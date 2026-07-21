/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\mp_trials_patches_petrograd.gsc
*****************************************************/

_id_134B3(var_0, var_1, var_2) {
  thread _id_134A0(var_0, var_1);

  if(scripts\asm\asm_bb::bb_moverequested()) {
    return;
  }
  self.bshootidle = 1;
  scripts\asm\asm::asm_playadditiveanimloopstate(var_0, var_1, var_2);
}

_id_134A0(var_0, var_1) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");

  if(!istrue(self.ignoreburstdelay))
    _id_13483();

  scripts\asm\asm::asm_fireevent(var_0, "_encstr_BAC91580A3480B7BF9E09054271868D663F6188BA0AFC9");
}

_id_13483() {
  if(scripts\asm\asm_bb::bb_shootparams_idsmatch() && self._blackboard.shootparams_style == "_encstr_997805335763B1" && !self._blackboard.shootparams_fastburst) {
    if(self.a.lastshoottime == gettime())
      waitframe();

    return;
  }

  var_0 = _id_1349D();

  if(var_0)
    wait(var_0);
}

_id_1349D() {
  var_0 = (gettime() - self.a.lastshoottime) / 1000;
  var_1 = _id_13499();

  if(var_1 > var_0)
    return var_1 - var_0;

  return 0;
}

_id_13499() {
  if(scripts\asm\shoot\script_funcs::using_a_turret() || weaponclass(self.weapon) == "_encstr_BE0703A54C")
    return scripts\asm\shoot\script_funcs::getburstdelaytimemg();

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isusingsidearm())
    return randomfloatrange(0.1, 0.45);

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::weapon_pump_action_shotgun())
    return randomfloatrange(2.0, 2.7);
  else if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::weapon_genade_launcher())
    return scripts\asm\shared\utility::grenadelauncherfirerate();
  else if(weaponclass(self.weapon) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
    return randomfloatrange(6, 8);

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper())
    return randomfloatrange(2.0, 3.0);

  if(scripts\asm\asm_bb::bb_shootparams_idsmatch()) {
    if(self._blackboard.shootparams_fastburst) {
      if(isDefined(self._blackboard.shootparams_ent))
        return randomfloatrange(0.1, 0.35);
      else
        return randomfloatrange(0.6, 1.0);
    }

    if(isDefined(self._blackboard.shootparams_ent))
      return randomfloatrange(0.4, 0.9);
    else
      return randomfloatrange(0.8, 1.2);
  }

  return randomfloatrange(0.8, 1.2);
}