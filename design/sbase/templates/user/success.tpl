{if $verify_user_email|not}
	{if or( ezini_hasvariable('NewsletterSettings', 'ModifySubscriptionsOnRegister', 'sbase.ini')|not, ezini('NewsletterSettings', 'ModifySubscriptionsOnRegister', 'sbase.ini')|eq('enabled')|not )}
		{if or( ezini_hasvariable('UserSettings', 'RedirectOnRegister', 'sbase.ini')|not, ezini('NewsletterSettings', 'RedirectOnRegister', 'sbase.ini')|eq('enabled') )}
			{if ezhttp_hasvariable('RegisterRedirect', 'session')}
		    	{def $redirect=ezhttp('RegisterRedirect', 'session')}
		    	{if $redirect}
		    		{redirect($redirect|ezurl(no))}
		    	{/if}
		    {/if}
		{/if}
	{/if}
{/if}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="user-success">

{if $verify_user_email}
<div class="attribute-header">
    <h1 class="long">{"User registered"|i18n("design/ezwebin/user/success")}</h1>
</div>

<div class="feedback">
<p>
{'Your account was successfully created. An email will be sent to the specified address. Follow the instructions in that email to activate your account.'|i18n('design/ezwebin/user/success')}
</p>
</div>
{else}
<div class="attribute-header">
    <h1 class="long">{"User registered"|i18n("design/ezwebin/user/success")}</h1>
</div>

<div class="feedback">
    <h2>{"Your account was successfully created."|i18n("design/ezwebin/user/success")}</h2>
    
    {if ezhttp_hasvariable('RegisterRedirect', 'session')}
    	{def $redirect=ezhttp('RegisterRedirect', 'session')}
    	{if $redirect}
    		<p>Use <a href={$redirect|ezurl}>this link</a> to go back to the page you came from.</p>
    	{/if}
    {/if}
</div>

	{if and( ezini_hasvariable('NewsletterSettings', 'ModifySubscriptionsOnRegister', 'sbase.ini'), ezini('NewsletterSettings', 'ModifySubscriptionsOnRegister', 'sbase.ini')|eq('enabled') )}
		{include uri='design:sbase/eznewsletter/multiple_register.tpl'}
	{/if}
{/if}

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>