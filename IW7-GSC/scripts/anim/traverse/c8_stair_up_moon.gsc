/******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\traverse\c8_stair_up_moon.gsc
******************************************************/

main() {
  self endon("death");
  self endon("terminate_ai_threads");
  var_0 = % c8_grnd_org_traversals_moon_stair_up;
  var_1 = 0.2;
  self animmode("noclip");
  var_2 = self getspectatepoint();
  self orientmode("face angle", var_2.angles[1]);
  self clearanim(lib_0A1E::asm_getbodyknob(), var_1);
  self _meth_82E7("traverse_external", var_0, 1, var_1, 1);
  lib_0A1E::func_231F("c8", "traverse_external");
  lib_0C6B::func_11701("c8", "traverse_external");
}