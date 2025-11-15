/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_quick_revive.gsc
************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\perks;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_utility;

#namespace zm_perk_mod_quick_revive;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_quick_revive", &__init__, undefined, undefined);
}

__init__() {
  enable_quick_revive_perk_for_level();
}

enable_quick_revive_perk_for_level() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_quickrevive", "mod_revive", #"perk_quick_revive", #"specialty_quickrevive", 2500);
  zm_perks::register_perk_threads(#"specialty_mod_quickrevive", &give_perk, &take_perk);
  callback::on_revived(&on_revived);
}

give_perk() {
  self thread monitor_health_regen();
}

take_perk(b_pause, str_perk, str_result, n_slot) {
  self notify(#"hash_478eed143ecc82fc");

  if(self hasperk(#"specialty_sprintspeed")) {
    self perks::perk_unsetperk(#"specialty_sprintspeed");
  }
}

on_revived(s_params) {
  if(isplayer(s_params.e_reviver) && s_params.e_reviver hasperk(#"specialty_mod_quickrevive")) {
    s_params.e_reviver zm_utility::set_max_health();
    s_params.e_reviver thread function_118be9d8();
  } else {
    return;
  }

  if(isplayer(s_params.e_revivee)) {
    s_params.e_revivee thread function_118be9d8();
  }
}

monitor_health_regen() {
  self endon(#"hash_478eed143ecc82fc", #"disconnect");

  while(true) {
    self waittill(#"snd_breathing_better");

    if(!(isDefined(self.heal.enabled) && self.heal.enabled)) {
      continue;
    }

    self thread function_118be9d8();
    wait 3;
  }
}

function_118be9d8() {
  self notify("16d61e93859b61b7");
  self endon("16d61e93859b61b7");
  self endon(#"hash_478eed143ecc82fc", #"disconnect");

  if(!self hasperk(#"specialty_sprintspeed")) {
    self perks::perk_setperk(#"specialty_sprintspeed");
  }

  wait 3;

  if(self hasperk(#"specialty_sprintspeed")) {
    self perks::perk_unsetperk(#"specialty_sprintspeed");
  }
}