/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_34b02db2817b42f.gsc
***********************************************/

#include script_174ce72cc0f850;
#include script_724752ab26bff81b;
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
#include scripts\zm\zm_white_util;
#include scripts\zm_common\zm_item_pickup;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace namespace_90b0490e;

preload() {
  level flag::init(#"chimney_grenaded");
  level.var_74170866 = spawnStruct();
  level.var_74170866.n_step = 0;
  callback::on_disconnect(&on_disconnect);
  a_s_cabinets = struct::get_array("cabinet");
  a_s_cabinets = array::randomize(a_s_cabinets);
  level.var_74170866.s_cabinet = array::pop_front(a_s_cabinets);
  level.var_74170866.s_cabinet.a_e_doors = getEntArray(level.var_74170866.s_cabinet.target, "targetname");
  a_s_fireplaces = struct::get_array("fireplace_canister");
  a_s_fireplaces = array::randomize(a_s_fireplaces);
  level.var_74170866.s_fireplace = array::pop_front(a_s_fireplaces);
  a_parts = getEntArray(level.var_74170866.s_fireplace.target, "targetname");

  foreach(part in a_parts) {
    if(part.classname == "trigger_damage_new") {
      level.var_74170866.s_fireplace.var_7126b6eb = part;
      continue;
    }

    if(part.classname == "info_volume") {
      level.var_74170866.s_fireplace.var_72807128 = part;
    }
  }

  level.var_74170866.s_fireplace.var_b9989e12 = hash(level.var_74170866.s_fireplace.script_noteworthy);
  level.var_74170866.s_fireplace.var_7944be4a = 0;
  level.var_74170866.s_fireplace.var_7126b6eb triggerenable(0);

  foreach(s_fireplace in a_s_fireplaces) {
    a_parts = getEntArray(s_fireplace.target, "targetname");
    array::run_all(a_parts, &delete);
  }

  clientfield::register("scriptmover", "" + #"hash_2184dd4e9090521f", 20000, 1, "int");
  namespace_bd74bbd2::register(#"sc_mk2z_1", 20000, "sc_mk2z_1", &function_a66f0de2, &function_17f3e9e2);
  namespace_bd74bbd2::register(#"sc_mk2z_2", 20000, "sc_mk2z_2", &function_a66f0de2, &function_17f3e9e2);
  namespace_bd74bbd2::register(#"sc_mk2z_3", 20000, "sc_mk2z_3", &function_a66f0de2, &function_17f3e9e2);
}

private function_18a1849f(e_player) {
  if(!isDefined(level.var_74170866.e_player)) {
    return false;
  }

  return e_player === level.var_74170866.e_player;
}

private function_f6048ee(e_player) {
  if(isDefined(e_player)) {
    if(!isDefined(level.var_74170866.e_player)) {
      if(isDefined(e_player.var_9c20e2c9)) {
        self sethintstring(#"hash_744b68f010abb05");
      } else {
        self sethintstring(#"hash_12346bdab086516e");
      }
    } else if(level.var_74170866.e_player == e_player) {
      self sethintstring(#"hash_74fc96e8d58ff646");
    } else {
      self sethintstring(#"hash_2054e8fdb6521566");
    }

    return true;
  }

  return false;
}

private function_5b4f9f76(e_player) {
  var_2fff5cb5 = level.var_74170866.e_player === e_player;
  var_24441d81 = !isDefined(level.var_74170866.e_player) && !isDefined(e_player.var_9c20e2c9);
  return var_2fff5cb5 || var_24441d81;
}

start_quest() {
  start_step_1();
}

private start_step_1() {
  level thread function_cbeb9a33();

  iprintlnbold("<dev string:x38>");

  iprintlnbold("<dev string:x50>" + level.var_74170866.s_cabinet.script_string + "<dev string:x5a>");

    level.var_74170866.n_step = 1;
  s_cabinet = level.var_74170866.s_cabinet;
  e_canister = util::spawn_model(s_cabinet.model, s_cabinet.origin, s_cabinet.angles);
  s_cabinet.e_canister = e_canister;
  level thread run_step_1();
}

private run_step_1() {
  level endon(#"end_game", #"insanity_mode_triggered");

  if(isDefined(level.var_74170866.s_cabinet.a_e_doors[0])) {
    exploder::exploder("fxexp_mk2_Z_smoke_orange_emit_closet_" + level.var_74170866.s_cabinet.script_string);
    pixbeginevent(#"hash_3aea5406d9a5bdcf");

    foreach(e_door in level.var_74170866.s_cabinet.a_e_doors) {
      e_door setCanDamage(1);
      e_door val::set("quest_mk2z", "allowDeath", 0);
      e_door thread function_4b4ede();
    }

    level.var_74170866.s_cabinet waittill(#"burn_cabinet");
    pixendevent();
    exploder::stop_exploder("fxexp_mk2_Z_smoke_orange_emit_closet_" + level.var_74170866.s_cabinet.script_string);
    exploder::exploder("fxexp_mk2_Z_fire_closet_door_" + level.var_74170866.s_cabinet.script_string);
    wait 1;
    array::run_all(level.var_74170866.s_cabinet.a_e_doors, &delete);
    wait 0.5;
    exploder::stop_exploder("fxexp_mk2_Z_fire_closet_door_" + level.var_74170866.s_cabinet.script_string);
    s_cabinet = level.var_74170866.s_cabinet;
  }

  s_unitrigger = level.var_74170866.s_cabinet.e_canister zm_item_pickup::create_item_pickup(&function_9d66ea6f, &function_f6048ee, &function_5b4f9f76);
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
  waitframe(1);
  zm_unitrigger::reregister_unitrigger_as_dynamic(level.var_74170866.s_cabinet.e_canister.s_unitrigger);
}

function_4b4ede() {
  self endon(#"death", #"burn_cabinet");

  while(true) {
    s_notify = self waittill(#"damage");

    if(s_notify zm_hms_util::function_69320b44("zm_aat_plasmatic_burst")) {
      level.var_74170866.s_cabinet notify(#"burn_cabinet");

      foreach(e_door in level.var_74170866.s_cabinet.a_e_doors) {
        e_door setCanDamage(0);
        e_door notify(#"burn_cabinet");
      }

      break;
    }
  }
}

function_e08b0124(e_player) {
  self sethintstringforplayer(e_player, zm_utility::function_d6046228(#"hash_12346bdab086516e", #"hash_184ab2db21c5bc9a"));
  return true;
}

private function_9d66ea6f(e_item, e_player) {

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(e_player.name + "<dev string:x65>");
    println(e_player.name + "<dev string:x65>");
  }

    level.var_74170866.e_player = e_player;
  namespace_a01a2431::function_605e5c25(e_player);
  e_player.var_9c20e2c9 = 1;
  e_player playSound("evt_canister_pickup");
  zm_ui_inventory::function_7df6bb60("zm_white_ww_mod_phase", 3, e_player);
  zm_ui_inventory::function_7df6bb60("zm_white_ww_mk2z_ammo", 1, e_player);
  start_step_2();

  if(zm_utility::is_classic()) {
    level.var_74170866.e_player zm_hms_util::function_51b752a9("vox_ww_z_ammo_pickup", 0);

    if(!zm_white_main_quest::function_6cebbce1()) {
      level.var_74170866.e_player zm_white_util::function_491673da(#"hash_571c990866faa511");
    }
  }
}

private start_step_2() {

  iprintlnbold("<dev string:x92>");

    if(zm_white_main_quest::function_6cebbce1()) {

      iprintlnbold("<dev string:xaa>");

    }

  while(zm_white_main_quest::function_6cebbce1()) {
    wait 3;
  }

  exploder::exploder("fxexp_mk2_Z_smoke_chimney_" + level.var_74170866.s_fireplace.script_string + "_house");
  level.var_74170866.n_step = 2;
  level thread run_step_2();
}

private run_step_2() {
  level endon(#"end_game", #"hash_7456b125dbebe41c");
  pixbeginevent(#"hash_2573979b6db7cb52");

  iprintlnbold("<dev string:xfe>" + level.var_74170866.s_fireplace.script_string);

    level.var_74170866.s_fireplace.var_7126b6eb triggerenable(1);
  level thread function_7130498();
  level thread function_20b366ef();
  level flag::wait_till(#"chimney_grenaded");

  if(!zm_white_main_quest::function_6cebbce1() && zm_utility::is_classic()) {
    level.var_74170866.e_player thread zm_white_util::function_491673da(#"hash_5dc92cbe0fbe5da");
  }

  exploder::stop_exploder("fxexp_mk2_Z_smoke_chimney_" + level.var_74170866.s_fireplace.script_string + "_house");
  level.var_74170866.s_fireplace.var_7126b6eb triggerenable(0);
  wait 1;
  exploder::exploder("fxexp_mk2_Z_fire_chimney_" + level.var_74170866.s_fireplace.script_string + "_house");
  pixendevent();
  start_step_3();
}

private cleanup_step_2() {
  exploder::stop_exploder("fxexp_mk2_Z_smoke_chimney_" + level.var_74170866.s_fireplace.script_string + "_house");
}

function_7130498() {
  level endon(#"end_game");

  while(!level flag::get(#"chimney_grenaded")) {
    waitresult = level.var_74170866.s_fireplace.var_7126b6eb waittill(#"damage");

    if(istouching(waitresult.position, level.var_74170866.s_fireplace.var_7126b6eb)) {

      iprintlnbold("<dev string:x10f>");

        level flag::set(#"chimney_grenaded");
    }
  }
}

function_20b366ef() {
  level endon(#"end_game");

  while(!level flag::get(#"chimney_grenaded")) {
    s_waitresult = level waittill(#"hash_3042a9bf2f57ea0a");
    v_origin = s_waitresult.var_814c9389;

    if(istouching(v_origin, level.var_74170866.s_fireplace.var_7126b6eb)) {

      iprintlnbold("<dev string:x13c>");

        level flag::set(#"chimney_grenaded");
    }
  }
}

private start_step_3() {
  s_sc = level.var_74170866.s_fireplace;
  s_sc zm_unitrigger::create("", 96);
  s_sc thread function_473f437();
  level.var_74170866.n_step = 3;
}

private function_473f437() {
  self endon(#"death", #"stop_think");

  while(true) {
    s_notify = self waittill(#"trigger_activated");
    playsoundatposition("evt_rgun_frame_putback", (-759, -626, -7));

    if(function_18a1849f(s_notify.e_who)) {
      level.var_74170866.var_fead3ae9 = util::spawn_model("p8_zm_whi_fuse_pickup_fluid_magenta_pink_half", self.origin, self.angles);
      level.var_74170866.var_fead3ae9.var_b9989e12 = hash(self.script_noteworthy);
      namespace_bd74bbd2::start(level.var_74170866.var_fead3ae9.var_b9989e12);
      zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
      break;
    }
  }
}

private function_a66f0de2() {
  namespace_bd74bbd2::end(hash(level.var_74170866.s_fireplace.script_noteworthy));
  s_unitrigger = level.var_74170866.var_fead3ae9 zm_item_pickup::create_item_pickup(&function_b9a31cb, &function_f6048ee, &function_5b4f9f76, 96);
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
  level.var_74170866.var_fead3ae9 setModel("p8_zm_whi_fuse_pickup_fluid_magenta_pink");
  level.var_74170866.var_fead3ae9 clientfield::set("" + #"hash_2184dd4e9090521f", 1);
}

private function_b9a31cb(e_item, e_player) {

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(e_player.name + "<dev string:x16d>");
    println(e_player.name + "<dev string:x16d>");
  }

    exploder::stop_exploder("fxexp_mk2_Z_fire_chimney_" + level.var_74170866.s_fireplace.script_string + "_house");
  zm_ui_inventory::function_7df6bb60("zm_white_ww_mk2z_ammo", 2, e_player);
  e_player.var_f7694097 = 3;
  e_player playSound("evt_canister_pickup");
  start_step_4();

  if(!zm_white_main_quest::function_6cebbce1() && zm_utility::is_classic()) {
    e_player zm_white_util::function_491673da(#"hash_3fa02403cbe89e77");
  }
}

private function_17f3e9e2() {
  s_unitrigger = level.var_74170866.var_fead3ae9 zm_unitrigger::create(&function_7015dc35, 96);
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
  level.var_74170866.var_fead3ae9 thread function_2ac1278b();
}

private function_7015dc35(e_player) {
  if(isDefined(e_player)) {
    if(level.var_74170866.e_player === e_player) {
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
      namespace_bd74bbd2::start(self.var_b9989e12);
      zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
      break;
    }
  }
}

cleanup_step_3() {
  exploder::stop_exploder("fxexp_mk2_Z_fire_chimney_" + level.var_74170866.s_fireplace.script_string + "_house");

  if(isDefined(level.var_74170866.var_fead3ae9)) {
    namespace_bd74bbd2::end(hash(level.var_74170866.s_fireplace.script_noteworthy));
    level.var_74170866.var_fead3ae9 delete();
    return;
  }

  s_sc = level.var_74170866.s_fireplace;
  s_sc notify(#"stop_think");
  zm_unitrigger::unregister_unitrigger(s_sc.s_unitrigger);
}

private start_step_4() {
  level.var_74170866.e_player thread function_cba90c3c();
  level.var_74170866.n_step = 4;
}

private function_cba90c3c() {
  self endon(#"death");
  self waittill(#"hash_13f3f231b45420ef");

  if(zm_utility::is_classic()) {
    if(!zm_white_main_quest::function_6cebbce1()) {
      level.var_74170866.e_player zm_white_util::function_491673da(#"hash_4107574caf164040");
    }

    level.var_74170866.e_player zm_hms_util::function_51b752a9("vox_ww_z_craft", 0);
  }

  complete_quest();
}

private complete_quest() {

  if(getdvarint(#"hash_7919e37cd5d57659", 0)) {
    iprintlnbold(level.var_74170866.e_player.name + "<dev string:x18a>");
    println(level.var_74170866.e_player.name + "<dev string:x18a>");
  }

    level.var_74170866.e_player = undefined;
  level.var_74170866.n_step = 5;
}

private on_disconnect() {
  if(function_18a1849f(self)) {
    restart_quest();
  }
}

private restart_quest(var_e19b7aed = 1) {
  level notify(#"hash_7456b125dbebe41c");

  switch (level.var_74170866.n_step) {
    case 1:
      var_e19b7aed = 0;
      break;
    case 2:
      cleanup_step_2();
      break;
    case 3:
      cleanup_step_3();
      break;
  }

  level.var_74170866.e_player = undefined;

  if(var_e19b7aed) {
    start_step_1();
  }
}

function_cbeb9a33() {
  level waittill(#"insanity_mode_triggered");
  exploder::stop_exploder("fxexp_mk2_Z_smoke_orange_emit_closet_" + level.var_74170866.s_cabinet.script_string);

  if(isDefined(level.var_74170866.s_cabinet.e_canister) && isDefined(level.var_74170866.s_cabinet.e_canister.s_unitrigger)) {
    zm_unitrigger::unregister_unitrigger(level.var_74170866.s_cabinet.e_canister.s_unitrigger);
    level.var_74170866.s_cabinet.e_canister delete();
  }

  restart_quest(0);
}