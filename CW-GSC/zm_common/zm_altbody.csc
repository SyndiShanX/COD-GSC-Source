/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_altbody.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_utility;
#namespace zm_altbody;

function private autoexec __init__system__() {
  system::register(#"zm_altbody", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register_clientuimodel("player_lives", #"zm_hud", #"player_lives", 1, 2, "int", undefined, 0, 0);
  clientfield::register("toplayer", "player_mana", 1, 8, "float", &set_player_mana, 0, 1);
  clientfield::register("toplayer", "player_in_afterlife", 1, 1, "int", &toggle_player_altbody, 0, 1);
  clientfield::register("allplayers", "player_altbody", 1, 1, "int", &toggle_player_altbody_3p, 0, 1);
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

  level.altbody_name = visionset_name;

  if(isDefined(visionset_priority)) {
    level.altbody_visionsets[visionset_name] = visionset_priority;
    visionset_mgr::register_visionset_info(visionset_priority, 1, 1, visionset_priority, visionset_priority);
  }

  level.altbody_enter_callbacks[visionset_name] = enter_callback;
  level.altbody_exit_callbacks[visionset_name] = exit_callback;
  level.altbody_enter_3p_callbacks[visionset_name] = enter_3p_callback;
  level.altbody_exit_3p_callbacks[visionset_name] = exit_3p_callback;
}

function set_player_mana(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.mana = bwastimejump;
}

function toggle_player_altbody(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.altbody)) {
    self.altbody = 0;
  }

  self usealternatehud(fieldname);

  if(self.altbody !== fieldname) {
    self.altbody = fieldname;

    if(bwastimejump) {
      self thread clear_transition(binitialsnap, fieldname);
    } else {
      self thread cover_transition(binitialsnap, fieldname);
    }

    if(fieldname == 1) {
      callback = level.altbody_enter_callbacks[level.altbody_name];

      if(isDefined(callback)) {
        self[[callback]](binitialsnap);
      }

      return;
    }

    callback = level.altbody_exit_callbacks[level.altbody_name];

    if(isDefined(callback)) {
      self[[callback]](binitialsnap);
    }
  }
}

function toggle_player_altbody_3p(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self function_21c0fa55()) {
    return;
  }

  self.altbody_3p = bwastimejump;

  if(bwastimejump == 1) {
    callback = level.altbody_enter_3p_callbacks[level.altbody_name];

    if(isDefined(callback)) {
      self[[callback]](fieldname);
    }

    return;
  }

  callback = level.altbody_exit_3p_callbacks[level.altbody_name];

  if(isDefined(callback)) {
    self[[callback]](fieldname);
  }
}

function cover_transition(localclientnum, onoff) {
  if(!self util::function_50ed1561(onoff)) {
    return;
  }

  if(isdemoplaying() && demoisanyfreemovecamera()) {
    return;
  }

  level lui::screen_fade_out(onoff, 0.05);
  level waittilltimeout(0.15, #"demo_jump");
  level lui::screen_fade_in(onoff, 0.1);
}

function clear_transition(localclientnum, onoff) {
  level lui::screen_fade_in(onoff, 0);
}