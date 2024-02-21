%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mlpda.batch_steps                                   = 20;
mlpda.intial_grid_length                            = 2500;
mlpda.grid_length                                   = 750;
mlpda.final_grid                                    = 250;
mlpda.v_max                                         = 4;
mlpda.MaxFunEvals                                   = 1e+100;
mlpda.TolFun                                        = 1e-50;
mlpda.TolX                                          = 1e-20;
mlpda.TolCon                                        = 1e-10;
mlpda.pi_m                                          = 0.1;
mlpda.miss_prob                                     = 0.05;
mlpda.mcr                                           = 1000;

%%%%%%%%%%%%%%%%%
% Property      %
%%%%%%%%%%%%%%%%%
pro.sampling_time                                   = 1;
pro.c                                               = 340;
pro.servival_region                                 = [4000 10000; 0 4000];

%%%%%%%%%%%%%%%
%Targets info %
%%%%%%%%%%%%%%%

target.no_of_targets                                = 1;
target.target_no(1).initial_state                   = [-6000 15 4000 15]';
target.target_no(1).start_time                      = 1;
target.target_no(1).no_of_legs                      = 1;
target.target_no(1).truth                           = [];
target.target_no(1).leg(1).model                    = 'CONSTANT VELOCITY EOIR';
target.target_no(1).leg(1).p_noise_variance         = 1.0000e-08;
target.target_no(1).leg(1).duration                 = 1601;
target.target_no(1).leg(1).angular_rate             = [];
target.target_no(1).leg(1).turn_rate_noise_variance = [];
target.target_no(1).leg(1).F                        = [];
target.target_no(1).leg(1).Q                        = [];
target.target_no(1).leg(1).V                        = [];

%%%%%%%%%%%%%%
%Sensor info %
%%%%%%%%%%%%%%

sensor.no_of_sensors                                = 1;

%%%%%%%%%%%%%%%%%%%%%%% Sensor 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sensor.sensor_no(1).FOV                             = [0 1000; 0 1000];
sensor.sensor_no(1).type                            = 'BEARING';
sensor.sensor_no(1).bearing_range                   = [-pi pi]';
sensor.sensor_no(1).elevation_range                 = [-pi pi]';
sensor.sensor_no(1).freq_range                      = [747 753]';
sensor.sensor_no(1).alt                             = 2000;

sensor.sensor_no(1).m_noise_variance                = (pi/180)*(0.75^2);
sensor.sensor_no(1).freq_noise_variance             = 0.07^2;
sensor.sensor_no(1).threshold                       = 2.2;
sensor.sensor_no(1).SNR                             = 5;

sensor.sensor_no(1).SNR_db2norm = 10^(sensor.sensor_no(1).SNR/20);

sensor.sensor_no(1).PD                              = exp(-1*sensor.sensor_no(1).threshold^2/(2*(1+sensor.sensor_no(1).SNR_db2norm)));
sensor.sensor_no(1).PFA                             = exp((-1*sensor.sensor_no(1).threshold^2)/2);

sensor.sensor_no(1).PD
sensor.sensor_no(1).PFA
sensor.sensor_no(1).SNR_db2norm

sensor.sensor_no(1).initial_state                   = [-8000 100 -2000 100]';
sensor.sensor_no(1).start_time                      = 1;
sensor.sensor_no(1).no_of_legs                      = 3;

sensor.sensor_no(1).leg(1).model                    = 'CONSTANT VELOCITY';
sensor.sensor_no(1).leg(1).duration                 = 300;
sensor.sensor_no(1).leg(1).p_noise_variance         = 0;
sensor.sensor_no(1).leg(1).angular_rate             = [];
sensor.sensor_no(1).leg(1).turn_rate_noise_variance = [];
sensor.sensor_no(1).leg(1).F                        = [];
sensor.sensor_no(1).leg(1).Q                        = [];
sensor.sensor_no(1).leg(1).V                        = [];

sensor.sensor_no(1).leg(2).model                    = 'CONSTANT TURN';
sensor.sensor_no(1).leg(2).duration                 = 1200;
sensor.sensor_no(1).leg(2).p_noise_variance         = 0;
sensor.sensor_no(1).leg(2).angular_rate             = 0.00500;
sensor.sensor_no(1).leg(2).turn_rate_noise_variance = 0;
sensor.sensor_no(1).leg(2).F                        = [];
sensor.sensor_no(1).leg(2).Q                        = [];
sensor.sensor_no(1).leg(2).V                        = [];

sensor.sensor_no(1).leg(3).model                    = 'CONSTANT VELOCITY';
sensor.sensor_no(1).leg(3).duration                 = 100;
sensor.sensor_no(1).leg(3).p_noise_variance         = 0;
sensor.sensor_no(1).leg(3).angular_rate             = [];
sensor.sensor_no(1).leg(3).turn_rate_noise_variance = [];
sensor.sensor_no(1).leg(3).F                        = [];
sensor.sensor_no(1).leg(3).Q                        = [];
sensor.sensor_no(1).leg(3).V                        = [];

sensor.sensor_no(1).truth                           = [];
sensor.sensor_no(1).measurement                     = [];
sensor.sensor_no(1).elevation                       = [];
sensor.sensor_no(1).measurement_set                 = [];
sensor.sensor_no(1).elevation_set                   = [];
sensor.sensor_no(1).measurement_amp_set             = [];
sensor.sensor_no(1).measurement_freq_set            = [];

% %%%%%%%%%%%%%%%%%%%%%%% Sensor 2a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sensor.sensor_no(2).FOV                             = [0 200; 0 200];
% sensor.sensor_no(2).type                            = 'BEARING';
% sensor.sensor_no(2).bearing_range                   = [-pi pi]';
% sensor.sensor_no(2).freq_range                      = [747 753]';
% sensor.sensor_no(2).alt                             = 2000;
% 
% sensor.sensor_no(2).m_noise_variance                = (pi/180)*(0.75^2);
% sensor.sensor_no(2).freq_noise_variance             = 0.07^2;
% sensor.sensor_no(2).threshold                       = 2.2;
% sensor.sensor_no(2).SNR                             = 5;
% 
% sensor.sensor_no(2).SNR_db2norm = 10^(sensor.sensor_no(1).SNR/20);
% 
% sensor.sensor_no(2).PD                              = exp(-1*sensor.sensor_no(1).threshold^2/(2*(1+sensor.sensor_no(1).SNR_db2norm)));
% sensor.sensor_no(2).PFA                             = exp((-1*sensor.sensor_no(1).threshold^2)/2);
% 
% sensor.sensor_no(2).PD
% sensor.sensor_no(2).PFA
% sensor.sensor_no(2).SNR_db2norm
% 
% sensor.sensor_no(2).initial_state                   = [-8000 100 -2000 100]';
% sensor.sensor_no(2).start_time                      = 1;
% sensor.sensor_no(2).no_of_legs                      = 3;
% 
% sensor.sensor_no(2).leg(1).model                    = 'CONSTANT VELOCITY';
% sensor.sensor_no(2).leg(1).duration                 = 300;
% sensor.sensor_no(2).leg(1).p_noise_variance         = 0;
% sensor.sensor_no(2).leg(1).angular_rate             = [];
% sensor.sensor_no(2).leg(1).turn_rate_noise_variance = [];
% sensor.sensor_no(2).leg(1).F                        = [];
% sensor.sensor_no(2).leg(1).Q                        = [];
% sensor.sensor_no(2).leg(1).V                        = [];
% 
% sensor.sensor_no(2).leg(2).model                    = 'CONSTANT TURN';
% sensor.sensor_no(2).leg(2).duration                 = 1200;
% sensor.sensor_no(2).leg(2).p_noise_variance         = 0;
% sensor.sensor_no(2).leg(2).angular_rate             = 0.00500;
% sensor.sensor_no(2).leg(2).turn_rate_noise_variance = 0;
% sensor.sensor_no(2).leg(2).F                        = [];
% sensor.sensor_no(2).leg(2).Q                        = [];
% sensor.sensor_no(2).leg(2).V                        = [];
% 
% sensor.sensor_no(2).leg(3).model                    = 'CONSTANT VELOCITY';
% sensor.sensor_no(2).leg(3).duration                 = 100;
% sensor.sensor_no(2).leg(3).p_noise_variance         = 0;
% sensor.sensor_no(2).leg(3).angular_rate             = [];
% sensor.sensor_no(2).leg(3).turn_rate_noise_variance = [];
% sensor.sensor_no(2).leg(3).F                        = [];
% sensor.sensor_no(2).leg(3).Q                        = [];
% sensor.sensor_no(2).leg(3).V                        = [];
% 
% sensor.sensor_no(2).truth                           = [];
% sensor.sensor_no(2).measurement                     = [];
% sensor.sensor_no(2).measurement_set                 = [];
% sensor.sensor_no(2).measurement_amp_set             = [];
% sensor.sensor_no(2).measurement_freq_set            = [];


% %%%%%%%%%%%%%%%%%%%% Sensor 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sensor.sensor_no(2).FOV                             = [0 200; 0 200];
% sensor.sensor_no(2).type                            = 'BEARING';
% sensor.sensor_no(2).bearing_range                   = [-pi pi]';
% sensor.sensor_no(2).freq_range                      = [747 753]';
% sensor.sensor_no(2).alt                             = 1000;
% 
% sensor.sensor_no(2).m_noise_variance                = (pi/180)*(0.75^2);
% sensor.sensor_no(2).freq_noise_variance             = 0.07^2;
% sensor.sensor_no(2).threshold                       = 2.2;
% sensor.sensor_no(2).SNR                             = 5;
% 
% sensor.sensor_no(2).SNR_db2norm = 10^(sensor.sensor_no(1).SNR/20);
% 
% sensor.sensor_no(2).PD                              = exp(-1*sensor.sensor_no(1).threshold^2/(2*(1+sensor.sensor_no(1).SNR_db2norm)));
% sensor.sensor_no(2).PFA                             = exp((-1*sensor.sensor_no(1).threshold^2)/2);
% 
% sensor.sensor_no(2).PD
% sensor.sensor_no(2).PFA
% sensor.sensor_no(2).SNR_db2norm
% 
% sensor.sensor_no(2).initial_state                   = [-8000 100 -3000 100]';
% sensor.sensor_no(2).start_time                      = 1;
% sensor.sensor_no(2).no_of_legs                      = 3;
% 
% sensor.sensor_no(2).leg(1).model                    = 'CONSTANT VELOCITY';
% sensor.sensor_no(2).leg(1).duration                 = 300;
% sensor.sensor_no(2).leg(1).p_noise_variance         = 0;
% sensor.sensor_no(2).leg(1).angular_rate             = [];
% sensor.sensor_no(2).leg(1).turn_rate_noise_variance = [];
% sensor.sensor_no(2).leg(1).F                        = [];
% sensor.sensor_no(2).leg(1).Q                        = [];
% sensor.sensor_no(2).leg(1).V                        = [];
% 
% sensor.sensor_no(2).leg(2).model                    = 'CONSTANT TURN';
% sensor.sensor_no(2).leg(2).duration                 = 1200;
% sensor.sensor_no(2).leg(2).p_noise_variance         = 0;
% sensor.sensor_no(2).leg(2).angular_rate             = -0.00500;
% sensor.sensor_no(2).leg(2).turn_rate_noise_variance = 0;
% sensor.sensor_no(2).leg(2).F                        = [];
% sensor.sensor_no(2).leg(2).Q                        = [];
% sensor.sensor_no(2).leg(2).V                        = [];
% 
% sensor.sensor_no(2).leg(3).model                    = 'CONSTANT VELOCITY';
% sensor.sensor_no(2).leg(3).duration                 = 100;
% sensor.sensor_no(2).leg(3).p_noise_variance         = 0;
% sensor.sensor_no(2).leg(3).angular_rate             = [];
% sensor.sensor_no(2).leg(3).turn_rate_noise_variance = [];
% sensor.sensor_no(2).leg(3).F                        = [];
% sensor.sensor_no(2).leg(3).Q                        = [];
% sensor.sensor_no(2).leg(3).V                        = [];
% 
% sensor.sensor_no(2).truth                           = [];
% sensor.sensor_no(2).measurement                     = [];
% sensor.sensor_no(2).measurement_set                 = [];
% sensor.sensor_no(2).measurement_amp_set             = [];
% sensor.sensor_no(2).measurement_freq_set            = [];

% X.duration
% X.F
% X.Q
% X.V
% X.angular_rate
