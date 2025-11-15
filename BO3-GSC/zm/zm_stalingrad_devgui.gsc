/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_devgui.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_ai_raps;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_placeable_mine;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_dragon_strike;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_stalingrad_dragon;
#using scripts\zm\zm_stalingrad_dragon_strike;
#using scripts\zm\zm_stalingrad_drop_pods;
#using scripts\zm\zm_stalingrad_ee_main;
#using scripts\zm\zm_stalingrad_finger_trap;
#using scripts\zm\zm_stalingrad_pap_quest;
#using scripts\zm\zm_stalingrad_util;
#namespace zm_stalingrad_devgui;

function function_91912a79() {
  zm_devgui::add_custom_devgui_callback( & function_17d8768b);
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  if(getdvarint("") > 0) {
    level thread function_867cb8b1();
  }
}

function function_867cb8b1() {
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
}

function function_17d8768b(cmd) {
  switch (cmd) {
    case "": {
      level thread function_2b22d1f9();
      return true;
    }
    case "": {
      level thread function_a7e8b47b();
      return true;
    }
    case "": {
      level thread function_31f1d173(0);
      return true;
    }
    case "": {
      level thread function_31f1d173(1);
      return true;
    }
    case "": {
      level thread function_31f1d173(2);
      return true;
    }
    case "": {
      level thread function_31f1d173(3);
      return true;
    }
    case "": {
      level thread function_cc40b263();
      return true;
    }
    case "":
    case "":
    case "":
    case "":
    case "":
    case "":
    case "":
    case "":
    case "":
    case "":
    case "":
    case "": {
      level.var_8cc024f2 = level.var_583e4a97.var_5d8406ed[cmd];
      level thread namespace_2e6e7fce::function_d1a91c4f(level.var_8cc024f2);
      return true;
    }
    case "": {
      level thread dragon::function_16734812();
      return true;
    }
    case "": {
      level thread dragon::function_e7982921();
      return true;
    }
    case "": {
      level thread dragon::function_cfe0d523();
      return true;
    }
    case "": {
      level thread dragon::function_5f0cb06e();
      return true;
    }
    case "": {
      level thread dragon::function_84bd37c8();
      return true;
    }
    case "": {
      level thread dragon::dragon_hazard_library();
      return true;
    }
    case "": {
      level thread dragon::function_7977857();
      return true;
    }
    case "": {
      level thread dragon::function_b8de630a();
      return true;
    }
    case "": {
      level thread dragon::function_941c2339();
      return true;
    }
    case "": {
      level thread dragon::function_ef4a09c3();
      return true;
    }
    case "": {
      level thread dragon::function_c09859f();
      return true;
    }
    case "": {
      level thread dragon::function_372d0868();
      break;
    }
    case "": {
      level thread dragon::function_21b70393();
      break;
    }
    case "": {
      level thread dragon::function_482eea0f(1);
      break;
    }
    case "": {
      level thread dragon::function_482eea0f(2);
      break;
    }
    case "": {
      level thread dragon::function_482eea0f(3);
      break;
    }
    case "": {
      level thread dragon::function_482eea0f(4);
      break;
    }
    case "": {
      level notify("hash_2b2c1420");
      break;
    }
    case "": {
      level thread function_4b210fe6();
      return true;
    }
    case "": {
      level thread function_4b210fe6("");
      return true;
    }
    case "": {
      level thread function_4b210fe6("");
      return true;
    }
    case "": {
      level thread function_4b210fe6("");
      return true;
    }
    case "": {
      level thread function_a5a0adb4();
      return true;
    }
    case "": {
      level thread function_bf490b3c();
      return true;
    }
    case "": {
      level thread function_1b0d61c5();
      return true;
    }
    case "": {
      level thread function_fd68eee0();
      return true;
    }
    case "": {
      level thread zm_stalingrad_finger_trap::function_ddb9991b();
      return true;
    }
    case "": {
      level thread zm_stalingrad_finger_trap::function_fc99caf5();
      return true;
    }
    case "": {
      level flag::set("");
      level flag::set("");
      util::wait_network_frame();
      level notify("hash_68bf9f79");
      util::wait_network_frame();
      level notify("hash_b227a45b");
      util::wait_network_frame();
      level notify("hash_9b46a273");
      return true;
    }
    case "": {
      level flag::set("");
      level flag::set("");
      return true;
    }
    case "": {
      level flag::set("");
      level flag::set("");
      return true;
    }
    case "": {
      level flag::set("");
      level flag::set("");
      level notify("hash_b7bed0ed");
      return true;
    }
    case "": {
      function_c072d3dc();
      return true;
    }
    case "": {
      function_4be43f4d();
      return true;
    }
    case "": {
      function_354ff582();
      return true;
    }
    case "": {
      function_f0aaa402();
      return true;
    }
    case "": {
      function_b221d46();
      return true;
    }
    default: {
      return false;
    }
  }
}

function function_2b22d1f9() {
  level flag::set("");
  s_pavlov_player = struct::get_array("", "");
  var_9544a498 = 0;
  foreach(player in level.activeplayers) {
    player setorigin(s_pavlov_player[var_9544a498].origin);
    player setplayerangles(s_pavlov_player[var_9544a498].angles);
  }
  level flag::set("");
}

function function_cc40b263() {
  if(isDefined(level.var_8cc024f2)) {
    iprintlnbold("");
    return false;
  }
  level zm_stalingrad_pap::function_809fbbff();
}

function function_a7e8b47b() {
  var_1a0a3da9 = getEntArray("", "");
  var_ff1b68c0 = getent("", "");
  a_e_collision = getEntArray("", "");
  var_50e0150f = getEntArray("", "");
  var_b9e116c5 = getEntArray("", "");
  var_6f3f4356 = getnodearray("", "");
  if(level.var_de98e3ce.gates_open) {
    level.var_de98e3ce.gates_open = 0;
    foreach(e_collision in a_e_collision) {
      e_collision movez(600, 0.1);
      e_collision disconnectpaths();
    }
    foreach(e_gate in var_50e0150f) {
      e_gate movez(600, 0.25);
    }
    foreach(e_door in var_1a0a3da9) {
      e_door movex(114, 1);
      e_door disconnectpaths();
    }
    foreach(e_hatch in var_b9e116c5) {
      e_hatch rotateroll(-90, 1);
    }
    foreach(var_b0a376a4 in var_6f3f4356) {
      unlinktraversal(var_b0a376a4);
    }
    var_ff1b68c0 movey(-84, 1);
    level thread scene::play("");
  } else {
    level.var_de98e3ce.gates_open = 1;
    foreach(e_collision in a_e_collision) {
      e_collision connectpaths();
      e_collision movez(-600, 0.1);
    }
    foreach(e_gate in var_50e0150f) {
      e_gate movez(-600, 0.25);
    }
    foreach(e_door in var_1a0a3da9) {
      e_door movex(-114, 1);
      e_door connectpaths();
    }
    foreach(e_hatch in var_b9e116c5) {
      e_hatch rotateroll(90, 1);
    }
    foreach(var_b0a376a4 in var_6f3f4356) {
      linktraversal(var_b0a376a4);
    }
    var_ff1b68c0 movey(84, 1);
    var_21ce8765 = getent("", "");
    var_21ce8765 thread scene::play("");
  }
  return true;
}

function function_31f1d173(var_41ef115f) {
  level notify("hash_31f1d173");
  wait(1);
  switch (var_41ef115f) {
    case 0: {
      var_e0320b0b = 1;
      var_6e2a9bd0 = 2;
      n_exploder = 1;
      break;
    }
    case 1: {
      var_e0320b0b = 0;
      var_6e2a9bd0 = 2;
      n_exploder = 2;
      break;
    }
    case 2: {
      var_e0320b0b = 0;
      var_6e2a9bd0 = 1;
      n_exploder = 3;
      break;
    }
    case 3: {
      var_e0320b0b = 0;
      var_6e2a9bd0 = 1;
      var_942d1639 = 2;
      n_exploder = 4;
      break;
    }
  }
  level thread zm_stalingrad_pap::function_187a933f(var_e0320b0b);
  level thread zm_stalingrad_pap::function_187a933f(var_6e2a9bd0);
  if(isDefined(var_942d1639)) {
    level thread zm_stalingrad_pap::function_187a933f(var_942d1639);
  }
  exploder::exploder("");
  exploder::exploder("" + n_exploder);
  level util::waittill_any_timeout(20, "");
  level thread zm_stalingrad_pap::function_a71517e1(var_e0320b0b);
  level thread zm_stalingrad_pap::function_a71517e1(var_6e2a9bd0);
  if(isDefined(var_942d1639)) {
    level thread zm_stalingrad_pap::function_a71517e1(var_942d1639);
  }
  exploder::kill_exploder("" + n_exploder);
  exploder::kill_exploder("");
}

function function_4b210fe6(var_b87a2184) {
  dragon::function_30560c4b();
  dragon::function_cf119cfd();
  level flag::set("");
  level zm_stalingrad_util::function_3804dbf1();
  zm_stalingrad_util::function_adf4d1d0();
  if(isDefined(level.var_ef9c43d7)) {
    if(isDefined(level.var_ef9c43d7.var_fa4643fb)) {
      level.var_ef9c43d7.var_fa4643fb delete();
    }
    level.var_ef9c43d7 delete();
    level.var_ef9c43d7 = undefined;
  }
  level zm_zonemgr::enable_zone("");
  if(isDefined(var_b87a2184)) {
    level flag::init("");
    level flag::init(var_b87a2184, 1);
  }
}

function function_a5a0adb4() {
  if(level flag::get("")) {
    level zm_ai_raps::special_raps_spawn(6);
  } else {
    iprintlnbold("");
  }
}

function function_bf490b3c() {
  level endon("_zombie_game_over");
  level flag::wait_till("");
  while(!isDefined(level.var_cf6e9729)) {
    wait(0.05);
  }
  level.var_cf6e9729.var_65850094[1] = 1;
  level.var_cf6e9729.var_65850094[2] = 1;
  level.var_cf6e9729.var_65850094[3] = 1;
  level.var_cf6e9729.var_65850094[4] = 1;
  level.var_cf6e9729.var_65850094[5] = 1;
  level.var_cf6e9729.var_dad3d9bd = 9999999;
}

function function_1b0d61c5() {
  level flag::clear("");
  foreach(e_player in level.players) {
    e_player namespace_19e79ea1::function_8258d71c();
  }
}

function function_fd68eee0() {
  level flag::set("");
  foreach(e_player in level.players) {
    e_player namespace_19e79ea1::function_8258d71c();
  }
}

function function_c072d3dc() {
  luinotifyevent(&"", 1, 1);
}

function function_4be43f4d() {
  luinotifyevent(&"", 1, 0);
}

function function_354ff582() {
  level clientfield::set("", int(((level.time - level.n_gameplay_start_time) + 500) / 1000));
  level clientfield::set("", level.round_number);
}

function function_f0aaa402() {
  level clientfield::set("", int(((level.time - level.n_gameplay_start_time) + 500) / 1000));
}

function function_b221d46() {
  level clientfield::set("", int(((level.time - level.n_gameplay_start_time) + 500) / 1000));
}