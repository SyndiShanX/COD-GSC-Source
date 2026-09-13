/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\long_death.gsc
***********************************************/

preventpainforashorttime() {
  self endon("kill_long_death");
  self endon("death");
  self.flashbangimmunity = 1;
  self.longdeathstarting = 1;
  self.doinglongdeath = 1;
  self notify("long_death");
  self.health = 10000;
  self.threatbias = self.threatbias - 2000;
  _func_58585BBAA46F6BBA(gettime() + 3000);
  _func_69E0176E97B04CC7(gettime() + 3000);
  wait 0.75;

  if(self.health > 1)
    self.health = 1;

  wait 0.05;
  self.longdeathstarting = undefined;
  self.a.mayonlydie = 1;
  wait 1.0;

  if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 1048576) {
    _func_9912FB866ADA47D7(randomintrange(10, 30));
    _func_58585BBAA46F6BBA(gettime() + randomintrange(15000, 60000));
  } else {
    _func_9912FB866ADA47D7(randomintrange(5, 12));
    _func_58585BBAA46F6BBA(gettime() + randomintrange(5000, 25000));
  }

  _func_69E0176E97B04CC7(gettime() + randomintrange(7000, 13000));
}

dyingcrawlbackaim(statename) {
  self endon("death");
  self notify("end_dying_crawl_back_aim");
  self endon("end_dying_crawl_back_aim");

  if(isagent(self)) {
    return;
  }
  _id_91017DFE29604942 = scripts\asm\asm::asm_getxanim(statename, scripts\asm\asm::asm_lookupanimfromalias(statename, "aim_4"));
  _id_91017BFE296044DC = scripts\asm\asm::asm_getxanim(statename, scripts\asm\asm::asm_lookupanimfromalias(statename, "aim_6"));
  _id_1CB7910504A15713 = scripts\asm\asm::asm_getxanim(statename, scripts\asm\asm::asm_lookupanimfromalias(statename, "aim_4_knob"));
  _id_BD00098FD9227F05 = scripts\asm\asm::asm_getxanim(statename, scripts\asm\asm::asm_lookupanimfromalias(statename, "aim_6_knob"));
  wait 0.05;
  self aisetanimlimited(_id_91017DFE29604942, 1, 0);
  self aisetanimlimited(_id_91017BFE296044DC, 1, 0);
  _id_B26B2DC165A4C077 = 0;

  for(;;) {
    _id_DD8DCDCF226AD155 = _id_2B79931B08683E0A::getyawtoenemy();
    _id_4573A8725DD3748E = angleclamp180(_id_DD8DCDCF226AD155 - _id_B26B2DC165A4C077);

    if(abs(_id_4573A8725DD3748E) > 3)
      _id_4573A8725DD3748E = scripts\engine\utility::sign(_id_4573A8725DD3748E) * 3;

    _id_DD8DCDCF226AD155 = angleclamp180(_id_B26B2DC165A4C077 + _id_4573A8725DD3748E);

    if(_id_DD8DCDCF226AD155 < 0) {
      if(_id_DD8DCDCF226AD155 < -45.0)
        _id_DD8DCDCF226AD155 = -45.0;

      weight = _id_DD8DCDCF226AD155 / -45.0;
      self setanim(_id_1CB7910504A15713, weight, 0.05);
      self setanim(_id_BD00098FD9227F05, 0, 0.05);
    } else {
      if(_id_DD8DCDCF226AD155 > 45.0)
        _id_DD8DCDCF226AD155 = 45.0;

      weight = _id_DD8DCDCF226AD155 / 45.0;
      self setanim(_id_BD00098FD9227F05, weight, 0.05);
      self setanim(_id_1CB7910504A15713, 0, 0.05);
    }

    _id_B26B2DC165A4C077 = _id_DD8DCDCF226AD155;
    wait 0.05;
  }
}

setupaiming(statename) {
  _id_4D85574313BC89DA = scripts\asm\asm::asm_lookupanimfromalias(statename, "clear_knob");
  self aiclearanim(_id_4D85574313BC89DA, 0.2);

  if(isDefined(self.a.bdyingbackidleandshootsetup)) {
    return;
  }
  thread dyingcrawlbackaim(statename);
  self.a.bdyingbackidleandshootsetup = 1;
}

dodyingcrawlbloodsmear() {
  self endon("death");
  _id_E42C947DBEB4C361 = "J_SpineLower";
  _id_5A737BE8B98F48F4 = "tag_origin";
  _id_7B2D455C047C521A = 6;
  fx = level._effect["crawling_death_blood_smear"];

  if(isDefined(self.a.crawl_fx_rate))
    _id_7B2D455C047C521A = self.a.crawl_fx_rate;

  if(isDefined(self.a.crawl_fx))
    fx = level._effect[self.a.crawl_fx];

  while(_id_7B2D455C047C521A) {
    org = self gettagorigin(_id_E42C947DBEB4C361);
    angles = self gettagangles(_id_5A737BE8B98F48F4);
    forward = anglestoright(angles);
    up = anglesToForward((270, 0, 0));
    playFX(fx, org, up, forward);
    wait(_id_7B2D455C047C521A);
  }
}

iscrawldeltaallowed(_id_509E0922EA1EDE0D) {
  if(self.force_num_crawls > 0)
    return 1;

  return isanimdeltaallowed(_id_509E0922EA1EDE0D);
}

startdyingcrawlbackaimsoon(statename) {
  self endon(statename + "_finished");
  wait 0.1;

  if(isDefined(self.a.bdyingbackidleandshootsetup)) {
    return;
  }
  thread dyingcrawlbackaim(statename);
  self.a.bdyingbackidleandshootsetup = 1;
}

handlebackcrawlnotetracks(statename, _id_A234A65C378F3289, params) {
  _id_748A5B6E1EB008F5 = 0;

  if(!isDefined(self.bdoingbloodsmear) && issubstr(_id_A234A65C378F3289, "bodyfall"))
    thread dodyingcrawlbloodsmear();
  else if(_id_A234A65C378F3289 == "fire_spray") {
    if(!_id_2B79931B08683E0A::canseeenemy())
      return 1;

    if(!self _meth_9CA5B32676727F92())
      return 1;

    _id_2B79931B08683E0A::shootenemywrapper();
    return 1;
  } else if(_id_A234A65C378F3289 == "pistol_pickup") {
    thread startdyingcrawlbackaimsoon(statename);
    return 0;
  } else if(_id_A234A65C378F3289 == "fire") {
    _id_2B79931B08683E0A::shootenemywrapper();
    return 1;
  } else if(_id_A234A65C378F3289 == "code_move")
    return 1;

  return 0;
}

playdyingcrawl(asmname, statename, params) {
  self endon(statename + "_finished");

  if(self.force_num_crawls > 0)
    numcrawls = self.force_num_crawls;
  else
    numcrawls = randomintrange(1, 5);

  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, xanim);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numcrawls; _id_AC0E594AC96AA3A8++) {
    if(!iscrawldeltaallowed(xanim)) {
      break;
    }

    if(isDefined(self.custom_crawl_sound))
      self playSound(self.custom_crawl_sound);

    for(;;) {
      endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));

      if(endnote == "code_move") {
        break;
      }
    }
  }

  scripts\asm\asm::asm_fireevent(asmname, "dying_crawl_done");
}

playdyingcrawlback(asmname, statename, params) {
  self endon(statename + "_finished");

  if(isDefined(self.enemy))
    scripts\common\utility::lookatentity(self.enemy);

  if(self.force_num_crawls > 0)
    numcrawls = self.force_num_crawls;
  else
    numcrawls = randomintrange(1, 5);

  setupaiming(statename);
  _id_B33F88434CD7CDE9 = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_C1F650BA5CB83399 = scripts\asm\asm::asm_getxanim(statename, _id_B33F88434CD7CDE9);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_C1F650BA5CB83399);
  self aisetanim(statename, _id_B33F88434CD7CDE9);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numcrawls; _id_AC0E594AC96AA3A8++) {
    if(!iscrawldeltaallowed(_id_C1F650BA5CB83399)) {
      break;
    }

    for(;;) {
      endnote = scripts\asm\asm::asm_donotetrackswithinterceptor(asmname, statename, ::handlebackcrawlnotetracks);

      if(endnote == "end") {
        break;
      }
    }
  }

  if(!istrue(self._id_D5E499E7FE2C490B))
    self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);

  scripts\asm\asm::asm_fireevent(asmname, "dying_back_crawl_done");
}

playcrawlflipover(asmname, statename, params) {
  scripts\common\utility::lookatentity();
  scripts\asm\asm::asm_playanimstatewithnotetrackinterceptor(asmname, statename, ::handlebackcrawlnotetracks);
}

playcrawlingpaintransition(asmname, statename, params) {
  setearlyfinishtime();

  if(istrue(self.forcelongdeathskipintroanim)) {
    if(!scripts\asm\asm::asm_eventfired(asmname, "end"))
      scripts\asm\asm::asm_fireevent(asmname, "end");

    return;
  }

  thread preventpainforashorttime();
  scripts\common\utility::lookatentity();
  scripts\asm\asm::asm_playanimstatewithnotetrackinterceptor(asmname, statename, ::handlebackcrawlnotetracks);
}

setearlyfinishtime() {
  if(!isDefined(self.asm.longdeathanims))
    self.asm.longdeathanims = spawnStruct();

  self._id_4AD177AB3DDDE8FD = gettime() + 2000;
}

playdyingbackshoot(asmname, statename, params) {
  self endon(statename + "_finished");
  setupaiming(statename);

  for(;;) {
    _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
    xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);
    scripts\asm\asm::asm_playfacialanim(asmname, statename, xanim);
    self aisetanim(statename, _id_2C8936D08F85C5C1);
    endnote = scripts\asm\asm::asm_donotetrackswithinterceptor(asmname, statename, ::handlebackcrawlnotetracks);

    if(endnote == "end") {
      if(!scripts\asm\asm::asm_eventfired(asmname, "end"))
        scripts\asm\asm::asm_fireevent(asmname, "end");
    }
  }
}

choosedyingbackidle(asmname, statename, params) {
  if(istrue(self.longdeathnoncombat))
    return scripts\asm\asm::asm_lookupanimfromalias(statename, "noncombat");

  return scripts\asm\asm::asm_chooseanim(asmname, statename, params);
}

playdyingbackidle(asmname, statename, params) {
  self endon(statename + "_finished");

  if(!istrue(self.longdeathnoncombat)) {
    self.nextlongdeathshoottime = gettime() + randomintrange(500, 1000);
    setupaiming(statename);
  }

  _id_F3716786BF084DD1 = undefined;

  for(;;) {
    _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
    xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);

    if(!isDefined(_id_F3716786BF084DD1) || _id_2C8936D08F85C5C1 != _id_F3716786BF084DD1) {
      self aisetanim(statename, _id_2C8936D08F85C5C1);
      _id_F3716786BF084DD1 = _id_2C8936D08F85C5C1;
    }

    scripts\asm\asm::asm_playfacialanim(asmname, statename, xanim);
    _id_F3716786BF084DD1 = _id_2C8936D08F85C5C1;
    scripts\asm\asm::asm_donotetrackssingleloop(asmname, statename, xanim, scripts\asm\asm::asm_getnotehandler(asmname, statename));
  }
}

playstumblingpaintransition(asmname, statename, params) {
  thread preventpainforashorttime();
  setearlyfinishtime();
  scripts\common\utility::lookatentity();
  scripts\asm\asm::asm_playanimstate(asmname, statename);
}

playstumblingwander(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_9B86C1C6F674531C = "stumbling_pain_collapse_death";
  _id_91BEBEDD6B5E41FE = scripts\asm\asm::asm_getanim(asmname, _id_9B86C1C6F674531C);
  _id_D0304CFB3ABCC42F = scripts\asm\asm::asm_getxanim(_id_9B86C1C6F674531C, _id_91BEBEDD6B5E41FE);
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);

  if(!animhasnotetrack(xanim, "code_move")) {
    scripts\asm\asm::asm_fireevent(asmname, "pain_wander_done");
    return;
  }

  _id_957DD9DB9CC2AD1C = getmovedelta(_id_D0304CFB3ABCC42F);
  _id_9DE3E590348729F6 = randomintrange(1, 3);
  self aisetanim(statename, _id_2C8936D08F85C5C1);
  scripts\asm\asm::asm_playfacialanim(asmname, statename, xanim);

  while(_id_9DE3E590348729F6 > 0) {
    endpos = self localtoworldcoords(_id_957DD9DB9CC2AD1C);

    if(!self maymovetopoint(endpos)) {
      break;
    }

    for(;;) {
      endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));

      if(endnote == "code_move") {
        break;
      }
    }

    _id_9DE3E590348729F6--;
  }

  scripts\asm\asm::asm_fireevent(asmname, "pain_wander_done");
}

hasbeenhitwithemp(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self.isempd) && self.isempd)
    return 1;

  return 0;
}

shoulddodyingcrawl(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(self.forcelongdeath == 4)
    return 1;

  if(self.currentpose == "prone")
    return 1;

  if(self.a.movement == "stop") {
    if(randomint(100) <= 20)
      return 1;
    else if(abs(self.damageyaw) > 90)
      return 1;
  } else if(abs(self getmotionangle()) > 90)
    return 1;

  if(self.currentpose != "prone") {
    _id_B33F88434CD7CDE9 = scripts\asm\asm::asm_getanim(asmname, _id_F2B19B25D457C2A6);
    _id_C1F650BA5CB83399 = scripts\asm\asm::asm_getxanim(_id_F2B19B25D457C2A6, _id_B33F88434CD7CDE9);

    if(!iscrawldeltaallowed(_id_C1F650BA5CB83399))
      return 0;
  }

  return 1;
}

playlongdeathintro(asmname, statename, params) {
  thread preventpainforashorttime();

  if(self._id_D5E499E7FE2C490B) {
    self._id_F4CD424DD91129F3 = self._id_D5E499E7FE2C490B;
    self._id_D5E499E7FE2C490B = 0;
  }

  scripts\asm\soldier\death::stop_sounds();

  if(istrue(self.forcelongdeathskipintroanim)) {
    if(!scripts\asm\asm::asm_eventfired(asmname, "end"))
      scripts\asm\asm::asm_fireevent(asmname, "end");

    return;
  }

  setearlyfinishtime();
  playlongdeathanim(asmname, statename, 1);
}

_id_C19267F99AB2FFE4(asmname, statename, params) {
  if(istrue(self._id_F4CD424DD91129F3)) {
    self._id_D5E499E7FE2C490B = self._id_F4CD424DD91129F3;
    self._id_F4CD424DD91129F3 = undefined;
    self.desiredtimeofdeath = gettime() + self._id_1544C20E168D97C0;
  }
}

playlongdeathmercy(asmname, statename, params) {
  playlongdeathanim(asmname, statename, 0);
}

playlongdeathidle(asmname, statename, params) {
  if(istrue(self._id_78E092F48B4948BA))
    self._id_10D76540F58C6628 = gettime() + self._id_961A07DC03C517EE;

  if(isDefined(self._id_A4988B7F91BF1AC1))
    self._id_AF13941E84BB5B2E = gettime() + self._id_A4988B7F91BF1AC1;

  _id_E5E43F791AE4DCAE = longdeathidlesingleloop(asmname, statename, params);

  if(!_id_E5E43F791AE4DCAE) {
    self._id_AF13941E84BB5B2E = gettime();

    if(!scripts\asm\asm::asm_eventfired(asmname, "end"))
      scripts\asm\asm::asm_fireevent(asmname, "end");
  }
}

playshootinglongdeathidle(asmname, statename, params) {
  if(!isDefined(self.desiredtimeofdeath))
    self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);

  self.nextlongdeathshoottime = gettime() + randomintrange(500, 1000);
  self.timestartwaitingtoshoot = gettime();
  setupaiming(statename);
  _id_E5E43F791AE4DCAE = longdeathidlesingleloop(asmname, statename, params);

  if(!_id_E5E43F791AE4DCAE) {
    self._id_AF13941E84BB5B2E = gettime();

    if(!scripts\asm\asm::asm_eventfired(asmname, "end"))
      scripts\asm\asm::asm_fireevent(asmname, "end");
  }
}

longdeathidlesingleloop(asmname, statename, params) {
  return playlongdeathanim(asmname, statename, 0);
}

playlongdeathgrenade(asmname, statename, params) {
  self._id_9BE065771308FAB4 = gettime() + int(randomfloatrange(1.5, 1.9) * 1000);
  playlongdeathanim(asmname, statename, 0);
}

playlongdeathgrenadepull(asmname, statename, params) {
  self.asm.longdeathanims.onfinaldeathcallback = ::onfinaldeathdropgrenade;
  playlongdeathanim(asmname, statename, 0);
}

playlongdeathanim(asmname, statename, _id_9D93FC2C06B1754F) {
  deathanim = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_60CE35EF4EA0CCAA = scripts\asm\asm::asm_getxanim(statename, deathanim);

  if(self.forcelongdeath > 0 || _id_9D93FC2C06B1754F || isanimdeltaallowed(_id_60CE35EF4EA0CCAA)) {
    scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_60CE35EF4EA0CCAA);
    self aisetanim(statename, deathanim);
    scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
  } else
    return 0;

  return 1;
}

isanimdeltaallowed(_id_509E0922EA1EDE0D) {
  if(istrue(self._id_4B6C55151A620061))
    return 1;

  _id_51E5F0FCB88E95B2 = 30.0;
  _id_3777ECE6A73EADA5 = getmovedelta(_id_509E0922EA1EDE0D, 0, 1);
  _id_35E47A94B2620C35 = length(_id_3777ECE6A73EADA5);
  _id_DFDDBA6C5A8A43AA = vectorNormalize(_id_3777ECE6A73EADA5);
  _id_3777ECE6A73EADA5 = _id_DFDDBA6C5A8A43AA * (_id_35E47A94B2620C35 + _id_51E5F0FCB88E95B2);
  endpoint = self localtoworldcoords(_id_3777ECE6A73EADA5);

  if(!checkstairsoffsetpoint(endpoint))
    return 0;

  return self maymovetopoint(endpoint);
}

checkstairsoffsetpoint(endpoint) {
  return self isatvalidlongdeathspot(endpoint);
}

playlongdeathfinaldeath(asmname, statename, params) {
  if(isDefined(self.asm.longdeathanims.onfinaldeathcallback))
    [[self.asm.longdeathanims.onfinaldeathcallback]]();

  scripts\asm\soldier\death::playdeathanim(asmname, statename, params);
}

onfinaldeathdropgrenade() {
  if(!isDefined(self._id_C17BC31F4EF0A002)) {
    return;
  }
  velocity = (0, 0, 30) - anglestoright(self.angles) * 70;

  if(self._id_C17BC31F4EF0A002 == "tag_accessory_left")
    velocity = velocity * -1;

  _id_6475F779A2C0A2C4 = self gettagorigin(self._id_C17BC31F4EF0A002);
  _id_67136A08E22E5888 = _id_6475F779A2C0A2C4 + (0, 0, 20);
  _id_03C9A8DDA8C5B252 = _id_6475F779A2C0A2C4 - (0, 0, 20);
  trace = scripts\engine\trace::ray_trace(_id_67136A08E22E5888, _id_03C9A8DDA8C5B252, self, undefined, 1);

  if(trace["fraction"] < 0.5)
    _id_6475F779A2C0A2C4 = trace["position"];

  surfacetype = "default";

  if(trace["surfacetype"] != "none")
    surfacetype = trace["surfacetype"];

  playworldsound("grenade_bounce_heavy", _id_6475F779A2C0A2C4);
  self detach(getweaponmodel(self.grenadeweapon.basename), self._id_C17BC31F4EF0A002);
  self magicgrenademanual(_id_6475F779A2C0A2C4, velocity, randomfloatrange(2.0, 3.0));
}

longdeathgrenadepullnotetrackhandler(_id_A234A65C378F3289) {
  if(_id_A234A65C378F3289 == "grenade_left")
    self._id_C17BC31F4EF0A002 = "tag_accessory_left";
  else if(_id_A234A65C378F3289 == "grenade_right")
    self._id_C17BC31F4EF0A002 = "tag_accessory_right";

  self attach(getweaponmodel(self.grenadeweapon.basename), self._id_C17BC31F4EF0A002);
}

_id_633F7DA4F34BBA83(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(!isDefined(self.grenadeweapon) || isnullweapon(self.grenadeweapon) || !isDefined(self.grenadeweapon.basename))
    return 0;

  _id_F4375B9F3C948E26 = ["frag", "frag_grenade_mp"];

  if(!scripts\engine\utility::array_contains(_id_F4375B9F3C948E26, self.grenadeweapon.basename))
    return 0;

  return 1;
}