function Ps = minimalCameraPose(xs,Xs)
% Minimal solver for calibrated camera pose
% xs - calibrated, image coordinates 3x3-array
% Xs - 3D points [3x3]-array
% By Olof Enqvist 2016

if any(size(Xs)~=[3 3]) || any(size(xs)~=[ 3])
    error('Input has wrong size')
end

% Change coordinate system in the Xs.
s  = Xs(:,1);
Xs = Xs-repmat(s,1,3);

S1 = Xs(:,2)/sqrt(sum(Xs(:,2).^2));

% Gram-Schmidt
S2 = Xs(:,3) - (Xs(:,3)'*S1)*S1;
S2 = S2/sqrt(sum(S2.^2));

% Form a rotation matrix
S = [S1  S2 cross(S1,S2)];

% Transform points
Xs = S'*Xs;

% Detect zero-division
if all(isfinite(Xs(:)))
    [Rs,ts] = cleanCameraPose(xs,Xs);
    Ps = cell(1,length(Rs));
   
    % Go back to original coordinates 
    for kk = 1:length(Rs)
        Ps{kk} = [Rs{kk}*S'   -Rs{kk}*S'*s+ts{kk}];
    end
else
    Ps = cell(1,0);
end


function [Rs,ts] = cleanCameraPose(xs,Xs)
% Minimal solver for calibrated camera pose in
% with Xs(:,1)=0, Xs(3,2)=Xs(3,3)=0.

M = zeros(6,8);
M(1:3,:) = [ Xs(1,2)*eye(3)  zeros(3,3)     -xs(:,2)    zeros(3,1)];
M(4:6,:) = [ Xs(1,3)*eye(3)  Xs(2,3)*eye(3)  zeros(3,1)  -xs(:,3)  ];

b = [xs(:,1);xs(:,1)];

% Basis for solution space to M*theta = b
% Could be computed with the command null
f1 = [zeros(3,1);         xs(:,3)/Xs(2,3);                    0;  1];
f2 = [xs(:,2)/Xs(1,2);   -Xs(1,3)*xs(:,2)/(Xs(1,2)*Xs(2,3));  1;  0];
f = [f1/norm(f1) f2/norm(f2) -M\b];

vec_a = f(1:3,:);
vec_b = f(4:6,:);

% Polynomial constraints in the new c.
E1 = vec_a(1,:)'*vec_a(1,:) + vec_a(2,:)'*vec_a(2,:) + vec_a(3,:)'*vec_a(3,:) - vec_b(1,:)'*vec_b(1,:) - vec_b(2,:)'*vec_b(2,:) - vec_b(3,:)'*vec_b(3,:);
E2 = vec_a(1,:)'*vec_b(1,:) + vec_a(2,:)'*vec_b(2,:) + vec_a(3,:)'*vec_b(3,:);
E2 = E2 + E2';

[xsols,ysols] = polySolver(E1,E2);

nsols = length(xsols);
Rs = cell(1,nsols);
ts = cell(1,nsols);
for kk = 1:nsols
    theta = ysols(kk)*f(:,1) + xsols(kk)*f(:,2) + f(:,3);
    c = 1/norm(theta(1:3));
    ts{kk} = c*xs(:,1);
    Rs{kk} = c*[ theta(1:3) theta(4:6) c*cross(theta(1:3),theta(4:6))];
end


function [xsols,ysols] = polySolver(E, F)

% Two quadratic equations. Solve with resultants
a1 = E(1,1);
a2 = 2*E(1,2);
a3 = 2*E(1,3);
a4 = E(2,2);
a5 = 2*E(2,3);
a6 = E(3,3);

b2 = 2*F(1,2);
b3 = 2*F(1,3);
b4 =   F(2,2);
b5 = 2*F(2,3);
b6 =   F(3,3);

cs(1) = a1*b4^2 - a2*b2*b4 + a4*b2^2;
cs(2) = 2*a1*b4*b5 - a2*b2*b5 - a2*b3*b4 - a3*b2*b4 + 2*a4*b2*b3 + a5*b2^2;
cs(3) = 2*a1*b4*b6 + a1*b5^2 -a2*b2*b6  - a2*b3*b5  - a3*b2*b5  - a3*b3*b4  + a4*b3^2 +  2*a5*b2*b3 + a6*b2^2;
cs(4) = 2*a1*b5*b6 - a2*b3*b6 - a3*b2*b6 - a3*b3*b5 + a5*b3^2 + 2*a6*b2*b3;
cs(5) = a1*b6^2 - a3*b3*b6 + a6*b3^2;

xsols = roots(cs);

xsols = real(xsols(abs(imag(xsols))<1e-5));

% Solve for the other unknown.
ysols = -(b4*xsols.*xsols + b5*xsols + b6)./(b2*xsols+b3); 
    