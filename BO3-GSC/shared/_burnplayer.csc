/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\_burnplayer.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace burnplayer;

function autoexec __init__sytem__() {
  system::register("burnplayer", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "burn", 1, 1, "int", & burning_callback, 0, 0);
  clientfield::register("playercorpse", "burned_effect", 1, 1, "int", & burning_corpse_callback, 0, 1);
  loadeffects();
  callback::on_localplayer_spawned( & on_localplayer_spawned);
  callback::on_localclient_connect( & on_local_client_connect);
}

function loadeffects() {
  level._effect["burn_j_elbow_le_loop"] = "fire/fx_fire_ai_human_arm_left_loop";
  level._effect["burn_j_elbow_ri_loop"] = "fire/fx_fire_ai_human_arm_right_loop";
  level._effect["burn_j_shoulder_le_loop"] = "fire/fx_fire_ai_human_arm_left_loop";
  level._effect["burn_j_shoulder_ri_loop"] = "fire/fx_fire_ai_human_arm_right_loop";
  level._effect["burn_j_spine4_loop"] = "fire/fx_fire_ai_human_torso_loop";
  level._effect["burn_j_hip_le_loop"] = "fire/fx_fire_ai_human_hip_left_loop";
  level._effect["burn_j_hip_ri_loop"] = "fire/fx_fire_ai_human_hip_right_loop";
  level._effect["burn_j_knee_le_loop"] = "fire/fx_fire_ai_human_leg_left_loop";
  level._effect["burn_j_knee_ri_loop"] = "fire/fx_fire_ai_human_leg_right_loop";
  level._effect["burn_j_head_loop"] = "fire/fx_fire_ai_human_head_loop";
  level._effect["burn_j_elbow_le_os"] = "fire/fx_fire_ai_human_arm_left_os";
  level._effect["burn_j_elbow_ri_os"] = "fire/fx_fire_ai_human_arm_right_os";
  level._effect["burn_j_shoulder_le_os"] = "fire/fx_fire_ai_human_arm_left_os";
  level._effect["burn_j_shoulder_ri_os"] = "fire/fx_fire_ai_human_arm_right_os";
  level._effect["burn_j_spine4_os"] = "fire/fx_fire_ai_human_torso_os";
  level._effect["burn_j_hip_le_os"] = "fire/fx_fire_ai_human_hip_left_os";
  level._effect["burn_j_hip_ri_os"] = "fire/fx_fire_ai_human_hip_right_os";
  level._effect["burn_j_knee_le_os"] = "fire/fx_fire_ai_human_leg_left_os";
  level._effect["burn_j_knee_ri_os"] = "fire/fx_fire_ai_human_leg_right_os";
  level._effect["burn_j_head_os"] = "fire/fx_fire_ai_human_head_os";
  level.burntags = array("j_elbow_le", "j_elbow_ri", "j_shoulder_le", "j_shoulder_ri", "j_spine4", "j_spinelower", "j_hip_le", "j_hip_ri", "j_head", "j_knee_le", "j_knee_ri");
}

function on_local_client_connect(localclientnum) {
  registerrewindfx(localclientnum, level._effect["burn_j_elbow_le_loop"]);
  registerrewindfx(localclientnum, level._effect["burn_j_elbow_ri_loop"]);
  registerrewindfx(localclientnum, level._effect["burn_j_shoulder_le_loop"]);
  registerrewindfx(localclientnum, level._effect["burn_j_shoulder_ri_loop"]);
  registerrewindfx(localclientnum, level._effect["burn_j_spine4_loop"]);
  registerrewindfx(localclientnum, level._effect["burn_j_hip_le_loop"]);
  registerrewindfx(localclientnum, level._effect["burn_j_hip_ri_loop"]);
  registerrewindfx(localclientnum, level._effect["burn_j_knee_le_loop"]);
  registerrewindfx(localclientnum, level._effect["burn_j_knee_ri_loop"]);
  registerrewindfx(localclientnum, level._effect["burn_j_head_loop"]);
}

function on_localplayer_spawned(localclientnum) {}

function burning_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self burn_on(localclientnum);
  } else {
    self burn_off(localclientnum);
  }
}

function burning_corpse_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self set_corpse_burning(localclientnum);
  } else {
    self burn_off(localclientnum);
  }
}

function set_corpse_burning(localclientnum) {
  self thread _burnbody(localclientnum);
}

function burn_off(localclientnum) {
  self notify("burn_off");
  if(getlocalplayer(localclientnum) == self) {
    self postfx::exitpostfxbundle();
  }
}

function burn_on(localclientnum) {
  if(getlocalplayer(localclientnum) != self || isthirdperson(localclientnum)) {
    self thread _burnbody(localclientnum);
  }
  if(getlocalplayer(localclientnum) == self && !isthirdperson(localclientnum)) {
    self thread burn_on_postfx();
  }
}

function burn_on_postfx() {
  self endon("entityshutdown");
  self endon("burn_off");
  self endon("death");
  self notify("burn_on_postfx");
  self endon("burn_on_postfx");
  self thread postfx::playpostfxbundle("pstfx_burn_loop");
}

function private _burntag(localclientnum, tag, postfix) {
  if(isDefined(self) && self hasdobj(localclientnum)) {
    fxname = ("burn_" + tag) + postfix;
    if(isDefined(level._effect[fxname])) {
      return playFXOnTag(localclientnum, level._effect[fxname], self, tag);
    }
  }
}

function private _burntagson(localclientnum, tags) {
  if(!isDefined(self)) {
    return;
  }
  self endon("entityshutdown");
  self endon("burn_off");
  self notify("burn_tags_on");
  self endon("burn_tags_on");
  activefx = [];
  for(i = 0; i < tags.size; i++) {
    activefx[activefx.size] = self _burntag(localclientnum, tags[i], "_loop");
  }
  burnsound = self playLoopSound("chr_burn_loop_overlay", 0.5);
  self thread _burntagswatchend(localclientnum, activefx, burnsound);
  self thread _burntagswatchclear(localclientnum, activefx, burnsound);
}

function private _burnbody(localclientnum) {
  self endon("entityshutdown");
  self thread _burntagson(localclientnum, level.burntags);
}

function private _burntagswatchend(localclientnum, fxarray, burnsound) {
  self endon("entityshutdown");
  self waittill("burn_off");
  if(isDefined(burnsound)) {
    self stoploopsound(burnsound, 1);
  }
  if(isDefined(fxarray)) {
    foreach(fx in fxarray) {
      stopfx(localclientnum, fx);
    }
  }
}

function private _burntagswatchclear(localclientnum, fxarray, burnsound) {
  self endon("burn_off");
  self waittill("entityshutdown");
  if(isDefined(burnsound)) {
    stopsound(burnsound);
  }
  if(isDefined(fxarray)) {
    foreach(fx in fxarray) {
      stopfx(localclientnum, fx);
    }
  }
}