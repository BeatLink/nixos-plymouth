1. Generate NixOS Logo from branding repo
2. Edit in inkscape
    1. Add background layer and center on page
    2. Group logo and center in background layer
    3. Duplicate logo group and set blur to 15%
    4. Duplicate logo and set blur to 30%
    5. Rename groups to logo, blur 1 and blur 2 respectively
4. Animate in xyris.app
    1. Create Fade In animation
        1. Set both blur groups opacity to 0
        2. Animate logo opacity
        3. Set keyframe at position 0 with opacity 0
        4. Set key frame at 5s with opacity 100
        5. Set animation to ease in
        6. Export as mp4
    2. Create pulse animation
        1. Set logo opacity to 100 and both blurs to 100
        2. Animate both blurs
        3. Set keyframe at the following positions with the following opacities for both blurs
            1. 0s 0%
            2. 2.5s 100%
            3. 3s   100%
            4. 5.5s 0%
            5. 6s   0%
        4. Set ease in to all transitions
        5. Export as mp4
5. Convert fade in to image series
    2.  
