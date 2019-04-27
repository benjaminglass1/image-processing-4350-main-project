% adaptive_noise_filter() accepts as inputs a grayscale uint8 image and an
% estimate of the variance of the noise that corrupts the image. It outputs
% a uint8 grayscale image that has been filtered with 7x7 adaptive local
% noise reduction, as in section 5.3 of Digital Image Processing by
% Gonzalez and Woods.

function im_out = adaptive_noise_filter(im_orig, variance_estimate)
    im_out = zeros(size(im_orig)); % Preallocate for speed; returns double
    im_double = double(im_orig); % Don't scale; variance is based on [0, 255]
    
    [size_x, size_y] = size(im_orig);
    
    for i = 1:size_x
        for j = 1:size_y
            if ((i<4) || (i>(size_x-4)) || (j<4) || (j>(size_y-4)))
                im_out(i,j) = im_double(i,j); % don't filter edges
            else
                im_neighborhood = im_double((i-3):(i+3),(j-3):(j+3));
                local_variance = var(reshape(im_neighborhood,[1,49]));
                local_mean = mean2(im_neighborhood);
                
                im_out(i,j) = im_double(i,j) - ...
                              (variance_estimate/local_variance) * ...
                              (im_double(i,j) - local_mean);
            end
        end
    end
    
    im_out = uint8(round(im_out));
end