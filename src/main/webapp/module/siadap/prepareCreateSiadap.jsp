<%@page import="org.jfree.data.time.Year"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"%>
<%@ taglib uri="http://fenix-ashes.ist.utl.pt/fenix-renderers" prefix="fr"%>

<!-- 
<h3>
	<bean:message key="title.createSiadap" arg0="<%=String.valueOf(request.getAttribute("year"))%>" bundle="SIADAP_RESOURCES"/>
</h3>
 -->
 
<fr:view name="peopleToEvaluate">
		<fr:schema type="module.siadap.domain.wrappers.PersonSiadapWrapper" bundle="SIADAP_RESOURCES">
			<fr:slot name="person.user.profile.fullName" key="label.evaluated"/>
			<fr:slot name="person.user.username" key="label.login.username" bundle="MYORG_RESOURCES"/>
			<fr:slot name="workingUnit.unit.partyName" key="label.unit" bundle="ORGANIZATION_RESOURCES"/>
			<fr:slot name="quotaAware" key="label.quotaAware"/>
			<fr:slot name="currentProcessState" key="label.state" bundle="SIADAP_RESOURCES" />
			<fr:slot name="hasUnreadComments" key="label.unreadComments" bundle="SIADAP_RESOURCES"/>
		</fr:schema>
		<fr:layout name="tabular-sortable">
			<fr:property name="classes" value="tstyle2"/>
			<fr:property name="columnClasses" value="aleft,aleft,,"/>
			<%-- 
			<fr:property name="link(create)" value="<%="/siadapManagement.do?method=createNewSiadapProcess&year=" + request.getParameter("year")%>"/>
			<fr:property name="bundle(create)" value="MYORG_RESOURCES"/>
			<fr:property name="key(create)" value="link.create"/>
			<fr:property name="param(create)" value="person.externalId/personId"/>
			<fr:property name="order(create)" value="1"/>
			<fr:property name="visibleIf(create)" value="currentUserAbleToCreateProcess"/>
			--%>
			<fr:property name="link(viewProcess)" value="<%="/workflowProcessManagement.do?method=viewProcess&year=" + request.getParameter("year")%>"/>
			<fr:property name="bundle(viewProcess)" value="MYORG_RESOURCES"/>
			<fr:property name="key(viewProcess)" value="link.view"/>
			<fr:property name="param(viewProcess)" value="siadap.externalId/processId"/>
			<fr:property name="order(viewProcess)" value="1"/>
			<fr:property name="visibleIf(viewProcess)" value="accessibleToCurrentUser"/>
			
			<fr:property name="sortParameter" value="sortBy"/>
       		<fr:property name="sortUrl" value="<%="/siadapManagement.do?method=prepareToCreateNewSiadapProcess&year=" + String.valueOf(request.getAttribute("year"))%>"/>
		    <fr:property name="sortBy" value="<%= request.getParameter("sortBy") == null ? "person.user.profile.fullName=asc" : request.getParameter("sortBy") %>"/>
		</fr:layout>
</fr:view>
<jsp:include page="processStateLegend.jsp"/>

<%--
<jsp:include page="/module/siadap/tracFeedBackSnip.jsp">	
   <jsp:param name="href" value="https://fenix-ashes.ist.utl.pt/trac/siadap/report/21" />	
</jsp:include>
 --%>
