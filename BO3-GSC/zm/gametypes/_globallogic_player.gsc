/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\gametypes\_globallogic_player.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\tweakables_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapon_utils;
#using scripts\shared\weapons_shared;
#using scripts\zm\_challenges;
#using scripts\zm\_util;
#using scripts\zm\_zm_stats;
#using scripts\zm\gametypes\_damagefeedback;
#using scripts\zm\gametypes\_globallogic;
#using scripts\zm\gametypes\_globallogic_audio;
#using scripts\zm\gametypes\_globallogic_score;
#using scripts\zm\gametypes\_globallogic_spawn;
#using scripts\zm\gametypes\_globallogic_ui;
#using scripts\zm\gametypes\_globallogic_utils;
#using scripts\zm\gametypes\_hostmigration;
#using scripts\zm\gametypes\_spawning;
#using scripts\zm\gametypes\_spawnlogic;
#using scripts\zm\gametypes\_spectating;
#using scripts\zm\gametypes\_weapons;
#namespace globallogic_player;

function freezeplayerforroundend() {
  self util::clearlowermessage();
  self closeingamemenu();
  self util::freeze_player_controls(1);
}

function callback_playerconnect() {
  thread notifyconnecting();
  self.statusicon = "hud_status_connecting";
  self waittill("begin");
  if(isDefined(level.reset_clientdvars)) {
    self[[level.reset_clientdvars]]();
  }
  waittillframeend();
  self.statusicon = "";
  self.guid = self getguid();
  profilelog_begintiming(4, "ship");
  level notify("connected", self);
  if(self ishost()) {
    self thread globallogic::listenforgameend();
  }
  if(!level.splitscreen && !isDefined(self.pers["score"])) {
    iprintln(&"MP_CONNECTED", self);
  }
  if(!isDefined(self.pers["score"])) {
    self thread zm_stats::adjustrecentstats();
  }
  if(gamemodeismode(0) && !isDefined(self.pers["matchesPlayedStatsTracked"])) {
    gamemode = util::getcurrentgamemode();
    self globallogic::incrementmatchcompletionstat(gamemode, "played", "started");
    if(!isDefined(self.pers["matchesHostedStatsTracked"]) && self islocaltohost()) {
      self globallogic::incrementmatchcompletionstat(gamemode, "hosted", "started");
      self.pers["matchesHostedStatsTracked"] = 1;
    }
    self.pers["matchesPlayedStatsTracked"] = 1;
    self thread zm_stats::uploadstatssoon();
  }
  lpselfnum = self getentitynumber();
  lpguid = self getguid();
  lpxuid = self getxuid(1);
  logprint(((((("J;" + lpguid) + ";") + lpselfnum) + ";") + self.name) + "\n");
  bbprint("global_joins", "name %s client %s xuid %s", self.name, lpselfnum, lpxuid);
  if(!sessionmodeiszombiesgame()) {
    self setclientuivisibilityflag("hud_visible", 1);
    self setclientuivisibilityflag("weapon_hud_visible", 1);
  }
  if(level.forceradar == 1) {
    self.pers["hasRadar"] = 1;
    self.hasspyplane = 1;
    level.activeuavs[self getentitynumber()] = 1;
  }
  if(level.forceradar == 2) {
    self setclientuivisibilityflag("g_compassShowEnemies", level.forceradar);
  } else {
    self setclientuivisibilityflag("g_compassShowEnemies", 0);
  }
  self setclientplayersprinttime(level.playersprinttime);
  self setclientnumlives(level.numlives);
  if(level.hardcoremode) {
    self setclientdrawtalk(3);
  }
  self[[level.player_stats_init]]();
  self.killedplayerscurrent = [];
  if(!isDefined(self.pers["best_kill_streak"])) {
    self.pers["killed_players"] = [];
    self.pers["killed_by"] = [];
    self.pers["nemesis_tracking"] = [];
    self.pers["artillery_kills"] = 0;
    self.pers["dog_kills"] = 0;
    self.pers["nemesis_name"] = "";
    self.pers["nemesis_rank"] = 0;
    self.pers["nemesis_rankIcon"] = 0;
    self.pers["nemesis_xp"] = 0;
    self.pers["nemesis_xuid"] = "";
    self.pers["best_kill_streak"] = 0;
  }
  if(!isDefined(self.pers["music"])) {
    self.pers["music"] = spawnStruct();
    self.pers["music"].spawn = 0;
    self.pers["music"].inque = 0;
    self.pers["music"].currentstate = "SILENT";
    self.pers["music"].previousstate = "SILENT";
    self.pers["music"].nextstate = "UNDERSCORE";
    self.pers["music"].returnstate = "UNDERSCORE";
  }
  self.leaderdialogqueue = [];
  self.leaderdialogactive = 0;
  self.leaderdialoggroups = [];
  self.currentleaderdialoggroup = "";
  self.currentleaderdialog = "";
  self.currentleaderdialogtime = 0;
  if(!isDefined(self.pers["cur_kill_streak"])) {
    self.pers["cur_kill_streak"] = 0;
  }
  if(!isDefined(self.pers["cur_total_kill_streak"])) {
    self.pers["cur_total_kill_streak"] = 0;
    self setplayercurrentstreak(0);
  }
  if(!isDefined(self.pers["totalKillstreakCount"])) {
    self.pers["totalKillstreakCount"] = 0;
  }
  if(!isDefined(self.pers["killstreaksEarnedThisKillstreak"])) {
    self.pers["killstreaksEarnedThisKillstreak"] = 0;
  }
  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks && !isDefined(self.pers["killstreak_quantity"])) {
    self.pers["killstreak_quantity"] = [];
  }
  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks && !isDefined(self.pers["held_killstreak_ammo_count"])) {
    self.pers["held_killstreak_ammo_count"] = [];
  }
  self.lastkilltime = 0;
  self.cur_death_streak = 0;
  self disabledeathstreak();
  self.death_streak = 0;
  self.kill_streak = 0;
  self.gametype_kill_streak = 0;
  self.spawnqueueindex = -1;
  self.deathtime = 0;
  self.lastgrenadesuicidetime = -1;
  self.teamkillsthisround = 0;
  if(!isDefined(level.livesdonotreset) || !level.livesdonotreset || !isDefined(self.pers["lives"])) {
    self.pers["lives"] = level.numlives;
  }
  if(!level.teambased) {
    self.pers["team"] = undefined;
  }
  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.deathcount = 0;
  self.wasaliveatmatchstart = 0;
  level.players[level.players.size] = self;
  if(level.splitscreen) {
    setdvar("splitscreen_playerNum", level.players.size);
  }
  if(game["state"] == "postgame") {
    self.pers["needteam"] = 1;
    self.pers["team"] = "spectator";
    self.team = "spectator";
    self.sessionteam = "spectator";
    self setclientuivisibilityflag("hud_visible", 0);
    self[[level.spawnintermission]]();
    self closeingamemenu();
    profilelog_endtiming(4, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
    return;
  }
  level endon("game_ended");
  if(isDefined(level.hostmigrationtimer)) {
    self thread hostmigration::hostmigrationtimerthink();
  }
  if(level.oldschool) {
    self.pers["class"] = undefined;
    self.curclass = self.pers["class"];
  }
  if(isDefined(self.pers["team"])) {
    self.team = self.pers["team"];
  }
  if(isDefined(self.pers["class"])) {
    self.curclass = self.pers["class"];
  }
  if(!isDefined(self.pers["team"]) || isDefined(self.pers["needteam"])) {
    self.pers["needteam"] = undefined;
    self.pers["team"] = "spectator";
    self.team = "spectator";
    self.sessionstate = "dead";
    self globallogic_ui::updateobjectivetext();
    [[level.spawnspectator]]();
    if(level.rankedmatch) {
      [
        [level.autoassign]
      ](0);
      self thread globallogic_spawn::kickifdontspawn();
    } else {
      [
        [level.autoassign]
      ](0);
    }
    if(self.pers["team"] == "spectator") {
      self.sessionteam = "spectator";
      self thread spectate_player_watcher();
    }
    if(level.teambased) {
      self.sessionteam = self.pers["team"];
      if(!isalive(self)) {
        self.statusicon = "hud_status_dead";
      }
      self thread spectating::setspectatepermissions();
    }
  } else {
    if(self.pers["team"] == "spectator") {
      self setclientscriptmainmenu(game["menu_start_menu"]);
      [
        [level.spawnspectator]
      ]();
      self.sessionteam = "spectator";
      self.sessionstate = "spectator";
      self thread spectate_player_watcher();
    } else {
      self.sessionteam = self.pers["team"];
      self.sessionstate = "dead";
      self globallogic_ui::updateobjectivetext();
      [
        [level.spawnspectator]
      ]();
      if(globallogic_utils::isvalidclass(self.pers["class"])) {
        self thread[[level.spawnclient]]();
      } else {
        self globallogic_ui::showmainmenuforteam();
      }
      self thread spectating::setspectatepermissions();
    }
  }
  if(self.sessionteam != "spectator") {
    self thread spawning::onspawnplayer_unified(1);
  }
  profilelog_endtiming(4, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
}

function spectate_player_watcher() {
  self endon("disconnect");
  self.watchingactiveclient = 1;
  self.waitingforplayerstext = undefined;
  while(true) {
    if(self.pers["team"] != "spectator" || level.gameended) {
      self hud_message::clearshoutcasterwaitingmessage();
      self freezecontrols(0);
      self.watchingactiveclient = 0;
      break;
    } else {
      if(!level.splitscreen && !level.hardcoremode && getdvarint("scr_showperksonspawn") == 1 && game["state"] != "postgame" && !isDefined(self.perkhudelem)) {
        if(level.perksenabled == 1) {
          self hud::showperks();
        }
      }
      count = 0;
      for(i = 0; i < level.players.size; i++) {
        if(level.players[i].team != "spectator") {
          count++;
          break;
        }
      }
      if(count > 0) {
        if(!self.watchingactiveclient) {
          self hud_message::clearshoutcasterwaitingmessage();
          self freezecontrols(0);
          println("");
        }
        self.watchingactiveclient = 1;
      } else {
        if(self.watchingactiveclient) {
          [
            [level.onspawnspectator]
          ]();
          self freezecontrols(1);
          self hud_message::setshoutcasterwaitingmessage();
        }
        self.watchingactiveclient = 0;
      }
      wait(0.5);
    }
  }
}

function callback_playermigrated() {
  println((("" + self.name) + "") + gettime());
  if(isDefined(self.connected) && self.connected) {
    self globallogic_ui::updateobjectivetext();
  }
  self thread inform_clientvm_of_migration();
  level.hostmigrationreturnedplayercount++;
  if(level.hostmigrationreturnedplayercount >= ((level.players.size * 2) / 3)) {
    println("");
    level notify("hostmigration_enoughplayers");
  }
}

function inform_clientvm_of_migration() {
  self endon("disconnect");
  wait(1);
  self util::clientnotify("hmo");
}

function arraytostring(inputarray) {
  targetstring = "";
  for(i = 0; i < inputarray.size; i++) {
    targetstring = targetstring + inputarray[i];
    if(i != (inputarray.size - 1)) {
      targetstring = targetstring + ",";
    }
  }
  return targetstring;
}

function recordzmendgamecomscoreeventforplayer(player, result) {
  lpselfnum = player getentitynumber();
  lpxuid = player getxuid(1);
  bbprint("global_leave", "name %s client %s xuid %s", player.name, lpselfnum, lpxuid);
  primaryweaponname = "";
  primaryweaponattachstr = "";
  secondaryweaponname = "";
  secondaryweaponattachstr = "";
  if(isDefined(player.primaryloadoutweapon)) {
    primaryweaponname = player.primaryloadoutweapon.name;
    primaryweaponattachstr = arraytostring(getarraykeys(player.primaryloadoutweapon.attachments));
  }
  if(isDefined(player.secondaryloadoutweapon)) {
    secondaryweaponname = player.secondaryloadoutweapon.name;
    secondaryweaponattachstr = arraytostring(getarraykeys(player.secondaryloadoutweapon.attachments));
  }
  resultstr = result;
  if(isDefined(player.team) && result == player.team) {
    resultstr = "win";
  } else if(result == "allies" || result == "axis") {
    resultstr = "lose";
  }
  timeplayed = game["timepassed"] / 1000;
  recordcomscoreevent("end_match", "match_id", getdemofileid(), "game_variant", "zm", "game_mode", level.gametype, "game_playlist", "N/A", "private_match", sessionmodeisprivate(), "game_map", getdvarstring("mapname"), "player_xuid", player getxuid(1), "player_ip", player getipaddress(), "match_kills", player.kills, "match_deaths", player.deaths, "match_score", player.score, "match_streak", player.pers["best_kill_streak"], "match_captures", player.pers["captures"], "match_defends", player.pers["defends"], "match_headshots", player.pers["headshots"], "match_longshots", player.pers["longshots"], "prestige_max", player.pers["plevel"], "level_max", player.pers["rank"], "match_result", resultstr, "season_pass_owned", player hasseasonpass(0), "match_hits", player.shotshit, "player_gender", player getplayergendertype(currentsessionmode()), "money", player.score, "zombie_waves", level.round_number, "revives", player.pers["revives"], "doors", player.pers["doors_purchased"], "downs", player.pers["downs"], "loadout_primary_weapon", primaryweaponname, "loadout_secondary_weapon", secondaryweaponname, "loadout_primary_attachments", primaryweaponattachstr, "loadout_secondary_attachments", secondaryweaponattachstr, "dlc_owned", player getdlcavailable(), "match_duration", timeplayed);
}

function callback_playerdisconnect() {
  profilelog_begintiming(5, "ship");
  if(game["state"] != "postgame" && !level.gameended) {
    gamelength = globallogic::getgamelength();
    self globallogic::bbplayermatchend(gamelength, "MP_PLAYER_DISCONNECT", 0);
  }
  arrayremovevalue(level.players, self);
  if(level.splitscreen) {
    players = level.players;
    if(players.size <= 1) {
      level thread globallogic::forceend();
    }
    setdvar("splitscreen_playerNum", players.size);
  }
  if(isDefined(self.score) && isDefined(self.pers["team"])) {
    print((("" + self.pers[""]) + "") + self.score);
    level.dropteam = level.dropteam + 1;
  }
  [[level.onplayerdisconnect]]();
  lpselfnum = self getentitynumber();
  lpguid = self getguid();
  logprint(((((("Q;" + lpguid) + ";") + lpselfnum) + ";") + self.name) + "\n");
  recordzmendgamecomscoreeventforplayer(self, "disconnected");
  for(entry = 0; entry < level.players.size; entry++) {
    if(level.players[entry] == self) {
      while(entry < (level.players.size - 1)) {
        level.players[entry] = level.players[entry + 1];
        entry++;
      }
      level.players[entry] = undefined;
      break;
    }
  }
  for(entry = 0; entry < level.players.size; entry++) {
    if(isDefined(level.players[entry].pers["killed_players"][self.name])) {
      level.players[entry].pers["killed_players"][self.name] = undefined;
    }
    if(isDefined(level.players[entry].killedplayerscurrent[self.name])) {
      level.players[entry].killedplayerscurrent[self.name] = undefined;
    }
    if(isDefined(level.players[entry].pers["killed_by"][self.name])) {
      level.players[entry].pers["killed_by"][self.name] = undefined;
    }
    if(isDefined(level.players[entry].pers["nemesis_tracking"][self.name])) {
      level.players[entry].pers["nemesis_tracking"][self.name] = undefined;
    }
    if(level.players[entry].pers["nemesis_name"] == self.name) {
      level.players[entry] choosenextbestnemesis();
    }
  }
  if(level.gameended) {
    self globallogic::removedisconnectedplayerfromplacement();
  }
  level thread globallogic::updateteamstatus();
  profilelog_endtiming(5, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
}

function callback_playermelee(eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind) {
  hit = 1;
  if(level.teambased && self.team == eattacker.team) {
    if(level.friendlyfire == 0) {
      hit = 0;
    }
  }
  self finishmeleehit(eattacker, weapon, vorigin, vdir, boneindex, shieldhit, hit, frombehind);
}

function choosenextbestnemesis() {
  nemesisarray = self.pers["nemesis_tracking"];
  nemesisarraykeys = getarraykeys(nemesisarray);
  nemesisamount = 0;
  nemesisname = "";
  if(nemesisarraykeys.size > 0) {
    for(i = 0; i < nemesisarraykeys.size; i++) {
      nemesisarraykey = nemesisarraykeys[i];
      if(nemesisarray[nemesisarraykey] > nemesisamount) {
        nemesisname = nemesisarraykey;
        nemesisamount = nemesisarray[nemesisarraykey];
      }
    }
  }
  self.pers["nemesis_name"] = nemesisname;
  if(nemesisname != "") {
    for(playerindex = 0; playerindex < level.players.size; playerindex++) {
      if(level.players[playerindex].name == nemesisname) {
        nemesisplayer = level.players[playerindex];
        self.pers["nemesis_rank"] = nemesisplayer.pers["rank"];
        self.pers["nemesis_rankIcon"] = nemesisplayer.pers["rankxp"];
        self.pers["nemesis_xp"] = nemesisplayer.pers["prestige"];
        self.pers["nemesis_xuid"] = nemesisplayer getxuid();
        break;
      }
    }
  } else {
    self.pers["nemesis_xuid"] = "";
  }
}

function custom_gamemodes_modified_damage(victim, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc) {
  if(level.onlinegame && !sessionmodeisprivate()) {
    return idamage;
  }
  if(isDefined(eattacker) && isDefined(eattacker.damagemodifier)) {
    idamage = idamage * eattacker.damagemodifier;
  }
  if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
    idamage = int(idamage * level.bulletdamagescalar);
  }
  return idamage;
}

function figureoutattacker(eattacker) {
  if(isDefined(eattacker)) {
    if(isai(eattacker) && isDefined(eattacker.script_owner)) {
      team = self.team;
      if(eattacker.script_owner.team != team) {
        eattacker = eattacker.script_owner;
      }
    }
    if(eattacker.classname == "script_vehicle" && isDefined(eattacker.owner)) {
      eattacker = eattacker.owner;
    } else if(eattacker.classname == "auto_turret" && isDefined(eattacker.owner)) {
      eattacker = eattacker.owner;
    }
  }
  return eattacker;
}

function figureoutweapon(weapon, einflictor) {
  if(weapon == level.weaponnone && isDefined(einflictor)) {
    if(isDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
      weapon = getweapon("explodable_barrel");
    } else if(isDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
      weapon = getweapon("destructible_car");
    }
  }
  return weapon;
}

function figureoutfriendlyfire(victim) {
  return level.friendlyfire;
}

function isplayerimmunetokillstreak(eattacker, weapon) {
  if(level.hardcoremode) {
    return 0;
  }
  if(!isDefined(eattacker)) {
    return 0;
  }
  if(self != eattacker) {
    return 0;
  }
  return weapon.donotdamageowner;
}

function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  profilelog_begintiming(6, "ship");
  if(game["state"] == "postgame") {
    return;
  }
  if(self.sessionteam == "spectator") {
    return;
  }
  if(isDefined(self.candocombat) && !self.candocombat) {
    return;
  }
  if(isDefined(eattacker) && isplayer(eattacker) && isDefined(eattacker.candocombat) && !eattacker.candocombat) {
    return;
  }
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  if(self.scene_takedamage === 0) {
    return;
  }
  weaponname = weapon.name;
  if(weaponname == "ai_tank_drone_gun" || weaponname == "ai_tank_drone_rocket" && !level.hardcoremode) {
    if(isDefined(eattacker) && eattacker == self) {
      if(isDefined(einflictor) && isDefined(einflictor.from_ai)) {
        return;
      }
    }
    if(isDefined(eattacker) && isDefined(eattacker.owner) && eattacker.owner == self) {
      return;
    }
  }
  if(weapon.isemp) {
    self notify("emp_grenaded", eattacker);
  }
  idamage = custom_gamemodes_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
  idamage = int(idamage);
  self.idflags = idflags;
  self.idflagstime = gettime();
  eattacker = figureoutattacker(eattacker);
  pixbeginevent("PlayerDamage flags/tweaks");
  if(!isDefined(vdir)) {
    idflags = idflags | level.idflags_no_knockback;
  }
  friendly = 0;
  if(self.health != self.maxhealth) {
    self notify("snd_pain_player", smeansofdeath);
  }
  if(isDefined(einflictor) && isDefined(einflictor.script_noteworthy) && einflictor.script_noteworthy == "ragdoll_now") {
    smeansofdeath = "MOD_FALLING";
  }
  if(globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isplayer(eattacker)) {
    smeansofdeath = "MOD_HEAD_SHOT";
  }
  if(level.onplayerdamage != ( & globallogic::blank)) {
    modifieddamage = [[level.onplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    if(isDefined(modifieddamage)) {
      if(modifieddamage <= 0) {
        return;
      }
      idamage = modifieddamage;
    }
  }
  if(level.onlyheadshots) {
    if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
      return;
    }
    if(smeansofdeath == "MOD_HEAD_SHOT") {
      idamage = 150;
    }
  }
  if(isDefined(eattacker) && isplayer(eattacker) && self.team != eattacker.team) {
    self.lastattackweapon = weapon;
  }
  weapon = figureoutweapon(weapon, einflictor);
  pixendevent();
  attackerishittingteammate = isplayer(eattacker) && self util::isenemyplayer(eattacker) == 0;
  if(shitloc == "riotshield") {
    if(attackerishittingteammate && level.friendlyfire == 0) {
      return;
    }
    if(smeansofdeath == "MOD_PISTOL_BULLET" || (smeansofdeath == "MOD_RIFLE_BULLET" && !attackerishittingteammate)) {
      previous_shield_damage = self.shielddamageblocked;
      self.shielddamageblocked = self.shielddamageblocked + idamage;
      if(isplayer(eattacker)) {
        eattacker.lastattackedshieldplayer = self;
        eattacker.lastattackedshieldtime = gettime();
      }
    }
    if(idflags & level.idflags_shield_explosive_impact) {
      shitloc = "none";
      if(!idflags & level.idflags_shield_explosive_impact_huge) {
        idamage = idamage * 0;
      }
    } else {
      if(idflags & level.idflags_shield_explosive_splash) {
        if(isDefined(einflictor) && isDefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self) {
          idamage = 101;
        }
        shitloc = "none";
      } else {
        return;
      }
    }
  }
  if(isDefined(eattacker) && eattacker != self && !friendly) {
    level.usestartspawns = 0;
  }
  pixbeginevent("PlayerDamage log");
  if(getdvarint("")) {
    println(((((((((("" + self getentitynumber()) + "") + self.health) + "") + eattacker.clientid) + "") + isplayer(einflictor) + "") + idamage) + "") + shitloc);
  }
  if(self.sessionstate != "dead") {
    lpselfnum = self getentitynumber();
    lpselfname = self.name;
    lpselfteam = self.team;
    lpselfguid = self getguid();
    lpattackerteam = "";
    lpattackerorigin = (0, 0, 0);
    if(isplayer(eattacker)) {
      lpattacknum = eattacker getentitynumber();
      lpattackguid = eattacker getguid();
      lpattackname = eattacker.name;
      lpattackerteam = eattacker.team;
      lpattackerorigin = eattacker.origin;
    } else {
      lpattacknum = -1;
      lpattackguid = "";
      lpattackname = "";
      lpattackerteam = "world";
    }
    logprint(((((((((((((((((((((((("D;" + lpselfguid) + ";") + lpselfnum) + ";") + lpselfteam) + ";") + lpselfname) + ";") + lpattackguid) + ";") + lpattacknum) + ";") + lpattackerteam) + ";") + lpattackname) + ";") + weapon.name) + ";") + idamage) + ";") + smeansofdeath) + ";") + shitloc) + "\n");
  }
  pixendevent();
  profilelog_endtiming(6, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
}

function resetattackerlist() {
  self.attackers = [];
  self.attackerdata = [];
  self.attackerdamage = [];
  self.firsttimedamaged = 0;
}

function dodamagefeedback(weapon, einflictor, idamage, smeansofdeath) {
  if(!isDefined(weapon)) {
    return false;
  }
  if(level.allowhitmarkers == 0) {
    return false;
  }
  if(level.allowhitmarkers == 1) {
    if(isDefined(smeansofdeath) && isDefined(idamage)) {
      if(istacticalhitmarker(weapon, smeansofdeath, idamage)) {
        return false;
      }
    }
  }
  return true;
}

function istacticalhitmarker(weapon, smeansofdeath, idamage) {
  if(weapons::is_grenade(weapon)) {
    if("Smoke Grenade" == weapon.offhandclass) {
      if(smeansofdeath == "MOD_GRENADE_SPLASH") {
        return true;
      }
    } else if(idamage == 1) {
      return true;
    }
  }
  return false;
}

function doperkfeedback(player, weapon, smeansofdeath, einflictor) {
  perkfeedback = undefined;
  return perkfeedback;
}

function isaikillstreakdamage(weapon, einflictor) {
  if(weapon.isaikillstreakdamage) {
    if(weapon.name != "ai_tank_drone_rocket" || isDefined(einflictor.firedbyai)) {
      return true;
    }
  }
  return false;
}

function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
  pixbeginevent("finishPlayerDamageWrapper");
  if(!level.console && idflags & level.idflags_penetration && isplayer(eattacker)) {
    println(((((((((("" + self getentitynumber()) + "") + self.health) + "") + eattacker.clientid) + "") + isplayer(einflictor) + "") + idamage) + "") + shitloc);
    eattacker addplayerstat("penetration_shots", 1);
  }
  if(getdvarstring("scr_csmode") != "") {
    self shellshock("damage", 0.2);
  }
  self damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage);
  self ability_power::power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
  self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
  pixendevent();
}

function allowedassistweapon(weapon) {
  return true;
}

function callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  profilelog_begintiming(7, "ship");
  self endon("spawned");
  self notify("killed_player");
  self flagsys::clear("loadout_given");
  if(self.sessionteam == "spectator") {
    return;
  }
  if(game["state"] == "postgame") {
    return;
  }
  self needsrevive(0);
  if(isDefined(self.burning) && self.burning == 1) {
    self setburn(0);
  }
  self.suicide = 0;
  if(isDefined(level.takelivesondeath) && level.takelivesondeath == 1) {
    if(self.pers["lives"]) {
      self.pers["lives"]--;
      if(self.pers["lives"] == 0) {
        level notify("player_eliminated");
        self notify("player_eliminated");
      }
    }
  }
  self thread globallogic_audio::flushgroupdialogonplayer("item_destroyed");
  weapon = updateweapon(einflictor, weapon);
  pixbeginevent("PlayerKilled pre constants");
  wasinlaststand = 0;
  deathtimeoffset = 0;
  lastweaponbeforedroppingintolaststand = undefined;
  attackerstance = undefined;
  self.laststandthislife = undefined;
  self.vattackerorigin = undefined;
  if(isDefined(self.uselaststandparams)) {
    self.uselaststandparams = undefined;
    assert(isDefined(self.laststandparams));
    if(!level.teambased || (!isDefined(attacker) || !isplayer(attacker) || attacker.team != self.team || attacker == self)) {
      einflictor = self.laststandparams.einflictor;
      attacker = self.laststandparams.attacker;
      attackerstance = self.laststandparams.attackerstance;
      idamage = self.laststandparams.idamage;
      smeansofdeath = self.laststandparams.smeansofdeath;
      weapon = self.laststandparams.weapon;
      vdir = self.laststandparams.vdir;
      shitloc = self.laststandparams.shitloc;
      self.vattackerorigin = self.laststandparams.vattackerorigin;
      deathtimeoffset = (gettime() - self.laststandparams.laststandstarttime) / 1000;
      if(isDefined(self.previousprimary)) {
        wasinlaststand = 1;
        lastweaponbeforedroppingintolaststand = self.previousprimary;
      }
    }
    self.laststandparams = undefined;
  }
  bestplayer = undefined;
  bestplayermeansofdeath = undefined;
  obituarymeansofdeath = undefined;
  bestplayerweapon = undefined;
  obituaryweapon = undefined;
  if(!isDefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || (isDefined(attacker.ismagicbullet) && attacker.ismagicbullet == 1) || attacker == self && isDefined(self.attackers)) {
    if(!isDefined(bestplayer)) {
      for(i = 0; i < self.attackers.size; i++) {
        player = self.attackers[i];
        if(!isDefined(player)) {
          continue;
        }
        if(!isDefined(self.attackerdamage[player.clientid]) || !isDefined(self.attackerdamage[player.clientid].damage)) {
          continue;
        }
        if(player == self || (level.teambased && player.team == self.team)) {
          continue;
        }
        if((self.attackerdamage[player.clientid].lasttimedamaged + 2500) < gettime()) {
          continue;
        }
        if(!allowedassistweapon(self.attackerdamage[player.clientid].weapon)) {
          continue;
        }
        if(self.attackerdamage[player.clientid].damage > 1 && !isDefined(bestplayer)) {
          bestplayer = player;
          bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
          bestplayerweapon = self.attackerdamage[player.clientid].weapon;
          continue;
        }
        if(isDefined(bestplayer) && self.attackerdamage[player.clientid].damage > self.attackerdamage[bestplayer.clientid].damage) {
          bestplayer = player;
          bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
          bestplayerweapon = self.attackerdamage[player.clientid].weapon;
        }
      }
    }
    if(isDefined(bestplayer)) {
      self recordkillmodifier("assistedsuicide");
    }
  }
  if(isDefined(bestplayer)) {
    attacker = bestplayer;
    obituarymeansofdeath = bestplayermeansofdeath;
    obituaryweapon = bestplayerweapon;
  }
  if(isplayer(attacker)) {
    attacker.damagedplayers[self.clientid] = undefined;
  }
  if(globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isplayer(attacker)) {
    attacker playlocalsound("prj_bullet_impact_headshot_helmet_nodie_2d");
    smeansofdeath = "MOD_HEAD_SHOT";
  }
  self.deathtime = gettime();
  attacker = updateattacker(attacker, weapon);
  einflictor = updateinflictor(einflictor);
  smeansofdeath = updatemeansofdeath(weapon, smeansofdeath);
  if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped == 1) {
    self detachshieldmodel(level.carriedshieldmodel, "tag_weapon_left");
    self.hasriotshield = 0;
    self.hasriotshieldequipped = 0;
  }
  self thread updateglobalbotkilledcounter();
  if(isplayer(attacker) && attacker != self && (!level.teambased || (level.teambased && self.team != attacker.team))) {
    self addweaponstat(weapon, "deaths", 1);
    if(wasinlaststand && isDefined(lastweaponbeforedroppingintolaststand)) {
      weapon = lastweaponbeforedroppingintolaststand;
    } else {
      weapon = self.lastdroppableweapon;
    }
    if(isDefined(weapon)) {
      self addweaponstat(weapon, "deathsDuringUse", 1);
    }
    if(smeansofdeath != "MOD_FALLING") {
      attacker addweaponstat(weapon, "kills", 1);
    }
    if(smeansofdeath == "MOD_HEAD_SHOT") {
      attacker addweaponstat(weapon, "headshots", 1);
    }
  }
  if(!isDefined(obituarymeansofdeath)) {
    obituarymeansofdeath = smeansofdeath;
  }
  if(!isDefined(obituaryweapon)) {
    obituaryweapon = weapon;
  }
  if(!isplayer(attacker) || self util::isenemyplayer(attacker) == 0) {
    level notify("reset_obituary_count");
    level.lastobituaryplayercount = 0;
    level.lastobituaryplayer = undefined;
  } else {
    if(isDefined(level.lastobituaryplayer) && level.lastobituaryplayer == attacker) {
      level.lastobituaryplayercount++;
    } else {
      level notify("reset_obituary_count");
      level.lastobituaryplayer = attacker;
      level.lastobituaryplayercount = 1;
    }
    if(level.lastobituaryplayercount >= 4) {
      level notify("reset_obituary_count");
      level.lastobituaryplayercount = 0;
      level.lastobituaryplayer = undefined;
    }
  }
  overrideentitycamera = 0;
  if(level.teambased && isDefined(attacker.pers) && self.team == attacker.team && obituarymeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {
    obituary(self, self, obituaryweapon, obituarymeansofdeath);
    demo::bookmark("kill", gettime(), self, self, 0, einflictor, overrideentitycamera);
  } else {
    obituary(self, attacker, obituaryweapon, obituarymeansofdeath);
    demo::bookmark("kill", gettime(), attacker, self, 0, einflictor, overrideentitycamera);
  }
  if(!level.ingraceperiod) {
    self weapons::dropscavengerfordeath(attacker);
    self weapons::dropweaponfordeath(attacker);
  }
  spawnlogic::deathoccured(self, attacker);
  self.sessionstate = "dead";
  self.statusicon = "hud_status_dead";
  self.pers["weapon"] = undefined;
  self.killedplayerscurrent = [];
  self.deathcount++;
  println((("" + self.clientid) + "") + self.deathcount);
  if(!isDefined(self.switching_teams)) {
    if(isplayer(attacker) && level.teambased && attacker != self && self.team == attacker.team) {
      self.pers["cur_kill_streak"] = 0;
      self.pers["cur_total_kill_streak"] = 0;
      self.pers["totalKillstreakCount"] = 0;
      self.pers["killstreaksEarnedThisKillstreak"] = 0;
      self setplayercurrentstreak(0);
    } else {
      self globallogic_score::incpersstat("deaths", 1, 1, 1);
      self.deaths = self globallogic_score::getpersstat("deaths");
      self updatestatratio("kdratio", "kills", "deaths");
      if(self.pers["cur_kill_streak"] > self.pers["best_kill_streak"]) {
        self.pers["best_kill_streak"] = self.pers["cur_kill_streak"];
      }
      self.pers["kill_streak_before_death"] = self.pers["cur_kill_streak"];
      self.pers["cur_kill_streak"] = 0;
      self.pers["cur_total_kill_streak"] = 0;
      self.pers["totalKillstreakCount"] = 0;
      self.pers["killstreaksEarnedThisKillstreak"] = 0;
      self setplayercurrentstreak(0);
      self.cur_death_streak++;
      if(self.cur_death_streak > self.death_streak) {
        if(level.rankedmatch) {
          self setdstat("HighestStats", "death_streak", self.cur_death_streak);
        }
        self.death_streak = self.cur_death_streak;
      }
      if(self.cur_death_streak >= getdvarint("perk_deathStreakCountRequired")) {
        self enabledeathstreak();
      }
    }
  } else {
    self.pers["totalKillstreakCount"] = 0;
    self.pers["killstreaksEarnedThisKillstreak"] = 0;
  }
  lpselfnum = self getentitynumber();
  lpselfname = self.name;
  lpattackguid = "";
  lpattackname = "";
  lpselfteam = self.team;
  lpselfguid = self getguid();
  lpattackteam = "";
  lpattackorigin = (0, 0, 0);
  lpattacknum = -1;
  awardassists = 0;
  pixendevent();
  self globallogic_score::resetplayermomentumondeath();
  if(isplayer(attacker)) {
    lpattackguid = attacker getguid();
    lpattackname = attacker.name;
    lpattackteam = attacker.team;
    lpattackorigin = attacker.origin;
    if(attacker == self) {
      dokillcam = 0;
      self globallogic_score::incpersstat("suicides", 1);
      self.suicides = self globallogic_score::getpersstat("suicides");
      if(smeansofdeath == "MOD_SUICIDE" && shitloc == "none" && self.throwinggrenade) {
        self.lastgrenadesuicidetime = gettime();
      }
      awardassists = 1;
      self.suicide = 1;
      if(isDefined(self.friendlydamage)) {
        self iprintln(&"MP_FRIENDLY_FIRE_WILL_NOT");
        if(level.teamkillpointloss) {
          scoresub = self[[level.getteamkillscore]](einflictor, attacker, smeansofdeath, weapon);
          globallogic_score::_setplayerscore(attacker, globallogic_score::_getplayerscore(attacker) - scoresub);
        }
      }
    } else {
      pixbeginevent("PlayerKilled attacker");
      lpattacknum = attacker getentitynumber();
      dokillcam = 1;
      if(level.teambased && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {} else {
        if(level.teambased && self.team == attacker.team) {
          if(!ignoreteamkills(weapon, smeansofdeath)) {
            teamkill_penalty = self[[level.getteamkillpenalty]](einflictor, attacker, smeansofdeath, weapon);
            attacker globallogic_score::incpersstat("teamkills_nostats", teamkill_penalty, 0);
            attacker globallogic_score::incpersstat("teamkills", 1);
            attacker.teamkillsthisround++;
            if(level.teamkillpointloss) {
              scoresub = self[[level.getteamkillscore]](einflictor, attacker, smeansofdeath, weapon);
              globallogic_score::_setplayerscore(attacker, globallogic_score::_getplayerscore(attacker) - scoresub);
            }
            if(globallogic_utils::gettimepassed() < 5000) {
              teamkilldelay = 1;
            } else {
              if(attacker.pers["teamkills_nostats"] > 1 && globallogic_utils::gettimepassed() < (8000 + (attacker.pers["teamkills_nostats"] * 1000))) {
                teamkilldelay = 1;
              } else {
                teamkilldelay = attacker teamkilldelay();
              }
            }
            if(teamkilldelay > 0) {
              attacker.teamkillpunish = 1;
              attacker suicide();
              if(attacker shouldteamkillkick(teamkilldelay)) {
                attacker teamkillkick();
              }
              attacker thread reduceteamkillsovertime();
            }
          }
        } else {
          globallogic_score::inctotalkills(attacker.team);
          attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self);
          if(isalive(attacker)) {
            pixbeginevent("killstreak");
            if(!isDefined(einflictor) || !isDefined(einflictor.requireddeathcount) || attacker.deathcount == einflictor.requireddeathcount) {
              shouldgivekillstreak = 0;
              attacker.pers["cur_total_kill_streak"]++;
              attacker setplayercurrentstreak(attacker.pers["cur_total_kill_streak"]);
              if(isDefined(level.killstreaks) && shouldgivekillstreak) {
                attacker.pers["cur_kill_streak"]++;
              }
            }
            pixendevent();
          }
          if(attacker.pers["cur_kill_streak"] > attacker.kill_streak) {
            if(level.rankedmatch) {
              attacker setdstat("HighestStats", "kill_streak", attacker.pers["totalKillstreakCount"]);
            }
            attacker.kill_streak = attacker.pers["cur_kill_streak"];
          }
          killstreak = undefined;
          attacker thread globallogic_score::trackattackerkill(self.name, self.pers["rank"], self.pers["rankxp"], self.pers["prestige"], self getxuid());
          attackername = attacker.name;
          self thread globallogic_score::trackattackeedeath(attackername, attacker.pers["rank"], attacker.pers["rankxp"], attacker.pers["prestige"], attacker getxuid());
          attacker thread globallogic_score::inckillstreaktracker(weapon);
          if(level.teambased && attacker.team != "spectator") {
            if(isai(attacker)) {
              globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
            } else {
              globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
            }
          }
          scoresub = level.deathpointloss;
          if(scoresub != 0) {
            globallogic_score::_setplayerscore(self, globallogic_score::_getplayerscore(self) - scoresub);
          }
          level thread playkillbattlechatter(attacker, weapon, self);
          if(level.teambased) {
            awardassists = 1;
          }
        }
      }
      pixendevent();
    }
  } else {
    if(isDefined(attacker) && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")) {
      dokillcam = 0;
      lpattacknum = -1;
      lpattackguid = "";
      lpattackname = "";
      lpattackteam = "world";
      self globallogic_score::incpersstat("suicides", 1);
      self.suicides = self globallogic_score::getpersstat("suicides");
      awardassists = 1;
    } else {
      dokillcam = 0;
      lpattacknum = -1;
      lpattackguid = "";
      lpattackname = "";
      lpattackteam = "world";
      if(isDefined(einflictor) && isDefined(einflictor.killcament)) {
        dokillcam = 1;
        lpattacknum = self getentitynumber();
      }
      if(isDefined(attacker) && isDefined(attacker.team) && isDefined(level.teams[attacker.team])) {
        if(attacker.team != self.team) {
          if(level.teambased) {
            globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
          }
        }
      }
      awardassists = 1;
    }
  }
  pixbeginevent("PlayerKilled post constants");
  self.lastattacker = attacker;
  self.lastdeathpos = self.origin;
  if(isDefined(attacker) && isplayer(attacker) && attacker != self && (!level.teambased || attacker.team != self.team)) {
    self thread challenges::playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance);
  } else {
    self notify("playerkilledchallengesprocessed");
  }
  if(isDefined(self.attackers)) {
    self.attackers = [];
  }
  if(isplayer(attacker)) {}
  logprint(((((((((((((((((((((((("K;" + lpselfguid) + ";") + lpselfnum) + ";") + lpselfteam) + ";") + lpselfname) + ";") + lpattackguid) + ";") + lpattacknum) + ";") + lpattackteam) + ";") + lpattackname) + ";") + weapon.name) + ";") + idamage) + ";") + smeansofdeath) + ";") + shitloc) + "\n");
  attackerstring = "none";
  if(isplayer(attacker)) {
    attackerstring = ((attacker getxuid() + "(") + lpattackname) + ")";
  }
  print((((((((((((("" + smeansofdeath) + "") + weapon.name) + "") + attackerstring) + "") + idamage) + "") + shitloc) + "") + int(self.origin[0]) + "") + int(self.origin[1]) + "") + int(self.origin[2]));
  level thread globallogic::updateteamstatus();
  killcamentity = self getkillcamentity(attacker, einflictor, weapon);
  killcamentityindex = -1;
  killcamentitystarttime = 0;
  if(isDefined(killcamentity)) {
    killcamentityindex = killcamentity getentitynumber();
    if(isDefined(killcamentity.starttime)) {
      killcamentitystarttime = killcamentity.starttime;
    } else {
      killcamentitystarttime = killcamentity.birthtime;
    }
    if(!isDefined(killcamentitystarttime)) {
      killcamentitystarttime = 0;
    }
  }
  if(isDefined(self.killstreak_waitamount) && self.killstreak_waitamount > 0) {
    dokillcam = 0;
  }
  self weapons::detach_carry_object_model();
  died_in_vehicle = 0;
  if(isDefined(self.diedonvehicle)) {
    died_in_vehicle = self.diedonvehicle;
  }
  pixendevent();
  pixbeginevent("PlayerKilled body and gibbing");
  if(!died_in_vehicle) {
    vattackerorigin = undefined;
    if(isDefined(attacker)) {
      vattackerorigin = attacker.origin;
    }
    ragdoll_now = 0;
    if(isDefined(self.usingvehicle) && self.usingvehicle && isDefined(self.vehicleposition) && self.vehicleposition == 1) {
      ragdoll_now = 1;
    }
    body = self cloneplayer(deathanimduration, weapon, attacker);
    self createdeadbody(idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_now, body);
  }
  pixendevent();
  thread globallogic_spawn::spawnqueuedclient(self.team, attacker);
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  self thread[[level.onplayerkilled]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
  for(icb = 0; icb < level.onplayerkilledextraunthreadedcbs.size; icb++) {
    self[[level.onplayerkilledextraunthreadedcbs[icb]]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
  }
  self.wantsafespawn = 0;
  perks = [];
  killstreaks = globallogic::getkillstreaks(attacker);
  if(!isDefined(self.killstreak_waitamount)) {
    self thread[[level.spawnplayerprediction]]();
  }
  profilelog_endtiming(7, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
  wait(0.25);
  self.cancelkillcam = 0;
  defaultplayerdeathwatchtime = 1.75;
  if(smeansofdeath == "MOD_MELEE_ASSASSINATE" || 0 > weapon.deathcamtime) {
    defaultplayerdeathwatchtime = (deathanimduration * 0.001) + 0.5;
  } else if(0 < weapon.deathcamtime) {
    defaultplayerdeathwatchtime = weapon.deathcamtime;
  }
  if(isDefined(level.overrideplayerdeathwatchtimer)) {
    defaultplayerdeathwatchtime = [[level.overrideplayerdeathwatchtimer]](defaultplayerdeathwatchtime);
  }
  globallogic_utils::waitfortimeornotifies(defaultplayerdeathwatchtime);
  self notify("death_delay_finished");
  if(getdvarint("") != 0) {
    dokillcam = 1;
    if(lpattacknum < 0) {
      lpattacknum = self getentitynumber();
    }
  }
  if(game["state"] != "playing") {
    return;
  }
  self.respawntimerstarttime = gettime();
  if(!self.cancelkillcam && dokillcam && level.killcam) {
    livesleft = !(level.numlives && !self.pers["lives"]);
    timeuntilspawn = globallogic_spawn::timeuntilspawn(1);
    willrespawnimmediately = livesleft && timeuntilspawn <= 0 && !level.playerqueuedrespawn;
  }
  if(game["state"] != "playing") {
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamtargetentity = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    return;
  }
  waittillkillstreakdone();
  if(globallogic_utils::isvalidclass(self.curclass)) {
    timepassed = undefined;
    if(isDefined(self.respawntimerstarttime)) {
      timepassed = (gettime() - self.respawntimerstarttime) / 1000;
    }
    self thread[[level.spawnclient]](timepassed);
    self.respawntimerstarttime = undefined;
  }
}

function updateglobalbotkilledcounter() {
  if(isDefined(self.pers["isBot"])) {
    level.globallarryskilled++;
  }
}

function waittillkillstreakdone() {
  if(isDefined(self.killstreak_waitamount)) {
    starttime = gettime();
    waittime = self.killstreak_waitamount * 1000;
    while(gettime() < (starttime + waittime) && isDefined(self.killstreak_waitamount)) {
      wait(0.1);
    }
    wait(2);
    self.killstreak_waitamount = undefined;
  }
}

function teamkillkick() {
  self globallogic_score::incpersstat("sessionbans", 1);
  self endon("disconnect");
  waittillframeend();
  playlistbanquantum = tweakables::gettweakablevalue("team", "teamkillerplaylistbanquantum");
  playlistbanpenalty = tweakables::gettweakablevalue("team", "teamkillerplaylistbanpenalty");
  if(playlistbanquantum > 0 && playlistbanpenalty > 0) {
    timeplayedtotal = self getdstat("playerstatslist", "time_played_total", "StatValue");
    minutesplayed = timeplayedtotal / 60;
    freebees = 2;
    banallowance = (int(floor(minutesplayed / playlistbanquantum))) + freebees;
    if(self.sessionbans > banallowance) {
      self setdstat("playerstatslist", "gametypeban", "StatValue", timeplayedtotal + (playlistbanpenalty * 60));
    }
  }
  if(self util::is_bot()) {
    level notify("bot_kicked", self.team);
  }
  ban(self getentitynumber());
  globallogic_audio::leaderdialog("kicked");
}

function teamkilldelay() {
  teamkills = self.pers["teamkills_nostats"];
  if(level.minimumallowedteamkills < 0 || teamkills <= level.minimumallowedteamkills) {
    return 0;
  }
  exceeded = teamkills - level.minimumallowedteamkills;
  return level.teamkillspawndelay * exceeded;
}

function shouldteamkillkick(teamkilldelay) {
  if(teamkilldelay && level.minimumallowedteamkills >= 0) {
    if(globallogic_utils::gettimepassed() >= 5000) {
      return true;
    }
    if(self.pers["teamkills_nostats"] > 1) {
      return true;
    }
  }
  return false;
}

function reduceteamkillsovertime() {
  timeperoneteamkillreduction = 20;
  reductionpersecond = 1 / timeperoneteamkillreduction;
  while(true) {
    if(isalive(self)) {
      self.pers["teamkills_nostats"] = self.pers["teamkills_nostats"] - reductionpersecond;
      if(self.pers["teamkills_nostats"] < level.minimumallowedteamkills) {
        self.pers["teamkills_nostats"] = level.minimumallowedteamkills;
        break;
      }
    }
    wait(1);
  }
}

function ignoreteamkills(weapon, smeansofdeath) {
  if(sessionmodeiszombiesgame()) {
    return true;
  }
  if(smeansofdeath == "MOD_MELEE") {
    return false;
  }
  if(weapon.name == "briefcase_bomb") {
    return true;
  }
  if(weapon.name == "supplydrop") {
    return true;
  }
  return false;
}

function callback_playerlaststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {}

function damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage) {
  self thread weapons::onweapondamage(eattacker, einflictor, weapon, smeansofdeath, idamage);
  self playrumbleonentity("damage_heavy");
}

function createdeadbody(idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body) {
  if(smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone") {
    self.body = body;
    return;
  }
  if(isDefined(level.ragdoll_override) && self[[level.ragdoll_override]]()) {
    return;
  }
  if(ragdoll_jib || self isonladder() || self ismantling() || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT") {
    body startragdoll();
  }
  if(!self isonground()) {
    if(getdvarint("scr_disable_air_death_ragdoll") == 0) {
      body startragdoll();
    }
  }
  if(self is_explosive_ragdoll(weapon, einflictor)) {
    body start_explosive_ragdoll(vdir, weapon);
  }
  thread delaystartragdoll(body, shitloc, vdir, weapon, einflictor, smeansofdeath);
  self.body = body;
}

function is_explosive_ragdoll(weapon, inflictor) {
  if(!isDefined(weapon)) {
    return false;
  }
  if(weapon.name == "destructible_car" || weapon.name == "explodable_barrel") {
    return true;
  }
  if(weapon.projexplosiontype == "grenade") {
    if(isDefined(inflictor) && isDefined(inflictor.stucktoplayer)) {
      if(inflictor.stucktoplayer == self) {
        return true;
      }
    }
  }
  return false;
}

function start_explosive_ragdoll(dir, weapon) {
  if(!isDefined(self)) {
    return;
  }
  x = randomintrange(50, 100);
  y = randomintrange(50, 100);
  z = randomintrange(10, 20);
  if(isDefined(weapon) && (weapon.name == "sticky_grenade" || weapon.name == "explosive_bolt")) {
    if(isDefined(dir) && lengthsquared(dir) > 0) {
      x = dir[0] * x;
      y = dir[1] * y;
    }
  } else {
    if(math::cointoss()) {
      x = x * -1;
    }
    if(math::cointoss()) {
      y = y * -1;
    }
  }
  self startragdoll();
  self launchragdoll((x, y, z));
}

function notifyconnecting() {
  waittillframeend();
  if(isDefined(self)) {
    level notify("connecting", self);
    self callback::callback("hash_fefe13f5");
  }
}

function delaystartragdoll(ent, shitloc, vdir, weapon, einflictor, smeansofdeath) {
  if(isDefined(ent)) {
    deathanim = ent getcorpseanim();
    if(animhasnotetrack(deathanim, "ignore_ragdoll")) {
      return;
    }
  }
  if(level.oldschool) {
    if(!isDefined(vdir)) {
      vdir = (0, 0, 0);
    }
    explosionpos = ent.origin + (0, 0, globallogic_utils::gethitlocheight(shitloc));
    explosionpos = explosionpos - (vdir * 20);
    explosionradius = 40;
    explosionforce = 0.75;
    if(smeansofdeath == "MOD_IMPACT" || smeansofdeath == "MOD_EXPLOSIVE" || issubstr(smeansofdeath, "MOD_GRENADE") || issubstr(smeansofdeath, "MOD_PROJECTILE") || shitloc == "head" || shitloc == "helmet") {
      explosionforce = 2.5;
    }
    ent startragdoll(1);
    wait(0.05);
    if(!isDefined(ent)) {
      return;
    }
    physicsexplosionsphere(explosionpos, explosionradius, explosionradius / 2, explosionforce);
    return;
  }
  wait(0.2);
  if(!isDefined(ent)) {
    return;
  }
  if(ent isragdoll()) {
    return;
  }
  deathanim = ent getcorpseanim();
  startfrac = 0.35;
  if(animhasnotetrack(deathanim, "start_ragdoll")) {
    times = getnotetracktimes(deathanim, "start_ragdoll");
    if(isDefined(times)) {
      startfrac = times[0];
    }
  }
  waittime = startfrac * getanimlength(deathanim);
  wait(waittime);
  if(isDefined(ent)) {
    ent startragdoll(1);
  }
}

function trackattackerdamage(eattacker, idamage, smeansofdeath, weapon) {
  if(!isDefined(eattacker)) {
    return;
  }
  if(!isplayer(eattacker)) {
    return;
  }
  if(self.attackerdata.size == 0) {
    self.firsttimedamaged = gettime();
  }
  if(!isDefined(self.attackerdata[eattacker.clientid])) {
    self.attackerdamage[eattacker.clientid] = spawnStruct();
    self.attackerdamage[eattacker.clientid].damage = idamage;
    self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
    self.attackerdamage[eattacker.clientid].weapon = weapon;
    self.attackerdamage[eattacker.clientid].time = gettime();
    self.attackers[self.attackers.size] = eattacker;
    self.attackerdata[eattacker.clientid] = 0;
  } else {
    self.attackerdamage[eattacker.clientid].damage = self.attackerdamage[eattacker.clientid].damage + idamage;
    self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
    self.attackerdamage[eattacker.clientid].weapon = weapon;
    if(!isDefined(self.attackerdamage[eattacker.clientid].time)) {
      self.attackerdamage[eattacker.clientid].time = gettime();
    }
  }
  self.attackerdamage[eattacker.clientid].lasttimedamaged = gettime();
  if(weapons::is_primary_weapon(weapon)) {
    self.attackerdata[eattacker.clientid] = 1;
  }
}

function giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon) {
  if(!allowedassistweapon(weapon)) {
    return;
  }
  self trackattackerdamage(eattacker, idamage, smeansofdeath, weapon);
  if(!isDefined(einflictor)) {
    return;
  }
  if(!isDefined(einflictor.owner)) {
    return;
  }
  if(!isDefined(einflictor.ownergetsassist)) {
    return;
  }
  if(!einflictor.ownergetsassist) {
    return;
  }
  if(isDefined(eattacker) && eattacker == einflictor.owner) {
    return;
  }
  self trackattackerdamage(einflictor.owner, idamage, smeansofdeath, weapon);
}

function updatemeansofdeath(weapon, smeansofdeath) {
  switch (weapon.name) {
    case "knife_ballistic": {
      if(smeansofdeath != "MOD_HEAD_SHOT" && smeansofdeath != "MOD_MELEE") {
        smeansofdeath = "MOD_PISTOL_BULLET";
      }
      break;
    }
    case "dog_bite": {
      smeansofdeath = "MOD_PISTOL_BULLET";
      break;
    }
    case "destructible_car": {
      smeansofdeath = "MOD_EXPLOSIVE";
      break;
    }
    case "explodable_barrel": {
      smeansofdeath = "MOD_EXPLOSIVE";
      break;
    }
  }
  return smeansofdeath;
}

function updateattacker(attacker, weapon) {
  if(isai(attacker) && isDefined(attacker.script_owner)) {
    if(!level.teambased || attacker.script_owner.team != self.team) {
      attacker = attacker.script_owner;
    }
  }
  if(attacker.classname == "script_vehicle" && isDefined(attacker.owner)) {
    attacker notify("killed", self);
    attacker = attacker.owner;
  }
  if(isai(attacker)) {
    attacker notify("killed", self);
  }
  if(isDefined(self.capturinglastflag) && self.capturinglastflag == 1) {
    attacker.lastcapkiller = 1;
  }
  if(isDefined(attacker) && isDefined(weapon) && weapon.name == "planemortar") {
    if(!isDefined(attacker.planemortarbda)) {
      attacker.planemortarbda = 0;
    }
    attacker.planemortarbda++;
  }
  return attacker;
}

function updateinflictor(einflictor) {
  if(isDefined(einflictor) && einflictor.classname == "script_vehicle") {
    einflictor notify("killed", self);
    if(isDefined(einflictor.bda)) {
      einflictor.bda++;
    }
  }
  return einflictor;
}

function updateweapon(einflictor, weapon) {
  if(weapon == level.weaponnone && isDefined(einflictor)) {
    if(isDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
      weapon = getweapon("explodable_barrel");
    } else if(isDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
      weapon = getweapon("destructible_car");
    }
  }
  return weapon;
}

function getclosestkillcamentity(attacker, killcamentities, depth = 0) {
  closestkillcament = undefined;
  closestkillcamentindex = undefined;
  closestkillcamentdist = undefined;
  origin = undefined;
  foreach(killcamentindex, killcament in killcamentities) {
    if(killcament == attacker) {
      continue;
    }
    origin = killcament.origin;
    if(isDefined(killcament.offsetpoint)) {
      origin = origin + killcament.offsetpoint;
    }
    dist = distancesquared(self.origin, origin);
    if(!isDefined(closestkillcament) || dist < closestkillcamentdist) {
      closestkillcament = killcament;
      closestkillcamentdist = dist;
      closestkillcamentindex = killcamentindex;
    }
  }
  if(depth < 3 && isDefined(closestkillcament)) {
    if(!bullettracepassed(closestkillcament.origin, self.origin, 0, self)) {
      killcamentities[closestkillcamentindex] = undefined;
      betterkillcament = getclosestkillcamentity(attacker, killcamentities, depth + 1);
      if(isDefined(betterkillcament)) {
        closestkillcament = betterkillcament;
      }
    }
  }
  return closestkillcament;
}

function getkillcamentity(attacker, einflictor, weapon) {
  if(!isDefined(einflictor)) {
    return undefined;
  }
  if(einflictor == attacker) {
    if(!isDefined(einflictor.ismagicbullet)) {
      return undefined;
    }
    if(isDefined(einflictor.ismagicbullet) && !einflictor.ismagicbullet) {
      return undefined;
    }
  } else if(isDefined(level.levelspecifickillcam)) {
    levelspecifickillcament = self[[level.levelspecifickillcam]]();
    if(isDefined(levelspecifickillcament)) {
      return levelspecifickillcament;
    }
  }
  if(weapon.name == "m220_tow") {
    return undefined;
  }
  if(isDefined(einflictor.killcament)) {
    if(einflictor.killcament == attacker) {
      return undefined;
    }
    return einflictor.killcament;
  }
  if(isDefined(einflictor.killcamentities)) {
    return getclosestkillcamentity(attacker, einflictor.killcamentities);
  }
  if(isDefined(einflictor.script_gameobjectname) && einflictor.script_gameobjectname == "bombzone") {
    return einflictor.killcament;
  }
  return einflictor;
}

function playkillbattlechatter(attacker, weapon, victim) {}

function recordactiveplayersendgamematchrecordstats() {
  foreach(player in level.players) {
    recordplayermatchend(player);
    recordplayerstats(player, "presentAtEnd", 1);
  }
}