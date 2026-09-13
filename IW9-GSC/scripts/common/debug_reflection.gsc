/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\debug_reflection.gsc
***********************************************/

init_reflection_probe(_id_8FBD94C423B673EC) {}

spplayerconnect() {}

onplayerconnect() {
  if(isDefined(level.func_run_lean_threads) && [[level.func_run_lean_threads]]())
    return;
}

debug_reflection_probes() {}

create_reflection_object() {}

_id_DA5718B2A8BE7B0B() {}

debug_reflection_buttons() {}