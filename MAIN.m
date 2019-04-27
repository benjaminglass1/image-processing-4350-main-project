% Main program for the Image Processing, EENG 4350, main project.
% Code by Chad Gibbons, Benjamin Glass, and Angel Rodriguez.

% This file is mostly responsible for the display of the images that are
% calculated by other functions.

% TASK 1

im_orig = imread('MainProjImage.tif');

im_orig_red = im_orig(:,:,1);
im_orig_green = im_orig(:,:,2);
im_orig_blue = im_orig(:,:,3);

figure()
subplot(3,2,1)
imshow(im_orig_red)
title('Original red band')
subplot(3,2,2)
imhist(im_orig_red)
title('Original red histogram')
subplot(3,2,3)
imshow(im_orig_green)
title('Original green band')
subplot(3,2,4)
imhist(im_orig_green)
title('Original green histogram')
subplot(3,2,5)
imshow(im_orig_blue)
title('Original blue band')
subplot(3,2,6)
imhist(im_orig_blue)
title('Original blue histogram')

im_noisy_red = add_gaussian_noise(im_orig_red, 1000);
im_noisy_green = add_gaussian_noise(im_orig_green, 1000);
im_noisy_blue = add_gaussian_noise(im_orig_blue, 1000);

figure()
subplot(3,2,1)
imshow(im_noisy_red)
title('Noisy red band')
subplot(3,2,2)
imhist(im_noisy_red)
title('Noisy red histogram')
subplot(3,2,3)
imshow(im_noisy_green)
title('Noisy green band')
subplot(3,2,4)
imhist(im_noisy_green)
title('Noisy green histogram')
subplot(3,2,5)
imshow(im_noisy_blue)
title('Noisy blue band')
subplot(3,2,6)
imhist(im_noisy_blue)
title('Noisy blue histogram')

im_filt_red = adaptive_noise_filter(im_noisy_red, 1000);
im_filt_green = adaptive_noise_filter(im_noisy_green, 1000);
im_filt_blue = adaptive_noise_filter(im_noisy_blue, 1000);

figure()
subplot(3,2,1)
imshow(im_filt_red)
title('Filtered red band')
subplot(3,2,2)
imhist(im_filt_red)
title('Filtered red histogram')
subplot(3,2,3)
imshow(im_filt_green)
title('Filtered green band')
subplot(3,2,4)
imhist(im_filt_green)
title('Filtered green histogram')
subplot(3,2,5)
imshow(im_filt_blue)
title('Filtered blue band')
subplot(3,2,6)
imhist(im_filt_blue)
title('Filtered blue histogram')

im_noisy = uint8(zeros(size(im_orig)));
im_noisy(:,:,1) = im_noisy_red;
im_noisy(:,:,2) = im_noisy_green;
im_noisy(:,:,3) = im_noisy_blue;

im_filt = uint8(zeros(size(im_orig)));
im_filt(:,:,1) = im_filt_red;
im_filt(:,:,2) = im_filt_green;
im_filt(:,:,3) = im_filt_blue;

figure()
subplot(1,3,1)
imshow(im_orig)
title('Original image')
subplot(1,3,2)
imshow(im_noisy)
title('Image w/Gaussian noise')
subplot(1,3,3)
imshow(im_filt)
title('Filtered image')

% TASK 2

im_hsi = rgb_to_hsi(im_filt);

im_h = im_hsi(:,:,1);
im_s = im_hsi(:,:,2);
im_i = im_hsi(:,:,3);

figure()
subplot(1,3,1)
imshow(im_h)
title('Original hue')
subplot(1,3,2)
imshow(im_s)
title('Original saturation')
subplot(1,3,3)
imshow(im_i)
title('Original intensity')

im_filt_h = gaussian_7x7(im_h);
im_filt_s = gaussian_7x7(im_s);

im_filt_hsi = zeros(size(im_hsi));
im_filt_hsi(:,:,1) = im_filt_h;
im_filt_hsi(:,:,2) = im_filt_s;
im_filt_hsi(:,:,3) = im_i;

im_filt_hsi = hsi_to_rgb(im_filt_hsi);

figure()
subplot(1,3,1)
imshow(im_filt_h)
title('Filtered hue')
subplot(1,3,2)
imshow(im_filt_s)
title('Filtered saturation')
subplot(1,3,3)
imshow(im_i)
title('Original intensity')

figure()
subplot(1,2,1)
imshow(im_filt)
title('RGB filtered image')
subplot(1,2,2)
imshow(im_filt_hsi)
title('HSI filtered image')

% Conclusions about filtering accuracy

diff_hsi_filtering = im_orig - im_filt_hsi;
scaling_factor = double(max(max(max(diff_hsi_filtering))));
diff_hsi_filtering = uint8((255/scaling_factor)*double(diff_hsi_filtering));
diff_rgb_filtering = uint8((255/scaling_factor)*double(im_orig - im_filt));


figure()
subplot(1,2,1)
imshow(diff_rgb_filtering)
title('Scaled error of RGB filtering')
subplot(1,2,2)
imshow(diff_hsi_filtering)
title('Scaled error of HSI filtering')