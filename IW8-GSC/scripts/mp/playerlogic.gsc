/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playerlogic.gsc
***********************************************/

function init() {
  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&onversusdone);
}

function timeuntilwavespawn(var_0) {
  if(!self.hasspawned) {
    return 0;
  }

  var_1 = gettime() + var_0 * 1000;
  var_2 = level.lastwave[self.pers["team"]];
  var_3 = level.wavedelay[self.pers["team"]] * 1000;
  var_4 = (var_1 - var_2) / var_3;
  var_5 = ceil(var_4);
  var_6 = var_2 + var_5 * var_3;

  if(isDefined(self.respawntimerstarttime)) {
    var_7 = (gettime() - self.respawntimerstarttime) / 1000;

    if(self.respawntimerstarttime < var_2) {
      return 0;
    }
  }

  if(isDefined(self.wavespawnindex)) {
    var_6 += 50 * self.wavespawnindex;
  }

  return (var_6 - gettime()) / 1000;
}

function teamkilldelay() {
  var_0 = self.pers["teamkills"];

  if(!isDefined(var_0) || level.maxallowedteamkills < 0 || var_0 <= level.maxallowedteamkills) {
    return 0;
  }

  var_1 = var_0 - level.maxallowedteamkills;
  return scripts\mp\tweakables::gettweakablevalue("team", "teamkillspawndelay") * var_1;
}

function timeuntilspawn(var_0) {
  if(level.ingraceperiod && !self.hasspawned || level.gameended) {
    return 0;
  }

  var_1 = 0;

  if(self.hasspawned) {
    var_2 = self[[level.onrespawndelay]]();

    if(isDefined(var_2)) {
      var_1 = var_2;
    } else {
      var_1 = getdvarfloat("scr_" + scripts\mp\utility\game::getgametype() + "_playerrespawndelay");
    }

    if(var_0 && isDefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"]) {
      var_1 += teamkilldelay();
    }

    if(isDefined(self.suicidespawndelay)) {
      var_1 += getdvarfloat("scr_" + scripts\mp\utility\game::getgametype() + "_suicidespawndelay");
    }

    if(isDefined(self.respawntimerstarttime) && !isDefined(level.spawndelay)) {
      var_3 = (gettime() - self.respawntimerstarttime) / 1000;
      var_1 -= var_3;

      if(var_1 < 0) {
        var_1 = 0;
      }
    }

    if(isDefined(self.setspawnpoint)) {
      var_1 += level.tispawndelay;
    }
  }

  var_4 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay") > 0;

  if(var_4) {
    var_1 = timeuntilwavespawn(var_1);
  }

  if(level.ingraceperiod && !self.hasspawned || level.gameended) {
    var_1 = 0;
  } else if(getdvarint("scr_cmd_camera_debug", 0) == 1) {
    var_1 = 999;
  }

  if(!isDefined(self.tiers)) {
    self.tiers = var_1;
  }

  return var_1;
}

function isdevelopmentspawningofbotclient(var_0) {
  return false;
}

function mayspawn() {
  if(istrue(level.nukegameover)) {
    return false;
  }

  if(scripts\mp\utility\game::getgametypenumlives() || isDefined(level.disablespawning)) {
    if(isDefined(level.teamswithplayers) && level.teamswithplayers.size == 1) {
      return true;
    }

    if(istrue(level.disablespawning)) {
      if(!isdevelopmentspawningofbotclient(self)) {
        return false;
      }
    }

    if(istrue(self.pers["teamKillPunish"])) {
      return false;
    }

    if(self.pers["lives"] <= 0 && scripts\mp\utility\game::gamehasstarted()) {
      return false;
    } else if(scripts\mp\utility\game::gamehasstarted()) {
      if(level.ingraceperiod && !self.hasspawned) {
        return true;
      }

      if(!level.ingraceperiod && !self.hasspawned && isDefined(level.allowlatecomers) && !level.allowlatecomers) {
        if(isDefined(self.siegelatecomer) && !self.siegelatecomer) {
          return true;
        }

        if(isdevelopmentspawningofbotclient(self)) {
          return true;
        }

        return false;
      }
    }
  }

  if(isDefined(level.loadoutdrop) && [[level.loadoutdrop]](self)) {
    return false;
  }

  return true;
}

function spawnclient(var_0) {
  self endon("becameSpectator");

  if(isDefined(level.ref_11c84)) {
    self[[level.ref_11c84]](var_0);
    return;
  }

  if(isDefined(self.pers["next_round_class"]) && !self.hasspawned) {
    self.class = self.pers["next_round_class"];
  }

  if(isDefined(self.waitingtoselectclass) && self.waitingtoselectclass) {
    self waittill("okToSpawn");
  }

  if(isDefined(self.addtoteam)) {
    scripts\mp\menus::addtoteam(self.addtoteam);
    self.addtoteam = undefined;
  }

  if(!mayspawn()) {
    waitframe();
    var_1 = self.origin;
    var_2 = self.angles;
    self notify("attempted_spawn");

    if(istrue(self.pers["teamKillPunish"])) {
      self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
      scripts\mp\utility\lower_message::setlowermessageomnvar(24);

      if(!self.hasspawned && self.pers["teamkills"] <= level.maxallowedteamkills) {
        self.pers["teamKillPunish"] = 0;
      }
    } else if(scripts\mp\utility\game::isroundbased() && game["finalRound"] == 0 || scripts\mp\utility\game::getgametypenumlives() != 0 && game["finalRound"] == 0 || istrue(level.disablespawning)) {
      var_3 = undefined;

      if(scripts\mp\utility\game::getgametype() != "arena" && isDefined(self.tagavailable) && self.tagavailable) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(8);
      } else if(istrue(self.revivetriggerblockedinremote) && level.teamdata[self.team]["aliveCount"] > 0) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(64);
      } else if(istrue(self.revivetriggeravailable)) {
        if(isDefined(self.timeuntilbleedout)) {
          if(isDefined(self.rallypoint)) {
            scripts\mp\utility\lower_message::setlowermessageomnvar(25, int(gettime() + self.timeuntilbleedout * 1000));
          } else if(!istrue(self.eliminated)) {
            scripts\mp\utility\lower_message::setlowermessageomnvar(6, int(gettime() + self.timeuntilbleedout * 1000));
          }
        } else if(level.teamdata[self.team]["aliveCount"] > 0) {
          scripts\mp\utility\lower_message::setlowermessageomnvar(64);
        } else {
          scripts\mp\utility\lower_message::setlowermessageomnvar(2);
        }
      } else if(scripts\mp\utility\game::getgametype() == "siege") {
        scripts\mp\utility\lower_message::setlowermessageomnvar(4);
        var_3 = 10;
      } else if(istrue(level.exfilstarted)) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(26);
      } else if(scripts\mp\utility\game::isroundbased()) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(2);
      } else if(scripts\mp\utility\game::getgametype() == "oic" && scripts\mp\utility\game::matchmakinggame()) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(78);
        var_3 = 30;
      } else {
        scripts\mp\utility\lower_message::setlowermessageomnvar(18);
        var_3 = 10;
      }

      if(!isDefined(self.revivetriggeravailable)) {
        thread removespawnmessageshortly(scripts\engine\utility::ter_op(isDefined(var_3), var_3, 6));
      }
    }

    if(self.sessionstate != "spectator") {
      var_1 += (0, 0, 60);
    }

    if(scripts\mp\utility\player::isusingremote()) {
      self.spawningafterremotedeath = 1;
      self.deathposition = self.origin;
      self waittill("stopped_using_remote");
    }

    if(!istrue(level.nukegameover)) {
      if(!scripts\mp\flags::gameflag("prematch_done")) {
        logstring("IWH-315293: DOLPHIN: can't spawn but prematch isn't over: " + self.name);
      }

      thread spawnspectator(var_1, var_2);
    }

    return;
  }

  if(self.waitingtospawn) {
    return;
  }

  self.waitingtospawn = 1;
  waitandspawnclient(var_2);

  if(isDefined(self)) {
    self.waitingtospawn = 0;
    return;
  }
}

function waittillcanspawnclient(var_0) {
  self endon("started_spawnPlayer");

  for(;;) {
    waitframe();

    if(self.team == "spectator" || self.team == "follower") {
      return;
    }

    if(isDefined(self) && (self.sessionstate == "spectator" || !scripts\mp\utility\player::isreallyalive(self))) {
      if(istrue(var_0)) {
        self.pers["teamKillPunish"] = 0;
      }

      self.pers["lives"] = 1;
      thread spawnclient(var_0);
      continue;
    }

    return;
  }
}

function waitandspawnclient(var_0) {
  self endon("disconnect");
  self endon("end_respawn");
  level endon("game_ended");
  self notify("attempted_spawn");

  if(isDefined(level.ref_12888)) {
    [[level.ref_12888]](var_0);
  }

  ref_1437c();
  var_1 = 0;

  if(istrue(self.pers["teamKillPunish"])) {
    var_2 = teamkilldelay();

    if(var_2 > 0) {
      scripts\mp\utility\lower_message::setlowermessageomnvar(65, int(gettime() + var_2 * 1000));
      thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
      var_1 = 1;
      wait var_2;
      scripts\mp\utility\lower_message::setlowermessageomnvar(0);
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
    scripts\mp\equipment\tac_insert::ref_13681(1);
  }

  var_3 = timeuntilspawn(0);
  var_4 = 0;

  if(!istrue(level.loadoutdefaultfiresalediscount)) {
    var_4 = scripts\engine\utility::ter_op(istrue(level.snaptospawncamera), 1.25, 2);
  }

  if(istrue(level.usespawnselection)) {
    var_4 = 0.5;
  }

  if(level.ingraceperiod && !self.hasspawned || level.gameended) {
    var_4 = 0;
    var_3 = 0;
  }

  var_5 = 0;

  if(scripts\mp\utility\game::getgametype() == "hq" && isDefined(level.zone) && level.zone.ownerteam == self.team) {
    var_5 = 1;
  }

  if(!istrue(self.skippedkillcam) && isDefined(self.killcamwatchtime) && !var_5) {
    if(isDefined(self.tiers)) {
      var_3 = max(self.tiers - self.killcamwatchtime, 0);
    } else {
      var_3 = max(var_3 - self.killcamwatchtime, 0);
    }

    self.killcamwatchtime = undefined;
  }

  if(isDefined(self.setspawnpoint)) {
    var_4 = 0;
    var_3 = 0;
  }

  var_3 = max(var_3, var_4);

  if(scripts\mp\arbitrary_up::isinarbitraryup()) {
    var_6 = self getworldupreferenceangles();
    var_7 = anglestoup(var_6);
    var_8 = var_7 * 60;
  } else {
    var_8 = (0, 0, 60);
  }

  var_9 = istrue(scripts\mp\flags::gameflag("prematch_done"));
  var_10 = scripts\mp\flags::gameflag("infil_will_run") && !istrue(scripts\mp\flags::gameflag("infil_started"));

  if(scripts\mp\utility\game::getgametype() == "arm" && !var_10 && !var_9) {
    var_11 = scripts\mp\gametypes\arm::getmissedinfilcamerapositions(self.team);
    var_12 = spawn("script_model", var_11.startorigin);
    var_12 setModel("tag_origin");
    var_12.angles = var_11.startangles;
    self cameralinkTo(var_12, "tag_origin");
    var_12 moveTo(var_11.endorigin, 18);
    var_12 rotateTo(var_11.endangles, 18);
    scripts\mp\flags::gameflagwait("prematch_done");
    var_9 = 1;
    self cameraunlink();
  }

  if(!istrue(level.loadoutdefaultfiresalediscount) && var_9 && !istrue(self.skipspawncamera) && !istrue(level.usespawnselection) && var_4 > 0) {
    thread scripts\mp\spawncamera::startspawncamera();
  }

  if(istrue(level.usespawnselection) && !isDefined(self.setspawnpoint)) {
    scripts\mp\spawnselection::waitforspawnselection(var_4, !istrue(var_9));
  } else if(var_4 > 0) {
    var_13 = 9;

    if(scripts\mp\utility\game::getgametype() == "hq") {
      if(isDefined(level.zone)) {
        if(level.zone.ownerteam == self.team) {
          scripts\mp\utility\dialog::leaderdialogonplayer("hp_dead");
          var_13 = 30;

          if(isDefined(self.suicidespawndelay)) {
            var_4 -= getdvarfloat("scr_hq_suicidespawndelay");
            var_4 = max(0, var_4);
          }
        } else if(isDefined(self.suicidespawndelay) && getdvarfloat("scr_hq_suicidespawndelay") > 0 && level.zone.ownerteam == "neutral") {
          var_13 = 31;
          self.suicidespawndelay = undefined;
        }
      }
    } else if(isDefined(self.suicidespawndelay) && getdvarfloat("scr_" + scripts\mp\utility\game::getgametype() + "_suicidespawndelay") > 0) {
      var_13 = 31;
      self.suicidespawndelay = undefined;
    }

    scripts\mp\utility\lower_message::setlowermessageomnvar(var_13, int(gettime() + var_4 * 1000));

    if(!var_3) {
      thread respawn_asspectator(self.origin + var_8, self.angles);
    }

    var_3 = 1;
    scripts\engine\utility::ref_143bf(var_4, "force_spawn");

    if(!istrue(self.waitingtoselectclass)) {
      self notify("stop_wait_safe_spawn_button");
    }
  }

  if(needsbuttontorespawn()) {
    if(!istrue(self.waitingtoselectclass)) {
      scripts\mp\utility\lower_message::setlowermessageomnvar(1);
    }

    if(!var_3) {
      thread respawn_asspectator(self.origin + var_8, self.angles);
    }

    var_3 = 1;
    waitrespawnbutton();
  }

  if(!istrue(level.loadoutdefaultfiresalediscount) || scripts\mp\utility\game::getgametype() == "arm") {
    thread scripts\mp\spawncamera::endspawncamera();
  }

  waitclassselected();

  if(isbot(self)) {
    if(!scripts\mp\bots\bots::bot_is_ready_to_spawn()) {
      self waittill("bot_ready_to_spawn");
    }
  }

  self.waitingtospawn = 0;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  self.wavespawnindex = undefined;
  thread spawnplayer(undefined, var_1);
}

function ref_1437c() {
  level endon("game_ended");
  self endon("disconnect");

  if(scripts\mp\utility\player::isusingremote()) {
    self.spawningafterremotedeath = 1;
    self.deathposition = self.origin;
    self waittill("stopped_using_remote");

    if(istrue(level.nukegameover)) {
      return;
    }

    return;
  }
}

function shouldwaitforsquadspawn() {
  return false;
}

function queueclientforsquadspawn() {
  while(!level.squaddata[self.team][self.squadindex].isfull && !level.squaddata[self.team][self.squadindex].isstale) {
    waitframe();
  }
}

function waitclassselected() {
  while(istrue(self.waitingtoselectclass)) {
    waitframe();
  }
}

function needsbuttontorespawn() {
  if(scripts\mp\tweakables::gettweakablevalue("player", "forcerespawn") != 0) {
    return false;
  }

  if(!self.hasspawned) {
    return false;
  }

  var_0 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay") > 0;

  if(var_0) {
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

  for(;;) {
    if(self useButtonPressed()) {
      break;
    }

    wait 0.05;
  }
}

function removespawnmessageshortly(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  waittillframeend();
  self endon("end_respawn");
  wait var_0;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

function tivalidationcheck() {
  if(!isDefined(self.setspawnpoint)) {
    return false;
  }

  if(isDefined(level.get_br_jugg_setting) && ![[level.get_br_jugg_setting]](self)) {
    return false;
  }

  var_0 = getEntArray("care_package", "targetname");

  foreach(var_2 in var_0) {
    if(distancesquared(var_2.origin, self.setspawnpoint.playerspawnpos) > 4096) {
      continue;
    }

    if(isDefined(var_2.owner)) {
      scripts\mp\hud_message::showsplash("destroyed_insertion", undefined, var_2.owner);
    }

    scripts\mp\equipment\tac_insert::ref_13681();
    return false;
  }

  var_4 = (30, 30, 80);
  var_5 = self.setspawnpoint.playerspawnpos - var_4;
  var_6 = self.setspawnpoint.playerspawnpos + var_4;
  var_7 = physics_createcontents(["physicscontents_vehicle"]);
  var_8 = [];
  var_9 = physics_aabbbroadphasequery(var_5, var_6, var_7, var_8);

  if(isDefined(var_9) && var_9.size > 0) {
    var_10 = 1;

    foreach(var_12 in var_9) {
      var_13 = var_12.code_classname == "scriptable" || var_12.code_classname == "worldspawn";

      if(!var_13) {
        var_10 = 0;
        break;
      }
    }

    if(!var_10) {
      return false;
    }
  }

  var_15 = self.setspawnpoint.playerspawnpos + (0, 0, 60);
  var_16 = self.setspawnpoint.playerspawnpos + (0, 0, 1);
  var_17 = [];
  GscBinSkip0(0x2e, 0, self);
}

function revivespawnvalidationcheck() {
  if(!isDefined(self.forcespawnorigin)) {
    return false;
  }

  var_0 = spawnStruct();
  var_0.ref_1368a = self.forcespawnorigin;
  var_0.vandalize_spotlight_speed = 1;
  var_1 = [];
  GscBinSkip0(0x2e, 0, self);
}

function spawningclientthisframereset() {
  self notify("spawningClientThisFrameReset");
  self endon("spawningClientThisFrameReset");
  waitframe();
  level.numplayerswaitingtospawn--;
}

function getplayerassets(var_0) {
  var_1 = spawnStruct();

  if(isDefined(var_0.loadoutprimaryfullname) && var_0.loadoutprimaryfullname != "none") {
    var_1.primaryweapon = var_0.loadoutprimaryfullname;
  }

  if(isDefined(var_0.loadoutsecondaryfullname) && var_0.loadoutsecondaryfullname != "none") {
    var_1.secondaryweapon = var_0.loadoutsecondaryfullname;
  }

  var_2 = scripts\mp\teams::getcustomization();

  if(isDefined(var_2["body"])) {
    var_1.body = var_2["body"];
  }

  if(isDefined(var_2["head"])) {
    var_1.head = var_2["head"];
  }

  return var_1;
}

function loadplayerassets(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isDefined(var_5.primaryweapon)) {
      var_3 = var_5.primaryweapon;
    }

    if(isDefined(var_5.secondaryweapon)) {
      var_3 = var_5.secondaryweapon;
    }

    if(!istrue(var_2)) {
      self loadcustomization(var_5.body, var_5.head, var_1);
    }
  }

  if(var_3.size > 0) {
    self loadweaponsforplayer(var_3, var_1);
    return;
  }
}

function allplayershaveassetsloaded(var_0) {
  var_1 = [];

  if(isDefined(var_0.primaryweapon)) {
    GscBinSkip0(0x2e, var_1.size, var_0.primaryweapon);
  }

  if(isDefined(var_0.secondaryweapon)) {
    GscBinSkip0(0x2e, var_1.size, var_0.secondaryweapon);
  }

  if(!self hasloadedviewweapons(var_1)) {
    return false;
  }

  if(!self hasloadedcustomizationviewmodels(var_0.body)) {
    return false;
  }

  return true;
}

function getspawnpoint() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  self.ti_spawn = 0;

  if(getdvarint("scr_useProfileSpawn", 0) != 0) {
    var_3 = getspawnarray("mp_tdm_spawn_allies_start");
    var_0 = var_3[0];
    var_1 = var_0.origin;
    var_2 = var_0.angles;
  } else if(isDefined(self.forcespawnorigin)) {
    var_4 = revivespawnvalidationcheck();

    if(!var_4.vandalize_spotlight_speed && isDefined(self.prevrevivepos) && !isDefined(self.rallypoint)) {
      var_1 = self.prevrevivepos;
    } else {
      var_1 = self.forcespawnorigin;
      self.forcespawnorigin = undefined;
    }

    if(isDefined(self.forcespawnangles)) {
      var_2 = self.forcespawnangles;
      self.forcespawnangles = undefined;
    } else {
      var_2 = (0, randomfloatrange(0, 360), 0);
    }

    if(isDefined(self.reviver)) {
      if(positionwouldtelefrag(var_1) || !var_4.vandalize_spotlight_speed) {
        var_0 = scripts\mp\spawnscoring::findteammatebuddyspawn(self.reviver);
        self.reviver = undefined;

        if(isDefined(var_0)) {
          var_1 = var_0.origin;
          var_2 = var_0.angles;
        }
      } else {
        var_1 = var_4.ref_1368a;
      }
    }
  } else if(isDefined(self.setspawnpoint)) {
    var_0 = self.setspawnpoint;

    if(!istrue(self.setspawnpoint.notti)) {
      if(istrue(level.unset_relic_laststandmelee) && level.mapname != "mp_aniyah") {
        self.ref_11d9e = undefined;
        var_5 = scripts\engine\utility::ter_op(istrue(level.brmini_playerwelcomesplashes), 1, istrue(self.setspawnpoint.issuper));

        if(var_5) {
          var_6 = min(level.steam_fx_on - self.setspawnpoint.playerspawnpos[2], level.steam_fx_on);

          if(var_6 < level.steam_fx_on - 950) {
            var_6 += 950;
          }

          self.setspawnpoint.playerspawnpos += (0, 0, var_6);
          self.updatearenaomnvardata = 1;
        }
      }

      self.ti_spawn = 1;
      self playlocalsound("tactical_spawn");

      if(level.teambased) {
        foreach(var_8 in level.teamnamelist) {
          if(var_8 != self.team) {
            self playsoundtoteam("tactical_spawn", var_8);
          }
        }
      } else {
        self playSound("tactical_spawn");
      }
    }

    foreach(var_11 in level.ugvs) {
      if(distancesquared(var_11.origin, var_0.playerspawnpos) < 1024) {
        var_11 notify("damage", 5000, var_11.owner, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, getcompleteweaponname("killstreak_jammer_mp"));
      }
    }

    var_1 = self.setspawnpoint.playerspawnpos;
    var_2 = self.setspawnpoint.playerspawnangles;
    scripts\mp\equipment\tac_insert::ref_13681(0, 1);
    var_0 = undefined;
  } else if(istrue(level.usespawnselection) && istrue(scripts\mp\flags::gameflag("prematch_done"))) {
    var_0 = scripts\mp\spawnselection::getspawnpoint();
    var_1 = var_0.origin;
    var_2 = var_0.angles;
  } else {
    var_0 = self[[level.getspawnpoint]]();
    var_1 = var_0.origin;
    var_2 = var_0.angles;
  }

  var_13 = spawnStruct();
  var_13.spawnpoint = var_0;
  var_13.spawnorigin = var_1;

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_13.spawnangles = (0, var_2[1], 0);
  return var_13;
}

function spawnplayer(var_0, var_1) {
  self endon("disconnect");
  self endon("joined_spectators");
  self notify("spawned");
  self notify("end_respawn");
  self notify("started_spawnPlayer");

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(scripts\mp\utility\game::teamhasinfil(self.team) && !scripts\mp\flags::gameflag("infil_started") && !isDefined(level.bypassclasschoicefunc)) {
    if(getdvarint("scr_force_cac_sre_callstack", 0) == 1 && scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "sandbox" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
      var_2 = scripts\mp\utility\game::teamhasinfil(self.team);
      var_3 = scripts\mp\flags::gameflag("infil_started");
      var_4 = isDefined(level.bypassclasschoicefunc);
      scripts\mp\utility\script::laststand_dogtags("spawnPlayer()" + self.name + " ui_options_menu = 2, hasInfil = " + var_2 + " infil_started = " + var_3 + "bypassClassChoiceFunc = " + var_4);
    }

    self setclientomnvar("ui_options_menu", 2);
  } else if(!isDefined(game["state"]) || game["state"] != "playing") {
    self setclientomnvar("ui_options_menu", 0);
  }

  scripts\mp\utility\game::checkrealismhudsettings();
  self setclientomnvar("ui_hud_shake", 0);
  self.lastkillsplash = undefined;
  self.ref_1363e = undefined;
  self.scorestreakvariantattackerinfo = undefined;
  self.cratemantle = undefined;

  if(getdvarint("scr_game_forceuav") > 1) {
    level thread scripts\cp_mp\killstreaks\uav::setforceradars(self);
  }

  level.numplayerswaitingtospawn++;

  if(level.numplayerswaitingtospawn > 1) {
    self.waitingtospawnamortize = 1;
    wait level.framedurationseconds * (level.numplayerswaitingtospawn - 1);
  }

  thread spawningclientthisframereset();
  self.waitingtospawnamortize = 0;
  jumpiftrue(isDefined(self.pers["copiedClass"])) LOC_000001df;
  var_6 = scripts\mp\class::preloadandqueueclass(self.class, 1);
  goto LOC_00000257;
}

function ref_119cb(var_0) {
  if(isDefined(var_0)) {
    self dlog_recordplayerevent("dlog_event_loadout_copy", ["receiver_player_client_id", self.clientid, "receiver_gamertag", self.name, "giver_player_client_id", var_0.clientid, "giver_gamertag", var_0.name]);
    return;
  }
}

function logstartingloadout() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  if(isDefined(self.curclass) && self.curclass != "juggernaut") {
    scripts\mp\class::loadout_lognewlygivenloadout(self.select_bridge_two_spawners, self.classstruct, self.curclass);
    return;
  }
}

function notifyreviveregen() {
  self endon("disconnect");
  waitframe();
  self notify("force_regeneration");
}

function setspawnnotifyomnvar() {
  self endon("disconnect");
  waitframe();
  self setclientomnvar("ui_player_spawned_notify", gettime());
}

function playerprematchallow(var_0) {
  self allowmovement(var_0);
  scripts\common\utility::allow_fire(var_0, "prematch");
  scripts\mp\equipment::allow_equipment(var_0, "prematch");
  scripts\common\utility::allow_supers(var_0, "prematch");
  scripts\common\utility::allow_jump(var_0, "prematch");
  scripts\common\utility::allow_melee(var_0, "prematch");
  scripts\common\utility::allow_sprint(var_0, "prematch");
  scripts\common\utility::allow_killstreaks(var_0, "prematch");

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(var_0, "prematch");
    scripts\common\utility::allow_mount_side(var_0, "prematch");
    return;
  }
}

function allowprematchlook(var_0) {
  var_0[[level.prematchallowfunc]](0);
  var_0.prematchlook = 1;
}

function clearprematchlook(var_0) {
  if(istrue(var_0.prematchlook) && !level.gameended) {
    var_0[[level.prematchallowfunc]](1);
    var_0.prematchlook = undefined;
    return;
  }
}

function waitforversusmenudone() {
  level endon("prematch_over");
  self endon("versus_menu_done");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "versus_done") {
      self notify("versus_menu_done");
    }
  }
}

function ref_13ffb(var_0) {
  var_0 endon("death_or_disconnect");

  for(;;) {
    var_0 getbeingrevived();
    var_0 getmid2damage();
    wait 0.05;
  }
}

function spawnspectatormapcam(var_0) {
  var_1 = 6;
  var_2 = 4;
  var_3 = 4;
  var_4 = 0;
  self endon("disconnect");

  if(isai(self)) {
    return;
  }

  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("cg_fovScale", "0.65");
  } else {
    self setclientdvars("cg_fovScale", "1");
  }

  self setclientomnvar("ui_mapshot_camera", 1);
  self lerpfovbypreset("mapflyover");
  var_5 = scripts\engine\utility::getStructArray("camera_intro", "targetname");

  switch (level.mapname) {
    case "mp_village2":
      var_5[0].origin = (1606.95, 2238.61, 958.77);
      var_5[0].angles = (17, 215, -4.14);
      break;
    case "mp_backlot2":
      var_5[0].origin = (310, -627, 279);
      var_5[0].angles = (4, 196, 0);
      break;
    case "mp_hideout":
      var_5[0].origin = (1867, -2487, 664);
      var_5[0].angles = (15, 118, 0);
      break;
    case "mp_crash2":
      var_5[0].origin = (-856, 2771, 1030);
      var_5[0].angles = (18, 313, 0);
      break;
    case "mp_m_king":
      var_5[0].origin = (691, -536, 223);
      var_5[0].angles = (9, 159, 0);
      GscBinSkip0(0x2e, 1, spawnStruct());

    case "mp_m_pine":
      var_5[0].origin = (1260, 203, 239);
      var_5[0].angles = (15, 189, 0);
      GscBinSkip0(0x2e, 1, spawnStruct());

    case "mp_m_showers":
      var_5[0].origin = (2446, 19, 377);
      var_5[0].angles = (24, 178, 0);
      GscBinSkip0(0x2e, 1, spawnStruct());

    case "mp_m_hill":
      var_5[0].origin = (254, 1651, 353);
      var_5[0].angles = (10, 253, 0);
      GscBinSkip0(0x2e, 1, spawnStruct());
  }

  if(var_5.size == 0 || scripts\mp\flags::gameflag("infil_will_run")) {
    self visionsetfadetoblackforplayer("", 0.75);
    return;
  }

  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  setspawnvariables();
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\utility\player::updatesessionstate("spectator");
  self.pers["team"] = "spectator";
  self.team = "spectator";
  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonspectate();

  foreach(var_11, var_10 in level.teamnamelist) {
    self allowspectateteam(var_10, 0);
  }

  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);

  if(isDefined(var_5) && var_5.size > 1 && !istrue(var_4)) {
    var_12 = randomintrange(0, var_5.size - 1);
    var_6 = var_5[var_12];
  } else if(isDefined(var_5)) {
    var_6 = var_5[0];

    if(istrue(var_4)) {
      var_8 = var_5[1];
    }
  }

  var_6.fil = 1;
  scripts\mp\utility\player::_freezecontrols(1, undefined, "spectatorMapCam");
  self setspectatedefaults(var_6.origin, var_6.angles);
  self spawn(var_6.origin, var_6.angles);
  scripts\mp\utility\player::ref_12898("playerlogic::spawnSpectatorMapCam() !!!CODE SPAWN!!! @" + var_6.origin);
  var_13 = spawn("script_model", var_6.origin);
  var_13 setModel("tag_origin");
  var_13.angles = var_6.angles;
  var_14 = undefined;

  if(istrue(var_4)) {
    var_14 = spawn("script_model", var_8.origin);
    var_14 setModel("tag_origin");
    var_14.angles = var_8.angles;
  }

  thread waitforversusmenudone();

  if(isDefined(var_0) && var_0 == 99) {
    var_15 = "debug";
  } else if(scripts\mp\flags::gameflag("prematch_done")) {
    var_15 = "prematch_over";
  } else if(self.versusdone) {
    var_15 = "versus_menu_done";
  } else {
    var_15 = scripts\engine\utility::ref_143ba(2, "versus_menu_done", "prematch_over");
  }

  if(var_15 == "timeout") {
    if(scripts\mp\flags::gameflag("prematch_done")) {
      var_15 = "prematch_over";
    } else {
      var_15 = "versus_menu_done";
    }
  }

  if(var_15 == "prematch_over") {
    self visionsetfadetoblackforplayer("", 0.75);
    return;
  }

  if(self issplitscreenplayer() && self issplitscreenplayerprimary()) {
    var_16 = self getothersplitscreenplayer();
    var_16 notify("versus_menu_done");
    waitframe();
  }

  self cameralinkTo(var_15, "tag_origin", 1);
  var_17 = scripts\cp_mp\utility\game_utility::getmapname();
  self notify("mapCamera_start");

  switch (var_17) {
    case "mp_parkour":
      var_15 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_parkour");
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait var_4 - 0.25;
      return;
    default:
      break;
  }

  wait 0.25;
  self visionsetfadetoblackforplayer("", 0.75);
  self playlocalsound("mp_camera_intro_whoosh");
  var_18 = var_9;
  var_10 = spawnStruct();
  var_10 = scripts\engine\utility::getStruct(var_9.target, "targetname");

  switch (level.mapname) {
    case "mp_village2":
      var_10[0].origin = (1925, -857, 1033);
      var_10[0].angles = (362, 127, 0);
      break;
    case "mp_backlot2":
      var_10[0].origin = (-399, -1457, 667);
      var_10[0].angles = (15, 57, 0);
      break;
    case "mp_hideout":
      var_10[0].origin = (1422, 2073, 464);
      var_10[0].angles = (6, 236, 0);
      break;
    case "mp_crash2":
      var_10[0].origin = (1559, 1586, 1030);
      var_10[0].angles = (30, 234, 0);
      break;
    case "mp_m_king":
      var_10[0].origin = (921, 300, 223);
      var_10[0].angles = (8, 202, 0);
      var_10 = spawnStruct();
      var_10[1].origin = (415, 372, 14);
      var_10[1].angles = (3, 179, 0);
      break;
    case "mp_m_pine":
      var_10[0].origin = (714, 440, 167);
      var_10[0].angles = (13, 205, 0);
      var_10 = spawnStruct();
      var_10[1].origin = (-859, -349, 75);
      var_10[1].angles = (7, 104, 0);
      break;
    case "mp_m_showers":
      var_10[0].origin = (1952, 354, 77);
      var_10[0].angles = (6, 208, 0);
      var_10 = spawnStruct();
      var_10[1].origin = (906, 9, 15);
      var_10[1].angles = (0, 0, 0);
      var_7 = 1;
      break;
    case "mp_m_hill":
      var_10[0].origin = (-1332, 483, 252);
      var_10[0].angles = (11, 313, 0);
      var_10 = spawnStruct();
      var_10[1].origin = (65, -547, 351);
      var_10[1].angles = (16, 83, 0);
      break;
  }

  var_19 = 0;

  for(;;) {
    if(isDefined(var_18.speedadjust)) {
      var_20 = 1 / var_18.speedadjust;
      var_21 = var_20 * distance(var_18.origin, var_10[0].origin);
    } else {
      var_21 = distance(var_18.origin, var_10[0].origin);
    }

    var_19 += var_21;
    var_18.distancetotarg = var_21;
    var_18 = var_10[0];

    if(isDefined(var_18.target)) {
      var_10 = scripts\engine\utility::getStruct(var_18.target, "targetname");
      continue;
    }

    break;
  }

  var_18.eol = 1;
  var_18 = var_9;
  var_10 = scripts\engine\utility::getStruct(var_9.target, "targetname");

  for(;;) {
    var_22 = var_18.distancetotarg / var_19;
    var_23 = scripts\engine\utility::ter_op(istrue(var_7), var_22 * var_5, var_22 * var_4);

    if(isDefined(var_10[0].eol)) {
      var_24 = var_23 / 2;
    } else {
      var_24 = 0;
    }

    if(isDefined(var_18.fil)) {
      var_25 = var_23 / 2;
    } else {
      var_25 = 0;
    }

    var_15 moveTo(var_10[0].origin, var_23, var_25, var_24);
    var_15 rotateTo(var_10[0].angles, var_23, var_25, var_24);

    if(isDefined(var_10[0].eol)) {
      var_26 = int(var_23 / 2);
      wait var_26;
      wait var_26;
    } else {
      wait var_23;
    }

    var_18 = var_10[0];

    if(isDefined(var_18.target)) {
      var_10 = scripts\engine\utility::getStruct(var_18.target, "targetname");
      continue;
    }

    break;
  }

  if(istrue(var_7)) {
    var_19 = 0;
    var_27 = var_11;
    self spawn(var_11.origin, var_11.angles);
    self cameralinkTo(var_15, "tag_origin", 1);
    wait 0.25;
    self visionsetfadetoblackforplayer("", 0.75);
    self playlocalsound("mp_camera_intro_whoosh");

    for(;;) {
      if(isDefined(var_27.speedadjust)) {
        var_20 = 1 / var_27.speedadjust;
        var_21 = var_20 * distance(var_27.origin, var_10[1].origin);
      } else {
        var_21 = distance(var_27.origin, var_10[1].origin);
      }

      var_19 += var_21;
      var_27.distancetotarg = var_21;

      if(isDefined(var_27.target)) {
        var_10 = scripts\engine\utility::getStruct(var_18.target, "targetname");
        continue;
      }

      break;
    }

    var_27.eol = 1;
    var_27.fil = 1;
    var_10[1].eol = 1;

    for(;;) {
      var_22 = var_27.distancetotarg / var_19;
      var_23 = scripts\engine\utility::ter_op(istrue(var_7), var_22 * var_6, var_22 * var_4);

      if(isDefined(var_10[1].eol)) {
        var_24 = var_23 / 2;
      } else {
        var_24 = 0;
      }

      if(isDefined(var_27.fil)) {
        var_25 = var_23 / 2;
      } else {
        var_25 = 0;
      }

      var_15 moveTo(var_10[1].origin, var_23, var_25, var_24);
      var_15 rotateTo(var_10[1].angles, var_23, var_25, var_24);

      if(isDefined(var_10[1].eol)) {
        var_26 = int(var_23 / 2);
        wait var_26;
        wait var_26;
      } else {
        wait var_23;
      }

      var_27 = var_10[1];

      if(isDefined(var_27.target)) {
        var_10 = scripts\engine\utility::getStruct(var_27.target, "targetname");
        continue;
      }

      break;
    }
  }

  scripts\mp\utility\player::_freezecontrols(0, undefined, "spectatorMapCam");
  self.startcament = var_15;
  self setclientomnvar("ui_mapshot_camera", 0);
}

function spawnspectator(var_0, var_1, var_2) {
  self notify("spawned");
  self notify("end_respawn");
  self notify("joined_spectators");
  level notify("joined_spectators", self);
  self.ref_1363e = 1;

  if(isDefined(self.deathspectatepos)) {
    var_0 = self.deathspectatepos;
    var_1 = vectortoangles(self.origin - self.deathspectatepos);
  }

  if(isDefined(self.startcament) && !isDefined(var_0)) {
    var_0 = self.startcament.origin;
    var_1 = self.startcament.angles;
    self.startcament delete();
  }

  in_spawnspectator(var_0, var_1, var_2);
}

function respawn_asspectator(var_0, var_1) {
  if(isDefined(self.deathspectatepos)) {
    var_0 = self.deathspectatepos;

    if(isDefined(self.deathspectateangles)) {
      var_1 = self.deathspectateangles;
    } else {
      var_1 = vectortoangles(self.origin - self.deathspectatepos);
    }
  }

  in_spawnspectator(var_0, var_1);
}

function in_spawnspectator(var_0, var_1, var_2) {
  setspawnvariables();
  var_3 = self.pers["team"];

  if(isDefined(var_3) && (var_3 == "spectator" || var_3 == "follower") && !level.gameended) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }

  scripts\mp\class::loadout_clearperks();
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonspectate();
  scripts\mp\spectating::setspectatepermissions();
  onspawnspectator(var_0, var_1, var_2);

  if(level.teambased && !level.splitscreen && !self issplitscreenplayer()) {
    scripts\mp\utility\player::setdof_spectator();
    return;
  }
}

function getplayerfromclientnum(var_0) {
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

function onspawnspectator(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1)) {
    self setspectatedefaults(var_0, var_1);
    self spawn(var_0, var_1);
    scripts\mp\utility\player::ref_12898("playerlogic::onSpawnSpectator() !!!CODE SPAWN!!! @" + var_0);
    return;
  }

  var_3 = getspectatepoint();

  if(istrue(level.usespawnselection)) {
    if(self.sessionteam == "allies") {
      var_3 = level.spawncameras["gw_fob_alliesHQ"]["allies"];
    } else if(self.sessionteam == "axis") {
      var_3 = level.spawncameras["gw_fob_axisHQ"]["axis"];
    }
  }

  var_4 = 8;

  if(isDefined(level.camerapos) && level.camerapos.size) {
    for(var_5 = 0; var_5 < level.camerahighestindex + 1 && var_5 < var_4; var_5++) {
      if(!isDefined(level.camerapos[var_5]) || !isDefined(level.cameraang[var_5])) {
        continue;
      }

      self setmlgcameradefaults(var_5, level.camerapos[var_5], level.cameraang[var_5]);
      level.cameramapobjs[var_5].origin = level.camerapos[var_5];
      level.numbermapobjs[var_5].origin = level.camerapos[var_5];
      level.cameramapobjs[var_5].angles = level.cameraang[var_5];
      level.numbermapobjs[var_5].angles = level.cameraang[var_5];
    }
  } else {
    for(var_5 = 0; var_5 < var_5; var_5++) {
      self setmlgcameradefaults(var_5, var_4.origin, var_4.angles);
    }
  }

  self setspectatedefaults(var_4.origin, var_4.angles);

  if(isDefined(var_3)) {
    self allowspectateteam("freelook", 1);
    self allowspectateteam("none", 1);
  }

  if(scripts\mp\utility\game::unset_relic_landlocked() && !self.hasspawned) {
    self predictstreampos(var_4.origin);
  }

  self spawn(var_4.origin, var_4.angles);
  scripts\mp\utility\player::ref_12898("playerlogic::onSpawnSpectator() !!!CODE SPAWN!!! @" + var_4.origin);
}

function getspectatepoint() {
  var_0 = getEntArray("mp_global_intermission", "classname");
  var_1 = [];

  if(scripts\mp\utility\game::getgametype() == "brtdm") {
    return level.endsuperdisableweaponbr.ref_136dc;
  }

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    if(level.localeid == "locale_6") {
      var_2 = spawn("script_origin", (25642, -26550, 1818));
      var_2.angles = (14, 101, 0);
      return var_2;
    } else if(level.localeid == "locale_3") {
      var_2 = spawn("script_origin", (34440, -18522, 995));
      var_2.angles = (10, 281, 0);
      return var_2;
    }

    var_2 = undefined;

    foreach(var_4 in var_2) {
      if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == level.localeid) {
        var_2 = var_4;
      }
    }

    if(isDefined(var_2)) {
      return var_2;
    } else {
      foreach(var_4 in var_2) {
        if(!isDefined(var_4.script_noteworthy) || !issubstr(var_4.script_noteworthy, "locale")) {
          var_2 = var_4;
          continue;
        }

        var_4 delete();
      }
    }
  } else if(var_2.size != 1) {
    foreach(var_4 in var_2) {
      if(!isDefined(var_4.script_noteworthy) || !issubstr(var_4.script_noteworthy, "locale")) {
        var_2 = var_4;
        continue;
      }

      var_4 delete();
    }
  } else {
    var_2 = var_2;
  }

  var_4 = scripts\mp\spawnlogic::getspawnpoint_random(var_2);
  return var_4;
}

function spawnintermission(var_0, var_1, var_2) {
  self endon("disconnect");
  self notify("spawned");
  self notify("end_respawn");

  if(!isDefined(var_1)) {
    var_1 = "intermission";
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  setspawnvariables();
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\utility\lower_message::clearlowermessages();
  scripts\mp\utility\player::_freezecontrols(1, undefined, "spawnIntermission");

  if(var_2) {
    self setclientdvar("cg_everyoneHearsEveryone", 1);
  }

  if(isDefined(level.finalkillcam_winner) && level.finalkillcam_winner != "none" && isDefined(level.match_end_delay) && scripts\mp\utility\game::waslastround() && !istrue(level.doingbroshot)) {
    wait level.match_end_delay;
  }

  if(!istrue(level.doingbroshot)) {
    scripts\mp\utility\player::updatesessionstate(var_1);
  }

  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;

  if(!isDefined(var_0)) {
    if(!isDefined(level.localeid)) {
      var_3 = getEntArray("mp_global_intermission", "classname");
      var_3 = scripts\mp\spawnscoring::checkdynamicspawns(var_3);
      var_0 = var_3[0];
    } else {
      var_0 = getspectatepoint();
    }
  }

  if(!isDefined(level.custom_ending)) {
    self spawn(var_0.origin, var_0.angles);
    scripts\mp\utility\player::ref_12898("playerlogic::spawnIntermission() !!!CODE SPAWN!!! @" + var_0.origin);
    scripts\mp\utility\player::setdof_spectator();
  }

  scripts\mp\utility\player::_freezecontrols(1, undefined, "spawnIntermission");
}

function spawnendofgame() {
  if(isDefined(level.ref_11c85) && self[[level.ref_11c85]]()) {
    return;
  }

  if(isDefined(level.custom_ending) && scripts\mp\utility\game::waslastround()) {
    level notify("start_custom_ending");
  }

  if(!istrue(self.controlsfrozen)) {
    scripts\mp\utility\player::_freezecontrols(1, undefined, "spawnEndOfGame");
  }

  if(istrue(level.doingbroshot)) {
    self notify("spawned");
    scripts\mp\utility\player::clearkillcamstate();
    return;
  }

  spawnspectator();
}

function setspawnvariables() {
  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
  self stoprumble("damage_heavy");
  self.deathposition = undefined;
}

function callback_playerdisconnect(var_0) {
  if(!isDefined(self.connected)) {
    return;
  }

  self.locationtriggersetpaused = 1;

  if(scripts\mp\utility\game::getgametype() == "br" && self isinexecutionvictim() && isalive(self)) {
    var_1 = self scriptablecanbepinged();

    if(!isbot(self)) {
      var_2 = self.health;

      if(scripts\mp\damage::ref_1331e(self)) {
        var_1 scripts\mp\utility\stats::incpersstat("damage", var_2);

        if(!isDefined(var_1.isbecomingzombie)) {
          var_1.isbecomingzombie = var_2;
        } else {
          var_1.isbecomingzombie += var_2;
        }
      } else if(isDefined(level.ref_12001)) {
        var_1[[level.ref_12001]](var_2);
      }

      var_1 scripts\mp\gametypes\br_public::updatebrscoreboardstat("damageDealt", var_1.pers["damage"]);
      self kill(self.origin, var_1, var_1, "MOD_EXECUTION");
      self notify("disconnect");
    }
  }

  if(getdvarint("online_matchdata_enabled") != 0) {
    var_3 = getmatchdata("commonMatchData", "player_count_left");
    var_3++;
    setmatchdata("commonMatchData", "player_count_left", var_3);
  }

  var_4 = undefined;

  if(scripts\mp\utility\game::getgametype() == "br") {
    if(istrue(self.pers["hasDoneAnyCombat"]) || istrue(self.pers["participation"])) {
      var_4 = "eliminated";
    }

    if(scripts\mp\utility\game::round_vehicle_logic() == "br") {
      var_5 = [];

      foreach(var_7 in scripts\mp\utility\teams::getenemyteams(self.team)) {
        if(scripts\mp\utility\teams::getteamdata(var_7, "aliveCount")) {
          var_5 = var_7;
        }
      }

      var_9 = var_5.size + 1;
      scripts\cp_mp\utility\game_utility::ref_13168(var_9);
    }
  }

  if(isDefined(level.music_timer_10seconds)) {
    var_4 = level.music_timer_10seconds;
  }

  scripts\cp_mp\utility\game_utility::stopkeyearning(var_4);

  if(scripts\mp\utility\killstreak::iscontrollingproxyagent()) {
    self restorecontrolagent();
  }

  removeplayerondisconnect();
  scripts\mp\spawnlogic::removefromparticipantsarray();
  scripts\mp\spawnlogic::removefromcharactersarray();
  scripts\cp_mp\utility\player_utility::ref_12c03();
  var_10 = self getentitynumber();

  if(!level.teambased) {
    game["roundsWon"][self.guid] = undefined;
  }

  if(level.splitscreen) {
    var_11 = level.players;

    if(var_11.size <= 1) {
      level thread scripts\mp\gamelogic::forceend();
    }
  }

  if(isDefined(self.kills) && isDefined(self.deaths)) {
    if(scripts\mp\utility\game::getgametype() == "arena" && 3 > self.timeplayed["total"]) {
      if(!isDefined(self.arenadamage)) {
        return;
      }

      var_12 = self.arenadamage;
      setplayerteamrank(self, self.clientid, var_12);
    } else if(120 < self.timeplayed["total"]) {
      var_13 = (self.kills - self.deaths) / self.timeplayed["total"] / 60;
      setplayerteamrank(self, self.clientid, var_13);
    }
  }

  var_14 = self getentitynumber();
  var_15 = self.guid;
  logprint("Q;" + var_15 + ";" + var_14 + ";" + self.name + "\n");

  if(drawentitybounds()) {
    analyticsstreamerlogfiletagplayer("Q;" + var_15 + ";" + var_14 + ";" + self.name + "\n");
  }

  thread scripts\mp\events::disconnected();

  if(level.gameended) {
    scripts\mp\gamescore::removedisconnectedplayerfromplacement();
  }

  if(isDefined(self.team)) {
    removefromteamcount();
  }

  scripts\cp_mp\utility\weapon_utility::clearlockedonondisconnect(self);

  if(isDefined(self.team) && isDefined(self.squadindex) && self.team != "spectator" && self.team != "follower") {
    scripts\mp\menus::leavesquad(self.team, self.squadindex);
  }

  if(self.sessionstate == "playing" && !(isDefined(self.fauxdead) && self.fauxdead)) {
    removefromalivecount(1, "disconnect1");
  } else if(self.sessionstate != "playing" && scripts\mp\utility\game::getgametype() == "br" && (scripts\mp\gametypes\br_public::iswaitingtoentergulag(self) || scripts\mp\gametypes\br_public::update_current_solution(self) || scripts\mp\gametypes\br_public::use_csm(self))) {
    removefromalivecount(1, "disconnect2");
  } else if(self.sessionstate == "intermission" && isDefined(self.team) && scripts\engine\utility::array_contains(level.teamdata[self.team]["alivePlayers"], self)) {
    removefromalivecount(1, "disconnect3");
  } else if(self.sessionstate == "spectator" || self.sessionstate == "dead") {
    if(isDefined(self.team) && scripts\engine\utility::array_contains(level.teamdata[self.team]["alivePlayers"], self)) {
      removefromalivecount(1, "disconnect4");
    }

    level thread[[level.updategameevents]]();
  }

  if(isDefined(self.team)) {
    scripts\mp\utility\teams::ref_140c9("disconnect", self.team, self);
  }

  scripts\mp\utility\disconnect_event_aggregator::rundisconnectcallbacks(self);
  scripts\mp\gamelogic::updatematchhasmorethan1playeromnvaronplayerdisconnect();
  scripts\common\utility::ref_13e0a(level.ref_11b2c, var_0);

  if(level.players.size == 0) {
    thread mp_oilrig_patches();
    return;
  }
}

function mp_oilrig_patches() {
  level notify("endEmptyGameWatcher");
  level endon("endEmptyGameWatcher");
  level endon("connected");
  var_0 = getdvarfloat("scr_disconnect_shutdown_amnesty_time", 30);
  wait var_0;

  if(scripts\mp\utility\game::getgametype() == "br" && getdvarint("scr_data_force_send_matchdata_for_no_players_left", 1) == 1 && istrue(level.br_prematchstarted)) {
    scripts\mp\gamelogic::ref_1301f();
  }

  thread scripts\mp\gamelogic::endgame(undefined, game["end_reason"]["host_ended_game"]);
}

function removeplayerondisconnect() {
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

  if(!isbot(self)) {
    level.playercustomizationdata[self getentitynumber()] = undefined;
  }

  level.playersbyentitynumber[self getentitynumber()] = undefined;
}

function initclientdvarssplitscreenspecific() {
  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("cg_fovScale", "0.75");
    setDvar("r_materialBloomHQScriptMasterEnable", 0);
    return;
  }

  self setclientdvars("cg_fovScale", "1");
}

function initclientdvars() {
  setDvar("cg_drawCrosshair", 1);
  setDvar("cg_drawCrosshairNames", 1);

  if(level.hardcoremode) {
    setDvar("cg_drawCrosshair", 0);
    setDvar("cg_drawCrosshairNames", 1);
  }

  if(isDefined(level.alwaysdrawfriendlynames) && level.alwaysdrawfriendlynames) {
    setDvar("cg_drawFriendlyNamesAlways", 1);
  } else {
    setDvar("cg_drawFriendlyNamesAlways", 0);
  }

  self setclientdvars("cg_drawSpectatorMessages", 1);
  initclientdvarssplitscreenspecific();

  if(scripts\mp\utility\game::getgametypenumlives()) {
    if(level.teambased) {
      self setclientdvars("cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0);
    } else {
      self setclientdvars("cg_deadChatWithDead", 1, "cg_deadChatWithTeam", 0, "cg_deadHearTeamLiving", 0, "cg_deadHearAllLiving", 0);
    }
  } else {
    self setclientdvars("cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0);
  }

  if(level.teambased) {
    self setclientdvars("cg_everyoneHearsEveryone", 0);
  }

  self setclientdvar("ui_altscene", 0);

  if(getdvarint("scr_hitloc_debug")) {
    for(var_0 = 0; var_0 < 6; var_0++) {
      self setclientdvar("ui_hitloc_" + var_0, "");
    }

    self.hitlocinited = 1;
    return;
  }
}

function connect_validateplayerteam() {
  if(!isDefined(self)) {
    return;
  }

  if(self.sessionteam == "none" && scripts\mp\utility\game::matchmakinggame() && level.teambased && !isbot(self) && !initmaxspeedforpathlengthtable(self) && !self ismlgspectator() && scripts\mp\utility\game::getgametype() != "infect") {
    getentitylessscriptablearray("mp_invalid_team_error", ["player_xuid", self getxuid(), "isHost", self ishost()]);
    wait 1.5;
    kick(self getentitynumber(), "EXE/PLAYERKICKED_INVALIDTEAM");
    return;
  }
}

function queueconnectednotify() {
  for(;;) {
    if(!isDefined(level.players_waiting_for_callback)) {
      waitframe();
      continue;
    }

    goto LOC_00000018;
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

    var_2 = scripts\engine\utility::array_removeundefined(level.players_waiting_for_callback);
    level.players_waiting_for_callback = var_2;
    waitframe();
  }
}

function onversusdone(var_0, var_1) {
  if(var_0 != "versus_done") {
    return;
  }

  self.versusdone = 1;
}

function initsegmentstats() {
  level endon("game_ended");
  thread recordplayersegmentdata();

  for(;;) {
    level waittill("connected", var_0);
    thread createplayersegmentstats(level);
  }
}

function recordplayersegmentdata() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 4;

  for(;;) {
    wait 1;

    foreach(var_1 in level.players) {
      if(istrue(var_1.get_baseaccuracy)) {
        thread updateplayersegmentdata();
      }
    }
  }
}

function createplayersegmentstats(var_0) {
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  var_0.segments = [];
  var_0.segments["distanceTotal"] = 0;
  var_0.segments["movingTotal"] = 0;
  var_0.segments["movementUpdateCount"] = 0;
  var_0.savedsegmentposition = var_0.origin;
  var_0.positionptm = var_0.origin;
  var_0.get_baseaccuracy = 1;
}

function updateplayersegmentdata() {
  self endon("disconnect");

  if(!isDefined(self.savedsegmentposition)) {
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
  }

  if(scripts\mp\utility\player::isusingremote()) {
    self waittill("stopped_using_remote");
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
    return;
  }

  self.segments["movementUpdateCount"]++;
  self.segments["distanceTotal"] = self.segments["distanceTotal"] + distance2d(self.savedsegmentposition, self.origin);
  self.savedsegmentposition = self.origin;

  if(self.segments["movementUpdateCount"] % 5 == 0) {
    var_0 = distance2d(self.positionptm, self.origin);
    self.positionptm = self.origin;

    if(var_0 > 16) {
      self.segments["movingTotal"]++;
      return;
    }

    return;
  }
}

function shouldshowwidemapshot(var_0) {
  return scripts\mp\utility\game::getgametype() != "br" && scripts\mp\utility\game::getgametype() != "arm" && var_0 < level.prematchperiod && !istrue(self.btestclient) && !scripts\mp\flags::gameflag("infil_will_run");
}

function setuipregamefadeup(var_0) {
  var_1 = newclienthudelem(self);
  var_1.x = 0;
  var_1.y = 0;
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.sort = 1;
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.foreground = 1;
  var_2 = 0;
  var_3 = 0.5;

  if(isDefined(var_2) && var_2 > 0) {
    var_1.alpha = 0;
  } else {
    var_1.alpha = 1;
  }

  var_1 setshader("black", 640, 480);

  if(isDefined(var_2) && var_2 > 0) {
    if(isDefined(self)) {
      self notify("fadeDown_start");
    }

    var_1 fadeovertime(var_2);
    var_1.alpha = 1;
    wait var_2;
  }

  if(isDefined(self)) {
    self waittill(var_0);
  }

  var_1 fadeovertime(var_3);
  var_1.alpha = 0;
  wait var_3;

  if(isDefined(var_1)) {
    var_1 destroy();
    return;
  }
}

function friendlystatuschangedcallback() {
  self.pers["streamSyncComplete"] = 1;
  self notify("player_active");

  if(isDefined(self.team) && scripts\mp\utility\teams::isgameplayteam(self.team)) {
    [var_1] = scripts\mp\teams::getoperatorcustomization();
    var_2 = var_0[1];
    self setcustomization(var_1, var_2);

    if(!isDefined(var_1) || var_1 == "") {
      var_3 = scripts\mp\teams::lookupcurrentoperator(self.team);
      var_4 = scripts\mp\teams::lookupcurrentoperatorskin(self.team);
      scripts\mp\utility\script::laststand_dogtags("getOperatorCustomization() returned empty body for player " + self getentitynumber() + ", team " + self.team + ", operatorIndex " + var_3 + ", operatorSkinIndex " + var_4);
      return;
    }

    if(!isDefined(var_2) || var_2 == "") {
      var_3 = scripts\mp\teams::lookupcurrentoperator(self.team);
      var_4 = scripts\mp\teams::lookupcurrentoperatorskin(self.team);
      scripts\mp\utility\script::laststand_dogtags("getOperatorCustomization() returned empty head for player " + self getentitynumber() + ", team " + self.team + ", operatorIndex " + var_3 + ", operatorSkinIndex " + var_4);
      return;
    }

    return;
  }
}

function ref_119cd() {
  var_0 = isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self);

  if(scripts\mp\utility\game::rankingenabled()) {
    var_1 = self getplayerdata("common", "mpProgression", "playerLevel", "xp");
    var_2 = self getplayerdata("mp", "playerStats", "combatStats", "kills");
    var_3 = self getplayerdata("mp", "playerStats", "combatStats", "deaths");
    var_4 = self getplayerdata("mp", "playerStats", "matchStats", "wins");
    var_5 = self getplayerdata("mp", "playerStats", "matchStats", "losses");
    var_6 = self getplayerdata("mp", "playerStats", "combatStats", "hits");
    var_7 = self getplayerdata("mp", "playerStats", "combatStats", "misses");
    var_8 = self getplayerdata("mp", "playerStats", "combatStats", "wallbangs");
    var_9 = self getplayerdata("mp", "playerStats", "combatStats", "nearMisses");
    var_10 = self getplayerdata("mp", "playerStats", "matchStats", "gamesPlayed");
    var_11 = self getplayerdata("mp", "playerStats", "matchStats", "timePlayedTotal");
    var_12 = self getplayerdata("mp", "playerStats", "matchStats", "score");
    var_13 = self getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");
  } else {
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;
    var_13 = 0;
  }

  var_14 = self updatelastcovertime();
  GscBinSkip1(0x45, 0, "");
}

function repair_grill_fixing_long_sfx() {
  if(level.gametype != "br") {
    return 30;
  }

  return 200;
}

function callback_playerconnect() {
  self.versusdone = 0;
  self.pers["afkResetTime"] = 0;
  self.statusicon = "hud_status_connecting";
  self waittill("begin");
  self.statusicon = "";

  if(isai(self) || getdvarint("unattended", 0) == 1) {
    friendlystatuschangedcallback();
  }

  self.connecttime = undefined;
  self clearpredictedstreampos();

  if(scripts\mp\utility\game::getgametype() != "br") {
    self clearadditionalstreampos();
  }

  var_0 = 1;

  if(isDefined(level.ref_12065)) {
    var_0 = self thread[[level.ref_12065]]();
  }

  if(scripts\mp\flags::gameflag("prematch_done") && istrue(level.usespawnselection) && isDefined(self.sessionteam)) {
    if(self.sessionteam == "allies") {
      var_1 = level.spawncameras["gw_fob_alliesHQ"]["allies"];
      self setadditionalstreampos(var_1.origin, 1);
    } else if(self.sessionteam == "axis") {
      var_1 = level.spawncameras["gw_fob_axisHQ"]["axis"];
      self setadditionalstreampos(var_1.origin, 1);
    }
  }

  self visionsetfadetoblackforplayer("bw", 0);
  var_2 = "connected_continue";
  var_3 = scripts\mp\utility\game::gettimepassed() / 1000 + 6;

  if(!isDefined(self.pers["streamSyncComplete"]) && (shouldshowwidemapshot(var_3) || level.gametype == "arm")) {
    var_2 = "player_active";
  }

  thread setuipregamefadeup(var_2);
  scripts\mp\utility\game::checkrealismhudsettings();
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
    var_4 = 0;
    var_5 = getdvarint("scr_skip_connected_msg_until_time", 0);

    if(var_5 > 0) {
      if(isDefined(level.starttime)) {
        var_6 = (gettime() - level.starttime) / 1000;

        if(var_6 <= var_5) {
          var_4 = 1;
        }
      } else {
        var_4 = 1;
      }
    }

    if(var_4 == 0) {}
  }

  self.usingonlinedataoffline = self isusingonlinedataoffline();
  initclientdvars();
  initplayerstats();
  scripts\mp\accolades::applyaccoladestructtoplayerpers();

  if(getDvar("r_reflectionProbeGenerate") == "1") {
    level waittill("eternity");
  }

  self.guid = scripts\mp\utility\player::getuniqueid();
  var_7 = 0;

  if(!isDefined(self.pers["clientid"])) {
    self.pers["clientid"] = game["clientid"];
    game["clientid"]++;
    var_8 = repair_grill_fixing_long_sfx();

    if(game["clientid"] >= var_8) {
      game["clientid"] = var_8 - 1;
      self.pers["clientid"] = var_8 - 1;
    }

    var_7 = 1;
    self.pers["matchdataWeaponStats"] = [];
    self.pers["matchdataScoreEventCounts"] = [];
    self.pers["xpAtLastDeath"] = 0;
    self.pers["scoreAtLastDeath"] = 0;
  }

  if(istrue(level.flashpointactive)) {
    thread scripts\mp\flashpoint::flashpoint_trackplayerevents(self);
  }

  if(var_7) {
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

  if(drawentitybounds()) {
    analyticsstreamerlogfiletagplayer("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");
  }

  self logstatmatchguid();

  if(getdvarint("online_matchdata_enabled") != 0) {
    var_9 = getmatchdata("commonMatchData", "player_count");

    if(var_7) {
      var_9++;
      setmatchdata("commonMatchData", "player_count", var_9);
    }

    if(isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self)) {
      var_10 = 1;
    } else {
      var_10 = 0;
    }

    if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::denysystemicteamchoice() && !var_10) {}
  }

  if(var_9) {
    ref_119cd();
  }

  if(level.uniqueplayersconnected <= repair_grill_fixing_long_sfx()) {
    if(var_9 && isDefined(level.matchrecording_logeventplayername)) {
      [[level.matchrecording_logeventplayername]](self.clientid, self.team, self.name);
    }
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
    self.bestlifetimekillstreak = scripts\mp\playerstats_interface::getplayerstat("bestStats", "killStreak");
  }

  self.lastgrenadesuicidetime = -1;
  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.wasaliveatmatchstart = 0;
  self.movespeedscaler = 1;
  self.objectivescaler = 1;
  self.killcountthislife = 0;
  self.intel_guys = 0;
  self.ref_11bc2 = 0;
  self.show_balloon_deploy_hint = undefined;
  self.shouldxmike109hitmarker = undefined;
  self.lifeid = 0;

  if(isDefined(self.pers["deaths"])) {
    self.lifeid = self.pers["deaths"];
  }

  resetuidvarsonconnect();
  waittillframeend();
  level.players[level.players.size] = self;
  level.playersbyentitynumber[self getentitynumber()] = self;
  scripts\mp\spawnlogic::addtoparticipantsarray();
  scripts\mp\spawnlogic::addtocharactersarray();
  scripts\cp_mp\utility\player_utility::being_kicked_from_inactivity();

  if(game["state"] == "postgame") {
    self.connectedpostgame = 1;
    self setclientdvars("cg_drawSpectatorMessages", 0);
    self visionsetfadetoblackforplayer("", 0.25);
    spawnintermission();
    return;
  }

  if(var_9 && (scripts\mp\utility\game::gettimepassed() >= 60000 || game["roundsPlayed"] > 0)) {
    self.joinedinprogress = 1;
  }

  if(isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["think"])) {
    self thread[[level.bot_funcs["think"]]]();
  }

  if(drawentitybounds() && !isai(self)) {
    analyticsstreamerislogfilestreamingenabled(self.guid);
  }

  level endon("game_ended");

  if(isDefined(level.hostmigrationtimer)) {
    thread scripts\mp\hostmigration::hostmigrationtimerthink();
  }

  if(isDefined(level.onplayerconnectaudioinit)) {
    [[level.onplayerconnectaudioinit]]();
  }

  thread scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_monitorplayerusability(self);
  thread abilityleft::claymore_crate_update_hint_logic_alt(self);
  thread scripts\mp\perks\perkfunctions::markedentities_think();

  if(!isDefined(self.pers["team"])) {
    var_7 = scripts\mp\utility\game::gettimepassed() / 1000 + 6;

    if(shouldshowwidemapshot(var_7)) {
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
      if(self ismlgfollower()) {
        thread scripts\mp\menus::setfollower();
      } else {
        thread scripts\mp\menus::setspectator();
      }
    } else if(dotournamentendgame() && (self.sessionteam == "spectator" || self.sessionteam == "follower")) {
      self.pers["team"] = self.sessionteam;
      self.team = self.sessionteam;
      thread spawnspectator();
    } else if((scripts\mp\utility\game::matchmakinggame() || scripts\mp\utility\game::lobbyteamselectenabled() || isgamebattlematch()) && self.sessionteam != "none") {
      if(var_2) {
        thread spawnspectator();
      }

      if((getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk" || getDvar("scr_br_gametype", "") == "gold_war") && getdvarint("scr_br_manual_team_assignment", 0) == 1) {
        thread scripts\mp\teams::ref_12304();
      } else {
        if(scripts\mp\menus::brking_updateteamscore()) {
          self.sessionteam = "allies";
        }

        thread scripts\mp\menus::setteam(self.sessionteam);
      }

      if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
        if(getdvarint("scr_force_cac_sre_callstack", 0) == 1 && scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "sandbox" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
          var_14 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
          scripts\mp\utility\script::laststand_dogtags("Callback_PlayerConnect() elseif MMG " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + var_14);
        }

        self setclientomnvar("ui_options_menu", 2);
      }

      if(!scripts\mp\utility\game::runleanthreadmode() && scripts\mp\utility\game::matchmakinggame() && !isgamebattlematch()) {
        thread kickifdontspawn();
      }

      clearpinnedobjectives();
      return;
    } else {
      if(var_2) {
        thread spawnspectator();
      }

      scripts\mp\menus::autoassign();

      if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
        if(getdvarint("scr_force_cac_sre_callstack", 0) == 1 && scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "sandbox" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
          var_14 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
          scripts\mp\utility\script::laststand_dogtags("Callback_PlayerConnect() else " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + var_14);
        }

        self setclientomnvar("ui_options_menu", 2);
      }

      if(!scripts\mp\utility\game::runleanthreadmode() && scripts\mp\utility\game::matchmakinggame()) {
        thread kickifdontspawn();
      }

      clearpinnedobjectives();
      return;
    }
  } else {
    self visionsetfadetoblackforplayer("", 0.5);
    connect_validateplayerteam();
    var_15 = self.pers["team"];

    if(scripts\mp\utility\game::matchmakinggame() && !isbot(self) && !initmaxspeedforpathlengthtable(self) && !self ismlgspectator() && getdvarint("team_consistency_fix")) {
      var_15 = self.sessionteam;
    }

    scripts\mp\menus::addtoteam(var_15, 1);

    if(scripts\mp\menus::shouldmodesetsquads()) {
      thread scripts\mp\menus::setsquad(var_15);
    }

    if(isDefined(level.ref_12065)) {
      self thread[[level.ref_12065]]();
    }

    if(self ismlgspectator()) {
      thread spawnspectator();
      clearpinnedobjectives();
      return;
    }

    if(scripts\mp\class::isvalidclass(self.pers["class"]) && var_15 != "spectator") {
      thread spawnclient();
      clearpinnedobjectives();
      return;
    }

    if(var_2) {
      thread spawnspectator();
    }

    if(self.pers["team"] == "spectator") {
      if(scripts\mp\utility\game::doesmodesupportplayerteamchoice() && !istrue(self.pers["playerChoseSpectatorTeam"])) {
        scripts\mp\menus::beginteamchoice();
      }
    } else {
      scripts\mp\menus::beginclasschoice();
    }
  }

  clearpinnedobjectives();
}

function callback_playermigrated() {
  if(isDefined(self.connected) && self.connected) {
    scripts\mp\utility\game::updateobjectivetext();
  }

  if(self ishost()) {
    initclientdvarssplitscreenspecific();
  }

  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isbot(var_2) && !initmaxspeedforpathlengthtable(var_2)) {
      var_0++;
    }
  }

  if(!isbot(self) && !initmaxspeedforpathlengthtable(self)) {
    level.hostmigrationreturnedplayercount++;

    if(level.hostmigrationreturnedplayercount >= var_0 * 2 / 3) {
      level notify("hostmigration_enoughplayers");
      return;
    }

    return;
  }
}

function addlevelstoexperience(var_0, var_1) {
  var_2 = scripts\mp\rank::getrankforxp(var_0);
  var_3 = scripts\mp\rank::getrankinfominxp(var_2);
  var_4 = scripts\mp\rank::getrankinfomaxxp(var_2);
  var_2 += (var_0 - var_3) / (var_4 - var_3);
  var_2 += var_1;

  if(var_2 < 0) {
    var_2 = 0;
    var_5 = 0;
  } else if(var_3 >= level.maxrank + 1) {
    var_3 = level.maxrank;
    var_5 = 1;
  } else {
    var_5 = var_4 - floor(var_4);
    var_4 = int(floor(var_4));
  }

  var_5 = scripts\mp\rank::getrankinfominxp(var_4);
  var_5 = scripts\mp\rank::getrankinfomaxxp(var_4);
  return int(var_5 * (var_5 - var_5)) + var_5;
}

function forcespawn() {
  self endon("death_or_disconnect");
  self endon("spawned");
  wait 60;

  if(self.hasspawned) {
    return;
  }

  if(self.pers["team"] == "spectator" || self.pers["team"] == "follower") {
    return;
  }

  if(!scripts\mp\class::isvalidclass(self.pers["class"])) {
    self.pers["class"] = "CLASS/CUSTOM1";
    self.class = self.pers["class"];
  }

  thread spawnclient();
}

function kickifdontspawn() {
  if(getdvarint("debug_stopAFKCheck", 0) == 1) {
    return;
  }

  if(istrue(self.ref_1363e) && !mayspawn()) {
    return;
  }

  self endon("death_or_disconnect");
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

  var_4 = (gettime() - var_3) / 1000;

  if(var_4 < var_0 - 0.1 && var_4 < var_1) {
    return;
  }

  if(self.hasspawned) {
    return;
  }

  if(self.pers["team"] == "spectator" || self.pers["team"] == "follower") {
    return;
  }

  kick(self getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
  level thread[[level.updategameevents]]();
}

function kickwait(var_0) {
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
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

function totaldisttracking(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");
  self notify("distFromSpawnTracking");
  self endon("distFromSpawnTracking");
  var_2 = var_0;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    scripts\mp\flags::gameflagwait("prematch_done");
    var_2 = self.origin;
  }

  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  for(;;) {
    var_6 = scripts\engine\utility::ref_143be(5, "death", "vehicle_enter", "vehicle_change_seat", "vehicle_exit", "afk_tracking_resume", "skydive_deployparachute");

    if(var_6 == "vehicle_exit" && !isDefined(self.lastvehicleseatchangetime)) {
      continue;
    }

    if(!isDefined(self.pers["totalDistTraveled"])) {
      scripts\mp\utility\stats::initpersstat("totalDistTraveled");
    }

    if(!isDefined(self.pers["totalDistTraveledByFoot"])) {
      scripts\mp\utility\stats::initpersstat("totalDistTraveledByFoot");
    }

    if(!isDefined(var_2)) {
      var_2 = self.origin;
    }

    var_7 = distance(var_2, self.origin);
    scripts\mp\utility\stats::incpersstat("totalDistTraveled", var_7);
    scripts\cp\vehicles\vehicle_compass_cp::incchallengestat("totalDistTraveled", var_7);

    if(getdvarint("scr_veteruns_challenge_enabled", 0)) {
      if(!isDefined(self.vehicle) && var_6 != "vehicle_exit" || var_6 == "vehicle_enter") {
        var_8 = 0;

        if(self isjumping()) {
          var_9 = scripts\mp\gametypes\br_public::modifytriggerlocation(self.origin, 0, -100000);
          var_10 = self.origin[2] - var_9["position"][2];
          var_8 = var_10 <= getdvarfloat("foot_tracking_max_small_jump_height", 100) && var_10 > 0 && !isDefined(var_9["entity"]);
        }

        var_9 = self getgroundentity();
        var_11 = isDefined(var_9) && var_9.classname == "worldspawn" || var_8;

        if(var_11 && var_5 && var_7 <= getdvarfloat("foot_tracking_max_expected_distance", 10000)) {
          scripts\mp\utility\stats::incpersstat("totalDistTraveledByFoot", var_7);
          scripts\cp\vehicles\vehicle_compass_cp::incchallengestat("totalDistTraveledByFoot", var_7);
        }

        var_5 = var_11 && var_6 != "skydive_deployparachute";
      }
    }

    if(isDefined(scripts\mp\utility\stats::getpersstat("distanceTraveledInVehicle")) && (var_6 == "vehicle_exit" || isDefined(self.vehicle))) {
      scripts\mp\utility\stats::incpersstat("distanceTraveledInVehicle", var_7);
    }

    if(var_6 == "vehicle_enter") {
      var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);
      self.lastvehicleseatchangetime = gettime();
    }

    if(var_6 == "vehicle_change_seat") {
      var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);
    }

    if(var_3 != var_4 || var_6 == "vehicle_exit") {
      var_12 = self.lastvehicleseatchangetime;
      var_13 = (gettime() - var_12) / 1000;

      if(var_3) {
        if(isDefined(scripts\mp\utility\stats::getpersstat("timeSpentAsDriver"))) {
          scripts\mp\utility\stats::incpersstat("timeSpentAsDriver", var_13);
        }
      } else if(isDefined(scripts\mp\utility\stats::getpersstat("timeSpentAsPassenger"))) {
        scripts\mp\utility\stats::incpersstat("timeSpentAsPassenger", var_13);
      }
    }

    if(var_6 == "vehicle_enter" || var_6 == "vehicle_change_seat") {
      var_3 = var_4;
    }

    if(var_6 == "vehicle_change_seat") {
      self.lastvehicleseatchangetime = gettime();
    }

    var_2 = self.origin;
    scripts\mp\utility\stats::incpersstat("averageAltitude", self.origin[2]);
    scripts\mp\utility\stats::incpersstat("averageAltitudeCount", 1);

    if(var_1 && !istrue(self.stack_patch_waittill_node)) {
      if(var_6 == "afk_tracking_resume") {
        continue;
      }

      if(!isDefined(self.pers["totalDistTraveledAFK"])) {
        scripts\mp\utility\stats::initpersstat("totalDistTraveledAFK");
      }

      scripts\mp\utility\stats::incpersstat("totalDistTraveledAFK", var_7);

      if(scripts\mp\utility\game::getgametype() == "arena") {
        if(self.pers["totalDistTraveledAFK"] > 50) {
          self.pers["distTrackingPassed"] = 1;
          self.pers["afkRounds"] = 0;
        }

        continue;
      }

      if(!istrue(self.pers["distTrackingPassed"])) {
        if(self.pers["totalDistTraveledAFK"] > 300) {
          self.pers["distTrackingPassed"] = 1;
        }

        continue;
      }

      var_14 = ref_1331c();

      if(var_14) {
        var_15 = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);

        if(var_15 - self.pers["afkResetTime"] > 240) {
          self.pers["afkResetTime"] = var_15;
          self.pers["distTrackingPassed"] = undefined;
          self.pers["totalDistTraveledAFK"] = undefined;
        }
      }
    }
  }
}

function initleanplayerstats() {
  if(!isDefined(self.pers["deaths"])) {
    scripts\mp\utility\stats::initpersstat("deaths");
    scripts\mp\persistence::statsetchild("round", "deaths", 0);
  }

  self.deaths = scripts\mp\utility\stats::getpersstat("deaths");
  scripts\mp\utility\stats::timedrun_finishlinevfx("deaths");

  if(!isDefined(self.pers["score"])) {
    scripts\mp\utility\stats::initpersstat("score");
    scripts\mp\persistence::statsetchild("round", "score", 0);
  }

  self.score = scripts\mp\utility\stats::getpersstat("score");
  scripts\mp\utility\stats::timedrun_finishlinevfx("score");

  if(!isDefined(self.pers["kills"])) {
    scripts\mp\utility\stats::initpersstat("kills");
    scripts\mp\persistence::statsetchild("round", "kills", 0);
  }

  self.kills = scripts\mp\utility\stats::getpersstat("kills");
  scripts\mp\utility\stats::timedrun_finishlinevfx("kills");
}

function initplayerstats() {
  scripts\mp\playerstats::initplayer();
  scripts\mp\persistence::initbufferedstats();

  if(!isDefined(self.watchvehicleingas)) {
    self.watchvehicleingas = [];
  }

  initleanplayerstats();

  if(!isDefined(self.pers["suicides"])) {
    scripts\mp\utility\stats::initpersstat("suicides");
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("suicides");

  if(!isDefined(self.pers["headshots"])) {
    scripts\mp\utility\stats::initpersstat("headshots");
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("headshots");

  if(!isDefined(self.pers["executions"])) {
    scripts\mp\utility\stats::initpersstat("executions");
  }

  if(!isDefined(self.pers["assists"])) {
    scripts\mp\utility\stats::initpersstat("assists");
    scripts\mp\persistence::statsetchild("round", "assists", 0);
  }

  self.assists = scripts\mp\utility\stats::getpersstat("assists");
  scripts\mp\utility\stats::timedrun_finishlinevfx("assists");

  if(!isDefined(self.pers["captures"])) {
    scripts\mp\utility\stats::initpersstat("captures");
    scripts\mp\persistence::statsetchild("round", "captures", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("captures");

  if(!isDefined(self.pers["returns"])) {
    scripts\mp\utility\stats::initpersstat("returns");
    scripts\mp\persistence::statsetchild("round", "returns", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("returns");

  if(!isDefined(self.pers["defends"])) {
    scripts\mp\utility\stats::initpersstat("defends");
    scripts\mp\persistence::statsetchild("round", "defends", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("defends");

  if(!isDefined(self.pers["plants"])) {
    scripts\mp\utility\stats::initpersstat("plants");
    scripts\mp\persistence::statsetchild("round", "plants", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("plants");

  if(!isDefined(self.pers["defuses"])) {
    scripts\mp\utility\stats::initpersstat("defuses");
    scripts\mp\persistence::statsetchild("round", "defuses", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("defuses");

  if(!isDefined(self.pers["destructions"])) {
    scripts\mp\utility\stats::initpersstat("destructions");
    scripts\mp\persistence::statsetchild("round", "destructions", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("destructions");

  if(!isDefined(self.pers["confirmed"])) {
    scripts\mp\utility\stats::initpersstat("confirmed");
    scripts\mp\persistence::statsetchild("round", "confirmed", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("confirmed");

  if(!isDefined(self.pers["denied"])) {
    scripts\mp\utility\stats::initpersstat("denied");
    scripts\mp\persistence::statsetchild("round", "denied", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("denied");

  if(!isDefined(self.pers["rescues"])) {
    scripts\mp\utility\stats::initpersstat("rescues");
    scripts\mp\persistence::statsetchild("round", "rescues", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("rescues");

  if(!isDefined(self.pers["touchdowns"])) {
    scripts\mp\utility\stats::initpersstat("touchdowns");
    scripts\mp\persistence::statsetchild("round", "touchdowns", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("touchdowns");

  if(!isDefined(self.pers["fieldgoals"])) {
    scripts\mp\utility\stats::initpersstat("fieldgoals");
    scripts\mp\persistence::statsetchild("round", "fieldgoals", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("fieldgoals");

  if(!isDefined(self.pers["killChains"])) {
    scripts\mp\utility\stats::initpersstat("killChains");
    scripts\mp\persistence::statsetchild("round", "killChains", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("killChains");

  if(!isDefined(self.pers["killsAsSurvivor"])) {
    scripts\mp\utility\stats::initpersstat("killsAsSurvivor");
    scripts\mp\persistence::statsetchild("round", "killsAsSurvivor", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("killsAsSurvivor");

  if(!isDefined(self.pers["killsAsInfected"])) {
    scripts\mp\utility\stats::initpersstat("killsAsInfected");
    scripts\mp\persistence::statsetchild("round", "killsAsInfected", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("killsAsInfected");

  if(!isDefined(self.pers["teamkills"])) {
    scripts\mp\utility\stats::initpersstat("teamkills");
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("teamkills");

  if(!isDefined(self.pers["extrascore0"])) {
    scripts\mp\utility\stats::initpersstat("extrascore0");
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("extrascore0");

  if(!isDefined(self.pers["extrascore1"])) {
    scripts\mp\utility\stats::initpersstat("extrascore1");
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("extrascore1");

  if(!isDefined(self.pers["stabs"])) {
    scripts\mp\utility\stats::initpersstat("stabs");
    scripts\mp\persistence::statsetchild("round", "stabs", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("stabs");

  if(!isDefined(self.pers["setbacks"])) {
    scripts\mp\utility\stats::initpersstat("setbacks");
    scripts\mp\persistence::statsetchild("round", "setbacks", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("setbacks");

  if(!isDefined(self.pers["objTime"])) {
    scripts\mp\utility\stats::initpersstat("objTime");
    scripts\mp\persistence::statsetchild("round", "objTime", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("objTime");

  if(!isDefined(self.pers["gamemodeScore"])) {
    scripts\mp\utility\stats::initpersstat("gamemodeScore");
    scripts\mp\persistence::statsetchild("round", "gamemodeScore", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("gamemodeScore");

  if(!isDefined(self.pers["damage"])) {
    scripts\mp\utility\stats::initpersstat("damage");
    scripts\mp\persistence::statsetchild("round", "damage", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("damage");

  if(!isDefined(self.pers["supersEarned"])) {
    scripts\mp\utility\stats::initpersstat("supersEarned");
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("supersEarned");

  if(!isDefined(self.pers["downs"])) {
    scripts\mp\utility\stats::initpersstat("downs");
    scripts\mp\persistence::statsetchild("round", "downs", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("downs");

  if(!isDefined(self.pers["contracts"])) {
    scripts\mp\utility\stats::initpersstat("contracts");
    scripts\mp\persistence::statsetchild("round", "contracts", 0);
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("contracts");

  if(!isDefined(self.pers["wins"])) {
    scripts\mp\utility\stats::initpersstat("wins");
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("wins");

  if(!isDefined(self.pers["topFive"])) {
    scripts\mp\utility\stats::initpersstat("topFive");
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("topFive");

  if(!isDefined(self.pers["topTen"])) {
    scripts\mp\utility\stats::initpersstat("topTen");
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("topTen");

  if(!isDefined(self.pers["topTwentyFive"])) {
    scripts\mp\utility\stats::initpersstat("topTwentyFive");
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("topTwentyFive");

  if(!isDefined(self.pers["gamesPlayed"])) {
    scripts\mp\utility\stats::initpersstat("gamesPlayed");
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("gamesPlayed");

  if(!isDefined(self.pers["cash"])) {
    scripts\mp\utility\stats::initpersstat("cash");
  }

  scripts\mp\utility\stats::timedrun_finishlinevfx("cash");

  if(!isDefined(self.pers["teamKillPunish"])) {
    self.pers["teamKillPunish"] = 0;
  }

  scripts\mp\utility\stats::initpersstat("longestStreak");
  scripts\mp\utility\stats::timedrun_finishlinevfx("longestStreak");
  self.pers["lives"] = scripts\mp\utility\game::getgametypenumlives();
  scripts\mp\persistence::statsetchild("round", "killStreak", 0);
  scripts\mp\persistence::statsetchild("round", "loss", 0);
  scripts\mp\persistence::statsetchild("round", "win", 0);
  scripts\mp\persistence::statsetchild("round", "scoreboardType", "none");
  scripts\mp\utility\stats::timedrun_finishlinevfx("killStreak");
  scripts\mp\utility\stats::timedrun_finishlinevfx("loss");
  scripts\mp\utility\stats::timedrun_finishlinevfx("win");
}

function addtoteamcount(var_0) {
  thread scripts\mp\utility\teams::addplayertoteam(self, self.team, var_0);
  [[level.updategameevents]]();
}

function removefromteamcount() {
  scripts\mp\utility\teams::removeplayerfromteam(self, self.team);
}

function addtoalivecount(var_0) {
  var_1 = self.team;

  if(!(isDefined(self.alreadyaddedtoalivecount) && self.alreadyaddedtoalivecount)) {
    scripts\mp\utility\teams::modifyteamdata(var_1, "hasSpawned", 1);
    incrementalivecount(var_1, 0, var_0);
  }

  self.alreadyaddedtoalivecount = undefined;
  var_2 = 0;

  foreach(var_4 in level.teamnamelist) {
    var_2 += scripts\mp\utility\teams::getteamdata(var_4, "aliveCount");
  }

  if(var_2 > level.maxplayercount) {
    level.maxplayercount = var_2;
    return;
  }
}

function incrementalivecount(var_0, var_1, var_2) {
  scripts\mp\utility\teams::addtoteamlives(self, var_0, var_1, var_2);
  [[level.updategameevents]]();
}

function removefromalivecount(var_0, var_1) {
  var_2 = self.pers["lives"];
  var_3 = scripts\mp\utility\game::getgametypenumlives() != 0 && var_2 == 0 && !istrue(level.ref_133df);
  self notify("remove_from_alive_count");
  var_4 = self.team;

  if(isDefined(self.switching_teams) && self.switching_teams && isDefined(self.joining_team) && self.joining_team == self.team) {
    var_4 = self.leaving_team;
  }

  if(isDefined(var_0)) {
    removeallfromlivescount();
  } else if(isDefined(self.switching_teams)) {
    if(!level.ingraceperiod || self.hasdonecombat) {
      scripts\mp\utility\teams::modifyteamdata(var_4, "hasSpawned", -1);

      if(var_2) {
        self.pers["lives"]--;
      }
    }
  }

  decrementalivecount(var_4, var_3, var_1);
}

function decrementalivecount(var_0, var_1, var_2) {
  scripts\mp\utility\teams::removefromteamlives(self, var_0, var_1, var_2);
  [[level.updategameevents]]();
}

function addtolivescount() {
  scripts\mp\utility\teams::modifyteamdata(self.team, "livesCount", self.pers["lives"]);
}

function removefromlivescount() {
  scripts\mp\utility\teams::setteamdata(self.team, "livesCount", int(max(0, scripts\mp\utility\teams::getteamdata(self.team, "livesCount") - 1)));
}

function removeallfromlivescount() {
  scripts\mp\utility\teams::setteamdata(self.team, "livesCount", int(max(0, scripts\mp\utility\teams::getteamdata(self.team, "livesCount") - self.pers["lives"])));
}

function resetuiomnvarscommon() {
  if(isDefined(level.resetuiomnvargamemode)) {
    [[level.resetuiomnvargamemode]]();
  }

  self setclientomnvar("ui_objective_state", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_reviver_id", -1);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_edge_glow", 0);
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self setclientomnvar("ui_life_kill_count", 0);
  self setclientomnvar("ui_is_laststand", 0);
}

function resetuidvarsonconnect() {
  resetuiomnvarscommon();
  self setclientdvar("ui_eyes_on_end_milliseconds", 0);
  self setclientomnvar("ui_match_status_hint_text", -1);
  self setclientomnvar("post_game_state", 0);

  if(scripts\mp\flags::gameflag("prematch_done")) {
    self setclientomnvar("ui_match_in_progress", 1);
    return;
  }

  self setclientomnvar("ui_match_in_progress", 0);
}

function resetuidvarsonspectate() {
  resetuiomnvarscommon();
  self setclientdvar("ui_eyes_on_end_milliseconds", 0);
}

function clearpinnedobjectives() {
  if(isbot(self)) {
    return;
  }

  if(isDefined(level.objectives)) {
    foreach(var_1 in level.objectives) {
      if(isDefined(var_1.objidnum)) {
        scripts\mp\objidpoolmanager::objective_unpin_player(var_1.objidnum, self, var_1.showoncompass);
      }
    }
  }

  if(isDefined(level.uncapturableobjectives)) {
    foreach(var_1 in level.uncapturableobjectives) {
      if(isDefined(var_1.objidnum)) {
        scripts\mp\objidpoolmanager::objective_unpin_player(var_1.objidnum, self, var_1.showoncompass);
      }
    }

    return;
  }
}

function watchtargethealth() {
  self endon("death_or_disconnect");
  self.targethealthinfo = [];

  for(;;) {
    var_0 = (self.origin[0], self.origin[1], self.origin[2] + 64);
    var_1 = self getplayerangles();
    var_2 = anglesToForward(var_1);
    var_3 = var_0 + var_2 * 10000;
    var_4 = scripts\engine\trace::_bullet_trace(var_0, var_3, 1, self, 0, 0, 0, 0, 0);
    var_5 = var_4["entity"];

    if(isDefined(var_5) && isPlayer(var_5) && var_5.team != self.team) {
      if(isDefined(var_5)) {
        updatetargethealthvariable("ui_target_health", var_5.health);
      }

      if(isDefined(var_5)) {
        updatetargethealthvariable("ui_target_max_health", var_5.maxhealth);
      }

      if(isDefined(var_5)) {
        updatetargethealthvariable("ui_target_entity_num", var_5 getentitynumber());
      }
    } else {
      updatetargethealthvariable("ui_target_entity_num", -1);
    }

    wait 0.1;
  }
}

function updatetargethealthvariable(var_0, var_1) {
  waitframe();

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(!isDefined(self.targethealthinfo[var_0]) || var_1 != self.targethealthinfo[var_0]) {
    self setclientomnvar(var_0, var_1);
    self.targethealthinfo[var_0] = var_1;
    return;
  }
}

function showgamemodeobjectivetext() {
  if(self.hasspawned) {
    return;
  }

  if(!showmatchhint()) {
    return;
  }

  if(scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  self endon("disconnect");
  wait 1;

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.pers["team"])) {
    return;
  }

  var_0 = self.pers["team"];
  var_1 = scripts\mp\utility\game::getobjectivehinttext(var_0);

  if(isDefined(var_1)) {
    var_2 = 0;

    if(game["defenders"] == var_0) {
      var_2 = 1;
    }

    self setclientomnvar("ui_objective_text", var_2);
    wait 6;
    self setclientomnvar("ui_objective_text", -1);
    return;
  }
}

function showmatchhint() {
  var_0 = scripts\mp\utility\game::getgametype();

  switch (var_0) {
    case "arena":
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
  if(scripts\mp\utility\player::alwaysshowminimap() || scripts\mp\utility\game::getgametype() == "br") {
    return;
  }

  if(!istrue(self.showuavminimaponspawn) && !scripts\mp\utility\perk::_hasperk("specialty_always_minimap")) {
    scripts\mp\utility\player::hideminimap(1);
  }

  self.showuavminimaponspawn = 0;
}

function initinputtypewatcher() {
  self.gamepadwasenabled = scripts\engine\utility::is_player_gamepad_enabled();
}

function updateinputtypewatcher() {
  var_0 = scripts\engine\utility::is_player_gamepad_enabled();

  if(self.gamepadwasenabled != var_0) {
    self notify("input_type_changed", var_0);
    self.gamepadwasenabled = var_0;
    return;
  }
}

function updateplayerwindmaterial() {
  var_0 = 100;
  var_1 = 700;
  var_2 = var_1 - var_0;
  var_3 = 0;
  var_4 = 10;

  for(;;) {
    foreach(var_6 in level.players) {
      if(!isDefined(var_6)) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var_6)) {
        continue;
      }

      if(istrue(var_6.manualoverridewindmaterial)) {
        continue;
      }

      if(isDefined(var_6.vehicle)) {
        var_7 = clamp(length(var_6.vehicle vehicle_getvelocity()), var_0, var_1);
      } else {
        var_7 = clamp(length(var_6 getvelocity()), var_0, var_1);
      }

      var_8 = (var_7 - var_0) / var_2;
      var_8 *= 10;
      var_8 = int(var_8);

      if(!isDefined(var_6.ref_145c6) || var_6.ref_145c6 != var_8) {
        switch (var_8) {
          case 0:
            var_6 setscriptablepartstate("wind", "0", 0);
            break;
          case 1:
            var_6 setscriptablepartstate("wind", "10", 0);
            break;
          case 2:
            var_6 setscriptablepartstate("wind", "20", 0);
            break;
          case 3:
            var_6 setscriptablepartstate("wind", "30", 0);
            break;
          case 4:
            var_6 setscriptablepartstate("wind", "40", 0);
            break;
          case 5:
            var_6 setscriptablepartstate("wind", "50", 0);
            break;
          case 6:
            var_6 setscriptablepartstate("wind", "60", 0);
            break;
          case 7:
            var_6 setscriptablepartstate("wind", "70", 0);
            break;
          case 8:
            var_6 setscriptablepartstate("wind", "80", 0);
            break;
          case 9:
            var_6 setscriptablepartstate("wind", "90", 0);
            break;
          case 10:
            var_6 setscriptablepartstate("wind", "100", 0);
            break;
        }
      }

      var_6.ref_145c6 = var_8;
      var_3++;

      if(var_3 == var_4) {
        waitframe();
        var_3 = 0;
      }
    }

    wait 0.1;
  }
}

function ref_1331c() {
  if(isDefined(level.ref_1331d)) {
    return [[level.ref_1331d]]();
  }

  return 1;
}