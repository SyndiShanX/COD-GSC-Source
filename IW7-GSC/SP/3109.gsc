/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3109.gsc
*********************************************/

func_98CA(var_0) {
  if(isDefined(self.bt.var_9882)) {
    return level.success;
  }

  self.bt.var_F15D = undefined;
  self.bt.var_1152B = 0;
  self.bt.var_1154B = 0;
  self.asm.var_7360 = 0;
  self.asm.var_4C86 = spawnStruct();
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.bt.var_54AE = 0;
  lib_0A10::func_F13B(var_0);
  thread func_AC76();
  thread damage_monitor();
  thread func_F16F();
  thread func_6744();
  thread func_EB63();
  thread func_13940();
  self give_zombies_perk("equipment");
  return level.success;
}

func_6744() {
  while(!isDefined(self.triggerportableradarping)) {
    wait(0.05);
  }

  if(self.team == "allies") {
    self.bt.var_652A = "axis";
  } else if(self.team == "team3" && isDefined(self.var_C93D)) {
    self.bt.var_652A = "team3";
  } else {
    self.bt.var_652A = "allies";
  }

  self.bt.var_F15D = self.triggerportableradarping;
  self.bt.var_9882 = 1;
}

func_AC76() {
  if(isDefined(self.bt.var_AC75)) {
    return;
  }

  self endon("death");
  self.bt.var_AC75 = 40;
  var_0 = 2;
  var_1 = 0;
  while(var_1 != var_0) {
    wait(self.bt.var_AC75);
    if(isDefined(self.var_595E)) {
      wait(5);
      continue;
    }

    if(func_9B71()) {
      self.bt.var_AC75 = self.bt.var_AC75 * 0.5;
      var_1++;
      continue;
    } else {
      break;
    }
  }

  thread func_EA0E();
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

    if(isDefined(self.var_9BB9)) {
      return;
    }

    if(isDefined(var_1) && var_1 func_9CB7()) {
      self notify("force_detonate");
      return;
    }
  }
}

func_F16F() {
  self waittill("death");
  level.var_F10A.var_1633 = scripts\engine\utility::array_remove(level.var_F10A.var_1633, self);
  lib_0E46::func_DFE3();
  if(isDefined(self.var_9BB9) || isDefined(self.var_EA0E)) {
    return;
  }

  lib_0E26::func_F11E(1);
}

func_9B71() {
  if(self.bt.var_F15D != self.triggerportableradarping && distancesquared(self.origin, self.bt.var_F15D.origin) < 640000 && self.var_164D["seeker"].var_4BC0 == "run_loop") {
    return 1;
  }

  return 0;
}

func_EA0E() {
  self.var_EA0E = 1;
  stopFXOnTag(level.var_7649[self.var_F166], self, "tag_fx");
  self _meth_8484();
  self _meth_8481(self.origin);
  if(isDefined(self.var_B14F)) {
    scripts\sp\utility::func_1101B();
  }

  playFXOnTag(level.var_7649["seeker_sparks"], self, "tag_fx");
  playworldsound("seeker_expire", self.origin);
  destroynavrepulsor("ent_" + self getentitynumber() + "_seeker_repulsor");
  self hudoutlinedisable();
  self _meth_81D0();
}

func_EB63() {
  self endon("death");
  for(;;) {
    if(isDefined(self.bt.var_F15D) && self.bt.var_F15D != self.triggerportableradarping && isDefined(self.vehicle_getspawnerarray)) {
      self.var_A9CB = self.vehicle_getspawnerarray;
    }

    wait(0.25);
  }
}

func_13940() {
  self endon("death");
  for(;;) {
    self waittill("bad_path");
    if(isDefined(self.bt.var_F15D) && self.bt.var_F15D != self.triggerportableradarping) {
      if(isDefined(self.var_728A) || isplayer(self.bt.var_F15D)) {
        if(isDefined(self.var_A9CB)) {
          self._meth_8425 = 1;
          self _meth_8481(self.var_A9CB);
          wait(2);
          self._meth_8425 = undefined;
        }

        continue;
      }

      clear_scripted_anim(1);
    }
  }
}

func_1572(var_0) {
  if(!isDefined(self.bt.var_9882)) {
    return level.failure;
  }

  if(isDefined(self.var_EA0E) || isDefined(self.var_C93D) || isDefined(self.var_9BB9) || isDefined(self.var_50EB)) {
    return level.success;
  }

  if(isDefined(self.bt.var_F15D) && !isDefined(self.var_728A)) {
    if(!isalive(self.bt.var_F15D) || self.bt.var_F15D.ignoreme || isDefined(self.bt.var_F15D.var_C012)) {
      clear_scripted_anim(0);
    }
  }

  if(!self.bt.var_1152B) {
    var_1 = !isDefined(self.bt.var_F15D) || self.bt.var_F15D == self.triggerportableradarping;
    var_2 = lib_0E26::func_7C41(!var_1);
    if(isDefined(var_2) && var_2 != self.triggerportableradarping) {
      func_DED7(var_2);
    }
  }

  _meth_8420();
  if(isDefined(self.bt.var_F15D) && self.bt.var_F15D != self.triggerportableradarping && !isDefined(self.var_9BB9) && !self.bt.var_54AE) {
    self.bt.var_54AE = 1;
    self notify("stop soundseeker_seek_lp");
    playworldsound("seeker_acquire_target", self.origin);
    if(self.var_2A4B) {
      thread func_CE01();
    }
  }

  return level.success;
}

func_CE01() {
  self endon("death");
  self endon("stop soundseeker_target_acquire_lp");
  wait(0.5);
  thread scripts\sp\utility::play_loop_sound_on_entity_with_pitch("seeker_target_acquire_lp", undefined, 3, 18);
}

func_F177(var_0) {
  if(isDefined(self.var_55B1) && self.var_55B1) {
    return level.failure;
  }

  if(isDefined(self.var_9BB9) || isDefined(self.var_C93D) || isDefined(self.var_50EB)) {
    return level.failure;
  }

  if(self.bt.var_F15D == self.triggerportableradarping) {
    return level.failure;
  }

  if(isDefined(self._meth_8425) || isDefined(self.var_391C)) {
    return level.failure;
  }

  if(isDefined(self.bt.var_F15D.unittype)) {
    var_1 = 0;
    switch (self.bt.var_F15D.unittype) {
      case "soldier":
      case "civilian":
      case "c6":
        var_1 = 1;
        break;
    }

    if(!var_1) {
      return level.failure;
    }
  }

  if(issubstr(self.bt.var_F15D.classname, "worker")) {
    return level.failure;
  }

  return scripts\aitypes\melee::shouldmelee(var_0, self.bt.var_F15D);
}

func_13850(var_0) {
  if(!isalive(self.bt.var_F15D)) {
    if(isplayer(self.bt.var_F15D)) {
      self _meth_8481(self.origin);
    }

    return level.failure;
  }

  if(isDefined(self.var_EA0E)) {
    return level.success;
  }

  var_1 = distancesquared(self.origin, self.bt.var_F15D.origin);
  if(isDefined(self._meth_8425) && isDefined(self.var_A9CB)) {
    var_1 = distancesquared(self.origin, self.var_A9CB);
  } else if(isDefined(self.var_391C) && isDefined(self.var_7296)) {
    var_1 = distancesquared(self.origin, self.var_7296);
  }

  var_2 = 72;
  if(isplayer(self.bt.var_F15D)) {
    var_2 = 25;
  }

  if(var_1 <= squared(var_2)) {
    self _meth_8484();
    self _meth_8481(self.origin);
    return level.success;
  } else {
    _meth_8420();
  }

  return level.running;
}

func_2BD3(var_0) {
  if(isDefined(self.var_55B1) && self.var_55B1) {
    return level.failure;
  }

  if(self.bt.var_F15D == self.triggerportableradarping) {
    return level.failure;
  }

  if(isDefined(self.melee)) {
    return level.failure;
  }

  if(isDefined(self.var_9BB9) || isDefined(self.var_C93D) || isDefined(self.var_50EB)) {
    return level.failure;
  }

  thread lib_0E26::func_F11C();
  return level.running;
}

_meth_8420() {
  if(isDefined(self.var_EA0E) || isDefined(self.var_C93D)) {
    return;
  }

  if(isplayer(self.bt.var_F15D)) {
    if(self.bt.var_F15D == self.triggerportableradarping) {
      self.var_6D = 120;
    } else {
      self.var_6D = 13;
    }
  } else if(isDefined(self.bt.var_F15D) && self.bt.var_F15D == self.triggerportableradarping) {
    self.var_6D = 120;
  } else {
    self.var_6D = 60;
  }

  if(isDefined(self._meth_8425)) {
    return;
  }

  if(isDefined(self.bt.var_F15D)) {
    var_0 = getclosestpointonnavmesh(self.bt.var_F15D.origin, self);
    var_1 = distancesquared(var_0, self.bt.var_F15D.origin);
    if(var_1 <= squared(12)) {
      self.var_391C = undefined;
      self.var_7296 = undefined;
      self _meth_8482(self.bt.var_F15D);
      return;
    }

    self.var_391C = 1;
    self.var_7296 = var_0;
    self _meth_8481(self.var_7296);
  }
}

func_2295(var_0) {
  return var_0.size > 0;
}

func_CBC1() {
  self.var_CBA0.var_1169D = [];
  self.var_CBA0.var_1169D["top"] = level.player func_CBA9();
  self.var_CBA0.var_1169D["bottom"] = level.player func_CBA9();
  self.var_CBA0.var_1169D["top"].x = 590;
  self.var_CBA0.var_1169D["top"].y = 21;
  self.var_CBA0.var_1169D["top"].font = "default";
  self.var_CBA0.var_1169D["top"].var_7253 = 0.2;
  self.var_CBA0.var_1169D["top"] settext("Seeker Online");
  self.var_CBA0.var_1169D["bottom"].x = 602;
  self.var_CBA0.var_1169D["bottom"].y = 165;
  self.var_CBA0.var_1169D["bottom"].font = "default";
  self.var_CBA0.var_1169D["bottom"].var_7253 = 0.2;
  self.var_CBA0.var_1169D["bottom"] settext("Target Acquired");
}

func_CBA9() {
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

func_E098(var_0, var_1) {
  var_0 endon("new_bt_target");
  var_0 scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "death");
  var_1 scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "death");
  var_1 scripts\sp\utility::func_178D(::scripts\sp\utility::func_137AA, "start_context_melee");
  scripts\sp\utility::func_57D6();
  level.var_F10A.targets = scripts\engine\utility::array_remove(level.var_F10A.targets, var_1);
}

func_F15F(var_0) {
  if(scripts\engine\utility::array_contains(level.var_F10A.targets, var_0)) {
    return 0;
  }

  return 1;
}

func_DED7(var_0) {
  if(isDefined(self.var_9BB9) || isDefined(self.var_EA0E) || isDefined(self.var_50EB)) {
    return;
  }

  if(isDefined(self.bt.var_F15D) && self.bt.var_F15D == var_0) {
    return;
  }

  if(isDefined(self.bt.var_F15D) && self.bt.var_F15D != var_0 && scripts\engine\utility::array_contains(level.var_F10A.targets, self.bt.var_F15D)) {
    clear_scripted_anim(0);
  }

  level.var_F10A.targets[level.var_F10A.targets.size] = var_0;
  self.loadstartpointtransients = var_0;
  self.bt.var_F15D = var_0;
  self.bt.var_1154B = gettime();
  var_0.var_F126 = self;
  self notify("set_bt_target");
  if(isai(var_0) && isDefined(self.triggerportableradarping) && isplayer(self.triggerportableradarping)) {
    thread func_F120(var_0);
  }

  level thread func_E098(self, var_0);
}

clear_scripted_anim(var_0) {
  self notify("new_bt_target");
  self.bt.var_F15D notify("seeker_stop_outline");
  self notify("stop soundseeker_target_acquire_lp");
  if(var_0) {
    self.var_2745 = scripts\engine\utility::array_add(self.var_2745, self.bt.var_F15D);
  }

  level.var_F10A.targets = scripts\engine\utility::array_remove(level.var_F10A.targets, self.bt.var_F15D);
  if(isalive(self.triggerportableradarping)) {
    self.bt.var_F15D = self.triggerportableradarping;
  } else {
    self.bt.var_F15D = undefined;
  }

  self.bt.var_1152B = 0;
  self.loadstartpointtransients = undefined;
  self.bt.var_1154B = 0;
  self.bt.var_54AE = 0;
}

func_F120(var_0) {
  var_0 endon("death");
  var_0 endon("seeker_stop_outline");
  self endon("meleegrab_start");
  self endon("death");
  thread func_F123(var_0);
  thread func_F125(var_0);
  thread func_F124(var_0);
  wait(0.25);
  var_0 scripts\sp\utility::func_9196(1, 0, 1, "default_seeker");
  wait(0.15);
  var_0 scripts\sp\utility::func_9193("default_seeker");
  wait(0.1);
  var_0 scripts\sp\utility::func_9196(1, 0, 1, "default_seeker");
  wait(0.15);
  var_0 scripts\sp\utility::func_9193("default_seeker");
  wait(0.1);
  var_0 scripts\sp\utility::func_9196(1, 0, 1, "default_seeker");
  wait(0.15);
  var_0 scripts\sp\utility::func_9193("default_seeker");
  wait(0.1);
  var_0 scripts\sp\utility::func_9196(1, 0, 1, "default_seeker");
}

func_F123(var_0) {
  var_0 scripts\engine\utility::waittill_either("death", "seeker_stop_outline");
  var_0 scripts\sp\utility::func_9193("default_seeker");
}

func_F125(var_0) {
  var_0 endon("death");
  self endon("new_bt_target");
  self waittill("death");
  var_0 notify("seeker_stop_outline");
  var_0 scripts\sp\utility::func_9193("default_seeker");
}

func_F124(var_0) {
  var_0 endon("death");
  self endon("death");
  self endon("new_bt_target");
  self waittill("meleegrab_start");
  waittillframeend;
  var_0 scripts\sp\utility::func_9196(1, 0, 0, "default_seeker");
  scripts\sp\utility::func_9196(3, 0, 0, "default_seeker");
}

func_9CB7() {
  return isDefined(self.asmname) && self.asmname == "seeker";
}

func_4F0B(var_0) {}