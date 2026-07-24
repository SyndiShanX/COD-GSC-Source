/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\flashed.gsc
**************************************/

_id_9514() {}

_id_7FE4() {
  var_0 = "soldier";

  if(isDefined(self._id_1F62) && isDefined(anim._id_6EC0[self._id_1F62]))
    var_0 = self._id_1F62;

  anim._id_6EC0[var_0]++;

  if(anim._id_6EC0[var_0] >= anim.archetypes[var_0]["flashed"]["flashed"].size) {
    anim._id_6EC0[var_0] = 0;
    anim.archetypes[var_0]["flashed"]["flashed"] = scripts\engine\utility::array_randomize(anim.archetypes[var_0]["flashed"]["flashed"]);
  }

  return anim.archetypes[var_0]["flashed"]["flashed"][anim._id_6EC0[var_0]];
}

#using_animtree("generic_human");

_id_6EC1(var_0) {
  self endon("killanimscript");
  self _meth_82E3("flashed_anim", var_0, %body, 0.2, randomfloatrange(0.9, 1.1));
  scripts\anim\shared::donotetracks("flashed_anim");
}

main() {
  self endon("death");
  self endon("killanimscript");
  scripts\anim\utility::_id_9832("flashed");
  var_0 = scripts\sp\utility::_id_6EC3();

  if(var_0 <= 0) {
    return;
  }
  scripts\anim\face::saygenericdialogue("flashbang");

  if(isDefined(self._id_10959)) {
    self[[self._id_10959]]();
    return;
  }

  var_1 = _id_7FE4();
  _id_6EC2(var_1, var_0);
}

_id_6EC2(var_0, var_1) {
  self endon("death");
  self endon("killanimscript");

  if(self.a.pose == "prone")
    scripts\anim\utility::exitpronewrapper(1);

  self.a.pose = "stand";
  self.allowdeath = 1;
  thread _id_6EC1(var_0);
  wait(var_1);
  self notify("stop_flashbang_effect");
  self._id_6EC9 = 0;
}