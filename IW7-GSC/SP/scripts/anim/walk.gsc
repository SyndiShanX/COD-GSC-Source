/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\walk.gsc
**************************************/

_id_BD2B() {
  var_0 = undefined;

  if(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > 4096)
    var_0 = "stand";

  var_1 = [[self._id_3EF3]](var_0);

  switch (var_1) {
    case "stand":
      if(scripts\anim\setposemovement::_id_10B84()) {
        return;
      }
      if(isDefined(self._id_13872)) {
        scripts\anim\move::_id_BCF8(self._id_13872, self._id_13871);
        return;
      }

      _id_5AEB(_id_820B("straight"));
      break;
    case "crouch":
      if(scripts\anim\setposemovement::_id_4AB1()) {
        return;
      }
      _id_5AEB(_id_820B("crouch"));
      break;
    default:
      if(scripts\anim\setposemovement::_id_DA91()) {
        return;
      }
      self.a.movement = "walk";
      _id_5AEB(_id_820B("prone"));
      break;
  }
}

#using_animtree("generic_human");

_id_5AEC(var_0) {
  self endon("movemode");
  self clearanim(%combatrun, 0.6);
  self _meth_82A5(%combatrun, %body, 1, 0.5, self.moveplaybackrate);

  if(isarray(self._id_13872)) {
    if(isDefined(self._id_13871))
      var_1 = scripts\engine\utility::choose_from_weighted_array(self._id_13872, self._id_13871);
    else
      var_1 = self._id_13872[randomint(self._id_13872.size)];
  } else
    var_1 = self._id_13872;

  self _meth_82E2("moveanim", var_1, 1, 0.2);
  scripts\anim\shared::donotetracks("moveanim");
}

_id_820B(var_0) {
  if(self.stairsstate == "up")
    return scripts\anim\utility::_id_7FCC("stairs_up");
  else if(self.stairsstate == "down")
    return scripts\anim\utility::_id_7FCC("stairs_down");

  var_1 = scripts\anim\utility::_id_7FCC(var_0);

  if(isarray(var_1))
    var_1 = var_1[randomint(var_1.size)];

  return var_1;
}

_id_5AEB(var_0) {
  self endon("movemode");
  var_1 = self.moveplaybackrate;

  if(self.stairsstate != "none")
    var_1 = var_1 * 0.6;

  if(self.a.pose == "stand") {
    if(isDefined(self.enemy)) {
      scripts\anim\cqb::_id_479B();
      self _meth_82E3("walkanim", scripts\anim\cqb::_id_53C3(), %walk_and_run_loops, 1, 1, var_1, 1);
    } else
      self _meth_82E3("walkanim", var_0, %body, 1, 1, var_1, 1);

    scripts\anim\run::_id_F7A9(scripts\anim\utility::_id_7FCC("move_b"), scripts\anim\utility::_id_7FCC("move_l"), scripts\anim\utility::_id_7FCC("move_r"));
    thread scripts\anim\run::setcombatstandmoveanimweights("walk");
  } else if(self.a.pose == "prone")
    self _meth_82E2("walkanim", scripts\anim\utility::_id_7FCC("prone"), 1, 0.3, self.moveplaybackrate);
  else {
    self _meth_82E3("walkanim", var_0, %body, 1, 1, var_1, 1);
    scripts\anim\run::_id_F7A9(scripts\anim\utility::_id_7FCC("move_b"), scripts\anim\utility::_id_7FCC("move_l"), scripts\anim\utility::_id_7FCC("move_r"));
    thread scripts\anim\run::setcombatstandmoveanimweights("walk");
  }

  scripts\anim\notetracks::donotetracksfortime(0.2, "walkanim");
  scripts\anim\run::_id_F843(0);
}