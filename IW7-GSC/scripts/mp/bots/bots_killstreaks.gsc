/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_killstreaks.gsc
************************************************/

bot_killstreak_setup() {
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

    bot_register_killstreak_func("nuke", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("ball_drone_backup", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("jackal", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("uav", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("counter_uav", ::bot_killstreak_simple_use);
    bot_register_killstreak_func("jammer", ::bot_killstreak_simple_use, ::func_2D28);
    bot_register_killstreak_func("directional_uav", ::bot_killstreak_simple_use);
    if(isDefined(level.mapcustombotkillstreakfunc)) {
      [
        [level.mapcustombotkillstreakfunc]
      ]();
    }
  }

  thread scripts\mp\bots\_bots_killstreaks_remote_vehicle::remote_vehicle_setup();
}

bot_register_killstreak_func(var_0, var_1, var_2, var_3) {
  level.killstreak_botfunc[var_0] = var_1;
  level.killstreak_botcanuse[var_0] = var_2;
  level.killstreak_botparm[var_0] = var_3;
  level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = var_0;
}

bot_killstreak_valid_for_specific_streaktype(var_0, var_1, var_2) {
  if(scripts\mp\utility::bot_is_fireteam_mode()) {
    return 1;
  }

  if(bot_killstreak_is_valid_internal(var_0, "bots", undefined, var_1)) {
    return 1;
  } else if(var_2) {}

  return 0;
}

bot_killstreak_is_valid_internal(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  if(var_0 == "specialist") {
    return 1;
  }

  if(!bot_killstreak_is_valid_single(var_0, var_1)) {
    return 0;
  }

  if(isDefined(var_3)) {
    var_4 = getsubstr(var_3, 11);
    switch (var_4) {
      case "assault":
        if(!scripts\mp\utility::isassaultkillstreak(var_0)) {
          return 0;
        }
        break;

      case "support":
        if(!scripts\mp\utility::issupportkillstreak(var_0)) {
          return 0;
        }
        break;

      case "specialist":
        if(!scripts\mp\utility::isspecialistkillstreak(var_0)) {
          return 0;
        }
        break;
    }
  }

  return 1;
}

bot_killstreak_is_valid_single(var_0, var_1) {
  if(var_1 == "humans") {
    return isDefined(level.killstreaksetups[var_0]) && scripts\mp\utility::getkillstreakindex(var_0) != -1;
  } else if(var_1 == "bots") {
    return isDefined(level.killstreak_botfunc[var_0]);
  }
}

bot_watch_for_killstreak_use() {
  self notify("bot_watch_for_killstreak_use");
  self endon("bot_watch_for_killstreak_use");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("killstreak_use_finished");
    scripts\mp\utility::_switchtoweapon("none");
  }
}

bot_is_killstreak_supported(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(level.killstreak_botfunc[var_0])) {
    return 0;
  }

  return 1;
}

func_2D29(var_0) {
  var_1 = level.killstreak_botcanuse[var_0];
  if(!isDefined(var_1)) {
    return 0;
  }

  if(isDefined(var_1) && !self[[var_1]]()) {
    return 0;
  }

  return 1;
}

bot_think_killstreak() {
  self notify("bot_think_killstreak");
  self endon("bot_think_killstreak");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  while(!isDefined(level.killstreak_botfunc)) {
    wait(0.05);
  }

  childthread bot_start_aa_launcher_tracking();
  childthread bot_watch_for_killstreak_use();
  for(;;) {
    if(scripts\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
      var_0 = self.pers["killstreaks"];
      if(isDefined(var_0)) {
        foreach(var_2 in var_0) {
          if(!isDefined(var_2)) {
            continue;
          }

          if(isDefined(var_2.streakname) && isDefined(self.bot_killstreak_wait) && isDefined(self.bot_killstreak_wait[var_2.streakname]) && gettime() < self.bot_killstreak_wait[var_2.streakname]) {
            continue;
          }

          if(var_2.var_269A) {
            var_3 = var_2.streakname;
            if(var_2.streakname == "all_perks_bonus") {
              continue;
            }

            if(scripts\mp\utility::isspecialistkillstreak(var_2.streakname)) {
              if(!var_2.var_9E0B) {
                var_3 = "specialist";
              } else {
                continue;
              }
            }

            var_2.var_394 = scripts\mp\utility::getkillstreakweapon(var_2.streakname);
            var_4 = level.killstreak_botcanuse[var_3];
            if(isDefined(var_4) && !self[[var_4]]()) {
              continue;
            }

            if(!scripts\mp\utility::validateusestreak(var_2.streakname, 1)) {
              continue;
            }

            var_5 = level.killstreak_botfunc[var_3];
            if(isDefined(var_5)) {
              var_6 = self[[var_5]](var_2, var_0, var_4, level.killstreak_botparm[var_2.streakname]);
              if(!isDefined(var_6) || var_6 == 0) {
                if(!isDefined(self.bot_killstreak_wait)) {
                  self.bot_killstreak_wait = [];
                }

                self.bot_killstreak_wait[var_2.streakname] = gettime() + 5000;
              }
            } else {
              if(level.gametype != "grnd") {}

              var_2.var_269A = 0;
            }

            break;
          }
        }
      }
    }

    wait(randomfloatrange(1, 2));
  }
}

bot_can_use_aa_launcher() {
  return 0;
}

bot_start_aa_launcher_tracking() {
  var_0 = scripts\mp\killstreaks\_aalauncher::getaalaunchername();
  for(;;) {
    self waittill("aa_launcher_fire");
    var_1 = self getrunningforwardpainanim(var_0);
    if(var_1 == 0) {
      scripts\mp\utility::_switchtoweapon(var_0);
      var_2 = scripts\engine\utility::waittill_any_return("LGM_player_allMissilesDestroyed", "enemy");
      wait(0.5);
      scripts\mp\utility::_switchtoweapon("none");
    }
  }
}

bot_killstreak_never_use() {}

bot_can_use_air_superiority() {
  if(!aerial_vehicle_allowed()) {
    return 0;
  }

  var_0 = scripts\mp\killstreaks\_air_superiority::func_6CAA(self, self.team);
  var_1 = gettime();
  foreach(var_3 in var_0) {
    if(var_1 - var_3.var_64 > 5000) {
      return 1;
    }
  }

  return 0;
}

aerial_vehicle_allowed() {
  if(scripts\mp\utility::isairdenied()) {
    return 0;
  }

  if(vehicle_would_exceed_limit()) {
    return 0;
  }

  return 1;
}

vehicle_would_exceed_limit() {
  return scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= scripts\mp\utility::maxvehiclesallowed();
}

func_2D28() {
  if(isDefined(level.empplayer)) {
    return 0;
  }

  var_0 = level.otherteam[self.team];
  if(isDefined(level.teamemped) && isDefined(level.teamemped[var_0]) && level.teamemped[var_0]) {
    return 0;
  }

  return 1;
}

bot_can_use_ball_drone() {
  if(scripts\mp\utility::isusingremote()) {
    return 0;
  }

  if(scripts\mp\killstreaks\_ball_drone::exceededmaxballdrones()) {
    return 0;
  }

  if(vehicle_would_exceed_limit()) {
    return 0;
  }

  if(isDefined(self.balldrone)) {
    return 0;
  }

  return 1;
}

bot_killstreak_simple_use(var_0, var_1, var_2, var_3) {
  self endon("commander_took_over");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(randomintrange(3, 5));
  if(!scripts\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
    return 1;
  }

  if(isDefined(var_2) && !self[[var_2]]()) {
    return 0;
  }

  bot_switch_to_killstreak_weapon(var_0, var_1, var_0.var_394);
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
  self endon("commander_took_over");
  wait(randomintrange(2, 4));
  if(!isDefined(var_4)) {
    var_4 = "anywhere";
  }

  if(!scripts\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
    return 1;
  }

  if(isDefined(var_2) && !self[[var_2]]()) {
    return 0;
  }

  var_5 = self getweaponammoclip(var_0.var_394) + self getweaponammostock(var_0.var_394);
  if(var_5 == 0) {
    foreach(var_7 in var_1) {
      if(isDefined(var_7.streakname) && var_7.streakname == var_0.streakname) {
        var_7.var_269A = 0;
      }
    }

    return 1;
  }

  var_9 = undefined;
  if(var_7 == "outside") {
    var_0A = [];
    var_0B = scripts\mp\bots\_bots_util::bot_get_nodes_in_cone(750, 0.6, 1);
    foreach(var_0D in var_0B) {
      if(nodeexposedtosky(var_0D)) {
        var_0A = scripts\engine\utility::array_add(var_0A, var_0D);
      }
    }

    if(var_0B.size > 5 && var_0A.size > var_0B.size * 0.6) {
      var_0F = scripts\engine\utility::get_array_of_closest(self.origin, var_0A, undefined, undefined, undefined, 150);
      if(var_0F.size > 0) {
        var_9 = scripts\engine\utility::random(var_0F);
      } else {
        var_9 = scripts\engine\utility::random(var_0A);
      }
    }
  } else if(var_7 == "hidden") {
    var_10 = getnodesinradius(self.origin, 256, 0, 40);
    var_11 = self getnearestnode();
    if(isDefined(var_11)) {
      var_12 = [];
      foreach(var_0D in var_10) {
        if(nodesvisible(var_11, var_0D, 1)) {
          var_12 = scripts\engine\utility::array_add(var_12, var_0D);
        }
      }

      var_9 = self botnodepick(var_12, 1, "node_hide");
    }
  }

  if(isDefined(var_9) || var_7 == "anywhere") {
    self botsetflag("disable_movement", 1);
    if(isDefined(var_9)) {
      self botlookatpoint(var_9.origin, 2.45, "script_forced");
    }

    bot_switch_to_killstreak_weapon(var_3, var_4, var_3.var_394);
    wait(2);
    self botpressbutton("attack");
    wait(1.5);
    scripts\mp\utility::_switchtoweapon("none");
    self botsetflag("disable_movement", 0);
  }

  return 1;
}

bot_switch_to_killstreak_weapon(var_0, var_1, var_2) {
  func_2E29(var_0, var_1);
}

func_2E29(var_0, var_1) {
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

bot_killstreak_choose_loc_enemies(var_0, var_1, var_2, var_3) {
  self endon("commander_took_over");
  wait(randomintrange(3, 5));
  if(!scripts\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
    return;
  }

  var_4 = getzonenearest(self.origin);
  if(!isDefined(var_4)) {
    return;
  }

  self botsetflag("disable_movement", 1);
  bot_switch_to_killstreak_weapon(var_0, var_1, var_0.var_394);
  wait(2);
  var_5 = level.zonecount;
  var_6 = -1;
  var_7 = 0;
  var_8 = [];
  var_9 = randomfloat(100) > 50;
  for(var_0A = 0; var_0A < var_5; var_0A++) {
    if(var_9) {
      var_0B = var_5 - 1 - var_0A;
    } else {
      var_0B = var_0A;
    }

    if(var_0B != var_4 && botzonegetindoorpercent(var_0B) < 0.25) {
      var_0C = botzonegetcount(var_0B, self.team, "enemy_predict");
      if(var_0C > var_7) {
        var_6 = var_0B;
        var_7 = var_0C;
      }

      var_8 = scripts\engine\utility::array_add(var_8, var_0B);
    }
  }

  if(var_6 >= 0) {
    var_0D = getzoneorigin(var_6);
  } else if(var_9.size > 0) {
    var_0D = getzoneorigin(scripts\engine\utility::random(var_9));
  } else {
    var_0D = getzoneorigin(randomint(level.zonecount));
  }

  var_0E = (randomfloatrange(-500, 500), randomfloatrange(-500, 500), 0);
  self notify("confirm_location", var_0D + var_0E, randomintrange(0, 360));
  wait(1);
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

  level.killstreak_global_bp_exists_for["allies"] = [];
  level.killstreak_global_bp_exists_for["axis"] = [];
  var_0 = 0;
  var_1 = randomfloatrange(0.05, 4);
  for(;;) {
    wait(var_1);
    var_1 = randomfloatrange(0.05, 4);
    if(scripts\mp\bots\_bots_util::bot_is_remote_or_linked()) {
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

    if(isDefined(level.heli_pilot[scripts\engine\utility::get_enemy_team(self.team)])) {
      var_2 = 1;
    }

    if(enemy_mortar_strike_exists(self.team)) {
      var_2 = 1;
      try_place_global_badplace("mortar_strike", ::enemy_mortar_strike_exists);
    }

    if(enemy_switchblade_exists(self.team)) {
      var_2 = 1;
      try_place_global_badplace("switchblade", ::enemy_switchblade_exists);
    }

    if(enemy_odin_assault_exists(self.team)) {
      var_2 = 1;
      try_place_global_badplace("odin_assault", ::enemy_odin_assault_exists);
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
      badplace_global("", 5, var_0, "only_sky");
      level.last_global_badplace_time = gettime();
    }

    wait(var_3);
  }

  level.killstreak_global_bp_exists_for[var_0][var_1] = 0;
}

enemy_mortar_strike_exists(var_0) {
  if(isDefined(level.air_raid_active) && level.air_raid_active) {
    if(var_0 != level.air_raid_team_called) {
      return 1;
    }
  }

  return 0;
}

enemy_switchblade_exists(var_0) {
  if(isDefined(level.remotemissileinprogress)) {
    foreach(var_2 in level.rockets) {
      if(isDefined(var_2.type) && var_2.type == "remote" && var_2.team != var_0) {
        return 1;
      }
    }
  }

  return 0;
}

enemy_odin_assault_exists(var_0) {
  foreach(var_2 in level.players) {
    if(!level.teambased || isDefined(var_2.team) && var_0 != var_2.team) {
      if(isDefined(var_2.odin) && var_2.odin.odintype == "odin_assault" && gettime() - var_2.odin.var_64 > 3000) {
        return 1;
      }
    }
  }

  return 0;
}

get_enemy_vanguard() {
  foreach(var_1 in level.players) {
    if(!level.teambased || isDefined(var_1.team) && self.team != var_1.team) {
      if(isDefined(var_1.remoteuav) && var_1.remoteuav.helitype == "remote_uav") {
        return var_1.remoteuav;
      }
    }
  }

  return undefined;
}

iskillstreakblockedforbots(var_0) {
  return isDefined(level.botblockedkillstreaks) && isDefined(level.botblockedkillstreaks[var_0]) && level.botblockedkillstreaks[var_0];
}

blockkillstreakforbots(var_0) {
  level.botblockedkillstreaks[var_0] = 1;
}