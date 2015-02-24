function [matrix_out] = pixels_reorganize(array_in)
lwd=size(array_in);
matrix_out=zeros(lwd(1)*lwd(2),5);

x=1:1:lwd(2);
y=1:1:lwd(1);

matrix_x=zeros(lwd(1),lwd(2));
matrix_y=zeros(lwd(1),lwd(2));

for i=1:lwd(1)
    matrix_x(i,:)=x;
end

for i=1:lwd(2)
    matrix_y(:,i)=y;
end

for i=1:5
    if i<4
        matrix_out(:,i)=reshape(array_in(:,:,i),lwd(1)*lwd(2),1);
    else 
        matrix_out(:,4)=reshape(matrix_x,lwd(1)*lwd(2),1);
        matrix_out(:,5)=reshape(matrix_y,lwd(1)*lwd(2),1);
    end
end

end

