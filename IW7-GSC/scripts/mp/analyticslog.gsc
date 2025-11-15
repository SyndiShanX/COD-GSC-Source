/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\analyticslog.gsc
***************************************/

init() {
  setdvarifuninitialized("enable_analytics_log", 0);
  level.analyticslog = spawnStruct();
  level.analyticslog.nextplayerid = 0;
  level.analyticslog.nextobjectid = 0;
  level.analyticslog.nextdeathid = 0;
  if(!analyticsactive()) {
    return;
  }

  thread watchforconnectedplayers();
  if(analyticslogenabled()) {
    thread logmatchtags();
    thread logallplayerposthink();
    thread logevent_minimapcorners();
  }
}

analyticsactive() {
  if(analyticsspawnlogenabled()) {
    return 1;
  }

  if(analyticslogenabled()) {
    return 1;
  }

  return 0;
}

analyticslogenabled() {
  return getdvarint("enable_analytics_log") == 1;
}

getuniqueobjectid() {
  var_00 = level.analyticslog.nextobjectid;
  level.analyticslog.nextobjectid++;
  return var_00;
}

cacheplayeraction(param_00) {
  if(!isDefined(self.analyticslog.cachedactions)) {
    self.analyticslog.cachedactions = 0;
  }

  self.analyticslog.cachedactions = self.analyticslog.cachedactions | param_00;
}

watchforconnectedplayers() {
  if(!analyticsactive()) {
    return;
  }

  for(;;) {
    level waittill("connected", var_00);
    var_00 logevent_playerconnected();
    var_00 thread watchforbasicplayerevents();
    var_00 thread watchforplayermovementevents();
    var_00 thread watchforusermessageevents();
  }
}

watchforbasicplayerevents() {
  self endon("disconnect");
  if(!analyticslogenabled()) {
    return;
  }

  for(;;) {
    var_00 = scripts\engine\utility::waittill_any_return_no_endon_death_3("adjustedStance", "jumped", "weapon_fired", "reload_start", "spawned_player");
    if(var_00 == "adjustedStance") {
      checkstancestatus();
      continue;
    }

    if(var_00 == "jumped") {
      cacheplayeraction(4);
      continue;
    }

    if(var_00 == "weapon_fired") {
      cacheplayeraction(8);
      continue;
    }

    if(var_00 == "reload_start") {
      cacheplayeraction(16);
      continue;
    }

    if(var_00 == "spawned_player") {
      thread logevent_playerspawn();
      thread logevent_spawnpointupdate();
    }
  }
}

watchforplayermovementevents() {
  self endon("disconnect");
  if(!analyticslogenabled()) {
    return;
  }

  for(;;) {
    var_00 = scripts\engine\utility::waittill_any_return_no_endon_death_3("doubleJumpBegin", "doubleJumpEnd", "sprint_slide_begin");
    if(var_00 == "doubleJumpBegin") {
      cacheplayeraction(64);
      continue;
    }

    if(var_00 == "doubleJumpEnd") {
      cacheplayeraction(128);
      continue;
    }

    if(var_00 == "sprint_slide_begin") {
      cacheplayeraction(256);
    }
  }
}

watchforusermessageevents() {
  self endon("disconnect");
  if(isai(self)) {
    return;
  }

  if(getdvarint("scr_playtest", 0) == 0) {
    return;
  }

  self notifyonplayercommand("log_user_event_start", "+actionslot 3");
  self notifyonplayercommand("log_user_event_end", "-actionslot 3");
  self notifyonplayercommand("log_user_event_generic_event", "+gostand");
  for(;;) {
    self waittill("log_user_event_start");
    var_00 = scripts\engine\utility::waittill_any_return("log_user_event_end", "log_user_event_generic_event");
    if(isDefined(var_00) && var_00 == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      logevent_message(self.name, self.origin, "Generic User Event");
    }
  }
}

checkstancestatus() {
  var_00 = self getstance();
  if(var_00 == "prone") {
    cacheplayeraction(1);
    return;
  }

  if(var_00 == "crouch") {
    cacheplayeraction(2);
  }
}

logallplayerposthink() {
  if(!analyticslogenabled()) {
    return;
  }

  for(;;) {
    var_00 = gettime();
    var_01 = level.players;
    foreach(var_03 in var_01) {
      if(!shouldplayerlogevents(var_03)) {
        continue;
      }

      if(isDefined(var_03) && scripts\mp\utility::isreallyalive(var_03)) {
        var_03 logevent_path();
        var_03 logevent_scoreupdate();
        scripts\engine\utility::waitframe();
      }
    }

    wait(max(0.05, 1.5 - gettime() - var_00 / 1000));
  }
}

getpathactionvalue() {
  var_00 = scripts\engine\utility::ter_op(isDefined(self.analyticslog.cachedactions), self.analyticslog.cachedactions, 0);
  if(self iswallrunning()) {
    var_00 = var_00 | 32;
  }
}

clearpathactionvalue() {
  self.analyticslog.cachedactions = 0;
  checkstancestatus();
}

buildkilldeathactionvalue() {
  var_00 = 0;
  var_01 = self getstance();
  if(var_01 == "prone") {
    var_00 = var_00 | 1;
  } else if(var_01 == "crouch") {
    var_00 = var_00 | 2;
  }

  if(self isjumping()) {
    var_00 = var_00 | 4;
  }

  if(isDefined(self.lastshotfiredtime) && gettime() - self.lastshotfiredtime < 500) {
    var_00 = var_00 | 8;
  }

  if(self getteamsize()) {
    var_00 = var_00 | 16;
  }

  return var_00;
}

buildloadoutstring() {
  var_00 = "archetype=" + self.loadoutarchetype + ";" + "powerPrimary=" + self.var_AE7B + ";" + "powerSecondary=" + self.var_AE7D + ";" + "weaponPrimary\t =" + scripts\mp\class::buildweaponname(self.loadoutprimary, self.loadoutprimaryattachments, self.loadoutprimarycamo, self.loadoutprimaryreticle) + ";" + "weaponSecondary =" + scripts\mp\class::buildweaponname(self.loadoutsecondary, self.loadoutsecondaryattachments, self.loadoutsecondarycamo, self.loadoutsecondaryreticle) + ";";
  return var_00;
}

buildspawnpointstatestring(param_00) {
  var_01 = "";
  if(isDefined(param_00.lastbucket)) {
    if(isDefined(param_00.lastbucket["allies"])) {
      var_01 = var_01 + "alliesBucket=" + param_00.lastbucket["allies"] + ";";
    }

    if(isDefined(param_00.lastbucket["axis"])) {
      var_01 = var_01 + "axisBucket=" + param_00.lastbucket["axis"] + ";";
    }
  }

  return var_01;
}

logevent_path() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_00 = anglesToForward(self getplayerangles());
  bbprint("gamemp_path", "playerid %i x %f y %f z %f gun_orientx %f gun_orienty %f gun_orientz %f action %i health %i", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_00[0], var_00[1], var_00[2], getpathactionvalue(), getsantizedhealth());
  clearpathactionvalue();
}

logevent_playerspawn() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_00 = isDefined(self.lastspawnpoint) && isDefined(self.lastspawnpoint.budgetedents) && self.lastspawnpoint.budgetedents;
  var_01 = anglesToForward(self.angles);
  bbprint("gamemp_spawn_in", "playerid %i x %f y %f z %f orientx %f orienty %f orientz %f loadout %s type %s team %s", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_01[0], var_01[1], var_01[2], buildloadoutstring(), scripts\engine\utility::ter_op(var_00, "Buddy", "Normal"), self.team);
}

logevent_playerconnected() {
  if(!analyticsactive()) {
    return;
  }

  if(!isDefined(self.analyticslog)) {
    self.analyticslog = spawnStruct();
  }

  self.analyticslog.playerid = level.analyticslog.nextplayerid;
  level.analyticslog.nextplayerid++;
  if(!analyticslogenabled()) {
    return;
  }

  var_00 = scripts\mp\class::cac_getsuper();
  var_01 = self getxuid();
  bbprint("gamemp_player_connect", "playerid %i player_name %s player_xuid %s player_super_name %s", self.analyticslog.playerid, self.name, var_01, var_00);
}

logevent_playerdeath(param_00, param_01, param_02) {
    if(!shouldplayerlogevents(self) || !isplayer(self)) {
      return;
    }

    var_03 = anglesToForward(self getplayerangles());
    var_04 = -1;
    var_05 = 0;
    var_06 = 0;
    var_07 = 0;
    var_08 = 0;
    var_09 = 0;
    var_0A = 0;
    var_0B = "s";
    var_0C = 0;
    if(isDefined(param_00) && isplayer(param_00)) {
      var_04 = param_00.analyticslog.playerid;
      if(isDefined(param_00.team)) {
        if(param_00.team == "axis") {
          var_0B = "a";
        } else {
          var_0B = "l";
        }
      }

      if(isDefined(param_00.origin)) {
        var_05 = param_00.origin[0];
        var_06 = param_00.origin[1];
        var_07 = param_00.origin[2];
      }

      if(isDefined(param_00.lifeid)) {
        var_0C = param_00.lifeid;
      }

      var_0D = anglesToForward(param_00 getplayerangles());
      if(isDefined(var_0D)) {
        var_08 = var_0D[0];
        var_09 = var_0D[1];
        var_0A = var_0D[2];
      }
    }

    var_0E = level.analyticslog.nextdeathid;
    level.analyticslog.nextdeathid++;
    param_02 = scripts\engine\utility::ter_op(isDefined(param_02), param_02, "None");
    var_0F = "s";
    if(self.team == "axis") {
      var_0F = "a";
    } else {
      var_0F = "l";
    }

    bbprint("gamemp_death", "@"
      playerid % i x % f y % f z % f gun_orientx % f gun_orienty % f gun_orientz % f weapon % s mean_of_death % s attackerid % i action % i server_death_id % i victim_life_index % d attacker_life_index % d victim_team % s attacker_team % s attacker_pos_x % f attacker_pos_y % f attacker_pos_z % f attacker_gun_orientx % f attacker_gun_orienty % f attacker_gun_orientz % f victim_weapon % s ",self.analyticslog.playerid,self.origin[0],self.origin[1],self.origin[2],var_03[0],var_03[1],var_03[2],param_02,scripts\engine\utility::ter_op(isDefined(param_01),param_01,"
      None "),var_04,buildkilldeathactionvalue(),var_0E,self.lifeid,var_0C,var_0F,var_0B,var_05,var_06,var_07,var_08,var_09,var_0A,self.primaryweapon);
      if(isDefined(param_01) && isexplosivedamagemod(param_01)) {
        logevent_explosion(scripts\engine\utility::ter_op(isDefined(param_02), param_02, "generic"), self.origin, param_00, 1);
      }

      if(isDefined(self.attackers)) {
        foreach(var_11 in self.attackers) {
          if(isDefined(var_11) && isplayer(var_11) && var_11 != param_00) {
            logevent_assist(var_11.analyticslog.playerid, var_0E, param_02);
          }
        }
      }
    }

    logevent_playerkill(param_00, param_01, param_02) {
      if(!shouldplayerlogevents(self)) {
        return;
      }

      var_03 = anglesToForward(self getplayerangles());
      bbprint("gamemp_kill", "playerid %i x %f y %f z %f gun_orientx %f gun_orienty %f gun_orientz %f weapon %s mean_of_kill %s victimid %i action %i attacker_health %i victim_pixel_count %i", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_03[0], var_03[1], var_03[2], scripts\engine\utility::ter_op(isDefined(param_02), param_02, "None"), scripts\engine\utility::ter_op(isDefined(param_01), param_01, "None"), scripts\engine\utility::ter_op(isDefined(param_00) && isplayer(param_00), param_00.analyticslog.playerid, "-1"), buildkilldeathactionvalue(), getsantizedhealth(), 0);
    }

    logevent_explosion(param_00, param_01, param_02, param_03, param_04) {
      if(!analyticslogenabled()) {
        return;
      }

      if(!isDefined(param_04)) {
        param_04 = (1, 0, 0);
      }

      bbprint("gamemp_explosion", "playerid %i x %f y %f z %f orientx %f orienty %f orientz %f duration %i type %s", param_02.analyticslog.playerid, param_01[0], param_01[1], param_01[2], param_04[0], param_04[1], param_04[2], param_03, param_00);
    }

    logevent_spawnpointupdate() {
      if(!analyticslogenabled()) {
        return;
      }

      if(!isDefined(level.spawnpoints)) {
        return;
      }

      foreach(var_01 in level.spawnpoints) {
        bbprint("gamemp_spawn_point", "x %f y %f z %f allies_score %i axis_score %i allies_max_score %i axis_max_score %i state %s", var_01.origin[0], var_01.origin[1], var_01.origin[2], scripts\engine\utility::ter_op(isDefined(var_01.var_A9E9["allies"]), var_01.var_A9E9["allies"], 0), scripts\engine\utility::ter_op(isDefined(var_01.var_A9E9["axis"]), var_01.var_A9E9["axis"], 0), scripts\engine\utility::ter_op(isDefined(var_01.var_11A3A), var_01.var_11A3A, 0), scripts\engine\utility::ter_op(isDefined(var_01.var_11A3A), var_01.var_11A3A, 0), buildspawnpointstatestring(var_01));
      }
    }

    logevent_frontlineupdate(param_00, param_01, param_02, param_03, param_04) {
      if(!analyticslogenabled()) {
        return;
      }

      bbprint("gamemp_front_line", "startx %f starty %f endx %f endy %f axis_centerx %f axis_centery %f allies_centerx %f allies_centery %f, state %i", param_00[0], param_00[1], param_01[0], param_01[1], param_03[0], param_03[1], param_02[0], param_02[1], param_04);
    }

    logevent_gameobject(param_00, param_01, param_02, param_03, param_04) {
      if(!analyticslogenabled()) {
        return;
      }

      bbprint("gamemp_object", "uniqueid %i x %f y %f z %f ownerid %i type %s state %s", param_01, param_02[0], param_02[1], param_02[2], param_03, param_00, param_04);
    }

    logevent_message(param_00, param_01, param_02) {
      if(!analyticslogenabled()) {
        return;
      }

      bbprint("gamemp_message", "ownerid %s x %f y %f z %f message %s", param_00, param_01[0], param_01[1], param_01[2], param_02);
    }

    logevent_tag(param_00) {
      if(!analyticslogenabled()) {
        return;
      }

      bbprint("gamemp_matchtags", "message %s", param_00);
    }

    logevent_powerused(param_00, param_01) {
      if(!shouldplayerlogevents(self)) {
        return;
      }

      var_02 = anglesToForward(self.angles);
      bbprint("gamemp_power", "ownerid %i x %f y %f z %f orientx %f orienty %f orientz %f type %s state %s", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_02[0], var_02[1], var_02[2], param_00, param_01);
    }

    logevent_scoreupdate() {
      if(!shouldplayerlogevents(self)) {
        return;
      }

      var_00 = anglesToForward(self.angles);
      bbprint("gamemp_scoreboard", "ownerid %i score %i", self.analyticslog.playerid, self.destroynavrepulsor);
    }

    logevent_minimapcorners() {
      if(!analyticslogenabled()) {
        return;
      }

      var_00 = getEntArray("minimap_corner", "targetname");
      if(!isDefined(var_00) || var_00.size != 2) {
        return;
      }

      bbprint("gamemp_map", "cornera_x %f cornera_y %f cornerb_x %f cornerb_y %f north %f", var_00[0].origin[0], var_00[0].origin[1], var_00[1].origin[0], var_00[1].origin[1], getnorthyaw());
    }

    logevent_assist(param_00, param_01, param_02) {
      if(!analyticslogenabled()) {
        return;
      }

      bbprint("gamemp_assists", "playerid %i server_death_id %i weapon %s", param_00, param_01, param_02);
    }

    getsantizedhealth() {
      return int(clamp(self.health, 0, 100000));
    }

    shouldplayerlogevents(param_00) {
      if(!analyticslogenabled()) {
        return 0;
      }

      if(!isDefined(param_00.team) || param_00.team == "spectator" || param_00.sessionstate != "playing" && param_00.sessionstate != "dead") {
        return 0;
      }

      return 1;
    }

    logmatchtags() {
      var_00 = getdvar("scr_analytics_tag", "");
      if(var_00 != "") {
        logevent_tag(var_00);
      }

      if(scripts\mp\utility::matchmakinggame()) {
        logevent_tag("OnlineMatch");
        return;
      }

      if(getdvarint("xblive_privatematch")) {
        logevent_tag("PrivateMatch");
        return;
      }

      if(!getdvarint("onlinegame")) {
        logevent_tag("OfflineMatch");
        return;
      }
    }

    logevent_superended(param_00, param_01, param_02, param_03) {
      if(!analyticslogenabled()) {
        return;
      }

      var_04 = -1;
      if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
        var_04 = self.analyticslog.playerid;
      }

      bbprint("analytics_mp_supers", "super_name %s time_to_use %i num_hits %i num_kills %i player_id %i", param_00, param_01, param_02, param_03, var_04);
    }

    logevent_superearned(param_00) {
      if(!analyticslogenabled()) {
        return;
      }

      var_01 = -1;
      if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
        var_01 = self.analyticslog.playerid;
      }

      bbprint("analytics_mp_super_earned", "match_time %i player_id %i", param_00, var_01);
    }

    logevent_killstreakearned(param_00, param_01) {
      if(!analyticslogenabled()) {
        return;
      }

      var_02 = -1;
      if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
        var_02 = self.analyticslog.playerid;
      }

      bbprint("analytics_mp_killstreak_earned", "killstreak_name %d match_time %i player_id %i", param_00, param_01, var_02);
    }

    logevent_killstreakavailable(param_00, param_01) {
      if(!analyticslogenabled()) {
        return;
      }

      var_02 = -1;
      if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
        var_02 = self.analyticslog.playerid;
      }

      bbprint("analytics_mp_killstreak", "killstreak_name %s time_to_activate %i player_id %i", param_00, param_01, var_02);
    }

    logevent_awardgained(param_00) {
      if(!analyticslogenabled()) {
        return;
      }

      bbprint("analytics_mp_awards", "award_message %s", param_00);
    }

    logevent_giveplayerxp(param_00, param_01, param_02, param_03) {
      if(!analyticslogenabled()) {
        return;
      }

      var_04 = -1;
      if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
        var_04 = self.analyticslog.playerid;
      }

      bbprint("analytics_mp_player_xp", "current_prestige %d current_level %d xp_gained %d xp_source %s player_id %i", param_00, param_01, param_02, param_03, var_04);
    }

    logevent_givempweaponxp(param_00, param_01, param_02, param_03, param_04) {
      if(!analyticslogenabled()) {
        return;
      }

      var_05 = -1;
      if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
        var_05 = self.analyticslog.playerid;
      }

      bbprint("analytics_mp_weapon_xp", "weapon %s current_prestige %d current_level %d xp_gained %d xp_source %s player_id %i", param_00, param_01, param_02, param_03, param_04, var_05);
    }

    logevent_sendplayerindexdata() {
        if(!analyticslogenabled()) {
          return;
        }

        var_00 = [];
        var_01 = [];
        var_02 = 0;
        for(var_02 = 0; var_02 < 12; var_02++) {
          var_00[var_02] = 0;
          var_01[var_02] = "";
        }

        var_02 = 0;
        foreach(var_04 in level.players) {
          if(!isai(var_04)) {
            var_00[var_02] = var_04.analyticslog.playerid;
            var_01[var_02] = var_04 getxuid();
          }

          var_02 = var_02 + 1;
        }

        bbprint("analytics_match_player_index_init", "@"
          player1_index % d player1_xuid % s player2_index % d player2_xuid % s player3_index % d player3_xuid % s player4_index % d player4_xuid % s player5_index % d player5_xuid % s player6_index % d player6_xuid % s player7_index % d player7_xuid % s player8_index % d player8_xuid % s player9_index % d player9_xuid % s player10_index % d player10_xuid % s player11_index % d player11_xuid % s player12_index % d player12_xuid % s ",var_00[0],var_01[0],var_00[1],var_01[1],var_00[2],var_01[2],var_00[3],var_01[3],var_00[4],var_01[4],var_00[5],var_01[5],var_00[6],var_01[6],var_00[7],var_01[7],var_00[8],var_01[8],var_00[9],var_01[9],var_00[10],var_01[10],var_00[11],var_01[11]);
        }

        analyticsspawnlogenabled() {
          return getdvarint("enable_analytics_spawn_log") != 0;
        }

        is_spawnid_a_less_than_b(param_00, param_01) {
          return param_00 < param_01;
        }

        analyticsstorespawndata() {
          if(isDefined(level.spawncount) && isDefined(level.spawnidstobeinstrumented) && isDefined(level.nextspawntobeinstrumented)) {
            game["spawnCount"] = level.spawncount;
            game["spawnIdsToBeInstrumented"] = level.spawnidstobeinstrumented;
            game["nextSpawnToBeInstrumented"] = level.nextspawntobeinstrumented;
          }
        }

        analyticsdoesspawndataexist() {
          if(isDefined(level.spawncount) && isDefined(level.spawnidstobeinstrumented) && isDefined(level.nextspawntobeinstrumented)) {
            return 1;
          }

          return 0;
        }

        analyticsinitspawndata() {
          var_00 = game["spawnCount"];
          var_01 = game["spawnIdsToBeInstrumented"];
          var_02 = game["nextSpawnToBeInstrumented"];
          if(isDefined(var_00) && isDefined(var_01) && isDefined(var_02)) {
            level.spawncount = var_00;
            level.spawnidstobeinstrumented = var_01;
            level.nextspawntobeinstrumented = var_02;
            return;
          }

          level.spawncount = 0;
          level.spawnidstobeinstrumented = [];
          level.nextspawntobeinstrumented = 0;
          var_03 = getdvarint("analytics_spawn_event_log_count");
          var_04 = analytics_getmaxspawneventsforcurrentmode();
          var_05 = [];
          for(var_06 = 0; var_06 < var_03; var_06++) {
            var_07 = randomintrange(20, var_04);
            if(isDefined(var_05[var_07])) {
              level.spawnidstobeinstrumented[var_06] = -1;
              continue;
            }

            var_05[var_07] = 1;
            level.spawnidstobeinstrumented[var_06] = var_07;
          }

          level.spawnidstobeinstrumented = scripts\engine\utility::array_sort_with_func(level.spawnidstobeinstrumented, ::is_spawnid_a_less_than_b);
        }

        analyticssend_shouldsenddata(param_00) {
          if(isDefined(level.nextspawntobeinstrumented) && isDefined(level.spawnidstobeinstrumented)) {
            if(level.nextspawntobeinstrumented < level.spawnidstobeinstrumented.size) {
              if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == -1) {
                level.nextspawntobeinstrumented++;
              }

              if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == param_00) {
                level.nextspawntobeinstrumented++;
                return 1;
              }
            }
          }

          return 0;
        }

        analyticssend_spawntype(param_00, param_01, param_02, param_03) {
          var_04 = scripts\mp\spawnfactor::getglobalfrontlineinfo();
          var_05 = var_04.midpoint;
          var_06 = 0;
          var_07 = 0;
          var_08 = 0;
          if(isDefined(var_05)) {
            var_06 = var_05[0];
            var_07 = var_05[1];
            var_08 = var_05[2];
          }

          var_09 = 0;
          if(isDefined(var_04.teamdiffyaw)) {
            var_09 = var_04.teamdiffyaw;
          }

          var_0A = var_04.isactive[param_01];
          var_0B = 0;
          if(isDefined(var_04.disabledreason) && isDefined(var_04.disabledreason[param_01])) {
            var_0B = var_04.disabledreason[param_01];
          }

          var_0C = level.spawnglobals.logicvariantid;
          var_0D = 0;
          if(isDefined(level.spawnglobals.buddyspawnid)) {
            var_0D = level.spawnglobals.buddyspawnid;
            level.spawnglobals.buddyspawnid = 0;
          }

          bbreportspawntypes(var_06, var_07, var_08, var_09, param_03, var_0A, var_0B, param_02, var_0C, var_0D);
        }

        analyticssend_spawnplayerdetails(param_00, param_01, param_02) {
          foreach(var_04 in level.players) {
            if(scripts\mp\utility::isreallyalive(var_04)) {
              var_05 = var_04 getplayerangles();
              var_06 = vectortoyaw(var_05);
              var_07 = var_04.origin[0];
              var_08 = var_04.origin[1];
              var_09 = var_04.origin[2];
              var_0A = 0;
              if(var_04 == param_00) {
                var_0A = 1;
              }

              var_0B = 0;
              if(isDefined(param_00.sethalfresparticles) && param_00.sethalfresparticles == var_04) {
                var_0B = 1;
              }

              var_0C = 0;
              if(var_04.team == "axis") {
                var_0C = 1;
              } else if(var_04.team == "allies") {
                var_0C = 2;
              }

              var_0D = 0;
              if(isDefined(var_04.analyticslog.playerid)) {
                var_0D = var_04.analyticslog.playerid;
              }

              bbreportspawnplayerdetails(param_02, var_06, var_07, var_08, var_09, var_0D, var_0C, var_0A, var_0B);
            }
          }
        }

        analyticssend_spawnfactors(param_00, param_01, param_02, param_03) {
          foreach(var_05 in level.spawnglobals.spawnpointslist) {
            var_06 = var_05.totalscore;
            var_07 = var_05.analytics.allyaveragedist;
            var_08 = var_05.analytics.enemyaveragedist;
            var_09 = var_05.analytics.timesincelastspawn;
            var_0A = 0;
            if(isDefined(param_00.lastspawnpoint) && param_00.lastspawnpoint == var_05) {
              var_0A = 1;
            }

            var_0B = 0;
            if(param_03 == var_05) {
              var_0B = 1;
            }

            var_0C = var_05.analytics.maxenemysightfraction;
            var_0D = var_05.analytics.randomscore;
            var_0E = var_05.analytics.spawnusedbyenemies;
            var_0F = 0;
            if(var_05.lastspawnteam == "axis") {
              var_0F = 1;
            } else if(var_05.lastspawnteam == "allies") {
              var_0F = 2;
            }

            var_10 = var_05.lastspawntime;
            var_11 = var_05.analytics.maxjumpingenemysightfraction;
            var_12 = 0;
            if(isDefined(var_05.index) && var_05.index <= 1023) {
              var_12 = var_05.index;
            }

            var_13 = 0;
            if(isDefined(var_05.analytics) && isDefined(var_05.analytics.spawntype)) {
              var_13 = var_05.analytics.spawntype;
            }

            var_14 = 0;
            if(isDefined(var_05.badspawnreason)) {
              var_14 = var_05.badspawnreason;
            }

            bbreportspawnfactors(2, var_06, var_0C, var_11, var_0D, param_02, var_07, var_08, var_0B, var_0A, var_0F, var_12, var_0E, var_09, var_13, var_14);
          }
        }

        analytics_getmaxspawneventsforcurrentmode() {
          var_00 = 120;
          if(isDefined(level.gametype)) {
            if(level.gametype == "war") {
              var_00 = 120;
            } else if(level.gametype == "dom") {
              var_00 = 120;
            } else if(level.gametype == "conf") {
              var_00 = 120;
            } else if(level.gametype == "front") {
              var_00 = 40;
            } else if(level.gametype == "sd") {
              var_00 = 50;
            } else if(level.gametype == "dm") {
              var_00 = 50;
            } else if(level.gametype == "koth") {
              var_00 = 125;
            } else if(level.gametype == "ctf") {
              var_00 = 50;
            } else if(level.gametype == "tdef") {
              var_00 = 75;
            } else if(level.gametype == "siege") {
              var_00 = 25;
            } else if(level.gametype == "gun") {
              var_00 = 50;
            } else if(level.gametype == "sr") {
              var_00 = 25;
            } else if(level.gametype == "grind") {
              var_00 = 75;
            } else if(level.gametype == "ball") {
              var_00 = 50;
            }
          }

          return var_00;
        }

        logevent_reportgamescore(param_00, param_01, param_02) {
          if(!analyticslogenabled()) {
            return;
          }

          var_03 = 1;
          if(!isDefined(param_02)) {
            param_02 = -1;
          }

          bbprint("analytics_mp_score_event", "score_type %d score_points %d score_eventid %d game_time %d player_id %d", var_03, param_00, param_02, param_01, self.analyticslog.playerid);
        }

        logevent_reportstreakscore(param_00, param_01, param_02) {
          if(!analyticslogenabled()) {
            return;
          }

          var_03 = 2;
          if(!isDefined(param_02)) {
            param_02 = -1;
          }

          bbprint("analytics_mp_score_event", "score_type %d score_points %d score_eventid %d game_time %d player_id %d", var_03, param_00, param_02, param_01, self.analyticslog.playerid);
        }

        logevent_reportsuperscore(param_00, param_01) {
          if(!analyticslogenabled()) {
            return;
          }

          var_02 = 3;
          bbprint("analytics_mp_score_event", "score_type %d score_points %d game_time %d player_id %d", var_02, param_00, param_01, self.analyticslog.playerid);
        }