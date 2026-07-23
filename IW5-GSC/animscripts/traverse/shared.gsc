/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\shared.gsc
*******************************************/

#using_animtree("generic_human");

advancedtraverse(var_0, var_1) {
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);
  var_3 = var_2.traverse_height - var_2.origin[2];
  thread teleportthread(var_3 - var_1);
  var_4 = 0.15;
  self clearanim(%body, var_4);
  self setflaggedanimknoballrestart("traverse", var_0, %root, 1, var_4, 1);
  var_5 = 0.2;
  var_6 = 0.2;
  thread animscripts\notetracks::donotetracksforever("traverse", "no clear");

  if(!animhasnotetrack(var_0, "gravity on")) {
    var_7 = 1.23;
    wait(var_7 - var_5);
    self traversemode("gravity");
    wait(var_5);
  } else {
    self waittillmatch("traverse", "gravity on");
    self traversemode("gravity");

    if(!animhasnotetrack(var_0, "blend")) {
      wait(var_5);
    } else {
      self waittillmatch("traverse", "blend");
    }
  }
}

teleportthread(var_0) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  var_1 = 5;
  var_2 = (0, 0, var_0 / var_1);

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self forceteleport(self.origin + var_2);
    wait 0.05;
  }
}

teleportthreadex(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");

  if(var_0 == 0 || var_2 <= 0) {
    return;
  }
  if(var_1 > 0) {
    wait(var_1);
  }
  var_4 = (0, 0, var_0 / var_2);

  if(isDefined(var_3) && var_3 < 1.0) {
    self setflaggedanimknoball("traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, var_3);
  }
  for(var_5 = 0; var_5 < var_2; var_5++) {
    self forceteleport(self.origin + var_4);
    wait 0.05;
  }

  if(isDefined(var_3) && var_3 < 1.0) {
    self setflaggedanimknoball("traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, 1.0);
  }
}

dotraverse(var_0) {
  self endon("killanimscript");
  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  var_1 = self getnegotiationstartnode();
  var_2 = self getnegotiationendnode();
  self orientmode("face angle", var_1.angles[1]);
  self.traverseheight = var_0["traverseHeight"];
  self.traversestartnode = var_1;
  var_3 = var_0["traverseAnim"];
  var_4 = var_0["traverseToCoverAnim"];
  self traversemode("nogravity");
  self traversemode("noclip");
  self.traversestartz = self.origin[2];

  if(!animhasnotetrack(var_3, "traverse_align")) {
    handletraversealignment();
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
  } else if(isDefined(var_0["traverseSound"])) {
    thread maps\_utility::play_sound_on_entity(var_0["traverseSound"]);
  }
  self.traverseanim = var_3;
  self.traverseanimroot = % body;
  self setflaggedanimknoballrestart("traverseAnim", var_3, %body, 1, 0.2, 1);
  self.traversedeathindex = 0;
  self.traversedeathanim = var_0["interruptDeathAnim"];
  animscripts\shared::donotetracks("traverseAnim", ::handletraversenotetracks);
  self traversemode("gravity");

  if(self.delayeddeath) {
    return;
  }
  self.a.nodeath = 0;

  if(var_5 && isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 256) {
    self.a.movement = "stop";
    self teleport(self.node.origin);
  } else if(isDefined(var_0["traverseStopsAtEnd"])) {
    self.a.movement = "stop";
  } else {
    self.a.movement = "run";
    self clearanim(var_3, 0.2);
  }

  self.traverseanimroot = undefined;
  self.traverseanim = undefined;
  self.deathanim = undefined;
}

handletraversenotetracks(var_0) {
  if(var_0 == "traverse_death") {
    return handletraversedeathnotetrack();
  } else if(var_0 == "traverse_align") {
    return handletraversealignment();
  } else if(var_0 == "traverse_drop") {
    return handletraversedrop();
  }
}

handletraversedeathnotetrack() {
  if(isDefined(self.traversedeathanim)) {
    var_0 = self.traversedeathanim[self.traversedeathindex];
    self.deathanim = var_0[randomint(var_0.size)];
    self.traversedeathindex++;
  }
}

handletraversealignment() {
  self traversemode("nogravity");
  self traversemode("noclip");

  if(isDefined(self.traverseheight) && isDefined(self.traversestartnode.traverse_height)) {
    var_0 = self.traversestartnode.traverse_height - self.traversestartz;
    thread teleportthread(var_0 - self.traverseheight);
  }
}

handletraversedrop() {
  var_0 = self.origin + (0, 0, 32);
  var_1 = bulletTrace(var_0, self.origin + (0, 0, -512), 0, undefined);
  var_2 = var_1["position"];
  var_3 = distance(var_0, var_2);
  var_4 = var_3 - 32 - 0.5;
  var_5 = self getanimtime(self.traverseanim);
  var_6 = getmovedelta(self.traverseanim, var_5, 1.0);
  var_7 = getanimlength(self.traverseanim);
  var_8 = 0 - var_6[2];
  var_9 = var_8 - var_4;

  if(var_8 < var_4) {
    var_10 = var_8 / var_4;
  } else {
    var_10 = 1;
  }
  var_11 = (var_7 - var_5) / 3.0;
  var_12 = ceil(var_11 * 20);
  thread teleportthreadex(var_9, 0, var_12, var_10);
  thread finishtraversedrop(var_2[2]);
}

finishtraversedrop(var_0) {
  self endon("killanimscript");
  var_0 = var_0 + 4.0;

  for(;;) {
    if(self.origin[2] < var_0) {
      self traversemode("gravity");
      break;
    }

    wait 0.05;
  }
}

donothingfunc() {
  self animmode("zonly_physics");
  self waittill("killanimscript");
}

#using_animtree("dog");

dog_wall_and_window_hop(var_0, var_1) {
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);
  var_3 = var_2.traverse_height - var_2.origin[2];
  thread teleportthread(var_3 - var_1);
  self clearanim(%root, 0.2);
  self setflaggedanimrestart("dog_traverse", anim.dogtraverseanims[var_0], 1, 0.2, 1);
  animscripts\shared::donotetracks("dog_traverse");
  self.traversecomplete = 1;
}

dog_jump_down(var_0, var_1) {
  self endon("killanimscript");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);
  var_3 = self getnegotiationstartnode().origin[2] - self getnegotiationendnode().origin[2];
  self.traverseanim = anim.dogtraverseanims["jump_down_40"];
  self.traverseanimroot = % root;
  thread teleportthreadex(40.0 - var_3, 0.1, var_0, var_1);
  self clearanim(%root, 0.2);
  self setflaggedanimrestart("traverseAnim", self.traverseanim, 1, 0.2, 1);
  animscripts\shared::donotetracks("traverseAnim");
  self clearanim(self.traverseanim, 0);
  self traversemode("gravity");
  self.traversecomplete = 1;
  self.traverseanimroot = undefined;
  self.traverseanim = undefined;
}

dog_jump_up(var_0, var_1) {
  self endon("killanimscript");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);
  thread teleportthreadex(var_0 - 40.0, 0.2, var_1);
  self clearanim(%root, 0.25);
  self setflaggedanimrestart("traverseAnim", anim.dogtraverseanims["jump_up_40"], 1, 0.2, 1);
  animscripts\shared::donotetracks("traverseAnim");
  self clearanim(anim.dogtraverseanims["jump_up_40"], 0);
  self traversemode("gravity");
  self.traversecomplete = 1;
}

dog_long_jump(var_0, var_1) {
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);

  if(!isDefined(var_2.traverse_height)) {
    var_2.traverse_height = var_2.origin[2];
  }
  var_3 = var_2.traverse_height - var_2.origin[2];
  thread teleportthread(var_3 - var_1);
  self clearanim(%root, 0.2);
  self setflaggedanimrestart("dog_traverse", anim.dogtraverseanims[var_0], 1, 0.2, 1);
  animscripts\shared::donotetracks("dog_traverse");
  self.traversecomplete = 1;
}