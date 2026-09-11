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

function bot_register_killstreak_func(var0, var1, var2, var3) {
  level.killstreak_botfunc[var0] = var1;
  level.killstreak_botcanuse[var0] = var2;
  level.killstreak_botparm[var0] = var3;
  level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = var0;
}

function bot_killstreak_valid_for_specific_streaktype(var0, var1, var2) {
  if(bot_killstreak_is_valid_internal(var0, "bots", undefined, var1)) {
    return true;
  } else if(var2) {}

  return false;
}

function bot_killstreak_is_valid_internal(var0, var1, var2, var3) {
  var4 = undefined;

  if(var0 == "specialist") {
    return true;
  }

  if(!bot_killstreak_is_valid_single(var0, var1)) {
    return false;
  }

  if(isDefined(var3)) {
    var4 = getsubstr(var3, 11);

    switch (var4) {
      case "assault":
        if(!scripts\mp\utility\killstreak::isassaultkillstreak(var0)) {
          return false;
        }

        break;
      case "support":
        if(!scripts\mp\utility\killstreak::issupportkillstreak(var0)) {
          return false;
        }

        break;
      case "specialist":
        if(!scripts\mp\utility\killstreak::isspecialistkillstreak(var0)) {
          return false;
        }

        break;
    }
  }

  return true;
}

function bot_killstreak_is_valid_single(var0, var1) {
  if(var1 == "humans") {
    return (isDefined(level.killstreaksetups[var0]) && scripts\mp\utility\killstreak::getkillstreakindex(var0) != -1);
  }

  if(var1 == "bots") {
    return isDefined(level.killstreak_botfunc[var0]);
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

function bot_is_killstreak_supported(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!isDefined(level.killstreak_botfunc[var0])) {
    return false;
  }

  return true;
}

function bot_can_use_killstreak(var0) {
  var1 = level.killstreak_botcanuse[var0];

  if(!isDefined(var1)) {
    return false;
  }

  if(isDefined(var1) && !self[[var1]]()) {
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

  var0 = scripts\mp\utility\teams::getenemyteams(self.owner.team);

  foreach(var2 in var0) {
    if(isDefined(level.teamemped) && !istrue(level.teamemped[var2])) {
      return true;
    }
  }

  return false;
}

function bot_can_use_ball_drone() {
  return false;
}

function bot_killstreak_simple_use(var0, var1, var2, var3) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait randomintrange(3, 5);

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    return true;
  }

  if(isDefined(var2) && !self[[var2]]()) {
    return false;
  }

  bot_switch_to_killstreak_weapon(var0, var1, var0.weapon);
  return true;
}

function bot_killstreak_drop_anywhere(var0, var1, var2, var3) {
  bot_killstreak_drop(var0, var1, var2, var3, "anywhere");
}

function bot_killstreak_drop_outside(var0, var1, var2, var3) {
  bot_killstreak_drop(var0, var1, var2, var3, "outside");
}

function bot_killstreak_drop_hidden(var0, var1, var2, var3) {
  bot_killstreak_drop(var0, var1, var2, var3, "hidden");
}

function bot_killstreak_drop(var0, var1, var2, var3, var4) {
  wait randomintrange(2, 4);

  if(!isDefined(var4)) {
    var4 = "anywhere";
  }

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    return true;
  }

  if(isDefined(var2) && !self[[var2]]()) {
    return false;
  }

  var5 = self getweaponammoclip(var0.weapon) + self getweaponammostock(var0.weapon);

  if(var5 == 0) {
    foreach(var7 in var1) {
      if(isDefined(var7.streakname) && var7.streakname == var0.streakname) {
        var7.available = 0;
      }
    }

    return true;
  }

  var9 = undefined;

  if(var7 == "outside") {
    var10 = [];
    var11 = scripts\mp\bots\bots_util::bot_get_nodes_in_cone(0, 750, 0.6, 1);

    foreach(var13 in var11) {
      if(nodeexposedtosky(var13)) {
        var10 = scripts\engine\utility::array_add(var10, var13);
      }
    }

    if(var11.size > 5 && var10.size > var11.size * 0.6) {
      var15 = scripts\engine\utility::get_array_of_closest(self.origin, var10, undefined, undefined, undefined, 150);

      if(var15.size > 0) {
        var9 = scripts\engine\utility::random(var15);
      } else {
        var9 = scripts\engine\utility::random(var10);
      }
    }
  } else if(var7 == "hidden") {
    var16 = getnodesinradius(self.origin, 256, 0, 40);
    var17 = self getnearestnode();

    if(isDefined(var17)) {
      var18 = [];

      foreach(var13 in var16) {
        if(nodesvisible(var17, var13, 1)) {
          var18 = scripts\engine\utility::array_add(var18, var13);
        }
      }

      var9 = self botnodepick(var18, 1, "node_hide");
    }
  }

  if(isDefined(var9) || var7 == "anywhere") {
    self botsetflag("disable_movement", 1);

    if(isDefined(var9)) {
      self botlookatpoint(var9.origin, 2.45, "script_forced");
    }

    bot_switch_to_killstreak_weapon(var3, var4, var3.weapon);
    wait 2;
    self botpressbutton("attack");
    wait 1.5;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon("none");
    self botsetflag("disable_movement", 0);
  }

  return true;
}

function bot_switch_to_killstreak_weapon(var0, var1, var2) {
  bot_notify_streak_used(var0, var1);
}

function bot_notify_streak_used(var0, var1) {
  if(isDefined(var0.isgimme) && var0.isgimme) {
    self notify("ks_action_6");
    return;
  }

  var2 = 1;

  while(var2 < 4) {
    if(isDefined(var1[var2])) {
      if(isDefined(var1[var2].streakname)) {
        if(var1[var2].streakname == var0.streakname) {
          var3 = var2 + 2;
          self notify("ks_action_" + var3);
          return;
        }
      }
    }

    var3++;
  }
}

function bot_killstreak_choose_loc_enemies(var0, var1, var2, var3) {
  wait randomintrange(3, 5);

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    return;
  }

  var4 = getzonenearest(self.origin);

  if(!isDefined(var4)) {
    return;
  }

  self botsetflag("disable_movement", 1);
  bot_switch_to_killstreak_weapon(var0, var1, var0.weapon);
  wait 2;
  var5 = level.zonecount;
  var6 = -1;
  var7 = 0;
  var8 = [];
  var9 = randomfloat(100) > 50;

  for(var10 = 0; var10 < var5; var10++) {
    if(var9) {
      var11 = var5 - 1 - var10;
    } else {
      var11 = var10;
    }

    if(var11 != var4 && botzonegetindoorpercent(var11) < 0.25) {
      var12 = botzonegetcount(var11, self.team, "enemy_predict");

      if(var12 > var7) {
        var6 = var11;
        var7 = var12;
      }

      var8 = scripts\engine\utility::array_add(var8, var11);
    }
  }

  if(var6 >= 0) {
    var13 = getzoneorigin(var6);
  } else if(var9.size > 0) {
    var13 = getzoneorigin(scripts\engine\utility::random(var9));
  } else {
    var13 = getzoneorigin(randomint(level.zonecount));
  }

  var14 = (randomfloatrange(-500, 500), randomfloatrange(-500, 500), 0);
  self notify("confirm_location", var13 + var14, randomintrange(0, 360));
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
  var0 = 0;
  var1 = randomfloatrange(0.05, 4);

  for(;;) {
    wait var1;
    var1 = randomfloatrange(0.05, 4);

    if(scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
      continue;
    }

    if(self botgetdifficultysetting("strategyLevel") == 0) {
      continue;
    }

    var2 = 0;

    if(isDefined(level.chopper) && level.chopper.team != self.team) {
      var2 = 1;
    }

    if(isDefined(level.lbsniper) && level.lbsniper.team != self.team) {
      var2 = 1;
    }

    if(enemy_mortar_strike_exists(self.team)) {
      var2 = 1;
      try_place_global_badplace("mortar_strike", &enemy_mortar_strike_exists);
    }

    if(enemy_switchblade_exists(self.team)) {
      var2 = 1;
      try_place_global_badplace("switchblade", &enemy_switchblade_exists);
    }

    if(enemy_odin_assault_exists(self.team)) {
      var2 = 1;
      try_place_global_badplace("odin_assault", &enemy_odin_assault_exists);
    }

    var3 = get_enemy_vanguard();

    if(isDefined(var3)) {
      var4 = self getEye();

      if(scripts\engine\utility::within_fov(var4, self getplayerangles(), var3.attackarrow.origin, self botgetfovdot())) {
        if(sighttracepassed(var4, var3.attackarrow.origin, 0, self, var3.attackarrow)) {
          badplace_cylinder("vanguard_" + var3 getentitynumber(), var1 + 0.5, var3.attackarrow.origin, 200, 100, self.team);
        }
      }
    }

    if(!var0 && var2) {
      var0 = 1;
      self botsetflag("hide_indoors", 1);
    }

    if(var0 && !var2) {
      var0 = 0;
      self botsetflag("hide_indoors", 0);
    }
  }
}

function try_place_global_badplace(var0, var1) {
  if(!isDefined(level.killstreak_global_bp_exists_for[self.team][var0])) {
    level.killstreak_global_bp_exists_for[self.team][var0] = 0;
  }

  if(!level.killstreak_global_bp_exists_for[self.team][var0]) {
    level.killstreak_global_bp_exists_for[self.team][var0] = 1;
    thread monitor_enemy_dangerous_killstreak(level, self.team, var0);
    return;
  }
}

function monitor_enemy_dangerous_killstreak(var0, var1, var2) {
  var3 = 0.5;

  while([[var2]](var0)) {
    if(gettime() > level.last_global_badplace_time + 4000) {
      badplace_global("", 5, var0, "only_sky");
      level.last_global_badplace_time = gettime();
    }

    wait var3;
  }

  level.killstreak_global_bp_exists_for[var0][var1] = 0;
}

function enemy_mortar_strike_exists(var0) {
  if(isDefined(level.air_raid_active) && level.air_raid_active) {
    if(var0 != level.air_raid_team_called) {
      return true;
    }
  }

  return false;
}

function enemy_switchblade_exists(var0) {
  if(isDefined(level.remotemissileinprogress)) {
    foreach(var2 in level.rockets) {
      if(isDefined(var2.type) && var2.type == "remote" && var2.team != var0) {
        return true;
      }
    }
  }

  return false;
}

function enemy_odin_assault_exists(var0) {
  foreach(var2 in level.players) {
    if(!level.teambased || isDefined(var2.team) && var0 != var2.team) {
      if(isDefined(var2.odin) && var2.odin.odintype == "odin_assault" && gettime() - var2.odin.birthtime > 3000) {
        return true;
      }
    }
  }

  return false;
}

function get_enemy_vanguard() {
  foreach(var1 in level.players) {
    if(!level.teambased || isDefined(var1.team) && self.team != var1.team) {
      if(isDefined(var1.remoteuav) && var1.remoteuav.helitype == "remote_uav") {
        return var1.remoteuav;
      }
    }
  }

  return undefined;
}

function iskillstreakblockedforbots(var0) {
  return isDefined(level.botblockedkillstreaks) && isDefined(level.botblockedkillstreaks[var0]) && level.botblockedkillstreaks[var0];
}

function blockkillstreakforbots(var0) {
  level.botblockedkillstreaks[var0] = 1;
}