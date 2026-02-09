/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\326.gsc
**************************************/

_id_1285() {
  var_0 = getEntArray("hiding_door_guy_org", "targetname");
  var_1 = maps\_utility::_id_0AE9(self.origin, var_0);
  var_1.targetname = undefined;
  var_2 = getEntArray(var_1.target, "targetname");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_1.script_linkto)) {
    var_5 = var_1 common_scripts\utility::get_linked_ent();
  }
  if(var_2.size == 1) {
    var_3 = var_2[0];
  } else {
    foreach(var_7 in var_2) {
      if(var_7.code_classname == "script_brushmodel") {
        var_4 = var_7;
        continue;
      }

      if(var_7.code_classname == "script_model") {
        var_3 = var_7;
      }
    }
  }

  var_9 = getent(var_3.target, "targetname");
  var_10 = undefined;

  if(isDefined(var_9.target)) {
    var_10 = getent(var_9.target, "targetname");
  }
  if(isDefined(var_10)) {
    var_1 thread _id_1294(var_10);

    if(!isDefined(level._id_1286)) {
      level._id_1286 = [];
    }
    level._id_1286[level._id_1286.size] = var_10;
  }

  var_3 delete();
  var_11 = maps\_utility::_id_1287("hiding_door");
  var_1 thread maps\_anim::_id_11CF(var_11, "fire_3");

  if(isDefined(var_4)) {
    var_4 linkto(var_11, "door_hinge_jnt");
    var_11 hide();
  }

  if(isDefined(var_9)) {
    var_9 linkto(var_11, "door_hinge_jnt");
    var_9 disconnectpaths();
  }

  var_12 = undefined;

  if(isDefined(self.target)) {
    var_12 = getent(self.target, "targetname");

    if(!issubstr(var_12.classname, "trigger")) {
      var_12 = undefined;
    }
  }

  if(!isDefined(self._id_1288) && !isDefined(var_12)) {
    var_13 = 200;

    if(isDefined(self.radius)) {
      var_13 = self.radius;
    }
    var_12 = spawn("trigger_radius", var_1.origin, 0, var_13, 48);
  }

  if(isDefined(var_5)) {
    badplace_brush(var_5 getentitynumber(), 0, var_5, "allies");
  }
  maps\_utility::add_spawn_function(::_id_128A, var_1, var_12, var_11, var_9, var_5);
}

_id_128A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_1298(var_0);
  self._id_1032 = "hiding_door_guy";
  self endon("death");
  self endon("damage");
  self.grenadeammo = 2;
  maps\_utility::_id_128B("death_2");
  self.allowdeath = 1;
  self.health = 50000;
  var_6 = [];
  var_6[var_6.size] = var_2;
  var_6[var_6.size] = self;
  thread _id_1292(var_0, self, var_2, var_3, var_4);
  thread _id_1296(var_2, var_0, self, var_3, var_4);

  if(var_5) {
    var_0 thread maps\_anim::_id_11D6(var_6, "idle");
  } else {
    var_0 thread maps\_anim::_id_11BF(var_6, "fire_3");
  }
  if(isDefined(var_1)) {
    wait 0.05;
    var_1 waittill("trigger");
  } else {
    common_scripts\utility::flag_wait(self._id_1288);
  }
  if(var_5) {
    var_0 notify("stop_loop");
    var_0 maps\_anim::_id_11DD(var_6, "close");
  }

  var_7 = 0;
  var_8 = 0;

  for(;;) {
    var_9 = level.player;

    if(isDefined(self.enemy)) {
      var_9 = self.enemy;
    }
    var_10 = _id_1291(var_2.angles, self.origin, var_9.origin);

    if(_id_128E(var_10)) {
      if(_id_128D()) {
        return;
      }
    }

    if(var_7 >= 2) {
      if(_id_128D(1)) {
        return;
      }
    }

    var_11 = undefined;

    if(var_10 == "left" || var_10 == "front") {
      var_11 = "fire_3";
    } else if(var_10 == "right") {
      var_11 = "fire_1";

      if(common_scripts\utility::cointoss()) {
        var_11 = "fire_2";
      }
    } else {
      var_0 maps\_anim::_id_11DD(var_6, "open");
      var_0 maps\_anim::_id_11DD(var_6, "close");
      var_7++;
      continue;
    }

    if(_id_128F(var_10, var_9, var_8)) {
      var_11 = "jump";

      if(common_scripts\utility::cointoss()) {
        if(self maymovetopoint(animscripts\utility::_id_0F99(level._id_0C59[self._id_1032]["kick"]))) {
          var_11 = "kick";
        }
      }

      thread _id_1297(var_3, var_4);
      var_0 notify("push_player");
      self notify("charge");
      self.allowdeath = 1;
      self.health = 100;
      maps\_utility::_id_128C();
      var_0 maps\_anim::_id_11DD(var_6, var_11);
      _id_128D();
      return;
    }

    if(_id_1290(var_10, var_8)) {
      self.grenadeammo--;
      var_11 = "grenade";
    }

    var_7 = 0;
    var_8++;
    var_0 thread maps\_anim::_id_11DD(var_6, var_11);
    maps\_utility::delaythread(0.05, maps\_anim::_id_127F, var_6, var_11, 0.3);
    var_0 waittill(var_11);
    var_0 thread maps\_anim::_id_11BF(var_6, "open");
    wait(randomfloatrange(0.2, 1.0));
    var_0 notify("stop_loop");
  }
}

_id_128D(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  if(var_0) {
    if(!sighttracepassed(level.player getEye(), self getEye(), 0, self)) {
      return 0;
    }
  }

  self.health = 100;
  maps\_utility::_id_128C();
  self.goalradius = 512;
  self setgoalpos(self.origin);
  self notify("quit_door_behavior");
  self stopanimscripted();
  self notify("killanimscript");
  return 1;
}

_id_128E(var_0) {
  if(var_0 != "behind") {
    return 0;
  }
  var_1 = distance(self.origin, level.player.origin);

  if(var_1 > 250) {
    return 0;
  }
  if(!sighttracepassed(level.player getEye(), self getEye(), 0, self)) {
    return 0;
  }
  return 1;
}

_id_128F(var_0, var_1, var_2) {
  var_3 = 3;
  var_4 = 100;
  var_5 = 600;

  if(var_2 < var_3) {
    return 0;
  }
  if(var_1 != level.player) {
    return 0;
  }
  if(var_0 != "front") {
    return 0;
  }
  var_6 = distance(self.origin, level.player.origin);

  if(var_6 < var_4) {
    return 0;
  }
  if(var_6 > var_5) {
    return 0;
  }
  return common_scripts\utility::cointoss();
}

_id_1290(var_0, var_1) {
  if(var_1 < 1) {
    return 0;
  }
  if(var_0 == "behind") {
    return 0;
  }
  if(randomint(100) < 25 * self.grenadeammo) {
    return 1;
  }
  return 0;
}

_id_1291(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0);
  var_4 = vectornormalize(var_3);
  var_5 = vectortoangles(var_4);
  var_6 = vectortoangles(var_2 - var_1);
  var_7 = var_5[1] - var_6[1];
  var_7 = var_7 + 360;
  var_7 = int(var_7) % 360;
  var_8 = undefined;

  if(var_7 >= 90 && var_7 <= 270) {
    var_8 = "behind";
  } else if(var_7 >= 300 || var_7 <= 45) {
    var_8 = "front";
  } else if(var_7 < 90) {
    var_8 = "right";
  } else if(var_7 > 270) {
    var_8 = "left";
  }
  return var_8;
}

_id_1292(var_0, var_1, var_2, var_3, var_4) {
  var_1 endon("charge");
  var_1 common_scripts\utility::waittill_either("death", "quit_door_behavior");
  var_0 notify("stop_loop");
  thread _id_1297(var_3, var_4);
  var_0 notify("push_player");

  if(!isDefined(var_2._id_1293)) {
    var_2._id_1293 = 1;
    var_0 thread maps\_anim::_id_1246(var_2, "death_2");
  }
}

_id_1294(var_0) {
  self waittill("push_player");
  var_0 moveto(self.origin, 1.5);
  wait 1.5;
  var_0 delete();
}

_id_1295(var_0) {
  var_1 = var_0 gettagorigin("J_Wrist_RI");
  var_2 = distance(level.player.origin, var_0.origin) * 2.0;

  if(var_2 < 300) {
    var_2 = 300;
  }
  if(var_2 > 1000) {
    var_2 = 1000;
  }
  var_3 = vectornormalize(level.player.origin - var_0.origin);
  var_4 = var_3 * var_2;
  var_0 magicgrenademanual(var_1, var_4, randomfloatrange(3.0, 5.0));
}

_id_1296(var_0, var_1, var_2, var_3, var_4) {
  var_2 endon("charge");
  var_2 endon("quit_door_behavior");
  var_2 waittill("damage", var_5, var_6);

  if(!isalive(var_2)) {
    return;
  }
  thread _id_1297(var_3, var_4);
  var_1 notify("push_player");
  var_1 thread maps\_anim::_id_1246(var_2, "death_2");

  if(!isDefined(var_0._id_1293)) {
    var_0._id_1293 = 1;
    var_1 thread maps\_anim::_id_1246(var_0, "death_2");
  }

  wait 0.5;

  if(isalive(var_2)) {
    if(isDefined(var_6)) {
      var_2 kill((0, 0, 0), var_6);
    } else {
      var_2 kill((0, 0, 0));
    }
  }
}

_id_1297(var_0, var_1) {
  wait 2;

  if(isDefined(var_0)) {
    var_0 disconnectpaths();
  }
  if(isDefined(var_1)) {
    badplace_delete(var_1 getentitynumber());
  }
}

_id_1298(var_0) {
  return isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "starts_open";
}