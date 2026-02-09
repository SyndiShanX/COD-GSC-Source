/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cqb.gsc
**************************************/

#using_animtree("generic_human");

_id_1075() {
  animscripts\run::_id_0FFD();

  if(self.a._id_0D26 != "stand") {
    self clearanim(%root, 0.2);

    if(self.a._id_0D26 == "prone") {
      animscripts\utility::_id_0F7D(1);
    }
    self.a._id_0D26 = "stand";
  }

  self.a._id_0D2B = self.movemode;
  thread _id_1079();
  var_0 = _id_1076();
  var_1 = self._id_0FC6;

  if(self.movemode == "walk") {
    var_1 = var_1 * 0.6;
  }
  if(self.stairsstate == "none") {
    var_2 = 0.3;
  } else {
    var_2 = 0.1;
  }
  self setflaggedanimknoball("runanim", var_0, %walk_and_run_loops, 1, var_2, var_1, 1);
  animscripts\run::_id_0FF7(%walk_backward, %walk_left, %walk_right);
  thread animscripts\run::_id_0FF8("cqb");
  animscripts\notetracks::_id_0D4F(0.2, "runanim");
  thread animscripts\run::_id_0FE5();
}

_id_1076() {
  if(isDefined(self._id_0C88) && isDefined(self._id_0C88["cqb"])) {
    return animscripts\run::_id_0FC2();
  }
  if(self.stairsstate == "up") {
    return % traverse_stair_run;
  }
  if(self.stairsstate == "down") {
    return % traverse_stair_run_down_01;
  }
  if(self.movemode == "walk") {
    return % walk_cqb_f;
  }
  var_0 = animscripts\utility::_id_1078(self.a._id_1077, 2);

  if(var_0 == 0) {
    return % run_cqb_f_search_v1;
  }
  return % run_cqb_f_search_v2;
}

_id_1079() {
  if(animscripts\move::_id_0FDE()) {
    animscripts\run::_id_0FE3();
  }
  animscripts\run::_id_0FE1();
}

_id_107A() {
  level._id_107B = [];
  var_0 = getEntArray("cqb_point_of_interest", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    level._id_107B[var_1] = var_0[var_1].origin;
    var_0[var_1] delete();
  }
}

_id_107C() {
  if(isDefined(anim._id_107D)) {
    return;
  }
  anim._id_107D = 1;

  if(!level._id_107B.size) {
    return;
  }
  for(;;) {
    var_0 = getaiarray();
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(isalive(var_3) && var_3 animscripts\utility::_id_0C98() && !isDefined(var_3._id_107E)) {
        var_4 = var_3.a._id_0D2B != "stop";
        var_5 = (var_3.origin[0], var_3.origin[1], var_3 getshootatpos()[2]);
        var_6 = var_5;
        var_7 = anglesToForward(var_3.angles);

        if(var_4) {
          var_8 = bulletTrace(var_6, var_6 + var_7 * 128, 0, undefined);
          var_6 = var_8["position"];
        }

        var_9 = -1;
        var_10 = 1048576;

        for(var_11 = 0; var_11 < level._id_107B.size; var_11++) {
          var_12 = level._id_107B[var_11];
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
          var_3._id_0CB9 = undefined;
        } else {
          var_3._id_0CB9 = level._id_107B[var_9];
        }
        wait 0.05;
        var_1 = 1;
      }
    }

    if(!var_1) {
      wait 0.25;
    }
  }
}