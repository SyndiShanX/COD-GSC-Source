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

  foreach(var1 in level.players) {
    var1.radarmode = "normal_radar";
  }

  var3 = getuavstrengthlevelneutral();
  scripts\cp_mp\killstreaks\uav::_setteamradarstrength("allies", var3 + 1);
  setteamradar("allies", 1);
}

function spawn_bomb() {
  var0 = getDvar("MOLPOSLOMO");

  if(var0 == "cp_survival") {
    scripts\cp\utility::hideminimap(1);
    return;
  }
}

function ref_131b6() {
  self.radarmode = "normal_radar";
}

function remoteuav_processtaggedassist(var0) {}

function setup_radio_tower_uavs(var0, var1, var2) {
  var3 = var1 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("uav", var1);
  var4 = "allies";
  var1 notify("used_uav");

  if(level.teambased) {
    var5 = scripts\cp_mp\killstreaks\uav::_getradarstrength(var4);
  }

  level notify("uav_update");
  var6 = "uav";
  var7 = scripts\cp_mp\killstreaks\uav::getuavrig(var6);
  var7.origin = var0;
  var8 = spawn("script_model", var7 gettagorigin("tag_origin") + (0, 0, 5000));
  var9 = level.uavsettings[var6].modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var1) && isDefined(level.uavsettings[var6].modelbasealt)) {
    var9 = level.uavsettings[var6].modelbasealt;
  }

  var8 setModel(var9);
  var8.team = var4;
  var8.owner = var1;
  var8.timetoadd = 0;
  var8.uavtype = var6;
  var8.health = level.uavsettings[var6].health;
  var8.maxhealth = level.uavsettings[var6].maxhealth;
  var8.streakinfo = var3;
  var8 setotherent(var1);
  var8 scriptmoveroutline();
  var8 scriptmoverthermal();
  var8 thread scripts\cp_mp\killstreaks\uav::damagetracker();
  var8 thread scripts\cp_mp\killstreaks\uav::handleincomingstinger();
  var8 thread scripts\cp_mp\killstreaks\uav::perkengineer_manageminimap();
  var8 thread scripts\cp_mp\killstreaks\uav::monitorowner();
  var8 thread scripts\cp_mp\killstreaks\uav::restorestrengthafterhostmigration();
  var8 thread scripts\cp_mp\killstreaks\uav::trackvelocity();
  var8 setscriptablepartstate("lights", "on", 0);
  var10 = randomintrange(5250, 5500);

  if(isDefined(level.spawnpoints)) {
    var11 = level.spawnpoints;
  } else {
    var11 = level.startspawnpoints;
  }

  if(!isDefined(var11)) {
    var12 = spawnStruct();
    var12.origin = (var2.origin[0], var2.origin[1], 6969);
    var11 = [var12];
  }

  var13 = var11[0];

  foreach(var12 in var11) {
    if(var12.origin[2] < var13.origin[2]) {
      var13 = var12;
    }
  }

  var16 = var13.origin[2];
  var17 = var8.origin[2];

  if(var16 < 0) {
    var17 += var16 * -1;
    var16 = 0;
  }

  var18 = var17 - var16;

  if(var18 + var11 > 8100) {
    var11 -= var18 + var11 - 8100;
  }

  var19 = randomint(360);
  var20 = randomint(1000) + 4000;
  var21 = cos(var19) * var20;
  var22 = sin(var19) * var20;
  var23 = vectorNormalize((var21, var22, var11));
  var23 *= var11;
  var9 linkTo(var8, "tag_origin", var23, (0, var19 - 90, 0));
  var9 thread scripts\cp_mp\killstreaks\uav::updateuavmodelvisibility();
  var9[[level.uavsettings[var7].addfunc]]();
  var3.uav = var9;

  if(var7 == "uav" || var7 == "directional_uav") {
    var9 scripts\cp_mp\killstreaks\uav::revealminimapforteam(1);
    var9 thread scripts\cp_mp\killstreaks\uav::applymapenableonspawn();
  }

  var9 scripts\cp_mp\killstreaks\uav::adduavmodel();

  if(isDefined(level.activeuavs[var6])) {
    foreach(var25 in level.uavmodels[var6]) {
      if(var25 == var9) {
        continue;
      }

      if(isDefined(var25.timetoadd)) {
        var25.timetoadd += 5;
      }
    }
  }

  var9 thread scripts\cp_mp\killstreaks\uav::handlewiretap();
  level notify("uav_update");
  var27 = level.uavsettings["uav"].timeout;
  var9 scripts\engine\utility::ref_143ba(var27, "death", "uav_disabled");

  if(var9.damagetaken < var9.maxhealth) {
    var9 unlink();
    var28 = var9.origin + anglesToForward(var9.angles) * 20000;
    var9 moveTo(var28, 60);

    if(isDefined(level.uavsettings[var7].fxid_leave) && isDefined(level.uavsettings[var7].fx_leave_tag)) {
      playFXOnTag(level.uavsettings[var7].fxid_leave, var9, level.uavsettings[var7].fx_leave_tag);
    }

    if(var9.damagetaken < var9.maxhealth) {
      var9 notify("leaving");
      var9.isleaving = 1;
      var9 moveTo(var28, 4, 4, 0);
    }
  }

  var9 scripts\cp_mp\killstreaks\uav::removeuavmodel();

  if(var7 == "uav" || var7 == "directional_uav") {
    var9 scripts\cp_mp\killstreaks\uav::revealminimapforteam(level.minimaponbydefault);
  }

  var9[[level.uavsettings[var7].removefunc]]();
  var3.uav = undefined;

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var4);
  }

  if(isDefined(var9.enemyobjid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var9.enemyobjid);
    var9 notify("uav_deleteObjective");
  }

  if(isDefined(var9)) {
    var9 delete();
  }

  if(var7 == "directional_uav") {
    var2.radarshowenemydirection = 0;

    if(level.teambased) {
      foreach(var30 in level.players) {
        if(isDefined(var30) && var30.pers["team"] == var6) {
          var30.radarshowenemydirection = 0;
        }
      }
    }
  }

  level notify("uav_update");
}