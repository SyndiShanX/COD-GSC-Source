/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3109.gsc
**************************************/

_id_98CA(var_0) {
  if(isDefined(self.bt._id_9882))
    return anim.success;

  self.bt._id_F15D = undefined;
  self.bt._id_1152B = 0;
  self.bt._id_1154B = 0;
  self.asm._id_7360 = 0;
  self.asm._id_4C86 = spawnStruct();
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.bt._id_54AE = 0;
  _id_0A10::_id_F13B(var_0);
  thread _id_AC76();
  thread damage_monitor();
  thread _id_F16F();
  thread _id_6744();
  thread _id_EB63();
  thread _id_13940();
  self setthreatbiasgroup("equipment");
  return anim.success;
}

_id_6744() {
  while(!isDefined(self.owner))
    wait 0.05;

  if(self.team == "allies")
    self.bt._id_652A = "axis";
  else if(self.team == "team3" && isDefined(self._id_C93D))
    self.bt._id_652A = "team3";
  else
    self.bt._id_652A = "allies";

  self.bt._id_F15D = self.owner;
  self.bt._id_9882 = 1;
}

_id_AC76() {
  if(isDefined(self.bt._id_AC75)) {
    return;
  }
  self endon("death");
  self.bt._id_AC75 = 40;
  var_0 = 2;
  var_1 = 0;

  while(var_1 != var_0) {
    wait(self.bt._id_AC75);

    if(isDefined(self._id_595E)) {
      wait 5;
      continue;
    }

    if(_id_9B71()) {
      self.bt._id_AC75 = self.bt._id_AC75 * 0.5;
      var_1++;
      continue;
    } else
      break;
  }

  thread _id_EA0E();
}

damage_monitor() {
  if(isDefined(self.damage_monitor)) {
    return;
  }
  self.damage_monitor = 1;
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && var_1 == self) {
      return;
    }
    if(isDefined(self._id_9BB9)) {
      return;
    }
    if(isDefined(var_1) && var_1 _id_9CB7()) {
      self notify("force_detonate");
      return;
    }
  }
}

_id_F16F() {
  self waittill("death");
  level._id_F10A._id_1633 = scripts\engine\utility::array_remove(level._id_F10A._id_1633, self);
  _id_0E46::_id_DFE3();

  if(isDefined(self._id_9BB9) || isDefined(self._id_EA0E)) {
    return;
  }
  _id_0E26::_id_F11E(1);
}

_id_9B71() {
  if(self.bt._id_F15D != self.owner && distancesquared(self.origin, self.bt._id_F15D.origin) < 640000 && self._id_164D["seeker"]._id_4BC0 == "run_loop")
    return 1;

  return 0;
}

_id_EA0E() {
  self._id_EA0E = 1;
  stopFXOnTag(level._id_7649[self._id_F166], self, "tag_fx");
  self _meth_8484();
  self _meth_8481(self.origin);

  if(isDefined(self._id_B14F))
    scripts\sp\utility::_id_1101B();

  playFXOnTag(level._id_7649["seeker_sparks"], self, "tag_fx");
  playworldsound("seeker_expire", self.origin);
  destroynavrepulsor("ent_" + self getentitynumber() + "_seeker_repulsor");
  self hudoutlinedisable();
  self _meth_81D0();
}

_id_EB63() {
  self endon("death");

  for(;;) {
    if(isDefined(self.bt._id_F15D) && self.bt._id_F15D != self.owner && isDefined(self.pathgoalpos))
      self._id_A9CB = self.pathgoalpos;

    wait 0.25;
  }
}

_id_13940() {
  self endon("death");

  for(;;) {
    self waittill("bad_path");

    if(isDefined(self.bt._id_F15D) && self.bt._id_F15D != self.owner) {
      if(isDefined(self._id_728A) || isPlayer(self.bt._id_F15D)) {
        if(isDefined(self._id_A9CB)) {
          self._id_8425 = 1;
          self _meth_8481(self._id_A9CB);
          wait 2;
          self._id_8425 = undefined;
        }

        continue;
      }

      clear_scripted_anim(1);
    }
  }
}

_id_1572(var_0) {
  if(!isDefined(self.bt._id_9882))
    return anim.failure;

  if(isDefined(self._id_EA0E) || isDefined(self._id_C93D) || isDefined(self._id_9BB9) || isDefined(self._id_50EB))
    return anim.success;

  if(isDefined(self.bt._id_F15D) && !isDefined(self._id_728A)) {
    if(!isalive(self.bt._id_F15D) || self.bt._id_F15D.ignoreme || isDefined(self.bt._id_F15D._id_C012))
      clear_scripted_anim(0);
  }

  if(!self.bt._id_1152B) {
    var_1 = !isDefined(self.bt._id_F15D) || self.bt._id_F15D == self.owner;
    var_2 = _id_0E26::_id_7C41(!var_1);

    if(isDefined(var_2) && var_2 != self.owner)
      _id_DED7(var_2);
  }

  _id_8420();

  if(isDefined(self.bt._id_F15D) && self.bt._id_F15D != self.owner && !isDefined(self._id_9BB9) && !self.bt._id_54AE) {
    self.bt._id_54AE = 1;
    self notify("stop soundseeker_seek_lp");
    playworldsound("seeker_acquire_target", self.origin);

    if(self._id_2A4B)
      thread _id_CE01();
  }

  return anim.success;
}

_id_CE01() {
  self endon("death");
  self endon("stop soundseeker_target_acquire_lp");
  wait 0.5;
  thread scripts\sp\utility::play_loop_sound_on_entity_with_pitch("seeker_target_acquire_lp", undefined, 3, 18);
}

_id_F177(var_0) {
  if(isDefined(self._id_55B1) && self._id_55B1)
    return anim.failure;

  if(isDefined(self._id_9BB9) || isDefined(self._id_C93D) || isDefined(self._id_50EB))
    return anim.failure;

  if(self.bt._id_F15D == self.owner)
    return anim.failure;

  if(isDefined(self._id_8425) || isDefined(self._id_391C))
    return anim.failure;

  if(isDefined(self.bt._id_F15D.unittype)) {
    var_1 = 0;

    switch (self.bt._id_F15D.unittype) {
      case "soldier":
      case "civilian":
      case "c6":
        var_1 = 1;
        break;
    }

    if(!var_1)
      return anim.failure;
  }

  if(issubstr(self.bt._id_F15D.classname, "worker"))
    return anim.failure;

  return scripts\aitypes\melee::shouldmelee(var_0, self.bt._id_F15D);
}

_id_13850(var_0) {
  if(!isalive(self.bt._id_F15D)) {
    if(isPlayer(self.bt._id_F15D))
      self _meth_8481(self.origin);

    return anim.failure;
  }

  if(isDefined(self._id_EA0E))
    return anim.success;

  var_1 = distancesquared(self.origin, self.bt._id_F15D.origin);

  if(isDefined(self._id_8425) && isDefined(self._id_A9CB))
    var_1 = distancesquared(self.origin, self._id_A9CB);
  else if(isDefined(self._id_391C) && isDefined(self._id_7296))
    var_1 = distancesquared(self.origin, self._id_7296);

  var_2 = 72;

  if(isPlayer(self.bt._id_F15D))
    var_2 = 25;

  if(var_1 <= squared(var_2)) {
    self _meth_8484();
    self _meth_8481(self.origin);
    return anim.success;
  } else
    _id_8420();

  return anim.running;
}

_id_2BD3(var_0) {
  if(isDefined(self._id_55B1) && self._id_55B1)
    return anim.failure;

  if(self.bt._id_F15D == self.owner)
    return anim.failure;

  if(isDefined(self.melee))
    return anim.failure;

  if(isDefined(self._id_9BB9) || isDefined(self._id_C93D) || isDefined(self._id_50EB))
    return anim.failure;

  thread _id_0E26::_id_F11C();
  return anim.running;
}

_id_8420() {
  if(isDefined(self._id_EA0E) || isDefined(self._id_C93D)) {
    return;
  }
  if(isPlayer(self.bt._id_F15D)) {
    if(self.bt._id_F15D == self.owner)
      self.btgoalradius = 120;
    else
      self.btgoalradius = 13;
  } else if(isDefined(self.bt._id_F15D) && self.bt._id_F15D == self.owner)
    self.btgoalradius = 120;
  else
    self.btgoalradius = 60;

  if(isDefined(self._id_8425)) {
    return;
  }
  if(isDefined(self.bt._id_F15D)) {
    var_0 = getclosestpointonnavmesh(self.bt._id_F15D.origin, self);
    var_1 = distancesquared(var_0, self.bt._id_F15D.origin);

    if(var_1 <= squared(12)) {
      self._id_391C = undefined;
      self._id_7296 = undefined;
      self _meth_8482(self.bt._id_F15D);
    } else {
      self._id_391C = 1;
      self._id_7296 = var_0;
      self _meth_8481(self._id_7296);
    }
  }
}

_id_2295(var_0) {
  return var_0.size > 0;
}

_id_CBC1() {
  self._id_CBA0._id_1169D = [];
  self._id_CBA0._id_1169D["top"] = level.player _id_CBA9();
  self._id_CBA0._id_1169D["bottom"] = level.player _id_CBA9();
  self._id_CBA0._id_1169D["top"].x = 590;
  self._id_CBA0._id_1169D["top"].y = 21;
  self._id_CBA0._id_1169D["top"].font = "default";
  self._id_CBA0._id_1169D["top"]._id_7253 = 0.2;
  self._id_CBA0._id_1169D["top"] settext("Seeker Online");
  self._id_CBA0._id_1169D["bottom"].x = 602;
  self._id_CBA0._id_1169D["bottom"].y = 165;
  self._id_CBA0._id_1169D["bottom"].font = "default";
  self._id_CBA0._id_1169D["bottom"]._id_7253 = 0.2;
  self._id_CBA0._id_1169D["bottom"] settext("Target Acquired");
}

_id_CBA9() {
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "right";
  var_0.aligny = "top";
  var_0.sort = 10;
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  return var_0;
}

_id_E098(var_0, var_1) {
  var_0 endon("new_bt_target");
  var_0 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  var_1 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  var_1 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "start_context_melee");
  scripts\sp\utility::_id_57D6();
  level._id_F10A.targets = scripts\engine\utility::array_remove(level._id_F10A.targets, var_1);
}

_id_F15F(var_0) {
  if(scripts\engine\utility::array_contains(level._id_F10A.targets, var_0))
    return 0;

  return 1;
}

_id_DED7(var_0) {
  if(isDefined(self._id_9BB9) || isDefined(self._id_EA0E) || isDefined(self._id_50EB)) {
    return;
  }
  if(isDefined(self.bt._id_F15D) && self.bt._id_F15D == var_0) {
    return;
  }
  if(isDefined(self.bt._id_F15D) && self.bt._id_F15D != var_0 && scripts\engine\utility::array_contains(level._id_F10A.targets, self.bt._id_F15D))
    clear_scripted_anim(0);

  level._id_F10A.targets[level._id_F10A.targets.size] = var_0;
  self.favoriteenemy = var_0;
  self.bt._id_F15D = var_0;
  self.bt._id_1154B = gettime();
  var_0._id_F126 = self;
  self notify("set_bt_target");

  if(isai(var_0) && isDefined(self.owner) && isPlayer(self.owner))
    thread _id_F120(var_0);

  level thread _id_E098(self, var_0);
}

clear_scripted_anim(var_0) {
  self notify("new_bt_target");
  self.bt._id_F15D notify("seeker_stop_outline");
  self notify("stop soundseeker_target_acquire_lp");

  if(var_0)
    self._id_2745 = scripts\engine\utility::array_add(self._id_2745, self.bt._id_F15D);

  level._id_F10A.targets = scripts\engine\utility::array_remove(level._id_F10A.targets, self.bt._id_F15D);

  if(isalive(self.owner))
    self.bt._id_F15D = self.owner;
  else
    self.bt._id_F15D = undefined;

  self.bt._id_1152B = 0;
  self.favoriteenemy = undefined;
  self.bt._id_1154B = 0;
  self.bt._id_54AE = 0;
}

_id_F120(var_0) {
  var_0 endon("death");
  var_0 endon("seeker_stop_outline");
  self endon("meleegrab_start");
  self endon("death");
  thread _id_F123(var_0);
  thread _id_F125(var_0);
  thread _id_F124(var_0);
  wait 0.25;
  var_0 scripts\sp\utility::_id_9196(1, 0, 1, "default_seeker");
  wait 0.15;
  var_0 scripts\sp\utility::_id_9193("default_seeker");
  wait 0.1;
  var_0 scripts\sp\utility::_id_9196(1, 0, 1, "default_seeker");
  wait 0.15;
  var_0 scripts\sp\utility::_id_9193("default_seeker");
  wait 0.1;
  var_0 scripts\sp\utility::_id_9196(1, 0, 1, "default_seeker");
  wait 0.15;
  var_0 scripts\sp\utility::_id_9193("default_seeker");
  wait 0.1;
  var_0 scripts\sp\utility::_id_9196(1, 0, 1, "default_seeker");
}

_id_F123(var_0) {
  var_0 scripts\engine\utility::waittill_either("death", "seeker_stop_outline");
  var_0 scripts\sp\utility::_id_9193("default_seeker");
}

_id_F125(var_0) {
  var_0 endon("death");
  self endon("new_bt_target");
  self waittill("death");
  var_0 notify("seeker_stop_outline");
  var_0 scripts\sp\utility::_id_9193("default_seeker");
}

_id_F124(var_0) {
  var_0 endon("death");
  self endon("death");
  self endon("new_bt_target");
  self waittill("meleegrab_start");
  waittillframeend;
  var_0 scripts\sp\utility::_id_9196(1, 0, 0, "default_seeker");
  scripts\sp\utility::_id_9196(3, 0, 0, "default_seeker");
}

_id_9CB7() {
  return isDefined(self.asmname) && self.asmname == "seeker";
}

_id_4F0B(var_0) {}