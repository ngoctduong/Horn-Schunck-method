% My function applied the Horn-Schunck method to show the optical flow
function [u, v] = HS_Toan(im1, im2, h, alpha, N)
% Estimate the Partial Derivatives, I chose my way, did not follow the way in section 7 on page 189 but it still works
   
    Ex = double([im1(:,2:end) im1(:,end)]-im1);
    Ey = double([im1(1,:);im1(1:end-1,:)]-im1);
    Et = double(im2-im1);

    [i,j] = size(im1);
    u = zeros(i,j);
    v = zeros(i,j); 
% Estimate the Laplacian of the Flow Velocities. In this case, I set up 4 values a1,...
% a2, a3 and a4 which are left, right, up ,down, respectively, like the 4
% directions in the cube 
    for n=1:N-1
% Define the local average u and v based on section 8 on page 190       
% Firstly, for u
        a1 = [u(:,2:end) u(:,end)];
        a2 = [u(:,1) u(:,1:end-1)];
        a3 = [u(1,:);u(1:end-1,:)];
        a4 = [u(2:end,:);u(end,:)];       
      
        delta_u = double((1/6) .* (a1 + a2 + a3 + a4) ...
                       + (1/12).* ( [a1(1,:);a1(1:end-1,:)] + [a1(2:end,:);a1(end,:)] + [a2(1,:);a2(1:end-1,:)] + [a2(2:end,:);a2(end,:)])); 
% Secondly, for v        
        a1 = [v(:,2:end) v(:,end)];
        a2 = [v(:,1) v(:,1:end-1)];
        a3 = [v(1,:);v(1:end-1,:)];
        a4 = [v(2:end,:);v(end,:)];       
        
        delta_v = double((1/6) .* (a1 + a2 + a3 + a4) ...
                       + (1/12).* ( [a1(1,:);a1(1:end-1,:)] + [a1(2:end,:);a1(end,:)] + [a2(1,:);a2(1:end-1,:)] + [a2(2:end,:);a2(end,:)]));
% Finally, find the iterative solution
        u = delta_u - Ex.*(Ex.*delta_u + Ey.*delta_v + Et)./(alpha^2 + Ex.^2 + Ey.^2);
        v = delta_v - Ey.*(Ex.*delta_u + Ey.*delta_v + Et)./(alpha^2 + Ex.^2 + Ey.^2);
   end   
end