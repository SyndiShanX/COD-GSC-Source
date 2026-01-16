/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_secret_shopper.gsc
****************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_weapons;

#namespace zm_bgb_secret_shopper;

autoexec __init__system__() {
  system::register(#"zm_bgb_secret_shopper", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_secret_shopper", "time", 600, &enable, &disable, undefined, undefined);
}

enable() {
  self endon(#"disconnect", #"bled_out", #"bgb_update");
  level thread function_bdbf3da2(self);
}

disable() {}

function_bdbf3da2(player) {
  self notify("6daba2448119ac03");
  self endon("6daba2448119ac03");
  player endon(#"bgb_update", #"disconnect");

  while(true) {
    is_melee = player meleebuttonpressed();

    if(!is_melee) {
      waitframe(1);
      continue;
    }

    if(!isDefined(player.useholdent)) {
      waitframe(1);
      continue;
    }

    if(player.useholdent.targetname !== "weapon_upgrade") {
      waitframe(1);
      continue;
    }

    if(!player bgb::is_enabled(#"zm_bgb_secret_shopper")) {
      waitframe(1);
      continue;
    }

    if(player isswitchingweapons()) {
      waitframe(1);
      continue;
    }

    w_current = player.currentweapon;

    if(isDefined(w_current.ammoregen) && w_current.ammoregen) {
      waitframe(1);
      continue;
    }

    n_ammo_cost = player zm_weapons::get_ammo_cost_for_weapon(w_current);
    var_67807dc5 = 0;

    if(player zm_score::can_player_purchase(n_ammo_cost)) {
      var_67807dc5 = player zm_weapons::ammo_give(w_current);
    }

    if(var_67807dc5) {
      player zm_score::minus_to_player_score(n_ammo_cost);
      player bgb::do_one_shot_use(1);
    } else {
      player bgb::function_b57e693f();
    }

    waitframe(1);
  }
}