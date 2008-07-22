<%
/**
 * Copyright (c) 2000-2008 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet" %>

<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util" %>

<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page import="com.liferay.knowledgebase.ArticleTitleException" %>
<%@ page import="com.liferay.knowledgebase.ArticleVersionException" %>
<%@ page import="com.liferay.knowledgebase.KnowledgeBaseKeys" %>
<%@ page import="com.liferay.knowledgebase.model.KBArticle" %>
<%@ page import="com.liferay.knowledgebase.model.KBArticleResource" %>
<%@ page import="com.liferay.knowledgebase.service.KBArticleLocalServiceUtil" %>
<%@ page import="com.liferay.knowledgebase.service.KBArticleResourceLocalServiceUtil" %>
<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.dao.search.SearchContainer" %>
<%@ page import="com.liferay.portal.kernel.dao.search.SearchEntry" %>
<%@ page import="com.liferay.portal.kernel.language.LanguageUtil" %>
<%@ page import="com.liferay.portal.kernel.portlet.LiferayWindowState" %>
<%@ page import="com.liferay.portal.kernel.search.Document" %>
<%@ page import="com.liferay.portal.kernel.search.Field" %>
<%@ page import="com.liferay.portal.kernel.search.Hits" %>
<%@ page import="com.liferay.portal.kernel.util.ArrayUtil" %>
<%@ page import="com.liferay.portal.kernel.util.Constants" %>
<%@ page import="com.liferay.portal.kernel.util.DateFormats" %>
<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<%@ page import="com.liferay.portal.kernel.util.HtmlUtil" %>
<%@ page import="com.liferay.portal.kernel.util.HttpUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.kernel.util.StringPool" %>
<%@ page import="com.liferay.portal.kernel.util.UnicodeFormatter" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>
<%@ page import="com.liferay.portal.kernel.log.Log" %>
<%@ page import="com.liferay.portal.kernel.log.LogFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.Validator" %>
<%@ page import="com.liferay.portal.security.permission.ActionKeys" %>
<%@ page import="com.liferay.portal.service.SubscriptionLocalServiceUtil" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.portal.util.PortletKeys" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.portlet.tags.EntryNameException" %>
<%@ page import="com.liferay.portlet.tags.NoSuchEntryException" %>
<%@ page import="com.liferay.portlet.tags.NoSuchPropertyException" %>
<%@ page import="com.liferay.portlet.tags.model.TagsAsset" %>
<%@ page import="com.liferay.portlet.tags.model.TagsEntry" %>
<%@ page import="com.liferay.portlet.tags.model.TagsProperty" %>
<%@ page import="com.liferay.portlet.tags.service.TagsAssetLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.tags.service.TagsEntryLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.tags.service.TagsPropertyLocalServiceUtil" %>
<%@ page import="com.liferay.util.BeanParamUtil" %>
<%@ page import="com.liferay.util.RSSUtil" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>

<%@ page import="java.text.DateFormat" %>

<%@ page import="javax.portlet.ActionRequest" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<%@ page import="javax.portlet.PortletURL" %>
<%@ page import="javax.portlet.WindowState" %>

<portlet:defineObjects />
<liferay-theme:defineObjects />

<%
PortletPreferences prefs = renderRequest.getPreferences();

String portletResource = ParamUtil.getString(request, "portletResource");

if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource);
}

String currentURL = PortalUtil.getCurrentURL(request);

int rssDelta = GetterUtil.getInteger(prefs.getValue("rss-delta", StringPool.BLANK), SearchContainer.DEFAULT_DELTA);
String rssDisplayStyle = prefs.getValue("rss-display-style", RSSUtil.DISPLAY_STYLE_FULL_CONTENT);

StringBuilder rssURLParams = new StringBuilder();

if ((rssDelta != SearchContainer.DEFAULT_DELTA) || !rssDisplayStyle.equals(RSSUtil.DISPLAY_STYLE_FULL_CONTENT)) {
	if (rssDelta != SearchContainer.DEFAULT_DELTA) {
		rssURLParams.append("&max=");
		rssURLParams.append(rssDelta);
	}

	if (!rssDisplayStyle.equals(RSSUtil.DISPLAY_STYLE_FULL_CONTENT)) {
		rssURLParams.append("&displayStyle=");
		rssURLParams.append(rssDisplayStyle);
	}
}

StringBuilder rssURLAtomParams = new StringBuilder(rssURLParams.toString());

rssURLAtomParams.append("&type=");
rssURLAtomParams.append(RSSUtil.ATOM);
rssURLAtomParams.append("&version=1.0");

StringBuilder rssURLRSS10Params = new StringBuilder(rssURLParams.toString());

rssURLRSS10Params.append("&type=");
rssURLRSS10Params.append(RSSUtil.RSS);
rssURLRSS10Params.append("&version=1.0");

StringBuilder rssURLRSS20Params = new StringBuilder(rssURLParams.toString());

rssURLRSS20Params.append("&type=");
rssURLRSS20Params.append(RSSUtil.RSS);
rssURLRSS20Params.append("&version=2.0");

DateFormat dateFormatDateTime = DateFormats.getDateTime(locale, timeZone);
%>