/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\scripted.gsc
**************************************/

#include animscripts\face;
#using_animtree("generic_human");

main() {
  self endon("death");
  self notify("killanimscript");
  self notify("clearSuppressionAttack");
  self.a.suppressingenemy = 0;
  self.codescripted["root"] = % body;
  self trackscriptstate("Scripted Main", "code");
  self endon("end_sequence");
  self startscriptedanim(self.codescripted["notifyName"], self.codescripted["origin"], self.codescripted["angles"], self.codescripted["anim"], self.codescripted["AnimMode"], self.codescripted["root"], self.codescripted["rate"], self.codescripted["goalTime"], self.codescripted["lerpTime"]);
  self.a.script = "scripted";
  self.codescripted = undefined;

  if(isDefined(self.scripted_dialogue) || isDefined(self.facial_animation)) {
    self animscripts\face::sayspecificdialogue(self.facial_animation, self.scripted_dialogue, 0.9, "scripted_anim_facedone");
    self.facial_animation = undefined;
    self.scripted_dialogue = undefined;
  }

  if(isDefined(self.deathstring_passed))
    self.deathstring = self.deathstring_passed;

  self waittill("killanimscript");
}

init(notifyname, origin, angles, theanim, animmode, root, rate, goaltime, lerptime) {
  self.codescripted["notifyName"] = notifyname;
  self.codescripted["origin"] = origin;
  self.codescripted["angles"] = angles;
  self.codescripted["anim"] = theanim;

  if(isDefined(animmode))
    self.codescripted["AnimMode"] = animmode;
  else
    self.codescripted["AnimMode"] = "normal";

  if(isDefined(root))
    self.codescripted["root"] = root;
  else
    self.codescripted["root"] = % body;

  self.codescripted["rate"] = rate;

  if(isDefined(goaltime))
    self.codescripted["goalTime"] = goaltime;
  else
    self.codescripted["goalTime"] = 0.2;

  if(isDefined(lerptime))
    self.codescripted["lerpTime"] = lerptime;
  else
    self.codescripted["lerpTime"] = 0.0;
}