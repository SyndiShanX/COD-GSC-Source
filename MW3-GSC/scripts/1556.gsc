/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1556.gsc
**************************************/

_id_3B9C() {
  precacheitem("airdrop_marker_mp");
  precachemodel("com_plasticcase_friendly");
  precachemodel("com_plasticcase_enemy");
  precachemodel("com_plasticcase_taskforce141");
  precacheshader("compass_objpoint_ammo_friendly");
}

_id_3B9D() {
  if(!isDefined(level._id_3B9E)) {
    level._id_3B9E = 24;
  }
  level._id_3B9F = 0;
  level._id_3BA0 = spawnStruct();
  _id_3BB0();
  level._id_3BA0._id_3BA1 = 1;
}

_id_3BA2() {
  return isDefined(level._id_3BA0) && isDefined(level._id_3BA0._id_3BA1);
}

_id_3BA3(var_0) {
  var_1 = undefined;

  if(_id_0611::isusingremote()) {
    return 0;
  }
  var_1 = _id_3BA5(var_0);

  if((!isDefined(var_1) || !var_1) && !isDefined(self._id_3BA4)) {
    return 0;
  }
  return 1;
}

_id_3BA5(var_0) {
  self endon("death");
  self endon("airdrop_marker_thrown");
  self._id_3BA4 = undefined;
  thread _id_3BA6(var_0);
  var_1 = self getcurrentweapon();

  if(isairdropmarker(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = undefined;
  }
  while(isairdropmarker(var_1)) {
    self waittill("weapon_change", var_1);

    if(isairdropmarker(var_1)) {
      var_2 = var_1;
    }
  }

  self notify("stopWatchingAirDropMarker");

  if(!isDefined(var_2)) {
    return 0;
  }
  return !(self getammocount(var_2) && self hasweapon(var_2));
}

_id_3BA6(var_0) {
  self notify("watchAirDropMarkerUsage");
  self endon("disconnect");
  self endon("watchAirDropMarkerUsage");
  self endon("stopWatchingAirDropMarker");
  thread _id_3BA7(var_0);

  for(;;) {
    self waittill("grenade_pullback", var_1);

    if(!isairdropmarker(var_1)) {
      continue;
    }
    common_scripts\utility::_disableusability();
    beginairdropmarkertracking();
  }
}

_id_3BA7(var_0) {
  self notify("watchAirDropMarker");
  self endon("watchAirDropMarker");
  self endon("spawned_player");
  self endon("disconnect");

  for(;;) {
    self waittill("grenade_fire", var_1, var_2);

    if(!isairdropmarker(var_2)) {
      continue;
    }
    self notify("airdrop_marker_thrown");
    var_1 thread airdropdetonateonstuck();
    var_1.owner = self;
    var_1.weaponname = var_2;
    self._id_3BA4 = var_1;
    var_1 thread _id_3BA8(var_0);
  }
}

_id_3BA8(var_0) {
  self notify("airDropMarkerActivate");
  self endon("airDropMarkerActivate");
  self waittill("explode", var_1);
  var_2 = self.owner;

  if(!isDefined(var_2)) {
    return;
  }
  wait 0.05;
  level _id_3BA9(var_0, var_2, var_1, randomfloat(360));
}

_id_3BA9(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getflyheightoffset(var_2);

  if(!isDefined(var_4)) {
    var_4 = 0;
  }
  var_5 = var_5 + var_4;

  if(!isDefined(var_1)) {
    return;
  }
  var_6 = var_2 * (1, 1, 0) + (0, 0, var_5);
  var_7 = getpathstart(var_6, var_3);
  var_8 = getpathend(var_6, var_3);
  var_6 = var_6 + anglesToForward((0, var_3, 0)) * -50;
  var_9 = _id_3BAA(var_1, var_7, var_6);
  var_9 endon("death");
  var_9 setvehgoalpos(var_6, 1);
  var_9 thread _id_3BAB(var_0, var_2, var_5, 0, undefined, var_7);
  wait 2;
  var_9 vehicle_setspeed(75, 40);
  var_9 setyawspeed(180, 180, 180, 0.3);
  var_9 waittill("goal");
  wait 0.1;
  var_9 notify("drop_crate");
  var_9 setvehgoalpos(var_8, 1);
  var_9 vehicle_setspeed(300, 75);
  var_9.leaving = 1;
  var_9 waittill("goal");
  var_9 notify("leaving");
  var_9 notify("delete");
  var_9 delete();
}

_id_3BAA(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = getent("airdrop_littlebird", "targetname");
  var_4.origin = var_1;
  var_4.angles = var_3;
  var_5 = maps\_vehicle::_id_2A99("airdrop_littlebird");
  var_5 hide();

  if(!isDefined(var_5)) {
    return;
  }
  if(isDefined(self.mgturret)) {
    self notify("mg_off");

    foreach(var_7 in self.mgturret) {
      var_7 turretfiredisable();
      var_7 setmode("manual");
    }
  }

  var_5.health = 500;
  var_5 setCanDamage(0);
  var_5.owner = var_0;
  var_5.team = var_0.team;
  var_5 thread heli_existence();
  var_5 setmaxpitchroll(45, 85);
  var_5 vehicle_setspeed(250, 175);
  var_5 common_scripts\utility::delaycall(0.1, ::show);
  return var_5;
}

heli_existence() {
  common_scripts\utility::waittill_any("crashing", "leaving");
  self notify("helicopter_gone");
}

_id_3BAB(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  self.owner endon("disconnect");
  var_6 = _id_3BAC(self.owner, var_0, var_5);
  var_6 linkto(self, "tag_ground", (32, 0, 5), (0, 0, 0));
  var_6.angles = (0, 0, 0);
  var_6 show();
  var_7 = self.veh_speed;
  self waittill("drop_crate");
  var_6 unlink();
  var_6 physicslaunchserver((0, 0, 0), (randomint(5), randomint(5), randomint(5)));
  var_6 thread _id_3BB7();
  var_6 thread _id_00D2(var_1, 64);
}

_id_3BAC(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_2);
  var_3.inuse = 0;
  var_3.curprogress = 0;
  var_3.usetime = 0;
  var_3.userate = 0;

  if(isDefined(var_0)) {
    var_3.owner = var_0;
  } else {
    var_3.owner = undefined;
  }
  var_3.cratetype = var_1;
  var_3.targetname = "care_package";
  var_3 setModel("com_plasticcase_taskforce141");
  var_3 _id_3BB4();
  var_3.collision thread _id_3BB6(var_3);
  var_3._id_3BAD = spawn("script_model", var_2);
  var_3._id_3BAD setModel("com_plasticcase_friendly");
  var_3._id_3BAD common_scripts\utility::delaycall(0.25, ::linkto, var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_3 thread _id_3BB5(var_0);
  level._id_3B9F++;
  return var_3;
}

_id_3BAE() {
  if(isDefined(self.objidfriendly)) {
    objective_delete(self.objidfriendly);
  }
  if(isDefined(level._id_3BAF) && level._id_3BAF.size) {
    level._id_3BAF = common_scripts\utility::array_remove(level._id_3BAF, self);
    level._id_3B9F--;
  }

  if(isDefined(self)) {
    self._id_3BAD delete();
    self delete();
  }
}

_id_3BB0() {
  var_0 = getEntArray("airdrop_crate_collision", "targetname");

  foreach(var_2 in var_0) {
    var_2 connectpaths();
    var_2 notsolid();
  }

  level._id_3BB1 = var_0;
}

_id_3BB2() {
  var_0 = undefined;

  foreach(var_2 in level._id_3BB1) {
    if(!isDefined(var_2._id_3BB3)) {
      var_0 = var_2;
      break;
    }
  }

  return var_0;
}

_id_3BB4() {
  var_0 = _id_3BB2();
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  var_0 solid();
  var_0 linkto(self);
  var_0._id_3BB3 = 1;
  self.collision = var_0;
}

_id_00D2(var_0, var_1) {
  while(isDefined(self) && distancesquared(self.origin, var_0) > 1024) {
    wait 0.05;
  }
  if(!isDefined(self)) {
    return;
  }
  var_2 = getaispeciesarray("axis", "all");

  foreach(var_4 in var_2) {
    if(distancesquared(self.origin, var_4.origin) < var_1 * var_1) {
      if(isDefined(self.owner)) {
        var_4 dodamage(300, self.origin, self.owner, self);
        continue;
      }

      var_4 dodamage(300, self.origin);
    }
  }
}

_id_3BB5(var_0) {
  var_0 waittill("death");
  _id_3BAE();
}

_id_3BB6(var_0) {
  var_0 waittill("death");
  self unlink();
  self connectpaths();
  self notsolid();
  self._id_3BB3 = undefined;
}

_id_3BB7() {
  self waittill("physics_finished");
  self._id_3BB8 = gettime();

  if(!isDefined(level._id_3BAF)) {
    level._id_3BAF = [];
  }
  level._id_3BAF[level._id_3BAF.size] = self;

  if(level._id_3BAF.size > 4) {
    level._id_3BAF[0] _id_3BAE();
  }
  thread _id_3BBB();
  level thread _id_3BB9(self, self.owner);
}

_id_3BB9(var_0, var_1) {
  var_0 endon("death");
  var_2 = 120;

  if(isDefined(level._id_3BBA)) {
    var_2 = level._id_3BBA;
  }
  if(var_2 <= 0) {
    return;
  }
  wait(var_2);

  while(var_0.curprogress != 0) {
    wait 1;
  }
  var_0 _id_3BAE();
}

_id_3BBB() {
  self endon("death");
  _id_3BC3();
  thread _id_3BCD();
  thread _id_3BCE();

  if(isDefined(level._id_3BBC)) {
    self thread[[level._id_3BBC]]();
  }
  for(;;) {
    self waittill("captured", var_0);

    if(isDefined(self.owner) && var_0 != self.owner) {
      thread _id_3BC0(var_0);
    }
    if(isPlayer(var_0)) {
      var_1 = var_0;
      var_1 playlocalsound("ammo_crate_use");

      if(isDefined(self._id_3BBD._id_3BBE)) {
        if(issubstr(self._id_3BBD.streaktype, "specialty_")) {
          var_1 thread[[self._id_3BBD._id_3BBE]](self._id_3BBD.streaktype);
        } else {
          var_1 thread[[self._id_3BBD._id_3BBE]]();
        }
      } else {
        var_1 thread _id_0611::_id_3BBF(self.cratetype);
      }
    }

    _id_3BAE();
  }
}

_id_3BC0(var_0) {
  self notify("hijacked", var_0);

  if(!isPlayer(self.owner)) {
    return;
  }
  if(var_0.team == self.owner.team) {
    if(isDefined(level._id_3BC1)) {
      self.owner thread[[level._id_3BC1]](var_0);
    }
  } else if(isDefined(level._id_3BC2)) {
    self.owner thread[[level._id_3BC2]](var_0);
  }
}

_id_3BC3() {
  self.collision disconnectpaths();
  var_0 = _id_0611::_id_3BC4(self.cratetype);
  self._id_3BBD = var_0;
  var_1 = _id_3BC9();
  objective_add(var_1, "invisible", (0, 0, 0));
  objective_position(var_1, self.origin);
  objective_icon(var_1, "compass_objpoint_ammo_friendly");
  self.objidfriendly = var_1;
  _id_3BCB(var_0._id_3BC5, (0, 0, 24), 14, 14);
  self setcursorhint("HINT_NOICON");
  self sethintstring(var_0._id_3BC6);
  self makeusable();

  if(isDefined(level._id_3BC7) && level._id_3BC7) {
    thread _id_3BC8();
  }
}

_id_3BC8() {
  self endon("death");
  self endon("captured");
  wait 2;
  var_0 = undefined;
  var_1 = [];

  foreach(var_3 in level.players) {
    if(isDefined(self.collision) && self.collision istouching(var_3)) {
      if(isDefined(self.owner) && self.owner == var_3) {
        var_0 = var_3;
        continue;
      }

      var_1[var_1.size] = var_3;
    }
  }

  if(isDefined(var_0)) {
    self notify("trigger", var_0);
    return;
  }

  if(var_1.size > 0) {
    self notify("trigger", var_1[0]);
  }
}

_id_3BC9() {
  var_0 = undefined;

  if(!isDefined(level._id_3BCA)) {
    var_0 = level._id_3B9E;
  } else {
    var_0 = level._id_3BCA + 1;
  }
  if(var_0 > level._id_3B9E + 7) {
    var_0 = level._id_3B9E;
  }
  level._id_3BCA = var_0;
  return var_0;
}

_id_3BCB(var_0, var_1, var_2, var_3) {
  var_4 = newhudelem();
  var_4.archived = 1;
  var_4.x = self.origin[0] + var_1[0];
  var_4.y = self.origin[1] + var_1[1];
  var_4.z = self.origin[2] + var_1[2];
  var_4.alpha = 0.85;
  var_4 setshader(var_0, var_2, var_3);
  var_4 setwaypoint(1, 1, 0);
  var_4 thread keeppositioned(self, var_1);
  self._id_3BCC = var_4;
  thread destroyiconsondeath();
}

_id_3BCD() {
  while(isDefined(self)) {
    self waittill("trigger", var_0);

    if(isDefined(self.owner) && var_0 != self.owner) {
      continue;
    }
    if(!_id_3BCF(var_0, 500)) {
      continue;
    }
    self notify("captured", var_0);
    level notify("crate_captured");
  }
}

_id_3BCE() {
  while(isDefined(self)) {
    self waittill("trigger", var_0);

    if(isDefined(self.owner) && var_0 == self.owner) {
      continue;
    }
    if(!_id_3BCF(var_0)) {
      continue;
    }
    self notify("captured", var_0);
    level notify("crate_captured");
  }
}

_id_3BCF(var_0, var_1) {
  var_0 freezecontrols(1);
  var_0 common_scripts\utility::_disableweapon();
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;

  if(isDefined(level._id_3BD0)) {
    self.usetime = level._id_3BD0;
  } else if(isDefined(var_1)) {
    self.usetime = var_1;
  } else {
    self.usetime = 3000;
  }
  if(self.usetime > 0) {
    var_0 thread _id_3BD2(self);
    var_2 = _id_3BD1(var_0);
  } else {
    var_2 = 1;
  }
  if(isalive(var_0)) {
    var_0 common_scripts\utility::_enableweapon();
    var_0 freezecontrols(0);
  }

  if(!isDefined(self)) {
    return 0;
  }
  self.inuse = 0;
  self.curprogress = 0;
  return var_2;
}

_id_3BD1(var_0) {
  while(isDefined(self) && isalive(var_0) && var_0 useButtonPressed() && self.curprogress < self.usetime) {
    self.curprogress = self.curprogress + 50 * self.userate;

    if(isDefined(self.objectivescaler)) {
      self.userate = 1 * self.objectivescaler;
    } else {
      self.userate = 1;
    }
    if(self.curprogress >= self.usetime) {
      return isalive(var_0);
    }
    wait 0.05;
  }

  return 0;
}

_id_3BD2(var_0) {
  self endon("disconnect");
  var_1 = createprimaryprogressbar(-25);
  var_2 = createprimaryprogressbartext(-25);
  var_2 settext(&"SP_KILLSTREAKS_CAPTURING_CRATE");
  var_3 = -1;

  while(isalive(self) && isDefined(var_0) && var_0.inuse) {
    if(var_3 != var_0.userate) {
      if(var_0.curprogress > var_0.usetime) {
        var_0.curprogress = var_0.usetime;
      }
      var_1 updatebar(var_0.curprogress / var_0.usetime, 1000 / var_0.usetime * var_0.userate);

      if(!var_0.userate) {
        var_1 hideelem();
        var_2 hideelem();
      } else {
        var_1 showelem();
        var_2 showelem();
      }
    }

    var_3 = var_0.userate;
    wait 0.05;
  }

  var_1 destroyelem();
  var_2 destroyelem();
}

getflyheightoffset(var_0) {
  var_1 = 850;
  var_2 = getent("airstrikeheight", "targetname");

  if(!isDefined(var_2)) {
    if(isDefined(level.airstrikeheightscale)) {
      if(level.airstrikeheightscale > 2) {
        var_1 = 1500;
        return var_1 * level.airstrikeheightscale;
      }

      return var_1 * level.airstrikeheightscale + 256 + var_0[2];
    } else {
      return var_1 + var_0[2];
    }
  } else {
    return var_2.origin[2];
  }
}

getpathstart(var_0, var_1) {
  var_2 = 100;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4) * (-1 * var_3);
  var_5 = var_5 + ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

getpathend(var_0, var_1) {
  var_2 = 150;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4 + (0, 90, 0)) * var_3;
  var_5 = var_5 + ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

isairdropmarker(var_0) {
  switch (var_0) {
    case "airdrop_sentry_marker_mp":
    case "airdrop_mega_marker_mp":
    case "airdrop_marker_mp":
      return 1;
    default:
      return 0;
  }
}

beginairdropmarkertracking() {
  self notify("beginAirDropMarkerTracking");
  self endon("beginAirDropMarkerTracking");
  self endon("death");
  self endon("disconnect");
  common_scripts\utility::waittill_any("grenade_fire", "weapon_change");
  common_scripts\utility::_enableusability();
}

airdropdetonateonstuck() {
  self endon("death");
  self waittill("missile_stuck");
  self detonate();
}

destroyiconsondeath() {
  self notify("destroyIconsOnDeath");
  self endon("destroyIconsOnDeath");
  self waittill("death");
  self._id_3BCC destroy();
}

keeppositioned(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  var_2 = var_0.origin;

  for(;;) {
    if(var_2 != var_0.origin) {
      var_2 = var_0.origin;
      self.x = var_2[0] + var_1[0];
      self.y = var_2[0] + var_1[0];
      self.z = var_2[0] + var_1[0];
    }

    wait 0.05;
  }
}

keepiconpositioned() {
  self endon("kill_entity_headicon_thread");
  self endon("death");
  var_0 = self.origin;

  for(;;) {
    if(var_0 != self.origin) {
      updateheadiconorigin();
      var_0 = self.origin;
    }

    wait 0.05;
  }
}

destroyheadiconsondeath() {
  self endon("kill_entity_headicon_thread");
  self waittill("death");

  if(!isDefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}

updateheadiconorigin() {
  self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
  self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
  self.entityheadicon.z = self.origin[2] + self.entityheadiconoffset[2];
}

createprimaryprogressbartext(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  var_1 = maps\_hud_util::createserverclientfontstring("hudbig", level.primaryprogressbarfontsize);
  var_1.hidden = 0;
  var_1 setpoint("CENTER", undefined, level.primaryprogressbartextx, level.primaryprogressbartexty - var_0);
  var_1.sort = -1;
  return var_1;
}

createprimaryprogressbar(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  var_1 = createbar((1, 1, 1), level.primaryprogressbarwidth, level.primaryprogressbarheight);
  var_1 setpoint("CENTER", undefined, level.primaryprogressbarx, level.primaryprogressbary - var_0);
  return var_1;
}

createbar(var_0, var_1, var_2, var_3) {
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4.frac = 0;
  var_4.color = var_0;
  var_4.sort = -2;
  var_4.shader = "progress_bar_fill";
  var_4 setshader("progress_bar_fill", var_1, var_2);
  var_4.hidden = 0;

  if(isDefined(var_3)) {
    var_4.flashfrac = var_3;
  }
  var_5 = newclienthudelem(self);
  var_5.elemtype = "bar";
  var_5.width = var_1;
  var_5.height = var_2;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5.bar = var_4;
  var_5.children = [];
  var_5.sort = -3;
  var_5.color = (0, 0, 0);
  var_5.alpha = 0.5;
  var_5.padding = 0;
  var_5 maps\_hud_util::setparent(level.uiparent);
  var_5 setshader("progress_bar_bg", var_1 + 4, var_2 + 4);
  var_5.hidden = 0;
  return var_5;
}

setpoint(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }
  var_5 = maps\_hud_util::getparent();

  if(var_4) {
    self moveovertime(var_4);
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  self.xoffset = var_2;

  if(!isDefined(var_3)) {
    var_3 = 0;
  }
  self.yoffset = var_3;
  self.point = var_0;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(var_0, "TOP")) {
    self.aligny = "top";
  }
  if(issubstr(var_0, "BOTTOM")) {
    self.aligny = "bottom";
  }
  if(issubstr(var_0, "LEFT")) {
    self.alignx = "left";
  }
  if(issubstr(var_0, "RIGHT")) {
    self.alignx = "right";
  }
  if(!isDefined(var_1)) {
    var_1 = var_0;
  }
  self.relativepoint = var_1;
  var_6 = "center_adjustable";
  var_7 = "middle";

  if(issubstr(var_1, "TOP")) {
    var_7 = "top_adjustable";
  }
  if(issubstr(var_1, "BOTTOM")) {
    var_7 = "bottom_adjustable";
  }
  if(issubstr(var_1, "LEFT")) {
    var_6 = "left_adjustable";
  }
  if(issubstr(var_1, "RIGHT")) {
    var_6 = "right_adjustable";
  }
  if(var_5 == level.uiparent) {
    self.horzalign = var_6;
    self.vertalign = var_7;
  } else {
    self.horzalign = var_5.horzalign;
    self.vertalign = var_5.vertalign;
  }

  if(strip_suffix(var_6, "_adjustable") == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_6 == "center" || var_5.alignx == "center") {
    var_8 = int(var_5.width / 2);

    if(var_6 == "left_adjustable" || var_5.alignx == "right") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  } else {
    var_8 = var_5.width;

    if(var_6 == "left_adjustable") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  }

  self.x = var_5.x + var_8 * var_9;

  if(strip_suffix(var_7, "_adjustable") == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_7 == "middle" || var_5.aligny == "middle") {
    var_10 = int(var_5.height / 2);

    if(var_7 == "top_adjustable" || var_5.aligny == "bottom") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  } else {
    var_10 = var_5.height;

    if(var_7 == "top_adjustable") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  }

  self.y = var_5.y + var_10 * var_11;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;

  switch (self.elemtype) {
    case "bar":
      setpointbar(var_0, var_1, var_2, var_3);
      break;
  }

  maps\_hud_util::updatechildren();
}

setpointbar(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "left") {
    self.bar.x = self.x;
  } else if(self.alignx == "right") {
    self.bar.x = self.x - self.width;
  } else {
    self.bar.x = self.x - int(self.width / 2);
  }
  if(self.aligny == "top") {
    self.bar.y = self.y;
  } else if(self.aligny == "bottom") {
    self.bar.y = self.y;
  }
  updatebar(self.bar.frac);
}

updatebar(var_0, var_1) {
  if(self.elemtype == "bar") {
    updatebarscale(var_0, var_1);
  }
}

updatebarscale(var_0, var_1) {
  var_2 = int(self.width * var_0 + 0.5);

  if(!var_2) {
    var_2 = 1;
  }
  self.bar.frac = var_0;
  self.bar setshader(self.bar.shader, var_2, self.height);

  if(isDefined(var_1) && var_2 < self.width) {
    if(var_1 > 0) {
      self.bar scaleovertime((1 - var_0) / var_1, self.width, self.height);
    } else if(var_1 < 0) {
      self.bar scaleovertime(var_0 / (-1 * var_1), 1, self.height);
    }
  }

  self.bar.rateofchange = var_1;
  self.bar.lastupdatetime = gettime();
}

hideelem() {
  if(self.hidden) {
    return;
  }
  self.hidden = 1;

  if(self.alpha != 0) {
    self.alpha = 0;
  }
  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar.hidden = 1;

    if(self.bar.alpha != 0) {
      self.bar.alpha = 0;
    }
  }
}

showelem() {
  if(!self.hidden) {
    return;
  }
  self.hidden = 0;

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    if(self.alpha != 0.5) {
      self.alpha = 0.5;
    }
    self.bar.hidden = 0;

    if(self.bar.alpha != 1) {
      self.bar.alpha = 1;
    }
  } else if(self.alpha != 1) {
    self.alpha = 1;
  }
}

strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size) {
    return var_0;
  }
  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
    return getsubstr(var_0, 0, var_0.size - var_1.size);
  }
  return var_0;
}

destroyelem() {
  var_0 = [];

  for(var_1 = 0; var_1 < self.children.size; var_1++) {
    if(isDefined(self.children[var_1])) {
      var_0[var_0.size] = self.children[var_1];
    }
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] maps\_hud_util::setparent(maps\_hud_util::getparent());
  }
  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar destroy();
  }
  self destroy();
}