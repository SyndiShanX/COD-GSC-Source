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

function weapongivenwp(var0) {
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
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("white_phosphorus", self);
  return tryusewpfromstruct(var0);
}

function tryusewpfromstruct(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return false;
    }
  }

  var1 = getcompleteweaponname("ks_remote_map_mp");
  var2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var0, var1, 1, &weapongivenwp);

  if(!istrue(var2)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      return false;
    }
  }

  var3 = wp_getmapselectioninfo(var0, 1, 1);

  if(!isDefined(var3)) {
    return false;
  }

  thread wp_startdeploy(var3, var0);
  var4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var0.streakname);
    var4 = 2;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var0.streakname, 1, var4);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("white_phosphorus", self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_white_phosphorus", self);
  }

  return true;
}

function wp_getmapselectioninfo(var0, var1, var2) {
  scripts\common\utility::allow_weapon_switch(0);
  self setsoundsubmix("mp_killstreak_overlay");
  var3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("white_phosphorus", "getSelectMapPoint")) {
    var3 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("white_phosphorus", "getSelectMapPoint")]](var0, var1, var2);
  }

  if(!isDefined(var3)) {
    scripts\common\utility::allow_weapon_switch(1);
    self clearsoundsubmix("mp_killstreak_overlay");
    return undefined;
  }

  scripts\common\utility::allow_weapon_switch(1);
  self clearsoundsubmix("mp_killstreak_overlay");
  return var3;
}

function wp_startdeploy(var0, var1) {
  self endon("disconnect");
  level endon("game_ended");

  if(istrue(level.wpinprogress)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/WP_ACTIVE");
    }

    return 0;
  }

  level.wpinprogress = 1;

  foreach(var3 in var0) {
    var4 = var3.location;
    var5 = var3.angles;
    wp_finishdeployment(var4, var5, var1);

    if(var0.size > 1 && var6 < var0.size - 1) {
      wait randomfloatrange(1, 3);
    }
  }
}

function wp_finishdeployment(var0, var1, var2) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  thread ref_145e6("disconnect");
  thread ref_145e6("joined_team");
  thread ref_145e6("joined_spectator");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
  var3 = wp_createplane(var0, var1, var2);

  if(!isDefined(var3)) {
    return 0;
  }

  thread ref_145ea();
  thread wp_deliverpayloads(var3);
}

function wp_createplane(var0, var1, var2) {
  var3 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var4 = 28000;
  var5 = 5000;
  var6 = 2500;
  var7 = 1500;
  var8 = (0, var1, 0);

  if(!isDefined(var3)) {
    var6 += 3000;
  } else {
    var6 = var3.origin[2] + 3000;
    var7 = scripts\cp_mp\killstreaks\airstrike::getexplodedistance(var6);
  }

  var9 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var0, var8, var4, var3, var6, var5, var7);
  var10 = spawn("script_model", var9["startPoint"]);
  var10.angles = var8;
  var10.flightpath = var9;
  var10.owner = self;
  var10.team = self.team;
  var10.streakinfo = var2;
  var10.speed = var5;
  var11 = "veh8_mil_air_suniform25_west";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(self)) {
    var11 = "veh8_mil_air_suniform25";
  }

  var10 setModel(var11);
  var12 = undefined;
  var13 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var13 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective");
  }

  if(isDefined(var13)) {
    var12 = var10[[var13]]("icon_minimap_wp", var10.team, 1, 1, 1);
    var10.minimapid = var12;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var10[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var10.streakinfo.streakname, "Killstreak_Air", self);
  }

  return var10;
}

function ref_145e6(var0, var1) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  self waittill(var0);
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

  var0 = 0;

  if(var0) {
    self freescriptable();
    return;
  }

  self delete();
}

function ref_145e7(var0) {
  self endon("death");
  level waittill("white_phosphorus_end");

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(ref_145e3("inner", self)) {
    wp_removefromactivewplist(level, "inner", self, var0, 1);
  }

  self notify("stop_wp_status_effect");
  var1 = 0;

  if(var1) {
    self freescriptable();
    return;
  }

  self delete();
}

function wp_deliverpayloads(var0) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var1 = self.flightpath["startPoint"];
  var2 = self.flightpath["endPoint"];
  var3 = self.flightpath["flyTime"];
  var4 = var1 + anglesToForward(self.angles) * 12500;
  var5 = var2 - anglesToForward(self.angles) * 12500;
  var6 = length(var4 - var5);
  var7 = 30;
  thread wp_watchend(self.owner, var0);
  thread ref_145e9(self.owner);
  self moveTo(var2, var3);
  self setscriptablepartstate("bodyFX", "on", 0);
  self scriptmodelplayanim("mp_suniform25_flyin");
  thread wp_enterpayloadaudio();
  thread wp_exitpayloadaudio(var2, var3);
  var9 = 3;
  wp_handlepayloadtyperelease(&wp_fireairburst, var1, var4, var6, var7, 4000, var9, 1);
  wp_handlepayloadtyperelease(&wp_firesmoke, var1, var4, var6, var7, 4000, 3, 1);
  wp_handlepayloadtyperelease(&wp_fireflaregroup, var1, var4, var6, var7, 2000, 6, 2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var3);
  self stopsounds();
  self scriptmodelplayanimdeltamotion("mp_suniform25_exit");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5.33);
  wp_removeplane(self);
}

function wp_watchend(var0, var1) {
  self endon("disconnect");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);
  self notify("white_phosphorus_finished");
  scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var0);
}

function ref_145e9(var0) {
  self endon("disconnect");
  self endon("white_phosphorus_finished");
  level endon("white_phosphorus_end");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var0);
}

function wp_enterpayloadaudio() {
  self endon("death");
  level endon("white_phosphorus_end");
  waitframe();
  self playsoundonmovingent("iw8_mp_white_phos_su25_flyby");
}

function wp_exitpayloadaudio(var0, var1) {
  self endon("death");
  level endon("white_phosphorus_end");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);
  playsoundatpos(var0, "iw8_mp_white_phos_su25_exit");
}

function wp_watchunsuccessfulzones(var0) {
  level endon("wp_zone_succeeded");
  level endon("game_ended");

  for(var1 = 0; var1 < var0; var1++) {
    level waittill("wp_zone_failed");
  }

  level.wpinprogress = undefined;
}

function wp_handlepayloadtyperelease(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = int(var3 / var5);
  var9 = 0;

  if(!isDefined(var6)) {
    var6 = var8;
  } else {
    var10 = var8 - var6;
    var9 = int(var10 / 2);
  }

  if(isDefined(var7)) {
    var9 += var7;
  }

  var11 = anglesToForward(self.angles);
  var12 = var2;
  var13 = 0;

  for(var14 = 0; var14 < var8; var14++) {
    var15 = length(var1 - var12) / self.speed;

    if(var14 < var9) {
      var12 += var11 * var5;
      goto LOC_0000010a;
    }

    var16 = var12 - (0, 0, 2000);

    if(var0 == &wp_fireflaregroup) {
      var17 = spawn("script_model", var1 + (0, 0, 1500));
      thread wp_movekillcam(var17, var15, var16, var11);
      self thread[[var0]](var16, var11, var15, var17);
    } else if(var0 == &wp_firesmoke) {
      self thread[[var0]](var16, var11, var15, var14);
    } else {
      self thread[[var0]](var16, var11, var15);
    }

    var12 += var11 * var5;
    var13++;
  }
}

function wp_movekillcam(var0, var1, var2, var3) {
  self endon("death");
  var1 -= var2 * 3500;
  var4 = var1 - var2 * 1000;
  self moveTo(var1, var0 + 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0 + 2);
  self moveTo(var4, 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var3);
  self delete();
}

function wp_testpayloads(var0, var1, var2) {
  self endon("death");
}

function wp_fireairburst(var0, var1, var2) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var3 = var0 - var1 * 3000;
  var4 = var0 - var1 * 2000;
  var5 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var2);
  playFX(scripts\engine\utility::getfx("white_phosphorus_inair_explosion"), var3, var1);
  playsoundatpos(var4, "iw8_mp_white_phos_midair_explo");
}

function wp_firesmoke(var0, var1, var2, var3) {
  level endon("white_phosphorus_end");
  level endon("game_ended");

  if(!isDefined(self.playersininitialsmokerange)) {
    self.playersininitialsmokerange = [];
  }

  if(!isDefined(self.playersoutsideinitialsmokerange)) {
    self.playersoutsideinitialsmokerange = [];
  }

  var4 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype != "arm") {
    var4 = 0;
  }

  var5 = scripts\engine\trace::ray_trace(var0, var0 - (0, 0, 10000));
  var6 = var5["position"];
  var7 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var2);
  var9 = 0;

  if(var9) {
    var10 = easepower("ks_white_phosphorus_mp_p", var6, self.angles);
  } else {
    var10 = spawn("script_model", var7);
    var10 setModel("ks_white_phosphorus_mp");
    var10 setentityowner(self.owner);
  }

  var10.team = self.team;
  var10.owner = self.owner;
  var10.streakinfo = self.streakinfo;
  thread ref_145e8();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  thread ref_145e5(level);

  if(istrue(var5)) {
    var11 = isDefined(var4) && var4 == 3;

    if(istrue(var11)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.5);
      self.playersininitialsmokerange = scripts\common\utility::playersincylinder(var7, 2000);
      self.playersoutsideinitialsmokerange = scripts\engine\utility::array_difference(level.players, self.playersininitialsmokerange);
      thread wp_watchdisorienteffect(var10, 2000, self.playersininitialsmokerange);
    }
  } else {
    if(scripts\cp_mp\utility\game_utility::isnightmap() || scripts\cp_mp\utility\game_utility::update_operator_west_char_loc()) {
      var10 setscriptablepartstate("smoke_night", "on", 0);
    } else {
      var10 setscriptablepartstate("smoke", "on", 0);
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.5);
    thread wp_watchdisorienteffect(var10, 2000);
  }

  wp_addtoactivewplist(level, "smoke", var10);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var9);
  wp_removefromactivewplist(level, "smoke", var10);
}

function wp_fireflaregroup(var0, var1, var2, var3) {
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var4 = self.owner;
  var5 = self.team;
  var6 = self.angles;
  var7 = scripts\engine\trace::ray_trace(var0, var0 - (0, 0, 10000), self, undefined, 1, 1);
  var8 = var7["position"];
  var9 = var7["surfacetype"];
  var10 = isDefined(level.white_phosphorus_damage_area);

  if(istrue(var10)) {
    level.white_phosphorus_damage_area dontinterpolate();
    level.white_phosphorus_damage_area.owner = var4;
    level.white_phosphorus_damage_area.team = var5;
    level.white_phosphorus_damage_area.streakinfo = self.streakinfo;
  }

  var11 = 30;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var2);
  var12 = wp_getflarepositions(var0, var8, 4, int(250));

  foreach(var14 in var12) {
    var15 = 0;

    if(var15) {
      var16 = easepower("ks_white_phosphorus_mp_p", var14.flareorigin, var6);
    } else {
      var16 = spawn("script_model", var14.flareorigin);
      var16 setModel("ks_white_phosphorus_mp");
      var16 setentityowner(var4);
      var16.angles = var6;
    }

    var16.owner = var4;
    var16.team = var5;
    var16.streakinfo = self.streakinfo;
    var16.struct = var14;
    var16.weapon_name = "white_phosphorus_proj_mp";
    var16.killcament = var3;
    thread ref_145e7(var16);
    thread wp_projwatchimpact(var16, var11, "burn");
    wait randomfloatrange(0.1, 0.4);
  }

  if(istrue(var10)) {
    level.white_phosphorus_damage_area.origin = (0, 0, 50000);
    return;
  }
}

function wp_getflarepositions(var0, var1, var2, var3) {
  var4 = [];
  var5 = self.angles * (0, 1, 0);
  var6 = anglesToForward(var5);
  var7 = anglestoright(var5);
  var8 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
  var9 = physics_createcontents(var8);
  var10 = -2000;
  var11 = 0;

  for(var12 = 0; var12 < var2; var12++) {
    var13 = var6 * var10 + var7 * var11;
    var14 = var1 + var6 * var10;
    var15 = var1 + var13;
    var16 = scripts\engine\trace::ray_trace(var15 + (0, 0, var0[2]), var15 - (0, 0, 10000), level.characters, var9);
    var17 = var16["position"];
    var18 = var1 * (1, 1, 0) + (0, 0, var17[2]) + var6 * var10;
    var19 = spawnStruct();
    var19.damageorigin = var18;
    var19.flareorigin = var17;
    var4 = var19;
    var10 += 500;
    var11 = randomintrange(-750, 750);
  }

  return var4;
}

function wp_projwatchimpact(var0, var1, var2) {
  self endon("death");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2.5);
  self.projimpacted = 1;
  wp_addtoactivewplist(level, "inner", self);
  self setscriptablepartstate("impact", "on", 0);

  if(isDefined(var2) && var2 == "surftype_water") {
    self setscriptablepartstate("flare_death_water", "on", 0);
  } else {
    self setscriptablepartstate("flare", "on", 0);
  }

  var3 = self.struct.damageorigin + (0, 0, 10);

  if(isDefined(self.owner)) {
    self radiusdamage(var3, 512, 500, 500, self.owner, "MOD_EXPLOSIVE", "white_phosphorus_proj_mp");
  }

  if(isDefined(var2) && var2 != "surftype_water") {
    if(isDefined(var1)) {
      self.killcament = spawn("script_model", self.origin + (0, 0, 100));

      if(var1 == "burn") {
        thread wp_watchburneffect(300);
      } else {
        thread wp_watchblindeffect(300);
      }

      if(!scripts\common\utility::iscp()) {
        scripts\cp_mp\utility\killstreak_utility::killstreak_createdangerzone(self.origin, 300, 300, var0, self.owner, self.team);
        thread ref_145e2();
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
    wp_removefromactivewplist(level, "inner", self, var1, 1);
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
  var0 = self.dangerzoneid;
  self waittill("death");
  scripts\cp_mp\utility\killstreak_utility::killstreak_destroydangerzone(var0);
}

function ref_145e1(var0) {
  self endon("death");
  level endon("white_phosphorus_end");
  level endon("game_ended");
  var1 = 0;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);

  if(var1) {
    self freescriptable();
    return;
  }

  self delete();
}

function wp_watchdisorienteffect(var0, var1, var2) {
  self endon("death");
  self.playersindisorientradius = [];
  jumpiffalse(isDefined(var1) && isDefined(var2)) LOC_0000003a;
  thread wp_delaydisorientplayersinrange(0.15, 2000, var1);
  thread wp_delaydisorientplayersinrange(0.25, undefined, var2);
  return;
}

function wp_getplayerswithinrange(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    if(distance2dsquared(self.origin, var4.origin) <= var1 * var1) {
      var2 = var4;
    }
  }

  return var2;
}

function wp_delaydisorientplayersinrange(var0, var1, var2) {
  self endon("death");

  if(isDefined(var0) && var0 > 0) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  }

  var3 = var2;

  if(isDefined(var1) && var1 > 0) {
    var3 = wp_getplayerswithinrange(var2, var1);
  }

  foreach(var5 in var3) {
    if(var5 scripts\cp_mp\utility\player_utility::_isalive()) {
      wp_addplayertostatusradiuslist("smoke", var5);

      if(!istrue(var5.wpdisorient)) {
        thread wp_startdisorientplayer(var5);
      }
    }

    thread wp_startdisorientplayeronspawn(var5);
  }
}

function wp_watchburneffect(var0) {
  self endon("stop_wp_status_effect");
  self endon("death");
  self.playersininnerradius = [];

  for(;;) {
    foreach(var2 in level.players) {
      if(!var2 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(distance2d(self.origin, var2.origin) <= var0 && scripts\engine\trace::ray_trace_passed(var2 getEye(), self.origin + (0, 0, 30), var2)) {
        if(!istrue(var2.wpburning)) {
          thread wp_startburnplayer(var2, self);
        }

        continue;
      }

      if(istrue(var2.wpburning) && wp_isinwpzone("inner", var2, self)) {
        wp_stopburnplayer(var2, self);
      }
    }

    waitframe();
  }
}

function wp_watchblindeffect(var0) {
  self endon("stop_wp_status_effect");
  self endon("death");
  self.playersininnerradius = [];

  for(;;) {
    foreach(var2 in level.players) {
      if(!var2 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(distance2d(self.origin, var2.origin) <= var0 && scripts\engine\trace::ray_trace_passed(var2 getEye(), self.origin + (0, 0, 30), var2)) {
        if(!istrue(var2.wpblinding)) {
          wp_startblindplayer(var2, self);
        }

        continue;
      }

      if(istrue(var2.wpblinding) && wp_isinwpzone("inner", var2, self)) {
        wp_stopblindplayer(var2, self);
      }
    }

    waitframe();
  }
}

function wp_addtoactivewplist(var0, var1) {
  if(var0 == "smoke") {
    level.activewpzones[level.activewpzones.size] = var1;
    return;
  }

  level.activewpinnerzones[level.activewpinnerzones.size] = var1;
}

function ref_145e3(var0, var1) {
  var2 = 0;
  jumpiffalse(var0 == "smoke") LOC_0000004c;

  foreach(var4 in level.activewpzones) {
    if(var4 == var1) {
      var2 = 1;
      break;
    }
  }

  goto LOC_00000082;
}

function wp_removefromactivewplist(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    return;
  }

  var4 = [];
  jumpiffalse(var0 == "smoke") LOC_000000bf;

  foreach(var6 in level.activewpzones) {
    if(var6 == var1) {
      continue;
    }

    var4 = var6;
  }

  level.activewpzones = var4;

  if(isDefined(var1.playersindisorientradius)) {
    foreach(var9 in var1.playersindisorientradius) {
      if(isDefined(var9) && !wp_isinanywpzone("smoke", var9)) {
        thread wp_stopdisorientplayer(var9);
      }
    }
  }

  if(level.activewpzones.size <= 0) {
    level.wpinprogress = undefined;
  }

  goto LOC_00000168;
}

function wp_isinanywpzone(var0, var1) {
  var2 = 0;
  jumpiffalse(var0 == "smoke") LOC_00000051;

  foreach(var4 in level.activewpzones) {
    if(wp_isinwpzone(var0, var1, var4)) {
      var2 = 1;
      break;
    }
  }

  goto LOC_0000008c;
}

function wp_isinwpzone(var0, var1, var2) {
  var3 = 0;
  var4 = undefined;

  if(var0 == "smoke") {
    var4 = var2.playersindisorientradius;
  } else {
    var4 = var2.playersininnerradius;
  }

  if(isDefined(var4)) {
    foreach(var6 in var4) {
      if(var6 == var1) {
        var3 = 1;
        break;
      }
    }
  }

  return var3;
}

function wp_addplayertostatusradiuslist(var0, var1) {
  if(var0 == "smoke") {
    self.playersindisorientradius[self.playersindisorientradius.size] = var1;
    return;
  }

  self.playersininnerradius[self.playersininnerradius.size] = var1;
}

function wp_removeplayerfromstatusradiuslist(var0, var1) {
  if(var0 == "smoke") {
    var2 = [];

    foreach(var4 in self.playersindisorientradius) {
      if(var4 == var1) {
        continue;
      }

      var2 = var4;
    }

    self.playersindisorientradius = var2;
    return;
  }

  var2 = [];

  foreach(var4 in self.playersininnerradius) {
    if(var4 == var4) {
      continue;
    }

    var2 = var4;
  }

  self.playersininnerradius = var2;
}

function wp_removeplayerfromallstatusradiuslists(var0, var1) {
  jumpiffalse(var0 == "smoke") LOC_0000004a;

  foreach(var3 in level.activewpzones) {
    if(wp_isinwpzone(var0, var1, var3)) {
      wp_removeplayerfromstatusradiuslist(var3, var0, var1);
    }
  }

  return;
}

function wp_startdisorientplayeronspawn(var0) {
  var0 endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("spawned_player");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
    wp_addplayertostatusradiuslist(var0, "smoke", self);
    thread wp_startdisorientplayer(var0);
  }
}

function wp_startdisorientplayer(var0) {
  var0 endon("death");
  self endon("death_or_disconnect");
  self endon("stop_disorient");
  level endon("game_ended");
  self.wpdisorient = 1;

  while(isDefined(self.sessionstate) && self.sessionstate != "playing") {
    waitframe();
  }

  thread wp_stopdisorientonplayerdeath(var0);
  thread wp_monitorsmokevisionset(var0);
  playfxontagforclients(scripts\engine\utility::getfx("white_phosphorus_screen"), self, "tag_eye", self);

  if(level.teambased && self.team == var0.team || self == var0.owner) {
    var1 = 1;

    if(istrue(var1)) {
      return;
    }
  }

  self.wphealthblock = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_block_health_regen");
  }

  if(self.health > 10) {
    var3 = wp_gethealthdebuffamount();
    wp_degenhealth(var3, var0);
  }

  if(!wp_hasresistperk()) {
    enableloopingcoughaudio();
    return;
  }
}

function wp_degenhealth(var0, var1) {
  if(istrue(self.gasmaskequipped)) {
    return;
  }

  if(!isDefined(self.wphealthblock)) {
    self.wphealthblock = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_block_health_regen");
    }
  }

  self dodamage(var0, self.origin, var1.owner, var1, "MOD_EXPLOSIVE", "white_phosphorus_proj_mp");
}

function wp_startdofshiftforplayer(var0) {
  var0 endon("death");
  self endon("death");
  level endon("game_ended");

  while(istrue(self.wpdisorient)) {
    wait randomfloatrange(1, 3);
  }
}

function wp_stopdisorientonplayerdeath(var0) {
  var0 endon("death");
  self endon("stop_disorient");
  level endon("game_ended");
  self waittill("death");
  wp_stopdisorientplayer(var0, 1);
}

function wp_stopdisorientplayer(var0, var1) {
  level endon("game_ended");

  if(istrue(var1)) {
    wp_removeplayerfromallstatusradiuslists(level, "smoke", self);
  } else {
    wp_removeplayerfromstatusradiuslist(var0, "smoke", self);
  }

  if(!wp_isinanywpzone("smoke", self) || istrue(var1)) {
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

function wp_startburnplayer(var0, var1) {
  var0 endon("death");
  self endon("stop_wp_burn");
  self endon("death");
  level endon("game_ended");

  if(level.teambased && self.team == var0.team && self != var0.owner) {
    var2 = 1;

    if(istrue(var2)) {
      return;
    }
  }

  wp_addplayertostatusradiuslist(var0, "inner", self);
  self.wpburning = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "enableBurnFX")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "enableBurnFX")]](undefined, "wp_active");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "enqueueCorpsetableFunc")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "enqueueCorpsetableFunc")]]("white_phosphorus_burning", &wp_playcorpsetableburningfx);
  }

  thread wp_stopstatuseffectondeath(var0);
  var4 = 10;

  for(;;) {
    if(self.health <= var4) {
      self notify("stop_degen");
    }

    self dodamage(var4, self.origin, var1, var0, "MOD_FIRE", var0.weapon_name);
    wait 0.5;
    var4++;

    if(var4 >= 20) {
      var4 = 20;
    }

    self.lastburntime = gettime();
  }
}

function wp_stopburnplayer(var0) {
  wp_removeplayerfromstatusradiuslist(var0, "inner", self);

  if(!wp_isinanywpzone("inner", self)) {
    wp_resetstatuseffect();
    self notify("stop_wp_burn");
    return;
  }
}

function wp_startblindplayer(var0) {
  if(level.teambased && self.team == var0.team || self == var0.owner) {
    var1 = 1;

    if(istrue(var1)) {
      return;
    }
  }

  wp_addplayertostatusradiuslist(var0, "inner", self);
  self.wpblinding = 1;
  thread wp_stopstatuseffectondeath(var0);
  self visionsetnakedforplayer("wp_flare", 1);
}

function wp_stopblindplayer(var0) {
  wp_removeplayerfromstatusradiuslist(var0, "inner", self);

  if(!wp_isinanywpzone("inner", self)) {
    wp_resetstatuseffect();
    return;
  }
}

function wp_stopstatuseffectondeath(var0) {
  var0 endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  wp_resetstatuseffect(1);
}

function wp_resetstatuseffect(var0) {
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

  if(istrue(var0)) {
    wp_removeplayerfromallstatusradiuslists(level, "inner", self);
    return;
  }
}

function wp_removeplane(var0) {
  if(isDefined(var0.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var0.minimapid);
    }

    var0.minimapid = undefined;
  }

  var0 delete();
}

function wp_getsmokevisionset() {
  var0 = "wp_smoke";
  var1 = "wp_smoke_night";
  var2 = var0;

  if(scripts\cp_mp\utility\game_utility::isnightmap() || scripts\cp_mp\utility\game_utility::update_operator_west_char_loc()) {
    var2 = var1;
  }

  return var2;
}

function wp_monitorsmokevisionset(var0) {
  var0 endon("death");
  self endon("disconnect");
  self endon("stop_disorient");
  self endon("death");
  level endon("game_ended");
  var1 = undefined;

  for(;;) {
    if(istrue(self.wpdisorient)) {
      var2 = wp_getsmokevisionset();

      if(!isDefined(var1) || var2 != var1) {
        var1 = var2;
        self visionsetnakedforplayer(var2, 2);
      }
    }

    waitframe();
  }
}

function wp_gethealthdebuffamount() {
  var0 = 50;

  if(wp_hasresistperk()) {
    var0 *= 0.5;
  }

  var1 = self.health;
  var2 = var1 - var0;

  if(var2 < 10) {
    var0 -= 10 - var2;
  }

  return var0;
}

function wp_playcorpsetableburningfx(var0) {
  var0 setscriptablepartstate("wp_burning", "flareUp", 0);
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
    var0 = randomfloatrange(4, 7);

    if(!loopingcoughaudioissupressed() && isDefined(self.operatorcustomization)) {
      var1 = "generic_cough_3_enemy_1";

      if(self.team == "allies") {
        if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
          var2 = game["dialogue"]["allies_female_cough"].size;
          var3 = randomint(var2);
          var1 = game["dialogue"]["allies_female_cough"][var3];
        } else {
          var2 = game["dialogue"]["allies_male_cough"].size;
          var3 = randomint(var2);
          var3 = game["dialogue"]["allies_male_cough"][var3];
        }
      } else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
        var2 = game["dialogue"]["axis_female_cough"].size;
        var3 = randomint(var2);
        var3 = game["dialogue"]["axis_female_cough"][var3];
      } else {
        var2 = game["dialogue"]["axis_male_cough"].size;
        var3 = randomint(var2);
        var3 = game["dialogue"]["axis_male_cough"][var3];
      }

      if(!isai(self)) {
        self playsoundtoplayer("gas_player_cough", self, self);
      }

      if(istrue(self.loopingcoughaudio)) {
        self playsoundonmovingent(var3);
      }
    }

    wait var2;
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

function ref_145e5(var0) {
  var0 setscriptablepartstate("impact_center", "on", 0);
  waitframe();
  var0 setscriptablepartstate("impact_center", "off", 0);
}