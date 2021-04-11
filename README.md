# compress_images

compress_images.sh is a culmination of research and work with the aim of better website/app performance by means of optimized images

## Please take a backup copy of your images before using this tool, images will be overwritten

This is a multi-step bash script with questions to help walk through the needs of a particular compression run

This script will:

- Optionally Resize based on a maximum width in pixels
- Optionally Optimize JPEG images to approx. 75% 
- Optionally create a WEBP copy of JPEG images
- Optionally Optimimize PNG images between 60-85% 
- Optionally creeate a WEBP copy of PNG Images

Dependencies and Credit Goes to:
- imagemagick (https://imagemagick.org/index.php)
- cwebp (https://developers.google.com/speed/webp/docs/cwebp) 
- pngquat (https://pngquant.org/)