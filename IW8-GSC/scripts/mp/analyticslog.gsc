/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\analyticslog.gsc
***********************************************/

function init() {
  setdvarifuninitialized("OLMQKSKMRS", 0);
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
  return getdvarint("OLMQKSKMRS") == 1;
}

function getuniqueobjectid() {
  var0 = level.analyticslog.nextobjectid;
  level.analyticslog.nextobjectid++;
  return var0;
}

function cacheplayeraction(var0) {
  if(!isDefined(self.analyticslog.cachedactions)) {
    self.analyticslog.cachedactions = 0;
  }

  self.analyticslog.cachedactions |= var0;
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
    var0 = scripts\engine\utility::ref_143ad("log_user_event_end", "log_user_event_generic_event");

    if(isDefined(var0) && var0 == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      logevent_message(self.name, self.origin, "Generic User Event");
    }
  }
}

function checkstancestatus() {
  var0 = self getstance();

  if(var0 == "prone") {
    cacheplayeraction(1);
    return;
  }

  if(var0 == "crouch") {
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

  if(getDvar("OLKQSLNLPM") == "0") {
    return;
  }

  if(isDefined(scripts\mp\utility\game::getgametype()) && scripts\mp\utility\game::getgametype() == "br") {
    var0 = getdvarfloat("MQPMTNTSLO", 4);
  } else {
    var0 = getdvarfloat("NSMKNLRLON", 2);
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    var1 = level.players.size;
    var2 = gettime();
    var3 = 0;

    while(var3 < var1) {
      for(var4 = 0; var4 < 20; var4++) {
        var5 = var3 + var4;
        var6 = level.players[var5];

        if(!isDefined(var6)) {
          continue;
        }

        if(!isDefined(var6.team)) {
          continue;
        }

        if(!scripts\mp\utility\player::isreallyalive(var6)) {
          continue;
        }

        if(var6.team == "spectator") {
          continue;
        }

        if(var6.sessionstate != "playing") {
          continue;
        }

        if(isai(var6)) {
          continue;
        }

        if(!isDefined(var6.matchdatalifeindex)) {
          continue;
        }

        if(!scripts\mp\matchdata::canlogclient(var6)) {
          continue;
        }

        var7 = var6 scripts\mp\utility\player::isplayerads();
        var8 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
        var6 recordbreadcrumbdataforplayer(var8, var6.matchdatalifeindex, var7);
      }

      waitframe();
      var3 += 20;
    }

    var9 = (gettime() - var2) * 0.001;
    var10 = max(var0 - var9, level.framedurationseconds);
    wait var10;
  }
}

function getpathactionvalue() {
  var0 = scripts\engine\utility::ter_op(isDefined(self.analyticslog.cachedactions), self.analyticslog.cachedactions, 0);

  if(self iswallrunning()) {
    var0 |= 32;
  }

  return var0;
}

function clearpathactionvalue() {
  self.analyticslog.cachedactions = 0;
  checkstancestatus();
}

function buildkilldeathactionvalue() {
  var0 = 0;
  var1 = self getstance();

  if(var1 == "prone") {
    var0 |= 1;
  } else if(var1 == "crouch") {
    var0 |= 2;
  }

  if(self isjumping()) {
    var0 |= 4;
  }

  if(isDefined(self.lastshotfiredtime) && gettime() - self.lastshotfiredtime < 500) {
    var0 |= 8;
  }

  if(self isreloading()) {
    var0 |= 16;
  }

  return var0;
}

function buildloadoutstring() {
  var0 = "archetype=" + self.loadoutarchetype + ";" + "powerPrimary=" + self.loadoutequipmentprimary + ";" + "powerSecondary=" + self.loadoutequipmentsecondary + ";" + "weaponPrimary\t =" + self.primaryweapon + ";" + "weaponSecondary =" + self.secondaryweapon + ";";
  return var0;
}

function buildspawnpointstatestring(var0) {
  var1 = "";

  if(isDefined(var0.lastbucket)) {
    if(isDefined(var0.lastbucket["allies"])) {
      var1 += "alliesBucket=" + var0.lastbucket["allies"] + ";";
    }

    if(isDefined(var0.lastbucket["axis"])) {
      var1 += "axisBucket=" + var0.lastbucket["axis"] + ";";
    }
  }

  return var1;
}

function logevent_path() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var0 = anglesToForward(self getplayerangles());
  getentitylessscriptablearray("gamemp_path", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var0[0], "gun_orienty", var0[1], "gun_orientz", var0[2], "action", getpathactionvalue(), "health", getsantizedhealth()]);
  clearpathactionvalue();
}

function logevent_playerspawn() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var0 = isDefined(self.lastspawnpoint) && isDefined(self.lastspawnpoint.buddyspawn) && self.lastspawnpoint.buddyspawn;
  var1 = anglesToForward(self.angles);
  getentitylessscriptablearray("gamemp_spawn_in", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", var1[0], "orienty", var1[1], "orientz", var1[2], "loadout", buildloadoutstring(), "type", scripts\engine\utility::ter_op(var0, "Buddy", "Normal"), "team", self.team]);
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

  var0 = undefined;

  if(isDefined(self.changedarchetypeinfo)) {
    var0 = self.changedarchetypeinfo.super;
  } else {
    var0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");
  }

  var1 = self getxuid();
  getentitylessscriptablearray("gamemp_player_connect", ["playerid", self.analyticslog.playerid, "player_name", self.name, "player_xuid", var1, "player_super_name", var0]);
}

function logevent_playerdeath(var0, var1, var2) {
  if(!shouldplayerlogevents(self) || !isPlayer(self)) {
    return;
  }

  var3 = anglesToForward(self getplayerangles());
  var4 = -1;
  var5 = 0;
  var6 = 0;
  var7 = 0;
  var8 = 0;
  var9 = 0;
  var10 = 0;
  var11 = "s";
  var12 = 0;

  if(isDefined(var0) && isPlayer(var0)) {
    var4 = var0.analyticslog.playerid;

    if(isDefined(var0.team)) {
      if(var0.team == "axis") {
        var11 = "a";
      } else {
        var11 = "l";
      }
    }

    if(isDefined(var0.origin)) {
      var5 = var0.origin[0];
      var6 = var0.origin[1];
      var7 = var0.origin[2];
    }

    if(isDefined(var0.lifeid)) {
      var12 = var0.lifeid;
    }

    var13 = anglesToForward(var0 getplayerangles());

    if(isDefined(var13)) {
      var8 = var13[0];
      var9 = var13[1];
      var10 = var13[2];
    }
  }

  var14 = level.analyticslog.nextdeathid;
  level.analyticslog.nextdeathid++;
  var2 = scripts\engine\utility::ter_op(isDefined(var2), var2, "None");
  var15 = "s";

  if(self.team == "axis") {
    var15 = "a";
  } else {
    var15 = "l";
  }

  getentitylessscriptablearray("134death", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var3[0], "gun_orienty", var3[1], "gun_orientz", var3[2], "weapon", var2, "mean_of_death", scripts\engine\utility::ter_op(isDefined(var1), var1, "None"), "attackerid", var4, "action", buildkilldeathactionvalue(), "server_death_id", var14, "victim_life_index", self.lifeid, "attacker_life_index", var12, "victim_team", var15, "attacker_team", var11, "attacker_pos_x", var5, "attacker_pos_y", var6, "attacker_pos_z", var7, "attacker_gun_orientx", var8, "attacker_gun_orienty", var9, "attacker_gun_orientz", var10, "victim_weapon", self.primaryweapon]);

  if(getdvarint("NPOPPTKNPS")) {
    var16 = "NO_ATTACKER";

    if(isDefined(var0) && isPlayer(var0)) {
      var16 = var0 playermounttype();
    }

    var17 = self playermounttype();
    getentitylessscriptablearray("dlog_event_gamemp_death_mount", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var3[0], "gun_orienty", var3[1], "gun_orientz", var3[2], "weapon", var2, "mean_of_death", scripts\engine\utility::ter_op(isDefined(var1), var1, "None"), "attackerid", var4, "action", buildkilldeathactionvalue(), "server_death_id", var14, "victim_life_index", self.lifeid, "attacker_life_index", var12, "victim_team", var15, "attacker_team", var11, "attacker_pos_x", var5, "attacker_pos_y", var6, "attacker_pos_z", var7, "attacker_gun_orientx", var8, "attacker_gun_orienty", var9, "attacker_gun_orientz", var10, "victim_weapon", self.primaryweapon, "attacker_mount_type", var16, "victim_mount_type", var17]);
  }

  if(isDefined(var1) && isexplosivedamagemod(var1)) {
    logevent_explosion(scripts\engine\utility::ter_op(isDefined(var2), var2, "generic"), self.origin, var0, 1);
  }

  if(isDefined(self.attackers)) {
    foreach(var19 in self.attackers) {
      if(isDefined(var19) && isPlayer(var19) && var19 != var0) {
        logevent_assist(var19.analyticslog.playerid, var14, var2);
      }
    }

    return;
  }
}

function logevent_playerkill(var0, var1, var2) {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var3 = anglesToForward(self getplayerangles());
  getentitylessscriptablearray("gamemp_kill", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var3[0], "gun_orienty", var3[1], "gun_orientz", var3[2], "weapon", scripts\engine\utility::ter_op(isDefined(var2), var2, "None"), "mean_of_kill", scripts\engine\utility::ter_op(isDefined(var1), var1, "None"), "victimid", scripts\engine\utility::ter_op(isDefined(var0) && isPlayer(var0), var0.analyticslog.playerid, "-1"), "action", buildkilldeathactionvalue(), "attacker_health", getsantizedhealth(), "victim_pixel_count", 0]);
}

function logevent_explosion(var0, var1, var2, var3, var4) {
  if(!analyticslogenabled()) {
    return;
  }

  if(!isDefined(var4)) {
    var4 = (1, 0, 0);
  }

  getentitylessscriptablearray("gamemp_explosion", ["playerid", var2.analyticslog.playerid, "x", var1[0], "y", var1[1], "z", var1[2], "orientx", var4[0], "orienty", var4[1], "orientz", var4[2], "duration", var3, "type", var0]);
}

function logevent_spawnpointupdate() {
  if(!analyticslogenabled()) {
    return;
  }

  if(!isDefined(level.spawnpoints)) {
    return;
  }

  foreach(var1 in level.spawnpoints) {
    getentitylessscriptablearray("gamemp_spawn_point", ["x", var1.origin[0], "y", var1.origin[1], "z", var1.origin[2], "allies_score", scripts\engine\utility::ter_op(isDefined(var1.lastscore["allies"]), var1.lastscore["allies"], 0), "axis_score", scripts\engine\utility::ter_op(isDefined(var1.lastscore["axis"]), var1.lastscore["axis"], 0), "allies_max_score", scripts\engine\utility::ter_op(isDefined(var1.totalpossiblescore), var1.totalpossiblescore, 0), "axis_max_score", scripts\engine\utility::ter_op(isDefined(var1.totalpossiblescore), var1.totalpossiblescore, 0), "state", buildspawnpointstatestring(var1)]);
  }
}

function logevent_frontlineupdate(var0, var1, var2, var3, var4) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamemp_front_line", ["startx", var0[0], "starty", var0[1], "endx", var1[0], "endy", var1[1], "axis_centerx", var3[0], "axis_centery", var3[1], "allies_centerx", var2[0], "allies_centery", var2[1], "state", var4]);
}

function logevent_gameobject(var0, var1, var2, var3, var4) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamemp_object", ["uniqueid", var1, "x", var2[0], "y", var2[1], "z", var2[2], "ownerid", var3, "type", var0, "state", var4]);
}

function logevent_message(var0, var1, var2) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamemp_message", ["ownerid", var0, "x", var1[0], "y", var1[1], "z", var1[2], "message", var2]);
}

function logevent_tag(var0) {
  if(!analyticslogenabled()) {
    return;
  }

  bbprint("gamemp_matchtags", "message %s", var0);
}

function logevent_powerused(var0, var1) {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var2 = anglesToForward(self.angles);
  getentitylessscriptablearray("gamemp_power", ["ownerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", var2[0], "orienty", var2[1], "orientz", var2[2], "type", var0, "state", var1]);
}

function logevent_scoreupdate() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var0 = anglesToForward(self.angles);
  getentitylessscriptablearray("gamemp_scoreboard", ["ownerid", self.analyticslog.playerid, "score", self.score]);
}

function logevent_minimapcorners() {
  if(!analyticslogenabled()) {
    return;
  }

  var0 = getEntArray("minimap_corner", "targetname");

  if(!isDefined(var0) || var0.size != 2) {
    return;
  }

  getentitylessscriptablearray("gamemp_map", ["cornera_x", var0[0].origin[0], "cornera_y", var0[0].origin[1], "cornerb_x", var0[1].origin[0], "cornerb_y", var0[1].origin[1], "north", getnorthyaw()]);
}

function logevent_assist(var0, var1, var2) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamemp_assists", ["playerid", var0, "server_death_id", var1, "weapon", var2]);
}

function getsantizedhealth() {
  return int(clamp(self.health, 0, 100000));
}

function shouldplayerlogevents(var0) {
  if(!analyticslogenabled()) {
    return false;
  }

  if(!isDefined(var0.team) || var0.team == "spectator" || var0.sessionstate != "playing" && var0.sessionstate != "dead") {
    return false;
  }

  return true;
}

function logmatchtags() {
  var0 = getDvar("scr_analytics_tag", "");

  if(var0 != "") {
    logevent_tag(var0);
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    logevent_tag("OnlineMatch");
    return;
  }

  if(getdvarint("LSTLQTSSRM")) {
    logevent_tag("PrivateMatch");
    return;
  }

  if(!getdvarint("LTSNLQNRKO")) {
    logevent_tag("OfflineMatch");
    return;
  }
}

function logevent_superended(var0, var1, var2, var3) {
  if(!analyticslogenabled()) {
    return;
  }

  var4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var4 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("analytics_mp_supers", ["super_name", var0, "time_to_use", var1, "num_hits", var2, "num_kills", var3, "player_id", var4]);
}

function logevent_superearned(var0) {
  if(!analyticslogenabled()) {
    return;
  }

  var1 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var1 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("analytics_mp_super_earned", ["match_time", var0, "player_id", var1]);
}

function logevent_awardgained(var0) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("analytics_mp_awards", ["award_message", var0]);
}

function logevent_giveplayerxp(var0, var1, var2, var3) {
  if(!analyticslogenabled()) {
    return;
  }

  var4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var4 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("analytics_mp_player_xp", ["current_prestige", var0, "current_level", var1, "xp_gained", var2, "xp_source", var3, "player_id", var4]);
}

function logevent_givempweaponxp(var0, var1, var2, var3, var4) {
  if(!analyticslogenabled()) {
    return;
  }

  var5 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var5 = self.analyticslog.playerid;
  }

  var6 = createheadicon(var0);
  getentitylessscriptablearray("analytics_mp_weapon_xp", ["weapon", var6, "current_prestige", var1, "current_level", var2, "xp_gained", var3, "xp_source", var4, "player_id", var5]);
}

function logevent_sendplayerindexdata() {
  if(!analyticslogenabled()) {
    return;
  }

  var0 = [];
  var1 = [];
  var2 = 0;

  for(var2 = 0; var2 < 12; var2++) {
    var0 = 0;
    var1 = "";
  }

  var2 = 0;

  foreach(var4 in level.players) {
    if(!isai(var4)) {
      var0 = var4.analyticslog.playerid;
      var1 = var4 getxuid();
    }

    var2 += 1;
  }

  getentitylessscriptablearray("analytics_match_player_index_init", ["player1_index", var0[0], "player1_xuid", var1[0], "player2_index", var0[1], "player2_xuid", var1[1], "player3_index", var0[2], "player3_xuid", var1[2], "player4_index", var0[3], "player4_xuid", var1[3], "player5_index", var0[4], "player5_xuid", var1[4], "player6_index", var0[5], "player6_xuid", var1[5], "player7_index", var0[6], "player7_xuid", var1[6], "player8_index", var0[7], "player8_xuid", var1[7], "player9_index", var0[8], "player9_xuid", var1[8], "player10_index", var0[9], "player10_xuid", var1[9], "player11_index", var0[10], "player11_xuid", var1[10], "player12_index", var0[11], "player12_xuid", var1[11]]);
}

function analyticsspawnlogenabled() {
  return getdvarint("NTOSMKNMSM") != 0;
}

function is_spawnid_a_less_than_b(var0, var1) {
  return var0 < var1;
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
  var0 = game["spawnCount"];
  var1 = game["spawnIdsToBeInstrumented"];
  var2 = game["nextSpawnToBeInstrumented"];

  if(isDefined(var0) && isDefined(var1) && isDefined(var2)) {
    level.spawncount = var0;
    level.spawnidstobeinstrumented = var1;
    level.nextspawntobeinstrumented = var2;
    return;
  }

  level.spawncount = 0;
  level.spawnidstobeinstrumented = [];
  level.nextspawntobeinstrumented = 0;
  var3 = getdvarint("SOOKORNPT");
  var4 = analytics_getmaxspawneventsforcurrentmode();
  var5 = [];

  for(var6 = 0; var6 < var3; var6++) {
    var7 = randomintrange(20, var4);

    if(isDefined(var5[var7])) {
      level.spawnidstobeinstrumented[var6] = -1;
      continue;
    }

    var5 = 1;
    level.spawnidstobeinstrumented[var6] = var7;
  }

  level.spawnidstobeinstrumented = scripts\engine\utility::array_sort_with_func(level.spawnidstobeinstrumented, &is_spawnid_a_less_than_b);
}

function analyticssend_shouldsenddata(var0) {
  if(isDefined(level.nextspawntobeinstrumented) && isDefined(level.spawnidstobeinstrumented)) {
    if(level.nextspawntobeinstrumented < level.spawnidstobeinstrumented.size) {
      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == -1) {
        level.nextspawntobeinstrumented++;
      }

      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == var0) {
        level.nextspawntobeinstrumented++;
        return true;
      }
    }
  }

  return false;
}

function analyticssend_spawntype(var0, var1, var2, var3) {
  var4 = getglobalfrontlineinfo();
  var5 = var4.midpoint;
  var6 = 0;
  var7 = 0;
  var8 = 0;

  if(isDefined(var5)) {
    var6 = var5[0];
    var7 = var5[1];
    var8 = var5[2];
  }

  var9 = 0;

  if(isDefined(var4.teamdiffyaw)) {
    var9 = var4.teamdiffyaw;
  }

  var10 = var4.isactive[var1];
  var11 = 0;

  if(isDefined(var4.disabledreason) && isDefined(var4.disabledreason[var1])) {
    var11 = var4.disabledreason[var1];
  }

  var12 = level.spawnglobals.logicvariantid;
  var13 = 0;

  if(isDefined(level.spawnglobals.buddyplayerid)) {
    var13 = level.spawnglobals.buddyplayerid;
    level.spawnglobals.buddyplayerid = 0;
  }

  bbreportspawntypes(var6, var7, var8, var9, var3, var10, var11, var2, var12, var13);
}

function analyticssend_spawnplayerdetails(var0, var1, var2) {
  foreach(var4 in level.players) {
    if(scripts\mp\utility\player::isreallyalive(var4)) {
      var5 = var4 getplayerangles();
      var6 = vectortoyaw(var5);
      var7 = var4.origin[0];
      var8 = var4.origin[1];
      var9 = var4.origin[2];
      var10 = 0;

      if(var4 == var0) {
        var10 = 1;
      }

      var11 = 0;

      if(isDefined(var0.lastattacker) && var0.lastattacker == var4) {
        var11 = 1;
      }

      var12 = 0;

      if(var4.team == "axis") {
        var12 = 1;
      } else if(var4.team == "allies") {
        var12 = 2;
      }

      var13 = 0;

      if(isDefined(var4.analyticslog.playerid)) {
        var13 = var4.analyticslog.playerid;
      }

      bbreportspawnplayerdetails(var2, var6, var7, var8, var9, var13, var12, var10, var11);
    }
  }
}

function analyticssend_spawnfactors(var0, var1, var2, var3) {
  foreach(var5 in level.spawnglobals.spawnpointslist) {
    var6 = var5.totalscore;
    var7 = var5.analytics.allyaveragedist;
    var8 = var5.analytics.enemyaveragedist;
    var9 = var5.analytics.timesincelastspawn;
    var10 = 0;

    if(isDefined(var0.lastspawnpoint) && var0.lastspawnpoint == var5) {
      var10 = 1;
    }

    var11 = 0;

    if(var3 == var5) {
      var11 = 1;
    }

    var12 = var5.analytics.maxenemysightfraction;
    var13 = var5.analytics.randomscore;
    var14 = var5.analytics.spawnusedbyenemies;
    var15 = 0;

    if(isDefined(var5.lastspawnteam) && var5.lastspawnteam == "axis") {
      var15 = 1;
    } else if(isDefined(var5.lastspawnteam) && var5.lastspawnteam == "allies") {
      var15 = 2;
    }

    var16 = var5.lastspawntime;
    var17 = var5.analytics.maxjumpingenemysightfraction;
    var18 = 0;

    if(isDefined(var5.index) && var5.index <= 1023) {
      var18 = var5.index;
    }

    var19 = 0;

    if(isDefined(var5.analytics) && isDefined(var5.analytics.spawntype)) {
      var19 = var5.analytics.spawntype;
    }

    var20 = 0;

    if(isDefined(var5.badspawnreason)) {
      var20 = var5.badspawnreason;
    }

    bbreportspawnfactors(2, var6, var12, var17, var13, var2, var7, var8, var11, var10, var15, var18, var14, var9, var19, var20);
  }
}

function analytics_getmaxspawneventsforcurrentmode() {
  var0 = 120;

  if(isDefined(scripts\mp\utility\game::getgametype())) {
    if(scripts\mp\utility\game::getgametype() == "war") {
      var0 = 120;
    } else if(scripts\mp\utility\game::getgametype() == "dom") {
      var0 = 120;
    } else if(scripts\mp\utility\game::getgametype() == "conf") {
      var0 = 120;
    } else if(scripts\mp\utility\game::getgametype() == "front") {
      var0 = 40;
    } else if(scripts\mp\utility\game::getgametype() == "sd") {
      var0 = 50;
    } else if(scripts\mp\utility\game::getgametype() == "dm") {
      var0 = 50;
    } else if(scripts\mp\utility\game::getgametype() == "koth") {
      var0 = 125;
    } else if(scripts\mp\utility\game::getgametype() == "ctf") {
      var0 = 50;
    } else if(scripts\mp\utility\game::getgametype() == "tdef") {
      var0 = 120;
    } else if(scripts\mp\utility\game::getgametype() == "siege") {
      var0 = 25;
    } else if(scripts\mp\utility\game::getgametype() == "gun") {
      var0 = 50;
    } else if(scripts\mp\utility\game::getgametype() == "sr") {
      var0 = 25;
    } else if(scripts\mp\utility\game::getgametype() == "grind") {
      var0 = 75;
    } else if(scripts\mp\utility\game::getgametype() == "pill") {
      var0 = 75;
    } else if(scripts\mp\utility\game::getgametype() == "ball") {
      var0 = 50;
    }
  }

  return var0;
}

function logevent_reportgamescore(var0, var1, var2) {
  if(!analyticslogenabled()) {
    return;
  }

  var3 = 1;

  if(!isDefined(var2)) {
    var2 = -1;
  }

  getentitylessscriptablearray("analytics_mp_score_event", ["score_type", var3, "score_points", var0, "score_eventid", var2, "game_time", var1, "player_id", self.analyticslog.playerid]);
}

function logevent_reportstreakscore(var0, var1, var2) {
  if(!analyticslogenabled()) {
    return;
  }

  var3 = 2;

  if(!isDefined(var2)) {
    var2 = -1;
  }

  getentitylessscriptablearray("analytics_mp_score_event", ["score_type", var3, "score_points", var0, "score_eventid", var2, "game_time", var1, "player_id", self.analyticslog.playerid]);
}

function logevent_reportsuperscore(var0, var1) {
  if(!analyticslogenabled()) {
    return;
  }

  var2 = 3;
  getentitylessscriptablearray("analytics_mp_score_event", ["score_type", var2, "score_points", var0, "game_time", var1, "player_id", self.analyticslog.playerid]);
}

function logevent_nvgtoggled(var0, var1, var2, var3, var4, var5) {
  if(!analyticslogenabled()) {
    return;
  }

  var6 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var6 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("dlog_event_gamemp_nvg_toggle", ["playerid", var6, "game_time", var0, "player_life_index", var1, "x", var2[0], "y", var2[1], "z", var2[2], "enabled", var3, "duration", var4, "disable_reason", var5]);
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

function logevent_playerhealed(var0, var1, var2) {
  var3 = isDefined(var2);

  if(!var3) {
    var2 = var0;
  }

  var0 dlog_recordplayerevent("dlog_event_player_heal", ["reviver", var2, "player_life_index", var0.matchdatalifeindex, "pos_x", var0.origin[0], "pos_y", var0.origin[1], "pos_z", var0.origin[2], "heal_ammount", var1, "was_revived", var3]);
}

function ref_119b7(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  var0 dlog_recordplayerevent("dlog_event_player_regen", ["player_life_index", var0.matchdatalifeindex, "heal_amount", var1]);
}

function logevent_fieldupgradeearned(var0, var1) {
  var0 dlog_recordplayerevent("dlog_event_player_field_upgrade_earned", ["player_life_index", var0.matchdatalifeindex, "pos_x", var0.origin[0], "pos_y", var0.origin[1], "pos_z", var0.origin[2], "field_upgrade_index", var1]);
}

function logevent_fieldupgradeactivated(var0, var1) {
  var0 dlog_recordplayerevent("dlog_event_player_field_upgrade_activated", ["player_life_index", var0.matchdatalifeindex, "pos_x", var0.origin[0], "pos_y", var0.origin[1], "pos_z", var0.origin[2], "field_upgrade_index", var1]);
}

function logevent_fieldupgradeexpired(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var0 dlog_recordplayerevent("dlog_event_player_field_upgrade_expired", ["player_life_index", var0.matchdatalifeindex, "pos_x", var0.origin[0], "pos_y", var0.origin[1], "pos_z", var0.origin[2], "field_upgrade_index", var1, "efficacy", var2, "was_destroyed", var3]);
}

function logevent_killstreakavailable(var0, var1, var2, var3, var4, var5) {
  var0 dlog_recordplayerevent("dlog_event_kill_streak_available", ["lifeindex", var1, "killstreak_name", var2, "killstreak_pickedup", var3, "time_msfrommatchstart", var4, "playerposx", var5[0], "playerposy", var5[1], "playerposz", var5[2]]);
}

function logevent_killstreakactivated(var0, var1, var2, var3, var4, var5) {
  var0 dlog_recordplayerevent("dlog_event_kill_streak_activated", ["lifeindex", var1, "killstreak_name", var2, "killstreak_pickedup", var3, "time_msfrommatchstart", var4, "playerposx", var5[0], "playerposy", var5[1], "playerposz", var5[2]]);
}

function logevent_killstreakexpired(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(!isDefined(var0)) {
    return;
  }

  var11 = scripts\mp\matchdata::gettimefrommatchstart(var4);
  var0 dlog_recordplayerevent("dlog_event_kill_streak_expired", ["lifeindex", var1, "killstreak_name", var2, "killstreak_pickedup", var3, "expiration_thru_death", var6, "shots", var7, "hits", var8, "kills", var9, "score", var10, "time_msfrommatchstart", var11, "playerposx", var5[0], "playerposy", var5[1], "playerposz", var5[2]]);
}

function ref_119bf(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    var4 = "";
  }

  var0 dlog_recordplayerevent("dlog_event_player_xp_earned", ["player_life_index", var0.matchdatalifeindex, "player_xp_earned", var1, "weapon_s", var2, "weapon_xp_earned", var3, "xp_event", var4]);
}

function ref_119ba(var0, var1) {
  var0 dlog_recordplayerevent("dlog_event_player_spawnselection_choice", ["player_life_index", var0.matchdatalifeindex, "selection", var1]);
}

function ref_119b1(var0, var1, var2, var3) {
  var0 dlog_recordplayerevent("dlog_event_player_challenge_item_unlocked", ["item_unlock_ref", var1, "item_type", var2, "item_id", var3]);
}