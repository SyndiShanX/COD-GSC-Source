/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_dividend_yield.gsc
****************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_score;

#namespace zm_bgb_dividend_yield;

autoexec __init__system__() {
  system::register(#"zm_bgb_dividend_yield", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  clientfield::register("allplayers", "" + #"hash_11a25fb3db96fc2d", 1, 1, "int");
  clientfield::register("toplayer", "" + #"hash_31b61c511ced94d7", 1, 1, "int");
  bgb::register(#"zm_bgb_dividend_yield", "time", 300, &enable, &disable, undefined, undefined);
  bgb::function_c2721e81(#"zm_bgb_dividend_yield", &add_to_player_score_override, 1);
}

enable() {
  self endon(#"disconnect", #"bled_out", #"bgb_update");
  self thread bgb::function_f51e3503(720, &function_db295169, &function_cbaf1f69);
  self thread function_5cf91552();
}

disable() {}

function_5cf91552() {
  self endon(#"disconnect");
  self clientfield::set("" + #"hash_11a25fb3db96fc2d", 1);
  self util::waittill_either("bled_out", "bgb_update");
  self clientfield::set("" + #"hash_11a25fb3db96fc2d", 0);
  self notify(#"dividend_yield_complete");
}

add_to_player_score_override(n_points, str_awarded_by, zm_scr_spawner_location_distance) {
  if(str_awarded_by == #"zm_bgb_dividend_yield" || n_points == 0) {
    return n_points;
  }

  switch (str_awarded_by) {
    case #"reviver":
    case #"bonus_points_powerup_shared":
    case #"magicbox_bear":
      return n_points;
    default:
      break;
  }

  if(zm_scr_spawner_location_distance) {
    var_bed6c5f = int(n_points / 20);
    var_15fc340f = var_bed6c5f * 10;

    if(var_15fc340f == 0) {
      return n_points;
    }

    if(!isDefined(self.var_9c42f3fe)) {
      self.var_9c42f3fe = [];
    } else if(!isarray(self.var_9c42f3fe)) {
      self.var_9c42f3fe = array(self.var_9c42f3fe);
    }

    foreach(e_player in self.var_9c42f3fe) {
      if(isDefined(e_player)) {
        e_player thread zm_score::add_to_player_score(var_15fc340f, 1, #"zm_bgb_dividend_yield");
      }
    }

    self thread zm_score::add_to_player_score(var_15fc340f, 1, #"zm_bgb_dividend_yield");
  }

  return n_points;
}

function_db295169(e_player) {
  self function_51e0947e();
  e_player function_51e0947e();
  str_notify = "dividend_yield_fx_stop_" + self getentitynumber();
  level util::waittill_any_ents(e_player, "disconnect", e_player, str_notify, self, "disconnect", self, "dividend_yield_complete");

  if(isDefined(self)) {
    self function_68790c5a();
  }

  if(isDefined(e_player)) {
    e_player function_68790c5a();
  }
}

function_cbaf1f69(e_player) {
  str_notify = "dividend_yield_fx_stop_" + self getentitynumber();
  e_player notify(str_notify);
}

function_51e0947e() {
  if(!isDefined(self.var_836ebde0) || self.var_836ebde0 == 0) {
    self.var_836ebde0 = 1;
    self clientfield::set_to_player("" + #"hash_31b61c511ced94d7", 1);
    return;
  }

  self.var_836ebde0++;
}

function_68790c5a() {
  self.var_836ebde0--;

  if(self.var_836ebde0 == 0) {
    self clientfield::set_to_player("" + #"hash_31b61c511ced94d7", 0);
  }
}