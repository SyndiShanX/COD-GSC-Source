/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\cover_prone.gsc
****************************************/

_id_9509() {}

#using_animtree("generic_human");

main() {
  self endon("killanimscript");
  scripts\anim\utility::_id_9832("cover_prone");

  if(weaponclass(self.weapon) == "rocketlauncher") {
    scripts\anim\combat::main();
    return;
  }

  if(isDefined(self.node.turret)) {
    scripts\anim\cover_wall::_id_130DF();
  }

  if(isDefined(self.enemy) && lengthsquared(self.origin - self.enemy.origin) < squared(512)) {
    thread scripts\anim\combat::main();
    return;
  }

  _id_F924();
  self.covernode = self.node;
  self orientmode("face angle", self.covernode.angles[1]);
  self.a._id_8445 = 1;
  self setproneanimnodes(-45, 45, %prone_legs_down, %exposed_modern, %prone_legs_up);

  if(self.a.pose != "prone") {
    prone_transitionto("prone");
  } else {
    scripts\anim\utility::enterpronewrapper(0);
  }

  thread scripts\anim\combat_utility::_id_1A3E();
  _id_FADE(0.2);
  self _meth_82A2(%prone_aim_5, 1, 0.1);
  self orientmode("face angle", self.covernode.angles[1]);
  self animmode("zonly_physics");
  _id_DA7E();
  self notify("stop_deciding_how_to_shoot");
}

end_script() {
  self.a._id_8445 = undefined;
}

_id_92FF() {
  self endon("killanimscript");
  self endon("kill_idle_thread");

  for(;;) {
    var_0 = scripts\anim\utility::_id_1F67("prone_idle");
    self _meth_82E8("idle", var_0);
    self waittillmatch("idle", "end");
    self clearanim(var_0, 0.2);
  }
}

_id_12EF6(var_0) {
  self _meth_83CF(scripts\anim\utility::_id_B027("cover_prone", "legs_up"), scripts\anim\utility::_id_B027("cover_prone", "legs_down"), 1, var_0, 1);
  self _meth_82A2(%exposed_aiming, 1, 0.2);
}

_id_DA7E() {
  self endon("killanimscript");
  thread scripts\anim\track::_id_11B07();
  thread scripts\anim\shoot_behavior::_id_4F69("normal");
  var_0 = gettime() > 2500;

  for(;;) {
    scripts\anim\utility::_id_12EB9();
    _id_12EF6(0.05);

    if(!var_0) {
      wait(0.05 + randomfloat(1.5));
      var_0 = 1;
      continue;
    }

    if(!isDefined(self._id_FECF)) {
      if(_id_453F()) {
        continue;
      }
      wait 0.05;
      continue;
    }

    var_1 = lengthsquared(self.origin - self._id_FECF);

    if(self.a.pose != "crouch" && self _meth_81BF("crouch") && var_1 < squared(400)) {
      if(var_1 < squared(285)) {
        prone_transitionto("crouch");
        thread scripts\anim\combat::main();
        return;
      }
    }

    if(_id_453F()) {
      continue;
    }
    if(_id_DA83(0)) {
      continue;
    }
    if(scripts\anim\combat_utility::_id_1A3B()) {
      scripts\anim\combat_utility::_id_FEDF();
      self clearanim(%add_fire, 0.2);
      continue;
    }

    wait 0.05;
  }
}

_id_DA83(var_0) {
  return scripts\anim\combat_utility::reload(var_0, scripts\anim\utility::_id_1F64("reload"));
}

_id_F924() {
  self _meth_82D0(self.node);
  self.a._id_2274 = scripts\anim\utility::_id_B028("cover_prone");
}

_id_128AF(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1) && var_1) {
    var_2 = scripts\anim\utility::_id_1F67("grenade_safe");
  } else {
    var_2 = scripts\anim\utility::_id_1F67("grenade_exposed");
  }

  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  var_3 = (32, 20, 64);
  var_4 = scripts\anim\combat_utility::_id_128A0(var_0, var_2);
  self.keepclaimednodeifvalid = 0;
  return var_4;
}

_id_453F() {
  if(isDefined(anim._id_11813) && isalive(level.player)) {
    if(_id_128AF(level.player, 200)) {
      return 1;
    }
  }

  if(isDefined(self.enemy)) {
    return _id_128AF(self.enemy, 850);
  }

  return 0;
}

_id_10012() {
  if(!isDefined(self.weapon) || !weaponisauto(self.weapon) || !weaponisbeam(self.weapon)) {
    return 0;
  }

  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 256) {
    return 0;
  }

  if(isDefined(self.enemy) && self cansee(self.enemy) && !isDefined(self.grenade) && scripts\anim\shared::getaimyawtoshootentorpos() < 20) {
    return scripts\anim\move::_id_B4EC();
  }

  return 0;
}

prone_transitionto(var_0) {
  if(var_0 == self.a.pose) {
    return;
  }
  self clearanim(%root, 0.3);
  scripts\anim\combat_utility::_id_631A();

  if(_id_10012()) {
    var_1 = scripts\anim\utility::_id_1F64(self.a.pose + "_2_" + var_0 + "_firing");
  } else {
    var_1 = scripts\anim\utility::_id_1F64(self.a.pose + "_2_" + var_0);
  }

  if(var_0 == "prone") {}

  self _meth_82E4("trans", var_1, %body, 1, 0.2, 1.0);
  scripts\anim\shared::donotetracks("trans");
  self _meth_82A8(scripts\anim\utility::_id_1F64("straight_level"), %body, 1, 0.25);
  _id_FADE(0.25);
}

_id_6CDE(var_0) {
  self endon("killanimscript");
  scripts\anim\shared::donotetracks(var_0);
}

_id_FADE(var_0) {
  self _meth_82A5(%prone_aim_5, %body, 1, var_0);
  self _meth_82AC(%prone_aim_2_add, 1, var_0);
  self _meth_82AC(%prone_aim_4_add, 1, var_0);
  self _meth_82AC(%prone_aim_6_add, 1, var_0);
  self _meth_82AC(%prone_aim_8_add, 1, var_0);
}

_id_DA87(var_0, var_1) {
  self clearanim(%root, 0.3);
  var_2 = undefined;

  if(isDefined(self._id_DA78)) {
    var_2 = self._id_DA78;
  }

  if(isDefined(self.prone_rate_override)) {
    var_1 = self.prone_rate_override;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  scripts\anim\utility::exitpronewrapper(getanimlength(var_2) / 2);
  self _meth_82E4("trans", var_2, %body, 1, 0.2, var_1);
  scripts\anim\shared::donotetracks("trans");
  self clearanim(var_2, 0.1);
}