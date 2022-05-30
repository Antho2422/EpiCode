function [config] = onset_setparams

disp('setting parameters');

if ismac
    error('Platform not supported')
elseif isunix
    rootpath_analysis   = '/network/lustre/iss02/charpier/analyses/vn_onset';
    rootpath_data       = '/network/lustre/iss02/epimicro/patients/raw';
    os                  = 'unix';
elseif ispc
    rootpath_analysis	= '\\l2export\iss02.charpier\analyses\vn_onset';
    rootpath_data       = '\\l2export\iss02.epimicro\patients\raw\';
    os                  = 'windows';
else
    error('Platform not supported')

end

datasavedir  = fullfile(rootpath_analysis,'data');
imagesavedir = fullfile(rootpath_analysis,'images');
script_path  = mfilename('fullpath');
script_path  = fileparts(script_path);

%% config common for all patients
configcommon.name                                   = {'Onset'};
configcommon.muse.write                             = true;
configcommon.circus.paramfile                       = fullfile(script_path,'onset_SpykingCircus.params');
configcommon.circus.params.filtering.cut_off        = '300, auto';
configcommon.circus.params.filtering.remove_median  = 'False';
configcommon.circus.params.detection.peaks          = 'negative';
configcommon.circus.params.data.stream_mode         = 'mapping-file';
configcommon.circus.params.data.mapping_file        = 'filelist.txt';

configcommon.statstime.timewin                      = 10; %statstime : pour fonction spikestatsOverTime.m
configcommon.statstime.slidestep                    = 1;
configcommon.statstime.minbadtime                   = 1; %temps minimum entre 2 marqueurs bad pour qu'il soit utilisé pour supprimer les données mesurées (s)
configcommon.statstime.write                        = true; %whether to save output stats on disk or recompute it each time
configcommon.statstime.plot.toi_seizure             = [-600 60]; %temps pour plot autour des crises
configcommon.spike.ISIbins                          = 0:0.001:0.150;%in seconds
configcommon.spike.RPV                              = 0.001;
configcommon.spikewaveform.nspikes                  = 1000; %100000; %1000; 'all';
configcommon.circus.correct_chunk{1}                = false;

configcommon.name                           = {'CriseStart', 'PreCrise_5s', 'PreCrise_10s', 'Crise_5s', 'LVFA', 'window'};
configcommon.LFP.name                       = {'CriseStart', 'PreCrise_5s', 'PreCrise_10s', 'Crise_5s', 'LVFA'};
configcommon.FFT.name                       = {'CriseStart', 'PreCrise_5s', 'PreCrise_10s', 'Crise_5s', 'LVFA'};
configcommon.spike.name                     = configcommon.name;

configcommon.window.length                  = 5;
configcommon.window.overlap                 = 0;
configcommon.FFT.foi.window                 = 1:40;

configcommon.muse.startmarker.CriseStart    = "CriseStart";
configcommon.muse.endmarker.CriseStart      = "CriseStart";
configcommon.epoch.toi.CriseStart           = [-40, 30];
configcommon.epoch.pad.CriseStart           = 0;
configcommon.spike.toi.CriseStart           = [-40, 30];  
configcommon.spike.pad.CriseStart           = 0;  
configcommon.FFT.foi.CriseStart             = 1:40;

configcommon.muse.startmarker.PreCrise_5s    = "CriseStart";
configcommon.muse.endmarker.PreCrise_5s      = "CriseStart";
configcommon.epoch.toi.PreCrise_5s           = [-5, 0];
configcommon.epoch.pad.PreCrise_5s           = 0;
configcommon.spike.toi.PreCrise_5s           = [-5, 0];  
configcommon.spike.pad.PreCrise_5s           = 0;  
configcommon.FFT.foi.PreCrise_5s             = 1:40;

configcommon.muse.startmarker.PreCrise_10s    = "CriseStart";
configcommon.muse.endmarker.PreCrise_10s      = "CriseStart";
configcommon.epoch.toi.PreCrise_10s           = [-10, -5];
configcommon.epoch.pad.PreCrise_10s           = 0;
configcommon.spike.toi.PreCrise_10s           = [-10, -5];  
configcommon.spike.pad.PreCrise_10s           = 0;  
configcommon.FFT.foi.PreCrise_10s             = 1:40;

configcommon.muse.startmarker.Crise_5s    = "CriseStart";
configcommon.muse.endmarker.Crise_5s      = "CriseStart";
configcommon.epoch.toi.Crise_5s           = [0, 5];
configcommon.epoch.pad.Crise_5s           = 0;
configcommon.spike.toi.Crise_5s           = [0, 5];  
configcommon.spike.pad.Crise_5s           = 0;  
configcommon.FFT.foi.Crise_5s             = 1:40;

configcommon.muse.startmarker.LVFA    = "CriseStart";
configcommon.muse.endmarker.LVFA      = "LVFA_End";
configcommon.epoch.toi.LVFA           = [0, 0];
configcommon.epoch.pad.LVFA           = 0;
configcommon.spike.toi.LVFA           = [0, 0];  
configcommon.spike.pad.LVFA           = 0;  
configcommon.FFT.foi.LVFA             = 1:40;

%LFP rereferencing in readLFP.m :
configcommon.LFP.reref                = 'yes';
configcommon.LFP.rerefmethod          = 'bipolar';

configcommon.spikewaveform.lpfreq     = 3000;

configcommon.TFR.raw.zlim = "maxmin";
configcommon.TFR.blcorrected.zlim = "maxmin";

%% patient 1
config{1}                     = configcommon;
config{1}.group               = 'slowwave'; 
config{1}.triallist           = 1;

config{1}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{1}.imagesavedir        = fullfile(imagesavedir, 'pat_03046_1482_Crise1_mHaT2');
config{1}.prefix              = 'pat_03046_1482_Crise1_mHaT2-';                     %patient name Must end by "-". namepatient-
config{1}.rawdir              = fullfile(rootpath_data,'pat_03046_1482','eeg');             %path to patient data
config{1}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'};                    %list of folders to analyse
config{1}.LFP.channel         = {'_HaT2_1','_HaT2_2','_HmT2_1','_HmT2_2','_Tpol_1','_Tpol_2'};  
%config{1}.LFP.resamplefs      = 250;

config{1}.circus.channel      = {'mHaT2_4'};       %name of the first electrode
config{1}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');

config{1}.circus.params.detection.spike_thresh  = '8';
config{1}.circus.params.clustering.nb_repeats   = '10';
config{1}.circus.params.clustering.max_elts     = '20000';

% config{1}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{1}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{1}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{1}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{1}.bad.sample_list     = 1; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{1}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)

%% patient 2
config{2}                     = configcommon;
config{2}.group               = 'slowwave';
config{2}.triallist           = 1;

config{2}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{2}.imagesavedir        = fullfile(imagesavedir, 'pat_03046_1482_Crise1_mHmT2');
config{2}.prefix              = 'pat_03046_1482_Crise1_mHmT2-';                                                        %patient name. Must end by "-". namepatient-
config{2}.rawdir              = fullfile(rootpath_data,'pat_03046_1482','eeg');                       %path to patient data
config{2}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'};                                               %list of folders to analyse
config{2}.circus.channel      = {'mHmT2_6','mHmT2_7','mHmT2_8'};       %name of the first electrode
config{2}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');

config{2}.circus.params.detection.spike_thresh  = '7';
config{2}.circus.params.clustering.nb_repeats   = '10';
config{2}.circus.params.clustering.max_elts     = '20000';

config{2}.LFP.channel         = {'_HmT2_1'};       %name the macro contact in the SOZ

% config{2}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{2}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{2}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{2}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{2}.bad.sample_list     = 1; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{2}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)

%% patient 3
config{3}                                       = configcommon;
config{3}.group                                 = 'simple';
config{3}.triallist                             = 2;
config{3}.datasavedir                           = datasavedir;       %path where to save MuseStruct data
config{3}.imagesavedir                          = fullfile(imagesavedir, 'pat_03046_1482_Crise2_mHaT2');
config{3}.prefix                                = 'pat_03046_1482_Crise2_mHaT2-';                                                        %patient name. Must end by "-". namepatient-
config{3}.rawdir                                = fullfile(rootpath_data,'pat_03046_1482','eeg');                       %path to patient data
config{3}.directorylist{1}                      = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'};                                               %list of folders to analyse
config{3}.circus.channel                        = {'mHaT2_4'};       %name of the first electrode
config{3}.circus.outputdir                      = fullfile(rootpath_analysis, 'data', 'SpykingCircus');


config{3}.circus.params.detection.spike_thresh  = '7';
config{3}.circus.params.clustering.nb_repeats   = '10';
config{3}.circus.params.clustering.max_elts     = '20000';

config{3}.LFP.channel         = {'_HaT2_1'};       %name the macro contact in the SOZ

% config{3}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{3}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{3}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{3}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{3}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{3}.bad.time_from_begin = 60; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)


%% patient 4
config{4}                     = configcommon;
config{4}.group               = 'simple';
config{4}.triallist           = 2;

config{4}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{4}.imagesavedir        = fullfile(imagesavedir, 'pat_03046_1482_Crise2_mHmT2');
config{4}.prefix              = 'pat_03046_1482_Crise2_mHmT2-';                                                        %patient name. Must end by "-". namepatient-
config{4}.rawdir              = fullfile(rootpath_data,'pat_03046_1482','eeg');                       %path to patient data
config{4}.directorylist{1}    = {'03046_2021-07-11_05-52','03046_2021-07-11_07-52'};                                               %list of folders to analyse
config{4}.circus.channel      = {'mHmT2_6','mHmT2_7','mHmT2_8'};       %name of the first electrode
config{4}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');


config{4}.circus.params.detection.spike_thresh  = '8';
config{4}.circus.params.clustering.nb_repeats   = '10';
config{4}.circus.params.clustering.max_elts     = '20000';

config{4}.LFP.channel         = {'_HmT2_1'};       %name the macro contact in the SOZ

%config{4}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{4}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{4}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{4}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{4}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{4}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)

config{4}.TFR.raw.zlim = [0 200];

%% patient 5
config{5}                     = configcommon;
config{5}.group               = 'slowwave';
config{5}.triallist           = 1;

config{5}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{5}.imagesavedir        = fullfile(imagesavedir, 'pat_02757_1244_Crise6_mF1p');
config{5}.prefix              = 'pat_02757_1244_Crise6_mF1p-';                                                        %patient name. Must end by "-". namepatient-
config{5}.rawdir              = fullfile(rootpath_data,'pat_02757_1244','eeg');                       %path to patient data
config{5}.directorylist{1}    = {'02757_2019-09-14_01-46','02757_2019-09-14_03-46'};                                               %list of folders to analyse
config{5}.circus.channel      = {'mF1p_3'};       %name of the first electrode
config{5}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');

config{5}.circus.params.detection.spike_thresh  = '7.5';
config{5}.circus.params.clustering.nb_repeats   = '10';
config{5}.circus.params.clustering.max_elts     = '30000';

config{5}.LFP.channel         = {'_F1p_1'};       %name the macro contact in the SOZ

%config{5}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{5}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{5}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{5}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{5}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{5}.bad.time_from_begin = 1700; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)

%% patient 6
% config{6}                     = configcommon;
% config{6}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{6}.imagesavedir        = fullfile(imagesavedir, 'pat_02599_1057_Crise2_mHaT2');
% config{6}.prefix              = 'pat_02599_1057_Crise2_mHaT2-';                                                        %patient name. Must end by "-". namepatient-
% config{6}.rawdir              = fullfile(rootpath_data,'pat_02599_1057','eeg');                       %path to patient data
% config{6}.directorylist{1}    = {'02599_2018-04-25_13-24','02599_2018-04-25_15-24'};                                               %list of folders to analyse
% config{6}.circus.channel      = {'mHaT2_6'};       %name of the first electrode
% config{6}.circus.refchan      = '';
% config{6}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{6}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{6}.circus.hpfreq       = 0; % even when not using[]
% config{6}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{6}.circus.params.detection.spike_thresh  = '6';
% config{6}.circus.params.clustering.nb_repeats   = '10';
% config{6}.circus.params.clustering.max_elts     = '20000';
% 
% config{6}.LFP.channel         = {'_HaT2_'};       %name the macro contact in the SOZ
% 
% config{6}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{6}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{6}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{6}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{6}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{6}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% 
% %% patient 7
% config{7}                     = configcommon;
% config{7}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{7}.imagesavedir        = fullfile(imagesavedir, 'pat_02614_1073_Crise9_mTNmi');
% config{7}.prefix              = 'pat_02614_1073_Crise9_mTNmi-';                                                        %patient name. Must end by "-". namepatient-
% config{7}.rawdir              = fullfile(rootpath_data,'pat_02614_1073','eeg');                       %path to patient data
% config{7}.directorylist{1}    = {'02614_2018-06-25_10-47'};                                               %list of folders to analyse
% config{7}.circus.channel      = {'mTNmi_5','mTNmi_7','mTNmi_8'};       %name of the first electrode
% config{7}.circus.reref        = 'no';
% config{7}.circus.refchan      = '';
% config{7}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{7}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{7}.circus.hpfreq       = 0; % even when not using
% config{7}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{7}.circus.params.detection.spike_thresh  = '8';
% config{7}.circus.params.clustering.nb_repeats   = '10';
% config{7}.circus.params.clustering.max_elts     = '20000';
% 
% config{7}.LFP.channel         = {'_TNmi_'};       %name the macro contact in the SOZ
% 
% config{7}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{7}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{7}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{7}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{7}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{7}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% 
% %% patient 8
% config{8}                     = configcommon;
% config{8}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{8}.imagesavedir        = fullfile(imagesavedir, 'pat_02614_1073_Crise11a_mTNmi');
% config{8}.prefix              = 'pat_02614_1073_Crise11a_mTNmi-';                                                        %patient name. Must end by "-". namepatient-
% config{8}.rawdir              = fullfile(rootpath_data,'pat_02614_1073','eeg');                       %path to patient data
% config{8}.directorylist{1}    = {'02614_2018-06-25_14-47','02614_2018-06-25_16-47'};                                               %list of folders to analyse
% config{8}.circus.channel      = {'mTNmi_5','mTNmi_7','mTNmi_8'};       %name of the first electrode
% config{8}.circus.reref        = 'no';
% config{8}.circus.refchan      = '';
% config{8}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{8}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{8}.circus.hpfreq       = 0; % even when not using
% config{8}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{8}.circus.params.detection.spike_thresh  = '7.5';
% config{8}.circus.params.clustering.nb_repeats   = '10';
% config{8}.circus.params.clustering.max_elts     = '20000';
% 
% config{8}.LFP.channel         = {'_HaT2_'};       %name the macro contact in the SOZ
% 
% config{8}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{8}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{8}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{8}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{8}.bad.sample_list     = 1; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{8}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 9
% config{9}                     = configcommon;
% config{9}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{9}.imagesavedir        = fullfile(imagesavedir, 'pat_02614_1073_Crise11b_mTNmi');
% config{9}.prefix              = 'pat_02614_1073_Crise11b_mTNmi-';                                                        %patient name. Must end by "-". namepatient-
% config{9}.rawdir              = fullfile(rootpath_data,'pat_02614_1073','eeg');                       %path to patient data
% config{9}.directorylist{1}    = {'02614_2018-06-25_14-47','02614_2018-06-25_16-47'};                                               %list of folders to analyse
% config{9}.circus.channel      = {'mTNmi_5','mTNmi_7','mTNmi_8'};       %name of the first electrode
% config{9}.circus.reref        = 'no';
% config{9}.circus.refchan      = '';
% config{9}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{9}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{9}.circus.hpfreq       = 0; % even when not using
% config{9}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{9}.circus.params.detection.spike_thresh  = '8';
% config{9}.circus.params.clustering.nb_repeats   = '10';
% config{9}.circus.params.clustering.max_elts     = '20000';
% 
% config{9}.LFP.channel         = {'_TNmi_'};       %name the macro contact in the SOZ
% 
% config{9}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{9}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{9}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{9}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{9}.bad.sample_list     = 2; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{9}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 10
% config{10}                     = configcommon;
% config{10}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{10}.imagesavedir        = fullfile(imagesavedir, 'pat_03046_1482_Crise3_mHaT2');
% config{10}.prefix              = 'pat_03046_1482_Crise3_mHaT2-';                                                        %patient name. Must end by "-". namepatient-
% config{10}.rawdir              = fullfile(rootpath_data,'pat_03046_1482','eeg');                       %path to patient data
% config{10}.directorylist{1}    = {'03046_2021-07-15_12-23','03046_2021-07-15_14-23'};                                               %list of folders to analyse
% config{10}.circus.channel      = {'mHaT2_4','mHaT2_5'};       %name of the first electrode
% config{10}.circus.reref        = 'no';
% config{10}.circus.refchan      = '';
% config{10}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{10}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{10}.circus.hpfreq       = 0; % even when not using
% config{10}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{10}.circus.params.detection.spike_thresh  = '7';
% config{10}.circus.params.clustering.nb_repeats   = '10';
% config{10}.circus.params.clustering.max_elts     = '20000';
% 
% config{10}.LFP.channel         = {'_HaT2_'};       %name the macro contact in the SOZ
% 
% config{10}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{10}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{10}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{10}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{10}.bad.sample_list     = 1; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{10}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 11
% config{11}                     = configcommon;
% config{11}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{11}.imagesavedir        = fullfile(imagesavedir, 'pat_02306_0751_Crise7_mHmT2');
% config{11}.prefix              = 'pat_02306_0751_Crise7_mHmT2-';                                                        %patient name. Must end by "-". namepatient-
% config{11}.rawdir              = fullfile(rootpath_data,'pat_02306_0751','eeg');                       %path to patient data
% config{11}.directorylist{1}    = {'02306_2015-09-30_08-31'};                                               %list of folders to analyse
% config{11}.circus.channel      = {'mHmT2_6'};       %name of the first electrode
% config{11}.circus.reref        = 'no';
% config{11}.circus.refchan      = '';
% config{11}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{11}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{11}.circus.hpfreq       = 0; % even when not using
% config{11}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{11}.circus.params.detection.spike_thresh  = '7';[]
% config{11}.circus.params.clustering.nb_repeats   = '10';
% config{11}.circus.params.clustering.max_elts     = '20000';
% 
% config{11}.LFP.channel         = {'_HmT2_'};       %name the macro contact in the SOZ
% 
% config{11}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{11}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{11}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{11}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{11}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{11}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
%% patient 12
config{12}                     = configcommon;
config{12}.group               = 'simple';
config{12}.triallist           = 1;
 
config{12}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{12}.imagesavedir        = fullfile(imagesavedir, 'pat_02256_0700_Crise1_m2mCi');
config{12}.prefix              = 'pat_02256_0700_Crise1_m2mCi-';                                                        %patient name. Must end by "-". namepatient-
config{12}.rawdir              = fullfile(rootpath_data,'pat_02256_0700','eeg');                       %path to patient data
config{12}.directorylist{1}    = {'02256_2015-05-09_05-37','02256_2015-05-09_07-37'};                                               %list of folders to analyse
config{12}.circus.channel      = {'m2mCi_2','m2mCi_5','m2mCi_6','m2mCi_7','m2mCi_8'};       %name of the first electrode
config{12}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
config{12}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC

config{12}.circus.params.detection.spike_thresh  = '6';
config{12}.circus.params.filtering.common_ground = '{1:3}';% reref : {group_channel : ground channel} with ground channel = reref channel index in channel list START AT 0
config{12}.circus.params.clustering.nb_repeats   = '10';
config{12}.circus.params.clustering.max_elts     = '20000';

config{12}.LFP.channel         = {'_2mCi_1'};       %name the macro contact in the SOZ

%config{12}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{12}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{12}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{12}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{12}.bad.sample_list     = 1; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{12}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
%% patient 13
config{13}                     = configcommon;
config{13}.group               = 'slowwave';
config{13}.triallist           = 1;

config{13}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{13}.imagesavedir        = fullfile(imagesavedir, 'pat_02256_0700_Crise2_m2mCi');
config{13}.prefix              = 'pat_02256_0700_Crise2_m2mCi-';                                                        %patient name. Must end by "-". namepatient-
config{13}.rawdir              = fullfile(rootpath_data,'pat_02256_0700','eeg');                       %path to patient data
config{13}.directorylist{1}    = {'02256_2015-05-21_03-28','02256_2015-05-21_05-28'};                                               %list of folders to analyse
config{13}.circus.channel      = {'m2mCi_2', 'm2mCi_5', 'm2mCi_6','m2mCi_7','m2mCi_8'};       %name of the first electrode
config{13}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');


config{13}.circus.params.detection.spike_thresh  = '8';
config{13}.circus.params.filtering.common_ground = '{1:1}';% reref : {group_channel : ground channel} with ground channel = reref channel index in channel list START AT 0 
config{13}.circus.params.clustering.nb_repeats   = '10';
config{13}.circus.params.clustering.max_elts     = '20000';

config{13}.LFP.channel         = {'_2mCi_1'};       %name the macro contact in the SOZ

%config{13}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{13}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{13}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{13}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{13}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{13}.bad.time_from_begin = 60; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
%% patient 14
% config{14}                     = configcommon;
% config{14}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{14}.imagesavedir        = fullfile(imagesavedir, 'pat_02230_0674_Crise1_m1pNs');
% config{14}.prefix              = 'pat_02230_0674_Crise1_m1pNs-';                                                        %patient name. Must end by "-". namepatient-
% config{14}.rawdir              = fullfile(rootpath_data,'pat_02230_0674','eeg');                       %path to patient data
% config{14}.directorylist{1}    = {'02230_2015-02-25_14-36','02230_2015-02-25_15-16'};                                               %list of folders to analyse
% config{14}.circus.channel      = {'m1pNs_1','m1pNs_8'};       %name of the first electrode
% config{14}.circus.reref        = 'no';
% config{14}.circus.refchan      = '';
% config{14}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{14}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{14}.circus.hpfreq       = 0; % even when not using
% config{14}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{14}.circus.params.detection.spike_thresh  = '9';
% config{14}.circus.params.clustering.nb_repeats   = '10';
% config{14}.circus.params.clustering.max_elts     = '20000';
% 
% config{14}.LFP.channel         = {'_1pNs_'};       %name the macro contact in the SOZ
% 
% config{14}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{14}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{14}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{14}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{14}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{14}.bad.time_from_begin = 600; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
%% patient 15
config{15}                     = configcommon;
config{15}.group               = 'slowwave';
config{15}.triallist            = 2;

config{15}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{15}.imagesavedir        = fullfile(imagesavedir, 'pat_02230_0674_Crise2_m1pNs');
config{15}.prefix              = 'pat_02230_0674_Crise2_m1pNs-';                                                        %patient name. Must end by "-". namepatient-
config{15}.rawdir              = fullfile(rootpath_data,'pat_02230_0674','eeg');                       %path to patient data
config{15}.directorylist{1}    = {'02230_2015-02-25_15-16','02230_2015-02-25_17-16'};                                               %list of folders to analyse
config{15}.circus.channel      = {'m1pNs_1','m1pNs_8'};       %name of the first electrode
config{15}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');


config{15}.circus.params.detection.spike_thresh  = '7';
config{15}.circus.params.clustering.nb_repeats   = '10';
config{15}.circus.params.clustering.max_elts     = '20000';

config{15}.LFP.channel         = {'_1pNs_1'};       %name the macro contact in the SOZ

%config{15}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{15}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{15}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{15}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{15}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{15}.bad.time_from_begin = 1400; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
%% patient 16
config{16}                     = configcommon;
config{16}.group               = 'slowwave';
config{16}.triallist           = 1;

config{16}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{16}.imagesavedir        = fullfile(imagesavedir, 'pat_02230_0674_Crise3_m1pNs');
config{16}.prefix              = 'pat_02230_0674_Crise3_m1pNs-';                                                        %patient name. Must end by "-". namepatient-
config{16}.rawdir              = fullfile(rootpath_data,'pat_02230_0674','eeg');                       %path to patient data
config{16}.directorylist{1}    = {'02230_2015-02-27_22-34','02230_2015-02-28_00-34'};                                               %list of folders to analyse
config{16}.circus.channel      = {'m1pNs_1','m1pNs_4','m1pNs_7'};       %name of the first electrode
config{16}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');


config{16}.circus.params.detection.spike_thresh  = '8';
config{16}.circus.params.clustering.nb_repeats   = '10';
config{16}.circus.params.clustering.max_elts     = '20000';

config{16}.LFP.channel         = {'_1pNs_1'};       %name the macro contact in the SOZ

%config{16}.seizure_index       = 'last' ; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{16}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{16}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{16}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{16}.bad.sample_list     = 1; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{16}.bad.time_from_begin = 600; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
%% patient 17
% config{17}                     = configcommon;
% config{17}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{17}.imagesavedir        = fullfile(imagesavedir, 'pat_02614_1073_Crise5_mTNmi');
% config{17}.prefix              = 'pat_02614_1073_Crise5_mTNmi-';                                                        %patient name. Must end by "-". namepatient-
% config{17}.rawdir              = fullfile(rootpath_data,'pat_02614_1073','eeg');                       %path to patient data
% config{17}.directorylist{1}    = {'02614_2018-06-25_05-23','02614_2018-06-25_07-23'};                                               %list of folders to analyse
% config{17}.circus.channel      = {'mTNmi_5','mTNmi_7','mTNmi_8'};       %name of the first electrode
% config{17}.circus.reref        = 'no';
% config{17}.circus.refchan      = '';
% config{17}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{17}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{17}.circus.hpfreq       = 0; % even when not using
% config{17}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{17}.circus.params.detection.spike_thresh  = '6';
% config{17}.circus.params.clustering.nb_repeats   = '10';
% config{17}.circus.params.clustering.max_elts     = '20000';
% 
% config{17}.LFP.channel         = {'_TNmi_'};       %name the macro contact in the SOZ
% 
% config{17}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{17}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{17}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{17}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{17}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{17}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 18
% config{18}                     = configcommon;
% config{18}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{18}.imagesavedir        = fullfile(imagesavedir, 'pat_02614_1073_Crise6_mTNmi');
% config{18}.prefix              = 'pat_02614_1073_Crise6_mTNmi-';                                                        %patient name. Must end by "-". namepatient-
% config{18}.rawdir              = fullfile(rootpath_data,'pat_02614_1073','eeg');                       %path to patient data
% config{18}.directorylist{1}    = {'02614_2018-06-25_09-23','02614_2018-06-25_10-47'};                                               %list of folders to analyse
% config{18}.circus.channel      = {'mTNmi_5','mTNmi_7','mTNmi_8'};       %name of the first electrode
% config{18}.circus.reref        = 'no';
% config{18}.circus.refchan      = '';
% config{18}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{18}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{18}.circus.hpfreq       = 0; % even when not using
% config{18}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{18}.circus.params.detection.spike_thresh  = '6';
% config{18}.circus.params.clustering.nb_repeats   = '10';
% config{18}.circus.params.clustering.max_elts     = '20000';
% 
% config{18}.LFP.channel         = {'_TNmi_'};       %name the macro contact in the SOZ
% 
% config{18}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{18}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{18}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{18}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{18}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{18}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 19
% config{19}                     = configcommon;
% config{19}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{19}.imagesavedir        = fullfile(imagesavedir, 'pat_02614_1073_Crise7_mTNmi');
% config{19}.prefix              = 'pat_02614_1073_Crise7_mTNmi-';                                                        %patient name. Must end by "-". namepatient-
% config{19}.rawdir              = fullfile(rootpath_data,'pat_02614_1073','eeg');                       %path to patient data
% config{19}.directorylist{1}    = {'02614_2018-06-27_01-46','02614_2018-06-27_03-46'};                                               %list of folders to analyse
% config{19}.circus.channel      = {'mTNmi_5','mTNmi_7','mTNmi_8'};       %name of the first electrode
% config{19}.circus.reref        = 'no';
% config{19}.circus.refchan      = '';
% config{19}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{19}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{19}.circus.hpfreq       = 0; % even when not using
% config{19}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{19}.circus.params.detection.spike_thresh  = '6';
% config{19}.circus.params.clustering.nb_repeats   = '10';
% config{19}.circus.params.clustering.max_elts     = '20000';
% 
% config{19}.LFP.channel         = {'_TNmi_'};       %name the macro contact in the SOZ
% 
% config{19}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{19}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{19}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{19}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{19}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{19}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 20
% config{20}                     = configcommon;
% config{20}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{20}.imagesavedir        = fullfile(imagesavedir, 'pat_02222_0667_Crise1_mAmT2');
% config{20}.prefix              = 'pat_02222_0667_Crise1_mAmT2-';                                                        %patient name. Must end by "-". namepatient-
% config{20}.rawdir              = fullfile(rootpath_data,'pat_02222_0667','eeg');                       %path to patient data
% config{20}.directorylist{1}    = {'02222_2015-01-30_16-32','02222_2015-01-30_18-32'};                                               %list of folders to analyse
% config{20}.circus.channel      = {'mAmT2_8'};       %name of the first electrode
% config{20}.circus.reref        = 'no';
% config{20}.circus.refchan      = '';
% config{20}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{20}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{20}.circus.hpfreq       = 0; % even when not using
% config{20}.circus.postfix      = []; % after using circus-gui-matlab's
% 
% 
% config{20}.circus.params.detection.spike_thresh  = '6';
% config{20}.circus.params.clustering.nb_repeats   = '10';
% config{20}.circus.params.clustering.max_elts     = '20000';
% 
% config{20}.LFP.channel         = {'_AmT2_'};       %name the macro contact in the SOZ
% 
% config{20}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{20}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{20}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{20}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{20}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{20}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 21
% config{21}                     = configcommon;
% config{21}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{21}.imagesavedir        = fullfile(imagesavedir, 'pat_02222_0667_Crise2_mAmT2');
% config{21}.prefix              = 'pat_02222_0667_Crise2_mAmT2-';                                                        %patient name. Must end by "-". namepatient-
% config{21}.rawdir              = fullfile(rootpath_data,'pat_02222_0667','eeg');                       %path to patient data
% config{21}.directorylist{1}    = {'02222_2015-02-10_03-47','02222_2015-02-10_05-47'};                                               %list of folders to analyse
% config{21}.circus.channel      = {'mAmT2_8'};       %name of the first electrode
% config{21}.circus.reref        = 'no';
% config{21}.circus.refchan      = '';
% config{21}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{21}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{21}.circus.hpfreq       = 0; % even when not using
% config{21}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{21}.circus.params.detection.spike_thresh  = '6';
% config{21}.circus.params.clustering.nb_repeats   = '10';
% config{21}.circus.params.clustering.max_elts     = '20000';
% 
% config{21}.LFP.channel         = {'_AmT2_'};       %name the macro contact in the SOZ
% 
% config{21}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)%
% config{21}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{21}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{21}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{21}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{21}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 22
% config{22}                     = configcommon;
% config{22}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{22}.imagesavedir        = fullfile(imagesavedir, 'pat_02222_0667_Crise3_mAmT2');
% config{22}.prefix              = 'pat_02222_0667_Crise3_mAmT2-';                                                        %patient name. Must end by "-". namepatient-
% config{22}.rawdir              = fullfile(rootpath_data,'pat_02222_0667','eeg');                       %path to patient data
% config{22}.directorylist{1}    = {'02222_2015-02-10_05-47','02222_2015-02-10_07-47'};                                               %list of folders to analyse
% config{22}.circus.channel      = {'mAmT2_8'};       %name of the first electrode
% config{22}.circus.reref        = 'no';
% config{22}.circus.refchan      = '';
% config{22}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{22}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{22}.circus.hpfreq       = 0; % even when not using
% config{22}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{22}.circus.params.detection.spike_thresh  = '6';
% config{22}.circus.params.clustering.nb_repeats   = '10';
% config{22}.circus.params.clustering.max_elts     = '20000';
% 
% config{22}.LFP.channel         = {'_AmT2_'};       %name the macro contact in the SOZ
% 
% config{22}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{22}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{22}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{22}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{22}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{22}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 23
% config{23}                     = configcommon;
% config{23}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{23}.imagesavedir        = fullfile(imagesavedir, 'pat_02222_0667_Crise4_mAmT2');
% config{23}.prefix              = 'pat_02222_0667_Crise4_mAmT2-';                                                        %patient name. Must end by "-". namepatient-
% config{23}.rawdir              = fullfile(rootpath_data,'pat_02222_0667','eeg');                       %path to patient data
% config{23}.directorylist{1}    = {'02222_2015-02-10_05-47','02222_2015-02-10_07-47'};                                               %list of folders to analyse
% config{23}.circus.channel      = {'mAmT2_8'};       %name of the first electrode
% config{23}.circus.reref        = 'no';
% config{23}.circus.refchan      = '';
% config{23}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{23}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{23}.circus.hpfreq       = 0; % even when not using
% %config{23}.circus.postfix      = ['1']; % after using circus-gui-matlab's SAVE number
% 
% config{23}.circus.params.detection.spike_thresh  = '9';
% config{23}.circus.params.clustering.nb_repeats   = '10';
% config{23}.circus.params.clustering.max_elts     = '20000';
% 
% config{23}.LFP.channel         = {'_AmT2_'};       %name the macro contact in the SOZ
% 
% config{23}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{23}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{23}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{23}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{23}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{23}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 24
% config{24}                     = configcommon;
% config{24}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{24}.imagesavedir        = fullfile(imagesavedir, 'pat_02141_0579_Crise1_mHaT1');
% config{24}.prefix              = 'pat_02141_0579_Crise1_mHaT1-';                                                        %patient name. Must end by "-". namepatient-
% config{24}.rawdir              = fullfile(rootpath_data,'pat_02141_0579','eeg');                       %path to patient data
% config{24}.directorylist{1}    = {'02141_2014-03-25_05-34','02141_2014-03-25_07-34'};                                               %list of folders to analyse
% config{24}.circus.channel      = {'mHaT1_5','mHaT1_7'};       %name of the first electrode
% config{24}.circus.reref        = 'no';
% config{24}.circus.refchan      = '';
% config{24}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{24}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{24}.circus.hpfreq       = 0; % even when not using
% config{24}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{24}.circus.params.detection.spike_thresh  = '8';
% config{24}.circus.params.clustering.nb_repeats   = '10';
% config{24}.circus.params.clustering.max_elts     = '20000';
% 
% config{24}.LFP.channel         = {'_HaT1_'};       %name the macro contact in the SOZ
% 
% config{24}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{24}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{24}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{24}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{24}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{24}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 25
% config{25}                     = configcommon;
% config{25}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{25}.imagesavedir        = fullfile(imagesavedir, 'pat_02141_0579_Crise2_mHaT1');
% config{25}.prefix              = 'pat_02141_0579_Crise2_mHaT1g-';                                                        %patient name. Must end by "-". namepatient-
% config{25}.rawdir              = fullfile(rootpath_data,'pat_02141_0579','eeg');                       %path to patient data
% config{25}.directorylist{1}    = {'02141_2014-03-29_05-34','02141_2014-03-29_07-34'};                                               %list of folders to analyse
% config{25}.circus.channel      = {'mHaT1_5','mHaT1_7'};       %name of the first electrode
% config{25}.circus.reref        = 'no';
% config{25}.circus.refchan      = '';
% config{25}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{25}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{25}.circus.hpfreq       = 0; % even when not using
% config{25}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{25}.circus.params.detection.spike_thresh  = '6';
% config{25}.circus.params.clustering.nb_repeats   = '10';
% config{25}.circus.params.clustering.max_elts     = '20000';
% 
% config{25}.LFP.channel         = {'_Ha2g_'};       %name the macro contact in the SOZ
% 
% config{25}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{25}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{25}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{25}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{25}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{25}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 26
% config{26}                     = configcommon;
% config{26}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{26}.imagesavedir        = fullfile(imagesavedir, 'pat_02141_0579_Crise3_mHaT1');
% config{26}.prefix              = 'pat_02141_0579_Crise3_mHaT1-';                                                        %patient name. Must end by "-". namepatient-
% config{26}.rawdir              = fullfile(rootpath_data,'pat_02141_0579','eeg');                       %path to patient data
% config{26}.directorylist{1}    = {'02141_2014-03-29_07-34','02141_2014-03-29_09-34'};                                               %list of folders to analyse
% config{26}.circus.channel      = {'mHaT1_5','mHaT1_7'};       %name of the first electrode
% config{26}.circus.reref        = 'no';
% config{26}.circus.refchan      = '';
% config{26}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{26}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{26}.circus.hpfreq       = 0; % even when not using
% config{26}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{26}.circus.params.detection.spike_thresh  = '6';
% config{26}.circus.params.clustering.nb_repeats   = '10';
% config{26}.circus.params.clustering.max_elts     = '20000';
% 
% config{26}.LFP.channel         = {'_HaT1_'};       %name the macro contact in the SOZ
% 
% config{26}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{26}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{26}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{26}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{26}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{26}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 27
% config{27}                     = configcommon;
% config{27}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{27}.imagesavedir        = fullfile(imagesavedir, 'pat_02141_0579_Crise4_mHaT1');
% config{27}.prefix              = 'pat_02141_0579_Crise4_mHaT1-';                                                        %patient name. Must end by "-". namepatient-
% config{27}.rawdir              = fullfile(rootpath_data,'pat_02141_0579','eeg');                       %path to patient data
% config{27}.directorylist{1}    = {'02141_2014-03-31_20-34','02141_2014-03-31_22-34'};                                               %list of folders to analyse
% config{27}.circus.channel      = {'mHaT1_7'};       %name of the first electrode
% config{27}.circus.reref        = 'no';
% config{27}.circus.refchan      = '';
% config{27}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{27}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{27}.circus.hpfreq       = 0; % even when not using
% config{27}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{27}.circus.params.detection.spike_thresh  = '6';
% config{27}.circus.params.clustering.nb_repeats   = '10';
% config{27}.circus.params.clustering.max_elts     = '20000';
% 
% config{27}.LFP.channel         = {'_HaT1_'};       %name the macro contact in the SOZ
% 
% config{27}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{27}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{27}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{27}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{27}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{27}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
% %% patient 28
% config{28}                     = configcommon;
% config{28}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{28}.imagesavedir        = fullfile(imagesavedir, 'pat_02141_0579_Crise5_mHaT1');
% config{28}.prefix              = 'pat_02141_0579_Crise5_mHaT1-';                                                        %patient name. Must end by "-". namepatient-
% config{28}.rawdir              = fullfile(rootpath_data,'pat_02141_0579','eeg');                       %path to patient data
% config{28}.directorylist{1}    = {'02141_2014-04-01_04-34','02141_2014-04-01_06-34'};                                               %list of folders to analyse
% config{28}.circus.channel      = {'mHaT1_7'};       %name of the first electrode
% config{28}.circus.reref        = 'no';
% config{28}.circus.refchan      = '';
% config{28}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{28}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{28}.circus.hpfreq       = 0; % even when not using
% config{28}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{28}.circus.params.detection.spike_thresh  = '6';
% config{28}.circus.params.clustering.nb_repeats   = '10';
% config{28}.circus.params.clustering.max_elts     = '20000';
% 
% config{28}.LFP.channel         = {'_HaT1_'};       %name the macro contact in the SOZ
% 
% config{28}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{28}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{28}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{28}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{28}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{28}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)
%% patient 29
config{29}                     = configcommon;
config{29}.group               = 'simple';
config{29}.triallist           = 4;

config{29}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{29}.imagesavedir        = fullfile(imagesavedir, 'pat_02161_0599_Crise2_mHa1d');
config{29}.prefix              = 'pat_02161_0599_Crise2_mHa1d-';                                                        %patient name. Must end by "-". namepatient-
config{29}.rawdir              = fullfile(rootpath_data,'pat_02161_0599','eeg');                       %path to patient data
config{29}.directorylist{1}    = {'02161_2014-06-04_14-01','02161_2014-06-04_16-01'};                                               %list of folders to analyse
config{29}.circus.channel      = {'mHa1d_2'};       %name of the first electrode
config{29}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');


config{29}.circus.params.detection.spike_thresh  = '8';
config{29}.circus.params.clustering.nb_repeats   = '10';
config{29}.circus.params.clustering.max_elts     = '20000';

config{29}.LFP.channel         = {'_Ha1d_1'};       %name the macro contact in the SOZ

%config{29}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{29}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{29}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{29}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{29}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{29}.bad.time_from_begin = 600; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)

%% patient 30
% config{30}                     = configcommon;
% config{30}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{30}.imagesavedir        = fullfile(imagesavedir, 'pat_03046_1482_Crise3_mHaT2');
% config{30}.prefix              = 'pat_03046_1482_Crise3_mHaT2-';                                                        %patient name. Must end by "-". namepatient-
% config{30}.rawdir              = fullfile(rootpath_data,'pat_03046_1482','eeg');                       %path to patient data
% config{30}.directorylist{1}    = {'03046_2021-07-15_12-23','03046_2021-07-15_14-23'};                                               %list of folders to analyse
% config{30}.circus.channel      = {'mHaT2_4','mHaT2_5'};       %name of the first electrode
% config{30}.circus.reref        = 'no';
% config{30}.circus.refchan      = '';
% config{30}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{30}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{30}.circus.hpfreq       = 0; % even when not using
% config{30}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{30}.circus.params.detection.spike_thresh  = '7';
% config{30}.circus.params.clustering.nb_repeats   = '10';
% config{30}.circus.params.clustering.max_elts     = '20000';
% 
% config{30}.LFP.channel         = {'_HaT2_'};       %name the macro contact in the SOZ
% 
% config{30}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{30}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{30}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{30}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{30}.bad.sample_list     = 1; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{30}.bad.time_from_begin = 1800; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)

%% patient 31
config{31}                     = configcommon;
config{31}.group               = 'simple';
config{31}.triallist            = 1;

config{31}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{31}.imagesavedir        = fullfile(imagesavedir, 'pat_02161_0599_Crise4_mHa1d');
config{31}.prefix              = 'pat_02161_0599_Crise4_mHa1d-';                                                        %patient name. Must end by "-". namepatient-
config{31}.rawdir              = fullfile(rootpath_data,'pat_02161_0599','eeg');                       %path to patient data
config{31}.directorylist{1}    = {'02161_2014-06-05_02-01','02161_2014-06-05_04-01'};                                               %list of folders to analyse
config{31}.circus.channel      = {'mHa1d_7'};       %name of the first electrode
config{31}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');


config{31}.circus.params.detection.spike_thresh  = '7';
config{31}.circus.params.clustering.nb_repeats   = '10';
config{31}.circus.params.clustering.max_elts     = '20000';

config{31}.LFP.channel         = {'_Ha1d_1'};%,'_Ha1d_2','_Hm1d_1','_Hm1d_2','_Ha1g_1','_Ha1g_2','_Hm2g_1','_Hm2g_2'};       %name the macro contact in the SOZ

%config{31}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{31}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{31}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{31}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{31}.bad.sample_list     = 1; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{31}.bad.time_from_begin = 400; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)

%% patient 32
config{32}                     = configcommon;
config{32}.group               = 'simple';
config{32}.triallist           = 2;

config{32}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{32}.imagesavedir        = fullfile(imagesavedir, 'pat_02161_0599_Crise5_mHa1d');
config{32}.prefix              = 'pat_02161_0599_Crise5_mHa1d-';                                                        %patient name. Must end by "-". namepatient-
config{32}.rawdir              = fullfile(rootpath_data,'pat_02161_0599','eeg');                       %path to patient data
config{32}.directorylist{1}    = {'02161_2014-06-05_02-01','02161_2014-06-05_04-01'};                                               %list of folders to analyse
config{32}.circus.channel      = {'mHa1d_7'};       %name of the first electrode
config{32}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');


config{32}.circus.params.detection.spike_thresh  = '7';
config{32}.circus.params.clustering.nb_repeats   = '10';
config{32}.circus.params.clustering.max_elts     = '20000';

config{32}.LFP.channel         = {'_Ha1d_1'};       %name the macro contact in the SOZ

%config{32}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{32}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{32}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{32}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{32}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{32}.bad.time_from_begin = 1400; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)

%% patient 33
% config{33}                     = configcommon;
% config{33}.group               = 'simple';
% config{33}.datasavedir         = datasavedir;       %path where to save MuseStruct data
% config{33}.imagesavedir        = fullfile(imagesavedir, 'pat_02161_0599_CriseSupp1_mHa1d');
% config{33}.prefix              = 'pat_02161_0599_CriseSupp1_mHa1d-';                                                        %patient name. Must end by "-". namepatient-
% config{33}.rawdir              = fullfile(rootpath_data,'pat_02161_0599','eeg');                       %path to patient data
% config{33}.directorylist{1}    = {'02161_2014-06-04_13-47','02161_2014-06-04_14-01'};                                               %list of folders to analyse
% config{33}.circus.channel      = {'mHa1d_2'};       %name of the first electrode
% config{33}.circus.reref        = 'no';
% config{33}.circus.refchan      = '';
% config{33}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');
% config{33}.circus.hpfilter     = 'no'; % hp before writing data for SC, does not change the hp of SC
% config{33}.circus.hpfreq       = 0; % even when not using
% config{33}.circus.postfix      = []; % after using circus-gui-matlab's SAVE number
% 
% config{33}.circus.params.detection.spike_thresh  = '7';
% config{33}.circus.params.clustering.nb_repeats   = '10';
% config{33}.circus.params.clustering.max_elts     = '20000';
% 
% config{33}.LFP.channel         = {'_Ha1d_1','_Ha1d_2'};       %name the macro contact in the SOZ
% 
% %config{33}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
% config{33}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
% config{33}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
% config{33}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
% config{33}.bad.sample_list     = 2; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
% config{33}.bad.time_from_begin = 0; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)

%% patient 34
config{34}                     = configcommon;
config{34}.group               = 'simple';
config{34}.triallist           = 3;

config{34}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{34}.imagesavedir        = fullfile(imagesavedir, 'pat_02161_0599_CriseSupp2_mHa1d');
config{34}.prefix              = 'pat_02161_0599_CriseSupp2_mHa1d-';                                                        %patient name. Must end by "-". namepatient-
config{34}.rawdir              = fullfile(rootpath_data,'pat_02161_0599','eeg');                       %path to patient data
config{34}.directorylist{1}    = {'02161_2014-06-05_04-01','02161_2014-06-05_06-01'};                                               %list of folders to analyse
config{34}.circus.channel      = {'mHa1d_7'};       %name of the first electrode
config{34}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');

config{34}.circus.params.detection.spike_thresh  = '7';
config{34}.circus.params.clustering.nb_repeats   = '10';
config{34}.circus.params.clustering.max_elts     = '20000';

config{34}.LFP.channel         = {'_Ha1d_1'};       %name the macro contact in the SOZ

%config{34}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{34}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{34}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{34}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{34}.bad.sample_list     = 2; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{34}.bad.time_from_begin = 60; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)

%% patient 35
config{35}                     = configcommon;
config{35}.group               = 'simple';
config{35}.triallist           = 4;

config{35}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{35}.imagesavedir        = fullfile(imagesavedir, 'pat_02161_0599_CriseSupp3_mHa1d');
config{35}.prefix              = 'pat_02161_0599_CriseSupp3_mHa1d-';                                                        %patient name. Must end by "-". namepatient-
config{35}.rawdir              = fullfile(rootpath_data,'pat_02161_0599','eeg');                       %path to patient data
config{35}.directorylist{1}    = {'02161_2014-06-05_04-01','02161_2014-06-05_06-01'};                                               %list of folders to analyse
config{35}.circus.channel      = {'mHa1d_7'};       %name of the first electrode
config{35}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');


config{35}.circus.params.detection.spike_thresh  = '7.5';
config{35}.circus.params.clustering.nb_repeats   = '10';
config{35}.circus.params.clustering.max_elts     = '20000';

config{35}.LFP.channel         = {'_Ha1d_1'};       %name the macro contact in the SOZ

%config{35}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{35}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{35}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{35}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{35}.bad.sample_list     = 3; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{35}.bad.time_from_begin = 60; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)

%% patient 36
config{36}                     = configcommon;
config{36}.group               = 'simple';
config{36}.triallist           = 5;

config{36}.datasavedir         = datasavedir;       %path where to save MuseStruct data
config{36}.imagesavedir        = fullfile(imagesavedir, 'pat_02161_0599_CriseSupp4_mHa1d');
config{36}.prefix              = 'pat_02161_0599_CriseSupp4_mHa1d-';                                                        %patient name. Must end by "-". namepatient-
config{36}.rawdir              = fullfile(rootpath_data,'pat_02161_0599','eeg');                       %path to patient data
config{36}.directorylist{1}    = {'02161_2014-06-05_04-01','02161_2014-06-05_06-01'};                                               %list of folders to analyse
config{36}.circus.channel      = {'mHa1d_7'};       %name of the first electrode
config{36}.circus.outputdir    = fullfile(rootpath_analysis, 'data', 'SpykingCircus');


config{36}.circus.params.detection.spike_thresh  = '8';
config{36}.circus.params.clustering.nb_repeats   = '10';
config{36}.circus.params.clustering.max_elts     = '20000';

config{36}.LFP.channel         = {'_Ha1d_1'};       %name the macro contact in the SOZ

%config{36}.seizure_index       = 'last'; %Optional. index of the seizure to analyze, on the LAST dir. can be 'last' (default)
config{36}.bad.markerStart     = 'CriseEnd'; %BAD à partir crise end
config{36}.bad.markerEnd       = 'end'; % BAD jusque fin du fichier
config{36}.bad.dir_list        = 'last'; %nouveau marqueur BAD sur dernier des 2 fichiers 
config{36}.bad.sample_list     = 'last'; %dernier marqueur crise END pris en compte (en cas de multiple crise sur un même fichier)
config{36}.bad.time_from_begin = 60; %début à +60s de crise END (pour rfaire spike sorting sur crise et post critique immédiat)

% config{10}                    = config{9};
% config{10}.imagesavedir       = fullfile(imagesavedir, 'pat_02599_1057_Crise3_mHaT2');
% config{10}.prefix             = 'pat_02599_1057_Crise3_mHaT2-';
% config{9}.circus.channel      = {'mHaT2_6'}; 
