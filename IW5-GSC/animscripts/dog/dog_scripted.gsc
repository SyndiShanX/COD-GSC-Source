/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_scripted.gsc
********************************************/

#using_animtree("dog");

main() {
  self endon("death");
  self notify("killanimscript");
  self._id_3B66["root"] = % root;
  self endon("end_sequence");
  self startscriptedanim(self._id_3B66["notifyName"], self._id_3B66["origin"], self._id_3B66["angles"], self._id_3B66["anim"], self._id_3B66["animMode"], self._id_3B66["root"]);
  self._id_3B66 = undefined;

  if(isDefined(self._id_3B67)) {
    self._id_3B68 = self._id_3B67;
  }
  self waittill("killanimscript");
}

init(var_0, var_1, var_2, var_3, var_4, var_5) {
  self._id_3B66["notifyName"] = var_0;
  self._id_3B66["origin"] = var_1;
  self._id_3B66["angles"] = var_2;
  self._id_3B66["anim"] = var_3;

  if(isDefined(var_4)) {
    self._id_3B66["animMode"] = var_4;
  } else {
    self._id_3B66["animMode"] = "normal";
  }
  if(isDefined(var_5)) {
    self._id_3B66["root"] = var_5;
  } else {
    self._id_3B66["root"] = % root;
  }
}