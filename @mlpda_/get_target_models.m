%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p,t,s] = get_target_models(p,t,s)

if(length(t.target_no(1).initial_state)~=5)
    
    for i = 1 : t.no_of_targets
        
        % For all target motion legs
        for j=1 : t.target_no(i).no_of_legs         
            switch t.target_no(i).leg(j).model
                case 'CONSTANT VELOCITY'
                    [t.target_no(i).leg(j)] = mlpda_.set_CV_models( t.target_no(i).leg(j), p.sampling_time, t.target_no(i).leg(j).p_noise_variance);
                case 'CONSTANT VELOCITY EOIR'
                    [t.target_no(i).leg(j)] = mlpda_.set_EOIR_models( t.target_no(i).leg(j), p.sampling_time, t.target_no(i).leg(j).p_noise_variance);
                case 'CONSTANT TURN'
                    [t.target_no(i).leg(j)] = mlpda_.set_CT_models( t.target_no(i).leg(j), p.sampling_time, t.target_no(i).leg(j).p_noise_variance, t.target_no(i).leg(j).angular_rate, t.target_no(i).leg(j).turn_rate_noise_variance);
                otherwise
                    disp('No model found');
                    
            end % end of switch
            
        end % end of legs
        
    end % end of all sensors
    
else
    
    for i = 1 : t.no_of_targets
        
        % For all target motion legs
        for j=1 : t.target_no(i).no_of_legs
            
            switch t.target_no(i).leg(j).model
                
                case 'CONSTANT VELOCITY'
                    [t.target_no(i).leg(j)] = mlpda_.set_CV_freq_models( t.target_no(i).leg(j), p.sampling_time, t.target_no(i).leg(j).p_noise_variance);
                case 'CONSTANT TURN'
                    [t.target_no(i).leg(j)] = mlpda_.set_CT_freq_models( t.target_no(i).leg(j), p.sampling_time, t.target_no(i).leg(j).p_noise_variance, t.target_no(i).leg(j).angular_rate, t.target_no(i).leg(j).turn_rate_noise_variance);
                otherwise
                    disp('No model found');
                    
            end % end of switch
            
        end % end of legs
        
    end % end of all sensors
    
    
end

end