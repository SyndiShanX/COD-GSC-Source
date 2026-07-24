/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\slide_across_car.gsc
******************************************************/

main() {
  if(self.type == "dog")
    _id_102DE();
  else
    _id_102DF();
}

#using_animtree("generic_human");

_id_102DF() {
  var_0 = [];
  var_0["traverseAnim"] = % slide_across_car;

  if(getdvarint("ai_iw7", 0) == 0)
    scripts\anim\traverse\shared::_id_5AC3(var_0);
  else
    self waittill("killanimscript");
}

#using_animtree("dog");

_id_102DE() {
  self endon("killanimscript");
  self _meth_83C4("noclip");
  var_0 = self _meth_8148();
  self orientmode("face angle", var_0.angles[1]);
  self clearanim(%root, 0.1);
  self _meth_82EA("traverse", anim._id_58C7["jump_up_40"], 1, 0.1, 1);
  scripts\anim\shared::donotetracks("traverse");
  playworldsound("anml_dog_bark", self gettagorigin("tag_eye"));
  self clearanim(%root, 0);
  self _meth_82EA("traverse", anim._id_58C7["jump_down_40"], 1, 0, 1);
  scripts\anim\shared::donotetracks("traverse");
  self _meth_83C4("gravity");
}