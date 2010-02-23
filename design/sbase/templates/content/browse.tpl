{ezpagedata_set('record_access', false)}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-browse">

{def $item_type=ezpreference( 'admin_list_limit' )
     $number_of_items=min( $item_type, 3)|choose( 10, 10, 25, 50 )
     $browse_list_count=fetch( content, list_count, hash( parent_node_id, $node_id, depth, 1 ) )
     $node_array=fetch( content, list, hash( parent_node_id, $node_id, depth, 1, offset, $view_parameters.offset, limit, $number_of_items, sort_by, $main_node.sort_array ) )
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

<form name="browse" action={$browse.from_page|ezurl} method="post">

{if $browse.description_template}
    {include name=Description uri=$browse.description_template browse=$browse main_node=$main_node}
{else}
    <div class="attribute-header">
    <h1 class="long">{'Browse'|i18n( 'design/ezwebin/content/browse' )} - {$main_node.name|wash}</h1>
    </div>

    <p>{'To select objects, choose the appropriate radiobutton or checkbox(es), and click the "Select" button.'|i18n( 'design/ezwebin/content/browse' )}</p>
    <p>{'To select an object that is a child of one of the displayed objects, click the parent object name to display a list of its children.'|i18n( 'design/ezwebin/content/browse' )}</p>
{/if}

{def $current_node=fetch( content, node, hash( node_id, $browse.start_node ) )}
{if $browse.start_node|gt( 1 )}
    <h2 class="context-title">
    <a href={concat( '/content/browse/', $main_node.parent_node_id, '/' )|ezurl}><img src={'back-button-16x16.gif'|ezimage} alt="{'Back'|i18n( 'design/ezwebin/content/browse' )}" /></a>
	{section show=is_array( $browse.class_array )}
            {section show=$browse.class_array|contains( $current_node.object.content_class.identifier )}
                <input type="{$select_type}" name="{$select_name}[]" value="{$current_node[$select_attribute]}" />
            {section-else}
                <input type="{$select_type}" name="" value="" disabled="disabled" />
            {/section}
        {section-else}
            {section show=and( or( eq( $browse.action_name, 'MoveNode' ), eq( $browse.action_name, 'CopyNode' ), eq( $browse.action_name, 'AddNodeAssignment' ) ), $current_node.object.content_class.is_container|not )}
                <input type="{$select_type}" name="{$select_name}[]" value="{$current_node[$select_attribute]}" disabled="disabled" />
            {section-else}
                <input type="{$select_type}" name="{$select_name}[]" value="{$current_node[$select_attribute]}" />
            {/section}
        {/section}
    {$current_node.name|wash}&nbsp;[{$current_node.children_count}]</h2>
{else}
    <h2 class="context-title"><img src={'back-button-16x16.gif'|ezimage} alt="Back" />&nbsp;{'Top level'|i18n( 'design/ezwebin/content/browse' )}&nbsp;[{$current_node.children_count}]</h2>
{/if}

<div class="context-toolbar">
<div class="block">
<div class="left">
    <p>
    {switch match=$number_of_items}
    {case match=25}
        <a href={'/user/preferences/set/admin_list_limit/1'|ezurl}>10</a>
        <span class="current">25</span>
        <a href={'/user/preferences/set/admin_list_limit/3'|ezurl}>50</a>

        {/case}

        {case match=50}
        <a href={'/user/preferences/set/admin_list_limit/1'|ezurl}>10</a>
        <a href={'/user/preferences/set/admin_list_limit/2'|ezurl}>25</a>
        <span class="current">50</span>
        {/case}

        {case}
        <span class="current">10</span>
        <a href={'/user/preferences/set/admin_list_limit/2'|ezurl}>25</a>
        <a href={'/user/preferences/set/admin_list_limit/3'|ezurl}>50</a>
        {/case}

        {/switch}
    </p>
</div>
<div class="right">
    <p>
    {switch match=ezpreference( 'admin_children_browsemode' )}
    {case match='thumbnail'}
      <a href={'/user/preferences/set/admin_children_browsemode/list'|ezurl} title="{'Display sub items using a simple list.'|i18n( 'design/admin/content/browse' )}">{'List'|i18n( 'design/admin/content/browse' )}</a>
      <span class="current">{'Thumbnail'|i18n( 'design/admin/content/browse' )}</span>
    {/case}
    {case}
      <span class="current">{'List'|i18n( 'design/admin/content/browse' )}</span>
      <a href={'/user/preferences/set/admin_children_browsemode/thumbnail'|ezurl} title="{'Display sub items as thumbnails.'|i18n( 'design/admin/content/browse' )}">{'Thumbnail'|i18n( 'design/admin/content/browse' )}</a>
    {/case}
    {/switch}
    </p>
</div>
<div class="break"></div>
</div>
</div>

{* Display the actual list of nodes. *}
{switch match=ezpreference( 'admin_children_browsemode' )}
    {case match='thumbnail'}
        {include uri='design:content/browse_mode_thumbnail.tpl'}
    {/case}
    {case}
        {include uri='design:content/browse_mode_list.tpl'}
    {/case}
{/switch}

{include name=Navigator
         uri='design:navigator/google.tpl'
         page_uri=concat('/content/browse/',$main_node.node_id)
         item_count=$browse_list_count
         view_parameters=$view_parameters
         item_limit=$number_of_items}


{if $browse.persistent_data|count()}
{foreach $browse.persistent_data as $key => $data_item}
    <input type="hidden" name="{$key|wash}" value="{$data_item|wash}" />
{/foreach}
{/if}

<input type="hidden" name="BrowseActionName" value="{$browse.action_name}" />
{if $browse.browse_custom_action}
<input type="hidden" name="{$browse.browse_custom_action.name}" value="{$browse.browse_custom_action.value}" />
{/if}

        <input class="button" type="submit" name="SelectButton" value="{'Select'|i18n('design/ezwebin/content/browse')}" />


{if $cancel_action}
<input type="hidden" name="BrowseCancelURI" value="{$cancel_action}" />
{/if}
 <input class="button" type="submit" name="BrowseCancelButton" value="{'Cancel'|i18n( 'design/ezwebin/content/browse' )}" />
</form>

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>