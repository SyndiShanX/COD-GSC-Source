/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\reactions.gsc
**************************************/

main() {
  self endon("killanimscript");
  animscripts\utility::_id_0D15("reactions");
  _id_0F2C();
}

#using_animtree("generic_human");

_id_0F1C() {
  anim._id_0F1D = [];
  anim._id_0F1D[anim._id_0F1D.size] = % run_react_duck;
  anim._id_0F1D[anim._id_0F1D.size] = % run_react_flinch;
  anim._id_0F1D[anim._id_0F1D.size] = % run_react_stumble;
  anim._id_0F1E = 0;
  anim._id_0F1F = [];
  anim._id_0F1F["cover_stand"] = animscripts\utility::_id_0C6D(%stand_cover_reaction_a, %stand_cover_reaction_b);
  anim._id_0F1F["cover_crouch"] = animscripts\utility::_id_0C6D(%crouch_cover_reaction_a, %crouch_cover_reaction_b);
  anim._id_0F1F["cover_left"] = animscripts\utility::_id_0C6D(%cornerstndl_react_a);
  anim._id_0F1F["cover_right"] = animscripts\utility::_id_0C6D(%cornerstndr_react_a);
}

_id_0F20() {
  thread _id_0F27();
}

_id_0F21() {
  return !isDefined(self._id_0F22) || gettime() - self._id_0F22 > 2000;
}

_id_0F23() {
  self endon("killanimscript");
  self._id_0F22 = gettime();
  self.a._id_0D2B = "stop";
  var_0 = isDefined(self._id_0F24) && distancesquared(self.origin, self._id_0F24.origin) < 160000;
  self animmode("gravity");
  self orientmode("face current");

  if(var_0 || common_scripts\utility::cointoss()) {
    self clearanim(%root, 0.1);
    var_1 = [];
    var_1[0] = % exposed_idle_reacta;
    var_1[1] = % exposed_idle_reactb;
    var_1[2] = % exposed_idle_twitch;
    var_1[3] = % exposed_idle_twitch_v4;
    var_2 = var_1[randomint(var_1.size)];

    if(var_0) {
      var_3 = 1 + randomfloat(0.5);
    } else {
      var_3 = 0.2 + randomfloat(0.5);
    }
    self setflaggedanimknobrestart("reactanim", var_2, 1, 0.1, 1);
    animscripts\notetracks::_id_0D4F(var_3, "reactanim");
    self clearanim(%root, 0.1);

    if(!var_0 && self.stairsstate == "none" && !isDefined(self._id_0F25)) {
      var_4 = 1 + randomfloat(0.2);
      var_5 = animscripts\utility::_id_0F26(%exposed_dive_grenade_b, %exposed_dive_grenade_f);
      self setflaggedanimknobrestart("dive", var_5, 1, 0.1, var_4);
      animscripts\shared::_id_0C51("dive");
    }
  } else {
    wait(randomfloat(0.2));
    var_4 = 1.2 + randomfloat(0.3);

    if(self.a._id_0D26 == "stand") {
      self clearanim(%root, 0.1);
      self setflaggedanimknobrestart("crouch", %exposed_stand_2_crouch, 1, 0.1, var_4);
      animscripts\shared::_id_0C51("crouch");
    }

    var_6 = anglesToForward(self.angles);

    if(isDefined(self._id_0F24)) {
      var_7 = vectornormalize(self._id_0F24.origin - self.origin);
    } else {
      var_7 = var_6;
    }
    if(vectordot(var_7, var_6) > 0) {
      var_8 = animscripts\utility::_id_0F26(%exposed_crouch_idle_twitch_v2, %exposed_crouch_idle_twitch_v3);
      self clearanim(%root, 0.1);
      self setflaggedanimknobrestart("twitch", var_8, 1, 0.1, 1);
      animscripts\shared::_id_0C51("twitch");
    } else {
      var_9 = animscripts\utility::_id_0F26(%exposed_crouch_turn_180_left, %exposed_crouch_turn_180_right);
      self clearanim(%root, 0.1);
      self setflaggedanimknobrestart("turn", var_9, 1, 0.1, 1);
      animscripts\shared::_id_0C51("turn");
    }
  }

  self clearanim(%root, 0.1);
  self._id_0F24 = undefined;
  self animmode("normal");
  self orientmode("face default");
}

_id_0F27() {
  self endon("killanimscript");

  if(isDefined(self._id_0EEE)) {
    return;
  }
  for(;;) {
    self waittill("bulletwhizby", var_0);

    if(!isDefined(var_0.team) || self.team == var_0.team) {
      continue;
    }
    if(isDefined(self._id_0CAF) || isDefined(self._id_0CF1)) {
      continue;
    }
    if(self.a._id_0D26 != "stand") {
      continue;
    }
    if(!_id_0F21()) {
      continue;
    }
    self._id_0F24 = var_0;
    self animcustom(::_id_0F23);
  }
}

_id_0F28() {
  self endon("killanimscript");
  wait 0.3;
  self setlookatentity();
}

_id_0F29() {
  var_0 = undefined;

  if(self nearclaimnodeandangle() && isDefined(anim._id_0F1F[self.prevscript])) {
    var_1 = anglesToForward(self.node.angles);
    var_2 = vectornormalize(self.reactiontargetpos - self.origin);

    if(vectordot(var_1, var_2) < -0.5) {
      self orientmode("face current");
      var_3 = randomint(anim._id_0F1F[self.prevscript].size);
      var_0 = anim._id_0F1F[self.prevscript][var_3];
    }
  }

  if(!isDefined(var_0)) {
    var_4 = [];
    var_4[0] = % exposed_backpedal;
    var_4[1] = % exposed_idle_reactb;

    if(isDefined(self.enemy) && distancesquared(self.enemy.origin, self.reactiontargetpos) < 65536) {
      self orientmode("face enemy");
    } else {
      self orientmode("face point", self.reactiontargetpos);
    }
    if(self.a._id_0D26 == "crouch") {
      var_2 = vectornormalize(self.reactiontargetpos - self.origin);
      var_5 = anglesToForward(self.angles);

      if(vectordot(var_5, var_2) < -0.5) {
        self orientmode("face current");
        var_4[0] = % crouch_cover_reaction_a;
        var_4[1] = % crouch_cover_reaction_b;
      }
    }

    var_0 = var_4[randomint(var_4.size)];
  }

  return var_0;
}

_id_0F2A() {
  self clearanim(%root, 0.2);

  if(randomint(4) < 3) {
    self orientmode("face enemy");
    self setflaggedanimknobrestart("reactanim", %exposed_idle_reactb, 1, 0.2, 1);
    var_0 = getanimlength(%exposed_idle_reactb);
    animscripts\notetracks::_id_0D4F(var_0 * 0.8, "reactanim");
    self orientmode("face current");
  } else {
    self orientmode("face enemy");
    self setflaggedanimknobrestart("reactanim", %exposed_backpedal, 1, 0.2, 1);
    var_0 = getanimlength(%exposed_backpedal);
    animscripts\notetracks::_id_0D4F(var_0 * 0.8, "reactanim");
    self orientmode("face current");
    self clearanim(%root, 0.2);
    self setflaggedanimknobrestart("reactanim", %exposed_backpedal_v2, 1, 0.2, 1);
    animscripts\shared::_id_0C51("reactanim");
  }
}

_id_0F2B() {
  self endon("death");
  self endon("endNewEnemyReactionAnim");
  self._id_0F22 = gettime();
  self.a._id_0D2B = "stop";

  if(isDefined(self._id_0B6E) && self.alertlevel != "combat") {
    _id_0F2A();
  } else {
    var_0 = _id_0F29();
    self clearanim(%root, 0.2);
    self setflaggedanimknobrestart("reactanim", var_0, 1, 0.2, 1);
    animscripts\shared::_id_0C51("reactanim");
  }

  self notify("newEnemyReactionDone");
}

_id_0F2C() {
  self endon("death");

  if(isDefined(self._id_0F2D)) {
    return;
  }
  if(!_id_0F21()) {
    return;
  }
  if(self.a._id_0D26 == "prone" || isDefined(self.a._id_0D29)) {
    return;
  }
  self animmode("gravity");

  if(isDefined(self.enemy)) {
    _id_0F2B();
  }
}