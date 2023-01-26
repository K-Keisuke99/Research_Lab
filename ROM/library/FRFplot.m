function FRFplot(fig)
    figure(fig);
    hold on
    [FRFdatas,path]=uigetfile('*.txt',"MultiSelect","on");
    leg=strings();
    for i=1:1:length(FRFdatas)
    FRFdata=fullfile(path,FRFdatas{i});
    FRFdata=importdata(FRFdata);%kokotabuntitlekesu
    Freq=FRFdata.data(:,1);
    Amp=FRFdata.data(:,2);
    Degree=FRFdata.data(:,3);
    Re=FRFdata.data(:,4);
    Im=FRFdata.data(:,5);
    plot(Freq,log10(Amp*1000))
    leg(end)=string(45*(i-1))+"[deg]~"+string(45*i)+"[deg]";leg(end+1)="";
    hold on
    end
    leg(end-1)="Avg Responce"
    legend(leg)
    title("Frequency Reponces")
    xlabel("Frequency [Hz]")
    ylabel("Compliance [mm/N]")
end