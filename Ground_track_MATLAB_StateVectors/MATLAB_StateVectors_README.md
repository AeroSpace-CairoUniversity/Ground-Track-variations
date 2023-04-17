# Ground tracker for any satellite using State Vectors!!
**This MATLAB code simulates an Earth orbit and plots its shape, trajectory, and ground track. The orbit is defined by the semi-major axis, eccentricity, inclination, right ascension of ascending node (RAAN), and argument of perigee, namely, the COEs. The code uses rotation matrices to transform the spacecraft position vector from the perifocal reference frame to the geocentric equatorial reference frame.**

To improve the readability of the code, the following modifications were made:

+ **Added comments to explain the purpose of each section of code.**

+ **Used meaningful variable names to make the code more self-explanatory.**
+ **Organized the code into sections separated by comments to make it easier to navigate.**
+ **Used the 'surf' function to plot the Earth's surface instead of 'mesh' function.**
+ **Added a background map image for the ground track plot.**
+ **Added titles, axis labels, and legends to the plots to make them more informative.**

To run the code, copy and paste it into a MATLAB script file and run the file. The script will generate three figures:

Figure 1: Orbit Shape
Figure 2: Orbit and Earth
Figure 3: Ground Track
Note: To run the code, make sure the image file "background.png" is saved in the same directory as the script file.
