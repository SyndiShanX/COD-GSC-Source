/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1478.gsc
**************************************/

main() {
  if(isDefined(level._id_3AAC)) {
    return;
  }
  level._id_3AAC = 1;

  if(!isDefined(level._id_2106)) {
    level._id_2106 = [];
  }
  level._id_2106["juggernaut"] = ::_id_3AAE;
  level._id_3AAD = 0;
}

_id_3AAE() {
  self._id_0A37 = 1;
  self.minpaindamage = 200;
  self.grenadeammo = 0;
  self._id_10A3 = 0.05;
  self._id_0F3C = 1;
  self.ignoresuppression = 1;
  self._id_1151 = 1;
  self._id_0FDF = 1;
  self._id_100A = 1;
  self._id_1199 = 1;
  self._id_117F = 1;
  self._id_0EEE = 1;
  self.combatmode = "no_cover";
  self._id_0FD9 = 1;
  self.a._id_0D31 = 1;
  maps\_utility::_id_2721();
  maps\_utility::_id_0EEC();
  _id_3AB3();
  maps\_utility::_id_12E2(animscripts\pain::_id_0D82);
  maps\_utility::_id_12E2(maps\_spawner::_id_216B);

  if(!self isbadguy()) {
    return;
  }
  self._id_1A2D = 40;
  maps\_utility::_id_12E2(maps\_spawner::_id_1A2D);
  thread _id_3AAF();
  thread _id_3AB0();
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  level notify("juggernaut_spawned");
  self waittill("death", var_0, var_1, var_2);

  if(isDefined(self) && isDefined(self._id_2145)) {
    var_3 = [];
    var_3[var_3.size] = "left";
    var_3[var_3.size] = "right";
    var_3[var_3.size] = "chest";
    var_3[var_3.size] = "back";
    animscripts\shared::_id_23C1();

    foreach(var_5 in var_3) {
      var_2 = self.a._id_0EE4[var_5];

      if(var_2 == "none") {
        continue;
      }
      self.weaponinfo[var_2]._id_2099 = "none";
      self.a._id_0EE4[var_5] = "none";
    }

    self.weapon = "none";
    animscripts\shared::_id_23C4();
  }

  level notify("juggernaut_died");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
}

_id_3AAF() {
  self endon("death");
  self endon("stop_hunting");
  self.usechokepoints = 0;

  for(;;) {
    wait 0.5;

    if(isDefined(self.enemy)) {
      self setgoalpos(self.enemy.origin);
      self.goalradius = 128;
      self.goalheight = 81;
    }
  }
}

_id_3AB0() {
  self endon("death");
  level endon("special_op_terminated");

  if(isDefined(level._id_3AB1) && level._id_3AB1) {
    return;
  }
  var_0 = 2500;

  if(level.script == "ending") {
    common_scripts\utility::flag_wait("panic_button");
    var_0 = 750;
  }

  for(;;) {
    wait 0.05;

    if(gettime() < level._id_3AAD) {
      continue;
    }
    var_1 = maps\_utility::_id_2608(self.origin);

    if(!isalive(var_1)) {
      continue;
    }
    if(distance(var_1.origin, self.origin) > var_0) {
      continue;
    }
    if(level._id_3AB2) {
      var_2 = self gettagorigin("tag_flash");

      if(!bullettracepassed(self getEye(), var_1 getEye(), 0, undefined)) {
        wait 0.25;
        continue;
      }
    }

    break;
  }

  level._id_3AAD = gettime() + 15000;
  level notify("juggernaut_attacking");
  common_scripts\utility::array_thread(level.players, maps\_utility::_id_2782, "_juggernaut_attack");
}

#using_animtree("generic_human");

_id_3AB3() {
  self.walkdist = 500;
  self.walkdistfacingmotion = 500;
  maps\_utility::_id_26F9("run", %juggernaut_runf, %juggernaut_sprint);
  maps\_utility::_id_26F9("walk", %juggernaut_walkf);
  maps\_utility::_id_26F9("cqb", %juggernaut_walkf);
  maps\_utility::_id_26F8(%juggernaut_stand_fire_burst, %juggernaut_aim5, %juggernaut_stand_idle, %juggernaut_stand_reload);
}