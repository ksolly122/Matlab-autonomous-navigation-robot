clc; clear;
clear myUno; % Use a consistent name for this device throughout the code.
% add clear myUno at the end of code
myUno = arduino('COM6','Uno','Libraries',{'Ultrasonic','Servo'}); % adds libraries to support other devices

% Buzzer Code
buzzpin = 'D11';
buzzFreq = 1000;
buzzDuration = 1;
configurePin(myUno, buzzpin, 'DigitalOutput');



for i = 1:10
    while buzzFreq < 6000
        playTone(myUno, buzzpin, buzzFreq, buzzDuration);
        pause(0.05);
        buzzFreq = buzzFreq + 600;
    end

    while buzzFreq > 1000
        playTone(myUno, buzzpin, buzzFreq, buzzDuration);
        pause(0.05);
        buzzFreq = buzzFreq - 600;
    end
end