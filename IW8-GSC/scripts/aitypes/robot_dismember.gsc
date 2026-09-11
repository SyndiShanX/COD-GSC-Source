/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\robot_dismember.gsc
***********************************************/

function setupdestructibleparts() {
  if(isDefined(self.damageparts)) {
    thread damagepartshandler();
    return;
  }
}

function damagepartshandlerpart() {
  self endon("terminate_ai_threads");

  while(isalive(self)) {
    self waittill("damage_part_died", var_0);
    scripts\anim\utility_common::repeater_headshot_ammo_passive(self.damageweapon, self.lastattacker, self);

    if(self isragdoll()) {
      return;
    }

    if(isDefined(self.fndismembermenthandler)) {
      foreach(var_2 in var_0) {
        self[[self.fndismembermenthandler]](var_2);
      }
    }
  }
}

function damagepartshandlersubpart() {
  self endon("terminate_ai_threads");

  while(isalive(self)) {
    self waittill("damage_subpart_died", var_0);

    if(self isragdoll()) {
      return;
    }

    if(isDefined(self.fndamagesubparthandler)) {
      foreach(var_2 in var_0) {
        self[[self.fndamagesubparthandler]](var_2);
      }
    }
  }
}

function damagepartshandler() {
  self endon("death");
  self endon("terminate_ai_threads");
  thread damagepartshandlersubpart();
  thread damagepartshandlerpart();
}

function isselfdestruct(var_0) {
  if(scripts\asm\asm_bb::bb_isselfdestruct()) {
    return anim.success;
  }

  return anim.failure;
}

function isheadless(var_0) {
  if(scripts\asm\asm_bb::bb_isheadless()) {
    return anim.success;
  }

  return anim.failure;
}