/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_wisps.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_genesis_util;
#using scripts\zm\zm_genesis_vo;
#namespace zm_genesis_wisps;

function autoexec __init__sytem__() {
  system::register("zm_genesis_wisps", & __init__, & __main__, undefined);
}

function __init__() {
  clientfield::register("toplayer", "set_funfact_fx", 15000, 3, "int");
  clientfield::register("scriptmover", "wisp_fx", 15000, 2, "int");
  callback::on_disconnect( & on_player_disconnect);
}

function __main__() {
  if(getdvarint("") > 0) {
    level thread function_a9d6e3ef();
  }
  level waittill("start_zombie_round_logic");
  level flag::init("funfacts_started");
  level flag::init("funfacts_activated");
  level thread function_d1c51308();
  level thread function_bce246fa();
}

function on_player_disconnect() {
  self clientfield::set_to_player("set_funfact_fx", 0);
}

function function_d1c51308() {
  level.a_wisps = [];
  level.a_wisps["s_trig"] = struct::get_array("s_trig_wisp", "targetname");
  level.a_wisps["s_fx"] = struct::get_array("s_fx_wisp", "targetname");
  foreach(s_trig in level.a_wisps["s_trig"]) {
    s_unitrigger = s_trig zm_unitrigger::create_unitrigger(&"", 64, & function_836f0458);
    s_unitrigger.require_look_at = 1;
  }
  level thread function_f61f49b0();
}

function function_f61f49b0() {
  var_96cdbf35 = array("abcd", "abcd", "shad");
  var_6cf8e556 = array("shad", "abcd");
  while (true) {
    str_notify = level util::waittill_any_return("wisps_on_abcd", "wisps_on_shad", "boss_round_end_vo_done", "chaos_round_end_vo_done", "wisps_off");
    if(str_notify == "wisps_on_abcd") {
      zm_genesis_vo::function_4821b1a3("abcd");
      function_719d3043(1, "abcd");
    } else {
      if(str_notify == "wisps_on_shad") {
        zm_genesis_vo::function_4821b1a3("shad");
        function_719d3043(1, "shad");
      } else {
        if(str_notify == "boss_round_end_vo_done" && var_6cf8e556.size > 0) {
          var_effd4dcc = var_6cf8e556[0];
          zm_genesis_vo::function_4821b1a3(var_effd4dcc);
          function_719d3043(1, var_effd4dcc);
          arrayremoveindex(var_6cf8e556, 0, 0);
        } else {
          if(str_notify == "chaos_round_end_vo_done" && var_96cdbf35.size > 0) {
            var_effd4dcc = var_96cdbf35[0];
            zm_genesis_vo::function_4821b1a3(var_effd4dcc);
            function_719d3043(1, var_effd4dcc);
            arrayremoveindex(var_96cdbf35, 0, 0);
          } else if(str_notify == "wisps_off") {
            function_719d3043(0, undefined);
          }
        }
      }
    }
  }
}

function function_719d3043(b_on = 1, str_who) {
  if(b_on) {
    assert(str_who == "" || str_who == "", "");
    level.var_c1feb276 = "wisp_" + str_who;
    foreach(s_trig in level.a_wisps["s_trig"]) {
      s_trig thread function_26ed5998(1, str_who);
    }
  } else {
    level.var_11db95ba = "wisp_off";
    foreach(s_trig in level.a_wisps["s_trig"]) {
      s_trig thread function_26ed5998(0, str_who);
    }
  }
}

function function_26ed5998(b_on = 1, str_who = "abcd") {
  var_c4217816 = [];
  var_c4217816["abcd"] = 1;
  var_c4217816["shad"] = 2;
  if(isdefined(self)) {
    if(b_on && !isdefined(self.var_3dc2890d)) {
      s_fx = struct::get(self.target, "targetname");
      self.var_3dc2890d = util::spawn_model("tag_origin", s_fx.origin, s_fx.angles);
      self.var_3dc2890d clientfield::set("wisp_fx", var_c4217816[str_who]);
      self.s_unitrigger.b_on = 1;
      self thread function_3bcaa1c();
    } else if(isdefined(self.var_3dc2890d)) {
      self.var_3dc2890d delete();
      self notify("hash_d8f13b7d");
      self.s_unitrigger.b_on = 0;
    }
  }
}

function function_3bcaa1c() {
  self endon("hash_d8f13b7d");
  while (true) {
    self waittill("trigger_activated", e_player);
    zm_utility::debug_print("");
    if(level.var_c1feb276 != "off" && !level flag::get("abcd_speaking") && !level flag::get("shadowman_speaking")) {
      level thread zm_genesis_vo::function_10b9b50e(level.var_c1feb276);
      self thread function_26ed5998(0);
    }
  }
}

function function_836f0458(e_player) {
  if(isdefined(self.stub.b_on) && self.stub.b_on && level.var_c1feb276 !== "off") {
    self sethintstring("");
    return true;
  }
  self sethintstring("");
  return false;
}

function function_bce246fa() {
  level.var_e2304a21 = [];
  level.var_e2304a21["s_trig"] = [];
  level.var_e2304a21["s_trig"][0] = struct::get("s_trig_funfact_demp", "targetname");
  level.var_e2304a21["s_trig"][1] = struct::get("s_trig_funfact_niko", "targetname");
  level.var_e2304a21["s_trig"][2] = struct::get("s_trig_funfact_rich", "targetname");
  level.var_e2304a21["s_trig"][3] = struct::get("s_trig_funfact_take", "targetname");
  level.var_e2304a21["s_fx"] = [];
  level.var_e2304a21["s_fx"][0] = struct::get("s_fx_funfact_demp", "targetname");
  level.var_e2304a21["s_fx"][1] = struct::get("s_fx_funfact_niko", "targetname");
  level.var_e2304a21["s_fx"][2] = struct::get("s_fx_funfact_rich", "targetname");
  level.var_e2304a21["s_fx"][3] = struct::get("s_fx_funfact_take", "targetname");
  foreach(s_trig in level.var_e2304a21["s_trig"]) {
    s_unitrigger = s_trig zm_unitrigger::create_unitrigger(&"", 64, & function_caef395a);
    s_unitrigger.require_look_at = 1;
    s_unitrigger.script_int = s_trig.script_int;
  }
  level thread function_b177eb62();
}

function function_b177eb62() {
  var_76bf4ac6 = level.var_783db6ab;
  while (true) {
    str_wait = util::waittill_any_return("start_of_round");
    if(level.round_number > var_76bf4ac6) {
      while (level flag::get("abcd_speaking") || level flag::get("shadowman_speaking")) {
        wait(0.1);
      }
      level thread function_cf810f3f(1);
    }
  }
}

function function_cf810f3f(b_on = 1) {
  foreach(s_trig in level.var_e2304a21["s_trig"]) {
    s_trig thread function_584171ff(b_on);
  }
}

function function_584171ff(b_on = 1) {
  if(isdefined(self)) {
    if(b_on && (!(isdefined(self.s_unitrigger.b_on) && self.s_unitrigger.b_on)) && level.var_8c92b387["fun_facts"][self.script_int].size > 0) {
      e_player = zm_utility::get_specific_character(self.script_int);
      if(isdefined(e_player)) {
        e_player thread set_funfact_fx(1);
      }
      self.s_unitrigger.b_on = 1;
      self thread function_198aed06();
    } else if(!b_on) {
      e_player = zm_utility::get_specific_character(self.script_int);
      if(isdefined(e_player)) {
        e_player thread set_funfact_fx(0);
      }
      self.s_unitrigger.b_on = 0;
      self notify("hash_d8f13b7d");
    }
  }
}

function set_funfact_fx(b_on = 1) {
  if(b_on) {
    var_f111a90b = self.characterindex + 1;
    self clientfield::set_to_player("set_funfact_fx", var_f111a90b);
  } else {
    self clientfield::set_to_player("set_funfact_fx", 0);
  }
}

function function_198aed06() {
  self endon("hash_77f5f32b");
  while (true) {
    self waittill("trigger_activated", e_player);
    zm_utility::debug_print("");
    if(self.script_int == e_player.characterindex && !level flag::get("abcd_speaking") && !level flag::get("shadowman_speaking")) {
      self thread function_584171ff(0);
      if(!level flag::get("funfacts_started")) {
        level thread zm_genesis_vo::function_36734069();
        level flag::set("funfacts_started");
      } else {
        if(!level flag::get("funfacts_activated")) {
          level flag::set("funfacts_activated");
          level zm_genesis_vo::function_2050fb34();
          level thread zm_genesis_vo::function_bbeae714(e_player.characterindex);
        } else {
          level thread zm_genesis_vo::function_bbeae714(e_player.characterindex);
        }
      }
    }
  }
}

function function_caef395a(e_player) {
  if(isdefined(self.stub.b_on) && self.stub.b_on) {
    if(self.stub.script_int == e_player.characterindex) {
      self sethintstring("");
      return true;
    }
    self sethintstring("");
    return false;
  }
  self sethintstring("");
  return false;
}

function function_a9d6e3ef() {
  level thread zm_genesis_util::setup_devgui_func("", "", 0, & function_d4b54e53);
  level thread zm_genesis_util::setup_devgui_func("", "", 1, & function_d4b54e53);
  level thread zm_genesis_util::setup_devgui_func("", "", 2, & function_d4b54e53);
  level thread zm_genesis_util::setup_devgui_func("", "", 3, & function_d4b54e53);
  level thread zm_genesis_util::setup_devgui_func("", "", 0, & function_910a409b);
  level thread zm_genesis_util::setup_devgui_func("", "", 1, & function_910a409b);
  level thread zm_genesis_util::setup_devgui_func("", "", 2, & function_910a409b);
  level thread zm_genesis_util::setup_devgui_func("", "", 3, & function_910a409b);
  level thread zm_genesis_util::setup_devgui_func("", "", 0, & function_920920c8);
  level thread zm_genesis_util::setup_devgui_func("", "", 1, & function_920920c8);
  level thread zm_genesis_util::setup_devgui_func("", "", 2, & function_920920c8);
  level thread zm_genesis_util::setup_devgui_func("", "", 3, & function_920920c8);
  level thread zm_genesis_util::setup_devgui_func("", "", 1, & function_4701ab9e);
  level thread zm_genesis_util::setup_devgui_func("", "", 2, & function_4701ab9e);
  level thread zm_genesis_util::setup_devgui_func("", "", 1, & function_76a93e50);
  level thread zm_genesis_util::setup_devgui_func("", "", 2, & function_76a93e50);
  level thread zm_genesis_util::setup_devgui_func("", "", 1, & function_eaebf31c);
  level thread zm_genesis_util::setup_devgui_func("", "", 2, & function_eaebf31c);
  level thread zm_genesis_util::setup_devgui_func("", "", 0, & function_eaebf31c);
  level thread zm_genesis_util::setup_devgui_func("", "", 0, & function_371c89ce);
  level thread zm_genesis_util::setup_devgui_func("", "", 1, & function_371c89ce);
  level thread zm_genesis_util::setup_devgui_func("", "", 2, & function_371c89ce);
  level thread zm_genesis_util::setup_devgui_func("", "", 3, & function_371c89ce);
}

function function_68f439f5(n_val) {
  player = level.activeplayers[n_val];
  if(isdefined(player)) {
    player set_funfact_fx(1);
  }
}

function function_12821101(n_val) {
  player = level.activeplayers[n_val];
  if(isdefined(player)) {
    player set_funfact_fx(0);
  }
}

function function_910a409b(n_val) {
  foreach(s_trig in level.var_e2304a21[""]) {
    if(s_trig.script_int == n_val) {
      s_trig thread function_584171ff(1);
      break;
    }
  }
}

function function_d4b54e53(n_val) {
  var_f0f08a9d = array("", "", "", "");
  s_dest = struct::get(var_f0f08a9d[n_val], "");
  if(isdefined(s_dest)) {
    player = level.activeplayers[0];
    var_5d8a4d6d = util::spawn_model("", player.origin, player.angles);
    player linkto(var_5d8a4d6d);
    var_5d8a4d6d.origin = s_dest.origin;
    wait(0.5);
    player unlink();
  }
}

function function_96632750(n_val) {
  zm_genesis_vo::function_bbeae714(level.activeplayers[n_val].characterindex);
}

function function_920920c8(n_val) {
  zm_genesis_vo::function_bbeae714(n_val);
}

function function_4701ab9e(n_val) {
  if(n_val == 1) {
    zm_genesis_vo::function_10b9b50e("");
  } else {
    zm_genesis_vo::function_10b9b50e("");
  }
}

function function_76a93e50(n_val) {
  if(n_val == 1) {
    zm_genesis_vo::function_4821b1a3("");
  } else {
    zm_genesis_vo::function_4821b1a3("");
  }
}

function function_eaebf31c(n_val) {
  if(n_val == 1) {
    level notify("wisps_on_abcd");
  } else {
    if(n_val == 2) {
      level notify("wisps_on_shad");
    } else if(n_val == 0) {
      level notify("wisps_off");
    }
  }
}

function function_371c89ce(n_val) {
  var_f0f08a9d = array("", "", "", "");
  s_dest = struct::get(var_f0f08a9d[n_val]);
  if(isdefined(s_dest)) {
    player = level.activeplayers[0];
    var_5d8a4d6d = util::spawn_model("", player.origin, player.angles);
    player linkto(var_5d8a4d6d);
    var_5d8a4d6d.origin = s_dest.origin;
    wait(0.5);
    player unlink();
    var_5d8a4d6d delete();
  }
}