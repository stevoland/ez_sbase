{if and( ezmodule( 'newsletter' ), $pagedata.is_edit|not ) }
	{if ezini_hasvariable( "NewsletterToolbar", "DefaultNewsletterTypeId" , "websitetoolbar.ini" ) }
		{def $defaultNewsletterTypeId=ezini( "NewsletterToolbar", "DefaultNewsletterTypeId", "websitetoolbar.ini" )
			 $defaultNewsletterClass=ezini( "NewsletterToolbar", "DefaultNewsletterClass", "websitetoolbar.ini" )
	 	}
		<div class="ezwt-right">
			<form name="CreateNewsletter" method="post" action={concat( 'newsletter/view_type/', $defaultNewsletterTypeId )|ezurl} ><p>
			<input type="image" src={"websitetoolbar/ezwt-icon-newsletter-new.gif"|ezimage} name="CreateNewsletter" title="{"Quick create default newsletter"|i18n( 'design/eznewsletter/view_newslettertype' )}" />
			<input type="hidden" name="ClassID" value="{$defaultNewsletterClass}" />
			<input type="hidden" name="RedirectURIAfterPublish" value={concat('/newsletter/view_type/', $defaultNewsletterTypeId )} />
		    <input type="hidden" name="RedirectIfDiscarded" value={concat('/newsletter/view_type/', $defaultNewsletterTypeId )} />
		</p></form>
		</div>
	{/if}
	<div class="ezwt-right">
	<p><a href={'/newsletter/list_type'|ezurl} title="{'Newsletter settings'|i18n('extension/base')}"><img src={"websitetoolbar/ezwt-icon-newsletter.gif"|ezimage} alt="{'Newsletter settings'|i18n('extension/base')}" /></a></p></div>
{/if}
