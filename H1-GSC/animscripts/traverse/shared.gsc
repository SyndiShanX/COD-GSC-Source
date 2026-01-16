/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
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
  var_2.traverse_height = var_2.origin[2] + var_2.traverse_height_delta;
  var_3 = var_2.traverse_height - var_2.origin[2];
  thread teleportthread(var_3 - var_1);
  var_4 = 0.15;
  self clearanim( % body, var_4);
  self setflaggedanimknoballrestart("traverse", var_0, % animscript_root, 1, var_4, 1);
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

    if(!animhasnotetrack(var_0, "blend"))
      wait(var_5);
    else
      self waittillmatch("traverse", "blend");
  }
}

teleportthread(var_0) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  var_1 = 5;
  var_2 = (0, 0, var_0 / var_1);

  for (var_3 = 0; var_3 < var_1; var_3++) {
    self forceteleport(self.origin + var_2);
    wait 0.05;
  }
}

teleportthreadex(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");

  if(var_0 >= 0 || var_2 <= 0) {
    return;
  }
  if(var_1 > 0)
    wait(var_1);

  var_4 = (0, 0, var_0 / var_2);

  if(isdefined(var_3) && var_3 < 1.0)
    self setflaggedanimknoball("traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, var_3);

  for (var_5 = 0; var_5 < var_2; var_5++) {
    self forceteleport(self.origin + var_4);
    wait 0.05;
  }

  if(isdefined(var_3) && var_3 < 1.0)
    self setflaggedanimknoball("traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, 1.0);
}

dotraverse(var_0) {
  self endon("killanimscript");
  setdvarifuninitialized("scr_traverse_debug", 0);
  self notify("traverse_started");
  self.istraversing = 1;
  self.desired_anim_pose = "stand";
  animscripts\utility::updateanimpose();
  var_1 = self getnegotiationstartnode();

  if(isdefined(var_1.traverse_height_delta))
    var_1.traverse_height = var_1.origin[2] + var_1.traverse_height_delta;
  else
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
  var_5 = 0;

  if(isdefined(var_4) && isdefined(self.node) && self.node.type == var_0["coverType"] && distancesquared(self.node.origin, var_2.origin) < 625) {
    if(animscripts\utility::absangleclamp180(self.node.angles[1] - var_2.angles[1]) > 160) {
      var_5 = 1;
      var_3 = var_4;
    }
  }

  if(var_5) {
    if(isdefined(var_0["traverseToCoverSound"]))
      thread maps\_utility::play_sound_on_entity(var_0["traverseToCoverSound"]);
  } else if(isdefined(var_0["traverseSound"]))
    thread maps\_utility::play_sound_on_entity(var_0["traverseSound"]);

  self.traverseanim = var_3;

  if(!animhasnotetrack(var_3, "traverse_align"))
    handletraversealignment();

  if(isdefined(var_0["traverseBodyNode"]))
    self.traverseanimroot = var_0["traverseBodyNode"];
  else
    self.traverseanimroot = % body;

  self setflaggedanimknoballrestart("traverseAnim", var_3, self.traverseanimroot, 1, 0.2, 1);
  var_6 = ::handletraversenotetracks;

  if(isdefined(var_0["traverseNotetrackFunc"]))
    var_6 = var_0["traverseNotetrackFunc"];

  self.traversedeathindex = 0;
  self.traversedeathanim = var_0["interruptDeathAnim"];
  animscripts\shared::donotetracks("traverseAnim", var_6);
  self traversemode("gravity");

  if(self.delayeddeath) {
    return;
  }
  self.a.nodeath = 0;

  if(var_5 && isdefined(self.node) && distancesquared(self.origin, self.node.origin) < 256) {
    self.a.movement = "stop";
    self teleport(self.node.origin);
  } else if(isdefined(var_0["traverseStopsAtEnd"]))
    self.a.movement = "stop";
  else {
    self.a.movement = "run";
    self clearanim(var_3, 0.2);
  }

  self notify("traverse_finish");
  self.traverseanimroot = undefined;
  self.traverseanim = undefined;
  self.deathanim = undefined;
  self.traversestartnode = undefined;
  self.istraversing = undefined;
}

handletraversenotetracks(var_0) {
  if(var_0 == "traverse_death")
    return handletraversedeathnotetrack();
  else if(var_0 == "traverse_align")
    return handletraversealignment();
  else if(var_0 == "traverse_drop")
    return handletraversedrop();
}

handletraversedeathnotetrack() {
  if(isdefined(self.traversedeathanim)) {
    var_0 = self.traversedeathanim[self.traversedeathindex];
    self.deathanim = var_0[randomint(var_0.size)];
    self.traversedeathindex++;
  }
}

handletraversealignment() {
  self traversemode("nogravity");
  self traversemode("noclip");

  if(isdefined(self.traverseheight) && isdefined(self.traversestartnode.traverse_height)) {
    var_0 = self.traversestartnode.traverse_height - self.traversestartz;
    thread teleportthread(var_0 - self.traverseheight);
  }
}

handletraversedrop() {
  var_0 = self.origin + (0, 0, 32);
  var_1 = self getanimtime(self.traverseanim);
  var_2 = getanimlength(self.traverseanim);
  var_3 = var_1 * var_2;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = undefined;
  var_8 = 1.0;
  var_9 = getnotetracktimes(self.traverseanim, "land");

  if(var_9.size > 0) {
    var_10 = getnextlandingtime(var_1, var_9);
    var_8 = var_10;
    var_11 = getmovedelta(self.traverseanim, var_1, var_10);
    var_12 = (0, self.angles[1], 0);
    var_11 = rotatevector(var_11, var_12);
    var_7 = self.origin + var_11;
    var_4 = 0 - var_11[2];
    var_11 = (var_11[0], var_11[1], 0);
    var_0 = var_0 + var_11;
    var_5 = (var_10 - var_1) * var_2;
  } else {
    var_13 = getmovedelta(self.traverseanim, var_1, 1.0);
    var_12 = (0, self.angles[1], 0);
    var_13 = rotatevector(var_13, var_12);
    var_4 = 0 - var_13[2];
    var_7 = self.origin + var_13;
    var_14 = var_2 - var_3;
    var_5 = var_14 / 3.0;
  }

  var_15 = physicstrace(var_0, var_0 + (0, 0, -768));
  var_16 = distance(var_0, var_15);
  var_17 = var_16 - 32 - 0.5;
  var_18 = var_4 - var_17;

  if(var_4 < var_17)
    var_19 = var_4 / var_17;
  else
    var_19 = 1;

  var_6 = ceil(var_5 * 20);
  thread teleportthreadex(var_18, 0, var_6, var_19);
  thread finishtraversedrop(var_15[2], var_5, var_9.size, var_18);
}

getnextlandingtime(var_0, var_1) {
  for (var_2 = 0; var_2 < var_1.size - 1; var_2++) {
    for (var_3 = var_2 + 1; var_3 < var_1.size; var_3++) {
      if(var_1[var_3] < var_1[var_2]) {
        var_4 = var_1[var_3];
        var_1[var_3] = var_1[var_2];
        var_1[var_2] = var_4;
      }
    }
  }

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] > var_0)
      return var_1[var_2];
  }

  return var_1[var_1.size - 1];
}

finishtraversedrop(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");

  if(var_2 > 0) {
    var_4 = var_1;

    if(var_3 > 0)
      var_4 = var_4 - 0.1;

    if(var_4 < 0)
      var_4 = 0.0;

    wait(var_4);
    self traversemode("gravity");
  } else {
    var_0 = var_0 + 4.0;

    for (;;) {
      if(self.origin[2] < var_0) {
        self traversemode("gravity");
        break;
      }

      wait 0.05;
    }
  }
}

donothingfunc() {
  self animmode("zonly_physics");
  self waittill("killanimscript");
}

dovariablelengthtraverse(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("killanimscript");
  var_7 = 1;

  if(isdefined(self.moveplaybackrate))
    var_7 = self.moveplaybackrate;

  var_8 = self getnegotiationstartnode();
  var_9 = self.origin;

  if(isdefined(var_0)) {
    var_10 = getmovedelta(var_0, 0, 1);
    var_9 = transformpoint(var_10, var_8.origin, var_8.angles);
  }

  var_11 = self getnegotiationendnode();
  var_12 = var_11.origin;

  if(isdefined(var_2)) {
    var_13 = getmovedelta(var_2, 0, 1);
    var_12 = transformpoint(var_13 * -1, var_11.origin, var_11.angles);
    var_12 = var_12 + (0, 0, 1);
  }

  var_14 = getmovedelta(var_1, 0, 1);
  var_15 = length(var_14) * var_7 / getanimlength(var_1);
  var_16 = length(var_12 - var_9) / var_15;

  if(var_16 <= 0) {
    return;
  }
  self.istraversing = 1;
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();

  if(isdefined(var_3))
    self traversemode(var_3);
  else
    self traversemode("noclip");

  self.allowpain = 1;

  if(isdefined(var_6))
    var_17 = var_6;
  else
    var_17 = % body;

  self orientmode("face angle", var_8.angles[1]);

  if(isdefined(var_0)) {
    self setflaggedanimknoballrestart("traversal", var_0, var_17, 1, 0.1, var_7);
    animscripts\shared::donotetracks("traversal");
  }

  self setflaggedanimknoballrestart("traversal", var_1, var_17, 1, 0.1, var_7);
  animscripts\notetracks::donotetracksfortime(var_16, "traversal");

  if(isdefined(var_2)) {
    self setflaggedanimknoballrestart("traversal", var_2, var_17, 1, 0.1, var_7);
    animscripts\shared::donotetracks("traversal");
  }

  self traversemode("gravity");

  if(isdefined(var_4))
    self.a.pose = var_4;

  if(isdefined(var_5))
    self.a.movement = var_5;

  self.istraversing = undefined;
}

transformpoint(var_0, var_1, var_2) {
  var_3 = length(var_0);
  var_4 = vectortoangles(var_0);
  var_5 = combineangles(var_2, var_4);
  var_6 = anglestoforward(var_5);
  return var_1 + var_6 * var_3;
}

dog_handle_traverse_notetracks(var_0) {
  var_1 = undefined;
  var_2 = 0;
  var_3 = 0;

  if(var_0 == "traverse_jump_start") {
    var_2 = 1;
    var_4 = getnotetracktimes(self.traverseanim, "traverse_align");

    if(var_4.size > 0)
      var_1 = var_4;
    else {
      var_1 = getnotetracktimes(self.traverseanim, "traverse_jump_end");
      var_3 = 1;
    }
  } else if(var_0 == "gravity on") {
    var_2 = 1;
    var_1 = getnotetracktimes(self.traverseanim, "traverse_jump_end");
    var_3 = 1;
  }

  if(var_2) {
    var_5 = getnotetracktimes(self.traverseanim, var_0);
    var_6 = var_5[0];
    var_7 = getmovedelta(self.traverseanim, 0, var_5[0]);
    var_8 = var_7[2];
    var_7 = getmovedelta(self.traverseanim, 0, var_1[0]);
    var_9 = var_7[2];
    var_10 = var_1[0];
    var_11 = getanimlength(self.traverseanim);
    var_12 = int((var_10 - var_6) * var_11 * 30);
    var_13 = max(1, var_12 - 2);
    var_14 = var_9 - var_8;

    if(var_3) {
      var_7 = getmovedelta(self.traverseanim, 0, 1);
      var_15 = var_7[2] - var_9;
      var_16 = self.traverseendnode.origin[2] - self.origin[2] - var_15;
    } else {
      var_17 = self.traversestartnode;
      var_16 = var_17.traverse_height_delta - (self.origin[2] - var_17.origin[2]);
    }

    thread teleportthreadex(var_16 - var_14, 0, var_13);
    return 1;
  }
}

dog_traverse_cleanup_on_end() {
  self waittill("killanimscript");
  self.traversestartnode = undefined;
  self.traverseendnode = undefined;
}

#using_animtree("dog");

dog_wall_and_window_hop(var_0, var_1, var_2) {
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  thread dog_traverse_cleanup_on_end();
  var_3 = self getnegotiationstartnode();
  self orientmode("face angle", var_3.angles[1]);

  if(!isdefined(var_2)) {
    var_4 = var_3.traverse_height - var_3.origin[2];
    thread teleportthread(var_4 - var_1);
  }

  self.traverseanim = anim.dogtraverseanims[var_0];
  self.traversestartnode = var_3;
  self.traverseendnode = self getnegotiationendnode();
  self clearanim( % body, 0.2);
  self setflaggedanimrestart("dog_traverse", self.traverseanim, 1, 0.2, 1);
  self.moveanimtype = "land";
  animscripts\notetracks::donotetracksintercept("dog_traverse", ::dog_handle_traverse_notetracks);
  self.moveanimtype = undefined;
  self.traverseanim = undefined;
}

dog_jump_down(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self traversemode("noclip");
  thread dog_traverse_cleanup_on_end();
  var_4 = self getnegotiationstartnode();
  var_5 = self getnegotiationendnode();
  self orientmode("face angle", var_4.angles[1]);

  if(!isdefined(var_2))
    var_2 = "jump_down_40";

  self.traverseanim = anim.dogtraverseanims[var_2];
  self.traverseanimroot = % body;
  self.traversestartnode = var_4;
  self.traverseendnode = var_5;

  if(!isdefined(var_3))
    var_3 = 0;

  if(!var_3) {
    var_6 = var_4.origin[2] - var_5.origin[2];
    thread teleportthreadex(40.0 - var_6, 0.1, var_0, var_1);
  }

  self.moveanimtype = "land";
  self clearanim( % body, 0.2);
  self setflaggedanimrestart("traverseAnim", self.traverseanim, 1, 0.2, 1);

  if(!var_3)
    animscripts\shared::donotetracks("traverseAnim");
  else
    animscripts\notetracks::donotetracksintercept("traverseAnim", ::dog_handle_traverse_notetracks);

  self.moveanimtype = undefined;
  self traversemode("gravity");
  self.traverseanimroot = undefined;
  self.traverseanim = undefined;
}

dog_jump_up(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self traversemode("noclip");
  thread dog_traverse_cleanup_on_end();
  var_4 = self getnegotiationstartnode();
  self orientmode("face angle", var_4.angles[1]);

  if(!isdefined(var_2))
    var_2 = "jump_up_40";

  self.traverseanim = anim.dogtraverseanims[var_2];
  self.traverseanimroot = % body;
  self.traversestartnode = var_4;
  self.traverseendnode = self getnegotiationendnode();

  if(!isdefined(var_3))
    var_3 = 0;

  if(!var_3)
    thread teleportthreadex(var_0 - 40.0, 0.2, var_1);

  self.moveanimtype = "land";
  self clearanim( % body, 0.2);
  self setflaggedanimrestart("traverseAnim", self.traverseanim, 1, 0.2, 1);

  if(!var_3)
    animscripts\shared::donotetracks("traverseAnim");
  else
    animscripts\notetracks::donotetracksintercept("traverseAnim", ::dog_handle_traverse_notetracks);

  self.moveanimtype = undefined;
  self traversemode("gravity");
  self.traverseanim = undefined;
  self.traverseanimroot = undefined;
}

dog_long_jump(var_0, var_1) {
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  thread dog_traverse_cleanup_on_end();
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);

  if(!isdefined(var_2.traverse_height))
    var_2.traverse_height = var_2.origin[2];

  var_3 = var_2.traverse_height - var_2.origin[2];
  thread teleportthread(var_3 - var_1);
  self.moveanimtype = "land";
  self clearanim( % body, 0.2);
  self setflaggedanimknoballrestart("dog_traverse", anim.dogtraverseanims[var_0], 1, 0.2, 1);
  animscripts\shared::donotetracks("dog_traverse");
  self.moveanimtype = undefined;
}

getnextfootdown() {
  var_0 = (0, 0, 0);
  var_1 = (0, 0, 0);

  if(isdefined(self.mech) && self.mech) {
    var_1 = self gettagorigin("j2_ball_ri");
    var_0 = self gettagorigin("j2_ball_le");
  } else {
    var_1 = self gettagorigin("j_ball_ri");
    var_0 = self gettagorigin("j_ball_le");
  }

  if(!isdefined(var_1) || !isdefined(var_0))
    return "none";

  if(var_0[2] > var_1[2])
    return "Left";

  return "Right";
}