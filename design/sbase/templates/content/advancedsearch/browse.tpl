{if and( ezhttp_hasvariable('BrowseParameters', 'session'), or( $full_search_text|ne(''), $phrase_search_text|ne('') ) ) }
	{def $browse=ezhttp('BrowseParameters', 'session')
		 $search_url='content/advancedsearch/browse'
	     $select_name='SelectedObjectIDArray'
	     $select_type='checkbox'
	     $select_attribute='contentobject_id'}
	{if eq( $browse.return_type, 'NodeID' )}
	    {set $select_name='SelectedNodeIDArray'}
	    {set $select_attribute='node_id'}
	{/if}
	{if eq( $browse.selection, 'single' )}
	    {set $select_type='radio'}
	{/if}
	{ezpagedata_set('ui_context', 'browse')}
	{ezpagedata_set('record_access', false)}
{else}
	{def $search_url='content/advancedsearch/admin'}
{/if}
{include uri='design:content/advancedsearch/admin_search.tpl'}