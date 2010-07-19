{* Folder - Full view *}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="content-view-full">
    <div class="{include uri='design:parts/full/cssclasses.tpl'}">

		{include uri='design:parts/full/title.tpl' node_title=$node.name|wash}
        
        {if is_set($node.object.data_map.short_description) }
            {if eq( ezini( 'folder', 'SummaryInFullView', 'content.ini' ), 'enabled' )}
                {if $node.object.data_map.short_description.has_content}
                    <div class="attribute-short">
                        {attribute_view_gui attribute=$node.data_map.short_description}
                    </div>
                {/if}
            {/if}
        {/if}

        {if $node.object.data_map.description.has_content}
            <div class="attribute-long">
                {attribute_view_gui attribute=$node.data_map.description}
            </div>
        {/if}
        
        {def $i18n_content='design/ezwebin/full/folder'
        	 $exclude_classes= ezini( 'MenuContentSettings', 'ExtraIdentifierList', 'menu.ini' )
    	}
        {if le( $node.depth, '3')}
            {set $exclude_classes = $exclude_classes|append('folder')}
        {/if}
        
        {include uri='design:parts/full/show_children.tpl'}
		{include uri='design:parts/full/show_comments.tpl'}
		{include uri='design:parts/full/show_tipafriend.tpl'}
        
    </div>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>