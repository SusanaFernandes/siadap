<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/fenix-renderers.tld" prefix="fr"%>


<%@page import="module.siadap.domain.SiadapYearConfiguration"%>
<%@page import="myorg.util.BundleUtil"%><bean:define id="processId" name="process" property="externalId"
	type="java.lang.String" />
<bean:define id="name" name="information" property="activityName" />

<bean:define id="siadap" name="information" property="process.siadap" />
<bean:define id="personName" name="information" property="process.siadap.evaluated.partyName"/>

<div class="dinline forminline">
<fr:form
	action='<%="/workflowProcessManagement.do?method=process&processId="
								+ processId + "&activity=" + name%>'>

	<fr:edit id="activityBean" name="information" visible="false" />

	<strong><bean:message key="label.objectives"
		bundle="SIADAP_RESOURCES" /></strong>:
		<table id="objectives" class="tstyle2">
		<tr>
			<td></td>
			<th><bean:message key="label.autoEvaluation" bundle="SIADAP_RESOURCES"/></th>
			<th><bean:message key="label.evaluation" bundle="SIADAP_RESOURCES"/></th>
		</tr>
		<logic:iterate id="evaluation" name="siadap"
			property="objectiveEvaluations">
			<tr>
				<td><fr:view name="evaluation" property="objective" /></td>
				<td><fr:view name="evaluation" property="autoEvaluation"
					type="module.siadap.domain.scoring.SiadapObjectivesEvaluation" /></td>
				<td><fr:edit name="evaluation" slot="evaluation" /></td>
			</tr>
		</logic:iterate>
	</table>

	<strong><bean:message key="label.competences"
		bundle="SIADAP_RESOURCES" /></strong>:
	    <table id="competences" class="tstyle2">
		<tr>
			<td></td>
			<th><bean:message key="label.autoEvaluation" bundle="SIADAP_RESOURCES"/></th>
			<th><bean:message key="label.evaluation" bundle="SIADAP_RESOURCES"/></th>
		</tr>
		<logic:iterate id="competence" name="siadap"
			property="competenceEvaluations">
			<tr>
				<td><fr:view name="competence" property="competence.name" /></td>
				<td><fr:view name="competence" property="autoEvaluation"
					type="module.siadap.domain.scoring.SiadapCompetencesEvaluation" /></td>
				<td><fr:edit name="competence" slot="evaluation" /></td>
			</tr>
		</logic:iterate>
	</table>

	<p>
		<bean:message key="label.propouseExcellencyAward" bundle="SIADAP_RESOURCES"/>: <fr:edit name="information" slot="excellencyAward" type="java.lang.String"/>
	</p>
	
	<div id="value" class="highlightBox">

	</div>
	
	<div>
	<strong><bean:message
		key="label.qualitativeEvaluation.justification"
		bundle="SIADAP_RESOURCES" /></strong>: <fr:edit name="information"
		slot="evaluationJustification" type="java.lang.String">
		<fr:layout name="longText">
			<fr:property name="rows" value="3" />
			<fr:property name="columns" value="50" />
		</fr:layout>
	</fr:edit></div>

	<p>
	<a href="#" id="toggleMoreInfo"><bean:message key="label.evaluation.moreData" bundle="SIADAP_RESOURCES"/></a>
	
	<div id="moreInfo" style="display: inline">
	
	<div><strong><bean:message
		key="label.personalDevelopment" bundle="SIADAP_RESOURCES" /></strong>
	<p><fr:edit name="information" slot="personalDevelopment"
		type="java.lang.String">
		<fr:layout name="longText">
			<fr:property name="rows" value="3" />
			<fr:property name="columns" value="50" />
		</fr:layout>
	</fr:edit></p>
	</div>

	<div><strong><bean:message key="label.trainningNeeds"
		bundle="SIADAP_RESOURCES" /></strong>
	<p><fr:edit name="information" slot="trainningNeeds"
		type="java.lang.String">
		<fr:layout name="longText">
			<fr:property name="rows" value="3" />
			<fr:property name="columns" value="50" />
		</fr:layout>
	</fr:edit></p>
	</div>
	
	</div>
	</p>
	
	<html:submit styleClass="inputbutton">
		<bean:message key="renderers.form.submit.name"
			bundle="RENDERER_RESOURCES" />
	</html:submit>
</fr:form> 
<fr:form
	action='<%="/workflowProcessManagement.do?method=viewProcess&processId="
								+ processId%>'>
	<html:submit styleClass="inputbutton">
		<bean:message key="renderers.form.cancel.name"
			bundle="RENDERER_RESOURCES" />
	</html:submit>
</fr:form>

</div>


<script type="text/javascript">
	var objectivesPonderation = <%= SiadapYearConfiguration.DEFAULT_OBJECTIVES_PONDERATION %> / 100;
	var competencesPonderation = <%= SiadapYearConfiguration.DEFAULT_COMPETENCES_PONDERATION %> / 100;

	var highLabel="<bean:message key="module.siadap.domain.scoring.SiadapGlobalEvaluation.HIGH" bundle="SIADAP_RESOURCES"/>";
	var mediumLabel="<bean:message key="module.siadap.domain.scoring.SiadapGlobalEvaluation.MEDIUM" bundle="SIADAP_RESOURCES"/>";
	var lowLabel="<bean:message key="module.siadap.domain.scoring.SiadapGlobalEvaluation.LOW" bundle="SIADAP_RESOURCES"/>";

	<%
		String message = BundleUtil.getStringFromResourceBundle("resources.SiadapResources","label.evaluationLine");
	%>
	var message = "<%= message.toString() %>";
			 
	$("select").change( function() {
		calculate();
	});

	$("#toggleMoreInfo").click(function() {
		$("#moreInfo").slideToggle();
	});
	
	function calculate() {
		var objectives = 0;
		var i = 0;
		var competences = 0;

		$("#objectives select").each( function(index, value) {
			objectives += getPoints(value.value);
			i++;
		});

		var objectives = Math.round(objectives / i * 1000) / 1000

		i = 0;
		$("#competences select").each( function(index, value) {
			competences += getPoints(value.value);
			i++;
		});

		var competences = Math.round(competences / i * 1000) / 1000

		objectives = objectives * objectivesPonderation;
		objectives = Math.round(objectives * 1000) / 1000
		competences = competences * competencesPonderation;
		competences = Math.round(competences * 1000) / 1000
		var total = objectives + competences;
		
		var text = formatString(message, [total, "<%= personName.toString() %>", getScoreLabel(total)]);

		$("#value").empty().append("<span class=\"bold\">" + text + "</span>");

		if (total < 2) {	
			$("#moreInfo").slideDown();
			$("#toggleMoreInfo").hide();
		}
		else {
			$("#moreInfo").slideUp();
			$("#toggleMoreInfo").show();
		}
		
		if (total < 4) {
				$("input[name$=excellencyAward]").removeAttr('checked');
				$("input[name$=excellencyAward]").attr('disabled','true');
		}
		else if (total >= 4) {
			$("input[name$=excellencyAward]").removeAttr('disabled');
		}
	}

	function getScoreLabel(value) {
		if (value >= 1 && value <2) {
			return lowLabel;
		}
		if (value >= 2 && value <4) {
			return mediumLabel;
		}
		if (value >= 4) {
			return highLabel;
		}
	}
	
	function getPoints(value) {
		if (value == "LOW") {
			return 1;
		}
		if (value == "MEDIUM") {
			return 3;
		}
		if (value == "HIGH") {
			return 5;
		} else {
			return 0;
		}
	}

	
	calculate();
</script>