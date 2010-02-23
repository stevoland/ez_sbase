{def $parent=$node.parent}
{while $parent.class_identifier|eq('comment')}
	{set $parent=$parent.parent}
{/while}

{redirect( concat($parent.url_alias, '#', $node.name|wash), 301 )}