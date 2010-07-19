{ezscript('head/head.js', 'text/javascript', '')}
<!--[if IE 6]>
	{ezscript( array('pngfix/pngfix.js'), 'text/javascript', '' )}
	<script type="text/javascript">
	{literal}
		DD_belatedPNG.fix('.pngfix');
		
		var $buoop = {} 
			$buoop.ol = window.onload; 
		window.onload=function(){ 
			 if ($buoop.ol)
			 	$buoop.ol(); 
			 var e = document.createElement("script"); 
			 e.setAttribute("type", "text/javascript"); 
			 e.setAttribute("src", "http://browser-update.org/update.js"); 
			 document.body.appendChild(e); 
		}
	{/literal}
	</script>
<![endif]-->

{if and($current_user.is_logged_in, fetch( 'user', 'has_access_to', hash( 'module', 'websitetoolbar', 'function', 'use' ) ) ) }
	{def $webin_scripts=ezini( 'WebinJavaScriptSettings', 'JavaScriptList', 'sbase.ini' )|unique}
	{ezscript( $webin_scripts, 'text/javascript', '' )}
	{set $loaded_scripts=$loaded_scripts|array_merge($webin_scripts) }
	{undef $webin_scripts}
{/if}
{def $design_scripts=ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' )|unique}
{ezscript( 'ezjsc::yui3', 'text/javascript', '' )}
{ezscript( $design_scripts, 'text/javascript', '' )}
{set $loaded_scripts=$loaded_scripts|array_merge($design_scripts) }
{undef $design_scripts}
{ezscript_load( array(), 'text/javascript', '' )}
{if $#head_scripts|count}
	{def $tmp_scripts=array()}
	{foreach $#head_scripts as $script}
		{if and( $loaded_scripts|contains($script)|not, or($script|contains('://'), ezscriptfiles($script)|count) ) }
			{set $tmp_scripts=$tmp_scripts|append($script)}
		{/if}
	{/foreach}
	{set $tmp_scripts=$tmp_scripts|unique}
	{ezscript($tmp_scripts, 'text/javascript', '')}
	{set $loaded_scripts=$loaded_scripts|array_merge($tmp_scripts) }
	{set $head_scripts = array()
		 scope=global}
	{undef $tmp_scripts}
{/if}
{if $#head_inline_scripts|count}
	{foreach $#head_inline_scripts as $script}
		{$script}
	{/foreach}
	{set $head_inline_scripts = array()
		 scope=global}
{/if}

{include uri='design:page_head_styleeditor.tpl'}