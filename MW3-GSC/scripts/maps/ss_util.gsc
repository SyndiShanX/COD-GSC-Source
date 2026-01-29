/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\ss_util.gsc
**************************************/

_id_441C(var_0, var_1, var_2) {
  self endon("death");
  wait(randomintrange(var_1, var_2));

  if(isDefined(self) && isai(self) && isalive(self)) {
    if(var_0 == "bullet") {
      _id_441D();
    } else {
      _id_441D();
    }
  }
}

_id_441D(var_0) {
  self endon("death");

  if(!issentient(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self._id_441E) && self._id_441E) {
    return;
  }
  self._id_441E = 1;

  if(isDefined(var_0)) {
    wait(randomfloat(var_0));

  }
  var_1 = [];
  var_1[0] = "j_hip_le";
  var_1[1] = "j_hip_ri";
  var_1[2] = "j_head";
  var_1[3] = "j_spine4";
  var_1[4] = "j_elbow_le";
  var_1[5] = "j_elbow_ri";
  var_1[6] = "j_clavicle_le";
  var_1[7] = "j_clavicle_ri";

  for(var_2 = 0; var_2 < 3 + randomint(5); var_2++) {
    var_3 = randomintrange(0, var_1.size);
    thread _id_441F(var_1[var_3], undefined);
    wait(randomfloat(0.1));
  }

  self dodamage(self.health + 50, self.origin);
}

_id_441F(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level._effect["flesh_hit"];

  }
  playFXOnTag(var_1, self, var_0);
}

_id_4420(var_0, var_1) {
  var_2 = getent(var_1, "targetname");
  wait 0.05;

  foreach(var_4 in var_0) {
    if(isDefined(var_4) && isai(var_4)) {
      var_4 cleargoalvolume();
      var_4 setgoalvolumeauto(var_2);
    }
  }
}

_id_4421(var_0) {
  maps\_shg_common::_id_168D();
  maps\_utility::_id_11F4(var_0);
  maps\_shg_common::_id_168E();
}

_id_4422(var_0) {
  maps\_shg_common::_id_168D();
  maps\_utility::_id_168C(var_0);
  maps\_shg_common::_id_168E();
}

_id_4423(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = [];

  if(isDefined(var_0)) {
    var_8[var_8.size] = var_0;

  }
  if(isDefined(var_1)) {
    var_8[var_8.size] = var_1;

  }
  if(isDefined(var_2)) {
    var_8[var_8.size] = var_2;

  }
  if(isDefined(var_3)) {
    var_8[var_8.size] = var_3;

  }
  if(isDefined(var_4)) {
    var_8[var_8.size] = var_4;

  }
  if(isDefined(var_5)) {
    var_8[var_8.size] = var_5;

  }
  if(isDefined(var_6)) {
    var_8[var_8.size] = var_6;

  }
  if(isDefined(var_7)) {
    var_8[var_8.size] = var_7;

  }
  if(!isDefined(level._id_4424)) {
    level._id_4424 = undefined;

  }
  var_9 = 0;

  while(!var_9) {
    var_10 = common_scripts\utility::random(var_8);

    if(isDefined(level._id_4424) && level._id_4424 == var_10) {
      continue;
    } else {
      if(isDefined(self) && isai(self)) {
        _id_4422(var_10);
      } else {
        _id_4421(var_10);

      }
      level._id_4424 = var_10;
      var_9 = 1;
    }

    wait 0.05;
  }

  var_9 = 0;
}

_id_4425() {
  return 0;
}

_id_4426() {
  var_0 = getEntArray("trigger_ignore_suppression", "targetname");

  foreach(var_2 in var_0) {}
  level thread _id_4427(var_2);
}

_id_4427(var_0) {
  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1) && isai(var_1) && !var_1 isbadguy()) {
      var_1 thread _id_4428(var_0);
    }
  }
}

_id_4428(var_0) {
  self notify("ignore_suppression_trigger_ai_think_stop");
  self endon("ignore_suppression_trigger_ai_think_stop");
  self endon("death");
  maps\_utility::_id_26F3(1);

  while(self istouching(var_0)) {
    wait 0.5;

  }
  maps\_utility::_id_26F3(0);
}

_id_4429(var_0) {
  if(isDefined(var_0)) {
    level._id_442A = maps\_hud_util::createicon("popmenu_bg", 650, 50);
  } else {
    level._id_442A = maps\_hud_util::createicon("popmenu_bg", 650, 30);

  }
  level._id_442A.hidewheninmenu = 1;
  level._id_442A maps\_hud_util::setpoint("TOP", undefined, 0, 110);
  level._id_442A.alpha = 0.5;
  level._id_442A.sort = 0;
}

_id_442B() {
  if(isDefined(level._id_442C)) {
    level._id_442C maps\_hud_util::destroyelem();

  }
  if(isDefined(level._id_442D)) {
    level._id_442D maps\_hud_util::destroyelem();

  }
  if(isDefined(level._id_442E)) {
    level._id_442E maps\_hud_util::destroyelem();

  }
  if(isDefined(level._id_442F)) {
    level._id_442F maps\_hud_util::destroyelem();

  }
  if(isDefined(level._id_442A)) {
    level._id_442A maps\_hud_util::destroyelem();

  }
  level notify("clearing_hints");
}

_id_4430(var_0, var_1, var_2) {
  _id_442B();
  level endon("clearing_hints");
  _id_4429(var_2);
  level._id_442C = maps\_hud_util::createfontstring("default", 2);
  level._id_442C.hidewheninmenu = 1;
  level._id_442C maps\_hud_util::setpoint("TOP", undefined, 0, 110);
  level._id_442C.sort = 0.5;
  level._id_4431 = 1;
  level._id_442C settext(var_0);

  if(isDefined(var_1)) {
    wait(var_1);
  } else {
    return;

  }
  level._id_4431 = undefined;
  level._id_442C fadeovertime(0.5);
  level._id_442C.alpha = 0;
  wait 0.5;
  _id_442B();
}

_id_4432(var_0, var_1) {
  level endon("special_op_terminated");
  self endon("death");
  var_2 = 30;
  var_3 = self.meleeattackdist + var_2;

  for(;;) {
    wait 0.05;

    if(_id_4434()) {
      continue;
    }
    if(isDefined(self.enemy) && self.movemode == "stop") {
      if(_id_4433(self) > gettime()) {
        continue;
      }
      self setgoalentity(var_1);
      maps\_utility::_id_2612(1);
      continue;
    }

    if(isDefined(self.ignoreall) && self.ignoreall) {
      var_4 = getnodesinradiussorted(self.favoriteenemy.origin, 16, 0, 64, "Path");

      if(isDefined(var_4) && var_4.size > 0) {
        self setgoalentity(self.favoriteenemy);
        maps\_utility::_id_2612(0);
        continue;
      }

      if(maps\_utility::_id_12C1() && distance2d(self.origin, var_1.origin) < 125) {
        var_5 = _id_03BD();

        if(var_5 _id_03BC(self)) {
          _id_4435();
          maps\_utility::_id_2612(0);
        }
      }
    }
  }
}

_id_03BC(var_0) {
  var_1 = self getEye();
  var_2 = var_0 getEye();

  if(sighttracepassed(var_1, var_2, 1, self, var_0)) {
    return 1;

  }
  return 0;
}

_id_4433(var_0) {
  var_1 = 0;

  if(isDefined(self.enemy._id_3B23)) {
    var_1 = self.enemy._id_3B23 + 2500;

  }
  return var_1;
}

_id_4434() {
  if(!maps\_utility::_id_12C1()) {
    return 0;

  }
  if(isDefined(self.favoriteenemy.laststand) && self.favoriteenemy.laststand) {
    _id_4435();
    return 1;
  }

  return 0;
}

_id_4435() {
  if(!maps\_utility::_id_12C1()) {
    return;
  }
  var_0 = _id_03BD();
  self setgoalentity(var_0);
  maps\_utility::_id_2613(var_0);
}

_id_03BD() {
  var_0 = self.favoriteenemy != level._id_1337;
  return level.players[var_0];
}