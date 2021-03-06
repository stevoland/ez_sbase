{let use_url_translation=ezini( 'URLTranslator', 'Translation' )|eq( 'enabled' )}

{section show=$search_result}
<table class="list" cellspacing="0">
<tr>
    <th>{'Name'|i18n( 'design/admin/content/search' )}</th>
    <th>{'Type'|i18n( 'design/admin/content/search' )}</th>
</tr>

{section var=Nodes loop=$search_result sequence=array( bglight, bgdark )}
<tr class="{$Nodes.sequence}">
<td>
{if is_set($#browse)}
	{* Note: The tpl code for $ignore_nodes_merge with the eq, unique and count
             is just a replacement for a missing template operator.
             If there are common elements the unique array will have less elements
             than the merged one
             In the future this should be replaced with a  new template operator that checks
             one array against another and returns true if elements in the first
             exists in the other *}
     {let ignore_nodes_merge=merge( $#browse.ignore_nodes_select_subtree, $Nodes.item.path_array )
          browse_permission = true()}
     {if $#browse.permission}
        {if $#browse.permission.contentclass_id}
            {if is_array( $#browse.permission.contentclass_id )}
                {foreach $#browse.permission.contentclass_id as $contentclass_id}
		            {set $browse_permission = fetch( 'content', 'access', hash( 'access', $#browse.permission.access,
		                                                               'contentobject',   $Nodes.item,
		                                                               'contentclass_id', $contentclass_id ) )}
		            {if $browse_permission|not}{break}{/if}
		        {/foreach}
            {else}
	            {set $browse_permission = fetch( 'content', 'access', hash( 'access', $#browse.permission.access,
	                                                               'contentobject',   $Nodes.item,
	                                                               'contentclass_id', $#browse.permission.contentclass_id ) )}
            {/if}
        {else}
            {set $browse_permission = fetch( 'content', 'access', hash( 'access', $#browse.permission.access,
                                                               'contentobject',   $Nodes.item ) )}
        {/if}
     {/if}
     {section show=and( $browse_permission,
                           $#browse.ignore_nodes_select|contains( $Nodes.item.node_id )|not,
                           eq( $ignore_nodes_merge|count,
                               $ignore_nodes_merge|unique|count ) )}
        {section show=is_array( $#browse.class_array )}
            {section show=$#browse.class_array|contains( $Nodes.item.object.content_class.identifier )}
                <input type="{$#select_type}" name="{$#select_name}[]" value="{$Nodes.item[$#select_attribute]}" />
            {section-else}
                <input type="{$#select_type}" name="" value="" disabled="disabled" />
            {/section}
        {section-else}
            {section show=and( or( eq( $#browse.action_name, 'MoveNode' ), eq( $#browse.action_name, 'CopyNode' ), eq( $#browse.action_name, 'AddNodeAssignment' ) ), $Nodes.item.object.content_class.is_container|not )}
                <input type="{$#select_type}" name="{$#select_name}[]" value="{$Nodes.item[$#select_attribute]}" disabled="disabled" />
            {section-else}
                <input type="{$#select_type}" name="{$#select_name}[]" value="{$Nodes.item[$#select_attribute]}" />
            {/section}
        {/section}
    {section-else}
        <input type="{$#select_type}" name="" value="" disabled="disabled" />
    {/section}
    {/let}
	{* Replaces node_view_gui... *}
    {* Note: The tpl code for $ignore_nodes_merge with the eq, unique and count
             is just a replacement for a missing template operator.
             If there are common elements the unique array will have less elements
             than the merged one
             In the future this should be replaced with a  new template operator that checks
             one array against another and returns true if elements in the first
             exists in the other *}
    {let ignore_nodes_merge=merge( $#browse.ignore_nodes_click, $Nodes.item.path_array )}
    {section show=eq( $ignore_nodes_merge|count,
                      $ignore_nodes_merge|unique|count )}
        {section show=and( or( ne( $#browse.action_name, 'MoveNode' ), ne( $#browse.action_name, 'CopyNode' ) ), $Nodes.item.object.content_class.is_container )}
            {$Nodes.item.object.class_identifier|class_icon( small, $Nodes.item.object.class_name )}&nbsp;<a href={concat( '/content/browse/', $Nodes.item.node_id )|ezurl}>{$Nodes.item.name|wash}</a>
        {section-else}
            {$Nodes.item.object.class_identifier|class_icon( small, $Nodes.item.object.class_name )}&nbsp;{$Nodes.item.name|wash}
        {/section}
    {section-else}
        {$Nodes.item.object.class_identifier|class_icon( small, $Nodes.item.object.class_name )}&nbsp;{$Nodes.item.name|wash}
    {/section}
    {/let}
{else}
	{node_view_gui view=admin_line content_node=$Nodes.item}
{/if}
</td>
<td>
{$Nodes.item.class_name|wash}
</td>
</tr>
{/section}


</table>
{/section}

{/let}
