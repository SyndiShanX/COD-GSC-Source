/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\iw6_jumpup_72.gsc
**************************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::dog_jump_up(72.0, 5);
  }
  else {
    low_wall_human();
  }
}

#using_animtree("generic_human");

low_wall_human() {
  var_0 = [];
  var_0["traverseAnim"] = % traverse_72_up_run;
  var_0["traverseHeight"] = 72.0;
  dotraversegravity(var_0);
}

dotraversegravity(var_0) {
  self endon("killanimscript");
  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  var_1 = self getnegotiationstartnode();
  var_1.traverse_height = var_1.origin[2] + var_1.traverse_height_delta;
  var_2 = self getnegotiationendnode();
  self orientmode("face angle", var_1.angles[1]);
  self.traverseheight = var_0["traverseHeight"];
  self.traversestartnode = var_1;
  var_3 = var_0["traverseAnim"];
  var_4 = var_0["traverseToCoverAnim"];
  self traversemode("gravity");
  self.traversestartz = self.origin[2];

  if(!animhasnotetrack(var_3, "traverse_align")) {
    animscripts\traverse\shared::handletraversealignment();
  }

  var_5 = 0;

  if(isDefined(var_4) && isDefined(self.node) && self.node.type == var_0["coverType"] && distancesquared(self.node.origin, var_2.origin) < 625) {
    if(animscripts\utility::absangleclamp180(self.node.angles[1] - var_2.angles[1]) > 160) {
      var_5 = 1;
      var_3 = var_4;
    }
  }

  if(var_5) {
    if(isDefined(var_0["traverseToCoverSound"])) {
      thread maps\_utility::play_sound_on_entity(var_0["traverseToCoverSound"]);
    }
  } else if(isDefined(var_0["traverseSound"]))
    thread maps\_utility::play_sound_on_entity(var_0["traverseSound"]);

  self.traverseanim = var_3;
  self.traverseanimroot = % body;
  self setflaggedanimknoballrestart("traverseAnim", var_3, % body, 1, 0.2, 1);
  self.traversedeathindex = 0;
  self.traversedeathanim = var_0["interruptDeathAnim"];
  animscripts\shared::donotetracks("traverseAnim", ::handletraversenotetracksgravity);
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

handletraversenotetracksgravity(var_0) {
  if(var_0 == "traverse_death") {
    return animscripts\traverse\shared::handletraversedeathnotetrack();
  }
  else if(var_0 == "traverse_align") {
    self.traversestartz = self.origin[2];
    return animscripts\traverse\shared::handletraversealignment();
  } else if(var_0 == "traverse_drop")
    return animscripts\traverse\shared::handletraversedrop();
}