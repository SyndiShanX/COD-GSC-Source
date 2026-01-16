/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_ks.gsc
********************************/

bot_killstreak_setup() {
  var_0 = gettime();

  if(!isdefined(level.killstreak_botfunc)) {
    bot_register_killstreak_func("radar_mp", ::bot_killstreak_simple_use, ::bot_can_use_uav);
    bot_register_killstreak_func("airstrike_mp", ::bot_killstreak_choose_loc_enemies, ::bot_can_use_airstrike);
    bot_register_killstreak_func("helicopter_mp", ::bot_killstreak_simple_use, ::bot_can_use_helicopter);
  }
}

bot_register_killstreak_func(var_0, var_1, var_2, var_3) {
  if(!isdefined(level.killstreak_botfunc))
    level.killstreak_botfunc = [];

  level.killstreak_botfunc[var_0] = var_1;

  if(!isdefined(level.killstreak_botcanuse))
    level.killstreak_botcanuse = [];

  level.killstreak_botcanuse[var_0] = var_2;

  if(!isdefined(level.killstreak_botparm))
    level.killstreak_botparm = [];

  level.killstreak_botparm[var_0] = var_3;

  if(!isdefined(level.bot_supported_killstreaks))
    level.bot_supported_killstreaks = [];

  level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = var_0;
}

bot_think_killstreak() {
  self notify("bot_think_killstreak");
  self endon("bot_think_killstreak");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while (!isdefined(level.killstreak_botfunc))
    wait 0.05;

  for (;;) {
    wait(randomfloatrange(2.0, 4.0));

    if(maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
      var_0 = self.pers["hardPointItem"];

      if(isdefined(var_0)) {
        if(isdefined(self.bot_killstreak_wait) && isdefined(self.bot_killstreak_wait[var_0]) && gettime() < self.bot_killstreak_wait[var_0]) {
          continue;
        }
        var_1 = level.killstreak_botcanuse[var_0];

        if(isdefined(var_1) && !self[[var_1]](var_0)) {
          continue;
        }
        var_2 = level.killstreak_botfunc[var_0];

        if(isdefined(var_2)) {
          var_3 = self[[var_2]](var_0, var_1);

          if(!isdefined(var_3) || var_3 == 0) {
            if(!isdefined(self.bot_killstreak_wait))
              self.bot_killstreak_wait = [];

            self.bot_killstreak_wait[var_0] = gettime() + 5000;
          }
        } else {

        }
      }
    }
  }
}

bot_killstreak_never_use() {}

bot_killstreak_do_not_use(var_0) {
  return 0;
}

bot_can_use_uav(var_0) {
  if(!maps\mp\gametypes\_hardpoints::playerhasuavactive())
    return 1;

  return 0;
}

bot_can_use_airstrike(var_0) {
  if(isdefined(level.airstrikeinprogress))
    return 0;

  return 1;
}

bot_can_use_helicopter(var_0) {
  if(isdefined(level.chopper))
    return 0;

  return 1;
}

bot_killstreak_simple_use(var_0, var_1) {
  wait(randomintrange(3, 5));

  if(!maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks())
    return 1;

  if(isdefined(var_1) && !self[[var_1]](var_0))
    return 0;

  bot_switch_to_killstreak_weapon(var_0);
  return 1;
}

bot_switch_to_killstreak_weapon(var_0) {
  self switchtoweapon(var_0);
}

bot_killstreak_get_zone_enemies() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!isalliedsentient(self, var_2) && isalive(var_2))
      var_0[var_0.size] = var_2;
  }

  var_4 = [];

  for (var_5 = 0; var_5 < level.zonecount; var_5++)
    var_4[var_5] = [];

  foreach(var_7 in var_0) {
    var_8 = var_7 getnearestnode();

    if(!isdefined(var_8)) {
      var_9 = getnodesinradiussorted(var_7.origin, 256, 0);

      if(var_9.size > 0)
        var_8 = var_9[0];
    }

    if(isdefined(var_8)) {
      var_10 = getnodezone(var_8);
      var_4[var_10] = common_scripts\utility::array_add(var_4[var_10], var_7);
    }
  }

  return var_4;
}

bot_killstreak_choose_loc_enemies(var_0, var_1) {
  wait(randomintrange(3, 5));

  if(!maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
    return;
  }
  var_2 = getzonenearest(self.origin);

  if(!isdefined(var_2)) {
    return;
  }
  if(isdefined(var_1) && !self[[var_1]](var_0))
    return 0;

  self botsetflag("disable_movement", 1);
  bot_switch_to_killstreak_weapon(var_0);
  wait 2.0;

  if(!isdefined(self.selectinglocation)) {
    self botsetflag("disable_movement", 0);
    return;
  }

  var_3 = abs(level.bot_map_center[0] - level.bot_map_min_x);
  var_4 = abs(level.bot_map_center[0] - level.bot_map_max_x);
  var_5 = abs(level.bot_map_center[1] - level.bot_map_min_y);
  var_6 = abs(level.bot_map_center[1] - level.bot_map_max_y);
  var_7 = (var_3 + var_4 + var_5 + var_6) / 4.0;
  var_8 = bot_killstreak_get_zone_enemies();
  var_9 = [];
  var_10 = [];

  for (var_11 = 0; var_11 < level.zonecount; var_11++) {
    if(var_11 != var_2 && botzonegetindoorpercent(var_11) < 0.25) {
      var_12 = spawnstruct();
      var_12.zonenum = var_11;
      var_12.disttomapcenter = distance(level.bot_map_center, getzoneorigin(var_11));
      var_13 = [];
      var_14 = var_8[var_11];

      foreach(var_16 in var_14) {
        if(maps\mp\gametypes\_hardpoints::playerhasuavactive()) {
          var_13[var_13.size] = var_16;
          continue;
        }

        if(isdefined(var_16.lastshotfiredtime) && gettime() - var_16.lastshotfiredtime < 1500) {
          if(!isweaponsilenced(var_16 getcurrentweapon()))
            var_13[var_13.size] = var_16;
        }
      }

      var_12.enemieslist = var_13;

      if(var_13.size > 0)
        var_9[var_9.size] = var_12;

      var_10[var_10.size] = var_12;
    }
  }

  foreach(var_19 in var_10) {
    var_20 = var_19.enemieslist.size * 100;
    var_21 = clamp(1.0 - var_19.disttomapcenter / var_7, 0.0, 1.0);
    var_20 = var_20 + var_21 * 100;
    var_19.weight = var_20;
  }

  var_23 = var_9;

  if(var_23.size == 0)
    var_23 = var_10;

  var_24 = 0;

  foreach(var_19 in var_23)
  var_24 = var_24 + var_19.weight;

  if(var_24 > 0) {
    var_27 = randomfloat(var_24);
    var_28 = undefined;

    for (var_29 = 0; var_27 >= 0; var_29++) {
      var_28 = var_23[var_29];
      var_27 = var_27 - var_28.weight;
    }

    var_14 = var_28.enemieslist;
    var_30 = getzoneorigin(var_28.zonenum);

    foreach(var_16 in var_14)
    var_30 = var_30 + var_16.origin;

    var_30 = var_30 / (var_14.size + 1);
    var_33 = undefined;
    var_34 = getnodesinradiussorted(var_30, 256, 0);

    if(var_34.size > 0) {
      var_33 = self botnodepick(var_34, var_34.size * 0.25, "node_traffic");
      var_35 = var_34[0].origin;
    }

    if(isdefined(var_33))
      var_35 = var_33.origin;
    else
      var_35 = var_30;
  } else
    var_35 = getzoneorigin(randomint(level.zonecount));

  self notify("confirm_location", var_35);
  self waittill("stop_location_selection");
  wait 1.0;
  self botsetflag("disable_movement", 0);
}

bot_think_watch_aerial_killstreak() {
  self notify("bot_think_watch_aerial_killstreak");
  self endon("bot_think_watch_aerial_killstreak");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isdefined(level.last_global_badplace_time))
    level.last_global_badplace_time = -10000;

  if(!isdefined(level.killstreak_global_bp_exists_for)) {
    level.killstreak_global_bp_exists_for["allies"] = [];
    level.killstreak_global_bp_exists_for["axis"] = [];
  }

  if(!isdefined(level.aerial_danger_exists_for)) {
    level.aerial_danger_exists_for["allies"] = 0;
    level.aerial_danger_exists_for["axis"] = 0;
  }

  var_0 = 0;
  var_1 = randomfloatrange(0.05, 4.0);

  for (;;) {
    wait(var_1);
    var_1 = randomfloatrange(0.05, 4.0);

    if(maps\mp\bots\_bots_util::bot_is_remote_or_linked()) {
      continue;
    }
    if(self botgetdifficultysetting("strategyLevel") == 0) {
      continue;
    }
    var_2 = 0;
    var_3 = get_enemy_helicopter(self.team);

    if(isdefined(var_3)) {
      var_2 = 1;

      if(!bot_is_monitoring_aerial_danger(var_3))
        childthread monitor_aerial_danger(var_3);
    }

    if(enemy_airstrike_exists(self.team)) {
      if(level.teambased)
        try_place_global_badplace("airstrike", ::enemy_airstrike_exists);

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
  if(!isdefined(self.aerial_dangers_monitoring))
    return 0;

  return common_scripts\utility::array_contains(self.aerial_dangers_monitoring, var_0);
}

monitor_aerial_danger(var_0) {
  if(!isdefined(self.aerial_dangers_monitoring))
    self.aerial_dangers_monitoring = [];

  self.aerial_dangers_monitoring[self.aerial_dangers_monitoring.size] = var_0;
  var_1 = vectornormalize((var_0.origin - self.origin) * (1, 1, 0));

  while (isalive(var_0)) {
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
  if(!isdefined(level.killstreak_global_bp_exists_for[self.team][var_0]))
    level.killstreak_global_bp_exists_for[self.team][var_0] = 0;

  if(!level.killstreak_global_bp_exists_for[self.team][var_0]) {
    level.killstreak_global_bp_exists_for[self.team][var_0] = 1;
    level thread monitor_enemy_dangerous_killstreak(self.team, var_0, var_1);
  }
}

monitor_enemy_dangerous_killstreak(var_0, var_1, var_2) {
  var_3 = 0.5;

  while ([
      [var_2]
    ](var_0)) {
    if(gettime() > level.last_global_badplace_time + 4000) {
      badplace_global("", 5.0, var_0, "only_sky");
      level.last_global_badplace_time = gettime();
    }

    wait(var_3);
  }

  level.killstreak_global_bp_exists_for[var_0][var_1] = 0;
}

get_enemy_helicopter(var_0) {
  if(isdefined(level.chopper)) {
    if(level.teambased) {
      if(level.chopper.team != var_0)
        return level.chopper;
    } else if(level.chopper.owner != self)
      return level.chopper;
  }

  return undefined;
}

enemy_airstrike_exists(var_0) {
  if(isdefined(level.artillerydangercenters)) {
    foreach(var_2 in level.artillerydangercenters) {
      if(level.teambased) {
        if(var_2.team != var_0)
          return 1;
      } else
        return 1;
    }
  }

  return 0;
}