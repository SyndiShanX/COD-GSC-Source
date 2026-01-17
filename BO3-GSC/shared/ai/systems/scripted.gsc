/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\scripted.gsc
*************************************************/

#using_animtree("generic");
#namespace scripted;

function main() {
  self endon("death");
  self notify("killanimscript");
  self notify("clearsuppressionattack");
  self.codescripted["root"] = % generic::body;
  self endon("end_sequence");
  self.a.script = "scripted";
  self waittill("killanimscript");
}

function init(notifyname, origin, angles, theanim, animmode, root, rate, goaltime, lerptime) {}

function end_script() {
  if(isDefined(self.___archetypeonbehavecallback)) {
    [[self.___archetypeonbehavecallback]](self);
  }
}