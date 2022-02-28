%% Code for analysis of Ksn and Kninckpoints, using watersheds with similar boundary conditions in the Liquñe - Ofqui Fault zone 
% This code use information processed in software SIG, as a Digital 
% elevation model (DEM) for the study area and two points (in format *.shp)
% with coordinates x and y (in this study we used projected coordinates UTM 18s).
%
% The script first processing the information and calculate parameters as 
% flow direction, flow acumulation and longitudinal  profile. After is done
% an ajust of the DEM using CRS tools (Schwanghart and Scherler, 2017). 
% Subsequently run the model again with the new DEM, calculates 
% steepness index (Ksn) and Knickpoints for both watersheds.
%
% Finally is generated the figures: 
% 
% * 1. Concavity (relation between area and slope),
% * 2. longitudinal profile,
% * 3. Map,
% * 4. Union figures 3 and 4.  
% * Also create shpaefiles of Ksn and kninckpoints, compatible SIG format. 
% * Save variables for subsequent statistical analysis using MATLAB o others statistics softwares.
%
% Compilate By Rojas, I (2017).
%% Carging DEM
clc
clear
%Carging las apps
addpath(genpath('C:\topotoolbox-master\topotoolbox-master\TopoToolbox-2'));
format short 
%Carging the DEM 
%other option for this code is open the archive "base.mat"
% Do not execute this code - out of memory.
DEM = GRIDobj('C:\cuencas_18_11_16\srtm_g_cut_topo.tif');
FD  = FLOWobj(DEM,'preprocess','carve');
%% Carging the outlets points (fron here begin the change)
clc
promptg = 'Group watersheds by analyst = '; 
group = input(promptg,'s');
promptE = 'N° Outlet East = '; %Down
E = input(promptE,'s');
promptW = 'N° Outlet West = '; %Up
W=input(promptW,'s'); %This codes is insert outlets using shapefiles
dir_E= ['C:\cuencas_19_07\outlets\' num2str(E) '.shp']; %for example delete the code: num2str(R) or num2str(L)with 001 and 002
dir_W= ['C:\cuencas_19_07\outlets\' num2str(W) '.shp'];
OUT_E = shaperead(dir_E); %R = Right
OUT_W = shaperead(dir_W); %L = Left
% figure(1), hold on                              % Figure test
% imageschs(DEM,DEM);
% geoshow(OUT_R);
% geoshow(OUT_L);
% c_gen = colorbar;
% c_gen.Label.String = 'Elevation (MASL)';
% text([OUT_R.x], [OUT_R.y], R, 'Color', [0 0 0],'clipping', 'on',...
%     'Interpreter','latex');
% text([OUT_L.x], [OUT_L.y], L, 'Color', [0 0 0],'clipping', 'on',...
%     'Interpreter','latex');
% hold off
%% Definition of watersheds fron outlets.
DBCRN_E = drainagebasins(FD,[OUT_E.x],[OUT_E.y]);
DBCRN_W = drainagebasins(FD,[OUT_W.x],[OUT_W.y]);
DEMc_E = crop(DEM,DBCRN_E,NaN);
DEMc_W= crop(DEM,DBCRN_W,NaN);
figure(2), hold on  %figure test
imageschs(DEMc_E,DEMc_E);
imageschs(DEMc_W,DEMc_W);
geoshow(OUT_E);
geoshow(OUT_W);
c_gen = colorbar;
c_gen.Label.String = 'Elevation (MASL)';
text([OUT_E.x], [OUT_E.y], E, 'Color', [0 0 0],'clipping', 'on',...
    'Interpreter','latex');
text([OUT_W.x], [OUT_W.y], W, 'Color', [0 0 0],'clipping', 'on',...
    'Interpreter','latex');
hold off
%% CRS toolbox East
FD_E = FLOWobj(DEMc_E,'preprocess','carve'); 
S_E = STREAMobj(FD_E,'minarea',1000);
crsapp(S_E,DEMc_E)
%% Estimate Ksn East watershed 
A_E = flowacc(FD_E);
DEMc_E = imposemin(FD_E,DEMc_E,0.0001);
S_E = klargestconncomps(S_E,1);
S_E = modify(S_E,'distance',50);
S_E = trunk(S_E);
figure(3), hold on 
STATS_E = slopearea(S_E,DEMc_E,A_E);
hold off
G_E = gradient8(DEMc_E);
KSN_E = G_E./(A_E.*(A_E.cellsize^2)).^STATS_E.theta;
[x,y,ksn] = STREAMobj2XY(S_E,KSN_E);
MS_E = STREAMobj2mapstruct(S_E,'seglength',200,'attributes',...
    {'ksn' KSN_E @mean ...
    'uparea' (A_E.*(A_E.cellsize^2)) @mean ...
    'gradient' G_E @mean});
nrksn_E = numel(MS_E);
for i=1:nrksn_E
    MS_E(i).ksnrel = (MS_E(i).ksn - min([MS_E.ksn]))/(max([MS_E.ksn]) - min([MS_E.ksn]));
    MS_E(i).pt = OUT_E.id;
    fprintf('%u/%u\n',i,nrksn_E)
end
% figure(4), hold on                                       % figure test
symbolspec_E = makesymbolspec('line',...
 {'ksn' [min([MS_E.ksn]) max([MS_E.ksn])] 'color' jet(6) 'LineWidth' 2});
% imageschs(DEMc_R,DEMc_R,'colormap',gray,'colorbar',false);
% mapshow(MS_R,'SymbolSpec',symbolspec_R);
% hold off
%% CRS toolbox West
FD_W = FLOWobj(DEMc_W,'preprocess','carve'); 
S_W = STREAMobj(FD_W,'minarea',1000);
crsapp(S_W,DEMc_W)
%% Estimate Ksn left watershed 
FD_W = FLOWobj(DEMc_W,'preprocess','carve'); 
A_W = flowacc(FD_W);
DEMc_W = imposemin(FD_W,DEMc_W,0.0001);
S_W = STREAMobj(FD_W,'minarea',1000);
S_W = klargestconncomps(S_W,1);
S_W = modify(S_W,'distance',50);
S_W = trunk(S_W);
figure(3), hold on 
STATS_W = slopearea(S_W,DEMc_W,A_W);
hold off
G_W = gradient8(DEMc_W);
KSN_W = G_W./(A_W.*(A_W.cellsize^2)).^STATS_W.theta;
[x,y,ksn] = STREAMobj2XY(S_W,KSN_W);
MS_W = STREAMobj2mapstruct(S_W,'seglength',200,'attributes',...
    {'ksn' KSN_W @mean ...
    'uparea' (A_W.*(A_W.cellsize^2)) @mean ...
    'gradient' G_W @mean});
nrksn_W = numel(MS_W);
for i=1:nrksn_W
    MS_W(i).ksnrel = (MS_W(i).ksn - min([MS_W.ksn]))/(max([MS_W.ksn]) - min([MS_W.ksn]));
    MS_W(i).pt = OUT_W.id;
    fprintf('%u/%u\n',i,nrksn_W)
end
symbolspec_W = makesymbolspec('line',...
     {'ksn' [min([MS_W.ksn]) max([MS_W.ksn])] 'color' jet(6) 'LineWidth' 2});
% figure(6), hold on                                      % figure test
% imageschs(DEMc_L,DEMc_L,'colormap',gray,'colorbar',false);
% mapshow(MS_L,'SymbolSpec',symbolspec_L);
% hold off
%% Estimating knickpoints
% zs_R = quantcarve(S_R,DEMc_R,.5,'split',false); %if the p_* variable no
% found, use the value of carve 
% zs_L = quantcarve(S_L,DEMc_L,.5,'split',false);
zs_E = crs(S_E,DEMc_E,p_E);
zs_W = crs(S_W,DEMc_W,p_W);

    figure(7)
    [zk_E,kp_E] = knickpointfinder(S_E,zs_E,'split',false,'plot',true,'tol',20);
    [zk_W,kp_W] = knickpointfinder(S_W,zs_W,'split',false,'plot',true,'tol',20);
    hold on
    scatter(kp_E.distance,kp_E.z,kp_E.dz,'sk','MarkerFaceColor','r')
    scatter(kp_W.distance,kp_W.z,kp_W.dz,'sk','MarkerFaceColor','r')
    hold off
    
%Generating SHP Kinckpoints
nr_Kp_E = numel(kp_E.n); kinckpoint_E = []; 
for i=1:kp_E.n
    kinckpoint_E(i).Geometry = deal('Point');
    kinckpoint_E(i).id = i;
    kinckpoint_E(i).X = kp_E.x(i);
    kinckpoint_E(i).Y = kp_E.y(i);
    kinckpoint_E(i).distan = kp_E.distance(i);
    kinckpoint_E(i).z = kp_E.z(i); 
    kinckpoint_E(i).IXgrid = kp_E.IXgrid(i); 
    kinckpoint_E(i).order = kp_E.order(i);
    kinckpoint_E(i).dz = kp_E.dz(i);
    kinckpoint_E(i).pt = OUT_E.id;
    fprintf('%u/%u\n',i,nr_Kp_E)
end
fprintf('ready\n')

nr_Kp_W = numel(kp_W.n); kinckpoint_W = []; 
for i=1:kp_W.n
    kinckpoint_W(i).Geometry = deal('Point');
    kinckpoint_W(i).id = i;
    kinckpoint_W(i).X = kp_W.x(i);
    kinckpoint_W(i).Y = kp_W.y(i);
    kinckpoint_W(i).distan = kp_W.distance(i);
    kinckpoint_W(i).z = kp_W.z(i); 
    kinckpoint_W(i).IXgrid = kp_W.IXgrid(i); 
    kinckpoint_W(i).order = kp_W.order(i);
    kinckpoint_W(i).dz = kp_W.dz(i);
    kinckpoint_W(i).pt = OUT_W.id
    
    fprintf('%u/%u\n',i,nr_Kp_W)
end
fprintf('ready\n')
% imageschs(DEM,DEM);                                   %Imagen test
% geoshow(kinckpoint_R,'Marker','o',...
%     'MarkerFaceColor','c','MarkerEdgeColor','k');
% geoshow(kinckpoint_L,'Marker','o',...
%     'MarkerFaceColor','c','MarkerEdgeColor','k');
%% Areas elevation Max y Min and gradients
z_E = getnal(S_E,DEMc_E);
[zmax_E,mask_E] = maplateral(S_E,DEMc_E,100,@max,'excludestream',false);
[zmin_E,mask2_E] = maplateral(S_E,DEMc_E,100,@min,'excludestream',false);
z_W = getnal(S_W,DEMc_W);
[zmax_W,mask_W] = maplateral(S_W,DEMc_W,100,@max,'excludestream',false);
[zmin_W,mask2_W] = maplateral(S_W,DEMc_W,100,@min,'excludestream',false);
g_E = gradient(S_E,zs_E);
g_W = gradient(S_W,zs_W);
%% Figures  
% legends
ley_1 = ['Watershed East ' num2str(OUT_E.id)];
ley_2 = ['Watershed West ' num2str(OUT_W.id)];
ley_3 = ['Knickpoint East ' num2str(OUT_E.id)];
ley_4 = ['Knickpoint West ' num2str(OUT_W.id)];
ley_5 = ['plot East ' num2str(OUT_E.id)];
ley_6 = ['line East ' num2str(OUT_E.id)];
ley_7 = ['plot West ' num2str(OUT_W.id)];
ley_8 = ['line West ' num2str(OUT_W.id)];
% Longitudinal profile
figure(8), hold on
plotdz(S_E,zs_E)
plotdz(S_W,zs_W)
scatter(kp_E.distance,kp_E.z,kp_E.dz,'o','MarkerFaceColor','r')
scatter(kp_W.distance,kp_W.z,kp_W.dz,'o','MarkerFaceColor','r')
plotdzshaded(S_E,[zmax_E zmin_E])
plotdzshaded(S_W,[zmax_W zmin_W])
hold off
legend(ley_1,...
       ley_2,...
       ley_3,...
       ley_4,... 
       'Change elevation channel')
legend('Location','best')
% figure concavity
figure(3), hold on
legend(ley_5,ley_6,ley_7,ley_8)
legend('Location','best')
hold off
% Map
Fault = shaperead('D:\Documents\Recursos_hidricos\TESIS\SHP\LOFS_valentina\Fallas_LOFZ_Maldonado_18s.shp');
figure(10), hold on
imageschs(DEMc_E,mask_E,'truecolor',[0.6 0.6 0.6],...
                   'colorbar',false);
imageschs(DEMc_W,mask_W,'truecolor',[0.6 0.6 0.6],...
                   'colorbar',false);
mapshow(MS_E,'SymbolSpec',symbolspec_E);
mapshow(MS_W,'SymbolSpec',symbolspec_W);
plot(kp_E.x,kp_E.y,'LineStyle','none',...
    'Marker','o',...
    'MarkerFaceColor','r');
plot(kp_W.x,kp_W.y,'LineStyle','none',...
    'Marker','o',...
    'MarkerFaceColor','r');
c = colorbar;
c.Label.String = 'k_{sn}';
xlimits = xlim;
ylimits = ylim;
hold off
figure(10), hold on
mapshow(Fault,'Color', 'black')
legend(ley_3,...
       ley_4)
legend('Location','best')
text([OUT_W.x], [OUT_W.y], '  LOFS', 'Color', [0 0 0],'clipping', 'on',...
    'Interpreter','latex');
xlim(xlimits);
ylim(ylimits);
xlabel('x (in meters)') 
ylabel('y (in meters)') 
hold off
%% Figure integrated
figure(12), 
% Map
subplot(5,1,[1:3]);
hold on
imageschs(DEMc_W,mask_W,'truecolor',[0.6 0.6 0.6],...
                   'colorbar',false);
imageschs(DEMc_E,mask_E,'truecolor',[0.6 0.6 0.6],...
                   'colorbar',false);
mapshow(MS_E,'SymbolSpec',symbolspec_E);
mapshow(MS_W,'SymbolSpec',symbolspec_W);
plot(kp_E.x,kp_E.y,'LineStyle','none',...
    'Marker','o',...
    'MarkerFaceColor','r');
plot(kp_W.x,kp_W.y,'LineStyle','none',...
    'Marker','o',...
    'MarkerFaceColor','r');
lgd_1 = legend(ley_3,...
       ley_4);
lgd_1.Location = 'best';
lgd_1.FontSize = 7;
c = colorbar;
c.FontSize = 7;
c.Label.String = 'k_{sn}';
xlimits = xlim;
ylimits = ylim;
mapshow(Fault,'Color', 'black')
text([OUT_W.x], [OUT_W.y], '  LOFS', 'Color', [0 0 0],'clipping', 'on',...
    'Interpreter','latex');
xlim(xlimits);
ylim(ylimits);
xlabel('x (in meters)') 
ylabel('y (in meters)') 
hold off
% Longitudinal profile
subplot(5,1,[4:5]);
hold on
plotdz(S_E,zs_E)
plotdz(S_W,zs_W)
scatter(kp_E.distance,kp_E.z,kp_E.dz,'o','MarkerFaceColor','r')
scatter(kp_W.distance,kp_W.z,kp_W.dz,'o','MarkerFaceColor','r')
plotdzshaded(S_E,[zmax_E zmin_E])
plotdzshaded(S_W,[zmax_W zmin_W])
hold off
lgd_2 = legend(ley_1,...
       ley_2,...
       ley_3,...
       ley_4,... 
       'Change elevation channel');
lgd_2.Location = 'best';
lgd_2.FontSize = 7;
hold off
%% Saving indicated data
v1 = ['S_E_' num2str(OUT_E.id)];
eval([v1, '= S_E']);
v2 = ['zs_E_' num2str(OUT_E.id)];
eval([v2, '= zs_E']);
v3 = ['kp_E_' num2str(OUT_E.id)];
eval([v3, '= kp_E']);
v4 = ['g_E_' num2str(OUT_E.id)];
eval([v4, '= g_E']);
v5 = ['MS_E_' num2str(OUT_E.id)];
eval([v5, '= MS_E']);
v6 = ['S_W_' num2str(OUT_W.id)];
eval([v6, '= S_W']);
v7 = ['zs_W_' num2str(OUT_W.id)];
eval([v7, '= zs_W']);
v8 = ['kp_W_' num2str(OUT_W.id)];
eval([v8, '= kp_W']);
v9 = ['g_W_' num2str(OUT_W.id)];
eval([v9, '= g_W']);
v10 = ['MS_W_' num2str(OUT_W.id)];
eval([v10, '= MS_W']);
v11 = ['KSN_E_' num2str(OUT_E.id)];
eval([v11, '= KSN_E']);
v12 = ['KSN_W_' num2str(OUT_W.id)];
eval([v12, '= KSN_W']);

dir_var = ['D:\Documents\Recursos_hidricos\TESIS\RESULTADOS\variables\' num2str(group)];
eval(['save dir_var_19_07 ', v1,' ', v2,' ', v3,' ', v4,' ', v5,...
    ' ', v6,' ', v7,' ', v8,' ', v9,' ', v10,' ', v11,' ', v12,' -append']) 
%% Export Knickpoints and Ksn
dir_E_KSN = ['D:\Documents\Recursos_hidricos\TESIS\RESULTADOS\V2_19_07\KSN\' num2str(OUT_E.id) '_E.shp'];
dir_E_Knick = ['D:\Documents\Recursos_hidricos\TESIS\RESULTADOS\V2_19_07\knickpoint\' num2str(OUT_E.id) '_E.shp'];
dir_W_KSN = ['D:\Documents\Recursos_hidricos\TESIS\RESULTADOS\V2_19_07\KSN\' num2str(OUT_W.id) '_W.shp'];
dir_W_Knick = ['D:\Documents\Recursos_hidricos\TESIS\RESULTADOS\V2_19_07\knickpoint\' num2str(OUT_W.id) '_W.shp'];
dir_fig1 = ['D:\Documents\Recursos_hidricos\TESIS\RESULTADOS\V2_19_07\figures\fig_01_' num2str(group) '.png' ];
dir_fig2 = ['D:\Documents\Recursos_hidricos\TESIS\RESULTADOS\V2_19_07\figures\fig_02_' num2str(group) '.png' ];
dir_fig3 = ['D:\Documents\Recursos_hidricos\TESIS\RESULTADOS\V2_19_07\figures\fig_03_' num2str(group) '.png' ];
dir_fig4 = ['D:\Documents\Recursos_hidricos\TESIS\RESULTADOS\V2_19_07\figures\fig_04_' num2str(group) '.png' ];
dir_fig3_4 = ['D:\Documents\Recursos_hidricos\TESIS\RESULTADOS\V2_19_07\figures\fig_03_04_' num2str(group) '.png' ];
shapewrite(MS_E,dir_E_KSN);
shapewrite(MS_W,dir_W_KSN);
shapewrite(kinckpoint_E,dir_E_Knick);
shapewrite(kinckpoint_W,dir_W_Knick);
%save(dir_var);
saveas(figure(2),dir_fig1);
saveas(figure(3),dir_fig2);
saveas(figure(8),dir_fig3);
saveas(figure(10),dir_fig4);   
saveas(figure(12),dir_fig3_4); 
