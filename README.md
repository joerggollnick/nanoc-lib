# nanoc-lib

## brrsync

This is a deployer. Every "compressable" file is brotli compressed and rsync'ed with respective output directory. 
It is configured mostly in same way as the rsync deployer.
Target webserver should support deliver brotli compressed content to the browser. In my case this a nginx.
Compression is done before deployment.

## autoindex

This is a helper to create an index page from all documents.

## nanoc-redirector and redirect-to-filter

This allows `redirect_from` and `redirect_to` in frontmatter.
This version respects `index_files` and `output_dir` config.

## thumbnailize

This creates thumbnails from an image

## jpegoptimize

This simple filter allows to resize and sert quality for compression.
