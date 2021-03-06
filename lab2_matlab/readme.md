# Introduction to Images in Matlab

## Setup

1.  Start the virtual machine
2.  Clone the original lab vision repository

    ```bash
    git clone https://github.com/diego0020/lab_vision.git lab_vision_orig
    ```
3.  Clone your fork from the repository

    ```bash
    git clone https://github.com/<USER>/lab_vision.git lab_vision
    ```
4.  Copy the folder lab2_matlab to your repository

    ```bash
    cp -rf lab_vision_orig/lab2_matlab lab_vision
    ```
5.  Delete the original repository from your machine

    ```bash
    rm -rf lab_vision_orig
    ```
6.  Commit changes to your repository

    ```bash
    cd lab_vision
    git status
    git add *
    git commit -m "added matlab lab"
    ```
7.  Push changes

    ```bash
    git push
    ```    
8.  Download and uncompress the sipi_images misc folder in your home folder

    ```bash
    cd ~
    scp -r vision@guitaca.uniandes.edu.co:/home/vision/sipi_images/misc.tar.gz .
    # alternative
    # wget http://sipi.usc.edu/database/misc.tar.gz
    tar -xzf misc.tar.gz
    ```    
9.  Open matlab

    ```bash
    /usr/local/MATLAB/R2014b/bin/matlab
    ```

Note: On windows you can use [github for windows](https://windows.github.com/) or [git-scm](http://git-scm.com/)

**IMPORTANT**
This file contains questions, you should write your answers here and don't forget to **commit** and **push** to
your github account.

## Working directory

The following commands can be used inside matlab, just like in bash

    -   pwd
    -   ls
    -   cd

For more file system see http://www.mathworks.com/help/matlab/file-operations.html

Note the current directory is also shown at the top of the graphical interface

1.  Change to the *misc* directory, which contains the uncompressed sipi_images
2.  List the contents of the directory

## Reading Images

The [imread](http://www.mathworks.com/help/matlab/ref/imread.html) command is used in matlab to read images. 

1.  Look at the manual page for the command
2.  Read the ``5.1.12`` image
    
    What is the dimension of the output?

    >   256x256

3.  Read the ``4.2.03`` image
    What is the dimension of the output?

    >   512x512x3

## Displaying Images

The following commands can be used for displaying images

-   [image](http://www.mathworks.com/help/matlab/ref/image.html)
-   [imshow](http://www.mathworks.com/help/images/ref/imshow.html)

1.  Look at their manual pages
2.  Try displaying the images read in the previous point using both commands
3.  What are the differences?

    >   La diferencia entre image e imshow es que 'image' retorna una imagen como una gráfica con coordenadas, mientras que imshow sólamente muestra la imagen. Las dos permiten ampliar la imagen y moverse por ella. 

## Writing Images

The [imwrite](http://www.mathworks.com/help/matlab/ref/imwrite.html) image is used for writing images to disk

1.  Look at the manual page
2.  Write one of the images from before as png and as jpg
3.  Write a matlab function that takes the path of an image and converts it to jpg

## Matlab and the shell

im1=imread('5.1.12.tiff');
im2=imread('4.2.03.tiff');
image(im2);
imshow(im2);
imwrite(im1,'Mico.png')
imwrite(im1,'Mico.jpg')

### Shell from Matlab

It is possible to excecute bash commands from matlab by using the [system](http://www.mathworks.com/help/matlab/ref/system.html) command
or by using a [bang](http://www.mathworks.com/help/matlab/matlab_env/run-external-commands-scripts-and-programs.html)

1.  Look at the manual pages
2.  Try it (for example ``!ps``)

### Matlab from the shell

It is also possible to invoke matlab in a non interactive mode to run a script from the terminal. If the matlab
binary is on the system PATH you can do something like this

```bash
matlab -nodisplay -nosplash -r "write_jpg('boat.512.tiff'); exit"
# or
matlab -nodisplay -nosplash script.m"
```
If the command or script doesn't end in ``exit`` the matlab shell will stay open, and will block the bash script.

### Exercise

1.  Create a script for converting all tiff images to jpeg
    -   You may create a bash script that calls matlab
    -   Or a matlab script that calls bash 
    -   Or both
    
2.  Save this script in the matlab lab folder of your git repository


    A=dir('*.tiff');
    l=size(A);
    h=l(1);

    for i=1:h
        name=A(i).name;
        IMAGE=imread(name);
        name2=name(1:end-5);
        imwrite(IMAGE,[name2,'.jpg'])
    end

## Filters

### Adding noise

The [imnoise](http://www.mathworks.com/help/images/ref/imnoise.html) command can be used to add noise to images.
We can do this to simulate difficult capture conditions, and evaluate the algorithms over difficult situations.

1.  Read the manual page
2.  Try the diffente noise types, and save the noisy images to the repository (5 images)
3.  Try saving noisy images as jpg, what happens?

    > Al guardar las imágenes con ruido en formato .jpg y comparalas con aquellas guardadas en formato .png, las imágenes quedan más oscuras y los colores se ven menos intensos. Esto puede estar pasando ya que el guardar la imagen en formato .jpg ésta está siendo comprimida y parte de la información de la imagen se pierde, generando estos cambios en color y en intensidad. 

### Median filter

These filters can be applied to a an image in order to remove noise. 
-   To apply a mean filter create it with the function [fspecial](http://www.mathworks.com/help/images/ref/fspecial.html)
    and apply it with [imfilter](http://www.mathworks.com/help/images/ref/imfilter.html) 
-   To apply a median filter use the function [medfilt2](http://www.mathworks.com/help/images/ref/medfilt2.html)

1.  Read the manuals for the functions described above
2.  Try applying both kinds of filters to noisy images. Be sure to zoom in to see the effects
3.  Try different sizes for the filters
4.  Which filter works best for salt & pepper noise?

    > Para el ruido 'salt & pepper' funciona mejor el median filter pues reduce el ruido y a su vez preserva los bordes de la imagen. 

For more on noise removal read http://www.mathworks.com/help/images/noise-removal.html

### Blur

To blur or smooth an image we can use the mean filter described above. We can also use the gaussian filter
which can be otained from [fspecial](http://www.mathworks.com/help/images/ref/fspecial.html).

1.  Smooth an image using average and gaussian filters
2.  Try different sizes for the filters
3.  What differences do you notice?

    > A medida que se incrementa el tamaño del filtro promedio, la imagen se vuelve más borrosa, pues la intensidad final termina siendo el promedio de las intensidades de más pixeles que rodean el pixel central. Para el filtro gaussiano no es tan perceptible, pues se le da más importancia a las intensidades de los pixeles que se encuentran cercanos al centro, por lo que la intensidad no se ve tan afectada por los píxeles lejanos.

### Sharpen

The [imsharpen](http://www.mathworks.com/help/images/ref/imsharpen.html) function lets us sharpen an image. 

1.  Sharp the ``5.1.12`` image. What do you notice?

    > La imagen que se obtiene al aplicar el sharpen tiene los bordes mucho más definidos lo que hace que las texturas y detalles de los objetos de la imagen se vean más claros. 

2.  Sharp a blurred image. What do you notice?

    > Al aplicarle sharpen a la imagen que se había puesto borrosa con un filtro promedio de 3x3 en el punto anterior, los bordes de la imagen se tornaron mucho más definidos. Por el contrario al aplicarle sharpen a la otra imagen borrosa (filtro promedio 9x9) ésta no cambió mucho su aspecto ni definición, lo que hace pensar que el resultado de aplicar ésta función depende mucho de la imagen de entrada y de qué tan definidos se encuentren los bordes en ella. 

### Edge detection

The following filters from fspecial can be used to enhance edges in an image
-   laplacian
-   log
-   prewitt
-   sobel

Notice that the last two filters detect horizontal edges, in order to detect vertical edges you have to transpose them.

1.  Try applying this filters
2.  What is the difference between prewitt and sobel?

    > Los dos métodos para detectar bordes (prewitt y sobel) encuentran el vector gradiente o la norma del vector para todos los pixeles de la imagen y de esta manera determinan si el pixel que se está analizando es o no un borde. La diferencia entre los métodos es la máscara que utilizan, pues la máscara de sobel le da más peso a los pixeles que se encuentran sobre la misma fila (en el caso de la máscara que detecta los bordes verticales) o sobre la misma columna (en el caso de la máscara que detecta los bordes horizontales), mientras que el método prewitt le da el mismo peso a todos los pixeles. 
    
    Nota: En los dos casos el peso de los pixeles que se encuentran en la misma columna (máscara para bordes verticales) y en la misma fila (máscara para bordes horizontales) tienen peso 0. 

More sophisticated methods for finding edges can be found in the following pages
    -   http://www.mathworks.com/discovery/edge-detection.html
    -   http://www.mathworks.com/help/images/ref/edge.html

### More

For more filtering operations look at http://www.mathworks.com/help/images/linear-filtering.html

## Color Spaces

As seen on the section on reading image, color images are represented by matrices with 4 dimensions.
The [color](http://www.mathworks.com/help/images/color.html) matlab module contains functions for moving between
color spaces.

1.  Load the ``4.2.03.tiff`` image (Mandril).
2.  Split it into the three color channels
    
    ```matlab
    img=imread('4.2.03.tiff');
    r = img(:,:,1);
    g = img(:,:,2);
    b = img(:,:,3);
    ```
3.  Look at the three channels simultaneusly

    ```matlab
    figure;
    subplot(2,2,1), subimage(img);
    subplot(2,2,2), subimage(r);
    subplot(2,2,3), subimage(g);
    subplot(2,2,4), subimage(b);
    ```
    
4.  Save the mosaic as a png file
    
    ```matlab
    print ('-dpng','rgb_mosaic.png');
    ```
5.  Transform the image to the following color spaces and repeat the exercise
    -   ycbcr
    -   lab
    -   hsv (use [rgb2hsv](http://www.mathworks.com/help/matlab/ref/rgb2hsv.html))

6.  Save all the mosaics in your github repository

## Pyramids

The [impyramid](http://www.mathworks.com/help/images/ref/impyramid.html) function creates gaussian pyramids from an image.

1.  Read the manual page
2.  Create a four level pyramid from the ``5.1.12`` clock  image
3.  At what level does the people in the picture dissappear?

    >   Las personas en la figura desaparecen, es decir dejan de tener una forma clara y se convierten en una cantidad de pixeles coloreados sin forma y con diferetes tonos de grises, en el segundo nivel de la pirámide.
    
4.  At what level does the numbers in the clock disappear?

    >   Los números en el reloj desaparecen del todo en el tercer nivel de la pirámide.

## Template Matching

The [norm2corrx](http://www.mathworks.com/help/images/ref/normxcorr2.htm) can be used to look for patterns in an image.

1.  Download the ``sequences.tar.gz`` file (from guitaca or sipi) and decompress it
2.  Go to the sequences directory
3.  Read the ``motion04.512.tiff`` image
4.  Use the ``imcrop`` comand to crop the train at the right side of the figure
    
    ```matlab
    [train,square] = imcrop(image);
    ```
5.  Now use [normxcorr2](http://www.mathworks.com/help/images/ref/normxcorr2.htm) to locate the train back in the image

    ```matlab
    c=normxcorr2(train,image);
    % c is correlation from -1 to 1
    [sx,sy] = size(image);
    d=floor(size(train)/2);
    dx=d(1);
    dy=d(2);
    %Remove borders from c2 to make it the same size as image
    c2=c(dx+1:sx+dx,dy+1:sy+dy);
    %lets accentuate it more
    c3=c2.^3;
    %convert it into an image from 0 to 1
    cr=0.5+0.5*c3;
    %leave the original image as the luminance channel
    y=mat2gray(image);
    %empty cb channel
    cb=0.5*ones(size(image));
    %join the three channels
    ycbcr=cat(3,y,cb,cr);
    rgb=ycbcr2rgb(ycbcr);
    imshow(rgb);
    ```
6.  Explain what the above code does

    > Inicialmente el código recibe unas coordenadas de la imagen en las cuales se encuentra el tren, que es el resultado de aplicar la función 'imcrop' en la cual el usuario debe seleccionar manualmente lo que se desea recortar. Posteriormente, se realiza la cros-correlación normalizada entre la imagen recortada del tren y la imagen original, de la cual resulta una matriz 'c' en la que se encuentran valores de la correlación entre el template y la imagen. A continuación se calcula el tamaño de la imagen original y de la máscara. Se continúa con la remoción de los bordes de la matriz resultante 'c' de tal forma que quede del mismo tamaño que la imagen original. Después se acentúan los valores de correlación obtenidos, elevando de manera individual los valores de la matriz a la tercera potencia. Se convierten los valores obtenidos a valores entre 0 y 1, multiplicando su valor individual por 0.5 y sumándole 0.5. La matriz obtenida se le asigna al canal de Cr del espacio de color YCbCr. Los últimos pasos corresponden generar el canal Y, transformando la matriz de la imagen original en grises; a generar una matriz con valores de 0.5 y asignárselo al canal Cb, y finalmente a unir los tres canales Y,Cb y Cr y transformarlos a RGB.
    
7.  Now lets find the train in the next frame, read image ``motion05.512.tiff``.
8.  Apply the procedure written above to it (use the train template from the past frame)
9.  What are the limitations of this method?

    > Ya que el template se obtiene a partir de la imagen original, la búsqueda de la imagen del template en la imagen original resulta sencilla y se obtienen buenos resultados. En caso de que por el contrario no se contara con un template exacto de lo que se busca, o en caso de que el objeto que se busca se encuentre en otra orientación en la imagen, es posible que el resultado de la cross-correlación no sea el ideal y que el objeto no se encuentre en la imagen. 

See [here](http://www.mathworks.com/help/images/examples/registering-an-image-using-normalized-cross-correlation.html)
another example.

## End

Don't forget to commit and push your answers and images to github
