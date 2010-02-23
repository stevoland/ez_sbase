{def $href=$attribute.content}{if and(is_set($#host_path), $href|begins_with('/'))}{set $href=concat($#host_path, $href)}{/if}
{section show=$attribute.data_text}
<a href="{$href}">{$attribute.data_text|wash( xhtml )}</a>
{section-else}
<a href="{$href}">{$attribute.content|wash( xhtml )}</a>
{/section}