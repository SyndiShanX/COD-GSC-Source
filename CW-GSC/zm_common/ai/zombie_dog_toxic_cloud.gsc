/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\ai\zombie_dog_toxic_cloud.gsc
***************************************************/

#using script_24c32478acf44108;
#using script_5f261a5d57de5f7c;
#using script_62caa307a394c18c;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\scoreevents;
#using scripts\zm_common\zm_utility;
#namespace zombie_dog_toxic_cloud;

function private autoexec __init__system__() {
  system::register(#"hash_33449a50d9656246", &init_shared, undefined, undefined, undefined);
}

function init_shared() {
  clientfield::register("actor", "" + # "hash_584428de7fdfefe2", 1, 1, "int");
  clientfield::register("toplayer", "" + # "hash_313a6af163e4bef1", 1, 1, "counter");
  clientfield::register("toplayer", "" + # "hash_10eff6a8464fb235", 1, 1, "counter");
  clientfield::register("actor", "pustule_pulse_plague", 1, 1, "int");
  namespace_9ff9f642::register_slowdown(#"hash_10d83afaeb265fde", 0.85, 2);
  spawner::add_archetype_spawn_function(#"zombie_dog", &function_4f3cd1f0);
}

function function_4f3cd1f0() {
  if(self.subarchetype === # "hash_2a5479b83161cb35") {
    self.var_90d0c0ff = "anim_spawn_plaguehound";
    self clientfield::set("pustule_pulse_plague", 1);
    self callback::function_d8abfc3d(#"on_dog_killed", &function_a6c93300);
  }
}

function function_a6c93300(params) {
  self function_5b8201e0();

  if(!isDefined(self.exploded) && !is_true(self.var_270befd2)) {
    self.exploded = 1;
    self clientfield::set("" + # "hash_584428de7fdfefe2", 1);
    var_659d1778 = spawn("script_origin", self.origin);
    var_659d1778.targetname = "zombie_dog_toxic_cloud";
    var_659d1778 thread function_659d1778(self.attacker);
    self.var_7a68cd0c = 1;
    self ghost();
    self notsolid();

    if(isalive(self)) {
      if(zm_utility::is_magic_bullet_shield_enabled(self)) {
        self util::stop_magic_bullet_shield();
      }

      self.allowdeath = 1;
      self.takedamage = 1;
      self kill(undefined, undefined, undefined, undefined, undefined, 1);
    }
  }
}

function function_659d1778(attacker) {
  self endon(#"death");
  var_9a4ca881 = gettime() + 5000;
  var_7e6e7f9f = getweapon(#"tear_gas");
  params = getstatuseffect("dot_toxic_cloud");

  while(true) {
    alive_players = function_a1ef346b(undefined, self.origin, 110);

    foreach(player in alive_players) {
      if(player laststand::player_is_in_laststand() === 0) {
        if(player namespace_e86ffa8::function_3623f9d1(1)) {
          params = getstatuseffect("dot_toxic_cloud_staminup");
        }

        player status_effect::status_effect_apply(params, var_7e6e7f9f, self);
        player clientfield::increment_to_player("" + # "hash_313a6af163e4bef1", 1);
      }
    }

    if(var_9a4ca881 < gettime()) {
      self delete();
    }

    var_739bcc52 = [];

    foreach(vehicle in getvehiclearray()) {
      if(is_true(vehicle.isplayervehicle)) {
        var_739bcc52[var_739bcc52.size] = vehicle;
      }
    }

    all_targets = [];
    var_739bcc52 = function_72d3bca6(var_739bcc52, self.origin, undefined, undefined, 120);
    ai_targets = getentitiesinradius(self.origin, 110, 15);
    ai_targets = arraycombine(var_739bcc52, ai_targets, 0, 0);

    foreach(ai in ai_targets) {
      waitframe(1);

      if(isalive(ai) && ai.subarchetype !== # "hash_2a5479b83161cb35") {
        damage = 3;
        round = zm_utility::get_round_number();

        if(round >= 2) {
          if(round > 35) {
            round = 35;
          }

          adjustment_rounds = round - 2 + 1;
          adjustment_percentage = 1.2;
          var_e2d3357 = pow(adjustment_percentage, adjustment_rounds);
          damage = int(damage * var_e2d3357);
        }

        if(isvehicle(ai) && isDefined(ai.maxhealth)) {
          damage_cap = ai.maxhealth * 0.025;
          damage = int(min(damage, damage_cap));
        }

        if(isalive(ai)) {
          if(damage >= ai.health && !is_true(ai.var_b70158b5)) {
            scoreevents::function_a1f450c2("plaguehound_toxic_killingblow", attacker, ai);
            ai.var_b70158b5 = 1;
            ai.killed_by = attacker;
          }

          ai dodamage(damage, self.origin, undefined, undefined, "none", "MOD_BURNED", 0, undefined);
          scoreevents::function_82234b38(ai, attacker, undefined, undefined, undefined, undefined);

          if(ai.zm_ai_category === # "normal") {
            ai thread namespace_9ff9f642::slowdown(#"hash_10d83afaeb265fde");
          }

          if(isPlayer(attacker)) {
            point = aiutility::function_cb552839(ai);
            hud::function_c9800094(attacker, point, damage, 1, self namespace_42457a0::function_1b3815a7(#"toxic"));
          }
        }
      }
    }

    wait 0.2;
  }
}

function function_5b8201e0(params) {
  self clientfield::set("pustule_pulse_plague", 0);
}