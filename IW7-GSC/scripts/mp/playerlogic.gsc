/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\playerlogic.gsc
**************************************/

timeuntilwavespawn(var_0) {
  if(!self.hasspawned) {
    return 0;
  }

  var_1 = gettime() + var_0 * 1000;
  var_2 = level.lastwave[self.pers["team"]];
  var_3 = level.wavedelay[self.pers["team"]] * 1000;
  var_4 = var_1 - var_2 / var_3;
  var_5 = ceil(var_4);
  var_6 = var_2 + var_5 * var_3;
  if(isDefined(self.respawntimerstarttime)) {
    var_7 = gettime() - self.respawntimerstarttime / 1000;
    if(self.respawntimerstarttime < var_2) {
      return 0;
    }
  }

  if(isDefined(self.wavespawnindex)) {
    var_6 = var_6 + 50 * self.wavespawnindex;
  }

  return var_6 - gettime() / 1000;
}

teamkilldelay() {
  var_0 = self.pers["teamkills"];
  if(level.maxallowedteamkills < 0 || var_0 <= level.maxallowedteamkills) {
    return 0;
  }

  var_1 = var_0 - level.maxallowedteamkills;
  return scripts\mp\tweakables::gettweakablevalue("team", "teamkillspawndelay") * var_1;
}

timeuntilspawn(var_0) {
  if((level.ingraceperiod && !self.hasspawned) || level.gameended) {
    return 0;
  }

  var_1 = 0;
  if(self.hasspawned) {
    var_2 = self[[level.onrespawndelay]]();
    if(isDefined(var_2)) {
      var_1 = var_2;
    } else {
      var_1 = getdvarfloat("scr_" + level.gametype + "_playerrespawndelay");
    }

    if(var_0 && isDefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"]) {
      var_1 = var_1 + teamkilldelay();
    }

    if(isDefined(self.respawntimerstarttime)) {
      var_3 = gettime() - self.respawntimerstarttime / 1000;
      var_1 = var_1 - var_3;
      if(var_1 < 0) {
        var_1 = 0;
      }
    }

    if(isDefined(self.setspawnpoint)) {
      var_1 = var_1 + level.tispawndelay;
    }
  }

  var_4 = getdvarint("scr_" + level.gametype + "_waverespawndelay") > 0;
  if(var_4) {
    return timeuntilwavespawn(var_1);
  }

  return var_1;
}

mayspawn() {
  if(scripts\mp\utility::istrue(level.nukegameover)) {
    return 0;
  }

  if(scripts\mp\utility::getgametypenumlives() || isDefined(level.disablespawning)) {
    if(isDefined(level.disablespawning) && level.disablespawning) {
      return 0;
    }

    if(scripts\mp\utility::istrue(self.pers["teamKillPunish"])) {
      return 0;
    }

    if(self.pers["lives"] <= 0 && scripts\mp\utility::gamehasstarted()) {
      return 0;
    } else if(scripts\mp\utility::gamehasstarted()) {
      if(level.ingraceperiod && !self.hasspawned) {
        return 1;
      }

      if(!level.ingraceperiod && !self.hasspawned && isDefined(level.allowlatecomers) && !level.allowlatecomers) {
        if(isDefined(self.siegelatecomer) && !self.siegelatecomer) {
          return 1;
        }

        return 0;
      }
    }
  }

  return 1;
}

spawnclient() {
  self endon("becameSpectator");
  if(isDefined(self.waitingtoselectclass) && self.waitingtoselectclass) {
    self waittill("okToSpawn");
  }

  if(isDefined(self.addtoteam)) {
    scripts\mp\menus::addtoteam(self.addtoteam);
    self.addtoteam = undefined;
  }

  if(!mayspawn()) {
    wait(0.05);
    var_0 = self.origin;
    var_1 = self.angles;
    self notify("attempted_spawn");
    if(scripts\mp\utility::istrue(self.pers["teamKillPunish"])) {
      self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
      scripts\mp\utility::setlowermessage("friendly_fire", &"MP_FRIENDLY_FIRE_WILL_NOT");
      if(!self.hasspawned && self.pers["teamkills"] <= level.maxallowedteamkills) {
        self.pers["teamKillPunish"] = 0;
      }
    } else if(scripts\mp\utility::isroundbased() && game["finalRound"] == 0) {
      if(isDefined(self.tagavailable) && self.tagavailable) {
        scripts\mp\utility::setlowermessage("spawn_info", game["strings"]["spawn_tag_wait"]);
      } else if(level.gametype == "siege") {
        scripts\mp\utility::setlowermessage("spawn_info", game["strings"]["spawn_point_capture_wait"]);
      } else {
        scripts\mp\utility::setlowermessage("spawn_info", game["strings"]["spawn_next_round"]);
      }

      thread removespawnmessageshortly(3);
    }

    if(self.sessionstate != "spectator") {
      var_0 = var_0 + (0, 0, 60);
    }

    if(scripts\mp\utility::isusingremote()) {
      self.spawningafterremotedeath = 1;
      self.deathposition = self.origin;
      self waittill("stopped_using_remote");
    }

    if(!scripts\mp\utility::istrue(level.nukegameover)) {
      thread spawnspectator(var_0, var_1);
    }

    return;
  }

  if(self.waitingtospawn) {
    return;
  }

  self.waitingtospawn = 1;
  waitandspawnclient();
  if(isDefined(self)) {
    self.waitingtospawn = 0;
  }
}

waitandspawnclient() {
  self endon("disconnect");
  self endon("end_respawn");
  level endon("game_ended");
  self notify("attempted_spawn");
  var_0 = 0;
  if(scripts\mp\utility::istrue(self.pers["teamKillPunish"])) {
    var_1 = teamkilldelay();
    if(var_1 > 0) {
      scripts\mp\utility::setlowermessage("friendly_fire", &"MP_FRIENDLY_FIRE_WILL_NOT", var_1, 1, 1);
      thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
      var_0 = 1;
      wait(var_1);
      scripts\mp\utility::clearlowermessage("friendly_fire");
      self.respawntimerstarttime = gettime();
    }

    self.pers["teamKillPunish"] = 0;
  } else if(teamkilldelay()) {
    self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
  }

  if(scripts\mp\utility::isusingremote()) {
    self.spawningafterremotedeath = 1;
    self.deathposition = self.origin;
    self waittill("stopped_using_remote");
    if(scripts\mp\utility::istrue(level.nukegameover)) {
      return;
    }
  }

  if(!isDefined(self.wavespawnindex) && isDefined(level.waveplayerspawnindex[self.team])) {
    self.wavespawnindex = level.waveplayerspawnindex[self.team];
    level.waveplayerspawnindex[self.team]++;
  }

  var_2 = timeuntilspawn(0);
  thread predictabouttospawnplayerovertime(var_2);
  if(scripts\mp\utility::isinarbitraryup()) {
    var_3 = self getworldupreferenceangles();
    var_4 = anglestoup(var_3);
    var_5 = var_4 * 60;
  } else {
    var_5 = (0, 0, 60);
  }

  if(var_2 > 0) {
    scripts\mp\utility::setlowermessage("spawn_info", game["strings"]["waiting_to_spawn"], var_2, 1, 1);
    if(!var_0) {
      thread respawn_asspectator(self.origin + var_5, self.angles);
    }

    var_0 = 1;
    scripts\mp\utility::waitfortimeornotify(var_2, "force_spawn");
    if(!scripts\mp\utility::istrue(self.waitingtoselectclass)) {
      self notify("stop_wait_safe_spawn_button");
    }
  }

  if(needsbuttontorespawn()) {
    if(!scripts\mp\utility::istrue(self.waitingtoselectclass)) {
      scripts\mp\utility::setlowermessage("spawn_info", game["strings"]["press_to_spawn"], undefined, undefined, undefined, undefined, undefined, undefined, 1);
    }

    if(!var_0) {
      thread respawn_asspectator(self.origin + var_5, self.angles);
    }

    var_0 = 1;
    waitrespawnbutton();
  }

  waitclassselected();
  if(isbot(self)) {
    if(!scripts\mp\bots\_bots::bot_is_ready_to_spawn()) {
      self waittill("bot_ready_to_spawn");
    }
  }

  self.waitingtospawn = 0;
  scripts\mp\utility::clearlowermessage("spawn_info");
  self.wavespawnindex = undefined;
  thread spawnplayer();
}

waitclassselected() {
  while(scripts\mp\utility::istrue(self.waitingtoselectclass)) {
    wait(0.05);
  }
}

needsbuttontorespawn() {
  if(scripts\mp\tweakables::gettweakablevalue("player", "forcerespawn") != 0) {
    return 0;
  }

  if(!self.hasspawned) {
    return 0;
  }

  var_0 = getdvarint("scr_" + level.gametype + "_waverespawndelay") > 0;
  if(var_0) {
    return 0;
  }

  if(self.wantsafespawn) {
    return 0;
  }

  return 1;
}

waitrespawnbutton() {
  self endon("disconnect");
  self endon("end_respawn");
  for(;;) {
    if(self usebuttonpressed()) {
      break;
    }

    wait(0.05);
  }
}

removespawnmessageshortly(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  waittillframeend;
  self endon("end_respawn");
  wait(var_0);
  scripts\mp\utility::clearlowermessage("spawn_info");
}

laststandrespawnplayer() {
  self laststandrevive();
  if(scripts\mp\utility::_hasperk("specialty_finalstand") && !level.diehardmode) {
    scripts\mp\utility::removeperk("specialty_finalstand");
  }

  if(level.diehardmode) {
    self.playerphysicstrace = "";
  }

  self setstance("crouch");
  self.revived = 1;
  self notify("revive");
  if(isDefined(self.standardmaxhealth)) {
    self.maxhealth = self.standardmaxhealth;
  }

  self.health = self.maxhealth;
  scripts\engine\utility::allow_usability(1);
  if(game["state"] == "postgame") {
    scripts\mp\gamelogic::freezeplayerforroundend();
  }
}

getdeathspawnpoint() {
  var_0 = spawn("script_origin", self.origin);
  var_0 hide();
  var_0.angles = self.angles;
  return var_0;
}

predictabouttospawnplayerovertime(var_0) {
  if(!0) {
    return;
  }

  self endon("disconnect");
  self endon("spawned");
  self endon("used_predicted_spawnpoint");
  self notify("predicting_about_to_spawn_player");
  self endon("predicting_about_to_spawn_player");
  if(var_0 <= 0) {
    return;
  }

  if(var_0 > 1) {
    wait(var_0 - 1);
  }

  predictabouttospawnplayer();
  self predictstreampos(self.predictedspawnpoint.origin + (0, 0, 60), self.predictedspawnpoint.angles);
  self.predictedspawnpointtime = gettime();
  for(var_1 = 0; var_1 < 30; var_1++) {
    wait(0.4);
    var_2 = self.predictedspawnpoint;
    predictabouttospawnplayer();
    if(self.predictedspawnpoint != var_2) {
      self predictstreampos(self.predictedspawnpoint.origin + (0, 0, 60), self.predictedspawnpoint.angles);
      self.predictedspawnpointtime = gettime();
    }
  }
}

predictabouttospawnplayer() {
  if(timeuntilspawn(1) > 1) {
    self.predictedspawnpoint = getspectatepoint();
    return;
  }

  if(isDefined(self.setspawnpoint)) {
    self.predictedspawnpoint = self.setspawnpoint;
    return;
  }

  var_0 = self[[level.getspawnpoint]]();
  self.predictedspawnpoint = var_0;
}

checkpredictedspawnpointcorrectness(var_0) {
  self notify("used_predicted_spawnpoint");
  self.predictedspawnpoint = undefined;
}

percentage(var_0, var_1) {
  return var_0 + " (" + int(var_0 / var_1 * 100) + "%)";
}

printpredictedspawnpointcorrectness() {}

getspawnorigin(var_0) {
  if(!positionwouldtelefrag(var_0.origin)) {
    return var_0.origin;
  }

  if(!isDefined(var_0.alternates)) {
    return var_0.origin;
  }

  foreach(var_2 in var_0.alternates) {
    if(!positionwouldtelefrag(var_2)) {
      return var_2;
    }
  }

  return var_0.origin;
}

tivalidationcheck() {
  if(!isDefined(self.setspawnpoint)) {
    return 0;
  }

  var_0 = getEntArray("care_package", "targetname");
  foreach(var_2 in var_0) {
    if(distance(var_2.origin, self.setspawnpoint.playerspawnpos) > 64) {
      continue;
    }

    if(isDefined(var_2.triggerportableradarping)) {
      scripts\mp\hud_message::showsplash("destroyed_insertion", undefined, var_2.triggerportableradarping);
    }

    scripts\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
    return 0;
  }

  var_4 = [];
  var_4[0] = self;
  var_4[1] = self.setspawnpoint;
  var_5 = scripts\common\trace::create_contents(1, 1, 1, 0, 0, 1, 1);
  if(!scripts\common\trace::ray_trace_passed(self.setspawnpoint.origin + (0, 0, 60), self.setspawnpoint.origin, var_4, var_5)) {
    return 0;
  }

  var_6 = self.setspawnpoint.origin + (0, 0, 1);
  var_7 = playerphysicstrace(var_6, self.setspawnpoint.origin + (0, 0, -16));
  if(var_6[2] == var_7[2]) {
    return 0;
  }

  return 1;
}

spawningclientthisframereset() {
  self notify("spawningClientThisFrameReset");
  self endon("spawningClientThisFrameReset");
  wait(0.05);
  level.numplayerswaitingtospawn--;
}

getplayerassets(var_0, var_1) {
  var_2 = scripts\mp\class::loadout_getclassstruct();
  var_2 = scripts\mp\class::loadout_updateclass(var_2, var_1);
  scripts\mp\class::loadout_updateclassfinalweapons(var_2);
  self.classstruct = var_2;
  self.classset = 1;
  if(var_2.loadoutprimaryfullname != "none") {
    var_0.primaryweapon = var_2.loadoutprimaryfullname;
  }

  if(var_2.loadoutsecondaryfullname != "none") {
    var_0.secondaryweapon = var_2.loadoutsecondaryfullname;
  }

  var_3 = scripts\mp\teams::getcustomization();
  if(isDefined(var_3["body"])) {
    var_0.body = var_3["body"];
  }

  if(isDefined(var_3["head"])) {
    var_0.head = var_3["head"];
  }
}

loadplayerassets(var_0, var_1) {
  var_2 = [];
  if(isDefined(var_0.primaryweapon)) {
    var_2[var_2.size] = var_0.primaryweapon;
  }

  if(isDefined(var_0.secondaryweapon)) {
    var_2[var_2.size] = var_0.secondaryweapon;
  }

  if(var_2.size > 0) {
    self loadweaponsforplayer(var_2, var_1);
  }

  self loadcustomization(var_0.body, var_0.head, var_1);
}

allplayershaveassetsloaded(var_0) {
  var_1 = [];
  if(isDefined(var_0.primaryweapon)) {
    var_1[var_1.size] = var_0.primaryweapon;
  }

  if(isDefined(var_0.secondaryweapon)) {
    var_1[var_1.size] = var_0.secondaryweapon;
  }

  if(!self hasloadedviewweapons(var_1)) {
    return 0;
  }

  if(!self hasloadedcustomizationviewmodels(var_0.body)) {
    return 0;
  }

  return 1;
}

spawnplayer(var_0) {
  self endon("disconnect");
  self endon("joined_spectators");
  self notify("spawned");
  self notify("end_respawn");
  self notify("started_spawnPlayer");
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = undefined;
  self.ti_spawn = 0;
  self setclientomnvar("ui_options_menu", 0);
  self setclientomnvar("ui_hud_shake", 0);
  self.lastkillsplash = undefined;
  self.customdeath = undefined;
  self.killsteakvariantattackerinfo = undefined;
  self.cratemantle = undefined;
  if(!level.ingraceperiod && !self.hasdonecombat) {
    level.numplayerswaitingtospawn++;
    if(level.numplayerswaitingtospawn > 1) {
      self.waitingtospawnamortize = 1;
      wait(0.05 * level.numplayerswaitingtospawn - 1);
    }

    thread spawningclientthisframereset();
    self.waitingtospawnamortize = 0;
  }

  var_2 = spawnStruct();
  getplayerassets(var_2, self.class);
  loadplayerassets(var_2, 1);
  if(!getomnvar("ui_prematch_period")) {
    if(!allplayershaveassetsloaded(var_2)) {
      var_3 = scripts\mp\tweakables::gettweakablevalue("player", "streamingwaittime");
      var_4 = var_3 * 1000;
      var_5 = gettime() + var_4;
      self.waitingtospawnamortize = 1;
      wait(0.1);
      while(!allplayershaveassetsloaded(var_2)) {
        wait(0.1);
        if(gettime() > var_5) {
          break;
        }
      }

      self.waitingtospawnamortize = 0;
    }
  }

  if(isDefined(self.forcespawnorigin)) {
    var_6 = self.forcespawnorigin;
    self.forcespawnorigin = undefined;
    if(isDefined(self.forcespawnangles)) {
      var_7 = self.forcespawnangles;
      self.forcespawnangles = undefined;
    } else {
      var_7 = (0, randomfloatrange(0, 360), 0);
    }
  } else if(isDefined(self.setspawnpoint) && isDefined(self.setspawnpoint.notti) || tivalidationcheck()) {
    var_6 = self.setspawnpoint;
    if(!isDefined(self.setspawnpoint.notti)) {
      self.ti_spawn = 1;
      self playlocalsound("tactical_spawn");
      if(level.multiteambased) {
        foreach(var_9 in level.teamnamelist) {
          if(var_9 != self.team) {
            self playsoundtoteam("tactical_spawn", var_9);
          }
        }
      } else if(level.teambased) {
        self playsoundtoteam("tactical_spawn", level.otherteam[self.team]);
      } else {
        self playSound("tactical_spawn");
      }
    }

    foreach(var_0C in level.ugvs) {
      if(distancesquared(var_0C.origin, var_1.playerspawnpos) < 1024) {
        var_0C notify("damage", 5000, var_0C.triggerportableradarping, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, "killstreak_jammer_mp");
      }
    }

    var_6 = self.setspawnpoint.playerspawnpos;
    var_7 = self.setspawnpoint.angles;
    if(isDefined(self.setspawnpoint.enemytrigger)) {
      self.setspawnpoint.enemytrigger delete();
    }

    self.setspawnpoint delete();
    var_1 = undefined;
  } else if(isDefined(self.isspawningonbattlebuddy) && isDefined(self.battlebuddy)) {
    var_6 = undefined;
    var_7 = undefined;
    var_0E = scripts\mp\battlebuddy::checkbuddyspawn();
    if(var_0E.status == 0) {
      var_6 = var_0E.origin;
      var_7 = var_0E.angles;
    } else {
      var_1 = self[[level.getspawnpoint]]();
      var_6 = var_1.origin;
      var_7 = var_1.angles;
    }

    scripts\mp\battlebuddy::cleanupbuddyspawn();
    self setclientomnvar("cam_scene_name", "battle_spawn");
    self setclientomnvar("cam_scene_lead", self.battlebuddy getentitynumber());
    self setclientomnvar("cam_scene_support", self getentitynumber());
  } else if(isDefined(self.helispawning) && !isDefined(self.firstspawn) || isDefined(self.firstspawn) && self.firstspawn && level.prematchperiod > 0 && self.team == "allies") {
    while(!isDefined(level.allieschopper)) {
      wait(0.1);
    }

    var_6 = level.allieschopper.origin;
    var_7 = level.allieschopper.angles;
    self.firstspawn = 0;
  } else if(isDefined(self.helispawning) && !isDefined(self.firstspawn) || isDefined(self.firstspawn) && self.firstspawn && level.prematchperiod > 0 && self.team == "axis") {
    while(!isDefined(level.axischopper)) {
      wait(0.1);
    }

    var_6 = level.axischopper.origin;
    var_7 = level.axischopper.angles;
    self.firstspawn = 0;
  } else {
    var_6 = self[[level.getspawnpoint]]();
    var_6 = var_6.origin;
    var_7 = var_2.angles;
  }

  setspawnvariables();
  var_0F = self.hasspawned;
  self.fauxdeath = undefined;
  if(!var_0) {
    self.killsthislife = [];
    self.killsthislifeperweapon = [];
    self.var_A6B4 = [];
    scripts\mp\utility::updatesessionstate("playing");
    scripts\mp\utility::clearkillcamstate();
    self.cancelkillcam = undefined;
    self.maxhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
    self.health = self.maxhealth;
    self.friendlydamage = undefined;
    self.hasspawned = 1;
    self.spawntime = gettime();
    self.wasti = !isDefined(var_1);
    self.afk = 0;
    self.damagedplayers = [];
    self.killstreakscaler = 1;
    self.objectivescaler = 1;
    self.clampedhealth = undefined;
    self.var_FC96 = 0;
    self.var_FC97 = 0;
    self.var_FC95 = 0;
    self.recentshieldxp = 0;
    self.var_AA43 = undefined;
    self.lifeid = 0;
    if(isDefined(self.pers["deaths"])) {
      self.lifeid = self.pers["deaths"];
    }

    scripts\mp\utility::cleardamagemodifiers();
    scripts\mp\killcam::clearkillcamomnvars();
    thread monitorwallrun();
  }

  self.movespeedscaler = 1;
  self.inlaststand = 0;
  self.setlasermaterial = undefined;
  self.infinalstand = undefined;
  self.inc4death = undefined;
  if(!var_0) {
    self.avoidkillstreakonspawntimer = 4;
    var_10 = self.pers["lives"];
    if(var_10 == scripts\mp\utility::getgametypenumlives()) {
      addtolivescount();
    }

    if(var_10) {
      self.pers["lives"]--;
    }

    addtoalivecount();
    if(!var_0F || scripts\mp\utility::gamehasstarted() || scripts\mp\utility::gamehasstarted() && level.ingraceperiod && self.hasdonecombat) {
      removefromlivescount();
    }

    if(!self.wasaliveatmatchstart) {
      var_11 = 20;
      if(scripts\mp\utility::gettimelimit() > 0 && var_11 < scripts\mp\utility::gettimelimit() * 60 / 4) {
        var_11 = scripts\mp\utility::gettimelimit() * 60 / 4;
      }

      if(level.ingraceperiod || scripts\mp\utility::gettimepassed() < var_11 * 1000) {
        self.wasaliveatmatchstart = 1;
      }
    }
  }

  self setdepthoffield(0, 0, 512, 512, 4, 0);
  if(level.console) {
    self setclientdvar("cg_fov", "63");
  }

  if(isDefined(var_1)) {
    scripts\mp\spawnlogic::finalizespawnpointchoice(var_1);
    var_6 = getspawnorigin(var_1);
    var_7 = var_1.angles;
  } else if(!isDefined(self.faux_spawn_infected)) {
    self.lastspawntime = gettime();
  }

  self.spawnpos = var_6;
  if(var_0 && scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    if(self isonground()) {
      self normalizeworldupreferenceangles();
      var_6 = var_6 - (0, 0, 80);
    }

    var_7 = self getworldupreferenceangles();
  }

  self spawn(var_6, var_7);
  if(var_0 && isDefined(self.faux_spawn_stance)) {
    self setstance(self.faux_spawn_stance);
    self.faux_spawn_stance = undefined;
  }

  if(isai(self)) {
    scripts\mp\utility::freezecontrolswrapper(1);
  }

  self motionblurhqenable();
  [[level.onspawnplayer]]();
  if(isDefined(var_1)) {
    checkpredictedspawnpointcorrectness(var_1.origin);
  }

  if(!var_0) {
    if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["player_spawned"])) {
      self[[level.bot_funcs["player_spawned"]]]();
    }

    if(!isai(self)) {
      thread watchforslide();
    }

    if(isDefined(level.matchrecording_logevent)) {
      [
        [level.matchrecording_logevent]
      ](self.clientid, self.team, "SPAWN", self.spawnpos[0], self.spawnpos[1], self.spawntime);
    }

    if(!isai(self)) {
      if(!isDefined(self.pers["distTrackingPassed"])) {
        thread totaldisttracking(var_6);
      }

      thread stancespamtracking();
    }
  }

  if(!var_0) {
    self.matchdatalifeindex = scripts\mp\matchdata::logplayerlife();
    self.lastmatchdatakillstreakindex = -1;
    thread func_DDED();
    if(self ishost()) {
      setmatchdata("players", self.clientid, "wasAHost", 1);
    }
  }

  scripts\mp\class::setclass(self.class);
  if(isDefined(level.custom_giveloadout)) {
    self[[level.custom_giveloadout]](var_0);
  } else {
    scripts\mp\class::giveloadout(self.team, self.class);
  }

  self _meth_84BE("player_mp");
  if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] > 0) {
    if(!isDefined(self.classrefreshed) || !self.classrefreshed) {
      if(isDefined(self.class_num)) {
        self setclientomnvar("ui_loadout_selected", self.class_num);
        self.classrefreshed = 1;
      }
    }
  }

  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(1);
  }

  if(!scripts\mp\utility::gameflag("prematch_done")) {
    allowprematchlook(self);
  } else {
    scripts\mp\utility::freezecontrolswrapper(0);
  }

  if(scripts\mp\utility::getintproperty("scr_showperksonspawn", 1) == 1 && game["state"] != "postgame") {
    scripts\mp\perks\_perks::func_F7C5("ui_spawn_perk_", self.pers["loadoutPerks"]);
    self setclientomnvar("ui_spawn_abilities_show", 1);
  }

  waittillframeend;
  self.spawningafterremotedeath = undefined;
  self notify("spawned_player");
  level notify("player_spawned", self);
  thread setspawnnotifyomnvar();
  if(game["state"] == "postgame") {
    scripts\mp\gamelogic::freezeplayerforroundend();
  }

  if(scripts\mp\analyticslog::analyticsspawnlogenabled() && !var_0) {
    if(scripts\mp\analyticslog::analyticsdoesspawndataexist()) {
      level.spawncount = level.spawncount + 1;
    } else {
      scripts\mp\analyticslog::analyticsinitspawndata();
    }

    if(scripts\mp\analyticslog::analyticssend_shouldsenddata(level.spawncount)) {
      if(isDefined(level.spawnglobals.spawnpointslist)) {
        scripts\mp\analyticslog::analyticssend_spawnfactors(self, self.spawnpointslist, level.spawncount, var_1);
        scripts\mp\analyticslog::analyticssend_spawntype(var_1.origin, self.team, self.lifeid, level.spawncount);
        scripts\mp\analyticslog::analyticssend_spawnplayerdetails(self, var_1.origin, level.spawncount);
      }
    }

    self.lastspawnpoint = var_1;
  }
}

setspawnnotifyomnvar() {
  self endon("disconnect");
  scripts\engine\utility::waitframe();
  self setclientomnvar("ui_player_spawned_notify", gettime());
}

func_DDED() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(scripts\mp\matchdata::canlogclient(self)) {
    for(;;) {
      var_0 = self.matchdatalifeindex;
      if(!isDefined(var_0)) {
        var_0 = -1;
      }

      var_1 = scripts\mp\utility::func_9EE8();
      var_2 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
      var_3 = var_2 / 1000;
      self _meth_8571(var_3, var_0, var_1);
      wait(2);
    }
  }
}

allowprematchlook(var_0) {
  var_0 allowmovement(0);
  var_0 scripts\engine\utility::allow_fire(0);
  var_0 scripts\engine\utility::allow_offhand_weapons(0);
  var_0 scripts\engine\utility::allow_jump(0);
  var_0.prematchlook = 1;
}

clearprematchlook(var_0) {
  if(scripts\engine\utility::istrue(var_0.prematchlook)) {
    var_0 allowmovement(1);
    var_0 scripts\engine\utility::allow_fire(1);
    var_0 scripts\engine\utility::allow_offhand_weapons(1);
    var_0 scripts\engine\utility::allow_jump(1);
    var_0.prematchlook = undefined;
  }
}

waitforversusmenudone() {
  level endon("prematch_over");
  self endon("versus_menu_done");
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "versus_done") {
      self notify("versus_menu_done");
    }
  }
}

spawnspectatormapcam(var_0) {
  var_1 = 6;
  self endon("disconnect");
  if(isai(self)) {
    return;
  }

  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("cg_fovscale", "0.65");
  } else {
    self setclientdvars("cg_fovscale", "1");
  }

  self setclientomnvar("ui_mapshot_camera", 1);
  self lerpfovbypreset("mapflyover");
  var_2 = scripts\engine\utility::getstructarray("camera_intro", "targetname");
  if(var_2.size == 0) {
    self visionsetfadetoblackforplayer("", 0.75);
    return;
  }

  var_3 = undefined;
  var_4 = undefined;
  setspawnvariables();
  scripts\mp\utility::clearlowermessage("spawn_info");
  scripts\mp\utility::updatesessionstate("spectator");
  self.pers["team"] = "spectator";
  self.team = "spectator";
  scripts\mp\utility::clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonconnect();
  self allowspectateteam("allies", 0);
  self allowspectateteam("axis", 0);
  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);
  if(isDefined(var_2) && var_2.size > 1) {
    var_5 = randomintrange(0, var_2.size - 1);
    var_3 = var_2[var_5];
  } else if(isDefined(var_2)) {
    var_3 = var_2[0];
  }

  var_3.fil = 1;
  scripts\mp\utility::freezecontrolswrapper(1);
  self setspectatedefaults(var_3.origin, var_3.angles);
  self spawn(var_3.origin, var_3.angles);
  checkpredictedspawnpointcorrectness(var_3.origin);
  var_6 = spawn("script_model", var_3.origin);
  var_6 setModel("tag_origin");
  var_6.angles = var_3.angles;
  thread waitforversusmenudone();
  if(isDefined(var_0) && var_0 == 99) {
    var_7 = "debug";
  } else if(scripts\mp\utility::gameflag("prematch_done")) {
    var_7 = "prematch_over";
  } else if(self.versusdone) {
    var_7 = "versus_menu_done";
  } else {
    var_7 = scripts\engine\utility::waittill_any_timeout_1(2, "versus_menu_done", "prematch_over");
  }

  if(var_7 == "timeout") {
    if(scripts\mp\utility::gameflag("prematch_done")) {
      var_7 = "prematch_over";
    } else {
      var_7 = "versus_menu_done";
    }
  }

  if(var_7 == "prematch_over") {
    self visionsetfadetoblackforplayer("", 0.75);
    return;
  }

  if(self issplitscreenplayer() && self issplitscreenplayerprimary()) {
    var_8 = self getothersplitscreenplayer();
    var_8 notify("versus_menu_done");
    wait(0.05);
  }

  self cameralinkto(var_6, "tag_origin");
  var_9 = scripts\mp\utility::getmapname();
  self notify("mapCamera_start");
  switch (var_9) {
    case "mp_parkour":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_parkour", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_frontier":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_frontier", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_fallen":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_fallen", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_proto":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_proto", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_metropolis":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_metropolis", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_dome_iw":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_dome_iw", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_breakneck":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_breakneck", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_desert":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_desert", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_divide":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_divide", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_quarry":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_quarry", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_skyway":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_skyway", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_rivet":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_rivet", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_riot":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_riot", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_dome_dusk":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_dome_iw", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_geneva":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_geneva", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_renaissance2":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_geneva", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_afghan":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_afghan", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_neon":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_neon", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_prime":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_prime", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_flip":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_flip", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_mansion":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_mansion", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_marsoasis":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_marsoasis", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_junk":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_junk", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_turista2":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_marsoasis", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_overflow":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_overflow", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_permafrost2":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_overflow", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_nova":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_nova", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_paris":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_paris", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_pixel":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_pixel", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_hawkwar":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_hawkwar", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_rally":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_rally", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_carnage2":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_rally", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_depot":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_depot", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    case "mp_codphish":
      var_6 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_codphish", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_1 - 0.25);
      break;

    default:
      break;
  }

  wait(0.25);
  self visionsetfadetoblackforplayer("", 0.75);
  self playlocalsound("mp_camera_intro_whoosh");
  var_0A = var_3;
  var_4 = scripts\engine\utility::getstruct(var_3.target, "targetname");
  var_0B = 0;
  for(;;) {
    if(isDefined(var_0A.speedadjust)) {
      var_0C = 1 / var_0A.speedadjust;
      var_0D = var_0C * distance(var_0A.origin, var_4.origin);
    } else {
      var_0D = distance(var_0A.origin, var_4.origin);
    }

    var_0B = var_0B + var_0D;
    var_0A.distancetotarg = var_0D;
    var_0A = var_4;
    if(isDefined(var_0A.target)) {
      var_4 = scripts\engine\utility::getstruct(var_0A.target, "targetname");
      continue;
    }

    break;
  }

  var_0A.eol = 1;
  var_0A = var_3;
  var_4 = scripts\engine\utility::getstruct(var_3.target, "targetname");
  for(;;) {
    var_0E = var_0A.distancetotarg / var_0B;
    var_0F = var_0E * var_1;
    if(isDefined(var_4.eol)) {
      var_10 = var_0F / 2;
    } else {
      var_10 = 0;
    }

    if(isDefined(var_0A.fil)) {
      var_11 = var_0F / 2;
    } else {
      var_11 = 0;
    }

    var_6 moveto(var_4.origin, var_0F, var_11, var_10);
    var_6 rotateto(var_4.angles, var_0F, var_11, var_10);
    if(isDefined(var_4.eol)) {
      var_12 = int(var_0F / 2);
      wait(var_12);
      wait(var_12);
    } else {
      wait(var_0F);
    }

    var_0A = var_4;
    if(isDefined(var_0A.target)) {
      var_4 = scripts\engine\utility::getstruct(var_0A.target, "targetname");
      continue;
    }

    break;
  }

  scripts\mp\utility::freezecontrolswrapper(0);
  self.startcament = var_6;
  self setclientomnvar("ui_mapshot_camera", 0);
}

spawnspectator(var_0, var_1) {
  self notify("spawned");
  self notify("end_respawn");
  self notify("joined_spectators");
  if(isDefined(self.deathspectatepos)) {
    var_0 = self.deathspectatepos;
    var_1 = vectortoangles(self.origin - self.deathspectatepos);
  }

  if(isDefined(self.startcament) && !isDefined(var_0)) {
    var_0 = self.startcament.origin;
    var_1 = self.startcament.angles;
    self.startcament delete();
  }

  in_spawnspectator(var_0, var_1);
}

respawn_asspectator(var_0, var_1) {
  if(isDefined(self.deathspectatepos)) {
    var_0 = self.deathspectatepos;
    var_1 = vectortoangles(self.origin - self.deathspectatepos);
  }

  in_spawnspectator(var_0, var_1);
}

in_spawnspectator(var_0, var_1) {
  setspawnvariables();
  var_2 = self.pers["team"];
  if(isDefined(var_2) && var_2 == "spectator" && !level.gameended) {
    scripts\mp\utility::clearlowermessage("spawn_info");
  }

  scripts\mp\utility::updatesessionstate("spectator");
  scripts\mp\utility::clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonconnect();
  scripts\mp\spectating::setspectatepermissions();
  onspawnspectator(var_0, var_1);
  if(level.teambased && !level.splitscreen && !self issplitscreenplayer()) {
    self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
  }
}

getplayerfromclientnum(var_0) {
  if(var_0 < 0) {
    return undefined;
  }

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] getentitynumber() == var_0) {
      return level.players[var_1];
    }
  }

  return undefined;
}

onspawnspectator(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    self setspectatedefaults(var_0, var_1);
    self spawn(var_0, var_1);
    checkpredictedspawnpointcorrectness(var_0);
    return;
  }

  var_2 = getspectatepoint();
  var_3 = 8;
  if(isDefined(level.camerapos) && level.camerapos.size) {
    for(var_4 = 0; var_4 < level.camerahighestindex + 1 && var_4 < var_3; var_4++) {
      if(!isDefined(level.camerapos[var_4]) || !isDefined(level.cameraang[var_4])) {
        continue;
      }

      self setmlgcameradefaults(var_4, level.camerapos[var_4], level.cameraang[var_4]);
      level.cameramapobjs[var_4].origin = level.camerapos[var_4];
      level.numbermapobjs[var_4].origin = level.camerapos[var_4];
      level.cameramapobjs[var_4].angles = level.cameraang[var_4];
      level.numbermapobjs[var_4].angles = level.cameraang[var_4];
    }
  } else {
    for(var_4 = 0; var_4 < var_3; var_4++) {
      self setmlgcameradefaults(var_4, var_2.origin, var_2.angles);
    }
  }

  self setspectatedefaults(var_2.origin, var_2.angles);
  self spawn(var_2.origin, var_2.angles);
  checkpredictedspawnpointcorrectness(var_2.origin);
}

getspectatepoint() {
  var_0 = getEntArray("mp_global_intermission", "classname");
  var_1 = scripts\mp\spawnlogic::getspawnpoint_random(var_0);
  return var_1;
}

spawnintermission() {
  self endon("disconnect");
  self notify("spawned");
  self notify("end_respawn");
  setspawnvariables();
  scripts\mp\utility::clearlowermessages();
  scripts\mp\utility::freezecontrolswrapper(1);
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  if(isDefined(level.finalkillcam_winner) && level.finalkillcam_winner != "none" && isDefined(level.match_end_delay) && scripts\mp\utility::waslastround() && !scripts\mp\utility::istrue(level.doingbroshot)) {
    wait(level.match_end_delay);
  }

  if(!scripts\mp\utility::istrue(level.doingbroshot)) {
    scripts\mp\utility::updatesessionstate("intermission");
  }

  scripts\mp\utility::clearkillcamstate();
  self.friendlydamage = undefined;
  var_0 = getEntArray("mp_global_intermission", "classname");
  var_0 = scripts\mp\spawnscoring::checkdynamicspawns(var_0);
  var_1 = var_0[0];
  if(!isDefined(level.custom_ending)) {
    self spawn(var_1.origin, var_1.angles);
    checkpredictedspawnpointcorrectness(var_1.origin);
    self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
  } else {
    level notify("scoreboard_displaying");
  }

  scripts\mp\utility::freezecontrolswrapper(1);
}

spawnendofgame() {
  if(1) {
    if(isDefined(level.custom_ending) && scripts\mp\utility::waslastround()) {
      level notify("start_custom_ending");
    }

    if(!self.controlsfrozen) {
      scripts\mp\utility::freezecontrolswrapper(1);
    }

    if(scripts\mp\utility::istrue(level.doingbroshot)) {
      self notify("spawned");
      scripts\mp\utility::clearkillcamstate();
    } else {
      spawnspectator();
      scripts\mp\utility::freezecontrolswrapper(1);
    }

    return;
  }

  self notify("spawned");
  self notify("end_respawn");
  setspawnvariables();
  scripts\mp\utility::clearlowermessages();
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  scripts\mp\utility::updatesessionstate("dead");
  scripts\mp\utility::clearkillcamstate();
  self.friendlydamage = undefined;
  var_0 = getspectatepoint();
  spawnspectator(var_0.origin, var_0.angles);
  checkpredictedspawnpointcorrectness(var_0.origin);
  scripts\mp\utility::freezecontrolswrapper(1);
  self setdepthoffield(0, 0, 512, 512, 4, 0);
}

setspawnvariables() {
  self stopshellshock();
  self stoprumble("damage_heavy");
  self.deathposition = undefined;
}

notifyconnecting() {
  waittillframeend;
  if(isDefined(self)) {
    level notify("connecting", self);
  }
}

callback_playerdisconnect(var_0) {
  if(!isDefined(self.connected)) {
    return;
  }

  if(scripts\mp\utility::isroundbased()) {
    setmatchdata("players", self.clientid, "playerQuitRoundNumber", game["roundsPlayed"]);
  }

  if(level.teambased) {
    if(isDefined(self.team)) {
      if(self.team == "allies") {
        setmatchdata("players", self.clientid, "playerQuitTeamScore", getteamscore("allies"));
        setmatchdata("players", self.clientid, "playerQuitOppposingTeamScore", getteamscore("axis"));
      } else if(self.team == "axis") {
        setmatchdata("players", self.clientid, "playerQuitTeamScore", getteamscore("axis"));
        setmatchdata("players", self.clientid, "playerQuitOppposingTeamScore", getteamscore("allies"));
      }
    }
  }

  setmatchdata("players", self.clientid, "utcDisconnectTimeSeconds", getsystemtime());
  setmatchdata("players", self.clientid, "disconnectReason", var_0);
  self logplayerendmatchdatamatchresult(self.clientid, var_0);
  var_1 = getmatchdata("commonMatchData", "playerCountLeft");
  var_1++;
  setmatchdata("commonMatchData", "playerCountLeft", var_1);
  if(scripts\mp\utility::rankingenabled()) {
    scripts\mp\matchdata::logfinalstats();
  }

  if(scripts\mp\utility::iscontrollingproxyagent()) {
    self restorecontrolagent();
  }

  scripts\mp\matchdata::logplayerdata();
  if(isDefined(self.pers["confirmed"])) {
    scripts\mp\matchdata::logkillsconfirmed();
  }

  if(isDefined(self.pers["denied"])) {
    scripts\mp\matchdata::logkillsdenied();
  }

  removeplayerondisconnect();
  scripts\mp\spawnlogic::removefromparticipantsarray();
  scripts\mp\spawnlogic::removefromcharactersarray();
  var_2 = self getentitynumber();
  if(!level.teambased) {
    game["roundsWon"][self.guid] = undefined;
  }

  if(level.splitscreen) {
    var_3 = level.players;
    if(var_3.size <= 1) {
      level thread scripts\mp\gamelogic::forceend();
    }
  }

  if(isDefined(self.setculldist) && isDefined(self.var_E9)) {
    if(120 < self.timeplayed["total"]) {
      var_4 = self.setculldist - self.var_E9 / self.timeplayed["total"] / 60;
      setplayerteamrank(self, self.clientid, var_4);
    }
  }

  var_5 = self getentitynumber();
  var_6 = self.guid;
  logprint("Q;" + var_6 + ";" + var_5 + ";" + self.name + "\n");
  thread scripts\mp\events::disconnected();
  if(level.gameended) {
    scripts\mp\gamescore::removedisconnectedplayerfromplacement();
  }

  if(isDefined(self.team)) {
    removefromteamcount();
  }

  if(self.sessionstate == "playing" && !isDefined(self.fauxdeath) && self.fauxdeath) {
    removefromalivecount(1);
    return;
  }

  if(self.sessionstate == "spectator" || self.sessionstate == "dead") {
    level thread scripts\mp\gamelogic::updategameevents();
  }
}

removeplayerondisconnect() {
  var_0 = 0;
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] == self) {
      var_0 = 1;
      while(var_1 < level.players.size - 1) {
        level.players[var_1] = level.players[var_1 + 1];
        var_1++;
      }

      level.players[var_1] = undefined;
      break;
    }
  }
}

initclientdvarssplitscreenspecific() {
  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("cg_fovscale", "0.75");
    setdvar("r_materialBloomHQScriptMasterEnable", 0);
    return;
  }

  self setclientdvars("cg_fovscale", "1");
}

initclientdvars() {
  setdvar("cg_drawCrosshair", 1);
  setdvar("cg_drawCrosshairNames", 1);
  if(level.hardcoremode) {
    setdvar("cg_drawCrosshair", 0);
    setdvar("cg_drawCrosshairNames", 1);
  }

  if(isDefined(level.alwaysdrawfriendlynames) && level.alwaysdrawfriendlynames) {
    setdvar("cg_drawFriendlyNamesAlways", 1);
  } else {
    setdvar("cg_drawFriendlyNamesAlways", 0);
  }

  self setclientdvars("cg_drawSpectatorMessages", 1);
  initclientdvarssplitscreenspecific();
  if(scripts\mp\utility::getgametypenumlives()) {
    self setclientdvars("cg_deadChatWithDead", 1, "cg_deadChatWithTeam", 0, "cg_deadHearTeamLiving", 0, "cg_deadHearAllLiving", 0);
  } else {
    self setclientdvars("cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0);
  }

  if(level.teambased) {
    self setclientdvars("cg_everyonehearseveryone", 0);
  }

  self setclientdvar("ui_altscene", 0);
  if(getdvarint("scr_hitloc_debug")) {
    for(var_0 = 0; var_0 < 6; var_0++) {
      self setclientdvar("ui_hitloc_" + var_0, "");
    }

    self.hitlocinited = 1;
  }
}

getlowestavailableclientid() {
  var_0 = 0;
  for(var_1 = 0; var_1 < 30; var_1++) {
    foreach(var_3 in level.players) {
      if(!isDefined(var_3)) {
        continue;
      }

      if(var_3.clientid == var_1) {
        var_0 = 1;
        break;
      }

      var_0 = 0;
    }

    if(!var_0) {
      return var_1;
    }
  }
}

setupsavedactionslots() {
  self.saved_actionslotdata = [];
  for(var_0 = 1; var_0 <= 4; var_0++) {
    self.saved_actionslotdata[var_0] = spawnStruct();
    self.saved_actionslotdata[var_0].type = "";
    self.saved_actionslotdata[var_0].randomintrange = undefined;
  }

  if(!level.console) {
    for(var_0 = 5; var_0 <= 8; var_0++) {
      self.saved_actionslotdata[var_0] = spawnStruct();
      self.saved_actionslotdata[var_0].type = "";
      self.saved_actionslotdata[var_0].randomintrange = undefined;
    }
  }
}

connect_validateplayerteam() {
  if(!isDefined(self)) {
    return;
  }

  if(self.sessionteam == "none" && scripts\mp\utility::matchmakinggame() && level.teambased && !isDefined(self.pers["isBot"]) && !self ismlgspectator() && level.gametype != "infect") {
    bbprint("mp_invalid_team_error", "player_xuid %s isHost %i", self getxuid(), self ishost());
    wait(1.5);
    kick(self getentitynumber(), "EXE_PLAYERKICKED_INVALIDTEAM");
  }
}

queueconnectednotify() {
  for(;;) {
    if(!isDefined(level.players_waiting_for_callback)) {
      wait(0.05);
      continue;
    }

    break;
  }

  for(;;) {
    for(var_0 = 0; var_0 < level.players_waiting_for_callback.size; var_0++) {
      var_1 = level.players_waiting_for_callback[var_0];
      if(isDefined(var_1)) {
        level notify("connected", var_1);
        var_1 notify("connected_continue");
        level.players_waiting_for_callback[var_0] = undefined;
        break;
      }
    }

    var_2 = scripts\mp\utility::cleanarray(level.players_waiting_for_callback);
    level.players_waiting_for_callback = var_2;
    wait(0.05);
  }
}

watchforversusdone() {
  self endon("disconnect");
  self.versusdone = 0;
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);
    if(var_0 == "versus_done") {
      self.versusdone = 1;
      return;
    }
  }
}

monitorplayersegments(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  createplayersegmentstats(var_0);
  for(;;) {
    var_0 waittill("spawned_player");
    recordsegmentdata(var_0);
  }
}

createplayersegmentstats(var_0) {
  var_0.segments = [];
  var_0.segments["distanceTotal"] = 0;
  var_0.segments["movingTotal"] = 0;
  var_0.segments["movementUpdateCount"] = 0;
}

recordsegmentdata(var_0) {
  var_0 endon("death");
  while(!scripts\mp\utility::gameflag("prematch_done")) {
    wait(0.5);
  }

  wait(4);
  var_0.savedsegmentposition = var_0.origin;
  var_0.positionptm = var_0.origin;
  for(;;) {
    wait(1);
    if(var_0 scripts\mp\utility::isusingremote()) {
      var_0 waittill("stopped_using_remote");
      var_0.savedsegmentposition = var_0.origin;
      var_0.positionptm = var_0.origin;
      continue;
    }

    var_0.segments["movementUpdateCount"]++;
    var_0.segments["distanceTotal"] = var_0.segments["distanceTotal"] + distance2d(var_0.savedsegmentposition, var_0.origin);
    var_0.savedsegmentposition = var_0.origin;
    if(var_0.segments["movementUpdateCount"] % 5 == 0) {
      var_1 = distance2d(var_0.positionptm, var_0.origin);
      var_0.positionptm = var_0.origin;
      if(var_1 > 16) {
        var_0.segments["movingTotal"]++;
      }
    }
  }
}

writesegmentdata(var_0) {
  var_0 endon("disconnect");
  if(var_0.segments["movementUpdateCount"] < 30) {
    return;
  }

  var_1 = var_0.segments["movingTotal"] / var_0.segments["movementUpdateCount"] / 5 * 100;
  var_2 = var_0.segments["distanceTotal"] / var_0.segments["movementUpdateCount"];
  setmatchdata("players", var_0.clientid, "averageSpeedDuringMatch", var_2);
  setmatchdata("players", var_0.clientid, "percentageOfTimeMoving", var_1);
}

callback_playerconnect() {
  thread notifyconnecting();
  thread watchforversusdone();
  self.getgrenadefusetime = "hud_status_connecting";
  self waittill("begin");
  self.getgrenadefusetime = "";
  self.connecttime = undefined;
  self visionsetfadetoblackforplayer("bw", 0);
  level.players_waiting_for_callback[level.players_waiting_for_callback.size] = self;
  self waittill("connected_continue");
  self.connected = 1;
  self setclientomnvar("ui_scoreboard_freeze", 0);
  if(self ishost()) {
    level.player = self;
  }

  if(!level.splitscreen && !isDefined(self.pers["score"])) {
    iprintln(&"MP_CONNECTED", self);
  }

  self.usingonlinedataoffline = self isusingonlinedataoffline();
  initclientdvars();
  initplayerstats();
  if(getdvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  self.guid = scripts\mp\utility::getuniqueid();
  var_0 = 0;
  var_1 = 0;
  if(!isDefined(self.pers["clientid"])) {
    for(var_2 = 0; var_2 < 30; var_2++) {
      var_3 = getmatchdata("players", var_2, "playerID", "xuid");
      if(var_3 == self.guid) {
        self.pers["clientid"] = var_2;
        var_1 = 1;
        var_4 = getmatchdata("commonMatchData", "playerCountReconnected");
        var_4++;
        setmatchdata("commonMatchData", "playerCountReconnected", var_4);
        setmatchdata("players", var_2, "utcReconnectTimeSeconds", getsystemtime());
        break;
      }
    }

    if(!var_1) {
      if(game["clientid"] >= 30) {
        self.pers["clientid"] = getlowestavailableclientid();
      } else {
        self.pers["clientid"] = game["clientid"];
      }

      if(game["clientid"] < 30) {
        game["clientid"]++;
      }
    }

    var_0 = 1;
    self.pers["matchdataWeaponStats"] = [];
    self.pers["matchdataScoreEventCounts"] = [];
    self.pers["xpAtLastDeath"] = 0;
    self.pers["scoreAtLastDeath"] = 0;
    self _meth_8596(self.pers["clientid"]);
    setmatchdata("players", self.pers["clientid"], "joinType", self getjointype());
    setmatchdata("players", self.pers["clientid"], "isTrialVersion", self istrialversion());
  }

  if(var_0) {
    scripts\mp\persistence::statsetchildbuffered("round", "timePlayed", 0, 1);
    self setplayerdata("common", "round", "timePlayed", 0);
    self setplayerdata("common", "round", "totalXp", 0);
    self setplayerdata("common", "aarUnlockCount", 0);
    if(!isDefined(game["uniquePlayerCount"])) {
      game["uniquePlayerCount"] = 1;
    } else {
      game["uniquePlayerCount"]++;
    }
  }

  self.clientid = self.pers["clientid"];
  self.pers["teamKillPunish"] = 0;
  logprint("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");
  self logstatmatchguid();
  var_5 = getmatchdata("commonMatchData", "playerCount");
  if(game["clientid"] <= 30 && game["clientid"] != var_5) {
    if(!isai(self) && scripts\mp\utility::matchmakinggame()) {
      self registerparty(self.clientid);
    }

    if(var_0 && !var_1) {
      var_5++;
      setmatchdata("commonMatchData", "playerCount", var_5);
    }

    setmatchdata("players", self.clientid, "playerID", "xuid", scripts\mp\utility::getuniqueid());
    setmatchdata("players", self.clientid, "gamertag", self.name);
    setmatchdata("players", self.clientid, "skill", self getskill());
    setmatchclientip(self, self.clientid);
    if(var_0 && !var_1) {
      setmatchdata("players", self.clientid, "utcConnectTimeSeconds", getsystemtime());
    }

    if(scripts\mp\utility::rankingenabled()) {
      scripts\mp\matchdata::loginitialspawnposition();
    }

    if((isDefined(self.pers["isBot"]) && self.pers["isBot"]) || isai(self)) {
      var_6 = 1;
      setmatchdata("players", self.clientid, "isBot", 1);
    } else {
      var_6 = 0;
    }

    if(scripts\mp\utility::matchmakinggame() && scripts\mp\utility::allowteamassignment() && !var_6) {
      setmatchdata("players", self.clientid, "team", self.sessionteam);
    }

    if(var_0 && isDefined(level.matchrecording_logeventplayername)) {
      [
        [level.matchrecording_logeventplayername]
      ](self.clientid, self.team, self.name);
    }
  }

  if(!level.teambased) {
    game["roundsWon"][self.guid] = 0;
  }

  self.leaderdialogqueue = [];
  self.leaderdialoglocqueue = [];
  self.leaderdialogactive = "";
  self.leaderdialoggroups = [];
  self.leaderdialoggroup = "";
  if(!isDefined(self.pers["cur_kill_streak"])) {
    self.pers["cur_kill_streak"] = 0;
  }

  if(!isDefined(self.pers["cur_death_streak"])) {
    self.pers["cur_death_streak"] = 0;
  }

  if(!isDefined(self.pers["cur_kill_streak_for_nuke"])) {
    self.pers["cur_kill_streak_for_nuke"] = 0;
  }

  if(scripts\mp\utility::rankingenabled()) {
    self.kill_streak = scripts\mp\persistence::statget("killStreak");
  }

  self.lastgrenadesuicidetime = -1;
  self.teamkillsthisround = 0;
  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.wasaliveatmatchstart = 0;
  self.movespeedscaler = 1;
  self.killstreakscaler = 1;
  self.objectivescaler = 1;
  self.firstspawn = 1;
  self.lifeid = 0;
  if(isDefined(self.pers["deaths"])) {
    self.lifeid = self.pers["deaths"];
  }

  setupsavedactionslots();
  level thread monitorplayersegments(self);
  resetuiomnvarscommon();
  waittillframeend;
  level.players[level.players.size] = self;
  scripts\mp\spawnlogic::addtoparticipantsarray();
  scripts\mp\spawnlogic::addtocharactersarray();
  if(game["state"] == "postgame") {
    self.connectedpostgame = 1;
    self setclientdvars("cg_drawSpectatorMessages", 0);
    self visionsetfadetoblackforplayer("", 0.25);
    spawnintermission();
    return;
  }

  if(var_0 && scripts\mp\utility::gettimepassed() >= -5536 || game["roundsPlayed"] > 0) {
    self.joinedinprogress = 1;
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

  if(!isDefined(self.pers["team"])) {
    var_0A = scripts\mp\utility::gettimepassed() / 1000 + 6;
    if(var_0A < level.prematchperiod) {
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
    if(self ismlgspectator()) {
      thread scripts\mp\menus::setspectator();
      return;
    }

    if((scripts\mp\utility::matchmakinggame() || scripts\mp\utility::lobbyteamselectenabled() || isgamebattlematch()) && self.sessionteam != "none") {
      thread spawnspectator();
      thread scripts\mp\menus::setteam(self.sessionteam);
      if(scripts\mp\utility::allowclasschoice() || scripts\mp\utility::showfakeloadout() && !isai(self)) {
        self setclientomnvar("ui_options_menu", 2);
      }

      if(!isgamebattlematch()) {
        thread kickifdontspawn();
      }

      return;
    }

    if(!scripts\mp\utility::matchmakinggame() && scripts\mp\utility::allowteamassignment()) {
      scripts\mp\menus::menuspectator();
      self setclientomnvar("ui_options_menu", 1);
      return;
    }

    thread spawnspectator();
    scripts\mp\menus::autoassign();
    if(scripts\mp\utility::allowclasschoice() || scripts\mp\utility::showfakeloadout() && !isai(self)) {
      self setclientomnvar("ui_options_menu", 2);
    }

    if(scripts\mp\utility::matchmakinggame()) {
      thread kickifdontspawn();
    }

    return;
  }

  self visionsetfadetoblackforplayer("", 0.5);
  connect_validateplayerteam();
  var_0B = self.pers["team"];
  if(scripts\mp\utility::matchmakinggame() && !isDefined(self.pers["isBot"]) && !self ismlgspectator() && getdvarint("team_consistency_fix")) {
    var_0B = self.sessionteam;
  }

  scripts\mp\menus::addtoteam(var_0B, 1);
  if(self ismlgspectator()) {
    thread spawnspectator();
    return;
  }

  if(scripts\mp\utility::isvalidclass(self.pers["class"])) {
    thread spawnclient();
    return;
  }

  thread spawnspectator();
  if(self.pers["team"] == "spectator") {
    if(scripts\mp\utility::allowteamassignment()) {
      scripts\mp\menus::beginteamchoice();
      return;
    }

    self[[level.autoassign]]();
    return;
  }

  scripts\mp\menus::beginclasschoice();
}

callback_playermigrated() {
  if(isDefined(self.connected) && self.connected) {
    scripts\mp\utility::updateobjectivetext();
    scripts\mp\utility::updatemainmenu();
  }

  if(self ishost()) {
    initclientdvarssplitscreenspecific();
  }

  var_0 = 0;
  foreach(var_2 in level.players) {
    if(!isDefined(var_2.pers["isBot"]) || var_2.pers["isBot"] == 0) {
      var_0++;
    }
  }

  if(!isDefined(self.pers["isBot"]) || self.pers["isBot"] == 0) {
    level.hostmigrationreturnedplayercount++;
    if(level.hostmigrationreturnedplayercount >= var_0 * 2 / 3) {
      level notify("hostmigration_enoughplayers");
    }
  }
}

addlevelstoexperience(var_0, var_1) {
  var_2 = scripts\mp\rank::getrankforxp(var_0);
  var_3 = scripts\mp\rank::getrankinfominxp(var_2);
  var_4 = scripts\mp\rank::getrankinfomaxxp(var_2);
  var_2 = var_2 + var_0 - var_3 / var_4 - var_3;
  var_2 = var_2 + var_1;
  if(var_2 < 0) {
    var_2 = 0;
    var_5 = 0;
  } else if(var_3 >= level.maxrank + 1) {
    var_3 = level.maxrank;
    var_5 = 1;
  } else {
    var_5 = var_3 - floor(var_3);
    var_2 = int(floor(var_2));
  }

  var_3 = scripts\mp\rank::getrankinfominxp(var_2);
  var_4 = scripts\mp\rank::getrankinfomaxxp(var_2);
  return int(var_5 * var_4 - var_3) + var_3;
}

forcespawn() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");
  wait(60);
  if(self.hasspawned) {
    return;
  }

  if(self.pers["team"] == "spectator") {
    return;
  }

  if(!scripts\mp\utility::isvalidclass(self.pers["class"])) {
    self.pers["class"] = "CLASS_CUSTOM1";
    self.class = self.pers["class"];
  }

  thread spawnclient();
}

kickifdontspawn() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");
  self endon("attempted_spawn");
  var_0 = getdvarfloat("scr_kick_time", 90);
  var_1 = getdvarfloat("scr_kick_mintime", 45);
  var_2 = getdvarfloat("scr_kick_hosttime", 120);
  var_3 = gettime();
  if(self ishost()) {
    kickwait(var_2);
  } else {
    kickwait(var_0);
  }

  var_4 = gettime() - var_3 / 1000;
  if(var_4 < var_0 - 0.1 && var_4 < var_1) {
    return;
  }

  if(self.hasspawned) {
    return;
  }

  if(self.pers["team"] == "spectator") {
    return;
  }

  kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE", 1);
  level thread scripts\mp\gamelogic::updategameevents();
}

kickwait(var_0) {
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
}

monitorvotekick() {
  level endon("game_ended");
  self endon("disconnect");
  self.votestokick = 0;
  while(self.votestokick < 2) {
    self waittill("voteToKick");
    self.votestokick++;
  }

  kick(self getentitynumber(), "EXE_PLAYERKICKED_TEAMKILLS");
}

fakevote() {
  wait(1);
  self notify("voteToKick");
  wait(3);
  self notify("voteToKick");
  wait(2);
  self notify("voteToKick");
}

totaldisttracking(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");
  self notify("distFromSpawnTracking");
  self endon("distFromSpawnTracking");
  if(!scripts\mp\utility::gameflag("prematch_done")) {
    scripts\mp\utility::gameflagwait("prematch_done");
  }

  var_1 = var_0;
  for(;;) {
    scripts\engine\utility::waittill_notify_or_timeout("death", 5);
    if(!isDefined(self.pers["totalDistTraveledSQ"])) {
      self.pers["totalDistTraveledSQ"] = 0;
    }

    self.pers["totalDistTraveledSQ"] = self.pers["totalDistTraveledSQ"] + distancesquared(var_1, self.origin);
    var_1 = self.origin;
    if(self.pers["totalDistTraveledSQ"] > 90000) {
      self.pers["distTrackingPassed"] = 1;
    }
  }
}

stancespamtracking() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");
  self notify("stanceSpamTracking");
  self endon("stanceSpamTracking");
  if(!scripts\mp\utility::gameflag("prematch_done")) {
    scripts\mp\utility::gameflagwait("prematch_done");
  }

  var_0 = undefined;
  for(;;) {
    var_1 = self getstance();
    if(isDefined(var_0) && var_0 != var_1) {
      if(!isDefined(self.pers["stanceTracking"])) {
        self.pers["stanceTracking"] = [];
        self.pers["stanceTracking"]["prone"] = 0;
        self.pers["stanceTracking"]["crouch"] = 0;
        self.pers["stanceTracking"]["stand"] = 0;
      }

      if(var_1 == "prone" || var_1 == "crouch" || var_1 == "stand") {
        self.pers["stanceTracking"][var_1]++;
      }
    }

    var_0 = var_1;
    scripts\engine\utility::waitframe();
  }
}

initplayerstats() {
  scripts\mp\persistence::initbufferedstats();
  if(!isDefined(self.pers["deaths"])) {
    scripts\mp\utility::initpersstat("deaths");
    scripts\mp\persistence::statsetchild("round", "deaths", 0);
  }

  self.var_E9 = scripts\mp\utility::getpersstat("deaths");
  if(!isDefined(self.pers["score"])) {
    scripts\mp\utility::initpersstat("score");
    scripts\mp\persistence::statsetchild("round", "score", 0);
  }

  self.destroynavrepulsor = scripts\mp\utility::getpersstat("score");
  if(!isDefined(self.pers["suicides"])) {
    scripts\mp\utility::initpersstat("suicides");
  }

  self.suicides = scripts\mp\utility::getpersstat("suicides");
  if(!isDefined(self.pers["kills"])) {
    scripts\mp\utility::initpersstat("kills");
    scripts\mp\persistence::statsetchild("round", "kills", 0);
  }

  self.setculldist = scripts\mp\utility::getpersstat("kills");
  if(!isDefined(self.pers["headshots"])) {
    scripts\mp\utility::initpersstat("headshots");
  }

  self.headshots = scripts\mp\utility::getpersstat("headshots");
  if(!isDefined(self.pers["assists"])) {
    scripts\mp\utility::initpersstat("assists");
    scripts\mp\persistence::statsetchild("round", "assists", 0);
  }

  self.var_4D = scripts\mp\utility::getpersstat("assists");
  if(!isDefined(self.pers["captures"])) {
    scripts\mp\utility::initpersstat("captures");
    scripts\mp\persistence::statsetchild("round", "captures", 0);
  }

  self.captures = scripts\mp\utility::getpersstat("captures");
  if(!isDefined(self.pers["returns"])) {
    scripts\mp\utility::initpersstat("returns");
    scripts\mp\persistence::statsetchild("round", "returns", 0);
  }

  self.returns = scripts\mp\utility::getpersstat("returns");
  if(!isDefined(self.pers["defends"])) {
    scripts\mp\utility::initpersstat("defends");
    scripts\mp\persistence::statsetchild("round", "defends", 0);
  }

  self.defends = scripts\mp\utility::getpersstat("defends");
  if(!isDefined(self.pers["plants"])) {
    scripts\mp\utility::initpersstat("plants");
    scripts\mp\persistence::statsetchild("round", "plants", 0);
  }

  self.plants = scripts\mp\utility::getpersstat("plants");
  if(!isDefined(self.pers["defuses"])) {
    scripts\mp\utility::initpersstat("defuses");
    scripts\mp\persistence::statsetchild("round", "defuses", 0);
  }

  self.defuses = scripts\mp\utility::getpersstat("defuses");
  if(!isDefined(self.pers["destructions"])) {
    scripts\mp\utility::initpersstat("destructions");
    scripts\mp\persistence::statsetchild("round", "destructions", 0);
  }

  self.destructions = scripts\mp\utility::getpersstat("destructions");
  if(!isDefined(self.pers["confirmed"])) {
    scripts\mp\utility::initpersstat("confirmed");
    scripts\mp\persistence::statsetchild("round", "confirmed", 0);
  }

  self.confirmed = scripts\mp\utility::getpersstat("confirmed");
  if(!isDefined(self.pers["denied"])) {
    scripts\mp\utility::initpersstat("denied");
    scripts\mp\persistence::statsetchild("round", "denied", 0);
  }

  self.denied = scripts\mp\utility::getpersstat("denied");
  if(!isDefined(self.pers["rescues"])) {
    scripts\mp\utility::initpersstat("rescues");
    scripts\mp\persistence::statsetchild("round", "rescues", 0);
  }

  self.rescues = scripts\mp\utility::getpersstat("rescues");
  if(!isDefined(self.pers["touchdowns"])) {
    scripts\mp\utility::initpersstat("touchdowns");
    scripts\mp\persistence::statsetchild("round", "touchdowns", 0);
  }

  self.touchdowns = scripts\mp\utility::getpersstat("touchdowns");
  if(!isDefined(self.pers["fieldgoals"])) {
    scripts\mp\utility::initpersstat("fieldgoals");
    scripts\mp\persistence::statsetchild("round", "fieldgoals", 0);
  }

  self.fieldgoals = scripts\mp\utility::getpersstat("fieldgoals");
  if(!isDefined(self.pers["killChains"])) {
    scripts\mp\utility::initpersstat("killChains");
    scripts\mp\persistence::statsetchild("round", "killChains", 0);
  }

  self.killchains = scripts\mp\utility::getpersstat("killChains");
  if(!isDefined(self.pers["killsAsSurvivor"])) {
    scripts\mp\utility::initpersstat("killsAsSurvivor");
    scripts\mp\persistence::statsetchild("round", "killsAsSurvivor", 0);
  }

  self.killsassurvivor = scripts\mp\utility::getpersstat("killsAsSurvivor");
  if(!isDefined(self.pers["killsAsInfected"])) {
    scripts\mp\utility::initpersstat("killsAsInfected");
    scripts\mp\persistence::statsetchild("round", "killsAsInfected", 0);
  }

  self.killsasinfected = scripts\mp\utility::getpersstat("killsAsInfected");
  if(!isDefined(self.pers["teamkills"])) {
    scripts\mp\utility::initpersstat("teamkills");
  }

  if(!isDefined(self.pers["extrascore0"])) {
    scripts\mp\utility::initpersstat("extrascore0");
  }

  if(!isDefined(self.pers["extrascore1"])) {
    scripts\mp\utility::initpersstat("extrascore1");
  }

  if(!isDefined(self.pers["stabs"])) {
    scripts\mp\utility::initpersstat("stabs");
    scripts\mp\persistence::statsetchild("round", "stabs", 0);
  }

  self.stabs = scripts\mp\utility::getpersstat("stabs");
  if(!isDefined(self.pers["setbacks"])) {
    scripts\mp\utility::initpersstat("setbacks");
    scripts\mp\persistence::statsetchild("round", "setbacks", 0);
  }

  self.setbacks = scripts\mp\utility::getpersstat("setbacks");
  if(!isDefined(self.pers["objTime"])) {
    scripts\mp\utility::initpersstat("objTime");
    scripts\mp\persistence::statsetchild("round", "objTime", 0);
  }

  self.objstruct = scripts\mp\utility::getpersstat("objTime");
  if(!isDefined(self.pers["gamemodeScore"])) {
    scripts\mp\utility::initpersstat("gamemodeScore");
    scripts\mp\persistence::statsetchild("round", "gamemodeScore", 0);
  }

  if(!isDefined(self.pers["supersEarned"])) {
    scripts\mp\utility::initpersstat("supersEarned");
  }

  if(!isDefined(self.pers["wardenKSCount"])) {
    scripts\mp\utility::initpersstat("wardenKSCount");
  }

  if(!isDefined(self.pers["teamKillPunish"])) {
    self.pers["teamKillPunish"] = 0;
  }

  scripts\mp\utility::initpersstat("longestStreak");
  self.pers["lives"] = ::scripts\mp\utility::getgametypenumlives();
  scripts\mp\persistence::statsetchild("round", "killStreak", 0);
  scripts\mp\persistence::statsetchild("round", "loss", 0);
  scripts\mp\persistence::statsetchild("round", "win", 0);
  scripts\mp\persistence::statsetchild("round", "scoreboardType", "none");
}

addtoteamcount() {
  level.teamcount[self.team]++;
  if(!isDefined(level.teamlist)) {
    level.teamlist = [];
  }

  if(!isDefined(level.teamlist[self.team])) {
    level.teamlist[self.team] = [];
  }

  level.teamlist[self.team][level.teamlist[self.team].size] = self;
  scripts\mp\gamelogic::updategameevents();
}

removefromteamcount() {
  level.teamcount[self.team]--;
  if(isDefined(level.teamlist) && isDefined(level.teamlist[self.team])) {
    var_0 = [];
    foreach(var_2 in level.teamlist[self.team]) {
      if(!isDefined(var_2) || var_2 == self) {
        continue;
      }

      var_0[var_0.size] = var_2;
    }

    level.teamlist[self.team] = var_0;
  }
}

addtoalivecount() {
  var_0 = self.team;
  if(!isDefined(self.alreadyaddedtoalivecount) && self.alreadyaddedtoalivecount) {
    level.hasspawned[var_0]++;
    incrementalivecount(var_0);
  }

  self.alreadyaddedtoalivecount = undefined;
  if(level.alivecount["allies"] + level.alivecount["axis"] > level.maxplayercount) {
    level.maxplayercount = level.alivecount["allies"] + level.alivecount["axis"];
  }
}

incrementalivecount(var_0, var_1) {
  level.alivecount[var_0]++;
  if(!isDefined(level.alive_players)) {
    level.alive_players = [];
  }

  if(!isDefined(level.alive_players[var_0])) {
    level.alive_players[var_0] = [];
  }

  level.alive_players[var_0] = ::scripts\engine\utility::array_add(level.alive_players[var_0], self);
  if(scripts\mp\utility::istrue(var_1) && var_0 == "allies" || var_0 == "axis") {
    var_2 = level.otherteam[var_0];
    foreach(var_4 in level.players) {
      if(var_4.team == var_0) {
        var_4 playsoundtoplayer("mp_bodycount_tick_positive", var_4);
        continue;
      }

      if(var_4.team == var_2) {
        var_4 playsoundtoplayer("mp_bodycount_tick_negative", var_4);
      }
    }
  }

  scripts\mp\gamelogic::updategameevents();
}

removefromalivecount(var_0) {
  var_1 = self.pers["lives"];
  var_2 = scripts\mp\utility::getgametypenumlives() != 0 && var_1 == 0;
  var_3 = self.team;
  if(isDefined(self.switching_teams) && self.switching_teams && isDefined(self.joining_team) && self.joining_team == self.team) {
    var_3 = self.leaving_team;
  }

  if(isDefined(var_0)) {
    removeallfromlivescount();
  } else if(isDefined(self.switching_teams) && !level.ingraceperiod || self.hasdonecombat) {
    if(var_1) {
      self.pers["lives"]--;
    }
  }

  decrementalivecount(var_3, var_2);
}

decrementalivecount(var_0, var_1) {
  level.alivecount[var_0]--;
  for(var_2 = 0; var_2 < level.alive_players[var_0].size; var_2++) {
    if(level.alive_players[var_0][var_2] == self) {
      level.alive_players[var_0][var_2] = level.alive_players[var_0][level.alive_players[var_0].size - 1];
      level.alive_players[var_0][level.alive_players[var_0].size - 1] = undefined;
      break;
    }
  }

  if(scripts\mp\utility::istrue(var_1) && var_0 == "allies" || var_0 == "axis") {
    var_3 = level.otherteam[var_0];
    foreach(var_5 in level.players) {
      if(var_5.team == var_0) {
        var_5 playsoundtoplayer("mp_bodycount_tick_negative", var_5);
        continue;
      }

      if(var_5.team == var_3) {
        var_5 playsoundtoplayer("mp_bodycount_tick_positive", var_5);
      }
    }
  }

  scripts\mp\gamelogic::updategameevents();
}

addtolivescount() {
  level.livescount[self.team] = level.livescount[self.team] + self.pers["lives"];
}

removefromlivescount() {
  level.livescount[self.team]--;
  level.livescount[self.team] = int(max(0, level.livescount[self.team]));
}

removeallfromlivescount() {
  level.livescount[self.team] = level.livescount[self.team] - self.pers["lives"];
  level.livescount[self.team] = int(max(0, level.livescount[self.team]));
}

resetuiomnvarscommon() {
  self setclientomnvar("ui_carrying_bomb", 0);
  self setclientomnvar("ui_objective_state", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_light_armor", 0);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_juiced_end_milliseconds", 0);
  self setclientdvar("ui_eyes_on_end_milliseconds", 0);
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self setclientomnvar("ui_edge_glow", 0);
}

resetuidvarsonconnect() {
  self setclientomnvar("ui_carrying_bomb", 0);
  self setclientomnvar("ui_objective_state", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_light_armor", 0);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_juiced_end_milliseconds", 0);
  self setclientdvar("ui_eyes_on_end_milliseconds", 0);
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self setclientomnvar("ui_edge_glow", 0);
}

monitorwallrun() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    if(self iswallrunning()) {
      self.var_AA43 = gettime();
    }

    wait(0.05);
  }
}

watchforslide() {
  self endon("death");
  self endon("disconnect");
  self waittill("sprint_slide_begin");
}

func_13B76() {
  self endon("death");
  self endon("disconnect");
  self.var_11563 = [];
  for(;;) {
    var_0 = (self.origin[0], self.origin[1], self.origin[2] + 64);
    var_1 = self getplayerangles();
    var_2 = anglesToForward(var_1);
    var_3 = var_0 + var_2 * 10000;
    var_4 = bulletTrace(var_0, var_3, 1, self, 0, 0, 0, 0, 0);
    var_5 = var_4["entity"];
    if(isDefined(var_5) && isplayer(var_5) && var_5.team != self.team && scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_5)) {
      if(isDefined(var_5)) {
        func_12F36("ui_target_health", var_5.health);
      }

      if(isDefined(var_5)) {
        func_12F36("ui_target_max_health", var_5.maxhealth);
      }

      if(isDefined(var_5)) {
        func_12F36("ui_target_entity_num", var_5 getentitynumber());
      }
    } else {
      func_12F36("ui_target_entity_num", -1);
    }

    wait(0.1);
  }
}

func_12F36(var_0, var_1) {
  scripts\engine\utility::waitframe();
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(!isDefined(self.var_11563[var_0]) || var_1 != self.var_11563[var_0]) {
    self setclientomnvar(var_0, var_1);
    self.var_11563[var_0] = var_1;
  }
}