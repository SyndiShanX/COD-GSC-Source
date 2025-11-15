/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\setposemovement.gsc
*******************************************/

#include animscripts\utility;
#include animscripts\anims;
#include maps\_utility;
#include common_scripts\utility;
#include animscripts\debug;
#include animscripts\run;
#include animscripts\cqb;
#include animscripts\move;
#include animscripts\cover_prone;
#include animscripts\shared;

setposemovement(desiredpose, desiredmovement) {
  self animscripts\debug::debugpushstate("SetPoseMovement: " + desiredpose + " - " + desiredmovement);

  if(desiredpose == "") {
    if(self.a.pose == "prone" && (desiredmovement == "walk" || desiredmovement == "run"))
      desiredpose = "crouch";
    else
      desiredpose = self.a.pose;
  }

  if(!isDefined(desiredmovement) || desiredmovement == "")
    desiredmovement = self.a.movement;

  [[anim.setposemovementfnarray[desiredpose][desiredmovement]]]();

  self animscripts\debug::debugpopstate("SetPoseMovement: " + desiredpose + " - " + desiredmovement);
}

initposemovementfunctions() {
  anim.setposemovementfnarray["stand"]["stop"] = ::beginstandstop;
  anim.setposemovementfnarray["stand"]["walk"] = ::beginstandwalk;
  anim.setposemovementfnarray["stand"]["run"] = ::beginstandrun;
  anim.setposemovementfnarray["crouch"]["stop"] = ::begincrouchstop;
  anim.setposemovementfnarray["crouch"]["walk"] = ::begincrouchwalk;
  anim.setposemovementfnarray["crouch"]["run"] = ::begincrouchrun;
  anim.setposemovementfnarray["prone"]["stop"] = ::beginpronestop;
  anim.setposemovementfnarray["prone"]["walk"] = ::beginpronewalk;
  anim.setposemovementfnarray["prone"]["run"] = ::beginpronerun;
}

beginstandstop() {
  self animscripts\debug::debugpushstate("BeginStandStop: " + self.a.pose + " - " + self.a.movement);

  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":

          self animscripts\debug::debugpopstate("BeginStandStop: " + self.a.pose + " - " + self.a.movement);

          return false;
        case "walk":
          standwalktostand();
          break;
        default:
          assert(self.a.movement == "run");
          standruntostand();
          break;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          crouchtostand();
          break;
        case "walk":
          crouchwalktostand();
          break;
        default:
          assert(self.a.movement == "run");
          crouchruntostand();
          break;
      }

      break;
    default:
      assert(self.a.pose == "prone");

      switch (self.a.movement) {
        case "stop":
          pronetostand();
          break;
        default:
          assert(self.a.movement == "walk" || self.a.movement == "run");
          pronetostand();
          break;
      }

      break;
  }

  self animscripts\debug::debugpopstate("BeginStandStop: " + self.a.pose + " - " + self.a.movement);

  return true;
}

beginstandwalk() {
  self animscripts\debug::debugpushstate("BeginStandWalk: " + self.a.pose + " - " + self.a.movement);

  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          blendintostandwalk();
          break;
        case "walk":

          self animscripts\debug::debugpopstate("BeginStandWalk: " + self.a.pose + " - " + self.a.movement);

          return false;
        default:
          assert(self.a.movement == "run");
          blendintostandwalk();
          break;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          crouchtostandwalk();
          break;
        case "walk":
          blendintostandwalk();
          break;
        default:
          assert(self.a.movement == "run");
          blendintostandwalk();
          break;
      }

      break;
    default:
      assert(self.a.pose == "prone");
      pronetostandwalk();
      break;
  }

  self animscripts\debug::debugpopstate("BeginStandWalk: " + self.a.pose + " - " + self.a.movement);

  return true;
}

beginstandrun() {
  self animscripts\debug::debugpushstate("BeginStandRun: " + self.a.pose + " - " + self.a.movement);

  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
        case "walk":
          blendintostandrun();
          break;
        default:

          self animscripts\debug::debugpopstate("BeginStandRun: " + self.a.pose + " - " + self.a.movement);

          assert(self.a.movement == "run");
          return false;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          crouchtostandrun();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          blendintostandrun();
          break;
      }

      break;
    default:
      assert(self.a.pose == "prone");
      pronetostandrun();
      break;
  }

  self animscripts\debug::debugpopstate("BeginStandRun: " + self.a.pose + " - " + self.a.movement);

  return true;
}

begincrouchstop() {
  self animscripts\debug::debugpushstate("BeginCrouchStop: " + self.a.pose + " - " + self.a.movement);

  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          standtocrouch();
          break;
        case "walk":
          standwalktocrouch();
          break;
        case "run":
          standruntocrouch();
          break;
        default:
          assert(0, "SetPoseMovement::BeginCrouchStop " + self.a.pose + " " + self.a.movement);
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          break;
        case "walk":
          crouchwalktocrouch();
          break;
        case "run":
          crouchruntocrouch();
          break;
        default:
          assert(0, "SetPoseMovement::BeginCrouchStop " + self.a.pose + " " + self.a.movement);
      }

      break;
    case "prone":
      pronetocrouch();
      break;
    default:
      assert(0, "SetPoseMovement::BeginCrouchStop " + self.a.pose + " " + self.a.movement);
  }

  self animscripts\debug::debugpopstate("BeginCrouchStop: " + self.a.pose + " - " + self.a.movement);
}

begincrouchwalk() {
  self animscripts\debug::debugpushstate("BeginCrouchWalk: " + self.a.pose + " - " + self.a.movement);

  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          blendintostandwalk();
          blendintocrouchwalk();
          break;
        case "walk":
          blendintocrouchwalk();
          break;
        default:
          assert(self.a.movement == "run");
          blendintocrouchwalk();
          break;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          crouchtocrouchwalk();
          break;
        case "walk":

          self animscripts\debug::debugpopstate("BeginCrouchWalk: " + self.a.pose + " - " + self.a.movement);

          return false;
        default:
          assert(self.a.movement == "run");
          blendintocrouchwalk();
          break;
      }

      break;
    default:
      assert(self.a.pose == "prone");
      pronetocrouchwalk();
      break;
  }

  self animscripts\debug::debugpopstate("BeginCrouchWalk: " + self.a.pose + " - " + self.a.movement);

  return true;
}

begincrouchrun() {
  self animscripts\debug::debugpushstate("BeginCrouchRun: " + self.a.pose + " - " + self.a.movement);

  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          blendintostandrun();
          blendintocrouchrun();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          blendintocrouchrun();
          break;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          crouchtocrouchrun();
          break;
        case "walk":
          blendintocrouchrun();
          break;
        default:

          self animscripts\debug::debugpopstate("BeginCrouchRun: " + self.a.pose + " - " + self.a.movement);

          assert(self.a.movement == "run");
          return false;
      }

      break;
    default:
      assert(self.a.pose == "prone");
      pronetocrouchrun();
      break;
  }

  self animscripts\debug::debugpopstate("BeginCrouchRun: " + self.a.pose + " - " + self.a.movement);

  return true;
}

beginpronestop() {
  self animscripts\debug::debugpushstate("BeginProneStop: " + self.a.pose + " - " + self.a.movement);

  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          standtoprone();
          break;
        case "walk":
          standtoprone();
          break;
        case "run":
          crouchruntoprone();
          break;
        default:
          assert(0, "SetPoseMovement::BeginCrouchRun " + self.a.pose + " " + self.a.movement);
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          crouchtoprone();
          break;
        case "walk":
          crouchtoprone();
          break;
        case "run":
          crouchruntoprone();
          break;
        default:
          assert(0, "SetPoseMovement::BeginCrouchRun " + self.a.pose + " " + self.a.movement);
      }

      break;
    case "prone":
      switch (self.a.movement) {
        case "stop":
          break;
        case "run":
        case "walk":
          pronecrawltoprone();
          break;
        default:
          assert(0, "SetPoseMovement::BeginCrouchRun " + self.a.pose + " " + self.a.movement);
      }

      break;
    default:
      assert(0, "SetPoseMovement::BeginCrouchRun " + self.a.pose + " " + self.a.movement);
  }

  self animscripts\debug::debugpopstate("BeginProneStop: " + self.a.pose + " - " + self.a.movement);
}

beginpronewalk() {
  self animscripts\debug::debugpushstate("BeginProneWalk: " + self.a.pose + " - " + self.a.movement);

  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          standtopronewalk();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          crouchruntopronewalk();
          break;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          crouchtopronewalk();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          crouchruntopronewalk();
          break;
      }

      break;
    default:
      assert(self.a.pose == "prone");

      switch (self.a.movement) {
        case "stop":
          pronetopronerun();
          break;
        default:

          self animscripts\debug::debugpopstate("BeginProneWalk: " + self.a.pose + " - " + self.a.movement);

          assert(self.a.movement == "run" || self.a.movement == "walk");
          self.a.movement = "walk";
          return false;
      }

      break;
  }

  self animscripts\debug::debugpopstate("BeginProneWalk: " + self.a.pose + " - " + self.a.movement);

  return true;
}

beginpronerun() {
  self animscripts\debug::debugpushstate("BeginProneRun: " + self.a.pose + " - " + self.a.movement);

  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          standtopronerun();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          crouchruntopronerun();
          break;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          crouchtopronerun();
          break;
        default:
          assert(self.a.movement == "run" || self.a.movement == "walk");
          crouchruntopronerun();
          break;
      }

      break;
    default:
      assert(self.a.pose == "prone");

      switch (self.a.movement) {
        case "stop":
          assert(self.a.movement == "stop");
          pronetopronerun();
          break;
        default:

          self animscripts\debug::debugpopstate("BeginProneRun: " + self.a.pose + " - " + self.a.movement);

          assert(self.a.movement == "run" || self.a.movement == "walk");
          self.a.movement = "run";
          return false;
      }

      break;
  }

  self animscripts\debug::debugpopstate("BeginProneRun: " + self.a.pose + " - " + self.a.movement);

  return true;
}

#using_animtree("generic_human");

playblendtransition(transanim, crossblendtime, endpose, endmovement, endaiming) {
  self animscripts\debug::debugpushstate("PlayBlendTransition: " + endpose + " - " + endmovement);

  endtime = gettime() + crossblendtime * 1000;
  self setanimknoball(transanim, % body, 1, crossblendtime, 1);
  wait(crossblendtime / 2);
  self.a.pose = endpose;
  self.a.movement = endmovement;
  waittime = (endtime - gettime()) / 1000;

  if(waittime < 0.05)
    waittime = 0.05;

  wait(waittime);

  self animscripts\debug::debugpopstate("PlayBlendTransition: " + endpose + " - " + endmovement);
}

playtransitionstandwalk(transanim, finalanim) {
  playtransitionanimation(transanim, "stand", "walk", 1, finalanim);
}

standwalktostand() {
  assert(self.a.pose == "stand", "SetPoseMovement::StandWalkToStand " + self.a.pose);
  assert(self.a.movement == "walk", "SetPoseMovement::StandWalkToStand " + self.a.movement);
  self.a.movement = "stop";
}

standwalktocrouch() {
  standwalktostand();
  standtocrouch();
}

standruntostand() {
  assert(self.a.pose == "stand", "SetPoseMovement::StandRunToStand " + self.a.pose);
  assert(self.a.movement == "run", "SetPoseMovement::StandRunToStand " + self.a.movement);
  self.a.movement = "stop";
}

standruntocrouch() {
  self.a.movement = "stop";
  self.a.pose = "crouch";
}

playblendtransitionstandrun(animname) {
  transtime = 0.3;

  if(self.a.movement != "stop") {
    self endon("movemode");
    transtime = 0.1;
  }

  playblendtransition(animname, transtime, "stand", "run", 0);
}

blendintostandrun() {
  shouldtacticalwalk = animscripts\run::shouldtacticalwalk();

  if(shouldtacticalwalk) {
    self.a.movement = "run";

    if(self.a.pose != "stand")
      transitiontotacticalwalk("stand");

    return false;
  }

  if(self animscripts\cqb::shouldcqb())
    playblendtransitionstandrun(animarray("start_cqb_run_f", "move"));
  else if(self animscripts\utility::isincombat() && isDefined(self.run_combatanim))
    playblendtransitionstandrun(self.run_combatanim);
  else if(isDefined(self.run_noncombatanim))
    playblendtransitionstandrun(self.run_noncombatanim);
  else {
    shouldshootwhilemoving = 0;
    runanimname = "start_stand_run_f";
    transitionanimparent = % combatrun;
    forwardrunanim = % combatrun_forward;
    runanimtranstime = 0.0;

    if(self.a.movement != "stop")
      runanimtranstime = 0.5;

    if(self.a.pose == "stand") {
      if(animscripts\move::mayshootwhilemoving() && self.bulletsinclip > 0 && isvalidenemy(self.enemy)) {
        shouldshootwhilemoving = 1;

        if(self.a.pose == "stand")
          runanimname = "run_n_gun_f";
      }
    }

    self clearanim( % walk_and_run_loops, 0.2);
    self setanimknob( % combatrun, 1.0, 0.5, self.moveplaybackrate);
    self setanimknoblimited(animarray(runanimname), 1, runanimtranstime, 1);

    if(shouldshootwhilemoving && self.a.pose == "stand")
      self thread animscripts\run::updaterunweights("BlendIntoStandRun", forwardrunanim, animarray("run_n_gun_b"));
    else
      self thread animscripts\run::updaterunweights("BlendIntoStandRun", forwardrunanim, animarray("combat_run_b"), animarray("combat_run_l"), animarray("combat_run_r"));

    playblendtransitionstandrun(transitionanimparent);
  }

  self notify("BlendIntoStandRun");
}

playblendtransitionstandwalk(animname) {
  if(self.a.movement != "stop")
    self endon("movemode");

  playblendtransition(animname, 0.6, "stand", "walk", 1);
}

blendintostandwalk() {
  if(self.a.movement != "stop")
    self endon("movemode");

  self.a.pose = "stand";
  self.a.movement = "walk";
}

crouchtostand() {
  assert(self.a.pose == "crouch", "SetPoseMovement::CrouchToStand " + self.a.pose);
  assert(self.a.movement == "stop", "SetPoseMovement::CrouchToStand " + self.a.movement);
  standspeed = 0.5;

  if(isDefined(self.faststand)) {
    standspeed = 1.8;
    self.faststand = undefined;
  }

  if(self animscripts\utility::weaponanims() == "pistol" || self animscripts\utility::weaponanims() == "none")
    playtransitionanimation(animarray("crouch_2_stand"), "stand", "stop", standspeed);
  else {
    self randomizeidleset();
    playtransitionanimation(animarray("crouch_2_stand"), "stand", "stop", standspeed);
  }

  self clearanim( % shoot, 0);
}

crouchtocrouchwalk() {
  assert(self.a.pose == "crouch", "SetPoseMovement::CrouchToCrouchWalk " + self.a.pose);
  assert(self.a.movement == "stop", "SetPoseMovement::CrouchToCrouchWalk " + self.a.movement);
  blendintocrouchwalk();
}

crouchtostandwalk() {
  crouchtocrouchwalk();
  blendintostandwalk();
}

crouchwalktocrouch() {
  assert(self.a.pose == "crouch", "SetPoseMovement::CrouchWalkToCrouch " + self.a.pose);
  assert(self.a.movement == "walk", "SetPoseMovement::CrouchWalkToCrouch " + self.a.movement);
  self.a.movement = "stop";
}

crouchwalktostand() {
  crouchwalktocrouch();
  crouchtostand();
}

crouchruntocrouch() {
  assert(self.a.pose == "crouch", "SetPoseMovement::CrouchRunToCrouch " + self.a.pose);
  assert(self.a.movement == "run", "SetPoseMovement::CrouchRunToCrouch " + self.a.movement);
  self.a.movement = "stop";
}

crouchruntostand() {
  crouchruntocrouch();
  crouchtostand();
}

crouchtocrouchrun() {
  assert(self.a.pose == "crouch", "SetPoseMovement::CrouchToCrouchRun " + self.a.pose);
  assert(self.a.movement == "stop", "SetPoseMovement::CrouchToCrouchRun " + self.a.movement);
  blendintocrouchrun();
}

crouchtostandrun() {
  blendintostandrun();
}

blendintocrouchrun() {
  if(isDefined(self.crouchrun_combatanim)) {
    self setanimknoball(self.crouchrun_combatanim, % body, 1, 0.4);
    playblendtransition(self.crouchrun_combatanim, 0.6, "crouch", "run", 0);
    self notify("BlendIntoCrouchRun");
  } else {
    self setanimknob(animscripts\run::getcrouchrunanim(), 1, 0.4);
    self thread animscripts\run::updaterunweights("BlendIntoCrouchRun", % combatrun_forward, animarray("combat_run_b"), animarray("combat_run_l"), animarray("combat_run_r"));
    playblendtransition( % combatrun, 0.6, "crouch", "run", 0);
    self notify("BlendIntoCrouchRun");
  }
}

pronetocrouchrun() {
  assert(self.a.pose == "prone", "SetPoseMovement::ProneToCrouchRun " + self.a.pose);
  self orientmode("face current");
  self exitpronewrapper(1.0);
  self animscripts\cover_prone::updatepronewrapper(0.1);
  playtransitionanimation(animarray("prone_2_crouch_run"), "crouch", "run", 0, animarray("crouch_run_f"));
}

pronetostandrun() {
  pronetocrouchrun();
  blendintostandrun();
}

pronetocrouchwalk() {
  pronetocrouchrun();
  blendintocrouchwalk();
}

blendintocrouchwalk() {
  if(isDefined(self.crouchrun_combatanim)) {
    self setanimknoball(self.crouchrun_combatanim, % body, 1, 0.4);
    playblendtransition(self.crouchrun_combatanim, 0.6, "crouch", "walk", 0);
    self notify("BlendIntoCrouchWalk");
  } else
    playblendtransition(animarray("crouch_run_f"), 0.8, "crouch", "walk", 1);
}

standtocrouch() {
  assert(self.a.pose == "stand", "SetPoseMovement::StandToCrouch " + self.a.pose);
  assert(self.a.movement == "stop", "SetPoseMovement::StandToCrouch " + self.a.movement);
  self randomizeidleset();
  crouchspeed = 0.5;

  if(isDefined(self.fastcrouch)) {
    crouchspeed = 1.8;
    self.fastcrouch = undefined;
  }

  playtransitionanimation(animarray("stand_2_crouch"), "crouch", "stop", 1, undefined, crouchspeed);
  self clearanim( % shoot, 0);
}

pronetocrouch() {
  assert(self.a.pose == "prone", "SetPoseMovement::StandToCrouch " + self.a.pose);
  self randomizeidleset();
  self orientmode("face current");
  self exitpronewrapper(1.0);
  self animscripts\cover_prone::updatepronewrapper(0.1);
  playtransitionanimation(animarray("prone_2_crouch"), "crouch", "stop", 1);
}

pronetostand() {
  assert(self.a.pose == "prone", self.a.pose);
  self orientmode("face current");
  self exitpronewrapper(1.0);
  self animscripts\cover_prone::updatepronewrapper(0.1);
  playtransitionanimation(animarray("prone_2_stand"), "stand", "stop", 1);
}

pronetostandwalk() {
  pronetocrouch();
  crouchtocrouchwalk();
  blendintostandwalk();
}

pronetopronemove(movement) {
  assert(self.a.pose == "prone", "SetPoseMovement::ProneToProneMove " + self.a.pose);
  assert(self.a.movement == "stop", "SetPoseMovement::ProneToProneMove " + self.a.movement);
  assert(movement == "walk" || movement == "run", "SetPoseMovement::ProneToProneMove got bad parameter " + movement);
  playtransitionanimation(animarray("aim_2_crawl"), "prone", movement, 0, animarray("combat_run_f"));
  self animscripts\cover_prone::updatepronewrapper(0.1);
}

pronetopronerun() {
  pronetopronemove("run");
}

pronecrawltoprone() {
  assert(self.a.pose == "prone", "SetPoseMovement::ProneCrawlToProne " + self.a.pose);
  assert(self.a.movement == "walk" || self.a.movement == "run", "SetPoseMovement::ProneCrawlToProne " + self.a.movement);
  self animscripts\cover_prone::updatepronewrapper(0.1);
  playtransitionanimation(animarray("crawl_2_aim"), "prone", "stop", 1);
  self clearanim( % exposed_modern, 0.2);
}

crouchtoprone() {
  assert(self.a.pose == "crouch", "SetPoseMovement::CrouchToProne " + self.a.pose);
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  self enterpronewrapper(1.0);
  self animscripts\cover_prone::updatepronewrapper(0.1);
  playtransitionanimation(animarray("crouch_2_prone"), "prone", "stop", 1);
  self clearanim( % exposed_modern, 0.2);
}

crouchtopronewalk() {
  crouchtoprone();
  pronetopronerun();
}

crouchtopronerun() {
  crouchtoprone();
  pronetopronerun();
}

standtoprone() {
  assert(self.a.pose == "stand", "SetPoseMovement::StandToProne " + self.a.pose);
  transanim = animarray("stand_2_prone");
  thread playtransitionanimationthread_withoutwaitsetstates(transanim, "prone", "stop", 0.5);
  self waittillmatch("transAnimDone2", "anim_pose = \"prone\"");
  waittillframeend;
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  self enterpronewrapper(0.5);
  self.a.movement = "stop";
  self waittillmatch("transAnimDone2", "end");
  self clearanim( % exposed_modern, 0.2);
}

standtopronewalk() {
  standtoprone();
  pronetopronerun();
}

standtopronerun() {
  standtoprone();
  pronetopronerun();
}

crouchruntoprone() {
  assert(self.a.pose == "crouch" || self.a.pose == "stand", "SetPoseMovement::CrouchRunToProne " + self.a.pose);
  assert(self.a.movement == "run" || self.a.movement == "walk", "SetPoseMovement::CrouchRunToProne " + self.a.movement);
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  self enterpronewrapper(0.5);
  self animscripts\cover_prone::updatepronewrapper(0.1);
  rundirection = animscripts\utility::getquadrant(self getmotionangle());
  diveanim = animarray("run_2_prone_dive", "move");
  localdeltavector = getmovedelta(diveanim, 0, 1);
  endpoint = self localtoworldcoords(localdeltavector);

  if(self maymovetopoint(endpoint))
    playtransitionanimation(diveanim, "prone", "stop", 0.5);
  else
    playtransitionanimation(animarray("run_2_prone_gunsupport", "move"), "prone", "stop", 0.5);
}

crouchruntopronewalk() {
  crouchruntoprone();
  pronetopronerun();
}

crouchruntopronerun() {
  crouchruntoprone();
  pronetopronerun();
}

playtransitionanimationthread_withoutwaitsetstates(transanim, endpose, endmovement, endaiming, finalanim, rate) {
  self endon("killanimscript");
  self endon("entered_pose" + endpose);
  playtransitionanimationfunc(transanim, endpose, endmovement, endaiming, finalanim, rate, 0);
}

playtransitionanimation(transanim, endpose, endmovement, endaiming, finalanim, rate) {
  playtransitionanimationfunc(transanim, endpose, endmovement, endaiming, finalanim, rate, 1);
}

playtransitionanimationfunc(transanim, endpose, endmovement, endaiming, finalanim, rate, waitsetstatesenabled) {
  if(!isDefined(rate))
    rate = 1;

  if(getdebugdvar("debug_animpose") == "on") {
    if(endpose != self.a.pose) {
      if(!animhasnotetrack(transanim, "anim_pose = \"" + endpose + "\"")) {
        println("Animation ", transanim, " lacks an endpose notetrack of ", endpose);
        assert(0, "A transition animation is missing a pose notetrack (see the line above)");
      }
    }

    if(endmovement != self.a.movement) {
      if(!animhasnotetrack(transanim, "anim_movement = \"" + endmovement + "\"")) {
        println("Animation ", transanim, " lacks an endmovement notetrack of ", endmovement);
        assert(0, "A transition animation is missing a movement notetrack (see the line above)");
      }
    }
  }

  if(waitsetstatesenabled)
    self thread waitsetstates(getanimlength(transanim) / 2.0, "killtimerscript", endpose);

  self setflaggedanimknoballrestart("transAnimDone2", transanim, % body, 1, 0.2, rate);

  if(!isDefined(self.a.pose))
    self.pose = "undefined";

  if(!isDefined(self.a.movement))
    self.movement = "undefined";

  debugidentifier = "";

  debugidentifier = self.a.script + ", " + self.a.pose + " to " + endpose + ", " + self.a.movement + " to " + endmovement;

  self animscripts\shared::donotetracks("transAnimDone2", undefined, debugidentifier);
  self notify("killtimerscript");
  self.a.pose = endpose;
  self notify("entered_pose" + endpose);
  self.a.movement = endmovement;

  if(isDefined(finalanim))
    self setanimknoball(finalanim, % body, 1, 0.3, rate);
}

waitsetstates(timetowait, killmestring, endpose) {
  self endon("killanimscript");
  self endon("death");
  self endon(killmestring);
  oldpose = self.a.pose;
  wait(timetowait);

  if(oldpose != "prone" && endpose == "prone") {
    self animscripts\cover_prone::updatepronewrapper(0.1);
    self enterpronewrapper(1.0);
  } else if(oldpose == "prone" && endpose != "prone") {
    self exitpronewrapper(1.0);
    self orientmode("face default");
  }
}

transitiontotacticalwalk(newpose) {
  if(newpose == self.a.pose) {
    return;
  }
  self animscripts\debug::debugpushstate("transitionTo: " + newpose);

  transanim = animarray(self.a.pose + "_2_" + newpose, "combat");

  if(newpose == "stand")
    rate = 2;
  else
    rate = 1;

  self orientmode("face enemy");

  if(!animhasnotetrack(transanim, "anim_pose = \"" + newpose + "\""))
    println("error: ^2 missing notetrack to set pose!", transanim);

  self setflaggedanimknoballrestart("trans", transanim, % body, 1, 0.3, rate);
  transtime = getanimlength(transanim) / rate;
  playtime = transtime - 0.2;

  if(playtime < 0.2)
    playtime = 0.2;

  self animscripts\shared::donotetracksfortime(playtime, "trans");
  self orientmode("face default");
  self clearanim( % exposed_modern, 0.2);
  self.a.pose = newpose;

  self animscripts\debug::debugpopstate("transitionTo: " + newpose);
}