/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\uav.gsc
***********************************************/

function init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("uav", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("uav", "init")]]();
  }

  var_0 = getEntArray("minimap_corner", "targetname");

  if(var_0.size) {
    var_1 = var_0[0].origin;
    var_2 = var_0[1].origin;
    var_3 = (0, 0, 0);
    var_3 = var_2 - var_1;
    var_3 = (var_3[0] / 2, var_3[1] / 2, var_3[2] / 2) + var_1;
    level.uavrotationorigin = var_3;
  } else {
    level.uavrotationorigin = (0, 0, 0);
  }

  level.uavrig = spawn("script_model", level.uavrotationorigin);
  level.uavrig setModel("tag_origin");
  level.uavrig.angles = (0, 115, 0);
  level.uavrig hide();
  level.uavrig.targetname = "uavrig_script_model";
  thread rotateuavrig(level.uavrig);
  level.uavrigslow = spawn("script_model", level.uavrotationorigin);
  level.uavrigslow setModel("tag_origin");
  level.uavrigslow.angles = (0, 115, 0);
  level.uavrigslow hide();
  level.uavrigslow.targetname = "uavrig_script_model";
  thread rotateuavrig(level.uavrigslow);
  level.counteruavrig = spawn("script_model", level.uavrotationorigin);
  level.counteruavrig setModel("tag_origin");
  level.counteruavrig.angles = (0, 115, 0);
  level.counteruavrig hide();
  level.counteruavrig.targetname = "counteruavrig_script_model";
  thread rotateuavrig(level.counteruavrig);
  level.advanceduavrig = spawn("script_model", level.uavrotationorigin);
  level.advanceduavrig setModel("tag_origin");
  level.advanceduavrig.angles = (0, 115, 0);
  level.advanceduavrig hide();
  level.advanceduavrig.targetname = "advanceduavrig_script_model";
  thread rotateuavrig(level.advanceduavrig);
  level.ref_13ede = getuavstrengthmin();
  level.ref_13ed9 = getuavstrengthmax();
  level.ref_13eda = getuavstrengthlevelshowenemydirectional();
  level.ref_13edc = getuavstrengthlevelneutral();
  level.ref_13edb = getuavstrengthlevelshowenemyfastsweep();

  if(!isDefined(level.ref_13edd) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
    level.ref_13edd = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]() && getdvarint("scr_uav_for_squad_only", 1);
  }

  if(level.teambased && !istrue(level.ref_13edd)) {
    for(var_4 = 0; var_4 < level.teamnamelist.size; var_4++) {
      level.radarmode[level.teamnamelist[var_4]] = "normal_radar";
      level.activeuavs[level.teamnamelist[var_4]] = 0;
      level.activecounteruavs[level.teamnamelist[var_4]] = 0;
      level.activeadvanceduavs[level.teamnamelist[var_4]] = 0;
      level.uavmodels[level.teamnamelist[var_4]] = [];
    }
  } else {
    level.radarmode = [];
    level.activeuavs = [];
    level.activecounteruavs = [];
    level.activeadvanceduavs = [];
    level.uavmodels = [];
  }

  level.totalactiveuavs = 0;
  level.totalactivecounteruavs = 0;
  level.audio_heli_end_fade_out = 0;
  thread onplayerconnect();
  thread uavtracker();
  game["dialog"]["uav_destroyed"] = "uav_destroyed";
}

function onplayerconnect() {
  var_0 = getuavstrengthlevelneutral();
  var_1 = level.teambased && istrue(level.ref_13edd);

  for(;;) {
    level waittill("connected", var_2);

    if(var_1) {
      thread ref_12090();
      continue;
    }

    level.activeuavs[var_2.guid] = 0;
    level.activeuavs[var_2.guid + "_radarStrength"] = var_0;
    level.activecounteruavs[var_2.guid] = 0;
    level.radarmode[var_2.guid] = "normal_radar";
    var_2.radarstrength = var_0;
  }
}

function ref_12090() {
  self endon("disconnect");

  while(!isDefined(self.squadindex)) {
    waitframe();
  }

  var_0 = self.team + self.squadindex;

  if(!isDefined(level.radarmode[var_0])) {
    level.radarmode[var_0] = "normal_radar";
  }

  if(!isDefined(level.activeuavs[var_0])) {
    level.activeuavs[var_0] = 0;
  }

  if(!isDefined(level.activecounteruavs[var_0])) {
    level.activecounteruavs[var_0] = 0;
  }

  if(!isDefined(level.activeadvanceduavs[var_0])) {
    level.activeadvanceduavs[var_0] = 0;
  }

  if(!isDefined(level.uavmodels[var_0])) {
    level.uavmodels[var_0] = [];
    return;
  }
}

function onplayerspawned() {
  level notify("uav_update");
}

function rotateuavrig(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(!isDefined(var_0)) {
    var_0 = 60;
  }

  if(!isDefined(var_1)) {
    var_1 = -360;
  }

  for(;;) {
    self rotateYaw(var_1, var_0);
    wait var_0;
  }
}

function tryuseuav(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  return tryuseuavfromstruct(var_1);
}

function tryuseuavfromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  if(istrue(level.pe_auavscan_active)) {
    var_1 = "MP_BR_INGAME_TU_WZ335/AUAVSCAN_IN_PROGRESS";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_1);
    }

    return false;
  }

  var_2 = 0;

  if(level.teambased && isDefined(level.teamdata) && isDefined(level.teamdata[self.team]) && isDefined(level.teamdata[self.team]["activeSupplySweeps"])) {
    var_3 = level.teamdata[self.team]["activeSupplySweeps"].size;
    var_2 = var_3 > 0;
  }

  if(var_2) {
    var_1 = "MP_BR_INGAME_TU_WZ350/SUPPLY_SWEEP_IN_PROGRESS";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_1);
    }

    return false;
  }

  if(!istrue(var_2.ref_133cc)) {
    var_4 = "ks_gesture_generic_mp";

    if(scripts\cp_mp\utility\game_utility::ref_140a9()) {
      var_4 = "ks_gesture_generic_mp_ch3";
    }

    var_5 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_2, getcompleteweaponname(var_4));

    if(!istrue(var_5)) {
      return false;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_2)) {
      return false;
    }
  }

  var_1 = useuav(var_2.streakname, var_2);
  return istrue(var_1);
}

function useuav(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0, self.origin);
  }

  var_2 = self.pers["team"];
  var_3 = self.squadindex;
  var_4 = level.uavsettings[var_0].timeout;
  var_5 = 0;

  if(level.gametype == "br") {
    var_5 = 1;
  }

  scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_call_in_uav_for_operator_mission", 1);
  scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_call_in_uav_for_operator_mission_op2", 1);

  if(getdvarint("current_season", 1) >= 8) {
    scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_call_in_uav_for_operator_mission_op3", 1);
  }

  thread launchuav(level, self, var_0, var_1);

  switch (var_0) {
    case "counter_uav":
      self notify("used_counter_uav");
      break;
    case "harp":
    case "directional_uav":
      self.radarshowenemydirection = 1;

      if(level.teambased) {
        foreach(var_7 in level.players) {
          if(var_7.pers["team"] == var_2) {
            var_7.radarshowenemydirection = 1;
            LOC_0000011a:
          }
          LOC_0000011a:
        }
      }

      self notify("used_directional_uav");
      break;
    default:
      self notify("used_uav");
      break;
  }

  return true;
}

function ref_13320(var_0) {
  if(level.gametype != "br") {
    return false;
  }

  if(var_0 != "uav") {
    return false;
  }

  var_1 = undefined;

  if(level.teambased) {
    var_1 = self.team;

    if(istrue(level.ref_13edd)) {
      var_1 = self.team + self.squadindex;
    }
  } else {
    var_1 = self.guid;
  }

  var_2 = level.activeadvanceduavs[var_1] > 0;

  if(var_2) {
    return false;
  }

  var_3 = level.activeuavs[var_1];
  var_4 = _getradarstrength(var_3 + 1, 0, 0);
  var_5 = getuavstrengthlevelshowenemydirectional();
  return var_4 >= var_5;
}

function launchuav(var_0, var_1, var_2, var_3) {
  var_4 = var_0.team;
  var_5 = var_0.squadindex;
  var_6 = getuavrig(var_1);

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    if(level.gametype == "arm") {
      if(isDefined(level.hqmidpoint)) {
        var_6.origin = level.hqmidpoint;
      }
    } else {
      var_6.origin = var_0.origin;
    }
  }

  var_7 = undefined;

  if(istrue(var_3)) {
    var_7 = spawnStruct();
    var_7.damagetaken = 0;
  } else {
    var_7 = spawn("script_model", var_6 gettagorigin("tag_origin") + (0, 0, 5000));
  }

  var_8 = level.uavsettings[var_1].modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0) && isDefined(level.uavsettings[var_1].modelbasealt)) {
    var_8 = level.uavsettings[var_1].modelbasealt;
  }

  var_9 = level.uavsettings[var_1].timeout;
  var_11 = level.uavsettings[var_1].maxhealth;
  var_12 = level.uavsettings[var_1].teamsplash;
  var_13 = var_2.streakname;

  if(ref_13320(var_0, var_1)) {
    var_13 = "directional_uav";
  }

  var_14 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](var_0, var_13);
    var_14 = 2;
  }

  if(level.gametype == "br") {
    ref_13ed5(var_0, var_4, 15000, var_13);
  }

  if(var_1 == "harp") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "harpSpawned")) {
      var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "harpSpawned")]](var_0);
    }
  }

  var_0 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_13, 1, var_14);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var_12, var_0);
  }

  if(isent(var_7)) {
    var_7 setModel(var_8);
  }

  var_7.team = var_4;
  var_7.owner = var_0;
  var_7.timetoadd = 0;
  var_7.uavtype = var_1;
  var_7.health = level.uavsettings[var_1].health;
  var_7.maxhealth = var_11;
  var_7.streakinfo = var_2;
  thread monitorowner();
  thread restorestrengthafterhostmigration();
  thread watchgameend();

  if(isent(var_7)) {
    var_7 setotherent(var_0);
    var_7 scriptmoveroutline();
    var_7 scriptmoverthermal();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
      var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_1, "Killstreak_Air", var_0);
    }

    thread damagetracker();
    thread handleincomingstinger();
    thread perkengineer_manageminimap();
    thread trackvelocity();
    var_7 setscriptablepartstate("lights", "on", 0);
    var_15 = randomintrange(6000, 6500);

    if(var_7.uavtype == "directional_uav" || var_7.uavtype == "harp") {
      var_15 = randomintrange(30000, 31000);
    }

    if(isDefined(level.spawnpoints)) {
      var_16 = level.spawnpoints;
    } else {
      var_16 = level.startspawnpoints;
    }

    if(!isDefined(var_16)) {
      var_17 = spawnStruct();
      var_17.origin = (var_1.origin[0], var_1.origin[1], 6969);
      var_16 = [var_17];
    }

    var_18 = var_16[0];

    foreach(var_17 in var_16) {
      if(var_17.origin[2] < var_18.origin[2]) {
        var_18 = var_17;
      }
    }

    var_21 = var_18.origin[2];
    var_22 = var_7.origin[2];

    if(var_21 < 0) {
      var_22 += var_21 * -1;
      var_21 = 0;
    }

    var_23 = randomint(360);
    var_24 = randomint(1000);

    if(var_8.uavtype == "directional_uav" || var_8.uavtype == "harp") {
      var_24 = randomintrange(20000, 22000);
    }

    var_25 = var_24 + 4000;
    var_26 = cos(var_23) * var_25;
    var_27 = sin(var_23) * var_25;
    var_28 = vectorNormalize((var_26, var_27, var_16));
    var_28 *= var_16;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
      var_29 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

      if(var_29 == "br") {
        var_30 = (0, 0, 3000);
        var_28 += var_30;
      }
    }

    var_8 linkTo(var_7, "tag_origin", var_28, (0, var_23 - 90, 0));
    thread updateuavmodelvisibility();
  }

  var_8[[level.uavsettings[var_2].addfunc]]();

  if(var_2 == "uav" || var_2 == "directional_uav" || var_8.uavtype == "harp") {
    revealminimapforteam(var_8, 1);
    thread applymapenableonspawn();
  }

  if(isDefined(level.activeuavs[var_5]) && level.activeuavs[var_5] > 0) {
    if(isent(var_8)) {
      foreach(var_32 in level.uavmodels[var_5]) {
        if(isDefined(var_32.timetoadd)) {
          var_32.timetoadd += 5;
          LOC_0000052d:
        }
        LOC_0000052d:
      }
    } else {
      var_8.timetoadd = 5 * (level.activeuavs[var_5] - 1);
    }
  }

  thread handlewiretap();
  level notify("uav_update");
  var_8 scripts\cp_mp\hostmigration::hostmigration_waittillnotifyortimeoutpause("death", var_11);

  if(isDefined(var_8) && var_8.damagetaken < var_8.maxhealth) {
    if(isent(var_8)) {
      var_8 unlink();
      var_8.lb_dmg_factor_fuselage = var_8.origin + anglesToForward(var_8.angles) * 50000;
      var_8 moveTo(var_8.lb_dmg_factor_fuselage, 50);

      if(isDefined(level.uavsettings[var_2].fxid_leave) && isDefined(level.uavsettings[var_2].fx_leave_tag)) {
        playFXOnTag(level.uavsettings[var_2].fxid_leave, var_8, level.uavsettings[var_2].fx_leave_tag);
      }
    }

    if(isDefined(var_1) && !istrue(level.gameended)) {
      var_1 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(level.uavsettings[var_8.uavtype].votimeout, 1);
    }

    var_8 scripts\cp_mp\hostmigration::hostmigration_waittillnotifyortimeoutpause("death", 3);

    if(isDefined(var_8) && var_8.damagetaken < var_8.maxhealth) {
      var_8 notify("leaving");
      var_8.isleaving = 1;

      if(var_2 == "harp") {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "harpTimeout")) {
          var_8[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "harpTimeout")]](var_1);
        }
      }

      if(isent(var_8)) {
        var_8 moveTo(var_8.lb_dmg_factor_fuselage, 15);
      }

      var_8 scripts\cp_mp\hostmigration::hostmigration_waittillnotifyortimeoutpause("death", 4 + var_8.timetoadd);

      if(isDefined(var_8) && var_8.damagetaken < var_8.maxhealth) {
        var_8.leftplayspace = 1;
      }
    }
  }

  if(isDefined(var_8)) {
    var_8.owner notify("uav_finished");

    if(var_2 == "uav" || var_2 == "directional_uav" || var_2 == "harp") {
      revealminimapforteam(var_8, level.minimaponbydefault);
    }

    var_8[[level.uavsettings[var_2].removefunc]]();

    if(isDefined(level.killstreakfinishusefunc)) {
      level thread[[level.killstreakfinishusefunc]](var_3);
    }

    if(isDefined(var_8.enemyobjid)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_8.enemyobjid);
      }

      var_8 notify("uav_deleteObjective");
    }

    var_8.streakinfo.onspray = !istrue(var_8.leftplayspace);

    if(!istrue(self.ref_12aa4)) {
      var_8.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var_8.streakinfo);
    }

    if(isent(var_8)) {
      var_8 delete();
    } else {
      var_8 notify("death");
    }
  }

  if(var_2 == "directional_uav") {
    if(isDefined(var_1)) {
      var_1.radarshowenemydirection = 0;
    }

    if(level.teambased) {
      foreach(var_35 in level.players) {
        if(isDefined(var_35) && var_35.pers["team"] == var_5) {
          var_35.radarshowenemydirection = 0;
          LOC_00000867:
        }
        LOC_00000867:
      }
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - " + var_2, var_1);
  }

  level notify("uav_update");
}

function monitorowner() {
  self endon("death");
  self.owner scripts\engine\utility::ref_143a5("disconnect", "joined_team");

  if(isent(self)) {
    self hide();
    var_0 = anglestoright(self.angles) * 200;
    playFX(level.uavsettings[self.uavtype].fxid_explode, self.origin, var_0);
    playsoundatpos(self.origin, level.uavsettings[self.uavtype].sound_explode);
    self.damagetaken = self.maxhealth;
  }

  self notify("death");
}

function restorestrengthafterhostmigration() {
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");

    if(level.teambased) {
      foreach(var_1 in level.teamnamelist) {
        if(istrue(level.ref_13edd)) {
          foreach(var_3 in level.squaddata[var_1]) {
            var_4 = var_1 + var_6;
            var_5 = aigroundturret_cancel(var_4);
            ammobox_showattachmentflyout(var_1, var_6, var_5);
          }

          continue;
        }

        var_5 = aigroundturret_mountcompleted(var_1);
        _setteamradarstrength(var_1, var_5);
      }
    }
  }
}

function updateuavmodelvisibility() {
  self endon("death");

  for(;;) {
    level scripts\engine\utility::waittill_either("joined_team", "uav_update");
    self hide();

    foreach(var_1 in level.players) {
      if(level.teambased) {
        if(var_1.team != self.team) {
          self showtoplayer(var_1);
        }

        continue;
      }

      if(isDefined(self.owner) && var_1 == self.owner) {
        continue;
      }

      self showtoplayer(var_1);
    }
  }
}

function damagetracker() {
  level endon("game_ended");
  self setCanDamage(1);
  self.damagetaken = 0;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "mapWeapon")) {
      var_9 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "mapWeapon")]](var_9, var_13);
    }

    if(!isPlayer(var_1)) {
      if(!isDefined(self)) {
        return;
      }

      continue;
    }

    if((self.uavtype == "directional_uav" || self.uavtype == "harp") && (var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET")) {
      continue;
    }

    if(isDefined(var_8) && var_8 &level.idflags_penetration) {
      self.wasdamagedfrombulletpenetration = 1;
    }

    if(isDefined(var_8) && var_8 &level.idflags_ricochet) {
      self.wasdamagedfrombulletricochet = 1;
    }

    self.wasdamaged = 1;
    var_14 = var_0;

    if(isPlayer(var_1)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
      }

      if(var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET") {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          if(var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_armorpiercing")) {
            var_14 += var_0 * level.armorpiercingmod;
          }
        }
      }
    }

    var_15 = 1;
    var_16 = 1;
    var_17 = 1;
    var_18 = 0;
    var_19 = 3;

    if(self.uavtype == "directional_uav" || self.uavtype == "harp") {
      var_15 = 5;
      var_16 = 6;
      var_17 = 7;
      var_18 = 0;
      var_19 = 0;
    }

    if(isDefined(var_9)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
        var_14 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var_1, var_9, var_4, var_14, self.maxhealth, var_15, var_16, var_17, var_18, var_19);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakHit")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakHit")]](var_1, var_9, self, var_4, var_14);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "logAttackerKillstreak")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "logAttackerKillstreak")]](self, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, createheadicon(var_9));
      }
    }

    self.damagetaken += var_14;

    if(self.damagetaken >= self.maxhealth) {
      if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {
        var_20 = level.uavsettings[self.uavtype].calloutdestroyed;
        var_21 = "destroyed_" + self.uavtype;

        if(self.uavtype == "uav") {
          var_21 = undefined;
          self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("uav_destroyed", 1);
        }

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](self.uavtype, var_1, var_9, var_4, var_0, "destroyed_" + self.uavtype, var_21, var_20);
        }

        if(isDefined(self.uavremotemarkedby) && self.uavremotemarkedby != var_1) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("uav", "remoteUAV_processTaggedAssist")) {
            self.uavremotemarkedby thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("uav", "remoteUAV_processTaggedAssist")]]();
          }
        }
      }

      self hide();
      var_22 = anglestoright(self.angles) * 200;
      playFX(level.uavsettings[self.uavtype].fxid_explode, self.origin, var_22);
      playsoundatpos(self.origin, level.uavsettings[self.uavtype].sound_explode);
      self notify("death");
      return;
    }
  }
}

function uavtracker() {
  level endon("game_ended");

  for(;;) {
    level waittill("uav_update");

    if(level.teambased) {
      foreach(var_1 in level.teamnamelist) {
        if(istrue(level.ref_13edd)) {
          if(isDefined(level.squaddata)) {
            foreach(var_3 in level.squaddata[var_1]) {
              ref_14020(var_1, var_4);
            }
          }

          continue;
        }

        updateteamuavstatus(var_1);
      }

      continue;
    }

    updateplayersuavstatus();
  }
}

function handlewiretap() {
  foreach(var_1 in level.players) {
    if(isDefined(self.streakname) && (self.streakname == "directional_uav" || self.streakname == "counter_uav" || self.uavtype == "harp")) {
      return;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(!var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_expanded_minimap")) {
        continue;
      }
    }

    if(var_1.team == self.team) {
      continue;
    }

    thread executewiretapsweeps(var_1);
  }
}

function executewiretapsweeps(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  triggeroneoffradarsweep(var_0);
  self waittill("death");
  triggeroneoffradarsweep(var_0);
}

function aigroundturret_cancel(var_0) {
  var_1 = scripts\engine\utility::ter_op(isDefined(level.activeuavs[var_0]), level.activeuavs[var_0], 0);
  var_2 = scripts\engine\utility::ter_op(isDefined(level.activeadvanceduavs[var_0]), level.activeadvanceduavs[var_0], 0);
  var_3 = scripts\engine\utility::ter_op(isDefined(level.activecounteruavs[var_0]), level.activecounteruavs[var_0], 0);
  var_3 = level.totalactivecounteruavs - var_3;
  return _getradarstrength(var_1, var_2, var_3);
}

function aigroundturret_mountcompleted(var_0) {
  var_1 = level.activeuavs[var_0];
  var_2 = level.activeadvanceduavs[var_0];
  var_3 = level.totalactivecounteruavs - level.activecounteruavs[var_0];
  return _getradarstrength(var_1, var_2, var_3);
}

function _getradarstrength(var_0, var_1, var_2) {
  var_3 = getuavstrengthmin();
  var_4 = getuavstrengthmax();

  if(var_1) {
    var_0 = var_4 - getuavstrengthlevelneutral();
  }

  if(level.gametype == "br") {
    var_5 = int(clamp(var_0 + getuavstrengthlevelneutral(), getuavstrengthlevelneutral(), getuavstrengthlevelshowenemydirectional()));
  } else if(var_3 > 0) {
    var_5 = var_4;
  } else if(var_3 > 0) {
    var_5 = var_5;
  } else {
    var_5 = int(clamp(var_3 + getuavstrengthlevelneutral(), getuavstrengthlevelneutral(), getuavstrengthlevelshowenemyfastsweep()));
  }

  var_5 = int(clamp(var_5, var_5, var_5));
  return var_5;
}

function _setteamradarstrength(var_0, var_1) {
  updateteamuavstatus(var_0, var_1);
}

function ammobox_showattachmentflyout(var_0, var_1, var_2) {
  ref_14020(var_0, var_1, var_2);
}

function updateteamuavstatus(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = aigroundturret_mountcompleted(var_1);
  }

  ref_13fdf(var_2, var_1);
}

function ref_14020(var_0, var_1, var_2) {
  jumpiffalse(isDefined(var_2)) LOC_00000012;
  var_3 = var_2;
  goto LOC_00000023;
}

function ref_13fdf(var_0, var_1, var_2) {
  var_0 = int(max(min(var_0, level.ref_13ed9), level.ref_13ede));
  var_3 = var_0 == level.ref_13ede;
  var_4 = !var_3;
  var_5 = var_0 >= level.ref_13eda;
  var_6 = !var_3;

  if(var_0 == level.ref_13edc) {
    var_7 = "normal_radar";
    var_4 = 0;
  } else if(var_1 == level.ref_13ed9 || var_6) {
    var_7 = "constant_radar";
  } else if(var_2 == level.ref_13edb) {
    var_7 = "fast_radar";
  } else {
    var_7 = "normal_radar";
  }

  var_8 = level.players;

  if(isDefined(var_5)) {
    var_8 = level.squaddata[var_4][var_5].players;
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData")) {
    var_8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](var_4, "players");
  }

  foreach(var_10 in var_8) {
    if(!isDefined(var_10)) {
      continue;
    }

    if(istrue(var_10.tracking_obit)) {
      continue;
    }

    if(istrue(var_10.ref_133e9)) {
      continue;
    }

    var_10.radarstrength = var_3;
    var_10.isradarblocked = var_6;
    var_10.hasradar = var_7;
    var_10.radarshowenemydirection = var_7;

    if(var_10.radarshowenemydirection) {
      var_10.radarmode = "constant_radar";
      continue;
    }

    var_10.radarmode = var_7;
  }
}

function updateplayersuavstatus() {
  foreach(var_1 in level.players) {
    if(istrue(var_1.tracking_obit)) {
      continue;
    }

    var_2 = level.activeuavs[var_1.guid + "_radarStrength"];
    var_3 = level.totalactivecounteruavs - level.activecounteruavs[var_1.guid];

    if(var_3 > 0) {
      var_2 = level.ref_13ede;
    }

    var_2 = int(max(min(var_2, level.ref_13ed9), level.ref_13ede));
    var_1.radarstrength = var_2;
    var_4 = var_1.team == "spectator" || var_1.team == "follower" || var_1.team == "free";

    if(var_2 <= level.ref_13edc || var_4) {
      var_1.hasradar = 0;
      var_1.radarshowenemydirection = 0;

      if(isDefined(var_1.radarmode) && var_1.radarmode == "constant_radar") {
        var_1.radarmode = "normal_radar";
      }

      continue;
    }

    if(var_2 >= level.ref_13edb) {
      var_1.radarmode = "fast_radar";
    } else {
      var_1.radarmode = "normal_radar";
    }

    var_1.radarshowenemydirection = var_2 >= level.ref_13eda;

    if(istrue(var_1.radarshowenemydirection)) {
      var_1.radarmode = "constant_radar";
    }

    var_1.hasradar = 1;
  }
}

function handleincomingstinger() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("stinger_fired", var_0, var_1, var_2);

    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }

    thread stingerproximitydetonate(var_1, var_2);
  }
}

function trackvelocity() {
  level endon("game_ended");
  self endon("death");
  self.velocity = (0, 0, 0);

  for(;;) {
    self.lastorigin = self.origin;
    wait 0.05;
    self.velocity = (self.origin - self.lastorigin) / 0.05;
  }
}

function watchgameend() {
  self endon("death");
  self.owner endon("uav_finished");
  level waittill("game_ended");
  self.ref_12aa4 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
}

function stingerproximitydetonate(var_0, var_1) {
  self endon("death");
  var_2 = distance(self.origin, var_0 getpointinbounds(0, 0, 0));
  var_3 = var_0 getpointinbounds(0, 0, 0);

  for(;;) {
    if(!isDefined(var_0)) {
      var_4 = var_3;
    } else {
      var_4 = var_0 getpointinbounds(0, 0, 0);
    }

    var_3 = var_4;
    var_5 = distance(self.origin, var_4);

    if(var_5 < var_2) {
      var_2 = var_5;
    }

    if(var_5 > var_2) {
      if(var_5 > 1536) {
        return;
      }

      radiusdamage(self.origin, 1536, 600, 600, var_1, "MOD_EXPLOSIVE", "iw8_la_gromeo_mp");
      self hide();
      self notify("deleted");
      waitframe();
      self delete();
      var_1 notify("killstreak_destroyed");
    }

    waitframe();
  }
}

function adduavmodel() {
  if(level.teambased) {
    if(istrue(level.ref_13edd)) {
      self.squadindex = self.owner.squadindex;
      self.teamsquadindex = self.team + self.owner.squadindex;
      level.uavmodels[self.teamsquadindex][level.uavmodels[self.teamsquadindex].size] = self;
      return;
    }

    level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
    return;
  }

  level.uavmodels[self.owner.guid + "_" + gettime()] = self;
}

function removeuavmodel() {
  var_0 = [];
  jumpiffalse(level.teambased) LOC_000000b6;
  var_1 = self.team;
  var_2 = self.owner.squadindex;

  if(istrue(level.ref_13edd)) {
    foreach(var_4 in level.uavmodels[self.teamsquadindex]) {
      if(!isDefined(var_4)) {
        continue;
      }

      var_0 = var_4;
    }

    level.uavmodels[self.teamsquadindex] = var_0;
    return;
  }

  foreach(var_4 in level.uavmodels[var_1]) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_0 = var_4;
  }

  level.uavmodels[var_1] = var_0;
  return;
}

function addactiveuav() {
  level.totalactiveuavs++;

  if(level.teambased) {
    var_0 = self.team;

    if(istrue(level.ref_13edd)) {
      self.squadindex = self.owner.squadindex;
      self.teamsquadindex = self.team + self.owner.squadindex;
      var_0 = self.teamsquadindex;
    }

    level.activeuavs[var_0]++;

    if(self.uavtype == "directional_uav" || self.uavtype == "harp") {
      level.activeadvanceduavs[var_0]++;
      level.audio_heli_end_fade_out++;
      return;
    }

    return;
  }

  level.activeuavs[self.owner.guid]++;
  level.activeuavs[self.owner.guid + "_radarStrength"]++;

  if(self.uavtype == "directional_uav" || self.uavtype == "harp") {
    level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] + 2;

    if(!isDefined(level.activeadvanceduavs[self.owner.guid])) {
      level.activeadvanceduavs[self.owner.guid] = 0;
    }

    level.activeadvanceduavs[self.owner.guid]++;
    level.audio_heli_end_fade_out++;
    return;
  }
}

function addactivecounteruav() {
  if(level.teambased) {
    if(istrue(level.ref_13edd)) {
      self.squadindex = self.owner.squadindex;
      self.teamsquadindex = self.team + self.owner.squadindex;
      level.activecounteruavs[self.teamsquadindex]++;
    } else {
      level.activecounteruavs[self.team]++;
    }
  } else {
    level.activecounteruavs[self.owner.guid]++;
  }

  level.totalactivecounteruavs++;
}

function removeactiveuav() {
  if(level.teambased) {
    var_0 = self.team;

    if(istrue(level.ref_13edd)) {
      var_0 = self.teamsquadindex;
    }

    level.activeuavs[var_0]--;
    level.totalactiveuavs--;

    if(self.uavtype == "directional_uav" || self.uavtype == "harp") {
      level.activeadvanceduavs[var_0]--;
      level.audio_heli_end_fade_out--;
      return;
    }

    return;
  }

  if(isDefined(self.owner)) {
    level.activeuavs[self.owner.guid]--;
    level.totalactiveuavs--;
    level.activeuavs[self.owner.guid + "_radarStrength"]--;

    if(self.uavtype == "directional_uav" || self.uavtype == "harp") {
      level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] - 2;
      level.activeadvanceduavs[self.owner.guid]--;
      level.audio_heli_end_fade_out--;
      return;
    }

    return;
  }
}

function removeactivecounteruav() {
  if(level.teambased) {
    if(istrue(level.ref_13edd)) {
      level.activecounteruavs[self.teamsquadindex]--;
    } else {
      level.activecounteruavs[self.team]--;
    }
  } else if(isDefined(self.owner)) {
    level.activecounteruavs[self.owner.guid]--;
  }

  level.totalactivecounteruavs--;
}

function watchhighlightfadetime(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_3 endon("death");
  }

  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::ref_143bf(var_2, "leave");

  if(isDefined(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_0, var_1);
      return;
    }

    return;
  }
}

function getuavrig(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "uav":
      var_1 = level.uavrig;
      break;
    case "counter_uav":
      var_1 = level.counteruavrig;
      break;
    case "harp":
    case "directional_uav":
      var_1 = level.advanceduavrig;
      break;
    case "default":
      break;
  }

  return var_1;
}

function perkengineer_manageminimap() {
  self.owner endon("disconnect");
  self endon("uav_deleteObjective");

  switch (self.uavtype) {
    case "uav":
      var_0 = "icon_minimap_uav";
      break;
    case "counter_uav":
      var_0 = "icon_minimap_counter_uav_enemy";
      break;
    case "harp":
    case "directional_uav":
      var_0 = "icon_minimap_auav";
      break;
    default:
      var_0 = "icon_minimap_uav";
      break;
  }

  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_1 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjectiveEngineer");
  }

  if(isDefined(var_1)) {
    self.enemyobjid = self[[var_1]](var_0, 1, 1);
  }

  var_2 = 0;

  for(;;) {
    var_3 = level.players.size;

    for(var_4 = 0; var_4 < 10; var_4++) {
      if(var_2 >= level.players.size) {
        var_2 = 0;
      }

      var_5 = level.players[var_2];
      var_2++;

      if(!isDefined(var_5)) {
        continue;
      }

      if(self.enemyobjid != -1) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          if(var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_engineer") && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_5, self.owner))) {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.enemyobjid, var_5);
            continue;
          }

          scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.enemyobjid, var_5);
        }
      }
    }

    waitframe();
  }
}

function startsystemshutdown() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(level.teambased && var_1.team == self.owner.team) {
      continue;
    }

    if(!level.teambased && var_1 == self.owner) {
      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(!var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_empimmune")) {
        thread shutdownenemysystem(var_1);
      }
    }
  }

  thread applyshutdownonspawn();
}

function givefriendlyperks(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_coldblooded");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_tracker_jammer");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_noscopeoutline");
  }

  var_0 waittill("death");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_coldblooded");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_tracker_jammer");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_noscopeoutline");
    return;
  }
}

function shutdownenemysystem(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self setuavjammed(1);
  var_0 waittill("death");
  self setuavjammed(0);
}

function applyshutdownonspawn() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  var_1 = var_0.team;

  for(;;) {
    level waittill("player_spawned", var_2);

    if(var_2 == var_0) {
      continue;
    }

    if(level.teambased) {
      if(istrue(level.ref_13edd)) {
        if(var_2.team == var_1 && var_2.squadindex == var_0.squadindex) {
          continue;
        }
      } else if(var_2.team == var_1) {
        continue;
      }
    }

    thread shutdownenemysystem(var_2);
  }
}

function startemppulse() {
  self endon("death");
  level endon("game_ended");
  wait 2;
  self playSound("jammer_drone_charge");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  wait 1.5;
  stopFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_shockwave"), self, "tag_origin");
  self playSound("jammer_drone_shockwave");

  foreach(var_1 in level.players) {
    if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    thread applyuavshellshock();
  }

  var_3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getEnemyTeams")) {
    var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getEnemyTeams")]](self.team);
  }

  foreach(var_5 in var_3) {
    destroyactiveobjects(var_5, self.owner);
  }
}

function applyuavshellshock() {
  self playLoopSound("emp_nade_lp");
  thread applyuavshellshockvisionset();
  wait 0.5;
  self playSound("emp_nade_lp_end");
  self stoploopsound("emp_nade_lp");
}

function applyuavshellshockvisionset() {
  visionsetnaked("coup_sunblind", 0.05);
  waitframe();
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 0.5);
}

function destroyactiveobjects(var_0, var_1) {
  var_2 = "nuke_mp";
  var_3 = level.activekillstreaks;
  var_4 = [[level.getactiveequipmentarray]]();
  var_5 = undefined;

  if(isDefined(var_3) && isDefined(var_4)) {
    var_5 = scripts\engine\utility::array_combine_unique(var_3, var_4);
  } else if(isDefined(var_3)) {
    var_5 = var_3;
  } else if(isDefined(var_4)) {
    var_5 = var_4;
  }

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      if(isDefined(var_7)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "doDamageToKillstreak")) {
          var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "doDamageToKillstreak")]](10000, var_1, var_1, var_0, var_7.origin, "MOD_EXPLOSIVE", var_2);
        }
      }
    }

    return;
  }
}

function revealminimapforteam(var_0) {
  foreach(var_2 in level.players) {
    if(isai(var_2)) {
      continue;
    }

    if(level.teambased) {
      if(istrue(level.ref_13edd)) {
        if(self.squadindex != var_2.squadindex || self.team != var_2.team) {
          continue;
        }
      } else if(self.team != var_2.team) {
        continue;
      }
    }

    if(!level.teambased && self.owner != var_2) {
      continue;
    }

    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(istrue(var_0)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
      }

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap")) {
      var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
    }
  }
}

function applymapenableonspawn() {
  self.owner endon("disconnect");
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner.guid;

  if(level.teambased) {
    if(istrue(level.ref_13edd)) {
      var_0 = self.team + self.owner.squadindex;
    } else {
      var_0 = self.team;
    }
  }

  level notify("uav_show_minimap_" + var_0);
  level endon("uav_show_minimap_" + var_0);
  jumpiffalse(istrue(level.istacops)) LOC_00000072;
  return;
}

function setforceradars(var_0, var_1) {
  if(isDefined(var_1)) {
    wait var_1;
  }

  var_2 = getdvarint("scr_game_forceuav");
  var_3 = "normal_radar";
  var_4 = 1;
  var_5 = 0;

  switch (var_2) {
    case 3:
      var_3 = "normal_radar";
      break;
    case 5:
      var_3 = "fast_radar";
      var_4 = 2;
      break;
    case 6:
      var_3 = "constant_radar";
      var_5 = 1;
      break;
    default:
      break;
  }

  if(level.teambased) {
    if(istrue(level.ref_13edd)) {
      var_6 = 0;

      foreach(var_8 in level.teamnamelist) {
        foreach(var_12, var_10 in level.squaddata[var_8]) {
          var_11 = var_8 + var_12;
          level.radarmode[var_11] = var_3;
          level.activeuavs[var_11] = var_4;
          level.activeadvanceduavs[var_11] = var_5;
          var_6++;
          ammobox_showattachmentflyout(var_8, var_12, var_2);
        }
      }

      level.audio_heli_end_fade_out = var_6;
      return;
    }

    foreach(var_16, var_15 in level.teamnamelist) {
      level.radarmode[var_15] = var_3;
      level.activeuavs[var_15] = var_4;
      level.activeadvanceduavs[var_15] = var_5;
      level.audio_heli_end_fade_out = level.teamnamelist.size;
      _setteamradarstrength(var_15, var_2);
    }

    return;
  }

  var_15 = scripts\engine\utility::ter_op(var_16 > 0, level.ref_13ed9, level.ref_13edc + var_15);
  level.radarmode[var_3.guid] = var_14;
  var_3.radarstrength = var_15;
  level.activeuavs[var_3.guid + "_radarStrength"] = var_15;
  level.activeadvanceduavs[var_3.guid] = var_16;
  level.audio_heli_end_fade_out = level.teamnamelist.size;
  updateplayersuavstatus();
}

function ref_13ed5(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return;
  }

  var_3 = ref_13ed6(var_0, var_1);

  foreach(var_5 in var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayer")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayer")]](var_5, var_2, 1);
    }
  }
}

function ref_13ed6(var_0, var_1) {
  var_2 = [];
  var_3 = level.teamdata[var_0]["players"];

  foreach(var_5 in var_3) {
    if(!isDefined(var_5) || !var_5 scripts\cp_mp\utility\player_utility::_isalive() || var_5 scripts\cp_mp\utility\player_utility::_isalive() && istrue(var_5.gulag)) {
      continue;
    }

    var_6 = scripts\common\utility::playersincylinder(var_5.origin, var_1, var_3);

    foreach(var_8 in var_6) {
      if(var_2.size > 0) {
        var_9 = ref_13ed7(var_8, var_2);

        if(istrue(var_9)) {
          continue;
        }
      }

      var_2 = var_8;
    }
  }

  return var_2;
}

function ref_13ed7(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && var_0 == var_4) {
      var_2 = 1;
      break;
    }
  }

  return var_2;
}