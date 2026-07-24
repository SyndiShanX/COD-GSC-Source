/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2581.gsc
**************************************/

setupdestructibledoors() {
  if(isDefined(self._id_4D5D))
    thread _id_4D5E();
}

_id_4D5F() {
  self endon("terminate_ai_threads");

  while(isalive(self)) {
    self waittill("damage_part_died", var_0);
    scripts\anim\utility_common::repeater_headshot_ammo_passive(self.damageweapon, self.lastattacker, self);

    if(self _meth_81B7()) {
      return;
    }
    if(isDefined(self._id_71A1)) {
      foreach(var_2 in var_0)
      self[[self._id_71A1]](var_2);
    }
  }
}

_id_4D60() {
  self endon("terminate_ai_threads");

  while(isalive(self)) {
    self waittill("damage_subpart_died", var_0);

    if(self _meth_81B7()) {
      return;
    }
    if(isDefined(self._id_719D)) {
      foreach(var_2 in var_0)
      self[[self._id_719D]](var_2);
    }
  }
}

_id_4D5E() {
  self endon("death");
  self endon("terminate_ai_threads");
  thread _id_4D60();
  thread _id_4D5F();
}

_id_9F3E(var_0) {
  if(scripts\asm\asm_bb::bb_isselfdestruct())
    return anim.success;

  return anim.failure;
}

isheadless(var_0) {
  if(scripts\asm\asm_bb::bb_isheadless())
    return anim.success;

  return anim.failure;
}