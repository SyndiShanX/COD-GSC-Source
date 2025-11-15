/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_anywhere_but_here.gsc
*******************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_bgb_anywhere_but_here;

autoexec __init__system__() {
  system::register(#"zm_bgb_anywhere_but_here", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  level._effect[#"teleport_splash"] = "zombie/fx_bgb_anywhere_but_here_teleport_zmb";
  level._effect[#"teleport_aoe"] = "zombie/fx_bgb_anywhere_but_here_teleport_aoe_zmb";
  level._effect[#"teleport_aoe_kill"] = "zombie/fx_bgb_anywhere_but_here_teleport_aoe_kill_zmb";
  bgb::register(#"zm_bgb_anywhere_but_here", "activated", 1, undefined, undefined, &validation, &activation);
  bgb::function_72469efe(#"zm_bgb_anywhere_but_here", 1);
  bgb::function_8a5d8cfb(#"zm_bgb_anywhere_but_here", 1);
}

activation(var_fad9ed02 = 1) {
  self endon(#"disconnect");
  self val::set(#"bgb_anywhere_but_here", "ignoreme");
  self.var_ffe2c4d7 = 1;
  zm_ai_utility::function_594bb7bd(self);

  if(self zm_utility::function_ab9a9770()) {
    self.var_b520496e = 1;
  }

  if(ispointonnavmesh(self.origin)) {
    playsoundatposition(#"zmb_bgb_abh_teleport_out", self.origin);
  }

  if(isDefined(level.var_f44e37f7)) {
    s_respawn_point = self[[level.var_f44e37f7]]();
  } else {
    s_respawn_point = self function_91a62549();
  }

  if(isDefined(level.var_40f4bfe0) && level.var_40f4bfe0 || !isDefined(s_respawn_point) && !var_fad9ed02) {
    s_respawn_point = struct::spawn(self.origin, self.angles);
    var_16d4797c = getclosestpointonnavmesh(self.origin, 128, 24);
    s_respawn_point.origin = isDefined(var_16d4797c) ? var_16d4797c : s_respawn_point.origin;
  }

  assert(isDefined(s_respawn_point), "<dev string:x38>" + self.origin);

  if(!isDefined(s_respawn_point)) {
    self val::reset(#"bgb_anywhere_but_here", "ignoreme");
    self.var_ffe2c4d7 = undefined;
    return;
  }

  if(isDefined(self.var_b520496e) && self.var_b520496e) {
    e_link = util::spawn_model("tag_origin", s_respawn_point.origin, s_respawn_point.angles);
    self setplayerangles(s_respawn_point.angles);
    self linkto(e_link);
  } else {
    self setorigin(s_respawn_point.origin);
    self setplayerangles(s_respawn_point.angles);
  }

  self val::set(#"bgb_anywhere_but_here", "freezecontrols", 1);
  v_return_pos = self.origin + (0, 0, 60);
  a_ai = getaiteamarray(level.zombie_team);
  a_closest = [];
  ai_closest = undefined;

  if(a_ai.size) {
    a_closest = arraysortclosest(a_ai, self.origin);

    foreach(ai in a_closest) {
      n_trace_val = ai sightconetrace(v_return_pos, self);

      if(n_trace_val > 0.2) {
        ai_closest = ai;
        break;
      }
    }

    if(isDefined(ai_closest)) {
      self setplayerangles(vectortoangles(ai_closest getcentroid() - v_return_pos));
    }
  }

  self playSound(#"zmb_bgb_abh_teleport_in");

  if(isDefined(level.var_a9c40fde)) {
    self[[level.var_a9c40fde]]();
  }

  wait 0.5;

  if(isDefined(self.var_b520496e) && self.var_b520496e) {
    self unlink();
    self.var_b520496e = undefined;
    e_link delete();
  }

  self show();
  playFX(level._effect[#"teleport_splash"], self.origin);
  playFX(level._effect[#"teleport_aoe"], self.origin);
  a_ai = getaiarray();
  a_aoe_ai = arraysortclosest(a_ai, self.origin, a_ai.size, 0, 200);

  foreach(ai in a_aoe_ai) {
    if(isactor(ai)) {
      if(ai.archetype === #"zombie") {
        playFX(level._effect[#"teleport_aoe_kill"], ai gettagorigin("j_spineupper"));
      } else {
        playFX(level._effect[#"teleport_aoe_kill"], ai.origin);
      }

      ai playSound(#"hash_22ff6701cf652785");
      ai.marked_for_recycle = 1;
      ai.has_been_damaged_by_player = 0;
      ai dodamage(ai.health + 1000, self.origin, self);
    }
  }

  wait 0.2;
  self val::reset(#"bgb_anywhere_but_here", "freezecontrols");

  if(var_fad9ed02) {
    self zm_stats::increment_challenge_stat(#"gum_gobbler_anywhere_but_here");
  }

  self.var_ffe2c4d7 = undefined;
  wait 3;
  self val::reset(#"bgb_anywhere_but_here", "ignoreme");
  self notify(#"hash_3e4335abc3d58a0b");
}

validation() {
  if(level.var_2439365b === #"turret") {
    return 0;
  }

  if(isDefined(level.zm_bgb_anywhere_but_here_validation_override)) {
    return [[level.zm_bgb_anywhere_but_here_validation_override]]();
  }

  s_point = function_91a62549();

  if(!isDefined(s_point)) {
    return 0;
  }

  return 1;
}

function_91a62549() {
  var_c73799d9 = zm_zonemgr::get_zone_from_position(self.origin + (0, 0, 32), 0);

  if(!isDefined(var_c73799d9)) {
    var_c73799d9 = self.zone_name;
  }

  if(isDefined(var_c73799d9)) {
    var_599d66bd = level.zones[var_c73799d9];
  }

  a_s_respawn_points = struct::get_array("player_respawn_point", "targetname");
  a_s_valid_respawn_points = [];

  foreach(s_respawn_point in a_s_respawn_points) {
    if(zm_utility::is_point_inside_enabled_zone(s_respawn_point.origin, var_599d66bd)) {
      if(!isDefined(a_s_valid_respawn_points)) {
        a_s_valid_respawn_points = [];
      } else if(!isarray(a_s_valid_respawn_points)) {
        a_s_valid_respawn_points = array(a_s_valid_respawn_points);
      }

      a_s_valid_respawn_points[a_s_valid_respawn_points.size] = s_respawn_point;
    }
  }

  if(isDefined(level.var_e120ae98)) {
    a_s_valid_respawn_points = [[level.var_e120ae98]](a_s_valid_respawn_points);
  }

  s_player_respawn = undefined;

  if(a_s_valid_respawn_points.size > 0) {
    var_53b1aa43 = array::random(a_s_valid_respawn_points);
    var_5ce8e5f9 = struct::get_array(var_53b1aa43.target, "targetname");

    foreach(var_5aff2c2c in var_5ce8e5f9) {
      n_script_int = self getentitynumber() + 1;

      if(var_5aff2c2c.script_int === n_script_int) {
        s_player_respawn = var_5aff2c2c;
      }
    }
  }

  return s_player_respawn;
}

function_886fce8f(b_enable = 1) {
  if(b_enable) {
    level.var_e120ae98 = level.var_ddf7e6bc;
    level.var_ddf7e6bc = undefined;
    level.var_40f4bfe0 = undefined;
    return;
  }

  level.var_ddf7e6bc = level.var_e120ae98;
  level.var_e120ae98 = &function_a124fd99;
  level.var_40f4bfe0 = 1;
}

function_a124fd99(var_6a069cf8) {
  return [];
}