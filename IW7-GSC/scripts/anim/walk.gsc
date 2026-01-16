/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\walk.gsc
*********************************************/

func_BD2B() {
  var_0 = undefined;
  if(isDefined(self.vehicle_getspawnerarray) && distancesquared(self.origin, self.vehicle_getspawnerarray) > 4096) {
    var_0 = "stand";
  }

  var_1 = [[self.var_3EF3]](var_0);
  switch (var_1) {
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

func_5AEC(var_0) {
  self endon("movemode");
  self clearanim( % combatrun, 0.6);
  self func_82A5( % combatrun, % body, 1, 0.5, self.moveplaybackrate);
  if(isarray(self.var_13872)) {
    if(isDefined(self.var_13871)) {
      var_1 = scripts\engine\utility::choose_from_weighted_array(self.var_13872, self.var_13871);
    } else {
      var_1 = self.var_13872[randomint(self.var_13872.size)];
    }
  } else {
    var_1 = self.var_13872;
  }

  self give_left_powers("moveanim", var_1, 1, 0.2);
  scripts\anim\shared::donotetracks("moveanim");
}

movegravity(var_0) {
  if(self.getcsplinepointtargetname == "up") {
    return scripts\anim\utility::func_7FCC("stairs_up");
  } else if(self.getcsplinepointtargetname == "down") {
    return scripts\anim\utility::func_7FCC("stairs_down");
  }

  var_1 = scripts\anim\utility::func_7FCC(var_0);
  if(isarray(var_1)) {
    var_1 = var_1[randomint(var_1.size)];
  }

  return var_1;
}

func_5AEB(var_0) {
  self endon("movemode");
  var_1 = self.moveplaybackrate;
  if(self.getcsplinepointtargetname != "none") {
    var_1 = var_1 * 0.6;
  }

  if(self.a.pose == "stand") {
    if(isDefined(self.enemy)) {
      scripts\anim\cqb::func_479B();
      self func_82E3("walkanim", scripts\anim\cqb::func_53C3(), % walk_and_run_loops, 1, 1, var_1, 1);
    } else {
      self func_82E3("walkanim", var_0, % body, 1, 1, var_1, 1);
    }

    scripts\anim\run::func_F7A9(scripts\anim\utility::func_7FCC("move_b"), scripts\anim\utility::func_7FCC("move_l"), scripts\anim\utility::func_7FCC("move_r"));
    thread scripts\anim\run::setcombatstandmoveanimweights("walk");
  } else if(self.a.pose == "prone") {
    self give_left_powers("walkanim", scripts\anim\utility::func_7FCC("prone"), 1, 0.3, self.moveplaybackrate);
  } else {
    self func_82E3("walkanim", var_0, % body, 1, 1, var_1, 1);
    scripts\anim\run::func_F7A9(scripts\anim\utility::func_7FCC("move_b"), scripts\anim\utility::func_7FCC("move_l"), scripts\anim\utility::func_7FCC("move_r"));
    thread scripts\anim\run::setcombatstandmoveanimweights("walk");
  }

  scripts\anim\notetracks::donotetracksfortime(0.2, "walkanim");
  scripts\anim\run::func_F843(0);
}