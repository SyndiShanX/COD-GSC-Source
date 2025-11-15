/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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

bot_register_killstreak_func(param_00, param_01, param_02, param_03) {
  level.killstreak_botfunc[param_00] = param_01;
  level.killstreak_botcanuse[param_00] = param_02;
  level.killstreak_botparm[param_00] = param_03;
  level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = param_00;
}

bot_killstreak_valid_for_specific_streaktype(param_00, param_01, param_02) {
  if(scripts\mp\utility::bot_is_fireteam_mode()) {
    return 1;
  }

  if(bot_killstreak_is_valid_internal(param_00, "bots", undefined, param_01)) {
    return 1;
  } else if(param_02) {}

  return 0;
}

bot_killstreak_is_valid_internal(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  if(param_00 == "specialist") {
    return 1;
  }

  if(!bot_killstreak_is_valid_single(param_00, param_01)) {
    return 0;
  }

  if(isDefined(param_03)) {
    var_04 = getsubstr(param_03, 11);
    switch (var_04) {
      case "assault":
        if(!scripts\mp\utility::isassaultkillstreak(param_00)) {
          return 0;
        }
        break;

      case "support":
        if(!scripts\mp\utility::issupportkillstreak(param_00)) {
          return 0;
        }
        break;

      case "specialist":
        if(!scripts\mp\utility::isspecialistkillstreak(param_00)) {
          return 0;
        }
        break;
    }
  }

  return 1;
}

bot_killstreak_is_valid_single(param_00, param_01) {
  if(param_01 == "humans") {
    return isDefined(level.killstreaksetups[param_00]) && scripts\mp\utility::getkillstreakindex(param_00) != -1;
  } else if(param_01 == "bots") {
    return isDefined(level.killstreak_botfunc[param_00]);
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

bot_is_killstreak_supported(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(!isDefined(level.killstreak_botfunc[param_00])) {
    return 0;
  }

  return 1;
}

func_2D29(param_00) {
  var_01 = level.killstreak_botcanuse[param_00];
  if(!isDefined(var_01)) {
    return 0;
  }

  if(isDefined(var_01) && !self[[var_01]]()) {
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
      var_00 = self.pers["killstreaks"];
      if(isDefined(var_00)) {
        foreach(var_02 in var_00) {
          if(!isDefined(var_02)) {
            continue;
          }

          if(isDefined(var_02.streakname) && isDefined(self.bot_killstreak_wait) && isDefined(self.bot_killstreak_wait[var_02.streakname]) && gettime() < self.bot_killstreak_wait[var_02.streakname]) {
            continue;
          }

          if(var_02.var_269A) {
            var_03 = var_02.streakname;
            if(var_02.streakname == "all_perks_bonus") {
              continue;
            }

            if(scripts\mp\utility::isspecialistkillstreak(var_02.streakname)) {
              if(!var_02.var_9E0B) {
                var_03 = "specialist";
              } else {
                continue;
              }
            }

            var_02.var_394 = scripts\mp\utility::getkillstreakweapon(var_02.streakname);
            var_04 = level.killstreak_botcanuse[var_03];
            if(isDefined(var_04) && !self[[var_04]]()) {
              continue;
            }

            if(!scripts\mp\utility::validateusestreak(var_02.streakname, 1)) {
              continue;
            }

            var_05 = level.killstreak_botfunc[var_03];
            if(isDefined(var_05)) {
              var_06 = self[[var_05]](var_02, var_00, var_04, level.killstreak_botparm[var_02.streakname]);
              if(!isDefined(var_06) || var_06 == 0) {
                if(!isDefined(self.bot_killstreak_wait)) {
                  self.bot_killstreak_wait = [];
                }

                self.bot_killstreak_wait[var_02.streakname] = gettime() + 5000;
              }
            } else {
              if(level.gametype != "grnd") {}

              var_02.var_269A = 0;
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
  var_00 = scripts\mp\killstreaks\_aalauncher::getaalaunchername();
  for(;;) {
    self waittill("aa_launcher_fire");
    var_01 = self getrunningforwardpainanim(var_00);
    if(var_01 == 0) {
      scripts\mp\utility::_switchtoweapon(var_00);
      var_02 = scripts\engine\utility::waittill_any_return("LGM_player_allMissilesDestroyed", "enemy");
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

  var_00 = scripts\mp\killstreaks\_air_superiority::func_6CAA(self, self.team);
  var_01 = gettime();
  foreach(var_03 in var_00) {
    if(var_01 - var_03.var_64 > 5000) {
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

  var_00 = level.otherteam[self.team];
  if(isDefined(level.teamemped) && isDefined(level.teamemped[var_00]) && level.teamemped[var_00]) {
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

bot_killstreak_simple_use(param_00, param_01, param_02, param_03) {
  self endon("commander_took_over");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(randomintrange(3, 5));
  if(!scripts\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
    return 1;
  }

  if(isDefined(param_02) && !self[[param_02]]()) {
    return 0;
  }

  bot_switch_to_killstreak_weapon(param_00, param_01, param_00.var_394);
  return 1;
}

bot_killstreak_drop_anywhere(param_00, param_01, param_02, param_03) {
  bot_killstreak_drop(param_00, param_01, param_02, param_03, "anywhere");
}

bot_killstreak_drop_outside(param_00, param_01, param_02, param_03) {
  bot_killstreak_drop(param_00, param_01, param_02, param_03, "outside");
}

bot_killstreak_drop_hidden(param_00, param_01, param_02, param_03) {
  bot_killstreak_drop(param_00, param_01, param_02, param_03, "hidden");
}

bot_killstreak_drop(param_00, param_01, param_02, param_03, param_04) {
  self endon("commander_took_over");
  wait(randomintrange(2, 4));
  if(!isDefined(param_04)) {
    param_04 = "anywhere";
  }

  if(!scripts\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
    return 1;
  }

  if(isDefined(param_02) && !self[[param_02]]()) {
    return 0;
  }

  var_05 = self getweaponammoclip(param_00.var_394) + self getweaponammostock(param_00.var_394);
  if(var_05 == 0) {
    foreach(var_07 in param_01) {
      if(isDefined(var_07.streakname) && var_07.streakname == param_00.streakname) {
        var_07.var_269A = 0;
      }
    }

    return 1;
  }

  var_09 = undefined;
  if(var_07 == "outside") {
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
        var_09 = scripts\engine\utility::random(var_0F);
      } else {
        var_09 = scripts\engine\utility::random(var_0A);
      }
    }
  } else if(var_07 == "hidden") {
    var_10 = getnodesinradius(self.origin, 256, 0, 40);
    var_11 = self getnearestnode();
    if(isDefined(var_11)) {
      var_12 = [];
      foreach(var_0D in var_10) {
        if(nodesvisible(var_11, var_0D, 1)) {
          var_12 = scripts\engine\utility::array_add(var_12, var_0D);
        }
      }

      var_09 = self botnodepick(var_12, 1, "node_hide");
    }
  }

  if(isDefined(var_09) || var_07 == "anywhere") {
    self botsetflag("disable_movement", 1);
    if(isDefined(var_09)) {
      self botlookatpoint(var_09.origin, 2.45, "script_forced");
    }

    bot_switch_to_killstreak_weapon(param_03, param_04, param_03.var_394);
    wait(2);
    self botpressbutton("attack");
    wait(1.5);
    scripts\mp\utility::_switchtoweapon("none");
    self botsetflag("disable_movement", 0);
  }

  return 1;
}

bot_switch_to_killstreak_weapon(param_00, param_01, param_02) {
  func_2E29(param_00, param_01);
}

func_2E29(param_00, param_01) {
  if(isDefined(param_00.isgimme) && param_00.isgimme) {
    self notify("ks_action_6");
    return;
  }

  var_02 = 1;
  while(var_02 < 4) {
    if(isDefined(param_01[var_02])) {
      if(isDefined(param_01[var_02].streakname)) {
        if(param_01[var_02].streakname == param_00.streakname) {
          var_03 = var_02 + 2;
          self notify("ks_action_" + var_03);
          return;
        }
      }
    }

    var_03++;
  }
}

bot_killstreak_choose_loc_enemies(param_00, param_01, param_02, param_03) {
  self endon("commander_took_over");
  wait(randomintrange(3, 5));
  if(!scripts\mp\bots\_bots_util::bot_allowed_to_use_killstreaks()) {
    return;
  }

  var_04 = getzonenearest(self.origin);
  if(!isDefined(var_04)) {
    return;
  }

  self botsetflag("disable_movement", 1);
  bot_switch_to_killstreak_weapon(param_00, param_01, param_00.var_394);
  wait(2);
  var_05 = level.zonecount;
  var_06 = -1;
  var_07 = 0;
  var_08 = [];
  var_09 = randomfloat(100) > 50;
  for(var_0A = 0; var_0A < var_05; var_0A++) {
    if(var_09) {
      var_0B = var_05 - 1 - var_0A;
    } else {
      var_0B = var_0A;
    }

    if(var_0B != var_04 && botzonegetindoorpercent(var_0B) < 0.25) {
      var_0C = botzonegetcount(var_0B, self.team, "enemy_predict");
      if(var_0C > var_07) {
        var_06 = var_0B;
        var_07 = var_0C;
      }

      var_08 = scripts\engine\utility::array_add(var_08, var_0B);
    }
  }

  if(var_06 >= 0) {
    var_0D = getzoneorigin(var_06);
  } else if(var_09.size > 0) {
    var_0D = getzoneorigin(scripts\engine\utility::random(var_09));
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
  var_00 = 0;
  var_01 = randomfloatrange(0.05, 4);
  for(;;) {
    wait(var_01);
    var_01 = randomfloatrange(0.05, 4);
    if(scripts\mp\bots\_bots_util::bot_is_remote_or_linked()) {
      continue;
    }

    if(self botgetdifficultysetting("strategyLevel") == 0) {
      continue;
    }

    var_02 = 0;
    if(isDefined(level.chopper) && level.chopper.team != self.team) {
      var_02 = 1;
    }

    if(isDefined(level.lbsniper) && level.lbsniper.team != self.team) {
      var_02 = 1;
    }

    if(isDefined(level.heli_pilot[scripts\engine\utility::get_enemy_team(self.team)])) {
      var_02 = 1;
    }

    if(enemy_mortar_strike_exists(self.team)) {
      var_02 = 1;
      try_place_global_badplace("mortar_strike", ::enemy_mortar_strike_exists);
    }

    if(enemy_switchblade_exists(self.team)) {
      var_02 = 1;
      try_place_global_badplace("switchblade", ::enemy_switchblade_exists);
    }

    if(enemy_odin_assault_exists(self.team)) {
      var_02 = 1;
      try_place_global_badplace("odin_assault", ::enemy_odin_assault_exists);
    }

    var_03 = get_enemy_vanguard();
    if(isDefined(var_03)) {
      var_04 = self getEye();
      if(scripts\engine\utility::within_fov(var_04, self getplayerangles(), var_03.attackarrow.origin, self botgetfovdot())) {
        if(sighttracepassed(var_04, var_03.attackarrow.origin, 0, self, var_03.attackarrow)) {
          badplace_cylinder("vanguard_" + var_03 getentitynumber(), var_01 + 0.5, var_03.attackarrow.origin, 200, 100, self.team);
        }
      }
    }

    if(!var_00 && var_02) {
      var_00 = 1;
      self botsetflag("hide_indoors", 1);
    }

    if(var_00 && !var_02) {
      var_00 = 0;
      self botsetflag("hide_indoors", 0);
    }
  }
}

try_place_global_badplace(param_00, param_01) {
  if(!isDefined(level.killstreak_global_bp_exists_for[self.team][param_00])) {
    level.killstreak_global_bp_exists_for[self.team][param_00] = 0;
  }

  if(!level.killstreak_global_bp_exists_for[self.team][param_00]) {
    level.killstreak_global_bp_exists_for[self.team][param_00] = 1;
    level thread monitor_enemy_dangerous_killstreak(self.team, param_00, param_01);
  }
}

monitor_enemy_dangerous_killstreak(param_00, param_01, param_02) {
  var_03 = 0.5;
  while([[param_02]](param_00)) {
    if(gettime() > level.last_global_badplace_time + 4000) {
      badplace_global("", 5, param_00, "only_sky");
      level.last_global_badplace_time = gettime();
    }

    wait(var_03);
  }

  level.killstreak_global_bp_exists_for[param_00][param_01] = 0;
}

enemy_mortar_strike_exists(param_00) {
  if(isDefined(level.air_raid_active) && level.air_raid_active) {
    if(param_00 != level.air_raid_team_called) {
      return 1;
    }
  }

  return 0;
}

enemy_switchblade_exists(param_00) {
  if(isDefined(level.remotemissileinprogress)) {
    foreach(var_02 in level.rockets) {
      if(isDefined(var_02.type) && var_02.type == "remote" && var_02.team != param_00) {
        return 1;
      }
    }
  }

  return 0;
}

enemy_odin_assault_exists(param_00) {
  foreach(var_02 in level.players) {
    if(!level.teambased || isDefined(var_02.team) && param_00 != var_02.team) {
      if(isDefined(var_02.odin) && var_02.odin.odintype == "odin_assault" && gettime() - var_02.odin.var_64 > 3000) {
        return 1;
      }
    }
  }

  return 0;
}

get_enemy_vanguard() {
  foreach(var_01 in level.players) {
    if(!level.teambased || isDefined(var_01.team) && self.team != var_01.team) {
      if(isDefined(var_01.remoteuav) && var_01.remoteuav.helitype == "remote_uav") {
        return var_01.remoteuav;
      }
    }
  }

  return undefined;
}

iskillstreakblockedforbots(param_00) {
  return isDefined(level.botblockedkillstreaks) && isDefined(level.botblockedkillstreaks[param_00]) && level.botblockedkillstreaks[param_00];
}

blockkillstreakforbots(param_00) {
  level.botblockedkillstreaks[param_00] = 1;
}