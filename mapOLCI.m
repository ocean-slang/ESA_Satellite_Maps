%% Read data
cd '/Volumes/slangSSD/Documents/smode_pilot_olci/';

% Add functions to path
addpath('/Volumes/slangSSD/Documents/smode_pilot_olci/functions')
addpath('/Volumes/slangSSD/Documents/smode_pilot_olci/functions/m_map')
load coastlines

% Loop Through Directory
sdir = dir('/Volumes/slangSSD/Documents/smode_pilot_olci/data/*SEN3');
spath = '/Volumes/slangSSD/Documents/smode_pilot_olci/data/';

%% Note: ESA's data structure is different than NASA's.
%% NASA has one NetCDF for all parameters, ESA uses different NetCDFs for each parameter
%% Read data
for file = 1:length(sdir)
    
    cd(spath)
    % Read Files
    filename = sdir(file).name;

        %'log10 scaled (Neural Net) Algal pigment concentration'
        chl_nn_1=ncread([filename,'/chl_nn.nc'],'CHL_NN');
        %'log10 scaled (OC4ME) Algal pigment concentration'
        chl_ocme=ncread([filename,'/chl_oc4me.nc'],'CHL_OC4ME');
        %latitude and longitude
        lat=ncread([filename,'/geo_coordinates.nc'],'latitude');
        lon=ncread([filename,'/geo_coordinates.nc'],'longitude');
        %'log10 scaled (Neural Net) CDM absorption coefficient'
        log10_cdom_a_coeff=ncread([filename,'/iop_nn.nc'],'ADG443_NN');
        %'Integrated water vapour column above the current pixel'
        iwv=ncread([filename,'/iwv.nc'],'IWV');
        %add lines to include whatever other parameters you are interested.

    LATLIMS=[28 42];
    LONLIMS=[-130 -116];
    
    %get date for plot titles
    year=str2double(filename(17:20));
    month=str2double(filename(21:22));
    day=str2double(filename(23:24));
    date=datestr(datetime(year,month,day));
    
    index=chl_nn_1<1.5; %mask values that are too high, log scale, these are clouds. ESA flags missed some clouds.
    chl_nn=chl_nn_1.*index;
    chl_nn(chl_nn==0)=NaN;
    
    figure()
    m_proj('Mercator','lon',LONLIMS,'lat',LATLIMS);
    m_pcolor(lon, lat, chl_nn);shading flat;
    m_grid('linewi',2,'tickdir','out');
    h=colorbar;
    m_coast('linewidth',0.5,'color','k');
    set(get(h,'ylabel'),'String','Chlorophyll-a (mg/m^{3})');
    caxis([0 1])
    ylabel('Latitude ( Â°)')
    xlabel('Longitude ( Â°)')
    title([date,' OLCI Chlorophyll-a (Neural Net)'])
    set(gca,'FontSize',14);  
    print(gcf,[date,'_olci_chl_nn.pdf'],'-dpdf','-r300');     
end