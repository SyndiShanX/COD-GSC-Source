/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\piccadilly\piccadilly_gap.gsc
*************************************************/

gap_flags() {
  scripts\engine\utility::flag_init("player_near_stairs");
  scripts\engine\utility::flag_init("price_at_stairs");
  scripts\engine\utility::flag_init("suicide_detonation_active");
  scripts\engine\utility::flag_init("ambush_terries_dead");
  scripts\engine\utility::flag_init("hostage_scene_begin");
  scripts\engine\utility::flag_init("spec_price_intro_start");
  scripts\engine\utility::flag_init("player_near_price");
  scripts\engine\utility::flag_init("price_intro_terry_shot");
  scripts\engine\utility::flag_init("bomb_vest_exploded_early");
  scripts\engine\utility::flag_init("interact_ready");
  scripts\engine\utility::flag_init("hostage_explosion");
  scripts\engine\utility::flag_init("start_end_anims");
  precachemodel("zip_tie_handcuffs_wm");
}

to_balcony_start() {
  setDvar("pic_intro", 0);
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::delete_trigger_with_noteworthy("left_main_trig");
  scripts\engine\utility::flag_set("stop_storefront_drones");
  scripts\engine\utility::flag_set("start_moveup_center");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::spawn_price();
  level.price thread price_clip();
  thread player_speed_management_ending("start_end_anims");
  thread spawn_spec_hostage();
  scripts\engine\sp\utility::set_start_location("spec_post_intro", [level.player]);
}

to_balcony_main() {
  thread scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::lights_off("price_intro");
  thread scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::lights_on("spec_hostage");
  var_0 = scripts\engine\utility::getStruct("spec_price_intro", "targetname");
  level thread vo_hostage_approach();

  if(!scripts\engine\utility::flag("player_near_price")) {
    var_1 = ["dx_vom_pri_move_to_balcony_hostages_10", "dx_vom_pri_move_to_balcony_hostages_20", "dx_vom_pri_move_to_balcony_hostages_30"];
    level.price thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::notetrack_nag(var_1, "player_near_price", "stop_price_nags");
    var_0 thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "price_spec_intro_idle", "stop_price_loop");
    scripts\engine\utility::flag_wait("player_near_price");
    var_0 notify("stop_price_loop");
  }

  visionsetnaked("", 1);
  thread update_hostages_objectives();
  level thread scripts\engine\sp\utility::notify_delay("delete_post_reveal_blocker", 2.3);
  var_0 scripts\common\anim::anim_single_solo(level.price, "price_spec_intro_exit");
  level.price notify("corner_anim_done");
  level notify("stop_price_nags");
  level.price thread start_spec_movement();
  scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::battlechatter_off);
  scripts\engine\sp\utility::autosave_by_name("gap_start");
  thread gap_ai_cleanup();
  scripts\engine\utility::flag_wait_all("player_near_stairs", "price_at_stairs");
  thread scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::lights_off("spec_pre_hostage");
  level.price thread balcony_hostage_anims_price();
  scripts\engine\utility::flag_wait("player_on_stairs");

  if(istrue(level.price.poi_enabled))
    level.price scripts\common\ai::poi_enable(0);
}

player_speed_management_ending(var_0) {
  scripts\sp\player::player_movement_state("cqb");
  var_1 = 45;
  var_2 = 135;
  var_3 = 20;
  var_4 = 200;

  while(!scripts\engine\utility::flag(var_0)) {
    var_5 = distance(level.price.origin, level.player.origin);
    var_6 = scripts\engine\math::normalize_value(var_3, var_4, var_5);
    var_7 = scripts\engine\math::factor_value(var_1, var_2, var_6);
    scripts\engine\sp\utility::player_speed_set(var_7);
    waitframe();
  }

  scripts\sp\player::player_movement_state("cqb");
}

update_hostages_objectives() {
  if(scripts\engine\sp\objectives::objective_exists("piccadilly_objective"))
    scripts\engine\sp\objectives::objective_remove("piccadilly_objective");

  scripts\engine\sp\objectives::objective_add("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_REACH_HOSTAGES", &"PICCADILLY/CURSOR_FOLLOW");
  scripts\engine\sp\objectives::objective_set_on_entity("piccadilly_objective", "Follow", level.price);
  scripts\engine\sp\objectives::objective_set_z_offset("piccadilly_objective", 72);
}

to_balcony_catchup() {
  scripts\engine\utility::flag_set("player_on_stairs");
  var_0 = getEnt("spec_stairs_blocker", "targetname");
  var_0 delete();
}

start_spec_movement() {
  var_0 = scripts\engine\utility::getStruct("end_run_price", "targetname");
  var_1 = scripts\engine\utility::getStruct("end_animnode", "targetname");
  scripts\engine\sp\utility::enable_dynamic_run_speed(level.player, 80, 110, 125);
  thread price_hostage_poi();
  scripted_movement(var_0);
  var_1 thread scripts\common\anim::anim_loop_solo(self, "stairs_arrival_idle", "stop_loop_" + self.animname);
  scripts\engine\utility::flag_set("price_at_stairs");
  thread bomb_countdown(20, "player_on_stairs");
}

vo_hostage_approach() {
  wait 1;
  level.hostage endon("trigger");
  var_0 = ["dx_vom_pri_move_to_balcony_hostages_10", "dx_vom_pri_move_to_balcony_hostages_20", "dx_vom_pri_move_to_balcony_hostages_30"];
  scripts\engine\utility::flag_wait("player_near_price");
  setmusicstate("mx_piccadilly_hostagetension_lp");
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_move_to_balcony_hostages_40");
  level scripts\engine\utility::waittill_notify_or_timeout("player_near_stairs", 10);
  level inside_gap_nag(var_0, undefined, "player_near_stairs");
  level scripts\engine\utility::waittill_notify_or_timeout("player_on_stairs", 3);
  level inside_gap_nag(var_0, undefined, "player_on_stairs");
}

price_hostage_poi() {
  level endon("hostage_scene_begin");
  var_0 = getEnt("price_spots_hostages", "targetname");

  while(!self istouching(var_0))
    waitframe();

  childthread vo_help_screams();
  thread vo_hostage_walla();
  childthread plays_quick_poi("price_notice_poi");
  level.price scripts\engine\utility::delaythread(1, scripts\sp\maps\piccadilly\piccadilly_util.gsc::say, "dx_vom_pri_move_to_balcony_hostages_80");
}

vo_help_screams() {
  level endon("player_on_stairs");
  var_0 = [];
  var_0[var_0.size] = "dx_vom_ucm1_move_to_balcony_hostages_50";
  var_0[var_0.size] = "dx_vom_ucf1_move_to_balcony_hostages_60";
  var_0[var_0.size] = "dx_vom_ucm2_move_to_balcony_hostages_70";
  var_0[var_0.size] = "dx_vom_ucf1_move_to_balcony_hostages_71";
  var_0[var_0.size] = "dx_vom_ucm1_move_to_balcony_hostages_72";
  var_0[var_0.size] = "dx_vom_ucm2_move_to_balcony_hostages_73";
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  var_2 = 1;
  var_3 = 0.5;

  for(;;) {
    var_4 = var_1 scripts\engine\sp\utility::deck_draw();
    var_5 = strtok(var_4, "_")[2];
    level.hostage_extras[var_5] scripts\engine\sp\utility::smart_dialogue(var_4);
    var_2 = min(var_2 * 1.45, 12);
    var_3 = min(var_3 * 1.5, 4);
    wait(randomfloatrange(var_2 - var_3, var_2 + var_3));
  }
}

vo_hostage_walla() {
  scripts\engine\utility::flag_wait("player_on_stairs");
  var_0 = spawn("script_origin", (432, 1086, 300));
  var_1 = spawn("script_origin", (306, 926, 300));
  var_0 playLoopSound("scn_piccadilly_outro_hostage_walla_left_lp");
  var_1 playLoopSound("scn_piccadilly_outro_hostage_walla_right_lp");
}

plays_quick_poi(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  scripts\common\ai::poi_enable(1, var_2);
  self.poi_enabled = 1;
  self waittill("start_anim_reach");
  scripts\common\ai::poi_enable(0);
  self.poi_enabled = 0;
}

plays_wait_poi(var_0) {
  if(scripts\engine\utility::flag("player_on_stairs")) {
    return;
  }
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  scripts\common\ai::poi_enable(1, var_1);
  self.poi_enabled = 1;
  scripts\engine\utility::flag_wait("player_near_stairs");
  scripts\common\ai::poi_enable(0);
  self.poi_enabled = 0;
}

balcony_hostage_intro_start() {
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::spawn_price();
  spawn_spec_hostage();
  thread vo_hostage_walla();
  var_0 = [level.price];
  var_1 = scripts\engine\utility::getStruct("end_animnode", "targetname");
  var_1 thread scripts\common\anim::anim_loop(var_0, "end_idle", "stop_hostage_loop");
  scripts\engine\sp\utility::set_start_location("hostage_intro", [level.player, level.price]);
  level.player modifybasefov(55, 0.05);
  scripts\engine\sp\objectives::objective_add("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_CHECK_BOMB", "");
  scripts\engine\sp\objectives::objective_set_on_entity("piccadilly_objective", "hostage", level.hostage);
  scripts\engine\sp\objectives::objective_set_z_offset("piccadilly_objective", 57);
  thread bomb_countdown(20, "hostage_scene_begin");
  scripts\engine\utility::flag_set("interact_ready");
}

balcony_hostage_intro_main() {
  level endon("bomb_vest_exploded_early");
  scripts\engine\utility::flag_wait("interact_ready");
  level.hostage scripts\sp\player\cursor_hint::create_cursor_hint("j_chest", (-2, -10, 0), &"PICCADILLY/CURSOR_INVESTIGATE", undefined, undefined, 110, 0, undefined, undefined, undefined, undefined, undefined, undefined, 65, 80);
  level.hostage waittill("trigger");
  setmusicstate("");
  stopcinematicingame();
  level.price scripts\engine\sp\utility::name_hide();
  scripts\engine\utility::flag_set("hostage_scene_begin");
  thread hostage_scene();
  level scripts\engine\utility::waittill_any("fade_out_scene", "stop_userskip_input_thread");

  if(level.gotachievement)
    thread scripts\sp\utility::giveachievement_wrapper("nofriendlyfire");
}

balcony_hostage_intro_catchup() {}

spawn_spec_hostage() {
  level.hostage = spawn_gap_hostage();
  level.hostage setModel("body_civ_london_male_bombvest");
  level.hostage detach(level.hostage.headmodel);
  level.hostage.headmodel = "head_sc_m_johnson";
  level.hostage attach(level.hostage.headmodel);
  level.hostage thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::shadow_manager();
  thread spawn_gap_extras();
}

spawn_gap_extras() {
  var_0 = scripts\engine\sp\utility::create_deck([level.intro_civs["male"][0], level.intro_civs["male"][0], level.intro_civs["female"][0]]);
  var_1 = scripts\engine\utility::getStruct("end_animnode", "targetname");
  level.hostage_extras = [];
  level.hostages = [];

  for(var_2 = 1; var_2 < 7; var_2++) {
    var_3 = var_0 scripts\engine\sp\utility::deck_draw();
    var_4 = scripts\engine\sp\utility::bodyonlyspawn(var_3);
    var_4.animname = "hostage" + var_2;
    var_4 setup_extras(var_2);
    var_4 setCanDamage(1);
    var_4 thread bodyonly_hostage_dmg_monitor();
    var_4 thread scripts\sp\maps\piccadilly\piccadilly_util.gsc::shadow_manager();
    var_4 thread kill_on_countdown_timer();
    level.hostages[level.hostages.size] = var_4;

    if(var_4.script_namenumber == "female" && !isDefined(level.hostage_extras["ucf1"]))
      level.hostage_extras["ucf1"] = var_4;
    else if(var_4.script_namenumber == "male" && !isDefined(level.hostage_extras["ucm1"]))
      level.hostage_extras["ucm1"] = var_4;
    else if(var_4.script_namenumber == "male" && !isDefined(level.hostage_extras["ucm2"]))
      level.hostage_extras["ucm2"] = var_4;

    var_1 thread scripts\common\anim::anim_loop_solo(var_4, "end_idle", "stop_hostage_loop_" + var_4.animname);
    var_4 thread anim_touch_react_and_idle(var_1);
  }
}

setup_extras(var_0) {
  switch (var_0) {
    case 1:
      scripts\sp\maps\piccadilly\piccadilly_infil.gsc::civ_different_everything("body_civ_london_male_1_1", "head_sc_m_tang_civ");
      break;
    case 2:
      scripts\sp\maps\piccadilly\piccadilly_infil.gsc::civ_different_everything("body_civ_london_female_4_2", "head_sc_f_stokes_civ_no_hair");
      break;
    case 3:
      scripts\sp\maps\piccadilly\piccadilly_infil.gsc::civ_different_everything("body_civ_london_male_7_2", "head_sc_m_tang_civ");
      break;
    case 4:
      scripts\sp\maps\piccadilly\piccadilly_infil.gsc::civ_different_everything("body_civ_london_female_10_1", "head_sc_f_stokes_civ_no_hair");
      break;
    case 5:
      scripts\sp\maps\piccadilly\piccadilly_infil.gsc::civ_different_everything("body_civ_london_female_6_2", "head_sc_f_stokes_civ_no_hair");
      break;
    case 6:
      scripts\sp\maps\piccadilly\piccadilly_infil.gsc::civ_different_everything("body_civ_london_male_10_1", "head_sc_m_tang_civ");
      break;
  }

  if(isDefined(self.hatmodel))
    self detach(self.hatmodel);

  self attach("zip_tie_handcuffs_wm", "tag_accessory_right");
  self attach("hat_prisoner_hood");
  self.hatmodel = "hat_prisoner_hood";
}

anim_touch_react_and_idle(var_0) {
  var_0 endon("stop_hostage_loop");
  self endon("death");
  var_1 = squared(45);

  for(;;) {
    var_2 = distancesquared(level.player.origin, self.origin);

    if(var_2 <= var_1) {
      var_0 notify("stop_hostage_loop_" + self.animname);
      var_0 scripts\common\anim::anim_single_solo(self, "end_react");
      var_0 thread scripts\common\anim::anim_loop_solo(self, "end_idle", "stop_hostage_loop_" + self.animname);

      for(;;) {
        var_2 = distancesquared(level.player.origin, self.origin);

        if(var_2 > var_1) {
          break;
        } else
          wait 0.25;
      }
    }

    wait 0.25;
  }
}

kill_on_countdown_timer() {
  level waittill("bomb_countdown_over");

  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  self startragdoll();
  self notsolid();
}

bodyonly_hostage_dmg_monitor() {
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  if(!scripts\engine\utility::flag("bomb_vest_exploded_early"))
    thread scripts\sp\friendlyfire::missionfail(1);

  level.gotachievement = 0;
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::print_no_achievement();
  self startragdoll();
  self notsolid();
}

balcony_hostage_anims_price() {
  level endon("hostage_scene_begin");
  level endon("bomb_vest_exploded_early");
  var_0 = scripts\engine\utility::getStruct("end_animnode", "targetname");
  var_1 = getEnt("spec_stairs_blocker", "targetname");
  var_1 scripts\engine\utility::delaycall(0.7, ::delete);
  thread temp_price_clip1();
  var_0 notify("stop_loop_" + self.animname);
  var_0 scripts\common\anim::anim_single_solo(self, "stairs_to_mid");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "stairs_to_mid_idle", "stop_loop_" + self.animname);
  scripts\engine\utility::flag_wait("player_on_stairs");
  var_2 = [self, level.hostage];
  var_1 = getEnt("spec_stairs_mid_blocker", "targetname");
  var_1 delete();
  thread temp_price_clip2();
  scripts\engine\utility::delaythread(3.5, scripts\engine\sp\utility::autosave_by_name, "price_intro_done");
  thread update_bomb_objective();

  foreach(var_4 in level.hostages)
  var_0 notify("stop_hostage_loop_" + var_4.animname);

  var_0 notify("stop_hostage_loop");
  var_0 notify("stop_loop_" + self.animname);
  scripts\engine\utility::flag_set("start_end_anims");
  scripts\engine\utility::delaythread(8, scripts\engine\utility::flag_set, "interact_ready");
  var_0 scripts\common\anim::anim_single(var_2, "end");
  var_0 scripts\common\anim::anim_single(var_2, "end_radio");
  thread bomb_countdown(8, "hostage_scene_begin", 1);
  var_0 thread scripts\common\anim::anim_loop(var_2, "end_idle", "stop_hostage_loop");
  wait 2;
}

update_bomb_objective() {
  if(scripts\engine\sp\objectives::objective_exists("piccadilly_objective")) {
    scripts\engine\sp\objectives::objective_remove_all_locations("piccadilly_objective");
    scripts\engine\sp\objectives::objective_update("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_CHECK_BOMB", "");
    scripts\engine\sp\objectives::objective_set_on_entity("piccadilly_objective", "hostage", level.hostage);
    scripts\engine\sp\objectives::objective_set_z_offset("piccadilly_objective", 57);
  } else {
    scripts\engine\sp\objectives::objective_add("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_CHECK_BOMB", "");
    scripts\engine\sp\objectives::objective_set_on_entity("piccadilly_objective", "hostage", level.hostage);
    scripts\engine\sp\objectives::objective_set_z_offset("piccadilly_objective", 57);
  }
}

temp_price_clip1() {
  self.followclip rotatebylinked((0, 45, 0), 0.9);
  wait 3.3;
  self.followclip rotatebylinked((0, -90, 0), 1);
}

temp_price_clip2() {
  wait 0.5;
  self.followclip rotatebylinked((0, 90, 0), 1.4);
  self.followclip scripts\engine\utility::delaycall(4.3, ::delete);
  self.followclip.clip scripts\engine\utility::delaycall(4.3, ::delete);
}

bomb_countdown(var_0, var_1, var_2) {
  level endon(var_1);

  if(isDefined(var_2))
    scripts\engine\utility::flag_wait("player_on_stairs");

  var_3 = gettime();

  for(;;) {
    if(gettime() >= var_3 + var_0 * 1000) {
      break;
    } else
      wait 0.1;
  }

  level notify("bomb_countdown_over");
  set_off_hostage_bomb(0);
}

set_off_hostage_bomb(var_0) {
  if(isDefined(level.hostage.cursor_hint_ent))
    level.hostage scripts\sp\player\cursor_hint::remove_cursor_hint();

  scripts\sp\maps\piccadilly\piccadilly_anim.gsc::start_explosion(level.hostage);
  scripts\engine\utility::flag_set("bomb_vest_exploded_early");
  scripts\engine\utility::array_thread(level.hostages, ::damage_hostages);
  level.price check_price_and_player();
  level.hostage damage_hostages();
  wait 0.5;

  if(var_0)
    scripts\sp\player_death::set_custom_death_quote(30);
  else
    scripts\sp\player_death::set_custom_death_quote(28);

  scripts\sp\utility::missionfailedwrapper();
}

damage_hostages() {
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    scripts\common\ai::stop_magic_bullet_shield();

  scripts\sp\utility::do_damage(self.health + 100, level.hostage.origin, undefined, undefined, "MOD_EXPLOSIVE");
}

check_price_and_player() {
  var_0 = squared(400);
  var_1 = distancesquared(level.hostage.origin, level.price.origin);
  var_2 = distancesquared(level.hostage.origin, level.player.origin);

  if(var_1 < var_0) {
    if(isDefined(level.price.magic_bullet_shield) && level.price.magic_bullet_shield)
      level.price scripts\common\ai::stop_magic_bullet_shield();

    level.price kill(level.hostage.origin, level.hostage, level.hostage, "MOD_EXPLOSIVE");
  }

  if(var_2 < var_0)
    level.player kill(level.hostage.origin, level.hostage, level.hostage, "MOD_EXPLOSIVE");
}

hostage_scene() {
  level.scr_model["player_rig"] = "viewhands_fullbody_kyle_sas_urban";
  var_0 = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 500 1.5 10000");
  var_1 = scripts\engine\utility::getStruct("end_animnode", "targetname");
  var_2 = var_1 scripts\sp\player_rig::link_player_to_rig("end_boom", "stand", 1, 0.3, 0, 35, 35, 20, 10, 1);
  level.rig = var_2;
  level.rig thread hostage_scene_plr_rumble();
  level.player scripts\engine\utility::delaycall(0.03, ::springcamenabled, 0.1, 3.5, 1.5);
  thread ending_extras();
  var_1 notify("stop_hostage_loop");
  var_3 = [level.price, level.hostage, var_2];
  scripts\engine\utility::delaythread(1, ::skippable_picc_ending, var_3);
  var_1 thread scripts\common\anim::anim_single(level.hostages, "end_boom");
  var_1 scripts\common\anim::anim_single([level.hostage, level.price, var_2], "end_boom");
  var_1 scripts\common\anim::anim_last_frame_solo(level.price, "end_boom");
  var_1 scripts\common\anim::anim_last_frame_solo(var_2, "end_boom");
  level.player setclienttriggeraudiozone("fade_to_black", 2.0);
  pausecinematicingame(0);
  setsaveddvar("OMNONNMOTP", var_0);

  foreach(var_5 in level.hostages) {
    if(isDefined(var_5))
      var_5 delete();
  }

  wait 2;
  scripts\engine\sp\utility::nextmission();
}

hostage_scene_plr_rumble() {
  level.player playRumbleOnEntity("damage_heavy");

  for(;;) {
    self waittill("single anim", var_0);

    switch (var_0[0]) {
      case "yank":
        level.player playRumbleOnEntity("damage_light");
        break;
      case "ps_lon_bmb_020_boom_lfe_01":
      case "grab":
        level.player playRumbleOnEntity("damage_heavy");
        break;
      default:
        break;
    }
  }
}

ending_extras() {
  level.hostage thread delete_after_anim();
  thread nextmission_wrapper();
  thread lerp_angle_during_price_grab();
  thread scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::balcony_hostage_dof();
  visionsetnaked("piccadilly_spec_hero", 1);
  level.player scripts\engine\utility::delaycall(0.2, ::lerpfovscalefactor, 0, 0.8);
  scripts\engine\sp\objectives::objective_complete("piccadilly_objective");
  scripts\engine\utility::flag_wait("hostage_explosion");
  level.player scripts\engine\utility::delaythread(0.2, scripts\engine\sp\utility::play_sound_on_entity, "dx_vom_plr_explosion_efforts");
  wait 3.6;
  level.player lerpviewangleclamp(1, 0.5, 0.5, 0, 0, 0, 0);
  level.player setcinematicmotionoverride("disabled");
  setsaveddvar("NOOPLKSRQT", 2.35);
  hidecinematicletterboxing(2, 0);
}

lerp_angle_during_price_grab() {
  wait 5.4;
  level.player lerpviewangleclamp(0.4, 0.1, 0.1, 5, 5, 5, 5);
  wait 1.2;
  level.player lerpviewangleclamp(0.4, 0.1, 0.1, 35, 35, 20, 10);
  wait 6;
  level.player lerpviewangleclamp(0.4, 0.1, 0.1, 5, 5, 5, 5);
  wait 2;
  level.player lerpviewangleclamp(0.4, 0.1, 0.1, 35, 35, 20, 10);
}

skippable_picc_ending(var_0) {
  var_1 = scripts\sp\utility::userskip_wait();

  if(!var_1) {
    return;
  }
  scripts\sp\hud_util::fade_out(0);
  var_2 = "end_boom";
  var_3 = 1.1;

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_5 scripts\engine\sp\utility::anim_stopanimScripted();
    var_5 stopsounds();
  }

  pausecinematicingame(0);
  setomnvar("ui_hide_hud", 0);
  scripts\engine\utility::delaythread(2.1, scripts\sp\hud_util::fade_in, 0);
  scripts\engine\sp\utility::nextmission();
  scripts\sp\utility::userskip_stop();
}

nextmission_wrapper() {
  level waittill("fade_out_scene");
  scripts\sp\utility::userskip_stop();
  scripts\sp\hud_util::fade_out(1.5, "black");
}

spawn_gap_hostage() {
  var_0 = scripts\engine\utility::getStruct("end_animnode", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("gap_hostage", 1);
  var_1 thread gap_hostage_dmg_monitor();
  var_1 thread gap_hostage_beeper_loop();
  var_0 thread scripts\common\anim::anim_loop_solo(var_1, "end_idle", "stop_hostage_loop");
  var_1.loop_node = var_0;
  return var_1;
}

gap_hostage_dmg_monitor() {
  scripts\engine\utility::waittill_either("damage", "death");
  wait 0.25;

  if(scripts\engine\utility::flag("hostage_scene_begin")) {
    return;
  }
  if(!scripts\engine\utility::flag("bomb_vest_exploded_early"))
    set_off_hostage_bomb(1);

  self delete();
}

gap_hostage_beeper_loop() {
  self endon("entitydeleted");
  self endon("death");
  self.bomb_exploded = 0;
  self.bomb_beeps = 0.7;
  childthread beeper_monitor();

  while(!self.bomb_exploded) {
    self playSound("bomb_beep");
    wait(self.bomb_beeps);
  }
}

beeper_monitor() {
  level waittill("beep_faster");
  self.bomb_beeps = 0.35;
  level waittill("beep_fastest");
  self.bomb_beeps = 0.1;
}

gap_ai_cleanup() {
  scripts\engine\utility::flag_wait("inside_gap_flag");
  var_0 = getaiarray("axis");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.origin[1] <= -1000)
      var_1[var_1.size] = var_3;
  }

  if(var_1.size)
    thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var_1, 300);
}

unblock_player() {
  scripts\engine\utility::flag_wait("price_through_exit");
  var_0 = getEnt("roofdoor_player_blocker", "targetname");
  var_0 delete();
}

waittill_player_is_close_and_sees(var_0, var_1, var_2) {
  var_3 = 0;
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 20);
  var_4 = cos(50);

  for(;;) {
    if(distancesquared(level.player.origin, var_0.origin) <= squared(var_1) && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, var_4) && scripts\engine\utility::can_trace_to_ai(level.player getEye(), var_0))
      var_3++;
    else
      var_3 = 0;

    if(var_3 >= var_2) {
      return;
    }
    waitframe();
  }
}

courtyard_mid_catchup() {}

courtyard_bomber() {
  var_0 = getEnt("spawn_sourtyard_bomber", "targetname");
  var_1 = getspawnerarray(var_0.target);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(issubstr(var_4.classname, "bomb")) {
      var_2 = var_4;
      break;
    }
  }

  var_0 waittill("trigger");
  wait(var_2.script_delay_spawn);
  waitframe();

  if(isDefined(level.price_redshirt) && isalive(level.price_redshirt))
    level.price_redshirt scripts\engine\sp\utility::die();

  activate_colortrig_safe("price_to_mid_courtyard");
}

activate_colortrig_on_aigroup_death(var_0, var_1) {
  var_2 = undefined;

  while(!isDefined(var_2)) {
    var_2 = scripts\engine\sp\utility::get_ai_group_ai(var_0);
    wait 0.5;
  }

  var_2 = scripts\engine\sp\utility::waittill_ai_group_dead(var_0);
  activate_colortrig_safe(var_1);
}

activate_trig_when_vol_clear(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");

  while(!var_2 scripts\engine\sp\utility::get_ai_touching_volume("axis").size)
    wait 1;

  while(var_2 scripts\engine\sp\utility::get_ai_touching_volume("axis").size)
    wait 1;

  activate_colortrig_safe(var_1);
}

activate_colortrig_on_death() {
  var_0 = scripts\engine\utility::get_linked_ent();
  self waittill("death");
  activate_colortrig_safe(var_0);
}

activate_colortrig_safe(var_0) {
  var_1 = undefined;

  if(isstring(var_0))
    var_1 = getEnt(var_0, "targetname");
  else if(isent(var_0))
    var_1 = var_0;

  var_1 scripts\engine\sp\utility::activate_trigger();
}

price_spec_start() {
  scripts\engine\utility::flag_set("stop_storefront_drones");
  scripts\engine\utility::flag_set("start_moveup_center");
  thread price_intro_debris_and_interact();
  scripts\engine\sp\utility::set_start_location("gap_start", [level.player]);
}

price_spec_main() {
  scripts\engine\utility::exploder("price_intro_fx");
  scripts\engine\utility::stop_exploder("aftermath");
  scripts\engine\utility::stop_exploder("spec");
  scripts\engine\utility::stop_exploder("rain_amb");
  price_spec_intro();
}

inside_gap_nag(var_0, var_1, var_2, var_3) {
  level.price endon("death");

  if(scripts\engine\utility::flag_exist(var_2) && scripts\engine\utility::flag(var_2)) {
    return;
  }
  if(isDefined(var_2))
    level endon(var_2);

  var_4 = scripts\engine\sp\utility::create_deck(var_0);
  var_5 = 3;
  var_6 = 1;
  wait 3;

  if(isDefined(var_3))
    level waittill(var_3);

  if(isDefined(var_1))
    level.price scripts\engine\sp\utility::smart_dialogue(var_4 scripts\engine\sp\utility::deck_draw_specific(var_1));

  wait(randomfloatrange(var_5 - var_6, var_5 + var_6));

  for(;;) {
    if(isDefined(var_3))
      level waittill(var_3);

    level.price scripts\engine\sp\utility::smart_dialogue(var_4 scripts\engine\sp\utility::deck_draw());
    var_5 = min(var_5 * 1.5, 20);
    var_6 = min(var_6 * 1.2, 6);
    wait(randomfloatrange(var_5 - var_6, var_5 + var_6));
  }
}

price_spec_catchup() {
  scripts\engine\utility::exploder("price_intro_fx");
  scripts\engine\utility::stop_exploder("aftermath");
  scripts\engine\utility::stop_exploder("spec");
}

price_intro_debris_and_interact() {
  var_0 = scripts\engine\utility::getStruct("spec_price_intro", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_anim_model("debris1");
  var_2 = scripts\engine\sp\utility::spawn_anim_model("debris2");
  var_0 scripts\common\anim::anim_first_frame([var_1, var_2], "price_spec_intro");
  var_0.actors = [var_1, var_2];
  scripts\engine\utility::flag_wait("gap_bomber_dead");
  level thread vo_post_gap_bomber();
  var_3 = scripts\engine\utility::getStruct("spec_door_interact", "targetname");
  var_3 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, undefined, &"PICCADILLY/MOVE_DEBRIS");
  var_3 waittill("trigger");
  scripts\engine\utility::flag_set("spec_price_intro_start");
}

vo_post_gap_bomber() {
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::pause_chatter();
  level endon("spec_price_intro_start");
  wait 4;
  level.player scripts\sp\maps\piccadilly\piccadilly_util.gsc::say("dx_vom_kyle_sting_rear_tanto_30");
  level scripts\sp\maps\piccadilly\piccadilly_util.gsc::say("dx_vom_gfc_sting_rear_tanto_40");
  level scripts\sp\maps\piccadilly\piccadilly_util.gsc::say("dx_vom_gfc_sting_rear_tanto_50");
  level.player scripts\sp\maps\piccadilly\piccadilly_util.gsc::say("dx_vom_kyle_sting_rear_tanto_60");
  scripts\sp\maps\piccadilly\piccadilly_util.gsc::resume_chatter(1);
}

price_spec_intro() {
  if(!scripts\engine\sp\utility::is_default_start())
    waitframe();

  level.player enableinvulnerability();
  var_0 = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 500 1.5 10000");
  getEnt("price_vehicle", "targetname") show();
  var_1 = scripts\engine\utility::getStruct("spec_price_intro", "targetname");

  while(!isDefined(var_1.actors))
    waitframe();

  visionsetnaked("piccadilly_price_intro", 0.6);
  thread price_intro_lighting();
  thread scripts\sp\utility::delete_live_grenades();
  thread mus_price_intro();
  level.dopickyautosavechecks = 0;
  var_1 thread scripts\sp\player_rig::link_player_to_rig("price_spec_intro", "stand", 1, 0.25, 0, 10, 10, 10, 7, 1);

  while(!isDefined(level.player_rig))
    waitframe();

  level.player_rig thread spec_intro_plr_rumble();
  level.rig = level.player_rig;
  var_2 = level.player_rig;
  var_3 = getanimlength(var_2 scripts\engine\utility::getanim("price_spec_intro"));
  scripts\engine\utility::noself_delaycall(var_3, ::visionsetnaked, "", 2.0);
  level.player scripts\engine\utility::delaycall(var_3, ::disableinvulnerability);
  thread scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::lights_on("price_intro");
  thread scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::lights_on("spec_pre_hostage");
  thread scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::lights_off("spec_hostage");
  setsaveddvar("LKOLRONRNQ", 500);
  var_2 thread func_after_anim(scripts\sp\player_rig::unlink_player_from_rig);
  spawn_spec_intro_actors(var_1);
  var_4 = scripts\engine\sp\utility::spawn_targetname("spec_intro_terry", 1);
  level.terry = var_4;
  var_4.context_melee_allowed = 0;
  var_4 setModel("body_al_qatala_urban_ar_variants_2_1");
  var_4 attach("weapon_wm_me_soscar_knife", "tag_accessory_right");
  var_4 detach(var_4.headmodel);
  var_4 attach("head_sc_m_yurteri_civ_beard");
  var_4.headmodel = "head_sc_m_yurteri_civ_beard";

  if(isDefined(var_4.hatmodel))
    var_4 detach(var_4.hatmodel);

  var_4 attach("hat_sc_m_yurteri_civ_beanie");
  var_4.hatmodel = "hat_sc_m_yurteri_civ_beanie";
  var_4 thread die_after_anim();
  var_1.actors[var_1.actors.size] = var_4;
  thread on_terry_death(var_4);
  thread scripts\sp\maps\piccadilly\piccadilly_infil.gsc::clip_delete("player_post_reveal_blocker", "delete_post_reveal_blocker");
  thread scripts\sp\maps\piccadilly\piccadilly_lighting.gsc::price_intro_dof();
  thread price_intro_fov(var_3);
  level.price thread scripts\engine\sp\utility::name_hide();
  level.price scripts\engine\utility::delaythread(var_3, scripts\engine\sp\utility::name_show);
  scripts\engine\utility::delaythread(18, ::spawn_spec_hostage);
  level.player scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::play_sound_on_entity, "dx_vom_plr_lon_tto_door");
  var_1 thread scripts\common\anim::anim_single_solo(var_2, "price_spec_intro");
  var_1 thread scripts\common\anim::anim_single(var_1.actors, "price_spec_intro");
  var_1 scripts\common\anim::anim_single_solo(level.price, "price_spec_intro");
  setsaveddvar("OMNONNMOTP", var_0);
}

mus_price_intro() {
  wait 1;
  setmusicstate("");
}

spec_intro_plr_rumble() {
  var_0 = level.player scripts\engine\sp\utility::get_rumble_ent("steady_rumble");
  var_0.intensity = 0;

  for(;;) {
    self waittill("single anim", var_1);

    switch (var_1[0]) {
      case "hand_on":
        level.player playRumbleOnEntity("damage_light");
        break;
      case "push_start":
        var_0.intensity = 0.2;
        break;
      case "push_end":
        var_0.intensity = 0;
        break;
      case "hand_grab":
        level.player playRumbleOnEntity("damage_heavy");
        var_0 thread scripts\engine\sp\utility::rumble_ramp_to(0.6, 2.1);
        var_0 scripts\engine\utility::delaycall(2.2, ::delete);
        return;
      default:
        break;
    }
  }
}

on_terry_death(var_0) {
  scripts\engine\utility::flag_wait("price_intro_terry_shot");

  foreach(var_2 in getaiarray()) {
    if(var_2 == var_0) {
      continue;
    }
    if(scripts\engine\utility::is_equal(var_2.team, "axis") || scripts\engine\utility::is_equal(var_2.asmname, "civilian"))
      var_2 delete();
  }

  thread scripts\sp\utility::delete_live_grenades();
}

price_intro_fov(var_0) {
  level.player lerpfovscalefactor(0, 1);
  level.player scripts\engine\utility::delaycall(var_0, ::lerpfovscalefactor, 1, 1);
  level.player modifybasefov(60, 1);
  level.player scripts\engine\utility::delaycall(var_0, ::modifybasefov, 65, 1);
}

set_friendname(var_0, var_1) {
  self.script_friendname = var_0;
  self.name = self.script_friendname;

  if(isDefined(var_1)) {
    self.script_callsign = var_1;
    self.callsign = self.script_callsign;
  }
}

price_intro_lighting() {
  if(level.start_point == "price_intro")
    waitframe();

  var_0 = getEntArray("price_intro_on", "targetname");
  var_1 = getEntArray("price_intro_off", "targetname");

  foreach(var_3 in var_0)
  var_3 setlightintensity(var_3.og_intensity);

  foreach(var_3 in var_1)
  var_3 setlightintensity(0);
}

spawn_spec_intro_actors(var_0) {
  var_1 = scripts\sp\maps\piccadilly\piccadilly_util.gsc::spawn_price();
  var_1 thread delay_for_clip();
  playworldsound("scn_piccadilly_price_intro_vehicle", (420, -226, 179));
  var_1.script_pushable = 0;
  var_2 = ["sas1", "sas2", "sas3"];

  foreach(var_4 in var_2) {
    var_1 = scripts\sp\maps\piccadilly\piccadilly_util.gsc::spawn_price_redshirt();
    var_1 thread delete_after_anim();
    var_1.animname = var_4;
    var_0.actors[var_0.actors.size] = var_1;
    waitframe();
  }
}

delay_for_clip() {
  wait 22;
  thread price_clip();
}

price_clip() {
  self.followclip = scripts\engine\utility::spawn_script_origin(level.price.origin, level.price.angles);
  self.followclip setModel("tag_origin");
  self.followclip.clip = getEnt("price_clip", "targetname");
  self.followclip linkTo(self, "tag_origin", (20, 0, 35), (0, -30, 0));
  self.followclip.clip linkTo(self.followclip, "tag_origin", (0, 0, 0), (0, 0, 0));
  self waittill("start_anim_single");
  wait 1.4;
  self.followclip rotatebylinked((0, -45, 0), 0.4);
}

die_after_anim() {
  self waittillmatch("single anim", "end");
  self.a.nodeath = 1;
  self.allowdeath = 1;
  scripts\engine\sp\utility::die();
}

delete_after_anim() {
  self waittillmatch("single anim", "end");

  if(isDefined(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  self delete();
}

func_after_anim(var_0) {
  self waittillmatch("single anim", "end");
  self[[var_0]]();
  thread player_speed_management_ending("start_end_anims");
}

scripted_movement(var_0, var_1) {
  self endon("stop_scripted_movement");

  if(isDefined(var_1) && var_1)
    self forceteleport(var_0.origin, var_0.angles);

  self.post_wait_func = ::scripted_movement_post_wait;
  scripts\sp\spawner::go_to_node(var_0, ::scripted_movement_arrival);
}

scripted_movement_post_wait() {
  if(isDefined(self.scripted_movement_idle))
    self.scripted_animnode notify("stop_" + self.scripted_anime + "_idle_" + self.animname);
}

scripted_movement_arrival(var_0) {
  if(isDefined(self.scripted_movement_idle))
    self.scripted_animnode notify("stop_" + self.scripted_anime + "_idle_" + self.animname);

  if(isDefined(var_0.script_ent_flag_set))
    scripts\engine\utility::ent_flag_set(var_0.script_ent_flag_set);

  if(isDefined(var_0.script_flag_set))
    scripts\engine\utility::flag_set(var_0.script_flag_set);

  if(isDefined(var_0.animation))
    script_movement_anim(var_0);
}

script_movement_anim(var_0) {
  var_1 = var_0.animation;
  var_0.origin = scripts\engine\utility::drop_to_ground(var_0.origin, 10, -100);
  var_2 = var_0;
  var_3 = 0;

  if(isDefined(var_0.script_parameters)) {
    if(var_0.script_parameters == "no_anim_reach")
      var_3 = 1;
  }

  if(isDefined(var_0.script_animnode))
    var_2 = scripts\engine\utility::getStruct(var_0.script_animnode, "targetname");

  var_4 = 0;

  if(isDefined(level.scr_anim["generic"][var_1]))
    var_4 = 1;

  if(!var_3) {
    self notify("start_anim_reach");

    if(var_4)
      var_2 scripts\sp\anim::anim_generic_reach(self, var_1);
    else
      var_2 scripts\sp\anim::anim_reach_solo(self, var_1);
  }

  self.scripted_movement_idle = undefined;
  self.scripted_anime = undefined;
  self.scripted_animnode = undefined;
  self notify("start_anim_single");

  if(var_4)
    var_2 thread scripts\common\anim::anim_generic(self, var_1);
  else
    var_2 thread scripts\common\anim::anim_single_solo(self, var_1);

  if(isDefined(var_0.script_type)) {
    if(var_0.script_type == "anim_wait")
      self waittillmatch("single anim", "end");
  }
}