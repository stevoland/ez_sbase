{if $#head_styles|count}
	{ezcss($#head_styles|unique)}
{/if}
{if $#head_inline_styles|count}
	<style type="text/css">
	{foreach $#head_inline_styles as $style}
		{$style}
	{/foreach}
	</style>
{/if}

{if $#head_scripts|count}
	{def $tmp_scripts=array()
		 $ext_scripts=array()}
	{foreach $#head_scripts as $script}
		{if $script|contains('://') }
			{set $ext_scripts=$ext_scripts|append($script)|unique}
		{elseif and( $loaded_scripts|contains($script)|not, ezscriptfiles($script)|count ) }
			{set $tmp_scripts=$tmp_scripts|append($script)}
		{/if}
	{/foreach}
	{foreach $ext_scripts as $script}
		<script type="text/javascript" src="{$script}"></script>
	{/foreach}
	{ezscript($tmp_scripts|unique, 'text/javascript', '')}
	{undef $tmp_scripts
		   $ext_scripts}
{/if}

{if $#head_inline_scripts|count}
	{foreach $#head_inline_scripts as $script}
		{$script}
	{/foreach}
{/if}

{if $#foot_scripts|count}
	{def $tmp_scripts=array()
		 $ext_scripts=array()}
	{foreach $#foot_scripts as $script}
		{if $script|contains('://') }
			{set $ext_scripts=$ext_scripts|append($script)|unique}
		{elseif and( $loaded_scripts|contains($script)|not, ezscriptfiles($script)|count ) }
			{set $tmp_scripts=$tmp_scripts|append($script)}
		{/if}
	{/foreach}
	{foreach $ext_scripts as $script}
		<script type="text/javascript" src="{$script}"></script>
	{/foreach}
	{ezscript($tmp_scripts|unique, 'text/javascript', '')}
	{undef $tmp_scripts
		   $ext_scripts}
{/if}

{if $#foot_inline_scripts|count}
	{foreach $#foot_inline_scripts as $script}
		{$script}
	{/foreach}
{/if}