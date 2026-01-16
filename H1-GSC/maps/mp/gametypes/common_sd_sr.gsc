/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\common_sd_sr.gsc
**********************************************/

onprecachegametype() {
  maps\mp\gametypes\common_bomb_gameobject::onprecachegametype();
}

updategametypedvars() {
  level.planttime = maps\mp\_utility::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime", 5, 0, 20);
  level.bombtimer = maps\mp\_utility::dvarfloatvalue("bombtimer", 45, 1, 300);
  level.multibomb = maps\mp\_utility::dvarintvalue("multibomb", 0, 0, 1);
  level.silentplant = maps\mp\_utility::dvarintvalue("silentplant", 0, 0, 1);
}

isplayeroutsideofanybombsite(var_0) {
  if(isdefined(level.bombzones)) {
    foreach(var_2 in level.bombzones) {
      if(distancesquared(self.origin, var_2.trigger.origin) < 4096)
        return 0;
    }
  }

  return 1;
}

onnormaldeath(var_0, var_1, var_2) {
  if(game["state"] == "postgame" && (var_0.team == game["defenders"] || !level.bombplanted))
    var_1.finalkill = 1;

  if(var_0.isplanting || var_0.isdefusing) {
    var_1 thread maps\mp\_events::defendobjectiveevent(var_0, var_2);

    if(var_0.isplanting)
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_interrupt");

    if(var_0.isdefusing)
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_protector");
  }

  if(waseliminatedbyenemy(var_0, var_1)) {
    var_3 = islastplayeralive(var_1);
    var_1 thread maps\mp\_events::eliminateplayerevent(var_3, var_0);
  }
}

waseliminatedbyenemy(var_0, var_1) {
  if(maps\mp\gametypes\_damage::isfriendlyfire(var_0, var_1))
    return 0;

  if(var_0 maps\mp\gametypes\_playerlogic::mayspawn())
    return 0;

  return 1;
}

onpickup(var_0) {
  maps\mp\gametypes\common_bomb_gameobject::oncarrybombpickup(var_0, game["attackers"]);

  if(var_0.team == "allies")
    var_0.objective = 1;
  else
    var_0.objective = 2;

  if(isdefined(level.carrierloadouts) && isdefined(level.carrierloadouts[var_0.team])) {
    var_0.isrespawningwithbombcarrierclass = 1;
    var_0 thread maps\mp\_utility::applycarrierclass();
  }

  if(!level.bombdefused) {
    maps\mp\_utility::teamplayercardsplash("callout_bombtaken", var_0, var_0.team);
    maps\mp\_utility::leaderdialog("bomb_taken", var_0.pers["team"]);
  }
}

bombs() {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  var_0 = getent("sd_bomb_pickup_trig", "targetname");

  if(!isdefined(var_0)) {
    common_scripts\utility::error("No sd_bomb_pickup_trig trigger found in map.");
    return;
  }

  var_1 = maps\mp\gametypes\common_bomb_gameobject::getcarrybombvisuals("sd_bomb");

  if(!isdefined(var_1)) {
    common_scripts\utility::error("No sd_bomb script_model found in map.");
    return;
  }

  if(!level.multibomb) {
    level.sdbomb = maps\mp\gametypes\common_bomb_gameobject::createbombcarryobject(game["attackers"], "friendly", var_0, var_1);
    thread maps\mp\_utility::streamcarrierweaponstoplayers(level.sdbomb, [game["attackers"]], ::shouldstreamcarrierclasstoplayer);

    if(game["attackers"] == "allies")
      maps\mp\_utility::setmlgicons(level.sdbomb, "waypoint_bomb_green");
    else
      maps\mp\_utility::setmlgicons(level.sdbomb, "waypoint_bomb_red");

    level.sdbomb.onpickup = ::onpickup;
    level.sdbomb.ondrop = ::ondrop;
  } else {
    var_0 delete();
    var_1[0] delete();
  }

  level.bombzones = [];
  var_2 = getentarray("bombzone", "targetname");
  var_3 = getentarray("bombzone_augmented", "targetname");

  if(maps\mp\_utility::isaugmentedgamemode()) {
    for (var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = var_3[var_4].script_label;

      for (var_6 = 0; var_6 < var_2.size; var_6++) {
        if(var_2[var_6].script_label == var_5) {
          removebombzone(var_2[var_6]);
          break;
        }
      }
    }
  } else {
    for (var_7 = 0; var_7 < var_3.size; var_7++)
      removebombzone(var_3[var_7]);
  }

  var_2 = common_scripts\utility::array_combine(var_2, var_3);

  for (var_7 = 0; var_7 < var_2.size; var_7++) {
    var_0 = var_2[var_7];
    var_1 = getentarray(var_2[var_7].target, "targetname");
    var_8 = undefined;

    if(!level.multibomb)
      var_8 = level.sdbomb;

    var_9 = maps\mp\gametypes\common_bomb_gameobject::createbombzoneobject(game["defenders"], "enemy", "any", var_0, var_8, 1);
    maps\mp\_utility::setmlgicons(var_9, "waypoint_esports_snd_target" + var_9.label + "_white");
    var_9.onbeginuse = ::onbeginuse;
    var_9.onenduse = ::onenduse;
    var_9.onuse = ::onuseplantobject;
    var_9.oncantuse = ::oncantuse;
    level.bombzones[level.bombzones.size] = var_9;
    var_9.bombdefusetrig = getent(var_1[0].target, "targetname");
    var_9.bombdefusetrig.origin = var_9.bombdefusetrig.origin + (0, 0, -10000);
    var_9.bombdefusetrig.label = var_9.label;
    var_9.bombdefusetrig usetriggertouchcheckstance(1);
  }

  for (var_7 = 0; var_7 < level.bombzones.size; var_7++) {
    var_10 = [];

    for (var_11 = 0; var_11 < level.bombzones.size; var_11++) {
      if(var_11 != var_7)
        var_10[var_10.size] = level.bombzones[var_11];
    }

    level.bombzones[var_7].otherbombzones = var_10;
  }

  setomnvar("ui_mlg_game_mode_status_1", 0);
}

shouldstreamcarrierclasstoplayer(var_0, var_1) {
  if(level.bombplanted)
    return 0;

  if(isdefined(var_0.carrier) && var_0.carrier == var_1)
    return 0;

  return 1;
}

removebombzone(var_0) {
  var_1 = getentarray("script_brushmodel", "classname");

  foreach(var_3 in var_1) {
    if(!isdefined(var_3.script_gameobjectname) || var_3.script_gameobjectname != "bombzone") {
      continue;
    }
    if(!isdefined(var_3.script_label)) {
      continue;
    }
    if(issubstr(var_3.script_label, var_0.script_label) && issubstr(var_3.script_label, var_0.targetname))
      var_3 delete();
  }

  var_5 = getentarray(var_0.target, "targetname");

  foreach(var_7 in var_5) {
    if(isdefined(var_7.target)) {
      var_8 = getentarray(var_7.target, "targetname");

      foreach(var_10 in var_8)
      var_10 delete();
    }

    var_7 delete();
  }

  var_0 delete();
}

onuseplantobject(var_0) {
  if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(var_0.pers["team"])) {
    level thread bombplanted(self, var_0);

    for (var_1 = 0; var_1 < level.bombzones.size; var_1++) {
      if(level.bombzones[var_1] == self) {
        var_2 = level.bombzones[var_1] maps\mp\gametypes\_gameobjects::getlabel();
        maps\mp\_utility::setmlgicons(level.bombzones[var_1], "waypoint_esports_snd_planted" + var_2);
        continue;
      }

      level.bombzones[var_1] maps\mp\gametypes\_gameobjects::disableobject();
      maps\mp\_utility::setmlgicons(level.bombzones[var_1], undefined);
    }

    var_0 maps\mp\gametypes\common_bomb_gameobject::onplayerplantbomb(1, game["attackers"], game["defenders"]);

    if(isdefined(level.carrierloadouts) && isdefined(level.carrierloadouts[var_0.team])) {
      var_0 thread maps\mp\_utility::removecarrierclass();
      return;
    }
  } else
    self.bombplantedon = 0;
}

onbeginuse(var_0) {
  if(maps\mp\gametypes\_gameobjects::isfriendlyteam(var_0.pers["team"]))
    maps\mp\gametypes\common_bomb_gameobject::onbegindefusebomb(var_0, level.sdbombmodel);
  else {
    maps\mp\gametypes\common_bomb_gameobject::onbeginplantbomb(var_0);

    if(level.multibomb) {
      for (var_1 = 0; var_1 < self.otherbombzones.size; var_1++) {
        self.otherbombzones[var_1] maps\mp\gametypes\_gameobjects::allowuse("none");
        self.otherbombzones[var_1] maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");
      }
    }
  }
}

onenduse(var_0, var_1, var_2) {
  if(var_1.isplanting && level.multibomb && !var_2) {
    for (var_3 = 0; var_3 < self.otherbombzones.size; var_3++) {
      self.otherbombzones[var_3] maps\mp\gametypes\_gameobjects::allowuse("enemy");
      self.otherbombzones[var_3] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
    }
  }

  var_4 = isdefined(var_1) && var_1.isdefusing && !var_2;
  maps\mp\gametypes\common_bomb_gameobject::onendusebomb(var_1, var_4);
}

bombplantedanim(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 playerlinkto(level.sdbombmodel);
  var_0 playerlinkedoffsetenable();

  while (var_0 getcurrentweapon() == self.useweapon)
    waitframe();

  var_0 unlink();
}

bombplanted(var_0, var_1) {
  level.bombplanted = 1;
  var_1.objective = 0;
  level.defuseendtime = int(gettime() + level.bombtimer * 1000);
  setgameendtime(level.defuseendtime);
  setomnvar("ui_bomb_timer", 1);

  if(!level.multibomb) {
    level.sdbomb maps\mp\gametypes\_gameobjects::allowcarry("none");
    level.sdbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
    maps\mp\_utility::setmlgicons(level.sdbomb, undefined);
    level.sdbomb maps\mp\gametypes\_gameobjects::setdropped();
    level.sdbombmodel = level.sdbomb.visuals[0];
  } else {
    level.sdbombmodel = spawn("script_model", var_1.origin);
    level.sdbombmodel.angles = var_1.angles;
    level.sdbombmodel setmodel("wpn_h1_briefcase_bomb_npc");
  }

  var_0 maps\mp\gametypes\common_bomb_gameobject::onbombplanted(level.sdbombmodel.origin + (0, 0, 1));
  var_0 maps\mp\gametypes\_gameobjects::allowuse("none");
  var_0 maps\mp\gametypes\_gameobjects::setvisibleteam("none");
  var_2 = var_0 maps\mp\gametypes\_gameobjects::getlabel();
  var_3 = var_0.bombdefusetrig;
  var_3.origin = level.sdbombmodel.origin;
  var_4 = [];
  var_5 = maps\mp\gametypes\_gameobjects::createuseobject(game["defenders"], var_3, var_4, (0, 0, 32));
  var_5.label = var_2;
  var_5 maps\mp\gametypes\common_bomb_gameobject::setupzonefordefusing(1);
  var_5.onbeginuse = ::onbeginuse;
  var_5.onenduse = ::onenduse;
  var_5.onuse = ::onusedefuseobject;
  var_5.nousebar = 1;
  var_5.id = "defuseObject";

  if(var_2 == "_a" || var_2 == "_A")
    setomnvar("ui_mlg_game_mode_status_1", 1);
  else if(var_2 == "_b" || var_2 == "_B")
    setomnvar("ui_mlg_game_mode_status_1", 2);

  bombtimerwait(var_5 isbombsiteb());
  setomnvar("ui_bomb_timer", 0);
  setbombendtime(0, var_5 isbombsiteb());
  var_0.tickingobject maps\mp\gametypes\common_bomb_gameobject::stoptickingsound();

  if(level.gameended || level.bombdefused) {
    return;
  }
  level.bombexploded = 1;
  setomnvar("ui_mlg_game_mode_status_1", 0);
  var_6 = level.sdbombmodel.origin;
  var_6 = var_6 + (0, 0, 10);
  level.sdbombmodel hide();
  var_0 maps\mp\gametypes\common_bomb_gameobject::onbombexploded(var_6, 300, var_1);

  for (var_7 = 0; var_7 < level.bombzones.size; var_7++)
    level.bombzones[var_7] maps\mp\gametypes\_gameobjects::disableobject();

  var_5 maps\mp\gametypes\_gameobjects::disableobject();
  setgameendtime(0);
  wait 3;
  sd_endgame(game["attackers"], game["end_reason"]["target_destroyed"]);
}

isbombsiteb() {
  return self.label == "_b" || self.label == "_B";
}

setbombendtime(var_0, var_1) {
  if(var_1)
    setomnvar("ui_bomb_timer_endtime_2", var_0);
  else
    setomnvar("ui_bomb_timer_endtime", var_0);
}

bombtimerwait(var_0) {
  level endon("game_ended");
  level endon("bomb_defused");
  var_1 = int(level.bombtimer * 1000 + gettime());
  setbombendtime(var_1, var_0);
  level thread handlehostmigration(var_1, var_0);
  maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

handlehostmigration(var_0, var_1) {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  setbombendtime(0, var_1);
  var_2 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

  if(var_2 > 0)
    setbombendtime(var_0 + var_2, var_1);
}

ondrop(var_0) {
  maps\mp\gametypes\common_bomb_gameobject::oncarrybombdrop(game["attackers"], game["defenders"]);
}

onusedefuseobject(var_0) {
  var_0 maps\mp\gametypes\common_bomb_gameobject::onplayerdefusebomb(getdefusetype(var_0), game["defenders"], game["attackers"]);
  thread bombdefused(isbombsiteb());
}

getdefusetype(var_0) {
  var_1 = "defuse";

  if(isdefined(level.bombowner) && maps\mp\_utility::isreallyalive(level.bombowner))
    var_1 = "ninja_defuse";

  if(islastplayeralive(var_0))
    var_1 = "last_man_defuse";

  return var_1;
}

islastplayeralive(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }
    if(var_2 maps\mp\gametypes\_playerlogic::mayspawn())
      return 0;

    if(maps\mp\_utility::isreallyalive(var_2))
      return 0;
  }

  return 1;
}

bombdefused(var_0) {
  maps\mp\gametypes\_gameobjects::disableobject();
  level.bombdefused = 1;
  setbombendtime(0, var_0);
  setomnvar("ui_bomb_timer", 0);
  setomnvar("ui_mlg_game_mode_status_1", 0);
  level notify("bomb_defused");
  wait 1.5;
  setgameendtime(0);
  sd_endgame(game["defenders"], game["end_reason"]["bomb_defused"]);
}

oncantuse(var_0) {
  var_0 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

ontimelimit() {
  sd_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
}

sd_endgame(var_0, var_1) {
  level.finalkillcam_winner = var_0;

  if(var_0 == game["attackers"]) {
    if(!isdefined(game["attackerWinCount"]))
      game["attackerWinCount"] = 0;

    game["attackerWinCount"]++;
  } else if(var_0 == game["defenders"]) {
    if(!isdefined(game["defenderWinCount"]))
      game["defenderWinCount"] = 0;

    game["defenderWinCount"]++;
  }

  if(var_1 == game["end_reason"]["target_destroyed"] || var_1 == game["end_reason"]["bomb_defused"]) {
    var_2 = 1;

    foreach(var_4 in level.bombzones) {
      if(isdefined(level.finalkillcam_killcamentityindex[var_0]) && level.finalkillcam_killcamentityindex[var_0] == var_4.killcamentnum) {
        var_2 = 0;
        break;
      }
    }

    if(var_2)
      maps\mp\gametypes\_damage::erasefinalkillcam();
  }

  maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_0, 1);
  thread maps\mp\gametypes\_gamelogic::endgame(var_0, var_1);
}

checkallowspectating() {
  wait 0.05;
  var_0 = 0;

  if(!level.alivecount[game["attackers"]]) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(!level.alivecount[game["defenders"]]) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(var_0)
    maps\mp\gametypes\_spectating::updatespectatesettings();
}

onplayerdisconnect() {
  level endon("game_ended");
  self notify("onPlayerDisconnect");
  self endon("onPlayerDisconnect");
  self waittill("disconnect");
  thread checkallowspectating();
}

ondeadevent(var_0) {
  if(level.bombexploded || level.bombdefused) {
    return;
  }
  if(var_0 == "all") {
    if(level.bombplanted)
      sd_endgame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
    else
      sd_endgame(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
  } else if(var_0 == game["attackers"]) {
    if(level.bombplanted) {
      return;
    }
    level thread sd_endgame(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
  } else if(var_0 == game["defenders"])
    level thread sd_endgame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
}

ononeleftevent(var_0) {
  if(level.bombexploded || level.bombdefused) {
    return;
  }
  var_1 = maps\mp\_utility::getlastlivingplayer(var_0);
  var_1 thread givelastonteamwarning();
}

givelastonteamwarning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\_utility::waittillrecoveredhealth(3);
  var_0 = maps\mp\_utility::getotherteam(self.pers["team"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive", self, var_0);
  level notify("last_alive", self);
  maps\mp\gametypes\_missions::lastmansd();
}

onreset() {}