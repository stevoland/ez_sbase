{default $i18n_context='design/ezwebin/full/article'
		 $used_node=$node
}
{if $used_node.object.content_class.is_container}
    {if and( is_unset( $versionview_mode ), is_set( $used_node.data_map.enable_comments ), $used_node.data_map.enable_comments.data_int )}
		{def $can_reply=false()}
		{if and( is_set( $used_node.data_map.allow_comments ), $used_node.data_map.allow_comments.data_int )}
			{if fetch( 'content', 'access', hash( 'access', 'create',
												  'contentobject', $used_node.object,
												  'contentclass_id', 'comment' ) )}
				{set $can_reply=true() }
			{/if}
		{/if}
        <h1 id="comments"><span>Comments on {$node.name|wash()}</span></h1>
        {def $intro=false() }
        {switch match=$used_node.class_identifier}
        	{case match='recipe'}
        		{set $intro='Post your comments, tips and related recipe tales here.'}
        	{/case}
        	{case}{/case}
        {/switch}
        {if $intro}
        	<div class="comments-intro"><p>{$intro}</p></div>
        {/if}
        {undef $intro}
		<div class="comments">
			{def $replies=false()
				 $i=0}
			{foreach fetch_alias( comments, hash( parent_node_id, $used_node.node_id ) ) as $comment}
				<div class="comment">
				{node_view_gui view='child'
							   content_node=$comment
							   show_reply_link=true()
							   index=$i}
				
				{if $can_reply}<a id="reply-{$comment.node_id}" class="reply-link" href={concat($used_node.url_alias,'/(reply)/',$comment.node_id,'#form',$comment.node_id)|ezurl()}>Reply</a>{/if}
				</div>
				{set $i=$i|sum(1)
					 $replies=fetch_alias( comments, hash( parent_node_id, $comment.node_id ) ) }
				<div class="comment comment-reply">
					{foreach $replies as $reply}
						{node_view_gui view='child'
									   content_node=$reply
							   		   index=$i}
						{set $i=$i|sum(1) }
					{/foreach}
					{include uri='design:parts/full/comment_form.tpl'
							 cur_node=$comment
							 redirect_node=$used_node
							 button_text='Post reply'}
				</div>
			{/foreach}
			{undef $i}
			{if $can_reply}<a id="reply-{$used_node.node_id}" class="reply-link reply-link-big" href={concat($used_node.url_alias,'/(reply)/',$used_node.node_id,'#form',$used_node.node_id)|ezurl()}>New comment</a>{/if}
			{include uri='design:parts/full/comment_form.tpl'
						 cur_node=$used_node
						 redirect_node=$used_node
						 show_closed_message=true()
						 show_logged_in=true()
						 button_text='Post comment'}		
		</div>
		{set $foot_scripts=$#foot_scripts|append('ezjsc::yui3', 'comments/comments.js')
			 scope=global}
    {/if}
{/if}
