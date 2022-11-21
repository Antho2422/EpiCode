%% GLOBAL PARAMETERS
function [config] = EpirestSpike_setparams

if ismac
    error('Platform not supported')
elseif isunix
    rootpath_analysis   	= '/network/lustre/iss02/charpier/priam';
    rootpath_data       	= '/network/lustre/iss02/epimicro/patients/raw';
    restpath_data		= '/network/lustre/iss02/epimicro/patients/protocols/epiRest';
    output_patients     	= '/network/lustre/iss02/charpier/priam/EpiRest_Spike/data/patients';
    output_images      		= '/network/lustre/iss02/charpier/priam/EpiRest_Spike/data/images';
    os                  	= 'unix';
elseif ispc
    rootpath_analysis		= '\\l2export\iss02.charpier\priam';
    rootpath_data       	= '\\l2export\iss02.epimicro\patients\raw';
    restpath_data		= '\\l2export\iss02.epimicro\patients\protocols\epiRest';
    output_patients     	= '\\l2export\iss02.charpier\priam\EpiRest_Spike\data\patients';
    output_images       	= '\\l2export\iss02.charpier\priam\EpiRest_Spike\data\images';
    os                  	= 'windows';
else
    error('Platform not supported')
end

datasavedir  = output_patients;
imagesavedir = output_images;
script_path  = mfilename('fullpath');
script_path  = fileparts(script_path);


configcommon.name                                   = {'Epirest_Spike'};

configcommon.muse.write                             = true;


configcommon.circus.paramfile                       = fullfile(script_path,'EpirestSpike_SpykingCircus.params');
configcommon.circus.params.filtering.cut_off        = '300, auto';
configcommon.circus.params.filtering.remove_median  = 'False';
configcommon.circus.params.detection.peaks          = 'negative';
configcommon.circus.params.data.stream_mode         = 'mapping-file';
configcommon.circus.params.data.mapping_file        = 'filelist.txt';

configcommon.spikewaveform.lpfilter   		    = 'yes';
configcommon.spikewaveform.lpfreq     		    = 3000;


%========================================================

%% PATIENT PARAMETERS - pat_02680_1158
config{1}                     = configcommon;
config{1}.patientid	      = 'pat_02680_1158';
config{1}.patients_root_dir   = output_patients;
config{1}.triallist           = 1;


config{1}.rawdir              = fullfile(rootpath_data, config{1}.patientid,'eeg');
%% SESSION PARAMETERS - ses-01
config{1}.sessionid           = 'ses-01';
config{1}.prefix              = 'pat_2680_ses01'; 

config{1}.datasavedir         = fullfile(datasavedir, config{1}.patientid, config{1}.sessionid);
config{1}.imagesavedir        = fullfile(imagesavedir, config{1}.prefix);

config{1}.directorylist{1}    = {'02680_2019-01-16_09-52', '02680_2019-01-16_10-58'}; 

config{1}.circus.channel      			= {'mAmT2_3','mAmT2_5','mHaT2_1', 'mHaT2_3', 'mHaT2_5', 'mHaT2_6', 'mHaT2_7'};
config{1}.circus.outputdir    			= config{1}.datasavedir;
config{1}.circus.params.detection.spike_thresh  = '6';
config{1}.circus.params.clustering.nb_repeats   = '10';
config{1}.circus.params.clustering.max_elts     = '20000';

config{1}.bad.markerStart     = 'begin';
config{1}.bad.markerEnd       = 'SS_Start'; 

config{1}.bad.dir_list        = 'last';

config{1}.bad.sample_list     = 'last'; 

config{1}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02680_1158
config{2}                     = configcommon;
config{2}.patientid	      = 'pat_02680_1158';
config{2}.patients_root_dir   = output_patients;
config{2}.triallist           = 1;


config{2}.rawdir              = fullfile(rootpath_data, config{2}.patientid,'eeg');
%% SESSION PARAMETERS - ses-02
config{2}.sessionid           = 'ses-02';
config{2}.prefix              = 'pat_2680_ses02'; 

config{2}.datasavedir         = fullfile(datasavedir, config{2}.patientid, config{2}.sessionid);
config{2}.imagesavedir        = fullfile(imagesavedir, config{2}.prefix);

config{2}.directorylist{1}    = {'02680_2019-01-18_08-01','02680_2019-01-18_09-41'}; 

config{2}.circus.channel      			= {'mHaT2_2', 'mHaT2_3', 'mHaT2_5', 'mHaT2_7'};
config{2}.circus.outputdir    			= config{2}.datasavedir;
config{2}.circus.params.detection.spike_thresh  = '6';
config{2}.circus.params.clustering.nb_repeats   = '10';
config{2}.circus.params.clustering.max_elts     = '20000';

config{2}.bad.markerStart     = 'begin';
config{2}.bad.markerEnd       = 'SS_Start'; 

config{2}.bad.dir_list        = 'all';

config{2}.bad.sample_list     = 'all'; 

config{2}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02680_1158
config{3}                     = configcommon;
config{3}.patientid	      = 'pat_02680_1158';
config{3}.patients_root_dir   = output_patients;
config{3}.triallist           = 1;


config{3}.rawdir              = fullfile(rootpath_data, config{3}.patientid,'eeg');
%% SESSION PARAMETERS - ses-03
config{3}.sessionid           = 'ses-03';
config{3}.prefix              = 'pat_2680_ses03'; 

config{3}.datasavedir         = fullfile(datasavedir, config{3}.patientid, config{3}.sessionid);
config{3}.imagesavedir        = fullfile(imagesavedir, config{3}.prefix);

config{3}.directorylist{1}    = {'02680_2019-01-21_11-29'}; 

config{3}.circus.channel      			= {'mAmT2_3','mHaT2_5'};
config{3}.circus.outputdir    			= config{3}.datasavedir;
config{3}.circus.params.detection.spike_thresh  = '6';
config{3}.circus.params.clustering.nb_repeats   = '10';
config{3}.circus.params.clustering.max_elts     = '20000';

config{3}.bad.markerStart     = 'begin';
config{3}.bad.markerEnd       = 'SS_Start'; 

config{3}.bad.dir_list        = 'all';

config{3}.bad.sample_list     = 'all'; 

config{3}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02680_1158
config{4}                     = configcommon;
config{4}.patientid	      = 'pat_02680_1158';
config{4}.patients_root_dir   = output_patients;
config{4}.triallist           = 1;


config{4}.rawdir              = fullfile(rootpath_data, config{4}.patientid,'eeg');
%% SESSION PARAMETERS - ses-04
config{4}.sessionid           = 'ses-04';
config{4}.prefix              = 'pat_2680_ses04';

config{4}.datasavedir         = fullfile(datasavedir, config{4}.patientid, config{4}.sessionid);
config{4}.imagesavedir        = fullfile(imagesavedir, config{4}.prefix);

config{4}.directorylist{1}    = {'02680_2019-01-22_09-22'}; 

config{4}.circus.channel      			= {'mAmT2_3','mHaT2_5'};
config{4}.circus.outputdir    			= config{4}.datasavedir;
config{4}.circus.params.detection.spike_thresh  = '7';
config{4}.circus.params.clustering.nb_repeats   = '10';
config{4}.circus.params.clustering.max_elts     = '20000';

config{4}.bad.markerStart     = 'begin';
config{4}.bad.markerEnd       = 'SS_Start'; 

config{4}.bad.dir_list        = 'all';

config{4}.bad.sample_list     = 'all'; 

config{4}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02680_1158
config{5}                     = configcommon;
config{5}.patientid	      = 'pat_02680_1158';
config{5}.patients_root_dir   = output_patients;
config{5}.triallist           = 1;


config{5}.rawdir              = fullfile(rootpath_data, config{5}.patientid,'eeg');
%% SESSION PARAMETERS - ses-05
config{5}.sessionid           = 'ses-05';
config{5}.prefix              = 'pat_2680_ses05'; 

config{5}.datasavedir         = fullfile(datasavedir, config{5}.patientid, config{5}.sessionid);
config{5}.imagesavedir        = fullfile(imagesavedir, config{5}.prefix);

config{5}.directorylist{1}    = {'02680_2019-01-23_09-21'}; 

config{5}.circus.channel      			= {'mAmT2_3','mHaT2_5'};
config{5}.circus.outputdir    			= config{5}.datasavedir;
config{5}.circus.params.detection.spike_thresh  = '7';
config{5}.circus.params.clustering.nb_repeats   = '10';
config{5}.circus.params.clustering.max_elts     = '20000';

config{5}.bad.markerStart     = 'begin';
config{5}.bad.markerEnd       = 'SS_Start'; 

config{5}.bad.dir_list        = 'all';

config{5}.bad.sample_list     = 'all'; 

config{5}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02680_1158
config{6}                     = configcommon;
config{6}.patientid	      = 'pat_02680_1158';
config{6}.patients_root_dir   = output_patients;
config{6}.triallist           = 1;


config{6}.rawdir              = fullfile(rootpath_data, config{6}.patientid,'eeg');
%% SESSION PARAMETERS - ses-07
config{6}.sessionid           = 'ses-07';
config{6}.prefix              = 'pat_2680_ses07';

config{6}.datasavedir         = fullfile(datasavedir, config{6}.patientid, config{6}.sessionid);
config{6}.imagesavedir        = fullfile(imagesavedir, config{6}.prefix);

config{6}.directorylist{1}    = {'02680_2019-01-24_11-46'}; 

config{6}.circus.channel      			= {'mAmT2_1', 'mAmT2_3', 'mHaT2_5', 'mHaT2_6'};
config{6}.circus.outputdir    			= config{6}.datasavedir;
config{6}.circus.params.detection.spike_thresh  = '7';
config{6}.circus.params.clustering.nb_repeats   = '10';
config{6}.circus.params.clustering.max_elts     = '20000';

config{6}.bad.markerStart     = 'begin';
config{6}.bad.markerEnd       = 'SS_Start'; 

config{6}.bad.dir_list        = 'all';

config{6}.bad.sample_list     = 'all'; 

config{6}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02680_1158
config{7}                     = configcommon;
config{7}.patientid	      = 'pat_02680_1158';
config{7}.patients_root_dir   = output_patients;
config{7}.triallist           = 1;


config{7}.rawdir              = fullfile(rootpath_data, config{7}.patientid,'eeg');
%% SESSION PARAMETERS - ses-08
config{7}.sessionid           = 'ses-08';
config{7}.prefix              = 'pat_2680_ses08'; 

config{7}.datasavedir         = fullfile(datasavedir, config{7}.patientid, config{7}.sessionid);
config{7}.imagesavedir        = fullfile(imagesavedir, config{7}.prefix);

config{7}.directorylist{1}    = {'02680_2019-01-25_10-03'}; 

config{7}.circus.channel      			= {'mAmT2_3', 'mHaT2_5', 'mHaT2_6'};
config{7}.circus.outputdir    			= config{7}.datasavedir;
config{7}.circus.params.detection.spike_thresh  = '8';
config{7}.circus.params.clustering.nb_repeats   = '10';
config{7}.circus.params.clustering.max_elts     = '20000';

config{7}.bad.markerStart     = 'begin';
config{7}.bad.markerEnd       = 'SS_Start'; 

config{7}.bad.dir_list        = 'all';

config{7}.bad.sample_list     = 'all'; 

config{7}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02680_1158
config{8}                     = configcommon;
config{8}.patientid	      = 'pat_02680_1158';
config{8}.patients_root_dir   = output_patients;
config{8}.triallist           = 1;


config{8}.rawdir              = fullfile(rootpath_data, config{8}.patientid,'eeg');
%% SESSION PARAMETERS - ses-09
config{8}.sessionid           = 'ses-09';
config{8}.prefix              = 'pat_2680_ses09'; 

config{8}.datasavedir         = fullfile(datasavedir, config{8}.patientid, config{8}.sessionid);
config{8}.imagesavedir        = fullfile(imagesavedir, config{8}.prefix);

config{8}.directorylist{1}    = {'02680_2019-01-28_11-06'}; 

config{8}.circus.channel      			= {'mHaT2_5'};
config{8}.circus.outputdir    			= config{8}.datasavedir;
config{8}.circus.params.detection.spike_thresh  = '8';
config{8}.circus.params.clustering.nb_repeats   = '10';
config{8}.circus.params.clustering.max_elts     = '20000';

config{8}.bad.markerStart     = 'begin';
config{8}.bad.markerEnd       = 'SS_Start'; 

config{8}.bad.dir_list        = 'all';

config{8}.bad.sample_list     = 'all'; 

config{8}.LFP.channel         = {''};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_02689_1168
config{9}                     = configcommon;
config{9}.patientid	      = 'pat_02680_1158';
config{9}.patients_root_dir   = output_patients;
config{9}.triallist           = 1;
config{9}.rawdir              = fullfile(rootpath_data, config{9}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{9}.sessionid           = 'ses-01';
config{9}.prefix              = 'pat_2680_ses01' 

config{9}.datasavedir         = fullfile(datasavedir, config{9}.patientid, config{9}.sessionid);
config{9}.imagesavedir        = fullfile(imagesavedir, config{9}.prefix);

config{9}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{9}.circus.channel      			= {'mHaT2_4'};
config{9}.circus.outputdir    			= config{9}.datasavedir;
config{9}.circus.params.detection.spike_thresh  = '8';
config{9}.circus.params.clustering.nb_repeats   = '10';
config{9}.circus.params.clustering.max_elts     = '20000';

config{9}.bad.markerStart     = 'begin';
config{9}.bad.markerEnd       = 'SS_Start'; 

config{9}.bad.dir_list        = 'all';

config{9}.bad.sample_list     = 'all'; 

config{9}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02689_1168
config{10}                     = configcommon;
config{10}.patientid	      = 'pat_02680_1158';
config{10}.patients_root_dir   = output_patients;
config{10}.triallist           = 1;
config{10}.rawdir              = fullfile(rootpath_data, config{10}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{10}.sessionid           = 'ses-01';
config{10}.prefix              = 'pat_2680_ses01' 

config{10}.datasavedir         = fullfile(datasavedir, config{10}.patientid, config{10}.sessionid);
config{10}.imagesavedir        = fullfile(imagesavedir, config{10}.prefix);

config{10}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{10}.circus.channel      			= {'mHaT2_4'};
config{10}.circus.outputdir    			= config{10}.datasavedir;
config{10}.circus.params.detection.spike_thresh  = '8';
config{10}.circus.params.clustering.nb_repeats   = '10';
config{10}.circus.params.clustering.max_elts     = '20000';

config{10}.bad.markerStart     = 'begin';
config{10}.bad.markerEnd       = 'SS_Start'; 

config{10}.bad.dir_list        = 'all';

config{10}.bad.sample_list     = 'all'; 

config{10}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02689_1168
config{11}                     = configcommon;
config{11}.patientid	      = 'pat_02680_1158';
config{11}.patients_root_dir   = output_patients;
config{11}.triallist           = 1;
config{11}.rawdir              = fullfile(rootpath_data, config{11}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{11}.sessionid           = 'ses-01';
config{11}.prefix              = 'pat_2680_ses01' 

config{11}.datasavedir         = fullfile(datasavedir, config{11}.patientid, config{11}.sessionid);
config{11}.imagesavedir        = fullfile(imagesavedir, config{11}.prefix);

config{11}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{11}.circus.channel      			= {'mHaT2_4'};
config{11}.circus.outputdir    			= config{11}.datasavedir;
config{11}.circus.params.detection.spike_thresh  = '8';
config{11}.circus.params.clustering.nb_repeats   = '10';
config{11}.circus.params.clustering.max_elts     = '20000';

config{11}.bad.markerStart     = 'begin';
config{11}.bad.markerEnd       = 'SS_Start'; 

config{11}.bad.dir_list        = 'all';

config{11}.bad.sample_list     = 'all'; 

config{11}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02689_1168
config{12}                     = configcommon;
config{12}.patientid	      = 'pat_02680_1158';
config{12}.patients_root_dir   = output_patients;
config{12}.triallist           = 1;
config{12}.rawdir              = fullfile(rootpath_data, config{12}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{12}.sessionid           = 'ses-01';
config{12}.prefix              = 'pat_2680_ses01' 

config{12}.datasavedir         = fullfile(datasavedir, config{12}.patientid, config{12}.sessionid);
config{12}.imagesavedir        = fullfile(imagesavedir, config{12}.prefix);

config{12}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{12}.circus.channel      			= {'mHaT2_4'};
config{12}.circus.outputdir    			= config{12}.datasavedir;
config{12}.circus.params.detection.spike_thresh  = '8';
config{12}.circus.params.clustering.nb_repeats   = '10';
config{12}.circus.params.clustering.max_elts     = '20000';

config{12}.bad.markerStart     = 'begin';
config{12}.bad.markerEnd       = 'SS_Start'; 

config{12}.bad.dir_list        = 'all';

config{12}.bad.sample_list     = 'all'; 

config{12}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02689_1168
config{13}                     = configcommon;
config{13}.patientid	      = 'pat_02680_1158';
config{13}.patients_root_dir   = output_patients;
config{13}.triallist           = 1;
config{13}.rawdir              = fullfile(rootpath_data, config{13}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{13}.sessionid           = 'ses-01';
config{13}.prefix              = 'pat_2680_ses01' 

config{13}.datasavedir         = fullfile(datasavedir, config{13}.patientid, config{13}.sessionid);
config{13}.imagesavedir        = fullfile(imagesavedir, config{13}.prefix);

config{13}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{13}.circus.channel      			= {'mHaT2_4'};
config{13}.circus.outputdir    			= config{13}.datasavedir;
config{13}.circus.params.detection.spike_thresh  = '8';
config{13}.circus.params.clustering.nb_repeats   = '10';
config{13}.circus.params.clustering.max_elts     = '20000';

config{13}.bad.markerStart     = 'begin';
config{13}.bad.markerEnd       = 'SS_Start'; 

config{13}.bad.dir_list        = 'all';

config{13}.bad.sample_list     = 'all'; 

config{13}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02689_1168
config{14}                     = configcommon;
config{14}.patientid	      = 'pat_02680_1158';
config{14}.patients_root_dir   = output_patients;
config{14}.triallist           = 1;
config{14}.rawdir              = fullfile(rootpath_data, config{14}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{14}.sessionid           = 'ses-01';
config{14}.prefix              = 'pat_2680_ses01' 

config{14}.datasavedir         = fullfile(datasavedir, config{14}.patientid, config{14}.sessionid);
config{14}.imagesavedir        = fullfile(imagesavedir, config{14}.prefix);

config{14}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{14}.circus.channel      			= {'mHaT2_4'};
config{14}.circus.outputdir    			= config{14}.datasavedir;
config{14}.circus.params.detection.spike_thresh  = '8';
config{14}.circus.params.clustering.nb_repeats   = '10';
config{14}.circus.params.clustering.max_elts     = '20000';

config{14}.bad.markerStart     = 'begin';
config{14}.bad.markerEnd       = 'SS_Start'; 

config{14}.bad.dir_list        = 'all';

config{14}.bad.sample_list     = 'all'; 

config{14}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02689_1168
config{15}                     = configcommon;
config{15}.patientid	      = 'pat_02680_1158';
config{15}.patients_root_dir   = output_patients;
config{15}.triallist           = 1;
config{15}.rawdir              = fullfile(rootpath_data, config{15}.patientid,'eeg');
%SESSION PARAMETERS - ses-07
config{15}.sessionid           = 'ses-01';
config{15}.prefix              = 'pat_2680_ses01' 

config{15}.datasavedir         = fullfile(datasavedir, config{15}.patientid, config{15}.sessionid);
config{15}.imagesavedir        = fullfile(imagesavedir, config{15}.prefix);

config{15}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{15}.circus.channel      			= {'mHaT2_4'};
config{15}.circus.outputdir    			= config{15}.datasavedir;
config{15}.circus.params.detection.spike_thresh  = '8';
config{15}.circus.params.clustering.nb_repeats   = '10';
config{15}.circus.params.clustering.max_elts     = '20000';

config{15}.bad.markerStart     = 'begin';
config{15}.bad.markerEnd       = 'SS_Start'; 

config{15}.bad.dir_list        = 'all';

config{15}.bad.sample_list     = 'all'; 

config{15}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02689_1168
config{16}                     = configcommon;
config{16}.patientid	      = 'pat_02680_1158';
config{16}.patients_root_dir   = output_patients;
config{16}.triallist           = 1;
config{16}.rawdir              = fullfile(rootpath_data, config{16}.patientid,'eeg');
%SESSION PARAMETERS - ses-08
config{16}.sessionid           = 'ses-01';
config{16}.prefix              = 'pat_2680_ses01' 

config{16}.datasavedir         = fullfile(datasavedir, config{16}.patientid, config{16}.sessionid);
config{16}.imagesavedir        = fullfile(imagesavedir, config{16}.prefix);

config{16}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{16}.circus.channel      			= {'mHaT2_4'};
config{16}.circus.outputdir    			= config{16}.datasavedir;
config{16}.circus.params.detection.spike_thresh  = '8';
config{16}.circus.params.clustering.nb_repeats   = '10';
config{16}.circus.params.clustering.max_elts     = '20000';

config{16}.bad.markerStart     = 'begin';
config{16}.bad.markerEnd       = 'SS_Start'; 

config{16}.bad.dir_list        = 'all';

config{16}.bad.sample_list     = 'all'; 

config{16}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02689_1168
config{17}                     = configcommon;
config{17}.patientid	      = 'pat_02680_1158';
config{17}.patients_root_dir   = output_patients;
config{17}.triallist           = 1;
config{17}.rawdir              = fullfile(rootpath_data, config{17}.patientid,'eeg');
%SESSION PARAMETERS - ses-09
config{17}.sessionid           = 'ses-01';
config{17}.prefix              = 'pat_2680_ses01' 

config{17}.datasavedir         = fullfile(datasavedir, config{17}.patientid, config{17}.sessionid);
config{17}.imagesavedir        = fullfile(imagesavedir, config{17}.prefix);

config{17}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{17}.circus.channel      			= {'mHaT2_4'};
config{17}.circus.outputdir    			= config{17}.datasavedir;
config{17}.circus.params.detection.spike_thresh  = '8';
config{17}.circus.params.clustering.nb_repeats   = '10';
config{17}.circus.params.clustering.max_elts     = '20000';

config{17}.bad.markerStart     = 'begin';
config{17}.bad.markerEnd       = 'SS_Start'; 

config{17}.bad.dir_list        = 'all';

config{17}.bad.sample_list     = 'all'; 

config{17}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02689_1168
config{18}                     = configcommon;
config{18}.patientid	      = 'pat_02680_1158';
config{18}.patients_root_dir   = output_patients;
config{18}.triallist           = 1;
config{18}.rawdir              = fullfile(rootpath_data, config{18}.patientid,'eeg');
%SESSION PARAMETERS - ses-10
config{18}.sessionid           = 'ses-01';
config{18}.prefix              = 'pat_2680_ses01' 

config{18}.datasavedir         = fullfile(datasavedir, config{18}.patientid, config{18}.sessionid);
config{18}.imagesavedir        = fullfile(imagesavedir, config{18}.prefix);

config{18}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{18}.circus.channel      			= {'mHaT2_4'};
config{18}.circus.outputdir    			= config{18}.datasavedir;
config{18}.circus.params.detection.spike_thresh  = '8';
config{18}.circus.params.clustering.nb_repeats   = '10';
config{18}.circus.params.clustering.max_elts     = '20000';

config{18}.bad.markerStart     = 'begin';
config{18}.bad.markerEnd       = 'SS_Start'; 

config{18}.bad.dir_list        = 'all';

config{18}.bad.sample_list     = 'all'; 

config{18}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02689_1168
config{19}                     = configcommon;
config{19}.patientid	      = 'pat_02680_1158';
config{19}.patients_root_dir   = output_patients;
config{19}.triallist           = 1;
config{19}.rawdir              = fullfile(rootpath_data, config{19}.patientid,'eeg');
%SESSION PARAMETERS - ses-11
config{19}.sessionid           = 'ses-01';
config{19}.prefix              = 'pat_2680_ses01' 

config{19}.datasavedir         = fullfile(datasavedir, config{19}.patientid, config{19}.sessionid);
config{19}.imagesavedir        = fullfile(imagesavedir, config{19}.prefix);

config{19}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{19}.circus.channel      			= {'mHaT2_4'};
config{19}.circus.outputdir    			= config{19}.datasavedir;
config{19}.circus.params.detection.spike_thresh  = '8';
config{19}.circus.params.clustering.nb_repeats   = '10';
config{19}.circus.params.clustering.max_elts     = '20000';

config{19}.bad.markerStart     = 'begin';
config{19}.bad.markerEnd       = 'SS_Start'; 

config{19}.bad.dir_list        = 'all';

config{19}.bad.sample_list     = 'all'; 

config{19}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02689_1168
config{20}                     = configcommon;
config{20}.patientid	      = 'pat_02680_1158';
config{20}.patients_root_dir   = output_patients;
config{20}.triallist           = 1;
config{20}.rawdir              = fullfile(rootpath_data, config{20}.patientid,'eeg');
%SESSION PARAMETERS - ses-12
config{20}.sessionid           = 'ses-01';
config{20}.prefix              = 'pat_2680_ses01' 

config{20}.datasavedir         = fullfile(datasavedir, config{20}.patientid, config{20}.sessionid);
config{20}.imagesavedir        = fullfile(imagesavedir, config{20}.prefix);

config{20}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{20}.circus.channel      			= {'mHaT2_4'};
config{20}.circus.outputdir    			= config{20}.datasavedir;
config{20}.circus.params.detection.spike_thresh  = '8';
config{20}.circus.params.clustering.nb_repeats   = '10';
config{20}.circus.params.clustering.max_elts     = '20000';

config{20}.bad.markerStart     = 'begin';
config{20}.bad.markerEnd       = 'SS_Start'; 

config{20}.bad.dir_list        = 'all';

config{20}.bad.sample_list     = 'all'; 

config{20}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02689_1168
config{21}                     = configcommon;
config{21}.patientid	      = 'pat_02680_1158';
config{21}.patients_root_dir   = output_patients;
config{21}.triallist           = 1;
config{21}.rawdir              = fullfile(rootpath_data, config{21}.patientid,'eeg');
%SESSION PARAMETERS - ses-13
config{21}.sessionid           = 'ses-01';
config{21}.prefix              = 'pat_2680_ses01' 

config{21}.datasavedir         = fullfile(datasavedir, config{21}.patientid, config{21}.sessionid);
config{21}.imagesavedir        = fullfile(imagesavedir, config{21}.prefix);

config{21}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{21}.circus.channel      			= {'mHaT2_4'};
config{21}.circus.outputdir    			= config{21}.datasavedir;
config{21}.circus.params.detection.spike_thresh  = '8';
config{21}.circus.params.clustering.nb_repeats   = '10';
config{21}.circus.params.clustering.max_elts     = '20000';

config{21}.bad.markerStart     = 'begin';
config{21}.bad.markerEnd       = 'SS_Start'; 

config{21}.bad.dir_list        = 'all';

config{21}.bad.sample_list     = 'all'; 

config{21}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_02711_1193
config{22}                     = configcommon;
config{22}.patientid	      = 'pat_02680_1158';
config{22}.patients_root_dir   = output_patients;
config{22}.triallist           = 1;
config{22}.rawdir              = fullfile(rootpath_data, config{22}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{22}.sessionid           = 'ses-01';
config{22}.prefix              = 'pat_2680_ses01' 

config{22}.datasavedir         = fullfile(datasavedir, config{22}.patientid, config{22}.sessionid);
config{22}.imagesavedir        = fullfile(imagesavedir, config{22}.prefix);

config{22}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{22}.circus.channel      			= {'mHaT2_4'};
config{22}.circus.outputdir    			= config{22}.datasavedir;
config{22}.circus.params.detection.spike_thresh  = '8';
config{22}.circus.params.clustering.nb_repeats   = '10';
config{22}.circus.params.clustering.max_elts     = '20000';

config{22}.bad.markerStart     = 'begin';
config{22}.bad.markerEnd       = 'SS_Start'; 

config{22}.bad.dir_list        = 'all';

config{22}.bad.sample_list     = 'all'; 

config{22}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02711_1193
config{23}                     = configcommon;
config{23}.patientid	      = 'pat_02680_1158';
config{23}.patients_root_dir   = output_patients;
config{23}.triallist           = 1;
config{23}.rawdir              = fullfile(rootpath_data, config{23}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{23}.sessionid           = 'ses-01';
config{23}.prefix              = 'pat_2680_ses01' 

config{23}.datasavedir         = fullfile(datasavedir, config{23}.patientid, config{23}.sessionid);
config{23}.imagesavedir        = fullfile(imagesavedir, config{23}.prefix);

config{23}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{23}.circus.channel      			= {'mHaT2_4'};
config{23}.circus.outputdir    			= config{23}.datasavedir;
config{23}.circus.params.detection.spike_thresh  = '8';
config{23}.circus.params.clustering.nb_repeats   = '10';
config{23}.circus.params.clustering.max_elts     = '20000';

config{23}.bad.markerStart     = 'begin';
config{23}.bad.markerEnd       = 'SS_Start'; 

config{23}.bad.dir_list        = 'all';

config{23}.bad.sample_list     = 'all'; 

config{23}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02711_1193
config{24}                     = configcommon;
config{24}.patientid	      = 'pat_02680_1158';
config{24}.patients_root_dir   = output_patients;
config{24}.triallist           = 1;
config{24}.rawdir              = fullfile(rootpath_data, config{24}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{24}.sessionid           = 'ses-01';
config{24}.prefix              = 'pat_2680_ses01' 

config{24}.datasavedir         = fullfile(datasavedir, config{24}.patientid, config{24}.sessionid);
config{24}.imagesavedir        = fullfile(imagesavedir, config{24}.prefix);

config{24}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{24}.circus.channel      			= {'mHaT2_4'};
config{24}.circus.outputdir    			= config{24}.datasavedir;
config{24}.circus.params.detection.spike_thresh  = '8';
config{24}.circus.params.clustering.nb_repeats   = '10';
config{24}.circus.params.clustering.max_elts     = '20000';

config{24}.bad.markerStart     = 'begin';
config{24}.bad.markerEnd       = 'SS_Start'; 

config{24}.bad.dir_list        = 'all';

config{24}.bad.sample_list     = 'all'; 

config{24}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02711_1193
config{25}                     = configcommon;
config{25}.patientid	      = 'pat_02680_1158';
config{25}.patients_root_dir   = output_patients;
config{25}.triallist           = 1;
config{25}.rawdir              = fullfile(rootpath_data, config{25}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{25}.sessionid           = 'ses-01';
config{25}.prefix              = 'pat_2680_ses01' 

config{25}.datasavedir         = fullfile(datasavedir, config{25}.patientid, config{25}.sessionid);
config{25}.imagesavedir        = fullfile(imagesavedir, config{25}.prefix);

config{25}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{25}.circus.channel      			= {'mHaT2_4'};
config{25}.circus.outputdir    			= config{25}.datasavedir;
config{25}.circus.params.detection.spike_thresh  = '8';
config{25}.circus.params.clustering.nb_repeats   = '10';
config{25}.circus.params.clustering.max_elts     = '20000';

config{25}.bad.markerStart     = 'begin';
config{25}.bad.markerEnd       = 'SS_Start'; 

config{25}.bad.dir_list        = 'all';

config{25}.bad.sample_list     = 'all'; 

config{25}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02711_1193
config{26}                     = configcommon;
config{26}.patientid	      = 'pat_02680_1158';
config{26}.patients_root_dir   = output_patients;
config{26}.triallist           = 1;
config{26}.rawdir              = fullfile(rootpath_data, config{26}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{26}.sessionid           = 'ses-01';
config{26}.prefix              = 'pat_2680_ses01' 

config{26}.datasavedir         = fullfile(datasavedir, config{26}.patientid, config{26}.sessionid);
config{26}.imagesavedir        = fullfile(imagesavedir, config{26}.prefix);

config{26}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{26}.circus.channel      			= {'mHaT2_4'};
config{26}.circus.outputdir    			= config{26}.datasavedir;
config{26}.circus.params.detection.spike_thresh  = '8';
config{26}.circus.params.clustering.nb_repeats   = '10';
config{26}.circus.params.clustering.max_elts     = '20000';

config{26}.bad.markerStart     = 'begin';
config{26}.bad.markerEnd       = 'SS_Start'; 

config{26}.bad.dir_list        = 'all';

config{26}.bad.sample_list     = 'all'; 

config{26}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02711_1193
config{27}                     = configcommon;
config{27}.patientid	      = 'pat_02680_1158';
config{27}.patients_root_dir   = output_patients;
config{27}.triallist           = 1;
config{27}.rawdir              = fullfile(rootpath_data, config{27}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{27}.sessionid           = 'ses-01';
config{27}.prefix              = 'pat_2680_ses01' 

config{27}.datasavedir         = fullfile(datasavedir, config{27}.patientid, config{27}.sessionid);
config{27}.imagesavedir        = fullfile(imagesavedir, config{27}.prefix);

config{27}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{27}.circus.channel      			= {'mHaT2_4'};
config{27}.circus.outputdir    			= config{27}.datasavedir;
config{27}.circus.params.detection.spike_thresh  = '8';
config{27}.circus.params.clustering.nb_repeats   = '10';
config{27}.circus.params.clustering.max_elts     = '20000';

config{27}.bad.markerStart     = 'begin';
config{27}.bad.markerEnd       = 'SS_Start'; 

config{27}.bad.dir_list        = 'all';

config{27}.bad.sample_list     = 'all'; 

config{27}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02711_1193
config{28}                     = configcommon;
config{28}.patientid	      = 'pat_02680_1158';
config{28}.patients_root_dir   = output_patients;
config{28}.triallist           = 1;
config{28}.rawdir              = fullfile(rootpath_data, config{28}.patientid,'eeg');
%SESSION PARAMETERS - ses-07
config{28}.sessionid           = 'ses-01';
config{28}.prefix              = 'pat_2680_ses01' 

config{28}.datasavedir         = fullfile(datasavedir, config{28}.patientid, config{28}.sessionid);
config{28}.imagesavedir        = fullfile(imagesavedir, config{28}.prefix);

config{28}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{28}.circus.channel      			= {'mHaT2_4'};
config{28}.circus.outputdir    			= config{28}.datasavedir;
config{28}.circus.params.detection.spike_thresh  = '8';
config{28}.circus.params.clustering.nb_repeats   = '10';
config{28}.circus.params.clustering.max_elts     = '20000';

config{28}.bad.markerStart     = 'begin';
config{28}.bad.markerEnd       = 'SS_Start'; 

config{28}.bad.dir_list        = 'all';

config{28}.bad.sample_list     = 'all'; 

config{28}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02711_1193
config{29}                     = configcommon;
config{29}.patientid	      = 'pat_02680_1158';
config{29}.patients_root_dir   = output_patients;
config{29}.triallist           = 1;
config{29}.rawdir              = fullfile(rootpath_data, config{29}.patientid,'eeg');
%SESSION PARAMETERS - ses-08
config{29}.sessionid           = 'ses-01';
config{29}.prefix              = 'pat_2680_ses01' 

config{29}.datasavedir         = fullfile(datasavedir, config{29}.patientid, config{29}.sessionid);
config{29}.imagesavedir        = fullfile(imagesavedir, config{29}.prefix);

config{29}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{29}.circus.channel      			= {'mHaT2_4'};
config{29}.circus.outputdir    			= config{29}.datasavedir;
config{29}.circus.params.detection.spike_thresh  = '8';
config{29}.circus.params.clustering.nb_repeats   = '10';
config{29}.circus.params.clustering.max_elts     = '20000';

config{29}.bad.markerStart     = 'begin';
config{29}.bad.markerEnd       = 'SS_Start'; 

config{29}.bad.dir_list        = 'all';

config{29}.bad.sample_list     = 'all'; 

config{29}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02711_1193
config{30}                     = configcommon;
config{30}.patientid	      = 'pat_02680_1158';
config{30}.patients_root_dir   = output_patients;
config{30}.triallist           = 1;
config{30}.rawdir              = fullfile(rootpath_data, config{30}.patientid,'eeg');
%SESSION PARAMETERS - ses-09
config{30}.sessionid           = 'ses-01';
config{30}.prefix              = 'pat_2680_ses01' 

config{30}.datasavedir         = fullfile(datasavedir, config{30}.patientid, config{30}.sessionid);
config{30}.imagesavedir        = fullfile(imagesavedir, config{30}.prefix);

config{30}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{30}.circus.channel      			= {'mHaT2_4'};
config{30}.circus.outputdir    			= config{30}.datasavedir;
config{30}.circus.params.detection.spike_thresh  = '8';
config{30}.circus.params.clustering.nb_repeats   = '10';
config{30}.circus.params.clustering.max_elts     = '20000';

config{30}.bad.markerStart     = 'begin';
config{30}.bad.markerEnd       = 'SS_Start'; 

config{30}.bad.dir_list        = 'all';

config{30}.bad.sample_list     = 'all'; 

config{30}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02711_1193
config{31}                     = configcommon;
config{31}.patientid	      = 'pat_02680_1158';
config{31}.patients_root_dir   = output_patients;
config{31}.triallist           = 1;
config{31}.rawdir              = fullfile(rootpath_data, config{31}.patientid,'eeg');
%SESSION PARAMETERS - ses-10
config{31}.sessionid           = 'ses-01';
config{31}.prefix              = 'pat_2680_ses01' 

config{31}.datasavedir         = fullfile(datasavedir, config{31}.patientid, config{31}.sessionid);
config{31}.imagesavedir        = fullfile(imagesavedir, config{31}.prefix);

config{31}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{31}.circus.channel      			= {'mHaT2_4'};
config{31}.circus.outputdir    			= config{31}.datasavedir;
config{31}.circus.params.detection.spike_thresh  = '8';
config{31}.circus.params.clustering.nb_repeats   = '10';
config{31}.circus.params.clustering.max_elts     = '20000';

config{31}.bad.markerStart     = 'begin';
config{31}.bad.markerEnd       = 'SS_Start'; 

config{31}.bad.dir_list        = 'all';

config{31}.bad.sample_list     = 'all'; 

config{31}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02711_1193
config{32}                     = configcommon;
config{32}.patientid	      = 'pat_02680_1158';
config{32}.patients_root_dir   = output_patients;
config{32}.triallist           = 1;
config{32}.rawdir              = fullfile(rootpath_data, config{32}.patientid,'eeg');
%SESSION PARAMETERS - ses-11
config{32}.sessionid           = 'ses-01';
config{32}.prefix              = 'pat_2680_ses01' 

config{32}.datasavedir         = fullfile(datasavedir, config{32}.patientid, config{32}.sessionid);
config{32}.imagesavedir        = fullfile(imagesavedir, config{32}.prefix);

config{32}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{32}.circus.channel      			= {'mHaT2_4'};
config{32}.circus.outputdir    			= config{32}.datasavedir;
config{32}.circus.params.detection.spike_thresh  = '8';
config{32}.circus.params.clustering.nb_repeats   = '10';
config{32}.circus.params.clustering.max_elts     = '20000';

config{32}.bad.markerStart     = 'begin';
config{32}.bad.markerEnd       = 'SS_Start'; 

config{32}.bad.dir_list        = 'all';

config{32}.bad.sample_list     = 'all'; 

config{32}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_02718_1201
config{33}                     = configcommon;
config{33}.patientid	      = 'pat_02680_1158';
config{33}.patients_root_dir   = output_patients;
config{33}.triallist           = 1;
config{33}.rawdir              = fullfile(rootpath_data, config{33}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{33}.sessionid           = 'ses-01';
config{33}.prefix              = 'pat_2680_ses01' 

config{33}.datasavedir         = fullfile(datasavedir, config{33}.patientid, config{33}.sessionid);
config{33}.imagesavedir        = fullfile(imagesavedir, config{33}.prefix);

config{33}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{33}.circus.channel      			= {'mHaT2_4'};
config{33}.circus.outputdir    			= config{33}.datasavedir;
config{33}.circus.params.detection.spike_thresh  = '8';
config{33}.circus.params.clustering.nb_repeats   = '10';
config{33}.circus.params.clustering.max_elts     = '20000';

config{33}.bad.markerStart     = 'begin';
config{33}.bad.markerEnd       = 'SS_Start'; 

config{33}.bad.dir_list        = 'all';

config{33}.bad.sample_list     = 'all'; 

config{33}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02718_1201
config{34}                     = configcommon;
config{34}.patientid	      = 'pat_02680_1158';
config{34}.patients_root_dir   = output_patients;
config{34}.triallist           = 1;
config{34}.rawdir              = fullfile(rootpath_data, config{34}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{34}.sessionid           = 'ses-01';
config{34}.prefix              = 'pat_2680_ses01' 

config{34}.datasavedir         = fullfile(datasavedir, config{34}.patientid, config{34}.sessionid);
config{34}.imagesavedir        = fullfile(imagesavedir, config{34}.prefix);

config{34}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{34}.circus.channel      			= {'mHaT2_4'};
config{34}.circus.outputdir    			= config{34}.datasavedir;
config{34}.circus.params.detection.spike_thresh  = '8';
config{34}.circus.params.clustering.nb_repeats   = '10';
config{34}.circus.params.clustering.max_elts     = '20000';

config{34}.bad.markerStart     = 'begin';
config{34}.bad.markerEnd       = 'SS_Start'; 

config{34}.bad.dir_list        = 'all';

config{34}.bad.sample_list     = 'all'; 

config{34}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02718_1201
config{35}                     = configcommon;
config{35}.patientid	      = 'pat_02680_1158';
config{35}.patients_root_dir   = output_patients;
config{35}.triallist           = 1;
config{35}.rawdir              = fullfile(rootpath_data, config{35}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{35}.sessionid           = 'ses-01';
config{35}.prefix              = 'pat_2680_ses01' 

config{35}.datasavedir         = fullfile(datasavedir, config{35}.patientid, config{35}.sessionid);
config{35}.imagesavedir        = fullfile(imagesavedir, config{35}.prefix);

config{35}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{35}.circus.channel      			= {'mHaT2_4'};
config{35}.circus.outputdir    			= config{35}.datasavedir;
config{35}.circus.params.detection.spike_thresh  = '8';
config{35}.circus.params.clustering.nb_repeats   = '10';
config{35}.circus.params.clustering.max_elts     = '20000';

config{35}.bad.markerStart     = 'begin';
config{35}.bad.markerEnd       = 'SS_Start'; 

config{35}.bad.dir_list        = 'all';

config{35}.bad.sample_list     = 'all'; 

config{35}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02718_1201
config{36}                     = configcommon;
config{36}.patientid	      = 'pat_02680_1158';
config{36}.patients_root_dir   = output_patients;
config{36}.triallist           = 1;
config{36}.rawdir              = fullfile(rootpath_data, config{36}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{36}.sessionid           = 'ses-01';
config{36}.prefix              = 'pat_2680_ses01' 

config{36}.datasavedir         = fullfile(datasavedir, config{36}.patientid, config{36}.sessionid);
config{36}.imagesavedir        = fullfile(imagesavedir, config{36}.prefix);

config{36}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{36}.circus.channel      			= {'mHaT2_4'};
config{36}.circus.outputdir    			= config{36}.datasavedir;
config{36}.circus.params.detection.spike_thresh  = '8';
config{36}.circus.params.clustering.nb_repeats   = '10';
config{36}.circus.params.clustering.max_elts     = '20000';

config{36}.bad.markerStart     = 'begin';
config{36}.bad.markerEnd       = 'SS_Start'; 

config{36}.bad.dir_list        = 'all';

config{36}.bad.sample_list     = 'all'; 

config{36}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02718_1201
config{37}                     = configcommon;
config{37}.patientid	      = 'pat_02680_1158';
config{37}.patients_root_dir   = output_patients;
config{37}.triallist           = 1;
config{37}.rawdir              = fullfile(rootpath_data, config{37}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{37}.sessionid           = 'ses-01';
config{37}.prefix              = 'pat_2680_ses01' 

config{37}.datasavedir         = fullfile(datasavedir, config{37}.patientid, config{37}.sessionid);
config{37}.imagesavedir        = fullfile(imagesavedir, config{37}.prefix);

config{37}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{37}.circus.channel      			= {'mHaT2_4'};
config{37}.circus.outputdir    			= config{37}.datasavedir;
config{37}.circus.params.detection.spike_thresh  = '8';
config{37}.circus.params.clustering.nb_repeats   = '10';
config{37}.circus.params.clustering.max_elts     = '20000';

config{37}.bad.markerStart     = 'begin';
config{37}.bad.markerEnd       = 'SS_Start'; 

config{37}.bad.dir_list        = 'all';

config{37}.bad.sample_list     = 'all'; 

config{37}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02718_1201
config{38}                     = configcommon;
config{38}.patientid	      = 'pat_02680_1158';
config{38}.patients_root_dir   = output_patients;
config{38}.triallist           = 1;
config{38}.rawdir              = fullfile(rootpath_data, config{38}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{38}.sessionid           = 'ses-01';
config{38}.prefix              = 'pat_2680_ses01' 

config{38}.datasavedir         = fullfile(datasavedir, config{38}.patientid, config{38}.sessionid);
config{38}.imagesavedir        = fullfile(imagesavedir, config{38}.prefix);

config{38}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{38}.circus.channel      			= {'mHaT2_4'};
config{38}.circus.outputdir    			= config{38}.datasavedir;
config{38}.circus.params.detection.spike_thresh  = '8';
config{38}.circus.params.clustering.nb_repeats   = '10';
config{38}.circus.params.clustering.max_elts     = '20000';

config{38}.bad.markerStart     = 'begin';
config{38}.bad.markerEnd       = 'SS_Start'; 

config{38}.bad.dir_list        = 'all';

config{38}.bad.sample_list     = 'all'; 

config{38}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02718_1201
config{39}                     = configcommon;
config{39}.patientid	      = 'pat_02680_1158';
config{39}.patients_root_dir   = output_patients;
config{39}.triallist           = 1;
config{39}.rawdir              = fullfile(rootpath_data, config{39}.patientid,'eeg');
%SESSION PARAMETERS - ses-07
config{39}.sessionid           = 'ses-01';
config{39}.prefix              = 'pat_2680_ses01' 

config{39}.datasavedir         = fullfile(datasavedir, config{39}.patientid, config{39}.sessionid);
config{39}.imagesavedir        = fullfile(imagesavedir, config{39}.prefix);

config{39}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{39}.circus.channel      			= {'mHaT2_4'};
config{39}.circus.outputdir    			= config{39}.datasavedir;
config{39}.circus.params.detection.spike_thresh  = '8';
config{39}.circus.params.clustering.nb_repeats   = '10';
config{39}.circus.params.clustering.max_elts     = '20000';

config{39}.bad.markerStart     = 'begin';
config{39}.bad.markerEnd       = 'SS_Start'; 

config{39}.bad.dir_list        = 'all';

config{39}.bad.sample_list     = 'all'; 

config{39}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02718_1201
config{40}                     = configcommon;
config{40}.patientid	      = 'pat_02680_1158';
config{40}.patients_root_dir   = output_patients;
config{40}.triallist           = 1;
config{40}.rawdir              = fullfile(rootpath_data, config{40}.patientid,'eeg');
%SESSION PARAMETERS - ses-08
config{40}.sessionid           = 'ses-01';
config{40}.prefix              = 'pat_2680_ses01' 

config{40}.datasavedir         = fullfile(datasavedir, config{40}.patientid, config{40}.sessionid);
config{40}.imagesavedir        = fullfile(imagesavedir, config{40}.prefix);

config{40}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{40}.circus.channel      			= {'mHaT2_4'};
config{40}.circus.outputdir    			= config{40}.datasavedir;
config{40}.circus.params.detection.spike_thresh  = '8';
config{40}.circus.params.clustering.nb_repeats   = '10';
config{40}.circus.params.clustering.max_elts     = '20000';

config{40}.bad.markerStart     = 'begin';
config{40}.bad.markerEnd       = 'SS_Start'; 

config{40}.bad.dir_list        = 'all';

config{40}.bad.sample_list     = 'all'; 

config{40}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02718_1201
config{41}                     = configcommon;
config{41}.patientid	      = 'pat_02680_1158';
config{41}.patients_root_dir   = output_patients;
config{41}.triallist           = 1;
config{41}.rawdir              = fullfile(rootpath_data, config{41}.patientid,'eeg');
%SESSION PARAMETERS - ses-09
config{41}.sessionid           = 'ses-01';
config{41}.prefix              = 'pat_2680_ses01' 

config{41}.datasavedir         = fullfile(datasavedir, config{41}.patientid, config{41}.sessionid);
config{41}.imagesavedir        = fullfile(imagesavedir, config{41}.prefix);

config{41}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{41}.circus.channel      			= {'mHaT2_4'};
config{41}.circus.outputdir    			= config{41}.datasavedir;
config{41}.circus.params.detection.spike_thresh  = '8';
config{41}.circus.params.clustering.nb_repeats   = '10';
config{41}.circus.params.clustering.max_elts     = '20000';

config{41}.bad.markerStart     = 'begin';
config{41}.bad.markerEnd       = 'SS_Start'; 

config{41}.bad.dir_list        = 'all';

config{41}.bad.sample_list     = 'all'; 

config{41}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02718_1201
config{42}                     = configcommon;
config{42}.patientid	      = 'pat_02680_1158';
config{42}.patients_root_dir   = output_patients;
config{42}.triallist           = 1;
config{42}.rawdir              = fullfile(rootpath_data, config{42}.patientid,'eeg');
%SESSION PARAMETERS - ses-10
config{42}.sessionid           = 'ses-01';
config{42}.prefix              = 'pat_2680_ses01' 

config{42}.datasavedir         = fullfile(datasavedir, config{42}.patientid, config{42}.sessionid);
config{42}.imagesavedir        = fullfile(imagesavedir, config{42}.prefix);

config{42}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{42}.circus.channel      			= {'mHaT2_4'};
config{42}.circus.outputdir    			= config{42}.datasavedir;
config{42}.circus.params.detection.spike_thresh  = '8';
config{42}.circus.params.clustering.nb_repeats   = '10';
config{42}.circus.params.clustering.max_elts     = '20000';

config{42}.bad.markerStart     = 'begin';
config{42}.bad.markerEnd       = 'SS_Start'; 

config{42}.bad.dir_list        = 'all';

config{42}.bad.sample_list     = 'all'; 

config{42}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02718_1201
config{43}                     = configcommon;
config{43}.patientid	      = 'pat_02680_1158';
config{43}.patients_root_dir   = output_patients;
config{43}.triallist           = 1;
config{43}.rawdir              = fullfile(rootpath_data, config{43}.patientid,'eeg');
%SESSION PARAMETERS - ses-11
config{43}.sessionid           = 'ses-01';
config{43}.prefix              = 'pat_2680_ses01' 

config{43}.datasavedir         = fullfile(datasavedir, config{43}.patientid, config{43}.sessionid);
config{43}.imagesavedir        = fullfile(imagesavedir, config{43}.prefix);

config{43}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{43}.circus.channel      			= {'mHaT2_4'};
config{43}.circus.outputdir    			= config{43}.datasavedir;
config{43}.circus.params.detection.spike_thresh  = '8';
config{43}.circus.params.clustering.nb_repeats   = '10';
config{43}.circus.params.clustering.max_elts     = '20000';

config{43}.bad.markerStart     = 'begin';
config{43}.bad.markerEnd       = 'SS_Start'; 

config{43}.bad.dir_list        = 'all';

config{43}.bad.sample_list     = 'all'; 

config{43}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02718_1201
config{44}                     = configcommon;
config{44}.patientid	      = 'pat_02680_1158';
config{44}.patients_root_dir   = output_patients;
config{44}.triallist           = 1;
config{44}.rawdir              = fullfile(rootpath_data, config{44}.patientid,'eeg');
%SESSION PARAMETERS - ses-12
config{44}.sessionid           = 'ses-01';
config{44}.prefix              = 'pat_2680_ses01' 

config{44}.datasavedir         = fullfile(datasavedir, config{44}.patientid, config{44}.sessionid);
config{44}.imagesavedir        = fullfile(imagesavedir, config{44}.prefix);

config{44}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{44}.circus.channel      			= {'mHaT2_4'};
config{44}.circus.outputdir    			= config{44}.datasavedir;
config{44}.circus.params.detection.spike_thresh  = '8';
config{44}.circus.params.clustering.nb_repeats   = '10';
config{44}.circus.params.clustering.max_elts     = '20000';

config{44}.bad.markerStart     = 'begin';
config{44}.bad.markerEnd       = 'SS_Start'; 

config{44}.bad.dir_list        = 'all';

config{44}.bad.sample_list     = 'all'; 

config{44}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02718_1201
config{45}                     = configcommon;
config{45}.patientid	      = 'pat_02680_1158';
config{45}.patients_root_dir   = output_patients;
config{45}.triallist           = 1;
config{45}.rawdir              = fullfile(rootpath_data, config{45}.patientid,'eeg');
%SESSION PARAMETERS - ses-13
config{45}.sessionid           = 'ses-01';
config{45}.prefix              = 'pat_2680_ses01' 

config{45}.datasavedir         = fullfile(datasavedir, config{45}.patientid, config{45}.sessionid);
config{45}.imagesavedir        = fullfile(imagesavedir, config{45}.prefix);

config{45}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{45}.circus.channel      			= {'mHaT2_4'};
config{45}.circus.outputdir    			= config{45}.datasavedir;
config{45}.circus.params.detection.spike_thresh  = '8';
config{45}.circus.params.clustering.nb_repeats   = '10';
config{45}.circus.params.clustering.max_elts     = '20000';

config{45}.bad.markerStart     = 'begin';
config{45}.bad.markerEnd       = 'SS_Start'; 

config{45}.bad.dir_list        = 'all';

config{45}.bad.sample_list     = 'all'; 

config{45}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02718_1201
config{46}                     = configcommon;
config{46}.patientid	      = 'pat_02680_1158';
config{46}.patients_root_dir   = output_patients;
config{46}.triallist           = 1;
config{46}.rawdir              = fullfile(rootpath_data, config{46}.patientid,'eeg');
%SESSION PARAMETERS - ses-14
config{46}.sessionid           = 'ses-01';
config{46}.prefix              = 'pat_2680_ses01' 

config{46}.datasavedir         = fullfile(datasavedir, config{46}.patientid, config{46}.sessionid);
config{46}.imagesavedir        = fullfile(imagesavedir, config{46}.prefix);

config{46}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{46}.circus.channel      			= {'mHaT2_4'};
config{46}.circus.outputdir    			= config{46}.datasavedir;
config{46}.circus.params.detection.spike_thresh  = '8';
config{46}.circus.params.clustering.nb_repeats   = '10';
config{46}.circus.params.clustering.max_elts     = '20000';

config{46}.bad.markerStart     = 'begin';
config{46}.bad.markerEnd       = 'SS_Start'; 

config{46}.bad.dir_list        = 'all';

config{46}.bad.sample_list     = 'all'; 

config{46}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_02757_1244
config{47}                     = configcommon;
config{47}.patientid	      = 'pat_02680_1158';
config{47}.patients_root_dir   = output_patients;
config{47}.triallist           = 1;
config{47}.rawdir              = fullfile(rootpath_data, config{47}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{47}.sessionid           = 'ses-01';
config{47}.prefix              = 'pat_2680_ses01' 

config{47}.datasavedir         = fullfile(datasavedir, config{47}.patientid, config{47}.sessionid);
config{47}.imagesavedir        = fullfile(imagesavedir, config{47}.prefix);

config{47}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{47}.circus.channel      			= {'mHaT2_4'};
config{47}.circus.outputdir    			= config{47}.datasavedir;
config{47}.circus.params.detection.spike_thresh  = '8';
config{47}.circus.params.clustering.nb_repeats   = '10';
config{47}.circus.params.clustering.max_elts     = '20000';

config{47}.bad.markerStart     = 'begin';
config{47}.bad.markerEnd       = 'SS_Start'; 

config{47}.bad.dir_list        = 'all';

config{47}.bad.sample_list     = 'all'; 

config{47}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02757_1244
config{48}                     = configcommon;
config{48}.patientid	      = 'pat_02680_1158';
config{48}.patients_root_dir   = output_patients;
config{48}.triallist           = 1;
config{48}.rawdir              = fullfile(rootpath_data, config{48}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{48}.sessionid           = 'ses-01';
config{48}.prefix              = 'pat_2680_ses01' 

config{48}.datasavedir         = fullfile(datasavedir, config{48}.patientid, config{48}.sessionid);
config{48}.imagesavedir        = fullfile(imagesavedir, config{48}.prefix);

config{48}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{48}.circus.channel      			= {'mHaT2_4'};
config{48}.circus.outputdir    			= config{48}.datasavedir;
config{48}.circus.params.detection.spike_thresh  = '8';
config{48}.circus.params.clustering.nb_repeats   = '10';
config{48}.circus.params.clustering.max_elts     = '20000';

config{48}.bad.markerStart     = 'begin';
config{48}.bad.markerEnd       = 'SS_Start'; 

config{48}.bad.dir_list        = 'all';

config{48}.bad.sample_list     = 'all'; 

config{48}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02757_1244
config{49}                     = configcommon;
config{49}.patientid	      = 'pat_02680_1158';
config{49}.patients_root_dir   = output_patients;
config{49}.triallist           = 1;
config{49}.rawdir              = fullfile(rootpath_data, config{49}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{49}.sessionid           = 'ses-01';
config{49}.prefix              = 'pat_2680_ses01' 

config{49}.datasavedir         = fullfile(datasavedir, config{49}.patientid, config{49}.sessionid);
config{49}.imagesavedir        = fullfile(imagesavedir, config{49}.prefix);

config{49}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{49}.circus.channel      			= {'mHaT2_4'};
config{49}.circus.outputdir    			= config{49}.datasavedir;
config{49}.circus.params.detection.spike_thresh  = '8';
config{49}.circus.params.clustering.nb_repeats   = '10';
config{49}.circus.params.clustering.max_elts     = '20000';

config{49}.bad.markerStart     = 'begin';
config{49}.bad.markerEnd       = 'SS_Start'; 

config{49}.bad.dir_list        = 'all';

config{49}.bad.sample_list     = 'all'; 

config{49}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02757_1244
config{50}                     = configcommon;
config{50}.patientid	      = 'pat_02680_1158';
config{50}.patients_root_dir   = output_patients;
config{50}.triallist           = 1;
config{50}.rawdir              = fullfile(rootpath_data, config{50}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{50}.sessionid           = 'ses-01';
config{50}.prefix              = 'pat_2680_ses01' 

config{50}.datasavedir         = fullfile(datasavedir, config{50}.patientid, config{50}.sessionid);
config{50}.imagesavedir        = fullfile(imagesavedir, config{50}.prefix);

config{50}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{50}.circus.channel      			= {'mHaT2_4'};
config{50}.circus.outputdir    			= config{50}.datasavedir;
config{50}.circus.params.detection.spike_thresh  = '8';
config{50}.circus.params.clustering.nb_repeats   = '10';
config{50}.circus.params.clustering.max_elts     = '20000';

config{50}.bad.markerStart     = 'begin';
config{50}.bad.markerEnd       = 'SS_Start'; 

config{50}.bad.dir_list        = 'all';

config{50}.bad.sample_list     = 'all'; 

config{50}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_02806_1302
config{51}                     = configcommon;
config{51}.patientid	      = 'pat_02680_1158';
config{51}.patients_root_dir   = output_patients;
config{51}.triallist           = 1;
config{51}.rawdir              = fullfile(rootpath_data, config{51}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{51}.sessionid           = 'ses-01';
config{51}.prefix              = 'pat_2680_ses01' 

config{51}.datasavedir         = fullfile(datasavedir, config{51}.patientid, config{51}.sessionid);
config{51}.imagesavedir        = fullfile(imagesavedir, config{51}.prefix);

config{51}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{51}.circus.channel      			= {'mHaT2_4'};
config{51}.circus.outputdir    			= config{51}.datasavedir;
config{51}.circus.params.detection.spike_thresh  = '8';
config{51}.circus.params.clustering.nb_repeats   = '10';
config{51}.circus.params.clustering.max_elts     = '20000';

config{51}.bad.markerStart     = 'begin';
config{51}.bad.markerEnd       = 'SS_Start'; 

config{51}.bad.dir_list        = 'all';

config{51}.bad.sample_list     = 'all'; 

config{51}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02806_1302
config{52}                     = configcommon;
config{52}.patientid	      = 'pat_02680_1158';
config{52}.patients_root_dir   = output_patients;
config{52}.triallist           = 1;
config{52}.rawdir              = fullfile(rootpath_data, config{52}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{52}.sessionid           = 'ses-01';
config{52}.prefix              = 'pat_2680_ses01' 

config{52}.datasavedir         = fullfile(datasavedir, config{52}.patientid, config{52}.sessionid);
config{52}.imagesavedir        = fullfile(imagesavedir, config{52}.prefix);

config{52}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{52}.circus.channel      			= {'mHaT2_4'};
config{52}.circus.outputdir    			= config{52}.datasavedir;
config{52}.circus.params.detection.spike_thresh  = '8';
config{52}.circus.params.clustering.nb_repeats   = '10';
config{52}.circus.params.clustering.max_elts     = '20000';

config{52}.bad.markerStart     = 'begin';
config{52}.bad.markerEnd       = 'SS_Start'; 

config{52}.bad.dir_list        = 'all';

config{52}.bad.sample_list     = 'all'; 

config{52}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%--------------------------------------------------------

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_02985_1405
config{53}                     = configcommon;
config{53}.patientid	      = 'pat_02680_1158';
config{53}.patients_root_dir   = output_patients;
config{53}.triallist           = 1;
config{53}.rawdir              = fullfile(rootpath_data, config{53}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{53}.sessionid           = 'ses-01';
config{53}.prefix              = 'pat_2680_ses01' 

config{53}.datasavedir         = fullfile(datasavedir, config{53}.patientid, config{53}.sessionid);
config{53}.imagesavedir        = fullfile(imagesavedir, config{53}.prefix);

config{53}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{53}.circus.channel      			= {'mHaT2_4'};
config{53}.circus.outputdir    			= config{53}.datasavedir;
config{53}.circus.params.detection.spike_thresh  = '8';
config{53}.circus.params.clustering.nb_repeats   = '10';
config{53}.circus.params.clustering.max_elts     = '20000';

config{53}.bad.markerStart     = 'begin';
config{53}.bad.markerEnd       = 'SS_Start'; 

config{53}.bad.dir_list        = 'all';

config{53}.bad.sample_list     = 'all'; 

config{53}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{54}                     = configcommon;
config{54}.patientid	      = 'pat_02680_1158';
config{54}.patients_root_dir   = output_patients;
config{54}.triallist           = 1;
config{54}.rawdir              = fullfile(rootpath_data, config{54}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{54}.sessionid           = 'ses-01';
config{54}.prefix              = 'pat_2680_ses01' 

config{54}.datasavedir         = fullfile(datasavedir, config{54}.patientid, config{54}.sessionid);
config{54}.imagesavedir        = fullfile(imagesavedir, config{54}.prefix);

config{54}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{54}.circus.channel      			= {'mHaT2_4'};
config{54}.circus.outputdir    			= config{54}.datasavedir;
config{54}.circus.params.detection.spike_thresh  = '8';
config{54}.circus.params.clustering.nb_repeats   = '10';
config{54}.circus.params.clustering.max_elts     = '20000';

config{54}.bad.markerStart     = 'begin';
config{54}.bad.markerEnd       = 'SS_Start'; 

config{54}.bad.dir_list        = 'all';

config{54}.bad.sample_list     = 'all'; 

config{54}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{55}                     = configcommon;
config{55}.patientid	      = 'pat_02680_1158';
config{55}.patients_root_dir   = output_patients;
config{55}.triallist           = 1;
config{55}.rawdir              = fullfile(rootpath_data, config{55}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{55}.sessionid           = 'ses-01';
config{55}.prefix              = 'pat_2680_ses01' 

config{55}.datasavedir         = fullfile(datasavedir, config{55}.patientid, config{55}.sessionid);
config{55}.imagesavedir        = fullfile(imagesavedir, config{55}.prefix);

config{55}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{55}.circus.channel      			= {'mHaT2_4'};
config{55}.circus.outputdir    			= config{55}.datasavedir;
config{55}.circus.params.detection.spike_thresh  = '8';
config{55}.circus.params.clustering.nb_repeats   = '10';
config{55}.circus.params.clustering.max_elts     = '20000';

config{55}.bad.markerStart     = 'begin';
config{55}.bad.markerEnd       = 'SS_Start'; 

config{55}.bad.dir_list        = 'all';

config{55}.bad.sample_list     = 'all'; 

config{55}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{56}                     = configcommon;
config{56}.patientid	      = 'pat_02680_1158';
config{56}.patients_root_dir   = output_patients;
config{56}.triallist           = 1;
config{56}.rawdir              = fullfile(rootpath_data, config{56}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{56}.sessionid           = 'ses-01';
config{56}.prefix              = 'pat_2680_ses01' 

config{56}.datasavedir         = fullfile(datasavedir, config{56}.patientid, config{56}.sessionid);
config{56}.imagesavedir        = fullfile(imagesavedir, config{56}.prefix);

config{56}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{56}.circus.channel      			= {'mHaT2_4'};
config{56}.circus.outputdir    			= config{56}.datasavedir;
config{56}.circus.params.detection.spike_thresh  = '8';
config{56}.circus.params.clustering.nb_repeats   = '10';
config{56}.circus.params.clustering.max_elts     = '20000';

config{56}.bad.markerStart     = 'begin';
config{56}.bad.markerEnd       = 'SS_Start'; 

config{56}.bad.dir_list        = 'all';

config{56}.bad.sample_list     = 'all'; 

config{56}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{57}                     = configcommon;
config{57}.patientid	      = 'pat_02680_1158';
config{57}.patients_root_dir   = output_patients;
config{57}.triallist           = 1;
config{57}.rawdir              = fullfile(rootpath_data, config{57}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{57}.sessionid           = 'ses-01';
config{57}.prefix              = 'pat_2680_ses01' 

config{57}.datasavedir         = fullfile(datasavedir, config{57}.patientid, config{57}.sessionid);
config{57}.imagesavedir        = fullfile(imagesavedir, config{57}.prefix);

config{57}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{57}.circus.channel      			= {'mHaT2_4'};
config{57}.circus.outputdir    			= config{57}.datasavedir;
config{57}.circus.params.detection.spike_thresh  = '8';
config{57}.circus.params.clustering.nb_repeats   = '10';
config{57}.circus.params.clustering.max_elts     = '20000';

config{57}.bad.markerStart     = 'begin';
config{57}.bad.markerEnd       = 'SS_Start'; 

config{57}.bad.dir_list        = 'all';

config{57}.bad.sample_list     = 'all'; 

config{57}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{58}                     = configcommon;
config{58}.patientid	      = 'pat_02680_1158';
config{58}.patients_root_dir   = output_patients;
config{58}.triallist           = 1;
config{58}.rawdir              = fullfile(rootpath_data, config{58}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{58}.sessionid           = 'ses-01';
config{58}.prefix              = 'pat_2680_ses01' 

config{58}.datasavedir         = fullfile(datasavedir, config{58}.patientid, config{58}.sessionid);
config{58}.imagesavedir        = fullfile(imagesavedir, config{58}.prefix);

config{58}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{58}.circus.channel      			= {'mHaT2_4'};
config{58}.circus.outputdir    			= config{58}.datasavedir;
config{58}.circus.params.detection.spike_thresh  = '8';
config{58}.circus.params.clustering.nb_repeats   = '10';
config{58}.circus.params.clustering.max_elts     = '20000';

config{58}.bad.markerStart     = 'begin';
config{58}.bad.markerEnd       = 'SS_Start'; 

config{58}.bad.dir_list        = 'all';

config{58}.bad.sample_list     = 'all'; 

config{58}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{59}                     = configcommon;
config{59}.patientid	      = 'pat_02680_1158';
config{59}.patients_root_dir   = output_patients;
config{59}.triallist           = 1;
config{59}.rawdir              = fullfile(rootpath_data, config{59}.patientid,'eeg');
%SESSION PARAMETERS - ses-07
config{59}.sessionid           = 'ses-01';
config{59}.prefix              = 'pat_2680_ses01' 

config{59}.datasavedir         = fullfile(datasavedir, config{59}.patientid, config{59}.sessionid);
config{59}.imagesavedir        = fullfile(imagesavedir, config{59}.prefix);

config{59}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{59}.circus.channel      			= {'mHaT2_4'};
config{59}.circus.outputdir    			= config{59}.datasavedir;
config{59}.circus.params.detection.spike_thresh  = '8';
config{59}.circus.params.clustering.nb_repeats   = '10';
config{59}.circus.params.clustering.max_elts     = '20000';

config{59}.bad.markerStart     = 'begin';
config{59}.bad.markerEnd       = 'SS_Start'; 

config{59}.bad.dir_list        = 'all';

config{59}.bad.sample_list     = 'all'; 

config{59}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{60}                     = configcommon;
config{60}.patientid	      = 'pat_02680_1158';
config{60}.patients_root_dir   = output_patients;
config{60}.triallist           = 1;
config{60}.rawdir              = fullfile(rootpath_data, config{60}.patientid,'eeg');
%SESSION PARAMETERS - ses-08
config{60}.sessionid           = 'ses-01';
config{60}.prefix              = 'pat_2680_ses01' 

config{60}.datasavedir         = fullfile(datasavedir, config{60}.patientid, config{60}.sessionid);
config{60}.imagesavedir        = fullfile(imagesavedir, config{60}.prefix);

config{60}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{60}.circus.channel      			= {'mHaT2_4'};
config{60}.circus.outputdir    			= config{60}.datasavedir;
config{60}.circus.params.detection.spike_thresh  = '8';
config{60}.circus.params.clustering.nb_repeats   = '10';
config{60}.circus.params.clustering.max_elts     = '20000';

config{60}.bad.markerStart     = 'begin';
config{60}.bad.markerEnd       = 'SS_Start'; 

config{60}.bad.dir_list        = 'all';

config{60}.bad.sample_list     = 'all'; 

config{60}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{61}                     = configcommon;
config{61}.patientid	      = 'pat_02680_1158';
config{61}.patients_root_dir   = output_patients;
config{61}.triallist           = 1;
config{61}.rawdir              = fullfile(rootpath_data, config{61}.patientid,'eeg');
%SESSION PARAMETERS - ses-09
config{61}.sessionid           = 'ses-01';
config{61}.prefix              = 'pat_2680_ses01' 

config{61}.datasavedir         = fullfile(datasavedir, config{61}.patientid, config{61}.sessionid);
config{61}.imagesavedir        = fullfile(imagesavedir, config{61}.prefix);

config{61}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{61}.circus.channel      			= {'mHaT2_4'};
config{61}.circus.outputdir    			= config{61}.datasavedir;
config{61}.circus.params.detection.spike_thresh  = '8';
config{61}.circus.params.clustering.nb_repeats   = '10';
config{61}.circus.params.clustering.max_elts     = '20000';

config{61}.bad.markerStart     = 'begin';
config{61}.bad.markerEnd       = 'SS_Start'; 

config{61}.bad.dir_list        = 'all';

config{61}.bad.sample_list     = 'all'; 

config{61}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{62}                     = configcommon;
config{62}.patientid	      = 'pat_02680_1158';
config{62}.patients_root_dir   = output_patients;
config{62}.triallist           = 1;
config{62}.rawdir              = fullfile(rootpath_data, config{62}.patientid,'eeg');
%SESSION PARAMETERS - ses-10
config{62}.sessionid           = 'ses-01';
config{62}.prefix              = 'pat_2680_ses01' 

config{62}.datasavedir         = fullfile(datasavedir, config{62}.patientid, config{62}.sessionid);
config{62}.imagesavedir        = fullfile(imagesavedir, config{62}.prefix);

config{62}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{62}.circus.channel      			= {'mHaT2_4'};
config{62}.circus.outputdir    			= config{62}.datasavedir;
config{62}.circus.params.detection.spike_thresh  = '8';
config{62}.circus.params.clustering.nb_repeats   = '10';
config{62}.circus.params.clustering.max_elts     = '20000';

config{62}.bad.markerStart     = 'begin';
config{62}.bad.markerEnd       = 'SS_Start'; 

config{62}.bad.dir_list        = 'all';

config{62}.bad.sample_list     = 'all'; 

config{62}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{63}                     = configcommon;
config{63}.patientid	      = 'pat_02680_1158';
config{63}.patients_root_dir   = output_patients;
config{63}.triallist           = 1;
config{63}.rawdir              = fullfile(rootpath_data, config{63}.patientid,'eeg');
%SESSION PARAMETERS - ses-11
config{63}.sessionid           = 'ses-01';
config{63}.prefix              = 'pat_2680_ses01' 

config{63}.datasavedir         = fullfile(datasavedir, config{63}.patientid, config{63}.sessionid);
config{63}.imagesavedir        = fullfile(imagesavedir, config{63}.prefix);

config{63}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{63}.circus.channel      			= {'mHaT2_4'};
config{63}.circus.outputdir    			= config{63}.datasavedir;
config{63}.circus.params.detection.spike_thresh  = '8';
config{63}.circus.params.clustering.nb_repeats   = '10';
config{63}.circus.params.clustering.max_elts     = '20000';

config{63}.bad.markerStart     = 'begin';
config{63}.bad.markerEnd       = 'SS_Start'; 

config{63}.bad.dir_list        = 'all';

config{63}.bad.sample_list     = 'all'; 

config{63}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{64}                     = configcommon;
config{64}.patientid	      = 'pat_02680_1158';
config{64}.patients_root_dir   = output_patients;
config{64}.triallist           = 1;
config{64}.rawdir              = fullfile(rootpath_data, config{64}.patientid,'eeg');
%SESSION PARAMETERS - ses-12
config{64}.sessionid           = 'ses-01';
config{64}.prefix              = 'pat_2680_ses01' 

config{64}.datasavedir         = fullfile(datasavedir, config{64}.patientid, config{64}.sessionid);
config{64}.imagesavedir        = fullfile(imagesavedir, config{64}.prefix);

config{64}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{64}.circus.channel      			= {'mHaT2_4'};
config{64}.circus.outputdir    			= config{64}.datasavedir;
config{64}.circus.params.detection.spike_thresh  = '8';
config{64}.circus.params.clustering.nb_repeats   = '10';
config{64}.circus.params.clustering.max_elts     = '20000';

config{64}.bad.markerStart     = 'begin';
config{64}.bad.markerEnd       = 'SS_Start'; 

config{64}.bad.dir_list        = 'all';

config{64}.bad.sample_list     = 'all'; 

config{64}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{65}                     = configcommon;
config{65}.patientid	      = 'pat_02680_1158';
config{65}.patients_root_dir   = output_patients;
config{65}.triallist           = 1;
config{65}.rawdir              = fullfile(rootpath_data, config{65}.patientid,'eeg');
%SESSION PARAMETERS - ses-13
config{65}.sessionid           = 'ses-01';
config{65}.prefix              = 'pat_2680_ses01' 

config{65}.datasavedir         = fullfile(datasavedir, config{65}.patientid, config{65}.sessionid);
config{65}.imagesavedir        = fullfile(imagesavedir, config{65}.prefix);

config{65}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{65}.circus.channel      			= {'mHaT2_4'};
config{65}.circus.outputdir    			= config{65}.datasavedir;
config{65}.circus.params.detection.spike_thresh  = '8';
config{65}.circus.params.clustering.nb_repeats   = '10';
config{65}.circus.params.clustering.max_elts     = '20000';

config{65}.bad.markerStart     = 'begin';
config{65}.bad.markerEnd       = 'SS_Start'; 

config{65}.bad.dir_list        = 'all';

config{65}.bad.sample_list     = 'all'; 

config{65}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{66}                     = configcommon;
config{66}.patientid	      = 'pat_02680_1158';
config{66}.patients_root_dir   = output_patients;
config{66}.triallist           = 1;
config{66}.rawdir              = fullfile(rootpath_data, config{66}.patientid,'eeg');
%SESSION PARAMETERS - ses-14
config{66}.sessionid           = 'ses-01';
config{66}.prefix              = 'pat_2680_ses01' 

config{66}.datasavedir         = fullfile(datasavedir, config{66}.patientid, config{66}.sessionid);
config{66}.imagesavedir        = fullfile(imagesavedir, config{66}.prefix);

config{66}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{66}.circus.channel      			= {'mHaT2_4'};
config{66}.circus.outputdir    			= config{66}.datasavedir;
config{66}.circus.params.detection.spike_thresh  = '8';
config{66}.circus.params.clustering.nb_repeats   = '10';
config{66}.circus.params.clustering.max_elts     = '20000';

config{66}.bad.markerStart     = 'begin';
config{66}.bad.markerEnd       = 'SS_Start'; 

config{66}.bad.dir_list        = 'all';

config{66}.bad.sample_list     = 'all'; 

config{66}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{67}                     = configcommon;
config{67}.patientid	      = 'pat_02680_1158';
config{67}.patients_root_dir   = output_patients;
config{67}.triallist           = 1;
config{67}.rawdir              = fullfile(rootpath_data, config{67}.patientid,'eeg');
%SESSION PARAMETERS - ses-15
config{67}.sessionid           = 'ses-01';
config{67}.prefix              = 'pat_2680_ses01' 

config{67}.datasavedir         = fullfile(datasavedir, config{67}.patientid, config{67}.sessionid);
config{67}.imagesavedir        = fullfile(imagesavedir, config{67}.prefix);

config{67}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{67}.circus.channel      			= {'mHaT2_4'};
config{67}.circus.outputdir    			= config{67}.datasavedir;
config{67}.circus.params.detection.spike_thresh  = '8';
config{67}.circus.params.clustering.nb_repeats   = '10';
config{67}.circus.params.clustering.max_elts     = '20000';

config{67}.bad.markerStart     = 'begin';
config{67}.bad.markerEnd       = 'SS_Start'; 

config{67}.bad.dir_list        = 'all';

config{67}.bad.sample_list     = 'all'; 

config{67}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{68}                     = configcommon;
config{68}.patientid	      = 'pat_02680_1158';
config{68}.patients_root_dir   = output_patients;
config{68}.triallist           = 1;
config{68}.rawdir              = fullfile(rootpath_data, config{68}.patientid,'eeg');
%SESSION PARAMETERS - ses-16
config{68}.sessionid           = 'ses-01';
config{68}.prefix              = 'pat_2680_ses01' 

config{68}.datasavedir         = fullfile(datasavedir, config{68}.patientid, config{68}.sessionid);
config{68}.imagesavedir        = fullfile(imagesavedir, config{68}.prefix);

config{68}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{68}.circus.channel      			= {'mHaT2_4'};
config{68}.circus.outputdir    			= config{68}.datasavedir;
config{68}.circus.params.detection.spike_thresh  = '8';
config{68}.circus.params.clustering.nb_repeats   = '10';
config{68}.circus.params.clustering.max_elts     = '20000';

config{68}.bad.markerStart     = 'begin';
config{68}.bad.markerEnd       = 'SS_Start'; 

config{68}.bad.dir_list        = 'all';

config{68}.bad.sample_list     = 'all'; 

config{68}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{69}                     = configcommon;
config{69}.patientid	      = 'pat_02680_1158';
config{69}.patients_root_dir   = output_patients;
config{69}.triallist           = 1;
config{69}.rawdir              = fullfile(rootpath_data, config{69}.patientid,'eeg');
%SESSION PARAMETERS - ses-17
config{69}.sessionid           = 'ses-01';
config{69}.prefix              = 'pat_2680_ses01' 

config{69}.datasavedir         = fullfile(datasavedir, config{69}.patientid, config{69}.sessionid);
config{69}.imagesavedir        = fullfile(imagesavedir, config{69}.prefix);

config{69}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{69}.circus.channel      			= {'mHaT2_4'};
config{69}.circus.outputdir    			= config{69}.datasavedir;
config{69}.circus.params.detection.spike_thresh  = '8';
config{69}.circus.params.clustering.nb_repeats   = '10';
config{69}.circus.params.clustering.max_elts     = '20000';

config{69}.bad.markerStart     = 'begin';
config{69}.bad.markerEnd       = 'SS_Start'; 

config{69}.bad.dir_list        = 'all';

config{69}.bad.sample_list     = 'all'; 

config{69}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{70}                     = configcommon;
config{70}.patientid	      = 'pat_02680_1158';
config{70}.patients_root_dir   = output_patients;
config{70}.triallist           = 1;
config{70}.rawdir              = fullfile(rootpath_data, config{70}.patientid,'eeg');
%SESSION PARAMETERS - ses-18
config{70}.sessionid           = 'ses-01';
config{70}.prefix              = 'pat_2680_ses01' 

config{70}.datasavedir         = fullfile(datasavedir, config{70}.patientid, config{70}.sessionid);
config{70}.imagesavedir        = fullfile(imagesavedir, config{70}.prefix);

config{70}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{70}.circus.channel      			= {'mHaT2_4'};
config{70}.circus.outputdir    			= config{70}.datasavedir;
config{70}.circus.params.detection.spike_thresh  = '8';
config{70}.circus.params.clustering.nb_repeats   = '10';
config{70}.circus.params.clustering.max_elts     = '20000';

config{70}.bad.markerStart     = 'begin';
config{70}.bad.markerEnd       = 'SS_Start'; 

config{70}.bad.dir_list        = 'all';

config{70}.bad.sample_list     = 'all'; 

config{70}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_02985_1405
config{71}                     = configcommon;
config{71}.patientid	      = 'pat_02680_1158';
config{71}.patients_root_dir   = output_patients;
config{71}.triallist           = 1;
config{71}.rawdir              = fullfile(rootpath_data, config{71}.patientid,'eeg');
%SESSION PARAMETERS - ses-19
config{71}.sessionid           = 'ses-01';
config{71}.prefix              = 'pat_2680_ses01' 

config{71}.datasavedir         = fullfile(datasavedir, config{71}.patientid, config{71}.sessionid);
config{71}.imagesavedir        = fullfile(imagesavedir, config{71}.prefix);

config{71}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{71}.circus.channel      			= {'mHaT2_4'};
config{71}.circus.outputdir    			= config{71}.datasavedir;
config{71}.circus.params.detection.spike_thresh  = '8';
config{71}.circus.params.clustering.nb_repeats   = '10';
config{71}.circus.params.clustering.max_elts     = '20000';

config{71}.bad.markerStart     = 'begin';
config{71}.bad.markerEnd       = 'SS_Start'; 

config{71}.bad.dir_list        = 'all';

config{71}.bad.sample_list     = 'all'; 

config{71}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_03012_1444
config{72}                     = configcommon;
config{72}.patientid	      = 'pat_02680_1158';
config{72}.patients_root_dir   = output_patients;
config{72}.triallist           = 1;
config{72}.rawdir              = fullfile(rootpath_data, config{72}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{72}.sessionid           = 'ses-01';
config{72}.prefix              = 'pat_2680_ses01' 

config{72}.datasavedir         = fullfile(datasavedir, config{72}.patientid, config{72}.sessionid);
config{72}.imagesavedir        = fullfile(imagesavedir, config{72}.prefix);

config{72}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{72}.circus.channel      			= {'mHaT2_4'};
config{72}.circus.outputdir    			= config{72}.datasavedir;
config{72}.circus.params.detection.spike_thresh  = '8';
config{72}.circus.params.clustering.nb_repeats   = '10';
config{72}.circus.params.clustering.max_elts     = '20000';

config{72}.bad.markerStart     = 'begin';
config{72}.bad.markerEnd       = 'SS_Start'; 

config{72}.bad.dir_list        = 'all';

config{72}.bad.sample_list     = 'all'; 

config{72}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03012_1444
config{73}                     = configcommon;
config{73}.patientid	      = 'pat_02680_1158';
config{73}.patients_root_dir   = output_patients;
config{73}.triallist           = 1;
config{73}.rawdir              = fullfile(rootpath_data, config{73}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{73}.sessionid           = 'ses-01';
config{73}.prefix              = 'pat_2680_ses01' 

config{73}.datasavedir         = fullfile(datasavedir, config{73}.patientid, config{73}.sessionid);
config{73}.imagesavedir        = fullfile(imagesavedir, config{73}.prefix);

config{73}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{73}.circus.channel      			= {'mHaT2_4'};
config{73}.circus.outputdir    			= config{73}.datasavedir;
config{73}.circus.params.detection.spike_thresh  = '8';
config{73}.circus.params.clustering.nb_repeats   = '10';
config{73}.circus.params.clustering.max_elts     = '20000';

config{73}.bad.markerStart     = 'begin';
config{73}.bad.markerEnd       = 'SS_Start'; 

config{73}.bad.dir_list        = 'all';

config{73}.bad.sample_list     = 'all'; 

config{73}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03012_1444
config{74}                     = configcommon;
config{74}.patientid	      = 'pat_02680_1158';
config{74}.patients_root_dir   = output_patients;
config{74}.triallist           = 1;
config{74}.rawdir              = fullfile(rootpath_data, config{74}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{74}.sessionid           = 'ses-01';
config{74}.prefix              = 'pat_2680_ses01' 

config{74}.datasavedir         = fullfile(datasavedir, config{74}.patientid, config{74}.sessionid);
config{74}.imagesavedir        = fullfile(imagesavedir, config{74}.prefix);

config{74}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{74}.circus.channel      			= {'mHaT2_4'};
config{74}.circus.outputdir    			= config{74}.datasavedir;
config{74}.circus.params.detection.spike_thresh  = '8';
config{74}.circus.params.clustering.nb_repeats   = '10';
config{74}.circus.params.clustering.max_elts     = '20000';

config{74}.bad.markerStart     = 'begin';
config{74}.bad.markerEnd       = 'SS_Start'; 

config{74}.bad.dir_list        = 'all';

config{74}.bad.sample_list     = 'all'; 

config{74}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03012_1444
config{75}                     = configcommon;
config{75}.patientid	      = 'pat_02680_1158';
config{75}.patients_root_dir   = output_patients;
config{75}.triallist           = 1;
config{75}.rawdir              = fullfile(rootpath_data, config{75}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{75}.sessionid           = 'ses-01';
config{75}.prefix              = 'pat_2680_ses01' 

config{75}.datasavedir         = fullfile(datasavedir, config{75}.patientid, config{75}.sessionid);
config{75}.imagesavedir        = fullfile(imagesavedir, config{75}.prefix);

config{75}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{75}.circus.channel      			= {'mHaT2_4'};
config{75}.circus.outputdir    			= config{75}.datasavedir;
config{75}.circus.params.detection.spike_thresh  = '8';
config{75}.circus.params.clustering.nb_repeats   = '10';
config{75}.circus.params.clustering.max_elts     = '20000';

config{75}.bad.markerStart     = 'begin';
config{75}.bad.markerEnd       = 'SS_Start'; 

config{75}.bad.dir_list        = 'all';

config{75}.bad.sample_list     = 'all'; 

config{75}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03012_1444
config{76}                     = configcommon;
config{76}.patientid	      = 'pat_02680_1158';
config{76}.patients_root_dir   = output_patients;
config{76}.triallist           = 1;
config{76}.rawdir              = fullfile(rootpath_data, config{76}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{76}.sessionid           = 'ses-01';
config{76}.prefix              = 'pat_2680_ses01' 

config{76}.datasavedir         = fullfile(datasavedir, config{76}.patientid, config{76}.sessionid);
config{76}.imagesavedir        = fullfile(imagesavedir, config{76}.prefix);

config{76}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{76}.circus.channel      			= {'mHaT2_4'};
config{76}.circus.outputdir    			= config{76}.datasavedir;
config{76}.circus.params.detection.spike_thresh  = '8';
config{76}.circus.params.clustering.nb_repeats   = '10';
config{76}.circus.params.clustering.max_elts     = '20000';

config{76}.bad.markerStart     = 'begin';
config{76}.bad.markerEnd       = 'SS_Start'; 

config{76}.bad.dir_list        = 'all';

config{76}.bad.sample_list     = 'all'; 

config{76}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03012_1444
config{77}                     = configcommon;
config{77}.patientid	      = 'pat_02680_1158';
config{77}.patients_root_dir   = output_patients;
config{77}.triallist           = 1;
config{77}.rawdir              = fullfile(rootpath_data, config{77}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{77}.sessionid           = 'ses-01';
config{77}.prefix              = 'pat_2680_ses01' 

config{77}.datasavedir         = fullfile(datasavedir, config{77}.patientid, config{77}.sessionid);
config{77}.imagesavedir        = fullfile(imagesavedir, config{77}.prefix);

config{77}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{77}.circus.channel      			= {'mHaT2_4'};
config{77}.circus.outputdir    			= config{77}.datasavedir;
config{77}.circus.params.detection.spike_thresh  = '8';
config{77}.circus.params.clustering.nb_repeats   = '10';
config{77}.circus.params.clustering.max_elts     = '20000';

config{77}.bad.markerStart     = 'begin';
config{77}.bad.markerEnd       = 'SS_Start'; 

config{77}.bad.dir_list        = 'all';

config{77}.bad.sample_list     = 'all'; 

config{77}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03012_1444
config{78}                     = configcommon;
config{78}.patientid	      = 'pat_02680_1158';
config{78}.patients_root_dir   = output_patients;
config{78}.triallist           = 1;
config{78}.rawdir              = fullfile(rootpath_data, config{78}.patientid,'eeg');
%SESSION PARAMETERS - ses-07
config{78}.sessionid           = 'ses-01';
config{78}.prefix              = 'pat_2680_ses01' 

config{78}.datasavedir         = fullfile(datasavedir, config{78}.patientid, config{78}.sessionid);
config{78}.imagesavedir        = fullfile(imagesavedir, config{78}.prefix);

config{78}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{78}.circus.channel      			= {'mHaT2_4'};
config{78}.circus.outputdir    			= config{78}.datasavedir;
config{78}.circus.params.detection.spike_thresh  = '8';
config{78}.circus.params.clustering.nb_repeats   = '10';
config{78}.circus.params.clustering.max_elts     = '20000';

config{78}.bad.markerStart     = 'begin';
config{78}.bad.markerEnd       = 'SS_Start'; 

config{78}.bad.dir_list        = 'all';

config{78}.bad.sample_list     = 'all'; 

config{78}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03012_1444
config{79}                     = configcommon;
config{79}.patientid	      = 'pat_02680_1158';
config{79}.patients_root_dir   = output_patients;
config{79}.triallist           = 1;
config{79}.rawdir              = fullfile(rootpath_data, config{79}.patientid,'eeg');
%SESSION PARAMETERS - ses-08
config{79}.sessionid           = 'ses-01';
config{79}.prefix              = 'pat_2680_ses01' 

config{79}.datasavedir         = fullfile(datasavedir, config{79}.patientid, config{79}.sessionid);
config{79}.imagesavedir        = fullfile(imagesavedir, config{79}.prefix);

config{79}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{79}.circus.channel      			= {'mHaT2_4'};
config{79}.circus.outputdir    			= config{79}.datasavedir;
config{79}.circus.params.detection.spike_thresh  = '8';
config{79}.circus.params.clustering.nb_repeats   = '10';
config{79}.circus.params.clustering.max_elts     = '20000';

config{79}.bad.markerStart     = 'begin';
config{79}.bad.markerEnd       = 'SS_Start'; 

config{79}.bad.dir_list        = 'all';

config{79}.bad.sample_list     = 'all'; 

config{79}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03012_1444
config{80}                     = configcommon;
config{80}.patientid	      = 'pat_02680_1158';
config{80}.patients_root_dir   = output_patients;
config{80}.triallist           = 1;
config{80}.rawdir              = fullfile(rootpath_data, config{80}.patientid,'eeg');
%SESSION PARAMETERS - ses-09
config{80}.sessionid           = 'ses-01';
config{80}.prefix              = 'pat_2680_ses01' 

config{80}.datasavedir         = fullfile(datasavedir, config{80}.patientid, config{80}.sessionid);
config{80}.imagesavedir        = fullfile(imagesavedir, config{80}.prefix);

config{80}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{80}.circus.channel      			= {'mHaT2_4'};
config{80}.circus.outputdir    			= config{80}.datasavedir;
config{80}.circus.params.detection.spike_thresh  = '8';
config{80}.circus.params.clustering.nb_repeats   = '10';
config{80}.circus.params.clustering.max_elts     = '20000';

config{80}.bad.markerStart     = 'begin';
config{80}.bad.markerEnd       = 'SS_Start'; 

config{80}.bad.dir_list        = 'all';

config{80}.bad.sample_list     = 'all'; 

config{80}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03012_1444
config{81}                     = configcommon;
config{81}.patientid	      = 'pat_02680_1158';
config{81}.patients_root_dir   = output_patients;
config{81}.triallist           = 1;
config{81}.rawdir              = fullfile(rootpath_data, config{81}.patientid,'eeg');
%SESSION PARAMETERS - ses-10
config{81}.sessionid           = 'ses-01';
config{81}.prefix              = 'pat_2680_ses01' 

config{81}.datasavedir         = fullfile(datasavedir, config{81}.patientid, config{81}.sessionid);
config{81}.imagesavedir        = fullfile(imagesavedir, config{81}.prefix);

config{81}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{81}.circus.channel      			= {'mHaT2_4'};
config{81}.circus.outputdir    			= config{81}.datasavedir;
config{81}.circus.params.detection.spike_thresh  = '8';
config{81}.circus.params.clustering.nb_repeats   = '10';
config{81}.circus.params.clustering.max_elts     = '20000';

config{81}.bad.markerStart     = 'begin';
config{81}.bad.markerEnd       = 'SS_Start'; 

config{81}.bad.dir_list        = 'all';

config{81}.bad.sample_list     = 'all'; 

config{81}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03012_1444
config{82}                     = configcommon;
config{82}.patientid	      = 'pat_02680_1158';
config{82}.patients_root_dir   = output_patients;
config{82}.triallist           = 1;
config{82}.rawdir              = fullfile(rootpath_data, config{82}.patientid,'eeg');
%SESSION PARAMETERS - ses-11
config{82}.sessionid           = 'ses-01';
config{82}.prefix              = 'pat_2680_ses01' 

config{82}.datasavedir         = fullfile(datasavedir, config{82}.patientid, config{82}.sessionid);
config{82}.imagesavedir        = fullfile(imagesavedir, config{82}.prefix);

config{82}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{82}.circus.channel      			= {'mHaT2_4'};
config{82}.circus.outputdir    			= config{82}.datasavedir;
config{82}.circus.params.detection.spike_thresh  = '8';
config{82}.circus.params.clustering.nb_repeats   = '10';
config{82}.circus.params.clustering.max_elts     = '20000';

config{82}.bad.markerStart     = 'begin';
config{82}.bad.markerEnd       = 'SS_Start'; 

config{82}.bad.dir_list        = 'all';

config{82}.bad.sample_list     = 'all'; 

config{82}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03012_1444
config{83}                     = configcommon;
config{83}.patientid	      = 'pat_02680_1158';
config{83}.patients_root_dir   = output_patients;
config{83}.triallist           = 1;
config{83}.rawdir              = fullfile(rootpath_data, config{83}.patientid,'eeg');
%SESSION PARAMETERS - ses-12
config{83}.sessionid           = 'ses-01';
config{83}.prefix              = 'pat_2680_ses01' 

config{83}.datasavedir         = fullfile(datasavedir, config{83}.patientid, config{83}.sessionid);
config{83}.imagesavedir        = fullfile(imagesavedir, config{83}.prefix);

config{83}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{83}.circus.channel      			= {'mHaT2_4'};
config{83}.circus.outputdir    			= config{83}.datasavedir;
config{83}.circus.params.detection.spike_thresh  = '8';
config{83}.circus.params.clustering.nb_repeats   = '10';
config{83}.circus.params.clustering.max_elts     = '20000';

config{83}.bad.markerStart     = 'begin';
config{83}.bad.markerEnd       = 'SS_Start'; 

config{83}.bad.dir_list        = 'all';

config{83}.bad.sample_list     = 'all'; 

config{83}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03012_1444
config{84}                     = configcommon;
config{84}.patientid	      = 'pat_02680_1158';
config{84}.patients_root_dir   = output_patients;
config{84}.triallist           = 1;
config{84}.rawdir              = fullfile(rootpath_data, config{84}.patientid,'eeg');
%SESSION PARAMETERS - ses-13
config{84}.sessionid           = 'ses-01';
config{84}.prefix              = 'pat_2680_ses01' 

config{84}.datasavedir         = fullfile(datasavedir, config{84}.patientid, config{84}.sessionid);
config{84}.imagesavedir        = fullfile(imagesavedir, config{84}.prefix);

config{84}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{84}.circus.channel      			= {'mHaT2_4'};
config{84}.circus.outputdir    			= config{84}.datasavedir;
config{84}.circus.params.detection.spike_thresh  = '8';
config{84}.circus.params.clustering.nb_repeats   = '10';
config{84}.circus.params.clustering.max_elts     = '20000';

config{84}.bad.markerStart     = 'begin';
config{84}.bad.markerEnd       = 'SS_Start'; 

config{84}.bad.dir_list        = 'all';

config{84}.bad.sample_list     = 'all'; 

config{84}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_03046_1482
config{85}                     = configcommon;
config{85}.patientid	      = 'pat_02680_1158';
config{85}.patients_root_dir   = output_patients;
config{85}.triallist           = 1;
config{85}.rawdir              = fullfile(rootpath_data, config{85}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{85}.sessionid           = 'ses-01';
config{85}.prefix              = 'pat_2680_ses01' 

config{85}.datasavedir         = fullfile(datasavedir, config{85}.patientid, config{85}.sessionid);
config{85}.imagesavedir        = fullfile(imagesavedir, config{85}.prefix);

config{85}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{85}.circus.channel      			= {'mHaT2_4'};
config{85}.circus.outputdir    			= config{85}.datasavedir;
config{85}.circus.params.detection.spike_thresh  = '8';
config{85}.circus.params.clustering.nb_repeats   = '10';
config{85}.circus.params.clustering.max_elts     = '20000';

config{85}.bad.markerStart     = 'begin';
config{85}.bad.markerEnd       = 'SS_Start'; 

config{85}.bad.dir_list        = 'all';

config{85}.bad.sample_list     = 'all'; 

config{85}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03046_1482
config{86}                     = configcommon;
config{86}.patientid	      = 'pat_02680_1158';
config{86}.patients_root_dir   = output_patients;
config{86}.triallist           = 1;
config{86}.rawdir              = fullfile(rootpath_data, config{86}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{86}.sessionid           = 'ses-01';
config{86}.prefix              = 'pat_2680_ses01' 

config{86}.datasavedir         = fullfile(datasavedir, config{86}.patientid, config{86}.sessionid);
config{86}.imagesavedir        = fullfile(imagesavedir, config{86}.prefix);

config{86}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{86}.circus.channel      			= {'mHaT2_4'};
config{86}.circus.outputdir    			= config{86}.datasavedir;
config{86}.circus.params.detection.spike_thresh  = '8';
config{86}.circus.params.clustering.nb_repeats   = '10';
config{86}.circus.params.clustering.max_elts     = '20000';

config{86}.bad.markerStart     = 'begin';
config{86}.bad.markerEnd       = 'SS_Start'; 

config{86}.bad.dir_list        = 'all';

config{86}.bad.sample_list     = 'all'; 

config{86}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03046_1482
config{87}                     = configcommon;
config{87}.patientid	      = 'pat_02680_1158';
config{87}.patients_root_dir   = output_patients;
config{87}.triallist           = 1;
config{87}.rawdir              = fullfile(rootpath_data, config{87}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{87}.sessionid           = 'ses-01';
config{87}.prefix              = 'pat_2680_ses01' 

config{87}.datasavedir         = fullfile(datasavedir, config{87}.patientid, config{87}.sessionid);
config{87}.imagesavedir        = fullfile(imagesavedir, config{87}.prefix);

config{87}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{87}.circus.channel      			= {'mHaT2_4'};
config{87}.circus.outputdir    			= config{87}.datasavedir;
config{87}.circus.params.detection.spike_thresh  = '8';
config{87}.circus.params.clustering.nb_repeats   = '10';
config{87}.circus.params.clustering.max_elts     = '20000';

config{87}.bad.markerStart     = 'begin';
config{87}.bad.markerEnd       = 'SS_Start'; 

config{87}.bad.dir_list        = 'all';

config{87}.bad.sample_list     = 'all'; 

config{87}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03046_1482
config{88}                     = configcommon;
config{88}.patientid	      = 'pat_02680_1158';
config{88}.patients_root_dir   = output_patients;
config{88}.triallist           = 1;
config{88}.rawdir              = fullfile(rootpath_data, config{88}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{88}.sessionid           = 'ses-01';
config{88}.prefix              = 'pat_2680_ses01' 

config{88}.datasavedir         = fullfile(datasavedir, config{88}.patientid, config{88}.sessionid);
config{88}.imagesavedir        = fullfile(imagesavedir, config{88}.prefix);

config{88}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{88}.circus.channel      			= {'mHaT2_4'};
config{88}.circus.outputdir    			= config{88}.datasavedir;
config{88}.circus.params.detection.spike_thresh  = '8';
config{88}.circus.params.clustering.nb_repeats   = '10';
config{88}.circus.params.clustering.max_elts     = '20000';

config{88}.bad.markerStart     = 'begin';
config{88}.bad.markerEnd       = 'SS_Start'; 

config{88}.bad.dir_list        = 'all';

config{88}.bad.sample_list     = 'all'; 

config{88}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03046_1482
config{89}                     = configcommon;
config{89}.patientid	      = 'pat_02680_1158';
config{89}.patients_root_dir   = output_patients;
config{89}.triallist           = 1;
config{89}.rawdir              = fullfile(rootpath_data, config{89}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{89}.sessionid           = 'ses-01';
config{89}.prefix              = 'pat_2680_ses01' 

config{89}.datasavedir         = fullfile(datasavedir, config{89}.patientid, config{89}.sessionid);
config{89}.imagesavedir        = fullfile(imagesavedir, config{89}.prefix);

config{89}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{89}.circus.channel      			= {'mHaT2_4'};
config{89}.circus.outputdir    			= config{89}.datasavedir;
config{89}.circus.params.detection.spike_thresh  = '8';
config{89}.circus.params.clustering.nb_repeats   = '10';
config{89}.circus.params.clustering.max_elts     = '20000';

config{89}.bad.markerStart     = 'begin';
config{89}.bad.markerEnd       = 'SS_Start'; 

config{89}.bad.dir_list        = 'all';

config{89}.bad.sample_list     = 'all'; 

config{89}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03046_1482
config{90}                     = configcommon;
config{90}.patientid	      = 'pat_02680_1158';
config{90}.patients_root_dir   = output_patients;
config{90}.triallist           = 1;
config{90}.rawdir              = fullfile(rootpath_data, config{90}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{90}.sessionid           = 'ses-01';
config{90}.prefix              = 'pat_2680_ses01' 

config{90}.datasavedir         = fullfile(datasavedir, config{90}.patientid, config{90}.sessionid);
config{90}.imagesavedir        = fullfile(imagesavedir, config{90}.prefix);

config{90}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{90}.circus.channel      			= {'mHaT2_4'};
config{90}.circus.outputdir    			= config{90}.datasavedir;
config{90}.circus.params.detection.spike_thresh  = '8';
config{90}.circus.params.clustering.nb_repeats   = '10';
config{90}.circus.params.clustering.max_elts     = '20000';

config{90}.bad.markerStart     = 'begin';
config{90}.bad.markerEnd       = 'SS_Start'; 

config{90}.bad.dir_list        = 'all';

config{90}.bad.sample_list     = 'all'; 

config{90}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03046_1482
config{91}                     = configcommon;
config{91}.patientid	      = 'pat_02680_1158';
config{91}.patients_root_dir   = output_patients;
config{91}.triallist           = 1;
config{91}.rawdir              = fullfile(rootpath_data, config{91}.patientid,'eeg');
%SESSION PARAMETERS - ses-07
config{91}.sessionid           = 'ses-01';
config{91}.prefix              = 'pat_2680_ses01' 

config{91}.datasavedir         = fullfile(datasavedir, config{91}.patientid, config{91}.sessionid);
config{91}.imagesavedir        = fullfile(imagesavedir, config{91}.prefix);

config{91}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{91}.circus.channel      			= {'mHaT2_4'};
config{91}.circus.outputdir    			= config{91}.datasavedir;
config{91}.circus.params.detection.spike_thresh  = '8';
config{91}.circus.params.clustering.nb_repeats   = '10';
config{91}.circus.params.clustering.max_elts     = '20000';

config{91}.bad.markerStart     = 'begin';
config{91}.bad.markerEnd       = 'SS_Start'; 

config{91}.bad.dir_list        = 'all';

config{91}.bad.sample_list     = 'all'; 

config{91}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03046_1482
config{92}                     = configcommon;
config{92}.patientid	      = 'pat_02680_1158';
config{92}.patients_root_dir   = output_patients;
config{92}.triallist           = 1;
config{92}.rawdir              = fullfile(rootpath_data, config{92}.patientid,'eeg');
%SESSION PARAMETERS - ses-08
config{92}.sessionid           = 'ses-01';
config{92}.prefix              = 'pat_2680_ses01' 

config{92}.datasavedir         = fullfile(datasavedir, config{92}.patientid, config{92}.sessionid);
config{92}.imagesavedir        = fullfile(imagesavedir, config{92}.prefix);

config{92}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{92}.circus.channel      			= {'mHaT2_4'};
config{92}.circus.outputdir    			= config{92}.datasavedir;
config{92}.circus.params.detection.spike_thresh  = '8';
config{92}.circus.params.clustering.nb_repeats   = '10';
config{92}.circus.params.clustering.max_elts     = '20000';

config{92}.bad.markerStart     = 'begin';
config{92}.bad.markerEnd       = 'SS_Start'; 

config{92}.bad.dir_list        = 'all';

config{92}.bad.sample_list     = 'all'; 

config{92}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03046_1482
config{93}                     = configcommon;
config{93}.patientid	      = 'pat_02680_1158';
config{93}.patients_root_dir   = output_patients;
config{93}.triallist           = 1;
config{93}.rawdir              = fullfile(rootpath_data, config{93}.patientid,'eeg');
%SESSION PARAMETERS - ses-09
config{93}.sessionid           = 'ses-01';
config{93}.prefix              = 'pat_2680_ses01' 

config{93}.datasavedir         = fullfile(datasavedir, config{93}.patientid, config{93}.sessionid);
config{93}.imagesavedir        = fullfile(imagesavedir, config{93}.prefix);

config{93}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{93}.circus.channel      			= {'mHaT2_4'};
config{93}.circus.outputdir    			= config{93}.datasavedir;
config{93}.circus.params.detection.spike_thresh  = '8';
config{93}.circus.params.clustering.nb_repeats   = '10';
config{93}.circus.params.clustering.max_elts     = '20000';

config{93}.bad.markerStart     = 'begin';
config{93}.bad.markerEnd       = 'SS_Start'; 

config{93}.bad.dir_list        = 'all';

config{93}.bad.sample_list     = 'all'; 

config{93}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03046_1482
config{94}                     = configcommon;
config{94}.patientid	      = 'pat_02680_1158';
config{94}.patients_root_dir   = output_patients;
config{94}.triallist           = 1;
config{94}.rawdir              = fullfile(rootpath_data, config{94}.patientid,'eeg');
%SESSION PARAMETERS - ses-10
config{94}.sessionid           = 'ses-01';
config{94}.prefix              = 'pat_2680_ses01' 

config{94}.datasavedir         = fullfile(datasavedir, config{94}.patientid, config{94}.sessionid);
config{94}.imagesavedir        = fullfile(imagesavedir, config{94}.prefix);

config{94}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{94}.circus.channel      			= {'mHaT2_4'};
config{94}.circus.outputdir    			= config{94}.datasavedir;
config{94}.circus.params.detection.spike_thresh  = '8';
config{94}.circus.params.clustering.nb_repeats   = '10';
config{94}.circus.params.clustering.max_elts     = '20000';

config{94}.bad.markerStart     = 'begin';
config{94}.bad.markerEnd       = 'SS_Start'; 

config{94}.bad.dir_list        = 'all';

config{94}.bad.sample_list     = 'all'; 

config{94}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03046_1482
config{95}                     = configcommon;
config{95}.patientid	      = 'pat_02680_1158';
config{95}.patients_root_dir   = output_patients;
config{95}.triallist           = 1;
config{95}.rawdir              = fullfile(rootpath_data, config{95}.patientid,'eeg');
%SESSION PARAMETERS - ses-11
config{95}.sessionid           = 'ses-01';
config{95}.prefix              = 'pat_2680_ses01' 

config{95}.datasavedir         = fullfile(datasavedir, config{95}.patientid, config{95}.sessionid);
config{95}.imagesavedir        = fullfile(imagesavedir, config{95}.prefix);

config{95}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{95}.circus.channel      			= {'mHaT2_4'};
config{95}.circus.outputdir    			= config{95}.datasavedir;
config{95}.circus.params.detection.spike_thresh  = '8';
config{95}.circus.params.clustering.nb_repeats   = '10';
config{95}.circus.params.clustering.max_elts     = '20000';

config{95}.bad.markerStart     = 'begin';
config{95}.bad.markerEnd       = 'SS_Start'; 

config{95}.bad.dir_list        = 'all';

config{95}.bad.sample_list     = 'all'; 

config{95}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03046_1482
config{96}                     = configcommon;
config{96}.patientid	      = 'pat_02680_1158';
config{96}.patients_root_dir   = output_patients;
config{96}.triallist           = 1;
config{96}.rawdir              = fullfile(rootpath_data, config{96}.patientid,'eeg');
%SESSION PARAMETERS - ses-12
config{96}.sessionid           = 'ses-01';
config{96}.prefix              = 'pat_2680_ses01' 

config{96}.datasavedir         = fullfile(datasavedir, config{96}.patientid, config{96}.sessionid);
config{96}.imagesavedir        = fullfile(imagesavedir, config{96}.prefix);

config{96}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{96}.circus.channel      			= {'mHaT2_4'};
config{96}.circus.outputdir    			= config{96}.datasavedir;
config{96}.circus.params.detection.spike_thresh  = '8';
config{96}.circus.params.clustering.nb_repeats   = '10';
config{96}.circus.params.clustering.max_elts     = '20000';

config{96}.bad.markerStart     = 'begin';
config{96}.bad.markerEnd       = 'SS_Start'; 

config{96}.bad.dir_list        = 'all';

config{96}.bad.sample_list     = 'all'; 

config{96}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03046_1482
config{97}                     = configcommon;
config{97}.patientid	      = 'pat_02680_1158';
config{97}.patients_root_dir   = output_patients;
config{97}.triallist           = 1;
config{97}.rawdir              = fullfile(rootpath_data, config{97}.patientid,'eeg');
%SESSION PARAMETERS - ses-13
config{97}.sessionid           = 'ses-01';
config{97}.prefix              = 'pat_2680_ses01' 

config{97}.datasavedir         = fullfile(datasavedir, config{97}.patientid, config{97}.sessionid);
config{97}.imagesavedir        = fullfile(imagesavedir, config{97}.prefix);

config{97}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{97}.circus.channel      			= {'mHaT2_4'};
config{97}.circus.outputdir    			= config{97}.datasavedir;
config{97}.circus.params.detection.spike_thresh  = '8';
config{97}.circus.params.clustering.nb_repeats   = '10';
config{97}.circus.params.clustering.max_elts     = '20000';

config{97}.bad.markerStart     = 'begin';
config{97}.bad.markerEnd       = 'SS_Start'; 

config{97}.bad.dir_list        = 'all';

config{97}.bad.sample_list     = 'all'; 

config{97}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_03065_1503
config{98}                     = configcommon;
config{98}.patientid	      = 'pat_02680_1158';
config{98}.patients_root_dir   = output_patients;
config{98}.triallist           = 1;
config{98}.rawdir              = fullfile(rootpath_data, config{98}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{98}.sessionid           = 'ses-01';
config{98}.prefix              = 'pat_2680_ses01' 

config{98}.datasavedir         = fullfile(datasavedir, config{98}.patientid, config{98}.sessionid);
config{98}.imagesavedir        = fullfile(imagesavedir, config{98}.prefix);

config{98}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{98}.circus.channel      			= {'mHaT2_4'};
config{98}.circus.outputdir    			= config{98}.datasavedir;
config{98}.circus.params.detection.spike_thresh  = '8';
config{98}.circus.params.clustering.nb_repeats   = '10';
config{98}.circus.params.clustering.max_elts     = '20000';

config{98}.bad.markerStart     = 'begin';
config{98}.bad.markerEnd       = 'SS_Start'; 

config{98}.bad.dir_list        = 'all';

config{98}.bad.sample_list     = 'all'; 

config{98}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03065_1503
config{99}                     = configcommon;
config{99}.patientid	      = 'pat_02680_1158';
config{99}.patients_root_dir   = output_patients;
config{99}.triallist           = 1;
config{99}.rawdir              = fullfile(rootpath_data, config{99}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{99}.sessionid           = 'ses-01';
config{99}.prefix              = 'pat_2680_ses01' 

config{99}.datasavedir         = fullfile(datasavedir, config{99}.patientid, config{99}.sessionid);
config{99}.imagesavedir        = fullfile(imagesavedir, config{99}.prefix);

config{99}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{99}.circus.channel      			= {'mHaT2_4'};
config{99}.circus.outputdir    			= config{99}.datasavedir;
config{99}.circus.params.detection.spike_thresh  = '8';
config{99}.circus.params.clustering.nb_repeats   = '10';
config{99}.circus.params.clustering.max_elts     = '20000';

config{99}.bad.markerStart     = 'begin';
config{99}.bad.markerEnd       = 'SS_Start'; 

config{99}.bad.dir_list        = 'all';

config{99}.bad.sample_list     = 'all'; 

config{99}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03065_1503
config{100}                     = configcommon;
config{100}.patientid	      = 'pat_02680_1158';
config{100}.patients_root_dir   = output_patients;
config{100}.triallist           = 1;
config{100}.rawdir              = fullfile(rootpath_data, config{100}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{100}.sessionid           = 'ses-01';
config{100}.prefix              = 'pat_2680_ses01' 

config{100}.datasavedir         = fullfile(datasavedir, config{100}.patientid, config{100}.sessionid);
config{100}.imagesavedir        = fullfile(imagesavedir, config{100}.prefix);

config{100}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{100}.circus.channel      			= {'mHaT2_4'};
config{100}.circus.outputdir    			= config{100}.datasavedir;
config{100}.circus.params.detection.spike_thresh  = '8';
config{100}.circus.params.clustering.nb_repeats   = '10';
config{100}.circus.params.clustering.max_elts     = '20000';

config{100}.bad.markerStart     = 'begin';
config{100}.bad.markerEnd       = 'SS_Start'; 

config{100}.bad.dir_list        = 'all';

config{100}.bad.sample_list     = 'all'; 

config{100}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_03083_1527
config{101}                     = configcommon;
config{101}.patientid	      = 'pat_02680_1158';
config{101}.patients_root_dir   = output_patients;
config{101}.triallist           = 1;
config{101}.rawdir              = fullfile(rootpath_data, config{101}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{101}.sessionid           = 'ses-01';
config{101}.prefix              = 'pat_2680_ses01' 

config{101}.datasavedir         = fullfile(datasavedir, config{101}.patientid, config{101}.sessionid);
config{101}.imagesavedir        = fullfile(imagesavedir, config{101}.prefix);

config{101}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{101}.circus.channel      			= {'mHaT2_4'};
config{101}.circus.outputdir    			= config{101}.datasavedir;
config{101}.circus.params.detection.spike_thresh  = '8';
config{101}.circus.params.clustering.nb_repeats   = '10';
config{101}.circus.params.clustering.max_elts     = '20000';

config{101}.bad.markerStart     = 'begin';
config{101}.bad.markerEnd       = 'SS_Start'; 

config{101}.bad.dir_list        = 'all';

config{101}.bad.sample_list     = 'all'; 

config{101}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03083_1527
config{102}                     = configcommon;
config{102}.patientid	      = 'pat_02680_1158';
config{102}.patients_root_dir   = output_patients;
config{102}.triallist           = 1;
config{102}.rawdir              = fullfile(rootpath_data, config{102}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{102}.sessionid           = 'ses-01';
config{102}.prefix              = 'pat_2680_ses01' 

config{102}.datasavedir         = fullfile(datasavedir, config{102}.patientid, config{102}.sessionid);
config{102}.imagesavedir        = fullfile(imagesavedir, config{102}.prefix);

config{102}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{102}.circus.channel      			= {'mHaT2_4'};
config{102}.circus.outputdir    			= config{102}.datasavedir;
config{102}.circus.params.detection.spike_thresh  = '8';
config{102}.circus.params.clustering.nb_repeats   = '10';
config{102}.circus.params.clustering.max_elts     = '20000';

config{102}.bad.markerStart     = 'begin';
config{102}.bad.markerEnd       = 'SS_Start'; 

config{102}.bad.dir_list        = 'all';

config{102}.bad.sample_list     = 'all'; 

config{102}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03083_1527
config{103}                     = configcommon;
config{103}.patientid	      = 'pat_02680_1158';
config{103}.patients_root_dir   = output_patients;
config{103}.triallist           = 1;
config{103}.rawdir              = fullfile(rootpath_data, config{103}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{103}.sessionid           = 'ses-01';
config{103}.prefix              = 'pat_2680_ses01' 

config{103}.datasavedir         = fullfile(datasavedir, config{103}.patientid, config{103}.sessionid);
config{103}.imagesavedir        = fullfile(imagesavedir, config{103}.prefix);

config{103}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{103}.circus.channel      			= {'mHaT2_4'};
config{103}.circus.outputdir    			= config{103}.datasavedir;
config{103}.circus.params.detection.spike_thresh  = '8';
config{103}.circus.params.clustering.nb_repeats   = '10';
config{103}.circus.params.clustering.max_elts     = '20000';

config{103}.bad.markerStart     = 'begin';
config{103}.bad.markerEnd       = 'SS_Start'; 

config{103}.bad.dir_list        = 'all';

config{103}.bad.sample_list     = 'all'; 

config{103}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03083_1527
config{104}                     = configcommon;
config{104}.patientid	      = 'pat_02680_1158';
config{104}.patients_root_dir   = output_patients;
config{104}.triallist           = 1;
config{104}.rawdir              = fullfile(rootpath_data, config{104}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{104}.sessionid           = 'ses-01';
config{104}.prefix              = 'pat_2680_ses01' 

config{104}.datasavedir         = fullfile(datasavedir, config{104}.patientid, config{104}.sessionid);
config{104}.imagesavedir        = fullfile(imagesavedir, config{104}.prefix);

config{104}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{104}.circus.channel      			= {'mHaT2_4'};
config{104}.circus.outputdir    			= config{104}.datasavedir;
config{104}.circus.params.detection.spike_thresh  = '8';
config{104}.circus.params.clustering.nb_repeats   = '10';
config{104}.circus.params.clustering.max_elts     = '20000';

config{104}.bad.markerStart     = 'begin';
config{104}.bad.markerEnd       = 'SS_Start'; 

config{104}.bad.dir_list        = 'all';

config{104}.bad.sample_list     = 'all'; 

config{104}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03083_1527
config{105}                     = configcommon;
config{105}.patientid	      = 'pat_02680_1158';
config{105}.patients_root_dir   = output_patients;
config{105}.triallist           = 1;
config{105}.rawdir              = fullfile(rootpath_data, config{105}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{105}.sessionid           = 'ses-01';
config{105}.prefix              = 'pat_2680_ses01' 

config{105}.datasavedir         = fullfile(datasavedir, config{105}.patientid, config{105}.sessionid);
config{105}.imagesavedir        = fullfile(imagesavedir, config{105}.prefix);

config{105}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{105}.circus.channel      			= {'mHaT2_4'};
config{105}.circus.outputdir    			= config{105}.datasavedir;
config{105}.circus.params.detection.spike_thresh  = '8';
config{105}.circus.params.clustering.nb_repeats   = '10';
config{105}.circus.params.clustering.max_elts     = '20000';

config{105}.bad.markerStart     = 'begin';
config{105}.bad.markerEnd       = 'SS_Start'; 

config{105}.bad.dir_list        = 'all';

config{105}.bad.sample_list     = 'all'; 

config{105}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03083_1527
config{106}                     = configcommon;
config{106}.patientid	      = 'pat_02680_1158';
config{106}.patients_root_dir   = output_patients;
config{106}.triallist           = 1;
config{106}.rawdir              = fullfile(rootpath_data, config{106}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{106}.sessionid           = 'ses-01';
config{106}.prefix              = 'pat_2680_ses01' 

config{106}.datasavedir         = fullfile(datasavedir, config{106}.patientid, config{106}.sessionid);
config{106}.imagesavedir        = fullfile(imagesavedir, config{106}.prefix);

config{106}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{106}.circus.channel      			= {'mHaT2_4'};
config{106}.circus.outputdir    			= config{106}.datasavedir;
config{106}.circus.params.detection.spike_thresh  = '8';
config{106}.circus.params.clustering.nb_repeats   = '10';
config{106}.circus.params.clustering.max_elts     = '20000';

config{106}.bad.markerStart     = 'begin';
config{106}.bad.markerEnd       = 'SS_Start'; 

config{106}.bad.dir_list        = 'all';

config{106}.bad.sample_list     = 'all'; 

config{106}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03083_1527
config{107}                     = configcommon;
config{107}.patientid	      = 'pat_02680_1158';
config{107}.patients_root_dir   = output_patients;
config{107}.triallist           = 1;
config{107}.rawdir              = fullfile(rootpath_data, config{107}.patientid,'eeg');
%SESSION PARAMETERS - ses-07
config{107}.sessionid           = 'ses-01';
config{107}.prefix              = 'pat_2680_ses01' 

config{107}.datasavedir         = fullfile(datasavedir, config{107}.patientid, config{107}.sessionid);
config{107}.imagesavedir        = fullfile(imagesavedir, config{107}.prefix);

config{107}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{107}.circus.channel      			= {'mHaT2_4'};
config{107}.circus.outputdir    			= config{107}.datasavedir;
config{107}.circus.params.detection.spike_thresh  = '8';
config{107}.circus.params.clustering.nb_repeats   = '10';
config{107}.circus.params.clustering.max_elts     = '20000';

config{107}.bad.markerStart     = 'begin';
config{107}.bad.markerEnd       = 'SS_Start'; 

config{107}.bad.dir_list        = 'all';

config{107}.bad.sample_list     = 'all'; 

config{107}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03083_1527
config{108}                     = configcommon;
config{108}.patientid	      = 'pat_02680_1158';
config{108}.patients_root_dir   = output_patients;
config{108}.triallist           = 1;
config{108}.rawdir              = fullfile(rootpath_data, config{108}.patientid,'eeg');
%SESSION PARAMETERS - ses-08
config{108}.sessionid           = 'ses-01';
config{108}.prefix              = 'pat_2680_ses01' 

config{108}.datasavedir         = fullfile(datasavedir, config{108}.patientid, config{108}.sessionid);
config{108}.imagesavedir        = fullfile(imagesavedir, config{108}.prefix);

config{108}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{108}.circus.channel      			= {'mHaT2_4'};
config{108}.circus.outputdir    			= config{108}.datasavedir;
config{108}.circus.params.detection.spike_thresh  = '8';
config{108}.circus.params.clustering.nb_repeats   = '10';
config{108}.circus.params.clustering.max_elts     = '20000';

config{108}.bad.markerStart     = 'begin';
config{108}.bad.markerEnd       = 'SS_Start'; 

config{108}.bad.dir_list        = 'all';

config{108}.bad.sample_list     = 'all'; 

config{108}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03083_1527
config{109}                     = configcommon;
config{109}.patientid	      = 'pat_02680_1158';
config{109}.patients_root_dir   = output_patients;
config{109}.triallist           = 1;
config{109}.rawdir              = fullfile(rootpath_data, config{109}.patientid,'eeg');
%SESSION PARAMETERS - ses-09
config{109}.sessionid           = 'ses-01';
config{109}.prefix              = 'pat_2680_ses01' 

config{109}.datasavedir         = fullfile(datasavedir, config{109}.patientid, config{109}.sessionid);
config{109}.imagesavedir        = fullfile(imagesavedir, config{109}.prefix);

config{109}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{109}.circus.channel      			= {'mHaT2_4'};
config{109}.circus.outputdir    			= config{109}.datasavedir;
config{109}.circus.params.detection.spike_thresh  = '8';
config{109}.circus.params.clustering.nb_repeats   = '10';
config{109}.circus.params.clustering.max_elts     = '20000';

config{109}.bad.markerStart     = 'begin';
config{109}.bad.markerEnd       = 'SS_Start'; 

config{109}.bad.dir_list        = 'all';

config{109}.bad.sample_list     = 'all'; 

config{109}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03083_1527
config{110}                     = configcommon;
config{110}.patientid	      = 'pat_02680_1158';
config{110}.patients_root_dir   = output_patients;
config{110}.triallist           = 1;
config{110}.rawdir              = fullfile(rootpath_data, config{110}.patientid,'eeg');
%SESSION PARAMETERS - ses-10
config{110}.sessionid           = 'ses-01';
config{110}.prefix              = 'pat_2680_ses01' 

config{110}.datasavedir         = fullfile(datasavedir, config{110}.patientid, config{110}.sessionid);
config{110}.imagesavedir        = fullfile(imagesavedir, config{110}.prefix);

config{110}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{110}.circus.channel      			= {'mHaT2_4'};
config{110}.circus.outputdir    			= config{110}.datasavedir;
config{110}.circus.params.detection.spike_thresh  = '8';
config{110}.circus.params.clustering.nb_repeats   = '10';
config{110}.circus.params.clustering.max_elts     = '20000';

config{110}.bad.markerStart     = 'begin';
config{110}.bad.markerEnd       = 'SS_Start'; 

config{110}.bad.dir_list        = 'all';

config{110}.bad.sample_list     = 'all'; 

config{110}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03083_1527
config{111}                     = configcommon;
config{111}.patientid	      = 'pat_02680_1158';
config{111}.patients_root_dir   = output_patients;
config{111}.triallist           = 1;
config{111}.rawdir              = fullfile(rootpath_data, config{111}.patientid,'eeg');
%SESSION PARAMETERS - ses-11
config{111}.sessionid           = 'ses-01';
config{111}.prefix              = 'pat_2680_ses01' 

config{111}.datasavedir         = fullfile(datasavedir, config{111}.patientid, config{111}.sessionid);
config{111}.imagesavedir        = fullfile(imagesavedir, config{111}.prefix);

config{111}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{111}.circus.channel      			= {'mHaT2_4'};
config{111}.circus.outputdir    			= config{111}.datasavedir;
config{111}.circus.params.detection.spike_thresh  = '8';
config{111}.circus.params.clustering.nb_repeats   = '10';
config{111}.circus.params.clustering.max_elts     = '20000';

config{111}.bad.markerStart     = 'begin';
config{111}.bad.markerEnd       = 'SS_Start'; 

config{111}.bad.dir_list        = 'all';

config{111}.bad.sample_list     = 'all'; 

config{111}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_03092_1538
config{112}                     = configcommon;
config{112}.patientid	      = 'pat_02680_1158';
config{112}.patients_root_dir   = output_patients;
config{112}.triallist           = 1;
config{112}.rawdir              = fullfile(rootpath_data, config{112}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{112}.sessionid           = 'ses-01';
config{112}.prefix              = 'pat_2680_ses01' 

config{112}.datasavedir         = fullfile(datasavedir, config{112}.patientid, config{112}.sessionid);
config{112}.imagesavedir        = fullfile(imagesavedir, config{112}.prefix);

config{112}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{112}.circus.channel      			= {'mHaT2_4'};
config{112}.circus.outputdir    			= config{112}.datasavedir;
config{112}.circus.params.detection.spike_thresh  = '8';
config{112}.circus.params.clustering.nb_repeats   = '10';
config{112}.circus.params.clustering.max_elts     = '20000';

config{112}.bad.markerStart     = 'begin';
config{112}.bad.markerEnd       = 'SS_Start'; 

config{112}.bad.dir_list        = 'all';

config{112}.bad.sample_list     = 'all'; 

config{112}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03092_1538
config{113}                     = configcommon;
config{113}.patientid	      = 'pat_02680_1158';
config{113}.patients_root_dir   = output_patients;
config{113}.triallist           = 1;
config{113}.rawdir              = fullfile(rootpath_data, config{113}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{113}.sessionid           = 'ses-01';
config{113}.prefix              = 'pat_2680_ses01' 

config{113}.datasavedir         = fullfile(datasavedir, config{113}.patientid, config{113}.sessionid);
config{113}.imagesavedir        = fullfile(imagesavedir, config{113}.prefix);

config{113}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{113}.circus.channel      			= {'mHaT2_4'};
config{113}.circus.outputdir    			= config{113}.datasavedir;
config{113}.circus.params.detection.spike_thresh  = '8';
config{113}.circus.params.clustering.nb_repeats   = '10';
config{113}.circus.params.clustering.max_elts     = '20000';

config{113}.bad.markerStart     = 'begin';
config{113}.bad.markerEnd       = 'SS_Start'; 

config{113}.bad.dir_list        = 'all';

config{113}.bad.sample_list     = 'all'; 

config{113}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03092_1538
config{114}                     = configcommon;
config{114}.patientid	      = 'pat_02680_1158';
config{114}.patients_root_dir   = output_patients;
config{114}.triallist           = 1;
config{114}.rawdir              = fullfile(rootpath_data, config{114}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{114}.sessionid           = 'ses-01';
config{114}.prefix              = 'pat_2680_ses01' 

config{114}.datasavedir         = fullfile(datasavedir, config{114}.patientid, config{114}.sessionid);
config{114}.imagesavedir        = fullfile(imagesavedir, config{114}.prefix);

config{114}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{114}.circus.channel      			= {'mHaT2_4'};
config{114}.circus.outputdir    			= config{114}.datasavedir;
config{114}.circus.params.detection.spike_thresh  = '8';
config{114}.circus.params.clustering.nb_repeats   = '10';
config{114}.circus.params.clustering.max_elts     = '20000';

config{114}.bad.markerStart     = 'begin';
config{114}.bad.markerEnd       = 'SS_Start'; 

config{114}.bad.dir_list        = 'all';

config{114}.bad.sample_list     = 'all'; 

config{114}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03092_1538
config{115}                     = configcommon;
config{115}.patientid	      = 'pat_02680_1158';
config{115}.patients_root_dir   = output_patients;
config{115}.triallist           = 1;
config{115}.rawdir              = fullfile(rootpath_data, config{115}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{115}.sessionid           = 'ses-01';
config{115}.prefix              = 'pat_2680_ses01' 

config{115}.datasavedir         = fullfile(datasavedir, config{115}.patientid, config{115}.sessionid);
config{115}.imagesavedir        = fullfile(imagesavedir, config{115}.prefix);

config{115}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{115}.circus.channel      			= {'mHaT2_4'};
config{115}.circus.outputdir    			= config{115}.datasavedir;
config{115}.circus.params.detection.spike_thresh  = '8';
config{115}.circus.params.clustering.nb_repeats   = '10';
config{115}.circus.params.clustering.max_elts     = '20000';

config{115}.bad.markerStart     = 'begin';
config{115}.bad.markerEnd       = 'SS_Start'; 

config{115}.bad.dir_list        = 'all';

config{115}.bad.sample_list     = 'all'; 

config{115}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03092_1538
config{116}                     = configcommon;
config{116}.patientid	      = 'pat_02680_1158';
config{116}.patients_root_dir   = output_patients;
config{116}.triallist           = 1;
config{116}.rawdir              = fullfile(rootpath_data, config{116}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{116}.sessionid           = 'ses-01';
config{116}.prefix              = 'pat_2680_ses01' 

config{116}.datasavedir         = fullfile(datasavedir, config{116}.patientid, config{116}.sessionid);
config{116}.imagesavedir        = fullfile(imagesavedir, config{116}.prefix);

config{116}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{116}.circus.channel      			= {'mHaT2_4'};
config{116}.circus.outputdir    			= config{116}.datasavedir;
config{116}.circus.params.detection.spike_thresh  = '8';
config{116}.circus.params.clustering.nb_repeats   = '10';
config{116}.circus.params.clustering.max_elts     = '20000';

config{116}.bad.markerStart     = 'begin';
config{116}.bad.markerEnd       = 'SS_Start'; 

config{116}.bad.dir_list        = 'all';

config{116}.bad.sample_list     = 'all'; 

config{116}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03092_1538
config{117}                     = configcommon;
config{117}.patientid	      = 'pat_02680_1158';
config{117}.patients_root_dir   = output_patients;
config{117}.triallist           = 1;
config{117}.rawdir              = fullfile(rootpath_data, config{117}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{117}.sessionid           = 'ses-01';
config{117}.prefix              = 'pat_2680_ses01' 

config{117}.datasavedir         = fullfile(datasavedir, config{117}.patientid, config{117}.sessionid);
config{117}.imagesavedir        = fullfile(imagesavedir, config{117}.prefix);

config{117}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{117}.circus.channel      			= {'mHaT2_4'};
config{117}.circus.outputdir    			= config{117}.datasavedir;
config{117}.circus.params.detection.spike_thresh  = '8';
config{117}.circus.params.clustering.nb_repeats   = '10';
config{117}.circus.params.clustering.max_elts     = '20000';

config{117}.bad.markerStart     = 'begin';
config{117}.bad.markerEnd       = 'SS_Start'; 

config{117}.bad.dir_list        = 'all';

config{117}.bad.sample_list     = 'all'; 

config{117}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_03105_1551
config{118}                     = configcommon;
config{118}.patientid	      = 'pat_02680_1158';
config{118}.patients_root_dir   = output_patients;
config{118}.triallist           = 1;
config{118}.rawdir              = fullfile(rootpath_data, config{118}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{118}.sessionid           = 'ses-01';
config{118}.prefix              = 'pat_2680_ses01' 

config{118}.datasavedir         = fullfile(datasavedir, config{118}.patientid, config{118}.sessionid);
config{118}.imagesavedir        = fullfile(imagesavedir, config{118}.prefix);

config{118}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{118}.circus.channel      			= {'mHaT2_4'};
config{118}.circus.outputdir    			= config{118}.datasavedir;
config{118}.circus.params.detection.spike_thresh  = '8';
config{118}.circus.params.clustering.nb_repeats   = '10';
config{118}.circus.params.clustering.max_elts     = '20000';

config{118}.bad.markerStart     = 'begin';
config{118}.bad.markerEnd       = 'SS_Start'; 

config{118}.bad.dir_list        = 'all';

config{118}.bad.sample_list     = 'all'; 

config{118}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03105_1551
config{119}                     = configcommon;
config{119}.patientid	      = 'pat_02680_1158';
config{119}.patients_root_dir   = output_patients;
config{119}.triallist           = 1;
config{119}.rawdir              = fullfile(rootpath_data, config{119}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{119}.sessionid           = 'ses-01';
config{119}.prefix              = 'pat_2680_ses01' 

config{119}.datasavedir         = fullfile(datasavedir, config{119}.patientid, config{119}.sessionid);
config{119}.imagesavedir        = fullfile(imagesavedir, config{119}.prefix);

config{119}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{119}.circus.channel      			= {'mHaT2_4'};
config{119}.circus.outputdir    			= config{119}.datasavedir;
config{119}.circus.params.detection.spike_thresh  = '8';
config{119}.circus.params.clustering.nb_repeats   = '10';
config{119}.circus.params.clustering.max_elts     = '20000';

config{119}.bad.markerStart     = 'begin';
config{119}.bad.markerEnd       = 'SS_Start'; 

config{119}.bad.dir_list        = 'all';

config{119}.bad.sample_list     = 'all'; 

config{119}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03105_1551
config{120}                     = configcommon;
config{120}.patientid	      = 'pat_02680_1158';
config{120}.patients_root_dir   = output_patients;
config{120}.triallist           = 1;
config{120}.rawdir              = fullfile(rootpath_data, config{120}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{120}.sessionid           = 'ses-01';
config{120}.prefix              = 'pat_2680_ses01' 

config{120}.datasavedir         = fullfile(datasavedir, config{120}.patientid, config{120}.sessionid);
config{120}.imagesavedir        = fullfile(imagesavedir, config{120}.prefix);

config{120}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{120}.circus.channel      			= {'mHaT2_4'};
config{120}.circus.outputdir    			= config{120}.datasavedir;
config{120}.circus.params.detection.spike_thresh  = '8';
config{120}.circus.params.clustering.nb_repeats   = '10';
config{120}.circus.params.clustering.max_elts     = '20000';

config{120}.bad.markerStart     = 'begin';
config{120}.bad.markerEnd       = 'SS_Start'; 

config{120}.bad.dir_list        = 'all';

config{120}.bad.sample_list     = 'all'; 

config{120}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03105_1551
config{121}                     = configcommon;
config{121}.patientid	      = 'pat_02680_1158';
config{121}.patients_root_dir   = output_patients;
config{121}.triallist           = 1;
config{121}.rawdir              = fullfile(rootpath_data, config{121}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{121}.sessionid           = 'ses-01';
config{121}.prefix              = 'pat_2680_ses01' 

config{121}.datasavedir         = fullfile(datasavedir, config{121}.patientid, config{121}.sessionid);
config{121}.imagesavedir        = fullfile(imagesavedir, config{121}.prefix);

config{121}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{121}.circus.channel      			= {'mHaT2_4'};
config{121}.circus.outputdir    			= config{121}.datasavedir;
config{121}.circus.params.detection.spike_thresh  = '8';
config{121}.circus.params.clustering.nb_repeats   = '10';
config{121}.circus.params.clustering.max_elts     = '20000';

config{121}.bad.markerStart     = 'begin';
config{121}.bad.markerEnd       = 'SS_Start'; 

config{121}.bad.dir_list        = 'all';

config{121}.bad.sample_list     = 'all'; 

config{121}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03105_1551
config{122}                     = configcommon;
config{122}.patientid	      = 'pat_02680_1158';
config{122}.patients_root_dir   = output_patients;
config{122}.triallist           = 1;
config{122}.rawdir              = fullfile(rootpath_data, config{122}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{122}.sessionid           = 'ses-01';
config{122}.prefix              = 'pat_2680_ses01' 

config{122}.datasavedir         = fullfile(datasavedir, config{122}.patientid, config{122}.sessionid);
config{122}.imagesavedir        = fullfile(imagesavedir, config{122}.prefix);

config{122}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{122}.circus.channel      			= {'mHaT2_4'};
config{122}.circus.outputdir    			= config{122}.datasavedir;
config{122}.circus.params.detection.spike_thresh  = '8';
config{122}.circus.params.clustering.nb_repeats   = '10';
config{122}.circus.params.clustering.max_elts     = '20000';

config{122}.bad.markerStart     = 'begin';
config{122}.bad.markerEnd       = 'SS_Start'; 

config{122}.bad.dir_list        = 'all';

config{122}.bad.sample_list     = 'all'; 

config{122}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03105_1551
config{123}                     = configcommon;
config{123}.patientid	      = 'pat_02680_1158';
config{123}.patients_root_dir   = output_patients;
config{123}.triallist           = 1;
config{123}.rawdir              = fullfile(rootpath_data, config{123}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{123}.sessionid           = 'ses-01';
config{123}.prefix              = 'pat_2680_ses01' 

config{123}.datasavedir         = fullfile(datasavedir, config{123}.patientid, config{123}.sessionid);
config{123}.imagesavedir        = fullfile(imagesavedir, config{123}.prefix);

config{123}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{123}.circus.channel      			= {'mHaT2_4'};
config{123}.circus.outputdir    			= config{123}.datasavedir;
config{123}.circus.params.detection.spike_thresh  = '8';
config{123}.circus.params.clustering.nb_repeats   = '10';
config{123}.circus.params.clustering.max_elts     = '20000';

config{123}.bad.markerStart     = 'begin';
config{123}.bad.markerEnd       = 'SS_Start'; 

config{123}.bad.dir_list        = 'all';

config{123}.bad.sample_list     = 'all'; 

config{123}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03105_1551
config{124}                     = configcommon;
config{124}.patientid	      = 'pat_02680_1158';
config{124}.patients_root_dir   = output_patients;
config{124}.triallist           = 1;
config{124}.rawdir              = fullfile(rootpath_data, config{124}.patientid,'eeg');
%SESSION PARAMETERS - ses-07
config{124}.sessionid           = 'ses-01';
config{124}.prefix              = 'pat_2680_ses01' 

config{124}.datasavedir         = fullfile(datasavedir, config{124}.patientid, config{124}.sessionid);
config{124}.imagesavedir        = fullfile(imagesavedir, config{124}.prefix);

config{124}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{124}.circus.channel      			= {'mHaT2_4'};
config{124}.circus.outputdir    			= config{124}.datasavedir;
config{124}.circus.params.detection.spike_thresh  = '8';
config{124}.circus.params.clustering.nb_repeats   = '10';
config{124}.circus.params.clustering.max_elts     = '20000';

config{124}.bad.markerStart     = 'begin';
config{124}.bad.markerEnd       = 'SS_Start'; 

config{124}.bad.dir_list        = 'all';

config{124}.bad.sample_list     = 'all'; 

config{124}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03105_1551
config{125}                     = configcommon;
config{125}.patientid	      = 'pat_02680_1158';
config{125}.patients_root_dir   = output_patients;
config{125}.triallist           = 1;
config{125}.rawdir              = fullfile(rootpath_data, config{125}.patientid,'eeg');
%SESSION PARAMETERS - ses-08
config{125}.sessionid           = 'ses-01';
config{125}.prefix              = 'pat_2680_ses01' 

config{125}.datasavedir         = fullfile(datasavedir, config{125}.patientid, config{125}.sessionid);
config{125}.imagesavedir        = fullfile(imagesavedir, config{125}.prefix);

config{125}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{125}.circus.channel      			= {'mHaT2_4'};
config{125}.circus.outputdir    			= config{125}.datasavedir;
config{125}.circus.params.detection.spike_thresh  = '8';
config{125}.circus.params.clustering.nb_repeats   = '10';
config{125}.circus.params.clustering.max_elts     = '20000';

config{125}.bad.markerStart     = 'begin';
config{125}.bad.markerEnd       = 'SS_Start'; 

config{125}.bad.dir_list        = 'all';

config{125}.bad.sample_list     = 'all'; 

config{125}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03105_1551
config{126}                     = configcommon;
config{126}.patientid	      = 'pat_02680_1158';
config{126}.patients_root_dir   = output_patients;
config{126}.triallist           = 1;
config{126}.rawdir              = fullfile(rootpath_data, config{126}.patientid,'eeg');
%SESSION PARAMETERS - ses-09
config{126}.sessionid           = 'ses-01';
config{126}.prefix              = 'pat_2680_ses01' 

config{126}.datasavedir         = fullfile(datasavedir, config{126}.patientid, config{126}.sessionid);
config{126}.imagesavedir        = fullfile(imagesavedir, config{126}.prefix);

config{126}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{126}.circus.channel      			= {'mHaT2_4'};
config{126}.circus.outputdir    			= config{126}.datasavedir;
config{126}.circus.params.detection.spike_thresh  = '8';
config{126}.circus.params.clustering.nb_repeats   = '10';
config{126}.circus.params.clustering.max_elts     = '20000';

config{126}.bad.markerStart     = 'begin';
config{126}.bad.markerEnd       = 'SS_Start'; 

config{126}.bad.dir_list        = 'all';

config{126}.bad.sample_list     = 'all'; 

config{126}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03105_1551
config{127}                     = configcommon;
config{127}.patientid	      = 'pat_02680_1158';
config{127}.patients_root_dir   = output_patients;
config{127}.triallist           = 1;
config{127}.rawdir              = fullfile(rootpath_data, config{127}.patientid,'eeg');
%SESSION PARAMETERS - ses-10
config{127}.sessionid           = 'ses-01';
config{127}.prefix              = 'pat_2680_ses01' 

config{127}.datasavedir         = fullfile(datasavedir, config{127}.patientid, config{127}.sessionid);
config{127}.imagesavedir        = fullfile(imagesavedir, config{127}.prefix);

config{127}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{127}.circus.channel      			= {'mHaT2_4'};
config{127}.circus.outputdir    			= config{127}.datasavedir;
config{127}.circus.params.detection.spike_thresh  = '8';
config{127}.circus.params.clustering.nb_repeats   = '10';
config{127}.circus.params.clustering.max_elts     = '20000';

config{127}.bad.markerStart     = 'begin';
config{127}.bad.markerEnd       = 'SS_Start'; 

config{127}.bad.dir_list        = 'all';

config{127}.bad.sample_list     = 'all'; 

config{127}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03105_1551
config{128}                     = configcommon;
config{128}.patientid	      = 'pat_02680_1158';
config{128}.patients_root_dir   = output_patients;
config{128}.triallist           = 1;
config{128}.rawdir              = fullfile(rootpath_data, config{128}.patientid,'eeg');
%SESSION PARAMETERS - ses-11
config{128}.sessionid           = 'ses-01';
config{128}.prefix              = 'pat_2680_ses01' 

config{128}.datasavedir         = fullfile(datasavedir, config{128}.patientid, config{128}.sessionid);
config{128}.imagesavedir        = fullfile(imagesavedir, config{128}.prefix);

config{128}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{128}.circus.channel      			= {'mHaT2_4'};
config{128}.circus.outputdir    			= config{128}.datasavedir;
config{128}.circus.params.detection.spike_thresh  = '8';
config{128}.circus.params.clustering.nb_repeats   = '10';
config{128}.circus.params.clustering.max_elts     = '20000';

config{128}.bad.markerStart     = 'begin';
config{128}.bad.markerEnd       = 'SS_Start'; 

config{128}.bad.dir_list        = 'all';

config{128}.bad.sample_list     = 'all'; 

config{128}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03105_1551
config{129}                     = configcommon;
config{129}.patientid	      = 'pat_02680_1158';
config{129}.patients_root_dir   = output_patients;
config{129}.triallist           = 1;
config{129}.rawdir              = fullfile(rootpath_data, config{129}.patientid,'eeg');
%SESSION PARAMETERS - ses-12
config{129}.sessionid           = 'ses-01';
config{129}.prefix              = 'pat_2680_ses01' 

config{129}.datasavedir         = fullfile(datasavedir, config{129}.patientid, config{129}.sessionid);
config{129}.imagesavedir        = fullfile(imagesavedir, config{129}.prefix);

config{129}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{129}.circus.channel      			= {'mHaT2_4'};
config{129}.circus.outputdir    			= config{129}.datasavedir;
config{129}.circus.params.detection.spike_thresh  = '8';
config{129}.circus.params.clustering.nb_repeats   = '10';
config{129}.circus.params.clustering.max_elts     = '20000';

config{129}.bad.markerStart     = 'begin';
config{129}.bad.markerEnd       = 'SS_Start'; 

config{129}.bad.dir_list        = 'all';

config{129}.bad.sample_list     = 'all'; 

config{129}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03105_1551
config{130}                     = configcommon;
config{130}.patientid	      = 'pat_02680_1158';
config{130}.patients_root_dir   = output_patients;
config{130}.triallist           = 1;
config{130}.rawdir              = fullfile(rootpath_data, config{130}.patientid,'eeg');
%SESSION PARAMETERS - ses-13
config{130}.sessionid           = 'ses-01';
config{130}.prefix              = 'pat_2680_ses01' 

config{130}.datasavedir         = fullfile(datasavedir, config{130}.patientid, config{130}.sessionid);
config{130}.imagesavedir        = fullfile(imagesavedir, config{130}.prefix);

config{130}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{130}.circus.channel      			= {'mHaT2_4'};
config{130}.circus.outputdir    			= config{130}.datasavedir;
config{130}.circus.params.detection.spike_thresh  = '8';
config{130}.circus.params.clustering.nb_repeats   = '10';
config{130}.circus.params.clustering.max_elts     = '20000';

config{130}.bad.markerStart     = 'begin';
config{130}.bad.markerEnd       = 'SS_Start'; 

config{130}.bad.dir_list        = 'all';

config{130}.bad.sample_list     = 'all'; 

config{130}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_03128_1591
config{131}                     = configcommon;
config{131}.patientid	      = 'pat_02680_1158';
config{131}.patients_root_dir   = output_patients;
config{131}.triallist           = 1;
config{131}.rawdir              = fullfile(rootpath_data, config{131}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{131}.sessionid           = 'ses-01';
config{131}.prefix              = 'pat_2680_ses01' 

config{131}.datasavedir         = fullfile(datasavedir, config{131}.patientid, config{131}.sessionid);
config{131}.imagesavedir        = fullfile(imagesavedir, config{131}.prefix);

config{131}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{131}.circus.channel      			= {'mHaT2_4'};
config{131}.circus.outputdir    			= config{131}.datasavedir;
config{131}.circus.params.detection.spike_thresh  = '8';
config{131}.circus.params.clustering.nb_repeats   = '10';
config{131}.circus.params.clustering.max_elts     = '20000';

config{131}.bad.markerStart     = 'begin';
config{131}.bad.markerEnd       = 'SS_Start'; 

config{131}.bad.dir_list        = 'all';

config{131}.bad.sample_list     = 'all'; 

config{131}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03128_1591
config{132}                     = configcommon;
config{132}.patientid	      = 'pat_02680_1158';
config{132}.patients_root_dir   = output_patients;
config{132}.triallist           = 1;
config{132}.rawdir              = fullfile(rootpath_data, config{132}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{132}.sessionid           = 'ses-01';
config{132}.prefix              = 'pat_2680_ses01' 

config{132}.datasavedir         = fullfile(datasavedir, config{132}.patientid, config{132}.sessionid);
config{132}.imagesavedir        = fullfile(imagesavedir, config{132}.prefix);

config{132}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{132}.circus.channel      			= {'mHaT2_4'};
config{132}.circus.outputdir    			= config{132}.datasavedir;
config{132}.circus.params.detection.spike_thresh  = '8';
config{132}.circus.params.clustering.nb_repeats   = '10';
config{132}.circus.params.clustering.max_elts     = '20000';

config{132}.bad.markerStart     = 'begin';
config{132}.bad.markerEnd       = 'SS_Start'; 

config{132}.bad.dir_list        = 'all';

config{132}.bad.sample_list     = 'all'; 

config{132}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03128_1591
config{133}                     = configcommon;
config{133}.patientid	      = 'pat_02680_1158';
config{133}.patients_root_dir   = output_patients;
config{133}.triallist           = 1;
config{133}.rawdir              = fullfile(rootpath_data, config{133}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{133}.sessionid           = 'ses-01';
config{133}.prefix              = 'pat_2680_ses01' 

config{133}.datasavedir         = fullfile(datasavedir, config{133}.patientid, config{133}.sessionid);
config{133}.imagesavedir        = fullfile(imagesavedir, config{133}.prefix);

config{133}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{133}.circus.channel      			= {'mHaT2_4'};
config{133}.circus.outputdir    			= config{133}.datasavedir;
config{133}.circus.params.detection.spike_thresh  = '8';
config{133}.circus.params.clustering.nb_repeats   = '10';
config{133}.circus.params.clustering.max_elts     = '20000';

config{133}.bad.markerStart     = 'begin';
config{133}.bad.markerEnd       = 'SS_Start'; 

config{133}.bad.dir_list        = 'all';

config{133}.bad.sample_list     = 'all'; 

config{133}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03128_1591
config{134}                     = configcommon;
config{134}.patientid	      = 'pat_02680_1158';
config{134}.patients_root_dir   = output_patients;
config{134}.triallist           = 1;
config{134}.rawdir              = fullfile(rootpath_data, config{134}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{134}.sessionid           = 'ses-01';
config{134}.prefix              = 'pat_2680_ses01' 

config{134}.datasavedir         = fullfile(datasavedir, config{134}.patientid, config{134}.sessionid);
config{134}.imagesavedir        = fullfile(imagesavedir, config{134}.prefix);

config{134}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{134}.circus.channel      			= {'mHaT2_4'};
config{134}.circus.outputdir    			= config{134}.datasavedir;
config{134}.circus.params.detection.spike_thresh  = '8';
config{134}.circus.params.clustering.nb_repeats   = '10';
config{134}.circus.params.clustering.max_elts     = '20000';

config{134}.bad.markerStart     = 'begin';
config{134}.bad.markerEnd       = 'SS_Start'; 

config{134}.bad.dir_list        = 'all';

config{134}.bad.sample_list     = 'all'; 

config{134}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03128_1591
config{135}                     = configcommon;
config{135}.patientid	      = 'pat_02680_1158';
config{135}.patients_root_dir   = output_patients;
config{135}.triallist           = 1;
config{135}.rawdir              = fullfile(rootpath_data, config{135}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{135}.sessionid           = 'ses-01';
config{135}.prefix              = 'pat_2680_ses01' 

config{135}.datasavedir         = fullfile(datasavedir, config{135}.patientid, config{135}.sessionid);
config{135}.imagesavedir        = fullfile(imagesavedir, config{135}.prefix);

config{135}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{135}.circus.channel      			= {'mHaT2_4'};
config{135}.circus.outputdir    			= config{135}.datasavedir;
config{135}.circus.params.detection.spike_thresh  = '8';
config{135}.circus.params.clustering.nb_repeats   = '10';
config{135}.circus.params.clustering.max_elts     = '20000';

config{135}.bad.markerStart     = 'begin';
config{135}.bad.markerEnd       = 'SS_Start'; 

config{135}.bad.dir_list        = 'all';

config{135}.bad.sample_list     = 'all'; 

config{135}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03128_1591
config{136}                     = configcommon;
config{136}.patientid	      = 'pat_02680_1158';
config{136}.patients_root_dir   = output_patients;
config{136}.triallist           = 1;
config{136}.rawdir              = fullfile(rootpath_data, config{136}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{136}.sessionid           = 'ses-01';
config{136}.prefix              = 'pat_2680_ses01' 

config{136}.datasavedir         = fullfile(datasavedir, config{136}.patientid, config{136}.sessionid);
config{136}.imagesavedir        = fullfile(imagesavedir, config{136}.prefix);

config{136}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{136}.circus.channel      			= {'mHaT2_4'};
config{136}.circus.outputdir    			= config{136}.datasavedir;
config{136}.circus.params.detection.spike_thresh  = '8';
config{136}.circus.params.clustering.nb_repeats   = '10';
config{136}.circus.params.clustering.max_elts     = '20000';

config{136}.bad.markerStart     = 'begin';
config{136}.bad.markerEnd       = 'SS_Start'; 

config{136}.bad.dir_list        = 'all';

config{136}.bad.sample_list     = 'all'; 

config{136}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03128_1591
config{137}                     = configcommon;
config{137}.patientid	      = 'pat_02680_1158';
config{137}.patients_root_dir   = output_patients;
config{137}.triallist           = 1;
config{137}.rawdir              = fullfile(rootpath_data, config{137}.patientid,'eeg');
%SESSION PARAMETERS - ses-07
config{137}.sessionid           = 'ses-01';
config{137}.prefix              = 'pat_2680_ses01' 

config{137}.datasavedir         = fullfile(datasavedir, config{137}.patientid, config{137}.sessionid);
config{137}.imagesavedir        = fullfile(imagesavedir, config{137}.prefix);

config{137}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{137}.circus.channel      			= {'mHaT2_4'};
config{137}.circus.outputdir    			= config{137}.datasavedir;
config{137}.circus.params.detection.spike_thresh  = '8';
config{137}.circus.params.clustering.nb_repeats   = '10';
config{137}.circus.params.clustering.max_elts     = '20000';

config{137}.bad.markerStart     = 'begin';
config{137}.bad.markerEnd       = 'SS_Start'; 

config{137}.bad.dir_list        = 'all';

config{137}.bad.sample_list     = 'all'; 

config{137}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03128_1591
config{138}                     = configcommon;
config{138}.patientid	      = 'pat_02680_1158';
config{138}.patients_root_dir   = output_patients;
config{138}.triallist           = 1;
config{138}.rawdir              = fullfile(rootpath_data, config{138}.patientid,'eeg');
%SESSION PARAMETERS - ses-08
config{138}.sessionid           = 'ses-01';
config{138}.prefix              = 'pat_2680_ses01' 

config{138}.datasavedir         = fullfile(datasavedir, config{138}.patientid, config{138}.sessionid);
config{138}.imagesavedir        = fullfile(imagesavedir, config{138}.prefix);

config{138}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{138}.circus.channel      			= {'mHaT2_4'};
config{138}.circus.outputdir    			= config{138}.datasavedir;
config{138}.circus.params.detection.spike_thresh  = '8';
config{138}.circus.params.clustering.nb_repeats   = '10';
config{138}.circus.params.clustering.max_elts     = '20000';

config{138}.bad.markerStart     = 'begin';
config{138}.bad.markerEnd       = 'SS_Start'; 

config{138}.bad.dir_list        = 'all';

config{138}.bad.sample_list     = 'all'; 

config{138}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03128_1591
config{139}                     = configcommon;
config{139}.patientid	      = 'pat_02680_1158';
config{139}.patients_root_dir   = output_patients;
config{139}.triallist           = 1;
config{139}.rawdir              = fullfile(rootpath_data, config{139}.patientid,'eeg');
%SESSION PARAMETERS - ses-09
config{139}.sessionid           = 'ses-01';
config{139}.prefix              = 'pat_2680_ses01' 

config{139}.datasavedir         = fullfile(datasavedir, config{139}.patientid, config{139}.sessionid);
config{139}.imagesavedir        = fullfile(imagesavedir, config{139}.prefix);

config{139}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{139}.circus.channel      			= {'mHaT2_4'};
config{139}.circus.outputdir    			= config{139}.datasavedir;
config{139}.circus.params.detection.spike_thresh  = '8';
config{139}.circus.params.clustering.nb_repeats   = '10';
config{139}.circus.params.clustering.max_elts     = '20000';

config{139}.bad.markerStart     = 'begin';
config{139}.bad.markerEnd       = 'SS_Start'; 

config{139}.bad.dir_list        = 'all';

config{139}.bad.sample_list     = 'all'; 

config{139}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03128_1591
config{140}                     = configcommon;
config{140}.patientid	      = 'pat_02680_1158';
config{140}.patients_root_dir   = output_patients;
config{140}.triallist           = 1;
config{140}.rawdir              = fullfile(rootpath_data, config{140}.patientid,'eeg');
%SESSION PARAMETERS - ses-10
config{140}.sessionid           = 'ses-01';
config{140}.prefix              = 'pat_2680_ses01' 

config{140}.datasavedir         = fullfile(datasavedir, config{140}.patientid, config{140}.sessionid);
config{140}.imagesavedir        = fullfile(imagesavedir, config{140}.prefix);

config{140}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{140}.circus.channel      			= {'mHaT2_4'};
config{140}.circus.outputdir    			= config{140}.datasavedir;
config{140}.circus.params.detection.spike_thresh  = '8';
config{140}.circus.params.clustering.nb_repeats   = '10';
config{140}.circus.params.clustering.max_elts     = '20000';

config{140}.bad.markerStart     = 'begin';
config{140}.bad.markerEnd       = 'SS_Start'; 

config{140}.bad.dir_list        = 'all';

config{140}.bad.sample_list     = 'all'; 

config{140}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03128_1591
config{141}                     = configcommon;
config{141}.patientid	      = 'pat_02680_1158';
config{141}.patients_root_dir   = output_patients;
config{141}.triallist           = 1;
config{141}.rawdir              = fullfile(rootpath_data, config{141}.patientid,'eeg');
%SESSION PARAMETERS - ses-11
config{141}.sessionid           = 'ses-01';
config{141}.prefix              = 'pat_2680_ses01' 

config{141}.datasavedir         = fullfile(datasavedir, config{141}.patientid, config{141}.sessionid);
config{141}.imagesavedir        = fullfile(imagesavedir, config{141}.prefix);

config{141}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{141}.circus.channel      			= {'mHaT2_4'};
config{141}.circus.outputdir    			= config{141}.datasavedir;
config{141}.circus.params.detection.spike_thresh  = '8';
config{141}.circus.params.clustering.nb_repeats   = '10';
config{141}.circus.params.clustering.max_elts     = '20000';

config{141}.bad.markerStart     = 'begin';
config{141}.bad.markerEnd       = 'SS_Start'; 

config{141}.bad.dir_list        = 'all';

config{141}.bad.sample_list     = 'all'; 

config{141}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03128_1591
config{142}                     = configcommon;
config{142}.patientid	      = 'pat_02680_1158';
config{142}.patients_root_dir   = output_patients;
config{142}.triallist           = 1;
config{142}.rawdir              = fullfile(rootpath_data, config{142}.patientid,'eeg');
%SESSION PARAMETERS - ses-12
config{142}.sessionid           = 'ses-01';
config{142}.prefix              = 'pat_2680_ses01' 

config{142}.datasavedir         = fullfile(datasavedir, config{142}.patientid, config{142}.sessionid);
config{142}.imagesavedir        = fullfile(imagesavedir, config{142}.prefix);

config{142}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{142}.circus.channel      			= {'mHaT2_4'};
config{142}.circus.outputdir    			= config{142}.datasavedir;
config{142}.circus.params.detection.spike_thresh  = '8';
config{142}.circus.params.clustering.nb_repeats   = '10';
config{142}.circus.params.clustering.max_elts     = '20000';

config{142}.bad.markerStart     = 'begin';
config{142}.bad.markerEnd       = 'SS_Start'; 

config{142}.bad.dir_list        = 'all';

config{142}.bad.sample_list     = 'all'; 

config{142}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_03138_1601
config{143}                     = configcommon;
config{143}.patientid	      = 'pat_02680_1158';
config{143}.patients_root_dir   = output_patients;
config{143}.triallist           = 1;
config{143}.rawdir              = fullfile(rootpath_data, config{143}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{143}.sessionid           = 'ses-01';
config{143}.prefix              = 'pat_2680_ses01' 

config{143}.datasavedir         = fullfile(datasavedir, config{143}.patientid, config{143}.sessionid);
config{143}.imagesavedir        = fullfile(imagesavedir, config{143}.prefix);

config{143}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{143}.circus.channel      			= {'mHaT2_4'};
config{143}.circus.outputdir    			= config{143}.datasavedir;
config{143}.circus.params.detection.spike_thresh  = '8';
config{143}.circus.params.clustering.nb_repeats   = '10';
config{143}.circus.params.clustering.max_elts     = '20000';

config{143}.bad.markerStart     = 'begin';
config{143}.bad.markerEnd       = 'SS_Start'; 

config{143}.bad.dir_list        = 'all';

config{143}.bad.sample_list     = 'all'; 

config{143}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03138_1601
config{144}                     = configcommon;
config{144}.patientid	      = 'pat_02680_1158';
config{144}.patients_root_dir   = output_patients;
config{144}.triallist           = 1;
config{144}.rawdir              = fullfile(rootpath_data, config{144}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{144}.sessionid           = 'ses-01';
config{144}.prefix              = 'pat_2680_ses01' 

config{144}.datasavedir         = fullfile(datasavedir, config{144}.patientid, config{144}.sessionid);
config{144}.imagesavedir        = fullfile(imagesavedir, config{144}.prefix);

config{144}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{144}.circus.channel      			= {'mHaT2_4'};
config{144}.circus.outputdir    			= config{144}.datasavedir;
config{144}.circus.params.detection.spike_thresh  = '8';
config{144}.circus.params.clustering.nb_repeats   = '10';
config{144}.circus.params.clustering.max_elts     = '20000';

config{144}.bad.markerStart     = 'begin';
config{144}.bad.markerEnd       = 'SS_Start'; 

config{144}.bad.dir_list        = 'all';

config{144}.bad.sample_list     = 'all'; 

config{144}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03138_1601
config{145}                     = configcommon;
config{145}.patientid	      = 'pat_02680_1158';
config{145}.patients_root_dir   = output_patients;
config{145}.triallist           = 1;
config{145}.rawdir              = fullfile(rootpath_data, config{145}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{145}.sessionid           = 'ses-01';
config{145}.prefix              = 'pat_2680_ses01' 

config{145}.datasavedir         = fullfile(datasavedir, config{145}.patientid, config{145}.sessionid);
config{145}.imagesavedir        = fullfile(imagesavedir, config{145}.prefix);

config{145}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{145}.circus.channel      			= {'mHaT2_4'};
config{145}.circus.outputdir    			= config{145}.datasavedir;
config{145}.circus.params.detection.spike_thresh  = '8';
config{145}.circus.params.clustering.nb_repeats   = '10';
config{145}.circus.params.clustering.max_elts     = '20000';

config{145}.bad.markerStart     = 'begin';
config{145}.bad.markerEnd       = 'SS_Start'; 

config{145}.bad.dir_list        = 'all';

config{145}.bad.sample_list     = 'all'; 

config{145}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03138_1601
config{146}                     = configcommon;
config{146}.patientid	      = 'pat_02680_1158';
config{146}.patients_root_dir   = output_patients;
config{146}.triallist           = 1;
config{146}.rawdir              = fullfile(rootpath_data, config{146}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{146}.sessionid           = 'ses-01';
config{146}.prefix              = 'pat_2680_ses01' 

config{146}.datasavedir         = fullfile(datasavedir, config{146}.patientid, config{146}.sessionid);
config{146}.imagesavedir        = fullfile(imagesavedir, config{146}.prefix);

config{146}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{146}.circus.channel      			= {'mHaT2_4'};
config{146}.circus.outputdir    			= config{146}.datasavedir;
config{146}.circus.params.detection.spike_thresh  = '8';
config{146}.circus.params.clustering.nb_repeats   = '10';
config{146}.circus.params.clustering.max_elts     = '20000';

config{146}.bad.markerStart     = 'begin';
config{146}.bad.markerEnd       = 'SS_Start'; 

config{146}.bad.dir_list        = 'all';

config{146}.bad.sample_list     = 'all'; 

config{146}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03138_1601
config{147}                     = configcommon;
config{147}.patientid	      = 'pat_02680_1158';
config{147}.patients_root_dir   = output_patients;
config{147}.triallist           = 1;
config{147}.rawdir              = fullfile(rootpath_data, config{147}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{147}.sessionid           = 'ses-01';
config{147}.prefix              = 'pat_2680_ses01' 

config{147}.datasavedir         = fullfile(datasavedir, config{147}.patientid, config{147}.sessionid);
config{147}.imagesavedir        = fullfile(imagesavedir, config{147}.prefix);

config{147}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{147}.circus.channel      			= {'mHaT2_4'};
config{147}.circus.outputdir    			= config{147}.datasavedir;
config{147}.circus.params.detection.spike_thresh  = '8';
config{147}.circus.params.clustering.nb_repeats   = '10';
config{147}.circus.params.clustering.max_elts     = '20000';

config{147}.bad.markerStart     = 'begin';
config{147}.bad.markerEnd       = 'SS_Start'; 

config{147}.bad.dir_list        = 'all';

config{147}.bad.sample_list     = 'all'; 

config{147}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03138_1601
config{148}                     = configcommon;
config{148}.patientid	      = 'pat_02680_1158';
config{148}.patients_root_dir   = output_patients;
config{148}.triallist           = 1;
config{148}.rawdir              = fullfile(rootpath_data, config{148}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{148}.sessionid           = 'ses-01';
config{148}.prefix              = 'pat_2680_ses01' 

config{148}.datasavedir         = fullfile(datasavedir, config{148}.patientid, config{148}.sessionid);
config{148}.imagesavedir        = fullfile(imagesavedir, config{148}.prefix);

config{148}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{148}.circus.channel      			= {'mHaT2_4'};
config{148}.circus.outputdir    			= config{148}.datasavedir;
config{148}.circus.params.detection.spike_thresh  = '8';
config{148}.circus.params.clustering.nb_repeats   = '10';
config{148}.circus.params.clustering.max_elts     = '20000';

config{148}.bad.markerStart     = 'begin';
config{148}.bad.markerEnd       = 'SS_Start'; 

config{148}.bad.dir_list        = 'all';

config{148}.bad.sample_list     = 'all'; 

config{148}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03138_1601
config{149}                     = configcommon;
config{149}.patientid	      = 'pat_02680_1158';
config{149}.patients_root_dir   = output_patients;
config{149}.triallist           = 1;
config{149}.rawdir              = fullfile(rootpath_data, config{149}.patientid,'eeg');
%SESSION PARAMETERS - ses-07
config{149}.sessionid           = 'ses-01';
config{149}.prefix              = 'pat_2680_ses01' 

config{149}.datasavedir         = fullfile(datasavedir, config{149}.patientid, config{149}.sessionid);
config{149}.imagesavedir        = fullfile(imagesavedir, config{149}.prefix);

config{149}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{149}.circus.channel      			= {'mHaT2_4'};
config{149}.circus.outputdir    			= config{149}.datasavedir;
config{149}.circus.params.detection.spike_thresh  = '8';
config{149}.circus.params.clustering.nb_repeats   = '10';
config{149}.circus.params.clustering.max_elts     = '20000';

config{149}.bad.markerStart     = 'begin';
config{149}.bad.markerEnd       = 'SS_Start'; 

config{149}.bad.dir_list        = 'all';

config{149}.bad.sample_list     = 'all'; 

config{149}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03138_1601
config{150}                     = configcommon;
config{150}.patientid	      = 'pat_02680_1158';
config{150}.patients_root_dir   = output_patients;
config{150}.triallist           = 1;
config{150}.rawdir              = fullfile(rootpath_data, config{150}.patientid,'eeg');
%SESSION PARAMETERS - ses-08
config{150}.sessionid           = 'ses-01';
config{150}.prefix              = 'pat_2680_ses01' 

config{150}.datasavedir         = fullfile(datasavedir, config{150}.patientid, config{150}.sessionid);
config{150}.imagesavedir        = fullfile(imagesavedir, config{150}.prefix);

config{150}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{150}.circus.channel      			= {'mHaT2_4'};
config{150}.circus.outputdir    			= config{150}.datasavedir;
config{150}.circus.params.detection.spike_thresh  = '8';
config{150}.circus.params.clustering.nb_repeats   = '10';
config{150}.circus.params.clustering.max_elts     = '20000';

config{150}.bad.markerStart     = 'begin';
config{150}.bad.markerEnd       = 'SS_Start'; 

config{150}.bad.dir_list        = 'all';

config{150}.bad.sample_list     = 'all'; 

config{150}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03138_1601
config{151}                     = configcommon;
config{151}.patientid	      = 'pat_02680_1158';
config{151}.patients_root_dir   = output_patients;
config{151}.triallist           = 1;
config{151}.rawdir              = fullfile(rootpath_data, config{151}.patientid,'eeg');
%SESSION PARAMETERS - ses-09
config{151}.sessionid           = 'ses-01';
config{151}.prefix              = 'pat_2680_ses01' 

config{151}.datasavedir         = fullfile(datasavedir, config{151}.patientid, config{151}.sessionid);
config{151}.imagesavedir        = fullfile(imagesavedir, config{151}.prefix);

config{151}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{151}.circus.channel      			= {'mHaT2_4'};
config{151}.circus.outputdir    			= config{151}.datasavedir;
config{151}.circus.params.detection.spike_thresh  = '8';
config{151}.circus.params.clustering.nb_repeats   = '10';
config{151}.circus.params.clustering.max_elts     = '20000';

config{151}.bad.markerStart     = 'begin';
config{151}.bad.markerEnd       = 'SS_Start'; 

config{151}.bad.dir_list        = 'all';

config{151}.bad.sample_list     = 'all'; 

config{151}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03138_1601
config{152}                     = configcommon;
config{152}.patientid	      = 'pat_02680_1158';
config{152}.patients_root_dir   = output_patients;
config{152}.triallist           = 1;
config{152}.rawdir              = fullfile(rootpath_data, config{152}.patientid,'eeg');
%SESSION PARAMETERS - ses-10
config{152}.sessionid           = 'ses-01';
config{152}.prefix              = 'pat_2680_ses01' 

config{152}.datasavedir         = fullfile(datasavedir, config{152}.patientid, config{152}.sessionid);
config{152}.imagesavedir        = fullfile(imagesavedir, config{152}.prefix);

config{152}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{152}.circus.channel      			= {'mHaT2_4'};
config{152}.circus.outputdir    			= config{152}.datasavedir;
config{152}.circus.params.detection.spike_thresh  = '8';
config{152}.circus.params.clustering.nb_repeats   = '10';
config{152}.circus.params.clustering.max_elts     = '20000';

config{152}.bad.markerStart     = 'begin';
config{152}.bad.markerEnd       = 'SS_Start'; 

config{152}.bad.dir_list        = 'all';

config{152}.bad.sample_list     = 'all'; 

config{152}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03138_1601
config{153}                     = configcommon;
config{153}.patientid	      = 'pat_02680_1158';
config{153}.patients_root_dir   = output_patients;
config{153}.triallist           = 1;
config{153}.rawdir              = fullfile(rootpath_data, config{153}.patientid,'eeg');
%SESSION PARAMETERS - ses-11
config{153}.sessionid           = 'ses-01';
config{153}.prefix              = 'pat_2680_ses01' 

config{153}.datasavedir         = fullfile(datasavedir, config{153}.patientid, config{153}.sessionid);
config{153}.imagesavedir        = fullfile(imagesavedir, config{153}.prefix);

config{153}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{153}.circus.channel      			= {'mHaT2_4'};
config{153}.circus.outputdir    			= config{153}.datasavedir;
config{153}.circus.params.detection.spike_thresh  = '8';
config{153}.circus.params.clustering.nb_repeats   = '10';
config{153}.circus.params.clustering.max_elts     = '20000';

config{153}.bad.markerStart     = 'begin';
config{153}.bad.markerEnd       = 'SS_Start'; 

config{153}.bad.dir_list        = 'all';

config{153}.bad.sample_list     = 'all'; 

config{153}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03138_1601
config{154}                     = configcommon;
config{154}.patientid	      = 'pat_02680_1158';
config{154}.patients_root_dir   = output_patients;
config{154}.triallist           = 1;
config{154}.rawdir              = fullfile(rootpath_data, config{154}.patientid,'eeg');
%SESSION PARAMETERS - ses-12
config{154}.sessionid           = 'ses-01';
config{154}.prefix              = 'pat_2680_ses01' 

config{154}.datasavedir         = fullfile(datasavedir, config{154}.patientid, config{154}.sessionid);
config{154}.imagesavedir        = fullfile(imagesavedir, config{154}.prefix);

config{154}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{154}.circus.channel      			= {'mHaT2_4'};
config{154}.circus.outputdir    			= config{154}.datasavedir;
config{154}.circus.params.detection.spike_thresh  = '8';
config{154}.circus.params.clustering.nb_repeats   = '10';
config{154}.circus.params.clustering.max_elts     = '20000';

config{154}.bad.markerStart     = 'begin';
config{154}.bad.markerEnd       = 'SS_Start'; 

config{154}.bad.dir_list        = 'all';

config{154}.bad.sample_list     = 'all'; 

config{154}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03138_1601
config{155}                     = configcommon;
config{155}.patientid	      = 'pat_02680_1158';
config{155}.patients_root_dir   = output_patients;
config{155}.triallist           = 1;
config{155}.rawdir              = fullfile(rootpath_data, config{155}.patientid,'eeg');
%SESSION PARAMETERS - ses-13
config{155}.sessionid           = 'ses-01';
config{155}.prefix              = 'pat_2680_ses01' 

config{155}.datasavedir         = fullfile(datasavedir, config{155}.patientid, config{155}.sessionid);
config{155}.imagesavedir        = fullfile(imagesavedir, config{155}.prefix);

config{155}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{155}.circus.channel      			= {'mHaT2_4'};
config{155}.circus.outputdir    			= config{155}.datasavedir;
config{155}.circus.params.detection.spike_thresh  = '8';
config{155}.circus.params.clustering.nb_repeats   = '10';
config{155}.circus.params.clustering.max_elts     = '20000';

config{155}.bad.markerStart     = 'begin';
config{155}.bad.markerEnd       = 'SS_Start'; 

config{155}.bad.dir_list        = 'all';

config{155}.bad.sample_list     = 'all'; 

config{155}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_03146_1608
config{156}                     = configcommon;
config{156}.patientid	      = 'pat_02680_1158';
config{156}.patients_root_dir   = output_patients;
config{156}.triallist           = 1;
config{156}.rawdir              = fullfile(rootpath_data, config{156}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{156}.sessionid           = 'ses-01';
config{156}.prefix              = 'pat_2680_ses01' 

config{156}.datasavedir         = fullfile(datasavedir, config{156}.patientid, config{156}.sessionid);
config{156}.imagesavedir        = fullfile(imagesavedir, config{156}.prefix);

config{156}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{156}.circus.channel      			= {'mHaT2_4'};
config{156}.circus.outputdir    			= config{156}.datasavedir;
config{156}.circus.params.detection.spike_thresh  = '8';
config{156}.circus.params.clustering.nb_repeats   = '10';
config{156}.circus.params.clustering.max_elts     = '20000';

config{156}.bad.markerStart     = 'begin';
config{156}.bad.markerEnd       = 'SS_Start'; 

config{156}.bad.dir_list        = 'all';

config{156}.bad.sample_list     = 'all'; 

config{156}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03146_1608
config{157}                     = configcommon;
config{157}.patientid	      = 'pat_02680_1158';
config{157}.patients_root_dir   = output_patients;
config{157}.triallist           = 1;
config{157}.rawdir              = fullfile(rootpath_data, config{157}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{157}.sessionid           = 'ses-01';
config{157}.prefix              = 'pat_2680_ses01' 

config{157}.datasavedir         = fullfile(datasavedir, config{157}.patientid, config{157}.sessionid);
config{157}.imagesavedir        = fullfile(imagesavedir, config{157}.prefix);

config{157}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{157}.circus.channel      			= {'mHaT2_4'};
config{157}.circus.outputdir    			= config{157}.datasavedir;
config{157}.circus.params.detection.spike_thresh  = '8';
config{157}.circus.params.clustering.nb_repeats   = '10';
config{157}.circus.params.clustering.max_elts     = '20000';

config{157}.bad.markerStart     = 'begin';
config{157}.bad.markerEnd       = 'SS_Start'; 

config{157}.bad.dir_list        = 'all';

config{157}.bad.sample_list     = 'all'; 

config{157}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03146_1608
config{158}                     = configcommon;
config{158}.patientid	      = 'pat_02680_1158';
config{158}.patients_root_dir   = output_patients;
config{158}.triallist           = 1;
config{158}.rawdir              = fullfile(rootpath_data, config{158}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{158}.sessionid           = 'ses-01';
config{158}.prefix              = 'pat_2680_ses01' 

config{158}.datasavedir         = fullfile(datasavedir, config{158}.patientid, config{158}.sessionid);
config{158}.imagesavedir        = fullfile(imagesavedir, config{158}.prefix);

config{158}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{158}.circus.channel      			= {'mHaT2_4'};
config{158}.circus.outputdir    			= config{158}.datasavedir;
config{158}.circus.params.detection.spike_thresh  = '8';
config{158}.circus.params.clustering.nb_repeats   = '10';
config{158}.circus.params.clustering.max_elts     = '20000';

config{158}.bad.markerStart     = 'begin';
config{158}.bad.markerEnd       = 'SS_Start'; 

config{158}.bad.dir_list        = 'all';

config{158}.bad.sample_list     = 'all'; 

config{158}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03146_1608
config{159}                     = configcommon;
config{159}.patientid	      = 'pat_02680_1158';
config{159}.patients_root_dir   = output_patients;
config{159}.triallist           = 1;
config{159}.rawdir              = fullfile(rootpath_data, config{159}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{159}.sessionid           = 'ses-01';
config{159}.prefix              = 'pat_2680_ses01' 

config{159}.datasavedir         = fullfile(datasavedir, config{159}.patientid, config{159}.sessionid);
config{159}.imagesavedir        = fullfile(imagesavedir, config{159}.prefix);

config{159}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{159}.circus.channel      			= {'mHaT2_4'};
config{159}.circus.outputdir    			= config{159}.datasavedir;
config{159}.circus.params.detection.spike_thresh  = '8';
config{159}.circus.params.clustering.nb_repeats   = '10';
config{159}.circus.params.clustering.max_elts     = '20000';

config{159}.bad.markerStart     = 'begin';
config{159}.bad.markerEnd       = 'SS_Start'; 

config{159}.bad.dir_list        = 'all';

config{159}.bad.sample_list     = 'all'; 

config{159}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03146_1608
config{160}                     = configcommon;
config{160}.patientid	      = 'pat_02680_1158';
config{160}.patients_root_dir   = output_patients;
config{160}.triallist           = 1;
config{160}.rawdir              = fullfile(rootpath_data, config{160}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{160}.sessionid           = 'ses-01';
config{160}.prefix              = 'pat_2680_ses01' 

config{160}.datasavedir         = fullfile(datasavedir, config{160}.patientid, config{160}.sessionid);
config{160}.imagesavedir        = fullfile(imagesavedir, config{160}.prefix);

config{160}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{160}.circus.channel      			= {'mHaT2_4'};
config{160}.circus.outputdir    			= config{160}.datasavedir;
config{160}.circus.params.detection.spike_thresh  = '8';
config{160}.circus.params.clustering.nb_repeats   = '10';
config{160}.circus.params.clustering.max_elts     = '20000';

config{160}.bad.markerStart     = 'begin';
config{160}.bad.markerEnd       = 'SS_Start'; 

config{160}.bad.dir_list        = 'all';

config{160}.bad.sample_list     = 'all'; 

config{160}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03146_1608
config{161}                     = configcommon;
config{161}.patientid	      = 'pat_02680_1158';
config{161}.patients_root_dir   = output_patients;
config{161}.triallist           = 1;
config{161}.rawdir              = fullfile(rootpath_data, config{161}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{161}.sessionid           = 'ses-01';
config{161}.prefix              = 'pat_2680_ses01' 

config{161}.datasavedir         = fullfile(datasavedir, config{161}.patientid, config{161}.sessionid);
config{161}.imagesavedir        = fullfile(imagesavedir, config{161}.prefix);

config{161}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{161}.circus.channel      			= {'mHaT2_4'};
config{161}.circus.outputdir    			= config{161}.datasavedir;
config{161}.circus.params.detection.spike_thresh  = '8';
config{161}.circus.params.clustering.nb_repeats   = '10';
config{161}.circus.params.clustering.max_elts     = '20000';

config{161}.bad.markerStart     = 'begin';
config{161}.bad.markerEnd       = 'SS_Start'; 

config{161}.bad.dir_list        = 'all';

config{161}.bad.sample_list     = 'all'; 

config{161}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03146_1608
config{162}                     = configcommon;
config{162}.patientid	      = 'pat_02680_1158';
config{162}.patients_root_dir   = output_patients;
config{162}.triallist           = 1;
config{162}.rawdir              = fullfile(rootpath_data, config{162}.patientid,'eeg');
%SESSION PARAMETERS - ses-07
config{162}.sessionid           = 'ses-01';
config{162}.prefix              = 'pat_2680_ses01' 

config{162}.datasavedir         = fullfile(datasavedir, config{162}.patientid, config{162}.sessionid);
config{162}.imagesavedir        = fullfile(imagesavedir, config{162}.prefix);

config{162}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{162}.circus.channel      			= {'mHaT2_4'};
config{162}.circus.outputdir    			= config{162}.datasavedir;
config{162}.circus.params.detection.spike_thresh  = '8';
config{162}.circus.params.clustering.nb_repeats   = '10';
config{162}.circus.params.clustering.max_elts     = '20000';

config{162}.bad.markerStart     = 'begin';
config{162}.bad.markerEnd       = 'SS_Start'; 

config{162}.bad.dir_list        = 'all';

config{162}.bad.sample_list     = 'all'; 

config{162}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03146_1608
config{163}                     = configcommon;
config{163}.patientid	      = 'pat_02680_1158';
config{163}.patients_root_dir   = output_patients;
config{163}.triallist           = 1;
config{163}.rawdir              = fullfile(rootpath_data, config{163}.patientid,'eeg');
%SESSION PARAMETERS - ses-08
config{163}.sessionid           = 'ses-01';
config{163}.prefix              = 'pat_2680_ses01' 

config{163}.datasavedir         = fullfile(datasavedir, config{163}.patientid, config{163}.sessionid);
config{163}.imagesavedir        = fullfile(imagesavedir, config{163}.prefix);

config{163}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{163}.circus.channel      			= {'mHaT2_4'};
config{163}.circus.outputdir    			= config{163}.datasavedir;
config{163}.circus.params.detection.spike_thresh  = '8';
config{163}.circus.params.clustering.nb_repeats   = '10';
config{163}.circus.params.clustering.max_elts     = '20000';

config{163}.bad.markerStart     = 'begin';
config{163}.bad.markerEnd       = 'SS_Start'; 

config{163}.bad.dir_list        = 'all';

config{163}.bad.sample_list     = 'all'; 

config{163}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03146_1608
config{164}                     = configcommon;
config{164}.patientid	      = 'pat_02680_1158';
config{164}.patients_root_dir   = output_patients;
config{164}.triallist           = 1;
config{164}.rawdir              = fullfile(rootpath_data, config{164}.patientid,'eeg');
%SESSION PARAMETERS - ses-09
config{164}.sessionid           = 'ses-01';
config{164}.prefix              = 'pat_2680_ses01' 

config{164}.datasavedir         = fullfile(datasavedir, config{164}.patientid, config{164}.sessionid);
config{164}.imagesavedir        = fullfile(imagesavedir, config{164}.prefix);

config{164}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{164}.circus.channel      			= {'mHaT2_4'};
config{164}.circus.outputdir    			= config{164}.datasavedir;
config{164}.circus.params.detection.spike_thresh  = '8';
config{164}.circus.params.clustering.nb_repeats   = '10';
config{164}.circus.params.clustering.max_elts     = '20000';

config{164}.bad.markerStart     = 'begin';
config{164}.bad.markerEnd       = 'SS_Start'; 

config{164}.bad.dir_list        = 'all';

config{164}.bad.sample_list     = 'all'; 

config{164}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_03152_1614
config{165}                     = configcommon;
config{165}.patientid	      = 'pat_02680_1158';
config{165}.patients_root_dir   = output_patients;
config{165}.triallist           = 1;
config{165}.rawdir              = fullfile(rootpath_data, config{165}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{165}.sessionid           = 'ses-01';
config{165}.prefix              = 'pat_2680_ses01' 

config{165}.datasavedir         = fullfile(datasavedir, config{165}.patientid, config{165}.sessionid);
config{165}.imagesavedir        = fullfile(imagesavedir, config{165}.prefix);

config{165}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{165}.circus.channel      			= {'mHaT2_4'};
config{165}.circus.outputdir    			= config{165}.datasavedir;
config{165}.circus.params.detection.spike_thresh  = '8';
config{165}.circus.params.clustering.nb_repeats   = '10';
config{165}.circus.params.clustering.max_elts     = '20000';

config{165}.bad.markerStart     = 'begin';
config{165}.bad.markerEnd       = 'SS_Start'; 

config{165}.bad.dir_list        = 'all';

config{165}.bad.sample_list     = 'all'; 

config{165}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03152_1614
config{166}                     = configcommon;
config{166}.patientid	      = 'pat_02680_1158';
config{166}.patients_root_dir   = output_patients;
config{166}.triallist           = 1;
config{166}.rawdir              = fullfile(rootpath_data, config{166}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{166}.sessionid           = 'ses-01';
config{166}.prefix              = 'pat_2680_ses01' 

config{166}.datasavedir         = fullfile(datasavedir, config{166}.patientid, config{166}.sessionid);
config{166}.imagesavedir        = fullfile(imagesavedir, config{166}.prefix);

config{166}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{166}.circus.channel      			= {'mHaT2_4'};
config{166}.circus.outputdir    			= config{166}.datasavedir;
config{166}.circus.params.detection.spike_thresh  = '8';
config{166}.circus.params.clustering.nb_repeats   = '10';
config{166}.circus.params.clustering.max_elts     = '20000';

config{166}.bad.markerStart     = 'begin';
config{166}.bad.markerEnd       = 'SS_Start'; 

config{166}.bad.dir_list        = 'all';

config{166}.bad.sample_list     = 'all'; 

config{166}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03152_1614
config{167}                     = configcommon;
config{167}.patientid	      = 'pat_02680_1158';
config{167}.patients_root_dir   = output_patients;
config{167}.triallist           = 1;
config{167}.rawdir              = fullfile(rootpath_data, config{167}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{167}.sessionid           = 'ses-01';
config{167}.prefix              = 'pat_2680_ses01' 

config{167}.datasavedir         = fullfile(datasavedir, config{167}.patientid, config{167}.sessionid);
config{167}.imagesavedir        = fullfile(imagesavedir, config{167}.prefix);

config{167}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{167}.circus.channel      			= {'mHaT2_4'};
config{167}.circus.outputdir    			= config{167}.datasavedir;
config{167}.circus.params.detection.spike_thresh  = '8';
config{167}.circus.params.clustering.nb_repeats   = '10';
config{167}.circus.params.clustering.max_elts     = '20000';

config{167}.bad.markerStart     = 'begin';
config{167}.bad.markerEnd       = 'SS_Start'; 

config{167}.bad.dir_list        = 'all';

config{167}.bad.sample_list     = 'all'; 

config{167}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03152_1614
config{168}                     = configcommon;
config{168}.patientid	      = 'pat_02680_1158';
config{168}.patients_root_dir   = output_patients;
config{168}.triallist           = 1;
config{168}.rawdir              = fullfile(rootpath_data, config{168}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{168}.sessionid           = 'ses-01';
config{168}.prefix              = 'pat_2680_ses01' 

config{168}.datasavedir         = fullfile(datasavedir, config{168}.patientid, config{168}.sessionid);
config{168}.imagesavedir        = fullfile(imagesavedir, config{168}.prefix);

config{168}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{168}.circus.channel      			= {'mHaT2_4'};
config{168}.circus.outputdir    			= config{168}.datasavedir;
config{168}.circus.params.detection.spike_thresh  = '8';
config{168}.circus.params.clustering.nb_repeats   = '10';
config{168}.circus.params.clustering.max_elts     = '20000';

config{168}.bad.markerStart     = 'begin';
config{168}.bad.markerEnd       = 'SS_Start'; 

config{168}.bad.dir_list        = 'all';

config{168}.bad.sample_list     = 'all'; 

config{168}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03152_1614
config{169}                     = configcommon;
config{169}.patientid	      = 'pat_02680_1158';
config{169}.patients_root_dir   = output_patients;
config{169}.triallist           = 1;
config{169}.rawdir              = fullfile(rootpath_data, config{169}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{169}.sessionid           = 'ses-01';
config{169}.prefix              = 'pat_2680_ses01' 

config{169}.datasavedir         = fullfile(datasavedir, config{169}.patientid, config{169}.sessionid);
config{169}.imagesavedir        = fullfile(imagesavedir, config{169}.prefix);

config{169}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{169}.circus.channel      			= {'mHaT2_4'};
config{169}.circus.outputdir    			= config{169}.datasavedir;
config{169}.circus.params.detection.spike_thresh  = '8';
config{169}.circus.params.clustering.nb_repeats   = '10';
config{169}.circus.params.clustering.max_elts     = '20000';

config{169}.bad.markerStart     = 'begin';
config{169}.bad.markerEnd       = 'SS_Start'; 

config{169}.bad.dir_list        = 'all';

config{169}.bad.sample_list     = 'all'; 

config{169}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03152_1614
config{170}                     = configcommon;
config{170}.patientid	      = 'pat_02680_1158';
config{170}.patients_root_dir   = output_patients;
config{170}.triallist           = 1;
config{170}.rawdir              = fullfile(rootpath_data, config{170}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{170}.sessionid           = 'ses-01';
config{170}.prefix              = 'pat_2680_ses01' 

config{170}.datasavedir         = fullfile(datasavedir, config{170}.patientid, config{170}.sessionid);
config{170}.imagesavedir        = fullfile(imagesavedir, config{170}.prefix);

config{170}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{170}.circus.channel      			= {'mHaT2_4'};
config{170}.circus.outputdir    			= config{170}.datasavedir;
config{170}.circus.params.detection.spike_thresh  = '8';
config{170}.circus.params.clustering.nb_repeats   = '10';
config{170}.circus.params.clustering.max_elts     = '20000';

config{170}.bad.markerStart     = 'begin';
config{170}.bad.markerEnd       = 'SS_Start'; 

config{170}.bad.dir_list        = 'all';

config{170}.bad.sample_list     = 'all'; 

config{170}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03152_1614
config{171}                     = configcommon;
config{171}.patientid	      = 'pat_02680_1158';
config{171}.patients_root_dir   = output_patients;
config{171}.triallist           = 1;
config{171}.rawdir              = fullfile(rootpath_data, config{171}.patientid,'eeg');
%SESSION PARAMETERS - ses-07
config{171}.sessionid           = 'ses-01';
config{171}.prefix              = 'pat_2680_ses01' 

config{171}.datasavedir         = fullfile(datasavedir, config{171}.patientid, config{171}.sessionid);
config{171}.imagesavedir        = fullfile(imagesavedir, config{171}.prefix);

config{171}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{171}.circus.channel      			= {'mHaT2_4'};
config{171}.circus.outputdir    			= config{171}.datasavedir;
config{171}.circus.params.detection.spike_thresh  = '8';
config{171}.circus.params.clustering.nb_repeats   = '10';
config{171}.circus.params.clustering.max_elts     = '20000';

config{171}.bad.markerStart     = 'begin';
config{171}.bad.markerEnd       = 'SS_Start'; 

config{171}.bad.dir_list        = 'all';

config{171}.bad.sample_list     = 'all'; 

config{171}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03152_1614
config{172}                     = configcommon;
config{172}.patientid	      = 'pat_02680_1158';
config{172}.patients_root_dir   = output_patients;
config{172}.triallist           = 1;
config{172}.rawdir              = fullfile(rootpath_data, config{172}.patientid,'eeg');
%SESSION PARAMETERS - ses-08
config{172}.sessionid           = 'ses-01';
config{172}.prefix              = 'pat_2680_ses01' 

config{172}.datasavedir         = fullfile(datasavedir, config{172}.patientid, config{172}.sessionid);
config{172}.imagesavedir        = fullfile(imagesavedir, config{172}.prefix);

config{172}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{172}.circus.channel      			= {'mHaT2_4'};
config{172}.circus.outputdir    			= config{172}.datasavedir;
config{172}.circus.params.detection.spike_thresh  = '8';
config{172}.circus.params.clustering.nb_repeats   = '10';
config{172}.circus.params.clustering.max_elts     = '20000';

config{172}.bad.markerStart     = 'begin';
config{172}.bad.markerEnd       = 'SS_Start'; 

config{172}.bad.dir_list        = 'all';

config{172}.bad.sample_list     = 'all'; 

config{172}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03152_1614
config{173}                     = configcommon;
config{173}.patientid	      = 'pat_02680_1158';
config{173}.patients_root_dir   = output_patients;
config{173}.triallist           = 1;
config{173}.rawdir              = fullfile(rootpath_data, config{173}.patientid,'eeg');
%SESSION PARAMETERS - ses-09
config{173}.sessionid           = 'ses-01';
config{173}.prefix              = 'pat_2680_ses01' 

config{173}.datasavedir         = fullfile(datasavedir, config{173}.patientid, config{173}.sessionid);
config{173}.imagesavedir        = fullfile(imagesavedir, config{173}.prefix);

config{173}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{173}.circus.channel      			= {'mHaT2_4'};
config{173}.circus.outputdir    			= config{173}.datasavedir;
config{173}.circus.params.detection.spike_thresh  = '8';
config{173}.circus.params.clustering.nb_repeats   = '10';
config{173}.circus.params.clustering.max_elts     = '20000';

config{173}.bad.markerStart     = 'begin';
config{173}.bad.markerEnd       = 'SS_Start'; 

config{173}.bad.dir_list        = 'all';

config{173}.bad.sample_list     = 'all'; 

config{173}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03152_1614
config{174}                     = configcommon;
config{174}.patientid	      = 'pat_02680_1158';
config{174}.patients_root_dir   = output_patients;
config{174}.triallist           = 1;
config{174}.rawdir              = fullfile(rootpath_data, config{174}.patientid,'eeg');
%SESSION PARAMETERS - ses-10
config{174}.sessionid           = 'ses-01';
config{174}.prefix              = 'pat_2680_ses01' 

config{174}.datasavedir         = fullfile(datasavedir, config{174}.patientid, config{174}.sessionid);
config{174}.imagesavedir        = fullfile(imagesavedir, config{174}.prefix);

config{174}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{174}.circus.channel      			= {'mHaT2_4'};
config{174}.circus.outputdir    			= config{174}.datasavedir;
config{174}.circus.params.detection.spike_thresh  = '8';
config{174}.circus.params.clustering.nb_repeats   = '10';
config{174}.circus.params.clustering.max_elts     = '20000';

config{174}.bad.markerStart     = 'begin';
config{174}.bad.markerEnd       = 'SS_Start'; 

config{174}.bad.dir_list        = 'all';

config{174}.bad.sample_list     = 'all'; 

config{174}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03152_1614
config{175}                     = configcommon;
config{175}.patientid	      = 'pat_02680_1158';
config{175}.patients_root_dir   = output_patients;
config{175}.triallist           = 1;
config{175}.rawdir              = fullfile(rootpath_data, config{175}.patientid,'eeg');
%SESSION PARAMETERS - ses-11
config{175}.sessionid           = 'ses-01';
config{175}.prefix              = 'pat_2680_ses01' 

config{175}.datasavedir         = fullfile(datasavedir, config{175}.patientid, config{175}.sessionid);
config{175}.imagesavedir        = fullfile(imagesavedir, config{175}.prefix);

config{175}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{175}.circus.channel      			= {'mHaT2_4'};
config{175}.circus.outputdir    			= config{175}.datasavedir;
config{175}.circus.params.detection.spike_thresh  = '8';
config{175}.circus.params.clustering.nb_repeats   = '10';
config{175}.circus.params.clustering.max_elts     = '20000';

config{175}.bad.markerStart     = 'begin';
config{175}.bad.markerEnd       = 'SS_Start'; 

config{175}.bad.dir_list        = 'all';

config{175}.bad.sample_list     = 'all'; 

config{175}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_03167_1630
config{176}                     = configcommon;
config{176}.patientid	      = 'pat_02680_1158';
config{176}.patients_root_dir   = output_patients;
config{176}.triallist           = 1;
config{176}.rawdir              = fullfile(rootpath_data, config{176}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{176}.sessionid           = 'ses-01';
config{176}.prefix              = 'pat_2680_ses01' 

config{176}.datasavedir         = fullfile(datasavedir, config{176}.patientid, config{176}.sessionid);
config{176}.imagesavedir        = fullfile(imagesavedir, config{176}.prefix);

config{176}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{176}.circus.channel      			= {'mHaT2_4'};
config{176}.circus.outputdir    			= config{176}.datasavedir;
config{176}.circus.params.detection.spike_thresh  = '8';
config{176}.circus.params.clustering.nb_repeats   = '10';
config{176}.circus.params.clustering.max_elts     = '20000';

config{176}.bad.markerStart     = 'begin';
config{176}.bad.markerEnd       = 'SS_Start'; 

config{176}.bad.dir_list        = 'all';

config{176}.bad.sample_list     = 'all'; 

config{176}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03167_1630
config{177}                     = configcommon;
config{177}.patientid	      = 'pat_02680_1158';
config{177}.patients_root_dir   = output_patients;
config{177}.triallist           = 1;
config{177}.rawdir              = fullfile(rootpath_data, config{177}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{177}.sessionid           = 'ses-01';
config{177}.prefix              = 'pat_2680_ses01' 

config{177}.datasavedir         = fullfile(datasavedir, config{177}.patientid, config{177}.sessionid);
config{177}.imagesavedir        = fullfile(imagesavedir, config{177}.prefix);

config{177}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{177}.circus.channel      			= {'mHaT2_4'};
config{177}.circus.outputdir    			= config{177}.datasavedir;
config{177}.circus.params.detection.spike_thresh  = '8';
config{177}.circus.params.clustering.nb_repeats   = '10';
config{177}.circus.params.clustering.max_elts     = '20000';

config{177}.bad.markerStart     = 'begin';
config{177}.bad.markerEnd       = 'SS_Start'; 

config{177}.bad.dir_list        = 'all';

config{177}.bad.sample_list     = 'all'; 

config{177}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03167_1630
config{178}                     = configcommon;
config{178}.patientid	      = 'pat_02680_1158';
config{178}.patients_root_dir   = output_patients;
config{178}.triallist           = 1;
config{178}.rawdir              = fullfile(rootpath_data, config{178}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{178}.sessionid           = 'ses-01';
config{178}.prefix              = 'pat_2680_ses01' 

config{178}.datasavedir         = fullfile(datasavedir, config{178}.patientid, config{178}.sessionid);
config{178}.imagesavedir        = fullfile(imagesavedir, config{178}.prefix);

config{178}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{178}.circus.channel      			= {'mHaT2_4'};
config{178}.circus.outputdir    			= config{178}.datasavedir;
config{178}.circus.params.detection.spike_thresh  = '8';
config{178}.circus.params.clustering.nb_repeats   = '10';
config{178}.circus.params.clustering.max_elts     = '20000';

config{178}.bad.markerStart     = 'begin';
config{178}.bad.markerEnd       = 'SS_Start'; 

config{178}.bad.dir_list        = 'all';

config{178}.bad.sample_list     = 'all'; 

config{178}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03167_1630
config{179}                     = configcommon;
config{179}.patientid	      = 'pat_02680_1158';
config{179}.patients_root_dir   = output_patients;
config{179}.triallist           = 1;
config{179}.rawdir              = fullfile(rootpath_data, config{179}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{179}.sessionid           = 'ses-01';
config{179}.prefix              = 'pat_2680_ses01' 

config{179}.datasavedir         = fullfile(datasavedir, config{179}.patientid, config{179}.sessionid);
config{179}.imagesavedir        = fullfile(imagesavedir, config{179}.prefix);

config{179}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{179}.circus.channel      			= {'mHaT2_4'};
config{179}.circus.outputdir    			= config{179}.datasavedir;
config{179}.circus.params.detection.spike_thresh  = '8';
config{179}.circus.params.clustering.nb_repeats   = '10';
config{179}.circus.params.clustering.max_elts     = '20000';

config{179}.bad.markerStart     = 'begin';
config{179}.bad.markerEnd       = 'SS_Start'; 

config{179}.bad.dir_list        = 'all';

config{179}.bad.sample_list     = 'all'; 

config{179}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03167_1630
config{180}                     = configcommon;
config{180}.patientid	      = 'pat_02680_1158';
config{180}.patients_root_dir   = output_patients;
config{180}.triallist           = 1;
config{180}.rawdir              = fullfile(rootpath_data, config{180}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{180}.sessionid           = 'ses-01';
config{180}.prefix              = 'pat_2680_ses01' 

config{180}.datasavedir         = fullfile(datasavedir, config{180}.patientid, config{180}.sessionid);
config{180}.imagesavedir        = fullfile(imagesavedir, config{180}.prefix);

config{180}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{180}.circus.channel      			= {'mHaT2_4'};
config{180}.circus.outputdir    			= config{180}.datasavedir;
config{180}.circus.params.detection.spike_thresh  = '8';
config{180}.circus.params.clustering.nb_repeats   = '10';
config{180}.circus.params.clustering.max_elts     = '20000';

config{180}.bad.markerStart     = 'begin';
config{180}.bad.markerEnd       = 'SS_Start'; 

config{180}.bad.dir_list        = 'all';

config{180}.bad.sample_list     = 'all'; 

config{180}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03167_1630
config{181}                     = configcommon;
config{181}.patientid	      = 'pat_02680_1158';
config{181}.patients_root_dir   = output_patients;
config{181}.triallist           = 1;
config{181}.rawdir              = fullfile(rootpath_data, config{181}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{181}.sessionid           = 'ses-01';
config{181}.prefix              = 'pat_2680_ses01' 

config{181}.datasavedir         = fullfile(datasavedir, config{181}.patientid, config{181}.sessionid);
config{181}.imagesavedir        = fullfile(imagesavedir, config{181}.prefix);

config{181}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{181}.circus.channel      			= {'mHaT2_4'};
config{181}.circus.outputdir    			= config{181}.datasavedir;
config{181}.circus.params.detection.spike_thresh  = '8';
config{181}.circus.params.clustering.nb_repeats   = '10';
config{181}.circus.params.clustering.max_elts     = '20000';

config{181}.bad.markerStart     = 'begin';
config{181}.bad.markerEnd       = 'SS_Start'; 

config{181}.bad.dir_list        = 'all';

config{181}.bad.sample_list     = 'all'; 

config{181}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------

%% PATIENT PARAMETERS - pat_03174_1634
config{182}                     = configcommon;
config{182}.patientid	      = 'pat_02680_1158';
config{182}.patients_root_dir   = output_patients;
config{182}.triallist           = 1;
config{182}.rawdir              = fullfile(rootpath_data, config{182}.patientid,'eeg');
%SESSION PARAMETERS - ses-01
config{182}.sessionid           = 'ses-01';
config{182}.prefix              = 'pat_2680_ses01' 

config{182}.datasavedir         = fullfile(datasavedir, config{182}.patientid, config{182}.sessionid);
config{182}.imagesavedir        = fullfile(imagesavedir, config{182}.prefix);

config{182}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{182}.circus.channel      			= {'mHaT2_4'};
config{182}.circus.outputdir    			= config{182}.datasavedir;
config{182}.circus.params.detection.spike_thresh  = '8';
config{182}.circus.params.clustering.nb_repeats   = '10';
config{182}.circus.params.clustering.max_elts     = '20000';

config{182}.bad.markerStart     = 'begin';
config{182}.bad.markerEnd       = 'SS_Start'; 

config{182}.bad.dir_list        = 'all';

config{182}.bad.sample_list     = 'all'; 

config{182}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03174_1634
config{183}                     = configcommon;
config{183}.patientid	      = 'pat_02680_1158';
config{183}.patients_root_dir   = output_patients;
config{183}.triallist           = 1;
config{183}.rawdir              = fullfile(rootpath_data, config{183}.patientid,'eeg');
%SESSION PARAMETERS - ses-02
config{183}.sessionid           = 'ses-01';
config{183}.prefix              = 'pat_2680_ses01' 

config{183}.datasavedir         = fullfile(datasavedir, config{183}.patientid, config{183}.sessionid);
config{183}.imagesavedir        = fullfile(imagesavedir, config{183}.prefix);

config{183}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{183}.circus.channel      			= {'mHaT2_4'};
config{183}.circus.outputdir    			= config{183}.datasavedir;
config{183}.circus.params.detection.spike_thresh  = '8';
config{183}.circus.params.clustering.nb_repeats   = '10';
config{183}.circus.params.clustering.max_elts     = '20000';

config{183}.bad.markerStart     = 'begin';
config{183}.bad.markerEnd       = 'SS_Start'; 

config{183}.bad.dir_list        = 'all';

config{183}.bad.sample_list     = 'all'; 

config{183}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03174_1634
config{184}                     = configcommon;
config{184}.patientid	      = 'pat_02680_1158';
config{184}.patients_root_dir   = output_patients;
config{184}.triallist           = 1;
config{184}.rawdir              = fullfile(rootpath_data, config{184}.patientid,'eeg');
%SESSION PARAMETERS - ses-03
config{184}.sessionid           = 'ses-01';
config{184}.prefix              = 'pat_2680_ses01' 

config{184}.datasavedir         = fullfile(datasavedir, config{184}.patientid, config{184}.sessionid);
config{184}.imagesavedir        = fullfile(imagesavedir, config{184}.prefix);

config{184}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{184}.circus.channel      			= {'mHaT2_4'};
config{184}.circus.outputdir    			= config{184}.datasavedir;
config{184}.circus.params.detection.spike_thresh  = '8';
config{184}.circus.params.clustering.nb_repeats   = '10';
config{184}.circus.params.clustering.max_elts     = '20000';

config{184}.bad.markerStart     = 'begin';
config{184}.bad.markerEnd       = 'SS_Start'; 

config{184}.bad.dir_list        = 'all';

config{184}.bad.sample_list     = 'all'; 

config{184}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03174_1634
config{185}                     = configcommon;
config{185}.patientid	      = 'pat_02680_1158';
config{185}.patients_root_dir   = output_patients;
config{185}.triallist           = 1;
config{185}.rawdir              = fullfile(rootpath_data, config{185}.patientid,'eeg');
%SESSION PARAMETERS - ses-04
config{185}.sessionid           = 'ses-01';
config{185}.prefix              = 'pat_2680_ses01' 

config{185}.datasavedir         = fullfile(datasavedir, config{185}.patientid, config{185}.sessionid);
config{185}.imagesavedir        = fullfile(imagesavedir, config{185}.prefix);

config{185}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{185}.circus.channel      			= {'mHaT2_4'};
config{185}.circus.outputdir    			= config{185}.datasavedir;
config{185}.circus.params.detection.spike_thresh  = '8';
config{185}.circus.params.clustering.nb_repeats   = '10';
config{185}.circus.params.clustering.max_elts     = '20000';

config{185}.bad.markerStart     = 'begin';
config{185}.bad.markerEnd       = 'SS_Start'; 

config{185}.bad.dir_list        = 'all';

config{185}.bad.sample_list     = 'all'; 

config{185}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03174_1634
config{186}                     = configcommon;
config{186}.patientid	      = 'pat_02680_1158';
config{186}.patients_root_dir   = output_patients;
config{186}.triallist           = 1;
config{186}.rawdir              = fullfile(rootpath_data, config{186}.patientid,'eeg');
%SESSION PARAMETERS - ses-05
config{186}.sessionid           = 'ses-01';
config{186}.prefix              = 'pat_2680_ses01' 

config{186}.datasavedir         = fullfile(datasavedir, config{186}.patientid, config{186}.sessionid);
config{186}.imagesavedir        = fullfile(imagesavedir, config{186}.prefix);

config{186}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{186}.circus.channel      			= {'mHaT2_4'};
config{186}.circus.outputdir    			= config{186}.datasavedir;
config{186}.circus.params.detection.spike_thresh  = '8';
config{186}.circus.params.clustering.nb_repeats   = '10';
config{186}.circus.params.clustering.max_elts     = '20000';

config{186}.bad.markerStart     = 'begin';
config{186}.bad.markerEnd       = 'SS_Start'; 

config{186}.bad.dir_list        = 'all';

config{186}.bad.sample_list     = 'all'; 

config{186}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03174_1634
config{187}                     = configcommon;
config{187}.patientid	      = 'pat_02680_1158';
config{187}.patients_root_dir   = output_patients;
config{187}.triallist           = 1;
config{187}.rawdir              = fullfile(rootpath_data, config{187}.patientid,'eeg');
%SESSION PARAMETERS - ses-06
config{187}.sessionid           = 'ses-01';
config{187}.prefix              = 'pat_2680_ses01' 

config{187}.datasavedir         = fullfile(datasavedir, config{187}.patientid, config{187}.sessionid);
config{187}.imagesavedir        = fullfile(imagesavedir, config{187}.prefix);

config{187}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{187}.circus.channel      			= {'mHaT2_4'};
config{187}.circus.outputdir    			= config{187}.datasavedir;
config{187}.circus.params.detection.spike_thresh  = '8';
config{187}.circus.params.clustering.nb_repeats   = '10';
config{187}.circus.params.clustering.max_elts     = '20000';

config{187}.bad.markerStart     = 'begin';
config{187}.bad.markerEnd       = 'SS_Start'; 

config{187}.bad.dir_list        = 'all';

config{187}.bad.sample_list     = 'all'; 

config{187}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03174_1634
config{188}                     = configcommon;
config{188}.patientid	      = 'pat_02680_1158';
config{188}.patients_root_dir   = output_patients;
config{188}.triallist           = 1;
config{188}.rawdir              = fullfile(rootpath_data, config{188}.patientid,'eeg');
%SESSION PARAMETERS - ses-07
config{188}.sessionid           = 'ses-01';
config{188}.prefix              = 'pat_2680_ses01' 

config{188}.datasavedir         = fullfile(datasavedir, config{188}.patientid, config{188}.sessionid);
config{188}.imagesavedir        = fullfile(imagesavedir, config{188}.prefix);

config{188}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{188}.circus.channel      			= {'mHaT2_4'};
config{188}.circus.outputdir    			= config{188}.datasavedir;
config{188}.circus.params.detection.spike_thresh  = '8';
config{188}.circus.params.clustering.nb_repeats   = '10';
config{188}.circus.params.clustering.max_elts     = '20000';

config{188}.bad.markerStart     = 'begin';
config{188}.bad.markerEnd       = 'SS_Start'; 

config{188}.bad.dir_list        = 'all';

config{188}.bad.sample_list     = 'all'; 

config{188}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03174_1634
config{189}                     = configcommon;
config{189}.patientid	      = 'pat_02680_1158';
config{189}.patients_root_dir   = output_patients;
config{189}.triallist           = 1;
config{189}.rawdir              = fullfile(rootpath_data, config{189}.patientid,'eeg');
%SESSION PARAMETERS - ses-08
config{189}.sessionid           = 'ses-01';
config{189}.prefix              = 'pat_2680_ses01' 

config{189}.datasavedir         = fullfile(datasavedir, config{189}.patientid, config{189}.sessionid);
config{189}.imagesavedir        = fullfile(imagesavedir, config{189}.prefix);

config{189}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{189}.circus.channel      			= {'mHaT2_4'};
config{189}.circus.outputdir    			= config{189}.datasavedir;
config{189}.circus.params.detection.spike_thresh  = '8';
config{189}.circus.params.clustering.nb_repeats   = '10';
config{189}.circus.params.clustering.max_elts     = '20000';

config{189}.bad.markerStart     = 'begin';
config{189}.bad.markerEnd       = 'SS_Start'; 

config{189}.bad.dir_list        = 'all';

config{189}.bad.sample_list     = 'all'; 

config{189}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03174_1634
config{190}                     = configcommon;
config{190}.patientid	      = 'pat_02680_1158';
config{190}.patients_root_dir   = output_patients;
config{190}.triallist           = 1;
config{190}.rawdir              = fullfile(rootpath_data, config{190}.patientid,'eeg');
%SESSION PARAMETERS - ses-09
config{190}.sessionid           = 'ses-01';
config{190}.prefix              = 'pat_2680_ses01' 

config{190}.datasavedir         = fullfile(datasavedir, config{190}.patientid, config{190}.sessionid);
config{190}.imagesavedir        = fullfile(imagesavedir, config{190}.prefix);

config{190}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{190}.circus.channel      			= {'mHaT2_4'};
config{190}.circus.outputdir    			= config{190}.datasavedir;
config{190}.circus.params.detection.spike_thresh  = '8';
config{190}.circus.params.clustering.nb_repeats   = '10';
config{190}.circus.params.clustering.max_elts     = '20000';

config{190}.bad.markerStart     = 'begin';
config{190}.bad.markerEnd       = 'SS_Start'; 

config{190}.bad.dir_list        = 'all';

config{190}.bad.sample_list     = 'all'; 

config{190}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03174_1634
config{191}                     = configcommon;
config{191}.patientid	      = 'pat_02680_1158';
config{191}.patients_root_dir   = output_patients;
config{191}.triallist           = 1;
config{191}.rawdir              = fullfile(rootpath_data, config{191}.patientid,'eeg');
%SESSION PARAMETERS - ses-10
config{191}.sessionid           = 'ses-01';
config{191}.prefix              = 'pat_2680_ses01' 

config{191}.datasavedir         = fullfile(datasavedir, config{191}.patientid, config{191}.sessionid);
config{191}.imagesavedir        = fullfile(imagesavedir, config{191}.prefix);

config{191}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{191}.circus.channel      			= {'mHaT2_4'};
config{191}.circus.outputdir    			= config{191}.datasavedir;
config{191}.circus.params.detection.spike_thresh  = '8';
config{191}.circus.params.clustering.nb_repeats   = '10';
config{191}.circus.params.clustering.max_elts     = '20000';

config{191}.bad.markerStart     = 'begin';
config{191}.bad.markerEnd       = 'SS_Start'; 

config{191}.bad.dir_list        = 'all';

config{191}.bad.sample_list     = 'all'; 

config{191}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03174_1634
config{192}                     = configcommon;
config{192}.patientid	      = 'pat_02680_1158';
config{192}.patients_root_dir   = output_patients;
config{192}.triallist           = 1;
config{192}.rawdir              = fullfile(rootpath_data, config{192}.patientid,'eeg');
%SESSION PARAMETERS - ses-11
config{192}.sessionid           = 'ses-01';
config{192}.prefix              = 'pat_2680_ses01' 

config{192}.datasavedir         = fullfile(datasavedir, config{192}.patientid, config{192}.sessionid);
config{192}.imagesavedir        = fullfile(imagesavedir, config{192}.prefix);

config{192}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{192}.circus.channel      			= {'mHaT2_4'};
config{192}.circus.outputdir    			= config{192}.datasavedir;
config{192}.circus.params.detection.spike_thresh  = '8';
config{192}.circus.params.clustering.nb_repeats   = '10';
config{192}.circus.params.clustering.max_elts     = '20000';

config{192}.bad.markerStart     = 'begin';
config{192}.bad.markerEnd       = 'SS_Start'; 

config{192}.bad.dir_list        = 'all';

config{192}.bad.sample_list     = 'all'; 

config{192}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03174_1634
config{193}                     = configcommon;
config{193}.patientid	      = 'pat_02680_1158';
config{193}.patients_root_dir   = output_patients;
config{193}.triallist           = 1;
config{193}.rawdir              = fullfile(rootpath_data, config{193}.patientid,'eeg');
%SESSION PARAMETERS - ses-12
config{193}.sessionid           = 'ses-01';
config{193}.prefix              = 'pat_2680_ses01' 

config{193}.datasavedir         = fullfile(datasavedir, config{193}.patientid, config{193}.sessionid);
config{193}.imagesavedir        = fullfile(imagesavedir, config{193}.prefix);

config{193}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{193}.circus.channel      			= {'mHaT2_4'};
config{193}.circus.outputdir    			= config{193}.datasavedir;
config{193}.circus.params.detection.spike_thresh  = '8';
config{193}.circus.params.clustering.nb_repeats   = '10';
config{193}.circus.params.clustering.max_elts     = '20000';

config{193}.bad.markerStart     = 'begin';
config{193}.bad.markerEnd       = 'SS_Start'; 

config{193}.bad.dir_list        = 'all';

config{193}.bad.sample_list     = 'all'; 

config{193}.LFP.channel         = {'_HaT2_1'};

%% PATIENT PARAMETERS - pat_03174_1634
config{194}                     = configcommon;
config{194}.patientid	      = 'pat_02680_1158';
config{194}.patients_root_dir   = output_patients;
config{194}.triallist           = 1;
config{194}.rawdir              = fullfile(rootpath_data, config{194}.patientid,'eeg');
%SESSION PARAMETERS - ses-13
config{194}.sessionid           = 'ses-01';
config{194}.prefix              = 'pat_2680_ses01' 

config{194}.datasavedir         = fullfile(datasavedir, config{194}.patientid, config{194}.sessionid);
config{194}.imagesavedir        = fullfile(imagesavedir, config{194}.prefix);

config{194}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'}; 

config{194}.circus.channel      			= {'mHaT2_4'};
config{194}.circus.outputdir    			= config{194}.datasavedir;
config{194}.circus.params.detection.spike_thresh  = '8';
config{194}.circus.params.clustering.nb_repeats   = '10';
config{194}.circus.params.clustering.max_elts     = '20000';

config{194}.bad.markerStart     = 'begin';
config{194}.bad.markerEnd       = 'SS_Start'; 

config{194}.bad.dir_list        = 'all';

config{194}.bad.sample_list     = 'all'; 

config{194}.LFP.channel         = {'_HaT2_1'};

%--------------------------------------------------------
