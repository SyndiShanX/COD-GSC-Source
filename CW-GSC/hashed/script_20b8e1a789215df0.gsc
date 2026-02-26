/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_20b8e1a789215df0.gsc
***********************************************/

#using script_2d443451ce681a;
#using script_3919f386abede84;
#using script_3c70d86dfe255354;
#using script_3dc93ca9902a9cda;
#using script_4ab78e327b76395f;
#using script_4b6505921addc7bc;
#using script_549b1f81e7dfe241;
#using script_708fc8496e63a128;
#using script_758226507b1afa11;
#using script_86ebb5dd573a003;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\event;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\flashback_tv;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace namespace_e6b6aea1;

function function_22b7fffd() {
  animation::add_notetrack_func("cp_ger_stakeout_apt::vo_edda_reaction", &function_63dd294e);
  animation::add_notetrack_func("cp_ger_stakeout_apt::vo_kraus_reaction", &function_27cda4ce);
}

function function_9de162de(str_objective) {
  level.apt_street_police = spawner::simple_spawn("apt_street_police");
  level thread namespace_11998b8f::function_91a7f501("apt_street_ambient_harass_loop", "apartment_2_done");
  level function_3141d875();
  level thread function_fb12384e();
  exploder::exploder("lgt_exp_target_building_01");
  level flag::set("flag_apt_near_front_door");
  level thread function_1610ce5e();
  level thread function_be8d91b2();
  player = getplayers()[0];
  player setmovespeedscale(0.5);
  player val::set("apartment", "allow_sprint", 0);
  windows::lock("apt_bedroom_window", "script_noteworthy");
  doors::close("tgt_apt_front_door");
  doors::lock("tgt_apt_front_door");
  getent("tgt_apt_front_door", "targetname").var_aff33935 = 0;
}

function function_b3837ddc(str_objective, var_50cc0d4f) {
  ai_array = getaiteamarray("axis");

  foreach(ai in ai_array) {
    if(isDefined(ai.script_noteworthy) && ai.script_noteworthy != "kraus" && ai.script_noteworthy != "wife" || !isDefined(ai.script_noteworthy)) {
      ai val::set("apartment", "ignoreall", 1);
      ai val::set("apartment", "ignoreme", 1);
    }
  }

  level thread function_7fc4cb95();
  level thread namespace_11998b8f::function_25120710();
  level thread function_d62ceccf();
  level thread function_c0a7c66();
  player = getplayers()[0];

  if(var_50cc0d4f) {
    level thread namespace_afd0968c::function_36a9bec7(var_50cc0d4f);
    level thread namespace_fba81a7f::function_3dfe810();

    level.player savegame::set_player_data(#"hash_58df9478d677bb38", 0);
  }

  namespace_5ceacc03::music("13.0_apartment");
  level flag::set("start_apartment_entry_lighting");
  exploder::exploder("lgt_exp_target_building_02");
  level thread function_af031d54();
  level thread function_963791c5();

  if(isDefined(level.stealth.disguised)) {
    player namespace_979752dc::set_disguised(0);
  }

  level thread function_328da7d3();
  level thread function_33e6dffe();
  level thread function_9cddf76d();
  level flag::wait_till("apartment_1_done");
  namespace_5ceacc03::music("14.0_find_briefcase");

  if(isDefined(level.apt_street_police)) {
    array::delete_all(level.apt_street_police);
  }

  skipto::function_4e3ab877(str_objective);
}

function function_9cddf76d() {
  thread namespace_3e1df757::function_b524c30d();
  level.var_3559e9e thread function_15c263da("front_door");
  level.var_49a292bb thread function_b66c66e("front_door");
  level thread namespace_c80e7f5f::function_84378e8a();
  level thread namespace_c80e7f5f::function_e1af55d1();
  level thread namespace_c80e7f5f::function_c60ce98d();
  level thread namespace_c80e7f5f::function_ba5c6b95();
  level thread namespace_c80e7f5f::function_6589b125();
  level thread function_3862e30();

  while(!isDefined(level.var_6c4b8850)) {
    waitframe(1);
  }

  level flag::wait_till("flag_close_front_door");
  doors::lock("tgt_apt_front_door", "targetname", 1);
}

function function_3141d875() {
  spawner::add_spawn_function_group("apartment_ai", "targetname", &function_9bd924c1);
  spawner::simple_spawn("apartment_ai");
}

function function_9bd924c1() {
  level.var_54b83d35 = struct::get("tag_align_target_apt_first_floor", "targetname");
  level.var_bd5c9b86 = struct::get("tag_align_target_apt_second_floor", "targetname");
  self ai::set_behavior_attribute("patrol", 1);
  self.var_c681e4c1 = 1;
  self.goalradius = 16;
  self.team = "axis";
  self.diequietly = 1;
  self val::set("apartment", "allowdeath", 1);
  self setCanDamage(1);
  self.health = 15;
  self stealth_event::event_entity_core_set_enabled(0);

  if(!level flag::get("apt_street_done")) {
    self val::set("electronics_store", "ignoreall", 1);
  }

  switch (self.script_noteworthy) {
    case # "kraus":
      level.var_49a292bb = self;
      self.animname = "kraus";
      self.var_22f5613a = 1;
      self.var_c5553760 = 1;
      self namespace_979752dc::function_57972217(0.34, 0.01);
      break;
    case # "wife":
      level.var_3559e9e = self;
      self.animname = "wife";
      self.var_22f5613a = 1;
      self.var_c5553760 = 1;
      self thread function_8be5093c();
      self namespace_979752dc::function_57972217(0.01, 0.01);
      self.fovcosinez = 0.7;
      break;
    default:
      break;
  }
}

function function_d62ceccf() {
  level.player endon(#"death");
  level.stealth.disguised = undefined;
  level.stealth.threatsightratescale = 2;
  level.stealth.threatsightdistscale = 1.5;
  level.stealth.proximity_combat_radius_bump = 60;
  level.stealth.proximity_combat_radius_sight = 120;
  level.stealth.proximity_combat_radius_fake_sight = 80;
  setsaveddvar(#"hash_12c53cd4a01caff3", 0.95);
  setsaveddvar(#"hash_5edb3c8437c5990e", cos(180));
  setsaveddvar(#"hash_30eedc859ec98ad", 0.025);
  setsaveddvar(#"hash_5aaea648688ff01e", 0.25);

  if(isDefined(level.var_49a292bb.stealth) && isDefined(level.var_49a292bb.stealth.threat_sight_state)) {
    level.var_49a292bb stealth_threat_sight::threat_sight_set_state_parameters();
  }

  if(isDefined(level.var_3559e9e.stealth) && isDefined(level.var_3559e9e.stealth.threat_sight_state)) {
    level.var_3559e9e stealth_threat_sight::threat_sight_set_state_parameters();
  }
}

function function_c0a7c66() {
  array[#"sight_dist"] = 2500;
  array[#"detect_dist"] = 800;
  array[#"found_dist"] = 800;
  namespace_cc4354b9::set_corpse_ranges(array);
}

function function_1610ce5e() {
  while(!isDefined(level.var_3559e9e)) {
    waitframe(1);
  }

  if(!isDefined(level.var_54b83d35)) {
    level.var_54b83d35 = struct::get("tag_align_target_apt_first_floor", "targetname");
  }

  if(!isDefined(level.var_bd5c9b86)) {
    level.var_bd5c9b86 = struct::get("tag_align_target_apt_second_floor", "targetname");
  }

  level.var_3559e9e animation::first_frame("z_stk_apt_front_door_entry_wife_answers_phone", level.var_54b83d35);
  kitchen_window_right_closed = getent("kitchen_window_right_closed", "targetname");
  kitchen_window_right_closed hide();
  kitchen_window_left_closed = getent("kitchen_window_left_closed", "targetname");
  kitchen_window_left_closed hide();
  level.var_49a292bb animation::last_frame("z_stk_surveillance_desk_kraus_exit", level.var_bd5c9b86);
}

function function_a6a7797f(a_ents) {
  level.var_7d6bf2d4 = a_ents[#"hash_475ee55621b83ca0"];
  level.var_6a64a507 = util::spawn_model("weapon_wm_m1911_composite");
  level.var_6a64a507 hidepart("j_mag2", "weapon_wm_m1911_composite");
  level.var_6a64a507 linkto(level.var_7d6bf2d4, "j_prop_1", (0, 0, 0), (0, 0, 270));
}

function function_fb12384e() {
  level.var_54b83d35 = struct::get("tag_align_target_apt_first_floor", "targetname");
  level.var_bd5c9b86 = struct::get("tag_align_target_apt_second_floor", "targetname");
  level.apt_couch_pillow = getent("apt_couch_pillow", "targetname");
  level.apt_couch_pillow.animname = "apt_pillow";
  level.apt_phone = getent("apt_phone", "targetname");
  level.apt_phone.animname = "apt_phone";
  level.apt_nightstand = getent("apt_nightstand", "targetname");
  level.apt_nightstand.animname = "apt_nightstand";
  level.apt_kettle = getent("apt_kettle", "targetname");
  level.apt_kettle.animname = "apt_kettle";
  level.apt_umbrella = getent("apt_umbrella", "targetname");
  level.apt_umbrella.animname = "apt_umbrella";
  scene::add_scene_func("aib_vign_stakeout_apt_kraus", &function_a6a7797f, "init");
  scene::add_scene_func("cin_stakeout_apt_bodycarry_pickup_apt_gl_exit", &function_7adcc91a, "done");
  level scene::init("aib_vign_stakeout_apt_wife");
  level scene::init("aib_vign_stakeout_apt_kraus");
  level scene::init("aib_vign_stakeout_apt_child");
  level scene::init("cin_stakeout_apt_bodycarry_pickup_apt_gl_exit");
  level.var_6c4b8850 = doors::function_73f09315("tgt_apt_front_door");
  level.var_89f4e16c = doors::function_73f09315("tgt_apt_master_bedroom_door");
  level.var_3cb475ae = doors::function_73f09315("tgt_apt_child_bedroom_door");
  level.var_78cfbe5a = doors::function_73f09315("apt_door_lower_bedroom");
  level.var_bb05e8f5 = getent("darkroom_hidden_door", "targetname");
  var_598a701b = struct::get("secret_door_pos", "targetname");
  level.var_bb05e8f5 moveto(var_598a701b.origin, 0.05, 0, 0);
  var_617f3755 = getent("secret_wall_panel", "targetname");
  var_ee7f9f95 = struct::get("secret_wall_panel_pos_01", "targetname");
  var_617f3755 moveto(var_ee7f9f95.origin, 0.05, 0, 0);
  level flag::wait_till("apartment_2_done");
  waitframe(1);

  if(isDefined(level.apt_couch_pillow)) {
    level.apt_couch_pillow delete();
  }

  if(isDefined(level.apt_phone)) {
    level.apt_phone delete();
  }

  waitframe(1);

  if(isDefined(level.apt_umbrella)) {
    level.apt_umbrella delete();
  }

  if(isDefined(level.var_c986705b)) {
    level.var_c986705b delete();
  }

  if(isDefined(level.apt_kettle)) {
    level.apt_kettle delete();
  }

  waitframe(1);

  if(isDefined(level.apt_nightstand)) {
    level.apt_nightstand delete();
  }

  if(isDefined(level.var_7d6bf2d4)) {
    level.var_7d6bf2d4 delete();
  }

  if(isDefined(level.var_6a64a507)) {
    level.var_6a64a507 delete();
  }

  waitframe(1);

  if(isDefined(level.var_f844521d)) {
    level.var_f844521d delete();
  }
}

function function_7fc4cb95() {
  kitchen_window_right_closed = getent("kitchen_window_right_closed", "targetname");
  kitchen_window_right_closed show();
  kitchen_window_left_closed = getent("kitchen_window_left_closed", "targetname");
  kitchen_window_left_closed show();
  kitchen_window_right_open = getent("kitchen_window_right_open", "targetname");
  kitchen_window_right_open delete();
  kitchen_window_left_open = getent("kitchen_window_left_open", "targetname");
  kitchen_window_left_open delete();
}

function function_7adcc91a(a_ents) {
  victim = a_ents[#"victim"];
  victim endon(#"death");
  level flag::wait_till("apartment_2_done");

  if(isDefined(victim)) {
    victim delete();
  }
}

function function_328da7d3() {
  videoprime("cp_ger_stakeout_apt_tv");
  e_vol = getent("vol_apt_upper_level", "targetname");
  returned = level flag::wait_till_any(array("flag_start_apt_tv", "flag_start_apt_tv_upper"));
  level.player thread namespace_78e9b80::function_15eaa2db(undefined, undefined, "flag_player_approached_flashback_TV", "flag_player_not_near_living_room", "flashback_tv_lookat", undefined, "lgt_exp_flashback_tv", #"hash_58df9478d677bb38", struct::get("flashback_tv_lookat"));

  if(returned._notify == "flag_start_apt_tv") {
    while(!level flag::get("flag_briefcase_found")) {
      videostart("cp_ger_stakeout_apt_tv", 1);

      while(!level.player istouching(e_vol)) {
        waitframe(1);
      }

      videostop("cp_ger_stakeout_apt_tv");

      while(level.player istouching(e_vol)) {
        waitframe(1);
      }
    }
  } else {
    while(!level flag::get("flag_briefcase_found")) {
      while(level.player istouching(e_vol)) {
        waitframe(1);
      }

      videostart("cp_ger_stakeout_apt_tv", 1);

      while(!level.player istouching(e_vol)) {
        waitframe(1);
      }

      videostop("cp_ger_stakeout_apt_tv");
    }
  }

  level flag::wait_till("flag_briefcase_found");
  videostop("cp_ger_stakeout_apt_tv");
}

function function_3862e30() {
  level flag::wait_till_any(array("flag_see_kraus_shadow_failsafe", "flag_see_kraus_shadow"));
  level flag::set("flag_kraus_is_upstairs");
  level.var_49a292bb thread function_4b86eb01();

  if(isDefined(level.var_3559e9e)) {
    level.var_3559e9e thread function_4fa71d38();
  }
}

function function_15c263da(var_763776e6) {
  level.var_3559e9e.var_66f1a336 = &function_a8ad2bdb;
  level.var_3559e9e.disableeasystealthheadshot = 1;
  self.var_b9c0ade5 = 1;
  self namespace_979752dc::set_event_override("investigate", &function_620b79a);
  self namespace_979752dc::set_event_override("cover_blown", &function_620b79a);
  self namespace_979752dc::set_event_override("combat", &function_620b79a);

  switch (var_763776e6) {
    case # "front_door":
      self thread function_13d3b6eb();
      break;
    case # "office_skip":
      self thread function_1709dcd();
      break;
    default:
      break;
  }
}

function function_620b79a(event) {
  if(isDefined(self.spotted)) {
    return false;
  }

  self.spotted = 1;
  self thread function_3cbcb275();
  return true;
}

function function_3cbcb275() {
  self endon(#"damage", #"death");
  level flag::set("edda_reacting");
  self notify(#"reacting");
  level notify(#"hash_205bf17f449d4088");
  level notify(#"hash_7676a54c41c55288");
  self val::set("apartment", "ignoreall", 1);
  self val::set("apartment", "ignoreme", 1);
  self dialogue::function_47b06180();
  self thread function_c243a96a();
  self thread function_bd346448();
  player = getplayers()[0];
  dirtoenemy = vectornormalize(player.origin - self.origin);
  forward = anglesToForward(self.angles);
  dot_fwd = vectordot(dirtoenemy, forward);
  right = anglestoright(self.angles);
  dot_right = vectordot(dirtoenemy, right);
  reaction = undefined;

  if(level flag::get("flag_wife_watching_tv")) {
    level scene::stop("aib_vign_stakeout_apt_wife");
    level thread scene::play("aib_vign_stakeout_apt_wife", "z_stk_apt_spot_player_on_couch_wife", self);
  } else {
    if(dot_fwd >= 0.7) {
      if(isDefined(self.a.movement) && (self.a.movement == "walk" || self.a.movement == "run")) {
        reaction = "walking_front";
      } else {
        reaction = "standing_front";
      }
    } else if(dot_fwd <= -0.7) {
      if(isDefined(self.a.movement) && (self.a.movement == "walk" || self.a.movement == "run")) {
        reaction = "walking_behind";
      } else {
        reaction = "standing_behind";
      }
    } else if(dot_right <= -0.7) {
      if(isDefined(self.a.movement) && (self.a.movement == "walk" || self.a.movement == "run")) {
        reaction = "walking_left";
      } else {
        reaction = "standing_left";
      }
    } else if(isDefined(self.a.movement) && (self.a.movement == "walk" || self.a.movement == "run")) {
      reaction = "walking_right";
    } else {
      reaction = "standing_right";
    }

    if(isDefined(reaction)) {
      level thread scene::stop("aib_vign_stakeout_apt_wife");
      level thread scene::stop("aib_vign_stakeout_safehouse_surveillance_wife");

      if(level flag::get("flag_wife_on_phone")) {
        var_3dd2d06b = getent("apt_phone", "targetname");
        level thread scene::play("aib_vign_stakeout_apt_wife", "react_phone_drop");

        if(reaction == "standing_behind") {
          if(dot_right <= 0) {
            reaction = "standing_left";
          } else {
            reaction = "standing_right";
          }
        }
      }

      level flag::clear("flag_wife_on_phone");
      self ai::look_at(player, 0, undefined, 0, 0, undefined, 1);
      self thread scene::play("aib_vign_stakeout_apt_wife_reacts", "z_stk_apt_spot_player_" + reaction + "_wife", self);
    } else {
      assertmsg("<dev string:x38>");
    }
  }

  self waittill(#"react_vo");
  level thread function_1de222fe();
}

function function_63dd294e(params) {
  level.var_3559e9e endon(#"hash_2a34667d783e7701");
  level.var_3559e9e thread vo_stop();
  vo_array = array("vox_cp_stkt_11400_edda_who_56", "vox_cp_stkt_11400_edda_scream_5b");
  vo = array::random(vo_array);
  level.var_3559e9e thread dialogue::queue(vo);
  level.var_3559e9e waittill(#"react_vo");
  vo_array = array("vox_cp_stkt_11400_edda_franzhelp_17", "vox_cp_stkt_11400_edda_franz_22", "vox_cp_stkt_11400_edda_help_4a");
  vo = array::random(vo_array);
  level.var_3559e9e dialogue::queue(vo);
}

function vo_stop() {
  self waittill(#"damage", #"death");
  self notify(#"hash_2a34667d783e7701");
  self dialogue::function_47b06180();
}

function function_1de222fe() {
  if(!level flag::get("flag_wife_is_darted")) {
    util::missionfailedwrapper(#"hash_4c5af5a1cd80371", #"hash_253c3de152942bc4");
  }
}

function function_13d3b6eb() {
  self endon(#"damage", #"death", #"dart_gunned", #"reacting");
  level flag::wait_till("flag_1st_entry_front_door");
  level scene::stop("aib_vign_stakeout_safehouse_surveillance_wife");
  level thread scene::play("aib_vign_stakeout_apt_wife", "wife_phone_front_door_answer", self);
  self thread namespace_c80e7f5f::function_74581093();
  self flag::wait_till_clear(#"scriptedanim");
  self thread function_a769d1d();
}

function function_a769d1d() {
  self notify("2affe8e98bdd1e8");
  self endon("2affe8e98bdd1e8");
  self endon(#"damage", #"death", #"dart_gunned", #"reacting");
  self.skipdeathanim = 1;
  flag_return = level flag::wait_till_any(array("flag_wife_phone_fidget", "flag_apt_wife_phone_call_done", "flag_edda_umbrella"));

  if(flag_return._notify == "flag_wife_phone_fidget") {
    if(isalive(self) && !level flag::get("flag_edda_umbrella")) {
      level thread scene::play("aib_vign_stakeout_apt_wife", "wife_phone_fidget", self);
    }

    level flag::wait_till_any(array("flag_apt_wife_phone_call_done", "flag_edda_umbrella"));
  }

  if(isalive(self)) {
    level scene::play("aib_vign_stakeout_apt_wife", "wife_phone_exit", self);
  }

  self.skipdeathanim = 0;
  level notify(#"hash_21e8502431806421");

  if(!level flag::get("flag_edda_umbrella")) {
    self thread function_d6da2ce5();
  }
}

function function_d6da2ce5() {
  self notify("fd6f74d5cdc0eea");
  self endon("fd6f74d5cdc0eea");
  self endon(#"damage", #"death", #"dart_gunned", #"reacting");
  level endon(#"flag_edda_umbrella");
  self.goalradius = 32;
  level scene::play("aib_vign_stakeout_apt_wife", "fix_tea_start", self);
  level thread dialogue::radio("vox_cp_stkt_11250_park_watchoutthewife_5e");
  level thread scene::play("aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_apt_1st_floor_watch_tv_wife_enter", self);
  level flag::wait_till("flag_wife_watching_tv");
  level thread flag::delay_set(5, "flag_kettle_can_whistle");
  level flag::wait_till("flag_kitchen_kettle");

  if(isDefined(level.apt_kettle)) {
    exploder::exploder("fx_exp_apt_kettle_steam");
    thread namespace_5ceacc03::function_e61f9ef4();
    level thread function_bdce9e8f();
  }

  wait 3;
  level scene::play("aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_apt_1st_floor_watch_tv_wife_exit", self);
  level thread dialogue::radio("vox_cp_stkt_11250_park_thewifeiscoming_13");
  level scene::play("aib_vign_stakeout_apt_wife", "fix_tea_finish", self);
  level thread scene::play("aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_apt_1st_floor_watch_tv_wife_enter", self);
}

function function_1709dcd() {
  level thread scene::play("aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_apt_1st_floor_watch_tv_wife_loop", level.var_3559e9e);
  level flag::set("flag_wife_watching_tv");
}

function function_bdce9e8f() {
  level waittill(#"hash_5450898ce50a75ea");

  if(isDefined(level.apt_kettle)) {
    exploder::stop_exploder("fx_exp_apt_kettle_steam");
  }
}

function function_8be5093c() {
  level endon(#"apartment_2_done");
  self waittill(#"death");
  wait 0.25;

  if(level flag::get("flag_wife_is_darted")) {
    return;
  }

  wait 2;
  util::missionfailedwrapper(#"hash_4c5af5a1cd80371", #"hash_1dd066257b842378");
}

function function_a8ad2bdb() {
  player = getplayers()[0];
  player endon(#"death");

  if(level flag::get("flag_wife_is_darted")) {
    return;
  }

  level flag::set("flag_wife_is_darted");
  self val::set("edda_tranq", "magic_bullet_shield", 1);
  self setCanDamage(0);
  level callback::function_30c3f95d(&function_92d5be3e);
  objectives::function_4eb5c04a(#"hash_410487ffcf0fdc58", (0, 0, 0));
  objectives::hide(#"hash_410487ffcf0fdc58");
  objectives_ui::function_49dec5b(#"hash_410487ffcf0fdc58", undefined, #"hash_6e3be33918521155");

  if(isDefined(level.var_3559e9e)) {
    level.var_3559e9e dialogue::function_47b06180();
  }

  namespace_5ceacc03::music("13.0_apartment_stinger");
  player notify(#"hash_255ac7580395ed51");
  self ai::function_603b970a();
  self thread function_c243a96a();
  self thread function_bd346448();
  self thread function_c0bfecc7();
  level notify(#"hash_205bf17f449d4088");
  level notify(#"hash_7676a54c41c55288");
  self notify(#"darted");
  self val::set("apartment", "ignoreall", 1);
  self val::set("apartment", "ignoreme", 1);
  level thread function_d131ba5d();

  if(!level flag::get("edda_reacting")) {
    level scene::stop("aib_vign_stakeout_apt_wife");
    level scene::stop("aib_vign_stakeout_safehouse_surveillance_wife");
  } else {
    self animation::stop();
  }

  if(level flag::get("flag_wife_on_phone")) {
    var_3dd2d06b = getent("apt_phone", "targetname");
    self.a.nodeath = 1;
    getplayers()[0] namespace_5f6e61d9::function_694887dc("cin_stakeout_apt_bodycarry_pickup_apt_gl_start");
    self thread scene::play("aib_vign_stakeout_apt_wife", "wife_phone_tranq", self);
    self waittill(#"death");
    self ai::set_corpse_entity(undefined);
  } else if(level flag::get("flag_wife_watching_tv")) {
    self.a.nodeath = 1;
    self thread scene::play("aib_vign_stakeout_apt_wife", "wife_couch_tranq", self);
    self waittill(#"death");
    self ai::set_corpse_entity(undefined);
  } else {
    vol = getent("vol_kitchen_doorway", "targetname");
    reaction = undefined;

    if(self istouching(vol)) {
      if(math::cointoss()) {
        reaction = "front_01";
      } else {
        reaction = "front_02";
      }

      if(level flag::get("edda_reacting")) {
        vol = getent("vol_kitchen_table", "targetname");

        if(player istouching(vol)) {
          reaction = self function_cd1af5d1();

          if(reaction == "front_01" || reaction == "front_02") {
            if(math::cointoss()) {
              reaction = "back_01";
            } else {
              reaction = "back_02";
            }
          }
        }
      }
    } else {
      reaction = self function_cd1af5d1();
    }

    self thread scene::play("scene_z_stk_apt_dart_deaths", reaction, self);
    self waittill(#"death");
    self ai::set_corpse_entity(undefined);
  }

  level flag::set("flag_edda_is_corpse");
  level thread function_811c81e6();
}

function function_cd1af5d1() {
  player = getplayers()[0];
  dirtoenemy = vectornormalize(player.origin - self.origin);
  forward = anglesToForward(self.angles);
  dot_fwd = vectordot(dirtoenemy, forward);
  right = anglestoright(self.angles);
  dot_right = vectordot(dirtoenemy, right);
  var_b6edd7ce = undefined;
  var_11fc6443 = undefined;
  var_20be01c6 = undefined;

  if(dot_fwd >= 0.7) {
    if(math::cointoss()) {
      reaction = "front_01";
    } else {
      reaction = "front_02";
    }

    var_b6edd7ce = anglesToForward(self.angles) * -96;
    var_11fc6443 = anglesToForward(self.angles + (0, 10, 0)) * -96;
    var_20be01c6 = anglesToForward(self.angles + (0, -10, 0)) * -96;
    var_1725375c = bullettracepassed(self.origin + (0, 0, 20), self.origin + var_b6edd7ce + (0, 0, 20), 0, self);
    var_57693ff = bullettracepassed(self.origin + (0, 0, 20), self.origin + var_11fc6443 + (0, 0, 20), 0, self);
    var_16f63702 = bullettracepassed(self.origin + (0, 0, 20), self.origin + var_20be01c6 + (0, 0, 20), 0, self);

    if(!var_1725375c && !var_57693ff && !var_16f63702) {
      if(math::cointoss()) {
        reaction = "back_01";
      } else {
        reaction = "back_02";
      }
    }
  } else if(dot_fwd <= -0.7) {
    if(math::cointoss()) {
      reaction = "back_01";
    } else {
      reaction = "back_02";
    }

    var_b6edd7ce = anglesToForward(self.angles) * 96;
    var_11fc6443 = anglesToForward(self.angles + (0, 10, 0)) * 96;
    var_20be01c6 = anglesToForward(self.angles + (0, -10, 0)) * 96;
    var_1725375c = bullettracepassed(self.origin + (0, 0, 20), self.origin + var_b6edd7ce + (0, 0, 20), 0, self);
    var_57693ff = bullettracepassed(self.origin + (0, 0, 20), self.origin + var_11fc6443 + (0, 0, 20), 0, self);
    var_16f63702 = bullettracepassed(self.origin + (0, 0, 20), self.origin + var_20be01c6 + (0, 0, 20), 0, self);

    if(!var_1725375c && !var_57693ff && !var_16f63702) {
      if(math::cointoss()) {
        reaction = "front_01";
      } else {
        reaction = "front_02";
      }
    }
  } else if(dot_right <= -0.7) {
    if(math::cointoss()) {
      reaction = "left_01";
    } else {
      reaction = "left_02";
    }

    var_b6edd7ce = anglestoright(self.angles) * 96;
    var_11fc6443 = anglestoright(self.angles + (0, 10, 0)) * 96;
    var_20be01c6 = anglestoright(self.angles + (0, -10, 0)) * 96;
    var_1725375c = bullettracepassed(self.origin + (0, 0, 20), self.origin + var_b6edd7ce + (0, 0, 20), 0, self);
    var_57693ff = bullettracepassed(self.origin + (0, 0, 20), self.origin + var_11fc6443 + (0, 0, 20), 0, self);
    var_16f63702 = bullettracepassed(self.origin + (0, 0, 20), self.origin + var_20be01c6 + (0, 0, 20), 0, self);

    if(!var_1725375c && !var_57693ff && !var_16f63702) {
      if(math::cointoss()) {
        reaction = "right_01";
      } else {
        reaction = "right_02";
      }
    }
  } else {
    if(math::cointoss()) {
      reaction = "right_01";
    } else {
      reaction = "right_02";
    }

    var_b6edd7ce = anglestoright(self.angles) * -96;
    var_11fc6443 = anglestoright(self.angles + (0, 10, 0)) * -96;
    var_20be01c6 = anglestoright(self.angles + (0, -10, 0)) * -96;
    var_1725375c = bullettracepassed(self.origin + (0, 0, 20), self.origin + var_b6edd7ce + (0, 0, 20), 0, self);
    var_57693ff = bullettracepassed(self.origin + (0, 0, 20), self.origin + var_11fc6443 + (0, 0, 20), 0, self);
    var_16f63702 = bullettracepassed(self.origin + (0, 0, 20), self.origin + var_20be01c6 + (0, 0, 20), 0, self);

    if(!var_1725375c && !var_57693ff && !var_16f63702) {
      if(math::cointoss()) {
        reaction = "left_01";
      } else {
        reaction = "left_02";
      }
    }
  }

  line(self.origin + (0, 0, 20), self.origin + var_b6edd7ce + (0, 0, 20), (0, 1, 1), undefined, undefined, 50);
  line(self.origin + (0, 0, 20), self.origin + var_11fc6443 + (0, 0, 20), (0, 1, 1), undefined, undefined, 50);
  line(self.origin + (0, 0, 20), self.origin + var_20be01c6 + (0, 0, 20), (0, 1, 1), undefined, undefined, 50);

  return reaction;
}

function function_92d5be3e(params) {
  self endon(#"death");
  self waittill(#"hash_3da14a3508f6e057");
  var_edd3f2ea = undefined;
  var_393b6e18 = self prompts::function_334e020();
  self prompts::set_objective(#"hash_410487ffcf0fdc58");

  while(var_393b6e18 !== var_edd3f2ea) {
    objectives::update_position(#"hash_410487ffcf0fdc58", self prompts::function_334e020());
    var_edd3f2ea = var_393b6e18;
    waitframe(1);
    var_393b6e18 = self prompts::function_334e020();
  }

  objectives::show(#"hash_410487ffcf0fdc58");
}

function function_811c81e6() {
  level endon(#"apartment_2_done");
  player = getplayers()[0];
  player endon(#"death");
  player flag::wait_till("body_pickup");
  waitframe(1);
  player namespace_5f6e61d9::function_461dbe2a();
  var_a37c27f3 = struct::get("wife_body_drop_pos", "targetname");
  var_a37c27f3 util::create_cursor_hint(undefined, undefined, #"hash_6e3be33918521155", 56, undefined, undefined, undefined, 112);
  var_a37c27f3 prompts::function_3171730f(#"use", #"body_carry");
  var_a37c27f3 prompts::set_objective(#"hash_410487ffcf0fdc58");
  objectives::update_position(#"hash_410487ffcf0fdc58", var_a37c27f3.origin);
  var_a37c27f3 thread function_c4139f80();
  var_a37c27f3 thread function_97be6108();
}

function function_c4139f80() {
  player = getplayers()[0];
  player endon(#"death");
  level endon(#"apartment_2_done");
  self notify("529bd23744ff8c89");
  self endon("529bd23744ff8c89");
  self waittill(#"trigger");
  var_aa8b96f8 = struct::get("tag_align_wife_body_drop", "targetname");
  player namespace_5f6e61d9::function_d0cb2574("cin_stakeout_apt_bodycarry_pickup_apt_gl_exit", var_aa8b96f8);
  player namespace_5f6e61d9::function_145a8b5a(0);
  player notify(#"hash_4dff86580406a1af");
  self util::remove_cursor_hint();
  objectives::remove(#"hash_410487ffcf0fdc58");
  level callback::function_95ba5345(&function_92d5be3e);
  level flag::set("flag_wife_placed_on_couch");
  player.var_9ebbaa46.var_7e5a6cf9 = 1;
  player waittill(#"hash_51c6ae96a7e40432");
  player.var_9ebbaa46.var_7e5a6cf9 = undefined;
  player namespace_5f6e61d9::function_b5b485f1();
}

function function_97be6108() {
  player = getplayers()[0];
  level endon(#"flag_wife_placed_on_couch", #"apartment_2_done");
  player endon(#"death");

  while(true) {
    while(player namespace_5f6e61d9::function_cad84e26()) {
      waitframe(1);
    }

    objectives::hide(#"hash_410487ffcf0fdc58");
    util::wait_network_frame();
    level flag::set("flag_wife_dropped_on_floor");
    self prompts::function_86eedc();
    player flag::wait_till("body_pickup");
    objectives::update_position(#"hash_410487ffcf0fdc58", self.origin);

    while(!player namespace_5f6e61d9::function_cad84e26()) {
      waitframe(1);
    }

    objectives::show(#"hash_410487ffcf0fdc58");
    level flag::clear("flag_wife_dropped_on_floor");
    self prompts::function_d675f5a4();
  }
}

function function_d131ba5d() {
  player = getplayers()[0];
  player endon(#"death");
  level endon(#"flag_wife_placed_on_couch", #"apartment_2_done");
  vol = getent("couch_vol", "targetname");

  while(true) {
    while(!player istouching(vol)) {
      waitframe(1);
    }

    player namespace_5f6e61d9::function_145a8b5a(1);

    while(player istouching(vol)) {
      waitframe(1);
    }

    player namespace_5f6e61d9::function_145a8b5a(0);
  }
}

function function_c0bfecc7() {
  player = getplayers()[0];
  player endon(#"death");

  while(!player namespace_5f6e61d9::function_cad84e26()) {
    waitframe(1);
  }

  level flag::set("flag_activate_kraus_shadow_trigger");
}

function function_4fa71d38() {
  self endon(#"damage", #"death", #"reacting");
  level endon(#"flag_wife_is_darted");

  if(level flag::get("flag_wife_is_darted")) {
    return;
  }

  self.goalradius = 32;
  level flag::set("flag_edda_umbrella");
  self dialogue::function_47b06180();
  self thread namespace_c80e7f5f::function_b2659110();

  if(level flag::get("flag_wife_watching_tv")) {
    level scene::stop("aib_vign_stakeout_safehouse_surveillance_wife");
    level scene::play("aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_apt_1st_floor_watch_tv_wife_exit", self);
  } else if(level flag::get("flag_wife_on_phone")) {
    level waittill(#"hash_21e8502431806421");
  } else {
    if(level flag::get("flag_edda_holding_kettle")) {
      level flag::wait_till_clear("flag_edda_holding_kettle");
    }

    level scene::stop("aib_vign_stakeout_apt_wife");
  }

  goal = struct::get("goal_edda_umbrella_pickup", "targetname");
  self setgoal(goal.origin, 1);
  self waittill(#"goal");
  level thread function_bdcd69b8();
  level scene::play("aib_vign_stakeout_apt_wife", "1st_floor_deliver_umbrella", self);

  if(level flag::get("flag_kraus_in_lower_hall")) {
    goal = spawn_tag_origin();
    self setgoal(goal.origin, 1);
    level flag::wait_till_clear("flag_kraus_in_lower_hall");
  }

  level thread scene::play("aib_vign_stakeout_safehouse_surveillance_wife", "z_stk_apt_1st_floor_watch_tv_wife_enter", self);
}

function function_bdcd69b8() {
  level endon(#"flag_edda_holding_umbrella");
  level flag::wait_till("flag_wife_is_darted");
  level.apt_umbrella animation::stop();
}

function function_bd346448() {
  if(level flag::get("flag_edda_holding_umbrella")) {
    level.apt_umbrella animation::stop();
    waitframe(1);
    level.apt_umbrella physicslaunch(level.apt_umbrella.origin + (0, 0, -4), (1, 1, -4));
  }
}

function function_c243a96a() {
  if(level flag::get("flag_edda_holding_kettle")) {
    level.apt_kettle animation::stop();
    level.apt_kettle physicslaunch(level.apt_kettle.origin + (0, 0, -4), (2, -2, 4));
  }
}

function function_b66c66e(var_763776e6) {
  while(!isDefined(self)) {
    waitframe(1);
  }

  self.var_66f1a336 = &function_8a91f60c;
  self namespace_979752dc::set_event_override("investigate", &function_19acc1c0);
  self namespace_979752dc::set_event_override("cover_blown", &function_19acc1c0);
  self namespace_979752dc::set_event_override("combat", &function_19acc1c0);
  self removesentienteventlistener("silenced_shot");
  self thread function_73f8fadd();
  self thread function_3b4254ca();

  switch (var_763776e6) {
    case # "front_door":
      break;
    case # "office_skip":
      self thread function_6bae0a9();
      break;
    default:
      break;
  }
}

function function_4b86eb01() {
  self endon(#"death", #"kraus_spotted_player");
  level thread function_aa936112();
  level thread function_b9c20732();
  returned = level flag::wait_till_any(array("flag_see_kraus_shadow", "flag_see_kraus_shadow_failsafe"));

  if(returned._notify == "flag_see_kraus_shadow") {
    level scene::play_from_time("aib_vign_stakeout_apt_kraus", "z_stk_apt_2nd_floor_call_down_to_wife_target", self, 5, 0, 1);
  } else {
    level scene::play_from_time("aib_vign_stakeout_apt_kraus", "z_stk_apt_2nd_floor_call_down_to_wife_target", self, 5.5, 0, 1);
  }

  if(!level flag::get("flag_apt_upstairs")) {
    level flag::set("flag_kraus_going_in_office");
    goal = struct::get("goal_kraus_enter_office", "targetname");
    self.goalradius = 24;
    self setgoal(goal.origin, 1);
    self waittill(#"goal");
    level thread scene::play("aib_vign_stakeout_apt_kraus", "z_stk_apt_2nd_floor_office_target_enter", self);
    level flag::wait_till("flag_apt_upstairs");
    level thread scene::stop("aib_vign_stakeout_apt_kraus");
  }

  level thread namespace_c80e7f5f::function_70af88ce();

  if(level flag::get("flag_kraus_going_in_office")) {
    level scene::play("aib_vign_stakeout_apt_kraus", "z_stk_apt_2nd_floor_office_exit", self);
  }

  goal = struct::get("goal_kraus_exit_office", "targetname");
  self.goalradius = 36;
  self setgoal(goal.origin, 1);
  self waittill(#"goal");
  level scene::play("aib_vign_stakeout_apt_kraus", "z_stk_apt_walk_down_stairs_target", self);
  level notify(#"hash_341edafabf8168e4");

  if(level flag::get("flag_wife_is_darted") && level flag::get("flag_wife_placed_on_couch")) {
    self thread namespace_c80e7f5f::function_952d90b5();
    level scene::play("aib_vign_stakeout_apt_kraus", "z_stk_apt_check_on_wife_target", self);
  } else if(level flag::get("flag_wife_is_darted")) {
    level flag::set("flag_kraus_checking_living_room");
    self thread namespace_c80e7f5f::function_ed37b989();
    level scene::play("aib_vign_stakeout_apt_kraus", "z_stk_apt_check_on_wife_target", self);
    level flag::clear("flag_kraus_checking_living_room");
  } else if(level flag::get("flag_edda_in_hall")) {
    self scene::play("aib_vign_stakeout_apt_kraus", "z_stk_apt_walking_stall_target", self);
    self util::delay(4, "death", &dialogue::queue, "vox_cp_stkt_11225_krus_thankyoudear_89");
  }

  level flag::set("flag_kraus_in_lower_hall");
  self.goalradius = 16;
  self thread function_1f314257();

  if(!level.var_78cfbe5a doors::is_open()) {
    level.var_78cfbe5a.animname = "door";
    var_6deddb80 = struct::get("lower_bedroom_door", "targetname");
    var_6deddb80 scene::play(array(level.var_49a292bb, level.var_78cfbe5a));
  }

  level flag::set("flag_kraus_umbrella_done");
  trigger = getent("guest_room_failsafe_trigger", "targetname");
  self thread function_41ff2f97(trigger, "lower");
  level thread scene::play("aib_vign_stakeout_apt_kraus", "guest_room_enter", self);
  self waittill(#"hash_3fb228a70ee2ba7e");
  vol = getent("apt_downstairs_bedroom_vol", "targetname");

  if(getplayers()[0] istouching(vol)) {
    trig = getent("near_lower_bedroom_trigger", "targetname");
    trig delete();
  }

  level thread function_edf2504c();
}

function function_edf2504c() {
  level.var_49a292bb endon(#"death", #"kraus_spotted_player", #"hash_774b3e0c443d80dd");
  player = getplayers()[0];
  player endon(#"death");
  time = 0;
  max_time = 7;
  vol = getent("apt_downstairs_bedroom_vol", "targetname");

  while(time < max_time) {
    if(player istouching(vol)) {
      time += float(function_60d95f53()) / 1000;
    }

    waitframe(1);
  }

  level flag::set("flag_kraus_exit_bedroom");
}

function function_1f314257() {
  self endon(#"death", #"kraus_spotted_player", #"hash_774b3e0c443d80dd");
  self thread function_3d01b9fd();
  level flag::wait_till("flag_kraus_exit_bedroom");
  util::delay(3.5, "kraus_spotted_player", &dialogue::radio, "vox_cp_stkt_11325_park_bellavoidkrausa_a1");
  level scene::play("aib_vign_stakeout_apt_kraus", "guest_room_exit", self);

  if(isDefined(level.var_6a64a507)) {
    level.var_6a64a507 delete();
  }

  self.goalradius = 16;
  goal = struct::get("kraus_return_upstairs", "targetname");
  self setgoal(goal, 1);
  level flag::wait_till("flag_apt_kraus_back_upstairs");

  if(!level.var_89f4e16c doors::is_open()) {
    level.var_89f4e16c.animname = "door";
    waitframe(1);
    var_6deddb80 = struct::get("upper_bedroom_door", "targetname");
    var_6deddb80 scene::play(array(level.var_49a292bb, level.var_89f4e16c));
  }

  level thread scene::play("aib_vign_stakeout_apt_kraus", "master_bedroom_enter", self);
  self waittill(#"hash_5b9dfc1ea7e895c7");
  level flag::set("flag_kraus_on_bed");
  trigger = getent("master_bedroom_failsafe_trigger", "targetname");
  self thread function_41ff2f97(trigger, "upper");
}

function function_3d01b9fd() {
  level endon(#"hash_4717a055a4ba889e", #"hash_7538d0f49c08fc76");
  self endon(#"death", #"darted");
  self waittill(#"hash_21e9694b28caa6c4");
  level.var_6a64a507 hide();
  level notify(#"hash_5c3d7a6dbf4a8ddf");
}

function function_125f4d72() {
  level endon(#"hash_5c3d7a6dbf4a8ddf", #"flag_apt_kraus_back_upstairs");
  level flag::wait_till("flag_kraus_spotted_player");

  if(isDefined(level.var_6a64a507)) {
    level.var_6a64a507 animation::stop();
    waitframe(1);
    level.var_6a64a507 physicslaunch(level.var_6a64a507.origin + (0, 0, -4), (1, 1, -4));
  }
}

function function_6bae0a9() {
  level thread scene::play("aib_vign_stakeout_apt_kraus", "guest_room_loop", self);
  self thread function_1f314257();
  self val::reset("apartment", "ignoreall");
}

function function_73f8fadd() {
  self endon(#"death", #"kraus_spotted_player");
  level endon(#"hash_7538d0f49c08fc76");
  level endon(#"flag_wife_placed_on_couch");
  level flag::wait_till("flag_edda_is_corpse");
  var_11ecc9fe = 200704;
  corpse_origin = undefined;

  while(!level flag::get("kraus_found_corpse")) {
    var_5fff2a1e = ai::function_4f84c3ed(self.origin, 448);
    eye = self getEye();
    fwd = anglesToForward(self gettagangles("tag_eye"));
    dotlimit = 0.5;

    if(var_5fff2a1e.size > 0) {
      foreach(corpse in var_5fff2a1e) {
        corpse_origin = corpse namespace_979752dc::getcorpseorigin();
        delta = corpse_origin - eye;
        dir = vectornormalize(delta);
        vector_dot = vectordot(dir, fwd);
        dist = distance2dsquared(corpse_origin, eye);

        if(vector_dot > dotlimit && dist < var_11ecc9fe) {
          if(bullettracepassed(eye, corpse_origin + (0, 0, 8), 1, self, corpse)) {
            level flag::set("kraus_found_corpse");
          }
        }
      }
    }

    waitframe(1);
  }

  self notify(#"kraus_found_corpse");
  self thread function_aa4ca19c(corpse_origin);
  level flag::set("flag_kraus_spotted_player");
}

function function_8a91f60c() {
  self notify(#"darted");
  self thread vo_stop();
  self ai::function_603b970a();
  level flag::set("flag_kraus_spotted_player");

  if(level flag::get("flag_kraus_is_darted")) {
    return;
  }

  level flag::set("flag_kraus_is_darted");
  self val::set("apartment", "ignoreall", 1);
  self val::set("apartment", "ignoreme", 1);
  level scene::stop("aib_vign_stakeout_apt_kraus");
  reaction = self function_cd1af5d1();
  self dialogue::queue("vox_cp_stkt_11425_krus_what_bc");
  self thread scene::play("scene_z_stk_apt_dart_deaths", reaction, self);
  util::delay(3, undefined, &dialogue::radio, "vox_cp_stkt_11425_park_dammitweneededk_5d");
  self waittill(#"death");
}

function function_41ff2f97(trigger, position) {
  self notify(#"darted");
  level endon(#"hash_7538d0f49c08fc76", #"hash_4fd2220067d87773");
  self thread function_f24e0f31(trigger, position);
  level flag::wait_till("flag_behind_kraus");
  self thread function_aa4ca19c();
  level flag::set("flag_kraus_spotted_player");
}

function function_f24e0f31(trigger, position) {
  if(position == "lower") {
    if(!flag::exists("flag_kraus_kneeling")) {
      flag::wait_till("flag_kraus_kneeling");
    }

    level flag::wait_till_clear("flag_kraus_kneeling");
  } else if(position == "upper") {
    level flag::wait_till("apartment_explosive_placed");
  } else {
    return;
  }

  level notify(#"hash_4fd2220067d87773");

  if(isDefined(trigger)) {
    trigger delete();
  }
}

function function_19acc1c0(event) {
  if(isDefined(self.spotted)) {
    return false;
  }

  self.spotted = 1;
  self thread function_aa4ca19c();
  level flag::set("flag_kraus_spotted_player");
  return true;
}

function function_aa4ca19c(corpse_origin) {
  self endon(#"damage", #"death");
  self val::set("apartment", "ignoreall", 1);
  self val::set("apartment", "ignoreme", 1);
  self notify(#"kraus_spotted_player");
  player = getplayers()[0];
  self thread function_125f4d72();

  if(isDefined(corpse_origin)) {
    dirtoenemy = vectornormalize(corpse_origin - self.origin);
  } else {
    dirtoenemy = vectornormalize(getplayers()[0].origin - self.origin);
  }

  forward = anglesToForward(self.angles);
  dot_fwd = vectordot(dirtoenemy, forward);
  right = anglestoright(self.angles);
  dot_right = vectordot(dirtoenemy, right);
  reaction = undefined;
  level scene::stop("aib_vign_stakeout_apt_kraus");

  if(isDefined(corpse_origin)) {
    self thread scene::play("aib_vign_stakeout_apt_kraus_react", "z_stk_apt_spot_wife_target", self);
    wait 5;
    self notify(#"fail_mission");
    return;
  }

  if(level flag::get("kraus_stair_rail")) {
    align_tag = struct::get("kraus_stairwell_react", "targetname");
    self ai::look_at(player, 0, undefined, 0, 0, undefined, 1);
    align_tag thread scene::play_from_time("aib_vign_stakeout_apt_kraus_react", "z_stk_apt_spot_player_front_target", self, 1);
    wait 3.5;
    self notify(#"fail_mission");
    return;
  }

  if(level flag::get("flag_kraus_on_bed")) {
    level thread scene::play("aib_vign_stakeout_apt_kraus_react", "master_bedroom_spot_player", self);
    wait 1;
    self ai::look_at(player, 0, undefined, 0, 0, undefined, 1);
    wait 2.7;
    self notify(#"fail_mission");
    return;
  }

  if(level flag::get("flag_kraus_kneeling")) {
    level thread scene::play("aib_vign_stakeout_apt_kraus_react", "guest_room_spot_player", array(self, level.apt_nightstand, level.var_7d6bf2d4));
    wait 1;
    self ai::look_at(player, 0, undefined, 0, 0, undefined, 1);
    wait 5.5;
    self notify(#"fail_mission");
    return;
  }

  if(level flag::get("flag_kraus_at_nightstand")) {
    level thread scene::play_from_time("aib_vign_stakeout_apt_kraus_react", "guest_room_spot_player", array(self, level.apt_nightstand, level.var_7d6bf2d4), 2.3, 0);
    wait 1;
    self ai::look_at(player, 0, undefined, 0, 0, undefined, 1);
    wait 5.5;
    self notify(#"fail_mission");
    return;
  }

  if(level flag::get("flag_kraus_office_chair")) {
    level thread scene::play("aib_vign_stakeout_apt_kraus_react", "office_spot_player", self);
    wait 1;
    self ai::look_at(player, 0, undefined, 0, 0, undefined, 1);
    wait 1.5;
    self notify(#"fail_mission");
    return;
  }

  if(dot_fwd >= 0.7) {
    reaction = "front_target";
  } else if(dot_fwd <= -0.7) {
    reaction = "behind_target";
  } else if(dot_right <= -0.7) {
    reaction = "right_target";
  } else {
    reaction = "left_target";
  }

  if(isDefined(reaction)) {
    self ai::look_at(player, 0, undefined, 0, 0, undefined, 1);
    self thread scene::play("aib_vign_stakeout_apt_kraus_react", "z_stk_apt_spot_player_" + reaction, self);
  } else {
    assertmsg("<dev string:x76>");
  }

  wait 5;
  self notify(#"fail_mission");
}

function function_27cda4ce(params) {
  level.var_49a292bb endon(#"hash_2a34667d783e7701");
  level.var_49a292bb thread vo_stop();
  level.var_49a292bb dialogue::queue("vox_cp_stkt_11425_krus_what_bc");
  level.var_49a292bb waittill(#"react_vo");
  vo_array = array("vox_cp_stkt_11450_krus_whoareyou_42", "vox_cp_stkt_11450_krus_howdidyougetinh_56");
  vo = array::random(vo_array);
  level.var_49a292bb dialogue::queue(vo);
}

function function_3b4254ca() {
  level endon(#"hash_7538d0f49c08fc76");
  s_result = self waittill(#"fail_mission", #"death");
  wait 1;

  if(s_result._notify == "fail_mission") {
    util::missionfailedwrapper(#"hash_4c5af5a1cd80371", #"hash_4039ceec8d9c7c5e");
    return;
  }

  util::missionfailedwrapper(#"hash_4c5af5a1cd80371", #"hash_46ac7b0e0f9d53a");
}

function function_aa936112(skipto) {
  returned = level flag::wait_till_any(array("flag_see_kraus_shadow", "flag_see_kraus_shadow_failsafe"));
  level.child = spawner::simple_spawn_single("child");
  level.child val::set("apartment", "ignoreall", 1);
  level.child val::set("apartment", "ignoreme", 1);
  level.child.animname = "child";
  level.child.allowpain = 0;
  level.child val::set("apartment", "allowdeath", 0);
  level.child ai::gun_remove();

  if(!is_true(skipto)) {
    if(returned._notify == "flag_see_kraus_shadow") {
      level thread namespace_c80e7f5f::function_74866b7c("start_child_vo_delayed");
      level scene::play_from_time("aib_vign_stakeout_apt_child", "run_into_bathroom", level.child, 2.6, 0, 1);
    } else {
      level thread namespace_c80e7f5f::function_74866b7c("start_child_vo");
      level scene::play_from_time("aib_vign_stakeout_apt_child", "run_into_bathroom", level.child, 8.1, 0, 1);
    }
  } else {
    level scene::play_from_time("aib_vign_stakeout_apt_child", "run_into_bathroom", level.child, 0.97, 1, 1);
  }

  level thread scene::play("aib_vign_stakeout_apt_child", "z_stk_apt_gl_in_bathroom_kid", level.child);
}

function function_b9c20732() {
  level flag::wait_till("flag_apt_halfway_stairs");

  while(!isDefined(level.child)) {
    waitframe(1);
  }

  level.child thread dialogue::queue("vox_cp_stkt_11300_will_dadareyoucoming_e6");
  level flag::wait_till("flag_approaching_office");
  util::delay(2, undefined, &snd::play, "evt_stk_apt_toilet_flush", (1686, 4666, 396));
  level.child util::delay(3, undefined, &dialogue::queue, "vox_cp_stkt_11300_will_dadimalldone_46");
  util::delay(9, undefined, &snd::play, "evt_stk_apt_bathroom_water", (1686, 4666, 396));
}

function function_33e6dffe() {
  level endon(#"apartment_2_done");
  trigger::wait_till("apt_bathroom_door_trigger");
  level.child dialogue::queue("vox_cp_stkt_11475_will_scream_5b");
  wait 1;
  util::missionfailedwrapper(#"hash_4c5af5a1cd80371", #"hash_b4302157d22e1af");
}

function function_af031d54() {
  if(!isDefined(objectives::function_285e460(#"hash_6cee2d43ad1f55e6"))) {
    objectives::scripted(#"hash_6cee2d43ad1f55e6", undefined, #"hash_1133bb730a6dcbf0");
    apt_search_area = getent("apt_search_area", "targetname");
    objectives::area(#"hash_7ef23308971af956", apt_search_area, undefined, undefined, 0, 0, undefined, #"hash_b1305ea2f0825bd");
  }

  level flag::wait_till("flag_darkroom_light_on");
  objectives::complete(#"hash_6cee2d43ad1f55e6");
  objectives::complete(#"hash_7ef23308971af956");
  var_2474602c = struct::get("obj_apt_briefcase", "targetname");
  objectives::scripted(#"hash_3393f7c11063f28f", undefined, #"hash_277d3d1d1ea0a57b");
  objectives::goto(#"hash_3393f7c11063f28f", var_2474602c.origin, undefined, 0);
  level thread function_91bf4e4b();
  level flag::wait_till("apartment_explosive_placed");

  if(!isDefined(objectives::function_285e460(#"hash_6df0b8e86689a9f7"))) {
    objectives::scripted(#"hash_6df0b8e86689a9f7", undefined, #"hash_12b7bf71c03d97a9");
  }
}

function function_963791c5() {
  level thread function_933998a1();

  if(collectibles::function_ab921f3d(3)) {
    var_4ad0d08d = getEntArray("ledger", "targetname");
    array::delete_all(var_4ad0d08d);
    return;
  }

  var_a697899e = struct::get_array("potential_ledger_pos", "targetname");
  array::thread_all(var_a697899e, &function_d07f9e90);
  level thread function_2f24a62a();
}

function private function_933998a1() {
  self notify("3007137af76139a0");
  self endon("3007137af76139a0");

  while(true) {
    level waittill(#"save_restore");

    if(collectibles::function_ab921f3d(3)) {
      level notify(#"hash_39a52174f2055f52");
      var_4ad0d08d = getEntArray("ledger", "targetname");
      array::delete_all(var_4ad0d08d);
      var_a697899e = struct::get_array("potential_ledger_pos", "targetname");
      array::thread_all(var_a697899e, &util::remove_cursor_hint);
    }
  }
}

function function_2f24a62a() {
  level endon(#"hash_66dd1fb05a674d8f", #"hash_39a52174f2055f52");
  level flag::wait_till("flag_apt_ledger_found");
  snd::play("evt_ledger_pickup", level.player);
  collectibles::function_6cd091d2(3);
}

function function_91bf4e4b() {
  level flag::wait_till("apartment_explosive_placed");
  objectives::complete(#"hash_3393f7c11063f28f");
}

function function_d07f9e90() {
  level endon(#"hash_66dd1fb05a674d8f", #"hash_39a52174f2055f52");
  self util::create_cursor_hint(undefined, undefined, #"hash_2f5be718d91a4c1e", 70);
  self waittill(#"trigger");

  switch (self.script_parameters) {
    case # "hash_275dda2f7b704c76":
      self thread function_db844d6d();
      break;
    case # "hash_155ebc163a242dd6":
      self thread function_a971060e();
      break;
    case # "2f_bedroom_drawer":
      self thread function_a3233bf5();
      break;
    default:
      break;
  }

  level waittill(#"hash_6317f16a37432c3a");
  level flag::set("flag_apt_ledger_found");
  var_a697899e = struct::get_array("potential_ledger_pos", "targetname");
  array::thread_all(var_a697899e, &util::remove_cursor_hint);
  level.player playgestureviewmodel("ges_stk_intel_inspect_ledger");
  wait 0.4;
  var_4ad0d08d = getEntArray("ledger", "targetname");
  array::delete_all(var_4ad0d08d);
  level notify(#"hash_66dd1fb05a674d8f");
}

function function_db844d6d() {
  level endon(#"hash_66dd1fb05a674d8f", #"hash_39a52174f2055f52");
  door = getent(self.script_parameters, "targetname");
  var_af01916d = struct::get(door.target, "targetname");
  namespace_5ceacc03::function_c32bc34f();
  door moveto(var_af01916d.origin, 1, 0.5, 0.5);
  player = getplayers()[0];
  player playrumbleonentity(#"anim_med");
  wait 1.5;
  var_4ad0d08d = getEntArray("ledger", "targetname");

  if(!isDefined(var_4ad0d08d) || var_4ad0d08d.size == 0) {
    level notify(#"hash_66dd1fb05a674d8f");
    return;
  }

  ledger = undefined;

  foreach(book in var_4ad0d08d) {
    if(isDefined(book.script_noteworthy) && book.script_noteworthy == "vent") {
      ledger = book;
    }
  }

  ledger util::create_cursor_hint("tag_origin", (-4, 0, 0), #"hash_681addf148e5303");
  ledger collectibles::function_d06c5a39();
  ledger waittill(#"trigger");
  level notify(#"hash_6317f16a37432c3a");
}

function function_a971060e() {
  level endon(#"hash_66dd1fb05a674d8f", #"hash_39a52174f2055f52");
  drawer = getent("desk_office_drawer_01", "targetname");
  fwd = anglesToForward(drawer.angles);
  namespace_5ceacc03::function_a3c35c97();
  drawer moveto(drawer.origin + fwd * 10, 1, 0.5, 0.5);
  player = getplayers()[0];
  player playrumbleonentity(#"anim_med");
  wait 1.5;
  var_4ad0d08d = getEntArray("ledger", "targetname");

  if(!isDefined(var_4ad0d08d) || var_4ad0d08d.size == 0) {
    level notify(#"hash_66dd1fb05a674d8f");
    return;
  }

  ledger = undefined;

  foreach(book in var_4ad0d08d) {
    if(isDefined(book.script_noteworthy) && book.script_noteworthy == "office_drawer") {
      ledger = book;
    }
  }

  ledger util::create_cursor_hint("tag_origin", (0, 0, 4), #"hash_681addf148e5303");
  ledger collectibles::function_d06c5a39();
  ledger waittill(#"trigger");
  level notify(#"hash_6317f16a37432c3a");
}

function function_a3233bf5() {
  level endon(#"hash_66dd1fb05a674d8f", #"hash_39a52174f2055f52");
  drawer = getent("2f_bedroom_drawer", "targetname");
  fwd = anglestoright(drawer.angles);
  namespace_5ceacc03::bedroom_drawer();
  drawer moveto(drawer.origin + fwd * 10, 1, 0.5, 0.5);
  player = getplayers()[0];
  player playrumbleonentity(#"anim_med");
  wait 1.5;
  var_4ad0d08d = getEntArray("ledger", "targetname");

  if(!isDefined(var_4ad0d08d) || var_4ad0d08d.size == 0) {
    level notify(#"hash_66dd1fb05a674d8f");
    return;
  }

  ledger = undefined;

  foreach(book in var_4ad0d08d) {
    if(isDefined(book.script_noteworthy) && book.script_noteworthy == "bedroom_drawer") {
      ledger = book;
    }
  }

  var_aec0f4ff = struct::get(ledger.target, "targetname");
  var_aec0f4ff util::create_cursor_hint(undefined, undefined, #"hash_681addf148e5303");
  var_aec0f4ff collectibles::function_d06c5a39();
  var_aec0f4ff waittill(#"trigger");
  level notify(#"hash_6317f16a37432c3a");
}

function function_69c02b2b(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  level flag::set("flag_see_kraus_shadow_failsafe");
  level flag::set("flag_kraus_umbrella_done");
}

function function_2d6c81be(str_objective) {
  level thread function_fb12384e();
  exploder::exploder("lgt_exp_target_building_01");
  exploder::exploder("lgt_exp_target_building_02");
  level thread function_be8d91b2();
  level function_3141d875();
  level.var_3559e9e thread function_15c263da("office_skip");
  level.var_49a292bb thread function_b66c66e("office_skip");
  level thread namespace_11998b8f::function_91a7f501("apt_street_ambient_harass_loop", "apartment_2_done");
  level.var_54b83d35 = struct::get("tag_align_target_apt_first_floor", "targetname");
  level.var_bd5c9b86 = struct::get("tag_align_target_apt_second_floor", "targetname");
  player = getplayers()[0];
  player setmovespeedscale(0.5);
  player val::set("apartment", "allow_sprint", 0);
  level thread namespace_11998b8f::function_25120710();
  level thread function_963791c5();
  level thread function_aa936112(1);
  level thread function_33e6dffe();
  doors::close("tgt_apt_front_door");
  doors::lock("tgt_apt_front_door");
  getent("tgt_apt_front_door", "targetname").var_aff33935 = 0;
}

function function_34ee80b8(str_objective, var_50cc0d4f) {
  if(var_50cc0d4f) {
    namespace_5ceacc03::music("14.0_find_briefcase");
    level thread namespace_afd0968c::function_36a9bec7(var_50cc0d4f);
    level thread function_328da7d3();
    level thread namespace_fba81a7f::function_3dfe810();
  }

  level flag::set("start_plant_tracking_device_lighting");
  level thread namespace_c80e7f5f::function_96de90a7();
  level thread namespace_c80e7f5f::function_4b72e85();
  level util::delay(0.5, undefined, &darkroom_light_interact);
  level thread function_c8ac96b3();

  if(var_50cc0d4f) {
    level thread function_af031d54();
  }

  scene::add_scene_func("scene_z_stk_darkroom_knockout", &function_d92bcbb5, "init");
  level thread scene::init("scene_z_stk_darkroom_knockout");
  level flag::wait_till("flag_give_blacklight");

  for(player = getplayers()[0]; !isPlayer(player); player = getplayers()[0]) {
    waitframe(1);
  }

  player thread namespace_11998b8f::function_e8e2095b();
  level thread function_1a702184();
  level flag::wait_till("flag_briefcase_found");
  savegame::checkpoint_save();
  player thread namespace_11998b8f::function_e58f7713();
  level flag::wait_till("apartment_explosive_placed");
  level thread function_66b3680f();
  level.var_dca3174b dialogue::queue("vox_cp_stkt_11500_gret_help_aa");
  s_interact = struct::get("apt_darkroom_closet_interact", "targetname");
  s_interact util::create_cursor_hint(undefined, (0, 0, 0), #"hash_24b92cc9c8f3144e", 64);
  s_interact waittill(#"trigger");
  var_7f0c634d = struct::get("warehouse_intro_player_start", "targetname");
  util::delay(3, undefined, &util::create_streamer_hint, var_7f0c634d.origin, var_7f0c634d.angles, 1, 15);
  thread namespace_5ceacc03::function_9ca60c0();
  level thread function_8b571528();
  level thread scene::play("scene_z_stk_darkroom_knockout", "start");
  level waittill(#"start_fade");
  level thread util::screen_fade_out(2);
  clientfield::set("force_stream_warehouse", 1);
  level.var_dca3174b flag::wait_till_clear(#"scriptedanim");
  player = getplayers()[0];
  player val::set("apartment_to_warehouse", "freezecontrols", 1);
  level flag::set("apartment_2_done");
  level callback::function_95ba5345(&function_92d5be3e);
  objectives::remove(#"hash_6df0b8e86689a9f7");
  player util::blend_movespeedscale(1, 0.5);
  player val::reset("apartment", "allow_sprint");
  level.var_375ea1c1 = spawner::simple_spawn_single("warehouse_volkov");
  wait 0.5;
  s_teleport = struct::get("warehouse_intro_player_start", "targetname");
  player setorigin(s_teleport.origin);
  player setplayerangles(s_teleport.angles);
  level.player val::set("knock_out", "show_crosshair", 0);
  wait 5;
  skipto::function_4e3ab877(str_objective);
}

function function_8b571528() {
  level waittill(#"hash_2e3d4f4ea7cb4eb8");
  player = getplayers()[0];
  player playrumbleonentity(#"hash_391d88e62e3bfab3");
}

function function_1a702184() {
  var_58cd8ee0 = struct::get("darkroom_door_interact_button", "targetname");
  var_897ff072 = struct::get("darkroom_door_interact_picture", "targetname");
  var_58cd8ee0 thread function_85fbc73e("found_secret_button", "button_interact_pressed");
  var_897ff072 thread function_85fbc73e("found_secret_picture", "picture_interact_pressed");
  level flag::wait_till_all(array("button_interact_pressed", "picture_interact_pressed"));
  level flag::set("darkroom_door_open");
  wait 0.5;
  level.var_bb05e8f5 rotateyaw(-79, 2.5, 0.75, 0.75);
}

function function_85fbc73e(wait_notify, flagname) {
  level waittill(wait_notify);
  timer = 6;
  var_617f3755 = getent("secret_wall_panel", "targetname");
  var_b227bb98 = getent("secret_picture", "targetname");

  while(!level flag::get("darkroom_door_open")) {
    self util::create_cursor_hint(undefined, undefined, #"hash_6c7bb285599937ba");
    self waittill(#"trigger");
    thread namespace_5ceacc03::function_4cab7b22(self, timer);
    level flag::set(flagname);

    if(flagname == "button_interact_pressed") {
      var_617f3755 thread function_c9d1be0e(timer);
    }

    if(flagname == "picture_interact_pressed") {
      var_b227bb98 thread function_3ce22f0b(timer);
    }

    wait timer;
    level flag::clear(flagname);
  }
}

function function_c9d1be0e(timer) {
  var_ee7f9f95 = struct::get("secret_wall_panel_pos_01", "targetname");
  var_cfa661e3 = struct::get("secret_wall_panel_pos_02", "targetname");
  self moveto(var_cfa661e3.origin, 0.5, 0.1, 0.1);
  level.player playrumbleonentity(#"anim_med");
  snd::play("evt_stk_apt_puzzle_panel_open", self);
  wait 0.5;
  self moveto(var_ee7f9f95.origin, timer - 0.5, 0.1, 0.1);
}

function function_3ce22f0b(timer) {
  self rotateroll(-12, 0.5, 0.1, 0.1);
  level.player playrumbleonentity(#"anim_med");
  snd::play("evt_stk_apt_puzzle_picture_open", self);
  wait 0.5;
  var_13ad4669 = (timer - 0.5) / 6;

  for(i = 0; i < 6; i++) {
    wait var_13ad4669;
    self rotateroll(2, 0.1, 0.05, 0.05);
  }
}

function darkroom_light_interact() {
  level thread scene::init("cin_stakeout_apt_darkroom_light");
  level.var_482950bb = getent("stk_apartment_light_red_helper", "targetname");
  level.var_482950bb.original_intensity = level.var_482950bb getlightintensity();
  level.var_482950bb setlightintensity(0);

  if(!isDefined(level.var_7a8f8e9)) {
    level.var_7a8f8e9 = getent("darkroom_light", "targetname");
    level.var_7a8f8e9.animname = "darkroom_light";
  }

  level function_2fd06e9c("on");
  level.var_2bf3ee79 util::remove_cursor_hint();
}

function function_66b3680f() {
  level waittill(#"hash_20f0c5a3e813044");

  if(!level flag::get("flag_darkroom_light_on")) {
    level thread function_186a0635();
  }
}

function function_2fd06e9c(state) {
  level endon(#"flag_close_briefcase");

  if(level flag::get("flag_close_briefcase")) {
    return;
  }

  level.var_2bf3ee79 = struct::get("darkroom_light_interact", "targetname");
  level.var_2bf3ee79 util::create_cursor_hint(undefined, undefined, #"hash_4c7c3b0a076e33d2", 64);
  s_waitresult = level.var_2bf3ee79 waittill(#"trigger", #"hash_7f21624bd71e55db");
  player = getplayers()[0];
  var_51a34a03 = player.origin - level.var_2bf3ee79.origin;
  var_51a34a03 = (var_51a34a03[0], var_51a34a03[1], 0);
  var_51a34a03 = vectornormalize(var_51a34a03);
  forward = anglesToForward(level.var_2bf3ee79.angles);
  dot_fwd = vectordot(var_51a34a03, forward);
  right = anglestoright(level.var_2bf3ee79.angles);
  dot_right = vectordot(var_51a34a03, right);
  direction = undefined;

  if(dot_fwd >= 0.7) {
    direction = "fr";
  } else if(dot_fwd <= -0.7) {
    direction = "ba";
  } else if(dot_right <= -0.7) {
    direction = "rt";
  } else {
    direction = "lf";
  }

  if(s_waitresult._notify === "trigger") {
    level thread scene::play("cin_stakeout_apt_darkroom_light", "apt_darkroom_light_" + direction);
    player waittill(#"hash_5626dd1a7ff2dfaf");
    player playrumbleonentity(#"anim_light");
  }

  if(state == "on") {
    level thread function_186a0635();
  } else {
    level thread function_8fd5f0ca();
  }

  wait 0.1;
}

function function_186a0635() {
  if(level flag::get("flag_darkroom_light_on")) {
    return;
  }

  namespace_5ceacc03::function_186a0635();
  level.var_482950bb setlightintensity(level.var_482950bb.original_intensity);
  level.var_7a8f8e9 clientfield::set("darkroom_light", 1);
  level flag::set("flag_darkroom_light_on");
}

function function_8fd5f0ca() {
  if(!level flag::get("flag_darkroom_light_on")) {
    return;
  }

  namespace_5ceacc03::function_8fd5f0ca();
  level.var_482950bb setlightintensity(0);
  level.var_7a8f8e9 clientfield::set("darkroom_light", 0);
  level flag::clear("flag_darkroom_light_on");
}

function function_d92bcbb5(a_ents) {
  level.var_dca3174b = a_ents[#"greta"];
}

function function_c0a03fad(a_ents) {
  level.var_4f36147a = a_ents[#"hash_230024232d90e377"];
}

function function_c8ac96b3() {
  scene::add_scene_func("scene_z_stk_apt_plant_tracker", &function_c0a03fad, "init");
  level scene::init("scene_z_stk_apt_plant_tracker");
  waitframe(1);
  level flag::wait_till("flag_darkroom_light_on");
  var_cbe1de3 = struct::get("apt_briefcase_interact", "targetname");

  if(isDefined(var_cbe1de3)) {
    var_cbe1de3 util::create_cursor_hint(undefined, undefined, #"hash_24b92cc9c8f3144e", 64, undefined, undefined, undefined, undefined, undefined, undefined, 1);
    var_cbe1de3 waittill(#"trigger");
    player = getplayers()[0];
    namespace_5ceacc03::music("deactivate_14.0_find_briefcase");
    level.var_bb05e8f5 rotateyaw(79, 0.25);

    if(!level flag::get("flag_wife_is_darted")) {
      level.player stats::function_dad108fa(#"hash_1b921321a962d6a6", 1);
    }

    objectives::remove(#"hash_410487ffcf0fdc58");
    thread namespace_5ceacc03::function_271bf326();
    level scene::play("scene_z_stk_apt_plant_tracker", "start");
    level thread scene::play("scene_z_stk_apt_plant_tracker", "loop");
    var_6e695d6d = # "hash_1be67a050a98eb";
    var_314be333 = # "hash_1be77a050a9a9e";
    var_87b83dca = dialog_tree::new_tree(undefined, undefined, 1, 1);
    var_dfc957f2 = var_87b83dca dialog_tree::add_option(var_6e695d6d, undefined, undefined, undefined, 1, "flag_close_briefcase");
    var_ed08f271 = var_87b83dca dialog_tree::add_option(var_314be333, undefined, undefined, undefined, 1, "flag_close_briefcase");
    var_87b83dca dialog_tree::run(undefined, undefined, 7);
    level flag::wait_till("flag_close_briefcase");
    level thread function_31240146();
    level scene::play("scene_z_stk_apt_plant_tracker", "end");
    wait 0.5;
    level flag::set("apartment_explosive_placed");
  }
}

function function_31240146() {
  level waittill(#"hash_4cff21653b9d5547");
  level.var_dca3174b dialogue::queue("vox_cp_stkt_11500_gret_help_aa_2");
}

function function_6b7988be() {
  level notify(#"hash_7538d0f49c08fc76");
  level thread function_d2de5ec5("aib_vign_stakeout_apt_child");
  level thread function_d2de5ec5("aib_vign_stakeout_apt_wife");
  level thread function_d2de5ec5("aib_vign_stakeout_apt_kraus");

  if(isDefined(level.var_49a292bb)) {
    level.var_49a292bb delete();
  }

  if(isDefined(level.var_3559e9e)) {
    level.var_3559e9e delete();
  }

  if(isDefined(level.child)) {
    level.child delete();
  }

  if(isDefined(level.var_4f36147a)) {
    level.var_4f36147a delete();
  }

  if(isDefined(level.var_752c558a)) {
    level.var_752c558a delete();
  }

  var_617f3755 = getent("secret_wall_panel", "targetname");

  if(isDefined(var_617f3755)) {
    var_617f3755 delete();
  }

  var_b227bb98 = getent("secret_picture", "targetname");

  if(isDefined(var_b227bb98)) {
    var_b227bb98 delete();
  }

  drawer = getent("desk_office_drawer_01", "targetname");
  var_8f7963a2 = getEntArray(drawer.linkname, "linkto");

  if(isDefined(drawer)) {
    drawer delete();
  }

  array::delete_all(var_8f7963a2);
  drawer = getent("2f_bedroom_drawer", "targetname");
  var_8f7963a2 = getEntArray(drawer.linkname, "linkto");

  if(isDefined(drawer)) {
    drawer delete();
  }

  array::delete_all(var_8f7963a2);
  a_decals = getEntArray("blacklight_decals_emissive", "targetname");
  array::delete_all(a_decals);
  var_5bc503b1 = getent("darkroom_hidden_door", "targetname");

  if(isDefined(var_5bc503b1)) {
    var_5bc503b1 delete();
  }

  chair = getent("kraus_office_chair", "targetname");

  if(isDefined(chair)) {
    chair delete();
  }

  apt_couch_pillow = getent("apt_couch_pillow", "targetname");

  if(isDefined(apt_couch_pillow)) {
    apt_couch_pillow delete();
  }

  apt_phone = getent("apt_phone", "targetname");

  if(isDefined(apt_phone)) {
    apt_phone delete();
  }

  apt_nightstand = getent("apt_nightstand", "targetname");

  if(isDefined(apt_nightstand)) {
    apt_nightstand delete();
  }

  apt_kettle = getent("apt_kettle", "targetname");

  if(isDefined(apt_kettle)) {
    apt_kettle delete();
  }

  apt_umbrella = getent("apt_umbrella", "targetname");

  if(isDefined(apt_umbrella)) {
    apt_umbrella delete();
  }

  doors::function_3353d645("tgt_apt_front_door");
  doors::function_3353d645("tgt_apt_master_bedroom_door");
  doors::function_3353d645("tgt_apt_child_bedroom_door");
  doors::function_3353d645("apt_door_lower_bedroom");
  doors::function_3353d645("door_electronics_store");
}

function function_d2de5ec5(scenedef) {
  if(level scene::is_active(scenedef)) {
    level scene::stop(scenedef, 1);
  }
}

function function_a3c49bc0(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  level thread function_6b7988be();
  level flag::set("apartment_2_done");
}

function function_be8d91b2() {
  var_22386ba3 = getEntArray("apartment_light1_fill", "targetname");
  var_13f6cf20 = getent("apartment_light1_spot", "targetname");
  var_f5b792a2 = getEntArray("apartment_light2_fill", "targetname");
  var_6799f665 = getent("apartment_light2_spot", "targetname");

  foreach(light in var_22386ba3) {
    light setlightintensity(0);
  }

  var_13f6cf20 setlightintensity(0);

  foreach(light in var_f5b792a2) {
    light setlightintensity(0);
  }

  var_6799f665 setlightintensity(0);
}

function spawn_tag_origin(origin = self.origin, angles = self.angles) {
  return util::spawn_model("tag_origin", origin, angles);
}