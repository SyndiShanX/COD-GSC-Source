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
  level.bot_funcs["should_start_cautious_approach"] = &ref_132e0;
}

function setup_bot_koth() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  var0 = 0;

  foreach(var2 in level.objectives) {
    var2 thread scripts\mp\bots\bots_gametype_common::monitor_zone_control();
    var3 = 0;

    if(istrue(var2.trigger.trigger_off)) {
      var2.trigger scripts\engine\utility::trigger_on();
      var3 = 1;
    }

    var2.nodes = scripts\mp\bots\bots_gametype_common::bot_get_valid_nodes_in_trigger(var2.trigger);

    if(var3) {
      var2.trigger scripts\engine\utility::trigger_off();
    }
  }

  level.death_info_func = 1;

  if(!var0) {
    level.deactivate_battle_station = 1;
    var5 = level.zone;

    if(!isDefined(var5)) {
      var5 = scripts\engine\utility::random(level.objectives);
    }

    scripts\mp\bots\bots_gametype_common::custom_damageshield([var5]);
    level.damagepercentmedium[var5.trigger getentitynumber()] = 1;
    level.bot_gametype_precaching_done = 1;
    thread custom_damage_handler(var5);
    return;
  }
}

function custom_damage_handler(var0) {
  for(var1 = scripts\engine\utility::array_remove(level.objectives, var0); var1.size > 0; var1 = scripts\engine\utility::array_remove(var1, var2)) {
    var2 = undefined;
    var3 = level.zone;

    if(isDefined(var3) && scripts\engine\utility::array_contains(var1, var3)) {
      var2 = var3;
    } else {
      var2 = scripts\engine\utility::random(var1);
    }

    scripts\mp\bots\bots_gametype_common::custom_damageshield([var2]);
    level.damagepercentmedium[var2.trigger getentitynumber()] = 1;
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
  var0 = undefined;
  var1 = level.zone;

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

    if(var1 != level.zone) {
      var0 = undefined;
      var1 = level.zone;
    }

    if(!istrue(level.zone.trigger.trigger_off) && isDefined(level.zoneendtime) && !isDefined(var0) && !level.zonerandomlocationorder && level.deactivate_battle_station) {
      var2 = level.zoneendtime - gettime();

      if(var2 > 0 && var2 < 10000) {
        var3 = level.zone scripts\mp\gameobjects::getownerteam() == self.team;

        if(!var3) {
          var4 = level.zone.ref_14713.radius * 6;

          if(var2 < 5000) {
            var4 = level.zone.ref_14713.radius * 3;
          }

          var5 = distance(level.zone.ref_14713.center, self.origin);

          if(var5 > var4) {
            var0 = deathsdoorsfx();
          }
        } else {
          var6 = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);
          var7 = ceil(var6 / 2);

          if(var2 < 5000) {
            var7 = ceil(var6 / 3);
          }

          var8 = damagestateref(level.zone);

          if(var8 + 1 > var7) {
            var0 = deathsdoorsfx();
          }
        }
      }
    }

    var9 = level.zone;

    if(istrue(var0)) {
      var10 = (level.prevzoneindex + 1) % level.objectives.size;

      if(var10 == 0) {
        var10 = 1;
      }

      var9 = level.objectives[scripts\engine\utility::string(var10)];
    }

    if(!deactivate_gas_trap_puddles(var9)) {
      custom_ground_vehicle_death_func(var9);
    }
  }
}

function deathsdoorsfx() {
  if(level.zonerandomlocationorder) {
    return 0;
  }

  var0 = self botgetdifficultysetting("strategyLevel");
  var1 = 0;

  if(var0 == 1) {
    var1 = 0.1;
  } else if(var0 == 2) {
    var1 = 0.5;
  } else if(var0 == 3) {
    var1 = 0.8;
  }

  return randomfloat(1) < var1;
}

function damagestateref(var0) {
  return dangernotifyplayersinrange(var0).size;
}

function dangernotifyplayersinrange(var0) {
  var1 = [];

  foreach(var3 in level.participants) {
    if(var3 != self && scripts\mp\utility\entity::isteamparticipant(var3) && istestclient(self, var3)) {
      if(var3 istouching(level.zone.trigger)) {
        if(!isai(var3) || deactivate_gas_trap_puddles(var3, var0)) {
          var1 = var3;
        }
      }
    }
  }

  return var1;
}

function deactivate_gas_trap_puddles(var0) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing()) {
    return false;
  }

  return self.initpayloadpunish == var0;
}

function custom_ground_vehicle_death_func(var0) {
  self.initpayloadpunish = var0;
  GscBinSkip1(0x45, "entrance_points_index", var0.entrance_indices);
}

function ref_132e0(var0) {
  if(var0) {
    var1 = level.zone scripts\mp\gameobjects::getownerteam();

    if(var1 == "neutral" || var1 == self.team) {
      return 0;
    }
  }

  return scripts\mp\bots\bots_strategy::should_start_cautious_approach_default(var0);
}