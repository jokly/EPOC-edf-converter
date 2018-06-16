function edf_to_mat(folder, root_output_folder)
    files = dir(folder);
    
    for i = 1 : length(files)
       if files(i).isdir
          if ~strcmp(files(i).name, '.') && ~strcmp(files(i).name, '..')
             edf_to_mat([folder filesep files(i).name], root_output_folder);
          end
       else
           disp([folder filesep files(i).name]);
           wfdb2mat([folder filesep files(i).name]);

           file_name = strrep(files(i).name, '.edf', '');
           file_name = strrep(file_name, '.', '_');
           file_path = [folder filesep file_name '_edfm.mat'];

           inner_folder = split(folder, filesep);
           inner_folder = strjoin(inner_folder(2 : end), '\\');
           if contains(file_name, '_md')
              output_folder = [root_output_folder '_md' filesep inner_folder];
           else
              output_folder = [root_output_folder filesep inner_folder]; 
           end
           if ~exist(output_folder, 'dir')
               mkdir(output_folder);
           end

           if exist(file_path, 'file') == 2
              movefile(file_path, [output_folder filesep file_name '.mat']); 
           else
              disp(['Cant convert: ' folder filesep files(i).name]); 
           end
       end
    end
end
