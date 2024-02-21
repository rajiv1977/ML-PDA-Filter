%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [temp_truth, temp] = generate_CT_freq_truth( temp_truth , temp , X , T )

t = temp_truth(end,1) ;
temp_F = X.F ;
temp = [ temp ; X.angular_rate ] ; 
% For all time steps
for j=1 : X.duration
    t = t + T ;
    temp = temp_F*temp + X.Q*diag(sqrt(X.V)*randn(1,4)) ;
    w =  temp(5) ;
    temp_F = [  1  sin(w*T)/w     0  (cos(w*T)-1)/w 0  ;
                0  cos(w*T)       0  -sin(w*T)      0  ;
                0 (1-cos(w*T))/w  1  sin(w*T)/w     0  ;
                0  sin(w*T)       0  cos(w*T)       0  ;
                0  0              0  0              1 ] ;
    temp_truth = [ temp_truth ; [ t , temp(1:4)'] ] ;
end

temp = temp(1:5) ;

end