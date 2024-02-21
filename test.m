%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                      ML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;

MLPDA_parameter;
mlpda_
[p,t,s]      = mlpda_.get_target_models(pro,target,sensor);
[p,t,s]      = mlpda_.generate_target_truth(p,t,s);
[p,t,s]      = mlpda_.get_sensor_models(p,t,s);
[p,t,s]      = mlpda_.generate_sensor_path(p,t,s);
[p,t,s]      = mlpda_.generate_target_measurement(p,t,s);
[p,t,s]      = mlpda_.generate_measurement_set(p,t,s);
p
t
s

mlpda_.plot_meas(s);
for sNo=1:1:s.no_of_sensors    
    current_time = 50;
    [x,fval,exitflag,output] = mlpda_.mlpda_main(p,s,t,mlpda,current_time,sNo);
    flag(sNo).tracks = mlpda_.trackconfirm(p,t,s,x,current_time);
    
end
J = mlpda_.get_CRLB(p,t,s);

tracks = mlpda_.fuseTrack(s,flag);
mlpda_.OSPA(p,t,s,mlpda,tracks);
status = '3D';
mlpda_.plot_target_truth_and_sensor(p,t,s,x,status,tracks);





