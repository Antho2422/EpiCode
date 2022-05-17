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
config = config(1:2); %temporaire juste pour faire le script avec quelques patients
ipart = 1;

%% load precomputed data

for ipatient = 1:size(config, 2)
    
    if isempty(config{ipatient})
        continue
    end

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

    WaveformStats{ipatient} = spikeWaveformStats(config{ipatient}, [], false);
    
end 


%% rasterplot : 1 par patient
toi = [-20 20];
bar_size = 0.5;

for ipatient = 1:size(config, 2)
    
    fig = figure; hold on;
    n_units = size(SpikeTrials{ipatient}{ipart}.CriseStart.label, 2);
    
    for i_unit = 1:n_units
        for i_time = SpikeTrials{ipatient}{ipart}.CriseStart.time{i_unit}
            if i_time < toi(1) || i_time > toi(2)
                continue
            end
            plot([i_time, i_time], [i_unit i_unit+bar_size], 'color', 'k');
        end
    end
    
    y = ylim;
    ylim([y(1) - (1-bar_size), y(2) + (1-bar_size)]);
    y = ylim;
    plot([0 0], y, '--r', 'linewidth', 2);
    xlabel('Time (s)');
    yticks(1+bar_size/2 : n_units+0.5);
    yticklabels(strrep(string(SpikeTrials{ipatient}{ipart}.CriseStart.label), '_', ' '));
    set(gca, 'tickdir', 'out', 'fontsize', 15);
    title(config{ipatient}.prefix(1:end-1), 'interpreter', 'none', 'fontsize', 18);
    xlim(toi);
    
    fname = fullfile(config{ipatient}.imagesavedir, '..', 'rasterplot_each_patient', sprintf('%srasterplot', config{ipatient}.prefix));
    savefigure_own(fig, fname, 'png', 'pdf', 'close');
end

% 'color': 'k', 'r', 'g', 'y', 'b'
% 'color': [0 0 0] noir, [1 1 1] [1 0 0] [0 1 0] [0.2 0.6 0.5]

%% rasterplot de toutes les units de chaque groupe

%% PSTH de tous les neurones par groupe simple/+

%% exemple de LFP + TFR

%% Classification PN/IN 


