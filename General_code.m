%This code was developed in order to obtain the general dz (VOKp) values for the LOFS study area.  Based on Topo-Toolbox tools.
%https://topotoolbox.wordpress.com

clc
clear

cd /Volumes/DMData/ivan/general

%loading las apps
addpath(genpath('/Users/daniel/CST/GitHub/TopoToolbox'));
format short 

%% Load inputs
%DEM = GRIDobj('srtm_g_full.tif');

DEMn='b';

DEM = GRIDobj(sprintf('srtm_%s.tif',DEMn));

% Definition of watersheds fron outlets.
FD  = FLOWobj(DEM,'preprocess','carve');
S = STREAMobj(FD,'minarea',1000);

% Estimate Ksn in the zone
DEM = imposemin(FD,DEM,0.0001);
S = klargestconncomps(S,1);
S = modify(S,'distance',500);

zs = crs(S,DEM,'K',1.9,'tau',0.1);

save step_b_01.mat

%% figure(5)
[zk,kp] = knickpointfinder(S,zs,'split',true,'plot',false,'tol',20);

save step_b_02.mat


%% Desde aquí comienzo yo!
DEM = GRIDobj('D:\Documents\Recursos_hidricos\TESIS\SRTM\SRTM_1_AE_19_07.tif');
A = flowacc(FD);
%% Concavidad figure
STATS = slopearea(S,DEM,A,'plot',false);

%% Ksn Loading
G = gradient8(DEM);
KSN = G./(A.*(A.cellsize^2)).^STATS.theta;
[x,y,ksn] = STREAMobj2XY(S,KSN);
MS = STREAMobj2mapstruct(S,'seglength',1000,'attributes',...
    {'ksn' KSN @mean ...
    'uparea' (A.*(A.cellsize^2)) @mean ...
    'gradient' G @mean});
symbolspec = makesymbolspec('line',...
 {'ksn' [min([MS.ksn]) max([MS.ksn])] 'color' jet(6) 'LineWidth' 2});
nrksn = numel(MS);
for i=1:nrksn
    MS(i).ksnrel = (MS(i).ksn - min([MS.ksn]))/(max([MS.ksn]) - min([MS.ksn]));
    
    fprintf('%u/%u\n',i,nrksn)
end
%% Generating SHP Kinckpoints
nr_Kp = numel(kp.n); kinckpoint = []; 
for i=1:kp.n
    kinckpoint(i).Geometry = deal('Point');
    kinckpoint(i).id = i;
    kinckpoint(i).X = kp.x(i);
    kinckpoint(i).Y = kp.y(i);
    kinckpoint(i).distan = kp.distance(i);
    kinckpoint(i).z = kp.z(i); 
    kinckpoint(i).IXgrid = kp.IXgrid(i); 
    kinckpoint(i).order = kp.order(i);
    kinckpoint(i).dz = kp.dz(i);
    
    fprintf('%u/%u\n',i,nr_Kp)
end
fprintf('ready\n')
%%
dir_Knick = ['General_kp.shp'];
shapewrite(kinckpoint,dir_Knick);
%% Figures

% Map
figure(6), hold on
imageschs(DEM,DEM,'colormap',gray,'colorbar',false);
mapshow(MS,'SymbolSpec',symbolspec);
dd = plot(kp.x,kp.y);
dd.LineStyle = 'none';
dd.Marker = 'o'; 
dd.MarkerFaceColor = 'r';
dd.MarkerSize = 3;
dd.MarkerEdgeColor = 'none';
legend('Knickpoint');
legend('Location','best');
c = colorbar;
c.Label.String = 'k_{sn}';
hold off

% Longitudinal profile
figure(7), hold on
plotdz(S,zs)
scatter(kp.distance,kp.z,kp.dz/2,'o','MarkerFaceColor','r')
hold off
legend('drainage',...
       'Knickpoint',... 
       'Change elevation channel')
legend('Location','best')
hold off

% Export Knickpoints and Ksn
dir_KSN = ['General_ksn.shp'];
dir_var = ['General_var'];
dir_fig1 = ['fig_01_General.png'];
dir_fig2 = ['fig_02_General.png'];
dir_fig3 = ['fig_03_General.png'];
shapewrite(MS,dir_KSN);
save(dir_var);
saveas(figure(3),dir_fig1);
saveas(figure(6),dir_fig2);
saveas(figure(7),dir_fig3);


