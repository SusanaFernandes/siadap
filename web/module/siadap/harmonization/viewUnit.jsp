<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/fenix-renderers.tld" prefix="fr"%>

<bean:define id="unitName" name="currentUnit" property="unit.partyName"/>
<bean:define id="unitId" name="currentUnit" property="unit.externalId"/>

<h2>
	<fr:view name="currentUnit" property="unit.partyName"/>
</h2>


<logic:messagesPresent property="message" message="true">
	<div class="error1">
		<html:messages id="errorMessage" property="message" message="true"> 
			<span><fr:view name="errorMessage"/></span>
		</html:messages>
	</div>
</logic:messagesPresent>

<bean:define id="unitId" name="currentUnit" property="unit.externalId"/>

<bean:define id="year" name="currentUnit" property="year"/>

<logic:present name="currentUnit" property="superiorUnit">
<bean:define id="superiorUnit" name="currentUnit" property="superiorUnit" type="module.organization.domain.Unit"/>

<strong>
	<bean:message key="label.superiorUnit" bundle="SIADAP_RESOURCES"/>:
</strong>
	<html:link page="<%="/siadapManagement.do?method=viewUnitHarmonizationData&year=" + year.toString()%>" paramId="unitId" paramName="superiorUnit" paramProperty="externalId">		
		<fr:view name="superiorUnit" property="partyName"/>
	</html:link>
</logic:present>

<div class="infobox">
	<fr:view name="currentUnit">
		<fr:schema type="module.siadap.domain.wrappers.UnitSiadapWrapper" bundle="SIADAP_RESOURCES">
			<fr:slot name="unit.partyName" key="label.unit" bundle="ORGANIZATION_RESOURCES"/>
			<fr:slot name="harmonizationUnit" key="label.harmonizationUnit" layout="null-as-label">
				<fr:property name="subLayout" value="values"/>
				<fr:property name="subSchema" value="module.organization.domain.Party.view.short.name"/>
			</fr:slot>
			<fr:slot name="evaluationResponsibles" key="label.unitEvaluationResponsibles" layout="flowLayout">
				<fr:property name="eachLayout" value="values"/>
				<fr:property name="eachSchema" value="organization.domain.Person.view.short"/>
				<fr:property name="htmlSeparator" value=", "/>
			</fr:slot>
			<fr:slot name="harmonizationResponsibles" key="label.unitHarmonizationResponsibles" layout="flowLayout">
				<fr:property name="eachLayout" value="values"/>
				<fr:property name="eachSchema" value="organization.domain.Person.view.short"/>
				<fr:property name="htmlSeparator" value=", "/>
			</fr:slot>
			<fr:slot name="totalPeopleWorkingInUnitDescriptionString" key="label.totalEvaluatedCurrentUnit"/>
			<fr:slot name="highGradeQuota" />
			<fr:slot name="currentUsedHighGradeQuota"/>
			<fr:slot name="relevantEvaluationPercentage"/>
			<fr:slot name="excellencyGradeQuota"/>
			<fr:slot name="currentUsedExcellencyGradeQuota"/>
			<fr:slot name="excellencyEvaluationPercentage"/>
		</fr:schema>
		<fr:layout name="tabular">
			<fr:property name="columnClasses" value="aright,,"/>
		</fr:layout>
	</fr:view>
</div>

<logic:equal name="currentUnit" property="responsibleForHarmonization" value="true">
	<logic:equal name="currentUnit" property="aboveQuotas" value="true">
	
		<bean:define id="currentHighQuota" name="currentUnit" property="currentUsedHighGradeQuota"/>
		<bean:define id="highQuota" name="currentUnit" property="highGradeQuota"/>
		<bean:define id="currentExcellencyQuota" name="currentUnit" property="currentUsedExcellencyGradeQuota"/>
		<bean:define id="excellencyGrade" name="currentUnit" property="excellencyGradeQuota"/>
		
		<div class="highlightBox">
			<bean:message key="warning.harmonizationUnitAboveQuotas" bundle="SIADAP_RESOURCES" arg0="<%= currentHighQuota.toString() %>" arg1="<%= highQuota.toString() %>" arg2="<%= currentExcellencyQuota.toString() %>" arg3="<%= excellencyGrade.toString() %>"/>
		</div>
	</logic:equal>
	
	<p>
	<html:link page="<%="/siadapManagement.do?method=listHighGlobalEvaluations&year=" + year.toString()%>" paramName="currentUnit" paramProperty="unit.externalId" paramId="unitId"> <bean:message key="label.viewGlobalEvaluations.relevant" bundle="SIADAP_RESOURCES"/> </html:link> | <html:link page="<%= "/siadapManagement.do?method=listExcellencyGlobalEvaluations&year=" + year.toString()%>" paramName="currentUnit" paramProperty="unit.externalId" paramId="unitId"> <bean:message key="label.viewGlobalEvaluations.excellency" bundle="SIADAP_RESOURCES"/> </html:link>
    <logic:equal name="currentUnit" property="harmonizationFinished" value="false">
    | <html:link styleId="terminateHarmonization"  page="/siadapManagement.do?method=terminateHarmonization" paramName="currentUnit" paramProperty="unit.externalId" paramId="unitId">
			<bean:message key="label.terminateHarmonization" bundle="SIADAP_RESOURCES"/>
		</html:link>
	| <html:link  page="<%="/siadapManagement.do?method=prepareAddExcedingQuotaSuggestion&year=" + year.toString()%>" paramName="currentUnit" paramProperty="unit.externalId" paramId="unitId">
			<bean:message key="label.addExcedingQuotaSuggestion" bundle="SIADAP_RESOURCES"/>
	  </html:link>
	</logic:equal>
	 <logic:equal name="currentUnit" property="harmonizationFinished" value="true">
    | <html:link styleId="reOpenHarmonization"  page="/siadapManagement.do?method=reOpenHarmonization" paramName="currentUnit" paramProperty="unit.externalId" paramId="unitId">
			<bean:message key="label.reOpenHarmonization" bundle="SIADAP_RESOURCES"/>
		</html:link>
	</logic:equal>
	</p>	
	
 <script src="<%= request.getContextPath() + "/javaScript/jquery.alerts.js"%>" type="text/javascript"></script> 
 <script src="<%= request.getContextPath() + "/javaScript/alertHandlers.js"%>" type="text/javascript"></script> 
 <script type="text/javascript"> 
   linkConfirmationHook('terminateHarmonization', '<bean:message key="label.terminateHarmonization.confirmationMessage" bundle="SIADAP_RESOURCES" arg0="<%= unitName.toString() %>"/>','<bean:message key="label.terminateHarmonization" bundle="SIADAP_RESOURCES"/>'); 
 </script> 
	
	
</logic:equal>

<logic:notEmpty name="people-withQuotas">
	<strong>
		<bean:message key="label.unitEmployees.withQuotas" bundle="SIADAP_RESOURCES"/>:
	</strong>
	
	<p>
		<fr:view name="people-withQuotas">
			<fr:schema type="module.siadap.domain.wrappers.PersonSiadapWrapper" bundle="SIADAP_RESOURCES">
				<fr:slot name="person.partyName" key="label.evaluated"/>
				<fr:slot name="person.user.username" key="label.login.username" bundle="MYORG_RESOURCES"/>
				<fr:slot name="evaluator.name" key="label.evaluator"/>
				<fr:slot name="evaluator.person.user.username" key="label.login.username" bundle="MYORG_RESOURCES"/>
				<fr:slot name="totalEvaluationScoring" layout="null-as-label" key="label.totalEvaluationScoring">
					<fr:property name="subLayout" value=""/>
				</fr:slot>
			</fr:schema>
			<fr:layout name="tabular-sortable">
				<fr:property name="classes" value="tstyle2"/>
				<fr:property name="columnClasses" value="aleft,aleft,,"/>
				<fr:property name="link(create)" value="/siadapManagement.do?method=createNewSiadapProcess"/>
				<fr:property name="bundle(create)" value="MYORG_RESOURCES"/>
				<fr:property name="key(create)" value="link.create"/>
				<fr:property name="param(create)" value="person.externalId/personId"/>
				<fr:property name="order(create)" value="1"/>
				<fr:property name="visibleIf(create)" value="currentUserAbleToCreateProcess"/>
				
				<fr:property name="link(viewProcess)" value="/workflowProcessManagement.do?method=viewProcess"/>
				<fr:property name="bundle(viewProcess)" value="MYORG_RESOURCES"/>
				<fr:property name="key(viewProcess)" value="link.view"/>
				<fr:property name="param(viewProcess)" value="siadap.process.externalId/processId"/>
				<fr:property name="order(viewProcess)" value="1"/>
				<fr:property name="visibleIf(viewProcess)" value="accessibleToCurrentUser"/>
				
				<fr:property name="sortParameter" value="sortByQuotas"/>
       			<fr:property name="sortUrl" value="<%= "/siadapManagement.do?method=viewUnitHarmonizationData&unitId=" + unitId + "&year=" + year.toString()%>"/>
			    <fr:property name="sortBy" value="<%= request.getParameter("sortByQuotas") == null ? "person.partyName=asc" : request.getParameter("sortByQuotas") %>"/>
				
			</fr:layout>
		</fr:view>
	</p>
</logic:notEmpty>

<logic:notEmpty name="people-withoutQuotas">
	<strong>
		<bean:message key="label.unitEmployees.withoutQuotas" bundle="SIADAP_RESOURCES"/>:
	</strong>
	
	<p>
		<fr:view name="people-withoutQuotas">
			<fr:schema type="module.siadap.domain.wrappers.PersonSiadapWrapper" bundle="SIADAP_RESOURCES">
				<fr:slot name="person.partyName" key="label.evaluated"/>
				<fr:slot name="person.user.username" key="label.login.username" bundle="MYORG_RESOURCES"/>
				<fr:slot name="evaluator.name" key="label.evaluator"/>
				<fr:slot name="evaluator.person.user.username" key="label.login.username" bundle="MYORG_RESOURCES"/>
				<fr:slot name="totalEvaluationScoring" layout="null-as-label" key="label.totalEvaluationScoring">
					<fr:property name="subLayout" value=""/>
				</fr:slot>
			</fr:schema>
			<fr:layout name="tabular-sortable">
				<fr:property name="classes" value="tstyle2"/>
				<fr:property name="columnClasses" value="aleft,aleft,,"/>
				<fr:property name="link(create)" value="/siadapManagement.do?method=createNewSiadapProcess"/>
				<fr:property name="bundle(create)" value="MYORG_RESOURCES"/>
				<fr:property name="key(create)" value="link.create"/>
				<fr:property name="param(create)" value="person.externalId/personId"/>
				<fr:property name="order(create)" value="1"/>
				<fr:property name="visibleIf(create)" value="currentUserAbleToCreateProcess"/>
				
				<fr:property name="link(viewProcess)" value="/workflowProcessManagement.do?method=viewProcess"/>
				<fr:property name="bundle(viewProcess)" value="MYORG_RESOURCES"/>
				<fr:property name="key(viewProcess)" value="link.view"/>
				<fr:property name="param(viewProcess)" value="siadap.process.externalId/processId"/>
				<fr:property name="order(viewProcess)" value="1"/>
				<fr:property name="visibleIf(viewProcess)" value="accessibleToCurrentUser"/>
				
				<fr:property name="sortParameter" value="sortByNoQuotas"/>
       			<fr:property name="sortUrl" value="<%= "/siadapManagement.do?method=viewUnitHarmonizationData&unitId=" + unitId + "&year=" + year.toString()%>"/>
			    <fr:property name="sortBy" value="<%= request.getParameter("sortByNoQuotas") == null ? "person.partyName=asc" : request.getParameter("sortByNoQuotas") %>"/>
			</fr:layout>
		</fr:view>
	</p>
</logic:notEmpty>

<bean:define id="highQuotaSuggestions" name="currentUnit" property="orderedExcedingQuotaProposalSuggestionsForHighEvaluation"/>

<logic:notEmpty name="highQuotaSuggestions">
	<strong> <bean:message key="label.listSuggestionForExcedingQuota.high" bundle="SIADAP_RESOURCES"/>: </strong>
	
	<fr:view name="highQuotaSuggestions">
		<fr:schema type="module.siadap.domain.ExcedingQuotaProposal" bundle="SIADAP_RESOURCES">
			<fr:slot name="proposalOrder"/>
			<fr:slot name="suggestion.presentationName" key="label.suggestion"/>
		</fr:schema>
		<fr:layout name="tabular">
			<fr:property name="classes" value="tstyle2"/>
			<fr:property name="link(delete)" value='<%= "/siadapManagement.do?method=removeExcedingQuotaSuggestion&unitId=" + unitId.toString() %>' />
			<fr:property name="bundle(delete)" value="MYORG_RESOURCES"/>
			<fr:property name="key(delete)" value="link.delete"/>
			<fr:property name="param(delete)" value="externalId/proposalId"/>
			<fr:property name="order(delete)" value="1"/>
		</fr:layout>
	</fr:view>
</logic:notEmpty>

<bean:define id="excellencyQuotaSuggestions" name="currentUnit" property="orderedExcedingQuotaProposalSuggestionsForExcellencyAward"/>

<logic:notEmpty name="excellencyQuotaSuggestions">

	<strong> <bean:message key="label.listSuggestionForExcedingQuota.excellency" bundle="SIADAP_RESOURCES"/>: </strong>
	
	<fr:view name="excellencyQuotaSuggestions">
		<fr:schema type="module.siadap.domain.ExcedingQuotaProposal" bundle="SIADAP_RESOURCES">
			<fr:slot name="proposalOrder"/>
			<fr:slot name="suggestion.presentationName" key="label.suggestion"/>
		</fr:schema>
		<fr:layout name="tabular">
			<fr:property name="classes" value="tstyle2"/>
			<fr:property name="link(delete)" value='<%= "/siadapManagement.do?method=removeExcedingQuotaSuggestion&unitId=" + unitId.toString() %>' />
			<fr:property name="bundle(delete)" value="MYORG_RESOURCES"/>
			<fr:property name="key(delete)" value="link.delete"/>
			<fr:property name="param(delete)" value="externalId/proposalId"/>
			<fr:property name="order(delete)" value="1"/>
		</fr:layout>
	</fr:view>

</logic:notEmpty>

<logic:notEmpty name="subUnits">
	<bean:define id="currentUnitId" name="currentUnit" property="unit.externalId"/>
	
	<strong>
		<bean:message key="label.subUnits" bundle="SIADAP_RESOURCES"/>:
	</strong>
	
	<p>
		<fr:view name="subUnits">
		<fr:schema type="module.siadap.domain.wrappers.UnitSiadapWrapper" bundle="SIADAP_RESOURCES">
				<fr:slot name="unit.partyName" key="label.unit" bundle="ORGANIZATION_RESOURCES" />
				<fr:slot name="unit.acronym" key="label.acronym" bundle="ORGANIZATION_RESOURCES"/>
				<fr:slot name="relevantEvaluationPercentage"/>
				<fr:slot name="excellencyEvaluationPercentage"/>
				<fr:slot name="totalPeopleWorkingInUnitIncludingNoQuotaPeople" key="label.totalEvaluated"/>
				<fr:slot name="totalPeopleWithSiadapWorkingInUnit"/>
			</fr:schema>
			<fr:layout name="tabular">
				<fr:property name="classes" value="tstyle2"/>
				<fr:property name="link(view)" value="<%="/siadapManagement.do?method=viewUnitHarmonizationData&year=" + year.toString() %>"/>
				<fr:property name="bundle(view)" value="MYORG_RESOURCES"/>
				<fr:property name="key(view)" value="link.view"/>
				<fr:property name="param(view)" value="unit.externalId/unitId"/>
				<fr:property name="order(view)" value="1"/>
			</fr:layout>
		</fr:view>
	</p>
</logic:notEmpty>

<jsp:include page="/module/siadap/tracFeedBackSnip.jsp">	
   <jsp:param name="href" value="https://fenix-ashes.ist.utl.pt/trac/siadap/report/19" />	
</jsp:include>