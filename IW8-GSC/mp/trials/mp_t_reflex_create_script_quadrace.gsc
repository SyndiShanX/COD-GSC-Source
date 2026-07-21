/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\mp_t_reflex_create_script_quadrace.gsc
************************************************************/

_id_134B8(var_0, var_1, var_2, var_3) {
  if(!_encstr_A938134BCF0540DA4A12771B26C7C04B5F11DFF20B())
    return 0;

  if(istrue(self.noturnanims))
    return 0;

  var_4 = scripts\asm\asm::asm_geteventtime(var_0, "_encstr_85E20B37342C4E83D71DD5E4B9");

  if(!isDefined(var_4))
    return 0;

  var_5 = 50;
  var_6 = gettime();

  if(var_6 - var_4 > var_5)
    return 0;

  var_7 = scripts\asm\asm::asm_geteventdata(var_0, "_encstr_85E20B37342C4E83D71DD5E4B9");
  var_8 = var_7[1];
  var_9 = var_7[2];
  var_10 = var_7[3];
  var_11 = 22500;

  if(var_9 && self pathdisttogoal() > 90 || lengthsquared(self.velocity) > var_11) {
    var_12 = 0;
    var_13 = undefined;

    if(!isarray(var_3))
      var_14 = var_3;
    else {
      var_14 = var_3[0];

      if(var_3.size > 1 && var_3[1] == 1)
        var_12 = 1;

      if(var_3.size > 2)
        var_13 = scripts\asm\asm_bb::bb_getprefixstring(var_3[2]);
    }

    var_15 = "_encstr_B40101";

    if(scripts\asm\shared\utility::demeanorhasblendspace() && scripts\asm\shared\utility::isentnotabomber()) {
      var_15 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349E();
      var_16 = scripts\asm\shared\utility::getbasearchetype();
      self.turnspeedtarget = getnearestspeedthresholdname(var_16, var_15);
    } else
      self.turnspeedtarget = undefined;

    var_17 = _id_13484(var_0, var_14, var_10, var_8, var_9, var_12, var_13, var_15);

    if(!isDefined(var_17))
      return 0;

    if(self.a.sharpturnnumberindex > 2 && self.a.sharpturnnumberindex < 6)
      return 0;

    self.a.sharpturnindex = var_17;
    self.a.sharpturncorner = var_10;
    self.a.sharpturnnextpathpoint = var_8;
    return 1;
  }

  return 0;
}

_id_13484(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 22.5;

  if(!isDefined(var_6))
    var_6 = "_encstr_B40101";

  if(!isDefined(var_7))
    var_7 = "_encstr_B40101";

  if(var_5) {
    if(scripts\asm\asm::asm_eventfiredrecently(var_0, "_encstr_A2A90A0E16B9E6EB1BAC99D1"))
      var_9 = var_6 + "_encstr_A5AD056A019C63";
    else if(scripts\asm\asm::asm_eventfiredrecently(var_0, "_encstr_8B830BC116B99BD79C4B9D0D3A"))
      var_9 = var_6 + "_encstr_8253060E2B5FE330";
    else if(self.asm.footsteps.foot == "_encstr_8253060E2B5FE330")
      var_9 = var_6 + "_encstr_8253060E2B5FE330";
    else
      var_9 = var_6 + "_encstr_A5AD056A019C63";
  } else
    var_9 = var_6;

  [var_11, var_12] = self actorcalcsharpturnanim(var_1, var_2, var_3, var_8, var_9, var_6, var_7);
  self.a.sharpturnnumberindex = var_12;
  return var_11;
}

_id_13490(var_0, var_1, var_2) {
  return self.a.sharpturnindex;
}

_id_1348B(var_0, var_1, var_2) {
  var_3 = "_encstr_A5AD056A019C63";

  if(scripts\asm\asm::asm_eventfiredrecently(var_0, "_encstr_A2A90A0E16B9E6EB1BAC99D1"))
    var_3 = "_encstr_A5AD056A019C63";
  else if(scripts\asm\asm::asm_eventfiredrecently(var_0, "_encstr_8B830BC116B99BD79C4B9D0D3A"))
    var_3 = "_encstr_8253060E2B5FE330";
  else if(self.asm.footsteps.foot == "_encstr_8253060E2B5FE330")
    var_3 = "_encstr_8253060E2B5FE330";

  var_4 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349E();
  var_5 = 0;
  var_6 = scripts\asm\shared\utility::getarrivalnode();
  var_7 = scripts\asm\shared\utility::nodeshouldfaceangles(var_6);
  var_8 = 6400.0;

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::recentlysawenemy() || !isDefined(self.enemy))
    var_5 = scripts\asm\soldier\script_funcs::getturndesiredyaw();
  else if(var_7 && length2dsquared(var_6.origin - self.origin) < var_8)
    var_5 = scripts\asm\shared\utility::getnodeforwardyaw(var_6) - self.angles[1];
  else if(istrue(self.brjugg_watchstartnotify)) {
    var_9 = 0;

    if(issentient(self.enemy))
      var_9 = self hastacvis(self.enemy);
    else
      var_9 = enablegroundwarspawnlogic(self.origin, self.enemy.origin);

    if(var_9)
      var_5 = vectortoyaw(self.enemy.origin - self.origin);
  }

  var_5 = angleclamp180(var_5);
  var_10 = [8, 9, 6, 3, 2, 1, 4, 7, 8];
  var_11 = getangleindex(var_5, 22.5);
  var_12 = var_3 + var_10[var_11] + var_4;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_12);
}

_id_134BC(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.asm.strafe_foot))
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  if(self getreacquirestate() == "_encstr_A18008BD35E222F01BD0")
    return 0;

  if(!_encstr_A938134BCF0540DA4A12771B26C7C04B5F11DFF20B())
    return 0;

  var_4 = scripts\asm\soldier\move::getstairsenterdist();
  var_5 = self getstairsstateatdist(var_4);

  if(var_5 != "_encstr_8BBA05185F8B99")
    return 0;

  var_6 = self aigettargetspeed();

  if(self.lookaheaddist < 90)
    return 0;

  var_7 = vectortoyaw(self.lookaheaddir);

  if(vectordot(vectorNormalize(self.velocity), vectorNormalize(self.lookaheaddir)) < 0.9)
    return 0;

  var_8 = self asmeventfiredwithin(var_0, "_encstr_85E20B37342C4E83D71DD5E4B9", 50);

  if(var_8) {
    var_9 = angleclamp180(var_7 - self.angles[1]);
    var_10 = angleclamp180(vectortoyaw(self.velocity) - self.angles[1]);

    if(abs(angleclamp180(var_10 - var_9)) > 45)
      return 0;
  } else
    var_10 = angleclamp180(var_7 - self.angles[1]);

  var_11 = scripts\asm\shared\utility::getshootfrompos();
  var_12 = scripts\asm\track::getshootpos(var_11);

  if(self.facemotion || self.predictedfacemotion || self shouldcautiousstrafe())
    var_13 = 0;
  else if(isDefined(var_12) || self iscurrentenemyvalid()) {
    if(isDefined(var_12))
      var_14 = var_12.shootpos;
    else {
      if(issentient(self.enemy) && gettime() - self lastknowntime(self.enemy) > 2000)
        return 0;

      var_14 = self lastknownpos(self.enemy);
    }

    if(distance2dsquared(var_14, self.origin) < 22500)
      return 0;

    var_15 = var_14 - self getposonpath(32);
    var_16 = vectortoyaw(var_15);

    if(abs(angleclamp180(var_16 - self.angles[1])) < 45)
      return 0;

    var_13 = angleclamp180(var_7 - var_16);
  } else if(istrue(self._blackboard.forcestrafe))
    return 0;
  else {
    if(var_8 || self pathdisttogoal() < 64)
      return 0;

    var_13 = angleclamp180(var_7 - self.desiredangle);
  }

  if(abs(angleclamp180(var_10 - var_13)) < 45)
    return 0;

  var_17 = scripts\asm\soldier\move::yawdiffto2468(var_10);
  var_18 = scripts\asm\soldier\move::yawdiffto2468(var_13);

  if(var_17 == var_18)
    return 0;

  var_19 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349E();

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var_20 = scripts\asm\shared\utility::getbasearchetype();
    var_19 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349E();
    self.strafepoispeedtarget = getnearestspeedthresholdname(var_20, var_19);
  } else
    self.strafepoispeedtarget = undefined;

  var_21 = var_19 + "_encstr_BA4C02DF" + self.asm.strafe_foot + "_encstr_BA4C02DF" + var_17 + "_encstr_844305BFD3F2A8" + var_18;

  if(!scripts\asm\asm::asm_hasalias(var_2, var_21)) {
    if(var_17 == "_encstr_AC4C024A" || var_17 == "_encstr_8F4C026A")
      var_21 = var_19 + "_encstr_998210FFAC310F8B2F28720A588144C70B98" + var_17 + "_encstr_844305BFD3F2A8" + var_18;
    else
      var_21 = var_19 + "_encstr_A3DD11F533EDDEE8F5D8EBCCF6E4BB0B3991FA" + var_17 + "_encstr_844305BFD3F2A8" + var_18;

    if(!scripts\asm\asm::asm_hasalias(var_2, var_21))
      return 0;
  }

  self.asm.strafeaimchangealias = var_21;
  return 1;
}

_id_134BB(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::asm_eventfired(var_0, "_encstr_B6B30A278FC7F078673A0B11") && _id_134BC(var_0, var_1, var_2, var_3))
    return 1;

  return 0;
}

_id_134BD(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\soldier\arrival::shoulddoarrival())
    return 0;

  if(self.facemotion)
    return 0;

  if(!isDefined(self.pathgoalpos))
    return 0;

  if(isDefined(self.node) && isDefined(self.node.angles))
    return 0;

  var_4 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(isDefined(var_4)) {
    if(scripts\engine\utility::absangleclamp180(var_4.angles[1] - self.angles[1]) > 15)
      return 0;
  }

  if(self getreacquirestate() == "_encstr_A18008BD35E222F01BD0" && self._blackboard.reacquiresteptime >= gettime() - 50)
    return 0;

  var_5 = self.requestedgoalpos - self.origin;
  var_6 = length(var_5);

  if(var_6 > 96)
    return 0;

  if(var_6 < self pathdisttogoal() * 0.8)
    return 0;

  var_7 = vectortoyaw(var_5);
  var_8 = angleclamp180(var_7 - self.angles[1]);
  var_9 = getangleindex(var_8, 22.5);
  var_10 = ["_encstr_A74C0222", "_encstr_A14C023B", "_encstr_8F4C026A", "_encstr_8B4C0227", "_encstr_864C02F9", "_encstr_914C02DC", "_encstr_AC4C024A", "_encstr_A34C02BB", "_encstr_A74C0222"];
  var_11 = scripts\asm\shared\utility::getbasearchetype();
  var_12 = length(self.velocity);
  var_13 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349E();
  var_14 = getanimspeedthreshold(var_11, "_encstr_99F605EE16B1DA");
  var_15 = getanimspeedthreshold(var_11, "_encstr_88BF08EBB84B751CA8C1");
  var_16 = getanimspeedthreshold(var_11, "_encstr_8F7905C4AEC319");

  if(!var_14 && !var_15 && !var_16)
    return 0;

  var_17 = "_encstr_A54C0259";

  if(self.asm.footsteps.foot == "_encstr_8253060E2B5FE330")
    var_17 = "_encstr_844C029C";

  var_18 = var_13 + var_10[var_9] + var_17;
  var_19 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_18);
  var_20 = scripts\asm\asm::asm_getxanim(var_2, var_19);
  var_21 = getmovedelta(var_20);
  var_22 = length(var_21);

  if(var_22 < 0.75 * var_6 || var_22 > 1.5 * var_6)
    return 0;

  var_23 = length2d(self.velocity) * level.framedurationseconds;
  var_24 = self getposonpath(var_23);

  if(var_22 < length(self.requestedgoalpos - var_24))
    return 0;

  var_25 = 0.7;
  var_26 = 1.3;

  if(var_13 == "_encstr_88BF08EBB84B751CA8C1")
    var_25 = 0.9;
  else if(var_13 == "_encstr_8F7905C4AEC319")
    var_26 = 1.2;

  self.asm.strafearrival_animindex = var_19;
  self.asm.strafearrival_idealstartpos = self.requestedgoalpos - rotatevector(var_21, self.angles);
  var_27 = getnearestspeedthresholdname(var_11, var_13);

  if(isDefined(var_27))
    self.asm.strafearrival_rate = clamp(var_12 / var_27, var_25, var_26);
  else
    self.asm.strafearrival_rate = var_25;

  self.asm.strafearrival_duration = int(getanimlength(var_20) * self.asm.strafearrival_rate * 750);
  return 1;
}

_id_13488(var_0, var_1, var_2) {
  var_3 = "_encstr_B40101";

  if(scripts\asm\shared\utility::isentasoldier() && scripts\asm\shared\utility::demeanorhasblendspace()) {
    var_4 = scripts\asm\soldier\move::determinedesiredexitspeed();
    var_5 = scripts\asm\shared\utility::getbasearchetype();
    var_3 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349E();
    self.exitspeedtarget = getnearestspeedthresholdname(var_5, var_3);
  } else
    self.exitspeedtarget = undefined;

  if(!scripts\asm\soldier\move::checktransitionpreconditions())
    return undefined;

  var_6 = undefined;
  var_7 = 0;

  if(isDefined(var_2))
    var_7 = var_2;

  var_6 = scripts\asm\soldier\move::determinestartanim(var_1, var_7, var_3);
  return var_6;
}

_id_134A8(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(scripts\asm\asm_bb::bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_pos))
      var_4 = self._blackboard.shootparams_pos;
    else if(isDefined(self._blackboard.shootparams_ent))
      var_4 = self._blackboard.shootparams_ent.origin;
  }

  if(!isDefined(var_4)) {
    if(isDefined(self.smartfacingpos))
      var_4 = self.smartfacingpos;
  }

  if(!isDefined(var_4)) {
    var_5 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349A();

    if(isDefined(var_5) && isalive(var_5))
      var_4 = var_5.origin;
  }

  if(!isDefined(var_4) && isDefined(self.node) && self.node.type == "_encstr_8E2508511EE07BE6B246" && distancesquared(self.node.origin, self.origin) < 36 && self.combatmode != "_encstr_821109FAE81117DA568730")
    var_4 = self.node.origin + anglesToForward(self.node.angles) * 384;

  if(!isDefined(var_4))
    return 0;

  var_6 = self.angles[1] - vectortoyaw(var_4 - self.origin);
  var_7 = distancesquared(self.origin, var_4);

  if(var_7 < 65536) {
    var_8 = sqrt(var_7);

    if(var_8 > 3)
      var_6 = var_6 + asin(-3 / var_8);
  }

  return abs(angleclamp180(var_6)) > self.turnthreshold;
}

_encstr_86AE1D701AF539D86F72A83E6A5F41E99DA2F858D28849501F8DCDA354FBC9(var_0, var_1, var_2) {
  if(!_encstr_A938134BCF0540DA4A12771B26C7C04B5F11DFF20B())
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_914B078DB09BAB0BB1");

  return scripts\asm\soldier\script_funcs::chooseanimidle_interiorexterior(var_0, var_1, var_2);
}

_encstr_A938134BCF0540DA4A12771B26C7C04B5F11DFF20B(var_0, var_1, var_2, var_3) {
  return self.spec == "_encstr_91181243A212272C1120DF82BBE9A253367D3B27" || self.alertlevel != "_encstr_AB410AEE5FF05E3739D98AE3";
}

_encstr_8A7D18D6B7200D488093117313E1D7C5A7B25BE3F335F1C8D718(var_0, var_1, var_2) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  scripts\common\gameskill::didsomethingotherthanshooting();
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);

  if(scripts\engine\utility::actor_is3d() && isDefined(self.enemy))
    self orientmode("_encstr_B43B0B33C2B1AC0895B92BAD5E");
  else
    self orientmode("_encstr_91440EF5D7AA1B467F70DAB9531A9ED1", self.angles);

  if(isDefined(self.node))
    self animmode("_encstr_8E9F0D859BD9C62B01192B8D1DC237");
  else
    self animmode("_encstr_A1370EF3FA638AFB695A587B03B42E57");

  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  self.stepoutyaw = angleclamp180(getangledelta(var_4, 0, 1) + self.angles[1]);
  self.useanimgoalweight = 1;
  var_5 = 1;
  self aisetanim(var_1, var_3, var_5);

  if(scripts\asm\soldier\script_funcs::shouldfaceenemyinexposed())
    thread scripts\asm\soldier\script_funcs::playturnanim_turnanimanglefixup(var_4, var_1);

  scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

_encstr_B2631AF8F8386B70A943416BBBD95EA8FF273EFD3BA008F0D662B0C7(var_0, var_1, var_2) {
  if(!_encstr_A938134BCF0540DA4A12771B26C7C04B5F11DFF20B()) {
    self.desiredturnyaw = scripts\asm\soldier\script_funcs::getturndesiredyaw();
    var_3 = scripts\asm\soldier\patrol::patrol_choosestationaryturnanim(var_0, var_1, var_2);
    self.desiredturnyaw = undefined;
    return var_3;
  }

  return scripts\asm\soldier\script_funcs::chooseturnanim(var_0, var_1, var_2);
}

_encstr_978420C35A1B95E8C7EA2F4DF2A1E869D7D3BB8B33BB5FA89CDD2747041738202FDB(var_0, var_1, var_2) {
  self.useanimgoalweight = 0;
  self.stepoutyaw = undefined;
  self.desiredturnyaw = undefined;
}