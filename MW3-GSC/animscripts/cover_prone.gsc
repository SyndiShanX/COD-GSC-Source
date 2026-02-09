/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_prone.gsc
***************************************/

#using_animtree("generic_human");

main() {
  self endon("killanimscript");
  animscripts\utility::_id_0D15("cover_prone");

  if(weaponclass(self.weapon) == "rocketlauncher") {
    animscripts\combat::main();
    return;
  }

  if(isDefined(self.a._id_10DF) && self.a._id_10DF == "prone_saw") {
    animscripts\cover_wall::_id_0FA5("saw_bipod_prone", "weapon_saw_MG_Setup");
  } else if(isDefined(self.node._id_0A50)) {
    animscripts\cover_wall::_id_0FA7();
  }
  if(isDefined(self.enemy) && lengthsquared(self.origin - self.enemy.origin) < squared(512)) {
    thread animscripts\combat::main();
    return;
  }

  _id_10E6();
  self._id_0CAF = self.node;
  self orientmode("face angle", self._id_0CAF.angles[1]);
  self.a._id_10E0 = 1;
  self setproneanimnodes(-45, 45, %prone_legs_down, %exposed_modern, %prone_legs_up);

  if(self.a._id_0D26 != "prone") {
    _id_10EA("prone");
  } else {
    animscripts\utility::_id_10E1(0);
  }
  thread animscripts\combat_utility::_id_0F78();
  _id_10EC(0.2);
  self setanim(%prone_aim_5, 1, 0.1);
  self orientmode("face angle", self._id_0CAF.angles[1]);
  self animmode("zonly_physics");
  _id_10E3();
  self notify("stop_deciding_how_to_shoot");
}

end_script() {
  self.a._id_10E0 = undefined;
}

_id_0F5E() {
  self endon("killanimscript");
  self endon("kill_idle_thread");

  for(;;) {
    var_0 = animscripts\utility::_id_0CA8("prone_idle");
    self setflaggedanimlimited("idle", var_0);
    self waittillmatch("idle", "end");
    self clearanim(var_0, 0.2);
  }
}

_id_10E2(var_0) {
  self updateprone(%prone_aim_feet_45up, %prone_aim_feet_45down, 1, var_0, 1);
  self setanim(%exposed_aiming, 1, 0.2);
}

_id_10E3() {
  self endon("killanimscript");
  thread animscripts\track::_id_0CA9();
  thread animscripts\shoot_behavior::_id_0CD7("normal");
  var_0 = gettime() > 2500;

  for(;;) {
    animscripts\utility::_id_0A69();
    _id_10E2(0.05);

    if(!var_0) {
      wait(0.05 + randomfloat(1.5));
      var_0 = 1;
      continue;
    }

    if(!isDefined(self._id_0CB1)) {
      if(_id_10E7()) {
        continue;
      }
      wait 0.05;
      continue;
    }

    var_1 = lengthsquared(self.origin - self._id_0CB1);

    if(self.a._id_0D26 != "crouch" && self isstanceallowed("crouch") && var_1 < squared(400)) {
      if(var_1 < squared(285)) {
        _id_10EA("crouch");
        thread animscripts\combat::main();
        return;
      }
    }

    if(_id_10E7()) {
      continue;
    }
    if(_id_10E5(0)) {
      continue;
    }
    if(animscripts\combat_utility::_id_10E4()) {
      animscripts\combat_utility::_id_0F06();
      self clearanim(%add_fire, 0.2);
      continue;
    }

    wait 0.05;
  }
}

_id_10E5(var_0) {
  return animscripts\combat_utility::_id_0F54(var_0, animscripts\utility::_id_0D4D("reload"));
}

_id_10E6() {
  self setdefaultaimlimits(self.node);
  var_0 = [];
  var_0["straight_level"] = % prone_aim_5;
  var_0["fire"] = % prone_fire_1;
  var_0["semi2"] = % prone_fire_burst;
  var_0["semi3"] = % prone_fire_burst;
  var_0["semi4"] = % prone_fire_burst;
  var_0["semi5"] = % prone_fire_burst;
  var_0["single"] = animscripts\utility::_id_0C6D(%prone_fire_1);
  var_0["burst2"] = % prone_fire_burst;
  var_0["burst3"] = % prone_fire_burst;
  var_0["burst4"] = % prone_fire_burst;
  var_0["burst5"] = % prone_fire_burst;
  var_0["burst6"] = % prone_fire_burst;
  var_0["reload"] = % prone_reload;
  var_0["look"] = animscripts\utility::_id_0C6D(%prone_twitch_look, %prone_twitch_lookfast, %prone_twitch_lookup);
  var_0["grenade_safe"] = animscripts\utility::_id_0C6D(%prone_grenade_a, %prone_grenade_a);
  var_0["grenade_exposed"] = animscripts\utility::_id_0C6D(%prone_grenade_a, %prone_grenade_a);
  var_0["exposed_idle"] = animscripts\utility::_id_0C6D(%prone_idle);
  var_0["hide_to_look"] = % coverstand_look_moveup;
  var_0["look_idle"] = % coverstand_look_idle;
  var_0["look_to_hide"] = % coverstand_look_movedown;
  var_0["look_to_hide_fast"] = % coverstand_look_movedown_fast;
  var_0["stand_2_prone"] = % stand_2_prone_nodelta;
  var_0["crouch_2_prone"] = % crouch_2_prone;
  var_0["prone_2_stand"] = % prone_2_stand_nodelta;
  var_0["prone_2_crouch"] = % prone_2_crouch;
  var_0["stand_2_prone_firing"] = % stand_2_prone_firing;
  var_0["crouch_2_prone_firing"] = % crouch_2_prone_firing;
  var_0["prone_2_stand_firing"] = % prone_2_stand_firing;
  var_0["prone_2_crouch_firing"] = % prone_2_crouch_firing;
  self.a._id_0C6D = var_0;
}

_id_0F61(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1) && var_1) {
    var_2 = animscripts\utility::_id_0CA8("grenade_safe");
  } else {
    var_2 = animscripts\utility::_id_0CA8("grenade_exposed");
  }
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  var_3 = (32, 20, 64);
  var_4 = animscripts\combat_utility::_id_0FA1(var_0, var_2);
  self.keepclaimednodeifvalid = 0;
  return var_4;
}

_id_10E7() {
  if(isDefined(anim._id_0F38) && isalive(level.player)) {
    if(_id_0F61(level.player, 200)) {
      return 1;
    }
  }

  if(isDefined(self.enemy)) {
    return _id_0F61(self.enemy, 850);
  }
  return 0;
}

_id_10E8() {
  if(!isDefined(self.weapon) || !weaponisauto(self.weapon)) {
    return 0;
  }
  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 256) {
    return 0;
  }
  if(isDefined(self.enemy) && self cansee(self.enemy) && !isDefined(self.grenade) && animscripts\shared::_id_10E9() < 20) {
    return animscripts\move::_id_0FDE();
  }
  return 0;
}

_id_10EA(var_0) {
  if(var_0 == self.a._id_0D26) {
    return;
  }
  self clearanim(%root, 0.3);
  animscripts\combat_utility::_id_0F85();

  if(_id_10E8()) {
    var_1 = animscripts\utility::_id_0D4D(self.a._id_0D26 + "_2_" + var_0 + "_firing");
  } else {
    var_1 = animscripts\utility::_id_0D4D(self.a._id_0D26 + "_2_" + var_0);
  }
  if(var_0 == "prone") {}

  self setflaggedanimknoballrestart("trans", var_1, %body, 1, 0.2, 1.0);
  animscripts\shared::_id_0C51("trans");
  self setanimknoballrestart(animscripts\utility::_id_0D4D("straight_level"), %body, 1, 0.25);
  _id_10EC(0.25);
}

_id_10EB(var_0) {
  self endon("killanimscript");
  animscripts\shared::_id_0C51(var_0);
}

_id_10EC(var_0) {
  self setanimknoball(%prone_aim_5, %body, 1, var_0);
  self setanimlimited(%prone_aim_2_add, 1, var_0);
  self setanimlimited(%prone_aim_4_add, 1, var_0);
  self setanimlimited(%prone_aim_6_add, 1, var_0);
  self setanimlimited(%prone_aim_8_add, 1, var_0);
}

_id_10B0(var_0, var_1) {
  self clearanim(%root, 0.3);
  var_2 = undefined;

  if(_id_10E8()) {
    if(var_0 == "crouch") {
      var_2 = % prone_2_crouch_firing;
    } else if(var_0 == "stand") {
      var_2 = % prone_2_stand_firing;
    }
  } else if(var_0 == "crouch") {
    var_2 = % prone_2_crouch;
  } else if(var_0 == "stand") {
    var_2 = % prone_2_stand_nodelta;
  }
  if(isDefined(self._id_10ED)) {
    var_2 = self._id_10ED;
  }
  if(isDefined(self._id_10EE)) {
    var_1 = self._id_10EE;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }
  animscripts\utility::_id_0F7D(getanimlength(var_2) / 2);
  self setflaggedanimknoballrestart("trans", var_2, %body, 1, 0.2, var_1);
  animscripts\shared::_id_0C51("trans");
  self clearanim(var_2, 0.1);
}