% Define the functions f and g using anonymous functions
% f is a rectangular pulse that is 1 between 0 and 5, and 0 elsewhere
% g is a triangular pulse that decreases from 1 to 0 between 0 and 3, and is 0 elsewhere
f = @(x) (x >= 0 & x <= 5); 
g = @(x) (1 - x/3) .* (x >= 0 & x <= 3);

% Define the range of x values and time (t) values
x_values = -10:0.1:10;     % Range of x values for evaluating f and g
t_values = -2:0.2:12;      % Range of t values for the convolution process
dx = x_values(2) - x_values(1); % Step size for x (0.1)

% Initialize an array to store the convolution result for each time shift t
convolution_result = zeros(size(t_values));

% Create a large figure window for better visualization of subplots
hFig = figure('Position', [100, 100, 800, 500]);

% Loop through each time shift (t) to compute the convolution
for t_index = 1:length(t_values)
    % Check if figure is closed; if so, exit the loop to prevent errors
    if ~isvalid(hFig)
        break;
    end

    % Define the current time shift, tau, as the current value in t_values
    tau = t_values(t_index);

    % Shift and mirror g by applying -1 to (x - tau), effectively g(t - x)
    shifted_g = g(-(x_values - tau));

    % Calculate the convolution result at the current tau by integrating f(x) * g(t - x)
    convolution_result(t_index) = trapz(x_values, f(x_values) .* shifted_g);

    % Plot the original functions f(x) and g(x) in the first subplot
    subplot(2,1,1);
    plot(x_values, f(x_values), 'b', 'LineWidth', 2); % Plot f(x) in blue
    hold on;
    plot(x_values, g(x_values), 'r', 'LineWidth', 2); % Plot g(x) in red
    title('Functions f(x) and g(x)');
    xlabel('x');
    ylabel('Amplitude');
    axis([-10 10 -0.5 1.5]); % Set axis limits for better visibility
    legend('f(x)', 'g(x)');
    hold off;

    % Plot the shifted function g(t - x) and the convolution result over time
    subplot(2,1,2);
    plot(x_values, f(x_values), 'b', 'LineWidth', 2); hold on;  % Plot f(x) in blue
    plot(x_values, shifted_g, 'r', 'LineWidth', 2);             % Plot shifted g(t - x) in red
    plot(t_values(1:t_index), convolution_result(1:t_index), 'g', 'LineWidth', 2); % Plot current convolution in green
    title(['Convolution Process: f(x) and Shifted g(t - x), t = ', num2str(tau)]);
    xlabel('x and t');
    ylabel('Amplitude');
    axis([-10 10 -0.5 2]); % Set axis limits to maintain a consistent view
    legend('f(x)', 'g(t - x)', '(f * g)(t)');
    hold off;

    %plots for a smoother animation effect
    drawnow;
    pause(0.01); % Short pause for smoother animation
end

