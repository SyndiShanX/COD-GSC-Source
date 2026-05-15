/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\roadkill_anim.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#using_animtree("generic_human");
main() {
  bridge_layer();
  roadkill_dialogue();
  roadkill_player_anims();
  script_model_animations();

  maps\_minigun_viewmodel::anim_minigun_hands();

  level.scr_anim["shepherd"]["player_shep_intro"] = % roadkill_intro_pickup_shepherd;
  addNotetrack_dialogue("shepherd", "dialog", "player_shep_intro", "roadkill_shp_ontheline");

  level.scr_anim["hargrove"]["roadkill_intro_orders"] = % roadkill_orders_officer;
  level.scr_anim["foley"]["roadkill_intro_orders"] = % roadkill_orders_soldier;

  level.scr_anim["hargrove"]["walk"] = % civilian_walk_hurried_1;
  level.scr_anim["foley"]["walk"] = % civilian_walk_hurried_1;
  addNotetrack_flag("foley", "slam", "slam_hood");

  level.scr_anim["shepherd"]["roadkill_cover_active_leader"] = % roadkill_cover_active_leader;
  level.scr_anim["shepherd"]["shepherd_cover"][0] = % roadkill_cover_active_leader_idle;
  addNotetrack_customFunction("shepherd", "lookat on", ::enable_lookat);
  addNotetrack_customFunction("shepherd", "lookat off", ::disable_lookat);
  addNotetrack_dialogue("shepherd", "dialog", "roadkill_cover_active_leader", "roadkill_shp_ontheline");

  level.scr_anim["shepherd"]["roadkill_riverbank_intro"] = % roadkill_opening_shepherd;
  level.scr_anim["shepherd"]["intro_idle"][0] = % roadkill_opening_shepherd_idle;
  addNotetrack_dialogue("shepherd", "roadkill_shp_dontcare_ps", "roadkill_riverbank_intro", "roadkill_shp_dontcare");

  level.scr_anim["foley"]["roadkill_riverbank_intro"] = % roadkill_opening_foley;
  level.scr_anim["foley"]["intro_idle"][0] = % roadkill_opening_foley_idle;

  addNotetrack_customFunction("foley", "m203", ::foley_m203, "roadkill_riverbank_intro");

  level.scr_anim["shepherd"]["ending"] = % roadkill_ending;
  level.scr_anim["shepherd"]["walk"] = % roadkill_opening_shepherd_walk;

  level.scr_anim["shepherd"]["idle_reach"] = % laptop_officer_idle;
  level.scr_anim["shepherd"]["idle"][0] = % laptop_officer_idle;

  level.scr_anim["shepherd"]["stair_approach"] = % roadkill_shepherd_stair_approach;
  level.scr_anim["shepherd"]["stair_idle"][0] = % roadkill_shepherd_stair_idle;
  level.scr_anim["shepherd"]["stair_wave"] = % roadkill_shepherd_stair_wave;

  level.scr_anim["shepherd"]["angry_walk"] = % roadkill_shepherd_walk;
  level.scr_anim["shepherd"]["angry_wander"] = % roadkill_shepherd_shout_sequence;

  addNotetrack_dialogue("shepherd", "roadkill_shp_goodwork_ps", "ending", "roadkill_shp_goodwork");

  addNotetrack_dialogue("shepherd", "roadkill_shp_specialop_ps", "ending", "roadkill_shp_specialop");

  addNotetrack_customFunction("shepherd", "point_end", ::point_end, "ending");

  level.scr_anim["spotter"]["idle"][0] = % roadkill_cover_spotter_idle;
  level.scr_anim["soldier"]["idle"][0] = % roadkill_cover_soldier_idle;

  level.scr_anim["spotter"]["binoc_scene"] = % roadkill_cover_spotter;
  level.scr_anim["soldier"]["binoc_scene"] = % roadkill_cover_soldier;
  addNotetrack_customFunction("spotter", "detach binoc", ::detach_binoc, "binoc_scene");
  addNotetrack_customFunction("spotter", "attach binoc", ::attach_binoc, "binoc_scene");

  level.scr_anim["cover_attack1"]["idle"][0] = % roadkill_cover_active_soldier1;
  level.scr_anim["cover_attack2"]["idle"][0] = % roadkill_cover_active_soldier2;
  level.scr_anim["cover_attack3"]["idle"][0] = % roadkill_cover_active_soldier3;
  level.scr_anim["cover_radio1"]["idle"][0] = % roadkill_cover_radio_soldier1;
  level.scr_anim["cover_radio2"]["idle"][0] = % roadkill_cover_radio_soldier2;
  level.scr_anim["cover_radio3"]["idle"][0] = % roadkill_cover_radio_soldier3;
  level.scr_anim["cover_radio1"]["idle_noshoot"][0] = % roadkill_cover_radio_soldier1_idle;

  level.scr_anim["film1"]["video_film_start"] = % roadkill_videotaper_1B_explosion_start;
  level.scr_anim["film1"]["video_film_idle"][0] = % roadkill_videotaper_1B_explosion_idle;
  level.scr_anim["film1"]["video_film_react"] = % roadkill_videotaper_1B_explosion;

  level.scr_anim["film2"]["video_film_start"] = % roadkill_videotaper_2B_explosion_start;
  level.scr_anim["film2"]["video_film_idle"][0] = % roadkill_videotaper_2B_explosion_idle;
  level.scr_anim["film2"]["video_film_react"] = % roadkill_videotaper_2B_explosion;
  level.scr_anim["film2"]["video_film_end"] = % roadkill_videotaper_2B_explosionend;

  level.scr_anim["film3"]["video_film_start"] = % roadkill_videotaper_3B_explosion_start;
  level.scr_anim["film3"]["video_film_idle"][0] = % roadkill_videotaper_3B_explosion_idle;
  level.scr_anim["film3"]["video_film_react"] = % roadkill_videotaper_3B_explosion;
  level.scr_anim["film3"]["video_film_end"] = % roadkill_videotaper_3B_explosionend;

  level.scr_anim["film4"]["video_film_start"] = % roadkill_videotaper_4B_explosion_start;
  level.scr_anim["film4"]["video_film_idle"][0] = % roadkill_videotaper_4B_explosion_idle;
  level.scr_anim["film4"]["video_film_react"] = % roadkill_videotaper_4B_explosion;

  level.scr_anim["generic"]["balcony_death"] = [];
  level.scr_anim["generic"]["balcony_death"][0] = % bog_b_rpg_fall_death;
  level.scr_anim["generic"]["balcony_death"][1] = % death_rooftop_A;
  level.scr_anim["generic"]["balcony_death"][2] = % death_rooftop_B;
  level.scr_anim["generic"]["balcony_death"][3] = % death_rooftop_D;

  level.scr_model["film1"] = "electronics_camera_pointandshoot_low";
  level.scr_model["film2"] = "electronics_camera_cellphone_low";
  level.scr_model["film3"] = "electronics_camera_cellphone_low";
  level.scr_model["film4"] = "electronics_camera_cellphone_low";

  level.scr_anim["shepherd"]["ending_additive_right"] = % roadkill_ending_point_left45;
  level.scr_anim["shepherd"]["ending_additive_left"] = % roadkill_ending_point_right45;
  level.scr_anim["shepherd"]["ending_additive_controller"] = % roadkill_ending_additive;

  level.scr_anim["exposed_flashbang_v1"]["flashed"] = % exposed_flashbang_v1;
  level.scr_anim["exposed_flashbang_v2"]["flashed"] = % exposed_flashbang_v2;
  level.scr_anim["exposed_flashbang_v3"]["flashed"] = % exposed_flashbang_v3;
  level.scr_anim["exposed_flashbang_v4"]["flashed"] = % exposed_flashbang_v4;
  level.scr_anim["exposed_flashbang_v5"]["flashed"] = % exposed_flashbang_v5;

  level.scr_anim["generic"]["pistol_walk_back"] = % pistol_walk_back;
  level.scr_anim["generic"]["pistol_death"] = % airport_security_guard_pillar_death_r;
  level.scr_anim["generic"]["exposed_reload"] = % exposed_reloadb;

  level.scr_anim["generic"]["cqb_wave"] = % CQB_stand_signal_move_out;

  level.scr_anim["sit_1"]["sit_around"][0] = % sitting_guard_loadAK_idle;
  level.scr_anim["sit_2"]["sit_around"][0] = % civilian_texting_sitting;
  level.scr_anim["sit_3"]["sit_around"][0] = % civilian_sitting_talking_A_1;

  level.scr_model["sit_2"] = "electronics_pda";

  level.scr_anim["generic"]["rooftop_turn"] = % stand_2_run_180L;

  level.scr_anim["generic"]["walk"] = % patrol_bored_patrolwalk;

  level.scr_anim["street_runner"]["scene"] = % airport_civ_pillar_exit;
  level.scr_anim["roof_backup"]["scene"] = % airport_civ_fear_drop_6;

  level.scr_anim["generic"]["help_player_getin"] = % roadkill_hummer_soldier_getin;

  level.scr_anim["generic"]["combat_walk"] = % combatwalk_f_spin;

  level.scr_anim["generic"]["garage_spawner"] = % unarmed_close_garage;
  level.scr_anim["generic"]["garage_spawner_right"] = % unarmed_runinto_garage_right;
  level.scr_anim["generic"]["garage_spawner_left"] = % unarmed_runinto_garage_left;
  level.scr_anim["generic"]["garage_spawner_left_run"] = % unarmed_scared_run_delta;

  level.scr_anim["generic"]["garage_window_shouter_spawner"][0] = % unarmed_shout_window;

  level.scr_anim["generic"]["garage_spawner_right"] = % unarmed_runinto_garage_right;

  level.scr_anim["flee_alley"]["round_corner"] = % flee_alley_civilain;
  level.scr_anim["flee_alley"]["idle"][0] = % flee_alley_civilain_idle;
  level.scr_anim["flee_alley"]["idle_location"] = % flee_alley_civilain_idle;

  level.scr_anim["flee_alley"]["hands_up"] = % unarmed_cowercrouch_react_A;

  level.scr_anim["generic"]["unarmed_climb_wall"] = % unarmed_climb_wall;
  level.scr_anim["generic"]["unarmed_climb_wall_v2"] = % unarmed_climb_wall_v2;
  level.scr_anim["generic"]["facedown_death"] = % run_death_facedown;

  level.scr_anim["flee_alley"]["flee_shooting"] = % flee_stand_2_run_med;

  level.scr_anim["generic"]["killhouse_gaz_idleA"][0] = % killhouse_gaz_idleA;
  level.scr_anim["generic"]["killhouse_gaz_talk_side"][0] = % killhouse_gaz_talk_side;
  level.scr_anim["generic"]["killhouse_gaz_idleB"][0] = % killhouse_gaz_idleB;
  level.scr_anim["generic"]["killhouse_sas_price_idle"][0] = % killhouse_sas_price_idle;

  level.scr_anim["generic"]["killhouse_gaz_idleA_solo"] = % killhouse_gaz_idleA;
  level.scr_anim["generic"]["killhouse_gaz_talk_side_solo"] = % killhouse_gaz_talk_side;
  level.scr_anim["generic"]["killhouse_gaz_idleB_solo"] = % killhouse_gaz_idleB;
  level.scr_anim["generic"]["killhouse_sas_price_idle_solo"] = % killhouse_sas_price_idle;

  level.scr_anim["generic"]["humvee_turret_bounce"] = % humvee_turret_bounce;
  level.scr_anim["generic"]["humvee_turret_idle_lookback"] = % humvee_turret_idle_lookback;
  level.scr_anim["generic"]["humvee_turret_idle_lookbackB"] = % humvee_turret_idle_lookbackB;
  level.scr_anim["generic"]["humvee_turret_idle_signal_forward"] = % humvee_turret_idle_signal_forward;
  level.scr_anim["generic"]["humvee_turret_idle_signal_side"] = % humvee_turret_idle_signal_side;
  level.scr_anim["generic"]["humvee_turret_radio"] = % humvee_turret_radio;
  level.scr_anim["generic"]["humvee_turret_flinchA"] = % humvee_turret_flinchA;
  level.scr_anim["generic"]["humvee_turret_flinchB"] = % humvee_turret_flinchB;
  level.scr_anim["generic"]["humvee_turret_rechamber"] = % humvee_turret_rechamber;
}

enable_lookat(guy) {}

disable_lookat(guy) {}

detach_binoc(guy) {
  if(!isDefined(guy.binoc)) {
    return;
  }
  guy Detach("weapon_binocular", "tag_inhand");
  guy.binoc = undefined;
}

attach_binoc(guy) {
  if(isDefined(guy.binoc)) {
    return;
  }
  guy Attach("weapon_binocular", "tag_inhand");
  guy.binoc = true;
}

foley_whistle(foley) {
  foley thread play_sound_on_entity("roadkill_whistle");
  wait(0.9);
  flag_set("bridgelayer_starts");
}

point_start(shepherd) {
  shepherd.pointing = true;

  shepherd shepherd_points_at_player();
}

shepherd_points_at_player() {
  self endon("point_end");
  controller = self getanim("ending_additive_controller");
  left_anim = self getanim("ending_additive_left");
  right_anim = self getanim("ending_additive_right");
  range = 45;

  for(;;) {
    animation = self getanim("ending");

    right = AnglesToRight(self.angles);
    othervec = VectorNormalize(level.player.origin - self.origin);

    forward = anglesToForward(self.angles);
    right = AnglesToRight(self.angles);

    forward_dot = VectorDot(forward, othervec);
    right_dot = VectorDot(right, othervec);

    degrees = ACos(forward_dot);

    degrees = abs(degrees);

    weight = 0;
    if(right_dot > 0) {
      if(degrees > range) {
        degrees = range;
      }

      weight = degrees / range;
      self SetAnim(left_anim, 0, 0.2, 1);
      self SetAnim(right_anim, 1, 0.2, 1);
    } else {
      degrees += 10;
      if(degrees > range) {
        degrees = range;
      }

      weight = degrees / range;
      self SetAnim(left_anim, 1, 0.2, 1);
      self SetAnim(right_anim, 0, 0.2, 1);
    }

    if(isDefined(self.pointing)) {
      if(abs(weight) >= 1) {
        self SetLookAtEntity(level.player);
      } else {
        self SetLookAtEntity();
      }
    }

    self SetAnim(controller, weight, 0.2, 1);

    wait(0.05);
  }
}

point_end(shepherd) {
  wait 2.9;
  shepherd.pointing = undefined;
  shepherd SetLookAtEntity();

  Shepherd notify("point_end");
  controller = Shepherd getanim("ending_additive_controller");
  Shepherd ClearAnim(controller, 0.2);
}

foley_m203(foley) {
  effect = getfx("m203");

  start = foley GetTagOrigin("tag_flash");
  angles = foley GetTagAngles("tag_flash");

  playFXOnTag(effect, foley, "tag_flash");

  shootpos = (-1734, -1205, 740);
  MagicBullet("m203", start, shootpos);
}

#using_animtree("script_model");
script_model_animations() {
  level.scr_animtree["gun_model"] = #animtree;
  level.scr_model["gun_model"] = "weapon_colt_anaconda_animated";
  level.scr_anim["gun_model"]["player_shep_intro"] = % roadkill_intro_pickup_gun;
}

#using_animtree("player");
roadkill_player_anims() {
  level.scr_anim["player_rig"]["player_getin"] = % roadkill_hummer_player_getin;

  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_player_us_army";

  level.scr_anim["player_rig"]["player_shep_intro"] = % roadkill_intro_pickup_player;
}

#using_animtree("vehicles");
bridge_layer() {
  level.scr_anim["bridge_layer_bridge"]["bridge_lower"] = % roadkill_M60A1_bridge_lower;
  level.scr_anim["bridge_layer_bridge"]["bridge_driveup"] = % roadkill_M60A1_bridge_driveup;

  level.scr_anim["bridge_layer"]["bridge_lower"] = % roadkill_M60A1_tank_lower;
  level.scr_anim["bridge_layer"]["bridge_driveup"] = % roadkill_M60A1_tank_driveup;
  level.scr_anim["bridge_layer"]["bridge_cross"] = % roadkill_M60A1_tank_cross;
  level.scr_anim["bridge_layer"]["bridge_arm_lower"] = % roadkill_M60A1_arm_lower;

  level.scr_animtree["bridge_layer_bridge"] = #animtree;
  level.scr_animtree["bridge_layer"] = #animtree;

  level.scr_animtree["player_humvee"] = #animtree;
  level.scr_anim["player_humvee"]["roadkill_intro_orders"] = % roadkill_orders_hummer;

  level.scr_anim["player_humvee"]["roadkill_player_door_open"] = % roadkill_hummer_door_soldier;

  level.scr_anim["turret"]["player_getin"] = % roadkill_hummer_gun_getin;
  level.scr_animtree["turret"] = #animtree;

  level.scr_anim["technical"]["technical_pushed"] = % roadkill_pickup_technical_pushed;
  level.scr_animtree["technical"] = #animtree;
}

intro_explosion(foley) {
  exploder("intro_boom");
}

#using_animtree("generic_human");
roadkill_dialogue() {
  level.scr_sound["generic"]["roadkill_fly_yourM203"] = "roadkill_fly_yourM203";

  level.scr_sound["generic"]["roadkill_fly_acrossriver"] = "roadkill_fly_acrossriver";

  level.scr_sound["generic"]["roadkill_fly_10oclockhigh"] = "roadkill_fly_10oclockhigh";

  level.scr_sound["generic"]["roadkill_fly_onthebridge"] = "roadkill_fly_onthebridge";

  level.scr_sound["generic"]["roadkill_shp_dontcare"] = "roadkill_shp_dontcare";

  level.scr_sound["generic"]["roadkill_fly_yessir"] = "roadkill_fly_yessir";

  level.scr_sound["generic"]["roadkill_fly_wereswimming"] = "roadkill_fly_wereswimming";

  level.scr_sound["generic"]["roadkill_fly_makingapush"] = "roadkill_fly_makingapush";

  level.scr_sound["generic"]["roadkill_fly_keephitting"] = "roadkill_fly_keephitting";

  level.scr_sound["generic"]["roadkill_fly_bridgecomplete"] = "roadkill_fly_bridgecomplete";
  level.scr_face["generic"]["roadkill_fly_bridgecomplete"] = % roadkill_fly_bridgecomplete;

  level.scr_sound["generic"]["roadkill_cpd_airstrike"] = "roadkill_cpd_airstrike";

  level.scr_radio["roadkill_auc_ontheline"] = "roadkill_auc_ontheline";

  level.scr_radio["roadkill_fp1_devil11"] = "roadkill_fp1_devil11";

  level.scr_sound["generic"]["roadkill_cpd_checkin"] = "roadkill_cpd_checkin";

  level.scr_radio["roadkill_fp1_standingby"] = "roadkill_fp1_standingby";

  level.scr_sound["generic"]["roadkill_cpd_levelbuilding"] = "roadkill_cpd_levelbuilding";

  level.scr_radio["roadkill_fp1_targetacquired"] = "roadkill_fp1_targetacquired";

  level.scr_sound["generic"]["roadkill_cpd_clearedhot"] = "roadkill_cpd_clearedhot";

  level.scr_radio["roadkill_fp1_offsafe"] = "roadkill_fp1_offsafe";

  level.scr_sound["generic"]["roadkill_ar3_holup"] = "roadkill_ar3_holup";

  level.scr_sound["generic"]["roadkill_cpd_majorfiremission"] = "roadkill_cpd_majorfiremission";

  level.scr_sound["generic"]["roadkill_ar3_dangerclose"] = "roadkill_ar3_dangerclose";

  level.scr_sound["generic"]["roadkill_cpd_sincewhen"] = "roadkill_cpd_sincewhen";

  level.scr_sound["generic"]["roadkill_cpd_getsome"] = "roadkill_cpd_getsome";

  level.scr_sound["generic"]["roadkill_ar1_yeah"] = "roadkill_ar1_yeah";

  level.scr_sound["generic"]["roadkill_ar2_wooyeah"] = "roadkill_ar2_wooyeah";

  level.scr_sound["generic"]["roadkill_ar1_huahyeah"] = "roadkill_ar1_huahyeah";

  level.scr_sound["generic"]["roadkill_cpd_paybig"] = "roadkill_cpd_paybig";

  level.scr_sound["generic"]["roadkill_ar2_keepdreamin"] = "roadkill_ar2_keepdreamin";

  level.scr_sound["generic"]["roadkill_cpd_extreme"] = "roadkill_cpd_extreme";

  level.scr_sound["generic"]["roadkill_ar1_whoa"] = "roadkill_ar1_whoa";

  level.scr_sound["generic"]["roadkill_ar2_yeahcough"] = "roadkill_ar2_yeahcough";

  level.scr_sound["generic"]["roadkill_gar_cough1"] = "roadkill_gar_cough1";
  level.scr_sound["generic"]["roadkill_gar_cough2"] = "roadkill_gar_cough2";
  level.scr_sound["generic"]["roadkill_gar_cough3"] = "roadkill_gar_cough3";
  level.scr_sound["generic"]["roadkill_gar_cough4"] = "roadkill_gar_cough4";
  level.scr_sound["generic"]["roadkill_gar_cough5"] = "roadkill_gar_cough5";
  level.scr_sound["generic"]["roadkill_gar_cough6"] = "roadkill_gar_cough6";

  level.scr_sound["generic"]["roadkill_cpd_movinout"] = "roadkill_cpd_movinout";

  level.scr_sound["generic"]["roadkill_ar2_huah"] = "roadkill_ar2_huah";

  level.scr_sound["generic"]["roadkill_ar3_backinvehicle"] = "roadkill_ar3_backinvehicle";

  level.scr_sound["generic"]["roadkill_ar4_oscarmike"] = "roadkill_ar4_oscarmike";

  level.scr_sound["generic"]["roadkill_fly_oscarmike"] = "roadkill_fly_oscarmike";

  level.scr_sound["generic"]["roadkill_ar2_oscarmike"] = "roadkill_ar2_oscarmike";

  level.scr_sound["generic"]["roadkill_cpd_notstoppin"] = "roadkill_cpd_notstoppin";

  level.scr_sound["generic"]["roadkill_fly_movingout"] = "roadkill_fly_movingout";

  level.scr_sound["generic"]["roadkill_fly_mountup"] = "roadkill_fly_mountup";

  level.scr_sound["generic"]["roadkill_fly_comeongetin"] = "roadkill_fly_comeongetin";

  level.scr_sound["generic"]["roadkill_fly_holdingupline"] = "roadkill_fly_holdingupline";

  level.scr_sound["generic"]["roadkill_fly_hurryup"] = "roadkill_fly_hurryup";

  level.scr_sound["generic"]["roadkill_fly_moveletsgo"] = "roadkill_fly_moveletsgo";

  level.scr_sound["generic"]["roadkill_fly_breakingaway"] = "roadkill_fly_breakingaway";

  level.scr_radio["roadkill_hqr_copyhunter2"] = "roadkill_hqr_copyhunter2";

  level.scr_sound["generic"]["roadkill_fly_scanrooftops"] = "roadkill_fly_scanrooftops";

  level.scr_sound["generic"]["roadkill_fly_lastlonger"] = "roadkill_fly_lastlonger";

  level.scr_sound["generic"]["roadkill_fly_eyeoutforciv"] = "roadkill_fly_eyeoutforciv";

  level.scr_sound["generic"]["roadkill_fly_holdoff"] = "roadkill_fly_holdoff";

  level.scr_sound["generic"]["roadkill_cpd_scoutingus"] = "roadkill_cpd_scoutingus";

  level.scr_sound["generic"]["roadkill_fly_doesntmean"] = "roadkill_fly_doesntmean";

  level.scr_sound["generic"]["roadkill_fly_nothingthere"] = "roadkill_fly_nothingthere";

  level.scr_sound["generic"]["roadkill_fly_standdown"] = "roadkill_fly_standdown";

  level.scr_sound["generic"]["roadkill_fly_ceasefire"] = "roadkill_fly_ceasefire";

  level.scr_sound["generic"]["roadkill_fly_watchsector"] = "roadkill_fly_watchsector";

  level.scr_sound["generic"]["roadkill_cpd_seeanything"] = "roadkill_cpd_seeanything";

  level.scr_sound["generic"]["roadkill_fly_stayfrosty"] = "roadkill_fly_stayfrosty";

  level.scr_sound["generic"]["roadkill_fly_eyesforward"] = "roadkill_fly_eyesforward";

  level.scr_sound["generic"]["roadkill_fly_watchalleys"] = "roadkill_fly_watchalleys";

  level.scr_sound["generic"]["roadkill_cpd_contact12"] = "roadkill_cpd_contact12";

  level.scr_sound["generic"]["roadkill_fly_sittingducks"] = "roadkill_fly_sittingducks";

  level.scr_sound["generic"]["roadkill_fly_strungout"] = "roadkill_fly_strungout";

  level.scr_sound["generic"]["roadkill_cpd_keepmoving"] = "roadkill_cpd_keepmoving";

  level.scr_radio["roadkill_ar2_shotup"] = "roadkill_ar2_shotup";

  level.scr_sound["generic"]["roadkill_fly_hangtight"] = "roadkill_fly_hangtight";

  level.scr_radio["roadkill_ar2_solidcopy"] = "roadkill_ar2_solidcopy";

  level.scr_sound["generic"]["roadkill_cpd_cutoff"] = "roadkill_cpd_cutoff";

  level.scr_sound["generic"]["roadkill_fly_pushthrough"] = "roadkill_fly_pushthrough";

  level.scr_sound["generic"]["roadkill_fly_headsup"] = "roadkill_fly_rpgtopfloor";

  level.scr_sound["generic"]["roadkill_fly_getoffstreet"] = "roadkill_fly_getoffstreet";

  level.scr_sound["generic"]["roadkill_fly_followme"] = "roadkill_fly_followme";

  level.scr_sound["generic"]["roadkill_fly_everybodyok"] = "roadkill_fly_everybodyok";

  level.scr_sound["generic"]["roadkill_cpd_huah"] = "roadkill_cpd_huah";

  level.scr_sound["generic"]["roadkill_ar1_huah"] = "roadkill_ar1_huah";

  level.scr_sound["generic"]["roadkill_ar2_huah2"] = "roadkill_ar2_huah2";

  level.scr_sound["generic"]["roadkill_cpd_movinaroundup"] = "roadkill_cpd_movinaroundup";

  level.scr_sound["generic"]["roadkill_fly_securetopfloor"] = "roadkill_fly_securetopfloor";

  level.scr_sound["generic"]["roadkill_fly_eyesonschool"] = "roadkill_fly_eyesonschool";

  level.scr_radio["roadkill_ar3_ineffective"] = "roadkill_ar3_ineffective";

  level.scr_sound["generic"]["roadkill_fly_keepittogether"] = "roadkill_fly_keepittogether";

  level.scr_sound["generic"]["roadkill_fly_intheschool"] = "roadkill_fly_intheschool";

  level.scr_sound["generic"]["roadkill_shp_copythat21"] = "roadkill_shp_copythat21";

  level.scr_sound["generic"]["roadkill_cpd_historyclass"] = "roadkill_cpd_historyclass";

  level.scr_sound["generic"]["roadkill_fly_rogerthat"] = "roadkill_fly_rogerthat";

  level.scr_sound["generic"]["roadkill_fly_sawone"] = "roadkill_fly_sawone";

  level.scr_sound["generic"]["roadkill_fly_moreresistance"] = "roadkill_fly_moreresistance";

  level.scr_sound["generic"]["roadkill_cpd_frontofschool"] = "roadkill_cpd_frontofschool";

  level.scr_sound["generic"]["roadkill_cpd_classonright"] = "roadkill_cpd_classonright";

  level.scr_sound["generic"]["roadkill_shp_thanksforassist"] = "roadkill_shp_thanksforassist";

  level.scr_sound["generic"]["roadkill_fly_allthewaysir"] = "roadkill_fly_allthewaysir";

  level.scr_sound["generic"]["roadkill_shp_alltheway"] = "roadkill_shp_alltheway";

  level.scr_sound["generic"]["roadkill_fly_pressureoff"] = "roadkill_fly_pressureoff";

  level.scr_radio["roadkill_shp_thanksforassist"] = "roadkill_shp_thanksforassist";

  level.scr_sound["generic"]["roadkill_fly_allthewaysir"] = "roadkill_fly_allthewaysir";

  level.scr_radio["roadkill_shp_alltheway"] = "roadkill_shp_alltheway";

  level.scr_sound["generic"]["roadkill_fly_togoliath"] = "roadkill_fly_togoliath";

  level.scr_radio["roadkill_ar3_sendtraffic"] = "roadkill_ar3_sendtraffic";

  level.scr_sound["generic"]["roadkill_fly_schoolsecure"] = "roadkill_fly_schoolsecure";

  level.scr_radio["roadkill_ar3_rallypoint"] = "roadkill_ar3_rallypoint";

  level.scr_sound["generic"]["roadkill_fly_thanksfortip"] = "roadkill_fly_thanksfortip";

  level.scr_sound["generic"]["roadkill_fly_watchstragglers"] = "roadkill_fly_watchstragglers";

  level.scr_sound["generic"]["roadkill_fly_lastofem"] = "roadkill_fly_lastofem";

  level.scr_sound["generic"]["roadkill_shp_shocktrauma"] = "roadkill_shp_shocktrauma";

  level.scr_sound["generic"]["roadkill_shp_goodwork"] = "roadkill_shp_goodwork";

  level.scr_sound["generic"]["roadkill_shp_specialop"] = "roadkill_shp_specialop";

  level.scr_sound["generic"]["roadkill_ar1_sparemre"] = "roadkill_ar1_sparemre";

  level.scr_sound["generic"]["roadkill_ar2_oscarmike2"] = "roadkill_ar2_oscarmike2";

  level.scr_sound["generic"]["roadkill_ar3_stowyourgear"] = "roadkill_ar3_stowyourgear";

  level.scr_sound["generic"]["roadkill_ar4_upandrunning"] = "roadkill_ar4_upandrunning";

  level.scr_sound["generic"]["roadkill_shp_ontheline"] = "roadkill_shp_ontheline";

  level.scr_sound["generic"]["roadkill_ar1_whichbuilding"] = "roadkill_ar1_whichbuilding";

  level.scr_sound["generic"]["roadkill_ar2_tallone"] = "roadkill_ar2_tallone";

  level.scr_sound["generic"]["roadkill_ar3_heydawg"] = "roadkill_ar3_heydawg";

  level.scr_sound["generic"]["roadkill_ar4_whichone"] = "roadkill_ar4_whichone";

  level.scr_sound["generic"]["roadkill_ar5_oneonleft"] = "roadkill_ar5_oneonleft";

  level.scr_sound["generic"]["roadkill_ar1_howlong"] = "roadkill_ar1_howlong";

  level.scr_sound["generic"]["roadkill_ar2_runsout"] = "roadkill_ar2_runsout";

  level.scr_sound["generic"]["roadkill_ar1_10seconds"] = "roadkill_ar1_10seconds";

  level.scr_sound["generic"]["roadkill_ar2_10seconds"] = "roadkill_ar2_10seconds";

  level.scr_sound["generic"]["roadkill_ar3_10seconds"] = "roadkill_ar3_10seconds";

  level.scr_sound["generic"]["roadkill_ar4_goinon"] = "roadkill_ar4_goinon";

  level.scr_sound["generic"]["roadkill_ar5_majorfire"] = "roadkill_ar5_majorfire";

  level.scr_sound["generic"]["roadkill_ar4_memoryleft"] = "roadkill_ar4_memoryleft";

  level.scr_sound["generic"]["roadkill_ar5_shouldbegood"] = "roadkill_ar5_shouldbegood";

  level.scr_sound["generic"]["roadkill_ar3_dangerclose"] = "roadkill_ar3_dangerclose";

  level.scr_sound["generic"]["roadkill_cpd_sincewhen"] = "roadkill_cpd_sincewhen";

  level.scr_sound["generic"]["roadkill_ar1_boom"] = "roadkill_ar1_boom";

  level.scr_sound["generic"]["roadkill_ar2_yeah"] = "roadkill_ar2_yeah";

  level.scr_sound["generic"]["roadkill_ar3_woo"] = "roadkill_ar3_woo";

  level.scr_sound["generic"]["roadkill_ar4_yeah"] = "roadkill_ar4_yeah";

  level.scr_sound["generic"]["roadkill_ar5_hotman"] = "roadkill_ar5_hotman";

  level.scr_sound["generic"]["roadkill_ar1_4thofjuly"] = "roadkill_ar1_4thofjuly";

  level.scr_sound["generic"]["roadkill_ar1_catcalls"] = "roadkill_ar1_catcalls";

  level.scr_sound["generic"]["roadkill_ar2_catcalls"] = "roadkill_ar2_catcalls";

  level.scr_sound["generic"]["roadkill_ar3_catcalls"] = "roadkill_ar3_catcalls";

  level.scr_sound["generic"]["roadkill_ar1_battalionom"] = "roadkill_ar1_battalionom";

  level.scr_sound["generic"]["roadkill_cpd_oscarmike"] = "roadkill_cpd_oscarmike";

  level.scr_sound["generic"]["roadkill_ar3_onthemove"] = "roadkill_ar3_onthemove";

  level.scr_sound["generic"]["roadkill_ar4_rogerthat"] = "roadkill_ar4_rogerthat";

  level.scr_sound["generic"]["roadkill_fly_breakingaway"] = "roadkill_fly_breakingaway";

  level.scr_sound["generic"]["roadkill_hqr_copyhunter2"] = "roadkill_hqr_copyhunter2";

  level.scr_sound["generic"]["roadkill_fly_eyeoutforciv"] = "roadkill_fly_eyeoutforciv";

  level.scr_sound["generic"]["roadkill_fly_scanrooftops"] = "roadkill_fly_scanrooftops";

  level.scr_sound["generic"]["roadkill_cpd_seeanything"] = "roadkill_cpd_seeanything";

  level.scr_sound["generic"]["roadkill_cpd_placeisdead"] = "roadkill_cpd_placeisdead";

  level.scr_sound["generic"]["roadkill_ar3_huah"] = "roadkill_ar3_huah";

  level.scr_sound["generic"]["roadkill_fly_crossstreeteliz"] = "roadkill_fly_crossstreeteliz";

  level.scr_sound["generic"]["roadkill_hqr_caution"] = "roadkill_hqr_caution";

  level.scr_sound["generic"]["roadkill_cpd_wildwest"] = "roadkill_cpd_wildwest";

  level.scr_sound["generic"]["roadkill_ar3_rogerthat"] = "roadkill_ar3_rogerthat";

  level.scr_sound["generic"]["roadkill_fly_watchalleys"] = "roadkill_fly_watchalleys";

  level.scr_sound["generic"]["roadkill_ar3_covering"] = "roadkill_ar3_covering";

  level.scr_sound["generic"]["roadkill_ar1_probablemilitia"] = "roadkill_ar1_probablemilitia";

  level.scr_sound["generic"]["roadkill_fly_aretheyarmed"] = "roadkill_fly_aretheyarmed";

  level.scr_sound["generic"]["roadkill_ar1_watchingus"] = "roadkill_ar1_watchingus";

  level.scr_sound["generic"]["roadkill_cpd_scoutingus"] = "roadkill_cpd_scoutingus";

  level.scr_sound["generic"]["roadkill_fly_doesntmean"] = "roadkill_fly_doesntmean";

  level.scr_sound["generic"]["roadkill_fly_nothingthere"] = "roadkill_fly_nothingthere";

  level.scr_sound["generic"]["roadkill_fly_ceasefire"] = "roadkill_fly_ceasefire";

  level.scr_sound["generic"]["roadkill_ar2_seeem"] = "roadkill_ar2_seeem";

  level.scr_sound["generic"]["roadkill_cpd_dontseejack"] = "roadkill_cpd_dontseejack";

  level.scr_sound["generic"]["roadkill_fly_prepeng"] = "roadkill_fly_prepeng";

  level.scr_sound["generic"]["roadkill_cpd_goinin"] = "roadkill_cpd_goinin";

  level.scr_sound["generic"]["roadkill_ar1_spinemup"] = "roadkill_ar1_spinemup";

  level.scr_sound["generic"]["roadkill_ar3_12and6"] = "roadkill_ar3_12and6";

  level.scr_sound["generic"]["roadkill_ar4_tonacontacts"] = "roadkill_ar4_tonacontacts";

  level.scr_sound["generic"]["roadkill_cpd_watchmvmnt"] = "roadkill_cpd_watchmvmnt";

  level.scr_sound["generic"]["roadkill_ar5_longrange"] = "roadkill_ar5_longrange";

  level.scr_sound["generic"]["roadkill_ar2_goinforward"] = "roadkill_ar2_goinforward";

  level.scr_sound["generic"]["roadkill_ar1_rightthere"] = "roadkill_ar1_rightthere";

  level.scr_sound["generic"]["roadkill_cpd_shutitoff"] = "roadkill_cpd_shutitoff";

  level.scr_sound["generic"]["roadkill_cpd_lightemup"] = "roadkill_cpd_lightemup";

  level.scr_sound["generic"]["roadkill_cpd_backup"] = "roadkill_cpd_backup";

  level.scr_sound["generic"]["roadkill_cpd_outtahere"] = "roadkill_cpd_outtahere";

  level.scr_sound["generic"]["roadkill_bmr_9_326"] = "roadkill_bmr_9_326";

  level.scr_sound["generic"]["roadkill_bmr_12_115"] = "roadkill_bmr_12_115";

  level.scr_sound["generic"]["roadkill_bmr_3_357"] = "roadkill_bmr_3_357";

  level.scr_sound["generic"]["roadkill_bmr_6_381"] = "roadkill_bmr_6_381";

  level.scr_sound["generic"]["roadkill_bmr_7_110"] = "roadkill_bmr_7_110";

  level.scr_sound["generic"]["roadkill_bmr_11_108"] = "roadkill_bmr_11_108";

  level.scr_sound["generic"]["roadkill_bmr_6_423"] = "roadkill_bmr_6_423";

  level.scr_sound["generic"]["roadkill_bmr_12_86"] = "roadkill_bmr_12_86";

  level.scr_sound["generic"]["roadkill_bmr_9_285"] = "roadkill_bmr_9_285";

  level.scr_sound["generic"]["roadkill_bmr_6_560"] = "roadkill_bmr_6_560";

  level.scr_sound["generic"]["roadkill_bmr_7_252"] = "roadkill_bmr_7_252";

  level.scr_sound["generic"]["roadkill_bmr_9_381"] = "roadkill_bmr_9_381";

  level.scr_sound["generic"]["roadkill_bmr_9_332"] = "roadkill_bmr_9_332";

  level.scr_sound["generic"]["roadkill_bmr_3_277"] = "roadkill_bmr_3_277";

  level.scr_sound["generic"]["roadkill_cpd_clear"] = "roadkill_cpd_clear";

  level.scr_sound["generic"]["roadkill_cpd_2cominout"] = "roadkill_cpd_2cominout";

  level.scr_sound["generic"]["roadkill_cpd_3cominout"] = "roadkill_cpd_3cominout";

  level.scr_sound["generic"]["roadkill_cpd_farside"] = "roadkill_cpd_farside";

  level.scr_sound["generic"]["roadkill_cpd_bridgelayer"] = "roadkill_cpd_bridgelayer";

  level.scr_sound["generic"]["roadkill_cpd_looklook"] = "roadkill_cpd_looklook";

  level.scr_sound["generic"]["roadkill_cpd_hahaitsdown"] = "roadkill_cpd_hahaitsdown";

  level.scr_sound["generic"]["roadkill_AB2_heretheycome"] = "roadkill_AB2_heretheycome";

  level.scr_sound["generic"]["roadkill_AB2_rpgshumvees"] = "roadkill_AB2_rpgshumvees";

  level.scr_sound["generic"]["roadkill_AB2_hassanmove"] = "roadkill_AB2_hassanmove";

  level.scr_sound["generic"]["roadkill_AB2_diedogs"] = "roadkill_AB2_diedogs";

  level.scr_sound["generic"]["roadkill_AB2_movex3"] = "roadkill_AB2_movex3";

  level.scr_sound["generic"]["roadkill_fly_getflashbang"] = "roadkill_fly_getflashbang";
}