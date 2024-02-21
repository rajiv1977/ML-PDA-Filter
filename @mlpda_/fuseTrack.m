function tracks = fuseTrack(s,flag)

for j=1:1:length(flag(1).tracks(:))
    tracks(j).x(1)=0;
    tracks(j).x(2)=0;
    tracks(j).x(3)=0;
    tracks(j).x(4)=0;
for i=1:1:s.no_of_sensors
    tracks(j).x(1) = tracks(j).x(1) + flag(i).tracks(j).x(1);
    tracks(j).x(2) = tracks(j).x(2) + flag(i).tracks(j).x(2);
    tracks(j).x(3) = tracks(j).x(3) + flag(i).tracks(j).x(3);
    tracks(j).x(4) = tracks(j).x(4) + flag(i).tracks(j).x(4);
end

    tracks(j).x(1)=tracks(j).x(1)/s.no_of_sensors;
    tracks(j).x(2)=tracks(j).x(2)/s.no_of_sensors;
    tracks(j).x(3)=tracks(j).x(3)/s.no_of_sensors;
    tracks(j).x(4)=tracks(j).x(4)/s.no_of_sensors;
    
end

end