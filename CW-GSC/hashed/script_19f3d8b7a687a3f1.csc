/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_19f3d8b7a687a3f1.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#namespace namespace_52c8f34d;

function preinit() {
  if(isDefined(level.var_6b33db60)) {
    return;
  }

  level.var_6b33db60 = 1;
  level clientfield::register("scriptmover", "item_machine_spawn_rob", 1, 1, "int", &function_c30c297c, 0, 0);
}

function function_c30c297c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    self playrenderoverridebundle(#"hash_1528dae63f55fcde");
    playSound(bwastimejump, #"hash_20c4f0485930af2a", self.origin + (0, 0, 35));
  }
}