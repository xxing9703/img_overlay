function R=img_reg_cp(moving,fixed)
[mp,fp] = cpselect(moving,fixed,'Wait',true);
t = fitgeotrans(mp,fp,'affine');
tform=cp2tform(mp,fp,'affine');
Rfixed = imref2d(size(fixed));
movingR = imwarp(moving,t,'nearest','OutputView',Rfixed);
%store the first registration R1
R.moving=moving;
R.fixed=fixed;
R.movingR=movingR;
R.Rfixed=Rfixed;
R.t=t; %affine 2d object
R.tform=tform;