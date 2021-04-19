%inp = imread('Y:\Thesis\Hand db\my test images\p1.JPG');
inp = imread('740.jpg');
figure;imshow(inp), title('pointing');
text(size(inp,2),size(inp,1)+15,'Image courtesy of Shankaranand, University of Illinois at Chicago', 'FontSize',7,'HorizontalAlignment','right');
% inp_c = colorspace('Luv<-',inp);
% u=inp_c(:, :, 2);
% v=inp_c(:, :, 3);
% figure;subplot(2,2,1), imshow(inp_c);subplot(2,2,2), imshow(inp_c(:,:,1));subplot(2,2,3), imshow(u);subplot(2,2,4), imshow(v);
%imshow(inp_c(:, :, 1));
% hist(inp_c(:,:,1));
cform = makecform('srgb2xyz');
inp_t = applycform(inp,cform);
cform1 = makecform('xyz2uvl');
inp_tb = applycform(inp_t,cform1);
figure;subplot(2,2,1), imshow(inp_tb), title('LUV color space');subplot(2,2,2), imshow(inp_tb(:,:,1)), title('U Component');
%figure;subplot(2,2,1), imshow(inp), title('LUV color space');subplot(2,2,2), imshow(inp(:,:,1)), title('U Component');

subplot(2,2,3), imshow(inp_tb(:,:,2)), title('V Component');subplot(2,2,4), imshow(inp_tb(:,:,3)), title('L Component');
%subplot(2,2,3), imshow(inp), title('LUV color space');subplot(2,2,4), imshow(inp(:,:,1)), title('U Component');

inp_uv = double(inp_tb(:,:,1:2));
%inp_uv = double(inp(:,:,1:2));

nrows = size(inp_uv,1);
ncols = size(inp_uv,2);
inp_uv_r = reshape(inp_uv,nrows*ncols,2);
nColors = 2;
opts = statset('Display','final');
[cluster cluster_cen] = kmeans(inp_uv_r,nColors,'distance','cityBlock','Replicates',2,'Options',opts);
figure;plot(inp_uv_r(cluster==1,1),inp_uv_r(cluster==1,2),'r.','MarkerSize',12)
hold on
plot(inp_uv_r(cluster==2,1),inp_uv_r(cluster==2,2),'b.','MarkerSize',12)
plot(cluster_cen(:,1),cluster_cen(:,2),'kx','MarkerSize',12,'LineWidth',2)
plot(cluster_cen(:,1),cluster_cen(:,2),'ko','MarkerSize',12,'LineWidth',2)

legend('Cluster 1','Cluster 2','Centroids','Location','NW')
pixel_lab = reshape(cluster,nrows,ncols);
figure;imshow(pixel_lab,[]), title('Skin color segmented by labelling cluster index');

segmented_images = cell(1,2);
rgb_label = repmat(pixel_lab,[1 1 2]);

for k = 1:nColors
    color = inp;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

% figure;imshow(segmented_images{1}), title('objects in cluster 1');
% figure;imshow(segmented_images{2}), title('objects in cluster 2');
