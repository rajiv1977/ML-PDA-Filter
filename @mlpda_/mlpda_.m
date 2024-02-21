%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef mlpda_
    
    properties
        
    end
    
    methods(Static)
        [x,fval,exitflag,output] = mlpda_main(p,s,target,mlpda,current_time, sNo);
        
        X = set_CV_models(X,T,p_noise);
        X = set_CV_freq_models(X,T,p_noise);
        
        X = set_EOIR_models(X,T,p_noise);
        %X = set_CV_freq_models(X,T,p_noise);
        
        X = set_CT_models(X, T, p_noise, w, w_noise);
        X = set_CT_freq_models(X, T, p_noise, w, w_noise);
        
        plot_target_truth_and_sensor(p,t,s,x,status,tracks);
        plot_meas(s);
        [Z, LnZ] = getZ(X,Y,s,p,t);
        [p,t,s] = get_target_models(p,t,s);
        [p,t,s] = get_sensor_models(p,t,s);
        [J] = get_CRLB(p,t,s);
        [p,t,s] = generate_target_truth(p,t,s);
        [p,t,s] = generate_target_measurement(p,t,s);
        [p,t,s] = generate_sensor_path(p,t,s);
        [p,t,s] = generate_measurement_set(p,t,s);
        
        x = trackconfirm(p,t,s,x,current_time);
        
        tracks = fuseTrack(s,trackSet);
        
        OSPA(p,t,s,m,sta);
        
        [temp_truth, temp] = generate_CV_truth(temp_truth, temp, X , sample_T );
        [temp_truth, temp] = generate_CV_freq_truth(temp_truth, temp, X , sample_T );
        
        [temp_truth, temp] = generate_CV_EOIR_truth(temp_truth, temp, X , sample_T );
        %[temp_truth, temp] = generate_CV_freq_truth(temp_truth, temp, X , sample_T );
        
        [temp_truth, temp] = generate_CT_truth( temp_truth , temp , X , T ); 
        [temp_truth, temp] = generate_CT_freq_truth( temp_truth , temp , X , T );
    end
    
end

