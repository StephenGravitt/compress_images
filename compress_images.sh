#! /bin/bash
echo "Where are the images to work on?"
read imagePath
echo "Batch Resize Images? Answer 'true' to continue"
read ResizeYes
if [ "$ResizeYes" = true ] ; then

	echo "Max Image Width?"
	read imageWidth
	#echo "Max Image Height?"
	#read imageHeight
fi

echo "Compress JPEG Images? Answer 'true' to confirm"
read CompressJPG

echo "Convert JPEG images to WebP? Answer 'true' to confirm"
read ConvertJPG

echo "Compress PNG Images? Answer 'true' to continue --WARNING-- it takes forever"
read CompressPNG

echo "Convert PNG images to WebP?  Answer 'true' to confirm"
read ConvertPNG



if [ "$ResizeYes" = true ] ; then
	echo '------Resizing...------'
	
	#resize png or jpg to either height or width, keeps proportions using imagemagick
	find $imagePath -iname '*.jpg' -exec convert \{} -verbose -resize $imageWidth\> \{} \;
	find $imagePath -iname '*.jpeg' -exec convert \{} -verbose -resize $imageWidth\> \{} \;
	find $imagePath -iname '*.png' -exec convert \{} -verbose -resize $imageWidth\> \{} \;
	
	echo '------Resize Complete------'
fi

if [ "$ConvertJPG" = true ] ; then
    echo "------Converting jpg images to webp------"
	
	find $imagePath -type f -name '*.jpg' | xargs -P 8 -I {} sh -c 'cwebp -q 75 $1 -o "${1%.jpg}.webp"' _ {} \;
	find $imagePath -type f -name '*.jpeg' | xargs -P 8 -I {} sh -c 'cwebp -q 75 $1 -o "${1%.jpeg}.webp"' _ {} \;
	echo '------jpg to webp conversion complete------'
	
fi

if [ "$CompressJPG" = true ] ; then
    echo "------Compressing jpg images------"
	
	find $imagePath -iname "*.jpg" | xargs -n1 -P8 -I{} convert -sampling-factor 4:2:0 -verbose -strip -quality 75 -interlace JPEG -colorspace sRGB "{}" "{}"
	find $imagePath -iname "*.jpeg" | xargs -n1 -P8 -I{} convert -sampling-factor 4:2:0 -verbose -strip -quality 75 -interlace JPEG -colorspace sRGB "{}" "{}"
	
    echo '------jpg compression complete------'
	
fi

if [ "$ConvertPNG" = true ] ; then
    echo "------Converting png images to webp------"
	
	find $imagePath -type f -name '*.png' | xargs -P 8 -I {} sh -c 'cwebp -q 75 $1 -o "${1%.png}.webp"' _ {} \;	
		
	echo '------png to webp conversion complete------'
	
fi

if [ "$CompressPNG" = true ] ; then
	echo "------Compressing png images------"
	find $imagePath -iname "*.png" -exec pngquant --force --quality=60-85 --skip-if-larger  --verbose \{} --output \{} \;
	echo '------png compression complete------'
	
fi
