# docker-demo
Repository hosting our Dockerfile used to create the instance of our demo environment

This Dockerfile is used to build a docker image so that one can solve a Traveling Salesman Problem using either an Arogi sample dataset
or by piping in a users data file.  This readme assumes that you have installed docker and are relatively familiar with the command line.

To build the image use the following command:
  docker build -t my-docker-image .
where my-docker-image is the name of the image we are creating.  Note that it is neccessary to insert the period after the image name.  If 
this is omitted the image will not compile and you will get an error.

The next step is to create and run your container.  To run a simple container utilizing only the arogi sample data issue the following
command:
  docker run -it -p 80:80 my-docker-image
This will instruct docker to create and run the image and maps port 80 on the host to 80 on the container using our compiled image. To run
 this container so that you can utilize your own data you must do the following.  First, ensure that your data file is a geojson file that
 is set up as a javascript file. Specifically your file needs to have a filename of mydata.js and the first line must include 
  'var defaultMarkers = {' and the last line must include '};' - minus the ''.  
Following this convention simply use the following docker command to pipe in your data:
  docker run -it -p 80:80 -v ~/Desktop:/var/www/html/data my-docker-image
Note that if you did not stop and remove the default example container above you will need to run docker ps -a to find the name of the
container (e.g. something like awesome_niblett) and remove it.  This can be done through: docker rm awesome_niblett
As a side note to users of Mac OS and Windows; the docker-machine which hosts our container typically is only configured to capture the
'users' area of the computer.  Thus, as long as Mac OS users utilize the ~/ to represent their home folder in the docker command they
should be fine.  Windows users, however, need to specify a particular path.  To specify a User space on windows within a docker run
command you may need to issue something like:
  docker run -v /c/Users/<path>:/<container path> 

To access the solution webpage simply open a web browser; if you are on linux you can simply type localhost and the page should load. If 
you are on Mac OS or Windows, however, you will need to type in the address of the docker-machine (usually 192.168.99.100) and the page
should then load.
