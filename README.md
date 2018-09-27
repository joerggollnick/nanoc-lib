# nanoc-lib

## brrsync

This is a deployer. Every "compressable" file is brotli compressed and rsync'ed with respective output directory. 
It is configured mostly in same way as the rsync deployer.
Target webserver should support deliver brotli compressed content to the browser. In my case this a nginx.
Compression is done before deployment.

## autoindex

This is a helper to create an index page from all documents.

