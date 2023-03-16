a=42163000; % GEO Satellite Altitude from Earth Surface
re=6378100; % Earth Radius in Meters (m)
hp=24372000;
E=0;
e=0.27;
lper=96;

S1=1;
r0=re+hp; % GEO Satellite Distance from Earth Centre

omega=268.6;
i=64.3;
t=0;

fo=acos((cos(E)-e)/(1-(e*cos(E))));

Lper=asin(sin(omega)*sin(i));
Lssp=asin(sin(omega+fo)*sin(i));

D1=acos((cos(omega))/(cos(Lper)));
D2=acos((cos(omega+fo))/(cos(Lssp)));
D3=t*0.250684;

lssp=lper+1*(D1+D2)-D3;

les = 77.23;       % Earth Station Longitude
Les = 38.37;         % Earth Station Latitude

lrel=lssp-les;

disp(['GEO Satellite Longitude (Sub-Satellite Point) = ' num2str(lssp)])
disp(['Earth Station Longitude = ' num2str(les)])
disp(['Earth Station Latitude = ' num2str(Les)])
disp(['Relative Longitude (l_rel=lssp-les) = ' num2str(lrel)])


figure()
CL = load('coastlines'); % CL = load('coast');
axesm('MapProjection','eqdcylin','Grid','on','MeridianLabel','on',...
    'MLabelParallel','north','ParallelLabel','on','Frame','on',...
    'FontWeight','Bold')
plotm(CL.coastlat, CL.coastlon) % plotm(CL.lat, CL.long);
hold on; axis off;
GS=plotm(Les,les,'rs','MarkerSize',10,'MarkerFaceColor','r');
SAT=plotm(Lssp,lssp,'mo','MarkerSize',10,'MarkerFaceColor','m');
linem([Les; 0],[les; lssp],'g-','LineWidth',2)
linem([+90; -90],[les; les],'r--','LineWidth',0.5)
linem([Les; Les; Les; Les],[-180; -abs(les); abs(les); 180],...
    'r--','LineWidth',0.5)
% geoshow('landareas.shp', 'FaceColor', [0.5 1.0 0.5]);
legend([GS,SAT],'Earth Station','GEO SAT SSP','Location','BestOutside',...
    'Box','off','Orientation','horizontal')