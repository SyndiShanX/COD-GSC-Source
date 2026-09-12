/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\analyticslog.gsc
***********************************************/

function init() {
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
    return;
  }
}

function analyticsactive() {
  if(analyticsspawnlogenabled()) {
    return true;
  }

  if(analyticslogenabled()) {
    return true;
  }

  return false;
}

function analyticslogenabled() {
  return getdvarint("enable_analytics_log") == 1;
}

function getuniqueobjectid() {
  var_0 = level.analyticslog.nextobjectid;
  level.analyticslog.nextobjectid++;
  return var_0;
}

function cacheplayeraction(var_0) {
  if(!isDefined(self.analyticslog.cachedactions)) {
    self.analyticslog.cachedactions = 0;
  }

  self.analyticslog.cachedactions |= var_0;
}

function watchforconnectedplayers() {
  jumpiftrue(analyticsactive()) LOC_00000009;
  return;
}

function watchforbasicplayerevents() {
  self endon("disconnect");
  jumpiftrue(analyticslogenabled()) LOC_00000010;
  return;
}

function watchforplayermovementevents() {
  self endon("disconnect");
  jumpiftrue(analyticslogenabled()) LOC_00000010;
  return;
}

function watchforusermessageevents() {
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
    var_0 = scripts\engine\utility::ref_143ad("log_user_event_end", "log_user_event_generic_event");

    if(isDefined(var_0) && var_0 == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      logevent_message(self.name, self.origin, "Generic User Event");
    }
  }
}

function checkstancestatus() {
  var_0 = self getstance();

  if(var_0 == "prone") {
    cacheplayeraction(1);
    return;
  }

  if(var_0 == "crouch") {
    cacheplayeraction(2);
    return;
  }
}

function logallplayerposthink() {
  jumpiftrue(analyticslogenabled()) LOC_00000009;
  return;
}

function recordbreadcrumbdata() {
  level endon("game_ended");

  if(getDvar("online_breadcrumbing_enabled") == "0") {
    return;
  }

  if(isDefined(scripts\mp\utility\game::getgametype()) && scripts\mp\utility\game::getgametype() == "br") {
    var_0 = getdvarfloat("online_br_breadcrumbing_frequency", 4);
  } else {
    var_0 = getdvarfloat("online_mp_breadcrumbing_frequency", 2);
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    var_1 = level.players.size;
    var_2 = gettime();
    var_3 = 0;

    while(var_3 < var_1) {
      for(var_4 = 0; var_4 < 20; var_4++) {
        var_5 = var_3 + var_4;
        var_6 = level.players[var_5];

        if(!isDefined(var_6)) {
          continue;
        }

        if(!isDefined(var_6.team)) {
          continue;
        }

        if(!scripts\mp\utility\player::isreallyalive(var_6)) {
          continue;
        }

        if(var_6.team == "spectator") {
          continue;
        }

        if(var_6.sessionstate != "playing") {
          continue;
        }

        if(isai(var_6)) {
          continue;
        }

        if(!isDefined(var_6.matchdatalifeindex)) {
          continue;
        }

        if(!scripts\mp\matchdata::canlogclient(var_6)) {
          continue;
        }

        var_7 = var_6 scripts\mp\utility\player::isplayerads();
        var_8 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
        var_6 recordbreadcrumbdataforplayer(var_8, var_6.matchdatalifeindex, var_7);
      }

      waitframe();
      var_3 += 20;
    }

    var_9 = (gettime() - var_2) * 0.001;
    var_10 = max(var_0 - var_9, level.framedurationseconds);
    wait var_10;
  }
}

function getpathactionvalue() {
  var_0 = scripts\engine\utility::ter_op(isDefined(self.analyticslog.cachedactions), self.analyticslog.cachedactions, 0);

  if(self iswallrunning()) {
    var_0 |= 32;
  }

  return var_0;
}

function clearpathactionvalue() {
  self.analyticslog.cachedactions = 0;
  checkstancestatus();
}

function buildkilldeathactionvalue() {
  var_0 = 0;
  var_1 = self getstance();

  if(var_1 == "prone") {
    var_0 |= 1;
  } else if(var_1 == "crouch") {
    var_0 |= 2;
  }

  if(self isjumping()) {
    var_0 |= 4;
  }

  if(isDefined(self.lastshotfiredtime) && gettime() - self.lastshotfiredtime < 500) {
    var_0 |= 8;
  }

  if(self isreloading()) {
    var_0 |= 16;
  }

  return var_0;
}

function buildloadoutstring() {
  var_0 = "archetype=" + self.loadoutarchetype + ";" + "powerPrimary=" + self.loadoutequipmentprimary + ";" + "powerSecondary=" + self.loadoutequipmentsecondary + ";" + "weaponPrimary\t =" + self.primaryweapon + ";" + "weaponSecondary =" + self.secondaryweapon + ";";
  return var_0;
}

function buildspawnpointstatestring(var_0) {
  var_1 = "";

  if(isDefined(var_0.lastbucket)) {
    if(isDefined(var_0.lastbucket["allies"])) {
      var_1 += "alliesBucket=" + var_0.lastbucket["allies"] + ";";
    }

    if(isDefined(var_0.lastbucket["axis"])) {
      var_1 += "axisBucket=" + var_0.lastbucket["axis"] + ";";
    }
  }

  return var_1;
}

function logevent_path() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_0 = anglesToForward(self getplayerangles());
  getentitylessscriptablearray("gamemp_path", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_0[0], "gun_orienty", var_0[1], "gun_orientz", var_0[2], "action", getpathactionvalue(), "health", getsantizedhealth()]);
  clearpathactionvalue();
}

function logevent_playerspawn() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_0 = isDefined(self.lastspawnpoint) && isDefined(self.lastspawnpoint.buddyspawn) && self.lastspawnpoint.buddyspawn;
  var_1 = anglesToForward(self.angles);
  getentitylessscriptablearray("gamemp_spawn_in", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", var_1[0], "orienty", var_1[1], "orientz", var_1[2], "loadout", buildloadoutstring(), "type", scripts\engine\utility::ter_op(var_0, "Buddy", "Normal"), "team", self.team]);
}

function logevent_playerconnected() {
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

  var_0 = undefined;

  if(isDefined(self.changedarchetypeinfo)) {
    var_0 = self.changedarchetypeinfo.super;
  } else {
    var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");
  }

  var_1 = self getxuid();
  getentitylessscriptablearray("gamemp_player_connect", ["playerid", self.analyticslog.playerid, "player_name", self.name, "player_xuid", var_1, "player_super_name", var_0]);
}

function logevent_playerdeath(var_0, var_1, var_2) {
  if(!shouldplayerlogevents(self) || !isPlayer(self)) {
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

  if(isDefined(var_0) && isPlayer(var_0)) {
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

  getentitylessscriptablearray("134death", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_3[0], "gun_orienty", var_3[1], "gun_orientz", var_3[2], "weapon", var_2, "mean_of_death", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "None"), "attackerid", var_4, "action", buildkilldeathactionvalue(), "server_death_id", var_14, "victim_life_index", self.lifeid, "attacker_life_index", var_12, "victim_team", var_15, "attacker_team", var_11, "attacker_pos_x", var_5, "attacker_pos_y", var_6, "attacker_pos_z", var_7, "attacker_gun_orientx", var_8, "attacker_gun_orienty", var_9, "attacker_gun_orientz", var_10, "victim_weapon", self.primaryweapon]);

  if(getdvarint("mount_bb_analytics")) {
    var_16 = "NO_ATTACKER";

    if(isDefined(var_0) && isPlayer(var_0)) {
      var_16 = var_0 playermounttype();
    }

    var_17 = self playermounttype();
    getentitylessscriptablearray("dlog_event_gamemp_death_mount", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_3[0], "gun_orienty", var_3[1], "gun_orientz", var_3[2], "weapon", var_2, "mean_of_death", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "None"), "attackerid", var_4, "action", buildkilldeathactionvalue(), "server_death_id", var_14, "victim_life_index", self.lifeid, "attacker_life_index", var_12, "victim_team", var_15, "attacker_team", var_11, "attacker_pos_x", var_5, "attacker_pos_y", var_6, "attacker_pos_z", var_7, "attacker_gun_orientx", var_8, "attacker_gun_orienty", var_9, "attacker_gun_orientz", var_10, "victim_weapon", self.primaryweapon, "attacker_mount_type", var_16, "victim_mount_type", var_17]);
  }

  if(isDefined(var_1) && isexplosivedamagemod(var_1)) {
    logevent_explosion(scripts\engine\utility::ter_op(isDefined(var_2), var_2, "generic"), self.origin, var_0, 1);
  }

  if(isDefined(self.attackers)) {
    foreach(var_19 in self.attackers) {
      if(isDefined(var_19) && isPlayer(var_19) && var_19 != var_0) {
        logevent_assist(var_19.analyticslog.playerid, var_14, var_2);
      }
    }

    return;
  }
}

function logevent_playerkill(var_0, var_1, var_2) {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_3 = anglesToForward(self getplayerangles());
  getentitylessscriptablearray("gamemp_kill", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_3[0], "gun_orienty", var_3[1], "gun_orientz", var_3[2], "weapon", scripts\engine\utility::ter_op(isDefined(var_2), var_2, "None"), "mean_of_kill", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "None"), "victimid", scripts\engine\utility::ter_op(isDefined(var_0) && isPlayer(var_0), var_0.analyticslog.playerid, "-1"), "action", buildkilldeathactionvalue(), "attacker_health", getsantizedhealth(), "victim_pixel_count", 0]);
}

function logevent_explosion(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }

  if(!isDefined(var_4)) {
    var_4 = (1, 0, 0);
  }

  getentitylessscriptablearray("gamemp_explosion", ["playerid", var_2.analyticslog.playerid, "x", var_1[0], "y", var_1[1], "z", var_1[2], "orientx", var_4[0], "orienty", var_4[1], "orientz", var_4[2], "duration", var_3, "type", var_0]);
}

function logevent_spawnpointupdate() {
  if(!analyticslogenabled()) {
    return;
  }

  if(!isDefined(level.spawnpoints)) {
    return;
  }

  foreach(var_1 in level.spawnpoints) {
    getentitylessscriptablearray("gamemp_spawn_point", ["x", var_1.origin[0], "y", var_1.origin[1], "z", var_1.origin[2], "allies_score", scripts\engine\utility::ter_op(isDefined(var_1.lastscore["allies"]), var_1.lastscore["allies"], 0), "axis_score", scripts\engine\utility::ter_op(isDefined(var_1.lastscore["axis"]), var_1.lastscore["axis"], 0), "allies_max_score", scripts\engine\utility::ter_op(isDefined(var_1.totalpossiblescore), var_1.totalpossiblescore, 0), "axis_max_score", scripts\engine\utility::ter_op(isDefined(var_1.totalpossiblescore), var_1.totalpossiblescore, 0), "state", buildspawnpointstatestring(var_1)]);
  }
}

function logevent_frontlineupdate(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamemp_front_line", ["startx", var_0[0], "starty", var_0[1], "endx", var_1[0], "endy", var_1[1], "axis_centerx", var_3[0], "axis_centery", var_3[1], "allies_centerx", var_2[0], "allies_centery", var_2[1], "state", var_4]);
}

function logevent_gameobject(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamemp_object", ["uniqueid", var_1, "x", var_2[0], "y", var_2[1], "z", var_2[2], "ownerid", var_3, "type", var_0, "state", var_4]);
}

function logevent_message(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamemp_message", ["ownerid", var_0, "x", var_1[0], "y", var_1[1], "z", var_1[2], "message", var_2]);
}

function logevent_tag(var_0) {
  if(!analyticslogenabled()) {
    return;
  }

  bbprint("gamemp_matchtags", "message %s", var_0);
}

function logevent_powerused(var_0, var_1) {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_2 = anglesToForward(self.angles);
  getentitylessscriptablearray("gamemp_power", ["ownerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", var_2[0], "orienty", var_2[1], "orientz", var_2[2], "type", var_0, "state", var_1]);
}

function logevent_scoreupdate() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_0 = anglesToForward(self.angles);
  getentitylessscriptablearray("gamemp_scoreboard", ["ownerid", self.analyticslog.playerid, "score", self.score]);
}

function logevent_minimapcorners() {
  if(!analyticslogenabled()) {
    return;
  }

  var_0 = getEntArray("minimap_corner", "targetname");

  if(!isDefined(var_0) || var_0.size != 2) {
    return;
  }

  getentitylessscriptablearray("gamemp_map", ["cornera_x", var_0[0].origin[0], "cornera_y", var_0[0].origin[1], "cornerb_x", var_0[1].origin[0], "cornerb_y", var_0[1].origin[1], "north", getnorthyaw()]);
}

function logevent_assist(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamemp_assists", ["playerid", var_0, "server_death_id", var_1, "weapon", var_2]);
}

function getsantizedhealth() {
  return int(clamp(self.health, 0, 100000));
}

function shouldplayerlogevents(var_0) {
  if(!analyticslogenabled()) {
    return false;
  }

  if(!isDefined(var_0.team) || var_0.team == "spectator" || var_0.sessionstate != "playing" && var_0.sessionstate != "dead") {
    return false;
  }

  return true;
}

function logmatchtags() {
  var_0 = getDvar("scr_analytics_tag", "");

  if(var_0 != "") {
    logevent_tag(var_0);
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
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

function logevent_superended(var_0, var_1, var_2, var_3) {
  if(!analyticslogenabled()) {
    return;
  }

  var_4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_4 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("analytics_mp_supers", ["super_name", var_0, "time_to_use", var_1, "num_hits", var_2, "num_kills", var_3, "player_id", var_4]);
}

function logevent_superearned(var_0) {
  if(!analyticslogenabled()) {
    return;
  }

  var_1 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_1 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("analytics_mp_super_earned", ["match_time", var_0, "player_id", var_1]);
}

function logevent_awardgained(var_0) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("analytics_mp_awards", ["award_message", var_0]);
}

function logevent_giveplayerxp(var_0, var_1, var_2, var_3) {
  if(!analyticslogenabled()) {
    return;
  }

  var_4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_4 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("analytics_mp_player_xp", ["current_prestige", var_0, "current_level", var_1, "xp_gained", var_2, "xp_source", var_3, "player_id", var_4]);
}

function logevent_givempweaponxp(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }

  var_5 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_5 = self.analyticslog.playerid;
  }

  var_6 = createheadicon(var_0);
  getentitylessscriptablearray("analytics_mp_weapon_xp", ["weapon", var_6, "current_prestige", var_1, "current_level", var_2, "xp_gained", var_3, "xp_source", var_4, "player_id", var_5]);
}

function logevent_sendplayerindexdata() {
  if(!analyticslogenabled()) {
    return;
  }

  var_0 = [];
  var_1 = [];
  var_2 = 0;

  for(var_2 = 0; var_2 < 12; var_2++) {
    var_0 = 0;
    var_1 = "";
  }

  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      var_0 = var_4.analyticslog.playerid;
      var_1 = var_4 getxuid();
    }

    var_2 += 1;
  }

  getentitylessscriptablearray("analytics_match_player_index_init", ["player1_index", var_0[0], "player1_xuid", var_1[0], "player2_index", var_0[1], "player2_xuid", var_1[1], "player3_index", var_0[2], "player3_xuid", var_1[2], "player4_index", var_0[3], "player4_xuid", var_1[3], "player5_index", var_0[4], "player5_xuid", var_1[4], "player6_index", var_0[5], "player6_xuid", var_1[5], "player7_index", var_0[6], "player7_xuid", var_1[6], "player8_index", var_0[7], "player8_xuid", var_1[7], "player9_index", var_0[8], "player9_xuid", var_1[8], "player10_index", var_0[9], "player10_xuid", var_1[9], "player11_index", var_0[10], "player11_xuid", var_1[10], "player12_index", var_0[11], "player12_xuid", var_1[11]]);
}

function analyticsspawnlogenabled() {
  return getdvarint("enable_analytics_spawn_log") != 0;
}

function is_spawnid_a_less_than_b(var_0, var_1) {
  return var_0 < var_1;
}

function analyticsstorespawndata() {
  if(isDefined(level.spawncount) && isDefined(level.spawnidstobeinstrumented) && isDefined(level.nextspawntobeinstrumented)) {
    game["spawnCount"] = level.spawncount;
    game["spawnIdsToBeInstrumented"] = level.spawnidstobeinstrumented;
    game["nextSpawnToBeInstrumented"] = level.nextspawntobeinstrumented;
    return;
  }
}

function analyticsdoesspawndataexist() {
  if(isDefined(level.spawncount) && isDefined(level.spawnidstobeinstrumented) && isDefined(level.nextspawntobeinstrumented)) {
    return true;
  }

  return false;
}

function analyticsinitspawndata() {
  var_0 = game["spawnCount"];
  var_1 = game["spawnIdsToBeInstrumented"];
  var_2 = game["nextSpawnToBeInstrumented"];

  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2)) {
    level.spawncount = var_0;
    level.spawnidstobeinstrumented = var_1;
    level.nextspawntobeinstrumented = var_2;
    return;
  }

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

    var_5 = 1;
    level.spawnidstobeinstrumented[var_6] = var_7;
  }

  level.spawnidstobeinstrumented = scripts\engine\utility::array_sort_with_func(level.spawnidstobeinstrumented, &is_spawnid_a_less_than_b);
}

function analyticssend_shouldsenddata(var_0) {
  if(isDefined(level.nextspawntobeinstrumented) && isDefined(level.spawnidstobeinstrumented)) {
    if(level.nextspawntobeinstrumented < level.spawnidstobeinstrumented.size) {
      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == -1) {
        level.nextspawntobeinstrumented++;
      }

      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == var_0) {
        level.nextspawntobeinstrumented++;
        return true;
      }
    }
  }

  return false;
}

function analyticssend_spawntype(var_0, var_1, var_2, var_3) {
  var_4 = getglobalfrontlineinfo();
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

  if(isDefined(level.spawnglobals.buddyplayerid)) {
    var_13 = level.spawnglobals.buddyplayerid;
    level.spawnglobals.buddyplayerid = 0;
  }

  bbreportspawntypes(var_6, var_7, var_8, var_9, var_3, var_10, var_11, var_2, var_12, var_13);
}

function analyticssend_spawnplayerdetails(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(scripts\mp\utility\player::isreallyalive(var_4)) {
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

function analyticssend_spawnfactors(var_0, var_1, var_2, var_3) {
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

    if(isDefined(var_5.lastspawnteam) && var_5.lastspawnteam == "axis") {
      var_15 = 1;
    } else if(isDefined(var_5.lastspawnteam) && var_5.lastspawnteam == "allies") {
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

function analytics_getmaxspawneventsforcurrentmode() {
  var_0 = 120;

  if(isDefined(scripts\mp\utility\game::getgametype())) {
    if(scripts\mp\utility\game::getgametype() == "war") {
      var_0 = 120;
    } else if(scripts\mp\utility\game::getgametype() == "dom") {
      var_0 = 120;
    } else if(scripts\mp\utility\game::getgametype() == "conf") {
      var_0 = 120;
    } else if(scripts\mp\utility\game::getgametype() == "front") {
      var_0 = 40;
    } else if(scripts\mp\utility\game::getgametype() == "sd") {
      var_0 = 50;
    } else if(scripts\mp\utility\game::getgametype() == "dm") {
      var_0 = 50;
    } else if(scripts\mp\utility\game::getgametype() == "koth") {
      var_0 = 125;
    } else if(scripts\mp\utility\game::getgametype() == "ctf") {
      var_0 = 50;
    } else if(scripts\mp\utility\game::getgametype() == "tdef") {
      var_0 = 120;
    } else if(scripts\mp\utility\game::getgametype() == "siege") {
      var_0 = 25;
    } else if(scripts\mp\utility\game::getgametype() == "gun") {
      var_0 = 50;
    } else if(scripts\mp\utility\game::getgametype() == "sr") {
      var_0 = 25;
    } else if(scripts\mp\utility\game::getgametype() == "grind") {
      var_0 = 75;
    } else if(scripts\mp\utility\game::getgametype() == "pill") {
      var_0 = 75;
    } else if(scripts\mp\utility\game::getgametype() == "ball") {
      var_0 = 50;
    }
  }

  return var_0;
}

function logevent_reportgamescore(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }

  var_3 = 1;

  if(!isDefined(var_2)) {
    var_2 = -1;
  }

  getentitylessscriptablearray("analytics_mp_score_event", ["score_type", var_3, "score_points", var_0, "score_eventid", var_2, "game_time", var_1, "player_id", self.analyticslog.playerid]);
}

function logevent_reportstreakscore(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }

  var_3 = 2;

  if(!isDefined(var_2)) {
    var_2 = -1;
  }

  getentitylessscriptablearray("analytics_mp_score_event", ["score_type", var_3, "score_points", var_0, "score_eventid", var_2, "game_time", var_1, "player_id", self.analyticslog.playerid]);
}

function logevent_reportsuperscore(var_0, var_1) {
  if(!analyticslogenabled()) {
    return;
  }

  var_2 = 3;
  getentitylessscriptablearray("analytics_mp_score_event", ["score_type", var_2, "score_points", var_0, "game_time", var_1, "player_id", self.analyticslog.playerid]);
}

function logevent_nvgtoggled(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!analyticslogenabled()) {
    return;
  }

  var_6 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_6 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("dlog_event_gamemp_nvg_toggle", ["playerid", var_6, "game_time", var_0, "player_life_index", var_1, "x", var_2[0], "y", var_2[1], "z", var_2[2], "enabled", var_3, "duration", var_4, "disable_reason", var_5]);
}

function getglobalfrontlineinfo() {
  if(!isDefined(level.frontlineinfo)) {
    level.frontlineinfo = spawnStruct();
    level.frontlineinfo.isactive = [];
    level.frontlineinfo.isactive["allies"] = 0;
    level.frontlineinfo.isactive["axis"] = 0;
    level.frontlineinfo.uptime = 0;
    level.frontlineinfo.downtime = 0;
  }

  return level.frontlineinfo;
}

function logevent_playerhealed(var_0, var_1, var_2) {
  var_3 = isDefined(var_2);

  if(!var_3) {
    var_2 = var_0;
  }

  var_0 dlog_recordplayerevent("dlog_event_player_heal", ["reviver", var_2, "player_life_index", var_0.matchdatalifeindex, "pos_x", var_0.origin[0], "pos_y", var_0.origin[1], "pos_z", var_0.origin[2], "heal_ammount", var_1, "was_revived", var_3]);
}

function ref_119b7(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  var_0 dlog_recordplayerevent("dlog_event_player_regen", ["player_life_index", var_0.matchdatalifeindex, "heal_amount", var_1]);
}

function logevent_fieldupgradeearned(var_0, var_1) {
  var_0 dlog_recordplayerevent("dlog_event_player_field_upgrade_earned", ["player_life_index", var_0.matchdatalifeindex, "pos_x", var_0.origin[0], "pos_y", var_0.origin[1], "pos_z", var_0.origin[2], "field_upgrade_index", var_1]);
}

function logevent_fieldupgradeactivated(var_0, var_1) {
  var_0 dlog_recordplayerevent("dlog_event_player_field_upgrade_activated", ["player_life_index", var_0.matchdatalifeindex, "pos_x", var_0.origin[0], "pos_y", var_0.origin[1], "pos_z", var_0.origin[2], "field_upgrade_index", var_1]);
}

function logevent_fieldupgradeexpired(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_0 dlog_recordplayerevent("dlog_event_player_field_upgrade_expired", ["player_life_index", var_0.matchdatalifeindex, "pos_x", var_0.origin[0], "pos_y", var_0.origin[1], "pos_z", var_0.origin[2], "field_upgrade_index", var_1, "efficacy", var_2, "was_destroyed", var_3]);
}

function logevent_killstreakavailable(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 dlog_recordplayerevent("dlog_event_kill_streak_available", ["lifeindex", var_1, "killstreak_name", var_2, "killstreak_pickedup", var_3, "time_msfrommatchstart", var_4, "playerposx", var_5[0], "playerposy", var_5[1], "playerposz", var_5[2]]);
}

function logevent_killstreakactivated(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 dlog_recordplayerevent("dlog_event_kill_streak_activated", ["lifeindex", var_1, "killstreak_name", var_2, "killstreak_pickedup", var_3, "time_msfrommatchstart", var_4, "playerposx", var_5[0], "playerposy", var_5[1], "playerposz", var_5[2]]);
}

function logevent_killstreakexpired(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0)) {
    return;
  }

  var_11 = scripts\mp\matchdata::gettimefrommatchstart(var_4);
  var_0 dlog_recordplayerevent("dlog_event_kill_streak_expired", ["lifeindex", var_1, "killstreak_name", var_2, "killstreak_pickedup", var_3, "expiration_thru_death", var_6, "shots", var_7, "hits", var_8, "kills", var_9, "score", var_10, "time_msfrommatchstart", var_11, "playerposx", var_5[0], "playerposy", var_5[1], "playerposz", var_5[2]]);
}

function ref_119bf(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = "";
  }

  var_0 dlog_recordplayerevent("dlog_event_player_xp_earned", ["player_life_index", var_0.matchdatalifeindex, "player_xp_earned", var_1, "weapon_s", var_2, "weapon_xp_earned", var_3, "xp_event", var_4]);
}

function ref_119ba(var_0, var_1) {
  var_0 dlog_recordplayerevent("dlog_event_player_spawnselection_choice", ["player_life_index", var_0.matchdatalifeindex, "selection", var_1]);
}

function ref_119b1(var_0, var_1, var_2, var_3) {
  var_0 dlog_recordplayerevent("dlog_event_player_challenge_item_unlocked", ["item_unlock_ref", var_1, "item_type", var_2, "item_id", var_3]);
}