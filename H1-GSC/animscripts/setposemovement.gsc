/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\setposemovement.gsc
*******************************************/

setposemovement(var_0, var_1) {
  if(var_0 == "") {
    if(self.a.pose == "prone" && (var_1 == "walk" || var_1 == "run"))
      var_0 = "crouch";
    else
      var_0 = self.a.pose;
  }

  if(!isdefined(var_1) || var_1 == "")
    var_1 = self.a.movement;

  return [[anim.setposemovementfnarray[var_0][var_1]]]();
}

initposemovementfunctions() {
  anim.setposemovementfnarray["stand"]["stop"] = ::standstop_begin;
  anim.setposemovementfnarray["stand"]["walk"] = ::standwalk_begin;
  anim.setposemovementfnarray["stand"]["run"] = ::standrun_begin;
  anim.setposemovementfnarray["crouch"]["stop"] = ::crouchstop_begin;
  anim.setposemovementfnarray["crouch"]["walk"] = ::crouchwalk_begin;
  anim.setposemovementfnarray["crouch"]["run"] = ::crouchrun_begin;
  anim.setposemovementfnarray["prone"]["stop"] = ::pronestop_begin;
  anim.setposemovementfnarray["prone"]["walk"] = ::pronewalk_begin;
  anim.setposemovementfnarray["prone"]["run"] = ::pronerun_begin;
}

standstop_begin() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          return 0;
        case "walk":
          standwalktostand();
          break;
        default:
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
          crouchruntostand();
          break;
      }

      break;
    default:
      switch (self.a.movement) {
        case "stop":
          pronetostand();
          break;
        default:
          pronecrawltoprone();
          break;
      }

      break;
  }

  return 1;
}

standwalk_begin() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          if(animscripts\stairs_utility::isonstairs())
            return 0;

          blendintostandwalk();
          break;
        case "walk":
          return 0;
        default:
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
          blendintostandwalk();
          break;
      }

      break;
    default:
      switch (self.a.movement) {
        case "stop":
          pronetostandwalk();
          break;
        default:
          pronecrawltoprone();
          break;
      }

      break;
  }

  return 1;
}

standrun_begin() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "walk":
        case "stop":
          if(animscripts\stairs_utility::isonstairs())
            return 0;

          return blendintostandrun();
        default:
          return 0;
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          return crouchtostandrun();
        default:
          return blendintostandrun();
      }

      break;
    default:
      switch (self.a.movement) {
        case "stop":
          pronetostandrun();
          break;
        default:
          pronecrawltoprone();
          break;
      }

      break;
  }

  return 1;
}

crouchstop_begin() {
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
      }

      break;
    case "crouch":
      switch (self.a.movement) {
        case "stop":
          return 0;
        case "walk":
          crouchwalktocrouch();
          break;
        case "run":
          crouchruntocrouch();
          break;
        default:
      }

      break;
    case "prone":
      switch (self.a.movement) {
        case "stop":
          pronetocrouch();
          break;
        default:
          pronecrawltoprone();
          break;
      }

      break;
    default:
  }

  return 1;
}

crouchwalk_begin() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          standtocrouch();
          blendintocrouchwalk();
          break;
        case "walk":
          blendintocrouchwalk();
          break;
        default:
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
          return 0;
        default:
          blendintocrouchwalk();
          break;
      }

      break;
    default:
      switch (self.a.movement) {
        case "stop":
          pronetocrouchwalk();
          break;
        default:
          pronecrawltoprone();
          break;
      }

      break;
  }

  return 1;
}

crouchrun_begin() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          standtocrouch();
          blendintocrouchrun();
          break;
        default:
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
          return 0;
      }

      break;
    default:
      switch (self.a.movement) {
        case "stop":
          pronetocrouchrun();
          break;
        default:
          pronecrawltoprone();
          break;
      }

      break;
  }

  return 1;
}

pronestop_begin() {
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
      }

      break;
    case "prone":
      switch (self.a.movement) {
        case "stop":
          return 0;
        case "walk":
        case "run":
          pronecrawltoprone();
          break;
        default:
      }

      break;
    default:
  }

  return 1;
}

pronewalk_begin() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          standtopronewalk();
          break;
        default:
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
          crouchruntopronewalk();
          break;
      }

      break;
    default:
      switch (self.a.movement) {
        case "stop":
          pronetopronerun();
          break;
        default:
          self.a.movement = "walk";
          return 0;
      }

      break;
  }

  return 1;
}

pronerun_begin() {
  switch (self.a.pose) {
    case "stand":
      switch (self.a.movement) {
        case "stop":
          standtopronerun();
          break;
        default:
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
          crouchruntopronerun();
          break;
      }

      break;
    default:
      switch (self.a.movement) {
        case "stop":
          pronetopronerun();
          break;
        default:
          self.a.movement = "run";
          return 0;
      }

      break;
  }

  return 1;
}

#using_animtree("generic_human");

playblendtransition(var_0, var_1, var_2, var_3) {
  var_4 = gettime() + var_1 * 1000;

  if(isarray(var_0))
    var_0 = var_0[randomint(var_0.size)];

  self setflaggedanimknoball("blendTransition", var_0, % body, 1, var_1, 1);
  animscripts\notetracks::donotetracksfortime(var_1 / 2, "blendTransition");
  self.a.pose = var_2;
  self.a.movement = var_3;
  var_5 = (var_4 - gettime()) / 1000;

  if(var_5 < 0.05)
    var_5 = 0.05;

  animscripts\notetracks::donotetracksfortime(var_5, "blendTransition");
}

playtransitionstandwalk(var_0, var_1) {
  playtransitionanimation(var_0, "stand", "walk", var_1);
}

standwalktostand() {
  self.a.movement = "stop";
}

standwalktocrouch() {
  standwalktostand();
  standtocrouch();
}

standruntostand() {
  self.a.movement = "stop";
}

standruntocrouch() {
  self.a.movement = "stop";
  self.a.pose = "crouch";
}

playblendtransitionstandrun(var_0) {
  var_1 = 0.3;

  if(self.a.movement != "stop") {
    self endon("movemode");
    var_1 = 1.0;
  }

  var_2 = animscripts\stairs_utility::getstairtransitionfinishedthisframe();

  if(var_2 != "none")
    var_1 = 0.1;

  playblendtransition(var_0, var_1, "stand", "run");
}

blendintostandrun() {
  if(!self.facemotion) {
    self.a.movement = "run";
    self.a.pose = "stand";
    return 0;
  }

  if(isdefined(self.run_overrideanim)) {
    self clearanim( % h1_stairs, 0.1);

    if(animscripts\stairs_utility::isonstairs()) {
      var_0 = animscripts\stairs_utility::getstairsanimnameatgroundpos();
      var_1 = animscripts\utility::getmoveanim(var_0);
      playblendtransitionstandrun(var_1);
      return 1;
    }

    playblendtransitionstandrun(self.run_overrideanim);
    return 1;
  }

  var_2 = 0.1;

  if(self.a.movement != "stop" && self.stairsstate == "none")
    var_2 = 0.5;

  if(isdefined(self.sprint))
    self setanimknoblimited(animscripts\utility::getmoveanim("sprint"), 1, var_2, 1);
  else
    self setanimknoblimited(animscripts\run::getrunanim(), 1, var_2, 1);

  animscripts\run::setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"), animscripts\utility::getmoveanim("move_l"), animscripts\utility::getmoveanim("move_r"), self.sidesteprate);
  thread animscripts\run::setcombatstandmoveanimweights("run");
  wait 0.05;
  playblendtransitionstandrun( % combatrun);
  return 1;
}

blendintostandwalk() {
  if(self.a.movement != "stop")
    self endon("movemode");

  if(!isdefined(self.alwaysrunforward) && self.a.pose != "prone")
    animscripts\run::setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"), animscripts\utility::getmoveanim("move_l"), animscripts\utility::getmoveanim("move_r"));

  self.a.pose = "stand";
  self.a.movement = "walk";
}

crouchtostand() {
  var_0 = 1;

  if(isdefined(self.faststand)) {
    var_0 = 1.8;
    self.faststand = undefined;
  }

  if(animscripts\utility::usingsidearm())
    playtransitionanimation( % pistol_crouchaimstraight2stand, "stand", "stop", undefined, var_0);
  else {
    animscripts\utility::randomizeidleset();
    playtransitionanimation( % crouch2stand, "stand", "stop", undefined, var_0);
  }
}

crouchtocrouchwalk() {
  blendintocrouchwalk();
}

crouchtostandwalk() {
  crouchtocrouchwalk();
  blendintostandwalk();
}

crouchwalktocrouch() {
  self.a.movement = "stop";
}

crouchwalktostand() {
  crouchwalktocrouch();
  crouchtostand();
}

crouchruntocrouch() {
  self.a.movement = "stop";
}

crouchruntostand() {
  crouchruntocrouch();
  crouchtostand();
}

crouchtocrouchrun() {
  if(self getanimweight( % casual_crouch_idle) != 0.0 || self getanimweight( % casual_crouch_idle_in) != 0.0)
    playtransitionanimation( % casual_crouch_idle_out, "crouch", "stop");

  blendintocrouchrun();
}

crouchtostandrun() {
  if(self getanimweight( % casual_crouch_idle) != 0.0 || self getanimweight( % casual_crouch_idle_in) != 0.0)
    playtransitionanimation( % casual_crouch_idle_out, "crouch", "stop");

  playtransitionanimation( % crouch_2run_f, "stand", "run");
  return 1;
}

blendintocrouchrun() {
  if(isdefined(self.crouchrun_combatanim))
    playblendtransition(self.crouchrun_combatanim, 0.6, "crouch", "run");
  else {
    var_0 = % crouchrun;
    var_1 = 0.4;
    var_2 = self.a.movement == "stop" && self.a.pose == "crouch";

    if(var_2) {
      var_0 = % crouchwalk_2_crouch_start_8;
      var_1 = 0.1;
    }

    self setanimknob(var_0, 1, var_1, self.moveplaybackrate);

    if(var_2) {
      var_3 = 0.27;

      if(isdefined(self.crouchtransitionoverridewait))
        var_3 = self.crouchtransitionoverridewait;

      wait(var_3);
    }

    if(animscripts\utility::usingsmg() && self.a.movement == "run" && !(isdefined(self.custommoveanimset) && isdefined(self.custommoveanimset["run"]))) {
      var_4 = "smg_crouch_run";
      thread animscripts\run::updatemoveanimweights("crouchrun", animscripts\utility::lookupanim(var_4, "crouch"), animscripts\utility::lookupanim(var_4, "crouch_b"), animscripts\utility::lookupanim(var_4, "crouch_l"), animscripts\utility::lookupanim(var_4, "crouch_r"));
    } else
      thread animscripts\run::updatemoveanimweights("crouchrun", animscripts\utility::getmoveanim("crouch"), animscripts\utility::getmoveanim("crouch_b"), animscripts\utility::getmoveanim("crouch_l"), animscripts\utility::getmoveanim("crouch_r"));

    wait 0.05;
    playblendtransition(var_0, var_1, "crouch", "run");
  }
}

pronetocrouchrun() {
  animscripts\move::getupifprone(0.4);
}

pronetostandrun() {
  animscripts\move::getupifprone(0.4);
}

pronetocrouchwalk() {
  animscripts\move::getupifprone(0.4);
}

blendintocrouchwalk() {
  if(isdefined(self.crouchrun_combatanim)) {
    self setanimknoball(self.crouchrun_combatanim, % body, 1, 0.4);
    playblendtransition(self.crouchrun_combatanim, 0.6, "crouch", "walk");
    self notify("BlendIntoCrouchWalk");
  } else {
    self setanimknob( % crouchrun, 1, 0.4, self.moveplaybackrate);
    thread animscripts\run::updatemoveanimweights("crouchrun", animscripts\utility::getmoveanim("crouch"), animscripts\utility::getmoveanim("crouch_b"), animscripts\utility::getmoveanim("crouch_l"), animscripts\utility::getmoveanim("crouch_r"));
    wait 0.05;
    playblendtransition( % crouchrun, 0.4, "crouch", "run");
  }
}

standtocrouch() {
  animscripts\utility::randomizeidleset();
  var_0 = 1;

  if(isdefined(self.fastcrouch)) {
    var_0 = 1.8;
    self.fastcrouch = undefined;
  }

  playtransitionanimation( % exposed_stand_2_crouch, "crouch", "stop", undefined, var_0);
}

pronetocrouch() {
  animscripts\utility::randomizeidleset();
  animscripts\move::getupifprone(0.4);
}

pronetostand() {
  animscripts\move::getupifprone(0.4);
}

pronetostandwalk() {
  pronetostand();
  blendintostandwalk();
}

pronetopronemove(var_0) {
  if(isdefined(self.custompronetopronetransitionfunc)) {
    [
      [self.custompronetopronetransitionfunc]
    ]();
    return;
  }

  pronelegsstraighttree(0.1);
  playtransitionanimation( % h1_crawlstart_f, "prone", var_0, % prone_crawl);
  animscripts\cover_prone::updatepronewrapper(0.1);
}

pronetopronerun() {
  pronetopronemove("run");
}

pronecrawltoprone() {
  pronelegsstraighttree(0.1);
  animscripts\cover_prone::updatepronewrapper(0.1);
  playtransitionanimation( % h1_crawl_2_prone, "prone", "stop", undefined, self.moveplaybackrate);
}

crouchtoprone() {
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  animscripts\utility::enterpronewrapper(1.0);
  pronelegsstraighttree(0.3);
  animscripts\cover_prone::updatepronewrapper(0.1);
  playtransitionanimation( % crouch_2_prone, "prone", "stop");
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
  self endon("entered_poseprone");
  var_0 = 0.5;
  thread playtransitionanimationthread_withoutwaitsetstates( % stand_2_prone, "prone", "stop", undefined, var_0);
  self waittillmatch("transAnimDone2", "anim_pose = \"crouch\"");
  waittillframeend;
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  animscripts\utility::enterpronewrapper(var_0);
  self.a.movement = "stop";
  animscripts\cover_prone::updatepronewrapper(0.1);
  self waittillmatch("transAnimDone2", "end");
  pronelegsstraighttree(0.2);
  self setanim( % prone_aim_idle, 1, 0.1);
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
  self notify("stop_move_anim_update");
  self.update_move_anim_type = undefined;
  var_0 = 0.5;
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  animscripts\utility::enterpronewrapper(var_0);
  pronelegsstraighttree(0.2);
  animscripts\cover_prone::updatepronewrapper(0.1);
  var_1 = animscripts\utility::getquadrant(self getmotionangle());
  var_2 = % crouch_2_prone;
  var_3 = getmovedelta(var_2, 0, 1);
  var_4 = self localtoworldcoords(var_3);

  if(self maymovetopoint(var_4))
    playtransitionanimation(var_2, "prone", "stop", undefined, var_0);
  else
    playtransitionanimation( % crouch_2_prone_firing, "prone", "stop", undefined, var_0);
}

crouchruntopronewalk() {
  crouchruntoprone();
  pronetopronerun();
}

crouchruntopronerun() {
  crouchruntoprone();
  pronetopronerun();
}

playtransitionanimationthread_withoutwaitsetstates(var_0, var_1, var_2, var_3, var_4) {
  self endon("killanimscript");
  self endon("entered_pose" + var_1);
  playtransitionanimationfunc(var_0, var_1, var_2, var_3, var_4, 0);
}

playtransitionanimation(var_0, var_1, var_2, var_3, var_4) {
  playtransitionanimationfunc(var_0, var_1, var_2, var_3, var_4, 1);
}

playtransitionanimationfunc(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(var_4))
    var_4 = 1;

  self.movetransitionanimation = var_0;
  self.movetransitionendpose = var_1;

  if(var_5)
    thread waitsetstates(getanimlength(var_0) / 2.0, "killtimerscript", var_1);

  self setflaggedanimknoballrestart("transAnimDone2", var_0, % body, 1, 0.2, var_4);

  if(!isdefined(self.a.pose))
    self.pose = "undefined";

  if(!isdefined(self.a.movement))
    self.movement = "undefined";

  var_6 = "";
  animscripts\shared::donotetracks("transAnimDone2", undefined, var_6);
  self notify("killtimerscript");
  self.a.pose = var_1;
  self notify("entered_pose" + var_1);
  self.a.movement = var_2;
  self.movetransitionanimation = undefined;
  self.movetransitionendpose = undefined;

  if(isdefined(var_3))
    self setanimknoball(var_3, % body, 1, 0.3, var_4);
  else
    self clearanim(var_0, 0.1);
}

waitsetstates(var_0, var_1, var_2) {
  self endon("killanimscript");
  self endon("death");
  self endon(var_1);
  var_3 = self.a.pose;
  wait(var_0);

  if(var_3 != "prone" && var_2 == "prone") {
    animscripts\cover_prone::updatepronewrapper(0.1);
    animscripts\utility::enterpronewrapper(1.0);
  } else if(var_3 == "prone" && var_2 != "prone") {
    animscripts\utility::exitpronewrapper(1.0);
    self orientmode("face default");
  }
}

pronelegsstraighttree(var_0) {
  self setanimknoball( % prone_legsstraight, % body, 1, var_0, self.moveplaybackrate);
}