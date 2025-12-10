/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_theater_teleporter.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace zm_theater_teleporter;

function autoexec __init__sytem__() {
  system::register("zm_theater_teleporter", &__init__, undefined, undefined);
}

function __init__() {
  visionset_mgr::register_overlay_info_style_postfx_bundle("zm_theater_teleport", 21000, 1, "pstfx_zm_kino_teleport");
  clientfield::register("scriptmover", "extra_screen", 21000, 1, "int", &function_667aa0b4, 0, 0);
  clientfield::register("scriptmover", "teleporter_fx", 21000, 1, "counter", &function_a8255fab, 0, 0);
  clientfield::register("allplayers", "player_teleport_fx", 21000, 1, "counter", &function_2b23adc9, 0, 0);
  clientfield::register("scriptmover", "play_fly_me_to_the_moon_fx", 21000, 1, "int", &play_fly_me_to_the_moon_fx, 0, 0);
  clientfield::register("world", "teleporter_initiate_fx", 21000, 1, "counter", &function_6776dea9, 0, 0);
  clientfield::register("scriptmover", "teleporter_link_cable_mtl", 21000, 1, "int", &teleporter_link_cable_mtl, 0, 0);
}

function main() {
  level thread setup_teleporter_screen();
  level thread pack_clock_init();
}

function setup_teleporter_screen() {
  level waittill("power_on");
  for(i = 0; i < level.localplayers.size; i++) {
    level.extracamactive[i] = 0;
  }
}

function pack_clock_init() {
  level waittill("pack_clock_start", clientnum);
  curr_time = getsystemtime();
  hours = curr_time[0];
  if(hours > 12) {
    hours = hours - 12;
  }
  if(hours == 0) {
    hours = 12;
  }
  minutes = curr_time[1];
  seconds = curr_time[2];
  hour_hand = getent(clientnum, "zom_clock_hour_hand", "targetname");
  hour_values = [];
  hour_values["hand_time"] = hours;
  hour_values["rotate"] = 30;
  hour_values["rotate_bit"] = 0.008333334;
  hour_values["first_rotate"] = ((minutes * 60) + seconds) * hour_values["rotate_bit"];
  minute_hand = getent(clientnum, "zom_clock_minute_hand", "targetname");
  minute_values = [];
  minute_values["hand_time"] = minutes;
  minute_values["rotate"] = 6;
  minute_values["rotate_bit"] = 0.1;
  minute_values["first_rotate"] = seconds * minute_values["rotate_bit"];
  if(isDefined(hour_hand)) {
    hour_hand thread pack_clock_run(hour_values);
  }
  if(isDefined(minute_hand)) {
    minute_hand thread pack_clock_run(minute_values);
  }
}

function pack_clock_run(time_values) {
  self endon("entityshutdown");
  self rotatepitch((time_values["hand_time"] * time_values["rotate"]) * -1, 0.05);
  self waittill("rotatedone");
  if(isDefined(time_values["first_rotate"])) {
    self rotatepitch(time_values["first_rotate"] * -1, 0.05);
    self waittill("rotatedone");
  }
  prev_time = getsystemtime();
  while(true) {
    curr_time = getsystemtime();
    if(prev_time != curr_time) {
      self rotatepitch(time_values["rotate_bit"] * -1, 0.05);
      prev_time = curr_time;
    }
    wait(1);
  }
}

function function_667aa0b4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level.cameraent = getent(localclientnum, "theater_extracam_eye", "targetname");
    level.cam_corona = util::spawn_model(localclientnum, "tag_origin", level.cameraent.origin, level.cameraent.angles);
    level.cam_corona.var_e39fd443 = playFXOnTag(localclientnum, level._effect["fx_mp_light_lamp"], level.cam_corona, "tag_origin");
    if(level.extracamactive[localclientnum] == 0 && level.localplayers.size < 3) {
      if(isDefined(level.var_3cb13a71[localclientnum])) {
        killfx(localclientnum, level.var_3cb13a71[localclientnum]);
      }
      level.extracamactive[localclientnum] = 1;
      level.cameraent setextracam(0, 320, 240);
    }
  } else {
    if(isDefined(level.cam_corona)) {
      stopfx(localclientnum, level.cam_corona.var_e39fd443);
      level.cam_corona delete();
    }
    if(level.extracamactive[localclientnum] == 1 && isDefined(level.cameraent)) {
      level.extracamactive[localclientnum] = 0;
      level.cameraent clearextracam();
      var_78113405 = struct::get("struct_theater_projector_beam", "targetname");
      if(isDefined(level.var_3cb13a71[localclientnum]) && isDefined(var_78113405.vid[localclientnum])) {
        level.var_3cb13a71[localclientnum] = playFXOnTag(localclientnum, level._effect[level.var_bcdc3660[localclientnum]], var_78113405.vid[localclientnum], "tag_origin");
      }
    }
  }
}

function function_a8255fab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon("entityshutdown");
  if(newval) {
    n_fx_id = playFXOnTag(localclientnum, level._effect["teleport_player_kino"], self, "tag_fx_wormhole");
    setfxignorepause(localclientnum, n_fx_id, 1);
    var_3d144b40 = playFXOnTag(localclientnum, level._effect["teleport_player_kino_cover"], self, "tag_fx_wormhole");
    setfxignorepause(localclientnum, var_3d144b40, 1);
  }
}

function function_2b23adc9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_e_players = getlocalplayers();
  foreach(e_player in a_e_players) {
    e_player.var_5c4ad807 = playFXOnTag(e_player.localclientnum, level._effect["teleport_player_flash"], self, "j_spinelower");
    setfxignorepause(e_player.localclientnum, e_player.var_5c4ad807, 1);
  }
}

function function_6776dea9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_33e4acb6 = (-306.684, 1116.25, 117.056);
  var_a1844610 = (0, 0, 0);
  v_origin = (-306.75, 1116.25, 0.0660095);
  v_angles = vectorscale((1, 0, 0), 270);
  a_e_players = getlocalplayers();
  foreach(e_player in a_e_players) {
    e_player.var_a0a2d27 = playFX(e_player.localclientnum, level._effect["teleport_initiate"], v_origin, anglesToForward(v_angles), anglestoup(v_angles));
    setfxignorepause(e_player.localclientnum, e_player.var_a0a2d27, 1);
    e_player.var_d4770e93 = playFX(e_player.localclientnum, level._effect["teleport_initiate_top"], var_33e4acb6, anglesToForward(var_a1844610), anglestoup(var_a1844610));
    setfxignorepause(e_player.localclientnum, e_player.var_d4770e93, 1);
  }
}

function play_fly_me_to_the_moon_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.fx_spot = util::spawn_model(localclientnum, "tag_origin", self.origin + (vectorscale((0, 0, -1), 19)), vectorscale((1, 0, 0), 90));
    self.fx_spot linkto(self);
    n_fx_id = playFXOnTag(localclientnum, level._effect["fx_mp_pipe_steam"], self.fx_spot, "tag_origin");
    setfxignorepause(localclientnum, n_fx_id, 1);
  } else if(isDefined(self) && isDefined(self.fx_spot)) {
    deletefx(localclientnum, level._effect["fx_mp_pipe_steam"]);
    self.fx_spot unlink();
    self.fx_spot delete();
  }
}

function teleporter_link_cable_mtl(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0, 0);
  } else {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
  }
}