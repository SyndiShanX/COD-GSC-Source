/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\reactions.gsc
********************************/

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
  anim.longestrunwizby = 0;

  foreach(var_2 in var_0) {
    var_3 = length(getmovedelta(var_2, 0, 1));

    if(var_3 > anim.longestrunwizby) {
      anim.longestrunwizby = var_3;
    }
  }

  anim.lastrunningreactanim = 0;
}

reactionscheckloop() {
  thread bulletwhizbycheckloop();
}

canreactagain() {
  return !isDefined(self.lastreacttime) || gettime() - self.lastreacttime > 2000;
}

bulletwhizbyreaction() {
  var_0 = gettime();
  self endon("killanimscript");
  self.lastreacttime = gettime();
  self.a.movement = "stop";
  var_1 = isDefined(self.whizbyenemy) && distancesquared(self.origin, self.whizbyenemy.origin) < 160000;
  self animmode("gravity");
  self orientmode("face current");

  if(isDefined(self.disable_crouch_whizby_react) || var_1 || common_scripts\utility::cointoss()) {
    self clearanim( % animscript_root, 0.1);
    var_2 = [];

    if(animscripts\utility::usingsmg()) {
      var_2[0] = % smg_exposed_idle_reacta;
      var_2[1] = % smg_exposed_idle_reactb;
      var_2[2] = % smg_exposed_idle_twitch;
      var_2[3] = % smg_exposed_idle_twitch_v4;
    } else {
      var_2[0] = % exposed_idle_reacta;
      var_2[1] = % exposed_idle_reactb;
      var_2[2] = % exposed_idle_twitch;
      var_2[3] = % exposed_idle_twitch_v4;
    }

    var_3 = var_2[randomint(var_2.size)];

    if(var_1) {
      var_4 = 1 + randomfloat(0.5);
    } else {
      var_4 = 0.2 + randomfloat(0.5);
    }

    self setflaggedanimknobrestart("reactanim", var_3, 1, 0.1, 1);
    animscripts\notetracks::donotetracksfortime(var_4, "reactanim");
    self clearanim( % animscript_root, 0.1);

    if(!var_1 && self.stairsstate == "none" && !isDefined(self.disable_dive_whizby_react)) {
      var_5 = 1 + randomfloat(0.2);
      var_6 = animscripts\utility::randomanimoftwo( % exposed_dive_grenade_b, % exposed_dive_grenade_f);
      self setflaggedanimknobrestart("dive", var_6, 1, 0.1, var_5);
      animscripts\shared::donotetracks("dive");
    }
  } else {
    wait(randomfloat(0.2));
    var_5 = 1.2 + randomfloat(0.3);

    if(self.a.pose == "stand") {
      self clearanim( % animscript_root, 0.1);
      self setflaggedanimknobrestart("crouch", % exposed_stand_2_crouch, 1, 0.1, var_5);
      animscripts\shared::donotetracks("crouch");
    }

    var_7 = anglesToForward(self.angles);

    if(isDefined(self.whizbyenemy)) {
      var_8 = vectornormalize(self.whizbyenemy.origin - self.origin);
    } else {
      var_8 = var_7;
    }

    if(vectordot(var_8, var_7) > 0) {
      var_9 = animscripts\utility::randomanimoftwo( % exposed_crouch_idle_twitch_v2, % exposed_crouch_idle_twitch_v3);
      self clearanim( % animscript_root, 0.1);
      self setflaggedanimknobrestart("twitch", var_9, 1, 0.1, 1);
      animscripts\shared::donotetracks("twitch");
    } else {
      var_10 = animscripts\utility::randomanimoftwo( % exposed_crouch_turn_180_left, % exposed_crouch_turn_180_right);
      self clearanim( % animscript_root, 0.1);
      self setflaggedanimknobrestart("turn", var_10, 1, 0.1, 1);
      animscripts\shared::donotetracks("turn");
    }
  }

  self clearanim( % animscript_root, 0.1);
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

    if(isDefined(self.disablebulletwhizbyreaction)) {
      return;
    }
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

    if(animscripts\utility::usingsmg()) {
      var_5[0] = % smg_exposed_backpedal;
      var_5[1] = % smg_exposed_idle_reactb;
    } else if(isDefined(self.animarchetype) && self.animarchetype == "s1_soldier") {
      var_5[0] = % s1_exposed_backpedal;
      var_5[1] = % s1_exposed_idle_alert_v5;
    } else {
      var_5[0] = % exposed_backpedal;
      var_5[1] = % exposed_idle_reactb;
    }

    if(isDefined(self.enemy) && distancesquared(self.enemy.origin, self.reactiontargetpos) < 65536) {
      self orientmode("face enemy");
    } else {
      self orientmode("face point", self.reactiontargetpos);
    }

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
  self clearanim( % animscript_root, 0.2);

  if(randomint(4) < 3) {
    self orientmode("face enemy");
    var_0 = % exposed_idle_reactb;

    if(animscripts\utility::usingsmg()) {
      var_0 = % smg_exposed_idle_reactb;
    }

    self setflaggedanimknobrestart("reactanim", var_0, 1, 0.2, 1);
    var_1 = getanimlength(var_0);
    animscripts\notetracks::donotetracksfortime(var_1 * 0.8, "reactanim");
    self orientmode("face current");
  } else {
    self orientmode("face enemy");
    var_2 = % exposed_backpedal;
    var_3 = % exposed_backpedal_v2;

    if(animscripts\utility::usingsmg()) {
      var_2 = % smg_exposed_backpedal;
      var_3 = % smg_exposed_backpedal_v2;
    }

    self setflaggedanimknobrestart("reactanim", var_2, 1, 0.2, 1);
    var_1 = getanimlength(var_2);
    animscripts\notetracks::donotetracksfortime(var_1 * 0.8, "reactanim");
    self orientmode("face current");
    self clearanim( % animscript_root, 0.2);
    self setflaggedanimknobrestart("reactanim", var_3, 1, 0.2, 1);
    animscripts\shared::donotetracks("reactanim");
  }
}

newenemyreactionanim() {
  self endon("death");
  self endon("endNewEnemyReactionAnim");
  self.lastreacttime = gettime();
  self.a.movement = "stop";
  self.playing_new_enemy_reaction_anim = 1;

  if(isDefined(self._stealth) && self.alertlevel != "combat") {
    stealthnewenemyreactanim();
  } else {
    var_0 = getnewenemyreactionanim();
    self clearanim( % animscript_root, 0.2);
    self setflaggedanimknobrestart("reactanim", var_0, 1, 0.2, 1);
    animscripts\shared::donotetracks("reactanim");
  }

  self notify("newEnemyReactionDone");
  self.playing_new_enemy_reaction_anim = undefined;
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

  if(isDefined(self.enemy)) {
    newenemyreactionanim();
  }
}

end_script() {
  if(isDefined(self.playing_new_enemy_reaction_anim)) {
    self notify("newEnemyReactionDone");
    self.playing_new_enemy_reaction_anim = undefined;
  }
}