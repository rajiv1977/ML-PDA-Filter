%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p,t,s] = generate_target_measurement(p,t,s)

% For all sensors
for l=1 : s.no_of_sensors
    temp_meas = [ ] ;
    temp_elev = [ ] ;
    % For all time steps
    T = s.sensor_no(l).start_time ;
    
    for j=s.sensor_no(l).start_time : length(s.sensor_no(l).truth(:,1)) % j=0 ; initial time
       
        % For all targets
        for i=1 : t.no_of_targets
            t_row_no = find(t.target_no(i).truth(:,1)==T);
            if ~isempty(t_row_no)
                s_row_no = find(s.sensor_no(l).truth(:,1)==T);
                x = t.target_no(i).truth(t_row_no,2)-s.sensor_no(l).truth(s_row_no,2) ;
                y = t.target_no(i).truth(t_row_no,4)-s.sensor_no(l).truth(s_row_no,4) ;
                meas = atan2(y,x) + sqrt(s.sensor_no(l).m_noise_variance)*randn ;
                temp_meas = [ temp_meas ; [ T , i , meas] ] ;
                
                eA = s.sensor_no(l).alt/sqrt(x^2 + y^2);
                elev = atan(eA) + sqrt(s.sensor_no(l).m_noise_variance)*randn;
                temp_elev = [ temp_elev ; [ T , i , elev] ] ;
                
            end
            
        end
        T = T + p.sampling_time ;
    end
    
    s.sensor_no(l).measurement = temp_meas ;
    s.sensor_no(l).elevation = temp_elev ;
end

% for i=1 : s.no_of_sensors
%     disp('--------------------------------------------');
%     disp('sensor measurement');
%     disp(s.sensor_no(i).measurement);
% end

end