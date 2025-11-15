/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_alchemical_antithesis.gsc
***********************************************************/

#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;

#namespace zm_bgb_alchemical_antithesis;

autoexec __init__system__() {
  system::register(#"zm_bgb_alchemical_antithesis", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_alchemical_antithesis", "activated", 1, undefined, undefined, &validation, &activation);
  bgb::function_57eb02e(#"zm_bgb_alchemical_antithesis");
  bgb::function_c2721e81(#"zm_bgb_alchemical_antithesis", &add_to_player_score_override, 0);
}

validation() {
  if(isDefined(level.var_375482b5) && level.var_375482b5) {
    return false;
  }

  return !(isDefined(self bgb::get_active()) && self bgb::get_active());
}

activation() {
  self.ready_for_score_events = 0;
  self bgb::run_timer(60);
  self.ready_for_score_events = 1;
}

add_to_player_score_override(points, str_awarded_by, zm_scr_spawner_location_distance) {
  if(!(isDefined(self.bgb_active) && self.bgb_active)) {
    return points;
  }

  var_f32fbbf5 = int(points / 7.5);
  w_current = self getcurrentweapon();

  if(zm_loadout::is_offhand_weapon(w_current)) {
    return points;
  }

  if(self zm_utility::is_drinking()) {
    return points;
  }

  if(w_current == level.weaponrevivetool) {
    return points;
  }

  if(w_current.iscliponly) {
    return points;
  }

  var_67a898af = self getweaponammostock(w_current);
  var_67a898af += var_f32fbbf5;

  if(self hasperk(#"specialty_extraammo")) {
    var_6ec34556 = w_current.maxammo;
  } else {
    var_6ec34556 = w_current.startammo;
  }

  if(w_current.isdualwield) {
    var_6ec34556 *= 2;
  }

  var_67a898af = math::clamp(var_67a898af, 0, var_6ec34556);
  self setweaponammostock(w_current, var_67a898af);
  self thread function_ec301a0d();
  return 0;
}

function_ec301a0d() {
  if(!isDefined(self.var_8f145772)) {
    self.var_8f145772 = 0;
  }

  if(!self.var_8f145772) {
    self.var_8f145772 = 1;
    self playsoundtoplayer(#"zmb_bgb_alchemical_ammoget", self);
    wait 0.5;

    if(isDefined(self)) {
      self.var_8f145772 = 0;
    }
  }
}