/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_5f9141e04e4e94a2.gsc
***********************************************/

#include script_174ce72cc0f850;
#include script_724752ab26bff81b;
#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_white_main_quest;
#include scripts\zm\zm_white_portals;
#include scripts\zm\zm_white_util;
#include scripts\zm_common\zm_item_pickup;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace namespace_825eac6b;

preload() {
  namespace_bd74bbd2::register(#"sc_mk2y", 20000, "sc_mk2y", &function_a66f0de2, &function_17f3e9e2);
  clientfield::register("scriptmover", "" + #"hash_70251001fe8c4abe", 20000, 1, "int");
  clientfield::register("scriptmover", "" + #"hash_b0298e980bd8da0", 20000, 1, "int");
  clientfield::register("scriptmover", "" + #"hash_1e4555a911a24ab7", 20000, 1, "int");
}

init() {
  level.var_23674b8f = spawnStruct();
  level.var_23674b8f.n_step = 0;
  callback::on_disconnect(&on_disconnect);
  level flag::init(#"hash_7ae84eb618c9266b");
  level flag::init(#"hash_11513646e875455c");
  level flag::init(#"hash_7a55d8f4bd6917cb");
  var_cf398736 = struct::get_array("mk2y_canister");
  var_cf398736 = array::randomize(var_cf398736);
  level.var_23674b8f.var_5dca8c75 = var_cf398736[0];

  foreach(var_5dca8c75 in var_cf398736) {
    var_d77110f1 = struct::get(var_5dca8c75.target);
    var_5dca8c75.var_ceb354bf = util::spawn_model(var_d77110f1.model, var_d77110f1.origin, var_d77110f1.angles);
  }
}

private function_18a1849f(e_player) {
  if(!isDefined(level.var_23674b8f.e_player)) {
    return false;
  }

  return e_player === level.var_23674b8f.e_player;
}

private function_a4ea69bf(w_weapon) {
  return isDefined(w_weapon) && (w_weapon == level.var_23674b8f.var_905d8263 || w_weapon == level.var_23674b8f.var_3b5ae85);
}

private function_f6048ee(e_player) {
  if(isDefined(e_player)) {
    if(!isDefined(level.var_23674b8f.e_player)) {
      if(isDefined(e_player.var_9c20e2c9)) {
        self sethintstring(#"hash_744b68f010abb05");
      } else {
        self sethintstring(#"hash_12346bdab086516e");
      }
    } else if(level.var_23674b8f.e_player == e_player) {
      self sethintstring(#"hash_74fc96e8d58ff646");
    } else {
      self sethintstring(#"hash_2054e8fdb6521566");
    }

    return true;
  }

  return false;
}

private function_5b4f9f76(e_player) {
  var_2fff5cb5 = level.var_23674b8f.e_player === e_player;
  var_24441d81 = !isDefined(level.var_23674b8f.e_player) && !isDefined(e_player.var_9c20e2c9);
  return var_2fff5cb5 || var_24441d81;
}

start_quest() {
  level thread start_step_1();
}

private start_step_1() {
  level endon(#"insanity_mode_triggered");
  level thread function_cbeb9a33();
  var_5dca8c75 = level.var_23674b8f.var_5dca8c75;
  var_5dca8c75.e_canister = util::spawn_model(var_5dca8c75.model, var_5dca8c75.origin, var_5dca8c75.angles);
  level.var_23674b8f.n_step = 1;

  if(isDefined(level.var_23674b8f.var_5dca8c75.var_ceb354bf)) {
    exploder::exploder("fxexp_mk2_y_smoke_emit_" + level.var_23674b8f.var_5dca8c75.script_string);
    level flag::set(#"hash_3a183a144032bbf3");
    level flag::wait_till(#"hash_7ae84eb618c9266b");
    level.var_23674b8f.var_5dca8c75.var_ceb354bf delete();
    exploder::stop_exploder("fxexp_mk2_y_smoke_emit_" + level.var_23674b8f.var_5dca8c75.script_string);
    exploder::exploder("fxexp_mk2_y_dirt_reveal_" + level.var_23674b8f.var_5dca8c75.script_string);
  }

  s_unitrigger = var_5dca8c75.e_canister zm_item_pickup::create_item_pickup(&function_9d66ea6f, &function_f6048ee, &function_5b4f9f76, 96);
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
}

function_33d9b1f8() {
  target = level.var_23674b8f.var_5dca8c75.var_ceb354bf;

  if(isDefined(target) && distancesquared(self.origin, target.origin) < 262144) {
    target util::make_sentient();
    self.favoriteenemy = target;
    v_goal = getclosestpointonnavmesh(target.origin);
    self setgoal(v_goal);

    if(self.var_7a9b6c1d !== 1) {
      self thread function_1f955544();
      self.var_7a9b6c1d = 1;
    }

    return true;
  }

  return false;
}

function_1f955544() {
  self endon(#"death");

  while(true) {
    if(!isDefined(level.var_23674b8f.var_5dca8c75.var_ceb354bf)) {
      break;
    }

    if(distancesquared(self.origin, level.var_23674b8f.var_5dca8c75.var_ceb354bf.origin) < 6400) {
      self thread function_62970384();
      break;
    }

    wait 0.1;
  }
}

function_62970384() {
  self endon(#"death");
  self thread animation::play("ai_t8_zm_zombie_base_attack_14");
  wait 1;
  level flag::set(#"hash_7ae84eb618c9266b");
  self.var_8b59c468 = undefined;
}

private function_9d66ea6f(e_item, e_player) {

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(e_player.name + "<dev string:x38>");
    println(e_player.name + "<dev string:x38>");
  }

    level.var_23674b8f.e_player = e_player;
  namespace_a01a2431::function_605e5c25(e_player);
  e_player.var_9c20e2c9 = 1;
  e_player playSound("evt_canister_pickup");
  zm_ui_inventory::function_7df6bb60("zm_white_ww_mod_phase", 2, e_player);
  zm_ui_inventory::function_7df6bb60("zm_white_ww_mk2y_ammo", 1, e_player);
  start_step_2();
}

cleanup_step_1() {
  exploder::stop_exploder("fxexp_mk2_y_smoke_emit_" + level.var_23674b8f.var_5dca8c75.script_string);
  level flag::clear(#"hash_3a183a144032bbf3");

  if(isDefined(level.var_23674b8f.var_5dca8c75.e_canister) && isDefined(level.var_23674b8f.var_5dca8c75.e_canister.s_unitrigger)) {
    zm_unitrigger::unregister_unitrigger(level.var_23674b8f.var_5dca8c75.e_canister.s_unitrigger);
    level.var_23674b8f.var_5dca8c75.e_canister delete();
  }
}

private start_step_2() {
  level endon(#"end_game", #"hash_36fd0ff497e7cb39");
  level.var_23674b8f.n_step = 2;
  a_s_portals = struct::get_array("white_portal");
  var_7ed14c5f = zm_white_portals::function_688df525();
  var_95d7a612 = array::exclude(a_s_portals, var_7ed14c5f);
  var_95d7a612 = array::randomize(var_95d7a612);
  level.var_23674b8f.var_80284ca5 = [];

  for(i = 0; i < 2; i++) {
    if(!isDefined(level.var_23674b8f.var_80284ca5)) {
      level.var_23674b8f.var_80284ca5 = [];
    } else if(!isarray(level.var_23674b8f.var_80284ca5)) {
      level.var_23674b8f.var_80284ca5 = array(level.var_23674b8f.var_80284ca5);
    }

    level.var_23674b8f.var_80284ca5[level.var_23674b8f.var_80284ca5.size] = array::pop_front(var_95d7a612);
  }

  iprintlnbold("<dev string:x65>" + level.var_23674b8f.var_80284ca5[0].script_noteworthy + "<dev string:x81>" + level.var_23674b8f.var_80284ca5[1].script_noteworthy);

    s_canister = level.var_23674b8f.var_5dca8c75;
  level.var_23674b8f.e_wisp = util::spawn_model(#"tag_origin", s_canister.origin - (0, 0, 64), s_canister.angles);
  e_wisp = level.var_23674b8f.e_wisp;
  e_wisp.e_model = util::spawn_model(#"p7_zm_ori_orb_wind", e_wisp.origin, e_wisp.angles);
  e_wisp.e_model linkto(e_wisp);
  e_wisp.e_model ghost();
  e_wisp clientfield::set("" + #"hash_b0298e980bd8da0", 1);
  e_wisp moveto(s_canister.origin + (0, 0, 64), 0.75);
  e_wisp waittill(#"movedone");
  level thread function_eddc2ed3();
  wait 3;
  n_time = distance(e_wisp.origin, level.var_23674b8f.var_80284ca5[0].origin) / 400;
  e_wisp moveto(level.var_23674b8f.var_80284ca5[0].origin + (0, 0, 64), n_time);
  e_wisp waittill(#"movedone");
  e_wisp thread function_fe82c566();
  level.var_23674b8f.e_player thread function_92344a03();
  level flag::wait_till(#"hash_7a55d8f4bd6917cb");
  level thread start_step_3();
}

private function_eddc2ed3() {
  if(zm_utility::is_classic()) {
    level.var_23674b8f.e_player zm_hms_util::function_51b752a9("vox_ww_y_ammo_pickup", 0);
    wait 1;

    if(!zm_white_main_quest::function_6cebbce1()) {
      level.var_23674b8f.e_player zm_white_util::function_491673da(#"hash_61ea1c56d8b85109");
    }
  }
}

private function_fe82c566() {
  self endon(#"death", #"hash_530fc6e3ae75d439");
  level.var_23674b8f.var_c8a6d360 = 0;

  while(true) {
    self.e_model setCanDamage(1);
    self.e_model val::set("quest_mk2y", "allowDeath", 0);
    s_notify = self.e_model waittill(#"damage");
    self.e_model setCanDamage(0);
    var_bc569584 = level.var_23674b8f.var_80284ca5[level.var_23674b8f.var_c8a6d360].origin;
    self moveto(var_bc569584, 0.3);
    self waittill(#"movedone");
    playFX(level._effect[#"portal_origin"], var_bc569584, (1, 0, 0), (0, 0, 1));
    playsoundatposition(#"evt_teleporter_out", var_bc569584);
    self clientfield::set("" + #"hash_b0298e980bd8da0", 0);
    level flag::set(#"hash_11513646e875455c");
    wait 10;
    level flag::clear(#"hash_11513646e875455c");
    level.var_23674b8f.var_c8a6d360++;

    if(level.var_23674b8f.var_c8a6d360 > level.var_23674b8f.var_80284ca5.size - 1) {
      level.var_23674b8f.var_c8a6d360 = 0;
    }

    self clientfield::set("" + #"hash_b0298e980bd8da0", 1);
    var_838db546 = level.var_23674b8f.var_80284ca5[level.var_23674b8f.var_c8a6d360].origin;
    self.origin = var_838db546 - (0, 0, 64);
    self moveto(var_838db546 + (0, 0, 64), 1);
    wait 0.5;
    playFX(level._effect[#"portal_dest"], var_838db546, (1, 0, 0), (0, 0, 1));
    playsoundatposition(#"evt_teleporter_go", var_838db546);
    self waittill(#"movedone");

    iprintlnbold("<dev string:x89>" + level.var_23674b8f.var_80284ca5[level.var_23674b8f.var_c8a6d360].script_noteworthy);

  }
}

private function_92344a03() {
  self endon(#"death", #"hash_376274afc09952fa");

  while(true) {
    var_135425aa = 0;
    self waittill(#"teleporting");
    var_8a3d3cf4 = level flag::get(#"hash_11513646e875455c");
    var_86812839 = 1;
    var_7ed14c5f = zm_white_portals::function_688df525();

    foreach(var_e2db3886 in level.var_23674b8f.var_80284ca5) {
      if(!isinarray(var_7ed14c5f, var_e2db3886)) {
        var_86812839 = 0;
        break;
      }
    }

    var_58ab2e2c = self.s_teleport === level.var_23674b8f.var_80284ca5[level.var_23674b8f.var_c8a6d360];

    if(var_8a3d3cf4 && var_86812839 && var_58ab2e2c) {
      wait 0.1;
      e_wisp = level.var_23674b8f.e_wisp;
      var_59bd625c = self getcentroid() + 20 * vectornormalize(anglesToForward(self.angles));
      var_59bd625c += 2 * vectornormalize(anglestoright(self.angles));
      var_59bd625c += (0, 0, 22);
      e_wisp.origin = var_59bd625c;
      e_wisp.angles = self.angles;
      e_wisp clientfield::set("" + #"hash_1e4555a911a24ab7", 1);
      wait 1.5;
      e_wisp moveto(self getcentroid(), 1);
      e_wisp waittill(#"movedone");
      e_wisp clientfield::set("" + #"hash_1e4555a911a24ab7", 0);
      var_135425aa = 1;

      iprintlnbold("<dev string:xa4>");

    }

    self waittill(#"teleporting_done");

    if(var_135425aa) {
      level flag::set(#"hash_7a55d8f4bd6917cb");
      level.var_23674b8f.e_wisp notify(#"hash_530fc6e3ae75d439");
      self notify(#"hash_376274afc09952fa");
    }
  }
}

function_631ca480() {
  if(isDefined(level.var_23674b8f.e_wisp)) {
    if(isDefined(level.var_23674b8f.e_wisp.e_model)) {
      level.var_23674b8f.e_wisp.e_model delete();
    }

    level.var_23674b8f.e_wisp delete();
  }
}

cleanup_step_2() {
  function_631ca480();
}

start_step_3() {
  level endon(#"end_game", #"hash_36fd0ff497e7cb39");
  level.var_23674b8f.n_step = 3;
  wait 0.25;
  e_wisp = level.var_23674b8f.e_wisp;
  e_wisp clientfield::set("" + #"hash_b0298e980bd8da0", 1);
  e_wisp.origin = level.var_23674b8f.e_player getcentroid();
  e_wisp.angles = level.var_23674b8f.e_player.angles;
  var_59bd625c = level.var_23674b8f.e_player getcentroid() + 96 * vectornormalize(anglesToForward(level.var_23674b8f.e_player.angles));
  var_59bd625c += (0, 0, 32);
  e_wisp moveto(var_59bd625c, 0.5);
  e_wisp waittill(#"movedone");
  wait 3;

  if(!zm_white_main_quest::function_6cebbce1() && zm_utility::is_classic()) {
    level.var_23674b8f.e_player thread zm_white_util::function_491673da(#"hash_6942fd3186464801");
  }

  var_3d7dfe05 = struct::get("mk2y_defend");
  n_time = distance(e_wisp.origin, var_3d7dfe05.origin) / 400;
  e_wisp moveto(var_3d7dfe05.origin, n_time);
  e_wisp waittill(#"movedone");
  var_3d7dfe05 = struct::get("mk2y_defend");
  var_3d7dfe05 zm_unitrigger::function_fac87205(&function_18a1849f, 96, 0, 1);
  level.var_23674b8f.var_fead3ae9 = util::spawn_model(var_3d7dfe05.model, var_3d7dfe05.origin, var_3d7dfe05.angles);
  level.var_23674b8f.var_fead3ae9 thread function_2b0060b8();
  playsoundatposition("evt_rgun_frame_putback", (1046, -1606, -259));
  namespace_bd74bbd2::start(#"sc_mk2y");
}

private function_2b0060b8() {
  self endon(#"death");
  var_a28e7c1f = self.origin + (0, 0, 1);
  var_ae661658 = self.origin - (0, 0, 1);

  for(var_4814cac6 = 1; true; var_4814cac6 = !var_4814cac6) {
    if(var_4814cac6) {
      self moveto(var_a28e7c1f, 2, 1, 1);
    } else {
      self moveto(var_ae661658, 2, 1, 1);
    }

    self rotatevelocity((0, 90, 0), 4);
    self waittill(#"movedone");
  }
}

private function_a66f0de2() {
  namespace_bd74bbd2::end(#"sc_mk2y");
  s_unitrigger = level.var_23674b8f.var_fead3ae9 zm_item_pickup::create_item_pickup(&function_b9a31cb, &function_f6048ee, &function_5b4f9f76);
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
  level.var_23674b8f.var_fead3ae9 setModel(#"hash_7b9a3cdf5dd8b4d7");
  level.var_23674b8f.var_fead3ae9 clientfield::set("" + #"hash_70251001fe8c4abe", 1);
}

private function_b9a31cb(e_item, e_player) {

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(e_player.name + "<dev string:xc1>");
    println(e_player.name + "<dev string:xc1>");
  }

    zm_ui_inventory::function_7df6bb60("zm_white_ww_mk2y_ammo", 2, e_player);
  e_player.var_f7694097 = 2;
  e_player playSound("evt_canister_pickup");
  level.var_23674b8f.e_wisp clientfield::set("" + #"hash_b0298e980bd8da0", 0);
  level.var_23674b8f.e_wisp.e_model delete();
  level.var_23674b8f.e_wisp delete();
  start_step_4();

  if(!zm_white_main_quest::function_6cebbce1() && zm_utility::is_classic()) {
    level.var_23674b8f.e_player thread zm_white_util::function_491673da(#"hash_4164610d88a43d16");
  }
}

private function_17f3e9e2() {
  s_unitrigger = level.var_23674b8f.var_fead3ae9 zm_unitrigger::create(&function_7015dc35, 96);
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
  level.var_23674b8f.var_fead3ae9 thread function_2ac1278b();
}

private function_7015dc35(e_player) {
  if(isDefined(e_player)) {
    if(level.var_23674b8f.e_player === e_player) {
      self sethintstring(#"hash_14eae7c162ebb8d2");
    } else {
      self sethintstring(#"hash_2054e8fdb6521566");
    }

    return true;
  }

  return false;
}

private function_2ac1278b() {
  self endon(#"death");

  while(true) {
    s_notify = self waittill(#"trigger_activated");
    e_player = s_notify.e_who;

    if(function_18a1849f(e_player)) {
      namespace_bd74bbd2::start(#"sc_mk2y");
      zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
      break;
    }
  }
}

cleanup_step_3() {
  function_631ca480();

  if(isDefined(level.var_23674b8f.var_fead3ae9)) {
    namespace_bd74bbd2::end(#"sc_mk2y");
    level.var_23674b8f.var_fead3ae9 delete();
    return;
  }

  s_sc = struct::get("mk2y_defend");
  s_sc notify(#"stop_think");
  zm_unitrigger::unregister_unitrigger(s_sc.s_unitrigger);
}

private start_step_4() {
  level.var_23674b8f.e_player thread function_cba90c3c();
  level.var_23674b8f.n_step = 4;
}

private function_cba90c3c() {
  self endon(#"death");
  self waittill(#"hash_13f3f231b45420ef");

  if(zm_utility::is_classic()) {
    if(!zm_white_main_quest::function_6cebbce1()) {
      level.var_23674b8f.e_player zm_white_util::function_491673da(#"hash_4b04746b2f367ca3");
    }

    level.var_23674b8f.e_player zm_hms_util::function_51b752a9("vox_ww_y_craft", 0);
  }

  complete_quest();
}

private complete_quest() {

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(level.var_23674b8f.e_player.name + "<dev string:xde>");
    println(level.var_23674b8f.e_player.name + "<dev string:xde>");
  }

    level.var_23674b8f.e_player = undefined;
  level.var_23674b8f.n_step = 5;
}

private on_disconnect() {
  if(function_18a1849f(self)) {
    restart_quest();
  }
}

private restart_quest(var_e19b7aed = 1) {
  level notify(#"hash_36fd0ff497e7cb39");

  switch (level.var_23674b8f.n_step) {
    case 1:
      cleanup_step_1();
      var_e19b7aed = 0;
      break;
    case 2:
      cleanup_step_2();
      break;
    case 3:
      cleanup_step_3();
      break;
  }

  level.var_23674b8f.e_player = undefined;

  if(var_e19b7aed) {
    start_step_1();
  }
}

function_cbeb9a33() {
  level waittill(#"insanity_mode_triggered");
  restart_quest(0);
}