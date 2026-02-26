/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5a85dd71c99e76a2.gsc
***********************************************/

#using script_3072532951b5b4ae;
#using script_3dc93ca9902a9cda;
#using script_58524f08c3081cbb;
#using script_5c325a0a637fdc2e;
#using script_6fad88ff3ed4ff7d;
#using script_c36b776c6718540;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\manager;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_cbf28e01;

function function_e39e219e() {}

function function_37c8a043(str_objective, var_50cc0d4f) {
  level thread scene::init("scene_yam_1010_hel_intro");
  level thread globallogic_ui::function_7bc0e4b9();
  snd::client_msg("audio_level_begin_duck_start");
  level waittill(#"chyron_menu_closed");
  level.allowbattlechatter[#"allies"] = 0;
  level.allowbattlechatter[#"axis"] = 0;
  namespace_b73b9191::function_15426f9d("cull_inside_satcom");
  namespace_b73b9191::function_15426f9d("cull_inside_finale");
  namespace_b73b9191::function_15426f9d("cull_inside_bunkerext");
  namespace_b73b9191::function_ee83e03a("cull_outside_bunkerint");
  namespace_b73b9191::function_15426f9d("cull_inside_excavation");
  level thread function_fe3defb0();
  level thread namespace_8a404420::function_7eb604b9();
  level flag::wait_till("flg_intro_dialog_done");
  level thread function_e16fed8b();
  level.ai_woods clientfield::increment("ai_cold_breath");
  level thread objectives::scripted("obj_yamantau_1", undefined, #"hash_423da80c752f859f");
  skipto::function_4e3ab877("intro_heli");
  savegame::checkpoint_save(1);
}

function function_fe3defb0() {
  while(!isDefined(level.player)) {
    waitframe(1);
  }

  level.player val::set("intro", "show_hud", 0);
  level.player val::set("intro", "allow_prone", 0);
  level.player val::set("intro", "allow_jump", 0);
  level flag::wait_till("flg_intro_dialog_done");
  level.player val::reset_all("intro");
}

function function_38910b5f(str_objective) {
  namespace_b73b9191::function_2683ec5d();
}

function function_a0b88490(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  waitframe(1);
  level flag::set("chyron_menu_closed");
  namespace_b73b9191::function_15426f9d("cull_inside_satcom");
  namespace_b73b9191::function_15426f9d("cull_inside_finale");
  namespace_b73b9191::function_15426f9d("cull_inside_bunkerext");
  namespace_b73b9191::function_ee83e03a("cull_outside_bunkerint");
  namespace_b73b9191::function_15426f9d("cull_inside_excavation");
  level thread namespace_b73b9191::function_346d9c79();
  level thread namespace_b73b9191::function_5b62c8af();
}

function function_3d1df8a6(str_objective, var_50cc0d4f) {
  var_14cbb6e9 = struct::get("woods_ice_slide_teleport", "targetname");
  level.ai_woods thread hms_util::function_b064d2a4("jog", var_14cbb6e9.origin, "flg_mountain_slide_woods_start", 1);
  level.player allowslide(0);
  level.player thread function_407a3aaa();
  level thread function_8ab7aab7();
  level thread namespace_7468806b::function_79af70ae(0);
  level thread function_ed43d759();
  level namespace_5d7a2dac::music("2.0_ridge", 3);
  level.ai_woods thread hms_util::function_2f50100e("stay_ahead", var_14cbb6e9.origin, "flg_mountain_slide_woods_start");
  level thread namespace_7468806b::function_ec4c365f();
  level thread function_51d9d9c1();
  level flag::wait_till("flg_mountain_slide_woods_start");
  skipto::function_4e3ab877("mountain_summit");
}

function function_407a3aaa() {
  self endon(#"death");

  while(!level flag::get("flg_mountain_player_climbing_up_slope")) {
    waitframe(1);
  }

  exploder::exploder("falling_rocks");
  snd::play("amb_vfx_rock_snow_slide", (-7365, 2155, 3878));
}

function function_8ab7aab7() {
  level.player val::set("mountain", "allow_jump", 0);
  level flag::wait_till("flg_intro_allow_jump");
  level.player val::reset("mountain", "allow_jump");
}

function function_e16fed8b() {
  while(!isDefined(level.ai_woods)) {
    waitframe(1);
  }

  level.ai_woods thread namespace_b73b9191::function_608217cf("flg_mountain_woods_slide_ready");
  level thread namespace_b73b9191::function_5c5b6ea7("nd_mountain_path_1", "node", 0, 1);
  level flag::wait_till_any(array("flg_mountain_woods_path_2_skip", "flg_mountain_woods_path_1_done"));

  if(level flag::get("flg_mountain_woods_path_1_done")) {
    level flag::wait_till("flg_mountain_woods_path_2");
  }

  level thread namespace_b73b9191::function_5c5b6ea7("s_mountain_woods_path_2", "struct", 0, 1);
  level flag::wait_till("flg_mountain_woods_path_3");
  level thread namespace_b73b9191::function_5c5b6ea7("s_mountain_woods_path_3", "struct", 0, 1);
}

function function_51d9d9c1() {
  level thread breadcrumb::function_61037c6c(#"hash_72504ca297c1cdf9");
}

function function_d3655e70(str_objective) {
  level thread objectives::scripted("obj_yamantau_1", undefined, #"hash_423da80c752f859f");
  namespace_b73b9191::function_2683ec5d();
  level thread function_e16fed8b();
  level thread function_fe3defb0();
  level flag::set("flg_intro_dialog_done");
  level.allowbattlechatter[#"allies"] = 0;
  level.allowbattlechatter[#"axis"] = 0;
  level thread namespace_8a404420::function_fbb0d73f();
  s_mountain_woods_teleport = struct::get("s_mountain_woods_teleport", "targetname");
  level.ai_woods forceteleport(s_mountain_woods_teleport.origin, s_mountain_woods_teleport.angles);
}

function function_fdbb9f1e(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_ae06da18(str_objective, var_50cc0d4f) {
  level.ai_woods.script_accuracy = 1;
  level.ai_woods notify(#"flg_mountain_slide_woods_start");
  level flag::set("flg_mountain_hill_woods_start");
  level flag::set("flg_mountain_slide_woods_start");
  level.player thread function_92e93428();
  level thread function_2f86f258();
  level thread namespace_7468806b::function_97c413c1();
  level thread namespace_7468806b::function_3325b147();
  var_fd13eeab = getnode("intro_zipline_woods_node", "targetname");
  level.ai_woods thread hms_util::function_2f50100e("stay_even", var_fd13eeab.origin, "flg_mountains_zipline_dialogue");
  level flag::wait_till("flg_ice_slide_start_save");
  savegame::checkpoint_save(1);
  level flag::wait_till("flg_ice_slide_complete");
  savegame::checkpoint_save(1);
  skipto::function_4e3ab877("ice_slide");
}

function function_92e93428() {
  self endon(#"death");
  self waittill(#"hash_21e7754db7821ef8");
  level flag::wait_till("flg_mountains_ruins_approach");
  self allowslide(1);
}

function function_ed43d759(b_start = 0) {
  level flag::wait_till("flg_mountain_hill_woods_start");
  level.ai_woods pushplayer(1);

  if(b_start == 0) {
    level scene::play("scene_yam_3010_sat_slide_woods", "enter");

    if(!level flag::get("flg_mountain_slide_woods_start")) {
      waitframe(1);
      level.ai_woods setgoal(level.ai_woods.origin);
    }
  }

  level flag::wait_till("flg_mountain_slide_woods_start");
  level scene::play("scene_yam_3010_sat_slide_woods", "init");

  if(!level flag::get("flg_mountains_ruins_approach")) {
    level.ai_woods setgoal(level.ai_woods.origin);
    level flag::wait_till("flg_mountains_ruins_approach");
  }

  level scene::play("scene_yam_3010_sat_slide_woods", "exit");

  if(!level flag::get("flg_woods_to_wrckd_bldg")) {
    level.ai_woods setgoal(getnode("nd_wrecked_bldg_arrive", "targetname"));
  }

  self ai::set_behavior_attribute("demeanor", "cqb");
}

function function_2f86f258() {
  level flag::wait_till("flg_mountain_woods_advance_to_bldg");
  level.var_52be209f = spawner::simple_spawn_single("ai_mountain_summit_1", &function_afa7ed6e);
  level.ai_mountain_summit_2 = spawner::simple_spawn_single("ai_mountain_summit_2", &function_4c4ae895);
  level thread function_ea4df875(level.var_52be209f, level.ai_mountain_summit_2);
}

function function_4c4ae895() {
  self endon(#"death");
  level thread function_50237c02(self);
  self thread scene::play("scene_yam_0000_ambient_guard_smoking_lean", self);
  self namespace_979752dc::function_bf1fb16f();
  self val::set("zipline_patrol", "ignoreme", 1);
  self thread function_df51d5fa();
  self thread function_70af1721();
  self thread function_de0f391a();
  self thread function_41a7dd5();
  self util::waittill_any_ents(self, "damage", self, "stealth_combat", self, "bulletwhizby");
  self scene::stop("scene_yam_0000_ambient_guard_smoking_lean");
  self flag::set("stealth_override_goal");
  self setgoal(getnode("nd_mountain_guard", "targetname"), 1);

  if(!is_true(self.in_melee_death)) {
    self val::reset("zipline_patrol", "ignoreme");
  }
}

function function_41a7dd5() {
  self endon(#"death");
  source = self waittill(#"damage");

  if(isDefined(source) && isDefined(source.attacker) && isDefined(source.attacker.targetname)) {
    if(source.attacker.targetname == "woods") {
      self kill();
    }
  }
}

function function_70af1721() {
  self endon(#"death");
  nd_wrecked_overlook = getnode("nd_wrecked_overlook", "targetname");

  while(distance2d(level.ai_woods.origin, nd_wrecked_overlook.origin) > 150) {
    waitframe(1);
  }

  level flag::set("flg_mountain_wrecked_woods_ready");
}

function function_de0f391a() {
  self endon(#"death");
  level flag::wait_till_all(array("flg_mountain_wrecked_woods_ready", "flg_mountain_summit_1_dead"));
  level.ai_woods thread ai::shoot_at_target("kill_within_time", self, undefined, 3, 1, 1);
}

function function_50237c02(ai) {
  source = ai waittill(#"damage", #"death");

  if(isDefined(source) && isDefined(source.attacker) && isDefined(source.attacker.targetname)) {
    if(source.attacker.targetname == "woods") {
      level flag::set("flg_mountain_spotter_woods_kill");
    }
  }

  if(isalive(ai)) {
    ai waittill(#"death");
  }

  level flag::set("flg_mountain_spotter_dead");
}

function function_afa7ed6e() {
  self endon(#"death");
  self thread scene::play("scene_yam_0000_ambient_rooftop_guard_scan", self);
  self thread function_5c4faa0d();
  self namespace_979752dc::function_bf1fb16f();
  self val::set("mountain_summit_sniper", "ignoreme", 1);
}

function function_5c4faa0d() {
  self endon(#"death");
  self thread function_3d8cac1b();
  self util::waittill_any_ents(self, "nonsniper_damage", self, "stealth_combat", self, "bulletwhizby", level, "flg_mountains_sniper_exit_anim");
  wait 0.1;

  if(!level flag::get("flg_rooftop_death_playing")) {
    self scene::stop("scene_yam_0000_ambient_rooftop_guard_scan");
    self notify(#"stop_scene");
  }

  self val::reset("mountain_summit_sniper", "ignoreme");
  self flag::set("stealth_override_goal");
  var_8dd7667d = getnode("mountain_summit_sniper_path", "targetname");
  self setgoal(var_8dd7667d, 1);
  self function_a3fcf9e0("attack", level.player, level.player getplayercamerapos());
  self getperfectinfo(level.player);
  self.script_accuracy = 1000;
  self.perfectaim = 1;
  self.favoriteenemy = level.player;
}

function function_3d8cac1b() {
  level endon(#"flg_mountains_sniper_exit_anim");
  self endon(#"stop_scene");
  s_notify = self waittill(#"damage");

  if(isDefined(s_notify.weapon) && s_notify.weapon.name === "sniper_standard_t9") {
    level.player playhitmarker(#"hash_31e38d8520839566", 5, undefined, 1);
    self namespace_979752dc::enable_stealth_for_ai(0);
    level flag::set("flg_rooftop_death_playing");
    level scene::play("scene_yam_0000_ambient_rooftop_guard_scan", "death");
    return;
  }

  self notify(#"nonsniper_damage");
}

function function_ea4df875(var_52be209f, ai_mountain_summit_2) {
  level endon(#"flg_mountains_sniper_exit_anim");
  level flag::wait_till_any(array("flg_rooftop_death_playing", "flg_mountain_summit_1_dead", "flg_mountain_summit_2_dead"));
  wait 0.5;

  if(!level flag::get("flg_rooftop_death_playing") && isalive(var_52be209f)) {
    var_4eb6ee88 = var_52be209f;
  } else if(isalive(ai_mountain_summit_2)) {
    var_4eb6ee88 = ai_mountain_summit_2;
  }

  if(!level flag::get("stealth_spotted") && !level flag::get("flg_zipline_intro_cleared")) {
    level thread namespace_7468806b::function_93e6003d();
  }

  level flag::wait_till_all(array("flg_mountain_summit_1_dead", "flg_mountain_summit_2_dead"));
  level flag::set("mountain_summit_sniper_clear");

  if(!level flag::get("flg_woods_goto_zipline_overlook")) {
    trigger::use("t_advance_woods_to_zip_intro", "targetname", level.player, 0);
  }

  wait 0.5;

  if(!level flag::get("stealth_spotted") && !level flag::get("flg_zipline_intro_cleared")) {
    level thread namespace_7468806b::function_4b868d7e();
  }
}

function function_bb34c64(str_objective) {
  level thread objectives::scripted("obj_yamantau_1", undefined, #"hash_423da80c752f859f");
  namespace_b73b9191::function_2683ec5d();
  var_b4bb921 = struct::get("woods_ice_slide_teleport", "targetname");
  level.ai_woods forceteleport(var_b4bb921.origin, var_b4bb921.angles);
  level flag::set("flg_mountain_woods_slide_ready");
  level thread namespace_7468806b::function_79af70ae(1);
  level.allowbattlechatter[#"allies"] = 0;
  level.allowbattlechatter[#"axis"] = 0;
  level thread function_ed43d759(1);
}

function function_33fd8fa3(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_11648e12(str_objective, var_50cc0d4f) {
  level.ai_woods.script_accuracy = 1;
  level.ai_woods.perfectaim = 1;
  level.ai_woods pushplayer(1);
  level.ai_woods.pushable = 0;
  var_75c2d324 = getent("zipline_mountain_tutorial", "targetname");
  var_75c2d324.var_dc6e66ea = 0.7;
  level.player.is_ziplining = 1;
  var_7f7daf16 = struct::get("zipline_mountain_tutorial_prompt", "targetname");
  tr_mountain_zipline_woods_color = getent("tr_mountain_zipline_woods_color", "targetname");
  level thread function_f4cb6831();
  level thread function_4fa3dab1();
  level thread function_de42d9ad();
  level thread namespace_7468806b::function_ba5a28f();
  level thread function_dc28274f();
  level thread namespace_8a404420::function_517fe722();
  level flag::wait_till("flg_zipline_intro_cleared");
  level.ai_woods.script_accuracy = 0.7;
  level.ai_woods.perfectaim = 0;
  savegame::checkpoint_save(1);
  level.player.is_ziplining = 0;
  var_75c2d324.var_dc6e66ea = 2;
  objectives::goto(#"hash_164cecb161e0109b", var_7f7daf16.origin + (0, 0, 15));
  level.player waittill(#"player_zipline_start");
  namespace_b73b9191::function_ee83e03a("cull_inside_satcom");
  level thread namespace_7468806b::function_32d5f643();
  level namespace_5d7a2dac::music("4.1_zipline");
  objectives::complete(#"hash_164cecb161e0109b");
  level flag::set("flg_zipline_intro_used");
  level.ai_woods val::set(#"woods", "ignoreall", 1);
  level.ai_woods.var_dfd2d506 = 0;
  level.ai_woods.var_660aa59f = 0.1;
  function_25160739();
  nd_zipliner_combat = getnode("nd_zipliner_combat", "targetname");
  var_7417bebe = distance2d(level.ai_woods.origin, nd_zipliner_combat.origin);

  if(var_7417bebe > 100) {
    level.ai_woods forceteleport(nd_zipliner_combat.origin, nd_zipliner_combat.angles);
  }

  nd_woods_satcom_overlook = getnode("nd_woods_satcom_overlook", "targetname");
  level.ai_woods setgoal(nd_woods_satcom_overlook, 1);
  var_80d333e3 = getnode("satcom_woods_node", "targetname");
  level.ai_woods thread hms_util::function_2f50100e("stay_behind", var_80d333e3.origin, "flg_satcom_approached");
  level.ai_woods pushplayer(0);
  level.ai_woods.pushable = 1;
  objectives::complete(#"hash_164cecb161e0109b");
  level flag::wait_till("flg_mountains_zipline_end");
  skipto::function_4e3ab877("zipline_intro");
}

function function_25160739() {
  zipline_mountain_tutorial_start = getvehiclenode("zipline_mountain_tutorial_start", "targetname");
  wait 2;
  distance = 0;

  while(distance < 200) {
    distance = distance2d(level.player.origin, zipline_mountain_tutorial_start.origin);
    wait 0.1;
  }
}

function function_dc28274f() {
  var_e1b467ff = getEntArray("e_mountain_zipline_clip", "targetname");
  level flag::wait_till("flg_zipline_intro_used");

  foreach(e_mountain_zipline_clip in var_e1b467ff) {
    e_mountain_zipline_clip movez(-1000, 0.1);
  }

  level flag::wait_till("flg_mountains_zipline_end");

  foreach(e_mountain_zipline_clip in var_e1b467ff) {
    e_mountain_zipline_clip movez(1000, 0.1);
  }
}

function function_de42d9ad() {
  level.ai_woods endon(#"death");
  level.ai_woods waittill(#"hash_65134449cd95c3cb");
  level.ai_woods pushplayer(0);
  level.ai_woods waittill(#"hash_4c7ded9d08b15793");
  level.ai_woods.var_dfd2d506 = 1;
  level.ai_woods.var_660aa59f = undefined;
  level flag::set("flg_intro_zipline_dismount");

  if(!level flag::get("flg_zipline_intro_zipliner_killed")) {
    level.ai_woods val::set(#"woods", "ignoreall", 0);
    level flag::wait_till("flg_zipline_intro_zipliner_killed");
  }

  level.ai_woods val::set(#"woods", "ignoreall", 1);
}

function function_f4cb6831() {
  tr_mountain_zipline_overlook = getent("tr_mountain_zipline_overlook", "targetname");
  var_9cdc6574 = getEntArray("tr_mountain_zipline_approach", "targetname");

  if(!isDefined(var_9cdc6574)) {
    var_9cdc6574 = [];
  } else if(!isarray(var_9cdc6574)) {
    var_9cdc6574 = array(var_9cdc6574);
  }

  var_9cdc6574[var_9cdc6574.size] = getent("t_advance_woods_to_zip_intro", "targetname");
  level.var_3369117 = 0;
  var_9d28dc20 = [];
  level.var_e814fac2 = 0;
  level.var_d596a87f = spawner::simple_spawn_single("sp_rus_zipline_patroller_1", &function_77b06f5c);
  level.var_a06bbe2a = spawner::simple_spawn_single("sp_rus_zipline_patroller_2", &function_77b06f5c, 1);
  level.var_89f99146 = spawner::simple_spawn_single("sp_rus_zipline_patroller_3", &function_94354bd7);
  level.var_74e7e723 = spawner::simple_spawn_single("sp_rus_zipline_patroller_4", &function_66fc9524);
  level thread namespace_b73b9191::function_5d981106("zipline_patrol", 0, "flg_zipline_intro_zipliner_killed");
  level thread function_75b9b13f();
  level thread function_ef876547();
  level thread function_ddf55816();

  if(isalive(level.var_52be209f)) {
    if(!isDefined(var_9d28dc20)) {
      var_9d28dc20 = [];
    } else if(!isarray(var_9d28dc20)) {
      var_9d28dc20 = array(var_9d28dc20);
    }

    var_9d28dc20[var_9d28dc20.size] = level.var_52be209f;
    level thread function_fa84444c(level.var_52be209f, "flg_mountain_summit_1_dead");
  }

  if(isalive(level.ai_mountain_summit_2)) {
    if(!isDefined(var_9d28dc20)) {
      var_9d28dc20 = [];
    } else if(!isarray(var_9d28dc20)) {
      var_9d28dc20 = array(var_9d28dc20);
    }

    var_9d28dc20[var_9d28dc20.size] = level.ai_mountain_summit_2;
    level thread function_fa84444c(level.ai_mountain_summit_2, "flg_mountain_summit_2_dead");
  }

  if(!isDefined(var_9d28dc20)) {
    var_9d28dc20 = [];
  } else if(!isarray(var_9d28dc20)) {
    var_9d28dc20 = array(var_9d28dc20);
  }

  var_9d28dc20[var_9d28dc20.size] = level.var_d596a87f;

  if(!isDefined(var_9d28dc20)) {
    var_9d28dc20 = [];
  } else if(!isarray(var_9d28dc20)) {
    var_9d28dc20 = array(var_9d28dc20);
  }

  var_9d28dc20[var_9d28dc20.size] = level.var_a06bbe2a;
  waitframe(1);

  foreach(ai in var_9d28dc20) {
    if(isalive(ai)) {
      ai.script_longdeath = 0;
    }
  }

  if(isalive(level.var_89f99146)) {
    level.var_89f99146.script_longdeath = 0;
  }

  if(isalive(level.var_74e7e723)) {
    level.var_74e7e723.script_longdeath = 0;
  }

  level thread namespace_8a404420::function_6240e40f();
  level thread namespace_8a404420::function_f21e84b4();
  level thread namespace_b73b9191::function_5d981106("mountain_summit_sniper", 0, "flg_zipline_intro_cleared");
  level flag::wait_till_any(array("flg_zipline_intro_cleared", "stealth_spotted", "flg_zipline_intro_engaging"));

  foreach(tr in var_9cdc6574) {
    if(isDefined(tr)) {
      tr triggerenable(0);
    }
  }

  if(!level flag::get("flg_zipline_intro_cleared")) {
    level.ai_woods.goalradius = 1024;
    level.ai_woods setgoal(level.player);

    if(!level flag::get("stealth_override_goal")) {
      level flag::wait_till("flg_zipline_intro_engaging");
      level.ai_woods setgoal(getent("vol_stealth_intro_zipline", "targetname"));
    }

    level flag::wait_till("flg_zipline_intro_cleared");
    level.ai_woods.goalradius = 8;
    level.ai_woods pushplayer(1);
    level flag::set("flg_woods_goto_zipline_overlook");
    level.ai_woods setgoal(getnode("intro_zipline_woods_node", "targetname"));
    return;
  }

  if(isDefined(tr_mountain_zipline_overlook)) {
    trigger::use("tr_mountain_zipline_overlook", "targetname", level.player, 0);
  }

  level.ai_woods pushplayer(1);
}

function function_fa84444c(ai, flag) {
  while(isalive(ai)) {
    wait 0.1;
  }

  level flag::set(flag);
}

function function_4fa3dab1() {
  level endon(#"flg_mountains_zipline_end");
  level flag::wait_till_any(array("flg_zipline_intro_stealth_broken", "flg_stealth_spotted"));
  level.allowbattlechatter[#"allies"] = 1;
  level.allowbattlechatter[#"axis"] = 1;
}

function function_94354bd7() {
  self endon(#"death");
  self val::set("zipline_patrol", "ignoreme", 1);
  self val::set("zipline_patrol", "ignoreall", 1);
  self ai::set_behavior_attribute("demeanor", "patrol");
  self.goalradius = 256;
  level flag::wait_till_any(array("flg_zipline_intro_zipliner_cross", "flg_zipline_intro_stealth_broken"));

  if(level flag::get("flg_zipline_intro_stealth_broken")) {
    self ai::set_behavior_attribute("demeanor", "combat");
    self val::reset_all("zipline_patrol");

    if(level flag::get("flg_zipline_intro_approached")) {
      vol_goal = getent("vol_stealth_intro_zipline", "targetname");
    } else {
      vol_goal = getent("vol_mountain_summit_stealth", "targetname");
    }

    self setgoal(vol_goal, 1);
    return;
  }

  self thread function_d32cd800();
  nd_zipliner = getnode("nd_zipliner", "targetname");
  wait 1;
  self setgoal(nd_zipliner, 1);
  self waittill(#"hash_65134449cd95c3cb");
  wait 4;

  if(level flag::get("flg_zipline_intro_rus_weapon_fired")) {
    var_d9fd973a = 1;
  }

  self waittill(#"hash_4c7ded9d08b15793");
  wait 0.5;

  if(!is_true(var_d9fd973a)) {
    self.script_stealthgroup = "stealth_bottom_zipline";
    self namespace_979752dc::do_stealth();
    self val::reset("zipline_patrol", "ignoreall");
    util::waittill_any_ents(self, "stealth_combat", level, "flg_intro_zipline_post", self, "damage", self, "bulletwhizby");
  } else {
    self getperfectinfo(level.player);
    self function_a3fcf9e0("attack", level.player, level.player getplayercamerapos());
  }

  level flag::set("flg_intro_zipline_post");
  nd_zipliner_alert = getnode("nd_zipliner_alert", "targetname");
  self setgoal(nd_zipliner_alert, 1);
  wait 1;
  self ai::set_behavior_attribute("demeanor", "combat");
  self val::reset_all("zipline_patrol");
}

function function_ac7492ff(ai) {
  ai waittill(#"death");
  level flag::set("flg_zipline_intro_zipliner_killed");
}

function function_d32cd800() {
  self endon(#"hash_4c1bc0b351b4a76f", #"death");
  level flag::wait_till("flg_zipline_intro_stealth_broken");
  nd_zipliner = getnode("nd_zipliner_combat", "targetname");
  self setgoal(nd_zipliner, 1);
  self ai::set_behavior_attribute("demeanor", "combat");
  self val::reset_all("zipline_patrol");
}

function function_77b06f5c(var_8aa20ba2 = 0) {
  self endon(#"death");
  self val::set("zipline_patrol", "ignoreme");
  self thread function_df51d5fa();
  self thread function_7cb7dbe8(var_8aa20ba2);
  self thread function_2baa592b();
  self thread function_479939d1();
  self thread function_41a7dd5();

  if(var_8aa20ba2 == 1) {
    self thread function_30fc8357();
    self.health = 10;
  }

  self waittill(#"stealth_combat");

  if(!level flag::get("flg_zipline_intro_approached")) {
    self flag::set("stealth_override_goal");
    vol_mountain_summit_stealth = getent("vol_mountain_summit_stealth", "targetname");
    self setgoal(vol_mountain_summit_stealth, 1);
  }

  if(!is_true(self.in_melee_death)) {
    level flag::set("flg_zipline_intro_stealth_broken");
    self val::reset("zipline_patrol", "ignoreme");
  }
}

function function_66fc9524() {
  self endon(#"death");
  self val::set("zipline_patrol", "ignoreme", 1);
  util::waittill_any_ents(self, "stealth_combat", level, "flg_intro_zipline_post", self, "damage", self, "bulletwhizby");
  self setgoal(getnode("nd_patroller_4_alert", "targetname"), 1);
  self function_a3fcf9e0("attack", level.player, level.player getplayercamerapos());
  self getperfectinfo(level.player);
  wait 1;
  self namespace_979752dc::enable_stealth_for_ai(0);
  self val::reset_all("zipline_patrol");
}

function function_75b9b13f() {
  level endon(#"flg_zipline_intro_cleared");

  while(true) {
    if(!isalive(level.var_d596a87f) && !isalive(level.var_a06bbe2a)) {
      if(isalive(level.var_89f99146)) {
        level.var_89f99146 val::set("zipline_patrol", "ignoreall", 0);
      }

      if(isalive(level.var_74e7e723)) {
        level.var_74e7e723 val::set("zipline_patrol", "ignoreall", 0);
      }

      break;
    }

    waitframe(1);
  }
}

function function_df51d5fa() {
  self endon(#"death", #"stealth_combat");
  level flag::wait_till("flg_zipline_intro_start_anim_1");

  while(true) {
    if(self cansee(level.ai_woods) && !level flag::get("flg_zipline_intro_woods_hidden")) {
      break;
    }

    waitframe(1);
  }

  self namespace_979752dc::enable_stealth_for_ai(0);
  self val::reset("zipline_patrol", "ignoreme");
}

function function_7cb7dbe8(var_8aa20ba2) {
  self endon(#"death");

  if(var_8aa20ba2 == 1) {
    self allowedstances("crouch");
  }

  s_notify = self waittill(#"damage");
  level flag::set("flg_zipline_intro_engaging");

  if(level.var_e814fac2 == 0) {
    level thread function_1677ef19(self, 0, 1.5);
  }

  if(isalive(self) && var_8aa20ba2 == 1) {
    self allowedstances("stand", "crouch");
  }

  self callback::function_d8abfc3d(#"on_ai_killed", &function_4730a08f);
  wait 2;
  self val::reset("zipline_patrol", "ignoreme");
}

function function_4730a08f(s_params) {
  if(s_params.eattacker === level.player) {
    level.var_3369117++;
  }
}

function function_2baa592b() {
  self endon(#"death");
  self waittill(#"takedown_begin");
  level flag::set("flg_zipline_intro_engaging");
  wait 1.5;

  if(level.var_e814fac2 == 0) {
    level thread function_1677ef19(self, 1, 1.5);
  }

  level.var_3369117++;
}

function function_479939d1() {
  self endon(#"death");
  self waittill(#"shoot");
  level flag::set("flg_zipline_intro_rus_weapon_fired");
}

function function_1677ef19(var_bcfd0b72, var_9d4d3a76, f_delay) {
  level endon(#"flg_zipline_intro_cleared");

  if(level.var_e814fac2 == 0) {
    level.var_e814fac2 = 1;

    if(isDefined(f_delay)) {
      wait f_delay;
    }

    if(isalive(level.var_d596a87f) && var_9d4d3a76 != level.var_d596a87f) {
      level.ai_woods ai::shoot_at_target("kill_within_time", level.var_d596a87f, undefined, 3, 1, 1);
      return;
    }

    if(isalive(level.var_a06bbe2a) && var_9d4d3a76 != level.var_a06bbe2a) {
      level.ai_woods ai::shoot_at_target("kill_within_time", level.var_a06bbe2a, undefined, 3, 1, 1);
    }
  }
}

function function_83ce3ef6() {
  level endon(#"flg_zipline_intro_cleared");
  level flag::wait_till("flg_zipline_intro_patrol_1_moving");

  if(!level flag::get("flg_zipline_intro_cleared") && !level flag::get("flg_zipline_intro_engaging")) {
    trigger::use("tr_mountain_zipline_hide", "targetname", level.player, 0);
    level.ai_woods setblackboardattribute("_stance", "crouch");
  }

  level flag::wait_till("flg_zipline_intro_engaging");
  level.ai_woods setblackboardattribute("_stance", "stand");
}

function function_a9bc2432(e_target) {
  level endon(#"flg_zipline_intro_cleared");
  self setgoal(e_target.origin, 1);
  self val::set("woods", "ignoreall");
  f_dist = distance2d(self.origin, e_target.origin);
  level.ai_woods function_9ae1c50();
  level.ai_woods ai::set_behavior_attribute("demeanor", "combat");

  while(f_dist > 150 && isalive(e_target)) {
    f_dist = distance2d(self.origin, e_target.origin);
    waitframe(1);

    if(level flag::get("stealth_spotted") && isalive(e_target)) {
      break;
    }
  }

  if(level flag::get("stealth_spotted") && isalive(e_target)) {
    level.ai_woods ai::shoot_at_target("kill_within_time", e_target, undefined, 3, 1, 1);
    self val::reset("woods", "ignoreall");
    e_target val::reset("zipline_patrol", "ignoreme");
    return;
  }

  if(!level flag::get("stealth_spotted") && isalive(e_target)) {
    level scene::stop("scene_yam_2020_zip_cliffside_alt");
    self val::reset("woods", "ignoreall");
    e_target val::reset("zipline_patrol", "ignoreme");
  }
}

function function_ddf55816() {
  level flag::wait_till("flg_zipline_intro_dialog");
  level thread function_40618920();
  level thread function_a361634d();

  if(!level flag::get("flg_zipline_intro_engaging") && !level flag::get("stealth_spotted")) {
    level flag::wait_till_timeout(0.5, "flg_zipline_intro_playing_looking");
    level thread namespace_7468806b::function_a4f7d6e();
    level thread function_8332a9bd();
  }

  level.ai_woods function_9ae1c50();
  level flag::set("flg_zipline_intro_visible");
  level namespace_5d7a2dac::music("3.0_takedown");
  level flag::wait_till_any_timeout(15, array("flg_zipline_intro_engaging", "flg_zipline_intro_cleared"));

  if(isalive(level.var_d596a87f) && isalive(level.var_a06bbe2a) && !level flag::get("stealth_spotted") && !level flag::get("flg_zipline_intro_engaging")) {
    nd_intro_patrol_1 = getnode("nd_intro_patrol_1", "targetname");
    nd_intro_patrol_2 = getnode("nd_intro_patrol_2", "targetname");
    level.var_d596a87f thread function_7f1196b2(nd_intro_patrol_1, "flg_zip_cliffside_alt_done", "flg_zipline_intro_patrol_1_moving");
    level.var_a06bbe2a thread function_7f1196b2(nd_intro_patrol_2, "flg_zip_cliffside_alt2_done", "flg_zipline_intro_patrol_2_moving", 3, "get_up");
  }

  level flag::wait_till("flg_zipline_intro_cleared");
  level.ai_woods ai::set_behavior_attribute("demeanor", "combat");
  level thread namespace_7468806b::function_478cabb9();
  wait 1.5;
  level thread namespace_7468806b::function_4d86101b();
}

function function_8332a9bd() {
  level.ai_woods ai::set_behavior_attribute("demeanor", "cqb");
  level flag::wait_till("flg_zipline_intro_engaging");
  level.ai_woods function_9ae1c50();
  level.ai_woods ai::set_behavior_attribute("demeanor", "combat");
}

function function_a361634d() {
  level endon(#"flg_zipline_intro_cleared");
  var_49292204 = [];

  if(!isDefined(var_49292204)) {
    var_49292204 = [];
  } else if(!isarray(var_49292204)) {
    var_49292204 = array(var_49292204);
  }

  var_49292204[var_49292204.size] = "stealth_spotted";

  if(!isDefined(var_49292204)) {
    var_49292204 = [];
  } else if(!isarray(var_49292204)) {
    var_49292204 = array(var_49292204);
  }

  var_49292204[var_49292204.size] = "flg_zipline_intro_engaging";
  var_c87b2793 = [];

  if(!isDefined(var_c87b2793)) {
    var_c87b2793 = [];
  } else if(!isarray(var_c87b2793)) {
    var_c87b2793 = array(var_c87b2793);
  }

  var_c87b2793[var_c87b2793.size] = "flg_zipline_intro_player_entered_space_right";

  if(!isDefined(var_c87b2793)) {
    var_c87b2793 = [];
  } else if(!isarray(var_c87b2793)) {
    var_c87b2793 = array(var_c87b2793);
  }

  var_c87b2793[var_c87b2793.size] = "flg_zipline_intro_player_entered_space_left";
  level flag::wait_till_any(var_c87b2793);

  if(!level flag::get_any(var_49292204)) {
    if(level flag::get("flg_zipline_intro_player_entered_space_right") && !level flag::get("flg_zipline_intro_cleared")) {
      level thread namespace_b73b9191::function_5c5b6ea7("s_zipline_intro_path_left_start", "struct", undefined, undefined, undefined, "flg_zipline_intro_cleared");
      return;
    }

    if(!level flag::get("flg_zipline_intro_cleared")) {
      level thread namespace_b73b9191::function_5c5b6ea7("s_zipline_intro_path_right_start", "struct", undefined, undefined, undefined, "flg_zipline_intro_cleared");
    }
  }
}

function function_40618920() {
  level endon(#"flg_zipline_intro_visible");
  var_49292204 = [];

  if(!isDefined(var_49292204)) {
    var_49292204 = [];
  } else if(!isarray(var_49292204)) {
    var_49292204 = array(var_49292204);
  }

  var_49292204[var_49292204.size] = "stealth_spotted";

  if(!isDefined(var_49292204)) {
    var_49292204 = [];
  } else if(!isarray(var_49292204)) {
    var_49292204 = array(var_49292204);
  }

  var_49292204[var_49292204.size] = "flg_zipline_intro_dialog";

  if(!isDefined(var_49292204)) {
    var_49292204 = [];
  } else if(!isarray(var_49292204)) {
    var_49292204 = array(var_49292204);
  }

  var_49292204[var_49292204.size] = "flg_zipline_intro_engaging";
  var_d250eb9f = 0;
  s_zipline_intro_lookat_ref = struct::get("s_zipline_intro_lookat_ref", "targetname");

  while(!level flag::get_any(var_49292204)) {
    if(level.player util::is_looking_at(s_zipline_intro_lookat_ref.origin, 0.995)) {
      var_d250eb9f = 1;
    } else {
      var_d250eb9f = 0;
    }

    waitframe(1);
  }

  if(var_d250eb9f == 1) {
    level flag::set("flg_zipline_intro_playing_looking");
  }
}

function function_30fc8357() {
  self endon(#"death");
  var_49292204 = [];

  if(!isDefined(var_49292204)) {
    var_49292204 = [];
  } else if(!isarray(var_49292204)) {
    var_49292204 = array(var_49292204);
  }

  var_49292204[var_49292204.size] = "stealth_spotted";

  if(!isDefined(var_49292204)) {
    var_49292204 = [];
  } else if(!isarray(var_49292204)) {
    var_49292204 = array(var_49292204);
  }

  var_49292204[var_49292204.size] = "flg_zipline_intro_engaging";
  self waittill(#"allow_stand_up");
  level flag::set("flg_zipline_intro_allow_stand_up");

  if(!level flag::get_any(var_49292204)) {
    level flag::wait_till_any(var_49292204);

    if(self.health > 0 && self namespace_77fd5d41::stealth_enemy_getbsmstate() == "Stealth_Idle" && !level flag::get("flg_zipline_intro_patrol_2_moving")) {
      level thread scene::play("scene_yam_2020_zip_cliffside_alt_enemy2", "react");
    }
  }
}

function function_7f1196b2(nd_target, var_8823b115, var_563104ef, var_809b5df, var_3cf3958e) {
  level endon(#"stealth_spotted", #"flg_zipline_intro_engaging", #"stealth_combat");
  self endon(#"death", #"damage");

  if(isDefined(var_8823b115)) {
    level flag::wait_till(var_8823b115);
  }

  if(isDefined(var_809b5df)) {
    wait var_809b5df;
  }

  if(isDefined(var_3cf3958e)) {
    level thread scene::play("scene_yam_2020_zip_cliffside_alt_enemy2", var_3cf3958e);
  } else {
    level scene::stop("scene_yam_2020_zip_cliffside_alt");
  }

  level flag::set(var_563104ef);
  self thread spawner::go_to_node(nd_target);
}

function function_ef876547() {
  level flag::wait_till("flg_zipline_intro_engaging");
  level namespace_5d7a2dac::music("4.0_zipline_intro");
}

function function_b205e5be(str_objective) {
  level thread objectives::scripted("obj_yamantau_1", undefined, #"hash_423da80c752f859f");
  namespace_b73b9191::function_2683ec5d();
  var_b4bb921 = struct::get("woods_zipline_teleport", "targetname");
  level.ai_woods forceteleport(var_b4bb921.origin, var_b4bb921.angles);
  level thread namespace_7468806b::function_79af70ae(1);
  level.allowbattlechatter[#"allies"] = 0;
  level.allowbattlechatter[#"axis"] = 0;
  level flag::set("flg_mountain_spotter_dead");
}

function function_71f05605(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  waitframe(1);
  namespace_b73b9191::function_ee83e03a("cull_inside_satcom");
}