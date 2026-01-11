/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2693.gsc
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

cacheplayeraction(var_00) {
  if(!isDefined(self.analyticslog.cachedactions)) {
    self.analyticslog.cachedactions = 0;
  }

  self.analyticslog.cachedactions = self.analyticslog.cachedactions | var_00;
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
    var_00 = scripts\engine\utility::waittill_any_return_no_endon_death("adjustedStance", "jumped", "weapon_fired", "reload_start", "spawned_player");

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
    var_00 = scripts\engine\utility::waittill_any_return_no_endon_death("doubleJumpBegin", "doubleJumpEnd", "sprint_slide_begin");

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
  }
  else if(var_00 == "crouch") {
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
      if(isDefined(var_03) && scripts\mp\utility\game::isreallyalive(var_03)) {
        var_03 logevent_path();
        var_03 logevent_scoreupdate();
        scripts\engine\utility::waitframe();
      }
    }

    wait(max(0.05, 1.5 - (gettime() - var_00) / 1000));
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
  }
  else if(var_01 == "crouch") {
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
  var_00 = "archetype=" + self.loadoutarchetype + ";" + "powerPrimary=" + self.func_AE7B + ";" + "powerSecondary=" + self.func_AE7D + ";" + "weaponPrimary\\t =" + scripts\mp\class::buildweaponname(self.loadoutprimary, self.loadoutprimaryattachments, self.loadoutprimarycamo, self.loadoutprimaryreticle) + ";" + "weaponSecondary =" + scripts\mp\class::buildweaponname(self.loadoutsecondary, self.loadoutsecondaryattachments, self.loadoutsecondarycamo, self.loadoutsecondaryreticle) + ";";
  return var_00;
}

buildspawnpointstatestring(var_00) {
  var_01 = "";

  if(isDefined(var_0.lastbucket)) {
    if(isDefined(var_0.lastbucket["allies"])) {
      var_01 = var_01 + ("alliesBucket=" + var_0.lastbucket["allies"] + ";");
    }

    if(isDefined(var_0.lastbucket["axis"])) {
      var_01 = var_01 + ("axisBucket=" + var_0.lastbucket["axis"] + ";");
    }
  }

  return var_01;
}

logevent_path() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_00 = anglesToForward(self getplayerangles());
  bbprint("gamemp_path", "playerid %i x %f y %f z %f gun_orientx %f gun_orienty %f gun_orientz %f action %i health %i", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_0[0], var_0[1], var_0[2], getpathactionvalue(), getsantizedhealth());
  clearpathactionvalue();
}

logevent_playerspawn() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_00 = isDefined(self.lastspawnpoint) && isDefined(self.lastspawnpoint.budgetedents) && self.lastspawnpoint.budgetedents;
  var_01 = anglesToForward(self.angles);
  bbprint("gamemp_spawn_in", "playerid %i x %f y %f z %f orientx %f orienty %f orientz %f loadout %s type %s team %s", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_1[0], var_1[1], var_1[2], buildloadoutstring(), scripts\engine\utility::ter_op(var_00, "Buddy", "Normal"), self.team);
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

logevent_playerdeath(var_00, var_01, var_02) {
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
  var_10 = 0;
  var_11 = "s";
  var_12 = 0;

  if(isDefined(var_00) && isplayer(var_00)) {
    var_04 = var_0.analyticslog.playerid;

    if(isDefined(var_0.team)) {
      if(var_0.team == "axis") {
        var_11 = "a";
      }
      else {
        var_11 = "l";
      }
    }

    if(isDefined(var_0.origin)) {
      var_05 = var_0.origin[0];
      var_06 = var_0.origin[1];
      var_07 = var_0.origin[2];
    }

    if(isDefined(var_0.lifeid)) {
      var_12 = var_0.lifeid;
    }

    var_13 = anglesToForward(var_00 getplayerangles());

    if(isDefined(var_13)) {
      var_08 = var_13[0];
      var_09 = var_13[1];
      var_10 = var_13[2];
    }
  }

  var_14 = level.analyticslog.nextdeathid;
  level.analyticslog.nextdeathid++;
  var_02 = scripts\engine\utility::ter_op(isDefined(var_02), var_02, "None");
  var_15 = "s";

  if(self.team == "axis") {
    var_15 = "a";
  }
  else {
    var_15 = "l";
  }

  bbprint("gamemp_death", "playerid %i x %f y %f z %f gun_orientx %f gun_orienty %f gun_orientz %f weapon %s mean_of_death %s attackerid %i action %i server_death_id %i victim_life_index %d attacker_life_index %d victim_team %s attacker_team %s attacker_pos_x %f attacker_pos_y %f attacker_pos_z %f attacker_gun_orientx %f attacker_gun_orienty %f attacker_gun_orientz %f victim_weapon %s", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_3[0], var_3[1], var_3[2], var_02, scripts\engine\utility::ter_op(isDefined(var_01), var_01, "None"), var_04, buildkilldeathactionvalue(), var_14, self.lifeid, var_12, var_15, var_11, var_05, var_06, var_07, var_08, var_09, var_10, self.primaryweapon);

  if(isDefined(var_01) && isexplosivedamagemod(var_01)) {
    logevent_explosion(scripts\engine\utility::ter_op(isDefined(var_02), var_02, "generic"), self.origin, var_00, 1.0);
  }

  if(isDefined(self.attackers)) {
    foreach(var_17 in self.attackers) {
      if(isDefined(var_17) && isplayer(var_17) && var_17 != var_00) {
        logevent_assist(var_17.analyticslog.playerid, var_14, var_02);
      }
    }
  }
}

logevent_playerkill(var_00, var_01, var_02) {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_03 = anglesToForward(self getplayerangles());
  bbprint("gamemp_kill", "playerid %i x %f y %f z %f gun_orientx %f gun_orienty %f gun_orientz %f weapon %s mean_of_kill %s victimid %i action %i attacker_health %i victim_pixel_count %i", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_3[0], var_3[1], var_3[2], scripts\engine\utility::ter_op(isDefined(var_02), var_02, "None"), scripts\engine\utility::ter_op(isDefined(var_01), var_01, "None"), scripts\engine\utility::ter_op(isDefined(var_00) && isplayer(var_00), var_0.analyticslog.playerid, "-1"), buildkilldeathactionvalue(), getsantizedhealth(), 0);
}

logevent_explosion(var_00, var_01, var_02, var_03, var_04) {
  if(!analyticslogenabled()) {
    return;
  }
  if(!isDefined(var_04)) {
    var_04 = (1, 0, 0);
  }

  bbprint("gamemp_explosion", "playerid %i x %f y %f z %f orientx %f orienty %f orientz %f duration %i type %s", var_2.analyticslog.playerid, var_1[0], var_1[1], var_1[2], var_4[0], var_4[1], var_4[2], var_03, var_00);
}

logevent_spawnpointupdate() {
  if(!analyticslogenabled()) {
    return;
  }
  if(!isDefined(level.spawnpoints)) {
    return;
  }
  foreach(var_01 in level.spawnpoints) {
  bbprint("gamemp_spawn_point", "x %f y %f z %f allies_score %i axis_score %i allies_max_score %i axis_max_score %i state %s", var_1.origin[0], var_1.origin[1], var_1.origin[2], scripts\engine\utility::ter_op(isDefined(var_1.func_A9E9["allies"]), var_1.func_A9E9["allies"], 0), scripts\engine\utility::ter_op(isDefined(var_1.func_A9E9["axis"]), var_1.func_A9E9["axis"], 0), scripts\engine\utility::ter_op(isDefined(var_1.func_11A3A), var_1.func_11A3A, 0), scripts\engine\utility::ter_op(isDefined(var_1.func_11A3A), var_1.func_11A3A, 0), buildspawnpointstatestring(var_01));
  }
}

logevent_frontlineupdate(var_00, var_01, var_02, var_03, var_04) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("gamemp_front_line", "startx %f starty %f endx %f endy %f axis_centerx %f axis_centery %f allies_centerx %f allies_centery %f, state %i", var_0[0], var_0[1], var_1[0], var_1[1], var_3[0], var_3[1], var_2[0], var_2[1], var_04);
}

logevent_gameobject(var_00, var_01, var_02, var_03, var_04) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("gamemp_object", "uniqueid %i x %f y %f z %f ownerid %i type %s state %s", var_01, var_2[0], var_2[1], var_2[2], var_03, var_00, var_04);
}

logevent_message(var_00, var_01, var_02) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("gamemp_message", "ownerid %s x %f y %f z %f message %s", var_00, var_1[0], var_1[1], var_1[2], var_02);
}

logevent_tag(var_00) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("gamemp_matchtags", "message %s", var_00);
}

logevent_powerused(var_00, var_01) {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_02 = anglesToForward(self.angles);
  bbprint("gamemp_power", "ownerid %i x %f y %f z %f orientx %f orienty %f orientz %f type %s state %s", self.analyticslog.playerid, self.origin[0], self.origin[1], self.origin[2], var_2[0], var_2[1], var_2[2], var_00, var_01);
}

logevent_scoreupdate() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  var_00 = anglesToForward(self.angles);
  bbprint("gamemp_scoreboard", "ownerid %i score %i", self.analyticslog.playerid, self.score);
}

logevent_minimapcorners() {
  if(!analyticslogenabled()) {
    return;
  }
  var_00 = getEntArray("minimap_corner", "targetname");

  if(!isDefined(var_00) || var_0.size != 2) {
    return;
  }
  bbprint("gamemp_map", "cornera_x %f cornera_y %f cornerb_x %f cornerb_y %f north %f", var_0[0].origin[0], var_0[0].origin[1], var_0[1].origin[0], var_0[1].origin[1], getnorthyaw());
}

logevent_assist(var_00, var_01, var_02) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("gamemp_assists", "playerid %i server_death_id %i weapon %s", var_00, var_01, var_02);
}

getsantizedhealth() {
  return int(clamp(self.health, 0, 100000));
}

shouldplayerlogevents(var_00) {
  if(!analyticslogenabled()) {
    return 0;
  }

  if(!isDefined(var_0.team) || var_0.team == "spectator" || var_0.sessionstate != "playing" && var_0.sessionstate != "dead") {
    return 0;
  }

  return 1;
}

logmatchtags() {
  var_00 = getdvar("scr_analytics_tag", "");

  if(var_00 != "") {
    logevent_tag(var_00);
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    logevent_tag("OnlineMatch");
  }
  else if(getdvarint("xblive_privatematch")) {
    logevent_tag("PrivateMatch");
  }
  else if(!getdvarint("onlinegame")) {
    logevent_tag("OfflineMatch");
  }
}

logevent_superended(var_00, var_01, var_02, var_03) {
  if(!analyticslogenabled()) {
    return;
  }
  var_04 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_04 = self.analyticslog.playerid;
  }

  bbprint("analytics_mp_supers", "super_name %s time_to_use %i num_hits %i num_kills %i player_id %i", var_00, var_01, var_02, var_03, var_04);
}

logevent_superearned(var_00) {
  if(!analyticslogenabled()) {
    return;
  }
  var_01 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_01 = self.analyticslog.playerid;
  }

  bbprint("analytics_mp_super_earned", "match_time %i player_id %i", var_00, var_01);
}

logevent_killstreakearned(var_00, var_01) {
  if(!analyticslogenabled()) {
    return;
  }
  var_02 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_02 = self.analyticslog.playerid;
  }

  bbprint("analytics_mp_killstreak_earned", "killstreak_name %d match_time %i player_id %i", var_00, var_01, var_02);
}

logevent_killstreakavailable(var_00, var_01) {
  if(!analyticslogenabled()) {
    return;
  }
  var_02 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_02 = self.analyticslog.playerid;
  }

  bbprint("analytics_mp_killstreak", "killstreak_name %s time_to_activate %i player_id %i", var_00, var_01, var_02);
}

logevent_awardgained(var_00) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("analytics_mp_awards", "award_message %s", var_00);
}

logevent_giveplayerxp(var_00, var_01, var_02, var_03) {
  if(!analyticslogenabled()) {
    return;
  }
  var_04 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_04 = self.analyticslog.playerid;
  }

  bbprint("analytics_mp_player_xp", "current_prestige %d current_level %d xp_gained %d xp_source %s player_id %i", var_00, var_01, var_02, var_03, var_04);
}

logevent_givempweaponxp(var_00, var_01, var_02, var_03, var_04) {
  if(!analyticslogenabled()) {
    return;
  }
  var_05 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_05 = self.analyticslog.playerid;
  }

  bbprint("analytics_mp_weapon_xp", "weapon %s current_prestige %d current_level %d xp_gained %d xp_source %s player_id %i", var_00, var_01, var_02, var_03, var_04, var_05);
}

logevent_sendplayerindexdata() {
  if(!analyticslogenabled()) {
    return;
  }
  var_00 = [];
  var_01 = [];
  var_02 = 0;

  for(var_02 = 0; var_02 < 12; var_2++) {
    var_0[var_02] = 0;
    var_1[var_02] = "";
  }

  var_02 = 0;

  foreach(var_04 in level.players) {
    if(!isai(var_04)) {
      var_0[var_02] = var_4.analyticslog.playerid;
      var_1[var_02] = var_04 getxuid();
    }

    var_02 = var_02 + 1;
  }

  bbprint("analytics_match_player_index_init", "player1_index %d player1_xuid %s player2_index %d player2_xuid %s player3_index %d player3_xuid %s player4_index %d player4_xuid %s player5_index %d player5_xuid %s player6_index %d player6_xuid %s player7_index %d player7_xuid %s player8_index %d player8_xuid %s player9_index %d player9_xuid %s player10_index %d player10_xuid %s player11_index %d player11_xuid %s player12_index %d player12_xuid %s", var_0[0], var_1[0], var_0[1], var_1[1], var_0[2], var_1[2], var_0[3], var_1[3], var_0[4], var_1[4], var_0[5], var_1[5], var_0[6], var_1[6], var_0[7], var_1[7], var_0[8], var_1[8], var_0[9], var_1[9], var_0[10], var_1[10], var_0[11], var_1[11]);
}

analyticsspawnlogenabled() {
  return getdvarint("enable_analytics_spawn_log") != 0;
}

is_spawnid_a_less_than_b(var_00, var_01) {
  return var_00 < var_01;
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
  } else {
    level.spawncount = 0;
    level.spawnidstobeinstrumented = [];
    level.nextspawntobeinstrumented = 0;
    var_03 = getdvarint("analytics_spawn_event_log_count");
    var_04 = analytics_getmaxspawneventsforcurrentmode();
    var_05 = [];

    for(var_06 = 0; var_06 < var_03; var_6++) {
      var_07 = randomintrange(20, var_04);

      if(isDefined(var_5[var_07])) {
        level.spawnidstobeinstrumented[var_06] = -1;
        continue;
      }

      var_5[var_07] = 1;
      level.spawnidstobeinstrumented[var_06] = var_07;
    }

    level.spawnidstobeinstrumented = scripts\engine\utility::array_sort_with_func(level.spawnidstobeinstrumented, ::is_spawnid_a_less_than_b);
  }
}

analyticssend_shouldsenddata(var_00) {
  if(isDefined(level.nextspawntobeinstrumented) && isDefined(level.spawnidstobeinstrumented)) {
    if(level.nextspawntobeinstrumented < level.spawnidstobeinstrumented.size) {
      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == -1) {
        level.nextspawntobeinstrumented++;
      }

      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == var_00) {
        level.nextspawntobeinstrumented++;
        return 1;
      }
    }
  }

  return 0;
}

analyticssend_spawntype(var_00, var_01, var_02, var_03) {
  var_04 = scripts\mp\spawnfactor::getglobalfrontlineinfo();
  var_05 = var_4.midpoint;
  var_06 = 0;
  var_07 = 0;
  var_08 = 0;

  if(isDefined(var_05)) {
    var_06 = var_5[0];
    var_07 = var_5[1];
    var_08 = var_5[2];
  }

  var_09 = 0;

  if(isDefined(var_4.teamdiffyaw)) {
    var_09 = var_4.teamdiffyaw;
  }

  var_10 = var_4.isactive[var_01];
  var_11 = 0;

  if(isDefined(var_4.disabledreason) && isDefined(var_4.disabledreason[var_01])) {
    var_11 = var_4.disabledreason[var_01];
  }

  var_12 = level.spawnglobals.logicvariantid;
  var_13 = 0;

  if(isDefined(level.spawnglobals.buddyspawnid)) {
    var_13 = level.spawnglobals.buddyspawnid;
    level.spawnglobals.buddyspawnid = 0;
  }

  bbreportspawntypes(var_06, var_07, var_08, var_09, var_03, var_10, var_11, var_02, var_12, var_13);
}

analyticssend_spawnplayerdetails(var_00, var_01, var_02) {
  foreach(var_04 in level.players) {
    if(scripts\mp\utility\game::isreallyalive(var_04)) {
      var_05 = var_04 getplayerangles();
      var_06 = vectortoyaw(var_05);
      var_07 = var_4.origin[0];
      var_08 = var_4.origin[1];
      var_09 = var_4.origin[2];
      var_10 = 0;

      if(var_04 == var_00) {
        var_10 = 1;
      }

      var_11 = 0;

      if(isDefined(var_0.lastattacker) && var_0.lastattacker == var_04) {
        var_11 = 1;
      }

      var_12 = 0;

      if(var_4.team == "axis") {
        var_12 = 1;
      }
      else if(var_4.team == "allies") {
        var_12 = 2;
      }

      var_13 = 0;

      if(isDefined(var_4.analyticslog.playerid)) {
        var_13 = var_4.analyticslog.playerid;
      }

      bbreportspawnplayerdetails(var_02, var_06, var_07, var_08, var_09, var_13, var_12, var_10, var_11);
    }
  }
}

analyticssend_spawnfactors(var_00, var_01, var_02, var_03) {
  foreach(var_05 in level.spawnglobals.spawnpointslist) {
    var_06 = var_5.totalscore;
    var_07 = var_5.analytics.allyaveragedist;
    var_08 = var_5.analytics.enemyaveragedist;
    var_09 = var_5.analytics.timesincelastspawn;
    var_10 = 0;

    if(isDefined(var_0.lastspawnpoint) && var_0.lastspawnpoint == var_05) {
      var_10 = 1;
    }

    var_11 = 0;

    if(var_03 == var_05) {
      var_11 = 1;
    }

    var_12 = var_5.analytics.maxenemysightfraction;
    var_13 = var_5.analytics.randomscore;
    var_14 = var_5.analytics.spawnusedbyenemies;
    var_15 = 0;

    if(var_5.lastspawnteam == "axis") {
      var_15 = 1;
    }
    else if(var_5.lastspawnteam == "allies") {
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

    bbreportspawnfactors(2, var_06, var_12, var_17, var_13, var_02, var_07, var_08, var_11, var_10, var_15, var_18, var_14, var_09, var_19, var_20);
  }
}

analytics_getmaxspawneventsforcurrentmode() {
  var_00 = 120;

  if(isDefined(level.gametype)) {
    if(level.gametype == "war") {
      var_00 = 120;
    }
    else if(level.gametype == "dom") {
      var_00 = 120;
    }
    else if(level.gametype == "conf") {
      var_00 = 120;
    }
    else if(level.gametype == "front") {
      var_00 = 40;
    }
    else if(level.gametype == "sd") {
      var_00 = 50;
    }
    else if(level.gametype == "dm") {
      var_00 = 50;
    }
    else if(level.gametype == "koth") {
      var_00 = 125;
    }
    else if(level.gametype == "ctf") {
      var_00 = 50;
    }
    else if(level.gametype == "tdef") {
      var_00 = 75;
    }
    else if(level.gametype == "siege") {
      var_00 = 25;
    }
    else if(level.gametype == "gun") {
      var_00 = 50;
    }
    else if(level.gametype == "sr") {
      var_00 = 25;
    }
    else if(level.gametype == "grind") {
      var_00 = 75;
    }
    else if(level.gametype == "ball") {
      var_00 = 50;
    }
  }

  return var_00;
}

logevent_reportgamescore(var_00, var_01, var_02) {
  if(!analyticslogenabled()) {
    return;
  }
  var_03 = 1;

  if(!isDefined(var_02)) {
    var_02 = -1;
  }

  bbprint("analytics_mp_score_event", "score_type %d score_points %d score_eventid %d game_time %d player_id %d", var_03, var_00, var_02, var_01, self.analyticslog.playerid);
}

logevent_reportstreakscore(var_00, var_01, var_02) {
  if(!analyticslogenabled()) {
    return;
  }
  var_03 = 2;

  if(!isDefined(var_02)) {
    var_02 = -1;
  }

  bbprint("analytics_mp_score_event", "score_type %d score_points %d score_eventid %d game_time %d player_id %d", var_03, var_00, var_02, var_01, self.analyticslog.playerid);
}

logevent_reportsuperscore(var_00, var_01) {
  if(!analyticslogenabled()) {
    return;
  }
  var_02 = 3;
  bbprint("analytics_mp_score_event", "score_type %d score_points %d game_time %d player_id %d", var_02, var_00, var_01, self.analyticslog.playerid);
}