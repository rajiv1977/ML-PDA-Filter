%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [temp_truth, temp] = generate_CV_freq_truth(temp_truth, temp, X , sample_T )

t = temp_truth(end,1);

% For all time steps
for j=1 : X.duration
    t = t+sample_T ;
    temp = X.F*temp + X.Q*diag(sqrt(X.V)*randn(1,3));
    temp_truth = [ temp_truth ; [ t , temp'] ] ;
end

end