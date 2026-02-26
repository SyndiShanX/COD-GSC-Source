/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\scripted.gsc
***********************************************/

#namespace scripted;

main() {
  self endon(#"death");
  self notify(#"killanimscript");
  self notify(#"clearsuppressionattack");
  self.codescripted[#"root"] = "body";
  self endon(#"end_sequence");
  self.a.script = "scripted";
  self waittill(#"killanimscript");
}

init(notifyname, origin, angles, theanim, animmode, root, rate, goaltime, lerptime) {}

end_script() {
  if(isDefined(self.___archetypeonbehavecallback)) {
    [[self.___archetypeonbehavecallback]](self);
  }
}