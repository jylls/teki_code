function runTekiv5(btag)

global TDT;
try
    if numel(btag)>1
        fprintf('\n\n----------------------- A new trial started -------------------\n')
        params = strsplit(btag,'SPKTeki');
        params = strsplit(params{2},'END');
        params_ = strsplit(params{1},'_');
        disp(params);
        freqs_char_targ=strsplit(params_{5},'.');
        freqs_char_back=strsplit(params_{6},'.');
        disp(params_{6})
        first_freq_targ=freqs_char_targ{1};
        first_freq_back=freqs_char_back{1};
        first_freq_targ=first_freq_targ(2:length(first_freq_targ));
        first_freq_back=first_freq_back(2:length(first_freq_back));
          
        frequencies_targ=[str2double(first_freq_targ),str2double(freqs_char_targ(2:size(freqs_char_targ,2)))];
        frequencies_back=[str2double(first_freq_back),str2double(freqs_char_back(2:size(freqs_char_back,2)))];
        
        params=strsplit(params{1},'.');
        disp(params)
        mid_params=strsplit(params{3},'_');
        N_coherence=str2double(params{2});
        
        N_on_off=str2double(mid_params{1});
        N_repeats=str2double(mid_params{2});
        beep_duration=str2double(mid_params{3});
        beep_frequency=str2double(mid_params{4});
        TDT.NT = TDT.NT+1;
        TDT = TDT.updateCS(0);
        
        getTekiv5(TDT,beep_duration,N_coherence,frequencies_targ,frequencies_back,N_on_off,beep_frequency);
        i = 0;
        
        save('params_teki.mat','N_coherence','N_on_off','N_repeats','beep_duration','beep_frequency','frequencies_targ','frequencies_back','i');
        
    else
        
        params_teki = load('params_teki.mat');
        N_repeats = params_teki.N_repeats;
        i = params_teki.i; 
        frequencies_targ=params_teki.frequencies_targ;
        frequencies_back=params_teki.frequencies_back;
        switch btag
            case '5' % ToneOn
              
                if i <= N_repeats-1
                    fprintf('\nPlaying pre-target...\n');
                    
                    TDT.triggerTDT(1);  % turn on tone
                    
                    i = i+1;
                    
                    save('params_teki.mat','N_repeats','i','frequencies_targ','frequencies_back')
                else
                    fprintf('\nPlaying target...\n');
                    TDT.triggerTDT(3); 
                end
            case '9'
                
                fprintf('\nSound stopped.\n')
               
                TDT.triggerTDT(2); % turn off pre-target tone
                TDT.triggerTDT(4); % turn off target tone
                %TDT = TDT.updateCS(0); % reset state-list
                TDT.RP.ZeroTag('Streamfig1');
                TDT.RP.ZeroTag('Streamfig2');
                %fprintf('\n\n--------------- A new trial started ---------------\n\n')

        
        end
       
    end
catch
    
    %disp('!!! Pass to the next trial !!!')
end
