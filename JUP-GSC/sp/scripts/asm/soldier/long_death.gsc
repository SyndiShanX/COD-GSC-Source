/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\asm\soldier\long_death.gsc
*************************************************/

#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\shared\death;
#using scripts\asm\soldier\death;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace long_death;

function preventpainforashorttime() {
  self endon("kill_long_death");
  self endon("death");
  self.flashbangimmunity = 1;
  self.longdeathstarting = 1;
  self.doinglongdeath = 1;
  self notify("long_death");
  self.health = 10000;
  self.threatbias -= 2000;
  function_58585bbaa46f6bba(gettime() + 3000);
  function_69e0176e97b04cc7(gettime() + 3000);
  wait 0.75;

  if(self.health > 1) {
    self.health = 1;
  }

  wait 0.05;
  self.longdeathstarting = undefined;
  self.a.mayonlydie = 1;
  wait 1;

  if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 1048576) {
    function_9912fb866ada47d7(randomintrange(10, 30));
    function_58585bbaa46f6bba(gettime() + randomintrange(15000, 60000));
  } else {
    function_9912fb866ada47d7(randomintrange(5, 12));
    function_58585bbaa46f6bba(gettime() + randomintrange(5000, 25000));
  }

  function_69e0176e97b04cc7(gettime() + randomintrange(7000, 13000));
}

function dyingcrawlbackaim(statename) {
  self endon("death");
  self notify("end_dying_crawl_back_aim");
  self endon("end_dying_crawl_back_aim");

  if(isagent(self)) {
    return;
  }

  aim4 = asm_getxanim(statename, asm_lookupanimfromalias(statename, "aim_4"));
  aim6 = asm_getxanim(statename, asm_lookupanimfromalias(statename, "aim_6"));
  aim4_knob = asm_getxanim(statename, asm_lookupanimfromalias(statename, "aim_4_knob"));
  aim6_knob = asm_getxanim(statename, asm_lookupanimfromalias(statename, "aim_6_knob"));
  wait 0.05;
  self aisetanimlimited(aim4, 1, 0);
  self aisetanimlimited(aim6, 1, 0);
  prevyaw = 0;

  while(true) {
    aimyaw = getyawtoenemy();
    diff = angleclamp180(aimyaw - prevyaw);

    if(abs(diff) > 3) {
      diff = sign(diff) * 3;
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
  clearknob = asm_lookupanimfromalias(statename, "clear_knob");
  self aiclearanim(clearknob, 0.2);

  if(isDefined(self.a.bdyingbackidleandshootsetup)) {
    return;
  }

  thread dyingcrawlbackaim(statename);
  self.a.bdyingbackidleandshootsetup = 1;
}

function dodyingcrawlbloodsmear() {
  self endon("death");
  origintag = "J_SpineLower";
  angletag = "tag_origin";
  fx_rate = 6;
  fx = level._effect["crawling_death_blood_smear"];

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
  self endon(statename + "_finished");
  wait 0.1;

  if(isDefined(self.a.bdyingbackidleandshootsetup)) {
    return;
  }

  thread dyingcrawlbackaim(statename);
  self.a.bdyingbackidleandshootsetup = 1;
}

function handlebackcrawlnotetracks(statename, note, params) {
  return_value = 0;

  if(!isDefined(self.bdoingbloodsmear) && issubstr(note, "bodyfall")) {
    thread dodyingcrawlbloodsmear();
  } else if(note == "fire_spray") {
    if(!canseeenemy()) {
      return true;
    }

    if(!self function_9ca5b32676727f92()) {
      return true;
    }

    shootenemywrapper();
    return true;
  } else if(note == "pistol_pickup") {
    thread startdyingcrawlbackaimsoon(statename);
    return false;
  } else if(note == "fire") {
    shootenemywrapper();
    return true;
  } else if(note == "code_move") {
    return true;
  }

  return false;
}

function playdyingcrawl(asmname, statename, params) {
  self endon(statename + "_finished");

  if(self.force_num_crawls > 0) {
    numcrawls = self.force_num_crawls;
  } else {
    numcrawls = randomintrange(1, 5);
  }

  animid = asm_getanim(asmname, statename);
  xanim = asm_getxanim(statename, animid);
  assertex(animhasnotetrack(xanim, "code_move"), "Anim " + xanim + " is missing code move notetrack");
  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, xanim);

  for(i = 0; i < numcrawls; i++) {
    if(!iscrawldeltaallowed(xanim)) {
      break;
    }

    if(isDefined(self.custom_crawl_sound)) {
      self playSound(self.custom_crawl_sound);
    }

    while(true) {
      endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));

      if(endnote == "code_move") {
        break;
      }
    }
  }

  asm_fireevent(asmname, "dying_crawl_done");
}

function playdyingcrawlback(asmname, statename, params) {
  self endon(statename + "_finished");

  if(isDefined(self.enemy)) {
    utility::lookatentity(self.enemy);
  }

  if(self.force_num_crawls > 0) {
    numcrawls = self.force_num_crawls;
  } else {
    numcrawls = randomintrange(1, 5);
  }

  setupaiming(statename);
  crawlanim = asm_getanim(asmname, statename);
  crawlxanim = asm_getxanim(statename, crawlanim);
  assert(animhasnotetrack(crawlxanim, "code_move"));
  asm_playfacialanim(asmname, statename, crawlxanim);
  self aisetanim(statename, crawlanim);

  for(i = 0; i < numcrawls; i++) {
    if(!iscrawldeltaallowed(crawlxanim)) {
      break;
    }

    while(true) {
      endnote = asm_donotetrackswithinterceptor(asmname, statename, &handlebackcrawlnotetracks);

      if(endnote == "end") {
        break;
      }
    }
  }

  if(!istrue(self.var_d5e499e7fe2c490b)) {
    self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);
  }

  asm_fireevent(asmname, "dying_back_crawl_done");
}

function playcrawlflipover(asmname, statename, params) {
  utility::lookatentity();
  asm_playanimstatewithnotetrackinterceptor(asmname, statename, &handlebackcrawlnotetracks);
}

function playcrawlingpaintransition(asmname, statename, params) {
  setearlyfinishtime();

  if(istrue(self.forcelongdeathskipintroanim)) {
    if(!asm_eventfired(asmname, "end")) {
      asm_fireevent(asmname, "end");
    }

    return;
  }

  thread preventpainforashorttime();
  utility::lookatentity();
  asm_playanimstatewithnotetrackinterceptor(asmname, statename, &handlebackcrawlnotetracks);
}

function setearlyfinishtime() {
  if(!isDefined(self.asm.longdeathanims)) {
    self.asm.longdeathanims = spawnStruct();
  }

  self.longdeathanims_earlyfinishtime = gettime() + 2000;
}

function playdyingbackshoot(asmname, statename, params) {
  self endon(statename + "_finished");
  setupaiming(statename);

  while(true) {
    animid = asm_getanim(asmname, statename);
    xanim = asm_getxanim(statename, animid);
    asm_playfacialanim(asmname, statename, xanim);
    self aisetanim(statename, animid);
    endnote = asm_donotetrackswithinterceptor(asmname, statename, &handlebackcrawlnotetracks);

    if(endnote == "end") {
      if(!asm_eventfired(asmname, "end")) {
        asm_fireevent(asmname, "end");
      }
    }
  }
}

function choosedyingbackidle(asmname, statename, params) {
  if(istrue(self.longdeathnoncombat)) {
    return asm_lookupanimfromalias(statename, "noncombat");
  }

  return asm_chooseanim(asmname, statename, params);
}

function playdyingbackidle(asmname, statename, params) {
  self endon(statename + "_finished");

  if(!istrue(self.longdeathnoncombat)) {
    self.nextlongdeathshoottime = gettime() + randomintrange(500, 1000);
    setupaiming(statename);
  }

  prevanim = undefined;

  while(true) {
    animid = asm_getanim(asmname, statename);
    xanim = asm_getxanim(statename, animid);

    if(!isDefined(prevanim) || animid != prevanim) {
      self aisetanim(statename, animid);
      prevanim = animid;
    }

    asm_playfacialanim(asmname, statename, xanim);
    prevanim = animid;
    asm_donotetrackssingleloop(asmname, statename, xanim, asm_getnotehandler(asmname, statename));
  }
}

function playstumblingpaintransition(asmname, statename, params) {
  thread preventpainforashorttime();
  setearlyfinishtime();
  utility::lookatentity();
  asm_playanimstate(asmname, statename);
}

function playstumblingwander(asmname, statename, params) {
  self endon(statename + "_finished");
  animid = asm_getanim(asmname, statename);
  collapsestatename = "stumbling_pain_collapse_death";
  collapseanimid = asm_getanim(asmname, collapsestatename);
  collapsexanim = asm_getxanim(collapsestatename, collapseanimid);
  assert(isDefined(animid));
  xanim = asm_getxanim(statename, animid);

  if(!animhasnotetrack(xanim, "code_move")) {
    asm_fireevent(asmname, "pain_wander_done");
    return;
  }

  collapsedelta = getmovedelta(collapsexanim);
  var_9de3e590348729f6 = randomintrange(1, 3);
  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, xanim);

  while(var_9de3e590348729f6 > 0) {
    endpos = self localtoworldcoords(collapsedelta);

    if(!self maymovetopoint(endpos)) {
      break;
    }

    while(true) {
      endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));

      if(endnote == "code_move") {
        break;
      }
    }

    var_9de3e590348729f6--;
  }

  asm_fireevent(asmname, "pain_wander_done");
}

function hasbeenhitwithemp(asmname, statename, tostatename, params) {
  if(isDefined(self.isempd) && self.isempd) {
    return true;
  }

  return false;
}

function shoulddodyingcrawl(asmname, statename, tostatename, params) {
  if(self.forcelongdeath == 4) {
    return true;
  }

  if(self.currentpose == "prone") {
    return true;
  }

  if(self.a.movement == "stop") {
    if(randomint(100) <= 20) {
      return true;
    } else if(abs(self.damageyaw) > 90) {
      return true;
    }
  } else if(abs(self getmotionangle()) > 90) {
    return true;
  }

  if(self.currentpose != "prone") {
    crawlanim = asm_getanim(asmname, tostatename);
    crawlxanim = asm_getxanim(tostatename, crawlanim);

    if(!iscrawldeltaallowed(crawlxanim)) {
      return false;
    }
  }

  return true;
}

function playlongdeathintro(asmname, statename, params) {
  thread preventpainforashorttime();

  if(self.var_d5e499e7fe2c490b) {
    self.var_f4cd424dd91129f3 = self.var_d5e499e7fe2c490b;
    self.var_d5e499e7fe2c490b = 0;
  }

  stop_sounds();

  if(istrue(self.forcelongdeathskipintroanim)) {
    if(!asm_eventfired(asmname, "end")) {
      asm_fireevent(asmname, "end");
    }

    return;
  }

  setearlyfinishtime();
  playlongdeathanim(asmname, statename, 1);
}

function playlongdeathintroterminate(asmname, statename, params) {
  if(istrue(self.var_f4cd424dd91129f3)) {
    self.var_d5e499e7fe2c490b = self.var_f4cd424dd91129f3;
    self.var_f4cd424dd91129f3 = undefined;
    self.desiredtimeofdeath = gettime() + self.revive_bleedouttime;
  }
}

function playlongdeathmercy(asmname, statename, params) {
  playlongdeathanim(asmname, statename, 0);
}

function playlongdeathidle(asmname, statename, params) {
  if(istrue(self.var_78e092f48b4948ba)) {
    self.var_10d76540f58c6628 = gettime() + self.var_961a07dc03c517ee;
  }

  if(isDefined(self.var_a4988b7f91bf1ac1)) {
    self.var_af13941e84bb5b2e = gettime() + self.var_a4988b7f91bf1ac1;
  }

  canplayanim = longdeathidlesingleloop(asmname, statename, params);

  if(!canplayanim) {
    self.var_af13941e84bb5b2e = gettime();

    if(!asm_eventfired(asmname, "end")) {
      asm_fireevent(asmname, "end");
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
    self.var_af13941e84bb5b2e = gettime();

    if(!asm_eventfired(asmname, "end")) {
      asm_fireevent(asmname, "end");
    }
  }
}

function longdeathidlesingleloop(asmname, statename, params) {
  return playlongdeathanim(asmname, statename, 0);
}

function playlongdeathgrenade(asmname, statename, params) {
  self.var_9be065771308fab4 = gettime() + int(randomfloatrange(1.5, 1.9) * 1000);
  playlongdeathanim(asmname, statename, 0);
}

function playlongdeathgrenadepull(asmname, statename, params) {
  self.asm.longdeathanims.onfinaldeathcallback = &onfinaldeathdropgrenade;
  playlongdeathanim(asmname, statename, 0);
}

function playlongdeathanim(asmname, statename, var_9d93fc2c06b1754f) {
  deathanim = asm_getanim(asmname, statename);
  deathxanim = asm_getxanim(statename, deathanim);

  if(self.forcelongdeath > 0 || var_9d93fc2c06b1754f || isanimdeltaallowed(deathxanim)) {
    asm_playfacialanim(asmname, statename, deathxanim);
    self aisetanim(statename, deathanim);
    asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
  } else {
    return false;
  }

  return true;
}

function isanimdeltaallowed(thexanim) {
  if(istrue(self.var_4b6c55151a620061)) {
    return 1;
  }

  var_51e5f0fcb88e95b2 = 30;
  delta = getmovedelta(thexanim, 0, 1);
  deltalength = length(delta);
  deltadirection = vectorNormalize(delta);
  delta = deltadirection * (deltalength + var_51e5f0fcb88e95b2);
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

  playdeathanim(asmname, statename, params);
}

function onfinaldeathdropgrenade() {
  if(!isDefined(self.longdeathanims_grenadetag)) {
    return;
  }

  velocity = (0, 0, 30) - anglestoright(self.angles) * 70;

  if(self.longdeathanims_grenadetag == "tag_accessory_left") {
    velocity *= -1;
  }

  releasepoint = self gettagorigin(self.longdeathanims_grenadetag);
  releasepointlifted = releasepoint + (0, 0, 20);
  releasepointdropped = releasepoint - (0, 0, 20);
  trace = scripts\engine\trace::ray_trace(releasepointlifted, releasepointdropped, self, undefined, 1);

  if(trace["fraction"] < 0.5) {
    releasepoint = trace["position"];
  }

  surfacetype = "default";

  if(trace["surfacetype"] != "none") {
    surfacetype = trace["surfacetype"];
  }

  playsoundatpos(releasepoint, "grenade_bounce_heavy");
  self detach(getweaponmodel(self.grenadeweapon.basename), self.longdeathanims_grenadetag);
  self magicgrenademanual(releasepoint, velocity, randomfloatrange(2, 3));
}

function longdeathgrenadepullnotetrackhandler(note) {
  if(note == "grenade_left") {
    self.longdeathanims_grenadetag = "tag_accessory_left";
  } else if(note == "grenade_right") {
    self.longdeathanims_grenadetag = "tag_accessory_right";
  }

  assert(isDefined(self.longdeathanims_grenadetag));
  self attach(getweaponmodel(self.grenadeweapon.basename), self.longdeathanims_grenadetag);
}

function function_633f7da4f34bba83(asmname, statename, tostatename, params) {
  if(!isDefined(self.grenadeweapon) || isnullweapon(self.grenadeweapon) || !isDefined(self.grenadeweapon.basename)) {
    return false;
  }

  var_f4375b9f3c948e26 = ["frag", "frag_grenade_mp"];

  if(!array_contains(var_f4375b9f3c948e26, self.grenadeweapon.basename)) {
    return false;
  }

  return true;
}