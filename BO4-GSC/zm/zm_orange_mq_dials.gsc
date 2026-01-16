/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_mq_dials.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_orange_pablo;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_orange_mq_dials;

preload() {}

main() {
  level flag::init(#"dials_aquired");
  level flag::init(#"dials_done");
  level.var_62bfa1a6 = [];
  level.var_4cf6900e = [];
  level.var_4cf6900e[#"orange"] = struct::get("orange", "script_noteworthy");
  level.var_4cf6900e[#"blue"] = struct::get("blue", "script_noteworthy");
  level.var_4cf6900e[#"yellow"] = struct::get("yellow", "script_noteworthy");
  level.var_4cf6900e[#"violet"] = struct::get("violet", "script_noteworthy");

  foreach(s_dial in level.var_4cf6900e) {
    s_dial.var_e5f66b29 = 0;
    s_dial.b_correct = 0;
    s_dial.n_value = 0;
    s_dial.var_7bb4ff56 = randomintrangeinclusive(1, 9);
    s_dial.dial_model = getent(s_dial.target, "targetname");
    s_dial.dial_model hide();
  }

  function_5f228e90();
}

function_77ed3bab(var_5ea5c94d) {
  zm_ui_inventory::function_7df6bb60(#"zm_orange_objective_progress", 1);

  if(!var_5ea5c94d) {

    if(getdvarint(#"zm_debug_ee", 0)) {
      if(getdvarint(#"zm_debug_ee", 0)) {
        iprintlnbold("<dev string:x38>");
        println("<dev string:x38>");
      }
    }

    if(getdvarint(#"zm_debug_ee", 0)) {
      if(getdvarint(#"zm_debug_ee", 0)) {
        iprintlnbold("<dev string:x4c>");
        println("<dev string:x4c>");
      }
    }

      zm_orange_pablo::function_3f9e02b8(6, #"hash_2934f352bd60d6d6", #"hash_68fc56c1fbf3b972", &function_bd605daa);
    zm_orange_pablo::function_d83490c5(6);
    level flag::wait_till(#"dials_aquired");

    foreach(s_dial in level.var_4cf6900e) {
      s_dial zm_unitrigger::create("", 32);
      s_dial thread function_1e5c0d3b();
    }

    while(!function_5a73ee80()) {
      wait 1;
    }
  }
}

function_51ecc801(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    zm_orange_pablo::function_6aaeff92(6);

    foreach(s_dial in level.var_4cf6900e) {
      s_dial.var_e5f66b29 = 1;
      s_dial.b_correct = 1;
      s_dial.dial_model show();
    }
  }

  level flag::set(#"dials_done");
}

function_bd605daa() {
  level flag::set(#"dials_aquired");
}

function_5a73ee80() {
  b_done = 1;

  foreach(dial in level.var_4cf6900e) {
    if(!dial.b_correct) {
      b_done = 0;
    }
  }

  return b_done;
}

private function_1e5c0d3b() {
  level endon(#"end_game");

  while(!level flag::get(#"dials_done")) {
    s_results = self waittill(#"trigger_activated", #"dials_done");

    if(s_results._notify == #"dials_done") {
      return;
    }

    e_who = s_results.e_who;

    if(!self.var_e5f66b29) {
      self.var_e5f66b29 = 1;
      self.dial_model show();
      self.dial_model playSound("zmb_vessel_drop");
      wait 0.2;
      continue;
    }

    self.dial_model playSound("zmb_quest_dial_turn");
    b_left = e_who lavapit_breach_(self.dial_model);

    if(b_left) {
      self.dial_model rotatepitch(36, 0.2, 0.03, 0.06);
      wait 0.2;
      self.n_value++;
    } else {
      self.dial_model rotatepitch(-36, 0.2, 0.03, 0.06);
      wait 0.2;
      self.n_value--;
    }

    wait 0.2;

    if(self.n_value > 9) {
      self.n_value = 0;
    }

    if(self.n_value < 0) {
      self.n_value = 9;
    }

    if(self.n_value == self.var_7bb4ff56) {

      if(getdvarint(#"zm_debug_ee", 0)) {
        if(getdvarint(#"zm_debug_ee", 0)) {
          iprintlnbold("<dev string:x69>" + self.script_noteworthy + "<dev string:x71>");
          println("<dev string:x69>" + self.script_noteworthy + "<dev string:x71>");
        }
      }

        self.b_correct = 1;
      self.dial_model playSound("zmb_quest_dial_success");
      continue;
    }

    self.b_correct = 0;
  }
}

private lavapit_breach_(object) {
  v_origin = object.origin;

  if(isDefined(object.var_eb397f67)) {
    v_origin = object.var_eb397f67;
  }

  v_delta = vectornormalize(self getEye() - v_origin);
  v_angles = self getplayerangles();
  v_view = anglesToForward(v_angles);
  v_cross = vectorcross(v_view, v_delta);
  var_35b81369 = vectordot(v_cross, anglestoup(v_angles));

  if(var_35b81369 >= 0) {
    return 1;
  }

  return 0;
}

function_a02dfba() {
  var_aff5104e = getEntArray("mq_dial_number", "targetname");

  foreach(e_code in var_aff5104e) {
    e_code function_eb2835af();
  }
}

function_eb2835af() {
  a_str_tag_name = ["tag_blue_", "tag_orange_", "tag_violet_", "tag_yellow_"];

  foreach(str_tag in a_str_tag_name) {
    for(i = 0; i < 10; i++) {
      self hidepart(str_tag + i);
    }
  }
}

function_66365668(n_code) {
  switch (self.script_noteworthy) {
    case #"orange_code":
      self showpart("tag_orange_" + n_code);
      break;
    case #"blue_code":
      self showpart("tag_blue_" + n_code);
      break;
    case #"yellow_code":
      self showpart("tag_yellow_" + n_code);
      break;
    case #"violet_code":
      self showpart("tag_violet_" + n_code);
      break;
  }
}

function_5f228e90() {
  level function_a02dfba();

  if(zm_utility::is_ee_enabled()) {
    function_ca3efcd8(level.var_c205c941, "orange_code", level.var_4cf6900e[#"orange"].var_7bb4ff56);
    function_ca3efcd8(level.var_c205c941, "blue_code", level.var_4cf6900e[#"blue"].var_7bb4ff56);
    function_ca3efcd8(level.var_c205c941, "yellow_code", level.var_4cf6900e[#"yellow"].var_7bb4ff56);
    function_ca3efcd8(level.var_c205c941, "violet_code", level.var_4cf6900e[#"violet"].var_7bb4ff56);
  }
}

function_ca3efcd8(e_code, str_noteworthy, n_code) {
  var_127789d1 = randomint(3);
  a_e_codes = zm_hms_util::function_bffcedde(str_noteworthy, "script_noteworthy", "script_int");
  level.var_c205c941[str_noteworthy] = a_e_codes[var_127789d1];
  level.var_c205c941[str_noteworthy] function_66365668(n_code);

  for(i = 0; i < a_e_codes.size; i++) {
    if(i != var_127789d1) {
      a_e_codes[i] delete();
    }
  }

  waitframe(1);
}