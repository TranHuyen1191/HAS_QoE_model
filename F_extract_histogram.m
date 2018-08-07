function [F_SQ, F_SV,F_It, MOS5,MOS4,MOS3,MOS2,MOS1,Keep,sw54,sw53,sw52,sw51,...
            sw43,sw42,sw41,sw32,sw31,sw21,I025,I0,I1,I2,I3,I4] ...
            = F_extract_histogram(SQ,Dur_inter)
	%% Boundaries of Bins 
	SQ_Bo_Amp       = [  0.50   1.50   2.50   3.50   4.50   5.50 ]; % 5 bins
	SQ_Bo_Gra       = [ -4.50  -3.50  -2.50  -1.50  -0.50   4.50 ]; % 5 bins
	Bo_Inter        = [  0.00   0.25   0.50	  1.00   2.00   3.00   1000]; % 6 bins

	%% Calculate gradient segment quality values
	   No_seg   = length(SQ); %Number of segment
	   No_sw    = length(SQ)-1; %Number of switches
	   No_inter = length(find(Dur_inter>0)); % Number of interruptions
	   Gra_seg  = [];
	   if(No_seg > 1)
		   Start_SQ = SQ(1:length(SQ)-1);
		   for i=2 : No_seg
			   Gra_seg(i-1) = SQ(i) - SQ(i-1);
		   end
	   end
	   %% Extract histograms
	   if No_seg > 0
			[SQ_Bincount,SQ_ind]         = histc(SQ,SQ_Bo_Amp);
			F_SQ                         = SQ_Bincount(1:5)/No_seg;
	   else
		   F_SQ = zeros(1,5);
	   end
	   if No_sw > 0
			SV_Bincount                         = histcounts2(Gra_seg,Start_SQ,SQ_Bo_Gra,SQ_Bo_Amp);
			F_SV = SV_Bincount/(No_sw+No_inter);
	   else
		   F_SV = zeros(5,5);
	   end
	   It_Bincount                  = zeros(1,length(Bo_Inter)-1);
	   F_It                         = zeros(1,length(Bo_Inter)-1);
	   if No_inter >= 1
		   for i = 1:length(Dur_inter)
			   for b = 1:length(Bo_Inter)-1
				   if Dur_inter(i) > Bo_Inter(b)&& Dur_inter(i)<= Bo_Inter(b+1)
					   It_Bincount(b) = It_Bincount(b) +1;
				   end
			   end
		   end
		   F_It                         = It_Bincount/(No_sw+No_inter); 
	   end
	   MOS5 = F_SQ(5);
	   MOS4 = F_SQ(4);
	   MOS3 = F_SQ(3);
	   MOS2 = F_SQ(2);
	   MOS1 = F_SQ(1);
	   Keep = sum(F_SV(5,:));
	   sw54 = F_SV(4,5);
	   sw53 = F_SV(3,5);
	   sw52 = F_SV(2,5);
	   sw51 = F_SV(1,5);
	   sw43 = F_SV(4,4);
	   sw42 = F_SV(3,4);
	   sw41 = F_SV(2,4);
	   sw32 = F_SV(4,3);
	   sw31 = F_SV(3,3);
	   sw21 = F_SV(4,2);
	   I025 = F_It(1);
	   I0   = F_It(2);
	   I1   = F_It(3);
	   I2   = F_It(4);
	   I3   = F_It(5);
	   I4   = F_It(6);
end
   