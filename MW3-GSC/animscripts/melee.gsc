/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\melee.gsc
**************************************/

_id_1006() {
  precachemodel("weapon_parabolic_knife");
  level._effect["melee_knife_ai"] = loadfx("impacts/flesh_hit_knife");
}

_id_1007() {
  if(!isDefined(self._id_0B6E)) {
    return 0;

  }
  if(isDefined(self._id_1008) && isDefined(self._id_1008["_stealth_enabled"]) && self._id_1008["_stealth_enabled"]) {
    if(isDefined(self._id_1008["_stealth_attack"]) && !self._id_1008["_stealth_attack"]) {
      return 1;
    }
  }

  return 0;
}

_id_1009() {
  if(!isDefined(self.enemy)) {
    return 0;

  }
  if(isDefined(self._id_100A)) {
    return 0;

  }
  if(_id_1007()) {
    return 0;

  }
  if(!_id_1073(self.enemy)) {
    return 0;

  }
  _id_100B();

  if(!_id_100F()) {
    _id_1074(self.enemy);
    return 0;
  }

  self animcustom(::_id_1020, ::_id_1072);
}

_id_100B() {
  self._id_100C.target = self.enemy;
  self._id_100C._id_100D = 0;
  self._id_100C._id_100E = 0;
}

_id_100F() {
  if(!_id_1016()) {
    return 0;

  }
  self._id_100C._id_100D = 1;

  if(_id_1040()) {
    self._id_100C.func = ::_id_1047;
    return 1;
  }

  if(_id_1025()) {
    if(isDefined(self._id_1010)) {
      self._id_100C.func = self._id_1010;
    } else {
      self._id_100C.func = ::_id_1029;

    }
    return 1;
  }

  self._id_100C.func = undefined;
  self._id_1011 = gettime() + 150;
  self._id_1012 = self._id_100C.target;
  return 0;
}

_id_1013() {
  var_0 = 1;
  var_1 = distance2d(self._id_100C.startpos, self._id_100C.target.origin);

  if(var_1 < 32) {
    var_2 = vectornormalize((self._id_100C.startpos[0] - self._id_100C.target.origin[0], self._id_100C.startpos[1] - self._id_100C.target.origin[1], 0));
    self._id_100C.startpos = self._id_100C.startpos + var_2 * (32 - var_1);
    var_0 = 0;
  }

  var_3 = self getdroptofloorposition(self._id_100C.startpos);

  if(!isDefined(var_3)) {
    return 0;

  }
  if(abs(self._id_100C.startpos[2] - var_3[2]) > 51.2) {
    return 0;

  }
  if(abs(self.origin[2] - var_3[2]) > 51.2) {
    return 0;

  }
  self._id_100C.startpos = var_3;

  if(!self maymovetopoint(self._id_100C.startpos, 1, var_0)) {
    return 0;

  }
  if(isDefined(self._id_100C._id_1015)) {
    var_4 = self._id_100C.startpos - self._id_100C.target.origin;
    var_5 = anglesToForward(self._id_100C._id_1015);
    var_6 = vectordot(var_5, var_4);
    var_7 = self._id_100C.startpos - var_5 * var_6;
    var_8 = self._id_100C.target.origin - var_7;
    var_9 = distance2d(self._id_100C.target.origin, var_7);

    if(var_9 < 32) {
      var_7 = var_7 - var_8 * ((32 - var_9) / 32);
    }
  } else {
    var_2 = vectornormalize((self._id_100C.startpos[0] - self._id_100C.target.origin[0], self._id_100C.startpos[1] - self._id_100C.target.origin[1], 0));
    var_7 = self._id_100C.target.origin + var_2 * 32;
  }

  if(!self maymovefrompointtopoint(self._id_100C.startpos, var_7, 1, 0)) {
    return 0;

  }
  if(!self maymovefrompointtopoint(var_7, self._id_100C.target.origin, 1, 1)) {
    return 0;

  }
  return 1;
}

_id_1016() {
  if(!isDefined(self._id_100C.target)) {
    return 0;

  }
  var_0 = self._id_100C.target;

  if(isDefined(var_0._id_100A)) {
    return 0;

  }
  var_1 = distancesquared(self.origin, var_0.origin);

  if(isDefined(self._id_1017)) {
    var_2 = self._id_1017;
  } else if(isplayer(var_0)) {
    var_2 = 40000;
  } else {
    var_2 = 25600;

  }
  if(!self._id_100C._id_100D && var_1 > var_2) {
    return 0;

  }
  if(!isalive(self)) {
    return 0;

  }
  if(isDefined(self.a._id_1018) && self.a._id_1019 >= gettime() + 50) {
    return 0;

  }
  if(isDefined(self._id_1011) && isDefined(self._id_1012) && gettime() < self._id_1011 && self._id_1012 == var_0) {
    return 0;

  }
  if(isDefined(self.a._id_0D29) || self.a._id_0D26 == "prone") {
    return 0;

  }
  if(animscripts\utility::_id_0C95()) {
    return 0;

  }
  if(isDefined(self.grenade) && self.frontshieldanglecos == 1) {
    return 0;

  }
  if(!isalive(var_0)) {
    return 0;

  }
  if(isDefined(var_0._id_0FA0) || isDefined(var_0.ignoreme) && var_0.ignoreme) {
    return 0;

  }
  if(!isai(var_0) && !isplayer(var_0)) {
    return 0;

  }
  if(isai(var_0)) {
    if(var_0 isinscriptedstate()) {
      return 0;

    }
    if(var_0 maps\_utility::_id_0D69() || var_0.delayeddeath) {
      return 0;
    }
  }

  if(isplayer(var_0)) {
    var_3 = var_0 getstance();
  } else {
    var_3 = var_0.a._id_0D26;

  }
  if(var_3 != "stand" && var_3 != "crouch") {
    return 0;

  }
  if(isDefined(self._id_0D04) && isDefined(var_0._id_0D04)) {
    return 0;

  }
  if(isDefined(var_0.grenade)) {
    return 0;

  }
  if(self._id_100C._id_100E) {
    var_4 = 110;
  } else {
    var_4 = 60;

  }
  var_5 = angleclamp180(self.angles[1] - animscripts\utility::_id_101A(var_0.origin));

  if(abs(var_5) > var_4) {
    return 0;

  }
  if(var_1 <= 4096) {
    return 1;

  }
  if(self._id_100C._id_100E) {
    return 0;

  }
  if(isDefined(self._id_101B) && isDefined(self._id_101C) && gettime() < self._id_101B && self._id_101C == var_0) {
    return 0;

  }
  return 1;
}

_id_101D() {
  self._id_100C._id_101E = 1;
  self.a._id_0D2B = "run";
}

#using_animtree("generic_human");

_id_101F() {
  self clearanim( % body, 0.2);
  self._id_100C._id_101E = undefined;
  self.a._id_0D2B = "stop";
  self orientmode("face default");
}

_id_1020() {
  self endon("killanimscript");
  self endon("end_melee");

  for(;;) {
    var_0 = self._id_100C.func;
    [[self._id_100C.func]]();

    if(!isDefined(self._id_100C.func) || var_0 == self._id_100C.func) {
      break;
    }
  }
}

_id_1021(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  self._id_1022 = gettime() + 2500;
  self._id_1023 = var_0;
}

_id_1024() {
  var_0 = distancesquared(self._id_100C.target.origin, self.origin);

  if(var_0 > 4096 && isDefined(self._id_1022) && isDefined(self._id_1023) && gettime() < self._id_1022 && self._id_1023 == self._id_100C.target) {
    return 0;

  }
  return 1;
}

_id_1025() {
  if(isDefined(self._id_100C.target._id_0D04)) {
    return 0;

  }
  if(!_id_1024()) {
    return 0;

  }
  if(isDefined(self._id_100C.target._id_1026)) {
    return 0;

  }
  return _id_102B();
}

_id_1027() {
  if(isDefined(self._id_1017)) {
    var_0 = self._id_1017;
  } else if(isplayer(self._id_100C.target)) {
    var_0 = 40000;
  } else {
    var_0 = 25600;

  }
  if(distancesquared(self.origin, self._id_100C.target.origin) > var_0) {
    self._id_100C._id_1028 = gettime() + 3000;
  } else {
    self._id_100C._id_1028 = gettime() + 1000;
  }
}

_id_1029() {
  self animmode("zonly_physics");

  if(isDefined(self._id_100C.target)) {
    _id_1027();

  }
  while(isDefined(self._id_100C.target)) {
    if(!_id_102D()) {
      self._id_101B = gettime() + 1500;
      self._id_101C = self._id_100C.target;
      break;
    }

    if(!isDefined(self._id_100C.target)) {
      break;
    }

    animscripts\battlechatter_ai::_id_0B37();
    self orientmode("face point", self._id_100C.target.origin);
    self setflaggedanimknoballrestart("meleeanim", % melee_1, % body, 1, 0.2, 1);
    self._id_100C._id_100E = 1;

    if(!_id_102A()) {
      _id_1021(self._id_100C.target);
      break;
    }
  }

  self animmode("none");
}

_id_102A() {
  for(;;) {
    self waittill("meleeanim", var_0);

    if(var_0 == "end") {
      return 1;

    }
    if(var_0 == "stop") {
      if(!_id_100F()) {
        return 0;

      }
      if(self._id_100C.func != ::_id_1029) {
        return 1;
      }
    }

    if(var_0 == "fire") {
      if(isDefined(self._id_100C.target)) {
        var_1 = self._id_100C.target.health;
        self melee();

        if(isDefined(self._id_100C.target) && self._id_100C.target.health < var_1) {
          _id_1027();
        }
      }
    }
  }
}

_id_102B() {
  if(!isDefined(self._id_100C.target)) {
    return 0;

  }
  if(!_id_1016()) {
    return 0;

  }
  var_0 = vectornormalize(self._id_100C.target.origin - self.origin);
  self._id_100C.startpos = self._id_100C.target.origin - 40.0 * var_0;
  return _id_1013();
}

_id_102C(var_0, var_1) {
  var_2 = (var_0[0] - var_1[0], var_0[1] - var_1[1], 0);
  return lengthsquared(var_2);
}

_id_102D() {
  if(!_id_102B()) {
    return 0;

  }
  var_0 = _id_102C(self.origin, self._id_100C.target.origin);

  if(var_0 <= 4096) {
    self setflaggedanimknoball("readyanim", % stand_2_melee_1, % body, 1, 0.3, 1);
    animscripts\shared::_id_0C51("readyanim");
    return 1;
  }

  _id_102E();
  var_1 = self._id_100C.target.origin;
  var_2 = 0.1;
  var_3 = length(getmovedelta( % run_2_melee_charge, 0, 1));
  var_4 = 32;
  var_5 = 48.0 + var_4 + var_3;
  var_6 = var_5 * var_5;
  var_7 = 64 + var_4;
  var_8 = var_7 * var_7;
  var_9 = getanimlength( % run_2_melee_charge) * 1000;
  var_10 = var_9 - 100;
  var_11 = var_9 - 200;
  var_12 = 0;
  var_13 = undefined;
  var_14 = % run_lowready_f;

  if(isplayer(self._id_100C.target) && self._id_100C.target == self.enemy) {
    self orientmode("face enemy");
  } else {
    self orientmode("face point", self._id_100C.target.origin);

  }
  self setflaggedanimknoball("chargeanim", var_14, % body, 1, 0.3, 1);
  var_15 = 0;

  for(;;) {
    var_16 = gettime();
    var_17 = isDefined(var_13) && var_13 <= var_6;

    if(!var_15) {
      if(var_17) {
        _id_101D();
        self setflaggedanimknoballrestart("chargeanim", % run_2_melee_charge, % body, 1, 0.2, 1);
        var_12 = var_16;
        var_15 = 1;
      }
    } else {
      var_18 = var_0 <= var_6;

      if(var_16 - var_12 >= var_10 || !var_17 && !var_18) {
        _id_101D();
        self setflaggedanimknoball("chargeanim", var_14, % body, 1, 0.3, 1);
        var_15 = 0;
      }
    }

    animscripts\notetracks::_id_0D4F(var_2, "chargeanim");

    if(!_id_102B()) {
      _id_101F();
      return 0;
    }

    var_0 = _id_102C(self.origin, self._id_100C.target.origin);
    var_19 = (self._id_100C.target.origin - var_1) * (1 / (gettime() - var_16));
    var_1 = self._id_100C.target.origin;
    var_20 = self._id_100C.target.origin + var_19 * var_11;
    var_13 = _id_102C(self.origin, var_20);

    if(var_15 && var_0 <= var_8 && (gettime() - var_12 >= var_10 || !isplayer(self._id_100C.target))) {
      break;
    }

    if(!var_15 && gettime() >= self._id_100C._id_1028) {
      _id_101F();
      return 0;
    }
  }

  _id_101F();
  return 1;
}

_id_102E() {
  if(!isDefined(self.a._id_102F)) {
    self.a._id_102F = 0;

  }
  if(isDefined(self.enemy) && isplayer(self.enemy) || randomint(3) == 0) {
    if(gettime() > self.a._id_102F) {
      animscripts\face::_id_0C41("meleecharge");
      self.a._id_102F = gettime() + 8000;
    }
  }
}

_id_1030(var_0) {
  var_1 = 90;

  if(self._id_100C._id_100E) {
    var_1 = var_1 + 50;

  }
  if(abs(var_0) < var_1) {
    return 0;

  }
  var_2 = self._id_100C.target;
  _id_103C();

  if(self._id_100C.winner) {
    self._id_100C._id_1032 = % melee_f_awin_attack;
    var_2._id_100C._id_1032 = % melee_f_awin_defend;
    var_2._id_100C._id_1033 = % melee_f_awin_defend_survive;
  } else {
    self._id_100C._id_1032 = % melee_f_dwin_attack;
    var_2._id_100C._id_1032 = % melee_f_dwin_defend;
  }

  return 1;
}

_id_1034(var_0) {
  var_1 = 100;

  if(self._id_100C._id_100E) {
    var_1 = var_1 + 50;

  }
  if(abs(var_0) < var_1) {
    return 0;

  }
  var_2 = self._id_100C.target;

  if(isDefined(var_2._id_0D04)) {
    return 0;

  }
  if(isDefined(var_2._id_1035)) {
    return 0;

  }
  self._id_100C.winner = 1;
  self._id_100C._id_1032 = % bog_melee_r_attack;
  var_2._id_100C._id_1032 = % bog_melee_r_defend;
  var_2._id_100C._id_1033 = % bog_melee_r_backdeath2;
  return 1;
}

_id_1036(var_0) {
  if(-90 > var_0 || var_0 > 0) {
    return 0;

  }
  var_1 = self._id_100C.target;

  if(isDefined(var_1._id_0D04)) {
    return 0;

  }
  if(isDefined(var_1._id_1035)) {
    return 0;

  }
  self._id_100C.winner = 1;
  self._id_100C._id_1032 = % melee_sync_attack;
  var_1._id_100C._id_1032 = % melee_sync_defend;
  return 1;
}

_id_1037() {
  if(isDefined(self._id_1038)) {
    var_0[0] = ::_id_1030;
  } else if(isDefined(self._id_1039)) {
    var_0[0] = ::_id_1034;
  } else {
    var_1 = randomint(2);
    var_2 = 1 - var_1;
    var_3 = 2;
    var_0[var_1] = ::_id_1030;
    var_0[var_2] = ::_id_1034;
    var_0[var_3] = ::_id_1036;
  }

  return var_0;
}

_id_103A() {
  var_0 = self._id_100C.target;
  var_1 = vectortoangles(var_0.origin - self.origin);
  var_2 = angleclamp180(var_0.angles[1] - var_1[1]);
  var_3 = _id_1037();

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if([[var_3[var_4]]](var_2)) {
      self._id_100C._id_103B = (0, var_1[1], 0);
      self._id_100C.startpos = getstartorigin(var_0.origin, var_0.angles, self._id_100C._id_1032);

      if(_id_1013()) {
        return 1;
      }
    }
  }

  return 0;
}

_id_103C() {
  var_0 = self._id_100C.target;

  if(isDefined(self._id_1035)) {
    self._id_100C.winner = 1;
    return;
  } else if(isDefined(var_0._id_1035)) {
    self._id_100C.winner = 0;
    return;
  }

  if(isDefined(self._id_0D04)) {
    self._id_100C.winner = 1;
  } else if(isDefined(var_0._id_0D04)) {
    self._id_100C.winner = 0;
  } else {
    self._id_100C.winner = common_scripts\utility::cointoss();
  }
}

_id_103D() {
  var_0 = self._id_100C.target;
  _id_103C();

  if(var_0._id_0CAF.type == "Cover Left") {
    if(self._id_100C.winner) {
      self._id_100C._id_1032 = % cornersdl_melee_wina_attacker;
      var_0._id_100C._id_1032 = % cornersdl_melee_wina_defender;
      var_0._id_100C._id_1033 = % cornersdl_melee_wina_defender_survive;
    } else {
      self._id_100C._id_1032 = % cornersdl_melee_wind_attacker;
      self._id_100C._id_1033 = % cornersdl_melee_wind_attacker_survive;
      var_0._id_100C._id_1032 = % cornersdl_melee_wind_defender;
    }
  } else if(self._id_100C.winner) {
    self._id_100C._id_1032 = % cornersdr_melee_wina_attacker;
    var_0._id_100C._id_1032 = % cornersdr_melee_wina_defender;
  } else {
    self._id_100C._id_1032 = % cornersdr_melee_wind_attacker;
    var_0._id_100C._id_1032 = % cornersdr_melee_wind_defender;
  }

  self._id_100C.startpos = getstartorigin(var_0._id_0CAF.origin, var_0._id_0CAF.angles, self._id_100C._id_1032);
  self._id_100C._id_103B = (var_0._id_0CAF.angles[0], angleclamp180(var_0._id_0CAF.angles[1] + 180), var_0._id_0CAF.angles[2]);
  var_0._id_100C._id_103E = animscripts\utility::_id_0F41(var_0._id_0CAF);
  self._id_100C._id_1015 = var_0._id_0CAF.angles;

  if(!_id_1013()) {
    self._id_100C._id_1015 = undefined;
    return 0;
  }

  return 1;
}

_id_103F() {
  var_0 = self._id_100C.target._id_0CAF;

  if(!isDefined(var_0)) {
    return 0;

  }
  if(distancesquared(var_0.origin, self._id_100C.target.origin) > 16 && isDefined(self._id_100C.target.a._id_0CF8) && (self._id_100C.target.a._id_0CF8 != "hide" && self._id_100C.target.a._id_0CF8 != "lean")) {
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

_id_1040() {
  var_0 = self._id_100C.target;

  if(!isai(var_0) || var_0.type != "human") {
    return 0;

  }
  if(self.stairsstate != "none" || var_0.stairsstate != "none") {
    return 0;

  }
  if(isDefined(self._id_1035) && isDefined(var_0._id_1035)) {
    return 0;

  }
  if(isDefined(self._id_0D04) && isDefined(var_0._id_0D04)) {
    return 0;

  }
  if(isDefined(self._id_1035) && isDefined(var_0._id_0D04) || isDefined(var_0._id_1035) && isDefined(self._id_0D04)) {
    return 0;

  }
  if(isDefined(self._id_1026)) {
    if(![[self._id_1026]]()) {
      return 0;

    }
    self._id_100C._id_1041 = 1;
  } else if(isDefined(var_0._id_1026)) {
    return 0;
  } else if(_id_103F() && _id_103D()) {
    self._id_100C._id_1041 = 1;
  } else {
    if(!_id_103A()) {
      return 0;

    }
    self._id_100C._id_1041 = 0;
  }

  if(!isDefined(var_0._id_100C._id_103E)) {
    var_0._id_100C._id_103E = var_0.angles[1];

  }
  self._id_100C._id_1042 = self._id_100C.startpos - var_0.origin;
  return 1;
}

_id_1043(var_0) {
  self._id_100C._id_1044 = var_0;
  var_0._id_100C._id_1044 = undefined;
}

_id_1045(var_0) {
  if(!isDefined(var_0._id_100C)) {
    return;
  }
  _id_102E();

  if(!isalive(var_0)) {
    return;
  }
  self.syncedmeleetarget = var_0;
  var_0.syncedmeleetarget = self;
  self._id_100C._id_1046 = 1;
  var_0._id_100C._id_1046 = 1;
  self linktoblendtotag(var_0, "tag_sync", 1, 1);
}

_id_1047() {
  if(!_id_1051()) {
    self._id_101B = gettime() + 1500;
    self._id_101C = self._id_100C.target;
    return;
  }

  var_0 = self._id_100C.target;
  _id_1043(var_0);

  if(self._id_100C.winner) {
    self._id_100C._id_1048 = undefined;
    var_0._id_100C._id_1048 = 1;
  } else {
    var_0._id_100C._id_1048 = undefined;
    self._id_100C._id_1048 = 1;
  }

  self._id_100C._id_1049 = var_0;
  var_0._id_100C._id_1049 = self;

  if(animscripts\utility::_id_0C95()) {
    maps\_utility::_id_104A(self.primaryweapon, "primary");
    self._id_1005 = self.primaryweapon;
  }

  if(var_0 animscripts\utility::_id_0C95()) {
    var_0 maps\_utility::_id_104A(var_0.primaryweapon, "primary");
    var_0._id_1005 = var_0.primaryweapon;
  }

  self._id_100C.weapon = self.weapon;
  self._id_100C._id_104C = animscripts\utility::_id_104B();
  var_0._id_100C.weapon = var_0.weapon;
  var_0._id_100C._id_104C = var_0 animscripts\utility::_id_104B();
  self._id_100C._id_100E = 1;
  var_0 animcustom(::_id_1052, ::_id_1072);
  var_0 thread _id_104D(self);
  self._id_100C.target = undefined;
  _id_1052();
}

_id_104D(var_0) {
  self endon("end_melee");
  self endon("melee_aivsai_execute");
  wait 0.1;

  if(isDefined(var_0)) {
    var_0 notify("end_melee");

  }
  self notify("end_melee");
}

_id_104E(var_0, var_1) {
  if(isDefined(var_1) && var_1 <= gettime()) {
    return 0;

  }
  if(!_id_1016()) {
    return 0;

  }
  var_2 = self._id_100C.target;
  var_3 = distancesquared(var_2.origin, var_0);

  if(self._id_100C._id_1041) {
    var_4 = 256;
  } else {
    var_4 = 1296;

  }
  if(var_3 > var_4) {
    return 0;

  }
  self._id_100C.startpos = var_2.origin + self._id_100C._id_1042;

  if(!_id_1013()) {
    return 0;

  }
  return 1;
}

_id_104F(var_0) {
  var_1 = distancesquared((self.origin[0], self.origin[1], 0), (self._id_100C.startpos[0], self._id_100C.startpos[1], 0));

  if(var_1 < 64 && abs(self._id_100C.startpos[2] - self.origin[2]) < 64) {
    return 1;

  }
  var_2 = distancesquared((var_0[0], var_0[1], 0), (self._id_100C.startpos[0], self._id_100C.startpos[1], 0));
  var_3 = distancesquared((self.origin[0], self.origin[1], 0), (self._id_100C.target.origin[0], self._id_100C.target.origin[1], 0));

  if(var_2 > var_3 && abs(self._id_100C.target.origin[2] - self.origin[2]) < 64) {
    return 1;

  }
  return 0;
}

_id_1050(var_0) {
  _id_101F();

  if(self._id_100C._id_1041) {
    self forceteleport(self._id_100C.startpos, self._id_100C._id_103B);
    wait 0.05;
  } else {
    self orientmode("face angle", self._id_100C._id_103B[1]);
    wait 0.05;
  }

  return _id_104E(var_0);
}

_id_1051() {
  if(!_id_1016()) {
    return 0;

  }
  _id_101D();
  self clearanim( % body, 0.2);
  self setanimknoball(animscripts\run::_id_0FC2(), % body, 1, 0.2);
  self animmode("zonly_physics");
  self.keepclaimednode = 1;
  var_0 = gettime() + 1500;
  var_1 = self._id_100C.target.origin;

  while(_id_104E(var_1, var_0)) {
    if(_id_104F(var_1)) {
      return _id_1050(var_1);

    }
    self orientmode("face point", self._id_100C.startpos);
    wait 0.05;
  }

  _id_101F();
  return 0;
}

_id_1052() {
  self endon("killanimscript");
  self endon("end_melee");
  self notify("melee_aivsai_execute");
  self animmode("zonly_physics");
  self.a._id_0D19 = "none";
  self._id_0D4B = undefined;
  thread _id_105C();
  thread _id_105F();

  if(isDefined(self._id_100C._id_103E)) {
    self orientmode("face angle", self._id_100C._id_103E);
  } else {
    self orientmode("face current");

  }
  self.a._id_0D26 = "stand";
  self clearanim( % body, 0.2);

  if(isDefined(self._id_100C._id_1048)) {
    _id_1054();

  }
  self setflaggedanimknoballrestart("meleeAnim", self._id_100C._id_1032, % body, 1, 0.2);
  var_0 = animscripts\shared::_id_0C51("meleeAnim", ::_id_1068);

  if(var_0 == "melee_death" && isDefined(self._id_100C._id_1053)) {
    _id_105A();
    self setflaggedanimknoballrestart("meleeAnim", self._id_100C._id_1033, % body, 1, 0.2);
    var_0 = animscripts\shared::_id_0C51("meleeAnim", ::_id_1068);
  }

  if(isDefined(self._id_100C) && isDefined(self._id_100C._id_1048)) {
    self kill();

  }
  self.keepclaimednode = 0;
}

_id_1054() {
  self._id_100C._id_1055 = self.allowpain;
  self._id_100C._id_1056 = self._id_0D68;
  maps\_utility::_id_1057();
  maps\_utility::_id_1058(1);
}

_id_1059() {
  return isDefined(self._id_100C.weapon) && self._id_100C.weapon != "none" && self.weapon != self._id_100C.weapon;
}

_id_105A() {
  if(self.weapon != "none" && self._id_1005 != "none") {
    return;
  }
  if(!isDefined(self._id_100C.weapon) || self._id_100C.weapon == "none") {
    return;
  }
  maps\_utility::_id_104A(self._id_100C.weapon, self._id_100C._id_104C);

  if(isDefined(self._id_100C._id_105B)) {
    self._id_100C._id_105B delete();
    self._id_100C._id_105B = undefined;
  }
}

_id_105C() {
  self endon("killanimscript");
  self endon("end_melee");
  self waittill("weapon_dropped", var_0);

  if(isDefined(var_0)) {
    self._id_100C._id_105B = var_0;
  }
}

_id_105D() {
  if(!isDefined(self._id_100C._id_1033)) {
    return 0;

  }
  if(!isDefined(self._id_100C._id_105E)) {
    return 0;

  }
  return 1;
}

_id_105F() {
  self endon("killanimscript");
  self endon("end_melee");
  self waittill("partner_end_melee");

  if(isDefined(self._id_100C._id_1048)) {
    if(isDefined(self._id_100C._id_1060) || isDefined(self._id_100C._id_1061)) {
      self kill();
    } else {
      self._id_100C._id_1048 = undefined;

      if(_id_105D()) {
        self._id_100C._id_1053 = 1;
      } else {
        self notify("end_melee");
      }
    }
  } else if(!isDefined(self._id_100C._id_1062)) {
    self notify("end_melee");
  }
}

_id_1063() {
  if(!isDefined(self._id_100C._id_1046)) {
    return;
  }
  if(isDefined(self.syncedmeleetarget)) {
    self.syncedmeleetarget _id_1064();

  }
  _id_1064();
}

_id_1064() {
  self unlink();
  self.syncedmeleetarget = undefined;

  if(!isalive(self)) {
    return;
  }
  self._id_100C._id_1046 = undefined;
  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
}

_id_1065() {
  _id_1063();
  self._id_100C._id_1062 = 1;

  if(isDefined(self._id_100C._id_1049) && isDefined(self._id_100C._id_1049._id_100C)) {
    self._id_100C._id_1049._id_100C._id_1062 = 1;
  }
}

_id_1066() {
  if(animhasnotetrack(self._id_100C._id_1032, "melee_death")) {
    return 0;

  }
  return isDefined(self._id_100C._id_1048);
}

_id_1067(var_0) {
  if(isDefined(var_0) && var_0) {
    self._id_100C._id_1061 = 1;
  } else {
    self._id_100C._id_1060 = 1;
  }
}

_id_1068(var_0) {
  if(issubstr(var_0, "ps_")) {
    var_1 = getsubstr(var_0, 3);
    self playSound(var_1);
  } else if(var_0 == "sync") {
    if(isDefined(self._id_100C._id_1044)) {
      _id_1045(self._id_100C._id_1044);
      self._id_100C._id_1044 = undefined;
    }
  } else if(var_0 == "unsync") {
    _id_1065();

    if(_id_1066()) {
      _id_1067();
    }
  } else if(var_0 == "melee_interact") {
    self._id_100C._id_105E = 1;
  } else if(var_0 == "melee_death") {
    if(isDefined(self._id_100C._id_1053)) {
      return var_0;

    }
    _id_1067();

    if(isDefined(self._id_100C._id_1060)) {
      return var_0;
    }
  } else if(var_0 == "attach_knife") {
    self attach("weapon_parabolic_knife", "TAG_INHAND", 1);
    self._id_100C._id_1069 = 1;
  } else {
    if(var_0 == "detach_knife") {
      self detach("weapon_parabolic_knife", "TAG_INHAND", 1);
      self._id_100C._id_1069 = undefined;
      return;
    }

    if(var_0 == "stab") {
      self playSound("melee_knife_hit_body");
      playFXOnTag(level._effect["melee_knife_ai"], self, "TAG_KNIFE_FX");

      if(isDefined(self._id_100C._id_1049) && isDefined(self._id_100C._id_1049._id_100C)) {
        self._id_100C._id_1049 _id_1067(1);
      }
    }
  }
}

_id_106A() {
  self endon("end_melee");
  animscripts\shared::_id_0D73();
  return 0;
}

_id_106B() {
  self endon("end_melee");
  animscripts\notetracks::_id_106C("meleeAnim", 10.0);
  animscripts\shared::_id_0D73();
  self startragdoll();
  return 1;
}

_id_106D() {
  if(!isalive(self) && isDefined(self._id_100C._id_1048)) {
    if(isDefined(self._id_100C._id_1060)) {
      self._id_0D45 = ::_id_106B;
    } else {
      self._id_0D45 = ::_id_106A;
    }
  }
}

_id_106E() {
  if(!isalive(self)) {
    return;
  }
  if(isDefined(self._id_100C._id_101E)) {
    _id_101F();

  }
  var_0 = self getdroptofloorposition();

  if(isDefined(var_0)) {
    self forceteleport(var_0, self.angles);
  } else {}
}

_id_106F() {
  if(isDefined(self._id_100C._id_1069)) {
    self detach("weapon_parabolic_knife", "TAG_INHAND", 1);

  }
  if(isalive(self)) {
    _id_105A();
  }
}

_id_1070() {
  if(isDefined(self._id_100C._id_1055)) {
    if(self._id_100C._id_1055) {
      maps\_utility::_id_1071();
    } else {
      maps\_utility::_id_1057();
    }
  }

  if(isDefined(self._id_100C._id_1056)) {
    maps\_utility::_id_1058(self._id_100C._id_1056);
  }
}

_id_1072() {
  _id_1063();
  _id_106D();
  _id_106E();
  _id_106F();
  _id_1070();

  if(isDefined(self._id_100C._id_1049)) {
    self._id_100C._id_1049 notify("partner_end_melee");

  }
  _id_1074(self._id_100C.target);
}

_id_1073(var_0) {
  if(isDefined(self._id_100C)) {
    return 0;

  }
  if(isDefined(var_0._id_100C)) {
    return 0;

  }
  self._id_100C = spawnStruct();
  var_0._id_100C = spawnStruct();
  return 1;
}

_id_1074(var_0) {
  self._id_100C = undefined;

  if(isDefined(var_0)) {
    var_0._id_100C = undefined;
  }
}