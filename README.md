# Perceived Lightness of Faces Experiments
## Academic Background
Can cognitive constructs such as beliefs, desires or expectations directly affect our perceptual experience of the world? Or is perception encapsulated from the influence of such "high-level" cognitive constructs? This has been an enduring debate in the literature on psychology and perception (for a review, see Stephens, 2015, Chapter 3). 

One highly cited example in this debate is a 2006 paper from researchers at Harvard (Levin & Banaji, 2006). They claimed to demonstrate that the perceived race of a face (a high-level cognitive construct) can alter how light its skin looks (a low-level perception) regardless of how light the skin actually is. Specifically, they showed that observers rate a prototypical African-American face as darker than a prototypical Caucasian face even when the faces have the same average luminance and contrast. 

As part of my PhD dissertation I showed that the effects demonstrated by Levin & Banaji go away when you conceal the purpose of the experiment from participants (Stephens, 2015). In other words, I showed that their effects can be explained as response bias due to the demand characteristics of the experiment (for a different objection, see Firestone & Scholl, 2015; for a reply, see Baker & Levin, 2016).

This repository contains the code I used in for my experiments. All code was written for Matlab's Psychophysics Toolbox (http://psychtoolbox.org/). 

## Custom Functions
In addition to the main experiment functions (MAIN_***.m), there are several other custom functions that are helpful when working with Matlab and the Psychophysics toolbox. 
 - GetNexSubID.m -- Gets an ID for the next participant based on the IDs of previous participants, which are stored in a subdirectory. Particpant IDs are simply increasing numbers (i.e., participant 1, 2, 3, etc...).
 - GetImgs.m -- Retreives the names and RGB matrices (necessary for showing the images on screen using Psyctoolbox) for the images in a subdirectory.
 - RePAndPermVects.m -- Takes in possibly multiple input vectors, copies each element of each vector numRepeats number of times and then randomly permutes each vector into a larger vector.
 - ShowImgUntilKeyPressed.m -- Psychtoolbox function that takes in an image filename and displays the the image in the current PsychToolbox window until a key is pressed. 
 - GetEchoInput -- Adapted from the Psychtoolbox function GetEchoString.m. Shows participants an image on a Psychtoolbox window along with a display message and takes inputs from the participants. 

 ## References
 Baker, L.J., & Levin, D.T. (2016). The face-race lightness illusion is not driven by low-level stimulus properties: An empirical reply to Firestone and Scholl (2014). *Psychonomic Bulletin & Review, 23*, 1989–1995. https://doi.org/10.3758/s13423-016-1048-z
 
 Firestone, C., & Scholl, B.J. (2015). Can you *experience* ‘top-down’ effects on perception?: The case of race categories and perceived lightness. *Psychonomic Bulletin & Review, 22*, 694–700. https://doi.org/10.3758/s13423-014-0711-5
 
 Levin, D. T., & Banaji, M. R. (2006). Distortions in the perceived lightness of faces: The role of race categories. *Journal of Experimental Psychology: General, 135(4)*, 501–512. https://doi.org/10.1037/0096-3445.135.4.501

 Stephens, K. D. (2015). *Texture preference, facial attractiveness, and the effect of race on lightness perception* [Doctoral Dissertation, Unversity of California, Irvine]. ProQuest.


 
