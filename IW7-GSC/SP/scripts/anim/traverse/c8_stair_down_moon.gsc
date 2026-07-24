/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\c8_stair_down_moon.gsc
********************************************************/

#using_animtree("c8");

main() {
  self endon("death");
  self endon("terminate_ai_threads");
  var_0 = % c8_grnd_org_traversals_moon_stair_down;
  var_1 = 0.2;
  self animmode("noclip");
  var_2 = self _meth_8148();
  self orientmode("face angle", var_2.angles[1]);
  self clearanim(_id_0A1E::asm_getbodyknob(), var_1);
  self _meth_82E7("traverse_external", var_0, 1, var_1, 1);
  _id_0A1E::_id_231F("c8", "traverse_external");
  _id_0C6B::_id_11701("c8", "traverse_external");
}