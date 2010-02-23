{def $user=fetch('user', 'current_user')
	 $subscribed=fetch('newsletter', 'active_subscriptions_by_email', hash(email, $user.email) )
	 $subscriptions=fetch('newsletter', 'list_subscriptions')
	 $not_subscribed=array()
	 $is_subscribed=false()}
	 
{foreach $subscriptions as $list}
	{set $is_subscribed=false()}
	{if $list.description|downcase|contains('[test]')|not}
		{foreach $subscribed as $sub}
			{if $sub.subscriptionlist_id|eq($list.id)}
				{set $is_subscribed=true()}
				{continue}
			{/if}
		{/foreach}
		{if $is_subscribed|not}
			{set $not_subscribed=$not_subscribed|append($list)}
		{/if}
	{/if}
{/foreach}

{if $not_subscribed|count}
	{if $not_subscribed|count|gt(1)}
		<h1>Why not sign up to receive these newsletters by email?</h1>
	{else}
		<h1>Why not sign up to receive {$not_subscribed.0.name|wash} newsletter by email?</h1>
	{/if}
	{def $default_format=2}
	{if ezini_hasvariable('NewsletterSettings', 'DefaultOutputFormat', 'sbase.ini')}
        {set $default_format=ezini('NewsletterSettings', 'DefaultOutputFormat', 'sbase.ini') }
    {/if}
	{foreach $not_subscribed as $subscriptionList}
		{if $not_subscribed|count|gt(1)}<h2>{$subscriptionList.name|wash}</h2>{/if}
		{if $subscriptionList.description|trim|ne('')}
            <p class="subscription-description">{$subscriptionList.description|wash}</p>
        {/if}
		<form name="subscription_list" method="post" action={concat( '/newsletter/register_subscription/', $subscriptionList.url_alias )|ezurl}>
			<input type="hidden" name="Firstname" value="{$user.contentobject.data_map.first_name.content|wash}" />
			<input type="hidden" name="Name" value="{$user.contentobject.data_map.last_name.content|wash}" />
			<input type="hidden" name="Mobile" value="{cond(is_set($user.contentobject.data_map.mobile),$user.contentobject.data_map.mobile.content, '')|wash}" />
			<input type="hidden" name="Email" value="{$user.email|wash}" />
			<input type="hidden" name="OutputFormat" value="{$default_format}" />
			<input type="hidden" name="JustRegistered" value="1" />
			<div class="block">
		        <input class="button" type="submit" name="StoreButton" value="{'Subscribe'|i18n( 'design/eznewsletter/register_subscription' )}" title="{'Add to subscription.'|i18n( 'design/eznewsletter/register_subscription' )}" />
		    </div>
		</form>
	{/foreach}
	
{/if}
