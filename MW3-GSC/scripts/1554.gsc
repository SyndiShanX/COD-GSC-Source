/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1554.gsc
**************************************/

_id_3C49() {
  if(!isDefined(level._id_3BD4)) {
    level._id_3BD4 = [];
  }
  level._id_3BD4[self.unique_id] = self;

  if(isDefined(level._id_3BD8._id_3C3B) && !isDefined(level._id_3BDD)) {
    level endon("draw_target_end");

    while(isDefined(level._id_3C4A) && level._id_3C4A == gettime()) {
      wait 0.05;
    }
    level._id_3C4A = gettime();

    if(isalive(self)) {
      maps\_remotemissile::_id_3C3C();
    }
  }

  self waittill("death");
  level._id_3BD4[self.unique_id] = undefined;

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_3C3D)) {
    self._id_3C3D = undefined;
    target_remove(self);
  }
}

_id_3C19() {
  if(isDefined(level.uavrig)) {
    return level.uavrig;
  }
  var_0 = maps\_remotemissile::_id_3C29();
  return var_0;
}

_id_3C4B(var_0) {
  foreach(var_2 in level.players) {
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = self.origin;
    var_3._id_3C2C = self;
    var_3 thread maps\_remotemissile::_id_3C47(var_0, var_2);
    var_2 _id_3C4C(var_3);
    var_2 thread maps\_remotemissile::_id_3C45();
  }
}

_id_3C4C(var_0) {
  if(!isDefined(self._id_3BF0)) {
    self._id_3BF0 = [];
  }
  self._id_3BF0[self._id_3BF0.size] = var_0;
}

_id_3C4D() {
  self giveweapon("remote_missile_detonator");
  self._id_1FB6 = 4;
  thread _id_3BEC();
  common_scripts\utility::flag_clear("predator_missile_launch_allowed");
  self setactionslot(self._id_1FB6, "weapon", "remote_missile_detonator");
}

_id_3C4E() {
  level endon("stop_uav_reload");
  level endon("special_op_terminated");

  if(common_scripts\utility::flag("uav_reloading")) {
    if(isDefined(level._id_3BDD)) {
      return;
    }
    maps\_remotemissile::_id_3BE9();

    if(common_scripts\utility::flag("uav_collecting_stats")) {
      level waittill("uav_collecting_stats");
      maps\_remotemissile::_id_3BFC();
    }

    if(isDefined(level._id_3BDD)) {
      return;
    }
    level._id_3BF3 = undefined;

    if(common_scripts\utility::flag("uav_reloading")) {
      level waittill("uav_reloading");
    }
    if(isDefined(level._id_3BDD)) {
      return;
    }
    if(!common_scripts\utility::flag("uav_enabled")) {
      return;
    }
    if(self getweaponammoclip(self._id_3BE8) < 1) {
      maps\_remotemissile::_id_3BE6();
      return;
    }

    maps\_remotemissile::_id_3BE7();
    thread maps\_remotemissile::_id_3BFF("uav_online");
    thread maps\_remotemissile::_id_3BFA();
  }
}

_id_3BEC() {
  maps\_remotemissile::_id_3BF8(::_id_3C4E);
}

_id_3C4F() {
  maps\_remotemissile::_id_3BF8();
}

_id_3C1A() {
  return isDefined(level._id_3C50);
}