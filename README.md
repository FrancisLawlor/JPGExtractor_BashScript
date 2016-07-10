# JPGExtractor_BashScript

The script takes two arguments from the user, a source directory and a destination directory.
Any pngs from the source directory will be copied to the destination directory and converted to jpgs.
The directory structure will be maintained for situations where subdirectories contain pngs. e.g.

```
input_folder
  \img1.png
  \img2.png
  other_folder
    \text_file.txt
    \img3.jpg
    \img4.png
```

yields

```
output_folder
  \img1.jpg
  \img2.jpg
  other_folder
    \img4.jpg
```

Usage:

Set permissions:

```
>chmod a+x ./JPGExtractor.sh
```

Run script:

```
>./JPGExtractor.sh test_input test_output
```

