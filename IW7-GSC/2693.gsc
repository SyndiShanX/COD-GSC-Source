/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2693.gsc
**************************************/

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
  var_0 = level.analyticslog.nextobjectid;
  level.analyticslog.nextobjectid++;
  return var_0;
}

cacheplayeraction(var_0) {
  if(!isDefined(self.analyticslog.cachedactions)) {
    self.analyticslog.cachedactions = 0;
  }

  self.analyticslog.cachedactions = self.analyticslog.cachedactions | var_0;
}

watchforconnectedplayers() {
  if(!analyticsactive()) {
    return;
  }
  for(;;) {
    level waittill("connected", var_0);
    var_0 logevent_playerconnected();
    var_0 thread watchforbasicplayerevents();
    var_0 thread watchforplayermovementevents();
    var_0 thread watchforusermessageevents();
  }
}

watchforbasicplayerevents() {
  self endon("disconnect");

  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return_no_endon_death("adjustedStance", "jumped", "weapon_fired", "reload_start", "spawned_player");

    if(var_0 == "adjustedStance") {
      checkstancestatus();
      continue;
    }

    if(var_0 == "jumped") {
      cacheplayeraction(4);
      continue;
    }

    if(var_0 == "weapon_fired") {
      cacheplayeraction(8);
      continue;
    }

    if(var_0 == "reload_start") {
      cacheplayeraction(16);
      continue;
    }

    if(var_0 == "spawned_player") {
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
    var_0 = scripts\engine\utility::waittill_any_return_no_endon_death("doubleJumpBegin", "doubleJumpEnd", "sprint_slide_begin");

    if(var_0 == "doubleJumpBegin") {
      cacheplayeraction(64);
      continue;
    }

    if(var_0 == "doubleJumpEnd") {
      cacheplayeraction(128);
      continue;
    }

    if(var_0 == "sprint_slide_begin") {
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
    var_0 = scripts\engine\utility::waittill_any_return("log_user_event_end", "log_user_event_generic_event");

    if(isDefined(var_0) && var_0 == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      logevent_message(self.name, self.origin, "Generic User Event");
    }
  }
}

checkstancestatus() {
  var_0 = self getstance();

  if(var_0 == "prone") {
    cacheplayeraction(1);
  } else if(var_0 == "crouch") {
    cacheplayeraction(2);
  }
}

logallplayerposthink() {
  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    var_0 = gettime();
    var_1 = level.players;

    foreach(var_3 in var_1) {
      if(!shouldplayerlogevents(var_3)) {
        continue;
      }
      if(isDefined(var_3) && scripts\mp\utility\game::isreallyalive(var_3)) {
        var_3 logevent_path();
        var_3 logevent_scoreupdate();
        scripts\engine\utility::waitframe();
      }
    }

    wait(max(0.05, 1.5 - (gettime() - var_0) / 1000));
  }
}

getpathactionvalue() {
  var_0 = scripts\engine\utility::ter_op(isDefined(self.analyticslog.cachedactions), self.analyticslog.cachedactions, 0);

  if(self iswallrunning()) {
    var_0 = var_0 | 32;
  }
}

clearpathactionvalue() {
  self.analyticslog.cachedactions = 0;
  checkstancestatus();
}

buildkilldeathactionvalue() {
  var_0 = 0;
  var_1 = self getstance();

  if(var_1 == "prone") {
    var_0 = var_0 | 1;
  } else if(var_1 == "crouch") {
    var_0 = var_0 | 2;
  }

  if(self isjumping()) {
    var_0 = var_0 | 4;
  }

  if(isDefined(self.lastshotfiredtime) && gettime() - self.lastshotfiredtime < 500) {
    var_0 = var_0 | 8;
  }

  if(self getteamsize()) {
    var_0 = var_0 | 16;
  }

  return var_0;
}

buildloadoutstring() {
  var_0 = "archetype=" + self.loadoutarchetype + ";" + "powerPrimary=" + self.var_AE7B + ";" + "powerSecondary=" + self.var_AE7D + ";" + "weaponPrimary\\t =" + scripts\mp\class::buildweaponname(self.loadoutprimary, self.loadoutprimaryattachments, self.loadoutprimarycamo, self.loadoutprimaryreticle) + ";" + "weaponSecondary =" + scripts\mp\class::buildweaponname(self.loadoutsecondary, self.loadoutsecondaryattachments, self.loadoutsecondarycamo, self.loadoutsecondaryreticle) + ";";
  return var_0;
}

buildspawnpointstatestring(var_0) {
  var_1 = "";

  if(isDefined(var_0.lastbucket)) {
    if(isDefined(var_0.lastbucket["allies"])) {
      var_1 = var_1 + ("alliesBucket=" + var_0.lastbucket["allies"] + ";");
    }

    if(isDefined(var_0.lastbucket["axis"])) {
      var_1 = var_1 + ("axisBucket=" + var_0.lastbucket["axis"] + ";");
    }
  }

  return var_1;
}

logevent_path() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_0 = anglesToForward(self getplayerangles());
  bbprint("gamemp_path", "playerid %i x %f y %f z %f gun_orientx %f gun_orienty %f gun_orientz %f action %i health %i", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_0[0], var_0[1], var_0[2], getpathactionvalue(), getsantizedhealth());
  clearpathactionvalue();
}

logevent_playerspawn() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_0 = isDefined(self.lastspawnpoint) && isDefined(self.lastspawnpoint.budgetedents) && self.lastspawnpoint.budgetedents;
  var_1 = anglesToForward(self.angles);
  bbprint("gamemp_spawn_in", "playerid %i x %f y %f z %f orientx %f orienty %f orientz %f loadout %s type %s team %s", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_1[0], var_1[1], var_1[2], buildloadoutstring(), scripts\engine\utility::ter_op(var_0, "Buddy", "Normal"), self.team);
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
  var_0 = scripts\mp\class::cac_getsuper();
  var_1 = self getxuid();
  bbprint("gamemp_player_connect", "playerid %i player_name %s player_xuid %s player_super_name %s", self.analyticslog.playerid, self.name, var_1, var_0);
}

logevent_playerdeath(var_0, var_1, var_2) {
  if(!shouldplayerlogevents(self) || !isplayer(self)) {
    return;
  }
  var_3 = anglesToForward(self getplayerangles());
  var_4 = -1;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = "s";
  var_12 = 0;

  if(isDefined(var_0) && isplayer(var_0)) {
    var_4 = var_0.analyticslog.playerid;

    if(isDefined(var_0.team)) {
      if(var_0.team == "axis") {
        var_11 = "a";
      } else {
        var_11 = "l";
      }
    }

    if(isDefined(var_0.origin)) {
      var_5 = var_0.origin[0];
      var_6 = var_0.origin[1];
      var_7 = var_0.origin[2];
    }

    if(isDefined(var_0.lifeid)) {
      var_12 = var_0.lifeid;
    }

    var_13 = anglesToForward(var_0 getplayerangles());

    if(isDefined(var_13)) {
      var_8 = var_13[0];
      var_9 = var_13[1];
      var_10 = var_13[2];
    }
  }

  var_14 = level.analyticslog.nextdeathid;
  level.analyticslog.nextdeathid++;
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, "None");
  var_15 = "s";

  if(self.team == "axis") {
    var_15 = "a";
  } else {
    var_15 = "l";
  }

  bbprint("gamemp_death", "playerid %i x %f y %f z %f gun_orientx %f gun_orienty %f gun_orientz %f weapon %s mean_of_death %s attackerid %i action %i server_death_id %i victim_life_index %d attacker_life_index %d victim_team %s attacker_team %s attacker_pos_x %f attacker_pos_y %f attacker_pos_z %f attacker_gun_orientx %f attacker_gun_orienty %f attacker_gun_orientz %f victim_weapon %s", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_3[0], var_3[1], var_3[2], var_2, scripts\engine\utility::ter_op(isDefined(var_1), var_1, "None"), var_4, buildkilldeathactionvalue(), var_14, self.lifeid, var_12, var_15, var_11, var_5, var_6, var_7, var_8, var_9, var_10, self.primaryweapon);

  if(isDefined(var_1) && isexplosivedamagemod(var_1)) {
    logevent_explosion(scripts\engine\utility::ter_op(isDefined(var_2), var_2, "generic"), self.origin, var_0, 1.0);
  }

  if(isDefined(self.attackers)) {
    foreach(var_17 in self.attackers) {
      if(isDefined(var_17) && isplayer(var_17) && var_17 != var_0) {
        logevent_assist(var_17.analyticslog.playerid, var_14, var_2);
      }
    }
  }
}

logevent_playerkill(var_0, var_1, var_2) {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_3 = anglesToForward(self getplayerangles());
  bbprint("gamemp_kill", "playerid %i x %f y %f z %f gun_orientx %f gun_orienty %f gun_orientz %f weapon %s mean_of_kill %s victimid %i action %i attacker_health %i victim_pixel_count %i", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_3[0], var_3[1], var_3[2], scripts\engine\utility::ter_op(isDefined(var_2), var_2, "None"), scripts\engine\utility::ter_op(isDefined(var_1), var_1, "None"), scripts\engine\utility::ter_op(isDefined(var_0) && isplayer(var_0), var_0.analyticslog.playerid, "-1"), buildkilldeathactionvalue(), getsantizedhealth(), 0);
}

logevent_explosion(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }
  if(!isDefined(var_4)) {
    var_4 = (1, 0, 0);
  }

  bbprint("gamemp_explosion", "playerid %i x %f y %f z %f orientx %f orienty %f orientz %f duration %i type %s", var_2.analyticslog.playerid, var_1[0], var_1[1], var_1[2], var_4[0], var_4[1], var_4[2], var_3, var_0);
}

logevent_spawnpointupdate() {
  if(!analyticslogenabled()) {
    return;
  }
  if(!isDefined(level.spawnpoints)) {
    return;
  }
  foreach(var_1 in level.spawnpoints) {
    bbprint("gamemp_spawn_point", "x %f y %f z %f allies_score %i axis_score %i allies_max_score %i axis_max_score %i state %s", var_1.origin[0], var_1.origin[1], var_1.origin[2], scripts\engine\utility::ter_op(isDefined(var_1.var_A9E9["allies"]), var_1.var_A9E9["allies"], 0), scripts\engine\utility::ter_op(isDefined(var_1.var_A9E9["axis"]), var_1.var_A9E9["axis"], 0), scripts\engine\utility::ter_op(isDefined(var_1.var_11A3A), var_1.var_11A3A, 0), scripts\engine\utility::ter_op(isDefined(var_1.var_11A3A), var_1.var_11A3A, 0), buildspawnpointstatestring(var_1));
  }
}

logevent_frontlineupdate(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("gamemp_front_line", "startx %f starty %f endx %f endy %f axis_centerx %f axis_centery %f allies_centerx %f allies_centery %f, state %i", var_0[0], var_0[1], var_1[0], var_1[1], var_3[0], var_3[1], var_2[0], var_2[1], var_4);
}

logevent_gameobject(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("gamemp_object", "uniqueid %i x %f y %f z %f ownerid %i type %s state %s", var_1, var_2[0], var_2[1], var_2[2], var_3, var_0, var_4);
}

logevent_message(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("gamemp_message", "ownerid %s x %f y %f z %f message %s", var_0, var_1[0], var_1[1], var_1[2], var_2);
}

logevent_tag(var_0) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("gamemp_matchtags", "message %s", var_0);
}

logevent_powerused(var_0, var_1) {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_2 = anglesToForward(self.angles);
  bbprint("gamemp_power", "ownerid %i x %f y %f z %f orientx %f orienty %f orientz %f type %s state %s", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_2[0], var_2[1], var_2[2], var_0, var_1);
}

logevent_scoreupdate() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_0 = anglesToForward(self.angles);
  bbprint("gamemp_scoreboard", "ownerid %i score %i", self.analyticslog.playerid, self.score);
}

logevent_minimapcorners() {
  if(!analyticslogenabled()) {
    return;
  }
  var_0 = getEntArray("minimap_corner", "targetname");

  if(!isDefined(var_0) || var_0.size != 2) {
    return;
  }
  bbprint("gamemp_map", "cornera_x %f cornera_y %f cornerb_x %f cornerb_y %f north %f", var_0[0].origin[0], var_0[0].origin[1], var_0[1].origin[0], var_0[1].origin[1], getnorthyaw());
}

logevent_assist(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("gamemp_assists", "playerid %i server_death_id %i weapon %s", var_0, var_1, var_2);
}

getsantizedhealth() {
  return int(clamp(self.health, 0, 100000));
}

shouldplayerlogevents(var_0) {
  if(!analyticslogenabled()) {
    return 0;
  }

  if(!isDefined(var_0.team) || var_0.team == "spectator" || var_0.sessionstate != "playing" && var_0.sessionstate != "dead") {
    return 0;
  }

  return 1;
}

logmatchtags() {
  var_0 = getdvar("scr_analytics_tag", "");

  if(var_0 != "") {
    logevent_tag(var_0);
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    logevent_tag("OnlineMatch");
  } else if(getdvarint("xblive_privatematch")) {
    logevent_tag("PrivateMatch");
  } else if(!getdvarint("onlinegame")) {
    logevent_tag("OfflineMatch");
  }
}

logevent_superended(var_0, var_1, var_2, var_3) {
  if(!analyticslogenabled()) {
    return;
  }
  var_4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_4 = self.analyticslog.playerid;
  }

  bbprint("analytics_mp_supers", "super_name %s time_to_use %i num_hits %i num_kills %i player_id %i", var_0, var_1, var_2, var_3, var_4);
}

logevent_superearned(var_0) {
  if(!analyticslogenabled()) {
    return;
  }
  var_1 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_1 = self.analyticslog.playerid;
  }

  bbprint("analytics_mp_super_earned", "match_time %i player_id %i", var_0, var_1);
}

logevent_killstreakearned(var_0, var_1) {
  if(!analyticslogenabled()) {
    return;
  }
  var_2 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_2 = self.analyticslog.playerid;
  }

  bbprint("analytics_mp_killstreak_earned", "killstreak_name %d match_time %i player_id %i", var_0, var_1, var_2);
}

logevent_killstreakavailable(var_0, var_1) {
  if(!analyticslogenabled()) {
    return;
  }
  var_2 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_2 = self.analyticslog.playerid;
  }

  bbprint("analytics_mp_killstreak", "killstreak_name %s time_to_activate %i player_id %i", var_0, var_1, var_2);
}

logevent_awardgained(var_0) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("analytics_mp_awards", "award_message %s", var_0);
}

logevent_giveplayerxp(var_0, var_1, var_2, var_3) {
  if(!analyticslogenabled()) {
    return;
  }
  var_4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_4 = self.analyticslog.playerid;
  }

  bbprint("analytics_mp_player_xp", "current_prestige %d current_level %d xp_gained %d xp_source %s player_id %i", var_0, var_1, var_2, var_3, var_4);
}

logevent_givempweaponxp(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }
  var_5 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_5 = self.analyticslog.playerid;
  }

  bbprint("analytics_mp_weapon_xp", "weapon %s current_prestige %d current_level %d xp_gained %d xp_source %s player_id %i", var_0, var_1, var_2, var_3, var_4, var_5);
}

logevent_sendplayerindexdata() {
  if(!analyticslogenabled()) {
    return;
  }
  var_0 = [];
  var_1 = [];
  var_2 = 0;

  for(var_2 = 0; var_2 < 12; var_2++) {
    var_0[var_2] = 0;
    var_1[var_2] = "";
  }

  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      var_0[var_2] = var_4.analyticslog.playerid;
      var_1[var_2] = var_4 getxuid();
    }

    var_2 = var_2 + 1;
  }

  bbprint("analytics_match_player_index_init", "player1_index %d player1_xuid %s player2_index %d player2_xuid %s player3_index %d player3_xuid %s player4_index %d player4_xuid %s player5_index %d player5_xuid %s player6_index %d player6_xuid %s player7_index %d player7_xuid %s player8_index %d player8_xuid %s player9_index %d player9_xuid %s player10_index %d player10_xuid %s player11_index %d player11_xuid %s player12_index %d player12_xuid %s", var_0[0], var_1[0], var_0[1], var_1[1], var_0[2], var_1[2], var_0[3], var_1[3], var_0[4], var_1[4], var_0[5], var_1[5], var_0[6], var_1[6], var_0[7], var_1[7], var_0[8], var_1[8], var_0[9], var_1[9], var_0[10], var_1[10], var_0[11], var_1[11]);
}

analyticsspawnlogenabled() {
  return getdvarint("enable_analytics_spawn_log") != 0;
}

is_spawnid_a_less_than_b(var_0, var_1) {
  return var_0 < var_1;
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
  var_0 = game["spawnCount"];
  var_1 = game["spawnIdsToBeInstrumented"];
  var_2 = game["nextSpawnToBeInstrumented"];

  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2)) {
    level.spawncount = var_0;
    level.spawnidstobeinstrumented = var_1;
    level.nextspawntobeinstrumented = var_2;
  } else {
    level.spawncount = 0;
    level.spawnidstobeinstrumented = [];
    level.nextspawntobeinstrumented = 0;
    var_3 = getdvarint("analytics_spawn_event_log_count");
    var_4 = analytics_getmaxspawneventsforcurrentmode();
    var_5 = [];

    for(var_6 = 0; var_6 < var_3; var_6++) {
      var_7 = randomintrange(20, var_4);

      if(isDefined(var_5[var_7])) {
        level.spawnidstobeinstrumented[var_6] = -1;
        continue;
      }

      var_5[var_7] = 1;
      level.spawnidstobeinstrumented[var_6] = var_7;
    }

    level.spawnidstobeinstrumented = scripts\engine\utility::array_sort_with_func(level.spawnidstobeinstrumented, ::is_spawnid_a_less_than_b);
  }
}

analyticssend_shouldsenddata(var_0) {
  if(isDefined(level.nextspawntobeinstrumented) && isDefined(level.spawnidstobeinstrumented)) {
    if(level.nextspawntobeinstrumented < level.spawnidstobeinstrumented.size) {
      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == -1) {
        level.nextspawntobeinstrumented++;
      }

      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == var_0) {
        level.nextspawntobeinstrumented++;
        return 1;
      }
    }
  }

  return 0;
}

analyticssend_spawntype(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\spawnfactor::getglobalfrontlineinfo();
  var_5 = var_4.midpoint;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;

  if(isDefined(var_5)) {
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_8 = var_5[2];
  }

  var_9 = 0;

  if(isDefined(var_4.teamdiffyaw)) {
    var_9 = var_4.teamdiffyaw;
  }

  var_10 = var_4.isactive[var_1];
  var_11 = 0;

  if(isDefined(var_4.disabledreason) && isDefined(var_4.disabledreason[var_1])) {
    var_11 = var_4.disabledreason[var_1];
  }

  var_12 = level.spawnglobals.logicvariantid;
  var_13 = 0;

  if(isDefined(level.spawnglobals.buddyspawnid)) {
    var_13 = level.spawnglobals.buddyspawnid;
    level.spawnglobals.buddyspawnid = 0;
  }

  bbreportspawntypes(var_6, var_7, var_8, var_9, var_3, var_10, var_11, var_2, var_12, var_13);
}

analyticssend_spawnplayerdetails(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(scripts\mp\utility\game::isreallyalive(var_4)) {
      var_5 = var_4 getplayerangles();
      var_6 = vectortoyaw(var_5);
      var_7 = var_4.origin[0];
      var_8 = var_4.origin[1];
      var_9 = var_4.origin[2];
      var_10 = 0;

      if(var_4 == var_0) {
        var_10 = 1;
      }

      var_11 = 0;

      if(isDefined(var_0.lastattacker) && var_0.lastattacker == var_4) {
        var_11 = 1;
      }

      var_12 = 0;

      if(var_4.team == "axis") {
        var_12 = 1;
      } else if(var_4.team == "allies") {
        var_12 = 2;
      }

      var_13 = 0;

      if(isDefined(var_4.analyticslog.playerid)) {
        var_13 = var_4.analyticslog.playerid;
      }

      bbreportspawnplayerdetails(var_2, var_6, var_7, var_8, var_9, var_13, var_12, var_10, var_11);
    }
  }
}

analyticssend_spawnfactors(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level.spawnglobals.spawnpointslist) {
    var_6 = var_5.totalscore;
    var_7 = var_5.analytics.allyaveragedist;
    var_8 = var_5.analytics.enemyaveragedist;
    var_9 = var_5.analytics.timesincelastspawn;
    var_10 = 0;

    if(isDefined(var_0.lastspawnpoint) && var_0.lastspawnpoint == var_5) {
      var_10 = 1;
    }

    var_11 = 0;

    if(var_3 == var_5) {
      var_11 = 1;
    }

    var_12 = var_5.analytics.maxenemysightfraction;
    var_13 = var_5.analytics.randomscore;
    var_14 = var_5.analytics.spawnusedbyenemies;
    var_15 = 0;

    if(var_5.lastspawnteam == "axis") {
      var_15 = 1;
    } else if(var_5.lastspawnteam == "allies") {
      var_15 = 2;
    }

    var_16 = var_5.lastspawntime;
    var_17 = var_5.analytics.maxjumpingenemysightfraction;
    var_18 = 0;

    if(isDefined(var_5.index) && var_5.index <= 1023) {
      var_18 = var_5.index;
    }

    var_19 = 0;

    if(isDefined(var_5.analytics) && isDefined(var_5.analytics.spawntype)) {
      var_19 = var_5.analytics.spawntype;
    }

    var_20 = 0;

    if(isDefined(var_5.badspawnreason)) {
      var_20 = var_5.badspawnreason;
    }

    bbreportspawnfactors(2, var_6, var_12, var_17, var_13, var_2, var_7, var_8, var_11, var_10, var_15, var_18, var_14, var_9, var_19, var_20);
  }
}

analytics_getmaxspawneventsforcurrentmode() {
  var_0 = 120;

  if(isDefined(level.gametype)) {
    if(level.gametype == "war") {
      var_0 = 120;
    } else if(level.gametype == "dom") {
      var_0 = 120;
    } else if(level.gametype == "conf") {
      var_0 = 120;
    } else if(level.gametype == "front") {
      var_0 = 40;
    } else if(level.gametype == "sd") {
      var_0 = 50;
    } else if(level.gametype == "dm") {
      var_0 = 50;
    } else if(level.gametype == "koth") {
      var_0 = 125;
    } else if(level.gametype == "ctf") {
      var_0 = 50;
    } else if(level.gametype == "tdef") {
      var_0 = 75;
    } else if(level.gametype == "siege") {
      var_0 = 25;
    } else if(level.gametype == "gun") {
      var_0 = 50;
    } else if(level.gametype == "sr") {
      var_0 = 25;
    } else if(level.gametype == "grind") {
      var_0 = 75;
    } else if(level.gametype == "ball") {
      var_0 = 50;
    }
  }

  return var_0;
}

logevent_reportgamescore(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }
  var_3 = 1;

  if(!isDefined(var_2)) {
    var_2 = -1;
  }

  bbprint("analytics_mp_score_event", "score_type %d score_points %d score_eventid %d game_time %d player_id %d", var_3, var_0, var_2, var_1, self.analyticslog.playerid);
}

logevent_reportstreakscore(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }
  var_3 = 2;

  if(!isDefined(var_2)) {
    var_2 = -1;
  }

  bbprint("analytics_mp_score_event", "score_type %d score_points %d score_eventid %d game_time %d player_id %d", var_3, var_0, var_2, var_1, self.analyticslog.playerid);
}

logevent_reportsuperscore(var_0, var_1) {
  if(!analyticslogenabled()) {
    return;
  }
  var_2 = 3;
  bbprint("analytics_mp_score_event", "score_type %d score_points %d game_time %d player_id %d", var_2, var_0, var_1, self.analyticslog.playerid);
}