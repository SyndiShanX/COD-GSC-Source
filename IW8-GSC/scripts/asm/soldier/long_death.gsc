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

function dyingcrawlbackaim(var0) {
  self endon("death");
  self notify("end_dying_crawl_back_aim");
  self endon("end_dying_crawl_back_aim");

  if(isagent(self)) {
    return;
  }

  var1 = scripts\asm\asm::asm_getxanim(var0, scripts\asm\asm::asm_lookupanimfromalias(var0, "aim_4"));
  var2 = scripts\asm\asm::asm_getxanim(var0, scripts\asm\asm::asm_lookupanimfromalias(var0, "aim_6"));
  var3 = scripts\asm\asm::asm_getxanim(var0, scripts\asm\asm::asm_lookupanimfromalias(var0, "aim_4_knob"));
  var4 = scripts\asm\asm::asm_getxanim(var0, scripts\asm\asm::asm_lookupanimfromalias(var0, "aim_6_knob"));
  wait 0.05;
  self aisetanimlimited(var1, 1, 0);
  self aisetanimlimited(var2, 1, 0);
  var5 = 0;

  for(;;) {
    var6 = scripts\anim\utility_common::getyawtoenemy();
    var7 = angleclamp180(var6 - var5);

    if(abs(var7) > 3) {
      var7 = scripts\engine\utility::sign(var7) * 3;
    }

    var6 = angleclamp180(var5 + var7);

    if(var6 < 0) {
      if(var6 < -45) {
        var6 = -45;
      }

      var8 = var6 / -45;
      self setanim(var3, var8, 0.05);
      self setanim(var4, 0, 0.05);
    } else {
      if(var6 > 45) {
        var6 = 45;
      }

      var8 = var6 / 45;
      self setanim(var4, var8, 0.05);
      self setanim(var3, 0, 0.05);
    }

    var5 = var6;
    wait 0.05;
  }
}

function setupaiming(var0) {
  var1 = scripts\asm\asm::asm_lookupanimfromalias(var0, "clear_knob");
  self aiclearanim(var1, 0.2);

  if(isDefined(self.a.bdyingbackidleandshootsetup)) {
    return;
  }

  thread dyingcrawlbackaim(var0);
  self.a.bdyingbackidleandshootsetup = 1;
}

function isaimedsomewhatatenemy() {
  var0 = self.enemy getshootatpos();
  var1 = self getmuzzleangle();
  var2 = vectortoangles(var0 - self getmuzzlepos());
  var3 = scripts\engine\utility::absangleclamp180(var1[1] - var2[1]);

  if(var3 > anim.painyawdifffartolerance) {
    if(distancesquared(self getEye(), var0) > anim.painyawdiffclosedistsq || var3 > anim.painyawdiffclosetolerance) {
      return false;
    }
  }

  return scripts\engine\utility::absangleclamp180(var1[0] - var2[0]) <= anim.painpitchdifftolerance;
}

function dodyingcrawlbloodsmear() {
  self endon("death");
  var0 = "J_SpineLower";
  var1 = "tag_origin";
  var2 = 6;
  var3 = level._effect["crawling_death_blood_smear"];

  if(isDefined(self.a.crawl_fx_rate)) {
    var2 = self.a.crawl_fx_rate;
  }

  jumpiffalse(isDefined(self.a.crawl_fx)) LOC_00000064;
  var3 = level._effect[self.a.crawl_fx];

  while(var2) {
    var4 = self gettagorigin(var0);
    var5 = self gettagangles(var1);
    var6 = anglestoright(var5);
    var7 = anglesToForward((270, 0, 0));
    playFX(var3, var4, var7, var6);
    wait var2;
  }
}

function iscrawldeltaallowed(var0) {
  if(isDefined(self.a.force_num_crawls)) {
    return 1;
  }

  return isanimdeltaallowed(var0);
}

function isenemyingeneraldirection(var0) {
  if(isDefined(self.forcelongdeath) && self.forcelongdeath == 4) {
    return true;
  }

  if(!isDefined(self.enemy)) {
    return false;
  }

  var1 = vectorNormalize(self.enemy getshootatpos() - self getEye());
  return vectordot(var1, var0) > 0.707;
}

function longdeathkillme(var0, var1, var2) {
  killme();
}

function killme() {
  if(isDefined(self.last_dmg_player)) {
    self kill(self.origin, self.last_dmg_player);
    return;
  }

  self kill();
}

function startdyingcrawlbackaimsoon(var0) {
  self endon(var0 + "_finished");
  wait 0.1;

  if(isDefined(self.a.bdyingbackidleandshootsetup)) {
    return;
  }

  thread dyingcrawlbackaim(var0);
  self.a.bdyingbackidleandshootsetup = 1;
}

function handlebackcrawlnotetracks(var0, var1, var2) {
  var3 = 0;

  if(!isDefined(self.bdoingbloodsmear) && issubstr(var1, "bodyfall")) {
    thread dodyingcrawlbloodsmear();
  } else if(var1 == "fire_spray") {
    if(!scripts\anim\utility_common::canseeenemy()) {
      return true;
    }

    if(!isaimedsomewhatatenemy()) {
      return true;
    }

    scripts\anim\utility_common::shootenemywrapper();
    return true;
  } else if(var1 == "pistol_pickup") {
    thread startdyingcrawlbackaimsoon(var0);
    return false;
  } else if(var1 == "fire") {
    scripts\anim\utility_common::shootenemywrapper();
    return true;
  } else if(var1 == "code_move") {
    return true;
  }

  return false;
}

function choosecrawlingpaintransitionanim(var0, var1, var2) {
  if(!isDefined(self.a.crawlingpaintransanim)) {
    var3 = self.currentpose;

    if(!scripts\asm\asm::asm_hasalias(var1, var3)) {
      self.a.crawlingpaintransanim = undefined;
      return self.a.crawlingpaintransanim;
    }

    self.a.crawlingpaintransanim = scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
  }

  return self.a.crawlingpaintransanim;
}

function choosestumblingpainanim(var0, var1, var2) {
  if(!isDefined(self.a.stumblingpainalias)) {
    var3 = "leg";
    var4 = "b";

    if(!self.leghit) {
      var3 = "gut";

      if(45 < self.damageyaw && self.damageyaw < 135) {
        var4 = "l";
      } else if(-135 < self.damageyaw && self.damageyaw < -45) {
        var4 = "r";
      } else if(-45 < self.damageyaw && self.damageyaw < 45) {}
    }

    self.a.stumblingpainalias = var3 + "_" + var4;
  }

  var5 = scripts\asm\asm::asm_getallanimindicesforalias(var1, self.a.stumblingpainalias);

  if(isarray(var5)) {
    if(!isDefined(self.a.stumblingpainanimindex)) {
      self.a.stumblingpainanimindex = randomint(var5.size);
    }

    var5 = var5[self.a.stumblingpainanimindex];
  }

  return var5;
}

function playdyingcrawl(var0, var1, var2) {
  self endon(var1 + "_finished");

  if(isDefined(self.a.force_num_crawls)) {
    var3 = self.a.force_num_crawls;
  } else {
    var3 = randomintrange(1, 5);
  }

  var4 = scripts\asm\asm::asm_getanim(var1, var2);
  var5 = scripts\asm\asm::asm_getxanim(var2, var4);
  self aisetanim(var2, var4);
  scripts\asm\asm::asm_playfacialanim(var1, var2, var5);

  for(var6 = 0; var6 < var3; var6++) {
    if(!iscrawldeltaallowed(var5)) {
      break;
    }

    if(isDefined(self.custom_crawl_sound)) {
      self playSound(self.custom_crawl_sound);
    }

    for(;;) {
      var7 = scripts\asm\asm::asm_donotetracks(var1, var2, scripts\asm\asm::asm_getnotehandler(var1, var2));

      if(var7 == "code_move") {
        break;
      }
    }
  }

  scripts\asm\asm::asm_fireevent(var1, "dying_crawl_done");
}

function playdyingcrawlback(var0, var1, var2) {
  self endon(var1 + "_finished");

  if(isDefined(self.enemy)) {
    scripts\common\utility::lookatentity(self.enemy);
  }

  if(isDefined(self.a.force_num_crawls)) {
    var3 = self.a.force_num_crawls;
  } else {
    var3 = randomintrange(1, 5);
  }

  setupaiming(var2);
  var4 = scripts\asm\asm::asm_getanim(var1, var2);
  var5 = scripts\asm\asm::asm_getxanim(var2, var4);
  scripts\asm\asm::asm_playfacialanim(var1, var2, var5);
  self aisetanim(var2, var4);

  for(var6 = 0; var6 < var3; var6++) {
    if(!iscrawldeltaallowed(var5)) {
      break;
    }

    for(;;) {
      var7 = scripts\asm\asm::asm_donotetrackswithinterceptor(var1, var2, &handlebackcrawlnotetracks);

      if(var7 == "end") {
        break;
      }
    }
  }

  self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);
  scripts\asm\asm::asm_fireevent(var1, "dying_back_crawl_done");
}

function playcrawlflipover(var0, var1, var2) {
  scripts\common\utility::lookatentity();
  scripts\asm\asm::asm_playanimstatewithnotetrackinterceptor(var0, var1, &handlebackcrawlnotetracks);
}

function playcrawlingpaintransition(var0, var1, var2) {
  setearlyfinishtime();

  if(istrue(self.forcelongdeathskipintroanim)) {
    if(!scripts\asm\asm::asm_eventfired(var0, "end")) {
      scripts\asm\asm::asm_fireevent(var0, "end");
    }

    return;
  }

  thread preventpainforashorttime();
  scripts\common\utility::lookatentity();
  scripts\asm\asm::asm_playanimstatewithnotetrackinterceptor(var0, var1, &handlebackcrawlnotetracks);
}

function setearlyfinishtime() {
  if(!isDefined(self.asm.longdeathanims)) {
    self.asm.longdeathanims = spawnStruct();
  }

  self.asm.longdeathanims.earlyfinishtime = gettime() + 2000;
}

function playdyingbackshoot(var0, var1, var2) {
  self endon(var1 + "_finished");
  setupaiming(var1);

  for(;;) {
    var3 = scripts\asm\asm::asm_getanim(var0, var1);
    var4 = scripts\asm\asm::asm_getxanim(var1, var3);
    scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
    self aisetanim(var1, var3);
    var5 = scripts\asm\asm::asm_donotetrackswithinterceptor(var0, var1, &handlebackcrawlnotetracks);

    if(var5 == "end") {
      if(!scripts\asm\asm::asm_eventfired(var0, "end")) {
        scripts\asm\asm::asm_fireevent(var0, "end");
      }
    }
  }
}

function choosedyingbackidle(var0, var1, var2) {
  if(istrue(self.longdeathnoncombat)) {
    return scripts\asm\asm::asm_lookupanimfromalias(var1, "noncombat");
  }

  return scripts\asm\asm::asm_chooseanim(var0, var1, var2);
}

function playdyingbackidle(var0, var1, var2) {
  self endon(var1 + "_finished");

  if(!istrue(self.longdeathnoncombat)) {
    self.a.nextlongdeathshoottime = gettime() + randomintrange(500, 1000);
    setupaiming(var1);
  }

  var3 = undefined;

  for(;;) {
    var4 = scripts\asm\asm::asm_getanim(var0, var1);
    var5 = scripts\asm\asm::asm_getxanim(var1, var4);

    if(!isDefined(var3) || var4 != var3) {
      self aisetanim(var1, var4);
      var3 = var4;
    }

    scripts\asm\asm::asm_playfacialanim(var0, var1, var5);
    var3 = var4;
    scripts\asm\asm::asm_donotetrackssingleloop(var0, var1, var5, scripts\asm\asm::asm_getnotehandler(var0, var1));
  }
}

function playstumblingpaintransition(var0, var1, var2) {
  thread preventpainforashorttime();
  setearlyfinishtime();
  scripts\common\utility::lookatentity();
  scripts\asm\asm::asm_playanimstate(var0, var1);
}

function playstumblingwander(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = "stumbling_pain_collapse_death";
  var5 = scripts\asm\asm::asm_getanim(var0, var4);
  var6 = scripts\asm\asm::asm_getxanim(var4, var5);
  var7 = scripts\asm\asm::asm_getxanim(var1, var3);

  if(!animhasnotetrack(var7, "code_move")) {
    scripts\asm\asm::asm_fireevent(var0, "pain_wander_done");
    return;
  }

  var8 = getmovedelta(var6);
  var9 = randomintrange(1, 3);
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var7);

  while(var9 > 0) {
    var10 = self localtoworldcoords(var8);

    if(!self maymovetopoint(var10)) {
      break;
    }

    for(;;) {
      var11 = scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));

      if(var11 == "code_move") {
        break;
      }
    }

    var9--;
  }

  scripts\asm\asm::asm_fireevent(var0, "pain_wander_done");
}

function hasbeenhitwithemp(var0, var1, var2, var3) {
  if(isDefined(self.isempd) && self.isempd) {
    return true;
  }

  return false;
}

function shouldflipover(var0, var1, var2, var3) {
  if(isDefined(self.isempd) && self.isempd) {
    return false;
  }

  if(isenemyingeneraldirection(anglesToForward(self.angles) * -1) && self.bulletsinclip > 0) {
    return true;
  }

  return false;
}

function shouldendlongdeath(var0, var1, var2, var3) {
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

function shouldattemptcrawlingpain(var0, var1, var2, var3) {
  scripts\asm\asm::asm_getanim(var0, var2);

  if(!isDefined(self.a.crawlingpaintransanim)) {
    return false;
  }

  var4 = scripts\asm\asm::asm_getxanim(var2, self.a.crawlingpaintransanim);

  if(!iscrawldeltaallowed(var4)) {
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

function shoulddoanylongdeath(var0, var1, var2, var3) {
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
  var4 = getdvarint("scr_forceLongDeath", 0);

  if(var4 != 0) {
    self.forcelongdeath = var4;
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

  foreach(var6 in level.players) {
    if(distancesquared(self.origin, var6.origin) < 30625) {
      return false;
    }
  }

  return true;
}

function shouldattemptstumblingpain(var0) {
  if(self.currentpose != "stand") {
    return false;
  }

  var1 = 20;

  if(isDefined(self.forcelongdeath)) {
    switch (self.forcelongdeath) {
      case 2:
        var1 = 100;
        break;
      case 4:
      case 3:
        return false;
    }
  }

  if(randomint(100) > var1) {
    return false;
  }

  var2 = 0;

  if(!var0) {
    var2 = scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower");

    if(!var2) {
      return false;
    }
  }

  var3 = 0;
  var4 = "leg";
  var5 = "b";

  if(var0) {
    var3 = 200;
  } else {
    var4 = "gut";
    var3 = 128;

    if(45 < self.damageyaw && self.damageyaw < 135) {
      var5 = "l";
    } else if(-135 < self.damageyaw && self.damageyaw < -45) {
      var5 = "r";
    } else if(-45 < self.damageyaw && self.damageyaw < 45) {
      return false;
    }
  }

  switch (var5) {
    case "b":
      var6 = anglesToForward(self.angles);
      var7 = self.origin - var6 * var3;
      break;
    case "l":
      var8 = anglestoright(self.angles);
      var7 = self.origin - var8 * var4;
      break;
    case "r":
      var8 = anglestoright(self.angles);
      var7 = self.origin + var8 * var5;
      break;
    default:
      return false;
  }

  if(!isDefined(self.forcelongdeath) || self.forcelongdeath != 2) {
    if(!self maymovetopoint(var7)) {
      return false;
    }
  }

  return true;
}

function shoulddostumblinglongdeath(var0, var1, var2, var3) {
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

function shoulddocrawlingbacklongdeath(var0, var1, var2, var3) {
  if(isDefined(self.forcelongdeath) && self.forcelongdeath == 4) {
    return true;
  }

  if(usingnewlongdeaths()) {
    return false;
  }

  if(!isenemyingeneraldirection(anglesToForward(self.angles)) || self.bulletsinclip <= 0) {
    return false;
  }

  if(shouldattemptcrawlingpain(var0, var1, var2, var3)) {
    return true;
  }

  return false;
}

function shoulddocrawlingonbellylongdeath(var0, var1, var2, var3) {
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

  return shouldattemptcrawlingpain(var0, var1, var2, var3);
}

function shoulddodyingbackcrawl(var0, var1, var2, var3) {
  return !istrue(self.skipdyingbackcrawl);
}

function shoulddodyingcrawl(var0, var1, var2, var3) {
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
    var4 = scripts\asm\asm::asm_getanim(var0, var2);
    var5 = scripts\asm\asm::asm_getxanim(var2, var4);

    if(!iscrawldeltaallowed(var5)) {
      return false;
    }
  }

  return true;
}

function longdeathshouldshoot(var0, var1, var2, var3) {
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

function doesstumblingpainstatehavealias(var0, var1, var2, var3) {
  if(!scripts\asm\asm::asm_hasalias(var2, self.a.stumblingpainalias)) {
    return false;
  }

  var4 = scripts\asm\asm::asm_getallanimindicesforalias(var2, self.a.stumblingpainalias);

  if(!isDefined(var4) || !isarray(var4)) {
    return false;
  }

  if(var4.size <= self.a.stumblingpainanimindex) {
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

function shoulddomercy(var0, var1, var2, var3) {
  if(!istrue(self.asm.longdeathanims.mercyenabled)) {
    return 0;
  }

  if(isforcingspecificlongdeath()) {
    return shoulddoforcedmercy();
  }

  var4 = anglesToForward(self.angles);

  foreach(var6 in level.players) {
    var7 = distancesquared(self.origin, var6.origin);

    if(distancesquared(self.origin, var6.origin) > 90000) {
      continue;
    }

    var8 = vectorNormalize(var6.origin - self.origin);

    if(istrue(self.asm.longdeathanims.bellycrawl)) {
      if(vectordot(var8, var4) > -0.707) {
        continue;
      }
    } else if(vectordot(var8, var4) < 0.707) {
      continue;
    }

    var9 = anglesToForward(var6.angles);

    if(vectordot(var9, var8) < -0.707) {
      return 1;
    }
  }

  return 0;
}

function shoulddoshootinglongdeath(var0, var1, var2, var3) {
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

function shoulddomercytransition(var0, var1, var2, var3) {
  return istrue(self.asm.longdeathanims.mercytransitionenabled);
}

function shoulddofinaldeath(var0, var1, var2, var3) {
  return gettime() > self.asm.longdeathanims.loopendtime;
}

function longdeathfinal(var0, var1, var2) {
  self.asm.longdeathanims.alias += "_final";
  self.asm.longdeathanims.bledout = 1;
  killme();
}

function playlongdeathintro(var0, var1, var2) {
  thread preventpainforashorttime();

  if(istrue(self.forcelongdeathskipintroanim)) {
    if(!scripts\asm\asm::asm_eventfired(var0, "end")) {
      scripts\asm\asm::asm_fireevent(var0, "end");
    }

    return;
  }

  setearlyfinishtime();
  playlongdeathanim(var0, var1);
}

function playlongdeathmercy(var0, var1, var2) {
  playlongdeathanim(var0, var1);
}

function chooseanimlongdeath(var0, var1, var2) {
  var3 = self.asm.longdeathanims.alias;

  if(!scripts\asm\asm::asm_hasalias(var1, var3)) {
    return undefined;
  }

  var4 = scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
  return var4;
}

function longdeathmercyfinal(var0, var1, var2) {
  killme();
}

function playlongdeathidle(var0, var1, var2) {
  if(istrue(self.asm.longdeathanims.grenadepullenabled)) {
    self.asm.longdeathanims.grenadepulltime = gettime() + self.asm.longdeathanims.grenadepulltimer;
  }

  if(isDefined(self.asm.longdeathanims.idletimeout)) {
    self.asm.longdeathanims.loopendtime = gettime() + self.asm.longdeathanims.idletimeout;
  }

  var3 = [[self.asm.longdeathanims.loopfunc]](var0, var1, var2);

  if(!var3) {
    self.asm.longdeathanims.loopendtime = gettime();

    if(!scripts\asm\asm::asm_eventfired(var0, "end")) {
      scripts\asm\asm::asm_fireevent(var0, "end");
      return;
    }

    return;
  }
}

function playshootinglongdeathidle(var0, var1, var2) {
  if(!isDefined(self.desiredtimeofdeath)) {
    self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);
  }

  self.a.nextlongdeathshoottime = gettime() + randomintrange(500, 1000);
  setupaiming(var1);
  var3 = [[self.asm.longdeathanims.loopfunc]](var0, var1, var2);

  if(!var3) {
    self.asm.longdeathanims.loopendtime = gettime();

    if(!scripts\asm\asm::asm_eventfired(var0, "end")) {
      scripts\asm\asm::asm_fireevent(var0, "end");
      return;
    }

    return;
  }
}

function longdeathidlesingleloop(var0, var1, var2) {
  return playlongdeathanim(var0, var1);
}

function shoulddocrawllongdeath(var0, var1, var2, var3) {
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

  var4 = randomfloat(1);
  return var4 < 0.6;
}

function shoulddocoverlongdeath(var0, var1, var2, var3) {
  if(!usingnewlongdeaths()) {
    return false;
  }

  if(isforcingspecificlongdeath()) {
    return (self.forcelongdeath >= 5 && self.forcelongdeath <= 16);
  }

  var4 = scripts\asm\asm_bb::bb_getcovernode();

  if(!isDefined(var4)) {
    return false;
  }

  if(!isDefined(self._blackboard.covernode.type)) {
    return false;
  }

  if(isDefined(self._blackboard.coverstate) && self._blackboard.coverstate == "exposed") {
    return false;
  }

  var5 = scripts\asm\shared\utility::getnodeforwardyaw(var4);
  var6 = self.angles[1];
  var7 = 5;

  if(abs(var5 - var6) > var7) {
    return false;
  }

  return self._blackboard.covernode.type != "Cover Prone";
}

function shoulddoexposedlongdeath(var0, var1, var2, var3) {
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

function choosecrawllongdeathanims(var0, var1, var2) {
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

  var0 = "exposed";

  if(self.currentpose == "crouch") {
    var0 += "_crouch";
  } else {
    var0 += "_stand";
  }

  var0 += "_crawl";
  var1 = getdamagedirection();

  switch (var1) {
    case 1:
      var0 += "_left";
      break;
    case 0:
      var0 += "_right";
      break;
    case 3:
      var0 += "_back";
      break;
    default:
      var0 = getfrontcrawldeath(var0);
      break;
  }

  return var0;
}

function getfrontcrawldeath(var0) {
  var1 = randomfloat(1);

  if(var1 < 0.4) {
    self.asm.longdeathanims.shootenabled = 1;
    self.asm.longdeathanims.mercyenabled = 0;
    var0 += "_shoot";
  } else {
    self.asm.longdeathanims.mercytransitionenabled = 1;
    self.asm.longdeathanims.bellycrawl = 1;
    var0 += "_belly";
  }

  return var0;
}

function choosecoverlongdeathanims(var0, var1, var2) {
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

  var0 = "cover";

  if(self._blackboard.covernode.type == "Cover Right") {
    var0 += "_right";
  } else if(self._blackboard.covernode.type == "Cover Left") {
    var0 += "_left";
  }

  if(self.currentpose == "crouch") {
    var0 += "_crouch";
  } else {
    var0 += "_stand";
  }

  return var0;
}

function chooseexposedlongdeathanims(var0, var1, var2) {
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
  var0 = abs(self.damageyaw);

  if(var0 > 135) {
    return 2;
  } else if(var0 < 45) {
    return 3;
  } else if(self.damageyaw < 0) {
    return 0;
  }

  return 1;
}

function getdamagedirectionsuffix() {
  if(!istrue(self.asm.longdeathanims.bledout)) {
    var0 = getdamagedirection();

    switch (var0) {
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

  var0 = getdamagedirection();

  switch (var0) {
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

function shouldshootduringlongdeath(var0, var1, var2, var3) {
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

function shoulddolongdeathgrenade(var0, var1, var2, var3) {
  if(isDefined(self.forcelongdeath) && self.forcelongdeath == 5) {
    return true;
  }

  if(!istrue(self.asm.longdeathanims.grenadepullenabled)) {
    return false;
  }

  if(!scripts\asm\asm::asm_hasalias(var2, self.asm.longdeathanims.alias)) {
    return false;
  }

  return gettime() > self.asm.longdeathanims.grenadepulltime;
}

function shoulddolongdeathgrenadefinal(var0, var1, var2, var3) {
  return gettime() > self.asm.longdeathanims.grenadedroptimer;
}

function playlongdeathgrenade(var0, var1, var2) {
  self.asm.longdeathanims.grenadedroptimer = gettime() + randomfloatrange(1.5, 1.9) * 1000;
  playlongdeathanim(var0, var1);
}

function playlongdeathgrenadepull(var0, var1, var2) {
  self.asm.longdeathanims.onfinaldeathcallback = &onfinaldeathdropgrenade;
  playlongdeathanim(var0, var1);
}

function playlongdeathanim(var0, var1) {
  var2 = scripts\asm\asm::asm_getanim(var0, var1);
  var3 = scripts\asm\asm::asm_getxanim(var1, var2);

  if(isDefined(self.forcelongdeath) || isanimdeltaallowed(var3)) {
    scripts\asm\asm::asm_playfacialanim(var0, var1, var3);
    self aisetanim(var1, var2);
    scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
  } else {
    return false;
  }

  return true;
}

function longdeathfinalgrenade(var0, var1, var2) {
  killme();
}

function chooselongdeathdeathanim(var0, var1, var2) {
  if(isDefined(self.asm.longdeathanims.longdeathdirectionalfunc)) {
    self.asm.longdeathanims.alias += [[self.asm.longdeathanims.longdeathdirectionalfunc]]();
  }

  return chooseanimlongdeath(var0, var1, var2);
}

function usingnewlongdeaths() {
  setdvarifuninitialized("scr_ai_new_long_deaths", "1");
  return getDvar("scr_ai_new_long_deaths") != "0";
}

function isanimdeltaallowed(var0) {
  if(istrue(self.asm.longdeathanims.ignoreanimdeltacheck)) {
    return 1;
  }

  var1 = 30;
  var2 = getmovedelta(var0, 0, 1);
  var3 = length(var2);
  var4 = vectorNormalize(var2);
  var2 = var4 * (var3 + var1);
  var5 = self localtoworldcoords(var2);

  if(!checkstairsoffsetpoint(var5)) {
    return 0;
  }

  return self maymovetopoint(var5);
}

function checkstairsoffsetpoint(var0) {
  return self isatvalidlongdeathspot(var0);
}

function canplaychosenlongdeath(var0, var1, var2, var3) {
  var4 = scripts\asm\asm::asm_getanim(var0, var2, var3);
  var5 = scripts\asm\asm::asm_getxanim(var2, var4);

  if(!istrue(self.forcelongdeath) && !isanimdeltaallowed(var5)) {
    self.asm.longdeathanims = undefined;
    return false;
  }

  return true;
}

function playlongdeathfinaldeath(var0, var1, var2) {
  if(isDefined(self.asm.longdeathanims.onfinaldeathcallback)) {
    [[self.asm.longdeathanims.onfinaldeathcallback]]();
  }

  scripts\asm\soldier\death::playdeathanim(var0, var1, var2);
}

function onfinaldeathdropgrenade() {
  if(!isDefined(self.asm.longdeathanims.grenadetag)) {
    return;
  }

  var0 = (0, 0, 30) - anglestoright(self.angles) * 70;

  if(self.asm.longdeathanims.grenadetag == "tag_accessory_left") {
    var0 *= -1;
  }

  var1 = self gettagorigin(self.asm.longdeathanims.grenadetag);
  var2 = var1 + (0, 0, 20);
  var3 = var1 - (0, 0, 20);
  var4 = scripts\engine\trace::ray_trace(var2, var3, self, undefined, 1);

  if(var4["fraction"] < 0.5) {
    var1 = var4["position"];
  }

  var5 = "default";

  if(var4["surfacetype"] != "none") {
    var5 = var4["surfacetype"];
  }

  playworldsound("grenade_bounce_heavy", var1);
  self detach(getweaponmodel("frag"), self.asm.longdeathanims.grenadetag);
  self magicgrenademanual(var1, var0, randomfloatrange(2, 3));
}

function shouldfinishlongdeath(var0, var1, var2, var3) {
  if(istrue(self.burningtodeath)) {
    return true;
  }

  if(isDefined(self.asm.longdeathanims.earlyfinishtime) && gettime() > self.asm.longdeathanims.earlyfinishtime) {
    foreach(var5 in level.players) {
      if(distancesquared(self.origin, var5.origin) < 2500) {
        return true;
      }
    }
  }

  if(isDefined(self.desiredtimeofdeath) && gettime() > self.desiredtimeofdeath) {
    return true;
  }

  return false;
}

function longdeathgrenadepullnotetrackhandler(var0) {
  if(var0 == "grenade_left") {
    self.asm.longdeathanims.grenadetag = "tag_accessory_left";
  } else if(var0 == "grenade_right") {
    self.asm.longdeathanims.grenadetag = "tag_accessory_right";
  }

  self attach(getweaponmodel("frag"), self.asm.longdeathanims.grenadetag);
}