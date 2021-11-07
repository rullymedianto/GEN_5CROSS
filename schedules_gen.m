tic
% clear all
% close all
load('NavData_5cross.mat')
load('NavAIP_5cross.mat')
load('Label_5cross.mat')

time= 3600; %
temp1=5;
lat_RADAR = -25118.4; %Koordinat X RADAR
lon_RADAR = -71138.2; %Koordinat Y RADAR
Vw = 5;   % Besar kecepatan angin
tetaw = 210; %sudut arah angin (dari)

separation_length = nm(12);                      %%Manual Input
%Separation_Angle = [270 335 28 432 393 494 250 250 250 250 250 250 250 250 250 250 250]; 
a = 1;                                          %For Platform Looping NavAIP
b = 1; 

Time_Trigger = cell(1,time);
Holding_status = cell(1,time);
Sim2 = cell(1,time);

sa1=jadwal(time);
sa2=jadwal(time);
sa3=jadwal(time);
sa4 = jadwal(time);
sa5 = jadwal(time);

[m1,n1]= size(sa1);
[m2,n2]= size(sa2);
[m3,n3]= size(sa3);
[m4,n4]= size(sa4);
[m5,n5]= size(sa5);

airplane_input = [n1 n2 n3 n4 n5];

airplane = sum(airplane_input);

Jumlah_AC = airplane
sched=zeros(time,airplane);
ruteno=zeros(1,airplane);
typeac = zeros(1,airplane);
InitialPos = zeros(3,airplane);
InitialROW = zeros(2,airplane);


%% Number of Entry Point
for i = 1:temp1
NavAIP{2,i}(1,1) = airplane_input(1,i);
end
Route = cell(1,airplane);

for h=1:temp1
    if h==1 
    takum(1,h)= airplane_input(1,h);
    else
        takum(1,h)= takum(1,h-1)+ airplane_input(1,h);
    end
end

for i = 1:time
    for k = 1:n1
    if i == sa1(1,k)
        sched(i,k) = 1;
        % sched(i,takum(1,1)+k) = 1;
    end
    ruteno(1,k) = 1;
    typeac(1,k)= aircraft_type();
    end
end

for i = 1:time
    for k = 1:n2
    if i == sa2(1,k)
        sched(i,takum(1,1)+k) = 1;
    end
    ruteno(1,takum(1,1)+k) = 2;
    typeac(1,takum(1,1)+k)= aircraft_type();
    end
end
        
for i = 1:time
    for k = 1:n3
    if i == sa3(1,k)
        sched(i,takum(1,2)+k) = 1;
    end
    ruteno(1,takum(1,2)+k) = 3;
    typeac(1,takum(1,2)+k)= aircraft_type();
    end
end

for i = 1:time
    for k = 1:n4
    if i == sa4(1,k)
        sched(i,takum(1,3)+k) = 1;
    end
    ruteno(1,takum(1,3)+k) = 4;
    typeac(1,takum(1,3)+k)= aircraft_type();
    end
end

for i = 1:time
    for k = 1:n5
    if i == sa5(1,k)
        sched(i,takum(1,4)+k) = 1;
    end
    ruteno(1,takum(1,4)+k) = 5;
    typeac(1,takum(1,4)+k)= aircraft_type();
    end
end

% %% Airplane Route
for i = 1:airplane
    
    c = NumberWaypoint(NavAIP{1,a}(:,1)); % Check Number of Row
    
    for j = 1:c
        m = typeac(1,i);
        
        Route{1,i}(j,1) = NavData(NavAIP{1,a}(j,1),1);      % X
        Route{1,i}(j,2) = NavData(NavAIP{1,a}(j,1),2);      % Y
        Route{1,i}(j,3) = NavData(NavAIP{1,a}(j,1),2+m);    % Z(Altitude) 
        Route{1,i}(j,4) = NavData(NavAIP{1,a}(j,1),7+m);    % Lateral Speed 
        Route{1,i}(j,5) = NavData(NavAIP{1,a}(j,1),12+m);   % Vertical Speed
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        if b == NavAIP{2,a}(1,1)
                            a = a+1;
                            b = 1;
                        elseif a+1>temp1
                            a = temp1;
                            b = b+1;
                        else
                            a = a;
                            b = b + 1;
                        end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                    
end

    InitialPos(1,1) = Route{1,1}(1,1);%+ (separation_length + (nm(30)-separation_length)*rand(1,1))*sind(Separation_Angle(1,1)); %X    
    InitialPos(2,1) = Route{1,1}(1,2);%+ (separation_length + (nm(30)-separation_length)*rand(1,1))*cosd(Separation_Angle(1,1)); %Y
    InitialPos(3,1) = Route{1,1}(1,3); %Altitude;
    
    for i=2:n1
    InitialPos(1,i) = InitialPos(1,i-1);%+ (separation_length + (nm(30)-separation_length)*rand(1,1))*sind(Separation_Angle(1,1)); %X    
    InitialPos(2,i) = InitialPos(2,i-1);%+ (separation_length + (nm(30)-separation_length)*rand(1,1))*cosd(Separation_Angle(1,1)); %Y
    InitialPos(3,i) = InitialPos(3,i-1); %Altitude;
    end
    
    for k=1:(temp1-1)
        
    InitialPos(1,takum(1,k)+1) = Route{1,takum(1,k)+1}(1,1);%+ (separation_length + (nm(2)-separation_length)*rand(1,1))*sind(Separation_Angle(1,k+1)); %X
    InitialPos(2,takum(1,k)+1) = Route{1,takum(1,k)+1}(1,2);%+ (separation_length + (nm(2)-separation_length)*rand(1,1))*cosd(Separation_Angle(1,k+1)); %Y
    InitialPos(3,takum(1,k)+1) = Route{1,takum(1,k)+1}(1,3); %Altitude;
    
    for i=2:airplane_input(1,k+1)
    
    InitialPos(1,takum(1,k)+i) = InitialPos(1,takum(1,k)+i-1);%+ (separation_length + (nm(2)-separation_length)*rand(1,1))*sind(Separation_Angle(1,k+1)); %X    
    InitialPos(2,takum(1,k)+i) = InitialPos(2,takum(1,k)+i-1);%+ (separation_length + (nm(2)-separation_length)*rand(1,1))*cosd(Separation_Angle(1,k+1)); %Y
    InitialPos(3,takum(1,k)+i) = InitialPos(3,takum(1,k)+i-1); %Altitude;
    end
    end
    
       %% Initial ROW
a = 1;
b = 1;
for i=1:airplane
    
    InitialROW(1,i) = i;
    InitialROW(2,i) = b;

    
                        if b == NavAIP{2,a}(1,1)
                            a = a+1;
                            b = 1;
                        elseif a+1>temp1
                            a = temp1;
                            b = b+1;
                        else
                            a = a;
                            b = b + 1;
                        end
    
end
    
%% Aircraft Data t = 0
a = 1;
b = 1;

for i = 1:airplane
Time_Trigger{1,1}(1,i) = 0;
Holding_status{1,1}(1,i) = 0;

 Sim1{1,1}(1,i) = 1 ; 

if sched(1,i)==1
                                    %Num Waypoint = [1 2 3 4 5 ....]
   
    Sim1{1,1}(2,i) = InitialPos(1,i);                    %X
    Sim1{1,1}(3,i) = InitialPos(2,i);                    %Y
    Sim1{1,1}(4,i) = InitialPos(3,i);                    %Z

else
    Sim1{1,1}(2,i) = 9.0e+7;                    %X
    Sim1{1,1}(3,i) = 9.0e+7;                    %Y
    Sim1{1,1}(4,i) = 9.0e+7;                    %Z
end
    
    
    Sim1{1,1}(5,i) = Route{1,i}(1,1) - Sim1{1,1}(2,i);    %Delta X
    Sim1{1,1}(6,i) = Route{1,i}(1,2) - Sim1{1,1}(3,i);    %Delta Y
    Sim1{1,1}(7,i) = Route{1,i}(1,3) - Sim1{1,1}(4,i);    %Delta Z

    Sim1{1,1}(8,i) = InitialROW(2,i);                    %ROW
    Sim1{1,1}(9,i) = 1;                                  %Clearance
    Sim1{1,1}(10,i) = 0;                                 %Resolution

    Sim1{1,1}(11,i) = angle(Sim1{1,1}(5,i),Sim1{1,1}(6,i)); %Relative Heading
    Sim1{1,1}(12,i) = Sim1{1,1}(11,i);                     %Heading

    Sim1{1,1}(13,i) = sqrt((Sim1{1,1}(5,i))^2+(Sim1{1,1}(6,i))^2+(Sim1{1,1}(7,i))^2);      %r

    Sim1{1,1}(14,i) = 0;                                              %vz
    Sim1{1,1}(15,i) = Route{1,i}(1,4) * sind(Sim1{1,1}(12,i));        %vx
    Sim1{1,1}(16,i) = Route{1,i}(1,4) * cosd(Sim1{1,1}(12,i));        %vy
    Sim1{1,1}(17,i) = NumberWaypoint(Route{1,i});                     %Total Waypoint
    Sim1{1,1}(18,i) = 0   ;                                           %Aircraft to merging point
    Sim1{1,1}(19,i) = sqrt((Sim1{1,1}(15,i)).^2 + (Sim1{1,1}(16,i)).^2 +(Sim1{1,1}(14,i)).^2) ;  %TAS
    Sim1{1,1}(20,i) = 0;
    Sim1{1,1}(21,i) = Sim1{1,1}(15,i)+ Vw*sind(tetaw+180); %Ground Speed Sumbu x
    Sim1{1,1}(22,i) = Sim1{1,1}(16,i)+ Vw*cosd(tetaw+180); %Ground Speed Sumbu y
    Sim1{1,1}(23,i) = round(sqrt((Sim1{1,1}(21,i))^2 + (Sim1{1,1}(22,i))^2 +(Sim1{1,1}(14,i))^2)); % Ground Speed
    Sim1{1,1}(24,i) = 0;
    
    
    for j= 1:time+1
    Sim2{1,j}(1,i) = ruteno(1,i); %Ruote No.
    Sim2{1,j}(2,i) = typeac(1,i); %Aircraft Type
    end
    
    Sim1{1,1}(25,i) = holding_point(Sim1{1,1}(1,i),Sim2{1,1}(1,i)); %Holding point
    Sim1{1,1}(26,i) = sqrt((lon_RADAR-Sim1{1,1}(2,i))^2 + (lat_RADAR - Sim1{1,1}(3,i))^2); %Radius to RADAR
    Sim1{1,1}(27,i) = Sim2{1,1}(1,i); %Route No.
    Sim1{1,1}(28,i) = Sim2{1,1}(2,i); %Aircraft Type
    Sim1{1,1}(29,i) = 0; % Sector Number
    Sim1{1,1}(30,i) = 0; % Status Conflict
    Sim1{1,1}(31,i) = 0; % Status Crossing Conflict
    
                        if b == NavAIP{2,a}(1,1)
                            a = a+1;
                            b = 1;
                        elseif a+1>temp1
                            a = temp1;
                            b = b+1;
                        else
                            a = a;
                            b = b + 1;
                        end
end

save('PlaneGenerator.mat', 'Route','InitialPos','Sim1','sched','Time_Trigger','label','Holding_status','InitialROW','airplane_input',  '-v7.3')
% save('Route.mat', 'Route', '-v7.3')

de = rand();
timeElapsed_schedules1 = toc;
Te = timeElapsed_schedules1;