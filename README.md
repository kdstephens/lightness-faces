# Perceived Lightness of Faces Experiments
## Academic Background
Can cognitive constructs such as beliefs, desires or expectations directly affect our perceptual experience of the world? Or is perception encapsulated from the influence of such "high-level" cognitive constructs? This has been an enduring debate in the literature on psychology and perception (for a review, see Chapter 3 of [Stephens, 2015](#step2015)). 

One highly cited example in this debate is a 2006 paper from researchers at Harvard ([Levin & Banaji, 2006](#lev2006)). They claimed to demonstrate that the perceived race of a face (a high-level cognitive construct) can alter how light its skin looks (a low-level perception) regardless of how light the skin actually is. Specifically, they showed that observers rate a prototypical African-American face as darker than a prototypical Caucasian face even when the faces have the same average luminance and contrast. 

As part of my PhD dissertation I showed that the effects demonstrated by Levin & Banaji go away when you conceal the purpose of the experiment from participants ([Stephens, 2015](#step2015)). In other words, I showed that their effects can be explained as response bias due to the demand characteristics of the experiment (for a different objection, see [Firestone & Scholl, 2015](#fire2015); for a reply, see [Baker & Levin, 2016](#baker2016)).

This repository contains the code I used in for my experiments. All code was written for Matlab's Psychophysics Toolbox (http://psychtoolbox.org/). 

## Custom Functions
In addition to the main experiment functions (MAIN_***.m), there are several other custom functions that are helpful when working with Matlab and the Psychophysics toolbox.
 - GetEchoInput &ndash; Adapted from the Psychtoolbox function GetEchoString.m. Shows participants an image on a Psychtoolbox window along with a display message and takes inputs.  
 - GetImgs.m &ndash; Retreives the names and RGB matrices (necessary for showing the images on screen using Psyctoolbox) for all images in a subdirectory.
 - GetNexSubID.m &ndash; Gets an ID for the next participant based on the IDs of previous participants, which are stored in a subdirectory. Particpant IDs are simply increasing numbers (i.e., participant 1, 2, 3, etc...).
 - MkWhiteNoise.m &ndash; Generates a rectangle of Gaussian white noise to be displayed between each stimulus, i.e. during the interstimulus interval (ISI). 
 - PsychtoolboxSetup.m &ndash; A script that runs the functions necessary to get Psychtoolbox ready for running an experiment.  
 - RePAndPermVects.m &ndash; Takes in possibly multiple input vectors, copies each element of each vector numRepeats number of times and then randomly permutes each vector into a larger vector.
 - ShowImgUntilKeyPressed.m &ndash; Psychtoolbox function that takes in an image filename and displays the the image in the current PsychToolbox window until a key is pressed. 


 ## Experiments
 ### Experiment LF0
 In this experiment, participants view several faces, one and a time, and must judge whether they are racially Black or White ('b' for Black, 'w' for White). There are only actually 2 different faces &ndash; the prototypical African-American face and the prototypical Caucausian face used in [Levin & Banaji's (2006)](lev2006) original experiment. However, each face has been duplicated several times, with each duplicate made either darker or lighter in luminance than the original. Odd-numbered participants see the faces upright and even-numbered participants see them inverted.

 ### Experiment MLF0
 Similar to experiment *LF0*, except uses "morphed faces" as stimuli, which are morphs between a Caucasin face and an African-American face. There are two versions of each morph, one wearing the Caucasian hairstyle and one wearing the African-American hairstyle. The goal of this experiment is to create a set of racially ambiguous faces that participants perceive as Caucasian when wearing one hairstyle but as African-American when wearing another hairstyle. See the ReadMe file in /MLF0 for more details. 

 ### Experiment LF1
 In this experiment, participants view two faces at a time and attempt to match their perceived lightness. This is a replication/extension of Experiment 1 in [Levin & Banaji (2006)](lev2006). (see p. 504 for their description of the experimental procedure). Thus the face stimuli come directly from Levin & Banaji. They consist of three faces &ndash; one pre-rated as racially Black, one pre-rated as racially White, and one pre-rated as racially Ambiguous (i.e., when asked, half of participants rate it as Black and the other half as White). 

 On each trial the experiment participants view two faces, one labeled the "reference face" and one labeled the "adjustable face." The participants' task is to manipulate the adjustable face so that its "shading" matches that of the reference face as closely as possible. Adjustments are made using the up-arrow key and down-arrow key. Hitting either key once exchanges the current adjustable face with the same face that is either 5 grey-levels lighter or 5 grey-levels darker. 

 ### More to Come
 I am in the process of uploading ALL of my old experiment code onto GitHub. This is just the beginning. Because I want to double-check all of the code (make sure it works, is properly commented, etc.), the process is slow-going. If this project interests you, check back in a couple of days as there will likely be more code uploaded. 

 ## References
 <a id="baker2016"></a>Baker, L.J., & Levin, D.T. (2016). The face-race lightness illusion is not driven by low-level stimulus properties: An empirical reply to Firestone and Scholl (2014). *Psychonomic Bulletin & Review, 23*, 1989–1995. https://doi.org/10.3758/s13423-016-1048-z
 
 <a id="fire2015"></a>Firestone, C., & Scholl, B.J. (2015). Can you *experience* ‘top-down’ effects on perception?: The case of race categories and perceived lightness. *Psychonomic Bulletin & Review, 22*, 694–700. https://doi.org/10.3758/s13423-014-0711-5
 
 <a id="lev2006"></a>Levin, D. T., & Banaji, M. R. (2006). Distortions in the perceived lightness of faces: The role of race categories. *Journal of Experimental Psychology: General, 135(4)*, 501–512. https://doi.org/10.1037/0096-3445.135.4.501

<a id="step2015"></a>Stephens, K. D. (2015). *Texture preference, facial attractiveness, and the effect of race on lightness perception* [Doctoral Dissertation, Unversity of California, Irvine]. ProQuest.


 
