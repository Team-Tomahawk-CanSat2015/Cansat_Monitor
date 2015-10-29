 axe = 30;
fig_ax = axes ('XLim', [-axe, axe], 'YLim', [-axe, axe], 'ZLim', [-axe+10, axe+10]);
% axis ([-axe, axe,-axe, axe, -axe+10, axe+10]); 

hold on;
%Next----create shape
lenght = 4; teta = pi/6; k =0; height = 30;
 x_pts_bplate = [lenght*cos(teta), lenght*cos(teta), 0, -lenght*cos(teta), -lenght*cos(teta), 0];
 y_pts_bplate = [lenght*sin(teta), -lenght*sin(teta), -lenght, -lenght*sin(teta), lenght*sin(teta), lenght];
 z_pts_bplate = [0, 00, 00, 00, 00, 00] ;
 k (1) = fill3 (x_pts_bplate, y_pts_bplate, z_pts_bplate, [0 0 0.5]);
 %tOP PLATE
 x_pts_Tplate = [lenght*cos(teta), lenght*cos(teta), 0, -lenght*cos(teta), -lenght*cos(teta), 0];
 y_pts_Tplate = [lenght*sin(teta), -lenght*sin(teta), -lenght, -lenght*sin(teta), lenght*sin(teta), lenght];
 z_pts_Tplate = [0+height, 00+height, 00+height, 00+height, 00+height, 00+height] ;
 k(2) = fill3 (x_pts_Tplate, y_pts_Tplate, z_pts_Tplate, [0 0 0.5]);

 for i = 2:1:numel(x_pts_Tplate)
side_x = [x_pts_bplate(i-1), x_pts_Tplate(i-1), x_pts_Tplate(i), x_pts_bplate(i)];
side_y = [y_pts_bplate(i-1),y_pts_Tplate(i-1), y_pts_Tplate(i),  y_pts_bplate(i)];               
side_z = [z_pts_bplate(i-1),z_pts_Tplate(i-1), z_pts_Tplate(i), z_pts_bplate(i)]; 
k(i+1) = fill3 (side_x, side_y, side_z, [0 1 0]);
 end   
 line ([0, 0], [0, 0], [-100, 100]); line ([0, 0], [-100, 100], [height/2,height/2]); line ([-100, 100], [0, 0], [height/2,height/2]);
 camproj ('perspective');  grid;  view (3); figure.Renderer = 'opengl';
 zlabel('<---  Direction of Descent'); ylabel('y axis'); xlabel('X axis'); title('Angle of descent is the angle between CANSAT"s Zaxis and descent direction.')
 hold off;
 cansat = hgtransform ('Parent',fig_ax);
 set ( k, 'Parent', cansat );drawnow;

  while (ishandle(fig_ax) == 1)
 %       actualXrotate= makehgtform ('xrotate', Xrotate(end)*0.1);
 %       set (hgTransform, 'Matrix', actualXrotate);%Xtransform here  %drawnow ();
        Table = get (handles.uitable3, 'Data');
        Xrotate = cell2mat (Table (5,:));
        Yrotate = cell2mat (Table (6,:));
        Zrotate = cell2mat (Table (7,:));
        actualrotate= makehgtform ('xrotate',Xrotate(end),'yrotate',Yrotate(end),'zrotate',Zrotate(end));
        set (hgTransform, 'Matrix', actualrotate);   drawnow();
  end