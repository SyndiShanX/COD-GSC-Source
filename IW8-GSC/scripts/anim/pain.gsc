/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\pain.gsc
***********************************************/

function init_animset_pain() {}

function main() {
  self endon("killanimscript");
  scripts\asm\asm_sp::paininternal();
}

function initpainfx() {
  level._effect["crawling_death_blood_smear"] = loadfx("vfx/core/impacts/blood_smear_decal.vfx");
}

function getdamageshieldpainanim() {
  if(self.currentpose == "prone") {
    return;
  }

  if(isDefined(self.lastattacker) && isDefined(self.lastattacker.team) && self.lastattacker.team == self.team) {
    return;
  }

  if(!isDefined(self.damageshieldcounter) || gettime() - self.a.lastpaintime > 1500) {
    self.damageshieldcounter = randomintrange(2, 3);
  }

  if(isDefined(self.lastattacker) && distancesquared(self.origin, self.lastattacker.origin) < squared(512)) {
    self.damageshieldcounter = 0;
  }

  if(self.damageshieldcounter > 0) {
    self.damageshieldcounter--;
    return;
  }

  self.damageshieldpain = 1;
  self.allowpain = 0;

  if(self.ignoreme) {
    self.predamageshieldignoreme = 1;
  } else {
    self.ignoreme = 1;
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
  }

  if(self.currentpose == "crouch") {
    return scripts\anim\utility::lookupanim("pain", "damage_shield_crouch");
  }

  var0 = scripts\anim\utility::lookupanim("pain", "damage_shield_pain_array");
  return var0[randomint(var0.size)];
}

function getpainanim() {
  if(self.damageshield && !isDefined(self.disabledamageshieldpain)) {
    var0 = getdamageshieldpainanim();

    if(isDefined(var0)) {
      return var0;
    }
  }

  if(isDefined(self.a.onback)) {
    if(self.currentpose == "crouch") {
      return scripts\anim\utility::lookupanim("pain", "back");
    } else {
      scripts\anim\utility::stoponback();
    }
  }

  if(self.currentpose == "stand") {
    var1 = isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 4096;

    if(!var1 && self.a.movement == "run" && abs(self getmotionangle()) < 60) {
      return getrunningforwardpainanim();
    }

    self.a.movement = "stop";
    return getstandpainanim();
  }

  if(self.currentpose == "crouch") {
    self.a.movement = "stop";
    return getcrouchpainanim();
  }

  if(self.currentpose == "prone") {
    self.a.movement = "stop";
    return getpronepainanim();
  }
}

function getrunningforwardpainanim() {
  var0 = [];
  var1 = 0;
  var2 = 0;
  var3 = 0;

  if(self maymovetopoint(self localtoworldcoords((300, 0, 0)))) {
    var2 = 1;
    var1 = 1;
  } else if(self maymovetopoint(self localtoworldcoords((200, 0, 0)))) {
    var1 = 1;
  }

  if(isDefined(self.a.disablelongpain)) {
    var2 = 0;
    var1 = 0;
  }

  if(var2) {
    var0 = scripts\anim\utility::lookupanim("pain", "run_long");
  } else if(var1) {
    var0 = scripts\anim\utility::lookupanim("pain", "run_medium");
  } else if(self maymovetopoint(self localtoworldcoords((120, 0, 0)))) {
    var0 = scripts\anim\utility::lookupanim("pain", "run_short");
  }

  if(!var0.size) {
    self.a.movement = "stop";
    return getstandpainanim();
  }

  return var0[randomint(var0.size)];
}

function getstandpistolpainanim() {
  var0 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var0 = scripts\anim\utility::lookupanim("pain", "pistol_torso_upper");
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    var0 = scripts\anim\utility::lookupanim("pain", "pistol_torso_lower");
  } else if(scripts\engine\utility::damagelocationisany("neck")) {
    var0 = scripts\anim\utility::lookupanim("pain", "pistol_neck");
  } else if(scripts\engine\utility::damagelocationisany("head")) {
    var0 = scripts\anim\utility::lookupanim("pain", "pistol_head");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "right_leg_upper")) {
    var0 = scripts\anim\utility::lookupanim("pain", "pistol_leg");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper")) {
    var0 = scripts\anim\utility::lookupanim("pain", "pistol_left_arm_upper");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_lower")) {
    var0 = scripts\anim\utility::lookupanim("pain", "pistol_left_arm_lower");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper")) {
    var0 = scripts\anim\utility::lookupanim("pain", "pistol_right_arm_upper");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_lower")) {
    var0 = scripts\anim\utility::lookupanim("pain", "pistol_right_arm_lower");
  }

  if(var0.size < 2) {
    var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("pain", "pistol_default1"));
  }

  if(var0.size < 2) {
    var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("pain", "pistol_default2"));
  }

  return var0[randomint(var0.size)];
}

function getstandpainanim() {
  if(scripts\anim\utility_common::isusingsidearm()) {
    return getstandpistolpainanim();
  }

  var0 = [];
  var1 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var0 = scripts\anim\utility::lookupanim("pain", "torso_upper");
    var1 = scripts\anim\utility::lookupanim("pain", "torso_upper_extended");
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    var0 = scripts\anim\utility::lookupanim("pain", "torso_lower");
    var1 = scripts\anim\utility::lookupanim("pain", "torso_lower_extended");
  } else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var0 = scripts\anim\utility::lookupanim("pain", "head");
    var1 = scripts\anim\utility::lookupanim("pain", "head_extended");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    var0 = scripts\anim\utility::lookupanim("pain", "right_arm");
    var1 = scripts\anim\utility::lookupanim("pain", "right_arm_extended");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower")) {
    var0 = scripts\anim\utility::lookupanim("pain", "left_arm");
    var1 = scripts\anim\utility::lookupanim("pain", "left_arm_extended");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "right_leg_upper")) {
    var0 = scripts\anim\utility::lookupanim("pain", "leg");
    var1 = scripts\anim\utility::lookupanim("pain", "leg_extended");
  } else if(scripts\engine\utility::damagelocationisany("left_foot", "right_foot", "left_leg_lower", "right_leg_lower")) {
    var0 = scripts\anim\utility::lookupanim("pain", "foot");
    var1 = scripts\anim\utility::lookupanim("pain", "foot_extended");
  }

  if(var0.size < 2) {
    if(!self.a.disablelongdeath) {
      var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("pain", "default_long"));
    } else {
      var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("pain", "default_short"));
    }
  }

  if(var1.size < 2) {
    var1 = scripts\engine\utility::array_combine(var1, scripts\anim\utility::lookupanim("pain", "default_extended"));
  }

  if(!self.damageshield && !self.a.disablelongdeath) {
    var2 = randomint(var0.size + var1.size);

    if(var2 < var0.size) {
      return var0[var2];
    } else {
      return var1[var2 - var0.size];
    }
  }

  return var0[randomint(var0.size)];
}

function getcrouchpainanim() {
  var0 = [];

  if(!self.damageshield && !self.a.disablelongdeath) {
    var0 = scripts\anim\utility::lookupanim("pain", "crouch_longdeath");
  }

  var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("pain", "crouch_default"));

  if(scripts\engine\utility::damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper")) {
    var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("pain", "crouch_left_arm"));
  }

  if(scripts\engine\utility::damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper")) {
    var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("pain", "crouch_right_arm"));
  }

  return var0[randomint(var0.size)];
}

function getpronepainanim() {
  var0 = scripts\anim\utility::lookupanim("pain", "prone");
  return var0[randomint(var0.size)];
}

#using_animtree("");

function playpainanim(var0) {
  var1 = 1;
  pain_setflaggedanimknoballrestart("painanim", var0, %body, 1, 0.1, var1);

  if(self.currentpose == "prone") {
    self updateprone(%prone_legs_up, $prone_legs_down, 1, 0.1, 1);
  }

  if(animhasnotetrack(var0, "start_aim")) {
    thread notifystartaim("painanim");
    self endon("start_aim");
  }

  if(animhasnotetrack(var0, "code_move")) {
    scripts\anim\notetracks::donotetracks("painanim");
  }

  scripts\anim\notetracks::donotetracks("painanim");
}

function notifystartaim(var0) {
  self endon("killanimscript");
  self waittillmatch(var0, "start_aim");
  self notify("start_aim");
}

function specialpainblocker() {
  self endon("killanimscript");
  self.blockingpain = 1;
  self.allowpain = 0;
  wait 0.5;
  self.blockingpain = undefined;
  self.allowpain = 1;
}

function specialpain(var0) {
  if(var0 == "none") {
    return 0;
  }

  self.a.special = "none";
  thread specialpainblocker();

  switch (var0) {
    case "cover_left":
      if(self.currentpose == "stand") {
        var1 = scripts\anim\utility::lookupanim("pain", "cover_left_stand");
        dopainfromarray(var1);
        var2 = 1;
      } else if(self.currentpose == "crouch") {
        var1 = scripts\anim\utility::lookupanim("pain", "cover_left_crouch");
        dopainfromarray(var1);
        var2 = 1;
      } else {
        var2 = 0;
      }

      break;
    case "cover_right":
      if(self.currentpose == "stand") {
        var1 = scripts\anim\utility::lookupanim("pain", "cover_right_stand");
        dopainfromarray(var1);
        var2 = 1;
      } else if(self.currentpose == "crouch") {
        var1 = scripts\anim\utility::lookupanim("pain", "cover_right_crouch");
        dopainfromarray(var1);
        var2 = 1;
      } else {
        var2 = 0;
      }

      break;
    case "cover_right_stand_A":
      var2 = 0;
      break;
    case "cover_right_stand_B":
      dopain(scripts\anim\utility::lookupanim("pain", "cover_right_stand_B"));
      var2 = 1;
      break;
    case "cover_left_stand_A":
      dopain(scripts\anim\utility::lookupanim("pain", "cover_left_stand_A"));
      var2 = 1;
      break;
    case "cover_left_stand_B":
      dopain(scripts\anim\utility::lookupanim("pain", "cover_left_stand_B"));
      var2 = 1;
      break;
    case "cover_crouch":
      var1 = scripts\anim\utility::lookupanim("pain", "cover_crouch");
      dopainfromarray(var1);
      var2 = 1;
      break;
    case "cover_stand":
      var1 = scripts\anim\utility::lookupanim("pain", "cover_stand");
      dopainfromarray(var1);
      var2 = 1;
      break;
    case "cover_stand_aim":
      var1 = scripts\anim\utility::lookupanim("pain", "cover_stand_aim");
      dopainfromarray(var1);
      var2 = 1;
      break;
    case "cover_crouch_aim":
      var1 = scripts\anim\utility::lookupanim("pain", "cover_crouch_aim");
      dopainfromarray(var1);
      var2 = 1;
      break;
    case "saw":
      if(self.currentpose == "stand") {
        var3 = scripts\anim\utility::lookupanim("pain", "saw_stand");
      } else {
        jumpiffalse(self.currentpose == "crouch") LOC_0000024a;
        var3 = scripts\anim\utility::lookupanim("pain", "saw_crouch");
        goto LOC_0000025d;
      }

      LOC_0000025d:
        pain_setflaggedanimknob("painanim", var3, 1, 0.3, 1);
      scripts\anim\notetracks::donotetracks("painanim");
      var2 = 1;
      break;
    case "mg42":
      mg42pain(self.currentpose);
      var2 = 1;
      break;
    case "minigun":
      var2 = 0;
      break;
    case "corner_right_martyrdom":
      var2 = trycornerrightgrenadedeath();
      break;
    case "rambo":
    case "rambo_right":
    case "rambo_left":
    case "dying_crawl":
      var2 = 0;
      break;
    default:
      var2 = 0;
      break;
  }

  return var2;
}

function paindeathnotify() {
  self endon("death");
  wait 0.05;
  self notify("pain_death");
}

function dopainfromarray(var0) {
  var1 = var0[randomint(var0.size)];
  pain_setflaggedanimknob("painanim", var1, 1, 0.3, 1);
  scripts\anim\notetracks::donotetracks("painanim");
}

function dopain(var0) {
  pain_setflaggedanimknob("painanim", var0, 1, 0.3, 1);
  scripts\anim\notetracks::donotetracks("painanim");
}

function mg42pain(var0) {
  pain_setflaggedanimknob("painanim", level.mg_animmg["pain_" + var0], 1, 0.1, 1);
  scripts\anim\notetracks::donotetracks("painanim");
}

function waitsetstop(var0, var1) {
  self endon("killanimscript");
  self endon("death");

  if(isDefined(var1)) {
    self endon(var1);
  }

  wait var0;
  self.a.movement = "stop";
}

function crawlingpain() {
  if(self.a.disablelongdeath || self.diequietly || self.damageshield) {
    return false;
  }

  if(self.stairsstate != "none") {
    return false;
  }

  if(isDefined(self.a.onback)) {
    return false;
  }

  var0 = scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot");

  if(isDefined(self.forcelongdeath)) {
    setcrawlingpaintransanim(var0);
    self.health = 10;
    thread crawlingpistol();
    self waittill("killanimscript");
    return true;
  }

  if(self.health > 100) {
    return false;
  }

  if(!isDefined(self.forcelongdeath) || !self.forcelongdeath) {
    if(var0 && self.health < self.maxhealth * 0.4) {
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
  }

  if(isDefined(self.deathfunction)) {
    return false;
  }

  foreach(var2 in level.players) {
    if(distancesquared(self.origin, var2.origin) < 30625) {
      return false;
    }
  }

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "gun", "right_hand", "left_hand")) {
    return false;
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return false;
  }

  setcrawlingpaintransanim(var0);

  if(!isDefined(self.a.stumblingpainanimseq) && !iscrawldeltaallowed(self.a.crawlingpaintransanim)) {
    return false;
  }

  anim.nextcrawlingpaintime = gettime() + 3000;
  anim.nextcrawlingpaintimefromlegdamage = gettime() + 3000;
  thread crawlingpistol();
  self waittill("killanimscript");
  return true;
}

function setcrawlingpaintransanim(var0) {
  var1 = [];
  var2 = undefined;

  if(self.currentpose == "stand") {
    var2 = shouldattemptstumblingpain(var0);

    if(isDefined(var2)) {
      var1 = [var2[0]];
    } else {
      var1 = scripts\anim\utility::lookupanim("crawl_death", "stand_transition");
    }
  } else if(self.currentpose == "crouch") {
    var1 = scripts\anim\utility::lookupanim("crawl_death", "crouch_transition");
  } else {
    var1 = scripts\anim\utility::lookupanim("crawl_death", "prone_transition");
  }

  self.a.crawlingpaintransanim = var1[randomint(var1.size)];
  self.a.stumblingpainanimseq = var2;
}

function iscrawldeltaallowed(var0) {
  if(isDefined(self.a.force_num_crawls)) {
    return 1;
  }

  var1 = getmovedelta(var0, 0, 1);
  var2 = self localtoworldcoords(var1);
  return self maymovetopoint(var2);
}

function crawlingpistol() {
  self endon("kill_long_death");
  self endon("death");
  thread preventpainforashorttime("crawling");
  self.a.special = "none";
  self.specialdeathfunc = undefined;
  self setlookatentity();
  thread paindeathnotify();
  level notify("ai_crawling", self);
  self setanimknoball(%dying, %body, 1, 0.1, 1);

  if(isDefined(self.a.stumblingpainanimseq)) {
    stumblingpain();
    self.a.stumblingpainanimseq = undefined;
    return;
  }

  if(!dyingcrawl()) {
    return;
  }

  pain_setflaggedanimknob("transition", self.a.crawlingpaintransanim, 1, 0.5, 1);
  scripts\anim\notetracks::donotetracksintercept("transition", &handlebackcrawlnotetracks);
  self.a.special = "dying_crawl";
  thread dyingcrawlbackaim();

  if(isDefined(self.enemy)) {
    self setlookatentity(self.enemy);
  }

  decidenumcrawls();

  while(shouldkeepcrawling()) {
    var0 = scripts\anim\utility::lookupanim("crawl_death", "back_crawl");

    if(!iscrawldeltaallowed(var0)) {
      break;
    }

    pain_setflaggedanimknobrestart("back_crawl", var0, 1, 0.1, 1);
    scripts\anim\notetracks::donotetracksintercept("back_crawl", &handlebackcrawlnotetracks);
  }

  self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);

  while(shouldstayalive()) {
    if(scripts\anim\utility_common::canseeenemy() && aimedsomewhatatenemy()) {
      var1 = scripts\anim\utility::lookupanim("crawl_death", "back_fire");
      pain_setflaggedanimknobrestart("back_idle_or_fire", var1, 1, 0.2, 1);
      scripts\anim\notetracks::donotetracks("back_idle_or_fire");
      continue;
    }

    var1 = scripts\anim\utility::lookupanim("crawl_death", "back_idle");

    if(randomfloat(1) < 0.4) {
      var2 = scripts\anim\utility::lookupanim("crawl_death", "back_idle_twitch");
      var1 = var2[randomint(var2.size)];
    }

    pain_setflaggedanimknobrestart("back_idle_or_fire", var1, 1, 0.1, 1);
    var3 = getanimlength(var1);

    while(var3 > 0) {
      if(scripts\anim\utility_common::canseeenemy() && aimedsomewhatatenemy()) {
        break;
      }

      var4 = 0.5;

      if(var4 > var3) {
        var4 = var3;
        var3 = 0;
      } else {
        var3 -= var4;
      }

      scripts\anim\notetracks::donotetracksfortime(var4, "back_idle_or_fire");
    }
  }

  self notify("end_dying_crawl_back_aim");
  self clearanim(%dying_back_aim_4_wrapper, 0.3);
  self clearanim(%dying_back_aim_6_wrapper, 0.3);
  var5 = scripts\anim\utility::lookupanim("crawl_death", "back_death");
  self.deathanim = var5[randomint(var5.size)];
  killwrapper();
  self.a.special = "none";
  self.specialdeathfunc = undefined;
}

function shouldattemptstumblingpain(var0) {
  if(self.currentpose != "stand") {
    return;
  }

  var1 = 2;

  if(randomint(10) > var1) {
    return;
  }

  var2 = 0;

  if(!var0) {
    var2 = scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower");

    if(!var2) {
      return;
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
      return;
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
      return;
  }

  if(!self maymovetopoint(var7)) {
    return;
  }

  var9 = scripts\anim\utility::lookupanim("crawl_death", "longdeath");
  var10 = var7 + "_" + var7;
  var11 = randomint(var9[var10].size);
  var12 = var9[var10][var11];
  return var12;
}

function stumblingpain() {
  pain_setflaggedanimknobrestart("stumblingPainInto", self.a.stumblingpainanimseq[0]);
  scripts\anim\notetracks::donotetracks("stumblingPainInto");
  self.a.special = "stumbling_pain";
  var0 = getmovedelta(self.a.stumblingpainanimseq[2]);
  var1 = getanimlength(self.a.stumblingpainanimseq[2]) * 1000;

  for(var2 = randomint(2) + 1; var2 > 0; var2--) {
    var3 = anglesToForward(self.angles);
    var4 = self.origin + var3 * var0;

    if(!self maymovetopoint(var4)) {
      break;
    }

    pain_setflaggedanimknobrestart("stumblingPain", self.a.stumblingpainanimseq[1]);
    scripts\anim\notetracks::donotetracks("stumblingPain");
  }

  self.a.nodeath = 1;
  self.a.special = "none";
  pain_setflaggedanimknobrestart("stumblingPainCollapse", self.a.stumblingpainanimseq[2], 1, 0.75);
  scripts\anim\notetracks::donotetracksintercept("stumblingPainCollapse", &stumblingpainnotetrackhandler);
  scripts\anim\notetracks::donotetracks("stumblingPainCollapse");
  killwrapper();
}

function stumblingpainnotetrackhandler(var0) {
  if(var0 == "start_ragdoll") {
    scripts\anim\notetracks::handlenotetrack(var0, "stumblingPainCollapse");
    return 1;
  }
}

function shouldstayalive() {
  if(!enemyisingeneraldirection(anglesToForward(self.angles))) {
    return false;
  }

  return gettime() < self.desiredtimeofdeath;
}

function dyingcrawl() {
  if(!isDefined(self.forcelongdeath)) {
    if(self.currentpose == "prone") {
      return true;
    }

    if(self.a.movement == "stop") {
      if(randomfloat(1) < 0.4) {
        if(randomfloat(1) < 0.5) {
          return true;
        }
      } else if(abs(self.damageyaw) > 90) {
        return true;
      }
    } else if(abs(self getmotionangle()) > 90) {
      return true;
    }
  }

  if(self.currentpose != "prone") {
    var0 = scripts\anim\utility::lookupanim("crawl_death", self.currentpose + "_2_crawl");
    var1 = var0[randomint(var0.size)];

    if(!iscrawldeltaallowed(var1)) {
      return true;
    }

    thread dyingcrawlbloodsmear();
    pain_setflaggedanimknob("falling", var1, 1, 0.5, 1);
    scripts\anim\notetracks::donotetracks("falling");
  } else {
    thread dyingcrawlbloodsmear();
  }

  self.a.crawlingpaintransanim = scripts\anim\utility::lookupanim("crawl_death", "default_transition");
  self.a.special = "dying_crawl";
  decidenumcrawls();
  var2 = scripts\anim\utility::lookupanim("crawl_death", "crawl");

  while(shouldkeepcrawling()) {
    if(!iscrawldeltaallowed(var2)) {
      return true;
    }

    if(isDefined(self.custom_crawl_sound)) {
      self playSound(self.custom_crawl_sound);
    }

    pain_setflaggedanimknobrestart("crawling", var2, 1, 0.1, 1);
    scripts\anim\notetracks::donotetracks("crawling");
  }

  self notify("done_crawling");

  if(!isDefined(self.forcelongdeath) && enemyisingeneraldirection(anglesToForward(self.angles) * -1)) {
    return true;
  }

  var3 = scripts\anim\utility::lookupanim("crawl_death", "death");
  var4 = var3[randomint(var3.size)];
  scripts\anim\death::playdeathanim(var4);
  killwrapper();
  self.a.special = "none";
  self.specialdeathfunc = undefined;
  return false;
}

function dyingcrawlbloodsmear() {
  self endon("death");

  if(self.currentpose != "prone") {
    for(;;) {
      self waittill("falling", var0);

      if(issubstr(var0, "bodyfall")) {
        break;
      }
    }
  }

  var1 = "J_SpineLower";
  var2 = "tag_origin";
  var3 = 0.25;
  var4 = level._effect["crawling_death_blood_smear"];

  if(isDefined(self.a.crawl_fx_rate)) {
    var3 = self.a.crawl_fx_rate;
  }

  jumpiffalse(isDefined(self.a.crawl_fx)) LOC_00000097;
  var4 = level._effect[self.a.crawl_fx];

  while(var3) {
    var5 = self gettagorigin(var1);
    var6 = self gettagangles(var2);
    var7 = anglestoright(var6);
    var8 = anglesToForward((270, 0, 0));
    playFX(var4, var5, var8, var7);
    wait var3;
  }
}

function dyingcrawlbackaim() {
  self endon("kill_long_death");
  self endon("death");
  self endon("end_dying_crawl_back_aim");

  if(isDefined(self.dyingcrawlaiming)) {
    return;
  }

  self.dyingcrawlaiming = 1;
  self setanimlimited(scripts\anim\utility::lookupanim("crawl_death", "aim_4"), 1, 0);
  self setanimlimited(scripts\anim\utility::lookupanim("crawl_death", "aim_6"), 1, 0);
  var0 = 0;

  for(;;) {
    var1 = scripts\anim\utility_common::getyawtoenemy();
    var2 = angleclamp180(var1 - var0);

    if(abs(var2) > 3) {
      var2 = scripts\engine\utility::sign(var2) * 3;
    }

    var1 = angleclamp180(var0 + var2);

    if(var1 < 0) {
      if(var1 < -45) {
        var1 = -45;
      }

      var3 = var1 / -45;
      self setanim(%dying_back_aim_4_wrapper, var3, 0.05);
      self setanim(%dying_back_aim_6_wrapper, 0, 0.05);
    } else {
      if(var1 > 45) {
        var1 = 45;
      }

      var3 = var1 / 45;
      self setanim(%dying_back_aim_6_wrapper, var3, 0.05);
      self setanim(%dying_back_aim_4_wrapper, 0, 0.05);
    }

    var0 = var1;
    wait 0.05;
  }
}

function startdyingcrawlbackaimsoon() {
  self endon("kill_long_death");
  self endon("death");
  wait 0.5;
  thread dyingcrawlbackaim();
}

function handlebackcrawlnotetracks(var0) {
  if(var0 == "fire_spray") {
    if(!scripts\anim\utility_common::canseeenemy()) {
      return true;
    }

    if(!aimedsomewhatatenemy()) {
      return true;
    }

    scripts\anim\utility_common::shootenemywrapper();
    return true;
  } else if(var0 == "pistol_pickup") {
    thread startdyingcrawlbackaimsoon();
    return false;
  }

  return false;
}

function aimedsomewhatatenemy() {
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

function enemyisingeneraldirection(var0) {
  if(!isDefined(self.enemy)) {
    return false;
  }

  var1 = vectorNormalize(self.enemy getshootatpos() - self getEye());
  return vectordot(var1, var0) > 0.5;
}

function preventpainforashorttime(var0) {
  self endon("kill_long_death");
  self endon("death");
  self.flashbangimmunity = 1;
  self.longdeathstarting = 1;
  self.a.doinglongdeath = 1;
  self notify("long_death");
  self.health = 10000;
  self.threatbias -= 2000;
  wait 0.75;

  if(self.health > 1) {
    self.health = 1;
  }

  wait 0.05;
  self.longdeathstarting = undefined;
  self.a.mayonlydie = 1;

  if(var0 == "crawling") {
    wait 1;

    if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 1048576) {
      anim.numdeathsuntilcrawlingpain = randomintrange(10, 30);
      anim.nextcrawlingpaintime = gettime() + randomintrange(15000, 60000);
    } else {
      anim.numdeathsuntilcrawlingpain = randomintrange(5, 12);
      anim.nextcrawlingpaintime = gettime() + randomintrange(5000, 25000);
    }

    anim.nextcrawlingpaintimefromlegdamage = gettime() + randomintrange(7000, 13000);
    return;
  }

  if(var0 == "corner_grenade") {
    wait 1;

    if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 490000) {
      anim.numdeathsuntilcornergrenadedeath = randomintrange(10, 30);
      anim.nextcornergrenadedeathtime = gettime() + randomintrange(15000, 60000);
      return;
    }

    anim.numdeathsuntilcornergrenadedeath = randomintrange(5, 12);
    anim.nextcornergrenadedeathtime = gettime() + randomintrange(5000, 25000);
    return;
  }
}

function decidenumcrawls() {
  if(isDefined(self.a.force_num_crawls)) {
    self.a.numcrawls = self.a.force_num_crawls;
    return;
  }

  self.a.numcrawls = randomintrange(1, 5);
}

function shouldkeepcrawling() {
  if(!self.a.numcrawls) {
    self.a.numcrawls = undefined;
    return false;
  }

  self.a.numcrawls--;
  return true;
}

function trycornerrightgrenadedeath() {
  if(anim.numdeathsuntilcornergrenadedeath > 0) {
    return false;
  }

  if(gettime() < anim.nextcornergrenadedeathtime) {
    return false;
  }

  if(self.a.disablelongdeath || self.diequietly || self.damageshield) {
    return false;
  }

  if(isDefined(self.deathfunction)) {
    return false;
  }

  if(distance(self.origin, level.player.origin) < 175) {
    return false;
  }

  anim.nextcornergrenadedeathtime = gettime() + 3000;
  thread cornerrightgrenadedeath();
  self waittill("killanimscript");
  return true;
}

function cornerrightgrenadedeath() {
  self endon("kill_long_death");
  self endon("death");
  thread paindeathnotify();
  thread preventpainforashorttime("corner_grenade");
  thread scripts\engine\sp\utility::set_battlechatter(0);
  self.threatbias = -1000;
  pain_setflaggedanimknoballrestart("corner_grenade_pain", scripts\anim\utility::lookupanim("corner_grenade_death", "pain"), %body, 1, 0.1);
  self waittillmatch("corner_grenade_pain", "dropgun");
  scripts\anim\shared::dropallaiweapons();
  self waittillmatch("corner_grenade_pain", "anim_pose = \"back\"");
  scripts\anim\notetracks_sp::notetrackposeback();
  self waittillmatch("corner_grenade_pain", "grenade_left");
  var0 = getweaponmodel("fraggrenade");
  self attach(var0, "tag_inhand");
  self.deathfunction = &prematurecornergrenadedeath;
  self waittillmatch("corner_grenade_pain", "end");
  var1 = gettime() + randomintrange(25000, 60000);
  pain_setflaggedanimknoballrestart("corner_grenade_idle", scripts\anim\utility::lookupanim("corner_grenade_death", "pain"), %body, 1, 0.2);
  thread watchenemyvelocity();

  while(!enemyisapproaching()) {
    if(gettime() >= var1) {
      break;
    }

    scripts\anim\notetracks::donotetracksfortime(0.1, "corner_grenade_idle");
  }

  var2 = scripts\anim\utility::lookupanim("corner_grenade_death", "release");
  pain_setflaggedanimknoballrestart("corner_grenade_release", var2, %body, 1, 0.2);
  var3 = getnotetracktimes(var2, "grenade_drop");
  var4 = var3[0] * getanimlength(var2);
  wait var4 - 1;
  scripts\anim\death::playdeathsound();
  wait 0.7;
  self.deathfunction = &waittillgrenadedrops;
  var5 = (0, 0, 30) - anglestoright(self.angles) * 70;
  cornerdeathreleasegrenade(var5, randomfloatrange(2, 3));
  wait 0.05;
  self detach(var0, "tag_inhand");
  thread killself();
}

function cornerdeathreleasegrenade(var0, var1) {
  var2 = self gettagorigin("tag_inhand");
  var3 = var2 + (0, 0, 20);
  var4 = var2 - (0, 0, 20);
  var5 = scripts\engine\trace::_bullet_trace(var3, var4, 0, undefined);

  if(var5["fraction"] < 0.5) {
    var2 = var5["position"];
  }

  var6 = "default";

  if(var5["surfacetype"] != "none") {
    var6 = var5["surfacetype"];
  }

  thread playsoundatpoint("grenade_bounce_med", var2);
  self.grenadeweapon = getcompleteweaponname("fraggrenade");
  self magicgrenademanual(var2, var0, var1);
}

function playsoundatpoint(var0, var1) {
  var2 = spawn("script_origin", var1);
  var2 playSound(var0, "sounddone");
  var2 waittill("sounddone");
  var2 delete();
}

function killself() {
  self.a.nodeath = 1;
  killwrapper();
  self startragdoll();
  wait 0.1;
  self notify("grenade_drop_done");
}

function killwrapper() {
  if(isDefined(self.last_dmg_player)) {
    self kill(self.origin, self.last_dmg_player);
    return;
  }

  self kill();
}

function enemyisapproaching() {
  if(!isDefined(self.enemy)) {
    return false;
  }

  if(distancesquared(self.origin, self.enemy.origin) > 147456) {
    return false;
  }

  if(distancesquared(self.origin, self.enemy.origin) < 16384) {
    return true;
  }

  var0 = self.enemy.origin + self.enemyvelocity * 3;
  var1 = self.enemy.origin;

  if(self.enemy.origin != var0) {
    var1 = pointonsegmentnearesttopoint(self.enemy.origin, var0, self.origin);
  }

  if(distancesquared(self.origin, var1) < 16384) {
    return true;
  }

  return false;
}

function prematurecornergrenadedeath() {
  var0 = scripts\anim\utility::lookupanim("corner_grenade_death", "premature_death");
  var1 = var0[randomint(var0.size)];
  scripts\anim\death::playdeathsound();
  pain_setflaggedanimknoballrestart("corner_grenade_die", var1, %body, 1, 0.2);
  var2 = scripts\anim\combat_utility::getgrenadedropvelocity();
  cornerdeathreleasegrenade(var2, 3);
  var3 = getweaponmodel("fraggrenade");
  self detach(var3, "tag_inhand");
  wait 0.05;
  self startragdoll();
  self waittillmatch("corner_grenade_die", "end");
}

function waittillgrenadedrops() {
  self waittill("grenade_drop_done");
}

function watchenemyvelocity() {
  self endon("kill_long_death");
  self endon("death");
  self.enemyvelocity = (0, 0, 0);
  var0 = undefined;
  var1 = self.origin;
  var2 = 0.15;

  for(;;) {
    if(isDefined(self.enemy) && isDefined(var0) && self.enemy == var0) {
      var3 = self.enemy.origin;
      self.enemyvelocity = (var3 - var1) * 1 / var2;
      var1 = var3;
    } else {
      if(isDefined(self.enemy)) {
        var1 = self.enemy.origin;
      } else {
        var1 = self.origin;
      }

      var0 = self.enemy;
      self.shootentvelocity = (0, 0, 0);
    }

    wait var2;
  }
}

function additive_pain(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.doingadditivepain)) {
    return;
  }

  if(var0 < self.minpaindamage) {
    return;
  }

  self.doingadditivepain = 1;
  var7 = undefined;

  if(scripts\engine\utility::damagelocationisany("left_arm_lower", "left_arm_upper", "left_hand")) {
    var7 = scripts\anim\utility::lookupanim("additive_pain", "left_arm");
  }

  if(scripts\engine\utility::damagelocationisany("right_arm_lower", "right_arm_upper", "right_hand")) {
    var7 = scripts\anim\utility::lookupanim("additive_pain", "right_arm");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var7 = scripts\anim\utility::lookupanim("additive_pain", "left_leg");
  } else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var7 = scripts\anim\utility::lookupanim("additive_pain", "right_leg");
  } else {
    var8 = scripts\anim\utility::lookupanim("additive_pain", "default");
    var7 = var8[randomint(var8.size)];
  }

  self setanimlimited(%add_pain, 1, 0.1, 1);
  self setanimlimited(var7, 1, 0, 1);
  wait 0.4;
  self clearanim(var7, 0.2);
  self clearanim(%add_pain, 0.2);
  self.doingadditivepain = undefined;
}

function pain_setflaggedanimknob(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 0.2;
  }

  if(!isDefined(var4)) {
    var4 = 1;
  }

  self setflaggedanimknob(var0, var1, var2, var3, var4);
  self.facialanimidx = scripts\anim\face::playfacialanim(var1, "pain", self.facialanimidx);
}

function pain_setflaggedanimknobrestart(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 0.2;
  }

  if(!isDefined(var4)) {
    var4 = 1;
  }

  self setflaggedanimknobrestart(var0, var1, var2, var3, var4);
  self.facialanimidx = scripts\anim\face::playfacialanim(var1, "pain", self.facialanimidx);
}

function pain_setflaggedanimknoballrestart(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var4)) {
    var4 = 0.2;
  }

  if(!isDefined(var5)) {
    var5 = 1;
  }

  self setflaggedanimknoballrestart(var0, var1, var2, var3, var4, var5);
  self.facialanimidx = scripts\anim\face::playfacialanim(var1, "pain", self.facialanimidx);
}