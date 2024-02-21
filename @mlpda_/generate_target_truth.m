%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p,t,s] = generate_target_truth(p,t,s)

if(length(t.target_no(1).initial_state)~=5)

% For all targets
for i=1 : t.no_of_targets
    
    temp = t.target_no(i).initial_state ;
    temp_truth = [ t.target_no(i).start_time , temp' ] ;
    
    % For all legs
    for j=1 : t.target_no(i).no_of_legs
        
        switch t.target_no(i).leg(j).model
            
            case 'CONSTANT VELOCITY'
                [temp_truth, temp] = mlpda_.generate_CV_truth(temp_truth, temp, t.target_no(i).leg(j),p.sampling_time);
            case 'CONSTANT VELOCITY EOIR'
                [temp_truth, temp] = mlpda_.generate_CV_EOIR_truth(temp_truth, temp, t.target_no(i).leg(j),p.sampling_time);
            case 'CONSTANT TURN'
                [temp_truth, temp] = mlpda_.generate_CT_truth(temp_truth, temp, t.target_no(i).leg(j), p.sampling_time);
            case 'STATIONARY'
                disp('No target with stationary')
            otherwise
                disp('No model found');
                
        end % end of switch
        
    end
    
    t.target_no(i).truth = temp_truth ;
end

else
 
    % For all targets
for i=1 : t.no_of_targets
    
    temp = t.target_no(i).initial_state ;
    temp_truth = [ t.target_no(i).start_time , temp' ] ;
    
    % For all legs
    for j=1 : t.target_no(i).no_of_legs
        
        switch t.target_no(i).leg(j).model
            
            case 'CONSTANT VELOCITY'
                [temp_truth, temp] = mlpda_.generate_CV_freq_truth(temp_truth, temp, t.target_no(i).leg(j),p.sampling_time);
            case 'CONSTANT TURN'
                [temp_truth, temp] = mlpda_.generate_CT_freq_truth(temp_truth, temp, t.target_no(i).leg(j), p.sampling_time);
            case 'STATIONARY'
                disp('No target with stationary')
            otherwise
                disp('No model found');
                
        end % end of switch
        
    end
    
    t.target_no(i).truth = temp_truth ;
end
    
    
end

% for i=1 : t.no_of_targets
%     disp('--------------------------------------------');
%     disp('target truth');
%     disp(t.target_no(i).truth);
% end

end