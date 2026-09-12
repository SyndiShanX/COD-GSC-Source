/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\airstrike.gsc
***************************************************/

function init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "init")]]();
  }

  level._effect["airstrike_tracer"] = loadfx("vfx/iw8_mp/killstreak/vfx_a10_tracer_sep.vfx");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "airstrike_params")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "airstrike_params")]]();
  }

  init_airstrike_flyby_anims();
  init_airstrike_vo();
  level.audio_heli_fade_up = [];
  level.brareloadoutdropbagsdelayed = 0;
  level.airstrikedefaultside = getdvarint("scr_br_airstrike_default_side", 1);
  level.airstrikeusescoring = getdvarint("scr_br_airstrike_use_scoring", 1);
  level.airstrikedangerradius = getdvarint("scr_br_airstrike_danger_radius", 1000);
  level.airstrikedangerfromcenter = getdvarint("scr_br_airstrike_danger_center", 0);
  level.airstrikedangerfromsites = getdvarint("scr_br_airstrike_danger_sites", 1);
}

#using_animtree("");

function init_airstrike_flyby_anims() {
  var_0 = % mp_alfa10_flyin;
  var_1 = "mp_alfa10_flyin";

  if(scripts\cp_mp\utility\game_utility::ref_140AA()) {
    var_0 = $mp_alfa10_flyin_br;
    var_1 = "mp_alfa10_flyin_br";
  }

  level.scr_animtree["precision_airstrike"] = #animtree;
  level.scr_anim["precision_airstrike"]["airstrike_flyby"] = var_0;
  level.scr_animname["precision_airstrike"]["airstrike_flyby"] = var_1;
  level.scr_animtree["multi_airstrike"] = #animtree;
  level.scr_anim["multi_airstrike"]["airstrike_flyby"] = % mp_alfa10_flyin;
  level.scr_animname["multi_airstrike"]["airstrike_flyby"] = "mp_alfa10_flyin";
  level.scr_animtree["fuel_airstrike"] = #animtree;
  level.scr_anim["fuel_airstrike"]["airstrike_flyby"] = % mp_alfa10_flyin;
  level.scr_animname["fuel_airstrike"]["airstrike_flyby"] = "mp_alfa10_flyin";
}

function init_airstrike_vo() {
  game["dialog"]["airstrike_good_hit"] = "precision_airstrike_hit";
  game["dialog"]["airstrike_bad_hit"] = "precision_airstrike_miss";
}

function weapongivenairstrike(var_0) {
  var_1 = getdvarint("scr_airstrike_type", 2);
  var_2 = branalytics_secondwind(self.origin);

  if(var_2 != "success") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_2);
    }

    return false;
  }

  if(var_0.streakname == "multi_airstrike") {
    var_3 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "startMapSelectSequence")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "startMapSelectSequence")]](0, 1, var_3);
    }
  } else if(var_0.streakname == "fuel_airstrike") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "startMapSelectSequence")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "startMapSelectSequence")]]();
    }
  }

  return true;
}

function weaponswitchendedairstrike(var_0, var_1) {
  var_2 = getdvarint("scr_airstrike_type", 2);

  if(istrue(var_1)) {
    if(var_0.streakname == "precision_airstrike") {
      if(var_2 == 1) {
        self laseron();
        return;
      }

      if(var_2 == 2) {
        thread airstrike_watchforads(var_0);
        return;
      }

      return;
    }

    return;
  }
}

function weaponfiredairstrike(var_0, var_1, var_2) {
  if(!isDefined(var_0.ref_13A81)) {
    var_3 = airstrike_getownerlookatpos(self);
    var_4 = branalytics_secondwind(var_3);

    if(var_4 != "success") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_4);
      }

      return "continue";
    }
  }

  if(isDefined(level.gametype)) {
    if(level.gametype == "br" && isDefined(self.scrambledby)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP_BR_INGAME_TU_WZ335/JAMMED");
      }

      return "continue";
    }
  }

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }

    return "continue";
  }

  var_5 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    var_5 = 2;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_0.streakname, 1, var_5);
  return "success";
}

function tryuseairstrike(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  return tryuseairstrikefromstruct(var_1);
}

function tryuseairstrikefromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  var_1 = undefined;
  var_2 = level.airstrikesettings[var_0.streakname].deployweaponobj;

  switch (var_0.streakname) {
    case "precision_airstrike":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

        if(var_3 == "br" && isDefined(self.waitandunloadinfils)) {
          var_0.ref_13A81 = self.waitandunloadinfils;
          self.waitandunloadinfils = undefined;
        }
      }

      if(isDefined(var_0.ref_13A81)) {
        var_4 = weaponfiredairstrike(var_0, undefined, undefined);
        var_1 = var_4 == "success";
      } else {
        var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var_0, var_2, "weapon_fired", &weapongivenairstrike, &weaponswitchendedairstrike, &weaponfiredairstrike);
      }

      break;
    case "multi_airstrike":
    case "fuel_airstrike":
      var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, var_2, 1, &weapongivenairstrike, &weaponswitchendedairstrike);
      break;
  }

  if(!istrue(var_1)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return false;
    }
  }

  var_5 = selectairstrikelocation(var_0);

  if(!istrue(var_5)) {
    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "munitionUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "munitionUsed")]]();
  }

  return true;
}

function selectairstrikelocation(var_0) {
  var_1 = (0, 0, 0);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = spawn("script_origin", self.origin);
  var_6 = "used_" + var_0.streakname;

  if(var_0.streakname == "precision_airstrike") {
    if(isDefined(var_0.ref_13A81)) {
      var_1 = var_0.ref_13A81;
    } else {
      var_1 = airstrike_getownerlookatpos(self, 1);
    }
  } else if(var_0.streakname == "multi_airstrike") {
    var_7 = 3;
    var_4 = 1;
    scripts\common\utility::allow_weapon_switch(0);
    self setsoundsubmix("mp_killstreak_overlay");
    var_2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "getSelectMapPoint")) {
      var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "getSelectMapPoint")]](var_0, var_7, 1);
    }

    scripts\common\utility::allow_weapon_switch(1);
  } else if(var_0.streakname == "fuel_airstrike") {
    var_7 = 3;
    scripts\common\utility::allow_weapon_switch(0);
    self setsoundsubmix("mp_killstreak_overlay");
    var_2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "getSelectMapPoint")) {
      var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "getSelectMapPoint")]](var_0, var_7);
    }

    scripts\common\utility::allow_weapon_switch(1);
  }

  if(isDefined(var_2)) {
    var_8 = branalytics_secondwind(var_2);

    if(var_8 != "success") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_8);
      }

      return false;
    }

    thread finishmapselectairstrikeusage(var_2, var_4, var_1, var_3, var_0);
    self clearsoundsubmix("mp_killstreak_overlay");
  } else if(!isDefined(var_2) && (var_0.streakname == "multi_airstrike" || var_0.streakname == "fuel_airstrike")) {
    if(isDefined(var_5)) {
      var_5 stoploopsound("");
      var_5 delete();
    }

    self clearsoundsubmix("mp_killstreak_overlay");
    return false;
  } else if(var_0.streakname == "precision_airstrike") {
    thread finishstandardairstrikeusage(var_1, var_3, var_0);
  }

  if(isDefined(var_5)) {
    var_5 stoploopsound("");
    var_5 delete();
  }

  var_0 notify("killstreak_finished_with_deploy_weapon");
  self notify("successful_fire");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash"), var_6, self);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0.streakname, var_1);
  }

  if(level.gametype == "br" && level.airstrikedangerfromcenter) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayersInRange"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayersInRange")]](var_1, level.airstrikedangerradius, var_0.streakname);
  }

  return true;
}

function finishmapselectairstrikeusage(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  level endon("game_ended");
  var_5 = level.scr_anim[var_4.streakname]["airstrike_flyby"];
  var_6 = getanimlength(var_5);
  var_7 = scripts\engine\utility::get_notetrack_time(var_5, "attack");
  var_8 = branalytics_respawn(self.origin, self);
  thread airstrike_watchkills(var_7 * 2, var_8);
  thread watchairstrikeowner(var_8);
  thread branalytics_teameliminated(var_4, var_8);

  foreach(var_10 in var_0) {
    var_2 = var_10.location;
    var_11 = self.angles[1];

    if(istrue(var_1)) {
      var_11 = var_10.angles;
    }

    finishairstrikeusage(var_2, var_11, var_3, var_4, var_5, var_8);

    if(var_0.size > 1 && var_12 < var_0.size - 1) {
      wait randomfloatrange(0.8, 1);
    }
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_6);

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var_4);
  }

  branalytics_seteventdelayedstate(self, var_8);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - " + var_4.streakname, self);
  }

  scripts\cp_mp\utility\killstreak_utility::ref_12AA7(var_4);
}

function finishstandardairstrikeusage(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  var_3 = level.scr_anim[var_2.streakname]["airstrike_flyby"];
  var_4 = getanimlength(var_3);
  var_5 = scripts\engine\utility::get_notetrack_time(var_3, "attack");
  var_6 = branalytics_respawn(var_0, self);
  thread airstrike_watchkills(var_5 * 2, var_6);
  thread watchairstrikeowner(var_6);
  thread branalytics_teameliminated(var_2, var_6);
  finishairstrikeusage(var_0, undefined, var_1, var_2, var_3, var_6);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_4);

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var_2);
  }

  branalytics_seteventdelayedstate(self, var_6);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - " + var_2.streakname, self);
  }

  scripts\cp_mp\utility\killstreak_utility::ref_12AA7(var_2);
}

function finishairstrikeusage(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("used");
  self notify("airstrike_used");
  doairstrike(var_0, var_1, self, self.pers["team"], var_2, var_3, var_4, var_5);
}

function doairstrike(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread callstrike(level, var_2, var_0, var_1, var_4, var_5, var_6);
}

function watchairstrikeowner(var_0) {
  self endon("airstrike_finished_" + var_0);
  level endon("game_ended");
  scripts\engine\utility::ref_143A5("disconnect", "joined_team");
  branalytics_seteventdelayedstate(self, var_0);
}

function callstrike(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 0;
  var_8 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_9 = 24000;
  var_10 = 6500;
  var_11 = 2500;
  var_7 = 1500;

  if(isDefined(var_8)) {
    var_11 = var_8.origin[2];
  }

  var_12 = scripts\cp_mp\utility\game_utility::getlocaleid();

  if(isDefined(var_12) && var_12 == "locale_6") {
    var_11 += 500;
  }

  if(level.mapname == "mp_br_mechanics" || scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    var_11 += 2500;
  }

  var_7 = getexplodedistance(var_11);
  var_14 = undefined;
  var_15 = undefined;

  if(isDefined(var_2)) {
    var_14 = (0, var_2, 0);
  } else {
    var_14 = callstrike_findoptimaldirection(var_0, var_1, var_11);
    var_15 = 1;
  }

  var_16 = getflightpath(var_1, var_14, var_9, var_8, var_11, var_10, var_7, var_4.streakname, var_15);

  if(var_4.streakname == "precision_airstrike") {
    for(var_17 = 0; var_17 < 2; var_17++) {
      var_11 += randomintrange(200, 300);
      thread doplanestrike(level, var_1, var_16["startPoint"], var_16["endPoint"], var_11, var_3, var_4, var_5, var_0);
      wait 3;
    }

    return;
  }

  thread doplanestrike(level, var_1, var_16["startPoint"], var_16["endPoint"], var_11, var_3, var_4, var_5, var_0);
}

function callstrike_findoptimaldirection(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0 getplayerangles());
  var_4 = scripts\engine\trace::create_default_contents(1);
  var_5 = scripts\engine\trace::ray_trace(var_1 - var_3 * 30, var_1 + var_3 * 1000, undefined, var_4);
  var_1 = var_5["position"] + var_5["normal"] * 20;
  var_6 = var_1;
  var_7 = var_2 * 3;
  var_8 = anglesToForward(var_0.angles);
  var_9 = anglestoright(var_0.angles);
  var_10 = 0;
  var_11 = [var_6 + var_8 * 100, var_6 - var_8 * 100, var_6 + var_9 * 100, var_6 - var_9 * 100, var_6 + (var_8 + var_9) * 100, var_6 + (var_8 - var_9) * 100, var_6 + (var_9 - var_8) * 100, var_6 + (-1 * var_8 - var_9) * 100];

  if(level.gametype == "br" && level.airstrikedefaultside) {
    var_12 = vectorNormalize(var_11[2] - var_6);
  } else {
    var_12 = vectorNormalize(var_12[0] - var_7);
  }

  var_13 = 0;
  var_14 = 0;

  foreach(var_16 in var_12) {
    var_17 = vectorNormalize(var_16 - var_7);
    var_18 = var_7 + (0, 0, var_8) - var_17 * 25000;
    var_19 = [var_7, var_7 - var_17 * 512, var_7 - var_17 * 256, var_7 + var_17 * 256, var_7 + var_17 * 512];
    var_20 = 0;

    foreach(var_22 in var_19) {
      var_23 = scripts\engine\trace::ray_trace(var_18, var_22, undefined, var_5);
      var_24 = var_23["fraction"] == 1;

      if(level.gametype == "br" && level.airstrikeusescoring) {
        if(var_23["fraction"] > var_14) {
          var_12 = var_17;
          var_14 = var_23["fraction"];
        }
      }

      if(!istrue(var_24)) {
        wait 0.05;
        break;
      }

      var_20++;
      wait 0.05;
    }

    if(var_20 > var_13) {
      var_12 = var_17;
      var_13 = var_20;

      if(var_20 >= 3) {
        break;
      }
    }
  }

  return var_12;
}

function ref_144B7(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("air_strike_complete");
  var_1 waittill("disconnect");

  if(isDefined(var_0.player_waittilljumpedfromc130)) {
    var_0.player_waittilljumpedfromc130 delete();
  }

  ref_123AE(var_0);
}

function doplanestrike(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_7)) {
    return;
  }

  var_7 endon("disconnect");
  level endon("game_ended");
  var_9 = level.airstrikesettings[var_5.streakname];
  var_10 = getanimlength(var_6);
  var_11 = scripts\engine\utility::get_notetrack_time(var_6, "attack");
  var_12 = var_0 + (0, 0, var_3);
  var_13 = vectorNormalize(var_2 - var_1);
  var_14 = var_9.modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_7) && isDefined(var_9.modelbasealt)) {
    var_14 = var_9.modelbasealt;
  }

  var_15 = spawn("script_model", var_12);
  var_15 setModel(var_14);
  var_15.angles = vectortoangles(var_13);
  var_15.flightdir = var_13;
  var_15.flightheight = var_3;
  var_15.owner = var_7;
  var_16 = istrue(level.vehicle_collision_getleveldata) && isDefined(level.ref_14603) && level.ref_14603 == 6;
  var_17 = var_16 || istrue(var_5.brmini_ontimelimit);

  if(var_17) {
    var_15.team = "team_ninety_nine";
  } else {
    var_15.team = var_7.team;
  }

  var_15.lifeid = var_5.lifeid;
  var_15.streakinfo = var_5;
  var_15.brbonusxpallowed = var_8;

  if(!istrue(var_5.ref_133DE)) {
    var_15 setotherent(var_7);
  }

  var_15 scriptmoveroutline();
  var_15 scriptmoverthermal();
  var_15 scriptmoverplane();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_15[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_5.streakname, "Killstreak_Air", var_7, 0, 1, 100);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "challengeEvaluator")) {
    var_18 = spawnStruct();
    var_18.ref_123A1 = var_15;
    var_18.ref_13A8A = var_0;
    var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "challengeEvaluator")]]("br_mastery_pointBlank_airstrike", var_18);
  }

  var_19 = "icon_minimap_airstrike";

  if(var_5.streakname == "fuel_airstrike") {
    var_19 = "icon_minimap_fuelairstrike";
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_15.minimapid = var_15[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](var_19, var_15.team, undefined, 1, 1);
  }

  var_20 = var_11 - 0.75;
  var_21 = var_11;
  var_22 = 8.596;
  var_23 = var_20 + var_22;

  if(var_5.streakname == "fuel_airstrike") {
    var_20 = var_11 + 1;
  }

  if(!istrue(var_5.setuptimelimit)) {
    thread airstrike_playplaneattackfx(level, var_15, var_20);
  }

  if(istrue(var_5.ref_12186) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "overridePlayFlyFX")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "overridePlayFlyFX")]](var_15, var_1, var_13, var_21, var_22, var_10, var_5);
  } else {
    thread airstrike_playflyfx(level, var_15, var_1, var_13, var_21, var_22, var_10);
  }

  var_15.bulletpoint = spawn("script_model", var_15.origin);
  var_15.bulletpoint setModel("ks_airstrike_target_mp");

  if(scripts\cp_mp\utility\game_utility::ref_140AA()) {
    var_15.bulletpoint setModel("ks_airstrike_target_br_ch3");
  }

  var_15.bulletpoint setentityowner(var_7);
  var_15.bulletpoint.weapon_name = "artillery_mp";
  var_15.bulletpoint.streakinfo = var_5;
  var_15.bulletpoint.angles = var_15.angles;
  var_15.bulletpoint dontinterpolate();
  var_15.animname = var_5.streakname;
  var_15 scripts\common\anim::setanimtree();
  var_15.scenenode = spawn("script_model", var_12);
  var_15.scenenode.angles = var_15.angles;
  var_15.scenenode setModel("tag_origin");

  if(istrue(var_5.setuptimelimit)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "harmlessAirstrikeEffect")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "harmlessAirstrikeEffect")]](var_15, var_20, var_10, var_0, var_7);
    }
  } else if(var_5.streakname == "precision_airstrike" || var_5.streakname == "multi_airstrike") {
    thread callstrike_precisionbulleteffect(level, var_15, var_20, var_10, var_0, var_7);
  } else if(var_5.streakname == "fuel_airstrike") {}

  var_25 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";
  var_26 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "brtdm";
  thread ref_144B7(var_15, var_7);

  if(var_25 || var_26) {
    var_15.scenenode childthread scripts\common\anim::anim_single_solo(var_15, "airstrike_flyby");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "postAirstrikeAnim")) {
      var_15 childthread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "postAirstrikeAnim")]]();
    }

    wait var_23;
  } else {
    var_15.scenenode scripts\common\anim::anim_single_solo(var_15, "airstrike_flyby");
  }

  var_15 notify("air_strike_complete");
  ref_123AE(var_15);
}

function ref_123AE(var_0) {
  if(isDefined(var_0.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_0.minimapid);
    }
  }

  var_0 notify("delete");

  if(isDefined(var_0.turrettarget)) {
    var_0.turrettarget delete();
  }

  if(isDefined(var_0.bulletpoint)) {
    var_0.bulletpoint delete();

    if(isDefined(var_0.bulletpoint.killcament)) {
      var_0.bulletpoint.killcament delete();
    }
  }

  if(isDefined(var_0.scenenode)) {
    var_0.scenenode delete();
  }

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function airstrike_playplaneattackfx(var_0, var_1, var_2) {
  var_0 endon("death");
  level endon("game_ended");

  if(var_2.streakname == "fuel_airstrike") {
    return;
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  playsoundatpos(var_0.origin, "ks_a10_fire_dist_crack");
  var_0 setscriptablepartstate("fire", "on", 0);
  var_0 waittill("fire_finished");
  var_0 setscriptablepartstate("fire", "off", 0);
}

function airstrike_playflyfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  level endon("game_ended");
  thread airstrike_delayplayscriptable(var_0);
  var_0.player_waittilljumpedfromc130 = spawn("script_model", var_1);
  var_0.player_waittilljumpedfromc130 setModel("ks_airstrike_mp");

  if(scripts\cp_mp\utility\game_utility::ref_140AA()) {
    var_0.player_waittilljumpedfromc130 setModel("ks_airstrike_br_ch3");
  }

  var_0.player_waittilljumpedfromc130 dontinterpolate();
  thread airstrike_playapproachfx(var_0.player_waittilljumpedfromc130);
  thread airstrike_playflybyfx(var_0.player_waittilljumpedfromc130);
  thread airstrike_playflyoutfx(var_0.player_waittilljumpedfromc130);
  thread airstrike_handleflyoutfxdeath(var_0.player_waittilljumpedfromc130);
  thread branalytics_selfrevive(var_0.player_waittilljumpedfromc130);
}

function airstrike_playapproachfx(var_0) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setscriptablepartstate("approach", "on", 0);
}

function airstrike_playflybyfx(var_0) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setscriptablepartstate("flyby", "on", 0);
}

function airstrike_playflyoutfx(var_0) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setscriptablepartstate("flyout", "on", 0);
}

function airstrike_handleflyoutfxdeath(var_0) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0 + 10);
  self delete();
}

function branalytics_selfrevive(var_0) {
  self endon("death");
  self endon("stop_update_fx_movement");
  level endon("game_ended");

  while(isDefined(var_0)) {
    self.origin = var_0.origin;
    wait 0.05;
  }
}

function airstrike_watchkills(var_0, var_1) {
  self endon("disconnect");
  self notify("airstrike_watch_kills");
  self endon("airstrike_watch_kills");
  self.brattractions = 0;
  var_2 = "airstrike_finished_" + var_1;
  GscBinSkip4(0x35, var_2);
}

function airstrike_watchkillscount(var_0) {
  self endon(var_0);
  self.airstrikekillcount = 0;

  for(;;) {
    self waittill("update_rapid_kill_buffered", var_1, var_2);

    if(isDefined(var_2) && var_2 == "artillery_mp") {
      self.airstrikekillcount++;
    }
  }
}

function testsoundplacement(var_0) {
  var_0 endon("death");

  for(;;) {
    wait 0.05;
  }
}

function callstrike_precisionbulleteffect(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_6 = var_0.flightdir;
  var_7 = var_3 + (0, 0, var_0.flightheight + 750);
  var_8 = var_7 - var_6 * 15000;
  var_9 = var_7 - var_6 * 500;
  var_10 = var_7;
  var_11 = istrue(level.vehicle_collision_getleveldata) && isDefined(level.ref_14603) && level.ref_14603 == 6;

  if(!var_11) {
    var_12 = spawn("script_model", var_8);
    thread airstrike_killcammove(var_12, var_1 - 3, var_9);
    var_0.bulletpoint.killcament = var_12;
  }

  var_13 = [var_3 - var_6 * 512, var_3 - var_6 * 256, var_3, var_3 + var_6 * 256, var_3 + var_6 * 512];

  if(level.gametype == "br" && level.airstrikedangerfromsites) {
    foreach(var_15 in var_13) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayersInRange")) {
        var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayersInRange")]](var_15, level.airstrikedangerradius, var_5.streakname);
      }
    }
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  if(!isDefined(var_4)) {
    return;
  }

  var_17 = 5;
  var_18 = (0, 0, 0);
  var_19 = var_18;
  var_0.bulletpoint setscriptablepartstate("bullet_impact", "on", 0);
  var_20 = 0;
  var_21 = 0;

  foreach(var_15 in var_13) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "addSpawnDangerZone")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "addSpawnDangerZone")]](var_15, 512, 512, var_4.team, 5, var_4, 1);
    }
  }

  var_28 = var_3[2] + var_0.flightheight * 3;

  for(var_29 = 0; var_29 < var_17; var_29++) {
    var_30 = -50;
    var_31 = 150;

    while(var_20 < var_21 + 4) {
      var_32 = callstrike_getrandomshotoffset(var_30, var_31, var_13[var_29], var_0.angles);
      var_33 = var_0 gettagorigin("tag_turret_fx") * (1, 1, 0) + (0, 0, var_28) + var_6 * 1000;
      var_35 = vectorNormalize(var_32 - var_33);
      var_36 = var_32 + var_35 * 30000;
      var_37 = scripts\engine\trace::ray_trace(var_33, var_36, undefined, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
      var_38 = var_37["position"];
      var_39 = var_37["normal"];
      var_40 = var_38 + var_39 * 10;
      var_41 = vectorNormalize(var_38 - var_0 gettagorigin("tag_turret_fx"));
      var_42 = vectorcross(var_41, (0, 0, 1));
      var_43 = vectorcross(var_42, var_41);
      thread callstrike_playmultitracerfx(var_0, scripts\engine\utility::getfx("airstrike_tracer"), var_40, var_41);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("skyhook", "precision_airstrike_damage")) {
        level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("skyhook", "precision_airstrike_damage")]](var_37, var_0, var_4);
      }

      thread moveanddamagepoint(var_0.bulletpoint, var_20 + 1);
      var_19 = var_38;
      var_20++;
      var_0.bulletpoint.streakinfo.shots_fired++;
      var_30 += 20;
      var_31 += 40;
      var_28 -= 200;

      if(var_28 < var_0.flightheight) {
        var_28 = var_0.flightheight;
      }

      wait 0.05;
    }

    var_21 = var_20;
  }

  LOC_0000036d:
    var_0 notify("fire_finished");
  var_0.bulletpoint setscriptablepartstate("bullet_impact", "off", 0);
}

function callstrike_getrandomshotoffset(var_0, var_1, var_2, var_3) {
  var_3 *= (0, 1, 0);
  var_4 = anglesToForward(var_3);
  var_5 = anglestoright(var_3);
  var_6 = randomintrange(var_0, var_1);
  var_7 = randomint(80) - 40;
  var_8 = var_4 * cos(var_7) * var_6;
  return var_2 + var_8 + var_5 * sin(var_7) * var_6;
}

function callstrike_playmultitracerfx(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = 0;
  var_5 = 3;

  while(var_4 < var_5) {
    var_6 = randomintrange(25, 50);
    var_7 = randomintrange(25, 50);
    playFX(var_0, var_1 + (var_6, var_7, 0), var_2, var_3);
    var_4++;
    wait 0.05;
  }
}

function moveanddamagepoint(var_0, var_1) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.18);
  self.origin = var_1;
  self setscriptablepartstate("explode" + var_0, "active", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self setscriptablepartstate("explode" + var_0, "neutral", 0);
}

function callstrike_fuelbombeffect(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  if(!isDefined(var_4)) {
    return;
  }

  var_5 = var_0.flightdir;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "addSpawnDangerZone")]](var_3, 650, 650, var_4.team, var_2, var_4, 1);
  }

  var_7 = var_3 + (0, 0, 2500);
  var_8 = var_3 - (0, 0, 10000);
  var_9 = scripts\engine\trace::ray_trace(var_7, var_8, undefined, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
  var_10 = var_9["position"];
  var_11 = var_9["normal"];
  var_12 = var_10 + var_11 * 10;
  var_13 = spawn("script_model", var_12 + (0, 0, 400));
  var_13 setModel("ks_fuelstrike_mp");
  var_13 setscriptablepartstate("release", "on", 0);
  var_14 = spawn("script_model", var_12);
  var_14 setModel("ks_fuelstrike_mp");
  var_14 setscriptablepartstate("ignite", "on", 0);
  var_14 setentityowner(var_4);
  thread delaydeletefxents(level, var_13);
}

function delaydeletefxents(var_0, var_1) {
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);

  if(isDefined(var_0)) {
    var_0 delete();
  }

  if(isDefined(var_1)) {
    var_1 delete();
    return;
  }
}

function getflightpath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;

  if(istrue(var_8)) {
    var_9 = var_1;
  } else {
    var_9 = anglesToForward(var_1);
  }

  var_10 = var_0 + var_9 * -1 * var_2;

  if(isDefined(var_3)) {
    var_10 *= (1, 1, 0);
  }

  var_10 += (0, 0, var_4);
  var_11 = var_0 + var_9 * var_2;

  if(isDefined(var_3)) {
    var_11 *= (1, 1, 0);
  }

  var_11 += (0, 0, var_4);
  var_12 = length(var_10 - var_11);
  var_13 = var_12 / var_5;
  var_12 = abs(var_12 / 2 + var_6);
  var_14 = var_12 / var_5;
  GscBinSkip1(0x45, "startPoint", var_10);
}

function getexplodedistance(var_0) {
  var_1 = 850;
  var_2 = 1500;
  var_3 = var_1 / var_0;
  var_4 = var_3 * var_2;
  return var_4;
}

function airstrike_getownerlookatpos(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "aim_override")) {
    return var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "aim_override")]]();
  }

  var_2 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicleclip"];
  var_3 = physics_createcontents(var_2);
  var_4 = var_0 getvieworigin();
  var_5 = var_4 + anglesToForward(var_0 getplayerangles()) * 50000;
  var_6 = var_0 scripts\cp_mp\utility\killstreak_utility::ref_125F8();
  var_7 = scripts\engine\trace::ray_trace(var_4, var_5, var_6, var_3);
  var_8 = var_7["position"];

  if(var_7["hittype"] == "hittype_none") {
    var_8 = undefined;
  }

  return var_8;
}

function airstrike_watchforads(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("deploy_cancelled");
  self endon("deploy_fired");
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("ks_airstrike_marker_mp");

  if(scripts\cp_mp\utility\game_utility::ref_140AA()) {
    var_2 setModel("ks_airstrike_marker_br_ch3");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID")) {
    var_2.objidnum = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
  }

  var_2 setotherent(self);
  var_2 dontinterpolate();
  var_2 hide();
  var_3 = scripts\cp_mp\utility\script_utility::ref_140DE("game", "isGameTypeBR", 0);

  if(var_3) {
    var_4 = "icon_waypoint_airstrike_ww2";
  } else {
    var_4 = "icon_waypoint_airstrike";
  }

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  airstrike_setmarkerobjective(var_3, var_3.objidnum, var_4, self, 50);
  thread branalytics_validation(var_3);
  thread airstrike_watchdeployended(var_3);
  thread branalytics_spawntablet(var_3);
  var_3.updatemarker = 0;
  scripts\common\utility::allow_fire(0);

  for(;;) {
    var_5 = self playerads();
    var_6 = var_5 == 1;
    var_7 = var_5 < 1;
    var_8 = scripts\cp_mp\emp_debuff::is_empd();
    var_9 = istrue(var_3.updatemarker);

    if(!var_9 && !var_8 && var_6) {
      scripts\common\utility::allow_fire(1);
      var_3 show();
      var_3 setscriptablepartstate("marker_scope", "on", 0);
      thread airstrike_updatemarkerpos(var_3);
      var_3.updatemarker = 1;
    } else if(var_9 && (var_7 || var_8)) {
      scripts\common\utility::allow_fire(0);
      var_3 hide();
      var_3 setscriptablepartstate("marker_scope", "off", 0);
      self notify("stop_update_marker");
      var_3.updatemarker = 0;
    }

    waitframe();
  }
}

function airstrike_setmarkerobjective(var_0, var_1, var_2, var_3) {
  objective_icon(var_0, var_1);
  objective_showtoplayersinmask(var_0);
  objective_addclienttomask(var_0, var_2);
  objective_onentity(var_0, self);
  objective_setzoffset(var_0, var_3);
  objective_setplayintro(var_0, 0);
  objective_setplayoutro(var_0, 0);
  objective_setbackground(var_0, 1);

  if(level.teambased) {
    objective_setownerteam(var_0, var_2.team);
  } else {
    objective_setownerclient(var_0, var_2);
  }

  objective_state(var_0, "done");
}

function airstrike_updatemarkerpos(var_0) {
  var_0 notify("stop_update_marker");
  var_0 endon("stop_update_marker");
  self endon("death");
  var_0 endon("deploy_cancelled");
  var_0 endon("deploy_fired");
  var_0 endon("death_or_disconnect");
  var_1 = 0;
  var_0 setclientomnvar("ui_spotter_scope_danger", 0);

  for(;;) {
    var_2 = airstrike_getownerlookatpos(var_0);
    var_3 = -1;
    var_4 = -1;
    var_5 = -1;
    var_6 = isDefined(var_2);

    if(var_6) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isPointInBounds")) {
        var_6 &= level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isPointInBounds")]](var_2);
      }
    }

    if(var_6) {
      self.origin = var_2;
      var_3 = int(self.origin[0]);
      var_4 = int(self.origin[1]);
      var_5 = int(self.origin[2]);
    }

    var_0 setclientomnvar("ui_ac130_coord3_posx", var_3);
    var_0 setclientomnvar("ui_ac130_coord3_posy", var_4);
    var_0 setclientomnvar("ui_ac130_coord3_posz", var_5);

    if(isDefined(var_2)) {
      if(!istrue(var_1) && distance2dsquared(var_0.origin, var_2) <= 1638400) {
        var_0 setclientomnvar("ui_spotter_scope_danger", 1);
        var_1 = 1;
      } else if(istrue(var_1) && distance2dsquared(var_0.origin, var_2) > 1638400) {
        var_0 setclientomnvar("ui_spotter_scope_danger", 0);
        var_1 = 0;
      }
    }

    waitframe();
  }
}

function branalytics_validation(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 waittill("death_or_disconnect");
  airstrike_removemarker();
}

function airstrike_watchdeployended(var_0) {
  var_0 endon("death_or_disconnect");
  self endon("death");
  level endon("game_ended");
  var_1 = var_0 scripts\engine\utility::ref_143AD("cancel_fire", "successful_fire");

  if(isDefined(var_1) && var_1 == "successful_fire") {
    var_0 notify("deploy_fired");
    self setscriptablepartstate("marker_scope", "off", 0);
    var_2 = anglesToForward(var_0 getplayerangles());
    var_3 = self.origin - var_2 * 500;
    var_4 = self.origin + var_2 * 20;
    var_5 = scripts\engine\trace::ray_trace(var_3, var_4, self);
    var_6 = var_5["normal"];
    self.angles = generateaxisanglesfromupvector(var_6, self.angles);
    self setscriptablepartstate("marker_placed", "on", 0);
    objective_state(self.objidnum, "current");
    thread airstrike_removemarker(7);
    return;
  }

  var_0 notify("deploy_cancelled");

  if(!var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerADS")]]()) {
    var_0 scripts\common\utility::allow_fire(1);
  }

  airstrike_removemarker();
}

function branalytics_spawntablet(var_0) {
  var_0 endon("death_or_disconnect");
  self endon("death");
  level endon("game_ended");
  var_1 = var_0 getcurrentweapon();

  for(;;) {
    if(var_0 getcurrentweapon() != var_1) {
      break;
    }

    waitframe();
  }

  var_0 notify("cancel_fire");
}

function airstrike_removemarker(var_0) {
  if(isDefined(var_0)) {
    self endon("death");
    level endon("game_ended");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  }

  if(isDefined(self.objidnum)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.objidnum);
    }
  }

  self delete();
}

function airstrike_delayplayscriptable(var_0) {
  self endon("death");
  level endon("game_ended");
  wait var_0;
  self setscriptablepartstate("bodyfx", "on", 0);
}

function airstrike_killcammove(var_0, var_1, var_2) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self moveTo(var_1, 4);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.95);
  self moveTo(var_2, 5);
}

function branalytics_teameliminated(var_0, var_1) {
  self endon("airstrike_finished_" + var_1);
  self endon("disconnect");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::ref_12AA7(var_0);
}

function branalytics_respawn(var_0, var_1) {
  level.brareloadoutdropbagsdelayed++;
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.owner = var_1;
  var_2.id = var_1.name + "_" + level.brareloadoutdropbagsdelayed;
  level.audio_heli_fade_up[var_2.id] = var_2;
  return var_2.id;
}

function branalytics_seteventdelayedstate(var_0, var_1) {
  level.audio_heli_fade_up = scripts\engine\utility::array_remove_index(level.audio_heli_fade_up, var_1, 1);

  if(isDefined(var_0)) {
    var_0 notify("airstrike_finished_" + var_1);
    return;
  }
}

function branalytics_secondwind(var_0) {
  var_1 = "success";
  var_2 = 625000000;

  if(isDefined(var_0)) {
    if(level.audio_heli_fade_up.size > 0) {
      var_3 = 1;
      var_4 = level.gametype == "br";

      if(var_4) {
        var_3 = 3;
      }

      if(level.audio_heli_fade_up.size >= var_3) {
        var_1 = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED";
      } else {
        foreach(var_6 in level.audio_heli_fade_up) {
          if(distance2dsquared(var_6.origin, var_0) <= var_2) {
            var_1 = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_AREA";
          }
        }
      }
    }
  } else {
    var_1 = "KILLSTREAKS/INVALID_POINT";
  }

  return var_1;
}

function game_end_watcher(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_5 = spawnStruct();
  var_5.streakname = "precision_airstrike";
  var_5.owner = var_4;
  var_5.score = 0;
  var_5.shots_fired = 0;
  var_5.hits = 0;
  var_5.damage = 0;
  var_5.kills = 0;
  var_5.setuptimelimit = istrue(var_1);
  var_5.brmini_ontimelimit = istrue(var_2);
  var_6 = var_3;
  var_7 = undefined;
  var_8 = % mp_alfa10_flyin;

  if(scripts\cp_mp\utility\game_utility::ref_140AA()) {
    var_8 = % mp_alfa10_flyin_br;
  }

  var_9 = undefined;
  thread callstrike(level, var_4, var_0, var_6, var_7, var_5, var_8);
}