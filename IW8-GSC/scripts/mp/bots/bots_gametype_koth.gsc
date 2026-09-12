/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_koth.gsc
**************************************************/

function main() {
  setup_callbacks();
  setup_bot_koth();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &deactivate_minigun;
  level.bot_funcs["should_start_cautious_approach"] = &ref_132E0;
}

function setup_bot_koth() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var_0 = 0;

  foreach(var_2 in level.objectives) {
    var_2 thread scripts\mp\bots\bots_gametype_common::monitor_zone_control();
    var_3 = 0;

    if(istrue(var_2.trigger.trigger_off)) {
      var_2.trigger scripts\engine\utility::trigger_on();
      var_3 = 1;
    }

    var_2.nodes = scripts\mp\bots\bots_gametype_common::bot_get_valid_nodes_in_trigger(var_2.trigger);

    if(var_3) {
      var_2.trigger scripts\engine\utility::trigger_off();
    }
  }

  level.death_info_func = 1;

  if(!var_0) {
    level.deactivate_battle_station = 1;
    var_5 = level.zone;

    if(!isDefined(var_5)) {
      var_5 = scripts\engine\utility::random(level.objectives);
    }

    scripts\mp\bots\bots_gametype_common::custom_damageshield([var_5]);
    level.damagepercentmedium[var_5.trigger getentitynumber()] = 1;
    level.bot_gametype_precaching_done = 1;
    thread custom_damage_handler(var_5);
    return;
  }
}

function custom_damage_handler(var_0) {
  for(var_1 = scripts\engine\utility::array_remove(level.objectives, var_0); var_1.size > 0; var_1 = scripts\engine\utility::array_remove(var_1, var_2)) {
    var_2 = undefined;
    var_3 = level.zone;

    if(isDefined(var_3) && scripts\engine\utility::array_contains(var_1, var_3)) {
      var_2 = var_3;
    } else {
      var_2 = scripts\engine\utility::random(var_1);
    }

    scripts\mp\bots\bots_gametype_common::custom_damageshield([var_2]);
    level.damagepercentmedium[var_2.trigger getentitynumber()] = 1;
  }
}

function deactivate_minigun() {
  self notify("bot_koth_think");
  self endon("bot_koth_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  var_0 = undefined;
  var_1 = level.zone;

  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }

    if(!isDefined(level.zone) || !isDefined(level.damagepercentmedium[level.zone.trigger getentitynumber()])) {
      if(scripts\mp\bots\bots_util::bot_is_defending()) {
        scripts\mp\bots\bots_strategy::bot_defend_stop();
      }

      self.initpayloadpunish = undefined;
      self[[self.personality_update_function]]();
      continue;
    }

    if(var_1 != level.zone) {
      var_0 = undefined;
      var_1 = level.zone;
    }

    if(!istrue(level.zone.trigger.trigger_off) && isDefined(level.zoneendtime) && !isDefined(var_0) && !level.zonerandomlocationorder && level.deactivate_battle_station) {
      var_2 = level.zoneendtime - gettime();

      if(var_2 > 0 && var_2 < 10000) {
        var_3 = level.zone scripts\mp\gameobjects::getownerteam() == self.team;

        if(!var_3) {
          var_4 = level.zone.ref_14713.radius * 6;

          if(var_2 < 5000) {
            var_4 = level.zone.ref_14713.radius * 3;
          }

          var_5 = distance(level.zone.ref_14713.center, self.origin);

          if(var_5 > var_4) {
            var_0 = deathsdoorsfx();
          }
        } else {
          var_6 = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);
          var_7 = ceil(var_6 / 2);

          if(var_2 < 5000) {
            var_7 = ceil(var_6 / 3);
          }

          var_8 = damagestateref(level.zone);

          if(var_8 + 1 > var_7) {
            var_0 = deathsdoorsfx();
          }
        }
      }
    }

    var_9 = level.zone;

    if(istrue(var_0)) {
      var_10 = (level.prevzoneindex + 1) % level.objectives.size;

      if(var_10 == 0) {
        var_10 = 1;
      }

      var_9 = level.objectives[scripts\engine\utility::string(var_10)];
    }

    if(!deactivate_gas_trap_puddles(var_9)) {
      custom_ground_vehicle_death_func(var_9);
    }
  }
}

function deathsdoorsfx() {
  if(level.zonerandomlocationorder) {
    return 0;
  }

  var_0 = self botgetdifficultysetting("strategyLevel");
  var_1 = 0;

  if(var_0 == 1) {
    var_1 = 0.1;
  } else if(var_0 == 2) {
    var_1 = 0.5;
  } else if(var_0 == 3) {
    var_1 = 0.8;
  }

  return randomfloat(1) < var_1;
}

function damagestateref(var_0) {
  return dangernotifyplayersinrange(var_0).size;
}

function dangernotifyplayersinrange(var_0) {
  var_1 = [];

  foreach(var_3 in level.participants) {
    if(var_3 != self && scripts\mp\utility\entity::isteamparticipant(var_3) && istestclient(self, var_3)) {
      if(var_3 istouching(level.zone.trigger)) {
        if(!isai(var_3) || deactivate_gas_trap_puddles(var_3, var_0)) {
          var_1 = var_3;
        }
      }
    }
  }

  return var_1;
}

function deactivate_gas_trap_puddles(var_0) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing()) {
    return false;
  }

  return self.initpayloadpunish == var_0;
}

function custom_ground_vehicle_death_func(var_0) {
  self.initpayloadpunish = var_0;
  GscBinSkip1(0x45, "entrance_points_index", var_0.entrance_indices);
}

function ref_132E0(var_0) {
  if(var_0) {
    var_1 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var_1 == "neutral" || var_1 == self.team) {
      return 0;
    }
  }

  return scripts\mp\bots\bots_strategy::should_start_cautious_approach_default(var_0);
}