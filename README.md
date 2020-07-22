# Anaglyph Maker

After visiting NASA's Jet Propulsion Laboratories websites for the Mars Rover with my daughter, I got interested in the process of creating red/blue 3D images. After doing some research on these 3D images called "anaglyph images," and not finding any Mac programs for generating them that I liked, I decided to write a program to create them. Anaglyph Maker is the result; it is a simple application for combining "stereo pair" images (images taken of the same subject from two positions a few inches apart on the same horizontal plane) into a single anaglyphic image. There are options in the program for generating both grayscale and color anaglyphs, but to generate a color anaglyph, your source images must be color. You can also save the raw stereo pairs into an Anaglyph Maker document so that you can load it later. 

There is some online help available that will help you learn to take "stereo pair" images, and will also take you on a short tour of using Anaglyph Maker.  It also contains information to help you find the things you will need to make and view the anaglyph images.



Version History
===============
v1.0b1	29-January 2004    	Initial release.
v1.0b2 	30-January 2004    	Fixed error with export that caused '.pdf' to 
						be appended to exported TIFF files.
v1.0b3	02-February 2004	Moved processing into a thread to make GUI more
						responsive; removed ask to save when both left
						and right image are empty.
v1.0b4	06-February 2004	Fixed compatibility problems with pre-OS X 10.3
						Operating systems
v1.0b5 	07-February 2004	Fixed issue where width was being used when
						pixelsWide should have been used, resulting in
						problems with pictures not at screen resolution.
v1.0b6	07-February 2004	Internal release.
v1.0b7  	08-February 2004	Fixed problem that caused color anaglyphs to be a
						different size and/or resolution than the original.
v1.0b8	09-February 2004	No, really. Fixed problem that caused color anaglyphs
						to be a different size and/or resolution than the
						original.
