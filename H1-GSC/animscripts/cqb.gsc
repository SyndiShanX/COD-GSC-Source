/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\cqb.gsc
********************************/

#using_animtree("generic_human");

movecqb() {
  cqb_checkchangeweapon();

  if(self.a.pose != "stand") {
    self clearanim( % animscript_root, 0.2);

    if(self.a.pose == "prone")
      animscripts\utility::exitpronewrapper(1);

    self.a.pose = "stand";
  }

  self.a.movement = self.movemode;
  cqbtracking();
  self clearanim( % h1_stairs, 0.1);

  if(cqb_checkreload()) {
    return;
  }
  var_0 = determinecqbanim();
  var_1 = cqb_gettranstime();
  var_2 = 0.2;
  thread cqb_scaleforslowdown(var_0, var_2);
  cqb_animate(var_0, var_2, var_1);
  cqb_playfacialanim(var_0);
  animscripts\notetracks::donotetracksfortime(var_2, "runanim");
}

cqb_checkchangeweapon() {
  if(!animscripts\stairs_utility::isonstairs())
    animscripts\run::standrun_checkchangeweapon();
}

cqb_checkreload() {
  return !animscripts\stairs_utility::isonstairs() && animscripts\run::standrun_checkreload();
}

cqb_gettranstime() {
  var_0 = animscripts\stairs_utility::getstairtransitionfinishedthisframe();

  if(var_0 == "none" && !animscripts\stairs_utility::isonstairs())
    return 0.3;
  else
    return 0.1;
}

cqb_animate(var_0, var_1, var_2) {
  if(isdefined(self.timeofmaincqbupdate))
    var_3 = self.timeofmaincqbupdate;
  else
    var_3 = 0;

  self.timeofmaincqbupdate = gettime();

  if(!animscripts\stairs_utility::isonstairs()) {
    var_4 = animscripts\stairs_utility::getstairtransitionfinishedthisframe();
    var_5 = % walk_and_run_loops;

    if(self.timeofmaincqbupdate - var_3 > var_1 * 1000 && var_4 == "none")
      var_5 = % stand_and_crouch;

    self setflaggedanimknoball("runanim", var_0, var_5, 1, var_2, self.moveplaybackrate * self.cqb_slowdown_scale, 1);
    animscripts\run::setmovenonforwardanims(animscripts\utility::lookupanim("cqb", "move_b"), animscripts\utility::lookupanim("cqb", "move_l"), animscripts\utility::lookupanim("cqb", "move_r"));
    thread animscripts\run::setcombatstandmoveanimweights("cqb");
  } else {
    self notify("stop_move_anim_update");
    self.update_move_anim_type = undefined;
    var_5 = % body;
    self setflaggedanimknoball("runanim", var_0, var_5, 1, var_2, self.moveplaybackrate * self.cqb_slowdown_scale, 1);
  }
}

determinecqbanim() {
  if(isdefined(self.custommoveanimset) && isdefined(self.custommoveanimset["cqb"]))
    return animscripts\run::getrunanim();

  if(animscripts\stairs_utility::isonstairs()) {
    var_0 = animscripts\stairs_utility::getstairsanimnameatgroundpos();
    return animscripts\utility::lookupanim("cqb", var_0);
  }

  if(self.movemode == "walk")
    return animscripts\utility::lookupanim("cqb", "move_f");

  if(isdefined(self.a.bdisablemovetwitch) && self.a.bdisablemovetwitch)
    return animscripts\utility::lookupanim("cqb", "straight");

  if(!isdefined(self.a.runloopcount))
    return animscripts\utility::lookupanim("cqb", "straight");

  var_1 = animscripts\utility::lookupanim("cqb", "straight_twitch");

  if(!isdefined(var_1) || var_1.size == 0)
    return animscripts\utility::lookupanim("cqb", "straight");

  var_2 = animscripts\utility::getrandomintfromseed(self.a.runloopcount, 4);

  if(var_2 == 0)
    return animscripts\utility::gettwitchanim(var_1);

  return animscripts\utility::lookupanim("cqb", "straight");
}

cqb_reloadinternal() {
  self endon("movemode");
  self endon("should_stairs_transition");
  self orientmode("face motion");
  var_0 = "reload_" + animscripts\combat_utility::getuniqueflagnameindex();
  var_1 = animscripts\utility::lookupanim("cqb", "reload");

  if(isarray(var_1))
    var_1 = var_1[randomint(var_1.size)];

  thread cqb_scaleforslowdown(var_1, getanimlength(var_1));
  self setflaggedanimknoballrestart(var_0, var_1, % body, 1, 0.25, self.moveplaybackrate * self.cqb_slowdown_scale);
  cqb_playfacialanim(var_1);
  animscripts\run::setmovenonforwardanims(animscripts\utility::lookupanim("cqb", "move_b"), animscripts\utility::lookupanim("cqb", "move_l"), animscripts\utility::lookupanim("cqb", "move_r"));
  thread animscripts\run::setcombatstandmoveanimweights("cqb");
  childthread animscripts\stairs_utility::threadcheckstairstransition(var_1, 0, 0.3);
  animscripts\shared::donotetracks(var_0);
  self notify("killThreadCheckStairsTransition");
}

cqbtracking() {
  var_0 = animscripts\stairs_utility::isonstairs();
  var_1 = !var_0 && animscripts\move::mayshootwhilemoving();
  animscripts\run::setshootwhilemoving(var_1);

  if(var_0)
    animscripts\run::endfaceenemyaimtracking();
  else
    thread animscripts\run::faceenemyaimtracking();
}

setupcqbpointsofinterest() {
  level.cqbpointsofinterest = [];
  var_0 = getentarray("cqb_point_of_interest", "targetname");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    level.cqbpointsofinterest[var_1] = var_0[var_1].origin;
    var_0[var_1] delete();
  }
}

findcqbpointsofinterest() {
  if(isdefined(anim.findingcqbpointsofinterest)) {
    return;
  }
  anim.findingcqbpointsofinterest = 1;

  if(!level.cqbpointsofinterest.size) {
    return;
  }
  for (;;) {
    var_0 = getaiarray();
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(isalive(var_3) && var_3 animscripts\utility::iscqbwalking() && !isdefined(var_3.disable_cqb_points_of_interest)) {
        var_4 = var_3.a.movement != "stop";
        var_5 = (var_3.origin[0], var_3.origin[1], var_3 getshootatpos()[2]);
        var_6 = var_5;
        var_7 = anglestoforward(var_3.angles);

        if(var_4) {
          var_8 = bullettrace(var_6, var_6 + var_7 * 128, 0, undefined);
          var_6 = var_8["position"];
        }

        var_9 = -1;
        var_10 = 1048576;

        for (var_11 = 0; var_11 < level.cqbpointsofinterest.size; var_11++) {
          var_12 = level.cqbpointsofinterest[var_11];
          var_13 = distancesquared(var_12, var_6);

          if(var_13 < var_10) {
            if(var_4) {
              if(distancesquared(var_12, var_5) < 4096) {
                continue;
              }
              var_14 = vectordot(vectornormalize(var_12 - var_5), var_7);

              if(var_14 < 0.643 || var_14 > 0.966)
                continue;
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

        if(var_9 < 0)
          var_3.cqb_point_of_interest = undefined;
        else
          var_3.cqb_point_of_interest = level.cqbpointsofinterest[var_9];

        wait 0.05;
        var_1 = 1;
      }
    }

    if(!var_1)
      wait 0.25;
  }
}

cqb_playfacialanim(var_0) {
  self.facialidx = animscripts\face::playfacialanim(var_0, "run", self.facialidx);
}

cqb_clearfacialanim() {
  self.facialidx = undefined;
  self clearanim( % head, 0.2);
}

cqb_scaleforslowdown(var_0, var_1) {
  self.cqb_slowdown_anim = var_0;
  self.cqb_slowdown_move_time = var_1;

  if(isdefined(self.cqb_slowdown_watcher_running)) {
    return;
  }
  self.cqb_slowdown_watcher_running = 1;
  thread cqb_slowdownwatcher_ender();
  cqb_slowdownwatcher();
  self.cqb_slowdown_watcher_running = undefined;
}

cqb_slowdownwatcher() {
  self notify("end_cqb_slowdown_watcher");
  self endon("death");
  self endon("killanimscript");
  self endon("move_interrupt");
  self endon("end_cqb_slowdown_watcher");

  if(isdefined(self.cqb_slowdown_scale) && self.cqb_slowdown_scale != 1)
    self waittill("slow_down_stop");

  for (;;) {
    cqb_slowdownscale(1);
    self waittill("slow_down_start");
    cqb_slowdownscale(0.75);
    self waittill("slow_down_stop");
  }
}

cqb_slowdownscale(var_0) {
  self.cqb_slowdown_scale = var_0;
  self setanimrate(self.cqb_slowdown_anim, self.moveplaybackrate * self.cqb_slowdown_scale);
}

cqb_slowdownwatcher_ender() {
  self endon("death");
  self endon("killanimscript");
  self endon("move_interrupt");
  wait(self.cqb_slowdown_move_time);

  while (animscripts\utility::shouldcqb())
    wait(self.cqb_slowdown_move_time);

  self notify("end_cqb_slowdown_watcher");
}