/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\cqb.gsc
*********************************************/

func_BCB1() {
  scripts\anim\run::func_10B77();
  if(self.a.pose != "stand") {
    self clearanim(%root, 0.2);
    if(self.a.pose == "prone") {
      scripts\anim\utility::exitpronewrapper(1);
    }

    self.a.pose = "stand";
  }

  self.a.movement = self.synctransients;
  func_479B();
  if(scripts\anim\run::func_BC1D()) {
    return;
  }

  self clearanim(%stair_transitions, 0.2);
  if(scripts\anim\run::func_10B78()) {
    return;
  }

  if(isDefined(self.timeoflaststatechange)) {
    var_0 = self.timeoflaststatechange;
  } else {
    var_0 = 0;
  }

  self.timeoflaststatechange = gettime();
  var_1 = func_53C3();
  if(self.getcsplinepointtargetname == "none") {
    var_2 = 0.3;
  } else {
    var_2 = 0.1;
  }

  var_3 = 0.2;
  var_4 = % walk_and_run_loops;
  if(self.timeoflaststatechange - var_0 > var_3 * 1000) {
    var_4 = % stand_and_crouch;
  }

  self func_82E3("runanim", var_1, var_4, 1, var_2, self.moveplaybackrate, 1);
  func_478E(var_1);
  scripts\anim\run::func_F7A9(scripts\anim\utility::func_B027("cqb", "move_b"), scripts\anim\utility::func_B027("cqb", "move_l"), scripts\anim\utility::func_B027("cqb", "move_r"));
  thread scripts\anim\run::setcombatstandmoveanimweights("cqb");
  scripts\anim\notetracks::donotetracksfortime(var_3, "runanim");
}

func_53C3() {
  if(isDefined(self.custommoveanimset) && isDefined(self.custommoveanimset["cqb"])) {
    return scripts\anim\run::getrunningforwardpainanim();
  }

  if(self.getcsplinepointtargetname == "up") {
    return scripts\anim\utility::func_B027("cqb", "stairs_up");
  }

  if(self.getcsplinepointtargetname == "down") {
    return scripts\anim\utility::func_B027("cqb", "stairs_down");
  }

  if(self.synctransients == "walk") {
    return scripts\anim\utility::func_B027("cqb", "move_f");
  }

  if(isDefined(self.a.var_29CE) && self.a.var_29CE) {
    return scripts\anim\utility::func_B027("cqb", "straight");
  }

  var_0 = scripts\anim\utility::func_B027("cqb", "straight_twitch");
  if(!isDefined(var_0) || var_0.size == 0) {
    return scripts\anim\utility::func_B027("cqb", "straight");
  }

  var_1 = scripts\anim\utility::setclientextrasuper(self.a.var_E860, 4);
  if(var_1 == 0) {
    var_2 = scripts\anim\utility::setclientextrasuper(self.a.var_E860, var_0.size);
    return var_0[var_2];
  }

  return scripts\anim\utility::func_B027("cqb", "straight");
}

func_4790() {
  self endon("movemode");
  self orientmode("face motion");
  var_0 = "reload_" + scripts\anim\combat_utility::func_81EB();
  var_1 = scripts\anim\utility::func_B027("cqb", "reload");
  if(isarray(var_1)) {
    var_1 = var_1[randomint(var_1.size)];
  }

  self func_82E4(var_0, var_1, %body, 1, 0.25);
  func_478E(var_1);
  scripts\anim\run::func_F7A9(scripts\anim\utility::func_B027("cqb", "move_b"), scripts\anim\utility::func_B027("cqb", "move_l"), scripts\anim\utility::func_B027("cqb", "move_r"));
  thread scripts\anim\run::setcombatstandmoveanimweights("cqb");
  scripts\anim\shared::donotetracks(var_0);
}

func_479B() {
  var_0 = self.getcsplinepointtargetname != "none";
  var_1 = !var_0 && scripts\anim\move::func_B4EC();
  scripts\anim\run::func_F843(var_1);
  if(var_0) {
    scripts\anim\run::func_6318();
    return;
  }

  thread scripts\anim\run::func_6A6B();
}

func_FA9F() {
  level.var_479A = [];
  var_0 = "cqb_point_of_interest";
  var_1 = getEntArray(var_0, "targetname");
  foreach(var_3 in var_1) {
    level.var_479A[level.var_479A.size] = var_3.origin;
    var_3 delete();
  }

  thread func_FAA0(var_0);
}

func_FAA0(var_0) {
  waittillframeend;
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");
  foreach(var_3 in var_1) {
    level.var_479A[level.var_479A.size] = var_3.origin;
    scripts\sp\utility::func_51D4(var_3);
  }
}

func_6CB4() {
  if(isDefined(level.var_6CB8)) {
    return;
  }

  anim.var_6CB8 = 1;
  waittillframeend;
  if(!level.var_479A.size) {
    return;
  }

  for(;;) {
    var_0 = getaiarray();
    var_1 = 0;
    foreach(var_3 in var_0) {
      if(isalive(var_3) && var_3 scripts\anim\utility::func_9D9B() && !isDefined(var_3.var_5512)) {
        var_4 = var_3.a.movement != "stop";
        var_5 = (var_3.origin[0], var_3.origin[1], var_3 getshootatpos()[2]);
        var_6 = var_5;
        var_7 = anglesToForward(var_3.angles);
        if(var_4) {
          var_8 = bulletTrace(var_6, var_6 + var_7 * 128, 0, undefined);
          var_6 = var_8["position"];
        }

        var_9 = -1;
        var_10 = 1048576;
        for(var_11 = 0; var_11 < level.var_479A.size; var_11++) {
          var_12 = level.var_479A[var_11];
          var_13 = distancesquared(var_12, var_6);
          if(var_13 < var_10) {
            if(var_4) {
              if(distancesquared(var_12, var_5) < 4096) {
                continue;
              }

              var_14 = vectordot(vectornormalize(var_12 - var_5), var_7);
              if(var_14 < 0.643 || var_14 > 0.966) {
                continue;
              }
            } else if(var_13 < 2500) {
              continue;
            }

            if(!sighttracepassed(var_6, var_12, 0, undefined)) {
              continue;
            }

            var_10 = var_13;
            var_9 = var_11;
          }
        }

        if(var_9 < 0) {
          var_3.var_478F = undefined;
        } else {
          var_3.var_478F = level.var_479A[var_9];
        }

        wait(0.05);
        var_1 = 1;
      }
    }

    if(!var_1) {
      wait(0.25);
    }
  }
}

func_478E(var_0) {
  self.facialidx = scripts\anim\face::playfacialanim(var_0, "run", self.facialidx);
}

func_4789() {
  self.facialidx = undefined;
  self clearanim(%head, 0.2);
}