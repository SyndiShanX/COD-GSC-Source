/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_blood_debt.gsc
************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_utility;

#namespace zm_bgb_blood_debt;

autoexec __init__system__() {
  system::register(#"zm_bgb_blood_debt", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_blood_debt", "time", 60, &enable, &disable, undefined, undefined);
  zm_player::register_player_damage_callback(&function_4b163259);
}

enable() {
  self endon(#"disconnect", #"bled_out", #"bgb_update");

  if(zm_utility::is_standard()) {
    self.var_d3df5e76 = array(2000);
  } else {
    self.var_d3df5e76 = array(50, 100, 250, 500);
  }

  self.var_7ad1482b = 1;
}

disable() {
  self.var_d3df5e76 = undefined;
  self.var_7ad1482b = undefined;
}

function_4b163259(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(bgb::is_enabled(#"zm_bgb_blood_debt") && !(isDefined(self.var_dad8bef6) && self.var_dad8bef6)) {
    if(idamage > 0) {
      if(self.var_d3df5e76.size > 1) {
        n_cost = self.var_d3df5e76[0];
      } else {
        n_cost = self.var_d3df5e76[0] * self.var_7ad1482b;
        self.var_7ad1482b++;
      }

      if(self zm_score::can_player_purchase(n_cost, 1)) {
        self function_c5d307a1(n_cost);
        return 0;
      } else {
        n_cost = zm_score::function_ffc2d0bc();

        if(n_cost == 0) {
          n_damage = idamage;
        } else {
          self function_c5d307a1(n_cost);
          n_damage = 0;
        }

        self bgb::take();
        return n_damage;
      }
    }
  }

  return -1;
}

function_c5d307a1(n_cost) {
  self zm_score::minus_to_player_score(n_cost, 1);

  if(self.var_d3df5e76.size > 1) {
    self.var_d3df5e76 = array::remove_index(self.var_d3df5e76, 0);
  }
}