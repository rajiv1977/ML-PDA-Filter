%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p,t,s] = generate_sensor_path(p,t,s)

if(length(s.sensor_no(1).initial_state)~=5)
    
    % For all sensors
    for i=1 : s.no_of_sensors
        temp = s.sensor_no(i).initial_state ;
        temp_truth = [ s.sensor_no(i).start_time , temp' ] ;
        
        % For all legs
        for j=1 : length(s.sensor_no(i).leg)
            
            switch s.sensor_no(i).leg(j).model
                
                case 'CONSTANT VELOCITY'
                    [temp_truth, temp] = mlpda_.generate_CV_truth(temp_truth, temp, s.sensor_no(i).leg(j),p.sampling_time);
                case 'CONSTANT TURN'
                    [temp_truth, temp] = mlpda_.generate_CT_truth(temp_truth, temp, s.sensor_no(i).leg(j), p.sampling_time);
                case 'STATIONARY'
                    [temp_truth, temp] = mlpda_.generate_STAND_truth(temp_truth, temp, s.sensor_no(i).leg(j));
                otherwise
                    disp('No model found');
                    
            end % end of switch
            
        end
        s.sensor_no(i).truth = temp_truth ;
    end % end of all sensors
    
    % for i=1 : s.no_of_sensors
    %     disp('--------------------------------------------');
    %     disp('sensor path');
    %     disp(s.sensor_no(i).truth);
    % end
    
else
    
    % For all sensors
    for i=1 : s.no_of_sensors
        temp = s.sensor_no(i).initial_state ;
        temp_truth = [ s.sensor_no(i).start_time , temp' ] ;
        
        % For all legs
        for j=1 : length(s.sensor_no(i).leg)
            
            switch s.sensor_no(i).leg(j).model
                
                case 'CONSTANT VELOCITY'
                    [temp_truth, temp] = mlpda_.generate_CV_freq_truth(temp_truth, temp, s.sensor_no(i).leg(j),p.sampling_time);
                case 'CONSTANT TURN'
                    [temp_truth, temp] = mlpda_.generate_CT_freq_truth(temp_truth, temp, s.sensor_no(i).leg(j), p.sampling_time);
                case 'STATIONARY'
                    [temp_truth, temp] = mlpda_.generate_STAND_truth(temp_truth, temp, s.sensor_no(i).leg(j));
                otherwise
                    disp('No model found');
                    
            end % end of switch
            
        end
        s.sensor_no(i).truth = temp_truth ;
    end % end of all sensors
    
    % for i=1 : s.no_of_sensors
    %     disp('--------------------------------------------');
    %     disp('sensor path');
    %     disp(s.sensor_no(i).truth);
    % end
    
    
end

end