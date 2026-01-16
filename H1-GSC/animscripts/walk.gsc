/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\walk.gsc
********************************/

movewalk() {
  var_0 = undefined;

  if(isdefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > 4096)
    var_0 = "stand";

  var_1 = [[self.chooseposefunc]](var_0);

  switch (var_1) {
    case "stand":
      if(animscripts\setposemovement::standwalk_begin()) {
        return;
      }
      if(isdefined(self.walk_overrideanim)) {
        animscripts\move::movestand_moveoverride(self.walk_overrideanim, self.walk_override_weights);
        return;
      }

      dowalkanim(getwalkanim("straight"));
      break;
    case "crouch":
      if(animscripts\setposemovement::crouchwalk_begin()) {
        return;
      }
      dowalkanim(getwalkanim("crouch"));
      break;
    default:
      if(animscripts\setposemovement::pronewalk_begin()) {
        return;
      }
      self.a.movement = "walk";
      dowalkanim(getwalkanim("prone"));
      break;
  }
}

#using_animtree("generic_human");

dowalkanimoverride(var_0) {
  self endon("movemode");
  self clearanim( % combatrun, 0.6);
  self setanimknoball( % combatrun, % body, 1, 0.5, self.moveplaybackrate);

  if(isarray(self.walk_overrideanim)) {
    if(isdefined(self.walk_override_weights))
      var_1 = common_scripts\utility::choose_from_weighted_array(self.walk_overrideanim, self.walk_override_weights);
    else
      var_1 = self.walk_overrideanim[randomint(self.walk_overrideanim.size)];
  } else
    var_1 = self.walk_overrideanim;

  self setflaggedanimknob("moveanim", var_1, 1, 0.2);
  animscripts\shared::donotetracks("moveanim");
}

getwalkanim(var_0) {
  if(animscripts\stairs_utility::isonstairs()) {
    var_1 = animscripts\stairs_utility::getstairsanimnameatgroundpos();
    return animscripts\utility::getmoveanim(var_1);
  }

  var_2 = animscripts\utility::getmoveanim(var_0);

  if(!animscripts\utility::isincombat() && !(isdefined(self.noruntwitch) && self.noruntwitch) && !(isdefined(self.a.bdisablemovetwitch) && self.a.bdisablemovetwitch)) {
    var_3 = animscripts\utility::getmoveanim("straight_twitch");

    if(isdefined(self.isunstableground) && self.isunstableground) {
      var_4 = animscripts\traverse\shared::getnextfootdown();

      if(var_4 == "Left")
        var_3 = animscripts\utility::getmoveanim("straight_twitch_l");
      else if(var_4 == "Right")
        var_3 = animscripts\utility::getmoveanim("straight_twitch_r");
    }

    if(!isdefined(self.a.runloopcount)) {
      if(isarray(var_2))
        var_2 = var_2[randomint(var_2.size)];

      return var_2;
    }

    if(isdefined(var_3) && var_3.size > 0) {
      var_5 = animscripts\utility::getrandomintfromseed(self.a.runloopcount, 4);

      if(var_5 == 0)
        return animscripts\utility::gettwitchanim(var_3);
    }
  }

  if(isarray(var_2))
    var_2 = var_2[randomint(var_2.size)];

  return var_2;
}

dowalkanim(var_0) {
  self endon("movemode");
  var_1 = self.moveplaybackrate;

  if(animscripts\stairs_utility::isonstairs())
    var_1 = var_1 * 0.9;

  if(self.a.pose == "stand") {
    if(isdefined(self.enemy)) {
      animscripts\cqb::cqbtracking();

      if(animscripts\stairs_utility::isonstairs())
        var_2 = % body;
      else
        var_2 = % walk_and_run_loops;

      self setflaggedanimknoball("walkanim", animscripts\cqb::determinecqbanim(), var_2, 1, 1, var_1, 1);
    } else
      self setflaggedanimknoball("walkanim", var_0, % body, 1, 1, var_1, 1);

    dowalkanim_initnonforwardanim();
  } else if(self.a.pose == "prone")
    self setflaggedanimknob("walkanim", animscripts\utility::getmoveanim("prone"), 1, 0.3, self.moveplaybackrate);
  else {
    self setflaggedanimknoball("walkanim", var_0, % body, 1, 1, var_1, 1);
    dowalkanim_initnonforwardanim();
  }

  animscripts\notetracks::donotetracksfortime(0.2, "walkanim");
  animscripts\run::setshootwhilemoving(0);
}

dowalkanim_initnonforwardanim() {
  if(animscripts\stairs_utility::isonstairs()) {
    return;
  }
  animscripts\run::setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"), animscripts\utility::getmoveanim("move_l"), animscripts\utility::getmoveanim("move_r"));
  thread animscripts\run::setcombatstandmoveanimweights("walk");
}