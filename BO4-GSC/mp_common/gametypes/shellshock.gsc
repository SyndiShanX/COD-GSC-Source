/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\shellshock.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\util;

#namespace shellshock;

autoexec __init__system__() {
  system::register(#"shellshock", &__init__, undefined, undefined);
}

__init__() {
  callback::on_start_gametype(&init);
  level.shellshockonplayerdamage = &on_damage;
}

init() {}

on_damage(cause, damage, weapon) {
  if(self util::isflashbanged()) {
    return;
  }

  if(self.health <= 0) {
    self clientfield::set_to_player("sndMelee", 0);
  }

  if(cause == "MOD_EXPLOSIVE" || cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_PROJECTILE" || cause == "MOD_PROJECTILE_SPLASH") {
    if(weapon.explosionradius == 0) {
      return;
    }

    time = 0;

    if(damage >= 90) {
      time = 4;
    } else if(damage >= 50) {
      time = 3;
    } else if(damage >= 25) {
      time = 2;
    } else if(damage > 10) {
      time = 2;
    }

    if(time) {
      if(self util::mayapplyscreeneffect() && self hasperk(#"specialty_flakjacket") == 0) {
        self shellshock(#"frag_grenade_mp", 0.5);
      }
    }
  }
}

end_on_death() {
  self waittill(#"death");
  waittillframeend();
  self notify(#"end_explode");
}

end_on_timer(timer) {
  self endon(#"disconnect");
  wait timer;
  self notify(#"end_on_timer");
}

rcbomb_earthquake(position) {
  playrumbleonposition("grenade_rumble", position);
  earthquake(0.5, 0.5, self.origin, 512);
}

reset_meleesnd() {
  self endon(#"death");
  wait 6;
  self clientfield::set_to_player("sndMelee", 0);
  self notify(#"snd_melee_end");
}