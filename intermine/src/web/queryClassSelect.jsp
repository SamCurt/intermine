<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<!-- queryClassSelect -->
<html:form action="/queryClassSelect">
  <fmt:message key="query.addclass"/>
  <br/>
  <html:select property="className" size="10">
    <html:options name="classNames" labelName="unqualifiedClassNames"/>
  </html:select>
  <br/>
  <html:submit property="action">
    <fmt:message key="button.addclass"/>
  </html:submit>
  <html:submit property="action">
    <fmt:message key="button.browse"/>
  </html:submit>
</html:form>
<!-- /queryClassSelect -->
