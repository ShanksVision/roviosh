% detect edges

file1 = 'ImageIn.jpg';
file2 = 'ImageOut.jpg';

I = rgb2gray(imread(file1));

%O = edge(I,'canny');
O = edge(I,'sobel');

imwrite(O,file2,'jpg');

