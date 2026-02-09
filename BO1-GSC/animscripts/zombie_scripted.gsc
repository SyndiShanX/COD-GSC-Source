/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_scripted.gsc
*******************************************/

#using_animtree("generic_human");

main() {
  self endon("death");
  self notify("killanimscript");
  self.codeScripted["root"] = % body;
  self trackScriptState("Scripted Main", "code");
  self endon("end_sequence");
  self StartScriptedAnim(self.codeScripted["notifyName"], self.codeScripted["origin"], self.codeScripted["angles"], self.codeScripted["anim"], self.codeScripted["AnimMode"], self.codeScripted["root"], self.codeScripted["rate"], self.codeScripted["goalTime"]);
  self.a.script = "scripted";
  self.codeScripted = undefined;
  if(isDefined(self.scripted_dialogue) || isDefined(self.facial_animation)) {
    self animscripts\face::SaySpecificDialogue(self.facial_animation, self.scripted_dialogue, 0.9, "scripted_anim_facedone");
    self.facial_animation = undefined;
    self.scripted_dialogue = undefined;
  }
  if(isDefined(self.deathstring_passed)) {
    self.deathstring = self.deathstring_passed;
  }
  self waittill("killanimscript");
}
#using_animtree("generic_human");

init(notifyName, origin, angles, theAnim, AnimMode, root, rate, goalTime) {
  self.codeScripted["notifyName"] = notifyName;
  self.codeScripted["origin"] = origin;
  self.codeScripted["angles"] = angles;
  self.codeScripted["anim"] = theAnim;
  if(isDefined(AnimMode)) {
    self.codeScripted["AnimMode"] = AnimMode;
  } else {
    self.codeScripted["AnimMode"] = "normal";
  }
  if(isDefined(root)) {
    self.codeScripted["root"] = root;
  } else {
    self.codeScripted["root"] = % body;
  }
  self.codeScripted["rate"] = rate;
  if(isDefined(goalTime)) {
    self.codeScripted["goalTime"] = goalTime;
  } else {
    self.codeScripted["goalTime"] = 0.2;
  }
}