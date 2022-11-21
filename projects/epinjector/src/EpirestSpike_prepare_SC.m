function EpirestSpike_prepare_SC

%analyses individuelles

restoredefaultpath
if ispc
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\shared'))
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\external'))
%     addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\templates'))
%     addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\EpiCode\projects\onset'))
%     addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\SPIKY_mar_2022'))
    addpath (genpath('\\l2export\iss02.charpier\analyses\vn_onset\fieldtrip'))
%     addpath (genpath('..\..\Epicode\shared'))
%     addpath (genpath('..\..\Epicode\external'))
%     addpath (genpath('..\..\fieldtrip'))
elseif isunix
    addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/shared'))
    addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/external'))
%     addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/templates'))
%     addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/EpiCode/projects/onset'))
%     addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/SPIKY_apr_2021'))
    addpath (genpath('/network/lustre/iss02/charpier/analyses/vn_onset/fieldtrip'))
%     addpath (genpath('../../Epicode/shared'))
%     addpath (genpath('../../Epicode/external'))
%     addpath (genpath('../../fieldtrip'))
end
ft_defaults

config = EpirestSpike_setparams;
ipart = 1;

%% prepare data for Spyking Circus
% write a new joblist for the cluster
EpirestSpike_slurm_joblist(config);



for isession = 1:8%1:size(config, 2)  % à définir (1 : n si plusieurs patients)

    if isempty(config{isession});
        continue
    end
    
    % read muse markers
    MuseStruct = readMuseMarkers(config{isession}, true);

    % Add "BAD" markers around the period of interest
    MuseStruct = addMuseBAD(config{isession}, MuseStruct);

    % write artefacts to file
    writeSpykingCircusDeadfiles(config{isession}, MuseStruct, true, '_period_SS');

   
    % write parameters file for spyking circus
    writeSpykingCircusParameters(config{isession});

    % write file list for spyking circus ---> LINUX
    writeSpykingCircusFileList(config{isession}, true);
    %
    %     %%
    %     % Now do your spike sorting
    %     %%
end 