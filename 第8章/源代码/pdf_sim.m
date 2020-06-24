%概率密度函数画图程序
function fr_approx=pdf_sim(r)
step = 0.1; range = 0:step:3; 
h = hist(r, range); 
fr_approx = h/(step*sum(h)); 
fr = (range/0.5).*exp(-range.^2);
figure
plot(range, fr_approx,'ko', range, fr,'k');
legend('仿真值','理论值')
grid;
