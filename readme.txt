VIIDEO Software release.

=======================================================================
-----------COPYRIGHT NOTICE STARTS WITH THIS LINE------------
Copyright (c) 2014 The University of Texas at Austin
All rights reserved.

Permission is hereby granted, without written agreement and without license or royalty fees, to use, copy, 
modify, and distribute this code (the source files) and its documentation for
any purpose, provided that the copyright notice in its entirety appear in all copies of this code, and the 
original source of this code, Laboratory for Image and Video Engineering (LIVE, http://live.ece.utexas.edu)
and Center for Perceptual Systems (CPS, http://www.cps.utexas.edu) at the University of Texas at Austin (UT Austin, 
http://www.utexas.edu), is acknowledged in any publication that reports research using this code. The research
is to be cited in the bibliography as:

1) A. Mittal, M. A. Saad and A. C. Bovik, “VIIDEO Software Release", 
URL: http://live.ece.utexas.edu/research/quality/VIIDEO_release.zip, 2014.

2) A. Mittal, M. A. Saad and A. C. Bovik, "A ‘Completely Blind’ Video Integrity Oracle", submitted to IEEE Transactions in Image Processing, 2014.

IN NO EVENT SHALL THE UNIVERSITY OF TEXAS AT AUSTIN BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, 
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OF THIS DATABASE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF TEXAS
AT AUSTIN HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

THE UNIVERSITY OF TEXAS AT AUSTIN SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE DATABASE PROVIDED HEREUNDER IS ON AN "AS IS" BASIS,
AND THE UNIVERSITY OF TEXAS AT AUSTIN HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.

-----------COPYRIGHT NOTICE ENDS WITH THIS LINE------------%

Author  : Anish Mittal 
Version : 1.0

The authors are with the Laboratory for Image and Video Engineering
(LIVE), Department of Electrical and Computer Engineering, The
University of Texas at Austin, Austin, TX.

Kindly report any suggestions or corrections to mittal.anish@gmail.com

=======================================================================

This is a demonstration of the Naturalness Image Quality Evaluator(NIQE) index. The algorithm is described in:

A. Mittal, R. Soundararajan and A. C. Bovik, "Making a Completely Blind Image Quality Analyzer", submitted to IEEE Signal Processing Letters, 2012.

You can change this program as you like and use it anywhere, but please
refer to its original source (cite our paper and our web page at
http://live.ece.utexas.edu/research/quality/niqe_release.zip).

=======================================================================
Running on Matlab 

Input : A test video name together with algorithm parameters

Output: A quality score of the video. Higher value represents a lower quality.
  
Usage: 
 
Sample execution is also shown through testscript.m


=======================================================================

MATLAB files: (provided with release): testscript.m, computeVIIDEOscore.m

Image Files: foreman_org_qcif.yuv, foreman_dst_qcif.yuv


=======================================================================
