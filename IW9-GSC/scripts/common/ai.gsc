/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\ai.gsc
***********************************************/

_id_67EC1DF786CAD61A() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];
    player _id_D7EDB8535850DB35();
  }
}

_id_D7EDB8535850DB35() {
  self _meth_D068AF002E4ECAB5();
}

set_forcegoal() {
  if(isDefined(self.set_forcedgoal)) {
    return;
  }
  self.oldfightdist = self.pathenemyfightdist;
  self.oldmaxdist = self.pathenemylookahead;
  self.oldmaxsight = self.maxsightdistsqrd;
  self.pathenemyfightdist = 8;
  self.pathenemylookahead = 8;
  self.maxsightdistsqrd = 1;
  self.set_forcedgoal = 1;
}

unset_forcegoal() {
  if(!isDefined(self.set_forcedgoal)) {
    return;
  }
  self.pathenemyfightdist = self.oldfightdist;
  self.pathenemylookahead = self.oldmaxdist;
  self.maxsightdistsqrd = self.oldmaxsight;
  self.set_forcedgoal = undefined;
}

disable_exits() {
  self.disableexits = 1;
}

enable_exits() {
  self.disableexits = 0;
}

disable_turnanims() {
  self._id_4CD89215083D17CD = 0;
}

enable_turnanims() {
  self._id_4CD89215083D17CD = 1;
}

disable_arrivals() {
  self.disablearrivals = 1;
}

enable_arrivals() {
  self endon("death");
  waittillframeend;
  self.disablearrivals = 0;
}

set_rebel(_id_5B0A55B4E162FEE3) {
  self._blackboard._id_96A8CBC0DFD31486 = _id_5B0A55B4E162FEE3;
}

spawn_failed(ent) {
  if(!isalive(ent))
    return 1;

  if(scripts\common\utility::issp() && !isDefined(ent.finished_spawning))
    ent scripts\engine\utility::waittill_either("finished spawning", "death");

  if(isalive(ent))
    return 0;

  return 1;
}

gun_remove() {
  if(isai(self))
    scripts\engine\utility::script_func("anim_placeweaponon", self.weapon, "none");
  else if(isDefined(self.fake_weapon_models))
    gun_remove_fake();
  else
    self detach(getweaponmodel(self.weapon), "tag_weapon_right");
}

gun_remove_fake() {
  if(isDefined(self.fake_weapon_models)) {
    for(_id_AC0E594AC96AA3A8 = self.fake_weapon_models.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--)
      self detach(self.fake_weapon_models[_id_AC0E594AC96AA3A8]);

    self.fake_weapon_models = undefined;
  }
}

gun_create_fake(models) {
  foreach(model in models) {
    if(issubstr(model, "toprail") || issubstr(model, "railcust")) {
      if(models.size > 1) {
        models = scripts\engine\utility::array_remove(models, model);
        models = scripts\engine\utility::array_insert(models, model, 1);
      }
    }
  }

  foreach(model in models)
  self attach(model);

  self.fake_weapon_models = models;
}

gun_recall() {
  if(isai(self))
    scripts\engine\utility::script_func("anim_placeweaponon", self.weapon, "right");
  else
    self attach(getweaponmodel(self.weapon), "tag_weapon_right");
}

set_gunpose(type, gundiscipline) {
  if(type == "automatic")
    type = undefined;

  self.gunposeoverride = type;
  self.gundiscipline = isDefined(gundiscipline) && gundiscipline;
}

reset_gunpose() {
  self.gunposeoverride = undefined;
  self.gundiscipline = 1;
}

poi_enable(val, startstruct) {
  scripts\asm\shared\utility::toggle_poi(val, startstruct);
}

stop_use_turret() {
  self notify("stop_use_turret");
  self unlink();
  self._blackboard.requestedturret = undefined;
  self._blackboard.requestedturretpose = undefined;
}

magic_bullet_shield(_id_7A28BDD1351DCBFB) {
  if(istrue(_id_7A28BDD1351DCBFB))
    _id_3B64EB40368C1450::set("magic_bullet_shield", "damage", -1);
  else
    _id_3B64EB40368C1450::set("magic_bullet_shield", "damage", 0);
}

stop_magic_bullet_shield() {
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("magic_bullet_shield");
}

_id_3F8F8FB4E593BFCE() {
  self notify("stop_magic_bullet_shield");

  if(isai(self)) {
    if(isDefined(self.old_attackeraccuracy)) {
      self.attackeraccuracy = self.old_attackeraccuracy;
      self.old_attackeraccuracy = undefined;
    } else
      self.attackeraccuracy = 1;
  }

  self.magic_bullet_shield = undefined;
  self.damageshield = 0;
  self notify("internal_stop_magic_bullet_shield");
}

magic_bullet_death_detection() {}

_id_34707F8E64F52969(_id_7A28BDD1351DCBFB) {
  if(isai(self)) {} else
    self.health = 100000;

  self endon("internal_stop_magic_bullet_shield");

  if(isai(self)) {
    self.old_attackeraccuracy = self.attackeraccuracy;
    self.attackeraccuracy = 0.1;
  }

  self notify("magic_bullet_shield");
  self.magic_bullet_shield = 1;
  self.damageshield = 1;
}

force_long_death_on_back_with_pistol(_id_5FA1543FA4653811) {
  self.forcelongdeath = 4;

  if(istrue(_id_5FA1543FA4653811))
    self.skipdyingbackcrawl = 1;

  self asmsetstate(self.asmname, "choose_long_death");
}

_id_A1404EF1116DBE2C(_id_5FA1543FA4653811, _id_F8FBA28C44387FD8) {
  _id_0535B99B940095F4 = [29, 31, 33, 35];
  _id_F4CAD9D2914C9DEB = randomint(4);
  self.forcelongdeath = _id_0535B99B940095F4[_id_F4CAD9D2914C9DEB];

  if(isDefined(_id_F8FBA28C44387FD8))
    self._id_00D0BEA6CF479A9C = _id_F8FBA28C44387FD8;

  if(isDefined(_id_5FA1543FA4653811))
    self.skipdyingbackcrawl = _id_5FA1543FA4653811;

  self asmsetstate(self.asmname, "choose_long_death");
}

_id_B9307A16E291255E(_id_5FA1543FA4653811, _id_F8FBA28C44387FD8) {
  self.forcelongdeath = 37;

  if(isDefined(_id_F8FBA28C44387FD8))
    self._id_00D0BEA6CF479A9C = _id_F8FBA28C44387FD8;

  if(isDefined(_id_5FA1543FA4653811))
    self.skipdyingbackcrawl = _id_5FA1543FA4653811;

  self asmsetstate(self.asmname, "choose_long_death");
}

force_long_death_crawling_away() {
  self.forcelongdeath = 3;
}

force_long_death_stumbling() {
  self.forcelongdeath = 2;
}

find_and_teleport_to_cover(_id_066FCA63B388F049) {
  _id_6CB7C526CA1B2907 = 0;
  _id_8F78581CD3208C45 = undefined;
  _id_75D29D4786AE4B4D = 1;
  _id_0386C209C4BE9E91 = self findbestcovernode(_id_066FCA63B388F049, _id_6CB7C526CA1B2907, _id_8F78581CD3208C45, _id_75D29D4786AE4B4D);

  if(isDefined(_id_0386C209C4BE9E91)) {
    _id_D38A5EB1292B482C = _id_0386C209C4BE9E91.angles;
    _id_CEE7A3C264A91076 = _id_0386C209C4BE9E91.origin;

    if(!issubstr(_id_0386C209C4BE9E91.type, "Prone")) {
      if(issubstr(_id_0386C209C4BE9E91.type, "Left"))
        _id_D38A5EB1292B482C = _id_D38A5EB1292B482C + (0, 90, 0);
      else if(issubstr(_id_0386C209C4BE9E91.type, "Right") || issubstr(_id_0386C209C4BE9E91.type, "Cover Crouch") || issubstr(_id_0386C209C4BE9E91.type, "Conceal") || issubstr(_id_0386C209C4BE9E91.type, "Cover Stand"))
        _id_D38A5EB1292B482C = _id_D38A5EB1292B482C - (0, 90, 0);
    }

    self forceteleport(_id_CEE7A3C264A91076, _id_D38A5EB1292B482C);
    self usecovernode(_id_0386C209C4BE9E91, 1);
    self setgoalnode(_id_0386C209C4BE9E91);
    return 1;
  }

  return 0;
}

aigroundturret_requestmount(turret) {
  if(self._blackboard.aigroundturretstate == "none") {
    self._blackboard.aigroundturretstate = "turret_mount_requested";
    self._blackboard.aigroundturretref = turret;
    return 1;
  }

  return 0;
}

aigroundturret_mountcompleted() {
  if(self._blackboard.aigroundturretstate == "turret_mount_requested")
    self._blackboard.aigroundturretstate = "turret_mounted";
}

aigroundturret_cancel() {
  if(self._blackboard.aigroundturretstate != "none") {
    if(self._blackboard.aigroundturretstate == "turret_mount_requested") {
      self._blackboard.aigroundturretstate = "none";
      self._blackboard.aigroundturretref = undefined;
      return 1;
    } else if(self._blackboard.aigroundturretstate == "turret_mounted") {
      self._blackboard.aigroundturretstate = "turret_dismount_requested";
      return 1;
    }
  }

  return 0;
}

aigroundturret_dismountcompleted() {
  if(self._blackboard.aigroundturretstate == "turret_dismount_requested") {
    self._blackboard.aigroundturretstate = "none";
    self._blackboard.aigroundturretref = undefined;
  }
}

ai_operate_turret(turret_operator, turret) {
  if(!isDefined(turret_operator) || !isalive(turret_operator)) {
    return;
  }
  _id_DCDF8390F44EE5CE = turret_operator aigroundturret_requestmount(turret);

  if(_id_DCDF8390F44EE5CE) {
    turret_operator.ignoreall = 1;
    turret_operator.ignoreme = 1;
  }
}

ai_dismount_turret(turret_operator) {
  if(!isDefined(turret_operator) || !isalive(turret_operator)) {
    return;
  }
  _id_45C1EE9653B5E42E = turret_operator aigroundturret_cancel();

  if(_id_45C1EE9653B5E42E) {
    turret_operator.ignoreall = 0;
    turret_operator.ignoreme = 0;
  }
}

_id_E2368C53744B331C(_id_34EA4B5A7B2A021B, _id_F58C62635C797BFD, cooldown, _id_C620CD5BD6B19EBF) {
  if(isai(self)) {
    if(isDefined(_id_34EA4B5A7B2A021B))
      self._id_55A29022CF7ABDAD = _id_34EA4B5A7B2A021B;

    if(isDefined(_id_F58C62635C797BFD))
      self._id_39887BA979A993AB = _id_F58C62635C797BFD;

    if(isDefined(cooldown))
      self._id_FC9B05FF80C7A4D6 = cooldown;

    if(isDefined(_id_C620CD5BD6B19EBF))
      self._id_EDB88205B19560BD = _id_C620CD5BD6B19EBF;
  }
}

_id_1123C27B444D9B1F() {
  if(isai(self)) {
    self._id_55A29022CF7ABDAD = undefined;
    self._id_39887BA979A993AB = undefined;
    self._id_FC9B05FF80C7A4D6 = undefined;
    self._id_EDB88205B19560BD = 0;
  }
}

_id_4DCCA048A83A2F3C(_id_0C0AB0189903C9D4) {
  setdvarifuninitialized("dvar_8483522C1E47A279", 0);
  level._id_6BCBE686F8635184 = _id_0C0AB0189903C9D4;
  scripts\engine\utility::flag_wait("scriptables_ready");

  while(gettime() < 3000)
    wait 0.1;

  guys = getaiarray();
  ents = getEntArray();

  foreach(ent in ents) {
    if(istrue(ent._id_C8A1996A0BC3AEE5))
      guys[guys.size] = ent;
  }

  if(getdvarint("dvar_8483522C1E47A279"))
    scripts\engine\utility::array_thread(guys, ::_id_EE3867FAFBAD621B);

  foreach(guy in guys) {
    if(!guy isscriptable()) {
      if(getdvarint("dvar_8483522C1E47A279")) {
        if(isDefined(guy.model)) {} else {}
      }

      continue;
    }

    switch (level._id_6BCBE686F8635184) {
      case 0:
        guy setscriptablepartstate("wind", "0", 0);
        break;
      case 1:
        guy setscriptablepartstate("wind", "10", 0);
        break;
      case 2:
        guy setscriptablepartstate("wind", "20", 0);
        break;
      case 3:
        guy setscriptablepartstate("wind", "30", 0);
        break;
      case 4:
        guy setscriptablepartstate("wind", "40", 0);
        break;
      case 5:
        guy setscriptablepartstate("wind", "50", 0);
        break;
      case 6:
        guy setscriptablepartstate("wind", "60", 0);
        break;
      case 7:
        guy setscriptablepartstate("wind", "70", 0);
        break;
      case 8:
        guy setscriptablepartstate("wind", "80", 0);
        break;
      case 9:
        guy setscriptablepartstate("wind", "90", 0);
        break;
      case 10:
        guy setscriptablepartstate("wind", "100", 0);
        break;
      default:
    }
  }
}

_id_EE3867FAFBAD621B() {
  self endon("death");
  self notify("stop_wind_debug");
  self endon("stop_wind_debug");

  for(;;)
    wait 0.5;
}

set_deathanim(deathanim) {
  _id_60CE35EF4EA0CCAA = undefined;

  if(isstring(deathanim))
    _id_60CE35EF4EA0CCAA = scripts\engine\utility::getanim(deathanim);
  else
    _id_60CE35EF4EA0CCAA = deathanim;

  self.deathanim = _id_60CE35EF4EA0CCAA;
  self._id_2FA5EFF1B71A2229 = 1;
}

clear_deathanim() {
  self.deathanim = undefined;
  self._id_2FA5EFF1B71A2229 = 0;
}

_id_82A45E8AEF44CE3F(_id_B806597F9E8FE7A4) {
  self.deathfunction = _id_B806597F9E8FE7A4;

  if(isDefined(_id_B806597F9E8FE7A4))
    self._id_334AB06981BC61AA = 1;
  else
    self._id_334AB06981BC61AA = 0;
}

remove_blackboard_isburning(guy) {
  waitframe();

  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy._blackboard))
    guy._blackboard.isburning = undefined;
}

_id_60DAA23100A2B874(grenade, target) {
  if(isDefined(target.asmname) && target asmhaspainstate(target.asmname)) {
    target._blackboard.isburning = 1;
    target.burningtodeath = 0;
    target.burningdirection = undefined;
    target.semtexstuckto = 1;
    _id_013E753F7FE12D1B = anglestoright(target.angles);
    _id_F3982EE60FBBA2EE = vectorNormalize(grenade.origin - target.origin);

    if(vectordot(_id_013E753F7FE12D1B, _id_F3982EE60FBBA2EE) > 0)
      target.burningdirection = "right";
    else
      target.burningdirection = "left";

    target asmevalpaintransition(target.asmname);
    level thread remove_blackboard_isburning(target);
    grenade.stucktoai = target;
  }
}

_id_8A09C0E5FA78A48C(_id_EDA7FDCEC973DC54, duration, _id_CA585E1E3AA156C2, _id_AEBFE2AFCCF39F9B) {
  if(!isDefined(duration))
    duration = 8.25;

  if(!isDefined(_id_CA585E1E3AA156C2))
    _id_CA585E1E3AA156C2 = 250.0;

  if(!isDefined(_id_AEBFE2AFCCF39F9B))
    _id_AEBFE2AFCCF39F9B = 150.0;

  _func_D002A41ABEA504BB(_id_EDA7FDCEC973DC54, duration, _id_CA585E1E3AA156C2, _id_AEBFE2AFCCF39F9B);
}

_id_F8903387EA945165(_id_EDA7FDCEC973DC54, _id_651E92B77B0B6F82) {
  delay = 0;
  duration = undefined;
  _id_8DB63374EC6BC2F9 = undefined;
  _id_7FB57E466F7F039A = undefined;

  switch (_id_651E92B77B0B6F82) {
    case 0:
      delay = getdvarfloat("dvar_03FC2C1569AC6D8E", 1);
      duration = getdvarfloat("dvar_1A91F99ED9835CAB", 3.5);
      _id_8DB63374EC6BC2F9 = getdvarint("dvar_A29B7C7EAC63A6B0", 200);
      _id_7FB57E466F7F039A = getdvarint("dvar_372E7FE80817D5E5", 150);
      break;
    case 1:
      delay = getdvarfloat("dvar_F0DC25D5E4277D02", 0);
      duration = getdvarfloat("dvar_314FDF30C2156F67", 8.25);
      _id_8DB63374EC6BC2F9 = getdvarint("dvar_85175F3FBFC3CCC4", 250);
      _id_7FB57E466F7F039A = getdvarint("dvar_CE8793C0E589AB81", 150);
      break;
    case 2:
      delay = getdvarfloat("dvar_FF93BE3566F3591F", 0.25);
      duration = getdvarfloat("dvar_B322661C8CDD2910", 1.4);
      _id_8DB63374EC6BC2F9 = getdvarint("dvar_230D4F148436BCBF", 200);
      _id_7FB57E466F7F039A = getdvarint("dvar_25852663E024A0E6", 150);
      break;
    case 3:
      delay = getdvarfloat("dvar_031266FE06E688A9", 0);
      duration = getdvarfloat("dvar_48315E1F1BC3A24A", 18);
      _id_8DB63374EC6BC2F9 = getdvarint("dvar_07AD30CECC84CB4D", 300);
      _id_7FB57E466F7F039A = getdvarint("dvar_2A401F3B20B48474", 250);
      break;
    default:
      break;
  }

  wait(delay);
  _id_8A09C0E5FA78A48C(_id_EDA7FDCEC973DC54, duration, _id_8DB63374EC6BC2F9, _id_7FB57E466F7F039A);
}