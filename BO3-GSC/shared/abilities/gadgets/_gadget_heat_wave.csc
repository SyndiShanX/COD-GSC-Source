/**********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_heat_wave.csc
**********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\_burnplayer;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace _gadget_heat_wave;

function autoexec __init__sytem__() {
  system::register("gadget_heat_wave", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "heatwave_fx", 1, 1, "int", & set_heatwave_fx, 0, 0);
  clientfield::register("allplayers", "heatwave_victim", 1, 1, "int", & update_victim, 0, 0);
  clientfield::register("toplayer", "heatwave_activate", 1, 1, "int", & update_activate, 0, 0);
  level.debug_heat_wave_traces = getdvarint("scr_debug_heat_wave_traces", 0);
  visionset_mgr::register_visionset_info("heatwave", 1, 16, undefined, "heatwave");
  visionset_mgr::register_visionset_info("charred", 1, 16, undefined, "charred");
  level thread updatedvars();
}

function updatedvars() {
  while (true) {
    level.debug_heat_wave_traces = getdvarint("", level.debug_heat_wave_traces);
    wait(1);
  }
}

function update_activate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread postfx::playpostfxbundle("pstfx_heat_pulse");
  }
}

function update_victim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self endon("entityshutdown");
    self util::waittill_dobj(localclientnum);
    self playrumbleonentity(localclientnum, "heat_wave_damage");
    playtagfxset(localclientnum, "ability_hero_heat_wave_player_impact", self);
  }
}

function set_heatwave_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self clear_heat_wave_fx(localclientnum);
  if(newval) {
    self.heatwavefx = [];
    self thread aoe_fx(localclientnum);
  }
}

function clear_heat_wave_fx(localclientnum) {
  if(!isdefined(self.heatwavefx)) {
    return;
  }
  foreach(fx in self.heatwavefx) {
    stopfx(localclientnum, fx);
  }
}

function aoe_fx(localclientnum) {
  self endon("entityshutdown");
  center = self.origin + vectorscale((0, 0, 1), 30);
  startpitch = -90;
  yaw_count = [];
  yaw_count[0] = 1;
  yaw_count[1] = 4;
  yaw_count[2] = 6;
  yaw_count[3] = 8;
  yaw_count[4] = 6;
  yaw_count[5] = 4;
  yaw_count[6] = 1;
  pitch_vals = [];
  pitch_vals[0] = 90;
  pitch_vals[3] = 0;
  pitch_vals[6] = -90;
  trace = bullettrace(center, center + ((0, 0, -1) * 400), 0, self);
  if(trace["fraction"] < 1) {
    pitch_vals[1] = 90 - (atan(150 / (trace["fraction"] * 400)));
    pitch_vals[2] = 90 - (atan(300 / (trace["fraction"] * 400)));
  } else {
    pitch_vals[1] = 60;
    pitch_vals[2] = 30;
  }
  trace = bullettrace(center, center + ((0, 0, 1) * 400), 0, self);
  if(trace["fraction"] < 1) {
    pitch_vals[5] = -90 + (atan(150 / (trace["fraction"] * 400)));
    pitch_vals[4] = -90 + (atan(300 / (trace["fraction"] * 400)));
  } else {
    pitch_vals[5] = -60;
    pitch_vals[4] = -30;
  }
  currentpitch = startpitch;
  for (yaw_level = 0; yaw_level < yaw_count.size; yaw_level++) {
    currentpitch = pitch_vals[yaw_level];
    do_fx(localclientnum, center, yaw_count[yaw_level], currentpitch);
  }
}

function do_fx(localclientnum, center, yaw_count, pitch) {
  currentyaw = randomint(360);
  for (fxcount = 0; fxcount < yaw_count; fxcount++) {
    randomoffsetpitch = randomint(5) - 2.5;
    randomoffsetyaw = randomint(30) - 15;
    angles = (pitch + randomoffsetpitch, currentyaw + randomoffsetyaw, 0);
    tracedir = anglestoforward(angles);
    currentyaw = currentyaw + (360 / yaw_count);
    fx_position = center + (tracedir * 400);
    trace = bullettrace(center, fx_position, 0, self);
    sphere_size = 5;
    angles = (0, randomint(360), 0);
    forward = anglestoforward(angles);
    if(trace["fraction"] < 1) {
      fx_position = center + ((tracedir * 400) * trace["fraction"]);
      if(level.debug_heat_wave_traces) {
        sphere(fx_position, sphere_size, (1, 0, 1), 1, 1, 8, 300);
        sphere(trace[""], sphere_size, (1, 1, 0), 1, 1, 8, 300);
      }
      normal = trace["normal"];
      if(lengthsquared(normal) == 0) {
        normal = -1 * tracedir;
      }
      right = (normal[2] * -1, normal[1] * -1, normal[0]);
      if(lengthsquared(vectorcross(forward, normal)) == 0) {
        forward = vectorcross(right, forward);
      }
      self.heatwavefx[self.heatwavefx.size] = playfx(localclientnum, "player/fx_plyr_heat_wave_distortion_volume", trace["position"], normal, forward);
    } else {
      line(fx_position + vectorscale((0, 0, 1), 50), fx_position - vectorscale((0, 0, 1), 50), (1, 0, 0), 1, 0, 300);
      sphere(fx_position, sphere_size, (1, 0, 1), 1, 1, 8, 300);
      if(level.debug_heat_wave_traces) {}
      if((lengthsquared(vectorcross(forward, tracedir * -1))) == 0) {
        forward = vectorcross(right, forward);
      }
      self.heatwavefx[self.heatwavefx.size] = playfx(localclientnum, "player/fx_plyr_heat_wave_distortion_volume_air", fx_position, tracedir * -1, forward);
    }
    if(fxcount % 2) {
      wait(0.016);
    }
  }
}