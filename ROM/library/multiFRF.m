function frf=multiFRF(mode_shapes,Mm,Km,a,b,freq,fig,Target_N_range)
    omega=freq*(2*pi);
    mode_num=length(mode_shapes(1,:));
    Point_num=length(mode_shapes(:,1));
    FRF=zeros(Point_num,Point_num,length(omega));
    for w=1:1:length(omega)
        for input=1:1:Point_num
            for output=1:1:Point_num
                for k=1:1:mode_num
                    
                    G=(1i*omega(w)*(a*Mm(k,k)+b*Km(k,k))+Km(k,k)-omega(w)^2*Mm(k,k));
                    
                    %FF=FRF(input,output,:);
                    %FRF(input,output,:)=FF(:)+FoverG(:,1);
                    FRF(input,output,w)=FRF(input,output,w)+mode_shapes(input,k)*mode_shapes(output,k)/G;
                end

            end
        end
    end
    figure(fig);
    bango=0;
    for p=1:1:Target_N_range
        for q=1:1:Target_N_range
            bango=bango+1;
            if p>q
                continue
            end
            subplot(Target_N_range,Target_N_range,bango)
            Freq_resp=log10(abs(FRF(p,q,:)));
            plot(freq,Freq_resp(:));
            text="Input:"+string(p)+": Output"+string(q);
            axes(bango)=gca;
            title(text)
            xticks(0:1000:freq(end))
            grid on
        end
    end
    linkaxes(axes,'xy');
    ylim([-12,-4])
    ylabel('Compliance[m/N]');
    xlabel('Frequency [Hz]');
    sgtitle('Frequency Responce Fucntions between Representative Points');
    frf=FRF;
end