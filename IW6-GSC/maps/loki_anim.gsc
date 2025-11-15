/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\loki_anim.gsc
*****************************************************/

main() {
  flag_inits();
  player_anims();
  generic_human();
  script_models();
  dialogue();
  vehicles();
  level thread vignettes();
}

anim_precache() {
  precachemodel("viewhands_us_space");
}

vignettes() {}

flag_inits() {}

#using_animtree("player");

player_anims() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_us_space";
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["infil"] = % loki_infil_player;
  level.scr_anim["player_rig"]["infil_still"] = % loki_infil_player_still;
  level.scr_model["player_rig"] = "viewhands_player_us_space";
  maps\_anim::addnotetrack_customfunction("player_rig", "grenade_delete", maps\loki_infil::infil_grenade_delete);
  maps\_anim::addnotetrack_customfunction("player_rig", "blackout_rotate", maps\loki_infil::doors_open_flicker);
  level.scr_animtree["player_hands"] = #animtree;
  level.scr_anim["player_hands"]["infil"] = % loki_infil_player;
  level.scr_anim["player_hands"]["infil_still"] = % loki_infil_player_still;
  level.scr_model["player_hands"] = "viewhands_player_us_space";
  maps\_anim::addnotetrack_customfunction("player_rig", "first_move", maps\loki_infil::first_move);
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["explosion_part2"] = % loki_moving_cover_player_part2;
  level.scr_model["player_rig"] = "viewhands_player_us_space";
  maps\_anim::addnotetrack_customfunction("player_rig", "take_control", maps\loki_moving_cover::take_control);
  maps\_anim::addnotetrack_customfunction("player_rig", "hit_panel", maps\loki_moving_cover::hit_panel);
  maps\_anim::addnotetrack_customfunction("player_rig", "hit_panel", maps\loki_moving_cover::hit_panel_rumble);
  maps\_anim::addnotetrack_customfunction("player_rig", "sfx_last_hit", maps\loki_audio::sfx_moving_cover_3rd_piece);
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["breach"] = % loki_breach_player;
  level.scr_model["player_rig"] = "viewhands_player_us_space";
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["breach_rog_controls_start"] = % loki_trans_to_rog_player;
  level.scr_anim["player_rig"]["breach_rog_controls_wait_loop"][0] = % loki_trans_to_rog_loop_player;
  level.scr_anim["player_rig"]["breach_rog_controls_fire"] = % loki_trans_to_rog_fire_player;
  level.scr_model["player_rig"] = "viewhands_player_us_space";
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["idle"] = % loki_rog_fp_idle_1;
  level.scr_anim["player_rig"]["breakapart"] = % loki_rog_fp_breakapart;
  level.scr_anim["player_rig"]["camera_shake"] = % loki_rog_fp_idle_1_shake;
  level.scr_anim["player_rig"]["camera_shake_breakapart"] = % loki_rog_fp_breakapart_shake;
  level.scr_anim["player_rig"]["camera_sway"] = % loki_rog_sway;
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["end_button_push"] = % loki_trans_to_rog_fire_player_v2;
  level.scr_model["player_rig"] = "viewhands_player_us_space";
}

#using_animtree("generic_human");

generic_human() {
  level.scr_animtree["generic"] = #animtree;
  level.scr_anim["generic"]["in_your_face_death"][0] = % casual_stand_idle;
  level.scr_animtree["ally_0"] = #animtree;
  level.scr_anim["ally_0"]["infil"] = % loki_infil_ally4;
  level.scr_anim["ally_0"]["infil_still"] = % loki_infil_ally4_still;
  level.scr_anim["ally_0"]["combat_two_intro"] = % loki_combat2_traversal_ally1_part2;
  level.scr_anim["ally_0"]["combat_two_trans_1"] = % loki_combat2_entera_ally01;
  maps\_anim::addnotetrack_customfunction("ally_0", "push_crates", maps\loki_combat_two::push_crates);
  level.scr_anim["ally_0"]["combat_two_trans_2"] = % loki_combat2_exitb_ally01;
  level.scr_anim["ally_0"]["combat_two_trans_3"] = % loki_combat2_exitc_ally01;
  level.scr_anim["ally_0"]["combat_two_trans_4"] = % loki_combat2_exitd_ally01;
  level.scr_anim["ally_0"]["combat_two_trans_4_loop"][0] = % loki_combat2_exitd_loop_ally01;
  level.scr_anim["ally_0"]["breach"] = % loki_breach_ally01;
  level.scr_anim["ally_0"]["rog_intro"][0] = % loki_trans_to_rog_ally2;
  level.scr_anim["ally_0"]["hatch_idle"][0] = % loki_combat1_hatchdoor_idle;
  level.scr_anim["ally_0"]["end"] = % loki_end_ally01;
  level.scr_anim["ally_0"]["end_loop"][0] = % loki_end_loop_ally01;
  maps\_anim::addnotetrack_customfunction("ally_0", "lights_on", maps\loki_infil::lights_on);
  level.scr_animtree["ally_1"] = #animtree;
  level.scr_anim["ally_1"]["infil"] = % loki_infil_ally1;
  level.scr_anim["ally_1"]["infil_still"] = % loki_infil_ally1_still;
  level.scr_anim["ally_1"]["combat_two_intro"] = % loki_combat2_traversal_ally2_part2;
  level.scr_anim["ally_1"]["combat_two_trans_1"] = % loki_combat2_entera_ally02;
  level.scr_anim["ally_1"]["combat_two_trans_1_loop"][0] = % loki_combat2_entera_loop_ally02;
  level.scr_anim["ally_1"]["combat_two_trans_1_exit"] = % loki_combat2_exita_ally02;
  level.scr_anim["ally_1"]["combat_two_trans_2"] = % loki_combat2_exitb_ally02;
  level.scr_anim["ally_1"]["combat_two_trans_3"] = % loki_combat2_exitc_ally02;
  level.scr_anim["ally_1"]["combat_two_trans_4"] = % loki_combat2_exitd_ally02;
  level.scr_anim["ally_1"]["combat_two_trans_4_loop"][0] = % loki_combat2_exitd_loop_ally02;
  level.scr_anim["ally_1"]["breach"] = % loki_breach_ally02;
  level.scr_anim["ally_1"]["rog_intro"][0] = % loki_trans_to_rog_ally1;
  maps\_anim::addnotetrack_customfunction("ally_1", "lights_on", maps\loki_infil::lights_on);
  level.scr_animtree["ally_2"] = #animtree;
  level.scr_anim["ally_2"]["infil"] = % loki_infil_ally5;
  level.scr_anim["ally_2"]["infil_still"] = % loki_infil_ally5_still;
  level.scr_anim["ally_2"]["explosion_part2"] = % loki_moving_cover_opfor1;
  maps\_anim::addnotetrack_customfunction("ally_2", "lights_on", maps\loki_infil::lights_on);
  maps\_anim::addnotetrack_customfunction("ally_2", "crushed", maps\loki_moving_cover::moving_cover_lightsoff);
  level.scr_animtree["redshirt_0"] = #animtree;
  level.scr_anim["redshirt_0"]["infil_still"] = % loki_infil_ally2_still;
  maps\_anim::addnotetrack_customfunction("redshirt_0", "lights_on", maps\loki_infil::lights_on);
  maps\_anim::addnotetrack_customfunction("redshirt_0", "ps_spacesuit_death_friendly_1", maps\loki_infil::headshot_redshirt);
  level.scr_animtree["redshirt_1"] = #animtree;
  level.scr_anim["redshirt_1"]["infil"] = % loki_infil_ally3;
  level.scr_anim["redshirt_1"]["infil_still"] = % loki_infil_ally3_still;
  maps\_anim::addnotetrack_customfunction("redshirt_1", "lights_on", maps\loki_infil::lights_on);
  level.scr_animtree["redshirt_2"] = #animtree;
  level.scr_anim["redshirt_2"]["infil"] = % loki_infil_ally6;
  level.scr_anim["redshirt_2"]["infil_still"] = % loki_infil_ally6_still;
  maps\_anim::addnotetrack_customfunction("redshirt_2", "lights_on", maps\loki_infil::lights_on);
  level.scr_animtree["redshirt_3"] = #animtree;
  level.scr_anim["redshirt_3"]["infil"] = % loki_infil_ally7;
  level.scr_anim["redshirt_3"]["infil_still"] = % loki_infil_ally7_still;
  maps\_anim::addnotetrack_customfunction("redshirt_3", "lights_on", maps\loki_infil::lights_on);
  maps\_anim::addnotetrack_customfunction("redshirt_3", "killed", maps\loki_infil::kill_during_vignette);
  maps\_anim::addnotetrack_customfunction("redshirt_3", "ally_through_sat_panel", maps\loki_infil::ally_through_sat_panel);
  level.scr_animtree["infil_opfor"] = #animtree;
  level.scr_anim["infil_opfor"]["infil"] = % loki_infil_opfor1;
  maps\_anim::addnotetrack_customfunction("infil_opfor", "killed", maps\loki_infil::kill_during_vignette);
  level.scr_animtree["enemy_1"] = #animtree;
  level.scr_anim["enemy_1"]["breach"] = % loki_breach_enemy01;
  level.scr_anim["enemy_1"]["breach_death"] = % loki_breach_enemy01_death;
  level.scr_anim["enemy_1"]["breach_death_loop"][0] = % loki_breach_enemy01_death_loop;
  level.scr_anim["enemy_1"]["before_breach"][0] = % loki_breach_loop_enemy01;
  level.scr_animtree["enemy_2"] = #animtree;
  level.scr_anim["enemy_2"]["breach"] = % loki_breach_enemy02;
  level.scr_anim["enemy_2"]["before_breach"][0] = % loki_breach_loop_enemy02;
  level.scr_animtree["enemy_3"] = #animtree;
  level.scr_anim["enemy_3"]["breach"] = % loki_breach_enemy03;
  level.scr_anim["enemy_3"]["before_breach"][0] = % loki_breach_loop_enemy03;
  level.scr_animtree["enemy_4"] = #animtree;
  level.scr_anim["enemy_4"]["breach"] = % loki_breach_enemy04;
  level.scr_anim["enemy_4"]["breach_death"] = % loki_breach_enemy04_death;
  level.scr_anim["enemy_4"]["breach_death_loop"][0] = % loki_breach_enemy04_death_loop;
  level.scr_anim["enemy_4"]["before_breach"][0] = % loki_breach_loop_enemy04;
  level.scr_animtree["enemy_5"] = #animtree;
  level.scr_anim["enemy_5"]["breach"] = % loki_breach_enemy05;
  level.scr_anim["enemy_5"]["breach_death"] = % loki_breach_enemy05_death;
  level.scr_goaltime["enemy_5"]["breach_death"] = 0.5;
  level.scr_anim["enemy_5"]["breach_death_loop"][0] = % loki_breach_enemy05_death_loop;
  level.scr_goaltime["enemy_5"]["breach_death_loop"] = 0.5;
  level.scr_anim["enemy_5"]["before_breach"][0] = % loki_breach_loop_enemy05;
  level.scr_animtree["enemy_6"] = #animtree;
  level.scr_anim["enemy_6"]["breach"] = % loki_breach_enemy06;
  level.scr_anim["enemy_6"]["before_breach"][0] = % loki_breach_loop_enemy06;
  level.scr_animtree["enemy_7"] = #animtree;
  level.scr_anim["enemy_7"]["breach"] = % loki_breach_enemy07;
  level.scr_anim["enemy_7"]["before_breach"][0] = % loki_breach_loop_enemy07;
  level.scr_animtree["player_legs"] = #animtree;
  level.scr_anim["player_legs"]["explosion_part2"] = % loki_moving_cover_player_legs_part2;
  level.scr_anim["player_legs"]["breach"] = % loki_breach_player_body;
  level.scr_model["player_legs"] = "us_space_assault_a_body";
  level.scr_animtree["moving_cover_opfor"] = #animtree;
  level.scr_anim["moving_cover_opfor"]["explosion_part2"] = % loki_moving_cover_opfor2;
  level.scr_animtree["generic"] = #animtree;
  level.scr_anim["generic"]["explosion_part1"] = % loki_moving_cover_deadbody_02_part1;
  level.scr_anim["generic"]["explosion_part2"] = % loki_moving_cover_deadbody_02_part2;
  level.scr_anim["generic"]["explosion_death"] = % death_explosion_up10;
  level.scr_animtree["generic"] = #animtree;
  level.scr_anim["generic"]["combat_one_traversal1"] = % loki_combat1_traversal_01;
  level.scr_anim["generic"]["combat_one_traversal2"] = % loki_combat1_traversal_02;
  level.scr_anim["generic"]["combat_one_traversal3"] = % loki_combat1_traversal_03;
  level.scr_anim["generic"]["combat_one_traversal4"] = % loki_combat1_traversal_04;
  level.scr_anim["opfor1"]["combat_one_door"] = % loki_combat1_opfordoor_01;
  level.scr_anim["opfor2"]["combat_one_door"] = % loki_combat1_opfordoor_02;
  level.scr_anim["opfor3"]["combat_one_door"] = % loki_combat1_opfordoor_03;
  level.scr_anim["opfor4"]["combat_one_door"] = % loki_combat1_opfordoor_04;
  level.scr_face["ally_0"]["loki_us3_thompsonfireforeffect"] = % loki_end_loop_ally01_facial_01;
  level.scr_sound["ally_0"]["loki_us3_thompsonfireforeffect"] = "space_face_null";
  level.scr_face["ally_0"]["loki_us3_thompsonthesatsare"] = % loki_end_loop_ally01_facial_02;
  level.scr_sound["ally_0"]["loki_us3_thompsonthesatsare"] = "space_face_null";
  level.scr_face["ally_0"]["loki_us3_firenow"] = % loki_end_loop_ally01_facial_03;
  level.scr_sound["ally_0"]["loki_us3_firenow"] = "space_face_null";
}

#using_animtree("script_model");

script_models() {
  level.scr_animtree["infil_shuttle"] = #animtree;
  level.scr_anim["infil_shuttle"]["infil"] = % loki_infil_shuttle;
  level.scr_model["infil_shuttle"] = "vehicle_space_shuttle";
  level.scr_animtree["infil_shuttle_interior"] = #animtree;
  level.scr_anim["infil_shuttle_interior"]["infil"] = % loki_infil_shuttle_interior;
  level.scr_anim["infil_shuttle_interior"]["infil_still"] = % loki_infil_shuttle_interior_still;
  level.scr_model["infil_shuttle_interior"] = "vehicle_space_shuttle_interior";
  level.scr_animtree["infil_arx"] = #animtree;
  level.scr_anim["infil_arx"]["infil_still"] = % loki_infil_arx_still;
  level.scr_model["infil_arx"] = "viewmodel_arx_160";
  level.scr_animtree["infil_grenade"] = #animtree;
  level.scr_anim["infil_grenade"]["infil_still"] = % loki_infil_grenade_still;
  level.scr_model["infil_grenade"] = "viewmodel_arx_160_grenade_seperate";
  level.scr_animtree["combat_one_door"] = #animtree;
  level.scr_anim["combat_one_door"]["combat_one_door"] = % loki_combat1_door;
  level.scr_model["combat_one_door"] = "loki_exterior_round_hatch";
  level.scr_animtree["moving_cover_obj0"] = #animtree;
  level.scr_anim["moving_cover_obj0"]["explosion_part1"] = % loki_moving_cover_objects_start_anim;
  level.scr_model["moving_cover_obj0"] = "loki_moving_cover_objects_start";
  level.scr_animtree["moving_cover_obj1"] = #animtree;
  level.scr_anim["moving_cover_obj1"]["explosion_part2"] = % loki_moving_cover_objects_anim;
  level.scr_model["moving_cover_obj1"] = "loki_moving_cover_objects";
  level.scr_animtree["moving_cover_sail"] = #animtree;
  level.scr_anim["moving_cover_sail"]["explosion_part2_sail"] = % loki_moving_cover_hitsail_sail;
  level.scr_animtree["moving_cover_solar0"] = #animtree;
  level.scr_anim["moving_cover_solar0"]["explosion_part2_solar0"] = % loki_moving_cover_solar_panel_01;
  level.scr_animtree["moving_cover_solar1"] = #animtree;
  level.scr_anim["moving_cover_solar1"]["explosion_part2_solar1"] = % loki_moving_cover_solar_panel_02;
  level.scr_animtree["combat_two_intro_debris"] = #animtree;
  level.scr_anim["combat_two_intro_debris"]["combat_two_intro_debris_move"] = % loki_moving_cover_module_2_dest;
  level.scr_goaltime["combat_two_ally_01_crate_01"]["combat_two_trans_1"] = 0.5;
  level.scr_animtree["combat_two_ally_01_crate_01"] = #animtree;
  level.scr_anim["combat_two_ally_01_crate_01"]["combat_two_trans_1"] = % loki_combat2_entera_ally01_crate01;
  level.scr_model["combat_two_ally_01_crate_01"] = "loki_crate_01";
  level.scr_goaltime["combat_two_ally_01_crate_02"]["combat_two_trans_1"] = 0.5;
  level.scr_animtree["combat_two_ally_01_crate_02"] = #animtree;
  level.scr_anim["combat_two_ally_01_crate_02"]["combat_two_trans_1"] = % loki_combat2_entera_ally01_crate02;
  level.scr_model["combat_two_ally_01_crate_02"] = "loki_crate_01";
  level.scr_animtree["combat_two_ally_02_crate_01"] = #animtree;
  level.scr_anim["combat_two_ally_02_crate_01"]["combat_two_trans_1"] = % loki_combat2_entera_ally02_crate02;
  level.scr_model["combat_two_ally_02_crate_01"] = "space_interior_pack_square";
  level.scr_animtree["combat_two_ally_02_trans_2_crate"] = #animtree;
  level.scr_anim["combat_two_ally_02_trans_2_crate"]["combat_two_trans_2"] = % loki_combat2_exitb_create;
  level.scr_model["combat_two_ally_02_trans_2_crate"] = "loki_shipping_frame_crates";
  level.scr_animtree["ctrlroom_top"] = #animtree;
  level.scr_anim["ctrlroom_top"]["breach"] = % loki_breach_hatch_top;
  level.scr_model["ctrlroom_top"] = "loki_breach_ctrlroom_top";
  level.scr_animtree["ctrlroom_explosive"] = #animtree;
  level.scr_anim["ctrlroom_explosive"]["breach"] = % loki_breach_space_breacher;
  level.scr_model["ctrlroom_explosive"] = "weapon_space_breacher";
  level.scr_animtree["loki_breach_bag_big"] = #animtree;
  level.scr_anim["loki_breach_bag_big"]["breach"] = % loki_breach_props_bag_big;
  level.scr_model["loki_breach_bag_big"] = "space_interior_pack_square_big";
  level.scr_animtree["loki_breach_bag_round"] = #animtree;
  level.scr_anim["loki_breach_bag_round"]["breach"] = % loki_breach_props_bag_round;
  level.scr_model["loki_breach_bag_round"] = "space_interior_pack_round";
  level.scr_animtree["loki_breach_bag_square"] = #animtree;
  level.scr_anim["loki_breach_bag_square"]["breach"] = % loki_breach_props_bag_square;
  level.scr_model["loki_breach_bag_square"] = "space_interior_pack_square";
  level.scr_animtree["loki_breach_laptop"] = #animtree;
  level.scr_anim["loki_breach_laptop"]["breach"] = % loki_breach_props_laptop;
  level.scr_model["loki_breach_laptop"] = "cnd_laptop_001_open_off";
  level.scr_animtree["ROG"] = #animtree;
  level.scr_model["ROG"] = "loki_rog_for_player_launch";
  level.scr_anim["ROG"]["breakapart"] = % loki_rog_breakapart;
  level.scr_anim["ROG"]["decelerate"] = % loki_rog_decelerate;
  level.scr_anim["ROG"]["decelerate_loop"] = % loki_rog_decelerate_loop;
  level.scr_anim["ROG"]["loki_rog_seperate_01"] = % loki_rog_seperate_01;
  level.scr_anim["ROG"]["loki_rog_seperate_02"] = % loki_rog_seperate_02;
  level.scr_anim["ROG"]["loki_rog_seperate_03"] = % loki_rog_seperate_03;
  level.scr_anim["ROG"]["loki_rog_seperate_04"] = % loki_rog_seperate_04;
  level.scr_anim["ROG"]["loki_rog_seperate_05"] = % loki_rog_seperate_05;
  level.scr_anim["ROG"]["loki_rog_seperate_06"] = % loki_rog_seperate_06;
  level.scr_anim["ROG"]["loki_rog_seperate_07"] = % loki_rog_seperate_07;
  level.scr_anim["ROG"]["loki_rog_seperate_08"] = % loki_rog_seperate_08;
  level.scr_animtree["loki_rog_single"] = #animtree;
  level.scr_model["loki_rog_single"] = "loki_rog_single_rod";
}

vehicles() {}

dialogue() {}

vignette_actor_aware_everything() {
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.fixednode = 1;
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::enable_pain();
  self.dontavoidplayer = 0;

  if(isDefined(self.og_newenemyreactiondistsq))
    self.newenemyreactiondistsq = self.og_newenemyreactiondistsq;
}