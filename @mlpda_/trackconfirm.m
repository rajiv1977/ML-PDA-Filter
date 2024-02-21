function Track = trackconfirm(p,t,s,x,current_time)

Track(1).x(1) = x(1); 
Track(1).x(2) = x(2);
Track(1).x(3) = x(3);
Track(1).x(4) = x(4);

for i=2:1:t.target_no(1).leg(1).duration
    
    Track(i).x(1) = Track(1).x(1)+(Track(1).x(2)*i); 
    Track(i).x(2) = Track(1).x(2);
    Track(i).x(3) = Track(1).x(3)+(Track(1).x(4)*i);
    Track(i).x(4) = Track(1).x(4);
    
end

end