{def $search_mode='admin'}
{if or( $module_result.ui_context|eq('browse'), $module_result.uri|begins_with('/content/advancedsearch/browse') ) }
	{set $search_mode='browse'}
{/if}
<div class="ezwt-right" id="ezwt-search">
	<form name="AdminSearch" method="get" action={concat('content/advancedsearch/', $search_mode)|ezurl} ><p><input class="halfbox" type="text" size="20" name="SearchText" value="" style="float:left;" />
	<input type="image" src={"websitetoolbar/ezwt-icon-preview.gif"|ezimage} name="AdminSearch" title="{"Search"|i18n( 'design/admin/content/search' )}" style="float:left;" />
</p></form>
</div>
