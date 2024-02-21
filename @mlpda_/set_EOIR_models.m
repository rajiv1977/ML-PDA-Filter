%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function X = set_EOIR_models(X,T,p_noise)

X.F = [ 1  T  0  0 ;
        0  1  0  0 ;
        0  0  1  T ;
        0  0  0  1 ] ;
X.Q = [0.005*T^3        0.005*T^2           0           0       ;
       0.005*T^2        0.01*T              0           0       ;
            0               0           0.005*T^3   0.005*T^2   ;
            0               0           0.005*T^2   0.01*T     ];  
X.V = [ p_noise p_noise p_noise p_noise]' ;

end

