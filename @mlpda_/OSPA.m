function OSPA(p,t,s,m,Track)

for i=1:1:t.target_no(1).leg(1).duration
 
        
       OsA(i) =  sqrt( (t.target_no.truth(i,2)-Track(i).x(1))^2 + (t.target_no.truth(i,4)-Track(i).x(3))^2)/m.mcr;
        
  
end

savefile = 'ospa.mat';
save(savefile, 'OsA');

size(OsA)
disp('OSPA')
sum(OsA)

t_d = 1:1:1601;

size(t_d)

figure(7)
plot(t_d,OsA,'--r','LineWidth',1,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','r',...
    'MarkerSize',1)
xlabel('Time (sec)');
ylabel('OSPA (m)');

end

