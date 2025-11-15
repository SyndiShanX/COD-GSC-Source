/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\bigdog\bigdog_scripted.gsc
**************************************************/

#using_animtree("bigdog");

main() {
  self endon("death");
  self notify("killanimscript");
  waittillframeend;
  self.codescripted["root"] = % root;
  self trackscriptstate("Scripted Main", "code");
  self endon("end_sequence");
  self startscriptedanim(self.codescripted["notifyName"], self.codescripted["origin"], self.codescripted["angles"], self.codescripted["anim"], self.codescripted["AnimMode"], self.codescripted["root"], self.codescripted["rate"], self.codescripted["goalTime"]);
  self.a.script = "scripted";
  self.codescripted = undefined;

  if(isDefined(self.deathstring_passed))
    self.deathstring = self.deathstring_passed;

  self waittill("killanimscript");
}

init(notifyname, origin, angles, theanim, animmode, root) {
  self.codescripted["notifyName"] = notifyname;
  self.codescripted["origin"] = origin;
  self.codescripted["angles"] = angles;
  self.codescripted["anim"] = theanim;

  if(isDefined(animmode))
    self.codescripted["animMode"] = animmode;
  else
    self.codescripted["animMode"] = "normal";

  if(isDefined(root))
    self.codescripted["root"] = root;
  else
    self.codescripted["root"] = % root;
}