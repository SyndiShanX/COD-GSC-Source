/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\traverse\shared.gsc
***********************************************/

function teleportthread(var_0) {
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

function teleportthreadex(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");

  if(var_0 == 0 || var_2 <= 0) {
    return;
  }

  if(var_1 > 0) {
    wait var_1;
  }

  var_4 = (0, 0, var_0 / var_2);

  if(isDefined(var_3) && var_3 < 1) {
    self setflaggedanimknoball("traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, var_3);
  }

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self forceteleport(self.origin + var_4);
    wait 0.05;
  }

  if(isDefined(var_3) && var_3 < 1) {
    self setflaggedanimknoball("traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, 1);
    return;
  }
}

function dotraverse(var_0) {}

function handletraversenotetracks(var_0) {
  if(var_0 == "traverse_death") {
    return handletraversedeathnotetrack();
  }

  if(var_0 == "traverse_align") {
    return handletraversealignment();
  }

  if(var_0 == "traverse_drop") {
    return handletraversedrop();
  }
}

function handletraversedeathnotetrack() {
  if(isDefined(self.traversedeathanim)) {
    var_0 = self.traversedeathanim[self.traversedeathindex];
    self.deathanim = var_0[randomint(var_0.size)];
    self.traversedeathindex++;
    return;
  }
}

function handletraversealignment() {
  self animmode("noclip");

  if(isDefined(self.traverseheight) && isDefined(self.traversestartnode.traverse_height)) {
    var_0 = self.traversestartnode.traverse_height - self.traversestartz;
    thread teleportthread(var_0 - self.traverseheight);
    return;
  }
}

function handletraversedrop() {
  var_0 = self.origin + (0, 0, 32);
  var_1 = physicstrace(var_0, self.origin + (0, 0, -512));
  var_2 = distance(var_0, var_1);
  var_3 = var_2 - 32 - 0.5;
  var_4 = self getanimtime(self.traverseanim);
  var_5 = getmovedelta(self.traverseanim, var_4, 1);
  var_6 = getanimlength(self.traverseanim);
  var_7 = 0 - var_5[2];
  var_8 = var_7 - var_3;

  if(var_7 < var_3) {
    var_9 = var_7 / var_3;
  } else {
    var_9 = 1;
  }

  var_10 = (var_7 - var_5) / 3;
  var_11 = ceil(var_10 * 20);
  thread teleportthreadex(var_9, 0, var_11, var_9);
  thread finishtraversedrop(var_2[2]);
}

function finishtraversedrop(var_0) {
  self endon("killanimscript");
  var_0 += 4;

  for(;;) {
    if(self.origin[2] < var_0) {
      self animmode("gravity");
      break;
    }

    wait 0.05;
  }
}

function donothingfunc() {
  self animmode("zonly_physics");
  self waittill("killanimscript");
}

function dog_jump_down(var_0, var_1, var_2, var_3) {}

function seeker_traversal() {
  self waittill("killanimscript");
}