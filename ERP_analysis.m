%% time lock analysis
% Baseline-correction options
cfg = [];
cfg.demean          = 'yes';
cfg.baselinewindow  = [0.25 0.5];
baseLineSub_bi            = ft_preprocessing(cfg,data_bi_ICA_filt_reRef_clean);
newdata_mono            = ft_preprocessing(cfg,data_bi_ICA_filt_reRef_clean);


cfg = [];
ERP_bi = ft_timelockanalysis(cfg,baseLineSub_bi);
ERP_mono = ft_timelockanalysis(cfg,newdata_mono);

%%
cfg = [];
cfg.trials = data_bi_ICA_filt_reRef_clean.trialinfo== 1;
bi_L1 = ft_selectdata (cfg,data_bi_ICA_filt_reRef_clean);
%%
cfg = [];
cfg.trials = data_bi_ICA_filt_reRef_clean.trialinfo== 2;
bi_L2 = ft_selectdata (cfg,data_bi_ICA_filt_reRef_clean);

%%
cfg = [];
cfg.layout = 'quickcap64.mat';
cfg.interactive = 'yes';
cfg.showoutline = 'yes';
ft_multiplotER(cfg, bi_L1, bi_L2 )

%%
% % ERP analysis based on the stimulus type
% cfg = [];
% cfg.trials = find(data_biling.trialinfo==1);
% L1_data = ft_timelockanalysis(cfg, data_biling);
% cfg = [];
% cfg.trials = find(data_biling.trialinfo==0);
% L2_data = ft_timelockanalysis(cfg, data_biling);
% 
% cfg.layout = 'quickcap64.mat';
% cfg.interactive = 'yes';
% cfg.showoutline = 'yes';
% ft_multiplotER(cfg,L1_data,L2_data);