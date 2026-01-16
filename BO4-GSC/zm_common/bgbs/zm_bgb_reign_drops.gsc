/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_reign_drops.gsc
*************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\bgbs\zm_bgb_extra_credit;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_customgame;

#namespace zm_bgb_reign_drops;

autoexec __init__system__() {
  system::register(#"zm_bgb_reign_drops", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_reign_drops", "activated", 1, undefined, undefined, &validation, &activation);
}

validation() {
  if(level.active_powerups.size >= 9 || !self bgb::function_9d8118f5()) {
    return false;
  }

  return true;
}

activation() {
  self endon(#"disconnect", #"bled_out");

  if(zm_custom::function_3ac936c6("zm_bgb_power_keg")) {
    level thread bgb::function_c6cd71d5("hero_weapon_power", self function_dfc73f65(1), 96);
  }

  if(zm_custom::function_3ac936c6("zm_bgb_extra_credit")) {
    self thread zm_bgb_extra_credit::function_22f934e6(self function_dfc73f65(2), 96);
  }

  if(zm_custom::function_3ac936c6("zm_bgb_dead_of_nuclear_winter")) {
    level thread bgb::function_c6cd71d5("nuke", self function_dfc73f65(3), 96);
  }

  if(zm_custom::function_3ac936c6("zm_bgb_licensed_contractor")) {
    level thread bgb::function_c6cd71d5("carpenter", self function_dfc73f65(4), 96);
  }

  if(zm_custom::function_3ac936c6("zm_bgb_on_the_house") && zm_custom::function_901b751c(#"zmperksactive")) {
    level thread bgb::function_c6cd71d5("free_perk", self function_dfc73f65(5), 96);
  }

  if(zm_custom::function_3ac936c6("zm_bgb_immolation_liquidation")) {
    level thread bgb::function_c6cd71d5("fire_sale", self function_dfc73f65(6), 96);
  }

  if(zm_custom::function_3ac936c6("zm_bgb_kill_joy")) {
    level thread bgb::function_c6cd71d5("insta_kill", self function_dfc73f65(7), 96);
  }

  if(zm_custom::function_3ac936c6("zm_bgb_cache_back")) {
    level thread bgb::function_c6cd71d5("full_ammo", self function_dfc73f65(8), 96);
  }

  if(zm_custom::function_3ac936c6("zm_bgb_whos_keeping_score")) {
    level thread bgb::function_c6cd71d5("double_points", self function_dfc73f65(9), 96);
  }

  self.var_a825ccbb = 1;
  self thread function_7f3b4877();
}

function_7f3b4877() {
  self endon(#"disconnect");
  waitframe(1);
  n_start_time = gettime();
  n_total_time = 0;

  while(isDefined(level.active_powerups) && level.active_powerups.size) {
    wait 0.5;
    n_current_time = gettime();
    n_total_time = (n_current_time - n_start_time) / 1000;

    if(n_total_time >= 28) {
      break;
    }
  }

  self.var_a825ccbb = undefined;
}

function_dfc73f65(n_position) {
  v_powerup = self bgb::get_player_dropped_powerup_origin();
  v_up = (0, 0, 5);
  var_85660237 = v_powerup + anglesToForward(self.angles) * 60 + v_up;
  var_97efa74a = var_85660237 + anglesToForward(self.angles) * 60 + v_up;

  switch (n_position) {
    case 1:
      v_origin = v_powerup + anglestoright(self.angles) * -60 + v_up;
      break;
    case 2:
      v_origin = v_powerup;
      break;
    case 3:
      v_origin = v_powerup + anglestoright(self.angles) * 60 + v_up;
      break;
    case 4:
      v_origin = var_85660237 + anglestoright(self.angles) * -60 + v_up;
      break;
    case 5:
      v_origin = var_85660237;
      break;
    case 6:
      v_origin = var_85660237 + anglestoright(self.angles) * 60 + v_up;
      break;
    case 7:
      v_origin = var_97efa74a + anglestoright(self.angles) * -60 + v_up;
      break;
    case 8:
      v_origin = var_97efa74a;
      break;
    case 9:
      v_origin = var_97efa74a + anglestoright(self.angles) * 60 + v_up;
      break;
    default:
      v_origin = v_powerup;
      break;
  }

  return v_origin;
}