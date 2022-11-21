function EpirestSpike_slurm_joblist(config)

sc_version = '1.0.8';

fname = fullfile(config{1}.patients_root_dir,'EpirestSpike_job_list.txt');
fid = fopen(fname,'w');

for ielec = 1:size(config,2)
    if isempty(config{ielec})
        fprintf(fid,'\n');
        continue
    end
    
    for ipart = 1:size(config{ielec}.directorylist,2) 
        
        %save_dir   = config{1}.datasavedir;
        save_dir   = '/network/lustre/iss02/charpier/priam/EpiRest_Spike/data/patients';%../data/patients';
        patdir     = config{ielec}.patientid;
        seshdir    = config{ielec}.sessionid;

        %get patient's information
        filename    = 'SpykingCircus.params';
        
        %code to launch SC
        load_sc         = sprintf('module load spyking-circus/%s;', sc_version);
        open_dir       = append('cd ', save_dir, '/', patdir, '/' , seshdir, ';');
        change_dead_1   = 'cp SpykingCircus_artefacts_samples_period_SS.dead SpykingCircus_artefacts_samples.dead;';
        launch_sc_1     = sprintf('spyking-circus %s -m filtering,whitening,clustering,fitting -c 28;', filename);
        
        %code to convert
        convert_results = sprintf('spyking-circus %s -m converting -c 28;', filename);
        
        %pull all together in one line of the text file
        fprintf(fid,[load_sc,open_dir,change_dead_1,launch_sc_1,convert_results,'\n']);
    end
end

close('all')