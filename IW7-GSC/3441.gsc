/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3441.gsc
***************************************/

bot_fireteam_setup_callbacks() {}

bot_fireteam_init() {
  level.bots_fireteam_num_classes_loaded = [];
  level thread bot_fireteam_connect_monitor();
}

bot_fireteam_connect_monitor() {
  self notify("bot_connect_monitor");
  self endon("bot_connect_monitor");
  level.bots_fireteam_humans = [];

  for(;;) {
    foreach(var_01 in level.players) {
      if(!isbot(var_01) && !isDefined(var_1.processed_for_fireteam)) {
        if(isDefined(var_1.team) && (var_1.team == "allies" || var_1.team == "axis")) {
          var_1.processed_for_fireteam = 1;
          level.bots_fireteam_humans[var_1.team] = var_01;
          level.bots_fireteam_num_classes_loaded[var_1.team] = 0;
          var_02 = scripts\mp\bots\bots_util::bot_get_team_limit();

          if(level.bots_fireteam_humans.size == 2)
            scripts\mp\bots\bots::drop_bots(var_02 - 1, var_1.team);

          scripts\mp\bots\bots::spawn_bots(var_02 - 1, var_1.team, ::bot_fireteam_spawn_callback);

          if(level.bots_fireteam_humans.size == 1) {
            var_03 = 0;

            foreach(var_05 in level.players) {
              if(isDefined(var_05) && !isbot(var_05))
                var_3++;
            }

            if(var_03 == 1)
              scripts\mp\bots\bots::spawn_bots(var_02 - 1, scripts\engine\utility::get_enemy_team(var_1.team));
          }
        }
      }
    }

    wait 0.25;
  }
}

bot_fireteam_spawn_callback() {
  self.override_class_function = ::bot_fireteam_setup_callback_class;
  self.fireteam_commander = level.bots_fireteam_humans[self.bot_team];
  thread bot_fireteam_monitor_killstreak_earned();
}

bot_fireteam_setup_callback_class() {
  self.classcallback = ::bot_fireteam_loadout_class_callback;
  return "callback";
}

bot_fireteam_loadout_class_callback() {
  if(isDefined(self.botlastloadout))
    return self.botlastloadout;

  self.class_num = level.bots_fireteam_num_classes_loaded[self.team];
  level.bots_fireteam_num_classes_loaded[self.team] = level.bots_fireteam_num_classes_loaded[self.team] + 1;

  if(self.class_num == 5)
    self.class_num = 0;

  var_0["loadoutPrimary"] = self.fireteam_commander bot_fireteam_cac_getweapon(self.class_num, 0);
  var_0["loadoutPrimaryAttachment"] = self.fireteam_commander bot_fireteam_cac_getweaponattachment(self.class_num, 0);
  var_0["loadoutPrimaryAttachment2"] = self.fireteam_commander bot_fireteam_cac_getweaponattachmenttwo(self.class_num, 0);
  var_0["loadoutPrimaryCamo"] = self.fireteam_commander bot_fireteam_cac_getweaponcamo(self.class_num, 0);
  var_0["loadoutPrimaryReticle"] = self.fireteam_commander bot_fireteam_cac_getweaponreticle(self.class_num, 0);
  var_0["loadoutSecondary"] = self.fireteam_commander bot_fireteam_cac_getweapon(self.class_num, 1);
  var_0["loadoutSecondaryAttachment"] = self.fireteam_commander bot_fireteam_cac_getweaponattachment(self.class_num, 1);
  var_0["loadoutSecondaryAttachment2"] = self.fireteam_commander bot_fireteam_cac_getweaponattachmenttwo(self.class_num, 1);
  var_0["loadoutSecondaryCamo"] = self.fireteam_commander bot_fireteam_cac_getweaponcamo(self.class_num, 1);
  var_0["loadoutSecondaryReticle"] = self.fireteam_commander bot_fireteam_cac_getweaponreticle(self.class_num, 1);
  var_0["loadoutEquipment"] = self.fireteam_commander bot_fireteam_cac_getprimarygrenade(self.class_num);
  var_0["loadoutOffhand"] = self.fireteam_commander bot_fireteam_cac_getsecondarygrenade(self.class_num);
  var_0["loadoutPerk1"] = self.fireteam_commander bot_fireteam_cac_getperk(self.class_num, 2);
  var_0["loadoutPerk2"] = self.fireteam_commander bot_fireteam_cac_getperk(self.class_num, 3);
  var_0["loadoutPerk3"] = self.fireteam_commander bot_fireteam_cac_getperk(self.class_num, 4);
  var_0["loadoutStreakType"] = self.fireteam_commander bot_fireteam_cac_getperk(self.class_num, 5);

  if(var_0["loadoutStreakType"] != "specialty_null") {
    var_01 = getsubstr(var_0["loadoutStreakType"], 11) + "Streaks";
    var_0["loadoutStreak1"] = self.fireteam_commander bot_fireteam_cac_getstreak(self.class_num, var_01, 0);

    if(var_0["loadoutStreak1"] == "none")
      var_0["loadoutStreak1"] = undefined;

    var_0["loadoutStreak2"] = self.fireteam_commander bot_fireteam_cac_getstreak(self.class_num, var_01, 1);

    if(var_0["loadoutStreak2"] == "none")
      var_0["loadoutStreak2"] = undefined;

    var_0["loadoutStreak3"] = self.fireteam_commander bot_fireteam_cac_getstreak(self.class_num, var_01, 2);

    if(var_0["loadoutStreak3"] == "none")
      var_0["loadoutStreak3"] = undefined;
  }

  self.botlastloadout = var_00;
  return var_00;
}

bot_fireteam_cac_getweapon(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", var_00, "weaponSetups", var_01, "weapon");
}

bot_fireteam_cac_getweaponattachment(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", var_00, "weaponSetups", var_01, "attachment", 0);
}

bot_fireteam_cac_getweaponattachmenttwo(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", var_00, "weaponSetups", var_01, "attachment", 1);
}

bot_fireteam_cac_getweaponcamo(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", var_00, "weaponSetups", var_01, "camo");
}

bot_fireteam_cac_getweaponreticle(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", var_00, "weaponSetups", var_01, "reticle");
}

bot_fireteam_cac_getprimarygrenade(var_00) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", var_00, "perks", 0);
}

bot_fireteam_cac_getsecondarygrenade(var_00) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", var_00, "perks", 1);
}

bot_fireteam_cac_getperk(var_00, var_01) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", var_00, "perks", var_01);
}

bot_fireteam_cac_getstreak(var_00, var_01, var_02) {
  return self getrankedplayerdata(level.loadoutsgroup, "squadMembers", var_00, var_01, var_02);
}

bot_fireteam_buddy_think() {
  var_00 = 250;
  var_01 = var_00 * var_00;

  if(!scripts\mp\bots\bots_util::bot_is_guarding_player(self.owner))
    scripts\mp\bots\bots_strategy::bot_guard_player(self.owner, var_00);

  if(distancesquared(self.origin, self.owner.origin) > var_01)
    self botsetflag("force_sprint", 1);
  else if(self.owner issprinting())
    self botsetflag("force_sprint", 1);
  else
    self botsetflag("force_sprint", 0);
}

bot_fireteam_buddy_search() {
  self endon("buddy_cancel");
  self endon("disconnect");
  self notify("buddy_search_start");
  self endon("buddy_search_start");

  for(;;) {
    if(isalive(self) && !isDefined(self.bot_fireteam_follower)) {
      if(isDefined(self.owner)) {
        if(self.sessionstate == "playing") {
          if(!self.owner.connected) {
            self.owner.bot_fireteam_follower = undefined;
            self.owner = undefined;
          } else if(isDefined(level.fireteam_commander[self.team])) {
            if(isDefined(level.fireteam_commander[self.team].commanding_bot) && level.fireteam_commander[self.team].commanding_bot == self) {
              self.owner.bot_fireteam_follower = undefined;
              self.owner.owner = level.fireteam_commander[self.team];
              self.owner.personality_update_function = ::bot_fireteam_buddy_think;
              self.owner = undefined;
            } else if(isDefined(level.fireteam_commander[self.team].commanding_bot) && level.fireteam_commander[self.team].commanding_bot == self.owner) {
              self.owner.bot_fireteam_follower = undefined;
              self.owner = level.fireteam_commander[self.team];
              self.owner.bot_fireteam_follower = self;
            } else if(self.owner == level.fireteam_commander[self.team] && !isDefined(self.owner.commanding_bot)) {
              self.owner.bot_fireteam_follower = undefined;

              if(isDefined(self.owner.last_commanded_bot)) {
                self.owner = self.owner.last_commanded_bot;
                self.owner.bot_fireteam_follower = self;
              } else
                self.owner = undefined;
            }
          }
        } else if(isDefined(level.fireteam_commander[self.team])) {
          if(isDefined(level.fireteam_commander[self.team].commanding_bot) && level.fireteam_commander[self.team].commanding_bot == self) {
            self.owner.bot_fireteam_follower = undefined;
            self.owner.owner = level.fireteam_commander[self.team];
            self.owner.personality_update_function = ::bot_fireteam_buddy_think;
            self.owner = undefined;
          }
        }
      }

      if(self.sessionstate == "playing") {
        if(!isDefined(self.owner)) {
          var_00 = [];

          foreach(var_02 in level.players) {
            if(var_02 != self && var_2.team == self.team) {
              if(isalive(var_02) && var_2.sessionstate == "playing" && !isDefined(var_2.bot_fireteam_follower) && !isDefined(var_2.owner))
                var_0[var_0.size] = var_02;
            }
          }

          if(var_0.size > 0) {
            var_04 = scripts\engine\utility::getclosest(self.origin, var_00);

            if(isDefined(var_04)) {
              self.owner = var_04;
              self.owner.bot_fireteam_follower = self;
            }
          }
        }
      }

      if(isDefined(self.owner))
        self.personality_update_function = ::bot_fireteam_buddy_think;
      else
        scripts\mp\bots\bots_personality::bot_assign_personality_functions();
    }

    wait 0.5;
  }
}

fireteam_tdm_set_hunt_leader(var_00) {
  var_01 = [];

  foreach(var_03 in level.players) {
    if(var_3.team == var_00) {
      if(var_3.connected && isalive(var_03) && var_3.sessionstate == "playing") {
        if(!isbot(var_03)) {
          level.fireteam_hunt_leader[var_00] = var_03;
          return 1;
        } else
          var_1[var_1.size] = var_03;
      }
    }
  }

  if(!isDefined(level.fireteam_hunt_leader[var_00])) {
    if(var_1.size > 0) {
      if(var_1.size == 1)
        level.fireteam_hunt_leader[var_00] = var_1[0];
      else
        level.fireteam_hunt_leader[var_00] = var_1[randomint(var_1.size)];

      return 1;
    }
  }

  return 0;
}

fireteam_tdm_hunt_end(var_00) {
  level notify("hunting_party_end_" + var_00);
  level.fireteam_hunt_leader[var_00] = undefined;
  level.fireteam_hunt_target_zone[var_00] = undefined;
  level.bot_random_path_function[var_00] = ::scripts\mp\bots\bots_personality::bot_random_path_default;
}

fireteam_tdm_hunt_most_dangerous_zone(var_00, var_01) {
  var_02 = 0;
  var_03 = undefined;
  var_04 = -1;

  if(level.zonecount > 0) {
    for(var_05 = 0; var_05 < level.zonecount; var_5++) {
      var_06 = botzonegetcount(var_05, var_01, "enemy_predict");

      if(var_06 < var_02) {
        continue;
      }
      var_07 = undefined;

      if(var_06 == var_02) {
        var_07 = getzonepath(var_00, var_05);

        if(!isDefined(var_07)) {
          continue;
        }
        if(var_04 >= 0 && var_7.size > var_04)
          continue;
      }

      var_02 = var_06;
      var_03 = var_05;

      if(isDefined(var_07)) {
        var_04 = var_7.size;
        continue;
      }

      var_04 = -1;
    }
  }

  return var_03;
}

fireteam_tdm_find_hunt_zone(var_00) {
  level endon("hunting_party_end_" + var_00);
  self endon("disconnect");
  level endon("game_ended");

  if(level.zonecount <= 0) {
    return;
  }
  level.bot_random_path_function[var_00] = ::bot_fireteam_hunt_zone_find_node;

  for(;;) {
    var_01 = 3;

    if(!isDefined(level.fireteam_hunt_leader[var_00]) || isbot(level.fireteam_hunt_leader[var_00]) || isDefined(level.fireteam_hunt_leader[var_00].commanding_bot))
      fireteam_tdm_set_hunt_leader(var_00);

    if(isDefined(level.fireteam_hunt_leader[var_00])) {
      var_02 = getzonenearest(level.fireteam_hunt_leader[var_00].origin);

      if(!isDefined(var_02)) {
        wait(var_01);
        continue;
      }

      if(!isbot(level.fireteam_hunt_leader[var_00])) {
        if(isalive(level.fireteam_hunt_leader[var_00]) && level.fireteam_hunt_leader[var_00].sessionstate == "playing" && (!isDefined(level.fireteam_hunt_leader[var_00].deathtime) || level.fireteam_hunt_leader[var_00].deathtime + 5000 < gettime())) {
          level.fireteam_hunt_target_zone[var_00] = var_02;
          level.fireteam_hunt_next_zone_search_time[var_00] = gettime() + 1000;
          var_01 = 0.5;
        } else
          var_01 = 1;
      } else {
        var_03 = 0;
        var_04 = 0;
        var_05 = undefined;

        if(isDefined(level.fireteam_hunt_target_zone[var_00]))
          var_05 = level.fireteam_hunt_target_zone[var_00];
        else {
          var_03 = 1;
          var_04 = 1;
          var_05 = var_02;
        }

        var_06 = undefined;

        if(isDefined(var_05)) {
          var_06 = fireteam_tdm_hunt_most_dangerous_zone(var_02, var_00);

          if(!var_03) {
            if(!isDefined(var_06) || var_06 != var_05) {
              if(var_05 == var_02)
                var_04 = 1;
              else if(gettime() > level.fireteam_hunt_next_zone_search_time[var_00])
                var_04 = 1;
            }
          }

          if(var_04) {
            if(!isDefined(var_06)) {
              var_07 = 0;
              var_08 = -1;

              for(var_09 = 0; var_09 < level.zonecount; var_9++) {
                var_10 = distance2d(getzoneorigin(var_09), level.fireteam_hunt_leader[var_00].origin);

                if(var_10 > var_07) {
                  var_07 = var_10;
                  var_08 = var_09;
                }
              }

              var_06 = var_08;
            }

            if(isDefined(var_06)) {
              if(!isDefined(level.fireteam_hunt_target_zone[var_00]) || level.fireteam_hunt_target_zone[var_00] != var_06) {
                foreach(var_12 in level.players) {
                  if(isbot(var_12) && var_12.team == var_00) {
                    var_12 botclearscriptgoal();
                    var_12.fireteam_hunt_goalpos = undefined;
                    var_12 thread bot_fireteam_hunt_zone_find_node();
                  }
                }
              }

              level.fireteam_hunt_target_zone[var_00] = var_06;
              level.fireteam_hunt_next_zone_search_time[var_00] = gettime() + 12000;
            }
          }
        }
      }
    }

    wait(var_01);
  }
}

bot_debug_script_goal() {
  self notify("bot_debug_script_goal");
  level endon("hunting_party_end_" + self.team);
  self endon("bot_debug_script_goal");
  var_00 = 48;

  for(;;) {
    if(self bothasscriptgoal()) {
      var_01 = self botgetscriptgoal();

      if(!isDefined(self.fireteam_hunt_goalpos)) {} else if(self.fireteam_hunt_goalpos != var_01) {} else {}
    } else if(isDefined(self.fireteam_hunt_goalpos)) {}

    wait 0.05;
  }
}

bot_fireteam_hunt_zone_find_node() {
  var_00 = 0;
  var_01 = undefined;

  if(isDefined(level.fireteam_hunt_target_zone[self.team])) {
    var_02 = getzonenodes(level.fireteam_hunt_target_zone[self.team], 0);

    if(var_2.size <= 18) {
      var_02 = getzonenodes(level.fireteam_hunt_target_zone[self.team], 1);

      if(var_2.size <= 18) {
        var_02 = getzonenodes(level.fireteam_hunt_target_zone[self.team], 2);

        if(var_2.size <= 18)
          var_02 = getzonenodes(level.fireteam_hunt_target_zone[self.team], 3);
      }
    }

    if(var_2.size <= 0)
      return scripts\mp\bots\bots_personality::bot_random_path_default();

    var_01 = self botnodepick(var_02, var_2.size, "node_hide");

    for(var_03 = 0; !isDefined(var_01) || !self botnodeavailable(var_01); var_01 = var_2[randomint(var_2.size)]) {
      var_3++;

      if(var_03 >= 10)
        return scripts\mp\bots\bots_personality::bot_random_path_default();
    }

    var_04 = var_1.origin;

    if(isDefined(var_04)) {
      var_05 = "guard";
      var_06 = getzonenearest(self.origin);

      if(isDefined(var_06) && var_06 == level.fireteam_hunt_target_zone[self.team])
        self botsetflag("force_sprint", 0);
      else
        self botsetflag("force_sprint", 1);

      var_00 = self botsetscriptgoal(var_04, 128, var_05);
      self.fireteam_hunt_goalpos = var_04;
    }
  }

  if(!var_00)
    return scripts\mp\bots\bots_personality::bot_random_path_default();

  return var_00;
}

bot_fireteam_monitor_killstreak_earned() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("bot_fireteam_monitor_killstreak_earned");
  self endon("bot_fireteam_monitor_killstreak_earned");

  for(;;) {
    self waittill("bot_killstreak_earned", var_00, var_01);

    if(scripts\mp\utility\game::bot_is_fireteam_mode()) {
      if(isDefined(self) && isbot(self)) {
        if(isDefined(self.fireteam_commander)) {
          var_02 = undefined;

          if(isDefined(self.fireteam_commander.commanding_bot))
            var_02 = self.fireteam_commander.commanding_bot;
          else
            var_02 = self.fireteam_commander getspectatingplayer();

          if(!isDefined(var_02) || var_02 != self)
            self.fireteam_commander thread scripts\mp\hud_message::showsplash(var_00, var_01, self);
        }
      }
    }
  }
}