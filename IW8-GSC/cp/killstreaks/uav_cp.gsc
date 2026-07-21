/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\uav_cp.gsc
***********************************************/

init_uav_cp() {
  level.radarviewtime = 43;
  level.advradarviewtime = 28;
  level.uavblocktime = 23;
  level.uavsettings = [];
  level.uavsettings["_encstr_851904B59B34"] = spawnStruct();
  level.uavsettings["_encstr_851904B59B34"].timeout = level.radarviewtime;
  level.uavsettings["_encstr_851904B59B34"].health = 999999;
  level.uavsettings["_encstr_851904B59B34"].maxhealth = 800;
  level.uavsettings["_encstr_851904B59B34"].streakname = "_encstr_851904B59B34";
  level.uavsettings["_encstr_851904B59B34"].modelbase = "_encstr_A7921CD9CA4370F5ADD2C6FAB04B39BEB5B8D55926ACB172F5E66BC26336";
  level.uavsettings["_encstr_851904B59B34"].modelbasealt = "_encstr_813E21B53D4C92E0FFD2B0DE3A872EF1A5810B1BA2F7801B0F6BE801D24B70E8FEFB81";
  level.uavsettings["_encstr_851904B59B34"].fxid_explode = loadfx("_encstr_B14928D9663CBCB4EE0E7DB6835EDAA563B19B3A9CAC2CADE5679987FABA85ECAF19560B3A43B8D9CC87");
  level.uavsettings["_encstr_851904B59B34"].fx_leave_tag = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";
  level.uavsettings["_encstr_851904B59B34"].fxid_contrail = undefined;
  level.uavsettings["_encstr_851904B59B34"].fx_contrail_tag = undefined;
  level.uavsettings["_encstr_851904B59B34"].sound_explode = "_encstr_885A12DA38AF5DC2ECD7B2F0E0B1DEFA192DDC8E";
  level.uavsettings["_encstr_851904B59B34"].teamsplash = "_encstr_8F0A0960FB97193E0F81DC";
  level.uavsettings["_encstr_851904B59B34"].votimeout = "_encstr_BD3B0CE05AD3EFDBFF0DD5D80D53";
  level.uavsettings["_encstr_851904B59B34"].calloutdestroyed = "_encstr_8A4E16D1E6ACA0709B0367297FC3C598777899C9811D70B4";
  level.uavsettings["_encstr_851904B59B34"].addfunc = scripts\cp_mp\killstreaks\uav::addactiveuav;
  level.uavsettings["_encstr_851904B59B34"].removefunc = scripts\cp_mp\killstreaks\uav::removeactiveuav;
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"] = spawnStruct();
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].timeout = level.advradarviewtime;
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].health = 999999;
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].maxhealth = 2000;
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].streakname = "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].modelbase = "_encstr_B21E163B2BA170AF5B2DC6BEB05AE4F50BAEB92D99BD276B";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].modelbasealt = "_encstr_8BE11BAB1F284ACF19E35936693A02B7C6937EE384B84E326EC76003C9";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].fxid_explode = loadfx("_encstr_A1B0294DB4989758FBE27757837A43085419CABD92D04ABABD1B4512A979C51FC3A78943A2108CD8661A79");
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].fx_leave_tag = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].fxid_contrail = undefined;
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].fx_contrail_tag = "_encstr_A3040E412FDAAFE0DDA32E434A81A0C1";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].sound_explode = "_encstr_885A12DA38AF5DC2ECD7B2F0E0B1DEFA192DDC8E";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].votimeout = "_encstr_B1F01868EF3AE9877B6C981046D2B753913B296017CD21A73353";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].teamsplash = "_encstr_991115BA3795467D32A593958D8E2DBD9B85637DEA2CEC";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].calloutdestroyed = "_encstr_A2332277377281C0B5DB2659879B50C6FAFFE3F1371ADB10FD764BF02D7E20719157632D";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].addfunc = scripts\cp_mp\killstreaks\uav::addactiveuav;
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].removefunc = scripts\cp_mp\killstreaks\uav::removeactiveuav;
  level.minimaponbydefault = getdvarint("_encstr_8C851703DE2317BFA33002B968E576AB98B5B581E0E807C669") != 0 || getdvarint("_encstr_9195174B1146FF5AC84FEFE46380E61FE16B2092D8938F16E0") != 0;
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp_mp\killstreaks\uav::onplayerspawned);
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::spawn_bomb);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_851904B59B34", "_encstr_924B1EBBB0434D43212DC12EC06B939587181323A133075719ADC903EE10EF1B", ::remoteuav_processtaggedassist);
}

scriptable_adddamagedcallback() {
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_131B6);

  foreach(var_1 in level.players)
  var_1.radarmode = "_encstr_A7C90DB83D45714FA1E16D79C58F12";

  var_3 = getuavstrengthlevelneutral();
  scripts\cp_mp\killstreaks\uav::_setteamradarstrength("_encstr_9A8507BA4040188D08", var_3 + 1);
  setteamradar("_encstr_9A8507BA4040188D08", 1);
}

spawn_bomb() {
  var_0 = getDvar("_encstr_ADE50BEB2F7C519F9918E82B68");

  if(var_0 == "_encstr_839E0CBFD1801B5DB0D34C932998")
    scripts\cp\utility::hideminimap(1);
}

_id_131B6() {
  self.radarmode = "_encstr_A7C90DB83D45714FA1E16D79C58F12";
}

remoteuav_processtaggedassist(var_0) {}

setup_radio_tower_uavs(var_0, var_1, var_2) {
  var_3 = var_1 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_851904B59B34", var_1);
  var_4 = "_encstr_9A8507BA4040188D08";
  var_1 notify("_encstr_8F0A0960FB97193E0F81DC");

  if(level.teambased)
    var_5 = scripts\cp_mp\killstreaks\uav::_getradarstrength(var_4);

  level notify("_encstr_8B540B6DB903360BFAAAF85852");
  var_6 = "_encstr_851904B59B34";
  var_7 = scripts\cp_mp\killstreaks\uav::getuavrig(var_6);
  var_7.origin = var_0;
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37") + (0, 0, 5000));
  var_9 = level.uavsettings[var_6].modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_1) && isDefined(level.uavsettings[var_6].modelbasealt))
    var_9 = level.uavsettings[var_6].modelbasealt;

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
  var_8 setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", "_encstr_AB0703DBB9", 0);
  var_10 = randomintrange(5250, 5500);

  if(isDefined(level.spawnpoints))
    var_11 = level.spawnpoints;
  else
    var_11 = level.startspawnpoints;

  if(!isDefined(var_11)) {
    var_12 = spawnStruct();
    var_12.origin = (var_1.origin[0], var_1.origin[1], 6969);
    var_11 = [var_12];
  }

  var_13 = var_11[0];

  foreach(var_12 in var_11) {
    if(var_12.origin[2] < var_13.origin[2])
      var_13 = var_12;
  }

  var_16 = var_13.origin[2];
  var_17 = var_7.origin[2];

  if(var_16 < 0) {
    var_17 = var_17 + var_16 * -1;
    var_16 = 0;
  }

  var_18 = var_17 - var_16;

  if(var_18 + var_10 > 8100.0)
    var_10 = var_10 - (var_18 + var_10 - 8100.0);

  var_19 = randomint(360);
  var_20 = randomint(1000) + 4000;
  var_21 = cos(var_19) * var_20;
  var_22 = sin(var_19) * var_20;
  var_23 = vectorNormalize((var_21, var_22, var_10));
  var_23 = var_23 * var_10;
  var_8 linkTo(var_7, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_23, (0, var_19 - 90, 0));
  var_8 thread scripts\cp_mp\killstreaks\uav::updateuavmodelvisibility();
  var_8[[level.uavsettings[var_6].addfunc]]();
  var_2.uav = var_8;

  if(var_6 == "_encstr_851904B59B34" || var_6 == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950") {
    var_8 scripts\cp_mp\killstreaks\uav::revealminimapforteam(1);
    var_8 thread scripts\cp_mp\killstreaks\uav::applymapenableonspawn();
  }

  var_8 scripts\cp_mp\killstreaks\uav::adduavmodel();

  if(isDefined(level.activeuavs[var_4])) {
    foreach(var_25 in level.uavmodels[var_4]) {
      if(var_25 == var_8) {
        continue;
      }
      if(isDefined(var_25.timetoadd))
        var_25.timetoadd = var_25.timetoadd + 5;
    }
  }

  var_8 thread scripts\cp_mp\killstreaks\uav::handlewiretap();
  level notify("_encstr_8B540B6DB903360BFAAAF85852");
  var_27 = level.uavsettings["_encstr_851904B59B34"].timeout;
  var_8 scripts\engine\utility::_id_143BA(var_27, "_encstr_AD75063D571AE108", "_encstr_8C500DBA58B3BEC82DB92C4C36CAC8");

  if(var_8.damagetaken < var_8.maxhealth) {
    var_8 unlink();
    var_28 = var_8.origin + anglesToForward(var_8.angles) * 20000;
    var_8 moveTo(var_28, 60);

    if(isDefined(level.uavsettings[var_6].fxid_leave) && isDefined(level.uavsettings[var_6].fx_leave_tag))
      playFXOnTag(level.uavsettings[var_6].fxid_leave, var_8, level.uavsettings[var_6].fx_leave_tag);

    if(var_8.damagetaken < var_8.maxhealth) {
      var_8 notify("_encstr_BA2D081B2B58B32D37EC");
      var_8.isleaving = 1;
      var_8 moveTo(var_28, 4, 4, 0.0);
    }
  }

  var_8 scripts\cp_mp\killstreaks\uav::removeuavmodel();

  if(var_6 == "_encstr_851904B59B34" || var_6 == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950")
    var_8 scripts\cp_mp\killstreaks\uav::revealminimapforteam(level.minimaponbydefault);

  var_8[[level.uavsettings[var_6].removefunc]]();
  var_2.uav = undefined;

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](var_3);

  if(isDefined(var_8.enemyobjid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(var_8.enemyobjid);
    var_8 notify("_encstr_81A01443291B468D7232BDCDBD909E531D12C3980C95");
  }

  if(isDefined(var_8))
    var_8 delete();

  if(var_6 == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950") {
    var_1.radarshowenemydirection = 0;

    if(level.teambased) {
      foreach(var_30 in level.players) {
        if(isDefined(var_30) && var_30.pers["_encstr_8AEF05472BC2D6"] == var_4)
          var_30.radarshowenemydirection = 0;
      }
    }
  }

  level notify("_encstr_8B540B6DB903360BFAAAF85852");
}