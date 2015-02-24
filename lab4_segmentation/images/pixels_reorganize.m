function [matrix_out] = pixels_reorganize(array_in)
lwd=size(array_in);
matrix_out=zeros(lwd(1)*lwd(2),3);

for i=1:3
    matrix_out(:,i)=reshape(array_in(:,:,i),lwd(1)*lwd(2),1);
end

end

