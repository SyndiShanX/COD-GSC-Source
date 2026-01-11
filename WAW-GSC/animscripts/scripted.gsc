/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\scripted.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  self endon("death");
  self notify("killanimscript");
  self notify("clearSuppressionAttack");
  self.a.suppressingEnemy = false;
  self.codeScripted["root"] = % body;
  self trackScriptState("Scripted Main", "code");
  self endon("end_sequence");
  self startscriptedanim(self.codeScripted["notifyName"], self.codeScripted["origin"], self.codeScripted["angles"], self.codeScripted["anim"], self.codeScripted["animMode"], self.codeScripted["root"], self.codeScripted["rate"]);
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

init(notifyName, origin, angles, theAnim, animMode, root, rate) {
  self.codeScripted["notifyName"] = notifyName;
  self.codeScripted["origin"] = origin;
  self.codeScripted["angles"] = angles;
  self.codeScripted["anim"] = theAnim;
  if(isDefined(animMode)) {
    self.codeScripted["animMode"] = animMode;
  } else {
    self.codeScripted["animMode"] = "normal";
  }
  if(isDefined(root)) {
    self.codeScripted["root"] = root;
  } else {
    self.codeScripted["root"] = % body;
  }
  self.codeScripted["rate"] = rate;
}