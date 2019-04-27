% hsi_to_rgb() expects as input an hsi image of type double, with all
% components ranging from [0,1]. It outputs a uint8 rgb image.

function im_rgb = hsi_to_rgb(im_hsi)
    im_rgb = zeros(size(im_hsi));
    
    for x = 1:size(im_hsi,1)
        for y = 1:size(im_hsi,2)
            h = 2*pi*im_hsi(x,y,1);
            s = im_hsi(x,y,2);
            i = im_hsi(x,y,3);
            
            if (h >= 0) && (h < 2*pi/3)
                im_rgb(x,y,3) = i*(1-s);
                im_rgb(x,y,1) = i*(1+s*cos(h)/cos(pi/3 - h));
                im_rgb(x,y,2) = 3*i - (im_rgb(x,y,1) + im_rgb(x,y,3));
            elseif (h >= 2*pi/3) && (h < 4*pi/3)
                h = h - 2*pi/3;
                
                im_rgb(x,y,1) = i*(1-s);
                im_rgb(x,y,2) = i*(1+s*cos(h)/cos(pi/3 - h));
                im_rgb(x,y,3) = 3*i - (im_rgb(x,y,1) + im_rgb(x,y,2));
            else
                h = h - 4*pi/3;
                
                im_rgb(x,y,2) = i*(1-s);
                im_rgb(x,y,3) = i*(1+s*cos(h)/cos(pi/3 - h));
                im_rgb(x,y,1) = 3*i - (im_rgb(x,y,2) + im_rgb(x,y,3));
            end
        end
    end
    
    im_rgb = uint8(round(255*im_rgb));
end