<div class="content-view-embed class-{$object.class_identifier}">

{def $locations= array($object.main_node)
	 $location_attribute = 'location'
	 $short_descriptive_attribute='description'
	 $w=400
	 $h=400 }
{if and( is_set($object_parameters.attr_width), $object_parameters.attr_width|trim|ne('') ) }
	{set $w=$object_parameters.attr_width}
{/if}
{if and( is_set($object_parameters.attr_height), $object_parameters.attr_height|trim|ne('') ) }
	{set $h=$object_parameters.attr_height}
{/if}

{include uri="design:parts/gmap.tpl" 
         locations=$locations
		 width=$w
		 height=$h
		 inner_style=cond(is_set($inner_style), $inner_style)}

</div>