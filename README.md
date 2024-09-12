# WiShield

## Introduction
This project contains the data and processing codes that are involved in Evaluation.

## Project Structure
A description of the project's directory structure, including key files and directories.

```plaintext
WiShield/
│
├── Basic5300Tools/         		# Tools to decode the collected CSI files (provided by [1])
├── My5300Tools/     			# Customized tools to preprocess CSI data
│   └── GetNewACSIVarienceIndicator.m	# Calculation of amplitude variance indicator for motion detection
│   └── ......
├── spotfi/   	                        # SpotFi implementation (modified from [2])
├── Data/				# Collected CSI data and processing results
│   └── AoAEstimation/		        # Data and results for evaluating obfuscation of AoA estimation
|       ├── calibration/		# Data for internal phase offset calibration
|       ├── move_test/			# Evaluation data with moving target
|       ├── still_test/			# Evaluation data with still target
│   └── MotionDetection/		# Data and results for evaluating obfuscation of motion detection
|       ├── DRandFDR/		        # Data and results for evaluating obfuscation of detection of temporary motion
|       ├── SpatialDistribution/	# Data and results for evaluating obfuscation of detection of long-lasting motion
├── Figure/				# Code for generating Figure 10-11 and 13-15
└── README.md           		# Project README

[1] https://dhalperi.github.io/linux-80211n-csitool/

[2] https://bitbucket.org/mkotaru/spotfimusicaoaestimation/src/master/

```

## Tested Environment
List all the hardware and software tested for running the project.

+ **Hardware**: AMD Ryzen 7 4700U

+ **Software**: Windows 10, MATLAB R2023b

+ **Required MATLAB add-ons**: Signal Processing Toolbox,  Wavelet Toolbox, Statistics and Machine Learning Toolbox

+ **Optional MATLAB add-ons**: Parallel Computing Toolbox (for parallel calculation of AoA estimation)

## How to use
In _Figure/_ folder, the files are the live scripts for processing CSI data and generating figures. They can be run through the following steps.
1. Change the current folder to _WiShield/_ in MATLAB.
2. Open the ".mlx" files in _Figure/_ without changing the current folder, and then, they can be run directly.

In each ".mlx" file, the first block adds the paths of the dependent libraries. They are relative paths, so the current folder in MATLAB should be _WiShield/_ to import the libraries successfully.
