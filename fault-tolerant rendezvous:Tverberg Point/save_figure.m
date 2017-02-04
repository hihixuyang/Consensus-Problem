function save_figure(t)
    if t == 0
        saveas(1,'fig_t=0.png');
    elseif t>=0.1 && t<= 0.2
        saveas(1,'fig_t=0.4.png');
    elseif t>=0.3 && t<= 0.4
        saveas(1,'fig_t=0.6.png');
    elseif t>=0.5 && t<= 0.7
        saveas(1,'fig_t=1.0.png');
    elseif t>=1.3 && t<= 1.4
        saveas(1,'fig_t=1.4.png');
    end  
end