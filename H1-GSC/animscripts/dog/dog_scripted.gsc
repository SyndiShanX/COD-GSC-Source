/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\dog\dog_scripted.gsc
********************************************/

#using_animtree("dog");

main() {
  self endon("death");
  self notify("killanimscript");
  self.codescripted["root"] = % root;
  self endon("end_sequence");
  self startscriptedanim(self.codescripted["notifyName"], self.codescripted["origin"], self.codescripted["angles"], self.codescripted["anim"], self.codescripted["animMode"], self.codescripted["root"]);
  self.codescripted = undefined;

  if(isdefined(self.deathstring_passed))
    self.deathstring = self.deathstring_passed;

  self waittill("killanimscript");
}

init(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.codescripted["notifyName"] = var_0;
  self.codescripted["origin"] = var_1;
  self.codescripted["angles"] = var_2;
  self.codescripted["anim"] = var_3;

  if(isdefined(var_4))
    self.codescripted["animMode"] = var_4;
  else
    self.codescripted["animMode"] = "normal";

  if(isdefined(var_5))
    self.codescripted["root"] = var_5;
  else
    self.codescripted["root"] = % root;
}