/****************************************
Replication do-file for:    Table 1, 2, and Appendix Tables 12, 13, 14, 15, 16.
Paper:                      "Ethnic Diversity and Forest Commons"
Journal:                    
Contact:                    
Required packages:          spmat, spreg (Spatial regression model by Drukker, Prucha, Raciborski)
Date:                       2021-09-28
Comments:                   This do-file replicates all results using village-level data 
                            from the main paper and the appendix, which are based 
                            on village_level.dta and village_level_spatial.dta
                            Data on longitude and latitude of the villages in the
                            sample are not included in the replication data set.   
****************************************/


use "village_level", clear

	global controlvars 	Shape_Area 	elevation dist_road dist_river dist_national_boundary pop_vill mean_born mean_read_and_write mean_rooms_per_hh mean_exclusive_toilet_use mean_piped_water mean_electricity 

	global controlvars_ethn_dummies $controlvars perc_village_etn_1 perc_village_etn_2 	perc_village_etn_3 perc_village_etn_4 	perc_village_etn_5 perc_village_etn_6 	perc_village_etn_7 perc_village_etn_8 	perc_village_etn_9  

******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************

** Tables 2 and 3 


******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************
*
	* Forest cover
	**************
	local depvar weighted_forest_cover

	reg 	`depvar' ELF $controlvars

			areg  `depvar' ELF if e(sample), robust a(wardID)
			areg  `depvar' ELF $controlvars, robust a(wardID)
			areg  `depvar' ELF $controlvars if `depvar'>7.17, robust a(wardID)
			areg  `depvar' ELF $controlvars_ethn_dummies, robust a(wardID)
			areg  `depvar' ELF $controlvars_ethn_dummies if `depvar'>7.17, robust a(wardID)

	* Forest loss
	**************
	local depvar percent_lost

	reg 	`depvar' ELF $controlvars

			areg  `depvar' ELF if e(sample), robust a(wardID)
			areg  `depvar' ELF $controlvars, robust a(wardID)
			areg  `depvar' ELF $controlvars if `depvar'>7.17, robust a(wardID)
			areg  `depvar' ELF $controlvars_ethn_dummies, robust a(wardID)
			areg  `depvar' ELF $controlvars_ethn_dummies if `depvar'>7.17, robust a(wardID)

		
	******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************

** Tables 12, 13, 14, 15


******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************	

***************
* Table 12: Interactions ELF and Population
***************


	* Forest cover
	**************
	local depvar weighted_forest_cover

	reg 	`depvar' ELF ELF_pop $controlvars

			areg  `depvar' ELF ELF_pop  if e(sample), robust a(wardID)
			areg  `depvar' ELF ELF_pop  $controlvars, robust a(wardID)
			areg  `depvar' ELF ELF_pop  $controlvars if `depvar'>7.17, robust a(wardID)
			areg  `depvar' ELF ELF_pop   $controlvars_ethn_dummies, robust a(wardID)
			areg  `depvar' ELF ELF_pop  $controlvars_ethn_dummies if `depvar'>7.17, robust a(wardID)

	* Forest loss
	**************	
		local depvar percent_lost 
		
		reg 	`depvar' ELF ELF_pop  $controlvars
		
			areg  `depvar' ELF ELF_pop weighted_forest_cover if e(sample), robust a(wardID)
			areg  `depvar' ELF ELF_pop   weighted_forest_cover $controlvars, robust a(wardID)
			areg  `depvar' ELF ELF_pop  weighted_forest_cover $controlvars if weighted_forest_cover>7.17, robust a(wardID)
			areg  `depvar' ELF ELF_pop  weighted_forest_cover $controlvars_ethn_dummies, robust a(wardID)
			areg  `depvar' ELF ELF_pop  weighted_forest_cover $controlvars_ethn_dummies if weighted_forest_cover>7.17, robust a(wardID)


***************
* Table 13: Interactions ELF and Poverty
***************


	* Forest cover
	**************
	local depvar weighted_forest_cover

	reg 	`depvar' ELF ELF_pov  $controlvars

			areg  `depvar' ELF ELF_pov   if e(sample), robust a(wardID)
			areg  `depvar' ELF ELF_pov   $controlvars, robust a(wardID)
			areg  `depvar' ELF ELF_pov   $controlvars if `depvar'>7.17, robust a(wardID)
			areg  `depvar' ELF ELF_pov    $controlvars_ethn_dummies, robust a(wardID)
			areg  `depvar' ELF ELF_pov   $controlvars_ethn_dummies if `depvar'>7.17, robust a(wardID)

	* Forest loss
	**************	
		local depvar percent_lost 
		
		reg 	`depvar' ELF ELF_pov  $controlvars

			areg  `depvar' ELF ELF_pov  weighted_forest_cover if e(sample), robust a(wardID)
			areg  `depvar' ELF ELF_pov    weighted_forest_cover $controlvars, robust a(wardID)
			areg  `depvar' ELF ELF_pov   weighted_forest_cover $controlvars if weighted_forest_cover>7.17, robust a(wardID)
			areg  `depvar' ELF ELF_pov   weighted_forest_cover $controlvars_ethn_dummies, robust a(wardID)
			areg  `depvar' ELF ELF_pov   weighted_forest_cover $controlvars_ethn_dummies if weighted_forest_cover>7.17, robust a(wardID)


***************
* Table 14: Polarization
***************

	* Forest cover
	**************
	local depvar weighted_forest_cover

	reg 	`depvar' pol $controlvars

			areg  `depvar' pol if e(sample), robust a(wardID)
			areg  `depvar' pol $controlvars, robust a(wardID)
			areg  `depvar' pol $controlvars if `depvar'>7.17, robust a(wardID)
			areg  `depvar' pol $controlvars_ethn_dummies, robust a(wardID)
			areg  `depvar' pol $controlvars_ethn_dummies if `depvar'>7.17, robust a(wardID)

	* Forest loss
	**************	
		local depvar percent_lost 
		
		reg 	`depvar' pol $controlvars

			areg  `depvar' pol weighted_forest_cover $controlvars, robust a(wardID)
			areg  `depvar' pol weighted_forest_cover $controlvars if weighted_forest_cover>7.17, robust a(wardID)
			areg  `depvar' pol weighted_forest_cover $controlvars_ethn_dummies, robust a(wardID)
			areg  `depvar' pol weighted_forest_cover $controlvars_ethn_dummies if weighted_forest_cover>7.17, robust a(wardID)


***************
* Table 15: Pixels of forest loss
***************

	* OLS
	**************
		rename total_pixels_lost_01_14 totPixLost
		
		local depvar totPixLost 
		
		reg 	`depvar' ELF $controlvars

			areg  `depvar' ELF weighted_forest_cover if e(sample), robust a(wardID)
			areg  `depvar' ELF weighted_forest_cover $controlvars, robust a(wardID)
			areg  `depvar' ELF weighted_forest_cover $controlvars if weighted_forest_cover>7.17, robust a(wardID)
			areg  `depvar' ELF weighted_forest_cover $controlvars_ethn_dummies, robust a(wardID)
			areg  `depvar' ELF weighted_forest_cover $controlvars_ethn_dummies if weighted_forest_cover>7.17, robust a(wardID)


	* Poisson 
	************
	cap 	rename total_pixels_lost_01_14 totPixLost

	local depvar totPixLost 

	reg 	`depvar' ELF $controlvars

	xtset  wardID village_id_census 
	xtpoisson `depvar'  ELF weighted_forest_cover $controlvars if e(sample), vce(robust) fe 
	xtpoisson `depvar'  ELF weighted_forest_cover $controlvars_ethn_dummies if e(sample), vce(robust) fe 

	local depvar totPixLost 

	* High forest
	xtset  wardID village_id_census 
	xtpoisson `depvar'  ELF weighted_forest_cover $controlvars if e(sample) & `depvar'>7.17, vce(robust) fe 


	
******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************

** Tables 16


******************************************************************************************************************************************************************************
******************************************************************************************************************************************************************************		

use  "village_level_spatial", replace

* Import spatial matrix (contiguity)
cap spmat use  village_level_spatial_contiguity using village_level_spatial_contiguity.spmat

	global controlvars Shape_Area elevation  dist_road dist_river dist_national_boundary pop_vill mean_born mean_read_and_write 	mean_rooms_per_hh mean_exclusive_toilet_use mean_piped_water mean_electricity 

	global controlvars_ethn_dummies $controlvars perc_village_etn_1 perc_village_etn_2 	perc_village_etn_3 perc_village_etn_4 	perc_village_etn_5 perc_village_etn_6 perc_village_etn_7 perc_village_etn_8 perc_village_etn_9  


	* Forest cover
	**************
		spreg gs2sls weighted_forest_cover ELF  $controlvars 			wardID_*, heteroskedastic dlmat("village_level_spatial_contiguity") elmat("village_level_spatial_contiguity") id(village_id_census_src)
		spreg gs2sls weighted_forest_cover ELF  $controlvars_ethn_dummies wardID_*, heteroskedastic dlmat("village_level_spatial_contiguity") elmat("village_level_spatial_contiguity") id(village_id_census_src)


	* Forest loss
	**************
		spreg gs2sls percent_lost ELF  $controlvars 			wardID_*, heteroskedastic dlmat("village_level_spatial_contiguity") elmat("village_level_spatial_contiguity") id(village_id_census_src)
		spreg gs2sls percent_lost ELF  $controlvars_ethn_dummies wardID_*, heteroskedastic dlmat("village_level_spatial_contiguity") elmat("village_level_spatial_contiguity") id(village_id_census_src)
	
	