# JPGExtractor_BashScript

All pngs from the source directory are copied to the destination directory and converted to jpgs, while maintaining directory structure.

Example:

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

### Parameters
Parameter 1:

- source directory.

Parameter 2:

- destination directory.

### Usage:

Set permissions:

```
>chmod a+x ./JPGExtractor.sh
```

Run:

```
>./JPGExtractor.sh test_input test_output
```
