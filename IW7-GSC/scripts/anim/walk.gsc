/*********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\walk.gsc
*********************************/

func_BD2B() {
  var_00 = undefined;
  if(isDefined(self.vehicle_getspawnerarray) && distancesquared(self.origin, self.vehicle_getspawnerarray) > 4096) {
    var_00 = "stand";
  }

  var_01 = [[self.var_3EF3]](var_00);
  switch (var_01) {
    case "stand":
      if(scripts\anim\setposemovement::func_10B84()) {
        return;
      }

      if(isDefined(self.var_13872)) {
        scripts\anim\move::func_BCF8(self.var_13872, self.var_13871);
        return;
      }

      func_5AEB(movegravity("straight"));
      break;

    case "crouch":
      if(scripts\anim\setposemovement::func_4AB1()) {
        return;
      }

      func_5AEB(movegravity("crouch"));
      break;

    default:
      if(scripts\anim\setposemovement::func_DA91()) {
        return;
      }

      self.a.movement = "walk";
      func_5AEB(movegravity("prone"));
      break;
  }
}

func_5AEC(param_00) {
  self endon("movemode");
  self clearanim( % combatrun, 0.6);
  self _meth_82A5( % combatrun, % body, 1, 0.5, self.moveplaybackrate);
  if(isarray(self.var_13872)) {
    if(isDefined(self.var_13871)) {
      var_01 = scripts\engine\utility::choose_from_weighted_array(self.var_13872, self.var_13871);
    } else {
      var_01 = self.var_13872[randomint(self.var_13872.size)];
    }
  } else {
    var_01 = self.var_13872;
  }

  self give_left_powers("moveanim", var_01, 1, 0.2);
  scripts\anim\shared::donotetracks("moveanim");
}

movegravity(param_00) {
  if(self.getcsplinepointtargetname == "up") {
    return scripts\anim\utility::func_7FCC("stairs_up");
  } else if(self.getcsplinepointtargetname == "down") {
    return scripts\anim\utility::func_7FCC("stairs_down");
  }

  var_01 = scripts\anim\utility::func_7FCC(param_00);
  if(isarray(var_01)) {
    var_01 = var_01[randomint(var_01.size)];
  }

  return var_01;
}

func_5AEB(param_00) {
  self endon("movemode");
  var_01 = self.moveplaybackrate;
  if(self.getcsplinepointtargetname != "none") {
    var_01 = var_01 * 0.6;
  }

  if(self.a.pose == "stand") {
    if(isDefined(self.isnodeoccupied)) {
      scripts\anim\cqb::func_479B();
      self _meth_82E3("walkanim", scripts\anim\cqb::func_53C3(), % walk_and_run_loops, 1, 1, var_01, 1);
    } else {
      self _meth_82E3("walkanim", param_00, % body, 1, 1, var_01, 1);
    }

    scripts\anim\run::func_F7A9(scripts\anim\utility::func_7FCC("move_b"), scripts\anim\utility::func_7FCC("move_l"), scripts\anim\utility::func_7FCC("move_r"));
    thread scripts\anim\run::setcombatstandmoveanimweights("walk");
  } else if(self.a.pose == "prone") {
    self give_left_powers("walkanim", scripts\anim\utility::func_7FCC("prone"), 1, 0.3, self.moveplaybackrate);
  } else {
    self _meth_82E3("walkanim", param_00, % body, 1, 1, var_01, 1);
    scripts\anim\run::func_F7A9(scripts\anim\utility::func_7FCC("move_b"), scripts\anim\utility::func_7FCC("move_l"), scripts\anim\utility::func_7FCC("move_r"));
    thread scripts\anim\run::setcombatstandmoveanimweights("walk");
  }

  scripts\anim\notetracks::donotetracksfortime(0.2, "walkanim");
  scripts\anim\run::func_F843(0);
}