{default $i18n_context='design/ezwebin/full/article'
		 $used_node=$node
}

	{* if and( is_unset( $versionview_mode ), is_set( $used_node.data_map.enable_tipafriend ), $used_node.data_map.enable_tipafriend.data_int ) *}
{def $tipafriend_access=fetch( 'user', 'has_access_to', hash( 'module', 'content',
                                                              'function', 'tipafriend' ) )}
{if and( ezmodule( 'content/tipafriend' ), $tipafriend_access )}
<div class="attribute-tipafriend">
    <p><a href={concat( "/content/tipafriend/", $used_node.node_id )|ezurl} title="{'Email a link a friend or enemy'|i18n( $i18n_context )}">{'Send to a friend'|i18n( 'design/ezwebin/full/article' )}</a></p>
</div>
{/if}
    {*/if*}