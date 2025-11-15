/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\c8_stair_up_moon.gsc
******************************************************/

main() {
  self endon("death");
  self endon("terminate_ai_threads");
  var_00 = % c8_grnd_org_traversals_moon_stair_up;
  var_01 = 0.2;
  self animmode("noclip");
  var_02 = self getspectatepoint();
  self orientmode("face angle", var_02.angles[1]);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_01);
  self _meth_82E7("traverse_external", var_00, 1, var_01, 1);
  lib_0A1E::func_231F("c8", "traverse_external");
  lib_0C6B::func_11701("c8", "traverse_external");
}