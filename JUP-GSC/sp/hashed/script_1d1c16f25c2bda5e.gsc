/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1d1c16f25c2bda5e.gsc
*************************************************/

#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace shared;

function teleportthread(verticaloffset) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  reps = 5;
  offset = (0, 0, verticaloffset / reps);

  for(i = 0; i < reps; i++) {
    self forceteleport(self.origin + offset);
    wait 0.05;
  }
}

function teleportthreadex(verticaloffset, delay, frames, animrate) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");

  if(verticaloffset == 0 || frames <= 0) {
    return;
  }

  if(delay > 0) {
    wait delay;
  }

  offset = (0, 0, verticaloffset / frames);

  if(isDefined(animrate) && animrate < 1) {
    self setflaggedanimknoball("traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, animrate);
  }

  for(i = 0; i < frames; i++) {
    self forceteleport(self.origin + offset);
    wait 0.05;
  }

  if(isDefined(animrate) && animrate < 1) {
    self setflaggedanimknoball("traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, 1);
  }
}

function dotraverse(traversedata) {
  assertmsg("if you are hitting this, you are doing something dreadfully wrong.");
}

function handletraversenotetracks(note) {
  if(note == "traverse_death") {
    return handletraversedeathnotetrack();
  }

  if(note == "traverse_align") {
    return handletraversealignment();
  }

  if(note == "traverse_drop") {
    return handletraversedrop();
  }
}

function handletraversedeathnotetrack() {
  if(isDefined(self.traversedeathanim)) {
    deathanimarray = self.traversedeathanim[self.traversedeathindex];
    set_deathanim(deathanimarray[randomint(deathanimarray.size)]);
    self.traversedeathindex++;
  }
}

function handletraversealignment() {
  self animmode("noclip");
  var_256ca46d1effdd41 = undefined;

  if(self.var_32a34987ee1b3095 == "nodeless" || self.var_32a34987ee1b3095 == "linkless") {
    var_256ca46d1effdd41 = self.var_64b933af90edc53c.traverse_height;
  } else {
    var_256ca46d1effdd41 = self.traversestartnode.traverse_height;
  }

  if(isDefined(self.traverseheight) && isDefined(var_256ca46d1effdd41)) {
    currentheight = var_256ca46d1effdd41 - self.traversestartz;
    thread teleportthread(currentheight - self.traverseheight);
  }
}

function handletraversedrop() {
  startpos = self.origin + (0, 0, 32);
  endpos = physicstrace(startpos, self.origin + (0, 0, -512));
  dist = distance(startpos, endpos);
  var_e365c44cbf1472ab = dist - 32 - 0.5;
  var_9c41c6bce074794 = self getanimtime(self.traverseanim);
  var_472176e97aa175c8 = getmovedelta(self.traverseanim, var_9c41c6bce074794, 1);
  traverseanimlength = getanimlength(self.traverseanim);
  var_fb6f770a5d1925e = 0 - var_472176e97aa175c8[2];
  assertex(var_fb6f770a5d1925e >= 0, var_fb6f770a5d1925e);
  dropoffset = var_fb6f770a5d1925e - var_e365c44cbf1472ab;

  if(getdvarint(@ "hash_60bc1b675216e3d")) {
    thread scripts\anim\utility::debugline(startpos, endpos, (1, 1, 1), 40);
    thread scripts\anim\utility::drawstringtime("<dev string:x1c>" + dropoffset, endpos, (1, 1, 1), 2);
  }

  if(var_fb6f770a5d1925e < var_e365c44cbf1472ab) {
    animrate = var_fb6f770a5d1925e / var_e365c44cbf1472ab;
  } else {
    animrate = 1;
  }

  teleportlength = (traverseanimlength - var_9c41c6bce074794) / 3;
  numframes = ceil(teleportlength * 20);
  thread teleportthreadex(dropoffset, 0, numframes, animrate);
  thread finishtraversedrop(endpos[2]);
}

function finishtraversedrop(finalz) {
  self endon("killanimscript");
  finalz += 4;

  while(true) {
    if(self.origin[2] < finalz) {
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

function dog_jump_down(frames, rate, traversal_anim, var_5a11f5d9304a0c83) {
  assertmsg("if this is being called, something dreadfully wrong is happening.");
}

function seeker_traversal() {
  self waittill("killanimscript");
}