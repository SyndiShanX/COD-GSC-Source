/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\uav_cp.gsc
***********************************************/

function init_uav_cp() {
  level.radarviewtime = 43;
  level.advradarviewtime = 28;
  level.uavblocktime = 23;
  level.uavsettings = [];
  level.uavsettings["uav"] = spawnStruct();
  level.uavsettings["uav"].timeout = level.radarviewtime;
  level.uavsettings["uav"].health = 999999;
  level.uavsettings["uav"].maxhealth = 800;
  level.uavsettings["uav"].streakname = "uav";
  level.uavsettings["uav"].modelbase = "veh8_mil_air_mquebec9_small";
  level.uavsettings["uav"].modelbasealt = "veh8_mil_air_mquebec9_small_east";
  level.uavsettings["uav"].fxid_explode = loadfx("vfx/iw8_mp/killstreak/vfx_uav_death.vfx");
  level.uavsettings["uav"].fx_leave_tag = "tag_origin";
  level.uavsettings["uav"].fxid_contrail = undefined;
  level.uavsettings["uav"].fx_contrail_tag = undefined;
  level.uavsettings["uav"].sound_explode = "mp_uav_explo_dist";
  level.uavsettings["uav"].teamsplash = "used_uav";
  level.uavsettings["uav"].votimeout = "uav_timeout";
  level.uavsettings["uav"].calloutdestroyed = "callout_destroyed_uav";
  level.uavsettings["uav"].addfunc = &scripts\cp_mp\killstreaks\uav::addactiveuav;
  level.uavsettings["uav"].removefunc = &scripts\cp_mp\killstreaks\uav::removeactiveuav;
  level.uavsettings["directional_uav"] = spawnStruct();
  level.uavsettings["directional_uav"].timeout = level.advradarviewtime;
  level.uavsettings["directional_uav"].health = 999999;
  level.uavsettings["directional_uav"].maxhealth = 2000;
  level.uavsettings["directional_uav"].streakname = "directional_uav";
  level.uavsettings["directional_uav"].modelbase = "veh8_mil_air_auniform";
  level.uavsettings["directional_uav"].modelbasealt = "veh8_mil_air_auniform_east";
  level.uavsettings["directional_uav"].fxid_explode = loadfx("vfx/iw8_mp/killstreak/vfx_auav_death.vfx");
  level.uavsettings["directional_uav"].fx_leave_tag = "tag_origin";
  level.uavsettings["directional_uav"].fxid_contrail = undefined;
  level.uavsettings["directional_uav"].fx_contrail_tag = "tag_jet_trail";
  level.uavsettings["directional_uav"].sound_explode = "mp_uav_explo_dist";
  level.uavsettings["directional_uav"].votimeout = "directional_uav_timeout";
  level.uavsettings["directional_uav"].teamsplash = "used_directional_uav";
  level.uavsettings["directional_uav"].calloutdestroyed = "callout_destroyed_directional_uav";
  level.uavsettings["directional_uav"].addfunc = &scripts\cp_mp\killstreaks\uav::addactiveuav;
  level.uavsettings["directional_uav"].removefunc = &scripts\cp_mp\killstreaks\uav::removeactiveuav;
  level.minimaponbydefault = getdvarint("scr_game_enableMinimap") != 0 || getdvarint("scr_showDefaultMinimap") != 0;
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&scripts\cp_mp\killstreaks\uav::onplayerspawned);
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&spawn_bomb);
  scripts\cp_mp\utility\script_utility::registersharedfunc("uav", "remoteUAV_processTaggedAssist", &remoteuav_processtaggedassist);
}

function scriptable_adddamagedcallback() {
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&ref_131b6);

  foreach(var_1 in level.players) {
    var_1.radarmode = "normal_radar";
  }

  var_3 = getuavstrengthlevelneutral();
  scripts\cp_mp\killstreaks\uav::_setteamradarstrength("allies", var_3 + 1);
  setteamradar("allies", 1);
}

function spawn_bomb() {
  var_0 = getDvar("MOLPOSLOMO");

  if(var_0 == "cp_survival") {
    scripts\cp\utility::hideminimap(1);
    return;
  }
}

function ref_131b6() {
  self.radarmode = "normal_radar";
}

function remoteuav_processtaggedassist(var_0) {}

function setup_radio_tower_uavs(var_0, var_1, var_2) {
  var_3 = var_1 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("uav", var_1);
  var_4 = "allies";
  var_1 notify("used_uav");

  if(level.teambased) {
    var_5 = scripts\cp_mp\killstreaks\uav::_getradarstrength(var_4);
  }

  level notify("uav_update");
  var_6 = "uav";
  var_7 = scripts\cp_mp\killstreaks\uav::getuavrig(var_6);
  var_7.origin = var_0;
  var_8 = spawn("script_model", var_7 gettagorigin("tag_origin") + (0, 0, 5000));
  var_9 = level.uavsettings[var_6].modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_1) && isDefined(level.uavsettings[var_6].modelbasealt)) {
    var_9 = level.uavsettings[var_6].modelbasealt;
  }

  var_8 setModel(var_9);
  var_8.team = var_4;
  var_8.owner = var_1;
  var_8.timetoadd = 0;
  var_8.uavtype = var_6;
  var_8.health = level.uavsettings[var_6].health;
  var_8.maxhealth = level.uavsettings[var_6].maxhealth;
  var_8.streakinfo = var_3;
  var_8 setotherent(var_1);
  var_8 scriptmoveroutline();
  var_8 scriptmoverthermal();
  var_8 thread scripts\cp_mp\killstreaks\uav::damagetracker();
  var_8 thread scripts\cp_mp\killstreaks\uav::handleincomingstinger();
  var_8 thread scripts\cp_mp\killstreaks\uav::perkengineer_manageminimap();
  var_8 thread scripts\cp_mp\killstreaks\uav::monitorowner();
  var_8 thread scripts\cp_mp\killstreaks\uav::restorestrengthafterhostmigration();
  var_8 thread scripts\cp_mp\killstreaks\uav::trackvelocity();
  var_8 setscriptablepartstate("lights", "on", 0);
  var_10 = randomintrange(5250, 5500);

  if(isDefined(level.spawnpoints)) {
    var_11 = level.spawnpoints;
  } else {
    var_11 = level.startspawnpoints;
  }

  if(!isDefined(var_11)) {
    var_12 = spawnStruct();
    var_12.origin = (var_2.origin[0], var_2.origin[1], 6969);
    var_11 = [var_12];
  }

  var_13 = var_11[0];

  foreach(var_12 in var_11) {
    if(var_12.origin[2] < var_13.origin[2]) {
      var_13 = var_12;
    }
  }

  var_16 = var_13.origin[2];
  var_17 = var_8.origin[2];

  if(var_16 < 0) {
    var_17 += var_16 * -1;
    var_16 = 0;
  }

  var_18 = var_17 - var_16;

  if(var_18 + var_11 > 8100) {
    var_11 -= var_18 + var_11 - 8100;
  }

  var_19 = randomint(360);
  var_20 = randomint(1000) + 4000;
  var_21 = cos(var_19) * var_20;
  var_22 = sin(var_19) * var_20;
  var_23 = vectorNormalize((var_21, var_22, var_11));
  var_23 *= var_11;
  var_9 linkTo(var_8, "tag_origin", var_23, (0, var_19 - 90, 0));
  var_9 thread scripts\cp_mp\killstreaks\uav::updateuavmodelvisibility();
  var_9[[level.uavsettings[var_7].addfunc]]();
  var_3.uav = var_9;

  if(var_7 == "uav" || var_7 == "directional_uav") {
    var_9 scripts\cp_mp\killstreaks\uav::revealminimapforteam(1);
    var_9 thread scripts\cp_mp\killstreaks\uav::applymapenableonspawn();
  }

  var_9 scripts\cp_mp\killstreaks\uav::adduavmodel();

  if(isDefined(level.activeuavs[var_6])) {
    foreach(var_25 in level.uavmodels[var_6]) {
      if(var_25 == var_9) {
        continue;
      }

      if(isDefined(var_25.timetoadd)) {
        var_25.timetoadd += 5;
      }
    }
  }

  var_9 thread scripts\cp_mp\killstreaks\uav::handlewiretap();
  level notify("uav_update");
  var_27 = level.uavsettings["uav"].timeout;
  var_9 scripts\engine\utility::ref_143ba(var_27, "death", "uav_disabled");

  if(var_9.damagetaken < var_9.maxhealth) {
    var_9 unlink();
    var_28 = var_9.origin + anglesToForward(var_9.angles) * 20000;
    var_9 moveTo(var_28, 60);

    if(isDefined(level.uavsettings[var_7].fxid_leave) && isDefined(level.uavsettings[var_7].fx_leave_tag)) {
      playFXOnTag(level.uavsettings[var_7].fxid_leave, var_9, level.uavsettings[var_7].fx_leave_tag);
    }

    if(var_9.damagetaken < var_9.maxhealth) {
      var_9 notify("leaving");
      var_9.isleaving = 1;
      var_9 moveTo(var_28, 4, 4, 0);
    }
  }

  var_9 scripts\cp_mp\killstreaks\uav::removeuavmodel();

  if(var_7 == "uav" || var_7 == "directional_uav") {
    var_9 scripts\cp_mp\killstreaks\uav::revealminimapforteam(level.minimaponbydefault);
  }

  var_9[[level.uavsettings[var_7].removefunc]]();
  var_3.uav = undefined;

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var_4);
  }

  if(isDefined(var_9.enemyobjid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_9.enemyobjid);
    var_9 notify("uav_deleteObjective");
  }

  if(isDefined(var_9)) {
    var_9 delete();
  }

  if(var_7 == "directional_uav") {
    var_2.radarshowenemydirection = 0;

    if(level.teambased) {
      foreach(var_30 in level.players) {
        if(isDefined(var_30) && var_30.pers["team"] == var_6) {
          var_30.radarshowenemydirection = 0;
        }
      }
    }
  }

  level notify("uav_update");
}