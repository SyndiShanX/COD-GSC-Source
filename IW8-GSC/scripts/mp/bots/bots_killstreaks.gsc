/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_killstreaks.gsc
************************************************/

function bot_killstreak_setup() {
  if(!isDefined(level.killstreak_botfunc)) {
    if(!isDefined(level.killstreak_botfunc)) {
      level.killstreak_botfunc = [];
    }

    if(!isDefined(level.killstreak_botcanuse)) {
      level.killstreak_botcanuse = [];
    }

    if(!isDefined(level.killstreak_botparm)) {
      level.killstreak_botparm = [];
    }

    if(!isDefined(level.bot_supported_killstreaks)) {
      level.bot_supported_killstreaks = [];
    }

    if(istrue(game["isLaunchChunk"])) {
      return;
    }

    bot_register_killstreak_func("uav", &bot_killstreak_simple_use);
    bot_register_killstreak_func("directional_uav", &bot_killstreak_simple_use);

    if(isDefined(level.mapcustombotkillstreakfunc)) {
      [[level.mapcustombotkillstreakfunc]]();
      return;
    }

    return;
  }
}

function bot_register_killstreak_func(var_0, var_1, var_2, var_3) {
  level.killstreak_botfunc[var_0] = var_1;
  level.killstreak_botcanuse[var_0] = var_2;
  level.killstreak_botparm[var_0] = var_3;
  level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = var_0;
}

function bot_killstreak_valid_for_specific_streaktype(var_0, var_1, var_2) {
  if(bot_killstreak_is_valid_internal(var_0, "bots", undefined, var_1)) {
    return true;
  } else if(var_2) {}

  return false;
}

function bot_killstreak_is_valid_internal(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(var_0 == "specialist") {
    return true;
  }

  if(!bot_killstreak_is_valid_single(var_0, var_1)) {
    return false;
  }

  if(isDefined(var_3)) {
    var_4 = getsubstr(var_3, 11);

    switch (var_4) {
      case "assault":
        if(!scripts\mp\utility\killstreak::isassaultkillstreak(var_0)) {
          return false;
        }

        break;
      case "support":
        if(!scripts\mp\utility\killstreak::issupportkillstreak(var_0)) {
          return false;
        }

        break;
      case "specialist":
        if(!scripts\mp\utility\killstreak::isspecialistkillstreak(var_0)) {
          return false;
        }

        break;
    }
  }

  return true;
}

function bot_killstreak_is_valid_single(var_0, var_1) {
  if(var_1 == "humans") {
    return (isDefined(level.killstreaksetups[var_0]) && scripts\mp\utility\killstreak::getkillstreakindex(var_0) != -1);
  }

  if(var_1 == "bots") {
    return isDefined(level.killstreak_botfunc[var_0]);
  }
}

function bot_watch_for_killstreak_use() {
  self notify("bot_watch_for_killstreak_use");
  self endon("bot_watch_for_killstreak_use");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("killstreak_use_finished");
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon("none");
  }
}

function bot_is_killstreak_supported(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isDefined(level.killstreak_botfunc[var_0])) {
    return false;
  }

  return true;
}

function bot_can_use_killstreak(var_0) {
  var_1 = level.killstreak_botcanuse[var_0];

  if(!isDefined(var_1)) {
    return false;
  }

  if(isDefined(var_1) && !self[[var_1]]()) {
    return false;
  }

  return true;
}

function bot_think_killstreak() {}

function bot_can_use_aa_launcher() {
  return false;
}

function bot_start_aa_launcher_tracking() {}

function bot_killstreak_never_use() {}

function bot_can_use_air_superiority() {
  return false;
}

function aerial_vehicle_allowed() {
  if(scripts\mp\utility\game::isairdenied()) {
    return false;
  }

  if(vehicle_would_exceed_limit()) {
    return false;
  }

  return true;
}

function vehicle_would_exceed_limit() {
  return scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= scripts\mp\utility\killstreak::maxvehiclesallowed();
}

function bot_can_use_emp() {
  if(isDefined(level.empplayer)) {
    return false;
  }

  var_0 = scripts\mp\utility\teams::getenemyteams(self.owner.team);

  foreach(var_2 in var_0) {
    if(isDefined(level.teamemped) && !istrue(level.teamemped[var_2])) {
      return true;
    }
  }

  return false;
}

function bot_can_use_ball_drone() {
  return false;
}

function bot_killstreak_simple_use(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait randomintrange(3, 5);

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    return true;
  }

  if(isDefined(var_2) && !self[[var_2]]()) {
    return false;
  }

  bot_switch_to_killstreak_weapon(var_0, var_1, var_0.weapon);
  return true;
}

function bot_killstreak_drop_anywhere(var_0, var_1, var_2, var_3) {
  bot_killstreak_drop(var_0, var_1, var_2, var_3, "anywhere");
}

function bot_killstreak_drop_outside(var_0, var_1, var_2, var_3) {
  bot_killstreak_drop(var_0, var_1, var_2, var_3, "outside");
}

function bot_killstreak_drop_hidden(var_0, var_1, var_2, var_3) {
  bot_killstreak_drop(var_0, var_1, var_2, var_3, "hidden");
}

function bot_killstreak_drop(var_0, var_1, var_2, var_3, var_4) {
  wait randomintrange(2, 4);

  if(!isDefined(var_4)) {
    var_4 = "anywhere";
  }

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    return true;
  }

  if(isDefined(var_2) && !self[[var_2]]()) {
    return false;
  }

  var_5 = self getweaponammoclip(var_0.weapon) + self getweaponammostock(var_0.weapon);

  if(var_5 == 0) {
    foreach(var_7 in var_1) {
      if(isDefined(var_7.streakname) && var_7.streakname == var_0.streakname) {
        var_7.available = 0;
      }
    }

    return true;
  }

  var_9 = undefined;

  if(var_7 == "outside") {
    var_10 = [];
    var_11 = scripts\mp\bots\bots_util::bot_get_nodes_in_cone(0, 750, 0.6, 1);

    foreach(var_13 in var_11) {
      if(nodeexposedtosky(var_13)) {
        var_10 = scripts\engine\utility::array_add(var_10, var_13);
      }
    }

    if(var_11.size > 5 && var_10.size > var_11.size * 0.6) {
      var_15 = scripts\engine\utility::get_array_of_closest(self.origin, var_10, undefined, undefined, undefined, 150);

      if(var_15.size > 0) {
        var_9 = scripts\engine\utility::random(var_15);
      } else {
        var_9 = scripts\engine\utility::random(var_10);
      }
    }
  } else if(var_7 == "hidden") {
    var_16 = getnodesinradius(self.origin, 256, 0, 40);
    var_17 = self getnearestnode();

    if(isDefined(var_17)) {
      var_18 = [];

      foreach(var_13 in var_16) {
        if(nodesvisible(var_17, var_13, 1)) {
          var_18 = scripts\engine\utility::array_add(var_18, var_13);
        }
      }

      var_9 = self botnodepick(var_18, 1, "node_hide");
    }
  }

  if(isDefined(var_9) || var_7 == "anywhere") {
    self botsetflag("disable_movement", 1);

    if(isDefined(var_9)) {
      self botlookatpoint(var_9.origin, 2.45, "script_forced");
    }

    bot_switch_to_killstreak_weapon(var_3, var_4, var_3.weapon);
    wait 2;
    self botpressbutton("attack");
    wait 1.5;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon("none");
    self botsetflag("disable_movement", 0);
  }

  return true;
}

function bot_switch_to_killstreak_weapon(var_0, var_1, var_2) {
  bot_notify_streak_used(var_0, var_1);
}

function bot_notify_streak_used(var_0, var_1) {
  if(isDefined(var_0.isgimme) && var_0.isgimme) {
    self notify("ks_action_6");
    return;
  }

  var_2 = 1;

  while(var_2 < 4) {
    if(isDefined(var_1[var_2])) {
      if(isDefined(var_1[var_2].streakname)) {
        if(var_1[var_2].streakname == var_0.streakname) {
          var_3 = var_2 + 2;
          self notify("ks_action_" + var_3);
          return;
        }
      }
    }

    var_3++;
  }
}

function bot_killstreak_choose_loc_enemies(var_0, var_1, var_2, var_3) {
  wait randomintrange(3, 5);

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    return;
  }

  var_4 = getzonenearest(self.origin);

  if(!isDefined(var_4)) {
    return;
  }

  self botsetflag("disable_movement", 1);
  bot_switch_to_killstreak_weapon(var_0, var_1, var_0.weapon);
  wait 2;
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

      var_8 = scripts\engine\utility::array_add(var_8, var_11);
    }
  }

  if(var_6 >= 0) {
    var_13 = getzoneorigin(var_6);
  } else if(var_9.size > 0) {
    var_13 = getzoneorigin(scripts\engine\utility::random(var_9));
  } else {
    var_13 = getzoneorigin(randomint(level.zonecount));
  }

  var_14 = (randomfloatrange(-500, 500), randomfloatrange(-500, 500), 0);
  self notify("confirm_location", var_13 + var_14, randomintrange(0, 360));
  wait 1;
  self botsetflag("disable_movement", 0);
}

function bot_think_watch_aerial_killstreak() {
  self notify("bot_think_watch_aerial_killstreak");
  self endon("bot_think_watch_aerial_killstreak");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(level.last_global_badplace_time)) {
    level.last_global_badplace_time = -10000;
  }

  level.killstreak_global_bp_exists_for["allies"] = [];
  level.killstreak_global_bp_exists_for["axis"] = [];
  var_0 = 0;
  var_1 = randomfloatrange(0.05, 4);

  for(;;) {
    wait var_1;
    var_1 = randomfloatrange(0.05, 4);

    if(scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      continue;
    }

    if(self botgetdifficultysetting("strategyLevel") == 0) {
      continue;
    }

    var_2 = 0;

    if(isDefined(level.chopper) && level.chopper.team != self.team) {
      var_2 = 1;
    }

    if(isDefined(level.lbsniper) && level.lbsniper.team != self.team) {
      var_2 = 1;
    }

    if(enemy_mortar_strike_exists(self.team)) {
      var_2 = 1;
      try_place_global_badplace("mortar_strike", &enemy_mortar_strike_exists);
    }

    if(enemy_switchblade_exists(self.team)) {
      var_2 = 1;
      try_place_global_badplace("switchblade", &enemy_switchblade_exists);
    }

    if(enemy_odin_assault_exists(self.team)) {
      var_2 = 1;
      try_place_global_badplace("odin_assault", &enemy_odin_assault_exists);
    }

    var_3 = get_enemy_vanguard();

    if(isDefined(var_3)) {
      var_4 = self getEye();

      if(scripts\engine\utility::within_fov(var_4, self getplayerangles(), var_3.attackarrow.origin, self botgetfovdot())) {
        if(sighttracepassed(var_4, var_3.attackarrow.origin, 0, self, var_3.attackarrow)) {
          badplace_cylinder("vanguard_" + var_3 getentitynumber(), var_1 + 0.5, var_3.attackarrow.origin, 200, 100, self.team);
        }
      }
    }

    if(!var_0 && var_2) {
      var_0 = 1;
      self botsetflag("hide_indoors", 1);
    }

    if(var_0 && !var_2) {
      var_0 = 0;
      self botsetflag("hide_indoors", 0);
    }
  }
}

function try_place_global_badplace(var_0, var_1) {
  if(!isDefined(level.killstreak_global_bp_exists_for[self.team][var_0])) {
    level.killstreak_global_bp_exists_for[self.team][var_0] = 0;
  }

  if(!level.killstreak_global_bp_exists_for[self.team][var_0]) {
    level.killstreak_global_bp_exists_for[self.team][var_0] = 1;
    thread monitor_enemy_dangerous_killstreak(level, self.team, var_0);
    return;
  }
}

function monitor_enemy_dangerous_killstreak(var_0, var_1, var_2) {
  var_3 = 0.5;

  while([[var_2]](var_0)) {
    if(gettime() > level.last_global_badplace_time + 4000) {
      badplace_global("", 5, var_0, "only_sky");
      level.last_global_badplace_time = gettime();
    }

    wait var_3;
  }

  level.killstreak_global_bp_exists_for[var_0][var_1] = 0;
}

function enemy_mortar_strike_exists(var_0) {
  if(isDefined(level.air_raid_active) && level.air_raid_active) {
    if(var_0 != level.air_raid_team_called) {
      return true;
    }
  }

  return false;
}

function enemy_switchblade_exists(var_0) {
  if(isDefined(level.remotemissileinprogress)) {
    foreach(var_2 in level.rockets) {
      if(isDefined(var_2.type) && var_2.type == "remote" && var_2.team != var_0) {
        return true;
      }
    }
  }

  return false;
}

function enemy_odin_assault_exists(var_0) {
  foreach(var_2 in level.players) {
    if(!level.teambased || isDefined(var_2.team) && var_0 != var_2.team) {
      if(isDefined(var_2.odin) && var_2.odin.odintype == "odin_assault" && gettime() - var_2.odin.birthtime > 3000) {
        return true;
      }
    }
  }

  return false;
}

function get_enemy_vanguard() {
  foreach(var_1 in level.players) {
    if(!level.teambased || isDefined(var_1.team) && self.team != var_1.team) {
      if(isDefined(var_1.remoteuav) && var_1.remoteuav.helitype == "remote_uav") {
        return var_1.remoteuav;
      }
    }
  }

  return undefined;
}

function iskillstreakblockedforbots(var_0) {
  return isDefined(level.botblockedkillstreaks) && isDefined(level.botblockedkillstreaks[var_0]) && level.botblockedkillstreaks[var_0];
}

function blockkillstreakforbots(var_0) {
  level.botblockedkillstreaks[var_0] = 1;
}