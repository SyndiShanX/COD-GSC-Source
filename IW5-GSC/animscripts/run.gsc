/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\run.gsc
**************************************/

moverun() {
  var_0 = [[self.chooseposefunc]]("stand");

  switch (var_0) {
    case "stand":
      if(animscripts\setposemovement::beginstandrun()) {
        return;
      }
      if(isDefined(self.run_overrideanim)) {
        animscripts\move::movestandmoveoverride(self.run_overrideanim, self.run_override_weights);
        return;
      }

      if(changeweaponstandrun()) {
        return;
      }
      if(reloadstandrun()) {
        return;
      }
      if(animscripts\utility::isincombat()) {
        movestandcombatnormal();
      } else {
        movestandnoncombatnormal();
      }
      break;
    case "crouch":
      if(animscripts\setposemovement::begincrouchrun()) {
        return;
      }
      if(isDefined(self.crouchrun_combatanim)) {
        movecrouchrunoverride();
      } else {
        movecrouchrunnormal();
      }
      break;
    default:
      if(animscripts\setposemovement::beginpronerun()) {
        return;
      }
      pronecrawl();
      break;
  }
}

#using_animtree("generic_human");

getrunanim() {
  if(!isDefined(self.a.moveanimset)) {
    return % run_lowready_f;
  }
  if(!self.facemotion) {
    if(self.stairsstate == "none" || abs(self getmotionangle()) > 45) {
      return animscripts\utility::moveanim("move_f");
    }
  }

  if(self.stairsstate == "up") {
    return animscripts\utility::moveanim("stairs_up");
  } else if(self.stairsstate == "down") {
    return animscripts\utility::moveanim("stairs_down");
  }
  return animscripts\utility::moveanim("straight");
}

getcrouchrunanim() {
  if(!isDefined(self.a.moveanimset)) {
    return % crouch_fastwalk_f;
  }
  return animscripts\utility::moveanim("crouch");
}

pronecrawl() {
  self.a.movement = "run";
  self setflaggedanimknob("runanim", animscripts\utility::moveanim("prone"), 1, 0.3, self.moveplaybackrate);
  animscripts\notetracks::donotetracksfortime(0.25, "runanim");
}

initrunngun() {
  if(!isDefined(self.runngun)) {
    self notify("stop_move_anim_update");
    self.update_move_anim_type = undefined;
    self clearanim(%combatrun_backward, 0.2);
    self clearanim(%combatrun_right, 0.2);
    self clearanim(%combatrun_left, 0.2);
    self clearanim(%w_aim_2, 0.2);
    self clearanim(%w_aim_4, 0.2);
    self clearanim(%w_aim_6, 0.2);
    self clearanim(%w_aim_8, 0.2);
    self.runngun = 1;
  }
}

stoprunngun() {
  if(isDefined(self.runngun)) {
    self clearanim(%run_n_gun, 0.2);
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

  var_3 = 1 - var_2;
  var_4 = self.maxrunngunangle;
  var_5 = self.runnguntransitionpoint;
  var_6 = self.runngunincrement;

  if(!var_0 || squared(var_1) > var_4 * var_4) {
    self clearanim(%add_fire, 0);

    if(squared(self.runngunweight) < var_6 * var_6) {
      self.runngunweight = 0;
      self.runngun = undefined;
      return 0;
    } else if(self.runngunweight > 0) {
      self.runngunweight = self.runngunweight - var_6;
    } else {
      self.runngunweight = self.runngunweight + var_6;
    }
  } else {
    var_7 = var_1 / var_4;
    var_8 = var_7 - self.runngunweight;

    if(abs(var_8) < var_5 * 0.7) {
      self.runngunweight = var_7;
    } else if(var_8 > 0) {
      self.runngunweight = self.runngunweight + var_6;
    } else {
      self.runngunweight = self.runngunweight - var_6;
    }
  }

  initrunngun();
  var_9 = abs(self.runngunweight);

  if(var_9 > var_5) {
    var_10 = (var_9 - var_5) / var_5;
    var_10 = clamp(var_10, 0, 1);
    self clearanim(self.runngunanims["F"], 0.2);
    self setanimlimited(self.runngunanims["L"], (1.0 - var_10) * var_2, 0.2);
    self setanimlimited(self.runngunanims["R"], (1.0 - var_10) * var_3, 0.2);
    self setanimlimited(self.runngunanims["LB"], var_10 * var_2, 0.2);
    self setanimlimited(self.runngunanims["RB"], var_10 * var_3, 0.2);
  } else {
    var_10 = clamp(var_9 / var_5, 0, 1);
    self setanimlimited(self.runngunanims["F"], 1.0 - var_10, 0.2);
    self setanimlimited(self.runngunanims["L"], var_10 * var_2, 0.2);
    self setanimlimited(self.runngunanims["R"], var_10 * var_3, 0.2);

    if(var_5 < 1) {
      self clearanim(self.runngunanims["LB"], 0.2);
      self clearanim(self.runngunanims["RB"], 0.2);
    }
  }

  self setflaggedanimknob("runanim", %run_n_gun, 1, 0.3, 0.8);
  self.a.allowedpartialreloadontheruntime = gettime() + 500;

  if(var_0 && isPlayer(self.enemy)) {
    self updateplayersightaccuracy();
  }
  return 1;
}

runngun_backward() {
  initrunngun();
  self setflaggedanimknob("runanim", %combatwalk_b, 1, 0.3, 0.8);

  if(isPlayer(self.enemy)) {
    self updateplayersightaccuracy();
  }
  animscripts\notetracks::donotetracksfortime(0.2, "runanim");
  thread stopshootwhilemovingthreads();
  self clearanim(%combatwalk_b, 0.2);
}

reacttobulletsinterruptcheck() {
  self endon("killanimscript");

  for(;;) {
    wait 0.2;

    if(!isDefined(self.reactingtobullet)) {
      break;
    }

    if(!isDefined(self.pathgoalpos) || distancesquared(self.pathgoalpos, self.origin) < squared(80)) {
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
  self.aim_while_moving_thread = undefined;
  self notify("end_face_enemy_tracking");
  self endon("interrupt_react_to_bullet");
  self.reactingtobullet = 1;
  self orientmode("face motion");
  var_0 = randomint(anim.runningreacttobullets.size);

  if(var_0 == anim.lastrunningreactanim) {
    var_0 = (var_0 + 1) % anim.runningreacttobullets.size;
  }
  anim.lastrunningreactanim = var_0;
  var_1 = anim.runningreacttobullets[var_0];
  self setflaggedanimknobrestart("reactanim", var_1, 1, 0.5);
  thread reacttobulletsinterruptcheck();
  animscripts\shared::donotetracks("reactanim");
  endrunningreacttobullets();
}

customrunningreacttobullets() {
  self.aim_while_moving_thread = undefined;
  self notify("end_face_enemy_tracking");
  self.reactingtobullet = 1;
  self orientmode("face motion");
  var_0 = randomint(self.run_overridebulletreact.size);
  var_1 = self.run_overridebulletreact[var_0];
  self setflaggedanimknobrestart("reactanim", var_1, 1, 0.5);
  thread reacttobulletsinterruptcheck();
  animscripts\shared::donotetracks("reactanim");
  endrunningreacttobullets();
}

getsprintanim() {
  var_0 = undefined;

  if(isDefined(self.grenade)) {
    var_0 = animscripts\utility::moveanim("sprint_short");
  }
  if(!isDefined(var_0)) {
    var_0 = animscripts\utility::moveanim("sprint");
  }
  return var_0;
}

shouldsprint() {
  if(isDefined(self.sprint)) {
    return 1;
  }
  if(isDefined(self.grenade) && isDefined(self.enemy) && self.frontshieldanglecos == 1) {
    return distancesquared(self.origin, self.enemy.origin) > 90000;
  }
  return 0;
}

shouldsprintforvariation() {
  if(isDefined(self.neversprintforvariation)) {
    return 0;
  }
  if(!self.facemotion || self.stairsstate != "none") {
    return 0;
  }
  var_0 = gettime();

  if(isDefined(self.dangersprinttime)) {
    if(var_0 < self.dangersprinttime) {
      return 1;
    }
    if(var_0 - self.dangersprinttime < 6000) {
      return 0;
    }
  }

  if(!isDefined(self.enemy) || !issentient(self.enemy)) {
    return 0;
  }
  if(randomint(100) < 25 && self lastknowntime(self.enemy) + 2000 > var_0) {
    self.dangersprinttime = var_0 + 2000 + randomint(1000);
    return 1;
  }

  return 0;
}

getmoveplaybackrate() {
  var_0 = self.moveplaybackrate;

  if(self.lookaheadhitsstairs && self.stairsstate == "none" && self.lookaheaddist < 300) {
    var_0 = var_0 * 0.75;
  }
  return var_0;
}

movestandcombatnormal() {
  var_0 = getmoveplaybackrate();
  self setanimknob(%combatrun, 1.0, 0.5, var_0);
  var_1 = 0;

  if(isDefined(self.requestreacttobullet) && gettime() - self.requestreacttobullet < 100 && randomfloat(1) < self.a.reacttobulletchance) {
    stoprunngun();
    runningreacttobullets();
    return;
  }

  if(shouldsprint()) {
    self setflaggedanimknob("runanim", getsprintanim(), 1, 0.5);
    var_1 = 1;
  } else if(isDefined(self.enemy) && animscripts\move::mayshootwhilemoving()) {
    runshootwhilemovingthreads();

    if(!self.facemotion) {
      thread faceenemyaimtracking();
    } else if(self.shootstyle != "none" && !isDefined(self.norunngun)) {
      self notify("end_face_enemy_tracking");
      self.aim_while_moving_thread = undefined;

      if(canshootwhilerunningforward()) {
        var_1 = runngun(1);
      } else if(canshootwhilerunningbackward()) {
        runngun_backward();
        return;
      }
    } else if(isDefined(self.runngunweight) && self.runngunweight != 0) {
      var_1 = runngun(0);
    }
  } else if(isDefined(self.runngunweight) && self.runngunweight != 0) {
    var_1 = runngun(0);
  }
  if(!var_1) {
    stoprunngun();

    if(isDefined(self.requestreacttobullet) && gettime() - self.requestreacttobullet < 100 && self.a.reacttobulletchance != 0) {
      runningreacttobullets();
      return;
    }

    if(shouldsprintforvariation()) {
      var_2 = animscripts\utility::moveanim("sprint_short");
    } else {
      var_2 = getrunanim();
    }
    self setflaggedanimknoblimited("runanim", var_2, 1, 0.1, 1, 1);
    setmovenonforwardanims(animscripts\utility::moveanim("move_b"), animscripts\utility::moveanim("move_l"), animscripts\utility::moveanim("move_r"), self.sidesteprate);
    thread setcombatstandmoveanimweights("run");
  }

  animscripts\notetracks::donotetracksfortime(0.2, "runanim");
  thread stopshootwhilemovingthreads();
}

faceenemyaimtracking() {
  self notify("want_aim_while_moving");

  if(isDefined(self.aim_while_moving_thread)) {
    return;
  }
  self.aim_while_moving_thread = 1;
  self endon("killanimscript");
  self endon("end_face_enemy_tracking");
  self setdefaultaimlimits();

  if(!isDefined(self.combatstandanims) || !isDefined(self.combatstandanims["walk_aims"])) {
    self setanimlimited(%walk_aim_2);
    self setanimlimited(%walk_aim_4);
    self setanimlimited(%walk_aim_6);
    self setanimlimited(%walk_aim_8);
  } else {
    self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_2"]);
    self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_4"]);
    self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_6"]);
    self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_8"]);
  }

  animscripts\track::trackloop(%w_aim_2, %w_aim_4, %w_aim_6, %w_aim_8);
}

endfaceenemyaimtracking() {
  self.aim_while_moving_thread = undefined;
  self notify("end_face_enemy_tracking");
}

runshootwhilemovingthreads() {
  self notify("want_shoot_while_moving");

  if(isDefined(self.shoot_while_moving_thread)) {
    return;
  }
  self.shoot_while_moving_thread = 1;
  thread rundecidewhatandhowtoshoot();
  thread runshootwhilemoving();
}

stopshootwhilemovingthreads() {
  self endon("killanimscript");
  self endon("want_shoot_while_moving");
  self endon("want_aim_while_moving");
  wait 0.05;
  self notify("end_shoot_while_moving");
  self notify("end_face_enemy_tracking");
  self.shoot_while_moving_thread = undefined;
  self.aim_while_moving_thread = undefined;
  self.runngun = undefined;
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
  var_0 = self getmuzzleangle();
  var_1 = vectortoangles(self.enemy getshootatpos() - self getmuzzlepos());

  if(animscripts\utility::absangleclamp180(var_0[1] - var_1[1]) > 15) {
    return 0;
  }
  return animscripts\utility::absangleclamp180(var_0[0] - var_1[0]) <= 20;
}

canshootwhilerunningforward() {
  if((!isDefined(self.runngunweight) || self.runngunweight == 0) && abs(self getmotionangle()) > self.maxrunngunangle) {
    return 0;
  }
  return 1;
}

canshootwhilerunningbackward() {
  if(180 - abs(self getmotionangle()) >= 45) {
    return 0;
  }
  var_0 = getpredictedyawtoenemy(0.2);

  if(abs(var_0) > 30) {
    return 0;
  }
  return 1;
}

canshootwhilerunning() {
  return animscripts\move::mayshootwhilemoving() && isDefined(self.enemy) && (canshootwhilerunningforward() || canshootwhilerunningbackward());
}

getpredictedyawtoenemy(var_0) {
  var_1 = self.origin;
  var_2 = self.angles[1] + self getmotionangle();
  var_1 = var_1 + (cos(var_2), sin(var_2), 0) * length(self.velocity) * var_0;
  var_3 = self.angles[1] - vectortoyaw(self.enemy.origin - var_1);
  var_3 = angleclamp180(var_3);
  return var_3;
}

movestandnoncombatnormal() {
  self endon("movemode");
  self clearanim(%combatrun, 0.6);
  var_0 = getmoveplaybackrate();
  self setanimknoball(%combatrun, %body, 1, 0.2, var_0);

  if(shouldsprint()) {
    var_1 = getsprintanim();
  } else {
    var_1 = getrunanim();
  }
  if(self.stairsstate == "none") {
    var_2 = 0.3;
  } else {
    var_2 = 0.1;
  }
  self setflaggedanimknob("runanim", var_1, 1, var_2, 1, 1);
  setmovenonforwardanims(animscripts\utility::moveanim("move_b"), animscripts\utility::moveanim("move_l"), animscripts\utility::moveanim("move_r"));
  thread setcombatstandmoveanimweights("run");
  animscripts\notetracks::donotetracksfortime(0.2, "runanim");
}

movecrouchrunoverride() {
  self endon("movemode");
  self setflaggedanimknoball("runanim", self.crouchrun_combatanim, %body, 1, 0.4, self.moveplaybackrate);
  animscripts\shared::donotetracks("runanim");
}

movecrouchrunnormal() {
  self endon("movemode");
  var_0 = getcrouchrunanim();
  self setanimknob(var_0, 1, 0.4);
  thread updatemoveanimweights("crouchrun", var_0, %crouch_fastwalk_b, %crouch_fastwalk_l, %crouch_fastwalk_r);
  self setflaggedanimknoball("runanim", %crouchrun, %body, 1, 0.2, self.moveplaybackrate);
  animscripts\notetracks::donotetracksfortime(0.2, "runanim");
}

reloadstandrun() {
  var_0 = isDefined(self.a.allowedpartialreloadontheruntime) && self.a.allowedpartialreloadontheruntime > gettime();
  var_0 = var_0 || isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 65536;

  if(var_0) {
    if(!animscripts\combat_utility::needtoreload(0)) {
      return 0;
    }
  } else if(!animscripts\combat_utility::needtoreload(0.5)) {
    return 0;
  }
  if(isDefined(self.grenade)) {
    return 0;
  }
  if(!self.facemotion || self.stairsstate != "none") {
    return 0;
  }
  if(isDefined(self.dontshootwhilemoving) || isDefined(self.norunreload)) {
    return 0;
  }
  if(canshootwhilerunning() && !animscripts\combat_utility::needtoreload(0)) {
    return 0;
  }
  if(!isDefined(self.pathgoalpos) || distancesquared(self.origin, self.pathgoalpos) < 65536) {
    return 0;
  }
  var_1 = angleclamp180(self getmotionangle());

  if(abs(var_1) > 25) {
    return 0;
  }
  if(!animscripts\utility::usingriflelikeweapon()) {
    return 0;
  }
  if(!runloopisnearbeginning()) {
    return 0;
  }
  reloadstandruninternal();
  self notify("abort_reload");
  self orientmode("face default");
  return 1;
}

reloadstandruninternal() {
  self endon("movemode");
  self orientmode("face motion");
  var_0 = "reload_" + animscripts\combat_utility::getuniqueflagnameindex();
  self setflaggedanimknoballrestart(var_0, %run_lowready_reload, %body, 1, 0.25);
  self.update_move_front_bias = 1;
  setmovenonforwardanims(animscripts\utility::moveanim("move_b"), animscripts\utility::moveanim("move_l"), animscripts\utility::moveanim("move_r"));
  thread setcombatstandmoveanimweights("run");
  animscripts\shared::donotetracks(var_0);
  self.update_move_front_bias = undefined;
}

runloopisnearbeginning() {
  var_0 = self getanimtime(%walk_and_run_loops);
  var_1 = getanimlength(%run_lowready_f) / 3.0;
  var_0 = var_0 * 3.0;

  if(var_0 > 3) {
    var_0 = var_0 - 2.0;
  } else if(var_0 > 2) {
    var_0 = var_0 - 1.0;
  }
  if(var_0 < 0.15 / var_1) {
    return 1;
  }
  if(var_0 > 1 - 0.3 / var_1) {
    return 1;
  }
  return 0;
}

setmovenonforwardanims(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }
  self setanimknoblimited(var_0, 1, 0.1, var_3, 1);
  self setanimknoblimited(var_1, 1, 0.1, var_3, 1);
  self setanimknoblimited(var_2, 1, 0.1, var_3, 1);
}

setcombatstandmoveanimweights(var_0) {
  updatemoveanimweights(var_0, %combatrun_forward, %combatrun_backward, %combatrun_left, %combatrun_right);
}

updatemoveanimweights(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self.update_move_anim_type) && self.update_move_anim_type == var_0) {
    return;
  }
  self notify("stop_move_anim_update");
  self.update_move_anim_type = var_0;
  self.wasfacingmotion = undefined;
  self endon("killanimscript");
  self endon("move_interrupt");
  self endon("stop_move_anim_update");

  for(;;) {
    updaterunweightsonce(var_1, var_2, var_3, var_4);
    wait 0.05;
    waittillframeend;
  }
}

updaterunweightsonce(var_0, var_1, var_2, var_3) {
  if(self.facemotion && !animscripts\utility::shouldcqb() && !isDefined(self.update_move_front_bias)) {
    if(!isDefined(self.wasfacingmotion)) {
      self.wasfacingmotion = 1;
      self setanim(var_0, 1, 0.2, 1, 1);
      self setanim(var_1, 0, 0.2, 1, 1);
      self setanim(var_2, 0, 0.2, 1, 1);
      self setanim(var_3, 0, 0.2, 1, 1);
    }
  } else {
    self.wasfacingmotion = undefined;
    var_4 = animscripts\utility::quadrantanimweights(self getmotionangle());

    if(isDefined(self.update_move_front_bias)) {
      var_4["back"] = 0.0;

      if(var_4["front"] < 0.2) {
        var_4["front"] = 0.2;
      }
    }

    self setanim(var_0, var_4["front"], 0.2, 1, 1);
    self setanim(var_1, var_4["back"], 0.2, 1, 1);
    self setanim(var_2, var_4["left"], 0.2, 1, 1);
    self setanim(var_3, var_4["right"], 0.2, 1, 1);
  }
}

changeweaponstandrun() {
  var_0 = isDefined(self.wantshotgun) && self.wantshotgun;
  var_1 = animscripts\utility::isshotgun(self.weapon);

  if(var_0 == var_1) {
    return 0;
  }
  if(!isDefined(self.pathgoalpos) || distancesquared(self.origin, self.pathgoalpos) < 65536) {
    return 0;
  }
  if(animscripts\utility::usingsidearm()) {
    return 0;
  }
  if(self.weapon == self.primaryweapon) {
    if(!var_0) {
      return 0;
    }
    if(animscripts\utility::isshotgun(self.secondaryweapon)) {
      return 0;
    }
  } else {
    if(var_0) {
      return 0;
    }
    if(animscripts\utility::isshotgun(self.primaryweapon)) {
      return 0;
    }
  }

  var_2 = angleclamp180(self getmotionangle());

  if(abs(var_2) > 25) {
    return 0;
  }
  if(!runloopisnearbeginning()) {
    return 0;
  }
  if(var_0) {
    shotgunswitchstandruninternal("shotgunPullout", %shotgun_cqbrun_pullout, "gun_2_chest", "none", self.secondaryweapon, "shotgun_pickup");
  } else {
    shotgunswitchstandruninternal("shotgunPutaway", %shotgun_cqbrun_putaway, "gun_2_back", "back", self.primaryweapon, "shotgun_pickup");
  }
  self notify("switchEnded");
  return 1;
}

shotgunswitchstandruninternal(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("movemode");
  self setflaggedanimknoballrestart(var_0, var_1, %body, 1, 0.25);
  self.update_move_front_bias = 1;
  setmovenonforwardanims(animscripts\utility::moveanim("move_b"), animscripts\utility::moveanim("move_l"), animscripts\utility::moveanim("move_r"));
  thread setcombatstandmoveanimweights("run");
  thread watchshotgunswitchnotetracks(var_0, var_2, var_3, var_4, var_5);
  animscripts\notetracks::donotetracksfortimeintercept(getanimlength(var_1) - 0.25, var_0, ::interceptnotetracksforweaponswitch);
  self.update_move_front_bias = undefined;
}

interceptnotetracksforweaponswitch(var_0) {
  if(var_0 == "gun_2_chest" || var_0 == "gun_2_back") {
    return 1;
  }
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