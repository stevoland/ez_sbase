{default $i18n_context='design/ezwebin/full/article'
		 $used_node=$node
}

{if $used_node.object.content_class.is_container}
	{if and( is_set( $used_node.data_map.show_children ), $used_node.data_map.show_children.data_int )}
                {def $page_limit = first_set($used_node.data_map.show_children_pr_page.data_int, 10)
                     $classes = ezini( 'MenuContentSettings', 'ExtraIdentifierList', 'menu.ini' )
                     $children = array()
                     $children_count = ''}
            	{if is_set( $exclude_classes )}
                    {set $classes = $exclude_classes}
                {elseif is_set( $used_node.data_map.show_children_exclude )}
                    {set $classes = $used_node.data_map.show_children_exclude.content|explode(',')}
                {/if}

                {set $children=fetch_alias( 'children', hash( 'parent_node_id', $used_node.node_id,
                                                              'offset', $view_parameters.offset,
                                                              'sort_by', $used_node.sort_array,
                                                              'class_filter_type', 'exclude',
                                                              'class_filter_array', $classes|append('comment','folder_hidden'),
                                                              'limit', cond(is_set($page_limit), $page_limit ) ) )  }

                {set $children_count=fetch_alias( 'children_count', hash( 'parent_node_id', $used_node.node_id,
                                                              'offset', $view_parameters.offset,
                                                              'sort_by', $used_node.sort_array,
                                                              'class_filter_type', 'exclude',
                                                              'class_filter_array', $classes|append('comment','folder_hidden') ) ) }

                <div class="content-view-children">
                    {foreach $children as $child }
                        {node_view_gui view='line' content_node=$child}
                    {/foreach}
                </div>
				
				{if is_set($page_limit) }
	                {include name=navigator
	                         uri='design:navigator/google.tpl'
	                         page_uri=$used_node.url_alias
	                         item_count=$children_count
	                         view_parameters=$view_parameters
	                         item_limit=$page_limit}
	            {/if}

        {/if}
{/if}