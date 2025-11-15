/********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\cqb.gsc
********************************/

func_BCB1() {
  scripts\anim\run::func_10B77();
  if(self.a.pose != "stand") {
    self clearanim( % root, 0.2);
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

  self clearanim( % stair_transitions, 0.2);
  if(scripts\anim\run::func_10B78()) {
    return;
  }

  if(isDefined(self.timeoflaststatechange)) {
    var_00 = self.timeoflaststatechange;
  } else {
    var_00 = 0;
  }

  self.timeoflaststatechange = gettime();
  var_01 = func_53C3();
  if(self.getcsplinepointtargetname == "none") {
    var_02 = 0.3;
  } else {
    var_02 = 0.1;
  }

  var_03 = 0.2;
  var_04 = % walk_and_run_loops;
  if(self.timeoflaststatechange - var_00 > var_03 * 1000) {
    var_04 = % stand_and_crouch;
  }

  self _meth_82E3("runanim", var_01, var_04, 1, var_02, self.moveplaybackrate, 1);
  func_478E(var_01);
  scripts\anim\run::func_F7A9(scripts\anim\utility::func_B027("cqb", "move_b"), scripts\anim\utility::func_B027("cqb", "move_l"), scripts\anim\utility::func_B027("cqb", "move_r"));
  thread scripts\anim\run::setcombatstandmoveanimweights("cqb");
  scripts\anim\notetracks::donotetracksfortime(var_03, "runanim");
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

  var_00 = scripts\anim\utility::func_B027("cqb", "straight_twitch");
  if(!isDefined(var_00) || var_00.size == 0) {
    return scripts\anim\utility::func_B027("cqb", "straight");
  }

  var_01 = scripts\anim\utility::setclientextrasuper(self.a.var_E860, 4);
  if(var_01 == 0) {
    var_02 = scripts\anim\utility::setclientextrasuper(self.a.var_E860, var_00.size);
    return var_00[var_02];
  }

  return scripts\anim\utility::func_B027("cqb", "straight");
}

func_4790() {
  self endon("movemode");
  self orientmode("face motion");
  var_00 = "reload_" + scripts\anim\combat_utility::_meth_81EB();
  var_01 = scripts\anim\utility::func_B027("cqb", "reload");
  if(isarray(var_01)) {
    var_01 = var_01[randomint(var_01.size)];
  }

  self _meth_82E4(var_00, var_01, % body, 1, 0.25);
  func_478E(var_01);
  scripts\anim\run::func_F7A9(scripts\anim\utility::func_B027("cqb", "move_b"), scripts\anim\utility::func_B027("cqb", "move_l"), scripts\anim\utility::func_B027("cqb", "move_r"));
  thread scripts\anim\run::setcombatstandmoveanimweights("cqb");
  scripts\anim\shared::donotetracks(var_00);
}

func_479B() {
  var_00 = self.getcsplinepointtargetname != "none";
  var_01 = !var_00 && scripts\anim\move::func_B4EC();
  scripts\anim\run::func_F843(var_01);
  if(var_00) {
    scripts\anim\run::func_6318();
    return;
  }

  thread scripts\anim\run::func_6A6B();
}

func_FA9F() {
  level.var_479A = [];
  var_00 = "cqb_point_of_interest";
  var_01 = getEntArray(var_00, "targetname");
  foreach(var_03 in var_01) {
    level.var_479A[level.var_479A.size] = var_03.origin;
    var_03 delete();
  }

  thread func_FAA0(var_00);
}

func_FAA0(param_00) {
  waittillframeend;
  var_01 = scripts\engine\utility::getstructarray(param_00, "targetname");
  foreach(var_03 in var_01) {
    level.var_479A[level.var_479A.size] = var_03.origin;
    scripts\sp\utility::func_51D4(var_03);
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
    var_00 = getaiarray();
    var_01 = 0;
    foreach(var_03 in var_00) {
      if(isalive(var_03) && var_03 scripts\anim\utility::func_9D9B() && !isDefined(var_03.var_5512)) {
        var_04 = var_03.a.movement != "stop";
        var_05 = (var_03.origin[0], var_03.origin[1], var_03 getshootatpos()[2]);
        var_06 = var_05;
        var_07 = anglesToForward(var_03.angles);
        if(var_04) {
          var_08 = bulletTrace(var_06, var_06 + var_07 * 128, 0, undefined);
          var_06 = var_08["position"];
        }

        var_09 = -1;
        var_0A = 1048576;
        for(var_0B = 0; var_0B < level.var_479A.size; var_0B++) {
          var_0C = level.var_479A[var_0B];
          var_0D = distancesquared(var_0C, var_06);
          if(var_0D < var_0A) {
            if(var_04) {
              if(distancesquared(var_0C, var_05) < 4096) {
                continue;
              }

              var_0E = vectordot(vectornormalize(var_0C - var_05), var_07);
              if(var_0E < 0.643 || var_0E > 0.966) {
                continue;
              }
            } else if(var_0D < 2500) {
              continue;
            }

            if(!sighttracepassed(var_06, var_0C, 0, undefined)) {
              continue;
            }

            var_0A = var_0D;
            var_09 = var_0B;
          }
        }

        if(var_09 < 0) {
          var_03.var_478F = undefined;
        } else {
          var_03.var_478F = level.var_479A[var_09];
        }

        wait(0.05);
        var_01 = 1;
      }
    }

    if(!var_01) {
      wait(0.25);
    }
  }
}

func_478E(param_00) {
  self.facialidx = scripts\anim\face::playfacialanim(param_00, "run", self.facialidx);
}

func_4789() {
  self.facialidx = undefined;
  self clearanim( % head, 0.2);
}