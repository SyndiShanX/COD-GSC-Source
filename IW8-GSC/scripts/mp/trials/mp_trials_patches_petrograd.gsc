/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_trials_patches_petrograd.gsc
*************************************************************/

function ref_134b3(var_0, var_1, var_2) {
  thread ref_134a0(var_0, var_1);

  if(scripts\asm\asm_bb::bb_moverequested()) {
    return;
  }

  self.bshootidle = 1;
  scripts\asm\asm::asm_playadditiveanimloopstate(var_0, var_1, var_2);
}

function ref_134a0(var_0, var_1) {
  self endon(var_1 + "_finished");

  if(!istrue(self.ignoreburstdelay)) {
    ref_13483();
  }

  scripts\asm\asm::asm_fireevent(var_0, "burst_delay_finished");
}

function ref_13483() {
  if(scripts\asm\asm_bb::bb_shootparams_idsmatch() && self._blackboard.shootparams_style == "full" && !self._blackboard.shootparams_fastburst) {
    if(self.a.lastshoottime == gettime()) {
      waitframe();
    }

    return;
  }

  var_0 = ref_1349d();

  if(var_0) {
    wait var_0;
    return;
  }
}

function ref_1349d() {
  var_0 = (gettime() - self.a.lastshoottime) / 1000;
  var_1 = ref_13499();

  if(var_1 > var_0) {
    return (var_1 - var_0);
  }

  return 0;
}

function ref_13499() {
  if(scripts\asm\shoot\script_funcs::using_a_turret() || weaponclass(self.weapon) == "mg") {
    return scripts\asm\shoot\script_funcs::getburstdelaytimemg();
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return randomfloatrange(0.1, 0.45);
  }

  if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    return randomfloatrange(2, 2.7);
  } else if(scripts\anim\utility_common::weapon_genade_launcher()) {
    return scripts\asm\shared\utility::grenadelauncherfirerate();
  } else if(weaponclass(self.weapon) == "rocketlauncher") {
    return randomfloatrange(6, 8);
  }

  if(scripts\anim\utility_common::isasniper()) {
    return randomfloatrange(2, 3);
  }

  if(scripts\asm\asm_bb::bb_shootparams_idsmatch()) {
    if(self._blackboard.shootparams_fastburst) {
      if(isDefined(self._blackboard.shootparams_ent)) {
        return randomfloatrange(0.1, 0.35);
      } else {
        return randomfloatrange(0.6, 1);
      }
    }

    if(isDefined(self._blackboard.shootparams_ent)) {
      return randomfloatrange(0.4, 0.9);
    } else {
      return randomfloatrange(0.8, 1.2);
    }
  }

  return randomfloatrange(0.8, 1.2);
}