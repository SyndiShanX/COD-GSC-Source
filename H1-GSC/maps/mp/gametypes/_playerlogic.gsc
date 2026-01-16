/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_playerlogic.gsc
**********************************************/

timeuntilwavespawn(var_0) {
  if(!self.hasspawned)
    return 0;

  var_1 = gettime() + var_0 * 1000;
  var_2 = level.lastwave[self.pers["team"]];
  var_3 = level.wavedelay[self.pers["team"]] * 1000;
  var_4 = (var_1 - var_2) / var_3;
  var_5 = ceil(var_4);
  var_6 = var_2 + var_5 * var_3;

  if(isdefined(self.respawntimerstarttime)) {
    var_7 = (gettime() - self.respawntimerstarttime) / 1000.0;

    if(self.respawntimerstarttime < var_2)
      return 0;
  }

  if(isdefined(self.wavespawnindex))
    var_6 = var_6 + 50 * self.wavespawnindex;

  return (var_6 - gettime()) / 1000;
}

teamkilldelay() {
  var_0 = self.pers["teamkills"];

  if(var_0 <= level.maxallowedteamkills)
    return 0;

  var_1 = var_0 - level.maxallowedteamkills;
  return maps\mp\gametypes\_tweakables::gettweakablevalue("team", "teamkillspawndelay") * var_1;
}

getrespawndelay() {
  var_0 = self[[level.onrespawndelay]]();

  if(isdefined(var_0))
    return var_0;
  else
    return getdvarint("scr_" + level.gametype + "_playerrespawndelay");
}

timeuntilspawn(var_0) {
  if(level.ingraceperiod && !self.hasspawned || level.gameended)
    return 0;

  var_1 = 0;

  if(self.hasspawned) {
    var_1 = getrespawndelay();

    if(var_0) {
      if(isdefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
        var_1 = var_1 + teamkilldelay();

      if(isdefined(self.pers["suicideSpawnDelay"]))
        var_1 = var_1 + self.pers["suicideSpawnDelay"];
    }

    if(isdefined(self.respawntimerstarttime)) {
      var_2 = (gettime() - self.respawntimerstarttime) / 1000.0;
      var_1 = var_1 - var_2;

      if(var_1 < 0)
        var_1 = 0;
    }

    if(isdefined(self.setspawnpoint))
      var_1 = var_1 + level.tispawndelay;
  }

  var_3 = getdvarfloat("scr_" + level.gametype + "_waverespawndelay") > 0;

  if(var_3)
    return timeuntilwavespawn(var_1);

  return var_1;
}

mayspawn(var_0) {
  if(!isdefined(var_0))
    var_0 = 1;

  if(isdefined(level.gamemodemayspawn))
    return [
      [level.gamemodemayspawn]
    ](var_0);

  if(maps\mp\_utility::getgametypenumlives() || isdefined(level.disablespawning)) {
    if(isdefined(level.disablespawning) && level.disablespawning)
      return 0;

    if(var_0 && isdefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
      return 0;

    if(!self.pers["lives"] && maps\mp\_utility::gamehasstarted())
      return 0;
    else if(maps\mp\_utility::gamehasstarted()) {
      if(!level.ingraceperiod && !self.hasspawned && (isdefined(level.allowlatecomers) && !level.allowlatecomers))
        return 0;
    }

    if(isdefined(level.disablespawningforplayerfunc) && [
        [level.disablespawningforplayerfunc]
      ](self))
      return 0;
  }

  return 1;
}

spawnclient() {
  self endon("becameSpectator");

  if(isdefined(self.clientid)) {} else {}

  if(isdefined(self.waitingtoselectclass) && self.waitingtoselectclass)
    self waittill("notWaitingToSelectClass");

  if(isdefined(self.addtoteam)) {
    maps\mp\gametypes\_menus::addtoteam(self.addtoteam);
    maps\mp\gametypes\_class::cac_setlastteam(self.addtoteam);
    self.addtoteam = undefined;
  }

  if(!mayspawn(0)) {
    wait 0.05;
    self notify("attempted_spawn");

    if(maps\mp\_utility::isroundbased() && !maps\mp\_utility::islastround()) {
      if(isdefined(self.tagavailable) && self.tagavailable)
        maps\mp\_utility::setlowermessage("spawn_info", game["strings"]["spawn_tag_wait"]);
      else
        maps\mp\_utility::setlowermessage("spawn_info", game["strings"]["spawn_next_round"]);

      thread removespawnmessageshortly(3.0);
    }

    thread spawnspectator();
    return;
  }

  if(self.waitingtospawn) {
    return;
  }
  self.waitingtospawn = 1;
  waitandspawnclient();

  if(isdefined(self))
    self.waitingtospawn = 0;
}

streamprimaryweapons() {
  if(isai(self) || istestclient(self)) {
    return;
  }
  if(maps\mp\_utility::allowclasschoice()) {
    var_0 = [];
    var_1 = [];
    var_2 = ["custom1", "custom2", "custom3", "custom4", "custom5", "class0", "class1", "class2", "class3", "class4"];
    var_3 = self.team;

    if(!isdefined(var_3) || var_3 != "allies" && var_3 != "axis")
      var_3 = "allies";

    foreach(var_5 in var_2) {
      var_6 = maps\mp\gametypes\_class::getloadout(self.team, var_5);
      var_0[var_0.size] = var_6.primaryname;
      var_7 = weaponclass(var_6.primaryname);

      if(var_7 != "none" && !isdefined(var_1[var_7])) {
        var_8 = spawnstruct();
        var_8.team = var_3;
        var_8.weapon = var_6.primaryname;
        var_1[var_7] = var_8;
      }
    }

    self hasloadedcustomizationplayerview(var_1, var_0);
  } else if(isdefined(level.streamprimariesfunc))
    self[[level.streamprimariesfunc]]();
}

gatherclassweapons(var_0, var_1) {
  var_2 = [];

  if(!isdefined(self.class) || self.class == "")
    return var_2;

  if(!isdefined(var_1))
    var_1 = maps\mp\gametypes\_class::getloadout(self.team, self.class, undefined, undefined, 1);

  var_2[var_2.size] = var_1.primaryname;

  if(!isdefined(var_0) || !var_0) {
    var_2[var_2.size] = var_1.secondaryname;
    var_2[var_2.size] = var_1.meleeweaponname;
  }

  return var_2;
}

getstreaminfo(var_0) {
  var_1 = spawnstruct();
  var_1.team = common_scripts\utility::ter_op(isdefined(self.addtoteam), self.addtoteam, self.team);
  var_1.weapon = var_0.primaryname;
  return var_1;
}

getloadoutforclass(var_0, var_1) {
  var_2 = var_0;

  if(!maps\mp\_utility::isvalidclass(var_2))
    var_2 = self.class;

  var_3 = maps\mp\gametypes\_class::getloadout(self.team, var_2, undefined, undefined, var_1);
  return var_3;
}

streamclass(var_0, var_1, var_2) {
  self.classweaponswait = 0;
  self notify("endStreamClass");
  self endon("endStreamClass");
  self endon("death");
  self endon("disconnect");

  if(isai(self) || !isdefined(var_0))
    var_0 = 0;

  while (isdefined(self.loadingplayerweapons) && self.loadingplayerweapons)
    wait 0.05;

  var_3 = getloadoutforclass(var_2, 1);
  var_4 = getstreaminfo(var_3);
  var_5 = gatherclassweapons(0, var_3);
  var_0 = !self hasloadedcustomizationplayerview(var_4, var_5) && var_0;
  self onlystreamactiveweapon(1);

  for (self.classweaponswait = var_0; var_0; var_0 = !self hasloadedcustomizationplayerview(var_4, var_5))
    waitframe();

  self onlystreamactiveweapon(0);
  self.classweaponswait = 0;
  self notify("streamClassComplete");
}

waitandspawnclient() {
  self endon("disconnect");
  self endon("end_respawn");
  level endon("game_ended");
  self notify("attempted_spawn");

  if(isdefined(self.clientid)) {} else {}

  var_0 = 0;
  var_1 = getentarray("mp_global_intermission", "classname");
  var_2 = var_1[randomint(var_1.size)];
  var_3 = self.pers["teamKillPunish"];

  if(isdefined(var_3) && var_3) {
    var_4 = teamkilldelay();

    if(var_4 > 0) {
      maps\mp\_utility::setlowermessage("friendly_fire", & "MP_FRIENDLY_FIRE_WILL_NOT", var_4, 1, 1);
      thread respawn_asspectator(var_2.origin, var_2.angles);
      var_0 = 1;
      wait(var_4);
      maps\mp\_utility::clearlowermessage("friendly_fire");
      self.respawntimerstarttime = gettime();
    }

    self.pers["teamKillPunish"] = 0;
  } else if(teamkilldelay())
    self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);

  var_5 = self.pers["suicideSpawnDelay"];

  if(isdefined(var_5) && var_5 > 0) {
    maps\mp\_utility::setlowermessage("suicidePenalty", & "MP_SUICIDE_PUNISHED", var_5, 1, 1);

    if(!var_0)
      thread respawn_asspectator(var_2.origin, var_2.angles);

    var_0 = 1;
    wait(var_5);
    maps\mp\_utility::clearlowermessage("suicidePenalty");
    self.respawntimerstarttime = gettime();
    self.pers["suicideSpawnDelay"] = 0;
  }

  if(maps\mp\_utility::isusingremote()) {
    self.spawningafterremotedeath = 1;
    self.deathposition = self.origin;
    self waittill("stopped_using_remote");
  }

  if(!isdefined(self.wavespawnindex) && isdefined(level.waveplayerspawnindex[self.team])) {
    self.wavespawnindex = level.waveplayerspawnindex[self.team];
    level.waveplayerspawnindex[self.team]++;
  }

  var_6 = timeuntilspawn(0);

  if(var_6 > 0) {
    self setclientomnvar("ui_killcam_time_until_spawn", gettime() + var_6 * 1000);

    if(!var_0)
      thread respawn_asspectator(var_2.origin, var_2.angles);

    var_0 = 1;
    maps\mp\_utility::waitfortimeornotify(var_6, "force_spawn");
    self notify("stop_wait_safe_spawn_button");
  }

  if(needsbuttontorespawn()) {
    maps\mp\_utility::setlowermessage("spawn_info", game["strings"]["press_to_spawn"], undefined, undefined, undefined, undefined, undefined, undefined, 1);

    if(!var_0)
      thread respawn_asspectator(var_2.origin, var_2.angles);

    var_0 = 1;
    waitrespawnbutton();
  }

  self.waitingtospawn = 0;
  maps\mp\_utility::clearlowermessage("spawn_info");
  self.wavespawnindex = undefined;
  thread spawnplayer();
}

needsbuttontorespawn() {
  if(maps\mp\gametypes\_tweakables::gettweakablevalue("player", "forcerespawn") != 0)
    return 0;

  if(!self.hasspawned)
    return 0;

  var_0 = getdvarfloat("scr_" + level.gametype + "_waverespawndelay") > 0;

  if(var_0)
    return 0;

  if(self.wantsafespawn)
    return 0;

  return 1;
}

waitrespawnbutton() {
  self endon("disconnect");
  self endon("end_respawn");

  for (;;) {
    if(self usebuttonpressed()) {
      break;
    }

    wait 0.05;
  }
}

removespawnmessageshortly(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  waittillframeend;
  self endon("end_respawn");
  wait(var_0);
  maps\mp\_utility::clearlowermessage("spawn_info");
}

laststandrespawnplayer() {
  self laststandrevive();

  if(maps\mp\_utility::_hasperk("specialty_finalstand") && !level.diehardmode)
    maps\mp\_utility::_unsetperk("specialty_finalstand");

  if(level.diehardmode)
    self.headicon = "";

  self setstance("crouch");
  self.revived = 1;
  self notify("revive");

  if(isdefined(self.standardmaxhealth))
    self.maxhealth = self.standardmaxhealth;

  self.health = self.maxhealth;
  common_scripts\utility::_enableusability();

  if(game["state"] == "postgame")
    maps\mp\gametypes\_gamelogic::freezeplayerforroundend();
}

getdeathspawnpoint() {
  var_0 = spawn("script_origin", self.origin);
  var_0 hide();
  var_0.angles = self.angles;
  return var_0;
}

showspawnnotifies() {}

getspawnorigin(var_0) {
  if(!positionwouldtelefrag(var_0.origin))
    return var_0.origin;

  if(!isdefined(var_0.alternates))
    return var_0.origin;

  foreach(var_2 in var_0.alternates) {
    if(!positionwouldtelefrag(var_2))
      return var_2;
  }

  return var_0.origin;
}

spawningclientthisframereset() {
  self notify("spawningClientThisFrameReset");
  self endon("spawningClientThisFrameReset");
  wait 0.05;
  level.numplayerswaitingtospawn--;
}

setuioptionsmenu(var_0) {
  self endon("disconnect");
  self endon("joined_spectators");

  while (self ismlgspectator() && !maps\mp\_utility::invirtuallobby())
    waitframe();

  self setclientomnvar("ui_options_menu", var_0);
}

gather_spawn_weapons() {
  var_0 = [];

  if(isdefined(self.loadout)) {
    var_0[var_0.size] = maps\mp\_utility::get_spawn_weapon_name(self.loadout);

    if(isdefined(self.loadout.secondaryname) && self.loadout.secondaryname != "none")
      var_0[var_0.size] = self.loadout.secondaryname;
  } else {
    if(isdefined(self.primaryweapon) && self.primaryweapon != "none")
      var_0[var_0.size] = self.primaryweapon;

    if(isdefined(self.secondaryweapon) && self.secondaryweapon != "none")
      var_0[var_0.size] = self.secondaryweapon;
  }

  return var_0;
}

spawnplayer(var_0, var_1) {
  self endon("disconnect");
  self endon("joined_spectators");
  self notify("spawned");
  self notify("end_respawn");
  self notify("started_spawnPlayer");

  if(isdefined(self.clientid)) {} else {}

  if(!isdefined(var_0))
    var_0 = 0;

  if(!isdefined(var_1)) {
    if(maps\mp\_utility::invirtuallobby())
      var_1 = 0;
    else
      var_1 = 1;
  }

  if(var_1) {
    self.spawnplayergivingloadout = 1;
    thread monitordelayedspawnloadouts();
  }

  self.lifeid = maps\mp\_utility::getnextlifeid();
  self.totallifetime = 0;
  var_2 = undefined;
  self.ti_spawn = 0;

  if(self getclientomnvar("ui_options_menu") > 0)
    thread setuioptionsmenu(0);

  self setclientomnvar("ui_hud_shake", 0);
  self setdemigod(0);
  self disableforcefirstpersonwhenfollowed();

  if(!level.ingraceperiod && !self.hasdonecombat) {
    level.numplayerswaitingtospawn++;

    if(level.numplayerswaitingtospawn > 1) {
      self.waitingtospawnamortize = 1;
      wait(0.05 * (level.numplayerswaitingtospawn - 1));
    }

    thread spawningclientthisframereset();
    self.waitingtospawnamortize = 0;
  }

  if(var_1) {
    var_3 = undefined;

    if(isdefined(level.iszombiegame) && level.iszombiegame)
      var_3 = 0;

    maps\mp\gametypes\_class::giveloadout(self.team, self.class, undefined, var_3);
    var_4 = gather_spawn_weapons();
    self.loadingplayerweapons = 1;

    if(!isdefined(self.costume)) {
      if(isplayer(self))
        self.costume = maps\mp\gametypes\_class::cao_getactivecostume();
      else if(isagent(self) && self.agent_type == "player")
        self.costume = maps\mp\gametypes\_teams::getdefaultcostume();
    }

    maps\mp\gametypes\_teams::applycostume(self.loadout.primaryname, self.team);
    var_5 = maps\mp\gametypes\_class::cao_getcharactercamoindex();
    self _meth_857C(var_5);

    if(!self hasloadedcustomizationplayerview(var_4)) {
      self.waitingtospawnamortize = 1;
      self onlystreamactiveweapon(1);
      var_6 = gettime() + 3000;

      while (gettime() < var_6) {
        waitframe();
        var_4 = gather_spawn_weapons();

        if(self hasloadedcustomizationplayerview(var_4)) {
          break;
        }
      }

      self onlystreamactiveweapon(0);

      if(gettime() >= var_6) {

      } else {

      }

      self.waitingtospawnamortize = 0;
    }

    self.loadingplayerweapons = 0;
  }

  if(isdefined(self.forcespawnorigin)) {
    var_7 = self.forcespawnorigin;
    self.forcespawnorigin = undefined;

    if(isdefined(self.forcespawnangles)) {
      var_8 = self.forcespawnangles;
      self.forcespawnangles = undefined;
    } else
      var_8 = (0, randomfloatrange(0, 360), 0);
  } else if(isdefined(self.setspawnpoint) && isdefined(self.setspawnpoint.notti)) {
    var_2 = self.setspawnpoint;

    if(!isdefined(self.setspawnpoint.notti)) {
      self.ti_spawn = 1;
      self playlocalsound("tactical_spawn");

      if(level.multiteambased) {
        foreach(var_10 in level.teamnamelist) {
          if(var_10 != self.team)
            self playsoundtoteam("tactical_spawn", var_10);
        }
      } else if(level.teambased)
        self playsoundtoteam("tactical_spawn", level.otherteam[self.team]);
      else
        self playsound("tactical_spawn");
    }

    var_7 = self.setspawnpoint.playerspawnpos;
    var_8 = self.setspawnpoint.angles;

    if(isdefined(self.setspawnpoint.enemytrigger))
      self.setspawnpoint.enemytrigger delete();

    self.setspawnpoint delete();
    var_2 = undefined;
  } else if(isdefined(self.helispawning) && (!isdefined(self.firstspawn) || isdefined(self.firstspawn) && self.firstspawn) && level.prematchperiod > 0 && self.team == "allies") {
    while (!isdefined(level.allieschopper))
      wait 0.1;

    var_7 = level.allieschopper.origin;
    var_8 = level.allieschopper.angles;
    self.firstspawn = 0;
  } else if(isdefined(self.helispawning) && (!isdefined(self.firstspawn) || isdefined(self.firstspawn) && self.firstspawn) && level.prematchperiod > 0 && self.team == "axis") {
    while (!isdefined(level.axischopper))
      wait 0.1;

    var_7 = level.axischopper.origin;
    var_8 = level.axischopper.angles;
    self.firstspawn = 0;
  } else {
    var_2 = self[[level.getspawnpoint]]();
    var_7 = var_2.origin;
    var_8 = var_2.angles;
  }

  setspawnvariables();
  var_12 = self.hasspawned;
  self.fauxdead = undefined;

  if(!var_0) {
    self.killsthislife = [];
    maps\mp\_utility::updatesessionstate("playing");
    maps\mp\_utility::clearkillcamstate();
    self.cancelkillcam = undefined;
    self.maxhealth = maps\mp\gametypes\_tweakables::gettweakablevalue("player", "maxhealth");
    self.health = self.maxhealth;
    self.friendlydamage = undefined;
    self.hasspawned = 1;
    self.spawntime = gettime();
    self.spawntimedecisecondsfrommatchstart = maps\mp\_utility::gettimepasseddecisecondsincludingrounds();
    self.wasti = !isdefined(var_2);
    self.afk = 0;
    self.damagedplayers = [];
    self.killstreakscaler = 1;
    self.objectivescaler = 1;
    self.clampedhealth = undefined;
    self.shielddamage = 0;
    self.shieldbullethits = 0;
    self.enemyhitcounts = [];
    self.currentfirefightshots = 0;

    if(!isai(self))
      thread maps\mp\gametypes\_damage::clearfirefightshotsoninterval();

    self.scoreatlifestart = self.pers["score"];

    if(isdefined(self.pers["summary"]) && isdefined(self.pers["summary"]["xp"]))
      self.xpatlifestart = self.pers["summary"]["xp"];
  }

  self.movespeedscaler = level.baseplayermovescale;
  self.inlaststand = 0;
  self.laststand = undefined;
  self.infinalstand = undefined;
  self.disabledweapon = 0;
  self.disabledweaponswitch = 0;
  self.disabledoffhandweapons = 0;
  common_scripts\utility::resetusability();
  self.playerdisableabilitytypes = [];

  if(!var_0) {
    self.avoidkillstreakonspawntimer = 5.0;
    var_13 = self.pers["lives"];

    if(var_13 == maps\mp\_utility::getgametypenumlives())
      addtolivescount();

    if(var_13)
      self.pers["lives"]--;

    addtoalivecount();

    if(!var_12 || maps\mp\_utility::gamehasstarted() || maps\mp\_utility::gamehasstarted() && level.ingraceperiod && self.hasdonecombat)
      removefromlivescount();

    if(!self.wasaliveatmatchstart) {
      var_14 = 20;

      if(maps\mp\_utility::gettimelimit() > 0 && var_14 < maps\mp\_utility::gettimelimit() * 60 / 4)
        var_14 = maps\mp\_utility::gettimelimit() * 60 / 4;

      if(level.ingraceperiod || maps\mp\_utility::gettimepassed() < var_14 * 1000)
        self.wasaliveatmatchstart = 1;
    }
  }

  if(level.console)
    self setclientdvar("cg_fov", "65");

  resetuidvarsonspawn();

  if(isdefined(var_2)) {
    maps\mp\gametypes\_spawnlogic::finalizespawnpointchoice(var_2);
    var_7 = getspawnorigin(var_2);
    var_8 = var_2.angles;
  } else
    self.lastspawntime = gettime();

  self.spawnpos = var_7;
  self spawn(var_7, var_8);
  maps\mp\_utility::setdof(level.dofdefault);

  if(self.team == "allies") {
    self.lastgameteamchosen = "allies";
    self setclientomnvar("ui_team_selected", maps\mp\gametypes\_menus::getuiteamindex("allies"));
  } else if(self.team == "axis") {
    self.lastgameteamchosen = "axis";
    self setclientomnvar("ui_team_selected", maps\mp\gametypes\_menus::getuiteamindex("axis"));
  }

  if(isdefined(self.pers["cur_kill_count"])) {
    self setclientomnvar("ks_count1", self.pers["cur_kill_count"]);
    self.pers["cur_kill_count"] = undefined;
  }

  if(var_0 && isdefined(self.faux_spawn_stance)) {
    self setstance(self.faux_spawn_stance);
    self.faux_spawn_stance = undefined;
  }

  [[level.onspawnplayer]]();

  if(!var_0) {
    maps\mp\gametypes\_missions::playerspawned();

    if(isai(self) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["player_spawned"]))
      self[[level.bot_funcs["player_spawned"]]]();
  }

  maps\mp\gametypes\_class::setclass(self.class);

  if(isdefined(level.custom_giveloadout))
    self[[level.custom_giveloadout]](var_0);
  else if(var_1) {
    maps\mp\gametypes\_class::applyloadout();
    self notify("spawnplayer_giveloadout");
  }

  if(getdvarint("camera_thirdPerson"))
    maps\mp\_utility::setthirdpersondof(1);

  if(!maps\mp\_utility::gameflag("prematch_done")) {
    maps\mp\_utility::freezecontrolswrapper(1);
    self disableammogeneration();
  } else {
    maps\mp\_utility::freezecontrolswrapper(0);
    self enableammogeneration();
  }

  self allowsprint(!getdvarint("scr_game_disablesprint", 0));

  if(!maps\mp\_utility::gameflag("prematch_done") || !var_12 && game["state"] == "playing") {
    var_15 = self.pers["team"];

    if(maps\mp\_utility::inovertime())
      thread maps\mp\gametypes\_hud_message::oldnotifymessage(game["strings"]["overtime"], game["strings"]["overtime_hint"], undefined, (1, 0, 0), "mp_last_stand");

    thread showspawnnotifies();
  }

  if(maps\mp\_utility::getintproperty("scr_showperksonspawn", 1) == 1 && game["state"] != "postgame") {}

  waittillframeend;
  self.spawningafterremotedeath = undefined;
  self notify("spawned_player");
  level notify("player_spawned", self);
  thread maps\mp\gametypes\_hardpoints::hardpointitemwaiter();

  if(game["state"] == "postgame")
    maps\mp\gametypes\_gamelogic::freezeplayerforroundend();

  if(isdefined(level.matchrules_switchteamdisabled) && level.matchrules_switchteamdisabled)
    self setclientomnvar("ui_disable_team_change", 1);
}

monitordelayedspawnloadouts() {
  common_scripts\utility::waittill_any("disconnected", "joined_spectators", "spawnplayer_giveloadout");
  self.spawnplayergivingloadout = undefined;
}

spawnspectator(var_0, var_1) {
  self notify("spawned");
  self notify("end_respawn");
  self notify("joined_spectators");
  in_spawnspectator(var_0, var_1);
}

respawn_asspectator(var_0, var_1) {
  in_spawnspectator(var_0, var_1);
}

in_spawnspectator(var_0, var_1) {
  setspawnvariables();
  var_2 = self.pers["team"];

  if(isdefined(var_2) && var_2 == "spectator" && !level.gameended)
    maps\mp\_utility::clearlowermessage("spawn_info");

  maps\mp\_utility::updatesessionstate("spectator");
  maps\mp\_utility::clearkillcamstate();
  self.friendlydamage = undefined;
  self.loadingplayerweapons = undefined;
  resetuidvarsonspectate();
  maps\mp\gametypes\_spectating::setspectatepermissions();
  onspawnspectator(var_0, var_1);

  if(level.teambased && !level.splitscreen && !self issplitscreenplayer())
    self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

getplayerfromclientnum(var_0) {
  if(var_0 < 0)
    return undefined;

  for (var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] getentitynumber() == var_0)
      return level.players[var_1];
  }

  return undefined;
}

getrandomspectatorspawnpoint() {
  var_0 = "mp_global_intermission";
  var_1 = getentarray(var_0, "classname");
  var_2 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_1);
  return var_2;
}

onspawnspectator(var_0, var_1) {
  if(isdefined(var_0) && isdefined(var_1)) {
    self setspectatedefaults(var_0, var_1);
    self spawn(var_0, var_1);
    return;
  }

  var_2 = getrandomspectatorspawnpoint();
  self setspectatedefaults(var_2.origin, var_2.angles);
  self spawn(var_2.origin, var_2.angles);
}

spawnintermission() {
  self endon("disconnect");
  self notify("spawned");
  self notify("end_respawn");
  setspawnvariables();
  maps\mp\_utility::clearlowermessages();
  maps\mp\_utility::freezecontrolswrapper(1);
  self disableammogeneration();
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  var_0 = self.pers["postGameChallenges"];

  if(level.rankedmatch && (self.postgamepromotion || isdefined(var_0) && var_0)) {
    if(self.postgamepromotion)
      self playlocalsound("mp_level_up");
    else if(isdefined(var_0))
      self playlocalsound("mp_challenge_complete");

    if(self.postgamepromotion > level.postgamenotifies)
      level.postgamenotifies = 1;

    if(isdefined(var_0) && var_0 > level.postgamenotifies)
      level.postgamenotifies = var_0;

    var_1 = 7.0;

    if(isdefined(var_0))
      var_1 = 4.0 + min(var_0, 3);

    while (var_1) {
      wait 0.25;
      var_1 = var_1 - 0.25;
    }
  }

  maps\mp\_utility::updatesessionstate("intermission");
  maps\mp\_utility::clearkillcamstate();
  self.friendlydamage = undefined;
  var_2 = getentarray("mp_global_intermission", "classname");
  var_3 = var_2[0];
  self spawn(var_3.origin, var_3.angles);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

spawnendofgame() {
  if(1) {
    maps\mp\_utility::freezecontrolswrapper(1);
    self disableammogeneration();
    spawnspectator();
    maps\mp\_utility::freezecontrolswrapper(1);
    self disableammogeneration();
    return;
  }

  self notify("spawned");
  self notify("end_respawn");
  setspawnvariables();
  maps\mp\_utility::clearlowermessages();
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  maps\mp\_utility::updatesessionstate("dead");
  maps\mp\_utility::clearkillcamstate();
  self.friendlydamage = undefined;
  var_0 = getentarray("mp_global_intermission", "classname");
  var_1 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_0);
  self spawn(var_1.origin, var_1.angles);
  var_1 setmodel("tag_origin");
  self playerlinkto(var_1);
  self playerhide();
  maps\mp\_utility::freezecontrolswrapper(1);
  self disableammogeneration();
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

setspawnvariables() {
  self stopshellshock();
  self stoprumble("damage_heavy");
  self.deathposition = undefined;
}

notifyconnecting() {
  waittillframeend;

  if(isdefined(self))
    level notify("connecting", self);
}

logplayerstats() {
  if(isdefined(self.pers["totalKillcamsSkipped"]))
    setmatchdata("players", self.clientid, "totalKillcamsSkipped", maps\mp\_utility::clamptobyte(self.pers["totalKillcamsSkipped"]));

  if(isdefined(self.pers["weaponPickupsCount"]))
    setmatchdata("players", self.clientid, "weaponPickupsCount", maps\mp\_utility::clamptobyte(self.pers["weaponPickupsCount"]));

  if(isdefined(self.pers["suicides"]))
    setmatchdata("players", self.clientid, "suicidesTotal", maps\mp\_utility::clamptobyte(self.pers["suicides"]));

  if(isdefined(self.pers["headshots"]))
    setmatchdata("players", self.clientid, "headshotsTotal", maps\mp\_utility::clamptoshort(self.pers["headshots"]));

  if(isdefined(self.pers["pingAccumulation"]) && isdefined(self.pers["pingSampleCount"])) {
    if(self.pers["pingSampleCount"] > 0) {
      var_0 = maps\mp\_utility::clamptobyte(self.pers["pingAccumulation"] / self.pers["pingSampleCount"]);
      setmatchdata("players", self.clientid, "averagePing", var_0);
    }
  }

  if(maps\mp\_utility::rankingenabled()) {
    var_1 = 3;
    var_2 = 0;

    for (var_3 = 0; var_3 < var_1; var_3++) {
      var_4 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "xpMultiplier", var_3);

      if(isdefined(var_4) && var_4 > var_2)
        var_2 = var_4;
    }

    if(var_2 > 0)
      setmatchdata("players", self.clientid, "xpMultiplier", var_2);
  }

  if(isdefined(self.pers["summary"]) && isdefined(self.pers["summary"]["clanWarsXP"]))
    setmatchdata("players", self.clientid, "clanWarsXp", self.pers["summary"]["clanWarsXP"]);

  if(isdefined(level.ishorde) && level.ishorde)
    [[level.hordeupdatetimestats]](self);
}

callback_playerdisconnect(var_0) {
  if(!isdefined(self.connected)) {
    return;
  }
  maps\mp\gametypes\_damage::handlelaststanddisconnect();
  setmatchdata("players", self.clientid, "disconnectTimeUTC", getsystemtime());
  setmatchdata("players", self.clientid, "disconnectReason", var_0);

  if(maps\mp\_utility::rankingenabled())
    maps\mp\_matchdata::logfinalstats();

  if(isdefined(self.pers["confirmed"]))
    maps\mp\_matchdata::logkillsconfirmed();

  if(isdefined(self.pers["denied"]))
    maps\mp\_matchdata::logkillsdenied();

  logplayerstats();

  if(maps\mp\_utility::isroundbased()) {
    var_1 = game["roundsPlayed"] + 1;
    setmatchdata("players", self.clientid, "playerQuitRoundNumber", var_1);

    if(isdefined(self.team) && (self.team == "allies" || self.team == "axis")) {
      if(self.team == "allies") {
        setmatchdata("players", self.clientid, "playerQuitTeamScore", game["roundsWon"]["allies"]);
        setmatchdata("players", self.clientid, "playerQuitOpposingTeamScore", game["roundsWon"]["axis"]);
      } else {
        setmatchdata("players", self.clientid, "playerQuitTeamScore", game["roundsWon"]["axis"]);
        setmatchdata("players", self.clientid, "playerQuitOpposingTeamScore", game["roundsWon"]["allies"]);
      }
    }
  } else if(isdefined(self.team) && (self.team == "allies" || self.team == "axis") && level.teambased) {
    if(self.team == "allies") {
      setmatchdata("players", self.clientid, "playerQuitTeamScore", game["teamScores"]["allies"]);
      setmatchdata("players", self.clientid, "playerQuitOpposingTeamScore", game["teamScores"]["axis"]);
    } else {
      setmatchdata("players", self.clientid, "playerQuitTeamScore", game["teamScores"]["axis"]);
      setmatchdata("players", self.clientid, "playerQuitOpposingTeamScore", game["teamScores"]["allies"]);
    }
  }

  maps\mp\_skill::processplayer();
  removeplayerondisconnect();
  maps\mp\gametypes\_spawnlogic::removefromparticipantsarray();
  maps\mp\gametypes\_spawnlogic::removefromcharactersarray();
  var_2 = self getentitynumber();

  if(!level.teambased)
    game["roundsWon"][self.guid] = undefined;

  if(!level.gameended)
    maps\mp\_utility::logxpgains();

  if(level.splitscreen) {
    var_3 = level.players;

    if(var_3.size <= 1)
      level thread maps\mp\gametypes\_gamelogic::forceend();
  }

  maps\mp\gametypes\_gamelogic::setplayerrank(self);
  reconevent("script_mp_playerquit: player_name %s, player %d, gameTime %d", self.name, self.clientid, gettime());
  var_4 = self getentitynumber();
  var_5 = self.guid;
  logprint("Q;" + var_5 + ";" + var_4 + ";" + self.name + "\n");
  thread maps\mp\_events::disconnected();

  if(level.gameended)
    maps\mp\gametypes\_gamescore::removedisconnectedplayerfromplacement();

  if(isdefined(self.team))
    removefromteamcount();

  if(self.sessionstate == "playing" && !(isdefined(self.fauxdead) && self.fauxdead))
    removefromalivecount(1);
  else if(self.sessionstate == "spectator" || self.sessionstate == "dead")
    level thread maps\mp\gametypes\_gamelogic::updategameevents();
}

removeplayerondisconnect() {
  var_0 = 0;

  for (var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] == self) {
      for (var_0 = 1; var_1 < level.players.size - 1; var_1++)
        level.players[var_1] = level.players[var_1 + 1];

      level.players[var_1] = undefined;
      level notify("playerCountChanged");
      break;
    }
  }
}

initclientdvarssplitscreenspecific() {
  if(level.splitscreen || self issplitscreenplayer())
    self setclientdvars("cg_hudGrenadeIconHeight", "37.5", "cg_hudGrenadeIconWidth", "37.5", "cg_hudGrenadeIconOffset", "75", "cg_hudGrenadePointerHeight", "18", "cg_hudGrenadePointerWidth", "37.5", "cg_hudGrenadePointerPivot", "18 40.5", "cg_fovscale", "0.75");
  else
    self setclientdvars("cg_hudGrenadeIconHeight", "25", "cg_hudGrenadeIconWidth", "25", "cg_hudGrenadeIconOffset", "50", "cg_hudGrenadePointerHeight", "12", "cg_hudGrenadePointerWidth", "25", "cg_hudGrenadePointerPivot", "12 27", "cg_fovscale", "1");
}

initclientdvars() {
  setdvar("cg_drawTalk", 1);
  setdvar("cg_drawCrosshair", 1);
  setdvar("cg_drawCrosshairNames", 1);
  setdvar("cg_hudGrenadeIconMaxRangeFrag", 250);

  if(level.hardcoremode) {
    setdvar("cg_drawTalk", 3);
    setdvar("cg_drawCrosshair", 0);
    setdvar("cg_drawCrosshairNames", 1);
    setdvar("cg_hudGrenadeIconMaxRangeFrag", 0);
  }

  if(isdefined(level.alwaysdrawfriendlynames) && level.alwaysdrawfriendlynames)
    setdvar("cg_drawFriendlyNamesAlways", 1);
  else
    setdvar("cg_drawFriendlyNamesAlways", 0);

  initclientdvarssplitscreenspecific();

  if(maps\mp\_utility::getgametypenumlives())
    self setclientdvars("cg_deadChatWithDead", 1, "cg_deadChatWithTeam", 0, "cg_deadHearTeamLiving", 0, "cg_deadHearAllLiving", 0);
  else
    self setclientdvars("cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0);

  if(level.teambased)
    self setclientdvars("cg_everyonehearseveryone", 0);

  if(getdvarint("scr_hitloc_debug")) {
    for (var_0 = 0; var_0 < 6; var_0++)
      self setclientdvar("ui_hitloc_" + var_0, "");

    self.hitlocinited = 1;
  }
}

getlowestavailableclientid() {
  var_0 = 0;

  for (var_1 = 0; var_1 < 30; var_1++) {
    foreach(var_3 in level.players) {
      if(!isdefined(var_3)) {
        continue;
      }
      if(var_3.clientid == var_1) {
        var_0 = 1;
        break;
      }

      var_0 = 0;
    }

    if(!var_0)
      return var_1;
  }
}

setupsavedactionslots() {
  self.saved_actionslotdata = [];

  for (var_0 = 1; var_0 <= 4; var_0++) {
    self.saved_actionslotdata[var_0] = spawnstruct();
    self.saved_actionslotdata[var_0].type = "";
    self.saved_actionslotdata[var_0].item = undefined;
  }

  if(!level.console) {
    for (var_0 = 5; var_0 <= 8; var_0++) {
      self.saved_actionslotdata[var_0] = spawnstruct();
      self.saved_actionslotdata[var_0].type = "";
      self.saved_actionslotdata[var_0].item = undefined;
    }
  }
}

logplayerconsoleidandonwifiinmatchdata() {
  var_0 = getcodanywherecurrentplatform();
  var_1 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "consoleIDChunkLow", var_0);
  var_2 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "consoleIDChunkHigh", var_0);

  if(isdefined(var_1) && var_1 != 0)
    setmatchdata("players", self.clientid, "consoleIDChunkLow", var_1);

  if(isdefined(var_2) && var_2 != 0)
    setmatchdata("players", self.clientid, "consoleIDChunkHigh", var_2);

  var_3 = 3;
  var_4 = -1;

  if(isdefined(var_2) && var_2 != 0 && isdefined(var_1) && var_1 != 0) {
    for (var_5 = 0; var_5 < var_3; var_5++) {
      var_6 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "deviceConnectionHistory", var_5, "device_id_high");
      var_7 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "deviceConnectionHistory", var_5, "device_id_low");

      if(var_6 == var_2 && var_7 == var_1) {
        var_4 = var_5;
        break;
      }
    }
  }

  if(var_4 == -1) {
    var_8 = 0;

    for (var_5 = 0; var_5 < var_3; var_5++) {
      var_9 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "deviceConnectionHistory", var_5, "deviceUseFrequency");

      if(var_9 > var_8) {
        var_8 = var_9;
        var_4 = var_5;
      }
    }
  }

  if(var_4 == -1)
    var_4 = 0;

  var_10 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "deviceConnectionHistory", var_4, "onWifi");

  if(var_10)
    setmatchdata("players", self.clientid, "playingOnWifi", 1);
}

truncateplayername(var_0) {
  if(level.xb3 && var_0.size > 18) {
    var_1 = common_scripts\utility::string_find(var_0, "]");

    if(var_1 >= 0 && common_scripts\utility::string_starts_with(var_0, "["))
      var_0 = getsubstr(var_0, var_1 + 1);
  }

  return var_0;
}

extractplayername(var_0) {
  var_1 = common_scripts\utility::string_find(var_0, "]");

  if(var_1 >= 0 && common_scripts\utility::string_starts_with(var_0, "["))
    var_0 = getsubstr(var_0, var_1 + 1);

  return var_0;
}

extractclantag(var_0) {
  var_1 = common_scripts\utility::string_find(var_0, "]");
  var_2 = common_scripts\utility::string_find(var_0, "[");

  if(var_1 >= 0 && var_2 >= 0) {
    var_0 = getsubstr(var_0, var_2 + 1, var_1);
    return var_0;
  }

  return "";
}

callback_playerconnect() {
  var_0 = getrandomspectatorspawnpoint();
  self setspectatedefaults(var_0.origin, var_0.angles);
  thread notifyconnecting();
  self waittill("begin");
  self.connecttime = gettime();
  level notify("connected", self);
  self.connected = 1;

  if(self ishost())
    level.player = self;

  self.usingonlinedataoffline = self isusingonlinedataoffline();
  initclientdvars();
  initplayerstats();

  if(getdvar("r_reflectionProbeGenerate") == "1")
    level waittill("eternity");

  self.guid = self getguid();
  self.xuid = self getxuid();
  self.totallifetime = 0;
  var_1 = 0;

  if(!isdefined(self.pers["clientid"])) {
    if(game["clientid"] >= 30)
      self.pers["clientid"] = getlowestavailableclientid();
    else
      self.pers["clientid"] = game["clientid"];

    if(game["clientid"] < 30)
      game["clientid"]++;

    var_1 = 1;
  }

  if(var_1)
    streamprimaryweapons();

  self.clientid = self.pers["clientid"];
  self.pers["teamKillPunish"] = 0;
  self.pers["suicideSpawnDelay"] = 0;

  if(var_1)
    reconevent("script_mp_playerjoin: player_name %s, player %d, gameTime %d", self.name, self.clientid, gettime());

  logprint("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");

  if(game["clientid"] <= 30 && game["clientid"] != getmatchdata("playerCount")) {
    var_2 = 0;
    var_3 = 0;

    if(!isai(self) && maps\mp\_utility::matchmakinggame())
      self registerparty(self.clientid);

    setmatchdata("playerCount", game["clientid"]);
    setmatchdata("players", self.clientid, "playerID", "xuid", self getxuid());
    setmatchdata("players", self.clientid, "playerID", "ucdIDHigh", self getucdidhigh());
    setmatchdata("players", self.clientid, "playerID", "ucdIDLow", self getucdidlow());
    setmatchdata("players", self.clientid, "playerID", "clanIDHigh", self getclanidhigh());
    setmatchdata("players", self.clientid, "playerID", "clanIDLow", self getclanidlow());
    setmatchdata("players", self.clientid, "gamertag", truncateplayername(self.name));
    setmatchdata("players", self.clientid, "isBot", isai(self));
    var_4 = self getentitynumber();
    setmatchdata("players", self.clientid, "codeClientNum", maps\mp\_utility::clamptobyte(var_4));
    var_5 = getcodanywherecurrentplatform();
    var_3 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "connectionIDChunkLow", var_5);
    var_2 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "connectionIDChunkHigh", var_5);
    setmatchdata("players", self.clientid, "connectionIDChunkLow", var_3);
    setmatchdata("players", self.clientid, "connectionIDChunkHigh", var_2);
    setmatchclientip(self, self.clientid);
    setmatchdata("players", self.clientid, "joinType", self getjointype());
    setmatchdata("players", self.clientid, "connectTimeUTC", getsystemtime());
    setmatchdata("players", self.clientid, "isSplitscreen", issplitscreen());
    logplayerconsoleidandonwifiinmatchdata();

    if(self ishost())
      setmatchdata("players", self.clientid, "wasAHost", 1);

    if(maps\mp\_utility::rankingenabled())
      maps\mp\_matchdata::loginitialstats();

    if(istestclient(self) || isai(self))
      var_6 = 1;
    else
      var_6 = 0;

    if(maps\mp\_utility::matchmakinggame() && maps\mp\_utility::allowteamchoice() && !var_6)
      setmatchdata("players", self.clientid, "team", self.sessionteam);

    if(maps\mp\_utility::isaiteamparticipant(self)) {
      if(!isdefined(level.matchdata))
        level.matchdata = [];

      if(!isdefined(level.matchdata["botJoinCount"]))
        level.matchdata["botJoinCount"] = 1;
      else
        level.matchdata["botJoinCount"]++;
    }
  }

  if(!level.teambased)
    game["roundsWon"][self.guid] = 0;

  self.leaderdialogqueue = [];
  self.leaderdialoglocqueue = [];
  self.leaderdialogactive = "";
  self.leaderdialoggroups = [];
  self.leaderdialoggroup = "";

  if(!isdefined(self.pers["cur_kill_streak"])) {
    self.pers["cur_kill_streak"] = 0;
    self.killstreakcount = 0;
    self setclientomnvar("ks_count1", 0);
  }

  if(!isdefined(self.pers["cur_death_streak"]))
    self.pers["cur_death_streak"] = 0;

  if(!isdefined(self.pers["cur_kill_streak_for_nuke"]))
    self.pers["cur_kill_streak_for_nuke"] = 0;

  if(maps\mp\_utility::rankingenabled())
    self.kill_streak = maps\mp\gametypes\_persistence::statget("killStreak");

  self.lastgrenadesuicidetime = -1;
  self.teamkillsthisround = 0;
  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.wasaliveatmatchstart = 0;
  self.movespeedscaler = level.baseplayermovescale;
  self.killstreakscaler = 1;
  self.objectivescaler = 1;
  self.issniper = 0;
  setupsavedactionslots();
  level thread monitorplayersegments(self);
  thread maps\mp\_flashgrenades::monitorflash();
  resetuidvarsonconnect();
  maps\mp\_snd_common_mp::snd_mp_player_join();
  waittillframeend;
  level.players[level.players.size] = self;
  level notify("playerCountChanged");
  maps\mp\gametypes\_spawnlogic::addtoparticipantsarray();
  maps\mp\gametypes\_spawnlogic::addtocharactersarray();

  if(level.teambased)
    self updatescores();

  if(!isdefined(self.pers["absoluteJoinTime"]))
    self.pers["absoluteJoinTime"] = getsystemtime();

  if(game["state"] == "postgame") {
    self.connectedpostgame = 1;
    spawnintermission();
  } else {
    if(isai(self) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["think"]))
      self thread[[level.bot_funcs["think"]]]();

    level endon("game_ended");

    if(isdefined(level.hostmigrationtimer)) {
      if(!isdefined(self.hostmigrationcontrolsfrozen) || self.hostmigrationcontrolsfrozen == 0) {
        self.hostmigrationcontrolsfrozen = 0;
        thread maps\mp\gametypes\_hostmigration::hostmigrationtimerthink();
      }
    }

    if(isdefined(level.onplayerconnectaudioinit))
      [[level.onplayerconnectaudioinit]]();

    if(!isdefined(self.pers["team"])) {
      if(maps\mp\_utility::matchmakinggame() && self.sessionteam != "none") {
        thread spawnspectator();

        if(isdefined(level.waitingforplayers) && level.waitingforplayers)
          maps\mp\_utility::freezecontrolswrapper(1);

        thread maps\mp\gametypes\_menus::setteam(self.sessionteam);

        if(maps\mp\_utility::allowclasschoice())
          thread setuioptionsmenu(2);

        thread kickifdontspawn();
        return;
      } else if(!maps\mp\_utility::matchmakinggame() && !maps\mp\_utility::forceautoassign() && maps\mp\_utility::allowteamchoice()) {
        maps\mp\gametypes\_menus::menuspectator();
        thread setuioptionsmenu(1);

        if(self ismlgspectator())
          maps\mp\_utility::freezecontrolswrapper(1);
      } else {
        thread spawnspectator();
        self[[level.autoassign]]();

        if(maps\mp\_utility::allowclasschoice())
          thread setuioptionsmenu(2);

        if(maps\mp\_utility::matchmakinggame())
          thread kickifdontspawn();

        return;
      }
    } else {
      maps\mp\gametypes\_menus::addtoteam(self.pers["team"], 1);

      if(maps\mp\_utility::isvalidclass(self.pers["class"]) && !maps\mp\_utility::ishodgepodgeph()) {
        thread spawnclient();
        return;
      }

      thread spawnspectator();

      if(self.pers["team"] == "spectator") {
        if(maps\mp\_utility::allowteamchoice()) {
          maps\mp\gametypes\_menus::beginteamchoice();
          return;
        }

        self[[level.autoassign]]();
        return;
        return;
      }

      maps\mp\gametypes\_menus::beginclasschoice();
    }
  }
}

callback_playermigrated() {
  if(isdefined(self.connected) && self.connected) {
    maps\mp\_utility::updateobjectivetext();
    maps\mp\_utility::updatemainmenu();

    if(level.teambased)
      self updatescores();
  }

  if(self ishost()) {
    initclientdvarssplitscreenspecific();
    setmatchdata("players", self.clientid, "wasAHost", 1);
  }

  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isbot(var_2) && !istestclient(var_2))
      var_0++;
  }

  if(!isbot(self) && !istestclient(self)) {
    level.hostmigrationreturnedplayercount++;

    if(level.hostmigrationreturnedplayercount >= var_0 * 2 / 3)
      level notify("hostmigration_enoughplayers");

    self notify("player_migrated");
  }
}

forcespawn() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");
  wait 60.0;

  if(self.hasspawned) {
    return;
  }
  if(self.pers["team"] == "spectator") {
    return;
  }
  if(!maps\mp\_utility::isvalidclass(self.pers["class"])) {
    self.pers["class"] = "CLASS_CUSTOM1";
    self.class = self.pers["class"];
    maps\mp\gametypes\_class::clearcopycatloadout();
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
  var_2 = gettime();

  if(self ishost())
    kickwait(120);
  else
    kickwait(var_0);

  var_3 = (gettime() - var_2) / 1000;

  if(var_3 < var_0 - 0.1 && var_3 < var_1) {
    return;
  }
  if(self.hasspawned) {
    return;
  }
  if(self.pers["team"] == "spectator") {
    return;
  }
  kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
  level thread maps\mp\gametypes\_gamelogic::updategameevents();
}

kickwait(var_0) {
  level endon("game_ended");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_0);
}

initplayerstats() {
  maps\mp\gametypes\_persistence::initbufferedstats();
  self.pers["lives"] = maps\mp\_utility::getgametypenumlives();

  if(!isdefined(self.pers["deaths"])) {
    maps\mp\_utility::initpersstat("deaths");
    maps\mp\gametypes\_persistence::statsetchild("round", "deaths", 0);
  }

  self.deaths = maps\mp\_utility::getpersstat("deaths");

  if(!isdefined(self.pers["score"])) {
    maps\mp\_utility::initpersstat("score");
    maps\mp\gametypes\_persistence::statsetchild("round", "score", 0);
    maps\mp\gametypes\_persistence::statsetchildbuffered("round", "timePlayed", 0);
  }

  self.score = int(min(maps\mp\_utility::getpersstat("score"), 65535));
  self.timeplayed["total"] = maps\mp\gametypes\_persistence::statgetchildbuffered("round", "timePlayed");

  if(!isdefined(self.pers["suicides"]))
    maps\mp\_utility::initpersstat("suicides");

  self.suicides = maps\mp\_utility::getpersstat("suicides");

  if(!isdefined(self.pers["kills"])) {
    maps\mp\_utility::initpersstat("kills");
    maps\mp\gametypes\_persistence::statsetchild("round", "kills", 0);
  }

  self.kills = maps\mp\_utility::getpersstat("kills");

  if(!isdefined(self.pers["headshots"])) {
    maps\mp\_utility::initpersstat("headshots");
    maps\mp\gametypes\_persistence::statsetchild("round", "headshots", 0);
  }

  self.headshots = maps\mp\_utility::getpersstat("headshots");

  if(!isdefined(self.pers["assists"])) {
    maps\mp\_utility::initpersstat("assists");
    maps\mp\gametypes\_persistence::statsetchild("round", "assists", 0);
  }

  self.assists = maps\mp\_utility::getpersstat("assists");

  if(!isdefined(self.pers["captures"])) {
    maps\mp\_utility::initpersstat("captures");
    maps\mp\gametypes\_persistence::statsetchild("round", "captures", 0);
  }

  if(!isdefined(self.pers["returns"])) {
    maps\mp\_utility::initpersstat("returns");
    maps\mp\gametypes\_persistence::statsetchild("round", "returns", 0);
  }

  self.returns = maps\mp\_utility::getpersstat("returns");

  if(!isdefined(self.pers["defends"])) {
    maps\mp\_utility::initpersstat("defends");
    maps\mp\gametypes\_persistence::statsetchild("round", "defends", 0);
  }

  if(!isdefined(self.pers["plants"])) {
    maps\mp\_utility::initpersstat("plants");
    maps\mp\gametypes\_persistence::statsetchild("round", "plants", 0);
  }

  if(!isdefined(self.pers["defuses"])) {
    maps\mp\_utility::initpersstat("defuses");
    maps\mp\gametypes\_persistence::statsetchild("round", "defuses", 0);
  }

  if(!isdefined(self.pers["destructions"])) {
    maps\mp\_utility::initpersstat("destructions");
    maps\mp\gametypes\_persistence::statsetchild("round", "destructions", 0);
  }

  if(!isdefined(self.pers["confirmed"])) {
    maps\mp\_utility::initpersstat("confirmed");
    maps\mp\gametypes\_persistence::statsetchild("round", "confirmed", 0);
  }

  if(!isdefined(self.pers["denied"])) {
    maps\mp\_utility::initpersstat("denied");
    maps\mp\gametypes\_persistence::statsetchild("round", "denied", 0);
  }

  if(!isdefined(self.pers["setbacks"])) {
    maps\mp\_utility::initpersstat("setbacks");
    maps\mp\gametypes\_persistence::statsetchild("round", "setbacks", 0);
  }

  if(!isdefined(self.pers["humiliations"])) {
    maps\mp\_utility::initpersstat("humiliations");
    maps\mp\gametypes\_persistence::statsetchild("round", "humiliations", 0);
  }

  if(!isdefined(self.pers["rescues"])) {
    maps\mp\_utility::initpersstat("rescues");
    maps\mp\gametypes\_persistence::statsetchild("round", "rescues", 0);
  }

  if(!isdefined(self.pers["captureTime"])) {
    maps\mp\_utility::initpersstat("captureTime");
    maps\mp\gametypes\_persistence::statsetchild("round", "captureTime", 0);
  }

  if(!isdefined(self.pers["banked"])) {
    maps\mp\_utility::initpersstat("banked");
    maps\mp\gametypes\_persistence::statsetchild("round", "banked", 0);
  }

  if(!isdefined(self.pers["muggings"])) {
    maps\mp\_utility::initpersstat("muggings");
    maps\mp\gametypes\_persistence::statsetchild("round", "muggings", 0);
  }

  if(!isdefined(self.pers["teamkills"]))
    maps\mp\_utility::initpersstat("teamkills");

  if(!isdefined(self.pers["totalTeamKills"]))
    maps\mp\_utility::initpersstat("totalTeamKills");

  if(!isdefined(self.pers["extrascore0"]))
    maps\mp\_utility::initpersstat("extrascore0");

  if(!isdefined(self.pers["extrascore1"]))
    maps\mp\_utility::initpersstat("extrascore1");

  if(!isdefined(self.pers["teamKillPunish"]))
    self.pers["teamKillPunish"] = 0;

  if(!isdefined(self.pers["suicideSpawnDelay"]))
    self.pers["suicideSpawnDelay"] = 0;

  maps\mp\_utility::initpersstat("longestStreak");
  self.pers["lives"] = maps\mp\_utility::getgametypenumlives();
  maps\mp\gametypes\_persistence::statsetchild("round", "killStreak", 0);
  maps\mp\gametypes\_persistence::statsetchild("round", "loss", 0);
  maps\mp\gametypes\_persistence::statsetchild("round", "win", 0);
  maps\mp\gametypes\_persistence::statsetchild("round", "scoreboardType", "none");

  if(maps\mp\_utility::rankingenabled()) {
    if(!isdefined(self.pers["previous_shots"]))
      self.pers["previous_shots"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "totalShots");

    if(!isdefined(self.pers["previous_hits"]))
      self.pers["previous_hits"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "hits");
  }

  if(!isdefined(self.pers["mpWeaponStats"]))
    self.pers["mpWeaponStats"] = [];

  if(!isdefined(self.pers["totalKillcamsSkipped"]))
    self.pers["totalKillcamsSkipped"] = 0;

  if(!isdefined(self.pers["weaponPickupsCount"]))
    self.pers["weaponPickupsCount"] = 0;

  if(!isdefined(self.pers["pingAccumulation"]))
    self.pers["pingAccumulation"] = 0;

  if(!isdefined(self.pers["pingSampleCount"]))
    self.pers["pingSampleCount"] = 0;

  if(!isdefined(self.pers["minPing"]))
    self.pers["minPing"] = 32767;

  if(!isdefined(self.pers["maxPing"]))
    self.pers["maxPing"] = 0;

  if(!isdefined(self.pers["validationInfractions"]))
    self.pers["validationInfractions"] = 0;

  if(!isdefined(self.pers["killed_players"]))
    self.pers["killed_players"] = [];

  if(!isdefined(self.pers["killed_by"]))
    self.pers["killed_by"] = [];

  if(!isdefined(self.pers["nemesis_tracking"]))
    self.pers["nemesis_tracking"] = [];

  if(!isdefined(self.pers["nemesis_guid"]))
    self.pers["nemesis_guid"] = "";

  if(!isdefined(self.pers["prey_guid"]))
    self.pers["prey_guid"] = "";
}

addtoteamcount() {
  level.teamcount[self.team]++;

  if(!isdefined(level.teamlist))
    level.teamlist = [];

  if(!isdefined(level.teamlist[self.team]))
    level.teamlist[self.team] = [];

  level.teamlist[self.team][level.teamlist[self.team].size] = self;
  maps\mp\gametypes\_gamelogic::updategameevents();
}

removefromteamcount() {
  level.teamcount[self.team]--;

  if(isdefined(level.teamlist) && isdefined(level.teamlist[self.team])) {
    var_0 = [];

    foreach(var_2 in level.teamlist[self.team]) {
      if(!isdefined(var_2) || var_2 == self) {
        continue;
      }
      var_0[var_0.size] = var_2;
    }

    level.teamlist[self.team] = var_0;
  }
}

addtoalivecount() {
  var_0 = self.team;

  if(!(isdefined(self.alreadyaddedtoalivecount) && self.alreadyaddedtoalivecount)) {
    level.hasspawned[var_0]++;
    incrementalivecount(var_0);
  }

  self.alreadyaddedtoalivecount = undefined;

  if(level.alivecount["allies"] + level.alivecount["axis"] > level.maxplayercount)
    level.maxplayercount = level.alivecount["allies"] + level.alivecount["axis"];
}

incrementalivecount(var_0) {
  level.alivecount[var_0]++;
}

removefromalivecount(var_0) {
  var_1 = self.team;

  if(isdefined(self.switching_teams) && self.switching_teams && isdefined(self.joining_team) && self.joining_team == self.team)
    var_1 = self.leaving_team;

  if(isdefined(var_0))
    removeallfromlivescount();

  decrementalivecount(var_1);
  return maps\mp\gametypes\_gamelogic::updategameevents();
}

decrementalivecount(var_0) {
  level.alivecount[var_0]--;
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

resetuidvarsonspawn() {
  self setclientomnvar("ui_carrying_bomb", 0);
  self setclientomnvar("ui_capture_icon", 0);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_killcam_time_until_spawn", 0);
}

resetuidvarsonconnect() {
  self setclientomnvar("ui_carrying_bomb", 0);
  self setclientomnvar("ui_capture_icon", 0);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
}

resetuidvarsonspectate() {
  self setclientomnvar("ui_carrying_bomb", 0);
  self setclientomnvar("ui_capture_icon", 0);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
}

resetuidvarsondeath() {}

monitorplayersegments(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  createplayersegmentstats(var_0);

  for (;;) {
    var_0 waittill("spawned_player");
    recordsegemtdata(var_0);
  }
}

createplayersegmentstats(var_0) {
  if(!isdefined(var_0.pers["segments"]))
    var_0.pers["segments"] = [];

  var_0.segments = var_0.pers["segments"];

  if(!var_0.segments.size) {
    var_0.segments["distanceTotal"] = 0;
    var_0.segments["movingTotal"] = 0;
    var_0.segments["movementUpdateCount"] = 0;
    var_0.segments["killDistanceTotal"] = 0;
    var_0.segments["killDistanceCount"] = 0;
  }
}

recordsegemtdata(var_0) {
  var_0 endon("death");

  while (!maps\mp\_utility::gameflag("prematch_done"))
    wait 0.5;

  wait 4;
  var_0.savedposition = var_0.origin;
  var_0.positionptm = var_0.origin;

  for (;;) {
    wait 1;

    if(var_0 maps\mp\_utility::isusingremote()) {
      var_0 waittill("stopped_using_remote");
      var_0.savedposition = var_0.origin;
      var_0.positionptm = var_0.origin;
      continue;
    }

    var_0.segments["movementUpdateCount"]++;
    var_0.segments["distanceTotal"] = var_0.segments["distanceTotal"] + distance2d(var_0.savedposition, var_0.origin);
    var_0.savedposition = var_0.origin;

    if(var_0.segments["movementUpdateCount"] % 5 == 0) {
      var_1 = distance2d(var_0.positionptm, var_0.origin);
      var_0.positionptm = var_0.origin;

      if(var_1 > 16)
        var_0.segments["movingTotal"]++;
    }
  }
}

writesegmentdata(var_0) {
  if(level.players.size < 2) {
    return;
  }
  var_0 endon("disconnect");

  if(var_0.segments["movementUpdateCount"] < 30 || var_0.segments["killDistanceCount"] < 1) {
    return;
  }
  var_1 = var_0.segments["movingTotal"] / int(var_0.segments["movementUpdateCount"] / 5) * 100;
  var_2 = var_0.segments["distanceTotal"] / var_0.segments["movementUpdateCount"];
  var_3 = var_0.segments["killDistanceTotal"] / var_0.segments["killDistanceCount"];
  var_1 = min(var_1, float(tablelookup("mp\playerSegments.csv", 0, "MAX", 3)));
  var_2 = min(var_2, float(tablelookup("mp\playerSegments.csv", 0, "MAX", 2)));
  var_3 = min(var_3, float(tablelookup("mp\playerSegments.csv", 0, "MAX", 4)));
  var_4 = calculatematchplaystyle(var_1, var_2, var_3);
  setmatchdata("players", var_0.clientid, "averageSpeedDuringMatch", var_2);
  setmatchdata("players", var_0.clientid, "percentageOfTimeMoving", var_1);
  setmatchdata("players", var_0.clientid, "averageKillDistance", var_3);
  setmatchdata("players", var_0.clientid, "totalDistanceTravelled", var_0.segments["distanceTotal"]);
  setmatchdata("players", var_0.clientid, "playstyle", maps\mp\_utility::clamptobyte(var_4));

  if(isai(var_0)) {
    return;
  }
  reconevent("script_PlayerSegments: percentTimeMoving %f, averageSpeed %f, averageKillDistance %f, playStyle %d, name %s", var_1, var_2, var_3, var_4, var_0.name);

  if(!var_0 maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_5 = 50;
  var_6 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "numPlayStyleTrends");
  var_6++;

  if(var_6 > var_5) {
    var_6 = var_5;

    if(var_5 > 1) {
      for (var_7 = 0; var_7 < var_5 - 1; var_7++) {
        var_8 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "playStyleTimeStamp", var_7 + 1);
        var_9 = var_0 getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "playStyle", var_7 + 1);
        var_0 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "playStyleTimeStamp", var_7, var_8);
        var_0 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "playStyle", var_7, var_9);
      }
    }
  }

  var_8 = maps\mp\_utility::gettimeutc_for_stat_recording();
  var_0 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "playStyleTimeStamp", var_6 - 1, var_8);
  var_0 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "playStyle", var_6 - 1, var_4);
  var_0 setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "combatRecord", "numPlayStyleTrends", var_6);
}

calculatematchplaystyle(var_0, var_1, var_2) {
  var_0 = normalizeplayersegment(var_0, float(tablelookup("mp\playerSegments.csv", 0, "Mean", 3)), float(tablelookup("mp\playerSegments.csv", 0, "SD", 3)));
  var_1 = normalizeplayersegment(var_1, float(tablelookup("mp\playerSegments.csv", 0, "Mean", 2)), float(tablelookup("mp\playerSegments.csv", 0, "SD", 2)));
  var_2 = normalizeplayersegment(var_2, float(tablelookup("mp\playerSegments.csv", 0, "Mean", 4)), float(tablelookup("mp\playerSegments.csv", 0, "SD", 4)));
  var_3 = (var_0, var_1, var_2);
  var_4 = ["Camper", "Mobile", "Run", "Sniper", "TacCQ"];
  var_5 = "Camper";
  var_6 = 1000;

  foreach(var_8 in var_4) {
    var_9 = getcentroiddistance(var_3, var_8);

    if(var_9 < var_6) {
      var_5 = var_8;
      var_6 = var_9;
    }
  }

  return int(tablelookup("mp\playerSegments.csv", 0, var_5, 1));
}

normalizeplayersegment(var_0, var_1, var_2) {
  return (var_0 - var_1) / var_2;
}

getcentroiddistance(var_0, var_1) {
  var_2 = (float(tablelookup("mp\playerSegments.csv", 0, var_1, 3)), float(tablelookup("mp\playerSegments.csv", 0, var_1, 2)), float(tablelookup("mp\playerSegments.csv", 0, var_1, 4)));
  return distance(var_0, var_2);
}