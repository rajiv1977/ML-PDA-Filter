%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,fval,exitflag,output] = mlpda_main(p,s,target,mlpda,current_time, sNo)

options = optimset('fmincon');
options = optimset(options,'MaxFunEvals',mlpda.MaxFunEvals,'TolFun',mlpda.TolFun, 'TolX', mlpda.TolX , 'TolCon',mlpda.TolCon, 'GradObj','on');

% init_x = p.servival_region(1,1) ;
% sucess = 0 ;
% for x_r_no=1 : round((p.servival_region(1,2)-p.servival_region(1,1))/mlpda.intial_grid_length)
%     inti_y = p.servival_region(2,1) ;
%     for y_r_no=1 : round((p.servival_region(2,2)-p.servival_region(2,1))/mlpda.intial_grid_length)
%         x_LB = [init_x;-mlpda.v_max;inti_y;-mlpda.v_max] ;
%         x_UB = [init_x+mlpda.intial_grid_length;mlpda.v_max;inti_y+mlpda.intial_grid_length;mlpda.v_max] ;
%         x_0 = (x_LB + x_UB) / 2 ;
%         [state,fun_value,flag,out_put] = fmincon(@likelihood_ML,x_0,[],[],[],[],x_LB,x_UB,[],options) ;
%         %if flag ~= 0
%             if sucess == 0
%                 sucess = 1 ;
%                 temp_x = state
%                 temp_fval = fun_value ;
%                 temp_flag = flag ;
%                 temp_out = out_put ;
%                 x_LB_region = x_LB ;
%                 x_UB_region = x_UB ;
%             elseif fun_value < temp_fval
%                 temp_x = state ;
%                 temp_fval = fun_value ;
%                 temp_flag = flag ;
%                 temp_out = out_put ;
%                 x_LB_region = x_LB ;
%                 x_UB_region = x_UB ;
%             end
%         %end
%         inti_y = inti_y + mlpda.intial_grid_length ;
%      end % end of y_r_no
%     init_x = init_x + mlpda.intial_grid_length ;
% end % end of x_r_no

% x_LB_region
% x_UB_region
%
% s_region = [ x_LB_region(1) , x_UB_region(1) ; x_LB_region(3) , x_UB_region(3) ] ;
% mlpda.intial_grid_length = mlpda.grid_length
% init_x = s_region(1,1) ;
% sucess = 0 ;
% for x_r_no=1 : round((s_region(1,2)-s_region(1,1))/mlpda.intial_grid_length)
%     inti_y = s_region(2,1) ;
%     for y_r_no=1 : round((s_region(2,2)-s_region(2,1))/mlpda.intial_grid_length)
%         x_LB = [init_x;-mlpda.v_max;inti_y;-mlpda.v_max] ;
%         x_UB = [init_x+mlpda.intial_grid_length;mlpda.v_max;inti_y+mlpda.intial_grid_length;mlpda.v_max] ;
%         x_0 = (x_LB + x_UB) / 2 ;
%         [state,fun_value,flag,out_put] = fmincon(@likelihood_ML,x_0,[],[],[],[],x_LB,x_UB,[],options) ;
%         %if flag ~= 0
%             if sucess == 0
%                 sucess = 1 ;
%                 temp_x = state ;
%                 temp_fval = fun_value ;
%                 temp_flag = flag ;
%                 temp_out = out_put ;
%                 x_LB_region = x_LB ;
%                 x_UB_region = x_UB ;
%             elseif fun_value < temp_fval
%                 temp_x = state ;
%                 temp_fval = fun_value ;
%                 temp_flag = flag ;
%                 temp_out = out_put ;
%                 x_LB_region = x_LB ;
%                 x_UB_region = x_UB ;
%             end
%         %end
%         inti_y = inti_y + mlpda.intial_grid_length ;
%      end % end of y_r_no
%     init_x = init_x + mlpda.intial_grid_length ;
% end % end of x_r_no

temp_x          = zeros(4,1);
temp_fval       = 0;
temp_flag       = 0;
temp_out        = 0;

x               = temp_x;
x_hat           = x;
fval            = temp_fval;
exitflag        = temp_flag;
output          = temp_out;

%(current_time-(mlpda.batch_steps-1)*p.sampling_time))
for jj=1:mlpda.mcr
 %disp('testing in progress..')
 
if (target.target_no(1).start_time<=current_time)
    tk = target.target_no(1).start_time;
   
    %while no initial estimates
    while (length(find(x==0)) == length(x))
  
    % run fmincon again with the result/tune the values
    tar_row = find(target.target_no(1).truth(:,1)==tk);
    
    %initial point selection
    ini_loc = randi([tar_row,tar_row+5],1);
    
    %t_truth = target.target_no(1).truth(tar_row,2:5)';
    t_truth = target.target_no(1).truth(ini_loc,2:5)';
    
    likelihood_ML(t_truth);
    temp_x = target.target_no(1).truth(ini_loc,2:5)';
    XLB = t_truth-rand(4,1)*1 ;
    XUB = t_truth+rand(4,1)*1 ;
    
    [state,fun_value,flag,out_put] = fmincon(@likelihood_ML,temp_x,[],[],[],[],XLB,XUB,[],options);
    
    if fun_value < temp_fval
        temp_x = [state(1);t_truth(2);state(3);t_truth(4)] ;
        temp_fval = fun_value ;
        temp_flag = flag ;
        temp_out = out_put ;
    end
 
    x = temp_x ;
    fval = temp_fval ;
    exitflag = temp_flag ;
    output = temp_out ;
    
    tk = tk + p.sampling_time;
    end
    
end
   
   x_hat = x_hat + x; 
end
    x = [];
    x(1) = x_hat(1)/mlpda.mcr;
    x(2) = x_hat(2)/mlpda.mcr;
    x(3) = x_hat(3)/mlpda.mcr;
    x(4) = x_hat(4)/mlpda.mcr;

    function [ML, gradML] = likelihood_ML(x)
        scan_cost = [];
        scan_cost_gML = [];
        i_i = 1 ;
   
        %i=(current_time-(mlpda.batch_steps-1)*p.sampling_time): p.sampling_time : current_time
        flag = (mlpda.batch_steps*p.sampling_time)+tk;
        for i=(tk : p.sampling_time : flag)
            i ;
            cost = [];
            cost_gML = [];
            m_rows = find(s.sensor_no(sNo).measurement_set(:,1)==i) ;
            m_i = length(m_rows) ;
            V = 2*pi ;
            %lambda = (2*pi)/0.001*s.sensor_no(sNo).PFA ;
            lambda = s.sensor_no(sNo).PFA/(2*pi);
            PD = s.sensor_no(sNo).PD ;
            cons_1 = (1-PD) ;
            sigma = sqrt(s.sensor_no(sNo).m_noise_variance) ;
            sigma_f = sqrt(s.sensor_no(sNo).freq_noise_variance) ;
            
            %t_i= i-(current_time-(mlpda.batch_steps-1)*p.sampling_time) ;
            t_i = i-tk;
            s_row=find(s.sensor_no(sNo).truth(:,1)==i);
            s_x = s.sensor_no(sNo).truth(s_row,2) ;
            s_y = s.sensor_no(sNo).truth(s_row,4) ;
            co_x = x(1)+x(2)*t_i-s_x ;
            co_y = x(3)+x(4)*t_i-s_y ;
            for j = 1 : m_i
                if ~isempty(m_rows)
                    z = s.sensor_no(sNo).measurement_set(m_rows(j),3);
                    x_value = z-atan2(co_y,co_x) ;
                    %f_value = s.sensor_no(sNo).measurement_freq_set(m_rows(j),3);
                    a_value = s.sensor_no(sNo).measurement_amp_set(m_rows(j),3);
                    a_value_id = s.sensor_no(sNo).measurement_amp_set(m_rows(j),2);
                    alr_1 = (a_value/(s.sensor_no(sNo).PD*(1+s.sensor_no(sNo).SNR)))*exp((-1*a_value^2)/(2*(1+s.sensor_no(sNo).SNR)));  
                    alr_0 = (a_value/s.sensor_no(sNo).PFA)*exp((-1*a_value^2)/2);
                    %cost(j) = (PD/lambda)*normpdf(x_value,0,sigma)*normpdf(f_value,0,sigma_f)*alr_1/alr_0;
                    cost(j) = (PD/lambda)*normpdf(x_value,0,sigma)*alr_1/alr_0;
                    tan_inv_element = co_y/co_x ;
                    common = cost(j)*(1/sigma^2)*x_value*(1/(1+tan_inv_element^2));
                    cost_gML(1,j) = common*co_y*(-1/co_x^2) ;
                    cost_gML(2,j) = common*co_y*(-1/co_x^2)*t_i ;
                    cost_gML(3,j) = common*(1/co_x) ;
                    cost_gML(4,j) = common*(1/co_x)*t_i ;
                end
            end
            scan_cost(i_i) = sum(cost)+(1-PD);
            if (m_i==1)
                scan_cost_gML(:,i_i) = cost_gML/scan_cost(i_i);
            elseif (m_i==0)
                scan_cost_gML(:,i_i) = zeros(4,1) ;
            else
                scan_cost_gML(:,i_i) = sum(cost_gML')'/scan_cost(i_i);
            end
            i_i = i_i + 1 ;
        end % end of for i=1 : mlpda.batch_steps
        % get ML
        temp_ML = 0 ;
        
        for k=1:length(scan_cost)
            if (scan_cost(k)~=0)
                temp_ML = temp_ML + log(scan_cost(k));
            end
        end
        ML = -1*temp_ML;
        gradML = -1*sum(scan_cost_gML')' ;
    end % end of function ML = likelihood_ML(x)

end % end of function MLPDA_main();

