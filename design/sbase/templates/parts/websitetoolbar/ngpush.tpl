{if ezmodule('push')}
	{if $module_result.node_id }
		<a href={concat('/push/node/',$module_result.node_id)|ezurl} title="{'Push to social media'|i18n('extension/base')}" class="ezwt-push"><img src={"websitetoolbar/ezwt-icon-ngpush.gif"|ezimage} alt="{'Push'|i18n('extension/base')}" /></a>
	{/if}
{/if}