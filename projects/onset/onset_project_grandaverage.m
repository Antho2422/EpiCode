function onset_project_grandaverage

restoredefaultpath
if ispc
    addpath (genpath('\\lexport\iss01.charpier\analyses\vn_onset\EpiCode\shared'))
    addpath (genpath('\\lexport\iss01.charpier\analyses\vn_onset\EpiCode\external'))
    addpath (genpath('\\lexport\iss01.charpier\analyses\vn_onset\EpiCode\templates'))
    addpath (genpath('\\lexport\iss01.charpier\analyses\vn_onset\EpiCode\projects\onset'))
    addpath (genpath('\\lexport\iss01.charpier\analyses\vn_onset\SPIKY_mar_2022'))
    addpath (genpath('\\lexport\iss01.charpier\analyses\vn_onset\SPIKY'))
    
    addpath \\lexport\iss01.charpier\analyses\vn_onset\fieldtrip
    
elseif isunix
    addpath (genpath('/network/lustre/iss01/charpier/analyses/vn_onset/EpiCode/shared'))
    addpath (genpath('/network/lustre/iss01/charpier/analyses/vn_onset/EpiCode/external'))
    addpath (genpath('/network/lustre/iss01/charpier/analyses/vn_onset/EpiCode/templates'))
    addpath (genpath('/network/lustre/iss01/charpier/analyses/vn_onset/EpiCode/projects/onset'))
    addpath (genpath('/network/lustre/iss01/charpier/analyses/vn_onset/SPIKY_apr_2021'))
    addpath /network/lustre/iss01/charpier/analyses/vn_onset/fieldtrip
    addpath (genpath('/network/lustre/iss01/charpier\analyses/vn_onset/SPIKY'))
end
ft_defaults

config = onset_setparams;


%% load precomputed data

for ipatient = 1

    % read muse markers
    MuseStruct = readMuseMarkers(config{ipatient}, false);
    
    % add (sliding) timewindow
    [config{ipatient}, MuseStruct] = addSlidingWindows(config{ipatient}, MuseStruct);
  
    % LFP
    LFP{ipatient}        = readLFP(config{ipatient}, MuseStruct, false);
%     figure;
%     cfgtemp          = [];
%     cfgtemp.hpfilter = 'yes';
%     cfgtemp.hpfreq   = 1;
%     data_filt        = ft_preprocessing(cfgtemp, LFP{ipatient}{1}.CriseStart);
%     plot(data_filt.time{1}, data_filt.trial{1}(1,:));
%     plot(LFP{ipatient}{1}.CriseStart.time{1}, LFP{ipatient}{1}.CriseStart.trial{1}(1,:));
    
    %read spike data
    SpikeRaw = readSpikeRaw_Phy(config{ipatient}, false);
    
    % epoch spike data into windows
    SpikeTrials{ipatient}  = readSpikeTrials(config{ipatient}, MuseStruct, SpikeRaw, false);
    
    % calculate statistics per window
    SpikeStats{ipatient}  = spikeTrialStats(config{ipatient}, SpikeTrials, false); 

end 

% Boucle qui ignore les patients commentés
% for ipatient = 1:size(config, 2)
%     if isempty(config{ipatient})
%         continue
%     end
%     disp(ipatient)
% end

%% rasterplot timelock sur le debut de la crise 


%% exemple de LFP + TFR


%% PSTH de tous les neurones par groupe simple/+


%% Classification PN/IN 


