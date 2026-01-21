/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\crawl.gsc
******************************************/

#using_animtree("generic_human");

main() {
  animscripts\setposemovement::pronerun_begin();
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self traversemode("noclip");
  var_0 = self getnegotiationstartnode();
  self orientmode("face angle", var_0.angles[1]);
  self setflaggedanimknoballrestart("crawlanim", %prone_crawl, %body, 1, 0.1, 1);
  animscripts\shared::donotetracks("crawlanim");
  self.a.movement = "run";
  self.a.pose = "crouch";
}