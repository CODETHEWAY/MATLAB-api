function [response] = fig2plotly(varargin)
% fig2plotly - plots a matlab figure object with PLOTLY
%   [response] = fig2plotly()
%   [response] = fig2plotly(gcf)
%   [response] = fig2plotly(f)
%   [response] = fig2plotly(gcf, plot_name)
%   [response] = fig2plotly(f, plot_name)
%       gcf - root figure object in the form of a double.
%       f - root figure object in the form of a struct. Use f = get(gcf); to
%           get the current figure struct.
%       plot_name - a string naming the plot
%       response - a struct containing the result info of the plot
% 
% For full documentation and examples, see https://plot.ly/api

%default input
f = get(gcf);
plot_name = 'untitled';

switch numel(varargin)
    case 0
    case 1
        if isa(varargin{1}, 'double')
            f = get(varargin{1});
        end
        if isa(varargin{1}, 'struct')
            f = varargin{1};
        end
        plot_name = 'untitled';
    case 2
        if isa(varargin{1}, 'double')
            f = get(varargin{1});
        end
        if isa(varargin{1}, 'struct')
            f = varargin{1};
        end
        plot_name = varargin{2};
    otherwise
        error('Too many arguments!')
end 
        

%convert figure into data and layout data structures
[data, layout, title] = convertFigure(f);

if numel(title)>0
    plot_name = title;
end

% send graph request
response = plotly(data, struct('layout', layout, ...
    'filename',plot_name, ...
	'fileopt', 'overwrite'));

display('Done! Check out your plot at:')
display(response.url)

end