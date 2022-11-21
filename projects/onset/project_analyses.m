function project_analyses

restoredefaultpath
if ispc
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\shared'))
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\external'))
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\templates'))
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\development'))
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\projects\onset'))
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\SPIKY'))
    addpath '\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\development'
    addpath \\l2export\iss02.charpier\analyses\vn_onset\fieldtrip
    
elseif isunix
    addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/shared'))
    addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/external'))
    addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/templates'))
    addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/development'))
    addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/projects/onset'))
    addpath /network/lustre/iss02/charpier/analyses/vn_onset/fieldtrip
    addpath /network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/development
    addpath (genpath('/network/lustre/iss02/charpier\analyses/vn_onset/SPIKY'))
end
ft_defaults

% à modif avec la nouvelle orga de Brieg

config = onset_setparams;

%% load precomputed data

for ipatient = 1:size(config, 2)
    if isempty(config{ipatient})
        continue
    end

    % read muse markers
    MuseStruct{ipatient} = readMuseMarkers(config{ipatient}, false);
  
    % LFP
    LFP{ipatient}        = readLFP(config{ipatient}, MuseStruct{ipatient}, false);

    %read spike data
    SpikeRaw = readSpikeRaw_Phy(config{ipatient}, false);
    
    % add (sliding) timewindow
    [config{ipatient}, MuseStruct{ipatient}] = addSlidingWindows(config{ipatient}, MuseStruct{ipatient});    
    
    % epoch spike data into windows
    SpikeTrials{ipatient}  = readSpikeTrials(config{ipatient}, MuseStruct{ipatient}, SpikeRaw, false);
    
    % calculate statistics per window
    SpikeStats{ipatient}  = spikeTrialStats(config{ipatient}, SpikeTrials{ipatient}, false); 

    SpikeWaveforms{ipatient} = readSpikeWaveforms(config{ipatient}, [], false);
    
    %statistics on the spike waveforms
    WaveformStats{ipatient} = spikeWaveformStats(config{ipatient}, [], false);
    
end 


%% rasterplot : 1 par patient
toi = [-20 20];
bar_size = 0.5;

for ipatient = 1:size(config, 2)
    
    if isempty(config{ipatient})
        continue
    end
    
    fig = figure; hold on;
    n_units = size(SpikeTrials{ipatient}{ipart}.CriseStart.label, 2);
    
    iplot = 0;
    for itrial = config{ipatient}.triallist% 1:size(SpikeTrials{ipatient}{ipart}.CriseStart.trialtime, 1) 
        for i_unit = 1:n_units
            
            %color differently mua and sua
            if contains(SpikeTrials{ipatient}{ipart}.CriseStart.cluster_group{i_unit}, 'good')
                color = 'k';
            elseif contains(SpikeTrials{ipatient}{ipart}.CriseStart.cluster_group{i_unit}, 'mua')
                color = 'r';
            else
                error('no group attributed to %s', SpikeTrials{ipatient}{ipart}.CriseStart.label{i_unit})
            end
            
            iplot = iplot+1; %to plot in a different raw
            %select timings corresponding to the trial
            sel   = SpikeTrials{ipatient}{ipart}.CriseStart.trial{i_unit} == itrial;
            %save the name to print on the figure
            plot_name{iplot} = sprintf('%s_trial_%d', SpikeTrials{ipatient}{ipart}.CriseStart.label{i_unit}, itrial);
            
            %patch the LVFA duration
            t_lvfa = find_muse_marker_in_trial(SpikeTrials{ipatient}{ipart}.CriseStart, MuseStruct{ipatient}, itrial, 'LVFA_End');
            if isempty(t_lvfa)
                error('No timing found for the LVFA marker in trial %d', itrial);
            end
            x = [0 t_lvfa];
            y = [iplot-(1-bar_size)/2, iplot+bar_size+(1-bar_size)/2];
            patch('XData', [x(1) x(2) x(2) x(1)], 'YData', [y(1) y(1) y(2) y(2)], 'edgecolor', 'none', 'facecolor', 'r', 'facealpha', 0.5);
            
            %patch the seizure duration
            t_crise_end = find_muse_marker_in_trial(SpikeTrials{ipatient}{ipart}.CriseStart, MuseStruct{ipatient}, itrial, 'CriseEnd', 0, 180);
            if isempty(t_crise_end)
                error('No timing found for the CriseEnd marker in trial %d', itrial);
            end
            x = [t_lvfa t_crise_end];
            y = [iplot-(1-bar_size)/2, iplot+bar_size+(1-bar_size)/2];
            patch('XData', [x(1) x(2) x(2) x(1)], 'YData', [y(1) y(1) y(2) y(2)], 'edgecolor', 'none', 'facecolor', 'y', 'facealpha', 0.5);
            
            %mark the baseline duration
                    t_baseline = [-10 -5];
                    x = t_baseline;
                    y = [iplot-(1-bar_size)/2, iplot+bar_size+(1-bar_size)/2];
                    patch('XData', [x(1) x(2) x(2) x(1)], 'YData', [y(1) y(1) y(2) y(2)], 'edgecolor', 'none', 'facecolor', 'b', 'facealpha', 0.5);
           
            %or plot a vertical line
            
            %plot each spike time
            for i_time = SpikeTrials{ipatient}{ipart}.CriseStart.time{i_unit}(sel)
                if i_time < toi(1) || i_time > toi(2)
                    continue
                end
                plot([i_time, i_time], [iplot iplot+bar_size], 'color', color);
            end
            
        end
    end
    
    ylim([bar_size, iplot + 1]);
    y = ylim;
    plot([0 0], y, '--r', 'linewidth', 2);
    xlabel('Time (s)');
    yticks(1+bar_size/2 : iplot+0.5);
    yticklabels(strrep(string(plot_name), '_', ' '));
    set(gca, 'tickdir', 'out', 'fontsize', 15);
    title(config{ipatient}.prefix(1:end-1), 'interpreter', 'none', 'fontsize', 18);
    xlim(toi);
    
    fname = fullfile(config{ipatient}.imagesavedir, '..', 'rasterplot_each_patient', sprintf('%srasterplot', config{ipatient}.prefix));
    savefigure_own(fig, fname, 'png', 'pdf', 'close');
end

% 'color': 'k', 'r', 'g', 'y', 'b'
% 'color': [0 0 0] noir, [1 1 1] [1 0 0] [0 1 0] [0.2 0.6 0.5]

%% rasterplot de toutes les units de chaque groupe
toilist = [-20, 20; -5, 5; config{1}.spike.toi.CriseStart]';
bar_size = 0.8;

for toi = toilist
    for igroup = ["simple", "slowwave"]
        
        fig = figure; hold on;
        iplot = 0;
        
        for ipatient = 1:size(config, 2)
            
            if isempty(config{ipatient})
                continue
            end
            
            if ~strcmp(config{ipatient}.group, igroup)
                continue
            end
            
            n_units = size(SpikeTrials{ipatient}{ipart}.CriseStart.label, 2);
            for itrial = config{ipatient}.triallist%1:size(SpikeTrials{ipatient}{ipart}.CriseStart.trialtime, 1)
                for i_unit = 1:n_units
                    
                    if contains(SpikeTrials{ipatient}{ipart}.CriseStart.cluster_group{i_unit}, 'good')
                        color = 'k';
                    elseif contains(SpikeTrials{ipatient}{ipart}.CriseStart.cluster_group{i_unit}, 'mua')
                        color = 'r';
                    else
                        error('no group attributed to %s', SpikeTrials{ipatient}{ipart}.CriseStart.label{i_unit})
                    end
                    
                    iplot = iplot+1;
                    sel = SpikeTrials{ipatient}{ipart}.CriseStart.trial{i_unit} == itrial;
                    plot_name{iplot} = sprintf('pat_%d_%s_trial_%d', ipatient, SpikeTrials{ipatient}{ipart}.CriseStart.label{i_unit}, itrial);
                    
                    %patch the LVFA duration
                    t_lvfa = find_muse_marker_in_trial(SpikeTrials{ipatient}{ipart}.CriseStart, MuseStruct{ipatient}, itrial, 'LVFA_End');
                    x = [0 t_lvfa];
                    y = [iplot-(1-bar_size)/2, iplot+bar_size+(1-bar_size)/2];
                    patch('XData', [x(1) x(2) x(2) x(1)], 'YData', [y(1) y(1) y(2) y(2)], 'edgecolor', 'none', 'facecolor', 'r', 'facealpha', 0.5);

                    %mark the seizure duration
                    t_crise_end = find_muse_marker_in_trial(SpikeTrials{ipatient}{ipart}.CriseStart, MuseStruct{ipatient}, itrial, 'CriseEnd', 0, 180);
                    if isempty(t_crise_end)
                        error('No timing found for the CriseEnd marker in trial %d', itrial);
                    end
                    x = [t_lvfa t_crise_end];
                    y = [iplot-(1-bar_size)/2, iplot+bar_size+(1-bar_size)/2];
                    patch('XData', [x(1) x(2) x(2) x(1)], 'YData', [y(1) y(1) y(2) y(2)], 'edgecolor', 'none', 'facecolor', 'y', 'facealpha', 0.5);

                    %mark the baseline duration
                    t_baseline = [-10 -5];
                    x = t_baseline;
                    y = [iplot-(1-bar_size)/2, iplot+bar_size+(1-bar_size)/2];
                    patch('XData', [x(1) x(2) x(2) x(1)], 'YData', [y(1) y(1) y(2) y(2)], 'edgecolor', 'none', 'facecolor', 'b', 'facealpha', 0.5);
                   
                   %plot each spike timing
                    for i_time = SpikeTrials{ipatient}{ipart}.CriseStart.time{i_unit}(sel)
                        if i_time < toi(1) || i_time > toi(2)
                            continue
                        end
                        plot([i_time, i_time], [iplot iplot+bar_size], 'color', color);
                    end
                end
            end
        end
        
        ylim([bar_size, iplot + 1]);
        y = ylim;
        plot([0 0], y, '--r', 'linewidth', 2);
        xlabel('Time (s)');
        yticks(1+bar_size/2 : iplot+0.5);
        yticklabels(strrep(string(plot_name), '_', ' '));
        set(gca, 'tickdir', 'out', 'fontsize', 5);
        title(igroup, 'interpreter', 'none', 'fontsize', 18);
        xlim(toi');
        
        fname = fullfile(config{1}.imagesavedir, '..', 'rasterplot_per_group', sprintf('rasterplot_%s_t_%g_%g', igroup, toi(1), toi(2)));
        savefigure_own(fig, fname, 'png', 'pdf', 'close');
    end
end

%% raster plot: classer units par frequence pendant la lvfa, et pendant la baseline
clear freq_baseline freq_lvfa pat_nr unit_nr trial_nr idx
for igroup = ["simple", "slowwave"]
    i = 0;
    for ipatient = 1:size(config, 2)
        
        if isempty(config{ipatient})
            continue
        end
        
        if ~strcmp(config{ipatient}.group, igroup)
            continue
        end
        
        n_units = size(SpikeTrials{ipatient}{ipart}.CriseStart.label, 2);
        for itrial = config{ipatient}.triallist
            for i_unit = 1:n_units
                crisestart                = SpikeTrials{ipatient}{1}.PreCrise_5s.trialinfo.endtime(itrial);
                lvfa_trial                = nearest(seconds(SpikeTrials{ipatient}{1}.LVFA.trialinfo.starttime-crisestart), 0);
                i                         = i+1;
                freq_baseline.(igroup)(i) = SpikeStats{ipatient}{ipart}.PreCrise_5s{i_unit}.trialfreq(itrial);
                freq_lvfa.(igroup)(i)     = SpikeStats{ipatient}{ipart}.LVFA{i_unit}.trialfreq(lvfa_trial);
                pat_nr.(igroup)(i)        = ipatient;
                unit_nr.(igroup)(i)       = i_unit;
                trial_nr.(igroup)(i)      = itrial;
            end
        end
    end
    freq_baseline.(igroup)(isnan(freq_baseline.(igroup))) = 0;
    freq_lvfa.(igroup)(isnan(freq_lvfa.(igroup))) = 0;
    
    [~, idx.baseline.(igroup)] = sort(freq_baseline.(igroup), 2, 'ascend');
    [~, idx.lvfa.(igroup)] = sort(freq_lvfa.(igroup), 2, 'ascend');
end


toilist = [-20, 20; -5, 5; config{1}.spike.toi.CriseStart]';
bar_size = 0.8;

for i_period = ["baseline", "lvfa"]
    for toi = toilist
        for igroup = ["simple", "slowwave"]
            
            fig = figure; hold on;
            iplot = 0;
            
            for idata = idx.(i_period).(igroup)
                
                ipatient = pat_nr.(igroup)(idata);
                itrial = trial_nr.(igroup)(idata);
                i_unit = unit_nr.(igroup)(idata);
                
                if contains(SpikeTrials{ipatient}{ipart}.CriseStart.cluster_group{i_unit}, 'good')
                    color = 'k';
                elseif contains(SpikeTrials{ipatient}{ipart}.CriseStart.cluster_group{i_unit}, 'mua')
                    color = 'r';
                else
                    error('no group attributed to %s', SpikeTrials{ipatient}{ipart}.CriseStart.label{i_unit})
                end
                
                iplot = iplot+1;
                sel = SpikeTrials{ipatient}{ipart}.CriseStart.trial{i_unit} == itrial;
                plot_name{iplot} = sprintf('pat_%d_%s_trial_%d', ipatient, SpikeTrials{ipatient}{ipart}.CriseStart.label{i_unit}, itrial);
                
                %patch the LVFA duration
                t_lvfa = find_muse_marker_in_trial(SpikeTrials{ipatient}{ipart}.CriseStart, MuseStruct{ipatient}, itrial, 'LVFA_End');
                x = [0 t_lvfa];
                y = [iplot-(1-bar_size)/2, iplot+bar_size+(1-bar_size)/2];
                patch('XData', [x(1) x(2) x(2) x(1)], 'YData', [y(1) y(1) y(2) y(2)], 'edgecolor', 'none', 'facecolor', 'r', 'facealpha', 0.5);
                
                %patch the seizure duration
                t_crise_end = find_muse_marker_in_trial(SpikeTrials{ipatient}{ipart}.CriseStart, MuseStruct{ipatient}, itrial, 'CriseEnd', 0, 180);
                if isempty(t_crise_end)
                    error('No timing found for the CriseEnd marker in trial %d', itrial);
                end
                x = [t_lvfa t_crise_end];
                y = [iplot-(1-bar_size)/2, iplot+bar_size+(1-bar_size)/2];
                patch('XData', [x(1) x(2) x(2) x(1)], 'YData', [y(1) y(1) y(2) y(2)], 'edgecolor', 'none', 'facecolor', 'y', 'facealpha', 0.5);

                %mark the baseline duration
                    t_baseline = [-10 -5];
                    x = t_baseline;
                    y = [iplot-(1-bar_size)/2, iplot+bar_size+(1-bar_size)/2];
                    patch('XData', [x(1) x(2) x(2) x(1)], 'YData', [y(1) y(1) y(2) y(2)], 'edgecolor', 'none', 'facecolor', 'b', 'facealpha', 0.5);
                
                %or plot a vertical line
                
                %plot each spike timing
                for i_time = SpikeTrials{ipatient}{ipart}.CriseStart.time{i_unit}(sel)
                    if i_time < toi(1) || i_time > toi(2)
                        continue
                    end
                    plot([i_time, i_time], [iplot iplot+bar_size], 'color', color);
                end
            end
            ylim([bar_size, iplot + 1]);
            y = ylim;
            plot([0 0], y, '--r', 'linewidth', 2);
            xlabel('Time (s)');
            yticks(1+bar_size/2 : iplot+0.5);
            yticklabels(strrep(string(plot_name), '_', ' '));
            set(gca, 'tickdir', 'out', 'fontsize', 5);
            title(sprintf('%s : ordre %s', igroup, i_period), 'interpreter', 'none', 'fontsize', 18);
            xlim(toi');
            
            fname = fullfile(config{1}.imagesavedir, '..', 'rasterplot_par_group_par_frequence', sprintf('rasterplot_%s_t_%g_%g_freq_%s', igroup, toi(1), toi(2), i_period));
            savefigure_own(fig, fname, 'png', 'pdf', 'close');
            
        end
    end
end

%% compute psth : par groupe
psth = [];
binsize = 1; %s
toi = config{1}.spike.toi.CriseStart;
bins = toi(1) : binsize : toi(2);

for igroup = ["simple", "slowwave"]
    i_psth = 0;
    for ipatient = 1:size(config, 2)
        
        if isempty(config{ipatient})
            continue
        end
        
        if ~strcmp(config{ipatient}.group, igroup)
            continue
        end
        data = SpikeTrials{ipatient}{ipart}.CriseStart;
        n_units = size(data.label, 2);
        for i_unit = 1:n_units
            for itrial = config{ipatient}.triallist %1:size(data.trialtime, 1)
                i_psth = i_psth +1;
                t = data.time{i_unit};
                sel = data.trial{i_unit} == itrial & t >= toi(1) & t <= toi(2);
                psth.(igroup).trial(i_psth, :) = histcounts(t(sel), bins);
                psth.(igroup).label{i_psth, 1} = sprintf('pat_%d-%s_trial%d', ipatient, data.label{i_unit}, itrial);
            end
        end
    end
    psth.(igroup).avg       = mean(psth.(igroup).trial, 1);
    psth.(igroup).std       = std(psth.(igroup).trial, 0, 1); % since sumPsth.^2 ./ dof = dof .* (sumPsth/dof).^2
    psth.(igroup).fsample   = 1/(binsize);   % might be more compatible with feeding psth in other funcs
    psth.(igroup).time      = bins(1:end-1) + 0.5*binsize;
end
save(fullfile(config{1}.datasavedir, 'psth_per_group.mat'), 'psth');

%% plot psth 
load(fullfile(config{1}.datasavedir, 'psth_per_group.mat'), 'psth');
toilist = [-20, 20; -5, 5; config{1}.spike.toi.CriseStart]';

%plot all psth raw
for toi = toilist
    fig = figure;
    sgtitle('PSTH');
    iplot = 0;
    for igroup = ["simple", "slowwave"]
        iplot = iplot +1;
        subplot(1,2,iplot); hold on;
        plot(psth.(igroup).time, psth.(igroup).trial);
        
        y(iplot, :) = ylim;
        xlabel('Time (s)');
        set(gca, 'tickdir', 'out', 'fontsize', 15);
        title(igroup, 'interpreter', 'none', 'fontsize', 18);
        xlim(toi');
    end
    
    %apply the same scale on the 2 subplots:
    %superior limit
    ymax(1) = max(y(:,1));
    ymax(2) = max(y(:,2));
    for i = 1:iplot
        subplot(1,2,i);
        ylim(ymax);
        plot([0 0], ymax, '--r', 'linewidth', 2);
    end
    
    fname = fullfile(config{1}.imagesavedir, '..', 'rasterplot_per_group', sprintf('psth_raw_t_%g_%g', toi(1), toi(2)));
    savefigure_own(fig, fname, 'png', 'pdf', 'close');
end

%plot all psth mean +/- sd
for toi = toilist
    fig = figure;
    sgtitle('PSTH')
    iplot = 0;
    for igroup = ["simple", "slowwave"]
        iplot = iplot +1;
        subplot(1,2,iplot); hold on;
%         patch_std(psth.(igroup).time, mean(psth.(igroup).trial, 1), std(psth.(igroup).trial, 0, 1), 'k');
%         plot(psth.(igroup).time, mean(psth.(igroup).trial, 1), 'k');
        bar(psth.(igroup).time, mean(psth.(igroup).trial, 1)+std(psth.(igroup).trial, 0, 1), 'edgecolor', [0.6 0.6 0.6], 'facecolor', [0.6 0.6 0.6]);
        bar(psth.(igroup).time, mean(psth.(igroup).trial, 1), 'k');
%         errorbar(psth.(igroup).time, mean(psth.(igroup).trial, 1), zeros(size(psth.(igroup).time)), std(psth.(igroup).trial, 0, 1), '.', 'color', 'k');
%         plot(psth.(igroup).time, mean(psth.(igroup).trial, 1)+std(psth.(igroup).trial, 0, 1), 'color', 'k');
        y = ylim;
        xlabel('Time (s)');
        set(gca, 'tickdir', 'out', 'fontsize', 15);
        title(igroup, 'interpreter', 'none', 'fontsize', 18);
        xlim(toi');
    end
    
    %apply the same scale on the 2 subplots:
    %superior limit
    ymax(1) = max(y(:,1));
    ymax(2) = max(y(:,2));
    for i = 1:iplot
        subplot(1,2,i);
        ylim(ymax);
        plot([0 0], ymax, '--r', 'linewidth', 2);
    end
    
    fname = fullfile(config{1}.imagesavedir, '..', 'rasterplot_per_group', sprintf('psth_mean_t_%g_%g', toi(1), toi(2)));
    savefigure_own(fig, fname, 'png', 'pdf', 'close');
end

%% psth en pourcentage de baseline
load(fullfile(config{1}.datasavedir, 'psth_per_group.mat'), 'psth');
t_baseline = [-10 -5];
toilist = [-20, 20; -5, 5; config{1}.spike.toi.CriseStart]';

%plot all psth raw
for toi = toilist
    fig = figure;
    sgtitle('PSTH');
    iplot = 0;
    for igroup = ["simple", "slowwave"]
        iplot = iplot +1;
        subplot(1,2,iplot); hold on;
        
        for i_unit = 1:size(psth.(igroup).trial, 1)
            baseline_idx = psth.(igroup).time >= t_baseline(1) & psth.(igroup).time <= t_baseline(2);
            baseline = mean(psth.(igroup).trial(i_unit, baseline_idx));
            plot(psth.(igroup).time, psth.(igroup).trial(i_unit,:)/baseline);
        end
        
        y(iplot, :) = ylim;
        xlabel('Time (s)');
        set(gca, 'tickdir', 'out', 'fontsize', 15);
        title(igroup, 'interpreter', 'none', 'fontsize', 18);
        xlim(toi');
    end
    
    %apply the same scale on the 2 subplots:
    %superior limit
    ymax(1) = max(y(:,1));
    ymax(2) = max(y(:,2));
    for i = 1:iplot
        subplot(1,2,i);
        ylim(ymax);
        plot([0 0], ymax, '--r', 'linewidth', 2);
    end
    
    fname = fullfile(config{1}.imagesavedir, '..', 'rasterplot_per_group', sprintf('psth_raw_blcorrected_t_%g_%g', toi(1), toi(2)));
    savefigure_own(fig, fname, 'png', 'pdf', 'close');
end

%plot all psth mean +/- sd
for toi = toilist
    fig = figure;
    sgtitle('PSTH')
    iplot = 0;
    for igroup = ["simple", "slowwave"]
        iplot = iplot +1;
        subplot(1,2,iplot); hold on;
        
        baseline_idx = psth.(igroup).time >= t_baseline(1) & psth.(igroup).time <= t_baseline(2);
        baseline = mean(mean(psth.(igroup).trial(:, baseline_idx)));
       
        bar(psth.(igroup).time, mean(psth.(igroup).trial/baseline, 1)+std(psth.(igroup).trial/baseline, 0, 1), 'edgecolor', [0.6 0.6 0.6], 'facecolor', [0.6 0.6 0.6]);
        bar(psth.(igroup).time, mean(psth.(igroup).trial/baseline, 1), 'k');
        y = ylim;
        xlabel('Time (s)');
        set(gca, 'tickdir', 'out', 'fontsize', 15);
        title(igroup, 'interpreter', 'none', 'fontsize', 18);
        xlim(toi');
    end
    
    %apply the same scale on the 2 subplots:
    %superior limit
    ymax(1) = max(y(:,1));
    ymax(2) = max(y(:,2));
    for i = 1:iplot
        subplot(1,2,i);
        ylim(ymax);
        plot([0 0], ymax, '--r', 'linewidth', 2);
    end
    
    fname = fullfile(config{1}.imagesavedir, '..', 'rasterplot_per_group', sprintf('psth_mean_blcorrected_t_%g_%g', toi(1), toi(2)));
    savefigure_own(fig, fname, 'png', 'pdf', 'close');
end

%% stats psth -5 et +5 s après CriseStart
load(fullfile(config{1}.datasavedir, 'psth_per_group.mat'), 'psth');
clear idx* p data*

tableout = table;
irow = 0;
% compute stats

for igroup = ["simple", "slowwave"]
    idx_ac(1) = find(psth.(igroup).time == 0.5); %centré sur 0.5 (entre 0 et 1)
    idx_ac(2) = find(psth.(igroup).time == 4.5); 
    idx_bl = find(psth.(igroup).time == -5.5); %5 secondes avant
    data_ac = psth.(igroup).trial(:,idx_ac(1):idx_ac(2));
    data_bl = psth.(igroup).trial(:,idx_bl);

    for i_time = 1:size(data_ac, 2)
        p.(igroup)(i_time) = signrank(data_bl, data_ac(:, i_time));
    end
    [h, crit_p, adj_ci_cvrg, p_corr.(igroup)] = fdr_bh(p.(igroup));
    
    %store baseline values
    irow = irow+2;
    tableout.group{irow}        = igroup;
    tableout.bin_time{irow}     = "baseline";
    tableout.mean_freq{irow}    = mean(data_bl, 1);
    tableout.std_freq{irow}     = std(data_bl,0, 1);
    tableout.p_value{irow}      = nan;
    tableout.p_value_corr{irow} = nan;
        
    %store active period values
    for i_time = 1:size(data_ac, 2)
        irow = irow+1;
        tableout.group{irow}        = igroup;
        tableout.bin_time{irow}     = sprintf('[%d %d]', i_time-1, i_time);
        tableout.mean_freq{irow}    = mean(data_ac(:,i_time), 1);
        tableout.std_freq{irow}     = std(data_ac(:,i_time),0, 1);
        tableout.p_value{irow}      = p.(igroup)(i_time);
        tableout.p_value_corr{irow} = p_corr.(igroup)(i_time);
    end
end

tablename = fullfile(config{1}.datasavedir, 'allpatients-psth_stats_-5_5.xlsx');
writetable(tableout, tablename);

%% Spike-distance of all binomes of unit
tabledata = table;
irow = 0;

for ipatient = 1:size(config, 2)
    
    if isempty(config{ipatient})
        continue
    end
    
    n_units = size(SpikeTrials{ipatient}{1}.PreCrise_10s.label, 2);
    for i_unit = 1 : n_units - 1 %-1 because for the last units all binomes are already used
        for itrial = config{ipatient}.triallist
            
            for i_dist = i_unit : n_units - 1
                
                %find lvfa marker number as there can be less lvfa markers than
                %crisestart marker
                crisestart = SpikeTrials{ipatient}{1}.PreCrise_5s.trialinfo.endtime(itrial);
                lvfa_trial = nearest(seconds(SpikeTrials{ipatient}{1}.LVFA.trialinfo.starttime-crisestart), 0);
                
                irow = irow + 1;
                tabledata.patient{irow}                 = config{ipatient}.prefix(1:end-1);
                tabledata.group{irow}                   = config{ipatient}.group;
                tabledata.unit_binome{irow}             = sprintf('%s and %s', SpikeTrials{ipatient}{1}.PreCrise_10s.label{i_unit}, SpikeTrials{ipatient}{1}.PreCrise_10s.label{i_dist+1});
                tabledata.quality{irow}                 = sprintf('%s and %s', SpikeTrials{ipatient}{1}.PreCrise_10s.cluster_group{i_unit}, SpikeTrials{ipatient}{1}.PreCrise_10s.cluster_group{i_dist+1});
                tabledata.dist_bl_10(irow)              = SpikeStats{ipatient}{ipart}.PreCrise_10s{i_unit}.dist(i_dist, itrial);
                tabledata.dist_bl_5(irow)               = SpikeStats{ipatient}{ipart}.PreCrise_5s{i_unit}.dist(i_dist, itrial);
                tabledata.dist_lvfa(irow)               = SpikeStats{ipatient}{ipart}.LVFA{i_unit}.dist(i_dist, lvfa_trial);
                
            end
            
        end
    end
end

writetable(tabledata, fullfile(config{1}.datasavedir, 'allpatients_spiky_all_binomes.xlsx'));

%plot all binomes par groupe
for igroup = ["simple", "slowwave"]
    
    sel = strcmp(tabledata.group, igroup);
    bl10 = tabledata.dist_bl_10(sel)';
    bl5 = tabledata.dist_bl_5(sel)';
    lvfa = tabledata.dist_lvfa(sel)';

    p1 = signrank(bl10, lvfa);
    p2 = signrank(bl5, lvfa);
    p3 = signrank(bl10, bl5);
   
    fig = figure;hold on;
    %plot bl 10
    bar(1, mean(bl10),'FaceColor','none','EdgeColor','k', 'LineWidth', 3);
    scatter(rand(size(bl10))*0.4+1-0.2, bl10, 200, 'o', 'filled', 'MarkerEdgeColor', [255 153 51]./255, 'MarkerFaceColor', [255 153 51]./255, 'LineWidth', 2);
    errorbar(1, mean(bl10),0, std(bl10),'k','CapSize',20, 'LineWidth', 3);

    %plot bl 5
    bar(2, mean(bl5),'FaceColor','none','EdgeColor','k', 'LineWidth', 3);
    scatter(rand(size(bl5))*0.4+2-0.2, bl5, 200, 'o', 'filled', 'MarkerEdgeColor', [255 153 51]./255, 'MarkerFaceColor', [255 153 51]./255, 'LineWidth', 2);
    errorbar(2, mean(bl5),0, std(bl5),'k','CapSize',20, 'LineWidth', 3);
    
    %plot lvfa
    bar(3, mean(lvfa),'FaceColor','none','EdgeColor','k', 'LineWidth', 3);
    scatter(rand(size(lvfa))*0.4+3-0.2, lvfa, 200, 'o', 'filled', 'MarkerEdgeColor', [255 153 51]./255, 'MarkerFaceColor', [255 153 51]./255, 'LineWidth', 2);
    errorbar(3, mean(lvfa),0, std(lvfa),'k','CapSize',20, 'LineWidth', 3);

    
    set(gca, 'LineWidth', 3);
    xlim([0 4]);
    xticks([1 2 3]);
    xticklabels({'BL10', 'BL5', 'LVFA'});
    set(gca,'TickDir','out','FontWeight','bold', 'FontSize', 15);
    ylabel('spike distance');
    title(sprintf('%s \np = %.4f, %.4f, %.4f', igroup, p1, p2, p3)); 
    
    fname = fullfile(config{1}.imagesavedir,'..', 'spiky_binomes',sprintf('%s_spiky_binomes', igroup));
    savefigure_own(fig,fname,'pdf','png','close');
end

%% stats sur les windows -10, -5, et +5, et L : freq, bursts, regularite, spike-distance moyen par unit
tabledata = table;
irow = 0;
clear data_bl data_lvfa p
% recuperer les donnees
for ipatient = 1:size(config, 2)
    
    if isempty(config{ipatient})
        continue
    end
    
    for i_unit = 1:size(SpikeTrials{ipatient}{1}.PreCrise_10s.label, 2)
        for itrial = config{ipatient}.triallist
            
            %find lvfa marker number as there can be less lvfa markers than
            %crisestart marker
            crisestart = SpikeTrials{ipatient}{1}.PreCrise_5s.trialinfo.endtime(itrial);
            lvfa_trial = nearest(seconds(SpikeTrials{ipatient}{1}.LVFA.trialinfo.starttime-crisestart), 0);
            
            irow = irow + 1;
            tabledata.patient{irow}                 = config{ipatient}.prefix(1:end-1);
            tabledata.group{irow}                   = config{ipatient}.group;
            tabledata.unit_ID{irow}                 = SpikeTrials{ipatient}{1}.PreCrise_10s.label{i_unit};
            tabledata.quality{irow}                 = SpikeTrials{ipatient}{1}.PreCrise_10s.cluster_group{i_unit};
            tabledata.freq_baseline(irow)           = SpikeStats{ipatient}{1}.PreCrise_10s{i_unit}.trialfreq(itrial);
            tabledata.freq_lvfa(irow)               = SpikeStats{ipatient}{1}.LVFA{i_unit}.trialfreq(lvfa_trial);
            tabledata.cv2_baseline(irow)            = SpikeStats{ipatient}{1}.PreCrise_10s{i_unit}.CV2_trial(itrial);
            tabledata.cv2_lvfa(irow)                = SpikeStats{ipatient}{1}.LVFA{i_unit}.CV2_trial(lvfa_trial);
            tabledata.nr_of_bursts_baseline(irow)   = SpikeStats{ipatient}{1}.PreCrise_10s{i_unit}.burst_trialsum(itrial);
            tabledata.nr_of_bursts_lvfa(irow)       = SpikeStats{ipatient}{1}.LVFA{i_unit}.burst_trialsum(lvfa_trial);
            tabledata.spike_dist_mean_baseline(irow)= mean(SpikeStats{ipatient}{1}.PreCrise_10s{i_unit}.dist(:, itrial));
            tabledata.spike_dist_mean_lvfa(irow)    = mean(SpikeStats{ipatient}{1}.LVFA{i_unit}.dist(:, lvfa_trial));
        end
    end
end

% replace nans per zero for freq and number of bursts
tabledata.freq_baseline(isnan(tabledata.freq_baseline))                 = 0;
tabledata.freq_lvfa(isnan(tabledata.freq_lvfa))                         = 0;
tabledata.nr_of_bursts_baseline(isnan(tabledata.nr_of_bursts_baseline)) = 0;
tabledata.nr_of_bursts_lvfa(isnan(tabledata.nr_of_bursts_lvfa))         = 0;

for igroup = ["simple", "slowwave"]
    for iparam = ["freq", "cv2", "nr_of_bursts", "spike_dist_mean"]
        data_idx                     = strcmp(tabledata.group, igroup);
        data_bl.(igroup).(iparam)    = tabledata.(sprintf('%s_baseline', iparam))(data_idx);
        data_lvfa.(igroup).(iparam)  = tabledata.(sprintf('%s_lvfa', iparam))(data_idx);
        p.(igroup).(iparam)          = signrank(data_bl.(igroup).(iparam), data_lvfa.(igroup).(iparam));
    end
end

tablestats = table;
irow = 0;
for iparam = ["freq", "cv2", "nr_of_bursts", "spike_dist_mean"]
    irow = irow+1;
    
    tablestats.parameter(irow) = iparam;
    
    % baseline
    tablestats.baseline_simple_mean(irow)   = mean(data_bl.simple.(iparam), 'omitnan');
    tablestats.baseline_simple_std(irow)    = std(data_bl.simple.(iparam), 'omitnan');
    tablestats.baseline_slowwave_mean(irow) = mean(data_bl.slowwave.(iparam), 'omitnan');
    tablestats.baseline_slowwave_std(irow)  = std(data_bl.slowwave.(iparam), 'omitnan');
    
    % LVFA 
    tablestats.lvfa_simple_mean(irow)       = mean(data_lvfa.simple.(iparam), 'omitnan');
    tablestats.lvfa_simple_std(irow)        = std(data_lvfa.simple.(iparam), 'omitnan');
    tablestats.lvfa_slowwave_mean(irow)     = mean(data_lvfa.slowwave.(iparam), 'omitnan');
    tablestats.lvfa_slowwave_std(irow)      = std(data_lvfa.slowwave.(iparam), 'omitnan');
    
    % p-values
    tablestats.p_value_baseline(irow)       = ranksum(data_bl.simple.(iparam), data_bl.slowwave.(iparam)); %baseline entre les 2 groupes
    tablestats.p_value_lvfa(irow)           = ranksum(data_lvfa.simple.(iparam), data_lvfa.slowwave.(iparam)); %lvfa entre les 2 groupes
    tablestats.p_value_simple(irow)         = p.simple.(iparam);%baseline et lvfa au sein du groupe
    tablestats.p_value_slowwave(irow)       = p.slowwave.(iparam); %baseline et lvfa au sein du groupe
end
    
pval_orig = table2array(tablestats(:, end-3:end));
[~, ~, ~, pval_corrected] = fdr_bh(pval_orig);

writetable(tabledata, fullfile(config{1}.datasavedir, 'allpatients_datas_spikes.xlsx'));
writetable(tablestats, fullfile(config{1}.datasavedir, 'allpatients_stats_spikes.xlsx'));

%% waveforms and ISI distribution
% re adapter read spike waveforms pour lire les spikes deja separes en trials
% raw
% mean +/- std
% une figure par patient

isi_limits = [0 0.025];

for ipatient = 1:size(config, 2)
    if isempty(config{ipatient})
        continue
    end
    
    config{ipatient}.plotspike.plotraw    = true;
    config{ipatient}.plotspike.suffix     = '_raw';
    config{ipatient}.plotspike.isi_lim    = isi_limits;
    config{ipatient}.plotspike.img_format = ["png", "pdf"];
    plot_spike_waveforms(config{ipatient}, "window", WaveformStats{ipatient}, SpikeStats{ipatient}, SpikeWaveforms{ipatient});

    config{ipatient}.plotspike.plotraw    = false;
    config{ipatient}.plotspike.suffix     = '_avg';
    config{ipatient}.plotspike.img_format = ["png", "pdf"];
    plot_spike_waveforms(config{ipatient}, "window", WaveformStats{ipatient}, SpikeStats{ipatient});
end

%% Classification PN/IN 
% a voir pour faire une fonction generale
tokeep = ~cellfun(@isempty, config);

classification_celltype(config(tokeep), true, true);

% for imethod = ["bartho", "elahian"]
% table_celltype = table;
% irow = 0;
% 
%     fig = figure;%hold on
%     for ipatient = 1:size(config,2)
%         if isempty(config{ipatient})
%             continue
%         end
%         for i_unit = 1:size(WaveformStats{ipatient}{ipart}.label, 2)
%             
%             %         WaveformStats{ipatient}{ipart}.peak_direction(i_unit) = 1; %a retirer
%             
%             x = WaveformStats{ipatient}{ipart}.halfwidth.val(i_unit) * 1000;
%             y = WaveformStats{ipatient}{ipart}.troughpeak.val(i_unit) * 1000; %en ms
%             %waveform asymetry : Elahian 2018
%             a = WaveformStats{ipatient}{ipart}.peaktrough.y(i_unit, 1) * -WaveformStats{ipatient}{ipart}.peak_direction(i_unit);
%             b = WaveformStats{ipatient}{ipart}.troughpeak.y(i_unit, 2) * -WaveformStats{ipatient}{ipart}.peak_direction(i_unit);
%             peak_asymetry = (b-a)/(b+a);
%             
%             %values to separate in and pn determined empirically
%             %                 if x>2.25*10^-4 && z>6*10^-4 %PN
%             if x>3.4*10^-4 || (x>2*10^-4&& y>4.7*10^-4) || y>6*10^-4%PN
%                 celltype = 'pn';
%                 plottype = 'b';
%             else %IN
%                 celltype = 'in';
%                 plottype = 'r';
%             end
%             
%             % celltype = 'to_determine';
%             % plottype = 'b';
%             %
%             if imethod == "bartho"
%                 if contains(WaveformStats{ipatient}{ipart}.cluster_group{i_unit}, 'good')
%                     scatter(x,y,plottype, 'filled');
%                 else
%                     scatter(x,y,plottype);
%                 end
%             elseif imethod == "elahian"
%                 if contains(WaveformStats{ipatient}{ipart}.cluster_group{i_unit}, 'good')
%                     scatter3(x,y,peak_asymetry,plottype, 'filled'); % 3D plot
%                 else
%                     scatter3(x,y,peak_asymetry,plottype); % 3D plot
%                 end
%             end
%             hold on
%             
%             irow = irow+1;
%             table_celltype.patient_ID{irow} = config{ipatient}.prefix(1:end-1);
%             table_celltype.unit_ID{irow}    = WaveformStats{ipatient}{ipart}.label{i_unit};
%             table_celltype.quality{irow}    = WaveformStats{ipatient}{ipart}.cluster_group{i_unit};
%             table_celltype.halfwidth_ms(irow)  = x;
%             table_celltype.troughpeak_ms(irow) = y;
%             table_celltype.peak_asymetry(irow) = peak_asymetry;
%             table_celltype.cell_type{irow}  = celltype;
%         end
%     end
%     
%     set(gca, 'TickDir', 'out', 'FontWeight', 'bold', 'FontSize', 15);
%     xlabel('halfwidth(ms)');
%     ylabel('trough-peak (ms)');
%     zlabel('peak asymetry');
%     
%     %bartho 2004
%     
%     if imethod == "bartho"
%         xlim([0.1 0.6]); ylim([0.25 1.55]); %same as Bartho 2004
%     end
%     %Elahian 2018 : (ne fonctionne pas avec nos donnees)
% %     xlim([0 0.5]);
% %     ylim([0.08 0.28]);
% %     zlim([-2.5 2.5]);
%     
%     figname = fullfile(config{1}.imagesavedir, '..', 'Classification_in_pn', imethod);
%     savefigure_own(fig, figname, 'png', 'pdf', 'fig', 'close');
%     
% end
% writetable(table_celltype, fullfile(config{1}.datasavedir, 'allpatients_cell_type.xlsx'));
% 

%% exemple de LFP + TFR
toi = [10 30];

for ipatient = 8%1:size(config,2)
    if isempty(config{ipatient})
        continue
    end
    
    for itrial = config{ipatient}.triallist
        
        % compute TFR
        cfgtemp                         = [];
        cfgtemp.channel                 = 1;
        cfgtemp.method                  = 'mtmconvol';
        cfgtemp.output                  = 'pow';
        cfgtemp.taper                   = 'hanning';
        %             cfgtemp.taper                   = 'dpss';
        %             cfgtemp.tapsmofrq               = 5;
        cfgtemp.pad                     = 'nextpow2';
        cfgtemp.trials                  = itrial;
        cfgtemp.foi                     = 1:50;
        cfgtemp.t_ftimwin               = 7./cfgtemp.foi;
        cfgtemp.toi                     = toi(1):0.2:toi(2);
        TFR.raw                         = ft_freqanalysis(cfgtemp,  LFP{ipatient}{ipart}.CriseStart);
        
        cfgtemp = [];
        cfgtemp.baseline     = [-20 0];
        cfgtemp.baselinetype = 'relative';
        TFR.blcorrected = ft_freqbaseline(cfgtemp, TFR.raw);
        
        for i_blcorr  = ["raw", "blcorrected"]
            for i_log = ""%["", "_log"]
                
                if i_log == "_log"
                    TFR.(i_blcorr).powspctrm = log10(TFR.(i_blcorr).powspctrm);
                end
                
                fig = figure;
                sgtitle(sprintf('%s : %s%s', config{ipatient}.prefix(1:end-1), i_blcorr, i_log), 'interpreter', 'none');
                %plot TFR
                
                subplot(2,1,2);
                cfgtemp = [];
                cfgtemp.zlim    = config{ipatient}.TFR.(i_blcorr).zlim;%'maxmin';
                %             cfgtemp.ylim = [0 50];
                cfgtemp.figure  = 'gca';
                cfgtemp.colormap = 'jet';
                ft_singleplotTFR(cfgtemp, TFR.(i_blcorr));
                c = colorbar;
                set(c, 'Location', 'southoutside', 'color', [0 0 0]);
                
                xlabel('Time (s)');
                ylabel('Freq (Hz)');
                
                ft_pimpplot(gcf, jet, true, false);
                title([]);
                set(gca, 'tickdir', 'out', 'fontsize', 15);
                
                %plot LFP
                subplot(2,1,1);
               
                %plot(LFP{1}.Crise.time{itrial}, LFP{1}.Crise.trial{itrial}(1,:), 'k'); %for ed3c to plot stim
                plot(LFP{ipatient}{ipart}.Crise.time{itrial}, LFP{ipatient}{ipart}.Crise.trial{itrial}(1,:), 'k'); %for ed3c to plot all the seizure
                %plot(LFP{ipatient}{ipart}.CriseStart.time{itrial}, LFP{ipatient}{ipart}.CriseStart.trial{itrial}(1,:), 'k');
                
                xlim(toi);
                ylabel('uV');
                %ylim([-300 300])
                set(gca, 'tickdir', 'out', 'fontsize', 15);
                figname = fullfile(config{ipatient}.imagesavedir, '..', 'ZoomedSeizure', sprintf('%sSeizure', config{ipatient}.prefix)); % for ed3c 
                %figname = fullfile(config{ipatient}.imagesavedir, '..', 'TFR', sprintf('%sTFR_%s%s', config{ipatient}.prefix, i_blcorr, i_log));
                savefigure_own(fig, figname, 'landscape', 'png', 'pdf', 'close');
            end
        end
        
    end
    
end

%% toutes les crises superposees, par groupe
clear h
toilist = {[-20 20], [-5 5], [-5 10], [-40 30], "lvfa"};

h.simple = 400;
h.slowwave = 600;

for toi = toilist
    for igroup = ["simple", "slowwave"]
        iplot = 0;
        fig = figure; hold on
        for ipatient = 1:size(config,2)
            if isempty(config{ipatient})
                continue
            end
            
            if ~strcmp(config{ipatient}.group, igroup)
                continue
            end
            
            for itrial = config{ipatient}.triallist
                
                if strcmp(toi{1}, "lvfa")
                    t_lvfa = find_muse_marker_in_trial(SpikeTrials{ipatient}{ipart}.CriseStart, MuseStruct{ipatient}, itrial, 'LVFA_End');
                    cfgtemp = [];
                    cfgtemp.latency = [-2 t_lvfa+2];
                    cfgtemp.trials = itrial;
                    data_temp = ft_selectdata(cfgtemp, LFP{ipatient}{ipart}.CriseStart);
                    x = data_temp.time{1};
                    y = data_temp.trial{1}(1,:);
                else
                    x = LFP{ipatient}{ipart}.CriseStart.time{itrial};
                    y = LFP{ipatient}{ipart}.CriseStart.trial{itrial}(1,:);
                end
                
                iplot = iplot+1;
                plot(x, y+iplot*h.(igroup), 'k');
                plot_name{iplot} = sprintf('pat_%d_trial_%d', ipatient, itrial);
                
            end
        end
        
        if strcmp(toi{1}, "lvfa")
            axis tight
        else
            xlim(toi{1}');
        end
        y = ylim;
        %plot([0 0], y, '--r', 'linewidth', 2);
        xlabel('Time (s)');
        yticks(h.(igroup): h.(igroup) : iplot*h.(igroup));
        yticklabels(strrep(string(plot_name), '_', ' '));
        set(gca, 'tickdir', 'out', 'fontsize', 15);
        title(igroup, 'interpreter', 'none', 'fontsize', 18);
        
        if  strcmp(toi{1}, "lvfa")
            fname = fullfile(config{1}.imagesavedir, '..', 'all_seizures_group', sprintf('all_seizures_%s_%s', igroup, toi{1}));
        else
            fname = fullfile(config{1}.imagesavedir, '..', 'all_seizures_group', sprintf('all_seizures_%s_%d_%d', igroup, toi{1}(1), toi{1}(2)));
        end
        savefigure_own(fig, fname, 'png', 'pdf', 'close');
        
    end
end

%% plot MUA
%choisir quel patient et quelles units illustrer
toi = [-2 3];
for ipatient = 1:size(config, 2)
    if isempty(config{ipatient})
        continue
    end
    for itrial = config{ipatient}.triallist
        plot_spike_trial_example(config{ipatient}, SpikeTrials{ipatient}, WaveformStats{ipatient}, ipart, 'CriseStart', itrial, toi)
    end
end

% for ipatient = 8
%     if isempty(config{ipatient})
%         continue
%     end
%     
%     for itrial = config{ipatient}.triallist
%         
%         for ichannel = 1:size(config{ipatient}.circus.channel, 2)
%             
%             %find trial samples to load filtered data
%             idir = SpikeTrials{ipatient}{ipart}.CriseStart.trialinfo.idir(itrial);
%             channame = config{ipatient}.circus.channel{ichannel};
%             temp = dir(fullfile(config{ipatient}.rawdir, config{ipatient}.directorylist{ipart}{idir}, sprintf('*%s.ncs', channame)));
%             datapath = fullfile(temp.folder, temp.name);
%             
%             cfgtemp             = [];
%             cfgtemp.trl(1)      = SpikeTrials{ipatient}{ipart}.CriseStart.trialinfo.begsample_dir(itrial);
%             cfgtemp.trl(2)      = cfgtemp.trl(1) + (SpikeTrials{ipatient}{ipart}.CriseStart.trialinfo.endsample(itrial) - SpikeTrials{ipatient}{ipart}.CriseStart.trialinfo.begsample(itrial));
%             cfgtemp.trl(3)      = SpikeTrials{ipatient}{ipart}.CriseStart.trialinfo.offset(itrial);
%             cfgtemp.dataset     = datapath;
%             cfgtemp.hpfilter    = 'yes';
%             cfgtemp.hpfreq      = 300;
%             cfgtemp.hpfiltord   = 3;
%             dat                 = ft_preprocessing(cfgtemp);
%             
%             for i_highlight = ["", "_higlighted"]
%                 
%                 %plot data
%                 fig = figure; hold on;
%                 plot(dat.time{1}, -dat.trial{1}, 'k', 'linewidth', 1);
%                 
%                 if i_highlight == "_higlighted"
%                     unitssel = ichannel == SpikeTrials{ipatient}{ipart}.CriseStart.template_maxchan +1;
%                     
%                     Fs = SpikeTrials{ipatient}{ipart}.CriseStart.hdr.Fs;
%                     C = linspecer(sum(unitssel));
%                     icolor = 0;
%                     
%                     for i_unit = find(unitssel)
%                         icolor = icolor+1;
%                         idx = SpikeTrials{ipatient}{ipart}.CriseStart.trial{i_unit} == itrial;
%                         spikes = SpikeTrials{ipatient}{ipart}.CriseStart.time{i_unit}(idx);
%                         for ispike = 1 : size(spikes, 2)
%                             if spikes(ispike) - 0.02 < dat.time{1}(1) || spikes(ispike) + 0.02 > dat.time{1}(end)
%                                 continue
%                             end
%                             temp = round((spikes(ispike) - 0.02) * Fs) : round((spikes(ispike) + 0.02) * Fs);
%                             sel = double(temp) - double(SpikeTrials{ipatient}{ipart}.CriseStart.trialinfo.offset(itrial));
%                             plot(dat.time{1}(sel), -dat.trial{1}(sel), 'color', C(icolor, :), 'linewidth', 1.5);%[1 0.6 0.2]);
%                         end
%                     end
%                 end
%                 
%                 title(sprintf('%s', config{ipatient}.prefix(1:end-1)), 'interpreter', 'none');
%                 set(gca, 'tickdir', 'out', 'fontsize', 15);
%                 xlim(toi)
%                 xlabel('time (s)');
%                 ylabel('uV');
%                 figname = fullfile(config{ipatient}.imagesavedir, '..', 'MUA', sprintf('%sMUA_trial_%d_channel_%s%s', config{ipatient}.prefix, itrial, channame, i_highlight));
%                 
%                 savefigure_own(fig, figname, 'landscape', 'png', 'pdf', 'close');
%                 
%             end
%         end
%     end
% end

%% plot toutes les electrodes d'un patient 
toilist = {[-20 20], [-40 30], "lvfa"};
h.all = 600;
ipatient = 13;
patname = erase(config{ipatient}.prefix, "_m2mCi-");

for toi = toilist
    iplot = 0;
    fig = figure; hold on

    for ielec = 1:size(config{ipatient}.LFP.channel, 2)

        for itrial = config{ipatient}.triallist

            if strcmp(toi{1}, "lvfa")
                t_lvfa = find_muse_marker_in_trial(SpikeTrials{ipatient}{ipart}.CriseStart, MuseStruct{ipatient}, itrial, 'LVFA_End');
                cfgtemp = [];
                cfgtemp.latency = [-2 t_lvfa+2];
                cfgtemp.trials = itrial;
                data_temp = ft_selectdata(cfgtemp, LFP{ipatient}{ipart}.CriseStart);
                x = data_temp.time{1};
                y = data_temp.trial{1}(ielec,:);
            else
                x = LFP{ipatient}{ipart}.CriseStart.time{itrial};
                y = LFP{ipatient}{ipart}.CriseStart.trial{itrial}(ielec,:);
            end

            iplot = iplot+1;
            plot(x, y-iplot*h.all, 'k');
            elecname = string(config{ipatient}.LFP.channel(iplot));
            plot_name{iplot} = sprintf('%s', elecname);

        end
    end

    if strcmp(toi{1}, "lvfa")
        axis tight
    else
        xlim(toi{1}');
    end
    y = ylim;
    %plot([0 0], y, '--r', 'linewidth', 2);
    xlabel('Time (s)');
    yticks(h.all: h.all : iplot*h.all);
    yticklabels(strrep(string(plot_name), '_', ' '));
    plot([0 0], y, '--r', 'linewidth', 1);
    set(gca, 'tickdir', 'out', 'fontsize', 15);
    title(patname, 'interpreter', 'none', 'fontsize', 18);

    if  strcmp(toi{1}, "lvfa")
        fname = fullfile(config{1}.imagesavedir, '..', 'all_macros_pat', sprintf('all_macros_%s_%s', config{ipatient}.prefix, toi{1}));
    else
        fname = fullfile(config{1}.imagesavedir, '..', 'all_seizures_pat', sprintf('all_macros_%s_%d_%d', config{ipatient}.prefix, toi{1}(1), toi{1}(2)));
    end
    savefigure_own(fig, fname, 'png', 'pdf', 'close');

end

%% temps LVFA moyen selon groupes
clear t_lvfa
tabledata = table;
irow = 0;
for igroup = ["simple", "slowwave"]
    for ipatient = 1:size(config, 2)
        
        if isempty(config{ipatient})
            continue
        end
        
        if ~strcmp(config{ipatient}.group, igroup)
            continue
            
        end
        for itrial = config{ipatient}.triallist
            irow = irow + 1;
            
            t_lvfa{ipatient} = find_muse_marker_in_trial(SpikeTrials{ipatient}{ipart}.CriseStart, MuseStruct{ipatient}, itrial, 'LVFA_End');
            tabledata.patient{irow} = config{ipatient}.prefix(1:end-1);
            tabledata.group{irow}   = config{ipatient}.group;
            tabledata.lvfa_duration(irow)  = t_lvfa{ipatient};
        end
        
    end
end
writetable(tabledata, fullfile(config{1}.datasavedir, 'allpatients_lvfa_duration.xlsx'));

%% sur une période de 10 minutes avec fenetre de 5 secondes glissantes : freq, bursts, synchronie
% Voir comment faire ça. Probablement définir une fenetre de 10 minutes,
% puis la couper à la mains en trials de 5 secondes pour appliquer
% spiketrialstats.m

%% Phase locking LFP et SUA
% voir le LFP moyen autour de chaque spike
% voir la phase moyenne autour de chaque spike

