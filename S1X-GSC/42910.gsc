/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42910.gsc
**************************************/

init() {
  level.killcam = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "allowkillcam");
}

setcinematiccamerastyle(var_0, var_1, var_2, var_3, var_4) {
  self setclientomnvar("cam_scene_name", var_0);
  self setclientomnvar("cam_scene_lead", var_1);
  self setclientomnvar("cam_scene_support", var_2);

  if(isDefined(var_3)) {
    self setclientomnvar("cam_scene_lead_alt", var_3);
  } else {
    self setclientomnvar("cam_scene_lead_alt", var_1);
  }

  if(isDefined(var_4)) {
    self setclientomnvar("cam_scene_support_alt", var_4);
  } else {
    self setclientomnvar("cam_scene_support_alt", var_2);
  }
}

setkillcamerastyle(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0) && isDefined(var_0.agent_type)) {
    if(var_0.agent_type == "dog") {
      setcinematiccamerastyle("killcam_dog", var_0 getentitynumber(), self getentitynumber());
    } else {
      setcinematiccamerastyle("killcam_agent", var_0 getentitynumber(), self getentitynumber());
    }
  } else if(isDefined(var_4) && isDefined(var_3) && var_3 == "orbital_laser_fov_mp" && var_5 == 5) {
    var_6 = -1;

    if(isDefined(var_4.body)) {
      var_6 = var_4.body getentitynumber();
    }

    thread setcinematiccamerastyle("orbital_laser_killcam", var_1, var_4 getentitynumber(), var_1, var_6);
  } else if(var_2 >= 0) {
    setcinematiccamerastyle("unknown", -1, -1);
    return 0;
  } else if(level.showingfinalkillcam) {
    setcinematiccamerastyle("unknown", var_1, self getentitynumber());
  } else {
    setcinematiccamerastyle("unknown", var_1, -1);
  }

  return 1;
}

isworldkillcam(var_0, var_1) {
  if(isDefined(var_0) && var_0 getentitynumber() == worldentnumber() && isDefined(var_1) && isDefined(var_1.killcament)) {
    return 1;
  }

  return 0;
}

prekillcamnotify(var_0, var_1, var_2, var_3) {
  if(isPlayer(self) && isDefined(var_1) && isPlayer(var_1)) {
    var_4 = maps\mp\gametypes\_playerlogic::gatherclassweapons();
    var_5 = gettime();
    waitframe();

    if(isPlayer(self) && isDefined(var_1) && isPlayer(var_1)) {
      var_5 = (gettime() - var_5) / 1000;
      self.streamweapons = self loadcustomizationplayerview(var_1, var_2 + var_5, var_3, var_4);
      self precachekillcamiconforweapon(var_3);
    }
  }
}

killcamtime(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(getDvar("scr_killcam_time") == "") {
    var_7 = maps\mp\_utility::strip_suffix(var_1, "_lefthand");

    if(var_5 || var_1 == "artillery_mp" || var_1 == "stealth_bomb_mp" || var_1 == "killstreakmahem_mp") {
      var_8 = (gettime() - var_0) / 1000 - var_2 - 0.1;
    } else if(var_6 || var_1 == "agent_mp") {
      var_8 = 4.0;
    } else if(issubstr(var_1, "remotemissile_")) {
      var_8 = 5;
    } else if(!var_3 || var_3 > 5.0) {
      var_8 = 5.0;
    } else if(var_7 == "frag_grenade_mp" || var_7 == "frag_grenade_short_mp" || var_7 == "semtex_mp" || var_7 == "semtexproj_mp" || var_7 == "thermobaric_grenade_mp" || var_7 == "frag_grenade_var_mp" || var_7 == "contact_grenade_var_mp" || var_7 == "semtex_grenade_var_mp") {
      var_8 = 4.25;
    } else {
      var_8 = 2.5;
    }
  } else {
    var_8 = getdvarfloat("scr_killcam_time");
  }

  if(var_5 && var_8 > 5) {
    var_8 = 5;
  }

  if(isDefined(var_4)) {
    if(var_8 > var_4) {
      var_8 = var_4;
    }

    if(var_8 < 0.05) {
      var_8 = 0.05;
    }
  }

  return var_8;
}

killcamarchivetime(var_0, var_1, var_2, var_3) {
  if(var_0 > var_1) {
    var_0 = var_1;
  }

  var_4 = var_0 + var_2 + var_3;
  return var_4;
}

killcamvalid(var_0, var_1) {
  return var_1 && level.killcam && !(isDefined(var_0.cancelkillcam) && var_0.cancelkillcam) && game["state"] == "playing" && !var_0 maps\mp\_utility::isusingremote() && !level.showingfinalkillcam && !isai(var_0);
}

killcam(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  var_15 = isworldkillcam(var_0, var_9);

  if((var_1 < 0 || !isDefined(var_9)) && !var_15) {
    return;
  }
  level.numplayerswaitingtoenterkillcam++;
  var_16 = level.numplayerswaitingtoenterkillcam * 0.05;

  if(level.numplayerswaitingtoenterkillcam > 1) {
    wait(0.05 * (level.numplayerswaitingtoenterkillcam - 1));
  }

  wait 0.05;
  level.numplayerswaitingtoenterkillcam--;
  var_17 = killcamtime(var_3, var_4, var_5, var_7, var_8, var_14, level.showingfinalkillcam);

  if(getDvar("scr_killcam_posttime") == "") {
    var_18 = 2;
  } else {
    var_18 = getdvarfloat("scr_killcam_posttime");

    if(var_18 < 0.05) {
      var_18 = 0.05;
    }
  }

  var_19 = var_17 + var_18;

  if(isDefined(var_8) && var_19 > var_8) {
    if(var_8 < 2) {
      return;
    }
    if(var_8 - var_17 >= 1) {
      var_18 = var_8 - var_17;
    } else {
      var_18 = 1;
      var_17 = var_8 - 1;
    }

    var_19 = var_17 + var_18;
  }

  self setclientomnvar("ui_killcam_end_milliseconds", 0);

  if(isagent(var_9) && !isDefined(var_9.isactive)) {
    return;
  }
  if(isPlayer(var_9)) {
    self setclientomnvar("ui_killcam_killedby_id", var_9 getentitynumber());
  } else if(isagent(var_9)) {
    self setclientomnvar("ui_killcam_killedby_id", -1);
  }

  if(maps\mp\_utility::iskillstreakweapon(var_4)) {
    var_20 = maps\mp\_utility::getkillstreakrownum(level.killstreakwieldweapons[var_4]);
    self setclientomnvar("ui_killcam_killedby_killstreak", var_20);
    self setclientomnvar("ui_killcam_killedby_weapon", -1);
    self setclientomnvar("ui_killcam_killedby_attachment1", -1);
    self setclientomnvar("ui_killcam_killedby_attachment2", -1);
    self setclientomnvar("ui_killcam_killedby_attachment3", -1);
    self setclientomnvar("ui_killcam_copycat", 0);
  } else {
    var_21 = [];
    var_22 = getweaponbasename(var_4);

    if(isDefined(var_22)) {
      if(maps\mp\_utility::ismeleemod(var_11) && !maps\mp\gametypes\_weapons::isriotshield(var_4)) {
        var_22 = "iw5_combatknife";
      } else {
        var_22 = maps\mp\_utility::strip_suffix(var_22, "_lefthand");
        var_22 = maps\mp\_utility::strip_suffix(var_22, "_mp");
      }

      var_23 = tablelookuprownum("mp/statsTable.csv", 4, var_22);
      self setclientomnvar("ui_killcam_killedby_weapon", var_23);
      self setclientomnvar("ui_killcam_killedby_killstreak", -1);

      if(var_22 != "iw5_combatknife") {
        var_21 = getweaponattachments(var_4);
      }

      if(!level.showingfinalkillcam && maps\mp\_utility::practiceroundgame() && isPlayer(var_9) && !isbot(self) && !isagent(self) && maps\mp\gametypes\_class::loadoutvalidforcopycat(var_9)) {
        self setclientomnvar("ui_killcam_copycat", 1);
        thread waitcopycatkillcambutton(var_9);
      } else {
        self setclientomnvar("ui_killcam_copycat", 0);
      }
    } else {
      self setclientomnvar("ui_killcam_killedby_weapon", -1);
      self setclientomnvar("ui_killcam_killedby_killstreak", -1);
      self setclientomnvar("ui_killcam_copycat", 0);
    }

    for(var_24 = 0; var_24 < 3; var_24++) {
      if(isDefined(var_21[var_24])) {
        var_25 = tablelookuprownum("mp/attachmentTable.csv", 3, maps\mp\_utility::attachmentmap_tobase(var_21[var_24]));
        self setclientomnvar("ui_killcam_killedby_attachment" + (var_24 + 1), var_25);
        continue;
      }

      self setclientomnvar("ui_killcam_killedby_attachment" + (var_24 + 1), -1);
    }
  }

  if(var_7 && !level.gameended || isDefined(self) && isDefined(self.battlebuddy) && !level.gameended) {
    self setclientomnvar("ui_killcam_text", "skip");
  } else if(!level.gameended) {
    self setclientomnvar("ui_killcam_text", "respawn");
  } else {
    self setclientomnvar("ui_killcam_text", "none");
  }

  switch (var_12) {
    case "score":
      self setclientomnvar("ui_killcam_type", 1);
      break;
    case "normal":
    default:
      self setclientomnvar("ui_killcam_type", 0);
      break;
  }

  var_26 = var_17 + var_5 + var_16;
  var_27 = gettime();
  self notify("begin_killcam", var_27);

  if(!var_15 && !isagent(var_9) && isDefined(var_9) && isPlayer(var_10)) {
    var_9 visionsyncwithplayer(var_10);
  }

  maps\mp\_utility::updatesessionstate("spectator");
  self.spectatekillcam = 1;

  if(isagent(var_9)) {
    var_1 = var_10 getentitynumber();
  }

  self onlystreamactiveweapon(0);

  if(var_15) {
    self.forcespectatorclient = var_10 getentitynumber();
  } else {
    self.forcespectatorclient = var_1;
  }

  self.killcamentity = -1;
  var_28 = setkillcamerastyle(var_0, var_1, var_2, var_4, var_10, var_17);

  if(!var_28) {
    thread setkillcamentity(var_2, var_26, var_3);
  }

  if(var_15) {
    if(var_26 > gettime() / 1000.0) {
      var_26 = gettime() / 1000.0;
    }
  } else if(var_26 > var_13) {
    var_26 = var_13;
  }

  self.archivetime = var_26;
  self.killcamlength = var_19;
  self.psoffsettime = var_6;
  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 1);
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);

  if(level.multiteambased) {
    foreach(var_30 in level.teamnamelist) {
      self allowspectateteam(var_30, 1);
    }
  }

  foreach(var_30 in level.teamnamelist) {
    self allowspectateteam(var_30, 1);
  }

  thread endedkillcamcleanup();
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  if(self.archivetime < var_26) {}

  var_17 = self.archivetime - 0.05 - var_5;
  var_19 = var_17 + var_18;
  self.killcamlength = var_19;

  if(var_17 <= 0) {
    maps\mp\_utility::updatesessionstate("dead");
    maps\mp\_utility::clearkillcamstate();
    self notify("killcam_ended");
    return;
  }

  self setclientomnvar("ui_killcam_end_milliseconds", int(var_19 * 1000) + gettime());

  if(level.showingfinalkillcam) {
    thread dofinalkillcamfx(var_17, var_2);
  }

  self.killcam = 1;

  if(isDefined(self.battlebuddy) && !level.gameended) {
    self.battlebuddyrespawntimestamp = gettime();
  }

  thread spawnedkillcamcleanup();
  self.skippedkillcam = 0;
  self.killcamstartedtimedeciseconds = maps\mp\_utility::gettimepasseddecisecondsincludingrounds();

  if(!level.showingfinalkillcam) {
    thread waitskipkillcambutton(var_7);
  } else {
    self notify("showing_final_killcam");
  }

  thread endkillcamifnothingtoshow();
  waittillkillcamover();

  if(level.showingfinalkillcam) {
    if(self == var_9) {
      var_9 maps\mp\gametypes\_missions::processchallenge("ch_precision_moviestar");
    }

    thread maps\mp\gametypes\_playerlogic::spawnendofgame();
    return;
  }

  thread killcamcleanup(1);
}

dofinalkillcamfx(var_0, var_1) {
  if(isDefined(level.doingfinalkillcamfx)) {
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

    if(var_2 > var_3) {
      wait((var_2 - var_3) / 1000);
    }
  }

  self.killcamentity = var_0;
}

waitskipkillcambutton(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");

  while(self useButtonPressed()) {
    wait 0.05;
  }

  while(!self useButtonPressed()) {
    wait 0.05;
  }

  self.skippedkillcam = 1;

  if(isDefined(self.pers["totalKillcamsSkipped"])) {
    self.pers["totalKillcamsSkipped"]++;
  }

  if(var_0 <= 0) {
    maps\mp\_utility::clearlowermessage("kc_info");
  }

  self notify("abort_killcam");
}

waitcopycatkillcambutton(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");
  self notifyonplayercommand("KillCamCopyCat", "weapnext");
  self waittill("KillCamCopyCat");
  self setclientomnvar("ui_killcam_copycat", 0);
  self playSound("copycat_steal_class");
  maps\mp\gametypes\_class::setcopycatloadout(var_0);
}

endkillcamifnothingtoshow() {
  self endon("disconnect");
  self endon("killcam_ended");

  for(;;) {
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
  setcinematiccamerastyle("unknown", -1, -1);
  self.killcam = undefined;

  if(isDefined(self.killcamstartedtimedeciseconds) && isPlayer(self) && maps\mp\_matchdata::canloglife(self.lifeid)) {
    var_1 = maps\mp\_utility::gettimepasseddecisecondsincludingrounds();
    setmatchdata("lives", self.lifeid, "killcamWatchTimeDeciSeconds", maps\mp\_utility::clamptobyte(var_1 - self.killcamstartedtimedeciseconds));
  }

  if(!level.gameended) {
    maps\mp\_utility::clearlowermessage("kc_info");
  }

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
  return self useButtonPressed();
}

cancelkillcamsafespawnbutton() {
  return self fragButtonPressed();
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

  for(;;) {
    if(!self[[var_0]]()) {
      wait 0.05;
      continue;
    }

    var_2 = 0;

    while(self[[var_0]]()) {
      var_2 = var_2 + 0.05;
      wait 0.05;
    }

    if(var_2 >= 0.5) {
      continue;
    }
    var_2 = 0;

    while(!self[[var_0]]() && var_2 < 0.5) {
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