{* Image in gallery - Full view *}

{if and( is_unset($no_wrapper), is_unset($view_parameters.nowrapper) ) }
	{include uri='design:parts/full/gallery_include.tpl'
			 item_node=$node}
{else}
	{if is_unset($fullscreen)}
		{def $fullscreen=cond( is_set($view_parameters.fullscreen), $view_parameters.fullscreen, false() ) }
	{/if}
	{def $href=cond( $fullscreen, $node.data_map.image.content.original.url|ezroot(no), concat($node.url_alias,'/(fullscreen)/1')|ezurl(no) )}
	<div class="content-view-full">
	    <div class="{include uri='design:parts/full/cssclasses.tpl'}"{if $fullscreen} style="width:{$node.data_map.image.content.galleryimage_full.width}px;"{/if}>
	
	        <div class="attribute-image">
	            <p><a href="{$href}" title="View full size"{if $fullscreen} target="_blank"{/if}>
	            	{attribute_view_gui attribute=$node.data_map.image 
	            						image_class=cond( $fullscreen, 'galleryimage_full', 'galleryimage_tab' )}
	            </a></p>
	        </div>
        
	        <div class="attribute-name">
	            <h1><a href="{$href}" title="View full size"{if $fullscreen} target="_blank"{/if}>{$node.name|wash()}</a></h1>
	        </div>
	        <div class="attribute-caption">
	            {attribute_view_gui attribute=$node.data_map.caption}
	        </div>
	    </div>
	</div>
{/if}

