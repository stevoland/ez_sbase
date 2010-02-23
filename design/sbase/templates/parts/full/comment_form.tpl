{if and( is_set( $redirect_node.data_map.allow_comments ), $redirect_node.data_map.allow_comments.data_int )}
	{if fetch( 'content', 'access', hash( 'access', 'create',
										  'contentobject', $cur_node.object,
										  'contentclass_id', 'comment' ) )}
		<div id="form{$cur_node.node_id}">
			{if and( is_set($view_parameters.replied), $view_parameters.replied|eq($cur_node.node_id) )}
				<div class="comment-approval">
					<p>Thanks for your comment. It will appear here when it's been approved.</p>
				</div>
			{/if}
		<form method="post" action={"powercontent/action"|ezurl}{if or( is_unset($view_parameters.reply), $view_parameters.reply|ne($cur_node.node_id) )} style="display:none;"{/if} >
			<input type="hidden" name="NodeID" value="{$cur_node.main_node_id}" />
			<input type="hidden" name="DoPublish" value="1" />
			<input type="hidden" name="UseNodeAssigments" value="0" />
			<input type="hidden" name="ClassIdentifier" value="comment" />
			<textarea class="box" cols="70" rows="10" name="powercontent_message_ContentObjectAttribute_data_text_pcattributeid"></textarea>
			<input type="hidden" name="RedirectURIAfterPublish" value="{$redirect_node.url_alias}/(replied)/{$cur_node.node_id}#form{$cur_node.node_id}" />
			<input class="button comment" type="submit" name="CreateButton" value="{$button_text}" />
		</form>
		</div>
	{elseif is_set($show_logged_in)}
		<div class="comments-register">
		{def $register_link=concat('/user/register?redirect=', $used_node.url_alias)|ezurl(no)
			 $login_link=concat('/user/login?redirect=', $used_node.url_alias)|ezurl(no) }
		{if ezmodule( 'user/register' )}
			<p>{'You need to %login_link_startLog in%login_link_end or %create_link_startcreate a user account%create_link_end to comment.'|i18n( $i18n_context, , hash( '%login_link_start', concat( '<a href="', $login_link, '">' ), '%login_link_end', '</a>', '%create_link_start', concat( '<a href="', $register_link, '">' ), '%create_link_end', '</a>' ) )}</p>
		{else}
			<p>{'You need to %login_link_startLog in%login_link_end to comment.'|i18n( concat($i18n_context, '/comments'), , hash( '%login_link_start', concat( '<a href="', $login_link, '">' ), '%login_link_end', '</a>' ) )}</p>
		{/if}
		</div>
	{/if}
{elseif is_set($show_closed_message)}
	<div class="comments-closed"><p>Comments are currently closed</p></div>
{/if}