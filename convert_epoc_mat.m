function convert_epoc_mat(folder, root_output_folder, convert_mode)
    %  оличество измерений дл€ дальнейшей обработки.
    count_samples = 2^10;
    files = dir(folder);
    
    for i = 1 : length(files)
        path_to_file = [folder filesep files(i).name];

        if files(i).isdir
            if ~strcmp(files(i).name, '.') && ~strcmp(files(i).name, '..') 
                convert_epoc_mat(path_to_file, root_output_folder, convert_mode);
            end
        else
            load(path_to_file);
            disp(path_to_file);

            if length(val) < count_samples
               continue;
            end
            
            val = val(3 : 16, 1 : count_samples);
            if strcmp(convert_mode, 'fft')
                [val, bool_res] = fft_convert(val, 15);
            elseif strcmp(convert_mode, 'max')
                [val, bool_res] = fft_convert(val, 15);
            else
                [val, bool_res] = raw_convert(val);
            end
            
            if bool_res
                inner_folder = split(folder, filesep);
                inner_folder = strjoin(inner_folder(2 : end), '\\');
                output_folder = [root_output_folder filesep inner_folder];
                if ~exist(output_folder, 'dir')
                    mkdir(output_folder);
                end
                
                output_file_name = strrep(files(i).name, '.mat', '');
                dlmwrite([output_folder filesep output_file_name '.txt'], val, 'delimiter', '\t', 'precision','%.8f');
            end
        end
    end
end

% row_len - количесвто измерений, выбираемых после ‘урье преобразовани€
function [Ans, bool_res] = fft_convert(val, row_len)
    Ans = [];
    bool_res = true;
    n = length(val);
    for j = 1 : size(val, 1)
        format long g;
        fftMat = fft(val(j, 1 : n));
        arr = [];
        for i = 1 : n
            if angle(fftMat(i)) > 0.261799 && angle(fftMat(i)) < 1.5708
                arr(end + 1) = fftMat(i);
            end
        end
        
        arr = arr(1, :);
        arr = sort(arr, 'descend');
        if length(arr) < row_len
            bool_res = false;
            continue;
        end

        arr = arr(1 : row_len);
        for i = 1 : row_len
           arr(i) = abs(arr(i)) * cos(angle(arr(i)));
        end
        Ans(end + 1, :) = arr;
    end
end

% ѕервых row_len максимальных измерений
function [Ans, bool_res] = max_convert(val, row_len)
    bool_res = true;
    Ans = [];

    for j = 1 : length(val)
        a = sort(val(j, :), 'descend');
        Ans(end + 1, :) = a(1 : row_len);
    end
end

function [Ans, bool_res] = raw_convert(val)
    bool_res = true;
    Ans = val;
end
