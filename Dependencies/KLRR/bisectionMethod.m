function [x,fx,exitFlag] = bisectionMethod(f,lb,ub)
% BISECTION  Fast and robust root-finding method that handles n-dim arrays.
% 
%   [x,fVal,ExitFlag] = BISECTION(f,LB,UB,target,options) finds x within 
%   (LB < x < UB) such that f(x +/- TolX) = target OR f(x) = target +/- TolFun.
% 
%   x = BISECTION(f,LB,UB) finds the root(s) of function f on the interval [LB,
%   UB], i.e. finds x such that f(x) = 0 where LB <= x <= UB. f will never be
%   evaluated outside of the interval specified by LB and UB. f should have only
%   one root and f(UB) and f(LB) must bound it. Elements of x are NaN for
%   instances where a solution could not be found.
% 
%   x = BISECTION(f,LB,UB,target) finds x such that f(x) = target.
% 
%   x = BISECTION(f,LB,UB,target,TolX) will terminate the search when the search
%   interval is smaller than TolX (TolX must be positive).
% 
%   x = BISECTION(f,LB,UB,target,options) solves with the default parameters
%   replaced by values in the structure OPTIONS, an argument created with the
%   OPTIMSET function. Used options are TolX and TolFun. Note that OPTIMSET will
%   not allow arrays for tolerances, so set the fields of the options structure
%   manually for non-scalar TolX or TolFun.
% 
%   [x,fVal] = BISECTION(f,...) returns the value of f evaluated at x.
%
%   [x,fVal,ExitFlag] = BISECTION(...) returns an ExitFlag that describes the
%   exit condition of BISECTION. Possible values of elements of ExitFlag and the
%   corresponding exit conditions are
%
%       1   Search interval smaller than TolX.
%       2   Function value within TolFun of target.
%       3   Search interval smaller than TolX AND function value within 
%           TolFun of target.
%      -1   No solution found.
%      -2   Unbounded root (f(LB) and f(UB) do not span target).
% 
%   Any or all of f(scalar), f(array), LB, UB, target, TolX, or TolFun may be
%   scalar or n-dim arrays. All non-scalar arrays must be the same size. All
%   outputs will be this size.
% 
%   Default values are target = 0, TolX = 1e-6, and TolFun = 0.
% 
%   There is no iteration limit. This is because BISECTION (with a TolX that
%   won't introduce numerical issues) is guaranteed to converge if f is a
%   continuous function on the interval [UB, LB] and f(x)-target changes sign on
%   the interval.
% 
%   The <a href="http://en.wikipedia.org/wiki/Bisection_method">bisection method</a> is a very robust root-finding method. The absolute
%   error is halved at each step so the method converges linearly. However,
%   <a href="http://en.wikipedia.org/wiki/Brent%27s_method">Brent's method</a> (such as implemented in FZERO) can converge
%   superlinearly and is as robust. FZERO also has more features and input
%   checking, so use BISECTION in cases where FZERO would have to be implemented
%   in a loop to solve multiple cases, in which case BISECTION will be much
%   faster because of vectorization.
%
%   Define LB, UB, target, TolX, and TolFun for each specific application using
%   great care for the following reasons:
%     - There is no iteration limit, so given an unsolvable task, BISECTION may
%       remain in an unending loop.
%     - There is no initial check to make sure that f(x) - target changes sign
%       between LB and UB.
%     - Very large or very small numbers can introduce numerical issues.
%
%   Example 1: Find cube root of array 'target' without using NTHROOT and
%   compare speed to using FZERO.
%       options = optimset('TolX', 1e-9);
%       target = [(-100:.1:100)' (-1000:1:1000)'];
% 
%       tic;
%       xfz = zeros(size(target));
%       for ii = 1:numel(target)
%           xfz(ii) = fzero(@(x) x.^3-target(ii), [-20 20], options);
%       end
%       fzero_time = toc
% 
%       tic;
%       xbis = bisection(@(x) x.^3, -20, 20, target, options);
%       bisection_time = toc
% 
%       fprintf('FZERO took %0.0f times longer than BISECTION.\n',...
%                   fzero_time/bisection_time)
% 
%   Example 2: Find roots by varying the function coefficients.
%       [A, B] = meshgrid(linspace(1,2,6), linspace(4,12,10));
%       f = @(x) A.*x.^0.2 + B.*x.^0.87 - 15;
%       xstar = bisection(f,0,5)
% 
%   See also FZERO, FMINBND, OPTIMSET, FUNCTION_HANDLE.
% 
%   [x,fVal,ExitFlag] = BISECTION(f,LB,UB,target,options)

%   FEX URL: http://www.mathworks.com/matlabcentral/fileexchange/28150
%   Copyright 2010-2015 Sky Sartorius
%   Author  - Sky Sartorius
%   Contact - www.mathworks.com/matlabcentral/fileexchange/authors/101715

%% Process inputs. 
% Set default values
tolX = 1e-3;
tolFun = 0;
if nargin == 5
    if isstruct(options)
        if isfield(options,'TolX') && ~isempty(options.TolX)
            tolX = options.TolX;
        end 
        if isfield(options,'TolFun') && ~isempty(options.TolFun)
            tolFun = options.TolFun;
        end
    else
        tolX = options;
    end      
end

if (nargin < 4) || isempty(target)
    target = 0;
else
    f = @(x) f(x) - target;
end

ub_in = ub; lb_in = lb; 

%% Flip UB and LB if necessary. 
isFlipped = lb > ub;
if any(isFlipped(:))
    ub(isFlipped) = lb_in(isFlipped);
    lb(isFlipped) = ub_in(isFlipped);
    ub_in = ub; lb_in = lb;
end

%% Make sure everything is the same size for a non-scalar problem. 
fub = f(ub);
if isscalar(lb) && isscalar(ub)
    % Test if f returns multiple outputs for scalar input.
    if ~isscalar(target)
        id = ones(size(target));
        ub = ub.*id;
        fub = fub.*id;
    elseif ~isscalar(fub)
        ub = ub.*ones(size(fub));
    end
end

% Check if lb and/or ub need to be made into arrays.
if isscalar(lb) && ~isscalar(ub)    
    lb = lb.*ones(size(ub));
elseif ~isscalar(lb) && isscalar(ub)
    id = ones(size(lb));
    ub = ub.*id;
    fub = fub.*id;
end

unboundedRoot = sign(fub).*sign(f(lb)) > 0;
ub(unboundedRoot) = NaN;

%% Iterate
ubSign = sign(fub);  
while true
    x = (lb + ub) / 2;
    fx = f(x);
    outsideTolX = abs(ub - x) > tolX;
    outsideTolFun = abs(fx) > tolFun;
    stillNotDone = outsideTolX & outsideTolFun;
    if ~any(stillNotDone(:))
        break;
    end
    select = sign(fx) ~= ubSign;
    lb(select) = x(select);
    ub(~select) = x(~select);
end

%% Catch NaN elements of UB, LB, target, or other funky stuff. 
x(isnan(fx)) = NaN;
x(isnan(tolX)) = NaN;
x(isnan(tolFun)) = NaN;
fx(isnan(x)) = NaN;

%% Characterize results. 
if nargout > 1 && nnz(target(:))
    fx = fx + target;
end
if nargout > 2 
    exitFlag                                    = +~outsideTolX;
    exitFlag(~outsideTolFun)                    =  2;
    exitFlag(~outsideTolFun & ~outsideTolX)     =  3;
    exitFlag(isnan(x))                          = -1;
    exitFlag(unboundedRoot)                     = -2;
end

end