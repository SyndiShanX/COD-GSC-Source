/************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\aats\ammomods\ammomod_shatterblast.gsc
************************************************************/

#using script_2c5daa95f8fec03c;
#using script_62caa307a394c18c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace ammomod_shatterblast;

function init_shatterblast() {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_2537d92585f4fce2"))) {
    level.var_1f737c8b = 1;
  }

  aat::register("ammomod_shatterblast", 0.33, 0, 25, 3, 1, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", undefined, #"explosive", undefined, #"hash_72956c8c7153f157");
  aat::register("ammomod_shatterblast_1", 0.33, 0, 25, 3, 1, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", undefined, #"explosive", undefined, #"hash_72956c8c7153f157");
  aat::register("ammomod_shatterblast_2", 0.33, 0, 25, 3, 1, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", undefined, #"explosive", undefined, #"hash_72956c8c7153f157");
  aat::register("ammomod_shatterblast_3", 0.33, 0, 25, 3, 1, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", undefined, #"explosive", undefined, #"hash_72956c8c7153f157");
  aat::register("ammomod_shatterblast_4", 0.33, 0, 25, 3, 1, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", undefined, #"explosive", undefined, #"hash_72956c8c7153f157");
  aat::register("ammomod_shatterblast_5", 0.33, 0, 25, 3, 1, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", undefined, #"explosive", undefined, #"hash_72956c8c7153f157");
  clientfield::register("toplayer", "ammomod_shatterblast_proc", 6000, 1, "counter");
}

function private function_93e5316a(aat_name = "ammomod_shatterblast") {
  switch (aat_name) {
    case # "ammomod_shatterblast":
    default:
      return 0;
    case # "ammomod_shatterblast_1":
      return 1;
    case # "ammomod_shatterblast_2":
      return 2;
    case # "ammomod_shatterblast_3":
      return 3;
    case # "ammomod_shatterblast_4":
      return 4;
    case # "ammomod_shatterblast_5":
      return 5;
  }

  return 0;
}

function result(death, attacker, mod, weapon, var_fd90b0bb, vpoint, shitloc = self.origin, boneindex) {
  waitframe(1);

  if(is_true(level.var_1f737c8b)) {
    return;
  }

  if(!isactor(self) && !isvehicle(self)) {
    return;
  }

  if(!isPlayer(var_fd90b0bb)) {
    return;
  }

  if(self.zm_ai_category === # "boss") {
    return;
  }

  aat_name = var_fd90b0bb aat::getaatonweapon(vpoint, 1);
  tier = function_93e5316a(aat_name);
  var_fd90b0bb clientfield::increment_to_player("ammomod_shatterblast_proc", 1);
  playFX("zm_weapons/fx9_aat_bul_impact_explosive", shitloc);
  var_fd90b0bb zm_utility::function_5d356609(aat_name, tier);
  self function_ddd30474(var_fd90b0bb, vpoint, shitloc, boneindex, tier);

  if(tier >= 5 && function_9465e5f8(var_fd90b0bb)) {
    level thread function_eb81be7e(var_fd90b0bb, vpoint, boneindex, shitloc);
  }
}

function function_2f3ba0ef(center) {
  angle = randomint(360);
  x_pos = center[0] + 64 * cos(angle);
  y_pos = center[1] + 64 * sin(angle);
  z_pos = center[2] + randomintrange(64 * -1, 64);
  var_f84680ae = (x_pos, y_pos, z_pos);
  return var_f84680ae;
}

function function_eb81be7e(attacker, weapon, shitloc, vpoint) {
  level endon(#"game_ended");

  if(isPlayer(attacker)) {
    attacker.aat_cooldown_start[# "hash_79b39f3766407263"] = float(gettime()) / 1000;
  }

  attacker endon(#"disconnected");
  var_624e473c = function_2f3ba0ef(vpoint);
  var_6f76e171 = function_2f3ba0ef(vpoint);
  var_623746f2 = function_2f3ba0ef(vpoint);
  var_ae78e48a = spawn("script_model", vpoint);
  var_3c3a800f = spawn("script_model", vpoint);
  var_5309adad = spawn("script_model", vpoint);
  var_ae78e48a setModel("tag_origin");
  var_3c3a800f setModel("tag_origin");
  var_5309adad setModel("tag_origin");
  playFXOnTag("zm_weapons/fx9_aat_shatterblast_lvl5_aoe_trail", var_ae78e48a, "tag_origin");
  playFXOnTag("zm_weapons/fx9_aat_shatterblast_lvl5_aoe_trail", var_3c3a800f, "tag_origin");
  playFXOnTag("zm_weapons/fx9_aat_shatterblast_lvl5_aoe_trail", var_5309adad, "tag_origin");
  time1 = randomfloatrange(0.4, 0.7);
  time2 = randomfloatrange(0.4, 0.7);
  var_846e9d0 = randomfloatrange(0.4, 0.7);
  var_ae78e48a thread function_a97aaed0(attacker, weapon, shitloc, var_624e473c);
  wait time1;
  var_3c3a800f thread function_a97aaed0(attacker, weapon, shitloc, var_6f76e171);
  wait time2;
  var_5309adad thread function_a97aaed0(attacker, weapon, shitloc, var_623746f2);
  wait var_846e9d0;
}

function function_a97aaed0(attacker, weapon, shitloc, point) {
  self endon(#"death");
  self moveto(point, 0.2);
  self waittill(#"movedone");
  level thread function_aa443b97(attacker, weapon, shitloc, point, 5, 1);
  self deletedelay();
}

function function_cbd0f7ea(attacker, damage, weapon) {
  var_e67ec32 = namespace_81245006::function_fab3ee3e(self);

  if(isarray(var_e67ec32)) {
    foreach(var_7092cd34 in var_e67ec32) {
      self function_945cac2d(damage, attacker, weapon, undefined, var_7092cd34);
    }
  }
}

function function_945cac2d(damage, attacker, weapon, shitloc, var_84ed9a13) {
  self namespace_42457a0::function_601fabe9(#"explosive", damage, self.origin, attacker, undefined, "none", "MOD_AAT", 0, weapon);

  if(!isDefined(var_84ed9a13)) {
    var_84ed9a13 = namespace_81245006::function_3131f5dd(self, shitloc, 1);
  }

  if(isDefined(var_84ed9a13) && is_true(var_84ed9a13.var_b98c4585)) {
    if(namespace_81245006::function_f29756fe(var_84ed9a13) == 1 && var_84ed9a13.type == # "armor" && var_84ed9a13.health > 0) {
      namespace_81245006::damageweakpoint(var_84ed9a13, var_84ed9a13.health);
    }

    if(namespace_81245006::function_f29756fe(var_84ed9a13) === 3 && isDefined(var_84ed9a13.var_f371ebb0)) {
      destructserverutils::function_8475c53a(self, var_84ed9a13.var_f371ebb0);

      if(isPlayer(attacker)) {
        attacker zm_stats::increment_challenge_stat(#"hash_2805701e53ce32a1");
        attacker zm_stats::increment_challenge_stat(#"hash_2a8df2f4c20fc21a");
        attacker stats::function_dad108fa(#"hash_20ef0c16d41d9cd2", 1);
        level scoreevents::doscoreeventcallback("scoreEventZM", {
          #attacker: attacker, #scoreevent: "destroyed_armor_zm"});
      }
    }

    if(var_84ed9a13.var_f371ebb0 === "body_armor") {
      callback::callback(#"hash_7d67d0e9046494fb");
    }
  }
}

function function_aa443b97(attacker, weapon, shitloc, vpoint, tier, extra = 0) {
  playrumbleonposition("grenade_rumble", vpoint);
  range = 64;

  if(!extra) {
    if(tier >= 4) {
      playFX("zm_weapons/fx9_aat_shatterblast_lvl4_exp", vpoint);
      range = 128;
    } else {
      playFX("zm_weapons/fx9_aat_shatterblast_lvl1_exp", vpoint);
    }
  } else {
    playFX("zm_weapons/fx9_aat_shatterblast_lvl5_aoe_exp_single", vpoint);
  }

  a_potential_targets = getentitiesinradius(vpoint, range, 15);

  foreach(zombie in a_potential_targets) {
    if(!isalive(zombie)) {
      continue;
    }

    damage = 50;

    if(zm_utility::is_survival()) {
      damage = zm_equipment::function_739fbb72(damage, undefined, zombie.zm_ai_category, zombie.maxhealth);
    } else {
      damage = zm_equipment::function_379f6b5d(damage, undefined, zombie.zm_ai_category, zombie.maxhealth);
    }

    if(damage >= zombie.health) {
      zombie.var_531d35d4 = 1;
    }

    if(tier >= 2) {
      if(zombie.zm_ai_category === # "normal") {
        zombie function_cbd0f7ea(weapon, damage, shitloc);
        var_6e1f497c = 1;
      }
    }

    if(!is_true(var_6e1f497c)) {
      zombie namespace_42457a0::function_601fabe9(#"explosive", damage, zombie.origin, weapon, undefined, "none", "MOD_AAT", 0, shitloc);
    }

    if(isalive(zombie)) {
      if(tier >= 3) {
        if(zombie.zm_ai_category === # "normal") {
          zombie zombie_utility::setup_zombie_knockdown(vpoint);
        }
      }
    } else if(zombie.zm_ai_category === # "normal") {
      v_curr_zombie_origin = zombie getcentroid();
      n_random_x = randomfloatrange(-3, 3);
      n_random_y = randomfloatrange(-3, 3);
      zombie zm_utility::start_ragdoll(1);
      zombie launchragdoll(60 * vectornormalize(v_curr_zombie_origin - vpoint + (n_random_x, n_random_y, 10)), "torso_lower");
    }

    util::wait_network_frame();
  }
}

function function_ddd30474(attacker, weapon, vpoint, shitloc, tier) {
  playrumbleonposition("grenade_rumble", vpoint);

  if(tier >= 1) {
    level thread function_aa443b97(attacker, weapon, shitloc, vpoint, tier);
  } else {
    playFX("zm_weapons/fx9_aat_shatterblast_lvl0_exp", vpoint);
  }

  if(isalive(self)) {
    damage = 50;

    if(zm_utility::is_survival()) {
      damage = zm_equipment::function_739fbb72(damage);
    } else {
      damage = zm_equipment::function_379f6b5d(damage);
    }

    if(damage >= self.health) {
      self.var_531d35d4 = 1;
    }

    self function_945cac2d(damage, attacker, weapon, shitloc);
  }
}

function private function_9465e5f8(attacker) {
  n_current_time = float(gettime()) / 1000;

  if(isPlayer(attacker)) {
    if(!isDefined(attacker.aat_cooldown_start[# "hash_79b39f3766407263"])) {
      return true;
    } else if(isDefined(attacker.aat_cooldown_start[# "hash_79b39f3766407263"]) && n_current_time >= attacker.aat_cooldown_start[# "hash_79b39f3766407263"] + 30) {
      return true;
    }
  }

  return false;
}