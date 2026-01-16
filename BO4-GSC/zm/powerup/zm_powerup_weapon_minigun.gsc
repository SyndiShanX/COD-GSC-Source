/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_weapon_minigun.gsc
****************************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_powerup_weapon_minigun;

autoexec __init__system__() {
  system::register(#"zm_powerup_weapon_minigun", &__init__, undefined, undefined);
}

__init__() {
  zm_powerups::register_powerup("minigun", &grab_minigun);
  zm_powerups::register_powerup_weapon("minigun", &minigun_countdown);
  zm_powerups::powerup_set_prevent_pick_up_if_drinking("minigun", 1);
  zm_powerups::set_weapon_ignore_max_ammo("minigun");

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("minigun", "zombie_pickup_minigun", #"zombie/powerup_minigun", &func_should_drop_minigun, 1, 0, 0, undefined, "powerup_mini_gun", "zombie_powerup_minigun_time", "zombie_powerup_minigun_on");
    level.zombie_powerup_weapon[#"minigun"] = getweapon(#"minigun");
  }

  callback::on_connect(&init_player_zombie_vars);
  zm::register_actor_damage_callback(&minigun_damage_adjust);
}

grab_minigun(player) {
  level thread minigun_weapon_powerup(player);
  player thread zm_powerups::powerup_vo("minigun");

  if(isDefined(level._grab_minigun)) {
    level thread[[level._grab_minigun]](player);
  }
}

init_player_zombie_vars() {
  self.zombie_vars[#"zombie_powerup_minigun_on"] = 0;
  self.zombie_vars[#"zombie_powerup_minigun_time"] = 0;
}

func_should_drop_minigun() {
  if(zm_powerups::minigun_no_drop()) {
    return false;
  }

  return true;
}

minigun_weapon_powerup(ent_player, time) {
  ent_player endon(#"disconnect", #"death", #"player_downed");

  if(!isDefined(time)) {
    time = 30;
  }

  if(isDefined(level._minigun_time_override)) {
    time = level._minigun_time_override;
  }

  if(ent_player.zombie_vars[#"zombie_powerup_minigun_on"] && (level.zombie_powerup_weapon[#"minigun"] == ent_player getcurrentweapon() || isDefined(ent_player.has_powerup_weapon[#"minigun"]) && ent_player.has_powerup_weapon[#"minigun"])) {
    if(ent_player.zombie_vars[#"zombie_powerup_minigun_time"] < time) {
      ent_player.zombie_vars[#"zombie_powerup_minigun_time"] = time;
    }

    return;
  }

  level._zombie_minigun_powerup_last_stand_func = &minigun_powerup_last_stand;
  stance_disabled = 0;

  if(ent_player getstance() === "prone") {
    ent_player allowcrouch(0);
    ent_player allowprone(0);
    stance_disabled = 1;

    while(ent_player getstance() != "stand") {
      waitframe(1);
    }
  }

  zm_powerups::weapon_powerup(ent_player, time, "minigun", 1);

  if(stance_disabled) {
    ent_player allowcrouch(1);
    ent_player allowprone(1);
  }
}

minigun_powerup_last_stand() {
  zm_powerups::weapon_watch_gunner_downed("minigun");
}

minigun_countdown(ent_player, str_weapon_time) {
  while(ent_player.zombie_vars[str_weapon_time] > 0) {
    waitframe(1);
    ent_player.zombie_vars[str_weapon_time] -= 0.05;
  }
}

minigun_weapon_powerup_off() {
  self.zombie_vars[#"zombie_powerup_minigun_time"] = 0;
}

minigun_damage_adjust(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(weapon.name != "minigun") {
    return -1;
  }

  if(self.archetype == #"zombie" || self.archetype == #"zombie_dog" || self.archetype == #"zombie_quad") {
    n_percent_damage = self.health * randomfloatrange(0.34, 0.75);
  }

  if(isDefined(level.minigun_damage_adjust_override)) {
    n_override_damage = thread[[level.minigun_damage_adjust_override]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);

    if(isDefined(n_override_damage)) {
      n_percent_damage = n_override_damage;
    }
  }

  if(isDefined(n_percent_damage)) {
    damage += n_percent_damage;
  }

  return damage;
}