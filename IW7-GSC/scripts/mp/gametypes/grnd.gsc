/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\grnd.gsc
*****************************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    scripts\mp\utility::registertimelimitdvar(level.gametype, 10);
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 7500);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::scripts\mp\gametypes\koth::getspawnpoint;
  level.onplayerkilled = ::scripts\mp\gametypes\koth::onplayerkilled;
  level.onrespawndelay = ::scripts\mp\gametypes\koth::getrespawndelay;
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "dropzone";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("camera_thirdPerson")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_" + level.gametype + "_promode")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "capture_obj";
  game["dialog"]["defense_obj"] = "capture_obj";
  thread scripts\mp\gametypes\koth::onplayerconnect();
  level.dangermaxradius["drop_zone"] = 1200;
  level.dangerminradius["drop_zone"] = 1190;
  level.dangerforwardpush["drop_zone"] = 0;
  level.dangerovalscale["drop_zone"] = 1;
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_grnd_dropTime", getmatchrulesdata("grndData", "dropTime"));
  setdynamicdvar("scr_grnd_enableVariantDZ", getmatchrulesdata("grndData", "enableVariantDZ"));
  setdynamicdvar("scr_grnd_zoneLifetime", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar("scr_grnd_zoneCaptureTime", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar("scr_grnd_zoneActivationDelay", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar("scr_grnd_randomLocationOrder", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar("scr_grnd_additiveScoring", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar("scr_grnd_pauseTime", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("scr_grnd_delayPlayer", getmatchrulesdata("kothData", "delayPlayer"));
  setdynamicdvar("scr_grnd_useHQRules", getmatchrulesdata("kothData", "useHQRules"));
  setdynamicdvar("scr_grnd_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("grnd", 0);
  setdynamicdvar("scr_grnd_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  scripts\mp\utility::setobjectivetext("allies", & "OBJECTIVES_GRND");
  scripts\mp\utility::setobjectivetext("axis", & "OBJECTIVES_GRND");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", & "OBJECTIVES_GRND");
    scripts\mp\utility::setobjectivescoretext("axis", & "OBJECTIVES_GRND");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", & "OBJECTIVES_GRND_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", & "OBJECTIVES_GRND_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", & "OBJECTIVES_DOM_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", & "OBJECTIVES_DOM_HINT");
  var_00[0] = level.gametype;
  var_00[1] = "tdm";
  var_00[2] = "hardpoint";
  scripts\mp\gameobjects::main(var_00);
  level thread scripts\mp\gametypes\koth::setupzones();
  level thread scripts\mp\gametypes\koth::setupzoneareabrushes();
  scripts\mp\gametypes\koth::initspawns();
  level thread scripts\mp\gametypes\koth::hardpointmainloop();
  if(level.droptime > 0) {
    level thread randomdrops();
  }
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.droptime = scripts\mp\utility::dvarfloatvalue("dropTime", 15, 0, 60);
  level.zoneduration = scripts\mp\utility::dvarfloatvalue("zoneLifetime", 60, 0, 300);
  level.zonecapturetime = scripts\mp\utility::dvarfloatvalue("zoneCaptureTime", 0, 0, 30);
  level.zoneactivationdelay = scripts\mp\utility::dvarfloatvalue("zoneActivationDelay", 0, 0, 60);
  level.zonerandomlocationorder = scripts\mp\utility::dvarintvalue("randomLocationOrder", 0, 0, 1);
  level.zoneadditivescoring = scripts\mp\utility::dvarintvalue("additiveScoring", 0, 0, 1);
  level.pausemodetimer = scripts\mp\utility::dvarintvalue("pauseTime", 1, 0, 1);
  level.delayplayer = scripts\mp\utility::dvarintvalue("delayPlayer", 0, 0, 1);
  level.usehqrules = scripts\mp\utility::dvarintvalue("useHQRules", 0, 0, 1);
  level.enablevariantdrops = scripts\mp\utility::dvarintvalue("enableVariantDZ", 0, 0, 1);
}

randomdrops() {
  level endon("game_ended");
  scripts\mp\utility::gameflagwait("prematch_done");
  level.grnd_previouscratetypes = [];
  for(;;) {
    var_00 = getbestplayer();
    var_01 = 1;
    if(isDefined(var_00) && scripts\mp\utility::currentactivevehiclecount() < scripts\mp\utility::maxvehiclesallowed() && level.fauxvehiclecount + var_01 < scripts\mp\utility::maxvehiclesallowed() && level.numdropcrates < 8) {
      scripts\mp\utility::playsoundonplayers("mp_dropzone_obj_taken", var_00.team);
      scripts\mp\utility::playsoundonplayers("mp_dropzone_obj_lost", level.otherteam[var_00.team]);
      var_02 = getnodesintrigger(level.zone.gameobject.trigger);
      var_03 = randomintrange(0, var_02.size);
      var_04 = var_02[var_03];
      var_05 = getclosestpointonnavmesh3d(var_04.origin);
      var_06 = var_04.origin;
      var_07 = var_05;
      var_08 = scripts\common\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
      var_09 = [];
      var_0A = scripts\common\trace::ray_trace(var_06, var_07, var_09, var_08);
      var_04.droporigin = var_0A["position"];
      var_0B = getdropzonecratetype();
      level scripts\mp\killstreaks\_airdrop::func_581F(var_00, var_04, randomfloat(360), "dronedrop_grnd");
      var_0C = level.droptime;
    } else {
      var_0C = 0.5;
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0C);
  }
}

getbestplayer() {
  var_00 = undefined;
  var_01 = 0;
  var_02 = level.zone.gameobject scripts\mp\gameobjects::getownerteam();
  if(var_02 == "neutral") {
    return var_00;
  }

  foreach(var_04 in level.zone.gameobject.touchlist[var_02]) {
    if(var_01 == 0 || var_01 > var_04.starttime) {
      var_01 = var_04.starttime;
      var_00 = var_04.player;
    }
  }

  return var_00;
}

getdropzonecratetype() {
  var_00 = undefined;
  if(!isDefined(level.grnd_previouscratetypes["mega"]) && level.numdropcrates == 0 && randomintrange(0, 100) < 5) {
    var_00 = "mega";
  } else {
    if(level.grnd_previouscratetypes.size) {
      for(var_01 = 200; var_01; var_01--) {
        var_00 = scripts\mp\killstreaks\_airdrop::getrandomcratetype("dronedrop_grnd");
        if(isDefined(level.grnd_previouscratetypes[var_00])) {
          var_00 = undefined;
          continue;
        }

        break;
      }
    }

    if(!isDefined(var_00)) {
      var_00 = scripts\mp\killstreaks\_airdrop::getrandomcratetype("dronedrop_grnd");
    }
  }

  level.grnd_previouscratetypes[var_00] = 1;
  if(level.grnd_previouscratetypes.size == 15) {
    level.grnd_previouscratetypes = [];
  }

  return var_00;
}