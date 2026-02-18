/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6f32a5eb9cd9dc68.gsc
***********************************************/

#using script_58524f08c3081cbb;
#using script_5c325a0a637fdc2e;
#using script_6fad88ff3ed4ff7d;
#using script_c36b776c6718540;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\event;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#namespace namespace_94dc1844;

function function_afb0a04c() {}

function function_22e1ef3a(str_objective, var_50cc0d4f) {}

function function_cc91ce1f(str_objective) {
  var_5b7b93ad = getspawnerarray("woods_ar", "script_noteworthy");
  var_5b7b93ad[0] spawner::add_spawn_function(&function_dd87ddce);
  level.ai_woods = var_5b7b93ad[0] spawner::spawn(1);
  nd_woods_satcom_overlook = getnode("nd_woods_satcom_overlook", "targetname");
  level.ai_woods forceteleport(nd_woods_satcom_overlook.origin, nd_woods_satcom_overlook.angles);
  var_56f59f61 = spawn("script_origin", nd_woods_satcom_overlook.origin);
  var_56f59f61.angles = nd_woods_satcom_overlook.angles;
  level.ai_woods linkto(var_56f59f61);
}

function function_dd87ddce() {
  self.goalradius = 64;
  self val::set(#"woods", "allowdeath", 0);
  self ai::set_behavior_attribute("demeanor", "patrol");
  self.name = "Woods";
  self.propername = # "hash_22f2861ded3918a8";
  self.attackeraccuracy = 0.1;
  self namespace_b73b9191::function_d432b47b();
}

function function_56b991c1(str_objective, var_50cc0d4f) {
  level thread function_7233c5ee();
  level thread function_de27b0eb();
  level thread function_de26569a();
  level thread function_bd2f2746();
  level thread function_1b387040();
  level thread function_d272f105();
  satcom_woods_node = getnode("satcom_woods_node", "targetname");
  level.ai_woods thread hms_util::function_2f50100e("stay_even", satcom_woods_node.origin, "flg_satcom_approached");
  level.allowbattlechatter[# "allies"] = 0;
  level.allowbattlechatter[# "axis"] = 0;
  level flag::wait_till("flg_satcom_approach_end");
  transient = savegame::function_6440b06b(#"transient");

  if(!level flag::get("flg_satcom_approach_unsilenced_weapon_fired")) {
    transient.var_296ec611 = 1;
  } else {
    transient.var_296ec611 = 0;
  }

  skipto::function_4e3ab877("satcom_approach");
}

function function_d272f105() {
  if(!function_72a9e321()) {
    var_ccd016c0 = getEntArray("e_satcom_clip_next_gen", "targetname");

    foreach(e_satcom_clip_next_gen in var_ccd016c0) {
      e_satcom_clip_next_gen movez(-1000, 0.1);
    }
  }
}

function function_1b387040() {
  level endon(#"flg_satcom_approach_end");
  level callback::on_weapon_fired(&function_f146c41d);
  level flag::wait_till("flg_satcom_approach_unsilenced_weapon_fired");
  level callback::remove_on_weapon_fired(&function_f146c41d);
}

function function_f146c41d(s_event) {
  b_valid_weapon = 0;

  if(isDefined(s_event.weapon.attachments)) {
    foreach(attachment in s_event.weapon.attachments) {
      if(attachment == "suppressed" || attachment == "suppressed2") {
        b_valid_weapon = 1;
      }
    }

    return;
  }

  if(b_valid_weapon == 0) {
    level flag::set("flg_satcom_approach_unsilenced_weapon_fired");
    level callback::remove_on_weapon_fired(&function_f146c41d);
  }
}

function function_de27b0eb() {
  str_flag = "";

  do {
    s_notify = level flag::wait_till_any(array("flg_satcom_vista", "flg_intro_zipline_dismount"));
    str_flag = s_notify._notify;

    if(!level flag::get("flg_satcom_vista")) {
      if(!level flag::get("flg_zipline_intro_zipliner_killed")) {
        thread function_2573cfe4();
      } else {
        level namespace_7468806b::function_9bd1eb5e();
        level.allowbattlechatter[# "axis"] = 0;
      }

      level flag::clear("flg_intro_zipline_dismount");
    }
  }
  while(str_flag != "flg_satcom_vista");

  savegame::checkpoint_save(1);
  level thread namespace_7468806b::function_7163fd33();
  level thread breadcrumb::function_61037c6c(#"hash_4c535a07614a40af");
  level flag::wait_till("flg_satcom_exterior_approaching");
  level.ai_woods ai::set_behavior_attribute("demeanor", "combat");
  level namespace_5d7a2dac::music("5.0_combat_1");
}

function function_2573cfe4() {
  if(isalive(level.var_89f99146) && !is_true(level.var_89f99146.in_melee_death)) {
    level.ai_woods ai::shoot_at_target("kill_within_time", level.var_89f99146, undefined, 5, undefined, 1);
  }

  level flag::wait_till_timeout(5, "flg_zipline_intro_zipliner_killed");

  if(level flag::get("flg_zipline_intro_zipliner_killed") && !level flag::get("flg_satcom_vista")) {
    level namespace_7468806b::function_9bd1eb5e();
  }

  level.allowbattlechatter[# "axis"] = 0;
}

function function_de26569a() {
  level flag::wait_till("flg_satcom_approached");
  level.ai_woods notify(#"flg_satcom_approached");
}

function function_7233c5ee() {
  thread function_dae43999();
  level thread function_118581b3();
  level.var_d71e48f7 = [];
  createthreatbiasgroup("snipers");
  createthreatbiasgroup("satcom_woods");
  setthreatbias("satcom_woods", "snipers", -100);
  level flag::wait_till("flg_satcom_spawn_exterior");
  level thread namespace_b73b9191::function_e79ede39("flg_satcom_exiting");
  level flag::set("flg_satcom_kill_confirmed_vo_ready");
  var_a83c59d7 = spawner::simple_spawn("sp_rus_satcom_sniper", &function_500f511d);
  var_b4c1e6ce = spawner::simple_spawn("sp_rus_satcom_ground", &function_98c3cbb8);
  level thread namespace_7468806b::function_292d47f7();
  level thread namespace_7468806b::function_88430eb0(var_a83c59d7);
  level thread namespace_7468806b::function_c55af47c();

  foreach(ai in var_b4c1e6ce) {
    ai hms_util::function_22099452(1);
  }

  level thread function_6bdeaa70();
  level thread function_c20f6fa3(var_b4c1e6ce);
  level.var_d71e48f7 = arraycombine(level.var_d71e48f7, var_b4c1e6ce);
  level.var_d71e48f7 = arraycombine(level.var_d71e48f7, var_a83c59d7);
  level thread function_ef32b815();
  level thread function_b489670b();
  level.ai_woods thread function_cd0539f4();
  level flag::wait_till("flg_satcom_approach_end");
  level flag::wait_till("flg_satcom_cleared");
  level namespace_5d7a2dac::music("5.8_tension_2");

  if(!level flag::get("flg_satcom_exiting")) {
    level thread breadcrumb::function_61037c6c(#"hash_29c606a3feaa95a");
  }
}

function function_4cd737f6() {
  level endon(#"game_ended");
  level callback::on_weapon_fired(&function_f56c216d);
  level flag::wait_till("flg_satcom_clear_sight_clip");
  level callback::remove_on_weapon_fired(&function_f56c216d);
}

function function_f56c216d(s_params) {
  var_55fc9dba = struct::get("satcom_vista_lookat_struct", "targetname");

  if(level.player util::is_looking_at(var_55fc9dba.origin, 0.8, 1)) {
    level flag::set("flg_satcom_clear_sight_clip");
  }
}

function function_b489670b() {
  level flag::wait_till_any(array("flg_satcom_stealth_broken", "flg_satcom_exiting"));
  level.allowbattlechatter[# "allies"] = 1;
  level.allowbattlechatter[# "axis"] = 1;
}

function function_bd2f2746() {
  level endon(#"flg_satcom_player_exiting");
  nd_woods_satcom_overlook = getnode("nd_woods_satcom_overlook", "targetname");

  while(distance2d(level.ai_woods.origin, nd_woods_satcom_overlook.origin) > 20) {
    waitframe(1);
  }

  level flag::set("flg_satcom_woods_vantage_arrived");
}

function function_ef32b815() {
  level.player endon(#"death");
  level namespace_b73b9191::function_5d981106("ai_satcom", 0, "flg_satcom_cleared");
  level thread namespace_7468806b::function_c2968902();

  if(!level flag::get("flg_satcom_approached") && !level flag::get("flg_satcom_push_woods")) {
    trigger::use("t_satcom_approach_clear", "targetname", level.player, 0);
  } else if(level flag::get("flg_satcom_push_woods") && !level flag::get("flg_satcom_woods_descend")) {
    level.ai_woods setgoal(getnode("nd_satcom_int_woods_arrive", "targetname"), 1);
  }

  t_satcom_woods_ground_approach = getent("t_satcom_woods_ground_approach", "targetname");

  if(isDefined(t_satcom_woods_ground_approach)) {
    t_satcom_woods_ground_approach triggerenable(0);
  }

  if(!level flag::get("flg_satcom_approach_end") && !level flag::get("flg_satcom_woods_descend")) {
    level flag::wait_till("flg_satcom_push_woods");
    level.ai_woods setgoal(getnode("nd_satcom_int_woods_arrive", "targetname"), 1);
  }
}

function function_dae43999() {
  var_5d14e11e = [];
  var_5d14e11e[# "prone"] = 2200;
  var_5d14e11e[# "crouch"] = 2200;
  var_5d14e11e[# "stand"] = 2200;
  var_8293536e = [];
  var_8293536e[# "prone"] = 8192;
  var_8293536e[# "crouch"] = 8192;
  var_8293536e[# "stand"] = 8192;
  namespace_979752dc::set_detect_ranges(var_5d14e11e, var_8293536e);
}

function function_118581b3() {
  level flag::wait_till("flg_satcom_stealth_broken");
  var_5d14e11e = [];
  var_5d14e11e[# "prone"] = 8192;
  var_5d14e11e[# "crouch"] = 8192;
  var_5d14e11e[# "stand"] = 8192;
  var_8293536e = [];
  var_8293536e[# "prone"] = 8192;
  var_8293536e[# "crouch"] = 8192;
  var_8293536e[# "stand"] = 8192;
  namespace_979752dc::set_detect_ranges(var_5d14e11e, var_8293536e);
}

function function_c20f6fa3(var_b4c1e6ce) {
  level flag::wait_till("flg_satcom_reinforce");
  function_1eaaceab(var_b4c1e6ce, 0);

  if(level flag::get("flg_satcom_stealth_broken") && var_b4c1e6ce.size == 1 && level flag::get("flg_satcom_approach_unsilenced_weapon_fired")) {
    var_55472680 = getspawnerarray("sp_rus_satcom_ground_reinforce", "targetname");
    var_1ef60fab = spawner::simple_spawn_single(var_55472680[0]);

    if(!isDefined(level.var_d71e48f7)) {
      level.var_d71e48f7 = [];
    } else if(!isarray(level.var_d71e48f7)) {
      level.var_d71e48f7 = array(level.var_d71e48f7);
    }

    level.var_d71e48f7[level.var_d71e48f7.size] = var_1ef60fab;

    while(level.var_d71e48f7.size > 0) {
      function_1eaaceab(level.var_d71e48f7, 0);
      wait 0.1;
    }

    wait 1;

    if(!level flag::get("flg_satcom_approach_end")) {
      t_satcom_enter = getent("t_satcom_enter", "targetname");

      if(isDefined(t_satcom_enter)) {
        trigger::use("t_satcom_enter", "targetname", level.player, 0);
      }
    }

    return;
  }

  if(flag::get("flg_satcom_stealth_broken") && var_b4c1e6ce.size == 0 && level flag::get("flg_satcom_approach_unsilenced_weapon_fired")) {
    var_8eeb3ab9 = spawner::simple_spawn("sp_rus_satcom_ground_reinforce");
    level.var_d71e48f7 = arraycombine(level.var_d71e48f7, var_8eeb3ab9);

    while(level.var_d71e48f7.size > 1) {
      function_1eaaceab(level.var_d71e48f7, 0);
      wait 0.1;
    }

    wait 1;

    if(!level flag::get("flg_satcom_approach_end")) {
      t_satcom_enter = getent("t_satcom_enter", "targetname");

      if(isDefined(t_satcom_enter)) {
        trigger::use("t_satcom_enter", "targetname", level.player, 0);
      }
    }
  }
}

function function_6bdeaa70() {
  level flag::wait_till("flg_satcom_hill_spawn");

  if(!level flag::get("flg_satcom_reinforce")) {
    var_9bc8b1d7 = spawner::simple_spawn_single("sp_rus_satcom_hill", &function_98c3cbb8, 0, 1);

    if(!isDefined(level.var_d71e48f7)) {
      level.var_d71e48f7 = [];
    } else if(!isarray(level.var_d71e48f7)) {
      level.var_d71e48f7 = array(level.var_d71e48f7);
    }

    level.var_d71e48f7[level.var_d71e48f7.size] = var_9bc8b1d7;
    level thread function_3da8816f(var_9bc8b1d7);
  }
}

function function_3da8816f(ai) {
  ai waittill(#"death");
  level flag::set("flg_satcom_approach_hill_cleared");
}

function function_98c3cbb8(var_7f952abc = 0, var_c5ccf1e0 = 0) {
  self endon(#"death");
  self.goalradius = 32;
  self thread function_6c8adffe();
  self thread function_456cd67e();
  self thread function_f7859bb3();
  self namespace_979752dc::function_569a126(1, 1800);
  self.var_c5553760 = 1;

  if(var_7f952abc == 1) {
    self.var_7f952abc = 1;
    self callback::on_ai_killed(&function_dbc98faf);
  }

  level thread namespace_7468806b::function_d3bb1c27(self);
  level flag::wait_till("flg_satcom_stealth_broken");
  wait 0.2;
  stealth_event::event_broadcast_generic("explode", level.player.origin, 1500, level.player);
  self getperfectinfo(level.player);
  level flag::wait_till("flg_satcom_ground_push");

  if(var_c5ccf1e0 == 1) {
    level flag::wait_till("flg_satcom_reinforce");
  }

  vol_satcom_ground_push = getent("vol_satcom_ground_push", "targetname");
  self setgoal(vol_satcom_ground_push, 1);
}

function function_500f511d() {
  self endon(#"death");
  self.goalradius = 32;
  self val::set("satcom_sniper", "attackeraccuracy", 0.1);
  self namespace_979752dc::function_bf1fb16f();
  self thread function_6c8adffe();
  self thread function_456cd67e();
  self thread function_f7859bb3();
  self namespace_979752dc::function_569a126(1, 1800);
  self.var_c5553760 = 1;
  self.script_accuracy = 1000;
  self.perfectaim = 1;
  self.favoriteenemy = level.player;
  self setthreatbiasgroup("snipers");
  level thread namespace_7468806b::function_aae80daa(self);
  level flag::wait_till("flg_satcom_stealth_broken");
  wait 0.2;
  stealth_event::event_broadcast_generic("explode", level.player.origin, 1500, level.player);
  self getperfectinfo(level.player);
}

function function_f7859bb3() {
  self endon(#"death");
  level endon(#"flg_satcom_approach_unsilenced_weapon_fired");
  self waittill(#"shoot");
  level flag::set("flg_satcom_approach_unsilenced_weapon_fired");
}

function function_6c8adffe() {
  self val::set("satcom_snipers_initial", "ignoreall");
  level flag::wait_till_any(array("flg_zipline_intro_zipliner_killed", "flg_satcom_vista"));
  self val::reset("satcom_snipers_initial", "ignoreall");
}

function function_396c7e23() {
  self val::set("satcom_snipers", "ignoreall");
  level flag::wait_till("flg_satcom_clear_sight_clip");
  self val::reset("satcom_snipers", "ignoreall");
}

function function_456cd67e() {
  self endon(#"death");
  self util::waittill_any_ents(self, "stealth_combat", self, "bulletwhizby", self, "stealth_investigate");
  wait 1;
  level flag::set("flg_satcom_stealth_broken");
}

function function_63fec104() {
  self endon(#"death");

  while(!level flag::get("flg_satcom_stealth_broken")) {
    if(self.alertlevel == "low_alert" || self.alertlevel == "high_alert") {
      level flag::set("flg_satcom_stealth_broken");
    }

    wait 0.1;
  }
}

function function_dbc98faf(s_params) {
  if(isDefined(self.var_7f952abc) && self.var_7f952abc == 1) {
    self startragdoll(1);
  }
}

function function_2f1fcaac() {
  self endon(#"death");
  level flag::wait_till("flg_satcom_ambush_scene_done");
  self namespace_979752dc::function_bf1fb16f();

  while(true) {
    if(self cansee(level.ai_woods)) {
      break;
    }

    waitframe(1);
  }

  wait 0.2;
  self namespace_979752dc::enable_stealth_for_ai(0);
}

function function_cd0539f4() {
  self endon(#"death");
  level endon(#"hash_ef37a73be834016");
  self val::set(#"woods", "ignoreall", 1);
  self val::set(#"woods", "ignoreme", 1);
  self ai::set_behavior_attribute("demeanor", "combat");
  self setthreatbiasgroup("satcom_woods");
  self.goalradius = 64;
  level flag::wait_till_any(array("flg_satcom_entered", "flg_satcom_approach_unsilenced_weapon_fired"));
  self ai::set_behavior_attribute("demeanor", "combat");

  if(level flag::get("flg_satcom_approach_unsilenced_weapon_fired")) {
    wait 1;
    level thread namespace_7468806b::function_c4f4d5d3();
  }

  self val::reset(#"woods", "ignoreall");
  self val::reset(#"woods", "ignoreme");
}

function function_c73772c6(str_objective) {
  function_afb0a04c();
  level thread objectives::scripted("obj_yamantau_1", undefined, #"hash_423da80c752f859f");
  namespace_b73b9191::function_2683ec5d();
  level flag::set("flg_zipline_intro_zipliner_killed");
  var_b4bb921 = struct::get("woods_satcom_approach_teleport", "targetname");
  level.ai_woods forceteleport(var_b4bb921.origin, var_b4bb921.angles);
  level thread namespace_7468806b::function_79af70ae(1);
  level thread namespace_7468806b::function_ba5a28f(1);
  level thread namespace_8a404420::function_517fe722();
  level flag::set("flg_satcom_birds_trigger");
}

function function_844967aa(str_objective, var_50cc0d4f, var_aa1a6455, player) {}

function function_8cc2cc25(str_objective, var_50cc0d4f) {
  if(var_50cc0d4f) {
    level namespace_5d7a2dac::music("5.8_tension_2");
  }

  level thread function_a94c664a();
  level flag::wait_till("flg_satcom_entered");

  if(level flag::get("flg_satcom_cleared")) {
    level thread namespace_7468806b::function_967c94ee();
  }

  level thread namespace_7468806b::function_a7286428();
  level thread namespace_b73b9191::function_6f1012dd("satcom");
  level flag::wait_till("flg_satcom_woods_descend");
  level flag::wait_till("flg_satcom_exiting");

  if(!level flag::get("flg_crossbow_bolt_corpse_interacted_with")) {
    level thread namespace_b73b9191::function_2e5072b5("satcom");
  }

  savegame::checkpoint_save(1);
  skipto::function_4e3ab877("satcom");
}

function function_a94c664a() {
  level endon(#"flg_satcom_woods_descend");
  nd_satcom_int_woods_arrive = getnode("nd_satcom_int_woods_arrive", "targetname");

  while(distance2d(level.ai_woods.origin, nd_satcom_int_woods_arrive.origin) > 20) {
    waitframe(1);
  }

  level flag::wait_till("flg_satcom_entered");
  wait randomfloatrange(1.5, 3);
  tr_satcom_interior = getent("tr_satcom_interior", "targetname");

  if(isDefined(tr_satcom_interior)) {
    trigger::use("tr_satcom_interior", "targetname", level.player, 0);
  }
}

function function_f6f8cdca(str_objective) {
  function_afb0a04c();
  level thread objectives::scripted("obj_yamantau_1", undefined, #"hash_423da80c752f859f");
  namespace_b73b9191::function_2683ec5d();
  var_b4bb921 = struct::get("woods_satcom_teleport", "targetname");
  level.ai_woods forceteleport(var_b4bb921.origin, var_b4bb921.angles);
  level thread namespace_7468806b::function_79af70ae(1);
  level thread namespace_7468806b::function_ba5a28f(1);
  level.allowbattlechatter[# "allies"] = 0;
  level.allowbattlechatter[# "axis"] = 0;
  level thread namespace_8a404420::function_517fe722();
  level flag::set("flg_satcom_birds_trigger");
  level flag::set("flg_satcom_cleared");
  level.var_13434d89 = [];
}

function function_a46dc345(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  level callback::remove_on_ai_killed(&function_dbc98faf);
}