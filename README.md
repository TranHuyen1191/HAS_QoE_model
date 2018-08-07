# HAS_QoE_Model-Matlab
* This source code is an implementation in the MATLAB language of our proposed model for predicting the QoE of a HAS session.

## How to use
### Input 
- String pvs_id     : Name of session                         
- Array  SQ         : Array of Segment quality values         
- Array  Dur_inter  : Array of interruption durations   
	
### Output
- Double QoE		: Overall MOS						
- Double Q_PQ	    : Varying perceptual quality value		 	
- Double D_QV	    : Distortion of quality variation		 	
- Double D_IR	    : Distortion of interruption				 


## Example
 A session of 9 seconds has 9 segments. The segment video quality values are [5 5 5 4 4 4 3 3 3]. 
 In addition, there are two interruptions with the durations of 0.1s and 0.5s. 

The predicted QoE value of the session can be obtained by the following commands. 
  ```
	SQ = [ 5 5 5 4 4 4 3 3 3];
	Dur_inter = [ 0.1 0.5];
	pvs_id = 'Session1';
	[QoE,Q_PQ,D_QV,D_IR] = F_model_HuyenAizu(pvs_id,SQ,Dur_inter)
	
  ```
Output:
  ```
	QoE = 3.0560
	Q_PQ = 3.8980
	D_QV = 0.0020
	D_IR = 0.8420
  ```

## Authors

* **Tran Huyen** - *The University of Aizu, Japan* - tranhuyen1191@gmail.com

## Acknowledgments

If you use this source code in your research, you must cite:

1. The link to this repository.

## License

The source code is only used for non-commercial research purposes.
* If you have any questions, suggestions or corrections, please email to tranhuyen1191@gmail.com. 
