/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_dog_scripted.gsc
***********************************************/

#using_animtree("zombie_dog");
main() {
  self endon("death");
  self notify("killanimscript");
  self.codeScripted["root"] = % root;
  self trackScriptState("Scripted Main", "code");
  self endon("end_sequence");
  self StartScriptedAnim(self.codeScripted["notifyName"], self.codeScripted["origin"], self.codeScripted["angles"], self.codeScripted["anim"], self.codeScripted["AnimMode"], self.codeScripted["root"], self.codeScripted["goalTime"]);
  self.a.script = "scripted";
  self.codeScripted = undefined;
  if(isDefined(self.deathstring_passed)) {
    self.deathstring = self.deathstring_passed;
  }
  self waittill("killanimscript");
}
init(notifyName, origin, angles, theAnim, AnimMode, root, goalTime) {
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
    self.codeScripted["root"] = % root;
  }
  if(isDefined(goalTime)) {
    self.codeScripted["goalTime"] = goalTime;
  }
}