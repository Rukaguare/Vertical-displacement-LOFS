%This code presents a series of codes used for the elaboration of figures, which contrasted the variables Left -Right. Based on Topo-Toolbox tools.
%https://topotoolbox.wordpress.com

% Figure 1 Graphic metodology
figure(1), hold on

plotdz(S_E_27,zs_E_27,'color','b','linewidth',0.1);
scatter(kp_E_27.distance,kp_E_27.z,kp_E_27.dz,'o','MarkerFaceColor','r')

plotdz(S_W_24,zs_W_24,'color','g','linewidth',0.1,'distance',S_W_24.distance*-1);
scatter([kp_W_24.distance*-1],kp_W_24.z,kp_W_24.dz,'o','MarkerFaceColor','r');

figure(1), hold off

%% Variation of figure 1, with gradient NOt execute

plotdz(S_E_27,zs_E_27,'color','b','linewidth',0.1);
scatter(kp_E_27.distance,kp_E_27.z,kp_E_27.dz,'o','MarkerFaceColor','r')

plotdz(S_W_24,zs_W_24,'color','g','linewidth',0.1,'distance',S_W_24.distance*-1);
scatter([kp_W_24.distance*-1],kp_W_24.z,kp_W_24.dz,'o','MarkerFaceColor','r');

plotdz(S_E_27,g_E_27,'color','b','linewidth',0.1);
plotdz(S_W_24,g_W_24,'color','g','linewidth',0.1,'distance',S_W_24.distance*-1);

figure(1), hold off

%% Figure 2 grafics E-W
nr = 125; v1 = [];v2 = []; g1 = [];

figure(2), hold on
%East
for i= [4,6,8,12,15,17,19,21,23,27,28,34,39,47,48,51,52,58,62,66,70,77,...
        83,86,89,92,94,97,98,100,104,106,108,110,112,115,116,119,121,...
        123,125,10,37,40,43,44,55,64,69,73,79,78,81,90,35]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''b'',''linewidth'',0.1);']) 

    fprintf('%u/%u\n',i,nr)
end
figure(2), hold off

%West
figure(2), hold on
for i= [3,5,9,11,13,16,18,20,22,24,29,32,38,46,49,50,56,59,61,65,67,72,...
        80,85,91,93,95,96,99,101,105,107,109,111,113,114,117,118,120,...
        122,124,7,33,41,42,45,53,63,68,76,74,75,82,88,36]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''g'',''linewidth'',0.1,''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(2), hold off
%% figure 3, grafics E-W, adjust lowest elevation

figure(3), hold on
%East
for i= [4,6,8,12,15,17,19,21,23,27,28,34,39,47,48,51,52,58,62,66,70,77,...
        83,86,89,92,94,97,98,100,104,106,108,110,112,115,116,119,121,...
        123,125,10,37,40,43,44,55,64,69,73,79,78,81,90,35]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',[' v2 ' - min(' v2 ')],''color'',''b'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% West
figure(3), hold on
for i= [3,5,9,11,13,16,18,20,22,24,29,32,38,46,49,50,56,59,61,65,67,72,...
        80,85,91,93,95,96,99,101,105,107,109,111,113,114,117,118,120,...
        122,124,7,33,41,42,45,53,63,68,76,74,75,82,88,36]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',[' v2 ' - min(' v2 ')],''color'',''m'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off
%% figure 4-5. General analyst histograms of channels
clc
zs_E_general = vertcat(zs_E_10, zs_E_100, zs_E_104, zs_E_106, zs_E_108, zs_E_110, zs_E_112, zs_E_115, zs_E_116, zs_E_119, zs_E_12, zs_E_121, zs_E_123, zs_E_125, zs_E_15, zs_E_17, zs_E_19, zs_E_21, zs_E_23, zs_E_27, zs_E_28, zs_E_34, zs_E_35, zs_E_37, zs_E_39, zs_E_4, zs_E_40, zs_E_43, zs_E_44, zs_E_47, zs_E_48, zs_E_51, zs_E_52, zs_E_55, zs_E_58, zs_E_6, zs_E_62, zs_E_64, zs_E_66, zs_E_69, zs_E_70, zs_E_73, zs_E_77, zs_E_78, zs_E_79, zs_E_8, zs_E_81, zs_E_82, zs_E_83, zs_E_86, zs_E_89, zs_E_90, zs_E_92, zs_E_94, zs_E_97, zs_E_98)
S_E_general = vertcat(S_E_10.distance, S_E_100.distance, S_E_104.distance, S_E_106.distance, S_E_108.distance, S_E_110.distance, S_E_112.distance, S_E_115.distance, S_E_116.distance, S_E_119.distance, S_E_12.distance, S_E_121.distance, S_E_123.distance, S_E_125.distance, S_E_15.distance, S_E_17.distance, S_E_19.distance, S_E_21.distance, S_E_23.distance, S_E_27.distance, S_E_28.distance, S_E_34.distance, S_E_35.distance, S_E_37.distance, S_E_39.distance, S_E_4.distance, S_E_40.distance, S_E_43.distance, S_E_44.distance, S_E_47.distance, S_E_48.distance, S_E_51.distance, S_E_52.distance, S_E_55.distance, S_E_58.distance, S_E_6.distance, S_E_62.distance, S_E_64.distance, S_E_66.distance, S_E_69.distance, S_E_70.distance, S_E_73.distance, S_E_77.distance, S_E_78.distance, S_E_79.distance, S_E_8.distance, S_E_81.distance, S_E_82.distance, S_E_83.distance, S_E_86.distance, S_E_89.distance, S_E_90.distance, S_E_92.distance, S_E_94.distance, S_E_97.distance, S_E_98.distance)

zs_W_general = vertcat(zs_W_99, zs_W_96, zs_W_95, zs_W_93, zs_W_91, zs_W_9, zs_W_88, zs_W_85, zs_W_82, zs_W_80, zs_W_76, zs_W_75, zs_W_74, zs_W_72, zs_W_7, zs_W_68, zs_W_67, zs_W_65, zs_W_63, zs_W_61, zs_W_59, zs_W_56, zs_W_53, zs_W_50, zs_W_5, zs_W_49, zs_W_46, zs_W_45, zs_W_42, zs_W_41, zs_W_38, zs_W_36, zs_W_33, zs_W_32, zs_W_3, zs_W_29, zs_W_24, zs_W_22, zs_W_20, zs_W_18, zs_W_16, zs_W_13, zs_W_124, zs_W_122, zs_W_120, zs_W_118, zs_W_117, zs_W_114, zs_W_113, zs_W_111, zs_W_11, zs_W_109, zs_W_107, zs_W_105, zs_W_101)
S_W_general = vertcat(S_W_99.distance, S_W_96.distance, S_W_95.distance, S_W_93.distance, S_W_91.distance, S_W_9.distance, S_W_88.distance, S_W_85.distance, S_W_82.distance, S_W_80.distance, S_W_76.distance, S_W_75.distance, S_W_74.distance, S_W_72.distance, S_W_7.distance, S_W_68.distance, S_W_67.distance, S_W_65.distance, S_W_63.distance, S_W_61.distance, S_W_59.distance, S_W_56.distance, S_W_53.distance, S_W_50.distance, S_W_5.distance, S_W_49.distance, S_W_46.distance, S_W_45.distance, S_W_42.distance, S_W_41.distance, S_W_38.distance, S_W_36.distance, S_W_33.distance, S_W_32.distance, S_W_3.distance, S_W_29.distance, S_W_24.distance, S_W_22.distance, S_W_20.distance, S_W_18.distance, S_W_16.distance, S_W_13.distance, S_W_124.distance, S_W_122.distance, S_W_120.distance, S_W_118.distance, S_W_117.distance, S_W_114.distance, S_W_113.distance, S_W_111.distance, S_W_11.distance, S_W_109.distance, S_W_107.distance, S_W_105.distance, S_W_101.distance)

figure(4), hold on
hist(zs_E_general)
hist(zs_W_general)
hold off

figure(5), hold on
hist(S_E_general)
hist(S_W_general)
hold off
%% figure 6, change slope grdient
figure(6), hold on
%East
for i= [4,6,8,12,15,17,19,21,23,27,28,34,39,47,48,51,52,58,62,66,70,77,...
        83,86,89,92,94,97,98,100,104,106,108,110,112,115,116,119,121,...
        123,125,10,37,40,43,44,55,64,69,73,79,78,81,90,35]
    v1 = ['S_E_' num2str(i)];
    v2 = ['g_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''b'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(6), hold off

%West

figure(6), hold on
for i= [3,5,9,11,13,16,18,20,22,24,29,32,38,46,49,50,56,59,61,65,67,72,...
        80,85,91,93,95,96,99,101,105,107,109,111,113,114,117,118,120,...
        122,124,7,33,41,42,45,53,63,68,76,74,75,82,88,36]
    v1 = ['S_W_' num2str(i)];
    v2 = ['g_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''m'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(6), hold off 
%% MEch estimator
%East
format bank
Mech = [];
for i= [4,6,8,12,15,17,19,21,23,27,28,34,39,47,48,51,52,58,62,66,70,77,...
        83,86,89,92,94,97,98,100,104,106,108,110,112,115,116,119,121,...
        123,125,10,37,40,43,44,55,64,69,73,79,78,81,90,35];
    v2 = ['zs_E_' num2str(i)];
    Mech(i).id = i;
    Mech(i).location = 'E';
    Mech(i).Mech = eval (['max(' v2 ')']);
    fprintf('%u/%u\n',i,nr)
end
%West
for i= [3,5,9,11,13,16,18,20,22,24,29,32,38,46,49,50,56,59,61,65,67,72,...
        80,85,91,93,95,96,99,101,105,107,109,111,113,114,117,118,120,...
        122,124,7,33,41,42,45,53,63,68,76,74,75,82,88,36]
    v2 = ['zs_W_' num2str(i)];
   Mech(i).id = i;
    Mech(i).location = 'W';
    Mech(i).Mech = eval (['max(' v2 ')']);
    fprintf('%u/%u\n',i,nr)
end

format bank
%% Code for extract distance shortest of knickpoint 
%Right
format bank
Dist = []; v3 = [];
for i= [102,104,106,114,117,121,129,133,135,138,14,140,142,147,17,19,2,21,...
        23,26,27,29,34,36,4,42,43,47,50,52,64,67,69,70,74,76,79,8,81,85,87,...
        90,94,99];
    v3 = ['kp_R_' num2str(i)];
    Dist(i).id = i;
    Dist(i).group = [];
    Dist(i).location = 'R';
    Dist(i).x = eval (['min(' v3 '.distance)']);
    Dist(i).X = round(Dist(i).x);
    if Dist(i).X <= []; 
        Dist(i) = []
    else Dist(i).X
    end
    fprintf('%u/%u\n',i,nr)
end
%Left
for i= [1,100,101,103,107,115,116,125,13,130,132,134,139,141,143,146,16,...
        18,20,22,25,28,3,30,33,35,44,45,46,49,53,65,66,68,7,71,75,78,80,...
        84,86,91,93]
    v3 = ['kp_L_' num2str(i)];
    Dist(i).id = i;
    Dist(i).group = [];
    Dist(i).location = 'L';
    Dist(i).x = eval(['min(' v3 '.distance)']);
    Dist(i).X = round(Dist(i).x);
    if Dist(i).X <= []; 
        Dist(i) = []
    else Dist(i).X
    end
    fprintf('%u/%u\n',i,nr)
end

format bank

%% SLOPE TEST
%East
format bank
slope = []; v3 = [];
for i= [4,6,8,12,15,17,19,21,23,27,28,34,39,47,48,51,52,58,62,66,70,77,...
        83,86,89,92,94,97,98,100,104,106,108,110,112,115,116,119,121,...
        123,125,10,37,40,43,44,55,64,69,73,79,78,81,90,35];
    v3 = ['kp_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    slope(i).id = i;
    slope(i).location = 'E';
    slope(i).x = eval (['min(' v3 '.distance)']);
    slope(i).z = eval (['min(' v3 '.z) - min(' v2 ')']);
    slope(i).xs = eval (['max(' v2 ')']);
    if slope(i).x <= []; 
        slope(i) = []
    else slope(i).x
    end
    fprintf('%u/%u\n',i,nr)
end
%West
for i= [3,5,9,11,13,16,18,20,22,24,29,32,38,46,49,50,56,59,61,65,67,72,...
        80,85,91,93,95,96,99,101,105,107,109,111,113,114,117,118,120,...
        122,124,7,33,41,42,45,53,63,68,76,74,75,82,88,36]
    v3 = ['kp_L_' num2str(i)];
    v2 = ['zs_L_' num2str(i)];
    slope(i).id = i;
    slope(i).location = 'W';
    slope(i).x = eval(['min(' v3 '.distance)']);
    slope(i).z = eval (['min(' v3 '.z) - min(' v2 ')']);
    slope(i).xs = eval (['max(' v2 ')']);
    if slope(i).x <= []; 
        slope(i) = []
    else slope(i).x
    end
    fprintf('%u/%u\n',i,nr)
end

format bank

%% Prueba falla paralela centro 3
nr = 125; v1 = [];v2 = []; g1 = [];

figure(2), hold on
%East
for i= [77,73,79,78]
    v1 = ['S_E_' num2str(i)];
    v2 = ['g_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''b'');']) 
    fprintf('%u/%u\n',i,nr)
end
figure(2), hold off

%West
figure(2), hold on
for i= [72,76,74,75]
    v1 = ['S_W_' num2str(i)];
    v2 = ['g_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''m'',''distance'',[' v1 '.distance*-1]);'])

    fprintf('%u/%u\n',i,nr)
end
figure(2), hold off

%%

zs_E_general = vertcat(zs_E_73, zs_E_77, zs_E_78, zs_E_79)
S_E_general = vertcat(S_E_73.distance, S_E_77.distance, S_E_78.distance, S_E_79.distance)

zs_W_general = vertcat(zs_W_76, zs_W_75, zs_W_74, zs_W_72)
S_W_general = vertcat(S_W_76.distance, S_W_75.distance, S_W_74.distance, S_W_72.distance)

figure(4), hold on
hist(zs_E_general)
hist(zs_W_general)
hold off

figure(5), hold on
hist(S_E_general)
hist(S_W_general)
hold off

%% Code Figures reference 
nr = 125; v1 = [];v2 = []; g1 = [];

figure(2), hold on
%East
for i= [4,6,8,12,15,17,19,21,23,27,28,34,39,47,48,51,52,58,62,66,70,77,...
        83,86,89,92,94,97,98,100,104,106,108,110,112,115,116,119,121,...
        123,125,10,37,40,43,44,55,64,69,73,79,78,81,90,35]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''b'',''linewidth'',0.1);']) 

    fprintf('%u/%u\n',i,nr)
end
figure(2), hold off

%West
figure(2), hold on
for i= [3,5,9,11,13,16,18,20,22,24,29,32,38,46,49,50,56,59,61,65,67,72,...
        80,85,91,93,95,96,99,101,105,107,109,111,113,114,117,118,120,...
        122,124,7,33,41,42,45,53,63,68,76,74,75,82,88,36]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''g'',''linewidth'',0.1,''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(2), hold off
%% figure 3, grafics E-W, adjust lowest elevation
nr = 125; v1 = [];v2 = []; g1 = [];
figure(3), hold on

% longitudinal profile

%East
for i= [4,6,8,10,17,21]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 1 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% West
figure(3), hold on
for i= [3,5,7,9,16,20]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 0 1]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% longitudinal profile relation
%East

figure(3), hold on
for i= [15]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0.9 0 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% West
figure(3), hold on
for i= [13]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0.9 0 0]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end


%Knickpoints
figure(3), hold on
%East
for i= [4,6,8,10,15,17,21]
    v1 = ['kp_E_' num2str(i)];
    eval (['scatter(' v1 '.distance,' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',''r'',''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

figure(3), hold on
%West
for i= [3,5,7,9,13,16,20]
    v1 = ['kp_W_' num2str(i)];
    eval (['scatter([' v1 '.distance*-1],' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',''r'',''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%% figure 4, grafics E-W, adjust lowest elevation
nr = 125; v1 = [];v2 = []; g1 = [];
figure(4), hold on

% longitudinal profile

%East
for i= [62,64]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 1 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(4), hold off

% West
figure(4), hold on
for i= [63,61]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 0 1]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(4), hold off

%Knickpoints
figure(4), hold on
%East
for i= [62,64]
    v1 = ['kp_E_' num2str(i)];
    eval (['scatter(' v1 '.distance,' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',''r'',''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(4), hold off

figure(4), hold on
%West
for i= [61,63]
    v1 = ['kp_W_' num2str(i)];
    eval (['scatter([' v1 '.distance*-1],' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',''r'',''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(4), hold off

%% Figure explicative hypotesis 

nr = 125; v1 = [];v2 = []; g1 = [];
figure(5), hold on

% longitudinal profile

%East
for i= [39,40,43,44]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 1 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(5), hold off

% West
figure(5), hold on
for i= [38,41,42,45]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 0 1]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(5), hold off

%Knickpoints
figure(5), hold on
%East
for i= [39,40,43,44]
    v1 = ['kp_E_' num2str(i)];
    eval (['scatter(' v1 '.distance,' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',''r'',''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(5), hold off

figure(5), hold on
%West
for i= [38,41,42,45]
    v1 = ['kp_W_' num2str(i)];
    eval (['scatter([' v1 '.distance*-1],' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',''r'',''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(5), hold off

%East
figure(5), hold on
for i= [39,40,43,44]
    v1 = ['S_E_' num2str(i)];
    v2 = ['g_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 1 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(5), hold off

% West
figure(5), hold on
for i= [38,41,42,45]
    v1 = ['S_W_' num2str(i)];
    v2 = ['g_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 0 1]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(5), hold off

%% figure 6, grafics E-W, Zone 2
nr = 125; v1 = [];v2 = []; g1 = [];
figure(3), hold on

% longitudinal profile

%East
for i= [4,6,8,10,12,15,17,19,21,23,115,116,123]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 1 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% West
figure(3), hold on
for i= [3,5,7,9,11,13,16,18,20,22,114,117,122]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 0 1]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%Knickpoints
figure(3), hold on
%East
for i= [4,6,8,10,12,15,17,19,21,23,115,116,123]
    v1 = ['kp_E_' num2str(i)];
    eval (['scatter(' v1 '.distance,' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',''r'',''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

figure(3), hold on
%West
for i= [3,5,7,9,11,13,16,18,20,22,114,117,122]
    v1 = ['kp_W_' num2str(i)];
    eval (['scatter([' v1 '.distance*-1],' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',''r'',''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%% figure 6, grafics E-W, Zone 2 classifiqued by fauls
nr = 125; v1 = [];v2 = [];v3 = [];v4 = []; g1 = [];

%Estero Francisco
% longitudinal profile 

%East
figure(3), hold on

for i= [4,6]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 0 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% West
figure(3), hold on
for i= [3,5]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 0 0]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%Knickpoints
figure(3), hold on
%East
for i= [4,6]
    v1 = ['kp_E_' num2str(i)];
    eval (['scatter(' v1 '.distance,' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 0 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

figure(3), hold on
%West
for i= [3,5]
    v1 = ['kp_W_' num2str(i)];
    eval (['scatter([' v1 '.distance*-1],' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 0 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% Riescos 
% longitudinal profile

%East
figure(3), hold on
for i= [8,10,15,21]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 1 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% West
figure(3), hold on
for i= [9,7,13,20]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 1 0]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%Knickpoints
figure(3), hold on
%East
for i= [8,10,15,21]
    v1 = ['kp_E_' num2str(i)];
    eval (['scatter(' v1 '.distance,' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[0 1 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

figure(3), hold on
%West
for i= [9,7,13,20]
    v1 = ['kp_W_' num2str(i)];
    eval (['scatter([' v1 '.distance*-1],' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[0 1 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off
%%
% Quitralco
% longitudinal profile 

%East
figure(3), hold on
plotdz(S_E_17,zs_E_17,'color',[0 0 1]);
figure(3), hold off

% West
figure(3), hold on
plotdz(S_W_16,zs_W_16,'color',[0 0 1],'distance',[S_W_16.distance*-1]);
figure(3), hold off

%Knickpoints
figure(3), hold on
%East
scatter(kp_E_17.distance,kp_E_17.z,kp_E_17.dz,'o','MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 0]);
figure(3), hold off

figure(3), hold on
%West
scatter([kp_W_16.distance*-1],kp_W_16.z,kp_W_16.dz,'o','MarkerFaceColor',[0 0 1],'MarkerEdgeColor',[0 0 0]);
figure(3), hold off

%%
% Rio Cuervo
% longitudinal profile 

%East
figure(3), hold on
plotdz(S_E_115,zs_E_115,'color',[0 1 1]);
figure(3), hold off

% West
figure(3), hold on
plotdz(S_W_114,zs_W_114,'color',[0 1 1],'distance',[S_W_114.distance*-1]);
figure(3), hold off

%Knickpoints
figure(3), hold on
%East
scatter(kp_E_115.distance,kp_E_115.z,kp_E_115.dz,'o','MarkerFaceColor',[0 1 1],'MarkerEdgeColor',[0 0 0]);
figure(3), hold off

figure(3), hold on
%West
scatter([kp_W_114.distance*-1],kp_W_114.z,kp_W_114.dz,'o','MarkerFaceColor',[0 1 1],'MarkerEdgeColor',[0 0 0]);
figure(3), hold off


% Main Fault
% longitudinal profile

%East
figure(3), hold on
for i= [116,123,19]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 1 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% West
figure(3), hold on
for i= [117,122,18]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 1 0]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%Knickpoints
figure(3), hold on
%East
for i= [116,123,19]
    v1 = ['kp_E_' num2str(i)];
    eval (['scatter(' v1 '.distance,' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 1 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

figure(3), hold on
%West
for i= [117,122,18]
    v1 = ['kp_W_' num2str(i)];
    eval (['scatter([' v1 '.distance*-1],' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 1 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% Others
% longitudinal profile

%East
figure(3), hold on
for i= [12,23]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 0 1]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% West
figure(3), hold on
for i= [11,22]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 0 1]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%Knickpoints
figure(3), hold on
%East
for i= [12,23]
    v1 = ['kp_E_' num2str(i)];
    eval (['scatter(' v1 '.distance,' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 0 1],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

figure(3), hold on
%West
for i= [11,22]
    v1 = ['kp_W_' num2str(i)];
    eval (['scatter([' v1 '.distance*-1],' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 0 1],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%%
%gradient

%East
figure(3), hold on
for i= [4,6,8,10,12,15,17,19,21,23,115,116,123]
    v1 = ['S_E_' num2str(i)];
    v2 = ['g_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 1 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% West
figure(3), hold on
for i= [3,5,7,9,11,13,16,18,20,22,114,117,122]
    v1 = ['S_W_' num2str(i)];
    v2 = ['g_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[0 0 1]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%% Zone 3 profiles
nr = 125; v1 = [];v2 = [];v3 = [];v4 = []; g1 = [];

%East
figure(3), hold on

for i= [27,28,34,35,37,39,40,43,44,47,48,51,98,121]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 0 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% West
figure(3), hold on
for i= [24,29,32,33,36,38,41,42,45,46,49,50,99,120]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 0 0]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%Knickpoints
figure(3), hold on
%East
for i= [27,28,34,35,37,39,40,43,44,47,48,51,98,121]
    v1 = ['kp_E_' num2str(i)];
    eval (['scatter(' v1 '.distance,' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 0 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

figure(3), hold on
%West
for i= [24,29,32,33,36,38,41,42,45,46,49,50,99,120]
    v1 = ['kp_W_' num2str(i)];
    eval (['scatter([' v1 '.distance*-1],' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 0 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%% Zone 4 profiles
nr = 125; v1 = [];v2 = [];v3 = [];v4 = []; g1 = [];

%East
figure(3), hold on

for i= [52,55,58,62,64,66,69,70,100,119,125]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 0 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% West
figure(3), hold on
for i= [53,56,59,61,63,65,67,68,101,118,124]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 0 0]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%Knickpoints
figure(3), hold on
%East
for i= [52,55,58,62,64,66,69,70,100,119,125]
    v1 = ['kp_E_' num2str(i)];
    eval (['scatter(' v1 '.distance,' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 0 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

figure(3), hold on
%West
for i= [53,56,59,61,63,65,67,68,101,118,124]
    v1 = ['kp_W_' num2str(i)];
    eval (['scatter([' v1 '.distance*-1],' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 0 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%% Zone 5 profiles
nr = 125; v1 = [];v2 = [];v3 = [];v4 = []; g1 = [];

%East
figure(3), hold on

for i= [73,77,78,79]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 0 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% West
figure(3), hold on
for i= [72,74,75,76]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 0 0]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%Knickpoints
figure(3), hold on
%East
for i= [73,77,78,79]
    v1 = ['kp_E_' num2str(i)];
    eval (['scatter(' v1 '.distance,' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 0 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

figure(3), hold on
%West
for i= [72,74,75,76]
    v1 = ['kp_W_' num2str(i)];
    eval (['scatter([' v1 '.distance*-1],' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 0 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%% Zone 6 profiles
nr = 125; v1 = [];v2 = [];v3 = [];v4 = []; g1 = [];

%East
figure(3), hold on

for i= [73,77,78,79]
    v1 = ['S_E_' num2str(i)];
    v2 = ['zs_E_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 0 0]'');']) 

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

% West
figure(3), hold on
for i= [72,74,75,76]
    v1 = ['S_W_' num2str(i)];
    v2 = ['zs_W_' num2str(i)];
    eval (['plotdz(' v1 ',' v2 ',''color'',''[1 0 0]'',''distance'',[' v1 '.distance*-1]);'])  

    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

%Knickpoints
figure(3), hold on
%East
for i= [73,77,78,79]
    v1 = ['kp_E_' num2str(i)];
    eval (['scatter(' v1 '.distance,' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 0 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off

figure(3), hold on
%West
for i= [72,74,75,76]
    v1 = ['kp_W_' num2str(i)];
    eval (['scatter([' v1 '.distance*-1],' v1 '.z,' v1 '.dz,''o'',''MarkerFaceColor'',[1 0 0],''MarkerEdgeColor'',[0 0 0]);']);
    fprintf('%u/%u\n',i,nr)
end
figure(3), hold off
