# EPOC edf converter

## Download dataset

[EDF dataset](https://www.dropbox.com/s/3goy1n7l9kqyc3r/edf.zip?dl=0)

## How to use

1. `edf_to_mat(folder, root_output_folder)`

    * `folder` - folder to convert
    * `root_output_folder` - output folder with converted data

    Create two folders (`root_output_folder` and `root_output_folder<_md>`) with converted data to Matlab files.

    ### Example

    ```matlab
        edf_to_mat('edf', 'mat');
    ```

    Create two folders `mat` and `mat_md` with converted data.

2. `convert_epoc_mat(folder, root_output_folder, convert_mode)`

    * `folder` - folder to convert
    * `root_output_folder` - output folder with converted data
    * `convert_mode` - convertation mode (`fft`, `max`, `raw`)

    Create folder with converted data to TXT files.

    ### Example

    ```matlab
        convert_epoc_mat('mat', 'fft_txt', 'fft');
    ```

    Create folder `fft_txt` with converted data.

## EPOC Matlab file info

Rows from 3 to 16 - signals (`row number`. `electrode`)

3.  AF3
4.  F7
5.  F3
6.  FC5
7.  T7
8.  P7
9.  01
10. O2
11. P8
12. T8
13. FC6
14. F4
15. F8
16. AF4
