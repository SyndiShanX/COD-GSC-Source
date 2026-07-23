/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\walk.gsc
**************************************/

_id_107F() {
  var_0 = undefined;

  if(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > 4096) {
    var_0 = "stand";
  }
  var_1 = [[self._id_0FBA]](var_0);

  switch (var_1) {
    case "stand":
      if(animscripts\setposemovement::_id_1080()) {
        return;
      }
      if(isDefined(self._id_1081)) {
        animscripts\move::_id_0FBE(self._id_1081, self._id_1082);
        return;
      }

      _id_1087(_id_1086("straight"));
      break;
    case "crouch":
      if(animscripts\setposemovement::_id_1083()) {
        return;
      }
      _id_1087(_id_1086("crouch"));
      break;
    default:
      if(animscripts\setposemovement::_id_1084()) {
        return;
      }
      self.a._id_0D2B = "walk";
      _id_1087(_id_1086("prone"));
      break;
  }
}

#using_animtree("generic_human");

_id_1085(var_0) {
  self endon("movemode");
  self clearanim(%combatrun, 0.6);
  self setanimknoball(%combatrun, %body, 1, 0.5, self._id_0FC6);

  if(isarray(self._id_1081)) {
    if(isDefined(self._id_1082)) {
      var_1 = common_scripts\utility::choose_from_weighted_array(self._id_1081, self._id_1082);
    } else {
      var_1 = self._id_1081[randomint(self._id_1081.size)];
    }
  } else {
    var_1 = self._id_1081;
  }
  self setflaggedanimknob("moveanim", var_1, 1, 0.2);
  animscripts\shared::_id_0C51("moveanim");
}

_id_1086(var_0) {
  if(self.stairsstate == "up") {
    return animscripts\utility::_id_0FC3("stairs_up");
  } else if(self.stairsstate == "down") {
    return animscripts\utility::_id_0FC3("stairs_down");
  }
  var_1 = animscripts\utility::_id_0FC3(var_0);

  if(isarray(var_1)) {
    var_1 = var_1[randomint(var_1.size)];
  }
  return var_1;
}

_id_1087(var_0) {
  self endon("movemode");
  var_1 = self._id_0FC6;

  if(self.stairsstate != "none") {
    var_1 = var_1 * 0.6;
  }
  if(self.a._id_0D26 == "stand") {
    if(isDefined(self.enemy)) {
      thread animscripts\cqb::_id_1079();
      self setflaggedanimknoball("walkanim", animscripts\cqb::_id_1076(), %walk_and_run_loops, 1, 1, var_1, 1);
    } else {
      self setflaggedanimknoball("walkanim", var_0, %body, 1, 1, var_1, 1);
    }
    animscripts\run::_id_0FF7(animscripts\utility::_id_0FC3("move_b"), animscripts\utility::_id_0FC3("move_l"), animscripts\utility::_id_0FC3("move_r"));
    thread animscripts\run::_id_0FF8("walk");
  } else {
    self setflaggedanimknoball("walkanim", var_0, %body, 1, 1, var_1, 1);
    animscripts\run::_id_0FF7(animscripts\utility::_id_0FC3("move_b"), animscripts\utility::_id_0FC3("move_l"), animscripts\utility::_id_0FC3("move_r"));
    thread animscripts\run::_id_0FF8("walk");
  }

  animscripts\notetracks::_id_0D4F(0.2, "walkanim");
  thread animscripts\run::_id_0FE5();
}