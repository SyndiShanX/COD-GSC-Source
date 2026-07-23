/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\move.gsc
**************************************/

main() {
  if(isDefined(self.custom_animscript_table)) {
    if(isDefined(self.custom_animscript_table["move"])) {
      [[self.custom_animscript_table["move"]]]();
      return;
    }
  }

  self endon("killanimscript");
  [[self.defaultexception["move"]]]();
  moveinit();
  getupifprone();
  animscripts\utility::initialize("move");
  var_0 = waspreviouslyincover();

  if(var_0 && isDefined(self.shufflemove)) {
    movecovertocover();
    movecovertocoverfinish();
  } else if(isDefined(self.battlechatter) && self.battlechatter) {
    movestartbattlechatter(var_0);
    animscripts\battlechatter::playbattlechatter();
  }

  thread stairscheck();
  thread pathchangecheck();
  thread animdodgeobstacle();
  animscripts\cover_arrival::startmovetransition();
  self.doingreacquirestep = undefined;
  self.ignorepathchange = undefined;
  thread startthreadstorunwhilemoving();
  thread animscripts\cover_arrival::setupapproachnode(1);
  self.shoot_while_moving_thread = undefined;
  self.aim_while_moving_thread = undefined;
  self.runngun = undefined;
  movemainloop(1);
}

end_script() {
  if(isDefined(self.oldgrenadeweapon)) {
    self.grenadeweapon = self.oldgrenadeweapon;
    self.oldgrenadeweapon = undefined;
  }

  self.teamflashbangimmunity = undefined;
  self.minindoortime = undefined;
  self.ignorepathchange = undefined;
  self.shufflemove = undefined;
  self.shufflenode = undefined;
  self.runngun = undefined;
  self.reactingtobullet = undefined;
  self.requestreacttobullet = undefined;
  self.currentdodgeanim = undefined;
  self.moveloopoverridefunc = undefined;
}

moveinit() {
  self.reactingtobullet = undefined;
  self.requestreacttobullet = undefined;
  self.update_move_anim_type = undefined;
  self.update_move_front_bias = undefined;
  self.runngunweight = 0;
  self.arrivalstartdist = undefined;
}

getupifprone() {
  if(self.a.pose == "prone") {
    var_0 = animscripts\utility::choosepose("stand");

    if(var_0 != "prone") {
      self orientmode("face current");
      self animmode("zonly_physics", 0);
      var_1 = 1;

      if(isDefined(self.grenade)) {
        var_1 = 2;
      }
      animscripts\cover_prone::proneto(var_0, var_1);
      self animmode("none", 0);
      self orientmode("face default");
    }
  }
}

waspreviouslyincover() {
  switch (self.prevscript) {
    case "concealment_stand":
    case "concealment_prone":
    case "concealment_crouch":
    case "cover_wide_right":
    case "cover_wide_left":
    case "cover_prone":
    case "cover_stand":
    case "cover_left":
    case "turret":
    case "cover_crouch":
    case "cover_right":
    case "hide":
      return 1;
  }

  return 0;
}

movestartbattlechatter(var_0) {
  if(self.movemode == "run") {
    animscripts\battlechatter_ai::evaluatemoveevent(var_0);
  }
}

movemainloop(var_0) {
  movemainloopinternal(var_0);
  self notify("abort_reload");
}

changemovemode(var_0) {
  if(var_0 != self.prevmovemode) {
    if(isDefined(self.custommoveanimset) && isDefined(self.custommoveanimset[var_0])) {
      self.a.moveanimset = self.custommoveanimset[var_0];
    } else {
      self.a.moveanimset = anim.animsets.move[var_0];

      if((self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only") && (isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > squared(100))) {
        self.sidesteprate = 1;
        animscripts\animset::set_ambush_sidestep_anims();
      } else {
        self.sidesteprate = 1.35;
      }
    }

    self.prevmovemode = var_0;
  }
}

#using_animtree("generic_human");

movemainloopinternal(var_0) {
  self endon("killanimscript");
  self endon("move_interrupt");
  var_1 = self getanimtime(%walk_and_run_loops);
  self.a.runloopcount = randomint(10000);
  self.prevmovemode = "none";
  self.moveloopcleanupfunc = undefined;

  for(;;) {
    var_2 = self getanimtime(%walk_and_run_loops);

    if(var_2 < var_1) {
      self.a.runloopcount++;
    }
    var_1 = var_2;
    changemovemode(self.movemode);
    movemainloopprocess(self.movemode);

    if(isDefined(self.moveloopcleanupfunc)) {
      self[[self.moveloopcleanupfunc]]();
      self.moveloopcleanupfunc = undefined;
    }

    self notify("abort_reload");
  }
}

movemainloopprocess(var_0) {
  self endon("move_loop_restart");
  animscripts\face::setidlefacedelayed(anim.alertface);

  if(isDefined(self.moveloopoverridefunc)) {
    self[[self.moveloopoverridefunc]]();
  } else if(animscripts\utility::shouldcqb()) {
    animscripts\cqb::movecqb();
  } else if(var_0 == "run") {
    animscripts\run::moverun();
  } else {
    animscripts\walk::movewalk();
  }
  self.requestreacttobullet = undefined;
}

mayshootwhilemoving() {
  if(self.weapon == "none") {
    return 0;
  }
  var_0 = weaponclass(self.weapon);

  if(!animscripts\utility::usingriflelikeweapon()) {
    return 0;
  }
  if(animscripts\combat_utility::issniper()) {
    if(!animscripts\utility::iscqbwalking() && self.facemotion) {
      return 0;
    }
  }

  if(isDefined(self.dontshootwhilemoving)) {
    return 0;
  }
  return 1;
}

shootwhilemoving() {
  self endon("killanimscript");
  self notify("doing_shootWhileMoving");
  self endon("doing_shootWhileMoving");

  if(isDefined(self.combatstandanims) && isDefined(self.combatstandanims["fire"])) {
    self.a.array["fire"] = self.combatstandanims["fire"];
  } else {
    self.a.array["fire"] = % exposed_shoot_auto_v3;
  }
  if(isDefined(self.weapon) && animscripts\utility::weapon_pump_action_shotgun()) {
    self.a.array["single"] = animscripts\utility::array(%shotgun_stand_fire_1a, %shotgun_stand_fire_1b);
  } else {
    self.a.array["single"] = animscripts\utility::array(%exposed_shoot_semi1);
  }
  self.a.array["burst2"] = % exposed_shoot_burst3;
  self.a.array["burst3"] = % exposed_shoot_burst3;
  self.a.array["burst4"] = % exposed_shoot_burst4;
  self.a.array["burst5"] = % exposed_shoot_burst5;
  self.a.array["burst6"] = % exposed_shoot_burst6;
  self.a.array["semi2"] = % exposed_shoot_semi2;
  self.a.array["semi3"] = % exposed_shoot_semi3;
  self.a.array["semi4"] = % exposed_shoot_semi4;
  self.a.array["semi5"] = % exposed_shoot_semi5;

  for(;;) {
    if(!self.bulletsinclip) {
      if(animscripts\utility::iscqbwalkingorfacingenemy()) {
        self.ammocheattime = 0;
        animscripts\combat_utility::cheatammoifnecessary();
      }

      if(!self.bulletsinclip) {
        wait 0.5;
        continue;
      }
    }

    animscripts\combat_utility::shootuntilshootbehaviorchange();
    self clearanim(%exposed_aiming, 0.2);
  }
}

startthreadstorunwhilemoving() {
  self endon("killanimscript");
  wait 0.05;
  thread bulletwhizbycheck_whilemoving();
  thread meleeattackcheck_whilemoving();
  thread animscripts\door::indoorcqbtogglecheck();
  thread animscripts\door::doorenterexitcheck();
}

stairscheck() {
  self endon("killanimscript");
  self.prevstairsstate = self.stairsstate;

  for(;;) {
    wait 0.05;

    if(self.prevstairsstate != self.stairsstate) {
      if(!isDefined(self.ignorepathchange) || self.stairsstate != "none") {
        self notify("move_loop_restart");
      }
    }

    self.prevstairsstate = self.stairsstate;
  }
}

restartmoveloop(var_0) {
  self endon("killanimscript");

  if(!var_0) {
    animscripts\cover_arrival::startmovetransition();
  }
  self.ignorepathchange = undefined;
  self clearanim(%root, 0.1);
  self orientmode("face default");
  self animmode("none", 0);
  self.requestarrivalnotify = 1;
  movemainloop(!var_0);
}

pathchangecheck() {
  self endon("killanimscript");
  self endon("move_interrupt");
  self.ignorepathchange = 1;

  for(;;) {
    self waittill("path_changed", var_0, var_1);

    if(isDefined(self.ignorepathchange) || isDefined(self.noturnanims)) {
      continue;
    }
    if(!self.facemotion || abs(self getmotionangle()) > 15) {
      continue;
    }
    if(self.a.movement != "run" && self.a.movement != "walk") {
      continue;
    }
    if(self.a.pose != "stand") {
      continue;
    }
    self notify("stop_move_anim_update");
    self.update_move_anim_type = undefined;
    var_2 = angleclamp180(self.angles[1] - vectortoyaw(var_1));
    var_3 = pathchange_getturnanim(var_2);

    if(isDefined(var_3)) {
      self.turnanim = var_3;
      self.turntime = gettime();
      self.moveloopoverridefunc = ::pathchange_doturnanim;
      self notify("move_loop_restart");
      animscripts\run::endfaceenemyaimtracking();
    }
  }
}

pathchange_getturnanim(var_0) {
  if(isDefined(self.pathturnanimoverridefunc)) {
    return [[self.pathturnanimoverridefunc]](var_0);
  }
  var_1 = undefined;
  var_2 = undefined;

  if(animscripts\utility::shouldcqb() || self.movemode == "walk") {
    var_3 = anim.cqbturnanims;
  } else {
    var_3 = anim.runturnanims;
  }
  if(var_0 < -30) {
    if(var_0 > -60) {
      var_1 = var_3["L45"];
    } else if(var_0 > -112.5) {
      var_1 = var_3["L90"];

      if(var_0 > -90) {
        var_2 = var_3["L45"];
      } else {
        var_2 = var_3["L135"];
      }
    } else if(var_0 > -157.5) {
      var_1 = var_3["L135"];

      if(var_0 > -135) {
        var_2 = var_3["L90"];
      } else {
        var_2 = var_3["180"];
      }
    } else {
      var_1 = var_3["180"];
      var_2 = var_3["L135"];
    }
  } else if(var_0 > 30) {
    if(var_0 < 60) {
      var_1 = var_3["R45"];
    } else if(var_0 < 112.5) {
      var_1 = var_3["R90"];

      if(var_0 < 90) {
        var_2 = var_3["R45"];
      } else {
        var_2 = var_3["R135"];
      }
    } else if(var_0 < 157.5) {
      var_1 = var_3["R135"];

      if(var_0 < 135) {
        var_2 = var_3["R90"];
      } else {
        var_2 = var_3["180"];
      }
    } else {
      var_1 = var_3["180"];
      var_2 = var_3["R135"];
    }
  }

  if(isDefined(var_1)) {
    if(pathchange_candoturnanim(var_1)) {
      return var_1;
    }
  }

  if(isDefined(var_2)) {
    if(pathchange_candoturnanim(var_2)) {
      return var_2;
    }
  }

  return undefined;
}

pathchange_candoturnanim(var_0) {
  if(!isDefined(self.pathgoalpos)) {
    return 0;
  }
  var_1 = getnotetracktimes(var_0, "code_move");
  var_2 = var_1[0];
  var_3 = getmovedelta(var_0, 0, var_2);
  var_4 = self localtoworldcoords(var_3);

  if(isDefined(self.arrivalstartdist) && squared(self.arrivalstartdist) > distancesquared(self.pathgoalpos, var_4)) {
    return 0;
  }
  var_3 = getmovedelta(var_0, 0, 1);
  var_5 = self localtoworldcoords(var_3);
  var_5 = var_4 + vectorNormalize(var_5 - var_4) * 20;
  return self maymovefrompointtopoint(var_4, var_5, 1, 1);
}

pathchange_doturnanim() {
  self endon("killanimscript");
  self.moveloopoverridefunc = undefined;
  var_0 = self.turnanim;

  if(gettime() > self.turntime + 50) {
    return;
  }
  self animmode("zonly_physics", 0);
  self clearanim(%body, 0.1);
  self.moveloopcleanupfunc = ::pathchange_cleanupturnanim;
  self.ignorepathchange = 1;
  var_1 = 0.05;

  if(isDefined(self.pathturnanimblendtime)) {
    var_1 = isDefined(self.pathturnanimblendtime);
  }
  self setflaggedanimrestart("turnAnim", var_0, 1, var_1, self.moveplaybackrate);
  self orientmode("face current");
  animscripts\shared::donotetracks("turnAnim");
  self.ignorepathchange = undefined;
  self orientmode("face motion");
  self animmode("none", 0);
  animscripts\shared::donotetracks("turnAnim");
}

pathchange_domovetransition() {
  self.moveloopoverridefunc = undefined;

  if(gettime() > self.turntime + 50) {
    return;
  }
  self.moveloopcleanupfunc = ::pathchange_cleanupturnanim;
  animscripts\cover_arrival::startmovetransition();
}

pathchange_cleanupturnanim() {
  self.ignorepathchange = undefined;
  self orientmode("face default");
  self clearanim(%root, 0.1);
  self animmode("none", 0);
}

dodgemoveloopoverride() {
  self pushplayer(1);
  self animmode("zonly_physics", 0);
  self clearanim(%body, 0.2);
  self setflaggedanimrestart("dodgeAnim", self.currentdodgeanim, 1, 0.2, 1);
  animscripts\shared::donotetracks("dodgeAnim");
  self animmode("none", 0);
  self orientmode("face default");

  if(animhasnotetrack(self.currentdodgeanim, "code_move")) {
    animscripts\shared::donotetracks("dodgeAnim");
  }
  self clearanim(%civilian_dodge, 0.2);
  self pushplayer(0);
  self.currentdodgeanim = undefined;
  self.moveloopoverridefunc = undefined;
  return 1;
}

trydodgewithanim(var_0, var_1) {
  var_2 = (self.lookaheaddir[1], -1 * self.lookaheaddir[0], 0);
  var_3 = self.lookaheaddir * var_1[0];
  var_4 = var_2 * var_1[1];
  var_5 = self.origin + var_3 - var_4;
  self pushplayer(1);

  if(self maymovetopoint(var_5)) {
    self.currentdodgeanim = var_0;
    self.moveloopoverridefunc = ::dodgemoveloopoverride;
    self notify("move_loop_restart");
    return 1;
  }

  self pushplayer(0);
  return 0;
}

animdodgeobstacle() {
  if(!isDefined(self.dodgeleftanim) || !isDefined(self.dodgerightanim)) {
    return;
  }
  self endon("killanimscript");
  self endon("move_interrupt");

  for(;;) {
    self waittill("path_need_dodge", var_0, var_1);

    if(animscripts\utility::isincombat()) {
      self.nododgemove = 0;
      return;
    }

    if(!issentient(var_0)) {
      continue;
    }
    var_2 = vectorNormalize(var_1 - self.origin);

    if(self.lookaheaddir[0] * var_2[1] - var_2[0] * self.lookaheaddir[1] > 0) {
      if(!trydodgewithanim(self.dodgerightanim, self.dodgerightanimoffset)) {
        trydodgewithanim(self.dodgeleftanim, self.dodgeleftanimoffset);
      }
    } else if(!trydodgewithanim(self.dodgeleftanim, self.dodgeleftanimoffset)) {
      trydodgewithanim(self.dodgerightanim, self.dodgerightanimoffset);
    }
    if(isDefined(self.currentdodgeanim)) {
      wait(getanimlength(self.currentdodgeanim));
      continue;
    }

    wait 0.1;
  }
}

setdodgeanims(var_0, var_1) {
  self.nododgemove = 1;
  self.dodgeleftanim = var_0;
  self.dodgerightanim = var_1;
  var_2 = 1;

  if(animhasnotetrack(var_0, "code_move")) {
    var_2 = getnotetracktimes(var_0, "code_move")[0];
  }
  self.dodgeleftanimoffset = getmovedelta(var_0, 0, var_2);
  var_2 = 1;

  if(animhasnotetrack(var_1, "code_move")) {
    var_2 = getnotetracktimes(var_1, "code_move")[0];
  }
  self.dodgerightanimoffset = getmovedelta(var_1, 0, var_2);
  self.interval = 80;
}

cleardodgeanims() {
  self.nododgemove = 0;
  self.dodgeleftanim = undefined;
  self.dodgerightanim = undefined;
  self.dodgeleftanimoffset = undefined;
  self.dodgerightanimoffset = undefined;
}

meleeattackcheck_whilemoving() {
  self endon("killanimscript");

  for(;;) {
    if(isDefined(self.enemy) && (isai(self.enemy) || isDefined(self.meleeplayerwhilemoving))) {
      if(abs(self getmotionangle()) <= 135) {
        animscripts\melee::melee_tryexecuting();
      }
    }

    wait 0.1;
  }
}

bulletwhizbycheck_whilemoving() {
  self endon("killanimscript");

  if(isDefined(self.disablebulletwhizbyreaction)) {
    return;
  }
  for(;;) {
    self waittill("bulletwhizby", var_0);

    if(self.movemode != "run" || !self.facemotion || self.a.pose != "stand" || isDefined(self.reactingtobullet)) {
      continue;
    }
    if(self.stairsstate != "none") {
      continue;
    }
    if(!isDefined(self.enemy) && !self.ignoreall && isDefined(var_0.team) && isenemyteam(self.team, var_0.team)) {
      self.whizbyenemy = var_0;
      self animcustom(animscripts\reactions::bulletwhizbyreaction);
      continue;
    }

    if(self.lookaheadhitsstairs || self.lookaheaddist < 100) {
      continue;
    }
    if(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) < 10000) {
      wait 0.2;
      continue;
    }

    self.requestreacttobullet = gettime();
    self notify("move_loop_restart");
    animscripts\run::endfaceenemyaimtracking();
  }
}

get_shuffle_to_corner_start_anim(var_0, var_1) {
  if(var_1.type == "Cover Left") {
    return % cornercrl_alert_2_shuffle;
  } else if(var_1.type == "Cover Right") {
    return % cornercrr_alert_2_shuffle;
  } else if(var_0) {
    return % covercrouch_hide_2_shufflel;
  } else {
    return % covercrouch_hide_2_shuffler;
  }
}

setup_shuffle_anim_array(var_0, var_1, var_2) {
  var_3 = [];

  if(var_2.type == "Cover Left") {
    var_3["shuffle_start"] = get_shuffle_to_corner_start_anim(var_0, var_1);
    var_3["shuffle"] = % covercrouch_shufflel;
    var_3["shuffle_end"] = % cornercrl_shuffle_2_alert;
  } else if(var_2.type == "Cover Right") {
    var_3["shuffle_start"] = get_shuffle_to_corner_start_anim(var_0, var_1);
    var_3["shuffle"] = % covercrouch_shuffler;
    var_3["shuffle_end"] = % cornercrr_shuffle_2_alert;
  } else if(var_2.type == "Cover Stand" && var_1.type == var_2.type) {
    if(var_0) {
      var_3["shuffle_start"] = % coverstand_hide_2_shufflel;
      var_3["shuffle"] = % coverstand_shufflel;
      var_3["shuffle_end"] = % coverstand_shufflel_2_hide;
    } else {
      var_3["shuffle_start"] = % coverstand_hide_2_shuffler;
      var_3["shuffle"] = % coverstand_shuffler;
      var_3["shuffle_end"] = % coverstand_shuffler_2_hide;
    }
  } else if(var_0) {
    var_3["shuffle_start"] = get_shuffle_to_corner_start_anim(var_0, var_1);
    var_3["shuffle"] = % covercrouch_shufflel;

    if(var_2.type == "Cover Stand") {
      var_3["shuffle_end"] = % coverstand_shufflel_2_hide;
    } else {
      var_3["shuffle_end"] = % covercrouch_shufflel_2_hide;
    }
  } else {
    var_3["shuffle_start"] = get_shuffle_to_corner_start_anim(var_0, var_1);
    var_3["shuffle"] = % covercrouch_shuffler;

    if(var_2.type == "Cover Stand") {
      var_3["shuffle_end"] = % coverstand_shuffler_2_hide;
    } else {
      var_3["shuffle_end"] = % covercrouch_shuffler_2_hide;
    }
  }

  self.a.array = var_3;
}

movecovertocover_checkstartpose(var_0, var_1) {
  if(self.a.pose == "stand" && (var_1.type != "Cover Stand" || var_0.type != "Cover Stand")) {
    self.a.pose = "crouch";
    return 0;
  }

  return 1;
}

movecovertocover_checkendpose(var_0) {
  if(self.a.pose == "crouch" && var_0.type == "Cover Stand") {
    self.a.pose = "stand";
    return 0;
  }

  return 1;
}

movecovertocover() {
  self endon("killanimscript");
  self endon("goal_changed");
  var_0 = self.shufflenode;
  self.shufflemove = undefined;
  self.shufflenode = undefined;
  self.shufflemoveinterrupted = 1;

  if(!isDefined(self.prevnode)) {
    return;
  }
  if(!isDefined(self.node) || !isDefined(var_0) || self.node != var_0) {
    return;
  }
  var_1 = self.prevnode;
  var_2 = self.node;
  var_3 = var_2.origin - self.origin;

  if(lengthsquared(var_3) < 1) {
    return;
  }
  var_3 = vectorNormalize(var_3);
  var_4 = anglesToForward(var_2.angles);
  var_5 = var_4[0] * var_3[1] - var_4[1] * var_3[0] > 0;

  if(movedoorsidetoside(var_5, var_1, var_2)) {
    return;
  }
  if(movecovertocover_checkstartpose(var_1, var_2)) {
    var_6 = 0.1;
  } else {
    var_6 = 0.4;
  }
  setup_shuffle_anim_array(var_5, var_1, var_2);
  self animmode("zonly_physics", 0);
  self clearanim(%body, var_6);
  var_7 = animscripts\utility::animarray("shuffle_start");
  var_8 = animscripts\utility::animarray("shuffle");
  var_9 = animscripts\utility::animarray("shuffle_end");

  if(animhasnotetrack(var_7, "finish")) {
    var_10 = getnotetracktimes(var_7, "finish")[0];
  } else {
    var_10 = 1;
  }
  var_11 = length(getmovedelta(var_7, 0, var_10));
  var_12 = length(getmovedelta(var_8, 0, 1));
  var_13 = length(getmovedelta(var_9, 0, 1));
  var_14 = distance(self.origin, var_2.origin);

  if(var_14 > var_11) {
    self orientmode("face angle", animscripts\utility::getnodeforwardyaw(var_1));
    self setflaggedanimrestart("shuffle_start", var_7, 1, var_6);
    animscripts\shared::donotetracks("shuffle_start");
    self clearanim(var_7, 0.2);
    var_14 = var_14 - var_11;
    var_6 = 0.2;
  } else {
    self orientmode("face angle", var_2.angles[1]);
  }
  var_15 = 0;

  if(var_14 > var_13) {
    var_15 = 1;
    var_14 = var_14 - var_13;
  }

  var_16 = getanimlength(var_8);
  var_17 = var_16 * (var_14 / var_12) * 0.9;
  var_17 = floor(var_17 * 20) * 0.05;
  self setflaggedanim("shuffle", var_8, 1, var_6);
  animscripts\notetracks::donotetracksfortime(var_17, "shuffle");

  for(var_18 = 0; var_18 < 2; var_18++) {
    var_14 = distance(self.origin, var_2.origin);

    if(var_15) {
      var_14 = var_14 - var_13;
    }
    if(var_14 < 4) {
      break;
    }

    var_17 = var_16 * (var_14 / var_12) * 0.9;
    var_17 = floor(var_17 * 20) * 0.05;

    if(var_17 < 0.05) {
      break;
    }

    animscripts\notetracks::donotetracksfortime(var_17, "shuffle");
  }

  if(var_15) {
    if(movecovertocover_checkendpose(var_2)) {
      var_6 = 0.2;
    } else {
      var_6 = 0.4;
    }
    self clearanim(var_8, var_6);
    self setflaggedanim("shuffle_end", var_9, 1, var_6);
    animscripts\shared::donotetracks("shuffle_end");
  }

  self safeteleport(var_2.origin);
  self animmode("normal");
  self.shufflemoveinterrupted = undefined;
}

movecovertocoverfinish() {
  if(isDefined(self.shufflemoveinterrupted)) {
    self clearanim(%cover_shuffle, 0.2);
    self.shufflemoveinterrupted = undefined;
    self animmode("none", 0);
    self orientmode("face default");
  } else {
    wait 0.2;
    self clearanim(%cover_shuffle, 0.2);
  }
}

movedoorsidetoside(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_1.type == "Cover Right" && var_2.type == "Cover Left" && !var_0) {
    var_3 = % corner_standr_door_r2l;
  } else if(var_1.type == "Cover Left" && var_2.type == "Cover Right" && var_0) {
    var_3 = % corner_standl_door_l2r;
  }
  if(!isDefined(var_3)) {
    return 0;
  }
  self animmode("zonly_physics", 0);
  self orientmode("face current");
  self setflaggedanimrestart("sideToSide", var_3, 1, 0.2);
  animscripts\shared::donotetracks("sideToSide", ::handlesidetosidenotetracks);
  var_4 = self getanimtime(var_3);
  var_5 = var_2.origin - var_1.origin;
  var_5 = vectorNormalize((var_5[0], var_5[1], 0));
  var_6 = getmovedelta(var_3, var_4, 1);
  var_7 = var_2.origin - self.origin;
  var_7 = (var_7[0], var_7[1], 0);
  var_8 = vectordot(var_7, var_5) - abs(var_6[1]);

  if(var_8 > 2) {
    var_9 = getnotetracktimes(var_3, "slide_end")[0];
    var_10 = (var_9 - var_4) * getanimlength(var_3);
    var_11 = int(ceil(var_10 / 0.05));
    var_12 = var_5 * var_8 / var_11;
    thread slidefortime(var_12, var_11);
  }

  animscripts\shared::donotetracks("sideToSide");
  self safeteleport(var_2.origin);
  self animmode("none");
  self orientmode("face default");
  self.shufflemoveinterrupted = undefined;
  wait 0.2;
  return 1;
}

handlesidetosidenotetracks(var_0) {
  if(var_0 == "slide_start") {
    return 1;
  }
}

slidefortime(var_0, var_1) {
  self endon("killanimscript");
  self endon("goal_changed");

  while(var_1 > 0) {
    self safeteleport(self.origin + var_0);
    var_1--;
    wait 0.05;
  }
}

movestandmoveoverride(var_0, var_1) {
  self endon("movemode");
  self clearanim(%combatrun, 0.6);
  self setanimknoball(%combatrun, %body, 1, 0.5, self.moveplaybackrate);

  if(isDefined(self.requestreacttobullet) && gettime() - self.requestreacttobullet < 100 && isDefined(self.run_overridebulletreact) && randomfloat(1) < self.a.reacttobulletchance) {
    animscripts\run::customrunningreacttobullets();
    return;
  }

  if(isarray(var_0)) {
    if(isDefined(self.run_override_weights)) {
      var_2 = common_scripts\utility::choose_from_weighted_array(var_0, var_1);
    } else {
      var_2 = var_0[randomint(var_0.size)];
    }
  } else {
    var_2 = var_0;
  }
  self setflaggedanimknob("moveanim", var_2, 1, 0.2);
  animscripts\shared::donotetracks("moveanim");
}