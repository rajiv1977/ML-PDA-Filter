%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function X = set_CT_freq_models(X, T, p_noise, w, w_noise)

X.F = [ 1  sin(w*T)/w     0     (cos(w*T)-1)/w     0    0;
        0  cos(w*T)       0     -sin(w*T)          0    0;
        0 (1-cos(w*T))/w  1     sin(w*T)/w         0    0;
        0  sin(w*T)       0     cos(w*T)           0    0;
        0  0              0     0                  1    0;
        0  0              0     0                  0    1] ;
X.Q = [ T^2/2 0     0   0;
        T     0     0   0;
        0     T^2/2 0   0;
        0     T     0   0;
        0     0     T   0;
        0     0     0   1] ;
X.V = [ p_noise p_noise w_noise p_noise]' ;

end

