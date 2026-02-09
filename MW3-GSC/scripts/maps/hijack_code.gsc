/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\hijack_code.gsc
****************************************/

_id_5949() {
  level._id_58D2 = maps\_utility::_id_272F("commander");
  level._id_58D2 maps\_utility::_id_0D04();
  level._id_58C6 = maps\_utility::_id_272F("advisor");
  level._id_58C6 maps\_utility::_id_0D04();
}

_id_594A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level._id_1F19 + "_" + var_0;
  }
  var_2 = _id_594B(var_0, var_1);
  return var_2;
}

_id_594B(var_0, var_1) {
  var_2 = getent(var_0, "script_noteworthy");
  var_3 = common_scripts\utility::getstruct(var_1, "targetname");
  var_2.origin = var_3.origin;

  if(isDefined(var_3.angles)) {
    var_2.angles = var_3.angles;
  }
  var_4 = var_2 maps\_utility::_id_166F();
  return var_4;
}

_id_594C(var_0) {
  var_1 = getent(var_0, "targetname");

  if(isDefined(var_1) && !isDefined(var_1.trigger_off)) {
    var_1 maps\_utility::_id_2703();
  }
}

_id_594D(var_0, var_1, var_2) {
  var_3 = "array_wait_any_" + var_1;

  foreach(var_5 in var_0) {}
  var_5 thread _id_594E(var_1, var_3);

  if(!isDefined(var_2)) {
    level waittill(var_3);
  } else {
    level common_scripts\utility::waittill_any_timeout(var_2, var_3);
  }
}

_id_594E(var_0, var_1) {
  self waittill(var_0);
  level notify(var_1);
}

_id_594F() {
  var_0 = getent(self.target, "targetname");
  var_1 = var_0.script_noteworthy;
  self.allowdeath = 1;
  self._id_1032 = "generic";
  self.health = 1;
  self._id_0EC6 = 1;
  self._id_0D16 = 1;
  self._id_0D50 = level._id_0C59["generic"][var_1];
  self.a._id_0D55 = 1;
  self.delete_on_death = 0;
  self._id_5950 = 1;
  self.ignoreme = 1;
  var_0 thread maps\_anim::_id_1246(self, var_1);
  wait 0.2;
  self kill();
}

_id_5951() {
  var_0 = "TAG_EYE";
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");
  self._id_5952 = 1;

  while(isDefined(self)) {
    wait 0.05;

    if(!isDefined(self)) {
      break;
    }

    playFXOnTag(level._effect["cold_breath"], self, var_0);
    wait(2.5 + randomfloat(2.5));
  }
}

_id_5953() {
  level endon("stop_rumbling");

  for(;;) {
    earthquake(0.15, 0.05, level.player.origin, 80000);
    wait 0.05;
  }
}

_id_5954() {
  _id_51F1();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player allowjump(0);
}

_id_5955() {
  level.player unlink();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowsprint(1);
  level.player allowjump(1);
  level._id_51F2 delete();
}

_id_51F1() {
  if(!isDefined(level._id_51F2)) {
    level._id_51F2 = maps\_utility::_id_1287("player_rig");
  }
  return level._id_51F2;
}

_id_45E4() {
  self.grenadeammo = 0;
}

_id_5956(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(var_1._id_1B71)) {
    var_1 delete();
  }
  var_1 playSound(var_0, "done");
  var_1 waittill("done");
}

_id_5957(var_0) {
  self endon("player_clear_of_idle");
  self endon("stop_prone_check");

  for(;;) {
    var_1 = distance(level.player.origin, self.origin);

    if(level.player getstance() == "prone" && var_1 < 50) {
      self invisiblenotsolid();
      level.player allowcrouch(0);
      level.player allowstand(0);
    } else {
      self visiblesolid();
      level.player allowcrouch(1);
      level.player allowstand(1);
      wait 0.05;

      if(isDefined(var_0) && var_0 == "true") {
        self notify("player_clear_of_idle");
      }
    }

    wait 0.05;
  }
}

_id_5958(var_0, var_1, var_2, var_3) {
  self rotateroll(var_0, var_1, var_2, var_3);
}

_id_5959(var_0, var_1, var_2, var_3) {
  self rotatepitch(var_0, var_1, var_2, var_3);
}

_id_595A(var_0, var_1, var_2, var_3) {
  self rotateto(var_0, var_1, var_2, var_3);
}

_id_595B(var_0, var_1, var_2) {
  setsaveddvar("phys_gravityChangeWakeupRadius", 1600);
  setphysicsgravitydir((var_0, var_1, var_2));
}

_id_595C(var_0, var_1, var_2) {
  var_3 = self;
  var_3 thread maps\_utility::play_sound_on_entity("foot_slide_plr_start");
  var_3 thread maps\_utility::_id_258E("foot_slide_plr_loop");
  var_4 = isDefined(level._id_27A4);

  if(!isDefined(var_0)) {
    var_0 = var_3 getvelocity() + (0, 0, -10);
  }
  if(!isDefined(var_1)) {
    var_1 = 10;
  }
  if(!isDefined(var_2)) {
    var_2 = 0.035;
  }
  var_5 = spawn("script_origin", var_3.origin);
  var_5.angles = var_3.angles;
  var_3._id_27A3 = var_5;
  var_5 moveslide((0, 0, 15), 15, var_0);

  if(var_4) {
    var_3 playerlinktodelta(var_5, undefined, 0);
  } else {
    var_3 playerlinkto(var_5, undefined, 0, 180, 180, 180, 180, 1);
  }
  if(!isDefined(level._id_595D)) {
    var_3 allowprone(0);
  }
  var_3 thread maps\_utility_code::_id_142F(var_5, var_1, var_2);
}

_id_595E() {
  var_0 = self;

  if(!isDefined(var_0._id_27A3)) {
    return;
  }
  var_0 notify("stop soundfoot_slide_plr_loop");
  var_0 thread maps\_utility::play_sound_on_entity("foot_slide_plr_end");
  var_0 unlink();
  var_0 setvelocity(var_0._id_27A3.slidevelocity);
  var_0._id_27A3 delete();
  var_0 allowprone(1);
  var_0 allowstand(1);
  var_0 notify("stop_sliding");
}

_id_595F() {
  level endon("stop_rocking");
  var_0 = level._id_5960;
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_2 = undefined;

  if(!isDefined(var_0)) {
    var_1.angles = (0, 0, 0);
  } else {
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
  }

  var_3 = 1;
  level._id_4B47[0] = 0.25;
  level._id_4B47[1] = 0.625;

  for(;;) {
    var_4 = randomfloatrange(6.0, 7.0);
    var_5 = var_3 * randomfloatrange(level._id_4B47[0], level._id_4B47[1]);
    var_3 = -1 * var_3;
    var_6 = (0, 0, var_5);
    common_scripts\utility::array_thread(level._id_5961, ::_id_595A, var_6, var_4, var_4 / 3, var_4 / 3);
    wait(var_4);
  }
}

_id_4B45(var_0) {
  common_scripts\utility::flag_wait("obj_capturesub_complete");
  level notify("stop_rocking");
  level.player playersetgroundreferenceent(undefined);
  self delete();

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_4B52(var_0) {
  level endon("stop_rocking");
  thread _id_4B53();
  var_1 = 0;
  var_2 = common_scripts\utility::getstruct("jolter", "targetname");

  for(;;) {
    var_3 = anglestoup(var_0.angles);
    var_4 = -1 * var_3;
    var_5 = var_4 * (1, 10, 0.75);
    var_6 = vectornormalize(var_5);
    setphysicsgravitydir(var_6);
    var_1++;

    if(var_1 > 10) {
      physicsjitter(var_2.origin, 1000, 800, 0.01, 0.1);
      var_1 = 0;
    }

    wait 0.05;
  }
}

_id_4B53() {
  level waittill("stop_rocking");
  wait 0.05;
  setphysicsgravitydir((0, 0, -1));
}

_id_4B54() {
  level._id_4B55 = [];
  level._id_4B56 = [];
  level._id_4B57 = [];
  var_0 = getEntArray("sub_pressuredoor_rocker", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getent(var_2.target, "targetname");
    var_2 linkto(var_3);
    level._id_4B55[level._id_4B55.size] = var_3;
  }

  var_0 = getEntArray("sub_pressuredoor_rocker_opposite", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getent(var_2.target, "targetname");
    var_2 linkto(var_3);
    level._id_4B56[level._id_4B56.size] = var_3;
  }

  var_7 = getEntArray("dyn_hanger", "targetname");

  foreach(var_9 in var_7) {
    var_3 = getent(var_9.target, "targetname");
    var_9 linkto(var_3);
    level._id_4B57[level._id_4B57.size] = var_3;
  }
}

_id_5962(var_0) {
  thread _id_5964();
  var_1 = var_0;
  wait(var_1);
  common_scripts\utility::flag_set("stop_turbulence");
  var_2 = abs(level._id_5963[0]) / 8;
  level._id_5960 rotateto((0, 0, 0), var_2, 0, 0);
  wait(var_2);
}

_id_5964() {
  level endon("stop_turbulence");
  var_0 = 1;
  level._id_4B47[0] = 0.3;
  level._id_4B47[1] = 0.5;
  level._id_5965[0] = 2;
  level._id_5965[1] = 5;

  for(;;) {
    var_1 = randomfloatrange(0.1, 0.2);
    var_2 = var_0 * randomfloatrange(level._id_5965[0], level._id_5965[1]);
    var_3 = var_0 * randomfloatrange(level._id_4B47[0], level._id_4B47[1]);
    var_4 = var_0 * randomfloatrange(level._id_4B47[0], level._id_4B47[1]);
    var_0 = -1 * var_0;
    level._id_5963 = (var_2, var_3, var_4);
    earthquake(0.1, var_1, level.player.origin, 80000);
    level._id_5960 rotateto(level._id_5963, var_1, var_1 / 3, var_1 / 3);
    wait(var_1);
  }
}

_id_5966(var_0, var_1) {
  var_2 = randomfloatrange(0, 0.9);
  wait(var_2);
  var_0 = var_0 * level._id_5967[self.model];
  var_3 = var_1 * var_0;
  self physicslaunchclient(self.origin, var_3);
}

_id_5968(var_0, var_1, var_2) {
  var_3 = randomfloatrange(0, 0.9);
  wait(var_3);
  physicsexplosionsphere(self.origin, var_0, var_1, var_2);
}

_id_09FA(var_0, var_1) {
  var_2 = _id_473C();

  if(var_0) {
    var_2 fadeovertime(var_0);
  }
  if(isDefined(var_1)) {
    var_2.alpha = var_1;
  } else {
    var_2.alpha = 1;
  }
  wait(var_0);
}

_id_17CC(var_0) {
  if(level._id_16C9) {
    return;
  }
  level notify("now_fade_in");
  var_1 = _id_473C();

  if(var_0) {
    var_1 fadeovertime(var_0);
  }
  var_1.alpha = 0;
  wait(var_0);
}

_id_473C() {
  if(!isDefined(level._id_473D)) {
    level._id_473D = maps\_hud_util::_id_09A7("black", 0, level.player);
  }
  level._id_473D.sort = -1;
  level._id_473D.foreground = 0;
  return level._id_473D;
}

_id_5969() {
  self._id_596A = spawn("script_origin", self.origin + (0, 0, 30));
  self._id_596A.angles = level._id_5960.angles;
  level._id_5961 = maps\_utility::_id_0BC3(level._id_5961, self._id_596A);
  self linkto(self._id_596A);
  self._id_596A movez(45, 0.1);
  self hide();
}

_id_596B() {
  if(getDvar("airmasks") == "0") {
    return;
  }
  self show();
  var_0 = randomfloatrange(0.75, 1.2);
  self._id_596A movez(-55, var_0, var_0 / 3, var_0 / 3);
  wait(var_0);
  self._id_596A movez(10, var_0 / 2);
  wait(var_0 / 2);
}

_id_596C(var_0, var_1, var_2, var_3) {
  maps\_utility::_id_2636(var_0, var_1, var_3);
  common_scripts\utility::flag_set(var_2);
}

_id_596D(var_0, var_1, var_2) {
  level notify("temp_dialogue", var_0, var_1, var_2);
  level endon("temp_dialogue");

  if(!isDefined(var_2)) {
    var_2 = 4;
  }
  if(isDefined(level._id_596E)) {
    level._id_596E destroy();
    level._id_596E = undefined;
  }

  level._id_596E = newhudelem();
  level._id_596E.x = -60;
  level._id_596E.y = -62;
  level._id_596E settext("^2" + var_0 + ": ^7" + var_1);
  level._id_596E.fontscale = 1.46;
  level._id_596E.alignx = "center";
  level._id_596E.aligny = "middle";
  level._id_596E.horzalign = "center";
  level._id_596E.vertalign = "bottom";
  level._id_596E.sort = 1;
  wait(var_2);
  thread _id_596F();
}

_id_596F() {
  level endon("temp_dialogue");

  for(var_0 = 1.0; var_0 > 0.0; var_0 = var_0 - 0.1) {
    level._id_596E.alpha = var_0;
    wait 0.05;
  }

  level._id_596E destroy();
}

_id_5970(var_0) {
  var_1 = 0.15;
  var_2 = 0.6;
  var_3 = var_2;

  for(;;) {
    while(var_3 > var_1) {
      var_3 = max(var_3 - var_2 / 7.5, var_1);
      self setlightintensity(var_3);
      wait 0.05;
    }

    wait 0.15;
    _id_5971(var_0);

    while(var_3 < var_2) {
      var_3 = min(var_3 + var_2 / 10, var_2);
      self setlightintensity(var_3);
      wait 0.05;
    }

    wait 0.15;
  }
}

_id_5971(var_0) {
  switch (var_0) {
    case 0:
      common_scripts\utility::exploder("light_0");
      break;
    case 1:
      common_scripts\utility::exploder("light_1");
      break;
    case 2:
      common_scripts\utility::exploder("light_2");
      break;
    case 3:
      common_scripts\utility::exploder("light_3");
      break;
    default:
      break;
  }
}

_id_5972() {
  var_0 = "";

  switch (level.gameskill) {
    case 1:
    case 0:
      var_0 = "regular";
      break;
    case 2:
      var_0 = "hardened";
      break;
    case 3:
      var_0 = "veteran";
      break;
    default:
      break;
  }

  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3._id_2148)) {
      continue;
    }
    if(_id_5973(var_3, var_0, maps\_utility::_id_12C1())) {
      var_3 delete();
    }
  }
}

_id_5973(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = strtok(var_0._id_2148, ",");
  var_5 = 0;

  foreach(var_7 in var_4) {
    var_3[var_5] = strtok(var_7, "_");
    var_5++;
  }

  foreach(var_10 in var_3) {
    var_11 = maps\_utility::_id_0AD1(var_10, "coop");
    var_12 = maps\_utility::_id_0AD1(var_10, "sp");

    if(var_11 || var_12) {
      if(var_2 && !var_11) {
        continue;
      }
      if(!var_2 && !var_12) {
        continue;
      }
    }

    var_13 = maps\_utility::_id_0AD1(var_10, "regular");
    var_14 = maps\_utility::_id_0AD1(var_10, "hardened");
    var_15 = maps\_utility::_id_0AD1(var_10, "veteran");

    if(var_13 || var_14 || var_15) {
      if(var_1 == "regular" && !var_13) {
        continue;
      }
      if(var_1 == "hardened" && !var_14) {
        continue;
      }
      if(var_1 == "veteran" && !var_15) {
        continue;
      }
    }

    return 0;
  }

  return 1;
}