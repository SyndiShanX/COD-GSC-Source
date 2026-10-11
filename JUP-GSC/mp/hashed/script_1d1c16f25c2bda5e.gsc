/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1d1c16f25c2bda5e.gsc
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
  assertmsg("<dev string:x1c>");
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
  targettraverseheight = undefined;

  if(self.var_32a34987ee1b3095 == "nodeless" || self.var_32a34987ee1b3095 == "linkless") {
    targettraverseheight = self.var_64b933af90edc53c.traverse_height;
  } else {
    targettraverseheight = self.traversestartnode.traverse_height;
  }

  if(isDefined(self.traverseheight) && isDefined(targettraverseheight)) {
    currentheight = targettraverseheight - self.traversestartz;
    thread teleportthread(currentheight - self.traverseheight);
  }
}

function handletraversedrop() {
  startpos = self.origin + (0, 0, 32);
  endpos = physicstrace(startpos, self.origin + (0, 0, -512));
  dist = distance(startpos, endpos);
  realdropheight = dist - 32 - 0.5;
  traverseanimpos = self getanimtime(self.traverseanim);
  traverseanimdelta = getmovedelta(self.traverseanim, traverseanimpos, 1);
  traverseanimlength = getanimlength(self.traverseanim);
  animdropheight = 0 - traverseanimdelta[2];
  assertex(animdropheight >= 0, animdropheight);
  dropoffset = animdropheight - realdropheight;

  if(getdvarint(@ "hash_60bc1b675216e3d")) {
    thread scripts\anim\utility::debugline(startpos, endpos, (1, 1, 1), 40);
    thread scripts\anim\utility::drawstringtime("<dev string:x62>" + dropoffset, endpos, (1, 1, 1), 2);
  }

  if(animdropheight < realdropheight) {
    animrate = animdropheight / realdropheight;
  } else {
    animrate = 1;
  }

  teleportlength = (traverseanimlength - traverseanimpos) / 3;
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
  assertmsg("<dev string:x73>");
}

function seeker_traversal() {
  self waittill("killanimscript");
}