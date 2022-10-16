function dT_thermal_mass = change_in_temp(t, T)
% Function to calculate change in temperature over time
% TODO: figure out where rho thermal mass goes; combine equations somehow;
% seperate solar radiation in into a different file for angle impact
% add window resistance and c

% Constants
k_fiberglass = 0.04;              % W/m-K
p_thermal_mass = 3000;            % kg/m^3
c_thermal_mass = 800;             % J/kg-K
h_indoor = 15;                    % W/m^2-K
h_eff = 1.4;                      % W/m^2-K   
h_outdoor = 30;                   % W/m^2-K
T_outside = 270.15;               % K
sun_angle_summer = 25*(pi/180);   % Radians
sun_angle_winter = 72*(pi/180);   % Radians
thickness_thermal_mass = 0.9144;  % m (arbitrary)
thickness_fiberglass = 0.2286;    % m (arbitrary)


A_thermal_mass = 5.1 * 5 * 2 + 5.1 * thickness_thermal_mass * 2 + 5 * thickness_thermal_mass * 2; % m^2
A_window = 2.6 * 5; % m^2, arbitrary window width of 5
A_wall = 5.1 * 5 + 6 * 5.1 + 3.2 * 2 * 5.1 + 3.2 * 5 + 0.4 * 5 + 0.2 * 5; % m^2

m_thermal_mass = thickness_thermal_mass * 5.1*5 * p_thermal_mass;
% step 0
% calculate resistances
r_thermal_mass = 1 / (h_indoor * A_thermal_mass);
r_wall_inside = 1 / (h_indoor * A_wall);
r_wall_internal = thickness_fiberglass / (k_fiberglass * A_wall);
r_wall_to_outside = 1 / (h_outdoor * A_wall);
r_window_in_window = (h_indoor * A_window)^(-1);
r_window_window_out = (h_outdoor * A_window)^(-1);

R_total = r_thermal_mass + ((r_window_in_window + r_window_window_out)^(-1) + (r_wall_inside + r_wall_internal+r_wall_to_outside)^(-1))^(-1);

% step 1
% calculate Q in and Q out of everything
q = -361 * cos(pi * t / (12 * 3600)) + 224 * cos(pi * t / (6 * 3600)) + 210; % in W/m^2
Q_in_window = q * A_window;

% step 2
% calculate change in temp of thermal mass
dT_thermal_mass = (Q_in_window - (T - T_outside)/R_total) / (m_thermal_mass * c_thermal_mass);

end

