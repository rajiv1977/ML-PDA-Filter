%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Z, LnZ] = getZ(X,Y,s,p,t)

mlpda.batch_steps = [ ] ;
MLPDA_parameter();

x_dot = t.target_no(1).initial_state(2) ;
y_dot = t.target_no(1).initial_state(4) ;
% x_dot = 0 ;
% y_dot = 0 ;
for row = 1 : length(X)
    V = 2*pi ;
    % Pfa = V * lambda
    lambda = s.sensor_no(1).PFA/V;
    PD = s.sensor_no(1).PD ;
    for col = 1 : length(Y)
        scan_cost = [] ;
        for i=1 : mlpda.batch_steps
            cost = [] ;
            m_rows = find(s.sensor_no(1).measurement_set(:,1)==i) ;
            m_i = length(m_rows) ;
            sigma = sqrt(s.sensor_no(1).m_noise_variance) ;
            t_i= (i-1)*p.sampling_time ;
            s_row=find(s.sensor_no(1).truth(:,1)==i);
            s_x = s.sensor_no(1).truth(s_row,2) ;
            s_y = s.sensor_no(1).truth(s_row,4) ;
            for j=1:m_i
                if ~isempty(m_rows)
                    z = s.sensor_no(1).measurement_set(m_rows(j),3);
                    co_x = X(row,col)+x_dot*t_i-s_x ;
                    co_y = Y(row,col)+y_dot*t_i-s_y ;
                    cost(j) = (PD/lambda)*normpdf(z-atan2(co_y,co_x),0,sigma);
                end
            end
            scan_cost(i) = (1-PD) + sum(cost);
        end % end of for i=1 : mlpda.batch_steps
        temp_ML = 1 ;
        for k=1 : length(scan_cost)
            temp_ML = temp_ML*scan_cost(k) ;
        end
        Z(row,col) = temp_ML ;
        temp_lnZ = 0 ;
        for k=1:length(scan_cost)
            temp_lnZ = temp_lnZ + log(scan_cost(k));
        end
        LnZ(row,col)= temp_lnZ ;
    end
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% BACKUP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function [Z] = getZ(X,Y,s,p,t) 
% 
% mlpda.batch_steps = [ ] ;
% MLPDA_parameter();
% 
% Z = [] ;
% x_dot = t.target_no(1).initial_state(2) ;
% y_dot = t.target_no(1).initial_state(4) ;
% % x_dot = 0 ;
% % y_dot = 0 ;
% for row = 1 : length(X)
%     for col = 1 : length(X)
%         for i=1 : mlpda.batch_steps
%             m_rows = find(s.sensor_no(1).measurement_set(:,1)==i) ;
%             m_i = length(m_rows) ;
%             V = 2*pi ;
%             %lambda = (2*pi)/0.001*s.sensor_no(1).PFA ;
%             lambda = s.sensor_no(1).PFA/(2*pi);
%             PD = s.sensor_no(1).PD ;
%             cons_1 = (1-PD)*((lambda*V)^(m_i))*exp(-lambda*V)/factorial(m_i);
%             cons_2 = PD*((lambda*V)^(m_i-1))*exp(-lambda*V)/factorial(m_i-1);
%             e_m_i = cons_1/(cons_1+cons_2);
%             sigma = sqrt(s.sensor_no(1).m_noise_variance) ;
%             t_i= (i-1)*p.sampling_time ;
%             s_row=find(s.sensor_no(1).truth(:,1)==i);
%             s_x = s.sensor_no(1).truth(s_row,2) ;
%             s_y = s.sensor_no(1).truth(s_row,4) ;
%             cost(1) = e_m_i ;
%             for j=1:m_i
%                 z = s.sensor_no(1).measurement_set(m_rows(j),3);
%                 co_x = X(row,col)+x_dot*t_i-s_x ;
%                 co_y = Y(row,col)+y_dot*t_i-s_y ;
%                 cost(j+1) = (1-e_m_i)/m_i*normpdf(z-atan2(co_y,co_x),0,sigma);
%             end
%             scan_cost(i) = sum(cost);
%         end % end of for i=1 : mlpda.batch_steps
%         % get ML
%         temp_ML = 1 ;
%         for k=1:length(scan_cost)
%             temp_ML = temp_ML*scan_cost(k);
%         end
%         Z(row,col) = temp_ML;
%     end
% end
% end