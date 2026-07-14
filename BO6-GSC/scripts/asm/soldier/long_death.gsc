/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\long_death.gsc
**********************************************/

#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\shared\death;
#using scripts\asm\soldier\death;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace long_death;

function private autoexec function_89fd39636d3897ab() {
  if(!isDefined(level.longdeath)) {
    level.longdeath = spawnStruct();
    settodefault = 1;

    if(isxhashasset(level.gamemodebundle.var_5d5d335f393f7158)) {
      var_5d5d335f393f7158 = getscriptbundle(level.gamemodebundle.var_5d5d335f393f7158);

      if(isxhashasset(var_5d5d335f393f7158.globalsoldiersettings)) {
        settodefault = 0;
        soldiersettings = getscriptbundle(var_5d5d335f393f7158.globalsoldiersettings);
        level.longdeath.var_4cbef231021c8f60 = int(soldiersettings.var_9e69f31fe376d386 ?? 10);
        level.longdeath.var_a92b3af989e96cba = int(soldiersettings.var_61aadc1846a66fa4 ?? 30);
        level.longdeath.var_c2887bfde9ae4f87 = int(utility::function_fe771e2bf31fa2fc(soldiersettings.var_4dba8087dda6b7a5 ?? 15));
        level.longdeath.var_1b45953fc536de95 = int(utility::function_fe771e2bf31fa2fc(soldiersettings.var_d9e98aed5db3a7 ?? 60));
        level.longdeath.var_e56182308abfe1d7 = int(soldiersettings.var_18caf2a8727897c ?? 5);
        level.longdeath.var_eaa3375e73ec7369 = int(soldiersettings.var_8921da0ad4e91026 ?? 12);
        level.longdeath.var_8515ecfe36773c38 = int(utility::function_fe771e2bf31fa2fc(soldiersettings.var_86e332d76b54ddd3 ?? 5));
        level.longdeath.var_d4d322d0c2ebf496 = int(utility::function_fe771e2bf31fa2fc(soldiersettings.var_89b0aea0dbef6cf1 ?? 25));
        level.longdeath.var_9eaa0b8c498e7d14 = int(utility::function_fe771e2bf31fa2fc(soldiersettings.var_5c61b029dd4785aa ?? 7));
        level.longdeath.var_923c0c57fad61d5e = int(utility::function_fe771e2bf31fa2fc(soldiersettings.var_2a1949ec284b10c4 ?? 13));
      }
    }

    if(settodefault) {
      level.longdeath.var_4cbef231021c8f60 = 10;
      level.longdeath.var_a92b3af989e96cba = 30;
      level.longdeath.var_c2887bfde9ae4f87 = int(utility::function_fe771e2bf31fa2fc(15));
      level.longdeath.var_1b45953fc536de95 = int(utility::function_fe771e2bf31fa2fc(60));
      level.longdeath.var_e56182308abfe1d7 = 5;
      level.longdeath.var_eaa3375e73ec7369 = 12;
      level.longdeath.var_8515ecfe36773c38 = int(utility::function_fe771e2bf31fa2fc(5));
      level.longdeath.var_d4d322d0c2ebf496 = int(utility::function_fe771e2bf31fa2fc(25));
      level.longdeath.var_9eaa0b8c498e7d14 = int(utility::function_fe771e2bf31fa2fc(7));
      level.longdeath.var_923c0c57fad61d5e = int(utility::function_fe771e2bf31fa2fc(13));
    }
  }
}

function preventpainforashorttime() {
  self endon("~Q\x88\xce?\xc8k\f\xe7'\xd91<x\x15");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.flashbangimmunity = 1;
  self.longdeathstarting = 1;
  self.doinglongdeath = 1;
  self notify("*\xeb\x7f!\xa4\xb9\xe6/\xcf\a");
  self.health = 10000;
  self.threatbias -= 2000;
  function_cf05a804b49d3e27(gettime() + 3000);
  function_88035f6a3f40c396(gettime() + 3000);
  wait 0.75;

  if(self.health > 1) {
    self.health = 1;
  }

  wait 0.05;
  self.longdeathstarting = undefined;
  self.a.mayonlydie = 1;
  wait 1;

  if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 1048576) {
    function_b0f552e92806cf9e(randomintrange(level.longdeath.var_4cbef231021c8f60, level.longdeath.var_a92b3af989e96cba));
    function_cf05a804b49d3e27(gettime() + randomintrange(level.longdeath.var_c2887bfde9ae4f87, level.longdeath.var_1b45953fc536de95));
  } else {
    function_b0f552e92806cf9e(randomintrange(level.longdeath.var_e56182308abfe1d7, level.longdeath.var_eaa3375e73ec7369));
    function_cf05a804b49d3e27(gettime() + randomintrange(level.longdeath.var_8515ecfe36773c38, level.longdeath.var_d4d322d0c2ebf496));
  }

  function_88035f6a3f40c396(gettime() + randomintrange(level.longdeath.var_9eaa0b8c498e7d14, level.longdeath.var_923c0c57fad61d5e));
}

function dyingcrawlbackaim(statename) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xfa\xaa!o\x03\xcf\x19H\x82E\xc2v\x16\x1fx4J\xd9,\x1d\xa3\xad\xfa\xcd");
  self endon("\xfa\xaa!o\x03\xcf\x19H\x82E\xc2v\x16\x1fx4J\xd9,\x1d\xa3\xad\xfa\xcd");

  if(isagent(self)) {
    return;
  }

  aim4 = asm::asm_getxanim(statename, asm::asm_lookupanimfromalias(statename, "=T\x8e\xf3\xa1"));
  aim6 = asm::asm_getxanim(statename, asm::asm_lookupanimfromalias(statename, "P\xee&_\x8d"));
  aim4_knob = asm::asm_getxanim(statename, asm::asm_lookupanimfromalias(statename, "\x89\x92\xf6c\x8az>e|z"));
  aim6_knob = asm::asm_getxanim(statename, asm::asm_lookupanimfromalias(statename, ">\x8a\x1f[Y_\x82\xdb\xdc\xb0"));
  wait 0.05;
  self aisetanimlimited(aim4, 1, 0);
  self aisetanimlimited(aim6, 1, 0);
  prevyaw = 0;

  while(true) {
    aimyaw = utility_common::getyawtoenemy();
    diff = angleclamp180(aimyaw - prevyaw);

    if(abs(diff) > 3) {
      diff = utility::sign(diff) * 3;
    }

    aimyaw = angleclamp180(prevyaw + diff);

    if(aimyaw < 0) {
      if(aimyaw < -45) {
        aimyaw = -45;
      }

      weight = aimyaw / -45;
      self setanim(aim4_knob, weight, 0.05);
      self setanim(aim6_knob, 0, 0.05);
    } else {
      if(aimyaw > 45) {
        aimyaw = 45;
      }

      weight = aimyaw / 45;
      self setanim(aim6_knob, weight, 0.05);
      self setanim(aim4_knob, 0, 0.05);
    }

    prevyaw = aimyaw;
    wait 0.05;
  }
}

function setupaiming(statename) {
  clearknob = asm::asm_lookupanimfromalias(statename, "\xed\x1e\xc2\x88\x84G\x12\x85\xcdA");
  self aiclearanim(clearknob, 0.2);

  if(isDefined(self.a.bdyingbackidleandshootsetup)) {
    return;
  }

  thread dyingcrawlbackaim(statename);
  self.a.bdyingbackidleandshootsetup = 1;
}

function dodyingcrawlbloodsmear() {
  self endon("\x1e\xfd\xd1\xa2\a");
  origintag = "&\x9b\xc1\xd1(A\x8c\x98f\x80\xf6\xfd";
  angletag = "\xec\xbfK|\au\xcd\xc2\x19<";
  fx_rate = 6;
  fx = level._effect["\xef\xeap\x8b\xef\x19\xe0=s\xb7\x0f~\x86\xc3\xc0t\xb5M&\x18@&\xe3\t\xbe\xa3"];

  if(isDefined(self.a.crawl_fx_rate)) {
    fx_rate = self.a.crawl_fx_rate;
  }

  if(isDefined(self.a.crawl_fx)) {
    fx = level._effect[self.a.crawl_fx];
  }

  while(fx_rate) {
    org = self gettagorigin(origintag);
    angles = self gettagangles(angletag);
    forward = anglestoright(angles);
    up = anglesToForward((270, 0, 0));
    playFX(fx, org, up, forward);
    wait fx_rate;
  }
}

function iscrawldeltaallowed(thexanim) {
  if(self.force_num_crawls > 0) {
    return 1;
  }

  return isanimdeltaallowed(thexanim);
}

function startdyingcrawlbackaimsoon(statename) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  wait 0.1;

  if(isDefined(self.a.bdyingbackidleandshootsetup)) {
    return;
  }

  thread dyingcrawlbackaim(statename);
  self.a.bdyingbackidleandshootsetup = 1;
}

function handlebackcrawlnotetracks(statename, note, params) {
  return_value = 0;

  if(!isDefined(self.bdoingbloodsmear) && issubstr(note, "\x84\"f\xcb\xa9-\xfe\xe1")) {
    thread dodyingcrawlbloodsmear();
  } else if(note == "3\xa5\x93V\xf5spNa\xe5") {
    if(!utility_common::canseeenemy()) {
      return true;
    }

    if(!self function_2a43abf87622cf77()) {
      return true;
    }

    utility_common::shootenemywrapper();
    return true;
  } else if(note == "\x16\x02[\xe1\x9b\x87\xf3\x85\xac\xff0L\xcd") {
    thread startdyingcrawlbackaimsoon(statename);
    return false;
  } else if(note == "\xcciN\xca") {
    utility_common::shootenemywrapper();
    return true;
  } else if(note == "f\x97\xb9`\xd1~\x80(\xca") {
    return true;
  }

  return false;
}

function playdyingcrawl(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  if(self.force_num_crawls > 0) {
    numcrawls = self.force_num_crawls;
  } else {
    numcrawls = randomintrange(1, 5);
  }

  animid = asm::asm_getanim(asmname, statename);
  xanim = asm::asm_getxanim(statename, animid);
  assert(animhasnotetrack(xanim, "<dev string:x24>"), "<dev string:x31>" + getxhashsourcename(getanimname(xanim)) + "<dev string:x3a>");
  self aisetanim(statename, animid);
  asm::asm_playfacialanim(asmname, statename, xanim);

  for(i = 0; i < numcrawls; i++) {
    if(!iscrawldeltaallowed(xanim)) {
      break;
    }

    if(isDefined(self.custom_crawl_sound)) {
      self playSound(self.custom_crawl_sound);
    }

    while(true) {
      endnote = asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));

      if(endnote == "f\x97\xb9`\xd1~\x80(\xca") {
        break;
      }
    }
  }

  asm::asm_fireevent(asmname, "[\x1b$\xab2\xc9\xff\xc7\r\xc3\xf0\xd5\x8f[X{");
}

function playdyingcrawlback(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  if(isDefined(self.enemy)) {
    utility::lookatentity(self.enemy);
  }

  if(self.force_num_crawls > 0) {
    numcrawls = self.force_num_crawls;
  } else {
    numcrawls = randomintrange(1, 5);
  }

  setupaiming(statename);
  crawlanim = asm::asm_getanim(asmname, statename);
  crawlxanim = asm::asm_getxanim(statename, crawlanim);
  assert(animhasnotetrack(crawlxanim, "<dev string:x24>"));
  asm::asm_playfacialanim(asmname, statename, crawlxanim);
  self aisetanim(statename, crawlanim);

  for(i = 0; i < numcrawls; i++) {
    if(!iscrawldeltaallowed(crawlxanim)) {
      break;
    }

    while(true) {
      endnote = asm::asm_donotetrackswithinterceptor(asmname, statename, &handlebackcrawlnotetracks);

      if(endnote == "8\xdb\x90") {
        break;
      }
    }
  }

  if(!istrue(self.var_e42ef3393a0ccb72)) {
    self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);
  }

  asm::asm_fireevent(asmname, "\x19yK\xcd\xce\xafL\xb0\xd8\xb6\xfa\xb19\xb0w\xc6\xd7\xc8\xbd\x9b\xca");
}

function playcrawlflipover(asmname, statename, params) {
  utility::lookatentity();
  asm::asm_playanimstatewithnotetrackinterceptor(asmname, statename, &handlebackcrawlnotetracks);
}

function playcrawlingpaintransition(asmname, statename, params) {
  setearlyfinishtime();

  if(istrue(self.forcelongdeathskipintroanim)) {
    if(!asm::asm_eventfired(asmname, "8\xdb\x90")) {
      asm::asm_fireevent(asmname, "8\xdb\x90");
    }

    return;
  }

  thread preventpainforashorttime();
  utility::lookatentity();
  asm::asm_playanimstatewithnotetrackinterceptor(asmname, statename, &handlebackcrawlnotetracks);
}

function setearlyfinishtime() {
  if(!isDefined(self.asm.longdeathanims)) {
    self.asm.longdeathanims = spawnStruct();
  }

  self.longdeathanims_earlyfinishtime = gettime() + 2000;
}

function playdyingbackshoot(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  setupaiming(statename);

  while(true) {
    animid = asm::asm_getanim(asmname, statename);
    xanim = asm::asm_getxanim(statename, animid);
    asm::asm_playfacialanim(asmname, statename, xanim);
    self aisetanim(statename, animid);
    endnote = asm::asm_donotetrackswithinterceptor(asmname, statename, &handlebackcrawlnotetracks);

    if(endnote == "8\xdb\x90") {
      if(!asm::asm_eventfired(asmname, "8\xdb\x90")) {
        asm::asm_fireevent(asmname, "8\xdb\x90");
      }
    }
  }
}

function choosedyingbackidle(asmname, statename, params) {
  if(istrue(self.longdeathnoncombat)) {
    return asm::asm_lookupanimfromalias(statename, "\xbd\xc3\x19\x1f\x83^\xa0\xba\x18");
  }

  return asm::asm_chooseanim(asmname, statename, params);
}

function playdyingbackidle(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  if(!istrue(self.longdeathnoncombat)) {
    self.nextlongdeathshoottime = gettime() + randomintrange(500, 1000);
    setupaiming(statename);
  }

  prevanim = undefined;

  while(true) {
    animid = asm::asm_getanim(asmname, statename);
    xanim = asm::asm_getxanim(statename, animid);

    if(!isDefined(prevanim) || animid != prevanim) {
      self aisetanim(statename, animid);
      prevanim = animid;
    }

    asm::asm_playfacialanim(asmname, statename, xanim);
    prevanim = animid;
    asm::asm_donotetrackssingleloop(asmname, statename, xanim, asm::asm_getnotehandler(asmname, statename));
  }
}

function playstumblingpaintransition(asmname, statename, params) {
  thread preventpainforashorttime();
  setearlyfinishtime();
  utility::lookatentity();
  asm::asm_playanimstate(asmname, statename);
}

function playstumblingwander(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  animid = asm::asm_getanim(asmname, statename);
  collapsestatename = "\x90(HG\xdd}\xf3\xdc\x8aC\x9d\xcdg\x8ca\x10p\x18\x84'E\x85\x90K\x90\x93\x15}o";
  collapseanimid = asm::asm_getanim(asmname, collapsestatename);
  collapsexanim = asm::asm_getxanim(collapsestatename, collapseanimid);
  assert(isDefined(animid));
  xanim = asm::asm_getxanim(statename, animid);

  if(!animhasnotetrack(xanim, "f\x97\xb9`\xd1~\x80(\xca")) {
    asm::asm_fireevent(asmname, "\x7f\xa3\x1a\xfd\xc7Y\x96\x92`\x7f\xbf\xe6\v\xcfb\xdb");
    return;
  }

  collapsedelta = getmovedelta(collapsexanim);

  if(isDefined(self.var_4c88ec7893c971be) && self.var_4c88ec7893c971be > 0) {
    var_92ecd5832cd46743 = self.var_4c88ec7893c971be;
  } else {
    var_92ecd5832cd46743 = randomintrange(1, 3);
  }

  self aisetanim(statename, animid);
  asm::asm_playfacialanim(asmname, statename, xanim);

  while(var_92ecd5832cd46743 > 0) {
    endpos = self localtoworldcoords(collapsedelta);

    if(!self maymovetopoint(endpos)) {
      break;
    }

    while(true) {
      endnote = asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));

      if(endnote == "f\x97\xb9`\xd1~\x80(\xca") {
        break;
      }
    }

    var_92ecd5832cd46743--;
  }

  asm::asm_fireevent(asmname, "\x7f\xa3\x1a\xfd\xc7Y\x96\x92`\x7f\xbf\xe6\v\xcfb\xdb");
}

function hasbeenhitwithemp(asmname, statename, tostatename, params) {
  return istrue(self.isempd);
}

function shoulddodyingcrawl(asmname, statename, tostatename, params) {
  if(self.forcelongdeath == 4) {
    return true;
  }

  if(self.currentpose == "GX\xa9]\x82") {
    return true;
  }

  if(self.a.movement == "\x04M\xed\xab") {
    if(randomint(100) <= 20) {
      return true;
    } else if(abs(self.damageyaw) > 90) {
      return true;
    }
  } else if(abs(self getmotionangle()) > 90) {
    return true;
  }

  if(self.currentpose != "GX\xa9]\x82") {
    crawlanim = asm::asm_getanim(asmname, tostatename);
    crawlxanim = asm::asm_getxanim(tostatename, crawlanim);

    if(!iscrawldeltaallowed(crawlxanim)) {
      return false;
    }
  }

  return true;
}

function playlongdeathintro(asmname, statename, params) {
  thread preventpainforashorttime();

  if(self.var_e42ef3393a0ccb72) {
    self.var_a23633aeea64d6fa = self.var_e42ef3393a0ccb72;
    self.var_e42ef3393a0ccb72 = 0;
  }

  death::stop_sounds();

  if(istrue(self.forcelongdeathskipintroanim)) {
    if(!asm::asm_eventfired(asmname, "8\xdb\x90")) {
      asm::asm_fireevent(asmname, "8\xdb\x90");
    }

    return;
  }

  setearlyfinishtime();
  playlongdeathanim(asmname, statename, 1);
}

function playlongdeathintroterminate(asmname, statename, params) {
  if(istrue(self.var_a23633aeea64d6fa)) {
    self.var_e42ef3393a0ccb72 = self.var_a23633aeea64d6fa;
    self.var_a23633aeea64d6fa = undefined;
    self.desiredtimeofdeath = gettime() + self.revive_bleedouttime;
  }
}

function playlongdeathmercy(asmname, statename, params) {
  playlongdeathanim(asmname, statename, 0);
}

function playlongdeathidle(asmname, statename, params) {
  if(istrue(self.var_1f275503ffeab32b)) {
    self.var_765cadf58e57dc91 = gettime() + self.var_3696a9468558c0ab;
  }

  if(isDefined(self.var_5a0023ef9fe2f254)) {
    self.var_b6e51d417436d00b = gettime() + self.var_5a0023ef9fe2f254;
  }

  canplayanim = longdeathidlesingleloop(asmname, statename, params);

  if(!canplayanim) {
    self.var_b6e51d417436d00b = gettime();

    if(!asm::asm_eventfired(asmname, "8\xdb\x90")) {
      asm::asm_fireevent(asmname, "8\xdb\x90");
    }
  }
}

function playshootinglongdeathidle(asmname, statename, params) {
  if(!isDefined(self.desiredtimeofdeath)) {
    self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);
  }

  self.nextlongdeathshoottime = gettime() + randomintrange(500, 1000);
  self.timestartwaitingtoshoot = gettime();
  setupaiming(statename);
  canplayanim = longdeathidlesingleloop(asmname, statename, params);

  if(!canplayanim) {
    self.var_b6e51d417436d00b = gettime();

    if(!asm::asm_eventfired(asmname, "8\xdb\x90")) {
      asm::asm_fireevent(asmname, "8\xdb\x90");
    }
  }
}

function longdeathidlesingleloop(asmname, statename, params) {
  return playlongdeathanim(asmname, statename, 0);
}

function playlongdeathgrenade(asmname, statename, params) {
  self.var_aca7480a4735689d = gettime() + int(randomfloatrange(1.5, 1.9) * 1000);
  playlongdeathanim(asmname, statename, 0);
}

function playlongdeathgrenadepull(asmname, statename, params) {
  self.asm.longdeathanims.onfinaldeathcallback = &onfinaldeathdropgrenade;
  playlongdeathanim(asmname, statename, 0);
}

function playlongdeathanim(asmname, statename, var_bb0b6fd89215d2be) {
  deathanim = asm::asm_getanim(asmname, statename);
  deathxanim = asm::asm_getxanim(statename, deathanim);

  if(self.forcelongdeath > 0 || var_bb0b6fd89215d2be || isanimdeltaallowed(deathxanim)) {
    asm::asm_playfacialanim(asmname, statename, deathxanim);
    self aisetanim(statename, deathanim);
    asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
  } else {
    return false;
  }

  return true;
}

function isanimdeltaallowed(thexanim) {
  if(istrue(self.var_e651b9f0d125baec)) {
    return 1;
  }

  var_24967f5d22e9d0fb = 30;
  delta = getmovedelta(thexanim, 0, 1);
  deltalength = length(delta);
  deltadirection = vectorNormalize(delta);
  delta = deltadirection * (deltalength + var_24967f5d22e9d0fb);
  endpoint = self localtoworldcoords(delta);

  if(!checkstairsoffsetpoint(endpoint)) {
    return 0;
  }

  return self maymovetopoint(endpoint);
}

function checkstairsoffsetpoint(endpoint) {
  return self isatvalidlongdeathspot(endpoint);
}

function playlongdeathfinaldeath(asmname, statename, params) {
  if(isDefined(self.asm.longdeathanims.onfinaldeathcallback)) {
    [[self.asm.longdeathanims.onfinaldeathcallback]]();
  }

  death::playdeathanim(asmname, statename, params);
}

function onfinaldeathdropgrenade() {
  if(!isDefined(self.longdeathanims_grenadetag)) {
    return;
  }

  velocity = (0, 0, 30) - anglestoright(self.angles) * 70;

  if(self.longdeathanims_grenadetag == "r\xfc}\xb0\xfc>\xe2~\xf7\x80\xa0\xa2\xd2\xae\x0e}\xf8G") {
    velocity *= -1;
  }

  releasepoint = self gettagorigin(self.longdeathanims_grenadetag);
  releasepointlifted = releasepoint + (0, 0, 20);
  releasepointdropped = releasepoint - (0, 0, 20);
  trace = trace::ray_trace(releasepointlifted, releasepointdropped, self, undefined, 1);

  if(trace["\xda\x16\x81\aw}^i"] < 0.5) {
    releasepoint = trace["\xc1\xbd\xdci\xe8i{7"];
  }

  surfacetype = "\x91\xca\xcc\v\xab\xd8:";

  if(trace["I\xf8\x17\x03\x90\x81\xd3\xf0]e\x11"] != "\r+x5") {
    surfacetype = trace["I\xf8\x17\x03\x90\x81\xd3\xf0]e\x11"];
  }

  playsoundatpos(releasepoint, "\xa5_\x151\xdb$\x9b~\xaa<8\xd7\xfe5\x9b\xd4O\x88\xd1\xc3");
  self detach(getweaponmodel(self.grenadeweapon.basename), self.longdeathanims_grenadetag);
  self magicgrenademanual(releasepoint, velocity, randomfloatrange(2, 3));
}

function longdeathgrenadepullnotetrackhandler(note) {
  if(note == "_\x8fQv\x1b\xfdi\\n\xe8\x15n") {
    self.longdeathanims_grenadetag = "r\xfc}\xb0\xfc>\xe2~\xf7\x80\xa0\xa2\xd2\xae\x0e}\xf8G";
  } else if(note == "\xfe-\xc5[\x81\n\xef\xe7\xed\x0fD`\xcb") {
    self.longdeathanims_grenadetag = "\xb9h\xc0\xfb\v\xf8\xd5\x12\xf9\xbd#\xb0:%.\x1e\xe4\xd75";
  }

  assert(isDefined(self.longdeathanims_grenadetag));
  self attach(getweaponmodel(self.grenadeweapon.basename), self.longdeathanims_grenadetag);
}

function function_6b78b1aee8f74fea(asmname, statename, tostatename, params) {
  if(!isDefined(self.grenadeweapon) || isnullweapon(self.grenadeweapon) || !isDefined(self.grenadeweapon.basename)) {
    return false;
  }

  var_356b723ef1b43d2b = ["\xf8\xd6\xf0\xd7", "T\xd9\xf0\x84\x0f\x8d\xb7\xb3\xbehF!\xc9T\x1e"];

  if(!arraycontains(var_356b723ef1b43d2b, self.grenadeweapon.basename)) {
    return false;
  }

  return true;
}