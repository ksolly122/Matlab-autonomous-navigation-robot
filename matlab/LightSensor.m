function [tHeReAlDoRE] = LightSensor(robotName, ldrPin)

% Capture user input for desired postion 
   desiredPosition = -90;
   
    % Convert angle to 0-1
   desiredPosition = round(-1/180 * desiredPosition + centerValue,3);
    % Send 1st position,
    writePosition(frontScanServo, desiredPosition)
    pause(2)

angleArray = zeros(1,181);
degArray = zeros(1,181);
lightArray = zeros(1,181);


for i = -90:90
    j = round(-1/180 * i + centerValue,3);
    writePosition(frontScanServo, j)
    ldrVolt = readVoltage(myDroid, ldrPin);
    p = i + 91; % Sets start of array values (can't be a negative num/0)
    angleArray(p) = j;
    degArray(p) = i + 90;
    lightArray(p) = ldrVolt;
  
    %fprintf('\nCurrent distance is %0.3f m, %0.1f cm or %0.1f inches.\n',distance,distance*100,distance*39.37);
    pause(0.0015)
end

dr = deg2rad(degArray(1,:));
LA = lightArray(1,:);

% subplot(1,2,2)
TF = islocalmin(LA);
polarplot(dr, LA, dr(TF), LA(TF), 'r*')
title('Polar Scan Plot (angles required)')

for i  = 1:180
    if TF(i) == 0
        lightArray(i) = 100;
    end
end

lightPoint = zeros(1,4);
turnAngle = zeros(1,4);

for i = 1:4
    lightPoint(i) = min(lightArray);
    lightTarget = min(lightArray);
    [x,y] = find(lightArray == lightTarget);
    a = x(1,1);
    b = y(1,1);
    lightArray(a,b) = 100;
    turnAngle(i) = angleArray(a,b);
end

tHeDoRe = sum(turnAngle)/4;

writePosition(frontScanServo,tHeDoRe)

tHeReAlDoRE = 180 - round(tHeDoRe * 180,1);

end