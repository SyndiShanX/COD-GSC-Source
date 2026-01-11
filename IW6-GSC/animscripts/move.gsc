/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\move.gsc
*****************************************************/

#using_animtree("generic_human");

init_animset_move() {
  var_0 = [];
  var_0["fire"] = % exposed_shoot_auto_v3;
  var_0["single"] = [ % exposed_shoot_semi1];
  var_0["single_shotgun"] = [ % shotgun_stand_fire_1a, % shotgun_stand_fire_1b];
  var_0["burst2"] = % exposed_shoot_burst3;
  var_0["burst3"] = % exposed_shoot_burst3;
  var_0["burst4"] = % exposed_shoot_burst4;
  var_0["burst5"] = % exposed_shoot_burst5;
  var_0["burst6"] = % exposed_shoot_burst6;
  var_0["semi2"] = % exposed_shoot_semi2;
  var_0["semi3"] = % exposed_shoot_semi3;
  var_0["semi4"] = % exposed_shoot_semi4;
  var_0["semi5"] = % exposed_shoot_semi5;
  anim.archetypes["soldier"]["shoot_while_moving"] = var_0;
  var_0 = [];
  var_0["shuffle_start_from_cover_left"] = % cornercrl_alert_2_shuffle;
  var_0["shuffle_start_from_cover_right"] = % cornercrr_alert_2_shuffle;
  var_0["shuffle_start_left"] = % covercrouch_hide_2_shufflel;
  var_0["shuffle_start_right"] = % covercrouch_hide_2_shuffler;
  var_0["shuffle_to_cover_left"] = % covercrouch_shufflel;
  var_0["shuffle_end_to_cover_left"] = % cornercrl_shuffle_2_alert;
  var_0["shuffle_to_cover_right"] = % covercrouch_shuffler;
  var_0["shuffle_end_to_cover_right"] = % cornercrr_shuffle_2_alert;
  var_0["shuffle_start_left_stand_to_stand"] = % coverstand_hide_2_shufflel;
  var_0["shuffle_left_stand_to_stand"] = % coverstand_shufflel;
  var_0["shuffle_end_left_stand_to_stand"] = % coverstand_shufflel_2_hide;
  var_0["shuffle_start_right_stand_to_stand"] = % coverstand_hide_2_shuffler;
  var_0["shuffle_right_stand_to_stand"] = % coverstand_shuffler;
  var_0["shuffle_end_right_stand_to_stand"] = % coverstand_shuffler_2_hide;
  var_0["shuffle_to_left_crouch"] = % covercrouch_shufflel;
  var_0["shuffle_end_to_left_stand"] = % coverstand_shufflel_2_hide;
  var_0["shuffle_end_to_left_crouch"] = % covercrouch_shufflel_2_hide;
  var_0["shuffle_to_right_crouch"] = % covercrouch_shuffler;
  var_0["shuffle_end_to_right_stand"] = % coverstand_shuffler_2_hide;
  var_0["shuffle_end_to_right_crouch"] = % covercrouch_shuffler_2_hide;
  anim.archetypes["soldier"]["shuffle"] = var_0;
}

main() {
  if(isDefined(self.custom_animscript)) {
    if(isDefined(self.custom_animscript["move"])) {
      [
        [self.custom_animscript["move"]]
      ]();
      return;
    }
  }

  self endon("killanimscript");
  [[self.exception["move"]]]();
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

  thread updatestairsstate();
  var_1 = ::pathchangelistener;

  if(isDefined(self.pathchangecheckoverridefunc)) {
    var_1 = self.pathchangecheckoverridefunc;
  }

  self thread[[var_1]]();
  thread animdodgeobstaclelistener();
  animscripts\exit_node::startmovetransition();
  self.doingreacquirestep = undefined;
  self.ignorepathchange = undefined;
  thread startthreadstorunwhilemoving();
  listenforcoverapproach();
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
  animscripts\run::setshootwhilemoving(0);

  if(self.swimmer) {
    animscripts\swim::swim_moveend();
  }

  self clearanim( % head, 0.2);
  self.facialidx = undefined;
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
    case "cover_swim_right":
    case "cover_swim_left":
    case "cover_prone":
    case "cover_left":
    case "cover_stand":
    case "turret":
    case "cover_crouch":
    case "hide":
    case "cover_multi":
    case "cover_right":
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

archetypechanged() {
  if(isDefined(self.animarchetype) && self.animarchetype != self.prevmovearchetype) {
    return 1;
  }
  else if(!isDefined(self.animarchetype) && self.prevmovearchetype != "none") {
    return 1;
  }

  return 0;
}

updatemovemode(var_0) {
  if(var_0 != self.prevmovemode || archetypechanged()) {
    if(isDefined(self.custommoveanimset) && isDefined(self.custommoveanimset[var_0])) {
      self.a.moveanimset = self.custommoveanimset[var_0];
    }
    else {
      self.a.moveanimset = animscripts\utility::lookupanimarray(var_0);

      if((self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only") && (isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > squared(100))) {
        self.sidesteprate = 1;
        animscripts\animset::set_ambush_sidestep_anims();
      } else
        self.sidesteprate = 1.35;
    }

    self.prevmovemode = var_0;

    if(isDefined(self.animarchetype)) {
      self.prevmovearchetype = self.animarchetype;
    }
  }
}

movemainloopinternal(var_0) {
  self endon("killanimscript");
  self endon("move_interrupt");
  var_1 = self getanimtime( % walk_and_run_loops);
  self.a.runloopcount = randomint(10000);
  self.prevmovemode = "none";
  self.prevmovearchetype = "none";
  self.moveloopcleanupfunc = undefined;

  for(;;) {
    var_2 = self getanimtime( % walk_and_run_loops);

    if(var_2 < var_1) {
      self.a.runloopcount++;
    }

    var_1 = var_2;
    updatemovemode(self.movemode);

    if(isDefined(self.movemainloopprocessoverridefunc)) {
      self[[self.movemainloopprocessoverridefunc]](self.movemode);
    }
    else {
      movemainloopprocess(self.movemode);
    }

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
  }
  else if(animscripts\utility::shouldcqb()) {
    animscripts\cqb::movecqb();
  }
  else if(self.swimmer) {
    animscripts\swim::moveswim();
  }
  else if(var_0 == "run") {
    animscripts\run::moverun();
  }
  else {
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
  var_0 = animscripts\utility::lookupanimarray("shoot_while_moving");

  foreach(var_3, var_2 in var_0) {
  self.a.array[var_3] = var_2;
  }

  if(isDefined(self.combatstandanims) && isDefined(self.combatstandanims["fire"])) {
    self.a.array["fire"] = self.combatstandanims["fire"];
  }

  if(isDefined(self.weapon) && animscripts\utility::weapon_pump_action_shotgun()) {
    self.a.array["single"] = animscripts\utility::lookupanim("shotgun_stand", "single");
  }

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
    self clearanim( % exposed_aiming, 0.2);
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

updatestairsstate() {
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
    animscripts\exit_node::startmovetransition();
  }

  self.ignorepathchange = undefined;
  self clearanim( % root, 0.1);
  self orientmode("face default");
  self animmode("none", 0);
  self.requestarrivalnotify = 1;
  movemainloop(!var_0);
}

pathchangelistener() {
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
    if(self.a.pose != "stand") {
      continue;
    }
    self notify("stop_move_anim_update");
    self.update_move_anim_type = undefined;
    var_2 = vectortoangles(var_1);
    var_3 = angleclamp180(self.angles[1] - var_2[1]);
    var_4 = angleclamp180(self.angles[0] - var_2[0]);
    var_5 = pathchange_getturnanim(var_3, var_4);

    if(isDefined(var_5)) {
      self.turnanim = var_5;
      self.turntime = gettime();
      self.moveloopoverridefunc = ::pathchange_doturnanim;
      self notify("move_loop_restart");
      animscripts\run::endfaceenemyaimtracking();
    }
  }
}

pathchange_getturnanim(var_0, var_1) {
  if(isDefined(self.pathturnanimoverridefunc)) {
    return [[self.pathturnanimoverridefunc]](var_0, var_1);
  }

  var_2 = undefined;
  var_3 = undefined;

  if(self.swimmer) {
    var_4 = animscripts\swim::getswimanim("turn");
  }
  else if(self.movemode == "walk") {
    var_4 = animscripts\utility::lookupanimarray("cqb_turn");
  }
  else if(animscripts\utility::shouldcqb()) {
    var_4 = animscripts\utility::lookupanimarray("cqb_run_turn");
  }
  else {
    var_4 = animscripts\utility::lookupanimarray("run_turn");
  }

  if(var_0 < 0) {
    if(var_0 > -45) {
      var_5 = 3;
    }
    else {
      var_5 = int(ceil((var_0 + 180 - 10) / 45));
    }
  } else if(var_0 < 45)
    var_5 = 5;
  else {
    var_5 = int(floor((var_0 + 180 + 10) / 45));
  }

  var_2 = var_4[var_5];

  if(isDefined(var_2)) {
    if(isarray(var_2)) {
      while(var_2.size > 0) {
        var_6 = randomint(var_2.size);

        if(pathchange_candoturnanim(var_2[var_6])) {
          return var_2[var_6];
        }

        var_2[var_6] = var_2[var_2.size - 1];
        var_2[var_2.size - 1] = undefined;
      }
    } else if(pathchange_candoturnanim(var_2))
      return var_2;
  }

  var_7 = -1;

  if(var_0 < -60) {
    var_7 = int(ceil((var_0 + 180) / 45));

    if(var_7 == var_5) {
      var_7 = var_5 - 1;
    }
  } else if(var_0 > 60) {
    var_7 = int(floor((var_0 + 180) / 45));

    if(var_7 == var_5) {
      var_7 = var_5 + 1;
    }
  }

  if(var_7 >= 0 && var_7 < 9) {
    var_3 = var_4[var_7];
  }

  if(isDefined(var_3)) {
    if(isarray(var_3)) {
      var_3 = var_3[0];
    }

    if(pathchange_candoturnanim(var_3)) {
      return var_3;
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
  var_5 = var_4 + vectornormalize(var_5 - var_4) * 20;
  var_6 = !self.swimmer;
  return self maymovefrompointtopoint(var_4, var_5, var_6, 1);
}

pathchange_doturnanim() {
  self endon("killanimscript");
  self.moveloopoverridefunc = undefined;
  var_0 = self.turnanim;

  if(gettime() > self.turntime + 50) {
    return;
  }
  if(self.swimmer) {
    self animmode("nogravity", 0);
  }
  else {
    self animmode("zonly_physics", 0);
  }

  var_1 = 0.1;

  if(isDefined(self.pathturnanimblendtime)) {
    var_1 = self.pathturnanimblendtime;
  }

  self clearanim( % body, var_1);
  self.moveloopcleanupfunc = ::pathchange_cleanupturnanim;
  self.ignorepathchange = 1;
  var_1 = 0.05;

  if(isDefined(self.pathturnanimblendtime)) {
    var_1 = self.pathturnanimblendtime;
  }

  self setflaggedanimrestart("turnAnim", var_0, 1, var_1, self.moveplaybackrate);

  if(animscripts\utility::isspaceai()) {
    self orientmode("face angle 3d", self.angles);
  }
  else {
    self orientmode("face angle", self.angles[1]);
  }

  animscripts\shared::donotetracks("turnAnim");
  self.ignorepathchange = undefined;
  self orientmode("face motion");
  self animmode("none", 0);
  animscripts\shared::donotetracks("turnAnim");
}

pathchange_cleanupturnanim() {
  self.ignorepathchange = undefined;
  self orientmode("face default");
  self clearanim( % root, 0.1);
  self animmode("none", 0);

  if(self.swimmer) {
    animscripts\swim::swim_cleanupturnanim();
  }
}

dodgemoveloopoverride() {
  self pushplayer(1);
  self animmode("zonly_physics", 0);
  self clearanim( % body, 0.2);
  self setflaggedanimrestart("dodgeAnim", self.currentdodgeanim, 1, 0.2, 1);
  animscripts\shared::donotetracks("dodgeAnim");
  self animmode("none", 0);
  self orientmode("face default");

  if(animhasnotetrack(self.currentdodgeanim, "code_move")) {
    animscripts\shared::donotetracks("dodgeAnim");
  }

  self clearanim( % civilian_dodge, 0.2);
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

animdodgeobstaclelistener() {
  if(!isDefined(self.dodgeleftanim) || !isDefined(self.dodgerightanim)) {
    return;
  }
  self endon("killanimscript");
  self endon("move_interrupt");

  for(;;) {
    self waittill("path_need_dodge", var_0, var_1);
    animscripts\utility::updateisincombattimer();

    if(animscripts\utility::isincombat()) {
      self.nododgemove = 0;
      return;
    }

    if(!issentient(var_0)) {
      continue;
    }
    var_2 = vectornormalize(var_1 - self.origin);

    if(self.lookaheaddir[0] * var_2[1] - var_2[0] * self.lookaheaddir[1] > 0) {
      if(!trydodgewithanim(self.dodgerightanim, self.dodgerightanimoffset)) {
        trydodgewithanim(self.dodgeleftanim, self.dodgeleftanimoffset);
      }
    } else if(!trydodgewithanim(self.dodgeleftanim, self.dodgeleftanimoffset))
      trydodgewithanim(self.dodgerightanim, self.dodgerightanimoffset);

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
  var_2 = var_1.type;

  if(var_2 == "Cover Multi") {
    var_2 = animscripts\utility::getcovermultipretendtype(var_1);
  }

  if(var_2 == "Cover Left") {
    return animscripts\utility::lookupanim("shuffle", "shuffle_start_from_cover_left");
  }
  else if(var_2 == "Cover Right") {
    return animscripts\utility::lookupanim("shuffle", "shuffle_start_from_cover_right");
  }
  else if(var_0) {
    return animscripts\utility::lookupanim("shuffle", "shuffle_start_left");
  }
  else {
    return animscripts\utility::lookupanim("shuffle", "shuffle_start_right");
  }
}

setup_shuffle_anim_array(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = var_2.type;

  if(var_4 == "Cover Multi") {
    var_4 = animscripts\utility::getcovermultipretendtype(var_2);
  }

  if(var_4 == "Cover Left") {
    var_3["shuffle_start"] = get_shuffle_to_corner_start_anim(var_0, var_1);
    var_3["shuffle"] = animscripts\utility::lookupanim("shuffle", "shuffle_to_cover_left");
    var_3["shuffle_end"] = animscripts\utility::lookupanim("shuffle", "shuffle_end_to_cover_left");
  } else if(var_4 == "Cover Right") {
    var_3["shuffle_start"] = get_shuffle_to_corner_start_anim(var_0, var_1);
    var_3["shuffle"] = animscripts\utility::lookupanim("shuffle", "shuffle_to_cover_right");
    var_3["shuffle_end"] = animscripts\utility::lookupanim("shuffle", "shuffle_end_to_cover_right");
  } else if(var_4 == "Cover Stand" && var_1.type == var_4) {
    if(var_0) {
      var_3["shuffle_start"] = animscripts\utility::lookupanim("shuffle", "shuffle_start_left_stand_to_stand");
      var_3["shuffle"] = animscripts\utility::lookupanim("shuffle", "shuffle_left_stand_to_stand");
      var_3["shuffle_end"] = animscripts\utility::lookupanim("shuffle", "shuffle_end_left_stand_to_stand");
    } else {
      var_3["shuffle_start"] = animscripts\utility::lookupanim("shuffle", "shuffle_start_right_stand_to_stand");
      var_3["shuffle"] = animscripts\utility::lookupanim("shuffle", "shuffle_right_stand_to_stand");
      var_3["shuffle_end"] = animscripts\utility::lookupanim("shuffle", "shuffle_end_right_stand_to_stand");
    }
  } else if(var_0) {
    var_3["shuffle_start"] = get_shuffle_to_corner_start_anim(var_0, var_1);
    var_3["shuffle"] = animscripts\utility::lookupanim("shuffle", "shuffle_to_left_crouch");

    if(var_4 == "Cover Stand") {
      var_3["shuffle_end"] = animscripts\utility::lookupanim("shuffle", "shuffle_end_to_left_stand");
    }
    else {
      var_3["shuffle_end"] = animscripts\utility::lookupanim("shuffle", "shuffle_end_to_left_crouch");
    }
  } else {
    var_3["shuffle_start"] = get_shuffle_to_corner_start_anim(var_0, var_1);
    var_3["shuffle"] = animscripts\utility::lookupanim("shuffle", "shuffle_to_right_crouch");

    if(var_4 == "Cover Stand") {
      var_3["shuffle_end"] = animscripts\utility::lookupanim("shuffle", "shuffle_end_to_right_stand");
    }
    else {
      var_3["shuffle_end"] = animscripts\utility::lookupanim("shuffle", "shuffle_end_to_right_crouch");
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
  var_3 = vectornormalize(var_3);
  var_4 = anglesToForward(var_2.angles);
  var_5 = var_4[0] * var_3[1] - var_4[1] * var_3[0] > 0;

  if(movedoorsidetoside(var_5, var_1, var_2)) {
    return;
  }
  if(movecovertocover_checkstartpose(var_1, var_2)) {
    var_6 = 0.1;
  }
  else {
    var_6 = 0.4;
  }

  setup_shuffle_anim_array(var_5, var_1, var_2);
  self animmode("zonly_physics", 0);
  self clearanim( % body, var_6);
  var_7 = animscripts\utility::animarray("shuffle_start");
  var_8 = animscripts\utility::animarray("shuffle");
  var_9 = animscripts\utility::animarray("shuffle_end");

  if(animhasnotetrack(var_7, "finish")) {
    var_10 = getnotetracktimes(var_7, "finish")[0];
  }
  else {
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
  } else
    self orientmode("face angle", var_2.angles[1]);

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
    }
    else {
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
    self clearanim( % cover_shuffle, 0.2);
    self.shufflemoveinterrupted = undefined;
    self animmode("none", 0);
    self orientmode("face default");
  } else {
    wait 0.2;
    self clearanim( % cover_shuffle, 0.2);
  }
}

movedoorsidetoside(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_1.type == "Cover Right" && var_2.type == "Cover Left" && !var_0) {
    var_3 = % corner_standr_door_r2l;
  }
  else if(var_1.type == "Cover Left" && var_2.type == "Cover Right" && var_0) {
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
  var_5 = vectornormalize((var_5[0], var_5[1], 0));
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

movestand_moveoverride(var_0, var_1) {
  self endon("movemode");
  self clearanim( % combatrun, 0.6);
  self setanimknoball( % combatrun, % body, 1, 0.5, self.moveplaybackrate);

  if(isDefined(self.requestreacttobullet) && gettime() - self.requestreacttobullet < 100 && isDefined(self.run_overridebulletreact) && randomfloat(1) < self.a.reacttobulletchance) {
    animscripts\run::customrunningreacttobullets();
    return;
  }

  if(isarray(var_0)) {
    if(isDefined(self.run_override_weights)) {
      var_2 = common_scripts\utility::choose_from_weighted_array(var_0, var_1);
    }
    else {
      var_2 = var_0[randomint(var_0.size)];
    }
  } else
    var_2 = var_0;

  self setflaggedanimknob("moveanim", var_2, 1, 0.2, self.moveplaybackrate);
  animscripts\shared::donotetracks("moveanim");
}

listenforcoverapproach() {
  thread animscripts\cover_arrival::setupapproachnode(1);
}