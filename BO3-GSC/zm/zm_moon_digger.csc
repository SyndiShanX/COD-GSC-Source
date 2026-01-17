/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_moon_digger.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#namespace zm_moon_digger;

function main() {
  level thread init_excavator_consoles();
}

function digger_moving_earthquake_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(localclientnum != 0) {
    return;
  }
  if(newval) {
    for(i = 0; i < level.localplayers.size; i++) {
      level thread do_digger_moving_earthquake_rumble(i, self);
    }
  } else {
    if(isDefined(self.headlight1)) {
      for(i = 0; i < level.localplayers.size; i++) {
        stopfx(i, self.headlight1);
        stopfx(i, self.headlight2);
        stopfx(i, self.blink1);
        stopfx(i, self.blink2);
        if(isDefined(self.tread_fx)) {
          stopfx(i, self.tread_fx);
        }
        if(isDefined(self.var_deef11e2)) {
          stopfx(i, self.var_deef11e2);
        }
      }
    }
    self notify("stop_moving_rumble");
  }
}

function function_a0cf54a0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    level thread function_1e254f15();
  }
}

function function_1e254f15() {
  for(i = 0; i < level.localplayers.size; i++) {
    player = getlocalplayers()[i];
    if(!isDefined(player)) {
      continue;
    }
    piece = struct::get("biodome_breached", "targetname");
    if(distancesquared(player.origin, piece.origin) < 6250000) {
      player earthquake(0.5, 3, player.origin, 1500);
      player thread bio_breach_rumble(i);
    }
    scene::play("p7_fxanim_zmhd_moon_biodome_glass_bundle");
    level notify("sl9");
    level notify("sl10");
  }
}

function bio_breach_rumble(localclientnum) {
  self endon("disconnect");
  for(i = 0; i < 10; i++) {
    self playrumbleonentity(localclientnum, "damage_heavy");
    wait(randomfloatrange(0.1, 0.2));
  }
}

function digger_digging_earthquake_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(localclientnum != 0) {
    return;
  }
  if(newval) {
    for(i = 0; i < level.localplayers.size; i++) {
      level thread do_digger_digging_earthquake_rumble(i, self);
    }
  } else {
    self notify("stop_digging_rumble");
  }
}

function do_digger_moving_earthquake_rumble(localclientnum, quake_ent) {
  quake_ent util::waittill_dobj(localclientnum);
  quake_ent endon("entityshutdown");
  quake_ent endon("stop_moving_rumble");
  dist_sqd = 6250000;
  quake_ent.tread_fx = playFXOnTag(localclientnum, level._effect["digger_treadfx_fwd"], quake_ent, "tag_origin");
  quake_ent.var_deef11e2 = playFXOnTag(localclientnum, level._effect["exca_body_all"], quake_ent, "tag_origin");
  player = getlocalplayers()[localclientnum];
  if(!isDefined(player)) {
    return;
  }
  while(true) {
    if(!isDefined(player)) {
      return;
    }
    player earthquake(randomfloatrange(0.15, 0.25), 3, quake_ent.origin, 2500);
    if(distancesquared(quake_ent.origin, player.origin) < dist_sqd) {
      player playrumbleonentity(localclientnum, "slide_rumble");
    }
    wait(randomfloatrange(0.05, 0.15));
  }
}

function do_digger_digging_earthquake_rumble(localclientnum, quake_ent) {
  quake_ent endon("entityshutdown");
  quake_ent endon("stop_digging_rumble");
  player = getlocalplayers()[localclientnum];
  if(!isDefined(player)) {
    return;
  }
  count = 0;
  dist = 2250000;
  while(true) {
    if(!isDefined(player)) {
      return;
    }
    player earthquake(randomfloatrange(0.12, 0.17), 3, quake_ent.origin, 1500);
    if(distancesquared(quake_ent.origin, player.origin) < dist && (abs(quake_ent.origin[2] - player.origin[2])) < 750) {
      player playrumbleonentity(localclientnum, "grenade_rumble");
    }
    wait(randomfloatrange(0.1, 0.25));
  }
}

function digger_arm_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(localclientnum != 0) {
    return;
  }
  if(newval) {
    for(i = 0; i < level.localplayers.size; i++) {
      level thread do_digger_arm_fx(i, self);
    }
  } else {
    if(isDefined(self.blink1)) {
      for(i = 0; i < level.localplayers.size; i++) {
        stopfx(i, self.blink1);
        stopfx(i, self.blink2);
      }
    }
    if(isDefined(self.var_5f9ccb3a)) {
      for(i = 0; i < level.localplayers.size; i++) {
        stopfx(i, self.var_5f9ccb3a);
      }
    }
  }
}

function do_digger_arm_fx(localclientnum, ent) {
  ent endon("entityshutdown");
  player = getlocalplayers()[localclientnum];
  if(!isDefined(player)) {
    return;
  }
  ent.var_5f9ccb3a = playFXOnTag(localclientnum, level._effect["exca_arm_all"], ent, "tag_origin");
}

function function_245b13ce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    level thread digger_visibility_toggle(localclientnum, "hide");
  } else {
    level thread digger_visibility_toggle(localclientnum, "show");
  }
}

function digger_visibility_toggle(localclient, visible) {
  diggers = getEntArray(localclient, "digger_body", "targetname");
  tracks = getEntArray(localclient, "tracks", "targetname");
  switch (visible) {
    case "hide": {
      for(i = 0; i < tracks.size; i++) {
        tracks[i] hide();
      }
      for(i = 0; i < diggers.size; i++) {
        arm = getent(localclient, diggers[i].target, "targetname");
        blade_center = getent(localclient, arm.target, "targetname");
        blade = getent(localclient, blade_center.target, "targetname");
        diggers[i] hide();
        arm hide();
        blade hide();
      }
      break;
    }
    case "show": {
      for(i = 0; i < tracks.size; i++) {
        tracks[i] show();
      }
      for(i = 0; i < diggers.size; i++) {
        arm = getent(localclient, diggers[i].target, "targetname");
        blade_center = getent(localclient, arm.target, "targetname");
        blade = getent(localclient, blade_center.target, "targetname");
        diggers[i] show();
        arm show();
        blade show();
      }
      break;
    }
  }
}

function init_excavator_consoles() {
  wait(15);
  for(index = 0; index < level.localplayers.size; index++) {
    if(!level clientfield::get("TCA")) {
      var_cc373138 = getent(index, "tunnel_console", "targetname");
      function_9b3daafa(index, var_cc373138, 0);
    }
    if(!level clientfield::get("HCA")) {
      var_cc373138 = getent(index, "hangar_console", "targetname");
      function_9b3daafa(index, var_cc373138, 0);
    }
    if(!level clientfield::get("BCA")) {
      var_cc373138 = getent(index, "biodome_console", "targetname");
      function_9b3daafa(index, var_cc373138, 0);
    }
  }
}

function function_774edb15(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (fieldname) {
    case "TCA": {
      var_ffc320da = "tunnel_console";
      break;
    }
    case "HCA": {
      var_ffc320da = "hangar_console";
      break;
    }
    case "BCA": {
      var_ffc320da = "biodome_console";
      break;
    }
  }
  var_cc373138 = getent(localclientnum, var_ffc320da, "targetname");
  if(newval) {
    function_9b3daafa(localclientnum, var_cc373138, 1);
  } else {
    function_9b3daafa(localclientnum, var_cc373138, 0);
  }
}

function function_9b3daafa(localclientnum, var_cc373138, var_a61a4e58) {
  if(isDefined(var_cc373138.n_fx_id)) {
    stopfx(localclientnum, var_cc373138.n_fx_id);
  }
  if(var_a61a4e58) {
    var_cc373138.n_fx_id = playFXOnTag(localclientnum, level._effect["panel_on"], var_cc373138, "tag_origin");
  } else {
    var_cc373138.n_fx_id = playFXOnTag(localclientnum, level._effect["panel_off"], var_cc373138, "tag_origin");
  }
}