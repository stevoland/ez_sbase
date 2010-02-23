{def $locations= array($object.main_node)
	 $location_attribute = 'location'
	 $short_descriptive_attribute='description'
	 $w=400
	 $h=400 }
{default $inline_style=''
		 $css_class=''}
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
		 inline_style=$inline_style
		 css_class=$css_class}