

clear all;
close all;
load response_compre_config_training.mat
S=response_compre_config_training;

[m, n] = size(S);
[X, Y] = meshgrid(1:m, 1:n);

nonzeroInd = find(S);
[x, y] = ind2sub([m n], nonzeroInd);
hold off;
hp = patch(x, y, S(nonzeroInd), ...
           'Marker', 'd', 'MarkerFaceColor', [0.3 0.3 0.4], 'MarkerSize', 10, ...
           'EdgeColor', 'none', 'FaceColor', 'none');
       grid on;
set(gca, 'XLim', [0.5, m+0.5 ], 'YLim', [0.5, n+0.5 ], 'YDir', 'reverse');


%colorbar();
ax=axis;
hold on;

yline=[2,14]; xline=[1,5];
plot(xline,yline)
xlabel('Training Image Number')
ylabel('Operator Number')