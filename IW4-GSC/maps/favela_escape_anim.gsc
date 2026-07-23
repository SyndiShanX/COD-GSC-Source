/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\favela_escape_anim.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#using_animtree("generic_human");

main() {
  setup_anims();
  setup_dialogue();
}

setup_anims() {
  level.scr_anim["generic"]["intro_rojas_idle"][0] = % favela_escape_crucified_idle;
  level.scr_anim["generic"]["intro_rojas_death"] = % favela_escape_crucified_death;

  level.scr_anim["generic"]["intro_casual_walk"] = % patrol_bored_patrolwalk;

  level.scr_anim["generic"]["favela_run_and_wave"] = % favela_run_and_wave;

  level.scr_anim["generic"]["door_kick_in"] = % door_kick_in;
  level.scr_anim["generic"]["doorburst_wave"] = % doorburst_wave;
  level.scr_anim["generic"]["doorburst_search"] = % doorburst_search;
  level.scr_anim["generic"]["doorburst_fall"] = % doorburst_fall;

  level.scr_anim["generic"]["window_smash_stop_inside"] = % window_smash_stop_inside;
  level.scr_anim["generic"]["window_smash_stop_outside"] = % window_smash_stop_outside;
  level.scr_anim["generic"]["window_smash_run"] = % window_smash_run;

  level.scr_anim["generic"]["favela_chaotic_above_through"] = % favela_chaotic_above_through;
  level.scr_anim["generic"]["favela_chaotic_above_through_uzi"] = % favela_chaotic_above_through_uzi;
  level.scr_anim["generic"]["favela_chaotic_above_back"] = % favela_chaotic_above_back;

  level.scr_anim["curtain_pull"]["pulldown"] = % favela_curtain_pull;

  level.scr_anim["generic"]["traverse_window_M_2_dive"] = % traverse_window_M_2_dive;

  level.scr_anim["generic"]["favela_escape_rooftop_traverse_L"] = % favela_escape_rooftop_traverse_L;
  level.scr_anim["generic"]["favela_escape_rooftop_traverse_R"] = % favela_escape_rooftop_traverse_R;
  level.scr_anim["generic"]["favela_escape_rooftop_traverse_M"] = % favela_escape_rooftop_traverse_M;
  level.scr_anim["generic"]["favela_escape_rooftop_traverse_M_idle"][0] = % favela_escape_rooftop_traverse_M_idle;
  level.scr_anim["generic"]["favela_escape_rooftop_traverse_M_idle_2_run"] = % favela_escape_rooftop_traverse_M_idle_2_run;

  level.scr_anim["generic"]["freerunnerA_run"] = % freerunnerA_loop;
  level.scr_anim["generic"]["freerunnerB_run"] = % freerunnerB_loop;
  level.scr_anim["freerunner"]["freerunnerA_left"] = % freerunnerA_left;
  level.scr_anim["freerunner"]["freerunnerB_mid"] = % freerunnerB_mid;
  level.scr_anim["freerunner"]["freerunnerA_right"] = % freerunnerA_right;
  level.scr_anim["freerunner"]["freerunnerA_sideslope"] = % freerunnerA_sideslope;
  level.scr_anim["freerunner"]["freerunnerA_laundry"] = % freerunnerA_laundry;
  level.scr_anim["freerunner"]["freerunnerB_laundry"] = % freerunnerB_laundry;
  level.scr_anim["freerunner"]["jump_across_100_lunge"] = % jump_across_100_lunge;
  level.scr_anim["freerunner"]["favela_escape_bigjump_faust_loop"][0] = % favela_escape_bigjump_faust_loop;
  level.scr_anim["freerunner"]["favela_escape_bigjump_ghost_loop"][0] = % favela_escape_bigjump_ghost_loop;
  level.scr_anim["freerunner"]["favela_escape_bigjump_soap_loop"][0] = % favela_escape_bigjump_soap_loop;
  level.scr_anim["freerunner"]["favela_escape_bigjump_soap_reach"] = % favela_escape_bigjump_soap_reach;
  level.scr_anim["freerunner"]["favela_escape_bigjump_soap"] = % favela_escape_bigjump_soap;
  level.scr_anim["freerunner"]["favela_escape_bigjump_ghost"] = % favela_escape_bigjump_ghost;
  level.scr_anim["freerunner"]["favela_escape_bigjump_faust"] = % favela_escape_bigjump_faust;

  level.scr_anim["generic"]["mobwalk_A"] = % mob_arc_A;
  level.scr_anim["generic"]["mobwalk_B"] = % mob_arc_B;
  level.scr_anim["generic"]["mobwalk_C"] = % mob_arc_C;
  level.scr_anim["generic"]["mobwalk_D"] = % mob_arc_D;

  level.scr_anim["generic"]["mob2_arc_A"] = % mob2_arc_A;
  level.scr_anim["generic"]["mob2_arc_B"] = % mob2_arc_B;
  level.scr_anim["generic"]["mob3_arc_C"] = % mob3_arc_C;
  level.scr_anim["generic"]["mob2_arc_D"] = % mob2_arc_D;
  level.scr_anim["generic"]["mob2_arc_E"] = % mob2_arc_E;
  level.scr_anim["generic"]["mob2_arc_F"] = % mob2_arc_F;
  level.scr_anim["generic"]["mob2_arc_G"] = % mob2_arc_G;
  level.scr_anim["generic"]["mob2_arc_H"] = % mob2_arc_H;

  level.scr_anim["generic"]["mob_left_A"] = % mob_left_A;
  level.scr_anim["generic"]["mob_left_B"] = % mob_left_B;
  level.scr_anim["generic"]["mob_left_C"] = % mob_left_C;
  level.scr_anim["generic"]["mob_left_D"] = % mob_left_D;

  level.scr_anim["generic"]["favela_escape_rooftop_mob1"] = % favela_escape_rooftop_mob1;
  level.scr_anim["generic"]["favela_escape_rooftop_mob2"] = % favela_escape_rooftop_mob2;
  level.scr_anim["generic"]["favela_escape_rooftop_mob3"] = % favela_escape_rooftop_mob3;
  level.scr_anim["generic"]["favela_escape_rooftop_mob4"] = % favela_escape_rooftop_mob4;

  level.scr_anim["default_civilian"]["run_and_slam_idle"][0] = % flee_alley_civilain_idle;
  level.scr_anim["default_civilian"]["run_and_slam"] = % flee_alley_civilain;
  level.scr_anim["default_civilian"]["run_and_slam_endidle"][0] = % civilain_crouch_hide_idle;

  level.scr_anim["generic"]["unarmed_cowercrouch_react_A"] = % unarmed_cowercrouch_react_A;
  level.scr_anim["generic"]["unarmed_cowercrouch_react_B"] = % unarmed_cowercrouch_react_B;
  level.scr_anim["generic"]["unarmed_cowercrouch_idle"][0] = % unarmed_cowercrouch_idle;
  level.scr_anim["generic"]["cargoship_stunned_react_v2"] = % cargoship_stunned_react_v2;
  level.scr_anim["generic"]["unarmed_cowerstand_react_2_crouch"] = % unarmed_cowerstand_react_2_crouch;
  level.scr_anim["generic"]["unarmed_cowerstand_idle"][0] = % unarmed_cowerstand_idle;

  level.scr_anim["chopper_door_guy"]["chopperjump_in"] = % favela_escape_ending_mctavish_in;
  level.scr_anim["chopper_door_guy"]["chopperjump_loop"][0] = % favela_escape_ending_mctavish_flying_loop;
  level.scr_anim["chopper_door_guy"]["chopperjump_flyaway"] = % favela_escape_ending_mctavish_flying_away;

  setup_vehicle_anims();

  setup_model_anims();

  favela_escape_player();
}

setup_dialogue() {
  level.scr_face["freerunner"]["favesc_cmt_pickusup"] = % favela_escape_Soap_pickusup;

  level.scr_face["freerunner"]["favesc_cmt_makeitgogo"] = % favela_escape_Soap_makeitgogo;

  level.scr_face["chopper_door_guy"]["favesc_cmt_jump"] = % favela_escape_soap_cmt_jump;
}

#using_animtree("player");
favela_escape_player() {
  level.scr_anim["player_bigjump"]["jump"] = % player_favela_escape_bigjump;
  level.scr_anim["player_bigjump"]["recover"] = % player_favela_escape_bigjump_getup;
  level.scr_model["player_bigjump"] = "viewhands_player_tf141_favela";
  level.scr_animtree["player_bigjump"] = #animtree;

  level.scr_anim["player"]["chopperjump_jump"] = % favela_escape_ending_player_catch_rope;
  level.scr_model["player"] = "viewhands_player_tf141_favela";
  level.scr_animtree["player"] = #animtree;
}

#using_animtree("script_model");
setup_model_anims() {
  level.scr_model["rojas_restraints"] = "unconscious_rojas_rope";
  level.scr_animtree["rojas_restraints"] = #animtree;
  level.scr_anim["rojas_restraints"]["idle"][0] = % favela_escape_crucified_ropes;

  level.scr_model["curtain"] = "curtain_torn01_animated";
  level.scr_animtree["curtain"] = #animtree;
  level.scr_anim["curtain"]["pulldown"] = % favela_curtain_model_pull;

  level.scr_model["civ_door"] = "com_door_01_handleleft";
  level.scr_animtree["civ_door"] = #animtree;
  level.scr_anim["civ_door"]["run_and_slam_idle"][0] = % flee_alley_door_idle;
  level.scr_anim["civ_door"]["run_and_slam"] = % flee_alley_door;

  level.scr_model["roof_rig"] = "favela_escape_roof_piece";
  level.scr_animtree["roof_rig"] = #animtree;
  level.scr_anim["roof_rig"]["breakaway"] = % favela_escape_roof_piece_collapse;

  level.scr_model["laundry"] = "hanging_sheet";
  level.scr_animtree["laundry"] = #animtree;
  level.scr_anim["laundry"]["roofrun_laundry_1"] = % favela_escape_sheet01_run_through;
  level.scr_anim["laundry"]["roofrun_laundry_2"] = % favela_escape_sheet02_run_through;

  level.scr_model["ladder"] = "favela_escape_ropeladder";
  level.scr_anim["ladder"]["chopperjump_in"] = % favela_escape_ending_rope_in;
  level.scr_anim["ladder"]["chopperjump_loop"][0] = % favela_escape_ending_rope_loop;
  level.scr_anim["ladder"]["chopperjump_jump"] = % favela_escape_ending_rope_interaction;
  level.scr_animtree["ladder"] = #animtree;
}

#using_animtree("vehicles");
setup_vehicle_anims() {
  level.scr_anim["chopper"]["cargodoor_open"] = % favela_escape_ending_chopper_open_back_door;
  level.scr_anim["chopper"]["chopperjump_in"] = % favela_escape_ending_chopper_in;
  level.scr_anim["chopper"]["chopperjump_loop"][0] = % favela_escape_ending_chopper_loop;
  level.scr_anim["chopper"]["chopperjump_flyaway"] = % favela_escape_ending_chopper_flying_away;
  level.scr_anim["chopper"]["rotors"] = % bh_rotors;
  level.scr_model["chopper"] = "vehicle_pavelow";
  level.scr_animtree["chopper"] = #animtree;
}