/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\tunnels\zd30tunnels_anim.gsc
************************************************/

main() {
  level.player.animname = "player";
  player();
  humans();
  vo_face();
  dogs();
  script_models();
  vehicles();
  scriptables();
  level.scr_model["generic_nvgs_on"] = "head_sas_woodland_ar_nvg";
  level.scr_model["price_nvgs_on"] = "hat_hero_price_helmet";
}

#using_animtree("player");

player() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_kyle_fullbody_wind";
  level.scr_anim["player_rig"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_plr;
  level.scr_goaltime["player_rig"]["heli_pre_intro"] = 0;
  level.scr_anim["player_rig"]["heli_intro"] = % zd30c_000_infil_lbirds_plr;
  level.scr_goaltime["player_rig"]["heli_intro"] = 1.5;
  level.scr_anim["player_rig"]["power_interact"] = % zd30_vm_fusebox_plr;
  level.scr_anim["player_rig"]["entrance"] = % zd30c_090_tunnel_entrance_plr;
  level.scr_goaltime["player_rig"]["entrance"] = 0.4;
  scripts\common\anim::addnotetrack_notify("player_rig", "cine_lb_off", "cine_letterboxing", "heli_pre_intro");
  scripts\common\anim::addnotetrack_flag("player_rig", "notify_fp", "start_fp_trans", "heli_pre_intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "model_swap", ::show_player, "heli_pre_intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "change", ::player_fov_change, "heli_intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_fov_scale_factor_override", ::infil_remove_fov_scale_factor_override, "heli_intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "hide_plr", ::swap_kyle, "entrance");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_scale_factor_override", ::entrance_add_fov_scale_factor_override, "entrance");
  level.scr_anim["player_rig"]["basement_intro"] = % zd30t_basement_intro_player;
  level.scr_anim["player_rig"]["mine_wakeup"] = % zd30t_basement_wakeup_plr;
  level.scr_anim["player_rig"]["ladder_explode"] = % zd30t_basement_ladder_explode_plr;
  level.scr_anim["player_rig"]["ladder_wakeup"] = % zd30t_basement_wakeup_intro_plr;
  scripts\common\anim::addnotetrack_notify("player_rig", "notify_fp", "cine_letterboxing", "basement_intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_scale_factor_override", ::basement_intro_add_fov_scale_factor_override, "basement_intro");
  level.scr_anim["player_rig"]["storage_split_scene_jump"] = % zd30t_basement_split_jump_plr;
  level.scr_anim["player_rig"]["storage_split_scene_jump_enter"] = % zd30t_basement_split_jump_enter_plr;
  level.scr_anim["player_rig"]["storage_split_scene_jump_back"] = % zd30t_basement_split_jump_backward_plr;
  level.scr_anim["player_rig"]["storage_split_scene_jump_enter_back"] = % zd30t_basement_split_jump_backward_enter_plr;
  level.scr_anim["player_rig"]["storage_split_scene_jump_idle"][0] = % zd30t_basement_split_jump_idle_plr;
  level.scr_anim["player_rig"]["storage_split_scene_getup"] = % zd30t_basement_split_getup_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_fov_scale_factor_override", ::storage_split_remove_fov_scale_factor_override, "storage_split_scene_getup");
  level.scr_anim["player_rig"]["shaft_ladder_intro"] = % zd30t_shaft_ladder_fall_intro_plr;
  level.scr_anim["player_rig"]["shaft_ladder_intro_idle"][0] = % zd30t_shaft_ladder_fall_intro_idle_plr;
  level.scr_goaltime["player_rig"]["shaft_ladder_intro_idle"] = 0.1;
  level.scr_anim["player_rig"]["shaft_ladder_intro_fail"] = % zd30t_shaft_ladder_fall_intro_fail_plr;
  level.scr_anim["player_rig"]["shaft_ladder_grab"] = % zd30t_shaft_ladder_fall_grab_plr;
  level.scr_anim["player_rig"]["shaft_ladder_grab_idle"][0] = % zd30t_shaft_ladder_fall_grab_idle_plr;
  level.scr_anim["player_rig"]["shaft_ladder_climb"] = % zd30t_shaft_ladder_fall_climb_plr;
  level.scr_goaltime["player_rig"]["shaft_ladder_climb"] = 0.1;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_scale_factor_override", ::shaft_ladder_add_fov_scale_factor_override, "shaft_ladder_intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_fov_scale_factor_override", ::shaft_ladder_remove_fov_scale_factor_override, "shaft_ladder_climb");
  level.scr_anim["player_rig"]["mine_getup"] = % zd30t_mine_getup_plr;
  level.scr_anim["player_rig"]["death_diffuse_enter"] = % zd30t_wolf_death_diffuse_enter_plr;
  level.scr_anim["player_rig"]["death_diffuse_enter_idle"][0] = % zd30t_wolf_death_diffuse_enter_idle_plr;
  level.scr_anim["player_rig"]["death_diffuse"] = % zd30t_wolf_death_diffuse_plr;
  level.scr_anim["player_rig"]["death_end"] = % zd30t_wolf_death_end_plr;
  scripts\common\anim::addnotetrack_notify("player_rig", "pvo_dx_vom_alx_wolf_death_70", "jackpot_line_start", "death_end");
  level.scr_anim["player_rig"]["coldopen_bink"] = % co_wolf_video_camera;
}

player_fov_change(var_0) {
  level.player modifybasefov(55, 0.55);
}

show_player(var_0) {
  if(isDefined(level.kyle))
    level.kyle delete();

  var_0 show();
  var_0.animweapon show();
}

swap_kyle(var_0) {
  level.kyledrone detach(level.kyledrone.hatmodel);
  level.kyledrone detach(level.kyledrone.headmodel);
  var_0 hide();
  level.kyledrone show();
  level.player setcinematicmotionoverride("disabled");
  hidecinematicletterboxing(2, 0);
  wait 2.5;
  level.kyledrone attach(level.kyledrone.headmodel);
  level.kyledrone attach(level.kyledrone.hatmodel);
}

#using_animtree("generic_human");

humans() {
  level.scr_anim["kyle"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_kyle3p;
  level.scr_goaltime["kyle"]["heli_pre_intro"] = 0;
  level.scr_anim["alphaP1"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_pilot01;
  level.scr_goaltime["alphaP1"]["heli_pre_intro"] = 0;
  level.scr_anim["alphaP2"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_copilot01;
  level.scr_goaltime["alphaP2"]["heli_pre_intro"] = 0;
  level.scr_anim["alpha5"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_ally11;
  level.scr_goaltime["alpha5"]["heli_pre_intro"] = 0;
  level.scr_anim["alpha6"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_ally13;
  level.scr_goaltime["alpha6"]["heli_pre_intro"] = 0;
  level.scr_anim["bravoP1"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_pilot02;
  level.scr_goaltime["bravoP1"]["heli_pre_intro"] = 0;
  level.scr_anim["bravoP2"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_copilot02;
  level.scr_goaltime["bravoP2"]["heli_pre_intro"] = 0;
  level.scr_anim["bravo4"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_ally21;
  level.scr_goaltime["bravo4"]["heli_pre_intro"] = 0;
  level.scr_anim["bravo1"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_ally22;
  level.scr_goaltime["bravo1"]["heli_pre_intro"] = 0;
  level.scr_anim["bravo5"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_ally23;
  level.scr_goaltime["bravo5"]["heli_pre_intro"] = 0;
  level.scr_anim["bravo2"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_ally24;
  level.scr_goaltime["bravo2"]["heli_pre_intro"] = 0;
  level.scr_anim["overwatch"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_ally25;
  level.scr_goaltime["overwatch"]["heli_pre_intro"] = 0;
  level.scr_anim["price"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_price;
  level.scr_goaltime["price"]["heli_pre_intro"] = 0;
  level.scr_anim["charlie1"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_ally31;
  level.scr_goaltime["charlie1"]["heli_pre_intro"] = 0;
  level.scr_anim["charlie2"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_ally32;
  level.scr_goaltime["charlie2"]["heli_pre_intro"] = 0;
  level.scr_anim["charlie3"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_ally33;
  level.scr_goaltime["charlie3"]["heli_pre_intro"] = 0;
  level.scr_anim["charlie4"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_ally34;
  level.scr_goaltime["charlie4"]["heli_pre_intro"] = 0;
  level.scr_anim["farah"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_farah;
  level.scr_goaltime["farah"]["heli_pre_intro"] = 0;
  level.scr_anim["alex"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_alex;
  level.scr_goaltime["alex"]["heli_pre_intro"] = 0;
  level.scr_anim["alphaP1"]["heli_intro"] = % zd30c_000_infil_lbirds_pilot01;
  level.scr_goaltime["alphaP1"]["heli_intro"] = 1.5;
  level.scr_anim["alphaP2"]["heli_intro"] = % zd30c_000_infil_lbirds_copilot01;
  level.scr_goaltime["alphaP2"]["heli_intro"] = 1.5;
  level.scr_anim["alpha5"]["heli_intro"] = % zd30c_000_infil_lbirds_ally11;
  level.scr_goaltime["alpha5"]["heli_intro"] = 1.5;
  level.scr_anim["alpha5"]["heli_intro_idle"][0] = % zd30c_000_infil_lbirds_idle_ally11;
  level.scr_goaltime["alpha5"]["heli_intro_idle"] = 1.5;
  level.scr_anim["alpha6"]["heli_intro"] = % zd30c_000_infil_lbirds_ally13;
  level.scr_goaltime["alpha6"]["heli_intro"] = 1.5;
  level.scr_anim["alpha6"]["heli_intro_idle"][0] = % zd30c_000_infil_lbirds_idle_ally13;
  level.scr_goaltime["alpha6"]["heli_intro_idle"] = 1.5;
  scripts\common\anim::addnotetrack_customfunction("alpha5", "visor_lower", ::nvg_on_fx, "heli_intro");
  scripts\common\anim::addnotetrack_customfunction("alpha6", "visor_lower", ::nvg_on_fx, "heli_intro");
  level.scr_anim["bravoP1"]["heli_intro"] = % zd30c_000_infil_lbirds_pilot02;
  level.scr_goaltime["bravoP1"]["heli_intro"] = 1.5;
  level.scr_anim["bravoP2"]["heli_intro"] = % zd30c_000_infil_lbirds_copilot02;
  level.scr_goaltime["bravoP2"]["heli_intro"] = 1.5;
  level.scr_anim["bravo4"]["heli_intro"] = % zd30c_000_infil_lbirds_ride_ally21;
  level.scr_goaltime["bravo4"]["heli_intro"] = 1.5;
  level.scr_anim["bravo1"]["heli_intro"] = % zd30c_000_infil_lbirds_ride_ally22;
  level.scr_goaltime["bravo1"]["heli_intro"] = 1.5;
  level.scr_anim["bravo5"]["heli_intro"] = % zd30c_000_infil_lbirds_ride_ally23;
  level.scr_goaltime["bravo5"]["heli_intro"] = 1.5;
  level.scr_anim["bravo2"]["heli_intro"] = % zd30c_000_infil_lbirds_ride_ally24;
  level.scr_goaltime["bravo2"]["heli_intro"] = 1.5;
  level.scr_anim["overwatch"]["heli_intro"] = % zd30c_000_infil_lbirds_ride_ally25;
  level.scr_goaltime["overwatch"]["heli_intro"] = 1.5;
  level.scr_anim["price"]["heli_intro"] = % zd30c_000_infil_lbirds_ride_price;
  level.scr_goaltime["price"]["heli_intro"] = 1.5;
  level.scr_anim["bravo4"]["heli_unload"] = % zd30c_000_infil_lbirds_ally21;
  level.scr_goaltime["bravo4"]["heli_unload"] = 1.5;
  level.scr_anim["bravo1"]["heli_unload"] = % zd30c_000_infil_lbirds_ally22;
  level.scr_goaltime["bravo1"]["heli_unload"] = 1.5;
  level.scr_anim["bravo5"]["heli_unload"] = % zd30c_000_infil_lbirds_ally23;
  level.scr_goaltime["bravo5"]["heli_unload"] = 1.5;
  level.scr_anim["bravo2"]["heli_unload"] = % zd30c_000_infil_lbirds_ally24;
  level.scr_goaltime["bravo2"]["heli_unload"] = 1.5;
  level.scr_anim["bravo2"]["heli_intro_idle"][0] = % zd30c_000_infil_lbirds_idle_ally24;
  level.scr_goaltime["bravo2"]["heli_intro_idle"] = 1.5;
  level.scr_anim["overwatch"]["heli_unload"] = % zd30c_000_infil_lbirds_ally25;
  level.scr_goaltime["overwatch"]["heli_unload"] = 1.5;
  level.scr_anim["overwatch"]["heli_intro_idle"][0] = % zd30c_000_infil_lbirds_idle_ally25;
  level.scr_goaltime["overwatch"]["heli_intro_idle"] = 1.5;
  level.scr_anim["price"]["heli_unload"] = % zd30c_000_infil_lbirds_price;
  level.scr_goaltime["price"]["heli_unload"] = 1.5;
  level.scr_anim["price"]["heli_intro_idle"][0] = % zd30c_000_infil_lbirds_idle_price;
  level.scr_goaltime["price"]["heli_intro_idle"] = 1.5;
  level.scr_anim["charlie1"]["heli_intro"] = % zd30c_000_infil_lbirds_ally31;
  level.scr_goaltime["charlie1"]["heli_intro"] = 1.5;
  level.scr_anim["charlie2"]["heli_intro"] = % zd30c_000_infil_lbirds_ally32;
  level.scr_goaltime["charlie2"]["heli_intro"] = 1.5;
  level.scr_anim["charlie3"]["heli_intro"] = % zd30c_000_infil_lbirds_ally33;
  level.scr_goaltime["charlie3"]["heli_intro"] = 1.5;
  level.scr_anim["charlie4"]["heli_intro"] = % zd30c_000_infil_lbirds_ally34;
  level.scr_goaltime["charlie4"]["heli_intro"] = 1.5;
  level.scr_anim["farah"]["heli_intro"] = % zd30c_000_infil_lbirds_farah;
  level.scr_goaltime["farah"]["heli_intro"] = 1.5;
  level.scr_anim["alex"]["heli_intro"] = % zd30c_000_infil_lbirds_alex;
  level.scr_goaltime["alex"]["heli_intro"] = 1.5;
  level.scr_anim["alpha5"]["sledge_intro"] = % zd30c_000_infil_lbirds_sledge_ally11;
  level.scr_anim["alpha6"]["sledge_intro"] = % zd30c_000_infil_lbirds_sledge_ally13;
  scripts\common\anim::addnotetrack_customfunction("alpha5", "stop_anim", ::temp_trim, "sledge_intro");
  scripts\common\anim::addnotetrack_customfunction("alpha6", "sledge_vs_door", ::sledge_hits_door, "sledge_intro");
  scripts\common\anim::addnotetrack_customfunction("alpha6", "stow_sledge", ::sledge_put_away, "sledge_intro");
  level.scr_anim["b1_intro_guy"]["b1_introA"] = % stp_bar_street_gate_idle_civ01;
  level.scr_anim["b1_intro_guy"]["b1_introA_deathA"] = % zd30c_001_infil_first_house_enter_death;
  level.scr_goaltime["b1_intro_guy"]["b1_introA_deathA"] = 0.15;
  level.scr_anim["b1_intro_guy"]["b1_introA_deathB"] = % zd30c_001_infil_first_house_enter_death;
  level.scr_goaltime["b1_intro_guy"]["b1_introA_deathB"] = 0.15;
  level.scr_anim["building1_runner"]["b1_scared"] = % zd30c_002_infil_woman_couch_enter_aq01;
  level.scr_goaltime["building1_runner"]["b1_scared"] = 0.15;
  level.scr_anim["building1_guy"]["b1_scared"] = % zd30c_002_infil_woman_couch_enter_aq02;
  level.scr_goaltime["building1_guy"]["b1_scared"] = 0.15;
  scripts\common\anim::addnotetrack_customfunction("building1_guy", "fire_at_player", ::fire_at_player, "b1_scared");
  level.scr_anim["building1_girl"]["b1_scared"] = % zd30c_002_infil_woman_couch_enter_civ;
  level.scr_goaltime["building1_guy"]["b1_scared"] = 0.15;
  level.scr_anim["building1_girl"]["b1_scared_idle"][0] = % zd30c_002_infil_woman_couch_enter_idle_civ;
  scripts\common\anim::addnotetrack_customfunction("building1_girl", "swap_to_clip", ::b1_girl_in_position, "b1_scared");
  level.scr_anim["building1_girl"]["b1_settle"] = % zd30c_002_infil_woman_couch_enter_exit_civ;
  level.scr_goaltime["building1_girl"]["b1_settle"] = 0.15;
  level.scr_anim["building1_girl"]["b1_settle_idle"][0] = % zd30c_002_infil_woman_couch_idle_civ;
  level.scr_anim["building1_girl"]["b1_settle_react"] = % zd30c_002_infil_woman_couch_react_civ;
  level.scr_goaltime["building1_girl"]["b1_settle_react"] = 0.25;
  level.scr_anim["building1_girl"]["b1_settle_react_idle"][0] = % zd30c_002_infil_woman_couch_react_idle_civ;
  level.scr_anim["building1_girl"]["b1_settle_react_back"] = % zd30c_002_infil_woman_couch_react_back_civ;
  level.scr_goaltime["building1_girl"]["b1_settle_react_back"] = 0.25;
  level.scr_anim["building1_girl"]["b1_settle_death"] = % zd30c_002_infil_woman_couch_death_civ;
  level.scr_goaltime["building1_girl"]["b1_settle_death"] = 0.25;
  level.scr_anim["building1_guy"]["b1_rush"] = % hm_grnd_org_cover_left_crouch_exit_2hands_ar_8;
  level.scr_anim["alpha5"]["b1_secure"] = % zd30c_002_infil_woman_couch_secure_ally;
  level.scr_anim["alpha5"]["b1_secure_idle"][0] = % zd30c_002_infil_woman_couch_secure_idle_ally;
  level.scr_anim["building1_girl"]["b1_secure"] = % zd30c_002_infil_woman_couch_secure_civ;
  level.scr_anim["building1_girl"]["b1_secure_idle"][0] = % zd30c_002_infil_woman_couch_secure_idle_civ;
  scripts\common\anim::addnotetrack_customfunction("building1_girl", "secured", ::prisoner_secured, "b1_secure");
  level.scr_anim["building1_mom"]["protect_idle"][0] = % zd30c_002_infil_mother_idle;
  level.scr_anim["building1_mom"]["protect_react"] = % zd30c_002_infil_mother_grab_gun;
  level.scr_goaltime["building1_mom"]["protect_react"] = 0.25;
  level.scr_anim["building1_mom"]["protect_death"] = % zd30c_002_infil_mother_death;
  level.scr_goaltime["building1_mom"]["protect_death"] = 0.25;
  level.scr_anim["building1_mom"]["protect_death_altA"] = % zd30c_002_infil_mother_death_alt;
  level.scr_goaltime["building1_mom"]["protect_death_altA"] = 0.25;
  level.scr_anim["building1_mom"]["protect_death_altB"] = % zd30c_002_infil_mother_death_alt2;
  level.scr_goaltime["building1_mom"]["protect_death_altB"] = 0.25;
  level.scr_anim["building1_mom"]["protect_death_idle"][0] = % zd30c_002_infil_mother_death_idle;
  level.scr_goaltime["building1_mom"]["protect_death_idle"] = 0.1;
  level.scr_anim["building1_mom"]["protect_death_kill"] = % zd30c_002_infil_mother_death_kill;
  scripts\common\anim::addnotetrack_customfunction("building1_mom", "swap_death", ::b1_mom_swap_death, "protect_react");
  scripts\common\anim::addnotetrack_customfunction("building1_mom", "blood_pool", ::blood_pool_mom, "protect_death");
  scripts\common\anim::addnotetrack_customfunction("building1_mom", "death_face", ::death_face, "protect_death");
  scripts\common\anim::addnotetrack_customfunction("building1_mom", "death_face", ::death_face, "protect_death_altA");
  scripts\common\anim::addnotetrack_detach_gun("building1_mom", "detach_gun", "protect_death_altA");
  scripts\common\anim::addnotetrack_detach_gun("building1_mom", "detach_gun", "protect_death");
  level.scr_anim["building1_child"]["protect_idle"][0] = % zd30c_002_infil_child_idle;
  level.scr_anim["building1_child"]["protect_react"] = % zd30c_002_infil_child_grab_gun;
  level.scr_goaltime["building1_child"]["protect_react"] = 0.25;
  level.scr_anim["building1_child"]["protect_react_idle"][0] = % zd30c_002_infil_child_gun_idle;
  level.scr_anim["building1_child"]["protect_death"] = % zd30c_002_infil_child_death;
  scripts\common\anim::addnotetrack_customfunction("building1_child", "vo_dx_vom_ccm1_heli_unload_guardhouse_134", ::whimper_loop, "protect_death");
  level.scr_goaltime["building1_child"]["protect_death"] = 0.25;
  level.scr_anim["building1_child"]["protect_death_idle"][0] = % zd30c_002_infil_child_death_idle;
  level.scr_goaltime["building1_child"]["protect_death_idle"] = 0.1;
  level.scr_anim["building1_child"]["protect_death_kill"] = % zd30c_002_infil_child_death_kill;
  level.scr_anim["alpha2"]["breach_idle"][0] = % zd30c_005_infil_gate_breach_idle_ally01;
  level.scr_anim["alpha2"]["breach"] = % zd30c_005_infil_gate_breach_ally01;
  level.scr_anim["alpha4"]["breach_idle"][0] = % zd30c_005_infil_gate_breach_idle_ally02;
  level.scr_anim["alpha4"]["breach"] = % zd30c_005_infil_gate_breach_ally02;
  level.scr_anim["alpha3"]["breach_setup"] = % zd30c_005_infil_gate_breach_setup_ally03;
  level.scr_anim["alpha3"]["breach_idle"][0] = % zd30c_005_infil_gate_breach_idle_ally03;
  level.scr_anim["alpha3"]["breach"] = % zd30c_005_infil_gate_breach_ally03;
  scripts\common\anim::addnotetrack_customfunction("alpha3", "clic", ::breach_explosion_fx, "breach");
  scripts\common\anim::addnotetrack_customfunction("alpha3", "detach_bomb", ::breach_bomb_detach, "breach_setup");
  level.scr_anim["price"]["moveup_arrival"] = % sdr_com_cover_left_stand_arrival_l_1;
  level.scr_anim["price"]["moveup_arrival_idle"][0] = % sdr_com_cover_left_stand_hide_idle;
  level.scr_anim["price"]["moveup_start"] = % sdr_cqb_cover_left_stand_fast_exit_7;
  level.scr_anim["price"]["door_arrival"] = % zd30c_1f_010_maindoor_arrival_ally01;
  level.scr_goaltime["price"]["door_arrival"] = 0.6;
  level.scr_anim["price"]["door_arrival_idle"][0] = % zd30c_1f_010_maindoor_arrival_idle_ally01;
  level.scr_anim["price"]["door_react"] = % zd30c_1f_010_maindoor_ally01;
  level.scr_anim["price"]["door_react_idle"][0] = % zd30c_1f_010_maindoor_idle_ally01;
  level.scr_anim["price"]["door_react_exit"] = % zd30c_1f_010_maindoor_exit_ally01;
  level.scr_anim["price"]["door_react_moveup"] = % zd30c_1f_040_breach_scenea_price;
  scripts\common\anim::addnotetrack_customfunction("price", "finish", ::temp_trim, "moveup_start");
  level.scr_anim["bravo4"]["moveup_arrival_idle"][0] = % sdr_com_exposed_crouch_idle01;
  level.scr_anim["bravo4"]["moveup_start"] = % sdr_cqb_exposed_crouch_fast_exit_7;
  level.scr_anim["bravo4"]["door_arrival"] = % zd30c_1f_010_maindoor_arrival_ally02;
  level.scr_goaltime["bravo4"]["door_arrival"] = 0.6;
  level.scr_anim["bravo4"]["door_arrival_idle"][0] = % zd30c_1f_010_maindoor_arrival_idle_ally02;
  level.scr_anim["bravo4"]["door_react"] = % zd30c_1f_010_maindoor_ally02;
  scripts\common\anim::addnotetrack_customfunction("bravo4", "visor_raise", ::nvg_off_fx, "door_react");
  scripts\common\anim::addnotetrack_customfunction("bravo4", "disable_light_fx", ::disable_light_fx, "door_react");
  scripts\common\anim::addnotetrack_customfunction("bravo4", "finish", ::temp_trim, "moveup_start");
  scripts\common\anim::addnotetrack_flag("bravo4", "notify_door_clip", "main_door_clip", "door_react");
  level.scr_anim["bravo5"]["moveup_arrival"] = % sdr_cqb_exposed_arrival_r_7;
  level.scr_anim["bravo5"]["moveup_arrival_idle"][0] = % sdr_com_exposed_stand_idle01;
  level.scr_anim["bravo5"]["moveup_start"] = % sdr_cqb_exposed_exit_9;
  level.scr_anim["bravo5"]["door_arrival"] = % zd30c_1f_010_maindoor_arrival_ally03;
  level.scr_goaltime["bravo5"]["door_arrival"] = 0.6;
  level.scr_anim["bravo5"]["door_arrival_idle"][0] = % zd30c_1f_010_maindoor_arrival_idle_ally03;
  level.scr_anim["bravo5"]["door_react"] = % zd30c_1f_010_maindoor_ally03;
  level.scr_anim["bravo5"]["door_react_exit"] = % zd30c_1f_010_maindoor_exit_ally03;
  level.scr_anim["bravo5"]["door_react_moveup"] = % zd30c_1f_010_maindoor_exit_ally01;
  scripts\common\anim::addnotetrack_customfunction("bravo5", "finish", ::temp_trim, "moveup_start");
  level.scr_anim["door_enemy"]["door_react"] = % zd30c_1f_010_maindoor_alq01;
  scripts\common\anim::addnotetrack_customfunction("door_enemy", "fire_start_sfx", ::fire_sfx_1f_door, "door_react");
  scripts\common\anim::addnotetrack_customfunction("door_enemy", "fire_silent", ::fire_silent_weapon, "door_react");
  scripts\common\anim::addnotetrack_customfunction("door_enemy", "kill", ::kill_enemy, "door_react");
  scripts\common\anim::addnotetrack_detach_gun("door_enemy", "detach_gun", "door_react");
  level.scr_anim["bravo1"]["door_arrival"] = % zd30c_1f_020_sidedoor_arrival_ally01;
  level.scr_goaltime["bravo1"]["door_arrival"] = 0.6;
  level.scr_anim["bravo1"]["door_arrival_idle"][0] = % zd30c_1f_020_sidedoor_idle_ally01;
  level.scr_anim["bravo1"]["door_arrival_exit"] = % zd30c_1f_020_sidedoor_exit_ally01;
  level.scr_anim["bravo2"]["door_arrival"] = % zd30c_1f_020_sidedoor_arrival_ally02;
  level.scr_goaltime["bravo2"]["door_arrival"] = 0.6;
  level.scr_anim["bravo2"]["door_arrival_idle"][0] = % zd30c_1f_020_sidedoor_idle_ally02;
  level.scr_anim["bravo2"]["door_arrival_exit"] = % zd30c_1f_020_sidedoor_exit_ally02;
  scripts\common\anim::addnotetrack_customfunction("bravo2", "tape", ::bravo2_tape, "door_arrival");
  scripts\common\anim::addnotetrack_customfunction("bravo2", "clacker_attach", ::clacker_attach, "door_arrival");
  level.scr_anim["alpha2"]["door_arrival"] = % zd30c_1f_010_maindoor_arrival_ally04;
  level.scr_goaltime["alpha2"]["door_arrival"] = 0.6;
  level.scr_anim["alpha2"]["door_arrival_idle"][0] = % zd30c_1f_010_maindoor_arrival_idle_ally04;
  level.scr_anim["civ04"]["1f_civ_run"] = % zd30c_1f_030_civs_run_woman03;
  level.scr_goaltime["civ04"]["1f_civ_run"] = 0;
  level.scr_anim["civ04"]["1f_civ_sceneA"] = % zd30c_1f_030_civs_grab_gun_woman03;
  level.scr_goaltime["civ04"]["1f_civ_sceneA"] = 0;
  level.scr_anim["civ04"]["1f_civ_sceneA_death"] = % zd30c_1f_030_civs_grab_gun_death_woman03;
  level.scr_anim["civ04"]["1f_civ_sceneB"] = % zd30c_1f_030_civs_bed_woman03;
  level.scr_goaltime["civ04"]["1f_civ_sceneB"] = 0;
  level.scr_anim["civ04"]["1f_civ_sceneB_idle"][0] = % zd30c_1f_030_civs_bed_idle_woman03;
  level.scr_anim["civ04"]["1f_civ_sceneB_death"] = % zd30c_1f_030_civs_bed_death_woman03;
  level.scr_anim["civ04"]["1f_civ_sceneC"] = % zd30c_1f_030_civs_bed_react_woman03;
  level.scr_anim["civ04"]["1f_civ_sceneC_idle"][0] = % zd30c_1f_030_civs_bed_react_idle_woman03;
  level.scr_anim["civ04"]["1f_civ_sceneC_death"] = % zd30c_1f_030_civs_bed_react_death_woman03;
  scripts\common\anim::addnotetrack_customfunction("civ04", "change_deathanim", ::change_civ04_deathanima, "1f_civ_sceneA");
  scripts\common\anim::addnotetrack_customfunction("civ04", "change_deathanim", ::change_civ04_deathanimb, "1f_civ_sceneB");
  scripts\common\anim::addnotetrack_customfunction("civ04", "fire_at_player", ::fire_at_player, "1f_civ_sceneC_idle");
  scripts\common\anim::addnotetrack_customfunction("civ04", "detach_gun", ::temp_spawn_gun, "1f_civ_sceneA");
  scripts\common\anim::addnotetrack_customfunction("civ04", "attach_gun", ::temp_swap_gun, "1f_civ_sceneA");
  scripts\common\anim::addnotetrack_customfunction("civ04", "detach_gun", ::temp_spawn_gun, "1f_civ_sceneB");
  scripts\common\anim::addnotetrack_customfunction("civ04", "attach_gun", ::temp_swap_gun, "1f_civ_sceneC");
  scripts\common\anim::addnotetrack_notify("civ04", "vo_dx_vom_cvf1_1st_floor_interior_237", "civ04_started_yelling", "1f_civ_sceneC");
  scripts\common\anim::addnotetrack_detach_gun("civ04", "detach_gun", "1f_civ_sceneA_death");
  level.scr_anim["civ01"]["1f_civ_idleA"][0] = % zd30c_1f_030_civs_idlea_woman01;
  level.scr_anim["civ02"]["1f_civ_idleA"][0] = % zd30c_1f_030_civs_idlea_woman02;
  level.scr_anim["civ03"]["1f_civ_idleA"][0] = % zd30c_1f_030_civs_idlea_child01;
  level.scr_anim["civ01"]["1f_civ_react"] = % zd30c_1f_030_civs_react_woman01;
  level.scr_goaltime["civ01"]["1f_civ_react"] = 0.25;
  level.scr_anim["civ02"]["1f_civ_react"] = % zd30c_1f_030_civs_react_woman02;
  level.scr_goaltime["civ02"]["1f_civ_react"] = 0.25;
  level.scr_anim["civ03"]["1f_civ_react"] = % zd30c_1f_030_civs_react_child01;
  level.scr_goaltime["civ03"]["1f_civ_react"] = 0.25;
  scripts\common\anim::addnotetrack_customfunction("civ01", "change_deathanim", ::change_civ01_deathanim, "1f_civ_react");
  scripts\common\anim::addnotetrack_customfunction("civ02", "change_deathanim", ::change_civ02_deathanim, "1f_civ_react");
  scripts\common\anim::addnotetrack_customfunction("civ02", "start_fail", ::start_fail_with_fade, "1f_civ_react");
  scripts\common\anim::addnotetrack_notify("civ02", "stop_reaction", "civ02_stop_react", "1f_civ_react");
  level.scr_anim["civ01"]["1f_civ_ads_react"] = % zd30c_1f_030_civs_ads_react_woman01;
  level.scr_goaltime["civ01"]["1f_civ_ads_react"] = 0.25;
  level.scr_anim["civ02"]["1f_civ_ads_react"] = % zd30c_1f_030_civs_ads_react_woman02;
  level.scr_goaltime["civ02"]["1f_civ_ads_react"] = 0.25;
  level.scr_anim["civ03"]["1f_civ_ads_react"] = % zd30c_1f_030_civs_ads_react_child01;
  level.scr_goaltime["civ03"]["1f_civ_ads_react"] = 0.25;
  level.scr_anim["civ01"]["1f_civ_idleB"][0] = % zd30c_1f_030_civs_idleb_woman01;
  level.scr_anim["civ02"]["1f_civ_idleB"][0] = % zd30c_1f_030_civs_idleb_woman02;
  level.scr_anim["civ03"]["1f_civ_idleB"][0] = % zd30c_1f_030_civs_idleb_child01;
  level.scr_anim["civ01"]["1f_civ_death01"] = % zd30c_1f_030_civs_killwmn1_woman01;
  level.scr_anim["civ01"]["1f_civ_death02"] = % zd30c_1f_030_civs_killwmn1and2_woman01;
  level.scr_anim["civ01"]["1f_civ_death_react"] = % zd30c_1f_030_civs_killwmn2child1_woman01;
  level.scr_anim["civ01"]["1f_civ_death_react_idle"][0] = % zd30c_1f_030_civs_killwmn2child1_idle_woman01;
  level.scr_anim["civ02"]["1f_civ_death01"] = % zd30c_1f_030_civs_killwmn2child1_woman02;
  level.scr_anim["civ02"]["1f_civ_death02"] = % zd30c_1f_030_civs_killwmn1and2_woman02;
  level.scr_anim["civ02"]["1f_civ_death_react"] = % zd30c_1f_030_civs_killwmn1_woman02;
  level.scr_anim["civ02"]["1f_civ_death_react_idle"][0] = % zd30c_1f_030_civs_killwmn1_idle_woman02;
  level.scr_anim["civ03"]["1f_civ_death01"] = % zd30c_1f_030_civs_killwmn2child1_child01;
  level.scr_anim["civ03"]["1f_civ_death_react"] = % zd30c_1f_030_civs_killwmn1_child01;
  level.scr_anim["civ03"]["1f_civ_death_react_idle"][0] = % zd30c_1f_030_civs_killwmn1_idle_child01;
  level.scr_anim["civ03"]["1f_civ_death_react_alt"] = % zd30c_1f_030_civs_killwmn1and2_child01;
  level.scr_anim["civ03"]["1f_civ_death_react_idle_alt"][0] = % zd30c_1f_030_civs_killwmn1and2_idle_child01;
  level.scr_anim["bravo1"]["1f_windowA"] = % hm_grnd_org_walk_cqb_forward_ar;
  level.scr_goaltime["bravo1"]["1f_windowA"] = 0.15;
  level.scr_anim["bravo1"]["1f_windowB"] = % hm_grnd_org_walk_cqb_forward_ar;
  level.scr_goaltime["bravo1"]["1f_windowB"] = 0.15;
  level.scr_anim["bravo2"]["1f_windowA"] = % reb_cqb_walk01;
  level.scr_goaltime["bravo2"]["1f_windowA"] = 0.15;
  level.scr_anim["bravo2"]["1f_windowB"] = % hm_grnd_org_walk_cqb_forward_ar;
  level.scr_goaltime["bravo2"]["1f_windowB"] = 0.15;
  level.scr_anim["alpha2"]["1f_windowA"] = % hm_grnd_org_exposed_cqb_arrival_ar_r_3;
  level.scr_goaltime["alpha2"]["1f_windowA"] = 0.15;
  level.scr_anim["alpha2"]["1f_windowB"] = % hm_grnd_org_exposed_cqb_exit_ar_7;
  level.scr_anim["alpha2"]["1f_windowC"] = % hm_grnd_org_walk_cqb_forward_ar;
  level.scr_goaltime["alpha2"]["1f_windowC"] = 0.15;
  level.scr_anim["bravo4"]["1f_hallway"] = % zd30c_1f_040_breach_scenea_sas01;
  level.scr_goaltime["bravo4"]["1f_hallway"] = 0.15;
  level.scr_anim["bravo4"]["1f_hallway_idle"][0] = % zd30c_1f_040_breach_idlea_sas01;
  level.scr_anim["bravo4"]["1f_hallway_idle_nags"][0] = % zd30c_1f_040_breach_idlea_nag_sas01;
  level.scr_anim["bravo4"]["1f_hallway_idle_nags_timer"] = 16;
  scripts\common\anim::addnotetrack_customfunction("bravo4", "power_vo", ::turn_off_power_vo, "1f_hallway");
  scripts\common\anim::addnotetrack_customfunction("bravo4", "nag", ::notify_self_nag, "1f_hallway_idle_nags");
  level.scr_anim["bravo4"]["1f_hallway_open"] = % zd30c_1f_040_breach_sceneb_sas01;
  level.scr_anim["bravo4"]["1f_hallway_open_idle"][0] = % zd30c_1f_040_breach_idleb_sas01;
  scripts\common\anim::addnotetrack_customfunction("bravo4", "visor_lower", ::nvg_on_fx, "1f_hallway_open");
  scripts\common\anim::addnotetrack_customfunction("bravo4", "look_at_player", ::look_at_player_start, "1f_hallway_open");
  level.scr_anim["bravo2"]["1f_hallway_open"] = % zd30c_1f_040_breach_sceneb_sas02;
  level.scr_anim["bravo2"]["1f_hallway_open_idle"][0] = % zd30c_1f_040_breach_idleb_sas02;
  level.scr_anim["price"]["1f_hallway_open"] = % zd30c_1f_040_breach_sceneb_price;
  level.scr_anim["price"]["1f_hallway_open_idle"][0] = % zd30c_1f_040_breach_idleb_price;
  level.scr_anim["price"]["1f_hallway_open_idle_nags"][0] = % zd30c_1f_040_breach_nag_price;
  level.scr_anim["price"]["1f_hallway_open_idle_nags_timer"] = 12;
  scripts\common\anim::addnotetrack_customfunction("price", "nag", ::notify_self_nag, "1f_hallway_open_idle_nags");
  level.scr_anim["price"]["2f_stairs_ascend"] = % zd30c_1f_040_breach_scenec_price;
  level.scr_goaltime["price"]["2f_stairs_ascend"] = 0.5;
  level.scr_anim["price"]["2f_stairs_ascend_idle"][0] = % zd30c_1f_040_breach_idlec_price;
  level.scr_anim["price"]["2f_stairs_ascend_additive_branch"] = % zd30c_stair_additives;
  level.scr_anim["price"]["2f_stairs_ascend_additive"] = % zd30c_stair_train_idle_forward;
  level.scr_anim["price"]["2f_stairs_ascend_settle"] = % zd30c_stair_train_settle_02_forward;
  level.scr_anim["price"]["2f_stairs_ascend_nag"] = % zd30c_stair_train_nag_side_a;
  scripts\common\anim::addnotetrack_customfunction("price", "visor_lower", ::nvg_on_fx, "1f_hallway_open");
  scripts\common\anim::addnotetrack_customfunction("price", "moveto_2f", ::moveto_2f_vo, "1f_hallway_open");
  level.scr_anim["bravo1"]["1f_hallway_open_idle"][0] = % zd30c_1f_040_breach_idlea_sas03;
  level.scr_anim["bravo1"]["2f_stairs_ascend"] = % zd30c_1f_040_breach_scenec_sas03;
  level.scr_goaltime["bravo1"]["2f_stairs_ascend"] = 0.5;
  level.scr_anim["bravo1"]["2f_stairs_ascend_idle"][0] = % zd30c_1f_040_breach_idlec_sas03;
  level.scr_anim["bravo1"]["2f_stairs_ascend_additive_branch"] = % zd30c_stair_additives;
  level.scr_anim["bravo1"]["2f_stairs_ascend_additive"] = % zd30c_stair_train_idle_forward;
  level.scr_anim["bravo1"]["2f_stairs_ascend_settle"] = % zd30c_stair_train_settle_02_forward;
  level.scr_anim["alpha2"]["1f_hallway_open"] = % zd30c_1f_040_breach_sceneb_sas04;
  level.scr_goaltime["alpha2"]["1f_hallway_open"] = 0.2;
  level.scr_anim["dead_kitchen"]["1f_hallway_open"] = % zd30c_1f_040_breach_sceneb_aq01;
  level.scr_goaltime["dead_kitchen"]["1f_hallway_open"] = 0.2;
  level.scr_anim["dead_enemy"]["dead_enemy"] = % est_cy_031_dead_bodies_c_dead01;
  level.scr_anim["price"]["2f_data_scene"] = % zd30c_2f_050_balcony_scenea_price;
  level.scr_goaltime["price"]["2f_data_scene"] = 0;
  level.scr_anim["price"]["2f_data_scene_idle"][0] = % zd30c_2f_050_balcony_idleb_price;
  scripts\common\anim::addnotetrack_customfunction("price", "fire", ::shoot_gun, "2f_data_scene");
  scripts\common\anim::addnotetrack_customfunction("price", "door_open", ::open_2f_data_door, "2f_data_scene");
  scripts\common\anim::addnotetrack_notify("price", "check_dataciv", "check_dataCiv_status", "2f_data_scene");
  level.scr_anim["data_enemy1"]["2f_data_scene"] = % zd30c_2f_050_balcony_scenea_aq01;
  level.scr_goaltime["data_enemy1"]["2f_data_scene"] = 0;
  level.scr_anim["data_enemy2"]["2f_data_scene"] = % zd30c_2f_050_balcony_scenea_aq02;
  level.scr_goaltime["data_enemy2"]["2f_data_scene"] = 0;
  level.scr_anim["data_civ"]["2f_data_scene"] = % zd30c_2f_050_balcony_scenea_aq03;
  level.scr_goaltime["data_civ"]["2f_data_scene"] = 0;
  level.scr_anim["data_civ"]["2f_data_scene_idle"][0] = % zd30c_2f_050_balcony_idleb_aq03;
  scripts\common\anim::addnotetrack_customfunction("data_civ", "secured", ::prisoner_secured, "2f_data_scene");
  level.scr_anim["balcony_enemy"]["2f_hallway"] = % zd30c_2f_050_balcony_scenea_enemy01;
  level.scr_anim["balcony_enemy"]["2f_hallway_turn"] = % hm_grnd_red_run_turn_l_2_ar;
  level.scr_anim["balcony_enemy"]["2f_hallway_death"] = % zd30c_2f_050_balcony_scenea_death_enemy01;
  level.scr_anim["balcony_enemy"]["2f_balcony_deathA"] = % hm_grnd_red_exposed_death_falls_8_ar;
  level.scr_anim["balcony_enemy"]["2f_balcony_deathB"] = % hm_grnd_red_exposed_death_neck_falls_8_ar;
  scripts\common\anim::addnotetrack_customfunction("balcony_enemy", "stop_anim", ::temp_trim, "2f_hallway");
  level.scr_anim["bravo1"]["2f_hallway"] = % zd30c_2f_050_balcony_scenea_sas01;
  level.scr_anim["bravo1"]["2f_hallway_idle"][0] = % zd30c_2f_050_balcony_idlea_sas01;
  level.scr_anim["bravo4"]["2f_hallway"] = % zd30c_2f_050_balcony_scenea_sas02;
  level.scr_anim["bravo4"]["2f_hallway_idle"][0] = % zd30c_2f_corridor_idle_ally01;
  level.scr_anim["bravo4"]["2f_hallway_post"] = % zd30c_2f_corridor_nag_ally01;
  level.scr_anim["bravo4"]["2f_hallway_post_idle"][0] = % zd30c_2f_corridor_idle_ally01;
  level.scr_anim["bravo4"]["2f_hallway_post_idle_nags"][0] = % zd30c_2f_corridor_nag_ally01;
  level.scr_anim["bravo4"]["2f_hallway_loop_idle_nags_timer"] = 10;
  scripts\common\anim::addnotetrack_customfunction("bravo4", "stop_anim", ::temp_trim, "2f_hallway");
  scripts\common\anim::addnotetrack_customfunction("bravo4", "nag", ::notify_self_nag, "2f_hallway_post");
  scripts\common\anim::addnotetrack_customfunction("bravo4", "nag", ::notify_self_nag, "2f_hallway_post_idle_nags");
  level.scr_anim["bed_enemy"]["stepout_left"] = % sdr_cqb_exposed_crouch_fast_arrival_r_4;
  level.scr_anim["bed_enemy"]["stepout_right"] = % sdr_cqb_exposed_crouch_fast_arrival_r_6;
  level.scr_anim["bed_enemy"]["bathroom_death"] = % zd30c_2f_050_bathroom_death_aq01;
  level.scr_anim["bed_civ"]["light_run"] = % zd30c_2f_050_woman_run;
  level.scr_anim["bed_civ"]["light_run_idle"][0] = % zd30c_2f_050_woman_idle;
  level.scr_anim["bed_civ"]["light_run_ads"] = % zd30c_2f_050_woman_ads;
  level.scr_anim["bed_civ"]["light_run_ads_idle"][0] = % zd30c_2f_050_woman_ads_idle;
  level.scr_anim["bed_civ"]["light_run_death"] = % zd30c_2f_050_woman_react_death;
  level.scr_anim["bravo1"]["3f_stairs_intro"][0] = % zd30c_3f_060_doubledoor_stairs_intro_idle_ally01;
  level.scr_anim["bravo1"]["3f_stairs_start"] = % zd30c_3f_060_doubledoor_stairs_intro_ally01;
  level.scr_anim["bravo1"]["3f_stairs"] = % zd30c_3f_060_doubledoor_stairs_ally01;
  level.scr_anim["bravo1"]["3f_stairs_idle"][0] = % zd30c_3f_060_doubledoor_stairs_idle_ally01;
  level.scr_anim["bravo1"]["3f_stairs_idle_nags"][0] = % zd30c_3f_060_doubledoor_stairs_nag_ally01;
  level.scr_anim["bravo1"]["3f_stairs_idle_nags_timer"] = 12;
  level.scr_anim["bravo1"]["3f_stairs_idle_end"][0] = % zd30c_3f_060_doubledoor_stairs_idle_ally01;
  scripts\common\anim::addnotetrack_customfunction("bravo1", "enemy_shooting", ::bravo1_3f_return_fire, "3f_stairs");
  scripts\common\anim::addnotetrack_flag("bravo1", "delete_clip", "3f_stairs_clip", "3f_stairs");
  scripts\common\anim::addnotetrack_customfunction("bravo1", "nag", ::notify_self_nag, "3f_stairs_idle_nags");
  level.scr_anim["bravo1"]["3f_door"] = % zd30c_3f_060_doubledoor_ally01;
  level.scr_anim["bravo1"]["3f_stairs_start_additive_branch"] = % zd30c_stair_additives;
  level.scr_anim["bravo1"]["3f_stairs_start_additive"] = % zd30c_stair_train_idle_forward;
  level.scr_anim["bravo1"]["3f_stairs_start_settle"] = % zd30c_stair_train_settle_02_forward;
  level.scr_anim["dead_enemy"]["3f_stairs_start"] = % zd30c_3f_060_doubledoor_stairs_alq01;
  scripts\common\anim::addnotetrack_customfunction("dead_enemy", "blood_smear", ::blood_smear, "3f_stairs_start");
  level.scr_anim["3f_enemy"]["3f_favella"] = % zd30c_3f_060_doubledoor_favella_introa_aq1;
  level.scr_anim["3f_enemy"]["3f_ally"] = % zd30c_3f_060_doubledoor_favella_introb_aq1;
  level.scr_anim["3f_enemy"]["3f_favella_idle"][0] = % zd30c_3f_060_doubledoor_favella_idle_aq1;
  level.scr_anim["3f_enemy"]["3f_favella_shoot"] = % zd30c_3f_060_doubledoor_favella_shoot_aq1;
  level.scr_anim["3f_enemy"]["3f_favella_death"] = % zd30c_3f_060_doubledoor_favella_death_aq1;
  level.scr_anim["3f_enemy"]["3f_favella_death_idle"][0] = % zd30c_3f_060_doubledoor_favella_death_idle_aq1;
  level.scr_anim["3f_enemy"]["3f_favella_death_alt"] = % zd30c_3f_060_doubledoor_favella_death_idle_kill_aq1;
  level.scr_anim["3f_enemy"]["3f_favella_react"] = % zd30c_3f_060_doubledoor_favella_death_react_aq1;
  scripts\common\anim::addnotetrack_customfunction("3f_enemy", "fire_at_player", ::fire_at_player, "3f_favella_shoot");
  scripts\common\anim::addnotetrack_customfunction("3f_enemy", "blood_pool", ::blood_pool, "3f_favella_death");
  scripts\common\anim::addnotetrack_detach_gun("3f_enemy", "detach_gun", "3f_favella_death");
  level.scr_anim["3f_hostage"]["3f_favella_idle"][0] = % zd30c_3f_060_doubledoor_favella_idle_woman;
  level.scr_anim["3f_hostage"]["3f_favella_pre_react"] = % zd30c_3f_060_doubledoor_favella_react_woman;
  level.scr_anim["3f_hostage"]["3f_favella_pre_react_idle"][0] = % zd30c_3f_060_doubledoor_favella_react_idle_woman;
  level.scr_anim["3f_hostage"]["3f_favella_pre_death"] = % zd30c_3f_060_doubledoor_favella_kill_woman;
  level.scr_anim["3f_hostage"]["3f_favella_death"] = % zd30c_3f_060_doubledoor_favella_death_woman;
  level.scr_anim["3f_hostage"]["3f_favella_death_idle"][0] = % zd30c_3f_060_doubledoor_favella_death_idle_woman;
  level.scr_anim["3f_hostage"]["3f_favella_death_alt"] = % zd30c_3f_060_doubledoor_favella_death_idle_kill_woman;
  level.scr_anim["3f_hostage"]["3f_favella_react"] = % zd30c_3f_060_doubledoor_favella_death_react_woman;
  level.scr_anim["3f_hostage"]["3f_favella_react_idle"][0] = % zd30c_3f_060_doubledoor_favella_death_react_idle_woman;
  level.scr_anim["3f_hostage"]["3f_favella_react_ads"] = % zd30c_3f_060_doubledoor_favella_death_reactb_woman;
  level.scr_anim["3f_hostage"]["3f_favella_react_death"] = % zd30c_3f_060_doubledoor_favella_death_kill_woman;
  scripts\common\anim::addnotetrack_customfunction("3f_hostage", "start_alt_death", ::start_alt_death, "3f_favella_death");
  scripts\common\anim::addnotetrack_customfunction("3f_hostage", "stop_alt_death", ::stop_alt_death, "3f_favella_react");
  level.scr_anim["bravo1"]["3f_ally"] = % zd30c_3f_060_doubledoor_favella_introb_ally;
  level.scr_anim["bravo1"]["3f_ally_idle"][0] = % zd30c_3f_060_doubledoor_favella_introb_idle_ally;
  level.scr_anim["bravo1"]["3f_ally_finish"][0] = % zd30c_3f_060_doubledoor_exit_idle_ally01;
  level.scr_anim["bravo4"]["2f_cleanup"] = % zd30c_2f_070_scenea_sas01;
  level.scr_anim["bravo4"]["2f_cleanup_idle"][0] = % zd30c_2f_070_idlea_sas01;
  level.scr_anim["bravo2"]["2f_cleanup"] = % zd30c_2f_070_scenea_sas02;
  level.scr_anim["bravo2"]["2f_cleanup_idle"][0] = % zd30c_2f_070_idlea_sas02;
  level.scr_anim["alpha3"]["2f_cleanup"] = % zd30c_2f_070_scenea_sas03;
  level.scr_anim["alpha3"]["2f_cleanup_idle"][0] = % zd30c_2f_070_idlea_sas03;
  level.scr_anim["alpha3"]["2f_cleanup_react"] = % zd30c_2f_070_idlea_react_sas03;
  level.scr_anim["sse_idle01"]["2f_cleanup_idle01"] = % hm_grnd_yel_patrol_idle01_ar;
  level.scr_anim["sse_idle02"]["2f_cleanup_idle02"] = % hm_grnd_yel_patrol_idle02_ar;
  level.scr_anim["sse_idle03"]["2f_cleanup_idle03"] = % hm_grnd_yel_patrol_idle03_ar;
  level.scr_anim["sse_idle04"]["2f_cleanup_idle04"] = % hm_grnd_yel_patrol_idle04_ar;
  level.scr_anim["data_enemy1"]["2f_cleanup"] = % zd30c_2f_070_sse_aq01;
  level.scr_anim["data_enemy2"]["2f_cleanup"] = % zd30c_2f_070_sse_aq02;
  level.scr_anim["price"]["tunnel_stairs_intro"] = % zd30c_090_tunnel_stairs_price_enter;
  level.scr_anim["price"]["tunnel_stairs_intro_idle"][0] = % zd30c_090_tunnel_stairs_idle_price;
  level.scr_anim["price"]["tunnel_stairs"] = % zd30c_090_tunnel_stairs_price;
  level.scr_anim["price"]["tunnel_stairs_idle"][0] = % zd30c_090_tunnel_intro_idle_price;
  level.scr_anim["alpha4"]["tunnel_stairs_idle"][0] = % zd30c_090_tunnel_intro_idle_ally04;
  level.scr_anim["alpha6"]["tunnel_stairs_idle"][0] = % zd30c_090_tunnel_intro_idle_ally06;
  level.scr_anim["civ1"]["tunnel_stairs_idle"][0] = % zd30c_090_tunnel_intro_idle_woman01;
  level.scr_anim["kid1"]["tunnel_stairs_idle"][0] = % zd30c_090_tunnel_intro_idle_kid01;
  scripts\common\anim::addnotetrack_notify("price", "price_moves", "price_on_the_move", "tunnel_stairs");
  level.scr_anim["price"]["tunnel_intro"] = % zd30c_090_tunnel_intro_price;
  level.scr_goaltime["price"]["tunnel_intro"] = 0.2;
  level.scr_anim["price"]["tunnel_intro_idle"][0] = % zd30c_090_tunnel_intro_exit_price;
  level.scr_anim["price"]["tunnel_intro_nag"] = % zd30c_090_tunnel_intro_nag_price;
  level.scr_anim["alpha4"]["tunnel_intro"] = % zd30c_090_tunnel_intro_ally04;
  level.scr_goaltime["alpha4"]["tunnel_intro"] = 0.2;
  level.scr_anim["alpha4"]["tunnel_intro_idle"][0] = % zd30c_090_tunnel_intro_exit_ally04;
  level.scr_anim["alpha6"]["tunnel_intro"] = % zd30c_090_tunnel_intro_ally06;
  level.scr_goaltime["alpha6"]["tunnel_intro"] = 0.2;
  level.scr_anim["alpha6"]["tunnel_intro_idle"][0] = % zd30c_090_tunnel_intro_exit_ally06;
  level.scr_anim["bravo5"]["tunnel_intro"] = % zd30c_090_tunnel_intro_ally07;
  level.scr_goaltime["bravo5"]["tunnel_intro"] = 0.2;
  level.scr_anim["bravo5"]["tunnel_intro_idle"][0] = % zd30c_090_tunnel_intro_idle_ally07;
  scripts\common\anim::addnotetrack_notify("price", "interrogation_over", "interrogation_over", "tunnel_intro");
  level.scr_anim["kid1"]["tunnel_intro"] = % zd30c_090_tunnel_intro_kid01;
  level.scr_goaltime["kid1"]["tunnel_intro"] = 0.2;
  level.scr_anim["kid1"]["tunnel_intro_idle"][0] = % zd30c_090_tunnel_intro_exit_kid01;
  level.scr_anim["kid2"]["tunnel_intro_idle"][0] = % zd30c_090_tunnel_intro_kid02;
  level.scr_anim["civ1"]["tunnel_intro"] = % zd30c_090_tunnel_intro_woman01;
  level.scr_goaltime["civ1"]["tunnel_intro"] = 0.2;
  level.scr_anim["civ1"]["tunnel_intro_idle"][0] = % zd30c_090_tunnel_intro_exit_woman01;
  level.scr_anim["civ2"]["tunnel_intro_idle"][0] = % zd30c_090_tunnel_intro_woman02;
  level.scr_anim["civ3"]["tunnel_intro_idle"][0] = % zd30c_090_tunnel_intro_woman03;
  level.scr_anim["civ4"]["tunnel_intro_idle"][0] = % zd30c_090_tunnel_intro_woman04;
  level.scr_anim["price"]["landing"] = % zd30c_090_tunnel_courtyard_price;
  level.scr_anim["price"]["landing_idle"][0] = % zd30c_090_tunnel_courtyard_idle_price;
  level.scr_anim["price"]["landing_nag"] = % zd30c_090_tunnel_courtyard_nag_price;
  level.scr_anim["charlieP1"]["landing"] = % zd30c_090_tunnel_courtyard_pilot;
  level.scr_anim["charlieP2"]["landing"] = % zd30c_090_tunnel_courtyard_copilot;
  level.scr_anim["farah"]["landing"] = % zd30c_090_tunnel_courtyard_farah;
  level.scr_anim["farah"]["landing_idle"][0] = % zd30c_090_tunnel_courtyard_idle_farah;
  level.scr_anim["alex"]["landing"] = % zd30c_090_tunnel_courtyard_alex;
  level.scr_anim["alex"]["landing_idle"][0] = % zd30c_090_tunnel_courtyard_idle_alex;
  level.scr_anim["charlie1"]["landing"] = % zd30c_090_tunnel_courtyard_ally01;
  level.scr_anim["charlie1"]["landing_idle"][0] = % zd30c_090_tunnel_courtyard_idle_ally01;
  level.scr_anim["price"]["entrance"] = % zd30c_090_tunnel_entrance_price;
  level.scr_goaltime["price"]["entrance"] = 0.4;
  level.scr_anim["kyle"]["entrance"] = % zd30c_090_tunnel_entrance_kyle;
  level.scr_goaltime["kyle"]["entrance"] = 0.4;
  level.scr_anim["farah"]["entrance"] = % zd30c_090_tunnel_entrance_farah;
  level.scr_goaltime["farah"]["entrance"] = 0.4;
  level.scr_anim["alex"]["entrance"] = % zd30c_090_tunnel_entrance_alex;
  level.scr_goaltime["alex"]["entrance"] = 0.4;
  level.scr_anim["charlie3"]["entrance"] = % zd30c_090_tunnel_entrance_ally03;
  level.scr_goaltime["charlie3"]["entrance"] = 0.4;
  scripts\common\anim::addnotetrack_customfunction("price", "drop_light", ::drop_glowstick, "entrance");
  scripts\common\anim::addnotetrack_customfunction("alex", "start_fireball", ::start_tunnels_fireball, "entrance");
  level.scr_anim["fake_bomber"]["tunnels_bomber"] = % sdr_com_run_turn_l_6;
  level.scr_anim["farah"]["basement_intro_enter"] = % zd30t_basement_intro_enter_farah;
  level.scr_anim["farah"]["basement_intro_wire"] = % zd30t_basement_intro_wire_farah;
  level.scr_anim["farah"]["basement_intro_exit"] = % zd30t_basement_intro_exit_farah;
  level.scr_anim["farah"]["basement_intro_branch_enter"] = % zd30t_basement_intro_branch_enter_farah;
  level.scr_anim["farah"]["basement_intro_branch_idle"][0] = % zd30t_basement_intro_branch_idle_farah;
  level.scr_anim["farah"]["basement_intro_branch_nag"] = % zd30t_basement_intro_branch_nag_farah;
  level.scr_anim["farah"]["basement_intro_branch_exit"] = % zd30t_basement_intro_branch_exit_farah;
  level.scr_face["farah"]["dx_vom_far_tunnels_tripwire_11"] = % zd30t_basement_intro_branch_nag01_farah_face;
  level.scr_face["farah"]["dx_vom_far_tunnels_tripwire_12"] = % zd30t_basement_intro_branch_nag02_farah_face;
  level.scr_anim["farah"]["basement_intro"] = % zd30t_basement_intro_farah;
  level.scr_anim["alex_wm"]["basement_intro"] = % zd30t_basement_intro_alex;
  scripts\common\anim::addnotetrack_customfunction("farah", "mayhem_start", ::farah_nobraids_body, "basement_intro_enter");
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start", %zd30t_basement_intro_enter_farah_face, "basement_intro_enter");
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end", %zd30t_basement_intro_enter_farah_face, "basement_intro_enter");
  scripts\common\anim::addnotetrack_customfunction("farah", "mayhem_end", ::farah_nobraids_body_reset, "basement_intro_enter");
  scripts\common\anim::addnotetrack_mayhemstart("alex_wm", "mayhem_start", %zd30t_basement_intro_alex_face, "basement_intro");
  scripts\common\anim::addnotetrack_mayhemend("alex_wm", "mayhem_end", %zd30t_basement_intro_alex_face, "basement_intro");
  level.scr_anim["farah"]["basement_trapdoor"] = % zd30t_basement_trapdoor_arrival_farah;
  level.scr_anim["farah"]["basement_trapdoor_exit"] = % zd30t_basement_trapdoor_exit_farah;
  level.scr_anim["farah"]["basement_trapdoor_idle"][0] = % zd30t_basement_trapdoor_idle_farah;
  level.scr_anim["trapper"]["basement_settrap"] = % zd30t_basement_alqatala_set_trap;
  level.scr_anim["trapper"]["basement_settrap_idle"][0] = % zd30t_basement_alqatala_set_trap_idle;
  level.scr_anim["trapper"]["basement_settrap_exit"] = % zd30t_basement_alqatala_set_trap_exit;
  level.scr_anim["trapper"]["basement_settrap_react"] = % zd30t_basement_alqatala_set_trap_react;
  level.scr_anim["paul_revere"]["basement_paul_revere"] = % zd30t_basement_paul_revere_aq02;
  level.scr_anim["first_blast"]["basement_first_blast"] = % zd30t_basement_paul_revere_aq01;
  level.scr_anim["basement_firstcell"]["blind_fire_right_idle"][0] = % zd30c_3f_060_doubledoor_favella_idle_aq1;
  level.scr_anim["basement_firstcell"]["blind_fire_right"] = % zd30t_basement_blind_fire_aq1;
  scripts\common\anim::addnotetrack_customfunction("basement_firstcell", "fire_at_player", ::fire_at_player_easy, "blind_fire_right");
  level.scr_anim["basement_right_to_left_runner"]["basement_run"] = % zd30t_basement_run_left_aq01;
  level.scr_anim["basement_left_to_right_runner"]["basement_run"] = % zd30t_basement_run_right_aq01;
  level.scr_anim["farah"]["basement_ceiling_takedown"] = % zd30t_basement_ceiling_kill_farah;
  level.scr_anim["farah"]["basement_ceiling_takedown_idle"][0] = % zd30t_basement_ceiling_idle_farah;
  level.scr_anim["farah"]["basement_ceiling_takedown_exit"] = % zd30t_basement_ceiling_exit_farah;
  level.scr_anim["takedown1_victim"]["basement_ceiling_takedown_aq"] = % zd30t_basement_ceiling_kill_aq01;
  level.scr_anim["farah"]["basement_hallway_takedown"] = % zd30t_basement_kill_reload_farah;
  level.scr_anim["takedown2_victim"]["basement_hallway_takedown"] = % zd30t_basement_kill_reload_aq01;
  scripts\common\anim::addnotetrack_customfunction("farah", "fire", ::shoot_gun, "basement_hallway_takedown");
  level.scr_anim["farah"]["collapse_crawl_A"] = % zd30t_basement_crawl_a_farah;
  level.scr_anim["farah"]["collapse_crawl_A_idle_nags"][0] = % zd30t_basement_crawl_a_nag_farah;
  level.scr_anim["farah"]["collapse_crawl_A_idle"][0] = % zd30t_basement_crawl_a_idle_farah;
  level.scr_anim["farah"]["collapse_crawl_B"] = % zd30t_basement_crawl_b_farah;
  level.scr_anim["farah"]["collapse_crawl_B_idle_nags"][0] = % zd30t_basement_crawl_b_nag_farah;
  level.scr_anim["farah"]["collapse_crawl_B_idle"][0] = % zd30t_basement_crawl_b_idle_farah;
  level.scr_anim["farah"]["collapse_crawl_C"] = % zd30t_basement_crawl_c_farah;
  level.scr_anim["farah"]["collapse_crawl_C_idle_nags"][0] = % zd30t_basement_crawl_c_nag_farah;
  level.scr_anim["farah"]["collapse_crawl_C_idle"][0] = % zd30t_basement_crawl_c_idle_farah;
  level.scr_anim["farah"]["collapse_crawl_D"] = % zd30t_basement_crawl_d_farah;
  level.scr_anim["farah"]["collapse_crawl_D_idle_nags"][0] = % zd30t_basement_crawl_d_nag_farah;
  level.scr_anim["farah"]["collapse_crawl_D_idle"][0] = % zd30t_basement_crawl_d_idle_farah;
  level.scr_anim["farah"]["collapse_crawl_E"] = % zd30t_basement_crawl_e_farah;
  level.scr_anim["farah"]["collapse_crawl_E_idle_nags"][0] = % zd30t_basement_crawl_e_nag_farah;
  level.scr_anim["farah"]["collapse_crawl_E_idle"][0] = % zd30t_basement_crawl_e_idle_farah;
  level.scr_anim["farah"]["collapse_crawl_F"] = % zd30t_basement_crawl_f_farah;
  level.scr_anim["farah"]["collapse_react"] = % zd30t_basement_explosion_react_farah;
  level.scr_anim["storage_spotter"]["storage_spotter_run"] = % zd30t_basement_wave_run_aq01;
  level.scr_anim["storage_surprise_guy"]["storage_surprise"] = % zd30c_002_infil_woman_couch_enter_aq02;
  level.scr_anim["storage_ambusher"]["blind_fire_right_idle"][0] = % zd30c_3f_060_doubledoor_favella_idle_aq1;
  level.scr_anim["storage_ambusher"]["blind_fire_right"] = % zd30t_basement_blind_fire_aq1;
  scripts\common\anim::addnotetrack_customfunction("storage_ambusher", "fire_at_player", ::fire_at_player_easy, "blind_fire_right");
  level.scr_anim["storage_pusher"]["storage_oilpush"] = % zd30t_mine_oil_spill_guy2;
  level.scr_anim["storage_lighter"]["storage_oilpush_idle"][0] = % est_search_locker_terry_idle;
  level.scr_anim["storage_mg_guy"]["burn_crawl"] = % sdr_com_exposed_crouch_long_death_crawl_belly;
  level.scr_anim["storage_mg_guy"]["burn_crawl_death"] = % sdr_com_exposed_crouch_long_death_crawl_belly_death;
  level.scr_anim["storage_mg_guy"]["dismount"] = % zd30t_basement_mg_exit_left_aq01;
  level.scr_anim["farah"]["storage_ladder"] = % zd30t_basement_ladder_arrival_farah;
  level.scr_anim["farah"]["storage_ladder_idle"][0] = % zd30t_basement_ladder_idle_farah;
  level.scr_anim["farah"]["ladder_explode"] = % zd30t_basement_ladder_explode_farah;
  level.scr_anim["clacker"]["ladder_explode"] = % zd30t_basement_ladder_explode_terry;
  level.scr_anim["clacker"]["ladder_death"] = % sdr_com_balcony_stand_norail_death02;
  level.scr_anim["farah"]["ladder_wakeup"] = % zd30t_basement_wakeup_intro_farah;
  level.scr_anim["farah"]["storage_split_scene_enter"] = % zd30t_basement_split_enter_farah;
  level.scr_anim["farah"]["storage_split_scene_enter_idleonce"] = % zd30t_basement_split_enter_idle_farah;
  level.scr_anim["farah"]["storage_split_scene_enter_idle"][0] = % zd30t_basement_split_enter_idle_farah;
  level.scr_anim["farah"]["storage_split_scene_enter_nag"] = % zd30t_basement_split_enter_nag_farah;
  level.scr_anim["farah"]["storage_split_scene_intro"] = % zd30t_basement_split_intro_farah;
  level.scr_anim["farah"]["storage_split_scene_intro_nag"] = % zd30t_basement_split_intro_nag_farah;
  level.scr_anim["farah"]["storage_split_scene_intro_idleonce"] = % zd30t_basement_split_intro_idle_farah;
  level.scr_anim["farah"]["storage_split_scene_intro_idle"][0] = % zd30t_basement_split_intro_idle_farah;
  level.scr_anim["farah"]["storage_split_scene_jump"] = % zd30t_basement_split_jump_farah;
  level.scr_anim["farah"]["storage_split_scene_jump_idle"][0] = % zd30t_basement_split_jump_idle_farah;
  level.scr_anim["farah"]["storage_split_scene_jump_exit"] = % zd30t_basement_split_jump_exit_farah;
  level.scr_anim["farah"]["mine_wakeup"] = % zd30t_basement_wakeup_farah;
  level.scr_anim["hadir"]["mine_wakeup"] = % zd30t_basement_wakeup_hadir;
  scripts\common\anim::addnotetrack_customfunction("hadir", "face_kick", ::hadir_face_kick, "mine_wakeup");
  level.scr_anim["pusher1"]["mine_oilpush"] = % zd30t_mine_oil_spill_guy1;
  level.scr_anim["pusher2"]["mine_oilpush"] = % zd30t_mine_oil_spill_guy2;
  level.scr_anim["farah"]["farah_storagedoor"] = % door_kick_in;
  level.scr_anim["farah"]["farah_tunneldoor"] = % door_kick_in;
  level.scr_anim["shaft_fire_victim"]["burn_crawl"] = % sdr_com_exposed_crouch_long_death_crawl_belly;
  level.scr_anim["shaft_fire_victim"]["burn_crawl_death"] = % sdr_com_exposed_crouch_long_death_crawl_belly_death;
  level.scr_anim["farah"]["shaft_ladder_intro"] = % zd30t_shaft_ladder_fall_intro_farah;
  level.scr_anim["farah"]["shaft_ladder_intro_idle"][0] = % zd30t_shaft_ladder_fall_intro_idle_farah;
  level.scr_goaltime["farah"]["shaft_ladder_intro_idle"] = 0.1;
  level.scr_anim["farah"]["shaft_ladder_intro_fail"] = % zd30t_shaft_ladder_fall_intro_fail_farah;
  level.scr_anim["farah"]["shaft_ladder_grab"] = % zd30t_shaft_ladder_fall_grab_farah;
  level.scr_anim["farah"]["shaft_ladder_grab_idle"][0] = % zd30t_shaft_ladder_fall_grab_idle_farah;
  level.scr_anim["farah"]["shaft_ladder_climb"] = % zd30t_shaft_ladder_fall_climb_farah;
  level.scr_goaltime["farah"]["shaft_ladder_climb"] = 0.1;
  scripts\common\anim::addnotetrack_attach("farah", "knife_attach", "weapon_wm_me_soscar_knife", "tag_accessory_left", "shaft_ladder_climb");
  scripts\common\anim::addnotetrack_detach("farah", "knife_stowed", "weapon_wm_me_soscar_knife", "tag_accessory_left", "shaft_ladder_climb");
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start_b", %zd30t_shaft_ladder_fall_climb_farah_b_face, "shaft_ladder_climb");
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end_b", %zd30t_shaft_ladder_fall_climb_farah_b_face, "shaft_ladder_climb");
  level.scr_anim["ladder_corpse"]["shaft_ladder_climb"] = % zd30t_shaft_ladder_fall_climb_aq01;
  level.scr_anim["ceiling_guy1"]["ceiling_death"] = % sdr_com_balcony_crouch_norail_death01;
  level.scr_anim["ceiling_guy2"]["ceiling_death"] = % sdr_com_balcony_crouch_norail_death01;
  level.scr_anim["ceiling_guy3"]["ceiling_death"] = % sdr_com_balcony_crouch_norail_death01;
  level.scr_anim["reunion_sacrifice"]["falling_death"] = % sdr_com_balcony_crouch_norail_death01;
  level.scr_anim["shaft_propane_kick_guy"]["falling_death"] = % sdr_com_balcony_crouch_norail_death01;
  level.scr_anim["shaft_propane_kick_guy"]["propane_kick"] = % zd30t_shaft_propane_kick_alq;
  level.scr_anim["shaft_propane_toss_guy"]["propane_toss"] = % zd30t_shaft_propane_throw_alq;
  level.scr_anim["deadbody_1"]["die_a_statue"] = % zd30t_basement_ceiling_kill_aq01;
  level.scr_anim["deadbody_2"]["die_a_statue"] = % zd30t_basement_kill_reload_aq01;
  level.scr_anim["farah"]["death_intro_enter_idle"][0] = % zd30t_wolf_death_enter_idle_farah;
  level.scr_anim["farah"]["death_intro_enter_nag"] = % zd30t_wolf_death_enter_nag_farah;
  level.scr_anim["wolf"]["death_intro"] = % zd30t_wolf_death_intro_wolf;
  level.scr_anim["farah"]["death_intro"] = % zd30t_wolf_death_intro_farah;
  level.scr_anim["farah"]["death_intro_idle"][0] = % zd30t_wolf_death_intro_idle_farah;
  level.scr_anim["wolf"]["death_kill"] = % zd30t_wolf_death_kill_wolf;
  level.scr_anim["farah"]["death_kill"] = % zd30t_wolf_death_kill_farah;
  scripts\common\anim::addnotetrack_customfunction("farah", "fire", ::shoot_gun, "death_kill");
  level.scr_anim["farah"]["death_diffuse_enter"] = % zd30t_wolf_death_diffuse_enter_farah;
  level.scr_anim["farah"]["death_diffuse_enter_nag"] = % zd30t_wolf_death_diffuse_enter_nag_farah;
  level.scr_anim["farah"]["death_diffuse_enter_idle"][0] = % zd30t_wolf_death_diffuse_enter_idle_farah;
  level.scr_anim["wolf"]["death_diffuse"] = % zd30t_wolf_death_diffuse_wolf;
  level.scr_anim["farah"]["death_diffuse"] = % zd30t_wolf_death_diffuse_farah;
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start", %zd30t_wolf_death_diffuse_farah_face, "death_diffuse");
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end", %zd30t_wolf_death_diffuse_farah_face, "death_diffuse");
  level.scr_anim["farah"]["death_diffuse_green"] = % zd30t_wolf_death_diffuse_green_farah;
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start", %zd30t_wolf_death_diffuse_green_farah_face, "death_diffuse_green");
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end", %zd30t_wolf_death_diffuse_green_farah_face, "death_diffuse_green");
  level.scr_anim["farah"]["death_diffuse_yellow"] = % zd30t_wolf_death_diffuse_yellow_farah;
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start", %zd30t_wolf_death_diffuse_yellow_farah_face, "death_diffuse_yellow");
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end", %zd30t_wolf_death_diffuse_yellow_farah_face, "death_diffuse_yellow");
  level.scr_anim["farah"]["death_diffuse_red"] = % zd30t_wolf_death_diffuse_red_farah;
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start", %zd30t_wolf_death_diffuse_red_farah_face, "death_diffuse_red");
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end", %zd30t_wolf_death_diffuse_red_farah_face, "death_diffuse_red");
  level.scr_anim["farah"]["death_end"] = % zd30t_wolf_death_end_farah;
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start", %zd30t_wolf_death_end_farah_face, "death_end");
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end", %zd30t_wolf_death_end_farah_face, "death_end");
  level.scr_anim["wolf"]["death_end"] = % zd30t_wolf_death_end_wolf;
  scripts\common\anim::addnotetrack_customfunction("farah", "farah_says_cut_wire", ::farah_says_cut_wire_green, "death_diffuse_green");
  scripts\common\anim::addnotetrack_customfunction("farah", "farah_says_cut_wire", ::farah_says_cut_wire_yellow, "death_diffuse_yellow");
  scripts\common\anim::addnotetrack_customfunction("farah", "farah_says_cut_wire", ::farah_says_cut_wire_red, "death_diffuse_red");
  level.scr_anim["wolf"]["coldopen_bink"] = % co_wolf_video_wolf;
  level.scr_anim["butcher"]["coldopen_bink"] = % co_wolf_video_butcher;
}

farah_says_cut_wire_green(var_0) {
  var_0 thread scripts\engine\utility::play_sound_in_space("dx_vom_far_wolf_death_81", level.farah.origin);
}

farah_says_cut_wire_yellow(var_0) {
  var_0 thread scripts\engine\utility::play_sound_in_space("dx_vom_far_wolf_death_101", level.farah.origin);
}

farah_says_cut_wire_red(var_0) {
  var_0 thread scripts\engine\utility::play_sound_in_space("dx_vom_far_wolf_death_171", level.farah.origin);
}

farah_nobraids_body(var_0) {
  level.farah.original_body_model = level.farah.model;
  level.farah setModel("body_hero_farah_nobraids");
}

farah_nobraids_body_reset(var_0) {
  if(isDefined(level.farah.original_body_model))
    level.farah setModel(level.farah.original_body_model);
}

start_fail_with_fade(var_0) {
  level endon("civs_moved_to_main_house");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_10) && var_10.basename == "flash") {
      continue;
    }
    break;
  }

  thread scripts\sp\hud_util::fade_out(0);
  var_0 stopsounds();
  var_0 kill();
  var_11 = [48, 49];
  var_12 = scripts\engine\utility::array_randomize(var_11);
  var_13 = var_12[0];
  scripts\sp\player_death::set_custom_death_quote(var_13);
  scripts\sp\utility::missionfailedwrapper();
}

notify_self_nag(var_0) {
  var_0 notify("nag");
}

drop_weapon_now(var_0) {
  if(isalive(var_0)) {
    var_0 dropweapon(var_0.weapon, "right");
    var_0 scripts\common\ai::gun_remove();
  }
}

hadir_face_kick(var_0) {
  var_0 notify("face_kicking");
}

nvg_on_fx(var_0) {
  wait 0.4;
  var_1 = scripts\engine\utility::getfx("nvg_eyelights");
  playFXOnTag(var_1, var_0, "j_nvg");
}

nvg_off_fx(var_0) {
  wait 0.4;
  var_1 = scripts\engine\utility::getfx("nvg_eyelights");
  stopFXOnTag(var_1, var_0, "j_nvg");
}

sledge_hits_door(var_0) {
  level notify("sledge_impact");
}

sledge_put_away(var_0) {
  var_0 detach("misc_wm_sledgehammer_scaled", "tag_accessory_right");
  var_0 attach("misc_wm_sledgehammer_scaled", "tag_stowed_back");
}

b1_girl_in_position(var_0) {
  var_0.isinposition = "yes";
}

prisoner_secured(var_0) {
  var_0.isinposition = "secured";
  var_0.nothreat = 1;
  level notify("dataCiv_is_secured");
}

b1_mom_swap_death(var_0) {
  var_0.mydeathanime = "protect_death";
}

whimper_loop(var_0) {
  if(scripts\engine\utility::flag("breach_finished")) {
    return;
  }
  level endon("breach_finished");
  wait(lookupsoundlength("dx_vom_ccm1_heli_unload_guardhouse_134") / 1000);

  for(;;) {
    var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_ccm1_heli_unload_guardhouse_132");
    var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_ccm1_heli_unload_guardhouse_134");
    waitframe();
  }
}

blood_pool_mom(var_0) {
  if(!var_0.enemywasmeleed)
    scripts\engine\utility::exploder("woman_one_blood");
}

death_face(var_0) {
  var_0 setfacialindex("none");
}

breach_explosion_fx(var_0) {
  if(isDefined(level.bomb))
    level.bomb delete();

  scripts\engine\utility::flag_set("breach_explosion");
  screenshake(level.player.origin, 9, 2, 2, 0.5);
  var_1 = scripts\engine\utility::getStruct("breach_gate_damage", "targetname");
  thread gate_breach_sfx(var_1.origin);
  radiusdamage(var_1.origin, var_1.radius, 5, 5);
}

gate_breach_sfx(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playexplosionsound("scn_zd30_gate_breach", "exp");
  wait 5.3;
  var_1 delete();
}

breach_bomb_detach(var_0) {
  var_1 = var_0 gettagorigin("tag_accessory_right");
  var_2 = var_0 gettagangles("tag_accessory_right");
  var_0 detach("offhand_wm_c4_bomb_sp", "tag_accessory_right");
  level.bomb = spawn("script_model", var_1);
  level.bomb.angles = var_2;
  level.bomb setModel("offhand_wm_c4_bomb_sp");
}

clacker_attach(var_0) {
  var_0 attach("offhand_vm_clacker_tactical", "tag_accessory_right");
  var_0.clackerattached = 1;
}

clacker_detach(var_0) {
  var_0 detach("offhand_vm_clacker_tactical", "tag_accessory_right");
}

bravo2_tape(var_0) {
  var_1 = scripts\engine\utility::getStruct("1f_animnode", "targetname");
  var_2 = scripts\engine\sp\utility::spawn_anim_model("side_door_tape");
  var_1 scripts\common\anim::anim_single_solo(var_2, "door_arrival");
  var_1 scripts\common\anim::anim_last_frame_solo(var_2, "door_arrival");
  scripts\engine\utility::flag_wait("compound_side_door_breach");
  var_2 delete();
}

kill_enemy(var_0) {
  var_0.allowdeath = 1;
  var_0.disabledeathorient = 1;
  var_0 kill();
}

fire_silent_weapon(var_0) {
  var_1 = [9, 16, 11, 13, 14, 15, 4, 7, 6, 5, 1];

  if(!isDefined(level.doorfirecount))
    level.doorfirecount = 0;

  var_2 = undefined;

  if(var_1[level.doorfirecount] >= 10)
    var_2 = "0";
  else
    var_2 = "00";

  var_3 = level.maindoor[0] gettagorigin("tag_geo_frag_a_" + var_2 + var_1[level.doorfirecount]);
  var_4 = level.maindoor[0] gettagangles("tag_geo_frag_a_" + var_2 + var_1[level.doorfirecount]);
  var_5 = var_0 gettagorigin("tag_flash");
  var_6 = var_3 + vectorNormalize(var_3 - var_5) * 300;
  playFX(scripts\engine\utility::getfx("akilo_muzzle_flash"), var_5);
  bullettracer(var_5, var_6, "iw8_sn_alpha50", 1);
  var_7 = scripts\engine\trace::ray_trace(var_5, var_6, level.maindoor[0], undefined, 1, 1);

  if(isDefined(var_7) && isDefined(var_7["entity"]) && var_7["entity"] == level.player) {
    var_8 = getEnt("main_door_trigger", "targetname");

    if(level.player istouching(var_8))
      level.player scripts\sp\utility::do_damage(75, var_5, var_0, undefined, "MOD_RIFLE_BULLET", "iw8_ar_akilo47");
    else
      level.player scripts\sp\utility::do_damage(40, var_5, var_0, undefined, "MOD_RIFLE_BULLET", "iw8_ar_akilo47");
  }

  level.maindoor[0] setscriptablepartstate("" + var_1[level.doorfirecount], "hide");
  level.maindoorcleanup[level.maindoorcleanup.size] = "" + var_1[level.doorfirecount];
  level.doorfirecount++;
}

fire_sfx_1f_door(var_0) {
  var_0 playSound("scn_zd30_1f_door_gunfire");
  level.maindoor[0] playSound("scn_zd30_1f_door_gunfire_door");
}

disable_light_fx(var_0) {
  level notify("disable_light_fx");

  foreach(var_2 in level.maindoorcleanup)
  level.maindoor[0] setscriptablepartstate(var_2, "vfx_off");
}

shoot_gun(var_0) {
  var_0 shoot();
}

change_civ01_deathanim(var_0) {
  var_0.deathanim = var_0 scripts\engine\utility::getanim("1f_civ_death02");
}

change_civ02_deathanim(var_0) {
  var_0.noragdoll = 1;
  var_0.skipdeathanim = undefined;
  var_0.deathanim = var_0 scripts\engine\utility::getanim("1f_civ_death02");
}

change_civ04_deathanima(var_0) {
  var_0.mydeathanime = "1f_civ_sceneA_death";
}

change_civ04_deathanimb(var_0) {
  var_0.mydeathanime = "1f_civ_sceneB_death";
}

temp_spawn_gun(var_0) {
  var_0 scripts\common\ai::gun_remove();
  var_1 = var_0 gettagorigin("tag_weapon_right");
  var_2 = var_0 gettagangles("tag_weapon_right");
  level.gunbed = spawn("weapon_" + createheadicon(var_0.weapon), var_1);
  level.gunbed.angles = var_2;
}

temp_swap_gun(var_0) {
  var_0 scripts\common\ai::gun_recall();

  if(isDefined(level.gunbed))
    level.gunbed delete();
}

look_at_player_start(var_0) {
  var_0 thread scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::lookat_random_lite("tunnels_transition");
  scripts\engine\utility::flag_wait("player_at_top_2f_stairs");
  var_0.stop_lookat_random = 1;
}

temp_trim(var_0) {
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
}

moveto_2f_vo(var_0) {
  wait 8;
  level.bravo2 scripts\engine\sp\utility::smart_dialogue("dx_vom_b65_2nd_floor_stairs_20");
}

turn_off_power_vo(var_0) {
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_b63_1st_floor_power_40");
  wait 1;

  if(!scripts\engine\utility::flag("power_is_off"))
    scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::objective_control("power");

  level.bravo4 notify("start_power_off_nag");
}

stairtrain_twitch_get() {
  var_0 = [];
  var_0[var_0.size] = % zd30c_stair_train_twitch_01;
  var_0[var_0.size] = % zd30c_stair_train_twitch_02;
  var_0[var_0.size] = % zd30c_stair_train_twitch_03;
  var_0[var_0.size] = % zd30c_stair_train_twitch_04;
  var_0[var_0.size] = % zd30c_stair_train_twitch_05;
  var_0[var_0.size] = % zd30c_stair_train_twitch_06;
  var_0[var_0.size] = % zd30c_stair_train_twitch_07;
  var_0[var_0.size] = % zd30c_stair_train_twitch_08;
  var_0[var_0.size] = % zd30c_stair_train_twitch_09;
  return var_0[randomint(var_0.size)];
}

open_2f_data_door(var_0) {
  var_0 scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::interactive_double_door_force_open("2f_data_door");
  scripts\engine\utility::flag_set("price_kick_in_door");
}

blood_smear(var_0) {
  var_1 = getEnt("3f_blood_smear", "targetname");
  var_1 show();
}

blood_pool(var_0) {
  scripts\engine\utility::exploder("closet_blood");
}

fire_at_player(var_0) {
  if(var_0 cansee(level.player)) {
    if(!isDefined(var_0.enemyflashed))
      var_0 shoot(0.9, level.player);
  }
}

fire_at_player_easy(var_0) {
  var_0 shoot(0.6, level.player);
}

start_alt_death(var_0) {
  var_0.altdeath = 1;
}

stop_alt_death(var_0) {
  var_0.altdeath = 0;
}

bravo1_3f_return_fire(var_0) {
  var_1 = scripts\engine\utility::getStruct("3f_shoot", "targetname");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_3 = [];
  var_3[0] = (0, 0, 0);
  var_3[1] = (-5, 0, 7);
  var_3[2] = (-10, 0, -5);
  var_3[3] = (0, 0, 0);
  var_4 = 0;
  playworldsound("scn_zd30_3f_door_gunfire", var_1.origin);
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_3f_door_gunfire_door", var_2.origin);

  for(var_4 = 0; var_4 < 4; var_4++) {
    magicbullet("iw8_ar_akilo47_silent", var_1.origin, var_2.origin + var_3[var_4]);
    wait 0.12;
  }

  wait 0.3;
  level notify("close_3f_door");
}

drop_glowstick(var_0) {
  var_1 = spawn("script_model", var_0 gettagorigin("tag_accessory_left"));
  var_1.origin = var_0 gettagorigin("tag_accessory_left");
  var_1.angles = var_0 gettagangles("tag_accessory_left");
  var_1 setModel("weapon_zd30_glowstick_wm_lit");
  var_1 linkTo(var_0, "tag_accessory_left", (0, 0, 0), (0, 0, 0));
  var_1 setModel("tag_origin");
  playFXOnTag(level._effect["vfx_zd30_glow_stick_drop"], var_1, "tag_origin");
  wait 4;
  var_1 unlink();
  level waittill("tunnels_transition");
  var_1 delete();
}

start_tunnels_fireball(var_0) {
  var_1 = scripts\engine\utility::getStructArray("tunnel_fireball_fx", "targetname");

  foreach(var_3 in var_1)
  playFX(level._effect["vfx_suicide_bomber_tunnel"], var_3.origin, anglesToForward(var_3.angles));

  var_0 scripts\engine\utility::delaythread(0.4, ::screen_shake_stuff);
  scripts\engine\utility::delaythread(2, scripts\sp\hud_util::fade_out, 0.05, "black");
  var_0 temp_sound_fx(var_1);
}

screen_shake_stuff() {
  var_0 = self gettagorigin("j_head");
  earthquake(0.3, 0.5, var_0, 300);
  screenshake(var_0, 1.5, 0, 0, 0.5);
  playrumbleonposition("grenade_rumble", var_0);
}

temp_sound_fx(var_0) {
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_gas_expl_trans", var_0[0].origin);
  wait 0.6;
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_gas_expl_fireball_front", var_0[0].origin);
  thread scripts\engine\utility::play_sound_in_space("scn_zd30_gas_expl_fireball_rear", var_0[0].origin);
  wait 1;
  level.player playSound("scn_zd30_collapse_lr_02");
}

infil_remove_fov_scale_factor_override(var_0) {
  level.player lerpfovscalefactor(1, 0.85);
}

entrance_add_fov_scale_factor_override(var_0) {
  level.player lerpfovscalefactor(0, 0.8);
}

basement_intro_add_fov_scale_factor_override(var_0) {
  level.player lerpfovscalefactor(1, 1.5);
}

shaft_ladder_add_fov_scale_factor_override(var_0) {
  level.player lerpfovscalefactor(0, 0.8);
}

shaft_ladder_remove_fov_scale_factor_override(var_0) {
  level.player lerpfovscalefactor(1, 1);
  level.player_rig scripts\engine\utility::delaycall(1, ::hide);
}

storage_split_remove_fov_scale_factor_override(var_0) {
  level.player lerpfovscalefactor(1, 0.6);
}

vo_face() {
  level.scr_face["building1_girl"]["dx_vom_aqf1_heli_unload_guardhouse_144"] = % dx_vom_aqf1_heli_unload_guardhouse_144_face;
  level.scr_face["price"]["dx_vom_pri_2nd_floor_hallway_60"] = % dx_vom_pri_2nd_floor_hallway_60_face;
  level.scr_face["price"]["dx_vom_pri_2nd_floor_hallway_80"] = % dx_vom_pri_2nd_floor_hallway_80_face;
  level.scr_face["bed_civ"]["dx_vom_aqf1_heli_unload_guardhouse_83"] = % dx_vom_heli_unload_guardhouse_aqf1_83_face;
  level.scr_face["price"]["dx_vom_pri_downstairs_interrogation_100"] = % dx_vom_pri_downstairs_interrogation_100_face;
  level.scr_face["price"]["dx_vom_pri_downstairs_teahouse_128"] = % dx_vom_pri_downstairs_teahouse_128_face;
  level.scr_face["price"]["dx_vom_pri_downstairs_teahouse_130"] = % dx_vom_pri_downstairs_teahouse_130_face;
  level.scr_face["price"]["dx_vom_pri_downstairs_teahouse_140"] = % dx_vom_pri_downstairs_teahouse_140_face;
  level.scr_face["alex"]["dx_vom_alx_downstairs_teahouse_150"] = % dx_vom_alx_downstairs_teahouse_150_face;
  level.scr_face["farah"]["dx_vom_far_wolf_death_12"] = % dx_vom_far_wolf_death_12_face;
  level.scr_face["farah"]["dx_vom_far_wolf_death_13"] = % dx_vom_far_wolf_death_13_face;
  level.scr_face["farah"]["dx_vom_far_wolf_death_14"] = % dx_vom_far_wolf_death_14_face;
  level.scr_face["farah"]["dx_vom_far_wolf_death_40"] = % dx_vom_far_wolf_death_40_face;
  level.scr_face["farah"]["dx_vom_far_wolf_death_57"] = % dx_vom_far_wolf_death_57_face;
  level.scr_face["farah"]["dx_vom_far_wolf_death_61"] = % dx_vom_far_wolf_death_61_face;
  level.scr_face["farah"]["dx_vom_far_wolf_death_63"] = % dx_vom_far_wolf_death_63_face;
  level.scr_face["farah"]["dx_vom_far_wolf_death_64"] = % dx_vom_far_wolf_death_64_face;
  level.scr_face["wolf"]["dx_vom_wolf_wolf_death_20"] = % dx_vom_wolf_wolf_death_20_face;
  level.scr_face["wolf"]["dx_vom_wolf_wolf_death_30"] = % dx_vom_wolf_wolf_death_30_face;
}

#using_animtree("dog");

dogs() {
  level.scr_anim["infil_dog1"]["introA_idle"][0] = % iw6_dog_casualidle;
  level.scr_anim["infil_dog1"]["introA"] = % iw6_dog_sprint;
  level.scr_anim["infil_dog1"]["introB"] = % iw6_dog_run_quickturn_7;
  level.scr_anim["infil_dog1"]["introC"] = % iw6_dog_attackidle_runin_9;
  level.scr_anim["infil_dog1"]["introC_idle"][0] = % iw6_dog_attackidle_bark;
}

#using_animtree("script_model");

script_models() {
  level.scr_animtree["door"] = #animtree;
  level.scr_anim["door"]["sledge_intro"] = % zd30c_000_infil_lbirds_sledge_door;
  level.scr_anim["door"]["main_door_open"] = % zd30c_1f_010_maindoor_door;
  level.scr_anim["door"]["3f_favella_l"] = % zd30c_3f_060_doubledoor_favella_introa_doorl;
  level.scr_anim["door"]["3f_favella_death_l"] = % zd30c_3f_060_doubledoor_favella_death_doorl;
  level.scr_anim["door"]["3f_ally_fl"] = % zd30c_3f_060_doubledoor_favella_introb_aq_doorl;
  level.scr_anim["door"]["3f_favella_r"] = % zd30c_3f_060_doubledoor_favella_introa_doorr;
  level.scr_anim["door"]["3f_favella_death_r"] = % zd30c_3f_060_doubledoor_favella_death_doorr;
  level.scr_anim["door"]["3f_ally_fr"] = % zd30c_3f_060_doubledoor_favella_introb_aq_doorr;
  level.scr_anim["door"]["3f_ally_al"] = % zd30c_3f_060_doubledoor_favella_introb_ally_doorl;
  level.scr_anim["door"]["3f_ally_ar"] = % zd30c_3f_060_doubledoor_favella_introb_ally_doorr;
  level.scr_animtree["gate_l"] = #animtree;
  level.scr_anim["gate_l"]["breach"] = % zd30c_005_infil_gate_breach_lgate;
  scripts\common\anim::addnotetrack_customfunction("gate_l", "model_swap", ::model_swap_gate, "breach");
  level.scr_animtree["gate_r"] = #animtree;
  level.scr_anim["gate_r"]["breach"] = % zd30c_005_infil_gate_breach_rgate;
  scripts\common\anim::addnotetrack_customfunction("gate_r", "model_swap", ::model_swap_gate, "breach");
  level.scr_animtree["side_door"] = #animtree;
  level.scr_model["side_door"] = "door_industrial_metal_sp_01";
  level.scr_anim["side_door"]["side_door_open"] = % zd30c_1f_020_sidedoor_exit_door;
  level.scr_animtree["side_door_tape"] = #animtree;
  level.scr_model["side_door_tape"] = "military_explosive_sheet_a";
  level.scr_anim["side_door_tape"]["door_arrival"] = % zd30c_1f_020_sidedoor_arrival_tape;
  level.scr_animtree["hallway_door"] = #animtree;
  level.scr_anim["hallway_door"]["1f_hallway_open"] = % zd30c_1f_040_breach_sceneb_door;
  level.scr_animtree["power"] = #animtree;
  level.scr_anim["power"]["power_interact"] = % zd30_vm_fusebox_handle;
  scripts\common\anim::addnotetrack_customfunction("power", "handle_down", scripts\sp\maps\tunnels\zd30tunnels_infil.gsc::power_handle_down, "power_interact");
  level.scr_animtree["ziptie"] = #animtree;
  level.scr_model["ziptie"] = "zip_tie_handcuffs_wm";
  level.scr_anim["ziptie"]["b1_secure"] = % zd30c_002_infil_woman_couch_secure_ziptie;
  level.scr_anim["ziptie"]["b1_secure_idle"][0] = % zd30c_002_infil_woman_couch_secure_idle_ziptie;
  level.scr_animtree["sse1"] = #animtree;
  level.scr_model["sse1"] = "prop_un_military_duffle_bag_01";
  level.scr_anim["sse1"]["2f_cleanup"] = % zd30c_2f_070_scenea_duffel01;
  level.scr_animtree["sse2"] = #animtree;
  level.scr_model["sse2"] = "prop_un_military_duffle_bag_01";
  level.scr_anim["sse2"]["2f_cleanup"] = % zd30c_2f_070_scenea_duffel02;
  level.scr_animtree["sse3"] = #animtree;
  level.scr_model["sse3"] = "computer_pc_tower_01_broken";
  level.scr_anim["sse3"]["2f_cleanup"] = % zd30c_2f_070_scenea_computer01;
  level.scr_animtree["sse4"] = #animtree;
  level.scr_model["sse4"] = "computer_pc_tower_01_broken";
  level.scr_anim["sse4"]["2f_cleanup"] = % zd30c_2f_070_scenea_computer02;
  level.scr_animtree["sse5"] = #animtree;
  level.scr_model["sse5"] = "prop_black_backpack";
  level.scr_anim["sse5"]["2f_cleanup"] = % zd30c_2f_070_scenea_bag01;
  level.scr_animtree["sse6"] = #animtree;
  level.scr_model["sse6"] = "prop_black_backpack";
  level.scr_anim["sse6"]["2f_cleanup"] = % zd30c_2f_070_scenea_bag02;
  level.scr_animtree["sse7"] = #animtree;
  level.scr_model["sse7"] = "uk_file_cabinet_garage_big_01";
  level.scr_anim["sse7"]["2f_cleanup"] = % zd30c_2f_070_scenea_cabinet01;
  level.scr_animtree["sse8"] = #animtree;
  level.scr_model["sse8"] = "uk_file_cabinet_garage_big_01";
  level.scr_anim["sse8"]["2f_cleanup"] = % zd30c_2f_070_scenea_cabinet02;
  level.scr_animtree["sse9"] = #animtree;
  level.scr_model["sse9"] = "un_office_binder_01";
  level.scr_anim["sse9"]["2f_cleanup"] = % zd30c_2f_070_scenea_binder01;
  level.scr_animtree["sse10"] = #animtree;
  level.scr_model["sse10"] = "un_office_binder_01";
  level.scr_anim["sse10"]["2f_cleanup"] = % zd30c_2f_070_scenea_binder02;
  level.scr_animtree["sse11"] = #animtree;
  level.scr_model["sse11"] = "un_office_binder_open_01";
  level.scr_anim["sse11"]["2f_cleanup"] = % zd30c_2f_070_scenea_binder03;
  level.scr_animtree["sse12"] = #animtree;
  level.scr_model["sse12"] = "school_textbooks_03";
  level.scr_anim["sse12"]["2f_cleanup"] = % zd30c_2f_070_scenea_textbook01;
  level.scr_animtree["sse13"] = #animtree;
  level.scr_model["sse13"] = "school_textbooks_03";
  level.scr_anim["sse13"]["2f_cleanup"] = % zd30c_2f_070_scenea_textbook04;
  level.scr_animtree["sse14"] = #animtree;
  level.scr_model["sse14"] = "school_textbooks_01";
  level.scr_anim["sse14"]["2f_cleanup"] = % zd30c_2f_070_scenea_textbook02;
  level.scr_animtree["sse15"] = #animtree;
  level.scr_model["sse15"] = "school_textbooks_01";
  level.scr_anim["sse15"]["2f_cleanup"] = % zd30c_2f_070_scenea_textbook03;
  level.scr_animtree["sse16"] = #animtree;
  level.scr_model["sse16"] = "un_office_passport_01";
  level.scr_anim["sse16"]["2f_cleanup"] = % zd30c_2f_070_scenea_passport01;
  level.scr_animtree["sse17"] = #animtree;
  level.scr_model["sse17"] = "un_office_passport_01";
  level.scr_anim["sse17"]["2f_cleanup"] = % zd30c_2f_070_scenea_passport02;
  level.scr_animtree["sse18"] = #animtree;
  level.scr_model["sse18"] = "un_office_passport_01";
  level.scr_anim["sse18"]["2f_cleanup"] = % zd30c_2f_070_scenea_passport03;
  level.scr_animtree["sse19"] = #animtree;
  level.scr_model["sse19"] = "un_office_passport_01";
  level.scr_anim["sse19"]["2f_cleanup"] = % zd30c_2f_070_scenea_passport04;
  level.scr_animtree["sse20"] = #animtree;
  level.scr_model["sse20"] = "un_office_passport_01";
  level.scr_anim["sse20"]["2f_cleanup"] = % zd30c_2f_070_scenea_passport05;
  level.scr_animtree["sse21"] = #animtree;
  level.scr_model["sse21"] = "electronics_vhs_tapes_01";
  level.scr_anim["sse21"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs01;
  level.scr_animtree["sse22"] = #animtree;
  level.scr_model["sse22"] = "electronics_vhs_tapes_01";
  level.scr_anim["sse22"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs08;
  level.scr_animtree["sse23"] = #animtree;
  level.scr_model["sse23"] = "electronics_vhs_tapes_02";
  level.scr_anim["sse23"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs02;
  level.scr_animtree["sse24"] = #animtree;
  level.scr_model["sse24"] = "electronics_vhs_tapes_02";
  level.scr_anim["sse24"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs07;
  level.scr_animtree["sse25"] = #animtree;
  level.scr_model["sse25"] = "electronics_vhs_tapes_03";
  level.scr_anim["sse25"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs03;
  level.scr_animtree["sse26"] = #animtree;
  level.scr_model["sse26"] = "electronics_vhs_tapes_03";
  level.scr_anim["sse26"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs04;
  level.scr_animtree["sse27"] = #animtree;
  level.scr_model["sse27"] = "electronics_vhs_tapes_03";
  level.scr_anim["sse27"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs05;
  level.scr_animtree["sse28"] = #animtree;
  level.scr_model["sse28"] = "electronics_vhs_tapes_03";
  level.scr_anim["sse28"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs06;
  level.scr_animtree["sse29"] = #animtree;
  level.scr_model["sse29"] = "electronics_vhs_tapes_03";
  level.scr_anim["sse29"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs09;
  level.scr_animtree["sse30"] = #animtree;
  level.scr_model["sse30"] = "electronics_vhs_tapes_03";
  level.scr_anim["sse30"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs10;
  level.scr_animtree["sse31"] = #animtree;
  level.scr_model["sse31"] = "electronics_vhs_tapes_03";
  level.scr_anim["sse31"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs11;
  level.scr_animtree["sse32"] = #animtree;
  level.scr_model["sse32"] = "electronics_vhs_tapes_03";
  level.scr_anim["sse32"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs12;
  level.scr_animtree["sse33"] = #animtree;
  level.scr_model["sse33"] = "electronics_vhs_tapes_03";
  level.scr_anim["sse33"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs13;
  level.scr_animtree["sse34"] = #animtree;
  level.scr_model["sse34"] = "electronics_vhs_tapes_03";
  level.scr_anim["sse34"]["2f_cleanup"] = % zd30c_2f_070_scenea_vhs14;
  level.scr_animtree["sse35"] = #animtree;
  level.scr_model["sse35"] = "device_laptop_01_closed";
  level.scr_anim["sse35"]["2f_cleanup"] = % zd30c_2f_070_scenea_laptop01;
  level.scr_animtree["sse36"] = #animtree;
  level.scr_model["sse36"] = "me_hardware_harddrive_01";
  level.scr_anim["sse36"]["2f_cleanup"] = % zd30c_2f_070_scenea_harddrive01;
  level.scr_animtree["sse37"] = #animtree;
  level.scr_model["sse37"] = "me_hardware_harddrive_01";
  level.scr_anim["sse37"]["2f_cleanup"] = % zd30c_2f_070_scenea_harddrive02;
  level.scr_animtree["sse38"] = #animtree;
  level.scr_model["sse38"] = "me_hardware_harddrive_01";
  level.scr_anim["sse38"]["2f_cleanup"] = % zd30c_2f_070_scenea_harddrive03;
  level.scr_animtree["sse39"] = #animtree;
  level.scr_model["sse39"] = "me_hardware_harddrive_01";
  level.scr_anim["sse39"]["2f_cleanup"] = % zd30c_2f_070_scenea_harddrive04;
  level.scr_animtree["sse40"] = #animtree;
  level.scr_model["sse40"] = "me_hardware_harddrive_01";
  level.scr_anim["sse40"]["2f_cleanup"] = % zd30c_2f_070_scenea_harddrive05;
  level.scr_animtree["sse41"] = #animtree;
  level.scr_model["sse41"] = "me_hardware_harddrive_01";
  level.scr_anim["sse41"]["2f_cleanup"] = % zd30c_2f_070_scenea_harddrive06;
  level.scr_animtree["sse0"] = #animtree;
  level.scr_model["sse0"] = "me_hardware_harddrive_01";
  level.scr_anim["sse0"]["2f_cleanup"] = % zd30c_2f_070_scenea_harddrive07;
  level.scr_animtree["farah_glowstick"] = #animtree;
  level.scr_model["farah_glowstick"] = "weapon_zd30_glowstick_wm";
  level.scr_anim["farah_glowstick"]["use"] = % zd30t_basement_intro_enter_glowstick;
  level.scr_animtree["reveal_rope"] = #animtree;
  level.scr_model["reveal_rope"] = "misc_rapelling_rope_sim";
  level.scr_anim["reveal_rope"]["landing"] = % zd30c_090_tunnel_courtyard_ally03_rope;
  level.scr_anim["reveal_rope"]["landing_idle"][0] = % zd30c_090_tunnel_courtyard_ally03_idle_rope;
  level.scr_anim["reveal_rope"]["entrance"] = % zd30c_090_tunnel_entrance_ally03_rope;
  level.scr_animtree["tunnel_door"] = #animtree;
  level.scr_anim["tunnel_door"]["entrance"] = % zd30c_090_tunnel_entrance_door;
  level.scr_goaltime["tunnel_door"]["entrance"] = 0.4;
  level.scr_animtree["rock"] = #animtree;
  level.scr_model["rock"] = "ee_manmade_tunnel_wall_rock_a";
  level.scr_anim["rock"]["entrance"] = % zd30c_090_tunnel_entrance_rock;
  level.scr_animtree["mine_push_barrel"] = #animtree;
  level.scr_model["mine_push_barrel"] = "oil_drum_big_01_blue";
  level.scr_anim["mine_push_barrel"]["mine_oilpush"] = % zd30t_mine_oil_spill_barrel;
  level.scr_anim["mine_push_barrel"]["storage_oilpush"] = % zd30t_mine_oil_spill_barrel;
  level.scr_animtree["mine_cart"] = #animtree;
  level.scr_model["mine_cart"] = "machinery_mining_orecart_01";
  level.scr_anim["mine_cart"]["pushable_cart_shaft"] = % zd30t_mine_cart_push_shaft;
  level.scr_animtree["mine_cart_tutorial"] = #animtree;
  level.scr_model["mine_cart_tutorial"] = "machinery_mining_orecart_01";
  level.scr_anim["mine_cart_tutorial"]["pushable_cart_tutorial"] = % zd30t_mine_cart_push_mine;
  level.scr_animtree["ladder_propane"] = #animtree;
  level.scr_model["ladder_propane"] = "decor_propane_tank_01_en";
  level.scr_anim["ladder_propane"]["ladder_explode"] = % zd30t_basement_ladder_explode_propane;
  level.scr_animtree["shaft_ladder"] = #animtree;
  level.scr_model["shaft_ladder"] = "ee_manmade_mine_ladder_a";
  level.scr_anim["shaft_ladder"]["shaft_ladder_intro"] = % zd30t_shaft_ladder_fall_intro_ladder;
  level.scr_animtree["shaft_propane_kick"] = #animtree;
  level.scr_model["shaft_propane_kick"] = "decor_propane_tank_01_en_d1";
  level.scr_anim["shaft_propane_kick"]["propane_kick"] = % zd30t_shaft_propane_kick_tank;
  level.scr_animtree["shaft_propane_toss"] = #animtree;
  level.scr_model["shaft_propane_toss"] = "decor_propane_tank_01_en_d1";
  level.scr_anim["shaft_propane_toss"]["propane_toss"] = % zd30t_shaft_propane_throw_tank;
}

model_swap_gate(var_0) {
  var_0 setModel("me_doors_zd30_gate_01_dmg_lod0");

  if(isDefined(var_0.animname) && var_0.animname == "gate_l")
    var_0 playSound("scn_zd30_gate_breach_left");
  else
    var_0 playSound("scn_zd30_gate_breach_right");
}

#using_animtree("scriptables");

scriptables() {
  level.scr_animtree["basement_collapse_sag_beam"] = #animtree;
  level.scr_anim["basement_collapse_sag_beam"] = % building_support_wood_beam_04_re_size_sag_anim;
}

#using_animtree("vehicles");

vehicles() {
  level.scr_animtree["heli_alpha"] = #animtree;
  level.scr_anim["heli_alpha"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_heli01;
  level.scr_goaltime["heli_alpha"]["heli_pre_intro"] = 0;
  level.scr_anim["heli_alpha"]["heli_intro"] = % zd30c_000_infil_lbirds_heli01;
  level.scr_goaltime["heli_alpha"]["heli_intro"] = 1.5;
  level.scr_animtree["heli_bravo"] = #animtree;
  level.scr_anim["heli_bravo"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_heli02;
  level.scr_goaltime["heli_bravo"]["heli_pre_intro"] = 0;
  level.scr_anim["heli_bravo"]["heli_intro"] = % zd30c_000_infil_lbirds_heli02;
  level.scr_goaltime["heli_bravo"]["heli_intro"] = 1.5;
  level.scr_animtree["heli_charlie"] = #animtree;
  level.scr_model["heli_charlie"] = "veh8_mil_air_lbravo";
  level.scr_anim["heli_charlie"]["heli_pre_intro"] = % zd30c_000_3p_infil_lbirds_heli03;
  level.scr_goaltime["heli_charlie"]["heli_pre_intro"] = 0;
  level.scr_anim["heli_charlie"]["heli_intro"] = % zd30c_000_infil_lbirds_heli03;
  level.scr_goaltime["heli_charlie"]["heli_intro"] = 1.5;
  level.scr_animtree["heli_charlie_end"] = #animtree;
  level.scr_anim["heli_charlie_end"]["landing"] = % zd30c_090_tunnel_courtyard_lbravo;
}