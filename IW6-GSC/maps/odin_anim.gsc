/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\odin_anim.gsc
*****************************************************/

main() {
  generic_human();
  script_model();
  player();
  vehicles();
  dialog();
}

#using_animtree("generic_human");

generic_human() {
  level.scr_anim["generic"]["traverse_inverted_192"] = % space_traversal_jump_180_u;
  level.scr_animtree["generic"] = #animtree;
  level.scr_anim["generic"]["odin_intro_suit_sway"][0] = % odin_intro_suit_sway;
  level.scr_animtree["decomp_legs"] = #animtree;
  level.scr_anim["decomp_legs"]["odin_escape_spin_room_player_body"] = % odin_escape_spin_room_player_body;
  level.scr_model["decomp_legs"] = "fullbody_us_space_kyra";
  level.scr_anim["odin_ally"]["odin_hall_escape_turn01_ally"] = % odin_hallway_escape_turn01_ally01;
  level.scr_anim["odin_ally"]["odin_hallway_escape_turn01_loop_ally01"][0] = % odin_hallway_escape_turn01_loop_ally01;
  level.scr_anim["odin_ally"]["odin_hall_escape_turn02_ally"] = % odin_hallway_escape_turn02_ally01;
  level.scr_anim["odin_ally"]["space_pain_1"] = % space_pain_1;
  level.scr_anim["odin_ally"]["odin_intro_kyra_satellite_idle"] = % odin_intro_kyra_satellite_idle;
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_kyr_budyoushouldbe", maps\odin_intro::intro_vin_ln_1);
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_cub_iseeittoo", maps\odin_intro::intro_vin_ln_2);
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_kyr_okbudcomeon", maps\odin_intro::intro_vin_ln_3);
  level.scr_anim["odin_ally"]["odin_intro_kyra_turn"] = % odin_intro_kyra_turn;
  level.scr_anim["odin_ally"]["intro_exterior_scene"] = % odin_intro_kyra;
  level.scr_anim["odin_ally"]["odin_intro_kyra_idle"][0] = % odin_intro_kyra_idle;
  level.scr_anim["odin_ally"]["odin_intro_kyra_wait_idle"][0] = % odin_intro_kyra_wait_idle;
  level.scr_anim["odin_ally"]["odin_infiltrate_kyra_entrance"] = % odin_infiltrate_kyra_entrance;
  level.scr_anim["odin_ally"]["odin_infiltrate_kyra_midpoint_idle"][0] = % odin_infiltrate_kyra_midpoint_idle;
  level.scr_anim["odin_ally"]["odin_infiltrate_kyra_to_door"] = % odin_infiltrate_kyra_to_door;
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_ast1_pressurizingairlock", maps\odin_intro::mosley_airlock_ln_1);
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_ast1_reallylookingforwardto", maps\odin_intro::mosley_airlock_ln_2);
  level.scr_anim["odin_ally"]["odin_infiltrate_kyra_door_idle"][0] = % odin_infiltrate_kyra_door_idle;
  level.scr_anim["odin_ally"]["odin_infiltrate_kyra_start"] = % odin_infiltrate_kyra_start;
  level.scr_anim["odin_ally"]["odin_infiltrate_kyra"] = % odin_infiltrate_kyra;
  maps\_anim::addnotetrack_customfunction("odin_ally", "odin_infiltrate_round_door", maps\odin_ally::invasion_door_shut);
  maps\_anim::addnotetrack_customfunction("odin_ally", "odin_infiltrate_escape_door", maps\odin_ally::shut_post_infil_door_flag);
  level.scr_anim["odin_ally"]["odin_infiltrate_kyra_no_push"] = % odin_infiltrate_kyra_no_push;
  maps\_anim::addnotetrack_customfunction("odin_ally", "odin_infiltrate_round_door", maps\odin_ally::invasion_door_shut);
  maps\_anim::addnotetrack_customfunction("odin_ally", "odin_infiltrate_escape_door", maps\odin_ally::shut_post_infil_door_flag);
  level.scr_anim["odin_ally"]["odin_infiltrate_kyra_escape_idle"][0] = % odin_infiltrate_kyra_escape_idle;
  level.scr_anim["odin_invader_01"]["odin_infiltrate"] = % odin_infiltrate_baddy_01;
  level.scr_anim["odin_invader_02"]["odin_infiltrate"] = % odin_infiltrate_baddy_02;
  level.scr_anim["odin_invader_03"]["odin_infiltrate"] = % odin_infiltrate_baddy_06;
  level.scr_anim["odin_invader_04"]["odin_infiltrate"] = % odin_infiltrate_baddy_04;
  level.scr_anim["odin_invader_05"]["odin_infiltrate"] = % odin_infiltrate_baddy_05;
  level.scr_anim["odin_victim_01"]["odin_infiltrate"] = % odin_infiltrate_red_shirt_01;
  maps\_anim::addnotetrack_customfunction("odin_victim_01", "fx_infil_red_shirt_die", maps\odin_fx::fx_infil_red_shirt_die);
  level.scr_anim["odin_victim_02"]["odin_infiltrate"] = % odin_infiltrate_red_shirt_02;
  maps\_anim::addnotetrack_customfunction("odin_victim_02", "fx_infil_red_shirt_die", maps\odin_fx::fx_infil_red_shirt_die);
  level.scr_anim["odin_victim_01"]["odin_infiltrate_idle"][0] = % odin_infiltrate_red_shirt_01_idle;
  level.scr_anim["odin_victim_02"]["odin_infiltrate_idle"][0] = % odin_infiltrate_red_shirt_02_idle;
  maps\_anim::addnotetrack_customfunction("odin_victim_02", "odin_infiltrate_enemy_door", maps\odin_ally::open_enemy_infiltration_door_flag);
  level.scr_anim["odin_victim_02"]["odin_infiltrate_wave"][0] = % odin_infiltrate_red_shirt_02_wave;
  level.scr_anim["odin_victim_03"]["odin_infiltrate_idle"][0] = % odin_infiltrate_red_shirt_03_idle;
  level.scr_anim["odin_victim_03"]["odin_infiltrate"] = % odin_infiltrate_red_shirt_03;
  maps\_anim::addnotetrack_customfunction("odin_victim_03", "fx_infil_red_shirt_die", maps\odin_fx::fx_infil_red_shirt_die);
  level.scr_animtree["odin_opfor"] = #animtree;
  level.scr_anim["odin_opfor"]["gun_struggle_intro_throw"] = % odin_intro_to_weapon_begin_struggle_opfor;
  level.scr_model["odin_opfor"] = "body_fed_space_assault_b";
  level.scr_anim["odin_ally"]["gun_struggle_intro"] = % odin_intro_to_weapon_struggle_ally;
  level.scr_anim["odin_opfor"]["gun_struggle_intro"] = % odin_intro_to_weapon_struggle_opfor;
  level.scr_anim["odin_redshirt"]["gun_struggle_intro"] = % odin_intro_to_weapon_struggle_redshirt;
  level.scr_anim["odin_ally"]["gun_struggle_intro_loop"][0] = % odin_intro_to_weapon_struggle_loop_ally;
  level.scr_anim["odin_opfor"]["gun_struggle_intro_loop"][0] = % odin_intro_to_weapon_struggle_loop_opfor;
  level.scr_anim["odin_ally"]["gun_struggle_intro_throw"] = % odin_intro_to_weapon_begin_struggle_ally;
  maps\_anim::addnotetrack_customfunction("odin_ally", "door_opens", maps\odin_ally::struggle_door_opens);
  level.scr_anim["odin_opfor"]["gun_struggle_intro_throw"] = % odin_intro_to_weapon_begin_struggle_opfor;
  maps\_anim::addnotetrack_customfunction("odin_opfor", "start_player_knock_anim", maps\odin_ally::set_player_anim_flag);
  maps\_anim::addnotetrack_customfunction("odin_opfor", "start_spin", maps\odin_ally::start_struggle_spin);
  level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_range_opfor"] = % odin_hallway_weapon_struggle_range_opfor;
  level.scr_anim["odin_opfor"]["odin_pyl_translatednostopno"] = % odin_hallway_weapon_struggle_range_opfor_face;
  maps\_anim::addnotetrack_customfunction("odin_opfor", "YOLO_odin_pyl_translatednostopno", maps\odin_ally::struggle_guy_line);
  level.scr_anim["odin_ally"]["odin_hallway_weapon_struggle_down_ally01"] = % odin_hallway_weapon_struggle_down_ally01;
  level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_down_opfor"] = % odin_hallway_weapon_struggle_down_opfor;
  level.scr_anim["odin_ally"]["odin_hallway_weapon_struggle_up_ally01"] = % odin_hallway_weapon_struggle_up_ally01;
  level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_up_opfor"] = % odin_hallway_weapon_struggle_up_opfor;
  level.scr_anim["odin_ally"]["odin_hallway_weapon_struggle_left_ally01"] = % odin_hallway_weapon_struggle_left_ally01;
  level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_left_opfor"] = % odin_hallway_weapon_struggle_left_opfor;
  level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_left_opfor_add"] = % odin_hallway_weapon_struggle_left_opfor_add;
  level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_right_opfor_add"] = % odin_hallway_weapon_struggle_right_opfor_add;
  level.scr_anim["odin_ally"]["odin_hallway_weapon_struggle_right_ally01"] = % odin_hallway_weapon_struggle_right_ally01;
  level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_right_opfor"] = % odin_hallway_weapon_struggle_right_opfor;
  level.scr_anim["odin_ally"]["odin_hallway_weapon_struggle_center_ally01"] = % odin_hallway_weapon_struggle_center_ally01;
  level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_center_opfor"] = % odin_hallway_weapon_struggle_center_opfor;
  level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_fail"] = % odin_hallway_weapon_struggle_fail_opfor;
  level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_shoot"] = % odin_hallway_weapon_struggle_shoot_opfor;
  level.scr_anim["odin_opfor"]["odin_escape_first_encounter_opfor"] = % odin_escape_first_encounter_opfor;
  level.scr_anim["odin_redshirt"]["odin_escape_first_encounter_redshirt"] = % odin_escape_first_encounter_redshirt;
  level.scr_anim["odin_opfor"]["odin_escape_first_encounter_opfor02"] = % odin_escape_first_encounter_opfor02;
  level.scr_anim["odin_redshirt"]["odin_escape_first_encounter_redshirt02"] = % odin_escape_first_encounter_redshirt02;
  level.scr_anim["odin_ally"]["odin_escape_first_encounter_loop_ally01"][0] = % odin_escape_first_encounter_loop_ally01;
  level.scr_anim["odin_ally"]["odin_escape_first_encounter_end_ally01"] = % odin_escape_first_encounter_end_ally01;
  level.scr_anim["odin_ally"]["odin_escape_start_first_encounter_loop_ally01"][0] = % odin_escape_start_first_encounter_loop_ally01;
  level.scr_anim["odin_ally"]["odin_escape_first_encounter_ally01"] = % odin_escape_first_encounter_ally01;
  level.scr_anim["odin_ally"]["odin_escape_first_encounter_end_loop_ally01"][0] = % odin_escape_first_encounter_end_loop_ally01;
  level.scr_anim["odin_ally"]["odin_escape_zigzag_start_ally01"] = % odin_escape_zigzag_start_ally01;
  level.scr_anim["odin_ally"]["odin_escape_zigzag_start_loop_ally01"][0] = % odin_escape_zigzag_start_loop_ally01;
  level.scr_anim["odin_ally"]["odin_escape_open_door_player"] = % odin_escape_zigzag_door_ally01;
  level.scr_anim["odin_ally"]["odin_escape_zigzag_second_ally01"] = % odin_escape_zigzag_second_ally01;
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_ast1_ohnoodinis", maps\odin_escape::window_vo_01);
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_kyr_theyreuploadingmore", maps\odin_escape::window_vo_02);
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_ast1_houstonwhatdowe", maps\odin_escape::window_vo_03);
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_ho2_odincontrolwehave", maps\odin_escape::window_vo_04);
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_ho2_imsorrymosley", maps\odin_escape::window_vo_05);
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_ast1_copyhouston", maps\odin_escape::window_vo_06);
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_kyr_budweneedto_2", maps\odin_escape::window_vo_07);
  level.scr_anim["odin_ally"]["odin_escape_zigzag_second_loop_ally01"][0] = % odin_escape_zigzag_second_loop_ally01;
  level.scr_anim["odin_ally"]["odin_escape_zigzag_third_ally01"] = % odin_escape_zigzag_third_ally01;
  level.scr_anim["odin_ally"]["odin_escape_zigzag_third_loop_ally01"][0] = % odin_escape_zigzag_third_loop_ally01;
  level.scr_anim["odin_ally"]["odin_escape_zigzag_fourth_ally01"] = % odin_escape_zigzag_fourth_ally01;
  level.scr_anim["odin_ally"]["odin_escape_zigzag_fourth_loop_ally01"][0] = % odin_escape_zigzag_fourth_loop_ally01;
  level.scr_anim["odin_ally"]["odin_escape_zigzag_to_spin_ally01"] = % odin_escape_zigzag_to_spin_ally01;
  level.scr_anim["odin_ally"]["odin_escape_zigzag_to_spin_loop_ally01"][0] = % odin_escape_zigzag_to_spin_loop_ally01;
  level.scr_anim["odin_ally"]["odin_escape_spin_room_ally01"] = % odin_escape_spin_room_ally01;
  maps\_anim::addnotetrack_customfunction("odin_ally", "start_odin_escape_spin_room_player", ::decomp_explosion_anim_player);
  maps\_anim::addnotetrack_customfunction("odin_ally", "fx_solar_panel_collision_kyra", maps\odin_fx::fx_solar_panel_collision_kyra);
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_kyr_houston", maps\odin_spin::decomp_anim_line_1);
  maps\_anim::addnotetrack_customfunction("odin_ally", "YOLO_odin_kyr_houstonbudandi", maps\odin_spin::decomp_anim_line_2);
  level.scr_anim["odin_ally"]["odin_escape_zigzag_to_spin_ally01"] = % odin_escape_zigzag_to_spin_ally01;
  level.scr_anim["generic"]["odin_escape_spin_room_opfor01"] = % odin_escape_spin_room_opfor01;
  level.scr_anim["generic"]["odin_escape_spin_room_opfor02"] = % odin_escape_spin_room_opfor02;
  level.scr_anim["generic"]["odin_spin_struggling_enemy_01_loop"][0] = % odin_spin_struggling_enemy_01;
  level.scr_anim["generic"]["odin_spin_struggling_enemy_02_loop"][0] = % odin_spin_struggling_enemy_02;
  level.scr_anim["generic"]["odin_escape_spin_opfor_death_01"] = % odin_escape_spin_opfor_death_01;
  level.scr_anim["generic"]["odin_escape_spin_opfor_death_02"] = % odin_escape_spin_opfor_death_02;
  level.scr_anim["generic"]["odin_escape_spin_opfor_death_03"] = % odin_escape_spin_opfor_death_03;
  level.scr_anim["generic"]["odin_escape_spin_opfor_death_04"] = % odin_escape_spin_opfor_death_04;
  level.scr_anim["generic"]["odin_escape_spin_opfor_death_05"] = % odin_escape_spin_opfor_death_05;
  level.scr_anim["odin_ally"]["satellite_end_start_loop"][0] = % odin_satellite_end_start_kyra_loop;
  level.scr_anim["odin_ally"]["satellite_end_cover_lift"] = % odin_satellite_end_cover_lift_kyra;
  maps\_anim::addnotetrack_customfunction("odin_ally", "show_kyra_gun", maps\odin_satellite::ally_gun_hide);
  level.scr_anim["odin_ally"]["satellite_end_explosion_01"] = % odin_satellite_end_explosion_01_kyra;
  level.scr_anim["odin_ally"]["satellite_end_explosion_02"] = % odin_satellite_end_explosion_02_kyra;
  level.scr_anim["odin_ally"]["satellite_end_shoot_01"][0] = % odin_satellite_end_shoot_01_kyra;
  level.scr_anim["odin_ally"]["satellite_end_shoot_02"][0] = % odin_satellite_end_shoot_02_kyra;
  level.scr_anim["odin_ally"]["satellite_end_start"] = % odin_satellite_end_start_kyra;
  maps\_anim::addnotetrack_customfunction("odin_ally", "hide_kyra_gun", maps\odin_satellite::ally_gun_show);
}

#using_animtree("script_model");

script_model() {
  level.scr_animtree["space_escape_pack"] = #animtree;
  level.scr_anim["space_escape_pack"]["odin_escape_zigzag_bag_01"] = % odin_escape_zigzag_bag_01;
  level.scr_model["space_escape_pack"] = "space_interior_pack_round";
  level.scr_anim["space_escape_pack"]["odin_escape_zigzag_bag_02"] = % odin_escape_zigzag_bag_02;
  level.scr_animtree["space_storage_container_01"] = #animtree;
  level.scr_anim["space_storage_container_01"]["decompression_props"] = % odin_escape_spin_room_opfor01_crate;
  level.scr_model["space_storage_container_01"] = "space_storage_container_01";
  level.scr_animtree["space_ata_box"] = #animtree;
  level.scr_anim["space_ata_box"]["decompression_props"] = % odin_escape_spin_room_opfor02_crate;
  level.scr_model["space_ata_box"] = "space_ata_box";
  level.scr_animtree["decomp_crate_01"] = #animtree;
  level.scr_anim["decomp_crate_01"]["decompression_props"] = % odin_escape_spin_room_anim_crate01;
  level.scr_animtree["decomp_crate_02"] = #animtree;
  level.scr_anim["decomp_crate_02"]["decompression_props"] = % odin_escape_spin_room_anim_crate02;
  level.scr_animtree["decomp_crate_03"] = #animtree;
  level.scr_anim["decomp_crate_03"]["decompression_props"] = % odin_escape_spin_room_anim_crate03;
  level.scr_animtree["decomp_pannel_01"] = #animtree;
  level.scr_anim["decomp_pannel_01"]["decompression_props"] = % odin_escape_spin_room_back_pannel01;
  level.scr_model["decomp_pannel_01"] = "tag_origin";
  level.scr_animtree["decomp_pannel_02"] = #animtree;
  level.scr_anim["decomp_pannel_02"]["decompression_props"] = % odin_escape_spin_room_back_pannel02;
  level.scr_model["decomp_pannel_02"] = "tag_origin";
  level.scr_animtree["decomp_pannel_03"] = #animtree;
  level.scr_anim["decomp_pannel_03"]["decompression_props"] = % odin_escape_spin_room_back_pannel03;
  level.scr_model["decomp_pannel_03"] = "tag_origin";
  level.scr_animtree["decomp_pannel_04"] = #animtree;
  level.scr_anim["decomp_pannel_04"]["decompression_props"] = % odin_escape_spin_room_back_pannel04;
  level.scr_model["decomp_pannel_04"] = "tag_origin";
  level.scr_animtree["decomp_pannel_05"] = #animtree;
  level.scr_anim["decomp_pannel_05"]["decompression_props"] = % odin_escape_spin_room_back_pannel05;
  level.scr_model["decomp_pannel_05"] = "tag_origin";
  level.scr_animtree["decomp_pannel_06"] = #animtree;
  level.scr_anim["decomp_pannel_06"]["decompression_props"] = % odin_escape_spin_room_back_pannel06;
  level.scr_model["decomp_pannel_06"] = "tag_origin";
  level.scr_animtree["opfor01_crate"] = #animtree;
  level.scr_anim["opfor01_crate"]["decompression_props"] = % odin_escape_spin_room_opfor01_crate;
  level.scr_model["opfor01_crate"] = "tag_origin";
  level.scr_animtree["opfor02_crate"] = #animtree;
  level.scr_anim["opfor02_crate"]["decompression_props"] = % odin_escape_spin_room_opfor02_crate;
  level.scr_model["opfor02_crate"] = "tag_origin";
  level.scr_animtree["decomp_solar_panel"] = #animtree;
  level.scr_anim["decomp_solar_panel"]["decompression_props"] = % odin_escape_spin_room_solar_panel;
  level.scr_model["decomp_solar_panel"] = "space_debris_solar_panel_01_anim";
  maps\_anim::addnotetrack_customfunction("decomp_solar_panel", "fx_solar_panel_collision_01", maps\odin_fx::fx_spin_solar_panel_collision_01);
  maps\_anim::addnotetrack_customfunction("decomp_solar_panel", "fx_solar_panel_collision_02", maps\odin_fx::fx_spin_solar_panel_collision_02);
  level.scr_animtree["shuttle"] = #animtree;
  level.scr_anim["shuttle"]["odin_intro_shuttle"] = % odin_intro_shuttle;
  level.scr_model["shuttle"] = "vehicle_space_shuttle";
  level.scr_animtree["wires"] = #animtree;
  level.scr_anim["wires"]["satellite_end_explosion_01"] = % odin_satellite_end_explosion_01_wire;
  level.scr_model["wires"] = "odin_sat_wire";
  level.scr_anim["wires"]["satellite_end_explosion_02"] = % odin_satellite_end_explosion_02_wire;
  level.scr_anim["wires"]["satellite_end_shoot_01"][0] = % odin_satellite_end_shoot_01_wire;
  level.scr_anim["wires"]["satellite_end_shoot_02"][0] = % odin_satellite_end_shoot_02_wire;
  level.scr_animtree["wires2"] = #animtree;
  level.scr_anim["wires2"]["satellite_end_explosion_01"] = % odin_satellite_end_explosion_01_wire_02;
  level.scr_model["wires2"] = "odin_sat_wire";
  level.scr_anim["wires2"]["satellite_end_shoot_02"][0] = % odin_satellite_end_shoot_02_wire_02;
  level.scr_anim["wires2"]["satellite_end_explosion_02"] = % odin_satellite_end_explosion_02_wire_02;
  level.scr_animtree["wires3"] = #animtree;
  level.scr_anim["wires3"]["satellite_end_explosion_01"] = % odin_satellite_end_explosion_01_wire_03;
  level.scr_model["wires3"] = "odin_sat_wire";
  level.scr_anim["wires3"]["satellite_end_shoot_02"][0] = % odin_satellite_end_shoot_02_wire_03;
  level.scr_anim["wires3"]["satellite_end_explosion_02"] = % odin_satellite_end_explosion_02_wire_03;
  level.scr_animtree["wires4"] = #animtree;
  level.scr_anim["wires4"]["satellite_end_explosion_01"] = % odin_satellite_end_explosion_01_wire_04;
  level.scr_model["wires4"] = "odin_sat_wire";
  level.scr_anim["wires4"]["satellite_end_shoot_02"][0] = % odin_satellite_end_shoot_02_wire_04;
  level.scr_anim["wires4"]["satellite_end_explosion_02"] = % odin_satellite_end_explosion_02_wire_04;
  level.scr_animtree["wires5"] = #animtree;
  level.scr_anim["wires5"]["satellite_end_explosion_01"] = % odin_satellite_end_explosion_01_wire_05;
  level.scr_model["wires5"] = "odin_sat_wire";
  level.scr_anim["wires5"]["satellite_end_shoot_02"][0] = % odin_satellite_end_shoot_02_wire_05;
  level.scr_anim["wires5"]["satellite_end_explosion_02"] = % odin_satellite_end_explosion_02_wire_05;
  level.scr_animtree["finale_gun"] = #animtree;
  level.scr_anim["finale_gun"]["satellite_end_explosion_01_gun"] = % odin_satellite_end_explosion_01_gun;
  level.scr_model["finale_gun"] = "viewmodel_space_tar21";
  level.scr_animtree["kyra_gun"] = #animtree;
  level.scr_anim["kyra_gun"]["odin_escape_first_encounter_end_tar21"] = % odin_escape_first_encounter_end_tar21;
  level.scr_model["kyra_gun"] = "weapon_tar21_space";
  level.scr_anim["finale_gun"]["satellite_end_explosion_02_gun"] = % odin_satellite_end_explosion_02_gun;
  level.scr_animtree["sat_body"] = #animtree;
  level.scr_anim["sat_body"]["satellite_end_explosion_02_Sat"] = % odin_satellite_end_explosion_02_sat_body;
  level.scr_model["sat_body"] = "odin_satellite_body";
  level.scr_anim["sat_body"]["satellite_end_explosion_loop_sat"] = % odin_satellite_end_loop_sat_body;
  level.scr_animtree["space_round_hatch"] = #animtree;
  level.scr_anim["space_round_hatch"]["odin_infiltrate_hatch"] = % odin_infiltrate_round_door;
  level.scr_model["space_round_hatch"] = "space_exterior_round_hatch_01";
  level.scr_anim["space_round_hatch"]["odin_infiltrate_exterior_door_close"] = % odin_infiltrate_exterior_door_close;
  level.scr_anim["space_round_hatch"]["odin_intro_exterior_door_open"] = % odin_intro_exterior_door_open;
  level.scr_animtree["space_square_hatch"] = #animtree;
  level.scr_anim["space_square_hatch"]["odin_infiltrate_door_open"] = % odin_infiltrate_door_open;
  level.scr_model["space_square_hatch"] = "module_door_01_animate";
  level.scr_anim["space_square_hatch"]["odin_infiltrate_escape_door"] = % odin_infiltrate_escape_door;
  level.scr_anim["space_square_hatch"]["odin_infiltrate_enemy_door"] = % odin_infiltrate_enemy_door;
  level.scr_anim["space_square_hatch"]["odin_escape_open_door_player"] = % odin_escape_zigzag_door;
  level.scr_anim["space_square_hatch"]["odin_escape_zigzag_start_door"] = % odin_escape_zigzag_start_door;
  level.scr_animtree["odin_sat_section_01"] = #animtree;
  level.scr_anim["odin_sat_section_01"]["satellite_end_start"] = % odin_satellite_end_sat_top_start;
  level.scr_model["odin_sat_section_01"] = "odin_sat_section_01";
  level.scr_anim["odin_sat_section_01"]["satellite_end_cover_lift"] = % odin_satellite_end_sat_top_cover_lift;
  level.scr_anim["odin_sat_section_01"]["satellite_end_shoot_01"][0] = % odin_satellite_end_sat_top_shoot_01;
  level.scr_anim["odin_sat_section_01"]["satellite_end_shoot_02"][0] = % odin_satellite_end_sat_top_shoot_02;
  level.scr_anim["odin_sat_section_01"]["satellite_end_explosion_01"] = % odin_satellite_end_sat_top_explostion_01;
  level.scr_anim["odin_sat_section_01"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_top_explosion_02;
  level.scr_animtree["odin_sat_cover_01"] = #animtree;
  level.scr_anim["odin_sat_cover_01"]["satellite_end_cover_lift"] = % odin_satellite_end_sat_top_cover_cover_lift;
  level.scr_model["odin_sat_cover_01"] = "odin_sat_cover_01";
  level.scr_anim["odin_sat_cover_01"]["satellite_end_start"] = % odin_satellite_end_sat_top_cover_start;
  level.scr_anim["odin_sat_cover_01"]["satellite_end_shoot_01"][0] = % odin_satellite_end_sat_top_cover_shoot_01;
  level.scr_anim["odin_sat_cover_01"]["satellite_end_shoot_02"][0] = % odin_satellite_end_sat_top_cover_shoot_02;
  level.scr_anim["odin_sat_cover_01"]["satellite_end_explosion_01"] = % odin_satellite_end_sat_top_cover_explostion_01;
  level.scr_anim["odin_sat_cover_01"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_top_cover_explosion_02;
  level.scr_animtree["finale_gun"] = #animtree;
  level.scr_anim["finale_gun"]["satellite_end_start"] = % odin_satellite_end_start_gun;
  level.scr_model["finale_gun"] = "viewmodel_space_tar21";
  level.scr_anim["finale_gun"]["satellite_end_start_gun_loop"][0] = % odin_satellite_end_start_gun_loop;
  level.scr_animtree["odin_sat_section_04_base"] = #animtree;
  level.scr_anim["odin_sat_section_04_base"]["sat_blossom_close"] = % odin_sat_blossom_close_base;
  level.scr_model["odin_sat_section_04_base"] = "odin_sat_section_04_base";
  level.scr_anim["odin_sat_section_04_base"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_base_explosion_02;
  level.scr_animtree["odin_sat_cover_01"] = #animtree;
  level.scr_anim["odin_sat_cover_01"]["sat_blossom_close"] = % odin_sat_blossom_close_cover;
  level.scr_model["odin_sat_cover_01"] = "odin_sat_cover_01";
  level.scr_animtree["odin_sat_section_02_breakup"] = #animtree;
  level.scr_anim["odin_sat_section_02_breakup"]["sat_blossom_close"] = % odin_sat_blossom_close_mid;
  level.scr_model["odin_sat_section_02_breakup"] = "odin_sat_section_02_breakup";
  level.scr_anim["odin_sat_section_02_breakup"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_mid_explosion_02;
  level.scr_animtree["odin_sat_section_03_rot"] = #animtree;
  level.scr_anim["odin_sat_section_03_rot"]["odin_sat_blossom_close_spin"][0] = % odin_sat_blossom_close_spin;
  level.scr_model["odin_sat_section_03_rot"] = "odin_sat_section_03_rot";
  level.scr_anim["odin_sat_section_03_rot"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_rot_explosion_02;
  level.scr_animtree["odin_sat_section_01"] = #animtree;
  level.scr_anim["odin_sat_section_01"]["sat_blossom_close"] = % odin_sat_blossom_close_top;
  level.scr_model["odin_sat_section_01"] = "odin_sat_section_01";
  level.scr_anim["odin_sat_section_01"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_top_explosion_02;
  level.scr_animtree["odin_sat_section_02_solar_wing_01"] = #animtree;
  level.scr_anim["odin_sat_section_02_solar_wing_01"]["sat_blossom_close"] = % odin_sat_blossom_close_blade01;
  level.scr_model["odin_sat_section_02_solar_wing_01"] = "odin_sat_section_02_solar_wing_01";
  level.scr_anim["odin_sat_section_02_solar_wing_01"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_blade01_explosion_02;
  level.scr_animtree["odin_sat_section_02_solar_wing_02"] = #animtree;
  level.scr_anim["odin_sat_section_02_solar_wing_02"]["sat_blossom_close"] = % odin_sat_blossom_close_blade02;
  level.scr_model["odin_sat_section_02_solar_wing_02"] = "odin_sat_section_02_solar_wing_01";
  level.scr_anim["odin_sat_section_02_solar_wing_02"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_blade02_explosion_02;
  level.scr_animtree["odin_sat_section_02_solar_wing_03"] = #animtree;
  level.scr_anim["odin_sat_section_02_solar_wing_03"]["sat_blossom_close"] = % odin_sat_blossom_close_blade03;
  level.scr_model["odin_sat_section_02_solar_wing_03"] = "odin_sat_section_02_solar_wing_01";
  level.scr_anim["odin_sat_section_02_solar_wing_03"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_blade03_explosion_02;
  level.scr_animtree["odin_sat_section_02_solar_wing_04"] = #animtree;
  level.scr_anim["odin_sat_section_02_solar_wing_04"]["sat_blossom_close"] = % odin_sat_blossom_close_blade04;
  level.scr_model["odin_sat_section_02_solar_wing_04"] = "odin_sat_section_02_solar_wing_01";
  level.scr_anim["odin_sat_section_02_solar_wing_04"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_blade04_explosion_02;
  level.scr_animtree["odin_sat_section_04_pod_doorL_01"] = #animtree;
  level.scr_anim["odin_sat_section_04_pod_doorL_01"]["sat_blossom_close"] = % odin_sat_blossom_close_doorl_01;
  level.scr_model["odin_sat_section_04_pod_doorL_01"] = "odin_sat_section_04_pod_door_01";
  level.scr_anim["odin_sat_section_04_pod_doorL_01"]["sat_blossom_open"] = % odin_sat_blossom_open_doorl_01;
  level.scr_anim["odin_sat_section_04_pod_doorL_01"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_doorl01_explosion_02;
  level.scr_animtree["odin_sat_section_04_pod_doorL_02"] = #animtree;
  level.scr_anim["odin_sat_section_04_pod_doorL_02"]["sat_blossom_close"] = % odin_sat_blossom_close_doorl_02;
  level.scr_model["odin_sat_section_04_pod_doorL_02"] = "odin_sat_section_04_pod_door_01";
  level.scr_anim["odin_sat_section_04_pod_doorL_02"]["sat_blossom_open"] = % odin_sat_blossom_open_doorl_02;
  level.scr_anim["odin_sat_section_04_pod_doorL_02"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_doorl02_explosion_02;
  level.scr_animtree["odin_sat_section_04_pod_doorL_03"] = #animtree;
  level.scr_anim["odin_sat_section_04_pod_doorL_03"]["sat_blossom_close"] = % odin_sat_blossom_close_doorl_03;
  level.scr_model["odin_sat_section_04_pod_doorL_03"] = "odin_sat_section_04_pod_door_01";
  level.scr_anim["odin_sat_section_04_pod_doorL_03"]["sat_blossom_open"] = % odin_sat_blossom_open_doorl_03;
  level.scr_anim["odin_sat_section_04_pod_doorL_03"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_doorl03_explosion_02;
  level.scr_animtree["odin_sat_section_04_pod_doorL_04"] = #animtree;
  level.scr_anim["odin_sat_section_04_pod_doorL_04"]["sat_blossom_close"] = % odin_sat_blossom_close_doorl_04;
  level.scr_model["odin_sat_section_04_pod_doorL_04"] = "odin_sat_section_04_pod_door_01";
  level.scr_anim["odin_sat_section_04_pod_doorL_04"]["sat_blossom_open"] = % odin_sat_blossom_open_doorl_04;
  level.scr_anim["odin_sat_section_04_pod_doorL_04"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_doorl04_explosion_02;
  level.scr_animtree["odin_sat_section_04_pod_doorR_01"] = #animtree;
  level.scr_anim["odin_sat_section_04_pod_doorR_01"]["sat_blossom_close"] = % odin_sat_blossom_close_doorr_01;
  level.scr_model["odin_sat_section_04_pod_doorR_01"] = "odin_sat_section_04_pod_door_02";
  level.scr_anim["odin_sat_section_04_pod_doorR_01"]["sat_blossom_open"] = % odin_sat_blossom_open_doorr_01;
  level.scr_anim["odin_sat_section_04_pod_doorR_01"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_doorr01_explosion_02;
  level.scr_animtree["odin_sat_section_04_pod_doorR_02"] = #animtree;
  level.scr_anim["odin_sat_section_04_pod_doorR_02"]["sat_blossom_close"] = % odin_sat_blossom_close_doorr_02;
  level.scr_model["odin_sat_section_04_pod_doorR_02"] = "odin_sat_section_04_pod_door_02";
  level.scr_anim["odin_sat_section_04_pod_doorR_02"]["sat_blossom_open"] = % odin_sat_blossom_open_doorr_02;
  level.scr_anim["odin_sat_section_04_pod_doorR_02"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_doorr02_explosion_02;
  level.scr_animtree["odin_sat_section_04_pod_doorR_03"] = #animtree;
  level.scr_anim["odin_sat_section_04_pod_doorR_03"]["sat_blossom_close"] = % odin_sat_blossom_close_doorr_03;
  level.scr_model["odin_sat_section_04_pod_doorR_03"] = "odin_sat_section_04_pod_door_02";
  level.scr_anim["odin_sat_section_04_pod_doorR_03"]["sat_blossom_open"] = % odin_sat_blossom_open_doorr_03;
  level.scr_anim["odin_sat_section_04_pod_doorR_03"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_doorr03_explosion_02;
  level.scr_animtree["odin_sat_section_04_pod_doorR_04"] = #animtree;
  level.scr_anim["odin_sat_section_04_pod_doorR_04"]["sat_blossom_close"] = % odin_sat_blossom_close_doorr_04;
  level.scr_model["odin_sat_section_04_pod_doorR_04"] = "odin_sat_section_04_pod_door_02";
  level.scr_anim["odin_sat_section_04_pod_doorR_04"]["sat_blossom_open"] = % odin_sat_blossom_open_doorr_04;
  level.scr_anim["odin_sat_section_04_pod_doorR_04"]["satellite_end_explosion_02"] = % odin_satellite_end_sat_doorr04_explosion_02;
  level.scr_animtree["space_crate_01_burned"] = #animtree;
  level.scr_anim["space_crate_01_burned"]["sat_colliders_go"] = % odin_escape_spin_room_collide_01;
  level.scr_model["space_crate_01_burned"] = "space_crate_01_burned";
  level.scr_animtree["space_debris_01"] = #animtree;
  level.scr_anim["space_debris_01"]["sat_colliders_go"] = % odin_escape_spin_room_collide_02;
  level.scr_model["space_debris_01"] = "space_debris_01";
  level.scr_animtree["space_debris_02"] = #animtree;
  level.scr_anim["space_debris_02"]["sat_colliders_go"] = % odin_escape_spin_room_collide_03;
  level.scr_model["space_debris_02"] = "space_debris_01";
  level.scr_animtree["airplane_debris_destroyed_03_iw6a"] = #animtree;
  level.scr_anim["airplane_debris_destroyed_03_iw6a"]["sat_colliders_go"] = % odin_escape_spin_room_collide_04;
  level.scr_model["airplane_debris_destroyed_03_iw6a"] = "airplane_debris_destroyed_03_iw6";
  level.scr_animtree["airplane_debris_destroyed_03_iw6b"] = #animtree;
  level.scr_anim["airplane_debris_destroyed_03_iw6b"]["sat_colliders_go"] = % odin_escape_spin_room_collide_05;
  level.scr_model["airplane_debris_destroyed_03_iw6b"] = "airplane_debris_destroyed_03_iw6";
}

#using_animtree("player");

player() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["intro_exterior_scene"] = % odin_intro_player;
  level.scr_model["player_rig"] = "viewhands_player_us_space";
  level.scr_anim["player_rig"]["odin_infiltrate_player"] = % odin_infiltrate_player;
  level.scr_anim["player_rig"]["odin_infiltrate_player_wipe"] = % odin_infiltrate_player_wipe;
  level.scr_anim["player_rig"]["odin_hall_escape_turn01_player"] = % odin_hallway_escape_turn01_player;
  level.scr_anim["player_rig"]["odin_hall_escape_turn02_player"] = % odin_hallway_escape_turn02_player;
  level.scr_anim["alt_player_rig"]["odin_hall_escape_turn01_player"] = % odin_hallway_escape_turn01_player;
  level.scr_anim["alt_player_rig"]["odin_hall_escape_turn02_player"] = % odin_hallway_escape_turn02_player;
  level.scr_anim["player_rig"]["viewmodel_space_l_arm_sidepush"] = % viewmodel_space_l_arm_sidepush;
  level.scr_anim["player_rig"]["viewmodel_space_l_arm_downpush"] = % viewmodel_space_l_arm_downpush;
  level.scr_anim["player_rig"]["gun_struggle_intro_throw"] = % odin_intro_to_weapon_begin_struggle_player;
  level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_range_player"] = % odin_hallway_weapon_struggle_range_player;
  level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_left_player"] = % odin_hallway_weapon_struggle_left_player;
  level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_left_player_add"] = % odin_hallway_weapon_struggle_left_player_add;
  level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_right_player_add"] = % odin_hallway_weapon_struggle_right_player_add;
  level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_right_player"] = % odin_hallway_weapon_struggle_right_player;
  level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_center_player"] = % odin_hallway_weapon_struggle_center_player;
  level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_up_player"] = % odin_hallway_weapon_struggle_up_player;
  level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_down_player"] = % odin_hallway_weapon_struggle_down_player;
  level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_shoot"] = % odin_hallway_weapon_struggle_shoot_player;
  level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_fail"] = % odin_hallway_weapon_struggle_fail_player;
  level.scr_anim["player_rig"]["odin_escape_open_door_player"] = % odin_escape_open_door_player;
  maps\_anim::addnotetrack_customfunction("player_rig", "odin_escape_zigzag_door", maps\odin_escape::escape_door_open_flag);
  maps\_anim::addnotetrack_customfunction("player_rig", "rumble_light", maps\odin_escape::escape_door_open_rumble);
  level.scr_anim["player_rig"]["odin_escape_spin_room_player"] = % odin_escape_spin_room_player;
  maps\_anim::addnotetrack_customfunction("player_rig", "player_link", ::decomp_anim_notify_player_link);
  maps\_anim::addnotetrack_customfunction("player_rig", "start_slomo", ::decomp_anim_notify_slomo);
  maps\_anim::addnotetrack_customfunction("player_rig", "stop_slomo", ::decomp_anim_notify_end_slomo);
  maps\_anim::addnotetrack_customfunction("player_rig", "anim_done", ::decomp_anim_notify_done);
  maps\_anim::addnotetrack_customfunction("player_rig", "fx_solar_panel_collision_player", maps\odin_fx::fx_solar_panel_collision_player);
  maps\_anim::addnotetrack_customfunction("player_rig", "light_rumble", ::decomp_light_rumble);
  maps\_anim::addnotetrack_customfunction("player_rig", "heavy_rumble", ::decomp_heavy_rumble);
  level.scr_anim["player_rig"]["satellite_end_explosion_01"] = % odin_satellite_end_explosion_01_player;
  level.scr_anim["player_rig"]["satellite_end_explosion_02"] = % odin_satellite_end_explosion_02_player;
  level.scr_anim["player_rig"]["satellite_end_shoot_01"][0] = % odin_satellite_end_shoot_01_player;
  level.scr_anim["player_rig"]["satellite_end_shoot_02"][0] = % odin_satellite_end_shoot_02_player;
  level.scr_anim["player_rig"]["satellite_end_start"] = % odin_satellite_end_start_player;
  level.scr_anim["player_rig"]["satellite_end_start_loop"][0] = % odin_satellite_end_start_loop_player;
  level.scr_anim["player_rig"]["satellite_end_cover_lift"] = % odin_satellite_end_cover_lift_player;
  maps\_anim::addnotetrack_customfunction("player_rig", "cover_lift_latch", maps\odin_satellite::cover_lift_rumble_1);
  maps\_anim::addnotetrack_customfunction("player_rig", "cover_lift_lever", maps\odin_satellite::cover_lift_rumble_2);
}

vehicles() {}

#using_animtree("generic_human");

dialog() {
  level.scr_sound["odin_ally"]["odin_kyr_comeonbud"] = "space_face_null";
  level.scr_sound["odin_ally"]["odin_kyr_whatthehellare"] = "space_face_null";
  level.scr_sound["odin_ally"]["odin_kyr_budineedyour"] = "space_face_null";
  level.scr_sound["odin_ally"]["odin_kyr_hurryandhelpme"] = "space_face_null";
  level.scr_sound["odin_ally"]["odin_kyr_youheardhimbud"] = "space_face_null";
  level.scr_sound["odin_victim_02"]["odin_gs1_budgivemea"] = "space_face_null";
  level.scr_sound["odin_ally"]["odin_kyr_weneedanopsstation"] = "space_face_null";
  level.scr_face["odin_ally"]["odin_kyr_comeonbud"] = % odin_satellite_end_start_kyra_loop_face_01;
  level.scr_face["odin_ally"]["odin_kyr_whatthehellare"] = % odin_satellite_end_start_kyra_loop_face_02;
  level.scr_face["odin_ally"]["odin_kyr_budineedyour"] = % odin_satellite_end_start_kyra_loop_face_03;
  level.scr_face["odin_ally"]["odin_kyr_hurryandhelpme"] = % odin_satellite_end_start_kyra_loop_face_04;
  level.scr_face["odin_victim_02"]["odin_gs1_budgivemea"] = % odin_infiltrate_red_shirt_02_face;
  level.scr_face["odin_ally"]["odin_kyr_youheardhimbud"] = % odin_satellite_end_cover_lift_kyra_face;
  level.scr_face["odin_ally"]["odin_kyr_weneedanopsstation"] = % odin_kyr_weneedanopsstation;
}

vignettes() {
  maps\_vignette_util::vignette_register(::odin_hall_escape_turn01_ally_spawn, "odin_hall_ally_turn01");
  maps\_vignette_util::vignette_register(::odin_hall_escape_turn01_player_spawn, "odin_hall_player_turn01");
  maps\_vignette_util::vignette_register(::odin_hall_escape_turn02_ally_spawn, "odin_hall_ally_turn02");
  maps\_vignette_util::vignette_register(::odin_hall_escape_turn02_player_spawn, "odin_hall_player_turn02");
}

odin_hall_escape_turn01_ally_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("ally_turn01", "hall_escape_turn01_ally");
  odin_hall_escape_turn01_ally(var_0);
  var_0 maps\_vignette_util::vignette_actor_delete();
}

odin_hall_escape_turn01_ally(var_0) {
  var_1 = common_scripts\utility::getstruct("odin_hall_escape_turn01", "script_noteworthy");
  var_2 = [];
  var_2["hall_escape_turn01_ally"] = var_0;
  var_1 maps\_anim::anim_first_frame(var_2, "odin_hall_escape_turn01_ally");
  var_1 maps\_anim::anim_single(var_2, "odin_hall_escape_turn01_ally");
}

odin_hall_escape_turn01_player_spawn() {
  odin_hall_escape_turn01_player();
}

odin_hall_escape_turn01_player() {
  var_0 = common_scripts\utility::getstruct("odin_hall_escape_turn01", "script_noteworthy");
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_1 hide();
  var_2 = [];
  var_2["player_rig"] = var_1;
  var_0 maps\_anim::anim_first_frame(var_2, "odin_hall_escape_turn01_player");
  var_3 = 0;
  level.player playerlinktoblend(var_1, "tag_player", 0.5, 0.15, 0.15);
  wait 0.5;
  level.player playerlinktodelta(var_1, "tag_player", 1, var_3, var_3, var_3, var_3, 1);
  var_1 show();
  var_0 maps\_anim::anim_single(var_2, "odin_hall_escape_turn01_player");
  level.player unlink();
  var_1 delete();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
}

odin_hall_escape_turn02_ally_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("ally_turn02", "hall_escape_turn02_ally");
  odin_hall_escape_turn02_ally(var_0);
  var_0 maps\_vignette_util::vignette_actor_delete();
}

odin_hall_escape_turn02_ally(var_0) {
  var_1 = common_scripts\utility::getstruct("odin_hall_escape_turn02", "script_noteworthy");
  var_2 = [];
  var_2["hall_escape_turn02_ally"] = var_0;
  var_1 maps\_anim::anim_first_frame(var_2, "odin_hall_escape_turn02_ally");
  var_1 maps\_anim::anim_single(var_2, "odin_hall_escape_turn02_ally");
}

odin_hall_escape_turn02_player_spawn() {
  odin_hall_escape_turn02_player();
}

odin_hall_escape_turn02_player() {
  var_0 = common_scripts\utility::getstruct("odin_hall_escape_turn02", "script_noteworthy");
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_1 hide();
  var_2 = [];
  var_2["player_rig"] = var_1;
  var_0 maps\_anim::anim_first_frame(var_2, "odin_hall_escape_turn02_player");
  var_3 = 0;
  level.player playerlinktoblend(var_1, "tag_player", 0.5, 0.15, 0.15);
  wait 0.5;
  level.player playerlinktodelta(var_1, "tag_player", 1, var_3, var_3, var_3, var_3, 1);
  var_1 show();
  var_0 maps\_anim::anim_single(var_2, "odin_hall_escape_turn02_player");
  level.player unlink();
  var_1 delete();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
}

decomp_explosion_anim_ally() {
  var_0 = getent("odin_decomp_anim", "targetname");
  var_0 maps\_anim::anim_first_frame_solo(level.ally, "odin_escape_spin_room_ally01");
  var_0 maps\_anim::anim_single_solo(level.ally, "odin_escape_spin_room_ally01");
  level notify("decomp_ally_anim_done");
}

decomp_explosion_anim_enemies(var_0) {
  var_1 = getent("odin_decomp_anim", "targetname");
  var_1 maps\_anim::anim_first_frame_solo(var_0[0], "odin_escape_spin_room_opfor01");
  var_1 maps\_anim::anim_first_frame_solo(var_0[1], "odin_escape_spin_room_opfor02");
  var_1 thread maps\_anim::anim_single_solo(var_0[0], "odin_escape_spin_room_opfor01");
  var_1 thread maps\_anim::anim_single_solo(var_0[1], "odin_escape_spin_room_opfor02");
  level waittill("decomp_player_anim_done");

  foreach(var_3 in var_0) {
    if(isalive(var_3)) {
      var_3.diequietly = 1;
      var_3 delete();
    }
  }
}

decomp_explosion_anim_player_legs(var_0) {
  common_scripts\utility::flag_wait("player_is_decompressing");
  var_1 = getent("odin_decomp_anim", "targetname");
  var_1 maps\_anim::anim_first_frame_solo(var_0, "odin_escape_spin_room_player_body");
  var_1 thread maps\_anim::anim_single_solo(var_0, "odin_escape_spin_room_player_body");
  common_scripts\utility::flag_wait("player_linked_with_legs");
  wait 0.5;
  var_0 show();
  level waittill("decomp_player_anim_done");
  var_0 delete();
}

decomp_explosion_anim_props(var_0, var_1) {
  var_2 = getent("odin_decomp_anim", "targetname");
  var_3 = [];
  var_3[0] = maps\_utility::spawn_anim_model("decomp_solar_panel");
  var_3 = common_scripts\utility::array_combine(var_3, var_0);
  var_2 thread maps\_anim::anim_single(var_3, "decompression_props");
  wait 1.75;
  var_4 = getEntArray("decomp_explode_wall", "targetname");

  foreach(var_6 in var_4) {
    var_6 delete();
  }

  var_8 = getEntArray("spin_decomp_delete", "script_noteworthy");

  foreach(var_6 in var_8) {
    var_6 delete();
  }
}

decomp_explosion_anim_player(var_0) {
  common_scripts\utility::flag_set("player_is_decompressing");
  setsaveddvar("ammoCounterHide", "1");
  var_1 = getent("odin_decomp_anim", "targetname");
  var_2 = maps\_utility::spawn_anim_model("player_rig");
  var_2.animname = "player_rig";
  var_2 hide();
  var_3 = [];
  var_3["player_rig"] = var_2;
  var_1 maps\_anim::anim_first_frame(var_3, "odin_escape_spin_room_player");
  var_1 thread maps\_anim::anim_single(var_3, "odin_escape_spin_room_player");
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  common_scripts\utility::flag_clear("clear_to_tweak_player");
  level.player playersetgroundreferenceent(undefined);
  var_4 = 15;
  level.player playerlinktoblend(var_2, "tag_player", 1, 0.15, 0.15);
  wait 1;
  level.player playerlinktodelta(var_2, "tag_player", 1, var_4, var_4, var_4, var_4, 1);
  var_2 show();
  common_scripts\utility::flag_set("player_linked_with_legs");
  level.player waittill("anim_done");
  level.player unlink();
  var_2 delete();
  var_5 = level.player getweaponammoclip(level.player.weapon_interior);
  level.player takeweapon(level.player.weapon_interior);
  level.player giveweapon(level.player.weapon_exterior);
  level.player setweaponammoclip(level.player.weapon_exterior, var_5);
  level.player switchtoweapon(level.player.weapon_exterior);
  setsaveddvar("ammoCounterHide", "0");
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player enableweapons();
  level.ally maps\_utility::gun_recall();
  level notify("decomp_player_anim_done");
  common_scripts\utility::flag_set("player_spin_decomp_anim_done");
  common_scripts\utility::flag_set("clear_to_tweak_player");
}

decomp_anim_notify_player_link(var_0) {
  level.player notify("player_link");
}

decomp_anim_notify_slomo(var_0) {
  maps\_utility::slowmo_setspeed_slow(0.35);
  maps\_utility::slowmo_setlerptime_in(0.6);
  thread maps\_utility::slowmo_lerp_in();
}

decomp_anim_notify_end_slomo(var_0) {
  wait 0.2;
  level.player notify("end_slomo");
  maps\_utility::slowmo_setlerptime_out(1.0);
  thread maps\_utility::slowmo_lerp_out();
}

decomp_light_rumble(var_0) {
  level.player playrumbleonentity("light_1s");
}

decomp_heavy_rumble(var_0) {
  level.player playrumbleonentity("heavy_1s");
}

decomp_anim_notify_done(var_0) {
  level.player notify("anim_done");
}

spin_deadguys() {
  var_0 = getent("spin_deadguy_01_node", "targetname");
  var_1 = maps\odin_util::spawn_odin_actor_single("spin_deadguy_1", 1);
  var_1.dontevershoot = 1;
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_1.animname = "generic";
  var_1.allowdeath = 1;
  var_1.diequietly = 1;
  var_1 thread maps\odin_util::odin_drop_weapon();
  var_0 thread maps\_anim::anim_loop_solo(var_1, "odin_spin_struggling_enemy_01_loop", "stop_spin_deadguy_loops");
  var_1 thread move_and_spin_and_animate_spin_dead_guy((-500, -600, 100), 0, 25, 0, undefined, "odin_spin_struggling_enemy_01_loop", var_0);
  var_0 = getent("spin_deadguy_02_node", "targetname");
  var_1 = maps\odin_util::spawn_odin_actor_single("spin_deadguy_2", 1);
  var_1.dontevershoot = 1;
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_1.animname = "generic";
  var_1.allowdeath = 1;
  var_1.diequietly = 1;
  var_1 thread maps\odin_util::odin_drop_weapon();
  var_0 thread maps\_anim::anim_loop_solo(var_1, "odin_spin_struggling_enemy_02_loop", "stop_spin_deadguy_loops");
  var_1 thread move_and_spin_and_animate_spin_dead_guy((-1000, 200, -200), 0, 80, 0, undefined, "odin_spin_struggling_enemy_02_loop", var_0);
  var_0 = getent("spin_deadguy_static_node_01", "targetname");
  var_1 = maps\odin_util::spawn_odin_actor_single("spin_deadguy_static_1", 1);
  var_1.dontevershoot = 1;
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_1.animname = "generic";
  var_1.allowdeath = 1;
  var_1.diequietly = 1;
  var_1 thread maps\odin_util::odin_drop_weapon();
  var_0 maps\_anim::anim_first_frame_solo(var_1, "odin_escape_spin_opfor_death_01");
  var_1 thread move_and_spin_and_animate_spin_dead_guy((-12000, 2400, 2400), 0, 120, 0.1, undefined, "odin_spin_struggling_enemy_02_loop");
  var_0 = getent("spin_deadguy_static_node_02", "targetname");
  var_1 = maps\odin_util::spawn_odin_actor_single("spin_deadguy_static_2", 1);
  var_1.dontevershoot = 1;
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_1.animname = "generic";
  var_1.allowdeath = 1;
  var_1.diequietly = 1;
  var_1 thread maps\odin_util::odin_drop_weapon();
  var_0 maps\_anim::anim_first_frame_solo(var_1, "odin_escape_spin_opfor_death_02");
  var_1 thread move_and_spin_and_animate_spin_dead_guy((400, 800, 100), 0, 20, 0.2, undefined, "odin_spin_struggling_enemy_01_loop");
  var_0 = getent("spin_deadguy_static_node_03", "targetname");
  var_1 = maps\odin_util::spawn_odin_actor_single("spin_deadguy_static_3", 1);
  var_1.dontevershoot = 1;
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_1.animname = "generic";
  var_1.allowdeath = 1;
  var_1.diequietly = 1;
  var_1 thread maps\odin_util::odin_drop_weapon();
  var_0 maps\_anim::anim_first_frame_solo(var_1, "odin_escape_spin_opfor_death_03");
  var_1 thread move_and_spin_and_animate_spin_dead_guy((1000, 500, 800), 0, 30, 0.4, undefined, "odin_spin_struggling_enemy_02_loop");
  var_0 = getent("spin_deadguy_static_node_04", "targetname");
  var_1 = maps\odin_util::spawn_odin_actor_single("spin_deadguy_static_4", 1);
  var_1.dontevershoot = 1;
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_1.animname = "generic";
  var_1.allowdeath = 1;
  var_1.diequietly = 1;
  var_1 thread maps\odin_util::odin_drop_weapon();
  var_0 maps\_anim::anim_first_frame_solo(var_1, "odin_escape_spin_opfor_death_04");
  var_1 thread move_and_spin_and_animate_spin_dead_guy((1200, -800, -210), 0, 25, 0.8, undefined, "odin_spin_struggling_enemy_01_loop");
  var_0 = getent("spin_deadguy_static_node_05", "targetname");
  var_1 = maps\odin_util::spawn_odin_actor_single("spin_deadguy_static_5", 1);
  var_1.dontevershoot = 1;
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_1.animname = "generic";
  var_1.allowdeath = 1;
  var_1.diequietly = 1;
  var_1 thread maps\odin_util::odin_drop_weapon();
  var_0 maps\_anim::anim_first_frame_solo(var_1, "odin_escape_spin_opfor_death_02");
  var_1 thread move_and_spin_and_animate_spin_dead_guy((-1000, 1000, 100), 0, 30, 0.8, undefined, "odin_spin_struggling_enemy_02_loop");
  var_0 = getent("spin_deadguy_03_node", "targetname");
  var_1 = maps\odin_util::spawn_odin_actor_single("spin_deadguy_3", 1);
  var_1.dontevershoot = 1;
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_1.animname = "generic";
  var_1.allowdeath = 1;
  var_1.diequietly = 1;
  var_1 thread maps\odin_util::odin_drop_weapon();
  var_0 maps\_anim::anim_first_frame_solo(var_1, "odin_escape_spin_opfor_death_05");
  var_1 thread move_and_spin_and_animate_spin_dead_guy((-500, 0, 700), 0, 40, 0, "odin_escape_spin_opfor_death_05");
}

move_and_spin_and_animate_spin_dead_guy(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  var_1 = var_1 + 14.15;
  wait(var_1);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_8 = self;
  wait 0.1;
  var_9 = common_scripts\utility::spawn_tag_origin();
  var_9.origin = var_8.origin;
  var_9.angles = var_8.angles;
  var_8 linkto(var_9);

  if(isDefined(var_6)) {
    var_6 notify("stop_spin_deadguy_loops");
    wait 0.1;
  }

  var_9 moveto(var_9.origin + var_0, var_2, var_2 * var_3, 0);

  if(isDefined(var_7)) {
    playFXOnTag(level._effect["spc_fire_puff_bigger_light"], var_9, "tag_origin");
  }

  if(isDefined(var_4)) {
    var_9 maps\_anim::anim_single_solo(var_8, var_4, "tag_origin");
  } else {
    if(distance(var_9.origin + var_0, var_9.origin) / var_2 < 70) {
      var_9 rotateto((randomfloatrange(-180, 180), randomfloatrange(-180, 180), randomfloatrange(-180, 180)), var_2);
    } else {
      var_9 rotatepitch(6000, var_2);
    }

    if(isDefined(var_5)) {
      var_9 thread maps\_anim::anim_loop_solo(var_8, var_5, "stop_spin_deadguy_loops");
    }

    var_8 waittill("movedone");
  }

  var_8 kill();
}

satellite_traversal_props() {
  var_0 = common_scripts\utility::getstruct("satellite_traversal_top", "script_noteworthy");
  var_1 = maps\_utility::spawn_anim_model("satellite_traversal_solar_panels");
  var_2 = [];
  var_2["satellite_traversal_solar_panels"] = var_1;
  var_0 maps\_anim::anim_single(var_2, "satellite_traversal_props");
}

empty_suit_animation() {
  wait 2;
  var_0 = getEntArray("suit_room_empty_suit", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 common_scripts\utility::get_target_ent();
    var_2.animname = "generic";
    var_2 maps\_utility::assign_animtree("generic");
    var_3 thread maps\_anim::anim_loop_solo(var_2, "odin_intro_suit_sway", "stop_suit_loops");
    thread stop_suit_loops(var_3, var_2);
    wait 0.32;
    thread mark_suits_for_delete(var_2, var_3);
  }
}

mark_suits_for_delete(var_0, var_1) {
  wait 10;

  if(isDefined(level.intro_ent_del)) {
    level.intro_ent_del[level.intro_ent_del.size] = var_0;
    level.intro_ent_del[level.intro_ent_del.size] = var_1;
  }
}

stop_suit_loops(var_0, var_1) {
  common_scripts\utility::flag_wait("lock_post_infil_auto_door");
  var_0 notify("stop_suit_loops");
}