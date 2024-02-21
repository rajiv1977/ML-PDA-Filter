t_d = 1:1:1601;

size(t_d)


figure(8)

m1 = load('ospa1');
m2 = load('ospa2');
m3 = load('ospa3');


plot(t_d,m1.OsA,'--r','LineWidth',1,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','r',...
    'MarkerSize',1);
% hold on
% plot(t_d,m2.OsA,'--g','LineWidth',1,...
%     'MarkerEdgeColor','g',...
%     'MarkerFaceColor','g',...
%     'MarkerSize',1);
% hold on;
% plot(t_d,m3.OsA,'--b','LineWidth',1,...
%     'MarkerEdgeColor','b',...
%     'MarkerFaceColor','b',...
%     'MarkerSize',1);
% legend('EO Wide Sensor','EO Wide and Narrow Sensors','Two platform with EO Wide and Narrow Sensors');
legend('EO Wide Sensor');
xlabel('Time (sec)');
ylabel('OSPA (km)');

