/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\playerlogic.gsc
***********************************************/

function init() {
  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&onversusdone);
}

function timeuntilwavespawn(var0) {
  if(!self.hasspawned) {
    return 0;
  }

  var1 = gettime() + var0 * 1000;
  var2 = level.lastwave[self.pers["team"]];
  var3 = level.wavedelay[self.pers["team"]] * 1000;
  var4 = (var1 - var2) / var3;
  var5 = ceil(var4);
  var6 = var2 + var5 * var3;

  if(isDefined(self.respawntimerstarttime)) {
    var7 = (gettime() - self.respawntimerstarttime) / 1000;

    if(self.respawntimerstarttime < var2) {
      return 0;
    }
  }

  if(isDefined(self.wavespawnindex)) {
    var6 += 50 * self.wavespawnindex;
  }

  return (var6 - gettime()) / 1000;
}

function teamkilldelay() {
  var0 = self.pers["teamkills"];

  if(!isDefined(var0) || level.maxallowedteamkills < 0 || var0 <= level.maxallowedteamkills) {
    return 0;
  }

  var1 = var0 - level.maxallowedteamkills;
  return scripts\mp\tweakables::gettweakablevalue("team", "teamkillspawndelay") * var1;
}

function timeuntilspawn(var0) {
  if(level.ingraceperiod && !self.hasspawned || level.gameended) {
    return 0;
  }

  var1 = 0;

  if(self.hasspawned) {
    var2 = self[[level.onrespawndelay]]();

    if(isDefined(var2)) {
      var1 = var2;
    } else {
      var1 = getdvarfloat("scr_" + scripts\mp\utility\game::getgametype() + "_playerrespawndelay");
    }

    if(var0 && isDefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"]) {
      var1 += teamkilldelay();
    }

    if(isDefined(self.suicidespawndelay)) {
      var1 += getdvarfloat("scr_" + scripts\mp\utility\game::getgametype() + "_suicidespawndelay");
    }

    if(isDefined(self.respawntimerstarttime) && !isDefined(level.spawndelay)) {
      var3 = (gettime() - self.respawntimerstarttime) / 1000;
      var1 -= var3;

      if(var1 < 0) {
        var1 = 0;
      }
    }

    if(isDefined(self.setspawnpoint)) {
      var1 += level.tispawndelay;
    }
  }

  var4 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay") > 0;

  if(var4) {
    var1 = timeuntilwavespawn(var1);
  }

  if(level.ingraceperiod && !self.hasspawned || level.gameended) {
    var1 = 0;
  } else if(getdvarint("scr_cmd_camera_debug", 0) == 1) {
    var1 = 999;
  }

  if(!isDefined(self.tiers)) {
    self.tiers = var1;
  }

  return var1;
}

function isdevelopmentspawningofbotclient(var0) {
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

function spawnclient(var0) {
  self endon("becameSpectator");

  if(isDefined(level.ref_11c84)) {
    self[[level.ref_11c84]](var0);
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
    var1 = self.origin;
    var2 = self.angles;
    self notify("attempted_spawn");

    if(istrue(self.pers["teamKillPunish"])) {
      self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
      scripts\mp\utility\lower_message::setlowermessageomnvar(24);

      if(!self.hasspawned && self.pers["teamkills"] <= level.maxallowedteamkills) {
        self.pers["teamKillPunish"] = 0;
      }
    } else if(scripts\mp\utility\game::isroundbased() && game["finalRound"] == 0 || scripts\mp\utility\game::getgametypenumlives() != 0 && game["finalRound"] == 0 || istrue(level.disablespawning)) {
      var3 = undefined;

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
        var3 = 10;
      } else if(istrue(level.exfilstarted)) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(26);
      } else if(scripts\mp\utility\game::isroundbased()) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(2);
      } else if(scripts\mp\utility\game::getgametype() == "oic" && scripts\mp\utility\game::matchmakinggame()) {
        scripts\mp\utility\lower_message::setlowermessageomnvar(78);
        var3 = 30;
      } else {
        scripts\mp\utility\lower_message::setlowermessageomnvar(18);
        var3 = 10;
      }

      if(!isDefined(self.revivetriggeravailable)) {
        thread removespawnmessageshortly(scripts\engine\utility::ter_op(isDefined(var3), var3, 6));
      }
    }

    if(self.sessionstate != "spectator") {
      var1 += (0, 0, 60);
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

      thread spawnspectator(var1, var2);
    }

    return;
  }

  if(self.waitingtospawn) {
    return;
  }

  self.waitingtospawn = 1;
  waitandspawnclient(var2);

  if(isDefined(self)) {
    self.waitingtospawn = 0;
    return;
  }
}

function waittillcanspawnclient(var0) {
  self endon("started_spawnPlayer");

  for(;;) {
    waitframe();

    if(self.team == "spectator" || self.team == "follower") {
      return;
    }

    if(isDefined(self) && (self.sessionstate == "spectator" || !scripts\mp\utility\player::isreallyalive(self))) {
      if(istrue(var0)) {
        self.pers["teamKillPunish"] = 0;
      }

      self.pers["lives"] = 1;
      thread spawnclient(var0);
      continue;
    }

    return;
  }
}

function waitandspawnclient(var0) {
  self endon("disconnect");
  self endon("end_respawn");
  level endon("game_ended");
  self notify("attempted_spawn");

  if(isDefined(level.ref_12888)) {
    [[level.ref_12888]](var0);
  }

  ref_1437c();
  var1 = 0;

  if(istrue(self.pers["teamKillPunish"])) {
    var2 = teamkilldelay();

    if(var2 > 0) {
      scripts\mp\utility\lower_message::setlowermessageomnvar(65, int(gettime() + var2 * 1000));
      thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
      var1 = 1;
      wait var2;
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

  var3 = timeuntilspawn(0);
  var4 = 0;

  if(!istrue(level.loadoutdefaultfiresalediscount)) {
    var4 = scripts\engine\utility::ter_op(istrue(level.snaptospawncamera), 1.25, 2);
  }

  if(istrue(level.usespawnselection)) {
    var4 = 0.5;
  }

  if(level.ingraceperiod && !self.hasspawned || level.gameended) {
    var4 = 0;
    var3 = 0;
  }

  var5 = 0;

  if(scripts\mp\utility\game::getgametype() == "hq" && isDefined(level.zone) && level.zone.ownerteam == self.team) {
    var5 = 1;
  }

  if(!istrue(self.skippedkillcam) && isDefined(self.killcamwatchtime) && !var5) {
    if(isDefined(self.tiers)) {
      var3 = max(self.tiers - self.killcamwatchtime, 0);
    } else {
      var3 = max(var3 - self.killcamwatchtime, 0);
    }

    self.killcamwatchtime = undefined;
  }

  if(isDefined(self.setspawnpoint)) {
    var4 = 0;
    var3 = 0;
  }

  var3 = max(var3, var4);

  if(scripts\mp\arbitrary_up::isinarbitraryup()) {
    var6 = self getworldupreferenceangles();
    var7 = anglestoup(var6);
    var8 = var7 * 60;
  } else {
    var8 = (0, 0, 60);
  }

  var9 = istrue(scripts\mp\flags::gameflag("prematch_done"));
  var10 = scripts\mp\flags::gameflag("infil_will_run") && !istrue(scripts\mp\flags::gameflag("infil_started"));

  if(scripts\mp\utility\game::getgametype() == "arm" && !var10 && !var9) {
    var11 = scripts\mp\gametypes\arm::getmissedinfilcamerapositions(self.team);
    var12 = spawn("script_model", var11.startorigin);
    var12 setModel("tag_origin");
    var12.angles = var11.startangles;
    self cameralinkTo(var12, "tag_origin");
    var12 moveTo(var11.endorigin, 18);
    var12 rotateTo(var11.endangles, 18);
    scripts\mp\flags::gameflagwait("prematch_done");
    var9 = 1;
    self cameraunlink();
  }

  if(!istrue(level.loadoutdefaultfiresalediscount) && var9 && !istrue(self.skipspawncamera) && !istrue(level.usespawnselection) && var4 > 0) {
    thread scripts\mp\spawncamera::startspawncamera();
  }

  if(istrue(level.usespawnselection) && !isDefined(self.setspawnpoint)) {
    scripts\mp\spawnselection::waitforspawnselection(var4, !istrue(var9));
  } else if(var4 > 0) {
    var13 = 9;

    if(scripts\mp\utility\game::getgametype() == "hq") {
      if(isDefined(level.zone)) {
        if(level.zone.ownerteam == self.team) {
          scripts\mp\utility\dialog::leaderdialogonplayer("hp_dead");
          var13 = 30;

          if(isDefined(self.suicidespawndelay)) {
            var4 -= getdvarfloat("scr_hq_suicidespawndelay");
            var4 = max(0, var4);
          }
        } else if(isDefined(self.suicidespawndelay) && getdvarfloat("scr_hq_suicidespawndelay") > 0 && level.zone.ownerteam == "neutral") {
          var13 = 31;
          self.suicidespawndelay = undefined;
        }
      }
    } else if(isDefined(self.suicidespawndelay) && getdvarfloat("scr_" + scripts\mp\utility\game::getgametype() + "_suicidespawndelay") > 0) {
      var13 = 31;
      self.suicidespawndelay = undefined;
    }

    scripts\mp\utility\lower_message::setlowermessageomnvar(var13, int(gettime() + var4 * 1000));

    if(!var3) {
      thread respawn_asspectator(self.origin + var8, self.angles);
    }

    var3 = 1;
    scripts\engine\utility::ref_143bf(var4, "force_spawn");

    if(!istrue(self.waitingtoselectclass)) {
      self notify("stop_wait_safe_spawn_button");
    }
  }

  if(needsbuttontorespawn()) {
    if(!istrue(self.waitingtoselectclass)) {
      scripts\mp\utility\lower_message::setlowermessageomnvar(1);
    }

    if(!var3) {
      thread respawn_asspectator(self.origin + var8, self.angles);
    }

    var3 = 1;
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
  thread spawnplayer(undefined, var1);
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

  var0 = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_waverespawndelay") > 0;

  if(var0) {
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

function removespawnmessageshortly(var0) {
  self endon("disconnect");
  level endon("game_ended");
  waittillframeend();
  self endon("end_respawn");
  wait var0;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

function tivalidationcheck() {
  if(!isDefined(self.setspawnpoint)) {
    return false;
  }

  if(isDefined(level.get_br_jugg_setting) && ![[level.get_br_jugg_setting]](self)) {
    return false;
  }

  var0 = getEntArray("care_package", "targetname");

  foreach(var2 in var0) {
    if(distancesquared(var2.origin, self.setspawnpoint.playerspawnpos) > 4096) {
      continue;
    }

    if(isDefined(var2.owner)) {
      scripts\mp\hud_message::showsplash("destroyed_insertion", undefined, var2.owner);
    }

    scripts\mp\equipment\tac_insert::ref_13681();
    return false;
  }

  var4 = (30, 30, 80);
  var5 = self.setspawnpoint.playerspawnpos - var4;
  var6 = self.setspawnpoint.playerspawnpos + var4;
  var7 = physics_createcontents(["physicscontents_vehicle"]);
  var8 = [];
  var9 = physics_aabbbroadphasequery(var5, var6, var7, var8);

  if(isDefined(var9) && var9.size > 0) {
    var10 = 1;

    foreach(var12 in var9) {
      var13 = var12.code_classname == "scriptable" || var12.code_classname == "worldspawn";

      if(!var13) {
        var10 = 0;
        break;
      }
    }

    if(!var10) {
      return false;
    }
  }

  var15 = self.setspawnpoint.playerspawnpos + (0, 0, 60);
  var16 = self.setspawnpoint.playerspawnpos + (0, 0, 1);
  var17 = [];
  GscBinSkip0(0x2e, 0, self);
}

function revivespawnvalidationcheck() {
  if(!isDefined(self.forcespawnorigin)) {
    return false;
  }

  var0 = spawnStruct();
  var0.ref_1368a = self.forcespawnorigin;
  var0.vandalize_spotlight_speed = 1;
  var1 = [];
  GscBinSkip0(0x2e, 0, self);
}

function spawningclientthisframereset() {
  self notify("spawningClientThisFrameReset");
  self endon("spawningClientThisFrameReset");
  waitframe();
  level.numplayerswaitingtospawn--;
}

function getplayerassets(var0) {
  var1 = spawnStruct();

  if(isDefined(var0.loadoutprimaryfullname) && var0.loadoutprimaryfullname != "none") {
    var1.primaryweapon = var0.loadoutprimaryfullname;
  }

  if(isDefined(var0.loadoutsecondaryfullname) && var0.loadoutsecondaryfullname != "none") {
    var1.secondaryweapon = var0.loadoutsecondaryfullname;
  }

  var2 = scripts\mp\teams::getcustomization();

  if(isDefined(var2["body"])) {
    var1.body = var2["body"];
  }

  if(isDefined(var2["head"])) {
    var1.head = var2["head"];
  }

  return var1;
}

function loadplayerassets(var0, var1, var2) {
  var3 = [];

  foreach(var5 in var0) {
    if(isDefined(var5.primaryweapon)) {
      var3 = var5.primaryweapon;
    }

    if(isDefined(var5.secondaryweapon)) {
      var3 = var5.secondaryweapon;
    }

    if(!istrue(var2)) {
      self loadcustomization(var5.body, var5.head, var1);
    }
  }

  if(var3.size > 0) {
    self loadweaponsforplayer(var3, var1);
    return;
  }
}

function allplayershaveassetsloaded(var0) {
  var1 = [];

  if(isDefined(var0.primaryweapon)) {
    GscBinSkip0(0x2e, var1.size, var0.primaryweapon);
  }

  if(isDefined(var0.secondaryweapon)) {
    GscBinSkip0(0x2e, var1.size, var0.secondaryweapon);
  }

  if(!self hasloadedviewweapons(var1)) {
    return false;
  }

  if(!self hasloadedcustomizationviewmodels(var0.body)) {
    return false;
  }

  return true;
}

function getspawnpoint() {
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;
  self.ti_spawn = 0;

  if(getdvarint("scr_useProfileSpawn", 0) != 0) {
    var3 = getspawnarray("mp_tdm_spawn_allies_start");
    var0 = var3[0];
    var1 = var0.origin;
    var2 = var0.angles;
  } else if(isDefined(self.forcespawnorigin)) {
    var4 = revivespawnvalidationcheck();

    if(!var4.vandalize_spotlight_speed && isDefined(self.prevrevivepos) && !isDefined(self.rallypoint)) {
      var1 = self.prevrevivepos;
    } else {
      var1 = self.forcespawnorigin;
      self.forcespawnorigin = undefined;
    }

    if(isDefined(self.forcespawnangles)) {
      var2 = self.forcespawnangles;
      self.forcespawnangles = undefined;
    } else {
      var2 = (0, randomfloatrange(0, 360), 0);
    }

    if(isDefined(self.reviver)) {
      if(positionwouldtelefrag(var1) || !var4.vandalize_spotlight_speed) {
        var0 = scripts\mp\spawnscoring::findteammatebuddyspawn(self.reviver);
        self.reviver = undefined;

        if(isDefined(var0)) {
          var1 = var0.origin;
          var2 = var0.angles;
        }
      } else {
        var1 = var4.ref_1368a;
      }
    }
  } else if(isDefined(self.setspawnpoint)) {
    var0 = self.setspawnpoint;

    if(!istrue(self.setspawnpoint.notti)) {
      if(istrue(level.unset_relic_laststandmelee) && level.mapname != "mp_aniyah") {
        self.ref_11d9e = undefined;
        var5 = scripts\engine\utility::ter_op(istrue(level.brmini_playerwelcomesplashes), 1, istrue(self.setspawnpoint.issuper));

        if(var5) {
          var6 = min(level.steam_fx_on - self.setspawnpoint.playerspawnpos[2], level.steam_fx_on);

          if(var6 < level.steam_fx_on - 950) {
            var6 += 950;
          }

          self.setspawnpoint.playerspawnpos += (0, 0, var6);
          self.updatearenaomnvardata = 1;
        }
      }

      self.ti_spawn = 1;
      self playlocalsound("tactical_spawn");

      if(level.teambased) {
        foreach(var8 in level.teamnamelist) {
          if(var8 != self.team) {
            self playsoundtoteam("tactical_spawn", var8);
          }
        }
      } else {
        self playSound("tactical_spawn");
      }
    }

    foreach(var11 in level.ugvs) {
      if(distancesquared(var11.origin, var0.playerspawnpos) < 1024) {
        var11 notify("damage", 5000, var11.owner, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, getcompleteweaponname("killstreak_jammer_mp"));
      }
    }

    var1 = self.setspawnpoint.playerspawnpos;
    var2 = self.setspawnpoint.playerspawnangles;
    scripts\mp\equipment\tac_insert::ref_13681(0, 1);
    var0 = undefined;
  } else if(istrue(level.usespawnselection) && istrue(scripts\mp\flags::gameflag("prematch_done"))) {
    var0 = scripts\mp\spawnselection::getspawnpoint();
    var1 = var0.origin;
    var2 = var0.angles;
  } else {
    var0 = self[[level.getspawnpoint]]();
    var1 = var0.origin;
    var2 = var0.angles;
  }

  var13 = spawnStruct();
  var13.spawnpoint = var0;
  var13.spawnorigin = var1;

  if(!isDefined(var2)) {
    var2 = (0, 0, 0);
  }

  var13.spawnangles = (0, var2[1], 0);
  return var13;
}

function spawnplayer(var0, var1) {
  self endon("disconnect");
  self endon("joined_spectators");
  self notify("spawned");
  self notify("end_respawn");
  self notify("started_spawnPlayer");

  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(scripts\mp\utility\game::teamhasinfil(self.team) && !scripts\mp\flags::gameflag("infil_started") && !isDefined(level.bypassclasschoicefunc)) {
    if(getdvarint("scr_force_cac_sre_callstack", 0) == 1 && scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "sandbox" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
      var2 = scripts\mp\utility\game::teamhasinfil(self.team);
      var3 = scripts\mp\flags::gameflag("infil_started");
      var4 = isDefined(level.bypassclasschoicefunc);
      scripts\mp\utility\script::laststand_dogtags("spawnPlayer()" + self.name + " ui_options_menu = 2, hasInfil = " + var2 + " infil_started = " + var3 + "bypassClassChoiceFunc = " + var4);
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
  var6 = scripts\mp\class::preloadandqueueclass(self.class, 1);
  goto LOC_00000257;
}

function ref_119cb(var0) {
  if(isDefined(var0)) {
    self dlog_recordplayerevent("dlog_event_loadout_copy", ["receiver_player_client_id", self.clientid, "receiver_gamertag", self.name, "giver_player_client_id", var0.clientid, "giver_gamertag", var0.name]);
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

function playerprematchallow(var0) {
  self allowmovement(var0);
  scripts\common\utility::allow_fire(var0, "prematch");
  scripts\mp\equipment::allow_equipment(var0, "prematch");
  scripts\common\utility::allow_supers(var0, "prematch");
  scripts\common\utility::allow_jump(var0, "prematch");
  scripts\common\utility::allow_melee(var0, "prematch");
  scripts\common\utility::allow_sprint(var0, "prematch");
  scripts\common\utility::allow_killstreaks(var0, "prematch");

  if(!istrue(level.loadout_updateammo)) {
    scripts\common\utility::allow_mount_top(var0, "prematch");
    scripts\common\utility::allow_mount_side(var0, "prematch");
    return;
  }
}

function allowprematchlook(var0) {
  var0[[level.prematchallowfunc]](0);
  var0.prematchlook = 1;
}

function clearprematchlook(var0) {
  if(istrue(var0.prematchlook) && !level.gameended) {
    var0[[level.prematchallowfunc]](1);
    var0.prematchlook = undefined;
    return;
  }
}

function waitforversusmenudone() {
  level endon("prematch_over");
  self endon("versus_menu_done");

  for(;;) {
    self waittill("luinotifyserver", var0, var1);

    if(var0 == "versus_done") {
      self notify("versus_menu_done");
    }
  }
}

function ref_13ffb(var0) {
  var0 endon("death_or_disconnect");

  for(;;) {
    var0 getbeingrevived();
    var0 getmid2damage();
    wait 0.05;
  }
}

function spawnspectatormapcam(var0) {
  var1 = 6;
  var2 = 4;
  var3 = 4;
  var4 = 0;
  self endon("disconnect");

  if(isai(self)) {
    return;
  }

  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("NSSLSNKPN", "0.65");
  } else {
    self setclientdvars("NSSLSNKPN", "1");
  }

  self setclientomnvar("ui_mapshot_camera", 1);
  self lerpfovbypreset("mapflyover");
  var5 = scripts\engine\utility::getStructArray("camera_intro", "targetname");

  switch (level.mapname) {
    case "mp_village2":
      var5[0].origin = (1606.95, 2238.61, 958.77);
      var5[0].angles = (17, 215, -4.14);
      break;
    case "mp_backlot2":
      var5[0].origin = (310, -627, 279);
      var5[0].angles = (4, 196, 0);
      break;
    case "mp_hideout":
      var5[0].origin = (1867, -2487, 664);
      var5[0].angles = (15, 118, 0);
      break;
    case "mp_crash2":
      var5[0].origin = (-856, 2771, 1030);
      var5[0].angles = (18, 313, 0);
      break;
    case "mp_m_king":
      var5[0].origin = (691, -536, 223);
      var5[0].angles = (9, 159, 0);
      GscBinSkip0(0x2e, 1, spawnStruct());

    case "mp_m_pine":
      var5[0].origin = (1260, 203, 239);
      var5[0].angles = (15, 189, 0);
      GscBinSkip0(0x2e, 1, spawnStruct());

    case "mp_m_showers":
      var5[0].origin = (2446, 19, 377);
      var5[0].angles = (24, 178, 0);
      GscBinSkip0(0x2e, 1, spawnStruct());

    case "mp_m_hill":
      var5[0].origin = (254, 1651, 353);
      var5[0].angles = (10, 253, 0);
      GscBinSkip0(0x2e, 1, spawnStruct());
  }

  if(var5.size == 0 || scripts\mp\flags::gameflag("infil_will_run")) {
    self visionsetfadetoblackforplayer("", 0.75);
    return;
  }

  var6 = undefined;
  var7 = undefined;
  var8 = undefined;
  setspawnvariables();
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\utility\player::updatesessionstate("spectator");
  self.pers["team"] = "spectator";
  self.team = "spectator";
  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonspectate();

  foreach(var11, var10 in level.teamnamelist) {
    self allowspectateteam(var10, 0);
  }

  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);

  if(isDefined(var5) && var5.size > 1 && !istrue(var4)) {
    var12 = randomintrange(0, var5.size - 1);
    var6 = var5[var12];
  } else if(isDefined(var5)) {
    var6 = var5[0];

    if(istrue(var4)) {
      var8 = var5[1];
    }
  }

  var6.fil = 1;
  scripts\mp\utility\player::_freezecontrols(1, undefined, "spectatorMapCam");
  self setspectatedefaults(var6.origin, var6.angles);
  self spawn(var6.origin, var6.angles);
  scripts\mp\utility\player::ref_12898("playerlogic::spawnSpectatorMapCam() !!!CODE SPAWN!!! @" + var6.origin);
  var13 = spawn("script_model", var6.origin);
  var13 setModel("tag_origin");
  var13.angles = var6.angles;
  var14 = undefined;

  if(istrue(var4)) {
    var14 = spawn("script_model", var8.origin);
    var14 setModel("tag_origin");
    var14.angles = var8.angles;
  }

  thread waitforversusmenudone();

  if(isDefined(var0) && var0 == 99) {
    var15 = "debug";
  } else if(scripts\mp\flags::gameflag("prematch_done")) {
    var15 = "prematch_over";
  } else if(self.versusdone) {
    var15 = "versus_menu_done";
  } else {
    var15 = scripts\engine\utility::ref_143ba(2, "versus_menu_done", "prematch_over");
  }

  if(var15 == "timeout") {
    if(scripts\mp\flags::gameflag("prematch_done")) {
      var15 = "prematch_over";
    } else {
      var15 = "versus_menu_done";
    }
  }

  if(var15 == "prematch_over") {
    self visionsetfadetoblackforplayer("", 0.75);
    return;
  }

  if(self issplitscreenplayer() && self issplitscreenplayerprimary()) {
    var16 = self getothersplitscreenplayer();
    var16 notify("versus_menu_done");
    waitframe();
  }

  self cameralinkTo(var15, "tag_origin", 1);
  var17 = scripts\cp_mp\utility\game_utility::getmapname();
  self notify("mapCamera_start");

  switch (var17) {
    case "mp_parkour":
      var15 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_parkour");
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait var4 - 0.25;
      return;
    default:
      break;
  }

  wait 0.25;
  self visionsetfadetoblackforplayer("", 0.75);
  self playlocalsound("mp_camera_intro_whoosh");
  var18 = var9;
  var10 = spawnStruct();
  var10 = scripts\engine\utility::getStruct(var9.target, "targetname");

  switch (level.mapname) {
    case "mp_village2":
      var10[0].origin = (1925, -857, 1033);
      var10[0].angles = (362, 127, 0);
      break;
    case "mp_backlot2":
      var10[0].origin = (-399, -1457, 667);
      var10[0].angles = (15, 57, 0);
      break;
    case "mp_hideout":
      var10[0].origin = (1422, 2073, 464);
      var10[0].angles = (6, 236, 0);
      break;
    case "mp_crash2":
      var10[0].origin = (1559, 1586, 1030);
      var10[0].angles = (30, 234, 0);
      break;
    case "mp_m_king":
      var10[0].origin = (921, 300, 223);
      var10[0].angles = (8, 202, 0);
      var10 = spawnStruct();
      var10[1].origin = (415, 372, 14);
      var10[1].angles = (3, 179, 0);
      break;
    case "mp_m_pine":
      var10[0].origin = (714, 440, 167);
      var10[0].angles = (13, 205, 0);
      var10 = spawnStruct();
      var10[1].origin = (-859, -349, 75);
      var10[1].angles = (7, 104, 0);
      break;
    case "mp_m_showers":
      var10[0].origin = (1952, 354, 77);
      var10[0].angles = (6, 208, 0);
      var10 = spawnStruct();
      var10[1].origin = (906, 9, 15);
      var10[1].angles = (0, 0, 0);
      var7 = 1;
      break;
    case "mp_m_hill":
      var10[0].origin = (-1332, 483, 252);
      var10[0].angles = (11, 313, 0);
      var10 = spawnStruct();
      var10[1].origin = (65, -547, 351);
      var10[1].angles = (16, 83, 0);
      break;
  }

  var19 = 0;

  for(;;) {
    if(isDefined(var18.speedadjust)) {
      var20 = 1 / var18.speedadjust;
      var21 = var20 * distance(var18.origin, var10[0].origin);
    } else {
      var21 = distance(var18.origin, var10[0].origin);
    }

    var19 += var21;
    var18.distancetotarg = var21;
    var18 = var10[0];

    if(isDefined(var18.target)) {
      var10 = scripts\engine\utility::getStruct(var18.target, "targetname");
      continue;
    }

    break;
  }

  var18.eol = 1;
  var18 = var9;
  var10 = scripts\engine\utility::getStruct(var9.target, "targetname");

  for(;;) {
    var22 = var18.distancetotarg / var19;
    var23 = scripts\engine\utility::ter_op(istrue(var7), var22 * var5, var22 * var4);

    if(isDefined(var10[0].eol)) {
      var24 = var23 / 2;
    } else {
      var24 = 0;
    }

    if(isDefined(var18.fil)) {
      var25 = var23 / 2;
    } else {
      var25 = 0;
    }

    var15 moveTo(var10[0].origin, var23, var25, var24);
    var15 rotateTo(var10[0].angles, var23, var25, var24);

    if(isDefined(var10[0].eol)) {
      var26 = int(var23 / 2);
      wait var26;
      wait var26;
    } else {
      wait var23;
    }

    var18 = var10[0];

    if(isDefined(var18.target)) {
      var10 = scripts\engine\utility::getStruct(var18.target, "targetname");
      continue;
    }

    break;
  }

  if(istrue(var7)) {
    var19 = 0;
    var27 = var11;
    self spawn(var11.origin, var11.angles);
    self cameralinkTo(var15, "tag_origin", 1);
    wait 0.25;
    self visionsetfadetoblackforplayer("", 0.75);
    self playlocalsound("mp_camera_intro_whoosh");

    for(;;) {
      if(isDefined(var27.speedadjust)) {
        var20 = 1 / var27.speedadjust;
        var21 = var20 * distance(var27.origin, var10[1].origin);
      } else {
        var21 = distance(var27.origin, var10[1].origin);
      }

      var19 += var21;
      var27.distancetotarg = var21;

      if(isDefined(var27.target)) {
        var10 = scripts\engine\utility::getStruct(var18.target, "targetname");
        continue;
      }

      break;
    }

    var27.eol = 1;
    var27.fil = 1;
    var10[1].eol = 1;

    for(;;) {
      var22 = var27.distancetotarg / var19;
      var23 = scripts\engine\utility::ter_op(istrue(var7), var22 * var6, var22 * var4);

      if(isDefined(var10[1].eol)) {
        var24 = var23 / 2;
      } else {
        var24 = 0;
      }

      if(isDefined(var27.fil)) {
        var25 = var23 / 2;
      } else {
        var25 = 0;
      }

      var15 moveTo(var10[1].origin, var23, var25, var24);
      var15 rotateTo(var10[1].angles, var23, var25, var24);

      if(isDefined(var10[1].eol)) {
        var26 = int(var23 / 2);
        wait var26;
        wait var26;
      } else {
        wait var23;
      }

      var27 = var10[1];

      if(isDefined(var27.target)) {
        var10 = scripts\engine\utility::getStruct(var27.target, "targetname");
        continue;
      }

      break;
    }
  }

  scripts\mp\utility\player::_freezecontrols(0, undefined, "spectatorMapCam");
  self.startcament = var15;
  self setclientomnvar("ui_mapshot_camera", 0);
}

function spawnspectator(var0, var1, var2) {
  self notify("spawned");
  self notify("end_respawn");
  self notify("joined_spectators");
  level notify("joined_spectators", self);
  self.ref_1363e = 1;

  if(isDefined(self.deathspectatepos)) {
    var0 = self.deathspectatepos;
    var1 = vectortoangles(self.origin - self.deathspectatepos);
  }

  if(isDefined(self.startcament) && !isDefined(var0)) {
    var0 = self.startcament.origin;
    var1 = self.startcament.angles;
    self.startcament delete();
  }

  in_spawnspectator(var0, var1, var2);
}

function respawn_asspectator(var0, var1) {
  if(isDefined(self.deathspectatepos)) {
    var0 = self.deathspectatepos;

    if(isDefined(self.deathspectateangles)) {
      var1 = self.deathspectateangles;
    } else {
      var1 = vectortoangles(self.origin - self.deathspectatepos);
    }
  }

  in_spawnspectator(var0, var1);
}

function in_spawnspectator(var0, var1, var2) {
  setspawnvariables();
  var3 = self.pers["team"];

  if(isDefined(var3) && (var3 == "spectator" || var3 == "follower") && !level.gameended) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }

  scripts\mp\class::loadout_clearperks();
  scripts\mp\utility\player::updatesessionstate("spectator");
  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonspectate();
  scripts\mp\spectating::setspectatepermissions();
  onspawnspectator(var0, var1, var2);

  if(level.teambased && !level.splitscreen && !self issplitscreenplayer()) {
    scripts\mp\utility\player::setdof_spectator();
    return;
  }
}

function getplayerfromclientnum(var0) {
  if(var0 < 0) {
    return undefined;
  }

  for(var1 = 0; var1 < level.players.size; var1++) {
    if(level.players[var1] getentitynumber() == var0) {
      return level.players[var1];
    }
  }

  return undefined;
}

function onspawnspectator(var0, var1, var2) {
  if(isDefined(var0) && isDefined(var1)) {
    self setspectatedefaults(var0, var1);
    self spawn(var0, var1);
    scripts\mp\utility\player::ref_12898("playerlogic::onSpawnSpectator() !!!CODE SPAWN!!! @" + var0);
    return;
  }

  var3 = getspectatepoint();

  if(istrue(level.usespawnselection)) {
    if(self.sessionteam == "allies") {
      var3 = level.spawncameras["gw_fob_alliesHQ"]["allies"];
    } else if(self.sessionteam == "axis") {
      var3 = level.spawncameras["gw_fob_axisHQ"]["axis"];
    }
  }

  var4 = 8;

  if(isDefined(level.camerapos) && level.camerapos.size) {
    for(var5 = 0; var5 < level.camerahighestindex + 1 && var5 < var4; var5++) {
      if(!isDefined(level.camerapos[var5]) || !isDefined(level.cameraang[var5])) {
        continue;
      }

      self setmlgcameradefaults(var5, level.camerapos[var5], level.cameraang[var5]);
      level.cameramapobjs[var5].origin = level.camerapos[var5];
      level.numbermapobjs[var5].origin = level.camerapos[var5];
      level.cameramapobjs[var5].angles = level.cameraang[var5];
      level.numbermapobjs[var5].angles = level.cameraang[var5];
    }
  } else {
    for(var5 = 0; var5 < var5; var5++) {
      self setmlgcameradefaults(var5, var4.origin, var4.angles);
    }
  }

  self setspectatedefaults(var4.origin, var4.angles);

  if(isDefined(var3)) {
    self allowspectateteam("freelook", 1);
    self allowspectateteam("none", 1);
  }

  if(scripts\mp\utility\game::unset_relic_landlocked() && !self.hasspawned) {
    self predictstreampos(var4.origin);
  }

  self spawn(var4.origin, var4.angles);
  scripts\mp\utility\player::ref_12898("playerlogic::onSpawnSpectator() !!!CODE SPAWN!!! @" + var4.origin);
}

function getspectatepoint() {
  var0 = getEntArray("mp_global_intermission", "classname");
  var1 = [];

  if(scripts\mp\utility\game::getgametype() == "brtdm") {
    return level.endsuperdisableweaponbr.ref_136dc;
  }

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    if(level.localeid == "locale_6") {
      var2 = spawn("script_origin", (25642, -26550, 1818));
      var2.angles = (14, 101, 0);
      return var2;
    } else if(level.localeid == "locale_3") {
      var2 = spawn("script_origin", (34440, -18522, 995));
      var2.angles = (10, 281, 0);
      return var2;
    }

    var2 = undefined;

    foreach(var4 in var2) {
      if(isDefined(var4.script_noteworthy) && var4.script_noteworthy == level.localeid) {
        var2 = var4;
      }
    }

    if(isDefined(var2)) {
      return var2;
    } else {
      foreach(var4 in var2) {
        if(!isDefined(var4.script_noteworthy) || !issubstr(var4.script_noteworthy, "locale")) {
          var2 = var4;
          continue;
        }

        var4 delete();
      }
    }
  } else if(var2.size != 1) {
    foreach(var4 in var2) {
      if(!isDefined(var4.script_noteworthy) || !issubstr(var4.script_noteworthy, "locale")) {
        var2 = var4;
        continue;
      }

      var4 delete();
    }
  } else {
    var2 = var2;
  }

  var4 = scripts\mp\spawnlogic::getspawnpoint_random(var2);
  return var4;
}

function spawnintermission(var0, var1, var2) {
  self endon("disconnect");
  self notify("spawned");
  self notify("end_respawn");

  if(!isDefined(var1)) {
    var1 = "intermission";
  }

  if(!isDefined(var2)) {
    var2 = 1;
  }

  setspawnvariables();
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\utility\lower_message::clearlowermessages();
  scripts\mp\utility\player::_freezecontrols(1, undefined, "spawnIntermission");

  if(var2) {
    self setclientdvar("LQKPQMPRQN", 1);
  }

  if(isDefined(level.finalkillcam_winner) && level.finalkillcam_winner != "none" && isDefined(level.match_end_delay) && scripts\mp\utility\game::waslastround() && !istrue(level.doingbroshot)) {
    wait level.match_end_delay;
  }

  if(!istrue(level.doingbroshot)) {
    scripts\mp\utility\player::updatesessionstate(var1);
  }

  scripts\mp\utility\player::clearkillcamstate();
  self.friendlydamage = undefined;

  if(!isDefined(var0)) {
    if(!isDefined(level.localeid)) {
      var3 = getEntArray("mp_global_intermission", "classname");
      var3 = scripts\mp\spawnscoring::checkdynamicspawns(var3);
      var0 = var3[0];
    } else {
      var0 = getspectatepoint();
    }
  }

  if(!isDefined(level.custom_ending)) {
    self spawn(var0.origin, var0.angles);
    scripts\mp\utility\player::ref_12898("playerlogic::spawnIntermission() !!!CODE SPAWN!!! @" + var0.origin);
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

function callback_playerdisconnect(var0) {
  if(!isDefined(self.connected)) {
    return;
  }

  self.locationtriggersetpaused = 1;

  if(scripts\mp\utility\game::getgametype() == "br" && self isinexecutionvictim() && isalive(self)) {
    var1 = self scriptablecanbepinged();

    if(!isbot(self)) {
      var2 = self.health;

      if(scripts\mp\damage::ref_1331e(self)) {
        var1 scripts\mp\utility\stats::incpersstat("damage", var2);

        if(!isDefined(var1.isbecomingzombie)) {
          var1.isbecomingzombie = var2;
        } else {
          var1.isbecomingzombie += var2;
        }
      } else if(isDefined(level.ref_12001)) {
        var1[[level.ref_12001]](var2);
      }

      var1 scripts\mp\gametypes\br_public::updatebrscoreboardstat("damageDealt", var1.pers["damage"]);
      self kill(self.origin, var1, var1, "MOD_EXECUTION");
      self notify("disconnect");
    }
  }

  if(getdvarint("TLRPKRKMS") != 0) {
    var3 = getmatchdata("commonMatchData", "player_count_left");
    var3++;
    setmatchdata("commonMatchData", "player_count_left", var3);
  }

  var4 = undefined;

  if(scripts\mp\utility\game::getgametype() == "br") {
    if(istrue(self.pers["hasDoneAnyCombat"]) || istrue(self.pers["participation"])) {
      var4 = "eliminated";
    }

    if(scripts\mp\utility\game::round_vehicle_logic() == "br") {
      var5 = [];

      foreach(var7 in scripts\mp\utility\teams::getenemyteams(self.team)) {
        if(scripts\mp\utility\teams::getteamdata(var7, "aliveCount")) {
          var5 = var7;
        }
      }

      var9 = var5.size + 1;
      scripts\cp_mp\utility\game_utility::ref_13168(var9);
    }
  }

  if(isDefined(level.music_timer_10seconds)) {
    var4 = level.music_timer_10seconds;
  }

  scripts\cp_mp\utility\game_utility::stopkeyearning(var4);

  if(scripts\mp\utility\killstreak::iscontrollingproxyagent()) {
    self restorecontrolagent();
  }

  removeplayerondisconnect();
  scripts\mp\spawnlogic::removefromparticipantsarray();
  scripts\mp\spawnlogic::removefromcharactersarray();
  scripts\cp_mp\utility\player_utility::ref_12c03();
  var10 = self getentitynumber();

  if(!level.teambased) {
    game["roundsWon"][self.guid] = undefined;
  }

  if(level.splitscreen) {
    var11 = level.players;

    if(var11.size <= 1) {
      level thread scripts\mp\gamelogic::forceend();
    }
  }

  if(isDefined(self.kills) && isDefined(self.deaths)) {
    if(scripts\mp\utility\game::getgametype() == "arena" && 3 > self.timeplayed["total"]) {
      if(!isDefined(self.arenadamage)) {
        return;
      }

      var12 = self.arenadamage;
      setplayerteamrank(self, self.clientid, var12);
    } else if(120 < self.timeplayed["total"]) {
      var13 = (self.kills - self.deaths) / self.timeplayed["total"] / 60;
      setplayerteamrank(self, self.clientid, var13);
    }
  }

  var14 = self getentitynumber();
  var15 = self.guid;
  logprint("Q;" + var15 + ";" + var14 + ";" + self.name + "\n");

  if(drawentitybounds()) {
    analyticsstreamerlogfiletagplayer("Q;" + var15 + ";" + var14 + ";" + self.name + "\n");
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
  scripts\common\utility::ref_13e0a(level.ref_11b2c, var0);

  if(level.players.size == 0) {
    thread mp_oilrig_patches();
    return;
  }
}

function mp_oilrig_patches() {
  level notify("endEmptyGameWatcher");
  level endon("endEmptyGameWatcher");
  level endon("connected");
  var0 = getdvarfloat("scr_disconnect_shutdown_amnesty_time", 30);
  wait var0;

  if(scripts\mp\utility\game::getgametype() == "br" && getdvarint("scr_data_force_send_matchdata_for_no_players_left", 1) == 1 && istrue(level.br_prematchstarted)) {
    scripts\mp\gamelogic::ref_1301f();
  }

  thread scripts\mp\gamelogic::endgame(undefined, game["end_reason"]["host_ended_game"]);
}

function removeplayerondisconnect() {
  var0 = 0;

  for(var1 = 0; var1 < level.players.size; var1++) {
    if(level.players[var1] == self) {
      var0 = 1;

      while(var1 < level.players.size - 1) {
        level.players[var1] = level.players[var1 + 1];
        var1++;
      }

      level.players[var1] = undefined;
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
    self setclientdvars("NSSLSNKPN", "0.75");
    setDvar("r_materialBloomHQScriptMasterEnable", 0);
    return;
  }

  self setclientdvars("NSSLSNKPN", "1");
}

function initclientdvars() {
  setDvar("LOPKSRNTTS", 1);
  setDvar("LROTSRRQMQ", 1);

  if(level.hardcoremode) {
    setDvar("LOPKSRNTTS", 0);
    setDvar("LROTSRRQMQ", 1);
  }

  if(isDefined(level.alwaysdrawfriendlynames) && level.alwaysdrawfriendlynames) {
    setDvar("NKMOPQSPMO", 1);
  } else {
    setDvar("NKMOPQSPMO", 0);
  }

  self setclientdvars("cg_drawSpectatorMessages", 1);
  initclientdvarssplitscreenspecific();

  if(scripts\mp\utility\game::getgametypenumlives()) {
    if(level.teambased) {
      self setclientdvars("QKMSSSLPK", 0, "SKNSKQTQR", 1, "OLKRNORMOQ", 1, "LTLQSKRKQM", 0);
    } else {
      self setclientdvars("QKMSSSLPK", 1, "SKNSKQTQR", 0, "OLKRNORMOQ", 0, "LTLQSKRKQM", 0);
    }
  } else {
    self setclientdvars("QKMSSSLPK", 0, "SKNSKQTQR", 1, "OLKRNORMOQ", 1, "LTLQSKRKQM", 0);
  }

  if(level.teambased) {
    self setclientdvars("LQKPQMPRQN", 0);
  }

  self setclientdvar("ui_altscene", 0);

  if(getdvarint("scr_hitloc_debug")) {
    for(var0 = 0; var0 < 6; var0++) {
      self setclientdvar("ui_hitloc_" + var0, "");
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
    for(var0 = 0; var0 < level.players_waiting_for_callback.size; var0++) {
      var1 = level.players_waiting_for_callback[var0];

      if(isDefined(var1)) {
        level notify("connected", var1);
        var1 notify("connected_continue");
        level.players_waiting_for_callback[var0] = undefined;
        break;
      }
    }

    var2 = scripts\engine\utility::array_removeundefined(level.players_waiting_for_callback);
    level.players_waiting_for_callback = var2;
    waitframe();
  }
}

function onversusdone(var0, var1) {
  if(var0 != "versus_done") {
    return;
  }

  self.versusdone = 1;
}

function initsegmentstats() {
  level endon("game_ended");
  thread recordplayersegmentdata();

  for(;;) {
    level waittill("connected", var0);
    thread createplayersegmentstats(level);
  }
}

function recordplayersegmentdata() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 4;

  for(;;) {
    wait 1;

    foreach(var1 in level.players) {
      if(istrue(var1.get_baseaccuracy)) {
        thread updateplayersegmentdata();
      }
    }
  }
}

function createplayersegmentstats(var0) {
  var0 endon("disconnect");
  var0 waittill("spawned_player");
  var0.segments = [];
  var0.segments["distanceTotal"] = 0;
  var0.segments["movingTotal"] = 0;
  var0.segments["movementUpdateCount"] = 0;
  var0.savedsegmentposition = var0.origin;
  var0.positionptm = var0.origin;
  var0.get_baseaccuracy = 1;
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
    var0 = distance2d(self.positionptm, self.origin);
    self.positionptm = self.origin;

    if(var0 > 16) {
      self.segments["movingTotal"]++;
      return;
    }

    return;
  }
}

function shouldshowwidemapshot(var0) {
  return scripts\mp\utility\game::getgametype() != "br" && scripts\mp\utility\game::getgametype() != "arm" && var0 < level.prematchperiod && !istrue(self.btestclient) && !scripts\mp\flags::gameflag("infil_will_run");
}

function setuipregamefadeup(var0) {
  var1 = newclienthudelem(self);
  var1.x = 0;
  var1.y = 0;
  var1.alignx = "left";
  var1.aligny = "top";
  var1.sort = 1;
  var1.horzalign = "fullscreen";
  var1.vertalign = "fullscreen";
  var1.foreground = 1;
  var2 = 0;
  var3 = 0.5;

  if(isDefined(var2) && var2 > 0) {
    var1.alpha = 0;
  } else {
    var1.alpha = 1;
  }

  var1 setshader("black", 640, 480);

  if(isDefined(var2) && var2 > 0) {
    if(isDefined(self)) {
      self notify("fadeDown_start");
    }

    var1 fadeovertime(var2);
    var1.alpha = 1;
    wait var2;
  }

  if(isDefined(self)) {
    self waittill(var0);
  }

  var1 fadeovertime(var3);
  var1.alpha = 0;
  wait var3;

  if(isDefined(var1)) {
    var1 destroy();
    return;
  }
}

function friendlystatuschangedcallback() {
  self.pers["streamSyncComplete"] = 1;
  self notify("player_active");

  if(isDefined(self.team) && scripts\mp\utility\teams::isgameplayteam(self.team)) {
    [var1] = scripts\mp\teams::getoperatorcustomization();
    var2 = var0[1];
    self setcustomization(var1, var2);

    if(!isDefined(var1) || var1 == "") {
      var3 = scripts\mp\teams::lookupcurrentoperator(self.team);
      var4 = scripts\mp\teams::lookupcurrentoperatorskin(self.team);
      scripts\mp\utility\script::laststand_dogtags("getOperatorCustomization() returned empty body for player " + self getentitynumber() + ", team " + self.team + ", operatorIndex " + var3 + ", operatorSkinIndex " + var4);
      return;
    }

    if(!isDefined(var2) || var2 == "") {
      var3 = scripts\mp\teams::lookupcurrentoperator(self.team);
      var4 = scripts\mp\teams::lookupcurrentoperatorskin(self.team);
      scripts\mp\utility\script::laststand_dogtags("getOperatorCustomization() returned empty head for player " + self getentitynumber() + ", team " + self.team + ", operatorIndex " + var3 + ", operatorSkinIndex " + var4);
      return;
    }

    return;
  }
}

function ref_119cd() {
  var0 = isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self);

  if(scripts\mp\utility\game::rankingenabled()) {
    var1 = self getplayerdata("common", "mpProgression", "playerLevel", "xp");
    var2 = self getplayerdata("mp", "playerStats", "combatStats", "kills");
    var3 = self getplayerdata("mp", "playerStats", "combatStats", "deaths");
    var4 = self getplayerdata("mp", "playerStats", "matchStats", "wins");
    var5 = self getplayerdata("mp", "playerStats", "matchStats", "losses");
    var6 = self getplayerdata("mp", "playerStats", "combatStats", "hits");
    var7 = self getplayerdata("mp", "playerStats", "combatStats", "misses");
    var8 = self getplayerdata("mp", "playerStats", "combatStats", "wallbangs");
    var9 = self getplayerdata("mp", "playerStats", "combatStats", "nearMisses");
    var10 = self getplayerdata("mp", "playerStats", "matchStats", "gamesPlayed");
    var11 = self getplayerdata("mp", "playerStats", "matchStats", "timePlayedTotal");
    var12 = self getplayerdata("mp", "playerStats", "matchStats", "score");
    var13 = self getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");
  } else {
    var1 = 0;
    var2 = 0;
    var3 = 0;
    var4 = 0;
    var5 = 0;
    var6 = 0;
    var7 = 0;
    var8 = 0;
    var9 = 0;
    var10 = 0;
    var11 = 0;
    var12 = 0;
    var13 = 0;
  }

  var14 = self updatelastcovertime();
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

  var0 = 1;

  if(isDefined(level.ref_12065)) {
    var0 = self thread[[level.ref_12065]]();
  }

  if(scripts\mp\flags::gameflag("prematch_done") && istrue(level.usespawnselection) && isDefined(self.sessionteam)) {
    if(self.sessionteam == "allies") {
      var1 = level.spawncameras["gw_fob_alliesHQ"]["allies"];
      self setadditionalstreampos(var1.origin, 1);
    } else if(self.sessionteam == "axis") {
      var1 = level.spawncameras["gw_fob_axisHQ"]["axis"];
      self setadditionalstreampos(var1.origin, 1);
    }
  }

  self visionsetfadetoblackforplayer("bw", 0);
  var2 = "connected_continue";
  var3 = scripts\mp\utility\game::gettimepassed() / 1000 + 6;

  if(!isDefined(self.pers["streamSyncComplete"]) && (shouldshowwidemapshot(var3) || level.gametype == "arm")) {
    var2 = "player_active";
  }

  thread setuipregamefadeup(var2);
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
    var4 = 0;
    var5 = getdvarint("scr_skip_connected_msg_until_time", 0);

    if(var5 > 0) {
      if(isDefined(level.starttime)) {
        var6 = (gettime() - level.starttime) / 1000;

        if(var6 <= var5) {
          var4 = 1;
        }
      } else {
        var4 = 1;
      }
    }

    if(var4 == 0) {}
  }

  self.usingonlinedataoffline = self isusingonlinedataoffline();
  initclientdvars();
  initplayerstats();
  scripts\mp\accolades::applyaccoladestructtoplayerpers();

  if(getDvar("LLQQOPKTKM") == "1") {
    level waittill("eternity");
  }

  self.guid = scripts\mp\utility\player::getuniqueid();
  var7 = 0;

  if(!isDefined(self.pers["clientid"])) {
    self.pers["clientid"] = game["clientid"];
    game["clientid"]++;
    var8 = repair_grill_fixing_long_sfx();

    if(game["clientid"] >= var8) {
      game["clientid"] = var8 - 1;
      self.pers["clientid"] = var8 - 1;
    }

    var7 = 1;
    self.pers["matchdataWeaponStats"] = [];
    self.pers["matchdataScoreEventCounts"] = [];
    self.pers["xpAtLastDeath"] = 0;
    self.pers["scoreAtLastDeath"] = 0;
  }

  if(istrue(level.flashpointactive)) {
    thread scripts\mp\flashpoint::flashpoint_trackplayerevents(self);
  }

  if(var7) {
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

  if(getdvarint("TLRPKRKMS") != 0) {
    var9 = getmatchdata("commonMatchData", "player_count");

    if(var7) {
      var9++;
      setmatchdata("commonMatchData", "player_count", var9);
    }

    if(isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self)) {
      var10 = 1;
    } else {
      var10 = 0;
    }

    if(scripts\mp\utility\game::matchmakinggame() && !scripts\mp\utility\game::denysystemicteamchoice() && !var10) {}
  }

  if(var9) {
    ref_119cd();
  }

  if(level.uniqueplayersconnected <= repair_grill_fixing_long_sfx()) {
    if(var9 && isDefined(level.matchrecording_logeventplayername)) {
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

  if(var9 && (scripts\mp\utility\game::gettimepassed() >= 60000 || game["roundsPlayed"] > 0)) {
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
    var7 = scripts\mp\utility\game::gettimepassed() / 1000 + 6;

    if(shouldshowwidemapshot(var7)) {
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
      if(var2) {
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
          var14 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
          scripts\mp\utility\script::laststand_dogtags("Callback_PlayerConnect() elseif MMG " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + var14);
        }

        self setclientomnvar("ui_options_menu", 2);
      }

      if(!scripts\mp\utility\game::runleanthreadmode() && scripts\mp\utility\game::matchmakinggame() && !isgamebattlematch()) {
        thread kickifdontspawn();
      }

      clearpinnedobjectives();
      return;
    } else {
      if(var2) {
        thread spawnspectator();
      }

      scripts\mp\menus::autoassign();

      if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
        if(getdvarint("scr_force_cac_sre_callstack", 0) == 1 && scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "sandbox" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
          var14 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
          scripts\mp\utility\script::laststand_dogtags("Callback_PlayerConnect() else " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + var14);
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
    var15 = self.pers["team"];

    if(scripts\mp\utility\game::matchmakinggame() && !isbot(self) && !initmaxspeedforpathlengthtable(self) && !self ismlgspectator() && getdvarint("TLNSRKRQP")) {
      var15 = self.sessionteam;
    }

    scripts\mp\menus::addtoteam(var15, 1);

    if(scripts\mp\menus::shouldmodesetsquads()) {
      thread scripts\mp\menus::setsquad(var15);
    }

    if(isDefined(level.ref_12065)) {
      self thread[[level.ref_12065]]();
    }

    if(self ismlgspectator()) {
      thread spawnspectator();
      clearpinnedobjectives();
      return;
    }

    if(scripts\mp\class::isvalidclass(self.pers["class"]) && var15 != "spectator") {
      thread spawnclient();
      clearpinnedobjectives();
      return;
    }

    if(var2) {
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

  var0 = 0;

  foreach(var2 in level.players) {
    if(!isbot(var2) && !initmaxspeedforpathlengthtable(var2)) {
      var0++;
    }
  }

  if(!isbot(self) && !initmaxspeedforpathlengthtable(self)) {
    level.hostmigrationreturnedplayercount++;

    if(level.hostmigrationreturnedplayercount >= var0 * 2 / 3) {
      level notify("hostmigration_enoughplayers");
      return;
    }

    return;
  }
}

function addlevelstoexperience(var0, var1) {
  var2 = scripts\mp\rank::getrankforxp(var0);
  var3 = scripts\mp\rank::getrankinfominxp(var2);
  var4 = scripts\mp\rank::getrankinfomaxxp(var2);
  var2 += (var0 - var3) / (var4 - var3);
  var2 += var1;

  if(var2 < 0) {
    var2 = 0;
    var5 = 0;
  } else if(var3 >= level.maxrank + 1) {
    var3 = level.maxrank;
    var5 = 1;
  } else {
    var5 = var4 - floor(var4);
    var4 = int(floor(var4));
  }

  var5 = scripts\mp\rank::getrankinfominxp(var4);
  var5 = scripts\mp\rank::getrankinfomaxxp(var4);
  return int(var5 * (var5 - var5)) + var5;
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
  var0 = getdvarfloat("scr_kick_time", 90);
  var1 = getdvarfloat("scr_kick_mintime", 45);
  var2 = getdvarfloat("scr_kick_hosttime", 120);
  var3 = gettime();

  if(self ishost()) {
    kickwait(var2);
  } else {
    kickwait(var0);
  }

  var4 = (gettime() - var3) / 1000;

  if(var4 < var0 - 0.1 && var4 < var1) {
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

function kickwait(var0) {
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var0);
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

function totaldisttracking(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");
  self notify("distFromSpawnTracking");
  self endon("distFromSpawnTracking");
  var2 = var0;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    scripts\mp\flags::gameflagwait("prematch_done");
    var2 = self.origin;
  }

  var3 = 0;
  var4 = 0;
  var5 = 0;

  for(;;) {
    var6 = scripts\engine\utility::ref_143be(5, "death", "vehicle_enter", "vehicle_change_seat", "vehicle_exit", "afk_tracking_resume", "skydive_deployparachute");

    if(var6 == "vehicle_exit" && !isDefined(self.lastvehicleseatchangetime)) {
      continue;
    }

    if(!isDefined(self.pers["totalDistTraveled"])) {
      scripts\mp\utility\stats::initpersstat("totalDistTraveled");
    }

    if(!isDefined(self.pers["totalDistTraveledByFoot"])) {
      scripts\mp\utility\stats::initpersstat("totalDistTraveledByFoot");
    }

    if(!isDefined(var2)) {
      var2 = self.origin;
    }

    var7 = distance(var2, self.origin);
    scripts\mp\utility\stats::incpersstat("totalDistTraveled", var7);
    scripts\cp\vehicles\vehicle_compass_cp::incchallengestat("totalDistTraveled", var7);

    if(getdvarint("scr_veteruns_challenge_enabled", 0)) {
      if(!isDefined(self.vehicle) && var6 != "vehicle_exit" || var6 == "vehicle_enter") {
        var8 = 0;

        if(self isjumping()) {
          var9 = scripts\mp\gametypes\br_public::modifytriggerlocation(self.origin, 0, -100000);
          var10 = self.origin[2] - var9["position"][2];
          var8 = var10 <= getdvarfloat("foot_tracking_max_small_jump_height", 100) && var10 > 0 && !isDefined(var9["entity"]);
        }

        var9 = self getgroundentity();
        var11 = isDefined(var9) && var9.classname == "worldspawn" || var8;

        if(var11 && var5 && var7 <= getdvarfloat("foot_tracking_max_expected_distance", 10000)) {
          scripts\mp\utility\stats::incpersstat("totalDistTraveledByFoot", var7);
          scripts\cp\vehicles\vehicle_compass_cp::incchallengestat("totalDistTraveledByFoot", var7);
        }

        var5 = var11 && var6 != "skydive_deployparachute";
      }
    }

    if(isDefined(scripts\mp\utility\stats::getpersstat("distanceTraveledInVehicle")) && (var6 == "vehicle_exit" || isDefined(self.vehicle))) {
      scripts\mp\utility\stats::incpersstat("distanceTraveledInVehicle", var7);
    }

    if(var6 == "vehicle_enter") {
      var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);
      self.lastvehicleseatchangetime = gettime();
    }

    if(var6 == "vehicle_change_seat") {
      var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);
    }

    if(var3 != var4 || var6 == "vehicle_exit") {
      var12 = self.lastvehicleseatchangetime;
      var13 = (gettime() - var12) / 1000;

      if(var3) {
        if(isDefined(scripts\mp\utility\stats::getpersstat("timeSpentAsDriver"))) {
          scripts\mp\utility\stats::incpersstat("timeSpentAsDriver", var13);
        }
      } else if(isDefined(scripts\mp\utility\stats::getpersstat("timeSpentAsPassenger"))) {
        scripts\mp\utility\stats::incpersstat("timeSpentAsPassenger", var13);
      }
    }

    if(var6 == "vehicle_enter" || var6 == "vehicle_change_seat") {
      var3 = var4;
    }

    if(var6 == "vehicle_change_seat") {
      self.lastvehicleseatchangetime = gettime();
    }

    var2 = self.origin;
    scripts\mp\utility\stats::incpersstat("averageAltitude", self.origin[2]);
    scripts\mp\utility\stats::incpersstat("averageAltitudeCount", 1);

    if(var1 && !istrue(self.stack_patch_waittill_node)) {
      if(var6 == "afk_tracking_resume") {
        continue;
      }

      if(!isDefined(self.pers["totalDistTraveledAFK"])) {
        scripts\mp\utility\stats::initpersstat("totalDistTraveledAFK");
      }

      scripts\mp\utility\stats::incpersstat("totalDistTraveledAFK", var7);

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

      var14 = ref_1331c();

      if(var14) {
        var15 = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);

        if(var15 - self.pers["afkResetTime"] > 240) {
          self.pers["afkResetTime"] = var15;
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

function addtoteamcount(var0) {
  thread scripts\mp\utility\teams::addplayertoteam(self, self.team, var0);
  [[level.updategameevents]]();
}

function removefromteamcount() {
  scripts\mp\utility\teams::removeplayerfromteam(self, self.team);
}

function addtoalivecount(var0) {
  var1 = self.team;

  if(!(isDefined(self.alreadyaddedtoalivecount) && self.alreadyaddedtoalivecount)) {
    scripts\mp\utility\teams::modifyteamdata(var1, "hasSpawned", 1);
    incrementalivecount(var1, 0, var0);
  }

  self.alreadyaddedtoalivecount = undefined;
  var2 = 0;

  foreach(var4 in level.teamnamelist) {
    var2 += scripts\mp\utility\teams::getteamdata(var4, "aliveCount");
  }

  if(var2 > level.maxplayercount) {
    level.maxplayercount = var2;
    return;
  }
}

function incrementalivecount(var0, var1, var2) {
  scripts\mp\utility\teams::addtoteamlives(self, var0, var1, var2);
  [[level.updategameevents]]();
}

function removefromalivecount(var0, var1) {
  var2 = self.pers["lives"];
  var3 = scripts\mp\utility\game::getgametypenumlives() != 0 && var2 == 0 && !istrue(level.ref_133df);
  self notify("remove_from_alive_count");
  var4 = self.team;

  if(isDefined(self.switching_teams) && self.switching_teams && isDefined(self.joining_team) && self.joining_team == self.team) {
    var4 = self.leaving_team;
  }

  if(isDefined(var0)) {
    removeallfromlivescount();
  } else if(isDefined(self.switching_teams)) {
    if(!level.ingraceperiod || self.hasdonecombat) {
      scripts\mp\utility\teams::modifyteamdata(var4, "hasSpawned", -1);

      if(var2) {
        self.pers["lives"]--;
      }
    }
  }

  decrementalivecount(var4, var3, var1);
}

function decrementalivecount(var0, var1, var2) {
  scripts\mp\utility\teams::removefromteamlives(self, var0, var1, var2);
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
    foreach(var1 in level.objectives) {
      if(isDefined(var1.objidnum)) {
        scripts\mp\objidpoolmanager::objective_unpin_player(var1.objidnum, self, var1.showoncompass);
      }
    }
  }

  if(isDefined(level.uncapturableobjectives)) {
    foreach(var1 in level.uncapturableobjectives) {
      if(isDefined(var1.objidnum)) {
        scripts\mp\objidpoolmanager::objective_unpin_player(var1.objidnum, self, var1.showoncompass);
      }
    }

    return;
  }
}

function watchtargethealth() {
  self endon("death_or_disconnect");
  self.targethealthinfo = [];

  for(;;) {
    var0 = (self.origin[0], self.origin[1], self.origin[2] + 64);
    var1 = self getplayerangles();
    var2 = anglesToForward(var1);
    var3 = var0 + var2 * 10000;
    var4 = scripts\engine\trace::_bullet_trace(var0, var3, 1, self, 0, 0, 0, 0, 0);
    var5 = var4["entity"];

    if(isDefined(var5) && isPlayer(var5) && var5.team != self.team) {
      if(isDefined(var5)) {
        updatetargethealthvariable("ui_target_health", var5.health);
      }

      if(isDefined(var5)) {
        updatetargethealthvariable("ui_target_max_health", var5.maxhealth);
      }

      if(isDefined(var5)) {
        updatetargethealthvariable("ui_target_entity_num", var5 getentitynumber());
      }
    } else {
      updatetargethealthvariable("ui_target_entity_num", -1);
    }

    wait 0.1;
  }
}

function updatetargethealthvariable(var0, var1) {
  waitframe();

  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(var1)) {
    return;
  }

  if(!isDefined(self.targethealthinfo[var0]) || var1 != self.targethealthinfo[var0]) {
    self setclientomnvar(var0, var1);
    self.targethealthinfo[var0] = var1;
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

  var0 = self.pers["team"];
  var1 = scripts\mp\utility\game::getobjectivehinttext(var0);

  if(isDefined(var1)) {
    var2 = 0;

    if(game["defenders"] == var0) {
      var2 = 1;
    }

    self setclientomnvar("ui_objective_text", var2);
    wait 6;
    self setclientomnvar("ui_objective_text", -1);
    return;
  }
}

function showmatchhint() {
  var0 = scripts\mp\utility\game::getgametype();

  switch (var0) {
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
  var0 = scripts\engine\utility::is_player_gamepad_enabled();

  if(self.gamepadwasenabled != var0) {
    self notify("input_type_changed", var0);
    self.gamepadwasenabled = var0;
    return;
  }
}

function updateplayerwindmaterial() {
  var0 = 100;
  var1 = 700;
  var2 = var1 - var0;
  var3 = 0;
  var4 = 10;

  for(;;) {
    foreach(var6 in level.players) {
      if(!isDefined(var6)) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var6)) {
        continue;
      }

      if(istrue(var6.manualoverridewindmaterial)) {
        continue;
      }

      if(isDefined(var6.vehicle)) {
        var7 = clamp(length(var6.vehicle vehicle_getvelocity()), var0, var1);
      } else {
        var7 = clamp(length(var6 getvelocity()), var0, var1);
      }

      var8 = (var7 - var0) / var2;
      var8 *= 10;
      var8 = int(var8);

      if(!isDefined(var6.ref_145c6) || var6.ref_145c6 != var8) {
        switch (var8) {
          case 0:
            var6 setscriptablepartstate("wind", "0", 0);
            break;
          case 1:
            var6 setscriptablepartstate("wind", "10", 0);
            break;
          case 2:
            var6 setscriptablepartstate("wind", "20", 0);
            break;
          case 3:
            var6 setscriptablepartstate("wind", "30", 0);
            break;
          case 4:
            var6 setscriptablepartstate("wind", "40", 0);
            break;
          case 5:
            var6 setscriptablepartstate("wind", "50", 0);
            break;
          case 6:
            var6 setscriptablepartstate("wind", "60", 0);
            break;
          case 7:
            var6 setscriptablepartstate("wind", "70", 0);
            break;
          case 8:
            var6 setscriptablepartstate("wind", "80", 0);
            break;
          case 9:
            var6 setscriptablepartstate("wind", "90", 0);
            break;
          case 10:
            var6 setscriptablepartstate("wind", "100", 0);
            break;
        }
      }

      var6.ref_145c6 = var8;
      var3++;

      if(var3 == var4) {
        waitframe();
        var3 = 0;
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