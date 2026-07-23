/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\walk.gsc
**************************************/

movewalk() {
  var_0 = undefined;

  if(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > 4096) {
    var_0 = "stand";
  }
  var_1 = [[self.chooseposefunc]](var_0);

  switch (var_1) {
    case "stand":
      if(animscripts\setposemovement::beginstandwalk()) {
        return;
      }
      if(isDefined(self.walk_overrideanim)) {
        animscripts\move::movestandmoveoverride(self.walk_overrideanim, self.walk_override_weights);
        return;
      }

      dowalkanim(getwalkanim("straight"));
      break;
    case "crouch":
      if(animscripts\setposemovement::begincrouchwalk()) {
        return;
      }
      dowalkanim(getwalkanim("crouch"));
      break;
    default:
      if(animscripts\setposemovement::beginpronewalk()) {
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
  self clearanim(%combatrun, 0.6);
  self setanimknoball(%combatrun, %body, 1, 0.5, self.moveplaybackrate);

  if(isarray(self.walk_overrideanim)) {
    if(isDefined(self.walk_override_weights)) {
      var_1 = common_scripts\utility::choose_from_weighted_array(self.walk_overrideanim, self.walk_override_weights);
    } else {
      var_1 = self.walk_overrideanim[randomint(self.walk_overrideanim.size)];
    }
  } else {
    var_1 = self.walk_overrideanim;
  }
  self setflaggedanimknob("moveanim", var_1, 1, 0.2);
  animscripts\shared::donotetracks("moveanim");
}

getwalkanim(var_0) {
  if(self.stairsstate == "up") {
    return animscripts\utility::moveanim("stairs_up");
  } else if(self.stairsstate == "down") {
    return animscripts\utility::moveanim("stairs_down");
  }
  var_1 = animscripts\utility::moveanim(var_0);

  if(isarray(var_1)) {
    var_1 = var_1[randomint(var_1.size)];
  }
  return var_1;
}

dowalkanim(var_0) {
  self endon("movemode");
  var_1 = self.moveplaybackrate;

  if(self.stairsstate != "none") {
    var_1 = var_1 * 0.6;
  }
  if(self.a.pose == "stand") {
    if(isDefined(self.enemy)) {
      thread animscripts\cqb::cqbtracking();
      self setflaggedanimknoball("walkanim", animscripts\cqb::determinecqbanim(), %walk_and_run_loops, 1, 1, var_1, 1);
    } else {
      self setflaggedanimknoball("walkanim", var_0, %body, 1, 1, var_1, 1);
    }
    animscripts\run::setmovenonforwardanims(animscripts\utility::moveanim("move_b"), animscripts\utility::moveanim("move_l"), animscripts\utility::moveanim("move_r"));
    thread animscripts\run::setcombatstandmoveanimweights("walk");
  } else {
    self setflaggedanimknoball("walkanim", var_0, %body, 1, 1, var_1, 1);
    animscripts\run::setmovenonforwardanims(animscripts\utility::moveanim("move_b"), animscripts\utility::moveanim("move_l"), animscripts\utility::moveanim("move_r"));
    thread animscripts\run::setcombatstandmoveanimweights("walk");
  }

  animscripts\notetracks::donotetracksfortime(0.2, "walkanim");
  thread animscripts\run::stopshootwhilemovingthreads();
}