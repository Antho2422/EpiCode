function onset_project_spikes

%analyses individuelles

restoredefaultpath
if ispc
    addpath (genpath('\\lexport\iss01.charpier\analyses\vn_onset\EpiCode\shared'))
    addpath (genpath('\\lexport\iss01.charpier\analyses\vn_onset\EpiCode\external'))
    addpath (genpath('\\lexport\iss01.charpier\analyses\vn_onset\EpiCode\templates'))
    addpath (genpath('\\lexport\iss01.charpier\analyses\vn_onset\EpiCode\projects\onset'))
    addpath (genpath('\\lexport\iss01.charpier\analyses\vn_onset\SPIKY_mar_2022'))
    
    
    addpath \\lexport\iss01.charpier\analyses\vn_onset\fieldtrip
    
elseif isunix
    addpath (genpath('/network/lustre/iss01/charpier/analyses/vn_onset/EpiCode/shared'))
    addpath (genpath('/network/lustre/iss01/charpier/analyses/vn_onset/EpiCode/external'))
    addpath (genpath('/network/lustre/iss01/charpier/analyses/vn_onset/EpiCode/templates'))
    addpath (genpath('/network/lustre/iss01/charpier/analyses/vn_onset/EpiCode/projects/onset'))
    addpath (genpath('/network/lustre/iss01/charpier/analyses/vn_onset/SPIKY_apr_2021'))
    addpath /network/lustre/iss01/charpier/analyses/vn_onset/fieldtrip
end
ft_defaults

config = onset_setparams;

%% prepare data for Spyking Circus
% write a new joblist for the cluster
%onset_spikes_slurm_joblist

for ipatient = 1:5  % à définir (1 : n si plusieurs patients)
    ipart = 1;

    % read muse markers
    MuseStruct = readMuseMarkers(config{ipatient}, true);

    % remove post ictal from the whole analysis,
    % according to config (some 'patients' will have
    % shorter postictal kept because of noise, see setparams)
    MuseStruct = addMuseBAD(config{ipatient}, MuseStruct);

    % write artefacts to file
    writeSpykingCircusDeadfiles(config{ipatient}, MuseStruct, true, '_SeizuresNotRemoved');

    %%
    % NOW RENAME SpykingCircus_artefacts_sample -> SpykingCircus_artefacts_samples_SeizuresNotRemoved
    %%


    % add artefact marker from seizure start to seizure end
    cfgtemp                       = [];
    cfgtemp.bad.markerStart       = 'CriseStart';
    cfgtemp.bad.markerEnd         = 'CriseEnd';
    MuseStruct                    = addMuseBAD(cfgtemp,MuseStruct);

    writeSpykingCircusDeadfiles(config{ipatient}, MuseStruct, true, '_SeizuresRemoved');

    %%
    % NOW RENAME SpykingCircus_artefacts_sample -> SpykingCircus_artefacts_samples_SeizuresRemoved
    %%
    % write parameters file for spyking circus
    writeSpykingCircusParameters(config{ipatient});

    % write file list for spyking circus ---> LINUX
    writeSpykingCircusFileList(config{ipatient}, true);
    %
    %     %%
    %     % Now do your spike sorting
    %     %%
end 

%% perform the analysis after spike sorting
for ipatient = 1:size(config, 2)

    if isempty(config{ipatient})
        continue
    end
   
    %read config
    config = onset_setparams;

    %read LFP
    readLFP(config{ipatient}, MuseStruct, true);

    %read spike data
    SpikeRaw = readSpikeRaw_Phy(config{ipatient}, true);

    %read spike waveforms
    SpikeWaveforms = readSpikeWaveforms(config{ipatient}, SpikeRaw, true);

    spikeWaveformStats(config{ipatient}, SpikeWaveforms, true);
    clear SpikeWaveforms

    % add (sliding) timewindow
    [config{ipatient}, MuseStruct] = addSlidingWindows(config{ipatient}, MuseStruct);

    % epoch data into trials
    SpikeTrials                = readSpikeTrials(config{ipatient}, MuseStruct, SpikeRaw, true);

    % calculate statistics per window
    spikeTrialStats(config{ipatient}, SpikeTrials, true);
end

