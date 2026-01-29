/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\riotshield\riotshield.gsc
*************************************************/

#using_animtree("generic_human");

_id_3AB4() {
  anim._id_1E72["detach shield"] = ::_id_3AB5;
  animscripts\init_move_transitions::_id_2082();
  anim._id_1164["riotshield"] = [];
  anim._id_1164["riotshield"][1] = % riotshield_run_approach_1;
  anim._id_1164["riotshield"][2] = % riotshield_run_approach_2;
  anim._id_1164["riotshield"][3] = % riotshield_run_approach_3;
  anim._id_1164["riotshield"][4] = % riotshield_run_approach_4;
  anim._id_1164["riotshield"][6] = % riotshield_run_approach_6;
  anim._id_1164["riotshield"][7] = undefined;
  anim._id_1164["riotshield"][8] = % riotshield_walk2crouch_8;
  anim._id_1164["riotshield"][9] = undefined;
  anim._id_1164["riotshield_crouch"] = [];
  anim._id_1164["riotshield_crouch"][1] = % riotshield_walk_approach_1;
  anim._id_1164["riotshield_crouch"][2] = % riotshield_walk_approach_2;
  anim._id_1164["riotshield_crouch"][3] = % riotshield_walk_approach_3;
  anim._id_1164["riotshield_crouch"][4] = % riotshield_walk_approach_4;
  anim._id_1164["riotshield_crouch"][6] = % riotshield_walk_approach_6;
  anim._id_1164["riotshield_crouch"][7] = undefined;
  anim._id_1164["riotshield_crouch"][8] = % riotshield_walk2crouch_8;
  anim._id_1164["riotshield_crouch"][9] = undefined;
  var_0 = [];
  var_0[0] = "riotshield";
  var_0[1] = "riotshield_crouch";

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    for(var_3 = 1; var_3 <= 9; var_3++) {
      if(var_3 == 5) {
        continue;
      }
      if(isDefined(anim._id_1164[var_2][var_3])) {
        anim._id_1186[var_2][var_3] = getmovedelta(anim._id_1164[var_2][var_3], 0, 1);
      }
    }
  }

  anim._id_1187["riotshield_crouch"][1] = 45;
  anim._id_1187["riotshield_crouch"][2] = 0;
  anim._id_1187["riotshield_crouch"][3] = -45;
  anim._id_1187["riotshield_crouch"][4] = 90;
  anim._id_1187["riotshield_crouch"][6] = -90;
  anim._id_1187["riotshield_crouch"][8] = 180;
  anim._id_1187["riotshield"][1] = 45;
  anim._id_1187["riotshield"][2] = 0;
  anim._id_1187["riotshield"][3] = -45;
  anim._id_1187["riotshield"][4] = 90;
  anim._id_1187["riotshield"][6] = -90;
  anim._id_1187["riotshield"][8] = 180;
  anim._id_1166["riotshield"] = "crouch";
  anim._id_1166["riotshield_crouch"] = "crouch";
  animscripts\combat_utility::_id_238B( % riotshield_crouch_grenade_toss, (-3.20014, 1.7098, 55.6886));
}

_id_3AB5(var_0, var_1) {
  animscripts\shared::_id_23C8(self.secondaryweapon);
  self.secondaryweapon = "none";

  if(isalive(self)) {
    _id_3AD4();
  }
}

_id_3AB6() {
  if(self.a._id_0D26 == "crouch") {
    return "riotshield_crouch";

  }
  return "riotshield";
}

_id_3AB7(var_0) {
  return 1;
}

_id_3AB8() {
  animscripts\shared::_id_0C9B(self.secondaryweapon, "left", 0);
  self initriotshieldhealth(self.secondaryweapon);
  self._id_23C2 = 0;
  thread _id_3AD5();
  self.subclass = "riotshield";
  self._id_1193 = ::_id_3AB6;
  self._id_118E = ::_id_3AB7;
  self._id_1195 = 1;
  self._id_1194 = 1;
  self.pathrandompercent = 0;
  self.interval = 0;
  self._id_1089 = 1;
  self._id_1151 = 1;
  self._id_0FF1 = 1;
  self._id_0EEE = 1;
  self._id_1106 = 1;
  self._id_0FD9 = 1;
  self.combatmode = "no_cover";
  self.fixednode = 0;
  self.maxfaceenemydist = 1500;
  self._id_1143 = 1;
  self._id_1017 = squared(256);
  self._id_10D3 = 1;
  self._id_23CD = 1;

  if(level.gameskill < 1) {
    self._id_3AB9 = randomintrange(4, 8);
  } else {
    self._id_3AB9 = randomintrange(8, 12);

  }
  self._id_3ABA = 0;
  self._id_3ABB = 0;
  self.walkdist = 500;
  self.walkdistfacingmotion = 500;
  self.grenadeawareness = 1;
  self.frontshieldanglecos = 0.5;
  self.nogrenadereturnthrow = 1;
  self.a._id_113C = "crouch";
  self._id_1139 = 400;
  self.ignoresuppression = 1;
  self._id_1010 = ::_id_3ABD;
  self._id_1026 = ::_id_3ABE;
  maps\_utility::_id_2721();
  maps\_utility::_id_0EEC();
  maps\_utility::_id_109E();
  _id_3AC9();

  if(level.gameskill < 1) {
    self._id_1A2D = 30;
  } else {
    self._id_1A2D = 40;

  }
  maps\_utility::_id_12E2(maps\_spawner::_id_1A2D);
  maps\_utility::_id_12E2(animscripts\pain::_id_0D82);
}

_id_3ABC() {
  if(!animscripts\melee::_id_102B()) {
    return 0;

  }
  var_0 = getmovedelta( % riotshield_basha_attack, 0, 1);
  var_1 = lengthsquared(var_0);

  if(distancesquared(self.origin, self._id_100C.target.origin) < var_1) {
    return 1;

  }
  animscripts\melee::_id_102E();
  var_2 = 0.1;
  var_3 = 1;

  for(;;) {
    if(!animscripts\melee::_id_102B()) {
      return 0;

    }
    if(var_3) {
      self.a._id_0D26 = "stand";
      self setflaggedanimknoball("chargeanim", % riotshield_sprint, % body, 1, 0.2, 1);
      var_3 = 0;
    }

    self orientmode("face point", self._id_100C.target.origin);
    animscripts\notetracks::_id_0D4F(var_2, "chargeanim");
    var_4 = distancesquared(self.origin, self._id_100C.target.origin);

    if(var_4 < var_1) {
      break;
    }

    if(gettime() >= self._id_100C._id_1028) {
      return 0;
    }
  }

  return 1;
}

_id_3ABD() {
  self animmode("zonly_physics");
  animscripts\melee::_id_1027();

  for(;;) {
    if(!_id_3ABC()) {
      self._id_101B = gettime() + 1500;
      self._id_101C = self._id_100C.target;
      break;
    }

    animscripts\battlechatter_ai::_id_0B37();
    self orientmode("face point", self._id_100C.target.origin);
    self setflaggedanimknoballrestart("meleeanim", % riotshield_bash_vs_player, % body, 1, 0.2, 1);
    self._id_100C._id_100E = 1;

    if(!animscripts\melee::_id_102A()) {
      animscripts\melee::_id_1021(self._id_100C.target);
      break;
    }

    self animmode("none");
  }

  self animmode("none");
}

_id_3ABE() {
  var_0 = self._id_100C.target;

  if(self.subclass == "riotshield" && var_0.subclass == "riotshield") {
    return 0;

  }
  animscripts\melee::_id_103C();
  var_1 = vectortoangles(var_0.origin - self.origin);
  var_2 = angleclamp180(var_0.angles[1] - var_1[1]);

  if(abs(var_2) > 100) {
    if(self._id_100C.winner) {
      if(self.subclass == "riotshield") {
        self._id_100C._id_1032 = % riotshield_basha_attack;
        var_0._id_100C._id_1032 = % riotshield_basha_defend;
        var_0._id_100C._id_1033 = % riotshield_basha_defend_survive;
      } else {
        self._id_100C._id_1032 = % riotshield_bashb_defend;
        var_0._id_100C._id_1032 = % riotshield_bashb_attack;
      }
    } else if(self.subclass == "riotshield") {
      self._id_100C._id_1032 = % riotshield_bashb_attack;
      var_0._id_100C._id_1032 = % riotshield_bashb_defend;
    } else {
      self._id_100C._id_1032 = % riotshield_basha_defend;
      var_0._id_100C._id_1032 = % riotshield_basha_attack;
    }
  } else {
    return 0;

  }
  self._id_100C.startpos = getstartorigin(var_0.origin, var_0.angles, self._id_100C._id_1032);
  self._id_100C._id_103B = (var_0.angles[0], angleclamp180(var_0.angles[1] + 180), var_0.angles[2]);
  self.lockorientation = 0;
  var_0.lockorientation = 0;
  return animscripts\melee::_id_1013();
}

_id_3ABF() {
  if(isDefined(self._id_1199)) {
    return;
  }
  self orientmode("face angle", self.angles[1]);
  self animmode("zonly_physics", 0);

  if(self.a._id_0D26 == "crouch") {
    if(isDefined(self._id_0FD7) || isDefined(self._id_3AC0)) {
      var_0 = % riotshield_crouch2stand;
    } else {
      var_0 = % riotshield_crouch2walk;

    }
    var_1 = randomfloatrange(0.9, 1.1);
    self setflaggedanimknoballrestart("startmove", var_0, % body, 1, 0.1, var_1);
    animscripts\shared::_id_0C51("startmove");
    self clearanim( % riotshield_crouch2walk, 0.5);
  }

  if(isDefined(self._id_0FD7) || isDefined(self._id_3AC0)) {
    self allowedstances("stand", "crouch");
    self.a._id_0D26 = "stand";
  }

  self orientmode("face default");
  self animmode("normal", 0);
  thread _id_3AC3();
}

_id_3AC1() {
  if(self.prevscript == "move" && self.a._id_0D26 == "crouch") {
    self clearanim( % root, 0.2);
    var_0 = randomfloatrange(0.9, 1.1);
    self animmode("zonly_physics");
    self setflaggedanimknoballrestart("endmove", % riotshield_walk2crouch_8, % body, 1, 0.2, var_0);
    animscripts\shared::_id_0C51("endmove");
    self animmode("normal");
  }

  self allowedstances("crouch");
}

_id_3AC2() {
  _id_3AC1();
  self.pushable = 0;
  thread _id_3AC3();
}

_id_3AC3() {
  self endon("killanimscript");

  for(;;) {
    self waittill("bullet_hitshield");
    var_0 = gettime();

    if(var_0 - self._id_3ABB > 500) {
      self._id_3ABA = 0;
    } else {
      self._id_3ABA++;

    }
    self._id_3ABB = var_0;

    if(self._id_3ABA > self._id_3AB9) {
      self dodamage(1, (0, 0, 0));

    }
    if(common_scripts\utility::cointoss()) {
      var_1 = % riotshield_reacta;
    } else {
      var_1 = % riotshield_reactb;

    }
    self notify("new_hit_react");
    self setflaggedanimrestart("hitreact", var_1, 1, 0.1, 1);
    thread _id_3AC4();
  }
}

_id_3AC4() {
  self endon("killanimscript");
  self endon("new_hit_react");
  self waittillmatch("hitreact", "end");
  self clearanim( % riotshield_react, 0.1);
}

_id_3AC5() {
  if(self.a._id_0D26 == "stand") {
    self clearanim( % root, 0.2);
    self setflaggedanimknoballrestart("trans", % riotshield_walk2crouch_8, % body, 1, 0.2, 1.2);
    animscripts\shared::_id_0C51("trans");
  }

  if(isDefined(self.grenade)) {
    var_0 = 1;
    var_1 = self.grenade.origin - self.origin;

    if(isDefined(self.enemy)) {
      var_2 = self.enemy.origin - self.origin;

      if(vectordot(var_1, var_2) < 0) {
        var_0 = 0;
      }
    }

    if(var_0) {
      var_3 = angleclamp180(self.angles[1] - vectortoyaw(var_1));

      if(!isDefined(self._id_0F72)) {
        self._id_0F72 = 55;

      }
      while(abs(var_3) > self._id_0F72) {
        if(!isDefined(self.a._id_0C6D)) {
          animscripts\combat::_id_1108();

        }
        if(!animscripts\combat::_id_0F73(var_3)) {
          break;
        }

        var_3 = angleclamp180(self.angles[1] - vectortoyaw(var_1));
      }
    }
  }

  self setanimknoball( % riotshield_crouch_aim_5, % body, 1, 0.2, 1);
  self setflaggedanimknoballrestart("grenadecower", % riotshield_crouch_idle_add, % add_idle, 1, 0.2, self._id_10F7);
  animscripts\shared::_id_0C51("grenadecower");
}

_id_3AC6() {
  self notify("flashed");

  if(!isDefined(self.a._id_0D29)) {
    var_0 = randomfloatrange(0.9, 1.1);
    self.frontshieldanglecos = 1;
    var_1 = [];
    var_1[0] = % riotshield_crouch_grenade_flash1;
    var_1[1] = % riotshield_crouch_grenade_flash2;
    var_1[2] = % riotshield_crouch_grenade_flash3;
    var_1[3] = % riotshield_crouch_grenade_flash4;
    var_2 = var_1[randomint(var_1.size)];
    self setflaggedanimknoballrestart("flashanim", var_2, % body, 1, 0.1, var_0);
    self.minpaindamage = 1000;
    animscripts\shared::_id_0C51("flashanim");
  } else {
    wait 0.1;

  }
  self.minpaindamage = 0;

  if(isDefined(self.subclass) && self.subclass == "riotshield") {
    self.frontshieldanglecos = 0.5;
  }
}

_id_3AC7() {
  self.a._id_0D26 = "crouch";

  if(animscripts\utility::_id_0C95()) {
    maps\_utility::_id_104A(self.primaryweapon, "primary");

  }
  if(!isDefined(self.a._id_0D29)) {
    var_0 = randomfloatrange(0.8, 1.15);
    self.frontshieldanglecos = 1;

    if((self.damageyaw < -120 || self.damageyaw > 120) && isexplosivedamagemod(self.damagemod)) {
      var_1 = [];
      var_1[0] = % riotshield_crouch_grenade_blowback;
      var_1[1] = % riotshield_crouch_grenade_blowbackl;
      var_1[2] = % riotshield_crouch_grenade_blowbackr;
      var_2 = var_1[randomint(var_1.size)];
      self setflaggedanimknoballrestart("painanim", var_2, % body, 1, 0.2, var_0);
      self.minpaindamage = 1000;
    } else {
      self setflaggedanimknoballrestart("painanim", % riotshield_crouch_pain, % body, 1, 0.2, var_0);

    }
    animscripts\shared::_id_0C51("painanim");
  } else {
    wait 0.1;

  }
  self.minpaindamage = 0;

  if(isDefined(self.subclass) && self.subclass == "riotshield") {
    self.frontshieldanglecos = 0.5;
  }
}

_id_3AC8() {
  if(isDefined(self.a._id_0D29) && self.a._id_0D26 == "crouch") {
    var_0 = [];
    var_0[0] = % dying_back_death_v2;
    var_0[1] = % dying_back_death_v3;
    var_0[2] = % dying_back_death_v4;
    var_1 = var_0[randomint(var_0.size)];
    animscripts\death::_id_0D56(var_1);
    return 1;
  }

  if(self.prevscript == "pain" || self.prevscript == "flashed") {
    var_2 = randomint(2) == 0;
  } else {
    var_2 = 1;

  }
  if(var_2) {
    if(common_scripts\utility::cointoss()) {
      var_1 = % riotshield_crouch_death;
    } else {
      var_1 = % riotshield_crouch_death_fallback;

    }
    animscripts\death::_id_0D56(var_1);
    return 1;
  }

  self.a._id_0D26 = "crouch";
  return 0;
}

_id_3AC9() {
  var_0 = [];
  var_0["sprint"] = % riotshield_sprint;
  var_0["prone"] = % prone_crawl;
  var_0["straight"] = % riotshield_run_f;
  var_0["move_f"] = % riotshield_run_f;
  var_0["move_l"] = % riotshield_run_l;
  var_0["move_r"] = % riotshield_run_r;
  var_0["move_b"] = % riotshield_run_b;
  var_0["crouch"] = % riotshield_crouchwalk_f;
  var_0["crouch_l"] = % riotshield_crouchwalk_l;
  var_0["crouch_r"] = % riotshield_crouchwalk_r;
  var_0["crouch_b"] = % riotshield_crouchwalk_b;
  var_0["stairs_up"] = % traverse_stair_run_01;
  var_0["stairs_down"] = % traverse_stair_run_down;
  self._id_0C88["run"] = var_0;
  self._id_0C88["walk"] = var_0;
  self._id_0C88["cqb"] = var_0;
  self._id_0C89 = [];
  self._id_0C89["crouch"] = % riotshield_crouch_aim_5;
  self._id_0C89["crouch_add"] = % riotshield_crouch_idle_add;
  self._id_0C89["stand"] = % riotshield_crouch_aim_5;
  self._id_0C89["stand_add"] = % riotshield_crouch_idle_add;
  self.a._id_0D26 = "crouch";
  self allowedstances("crouch");
  var_0 = anim._id_0C65._id_0C78;
  var_0["add_aim_up"] = % riotshield_crouch_aim_8;
  var_0["add_aim_down"] = % riotshield_crouch_aim_2;
  var_0["add_aim_left"] = % riotshield_crouch_aim_4;
  var_0["add_aim_right"] = % riotshield_crouch_aim_6;
  var_0["straight_level"] = % riotshield_crouch_aim_5;
  var_0["fire"] = % riotshield_crouch_fire_auto;
  var_0["single"] = animscripts\utility::_id_0C6D( % riotshield_crouch_fire_single);
  var_0["burst2"] = % riotshield_crouch_fire_burst;
  var_0["burst3"] = % riotshield_crouch_fire_burst;
  var_0["burst4"] = % riotshield_crouch_fire_burst;
  var_0["burst5"] = % riotshield_crouch_fire_burst;
  var_0["burst6"] = % riotshield_crouch_fire_burst;
  var_0["semi2"] = % riotshield_crouch_fire_burst;
  var_0["semi3"] = % riotshield_crouch_fire_burst;
  var_0["semi4"] = % riotshield_crouch_fire_burst;
  var_0["semi5"] = % riotshield_crouch_fire_burst;
  var_0["exposed_idle"] = animscripts\utility::_id_0C6D( % riotshield_crouch_idle_add, % riotshield_crouch_twitch);
  var_0["exposed_grenade"] = animscripts\utility::_id_0C6D( % riotshield_crouch_grenade_toss);
  var_0["reload"] = animscripts\utility::_id_0C6D( % riotshield_crouch_reload);
  var_0["reload_crouchhide"] = animscripts\utility::_id_0C6D( % riotshield_crouch_reload);
  var_0["turn_left_45"] = % riotshield_crouch_lturn;
  var_0["turn_left_90"] = % riotshield_crouch_lturn;
  var_0["turn_left_135"] = % riotshield_crouch_lturn;
  var_0["turn_left_180"] = % riotshield_crouch_lturn;
  var_0["turn_right_45"] = % riotshield_crouch_rturn;
  var_0["turn_right_90"] = % riotshield_crouch_rturn;
  var_0["turn_right_135"] = % riotshield_crouch_rturn;
  var_0["turn_right_180"] = % riotshield_crouch_rturn;
  var_0["stand_2_crouch"] = % riotshield_walk2crouch_8;
  animscripts\animset::_id_0C81(var_0);
  animscripts\animset::_id_0C84(var_0);
  self._id_0FBA = ::_id_3ACB;
  self._id_0D18 = ::_id_3AC7;
  self._id_0D4B = ::_id_3AC8;
  self._id_2095 = ::_id_3AC6;
  self._id_3ACA = ::_id_3AC5;
  self._id_11A0 = ::_id_3ABF;
  self._id_11A1 = 1;
  common_scripts\utility::set_exception("exposed", ::_id_3AC2);
}

_id_3ACB(var_0) {
  if(isDefined(self.grenade)) {
    return "stand";

  }
  return animscripts\utility::_id_10AF(var_0);
}

_id_3ACC() {
  self.maxfaceenemydist = 128;
  self._id_0FD7 = 1;
  self orientmode("face default");
  self.lockorientation = 0;
  self.walkdist = 32;
  self.walkdistfacingmotion = 32;
}

_id_3ACD() {
  self.maxfaceenemydist = 128;
  self._id_3AC0 = 1;
  self.walkdist = 32;
  self.walkdistfacingmotion = 32;
}

_id_3ACE() {
  self.maxfaceenemydist = 1500;
  self.walkdist = 500;
  self.walkdistfacingmotion = 500;
  self._id_0FD7 = undefined;
  self allowedstances("crouch");
}

_id_3ACF() {
  self.maxfaceenemydist = 1500;
  self.walkdist = 500;
  self.walkdistfacingmotion = 500;
  self._id_3AC0 = undefined;
  self allowedstances("crouch");
}

_id_3AD0() {}

_id_3AD1() {
  if(self.script == "move") {
    self animcustom(::_id_3AD0);

  }
  self._id_11A0 = ::_id_3AD2;
}

_id_3AD2() {
  self._id_11A0 = ::_id_3ABF;
  self animmode("zonly_physics", 0);
  self orientmode("face current");

  if(!isDefined(self._id_3AD3) && isDefined(self.enemy) && vectordot(self.lookaheaddir, anglesToForward(self.angles)) < 0) {
    var_0 = % riotshield_crouch2walk_2flee;
  } else {
    var_0 = % riotshield_crouch2stand_shield_drop;

  }
  var_1 = randomfloatrange(0.85, 1.1);
  self setflaggedanimknoball("fleeanim", var_0, % root, 1, 0.1, var_1);
  animscripts\shared::_id_0C51("fleeanim");
  self.maxfaceenemydist = 32;
  self.lockorientation = 0;
  self orientmode("face default");
  self animmode("normal", 0);
  animscripts\shared::_id_0C51("fleeanim");
  self clearanim(var_0, 0.2);
  self.maxfaceenemydist = 128;
}

_id_3AD4() {
  self.subclass = "regular";
  self.combatmode = "cover";
  self._id_1193 = undefined;
  self._id_118E = undefined;
  self._id_1195 = undefined;
  self._id_1194 = undefined;
  self.pathrandompercent = 0;
  self.interval = 80;
  self._id_1089 = undefined;
  self._id_1151 = undefined;
  self._id_0FF1 = undefined;
  self._id_0EEE = undefined;
  self._id_1106 = undefined;
  self._id_0FD9 = undefined;
  self.maxfaceenemydist = 128;
  self._id_1143 = undefined;
  self._id_1017 = undefined;
  self._id_10D3 = undefined;
  self._id_23CD = undefined;
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  self.walkdist = 256;
  self.walkdistfacingmotion = 64;
  self.lockorientation = 0;
  self.frontshieldanglecos = 1;
  self.nogrenadereturnthrow = 0;
  self.ignoresuppression = 0;
  self._id_0FD7 = undefined;
  self allowedstances("stand", "crouch", "prone");
  self._id_1010 = undefined;
  self._id_1026 = undefined;
  maps\_utility::_id_2722();
  self._id_1A2D = undefined;
  maps\_utility::_id_1A2A(maps\_spawner::_id_1A2D);
  maps\_utility::_id_1A2A(animscripts\pain::_id_0D82);
  animscripts\animset::_id_0C87();
  self._id_0FBA = animscripts\utility::_id_10AF;
  self._id_0D18 = undefined;
  self._id_0D4B = undefined;
  self._id_2095 = undefined;
  self._id_3ACA = undefined;
  self._id_11A0 = undefined;
  self._id_11A1 = undefined;
  common_scripts\utility::clear_exception("exposed");
  common_scripts\utility::clear_exception("stop_immediate");
}

_id_3AD5() {
  self endon("death");
  self waittill("riotshield_damaged");
  self._id_23C3 = 1;
  animscripts\shared::_id_23C1();
  self._id_23C2 = 1;
  animscripts\shared::_id_23C4();
}