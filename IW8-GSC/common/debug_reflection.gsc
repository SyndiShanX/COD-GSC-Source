/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\debug_reflection.gsc
***********************************************/

init_reflection_probe(var_0) {}

spplayerconnect() {}

onplayerconnect() {
  if(isDefined(level.func_run_lean_threads) && [[level.func_run_lean_threads]]())
    return;
}

debug_reflection_probes() {}

remove_reflection_objects() {}

create_reflection_objects() {}

create_reflection_object() {}

debug_reflection_buttons() {}