/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heistspace\heistspace_anim.gsc
**********************************************************/

main() {
  _id_91DC();
  _id_3353();
  _id_3508();
  player();
  _id_13267();
  _id_A056();
  _id_EE25();
}

#using_animtree("generic_human");

_id_91DC() {
  level._id_EC85["brooks"]["bridge_intro_loop"][0] = % heistspace_om130_bridge_loop_brooks;
  level._id_EC85["brooks"]["bridge_fspar_react"] = % heistspace_om130_fspar_fire_reaction_brooks;
  level._id_EC85["brooks"]["bridge_chatter_01"] = % heistspace_om130_battle_chatter_brooks_01;
  level._id_EC85["brooks"]["bridge_chatter_02"] = % heistspace_om130_battle_chatter_brooks_02;
  level._id_EC85["brooks"]["bridge_move_to_pcap"] = % heistspace_om130_fall_back_brooks;
  level._id_EC85["salter"]["bridge_intro"] = % heistspace_om130_bridge_intro_salter;
  level._id_EC85["salter"]["bridge_intro_loop"][0] = % heistspace_om130_bridge_loop_salter;
  level._id_EC85["salter"]["bridge_fspar_react"] = % heistspace_om130_fspar_fire_reaction_salter;
  level._id_EC85["salter"]["bridge_chatter_01"] = % heistspace_om130_battle_chatter_salter_01;
  level._id_EC85["salter"]["bridge_chatter_02"] = % heistspace_om130_battle_chatter_salter_02;
  level._id_EC85["salter"]["bridge_move_to_pcap"] = % heistspace_om130_fall_back_salter;
  level._id_EC85["ethan"]["bridge_intro"] = % heistspace_om130_bridge_intro_ethan;
  scripts\sp\anim::_id_17FC("ethan", "sd_heistspace_eth_sdfshipyardbear", "start_om_player_vo", "bridge_intro");
  scripts\sp\anim::_id_17FC("ethan", "sd_heistspace_eth_activatingweapo", "start_om_hud", "bridge_intro");
  level._id_EC85["ethan"]["bridge_intro_loop"][0] = % heistspace_om130_bridge_loop_ethan;
  level._id_EC85["ethan"]["bridge_fspar_react"] = % heistspace_om130_fspar_fire_reaction_ethan;
  level._id_EC85["ethan"]["bridge_chatter_01"] = % heistspace_om130_battle_chatter_ethan_01;
  level._id_EC85["ethan"]["bridge_chatter_02"] = % heistspace_om130_battle_chatter_ethan_02;
  level._id_EC85["kashima"]["bridge_intro_loop"][0] = % heistspace_om130_bridge_loop_kashima;
  level._id_EC85["kashima"]["bridge_fspar_react"] = % heistspace_om130_fspar_fire_reaction_kashima;
  level._id_EC85["kashima"]["bridge_chatter_01"] = % heistspace_om130_battle_chatter_kashima_01;
  level._id_EC85["kashima"]["bridge_chatter_02"] = % heistspace_om130_battle_chatter_kashima_02;
  level._id_EC85["kashima"]["bridge_move_to_pcap"] = % heistspace_om130_fall_back_kashima;
  level._id_EC85["salter"]["bridge_pcap"] = % heistspace_bridge_salter;
  level._id_EC85["ethan"]["bridge_pcap"] = % heistspace_bridge_ethan;
  level._id_EC85["brooks"]["bridge_pcap"] = % heistspace_bridge_brooks;
  level._id_EC85["kashima"]["bridge_pcap"] = % heistspace_bridge_kashima;
  level._id_EC85["brooks"]["bridge_pcap_loop"][0] = % heistspace_bridge_brooks_loop;
  level._id_EC85["kashima"]["bridge_pcap_loop"][0] = % heistspace_bridge_kashima_loop;
  level._id_EC85["ethan"]["bridge_pcap_loop"][0] = % heistspace_bridge_ethan_loop;
  level._id_EC85["salter"]["upper_hall_exit_to_elevator"] = % heist_space_post_bridge_xo_exit_to_bypass;
  level._id_EC85["salter"]["upper_hall_exit_to_idle2"] = % heist_space_post_bridge_xo_exit_to_idle2;
  level._id_EC85["salter"]["upper_hall_idle2"][0] = % heist_space_post_bridge_xo_idle2;
  level._id_EC85["salter"]["upper_hall_idle2_to_elevator"] = % heist_space_post_bridge_xo_idle2_exit;
  level._id_EC85["salter"]["elevator_enter"] = % heist_space_elevator_xo_enter;
  level._id_EC85["salter"]["elevator_start_idle"][0] = % heist_space_elevator_xo_start_idle;
  level._id_EC85["salter"]["elevator_end_idle"][0] = % heist_space_elevator_xo_end_idle;
  level._id_EC85["salter"]["readyroom_hall_traverse_a"] = % hs_readyroom_hall_traverse_sec_a_xo;
  scripts\sp\anim::_id_17F6("salter", "ethan_vo_1", scripts\sp\maps\heistspace\heistspace_interior::_id_676F, "readyroom_hall_traverse_a");
  scripts\sp\anim::_id_17F6("salter", "ethan_vo_2", scripts\sp\maps\heistspace\heistspace_interior::_id_6770, "readyroom_hall_traverse_a");
  level._id_EC85["salter"]["readyroom_hall_traverse_b_branch_intro"] = % hs_readyroom_hall_traverse_sec_b_branch_intro_xo;
  level._id_EC85["salter"]["readyroom_hall_traverse_b_branch_outro"] = % hs_readyroom_hall_traverse_sec_b_branch_outro_xo;
  level._id_EC85["salter"]["readyroom_hall_traverse_c_branch_intro"] = % hs_readyroom_hall_traverse_sec_c_branch_intro_xo;
  level._id_EC85["salter"]["readyroom_hall_traverse_c_branch_outro"] = % hs_readyroom_hall_traverse_sec_c_branch_outro_xo;
  level._id_EC85["salter"]["readyroom_hall_traverse_branch_idle"][0] = % hs_readyroom_hall_traverse_sec_b_branch_idle_xo;
  level._id_EC85["salter"]["readyroom_exit_traverse_branch_c_idle"][0] = % hm_grnd_red_cover_right_stand_hide_idle_ar;
  level._id_EC85["readyroom_door_guy"]["readyroom_traverse_b_doorguy"] = % hs_readyroom_hall_traverse_sec_b_doorguy;
  level._id_EC85["readyroom_door_guy"]["readyroom_traverse_b_doorguy_idle"][0] = % hs_readyroom_hall_traverse_sec_b_idle_doorguy;
  level._id_EC85["readyroom_door_guy"]["readyroom_traverse_b_doorguy_intro_idle"][0] = % hm_grnd_red_cover_right_stand_hide_idle_ar;
  level._id_EC85["readyroom_ally1"]["reinforcements_enter"] = % heistspace_readyroom_reinforcements_ally1_enter;
  level._id_EC85["readyroom_ally1"]["reinforcements_loop"][0] = % heistspace_readyroom_reinforcements_ally1_loop;
  level._id_EC85["readyroom_ally2"]["reinforcements_enter"] = % heistspace_readyroom_reinforcements_ally2_enter;
  level._id_EC85["readyroom_ally2"]["reinforcements_loop"][0] = % heistspace_readyroom_reinforcements_ally2_loop;
  level._id_EC85["readyroom_ally3"]["reinforcements_enter"] = % heistspace_readyroom_reinforcements_ally3_enter;
  level._id_EC85["readyroom_ally3"]["reinforcements_loop"][0] = % heistspace_readyroom_reinforcements_ally3_loop;
  level._id_EC85["readyroom_medic"]["injury_approach_loop"][0] = % heistspace_readyroom_medic_approach_loop;
  level._id_EC85["readyroom_medic"]["injury_approach_enter"] = % heistspace_readyroom_medic_enter;
  level._id_EC85["readyroom_medic"]["injury_approach_exit_loop"][0] = % heistspace_readyroom_medic_exit_loop;
  level._id_EC85["readyroom_injured1"]["injury_approach_loop"][0] = % heistspace_readyroom_injured1_approach_loop;
  level._id_EC85["readyroom_injured1"]["injury_approach_enter"] = % heistspace_readyroom_injured1_enter;
  level._id_EC85["readyroom_injured1"]["injury_approach_exit_loop"][0] = % heistspace_readyroom_injured1_exit_loop;
  level._id_EC85["readyroom_injured2"]["injury_approach_enter"] = % heistspace_readyroom_injured2_enter;
  level._id_EC85["readyroom_injured2"]["injury_approach_exit_loop"][0] = % heistspace_readyroom_injured2_exit_loop;
  level._id_EC85["readyroom_hall_runner1"]["deploy_hall_c6"] = % heistspace_readyroom_hall_runner_ally1;
  level._id_EC85["readyroom_hall_runner2"]["deploy_hall_c6"] = % heistspace_readyroom_hall_runner_ally2;
  level._id_EC85["salter"]["hall_traverse_a_idle"][0] = % hm_grnd_red_cover_right_stand_hide_idle_ar;
  level._id_EC85["salter"]["hall_traverse_a"] = % hs_ordnance_hall_traverse_sec_a_xo;
  level._id_EC85["salter"]["hall_traverse_b"] = % hs_ordnance_hall_traverse_sec_b_xo;
  level._id_EC85["salter"]["hall_traverse_branch_intro"] = % hs_ordnance_hall_traverse_branch_intro_xo;
  level._id_EC85["salter"]["hall_traverse_branch_idle"][0] = % hm_grnd_yel_patrol_creepwalk_idle_ar_03;
  level._id_EC85["salter"]["hall_traverse_branch_outro"] = % hs_ordnance_hall_traverse_branch_outro_xo;
  level._id_EC85["salter"]["hall_traverse_end_loop"][0] = % hs_ordnance_hall_traverse_sec_b_end_loop_xo;
  level._id_EC85["salter"]["check_ordnance_enter"] = % heist_space_check_ordnance_xo_enter;
  level._id_EC85["salter"]["check_ordnance_loop"][0] = % heist_space_check_ordnance_xo_loop;
  level._id_EC85["salter"]["check_ordnance_exit"] = % heist_space_check_ordnance_xo_exit;
}

#using_animtree("c6");

_id_3353() {
  level._id_EC85["c6"]["injury_approach_enter"] = % heistspace_readyroom_c6_enter;
  level._id_EC85["c6"]["injury_approach_exit_loop"][0] = % heistspace_readyroom_c6_exit_loop;
  level._id_EC85["deploy_c6_1"]["deploy_hall_c6"] = % heistspace_readyroom_hall_deployed_c6_1;
  level._id_EC85["deploy_c6_2"]["deploy_hall_c6"] = % heistspace_readyroom_hall_deployed_c6_2;
  level._id_EC85["c6_runner1"]["hall_c6_runner"] = % heistspace_comms_hall_runner_c6_1;
  level._id_EC85["c6_runner2"]["hall_c6_runner"] = % heistspace_comms_hall_runner_c6_2;
  level._id_EC85["c6_injured1"]["hall_c6_injured1"][0] = % heistspace_comms_hall_injured_c6_1;
  level._id_EC85["c6_injured2"]["hall_c6_injured2"][0] = % heistspace_comms_hall_injured_c6_2;
  level._id_EC85["c6_injured3"]["hall_c6_injured3"][0] = % heistspace_comms_hall_injured_c6_3;
}

_id_3508() {}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["bridge_door_pull"] = % shipcrib_player_door_right_pull;
  level._id_EC85["player_rig"]["door_right_push_long_open"] = % shipcrib_plr_door_right_push_long;
  level._id_EC85["player_rig"]["door_right_push_long_hold"][0] = % shipcrib_plr_door_right_push_long_hold;
  level._id_EC85["player_rig"]["door_right_push_long_close"] = % shipcrib_plr_door_right_push_long_close;
  level._id_EC85["player_rig"]["bridge_intro"] = % heistspace_om130_bridge_intro_player;
  scripts\sp\anim::_id_17FC("player_rig", "start_fspar_ui", "start_ui", "bridge_intro");
  level._id_EC85["player_rig"]["sitdown"][0] = % heistspace_bridge_player_loop;
  level._id_EC85["player_rig"]["bridge_pcap"] = % heistspace_bridge_player;
  level._id_EC85["player_rig"]["plr_elevator_button"] = % heistspace_elevator_console_use_plr;
  level._id_EC85["player_rig"]["check_ordnance_exit"] = % heist_space_check_ordnance_plr_exit;
  level._id_EC85["player_rig"]["outro"] = % hs_outro_monscrash_plr;
  scripts\sp\anim::_id_17FC("player_rig", "pvo_heistspace_plr_metal1thisisitl", "crash_blur_out_01", "outro");
  scripts\sp\anim::_id_17FC("player_rig", "vo_heistspace_eth_maydaymaydaymay", "crash_blur_out_02", "outro");
  scripts\sp\anim::_id_17FC("player_rig", "pvo_heistspace_plr_nosalt", "crash_blur_out_03", "outro");
}

#using_animtree("vehicles");

_id_13267() {
  level._id_EC87["crash_mover"] = #animtree;
  level._id_EC8C["crash_mover"] = "tag_origin";
  level._id_EC85["crash_mover"]["outro"] = % hs_outro_monscrash_player_jackal_mover;
}

#using_animtree("jackal");

_id_A056() {
  level._id_EC87["crash_player_jackal"] = #animtree;
  level._id_EC8C["crash_player_jackal"] = "veh_mil_air_un_jackal_02";
  level._id_EC85["crash_player_jackal"]["outro"] = % hs_outro_monscrash_player_jackal;
}

#using_animtree("script_model");

_id_EE25() {
  level._id_EC87["door"] = #animtree;
  level._id_EC8C["door"] = "sdf_door_metal_hinged_01_anim";
  level._id_EC85["door"]["bridge_door_pull"] = % shipcrib_door_right_pull_open;
  level._id_EC85["door"]["door_right_push_long_open"] = % shipcrib_door_right_push_long_open;
  level._id_EC85["door"]["door_right_push_long_hold"][0] = % shipcrib_door_right_push_long_hold;
  level._id_EC85["door"]["door_right_push_long_close"] = % shipcrib_door_right_push_long_close;
  level._id_EC87["ordnance_door"] = #animtree;
  level._id_EC8C["ordnance_door"] = "sdf_door_metal_hinged_01_anim";
  level._id_EC85["ordnance_door"]["check_ordnance_exit"] = % heist_space_check_ordnance_door_exit;
  level._id_EC87["panel"] = #animtree;
  level._id_EC8C["panel"] = "bi_command_center_panel_19";
  level._id_EC85["panel"]["check_ordnance_enter"] = % heist_space_check_ordnance_panel_enter;
  level._id_EC85["panel"]["check_ordnance_loop"][0] = % heist_space_check_ordnance_panel_loop;
  level._id_EC85["panel"]["check_ordnance_exit"] = % heist_space_check_ordnance_panel_exit;
  level._id_EC87["barrel01"] = #animtree;
  level._id_EC8C["barrel01"] = "container_space_barrel_01";
  level._id_EC85["barrel01"]["check_ordnance_exit"] = % heist_space_check_ordnance_barrel01;
  level._id_EC87["barrel02"] = #animtree;
  level._id_EC8C["barrel02"] = "container_space_barrel_01";
  level._id_EC85["barrel02"]["check_ordnance_exit"] = % heist_space_check_ordnance_barrel02;
  level._id_EC87["barrel03"] = #animtree;
  level._id_EC8C["barrel03"] = "container_space_barrel_01";
  level._id_EC85["barrel03"]["check_ordnance_exit"] = % heist_space_check_ordnance_barrel03;
  level._id_EC87["barrel04"] = #animtree;
  level._id_EC8C["barrel04"] = "container_space_barrel_01";
  level._id_EC85["barrel04"]["check_ordnance_exit"] = % heist_space_check_ordnance_barrel04;
  level._id_EC87["barrel05"] = #animtree;
  level._id_EC8C["barrel05"] = "container_space_barrel_01";
  level._id_EC85["barrel05"]["check_ordnance_exit"] = % heist_space_check_ordnance_barrel05;
  level._id_EC87["crate01"] = #animtree;
  level._id_EC8C["crate01"] = "shipping_frame_crates";
  level._id_EC85["crate01"]["check_ordnance_exit"] = % heist_space_check_ordnance_crate01;
  level._id_EC87["crate02"] = #animtree;
  level._id_EC8C["crate02"] = "sdf_missile_carraige";
  level._id_EC85["crate02"]["check_ordnance_exit"] = % heist_space_check_ordnance_crate02;
  level._id_EC87["crate03"] = #animtree;
  level._id_EC8C["crate03"] = "shipping_frame_crates";
  level._id_EC85["crate03"]["check_ordnance_exit"] = % heist_space_check_ordnance_crate03;
  level._id_EC87["debris01"] = #animtree;
  level._id_EC8C["debris01"] = "hallway_frame_segment_single_32";
  level._id_EC85["debris01"]["check_ordnance_exit"] = % heist_space_check_ordnance_debris01;
  level._id_EC87["debris02"] = #animtree;
  level._id_EC8C["debris02"] = "hallway_frame_segment_single_corner";
  level._id_EC85["debris02"]["check_ordnance_exit"] = % heist_space_check_ordnance_debris02;
  level._id_EC87["screen"] = #animtree;
  level._id_EC8C["screen"] = "equipment_industrial_titan_console_01_screen_damaged";
  level._id_EC85["screen"]["check_ordnance_exit"] = % heist_space_check_ordnance_screen;
  level._id_EC87["crash_mons"] = #animtree;
  level._id_EC8C["crash_mons"] = "tag_origin";
  level._id_EC85["crash_mons"]["outro"] = % hs_outro_monscrash_mons;
  level._id_EC87["crash_ret"] = #animtree;
  level._id_EC8C["crash_ret"] = "tag_origin";
  level._id_EC85["crash_ret"]["outro"] = % hs_outro_monscrash_retribution;
  level._id_EC87["crash_salter"] = #animtree;
  level._id_EC8C["crash_salter"] = "veh_mil_air_un_jackal_02";
  level._id_EC85["crash_salter"]["outro"] = % hs_outro_monscrash_salter;
  level._id_EC87["crash_shipyard"] = #animtree;
  level._id_EC8C["crash_shipyard"] = "tag_origin";
  level._id_EC85["crash_shipyard"]["outro"] = % hs_outro_monscrash_shipyard;
  level._id_EC87["crash_vista_destroyer"] = #animtree;
  level._id_EC8C["crash_vista_destroyer"] = "generic_prop_x10";
  level._id_EC85["crash_vista_destroyer"]["outro"] = % hs_outro_monscrash_sdf_ships;
  level._id_EC87["crash_mars"] = #animtree;
  level._id_EC8C["crash_mars"] = "generic_prop_x3";
  level._id_EC85["crash_mars"]["outro"] = % hs_outro_monscrash_mars;
}