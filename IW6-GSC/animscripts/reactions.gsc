/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\reactions.gsc
*****************************************************/

main() {
  self endon("killanimscript");
  animscripts\utility::initialize("reactions");
  newenemysurprisedreaction();
}

#using_animtree("generic_human");

init_animset_reactions() {
  var_0 = [];
  var_0["cover_stand"] = [ % stand_cover_reaction_a, % stand_cover_reaction_b];
  var_0["cover_crouch"] = [ % stand_cover_reaction_a, % stand_cover_reaction_b];
  var_0["cover_left"] = [ % stand_cover_reaction_a, % stand_cover_reaction_b];
  var_0["cover_right"] = [ % stand_cover_reaction_a, % stand_cover_reaction_b];
  anim.archetypes["soldier"]["cover_reactions"] = var_0;
  var_0 = [];
  var_0[0] = % run_wizby_a;
  var_0[1] = % run_wizby_b;
  anim.archetypes["soldier"]["running_react_to_bullets"] = var_0;
  anim.lastrunningreactanim = 0;
}

reactionscheckloop() {
  thread bulletwhizbycheckloop();
}

canreactagain() {
  return !isDefined(self.lastreacttime) || gettime() - self.lastreacttime > 2000;
}

bulletwhizbyreaction() {
  self endon("killanimscript");
  self.lastreacttime = gettime();
  self.a.movement = "stop";
  var_0 = isDefined(self.whizbyenemy) && distancesquared(self.origin, self.whizbyenemy.origin) < 160000;
  self animmode("gravity");
  self orientmode("face current");

  if(var_0 || common_scripts\utility::cointoss()) {
    self clearanim( % root, 0.1);
    var_1 = [];
    var_1[0] = % exposed_idle_reacta;
    var_1[1] = % exposed_idle_reactb;
    var_1[2] = % exposed_idle_twitch;
    var_1[3] = % exposed_idle_twitch_v4;
    var_2 = var_1[randomint(var_1.size)];

    if(var_0)
      var_3 = 1 + randomfloat(0.5);
    else
      var_3 = 0.2 + randomfloat(0.5);

    self setflaggedanimknobrestart("reactanim", var_2, 1, 0.1, 1);
    animscripts\notetracks::donotetracksfortime(var_3, "reactanim");
    self clearanim( % root, 0.1);

    if(!var_0 && self.stairsstate == "none" && !isDefined(self.disable_dive_whizby_react)) {
      var_4 = 1 + randomfloat(0.2);
      var_5 = animscripts\utility::randomanimoftwo( % exposed_dive_grenade_b, % exposed_dive_grenade_f);
      self setflaggedanimknobrestart("dive", var_5, 1, 0.1, var_4);
      animscripts\shared::donotetracks("dive");
    }
  } else {
    wait(randomfloat(0.2));
    var_4 = 1.2 + randomfloat(0.3);

    if(self.a.pose == "stand") {
      self clearanim( % root, 0.1);
      self setflaggedanimknobrestart("crouch", % exposed_stand_2_crouch, 1, 0.1, var_4);
      animscripts\shared::donotetracks("crouch");
    }

    var_6 = anglesToForward(self.angles);

    if(isDefined(self.whizbyenemy))
      var_7 = vectornormalize(self.whizbyenemy.origin - self.origin);
    else
      var_7 = var_6;

    if(vectordot(var_7, var_6) > 0) {
      var_8 = animscripts\utility::randomanimoftwo( % exposed_crouch_idle_twitch_v2, % exposed_crouch_idle_twitch_v3);
      self clearanim( % root, 0.1);
      self setflaggedanimknobrestart("twitch", var_8, 1, 0.1, 1);
      animscripts\shared::donotetracks("twitch");
    } else {
      var_9 = animscripts\utility::randomanimoftwo( % exposed_crouch_turn_180_left, % exposed_crouch_turn_180_right);
      self clearanim( % root, 0.1);
      self setflaggedanimknobrestart("turn", var_9, 1, 0.1, 1);
      animscripts\shared::donotetracks("turn");
    }
  }

  self clearanim( % root, 0.1);
  self.whizbyenemy = undefined;
  self animmode("normal");
  self orientmode("face default");
}

bulletwhizbycheckloop() {
  self endon("killanimscript");

  if(isDefined(self.disablebulletwhizbyreaction)) {
    return;
  }
  for(;;) {
    self waittill("bulletwhizby", var_0);

    if(!isDefined(var_0.team) || self.team == var_0.team) {
      continue;
    }
    if(isDefined(self.covernode) || isDefined(self.ambushnode)) {
      continue;
    }
    if(self.a.pose != "stand") {
      continue;
    }
    if(!canreactagain()) {
      continue;
    }
    self.whizbyenemy = var_0;
    self animcustom(::bulletwhizbyreaction);
  }
}

clearlookatthread() {
  self endon("killanimscript");
  wait 0.3;
  self setlookatentity();
}

getnewenemyreactionanim() {
  var_0 = undefined;

  if(self nearclaimnodeandangle()) {
    var_1 = animscripts\utility::lookupanimarray("cover_reactions");

    if(isDefined(var_1[self.prevscript])) {
      var_2 = anglesToForward(self.node.angles);
      var_3 = vectornormalize(self.reactiontargetpos - self.origin);

      if(vectordot(var_2, var_3) < -0.5) {
        self orientmode("face current");
        var_4 = randomint(var_1[self.prevscript].size);
        var_0 = var_1[self.prevscript][var_4];
      }
    }
  }

  if(!isDefined(var_0)) {
    var_5 = [];
    var_5[0] = % exposed_backpedal;
    var_5[1] = % exposed_idle_reactb;

    if(isDefined(self.enemy) && distancesquared(self.enemy.origin, self.reactiontargetpos) < 65536)
      self orientmode("face enemy");
    else
      self orientmode("face point", self.reactiontargetpos);

    if(self.a.pose == "crouch") {
      var_3 = vectornormalize(self.reactiontargetpos - self.origin);
      var_6 = anglesToForward(self.angles);

      if(vectordot(var_6, var_3) < -0.5) {
        self orientmode("face current");
        var_5[0] = % crouch_cover_reaction_a;
        var_5[1] = % crouch_cover_reaction_b;
      }
    }

    var_0 = var_5[randomint(var_5.size)];
  }

  return var_0;
}

stealthnewenemyreactanim() {
  self clearanim( % root, 0.2);

  if(randomint(4) < 3) {
    self orientmode("face enemy");
    self setflaggedanimknobrestart("reactanim", % exposed_idle_reactb, 1, 0.2, 1);
    var_0 = getanimlength( % exposed_idle_reactb);
    animscripts\notetracks::donotetracksfortime(var_0 * 0.8, "reactanim");
    self orientmode("face current");
  } else {
    self orientmode("face enemy");
    self setflaggedanimknobrestart("reactanim", % exposed_backpedal, 1, 0.2, 1);
    var_0 = getanimlength( % exposed_backpedal);
    animscripts\notetracks::donotetracksfortime(var_0 * 0.8, "reactanim");
    self orientmode("face current");
    self clearanim( % root, 0.2);
    self setflaggedanimknobrestart("reactanim", % exposed_backpedal_v2, 1, 0.2, 1);
    animscripts\shared::donotetracks("reactanim");
  }
}

newenemyreactionanim() {
  self endon("death");
  self endon("endNewEnemyReactionAnim");
  self.lastreacttime = gettime();
  self.a.movement = "stop";

  if(isDefined(self._stealth) && self.alertlevel != "combat")
    stealthnewenemyreactanim();
  else {
    var_0 = getnewenemyreactionanim();
    self clearanim( % root, 0.2);
    self setflaggedanimknobrestart("reactanim", var_0, 1, 0.2, 1);
    animscripts\shared::donotetracks("reactanim");
  }

  self notify("newEnemyReactionDone");
}

newenemysurprisedreaction() {
  self endon("death");

  if(isDefined(self.disablereactionanims)) {
    return;
  }
  if(!canreactagain()) {
    return;
  }
  if(self.a.pose == "prone" || isDefined(self.a.onback)) {
    return;
  }
  self animmode("gravity");

  if(isDefined(self.enemy))
    newenemyreactionanim();
}