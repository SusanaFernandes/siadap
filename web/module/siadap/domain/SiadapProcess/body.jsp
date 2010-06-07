<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/fenix-renderers.tld" prefix="fr"%>


<logic:equal name="process" property="siadap.evaluatedWithKnowledgeOfObjectives" value="false">
	<div class="highlightBox mtop05 mbottom15">
		<bean:message key="label.info.objectivesNotKownToEvaluated" bundle="SIADAP_RESOURCES"/>
	</div>
</logic:equal>

<logic:equal name="process" property="siadap.autoEvaluationIntervalFinished" value="true">
	<logic:equal name="process" property="siadap.autoEvaliationDone" value="false">
		<div class="highlightBox mtop05 mbottom15">
			<bean:message key="label.info.evaluatedFailedToDoAutoEvaluation" bundle="SIADAP_RESOURCES"/>
		</div>
	</logic:equal>
</logic:equal>

<strong><bean:message key="label.results"
	bundle="SIADAP_RESOURCES" />:</strong>

<logic:iterate id="objective" name="process"
	property="siadap.objectiveEvaluations" indexId="i">
	<bean:define id="index" value="<%=String.valueOf(i + 1)%>"
		toScope="request" />
	<bean:define id="objectiveEvaluation" name="objective"
		toScope="request" />
	<p><jsp:include page="snips/objectiveSnip.jsp" flush="true" /></p>
</logic:iterate>

<strong><bean:message key="label.competences"
	bundle="SIADAP_RESOURCES" />:</strong>
<p>
	<fr:view name="process" property="siadap.competenceEvaluations">
		<fr:schema bundle="SIADAP_RESOURCES"
			type="module.siadap.domain.CompetenceEvaluation">
			<fr:slot name="competence.number" />
			<fr:slot name="competence.name" />
			<fr:slot name="autoEvaluation" />
			<fr:slot name="evaluation" />
		</fr:schema>
		<fr:layout name="tabular">
			<fr:property name="classes" value="tstyle2 width100pc" />
			<fr:property name="sortBy" value="competence.number"/>
		</fr:layout>
	</fr:view>
</p>

<logic:equal name="process" property="siadap.withSkippedEvaluation" value="false">
	<strong><bean:message key="label.overalEvaluation" bundle="SIADAP_RESOURCES"/>:</strong>
	<p>
		<bean:define id="siadap" name="process" property="siadap" toScope="request"/>
		<jsp:include page="snips/globalEvaluationSnip.jsp" flush="true"/>
	</p>
</logic:equal>

<logic:equal name="process" property="siadap.evaluationDone" value="true">

<logic:equal name="process" property="siadap.withSkippedEvaluation" value="false">

	
	<p>
		<strong>
			<bean:message key="label.evaluationJustification" bundle="SIADAP_RESOURCES"/>:
		</strong>
		<bean:define id="justification" name="process" property="siadap.evaluationData.evaluationJustification"/>
		<p>
			<logic:notEmpty name="justification">
				<fr:view name="process" property="siadap.evaluationData.evaluationJustification"/>
			</logic:notEmpty>
			<logic:empty name="justification">
				<em><bean:message key="label.noJustification" bundle="SIADAP_RESOURCES"/></em>
			</logic:empty>
		</p>
	</p>

	<logic:notEmpty name="process" property="siadap.evaluationData.personalDevelopment">
		<p>
			<strong>
				<bean:message key="label.personalDevelopment" bundle="SIADAP_RESOURCES"/>:
			</strong>
			<p>
			<fr:view name="process" property="siadap.evaluationData.personalDevelopment"/>
			</p>
		</p>
	</logic:notEmpty>
	
	
	<logic:notEmpty name="process" property="siadap.evaluationData.trainningNeeds">
		<strong>
			<bean:message key="label.trainningNeeds" bundle="SIADAP_RESOURCES"/>:
		</strong>
		<p>
			<fr:view name="process" property="siadap.evaluationData.trainningNeeds"/>
		</p>
	</logic:notEmpty>
	
</logic:equal>
</logic:equal>

<logic:equal name="process" property="siadap.withSkippedEvaluation" value="true">
	<p>
		<strong><bean:message key="label.noEvaluationJustification" bundle="SIADAP_RESOURCES"/>:</strong>
		<p>
			<fr:view name="process" property="siadap.evaluationData.noEvaluationJustification"/>
		</p>
	</p>
</logic:equal>