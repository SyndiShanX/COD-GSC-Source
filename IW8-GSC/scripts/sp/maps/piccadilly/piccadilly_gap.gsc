/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\piccadilly\piccadilly_gap.gsc
*********************************************************/

function gap_flags() {
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

function to_balcony_start() {
  setDvar("pic_intro", 0);
  scripts\sp\maps\piccadilly\piccadilly_util::delete_trigger_with_noteworthy("left_main_trig");
  scripts\engine\utility::flag_set("stop_storefront_drones");
  scripts\engine\utility::flag_set("start_moveup_center");
  scripts\sp\maps\piccadilly\piccadilly_util::spawn_price();
  thread price_clip();
  thread player_speed_management_ending("start_end_anims");
  thread spawn_spec_hostage();
  scripts\engine\sp\utility::set_start_location("spec_post_intro", [level.player]);
}

function to_balcony_main() {
  thread scripts\sp\maps\piccadilly\piccadilly_lighting::lights_off("price_intro");
  thread scripts\sp\maps\piccadilly\piccadilly_lighting::lights_on("spec_hostage");
  var0 = scripts\engine\utility::getStruct("spec_price_intro", "targetname");
  thread vo_hostage_approach();

  if(!scripts\engine\utility::flag("player_near_price")) {
    var1 = ["dx_vom_pri_move_to_balcony_hostages_10", "dx_vom_pri_move_to_balcony_hostages_20", "dx_vom_pri_move_to_balcony_hostages_30"];
    level.price thread scripts\sp\maps\piccadilly\piccadilly_util::notetrack_nag(var1, "player_near_price", "stop_price_nags");
    var0 thread scripts\common\anim::anim_loop_solo_with_nags(level.price, "price_spec_intro_idle", "stop_price_loop");
    scripts\engine\utility::flag_wait("player_near_price");
    var0 notify("stop_price_loop");
  }

  visionsetnaked("", 1);
  thread update_hostages_objectives();
  level thread scripts\engine\sp\utility::notify_delay("delete_post_reveal_blocker", 2.3);
  var0 scripts\common\anim::anim_single_solo(level.price, "price_spec_intro_exit");
  level.price notify("corner_anim_done");
  level notify("stop_price_nags");
  thread start_spec_movement();
  scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::battlechatter_off);
  scripts\engine\sp\utility::autosave_by_name("gap_start");
  thread gap_ai_cleanup();
  scripts\engine\utility::flag_wait_all("player_near_stairs", "price_at_stairs");
  thread scripts\sp\maps\piccadilly\piccadilly_lighting::lights_off("spec_pre_hostage");
  thread balcony_hostage_anims_price();
  scripts\engine\utility::flag_wait("player_on_stairs");

  if(istrue(level.price.poi_enabled)) {
    level.price scripts\common\ai::poi_enable(0);
    return;
  }
}

function player_speed_management_ending(var0) {
  scripts\sp\player::player_movement_state("cqb");
  var1 = 45;
  var2 = 135;
  var3 = 20;
  var4 = 200;

  while(!scripts\engine\utility::flag(var0)) {
    var5 = distance(level.price.origin, level.player.origin);
    var6 = scripts\engine\math::normalize_value(var3, var4, var5);
    var7 = scripts\engine\math::factor_value(var1, var2, var6);
    scripts\engine\sp\utility::player_speed_set(var7);
    waitframe();
  }

  scripts\sp\player::player_movement_state("cqb");
}

function update_hostages_objectives() {
  if(scripts\engine\sp\objectives::objective_exists("piccadilly_objective")) {
    scripts\engine\sp\objectives::objective_remove("piccadilly_objective");
  }

  scripts\engine\sp\objectives::objective_add("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_REACH_HOSTAGES", &"PICCADILLY/CURSOR_FOLLOW");
  scripts\engine\sp\objectives::objective_set_on_entity("piccadilly_objective", "Follow", level.price);
  scripts\engine\sp\objectives::objective_set_z_offset("piccadilly_objective", 72);
}

function to_balcony_catchup() {
  scripts\engine\utility::flag_set("player_on_stairs");
  var0 = getEnt("spec_stairs_blocker", "targetname");
  var0 delete();
}

function start_spec_movement() {
  var0 = scripts\engine\utility::getStruct("end_run_price", "targetname");
  var1 = scripts\engine\utility::getStruct("end_animnode", "targetname");
  scripts\engine\sp\utility::enable_dynamic_run_speed(level.player, 80, 110, 125);
  thread price_hostage_poi();
  scripted_movement(var0);
  var1 thread scripts\common\anim::anim_loop_solo(self, "stairs_arrival_idle", "stop_loop_" + self.animname);
  scripts\engine\utility::flag_set("price_at_stairs");
  thread bomb_countdown(20, "player_on_stairs");
}

function vo_hostage_approach() {
  wait 1;
  level.hostage endon("trigger");
  var0 = ["dx_vom_pri_move_to_balcony_hostages_10", "dx_vom_pri_move_to_balcony_hostages_20", "dx_vom_pri_move_to_balcony_hostages_30"];
  scripts\engine\utility::flag_wait("player_near_price");
  setmusicstate("mx_piccadilly_hostagetension_lp");
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_move_to_balcony_hostages_40");
  level scripts\engine\utility::waittill_notify_or_timeout("player_near_stairs", 10);
  inside_gap_nag(level, var0, undefined, "player_near_stairs");
  level scripts\engine\utility::waittill_notify_or_timeout("player_on_stairs", 3);
  inside_gap_nag(level, var0, undefined, "player_on_stairs");
}

function price_hostage_poi() {
  level endon("hostage_scene_begin");
  var0 = getEnt("price_spots_hostages", "targetname");

  while(!self istouching(var0)) {
    waitframe();
  }

  GscBinSkip4(0x35);
}

function vo_help_screams() {
  level endon("player_on_stairs");
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_ucm1_move_to_balcony_hostages_50");
}

function vo_hostage_walla() {
  scripts\engine\utility::flag_wait("player_on_stairs");
  var0 = spawn("script_origin", (432, 1086, 300));
  var1 = spawn("script_origin", (306, 926, 300));
  var0 playLoopSound("scn_piccadilly_outro_hostage_walla_left_lp");
  var1 playLoopSound("scn_piccadilly_outro_hostage_walla_right_lp");
}

function plays_quick_poi(var0, var1) {
  var2 = scripts\engine\utility::getStruct(var0, "targetname");
  scripts\common\ai::poi_enable(1, var2);
  self.poi_enabled = 1;
  self waittill("start_anim_reach");
  scripts\common\ai::poi_enable(0);
  self.poi_enabled = 0;
}

function plays_wait_poi(var0) {
  if(scripts\engine\utility::flag("player_on_stairs")) {
    return;
  }

  var1 = scripts\engine\utility::getStruct(var0, "targetname");
  scripts\common\ai::poi_enable(1, var1);
  self.poi_enabled = 1;
  scripts\engine\utility::flag_wait("player_near_stairs");
  scripts\common\ai::poi_enable(0);
  self.poi_enabled = 0;
}

function balcony_hostage_intro_start() {
  scripts\sp\maps\piccadilly\piccadilly_util::spawn_price();
  spawn_spec_hostage();
  thread vo_hostage_walla();
  var0 = [level.price];
  var1 = scripts\engine\utility::getStruct("end_animnode", "targetname");
  var1 thread scripts\common\anim::anim_loop(var0, "end_idle", "stop_hostage_loop");
  scripts\engine\sp\utility::set_start_location("hostage_intro", [level.player, level.price]);
  level.player modifybasefov(55, 0.05);
  scripts\engine\sp\objectives::objective_add("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_CHECK_BOMB", "");
  scripts\engine\sp\objectives::objective_set_on_entity("piccadilly_objective", "hostage", level.hostage);
  scripts\engine\sp\objectives::objective_set_z_offset("piccadilly_objective", 57);
  thread bomb_countdown(20, "hostage_scene_begin");
  scripts\engine\utility::flag_set("interact_ready");
}

function balcony_hostage_intro_main() {
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

  if(level.gotachievement) {
    thread scripts\sp\utility::giveachievement_wrapper("nofriendlyfire");
    return;
  }
}

function balcony_hostage_intro_catchup() {}

function spawn_spec_hostage() {
  level.hostage = spawn_gap_hostage();
  level.hostage setModel("body_civ_london_male_bombvest");
  level.hostage detach(level.hostage.headmodel);
  level.hostage.headmodel = "head_sc_m_johnson";
  level.hostage attach(level.hostage.headmodel);
  level.hostage thread scripts\sp\maps\piccadilly\piccadilly_util::shadow_manager();
  thread spawn_gap_extras();
}

function spawn_gap_extras() {
  var0 = scripts\engine\sp\utility::create_deck([level.intro_civs["male"][0], level.intro_civs["male"][0], level.intro_civs["female"][0]]);
  var1 = scripts\engine\utility::getStruct("end_animnode", "targetname");
  level.hostage_extras = [];
  level.hostages = [];

  for(var2 = 1; var2 < 7; var2++) {
    var3 = var0 scripts\engine\sp\utility::deck_draw();
    var4 = scripts\engine\sp\utility::bodyonlyspawn(var3);
    var4.animname = "hostage" + var2;
    setup_extras(var4, var2);
    var4 setCanDamage(1);
    thread bodyonly_hostage_dmg_monitor();
    var4 thread scripts\sp\maps\piccadilly\piccadilly_util::shadow_manager();
    thread kill_on_countdown_timer();
    level.hostages[level.hostages.size] = var4;

    if(var4.script_namenumber == "female" && !isDefined(level.hostage_extras["ucf1"])) {
      level.hostage_extras["ucf1"] = var4;
    } else if(var4.script_namenumber == "male" && !isDefined(level.hostage_extras["ucm1"])) {
      level.hostage_extras["ucm1"] = var4;
    } else if(var4.script_namenumber == "male" && !isDefined(level.hostage_extras["ucm2"])) {
      level.hostage_extras["ucm2"] = var4;
    }

    var1 thread scripts\common\anim::anim_loop_solo(var4, "end_idle", "stop_hostage_loop_" + var4.animname);
    thread anim_touch_react_and_idle(var4);
  }
}

function setup_extras(var0) {
  switch (var0) {
    case 1:
      scripts\sp\maps\piccadilly\piccadilly_infil::civ_different_everything("body_civ_london_male_1_1", "head_sc_m_tang_civ");
      break;
    case 2:
      scripts\sp\maps\piccadilly\piccadilly_infil::civ_different_everything("body_civ_london_female_4_2", "head_sc_f_stokes_civ_no_hair");
      break;
    case 3:
      scripts\sp\maps\piccadilly\piccadilly_infil::civ_different_everything("body_civ_london_male_7_2", "head_sc_m_tang_civ");
      break;
    case 4:
      scripts\sp\maps\piccadilly\piccadilly_infil::civ_different_everything("body_civ_london_female_10_1", "head_sc_f_stokes_civ_no_hair");
      break;
    case 5:
      scripts\sp\maps\piccadilly\piccadilly_infil::civ_different_everything("body_civ_london_female_6_2", "head_sc_f_stokes_civ_no_hair");
      break;
    case 6:
      scripts\sp\maps\piccadilly\piccadilly_infil::civ_different_everything("body_civ_london_male_10_1", "head_sc_m_tang_civ");
      break;
  }

  if(isDefined(self.hatmodel)) {
    self detach(self.hatmodel);
  }

  self attach("zip_tie_handcuffs_wm", "tag_accessory_right");
  self attach("hat_prisoner_hood");
  self.hatmodel = "hat_prisoner_hood";
}

function anim_touch_react_and_idle(var0) {
  var0 endon("stop_hostage_loop");
  self endon("death");
  var1 = squared(45);

  for(;;) {
    var2 = distancesquared(level.player.origin, self.origin);

    if(var2 <= var1) {
      var0 notify("stop_hostage_loop_" + self.animname);
      var0 scripts\common\anim::anim_single_solo(self, "end_react");
      var0 thread scripts\common\anim::anim_loop_solo(self, "end_idle", "stop_hostage_loop_" + self.animname);

      for(;;) {
        var2 = distancesquared(level.player.origin, self.origin);

        if(var2 > var1) {
          break;
        }

        wait 0.25;
      }
    }

    wait 0.25;
  }
}

function kill_on_countdown_timer() {
  level waittill("bomb_countdown_over");

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  self startragdoll();
  self notsolid();
}

function bodyonly_hostage_dmg_monitor() {
  self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7);

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  if(!scripts\engine\utility::flag("bomb_vest_exploded_early")) {
    thread scripts\sp\friendlyfire::missionfail(1);
  }

  level.gotachievement = 0;
  scripts\sp\maps\piccadilly\piccadilly_util::print_no_achievement();
  self startragdoll();
  self notsolid();
}

function balcony_hostage_anims_price() {
  level endon("hostage_scene_begin");
  level endon("bomb_vest_exploded_early");
  var0 = scripts\engine\utility::getStruct("end_animnode", "targetname");
  var1 = getEnt("spec_stairs_blocker", "targetname");
  var1 scripts\engine\utility::delaycall(0.7, &delete);
  thread temp_price_clip1();
  var0 notify("stop_loop_" + self.animname);
  var0 scripts\common\anim::anim_single_solo(self, "stairs_to_mid");
  var0 thread scripts\common\anim::anim_loop_solo(self, "stairs_to_mid_idle", "stop_loop_" + self.animname);
  scripts\engine\utility::flag_wait("player_on_stairs");
  var2 = [self, level.hostage];
  var1 = getEnt("spec_stairs_mid_blocker", "targetname");
  var1 delete();
  thread temp_price_clip2();
  scripts\engine\utility::delaythread(3.5, &scripts\engine\sp\utility::autosave_by_name, "price_intro_done");
  thread update_bomb_objective();

  foreach(var4 in level.hostages) {
    var0 notify("stop_hostage_loop_" + var4.animname);
  }

  var0 notify("stop_hostage_loop");
  var0 notify("stop_loop_" + self.animname);
  scripts\engine\utility::flag_set("start_end_anims");
  scripts\engine\utility::delaythread(8, &scripts\engine\utility::flag_set, "interact_ready");
  var0 scripts\common\anim::anim_single(var2, "end");
  var0 scripts\common\anim::anim_single(var2, "end_radio");
  thread bomb_countdown(8, "hostage_scene_begin", 1);
  var0 thread scripts\common\anim::anim_loop(var2, "end_idle", "stop_hostage_loop");
  wait 2;
}

function update_bomb_objective() {
  if(scripts\engine\sp\objectives::objective_exists("piccadilly_objective")) {
    scripts\engine\sp\objectives::objective_remove_all_locations("piccadilly_objective");
    scripts\engine\sp\objectives::objective_update("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_CHECK_BOMB", "");
    scripts\engine\sp\objectives::objective_set_on_entity("piccadilly_objective", "hostage", level.hostage);
    scripts\engine\sp\objectives::objective_set_z_offset("piccadilly_objective", 57);
    return;
  }

  scripts\engine\sp\objectives::objective_add("piccadilly_objective", "current", undefined, &"PICCADILLY/OBJ_CHECK_BOMB", "");
  scripts\engine\sp\objectives::objective_set_on_entity("piccadilly_objective", "hostage", level.hostage);
  scripts\engine\sp\objectives::objective_set_z_offset("piccadilly_objective", 57);
}

function temp_price_clip1() {
  self.followclip rotatebylinked((0, 45, 0), 0.9);
  wait 3.3;
  self.followclip rotatebylinked((0, -90, 0), 1);
}

function temp_price_clip2() {
  wait 0.5;
  self.followclip rotatebylinked((0, 90, 0), 1.4);
  self.followclip scripts\engine\utility::delaycall(4.3, &delete);
  self.followclip.clip scripts\engine\utility::delaycall(4.3, &delete);
}

function bomb_countdown(var0, var1, var2) {
  level endon(var1);

  if(isDefined(var2)) {
    scripts\engine\utility::flag_wait("player_on_stairs");
  }

  var3 = gettime();

  for(;;) {
    if(gettime() >= var3 + var0 * 1000) {
      break;
    }

    wait 0.1;
  }

  level notify("bomb_countdown_over");
  set_off_hostage_bomb(0);
}

function set_off_hostage_bomb(var0) {
  if(isDefined(level.hostage.cursor_hint_ent)) {
    level.hostage scripts\sp\player\cursor_hint::remove_cursor_hint();
  }

  scripts\sp\maps\piccadilly\piccadilly_anim::start_explosion(level.hostage);
  scripts\engine\utility::flag_set("bomb_vest_exploded_early");
  scripts\engine\utility::array_thread(level.hostages, &damage_hostages);
  check_price_and_player(level.price);
  damage_hostages(level.hostage);
  wait 0.5;

  if(var0) {
    scripts\sp\player_death::set_custom_death_quote(30);
  } else {
    scripts\sp\player_death::set_custom_death_quote(28);
  }

  scripts\sp\utility::missionfailedwrapper();
}

function damage_hostages() {
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  scripts\sp\utility::do_damage(self.health + 100, level.hostage.origin, undefined, undefined, "MOD_EXPLOSIVE");
}

function check_price_and_player() {
  var0 = squared(400);
  var1 = distancesquared(level.hostage.origin, level.price.origin);
  var2 = distancesquared(level.hostage.origin, level.player.origin);

  if(var1 < var0) {
    if(isDefined(level.price.magic_bullet_shield) && level.price.magic_bullet_shield) {
      level.price scripts\common\ai::stop_magic_bullet_shield();
    }

    level.price kill(level.hostage.origin, level.hostage, level.hostage, "MOD_EXPLOSIVE");
  }

  if(var2 < var0) {
    level.player kill(level.hostage.origin, level.hostage, level.hostage, "MOD_EXPLOSIVE");
    return;
  }
}

function hostage_scene() {
  level.scr_model["player_rig"] = "viewhands_fullbody_kyle_sas_urban";
  var0 = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 500 1.5 10000");
  var1 = scripts\engine\utility::getStruct("end_animnode", "targetname");
  var2 = var1 scripts\sp\player_rig::link_player_to_rig("end_boom", "stand", 1, 0.3, 0, 35, 35, 20, 10, 1);
  level.rig = var2;
  thread hostage_scene_plr_rumble();
  level.player scripts\engine\utility::delaycall(0.03, &springcamenabled, 0.1, 3.5, 1.5);
  thread ending_extras();
  var1 notify("stop_hostage_loop");
  var3 = [level.price, level.hostage, var2];
  scripts\engine\utility::delaythread(1, &skippable_picc_ending, var3);
  var1 thread scripts\common\anim::anim_single(level.hostages, "end_boom");
  var1 scripts\common\anim::anim_single([level.hostage, level.price, var2], "end_boom");
  var1 scripts\common\anim::anim_last_frame_solo(level.price, "end_boom");
  var1 scripts\common\anim::anim_last_frame_solo(var2, "end_boom");
  level.player setclienttriggeraudiozone("fade_to_black", 2);
  pausecinematicingame(0);
  setsaveddvar("OMNONNMOTP", var0);

  foreach(var5 in level.hostages) {
    if(isDefined(var5)) {
      var5 delete();
    }
  }

  wait 2;
  scripts\engine\sp\utility::nextmission();
}

function hostage_scene_plr_rumble() {
  level.player playRumbleOnEntity("damage_heavy");

  for(;;) {
    self waittill("single anim", var0);

    switch (var0[0]) {
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

function ending_extras() {
  thread delete_after_anim();
  thread nextmission_wrapper();
  thread lerp_angle_during_price_grab();
  thread scripts\sp\maps\piccadilly\piccadilly_lighting::balcony_hostage_dof();
  visionsetnaked("piccadilly_spec_hero", 1);
  level.player scripts\engine\utility::delaycall(0.2, &lerpfovscalefactor, 0, 0.8);
  scripts\engine\sp\objectives::objective_complete("piccadilly_objective");
  scripts\engine\utility::flag_wait("hostage_explosion");
  level.player scripts\engine\utility::delaythread(0.2, &scripts\engine\sp\utility::play_sound_on_entity, "dx_vom_plr_explosion_efforts");
  wait 3.6;
  level.player lerpviewangleclamp(1, 0.5, 0.5, 0, 0, 0, 0);
  level.player setcinematicmotionoverride("disabled");
  setsaveddvar("NOOPLKSRQT", 2.35);
  hidecinematicletterboxing(2, 0);
}

function lerp_angle_during_price_grab() {
  wait 5.4;
  level.player lerpviewangleclamp(0.4, 0.1, 0.1, 5, 5, 5, 5);
  wait 1.2;
  level.player lerpviewangleclamp(0.4, 0.1, 0.1, 35, 35, 20, 10);
  wait 6;
  level.player lerpviewangleclamp(0.4, 0.1, 0.1, 5, 5, 5, 5);
  wait 2;
  level.player lerpviewangleclamp(0.4, 0.1, 0.1, 35, 35, 20, 10);
}

function skippable_picc_ending(var0) {
  var1 = scripts\sp\utility::userskip_wait();

  if(!var1) {
    return;
  }

  scripts\sp\hud_util::fade_out(0);
  var2 = "end_boom";
  var3 = 1.1;

  foreach(var5 in var0) {
    if(!isDefined(var5)) {
      continue;
    }

    var5 scripts\engine\sp\utility::anim_stopanimScripted();
    var5 stopsounds();
  }

  pausecinematicingame(0);
  setomnvar("ui_hide_hud", 0);
  scripts\engine\utility::delaythread(2.1, &scripts\sp\hud_util::fade_in, 0);
  scripts\engine\sp\utility::nextmission();
  scripts\sp\utility::userskip_stop();
}

function nextmission_wrapper() {
  level waittill("fade_out_scene");
  scripts\sp\utility::userskip_stop();
  scripts\sp\hud_util::fade_out(1.5, "black");
}

function spawn_gap_hostage() {
  var0 = scripts\engine\utility::getStruct("end_animnode", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("gap_hostage", 1);
  thread gap_hostage_dmg_monitor();
  thread gap_hostage_beeper_loop();
  var0 thread scripts\common\anim::anim_loop_solo(var1, "end_idle", "stop_hostage_loop");
  var1.loop_node = var0;
  return var1;
}

function gap_hostage_dmg_monitor() {
  scripts\engine\utility::waittill_either("damage", "death");
  wait 0.25;

  if(scripts\engine\utility::flag("hostage_scene_begin")) {
    return;
  }

  if(!scripts\engine\utility::flag("bomb_vest_exploded_early")) {
    set_off_hostage_bomb(1);
  }

  self delete();
}

function gap_hostage_beeper_loop() {
  self endon("entitydeleted");
  self endon("death");
  self.bomb_exploded = 0;
  self.bomb_beeps = 0.7;
  GscBinSkip4(0x35);
}

function beeper_monitor() {
  level waittill("beep_faster");
  self.bomb_beeps = 0.35;
  level waittill("beep_fastest");
  self.bomb_beeps = 0.1;
}

function gap_ai_cleanup() {
  scripts\engine\utility::flag_wait("inside_gap_flag");
  var0 = getaiarray("axis");
  var1 = [];

  foreach(var3 in var0) {
    if(var3.origin[1] <= -1000) {
      var1 = var3;
    }
  }

  if(var1.size) {
    thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var1, 300);
    return;
  }
}

function unblock_player() {
  scripts\engine\utility::flag_wait("price_through_exit");
  var0 = getEnt("roofdoor_player_blocker", "targetname");
  var0 delete();
}

function waittill_player_is_close_and_sees(var0, var1, var2) {
  var3 = 0;
  var2 = scripts\engine\utility::ter_op(isDefined(var2), var2, 20);
  var4 = cos(50);

  for(;;) {
    if(distancesquared(level.player.origin, var0.origin) <= squared(var1) && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var0.origin, var4) && scripts\engine\utility::can_trace_to_ai(level.player getEye(), var0)) {
      var3++;
    } else {
      var3 = 0;
    }

    if(var3 >= var2) {
      return;
    }

    waitframe();
  }
}

function courtyard_mid_catchup() {}

function courtyard_bomber() {
  var0 = getEnt("spawn_sourtyard_bomber", "targetname");
  var1 = getspawnerarray(var0.target);
  var2 = undefined;

  foreach(var4 in var1) {
    if(issubstr(var4.classname, "bomb")) {
      var2 = var4;
      break;
    }
  }

  var0 waittill("trigger");
  wait var2.script_delay_spawn;
  waitframe();

  if(isDefined(level.price_redshirt) && isalive(level.price_redshirt)) {
    level.price_redshirt scripts\engine\sp\utility::die();
  }

  activate_colortrig_safe("price_to_mid_courtyard");
}

function activate_colortrig_on_aigroup_death(var0, var1) {
  var2 = undefined;

  while(!isDefined(var2)) {
    var2 = scripts\engine\sp\utility::get_ai_group_ai(var0);
    wait 0.5;
  }

  var2 = scripts\engine\sp\utility::waittill_ai_group_dead(var0);
  activate_colortrig_safe(var1);
}

function activate_trig_when_vol_clear(var0, var1) {
  var2 = getEnt(var0, "targetname");

  while(!var2 scripts\engine\sp\utility::get_ai_touching_volume("axis").size) {
    wait 1;
  }

  while(var2 scripts\engine\sp\utility::get_ai_touching_volume("axis").size) {
    wait 1;
  }

  activate_colortrig_safe(var1);
}

function activate_colortrig_on_death() {
  var0 = scripts\engine\utility::get_linked_ent();
  self waittill("death");
  activate_colortrig_safe(var0);
}

function activate_colortrig_safe(var0) {
  var1 = undefined;

  if(isstring(var0)) {
    var1 = getEnt(var0, "targetname");
  } else if(isent(var0)) {
    var1 = var0;
  }

  var1 scripts\engine\sp\utility::activate_trigger();
}

function price_spec_start() {
  scripts\engine\utility::flag_set("stop_storefront_drones");
  scripts\engine\utility::flag_set("start_moveup_center");
  thread price_intro_debris_and_interact();
  scripts\engine\sp\utility::set_start_location("gap_start", [level.player]);
}

function price_spec_main() {
  scripts\engine\utility::exploder("price_intro_fx");
  scripts\engine\utility::stop_exploder("aftermath");
  scripts\engine\utility::stop_exploder("spec");
  scripts\engine\utility::stop_exploder("rain_amb");
  price_spec_intro();
}

function inside_gap_nag(var0, var1, var2, var3) {
  level.price endon("death");

  if(scripts\engine\utility::flag_exist(var2) && scripts\engine\utility::flag(var2)) {
    return;
  }

  if(isDefined(var2)) {
    level endon(var2);
  }

  var4 = scripts\engine\sp\utility::create_deck(var0);
  var5 = 3;
  var6 = 1;
  wait 3;

  if(isDefined(var3)) {
    level waittill(var3);
  }

  if(isDefined(var1)) {
    level.price scripts\engine\sp\utility::smart_dialogue(var4 scripts\engine\sp\utility::deck_draw_specific(var1));
  }

  wait randomfloatrange(var5 - var6, var5 + var6);

  for(;;) {
    if(isDefined(var3)) {
      level waittill(var3);
    }

    level.price scripts\engine\sp\utility::smart_dialogue(var4 scripts\engine\sp\utility::deck_draw());
    var5 = min(var5 * 1.5, 20);
    var6 = min(var6 * 1.2, 6);
    wait randomfloatrange(var5 - var6, var5 + var6);
  }
}

function price_spec_catchup() {
  scripts\engine\utility::exploder("price_intro_fx");
  scripts\engine\utility::stop_exploder("aftermath");
  scripts\engine\utility::stop_exploder("spec");
}

function price_intro_debris_and_interact() {
  var0 = scripts\engine\utility::getStruct("spec_price_intro", "targetname");
  var1 = scripts\engine\sp\utility::spawn_anim_model("debris1");
  var2 = scripts\engine\sp\utility::spawn_anim_model("debris2");
  var0 scripts\common\anim::anim_first_frame([var1, var2], "price_spec_intro");
  var0.actors = [var1, var2];
  scripts\engine\utility::flag_wait("gap_bomber_dead");
  thread vo_post_gap_bomber();
  var3 = scripts\engine\utility::getStruct("spec_door_interact", "targetname");
  var3 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, undefined, &"PICCADILLY/MOVE_DEBRIS");
  var3 waittill("trigger");
  scripts\engine\utility::flag_set("spec_price_intro_start");
}

function vo_post_gap_bomber() {
  scripts\sp\maps\piccadilly\piccadilly_util::pause_chatter();
  level endon("spec_price_intro_start");
  wait 4;
  level.player scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_kyle_sting_rear_tanto_30");
  level scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_gfc_sting_rear_tanto_40");
  level scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_gfc_sting_rear_tanto_50");
  level.player scripts\sp\maps\piccadilly\piccadilly_util::say("dx_vom_kyle_sting_rear_tanto_60");
  scripts\sp\maps\piccadilly\piccadilly_util::resume_chatter(1);
}

function price_spec_intro() {
  if(!scripts\engine\sp\utility::is_default_start()) {
    waitframe();
  }

  level.player enableinvulnerability();
  var0 = getDvar("OMNONNMOTP");
  setsaveddvar("OMNONNMOTP", "0.1 500 1.5 10000");
  getEnt("price_vehicle", "targetname") show();
  var1 = scripts\engine\utility::getStruct("spec_price_intro", "targetname");

  while(!isDefined(var1.actors)) {
    waitframe();
  }

  visionsetnaked("piccadilly_price_intro", 0.6);
  thread price_intro_lighting();
  thread scripts\sp\utility::delete_live_grenades();
  thread mus_price_intro();
  level.dopickyautosavechecks = 0;
  var1 thread scripts\sp\player_rig::link_player_to_rig("price_spec_intro", "stand", 1, 0.25, 0, 10, 10, 10, 7, 1);

  while(!isDefined(level.player_rig)) {
    waitframe();
  }

  thread spec_intro_plr_rumble();
  level.rig = level.player_rig;
  var2 = level.player_rig;
  var3 = getanimlength(var2 scripts\engine\utility::getanim("price_spec_intro"));
  scripts\engine\utility::noself_delaycall(var3, &visionsetnaked, "", 2);
  level.player scripts\engine\utility::delaycall(var3, &disableinvulnerability);
  thread scripts\sp\maps\piccadilly\piccadilly_lighting::lights_on("price_intro");
  thread scripts\sp\maps\piccadilly\piccadilly_lighting::lights_on("spec_pre_hostage");
  thread scripts\sp\maps\piccadilly\piccadilly_lighting::lights_off("spec_hostage");
  setsaveddvar("LKOLRONRNQ", 500);
  thread func_after_anim(var2);
  spawn_spec_intro_actors(var1);
  var4 = scripts\engine\sp\utility::spawn_targetname("spec_intro_terry", 1);
  level.terry = var4;
  var4.context_melee_allowed = 0;
  var4 setModel("body_al_qatala_urban_ar_variants_2_1");
  var4 attach("weapon_wm_me_soscar_knife", "tag_accessory_right");
  var4 detach(var4.headmodel);
  var4 attach("head_sc_m_yurteri_civ_beard");
  var4.headmodel = "head_sc_m_yurteri_civ_beard";

  if(isDefined(var4.hatmodel)) {
    var4 detach(var4.hatmodel);
  }

  var4 attach("hat_sc_m_yurteri_civ_beanie");
  var4.hatmodel = "hat_sc_m_yurteri_civ_beanie";
  thread die_after_anim();
  var1.actors[var1.actors.size] = var4;
  thread on_terry_death(var4);
  thread scripts\sp\maps\piccadilly\piccadilly_infil::clip_delete("player_post_reveal_blocker", "delete_post_reveal_blocker");
  thread scripts\sp\maps\piccadilly\piccadilly_lighting::price_intro_dof();
  thread price_intro_fov(var3);
  level.price thread scripts\engine\sp\utility::name_hide();
  level.price scripts\engine\utility::delaythread(var3, &scripts\engine\sp\utility::name_show);
  scripts\engine\utility::delaythread(18, &spawn_spec_hostage);
  level.player scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::play_sound_on_entity, "dx_vom_plr_lon_tto_door");
  var1 thread scripts\common\anim::anim_single_solo(var2, "price_spec_intro");
  var1 thread scripts\common\anim::anim_single(var1.actors, "price_spec_intro");
  var1 scripts\common\anim::anim_single_solo(level.price, "price_spec_intro");
  setsaveddvar("OMNONNMOTP", var0);
}

function mus_price_intro() {
  wait 1;
  setmusicstate("");
}

function spec_intro_plr_rumble() {
  var0 = level.player scripts\engine\sp\utility::get_rumble_ent("steady_rumble");
  var0.intensity = 0;

  for(;;) {
    self waittill("single anim", var1);

    switch (var1[0]) {
      case "hand_on":
        level.player playRumbleOnEntity("damage_light");
        break;
      case "push_start":
        var0.intensity = 0.2;
        break;
      case "push_end":
        var0.intensity = 0;
        break;
      case "hand_grab":
        level.player playRumbleOnEntity("damage_heavy");
        var0 thread scripts\engine\sp\utility::rumble_ramp_to(0.6, 2.1);
        var0 scripts\engine\utility::delaycall(2.2, &delete);
        return;
      default:
        break;
    }
  }
}

function on_terry_death(var0) {
  scripts\engine\utility::flag_wait("price_intro_terry_shot");

  foreach(var2 in getaiarray()) {
    if(var2 == var0) {
      continue;
    }

    if(scripts\engine\utility::is_equal(var2.team, "axis") || scripts\engine\utility::is_equal(var2.asmname, "civilian")) {
      var2 delete();
    }
  }

  thread scripts\sp\utility::delete_live_grenades();
}

function price_intro_fov(var0) {
  level.player lerpfovscalefactor(0, 1);
  level.player scripts\engine\utility::delaycall(var0, &lerpfovscalefactor, 1, 1);
  level.player modifybasefov(60, 1);
  level.player scripts\engine\utility::delaycall(var0, &modifybasefov, 65, 1);
}

function set_friendname(var0, var1) {
  self.script_friendname = var0;
  self.name = self.script_friendname;

  if(isDefined(var1)) {
    self.script_callsign = var1;
    self.callsign = self.script_callsign;
    return;
  }
}

function price_intro_lighting() {
  if(level.start_point == "price_intro") {
    waitframe();
  }

  var0 = getEntArray("price_intro_on", "targetname");
  var1 = getEntArray("price_intro_off", "targetname");

  foreach(var3 in var0) {
    var3 setlightintensity(var3.og_intensity);
  }

  foreach(var3 in var1) {
    var3 setlightintensity(0);
  }
}

function spawn_spec_intro_actors(var0) {
  var1 = scripts\sp\maps\piccadilly\piccadilly_util::spawn_price();
  thread delay_for_clip();
  playworldsound("scn_piccadilly_price_intro_vehicle", (420, -226, 179));
  var1.script_pushable = 0;
  var2 = ["sas1", "sas2", "sas3"];

  foreach(var4 in var2) {
    var1 = scripts\sp\maps\piccadilly\piccadilly_util::spawn_price_redshirt();
    thread delete_after_anim();
    var1.animname = var4;
    var0.actors[var0.actors.size] = var1;
    waitframe();
  }
}

function delay_for_clip() {
  wait 22;
  thread price_clip();
}

function price_clip() {
  self.followclip = scripts\engine\utility::spawn_script_origin(level.price.origin, level.price.angles);
  self.followclip setModel("tag_origin");
  self.followclip.clip = getEnt("price_clip", "targetname");
  self.followclip linkTo(self, "tag_origin", (20, 0, 35), (0, -30, 0));
  self.followclip.clip linkTo(self.followclip, "tag_origin", (0, 0, 0), (0, 0, 0));
  self waittill("start_anim_single");
  wait 1.4;
  self.followclip rotatebylinked((0, -45, 0), 0.4);
}

function die_after_anim() {
  self waittillmatch("single anim", "end");
  self.a.nodeath = 1;
  self.allowdeath = 1;
  scripts\engine\sp\utility::die();
}

function delete_after_anim() {
  self waittillmatch("single anim", "end");

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  self delete();
}

function func_after_anim(var0) {
  self waittillmatch("single anim", "end");
  self[[var0]]();
  thread player_speed_management_ending("start_end_anims");
}

function scripted_movement(var0, var1) {
  self endon("stop_scripted_movement");

  if(isDefined(var1) && var1) {
    self forceteleport(var0.origin, var0.angles);
  }

  self.post_wait_func = &scripted_movement_post_wait;
  scripts\sp\spawner::go_to_node(var0, &scripted_movement_arrival);
}

function scripted_movement_post_wait() {
  if(isDefined(self.scripted_movement_idle)) {
    self.scripted_animnode notify("stop_" + self.scripted_anime + "_idle_" + self.animname);
    return;
  }
}

function scripted_movement_arrival(var0) {
  if(isDefined(self.scripted_movement_idle)) {
    self.scripted_animnode notify("stop_" + self.scripted_anime + "_idle_" + self.animname);
  }

  if(isDefined(var0.script_ent_flag_set)) {
    scripts\engine\utility::ent_flag_set(var0.script_ent_flag_set);
  }

  if(isDefined(var0.script_flag_set)) {
    scripts\engine\utility::flag_set(var0.script_flag_set);
  }

  if(isDefined(var0.animation)) {
    script_movement_anim(var0);
    return;
  }
}

function script_movement_anim(var0) {
  var1 = var0.animation;
  var0.origin = scripts\engine\utility::drop_to_ground(var0.origin, 10, -100);
  var2 = var0;
  var3 = 0;

  if(isDefined(var0.script_parameters)) {
    if(var0.script_parameters == "no_anim_reach") {
      var3 = 1;
    }
  }

  if(isDefined(var0.script_animnode)) {
    var2 = scripts\engine\utility::getStruct(var0.script_animnode, "targetname");
  }

  var4 = 0;

  if(isDefined(level.scr_anim["generic"][var1])) {
    var4 = 1;
  }

  if(!var3) {
    self notify("start_anim_reach");

    if(var4) {
      var2 scripts\sp\anim::anim_generic_reach(self, var1);
    } else {
      var2 scripts\sp\anim::anim_reach_solo(self, var1);
    }
  }

  self.scripted_movement_idle = undefined;
  self.scripted_anime = undefined;
  self.scripted_animnode = undefined;
  self notify("start_anim_single");

  if(var4) {
    var2 thread scripts\common\anim::anim_generic(self, var1);
  } else {
    var2 thread scripts\common\anim::anim_single_solo(self, var1);
  }

  if(isDefined(var0.script_type)) {
    if(var0.script_type == "anim_wait") {
      self waittillmatch("single anim", "end");
      return;
    }

    return;
  }
}