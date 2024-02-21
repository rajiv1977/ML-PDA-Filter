%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p,t,s] = get_sensor_models(p,t,s)

if(length(s.sensor_no(1).initial_state)~=5)
    
    for i = 1 : s.no_of_sensors
        
        % For all sensor motion legs
        for j= 1 : s.sensor_no(i).no_of_legs
            
            switch s.sensor_no(i).leg(j).model
                
                case 'CONSTANT VELOCITY'
                    [s.sensor_no(i).leg(j)] = mlpda_.set_CV_models( s.sensor_no(i).leg(j), p.sampling_time, s.sensor_no(i).leg(j).p_noise_variance);
                case 'CONSTANT TURN'
                    [s.sensor_no(i).leg(j)] = mlpda_.set_CT_models( s.sensor_no(i).leg(j), p.sampling_time, s.sensor_no(i).leg(j).p_noise_variance, s.sensor_no(i).leg(j).angular_rate, s.sensor_no(i).leg(j).turn_rate_noise_variance);
                otherwise
                    disp('No model found');
                    
            end % end of switch
            
        end % end of legs
        
    end % end of all sensors
    
else
    
    for i = 1 : s.no_of_sensors
        
        % For all sensor motion legs
        for j= 1 : s.sensor_no(i).no_of_legs
            
            switch s.sensor_no(i).leg(j).model
                
                case 'CONSTANT VELOCITY'
                    [s.sensor_no(i).leg(j)] = mlpda_.set_CV_freq_models( s.sensor_no(i).leg(j), p.sampling_time, s.sensor_no(i).leg(j).p_noise_variance);
                case 'CONSTANT TURN'
                    [s.sensor_no(i).leg(j)] = mlpda_.set_CT_freq_models( s.sensor_no(i).leg(j), p.sampling_time, s.sensor_no(i).leg(j).p_noise_variance, s.sensor_no(i).leg(j).angular_rate, s.sensor_no(i).leg(j).turn_rate_noise_variance);
                otherwise
                    disp('No model found');
                    
            end % end of switch
            
        end % end of legs
        
    end % end of all sensors
    
end

end