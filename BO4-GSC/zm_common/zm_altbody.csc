/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_altbody.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_utility;

#namespace zm_altbody;

autoexec __init__system__() {
  system::register(#"zm_altbody", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("clientuimodel", "player_lives", 1, 2, "int", undefined, 0, 0);
  clientfield::register("clientuimodel", "player_mana", 1, 8, "float", &set_player_mana, 0, 1);
  clientfield::register("toplayer", "player_in_afterlife", 1, 1, "int", &toggle_player_altbody, 0, 1);
  clientfield::register("allplayers", "player_altbody", 1, 1, "int", &toggle_player_altbody_3p, 0, 1);
  setupclientfieldcodecallbacks("toplayer", 1, "player_in_afterlife");
}

init(name, trigger_name, trigger_hint, visionset_name, visionset_priority, enter_callback, exit_callback, enter_3p_callback, exit_3p_callback) {
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

set_player_mana(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.mana = newval;
}

toggle_player_altbody(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.altbody)) {
    self.altbody = 0;
  }

  self usealternatehud(newval);

  if(self.altbody !== newval) {
    self.altbody = newval;

    if(bwastimejump) {
      self thread clear_transition(localclientnum, newval);
    } else {
      self thread cover_transition(localclientnum, newval);
    }

    if(newval == 1) {
      callback = level.altbody_enter_callbacks[level.altbody_name];

      if(isDefined(callback)) {
        self[[callback]](localclientnum);
      }

      return;
    }

    callback = level.altbody_exit_callbacks[level.altbody_name];

    if(isDefined(callback)) {
      self[[callback]](localclientnum);
    }
  }
}

toggle_player_altbody_3p(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self function_21c0fa55()) {
    return;
  }

  self.altbody_3p = newval;

  if(newval == 1) {
    callback = level.altbody_enter_3p_callbacks[level.altbody_name];

    if(isDefined(callback)) {
      self[[callback]](localclientnum);
    }

    return;
  }

  callback = level.altbody_exit_3p_callbacks[level.altbody_name];

  if(isDefined(callback)) {
    self[[callback]](localclientnum);
  }
}

cover_transition(localclientnum, onoff) {
  if(!self util::function_50ed1561(localclientnum)) {
    return;
  }

  if(isdemoplaying() && demoisanyfreemovecamera()) {
    return;
  }

  self lui::screen_fade_out(0.05);
  level waittilltimeout(0.15, #"demo_jump");

  if(isDefined(self)) {
    self lui::screen_fade_in(0.1);
  }
}

clear_transition(localclientnum, onoff) {
  self lui::screen_fade_in(0);
}