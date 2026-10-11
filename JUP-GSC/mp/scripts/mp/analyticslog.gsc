/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\analyticslog.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\matchdata;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#namespace analyticslog;

function init() {
  setdvarifuninitialized(@ "hash_c8944dc52325691f", 0);
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
  return getdvarint(@ "hash_c8944dc52325691f") == 1;
}

function getuniqueobjectid() {
  id = level.analyticslog.nextobjectid;
  level.analyticslog.nextobjectid++;
  return id;
}

function cacheplayeraction(actionbit) {
  if(!isDefined(self.analyticslog.cachedactions)) {
    self.analyticslog.cachedactions = 0;
  }

  self.analyticslog.cachedactions |= actionbit;
}

function watchforconnectedplayers() {
  if(!analyticsactive()) {
    return;
  }

  while(true) {
    level waittill("connected", player);
    player logevent_playerconnected();
    player thread watchforbasicplayerevents();
    player thread watchforplayermovementevents();
    player thread watchforusermessageevents();
  }
}

function watchforbasicplayerevents() {
  self endon("disconnect");

  if(!analyticslogenabled()) {
    return;
  }

  while(true) {
    notifyvalue = waittill_any_return_no_endon_death_5("adjustedStance", "jumped", "weapon_fired", "reload_start", "spawned_player");

    if(notifyvalue == "adjustedStance") {
      checkstancestatus();
      continue;
    }

    if(notifyvalue == "jumped") {
      cacheplayeraction(4);
      continue;
    }

    if(notifyvalue == "weapon_fired") {
      cacheplayeraction(8);
      continue;
    }

    if(notifyvalue == "reload_start") {
      cacheplayeraction(16);
      continue;
    }

    if(notifyvalue == "spawned_player") {
      thread logevent_playerspawn();
      thread logevent_spawnpointupdate();
    }
  }
}

function watchforplayermovementevents() {
  self endon("disconnect");

  if(!analyticslogenabled()) {
    return;
  }

  while(true) {
    notifyvalue = waittill_any_return_no_endon_death_3("doubleJumpBegin", "doubleJumpEnd", "sprint_slide_begin");

    if(notifyvalue == "doubleJumpBegin") {
      cacheplayeraction(64);
      continue;
    }

    if(notifyvalue == "doubleJumpEnd") {
      cacheplayeraction(128);
      continue;
    }

    if(notifyvalue == "sprint_slide_begin") {
      cacheplayeraction(256);
    }
  }
}

function watchforusermessageevents() {
  self endon("disconnect");

  if(isai(self)) {
    return;
  }

  if(getdvarint(@ "hash_ff689af941dd10a1", 0) == 0) {
    return;
  }

  self notifyonplayercommand("log_user_event_start", "+actionslot 3");
  self notifyonplayercommand("log_user_event_end", "-actionslot 3");
  self notifyonplayercommand("log_user_event_generic_event", "+gostand");

  while(true) {
    self waittill("log_user_event_start");
    notification = waittill_any_return_2("log_user_event_end", "log_user_event_generic_event");

    if(isDefined(notification) && notification == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      logevent_message(self.name, self.origin, "Generic User Event");
    }
  }
}

function checkstancestatus() {
  stance = self getstance();

  if(stance == "prone") {
    cacheplayeraction(1);
    return;
  }

  if(stance == "crouch") {
    cacheplayeraction(2);
  }
}

function logallplayerposthink() {
  if(!analyticslogenabled()) {
    return;
  }

  while(true) {
    timestart = gettime();
    players = level.players;

    foreach(player in players) {
      if(!shouldplayerlogevents(player)) {
        continue;
      }

      if(isDefined(player) && isreallyalive(player)) {
        player logevent_path();
        player logevent_scoreupdate();
        waitframe();
      }
    }

    wait max(0.05, 1.5 - (gettime() - timestart) / 1000);
  }
}

function recordbreadcrumbdata() {
  level endon("game_ended");

  if(getdvarint(@ "hash_35bfb8187f185ae7", 1) == 0) {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    var_2fe6a798e49f4de6 = getdvarfloat(@ "hash_7c8bee10dba43fe7", 4);
    var_db5e61a22ce91ab9 = getdvarint(@ "hash_4bf88114393d1628", 2);
  } else {
    var_2fe6a798e49f4de6 = getdvarfloat(@ "hash_246c8305339e703e", 2);
    var_db5e61a22ce91ab9 = getdvarint(@ "hash_9361b1490151da6f", 20);
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  while(true) {
    playercount = level.players.size;
    starttime = gettime();

    if(!istrue(game["isLaunchChunk"])) {
      startplayer = 0;

      while(startplayer < playercount) {
        for(updateindex = 0; updateindex < var_db5e61a22ce91ab9; updateindex++) {
          playerindex = startplayer + updateindex;
          player = level.players[playerindex];

          if(!isDefined(player)) {
            continue;
          }

          if(!isDefined(player.team)) {
            continue;
          }

          if(!isreallyalive(player)) {
            continue;
          }

          if(player.team == "spectator") {
            continue;
          }

          if(player.sessionstate != "playing") {
            continue;
          }

          if(isai(player)) {
            continue;
          }

          persstat = player scripts\mp\utility\stats::getpersstat("telemetry");

          if(!isDefined(persstat) || !isDefined(persstat.life) || !isDefined(persstat.life.life_index)) {
            continue;
          }

          isads = player isplayerads();
          msfrommatchstart = scripts\mp\matchdata::gettimefrommatchstart(gettime());
          player recordbreadcrumbdataforplayer(msfrommatchstart, persstat.life.life_index, isads);
        }

        waitframe();
        startplayer += var_db5e61a22ce91ab9;
      }
    }

    updatetime = (gettime() - starttime) * 0.001;
    waittime = max(var_2fe6a798e49f4de6 - updatetime, level.framedurationseconds);
    wait waittime;
  }
}

function getpathactionvalue() {
  actions = ter_op(isDefined(self.analyticslog.cachedactions), self.analyticslog.cachedactions, 0);

  if(self iswallrunning()) {
    actions |= 32;
  }

  return actions;
}

function clearpathactionvalue() {
  self.analyticslog.cachedactions = 0;
  checkstancestatus();
}

function buildkilldeathactionvalue() {
  actionvalue = 0;
  stance = self getstance();

  if(stance == "prone") {
    actionvalue |= 1;
  } else if(stance == "crouch") {
    actionvalue |= 2;
  }

  if(self isjumping()) {
    actionvalue |= 4;
  }

  if(isDefined(self.lastshotfiredtime) && gettime() - self.lastshotfiredtime < 500) {
    actionvalue |= 8;
  }

  if(self isreloading()) {
    actionvalue |= 16;
  }

  return actionvalue;
}

function buildloadoutstring() {
  loadoutstring = "archetype=" + self.loadoutarchetype + ";" + "powerPrimary=" + self.loadoutequipmentprimary + ";" + "powerSecondary=" + self.loadoutequipmentsecondary + ";" + "weaponPrimary\t =" + self.primaryweapon + ";" + "weaponSecondary =" + self.secondaryweapon + ";";
  return loadoutstring;
}

function buildspawnpointstatestring(spawnpoint) {
  output = "";

  if(isDefined(spawnpoint.lastbucket)) {
    if(isDefined(spawnpoint.lastbucket["allies"])) {
      output += "alliesBucket=" + spawnpoint.lastbucket["allies"] + ";";
    }

    if(isDefined(spawnpoint.lastbucket["axis"])) {
      output += "axisBucket=" + spawnpoint.lastbucket["axis"] + ";";
    }
  }

  return output;
}

function logevent_path() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_53f4b69ae494195a = anglesToForward(self getplayerangles());
  dlog_recordevent("gamemp_" + "path", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_53f4b69ae494195a[0], "gun_orienty", var_53f4b69ae494195a[1], "gun_orientz", var_53f4b69ae494195a[2], "action", getpathactionvalue(), "health", getsantizedhealth()]);
  clearpathactionvalue();
}

function logevent_playerspawn() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_c6c41b96b7c2ef2a = isDefined(self.lastspawnpoint) && isDefined(self.lastspawnpoint.buddyspawn) && self.lastspawnpoint.buddyspawn;
  playerforward = anglesToForward(self.angles);
  dlog_recordevent("gamemp_" + "spawn_in", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", playerforward[0], "orienty", playerforward[1], "orientz", playerforward[2], "loadout", buildloadoutstring(), "type", ter_op(var_c6c41b96b7c2ef2a, "Buddy", "Normal"), "team", self.team]);
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

  super = undefined;

  if(isDefined(self.changedarchetypeinfo)) {
    super = self.changedarchetypeinfo.super;
  } else {
    super = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");
  }

  xuid = self getxuid();
  dlog_recordevent("gamemp_" + "player_connect", ["playerid", self.analyticslog.playerid, "player_name", self.name, "player_xuid", xuid, "player_super_name", super]);
}

function logevent_playerdeath(attacker, meansofdeath, weaponname) {
  if(!shouldplayerlogevents(self) || !isPlayer(self)) {
    return;
  }

  var_53f4b69ae494195a = anglesToForward(self getplayerangles());
  var_77295bbd7b1b8155 = -1;
  attackerposx = 0;
  attackerposy = 0;
  attackerposz = 0;
  var_40cfb0f1536d4858 = 0;
  var_40cfb1f1536d4a8b = 0;
  var_40cfb2f1536d4cbe = 0;
  attackerteam = "s";
  attackerlifeid = 0;

  if(isDefined(attacker) && isPlayer(attacker)) {
    var_77295bbd7b1b8155 = attacker.analyticslog.playerid;

    if(isDefined(attacker.team)) {
      if(attacker.team == "axis") {
        attackerteam = "a";
      } else {
        attackerteam = "l";
      }
    }

    if(isDefined(attacker.origin)) {
      attackerposx = attacker.origin[0];
      attackerposy = attacker.origin[1];
      attackerposz = attacker.origin[2];
    }

    if(isDefined(attacker.lifeid)) {
      attackerlifeid = attacker.lifeid;
    }

    var_fde6939445aae30 = anglesToForward(attacker getplayerangles());

    if(isDefined(var_fde6939445aae30)) {
      var_40cfb0f1536d4858 = var_fde6939445aae30[0];
      var_40cfb1f1536d4a8b = var_fde6939445aae30[1];
      var_40cfb2f1536d4cbe = var_fde6939445aae30[2];
    }
  }

  deathid = level.analyticslog.nextdeathid;
  level.analyticslog.nextdeathid++;
  weaponname = ter_op(isDefined(weaponname), weaponname, "None");
  victimteam = "s";

  if(self.team == "axis") {
    victimteam = "a";
  } else {
    victimteam = "l";
  }

  dlog_recordevent("gamemp_" + "death", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_53f4b69ae494195a[0], "gun_orienty", var_53f4b69ae494195a[1], "gun_orientz", var_53f4b69ae494195a[2], "weapon", weaponname, "mean_of_death", ter_op(isDefined(meansofdeath), meansofdeath, "None"), "attackerid", var_77295bbd7b1b8155, "action", buildkilldeathactionvalue(), "server_death_id", deathid, "victim_life_index", self.lifeid, "attacker_life_index", attackerlifeid, "victim_team", victimteam, "attacker_team", attackerteam, "attacker_pos_x", attackerposx, "attacker_pos_y", attackerposy, "attacker_pos_z", attackerposz, "attacker_gun_orientx", var_40cfb0f1536d4858, "attacker_gun_orienty", var_40cfb1f1536d4a8b, "attacker_gun_orientz", var_40cfb2f1536d4cbe, "victim_weapon", self.primaryweapon]);

  if(getdvarint(@ "hash_eea95a7206a9ebeb")) {
    attackermounttype = "NO_ATTACKER";

    if(isDefined(attacker) && isPlayer(attacker)) {
      attackermounttype = attacker playermounttype();
    }

    victimmounttype = self playermounttype();
    dlog_recordevent("dlog_event_gamemp_death_mount", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_53f4b69ae494195a[0], "gun_orienty", var_53f4b69ae494195a[1], "gun_orientz", var_53f4b69ae494195a[2], "weapon", weaponname, "mean_of_death", ter_op(isDefined(meansofdeath), meansofdeath, "None"), "attackerid", var_77295bbd7b1b8155, "action", buildkilldeathactionvalue(), "server_death_id", deathid, "victim_life_index", self.lifeid, "attacker_life_index", attackerlifeid, "victim_team", victimteam, "attacker_team", attackerteam, "attacker_pos_x", attackerposx, "attacker_pos_y", attackerposy, "attacker_pos_z", attackerposz, "attacker_gun_orientx", var_40cfb0f1536d4858, "attacker_gun_orienty", var_40cfb1f1536d4a8b, "attacker_gun_orientz", var_40cfb2f1536d4cbe, "victim_weapon", self.primaryweapon, "attacker_mount_type", attackermounttype, "victim_mount_type", victimmounttype]);
  }

  if(isDefined(meansofdeath) && isexplosivedamagemod(meansofdeath)) {
    logevent_explosion(ter_op(isDefined(weaponname), weaponname, "generic"), self.origin, attacker, 1);
  }

  if(isDefined(self.attackers)) {
    foreach(assister in self.attackers) {
      if(isDefined(assister) && isPlayer(assister) && assister != attacker) {
        logevent_assist(assister.analyticslog.playerid, deathid, weaponname);
      }
    }
  }
}

function logevent_playerkill(victim, meansofdeath, weaponname) {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_53f4b69ae494195a = anglesToForward(self getplayerangles());
  dlog_recordevent("gamemp_" + "kill", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_53f4b69ae494195a[0], "gun_orienty", var_53f4b69ae494195a[1], "gun_orientz", var_53f4b69ae494195a[2], "weapon", ter_op(isDefined(weaponname), weaponname, "None"), "mean_of_kill", ter_op(isDefined(meansofdeath), meansofdeath, "None"), "victimid", ter_op(isDefined(victim) && isPlayer(victim), victim.analyticslog.playerid, "-1"), "action", buildkilldeathactionvalue(), "attacker_health", getsantizedhealth(), "victim_pixel_count", 0]);
}

function logevent_explosion(type, center, var_e83217ed09c27313, duration, direction) {
  if(!analyticslogenabled()) {
    return;
  }

  if(!isDefined(direction)) {
    direction = (1, 0, 0);
  }

  dlog_recordevent("gamemp_" + "explosion", ["playerid", var_e83217ed09c27313.analyticslog.playerid, "x", center[0], "y", center[1], "z", center[2], "orientx", direction[0], "orienty", direction[1], "orientz", direction[2], "duration", duration, "type", type]);
}

function logevent_spawnpointupdate() {
  if(!analyticslogenabled()) {
    return;
  }

  if(!isDefined(level.spawnpoints)) {
    return;
  }

  foreach(spawnpoint in level.spawnpoints) {
    dlog_recordevent("gamemp_" + "spawn_point", ["x", spawnpoint.origin[0], "y", spawnpoint.origin[1], "z", spawnpoint.origin[2], "allies_score", ter_op(isDefined(spawnpoint.lastscore["allies"]), spawnpoint.lastscore["allies"], 0), "axis_score", ter_op(isDefined(spawnpoint.lastscore["axis"]), spawnpoint.lastscore["axis"], 0), "allies_max_score", ter_op(isDefined(spawnpoint.totalpossiblescore), spawnpoint.totalpossiblescore, 0), "axis_max_score", ter_op(isDefined(spawnpoint.totalpossiblescore), spawnpoint.totalpossiblescore, 0), "state", buildspawnpointstatestring(spawnpoint)]);
  }
}

function logevent_frontlineupdate(startpos, endpos, alliescenter, axiscenter, ison) {
  if(!analyticslogenabled()) {
    return;
  }

  dlog_recordevent("gamemp_" + "front_line", ["startx", startpos[0], "starty", startpos[1], "endx", endpos[0], "endy", endpos[1], "axis_centerx", axiscenter[0], "axis_centery", axiscenter[1], "allies_centerx", alliescenter[0], "allies_centery", alliescenter[1], "state", ison]);
}

function logevent_gameobject(type, uniqueid, pos, ownerid, state) {
  if(!analyticslogenabled()) {
    return;
  }

  dlog_recordevent("gamemp_" + "object", ["uniqueid", uniqueid, "x", pos[0], "y", pos[1], "z", pos[2], "ownerid", ownerid, "type", type, "state", state]);
}

function logevent_message(ownerid, pos, message) {
  if(!analyticslogenabled()) {
    return;
  }

  dlog_recordevent("gamemp_" + "message", ["ownerid", ownerid, "x", pos[0], "y", pos[1], "z", pos[2], "message", message]);
}

function logevent_tag(message) {
  if(!analyticslogenabled()) {
    return;
  }

  bbprint("gamemp_" + "matchtags", "message %s", message);
}

function logevent_powerused(powername, state) {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  playerforward = anglesToForward(self.angles);
  dlog_recordevent("gamemp_" + "power", ["ownerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", playerforward[0], "orienty", playerforward[1], "orientz", playerforward[2], "type", powername, "state", state]);
}

function logevent_scoreupdate() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  playerforward = anglesToForward(self.angles);
  dlog_recordevent("gamemp_" + "scoreboard", ["ownerid", self.analyticslog.playerid, "score", self.score]);
}

function logevent_minimapcorners() {
  if(!analyticslogenabled()) {
    return;
  }

  corners = getEntArray("minimap_corner", "targetname");

  if(!isDefined(corners) || corners.size != 2) {
    return;
  }

  dlog_recordevent("gamemp_" + "map", ["cornera_x", corners[0].origin[0], "cornera_y", corners[0].origin[1], "cornerb_x", corners[1].origin[0], "cornerb_y", corners[1].origin[1], "north", getnorthyaw()]);
}

function logevent_assist(playerid, deathid, weapon) {
  if(!analyticslogenabled()) {
    return;
  }

  dlog_recordevent("gamemp_" + "assists", ["playerid", playerid, "server_death_id", deathid, "weapon", weapon]);
}

function getsantizedhealth() {
  return int(clamp(self.health, 0, 100000));
}

function shouldplayerlogevents(player) {
  if(!analyticslogenabled()) {
    return false;
  }

  if(!isDefined(player.team) || player.team == "spectator" || player.sessionstate != "playing" && player.sessionstate != "dead") {
    return false;
  }

  return true;
}

function logmatchtags() {
  dvartag = getDvar(@ "scr_analytics_tag", "");

  if(dvartag != "") {
    logevent_tag(dvartag);
  }

  if(matchmakinggame()) {
    logevent_tag("OnlineMatch");
    return;
  }

  if(getdvarint(@ "xblive_privatematch")) {
    logevent_tag("PrivateMatch");
    return;
  }

  if(!getdvarint(@ "onlinegame")) {
    logevent_tag("OfflineMatch");
  }
}

function logevent_superended(super_name, time_to_use, num_hits, num_kills) {
  if(!analyticslogenabled()) {
    return;
  }

  player_id = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    player_id = self.analyticslog.playerid;
  }

  dlog_recordevent("analytics_mp_supers", ["super_name", super_name, "time_to_use", time_to_use, "num_hits", num_hits, "num_kills", num_kills, "player_id", player_id]);
}

function logevent_superearned(match_time) {
  if(!analyticslogenabled()) {
    return;
  }

  player_id = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    player_id = self.analyticslog.playerid;
  }

  dlog_recordevent("analytics_mp_super_earned", ["match_time", match_time, "player_id", player_id]);
}

function logevent_awardgained(award_message) {
  if(!analyticslogenabled()) {
    return;
  }

  if(isxhash(award_message)) {
    award_message = getxhashhexname(award_message);
  }

  dlog_recordevent("analytics_mp_awards", ["award_message", award_message]);
}

function logevent_giveplayerxp(current_prestige, current_level, xp_gained, source) {
  if(!analyticslogenabled()) {
    return;
  }

  player_id = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    player_id = self.analyticslog.playerid;
  }

  dlog_recordevent("analytics_mp_player_xp", ["current_prestige", current_prestige, "current_level", current_level, "xp_gained", xp_gained, "xp_source", source, "player_id", player_id]);
}

function logevent_givempweaponxp(objweapon, current_prestige, current_level, xp_gained, source) {
  if(!analyticslogenabled()) {
    return;
  }

  player_id = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    player_id = self.analyticslog.playerid;
  }

  weapon_name = getcompleteweaponname(objweapon);
  dlog_recordevent("analytics_mp_weapon_xp", ["weapon", weapon_name, "current_prestige", current_prestige, "current_level", current_level, "xp_gained", xp_gained, "xp_source", source, "player_id", player_id]);
}

function logevent_sendplayerindexdata() {
  if(!analyticslogenabled()) {
    return;
  }

  var_d6228dada168a8a6 = [];
  var_7866d1bb4718ac7 = [];
  playercount = 0;

  for(playercount = 0; playercount < 12; playercount++) {
    var_d6228dada168a8a6[playercount] = 0;
    var_7866d1bb4718ac7[playercount] = "";
  }

  playercount = 0;

  foreach(player in level.players) {
    if(!isai(player)) {
      var_d6228dada168a8a6[playercount] = player.analyticslog.playerid;
      var_7866d1bb4718ac7[playercount] = player getxuid();
    }

    playercount += 1;
  }

  dlog_recordevent("analytics_match_player_index_init", ["player1_index", var_d6228dada168a8a6[0], "player1_xuid", var_7866d1bb4718ac7[0], "player2_index", var_d6228dada168a8a6[1], "player2_xuid", var_7866d1bb4718ac7[1], "player3_index", var_d6228dada168a8a6[2], "player3_xuid", var_7866d1bb4718ac7[2], "player4_index", var_d6228dada168a8a6[3], "player4_xuid", var_7866d1bb4718ac7[3], "player5_index", var_d6228dada168a8a6[4], "player5_xuid", var_7866d1bb4718ac7[4], "player6_index", var_d6228dada168a8a6[5], "player6_xuid", var_7866d1bb4718ac7[5], "player7_index", var_d6228dada168a8a6[6], "player7_xuid", var_7866d1bb4718ac7[6], "player8_index", var_d6228dada168a8a6[7], "player8_xuid", var_7866d1bb4718ac7[7], "player9_index", var_d6228dada168a8a6[8], "player9_xuid", var_7866d1bb4718ac7[8], "player10_index", var_d6228dada168a8a6[9], "player10_xuid", var_7866d1bb4718ac7[9], "player11_index", var_d6228dada168a8a6[10], "player11_xuid", var_7866d1bb4718ac7[10], "player12_index", var_d6228dada168a8a6[11], "player12_xuid", var_7866d1bb4718ac7[11]]);
}

function analyticsspawnlogenabled() {
  return getdvarint(@ "hash_906c263c7e34d59f") != 0;
}

function is_spawnid_a_less_than_b(a, b) {
  return a < b;
}

function analyticsstorespawndata() {
  if(isDefined(level.spawncount) && isDefined(level.spawnidstobeinstrumented) && isDefined(level.nextspawntobeinstrumented)) {
    game["spawnCount"] = level.spawncount;
    game["spawnIdsToBeInstrumented"] = level.spawnidstobeinstrumented;
    game["nextSpawnToBeInstrumented"] = level.nextspawntobeinstrumented;
  }
}

function analyticsdoesspawndataexist() {
  if(isDefined(level.spawncount) && isDefined(level.spawnidstobeinstrumented) && isDefined(level.nextspawntobeinstrumented)) {
    return true;
  }

  return false;
}

function analyticsinitspawndata() {
  spawncount = game["spawnCount"];
  var_684b19be1a3362f9 = game["spawnIdsToBeInstrumented"];
  nextspawntobeinstrumented = game["nextSpawnToBeInstrumented"];

  if(isDefined(spawncount) && isDefined(var_684b19be1a3362f9) && isDefined(nextspawntobeinstrumented)) {
    level.spawncount = spawncount;
    level.spawnidstobeinstrumented = var_684b19be1a3362f9;
    level.nextspawntobeinstrumented = nextspawntobeinstrumented;
    return;
  }

  level.spawncount = 0;
  level.spawnidstobeinstrumented = [];
  level.nextspawntobeinstrumented = 0;
  var_9b5e7bbe7bbe2095 = getdvarint(@ "hash_883352c04ceb60d0");
  var_f173d241cde30ed5 = scripts\mp\analyticslog::analytics_getmaxspawneventsforcurrentmode();
  var_ed9bcf1d68316223 = [];

  for(var_f7b3db25022143df = 0; var_f7b3db25022143df < var_9b5e7bbe7bbe2095; var_f7b3db25022143df++) {
    var_47839683093fa30e = randomintrange(20, var_f173d241cde30ed5);

    if(isDefined(var_ed9bcf1d68316223[var_47839683093fa30e])) {
      level.spawnidstobeinstrumented[var_f7b3db25022143df] = -1;
      continue;
    }

    var_ed9bcf1d68316223[var_47839683093fa30e] = 1;
    level.spawnidstobeinstrumented[var_f7b3db25022143df] = var_47839683093fa30e;
  }

  level.spawnidstobeinstrumented = array_sort_with_func(level.spawnidstobeinstrumented, &is_spawnid_a_less_than_b);
}

function analyticssend_shouldsenddata(spawnid) {
  if(isDefined(level.nextspawntobeinstrumented) && isDefined(level.spawnidstobeinstrumented)) {
    if(level.nextspawntobeinstrumented < level.spawnidstobeinstrumented.size) {
      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == -1) {
        level.nextspawntobeinstrumented++;
      }

      if(level.spawnidstobeinstrumented[level.nextspawntobeinstrumented] == spawnid) {
        level.nextspawntobeinstrumented++;
        return true;
      }
    }
  }

  return false;
}

function analyticssend_spawntype(spawn_pos, team_name, life_index, spawnid) {
  frontlineinfo = getglobalfrontlineinfo();
  frontline_midpoint = frontlineinfo.midpoint;
  var_a4a67d69520e0248 = 0;
  var_a4a67e69520e047b = 0;
  var_a4a67f69520e06ae = 0;

  if(isDefined(frontline_midpoint)) {
    var_a4a67d69520e0248 = frontline_midpoint[0];
    var_a4a67e69520e047b = frontline_midpoint[1];
    var_a4a67f69520e06ae = frontline_midpoint[2];
  }

  frontline_angle = 0;

  if(isDefined(frontlineinfo.teamdiffyaw)) {
    frontline_angle = frontlineinfo.teamdiffyaw;
  }

  var_2cf02e998291f5ea = frontlineinfo.isactive[team_name];
  var_b3372bbd4ec17e38 = 0;

  if(isDefined(frontlineinfo.disabledreason) && isDefined(frontlineinfo.disabledreason[team_name])) {
    var_b3372bbd4ec17e38 = frontlineinfo.disabledreason[team_name];
  }

  var_86f685e81768ea92 = level.spawnglobals.logicvariantid;
  buddyspawnid = 0;

  if(isDefined(level.spawnglobals.buddyplayerid)) {
    buddyspawnid = level.spawnglobals.buddyplayerid;
    level.spawnglobals.buddyplayerid = 0;
  }

  bbreportspawntypes(var_a4a67d69520e0248, var_a4a67e69520e047b, var_a4a67f69520e06ae, frontline_angle, spawnid, var_2cf02e998291f5ea, var_b3372bbd4ec17e38, life_index, var_86f685e81768ea92, buddyspawnid);
}

function analyticssend_spawnplayerdetails(spawnplayer, spawnorigin, spawnid) {
  foreach(player in level.players) {
    if(isreallyalive(player)) {
      player_orientation = player getplayerangles();
      player_yaw = vectortoyaw(player_orientation);
      player_position_x = player.origin[0];
      player_position_y = player.origin[1];
      player_position_z = player.origin[2];
      var_a4b47809b71bf9ce = 0;

      if(player == spawnplayer) {
        var_a4b47809b71bf9ce = 1;
      }

      var_1bf050cad818d5c0 = 0;

      if(isDefined(spawnplayer.lastattacker) && spawnplayer.lastattacker == player) {
        var_1bf050cad818d5c0 = 1;
      }

      player_team = 0;

      if(player.team == "axis") {
        player_team = 1;
      } else if(player.team == "allies") {
        player_team = 2;
      }

      player_id = 0;

      if(isDefined(player.analyticslog.playerid)) {
        player_id = player.analyticslog.playerid;
      }

      bbreportspawnplayerdetails(spawnid, player_yaw, player_position_x, player_position_y, player_position_z, player_id, player_team, var_a4b47809b71bf9ce, var_1bf050cad818d5c0);
    }
  }
}

function analyticssend_spawnfactors(spawnplayer, spawnpointlist, spawn_id, var_bac9c46b10034944) {
  println("<dev string:x1c>");

  foreach(spawnpoint in level.spawnglobals.spawnpointslist) {
    totalscore = spawnpoint.totalscore;
    allyaveragedist = spawnpoint.analytics.allyaveragedist;
    enemyaveragedist = spawnpoint.analytics.enemyaveragedist;
    timesincelastspawn = spawnpoint.analytics.timesincelastspawn;
    islastspawnpoint = 0;

    if(isDefined(spawnplayer.lastspawnpoint) && spawnplayer.lastspawnpoint == spawnpoint) {
      islastspawnpoint = 1;
    }

    var_7f1500b202ddad69 = 0;

    if(var_bac9c46b10034944 == spawnpoint) {
      var_7f1500b202ddad69 = 1;
    }

    maxenemysightfraction = spawnpoint.analytics.maxenemysightfraction;
    randomscore = spawnpoint.analytics.randomscore;
    spawnusedbyenemies = spawnpoint.analytics.spawnusedbyenemies;
    lastspawnteam = 0;

    if(isDefined(spawnpoint.lastspawnteam) && spawnpoint.lastspawnteam == "axis") {
      lastspawnteam = 1;
    } else if(isDefined(spawnpoint.lastspawnteam) && spawnpoint.lastspawnteam == "allies") {
      lastspawnteam = 2;
    }

    lastspawntime = spawnpoint.lastspawntime;
    maxjumpingenemysightfraction = spawnpoint.analytics.maxjumpingenemysightfraction;
    spawnpointid = 0;

    if(isDefined(spawnpoint.index) && spawnpoint.index <= 1023) {
      spawnpointid = spawnpoint.index;
    }

    spawn_type = 0;

    if(isDefined(spawnpoint.analytics) && isDefined(spawnpoint.analytics.spawntype)) {
      spawn_type = spawnpoint.analytics.spawntype;
    }

    var_a60b2840cb045255 = 0;

    if(isDefined(spawnpoint.badspawnreason)) {
      var_a60b2840cb045255 = spawnpoint.badspawnreason;
    }

    bbreportspawnfactors(2, totalscore, maxenemysightfraction, maxjumpingenemysightfraction, randomscore, spawn_id, allyaveragedist, enemyaveragedist, var_7f1500b202ddad69, islastspawnpoint, lastspawnteam, spawnpointid, spawnusedbyenemies, timesincelastspawn, spawn_type, var_a60b2840cb045255);
  }
}

function analytics_getmaxspawneventsforcurrentmode() {
  maxspawns = 120;

  if(isDefined(getgametype())) {
    if(getgametype() == "war") {
      maxspawns = 120;
    } else if(getgametype() == "dom") {
      maxspawns = 120;
    } else if(getgametype() == "conf") {
      maxspawns = 120;
    } else if(getgametype() == "front") {
      maxspawns = 40;
    } else if(getgametype() == "sd") {
      maxspawns = 50;
    } else if(getgametype() == "dm") {
      maxspawns = 50;
    } else if(getgametype() == "koth" || getgametype() == "koth_horde") {
      maxspawns = 125;
    } else if(getgametype() == "ctf") {
      maxspawns = 50;
    } else if(getgametype() == "tdef") {
      maxspawns = 120;
    } else if(getgametype() == "siege") {
      maxspawns = 25;
    } else if(getgametype() == "gun") {
      maxspawns = 50;
    } else if(getgametype() == "sr") {
      maxspawns = 25;
    } else if(getgametype() == "grind") {
      maxspawns = 75;
    } else if(getgametype() == "pill") {
      maxspawns = 75;
    } else if(getgametype() == "ball") {
      maxspawns = 50;
    }
  }

  return maxspawns;
}

function logevent_nvgtoggled(game_time, player_life_index, pos, enabled, duration, disable_reason) {
  if(!analyticslogenabled()) {
    return;
  }

  player_id = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    player_id = self.analyticslog.playerid;
  }

  dlog_recordevent("dlog_event_gamemp_nvg_toggle", ["playerid", player_id, "game_time", game_time, "player_life_index", player_life_index, "x", pos[0], "y", pos[1], "z", pos[2], "enabled", enabled, "duration", duration, "disable_reason", disable_reason]);
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

function logevent_playerhealed(player, amount, reviver) {
  amount = default_to(amount, 0);
  wasrevived = isDefined(reviver);

  if(!wasrevived) {
    reviver = player;
  }

  life_index = -1;

  if(isDefined(player scripts\mp\utility\stats::getpersstat("telemetry")) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index)) {
    life_index = player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index;
  }

  player dlog_recordplayerevent("dlog_event_player_heal", ["reviver", reviver, "player_life_index", life_index, "pos_x", player.origin[0], "pos_y", player.origin[1], "pos_z", player.origin[2], "heal_ammount", amount, "was_revived", wasrevived]);
}

function logevent_playerregen(player, amount) {
  if(!isDefined(player)) {
    return;
  }

  life_index = -1;

  if(isDefined(player scripts\mp\utility\stats::getpersstat("telemetry")) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index)) {
    life_index = player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index;
  }

  player dlog_recordplayerevent("dlog_event_player_regen", ["player_life_index", life_index, "heal_amount", amount]);
}

function logevent_fieldupgradeearned(player, refid) {
  life_index = -1;
  refid = default_to(refid, 0);

  if(isDefined(player scripts\mp\utility\stats::getpersstat("telemetry")) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index)) {
    life_index = player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index;
  }

  player dlog_recordplayerevent("dlog_event_player_field_upgrade_earned", ["player_life_index", life_index, "pos_x", player.origin[0], "pos_y", player.origin[1], "pos_z", player.origin[2], "field_upgrade_index", refid]);
}

function logevent_fieldupgradeactivated(player, refid) {
  life_index = -1;
  refid = default_to(refid, 0);

  if(isDefined(player scripts\mp\utility\stats::getpersstat("telemetry")) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index)) {
    life_index = player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index;
  }

  player dlog_recordplayerevent("dlog_event_player_field_upgrade_activated", ["player_life_index", life_index, "pos_x", player.origin[0], "pos_y", player.origin[1], "pos_z", player.origin[2], "field_upgrade_index", refid]);
}

function logevent_fieldupgradeexpired(player, refid, efficacy, wasdestroyed) {
  if(!isDefined(player)) {
    return;
  }

  refid = default_to(refid, 0);

  if(!isDefined(efficacy)) {
    efficacy = 0;
  }

  life_index = -1;

  if(isDefined(player scripts\mp\utility\stats::getpersstat("telemetry")) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index)) {
    life_index = player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index;
  }

  player dlog_recordplayerevent("dlog_event_player_field_upgrade_expired", ["player_life_index", life_index, "pos_x", player.origin[0], "pos_y", player.origin[1], "pos_z", player.origin[2], "field_upgrade_index", refid, "efficacy", efficacy, "was_destroyed", wasdestroyed]);
}

function logevent_killstreakavailable(player, lifeid, killstreakname, pickedup, matchtime, playerpos) {
  streaktype = "Killstreaks";

  if(istrue(player.scorestreaktype)) {
    streaktype = "Points";
  }

  player dlog_recordplayerevent("dlog_event_kill_streak_available", ["lifeindex", lifeid, "killstreak_name", killstreakname, "killstreak_pickedup", pickedup, "time_msfrommatchstart", matchtime, "playerposx", playerpos[0], "playerposy", playerpos[1], "playerposz", playerpos[2], "streak_type", getxhash(streaktype)]);
}

function logevent_killstreakactivated(player, lifeid, killstreakname, pickedup, matchtime, playerpos) {
  streaktype = "Killstreaks";

  if(istrue(player.scorestreaktype)) {
    streaktype = "Points";
  }

  player dlog_recordplayerevent("dlog_event_kill_streak_activated", ["lifeindex", lifeid, "killstreak_name", killstreakname, "killstreak_pickedup", pickedup, "time_msfrommatchstart", matchtime, "playerposx", playerpos[0], "playerposy", playerpos[1], "playerposz", playerpos[2], "streak_type", getxhash(streaktype)]);
}

function logevent_killstreakexpired(player, lifeid, killstreakname, pickedup, var_6befa2534acb8df6, playerpos, expiredbydeath, shotsfired, var_8f52823e77aca0d3, var_f5ff9a2f5217b3ec, var_7e6dbb913989cf29) {
  if(!isDefined(player)) {
    return;
  }

  expiredtime = scripts\mp\matchdata::gettimefrommatchstart(var_6befa2534acb8df6);
  streaktype = "Killstreaks";

  if(istrue(player.scorestreaktype)) {
    streaktype = "Points";
  }

  var_d3cf11436c80a43e = player dlog_recordplayerevent("dlog_event_kill_streak_expired", ["lifeindex", lifeid, "killstreak_name", killstreakname, "killstreak_pickedup", pickedup, "expiration_thru_death", expiredbydeath, "shots", shotsfired, "hits", var_8f52823e77aca0d3, "kills", var_f5ff9a2f5217b3ec, "score", var_7e6dbb913989cf29, "time_msfrommatchstart", expiredtime, "playerposx", playerpos[0], "playerposy", playerpos[1], "playerposz", playerpos[2], "streak_type", getxhash(streaktype)]);

  if(isDefined(player scripts\mp\utility\stats::getpersstat("telemetry")) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").kill_streak_expired_count) && var_d3cf11436c80a43e) {
    player.pers["telemetry"].kill_streak_expired_count++;
  }
}

function logevent_xpearned(player, playerxp, weaponname, weaponxp, type) {
  life_index = -1;

  if(isDefined(player scripts\mp\utility\stats::getpersstat("telemetry")) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index)) {
    life_index = player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index;
  }

  player dlog_recordplayerevent("dlog_event_player_xp_earned", ["player_life_index", life_index, "player_xp_earned", playerxp, "weapon_s", weaponname, "weapon_xp_earned", weaponxp, "xp_event", type]);
  scripts\mp\gametypes\br_analytics::function_cb3b3cbf2d1ac3f3(playerxp, weaponxp, life_index, weaponname, player, type);
}

function logevent_spawnselectionchoice(player, selection) {
  life_index = -1;

  if(isDefined(player scripts\mp\utility\stats::getpersstat("telemetry")) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life) && isDefined(player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index)) {
    life_index = player scripts\mp\utility\stats::getpersstat("telemetry").life.life_index;
  }

  player dlog_recordplayerevent("dlog_event_player_spawnselection_choice", ["player_life_index", life_index, "selection", selection]);
}

function logevent_challengeitemunlocked(player, itemunlockref, itemtype, itemid) {
  player dlog_recordplayerevent("dlog_event_player_challenge_item_unlocked", ["item_unlock_ref", itemunlockref, "item_type", itemtype, "item_id", itemid]);
}

function function_b4e1d087442647ef(var_4ec493e39340a7ce, victimid, playersquadsize, var_244d4aac201aa9d, interrogationduration, endreason) {
  dlog_recordevent("dlog_event_player_interrogation_complete", ["player_interrogator", var_4ec493e39340a7ce, "player_victim", victimid, "player_squad_size", playersquadsize, "player_squad_equipment", var_244d4aac201aa9d, "player_interrogation_duration", interrogationduration, "end_reason", endreason]);
}