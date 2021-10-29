# ESA_Satellite_Maps
In this script, I create maps with Sentinel-3's OLCI, but can modify for a different ESA satellite.

# About ESA vs. NASA data structures
ESA and NASA use different data structures. NASA stores all parameters in one NetCDF file, while ESA stores each parameter in a separate NetCDF.

# How to set up working directory:
<img width="294" alt="Screen Shot 2021-10-29 at 5 47 37 PM" src="https://user-images.githubusercontent.com/83712030/139505920-0bac5238-b24e-42b8-a48a-6ff29e175eec.png">
Download M_map (https://www.eoas.ubc.ca/~rich/map.html) and move to functions folder.
Store Sentinel-3 file folders in data folder.

# Downloading Sentinel-2 or other OLCI images: 
I recommending using getOC: https://github.com/OceanOptics/getOC
It's a fantastic batch download tool.
