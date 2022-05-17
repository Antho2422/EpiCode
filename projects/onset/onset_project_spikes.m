function onset_project_spikes(ipatient)

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
    addpath (genpath('/network/lustre/iss01/charpier/analyses/vn_onset/SPIKY_mar_2022'))
    addpath /network/lustre/iss01/charpier/analyses/vn_onset/fieldtrip
end
ft_defaults

config = onset_setparams;
ipart = 1;

if isempty(config{ipatient})
    return
end

MuseStruct = readMuseMarkers(config{ipatient}, false);

%read LFP
readLFP(config{ipatient}, MuseStruct, true);

%read spike data
SpikeRaw = readSpikeRaw_Phy(config{ipatient}, false);

%read spike waveforms
SpikeWaveforms = readSpikeWaveforms(config{ipatient}, SpikeRaw, false);

spikeWaveformStats(config{ipatient}, SpikeWaveforms, true);
clear SpikeWaveforms

% add (sliding) timewindow
[config{ipatient}, MuseStruct] = addSlidingWindows(config{ipatient}, MuseStruct);

% epoch data into trials
SpikeTrials = readSpikeTrials(config{ipatient}, MuseStruct, SpikeRaw, true);

% calculate statistics per window
spikeTrialStats(config{ipatient}, SpikeTrials, true);
