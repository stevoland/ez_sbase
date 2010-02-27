{if $pagedata.is_edit|not}
	{if ezini_hasvariable('AnalyticsSettings', 'URL', 'sbase.ini',,true())}
		{def $url=ezini('AnalyticsSettings', 'URL', 'sbase.ini',,true())}
		<div class="ezwt-right"><p><a href="{$url}" title="{'Google analytics'|i18n('extension/base')}" target="_blank"><img src={"websitetoolbar/ezwt-icon-analytics.gif"|ezimage} alt="{'Google analytics'|i18n('extension/base')}" /></a></p></div>
	{/if}
{/if}
