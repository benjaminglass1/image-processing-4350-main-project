% add_gaussian_noise() accepts a grayscale uint8 image and a noise variance
% as inputs, and outputs the image corrupted with an Gaussian noise of the
% given variance and 0 mean. Image values above 255 or below 0 are clipped.

function im_out = add_gaussian_noise(im_orig, variance)
    gaussian_noise = sqrt(variance)*randn(size(im_orig));
    
    % Cast to double to prevent overflows; then clip to [0, 255]
    im_out = uint8(double(im_orig) + gaussian_noise);
end