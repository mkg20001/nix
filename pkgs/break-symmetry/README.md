# break-symmetry

Tool to tmp edit /etc files on nixOS

# How does it work?

Tool moves orignal link to /etc/_orig/orig_path_urlencoded
- cp -L /etc/_sym/encoded orig
- nano orig

Hook moves files back when setting up /etc

Loads path from /etc/_orig, moves edited versions to /etc/_edited, moves stuff from /etc/_orig back
Later normal etc hook executes and runs update
