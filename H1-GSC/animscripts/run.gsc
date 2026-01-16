/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\run.gsc
********************************/

moverun() {
  var_0 = [[self.chooseposefunc]]("stand");

  switch (var_0) {
    case "stand":
      if(animscripts\setposemovement::standrun_begin()) {
        return;
      }
      if(isdefined(self.run_overrideanim)) {
        animscripts\move::movestand_moveoverride(self.run_overrideanim, self.run_override_weights);
        return;
      }

      if(standrun_checkchangeweapon()) {
        return;
      }
      if(standrun_checkreload()) {
        return;
      }
      animscripts\utility::updateisincombattimer();

      if(animscripts\utility::isincombat())
        standrun_combatnormal();
      else
        standrun_noncombatnormal();

      break;
    case "crouch":
      if(animscripts\setposemovement::crouchrun_begin()) {
        return;
      }
      if(isdefined(self.crouchrun_combatanim))
        crouchrun_runoverride();
      else
        crouchrun_runnormal();

      break;
    default:
      if(animscripts\setposemovement::pronerun_begin()) {
        return;
      }
      pronecrawl();
      break;
  }
}

getrunanim() {
  if(!isdefined(self.a.moveanimset)) {
    var_0 = animscripts\utility::lookupanim("run", "straight");
    return var_0;
  }

  var_1 = animscripts\stairs_utility::isonstairs();

  if(!self.facemotion && !self shouldfacemotion()) {
    var_2 = abs(self getmotionangle());

    if(!var_1 || var_2 > 45) {
      var_0 = animscripts\utility::getmoveanim("move_f");
      return var_0;
    }
  }

  if(var_1) {
    var_3 = animscripts\stairs_utility::getstairsanimnameatgroundpos();
    var_0 = animscripts\utility::getmoveanim(var_3);
    return var_0;
  } else if(animscripts\utility::usingsmg()) {
    var_0 = animscripts\utility::getmoveanim("smg_straight");
    return var_0;
  }

  if(animscripts\utility::isincombat() || isdefined(self.noruntwitch) && self.noruntwitch || isdefined(self.a.bdisablemovetwitch) && self.a.bdisablemovetwitch) {
    var_0 = animscripts\utility::getmoveanim("straight");
    return var_0;
  }

  if(!isdefined(self.a.runloopcount))
    return animscripts\utility::getmoveanim("straight");

  var_4 = animscripts\utility::getmoveanim("straight_twitch");

  if(!isdefined(var_4) || var_4.size == 0) {
    var_0 = animscripts\utility::getmoveanim("straight");
    return var_0;
  }

  var_5 = animscripts\utility::getrandomintfromseed(self.a.runloopcount, 4);

  if(var_5 == 0) {
    var_0 = animscripts\utility::gettwitchanim(var_4);
    return var_0;
  }

  var_0 = animscripts\utility::getmoveanim("straight");
  return var_0;
}

getcrouchrunanim() {
  if(!isdefined(self.a.moveanimset)) {
    if(animscripts\utility::usingsmg())
      return animscripts\utility::lookupanim("smg_crouch_run", "crouch");
    else
      return animscripts\utility::lookupanim("run", "crouch");
  }

  return animscripts\utility::getmoveanim("crouch");
}

pronecrawl() {
  self.a.movement = "run";
  self setflaggedanimknob("runanim", animscripts\utility::getmoveanim("prone"), 1, 0.3, self.moveplaybackrate);
  run_clearfacialanim();
  animscripts\notetracks::donotetracksfortime(0.25, "runanim");
}

#using_animtree("generic_human");

initrunngun() {
  if(!isdefined(self.runngun)) {
    self notify("stop_move_anim_update");
    self.update_move_anim_type = undefined;
    self clearanim( % combatrun_backward, 0.2);
    self clearanim( % combatrun_right, 0.2);
    self clearanim( % combatrun_left, 0.2);
    self clearanim( % w_aim_2, 0.2);
    self clearanim( % w_aim_4, 0.2);
    self clearanim( % w_aim_6, 0.2);
    self clearanim( % w_aim_8, 0.2);
    self.runngun = 1;
  }
}

stoprunngun() {
  if(isdefined(self.runngun)) {
    self clearanim( % run_n_gun, 0.2);
    self.runngun = undefined;
  }

  return 0;
}

runngun(var_0) {
  if(var_0) {
    var_1 = getpredictedyawtoenemy(0.2);
    var_2 = var_1 < 0;
  } else {
    var_1 = 0;
    var_2 = self.runngunweight < 0;
  }

  var_3 = self.maxrunngunangle;
  var_4 = self.runnguntransitionpoint;
  var_5 = self.runngunincrement;

  if(!var_0 || squared(var_1) > var_3 * var_3) {
    self clearanim( % add_fire, 0);

    if(squared(self.runngunweight) < var_5 * var_5) {
      self.runngunweight = 0;
      self.runngun = undefined;
      return 0;
    } else if(self.runngunweight > 0)
      self.runngunweight = self.runngunweight - var_5;
    else
      self.runngunweight = self.runngunweight + var_5;
  } else {
    var_6 = var_1 / var_3;
    var_7 = var_6 - self.runngunweight;

    if(abs(var_7) < var_4 * 0.7)
      self.runngunweight = var_6;
    else if(var_7 > 0)
      self.runngunweight = self.runngunweight + var_5;
    else
      self.runngunweight = self.runngunweight - var_5;
  }

  initrunngun();
  runngun_animate(var_4, var_2);
  run_playfacialanim(undefined);
  self.a.allowedpartialreloadontheruntime = gettime() + 500;

  if(var_0 && isplayer(self.enemy))
    self updateplayersightaccuracy();

  return 1;
}

runngun_animate(var_0, var_1) {
  var_2 = 1 - var_1;
  var_3 = abs(self.runngunweight);
  var_4 = animscripts\utility::lookupanimarray("run_n_gun");

  if(animscripts\stairs_utility::isonstairs()) {
    var_5 = animscripts\stairs_utility::getstairsanimnameatgroundpos();
    var_6 = var_4[var_5];
    self clearanim( % body, 0.1);
    var_7 = animscripts\stairs_utility::getstairtransitionfinishedthisframe();

    if(var_7 == "in")
      var_8 = 0.1;
    else
      var_8 = 0.2;

    self.laststairrunngunanimplayed = var_6;
    self setflaggedanimknob("runanim", var_6, 1, var_8, 1, 1);
  } else {
    if(isdefined(self.laststairrunngunanimplayed)) {
      self clearanim(self.laststairrunngunanimplayed, 0.1);
      self.laststairrunngunanimplayed = undefined;
    }

    self clearanim( % h1_stairs, 0.1);

    if(var_3 > var_0) {
      var_9 = (var_3 - var_0) / var_0;
      var_9 = clamp(var_9, 0, 1);
      self clearanim(var_4["F"], 0.2);
      self setanimlimited(var_4["L"], (1.0 - var_9) * var_1, 0.2);
      self setanimlimited(var_4["R"], (1.0 - var_9) * var_2, 0.2);
      self setanimlimited(var_4["LB"], var_9 * var_1, 0.2);
      self setanimlimited(var_4["RB"], var_9 * var_2, 0.2);
    } else {
      var_9 = clamp(var_3 / var_0, 0, 1);
      self setanimlimited(var_4["F"], 1.0 - var_9, 0.2);
      self setanimlimited(var_4["L"], var_9 * var_1, 0.2);
      self setanimlimited(var_4["R"], var_9 * var_2, 0.2);

      if(var_0 < 1) {
        self clearanim(var_4["LB"], 0.2);
        self clearanim(var_4["RB"], 0.2);
      }
    }

    var_7 = animscripts\stairs_utility::getstairtransitionfinishedthisframe();

    if(var_7 != "none")
      var_8 = 0.1;
    else
      var_8 = 0.3;

    self setflaggedanimknob("runanim", % run_n_gun, 1, var_8, 0.8);
  }
}

runngun_backward() {
  initrunngun();
  var_0 = animscripts\utility::lookupanim("run_n_gun", "move_back");
  self setflaggedanimknob("runanim", var_0, 1, 0.3, 0.8);
  run_playfacialanim(var_0);

  if(isplayer(self.enemy))
    self updateplayersightaccuracy();

  animscripts\notetracks::donotetracksfortime(0.2, "runanim");
  self clearanim(var_0, 0.2);
}

reacttobulletsinterruptcheck() {
  self endon("killanimscript");

  for (;;) {
    wait 0.2;

    if(!isdefined(self.reactingtobullet)) {
      break;
    }

    if(!isdefined(self.pathgoalpos) || distancesquared(self.pathgoalpos, self.origin) < squared(80)) {
      endrunningreacttobullets();
      self notify("interrupt_react_to_bullet");
      break;
    }
  }
}

endrunningreacttobullets() {
  self orientmode("face default");
  self.reactingtobullet = undefined;
  self.requestreacttobullet = undefined;
}

runningreacttobullets() {
  if(isdefined(self.mech) && self.mech) {
    return;
  }
  endfaceenemyaimtracking();
  self endon("interrupt_react_to_bullet");
  self.reactingtobullet = 1;
  self orientmode("face motion");
  var_0 = animscripts\utility::lookupanimarray("running_react_to_bullets");
  var_1 = randomint(var_0.size);

  if(var_1 == anim.lastrunningreactanim)
    var_1 = (var_1 + 1) % var_0.size;

  anim.lastrunningreactanim = var_1;
  var_2 = var_0[var_1];
  self setflaggedanimknobrestart("reactanim", var_2, 1, 0.5, 1);
  run_playfacialanim(var_2);
  thread reacttobulletsinterruptcheck();
  animscripts\shared::donotetracks("reactanim");
  endrunningreacttobullets();
}

customrunningreacttobullets() {
  endfaceenemyaimtracking();
  self.reactingtobullet = 1;
  self orientmode("face motion");
  var_0 = randomint(self.run_overridebulletreact.size);
  var_1 = self.run_overridebulletreact[var_0];
  self setflaggedanimknobrestart("reactanim", var_1, 1, 0.5, 1.0);
  run_playfacialanim(var_1);
  thread reacttobulletsinterruptcheck();
  animscripts\shared::donotetracks("reactanim");
  endrunningreacttobullets();
}

getsprintanim() {
  var_0 = undefined;

  if(isdefined(self.grenade))
    var_0 = animscripts\utility::getmoveanim("sprint_short");

  if(!isdefined(var_0))
    var_0 = animscripts\utility::getmoveanim("sprint");

  return var_0;
}

shouldsprint() {
  if(isdefined(self.sprint))
    return 1;

  if(isdefined(self.grenade) && isdefined(self.enemy) && self.frontshieldanglecos == 1)
    return distancesquared(self.origin, self.enemy.origin) > 90000;

  return 0;
}

shouldsprintforvariation() {
  if(isdefined(self.neversprintforvariation))
    return 0;

  if(!self.facemotion || animscripts\stairs_utility::isonstairs())
    return 0;

  var_0 = gettime();

  if(isdefined(self.dangersprinttime)) {
    if(var_0 < self.dangersprinttime)
      return 1;

    if(var_0 - self.dangersprinttime < 6000)
      return 0;
  }

  if(!isdefined(self.enemy) || !issentient(self.enemy))
    return 0;

  if(randomint(100) < 25 && self lastknowntime(self.enemy) + 2000 > var_0) {
    self.dangersprinttime = var_0 + 2000 + randomint(1000);
    return 1;
  }

  return 0;
}

getmoveplaybackrate() {
  var_0 = self.moveplaybackrate;

  if(animscripts\stairs_utility::isonstairs())
    var_0 = 1;

  return var_0;
}

recentlydisabledcqb() {
  if(isdefined(self.cqbdisabledtime)) {
    var_0 = gettime() - self.cqbdisabledtime;
    return var_0 < 500;
  }

  return 0;
}

standrun_combatnormal() {
  var_0 = getmoveplaybackrate();
  var_1 = animscripts\stairs_utility::isonstairs();

  if(!var_1)
    self setanimknob( % combatrun, 1.0, 0.5, var_0);

  var_2 = 0;
  var_3 = !var_1 && isdefined(self.requestreacttobullet) && gettime() - self.requestreacttobullet < 100;
  var_4 = animscripts\utility::getreacttobulletchance();

  if(var_3 && randomfloat(1) < var_4) {
    stoprunngun();
    setshootwhilemoving(0);
    runningreacttobullets();
    return;
  }

  if(!var_1 && shouldsprint()) {
    var_5 = getsprintanim();
    self setflaggedanimknob("runanim", var_5, 1, 0.5, 1.0);
    run_playfacialanim(var_5);
    setshootwhilemoving(0);
    var_2 = 1;
  } else if(isdefined(self.enemy) && animscripts\move::mayshootwhilemoving()) {
    setshootwhilemoving(1);

    if(!var_1 && !self.facemotion)
      thread faceenemyaimtracking();
    else if(self.shootstyle != "none" && !isdefined(self.norunngun)) {
      endfaceenemyaimtracking();

      if(canshootwhilerunningforward())
        var_2 = runngun(1);
      else if(!var_1 && canshootwhilerunningbackward()) {
        runngun_backward();
        return;
      }
    } else if(isdefined(self.runngunweight) && self.runngunweight != 0)
      var_2 = runngun(0);
  } else if(isdefined(self.runngunweight) && self.runngunweight != 0) {
    setshootwhilemoving(0);
    var_2 = runngun(0);
  } else
    setshootwhilemoving(0);

  if(!var_2) {
    stoprunngun();
    var_4 = animscripts\utility::getreacttobulletchance();

    if(var_3 && var_4 != 0) {
      runningreacttobullets();
      return;
    }

    if(!var_1 && shouldsprintforvariation())
      var_6 = animscripts\utility::getmoveanim("sprint_short");
    else
      var_6 = getrunanim();

    if(recentlydisabledcqb())
      var_7 = 0.3;
    else
      var_7 = 0.1;

    standrun_combatnormal_animate(var_6, var_7);
  }

  animscripts\notetracks::donotetracksfortime(0.2, "runanim");
}

standrun_combatnormal_animate(var_0, var_1) {
  if(!animscripts\stairs_utility::isonstairs()) {
    self clearanim( % h1_stairs, var_1);
    self setflaggedanimknoblimited("runanim", var_0, 1, var_1, 1, 1);
    run_playfacialanim(var_0);
    setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"), animscripts\utility::getmoveanim("move_l"), animscripts\utility::getmoveanim("move_r"), self.sidesteprate);
    thread setcombatstandmoveanimweights("run");
  } else {
    self notify("stop_move_anim_update");
    self.update_move_anim_type = undefined;
    self clearanim( % body, var_1);
    self setflaggedanimknob("runanim", var_0, 1, var_1, 1, 1);
    run_playfacialanim(var_0);
  }
}

getstairstransitionanim(var_0, var_1, var_2) {
  if(!isdefined(var_0))
    var_0 = "none";

  if(var_0 == var_1)
    return undefined;

  var_3 = undefined;

  switch (var_0) {
    case "up":
      var_3 = "stairs_up_out";
      break;
    case "down":
      var_3 = "stairs_down_out";
      break;
    case "turn_L90":
      var_3 = "turn_90l_2_stairs_" + var_1;
      break;
    case "turn_R90":
      var_3 = "turn_90r_2_stairs_" + var_1;
      break;
    case "none":
      var_3 = "stairs_" + var_1 + "_in";
      break;
    default:
      break;
  }

  var_4 = isdefined(self.enemy) && animscripts\utility::isincombat() && !isdefined(self.norunngun) && canshootwhilerunningforward() && isdefined(self.shootstyle) && self.shootstyle != "none";
  var_3 = var_3 + "_" + var_2;

  if(animscripts\utility::shouldcqb())
    return animscripts\utility::lookupanim("cqb", var_3);
  else if(var_4)
    return animscripts\utility::lookupanim("run_n_gun", var_3);
  else if(isdefined(self.a.moveanimset))
    return animscripts\utility::getmoveanim(var_3);
  else
    return animscripts\utility::lookupanim("run", var_3);
}

faceenemyaimtracking() {
  if(isdefined(self.aim_while_moving_thread)) {
    return;
  }
  self.aim_while_moving_thread = 1;
  self endon("killanimscript");
  self endon("end_face_enemy_tracking");
  self setdefaultaimlimits();
  var_0 = undefined;

  if(isdefined(self.combatstandanims) && isdefined(self.combatstandanims["walk_aims"])) {
    self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_2"]);
    self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_4"]);
    self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_6"]);
    self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_8"]);
  } else {
    var_1 = "walk";

    if(animscripts\utility::shouldcqb() && isdefined(animscripts\utility::lookupanim("cqb", "aim_2")))
      var_1 = "cqb";

    var_2 = animscripts\utility::lookupanimarray(var_1);
    self setanimlimited(var_2["aim_2"]);
    self setanimlimited(var_2["aim_4"]);
    self setanimlimited(var_2["aim_6"]);
    self setanimlimited(var_2["aim_8"]);

    if(isdefined(var_2["aim_5"])) {
      self setanimlimited(var_2["aim_5"]);
      var_0 = % w_aim_5;
    }
  }

  animscripts\track::trackloop( % w_aim_2, % w_aim_4, % w_aim_6, % w_aim_8, var_0);
}

endfaceenemyaimtracking() {
  self.aim_while_moving_thread = undefined;
  self notify("end_face_enemy_tracking");
}

setshootwhilemoving(var_0) {
  var_1 = isdefined(self.bshootwhilemoving);

  if(var_0) {
    self.bshootwhilemoving = var_0;

    if(!var_1) {
      thread rundecidewhatandhowtoshoot();
      thread runshootwhilemoving();
    }
  } else {
    self.bshootwhilemoving = undefined;

    if(var_1) {
      self notify("end_shoot_while_moving");
      self notify("end_face_enemy_tracking");
      self.shoot_while_moving_thread = undefined;
      self.aim_while_moving_thread = undefined;
      self.runngun = undefined;
    }
  }
}

rundecidewhatandhowtoshoot() {
  self endon("killanimscript");
  self endon("end_shoot_while_moving");
  animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");
}

runshootwhilemoving() {
  self endon("killanimscript");
  self endon("end_shoot_while_moving");
  animscripts\move::shootwhilemoving();
}

aimedsomewhatatenemy() {
  if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
    var_0 = animscripts\combat_utility::get_last_known_shoot_pos(self.enemy);
  else
    var_0 = self.enemy getshootatpos();

  var_1 = self getmuzzleangle();
  var_2 = vectortoangles(var_0 - self getmuzzlepos());

  if(animscripts\utility::absangleclamp180(var_1[1] - var_2[1]) > 15)
    return 0;

  return animscripts\utility::absangleclamp180(var_1[0] - var_2[0]) <= 20;
}

canshootwhilerunningforward() {
  if((!isdefined(self.runngunweight) || self.runngunweight == 0) && abs(self getmotionangle()) > self.maxrunngunangle)
    return 0;

  return 1;
}

canshootwhilerunningbackward() {
  if(180 - abs(self getmotionangle()) >= 45)
    return 0;

  var_0 = getpredictedyawtoenemy(0.2);

  if(abs(var_0) > 30)
    return 0;

  return 1;
}

canshootwhilerunning() {
  return animscripts\move::mayshootwhilemoving() && isdefined(self.enemy) && (canshootwhilerunningforward() || canshootwhilerunningbackward());
}

getpredictedyawtoenemy(var_0) {
  var_1 = self.origin;
  var_2 = self.angles[1] + self getmotionangle();
  var_1 = var_1 + (cos(var_2), sin(var_2), 0) * length(self.velocity) * var_0;
  var_3 = self.angles[1] - vectortoyaw(self.enemy.origin - var_1);
  var_3 = angleclamp180(var_3);
  return var_3;
}

move_checkstairstransition() {
  if(!animscripts\stairs_utility::using_h1_stairs_system())
    return 0;

  if(isdefined(self.turntime) && self.turntime == gettime())
    return 0;

  var_0 = animscripts\move::getexpectedcurrentmoveanim();
  self.stairstransition = undefined;
  var_1 = animscripts\stairs_utility::getstairstransition(var_0["anim"], 1, var_0["updateTime"]);

  if(!isdefined(var_1))
    return 0;

  animscripts\stairs_utility::preparedetectedstairstransition();
  var_2 = var_1["transitionAnim"];

  if(!isdefined(var_2))
    return 0;

  self notify("stop_move_anim_update");
  self.update_move_anim_type = undefined;
  self.isinstairstransition = 1;
  var_3 = 1 / self.moveplaybackrate;
  var_4 = getnotetracktimes(var_2, "stair_edge");
  var_5 = getanimlength(var_2);

  if(isdefined(self.stairstransition["startTime"]))
    var_6 = var_4[0] - self.stairstransition["startTime"];
  else
    var_6 = var_4[0] * var_5 / var_3;

  var_7 = var_1["currentContext"];

  if(var_7 == "turn_L90" || var_7 == "turn_R90") {
    var_8 = var_6 * 0.85;
    self.ignorepathchange = 1;
  } else
    var_8 = min(var_6, 0.1);

  self clearanim( % body, var_8);
  self setflaggedanimknoballrestart("runanim", var_2, % body, 1, var_8, var_3);
  run_playfacialanim(var_2);

  if(isdefined(self.stairstransition["startTime"]))
    self setanimtime(var_2, self.stairstransition["startTime"]);

  var_9 = isdefined(var_1["inStairTransitionIn"]) && var_1["inStairTransitionIn"];
  var_10 = 0.05 * var_3 / var_5;
  childthread animscripts\stairs_utility::stairupdatepos(var_2, self.origin, self.stairstransition, var_4[0], var_9, var_10);
  thread animscripts\stairs_utility::waitforstairedge(var_2, var_4[0]);
  animscripts\shared::donotetracks("runanim");
  self.ignorepathchange = undefined;
  self.lastfinishedstairtransitiontime = gettime();

  if(var_9)
    self.lastfinishedstairtransitiontype = "in";
  else
    self.lastfinishedstairtransitiontype = "out";

  self.isinstairstransition = undefined;
  return 1;
}

standrun_noncombatnormal() {
  self endon("movemode");
  var_0 = animscripts\stairs_utility::isonstairs();

  if(!var_0)
    self clearanim( % combatrun, 0.6);
  else
    self clearanim( % body, 0.1);

  if(!var_0 && shouldsprint())
    var_1 = getsprintanim();
  else
    var_1 = getrunanim();

  var_2 = standrun_noncombatnormal_gettranstime();
  standrun_noncombatnormal_animate(var_1, var_2);
  var_3 = 0;

  if(self.leanamount > 0 && self.leanamount < 0.998)
    var_3 = 1;
  else if(self.leanamount < 0 && self.leanamount > -0.998)
    var_3 = -1;

  var_4 = max(0.2, var_2);
  animscripts\notetracks::donotetracksfortime(var_4, "runanim");
}

standrun_noncombatnormal_gettranstime() {
  var_0 = animscripts\stairs_utility::getstairtransitionfinishedthisframe();

  if(var_0 == "none" && !animscripts\stairs_utility::isonstairs())
    return 0.3;
  else
    return 0.1;
}

standrun_noncombatnormal_animate(var_0, var_1) {
  var_2 = animscripts\stairs_utility::isonstairs();
  var_3 = getmoveplaybackrate();

  if(!var_2) {
    self clearanim( % h1_stairs, 0.1);
    self setanimknoball( % combatrun, % body, 1, 0.2, var_3);
  }

  self setflaggedanimknob("runanim", var_0, 1, var_1, 1, 1);
  run_playfacialanim(var_0);

  if(!var_2) {
    setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"), animscripts\utility::getmoveanim("move_l"), animscripts\utility::getmoveanim("move_r"));
    thread setcombatstandmoveanimweights("run");
  } else {
    self notify("stop_move_anim_update");
    self.update_move_anim_type = undefined;
  }
}

crouchrun_runoverride() {
  self endon("movemode");
  self setflaggedanimknoball("runanim", self.crouchrun_combatanim, % body, 1, 0.4, self.moveplaybackrate);
  run_playfacialanim(self.crouchrun_combatanim);
  animscripts\shared::donotetracks("runanim");
}

crouchrun_runnormal() {
  self endon("movemode");
  var_0 = getcrouchrunanim();
  self setanimknob(var_0, 1, 0.4);
  var_1 = "run";

  if(animscripts\utility::usingsmg())
    var_1 = "smg_crouch_run";

  thread updatemoveanimweights("crouchrun", var_0, animscripts\utility::lookupanim(var_1, "crouch_b"), animscripts\utility::lookupanim(var_1, "crouch_l"), animscripts\utility::lookupanim(var_1, "crouch_r"));
  self setflaggedanimknoball("runanim", % crouchrun, % body, 1, 0.2, self.moveplaybackrate);
  run_playfacialanim(undefined);
  animscripts\notetracks::donotetracksfortime(0.2, "runanim");
}

standrun_checkreload() {
  var_0 = isdefined(self.a.allowedpartialreloadontheruntime) && self.a.allowedpartialreloadontheruntime > gettime();
  var_0 = var_0 || isdefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 65536;

  if(var_0) {
    if(!animscripts\combat_utility::needtoreload(0))
      return 0;
  } else if(!animscripts\combat_utility::needtoreload(0.5))
    return 0;

  if(isdefined(self.grenade))
    return 0;

  if(!self.facemotion || animscripts\stairs_utility::isonstairs())
    return 0;

  if(isdefined(self.dontshootwhilemoving) || isdefined(self.norunreload))
    return 0;

  if(canshootwhilerunning() && !animscripts\combat_utility::needtoreload(0))
    return 0;

  if(!isdefined(self.pathgoalpos) || distancesquared(self.origin, self.pathgoalpos) < 65536)
    return 0;

  var_1 = getdvarfloat("ai_runReload_minLookahead", 320);

  if(var_1 > 0 && self.lookaheaddist < var_1)
    return 0;

  var_2 = angleclamp180(self getmotionangle());

  if(abs(var_2) > 25)
    return 0;

  if(!animscripts\utility::usingriflelikeweapon())
    return 0;

  if(!runloopisnearbeginning())
    return 0;

  if(animscripts\utility::shouldcqb())
    animscripts\cqb::cqb_reloadinternal();
  else
    standrun_reloadinternal();

  self notify("abort_reload");
  self orientmode("face default");
  return 1;
}

standrun_reloadinternal() {
  self endon("movemode");
  self endon("should_stairs_transition");
  self orientmode("face motion");
  var_0 = "reload_" + animscripts\combat_utility::getuniqueflagnameindex();
  var_1 = animscripts\utility::lookupanim("run", "reload");

  if(isarray(var_1))
    var_1 = var_1[randomint(var_1.size)];

  self setflaggedanimknoballrestart(var_0, var_1, % body, 1, 0.25);
  run_playfacialanim(var_1);
  self.update_move_front_bias = 1;
  setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"), animscripts\utility::getmoveanim("move_l"), animscripts\utility::getmoveanim("move_r"));
  thread setcombatstandmoveanimweights("run");
  childthread animscripts\stairs_utility::threadcheckstairstransition(var_1, 0, 0.3);
  animscripts\shared::donotetracks(var_0);
  self.update_move_front_bias = undefined;
  self notify("killThreadCheckStairsTransition");
}

runloopisnearbeginning() {
  var_0 = self getanimtime( % walk_and_run_loops);
  var_1 = getanimlength(animscripts\utility::lookupanim("run", "straight")) / 3.0;
  var_0 = var_0 * 3.0;

  if(var_0 > 3)
    var_0 = var_0 - 2.0;
  else if(var_0 > 2)
    var_0 = var_0 - 1.0;

  if(var_0 < 0.15 / var_1)
    return 1;

  if(var_0 > 1 - 0.3 / var_1)
    return 1;

  return 0;
}

setmovenonforwardanims(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_3))
    var_3 = 1;

  self setanimknoblimited(var_0, 1, 0.1, var_3, 1);
  self setanimknoblimited(var_1, 1, 0.1, var_3, 1);
  self setanimknoblimited(var_2, 1, 0.1, var_3, 1);
}

setcombatstandmoveanimweights(var_0) {
  updatemoveanimweights(var_0, % combatrun_forward, % combatrun_backward, % combatrun_left, % combatrun_right);
}

updatemoveanimweights(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(self.update_move_anim_type) && self.update_move_anim_type == var_0) {
    return;
  }
  self notify("stop_move_anim_update");
  self.update_move_anim_type = var_0;
  self.wasfacingmotion = undefined;
  self endon("killanimscript");
  self endon("move_interrupt");
  self endon("stop_move_anim_update");

  for (;;) {
    updaterunweightsonce(var_1, var_2, var_3, var_4);
    wait 0.05;
    waittillframeend;
  }
}

updaterunweightsonce(var_0, var_1, var_2, var_3) {
  if(self.facemotion && !animscripts\utility::shouldcqb() && !isdefined(self.update_move_front_bias) && !(isdefined(self.mech) && self.mech)) {
    if(!isdefined(self.wasfacingmotion)) {
      self.wasfacingmotion = 1;
      var_4 = 0.2;

      if(isdefined(self.strafeblendtimes))
        var_4 = self.strafeblendtimes;

      self setanim(var_0, 1, var_4, 1, 1);
      self setanim(var_1, 0, var_4, 1, 1);
      self setanim(var_2, 0, var_4, 1, 1);
      self setanim(var_3, 0, var_4, 1, 1);
    }
  } else {
    self.wasfacingmotion = undefined;
    var_5 = animscripts\utility::quadrantanimweights(self getmotionangle());

    if(isdefined(self.update_move_front_bias)) {
      var_5["back"] = 0.0;

      if(var_5["front"] < 0.2)
        var_5["front"] = 0.2;
    }

    var_4 = 0.2;

    if(isdefined(self.strafeblendtimes))
      var_4 = self.strafeblendtimes;

    var_6 = var_5["front"];

    if(var_6 < 0.001)
      var_6 = 0.001;

    self setanim(var_0, var_6, var_4, 1, 1);
    self setanim(var_1, var_5["back"], var_4, 1, 1);
    self setanim(var_2, var_5["left"], var_4, 1, 1);
    self setanim(var_3, var_5["right"], var_4, 1, 1);
  }
}

standrun_checkchangeweapon() {
  var_0 = isdefined(self.wantshotgun) && self.wantshotgun;
  var_1 = animscripts\utility::isshotgun(self.weapon);

  if(var_0 == var_1)
    return 0;

  if(animscripts\stairs_utility::isonstairs())
    return 0;

  if(!isdefined(self.pathgoalpos) || distancesquared(self.origin, self.pathgoalpos) < 65536)
    return 0;

  if(animscripts\utility::usingsidearm())
    return 0;

  if(self.weapon == self.primaryweapon) {
    if(!var_0)
      return 0;

    if(!animscripts\utility::isshotgun(self.secondaryweapon))
      return 0;
  } else {
    if(var_0)
      return 0;

    if(animscripts\utility::isshotgun(self.primaryweapon))
      return 0;
  }

  var_2 = angleclamp180(self getmotionangle());

  if(abs(var_2) > 25)
    return 0;

  if(!runloopisnearbeginning())
    return 0;

  if(var_0)
    shotgunswitchstandruninternal("shotgunPullout", animscripts\utility::lookupanim("cqb", "shotgun_pullout"), "gun_2_chest", "none", self.secondaryweapon, "shotgun_pickup");
  else
    shotgunswitchstandruninternal("shotgunPutaway", animscripts\utility::lookupanim("cqb", "shotgun_putaway"), "gun_2_back", "back", self.primaryweapon, "shotgun_pickup");

  self notify("switchEnded");
  return 1;
}

shotgunswitchstandruninternal(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("movemode");
  self endon("should_stairs_transition");
  self setflaggedanimknoballrestart(var_0, var_1, % body, 1, 0.25);
  run_playfacialanim(var_1);
  self.update_move_front_bias = 1;
  setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"), animscripts\utility::getmoveanim("move_l"), animscripts\utility::getmoveanim("move_r"));
  thread setcombatstandmoveanimweights("run");
  thread watchshotgunswitchnotetracks(var_0, var_2, var_3, var_4, var_5);
  childthread animscripts\stairs_utility::threadcheckstairstransition(var_1, 0, 0.3);
  animscripts\notetracks::donotetracksfortimeintercept(getanimlength(var_1) - 0.25, var_0, ::interceptnotetracksforweaponswitch);
  self.update_move_front_bias = undefined;
  self notify("killThreadCheckStairsTransition");
}

interceptnotetracksforweaponswitch(var_0) {
  if(var_0 == "gun_2_chest" || var_0 == "gun_2_back")
    return 1;
}

watchshotgunswitchnotetracks(var_0, var_1, var_2, var_3, var_4) {
  self endon("killanimscript");
  self endon("movemode");
  self endon("switchEnded");
  self waittillmatch(var_0, var_1);
  animscripts\shared::placeweaponon(self.weapon, var_2);
  thread shotgunswitchfinish(var_3);
  self waittillmatch(var_0, var_4);
  self notify("complete_weapon_switch");
}

shotgunswitchfinish(var_0) {
  self endon("death");
  common_scripts\utility::waittill_any("killanimscript", "movemode", "switchEnded", "complete_weapon_switch");
  self.lastweapon = self.weapon;
  animscripts\shared::placeweaponon(var_0, "right");
  self.bulletsinclip = weaponclipsize(self.weapon);
}

run_playfacialanim(var_0) {
  self.facialidx = animscripts\face::playfacialanim(var_0, "run", self.facialidx);
}

run_clearfacialanim() {
  self.facialidx = undefined;
  self clearanim( % head, 0.2);
}