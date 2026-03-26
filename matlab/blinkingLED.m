% ENSC192 - Spring 2022 - Blinking LED Control
% Description:
    % Demonstration of configuration and control of a digital output pin
    % New commands: 
    % - configurePin()
    % - writeDigitalPin()
    % - pause(), 
    
%-------------BEGIN CODE------------
% Program Setup - clear Command Window and Workspace
    clc;clear;
    
% Add Arduino Connection and Libraries
% MUST be modified to match serial communcation port used
% UPDATE 'com15' as needed in studio
    a = arduino('com4','Uno');

% Internal LED digital pin 13 configuration
    ledPin = 'D13'; % variable used to assign specific digital pin
    configurePin(a,ledPin,'DigitalOutput'); % sets up assigned pin as an output
    
% Blink LED 3 times
    fprintf("Blink 1...\n");
    delaytime = 3.5; % assigns delay use for on/off time
    writeDigitalPin(a,ledPin,1); % ON, a '1' value indicates output is HIGH
    pause(delaytime); % inserts a delay keeping LED ON until next command
    writeDigitalPin(a,ledPin,0); % OFF, a '0' value indicates output is LOW
    pause(delaytime); % inserts a delay keeping LED OFF until next command
    fprintf("Blink 2...\n");
    writeDigitalPin(a,ledPin,1); % ON
    pause(delaytime);
    writeDigitalPin(a,ledPin,0); % OFF
    pause(delaytime);
    fprintf("Blink 3...\n");
    writeDigitalPin(a,ledPin,1); % ON
    pause(delaytime);
    writeDigitalPin(a,ledPin,0); % OFF
    
    fprintf("Done Blinking...\n");

% Close Arduino Connection
    pause(5); % wait to close connection
    clear a; % good practice to end connection

%-------------END CODE------------
