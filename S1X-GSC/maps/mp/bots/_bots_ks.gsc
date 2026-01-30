/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_ks.gsc
**************************************/

bot_killstreak_setup() {
  var_0 = gettime();

  if(!isDefined(level.killstreak_botfunc)) {
    thread bot_setup_map_specific_killstreaks();
    bot_register_killstreak_func("uav", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("orbital_carepackage", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("heavy_exosuit", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("nuke", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("emp", ::bot_killstreak_simple_use, ::bot_can_use_emp);
    bot_register_killstreak_func("remote_mg_sentry_turret", maps\mp\bots\_bots_sentry::bot_killstreak_sentry, maps\mp\bots\_bots_sentry::bot_can_use_sentry_only_ai_version, "turret");
    bot_register_killstreak_func("assault_ugv", ::bot_killstreak_simple_use, ::bot_can_use_assault_ugv_only_ai_version);
    bot_register_killstreak_func("warbird", ::bot_killstreak_simple_use, ::bot_can_use_warbird_only_ai_version);
    bot_register_killstreak_func("strafing_run_airstrike", ::bot_killstreak_choose_loc_enemies, ::bot_can_use_strafing_run);
    bot_register_killstreak_func("orbitalsupport", ::bot_killstreak_never_use, ::bot_killstreak_do_not_use);
    bot_register_killstreak_func("recon_ugv", ::bot_killstreak_never_use, ::bot_killstreak_do_not_use);
    bot_register_killstreak_func("orbital_strike_laser", ::bot_killstreak_never_use, ::bot_killstreak_do_not_use);
    bot_register_killstreak_func("missile_strike", ::bot_killstreak_never_use, ::bot_killstreak_do_not_use);
  }

  thread maps\mp\bots\_bots_ks_remote_vehicle::remote_vehicle_setup();
}

bot_setup_map_specific_killstreaks() {
  wait 0.5;

  if(isDefined(level.mapcustombotkillstreakfunc)) {
    [[level.mapcustombotkillstreakfunc]]();
  } else if(isDefined(level.mapkillstreak)) {
    bot_register_killstreak_func(level.mapkillstreak, ::bot_killstreak_never_use, ::bot_killstreak_do_not_use);
  }
}

bot_register_killstreak_func(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.killstreak_botfunc)) {
    level.killstreak_botfunc = [];
  }

  level.killstreak_botfunc[var_0] = var_1;

  if(!isDefined(level.killstreak_botcanuse)) {
    level.killstreak_botcanuse = [];
  }

  level.killstreak_botcanuse[var_0] = var_2;

  if(!isDefined(level.killstreak_botparm)) {
    level.killstreak_botparm = [];
  }

  level.killstreak_botparm[var_0] = var_3;

  if(!isDefined(level.bot_supported_killstreaks)) {
    level.bot_supported_killstreaks = [];
  }

  level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = var_0;
}

bot_is_valid_killstreak(var_0, var_1) {
  if(bot_killstreak_is_valid_internal(var_0, "bots", undefined)) {
    return 1;
  } else if(var_1) {}

  return 0;
}

bot_killstreak_is_valid_internal(var_0, var_1, var_2) {
  if(!bot_killstreak_is_valid_single(var_0, var_1)) {
    return 0;
  }

  return 1;
}

bot_killstreak_is_valid_single(var_0, var_1) {
  if(var_1 == "humans") {
    return isDefined(level.killstreakfuncs[var_0]) && maps\mp\_utility::getkillstreakindex(var_0) != -1;
  } else if(var_1 == "bots") {
    return isDefined(level.killstreak_botfunc[var_0]);
  }
}

bot_think_killstreak() {
  self notify("bot_think_killstreak");
  self endon("bot_think_killstreak");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level.killstreak_botfunc)) {
    wait 0.05;
  }

  for(;;) {
    if(maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
      var_0 = self.pers["killstreaks"];

      if(isDefined(var_0)) {
        var_1 = 0;

        for(var_2 = 0; var_2 < var_0.size && !var_1; var_2++) {
          var_3 = var_0[var_2];

          if(isDefined(var_3.streakname) && isDefined(self.bot_killstreak_wait) && isDefined(self.bot_killstreak_wait[var_3.streakname]) && gettime() < self.bot_killstreak_wait[var_3.streakname]) {
            continue;
          }
          if(var_3.available) {
            var_4 = var_3.streakname;
            var_3.weapon = maps\mp\_utility::getkillstreakweapon(var_3.streakname, var_3.modules);
            var_5 = level.killstreak_botcanuse[var_4];

            if(isDefined(var_5) && !self[[var_5]](var_3)) {
              continue;
            }
            if(!maps\mp\_utility::validateusestreak(var_3.streakname, 1)) {
              continue;
            }
            var_6 = level.killstreak_botfunc[var_4];

            if(isDefined(var_6)) {
              var_7 = self[[var_6]](var_3, var_0, var_5, level.killstreak_botparm[var_3.streakname]);

              if(!isDefined(var_7) || var_7 == 0) {
                if(!isDefined(self.bot_killstreak_wait)) {
                  self.bot_killstreak_wait = [];
                }

                self.bot_killstreak_wait[var_3.streakname] = gettime() + 5000;
              }
            } else {
              var_3.available = 0;
              maps\mp\killstreaks\_killstreaks::updatekillstreaks(0);
            }

            var_1 = 1;
          }
        }
      }
    }

    wait(randomfloatrange(2.0, 4.0));
  }
}

bot_killstreak_never_use() {}

bot_killstreak_do_not_use(var_0) {
  return 0;
}

bot_killstreak_can_use_weapon_version(var_0) {
  return var_0.weapon == "killstreak_uav_mp";
}

bot_can_use_warbird_only_ai_version(var_0) {
  if(!bot_killstreak_can_use_weapon_version(var_0)) {
    return 0;
  }

  if(!bot_can_use_warbird(var_0)) {
    return 0;
  }

  return 1;
}

bot_can_use_warbird(var_0) {
  if(!maps\mp\killstreaks\_warbird::canusewarbird()) {
    return 0;
  }

  if(vehicle_would_exceed_limit()) {
    return 0;
  }

  return 1;
}

bot_can_use_assault_ugv_only_ai_version(var_0) {
  if(!bot_killstreak_can_use_weapon_version(var_0)) {
    return 0;
  }

  if(!bot_can_use_assault_ugv(var_0)) {
    return 0;
  }

  return 1;
}

bot_can_use_assault_ugv(var_0) {
  if(vehicle_would_exceed_limit()) {
    return 0;
  }

  return 1;
}

vehicle_would_exceed_limit() {
  return maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed();
}

bot_can_use_emp(var_0) {
  if(isDefined(level.empplayer)) {
    return 0;
  }

  var_1 = level.otherteam[self.team];

  if(isDefined(level.teamemped) && isDefined(level.teamemped[var_1]) && level.teamemped[var_1]) {
    return 0;
  }

  return 1;
}

bot_can_use_strafing_run(var_0) {
  if(isDefined(level.strafing_run_airstrike)) {
    return 0;
  }

  return 1;
}

bot_killstreak_simple_use(var_0, var_1, var_2, var_3) {
  wait(randomintrange(3, 5));

  if(!maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
    return 1;
  }

  if(isDefined(var_2) && !self[[var_2]](var_0)) {
    return 0;
  }

  bot_switch_to_killstreak_weapon(var_0, var_1, var_0.weapon);
  return 1;
}

bot_killstreak_drop_anywhere(var_0, var_1, var_2, var_3) {
  bot_killstreak_drop(var_0, var_1, var_2, var_3, "anywhere");
}

bot_killstreak_drop_outside(var_0, var_1, var_2, var_3) {
  bot_killstreak_drop(var_0, var_1, var_2, var_3, "outside");
}

bot_killstreak_drop_hidden(var_0, var_1, var_2, var_3) {
  bot_killstreak_drop(var_0, var_1, var_2, var_3, "hidden");
}

bot_killstreak_drop(var_0, var_1, var_2, var_3, var_4) {
  wait(randomintrange(2, 4));

  if(!isDefined(var_4)) {
    var_4 = "anywhere";
  }

  if(!maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
    return 1;
  }

  if(isDefined(var_2) && !self[[var_2]](var_0)) {
    return 0;
  }

  var_5 = self getweaponammoclip(var_0.weapon) + self getweaponammostock(var_0.weapon);

  if(var_5 == 0) {
    foreach(var_7 in var_1) {
      if(isDefined(var_7.streakname) && var_7.streakname == var_0.streakname) {
        var_7.available = 0;
      }
    }

    maps\mp\killstreaks\_killstreaks::updatekillstreaks(0);
    return 1;
  }

  var_9 = undefined;

  if(var_4 == "outside") {
    var_10 = [];
    var_11 = maps\mp\bots\_bots_util::bot_get_nodes_in_cone(0, 750, 0.6, 1);

    foreach(var_13 in var_11) {
      if(nodeexposedtosky(var_13)) {
        var_10 = common_scripts\utility::array_add(var_10, var_13);
      }
    }

    if(var_11.size > 5 && var_10.size > var_11.size * 0.6) {
      var_15 = common_scripts\utility::get_array_of_closest(self.origin, var_10, undefined, undefined, undefined, 150);

      if(var_15.size > 0) {
        var_9 = common_scripts\utility::random(var_15);
      } else {
        var_9 = common_scripts\utility::random(var_10);
      }
    }
  } else if(var_4 == "hidden") {
    var_16 = getnodesinradius(self.origin, 256, 0, 40);
    var_17 = self getnearestnode();

    if(isDefined(var_17)) {
      var_18 = [];

      foreach(var_13 in var_16) {
        if(nodesvisible(var_17, var_13, 1)) {
          var_18 = common_scripts\utility::array_add(var_18, var_13);
        }
      }

      var_9 = self botnodepick(var_18, 1, "node_hide");
    }
  }

  if(isDefined(var_9) || var_4 == "anywhere") {
    self botsetflag("disable_movement", 1);

    if(isDefined(var_9)) {
      self botlookatpoint(var_9.origin, 2.45, "script_forced");
    }

    bot_switch_to_killstreak_weapon(var_0, var_1, var_0.weapon);
    wait 2.0;
    self botpressbutton("attack");
    wait 1.5;
    self switchtoweapon("none");
    self botsetflag("disable_movement", 0);
  }

  return 1;
}

bot_switch_to_killstreak_weapon(var_0, var_1, var_2) {
  bot_notify_streak_used(var_0, var_1);
  wait 0.05;
  self switchtoweapon(var_2);
}

bot_notify_streak_used(var_0, var_1) {
  if(isDefined(var_0.isgimme) && var_0.isgimme) {
    self notify("streakUsed1");
  } else {
    for(var_2 = 0; var_2 < 3; var_2++) {
      if(isDefined(var_1[var_2].streakname)) {
        if(var_1[var_2].streakname == var_0.streakname) {
          break;
        }
      }
    }

    self notify("streakUsed" + (var_2 + 1));
  }
}

bot_killstreak_choose_loc_enemies(var_0, var_1, var_2, var_3) {
  wait(randomintrange(3, 5));

  if(!maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
    return;
  }
  var_4 = getzonenearest(self.origin);

  if(!isDefined(var_4)) {
    return;
  }
  self botsetflag("disable_movement", 1);
  bot_switch_to_killstreak_weapon(var_0, var_1, var_0.weapon);
  wait 2;

  if(!isDefined(self.selectinglocation)) {
    return;
  }
  var_5 = level.zonecount;
  var_6 = -1;
  var_7 = 0;
  var_8 = [];
  var_9 = randomfloat(100) > 50;

  for(var_10 = 0; var_10 < var_5; var_10++) {
    if(var_9) {
      var_11 = var_5 - 1 - var_10;
    } else {
      var_11 = var_10;
    }

    if(var_11 != var_4 && botzonegetindoorpercent(var_11) < 0.25) {
      var_12 = botzonegetcount(var_11, self.team, "enemy_predict");

      if(var_12 > var_7) {
        var_6 = var_11;
        var_7 = var_12;
      }

      var_8 = common_scripts\utility::array_add(var_8, var_11);
    }
  }

  if(var_6 >= 0) {
    var_13 = getzoneorigin(var_6);
  } else if(var_8.size > 0) {
    var_13 = getzoneorigin(common_scripts\utility::random(var_8));
  } else {
    var_13 = getzoneorigin(randomint(level.zonecount));
  }

  var_14 = (randomfloatrange(-500, 500), randomfloatrange(-500, 500), 0);
  var_15 = 1;

  while(var_15) {
    self notify("confirm_location", var_13 + var_14, randomintrange(0, 360));
    var_16 = common_scripts\utility::waittill_any_return("location_selection_complete", "airstrikeShowBlockedHUD");

    if(var_16 == "location_selection_complete") {
      var_15 = 0;
      continue;
    }

    wait 0.5;
  }

  wait 1.0;
  self botsetflag("disable_movement", 0);
}

bot_think_watch_aerial_killstreak() {
  self notify("bot_think_watch_aerial_killstreak");
  self endon("bot_think_watch_aerial_killstreak");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(level.last_global_badplace_time)) {
    level.last_global_badplace_time = -10000;
  }

  if(!isDefined(level.killstreak_global_bp_exists_for)) {
    level.killstreak_global_bp_exists_for["allies"] = [];
    level.killstreak_global_bp_exists_for["axis"] = [];
  }

  if(!isDefined(level.aerial_danger_exists_for)) {
    level.aerial_danger_exists_for["allies"] = 0;
    level.aerial_danger_exists_for["axis"] = 0;
  }

  var_0 = 0;
  var_1 = randomfloatrange(0.05, 4.0);

  for(;;) {
    wait(var_1);
    var_1 = randomfloatrange(0.05, 4.0);

    if(maps\mp\bots\_bots_util::bot_is_remote_or_linked()) {
      continue;
    }
    if(self botgetdifficultysetting("strategyLevel") == 0) {
      continue;
    }
    var_2 = 0;
    var_3 = get_enemy_warbird(self.team);

    if(isDefined(var_3)) {
      var_2 = 1;

      if(!bot_is_monitoring_aerial_danger(var_3)) {
        childthread monitor_aerial_danger(var_3);
      }
    }

    if(enemy_paladin_exists(self.team)) {
      var_2 = 1;

      if(!bot_is_monitoring_aerial_danger(level.orbitalsupport_planemodel)) {
        childthread monitor_aerial_danger(level.orbitalsupport_planemodel);
      }
    }

    if(enemy_orbital_laser_exists(self.team)) {
      try_place_global_badplace("orbital_laser", ::enemy_orbital_laser_exists);
      var_2 = 1;
    }

    if(enemy_missile_strike_exists(self.team)) {
      try_place_global_badplace("missile_strike", ::enemy_missile_strike_exists);
      var_2 = 1;
    }

    if(enemy_strafing_run_exists(self.team)) {
      try_place_global_badplace("missile_strike", ::enemy_strafing_run_exists);
      var_2 = 1;
    }

    if(!var_0 && var_2) {
      var_0 = 1;
      self botsetflag("hide_indoors", 1);
    }

    if(var_0 && !var_2) {
      var_0 = 0;
      self botsetflag("hide_indoors", 0);
    }

    level.aerial_danger_exists_for[self.team] = var_2;
  }
}

bot_is_monitoring_aerial_danger(var_0) {
  if(!isDefined(self.aerial_dangers_monitoring)) {
    return 0;
  }

  return common_scripts\utility::array_contains(self.aerial_dangers_monitoring, var_0);
}

monitor_aerial_danger(var_0) {
  if(!isDefined(self.aerial_dangers_monitoring)) {
    self.aerial_dangers_monitoring = [];
  }

  self.aerial_dangers_monitoring[self.aerial_dangers_monitoring.size] = var_0;
  var_1 = vectornormalize((var_0.origin - self.origin) * (1, 1, 0));

  while(isalive(var_0)) {
    var_2 = vectornormalize((var_0.origin - self.origin) * (1, 1, 0));
    var_3 = vectordot(var_1, var_2);

    if(var_3 <= 0) {
      var_1 = var_2;
      self notify("defend_force_node_recalculation");
    }

    wait 0.05;
  }

  self.aerial_dangers_monitoring = common_scripts\utility::array_remove(self.aerial_dangers_monitoring, var_0);
}

try_place_global_badplace(var_0, var_1) {
  if(!isDefined(level.killstreak_global_bp_exists_for[self.team][var_0])) {
    level.killstreak_global_bp_exists_for[self.team][var_0] = 0;
  }

  if(!level.killstreak_global_bp_exists_for[self.team][var_0]) {
    level.killstreak_global_bp_exists_for[self.team][var_0] = 1;
    level thread monitor_enemy_dangerous_killstreak(self.team, var_0, var_1);
  }
}

monitor_enemy_dangerous_killstreak(var_0, var_1, var_2) {
  var_3 = 0.5;

  while([[var_2]](var_0)) {
    if(gettime() > level.last_global_badplace_time + 4000) {
      badplace_global("", 5.0, var_0, "only_sky");
      level.last_global_badplace_time = gettime();
    }

    wait(var_3);
  }

  level.killstreak_global_bp_exists_for[var_0][var_1] = 0;
}

get_enemy_warbird(var_0) {
  if(isDefined(level.spawnedwarbirds)) {
    foreach(var_2 in level.spawnedwarbirds) {
      if(!level.teambased || var_2.team != var_0) {
        return var_2;
      }
    }
  }

  return undefined;
}

enemy_orbital_laser_exists(var_0) {
  if(isDefined(level.orbital_lasers)) {
    foreach(var_2 in level.orbital_lasers) {
      if(!level.teambased || var_2.team != var_0) {
        return 1;
      }
    }
  }

  return 0;
}

enemy_paladin_exists(var_0) {
  if(level.orbitalsupportinuse) {
    if(isDefined(level.orbitalsupport_planemodel) && isDefined(level.orbitalsupport_planemodel.owner)) {
      if(!level.teambased || level.orbitalsupport_planemodel.owner.team != var_0) {
        return 1;
      }
    }
  }

  return 0;
}

enemy_missile_strike_exists(var_0) {
  if(isDefined(level.remotemissileinprogress)) {
    foreach(var_2 in level.rockets) {
      if(var_2.type == "remote" && var_2.team != var_0) {
        return 1;
      }
    }
  }

  return 0;
}

enemy_strafing_run_exists(var_0) {
  if(isDefined(level.artillerydangercenters)) {
    foreach(var_2 in level.artillerydangercenters) {
      if(maps\mp\_utility::isstrstart(var_2.streakname, "strafing_run_airstrike") && var_2.team != var_0) {
        return 1;
      }
    }
  }

  return 0;
}