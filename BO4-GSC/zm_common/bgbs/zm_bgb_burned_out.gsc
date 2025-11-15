/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_burned_out.gsc
************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;

#namespace zm_bgb_burned_out;

autoexec __init__system__() {
  system::register(#"zm_bgb_burned_out", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_burned_out", "event", &event, undefined, undefined, undefined);
  clientfield::register("toplayer", "zm_bgb_burned_out" + "_1p" + "toplayer", 1, 1, "counter");
  clientfield::register("allplayers", "zm_bgb_burned_out" + "_3p" + "_allplayers", 1, 1, "counter");
  clientfield::register("actor", "zm_bgb_burned_out" + "_fire_torso" + "_actor", 1, 1, "counter");
  clientfield::register("vehicle", "zm_bgb_burned_out" + "_fire_torso" + "_vehicle", 1, 1, "counter");
}

event() {
  self endon(#"disconnect", #"bgb_update");
  var_3c24cb96 = 0;
  self thread bgb::set_timer(3, 3);

  for(;;) {
    waitresult = self waittill(#"damage", #"damage_armor");
    type = waitresult.mod;
    attacker = waitresult.attacker;

    if("MOD_MELEE" != type || !isai(attacker)) {
      continue;
    }

    self thread result();
    self playSound(#"zmb_bgb_powerup_burnedout");
    var_3c24cb96++;
    self thread bgb::set_timer(3 - var_3c24cb96, 3);
    self bgb::do_one_shot_use();

    if(3 <= var_3c24cb96) {
      return;
    }

    wait 1.5;
  }
}

result() {
  self clientfield::increment_to_player("zm_bgb_burned_out" + "_1p" + "toplayer");
  self clientfield::increment("zm_bgb_burned_out" + "_3p" + "_allplayers");
  zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 128);

  if(!isDefined(zombies)) {
    return;
  }

  dist_sq = 128 * 128;
  var_7694ea6b = [];

  for(i = 0; i < zombies.size; i++) {
    if(zombies[i].zm_ai_category !== #"basic" && zombies[i].zm_ai_category !== #"popcorn" && zombies[i].zm_ai_category !== #"enhanced") {
      continue;
    }

    if(isDefined(zombies[i].ignore_nuke) && zombies[i].ignore_nuke) {
      continue;
    }

    if(isDefined(zombies[i].marked_for_death) && zombies[i].marked_for_death) {
      continue;
    }

    if(zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
      continue;
    }

    zombies[i].marked_for_death = 1;

    if(!isalive(zombies[i])) {
      continue;
    }

    if(isvehicle(zombies[i])) {
      zombies[i] clientfield::increment("zm_bgb_burned_out" + "_fire_torso" + "_vehicle");
    } else {
      zombies[i] clientfield::increment("zm_bgb_burned_out" + "_fire_torso" + "_actor");
    }

    var_7694ea6b[var_7694ea6b.size] = zombies[i];
  }

  for(i = 0; i < var_7694ea6b.size; i++) {
    util::wait_network_frame();

    if(!isDefined(var_7694ea6b[i])) {
      continue;
    }

    if(zm_utility::is_magic_bullet_shield_enabled(var_7694ea6b[i])) {
      continue;
    }

    var_7694ea6b[i] dodamage(var_7694ea6b[i].health + 666, var_7694ea6b[i].origin, self, undefined, undefined, "MOD_BURNED", 0, level.weapondefault);

    if(isDefined(self)) {
      self zm_stats::increment_challenge_stat(#"gum_gobbler_burned_out");
    }
  }
}