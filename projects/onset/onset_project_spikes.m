function onset_project_spikes(ipatient)

%analyses individuelles

restoredefaultpath
if ispc
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\shared'))
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\external'))
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\templates'))
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\projects\onset'))
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\SPIKY'))
    addpath \\l2export\iss02.charpier\analyses\vn_onset\fieldtrip
    
elseif isunix
    addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/shared'))
    addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/external'))
    addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/templates'))
    addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/projects/onset'))
    addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/SPIKY'))
    addpath /network/lustre/iss02/charpier/analyses/vn_onset/fieldtrip
end
ft_defaults

config = onset_setparams;
ipart = 1;

if isempty(config{ipatient})
    return
end

MuseStruct = readMuseMarkers(config{ipatient}, true);

%read LFP
LFP = readLFP(config{ipatient}, MuseStruct, true);

%comput FFT
FFTtrials(config{ipatient}, true, LFP);

%read spike data
SpikeRaw = readSpikeRaw_Phy(config{ipatient}, true);

% add (sliding) timewindow
[config{ipatient}, MuseStruct] = addSlidingWindows(config{ipatient}, MuseStruct);
% epoch data into trials
SpikeTrials = readSpikeTrials(config{ipatient}, MuseStruct, SpikeRaw, true);

% calculate statistics per window
spikeTrialStats(config{ipatient}, SpikeTrials, true);

%read spike waveforms
SpikeWaveforms = readSpikeWaveforms(config{ipatient}, SpikeRaw, true);

spikeWaveformStats(config{ipatient}, SpikeWaveforms, true);
clear SpikeWaveforms
