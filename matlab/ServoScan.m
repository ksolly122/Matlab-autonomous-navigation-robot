function [target, targetAngle, degreeTarget] = ServoScan(robotName, usTriggerPin)

% System reset
clc; clear;
clear myDroid; % Use a consistent name for this device throughout the code.
% add clear myDroid at the end of code
myDroid = arduino('COM6','Uno','Libraries',{'Ultrasonic','Servo', 'I2C'}); % adds libraries to support other devices

% Configure pins for ultrasonic sensor
    usEchoPin = 'A1'; % pin connected to ultrasonic echo
        configurePin(myDroid,usEchoPin,'Ultrasonic'); % Ultrasonic echo
    usTriggerPin = 'A0'; % pin connected to ultrasonic trigger
        configurePin(myDroid,usTriggerPin,'Ultrasonic'); % Ultrasonic trigger   
    
% Assign Ultrasonic sensor to Arduino pins for trigger and echo
%   - Output format switched to double to simplify calculations and display
    frontUSsensor = ultrasonic(myDroid,usTriggerPin,usEchoPin,'OutputFormat','double' );
% Assign and configure pins for servo control
frontServoPin = 'D10';
configurePin(myDroid, frontServoPin, 'Servo')

% Set Servo Characteristics - Pulse Duration Values - servo dependent.
rotMinPulse = 500* 10^-6; % minimum pulse width
rotMaxPulse = 2400* 10^-6; % maximum pulse width
    
% Servo Object Setup: Servo pins and pulse characteristics assigned to device
frontScanServo = servo(myDroid, frontServoPin, 'MinPulseDuration', rotMinPulse,...
    'MaxPulseDuration', rotMaxPulse);
% Control Example 
    % Set to Center and reattach head
    centerValue = 0.5;
    writePosition(frontScanServo, centerValue)
    startPosition = readPosition(frontScanServo)
% Capture user input for desired postion 
   desiredPosition = -90;
   
    % Convert angle to 0-1
   desiredPosition = round(-1/180 * desiredPosition + centerValue,3);
    % Send 1st position,
    writePosition(frontScanServo, desiredPosition)

    % Check position, show on screen
    checkPosition = readPosition(frontScanServo);
    % Return to center
    pause(1)


% Turn and scan
distArray = zeros(1,181);
angleArray = zeros(1,181);
degArray = zeros(1,181);
for i = -90:90
    j = round(-1/180 * i + centerValue,3);
    writePosition(frontScanServo, j)
    distance = readDistance(frontUSsensor);
    p = i + 91; % Sets start of array values (can't be a negative num/0)
    distArray(p) = distance;
    angleArray(p) = j;
    degArray(p) = i + 90;
    %fprintf('\nCurrent distance is %0.3f m, %0.1f cm or %0.1f inches.\n',distance,distance*100,distance*39.37);
    pause(0.0015)
end
writePosition(frontScanServo, centerValue)
disp(distArray)
disp(angleArray)

target = min(distArray)
[x,y] = find(distArray == target)
targetAngle = angleArray(x,y)
writePosition(frontScanServo, targetAngle)
degreeTarget = degArray(x,y)

subplot(1,2,2)
polarscatter(deg2rad(degArray(1,:)), distArray(1,:),'LineWidth',0.5)
title('Polar Scan Plot (angles required)')


end