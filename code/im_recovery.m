function x=im_recovery(im,damaged_x1,damaged_x2,damaged_y1,damaged_y2);
% 
% Damaged image recovery 
% This is a simple prog. for treating damaged areas in gray scale images.
% The recovery algorithm depends on replacing the missing pixels by the
% median of the non-damaged pixels lying within a 3x3 mask centered on the
% treated pixel. The algorithm is efficient for smooth areas, and it is
% less efficient in recovering areas belonging to different regions in the
% image. The prog. is tested on a segment of the rice.png image. The 
% damaged area is determined by the user. 
%
% By: Abdulrahman Ikram Siddiq
% Kirkuk - IRAQ
% Saturday Nov. 5th 2011 10:40 PM
im(damaged_x1:damaged_x2,damaged_y1:damaged_y2)=zeros(damaged_x2-damaged_x1+1,damaged_y2-damaged_y1+1); 
x=im;
% for each damaged pixel
for i=damaged_x1:damaged_x2
    for j=damaged_y1:damaged_y2
        temp=[x(i-1,j-1) x(i-1,j) x(i-1,j+1) x(i,j-1) x(i,j) x(i,j+1) x(i+1,j-1) x(i+1,j) x(i+1,j+1)];
        temp_ind=find(temp); % find non-damaged pixels
        x(i,j)=median(temp(temp_ind)); 
    end
end