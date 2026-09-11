/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\white_phosphorus.gsc
**********************************************************/

function init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "init")]]();
  }

  level._effect["white_phosphorus_inair_explosion"] = loadfx("vfx/iw8_mp/killstreak/vfx_white_phosphorus_expl_inair.vfx");
  level._effect["white_phosphorus_screen"] = loadfx("vfx/iw8_mp/killstreak/vfx_white_phosphorus_screen.vfx");
  level.activewpzones = [];
  level.activewpinnerzones = [];
  level.white_phosphorus_damage_area = getEnt("white_phosphorus_damage", "targetname");
}

function weapongivenwp(var_0) {
  if(istrue(level.wpinprogress)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/WP_ACTIVE");
    }

    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "startMapSelectSequence")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "startMapSelectSequence")]](0, 1, 1);
  }

  return true;
}

function tryusewp() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("white_phosphorus", self);
  return tryusewpfromstruct(var_0);
}

function tryusewpfromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  var_1 = getcompleteweaponname("ks_remote_map_mp");
  var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, var_1, 1, &weapongivenwp);

  if(!istrue(var_2)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return false;
    }
  }

  var_3 = wp_getmapselectioninfo(var_0, 1, 1);

  if(!isDefined(var_3)) {
    return false;
  }

  thread wp_startdeploy(var_3, var_0);
  var_4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    var_4 = 2;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_0.streakname, 1, var_4);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("white_phosphorus", self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_white_phosphorus", self);
  }

  return true;
}

function wp_getmapselectioninfo(var_0, var_1, var_2) {
  scripts\common\utility::allow_weapon_switch(0);
  self setsoundsubmix("mp_killstreak_overlay");
  var_3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "getSelectMapPoint")) {
    var_3 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "getSelectMapPoint")]](var_0, var_1, var_2);
  }

  if(!isDefined(var_3)) {
    scripts\common\utility::allow_weapon_switch(1);
    self clearsoundsubmix("mp_killstreak_overlay");
    return undefined;
  }

  scripts\common\utility::allow_weapon_switch(1);
  self clearsoundsubmix("mp_killstreak_overlay");
  return var_3;
}

function wp_startdeploy(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");

  if(istrue(level.wpinprogress)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/WP_ACTIVE");
    }

    return 0;
  }

  level.wpinprogress = 1;

  foreach(var_3 in var_0) {
    var_4 = var_3.location;
    var_5 = var_3.angles;
    wp_finishdeployment(var_4, var_5, var_1);

    if(var_0.size > 1 && var_6 < var_0.size - 1) {
      wait randomfloatrange(1, 3);
    }
  }
}

function wp_finishdeployment(var_0, var_1, var_2) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  thread ref_145e6("disconnect");
  thread ref_145e6("joined_team");
  thread ref_145e6("joined_spectator");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  var_3 = wp_createplane(var_0, var_1, var_2);

  if(!isDefined(var_3)) {
    return 0;
  }

  thread ref_145ea();
  thread wp_deliverpayloads(var_3);
}

function wp_createplane(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_4 = 28000;
  var_5 = 5000;
  var_6 = 2500;
  var_7 = 1500;
  var_8 = (0, var_1, 0);

  if(!isDefined(var_3)) {
    var_6 += 3000;
  } else {
    var_6 = var_3.origin[2] + 3000;
    var_7 = scripts\cp_mp\killstreaks\airstrike::getexplodedistance(var_6);
  }

  var_9 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var_0, var_8, var_4, var_3, var_6, var_5, var_7);
  var_10 = spawn("script_model", var_9["startPoint"]);
  var_10.angles = var_8;
  var_10.flightpath = var_9;
  var_10.owner = self;
  var_10.team = self.team;
  var_10.streakinfo = var_2;
  var_10.speed = var_5;
  var_11 = "veh8_mil_air_suniform25_west";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(self)) {
    var_11 = "veh8_mil_air_suniform25";
  }

  var_10 setModel(var_11);
  var_12 = undefined;
  var_13 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_13 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective");
  }

  if(isDefined(var_13)) {
    var_12 = var_10[[var_13]]("icon_minimap_wp", var_10.team, 1, 1, 1);
    var_10.minimapid = var_12;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_10[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_10.streakinfo.streakname, "Killstreak_Air", self);
  }

  return var_10;
}

function ref_145e6(var_0, var_1) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  self waittill(var_0);
  level.wpinprogress = undefined;
  level notify("white_phosphorus_end");
}

function ref_145ea() {
  self endon("death");
  level waittill("white_phosphorus_end");
  wp_removeplane(self);
}

function ref_145e8() {
  self endon("death");
  level waittill("white_phosphorus_end");

  if(ref_145e3("smoke", self)) {
    wp_removefromactivewplist(level, "smoke", self);
    return;
  }

  var_0 = 0;

  if(var_0) {
    self freescriptable();
    return;
  }

  self delete();
}

function ref_145e7(var_0) {
  self endon("death");
  level waittill("white_phosphorus_end");

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(ref_145e3("inner", self)) {
    wp_removefromactivewplist(level, "inner", self, var_0, 1);
  }

  self notify("stop_wp_status_effect");
  var_1 = 0;

  if(var_1) {
    self freescriptable();
    return;
  }

  self delete();
}

function wp_deliverpayloads(var_0) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_1 = self.flightpath["startPoint"];
  var_2 = self.flightpath["endPoint"];
  var_3 = self.flightpath["flyTime"];
  var_4 = var_1 + anglesToForward(self.angles) * 12500;
  var_5 = var_2 - anglesToForward(self.angles) * 12500;
  var_6 = length(var_4 - var_5);
  var_7 = 30;
  thread wp_watchend(self.owner, var_0);
  thread ref_145e9(self.owner);
  self moveTo(var_2, var_3);
  self setscriptablepartstate("bodyFX", "on", 0);
  self scriptmodelplayanim("mp_suniform25_flyin");
  thread wp_enterpayloadaudio();
  thread wp_exitpayloadaudio(var_2, var_3);
  var_9 = 3;
  wp_handlepayloadtyperelease(&wp_fireairburst, var_1, var_4, var_6, var_7, 4000, var_9, 1);
  wp_handlepayloadtyperelease(&wp_firesmoke, var_1, var_4, var_6, var_7, 4000, 3, 1);
  wp_handlepayloadtyperelease(&wp_fireflaregroup, var_1, var_4, var_6, var_7, 2000, 6, 2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_3);
  self stopsounds();
  self scriptmodelplayanimdeltamotion("mp_suniform25_exit");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5.33);
  wp_removeplane(self);
}

function wp_watchend(var_0, var_1) {
  self endon("disconnect");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  self notify("white_phosphorus_finished");
  scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var_0);
}

function ref_145e9(var_0) {
  self endon("disconnect");
  self endon("white_phosphorus_finished");
  level endon("white_phosphorus_end");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var_0);
}

function wp_enterpayloadaudio() {
  self endon("death");
  level endon("white_phosphorus_end");
  waitframe();
  self playsoundonmovingent("iw8_mp_white_phos_su25_flyby");
}

function wp_exitpayloadaudio(var_0, var_1) {
  self endon("death");
  level endon("white_phosphorus_end");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  playsoundatpos(var_0, "iw8_mp_white_phos_su25_exit");
}

function wp_watchunsuccessfulzones(var_0) {
  level endon("wp_zone_succeeded");
  level endon("game_ended");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level waittill("wp_zone_failed");
  }

  level.wpinprogress = undefined;
}

function wp_handlepayloadtyperelease(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = int(var_3 / var_5);
  var_9 = 0;

  if(!isDefined(var_6)) {
    var_6 = var_8;
  } else {
    var_10 = var_8 - var_6;
    var_9 = int(var_10 / 2);
  }

  if(isDefined(var_7)) {
    var_9 += var_7;
  }

  var_11 = anglesToForward(self.angles);
  var_12 = var_2;
  var_13 = 0;

  for(var_14 = 0; var_14 < var_8; var_14++) {
    var_15 = length(var_1 - var_12) / self.speed;

    if(var_14 < var_9) {
      var_12 += var_11 * var_5;
      goto LOC_0000010a;
    }

    var_16 = var_12 - (0, 0, 2000);

    if(var_0 == &wp_fireflaregroup) {
      var_17 = spawn("script_model", var_1 + (0, 0, 1500));
      thread wp_movekillcam(var_17, var_15, var_16, var_11);
      self thread[[var_0]](var_16, var_11, var_15, var_17);
    } else if(var_0 == &wp_firesmoke) {
      self thread[[var_0]](var_16, var_11, var_15, var_14);
    } else {
      self thread[[var_0]](var_16, var_11, var_15);
    }

    var_12 += var_11 * var_5;
    var_13++;
  }
}

function wp_movekillcam(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_1 -= var_2 * 3500;
  var_4 = var_1 - var_2 * 1000;
  self moveTo(var_1, var_0 + 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0 + 2);
  self moveTo(var_4, 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_3);
  self delete();
}

function wp_testpayloads(var_0, var_1, var_2) {
  self endon("death");
}

function wp_fireairburst(var_0, var_1, var_2) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_3 = var_0 - var_1 * 3000;
  var_4 = var_0 - var_1 * 2000;
  var_5 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  playFX(scripts\engine\utility::getfx("white_phosphorus_inair_explosion"), var_3, var_1);
  playsoundatpos(var_4, "iw8_mp_white_phos_midair_explo");
}

function wp_firesmoke(var_0, var_1, var_2, var_3) {
  level endon("white_phosphorus_end");
  level endon("game_ended");

  if(!isDefined(self.playersininitialsmokerange)) {
    self.playersininitialsmokerange = [];
  }

  if(!isDefined(self.playersoutsideinitialsmokerange)) {
    self.playersoutsideinitialsmokerange = [];
  }

  var_4 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype != "arm") {
    var_4 = 0;
  }

  var_5 = scripts\engine\trace::ray_trace(var_0, var_0 - (0, 0, 10000));
  var_6 = var_5["position"];
  var_7 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  var_9 = 0;

  if(var_9) {
    var_10 = easepower("ks_white_phosphorus_mp_p", var_6, self.angles);
  } else {
    var_10 = spawn("script_model", var_7);
    var_10 setModel("ks_white_phosphorus_mp");
    var_10 setentityowner(self.owner);
  }

  var_10.team = self.team;
  var_10.owner = self.owner;
  var_10.streakinfo = self.streakinfo;
  thread ref_145e8();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  thread ref_145e5(level);

  if(istrue(var_5)) {
    var_11 = isDefined(var_4) && var_4 == 3;

    if(istrue(var_11)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.5);
      self.playersininitialsmokerange = scripts\common\utility::playersincylinder(var_7, 2000);
      self.playersoutsideinitialsmokerange = scripts\engine\utility::array_difference(level.players, self.playersininitialsmokerange);
      thread wp_watchdisorienteffect(var_10, 2000, self.playersininitialsmokerange);
    }
  } else {
    if(scripts\cp_mp\utility\game_utility::isnightmap() || scripts\cp_mp\utility\game_utility::update_operator_west_char_loc()) {
      var_10 setscriptablepartstate("smoke_night", "on", 0);
    } else {
      var_10 setscriptablepartstate("smoke", "on", 0);
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.5);
    thread wp_watchdisorienteffect(var_10, 2000);
  }

  wp_addtoactivewplist(level, "smoke", var_10);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_9);
  wp_removefromactivewplist(level, "smoke", var_10);
}

function wp_fireflaregroup(var_0, var_1, var_2, var_3) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_4 = self.owner;
  var_5 = self.team;
  var_6 = self.angles;
  var_7 = scripts\engine\trace::ray_trace(var_0, var_0 - (0, 0, 10000), self, undefined, 1, 1);
  var_8 = var_7["position"];
  var_9 = var_7["surfacetype"];
  var_10 = isDefined(level.white_phosphorus_damage_area);

  if(istrue(var_10)) {
    level.white_phosphorus_damage_area dontinterpolate();
    level.white_phosphorus_damage_area.owner = var_4;
    level.white_phosphorus_damage_area.team = var_5;
    level.white_phosphorus_damage_area.streakinfo = self.streakinfo;
  }

  var_11 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  var_12 = wp_getflarepositions(var_0, var_8, 4, int(250));

  foreach(var_14 in var_12) {
    var_15 = 0;

    if(var_15) {
      var_16 = easepower("ks_white_phosphorus_mp_p", var_14.flareorigin, var_6);
    } else {
      var_16 = spawn("script_model", var_14.flareorigin);
      var_16 setModel("ks_white_phosphorus_mp");
      var_16 setentityowner(var_4);
      var_16.angles = var_6;
    }

    var_16.owner = var_4;
    var_16.team = var_5;
    var_16.streakinfo = self.streakinfo;
    var_16.struct = var_14;
    var_16.weapon_name = "white_phosphorus_proj_mp";
    var_16.killcament = var_3;
    thread ref_145e7(var_16);
    thread wp_projwatchimpact(var_16, var_11, "burn");
    wait randomfloatrange(0.1, 0.4);
  }

  if(istrue(var_10)) {
    level.white_phosphorus_damage_area.origin = (0, 0, 50000);
    return;
  }
}

function wp_getflarepositions(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = self.angles * (0, 1, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
  var_9 = physics_createcontents(var_8);
  var_10 = -2000;
  var_11 = 0;

  for(var_12 = 0; var_12 < var_2; var_12++) {
    var_13 = var_6 * var_10 + var_7 * var_11;
    var_14 = var_1 + var_6 * var_10;
    var_15 = var_1 + var_13;
    var_16 = scripts\engine\trace::ray_trace(var_15 + (0, 0, var_0[2]), var_15 - (0, 0, 10000), level.characters, var_9);
    var_17 = var_16["position"];
    var_18 = var_1 * (1, 1, 0) + (0, 0, var_17[2]) + var_6 * var_10;
    var_19 = spawnStruct();
    var_19.damageorigin = var_18;
    var_19.flareorigin = var_17;
    var_4 = var_19;
    var_10 += 500;
    var_11 = randomintrange(-750, 750);
  }

  return var_4;
}

function wp_projwatchimpact(var_0, var_1, var_2) {
  self endon("death");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2.5);
  self.projimpacted = 1;
  wp_addtoactivewplist(level, "inner", self);
  self setscriptablepartstate("impact", "on", 0);

  if(isDefined(var_2) && var_2 == "surftype_water") {
    self setscriptablepartstate("flare_death_water", "on", 0);
  } else {
    self setscriptablepartstate("flare", "on", 0);
  }

  var_3 = self.struct.damageorigin + (0, 0, 10);

  if(isDefined(self.owner)) {
    self radiusdamage(var_3, 512, 500, 500, self.owner, "MOD_EXPLOSIVE", "white_phosphorus_proj_mp");
  }

  if(isDefined(var_2) && var_2 != "surftype_water") {
    if(isDefined(var_1)) {
      self.killcament = spawn("script_model", self.origin + (0, 0, 100));

      if(var_1 == "burn") {
        thread wp_watchburneffect(300);
      } else {
        thread wp_watchblindeffect(300);
      }

      if(!scripts\common\utility::iscp()) {
        scripts\cp_mp\utility\killstreak_utility::killstreak_createdangerzone(self.origin, 300, 300, var_0, self.owner, self.team);
        thread ref_145e2();
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
    wp_removefromactivewplist(level, "inner", self, var_1, 1);
    self notify("stop_wp_status_effect");
    self setscriptablepartstate("flare", "off", 0);
    self setscriptablepartstate("flare_death", "on", 0);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  thread ref_145e1(15);
}

function ref_145e2() {
  level endon("game_ended");
  var_0 = self.dangerzoneid;
  self waittill("death");
  scripts\cp_mp\utility\killstreak_utility::killstreak_destroydangerzone(var_0);
}

function ref_145e1(var_0) {
  self endon("death");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var_1 = 0;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  if(var_1) {
    self freescriptable();
    return;
  }

  self delete();
}

function wp_watchdisorienteffect(var_0, var_1, var_2) {
  self endon("death");
  self.playersindisorientradius = [];
  jumpiffalse(isDefined(var_1) && isDefined(var_2)) LOC_0000003a;
  thread wp_delaydisorientplayersinrange(0.15, 2000, var_1);
  thread wp_delaydisorientplayersinrange(0.25, undefined, var_2);
  return;
}

function wp_getplayerswithinrange(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(distance2dsquared(self.origin, var_4.origin) <= var_1 * var_1) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function wp_delaydisorientplayersinrange(var_0, var_1, var_2) {
  self endon("death");

  if(isDefined(var_0) && var_0 > 0) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  }

  var_3 = var_2;

  if(isDefined(var_1) && var_1 > 0) {
    var_3 = wp_getplayerswithinrange(var_2, var_1);
  }

  foreach(var_5 in var_3) {
    if(var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
      wp_addplayertostatusradiuslist("smoke", var_5);

      if(!istrue(var_5.wpdisorient)) {
        thread wp_startdisorientplayer(var_5);
      }
    }

    thread wp_startdisorientplayeronspawn(var_5);
  }
}

function wp_watchburneffect(var_0) {
  self endon("stop_wp_status_effect");
  self endon("death");
  self.playersininnerradius = [];

  for(;;) {
    foreach(var_2 in level.players) {
      if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(distance2d(self.origin, var_2.origin) <= var_0 && scripts\engine\trace::ray_trace_passed(var_2 getEye(), self.origin + (0, 0, 30), var_2)) {
        if(!istrue(var_2.wpburning)) {
          thread wp_startburnplayer(var_2, self);
        }

        continue;
      }

      if(istrue(var_2.wpburning) && wp_isinwpzone("inner", var_2, self)) {
        wp_stopburnplayer(var_2, self);
      }
    }

    waitframe();
  }
}

function wp_watchblindeffect(var_0) {
  self endon("stop_wp_status_effect");
  self endon("death");
  self.playersininnerradius = [];

  for(;;) {
    foreach(var_2 in level.players) {
      if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(distance2d(self.origin, var_2.origin) <= var_0 && scripts\engine\trace::ray_trace_passed(var_2 getEye(), self.origin + (0, 0, 30), var_2)) {
        if(!istrue(var_2.wpblinding)) {
          wp_startblindplayer(var_2, self);
        }

        continue;
      }

      if(istrue(var_2.wpblinding) && wp_isinwpzone("inner", var_2, self)) {
        wp_stopblindplayer(var_2, self);
      }
    }

    waitframe();
  }
}

function wp_addtoactivewplist(var_0, var_1) {
  if(var_0 == "smoke") {
    level.activewpzones[level.activewpzones.size] = var_1;
    return;
  }

  level.activewpinnerzones[level.activewpinnerzones.size] = var_1;
}

function ref_145e3(var_0, var_1) {
  var_2 = 0;
  jumpiffalse(var_0 == "smoke") LOC_0000004c;

  foreach(var_4 in level.activewpzones) {
    if(var_4 == var_1) {
      var_2 = 1;
      break;
    }
  }

  goto LOC_00000082;
}

function wp_removefromactivewplist(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    return;
  }

  var_4 = [];
  jumpiffalse(var_0 == "smoke") LOC_000000bf;

  foreach(var_6 in level.activewpzones) {
    if(var_6 == var_1) {
      continue;
    }

    var_4 = var_6;
  }

  level.activewpzones = var_4;

  if(isDefined(var_1.playersindisorientradius)) {
    foreach(var_9 in var_1.playersindisorientradius) {
      if(isDefined(var_9) && !wp_isinanywpzone("smoke", var_9)) {
        thread wp_stopdisorientplayer(var_9);
      }
    }
  }

  if(level.activewpzones.size <= 0) {
    level.wpinprogress = undefined;
  }

  goto LOC_00000168;
}

function wp_isinanywpzone(var_0, var_1) {
  var_2 = 0;
  jumpiffalse(var_0 == "smoke") LOC_00000051;

  foreach(var_4 in level.activewpzones) {
    if(wp_isinwpzone(var_0, var_1, var_4)) {
      var_2 = 1;
      break;
    }
  }

  goto LOC_0000008c;
}

function wp_isinwpzone(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = undefined;

  if(var_0 == "smoke") {
    var_4 = var_2.playersindisorientradius;
  } else {
    var_4 = var_2.playersininnerradius;
  }

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      if(var_6 == var_1) {
        var_3 = 1;
        break;
      }
    }
  }

  return var_3;
}

function wp_addplayertostatusradiuslist(var_0, var_1) {
  if(var_0 == "smoke") {
    self.playersindisorientradius[self.playersindisorientradius.size] = var_1;
    return;
  }

  self.playersininnerradius[self.playersininnerradius.size] = var_1;
}

function wp_removeplayerfromstatusradiuslist(var_0, var_1) {
  if(var_0 == "smoke") {
    var_2 = [];

    foreach(var_4 in self.playersindisorientradius) {
      if(var_4 == var_1) {
        continue;
      }

      var_2 = var_4;
    }

    self.playersindisorientradius = var_2;
    return;
  }

  var_2 = [];

  foreach(var_4 in self.playersininnerradius) {
    if(var_4 == var_4) {
      continue;
    }

    var_2 = var_4;
  }

  self.playersininnerradius = var_2;
}

function wp_removeplayerfromallstatusradiuslists(var_0, var_1) {
  jumpiffalse(var_0 == "smoke") LOC_0000004a;

  foreach(var_3 in level.activewpzones) {
    if(wp_isinwpzone(var_0, var_1, var_3)) {
      wp_removeplayerfromstatusradiuslist(var_3, var_0, var_1);
    }
  }

  return;
}

function wp_startdisorientplayeronspawn(var_0) {
  var_0 endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("spawned_player");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    wp_addplayertostatusradiuslist(var_0, "smoke", self);
    thread wp_startdisorientplayer(var_0);
  }
}

function wp_startdisorientplayer(var_0) {
  var_0 endon("death");
  self endon("death_or_disconnect");
  self endon("stop_disorient");
  level endon("game_ended");
  self.wpdisorient = 1;

  while(isDefined(self.sessionstate) && self.sessionstate != "playing") {
    waitframe();
  }

  thread wp_stopdisorientonplayerdeath(var_0);
  thread wp_monitorsmokevisionset(var_0);
  playfxontagforclients(scripts\engine\utility::getfx("white_phosphorus_screen"), self, "tag_eye", self);

  if(level.teambased && self.team == var_0.team || self == var_0.owner) {
    var_1 = 1;

    if(istrue(var_1)) {
      return;
    }
  }

  self.wphealthblock = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_block_health_regen");
  }

  if(self.health > 10) {
    var_3 = wp_gethealthdebuffamount();
    wp_degenhealth(var_3, var_0);
  }

  if(!wp_hasresistperk()) {
    enableloopingcoughaudio();
    return;
  }
}

function wp_degenhealth(var_0, var_1) {
  if(istrue(self.gasmaskequipped)) {
    return;
  }

  if(!isDefined(self.wphealthblock)) {
    self.wphealthblock = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_block_health_regen");
    }
  }

  self dodamage(var_0, self.origin, var_1.owner, var_1, "MOD_EXPLOSIVE", "white_phosphorus_proj_mp");
}

function wp_startdofshiftforplayer(var_0) {
  var_0 endon("death");
  self endon("death");
  level endon("game_ended");

  while(istrue(self.wpdisorient)) {
    wait randomfloatrange(1, 3);
  }
}

function wp_stopdisorientonplayerdeath(var_0) {
  var_0 endon("death");
  self endon("stop_disorient");
  level endon("game_ended");
  self waittill("death");
  wp_stopdisorientplayer(var_0, 1);
}

function wp_stopdisorientplayer(var_0, var_1) {
  level endon("game_ended");

  if(istrue(var_1)) {
    wp_removeplayerfromallstatusradiuslists(level, "smoke", self);
  } else {
    wp_removeplayerfromstatusradiuslist(var_0, "smoke", self);
  }

  if(!wp_isinanywpzone("smoke", self) || istrue(var_1)) {
    if(istrue(self.wpdisorient)) {
      self.wpdisorient = undefined;

      if(scripts\cp_mp\utility\player_utility::_isalive()) {
        scripts\mp\utility\player::ref_12cc5(2);
      }

      stopfxontagforclients(scripts\engine\utility::getfx("white_phosphorus_screen"), self, "tag_eye", self);

      if(istrue(self.wphealthblock)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_block_health_regen");
        }

        self.wphealthblock = undefined;
      }

      disableloopingcoughaudio();
      self notify("stop_disorient");
      return;
    }

    return;
  }
}

function wp_startburnplayer(var_0, var_1) {
  var_0 endon("death");
  self endon("stop_wp_burn");
  self endon("death");
  level endon("game_ended");

  if(level.teambased && self.team == var_0.team && self != var_0.owner) {
    var_2 = 1;

    if(istrue(var_2)) {
      return;
    }
  }

  wp_addplayertostatusradiuslist(var_0, "inner", self);
  self.wpburning = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "enableBurnFX")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "enableBurnFX")]](undefined, "wp_active");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "enqueueCorpsetableFunc")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "enqueueCorpsetableFunc")]]("white_phosphorus_burning", &wp_playcorpsetableburningfx);
  }

  thread wp_stopstatuseffectondeath(var_0);
  var_4 = 10;

  for(;;) {
    if(self.health <= var_4) {
      self notify("stop_degen");
    }

    self dodamage(var_4, self.origin, var_1, var_0, "MOD_FIRE", var_0.weapon_name);
    wait 0.5;
    var_4++;

    if(var_4 >= 20) {
      var_4 = 20;
    }

    self.lastburntime = gettime();
  }
}

function wp_stopburnplayer(var_0) {
  wp_removeplayerfromstatusradiuslist(var_0, "inner", self);

  if(!wp_isinanywpzone("inner", self)) {
    wp_resetstatuseffect();
    self notify("stop_wp_burn");
    return;
  }
}

function wp_startblindplayer(var_0) {
  if(level.teambased && self.team == var_0.team || self == var_0.owner) {
    var_1 = 1;

    if(istrue(var_1)) {
      return;
    }
  }

  wp_addplayertostatusradiuslist(var_0, "inner", self);
  self.wpblinding = 1;
  thread wp_stopstatuseffectondeath(var_0);
  self visionsetnakedforplayer("wp_flare", 1);
}

function wp_stopblindplayer(var_0) {
  wp_removeplayerfromstatusradiuslist(var_0, "inner", self);

  if(!wp_isinanywpzone("inner", self)) {
    wp_resetstatuseffect();
    return;
  }
}

function wp_stopstatuseffectondeath(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  wp_resetstatuseffect(1);
}

function wp_resetstatuseffect(var_0) {
  if(istrue(self.wpburning)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "disableBurnFX")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "disableBurnFX")]](undefined, "wp_active");
    }

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "dequeueCorpsetableFunc")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "dequeueCorpsetableFunc")]]("white_phosphorus_burning");
      }
    }

    self.wpburning = undefined;
  }

  if(istrue(self.wpblinding)) {
    self.wpblinding = undefined;

    if(wp_isinanywpzone("smoke", self)) {
      self visionsetnakedforplayer(wp_getsmokevisionset(), 1);
    } else {
      scripts\mp\utility\player::ref_12cc5(1);
    }
  }

  if(istrue(var_0)) {
    wp_removeplayerfromallstatusradiuslists(level, "inner", self);
    return;
  }
}

function wp_removeplane(var_0) {
  if(isDefined(var_0.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_0.minimapid);
    }

    var_0.minimapid = undefined;
  }

  var_0 delete();
}

function wp_getsmokevisionset() {
  var_0 = "wp_smoke";
  var_1 = "wp_smoke_night";
  var_2 = var_0;

  if(scripts\cp_mp\utility\game_utility::isnightmap() || scripts\cp_mp\utility\game_utility::update_operator_west_char_loc()) {
    var_2 = var_1;
  }

  return var_2;
}

function wp_monitorsmokevisionset(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  self endon("stop_disorient");
  self endon("death");
  level endon("game_ended");
  var_1 = undefined;

  for(;;) {
    if(istrue(self.wpdisorient)) {
      var_2 = wp_getsmokevisionset();

      if(!isDefined(var_1) || var_2 != var_1) {
        var_1 = var_2;
        self visionsetnakedforplayer(var_2, 2);
      }
    }

    waitframe();
  }
}

function wp_gethealthdebuffamount() {
  var_0 = 50;

  if(wp_hasresistperk()) {
    var_0 *= 0.5;
  }

  var_1 = self.health;
  var_2 = var_1 - var_0;

  if(var_2 < 10) {
    var_0 -= 10 - var_2;
  }

  return var_0;
}

function wp_playcorpsetableburningfx(var_0) {
  var_0 setscriptablepartstate("wp_burning", "flareUp", 0);
}

function wp_hasresistperk() {
  return isDefined(self.perks) && isDefined(self.perks["specialty_tac_resist"]);
}

function enableloopingcoughaudio() {
  if(!isDefined(self.loopingcoughaudio)) {
    self.loopingcoughaudio = 0;
  }

  self.loopingcoughaudio++;

  if(self.loopingcoughaudio == 1) {
    thread startloopingcoughaudio();
    return;
  }
}

function disableloopingcoughaudio() {
  if(!isDefined(self.loopingcoughaudio)) {
    return;
  }

  self.loopingcoughaudio--;

  if(self.loopingcoughaudio == 0) {
    thread stoploopingcoughaudio();
    self.loopingcoughaudio = undefined;
    return;
  }
}

function startloopingcoughaudio() {
  self endon("death_or_disconnect");
  self endon("clearLoopingCoughAudio");
  level endon("game_ended");

  for(;;) {
    var_0 = randomfloatrange(4, 7);

    if(!loopingcoughaudioissupressed() && isDefined(self.operatorcustomization)) {
      var_1 = "generic_cough_3_enemy_1";

      if(self.team == "allies") {
        if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
          var_2 = game["dialogue"]["allies_female_cough"].size;
          var_3 = randomint(var_2);
          var_1 = game["dialogue"]["allies_female_cough"][var_3];
        } else {
          var_2 = game["dialogue"]["allies_male_cough"].size;
          var_3 = randomint(var_2);
          var_3 = game["dialogue"]["allies_male_cough"][var_3];
        }
      } else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
        var_2 = game["dialogue"]["axis_female_cough"].size;
        var_3 = randomint(var_2);
        var_3 = game["dialogue"]["axis_female_cough"][var_3];
      } else {
        var_2 = game["dialogue"]["axis_male_cough"].size;
        var_3 = randomint(var_2);
        var_3 = game["dialogue"]["axis_male_cough"][var_3];
      }

      if(!isai(self)) {
        self playsoundtoplayer("gas_player_cough", self, self);
      }

      if(istrue(self.loopingcoughaudio)) {
        self playsoundonmovingent(var_3);
      }
    }

    wait var_2;
  }
}

function stoploopingcoughaudio() {
  self notify("clearLoopingCoughAudio");
}

function enableloopingcoughaudiosupression() {
  if(!isDefined(self.loopingcoughaudiosupression)) {
    self.loopingcoughaudiosupression = 0;
  }

  self.loopingcoughaudiosupression++;
}

function disableloopingcoughaudiosupression() {
  if(!isDefined(self.loopingcoughaudiosupression)) {
    return;
  }

  self.loopingcoughaudiosupression--;
}

function loopingcoughaudioissupressed() {
  return isDefined(self.loopingcoughaudiosupression) && self.loopingcoughaudiosupression > 0;
}

function clearloopingcoughaudio() {
  self notify("clearLoopingCoughAudio");
  self.loopingcoughaudio = undefined;
  self.loopingcoughaudiosupression = undefined;
}

function ref_145e5(var_0) {
  var_0 setscriptablepartstate("impact_center", "on", 0);
  waitframe();
  var_0 setscriptablepartstate("impact_center", "off", 0);
}