/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\traverse\shared.gsc
***********************************************/

function teleportthread(var0) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  var1 = 5;
  var2 = (0, 0, var0 / var1);

  for(var3 = 0; var3 < var1; var3++) {
    self forceteleport(self.origin + var2);
    wait 0.05;
  }
}

function teleportthreadex(var0, var1, var2, var3) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");

  if(var0 == 0 || var2 <= 0) {
    return;
  }

  if(var1 > 0) {
    wait var1;
  }

  var4 = (0, 0, var0 / var2);

  if(isDefined(var3) && var3 < 1) {
    self setflaggedanimknoball("traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, var3);
  }

  for(var5 = 0; var5 < var2; var5++) {
    self forceteleport(self.origin + var4);
    wait 0.05;
  }

  if(isDefined(var3) && var3 < 1) {
    self setflaggedanimknoball("traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, 1);
    return;
  }
}

function dotraverse(var0) {}

function handletraversenotetracks(var0) {
  if(var0 == "traverse_death") {
    return handletraversedeathnotetrack();
  }

  if(var0 == "traverse_align") {
    return handletraversealignment();
  }

  if(var0 == "traverse_drop") {
    return handletraversedrop();
  }
}

function handletraversedeathnotetrack() {
  if(isDefined(self.traversedeathanim)) {
    var0 = self.traversedeathanim[self.traversedeathindex];
    self.deathanim = var0[randomint(var0.size)];
    self.traversedeathindex++;
    return;
  }
}

function handletraversealignment() {
  self animmode("noclip");

  if(isDefined(self.traverseheight) && isDefined(self.traversestartnode.traverse_height)) {
    var0 = self.traversestartnode.traverse_height - self.traversestartz;
    thread teleportthread(var0 - self.traverseheight);
    return;
  }
}

function handletraversedrop() {
  var0 = self.origin + (0, 0, 32);
  var1 = physicstrace(var0, self.origin + (0, 0, -512));
  var2 = distance(var0, var1);
  var3 = var2 - 32 - 0.5;
  var4 = self getanimtime(self.traverseanim);
  var5 = getmovedelta(self.traverseanim, var4, 1);
  var6 = getanimlength(self.traverseanim);
  var7 = 0 - var5[2];
  var8 = var7 - var3;

  if(var7 < var3) {
    var9 = var7 / var3;
  } else {
    var9 = 1;
  }

  var10 = (var7 - var5) / 3;
  var11 = ceil(var10 * 20);
  thread teleportthreadex(var9, 0, var11, var9);
  thread finishtraversedrop(var2[2]);
}

function finishtraversedrop(var0) {
  self endon("killanimscript");
  var0 += 4;

  for(;;) {
    if(self.origin[2] < var0) {
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

function dog_jump_down(var0, var1, var2, var3) {}

function seeker_traversal() {
  self waittill("killanimscript");
}