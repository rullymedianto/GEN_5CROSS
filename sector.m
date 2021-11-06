function [sct] = sector(AB, AC, AF)

 if AB>1 && AC > meter(15000) && AC < meter(24500) && (AF == 1 || AF == 2 || AF == 3 || AF == 4 || AF == 5 || AF ==6) % Lower East (LE)
     sct = 1;
 else
    sct =0;
 end
end
 
