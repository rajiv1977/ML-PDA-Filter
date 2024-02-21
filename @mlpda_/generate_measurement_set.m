%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p,t,s] = generate_measurement_set(p,t,s)

% For all sensors
for l=1 : s.no_of_sensors
    temp = [] ;
    elev = [];
    amp = [];
    freq = [];
    % For all time steps
    T = s.sensor_no(l).truth(1,1) ;
    for j = 1 : length(s.sensor_no(l).measurement(:,1))
        % For all targets
        rows = find(s.sensor_no(l).measurement(:,1)== T );
        if ~isempty(rows)
            for r=1 : length(rows)
                if s.sensor_no(l).PD >= rand
                    temp = [ temp ; s.sensor_no(l).measurement(rows(r),:) ] ;
                    
                    elev = [ elev ; s.sensor_no(l).elevation(rows(r),:) ] ;
                    
                    dd = 10^(s.sensor_no(l).SNR/20);
                    %dd
                    amp = [amp; [T, 1, random('rayleigh',dd)]];
                                 
                    Vx = t.target_no(1).truth(rows(r),3)-s.sensor_no(l).truth(rows(r),3) ;
                    Vy = t.target_no(1).truth(rows(r),5)-s.sensor_no(l).truth(rows(r),5) ;            
%                     nf_freq = t.target_no(1).initial_state(5) *(1 - (((Vx*sin(s.sensor_no(l).measurement(rows(r),3)))+ (Vy*cos(s.sensor_no(l).measurement(rows(r),3))))/p.c)/100 ) + sqrt(s.sensor_no(l).freq_noise_variance)*randn ;
%                     freq = [freq; [T, 1, nf_freq]]; 
                    
                end
            end
        end
        % Generate and add false alarms
        for k=1 : get_no_of_FA()
            
            f_bea = s.sensor_no(l).bearing_range(1) + ( s.sensor_no(l).bearing_range(2)-s.sensor_no(l).bearing_range(1) )*rand ;
            temp = [ temp ; [ T , 0 , f_bea ] ] ;
            
            f_elv = s.sensor_no(l).elevation_range(1) + ( s.sensor_no(l).elevation_range(2)-s.sensor_no(l).elevation_range(1) )*rand ;
            elev = [ elev ; [ T , 0 , f_elv ] ] ;
            
%             f_frq = s.sensor_no(l).freq_range(1) + ( s.sensor_no(l).freq_range(2)-s.sensor_no(l).freq_range(1) )*rand ;
%             freq = [freq; [T, 0, f_frq]]; 
            
            amp = [amp; [T, 0, random('rayleigh',1)]];
        end
        T = T + p.sampling_time ;
    end % end of time step
    
    s.sensor_no(l).measurement_set          = temp ;
    s.sensor_no(l).elevation_set            = elev ;
    s.sensor_no(l).measurement_amp_set      = amp;
    s.sensor_no(l).measurement_freq_set     = freq;
    
end % end of all sensors

    function x = get_no_of_FA()
        V = 2*pi ;
        %x = randi(V*s.sensor_no(l).PFA,1,1);
        x = poissrnd(V*s.sensor_no(l).PFA);
       
       
    end % end of function get_no_of_FA

% for i=1 : s.no_of_sensors
%     disp('--------------------------------------------');
%     disp('sensor measurement set');
%     disp(s.sensor_no(i).measurement_set);
% end

end % end of function generate_measurement_set