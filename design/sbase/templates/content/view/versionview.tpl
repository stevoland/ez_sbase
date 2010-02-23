{set-block scope=global variable=cache_ttl}6{/set-block}
{ezpagedata_set('preview_node', $node)}

{node_view_gui view=full with_children=false() versionview_mode=true() is_editable=false() is_standalone=false() content_object=$object node_name=$object.name content_node=$node node=$node}