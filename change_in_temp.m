function [dT_thermal_mass, dT_air] = change_in_temp(k_fiberglass, p_thermal_mass, c_thermal_mass, thickness_thermal_mass, thickness_fiberglass, h_indoor, h_outdoor, h_eff, T_outside, sun_angle, t)
% Function to calculate change in temperature over time
% TODO: figure out where rho thermal mass goes; combine equations somehow;
% seperate solar radiation in into a different file for angle impact
% add window resistance and c

A_thermal_mass = 5.1 * 5 * thickness_thermal_mass; % m^3
A_window = 2.6 * 5; % m^2, arbitrary window width of 5
A_wall = 5.1 * 5 + 6 * 5.1 + 3.2 * 2 * 5.1 + 3.2 * 5 + 0.4 * 5 + 0.2 * 5; % m^2

% step 0
% calculate resistances
r_thermal_mass = 1 / (h_indoor * A_thermal_mass);
r_wall_inside = 1 / (h_indoor * A_wall);
r_wall_internal = thickness_fiberglass / (k_fiberglass * A_wall);
r_wall_to_outside = 1 / (h_outdoor * A_thermal_mass);

R_total = r_thermal_mass + (1/(1/(h_eff * A_window) + (1/(h_eff * A_window)) + 1/(r_wall_inside + r_wall_internal+r_wall_to_outside)));

% step 1
% calculate Q in and Q out of everything
q = -361 * cos(pi * t / (12 * 3600)) + 224 * cos(pi * t / (6 * 3600)) + 210; % in W/m^2
Q_in_window = q * A_window;

% step 2
% calculate change in temp of thermal mass
dT_thermal_mass = (Q_in_window - (T_thermal - T_outside)/R_total) / (p_thermal_mass * c_thermal_mass);

end

