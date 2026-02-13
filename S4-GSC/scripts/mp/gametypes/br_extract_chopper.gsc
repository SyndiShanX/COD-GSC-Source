/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_extract_chopper.gsc
*******************************************************/

_id_E2E3(var_0, var_1, var_2, var_3) {
  var_4 = var_0.origin;
  var_5 = var_4;
  var_6 = (0, 0, 0);
  var_7 = 24000;
  var_8 = getent("airstrikeheight", "targetname");
  var_9 = var_8.origin[2];
  var_10 = "jackal";
  var_11 = level._id_9AAC - var_0.origin;
  var_11 = (var_11[0], var_11[1], 0);
  var_12 = vectornormalize(var_11);
  var_13 = var_12 * -10000 + (0, 0, 1) * var_9;
  var_14 = (var_4[0], var_4[1], var_9);
  var_15 = _id_5954();
  var_16 = spawn("trigger_radius", var_4, 0, 90, 128);
  var_16.angles = (0, 0, 0);
  var_16.team = self.team;
  var_16._id_ADAE = self.team;
  var_16._id_1041A = "any";
  var_16._id_A97E = (0, 0, 16);
  var_16._id_96CF = var_4;
  var_17 = _id_24AD(0, var_13, var_14, var_15, var_16, var_1, self.team, var_3);
  var_17._id_AAFD = var_2;
  var_17._id_110CF = var_0;
  return var_17;
}

_id_5954() {
  var_0 = spawnStruct();
  var_0._id_1F84 = 1;
  var_0._id_5B70 = "offhand_fired";
  var_0._id_887C = 1;
  var_0._id_8CED = 5;
  var_0._id_936C = 0;
  var_0._id_9925 = gettime();
  var_0._id_CF97 = "gesture_script_weapon";
  var_0.streakname = "jackal";
  var_0._id_EA15 = undefined;
  var_0._id_04CC = -1;
  var_0._id_04FE = "ks_gesture_generic_mp";
  var_0.objweapon = makeweapon(var_0._id_04FE);
  return var_0;
}

_id_24AD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = undefined;

  if(isDefined(var_4)) {
    var_8 = var_4._id_9B4D;

    if(!isDefined(var_8)) {
      var_8 = spawnStruct();

      if(isDefined(var_5)) {
        var_8._id_96CF = var_5;
      } else if(isDefined(var_4._id_96CF)) {
        var_8._id_96CF = var_4._id_96CF;
      } else {
        var_8._id_96CF = var_4.trigger.origin;
      }

      var_8.angles = (0, 0, 0);
      var_8._id_EA52 = "equip_deploy_succeeded";
      var_8._id_04ED = spawn("script_model", var_8._id_96CF);
      var_8._id_04ED setModel("ks_marker_mp");
      var_8._id_04ED setotherent(self);
    }

    if(!isDefined(var_8._id_96CF)) {
      self notify("cancel_littlebird");
      return 0;
    }
  }

  self notify("called_in_littlebird");
  var_9 = getent("airstrikeheight", "targetname");

  if(isDefined(var_9)) {
    var_10 = var_9.origin[2] + 500;
  } else {
    var_10 = 1300;
  }

  if(isDefined(var_8) && isDefined(var_8._id_96CF)) {
    var_2 = var_8._id_96CF;
  }

  var_2 = var_2 * (1, 1, 0);
  var_11 = var_2 + (0, 0, var_10);
  var_12 = _id_E319(var_0, self, var_1, var_11, var_3, var_4);
  var_12._id_991F = var_4;
  var_12._id_AEDC = var_11;
  thread _id_A0F3(var_12, var_8, var_6, var_7);
  return var_12;
}

_id_E319(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_3 - var_2);

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var_7 = 99;
    var_8 = 10000;
  } else if(scripts\mp\utility\game::getgametype() == "btm") {
    var_7 = 99;
    var_8 = 99999;
  } else {
    var_7 = 1;
    var_8 = 10000;
  }

  var_9 = "veh8_mil_air_lbravo";
  var_10 = spawnhelicopter(var_1, var_2, var_6, "lbravo_infil_mp", var_9);

  if(!isDefined(var_10)) {
    return;
  }
  if(isDefined(var_5)) {
    var_10._id_991F = var_5;
  }

  var_10 thread _id_7435();
  var_10._id_42E9 = ::_id_2F40;
  var_10.speed = 50;
  var_10.accel = 125;
  var_10.health = var_8;
  var_10.maxhealth = var_10.health;
  var_10.team = var_1.team;
  var_10.owner = var_1;
  var_10 setCanDamage(1);
  var_10._id_461E = var_3;
  var_10._id_936C = var_0;
  var_10._id_8B45 = 1;
  var_10.streakinfo = var_4;
  var_10.streakname = var_4.streakname;
  var_10.streakinfo = var_4;
  var_10._id_5C8A = var_7;
  var_10 scripts\mp\utility\killstreak::_id_1155(var_4.streakname, "Killstreak_Air", var_1, 0, 1, 100);
  var_10 setmaxpitchroll(0, 90);
  var_10 vehicle_setspeed(var_10.speed, var_10.accel);
  var_10 sethoverparams(50, 100, 50);
  var_10 setturningability(0.05);
  var_10 setyawspeed(45, 25, 25, 0.5);
  var_10 setotherent(var_1);
  var_10._id_FE90 = spawn("script_model", var_10 gettagorigin("tag_origin"));
  var_10._id_FE90 linkto(var_10, "tag_origin");

  if(!isDefined(level._id_8B53)) {
    level._id_8B53 = [];
  }

  level._id_8B53[level._id_8B53.size] = var_10;
  level._id_8B53 = scripts\engine\utility::_id_1BD1(level._id_8B53);
  var_10 thread _id_0A44::_id_5C7F(undefined, undefined);
  var_10 thread _id_958F();
  var_10 thread _id_466A();
  return var_10;
}

_id_466A() {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
}

_id_46CE(var_0, var_1) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self playLoopSound(var_1);
}

_id_958F() {
  self endon("jackal_gone");
  var_0 = self.owner;
  self waittill("death");

  if(isDefined(self._id_F899) && isDefined(self._id_EEF1)) {
    scripts\mp\utility\outline::outlinedisable(self._id_EEF1, self._id_F899);
  }

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_8EE2)) {
    self vehicle_setspeed(25, 5);
    thread _id_958C(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  if(isDefined(self._id_991F)) {
    self._id_991F notify("extraction_destroyed");
  }

  _id_9591();
}

_id_9591() {
  self playSound("dropship_explode_mp");
  level._id_8B53[level._id_8B53.size - 1] = undefined;
  self notify("explode");

  if(isDefined(self._id_991F)) {
    playFXOnTag(scripts\engine\utility::getfx("jackal_explosion"), self, "tag_origin");
  }

  wait 0.35;
  thread _id_958D();
}

_id_958D() {
  scripts\mp\utility\print::_id_BD15("killstreak ended - jackal", self.owner);

  if(isDefined(self._id_F81F)) {
    self._id_F81F delete();
  }

  if(isDefined(self._id_319B)) {
    self._id_319B delete();
  }

  if(isDefined(self._id_FE90)) {
    self._id_FE90 delete();
  }

  foreach(var_1 in level._id_326D) {
    var_1._id_01E3 = undefined;
  }

  self delete();
}

_id_958C(var_0) {
  self endon("explode");
  self _meth_807E();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self _meth_838A(self.angles[1] + var_0 * 2.5);
}

_id_7435() {
  self endon("death");
  self endon("leaving");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::_id_9ACB(var_9, var_13);

    if((var_9.basename == "aamissile_projectile_mp" || var_9.basename == "nuke_mp") && var_4 == "MOD_EXPLOSIVE" && var_0 >= self.health) {
      if(isDefined(self._id_AAFD)) {
        [[self._id_AAFD]](self.team);
      }

      _id_2F40(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
    }
  }
}

_id_2F40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }
  }

  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["team"] == self.team && !level._id_5FA5 && level.teambased) && var_1 != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  var_2 = scripts\mp\utility\killstreak::_id_6B66(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::_id_8DD6(var_1, var_5, self, var_4, var_2);
  var_1 _id_07C4::_id_FC47("");
  _id_07C3::_id_9757(self, var_2, var_1, var_7, var_6, var_4, var_10, undefined, var_11, var_3, getcompleteweaponname(var_5));

  if(self.health <= var_2) {
    if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {
      _id_07C3::_id_AB18("jackal", var_1, var_5, var_4, var_2, "destroyed_jackal", "jackal_destroyed", "callout_destroyed_harrier");
    }
  }

  if(self.health - var_2 <= 900 && (!isDefined(self._id_DE57) || !self._id_DE57)) {
    self._id_DE57 = 1;
  }

  self _meth_842C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

_id_A0F3(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 endon("leaving");
  var_0 setvehgoalpos(var_0._id_AEDC, 1);
  var_0 thread _id_33E0(var_0._id_AEDC);
  var_0 waittill("goal");
  var_0 thread _id_10B65();

  if(isDefined(var_3)) {
    var_4 = var_0.speed;
    var_5 = var_0.accel;
  } else {
    var_4 = var_0.speed / 4;
    var_5 = var_0.accel / 6;
  }

  var_0 vehicle_setspeed(var_4, var_5);
  var_0 _id_958E(var_1._id_96CF, var_0._id_110CF, var_2);
}

_id_9592() {
  self endon("death");
  var_0 = self.speed;
  var_1 = self.accel;
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self._id_916C = 1;
  self _meth_807E();

  if(isDefined(self._id_F899) && isDefined(self._id_EEF1)) {
    scripts\mp\utility\outline::outlinedisable(self._id_EEF1, self._id_F899);
  }

  var_2 = int(self.speed / 14);
  var_3 = int(self.accel / 16);

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  self vehicle_setspeed(var_2, var_3);
  var_4 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_4 = var_4 + (0, 0, 1000);
  self setvehgoalpos(var_4, 1);

  if(isDefined(self._id_FE90)) {
    self._id_FE90 delete();
  }

  self waittill("goal");
  var_5 = _id_6C1C();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var_5, 1);
  self waittill("goal");
  self stoploopsound();
  level._id_8B53[level._id_8B53.size - 1] = undefined;
  self notify("jackal_gone");

  if(scripts\mp\utility\game::getgametype() != "arm") {
    _id_958D();
  }
}

_id_6C1C() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

_id_958E(var_0, var_1, var_2) {
  _id_4809(var_0, var_1);

  if(scripts\mp\utility\game::getgametype() != "vip" && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "btm") {
    var_1._id_EFA7 = scripts\engine\utility::array_remove(var_1._id_EFA7, var_2 + self._id_E496);
    thread _id_9592();
  }
}

_id_4809(var_0, var_1) {
  self endon("bugOut");
  var_2 = undefined;
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = _id_F3C9(var_3, var_4, 20);
  var_2 = (var_3, var_4, var_5);

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var_5 = _id_F3C9(var_3, var_4, 5, 1);
    var_2 = (var_3, var_4, var_5 + 200);
  }

  self _meth_807E();
  self setvehgoalpos(var_2, 1);
  self waittill("goal");

  if(scripts\mp\utility\game::getgametype() == "vip") {
    self notify("esc_littlebird_arrive");
  } else if(scripts\mp\utility\game::getgametype() == "arm") {
    self vehicle_setspeed(self.speed / 8, self.accel / 12);
    var_5 = _id_F3C9(var_3, var_4, undefined, 1);
    var_2 = (var_3, var_4, var_5 + 120);
    self setvehgoalpos(var_2, 1);
    self notify("esc_littlebird_arrive");
    self waittill("goal");
    self vehicle_setspeed(self.speed / 3, self.accel / 4);
  } else if(scripts\mp\utility\game::getgametype() == "btm")
    self notify("esc_littlebird_arrive");
}

_id_F3C9(var_0, var_1, var_2, var_3) {
  var_4 = 30;
  var_5 = _id_F3CB(var_0, var_1, var_3);
  var_6 = var_5 + var_4;

  if(isDefined(var_2)) {
    var_6 = var_6 + randomint(var_2);
  }

  return var_6;
}

_id_F3CB(var_0, var_1, var_2) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_3 = -99999;
  var_4 = self.origin[2] + 2000;
  var_5 = level._id_1F9C;
  var_6 = [self];

  if(isDefined(self._id_502B)) {
    foreach(var_8 in self._id_502B) {
      var_6[var_6.size] = var_8;
    }
  }

  var_10 = 256;

  if(isDefined(var_2)) {
    var_11 = scripts\engine\trace::ray_trace((var_0, var_1, var_4), (var_0, var_1, var_3), var_6, undefined, undefined, 1);
  } else {
    var_11 = scripts\engine\trace::_id_E409((var_0, var_1, var_4), (var_0, var_1, var_3), 256, var_6, undefined, 1);
  }

  if(var_11["position"][2] < var_5) {
    var_12 = var_5;
  } else {
    var_12 = var_11["position"][2];
  }

  return var_12;
}

_id_10B65() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread _id_9592();
}

_id_33E0(var_0) {
  self endon("goal");
  self endon("death");
  self endon("leaving");

  for(;;) {
    if(distance2d(self.origin, var_0) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

_id_0E0A() {
  thread _id_9592();
}