/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\playerlogic.gsc
***********************************************/

#using script_1b1a05843f74cfa9;
#using script_3f8889c16399185c;
#using script_4a6760982b403bad;
#using script_4cdabcd91a92977;
#using script_6ad351ebd5a33280;
#using script_728ffcee8cbf30ee;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\killstreaks\uav;
#using scripts\cp_mp\playerachievements;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\customization\battle_tracks;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\accolades;
#using scripts\mp\analyticslog;
#using scripts\mp\arbitrary_up;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots;
#using scripts\mp\class;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\equipment\tac_insert;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\flashpoint;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gamestaterestore;
#using scripts\mp\gametypes\br_armor;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\war;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\meatshield;
#using scripts\mp\menus;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outline;
#using scripts\mp\outofbounds;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\perks\perks;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\playerstats;
#using scripts\mp\playerstats_interface;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spawnselection;
#using scripts\mp\spectating;
#using scripts\mp\supers;
#using scripts\mp\teams;
#using scripts\mp\tweakables;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace playerlogic;

function init() {
  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&onversusdone);
}

function timeuntilwavespawn(minimumwait) {
  if(!self.hasspawned) {
    return 0;
  }

  earliestspawntime = gettime() + minimumwait * 1000;
  lastwavetime = level.lastwave[self.pers["team"]];
  wavedelay = level.wavedelay[self.pers["team"]] * 1000;
  numwavespassedearliestspawntime = (earliestspawntime - lastwavetime) / wavedelay;
  numwaves = ceil(numwavespassedearliestspawntime);
  timeofspawn = lastwavetime + numwaves * wavedelay;

  if(isDefined(self.respawntimerstarttime)) {
    timealreadypassed = (gettime() - self.respawntimerstarttime) / 1000;

    if(self.respawntimerstarttime < lastwavetime) {
      return 0;
    }
  }

  if(isDefined(self.wavespawnindex)) {
    timeofspawn += 50 * self.wavespawnindex;
  }

  return (timeofspawn - gettime()) / 1000;
}

function teamkilldelay() {
  teamkills = scripts\mp\utility\stats::getpersstat("teamkills");

  if(!isDefined(teamkills) || level.maxallowedteamkills < 0 || teamkills <= level.maxallowedteamkills) {
    return 0;
  }

  exceeded = teamkills - level.maxallowedteamkills;

  if(function_eb455c18ac9d8ac5()) {
    return scripts\mp\tweakables::gettweakablevalue("team", "teamkillspawndelay");
  }

  return scripts\mp\tweakables::gettweakablevalue("team", "teamkillspawndelay") * exceeded;
}

function timeuntilspawn(includeteamkilldelay) {
  if(level.ingraceperiod && !self.hasspawned || level.gameended) {
    return 0;
  }

  respawndelay = 0;

  if(istrue(self.hasspawned)) {
    result = self[[level.onrespawndelay]]();

    if(isDefined(result)) {
      respawndelay = result;
    } else {
      respawndelay = getdvarfloat(hashcat(@ "scr_", getgametype(), "_playerrespawndelay"));
    }

    if(includeteamkilldelay && isDefined(scripts\mp\utility\stats::getpersstat("teamKillPunish")) && scripts\mp\utility\stats::getpersstat("teamKillPunish")) {
      respawndelay += teamkilldelay();
    }

    if(isDefined(self.suicidespawndelay) && !ismutationgamemodezombie()) {
      respawndelay += getdvarfloat(hashcat(@ "scr_", getgametype(), "_suicidespawndelay"));
    }

    if(isDefined(self.respawntimerstarttime) && !isDefined(level.spawndelay)) {
      timealreadypassed = (gettime() - self.respawntimerstarttime) / 1000;
      respawndelay -= timealreadypassed;

      if(respawndelay < 0) {
        respawndelay = 0;
      }
    }
  }

  if(scripts\cp_mp\utility\game_utility::function_d04af493b6e718ac()) {
    wavebased = level.respawndelaytype == 1;
  } else {
    wavebased = getdvarint(hashcat(@ "scr_", getgametype(), "_waverespawndelay")) > 0;
  }

  if(wavebased) {
    respawndelay = timeuntilwavespawn(respawndelay);
  }

  if(level.ingraceperiod && !self.hasspawned || level.gameended) {
    respawndelay = 0;
  } else if(getdvarint(@ "hash_4ac8d16ce8dd74fd", 0) == 1) {
    respawndelay = 999;
  }

  if(!isDefined(self.initialrespawndelay)) {
    self.initialrespawndelay = respawndelay;
  }

  return respawndelay;
}

function mayspawn() {
  if(istrue(level.nukeinfo.gameover)) {
    return false;
  }

  if(getgametypenumlives() || isDefined(level.disablespawning)) {
    if(isDefined(level.teamswithplayers) && level.teamswithplayers.size == 1) {
      return true;
    }

    if(istrue(level.disablespawning)) {
      if(!istestclient(self)) {
        return false;
      }
    }

    if(istrue(self.pers["teamKillPunish"])) {
      var_f7dbdb03018ddfc = scripts\cp_mp\utility\game_utility::getgametype() == "cdl_control";
      var_ea619a6a8f579647 = getdvarint(@ "hash_8568a599205cb922", 0);

      if(var_f7dbdb03018ddfc && var_ea619a6a8f579647) {
        return false;
      }

      if(!var_f7dbdb03018ddfc) {
        return false;
      }
    }

    if(self.pers["lives"] <= 0 && gamehasstarted()) {
      return false;
    } else if(gamehasstarted()) {
      if(level.ingraceperiod && !self.hasspawned) {
        return true;
      }

      if(!level.ingraceperiod && !self.hasspawned && isDefined(level.allowlatecomers) && !level.allowlatecomers) {
        if(isDefined(self.siegelatecomer) && !self.siegelatecomer) {
          return true;
        }

        if(istestclient(self)) {
          return true;
        }

        return false;
      }
    }
  }

  if(isDefined(level.disablespawningforplayerfunc) && [[level.disablespawningforplayerfunc]](self)) {
    return false;
  }

  return true;
}

function spawnclient(revivespawn) {
  self endon("becameSpectator");

  if(isDefined(level.modespawnclient)) {
    self[[level.modespawnclient]](revivespawn);
    return;
  }

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers["next_round_class"]) && !self.hasspawned) {
    self.class = self.pers["next_round_class"];
  }

  assert(isDefined(self.team));
  assert(scripts\mp\class::isvalidclass(self.class));

  if(isDefined(self.waitingtoselectclass) && self.waitingtoselectclass) {
    self waittill("okToSpawn");
  }

  if(isDefined(self.addtoteam)) {
    scripts\mp\menus::addtoteam(self.addtoteam);
    self.addtoteam = undefined;
  }

  println("<dev string:x1c>" + self.name + "<dev string:x50>" + self.class);

  if(!mayspawn()) {
    waitframe();
    currentorigin = self.origin;
    currentangles = self.angles;
    self notify("attempted_spawn");

    if(istrue(self.pers["teamKillPunish"])) {
      if(isDefined(self.pers["teamkills"])) {
        self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
      } else {
        self.pers["teamkills"] = 0;
      }

      setlowermessageomnvar("no_friendly_fire");

      if(!self.hasspawned && self.pers["teamkills"] <= level.maxallowedteamkills) {
        self.pers["teamKillPunish"] = 0;
      }
    } else if(isroundbased() && game["finalRound"] == 0 || getgametypenumlives() != 0 && game["finalRound"] == 0 || istrue(level.disablespawning)) {
      var_eed812fd1b7f551c = undefined;

      if(getgametype() != "arena" && isDefined(self.tagavailable) && self.tagavailable) {
        setlowermessageomnvar("spawn_tag_wait");
      } else if(istrue(self.revivetriggerblockedinremote) && level.teamdata[self.team]["aliveCount"] > 0) {
        setlowermessageomnvar("spawn_revive_wait_notimer");
      } else if(istrue(self.revivetriggeravailable)) {
        if(isDefined(self.timeuntilbleedout)) {
          if(isDefined(self.rallypoint)) {
            setlowermessageomnvar("rally_point", int(gettime() + self.timeuntilbleedout * 1000));
          } else if(!istrue(self.eliminated)) {
            setlowermessageomnvar("spawn_revive_wait_bleedout", int(gettime() + self.timeuntilbleedout * 1000));
          }
        } else if(level.teamdata[self.team]["aliveCount"] > 0) {
          setlowermessageomnvar("spawn_revive_wait_notimer");
        } else {
          setlowermessageomnvar("spawn_next_round");
        }
      } else if(getgametype() == "siege") {
        setlowermessageomnvar("spawn_point_capture_wait");
        var_eed812fd1b7f551c = 10;
      } else if(istrue(level.exfilstarted)) {
        setlowermessageomnvar("exfil_eliminated");
      } else if(isroundbased()) {
        setlowermessageomnvar("spawn_next_round");
      } else if(getgametype() == "oic" && matchmakinggame()) {
        setlowermessageomnvar("player_eliminated_oic");
        var_eed812fd1b7f551c = 30;
      } else {
        setlowermessageomnvar("player_eliminated");
        var_eed812fd1b7f551c = 10;
      }

      if(!isDefined(self.revivetriggeravailable)) {
        thread removespawnmessageshortly(ter_op(isDefined(var_eed812fd1b7f551c), var_eed812fd1b7f551c, 6));
      }
    }

    if(self.sessionstate != "spectator") {
      currentorigin += (0, 0, 60);
    }

    if(isusingremote()) {
      self.spawningafterremotedeath = 1;
      self.deathposition = self.origin;
      self waittill("stopped_using_remote");
    }

    if(!istrue(level.nukeinfo.gameover)) {
      if(!gameflag("prematch_done")) {
        logstring("IWH-315293: DOLPHIN: can't spawn but prematch isn't over: " + self.name);
      }

      thread spawnspectator(currentorigin, currentangles);
    }

    return;
  }

  if(self.waitingtospawn) {
    return;
  }

  self.waitingtospawn = 1;
  waitandspawnclient(revivespawn);

  if(isDefined(self)) {
    self.waitingtospawn = 0;
  }
}

function waittillcanspawnclient(revivespawn) {
  self endon("started_spawnPlayer");

  for(;;) {
    waitframe();

    if(self.team == "spectator" || self.team == "codcaster") {
      return;
    }

    if(isDefined(self) && (self.sessionstate == "spectator" || !isreallyalive(self))) {
      if(istrue(revivespawn)) {
        self.pers["teamKillPunish"] = 0;
      }

      self.pers["lives"] = 1;
      thread spawnclient(revivespawn);
      continue;
    }

    return;
  }
}

function waitandspawnclient(revivespawn) {
  self endon("disconnect");
  self endon("end_respawn");
  level endon("game_ended");
  self notify("attempted_spawn");
  println("<dev string:x5c>" + self.name);

  if(isDefined(level.prewaitandspawnclient)) {
    [[level.prewaitandspawnclient]](revivespawn);
  }

  waitforremoteend();
  spawnedasspectator = 0;

  if(istrue(scripts\mp\utility\stats::getpersstat("teamKillPunish"))) {
    teamkilldelay = teamkilldelay();

    if(teamkilldelay > 0) {
      setlowermessageomnvar("no_friendly_fire_timer", int(gettime() + teamkilldelay * 1000));
      thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
      spawnedasspectator = 1;
      wait teamkilldelay;
      setlowermessageomnvar("clear_lower_msg");
      self.respawntimerstarttime = gettime();
    }

    self.pers["teamKillPunish"] = 0;
  } else if(teamkilldelay()) {
    self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
  }

  if(!isDefined(self.wavespawnindex) && isDefined(level.waveplayerspawnindex[self.team])) {
    self.wavespawnindex = level.waveplayerspawnindex[self.team];
    level.waveplayerspawnindex[self.team]++;
  }

  if(isDefined(self.setspawnpoint) && !tivalidationcheck()) {
    scripts\mp\equipment\tac_insert::spawnpoint_clearspawnpoint(1);
  }

  timeuntilspawn = timeuntilspawn(0);
  var_d322c5816f6135b5 = 0;

  if(!istrue(level.disablespawncamera)) {
    var_d322c5816f6135b5 = ter_op(istrue(level.snaptospawncamera), 1.25, 2);
  }

  if(istrue(level.usespawnselection)) {
    var_d322c5816f6135b5 = 0.5;
  }

  if(level.ingraceperiod && !self.hasspawned || level.gameended) {
    var_d322c5816f6135b5 = 0;
    timeuntilspawn = 0;
  }

  var_d86b42b0fa413aa2 = 0;

  if(getbasegametype() == "hq" && isDefined(level.zone) && level.zone.ownerteam == self.team) {
    var_d86b42b0fa413aa2 = 1;
  }

  if(!istrue(self.skippedkillcam) && isDefined(self.killcamwatchtime) && !var_d86b42b0fa413aa2) {
    if(isDefined(self.initialrespawndelay)) {
      timeuntilspawn = max(self.initialrespawndelay - self.killcamwatchtime, 0);
    } else {
      timeuntilspawn = max(timeuntilspawn - self.killcamwatchtime, 0);
    }

    self.killcamwatchtime = undefined;
  }

  if(isDefined(self.var_be203805bd352c2d)) {
    timeuntilspawn = self.var_be203805bd352c2d;
    self.var_be203805bd352c2d = undefined;
  } else {
    timeuntilspawn = max(timeuntilspawn, var_d322c5816f6135b5);
  }

  if(scripts\mp\arbitrary_up::isinarbitraryup()) {
    angles = self getworldupreferenceangles();
    up = anglestoup(angles);
    spawn_offset = up * 60;
  } else {
    spawn_offset = (0, 0, 60);
  }

  pastprematch = istrue(gameflag("prematch_done"));
  caninfil = gameflag("infil_will_run") && !istrue(gameflag("infil_started"));

  if(istrue(level.var_a6954a050d77d75c)) {
    if(!caninfil && !pastprematch && (!isDefined(level.var_58a42cd072629ca) || [[level.var_58a42cd072629ca]]())) {
      self clearpredictedstreampos();
      thread function_ae6fb03b95fca93e(getdvarint(@ "hash_41c2228192c27e59", 1));
    }
  } else if((getgametype() == "arm" || getgametype() == "conflict") && !caninfil && !pastprematch) {
    camerapositions = [[level.var_e637d49948a038d3]](self.team);
    streamorigin = scripts\mp\gametypes\br_public::playerstreamhintlocation(camerapositions.startorigin);
    thread setuipregamefadeup();
    scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();
    cament = spawn("script_model", camerapositions.startorigin);
    cament setModel("tag_origin");
    cament.angles = camerapositions.startangles;
    self cameralinkTo(cament, "tag_origin");
    cament moveTo(camerapositions.endorigin, 18);
    cament rotateTo(camerapositions.endangles, 18);
    gameflagwait("prematch_done");
    pastprematch = 1;
    self cameraunlink();
  }

  if(scripts\mp\spawncamera::function_581a8fc6f76d525d() && timeuntilspawn > 0) {
    if(getdvarint(@ "hash_f011125b6f888598", 1) == 1) {
      thread scripts\mp\spawncamera::startspawncamera(0, 0, 0.5);
    } else {
      thread scripts\mp\spawncamera::startspawncamera();
    }
  }

  if(istrue(level.usespawnselection)) {
    scripts\mp\spawnselection::waitforspawnselection(timeuntilspawn, !istrue(pastprematch));
  } else {
    if(isDefined(self.setspawnpoint)) {
      var_d82413d0d82e4e34 = scripts\mp\equipment\tac_insert::tacinsert_respawn();
      spawnedasspectator = 1;

      if(isDefined(self.ti_timer)) {
        timeuntilspawn = max(var_d322c5816f6135b5, timeuntilspawn - var_d82413d0d82e4e34);
        self setspectatedefaults(self.origin + spawn_offset, self.angles);
        scripts\mp\spectating::setspectatepermissions();
      }
    }

    if(timeuntilspawn > 0) {
      var_bcf42b30ba361835 = "waiting_to_spawn";

      if(getbasegametype() == "hq") {
        if(isDefined(level.zone)) {
          if(level.zone.ownerteam == self.team) {
            scripts\mp\utility\dialog::leaderdialogonplayer("hp_dead");
            var_bcf42b30ba361835 = "waiting_for_hq";

            if(isDefined(self.suicidespawndelay)) {
              timeuntilspawn -= getdvarfloat(@ "hash_7f95444a17ecdec5");
              timeuntilspawn = max(0, timeuntilspawn);
            }
          } else if(isDefined(self.suicidespawndelay) && getdvarfloat(@ "hash_7f95444a17ecdec5") > 0 && level.zone.ownerteam == "neutral") {
            var_bcf42b30ba361835 = "waiting_suicide_delay";
            self.suicidespawndelay = undefined;
          }
        }
      } else if(isDefined(self.suicidespawndelay) && getdvarfloat(hashcat(@ "scr_", getgametype(), "_suicidespawndelay")) > 0) {
        var_bcf42b30ba361835 = "waiting_suicide_delay";
        self.suicidespawndelay = undefined;
      }

      setlowermessageomnvar(var_bcf42b30ba361835, int(gettime() + timeuntilspawn * 1000));

      if(getdvarint(@ "hash_f011125b6f888598", 1) == 1 && istrue(self.inspawncamera) && getgametype() == "gwtdm") {} else {
        if(!spawnedasspectator) {
          thread respawn_asspectator(self.origin + spawn_offset, self.angles);
        }

        spawnedasspectator = 1;
      }

      waittill_any_timeout_no_endon_death_1(timeuntilspawn, "force_spawn");

      if(!istrue(self.waitingtoselectclass)) {
        self notify("stop_wait_safe_spawn_button");
      }
    }
  }

  if(!isbot(self) && needsbuttontorespawn()) {
    if(function_98811c91e3781166()) {
      if(self.hasspawned) {
        function_5ecf910ea9dfdb41();
      }
    } else {
      if(!istrue(self.waitingtoselectclass)) {
        setlowermessageomnvar("press_to_spawn");
      }

      if(!spawnedasspectator) {
        thread respawn_asspectator(self.origin + spawn_offset, self.angles);
      }

      spawnedasspectator = 1;
      waitrespawnbutton();
    }
  }

  if(!istrue(level.disablespawncamera) || getgametype() == "arm" || getgametype() == "conflict" || getgametype() == "risk") {
    thread scripts\mp\spawncamera::endspawncamera();
  }

  waitclassselected();

  if(isbot(self)) {
    if(!scripts\mp\bots\bots::bot_is_ready_to_spawn()) {
      self waittill("bot_ready_to_spawn");
    }
  }

  if(scripts\engine\utility::issharedfuncdefined("instanceInventory", "inventoryIsValid")) {
    while(!istrue(scripts\engine\utility::function_f3bb4f4911a1beb2("instanceInventory", "inventoryIsValid", self))) {
      waitframe();
    }
  }

  self.waitingtospawn = 0;
  setlowermessageomnvar("clear_lower_msg");
  self.wavespawnindex = undefined;
  thread spawnplayer(undefined, revivespawn);
}

function function_ae6fb03b95fca93e(mintime) {
  self endon("death_or_disconnect");
  self waittill("spawned_player");
  self setclientomnvar("ui_world_fade", 1);
  starttime = gettime();
  scripts\mp\gametypes\br_public::playerstreamhintlocation(self getEye());
  self waittill("playerPrestreamComplete");
  self clearpredictedstreampos();

  if(isDefined(mintime)) {
    timepassed = (gettime() - starttime) / 1000;

    if(timepassed < mintime) {
      wait mintime - timepassed;
    }
  }

  var_dfab0807d83a77fe = 0.5;

  if(isDefined(var_dfab0807d83a77fe) && var_dfab0807d83a77fe > 0) {
    var_c8d49bba66d8db34 = 1;
    framecount = var_dfab0807d83a77fe / level.framedurationseconds;
    var_11b42fd8a12916ad = 1 / framecount;
    currentframe = 0;

    while(currentframe < framecount) {
      currentframe++;
      var_c8d49bba66d8db34 -= var_11b42fd8a12916ad;
      var_c8d49bba66d8db34 = clamp(var_c8d49bba66d8db34, 0, 1);
      self setclientomnvar("ui_world_fade", var_c8d49bba66d8db34);
      waitframe();
    }
  }

  self setclientomnvar("ui_world_fade", 0);
}

function waitforremoteend() {
  level endon("game_ended");
  self endon("disconnect");

  if(isusingremote()) {
    self.spawningafterremotedeath = 1;
    self.deathposition = self.origin;
    self waittill("stopped_using_remote");

    if(istrue(level.nukeinfo.gameover)) {
      return;
    }
  }
}

function shouldwaitforsquadspawn() {
  return false;
}

function queueclientforsquadspawn() {
  while(!level.squaddata[self.team][self.sessionsquadid].isfull && !level.squaddata[self.team][self.sessionsquadid].isstale) {
    waitframe();
  }
}

function waitclassselected() {
  while(istrue(self.waitingtoselectclass)) {
    waitframe();
  }
}

function needsbuttontorespawn() {
  if(istrue(self.var_6c0f9f7e906a5ee6)) {
    return false;
  }

  if(gameflag("infil_will_run") && !gameflag("prematch_done")) {
    return false;
  }

  if(function_98811c91e3781166()) {
    return true;
  }

  if(scripts\mp\tweakables::gettweakablevalue("player", "forcerespawn") != 0) {
    return false;
  }

  if(!self.hasspawned) {
    return false;
  }

  wavebased = getdvarint(hashcat(@ "scr_", getgametype(), "_waverespawndelay")) > 0;

  if(wavebased) {
    return false;
  }

  if(self.wantsafespawn) {
    return false;
  }

  return true;
}

function waitrespawnbutton() {
  self endon("disconnect");
  self endon("end_respawn");

  while(true) {
    if(self useButtonPressed()) {
      break;
    }

    wait 0.05;
  }
}

function function_98811c91e3781166() {
  if(function_9cdaadfddeda4d7a() && !isbot(self) && !self isplayerheadless()) {
    return true;
  }

  return false;
}

function function_5ecf910ea9dfdb41() {
  self openmenu("Shop");
  scripts\mp\gametypes\br_armory_kiosk::armorykioskused(0, undefined, undefined, self);
  function_e02011baf71d84ac();
}

function function_e02011baf71d84ac() {
  self endon("disconnect");
  self endon("end_respawn");
  self endon("buy_menu_close");
  self endon("game_ended");
  timeout = 10;

  while(true) {
    wait ter_op(matchmakinggame(), 10, 20);
    break;
  }
}

function removespawnmessageshortly(delay) {
  self endon("disconnect");
  level endon("game_ended");
  waittillframeend();
  self endon("end_respawn");
  wait delay;
  setlowermessageomnvar("clear_lower_msg");
}

function tivalidationcheck() {
  if(!isDefined(self.setspawnpoint)) {
    return false;
  }

  if(isDefined(level.canspawnontacinsert) && ![[level.canspawnontacinsert]](self)) {
    return false;
  }

  carepackages = getEntArray("care_package", "targetname");

  foreach(package in carepackages) {
    if(distancesquared(package.origin, self.setspawnpoint.playerspawnpos) > 4096) {
      continue;
    }

    if(isDefined(package.owner)) {
      scripts\mp\hud_message::showsplash("destroyed_insertion", undefined, package.owner);
    }

    scripts\mp\equipment\tac_insert::spawnpoint_clearspawnpoint();
    return false;
  }

  radiusvector = (30, 30, 80);
  aabbmin = self.setspawnpoint.playerspawnpos - radiusvector;
  aabbmax = self.setspawnpoint.playerspawnpos + radiusvector;
  contents = physics_createcontents(["physicscontents_vehicle"]);
  ignorelist = [];
  vehicles = physics_aabbbroadphasequery(aabbmin, aabbmax, contents, ignorelist);

  if(isDefined(vehicles) && vehicles.size > 0) {
    fakevehicle = 1;

    foreach(vehicle in vehicles) {
      fake = vehicle.code_classname == "scriptable" || vehicle.code_classname == "worldspawn";

      if(!fake) {
        fakevehicle = 0;
        break;
      }
    }

    if(!fakevehicle) {
      return false;
    }
  }

  startpos = self.setspawnpoint.playerspawnpos + (0, 0, 60);
  endpos = self.setspawnpoint.playerspawnpos + (0, 0, 1);
  ignoreents = [];
  ignoreents[0] = self;
  ignoreents[1] = self.setspawnpoint;
  contentoverride = physics_createcontents(["physicscontents_playerclip", "physicscontents_characterproxy", "physicscontents_glass"]);

  if(!scripts\engine\trace::ray_trace_passed(startpos, endpos, ignoreents, contentoverride)) {
    return false;
  }

  tracestartpos = self.setspawnpoint.playerspawnpos + (0, 0, 1);
  traceendpos = playerphysicstrace(tracestartpos, self.setspawnpoint.playerspawnpos + (0, 0, -16));

  if(tracestartpos[2] == traceendpos[2]) {
    return false;
  }

  return true;
}

function revivespawnvalidationcheck() {
  if(!isDefined(self.forcespawnorigin)) {
    return 0;
  }

  var_e5f115aee2bf7de7 = spawnStruct();
  var_e5f115aee2bf7de7.spawnposition = self.forcespawnorigin;
  var_e5f115aee2bf7de7.isvalidpos = 1;
  ignoreents = [];
  ignoreents[0] = self;
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 0, 0, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(self.forcespawnorigin + (0, 0, 60), self.forcespawnorigin, ignoreents, contentoverride)) {
    var_e5f115aee2bf7de7.isvalidpos = 0;
    return var_e5f115aee2bf7de7;
  }

  if(istrue(self.var_908f8ac4bbcdb65e)) {
    var_e5f115aee2bf7de7.isvalidpos = 1;
    return var_e5f115aee2bf7de7;
  }

  forward = anglesToForward(self.angles);
  delta = vectorNormalize(forward) * 5;

  if(!scripts\engine\trace::ray_trace_passed(self.forcespawnorigin + delta, self.forcespawnorigin + delta - (0, 0, 16), ignoreents, contentoverride)) {
    var_e5f115aee2bf7de7.isvalidpos = 0;
    return var_e5f115aee2bf7de7;
  }

  tracestartpos = self.forcespawnorigin + (0, 0, 1);
  traceendpos = playerphysicstrace(tracestartpos, self.forcespawnorigin + (0, 0, -16));

  if(tracestartpos[2] == traceendpos[2]) {
    var_e5f115aee2bf7de7.isvalidpos = 0;
    return var_e5f115aee2bf7de7;
  } else {
    var_e5f115aee2bf7de7.spawnposition = traceendpos;
    var_e5f115aee2bf7de7.isvalidpos = 0;
  }

  if(isDefined(self.faux_spawn_stance) && self.faux_spawn_stance == "prone") {
    self.faux_spawn_stance = "prone";
  } else {
    self.faux_spawn_stance = "crouch";
  }

  var_e5f115aee2bf7de7.isvalidpos = 1;
  return var_e5f115aee2bf7de7;
}

function spawningclientthisframereset() {
  self notify("spawningClientThisFrameReset");
  self endon("spawningClientThisFrameReset");
  waitframe();
  level.numplayerswaitingtospawn--;
}

function getplayerassets(classstruct) {
  assets = spawnStruct();

  if(isDefined(classstruct.loadoutprimaryfullname) && classstruct.loadoutprimaryfullname != "none") {
    assets.primaryweapon = classstruct.loadoutprimaryfullname;
  }

  if(isDefined(classstruct.loadoutsecondaryfullname) && classstruct.loadoutsecondaryfullname != "none") {
    assets.secondaryweapon = classstruct.loadoutsecondaryfullname;
  }

  customization = scripts\mp\teams::getcustomization();

  if(isDefined(customization["body"])) {
    assets.body = customization["body"];
  }

  if(isDefined(customization["head"])) {
    assets.head = customization["head"];
  }

  return assets;
}

function loadplayerassets(var_424ddd9840da9529, highpriority, var_8c3977c9c8dc729b) {
  var_e2705839f9350b00 = [];

  foreach(assets in var_424ddd9840da9529) {
    if(isDefined(assets.primaryweapon)) {
      var_e2705839f9350b00[var_e2705839f9350b00.size] = assets.primaryweapon;
    }

    if(isDefined(assets.secondaryweapon)) {
      var_e2705839f9350b00[var_e2705839f9350b00.size] = assets.secondaryweapon;
    }

    if(!istrue(var_8c3977c9c8dc729b)) {
      self loadcustomization(assets.body, assets.head, highpriority);
    }
  }

  if(var_e2705839f9350b00.size > 0) {
    self loadweaponsforplayer(var_e2705839f9350b00, highpriority);
  }
}

function allplayershaveassetsloaded(assets) {
  var_e2705839f9350b00 = [];

  if(isDefined(assets.primaryweapon)) {
    var_e2705839f9350b00[var_e2705839f9350b00.size] = assets.primaryweapon;
  }

  if(isDefined(assets.secondaryweapon)) {
    var_e2705839f9350b00[var_e2705839f9350b00.size] = assets.secondaryweapon;
  }

  if(!self hasloadedviewweapons(var_e2705839f9350b00)) {
    return false;
  }

  if(!self hasloadedcustomizationviewmodels(assets.body)) {
    return false;
  }

  return true;
}

function getspawnpoint() {
  spawnpoint = undefined;
  spawnorigin = undefined;
  spawnangles = undefined;
  self.ti_spawn = 0;

  if(getdvarint(@ "hash_3f36284b49b3d7a", 0) != 0) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      spawnarray = getspawnarray("mp_dm_spawn_start");

      if(spawnarray.size == 0) {
        spawnarray = getspawnarray("mp_tdm_spawn_allies_start");
      }
    } else {
      spawnarray = getspawnarray("mp_tdm_spawn_allies_start");
    }

    spawnpoint = spawnarray[0];
    spawnorigin = getgroundposition(spawnpoint.origin, 15);
    spawnangles = spawnpoint.angles;
  } else if(isDefined(self.forcespawnorigin)) {
    var_e5f115aee2bf7de7 = revivespawnvalidationcheck();

    if(!var_e5f115aee2bf7de7.isvalidpos && isDefined(self.prevrevivepos) && !isDefined(self.rallypoint)) {
      spawnorigin = self.prevrevivepos;
    } else {
      spawnorigin = self.forcespawnorigin;
      self.forcespawnorigin = undefined;
    }

    if(isDefined(self.forcespawnangles)) {
      spawnangles = self.forcespawnangles;
      self.forcespawnangles = undefined;
    } else {
      spawnangles = (0, randomfloatrange(0, 360), 0);
    }

    if(isDefined(self.reviver)) {
      if(istrue(self.liveragdoll)) {
        vehicles = vehicle_getarrayinradius(spawnorigin, 500);

        foreach(vehicle in vehicles) {
          if(vehicle scripts\cp_mp\vehicles\vehicle_occupancy::function_4e4cf75e0f7e4184(spawnorigin)) {
            [exitorigin, exitdirection] = scripts\cp_mp\vehicles\vehicle_occupancy::function_9d86fd9a89cd2702(self, vehicle, spawnorigin);
            spawnorigin = exitorigin;
            break;
          }
        }
      } else if(positionwouldtelefrag(spawnorigin) || !var_e5f115aee2bf7de7.isvalidpos) {
        spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn(self.reviver);
        self.reviver = undefined;

        if(isDefined(spawnpoint)) {
          spawnorigin = spawnpoint.origin;
          spawnangles = spawnpoint.angles;
        }
      } else {
        spawnorigin = var_e5f115aee2bf7de7.spawnposition;
      }
    }
  } else if(istrue(level.usespawnselection) && self[[level.var_d280c5fdb0036183]]() && istrue(gameflag("prematch_done"))) {
    spawnpoint = scripts\mp\spawnselection::getspawnpoint();
    assertex(isDefined(spawnpoint), "<dev string:x81>");
    assert(isDefined(spawnpoint.origin));
    assert(isDefined(spawnpoint.angles));
    spawnorigin = spawnpoint.origin;
    spawnangles = spawnpoint.angles;
  } else {
    spawnpoint = self[[level.getspawnpoint]]();
    assertex(isDefined(spawnpoint), "<dev string:xbd>");
    assert(isDefined(spawnpoint.origin));
    assert(isDefined(spawnpoint.angles));
    spawnorigin = spawnpoint.origin;
    spawnangles = spawnpoint.angles;
  }

  if(isDefined(self.setspawnpoint)) {
    if(!istrue(level.usespawnselection)) {
      self.ti_spawn = 1;
    }

    if(istrue(self.ti_spawn)) {
      spawnpoint = self.setspawnpoint;

      if(!istrue(self.setspawnpoint.notti)) {
        if(istrue(level.isgroundwarinfected) && istrue(level.var_624c83b532efce04) && level.mapname != "mp_aniyah") {
          self.movedtoinfected = undefined;
          parachutespawn = ter_op(istrue(level.alwaysdoskyspawnontacinsert), 1, istrue(self.setspawnpoint.issuper));

          if(parachutespawn) {
            self.setspawnpoint.playerspawnpos += (0, 0, level.infectparachuteheightoffset);
            heightclamp = getdvarint(@ "hash_492618a75e1c0035", 0);

            if(heightclamp > 0) {
              if(self.setspawnpoint.playerspawnpos[2] > heightclamp) {
                self.setspawnpoint.playerspawnpos = (self.setspawnpoint.playerspawnpos[0], self.setspawnpoint.playerspawnpos[1], heightclamp);
              }
            }

            self.isparachutespawning = 1;
          }
        }

        self.ti_spawn = 1;
        self playlocalsound("tactical_spawn");

        if(level.teambased) {
          foreach(entry in level.teamnamelist) {
            if(entry != self.team) {
              self playsoundtoteam("tactical_spawn", entry);
            }
          }
        } else {
          self playSound("tactical_spawn");
        }
      }

      foreach(tank in level.ugvs) {
        if(distancesquared(tank.origin, spawnpoint.playerspawnpos) < 1024) {
          tank notify("damage", 5000, tank.owner, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, makeweapon("killstreak_jammer_mp"));
        }
      }

      assert(isDefined(spawnpoint.playerspawnpos));
      assert(isDefined(spawnpoint.angles));

      if(scripts\mp\equipment\tac_insert::function_801a0264d93b7be6(self.setspawnpoint.playerspawnpos)) {
        spawnorigin = self.setspawnpoint.playerspawnpos;
        spawnangles = self.setspawnpoint.playerspawnangles;
      } else {
        var_57f38e8d47549af9 = getnodesinradiussorted(self.setspawnpoint.playerspawnpos, 512, 0, 64, "path");

        foreach(node in var_57f38e8d47549af9) {
          position = node.origin + (0, 0, 3);

          if(canspawn(position, self)) {
            spawnorigin = position;
            spawnangles = node.angles;
            break;
          }
        }
      }

      scripts\mp\equipment\tac_insert::spawnpoint_clearspawnpoint(0, 1);
      spawnpoint = undefined;
    }
  }

  spawndata = spawnStruct();
  spawndata.spawnpoint = spawnpoint;
  spawndata.spawnorigin = spawnorigin;

  if(!isDefined(spawnangles)) {
    spawnangles = (0, 0, 0);
  }

  spawndata.spawnangles = (0, spawnangles[1], 0);
  return spawndata;
}

function spawnplayer(fauxspawn, revivespawn) {
  self endon("disconnect");
  self endon("joined_spectators");
  self notify("spawned");
  self notify("end_respawn");
  self notify("started_spawnPlayer");

  if(self.team == "codcaster") {
    return;
  }

  if(!isDefined(fauxspawn)) {
    fauxspawn = 0;
  }

  if(!isDefined(revivespawn)) {
    revivespawn = 0;
  }

  if(teamhasinfil(self.team) && !gameflag("infil_started") && !isDefined(level.bypassclasschoicefunc)) {
    if(getdvarint(@ "hash_206a763969420ce0", 0) == 1 && scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "dmz" && getsubgametype() != "exgm" && getsubgametype() != "plunder" && getsubgametype() != "risk" && getsubgametype() != "sandbox" && getsubgametype() != "rumble_mgl") {
      hasinfil = teamhasinfil(self.team);
      started = gameflag("infil_started");
      bypass = isDefined(level.bypassclasschoicefunc);
      scripts\mp\utility\script::demoforcesre("spawnPlayer()" + self.name + " ui_options_menu = 2, hasInfil = " + hasinfil + " infil_started = " + started + "bypassClassChoiceFunc = " + bypass);
    }

    if(!istrue(self.var_10844ddcb34694ee)) {
      self setclientomnvar("ui_options_menu", 2);
    }
  } else if(!isDefined(game["state"]) || game["state"] != "playing") {
    self setclientomnvar("ui_options_menu", 0);
  }

  self setclientomnvar("ui_hud_shake", 0);
  self setclientomnvar("ui_combat_report_num_attackers", 0);
  self.lastkillsplash = undefined;
  self.spawnedasspectator = undefined;
  self.scorestreakvariantattackerinfo = undefined;
  self.cratemantle = undefined;
  self.var_4a2f2f50a9020e2e = undefined;

  if(getdvarint(@ "scr_game_forceuav", 0) != 0) {
    level thread scripts\cp_mp\killstreaks\uav::function_c11936b9c6c3a076(self);
  }

  if(getdvarint(@ "hash_c4849d6a757e0b64", 0) != 0) {
    self.waitingtospawnamortize = 1;
    numplayerswaitingtospawn = getdvarint(@ "hash_c4849d6a757e0b64", 0);
    wait level.framedurationseconds * numplayerswaitingtospawn;
    self.waitingtospawnamortize = 0;
  }

  level.numplayerswaitingtospawn++;

  if(level.numplayerswaitingtospawn > 1) {
    println("<dev string:xf9>");
    self.waitingtospawnamortize = 1;
    wait level.framedurationseconds * (level.numplayerswaitingtospawn - 1);
  }

  if(getteamdata(self.team, "noRespawns") == 1 && !revivespawn) {
    if(!isDefined(self.lastdeathtime)) {
      return;
    } else if(level.var_defc2acd2b0203ad[self.team] < self.lastdeathtime) {
      return;
    }
  }

  thread spawningclientthisframereset();
  self.waitingtospawnamortize = 0;
  self.validspawn = 0;
  thread validatespawn();

  if(!isDefined(scripts\mp\utility\stats::getpersstat("copiedClass"))) {
    loadoutstruct = scripts\mp\class::preloadandqueueclass(self.class, 1);
  } else {
    classstruct = scripts\mp\class::loadout_getorbuildclassstruct(self.class);
    scripts\mp\class::loadout_fixcopiedclassstruct(self.pers["copiedClass"], classstruct);

    if(isDefined(self.pers["lastKiller"])) {
      logloadoutcopy(self.pers["lastKiller"]);
      self.pers["lastKiller"] = undefined;
    }

    scripts\mp\class::preloadandqueueclassstruct(self.pers["copiedClass"], 1);
    loadoutstruct = self.pers["copiedClass"];
    self.pers["copiedClass"] = undefined;
  }

  spawnstarttime = gettime();
  self.spawndata = getspawnpoint();
  setspawnvariables();

  if(!getdvarint(@ "hash_9c2d59c1962cac50")) {
    assert(level.teambased && (denysystemicteamchoice() || self.sessionteam == self.team) || !level.teambased && self.sessionteam == "<dev string:x125>");
  }

  hadspawned = self.hasspawned;
  self.suicidespawndelay = undefined;
  self.fauxdead = undefined;
  self sethidenameplate(0);
  self function_5226227bce83ebe9(2, self.team);

  if(!fauxspawn) {
    self.killsthislife = [];

    if(!istrue(self.inspawncamera)) {
      updatesessionstate("playing");
    }

    clearkillcamstate();
    self.cancelkillcam = undefined;

    if(istrue(self.liveragdoll)) {
      println("<dev string:x12d>" + gettime() + "<dev string:x133>" + self.name + "<dev string:x139>" + self.health);
    }

    self.maxhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");

    if(istrue(revivespawn)) {
      health = getwatcheddvar("teamReviveHealth");

      if(!isDefined(health)) {
        self.health = getdvarint(@ "hash_a8543004b97470b5", 50);
      } else {
        self.health = health;
      }

      thread notifyreviveregen();
    } else {
      self.health = self.maxhealth;
    }

    if(istrue(self.friendlyfiredeath)) {
      self.friendlyfiredeath = undefined;
      thread scripts\mp\gametypes\common::ffmessageonspawn();
    }

    self.friendlydamage = undefined;
    self.spawntime = gettime();
    self.wasti = self.ti_spawn;
    self.damagedplayers = [];
    self.objectivescaler = 1;
    self.shieldbullethits = 0;
    self.recentshieldxp = 0;
    self.respawntimerstarttime = undefined;
    self.initialrespawndelay = undefined;
    self.lastgastouchtime = undefined;
    self.lastsnapshotgrenadetime = undefined;
    self.lastinsmoketime = undefined;
    self.lastburntime = undefined;
    self.lasttimedamaged = undefined;
    self.var_198b774c93c48891 = undefined;
    self.var_9691e7d8cde294f2 = undefined;
    self.weaponslotblocked = undefined;
    self.var_b43706cbb600fe5a = undefined;
    self.var_7744df488b629b5 = undefined;
    self.clearspawnprotection = undefined;
    scripts\mp\utility\stats::initpersstat("agentsKillstreakCount");

    if(isDefined(self.stuckbygrenade) && self.stuckbygrenade.stuckenemyentity == self) {
      self.stuckbygrenade.stuckenemyentity = undefined;
    }

    self.stuckbygrenade = undefined;
    self.stuckbygrenadeowner = undefined;
    self.lifeid = 0;

    if(getdvarint(@ "hash_7dfc9d99d9c1ff2f", 0) == 1) {
      if(isDefined(game["gameStateRestore"]) && istrue(game["gameStateRestore"].enabled)) {
        self.pers["deaths"] = scripts\mp\gamestaterestore::getlifeid(self.name);
      }
    }

    if(isDefined(scripts\mp\utility\stats::getpersstat("deaths"))) {
      self.lifeid = scripts\mp\utility\stats::getpersstat("deaths");
    }

    cleardamagemodifiers();
    namespace_54fe482119c59b2f::clearkillcamomnvars();
  }

  self.movespeedscaler = 1;

  if(!fauxspawn) {
    self.avoidkillstreakonspawntimer = 5;
    var_f6ef404dcb6eb18c = scripts\mp\utility\stats::getpersstat("lives");

    if(var_f6ef404dcb6eb18c == getgametypenumlives() && getbasegametype() != "control") {
      scripts\mp\playerlogic::addtolivescount();
    }

    if(var_f6ef404dcb6eb18c) {
      if(getbasegametype() != "control") {
        scripts\mp\utility\stats::incpersstat("lives", -1);
      }
    }

    if(!istrue(self.gulag) && (!istrue(self.respawningfromtoken) || istrue(self.var_a8a69818c7e933a9)) && !istrue(self.respawningbr)) {
      scripts\mp\playerlogic::addtoalivecount("spawnPlayer");
    }

    self.var_a8a69818c7e933a9 = undefined;

    if(!hadspawned || gamehasstarted() || gamehasstarted() && level.ingraceperiod && self.hasdonecombat) {
      var_5e94c58dde8a0c0a = 1;

      if(!istrue(level.suicideteamkilllowerslives) && istrue(self.uncounteddeath)) {
        if(getbasegametype() == "control") {
          var_5e94c58dde8a0c0a = 0;
        }
      } else if(istrue(level.var_6f175c9cc4d2f1b7)) {
        var_5e94c58dde8a0c0a = 0;
      }

      if(var_5e94c58dde8a0c0a) {
        scripts\mp\playerlogic::removefromlivescount();
      }
    }

    if(!istrue(self.wasaliveatmatchstart)) {
      var_2208746f8409b6d0 = 20;

      if(gettimelimit() > 0 && var_2208746f8409b6d0 < gettimelimit() / 4) {
        var_2208746f8409b6d0 = gettimelimit() / 4;
      }

      if(level.ingraceperiod || gettimepassed() < var_2208746f8409b6d0 * 1000) {
        self.wasaliveatmatchstart = 1;
      }
    }
  }

  thread scripts\cp_mp\challenges::onspawn();
  sfov = getDvar(@ "hash_f2bdd0a9974968aa", "65");

  if(self isconsoleplayer()) {
    self setclientdvar(@ "cg_fov", sfov);
  }

  if(isDefined(self.spawndata.spawnpoint)) {
    if(!istrue(self.shouldgetnewspawnpoint)) {
      scripts\mp\spawnlogic::finalizespawnpointchoice(self.spawndata.spawnpoint);
    }

    self.lastspawntime = gettime();
  } else if(!isDefined(self.faux_spawn_infected)) {
    self.lastspawntime = gettime();
  }

  self.spawnpos = self.spawndata.spawnorigin;

  if(fauxspawn && scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    if(self isonground()) {
      self normalizeworldupreferenceangles();
      self.spawndata.spawnorigin -= (0, 0, 80);
    }

    spawnangles = self getworldupreferenceangles();
  }

  self.lifetimedamage = 0;
  self.var_489f22c08f63bc0f = 0;
  scripts\mp\spectating::setspectatepermissions();

  if(istrue(self.liveragdoll)) {
    self sethidenameplate(0);
    self.healthregendisabled = 0;
    self.liveragdoll = 0;
    stopspectateplayer(self getentitynumber(), 1, 0);
    updatesessionstate("playing");
    scripts\cp_mp\utility\player_utility::function_6fb380927695ee76();
    scripts\cp_mp\utility\player_utility::function_985b0973f29da4f8("playerlogic::spawnPlayer()");
    self function_6b4c8718bc36d1ef(0);
    self function_e4ccd01fb7ec7a6f(0);
    self function_d87e1768229d0e3e();
    _freezecontrols(0, undefined, "liveRagdoll");
    scripts\mp\class::setthirdpersonview();
  } else {
    if(isDefined(self.var_f109e15fae27ddc2)) {
      self function_fe283bad58880808(self.spawndata.spawnorigin, self.spawndata.spawnangles[1], self.var_f109e15fae27ddc2);
    } else {
      self spawn(self.spawndata.spawnorigin, self.spawndata.spawnangles);
    }

    playerangles = undefined;

    if(isDefined(level.getplayerspawnangles)) {
      playerangles = self[[level.getplayerspawnangles]]();
    }

    if(!isDefined(playerangles)) {
      playerangles = (0, self.spawndata.spawnangles[1], 0);
    }

    self setplayerangles(playerangles, 1);
    printspawnmessage("playerlogic::spawnPlayer() !!!CODE SPAWN!!! @" + self.spawndata.spawnorigin);

    if(getDvar(@ "hash_87485eca39b418a6") == "1" && scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587() && !istrue(self.gulag)) {
      scripts\mp\outline::hudoutline_add_channel_internal("target acquisition", 1, getDvar(@ "hash_b2a3957007bd8417", "outline_depth_trans_red"));

      if(!isbot(self)) {
        enableoutline();
      }
    }

    if(getdvarint(@ "hash_432df71393030be5", 0) == 1) {
      scripts\mp\outline::hudoutline_add_channel_internal("damage", 2, "outline_nodepth_white");
    }
  }

  self.combatinstances = [];

  if(!istrue(self.inspawncamera)) {
    self.var_f109e15fae27ddc2 = undefined;
    self.platformoffset = undefined;
  }

  if(!isDefined(level.lastspawnpos)) {
    level.lastspawnpos = [];
  }

  level.lastspawnpos[self.team] = self.spawndata.spawnorigin;
  self.death_timer_length = 1023;

  if((fauxspawn || revivespawn) && isDefined(self.faux_spawn_stance)) {
    self setstance(self.faux_spawn_stance);
    self.faux_spawn_stance = undefined;
  }

  if(isai(self)) {
    _freezecontrols(1, undefined, "spawn");
  }

  self motionblurhqenable();

  if(!fauxspawn) {
    self painvisionon();
  }

  canparachutebecut(self);
  [[level.onspawnplayer]](revivespawn);

  if(!isDefined(level.var_58a42cd072629ca) || [[level.var_58a42cd072629ca]]()) {
    self clearpredictedstreampos();
  }

  var_89c45825fbc9944b = !fauxspawn || istrue(self.faux_spawn_infected);

  if(var_89c45825fbc9944b) {
    if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["player_spawned"])) {
      self[[level.bot_funcs["player_spawned"]]]();
    }

    if(isDefined(level.matchrecording_logevent)) {
      [[level.matchrecording_logevent]](self.clientid, self.team, "SPAWN", self.spawnpos[0], self.spawnpos[1], self.spawntime);
    }

    if(!isai(self) && !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      thread totaldisttracking(self.spawndata.spawnorigin);
    }
  }

  if(!fauxspawn) {
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_player_spawned", self);
    callback::callback("onPlayerSpawn_destroyEquipment");
    self.matchdatalifeindex = -1;

    if(namespace_de6e6777b0937bd7::function_892570944f6b6a2(self)) {
      self.matchdatalifeindex = game["life_count"];
      game["life_count"]++;
    }

    self.lastmatchdatakillstreakindex = -1;

    if(getdvarint(@ "online_matchdata_enabled") != 0) {
      setmatchdata("lifeCount", game["life_count"]);
    }
  }

  if(isDefined(self.selectedspawnarea)) {
    scripts\mp\analyticslog::logevent_spawnselectionchoice(self, self.selectedspawnarea);
  }

  scripts\mp\equipment::clearallequipment();
  assert(scripts\mp\class::isvalidclass(self.class));

  if(istrue(level.var_606eb45e074ff204)) {
    scripts\mp\perks\perks::function_7ef2f6d740da9325();
  }

  scripts\mp\class::setclass(self.class);

  if(isDefined(level.custom_giveloadout)) {
    self[[level.custom_giveloadout]](fauxspawn, revivespawn);
  } else {
    if(istrue(self.var_309a9b707ba4b596)) {
      thread scripts\mp\equipment\tac_insert::function_3807e5acb77b5011(revivespawn);
    } else {
      scripts\mp\class::giveloadout(self.team, self.class, undefined, undefined, revivespawn);
    }

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      scripts\mp\perks\perks::function_f2dbab6f947771f2();
      self.perksgiven = 1;

      if(!scripts\mp\utility\perk::_hasperk("specialty_overcharge_field_upgrade")) {
        scripts\mp\supers::function_b3d636936ec98aa0(0);
        self.overclockcharge = undefined;
      }
    }

    if(scripts\mp\utility\perk::_hasperk("specialty_survivor")) {
      self.var_4945d0d82dd3964b = 0;
    }
  }

  if(getomnvar("ui_prematch_period")) {
    thread showgamemodeobjectivetext();
    thread function_155c4aaa1dae57e6();

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      thread function_ebd3a9ccfbeb79c3();
    }
  }

  if(!istrue(game["isLaunchChunk"])) {
    thread logstartingloadout();

    if(istrue(level.codcasterenabled) && !self iscodcaster()) {
      thread function_1354d352db863672(self);
    }
  }

  if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] > 0) {
    if(!isDefined(self.classrefreshed) || !self.classrefreshed) {
      if(isDefined(self.class_num)) {
        self.classrefreshed = 1;
      }
    }
  }

  if(getdvarint(@ "camera_thirdperson")) {
    setthirdpersondof(1);
  }

  if(isai(self)) {
    _freezecontrols(0, undefined, "spawn");
  }

  if(istrue(game["inLiveLobby"]) || scripts\cp_mp\utility\game_utility::isbrstylegametype() && !gameflag("prematch_done")) {
    if(getsubgametype() == "dmz" || getsubgametype() == "exgm") {
      allowprematchlook(self);
    }
  } else if(!gameflag("prematch_done")) {
    allowprematchlook(self);
  } else {
    force = !self.hasspawned;
    _freezecontrols(0, force, "spawn");
    _freezelookcontrols(0, force);
  }

  if(!istrue(self.hasspawned)) {
    scripts\mp\gamelogic::updatematchhasmorethan1playeromnvaronplayersfirstspawn();
  }

  if(isDefined(scripts\mp\utility\stats::getpersstat("hasEarnedHardlineStreak")) && scripts\mp\utility\stats::getpersstat("hasEarnedHardlineStreak") == 0) {
    scripts\mp\killstreaks\killstreaks::givestreakpoints(#"hash_faa043c8926419e6", 3, 0);
  }

  self.hasspawned = 1;
  self.pers["hasSpawned"] = 1;

  if(isDefined(level.var_fa280df6cfd09d0b)) {
    self[[level.var_fa280df6cfd09d0b]]();
  }

  assert(spawnstarttime == gettime());
  waittillframeend();
  self.spawningafterremotedeath = undefined;
  self.delayedspawnedplayernotify = undefined;

  if(!istrue(level.disablespawncamera) && isDefined(self.spawncameraent) || istrue(level.disablespawncamera) && isDefined(self.spawncameraent) && (getgametype() == "arm" || getgametype() == "conflict" || getgametype() == "risk")) {
    self.wasrevivespawn = revivespawn;
    self.delayedspawnedplayernotify = 1;
    self notify("spawncamera_start");
  }

  if(istrue(self.var_309a9b707ba4b596)) {
    self.wasrevivespawn = revivespawn;
    self.delayedspawnedplayernotify = 1;
    self notify("ti_spawncamera_start");
  }

  if(!istrue(self.delayedspawnedplayernotify)) {
    self notify("spawned_player");
    level notify("player_spawned", self, revivespawn);
    thread setspawnnotifyomnvar();
  }

  if(game["state"] == "postgame") {
    assert(!level.intermission);
    scripts\mp\gamelogic::freezeplayerforroundend();
  }

  if(scripts\mp\analyticslog::analyticsspawnlogenabled() && !fauxspawn) {
    if(scripts\mp\analyticslog::analyticsdoesspawndataexist()) {
      level.spawncount += 1;
    } else {
      scripts\mp\analyticslog::analyticsinitspawndata();
    }

    if(scripts\mp\analyticslog::analyticssend_shouldsenddata(level.spawncount)) {
      if(isDefined(level.spawnglobals.spawnpointslist)) {
        scripts\mp\analyticslog::analyticssend_spawnfactors(self, self.spawnpointslist, level.spawncount, self.spawndata.spawnpoint);
        scripts\mp\analyticslog::analyticssend_spawntype(self.spawndata.spawnpoint.origin, self.team, self.lifeid, level.spawncount);
        scripts\mp\analyticslog::analyticssend_spawnplayerdetails(self, self.spawndata.spawnpoint.origin, level.spawncount);
      }
    }

    self.lastspawnpoint = self.spawndata.spawnpoint;
  }

  if(!istrue(self.delayedspawnedplayernotify)) {
    self.spawndata = undefined;
  }

  if(!isDefined(self.revive_chosenclass)) {
    thread scripts\mp\class::updateinstantclassswapallowed();
  }

  alloweverywhere = 0;

  alloweverywhere = getdvarint(@ "hash_174506584f9d388e", 0) == 1;

  if(alloweverywhere || isusingmatchrulesdata() && getmatchrulesdata("commonOption", "allowParachute") || gametypesupportsbasejumping() && mapsupportsbasejumping()) {
    self skydive_setbasejumpingstatus(1);
    self skydive_setdeploymentstatus(1);
  }

  self.validspawn = 1;
  self notify("validate_spawn");

  if(istrue(self.var_b1e84fe29da97885)) {
    level thread scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 0, 0);
  }

  callback("player_spawned");
}

function validatespawn() {
  self endon("disconnect");
  waittill_any_timeout_1(1, "validate_spawn");

  if(!istrue(self.validspawn)) {
    kick(self getentitynumber(), "EXE/PLAYERKICKED");
  }
}

function enableoutline() {
  thread function_9055412313c726ad();
}

function function_9055412313c726ad() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }

  self.var_c7365acbd7c37449 = [];
  var_68a6cd6d3cb58e79 = spawnStruct();
  self.wasdriver = 0;
  self.isdriver = 0;
  thread isvehicledriver();

  while(true) {
    enemies = self getsightedplayers();

    if(!isDefined(enemies)) {
      continue;
    }

    if(self.isdriver) {
      if(!self.wasdriver) {
        foreach(localenemy in enemies) {
          localenemy scripts\mp\outline::function_32dfa50c47325abe(self, "target acquisition", 1);
        }

        self.wasdriver = 1;
      }

      waitframe();
      continue;
    }

    function_a9d32c0b976412da(var_68a6cd6d3cb58e79);
    var_2fd22303c5fca912 = scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "dmz";

    foreach(localenemy in enemies) {
      if(var_2fd22303c5fca912) {
        if(isDefined(localenemy.haslanded) && !localenemy.haslanded) {
          continue;
        }
      }

      if(array_contains_key(self.var_c7365acbd7c37449, localenemy.clientid)) {
        self.var_c7365acbd7c37449[localenemy.clientid].visible = 1;
      } else {
        self.var_c7365acbd7c37449[localenemy.clientid] = spawnStruct();
        self.var_c7365acbd7c37449[localenemy.clientid].enemyentity = localenemy;
        self.var_c7365acbd7c37449[localenemy.clientid].finishtimer = 0;
        thread function_1610dbc40254209c(localenemy);
      }

      enable_outline = 0;
      viewpos = localenemy gettagorigin("j_spinelower") - self gettagorigin("tag_eye");
      disttoplayer = length(viewpos);

      if(self.var_c7365acbd7c37449[localenemy.clientid].finishtimer) {
        if(disttoplayer < var_68a6cd6d3cb58e79.maxdist && disttoplayer > getdvarfloat(@ "hash_1adfe2e839bc58a6")) {
          angle = scripts\engine\math::anglebetweenvectors(viewpos, anglesToForward(self getplayerangles()));

          if(angle < var_68a6cd6d3cb58e79.maxangle) {
            enable_outline = 1;
          }
        }
      }

      var_eeb63a7eca4dce95 = ter_op(!isbot(self), self function_e9d534b5f70dc904(), 1);

      if(var_eeb63a7eca4dce95 && enable_outline) {
        localenemy scripts\mp\outline::hudoutline_enable_internal(self, "target acquisition");
        continue;
      }

      localenemy scripts\mp\outline::function_32dfa50c47325abe(self, "target acquisition", 1);
    }

    var_f421c15cb65f2710 = getarraykeys(self.var_c7365acbd7c37449);

    foreach(var_fd31c374b38d3c00 in var_f421c15cb65f2710) {
      if(isDefined(self.var_c7365acbd7c37449[var_fd31c374b38d3c00].visible) && !self.var_c7365acbd7c37449[var_fd31c374b38d3c00].visible) {
        self.var_c7365acbd7c37449[var_fd31c374b38d3c00].enemyentity notify("out_of_sight_" + self.clientid);
        self.var_c7365acbd7c37449 = array_remove_key(self.var_c7365acbd7c37449, var_fd31c374b38d3c00);
        continue;
      }

      self.var_c7365acbd7c37449[var_fd31c374b38d3c00].visible = 0;
    }

    waitframe();
  }
}

function isvehicledriver() {
  self endon("death_or_disconnect");

  while(true) {
    message = waittill_any_timeout_3(1, "vehicle_enter", "vehicle_change_seat", "vehicle_exit");

    if(self.wasdriver && message == "vehicle_exit") {
      self.wasdriver = 0;
      self.isdriver = 0;
      continue;
    }

    if(message == "vehicle_enter") {
      self.isdriver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);
      continue;
    }

    if(message == "vehicle_change_seat") {
      self.wasdriver = self.isdriver;
      self.isdriver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);
    }
  }
}

function function_1610dbc40254209c(localenemy) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  localenemy endon("death_or_disconnect");
  localenemy endon("out_of_sight_" + self.clientid);
  wait getdvarfloat(@ "hash_babf297f40ef9792", 1.5);
  self.var_c7365acbd7c37449[localenemy.clientid].finishtimer = 1;
}

function function_a9d32c0b976412da(var_68a6cd6d3cb58e79) {
  isads = self playerads() > 0.5;
  var_68a6cd6d3cb58e79.minangle = getdvarfloat(@ "hash_82bf79a286a47409", 1);
  var_68a6cd6d3cb58e79.maxdist = ter_op(isads, getdvarfloat(@ "hash_9166b379c429ca44"), getdvarfloat(@ "hash_d9a3414a981b1b5a"));
  var_68a6cd6d3cb58e79.maxangle = ter_op(isads, getdvarfloat(@ "hash_b04f78259746bfaa", 7), getdvarfloat(@ "hash_7544939a6ec22268", 12));

  if(isads && self playergetzoomfov() <= 30) {
    var_68a6cd6d3cb58e79.maxdist = getdvarfloat(@ "hash_7ea5074a21ca4ba1");
    var_68a6cd6d3cb58e79.maxangle = getdvarfloat(@ "hash_ef8fa48b3241b8f3", 3);
  }
}

function logloadoutcopy(killer) {
  if(isDefined(killer)) {
    self dlog_recordplayerevent("dlog_event_loadout_copy", ["receiver_player_client_id", self.clientid, "receiver_gamertag", self.name, "giver_player_client_id", killer.clientid, "giver_gamertag", killer.name]);
  }
}

function logstartingloadout() {
  if(gameflag("prematch_done")) {
    return;
  }

  if(!isDefined(self.curclass)) {
    return;
  }

  if(self.curclass == "juggernaut") {
    return;
  }

  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\class::function_200c71e93799b32f(self.classstruct);
  gameflagwait("prematch_done");

  if(isDefined(level.var_493c039ada7d082e)) {
    throttle::function_f632348cbb773537(level.var_493c039ada7d082e, self);
  }

  scripts\mp\class::loadout_lognewlygivenloadout(self.globalstruct, self.classstruct, self.curclass);
}

function notifyreviveregen() {
  self endon("disconnect");
  self waittill("spawned_player");
  waitframe();
  self notify("force_regeneration");
}

function setspawnnotifyomnvar() {
  self endon("disconnect");
  waitframe();
  self setclientomnvar("ui_player_spawned_notify", gettime());
}

function playerprematchallow(allow) {
  if(!allow) {
    val::set("prematch", "allow_movement", 0);
    val::set("prematch", "fire", 0);
    val::set("prematch", "offhand_weapons", 0);
    val::set("prematch", "offhand_primary_weapons", 0);
    val::set("prematch", "offhand_secondary_weapons", 0);
    val::set("prematch", "supers", 0);
    val::set("prematch", "allow_jump", 0);
    val::set("prematch", "melee", 0);
    val::set("prematch", "sprint", 0);
    val::set("prematch", "killstreaks", 0);
    val::set("prematch", "usability", 0);

    if(!istrue(level.disablemount)) {
      val::set("prematch_mount", "mount_top", 0);
      val::set("prematch_mount", "mount_side", 0);
    }

    return;
  }

  val::reset_all("prematch");

  if(!istrue(level.disablemount)) {
    val::reset_all("prematch_mount");
  }
}

function allowprematchlook(player) {
  player[[level.prematchallowfunc]](0);
  player.prematchlook = 1;
}

function clearprematchlook(player) {
  if(istrue(player.prematchlook) && !level.gameended) {
    player[[level.prematchallowfunc]](1);
    player.prematchlook = undefined;
  }
}

function waitforversusmenudone() {
  level endon("prematch_over");
  self endon("versus_menu_done");

  for(;;) {
    self waittill("luinotifyserver", result, value);

    if(result == "versus_done") {
      self notify("versus_menu_done");
    }
  }
}

function function_b18bcc805b8800e() {
  scripts\mp\gametypes\br_armor::function_bcb1d5fb674fa3a0();
  reserveplates = scripts\cp_mp\armor::function_20b8437058079297();
  var_dccf522fb0268d46 = 0;

  if(issharedfuncdefined("backpack", "getTotalItemCountInBag")) {
    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_armor_plate");
    var_dccf522fb0268d46 = [[getsharedfunc("backpack", "getTotalItemCountInBag")]](lootid);
  }

  var_fbe8d53a303038c4 = reserveplates + var_dccf522fb0268d46;
  scripts\mp\codcasterclientmatchdata::function_f8b808cd6473e6cc(20, var_fbe8d53a303038c4);
  var_b8b6fa3d6f2f0b8c = 0;

  if(isDefined(self.gasmaskhealth) && isDefined(self.gasmaskmaxhealth)) {
    var_b8b6fa3d6f2f0b8c = (self.gasmaskhealth + 1) / self.gasmaskmaxhealth;
  }

  scripts\mp\codcasterclientmatchdata::function_f8b808cd6473e6cc(21, var_b8b6fa3d6f2f0b8c);
  hasselfrevivetoken = scripts\mp\gametypes\br_public::hasselfrevivetoken();
  scripts\mp\codcasterclientmatchdata::function_f8b808cd6473e6cc(22, hasselfrevivetoken);
}

function function_1354d352db863672(player) {
  player endon("death_or_disconnect");

  for(;;) {
    if(isDefined(player.primaryweaponobj)) {
      player setclientweaponinfo(0, getcompleteweaponname(player.primaryweaponobj));
    }

    if(isDefined(player.secondaryweaponobj)) {
      player setclientweaponinfo(1, getcompleteweaponname(player.secondaryweaponobj));
    }

    player updatemlgammoinfo();
    player updatecurrentweapon();
    player function_b18bcc805b8800e();
    wait 0.05;
  }
}

function function_38d8271a5b966538() {
  var_c2db1b6c79ea1c6c = getStructArray("camera_intro", "targetname");

  if(!isDefined(var_c2db1b6c79ea1c6c) || var_c2db1b6c79ea1c6c.size == 0) {
    var_c2db1b6c79ea1c6c = [];
    var_c2db1b6c79ea1c6c[0] = spawnStruct();
    var_c2db1b6c79ea1c6c[0].origin = (0, 0, 0);
    var_c2db1b6c79ea1c6c[0].angles = (0, 0, 0);
  }

  mapname = getmapname();

  switch (mapname) {
    case #"hash_a62df42a13dad323":
      var_c2db1b6c79ea1c6c[0].origin = (1606.95, 2238.61, 958.77);
      var_c2db1b6c79ea1c6c[0].angles = (17, 215, -4.14);
      break;
    case #"hash_81c63d549bea3339":
      var_c2db1b6c79ea1c6c[0].origin = (310, -627, 279);
      var_c2db1b6c79ea1c6c[0].angles = (4, 196, 0);
      break;
    case #"hash_8eb456b9e1d842c7":
      var_c2db1b6c79ea1c6c[0].origin = (1867, -2487, 664);
      var_c2db1b6c79ea1c6c[0].angles = (15, 118, 0);
      break;
    case #"hash_9c2fdccb75b37f7e":
      var_c2db1b6c79ea1c6c[0].origin = (-856, 2771, 1030);
      var_c2db1b6c79ea1c6c[0].angles = (18, 313, 0);
      break;
    case #"hash_a8186a9f8bd241d6":
      var_c2db1b6c79ea1c6c[0].origin = (691, -536, 223);
      var_c2db1b6c79ea1c6c[0].angles = (9, 159, 0);
      var_c2db1b6c79ea1c6c[1] = spawnStruct();
      var_c2db1b6c79ea1c6c[1].origin = (428, 508, 14);
      var_c2db1b6c79ea1c6c[1].angles = (0, 182, 0);
      var_d0f582ece8584466 = 1;
      break;
    case #"hash_d369b0ca801c4b63":
      var_c2db1b6c79ea1c6c[0].origin = (1260, 203, 239);
      var_c2db1b6c79ea1c6c[0].angles = (15, 189, 0);
      var_c2db1b6c79ea1c6c[1] = spawnStruct();
      var_c2db1b6c79ea1c6c[1].origin = (-582, -154, 64);
      var_c2db1b6c79ea1c6c[1].angles = (0, 137, 0);
      var_d0f582ece8584466 = 1;
      break;
    case #"hash_89cd8aae588a4328":
      var_c2db1b6c79ea1c6c[0].origin = (2446, 19, 377);
      var_c2db1b6c79ea1c6c[0].angles = (24, 178, 0);
      var_c2db1b6c79ea1c6c[1] = spawnStruct();
      var_c2db1b6c79ea1c6c[1].origin = (435, 11, 15);
      var_c2db1b6c79ea1c6c[1].angles = (0, 0, 0);
      var_d0f582ece8584466 = 1;
      break;
    case #"hash_51f2bb9a988ac56a":
      var_c2db1b6c79ea1c6c[0].origin = (254, 1651, 353);
      var_c2db1b6c79ea1c6c[0].angles = (10, 253, 0);
      var_c2db1b6c79ea1c6c[1] = spawnStruct();
      var_c2db1b6c79ea1c6c[1].origin = (231, -1024, 37);
      var_c2db1b6c79ea1c6c[1].angles = (353, 89, 0);
      var_d0f582ece8584466 = 1;
      break;
    case #"hash_a11e6e81ea219453":
    case #"hash_ce2681671c034722":
      var_c2db1b6c79ea1c6c[0].origin = (-36200, -25850, 2000);
      var_c2db1b6c79ea1c6c[0].angles = (25, 70, 0);
      break;
    case #"hash_5586b38644ed9b26":
      var_c2db1b6c79ea1c6c[0].origin = (-8982.57, -51049.3, 2653.06);
      var_c2db1b6c79ea1c6c[0].angles = (14, 59, 0);
      break;
  }

  return var_c2db1b6c79ea1c6c;
}

function spawnspectatormapcam(cameraoverride) {
  var_2365afb9696e69a4 = 6;
  var_63efee80a44e06e1 = 4;
  var_c3899f8e31b31e75 = 4;
  var_d0f582ece8584466 = 0;
  self endon("disconnect");

  if(isai(self)) {
    return;
  }

  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars(@ "hash_682a9bc40f96ca4a", "0.65");
  } else {
    self setclientdvars(@ "hash_682a9bc40f96ca4a", "1");
  }

  self setclientomnvar("ui_mapshot_camera", 1);
  self lerpfovbypreset("mapflyover");
  var_c2db1b6c79ea1c6c = function_38d8271a5b966538();

  if(var_c2db1b6c79ea1c6c.size == 0 || gameflag("infil_will_run")) {
    self visionsetfadetoblackforplayer("", 0.75);
    return;
  }

  var_4006e26a6a576e8 = undefined;
  endpoint = undefined;
  var_940902e006c2d2a2 = undefined;
  setspawnvariables();
  setlowermessageomnvar("clear_lower_msg");
  updatesessionstate("spectator");
  self.pers["team"] = "spectator";
  self.team = "spectator";
  clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonspectate();

  foreach(entry in level.teamnamelist) {
    self allowspectateteam(entry, 0);
  }

  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);

  if(isDefined(var_c2db1b6c79ea1c6c) && var_c2db1b6c79ea1c6c.size > 1 && !istrue(var_d0f582ece8584466)) {
    var_7342959c0a950bd8 = randomintrange(0, var_c2db1b6c79ea1c6c.size - 1);
    var_4006e26a6a576e8 = var_c2db1b6c79ea1c6c[var_7342959c0a950bd8];
  } else if(isDefined(var_c2db1b6c79ea1c6c)) {
    var_4006e26a6a576e8 = var_c2db1b6c79ea1c6c[0];

    if(istrue(var_d0f582ece8584466)) {
      var_940902e006c2d2a2 = var_c2db1b6c79ea1c6c[1];
    }
  } else {
    assertmsg("<dev string:x195>");
  }

  var_4006e26a6a576e8.fil = 1;
  _freezecontrols(1, undefined, "spectatorMapCam");
  self setspectatedefaults(var_4006e26a6a576e8.origin, var_4006e26a6a576e8.angles);
  self spawn(var_4006e26a6a576e8.origin, var_4006e26a6a576e8.angles);
  printspawnmessage("playerlogic::spawnSpectatorMapCam() !!!CODE SPAWN!!! @" + var_4006e26a6a576e8.origin);
  var_2584e8f1c45ffb37 = spawn("script_model", var_4006e26a6a576e8.origin);
  var_2584e8f1c45ffb37 setModel("tag_origin");
  var_2584e8f1c45ffb37.angles = var_4006e26a6a576e8.angles;
  var_a0fd91f162829a01 = undefined;

  if(istrue(var_d0f582ece8584466)) {
    var_a0fd91f162829a01 = spawn("script_model", var_940902e006c2d2a2.origin);
    var_a0fd91f162829a01 setModel("tag_origin");
    var_a0fd91f162829a01.angles = var_940902e006c2d2a2.angles;
  }

  thread waitforversusmenudone();

  if(isDefined(cameraoverride) && cameraoverride == 99) {
    result = "debug";
    println("<dev string:x1b2>");
  } else if(gameflag("prematch_done")) {
    result = "prematch_over";
  } else if(self.versusdone) {
    result = "versus_menu_done";
  } else {
    result = waittill_any_timeout_2(2, "versus_menu_done", "prematch_over");
  }

  if(result == "timeout") {
    if(gameflag("prematch_done")) {
      result = "prematch_over";
    } else {
      result = "versus_menu_done";
    }
  }

  if(result == "prematch_over") {
    self visionsetfadetoblackforplayer("", 0.75);
    return;
  }

  if(self issplitscreenplayer() && self issplitscreenplayerprimary()) {
    otherplayer = self getothersplitscreenplayer();
    otherplayer notify("versus_menu_done");
    waitframe();
  }

  self cameralinkTo(var_2584e8f1c45ffb37, "tag_origin", 1);
  self notify("mapCamera_start");

  switch (level.mapname) {
    case #"hash_7ac8036cc19377e5":
      var_2584e8f1c45ffb37 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_parkour");
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait var_2365afb9696e69a4 - 0.25;
      return;
    default:
      break;
  }

  wait 0.25;
  self visionsetfadetoblackforplayer("", 0.75);
  self playlocalsound("mp_camera_intro_whoosh");
  curpoint = var_4006e26a6a576e8;
  endpoint[0] = spawnStruct();

  if(isDefined(var_4006e26a6a576e8.target)) {
    endpoint[0] = getStruct(var_4006e26a6a576e8.target, "targetname");
  } else {
    endpoint[0].origin = (0, 0, 0);
    endpoint[0].angles = (0, 0, 0);
  }

  switch (level.mapname) {
    case #"hash_a62df42a13dad323":
      endpoint[0].origin = (1925, -857, 1033);
      endpoint[0].angles = (362, 127, 0);
      break;
    case #"hash_81c63d549bea3339":
      endpoint[0].origin = (-399, -1457, 667);
      endpoint[0].angles = (15, 57, 0);
      break;
    case #"hash_8eb456b9e1d842c7":
      endpoint[0].origin = (1422, 2073, 464);
      endpoint[0].angles = (6, 236, 0);
      break;
    case #"hash_9c2fdccb75b37f7e":
      endpoint[0].origin = (1559, 1586, 1030);
      endpoint[0].angles = (30, 234, 0);
      break;
    case #"hash_a8186a9f8bd241d6":
      endpoint[0].origin = (921, 300, 223);
      endpoint[0].angles = (8, 202, 0);
      endpoint[1] = spawnStruct();
      endpoint[1].origin = (415, 372, 14);
      endpoint[1].angles = (3, 179, 0);
      break;
    case #"hash_d369b0ca801c4b63":
      endpoint[0].origin = (714, 440, 167);
      endpoint[0].angles = (13, 205, 0);
      endpoint[1] = spawnStruct();
      endpoint[1].origin = (-859, -349, 75);
      endpoint[1].angles = (7, 104, 0);
      break;
    case #"hash_89cd8aae588a4328":
      endpoint[0].origin = (1952, 354, 77);
      endpoint[0].angles = (6, 208, 0);
      endpoint[1] = spawnStruct();
      endpoint[1].origin = (906, 9, 15);
      endpoint[1].angles = (0, 0, 0);
      var_d0f582ece8584466 = 1;
      break;
    case #"hash_51f2bb9a988ac56a":
      endpoint[0].origin = (-1332, 483, 252);
      endpoint[0].angles = (11, 313, 0);
      endpoint[1] = spawnStruct();
      endpoint[1].origin = (65, -547, 351);
      endpoint[1].angles = (16, 83, 0);
      break;
    case #"hash_a11e6e81ea219453":
    case #"hash_ce2681671c034722":
      endpoint[0].origin = (-30200, -23550, 2000);
      endpoint[0].angles = (25, 150, 0);
      break;
    case #"hash_5586b38644ed9b26":
      endpoint[0].origin = (6444.48, -46895.7, 2653.06);
      endpoint[0].angles = (16, 117, 0);
      break;
  }

  totaldistance = 0;

  while(true) {
    if(isDefined(curpoint.speedadjust)) {
      var_600c46d6ed25dfd7 = 1 / curpoint.speedadjust;
      nodedistance = var_600c46d6ed25dfd7 * distance(curpoint.origin, endpoint[0].origin);
    } else {
      nodedistance = distance(curpoint.origin, endpoint[0].origin);
    }

    totaldistance += nodedistance;
    curpoint.distancetotarg = nodedistance;
    curpoint = endpoint[0];

    if(isDefined(curpoint.target)) {
      endpoint[0] = getStruct(curpoint.target, "targetname");
      continue;
    }

    break;
  }

  curpoint.eol = 1;
  curpoint = var_4006e26a6a576e8;

  if(isDefined(var_4006e26a6a576e8.target)) {
    endpoint[0] = getStruct(var_4006e26a6a576e8.target, "targetname");
  } else {
    endpoint[0].origin = (0, 0, 0);
    endpoint[0].angles = (0, 0, 0);
  }

  if(totaldistance > 0) {
    while(true) {
      var_12da28838c27dba0 = curpoint.distancetotarg / totaldistance;
      timetomove = ter_op(istrue(var_d0f582ece8584466), var_12da28838c27dba0 * var_63efee80a44e06e1, var_12da28838c27dba0 * var_2365afb9696e69a4);

      if(isDefined(endpoint[0].eol)) {
        decel = timetomove / 2;
      } else {
        decel = 0;
      }

      if(isDefined(curpoint.fil)) {
        accel = timetomove / 2;
      } else {
        accel = 0;
      }

      var_2584e8f1c45ffb37 moveTo(endpoint[0].origin, timetomove, accel, decel);
      var_2584e8f1c45ffb37 rotateTo(endpoint[0].angles, timetomove, accel, decel);

      if(isDefined(endpoint[0].eol)) {
        halftime = int(timetomove / 2);
        wait halftime;
        wait halftime;
      } else {
        wait timetomove;
      }

      curpoint = endpoint[0];

      if(isDefined(curpoint.target)) {
        endpoint[0] = getStruct(curpoint.target, "targetname");
        continue;
      }

      break;
    }
  }

  if(istrue(var_d0f582ece8584466)) {
    totaldistance = 0;
    var_dd80e398990947f1 = var_940902e006c2d2a2;
    self spawn(var_940902e006c2d2a2.origin, var_940902e006c2d2a2.angles);
    self cameralinkTo(var_a0fd91f162829a01, "tag_origin", 1);
    wait 0.25;
    self visionsetfadetoblackforplayer("", 0.75);
    self playlocalsound("mp_camera_intro_whoosh");

    while(true) {
      if(isDefined(var_dd80e398990947f1.speedadjust)) {
        var_600c46d6ed25dfd7 = 1 / var_dd80e398990947f1.speedadjust;
        nodedistance = var_600c46d6ed25dfd7 * distance(var_dd80e398990947f1.origin, endpoint[1].origin);
      } else {
        nodedistance = distance(var_dd80e398990947f1.origin, endpoint[1].origin);
      }

      totaldistance += nodedistance;
      var_dd80e398990947f1.distancetotarg = nodedistance;

      if(isDefined(var_dd80e398990947f1.target)) {
        endpoint[1] = getStruct(curpoint.target, "targetname");
        continue;
      }

      break;
    }

    var_dd80e398990947f1.eol = 1;
    var_dd80e398990947f1.fil = 1;
    endpoint[1].eol = 1;

    while(true) {
      var_12da28838c27dba0 = var_dd80e398990947f1.distancetotarg / totaldistance;
      timetomove = ter_op(istrue(var_d0f582ece8584466), var_12da28838c27dba0 * var_c3899f8e31b31e75, var_12da28838c27dba0 * var_2365afb9696e69a4);

      if(isDefined(endpoint[1].eol)) {
        decel = timetomove / 2;
      } else {
        decel = 0;
      }

      if(isDefined(var_dd80e398990947f1.fil)) {
        accel = timetomove / 2;
      } else {
        accel = 0;
      }

      var_a0fd91f162829a01 moveTo(endpoint[1].origin, timetomove, accel, decel);
      var_a0fd91f162829a01 rotateTo(endpoint[1].angles, timetomove, accel, decel);

      if(isDefined(endpoint[1].eol)) {
        halftime = int(timetomove / 2);
        wait halftime;
        wait halftime;
      } else {
        wait timetomove;
      }

      var_dd80e398990947f1 = endpoint[1];

      if(isDefined(var_dd80e398990947f1.target)) {
        endpoint[1] = getStruct(var_dd80e398990947f1.target, "targetname");
        continue;
      }

      break;
    }
  }

  _freezecontrols(0, undefined, "spectatorMapCam");
  self.startcament = var_2584e8f1c45ffb37;
  self setclientomnvar("ui_mapshot_camera", 0);
}

function spawnspectator(origin, angles, gameended) {
  self notify("spawned");
  self notify("end_respawn");
  self notify("joined_spectators");
  level notify("joined_spectators", self);
  self.spawnedasspectator = 1;

  if(isDefined(self.deathspectatepos)) {
    origin = self.deathspectatepos;
    angles = vectortoangles(self.origin - self.deathspectatepos);
  }

  if(isDefined(self.startcament) && !isDefined(origin)) {
    origin = self.startcament.origin;
    angles = self.startcament.angles;
    self.startcament delete();
  }

  in_spawnspectator(origin, angles, gameended);
}

function respawn_asspectator(origin, angles) {
  if(isDefined(self.deathspectatepos)) {
    origin = self.deathspectatepos;

    if(isDefined(self.deathspectateangles)) {
      angles = self.deathspectateangles;
    } else {
      angles = vectortoangles(self.origin - self.deathspectatepos);
    }
  }

  in_spawnspectator(origin, angles);
}

function in_spawnspectator(origin, angles, gameended) {
  setspawnvariables();
  var_b47248e0c4294fa4 = self.pers["team"];

  if(isDefined(var_b47248e0c4294fa4) && (var_b47248e0c4294fa4 == "spectator" || var_b47248e0c4294fa4 == "codcaster") && !level.gameended) {
    setlowermessageomnvar("clear_lower_msg");
  }

  scripts\mp\class::loadout_clearperks();
  updatesessionstate("spectator");
  clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonspectate();
  scripts\mp\spectating::setspectatepermissions();
  onspawnspectator(origin, angles, gameended);

  if(level.teambased && !level.splitscreen && !self issplitscreenplayer()) {
    setdof_spectator();
  }
}

function getplayerfromclientnum(clientnum) {
  if(clientnum < 0) {
    return undefined;
  }

  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] getentitynumber() == clientnum) {
      return level.players[i];
    }
  }

  return undefined;
}

function onspawnspectator(origin, angles, gameended) {
  if(isDefined(origin) && isDefined(angles)) {
    self setspectatedefaults(origin, angles);
    self spawn(origin, angles);
    printspawnmessage("playerlogic::onSpawnSpectator() !!!CODE SPAWN!!! @" + origin);
    return;
  }

  spawnpoint = getspectatepoint();

  if(istrue(level.usespawnselection)) {
    if(getgametype() == "risk") {
      spawnpoint = level.spawncameras["default"]["allies"];
    } else if(istrue(level.usestaticspawnselectioncamera)) {
      spawnpoint = scripts\mp\spawnselection::getstaticcameraposition(self.sessionteam);
    } else if(self.sessionteam == "allies") {
      spawnpoint = level.spawncameras["gw_fob_alliesHQ"]["allies"];
    } else if(self.sessionteam == "axis") {
      spawnpoint = level.spawncameras["gw_fob_axisHQ"]["axis"];
    }
  }

  var_4816b1172f8e226b = 8;

  if(isDefined(level.camerapos) && level.camerapos.size) {
    for(i = 0; i < level.camerahighestindex + 1 && i < var_4816b1172f8e226b; i++) {
      if(!isDefined(level.camerapos[i]) || !isDefined(level.cameraang[i])) {
        continue;
      }

      self setmlgcameradefaults(i, level.camerapos[i], level.cameraang[i]);
      level.cameramapobjs[i].origin = level.camerapos[i];
      level.numbermapobjs[i].origin = level.camerapos[i];
      level.cameramapobjs[i].angles = level.cameraang[i];
      level.numbermapobjs[i].angles = level.cameraang[i];
    }
  } else {
    for(i = 0; i < var_4816b1172f8e226b; i++) {
      self setmlgcameradefaults(i, spawnpoint.origin, spawnpoint.angles);
    }
  }

  self setspectatedefaults(spawnpoint.origin, spawnpoint.angles);

  if(isDefined(gameended)) {
    self allowspectateteam("freelook", 1);
    self allowspectateteam("none", 1);
  }

  if(isgroundwarcoremode() && !self.hasspawned) {
    self function_b88c89bb7cd1ab8e(spawnpoint.origin);
  }

  self spawn(spawnpoint.origin, spawnpoint.angles);
  printspawnmessage("playerlogic::onSpawnSpectator() !!!CODE SPAWN!!! @" + spawnpoint.origin);
}

function getspectatepoint() {
  if(getgametype() == "gwtdm" && isDefined(level.spawncameras) && isDefined(level.spawncameras["default"])) {
    return level.spawncameras["default"][self.sessionteam];
  }

  if(getgametype() == "brtdm" || getgametype() == "brtdm_mgl") {
    return level.brtdm_config.spectatepoint;
  }

  spawnpoints = getEntArray("mp_global_intermission", "classname");
  assertex(spawnpoints.size, "<dev string:x1c2>");
  validspawnpoints = [];

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    if(level.localeid == "locale_6") {
      var_3cc83b4e56d476a9 = spawn("script_origin", (25642, -26550, 1818));
      var_3cc83b4e56d476a9.angles = (14, 101, 0);
      return var_3cc83b4e56d476a9;
    } else if(level.localeid == "locale_3") {
      var_3cc83b4e56d476a9 = spawn("script_origin", (34440, -18522, 995));
      var_3cc83b4e56d476a9.angles = (10, 281, 0);
      return var_3cc83b4e56d476a9;
    }

    var_3cc83b4e56d476a9 = undefined;

    foreach(spawnpoint in spawnpoints) {
      if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy == level.localeid) {
        var_3cc83b4e56d476a9 = spawnpoint;
      }
    }

    if(isDefined(var_3cc83b4e56d476a9)) {
      return var_3cc83b4e56d476a9;
    } else {
      foreach(spawnpoint in spawnpoints) {
        if(!isDefined(spawnpoint.script_noteworthy) || !issubstr(spawnpoint.script_noteworthy, "locale")) {
          validspawnpoints[validspawnpoints.size] = spawnpoint;
          continue;
        }

        spawnpoint delete();
      }
    }
  } else if(spawnpoints.size != 1) {
    foreach(spawnpoint in spawnpoints) {
      if(!isDefined(spawnpoint.script_noteworthy) || !issubstr(spawnpoint.script_noteworthy, "locale")) {
        validspawnpoints[validspawnpoints.size] = spawnpoint;
        continue;
      }

      spawnpoint delete();
    }
  } else {
    validspawnpoints = spawnpoints;
  }

  spawnpoint = scripts\mp\spawnlogic::getspawnpoint_random(validspawnpoints);
  return spawnpoint;
}

function spawnintermission(spawnpoint, sessionstate, everyonehearseveryone) {
  self endon("disconnect");
  self notify("spawned");
  self notify("end_respawn");

  if(!isDefined(sessionstate)) {
    sessionstate = "intermission";
  }

  if(!isDefined(everyonehearseveryone)) {
    everyonehearseveryone = 1;
  }

  setspawnvariables();
  setlowermessageomnvar("clear_lower_msg");
  clearlowermessages();

  if(!getdvarint(@ "hash_8117734e3e0f8be5", 0)) {
    _freezecontrols(1, undefined, "spawnIntermission");
  }

  if(everyonehearseveryone) {
    self setclientdvar(@ "cg_everyonehearseveryone", 1);
  }

  if(isDefined(level.finalkillcam_winner) && level.finalkillcam_winner != "none" && isDefined(level.match_end_delay) && waslastround() && !istrue(level.var_286c2c7b34d03b04)) {
    wait level.match_end_delay;
  }

  if(isDefined(level.spawnintermissiondelayseconds)) {
    wait level.spawnintermissiondelayseconds;
  }

  if(!istrue(level.var_286c2c7b34d03b04)) {
    updatesessionstate(sessionstate);
  }

  clearkillcamstate();
  self.friendlydamage = undefined;

  if(!isDefined(spawnpoint)) {
    if(!isDefined(level.localeid)) {
      spawnpoints = getEntArray("mp_global_intermission", "classname");
      spawnpoints = scripts\mp\spawnscoring::checkdynamicspawns(spawnpoints);
      assertex(spawnpoints.size, "<dev string:x1c2>");

      if(istrue(level.var_8cf13ef4fd814ccd)) {
        spawnpoint = array_random(spawnpoints);
      } else {
        spawnpoint = spawnpoints[0];
      }
    } else {
      spawnpoint = getspectatepoint();
    }
  }

  if(!isDefined(level.custom_ending)) {
    self spawn(spawnpoint.origin, spawnpoint.angles);
    printspawnmessage("playerlogic::spawnIntermission() !!!CODE SPAWN!!! @" + spawnpoint.origin);
    setdof_spectator();
  }

  if(!getdvarint(@ "hash_8117734e3e0f8be5", 0)) {
    _freezecontrols(1, undefined, "spawnIntermission");
  }
}

function spawnendofgame() {
  if(isDefined(level.modespawnendofgame) && self[[level.modespawnendofgame]]()) {
    return;
  }

  if(isDefined(level.custom_ending) && waslastround()) {
    level notify("start_custom_ending");
  }

  if(!istrue(self.controlsfrozen)) {
    _freezecontrols(1, undefined, "spawnEndOfGame");
  }

  if(istrue(level.var_286c2c7b34d03b04)) {
    self notify("spawned");
    clearkillcamstate();
    return;
  }

  spawnspectator();
}

function setspawnvariables() {
  _stopshellshock();
  self stoprumble("damage_heavy");
  self.deathposition = undefined;
}

function function_358a3ae71b7d1935(player) {
  if(!isPlayer(player) || isbot(player)) {
    return undefined;
  }

  weapon_accuracy = 0;
  totalshots = player.pers["shotsFired"];
  totalhits = player.pers["shotsHit"];

  if(isDefined(totalshots) && isDefined(totalhits) && totalshots > 0) {
    weapon_accuracy = float(totalhits / totalshots * 100);
  }

  xp_at_start = 0;

  if(isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].xp_at_start)) {
    xp_at_start = player.pers["telemetry"].xp_at_start;
  }

  xp_at_end = 0;

  if(player rankingenabled() && player hasplayerdata()) {
    xp_at_end = player getplayerdata("common", "mpProgression", "playerLevel", "xp");
  }

  playerstats = spawnStruct();
  playerstats.time_in_match = gettime() - player.connecttime;
  playerstats.kills = player getpersstat("kills");
  playerstats.deaths = player getpersstat("deaths");
  playerstats.headshots = player getpersstat("headshots");
  playerstats.xp_earned = xp_at_end - xp_at_start;
  playerstats.accuracy = weapon_accuracy;
  playerstats.xuid = player getxuid();
  return playerstats;
}

function callback_playerdisconnect(reason) {
  if(!isDefined(self.connected)) {
    return;
  }

  self.disconnecting = 1;
  playerstats = function_358a3ae71b7d1935(self);
  self function_fe84f716b4611373(playerstats);

  if(getdvarint(@ "online_matchdata_enabled") != 0) {
    playercountleft = getmatchdata("commonMatchData", "player_count_left");
    playercountleft++;
    setmatchdata("commonMatchData", "player_count_left", playercountleft);
  }

  result = undefined;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(istrue(self.pers["hasDoneAnyCombat"]) || istrue(self.pers["participation"])) {
      result = "eliminated";
    }

    if(istrue(level.var_455a4e4b5e61f55f) && !isbot(self) && self isinexecutionvictim() && isalive(self)) {
      attacker = self getexecutionpartner();
      var_ba9dc00e6d5896dc = self.health;

      if(scripts\mp\damage::shouldrecorddamagestats(self)) {
        attacker incpersstat("damage", var_ba9dc00e6d5896dc);

        if(!isDefined(attacker.damagethisround)) {
          attacker.damagethisround = var_ba9dc00e6d5896dc;
        } else {
          attacker.damagethisround += var_ba9dc00e6d5896dc;
        }
      } else if(isDefined(level.onattackerdamagenottracked)) {
        attacker[[level.onattackerdamagenottracked]](var_ba9dc00e6d5896dc);
      }

      attacker scripts\mp\gametypes\br_public::updatebrscoreboardstat("damageDealt", attacker.pers["damage"]);
      self kill(self.origin, attacker, attacker, "MOD_EXECUTION");
      self notify("disconnect");
    }
  }

  if(isDefined(level.endgamewinner)) {
    result = level.endgamewinner;
  }

  scripts\mp\utility\disconnect_event_aggregator::function_7104b549684a0447(self);

  if(isDefined(result)) {
    scripts\cp_mp\utility\game_utility::stopkeyearning(result);
  }

  if(iscontrollingproxyagent()) {
    self restorecontrolagent();
  }

  var_5814d27874b48e54 = spawnStruct();
  var_5814d27874b48e54.player = self;
  var_5814d27874b48e54.disconnectreason = reason;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_player_disconnect", var_5814d27874b48e54);
  removeplayerondisconnect();
  scripts\cp_mp\utility\game_utility::removefromparticipantsarray();
  scripts\cp_mp\utility\game_utility::removefromcharactersarray();
  scripts\cp_mp\utility\player_utility::removefromdismembermentlist();
  function_dcd8f0ad9ced02ba(self);
  entnum = self getentitynumber();

  if(!level.teambased) {
    game["roundsWon"][self.guid] = undefined;
  }

  if(level.splitscreen) {
    players = level.players;

    if(players.size <= 1) {
      level thread scripts\mp\gamelogic::forceend();
    }
  }

  if(isDefined(self.kills) && isDefined(self.deaths)) {
    if(getgametype() == "arena" && 3 > self.timeplayed["total"]) {
      if(!isDefined(self.arenadamage)) {
        return;
      }

      damage = self.arenadamage;
      println("<dev string:x1f2>" + damage);
      setplayerteamrank(self, self.clientid, damage);
    } else if(120 < self.timeplayed["total"]) {
      kd = (self.kills - self.deaths) / self.timeplayed["total"] / 60;
      println("<dev string:x1f2>" + self.kills + "<dev string:x1fd>" + self.deaths + "<dev string:x204>" + kd);
      setplayerteamrank(self, self.clientid, kd);
    }
  } else {
    println("<dev string:x20b>");
  }

  lpselfnum = self getentitynumber();
  lpguid = self.guid;
  logprint("Q;" + lpguid + ";" + lpselfnum + ";" + self.name + "\n");

  if(analyticsstreamerislogfilestreamingenabled()) {
    analyticsstreamerlogfilewritetobuffer("Q;" + lpguid + ";" + lpselfnum + ";" + self.name + "\n");
  }

  thread scripts\mp\events::disconnected();

  if(level.gameended) {
    scripts\mp\gamescore::removedisconnectedplayerfromplacement();
  }

  if(isDefined(self.team)) {
    scripts\mp\playerlogic::removefromteamcount();

    if(array_contains(level.teamdata[self.team]["alivePlayers"], self)) {
      scripts\mp\playerlogic::removefromalivecount(1, "disconnect");
      scripts\mp\utility\teams::validatealivecount("disconnect", self.team, self, "Callback_PlayerDisconnect");
    }

    if(isDefined(self.sessionsquadid) && isDefined(self.team) && isDefined(level.squaddata) && isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self.sessionsquadid])) {
      scripts\cp_mp\squads::leavesquad(self.team, self.sessionsquadid);
    }
  }

  scripts\cp_mp\utility\weapon_utility::clearlockedonondisconnect(self);
  level thread[[level.updategameevents]]();
  namespace_bf9ffd2b22c7d819::function_8cf8ff669ac52156(reason);
  scripts\mp\utility\disconnect_event_aggregator::rundisconnectcallbacks(self);
  scripts\mp\gamelogic::updatematchhasmorethan1playeromnvaronplayerdisconnect();
  utility::trycall(level.matchdata_logplayerdata, reason);

  if(!scripts\mp\gamelogic::function_8464fd951b451534(self)) {
    level thread endemptygamewatcher();
  }

  scripts\cp_mp\utility\game_utility::function_b6af940d92701b15(0);
}

function endemptygamewatcher() {
  level notify("endEmptyGameWatcher");
  level endon("endEmptyGameWatcher");
  level endon("connected");
  var_c08c3b91ed82c26d = getdvarfloat(@ "hash_36c64acc6ca5e510", 30);
  wait var_c08c3b91ed82c26d;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && getdvarint(@ "hash_e709033afed344c5", 1) == 1 && istrue(level.br_prematchstarted)) {
    scripts\mp\gamelogic::sendendofmatchdata();
  }

  if(isDefined(level.var_9aa019939f20359)) {
    thread[[level.var_9aa019939f20359]]("none", game["end_reason"]["host_ended_game"]);
    return;
  }

  thread scripts\mp\gamelogic::endgame("none", game["end_reason"]["host_ended_game"]);
}

function removeplayerondisconnect() {
  found = 0;

  for(entry = 0; entry < level.players.size; entry++) {
    if(level.players[entry] == self) {
      found = 1;

      while(entry < level.players.size - 1) {
        level.players[entry] = level.players[entry + 1];
        assert(level.players[entry] != self);
        entry++;
      }

      level.players[entry] = undefined;
      break;
    }
  }

  level.playersbyentitynumber[self getentitynumber()] = undefined;
  assert(found);
}

function initclientdvarssplitscreenspecific() {
  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars(@ "hash_682a9bc40f96ca4a", "0.75");
    setDvar(@ "hash_d18838f3e4b65d16", 0);
    return;
  }

  self setclientdvars(@ "hash_682a9bc40f96ca4a", "1");
}

function initclientdvars() {
  setDvar(@ "cg_drawcrosshair", 1);
  setDvar(@ "cg_drawcrosshairnames", 1);

  if(scripts\cp_mp\utility\game_utility::function_21322da268e71c19()) {
    setDvar(@ "cg_drawcrosshair", 0);
    setDvar(@ "cg_drawcrosshairnames", 1);
  }

  if(isDefined(level.alwaysdrawfriendlynames) && level.alwaysdrawfriendlynames) {
    setDvar(@ "hash_721a6fa1822b17d9", 1);
  } else {
    setDvar(@ "hash_721a6fa1822b17d9", 0);
  }

  self setclientdvars(@ "cg_drawspectatormessages", 1);
  initclientdvarssplitscreenspecific();

  if(getgametypenumlives()) {
    if(level.teambased) {
      self setclientdvars(@ "cg_deadchatwithdead", 0, @ "cg_deadchatwithteam", 1, @ "cg_deadhearteamliving", 1, @ "cg_deadhearallliving", 0);
    } else {
      self setclientdvars(@ "cg_deadchatwithdead", 1, @ "cg_deadchatwithteam", 0, @ "cg_deadhearteamliving", 0, @ "cg_deadhearallliving", 0);
    }
  } else {
    self setclientdvars(@ "cg_deadchatwithdead", 0, @ "cg_deadchatwithteam", 1, @ "cg_deadhearteamliving", 1, @ "cg_deadhearallliving", 0);
  }

  if(level.teambased) {
    self setclientdvars(@ "cg_everyonehearseveryone", 0);
  }

  self setclientdvar(@ "hash_b21f1157c582ff15", 1);
  self setclientdvar(@ "cg_fov", 65);
  self setclientdvar(@ "hash_71c6c0b8428e44a7", 0);

  if(getdvarint(@ "hash_8662c4d785d46fd6")) {
    for(i = 0; i < 6; i++) {
      self setclientdvar(hashcat(@ "hash_3dd1dde9508849d5", string(i)), "");
    }

    self.hitlocinited = 1;
  }
}

function connect_validateplayerteam() {
  if(!isDefined(self)) {
    return;
  }

  forceteam = getDvar(@ "scr_force_team", "");

  if(self.sessionteam == "none" && matchmakinggame() && level.teambased && !isbot(self) && !istestclient(self) && !self iscodcaster() && !scripts\cp_mp\utility\game_utility::isinfectedgametype() && !isgameplayteam(forceteam)) {
    println("<dev string:x235>");
    dlog_recordevent("mp_invalid_team_error", ["player_xuid", self getxuid(), "isHost", self ishost()]);
    wait 1.5;
    kick(self getentitynumber(), "EXE/PLAYERKICKED_INVALIDTEAM");
  }
}

function queueconnectednotify() {
  for(;;) {
    if(!isDefined(level.players_waiting_for_callback)) {
      waitframe();
      continue;
    }

    break;
  }

  for(;;) {
    for(i = 0; i < level.players_waiting_for_callback.size; i++) {
      player = level.players_waiting_for_callback[i];

      if(isDefined(player)) {
        level notify("connected", player);
        player notify("connected_continue");
        level.players_waiting_for_callback[i] = undefined;
        break;
      }
    }

    temparray = array_removeundefined(level.players_waiting_for_callback);
    level.players_waiting_for_callback = temparray;
    waitframe();
  }
}

function onversusdone(channel, splashindex) {
  if(channel != "versus_done") {
    return;
  }

  self.versusdone = 1;
}

function initsegmentstats() {
  level endon("game_ended");
  level thread recordplayersegmentdata();

  while(true) {
    level waittill("connected", player);
    level thread createplayersegmentstats(player);
  }
}

function recordplayersegmentdata() {
  level endon("game_ended");

  if(scripts\cp_mp\utility\game_utility::function_ba5574c7f287c587()) {
    level thread function_6507acd84aa694f8();
  } else {
    gameflagwait("prematch_done");
    wait 4;
  }

  var_f9bd25a96ac21421 = 5;

  while(true) {
    processedplayers = 0;
    wait 1;
    players = level.players;

    foreach(player in players) {
      if(!isDefined(player)) {
        continue;
      }

      if(istrue(player.canrecordsegmentstats)) {
        player thread updateplayersegmentdata();
      }

      processedplayers++;
      processedplayers %= var_f9bd25a96ac21421;

      if(processedplayers == 0) {
        waitframe();
      }
    }
  }
}

function createplayersegmentstats(player) {
  player endon("disconnect");
  player waittill("spawned_player");

  if(!isDefined(player.pers["distanceTotal"])) {
    player.pers["distanceTotal"] = 0;
  }

  if(!isDefined(player.pers["movingTotal"])) {
    player.pers["movingTotal"] = 0;
  }

  if(!isDefined(player.pers["movementUpdateCount"])) {
    player.pers["movementUpdateCount"] = 0;
  }

  player.savedsegmentposition = player.origin;
  player.positionptm = player.origin;
  player.canrecordsegmentstats = 1;
}

function function_81556b07c7a4bf27() {
  self.pers["movementUpdateCount"] = 0;
  self.pers["distanceTotal"] = 0;
  self.pers["movingTotal"] = 0;
  self.savedsegmentposition = undefined;
  self.positionptm = undefined;
}

function function_6507acd84aa694f8() {
  gameflagwait("prematch_done");
  wait 4;

  foreach(player in level.players) {
    if(istrue(player.canrecordsegmentstats)) {
      player function_81556b07c7a4bf27();
    }
  }
}

function updateplayersegmentdata() {
  self endon("disconnect");

  if(!isDefined(self.savedsegmentposition)) {
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
  }

  if(isusingremote()) {
    self waittill("stopped_using_remote");
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
    return;
  }

  scripts\mp\utility\stats::incpersstat("movementUpdateCount", 1);
  scripts\mp\utility\stats::incpersstat("distanceTotal", distance2d(self.savedsegmentposition, self.origin));
  self.savedsegmentposition = self.origin;

  if(scripts\mp\utility\stats::getpersstat("movementUpdateCount") % 5 == 0) {
    distancetraveled = distance2d(self.positionptm, self.origin);
    self.positionptm = self.origin;

    if(distancetraveled > 16) {
      scripts\mp\utility\stats::incpersstat("movingTotal", 1);
    }
  }
}

function shouldshowwidemapshot(normalizedtimepassed) {
  if(istrue(level.var_a6954a050d77d75c) || getdvarint(@ "scr_shoulddisablemapflyin", 1)) {
    return false;
  }

  return !scripts\cp_mp\utility\game_utility::isbrstylegametype() && normalizedtimepassed < level.prematchperiod && !istrue(self.btestclient) && !gameflag("infil_will_run");
}

function function_9fac5c57173a9bb9() {
  self endon("disconnect");
  fadetime = getdvarfloat(@ "hash_e13bff48d7059619", 1);
  wait fadetime;
  self notify("round_based_fade_up");
}

function setuipregamefadeup(waitmsg, messagelistener, keepui) {
  self endon("disconnect");

  if(istrue(keepui)) {
    scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 1, 0);
  } else {
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0);
  }

  if(gameflag("infil_will_run") && !gameflag("prematch_done")) {
    thread function_af273a2e9abf2489(keepui);
  }

  starttime = gettime();

  if(isDefined(messagelistener) && isDefined(waitmsg)) {
    messagelistener waittill(waitmsg);
  }

  scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();
  mintime = getdvarfloat(@ "hash_d91436487f90e63c", 0);

  if(mintime > 0) {
    waited = (gettime() - starttime) / 1000;

    if(waited < mintime) {
      wait mintime - waited;
    }
  }

  fadetime = getdvarfloat(@ "hash_1b65b5ed4995fe92", 0.5);

  if(istrue(keepui)) {
    scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 0, fadetime);
    return;
  }

  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, fadetime);
}

function function_af273a2e9abf2489(keepui) {
  self endon("disconnect");
  level endon("start_scene");
  level waittill("post_game_ui_start");
  spawnpoints = getEntArray("mp_global_intermission", "classname");

  if(spawnpoints.size > 0) {
    intermissionspawn = getclosest(self.origin, spawnpoints);

    if(isDefined(intermissionspawn)) {
      cameraentity = spawn("script_model", intermissionspawn.origin);

      if(isDefined(cameraentity)) {
        cameraentity setModel("tag_origin");
        cameraentity.angles = intermissionspawn.angles;
        cameraentity.data = intermissionspawn;
        self cameralinkTo(cameraentity, "tag_origin", 1, 1);
      } else {
        assertex(isDefined(cameraentity), "<dev string:x263>");
      }
    } else {
      assertex(isDefined(intermissionspawn), "<dev string:x294>");
    }
  } else {
    assertex(spawnpoints.size, "<dev string:x1c2>");
  }

  if(istrue(keepui)) {
    scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 0, 0.5);
    return;
  }

  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.5);
}

function callback_playeractive() {
  self.pers["streamSyncComplete"] = 1;
  self notify("player_active");

  if(isDefined(self.team) && isgameplayteam(self.team)) {
    customization = scripts\mp\teams::getoperatorcustomization();
    body = customization[0];
    head = customization[1];
    self setcustomization(body, head);
  }

  scripts\cp_mp\utility\game_utility::function_b6af940d92701b15(1);
}

function getmaxnumplayerslogging() {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return 30;
  }

  return 200;
}

function function_2724805d492e905d(origin, angles) {
  cament = spawn("script_model", origin);
  cament setModel("tag_origin");
  cament.angles = angles;
  updatesessionstate("spectator");
  self cameralinkTo(cament, "tag_origin");
  waittill_any_2("death_or_disconnect", "spawned_player");
  cament delete();
}

function callback_playerconnect() {
  self.versusdone = 0;
  self.statusicon = "hud_status_connecting";
  self waittill("begin");
  self.statusicon = "";

  if(isai(self) || getdvarint(@ "hash_e244e1b9c23a167c", 0) == 1) {
    callback_playeractive();
  }

  self.connecttime = gettime();
  self clearpredictedstreampos();

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    self clearadditionalstreampos();
  }

  dospawnspectator = 1;

  if(isDefined(level.onplayerconnectstream)) {
    dospawnspectator = self thread[[level.onplayerconnectstream]]();
  }

  thread function_2c0b975a7130601e();

  if(scripts\mp\spawncamera::function_581a8fc6f76d525d() && isDefined(self.sessionteam) && isgameplayteam(self.sessionteam)) {
    scripts\mp\spawncamera::function_cdff2f0b5dcf3aa1();
  }

  if(gameflag("prematch_done") && istrue(level.usespawnselection) && isDefined(self.sessionteam)) {
    if(getgametype() == "risk") {
      spawncam = level.spawncameras["default"]["allies"];
    } else if(self.sessionteam == "allies") {
      spawncam = level.spawncameras["gw_fob_alliesHQ"]["allies"];
      self function_47933f5eb9f65afe(spawncam.origin);
    } else if(self.sessionteam == "axis") {
      spawncam = level.spawncameras["gw_fob_axisHQ"]["axis"];
      self function_47933f5eb9f65afe(spawncam.origin);
    }
  }

  self visionsetfadetoblackforplayer("bw", 0);
  waitmsg = "connected_continue";
  keepui = 0;
  messagelistener = self;
  normalizedtimepassed = gettimepassed() / 1000 + 6;

  if(gameflag("infil_will_run") && !gameflag("infil_started")) {
    waitmsg = "infil_started";
    keepui = 1;
    messagelistener = level;
  }

  if(!isDefined(self.pers["streamSyncComplete"]) && shouldshowwidemapshot(normalizedtimepassed)) {
    var_c2db1b6c79ea1c6c = function_38d8271a5b966538();
    streamorigin = scripts\mp\gametypes\br_public::playerstreamhintlocation(var_c2db1b6c79ea1c6c[0].origin);
    waitmsg = "player_active";
  } else if(getsubgametype() == "dmz" && getdvarint(@ "hash_1ed3f112d3406b97", 1)) {
    if(!istrue(level.var_72e1667d06ab98db) && isDefined(self.origin) && getdvarint(@ "hash_8502b5f6f282d7c1", 1)) {
      if(!istrue(level.infilcompleted)) {
        waitmsg = "dmz_playInfil";
      } else {
        waitmsg = undefined;
      }

      keepui = 1;
    } else if(!isDefined(self.pers["streamSyncComplete"])) {
      waitmsg = "player_active";
      keepui = 1;
    }
  } else if(isroundbased() && game["roundsPlayed"] > 0 && !scripts\cp_mp\utility\game_utility::function_8b6131109e66d962()) {
    waitmsg = "round_based_fade_up";
    keepui = 0;
    thread function_9fac5c57173a9bb9();
  }

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype() || getsubgametype() == "dmz" && istrue(level.var_59ff09549058dda2)) {
    thread setuipregamefadeup(waitmsg, messagelistener, keepui);
  }

  level.players_waiting_for_callback[level.players_waiting_for_callback.size] = self;
  self waittill("connected_continue");
  self.connected = 1;

  if(!isDefined(level.uniqueplayersconnected)) {
    level.uniqueplayersconnected = 1;
  } else {
    level.uniqueplayersconnected++;
  }

  initinputtypewatcher();
  self setclientomnvar("ui_scoreboard_freeze", 0);

  if(self ishost()) {
    level.player = self;
  }

  if(!level.splitscreen && !isDefined(self.pers["score"])) {
    var_973c2033e57c470b = 0;
    var_f56f146953ca91b5 = getmatchrulesdata("commonOption", "startConnectedMsgTime");

    if(var_f56f146953ca91b5 > 0) {
      if(isDefined(level.starttime)) {
        timepassed = (gettime() - level.starttime) / 1000;

        if(timepassed <= var_f56f146953ca91b5) {
          var_973c2033e57c470b = 1;
        }
      } else {
        var_973c2033e57c470b = 1;
      }
    }

    if(var_973c2033e57c470b == 0) {
      iprintln(&"<dev string:x2c0>", self);
    }
  }

  self.usingonlinedataoffline = self isusingonlinedataoffline();
  initclientdvars();
  initplayerstats();
  scripts\mp\accolades::applyaccoladestructtoplayerpers();

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "1") {
    level waittill("eternity");
  }

  self.guid = getuniqueid();
  firstconnect = 0;

  if(!isDefined(self.pers["clientid"])) {
    self.pers["clientid"] = game["clientid"];
    game["clientid"]++;
    maxplayers = getmaxnumplayerslogging();

    if(game["clientid"] >= maxplayers) {
      game["clientid"] = maxplayers - 1;
      self.pers["clientid"] = maxplayers - 1;
    }

    firstconnect = 1;
    self.pers["matchdataWeaponStats"] = [];
    self.pers["matchdataScoreEventCounts"] = [];
    self.pers["xpAtLastDeath"] = 0;
    self.pers["scoreAtLastDeath"] = 0;
    self.pers["weaponStats"] = [];

    if(scripts\mp\utility\game::function_d75b73c443421047() == 0) {
      if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
        var_b9c95d2f33c0d8b = function_ce68631570796a41();

        if(isDefined(var_b9c95d2f33c0d8b)) {
          thread function_408b1b8364d0e722(var_b9c95d2f33c0d8b);
          scripts\cp_mp\playerachievements::getstate(self, var_b9c95d2f33c0d8b);
        }
      }

      var_8ca33da989ab6666 = getdvarint(@ "hash_ed901443dea302d4", 26871);

      if(var_8ca33da989ab6666 > 0) {
        thread function_fd6c077d98fa4be9(var_8ca33da989ab6666);
        scripts\cp_mp\playerachievements::getstate(self, var_8ca33da989ab6666);
      }
    }
  }

  scripts\mp\codcasterclientmatchdata::function_9b229b18b0750bad();

  if(self iscodcaster() && getdvarint(@ "hash_2745598e35a47913") == 1) {
    gamelengthseconds = int(floor(scripts\mp\utility\game::getgamelength() / 1000));
    self setclientomnvar("ui_total_game_time", gamelengthseconds);
  }

  println("<dev string:x2d0>" + self.name + "<dev string:x2df>" + self.pers["<dev string:x2ff>"]);

  if(istrue(level.flashpointactive)) {
    thread scripts\mp\flashpoint::flashpoint_trackplayerevents(self);
  }

  if(firstconnect) {
    scripts\mp\persistence::statsetchildbuffered("round", "timePlayed", 0, 1);
    self setplayerdata("common", "round", "totalXp", 0);
    scripts\cp_mp\utility\game_utility::startkeyearning();

    if(!isDefined(game["uniquePlayerCount"])) {
      game["uniquePlayerCount"] = 1;
    } else {
      game["uniquePlayerCount"]++;
    }
  }

  self.clientid = self.pers["clientid"];
  self.pers["teamKillPunish"] = 0;
  logprint("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");

  if(analyticsstreamerislogfilestreamingenabled()) {
    analyticsstreamerlogfilewritetobuffer("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");
  }

  self logstatmatchguid();

  if(getdvarint(@ "online_matchdata_enabled") != 0) {
    playercount = getmatchdata("commonMatchData", "player_count");

    if(firstconnect) {
      playercount++;
      setmatchdata("commonMatchData", "player_count", playercount);
    }

    if(isbot(self) || istestclient(self) || isai(self)) {
      connectedbot = 1;
    } else {
      connectedbot = 0;
    }

    if(matchmakinggame() && !denysystemicteamchoice() && !connectedbot) {
      println("<dev string:x30b>" + gettime());
      println("<dev string:x322>" + getdvarint(@ "hash_ff213c5a6a5e05e4", 0));
      println("<dev string:x33b>" + istrue(level.multiteambased));
      println("<dev string:x355>" + istrue(level.teambased));
      println("<dev string:x36a>" + self.sessionteam);

      assert(getdvarint(@ "hash_ff213c5a6a5e05e4", 0) == 1 || istrue(level.multiteambased) || istrue(level.teambased) && isgameplayteam(self.sessionteam) || !istrue(level.teambased) && self.sessionteam == "<dev string:x125>" || (scripts\cp_mp\utility\game_utility::isinfectedgametype() || getgametype() == "<dev string:x380>") && self.sessionteam == "<dev string:x125>");
    }
  }

  if(firstconnect) {
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_player_first_connect", self);

    if(function_9f3fd36055d11136(self)) {
      self.pers["streaming"] = 1;
    }
  }

  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_player_connect", self);

  if(level.uniqueplayersconnected <= getmaxnumplayerslogging()) {
    if(firstconnect && isDefined(level.matchrecording_logeventplayername)) {
      [[level.matchrecording_logeventplayername]](self.clientid, self.team, self.name);
    }
  }

  if(firstconnect) {
    namespace_bf9ffd2b22c7d819::function_342af7ea8a120b16();
  }

  if(!level.teambased) {
    game["roundsWon"][self.guid] = 0;
  }

  if(!isDefined(self.pers["cur_kill_streak"])) {
    self.pers["cur_kill_streak"] = 0;
  }

  if(!isDefined(self.pers["cur_death_streak"])) {
    self.pers["cur_death_streak"] = 0;
  }

  if(level.onlinestatsenabled) {
    self.bestlifetimekillstreak = getplayerstat("bestStats", "killStreak");
  }

  self.lastgrenadesuicidetime = -1;
  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.wasaliveatmatchstart = 0;
  self.movespeedscaler = 1;
  self.objectivescaler = 1;
  self.killcountthislife = 0;
  resetuidvarsonconnect();
  self.lifeid = 0;

  if(isDefined(scripts\mp\utility\stats::getpersstat("deaths"))) {
    self.lifeid = scripts\mp\utility\stats::getpersstat("deaths");
  }

  waittillframeend();

  foreach(player in level.players) {
    assert(player != self);
  }

  level.players[level.players.size] = self;
  level.playersbyentitynumber[self getentitynumber()] = self;
  scripts\cp_mp\utility\game_utility::addtoparticipantsarray();
  scripts\cp_mp\utility\game_utility::addtocharactersarray();
  scripts\cp_mp\utility\player_utility::addtodismembermentlist();

  if(game["state"] == "postgame") {
    self.connectedpostgame = 1;
    self setclientdvars(@ "cg_drawspectatormessages", 0);
    self visionsetfadetoblackforplayer("", 0.25);
    spawnintermission();
    return;
  }

  if(firstconnect && (gettimepassed() >= 60000 || game["roundsPlayed"] > 0)) {
    self.joinedinprogress = 1;
  }

  if(getdvarint(@ "hash_a91f736779a57bef")) {
    self.pers["<dev string:x389>"] = "<dev string:x392>";
    self.class = "<dev string:x392>";

    if(self.sessionteam != "<dev string:x396>" && self.sessionteam != "<dev string:x3a3>") {
      self.pers["<dev string:x3b0>"] = self.sessionteam;
    }

    self.team = "<dev string:x3b8>";
  }

  if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["think"])) {
    self thread[[level.bot_funcs["think"]]]();
  }

  level endon("game_ended");

  if(isDefined(level.hostmigrationtimer)) {
    thread scripts\mp\hostmigration::hostmigrationtimerthink();
  }

  if(isDefined(level.onplayerconnectaudioinit)) {
    [[level.onplayerconnectaudioinit]]();
  }

  thread scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_monitorplayerusability(self);
  thread scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_monitorstandingonvehicles(self);
  thread scripts\cp_mp\vehicles\vehicle_interact::function_356ea06606d08642(self);
  scripts\mp\meatshield::function_8f2f9f02b630ed27();
  thread scripts\mp\perks\perkfunctions::markedentities_think();

  if(!isDefined(self.pers["team"])) {
    normalizedtimepassed = gettimepassed() / 1000 + 6;

    if(shouldshowwidemapshot(normalizedtimepassed)) {
      scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();
      spawnspectatormapcam();
      self lerpfovbypreset("default");
      self setclientomnvar("ui_mapshot_camera", 0);
      initclientdvarssplitscreenspecific();
      self.pers["team"] = "";
      self.team = "free";
    } else {
      self visionsetfadetoblackforplayer("", 0.5);
    }

    connect_validateplayerteam();

    if(isPlayer(self) && scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      dlog_recordevent("dlog_event_br_player_connect", ["player_id", self.clientid, "player_name", self.name, "connect_time", int(gettime() / 1000)]);
    }

    if(self iscodcaster()) {
      thread scripts\mp\menus::function_9ff5c7531349cdfc();
    } else if((isintournament() || privatematch()) && (self.sessionteam == "spectator" || self.sessionteam == "codcaster")) {
      self.pers["team"] = self.sessionteam;
      self.team = self.sessionteam;
      thread spawnspectator();
    } else if((matchmakinggame() || lobbyteamselectenabled()) && self.sessionteam != "none") {
      if(dospawnspectator) {
        thread spawnspectator();
      }

      brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

      if((brgametype == "dmz" || brgametype == "exgm" || brgametype == "plunder" || brgametype == "risk") && getdvarint(@ "scr_br_manual_team_assignment", 0) == 1) {
        thread scripts\mp\teams::persistantgametypeteamassign();
      } else {
        thread scripts\mp\menus::setteam(self.sessionteam, firstconnect);
      }

      if(!gameflag("infil_will_run") && getdvarint(@ "hash_7958073a99a0d67e", 1) == 1 && getgametype() == "gwtdm") {
        thread scripts\mp\spawncamera::startspawncamera();
      } else if((getgametype() == "arm" || getgametype() == "conflict") && istrue(level.var_a6954a050d77d75c)) {
        if(isDefined(level.spawnselectionlocations) && isDefined(level.var_6121d66ffc5b8ec9[self.team])) {
          streampos = level.spawnselectionlocations[level.var_6121d66ffc5b8ec9[self.team]][self.team].origin;
          thread scripts\mp\gametypes\br_public::playerstreamhintlocation(streampos, 0, undefined, undefined, -1);
        }
      }

      if(allowclasschoice() || showfakeloadout() && !isai(self)) {
        if(getdvarint(@ "hash_206a763969420ce0", 0) == 1 && scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "dmz" && getsubgametype() != "exgm" && getsubgametype() != "plunder" && getsubgametype() != "risk" && getsubgametype() != "sandbox" && getsubgametype() != "rumble_mgl") {
          classchoicefunc = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
          scripts\mp\utility\script::demoforcesre("Callback_PlayerConnect() elseif MMG " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + classchoicefunc);
        }

        if(!istrue(self.var_10844ddcb34694ee) && getdvarint(@ "hash_89556297eaab6b6a", 0) == 0) {
          self setclientomnvar("ui_options_menu", 2);
        }
      }

      if(!runleanthreadmode() && matchmakinggame() && !getdvarint(@ "hash_9b383028dfd6542d", 0)) {
        thread kickifdontspawn();
      }

      clearpinnedobjectives();
      return;
    } else {
      if(getdvarint(@ "hash_c90bde85e15978ef", 0) == 1 && !istrue(game["<dev string:x3c0>"]) && !matchmakinggame() && !denysystemicteamchoice() && doesmodesupportplayerteamchoice()) {
        scripts\mp\menus::menuspectator();
        scripts\mp\menus::beginteamchoice();
        return;
      }

      if(dospawnspectator) {
        thread spawnspectator();
      }

      scripts\mp\menus::autoassign(firstconnect);

      if(!gameflag("infil_will_run") && getdvarint(@ "hash_7958073a99a0d67e", 1) == 1 && getgametype() == "gwtdm") {
        thread scripts\mp\spawncamera::startspawncamera();
      } else if((getgametype() == "arm" || getgametype() == "conflict") && istrue(level.var_a6954a050d77d75c)) {
        if(isDefined(level.spawnselectionlocations) && isDefined(level.var_6121d66ffc5b8ec9[self.team])) {
          streampos = level.spawnselectionlocations[level.var_6121d66ffc5b8ec9[self.team]][self.team].origin;
          thread scripts\mp\gametypes\br_public::playerstreamhintlocation(streampos, 0, undefined, undefined, -1);
        }
      }

      if(allowclasschoice() || showfakeloadout() && !isai(self)) {
        if(getdvarint(@ "hash_206a763969420ce0", 0) == 1 && scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "dmz" && getsubgametype() != "exgm" && getsubgametype() != "plunder" && getsubgametype() != "risk" && getsubgametype() != "sandbox" && getsubgametype() != "rumble_mgl") {
          classchoicefunc = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
          scripts\mp\utility\script::demoforcesre("Callback_PlayerConnect() else " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + classchoicefunc);
        }

        if(!istrue(self.var_10844ddcb34694ee) && getdvarint(@ "hash_89556297eaab6b6a", 0) == 0) {
          self setclientomnvar("ui_options_menu", 2);
        }
      }

      if(!runleanthreadmode() && matchmakinggame()) {
        thread kickifdontspawn();
      }

      clearpinnedobjectives();
      return;
    }
  } else {
    self visionsetfadetoblackforplayer("", 0.5);
    connect_validateplayerteam();
    playerteam = self.pers["team"];

    if(matchmakinggame() && !isbot(self) && !istestclient(self) && !self iscodcaster() && getdvarint(@ "hash_fc92f4512d812fec")) {
      playerteam = self.sessionteam;
    }

    var_aa4c1ed9107c16e0 = 0;

    if(scripts\cp_mp\utility\game_utility::function_8b6131109e66d962() && istrue(self.pers["secondHalfInitialConnect"])) {
      self.pers["secondHalfInitialConnect"] = 0;
      playerteam = getotherteam(playerteam)[0];
      setDvar(@ "online_allowteamchange", 1);
      var_aa4c1ed9107c16e0 = 1;
    }

    scripts\mp\menus::addtoteam(playerteam, 1);
    thread scripts\cp_mp\squads::setsquad(playerteam);

    if(var_aa4c1ed9107c16e0) {
      setDvar(@ "online_allowteamchange", 0);
    }

    if(self iscodcaster()) {
      thread spawnspectator();
      clearpinnedobjectives();
      return;
    }

    if(scripts\mp\class::isvalidclass(self.pers["class"]) && playerteam != "spectator") {
      thread spawnclient();
      clearpinnedobjectives();
      return;
    }

    thread spawnspectator();

    if(self.pers["team"] == "spectator") {
      if(doesmodesupportplayerteamchoice() && !istrue(self.pers["playerChoseSpectatorTeam"])) {
        scripts\mp\menus::beginteamchoice();
      }
    } else {
      scripts\mp\menus::beginclasschoice();
    }
  }

  clearpinnedobjectives();
}

function function_2c0b975a7130601e() {
  projectname = function_3cb5da19764baa3();

  if(projectname == "JUP") {
    if(isDefined(self)) {
      self setsoundsubmix("jup_global_ingame", 0.05);

      if(getsubgametype() != "ob") {
        self setsoundsubmix("jup_global_mp", 0.05);
        thread function_8eed5edfb3ce6f1a();
      }

      if(!isDefined(getmapname()) || getmapname() == "mp_jup_bigmap" || islargemap()) {
        return;
      }
    }
  }

  if(projectname == "WZ2") {
    if(isDefined(self)) {
      self setsoundsubmix("jup_global_ingame", 0.05);

      if(getsubgametype() != "ob") {
        self setsoundsubmix("jup_global_wz", 0.05);
      }

      if(!isDefined(getmapname()) || getmapname() == "mp_jup_bigmap" || islargemap()) {
        return;
      }
    }
  }
}

function function_8eed5edfb3ce6f1a() {
  if(istrue(level.snowballfight)) {
    self setsoundsubmix("jup_mp_snowball", 0.05);

    if(level.mapname == "mp_jup_highrise_xmas" || level.mapname == "mp_jup_shipment_xmas") {
      self setsoundsubmix("jup_mp_xmas_music", 0.05);
      level waittill("prematch_over");
      self clearsoundsubmix("jup_mp_xmas_music", 5);
    }

    return;
  }

  if(getdvarint(@ "hash_57efffe601711595", 0)) {
    self setsoundsubmix("jup_global_mp_zombie", 0.05);
    self setsoundsubmix("jup_global_mp_mimic", 0.05);
  }

  if(isjuggermoshgamemode()) {
    self setsoundsubmix("jup_global_mp_juggermosh", 0.05);
  }

  if(level.mapname == "mp_jup_skydiving") {
    self setsoundsubmix("jup_global_mp_zombie", 0.05);
    self setsoundsubmix("mp_jup_skydiving_global", 0.05);
  }
}

function callback_playermigrated() {
  println("<dev string:x3d1>" + self.name + "<dev string:x3dc>" + gettime());

  if(isDefined(self.connected) && self.connected) {
    updateobjectivetext();
  }

  if(self ishost()) {
    initclientdvarssplitscreenspecific();
  }

  humanplayercount = 0;

  foreach(player in level.players) {
    if(!isbot(player) && !istestclient(player)) {
      humanplayercount++;
    }
  }

  if(!isbot(self) && !istestclient(self)) {
    level.hostmigrationreturnedplayercount++;

    if(level.hostmigrationreturnedplayercount >= humanplayercount * 2 / 3) {
      println("<dev string:x3fc>");
      level notify("hostmigration_enoughplayers");
    }
  }
}

function function_556228e50ff920d9() {
  println("<dev string:x42c>" + self.guid + "<dev string:x45e>" + self getentitynumber() + "<dev string:x45e>" + self.name + "<dev string:x463>");
  thread namespace_bf9ffd2b22c7d819::function_59121677f31f75a5();
}

function function_5c9544ef10cb9e0c(reason) {
  if(!isDefined(self.connected)) {
    return;
  }

  println("<dev string:x468>" + self.guid + "<dev string:x45e>" + self getentitynumber() + "<dev string:x45e>" + self.name + "<dev string:x45e>" + reason + "<dev string:x463>");
  namespace_bf9ffd2b22c7d819::function_8cf8ff669ac52156(reason, 1);
  scripts\mp\utility\disconnect_event_aggregator::function_fab0966a8fb0e314(self);
  scripts\cp_mp\utility\game_utility::function_b6af940d92701b15(0);
}

function function_2a643088582c8be3(achievementid, progressdata) {
  namespace_bf9ffd2b22c7d819::function_a1b2dc3090437789(achievementid, progressdata);
  scripts\mp\gametypes\common::function_59a736fffddc7c05(achievementid, progressdata);
  namespace_8885c19c053dcb46::function_4b12e9b5e37d05c2(achievementid, progressdata);
  utility::function_f3bb4f4911a1beb2("game", "mutationModeAchievementStateFetched", achievementid, progressdata);
  utility::function_f3bb4f4911a1beb2("game", "turtleAchievementStateFetched", achievementid, progressdata);
  utility::function_f3bb4f4911a1beb2("game", "trickrtreatAchievementStateFetched", achievementid, progressdata);
}

function addlevelstoexperience(experience, levels) {
  rank = getrankforxp(experience);
  minxp = getrankinfominxp(rank);
  maxxp = getrankinfomaxxp(rank);
  rank += (experience - minxp) / (maxxp - minxp);
  rank += levels;

  if(rank < 0) {
    rank = 0;
    var_a176dcda08e09243 = 0;
  } else if(rank >= level.maxrank + 1) {
    rank = level.maxrank;
    var_a176dcda08e09243 = 1;
  } else {
    var_a176dcda08e09243 = rank - floor(rank);
    rank = int(floor(rank));
  }

  minxp = getrankinfominxp(rank);
  maxxp = getrankinfomaxxp(rank);
  return int(var_a176dcda08e09243 * (maxxp - minxp)) + minxp;
}

function forcespawn() {
  self endon("death_or_disconnect");
  self endon("spawned");
  wait 60;

  if(self.hasspawned) {
    return;
  }

  if(self.pers["team"] == "spectator" || self.pers["team"] == "codcaster") {
    return;
  }

  if(!scripts\mp\class::isvalidclass(self.pers["class"])) {
    self.pers["class"] = "CLASS/CUSTOM1";
    self.class = self.pers["class"];
  }

  thread spawnclient();
}

function kickifdontspawn() {
  if(getdvarint(@ "debug_stopafkcheck", 0) == 1) {
    return;
  }

  if(istrue(self.spawnedasspectator) && !mayspawn()) {
    return;
  }

  self endon("death_or_disconnect");
  self endon("spawned");
  self endon("attempted_spawn");
  wait_time = getdvarfloat(@ "scr_kick_time", 90);
  min_time = getdvarfloat(@ "scr_kick_mintime", 45);
  var_6392bb56f874343f = getdvarfloat(@ "hash_ebb6b541d00c0665", 120);
  starttime = gettime();

  if(self ishost()) {
    kickwait(var_6392bb56f874343f);
  } else {
    kickwait(wait_time);
  }

  timepassed = (gettime() - starttime) / 1000;

  if(timepassed < wait_time - 0.1 && timepassed < min_time) {
    return;
  }

  if(self.hasspawned) {
    return;
  }

  if(self.pers["team"] == "spectator" || self.pers["team"] == "codcaster") {
    return;
  }

  kick(self getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
  level thread[[level.updategameevents]]();
}

function kickwait(waittime) {
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

function monitorvotekick() {
  level endon("game_ended");
  self endon("disconnect");
  self.votestokick = 0;

  while(self.votestokick < 2) {
    self waittill("voteToKick");
    self.votestokick++;
  }

  kick(self getentitynumber(), "EXE/PLAYERKICKED_TEAMKILLS");
}

function fakevote() {
  wait 1;
  self notify("voteToKick");
  wait 3;
  self notify("voteToKick");
  wait 2;
  self notify("voteToKick");
}

function function_147b2c2604c54839() {
  if(getdvarint(@ "hash_62aef0bf73b3a0f", 0) == 0) {
    return 2;
  }

  idealnexttime = gettime() + 2000;

  if(level.var_7a2f24cb7a276bc4 < idealnexttime) {
    level.var_7a2f24cb7a276bc4 = idealnexttime;
  }

  timeout = (level.var_7a2f24cb7a276bc4 - gettime()) * 0.001;
  level.var_7a2f24cb7a276bc4 += level.frameduration;
  return timeout;
}

function totaldisttracking(spawnorigin) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");
  self endon("br_begin_respawn");
  self notify("distFromSpawnTracking");
  self endon("distFromSpawnTracking");
  lastposition = spawnorigin;

  if(!isDefined(level.var_808e471a357552a4)) {
    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      level.var_808e471a357552a4 = getdvarint(@ "hash_a1f0eac17092b910", 240);
    } else {
      level.var_808e471a357552a4 = getdvarint(@ "hash_35effe41515eb6d1", 120);
    }
  }

  if(!isDefined(level.var_4c3ab9ef59de46c9)) {
    level.var_4c3ab9ef59de46c9 = getdvarfloat(@ "hash_dbca7dad12fdb6df", 100);
  }

  if(!isDefined(level.var_bc1acb66e7fa31be)) {
    level.var_bc1acb66e7fa31be = getdvarint(@ "hash_25b5baf9db6af062", 3000);
  }

  if(!gameflag("prematch_done")) {
    gameflagwait("prematch_done");
    lastposition = self.origin;
  }

  wasdriver = 0;
  isdriver = 0;
  var_f76842485babee15 = 300;

  if(getgametype() == "arena" || scripts\cp_mp\utility\game_utility::isinfectedgametype()) {
    var_f76842485babee15 = 50;
  } else if(level.var_ec2fb549b15ad827) {
    var_f76842485babee15 = 50;
  }

  if(!isDefined(level.var_7a2f24cb7a276bc4)) {
    level.var_7a2f24cb7a276bc4 = gettime() + 2000;
  }

  while(true) {
    timeout = function_147b2c2604c54839();
    message = waittill_any_timeout_5(timeout, "death", "vehicle_enter", "vehicle_change_seat", "vehicle_exit", "afk_tracking_resume");

    if(isDefined(level.var_6fbd98e2b09d3c26)) {
      throttle::function_f632348cbb773537(level.var_6fbd98e2b09d3c26, self);
    }

    if(message == "vehicle_exit" && !isDefined(self.lastvehicleseatchangetime)) {
      continue;
    }

    if(istrue(self.ignoreafkcheck) || istrue(self.var_cbece90c5beea82)) {
      continue;
    }

    if(message == "afk_tracking_resume") {
      lastposition = self.origin;
      continue;
    }

    initpersstat("totalDistTraveled");
    initpersstat("totalDistTraveledAFK");

    if(!isDefined(lastposition)) {
      lastposition = self.origin;
    }

    dist = distance(lastposition, self.origin);

    if(isDefined(level.var_4c3ab9ef59de46c9) && level.var_4c3ab9ef59de46c9 > 0) {
      if(dist < level.var_4c3ab9ef59de46c9) {
        dist = 0;
      }
    }

    incpersstat("totalDistTraveled", dist);
    incpersstat("totalDistTraveledAFK", dist);

    if(isDefined(scripts\mp\utility\stats::getpersstat("distanceTraveledInVehicle")) && (message == "vehicle_exit" || isDefined(self.vehicle))) {
      incpersstat("distanceTraveledInVehicle", dist);
    }

    if(message == "vehicle_enter") {
      isdriver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);
      self.lastvehicleseatchangetime = gettime();
    }

    if(message == "vehicle_change_seat") {
      isdriver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);
    }

    if(wasdriver != isdriver || message == "vehicle_exit") {
      if(isDefined(self.lastvehicleseatchangetime)) {
        starttime = self.lastvehicleseatchangetime;
        time = (gettime() - starttime) / 1000;

        if(wasdriver) {
          if(isDefined(scripts\mp\utility\stats::getpersstat("timeSpentAsDriver"))) {
            incpersstat("timeSpentAsDriver", time);
          }
        } else if(isDefined(scripts\mp\utility\stats::getpersstat("timeSpentAsPassenger"))) {
          incpersstat("timeSpentAsPassenger", time);
        }
      }
    }

    if(message == "vehicle_enter" || message == "vehicle_change_seat") {
      wasdriver = isdriver;
    }

    if(message == "vehicle_change_seat") {
      self.lastvehicleseatchangetime = gettime();
    }

    lastposition = self.origin;

    if(scripts\mp\utility\stats::getpersstat("totalDistTraveledAFK") > var_f76842485babee15) {
      playerhasmoved();
    } else if(dist > 0) {
      self.var_3681793bfd7b68e = gettime() + level.var_bc1acb66e7fa31be;
    }

    if(istrue(scripts\mp\utility\stats::getpersstat("distTrackingPassedOrResetTime")) && function_48c5a587383a90e7()) {
      var_a0b3c6b277c1a146 = scripts\mp\teams::function_19300abfbb10928b();

      if(var_a0b3c6b277c1a146 - scripts\mp\utility\stats::getpersstat("distTrackingPassedOrResetTime") > level.var_808e471a357552a4) {
        self.pers["distTrackingPassed"] = 0;
        self.pers["totalDistTraveledAFK"] = 0;
        self.var_cb9581fc7ff5f394 = undefined;
      }
    }

    incpersstat("averageAltitude", self.origin[2]);
    incpersstat("averageAltitudeCount", 1);
  }
}

function playerhasmoved() {
  self.pers["distTrackingPassed"] = 1;
  self.pers["totalDistTraveledAFK"] = 0;
  self.pers["distTrackingPassedOrResetTime"] = scripts\mp\teams::function_19300abfbb10928b();
  self.var_3681793bfd7b68e = undefined;
}

function initleanplayerstats() {
  if(!isDefined(self.pers["deaths"])) {
    initpersstat("deaths");
    scripts\mp\persistence::statsetchild("round", "deaths", 0);
  }

  self.deaths = getpersstat("deaths");
  initleaderboardstat("deaths");

  if(!isDefined(self.pers["score"])) {
    initpersstat("score");
    scripts\mp\persistence::statsetchild("round", "score", 0);
  }

  self.score = getpersstat("score");
  initleaderboardstat("score");

  if(!isDefined(self.pers["kills"])) {
    initpersstat("kills");
    scripts\mp\persistence::statsetchild("round", "kills", 0);
  }

  self.kills = getpersstat("kills");
  initleaderboardstat("kills");
}

function initplayerstats() {
  scripts\mp\playerstats::initplayer();
  scripts\mp\persistence::initbufferedstats();

  if(!isDefined(self.leaderboarddata)) {
    self.leaderboarddata = [];
  }

  initleanplayerstats();
  initpersstat("suicides");
  initleaderboardstat("suicides");
  initpersstat("headshots");
  initleaderboardstat("headshots");
  initpersstat("executions");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("assists"))) {
    initpersstat("assists");
    scripts\mp\persistence::statsetchild("round", "assists", 0);
  }

  self.assists = getpersstat("assists");
  initleaderboardstat("assists");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("captures"))) {
    initpersstat("captures");
    scripts\mp\persistence::statsetchild("round", "captures", 0);
  }

  initleaderboardstat("captures", &scripts\cp_mp\challenges::function_4fb61d33f02e8203);

  if(!isDefined(scripts\mp\utility\stats::getpersstat("returns"))) {
    initpersstat("returns");
    scripts\mp\persistence::statsetchild("round", "returns", 0);
  }

  initleaderboardstat("returns");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("defends"))) {
    initpersstat("defends");
    scripts\mp\persistence::statsetchild("round", "defends", 0);
  }

  initleaderboardstat("defends");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("plants"))) {
    initpersstat("plants");
    scripts\mp\persistence::statsetchild("round", "plants", 0);
  }

  initleaderboardstat("plants");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("defuses"))) {
    initpersstat("defuses");
    scripts\mp\persistence::statsetchild("round", "defuses", 0);
  }

  initleaderboardstat("defuses");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("destructions"))) {
    initpersstat("destructions");
    scripts\mp\persistence::statsetchild("round", "destructions", 0);
  }

  initleaderboardstat("destructions");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("confirmed"))) {
    initpersstat("confirmed");
    scripts\mp\persistence::statsetchild("round", "confirmed", 0);
  }

  initleaderboardstat("confirmed", &scripts\cp_mp\challenges::function_58e830149fcb9a1e);

  if(!isDefined(scripts\mp\utility\stats::getpersstat("denied"))) {
    initpersstat("denied");
    scripts\mp\persistence::statsetchild("round", "denied", 0);
  }

  initleaderboardstat("denied", &scripts\cp_mp\challenges::function_4cb78ed013587e76);

  if(!isDefined(scripts\mp\utility\stats::getpersstat("rescues"))) {
    initpersstat("rescues");
    scripts\mp\persistence::statsetchild("round", "rescues", 0);
  }

  initleaderboardstat("rescues");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("touchdowns"))) {
    initpersstat("touchdowns");
    scripts\mp\persistence::statsetchild("round", "touchdowns", 0);
  }

  initleaderboardstat("touchdowns");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("fieldgoals"))) {
    initpersstat("fieldgoals");
    scripts\mp\persistence::statsetchild("round", "fieldgoals", 0);
  }

  initleaderboardstat("fieldgoals");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("killChains"))) {
    initpersstat("killChains");
    scripts\mp\persistence::statsetchild("round", "killChains", 0);
  }

  initleaderboardstat("killChains");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("killsAsSurvivor"))) {
    initpersstat("killsAsSurvivor");
    scripts\mp\persistence::statsetchild("round", "killsAsSurvivor", 0);
  }

  initleaderboardstat("killsAsSurvivor");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("killsAsInfected"))) {
    initpersstat("killsAsInfected");
    scripts\mp\persistence::statsetchild("round", "killsAsInfected", 0);
  }

  initleaderboardstat("killsAsInfected");
  initpersstat("teamkills");
  initleaderboardstat("teamkills");
  initpersstat("teamdamage");
  initpersstat("extrascore0");
  initleaderboardstat("extrascore0");
  initpersstat("extrascore1");
  initleaderboardstat("extrascore1");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("stabs"))) {
    initpersstat("stabs");
    scripts\mp\persistence::statsetchild("round", "stabs", 0);
  }

  initleaderboardstat("stabs");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("setbacks"))) {
    initpersstat("setbacks");
    scripts\mp\persistence::statsetchild("round", "setbacks", 0);
  }

  initleaderboardstat("setbacks");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("objTime"))) {
    initpersstat("objTime");
    scripts\mp\persistence::statsetchild("round", "objTime", 0);
  }

  initleaderboardstat("objTime");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("gamemodeScore"))) {
    initpersstat("gamemodeScore");
    scripts\mp\persistence::statsetchild("round", "gamemodeScore", 0);
  }

  initleaderboardstat("gamemodeScore");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("damage"))) {
    initpersstat("damage");
    scripts\mp\persistence::statsetchild("round", "damage", 0);
  }

  initleaderboardstat("damage", &scripts\cp_mp\challenges::function_73317c391c8e6d10);
  initpersstat("supersEarned");
  initleaderboardstat("supersEarned");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("downs"))) {
    initpersstat("downs");
    scripts\mp\persistence::statsetchild("round", "downs", 0);
  }

  initleaderboardstat("downs");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("contracts"))) {
    initpersstat("contracts");
    scripts\mp\persistence::statsetchild("round", "contracts", 0);
  }

  initleaderboardstat("contracts");
  initpersstat("wins");
  initleaderboardstat("wins");
  initpersstat("topFive");
  initleaderboardstat("topFive");
  initpersstat("topTen");
  initleaderboardstat("topTen");
  initpersstat("topTwentyFive");
  initleaderboardstat("topTwentyFive");
  initpersstat("gamesPlayed");
  initleaderboardstat("gamesPlayed");
  initpersstat("cash");
  initleaderboardstat("cash");
  initpersstat("eliteStarted");
  initleaderboardstat("eliteStarted");
  initpersstat("eliteCompleted");
  initleaderboardstat("eliteCompleted");
  initpersstat("eliteBlocked");
  initleaderboardstat("eliteBlocked");
  initpersstat("secondaryVictories");
  initleaderboardstat("secondaryVictories");
  initpersstat("weaponCaseExfils");
  initleaderboardstat("weaponCaseExfils");
  initpersstat("weaponCaseWins");
  initleaderboardstat("weaponCaseWins");
  initpersstat("contribution");
  initleaderboardstat("contribution");
  initpersstat("goals");
  initleaderboardstat("goals");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("segmentCaptures"))) {
    initpersstat("segmentCaptures");
    scripts\mp\persistence::statsetchild("round", "segmentCaptures", 0);
  }

  initleaderboardstat("segmentCaptures");
  initpersstat("highestMultikill");
  initpersstat("untradedDeaths");
  initpersstat("tradedKills");
  initpersstat("tradedDeaths");
  initpersstat("wallbangs");
  initpersstat("hvtKills");
  initleaderboardstat("hvtKills");
  initpersstat("zombieDeaths");

  if(!isDefined(scripts\mp\utility\stats::getpersstat("teamKillPunish"))) {
    self.pers["teamKillPunish"] = 0;
  }

  initpersstat("longestStreak");
  initleaderboardstat("longestStreak");

  if(scripts\mp\gametypes\war::function_2898a9c3d425a919()) {
    initpersstat("slams");
  }

  self.pers["lives"] = getgametypenumlives();
  scripts\mp\persistence::statsetchild("round", "killStreak", 0);
  scripts\mp\persistence::statsetchild("round", "loss", 0);
  scripts\mp\persistence::statsetchild("round", "win", 0);
  scripts\mp\persistence::statsetchild("round", "scoreboardType", "none");
  initleaderboardstat("killStreak");
  initleaderboardstat("loss");
  initleaderboardstat("win");
}

function addtoteamcount(addlives) {
  assert(isPlayer(self));
  assert(isDefined(self.team));
  assert(isDefined(self.pers["<dev string:x3b0>"]));
  assert(self.team == self.pers["<dev string:x3b0>"]);
  thread addplayertoteam(self, self.team, addlives);
  [[level.updategameevents]]();
}

function removefromteamcount() {
  assert(isPlayer(self));
  assert(isDefined(self.team));
  assert(isDefined(self.pers["<dev string:x3b0>"]));
  assert(self.team == self.pers["<dev string:x3b0>"]);
  removeplayerfromteam(self, self.team);
}

function addtoalivecount(context) {
  assert(isPlayer(self));
  var_da533fd7eba790e5 = self.team;

  if(!(isDefined(self.alreadyaddedtoalivecount) && self.alreadyaddedtoalivecount)) {
    modifyteamdata(var_da533fd7eba790e5, "hasSpawned", 1);
    incrementalivecount(var_da533fd7eba790e5, undefined, context);
  }

  self.alreadyaddedtoalivecount = undefined;
  alivecounttotal = 0;

  foreach(entry in level.teamnamelist) {
    alivecounttotal += getteamdata(entry, "aliveCount");
  }

  if(alivecounttotal > level.maxplayercount) {
    level.maxplayercount = alivecounttotal;
  }
}

function incrementalivecount(var_da533fd7eba790e5, var_28335de6505d7e0c, context) {
  addtoteamlives(self, var_da533fd7eba790e5, var_28335de6505d7e0c, context);
  [[level.updategameevents]]();
}

function removefromalivecount(disconnected, context) {
  assert(isPlayer(self));
  lives = scripts\mp\utility\stats::getpersstat("lives");
  var_28335de6505d7e0c = getgametypenumlives() != 0 && lives == 0 && !istrue(level.skipplaybodycountsound) && !istrue(self.skipplaybodycountsound);
  self notify("remove_from_alive_count");
  var_f559615fec1d7733 = self.team;

  if(isDefined(self.switching_teams) && self.switching_teams && isDefined(self.joining_team) && self.joining_team == self.team) {
    var_f559615fec1d7733 = self.leaving_team;
  }

  if(isDefined(disconnected) && getbasegametype() != "control") {
    scripts\mp\playerlogic::removeallfromlivescount();
  } else if(isDefined(self.switching_teams)) {
    if(!level.ingraceperiod || self.hasdonecombat) {
      modifyteamdata(var_f559615fec1d7733, "hasSpawned", -1);

      if(lives && getbasegametype() != "control") {
        self.pers["lives"]--;
      }
    }
  }

  decrementalivecount(var_f559615fec1d7733, var_28335de6505d7e0c, context);
}

function decrementalivecount(var_f559615fec1d7733, var_28335de6505d7e0c, context) {
  removefromteamlives(self, var_f559615fec1d7733, var_28335de6505d7e0c, context);
  [[level.updategameevents]]();
}

function addtolivescount() {
  assert(isPlayer(self));
  modifyteamdata(self.team, "livesCount", scripts\mp\utility\stats::getpersstat("lives"));
}

function removefromlivescount() {
  assert(isPlayer(self));
  setteamdata(self.team, "livesCount", int(max(0, getteamdata(self.team, "livesCount") - 1)));
}

function removeallfromlivescount() {
  assert(isPlayer(self));
  setteamdata(self.team, "livesCount", int(max(0, getteamdata(self.team, "livesCount") - scripts\mp\utility\stats::getpersstat("lives"))));
}

function resetuiomnvarscommon() {
  if(isDefined(level.resetuiomnvargamemode)) {
    [[level.resetuiomnvargamemode]]();
  }

  self setclientomnvar("ui_objective_pinned_text_param", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_reviver_id", -1);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_edge_glow", 0);
  self setclientomnvar("ui_life_kill_count", 0);
}

function resetuidvarsonconnect() {
  resetuiomnvarscommon();
  self setclientdvar(@ "hash_37165bc532972906", 0);
  scripts\mp\hud_message::function_f004ef4606b9efdc("hide_match_hint");
  self setclientomnvar("post_game_state", 0);

  if(gameflag("prematch_done")) {
    self setclientomnvar("ui_match_in_progress", 1);
    return;
  }

  self setclientomnvar("ui_match_in_progress", 0);
}

function resetuidvarsonspectate() {
  resetuiomnvarscommon();
  self setclientdvar(@ "hash_37165bc532972906", 0);
}

function clearpinnedobjectives() {
  if(isbot(self)) {
    return;
  }

  if(isDefined(level.objectives)) {
    foreach(objective in level.objectives) {
      if(isDefined(objective.objidnum)) {
        scripts\mp\objidpoolmanager::objective_unpin_player(objective.objidnum, self, objective.showoncompass);
      }
    }
  }

  if(isDefined(level.uncapturableobjectives)) {
    foreach(objective in level.uncapturableobjectives) {
      if(isDefined(objective.objidnum)) {
        scripts\mp\objidpoolmanager::objective_unpin_player(objective.objidnum, self, objective.showoncompass);
      }
    }
  }
}

function watchtargethealth() {
  self endon("death_or_disconnect");
  self.targethealthinfo = [];

  while(true) {
    tracestart = (self.origin[0], self.origin[1], self.origin[2] + 64);
    playerangles = self getplayerangles();
    playerlookdir = anglesToForward(playerangles);
    traceend = tracestart + playerlookdir * 10000;
    results = scripts\engine\trace::_bullet_trace(tracestart, traceend, 1, self, 0, 0, 0, 0, 0);
    hitentity = results["entity"];

    if(isDefined(hitentity) && isPlayer(hitentity) && hitentity.team != self.team) {
      if(isDefined(hitentity)) {
        updatetargethealthvariable("ui_target_health", hitentity.health);
      }

      if(isDefined(hitentity)) {
        updatetargethealthvariable("ui_target_max_health", hitentity.maxhealth);
      }

      if(isDefined(hitentity)) {
        updatetargethealthvariable("ui_target_entity_num", hitentity getentitynumber());
      }
    } else {
      updatetargethealthvariable("ui_target_entity_num", -1);
    }

    wait 0.1;
  }
}

function updatetargethealthvariable(var_e9d476a3809cb3f1, value) {
  waitframe();

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(value)) {
    return;
  }

  if(!isDefined(self.targethealthinfo[var_e9d476a3809cb3f1]) || value != self.targethealthinfo[var_e9d476a3809cb3f1]) {
    self setclientomnvar(var_e9d476a3809cb3f1, value);
    self.targethealthinfo[var_e9d476a3809cb3f1] = value;
  }
}

function showgamemodeobjectivetext() {
  if(self.hasspawned) {
    return;
  }

  if(!showmatchhint()) {
    return;
  }

  if(gameflag("prematch_done")) {
    return;
  }

  gameflagwait("prematch_done");
  self endon("disconnect");
  wait 1;

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.pers["team"])) {
    return;
  }

  player_team = self.pers["team"];
  hintmessage = getobjectivehinttext(player_team);

  if(isDefined(hintmessage)) {
    idx = 0;

    if(game["defenders"] == player_team) {
      idx = 1;
    }

    self setclientomnvar("ui_objective_text", idx);
    wait 6;
    self setclientomnvar("ui_objective_text", -1);
  }
}

function function_155c4aaa1dae57e6() {
  gameflagwait("prematch_done");
  scripts\common\damage_effects::onexitdeathsdoor(0);
}

function function_ebd3a9ccfbeb79c3() {
  self endon("disconnect");
  level endon("game_ended");
  gameflagwait("prematch_fade_done");

  if(scripts\mp\outofbounds::isoob(self)) {
    self.var_f9b51be13b8defc = 1;
  }
}

function showmatchhint() {
  gametype = getgametype();

  switch (gametype) {
    case #"hash_5ff8e011d5b9d1c8":
      if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] > 0) {
        return false;
      }

      break;
    default:
      break;
  }

  return true;
}

function trydisableminimap() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && istrue(game["inLiveLobby"])) {
    return;
  }

  if(alwaysshowminimap()) {
    return;
  }

  if(!istrue(self.showuavminimaponspawn) && !scripts\mp\utility\perk::_hasperk("specialty_always_minimap")) {
    hideminimap(1);
  }

  self.showuavminimaponspawn = 0;

  level.var_3246cb2506b3080b = 0;
}

function initinputtypewatcher() {
  self.gamepadwasenabled = is_player_gamepad_enabled();
}

function managerespawnfade(var_ad4dd16f29e24b77, var_dfab0807d83a77fe) {
  self endon("disconnect");

  if(istrue(self.respawnfade)) {
    return;
  }

  self.respawnfade = 1;
  self notify("fadeDown_start");

  if(!isDefined(var_ad4dd16f29e24b77)) {
    var_ad4dd16f29e24b77 = 0;
  }

  fadeduration = var_ad4dd16f29e24b77;

  if(fadeduration > 0) {
    var_c8d49bba66d8db34 = 0;
    framecount = fadeduration / level.framedurationseconds;
    var_11b42fd8a12916ad = 1 / framecount;
    currentframe = 0;

    while(currentframe < framecount) {
      currentframe++;
      var_c8d49bba66d8db34 += var_11b42fd8a12916ad;
      var_c8d49bba66d8db34 = clamp(var_c8d49bba66d8db34, 0, 1);
      self setclientomnvar("ui_world_fade", var_c8d49bba66d8db34);
      waitframe();
    }
  } else {
    self setclientomnvar("ui_world_fade", 1);
  }

  self notify("fadeDown_complete");
  restorehud = 0;

  if(!isreallyalive(self)) {
    self waittill("spawned_player");
    restorehud = 1;
  }

  gameflagwait("prematch_done");

  if(restorehud) {
    utility::hidehudenable();
  }

  wait 2;
  self notify("fadeUp_start");

  if(!isDefined(var_dfab0807d83a77fe)) {
    var_dfab0807d83a77fe = 0;
  }

  fadeduration = var_dfab0807d83a77fe;

  if(fadeduration > 0) {
    var_c8d49bba66d8db34 = 1;
    framecount = fadeduration / level.framedurationseconds;
    var_11b42fd8a12916ad = 1 / framecount;
    currentframe = 0;

    while(currentframe < framecount) {
      currentframe++;
      var_c8d49bba66d8db34 -= var_11b42fd8a12916ad;
      var_c8d49bba66d8db34 = clamp(var_c8d49bba66d8db34, 0, 1);
      self setclientomnvar("ui_world_fade", var_c8d49bba66d8db34);
      waitframe();
    }
  } else {
    self setclientomnvar("ui_world_fade", 0);
  }

  if(restorehud) {
    utility::hidehuddisable();
  }

  self.respawnfade = undefined;
  self notify("fadeUp_complete");
}

function function_48c5a587383a90e7() {
  if(isDefined(level.var_29f84151a47f0a35)) {
    return [[level.var_29f84151a47f0a35]]();
  }

  return 1;
}

function private function_ce68631570796a41() {
  gametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

  if(gametype == "resurgence") {
    return getdvarint(@ "hash_e4cbe5be35a3a947", 28423);
  }

  return getdvarint(@ "hash_4c90ef27a8730b6", 29387);
}

function private function_408b1b8364d0e722(var_b9c95d2f33c0d8b) {
  self endon("disconnect");
  self waittillmatch("challengeProgress", var_b9c95d2f33c0d8b);
  scripts\cp_mp\challenges::function_52035021c9edec95(var_b9c95d2f33c0d8b);

  if(isDefined(level.arrow) && isDefined(level.arrow.props.tablets)) {
    if(namespace_6c622b52017c6808::function_aee3a8be63db5997(self)) {
      namespace_6c622b52017c6808::function_1b94d19475863421(1);
    }
  }
}

function private function_fd6c077d98fa4be9(var_8ca33da989ab6666) {
  self endon("disconnect");
  self waittillmatch("challengeProgress", var_8ca33da989ab6666);
  scripts\cp_mp\challenges::initgameflags(var_8ca33da989ab6666);

  if(scripts\cp_mp\challenges::function_cfe6dcedf7278543(#"hash_1384ba8ab1971c0f", #"hash_c0c756ce39258e55")) {
    println("<dev string:x4a0>");
  }

  if(scripts\cp_mp\challenges::function_cfe6dcedf7278543(#"hash_1384ba8ab1971c0f", #"hash_9825f19f390e340f")) {
    println("<dev string:x4ca>");
  }

  if(scripts\cp_mp\challenges::function_cfe6dcedf7278543(#"hash_1384ba8ab1971c0f", #"hash_1bf73ab9872f28cb")) {
    println("<dev string:x4fa>");
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(scripts\cp_mp\challenges::function_cfe6dcedf7278543(#"hash_4a7f024e87253788", #"hash_cbddf4cbba197f26")) {
      println("<dev string:x529>");
      scripts\cp_mp\challenges::function_5b58181f4c00ba56(#"hash_4a7f024e87253788", #"hash_cbddf4cbba197f26");
    }
  }
}

function function_35b4c67f5f658332() {
  return int(getDvar(@ "hash_ea48708e2261aa61", 2));
}

function function_1761d46d3de136b9() {
  if(!istrue(scripts\cp_mp\challenges::function_cfe6dcedf7278543(#"hash_1384ba8ab1971c0f", #"hash_11c8e20aa1709429"))) {
    return 0;
  }

  if(issharedfuncdefined("seasonalevents", "isInWinbackDoubleXpPeriod")) {
    return function_f3bb4f4911a1beb2("seasonalevents", "isInWinbackDoubleXpPeriod");
  }

  return 0;
}

function function_5c5f27d13e5eb129() {
  if(istrue(level.gameended)) {
    return;
  }

  self endon("disconnect");
  self endon("spawned_player");
  level endon("game_ended");
  self.currentspectatetarget = undefined;
  self.var_caeae385d522ac4e = undefined;
  self.var_b1e84fe29da97885 = undefined;

  thread debugcommands();

  while(true) {
    self waittill("spectating_cycle_start", playertospectate);

    if(istrue(self.spectatekillcam)) {
      continue;
    }

    if(isDefined(playertospectate)) {
      if(!isDefined(self.var_b1e84fe29da97885)) {
        function_cb60f35d0e8977eb(1);
        thread removespectateblackonspawn();
        thread function_a385f81e49ecdf52();
      }

      if(!isreallyalive(playertospectate)) {
        function_cb60f35d0e8977eb(1);
        continue;
      }

      thread removespectateblackonspectatecycle(playertospectate);
    }
  }
}

function removespectateblackonspectatecycle(playertospectate) {
  self endon("disconnect");
  self endon("spawned_player");
  level endon("game_ended");
  playertospectate endon("death_or_disconnect");
  self notify("removeSpectateBlackOnSpectateCycle");
  self endon("removeSpectateBlackOnSpectateCycle");
  self.currentspectatetarget = playertospectate;
  self waittill("spectating_cycle");

  if(!isDefined(self.var_caeae385d522ac4e)) {
    level thread scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 0, 0.25);
  }

  self.currentspectatetarget = undefined;
  self.var_caeae385d522ac4e = playertospectate;
  thread watchforcurrentspectateclientdeathordisconnect();
}

function watchforcurrentspectateclientdeathordisconnect() {
  self endon("disconnect");
  self endon("spawned_player");
  level endon("game_ended");
  self notify("watchForCurrentSpectateClientDeathOrDisconnect");
  self endon("watchForCurrentSpectateClientDeathOrDisconnect");
  self.var_caeae385d522ac4e waittill("death_or_disconnect");
  function_cb60f35d0e8977eb(0);
  params = spawnStruct();
  params.spectatingplayer = self;
  level callback::callback("spectating_target_death_or_disconnect", params);
}

function function_cb60f35d0e8977eb(instant) {
  self.currentspectatetarget = undefined;
  self.var_caeae385d522ac4e = undefined;
  self.var_b1e84fe29da97885 = 1;
  fadeduration = ter_op(istrue(instant), 0, 1);
  level thread scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 1, fadeduration);
}

function removespectateblackonspawn() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("removeSpectateBlackOnSpawn");
  self endon("removeSpectateBlackOnSpawn");
  self waittill("spawned_player");
  level thread scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 0, 0);
}

function function_a385f81e49ecdf52() {
  self endon("disconnect");
  level waittill("game_ended");
  level thread scripts\cp_mp\utility\game_utility::function_852712268d005332(self, 0, 0);
}

function function_556c01754f79330f() {
  if(getdvarint(@ "scr_globalautopilot", 0) == 1) {
    level callback::add("player_spawned", &function_68242cdc52332123);

    if(!isDefined(level.autopilot)) {
      scripts\mp\autopilot::initialize();
    }
  }
}

function function_68242cdc52332123(params) {
  if(!isbot(self, 0)) {
    self function_54c0f616842eb58e();
  }
}

function debugcommands() {
  while(true) {
    if(getdvarint(@ "hash_ebeff7f31e599ecb", 0) != 0) {
      setDvar(@ "hash_ebeff7f31e599ecb", 0);

      if(isDefined(self.currentspectatetarget)) {
        self.currentspectatetarget _suicide();
      }
    }

    if(getdvarint(@ "hash_1bc12e3cf57a5f09", 0) != 0) {
      setDvar(@ "hash_1bc12e3cf57a5f09", 0);

      if(isDefined(self.var_caeae385d522ac4e)) {
        self.var_caeae385d522ac4e _suicide();
      }
    }

    waitframe();
  }
}

# /