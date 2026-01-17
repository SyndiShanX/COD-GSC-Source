/************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_security_breach.csc
************************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_oed;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\math_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace cybercom_security_breach;

function init() {
  init_clientfields();
  callback::on_spawned(&on_player_spawned);
  level.vehicle_transition_on = [];
}

function init_clientfields() {
  clientfield::register("toplayer", "hijack_vehicle_transition", 1, 2, "int", &player_vehicletransition, 0, 0);
  clientfield::register("toplayer", "hijack_static_effect", 1, 7, "float", &player_static_cb, 0, 0);
  clientfield::register("toplayer", "sndInDrivableVehicle", 1, 1, "int", &sndindrivablevehicle, 0, 0);
  clientfield::register("vehicle", "vehicle_hijacked", 1, 1, "int", &player_hijacked_this_vehicle, 0, 0);
  clientfield::register("toplayer", "vehicle_hijacked", 1, 1, "int", &player_hijacked_vehicle, 0, 0);
  clientfield::register("toplayer", "hijack_spectate", 1, 1, "int", &player_spectate_cb, 0, 0);
  clientfield::register("toplayer", "hijack_static_ramp_up", 1, 1, "int", &player_static_rampup_cb, 0, 0);
  visionset_mgr::register_visionset_info("hijack_vehicle", 1, 7, undefined, "vehicle_transition");
  visionset_mgr::register_visionset_info("hijack_vehicle_blur", 1, 7, undefined, "vehicle_hijack_blur");
}

function on_player_spawned(localclientnum) {
  player = getlocalplayer(localclientnum);
  if(player getentitynumber() == self getentitynumber()) {
    filter::init_filter_vehicle_hijack_oor(self);
  }
}

function spectate(localclientnum, delta_time) {
  player = getlocalplayer(localclientnum);
  if(!isDefined(player)) {
    return;
  }
  if(!player isplayer()) {
    return;
  }
  if(!isalive(player)) {
    return;
  }
  if(isDefined(player.sessionstate)) {
    if(player.sessionstate == "spectator") {
      return;
    }
    if(player.sessionstate == "intermission") {
      return;
    }
  }
  if(isDefined(player.vehicle_camera_pos)) {
    player camerasetposition(player.vehicle_camera_pos);
  }
  ang = player getcamangles();
  if(isDefined(player.vehicle_camera_ang)) {
    ang = player.vehicle_camera_ang;
  }
  if(isDefined(ang)) {
    ang = (ang[0], ang[1], 0);
    player camerasetlookat(ang);
  }
}

function player_static_rampup_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    startstatic = (isDefined(self.last_hijack_oor_value) ? self.last_hijack_oor_value : 0);
    if(!(isDefined(self.vehicle_hijack_filter_on) && self.vehicle_hijack_filter_on)) {
      filter::enable_filter_vehicle_hijack_oor(self, 0);
      self.vehicle_hijack_filter_on = 1;
    }
    timestart = gettime();
    timeend = timestart + 3000;
    timecur = timestart;
    playSound(localclientnum, "gdt_securitybreach_static_oneshot", (0, 0, 0));
    while(timecur < timeend) {
      timecur = gettime();
      curstatic = math::linear_map(timecur, timestart, timeend, startstatic, 1);
      filter::set_filter_vehicle_hijack_oor_amount(self, 0, curstatic);
      wait(0.01);
    }
  } else {
    filter::disable_filter_vehicle_hijack_oor(self, 0);
    self.vehicle_hijack_filter_on = undefined;
  }
}

function player_spectate_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("player_spectate");
  if(newval) {
    self camerasetupdatecallback(&spectate);
  } else {
    self camerasetupdatecallback();
    self.vehicle_camera_pos = undefined;
    self.vehicle_camera_ang = undefined;
  }
}

function player_update_angles(vehicle) {
  self endon("player_spectate");
  self endon("disconnect");
  self endon("spawn");
  self endon("entityshutdown");
  vehicle endon("entityshutdown");
  while(isalive(vehicle)) {
    self.vehicle_camera_pos = self getcampos();
    self.vehicle_camera_ang = self getcamangles();
    wait(0.01);
  }
}

function player_hijacked_vehicle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self tmodeenable(0);
    self oed::function_3b4d6db0(localclientnum);
  } else if(isDefined(self.var_8b70667f) && self.var_8b70667f) {
    self tmodeenable(1);
    self oed::function_165838aa(localclientnum);
  }
}

function player_hijacked_this_vehicle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self islocalclientdriver(localclientnum)) {
    player = getlocalplayer(localclientnum);
    player thread player_update_angles(self);
  }
}

function player_static_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval != 0) {
    self.last_hijack_oor_value = newval;
    if(!(isDefined(self.vehicle_hijack_filter_on) && self.vehicle_hijack_filter_on)) {
      filter::enable_filter_vehicle_hijack_oor(self, 0);
      self.vehicle_hijack_filter_on = 1;
    }
    filter::set_filter_vehicle_hijack_oor_amount(self, 0, newval);
  }
  if(isDefined(self.vehicle_hijack_filter_on) && self.vehicle_hijack_filter_on && newval == 0) {
    filter::disable_filter_vehicle_hijack_oor(self, 0);
    self.vehicle_hijack_filter_on = undefined;
  }
  self thread static_sound(newval);
}

function static_sound(val) {
  if(!isDefined(level.static_soundent)) {
    level.static_soundent = spawn(0, self.origin, "script_origin");
    level.static_soundent linkto(self);
  }
  if(val == 0) {
    level.static_soundent delete();
    level.static_soundent = undefined;
  } else {
    sid = level.static_soundent playLoopSound("gdt_securitybreach_static_interference", 1);
    if(isDefined(sid)) {
      setsoundvolume(sid, val);
      setsoundvolumerate(sid, 1);
    }
  }
}

function sndindrivablevehicle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(!isDefined(level.plr_dist_soundent)) {
      level.plr_dist_soundent = spawn(0, self.origin, "script_origin");
      level.plr_dist_soundent linkto(self);
      level.plr_dist_soundent playLoopSound("gdt_securitybreach_silence");
    }
  } else {
    level.plr_dist_soundent delete();
    level.plr_dist_soundent = undefined;
  }
}

function player_vehicletransition(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 2: {
      self thread postfx::playpostfxbundle("pstfx_vehicle_takeover_fade_in");
      playSound(0, "gdt_securitybreach_transition_in", (0, 0, 0));
      break;
    }
    case 3: {
      self thread postfx::playpostfxbundle("pstfx_vehicle_takeover_fade_out");
      playSound(0, "gdt_securitybreach_transition_out", (0, 0, 0));
      break;
    }
    case 1: {
      self thread postfx::stoppostfxbundle();
      break;
    }
    case 4: {
      self thread postfx::playpostfxbundle("pstfx_vehicle_takeover_white");
      break;
    }
  }
}