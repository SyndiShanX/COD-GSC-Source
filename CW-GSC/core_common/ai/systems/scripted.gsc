/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\scripted.gsc
***********************************************/

#namespace scripted;

function main() {
  self notify(#"killanimscript");
  self notify(#"clearsuppressionattack");
  self.codescripted[#"root"] = "body";
  self.a.script = "scripted";
}

function init(notifyname, origin, angles, theanim, animmode, root, rate, goaltime, lerptime) {}

function end_script() {
  if(isDefined(self.___archetypeonbehavecallback)) {
    [[self.___archetypeonbehavecallback]](self);
  }
}