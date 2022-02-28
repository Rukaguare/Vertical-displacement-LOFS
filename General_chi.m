%This code was developed to obtain a general Chi value for the LOFS study area. Based on Topo-Toolbox tools.
%https://topotoolbox.wordpress.com
%% Carging DEM
clc
clear
%Carging las apps
addpath(genpath('C:\topotoolbox-master\topotoolbox-master\TopoToolbox-2'));
format short 
%Carging the DEM
DEM = GRIDobj('SRTM_1_AE_19_07.tif');
%% Adjust DEM
info(DEM)
prompt1 = 'Correction value for NaN = '; 
value =  input(prompt1,'s');
DEM.Z(DEM.Z == 0)
DEM = inpaintnans(DEM);
figure (1), hold on;
imageschs(DEM,DEM);
c_gen = colorbar;
c_gen.Label.String = 'Elevation (MASL)';
hold off
%% Ajust streams by similar elevation
FD = FLOWobj(DEM,'preprocess','carve', 'verbose', true);

%%
S = STREAMobj(FD,'minarea',1000);
C = griddedcontour(DEM,[800 800]);
C.Z = bwmorph(C.Z,'diag');
S = modify(S,'upstreamto',C);
%figure (2), hold on;
%imageschs(DEM,DEM);
%plot(S,'color','r');
%hold off
%% adjust watersheds
% Get drainage basins
D = drainagebasins(FD,S);
 
% Get NaN mask and dilate it by one pixel.
I = isnan(DEM);
I = dilate(I,ones(3));
 
% Add border pixels to the mask
I.Z([1 end],:) = true;
I.Z(:,[1 end]) = true;
 
%% Get outlines for each basin

OUTLINES = false(DEM.size);
for r = 1:max(D);
OUTLINES = OUTLINES | bwperim(D.Z == r);
end

%% Calculate the fraction that each outline shares with the NaN mask
frac = accumarray(D.Z(OUTLINES),I.Z(OUTLINES),[],@mean);
 
% Grid the fractions
FRAC = GRIDobj(DEM);
FRAC.Z(:,:) = nan;
FRAC.Z(D.Z>0) = frac(D.Z(D.Z>0));

% Modify the STREAMobj with FRAC

S = modify(S,'upstreamto',FRAC<=0.01);
%%
figure (3), hold on;
%imageschs(DEM,FRAC);
plot(S,'color','r');
hold off
%% Selection of optime value of m/n 

flowpathapp(FD,DEM,S)
chiplot(S,DEM,A,'mnplot',true,'plot',false)
C = chiplot(S,DEM,A);


STATS = slopearea(S,DEM,A,'plot',false);
%% Calculate Chi-plot
A = flowacc(FD); % calculate flow accumulation
c = chitransform(S,A,'mn',0.4776);

%% Figure

imageschs(DEM,[],'colormap',[1 1 1],'colorbar',false,'ticklabel','nice');
hold on
plotc(S,c)
colormap(jet)
colorbar
hold off

%% convert to shapefile

MS = STREAMobj2mapstruct(S,'seglength',1000,'attributes',{'chi' c @mean});
shapewrite(MS,'chishape_0.shp')

%% figure comparasion

Sm = modify(S,'interactive','polyselect');


figure(5),hold on
plotdz(Sm,DEM,'distance',c2,'color','r','FaceAlpha',.1,'EdgeAlpha',.1);
plotdz(Sm2,DEM,'distance',c3,'color','b','FaceAlpha',.1,'EdgeAlpha',.1);
hold off
xlabel('\chi [m]')
