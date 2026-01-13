/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\combatrun_forward_72.gsc
**********************************************************/

main() {
  if(getdvarint("ai_iw7", 0) == 1) {
    self waittill("killanimscript");
    return;
  }

  self.var_5270 = "stand";
  scripts\anim\utility::func_12E5F();
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  var_0 = self getspectatepoint();
  self orientmode("face angle", var_0.angles[1]);
  self _meth_82E4("combatrun", % combatrun_forward, % body, 1, 0.1, 1);
  wait(0.45);
  self _meth_83C4("gravity");
}