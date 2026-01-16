/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\scripted.gsc
********************************/

#using_animtree("generic_human");

main() {
  self endon("death");
  self notify("killanimscript");
  self notify("clearSuppressionAttack");
  self.a.suppressingenemy = 0;
  self.codescripted["root"] = % body;
  self endon("end_sequence");
  self startscriptedanim(self.codescripted["notifyName"], self.codescripted["origin"], self.codescripted["angles"], self.codescripted["anim"], self.codescripted["animMode"], self.codescripted["root"], self.codescripted["goalTime"]);
  self.codescripted = undefined;

  if(isdefined(self.scripted_dialogue) || isdefined(self.facial_animation)) {
    animscripts\face::sayspecificdialogue(self.facial_animation, self.scripted_dialogue, 0.9, "scripted_anim_facedone");
    self.facial_animation = undefined;
    self.scripted_dialogue = undefined;
  }

  if(isdefined(self.deathstring_passed))
    self.deathstring = self.deathstring_passed;

  self waittill("killanimscript");
}

init(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
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
    self.codescripted["root"] = % body;

  self.codescripted["goalTime"] = var_6;
}