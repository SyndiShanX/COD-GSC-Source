/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\shared.gsc
*******************************************/

#include common_scripts\utility;
#include maps\_utility;
#include animscripts\debug;
#include animscripts\utility;
#include animscripts\run;
#include animscripts\shared;
#include animscripts\weaponlist;
#include animscripts\death;

init_traverse() {
  point = getent(self.target, "targetname");

  if(isDefined(point)) {
    self.traverse_height = point.origin[2];
    point delete();
  } else {
    point = getstruct(self.target, "targetname");

    if(isDefined(point))
      self.traverse_height = point.origin[2];
  }
}

teleportthread(verticaloffset) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  offset = (0, 0, verticaloffset / 5);

  for(i = 0; i < 5; i++) {
    self teleport(self.origin + offset);
    wait 0.05;
  }
}

teleportthreadex(verticaloffset, delay, frames) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");

  if(verticaloffset == 0) {
    return;
  }
  wait(delay);
  amount = verticaloffset / frames;

  if(amount > 10.0)
    amount = 10.0;
  else if(amount < -10.0)
    amount = -10.0;

  offset = (0, 0, amount);

  for(i = 0; i < frames; i++) {
    self teleport(self.origin + offset);
    wait 0.05;
  }
}

preparefortraverse() {
  self.a.prevpose = "stand";
  self.a.pose = "stand";
  movement = "move";

  if(isDefined(self.force_traversal_movement))
    movement = self.force_traversal_movement;

  return movement;
}

#using_animtree("generic_human");

dotraverse(traversedata) {
  self endon("killanimscript");
  self.a.script = "move";

  self animscripts\debug::debugclearstate();
  self animscripts\debug::debugpushstate(self.a.script);
  self animscripts\debug::debugpushstate("traverse");

  self.traverseanimissequence = isDefined(traversedata["traverseAnimType"]) && traversedata["traverseAnimType"] == "sequence";
  self.traverseanim = traversedata["traverseAnim"];
  self.traverseanimtransin = traversedata["traverseAnimTransIn"];
  self.traverseanimtransout = traversedata["traverseAnimTransOut"];
  self.traversesound = traversedata["traverseSound"];
  self.traversealertness = traversedata["traverseAlertness"];
  self.traversestance = traversedata["traverseStance"];
  self.traverseheight = traversedata["traverseHeight"];
  self.traversemovement = traversedata["traverseMovement"];
  self.traversetocoveranim = traversedata["traverseToCoverAnim"];
  self.traversetocoversound = traversedata["traverseToCoverSound"];
  self.traversedeathanim = traversedata["interruptDeathAnim"];
  self.traversedeathindex = 0;
  self.traverseallowaiming = 0;

  if(isDefined(traversedata["traverseAllowAiming"])) {
    self.traverseallowaiming = traversedata["traverseAllowAiming"];
    self.traverseaimanims = [];
    self.traverseaimanims["up"] = traversedata["traverseAimUp"];
    self.traverseaimanims["down"] = traversedata["traverseAimDown"];
    self.traverseaimanims["left"] = traversedata["traverseAimLeft"];
    self.traverseaimanims["right"] = traversedata["traverseAimRight"];
  }

  self.traverseragdolldeath = 0;

  if(isDefined(traversedata["traverseRagdollDeath"])) {
    self.traverseragdolldeath = traversedata["traverseRagdollDeath"];

    if(self.traverseragdolldeath)
      self traversestartragdolldeath();
  }

  self.traverseanimrate = 1.0;

  if(isDefined(traversedata["traverseAnimRate"]))
    self.traverseanimrate = traversedata["traverseAnimRate"];

  self traversemode("nogravity");
  self traversemode("noclip");

  if(!isDefined(self.traversestance))
    self.desired_anim_pose = "stand";
  else
    self.desired_anim_pose = self.traversestance;

  animscripts\utility::updateanimpose();
  self.traversestartnode = self getnegotiationstartnode();
  self.traverseendnode = self getnegotiationendnode();
  assert(isDefined(self.traversestartnode));
  assert(isDefined(self.traverseendnode));
  self orientmode("face angle", self.traversestartnode.angles[1]);
  self.traversestartz = self.origin[2];
  tocover = 0;

  if(isDefined(self.traversetocoveranim) && isDefined(self.node) && self.node.type == traversedata["coverType"] && distancesquared(self.node.origin, self.traverseendnode.origin) < 625) {
    if(absangleclamp180(self.node.angles[1] - self.traverseendnode.angles[1]) > 160) {
      tocover = 1;
      self.traverseanim = self.traversetocoveranim;
    }
  }

  if(isarray(self.traverseanim) && !self.traverseanimissequence)
    self.traverseanim = random(self.traverseanim);

  if(tocover) {
    if(isDefined(self.traversetocoversound))
      self thread play_sound_on_entity(self.traversetocoversound);
  } else if(isDefined(self.traversesound))
    self thread play_sound_on_entity(self.traversesound);

  self dotraverse_animation();
  self traversemode("gravity");

  if(self.traverseragdolldeath)
    self traversestopragdolldeath();

  if(self.delayeddeath) {
    self animscripts\debug::debugpopstate("traverse", "delayedDeath");

    return;
  }

  self.a.nodeath = 0;

  if(tocover && isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 256) {
    self.a.movement = "stop";
    self teleport(self.node.origin);
  } else {
    if(isDefined(self.traversemovement))
      self.a.movement = self.traversemovement;

    if(self.a.movement != "stop")
      self setanimknoballrestart(animscripts\run::getrunanim(), % body, 1, 0.2, 1);
  }

  self animscripts\debug::debugpopstate("traverse");

  waittillframeend;
  self.a.script = "traverse";
}

dotraverse_animation() {
  self.in_traversal = 1;
  traverseanim = self.traverseanim;

  if(!isarray(traverseanim))
    traverseanim = add_to_array(undefined, traverseanim);

  self clearanim( % body, 0.2);
  played_trans_in = 0;

  if(isDefined(self.traverseanimtransin)) {
    played_trans_in = 1;
    self thread domaintraverse_animationaiming(self.traverseanimtransin, "traverseAnim");
    self setflaggedanimknobrestart("traverseAnim", self.traverseanimtransin, 1, 0.2, self.traverseanimrate);

    if(traverseanim.size || isDefined(self.traverseanimtransout))
      self domaintraverse_notetracks("traverseAnim");
    else {
      self thread domaintraverse_notetracks("traverseAnim");
      wait_anim_length(self.traverseanimtransin, 0.2, self.traverseanimrate);
    }
  }

  first = 1;
  last = 1;

  for(i = 0; i < traverseanim.size; i++) {
    if(played_trans_in || i > 0)
      first = 0;

    if(i < traverseanim.size - 1)
      last = 0;

    domaintraverse_animation(traverseanim[i], first, last);
  }

  if(isDefined(self.traverseanimtransout)) {
    self setflaggedanimknobrestart("traverseAnim", self.traverseanimtransout, 1, 0, self.traverseanimrate);
    self thread domaintraverse_notetracks("traverseAnim");
    wait_anim_length(self.traverseanimtransout, 0.1, self.traverseanimrate);
  }

  self notify("traverseAnim", "end");
  self animscripts\shared::stoptracking();
  self animscripts\run::stopshootwhilemovingthreads();
  self animscripts\weaponlist::refillclip();
  self.in_traversal = undefined;
}

domaintraverse_animation(animation, first, last) {
  if(first) {
    self thread domaintraverse_animationaiming(animation, "traverseAnim");
    self setflaggedanimknobrestart("traverseAnim", animation, 1, 0.2, self.traverseanimrate);
  } else
    self setflaggedanimknobrestart("traverseAnim", animation, 1, 0, self.traverseanimrate);

  self thread traverseragdolldeath(animation);

  if(last && !isDefined(self.traverseanimtransout)) {
    self thread domaintraverse_notetracks("traverseAnim");
    wait_anim_length(animation, 0.2, self.traverseanimrate);
  } else
    self animscripts\shared::donotetracks("traverseAnim");
}

domaintraverse_animationaiming(animation, flag) {
  self endon("killanimscript");
  self endon("death");
  self endon("stop tracking");

  if(self.traverseallowaiming) {
    if(animhasnotetrack(animation, "start_aim"))
      self waittillmatch(flag, "start_aim");

    self.a.isaiming = 1;
    assert(isDefined(self.traverseaimanims));
    self setanimknoblimited(self.traverseaimanims["up"], 1, 0.2);
    self setanimknoblimited(self.traverseaimanims["down"], 1, 0.2);
    self setanimknoblimited(self.traverseaimanims["left"], 1, 0.2);
    self setanimknoblimited(self.traverseaimanims["right"], 1, 0.2);
    self.rightaimlimit = 50;
    self.leftaimlimit = -50;
    self.upaimlimit = 50;
    self.downaimlimit = -50;
    self animscripts\shared::setaiminganims( % traverse_aim_2, % traverse_aim_4, % traverse_aim_6, % traverse_aim_8);
    self animscripts\shared::trackloopstart();
    self animscripts\weaponlist::refillclip();
    self.shoot_while_moving_thread = undefined;
    self thread animscripts\run::runshootwhilemovingthreads();
  }
}

domaintraverse_notetracks(flagname) {
  self notify("stop_DoNotetracks");
  self endon("killanimscript");
  self endon("stop_DoNotetracks");
  self animscripts\shared::donotetracks(flagname, ::handletraversenotetracks);
}

wait_anim_length(animation, blend, rate) {
  len = getanimlength(animation) / rate - blend;

  if(len > 0)
    wait(len);
}

handletraversenotetracks(note) {
  if(note == "traverse_death")
    return handletraversedeathnotetrack();
}

handletraversedeathnotetrack() {
  self endon("killanimscript");

  if(self.delayeddeath) {
    self.a.nodeath = 1;
    self.exception["move"] = ::donothingfunc;
    self traversedeath();
    return true;
  }

  self.traversedeathindex++;
}

handletraversealignment() {
  self traversemode("nogravity");
  self traversemode("noclip");

  if(isDefined(self.traverseheight) && isDefined(self.traversestartnode.traverse_height)) {
    currentheight = self.traversestartnode.traverse_height - self.traversestartz;
    self thread teleportthread(currentheight - self.traverseheight);
  }
}

donothingfunc() {
  self animmode("zonly_physics");
  self waittill("killanimscript");
}

traversedeath() {
  self notify("traverse_death");

  if(!isDefined(self.triedtraverseragdoll))
    self animscripts\death::playdeathsound();

  deathanim = undefined;

  if(isDefined(self.traversedeathanim) && self.traversedeathanim.size > 0) {
    deathanimarray = self.traversedeathanim[self.traversedeathindex];
    deathanim = deathanimarray[randomint(deathanimarray.size)];
  }

  if(isDefined(deathanim))
    animscripts\death::play_death_anim(deathanim);
  else
    traversestartragdolldeath();

  self dodamage(self.health + 5, self.origin);
}

traversestartragdolldeath() {
  self.prevdelayeddeath = self.delayeddeath;
  self.prevallowdeath = self.allowdeath;
  self.prevdeathfunction = self.deathfunction;
  self.delayeddeath = 0;
  self.allowdeath = 1;
  self.deathfunction = ::traverseragdolldeathsimple;
}

traversestopragdolldeath() {
  self.delayeddeath = self.prevdelayeddeath;
  self.allowdeath = self.prevallowdeath;
  self.deathfunction = self.prevdeathfunction;
  self.prevdelayeddeath = undefined;
  self.prevallowdeath = undefined;
  self.prevdeathfunction = undefined;
}

traverseragdolldeathsimple() {
  assert(!is_true(self.magic_bullet_shield), "Cannot ragdoll death on guy with magic bullet shield.");
  self unlink();
  self startragdoll();
  self animscripts\shared::dropallaiweapons();
  return true;
}

traverseragdolldeath(traverseanim) {
  self notify("TraverseRagdollDeath");
  self endon("TraverseRagdollDeath");
  self endon("traverse_death");
  self endon("killanimscript");

  while(true) {
    self waittill("damage");

    if(!self.delayeddeath) {
      continue;
    }
    scripteddeathtimes = getnotetracktimes(traverseanim, "traverse_death");
    currenttime = self getanimtime(traverseanim);
    scripteddeathtimes[scripteddeathtimes.size] = 1.0;

    if(getdebugdvarint("scr_forcetraverseragdoll") == 1)
      scripteddeathtimes = [];

    for(i = 0; i < scripteddeathtimes.size; i++) {
      if(scripteddeathtimes[i] > currenttime) {
        animlength = getanimlength(traverseanim);
        timeuntilscripteddeath = (scripteddeathtimes[i] - currenttime) * animlength;

        if(timeuntilscripteddeath < 0.5) {
          return;
        }
        break;
      }
    }

    self.deathfunction = ::posttraversedeathanim;
    self.exception["move"] = ::donothingfunc;
    self ragdoll_death();
    self.a.triedtraverseragdoll = 1;
    break;
  }
}

posttraversedeathanim() {
  self endon("killanimscript");

  if(!isDefined(self)) {
    return;
  }
  deathanim = animscripts\death::get_death_anim();
  self setflaggedanimknoballrestart("deathanim", deathanim, % body, 1, 0.1);

  if(animhasnotetrack(deathanim, "death_neckgrab_spurt"))
    playfxontag(level._effects["death_neckgrab_spurt"], self, "j_neck");
}

#using_animtree("dog");

dog_wall_and_window_hop(traversename, height) {
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("face angle", startnode.angles[1]);

  if(isDefined(startnode.traverse_height)) {
    realheight = startnode.traverse_height - startnode.origin[2];
    self thread teleportthread(realheight - height);
  }

  self clearanim( % root, 0.2);
  self setflaggedanimrestart("dog_traverse", anim.dogtraverseanims[traversename], 1, 0.2, 1);
  self animscripts\shared::donotetracks("dog_traverse");
  self.traversecomplete = 1;
}

dog_jump_down(height, frames) {
  self endon("killanimscript");
  self traversemode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("face angle", startnode.angles[1]);
  self thread teleportthreadex(40.0 - height, 0.1, frames);
  self clearanim( % root, 0.2);
  self setflaggedanimrestart("traverse", anim.dogtraverseanims["jump_down_40"], 1, 0.2, 1);
  self animscripts\shared::donotetracks("traverse");
  self clearanim(anim.dogtraverseanims["jump_down_40"], 0);
  self traversemode("gravity");
  self.traversecomplete = 1;
}

dog_jump_up(height, frames) {
  self endon("killanimscript");
  self traversemode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("face angle", startnode.angles[1]);
  self thread teleportthreadex(height - 40.0, 0.2, frames);
  self clearanim( % root, 0.25);
  self setflaggedanimrestart("traverse", anim.dogtraverseanims["jump_up_40"], 1, 0.2, 1);
  self animscripts\shared::donotetracks("traverse");
  self clearanim(anim.dogtraverseanims["jump_up_40"], 0);
  self traversemode("gravity");
  self.traversecomplete = 1;
}