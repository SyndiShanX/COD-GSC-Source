/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_util.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#namespace zm_castle_util;

function create_unitrigger(str_hint, n_radius = 64, func_prompt_and_visibility = & unitrigger_prompt_and_visibility, func_unitrigger_logic = & unitrigger_logic) {
  s_unitrigger = spawnstruct();
  s_unitrigger.origin = self.origin;
  s_unitrigger.angles = self.angles;
  s_unitrigger.script_unitrigger_type = "unitrigger_radius_use";
  s_unitrigger.cursor_hint = "HINT_NOICON";
  s_unitrigger.hint_string = str_hint;
  s_unitrigger.prompt_and_visibility_func = func_prompt_and_visibility;
  s_unitrigger.related_parent = self;
  s_unitrigger.radius = n_radius;
  self.s_unitrigger = s_unitrigger;
  zm_unitrigger::register_static_unitrigger(s_unitrigger, func_unitrigger_logic);
}

function unitrigger_prompt_and_visibility(player) {
  b_visible = 1;
  return b_visible;
}

function unitrigger_logic() {
  self endon("death");
  while (true) {
    self waittill("trigger", player);
    if(player zm_utility::in_revive_trigger()) {
      continue;
    }
    if(player.is_drinking > 0) {
      continue;
    }
    if(!zm_utility::is_player_valid(player)) {
      continue;
    }
    if(isdefined(self.stub.related_parent)) {
      self.stub.related_parent notify("trigger_activated", player);
    }
  }
}

function function_fa7da172() {
  self endon("death");
  var_82a4f07b = struct::get("keeper_end_loc");
  var_77b9bd02 = 0;
  while (isdefined(level.var_8ef26cd9) && level.var_8ef26cd9) {
    str_player_zone = self zm_zonemgr::get_player_zone();
    if(zm_utility::is_player_valid(self) && str_player_zone === "zone_undercroft") {
      if(!(isdefined(var_77b9bd02) && var_77b9bd02) && distance2dsquared(var_82a4f07b.origin, self.origin) <= 53361) {
        self clientfield::set_to_player("gravity_trap_rumble", 1);
        var_77b9bd02 = 1;
      } else if(isdefined(var_77b9bd02) && var_77b9bd02 && distance2dsquared(var_82a4f07b.origin, self.origin) > 53361) {
        self clientfield::set_to_player("gravity_trap_rumble", 0);
        var_77b9bd02 = 0;
      }
    } else if(isdefined(var_77b9bd02) && var_77b9bd02) {
      self clientfield::set_to_player("gravity_trap_rumble", 0);
      var_77b9bd02 = 0;
    }
    wait(0.15);
  }
  self clientfield::set_to_player("gravity_trap_rumble", 0);
}

function function_8faf1d24(v_color, var_8882142e, n_scale, str_endon) {
  if(!isdefined(v_color)) {
    v_color = vectorscale((0, 0, 1), 255);
  }
  if(!isdefined(var_8882142e)) {
    var_8882142e = "";
  }
  if(!isdefined(n_scale)) {
    n_scale = 0.25;
  }
  if(!isdefined(str_endon)) {
    str_endon = "";
  }
  if(getdvarint("") == 0) {
    return;
  }
  if(isdefined(str_endon)) {
    self endon(str_endon);
  }
  origin = self.origin;
  while (true) {
    print3d(origin, var_8882142e, v_color, n_scale);
    wait(0.1);
  }
}

function setup_devgui_func(str_devgui_path, str_dvar, n_value, func, n_base_value) {
  if(!isdefined(n_base_value)) {
    n_base_value = -1;
  }
  setdvar(str_dvar, n_base_value);
  adddebugcommand(((((("" + str_devgui_path) + "") + str_dvar) + "") + n_value) + "");
  while (true) {
    n_dvar = getdvarint(str_dvar);
    if(n_dvar > n_base_value) {
      [
        [func]
      ](n_dvar);
      setdvar(str_dvar, n_base_value);
    }
    util::wait_network_frame();
  }
}