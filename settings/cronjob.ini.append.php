<?php /*#?ini charset="iso-8859-1"?

[CronjobSettings]
ScriptDirectories[]=cronjobs
Scripts[]
Scripts[]=unpublish.php
#Scripts[]=rssimport.php
Scripts[]=hide.php
Scripts[]=subtreeexpirycleanup.php
Scripts[]=internal_drafts_cleanup.php
#Scripts[]=unlock.php
#Scripts[]=staticcache_cleanup.php
#Scripts[]=ldapusermanage.php
Scripts[]=updateviewcount.php
Scripts[]=indexcontent.php
#Extension directory for cronjobs.
#ExtensionDirectories[]

[CronjobPart-infrequent]
Scripts[]=basket_cleanup.php
#PRODUCTION
#Scripts[]=linkcheck.php

[CronjobPart-frequent]
Scripts[]=notification.php
Scripts[]=workflow.php
Scripts[]=archive.php

[CronjobPart-unlock]
Scripts[]=unlock.php

*/ ?>