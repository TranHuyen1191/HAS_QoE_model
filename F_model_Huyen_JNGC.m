%%%%%%%%%%%%%%%%%%%%%%%% Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% String pvs_id     : Name of session                         %%
%%%% Array  SQ         : Array of Segment quality values         %%
%%%% Array  Dur_inter  : Array of interruption durations         %%
%%%% Double ID         : Initial delay duration                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Double QoE		   : Overall MOS							 %%
%%%% Double Q_PQ	   : Varying perceptual quality value		 %%	
%%%% Double D_ID	   : Distortion of initial delay			 %%
%%%% Double D_QV	   : Distortion of quality variation		 %%	
%%%% Double D_IR	   : Distortion of interruption				 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Example
%SQ = [ 5 5 5 4 4 4 3 3 3];
%Dur_inter = [ 0.1];
%ID = 5;
%[QoE, Q_PQ, D_ID, D_QV, D_IR] = F_model_Huyen_GlobeCom('Session1',SQ,Dur_inter,ID)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                           Function                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [QoE, Q_PQ, D_ID, D_QV, D_IR] = F_model_Huyen_JNGC(pvs_id,SQ,Dur_inter,ID)
	%% Weight Parameters 
    SQ_Param_Amp    = [  1.11	2.20	3.20	 4.00	  4.50 ];
    Inter_Param     = [  0.00	8.42   16.15	24.16	 45.58	50.65];
    SQ_Param_Gra    = [  0.00	0.00	0.00	 0.00	-24.76 ;  % (1,-4)   (2,-4) .... (5,-4) 
                         0.00	0.00	0.00   -18.99	-18.69 ;  % (1,-3)   (2,-3) .... (5,-3)
                         0.00	0.00  -14.36    -4.13	 -3.93 ;  % (1,-2)   (2,-2) .... (5,-2)
                         0.00   -7.89   -3.93	-0.01	 -0.01 ;  % (1,-1)   (2,-1) .... (5,-1)
                         0.00	0.00	0.00	 0.00	 0.00 ];  % (1, 0)   (2, 0) .... (5, 0)
                  
	Gam             = 0.1; 
	Muy             = 1.0;
	[F_SQ, F_SV,F_It, MOS5,MOS4,MOS3,MOS2,MOS1,Keep,sw54,sw53,sw52,sw51,...
				sw43,sw42,sw41,sw32,sw31,sw21,I025,I0,I1,I2,I3,I4]...
				= F_extract_histogram(SQ,Dur_inter);
    
    %% Calculate overall MOS
    D_ID  		= Gam*log(ID + Muy);
    D_QV 		= sum(sum(F_SV.*SQ_Param_Gra));
    Q_PQ         = sum(F_SQ.*SQ_Param_Amp) + D_QV;
    D_IR 		= sum(F_It.*Inter_Param);
    QoE          = max(min(Q_PQ - D_IR - D_ID,5),1);
   
end
