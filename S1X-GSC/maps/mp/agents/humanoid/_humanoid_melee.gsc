/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\humanoid\_humanoid_melee.gsc
*******************************************************/

main() {
  self endon("death");
  self endon("killanimscript");
  self.curmeleetarget endon("disconnect");
  var_0 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);

  if(ismeleeblocked()) {
    return meleefailed();
  }

  if(maps\mp\zombies\_util::is_true(self.lungemeleeenabled) && var_0.valid) {
    if(!isDefined(self.lungelast)) {
      self.lungelast = 0;
    }

    if(isDefined(self.meleemovemode)) {
      var_1 = gettime() - self.lungelast > self.lungedebouncems;
      var_2 = maps\mp\agents\humanoid\_humanoid_util::canhumanoidmovepointtopoint(self.origin, var_0.origin);
      var_3 = distancesquared(self.curmeleetarget.origin, self.origin) > self.lungeminrangesq;

      if(var_1 && var_2 && var_3) {
        self.lungelast = gettime();
        doattacklunge(self.curmeleetarget, var_0.origin);
        return;
      }
    }

    if(!maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase()) {
      lungemeleefailed();
      return;
    }
  }

  doattackstandard(self.curmeleetarget, var_0.origin);
}

ismeleeblocked() {
  var_0 = self.origin + (0, 0, self.meleecheckheight);
  var_1 = self.curmeleetarget.origin + (0, 0, self.meleecheckheight);
  var_2 = undefined;

  if(isDefined(self.curmeleetarget.classname) && self.curmeleetarget.classname == "misc_turret" && isDefined(self.curmeleetarget.aiclip)) {
    var_2 = physicstrace(var_0, var_1, self.curmeleetarget.aiclip);
  } else {
    var_2 = physicstrace(var_0, var_1);
  }

  return distancesquared(var_2, var_1) > 1;
}

end_script() {
  self scragentsetanimscale(1, 1);
}

doattack(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self.lastmeleefailedmypos = undefined;
  self.lastmeleefailedpos = undefined;

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_7 = randomint(self getanimentrycount(var_2));
  var_8 = self getanimentry(var_2, var_7);
  var_9 = getanimlength(var_8);
  var_10 = getnotetracktimes(var_8, "hit");
  var_11 = var_9 / var_5 * 0.33;

  if(var_10.size > 0) {
    var_11 = var_9 / var_5 * var_10[0];
  }

  self scragentsetphysicsmode("gravity");

  if(var_4) {
    self scragentsetorientmode("face enemy");
  } else {
    self scragentsetorientmode("face angle abs", (0, vectortoyaw(var_0.origin - self.origin), 0));
  }

  self scragentsetanimmode("anim deltas");
  maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_2, var_7, var_5);

  if(var_6) {
    var_12 = getnotetracktimes(var_8, "lunge_start");
    var_13 = 0;

    if(var_12.size > 0) {
      var_13 = var_9 / var_5 * var_12[0];
    }

    var_11 = var_11 - var_13;

    if(var_13 > 0) {
      wait(var_13);
    }

    maps\mp\agents\humanoid\_humanoid_util::play_boost_fx(self.lungefx);

    if(self.lungeanimratescale) {
      var_14 = var_1 - self.origin;
      var_15 = getmovedelta(var_8, var_12[0], var_10[0]);
      var_16 = maps\mp\agents\_scripted_agent_anim_util::getanimscalefactors(var_14, var_15);
      var_5 = var_5 * clamp(1 / var_16.xy, 0.5, 1);
      var_11 = var_9 / var_5 * var_10[0] - var_9 / var_5 * var_12[0];
      maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_2 + "_norestart", var_7, var_5);
    }
  }

  if(var_3) {
    self scragentsetanimscale(0, 1);
    self scragentdoanimlerp(self.origin, var_1, var_11);
    childthread updatelerppos(var_0, var_11, 1, self.lungelerprange);
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "DoAttack");
  } else {
    self scragentsetanimscale(1, 1);
  }

  wait(var_11);
  self notify("cancel_updatelerppos");
  self scragentsetanimmode("anim deltas");
  self scragentsetanimscale(1, 1);

  if(var_3) {
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoAttack");
  }

  if(attackshouldhit(var_0)) {
    self notify("attack_hit", var_0, var_1);
    var_17 = 0;

    if(isDefined(var_0)) {
      var_17 = var_0.health;
    }

    if(isDefined(self.meleedamage)) {
      var_17 = self.meleedamage;
    }

    if(isalive(var_0)) {
      domeleedamage(var_0, var_17, "MOD_IMPACT");
    }
  } else {
    self notify("attack_miss", var_0, var_1);
  }

  self.lastmeleepos = self.origin;
  var_18 = var_9 / var_5 - var_11;

  if(var_18 > 0) {
    maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("attack_anim", "end", var_18);
  }

  self.lastmeleefinishtime = gettime();
}

attackshouldhit(var_0) {
  if(!isalive(var_0)) {
    return 0;
  }

  if(!withinmeleedamagerange()) {
    return 0;
  }

  if(isenemyinfrontofme(var_0, self.meleedot)) {
    return 1;
  }

  if(maps\mp\agents\humanoid\_humanoid_util::isentstandingonme(var_0)) {
    return 1;
  }

  return 0;
}

isenemyinfrontofme(var_0, var_1) {
  var_2 = vectornormalize((var_0.origin - self.origin) * (1, 1, 0));
  var_3 = anglesToForward(self.angles);
  var_4 = vectordot(var_2, var_3);
  return var_4 > var_1;
}

withinmeleedamagerange() {
  if(!maps\mp\agents\humanoid\_humanoid::readytomeleetarget("normal")) {
    return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid_util::getmeleeradius() > self.meleeradiusbase && !maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase()) {
    return 0;
  }

  return 1;
}

doattackstandard(var_0, var_1) {
  var_2 = "attack_stand";
  var_3 = self.nonmoveratescale;
  var_4 = 0;

  if(isDefined(self.meleemovemode)) {
    var_2 = "attack_" + self.meleemovemode;
    var_4 = 1;
    self.meleemovemode = undefined;
  }

  doattack(var_0, var_1, var_2, 0, var_4, var_3);
}

doattacklunge(var_0, var_1) {
  doattack(var_0, var_1, self.lungeanimstate, 1, 1, self.nonmoveratescale, 1);
}

updatelerppos(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_4 = self.origin;
  var_5 = var_1;
  var_6 = 0.05;

  for(;;) {
    wait(var_6);
    var_5 = var_5 - var_6;

    if(var_5 <= 0) {
      break;
    }

    var_7 = getupdatedattackpos(var_0, var_2);

    if(!isDefined(var_7)) {
      break;
    }

    if(isDefined(var_3)) {
      var_8 = var_3;
    } else {
      var_8 = maps\mp\agents\humanoid\_humanoid_util::getmeleeradius() - self.radius;
    }

    var_9 = var_7 - var_4;

    if(lengthsquared(var_9) > var_8 * var_8) {
      var_7 = var_4 + vectornormalize(var_9) * var_8;
    }

    self scragentsetorientmode("face enemy");
    self scragentdoanimlerp(self.origin, var_7, var_5);
  }
}

getupdatedattackpos(var_0, var_1) {
  if(!var_1) {
    var_2 = maps\mp\zombies\_util::droppostoground(var_0.origin);
    return var_2;
  } else {
    var_3 = var_0.origin - self.origin;
    var_4 = length(var_3);

    if(var_4 < self.attackoffset) {
      return self.origin;
    } else {
      var_3 = var_3 / var_4;
      var_5 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(var_0);

      if(maps\mp\agents\humanoid\_humanoid_util::canhumanoidmovepointtopoint(self.origin, var_5.origin)) {
        return var_5.origin;
      } else {
        return undefined;
      }
    }
  }
}

isprotectedbyriotshield(var_0) {
  if(var_0 maps\mp\_riotshield::hasriotshield()) {
    var_1 = self.origin - var_0.origin;
    var_2 = vectornormalize((var_1[0], var_1[1], 0));
    var_3 = anglesToForward(var_0.angles);
    var_4 = vectordot(var_3, var_1);

    if(var_0 maps\mp\_riotshield::hasriotshieldequipped()) {
      if(var_4 > 0.766) {
        return 1;
      }
    } else if(var_4 < -0.766) {
      return 1;
    }
  }

  return 0;
}

domeleedamage(var_0, var_1, var_2) {
  if(isprotectedbyriotshield(var_0)) {
    return;
  }
  var_0 dodamage(var_1, self.origin, self, self, var_2);
}

meleefailed() {
  self.lastmeleefailedmypos = self.origin;
  self.lastmeleefailedpos = self.curmeleetarget.origin;
}

lungemeleefailed() {
  self.lastlungemeleefailedmypos = self.origin;
  self.lastlungemeleefailedpos = self.curmeleetarget.origin;
}