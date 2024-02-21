%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     SML-PDA Filter                                        %
%                   Copyright @2014_mcmaster, version 01_02242014                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S.Rajiv,  and T.Kirubarajan                                 %
%           ECE Dept., McMaster University, Hamilton, Ontario, L8S 4K1, Canada.             %
%                         sithirr@mcmaster.ca and kiruba@mcmaster.ca                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_meas(s)

pp = s.sensor_no(1).measurement_set;
[r,c] = find(pp(:,2)==2);
pp(r,:) = [];
[r1,c1] = find(pp(:,2)==1);
ppp = pp(r1,:);
pp(r1,:)=[];
figure(1);
plot(pp(:,1),pp(:,3),'r.','LineWidth',2,'MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',10)
hold on
plot(ppp(:,1),ppp(:,3),'bo','LineWidth',2,'MarkerEdgeColor','b','MarkerSize',2)
hold off
legend('False alarm generated measurement','Target generated measurement');
xlabel('Time index (sec)');
ylabel('Bearing (rad)');

cc = s.sensor_no(1).measurement_amp_set;
ccc = cc;
[r,c] = find(cc(:,2)==1);
cc(r,:) = [];
[r1,c1] = find(ccc(:,2)==0);
ccc(r1,:)=[];

figure(2);
plot(cc(:,1),cc(:,3),'r.','LineWidth',2,'MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',10)
hold on
plot(ccc(:,1),ccc(:,3),'bo','LineWidth',2,'MarkerEdgeColor','b','MarkerSize',2)
hold off
legend('False alarm','Target originated');
xlabel('Time (sec)');
ylabel('Amplitude');


pp = s.sensor_no(1).elevation_set;
[r,c] = find(pp(:,2)==2);
pp(r,:) = [];
[r1,c1] = find(pp(:,2)==1);
ppp = pp(r1,:);
pp(r1,:)=[];
figure(3);
plot(pp(:,1),pp(:,3),'r.','LineWidth',2,'MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',10)
hold on
plot(ppp(:,1),ppp(:,3),'bo','LineWidth',2,'MarkerEdgeColor','b','MarkerSize',2)
hold off
legend('False alarm generated measurement','Target generated measurement');
xlabel('Time index (sec)');
ylabel('Elevation (rad)');

% ee = s.sensor_no(1).measurement_freq_set;
% eee = ee;
% [r,c] = find(ee(:,2)==1);
% ee(r,:) = [];
% [r1,c1] = find(eee(:,2)==0);
% eee(r1,:)=[];
% 
% figure(3);
% plot(ee(:,1),ee(:,3),'r.','LineWidth',2,'MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',10)
% hold on
% plot(eee(:,1),eee(:,3),'bo','LineWidth',2,'MarkerEdgeColor','b','MarkerSize',2)
% hold off
% legend('False alarm','Target originated');
% xlabel('Time (sec)');
% ylabel('Frequency');

end