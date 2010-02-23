<div class="box">
<div class="tl">
<div class="tr">
<div class="br">
<div class="bl">
<div class="box-content float-break">

<h2>{'Thank you for registering'|i18n( 'design/eznewsletter/register_subscription_info' )}</h2>

<p>{'Thank you for subscribing to %name.'|i18n( 'design/eznewsletter/register_subscription_info', '', hash( '%name', $subscriptionList.name ) )|wash}</p>

{def $user=fetch('user', 'current_user')}
{if and( $user.login|ne('anonymous'), ezini_hasvariable('NewsletterSettings', 'ModifySubscriptionsOnRegister', 'sbase.ini'), ezini('NewsletterSettings', 'ModifySubscriptionsOnRegister', 'sbase.ini')|eq('enabled') )}
    {include uri='design:sbase/eznewsletter/multiple_register.tpl'}
{/if}


</div></div></div>
</div></div></div>
