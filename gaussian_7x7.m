% gaussian_7x7() accepts as input a grayscale double image, filters it with
% a 7x7 Gaussian low-pass kernel, and outputs a grayscale double image.

function im_out = gaussian_7x7(im_in)
    kernel = [0.000036 0.000363 0.001446 0.002291 0.001446 0.000363 0.000036;
              0.000363 0.003676 0.014662 0.023226 0.014662 0.003676 0.000363;
              0.001446 0.014662 0.058488 0.092651 0.058488 0.014662 0.001446;
              0.002291 0.023226 0.092651 0.146768 0.092651 0.023226 0.002291;
              0.001446 0.014662 0.058488 0.092651 0.058488 0.014662 0.001446;
              0.000363 0.003676 0.014662 0.023226 0.014662 0.003676 0.000363;
              0.000036 0.000363 0.001446 0.002291 0.001446 0.000363 0.000036];
          
    im_out = conv2(im_in,kernel,'same');
end