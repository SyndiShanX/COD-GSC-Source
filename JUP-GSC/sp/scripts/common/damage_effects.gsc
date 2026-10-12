/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\damage_effects.gsc
***********************************************/



#using scripts\common\callbacks;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\playerhealth;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace damage_effects;

function init() {
  if(!isDefined(level.var_562530bdb8e83b66)) {
    level.var_562530bdb8e83b66 = 0.55;
  }

  if(!isDefined(level.var_fdd1af3c4c6cbe86)) {
    level.var_fdd1af3c4c6cbe86 = 0.7;
  }
}

function function_9bc46d4b8891a740() {
  if(!isPlayer(self) || isbot(self)) {
    return;
  }

  if(!isDefined(self.damage)) {
    self.damage = spawnStruct();
  } else if(isDefined(self.damage.var_7076478738f62d10)) {
    foreach(overlay in self.damage.var_7076478738f62d10) {
      if(isDefined(overlay)) {
        overlay destroy();
      }
    }
  }

  self.damage.var_7076478738f62d10 = [];
  self.damage.var_f4687931bd3b8634 = [];
  self.damage.altdirectionalbloodoverlay = 0;
  self.damage.lastdiretionalbloodtime = -99999;
  initdeathsdooroverlaypulse();
  function_12bd9b0199862940();
  thread function_fba4aaaecf8e34ac();
  thread function_c0124edee3a13496();
  thread function_54117659a8e5c5b4();
}

function initdeathsdooroverlaypulse() {
  if(!isDefined(level.projectbundle) || !isDefined(level.projectbundle.var_1ad4a3f795bf0321)) {
    return;
  }

  self.damage.deathsdooroverlaypulse = newclienthudelem(self);
  self.damage.deathsdooroverlaypulse.sort = 9;
  self.damage.deathsdooroverlaypulse.x = 0;
  self.damage.deathsdooroverlaypulse.y = 0;
  self.damage.deathsdooroverlaypulse.alignx = "left";
  self.damage.deathsdooroverlaypulse.aligny = "top";
  self.damage.deathsdooroverlaypulse.foreground = 0;
  self.damage.deathsdooroverlaypulse.lowresbackground = 1;
  self.damage.deathsdooroverlaypulse.horzalign = "fullscreen";
  self.damage.deathsdooroverlaypulse.vertalign = "fullscreen";
  self.damage.deathsdooroverlaypulse.alpha = 0;
  self.damage.deathsdooroverlaypulse.enablehudlighting = 0;
  self.damage.deathsdooroverlaypulse.scramblerdisabled = 1;
  self.damage.deathsdooroverlaypulse setshader(level.projectbundle.var_1ad4a3f795bf0321, 640, 480);
  self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949 = 0;
  self.damage.var_7076478738f62d10 = array_add(self.damage.var_7076478738f62d10, self.damage.deathsdooroverlaypulse);
}

function function_12bd9b0199862940() {
  if(!isDefined(level.projectbundle) || !isDefined(level.projectbundle.var_e44fdf0e370e159a)) {
    return;
  }

  self.damage.var_5d28af440fb50e5a = newclienthudelem(self);
  self.damage.var_5d28af440fb50e5a.sort = 10;
  self.damage.var_5d28af440fb50e5a.x = 0;
  self.damage.var_5d28af440fb50e5a.y = 0;
  self.damage.var_5d28af440fb50e5a.alignx = "left";
  self.damage.var_5d28af440fb50e5a.aligny = "top";
  self.damage.var_5d28af440fb50e5a.foreground = 0;
  self.damage.var_5d28af440fb50e5a.lowresbackground = 1;
  self.damage.var_5d28af440fb50e5a.horzalign = "fullscreen";
  self.damage.var_5d28af440fb50e5a.vertalign = "fullscreen";
  self.damage.var_5d28af440fb50e5a.alpha = 0;
  self.damage.var_5d28af440fb50e5a.enablehudlighting = 0;
  self.damage.var_5d28af440fb50e5a.scramblerdisabled = 1;
  self.damage.var_5d28af440fb50e5a setshader(level.projectbundle.var_e44fdf0e370e159a, 640, 480);
  self.damage.var_f4687931bd3b8634 = array_add(self.damage.var_7076478738f62d10, self.damage.var_5d28af440fb50e5a);
}

function function_fba4aaaecf8e34ac() {
  overlays = self.damage.var_7076478738f62d10;
  waittill_any_2("death_or_disconnect", "ending_cinematic");

  foreach(overlay in overlays) {
    if(isDefined(overlay)) {
      overlay destroy();
    }
  }
}

function function_c0124edee3a13496() {
  overlays = self.damage.var_f4687931bd3b8634;
  waittill_any_4("disconnect", "death_delay_finished", "spawned", "ending_cinematic");

  foreach(overlay in overlays) {
    if(isDefined(overlay)) {
      overlay destroy();
    }
  }
}

function function_3d879029586de3(alphavalue) {
  if(getdvarint(@ "touch_enabled")) {
    return (alphavalue * 0.6);
  }

  return alphavalue;
}

function onenterdeathsdoor(smeansofdeath) {
  if(istrue(self.deathsdoor)) {
    return;
  }

  self.deathsdoor = 1;
  self.painbreathloopsplayed = 0;
  self.var_632fcfdf269b9dc8 = gettime();
  self notify("startHeartbeatPulse");

  if(!istrue(self.deathsdoorsfx) && !istrue(self.var_a9982aba7477cc90)) {
    self.deathsdoorsfx = 1;
    self stoplocalsound("deaths_door_out");
    self playlocalsound("deaths_door_in");
    function_501be800abf11f33(0.2, 1);
    self enableplayerbreathsystem(0);
    self setentitysoundcontext("deaths_door", "active", 0.1);
    thread playerbreathingpainsound();

    if(isPlayer(self) && !isbot(self)) {
      function_9030f56a68f604dc();
      function_c2e66bc8cbf81b2d();
    }
  }

  if(level.healthregendisabled) {
    self painvisionon();
  }

  self notify("deaths_door_enter");
}

function playerbreathingpainsound(healthcap) {
  self endon("death_or_disconnect");
  self endon("deaths_door_exit");
  self endon("healed");
  self endon("joined_spectators");
  self endon("last_stand_revived");
  level endon("game_ended");
  self.painbreathloopsplayed = default_to(self.painbreathloopsplayed, 0);
  wait 0.5;

  while(true) {
    if(isusingremote()) {
      waitframe();
      continue;
    }

    if(!val::get("health_regen") || level.healthregendisabled || level.var_be39d6b46044f344 < 40) {
      self.painbreathloopsplayed++;

      if(self.painbreathloopsplayed > ter_op(istrue(self.hasdonepainbreathloopthislife), 1, 4)) {
        wait 1;
        self.hasdonepainbreathloopthislife = 1;
        onexitdeathsdoor(0);
        break;
      }
    }

    self playlocalsound("plr_breath_pain_ong_exh");
    wait 1.7;
  }
}

function onexitdeathsdoor(healed) {
  if(istrue(healed)) {
    self.painbreathloopsplayed = 0;
    self.hasdonepainbreathloopthislife = 0;
  }

  if(!istrue(self.deathsdoor)) {
    return;
  }

  self.deathsdoor = 0;
  self.deathsdoorsfx = 0;

  if(isPlayer(self) && !isbot(self)) {
    function_86765f42c27f4bee();
    function_7067dfb2023a23b7();
  }

  self stoplocalsound("deaths_door_in");
  self playlocalsound("deaths_door_out");
  function_a2b4e6088394bade();
  self playlocalsound(ter_op(isfemale(), "Fem_breathing_better", "breathing_better"));
  self setentitysoundcontext("deaths_door", "", 0.1);
  self enableplayerbreathsystem(1);

  if(level.healthregendisabled) {
    self painvisionoff();
  }

  self notify("deaths_door_exit");
}

function function_9030f56a68f604dc() {
  if(!isDefined(self.damage.deathsdooroverlaypulse)) {
    return;
  }

  thread function_41a40f1e0a6aa78e();
}

function function_c2e66bc8cbf81b2d() {
  if(!isDefined(self.damage.var_5d28af440fb50e5a)) {
    return;
  }

  self.damage.var_5d28af440fb50e5a fadeovertime(0.15);
  self.damage.var_5d28af440fb50e5a.alpha = function_3d879029586de3(1);
  self.damage.var_5d28af440fb50e5a.var_8a8941ad64562137 = 1;
}

function function_86765f42c27f4bee() {
  thread function_47b9c7c77690bb03(0, 3.5);
}

function function_7067dfb2023a23b7() {
  if(!isDefined(self.damage.var_5d28af440fb50e5a)) {
    return;
  }

  self.damage.var_5d28af440fb50e5a fadeovertime(2);
  self.damage.var_5d28af440fb50e5a.alpha = 0;
}

function applyshrapnelfx() {
  self endon("disconnect");
  self notify("applyShrapnelFX");
  self endon("applyShrapnelFX");
  self setclientomnvar("ui_shrapnel_overlay", 1);
  self playlocalsound("iw8_mp_perk_shrapnel");
  endednormally = applyshrapnelfxinternal();

  if(istrue(endednormally)) {
    self setclientomnvar("ui_shrapnel_overlay", 2);
    return;
  }

  self setclientomnvar("ui_shrapnel_overlay", 3);
}

function applyshrapnelfxinternal() {
  self endon("death");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");
  value = waittill_any_return_3("shrapnel_ended_early", "shrapnel_ended", "force_regeneration");
  return value == "shrapnel_ended";
}

function function_6410111baf734017() {
  if(!isDefined(level.var_194088d9669cb53d)) {
    level.var_194088d9669cb53d = getdvarint(@ "scr_attacker_time_buffer_ms", 2000);
    level.var_1736de83d797adc0 = getdvarint(@ "hash_2fd03831cb8a51e6", 4000);
  }

  return level.var_194088d9669cb53d;
}

function function_549fbfada3618987() {
  var_194088d9669cb53d = function_6410111baf734017();
  return var_194088d9669cb53d > 2000;
}

function updatefirsttimedamaged() {
  if(function_549fbfada3618987()) {
    assert(isDefined(level.var_1736de83d797adc0));

    if(!isDefined(self.lasttimedamaged)) {
      self.firsttimedamaged = gettime();
      return;
    }

    if(gettime() - self.lasttimedamaged > level.var_1736de83d797adc0) {
      self.firsttimedamaged = gettime();
    }
  }
}

function removeoldattackersovertime() {
  self endon("damage");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(self.attackers)) {
    return;
  }

  var_194088d9669cb53d = function_6410111baf734017();

  while(true) {
    time = gettime();

    foreach(guid, attacker in self.attackers) {
      if(isDefined(attacker) && time - self.attackerdata[guid].lasttimedamaged < var_194088d9669cb53d) {
        continue;
      }

      self.attackers[guid] = undefined;
      self.attackerdata[guid] = undefined;
    }

    waitframe();
  }
}

function function_446043a04ae1bfe() {
  self.attackers = [];
  self.attackerdata = [];
}

function damageeffects(idamage, eattacker, smeansofdeath, vpoint, lightarmordamage, objweapon, shitloc) {
  self endon("death_or_disconnect");
  self notify("damageEffects");

  if(!isPlayer(self) || isbot(self) || issimulationplayer(self)) {
    return;
  }

  if(function_816434396dce13f(self)) {
    return;
  }

  factor = damageratio(idamage + lightarmordamage);

  if(!isDefined(eattacker) && smeansofdeath == "MOD_FALLING") {
    eattacker = self;
  }

  childthread damagepainvision(vpoint, factor, smeansofdeath, idamage, objweapon);
  childthread damagebloodoverlaydirectional(vpoint, factor, smeansofdeath, idamage, objweapon, shitloc);
  var_2809cfd0f803f738 = {
    #objweapon: objweapon, #lightarmordamage: lightarmordamage, #vpoint: vpoint, #smeansofdeath: smeansofdeath, #eattacker: eattacker, #idamage: idamage
  };
  callback::callback("on_player_damage_effects", var_2809cfd0f803f738);
}

function damagepainvision(vpoint, factor, smeansofdeath, idamage, objweapon) {
  self endon("damageEffects");
  self endon("death_or_disconnect");

  if(!shoulddopainvision(objweapon)) {
    return 0;
  }

  if(function_c1af921b6351d49a(smeansofdeath)) {
    self function_2f6b8c6721d18b0b("vsp_fall");
    self function_9227c84d3fb311a3("vsp_bullet");
    return;
  }

  if(function_3e54581e73dff375(smeansofdeath)) {
    eventtype = "vsp_fall";
  } else if(function_6a97b15cdcd5961b(smeansofdeath)) {
    eventtype = "vsp_fire";
  } else if(function_9ca01a02f4efc7f6(smeansofdeath)) {
    eventtype = "vsp_explosive";
  } else {
    eventtype = "vsp_bullet";
  }

  self function_2f6b8c6721d18b0b(eventtype);
  self function_9227c84d3fb311a3(eventtype);
}

function shoulddopainvision(objweapon) {
  if(istrue(level.wpinprogress) || istrue(self.focus)) {
    return false;
  }

  if(isDefined(objweapon) && objweapon.basename == "dragonsbreath_mp") {
    return false;
  }

  return true;
}

function function_52f60ac82b866362(fadetime) {
  if(istrue(level.wpinprogress)) {
    return;
  }

  self visionsetnakedforplayer("", fadetime);
}

function damagebloodoverlaydirectional(vpoint, factor, smeansofdeath, idamage, objweapon, shitloc) {
  if(!isDefined(vpoint)) {
    return;
  }

  if(!function_9c9288020fccd597(factor, smeansofdeath, idamage, objweapon, shitloc)) {
    return;
  }

  time = gettime();

  if(time - self.damage.lastdiretionalbloodtime < 200) {
    return;
  } else {
    self.damage.lastdiretionalbloodtime = time;
  }

  sides = getplayersidesfromposition(vpoint);
  materialsuffix = "";

  if(function_9ca01a02f4efc7f6(smeansofdeath)) {
    prefix = "fullscreen_dirt_";
  } else if(!scripts\cp_mp\armor::hasarmor()) {
    prefix = "fullscreen_blood_";

    if(self.damage.altdirectionalbloodoverlay) {
      materialsuffix = "_alt";
      self.damage.altdirectionalbloodoverlay = 0;
    } else {
      self.damage.altdirectionalbloodoverlay = 1;
    }
  } else {
    prefix = "fullscreen_armor_";
  }

  foreach(side, type in sides) {
    material = prefix + side;
    splashmaterial = material + "_splash";
    material += materialsuffix;
    randomoffsets = createscreeneffectoffsets(randomfloatrange(0, 1), randomfloatrange(0, 1), randomfloatrange(0, 1));
    createscreeneffect(side, material, 0.15, 2, randomoffsets, 1, 1, 1);
    createscreeneffect(side, splashmaterial, 0.15, 0.15, randomoffsets, 0, 1, 1);
  }
}

function function_9ca01a02f4efc7f6(smeansofdeath) {
  explosivemods = ["MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_GRENADE", "MOD_GRENADE_SPLASH"];

  if(array_contains(explosivemods, smeansofdeath)) {
    return true;
  }

  return false;
}

function function_3e54581e73dff375(smeansofdeath) {
  if(smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_IMPACT") {
    return true;
  }

  return false;
}

function function_6a97b15cdcd5961b(smeansofdeath) {
  if(smeansofdeath == "MOD_FIRE") {
    return true;
  }

  return false;
}

function function_c1af921b6351d49a(smeansofdeath) {
  if(smeansofdeath == "MOD_DOWN") {
    return true;
  }

  return false;
}

function function_9c9288020fccd597(factor, smeansofdeath, idamage, objweapon, shitloc) {
  if(!isalive(self)) {
    return false;
  }

  if(isDefined(idamage) && idamage <= 12) {
    return false;
  }

  if(utility::iswegameplatform()) {
    return false;
  }

  if(scripts\common\swim_common::isplayerunderwater()) {
    return false;
  }

  if(function_3e54581e73dff375(smeansofdeath) || function_6a97b15cdcd5961b(smeansofdeath)) {
    return false;
  }

  if(isDefined(objweapon) && objweapon.basename == "dragonsbreath_mp") {
    return false;
  }

  if(istrue(self.inlaststand)) {
    return false;
  }

  if(isDefined(shitloc) && shitloc == "shield") {
    return false;
  }

  return true;
}

function getplayersidesfromposition(position) {
  forwardvec = vectorNormalize(anglesToForward(self.angles));
  rightvec = vectorNormalize(anglestoright(self.angles));
  var_44ade5cf4179de8f = vectorNormalize((position[0], position[1], 0) - (self.origin[0], self.origin[1], 0));
  fdot = vectordot(var_44ade5cf4179de8f, forwardvec);
  rdot = vectordot(var_44ade5cf4179de8f, rightvec);
  sides = [];

  if(abs(fdot) > 0.819152) {
    sides["bottom"] = 1;
  } else if(rdot > 0) {
    sides["right"] = 1;
  } else {
    sides["left"] = 1;
  }

  return sides;
}

function createscreeneffectoffsets(x, y, scale) {
  offsets = [];
  offsets["x"] = x;
  offsets["y"] = y;
  offsets["scale"] = scale;
  return offsets;
}

function createscreeneffect(side, shader, intime, outtime, randomoffsets, fadein, lowres, containsblood) {
  hud = newclienthudelem(self);
  hud.sort = 13;
  hud.foreground = 0;
  hud.lowresbackground = lowres;
  hud.horzalign = "fullscreen";
  hud.vertalign = "fullscreen";
  hud.alpha = 0;
  hud.enablehudlighting = 1;
  hud.scramblerdisabled = 1;
  hud.var_8a8941ad64562137 = containsblood;
  x = 0;
  y = 0;
  finalx = 0;
  finaly = 0;
  finalscale = math::factor_value(0.9, 1.25, randomoffsets["scale"]);

  switch (side) {
    case #"hash_c9b3133a17a3b2d0":
      hud.aligny = "top";
      hud.alignx = "left";
      x = -640;
      y = math::factor_value(-30, 30, randomoffsets["y"]);
      finaly = y;
      finalx = math::factor_value(-55, 0, randomoffsets["x"]);
      break;
    case #"hash_96815ce4f2a3dbc5":
      hud.aligny = "top";
      hud.alignx = "right";
      x = 1280;
      y = math::factor_value(-30, 30, randomoffsets["y"]);
      finaly = y;
      finalx = math::factor_value(0, 55, randomoffsets["x"]) + 640;
      break;
    case #"hash_dcbcc9b3083fb78a":
      hud.aligny = "bottom";
      hud.alignx = "left";
      y = 960;
      x = math::factor_value(-50, 50, randomoffsets["x"]);
      finaly = math::factor_value(0, 50, randomoffsets["y"]);
      finaly += 480;
      finalx = x;
      break;
  }

  hud.x = x;
  hud.y = y;
  hud setshader(shader, 640, 480);
  thread screeneffectcleanup(hud);
  thread animatescreeneffect(hud, intime, outtime, finalx, finaly, finalscale, fadein);
}

function screeneffectcleanup(hud) {
  function_81a2b809749b4189(hud);

  if(isDefined(hud)) {
    hud notify("destroySreenEffectOverlay");
    hud destroy();
  }
}

function function_81a2b809749b4189(hud) {
  self endon("death_or_disconnect");
  hud waittill("destroySreenEffectOverlay");
}

function animatescreeneffect(hud, intime, outtime, x, y, scale, fadein) {
  self endon("death_or_disconnect");
  hud endon("destroySreenEffectOverlay");
  width = int(640 * scale);
  height = int(480 * scale);

  if(!fadein) {
    width = int(640 * scale);
    height = int(480 * scale);
    hud scaleovertime(intime, width, height);
    hud moveovertime(intime);
    hud.x = x;
    hud.y = y;
    intime = 0.05;
    hud.alpha = function_3d879029586de3(1);
    wait 0.05;
  } else {
    hud scaleovertime(intime, width, height);
    hud.x = x;
    hud.y = y;
    wait 0.15;
    hud fadeovertime(intime);
    hud.alpha = function_3d879029586de3(1);
    wait intime;
  }

  if(isDefined(hud)) {
    hud fadeovertime(outtime);
    hud.alpha = 0;
  }

  wait outtime + 0.05;

  if(isDefined(hud)) {
    hud notify("destroySreenEffectOverlay");
  }
}

function damageratio(idamage) {
  return math::normalize_value(10, 40, idamage);
}

function function_2a9705c393c0e2c4() {
  return self.deathsdoor || isDefined(self.damage) && isDefined(self.damage.deathsdooroverlaypulse) && isDefined(self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949) && self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949 > 0;
}

function function_41a40f1e0a6aa78e() {
  self notify("deaths_door_overlay_pulse");
  self endon("death_or_disconnect");
  self endon("deaths_door_overlay_pulse");
  thread function_47b9c7c77690bb03(1, 0.3);
  regendelaytime = function_5c0987ada94437df();
  starttime = gettime();

  if(!isDefined(self.heartbeat) || !isDefined(self.heartbeat.pulsetime)) {
    return;
  }

  while(function_2a9705c393c0e2c4()) {
    pulsefraction = self.heartbeat.pulsetime;
    pulsealphamax = math::factor_value(0.15, 0.45, pulsefraction);
    pulsealphamin = math::factor_value(0.05, 0.28, pulsefraction);
    timepassed = gettime() - starttime;

    if(regendelaytime > 0) {
      var_3b56fe29ad0cb0b5 = math::normalize_value(0, regendelaytime, timepassed);
    } else {
      var_3b56fe29ad0cb0b5 = 0;
    }

    pulsealpha = math::factor_value(pulsealphamax, pulsealphamin, var_3b56fe29ad0cb0b5);

    if(isDefined(self.damage.deathsdooroverlaypulse)) {
      pulsealpha *= self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949;
      pulsealpha = function_3d879029586de3(pulsealpha);
      self.damage.deathsdooroverlaypulse fadeovertime(0.05);
      self.damage.deathsdooroverlaypulse.alpha = pulsealpha;
    }

    waitframe();
  }
}

function function_252173bf5ac108a3(startalpha, time) {
  if(!isPlayer(self)) {
    return;
  }

  if(self.deathsdoor) {
    return;
  }

  if(!isDefined(self.damage)) {
    return;
  }

  self notify("deaths_door_overlay_pulse_oneoff");
  self endon("deaths_door_overlay_pulse_oneoff");
  self endon("deaths_door_overlay_pulse");
  self endon("death_or_disconnect");
  level endon("game_ended");
  starttime = time;

  while(time > 0) {
    if(!isDefined(self.damage.deathsdooroverlaypulse)) {
      return;
    }

    timefactor = math::normalize_value(0, starttime, time);
    pulsealpha = math::factor_value(0, startalpha, timefactor);
    pulsealpha = function_3d879029586de3(pulsealpha);
    self.damage.deathsdooroverlaypulse fadeovertime(0.05);
    self.damage.deathsdooroverlaypulse.alpha = pulsealpha;
    wait 0.05;
    time -= 0.05;
  }
}

function function_47b9c7c77690bb03(targetalpha, time) {
  self notify("lerpDeathDoorOverlayAlpha");
  self endon("lerpDeathDoorOverlayAlpha");
  self endon("death_or_disconnect");

  if(!isDefined(self.damage) || !isDefined(self.damage.deathsdooroverlaypulse)) {
    return;
  }

  timer = time;
  startalpha = self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949;

  while(timer > 0) {
    if(!isDefined(self.damage) || !isDefined(self.damage.deathsdooroverlaypulse)) {
      return;
    }

    normtime = math::normalize_value(0, time, timer);
    var_eeda4296ae80e949 = math::factor_value(targetalpha, startalpha, normtime);
    self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949 = var_eeda4296ae80e949;
    timer -= 0.05;
    waitframe();
  }

  if(isDefined(self.damage) && isDefined(self.damage.deathsdooroverlaypulse)) {
    self.damage.deathsdooroverlaypulse.var_eeda4296ae80e949 = targetalpha;
  }
}

function falldamageeffects(falldamage) {
  factor = falldamage / self.maxhealth;
  var_2ff497a47c266950 = getdvarfloat(@ "scr_falling_damage_min_shock_factor", 0.5);

  if(factor >= var_2ff497a47c266950) {
    var_4bc08db3876de031 = getdvarfloat(@ "scr_falling_damage_max_shock_duration", 3);
    var_b1505e7ce3af8fea = 1 - var_2ff497a47c266950;
    shockfactor = (factor - var_2ff497a47c266950) / var_b1505e7ce3af8fea;
    shockduration = shockfactor * var_4bc08db3876de031;
    scripts\cp_mp\utility\shellshock_utility::_shellshock("falldamage", "damage", shockduration, 0, 0);
  }

  pulsetime = math::factor_value(0.5, 0.5, factor);
  pulsealpha = math::factor_value(0.3, 0.7, factor);
  function_252173bf5ac108a3(pulsealpha, pulsetime);
}

function function_54117659a8e5c5b4() {
  self.var_dd452cc5c546120b = "deaths_door_mp";

  if(isDefined(level.var_c3934394c0f5cb03)) {
    self.var_dd452cc5c546120b = level.var_c3934394c0f5cb03;
    return;
  }

  if(level.gametype == "dungeons") {
    self.var_dd452cc5c546120b = "deaths_door_sp";
  }
}

function function_501be800abf11f33(fadetime, scale) {
  str_submix = default_to(self.var_dd452cc5c546120b, "deaths_door_mp");
  n_fadetime = default_to(fadetime, -1);
  n_scale = default_to(scale, 1);
  self setsoundsubmix(str_submix, n_fadetime, n_scale);
}

function function_a2b4e6088394bade(fadetime) {
  str_submix = default_to(self.var_dd452cc5c546120b, "deaths_door_mp");
  n_fadetime = default_to(fadetime, undefined);

  if(isDefined(n_fadetime)) {
    self clearsoundsubmix(str_submix, n_fadetime);
    return;
  }

  self clearsoundsubmix(str_submix);
}