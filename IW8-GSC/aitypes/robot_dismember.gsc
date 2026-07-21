/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\robot_dismember.gsc
***********************************************/

setupdestructibleparts() {
  if(isDefined(self.damageparts))
    thread damagepartshandler();
}

damagepartshandlerpart() {
  self endon("terminate_ai_threads");

  while(isalive(self)) {
    self waittill("damage_part_died", var_0);
    scripts\anim\utility_common.gsc::repeater_headshot_ammo_passive(self.damageweapon, self.lastattacker, self);

    if(self isragdoll()) {
      return;
    }
    if(isDefined(self.fndismembermenthandler)) {
      foreach(var_2 in var_0)
      self[[self.fndismembermenthandler]](var_2);
    }
  }
}

damagepartshandlersubpart() {
  self endon("terminate_ai_threads");

  while(isalive(self)) {
    self waittill("damage_subpart_died", var_0);

    if(self isragdoll()) {
      return;
    }
    if(isDefined(self.fndamagesubparthandler)) {
      foreach(var_2 in var_0)
      self[[self.fndamagesubparthandler]](var_2);
    }
  }
}

damagepartshandler() {
  self endon("death");
  self endon("terminate_ai_threads");
  thread damagepartshandlersubpart();
  thread damagepartshandlerpart();
}

isselfdestruct(var_0) {
  if(scripts\asm\asm_bb::bb_isselfdestruct())
    return anim.success;

  return anim.failure;
}

isheadless(var_0) {
  if(scripts\asm\asm_bb::bb_isheadless())
    return anim.success;

  return anim.failure;
}