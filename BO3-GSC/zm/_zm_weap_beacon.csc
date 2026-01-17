/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_beacon.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace _zm_weap_beacon;

function init() {
  level.w_beacon = getweapon("beacon");
  level.var_67735adb = "wpn_t7_zmb_hd_g_strike_world";
  level._effect["beacon_glow"] = "dlc5/tomb/fx_tomb_beacon_glow";
  level._effect["beacon_launch_fx"] = "dlc5/tomb/fx_tomb_beacon_launch";
  level._effect["beacon_shell_explosion"] = "dlc5/tomb/fx_tomb_beacon_exp";
  level._effect["beacon_shell_trail"] = "dlc5/tomb/fx_tomb_beacon_trail";
  clientfield::register("world", "play_launch_artillery_fx_robot_0", 21000, 1, "int", &function_59491961, 0, 0);
  clientfield::register("world", "play_launch_artillery_fx_robot_1", 21000, 1, "int", &function_59491961, 0, 0);
  clientfield::register("world", "play_launch_artillery_fx_robot_2", 21000, 1, "int", &function_59491961, 0, 0);
  clientfield::register("scriptmover", "play_beacon_fx", 21000, 1, "int", &function_dc4ed336, 0, 0);
  clientfield::register("scriptmover", "play_artillery_barrage", 21000, 2, "int", &play_artillery_barrage, 0, 0);
}

function function_59491961(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(issubstr(fieldname, 0)) {
    ai_robot = level.a_giant_robots[localclientnum][0];
  } else {
    if(issubstr(fieldname, 1)) {
      ai_robot = level.a_giant_robots[localclientnum][1];
    } else {
      ai_robot = level.a_giant_robots[localclientnum][2];
    }
  }
  if(newval == 1) {
    playFX(localclientnum, level._effect["beacon_launch_fx"], ai_robot gettagorigin("tag_rocketpod"));
    level thread function_d391c94e(ai_robot gettagorigin("tag_rocketpod"));
  }
}

function function_d391c94e(origin) {
  playSound(0, "zmb_homingbeacon_missiile_alarm", origin);
  for(i = 0; i < 5; i++) {
    playSound(0, "zmb_homingbeacon_missile_fire", origin);
    wait(0.15);
  }
}

function function_dc4ed336(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon("hash_962e0148");
  while(isDefined(self)) {
    playSound(0, "evt_beacon_beep", self.origin);
    playFXOnTag(localclientnum, level._effect["beacon_glow"], self, "origin_animate_jnt");
    wait(1.5);
  }
}

function play_artillery_barrage(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 0) {
    return;
  }
  if(newval == 1) {
    if(!isDefined(self.a_v_land_offsets)) {
      self.a_v_land_offsets = [];
    }
    if(!isDefined(self.a_v_land_offsets[localclientnum])) {
      self.a_v_land_offsets[localclientnum] = self build_weap_beacon_landing_offsets();
    }
    if(!isDefined(self.a_v_start_offsets)) {
      self.a_v_start_offsets = [];
    }
    if(!isDefined(self.a_v_start_offsets[localclientnum])) {
      self.a_v_start_offsets[localclientnum] = self build_weap_beacon_start_offsets();
    }
  }
  if(newval == 2) {
    if(!isDefined(self.a_v_land_offsets)) {
      self.a_v_land_offsets = [];
    }
    if(!isDefined(self.a_v_land_offsets[localclientnum])) {
      self.a_v_land_offsets[localclientnum] = self build_weap_beacon_landing_offsets_ee();
    }
    if(!isDefined(self.a_v_start_offsets)) {
      self.a_v_start_offsets = [];
    }
    if(!isDefined(self.a_v_start_offsets[localclientnum])) {
      self.a_v_start_offsets[localclientnum] = self build_weap_beacon_start_offsets_ee();
    }
  }
  if(!isDefined(self.var_f510f618)) {
    self.var_f510f618 = [];
  }
  if(!isDefined(self.var_f510f618[localclientnum])) {
    self.var_f510f618[localclientnum] = 0;
  }
  n_index = self.var_f510f618[localclientnum];
  v_start = self.origin + self.a_v_start_offsets[localclientnum][n_index];
  shell = spawn(localclientnum, v_start, "script_model");
  shell.angles = vectorscale((-1, 0, 0), 90);
  shell setModel("tag_origin");
  shell thread function_3700164e(self, n_index, v_start, localclientnum);
  self.var_f510f618[localclientnum]++;
}

function build_weap_beacon_landing_offsets() {
  a_offsets = [];
  a_offsets[0] = (0, 0, 0);
  a_offsets[1] = vectorscale((-1, 1, 0), 72);
  a_offsets[2] = vectorscale((1, 1, 0), 72);
  a_offsets[3] = vectorscale((1, -1, 0), 72);
  a_offsets[4] = vectorscale((-1, -1, 0), 72);
  return a_offsets;
}

function build_weap_beacon_start_offsets() {
  a_offsets = [];
  a_offsets[0] = vectorscale((0, 0, 1), 8500);
  a_offsets[1] = (-6500, 6500, 8500);
  a_offsets[2] = (6500, 6500, 8500);
  a_offsets[3] = (6500, -6500, 8500);
  a_offsets[4] = (-6500, -6500, 8500);
  return a_offsets;
}

function build_weap_beacon_landing_offsets_ee() {
  a_offsets = [];
  a_offsets[0] = (0, 0, 0);
  a_offsets[1] = vectorscale((-1, 1, 0), 72);
  a_offsets[2] = vectorscale((1, 1, 0), 72);
  a_offsets[3] = vectorscale((1, -1, 0), 72);
  a_offsets[4] = vectorscale((-1, -1, 0), 72);
  a_offsets[5] = vectorscale((-1, 1, 0), 72);
  a_offsets[6] = vectorscale((1, 1, 0), 72);
  a_offsets[7] = vectorscale((1, -1, 0), 72);
  a_offsets[8] = vectorscale((-1, -1, 0), 72);
  a_offsets[9] = vectorscale((-1, 1, 0), 72);
  a_offsets[10] = vectorscale((1, 1, 0), 72);
  a_offsets[11] = vectorscale((1, -1, 0), 72);
  a_offsets[12] = vectorscale((-1, -1, 0), 72);
  a_offsets[13] = vectorscale((-1, 1, 0), 72);
  a_offsets[14] = vectorscale((1, 1, 0), 72);
  return a_offsets;
}

function build_weap_beacon_start_offsets_ee() {
  a_offsets = [];
  a_offsets[0] = vectorscale((0, 0, 1), 8500);
  a_offsets[1] = (-6500, 6500, 8500);
  a_offsets[2] = (6500, 6500, 8500);
  a_offsets[3] = (6500, -6500, 8500);
  a_offsets[4] = (-6500, -6500, 8500);
  a_offsets[5] = (-6500, 6500, 8500);
  a_offsets[6] = (6500, 6500, 8500);
  a_offsets[7] = (6500, -6500, 8500);
  a_offsets[8] = (-6500, -6500, 8500);
  a_offsets[9] = (-6500, 6500, 8500);
  a_offsets[10] = (6500, 6500, 8500);
  a_offsets[11] = (6500, -6500, 8500);
  a_offsets[12] = (-6500, -6500, 8500);
  a_offsets[13] = (-6500, 6500, 8500);
  a_offsets[14] = (6500, 6500, 8500);
  return a_offsets;
}

function function_3700164e(model, index, v_start, localclientnum) {
  var_89ea469b = model.origin + model.a_v_land_offsets[localclientnum][index];
  v_start_trace = v_start - vectorscale((0, 0, 1), 5000);
  trace = bulletTrace(v_start_trace, var_89ea469b, 0, undefined);
  var_89ea469b = trace["position"];
  self moveto(var_89ea469b, 3);
  playFXOnTag(localclientnum, level._effect["beacon_shell_trail"], self, "tag_origin");
  self playSound(0, "zmb_homingbeacon_missile_boom");
  self thread function_42cb41ec(var_89ea469b);
  self waittill("movedone");
  if(index == 1) {
    model notify("hash_962e0148");
  }
  playFX(localclientnum, level._effect["beacon_shell_explosion"], self.origin);
  playSound(0, "wpn_rocket_explode", self.origin);
  self delete();
}

function function_42cb41ec(origin) {
  wait(2);
  playSound(0, "zmb_homingbeacon_missile_incoming", origin);
}