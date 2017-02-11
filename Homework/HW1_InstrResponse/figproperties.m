% box on
 set(gca,'fontsize',fsize,'linewidth',1);
 
 
% set(get(gca,'YLabel'),'fontsize',fsize);
% set(get(gca,'Title'),'fontsize',fsize);
% set(gcf,'Color','w');
% set(gcf,'PaperPositionMode','auto')

%set( findall( gcf, '-property', 'Interpreter' ), 'Interpreter', 'Latex' );
 set( findall( gcf, '-property', 'TickLabelInterpreter' ), 'TickLabelInterpreter', 'Latex' );

set( findall( gcf, '-property', 'FontSize' ), 'FontSize', fsize);
%set( findall( gcf, '-property', 'FontWeight' ), 'FontWeight', 'Bold' );
set( findall( gcf, '-property', 'LineWidth' ), 'LineWidth', 2 );