/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\ai_sentry_turret.gsc
***********************************************/

init() {
  level.sentrysettings["ai_sentry_turret"] = spawnStruct();
  level.sentrysettings["ai_sentry_turret"].health = 999999;
  level.sentrysettings["ai_sentry_turret"].maxhealth = 650;
  level.sentrysettings["ai_sentry_turret"].burstmin = 20;
  level.sentrysettings["ai_sentry_turret"].burstmax = 120;
  level.sentrysettings["ai_sentry_turret"].pausemin = 0.15;
  level.sentrysettings["ai_sentry_turret"].pausemax = 0.35;
  level.sentrysettings["ai_sentry_turret"].lockstrength = 6;
  level.sentrysettings["ai_sentry_turret"].sentrymodeon = "sentry";
  level.sentrysettings["ai_sentry_turret"]._id_7C46D96A6FEDD4CD = "manual";
  level.sentrysettings["ai_sentry_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["ai_sentry_turret"].spinuptime = 1.5;
  level.sentrysettings["ai_sentry_turret"].overheattime = 8.0;
  level.sentrysettings["ai_sentry_turret"].cooldowntime = 0.3;
  level.sentrysettings["ai_sentry_turret"]._id_AA507124549D7490 = 4;
  level.sentrysettings["ai_sentry_turret"]._id_6265B628C3ED1103 = 3;
  level.sentrysettings["ai_sentry_turret"]._id_87D927A08CBFDF3F = 1;
  level.sentrysettings["ai_sentry_turret"].leftarc = 80;
  level.sentrysettings["ai_sentry_turret"].rightarc = 80;
  level.sentrysettings["ai_sentry_turret"].fxtime = 0.3;
  level.sentrysettings["ai_sentry_turret"]._id_951AF53D31931D09 = 1024;
  level.sentrysettings["ai_sentry_turret"].weaponinfo = "sentry_turret_mp";
  level.sentrysettings["ai_sentry_turret"].playerweaponinfo = "sentry_turret_mp";
  level.sentrysettings["ai_sentry_turret"].modelbaseground = "wpn_wm_p45_mg_auto_sentry_v0_mp";
  level.sentrysettings["ai_sentry_turret"].modeldestroyedground = "wpn_wm_p45_mg_auto_sentry_v0_mp";
  level.sentrysettings["ai_sentry_turret"].scorepopup = "destroyed_sentry";
  level.sentrysettings["ai_sentry_turret"].lightfxtag = "tag_fx";

  if(getdvarint("scr_ai_sentry_turret", 1) == 0) {
    return;
  }
  level._id_B08CAEEDD32CFDAF = spawnStruct();
  level._id_B08CAEEDD32CFDAF._id_0545DB13B94C9E4D = getdvarint("dvar_E2A4ECAA972FB581", 15);
  level._id_B08CAEEDD32CFDAF._id_A4186F089A36D2F0 = getdvarint("dvar_6A8C234B065D124C", 3);
  level._id_B08CAEEDD32CFDAF._id_A4CD5B9AE4A509F4 = [];
  level._id_B08CAEEDD32CFDAF._id_325F9F15252B4928 = ::_id_2D24EE630D6C37E2;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("aiSentryTurrets");
}

_id_2D24EE630D6C37E2() {
  while(!scripts\engine\utility::flag_exist("create_script_initialized"))
    waitframe();

  scripts\engine\utility::flag_wait("create_script_initialized");
  waitframe();
  _id_76BC16F4E15DEC1C = _id_5DEF7AF2A9F04234::_id_47D356083884F913();
  _id_171F90B9C4C76D44 = undefined;
  level._id_B08CAEEDD32CFDAF._id_FD5EA9CB37C309D3 = scripts\engine\utility::array_randomize(scripts\engine\utility::getStructArray("aiSentryTurret", "script_noteworthy"));

  foreach(_id_FB1DEF007972B25A in level._id_B08CAEEDD32CFDAF._id_FD5EA9CB37C309D3) {
    _id_DE58CA0235EE107B = 1;

    if(level._id_B08CAEEDD32CFDAF._id_A4CD5B9AE4A509F4.size >= level._id_B08CAEEDD32CFDAF._id_0545DB13B94C9E4D)
      _id_DE58CA0235EE107B = 0;
    else if(_id_76BC16F4E15DEC1C) {
      if(!isDefined(_id_FB1DEF007972B25A._id_B205D90302DA2F07))
        _id_FB1DEF007972B25A._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_FB1DEF007972B25A.origin);

      if(!isDefined(_id_FB1DEF007972B25A._id_B205D90302DA2F07) || !_id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(_id_FB1DEF007972B25A._id_B205D90302DA2F07))
        _id_DE58CA0235EE107B = 0;
      else if(level._id_B205D90302DA2F07[_id_FB1DEF007972B25A._id_B205D90302DA2F07]["aiSentryTurrets"].size >= level._id_B08CAEEDD32CFDAF._id_A4186F089A36D2F0)
        _id_DE58CA0235EE107B = 0;
    }

    if(_id_DE58CA0235EE107B) {
      _id_FB1DEF007972B25A._id_1B096843A2175F92 = 1;
      turret = _id_F33B0AFADF9107EB(_id_FB1DEF007972B25A);
      level._id_B08CAEEDD32CFDAF._id_A4CD5B9AE4A509F4[level._id_B08CAEEDD32CFDAF._id_A4CD5B9AE4A509F4.size] = turret;

      if(_id_76BC16F4E15DEC1C && isDefined(_id_FB1DEF007972B25A._id_B205D90302DA2F07)) {
        level._id_B205D90302DA2F07[_id_FB1DEF007972B25A._id_B205D90302DA2F07]["aiSentryTurrets"][level._id_B205D90302DA2F07[_id_FB1DEF007972B25A._id_B205D90302DA2F07]["aiSentryTurrets"].size] = turret;
        _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(_id_FB1DEF007972B25A._id_B205D90302DA2F07, "aiSentryTurrets", turret);
      }
    }
  }
}

_id_2DD8DD0EBC078F25() {
  wait 10;
  config = level.sentrysettings["ai_sentry_turret"];
  _id_B5DEFF62BA0378CA = spawnStruct();
  _id_B5DEFF62BA0378CA.origin = (2644, -4359, 10);
  _id_B5DEFF62BA0378CA.angles = (0, 180, 0);

  if(isDefined(_id_B5DEFF62BA0378CA))
    turret = _id_F33B0AFADF9107EB(_id_B5DEFF62BA0378CA);
}

_id_F33B0AFADF9107EB(_id_B5DEFF62BA0378CA, team, _id_B43BC01927D1C26A) {
  if(!istrue(_id_B43BC01927D1C26A) && getdvarint("scr_ai_sentry_turret", 1) == 0) {
    return;
  }
  if(!isDefined(team))
    team = "team_hundred_ninety_five";

  config = level.sentrysettings["ai_sentry_turret"];
  turret = spawnturret("misc_turret", _id_B5DEFF62BA0378CA.origin, config.weaponinfo);
  turret.angles = _id_B5DEFF62BA0378CA.angles;
  turret.health = 9999;
  turret.maxhealth = config.maxhealth;
  turret.ammocount = config.ammo;
  turret.timeout = config.timeout;
  turret.momentum = 0;
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 0.1;
  turret.sentrytype = "ai_sentry_turret";
  turret._id_3A94ED22775A3C94 = team;
  turret.team = team;
  turret setModel(config.modelbaseground);
  turret setturretteam(turret._id_3A94ED22775A3C94);
  turret setCanDamage(1);
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret setautorotationdelay(0.5);
  turret maketurretinoperable();
  leftarc = float(scripts\engine\utility::ter_op(isDefined(_id_B5DEFF62BA0378CA.leftarc), _id_B5DEFF62BA0378CA.leftarc, config.leftarc));
  turret.leftarc = leftarc;
  turret setleftarc(leftarc);
  rightarc = float(scripts\engine\utility::ter_op(isDefined(_id_B5DEFF62BA0378CA.rightarc), _id_B5DEFF62BA0378CA.rightarc, config.rightarc));
  turret.rightarc = rightarc;
  turret setrightarc(rightarc);
  turret setbottomarc(50);
  turret settoparc(60);
  turret setconvergencetime(1.0, "pitch");
  turret setconvergencetime(1.0, "yaw");
  turret setconvergenceheightpercent(0.9);
  turret setdefaultdroppitch(-89.0);
  turret setturretmodechangewait(1);
  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(::_id_76189206D67BD21C);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(::_id_1EF2976B1357C651);
  turret laseron();
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel.owner = turret.owner;
  turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
  turret.colmodel dontinterpolate();
  turret.colmodel hide();
  turret thread scripts\mp\damage::monitordamage(turret.maxhealth, "hitequip", ::_id_4424088DA3075B69, ::_id_CB32FE838A62170F, 1);
  turret thread _id_B0FACA885D335F8B(turret);
  turret thread _id_F9DCBE0AB7AAC5F6();
  turret thread _id_9E099B94CB9FC336();
  turret thread _id_352E4C58083275A4();
  turret.turreton = 1;
  turret setmode(config.sentrymodeon);
  return turret;
}

_id_4424088DA3075B69(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  config = level.sentrysettings[self.sentrytype];
  _id_A93F9D30441FFED1 = 0;

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH")
    _id_A93F9D30441FFED1 = 1;

  if(isDefined(attacker)) {
    guy = scripts\engine\utility::ter_op(isDefined(attacker.owner), attacker.owner, attacker);

    if(isPlayer(guy))
      guy thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2B5885666AF24123", objweapon, undefined, undefined, self, undefined, undefined, 0, undefined, 1);
  }

  self notify("kill_turret", _id_A93F9D30441FFED1, 1);
}

_id_CB32FE838A62170F(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  return damage;
}

_id_F9DCBE0AB7AAC5F6() {
  self endon("death");
  config = level.sentrysettings[self.sentrytype];

  for(;;) {
    if(!istrue(self.turreton) || istrue(self.turretdisabled)) {
      waitframe();
      continue;
    }

    besttarget = _id_22DEB1E23A622FFF();
    _id_1B951C4E47BA5C35 = 1;

    if(isDefined(besttarget)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](besttarget))
          _id_1B951C4E47BA5C35 = 0;
      }

      if(_id_1B951C4E47BA5C35) {
        thread scripts\cp_mp\utility\debug_utility::drawline(besttarget.origin, self.origin, 5, (0, 0, 1));
        _id_EB48FDF891A4E9EE(besttarget);
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(config.cooldowntime);
      }
    }

    waitframe();
  }
}

_id_EB48FDF891A4E9EE(besttarget) {
  config = level.sentrysettings[self.sentrytype];

  while(istrue(self.turreton) && _id_C5754FDAC13FC2A5(besttarget)) {
    self settargetentity(besttarget);

    if(isPlayer(besttarget))
      _id_6E7B6ACDC197A7EC = config._id_6265B628C3ED1103;
    else
      _id_6E7B6ACDC197A7EC = config._id_87D927A08CBFDF3F;

    _id_BA7DF6EEACB835F6(config._id_AA507124549D7490, besttarget);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_6E7B6ACDC197A7EC);
    self cleartargetentity(besttarget);
  }
}

_id_22DEB1E23A622FFF() {
  config = level.sentrysettings[self.sentrytype];
  _id_951AF53D31931D09 = config._id_951AF53D31931D09;
  _id_52EDC18A611B938D = _id_951AF53D31931D09 * _id_951AF53D31931D09;
  _id_B80DBEDF22C6D394 = scripts\common\utility::playersinsphere(self.origin, _id_951AF53D31931D09);
  besttarget = undefined;
  _id_B3F7F2DDF0FD4828 = undefined;

  foreach(_id_BD73C7ACC56CD20C in _id_B80DBEDF22C6D394) {
    _id_E85A3B23195A0FE0 = _id_10F997ED68F4FCEF(_id_BD73C7ACC56CD20C);

    if(!istrue(_id_E85A3B23195A0FE0)) {
      continue;
    }
    startpoint = self gettagorigin("tag_flash");
    endpoint = _id_BD73C7ACC56CD20C.origin;
    _id_5E048634C072B43B = distancesquared(startpoint, endpoint);

    if(_id_5E048634C072B43B <= _id_52EDC18A611B938D) {
      if(!isDefined(besttarget) && !isDefined(_id_B3F7F2DDF0FD4828) || _id_5E048634C072B43B < _id_B3F7F2DDF0FD4828) {
        besttarget = _id_BD73C7ACC56CD20C;
        _id_B3F7F2DDF0FD4828 = _id_5E048634C072B43B;
      }
    }
  }

  return besttarget;
}

_id_10F997ED68F4FCEF(_id_BD73C7ACC56CD20C) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](_id_BD73C7ACC56CD20C))
      return 0;
  }

  if(istrue(_id_BD73C7ACC56CD20C.notarget))
    return 0;

  if(istrue(_id_BD73C7ACC56CD20C._id_F6F8549C6FD27E85))
    return 0;

  if(!_id_BC0708B3CC5719C9(_id_BD73C7ACC56CD20C))
    return 0;

  if(!_id_F6F04FC4E42CF2C4(_id_BD73C7ACC56CD20C))
    return 0;

  return 1;
}

_id_C5754FDAC13FC2A5(besttarget) {
  config = level.sentrysettings[self.sentrytype];
  maxrangesq = config._id_951AF53D31931D09 * config._id_951AF53D31931D09;

  if(distancesquared(self gettagorigin("tag_flash"), besttarget.origin) > maxrangesq)
    return 0;

  if(!_id_10F997ED68F4FCEF(besttarget))
    return 0;

  return 1;
}

_id_BC0708B3CC5719C9(_id_BD73C7ACC56CD20C) {
  offset = vectorNormalize(self.origin - _id_BD73C7ACC56CD20C.origin);
  _id_9913FD1FFEA99C33 = vectordot(anglesToForward(self.angles), offset);
  return _id_9913FD1FFEA99C33 < 0;
}

_id_F6F04FC4E42CF2C4(_id_BD73C7ACC56CD20C) {
  _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  _id_7E7A5A3C0A297A0B = ["j_head", "j_mainroot", "tag_origin"];
  canseetarget = 0;

  foreach(point in _id_7E7A5A3C0A297A0B) {
    canseetarget = scripts\engine\trace::ray_trace_passed(self gettagorigin("tag_flash"), _id_BD73C7ACC56CD20C gettagorigin(point), self, _id_C3FBB6661B91750F);

    if(istrue(canseetarget)) {
      canseetarget = 1;
      break;
    }
  }

  return canseetarget;
}

_id_B0FACA885D335F8B(turret) {
  turret waittill("kill_turret", _id_0B2797481A55C620, _id_4FAC8B8CE36E09F1);
  turret._id_6181D0250AFA3CEC = 1;
  turret _id_CAEA36DC6C3CE373("destroyed");
  turret setturretowner(undefined);

  if(!istrue(_id_0B2797481A55C620)) {
    turret playSound("sentry_explode_smoke");
    turret setscriptablepartstate("shutdown", "on");
    turret.turreton = 0;
    turret.turretdisabled = 1;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    turret setscriptablepartstate("explode", "regular");
  } else
    turret setscriptablepartstate("explode", "violent");

  turret playSound("mp_equip_destroyed");

  if(isDefined(turret.colmodel))
    turret.colmodel delete();

  wait 0.2;

  if(0)
    level thread _id_92FA86C7825C72E1(turret.origin, turret.angles, turret.leftarc, turret.rightarc, 4);

  turret delete();
}

_id_92FA86C7825C72E1(origin, angles, leftarc, rightarc, _id_68FAA79E3E6058FB) {
  wait(_id_68FAA79E3E6058FB);
  _id_B5DEFF62BA0378CA = spawnStruct();
  _id_B5DEFF62BA0378CA.origin = origin;
  _id_B5DEFF62BA0378CA.angles = angles;
  _id_B5DEFF62BA0378CA.leftarc = leftarc;
  _id_B5DEFF62BA0378CA.rightarc = rightarc;
  turret = _id_F33B0AFADF9107EB(_id_B5DEFF62BA0378CA);
}

_id_CAEA36DC6C3CE373(type) {
  turretmodel = undefined;

  if(type == "destroyed")
    turretmodel = level.sentrysettings[self.sentrytype].modeldestroyedground;

  self setModel(turretmodel);
}

_id_9E099B94CB9FC336() {
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self)) {
    self.colmodel delete();
    self delete();
  }
}

_id_01279FB3B42FF8E1() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  self playSound("sentry_gun_target_lock_beep", undefined, self);
  wait 0.19;
  self playSound("sentry_gun_target_lock_beep", undefined, self);
}

_id_BA7DF6EEACB835F6(_id_BE9FA813C1AFA2C8, _id_BD73C7ACC56CD20C) {
  _id_38EDCF00CFD7F099();
  config = level.sentrysettings[self.sentrytype];
  firetime = weaponfiretime(config.weaponinfo);
  _id_3746EC1BEFD86AE8 = config.burstmin;
  _id_3E92CD336A99CE02 = config.burstmax;
  _id_5F622C39D6661B23 = config.pausemin;
  _id_42AE243CD994C3BD = config.pausemax;
  lockstrength = config.lockstrength;
  currenttime = 0;
  _id_1B951C4E47BA5C35 = 1;

  while(istrue(self.turreton) && currenttime < _id_BE9FA813C1AFA2C8 && _id_1B951C4E47BA5C35) {
    _id_89F949A75D92E1A4 = randomintrange(_id_3746EC1BEFD86AE8, _id_3E92CD336A99CE02 + 1);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_89F949A75D92E1A4 && !self.overheated; _id_AC0E594AC96AA3A8++) {
      if(!istrue(self.turreton)) {
        break;
      }

      target = self getturrettarget(1);

      if(!isDefined(target)) {
        break;
      }

      self shootturret("tag_flash", lockstrength);
      wait(firetime);
      currenttime = currenttime + firetime;
    }

    if(!istrue(self.turreton)) {
      break;
    }

    _id_43559AFED713D177 = randomfloatrange(_id_5F622C39D6661B23, _id_42AE243CD994C3BD);
    wait(_id_43559AFED713D177);
    currenttime = currenttime + _id_43559AFED713D177;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive"))
      _id_1B951C4E47BA5C35 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](_id_BD73C7ACC56CD20C);
  }

  _id_E711849FBC474180();
}

_id_AFE3C3AF7CB5E39E() {
  _id_E711849FBC474180();
}

_id_38EDCF00CFD7F099() {
  config = level.sentrysettings[self.sentrytype];
  thread _id_01279FB3B42FF8E1();

  while(istrue(self.turreton) && self.momentum < config.spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

_id_E711849FBC474180() {
  self.momentum = 0;
}

_id_352E4C58083275A4() {
  self endon("kill_turret");
  level endon("game_ended");

  for(;;) {
    wait 3.0;

    if(self isfiringturret()) {
      waitframe();
      continue;
    }

    self playSound("sentry_gun_beep", undefined, self);
  }
}

_id_704307EB2F1581AC(_id_73D512F6FFEF310D) {
  self endon("death");
  config = level.sentrysettings[self.sentrytype];
  self setmode(config.sentrymodeoff);
  self.turreton = 0;

  for(;;) {
    _id_73D512F6FFEF310D waittill("trigger", player);

    if(!istrue(self.turreton)) {
      self.turreton = 1;
      self setmode(config.sentrymodeon);

      while(isalive(player) && player istouching(_id_73D512F6FFEF310D))
        waitframe();

      self.turreton = 0;
      self setmode(config.sentrymodeoff);
      self notify("stop_shooting");
    }
  }
}

_id_76189206D67BD21C(data) {
  if(isDefined(data.attacker)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
      data.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("disabled_sentry_gun");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "empStarted"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "empStarted")]]();
  }

  _id_0E3217606F8218AE();
}

_id_1EF2976B1357C651(_id_B3990D56E2779F79) {
  if(_id_B3990D56E2779F79) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentry_gun", "empStarted"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentry_gun", "empCleared")]]();

  _id_0E3217606F8218AE();
}

_id_0E3217606F8218AE() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
    self laseroff();
  } else if(!istrue(self._id_6181D0250AFA3CEC)) {
    self turretfireenable();
    self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
    self laseron();
  }
}