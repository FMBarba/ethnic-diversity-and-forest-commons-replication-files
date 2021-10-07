/****************************************
Replication do-file for:    Table 4, 5, and Appendix Tables 17 to 20.
Paper:                      "Ethnic Diversity and Forest Commons"
Journal:                    
Contact:                    
Required packages:          regdyad2 (robust inference for dyadic data)
Date:                       2021-09-28
Comments:                   This do-file replicates all results using dyadic data 
                            from the main paper and the appendix, which are based 
                            on ethnic_forest_dyadic.dta.
                            Data onlongitude and latitude of the villages in the
                            sample are not included in the replication data set.   
****************************************/


clear
set matsize 10000
use ethnic_forest_dyadic


global controlvars area distance_km  ij_dist_national_boundary ij_elevation ij_dist_road pop_sum pop_diff mean_born__* mean_rooms_per_hh__* mean_read_and_write__*   mean_piped_water__*  mean_electricity__* 	 


******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************

** Table 4 


******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************



	foreach indepvar in Bh_dist DINE_dist shared_dist ELF_dist{  
			
			regdyad2 forest_cover `indepvar' $controlvars i.wardID_i i.wardID_j,  dyads(village_id_census_i village_id_census_j) 
			
			regdyad2 forest_cover `indepvar' $controlvars i.wardID_i i.wardID_j if ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1, dyads(village_id_census_i village_id_census_j) 
			
			regdyad2 forest_loss `indepvar' $controlvars i.wardID_i i.wardID_j,  dyads(village_id_census_i village_id_census_j) 
			
			regdyad2 forest_loss `indepvar' $controlvars i.wardID_i i.wardID_j if ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1, dyads(village_id_census_i village_id_census_j) 	


	}

******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************

** Table 5


******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************


	foreach indepvar in Bh_dist DINE_dist shared_dist ELF_dist{  
			
			regdyad2 forest_cover `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j, dyads(village_id_census_i village_id_census_j) 

			regdyad2 forest_cover `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j if ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1, dyads(village_id_census_i village_id_census_j) 

			regdyad2 forest_loss `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j, dyads(village_id_census_i village_id_census_j) 

			regdyad2 forest_loss `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j if ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1, dyads(village_id_census_i village_id_census_j) 

	}


******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************

** Appendix Table 17 (District i fixed-effects)


******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************


	foreach indepvar in Bh_dist DINE_dist shared_dist ELF_dist{  
			
			regdyad2 forest_cover `indepvar' $controlvars i.districtid_i,  	dyads(village_id_census_i village_id_census_j) 
			
			regdyad2 forest_cover `indepvar' $controlvars i.districtid_i if ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1,  	dyads(village_id_census_i village_id_census_j) 
			
			regdyad2 forest_loss `indepvar' $controlvars i.districtid_i,  	dyads(village_id_census_i village_id_census_j) 
			
			regdyad2 forest_loss `indepvar' $controlvars i.districtid_i if ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1,  	dyads(village_id_census_i village_id_census_j) 
			


	}


******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************

** Appendix Table 18 (Villages with population below 1,000)


******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************

	foreach indepvar in Bh_dist DINE_dist shared_dist ELF_dist{  
			
			regdyad2 forest_cover `indepvar' $controlvars i.wardID_i i.wardID_j if   pop_vill_j< 1000 &  pop_vill_i< 1000, dyads(village_id_census_i village_id_census_j) 
			
			regdyad2 forest_cover `indepvar' $controlvars i.wardID_i i.wardID_j if (ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1) & pop_vill_j< 1000 &  pop_vill_i< 1000, dyads(village_id_census_i village_id_census_j) 
			
			regdyad2 forest_loss `indepvar' $controlvars i.wardID_i i.wardID_j if   pop_vill_j< 1000 &  pop_vill_i< 1000,  	dyads(village_id_census_i village_id_census_j) 
		
			regdyad2 forest_loss `indepvar' $controlvars i.wardID_i i.wardID_j if (ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1) & pop_vill_j< 1000 &  pop_vill_i< 1000, dyads(village_id_census_i village_id_census_j) 
		
			

			regdyad2 forest_cover `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j if   pop_vill_j< 1000 &  pop_vill_i< 1000,  	dyads(village_id_census_i village_id_census_j) 
		
			regdyad2 forest_cover `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j if (ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1) & pop_vill_j< 1000 &  pop_vill_i< 1000, dyads(village_id_census_i village_id_census_j) 
	
			regdyad2 forest_loss `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j if   pop_vill_j< 1000 &  pop_vill_i< 1000,  	dyads(village_id_census_i village_id_census_j) 
			
			regdyad2 forest_loss `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j if (ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1) & pop_vill_j< 1000 &  pop_vill_i< 1000,  	dyads(village_id_census_i village_id_census_j) 
		
	}



******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************

** Appendix Table 19 (polygons excluding a 500m buffer around the village centroids)


******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************


	foreach indepvar in Bh_dist DINE_dist shared_dist ELF_dist{  
			
			regdyad2 forest_cover_buffer500 `indepvar' $controlvars i.wardID_i i.wardID_j , dyads(village_id_census_i village_id_census_j) 
		
			regdyad2 forest_cover_buffer500 `indepvar' $controlvars i.wardID_i i.wardID_j if (ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1), dyads(village_id_census_i village_id_census_j) 
		
			regdyad2 forest_loss_buffer500 `indepvar' $controlvars i.wardID_i i.wardID_j ,  dyads(village_id_census_i village_id_census_j) 
		
			regdyad2 forest_loss_buffer500 `indepvar' $controlvars i.wardID_i i.wardID_j if (ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1), dyads(village_id_census_i village_id_census_j) 
			
			
			
			regdyad2 forest_cover_buffer500 `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j ,  	dyads(village_id_census_i village_id_census_j) 
	
			regdyad2 forest_cover_buffer500 `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j if (ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1), dyads(village_id_census_i village_id_census_j) 
		
			regdyad2 forest_loss_buffer500 `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j ,  	dyads(village_id_census_i village_id_census_j) 

			regdyad2 forest_loss_buffer500 `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j if (ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1), dyads(village_id_census_i village_id_census_j) 

	}



******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************

** Appendix Table 20 (polygons excluding a 1km buffer around the village centroids)


******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************

	foreach indepvar in Bh_dist DINE_dist shared_dist ELF_dist{  
			
			regdyad2 forest_cover_buffer1000 `indepvar' $controlvars i.wardID_i i.wardID_j,  dyads(village_id_census_i village_id_census_j) 
			
			regdyad2 forest_cover_buffer1000 `indepvar' $controlvars i.wardID_i i.wardID_j if (ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1), dyads(village_id_census_i village_id_census_j) 
			
			regdyad2 forest_loss_buffer1000 `indepvar' $controlvars i.wardID_i i.wardID_j ,  dyads(village_id_census_i village_id_census_j) 
			
			regdyad2 forest_loss_buffer1000 `indepvar' $controlvars i.wardID_i i.wardID_j if (ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1), dyads(village_id_census_i village_id_census_j) 
			

			regdyad2 forest_cover_buffer1000 `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j,  dyads(village_id_census_i village_id_census_j) 
		
			regdyad2 forest_cover_buffer1000 `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j if (ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1), dyads(village_id_census_i village_id_census_j) 
		
			regdyad2 forest_loss_buffer1000 `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j, dyads(village_id_census_i village_id_census_j) 
			
			regdyad2 forest_loss_buffer1000 `indepvar' $controlvars  i.village_id_census_i i.village_id_census_j if (ward_above_median_forest_cover_i ==1 | ward_above_median_forest_cover_j ==1), dyads(village_id_census_i village_id_census_j) 

	}



*********************************************************** END *******************************************************************************************************************

