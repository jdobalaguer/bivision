
% squircle values
S(1:parameters.vb_setsize) = 2;
C = 0.5 * (1 + blockstruct.vb_x(:,i_trial));
   
% angle
theta = linspace(0,360,parameters.vb_setsize+1);
theta = theta(1:end-1);

% [x,y] coordinates
x = ptb.screen_center(1) + parameters.vb_radi * sin(theta*pi/180);
y = ptb.screen_center(2) + parameters.vb_radi * cos(theta*pi/180);
        
% graphical construction
Ht = 0:(2*pi/180):(2*pi);   % shapes are defined by parametric curves of Ht (angle)
Hr = 45*pi/180;             % the rotation of the hyperellipse
for n = 1:parameters.vb_setsize
    Ha = sqrt(abs(parameters.stim_harea./4.*gamma(1.+2./S(n))./(gamma(1.+1./S(n))).^2)); % define the parameter a from the expected area + curvature S(n)
    Hx = abs(cos(Ht)).^(2./S(n)).*Ha.*sign(cos(Ht));                     % x coordinates
    Hy = abs(sin(Ht)).^(2./S(n)).*Ha.*sign(sin(Ht));                     % y coordinates
    Hc = [C(n) 0 1-C(n)];                                                % color
    Hpoly = [Hx*cos(Hr)-Hy*sin(Hr) + x(n) ; Hx*sin(Hr)+Hy*cos(Hr) + y(n)]';
    Screen('FillPoly',ptb.screen_w,tools_RGBcor(Hc,parameters.stim_lumiIM),Hpoly,1);
end
