/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\melee.gsc
**************************************/

melee_init() {
  precachemodel("weapon_parabolic_knife");
  level._effect["melee_knife_ai"] = loadfx("impacts/flesh_hit_knife");
}

melee_stealthcheck() {
  if(!isDefined(self._stealth)) {
    return 0;
  }
  if(isDefined(self.ent_flag) && isDefined(self.ent_flag["_stealth_enabled"]) && self.ent_flag["_stealth_enabled"]) {
    if(isDefined(self.ent_flag["_stealth_attack"]) && !self.ent_flag["_stealth_attack"]) {
      return 1;
    }
  }

  return 0;
}

melee_tryexecuting() {
  if(!isDefined(self.enemy)) {
    return 0;
  }
  if(isDefined(self.dontmelee)) {
    return 0;
  }
  if(melee_stealthcheck()) {
    return 0;
  }
  if(!melee_acquiremutex(self.enemy)) {
    return 0;
  }
  melee_resetaction();

  if(!melee_chooseaction()) {
    melee_releasemutex(self.enemy);
    return 0;
  }

  self animcustom(::melee_mainloop, ::melee_endscript);
}

melee_resetaction() {
  self.melee.target = self.enemy;
  self.melee.initiated = 0;
  self.melee.inprogress = 0;
}

melee_chooseaction() {
  if(!melee_isvalid()) {
    return 0;
  }
  self.melee.initiated = 1;

  if(melee_aivsai_chooseaction()) {
    self.melee.func = ::melee_aivsai_main;
    return 1;
  }

  if(melee_standard_chooseaction()) {
    if(isDefined(self.specialmelee_standard)) {
      self.melee.func = self.specialmelee_standard;
    } else {
      self.melee.func = ::melee_standard_main;
    }
    return 1;
  }

  self.melee.func = undefined;
  self.nextmeleechecktime = gettime() + 150;
  self.nextmeleechecktarget = self.melee.target;
  return 0;
}

melee_updateandvalidatestartpos() {
  var_0 = 1;
  var_1 = distance2d(self.melee.startpos, self.melee.target.origin);

  if(var_1 < 32) {
    var_2 = vectorNormalize((self.melee.startpos[0] - self.melee.target.origin[0], self.melee.startpos[1] - self.melee.target.origin[1], 0));
    self.melee.startpos = self.melee.startpos + var_2 * (32 - var_1);
    var_0 = 0;
  }

  var_3 = self getdroptofloorposition(self.melee.startpos);

  if(!isDefined(var_3)) {
    return 0;
  }
  if(abs(self.melee.startpos[2] - var_3[2]) > 51.2) {
    return 0;
  }
  if(abs(self.origin[2] - var_3[2]) > 51.2) {
    return 0;
  }
  self.melee.startpos = var_3;

  if(!self maymovetopoint(self.melee.startpos, 1, var_0)) {
    return 0;
  }
  if(isDefined(self.melee.starttotargetcornerangles)) {
    var_4 = self.melee.startpos - self.melee.target.origin;
    var_5 = anglesToForward(self.melee.starttotargetcornerangles);
    var_6 = vectordot(var_5, var_4);
    var_7 = self.melee.startpos - var_5 * var_6;
    var_8 = self.melee.target.origin - var_7;
    var_9 = distance2d(self.melee.target.origin, var_7);

    if(var_9 < 32) {
      var_7 = var_7 - var_8 * ((32 - var_9) / 32);
    }
  } else {
    var_2 = vectorNormalize((self.melee.startpos[0] - self.melee.target.origin[0], self.melee.startpos[1] - self.melee.target.origin[1], 0));
    var_7 = self.melee.target.origin + var_2 * 32;
  }

  if(!self maymovefrompointtopoint(self.melee.startpos, var_7, 1, 0)) {
    return 0;
  }
  if(!self maymovefrompointtopoint(var_7, self.melee.target.origin, 1, 1)) {
    return 0;
  }
  return 1;
}

melee_isvalid() {
  if(!isDefined(self.melee.target)) {
    return 0;
  }
  var_0 = self.melee.target;

  if(isDefined(var_0.dontmelee)) {
    return 0;
  }
  var_1 = distancesquared(self.origin, var_0.origin);

  if(isDefined(self.meleechargedistsq)) {
    var_2 = self.meleechargedistsq;
  } else if(isPlayer(var_0)) {
    var_2 = 40000;
  } else {
    var_2 = 25600;
  }
  if(!self.melee.initiated && var_1 > var_2) {
    return 0;
  }
  if(!isalive(self)) {
    return 0;
  }
  if(isDefined(self.a.nofirstframemelee) && self.a.scriptstarttime >= gettime() + 50) {
    return 0;
  }
  if(isDefined(self.nextmeleechecktime) && isDefined(self.nextmeleechecktarget) && gettime() < self.nextmeleechecktime && self.nextmeleechecktarget == var_0) {
    return 0;
  }
  if(isDefined(self.a.onback) || self.a.pose == "prone") {
    return 0;
  }
  if(animscripts\utility::usingsidearm()) {
    return 0;
  }
  if(isDefined(self.grenade) && self.frontshieldanglecos == 1) {
    return 0;
  }
  if(!isalive(var_0)) {
    return 0;
  }
  if(isDefined(var_0.dontattackme) || isDefined(var_0.ignoreme) && var_0.ignoreme) {
    return 0;
  }
  if(!isai(var_0) && !isPlayer(var_0)) {
    return 0;
  }
  if(isai(var_0)) {
    if(var_0 isinscriptedstate()) {
      return 0;
    }
    if(var_0 maps\_utility::doinglongdeath() || var_0.delayeddeath) {
      return 0;
    }
  }

  if(isPlayer(var_0)) {
    var_3 = var_0 getstance();
  } else {
    var_3 = var_0.a.pose;
  }
  if(var_3 != "stand" && var_3 != "crouch") {
    return 0;
  }
  if(isDefined(self.magic_bullet_shield) && isDefined(var_0.magic_bullet_shield)) {
    return 0;
  }
  if(isDefined(var_0.grenade)) {
    return 0;
  }
  if(self.melee.inprogress) {
    var_4 = 110;
  } else {
    var_4 = 60;
  }
  var_5 = angleclamp180(self.angles[1] - animscripts\utility::getyaw(var_0.origin));

  if(abs(var_5) > var_4) {
    return 0;
  }
  if(var_1 <= 4096) {
    return 1;
  }
  if(self.melee.inprogress) {
    return 0;
  }
  if(isDefined(self.nextmeleechargetime) && isDefined(self.nextmeleechargetarget) && gettime() < self.nextmeleechargetime && self.nextmeleechargetarget == var_0) {
    return 0;
  }
  return 1;
}

melee_startmovement() {
  self.melee.playingmovementanim = 1;
  self.a.movement = "run";
}

#using_animtree("generic_human");

melee_stopmovement() {
  self clearanim(%body, 0.2);
  self.melee.playingmovementanim = undefined;
  self.a.movement = "stop";
  self orientmode("face default");
}

melee_mainloop() {
  self endon("killanimscript");
  self endon("end_melee");

  for(;;) {
    var_0 = self.melee.func;
    [[self.melee.func]]();

    if(!isDefined(self.melee.func) || var_0 == self.melee.func) {
      break;
    }
  }
}

melee_standard_delaystandardcharge(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  self.nextmeleestandardchargetime = gettime() + 2500;
  self.nextmeleestandardchargetarget = var_0;
}

melee_standard_checktimeconstraints() {
  var_0 = distancesquared(self.melee.target.origin, self.origin);

  if(var_0 > 4096 && isDefined(self.nextmeleestandardchargetime) && isDefined(self.nextmeleestandardchargetarget) && gettime() < self.nextmeleestandardchargetime && self.nextmeleestandardchargetarget == self.melee.target) {
    return 0;
  }
  return 1;
}

melee_standard_chooseaction() {
  if(isDefined(self.melee.target.magic_bullet_shield)) {
    return 0;
  }
  if(!melee_standard_checktimeconstraints()) {
    return 0;
  }
  if(isDefined(self.melee.target.specialmeleechooseaction)) {
    return 0;
  }
  return melee_standard_updateandvalidatetarget();
}

melee_standard_resetgiveuptime() {
  if(isDefined(self.meleechargedistsq)) {
    var_0 = self.meleechargedistsq;
  } else if(isPlayer(self.melee.target)) {
    var_0 = 40000;
  } else {
    var_0 = 25600;
  }
  if(distancesquared(self.origin, self.melee.target.origin) > var_0) {
    self.melee.giveuptime = gettime() + 3000;
  } else {
    self.melee.giveuptime = gettime() + 1000;
  }
}

melee_standard_main() {
  self animmode("zonly_physics");

  if(isDefined(self.melee.target)) {
    melee_standard_resetgiveuptime();
  }
  while(isDefined(self.melee.target)) {
    if(!melee_standard_getinposition()) {
      self.nextmeleechargetime = gettime() + 1500;
      self.nextmeleechargetarget = self.melee.target;
      break;
    }

    if(!isDefined(self.melee.target)) {
      break;
    }

    animscripts\battlechatter_ai::evaluatemeleeevent();
    self orientmode("face point", self.melee.target.origin);
    self setflaggedanimknoballrestart("meleeanim", %melee_1, %body, 1, 0.2, 1);
    self.melee.inprogress = 1;

    if(!melee_standard_playattackloop()) {
      melee_standard_delaystandardcharge(self.melee.target);
      break;
    }
  }

  self animmode("none");
}

melee_standard_playattackloop() {
  for(;;) {
    self waittill("meleeanim", var_0);

    if(var_0 == "end") {
      return 1;
    }
    if(var_0 == "stop") {
      if(!melee_chooseaction()) {
        return 0;
      }
      if(self.melee.func != ::melee_standard_main) {
        return 1;
      }
    }

    if(var_0 == "fire") {
      if(isDefined(self.melee.target)) {
        var_1 = self.melee.target.health;
        self melee();

        if(isDefined(self.melee.target) && self.melee.target.health < var_1) {
          melee_standard_resetgiveuptime();
        }
      }
    }
  }
}

melee_standard_updateandvalidatetarget() {
  if(!isDefined(self.melee.target)) {
    return 0;
  }
  if(!melee_isvalid()) {
    return 0;
  }
  var_0 = vectorNormalize(self.melee.target.origin - self.origin);
  self.melee.startpos = self.melee.target.origin - 40.0 * var_0;
  return melee_updateandvalidatestartpos();
}

distance2dsquared(var_0, var_1) {
  var_2 = (var_0[0] - var_1[0], var_0[1] - var_1[1], 0);
  return lengthsquared(var_2);
}

melee_standard_getinposition() {
  if(!melee_standard_updateandvalidatetarget()) {
    return 0;
  }
  var_0 = distance2dsquared(self.origin, self.melee.target.origin);

  if(var_0 <= 4096) {
    self setflaggedanimknoball("readyanim", %stand_2_melee_1, %body, 1, 0.3, 1);
    animscripts\shared::donotetracks("readyanim");
    return 1;
  }

  melee_playchargesound();
  var_1 = self.melee.target.origin;
  var_2 = 0.1;
  var_3 = length(getmovedelta(%run_2_melee_charge, 0, 1));
  var_4 = 32;
  var_5 = 48.0 + var_4 + var_3;
  var_6 = var_5 * var_5;
  var_7 = 64 + var_4;
  var_8 = var_7 * var_7;
  var_9 = getanimlength(%run_2_melee_charge) * 1000;
  var_10 = var_9 - 100;
  var_11 = var_9 - 200;
  var_12 = 0;
  var_13 = undefined;
  var_14 = % run_lowready_f;

  if(isPlayer(self.melee.target) && self.melee.target == self.enemy) {
    self orientmode("face enemy");
  } else {
    self orientmode("face point", self.melee.target.origin);
  }
  self setflaggedanimknoball("chargeanim", var_14, %body, 1, 0.3, 1);
  var_15 = 0;

  for(;;) {
    var_16 = gettime();
    var_17 = isDefined(var_13) && var_13 <= var_6;

    if(!var_15) {
      if(var_17) {
        melee_startmovement();
        self setflaggedanimknoballrestart("chargeanim", %run_2_melee_charge, %body, 1, 0.2, 1);
        var_12 = var_16;
        var_15 = 1;
      }
    } else {
      var_18 = var_0 <= var_6;

      if(var_16 - var_12 >= var_10 || !var_17 && !var_18) {
        melee_startmovement();
        self setflaggedanimknoball("chargeanim", var_14, %body, 1, 0.3, 1);
        var_15 = 0;
      }
    }

    animscripts\notetracks::donotetracksfortime(var_2, "chargeanim");

    if(!melee_standard_updateandvalidatetarget()) {
      melee_stopmovement();
      return 0;
    }

    var_0 = distance2dsquared(self.origin, self.melee.target.origin);
    var_19 = (self.melee.target.origin - var_1) * (1 / (gettime() - var_16));
    var_1 = self.melee.target.origin;
    var_20 = self.melee.target.origin + var_19 * var_11;
    var_13 = distance2dsquared(self.origin, var_20);

    if(var_15 && var_0 <= var_8 && (gettime() - var_12 >= var_10 || !isPlayer(self.melee.target))) {
      break;
    }

    if(!var_15 && gettime() >= self.melee.giveuptime) {
      melee_stopmovement();
      return 0;
    }
  }

  melee_stopmovement();
  return 1;
}

melee_playchargesound() {
  if(!isDefined(self.a.nextmeleechargesound)) {
    self.a.nextmeleechargesound = 0;
  }
  if(isDefined(self.enemy) && isPlayer(self.enemy) || randomint(3) == 0) {
    if(gettime() > self.a.nextmeleechargesound) {
      animscripts\face::saygenericdialogue("meleecharge");
      self.a.nextmeleechargesound = gettime() + 8000;
    }
  }
}

melee_aivsai_exposed_chooseanimationandposition_flip(var_0) {
  var_1 = 90;

  if(self.melee.inprogress) {
    var_1 = var_1 + 50;
  }
  if(abs(var_0) < var_1) {
    return 0;
  }
  var_2 = self.melee.target;
  melee_decide_winner();

  if(self.melee.winner) {
    self.melee.animname = % melee_f_awin_attack;
    var_2.melee.animname = % melee_f_awin_defend;
    var_2.melee.surviveanimname = % melee_f_awin_defend_survive;
  } else {
    self.melee.animname = % melee_f_dwin_attack;
    var_2.melee.animname = % melee_f_dwin_defend;
  }

  return 1;
}

melee_aivsai_exposed_chooseanimationandposition_wrestle(var_0) {
  var_1 = 100;

  if(self.melee.inprogress) {
    var_1 = var_1 + 50;
  }
  if(abs(var_0) < var_1) {
    return 0;
  }
  var_2 = self.melee.target;

  if(isDefined(var_2.magic_bullet_shield)) {
    return 0;
  }
  if(isDefined(var_2.meleealwayswin)) {
    return 0;
  }
  self.melee.winner = 1;
  self.melee.animname = % bog_melee_r_attack;
  var_2.melee.animname = % bog_melee_r_defend;
  var_2.melee.surviveanimname = % bog_melee_r_backdeath2;
  return 1;
}

melee_aivsai_exposed_chooseanimationandposition_behind(var_0) {
  if(-90 > var_0 || var_0 > 0) {
    return 0;
  }
  var_1 = self.melee.target;

  if(isDefined(var_1.magic_bullet_shield)) {
    return 0;
  }
  if(isDefined(var_1.meleealwayswin)) {
    return 0;
  }
  self.melee.winner = 1;
  self.melee.animname = % melee_sync_attack;
  var_1.melee.animname = % melee_sync_defend;
  return 1;
}

melee_aivsai_exposed_chooseanimationandposition_buildexposedlist() {
  if(isDefined(self.meleeforcedexposedflip)) {
    var_0[0] = ::melee_aivsai_exposed_chooseanimationandposition_flip;
  } else if(isDefined(self.meleeforcedexposedwrestle)) {
    var_0[0] = ::melee_aivsai_exposed_chooseanimationandposition_wrestle;
  } else {
    var_1 = randomint(2);
    var_2 = 1 - var_1;
    var_3 = 2;
    var_0[var_1] = ::melee_aivsai_exposed_chooseanimationandposition_flip;
    var_0[var_2] = ::melee_aivsai_exposed_chooseanimationandposition_wrestle;
    var_0[var_3] = ::melee_aivsai_exposed_chooseanimationandposition_behind;
  }

  return var_0;
}

melee_aivsai_exposed_chooseanimationandposition() {
  var_0 = self.melee.target;
  var_1 = vectortoangles(var_0.origin - self.origin);
  var_2 = angleclamp180(var_0.angles[1] - var_1[1]);
  var_3 = melee_aivsai_exposed_chooseanimationandposition_buildexposedlist();

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if([[var_3[var_4]]](var_2)) {
      self.melee.startangles = (0, var_1[1], 0);
      self.melee.startpos = getstartorigin(var_0.origin, var_0.angles, self.melee.animname);

      if(melee_updateandvalidatestartpos()) {
        return 1;
      }
    }
  }

  return 0;
}

melee_decide_winner() {
  var_0 = self.melee.target;

  if(isDefined(self.meleealwayswin)) {
    self.melee.winner = 1;
    return;
  } else if(isDefined(var_0.meleealwayswin)) {
    self.melee.winner = 0;
    return;
  }

  if(isDefined(self.magic_bullet_shield)) {
    self.melee.winner = 1;
  } else if(isDefined(var_0.magic_bullet_shield)) {
    self.melee.winner = 0;
  } else {
    self.melee.winner = common_scripts\utility::cointoss();
  }
}

melee_aivsai_specialcover_chooseanimationandposition() {
  var_0 = self.melee.target;
  melee_decide_winner();

  if(var_0.covernode.type == "Cover Left") {
    if(self.melee.winner) {
      self.melee.animname = % cornersdl_melee_wina_attacker;
      var_0.melee.animname = % cornersdl_melee_wina_defender;
      var_0.melee.surviveanimname = % cornersdl_melee_wina_defender_survive;
    } else {
      self.melee.animname = % cornersdl_melee_wind_attacker;
      self.melee.surviveanimname = % cornersdl_melee_wind_attacker_survive;
      var_0.melee.animname = % cornersdl_melee_wind_defender;
    }
  } else if(self.melee.winner) {
    self.melee.animname = % cornersdr_melee_wina_attacker;
    var_0.melee.animname = % cornersdr_melee_wina_defender;
  } else {
    self.melee.animname = % cornersdr_melee_wind_attacker;
    var_0.melee.animname = % cornersdr_melee_wind_defender;
  }

  self.melee.startpos = getstartorigin(var_0.covernode.origin, var_0.covernode.angles, self.melee.animname);
  self.melee.startangles = (var_0.covernode.angles[0], angleclamp180(var_0.covernode.angles[1] + 180), var_0.covernode.angles[2]);
  var_0.melee.faceyaw = animscripts\utility::getnodeforwardyaw(var_0.covernode);
  self.melee.starttotargetcornerangles = var_0.covernode.angles;

  if(!melee_updateandvalidatestartpos()) {
    self.melee.starttotargetcornerangles = undefined;
    return 0;
  }

  return 1;
}

melee_aivsai_specialcover_canexecute() {
  var_0 = self.melee.target.covernode;

  if(!isDefined(var_0)) {
    return 0;
  }
  if(distancesquared(var_0.origin, self.melee.target.origin) > 16 && isDefined(self.melee.target.a.covermode) && (self.melee.target.a.covermode != "hide" && self.melee.target.a.covermode != "lean")) {
    return 0;
  }
  var_1 = vectortoangles(self.origin - var_0.origin);
  var_2 = angleclamp180(var_0.angles[1] - var_1[1]);

  if(var_0.type == "Cover Left") {
    if(var_2 >= -50 && var_2 <= 0) {
      return 1;
    }
  } else if(var_0.type == "Cover Right") {
    if(var_2 >= 0 && var_2 <= 50) {
      return 1;
    }
  }

  return 0;
}

melee_aivsai_chooseaction() {
  var_0 = self.melee.target;

  if(!isai(var_0) || var_0.type != "human") {
    return 0;
  }
  if(self.stairsstate != "none" || var_0.stairsstate != "none") {
    return 0;
  }
  if(isDefined(self.meleealwayswin) && isDefined(var_0.meleealwayswin)) {
    return 0;
  }
  if(isDefined(self.magic_bullet_shield) && isDefined(var_0.magic_bullet_shield)) {
    return 0;
  }
  if(isDefined(self.meleealwayswin) && isDefined(var_0.magic_bullet_shield) || isDefined(var_0.meleealwayswin) && isDefined(self.magic_bullet_shield)) {
    return 0;
  }
  if(isDefined(self.specialmeleechooseaction)) {
    if(![[self.specialmeleechooseaction]]()) {
      return 0;
    }
    self.melee.precisepositioning = 1;
  } else if(isDefined(var_0.specialmeleechooseaction)) {
    return 0;
  } else if(melee_aivsai_specialcover_canexecute() && melee_aivsai_specialcover_chooseanimationandposition()) {
    self.melee.precisepositioning = 1;
  } else {
    if(!melee_aivsai_exposed_chooseanimationandposition()) {
      return 0;
    }
    self.melee.precisepositioning = 0;
  }

  if(!isDefined(var_0.melee.faceyaw)) {
    var_0.melee.faceyaw = var_0.angles[1];
  }
  self.melee.startposoffset = self.melee.startpos - var_0.origin;
  return 1;
}

melee_aivsai_schedulenotetracklink(var_0) {
  self.melee.syncnotetrackent = var_0;
  var_0.melee.syncnotetrackent = undefined;
}

melee_aivsai_targetlink(var_0) {
  if(!isDefined(var_0.melee)) {
    return;
  }
  melee_playchargesound();

  if(!isalive(var_0)) {
    return;
  }
  self.syncedmeleetarget = var_0;
  var_0.syncedmeleetarget = self;
  self.melee.linked = 1;
  var_0.melee.linked = 1;
  self linktoblendtotag(var_0, "tag_sync", 1, 1);
}

melee_aivsai_main() {
  if(!melee_aivsai_getinposition()) {
    self.nextmeleechargetime = gettime() + 1500;
    self.nextmeleechargetarget = self.melee.target;
    return;
  }

  var_0 = self.melee.target;
  melee_aivsai_schedulenotetracklink(var_0);

  if(self.melee.winner) {
    self.melee.death = undefined;
    var_0.melee.death = 1;
  } else {
    var_0.melee.death = undefined;
    self.melee.death = 1;
  }

  self.melee.partner = var_0;
  var_0.melee.partner = self;

  if(animscripts\utility::usingsidearm()) {
    maps\_utility::forceuseweapon(self.primaryweapon, "primary");
    self.lastweapon = self.primaryweapon;
  }

  if(var_0 animscripts\utility::usingsidearm()) {
    var_0 maps\_utility::forceuseweapon(var_0.primaryweapon, "primary");
    var_0.lastweapon = var_0.primaryweapon;
  }

  self.melee.weapon = self.weapon;
  self.melee.weaponslot = animscripts\utility::getcurrentweaponslotname();
  var_0.melee.weapon = var_0.weapon;
  var_0.melee.weaponslot = var_0 animscripts\utility::getcurrentweaponslotname();
  self.melee.inprogress = 1;
  var_0 animcustom(::melee_aivsai_execute, ::melee_endscript);
  var_0 thread melee_aivsai_animcustominterruptionmonitor(self);
  self.melee.target = undefined;
  melee_aivsai_execute();
}

melee_aivsai_animcustominterruptionmonitor(var_0) {
  self endon("end_melee");
  self endon("melee_aivsai_execute");
  wait 0.1;

  if(isDefined(var_0)) {
    var_0 notify("end_melee");
  }
  self notify("end_melee");
}

melee_aivsai_getinposition_updateandvalidatetarget(var_0, var_1) {
  if(isDefined(var_1) && var_1 <= gettime()) {
    return 0;
  }
  if(!melee_isvalid()) {
    return 0;
  }
  var_2 = self.melee.target;
  var_3 = distancesquared(var_2.origin, var_0);

  if(self.melee.precisepositioning) {
    var_4 = 256;
  } else {
    var_4 = 1296;
  }
  if(var_3 > var_4) {
    return 0;
  }
  self.melee.startpos = var_2.origin + self.melee.startposoffset;

  if(!melee_updateandvalidatestartpos()) {
    return 0;
  }
  return 1;
}

melee_aivsai_getinposition_issuccessful(var_0) {
  var_1 = distancesquared((self.origin[0], self.origin[1], 0), (self.melee.startpos[0], self.melee.startpos[1], 0));

  if(var_1 < 64 && abs(self.melee.startpos[2] - self.origin[2]) < 64) {
    return 1;
  }
  var_2 = distancesquared((var_0[0], var_0[1], 0), (self.melee.startpos[0], self.melee.startpos[1], 0));
  var_3 = distancesquared((self.origin[0], self.origin[1], 0), (self.melee.target.origin[0], self.melee.target.origin[1], 0));

  if(var_2 > var_3 && abs(self.melee.target.origin[2] - self.origin[2]) < 64) {
    return 1;
  }
  return 0;
}

melee_aivsai_getinposition_finalize(var_0) {
  melee_stopmovement();

  if(self.melee.precisepositioning) {
    self forceteleport(self.melee.startpos, self.melee.startangles);
    wait 0.05;
  } else {
    self orientmode("face angle", self.melee.startangles[1]);
    wait 0.05;
  }

  return melee_aivsai_getinposition_updateandvalidatetarget(var_0);
}

melee_aivsai_getinposition() {
  if(!melee_isvalid()) {
    return 0;
  }
  melee_startmovement();
  self clearanim(%body, 0.2);
  self setanimknoball(animscripts\run::getrunanim(), %body, 1, 0.2);
  self animmode("zonly_physics");
  self.keepclaimednode = 1;
  var_0 = gettime() + 1500;
  var_1 = self.melee.target.origin;

  while(melee_aivsai_getinposition_updateandvalidatetarget(var_1, var_0)) {
    if(melee_aivsai_getinposition_issuccessful(var_1)) {
      return melee_aivsai_getinposition_finalize(var_1);
    }
    self orientmode("face point", self.melee.startpos);
    wait 0.05;
  }

  melee_stopmovement();
  return 0;
}

melee_aivsai_execute() {
  self endon("killanimscript");
  self endon("end_melee");
  self notify("melee_aivsai_execute");
  self animmode("zonly_physics");
  self.a.special = "none";
  self.specialdeathfunc = undefined;
  thread melee_droppedweaponmonitorthread();
  thread melee_partnerendedmeleemonitorthread();

  if(isDefined(self.melee.faceyaw)) {
    self orientmode("face angle", self.melee.faceyaw);
  } else {
    self orientmode("face current");
  }
  self.a.pose = "stand";
  self clearanim(%body, 0.2);

  if(isDefined(self.melee.death)) {
    melee_disableinterruptions();
  }
  self setflaggedanimknoballrestart("meleeAnim", self.melee.animname, %body, 1, 0.2);
  var_0 = animscripts\shared::donotetracks("meleeAnim", ::melee_handlenotetracks);

  if(var_0 == "melee_death" && isDefined(self.melee.survive)) {
    melee_droppedweaponrestore();
    self setflaggedanimknoballrestart("meleeAnim", self.melee.surviveanimname, %body, 1, 0.2);
    var_0 = animscripts\shared::donotetracks("meleeAnim", ::melee_handlenotetracks);
  }

  if(isDefined(self.melee) && isDefined(self.melee.death)) {
    self kill();
  }
  self.keepclaimednode = 0;
}

melee_disableinterruptions() {
  self.melee.wasallowingpain = self.allowpain;
  self.melee.wasflashbangimmune = self.flashbangimmunity;
  maps\_utility::disable_pain();
  maps\_utility::setflashbangimmunity(1);
}

melee_needsweaponswap() {
  return isDefined(self.melee.weapon) && self.melee.weapon != "none" && self.weapon != self.melee.weapon;
}

melee_droppedweaponrestore() {
  if(self.weapon != "none" && self.lastweapon != "none") {
    return;
  }
  if(!isDefined(self.melee.weapon) || self.melee.weapon == "none") {
    return;
  }
  maps\_utility::forceuseweapon(self.melee.weapon, self.melee.weaponslot);

  if(isDefined(self.melee.droppedweaponent)) {
    self.melee.droppedweaponent delete();
    self.melee.droppedweaponent = undefined;
  }
}

melee_droppedweaponmonitorthread() {
  self endon("killanimscript");
  self endon("end_melee");
  self waittill("weapon_dropped", var_0);

  if(isDefined(var_0)) {
    self.melee.droppedweaponent = var_0;
  }
}

melee_partnerendedmeleemonitorthread_shouldanimsurvive() {
  if(!isDefined(self.melee.surviveanimname)) {
    return 0;
  }
  if(!isDefined(self.melee.surviveanimallowed)) {
    return 0;
  }
  return 1;
}

melee_partnerendedmeleemonitorthread() {
  self endon("killanimscript");
  self endon("end_melee");
  self waittill("partner_end_melee");

  if(isDefined(self.melee.death)) {
    if(isDefined(self.melee.animateddeath) || isDefined(self.melee.interruptdeath)) {
      self kill();
    } else {
      self.melee.death = undefined;

      if(melee_partnerendedmeleemonitorthread_shouldanimsurvive()) {
        self.melee.survive = 1;
      } else {
        self notify("end_melee");
      }
    }
  } else if(!isDefined(self.melee.unsynchappened)) {
    self notify("end_melee");
  }
}

melee_unlink() {
  if(!isDefined(self.melee.linked)) {
    return;
  }
  if(isDefined(self.syncedmeleetarget)) {
    self.syncedmeleetarget melee_unlinkinternal();
  }
  melee_unlinkinternal();
}

melee_unlinkinternal() {
  self unlink();
  self.syncedmeleetarget = undefined;

  if(!isalive(self)) {
    return;
  }
  self.melee.linked = undefined;
  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
}

melee_handlenotetracks_unsync() {
  melee_unlink();
  self.melee.unsynchappened = 1;

  if(isDefined(self.melee.partner) && isDefined(self.melee.partner.melee)) {
    self.melee.partner.melee.unsynchappened = 1;
  }
}

melee_handlenotetracks_shoulddieafterunsync() {
  if(animhasnotetrack(self.melee.animname, "melee_death")) {
    return 0;
  }
  return isDefined(self.melee.death);
}

melee_handlenotetracks_death(var_0) {
  if(isDefined(var_0) && var_0) {
    self.melee.interruptdeath = 1;
  } else {
    self.melee.animateddeath = 1;
  }
}

melee_handlenotetracks(var_0) {
  if(issubstr(var_0, "ps_")) {
    var_1 = getsubstr(var_0, 3);
    self playSound(var_1);
  } else if(var_0 == "sync") {
    if(isDefined(self.melee.syncnotetrackent)) {
      melee_aivsai_targetlink(self.melee.syncnotetrackent);
      self.melee.syncnotetrackent = undefined;
    }
  } else if(var_0 == "unsync") {
    melee_handlenotetracks_unsync();

    if(melee_handlenotetracks_shoulddieafterunsync()) {
      melee_handlenotetracks_death();
    }
  } else if(var_0 == "melee_interact") {
    self.melee.surviveanimallowed = 1;
  } else if(var_0 == "melee_death") {
    if(isDefined(self.melee.survive)) {
      return var_0;
    }
    melee_handlenotetracks_death();

    if(isDefined(self.melee.animateddeath)) {
      return var_0;
    }
  } else if(var_0 == "attach_knife") {
    self attach("weapon_parabolic_knife", "TAG_INHAND", 1);
    self.melee.hasknife = 1;
  } else {
    if(var_0 == "detach_knife") {
      self detach("weapon_parabolic_knife", "TAG_INHAND", 1);
      self.melee.hasknife = undefined;
      return;
    }

    if(var_0 == "stab") {
      self playSound("melee_knife_hit_body");
      playFXOnTag(level._effect["melee_knife_ai"], self, "TAG_KNIFE_FX");

      if(isDefined(self.melee.partner) && isDefined(self.melee.partner.melee)) {
        self.melee.partner melee_handlenotetracks_death(1);
      }
    }
  }
}

melee_deathhandler_regular() {
  self endon("end_melee");
  animscripts\shared::dropallaiweapons();
  return 0;
}

melee_deathhandler_delayed() {
  self endon("end_melee");
  animscripts\notetracks::donotetrackswithtimeout("meleeAnim", 10.0);
  animscripts\shared::dropallaiweapons();
  self startragdoll();
  return 1;
}

melee_endscript_checkdeath() {
  if(!isalive(self) && isDefined(self.melee.death)) {
    if(isDefined(self.melee.animateddeath)) {
      self.deathfunction = ::melee_deathhandler_delayed;
    } else {
      self.deathfunction = ::melee_deathhandler_regular;
    }
  }
}

melee_endscript_checkpositionandmovement() {
  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.melee.playingmovementanim)) {
    melee_stopmovement();
  }
  var_0 = self getdroptofloorposition();

  if(isDefined(var_0)) {
    self forceteleport(var_0, self.angles);
  } else {}
}

melee_endscript_checkweapon() {
  if(isDefined(self.melee.hasknife)) {
    self detach("weapon_parabolic_knife", "TAG_INHAND", 1);
  }
  if(isalive(self)) {
    melee_droppedweaponrestore();
  }
}

melee_endscript_checkstatechanges() {
  if(isDefined(self.melee.wasallowingpain)) {
    if(self.melee.wasallowingpain) {
      maps\_utility::enable_pain();
    } else {
      maps\_utility::disable_pain();
    }
  }

  if(isDefined(self.melee.wasflashbangimmune)) {
    maps\_utility::setflashbangimmunity(self.melee.wasflashbangimmune);
  }
}

melee_endscript() {
  melee_unlink();
  melee_endscript_checkdeath();
  melee_endscript_checkpositionandmovement();
  melee_endscript_checkweapon();
  melee_endscript_checkstatechanges();

  if(isDefined(self.melee.partner)) {
    self.melee.partner notify("partner_end_melee");
  }
  melee_releasemutex(self.melee.target);
}

melee_acquiremutex(var_0) {
  if(isDefined(self.melee)) {
    return 0;
  }
  if(isDefined(var_0.melee)) {
    return 0;
  }
  self.melee = spawnStruct();
  var_0.melee = spawnStruct();
  return 1;
}

melee_releasemutex(var_0) {
  self.melee = undefined;

  if(isDefined(var_0)) {
    var_0.melee = undefined;
  }
}