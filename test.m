% Set up the path for 2 images to see the optical flow. My Matlab version
% cannot show the whole video, so I have to compare each pair of images,
% that I save in the file v_im_carnb in the file Figures.
im1 = imread('D:\IT\USTH Toan\TU 2.2 Image Video Processing\Week 2_Marie Luong\Labwork\images\v_im_carnb1.jpg');
im2 = imread('D:\IT\USTH Toan\TU 2.2 Image Video Processing\Week 2_Marie Luong\Labwork\images\v_im_carnb2.jpg');

% I tested image 1 with other images: 3,5,10,30 to see the differences.
%im2 = imread('D:\IT\USTH Toan\TU 2.2 Image Video Processing\Week 2_Marie Luong\Labwork\images\v_im_carnb3.jpg');
%im2 = imread('D:\IT\USTH Toan\TU 2.2 Image Video Processing\Week 2_Marie Luong\Labwork\images\v_im_carnb5.jpg');
%im2 = imread('D:\IT\USTH Toan\TU 2.2 Image Video Processing\Week 2_Marie Luong\Labwork\images\v_im_carnb10.jpg');
%im2 = imread('D:\IT\USTH Toan\TU 2.2 Image Video Processing\Week 2_Marie Luong\Labwork\images\v_im_carnb30.jpg');

% Then, I test other pairs of other images, in this case, I choose
% sign1.bmp and use it with sign75.bmp, sign150, sign300.bmp
%im1 = imread('D:\IT\USTH Toan\TU 2.2 Image Video Processing\Week 2_Marie Luong\hanoi-pres\sign1.bmp')
%im2 = imread('D:\IT\USTH Toan\TU 2.2 Image Video Processing\Week 2_Marie Luong\hanoi-pres\sign75.bmp')
%im2 = imread('D:\IT\USTH Toan\TU 2.2 Image Video Processing\Week 2_Marie Luong\hanoi-pres\sign150.bmp')
%im2 = imread('D:\IT\USTH Toan\TU 2.2 Image Video Processing\Week 2_Marie Luong\hanoi-pres\sign300.bmp')


%im1 =rgb2gray(im1);
%im2 =rgb2gray(im2);

% Run my HS code with h = 1, alpha = 0.1 and N = 150
[u,v] = HS_Toan(im1,im2,1,0.1,150);
% Try another value of alpha
% [u,v] = HS_Toan(im1,im2,1,0.5,150);

threshold = 0.1;
u(abs(u)<threshold) = 0;
v(abs(v)<threshold) = 0;

[m,n] = size(u);
% Set up the number of steps
step = 5;
x = step:step:m;
y = step:step:n;
U = u(x,y);
V = v(x,y);

[X,Y] = meshgrid(x,y);
figure, quiver(Y,X,-V(end:-1:1,:)',-U(end:-1:1,:)',3);
title('Flow patterns');
