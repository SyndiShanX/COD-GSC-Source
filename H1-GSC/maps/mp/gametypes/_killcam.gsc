/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_killcam.gsc
******************************************/

init() {
  level.killcam = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "allowkillcam");
}

setkillcamerastyle(var_0, var_1, var_2, var_3, var_4, var_5) {
  return 0;
}

prekillcamnotify(var_0, var_1, var_2, var_3) {
  if(isplayer(self) && isdefined(var_1) && isplayer(var_1)) {
    var_4 = gettime();
    waittillframeend;

    if(isplayer(self) && isdefined(var_1) && isplayer(var_1)) {
      var_4 = (gettime() - var_4) / 1000;
      var_5 = maps\mp\gametypes\_playerlogic::gatherclassweapons();
      var_6 = var_1 loadcustomizationplayerview(var_2 + var_4, var_3, var_5);
      var_7 = spawnstruct();
      var_7.team = var_1.team;
      var_7.weapon = var_1.loadoutprimary;
      var_8 = spawnstruct();
      var_8.cust = var_7;
      var_8.weapons = var_6;
      self.killcamstream = var_8;
      self hasloadedcustomizationplayerview(var_7, var_6);
      self precachekillcamiconforweapon(var_3);
    }
  }
}

killcamtime(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(getdvar("scr_killcam_time") == "") {
    var_7 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_5 || var_1 == "artillery_mp")
      var_8 = (gettime() - var_0) / 1000 - var_2 - 0.1;
    else if(var_6)
      var_8 = 4.0;
    else if(issubstr(var_1, "remotemissile_"))
      var_8 = 5;
    else if(!var_3)
      var_8 = 5.0;
    else if(var_7 == "h1_fraggrenade_mp" || var_7 == "h1_fraggrenadeshort_mp")
      var_8 = 4.25;
    else
      var_8 = 2.5;
  } else
    var_8 = getdvarfloat("scr_killcam_time");

  if(var_5 && var_8 > 5)
    var_8 = 5;

  if(isdefined(var_4)) {
    if(var_8 > var_4)
      var_8 = var_4;

    if(var_8 < 0.05)
      var_8 = 0.05;
  }

  return var_8;
}

killcamadjustalivetime(var_0, var_1, var_2) {
  var_3 = 1000;

  if(isdefined(var_1) && isdefined(var_2) && var_1 != var_2)
    return var_3;

  return var_0;
}

killcamarchivetime(var_0, var_1, var_2, var_3) {
  if(var_0 > var_1)
    var_0 = var_1;

  var_4 = var_0 + var_2 + var_3;
  return var_4;
}

killcamvalid(var_0, var_1) {
  return var_1 && level.killcam && !(isdefined(var_0.cancelkillcam) && var_0.cancelkillcam) && game["state"] == "playing" && !var_0 maps\mp\_utility::isusingremote() && !level.showingfinalkillcam && !isagent(var_0);
}

killcam(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");

  if(var_1 < 0 || !isdefined(var_13)) {
    return;
  }
  level.numplayerswaitingtoenterkillcam++;
  var_19 = level.numplayerswaitingtoenterkillcam * 0.05;

  if(level.numplayerswaitingtoenterkillcam > 1)
    wait(0.05 * (level.numplayerswaitingtoenterkillcam - 1));

  wait 0.05;
  level.numplayerswaitingtoenterkillcam--;
  var_20 = killcamtime(var_3, var_4, var_8, var_11, var_12, var_18, level.showingfinalkillcam);

  if(getdvar("scr_killcam_posttime") == "")
    var_21 = 2;
  else {
    var_21 = getdvarfloat("scr_killcam_posttime");

    if(var_21 < 0.05)
      var_21 = 0.05;
  }

  var_22 = var_20 + var_21;

  if(isdefined(var_12) && var_22 > var_12) {
    if(var_12 < 2) {
      return;
    }
    if(var_12 - var_20 >= 1)
      var_21 = var_12 - var_20;
    else {
      var_21 = 1;
      var_20 = var_12 - 1;
    }

    var_22 = var_20 + var_21;
  }

  self setclientomnvar("ui_killcam_end_milliseconds", 0);

  if(isagent(var_13) && !isdefined(var_13.isactive)) {
    return;
  }
  if(isplayer(var_14))
    self setclientomnvar("ui_killcam_victim_id", var_14 getentitynumber());
  else
    self setclientomnvar("ui_killcam_victim_id", -1);

  if(isplayer(var_13))
    self setclientomnvar("ui_killcam_killedby_id", var_13 getentitynumber());
  else if(isagent(var_13))
    self setclientomnvar("ui_killcam_killedby_id", -1);

  if(maps\mp\_utility::iskillstreakweapon(var_4)) {
    var_23 = maps\mp\_utility::getkillstreakrownum(level.killstreakwieldweapons[var_4]);
    self setclientomnvar("ui_killcam_killedby_killstreak", var_23);
    self setclientomnvar("ui_killcam_killedby_weapon", -1);
    self setclientomnvar("ui_killcam_killedby_weapon_custom", -1);
    self setclientomnvar("ui_killcam_killedby_weapon_alt", 0);
    self setclientomnvar("ui_killcam_copycat", 0);
  } else {
    var_24 = [];
    var_25 = getweaponbasename(var_4);

    if(isdefined(var_25)) {
      if(maps\mp\_utility::ismeleemod(var_15) && !maps\mp\gametypes\_weapons::isriotshield(var_4))
        var_25 = "iw5_combatknife";
      else {
        var_25 = maps\mp\_utility::strip_suffix(var_25, "_lefthand");
        var_25 = maps\mp\_utility::strip_suffix(var_25, "_mp");
      }

      self setclientomnvar("ui_killcam_killedby_weapon", var_5);
      self setclientomnvar("ui_killcam_killedby_weapon_custom", var_6);
      self setclientomnvar("ui_killcam_killedby_weapon_alt", var_7);
      self setclientomnvar("ui_killcam_killedby_killstreak", -1);

      if(var_25 != "iw5_combatknife")
        var_24 = getweaponattachments(var_4);

      self setclientomnvar("ui_killcam_copycat", 0);
    } else {
      self setclientomnvar("ui_killcam_killedby_weapon", -1);
      self setclientomnvar("ui_killcam_killedby_weapon_custom", -1);
      self setclientomnvar("ui_killcam_killedby_weapon_alt", 0);
      self setclientomnvar("ui_killcam_killedby_killstreak", -1);
      self setclientomnvar("ui_killcam_copycat", 0);
    }
  }

  if(isplayer(var_14) && var_14.pers["nemesis_guid"] == var_13.guid && var_14.pers["nemesis_tracking"][var_13.guid] >= 2)
    self setclientomnvar("ui_killcam_killedby_nemesis", 1);
  else
    self setclientomnvar("ui_killcam_killedby_nemesis", 0);

  if(!var_11 && !level.gameended)
    self setclientomnvar("ui_killcam_text", "skip");
  else if(!level.gameended)
    self setclientomnvar("ui_killcam_text", "respawn");
  else
    self setclientomnvar("ui_killcam_text", "none");

  switch (var_16) {
    case "score":
      self setclientomnvar("ui_killcam_type", 1);
      break;
    case "normal":
    default:
      self setclientomnvar("ui_killcam_type", 0);
      break;
  }

  var_26 = var_20 + var_8 + var_19;
  var_27 = gettime();
  self notify("begin_killcam", var_27);

  if(!isagent(var_13) && isdefined(var_13) && isplayer(var_14))
    var_13 visionsyncwithplayer(var_14);

  maps\mp\_utility::updatesessionstate("spectator");
  self.spectatekillcam = 1;

  if(isagent(var_13))
    var_1 = var_14 getentitynumber();

  self onlystreamactiveweapon(0);
  self.forcespectatorclient = var_1;
  self.killcamentity = -1;
  var_28 = setkillcamerastyle(var_0, var_1, var_2, var_4, var_14, var_20);

  if(!var_28)
    thread setkillcamentity(var_2, var_26, var_3);

  var_17 = killcamadjustalivetime(var_17, var_1, var_2);

  if(var_26 > var_17)
    var_26 = var_17;

  self.archivetime = var_26;
  self.killcamlength = var_22;
  self.psoffsettime = var_9;
  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 1);
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);

  if(level.multiteambased) {
    foreach(var_30 in level.teamnamelist)
    self allowspectateteam(var_30, 1);
  }

  foreach(var_30 in level.teamnamelist)
  self allowspectateteam(var_30, 1);

  thread endedkillcamcleanup();
  wait 0.05;

  if(!isdefined(self)) {
    return;
  }
  if(self.archivetime < var_26) {}

  var_20 = self.archivetime - 0.05 - var_8;
  var_22 = var_20 + var_21;
  self.killcamlength = var_22;

  if(var_20 <= 0) {
    maps\mp\_utility::updatesessionstate("dead");
    maps\mp\_utility::clearkillcamstate();
    self notify("killcam_ended");
    return;
  }

  self setclientomnvar("ui_killcam_end_milliseconds", int(var_22 * 1000) + gettime());

  if(level.showingfinalkillcam)
    thread dofinalkillcamfx(var_20, var_2);

  self.killcam = 1;
  thread spawnedkillcamcleanup();
  self.skippedkillcam = 0;
  self.killcamstartedtimedeciseconds = maps\mp\_utility::gettimepasseddecisecondsincludingrounds();

  if(!level.showingfinalkillcam)
    thread waitskipkillcambutton(var_10);
  else
    self notify("showing_final_killcam");

  thread endkillcamifnothingtoshow();
  waittillkillcamover();

  if(level.showingfinalkillcam) {
    if(self == var_13)
      var_13 maps\mp\gametypes\_missions::processchallenge("ch_moviestar");

    thread maps\mp\gametypes\_playerlogic::spawnendofgame();
    return;
  }

  thread killcamcleanup(1);
}

dofinalkillcamfx(var_0, var_1) {
  if(isdefined(level.doingfinalkillcamfx)) {
    return;
  }
  level.doingfinalkillcamfx = 1;
  var_2 = var_0;

  if(var_2 > 1.0) {
    var_2 = 1.0;
    wait(var_0 - 1.0);
  }

  setslowmotion(1.0, 0.25, var_2);
  wait(var_2 + 0.5);
  setslowmotion(0.25, 1, 1.0);
  level.doingfinalkillcamfx = undefined;
}

waittillkillcamover() {
  self endon("abort_killcam");
  wait(self.killcamlength - 0.05);
}

setkillcamentity(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("killcam_ended");
  var_3 = gettime() - var_1 * 1000;

  if(var_2 > var_3) {
    wait 0.05;
    var_1 = self.archivetime;
    var_3 = gettime() - var_1 * 1000;

    if(var_2 > var_3)
      wait((var_2 - var_3) / 1000);
  }

  self.killcamentity = var_0;
}

waitskipkillcambutton(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");

  while (self usebuttonpressed())
    wait 0.05;

  while (!self usebuttonpressed())
    wait 0.05;

  self.skippedkillcam = 1;

  if(isdefined(self.pers["totalKillcamsSkipped"]))
    self.pers["totalKillcamsSkipped"]++;

  if(var_0 <= 0)
    maps\mp\_utility::clearlowermessage("kc_info");

  self notify("abort_killcam");
}

endkillcamifnothingtoshow() {
  self endon("disconnect");
  self endon("killcam_ended");

  for (;;) {
    if(self.archivetime <= 0) {
      break;
    }

    wait 0.05;
  }

  self notify("abort_killcam");
}

spawnedkillcamcleanup() {
  self endon("disconnect");
  self endon("killcam_ended");
  self waittill("spawned");
  thread killcamcleanup(0);
}

endedkillcamcleanup() {
  self endon("disconnect");
  self endon("killcam_ended");
  level waittill("game_ended");
  thread killcamcleanup(1);
}

killcamcleanup(var_0) {
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self.killcam = undefined;

  if(isdefined(self.killcamstartedtimedeciseconds) && isplayer(self) && isdefined(self.lifeid) && maps\mp\_matchdata::canloglife(self.lifeid)) {
    var_1 = maps\mp\_utility::gettimepasseddecisecondsincludingrounds();
    setmatchdata("lives", self.lifeid, "killcamWatchTimeDeciSeconds", maps\mp\_utility::clamptobyte(var_1 - self.killcamstartedtimedeciseconds));
  }

  if(!level.gameended)
    maps\mp\_utility::clearlowermessage("kc_info");

  thread maps\mp\gametypes\_spectating::setspectatepermissions();
  self notify("killcam_ended");

  if(!var_0) {
    return;
  }
  maps\mp\_utility::updatesessionstate("dead");
  maps\mp\_utility::clearkillcamstate();
}

cancelkillcamonuse() {
  self.cancelkillcam = 0;
  thread cancelkillcamonuse_specificbutton(::cancelkillcamusebutton, ::cancelkillcamcallback);
}

cancelkillcamusebutton() {
  return self usebuttonpressed();
}

cancelkillcamsafespawnbutton() {
  return self fragbuttonpressed();
}

cancelkillcamcallback() {
  self.cancelkillcam = 1;
}

cancelkillcamsafespawncallback() {
  self.cancelkillcam = 1;
  self.wantsafespawn = 1;
}

cancelkillcamonuse_specificbutton(var_0, var_1) {
  self endon("death_delay_finished");
  self endon("disconnect");
  level endon("game_ended");

  for (;;) {
    if(!self[[var_0]]()) {
      wait 0.05;
      continue;
    }

    var_2 = 0;

    while (self[[var_0]]()) {
      var_2 = var_2 + 0.05;
      wait 0.05;
    }

    if(var_2 >= 0.5) {
      continue;
    }
    var_2 = 0;

    while (!self[[var_0]]() && var_2 < 0.5) {
      var_2 = var_2 + 0.05;
      wait 0.05;
    }

    if(var_2 >= 0.5) {
      continue;
    }
    self[[var_1]]();
    return;
  }
}