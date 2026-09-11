/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\long_death.gsc
***********************************************/

function preventpainforashorttime() {
  self endon("kill_long_death");
  self endon("death");
  self.flashbangimmunity = 1;
  self.longdeathstarting = 1;
  self.a.doinglongdeath = 1;
  self notify("long_death");
  self.health = 10000;
  self.threatbias -= 2000;
  anim.nextcrawlingpaintime = gettime() + 3000;
  anim.nextcrawlingpaintimefromlegdamage = gettime() + 3000;
  wait 0.75;

  if(self.health > 1) {
    self.health = 1;
  }

  wait 0.05;
  self.longdeathstarting = undefined;
  self.a.mayonlydie = 1;
  wait 1;

  if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 1048576) {
    anim.numdeathsuntilcrawlingpain = randomintrange(10, 30);
    anim.nextcrawlingpaintime = gettime() + randomintrange(15000, 60000);
  } else {
    anim.numdeathsuntilcrawlingpain = randomintrange(5, 12);
    anim.nextcrawlingpaintime = gettime() + randomintrange(5000, 25000);
  }

  anim.nextcrawlingpaintimefromlegdamage = gettime() + randomintrange(7000, 13000);
}

function dyingcrawlbackaim(var_0) {
  self endon("death");
  self notify("end_dying_crawl_back_aim");
  self endon("end_dying_crawl_back_aim");

  if(isagent(self)) {
    return;
  }

  var_1 = scripts\asm\asm::asm_getxanim(var_0, scripts\asm\asm::asm_lookupanimfromalias(var_0, "aim_4"));
  var_2 = scripts\asm\asm::asm_getxanim(var_0, scripts\asm\asm::asm_lookupanimfromalias(var_0, "aim_6"));
  var_3 = scripts\asm\asm::asm_getxanim(var_0, scripts\asm\asm::asm_lookupanimfromalias(var_0, "aim_4_knob"));
  var_4 = scripts\asm\asm::asm_getxanim(var_0, scripts\asm\asm::asm_lookupanimfromalias(var_0, "aim_6_knob"));
  wait 0.05;
  self aisetanimlimited(var_1, 1, 0);
  self aisetanimlimited(var_2, 1, 0);
  var_5 = 0;

  for(;;) {
    var_6 = scripts\anim\utility_common::getyawtoenemy();
    var_7 = angleclamp180(var_6 - var_5);

    if(abs(var_7) > 3) {
      var_7 = scripts\engine\utility::sign(var_7) * 3;
    }

    var_6 = angleclamp180(var_5 + var_7);

    if(var_6 < 0) {
      if(var_6 < -45) {
        var_6 = -45;
      }

      var_8 = var_6 / -45;
      self setanim(var_3, var_8, 0.05);
      self setanim(var_4, 0, 0.05);
    } else {
      if(var_6 > 45) {
        var_6 = 45;
      }

      var_8 = var_6 / 45;
      self setanim(var_4, var_8, 0.05);
      self setanim(var_3, 0, 0.05);
    }

    var_5 = var_6;
    wait 0.05;
  }
}

function setupaiming(var_0) {
  var_1 = scripts\asm\asm::asm_lookupanimfromalias(var_0, "clear_knob");
  self aiclearanim(var_1, 0.2);

  if(isDefined(self.a.bdyingbackidleandshootsetup)) {
    return;
  }

  thread dyingcrawlbackaim(var_0);
  self.a.bdyingbackidleandshootsetup = 1;
}

function isaimedsomewhatatenemy() {
  var_0 = self.enemy getshootatpos();
  var_1 = self getmuzzleangle();
  var_2 = vectortoangles(var_0 - self getmuzzlepos());
  var_3 = scripts\engine\utility::absangleclamp180(var_1[1] - var_2[1]);

  if(var_3 > anim.painyawdifffartolerance) {
    if(distancesquared(self getEye(), var_0) > anim.painyawdiffclosedistsq || var_3 > anim.painyawdiffclosetolerance) {
      return false;
    }
  }

  return scripts\engine\utility::absangleclamp180(var_1[0] - var_2[0]) <= anim.painpitchdifftolerance;
}

function dodyingcrawlbloodsmear() {
  self endon("death");
  var_0 = "J_SpineLower";
  var_1 = "tag_origin";
  var_2 = 6;
  var_3 = level._effect["crawling_death_blood_smear"];

  if(isDefined(self.a.crawl_fx_rate)) {
    var_2 = self.a.crawl_fx_rate;
  }

  jumpiffalse(isDefined(self.a.crawl_fx)) LOC_00000064;
  var_3 = level._effect[self.a.crawl_fx];

  while(var_2) {
    var_4 = self gettagorigin(var_0);
    var_5 = self gettagangles(var_1);
    var_6 = anglestoright(var_5);
    var_7 = anglesToForward((270, 0, 0));
    playFX(var_3, var_4, var_7, var_6);
    wait var_2;
  }
}

function iscrawldeltaallowed(var_0) {
  if(isDefined(self.a.force_num_crawls)) {
    return 1;
  }

  return isanimdeltaallowed(var_0);
}

function isenemyingeneraldirection(var_0) {
  if(isDefined(self.forcelongdeath) && self.forcelongdeath == 4) {
    return true;
  }

  if(!isDefined(self.enemy)) {
    return false;
  }

  var_1 = vectorNormalize(self.enemy getshootatpos() - self getEye());
  return vectordot(var_1, var_0) > 0.707;
}

function longdeathkillme(var_0, var_1, var_2) {
  killme();
}

function killme() {
  if(isDefined(self.last_dmg_player)) {
    self kill(self.origin, self.last_dmg_player);
    return;
  }

  self kill();
}

function startdyingcrawlbackaimsoon(var_0) {
  self endon(var_0 + "_finished");
  wait 0.1;

  if(isDefined(self.a.bdyingbackidleandshootsetup)) {
    return;
  }

  thread dyingcrawlbackaim(var_0);
  self.a.bdyingbackidleandshootsetup = 1;
}

function handlebackcrawlnotetracks(var_0, var_1, var_2) {
  var_3 = 0;

  if(!isDefined(self.bdoingbloodsmear) && issubstr(var_1, "bodyfall")) {
    thread dodyingcrawlbloodsmear();
  } else if(var_1 == "fire_spray") {
    if(!scripts\anim\utility_common::canseeenemy()) {
      return true;
    }

    if(!isaimedsomewhatatenemy()) {
      return true;
    }

    scripts\anim\utility_common::shootenemywrapper();
    return true;
  } else if(var_1 == "pistol_pickup") {
    thread startdyingcrawlbackaimsoon(var_0);
    return false;
  } else if(var_1 == "fire") {
    scripts\anim\utility_common::shootenemywrapper();
    return true;
  } else if(var_1 == "code_move") {
    return true;
  }

  return false;
}

function choosecrawlingpaintransitionanim(var_0, var_1, var_2) {
  if(!isDefined(self.a.crawlingpaintransanim)) {
    var_3 = self.currentpose;

    if(!scripts\asm\asm::asm_hasalias(var_1, var_3)) {
      self.a.crawlingpaintransanim = undefined;
      return self.a.crawlingpaintransanim;
    }

    self.a.crawlingpaintransanim = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  }

  return self.a.crawlingpaintransanim;
}

function choosestumblingpainanim(var_0, var_1, var_2) {
  if(!isDefined(self.a.stumblingpainalias)) {
    var_3 = "leg";
    var_4 = "b";

    if(!self.leghit) {
      var_3 = "gut";

      if(45 < self.damageyaw && self.damageyaw < 135) {
        var_4 = "l";
      } else if(-135 < self.damageyaw && self.damageyaw < -45) {
        var_4 = "r";
      } else if(-45 < self.damageyaw && self.damageyaw < 45) {}
    }

    self.a.stumblingpainalias = var_3 + "_" + var_4;
  }

  var_5 = scripts\asm\asm::asm_getallanimindicesforalias(var_1, self.a.stumblingpainalias);

  if(isarray(var_5)) {
    if(!isDefined(self.a.stumblingpainanimindex)) {
      self.a.stumblingpainanimindex = randomint(var_5.size);
    }

    var_5 = var_5[self.a.stumblingpainanimindex];
  }

  return var_5;
}

function playdyingcrawl(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  if(isDefined(self.a.force_num_crawls)) {
    var_3 = self.a.force_num_crawls;
  } else {
    var_3 = randomintrange(1, 5);
  }

  var_4 = scripts\asm\asm::asm_getanim(var_1, var_2);
  var_5 = scripts\asm\asm::asm_getxanim(var_2, var_4);
  self aisetanim(var_2, var_4);
  scripts\asm\asm::asm_playfacialanim(var_1, var_2, var_5);

  for(var_6 = 0; var_6 < var_3; var_6++) {
    if(!iscrawldeltaallowed(var_5)) {
      break;
    }

    if(isDefined(self.custom_crawl_sound)) {
      self playSound(self.custom_crawl_sound);
    }

    for(;;) {
      var_7 = scripts\asm\asm::asm_donotetracks(var_1, var_2, scripts\asm\asm::asm_getnotehandler(var_1, var_2));

      if(var_7 == "code_move") {
        break;
      }
    }
  }

  scripts\asm\asm::asm_fireevent(var_1, "dying_crawl_done");
}

function playdyingcrawlback(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  if(isDefined(self.enemy)) {
    scripts\common\utility::lookatentity(self.enemy);
  }

  if(isDefined(self.a.force_num_crawls)) {
    var_3 = self.a.force_num_crawls;
  } else {
    var_3 = randomintrange(1, 5);
  }

  setupaiming(var_2);
  var_4 = scripts\asm\asm::asm_getanim(var_1, var_2);
  var_5 = scripts\asm\asm::asm_getxanim(var_2, var_4);
  scripts\asm\asm::asm_playfacialanim(var_1, var_2, var_5);
  self aisetanim(var_2, var_4);

  for(var_6 = 0; var_6 < var_3; var_6++) {
    if(!iscrawldeltaallowed(var_5)) {
      break;
    }

    for(;;) {
      var_7 = scripts\asm\asm::asm_donotetrackswithinterceptor(var_1, var_2, &handlebackcrawlnotetracks);

      if(var_7 == "end") {
        break;
      }
    }
  }

  self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);
  scripts\asm\asm::asm_fireevent(var_1, "dying_back_crawl_done");
}

function playcrawlflipover(var_0, var_1, var_2) {
  scripts\common\utility::lookatentity();
  scripts\asm\asm::asm_playanimstatewithnotetrackinterceptor(var_0, var_1, &handlebackcrawlnotetracks);
}

function playcrawlingpaintransition(var_0, var_1, var_2) {
  setearlyfinishtime();

  if(istrue(self.forcelongdeathskipintroanim)) {
    if(!scripts\asm\asm::asm_eventfired(var_0, "end")) {
      scripts\asm\asm::asm_fireevent(var_0, "end");
    }

    return;
  }

  thread preventpainforashorttime();
  scripts\common\utility::lookatentity();
  scripts\asm\asm::asm_playanimstatewithnotetrackinterceptor(var_0, var_1, &handlebackcrawlnotetracks);
}

function setearlyfinishtime() {
  if(!isDefined(self.asm.longdeathanims)) {
    self.asm.longdeathanims = spawnStruct();
  }

  self.asm.longdeathanims.earlyfinishtime = gettime() + 2000;
}

function playdyingbackshoot(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  setupaiming(var_1);

  for(;;) {
    var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
    var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
    scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
    self aisetanim(var_1, var_3);
    var_5 = scripts\asm\asm::asm_donotetrackswithinterceptor(var_0, var_1, &handlebackcrawlnotetracks);

    if(var_5 == "end") {
      if(!scripts\asm\asm::asm_eventfired(var_0, "end")) {
        scripts\asm\asm::asm_fireevent(var_0, "end");
      }
    }
  }
}

function choosedyingbackidle(var_0, var_1, var_2) {
  if(istrue(self.longdeathnoncombat)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "noncombat");
  }

  return scripts\asm\asm::asm_chooseanim(var_0, var_1, var_2);
}

function playdyingbackidle(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");

  if(!istrue(self.longdeathnoncombat)) {
    self.a.nextlongdeathshoottime = gettime() + randomintrange(500, 1000);
    setupaiming(var_1);
  }

  var_3 = undefined;

  for(;;) {
    var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);
    var_5 = scripts\asm\asm::asm_getxanim(var_1, var_4);

    if(!isDefined(var_3) || var_4 != var_3) {
      self aisetanim(var_1, var_4);
      var_3 = var_4;
    }

    scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_5);
    var_3 = var_4;
    scripts\asm\asm::asm_donotetrackssingleloop(var_0, var_1, var_5, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  }
}

function playstumblingpaintransition(var_0, var_1, var_2) {
  thread preventpainforashorttime();
  setearlyfinishtime();
  scripts\common\utility::lookatentity();
  scripts\asm\asm::asm_playanimstate(var_0, var_1);
}

function playstumblingwander(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = "stumbling_pain_collapse_death";
  var_5 = scripts\asm\asm::asm_getanim(var_0, var_4);
  var_6 = scripts\asm\asm::asm_getxanim(var_4, var_5);
  var_7 = scripts\asm\asm::asm_getxanim(var_1, var_3);

  if(!animhasnotetrack(var_7, "code_move")) {
    scripts\asm\asm::asm_fireevent(var_0, "pain_wander_done");
    return;
  }

  var_8 = getmovedelta(var_6);
  var_9 = randomintrange(1, 3);
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_7);

  while(var_9 > 0) {
    var_10 = self localtoworldcoords(var_8);

    if(!self maymovetopoint(var_10)) {
      break;
    }

    for(;;) {
      var_11 = scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));

      if(var_11 == "code_move") {
        break;
      }
    }

    var_9--;
  }

  scripts\asm\asm::asm_fireevent(var_0, "pain_wander_done");
}

function hasbeenhitwithemp(var_0, var_1, var_2, var_3) {
  if(isDefined(self.isempd) && self.isempd) {
    return true;
  }

  return false;
}

function shouldflipover(var_0, var_1, var_2, var_3) {
  if(isDefined(self.isempd) && self.isempd) {
    return false;
  }

  if(isenemyingeneraldirection(anglesToForward(self.angles) * -1) && self.bulletsinclip > 0) {
    return true;
  }

  return false;
}

function shouldendlongdeath(var_0, var_1, var_2, var_3) {
  if(shouldfinishlongdeath()) {
    return true;
  }

  if(istrue(self.longdeathnoncombat)) {
    return false;
  }

  if(!isenemyingeneraldirection(anglesToForward(self.angles)) || self.bulletsinclip <= 0) {
    return true;
  }

  if(isDefined(self.isempd) && self.isempd) {
    return true;
  }

  if(isDefined(self.desiredtimeofdeath)) {
    return (gettime() > self.desiredtimeofdeath);
  }

  return false;
}

function shouldattemptcrawlingpain(var_0, var_1, var_2, var_3) {
  scripts\asm\asm::asm_getanim(var_0, var_2);

  if(!isDefined(self.a.crawlingpaintransanim)) {
    return false;
  }

  var_4 = scripts\asm\asm::asm_getxanim(var_2, self.a.crawlingpaintransanim);

  if(!iscrawldeltaallowed(var_4)) {
    self.a.crawlingpaintransanim = undefined;
    return false;
  }

  return true;
}

function isonornearstairs() {
  if(self.stairsstate != "none") {
    return true;
  }

  return false;
}

function shoulddoanylongdeath(var_0, var_1, var_2, var_3) {
  setdvarifuninitialized("scr_forceLongDeath", 0);

  if(self.a.disablelongdeath || self.diequietly || self.damageshield || isDefined(self.deathanim)) {
    return false;
  }

  if(isonornearstairs()) {
    return false;
  }

  if(isDefined(self.a.onback)) {
    return false;
  }

  if(isDefined(self.deathfunction)) {
    return false;
  }

  if(scripts\anim\utility_common::isusingsidearm() && !istrue(self.longdeathwithsidearm)) {
    return false;
  }

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "gun", "right_hand", "left_hand")) {
    return false;
  }

  self.leghit = scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot");
  var_4 = getdvarint("scr_forceLongDeath", 0);

  if(var_4 != 0) {
    self.forcelongdeath = var_4;
  }

  if(isDefined(self.forcelongdeath) && self.forcelongdeath >= 1) {
    return true;
  }

  if(!self isatvalidlongdeathspot()) {
    return false;
  }

  if(self.leghit && self.health < self.maxhealth * 0.4) {
    if(gettime() < anim.nextcrawlingpaintimefromlegdamage) {
      return false;
    }
  } else {
    if(anim.numdeathsuntilcrawlingpain > 0) {
      return false;
    }

    if(gettime() < anim.nextcrawlingpaintime) {
      return false;
    }
  }

  foreach(var_6 in level.players) {
    if(distancesquared(self.origin, var_6.origin) < 30625) {
      return false;
    }
  }

  return true;
}

function shouldattemptstumblingpain(var_0) {
  if(self.currentpose != "stand") {
    return false;
  }

  var_1 = 20;

  if(isDefined(self.forcelongdeath)) {
    switch (self.forcelongdeath) {
      case 2:
        var_1 = 100;
        break;
      case 4:
      case 3:
        return false;
    }
  }

  if(randomint(100) > var_1) {
    return false;
  }

  var_2 = 0;

  if(!var_0) {
    var_2 = scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower");

    if(!var_2) {
      return false;
    }
  }

  var_3 = 0;
  var_4 = "leg";
  var_5 = "b";

  if(var_0) {
    var_3 = 200;
  } else {
    var_4 = "gut";
    var_3 = 128;

    if(45 < self.damageyaw && self.damageyaw < 135) {
      var_5 = "l";
    } else if(-135 < self.damageyaw && self.damageyaw < -45) {
      var_5 = "r";
    } else if(-45 < self.damageyaw && self.damageyaw < 45) {
      return false;
    }
  }

  switch (var_5) {
    case "b":
      var_6 = anglesToForward(self.angles);
      var_7 = self.origin - var_6 * var_3;
      break;
    case "l":
      var_8 = anglestoright(self.angles);
      var_7 = self.origin - var_8 * var_4;
      break;
    case "r":
      var_8 = anglestoright(self.angles);
      var_7 = self.origin + var_8 * var_5;
      break;
    default:
      return false;
  }

  if(!isDefined(self.forcelongdeath) || self.forcelongdeath != 2) {
    if(!self maymovetopoint(var_7)) {
      return false;
    }
  }

  return true;
}

function shoulddostumblinglongdeath(var_0, var_1, var_2, var_3) {
  if(isDefined(self.forcelongdeath) && self.forcelongdeath == 2) {
    return true;
  }

  if(usingnewlongdeaths()) {
    return false;
  }

  if(shouldattemptstumblingpain(self.leghit)) {
    return true;
  }

  return false;
}

function shoulddocrawlingbacklongdeath(var_0, var_1, var_2, var_3) {
  if(isDefined(self.forcelongdeath) && self.forcelongdeath == 4) {
    return true;
  }

  if(usingnewlongdeaths()) {
    return false;
  }

  if(!isenemyingeneraldirection(anglesToForward(self.angles)) || self.bulletsinclip <= 0) {
    return false;
  }

  if(shouldattemptcrawlingpain(var_0, var_1, var_2, var_3)) {
    return true;
  }

  return false;
}

function shoulddocrawlingonbellylongdeath(var_0, var_1, var_2, var_3) {
  if(isDefined(self.forcelongdeath) && (self.forcelongdeath == 2 || self.forcelongdeath == 3)) {
    return true;
  }

  if(self.currentpose == "prone") {
    return false;
  }

  if(usingnewlongdeaths()) {
    return false;
  }

  if(self.a.movement == "stop") {
    if(randomint(100) > 20) {
      return false;
    } else if(abs(self.damageyaw) > 90) {
      return false;
    }
  } else if(abs(self getmotionangle()) > 90) {
    return false;
  }

  return shouldattemptcrawlingpain(var_0, var_1, var_2, var_3);
}

function shoulddodyingbackcrawl(var_0, var_1, var_2, var_3) {
  return !istrue(self.skipdyingbackcrawl);
}

function shoulddodyingcrawl(var_0, var_1, var_2, var_3) {
  if(isDefined(self.forcelongdeath) && self.forcelongdeath == 4) {
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
    var_4 = scripts\asm\asm::asm_getanim(var_0, var_2);
    var_5 = scripts\asm\asm::asm_getxanim(var_2, var_4);

    if(!iscrawldeltaallowed(var_5)) {
      return false;
    }
  }

  return true;
}

function longdeathshouldshoot(var_0, var_1, var_2, var_3) {
  if(istrue(self.longdeathnoncombat)) {
    return false;
  }

  if(isDefined(self.a.nextlongdeathshoottime)) {
    if(gettime() < self.a.nextlongdeathshoottime) {
      return false;
    }
  }

  if(!isDefined(self.enemy)) {
    return false;
  }

  if(!scripts\anim\utility_common::canseeenemy()) {
    return false;
  }

  if(!isaimedsomewhatatenemy()) {
    return false;
  }

  return true;
}

function doesstumblingpainstatehavealias(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm::asm_hasalias(var_2, self.a.stumblingpainalias)) {
    return false;
  }

  var_4 = scripts\asm\asm::asm_getallanimindicesforalias(var_2, self.a.stumblingpainalias);

  if(!isDefined(var_4) || !isarray(var_4)) {
    return false;
  }

  if(var_4.size <= self.a.stumblingpainanimindex) {
    return false;
  }

  return true;
}

function getforcedlongdeathalias() {
  if(isDefined(self.forcelongdeath)) {
    switch (self.forcelongdeath) {
      case 5:
        return "cover_crouch";
      case 6:
        initlongdeathgrenadepull();
        return "cover_crouch";
      case 7:
        return "cover_stand";
      case 8:
        initlongdeathgrenadepull();
        return "cover_stand";
      case 9:
        return "cover_left_crouch";
      case 10:
        initlongdeathgrenadepull();
        return "cover_left_crouch";
      case 11:
        return "cover_left_stand";
      case 12:
        initlongdeathgrenadepull();
        return "cover_left_stand";
      case 13:
        return "cover_right_crouch";
      case 14:
        initlongdeathgrenadepull();
        return "cover_right_crouch";
      case 15:
        return "cover_right_stand";
      case 16:
        initlongdeathgrenadepull();
        return "cover_right_stand";
      case 17:
        return "exposed_front";
      case 18:
        return "exposed_back";
      case 19:
        return "exposed_left";
      case 20:
        return "exposed_right";
      case 21:
        return "exposed_crouch_crawl_back";
      case 22:
        return "exposed_crouch_crawl_back";
      case 23:
        return "exposed_crouch_crawl_belly";
      case 24:
        self.asm.longdeathanims.mercytransitionenabled = 1;
        self.asm.longdeathanims.bellycrawl = 1;
        return "exposed_crouch_crawl_belly";
      case 25:
        return "exposed_crouch_crawl_left";
      case 26:
        return "exposed_crouch_crawl_left";
      case 27:
        return "exposed_crouch_crawl_right";
      case 28:
        return "exposed_crouch_crawl_right";
      case 29:
        return "exposed_stand_crawl_back";
      case 30:
        return "exposed_stand_crawl_back";
      case 31:
        return "exposed_stand_crawl_belly";
      case 32:
        self.asm.longdeathanims.mercytransitionenabled = 1;
        self.asm.longdeathanims.bellycrawl = 1;
        return "exposed_stand_crawl_belly";
      case 33:
        return "exposed_stand_crawl_left";
      case 34:
        return "exposed_stand_crawl_left";
      case 35:
        return "exposed_stand_crawl_right";
      case 36:
        return "exposed_stand_crawl_right";
      case 37:
        self.asm.longdeathanims.shootenabled = 1;
        return "exposed_stand_crawl_shoot";
      case 38:
        self.asm.longdeathanims.shootenabled = 1;
        return "exposed_crouch_crawl_shoot";
      default:
        return "exposed_front";
    }

    return;
  }
}

function shoulddoforcedmercy() {
  switch (self.forcelongdeath) {
    case 36:
    case 34:
    case 32:
    case 30:
    case 28:
    case 26:
    case 24:
    case 22:
      return 1;
    default:
      return 0;
  }
}

function isforcingspecificlongdeath() {
  return isDefined(self.forcelongdeath) && self.forcelongdeath > 1;
}

function shoulddomercy(var_0, var_1, var_2, var_3) {
  if(!istrue(self.asm.longdeathanims.mercyenabled)) {
    return 0;
  }

  if(isforcingspecificlongdeath()) {
    return shoulddoforcedmercy();
  }

  var_4 = anglesToForward(self.angles);

  foreach(var_6 in level.players) {
    var_7 = distancesquared(self.origin, var_6.origin);

    if(distancesquared(self.origin, var_6.origin) > 90000) {
      continue;
    }

    var_8 = vectorNormalize(var_6.origin - self.origin);

    if(istrue(self.asm.longdeathanims.bellycrawl)) {
      if(vectordot(var_8, var_4) > -0.707) {
        continue;
      }
    } else if(vectordot(var_8, var_4) < 0.707) {
      continue;
    }

    var_9 = anglesToForward(var_6.angles);

    if(vectordot(var_9, var_8) < -0.707) {
      return 1;
    }
  }

  return 0;
}

function shoulddoshootinglongdeath(var_0, var_1, var_2, var_3) {
  if(istrue(self.asm.longdeathanims.shootforced)) {
    return true;
  }

  if(!istrue(self.asm.longdeathanims.shootenabled)) {
    return false;
  }

  if(istrue(self.longdeathnoncombat)) {
    return false;
  }

  return true;
}

function shoulddomercytransition(var_0, var_1, var_2, var_3) {
  return istrue(self.asm.longdeathanims.mercytransitionenabled);
}

function shoulddofinaldeath(var_0, var_1, var_2, var_3) {
  return gettime() > self.asm.longdeathanims.loopendtime;
}

function longdeathfinal(var_0, var_1, var_2) {
  self.asm.longdeathanims.alias += "_final";
  self.asm.longdeathanims.bledout = 1;
  killme();
}

function playlongdeathintro(var_0, var_1, var_2) {
  thread preventpainforashorttime();

  if(istrue(self.forcelongdeathskipintroanim)) {
    if(!scripts\asm\asm::asm_eventfired(var_0, "end")) {
      scripts\asm\asm::asm_fireevent(var_0, "end");
    }

    return;
  }

  setearlyfinishtime();
  playlongdeathanim(var_0, var_1);
}

function playlongdeathmercy(var_0, var_1, var_2) {
  playlongdeathanim(var_0, var_1);
}

function chooseanimlongdeath(var_0, var_1, var_2) {
  var_3 = self.asm.longdeathanims.alias;

  if(!scripts\asm\asm::asm_hasalias(var_1, var_3)) {
    return undefined;
  }

  var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return var_4;
}

function longdeathmercyfinal(var_0, var_1, var_2) {
  killme();
}

function playlongdeathidle(var_0, var_1, var_2) {
  if(istrue(self.asm.longdeathanims.grenadepullenabled)) {
    self.asm.longdeathanims.grenadepulltime = gettime() + self.asm.longdeathanims.grenadepulltimer;
  }

  if(isDefined(self.asm.longdeathanims.idletimeout)) {
    self.asm.longdeathanims.loopendtime = gettime() + self.asm.longdeathanims.idletimeout;
  }

  var_3 = [[self.asm.longdeathanims.loopfunc]](var_0, var_1, var_2);

  if(!var_3) {
    self.asm.longdeathanims.loopendtime = gettime();

    if(!scripts\asm\asm::asm_eventfired(var_0, "end")) {
      scripts\asm\asm::asm_fireevent(var_0, "end");
      return;
    }

    return;
  }
}

function playshootinglongdeathidle(var_0, var_1, var_2) {
  if(!isDefined(self.desiredtimeofdeath)) {
    self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);
  }

  self.a.nextlongdeathshoottime = gettime() + randomintrange(500, 1000);
  setupaiming(var_1);
  var_3 = [[self.asm.longdeathanims.loopfunc]](var_0, var_1, var_2);

  if(!var_3) {
    self.asm.longdeathanims.loopendtime = gettime();

    if(!scripts\asm\asm::asm_eventfired(var_0, "end")) {
      scripts\asm\asm::asm_fireevent(var_0, "end");
      return;
    }

    return;
  }
}

function longdeathidlesingleloop(var_0, var_1, var_2) {
  return playlongdeathanim(var_0, var_1);
}

function shoulddocrawllongdeath(var_0, var_1, var_2, var_3) {
  if(!usingnewlongdeaths()) {
    return false;
  }

  if(isforcingspecificlongdeath()) {
    return (self.forcelongdeath >= 21);
  }

  if(self.currentpose == "prone") {
    return false;
  } else if(self.currentpose == "crouch") {
    return true;
  }

  var_4 = randomfloat(1);
  return var_4 < 0.6;
}

function shoulddocoverlongdeath(var_0, var_1, var_2, var_3) {
  if(!usingnewlongdeaths()) {
    return false;
  }

  if(isforcingspecificlongdeath()) {
    return (self.forcelongdeath >= 5 && self.forcelongdeath <= 16);
  }

  var_4 = scripts\asm\asm_bb::bb_getcovernode();

  if(!isDefined(var_4)) {
    return false;
  }

  if(!isDefined(self._blackboard.covernode.type)) {
    return false;
  }

  if(isDefined(self._blackboard.coverstate) && self._blackboard.coverstate == "exposed") {
    return false;
  }

  var_5 = scripts\asm\shared\utility::getnodeforwardyaw(var_4);
  var_6 = self.angles[1];
  var_7 = 5;

  if(abs(var_5 - var_6) > var_7) {
    return false;
  }

  return self._blackboard.covernode.type != "Cover Prone";
}

function shoulddoexposedlongdeath(var_0, var_1, var_2, var_3) {
  if(!usingnewlongdeaths()) {
    return false;
  }

  if(self.currentpose == "prone") {
    return false;
  }

  if(isforcingspecificlongdeath()) {
    return (self.forcelongdeath >= 17 && self.forcelongdeath <= 20);
  }

  return true;
}

function choosecrawllongdeathanims(var_0, var_1, var_2) {
  self.asm.longdeathanims = spawnStruct();
  self.asm.longdeathanims.mercyenabled = 1;
  self.asm.longdeathanims.alias = getcrawllongdeathalias();
  self.asm.longdeathanims.idletimeout = 4000;
  self.asm.longdeathanims.loopfunc = &longdeathidlesingleloop;
}

function getcrawllongdeathalias() {
  if(isforcingspecificlongdeath()) {
    return getforcedlongdeathalias();
  }

  var_0 = "exposed";

  if(self.currentpose == "crouch") {
    var_0 += "_crouch";
  } else {
    var_0 += "_stand";
  }

  var_0 += "_crawl";
  var_1 = getdamagedirection();

  switch (var_1) {
    case 1:
      var_0 += "_left";
      break;
    case 0:
      var_0 += "_right";
      break;
    case 3:
      var_0 += "_back";
      break;
    default:
      var_0 = getfrontcrawldeath(var_0);
      break;
  }

  return var_0;
}

function getfrontcrawldeath(var_0) {
  var_1 = randomfloat(1);

  if(var_1 < 0.4) {
    self.asm.longdeathanims.shootenabled = 1;
    self.asm.longdeathanims.mercyenabled = 0;
    var_0 += "_shoot";
  } else {
    self.asm.longdeathanims.mercytransitionenabled = 1;
    self.asm.longdeathanims.bellycrawl = 1;
    var_0 += "_belly";
  }

  return var_0;
}

function choosecoverlongdeathanims(var_0, var_1, var_2) {
  self.asm.longdeathanims = spawnStruct();
  self.asm.longdeathanims.alias = getcoverlongdeathalias();
  self.asm.longdeathanims.idletimeout = 4000;
  self.asm.longdeathanims.ignoreanimdeltacheck = 1;
  self.asm.longdeathanims.loopfunc = &longdeathidlesingleloop;

  if(!isforcingspecificlongdeath()) {
    if(self.grenadeammo <= 0) {
      return;
    }

    if(nullweapon(self.grenadeweapon)) {
      return;
    }

    if(self.grenadeweapon.basename != "frag") {
      return;
    }

    if(randomfloat(1) < 0.5) {
      initlongdeathgrenadepull();
      return;
    }

    return;
  }
}

function initlongdeathgrenadepull() {
  self.asm.longdeathanims.grenadepullenabled = 1;
  self.asm.longdeathanims.grenadepulltimer = randomfloatrange(1.2, 2.5) * 1000;
}

function getcoverlongdeathalias() {
  if(isforcingspecificlongdeath()) {
    return getforcedlongdeathalias();
  }

  var_0 = "cover";

  if(self._blackboard.covernode.type == "Cover Right") {
    var_0 += "_right";
  } else if(self._blackboard.covernode.type == "Cover Left") {
    var_0 += "_left";
  }

  if(self.currentpose == "crouch") {
    var_0 += "_crouch";
  } else {
    var_0 += "_stand";
  }

  return var_0;
}

function chooseexposedlongdeathanims(var_0, var_1, var_2) {
  self.asm.longdeathanims = spawnStruct();
  self.asm.longdeathanims.alias = getexposedlongdeathalias();
  self.asm.longdeathanims.idletimeout = 4000;
  self.asm.longdeathanims.loopfunc = &longdeathidlesingleloop;

  if(self.asm.longdeathanims.alias == "exposed_front") {
    self.asm.longdeathanims.longdeathdirectionalfunc = &getdamagedirectionsuffix;
    return;
  }
}

function getdamagedirection() {
  var_0 = abs(self.damageyaw);

  if(var_0 > 135) {
    return 2;
  } else if(var_0 < 45) {
    return 3;
  } else if(self.damageyaw < 0) {
    return 0;
  }

  return 1;
}

function getdamagedirectionsuffix() {
  if(!istrue(self.asm.longdeathanims.bledout)) {
    var_0 = getdamagedirection();

    switch (var_0) {
      case 1:
        return "_l";
      case 0:
        return "_r";
      case 3:
        return "_f";
      default:
        return "_b";
    }
  }

  return "";
}

function getexposedlongdeathalias() {
  if(isforcingspecificlongdeath()) {
    return getforcedlongdeathalias();
  }

  var_0 = getdamagedirection();

  switch (var_0) {
    case 1:
      return "exposed_left";
    case 0:
      return "exposed_right";
    case 3:
      return "exposed_back";
    default:
      return "exposed_front";
  }
}

function shouldshootduringlongdeath(var_0, var_1, var_2, var_3) {
  if(isDefined(self.a.nextlongdeathshoottime)) {
    if(gettime() < self.a.nextlongdeathshoottime) {
      return false;
    }
  }

  if(!isDefined(self.enemy)) {
    return false;
  }

  if(!scripts\anim\utility_common::canseeenemy()) {
    return false;
  }

  if(!isaimedsomewhatatenemy()) {
    return false;
  }

  return true;
}

function shoulddolongdeathgrenade(var_0, var_1, var_2, var_3) {
  if(isDefined(self.forcelongdeath) && self.forcelongdeath == 5) {
    return true;
  }

  if(!istrue(self.asm.longdeathanims.grenadepullenabled)) {
    return false;
  }

  if(!scripts\asm\asm::asm_hasalias(var_2, self.asm.longdeathanims.alias)) {
    return false;
  }

  return gettime() > self.asm.longdeathanims.grenadepulltime;
}

function shoulddolongdeathgrenadefinal(var_0, var_1, var_2, var_3) {
  return gettime() > self.asm.longdeathanims.grenadedroptimer;
}

function playlongdeathgrenade(var_0, var_1, var_2) {
  self.asm.longdeathanims.grenadedroptimer = gettime() + randomfloatrange(1.5, 1.9) * 1000;
  playlongdeathanim(var_0, var_1);
}

function playlongdeathgrenadepull(var_0, var_1, var_2) {
  self.asm.longdeathanims.onfinaldeathcallback = &onfinaldeathdropgrenade;
  playlongdeathanim(var_0, var_1);
}

function playlongdeathanim(var_0, var_1) {
  var_2 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_3 = scripts\asm\asm::asm_getxanim(var_1, var_2);

  if(isDefined(self.forcelongdeath) || isanimdeltaallowed(var_3)) {
    scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_3);
    self aisetanim(var_1, var_2);
    scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  } else {
    return false;
  }

  return true;
}

function longdeathfinalgrenade(var_0, var_1, var_2) {
  killme();
}

function chooselongdeathdeathanim(var_0, var_1, var_2) {
  if(isDefined(self.asm.longdeathanims.longdeathdirectionalfunc)) {
    self.asm.longdeathanims.alias += [[self.asm.longdeathanims.longdeathdirectionalfunc]]();
  }

  return chooseanimlongdeath(var_0, var_1, var_2);
}

function usingnewlongdeaths() {
  setdvarifuninitialized("scr_ai_new_long_deaths", "1");
  return getDvar("scr_ai_new_long_deaths") != "0";
}

function isanimdeltaallowed(var_0) {
  if(istrue(self.asm.longdeathanims.ignoreanimdeltacheck)) {
    return 1;
  }

  var_1 = 30;
  var_2 = getmovedelta(var_0, 0, 1);
  var_3 = length(var_2);
  var_4 = vectorNormalize(var_2);
  var_2 = var_4 * (var_3 + var_1);
  var_5 = self localtoworldcoords(var_2);

  if(!checkstairsoffsetpoint(var_5)) {
    return 0;
  }

  return self maymovetopoint(var_5);
}

function checkstairsoffsetpoint(var_0) {
  return self isatvalidlongdeathspot(var_0);
}

function canplaychosenlongdeath(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_2, var_3);
  var_5 = scripts\asm\asm::asm_getxanim(var_2, var_4);

  if(!istrue(self.forcelongdeath) && !isanimdeltaallowed(var_5)) {
    self.asm.longdeathanims = undefined;
    return false;
  }

  return true;
}

function playlongdeathfinaldeath(var_0, var_1, var_2) {
  if(isDefined(self.asm.longdeathanims.onfinaldeathcallback)) {
    [[self.asm.longdeathanims.onfinaldeathcallback]]();
  }

  scripts\asm\soldier\death::playdeathanim(var_0, var_1, var_2);
}

function onfinaldeathdropgrenade() {
  if(!isDefined(self.asm.longdeathanims.grenadetag)) {
    return;
  }

  var_0 = (0, 0, 30) - anglestoright(self.angles) * 70;

  if(self.asm.longdeathanims.grenadetag == "tag_accessory_left") {
    var_0 *= -1;
  }

  var_1 = self gettagorigin(self.asm.longdeathanims.grenadetag);
  var_2 = var_1 + (0, 0, 20);
  var_3 = var_1 - (0, 0, 20);
  var_4 = scripts\engine\trace::ray_trace(var_2, var_3, self, undefined, 1);

  if(var_4["fraction"] < 0.5) {
    var_1 = var_4["position"];
  }

  var_5 = "default";

  if(var_4["surfacetype"] != "none") {
    var_5 = var_4["surfacetype"];
  }

  playworldsound("grenade_bounce_heavy", var_1);
  self detach(getweaponmodel("frag"), self.asm.longdeathanims.grenadetag);
  self magicgrenademanual(var_1, var_0, randomfloatrange(2, 3));
}

function shouldfinishlongdeath(var_0, var_1, var_2, var_3) {
  if(istrue(self.burningtodeath)) {
    return true;
  }

  if(isDefined(self.asm.longdeathanims.earlyfinishtime) && gettime() > self.asm.longdeathanims.earlyfinishtime) {
    foreach(var_5 in level.players) {
      if(distancesquared(self.origin, var_5.origin) < 2500) {
        return true;
      }
    }
  }

  if(isDefined(self.desiredtimeofdeath) && gettime() > self.desiredtimeofdeath) {
    return true;
  }

  return false;
}

function longdeathgrenadepullnotetrackhandler(var_0) {
  if(var_0 == "grenade_left") {
    self.asm.longdeathanims.grenadetag = "tag_accessory_left";
  } else if(var_0 == "grenade_right") {
    self.asm.longdeathanims.grenadetag = "tag_accessory_right";
  }

  self attach(getweaponmodel("frag"), self.asm.longdeathanims.grenadetag);
}