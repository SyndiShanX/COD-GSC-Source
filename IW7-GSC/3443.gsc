/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3443.gsc
***************************************/

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

  thread scripts\mp\bots\bots_killstreaks_remote_vehicle::remote_vehicle_setup();
}

bot_register_killstreak_func(var_00, var_01, var_02, var_03) {
  level.killstreak_botfunc[var_00] = var_01;
  level.killstreak_botcanuse[var_00] = var_02;
  level.killstreak_botparm[var_00] = var_03;
  level.bot_supported_killstreaks[level.bot_supported_killstreaks.size] = var_00;
}

bot_killstreak_valid_for_specific_streaktype(var_00, var_01, var_02) {
  if(scripts\mp\utility\game::bot_is_fireteam_mode()) {
    return 1;
  }

  if(bot_killstreak_is_valid_internal(var_00, "bots", undefined, var_01)) {
    return 1;
  } else if(var_02) {}

  return 0;
}

bot_killstreak_is_valid_internal(var_00, var_01, var_02, var_03) {
  var_04 = undefined;

  if(var_00 == "specialist") {
    return 1;
  }

  if(!bot_killstreak_is_valid_single(var_00, var_01)) {
    return 0;
  }

  if(isDefined(var_03)) {
    var_04 = getsubstr(var_03, 11);

    switch (var_04) {
      case "assault":
        if(!scripts\mp\utility\game::isassaultkillstreak(var_00)) {
          return 0;
        }

        break;
      case "support":
        if(!scripts\mp\utility\game::issupportkillstreak(var_00)) {
          return 0;
        }

        break;
      case "specialist":
        if(!scripts\mp\utility\game::isspecialistkillstreak(var_00)) {
          return 0;
        }

        break;
    }
  }

  return 1;
}

bot_killstreak_is_valid_single(var_00, var_01) {
  if(var_01 == "humans") {
    return isDefined(level.killstreaksetups[var_00]) && scripts\mp\utility\game::getkillstreakindex(var_00) != -1;
  } else if(var_01 == "bots") {
    return isDefined(level.killstreak_botfunc[var_00]);
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
    scripts\mp\utility\game::_switchtoweapon("none");
  }
}

bot_is_killstreak_supported(var_00) {
  if(!isDefined(var_00)) {
    return 0;
  }

  if(!isDefined(level.killstreak_botfunc[var_00])) {
    return 0;
  }

  return 1;
}

func_2D29(var_00) {
  var_01 = level.killstreak_botcanuse[var_00];

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
    wait 0.05;
  }

  childthread bot_start_aa_launcher_tracking();
  childthread bot_watch_for_killstreak_use();

  for(;;) {
    if(scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
      var_00 = self.pers["killstreaks"];

      if(isDefined(var_00)) {
        foreach(var_02 in var_00) {
          if(!isDefined(var_02)) {
            continue;
          }
          if(isDefined(var_2.streakname) && isDefined(self.bot_killstreak_wait) && isDefined(self.bot_killstreak_wait[var_2.streakname]) && gettime() < self.bot_killstreak_wait[var_2.streakname]) {
            continue;
          }
          if(var_2.func_269A) {
            var_03 = var_2.streakname;

            if(var_2.streakname == "all_perks_bonus") {
              continue;
            }
            if(scripts\mp\utility\game::isspecialistkillstreak(var_2.streakname)) {
              if(!var_2.func_9E0B) {
                var_03 = "specialist";
              } else {
                continue;
              }
            }

            var_2.weapon = scripts\mp\utility\game::getkillstreakweapon(var_2.streakname);
            var_04 = level.killstreak_botcanuse[var_03];

            if(isDefined(var_04) && !self[[var_04]]()) {
              continue;
            }
            if(!scripts\mp\utility\game::func_1314A(var_2.streakname, 1)) {
              continue;
            }
            var_05 = level.killstreak_botfunc[var_03];

            if(isDefined(var_05)) {
              var_06 = self[[var_05]](var_02, var_00, var_04, level.killstreak_botparm[var_2.streakname]);

              if(!isDefined(var_06) || var_06 == 0) {
                if(!isDefined(self.bot_killstreak_wait)) {
                  self.bot_killstreak_wait = [];
                }

                self.bot_killstreak_wait[var_2.streakname] = gettime() + 5000;
              }
            } else {
              if(level.gametype != "grnd") {}

              var_2.func_269A = 0;
            }

            break;
          }
        }
      }
    }

    wait(randomfloatrange(1.0, 2.0));
  }
}

bot_can_use_aa_launcher() {
  return 0;
}

bot_start_aa_launcher_tracking() {
  var_00 = scripts\mp\killstreaks\aalauncher::getaalaunchername();

  for(;;) {
    self waittill("aa_launcher_fire");
    var_01 = self getammocount(var_00);

    if(var_01 == 0) {
      scripts\mp\utility\game::_switchtoweapon(var_00);
      var_02 = scripts\engine\utility::waittill_any_return("LGM_player_allMissilesDestroyed", "enemy");
      wait 0.5;
      scripts\mp\utility\game::_switchtoweapon("none");
    }
  }
}

bot_killstreak_never_use() {}

bot_can_use_air_superiority() {
  if(!aerial_vehicle_allowed()) {
    return 0;
  }

  var_00 = scripts\mp\killstreaks\airdrone::func_6CAA(self, self.team);
  var_01 = gettime();

  foreach(var_03 in var_00) {
    if(var_01 - var_3.birthtime > 5000) {
      return 1;
    }
  }

  return 0;
}

aerial_vehicle_allowed() {
  if(scripts\mp\utility\game::isairdenied()) {
    return 0;
  }

  if(vehicle_would_exceed_limit()) {
    return 0;
  }

  return 1;
}

vehicle_would_exceed_limit() {
  return scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= scripts\mp\utility\game::maxvehiclesallowed();
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
  if(scripts\mp\utility\game::isusingremote()) {
    return 0;
  }

  if(scripts\mp\killstreaks\ball_drone::exceededmaxballdrones()) {
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

bot_killstreak_simple_use(var_00, var_01, var_02, var_03) {
  self endon("commander_took_over");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(randomintrange(3, 5));

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    return 1;
  }

  if(isDefined(var_02) && !self[[var_02]]()) {
    return 0;
  }

  bot_switch_to_killstreak_weapon(var_00, var_01, var_0.weapon);
  return 1;
}

bot_killstreak_drop_anywhere(var_00, var_01, var_02, var_03) {
  bot_killstreak_drop(var_00, var_01, var_02, var_03, "anywhere");
}

bot_killstreak_drop_outside(var_00, var_01, var_02, var_03) {
  bot_killstreak_drop(var_00, var_01, var_02, var_03, "outside");
}

bot_killstreak_drop_hidden(var_00, var_01, var_02, var_03) {
  bot_killstreak_drop(var_00, var_01, var_02, var_03, "hidden");
}

bot_killstreak_drop(var_00, var_01, var_02, var_03, var_04) {
  self endon("commander_took_over");
  wait(randomintrange(2, 4));

  if(!isDefined(var_04)) {
    var_04 = "anywhere";
  }

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    return 1;
  }

  if(isDefined(var_02) && !self[[var_02]]()) {
    return 0;
  }

  var_05 = self getweaponammoclip(var_0.weapon) + self getweaponammostock(var_0.weapon);

  if(var_05 == 0) {
    foreach(var_07 in var_01) {
      if(isDefined(var_7.streakname) && var_7.streakname == var_0.streakname) {
        var_7.func_269A = 0;
      }
    }

    return 1;
  }

  var_09 = undefined;

  if(var_04 == "outside") {
    var_10 = [];
    var_11 = scripts\mp\bots\bots_util::bot_get_nodes_in_cone(750, 0.6, 1);

    foreach(var_13 in var_11) {
      if(nodeexposedtosky(var_13)) {
        var_10 = scripts\engine\utility::array_add(var_10, var_13);
      }
    }

    if(var_11.size > 5 && var_10.size > var_11.size * 0.6) {
      var_15 = scripts\engine\utility::get_array_of_closest(self.origin, var_10, undefined, undefined, undefined, 150);

      if(var_15.size > 0) {
        var_09 = scripts\engine\utility::random(var_15);
      } else {
        var_09 = scripts\engine\utility::random(var_10);
      }
    }
  } else if(var_04 == "hidden") {
    var_16 = getnodesinradius(self.origin, 256, 0, 40);
    var_17 = self getnearestnode();

    if(isDefined(var_17)) {
      var_18 = [];

      foreach(var_13 in var_16) {
        if(nodesvisible(var_17, var_13, 1)) {
          var_18 = scripts\engine\utility::array_add(var_18, var_13);
        }
      }

      var_09 = self botnodepick(var_18, 1, "node_hide");
    }
  }

  if(isDefined(var_09) || var_04 == "anywhere") {
    self botsetflag("disable_movement", 1);

    if(isDefined(var_09)) {
      self botlookatpoint(var_9.origin, 2.45, "script_forced");
    }

    bot_switch_to_killstreak_weapon(var_00, var_01, var_0.weapon);
    wait 2.0;
    self botpressbutton("attack");
    wait 1.5;
    scripts\mp\utility\game::_switchtoweapon("none");
    self botsetflag("disable_movement", 0);
  }

  return 1;
}

bot_switch_to_killstreak_weapon(var_00, var_01, var_02) {
  func_2E29(var_00, var_01);
}

func_2E29(var_00, var_01) {
  if(isDefined(var_0.isgimme) && var_0.isgimme) {
    self notify("ks_action_6");
    return;
  }

  for(var_02 = 1; var_02 < 4; var_2++) {
    if(isDefined(var_1[var_02])) {
      if(isDefined(var_1[var_02].streakname)) {
        if(var_1[var_02].streakname == var_0.streakname) {
          var_03 = var_02 + 2;
          self notify("ks_action_" + var_03);
          return;
        }
      }
    }
  }
}

bot_killstreak_choose_loc_enemies(var_00, var_01, var_02, var_03) {
  self endon("commander_took_over");
  wait(randomintrange(3, 5));

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    return;
  }
  var_04 = getzonenearest(self.origin);

  if(!isDefined(var_04)) {
    return;
  }
  self botsetflag("disable_movement", 1);
  bot_switch_to_killstreak_weapon(var_00, var_01, var_0.weapon);
  wait 2;
  var_05 = level.zonecount;
  var_06 = -1;
  var_07 = 0;
  var_08 = [];
  var_09 = randomfloat(100) > 50;

  for(var_10 = 0; var_10 < var_05; var_10++) {
    if(var_09) {
      var_11 = var_05 - 1 - var_10;
    } else {
      var_11 = var_10;
    }

    if(var_11 != var_04 && botzonegetindoorpercent(var_11) < 0.25) {
      var_12 = botzonegetcount(var_11, self.team, "enemy_predict");

      if(var_12 > var_07) {
        var_06 = var_11;
        var_07 = var_12;
      }

      var_08 = scripts\engine\utility::array_add(var_08, var_11);
    }
  }

  if(var_06 >= 0) {
    var_13 = getzoneorigin(var_06);
  } else if(var_8.size > 0) {
    var_13 = getzoneorigin(scripts\engine\utility::random(var_08));
  } else {
    var_13 = getzoneorigin(randomint(level.zonecount));
  }

  var_14 = (randomfloatrange(-500, 500), randomfloatrange(-500, 500), 0);
  self notify("confirm_location", var_13 + var_14, randomintrange(0, 360));
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

  level.killstreak_global_bp_exists_for["allies"] = [];
  level.killstreak_global_bp_exists_for["axis"] = [];
  var_00 = 0;
  var_01 = randomfloatrange(0.05, 4.0);

  for(;;) {
    wait(var_01);
    var_01 = randomfloatrange(0.05, 4.0);

    if(scripts\mp\bots\bots_util::bot_is_remote_or_linked()) {
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

      if(scripts\engine\utility::within_fov(var_04, self getplayerangles(), var_3.attackarrow.origin, self botgetfovdot())) {
        if(sighttracepassed(var_04, var_3.attackarrow.origin, 0, self, var_3.attackarrow)) {
          badplace_cylinder("vanguard_" + var_03 getentitynumber(), var_01 + 0.5, var_3.attackarrow.origin, 200, 100, self.team);
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

try_place_global_badplace(var_00, var_01) {
  if(!isDefined(level.killstreak_global_bp_exists_for[self.team][var_00])) {
    level.killstreak_global_bp_exists_for[self.team][var_00] = 0;
  }

  if(!level.killstreak_global_bp_exists_for[self.team][var_00]) {
    level.killstreak_global_bp_exists_for[self.team][var_00] = 1;
    level thread monitor_enemy_dangerous_killstreak(self.team, var_00, var_01);
  }
}

monitor_enemy_dangerous_killstreak(var_00, var_01, var_02) {
  var_03 = 0.5;

  while([[var_02]](var_00)) {
    if(gettime() > level.last_global_badplace_time + 4000) {
      badplace_global("", 5.0, var_00, "only_sky");
      level.last_global_badplace_time = gettime();
    }

    wait(var_03);
  }

  level.killstreak_global_bp_exists_for[var_00][var_01] = 0;
}

enemy_mortar_strike_exists(var_00) {
  if(isDefined(level.air_raid_active) && level.air_raid_active) {
    if(var_00 != level.air_raid_team_called) {
      return 1;
    }
  }

  return 0;
}

enemy_switchblade_exists(var_00) {
  if(isDefined(level.remotemissileinprogress)) {
    foreach(var_02 in level.rockets) {
      if(isDefined(var_2.type) && var_2.type == "remote" && var_2.team != var_00) {
        return 1;
      }
    }
  }

  return 0;
}

enemy_odin_assault_exists(var_00) {
  foreach(var_02 in level.players) {
    if(!level.teambased || isDefined(var_2.team) && var_00 != var_2.team) {
      if(isDefined(var_2.odin) && var_2.odin.odintype == "odin_assault" && gettime() - var_2.odin.birthtime > 3000) {
        return 1;
      }
    }
  }

  return 0;
}

get_enemy_vanguard() {
  foreach(var_01 in level.players) {
    if(!level.teambased || isDefined(var_1.team) && self.team != var_1.team) {
      if(isDefined(var_1.remoteuav) && var_1.remoteuav.helitype == "remote_uav") {
        return var_1.remoteuav;
      }
    }
  }

  return undefined;
}

iskillstreakblockedforbots(var_00) {
  return isDefined(level.botblockedkillstreaks) && isDefined(level.botblockedkillstreaks[var_00]) && level.botblockedkillstreaks[var_00];
}

blockkillstreakforbots(var_00) {
  level.botblockedkillstreaks[var_00] = 1;
}