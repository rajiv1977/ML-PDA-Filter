%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [J] = get_CRLB(p,t,s)
mlpda.batch_steps = [] ;
MLPDA_parameter();
% Assign values
x_0 = t.target_no(1).initial_state ;
sigma = sqrt(s.sensor_no(1).m_noise_variance) ;
J = zeros(4,4) ;
for i=1 : mlpda.batch_steps
    t_i= (i-1)*p.sampling_time ;
    s_row=find(s.sensor_no(1).truth(:,1)==i);
    s_x = s.sensor_no(1).truth(s_row,2) ;
    s_y = s.sensor_no(1).truth(s_row,4) ;
    co_x = x_0(1)+x_0(2)*t_i-s_x ;
    co_y = x_0(3)+x_0(4)*t_i-s_y ;
    common = (1/(1+(co_y/co_x)^2));
    temp_J = [common*co_y*(-1/co_x^2);common*co_y*(-1/co_x^2)*t_i;common*(1/co_x);common*(1/co_x)*t_i] ;
    J = J + temp_J*temp_J' ;
end % end of for loop window
J = J/sigma^2 ;
%PCRLB = inv(J) ;
end % end of get_PCRLB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% BACKUP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function [PCRLB] = get_PCRLB(p,t,s)
%     mlpda.batch_steps = [] ;
%     mlpda.no_of_mes_samples = [] ;
%     MLPDA_parameter();
%     % Assign values
%     x_0 = t.target_no(1).initial_state ;
%     m_i = mlpda.no_of_mes_samples ;
%     V = 2*pi ;
%     lambda = s.sensor_no(1).PFA/(2*pi);
%     PD = s.sensor_no(1).PD ;
%     cons_1 = (1-PD)*((lambda*V)^(m_i))*exp(-lambda*V)/factorial(m_i);
%     cons_2 = PD*((lambda*V)^(m_i-1))*exp(-lambda*V)/factorial(m_i-1);
%     e_m_i = cons_1/(cons_1+cons_2);
%     sigma = sqrt(s.sensor_no(1).m_noise_variance) ;
%     J_i = [] ;
%     for i=1 : mlpda.batch_steps
%         cost = 0 ;
%         t_i= (i-1)*p.sampling_time ;
%         s_row=find(s.sensor_no(1).truth(:,1)==i);
%         s_x = s.sensor_no(1).truth(s_row,2) ;
%         s_y = s.sensor_no(1).truth(s_row,4) ;
%         co_x = x_0(1)+x_0(2)*t_i-s_x ;
%         co_y = x_0(3)+x_0(4)*t_i-s_y ;
%         tan_inv_element = co_y/co_x ;
%         temp_J = zeros(4,1) ;
%         cost = e_m_i ;
%         for j = 1 : m_i
% %             z = normcdf(rand,sigma,atan2(co_y,co_x));
%             x_value = z-atan2(co_y,co_x) ;
%             cost = cost + (1-e_m_i)/m_i*normpdf(x_value,0,sigma) ;
%             common = (1-e_m_i)/m_i*normpdf(x_value,0,sigma)*(1/sigma)*x_value*(1/(1+tan_inv_element^2));
%             temp_J = temp_J + [common*co_y*(-1/co_x^2);common*co_y*(-1/co_x^2)*t_i;common*(1/co_x);common*(1/co_x)*t_i] ;
%         end
%         J_i{i} = temp_J/cost ;
%     end % end of for loop window
%     J = J_i{1}*J_i{1}' ;
%     for i = 2 : length(J_i)
%         J = J + J_i{i}*J_i{i}' ;
%     end
%     PCRLB = inv(J) ;
% end % end of get_PCRLB