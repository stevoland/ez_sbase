{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{section show=$attribute.content}
<a href="{if is_set($#host_path)}{$#host_path}{/if}{concat( 'content/download/', $attribute.contentobject_id, '/', $attribute.id,'/version/', $attribute.version , '/file/', $attribute.content.original_filename|urlencode )|ezurl(no)}">{$attribute.content.original_filename|wash( xhtml )}</a>&nbsp;({$attribute.content.filesize|si( byte )})
{/section}