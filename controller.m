function [linvel,angvel]=controller(pose,scan,wp)
% Obstacle Avoidance
    distanceThreshold=0.6;
    data=readCartesian(scan);
    x=data(:,1);
    y=data(:,2);
    dist = sqrt(x.^2 + y.^2);
    minDist = min(dist);

% Waypoint Navigation
    ctrlr=robotics.PurePursuit;
    ctrlr.Waypoints = wp;
    ctrlr.DesiredLinearVelocity = 0.2;
    ctrlr.MaxAngularVelocity = 0.3;
    ctrlr.LookaheadDistance = 0.1;
    
    goalRadius = 0.2;
    distanceToGoal = norm([pose(1) pose(2)] - [wp(1,1) wp(1,2)]);
    controlRate=robotics.Rate(10);

% Controller
    if minDist < distanceThreshold
        linvel=0;
        angvel=0;
        fprintf('OBSTACLE!\n')
    elseif(distanceToGoal>goalRadius)
       [linvel,angvel] = ctrlr(pose);
       fprintf('Distance to goal: %f\n',distanceToGoal)
    else
       fprintf('Waypoint Reached!\n')
       linvel=0;
       angvel=0;
    end
end