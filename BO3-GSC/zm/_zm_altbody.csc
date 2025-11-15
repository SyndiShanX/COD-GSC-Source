/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_altbody.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_utility;
#namespace zm_altbody;

function autoexec __init__sytem__() {
  system::register("zm_altbody", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("clientuimodel", "player_mana", 1, 8, "float", & set_player_mana, 0, 1);
  clientfield::register("toplayer", "player_in_afterlife", 1, 1, "int", & toggle_player_altbody, 0, 1);
  clientfield::register("allplayers", "player_altbody", 1, 1, "int", & toggle_player_altbody_3p, 0, 1);
  setupclientfieldcodecallbacks("toplayer", 1, "player_in_afterlife");
}

function init(name, trigger_name, trigger_hint, visionset_name, visionset_priority, enter_callback, exit_callback, enter_3p_callback, exit_3p_callback) {
  if(!isDefined(level.altbody_enter_callbacks)) {
    level.altbody_enter_callbacks = [];
  }
  if(!isDefined(level.altbody_exit_callbacks)) {
    level.altbody_exit_callbacks = [];
  }
  if(!isDefined(level.altbody_enter_3p_callbacks)) {
    level.altbody_enter_3p_callbacks = [];
  }
  if(!isDefined(level.altbody_exit_3p_callbacks)) {
    level.altbody_exit_3p_callbacks = [];
  }
  if(!isDefined(level.altbody_visionsets)) {
    level.altbody_visionsets = [];
  }
  level.altbody_name = name;
  if(isDefined(visionset_name)) {
    level.altbody_visionsets[name] = visionset_name;
    visionset_mgr::register_visionset_info(visionset_name, 1, 1, visionset_name, visionset_name);
  }
  level.altbody_enter_callbacks[name] = enter_callback;
  level.altbody_exit_callbacks[name] = exit_callback;
  level.altbody_enter_3p_callbacks[name] = enter_3p_callback;
  level.altbody_exit_3p_callbacks[name] = exit_3p_callback;
}

function set_player_mana(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.mana = newval;
}

function toggle_player_altbody(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.altbody)) {
    self.altbody = 0;
  }
  self usealternatehud(newval);
  if(self.altbody !== newval) {
    self.altbody = newval;
    if(bwastimejump) {
      self thread function_9927f5ae(localclientnum, newval);
    } else {
      self thread cover_transition(localclientnum, newval);
    }
    if(newval == 1) {
      callback = level.altbody_enter_callbacks[level.altbody_name];
      if(isDefined(callback)) {
        self[[callback]](localclientnum);
      }
    } else {
      callback = level.altbody_exit_callbacks[level.altbody_name];
      if(isDefined(callback)) {
        self[[callback]](localclientnum);
      }
    }
  }
}

function toggle_player_altbody_3p(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self islocalplayer()) {
    return;
  }
  self.altbody_3p = newval;
  if(newval == 1) {
    callback = level.altbody_enter_3p_callbacks[level.altbody_name];
    if(isDefined(callback)) {
      self[[callback]](localclientnum);
    }
  } else {
    callback = level.altbody_exit_3p_callbacks[level.altbody_name];
    if(isDefined(callback)) {
      self[[callback]](localclientnum);
    }
  }
}

function cover_transition(localclientnum, onoff) {
  if(!self islocalplayer() || isspectating(localclientnum, 0) || localclientnum !== self getlocalclientnumber()) {
    return;
  }
  if(isdemoplaying() && demoisanyfreemovecamera()) {
    return;
  }
  lui::screen_fade_out(0.05);
  level util::waittill_any_timeout(0.15, "demo_jump");
  if(isDefined(self)) {
    lui::screen_fade_in(0.1);
  }
}

function function_9927f5ae(localclientnum, onoff) {
  lui::screen_fade_in(0);
}