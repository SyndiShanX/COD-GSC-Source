/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\platform_off.gsc
*************************************************/

#using_animtree("generic_human");

main() {
  var_0 = [];
  var_0["traverseAnim"] = % creepwalk_to_cqb_run_iw6;
  dotraverse_custom(var_0);
}

dotraverse_custom(var_0) {
  self endon("killanimscript");
  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  var_1 = self getnegotiationstartnode();
  var_1.traverse_height = var_1.origin[2];
  var_2 = self getnegotiationendnode();
  self orientmode("face angle", var_1.angles[1]);
  self.traverseheight = var_0["traverseHeight"];
  self.traversestartnode = var_1;
  var_3 = var_0["traverseAnim"];
  var_4 = var_0["traverseToCoverAnim"];
  self traversemode("nogravity");
  self traversemode("noclip");
  self.traversestartz = self.origin[2];

  if(!animhasnotetrack(var_3, "traverse_align"))
    animscripts\traverse\shared::handletraversealignment();

  var_5 = 0;

  if(isDefined(var_4) && isDefined(self.node) && self.node.type == var_0["coverType"] && distancesquared(self.node.origin, var_2.origin) < 625) {
    if(animscripts\utility::absangleclamp180(self.node.angles[1] - var_2.angles[1]) > 160) {
      var_5 = 1;
      var_3 = var_4;
    }
  }

  self.traverseanim = var_3;
  self.traverseanimroot = % body;
  self setflaggedanimknoballrestart("traverseAnim", var_3, % body, 1, 0.2, 1);
  self.traversedeathindex = 0;
  self.traversedeathanim = var_0["interruptDeathAnim"];
  animscripts\shared::donotetracks("traverseAnim", animscripts\traverse\shared::handletraversenotetracks);
  self traversemode("gravity");

  if(self.delayeddeath) {
    return;
  }
  self.a.nodeath = 0;

  if(var_5 && isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 256) {
    self.a.movement = "stop";
    self teleport(self.node.origin);
  } else if(isDefined(var_0["traverseStopsAtEnd"]))
    self.a.movement = "stop";
  else {
    self.a.movement = "run";
    self clearanim(var_3, 0.2);
  }

  self.traverseanimroot = undefined;
  self.traverseanim = undefined;
  self.deathanim = undefined;
}