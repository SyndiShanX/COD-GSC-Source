/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2581.gsc
************************/

setupdestructibledoors() {
  if(isDefined(self.var_4D5D)) {
    thread func_4D5E();
  }
}

func_4D5F() {
  self endon("terminate_ai_threads");
  while(isalive(self)) {
    self waittill("damage_part_died", var_0);
    scripts\anim\utility_common::repeater_headshot_ammo_passive(self.var_E2, self.sethalfresparticles, self);
    if(self _meth_81B7()) {
      return;
    }

    if(isDefined(self.var_71A1)) {
      foreach(var_2 in var_0) {
        self[[self.var_71A1]](var_2);
      }
    }
  }
}

func_4D60() {
  self endon("terminate_ai_threads");
  while(isalive(self)) {
    self waittill("damage_subpart_died", var_0);
    if(self _meth_81B7()) {
      return;
    }

    if(isDefined(self.var_719D)) {
      foreach(var_2 in var_0) {
        self[[self.var_719D]](var_2);
      }
    }
  }
}

func_4D5E() {
  self endon("death");
  self endon("terminate_ai_threads");
  thread func_4D60();
  thread func_4D5F();
}

func_9F3E(var_0) {
  if(scripts\asm\asm_bb::bb_isselfdestruct()) {
    return level.success;
  }

  return level.failure;
}

isheadless(var_0) {
  if(scripts\asm\asm_bb::bb_isheadless()) {
    return level.success;
  }

  return level.failure;
}