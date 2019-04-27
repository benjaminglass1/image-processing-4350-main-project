% rgb_to_hsi() expects a uint8 rgb image as input, and outputs an hsi
% image, with all components scaled to the range [0,1].

function im_hsi = rgb_to_hsi(im_rgb)
im_double = double(im_rgb)/255;
im_hsi = zeros(size(im_double));

for i = 1:size(im_rgb,1)
    for j = 1:size(im_rgb,2)
        r = im_double(i,j,1);
        g = im_double(i,j,2);
        b = im_double(i,j,3);
        
        % 0.00000001 added to denominator to prevent divide by 0 errors
        theta = acos(0.5*((r-g)+(r-b))/(sqrt((r-g)^2 + (r-b)*(g-b))+0.00000001));
        
        if b <= g
            im_hsi(i,j,1) = theta/(2*pi);
        else
            im_hsi(i,j,1) = (2*pi-theta)/(2*pi); % normalize to [0,1]
        end
        
        im_hsi(i,j,2) = 1 - (3*min([r,g,b])/(r+g+b));
        im_hsi(i,j,3) = (1/3)*(r+g+b);
    end
end
end