function onset_spikes_slurm_joblist(config)

sc_version = '1.0.8';

fname = fullfile(config{1}.datasavedir,'onset_slurm_job_list.txt');
fid = fopen(fname,'w');

for ielec = 1:size(config,2)
    if isempty(config{ielec})
        fprintf(fid,'\n');
        continue
    end
    
    for ipart = 1:size(config{ielec}.directorylist,2) 
        
        %get patient's information
        subjdir     = config{ielec}.prefix(1:end-1);
        partdir     = ['p',num2str(ipart)]; % a voir pour retirer +l21
 %       filename    = [config{ielec}.prefix,'p',num2str(ipart),'-multifile-',config{ielec}.circus.channel{1},'.ncs']; 
        filename    = 'SpykingCircus.params';
        
        dirname     = sprintf('/network/lustre/iss02/charpier/analyses/vn_onset/data/%s/%s',subjdir,partdir);
%        dirname     = sprintf('/network/lustre/iss01/charpier/analyses/vn_onset/data/%s/%s',subjdir);
        
        %code to launch SC
        load_sc         = sprintf('module load spyking-circus/%s;', sc_version);
        open_dir        = sprintf('cd %s;', dirname);
        change_dead_1   = 'cp SpykingCircus_artefacts_samples_SeizuresRemoved.dead SpykingCircus_artefacts_samples.dead;';
       % launch_sc_1     = sprintf('spyking-circus %s -c 28;', filename);
        launch_sc_1     = sprintf('spyking-circus %s -m filtering,whitening,clustering -c 28;', filename);
        
        %code to launch extracting
        change_dead_2   = 'cp SpykingCircus_artefacts_samples_SeizuresNotRemoved.dead SpykingCircus_artefacts_samples.dead;';
        %launch_sc_2      = sprintf('spyking-circus %s -m whitening,extracting,fitting -c 28;', filename);
        launch_sc_2      = sprintf('spyking-circus %s -m fitting -c 28;', filename);
        
        %code to convert
        convert_results = sprintf('spyking-circus %s -m converting;', filename);
        
        %pull all together in one line of the text file
        fprintf(fid,[load_sc,open_dir,change_dead_1,launch_sc_1,change_dead_2,launch_sc_2,convert_results,'\n']);
        
    end
end

close('all')
