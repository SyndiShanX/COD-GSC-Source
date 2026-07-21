/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\pain.gsc
***********************************************/

init_animset_pain() {}

main() {
  self endon("killanimscript");
  scripts\asm\asm_sp::paininternal();
}

initpainfx() {
  level._effect["crawling_death_blood_smear"] = loadfx("vfx/core/impacts/blood_smear_decal.vfx");
}

getdamageshieldpainanim() {
  if(self.currentpose == "prone") {
    return;
  }
  if(isDefined(self.lastattacker) && isDefined(self.lastattacker.team) && self.lastattacker.team == self.team) {
    return;
  }
  if(!isDefined(self.damageshieldcounter) || gettime() - self.a.lastpaintime > 1500)
    self.damageshieldcounter = randomintrange(2, 3);

  if(isDefined(self.lastattacker) && distancesquared(self.origin, self.lastattacker.origin) < squared(512))
    self.damageshieldcounter = 0;

  if(self.damageshieldcounter > 0)
    self.damageshieldcounter--;
  else {
    self.damageshieldpain = 1;
    self.allowpain = 0;

    if(self.ignoreme)
      self.predamageshieldignoreme = 1;
    else
      self.ignoreme = 1;

    if(scripts\anim\utility_common.gsc::isusingsidearm())
      scripts\anim\shared.gsc::placeweaponon(self.primaryweapon, "right");

    if(self.currentpose == "crouch")
      return scripts\anim\utility.gsc::lookupanim("pain", "damage_shield_crouch");

    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "damage_shield_pain_array");
  }
}

getpainanim() {
  if(self.damageshield && !isDefined(self.disabledamageshieldpain)) {
    var_0 = getdamageshieldpainanim();

    if(isDefined(var_0))
      return var_0;
  }

  if(isDefined(self.a.onback)) {
    if(self.currentpose == "crouch")
      return scripts\anim\utility.gsc::lookupanim("pain", "back");
    else
      scripts\anim\utility.gsc::stoponback();
  }

  if(self.currentpose == "stand") {
    var_1 = isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 4096;

    if(!var_1 && self.a.movement == "run" && abs(self getmotionangle()) < 60)
      return getrunningforwardpainanim();

    self.a.movement = "stop";
    return getstandpainanim();
  } else if(self.currentpose == "crouch") {
    self.a.movement = "stop";
    return getcrouchpainanim();
  } else if(self.currentpose == "prone") {
    self.a.movement = "stop";
    return getpronepainanim();
  }
}

getrunningforwardpainanim() {
  var_0 = [];
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  if(self maymovetopoint(self localtoworldcoords((300, 0, 0)))) {
    var_2 = 1;
    var_1 = 1;
  } else if(self maymovetopoint(self localtoworldcoords((200, 0, 0))))
    var_1 = 1;

  if(isDefined(self.a.disablelongpain)) {
    var_2 = 0;
    var_1 = 0;
  }

  if(var_2)
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "run_long");
  else if(var_1)
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "run_medium");
  else if(self maymovetopoint(self localtoworldcoords((120, 0, 0))))
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "run_short");

  if(!var_0.size) {
    self.a.movement = "stop";
    return getstandpainanim();
  }

  return var_0[randomint(var_0.size)];
}

getstandpistolpainanim() {
  var_0 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper"))
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "pistol_torso_upper");
  else if(scripts\engine\utility::damagelocationisany("torso_lower"))
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "pistol_torso_lower");
  else if(scripts\engine\utility::damagelocationisany("neck"))
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "pistol_neck");
  else if(scripts\engine\utility::damagelocationisany("head"))
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "pistol_head");
  else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "right_leg_upper"))
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "pistol_leg");
  else if(scripts\engine\utility::damagelocationisany("left_arm_upper"))
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "pistol_left_arm_upper");
  else if(scripts\engine\utility::damagelocationisany("left_arm_lower"))
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "pistol_left_arm_lower");
  else if(scripts\engine\utility::damagelocationisany("right_arm_upper"))
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "pistol_right_arm_upper");
  else if(scripts\engine\utility::damagelocationisany("right_arm_lower"))
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "pistol_right_arm_lower");

  if(var_0.size < 2)
    var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("pain", "pistol_default1"));

  if(var_0.size < 2)
    var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("pain", "pistol_default2"));

  return var_0[randomint(var_0.size)];
}

getstandpainanim() {
  if(scripts\anim\utility_common.gsc::isusingsidearm())
    return getstandpistolpainanim();

  var_0 = [];
  var_1 = [];

  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "torso_upper");
    var_1 = scripts\anim\utility.gsc::lookupanim("pain", "torso_upper_extended");
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "torso_lower");
    var_1 = scripts\anim\utility.gsc::lookupanim("pain", "torso_lower_extended");
  } else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "head");
    var_1 = scripts\anim\utility.gsc::lookupanim("pain", "head_extended");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "right_arm");
    var_1 = scripts\anim\utility.gsc::lookupanim("pain", "right_arm_extended");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower")) {
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "left_arm");
    var_1 = scripts\anim\utility.gsc::lookupanim("pain", "left_arm_extended");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "right_leg_upper")) {
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "leg");
    var_1 = scripts\anim\utility.gsc::lookupanim("pain", "leg_extended");
  } else if(scripts\engine\utility::damagelocationisany("left_foot", "right_foot", "left_leg_lower", "right_leg_lower")) {
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "foot");
    var_1 = scripts\anim\utility.gsc::lookupanim("pain", "foot_extended");
  }

  if(var_0.size < 2) {
    if(!self.a.disablelongdeath)
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("pain", "default_long"));
    else
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("pain", "default_short"));
  }

  if(var_1.size < 2)
    var_1 = scripts\engine\utility::array_combine(var_1, scripts\anim\utility.gsc::lookupanim("pain", "default_extended"));

  if(!self.damageshield && !self.a.disablelongdeath) {
    var_2 = randomint(var_0.size + var_1.size);

    if(var_2 < var_0.size)
      return var_0[var_2];
    else
      return var_1[var_2 - var_0.size];
  }

  return var_0[randomint(var_0.size)];
}

getcrouchpainanim() {
  var_0 = [];

  if(!self.damageshield && !self.a.disablelongdeath)
    var_0 = scripts\anim\utility.gsc::lookupanim("pain", "crouch_longdeath");

  var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("pain", "crouch_default"));

  if(scripts\engine\utility::damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper"))
    var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("pain", "crouch_left_arm"));

  if(scripts\engine\utility::damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper"))
    var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("pain", "crouch_right_arm"));

  return var_0[randomint(var_0.size)];
}

getpronepainanim() {
  var_0 = scripts\anim\utility.gsc::lookupanim("pain", "prone");
  return var_0[randomint(var_0.size)];
}

#using_animtree("generic_human");

playpainanim(var_0) {
  var_1 = 1;
  pain_setflaggedanimknoballrestart("painanim", var_0, %body, 1, 0.1, var_1);

  if(self.currentpose == "prone")
    self updateprone(%prone_legs_up, %prone_legs_down, 1, 0.1, 1);

  if(animhasnotetrack(var_0, "start_aim")) {
    thread notifystartaim("painanim");
    self endon("start_aim");
  }

  if(animhasnotetrack(var_0, "code_move"))
    scripts\anim\notetracks.gsc::donotetracks("painanim");

  scripts\anim\notetracks.gsc::donotetracks("painanim");
}

notifystartaim(var_0) {
  self endon("killanimscript");
  self waittillmatch(var_0, "start_aim");
  self notify("start_aim");
}

specialpainblocker() {
  self endon("killanimscript");
  self.blockingpain = 1;
  self.allowpain = 0;
  wait 0.5;
  self.blockingpain = undefined;
  self.allowpain = 1;
}

specialpain(var_0) {
  if(var_0 == "none")
    return 0;

  self.a.special = "none";
  thread specialpainblocker();

  switch (var_0) {
    case "cover_left":
      if(self.currentpose == "stand") {
        var_1 = scripts\anim\utility.gsc::lookupanim("pain", "cover_left_stand");
        dopainfromarray(var_1);
        var_2 = 1;
      } else if(self.currentpose == "crouch") {
        var_1 = scripts\anim\utility.gsc::lookupanim("pain", "cover_left_crouch");
        dopainfromarray(var_1);
        var_2 = 1;
      } else
        var_2 = 0;

      break;
    case "cover_right":
      if(self.currentpose == "stand") {
        var_1 = scripts\anim\utility.gsc::lookupanim("pain", "cover_right_stand");
        dopainfromarray(var_1);
        var_2 = 1;
      } else if(self.currentpose == "crouch") {
        var_1 = scripts\anim\utility.gsc::lookupanim("pain", "cover_right_crouch");
        dopainfromarray(var_1);
        var_2 = 1;
      } else
        var_2 = 0;

      break;
    case "cover_right_stand_A":
      var_2 = 0;
      break;
    case "cover_right_stand_B":
      dopain(scripts\anim\utility.gsc::lookupanim("pain", "cover_right_stand_B"));
      var_2 = 1;
      break;
    case "cover_left_stand_A":
      dopain(scripts\anim\utility.gsc::lookupanim("pain", "cover_left_stand_A"));
      var_2 = 1;
      break;
    case "cover_left_stand_B":
      dopain(scripts\anim\utility.gsc::lookupanim("pain", "cover_left_stand_B"));
      var_2 = 1;
      break;
    case "cover_crouch":
      var_1 = scripts\anim\utility.gsc::lookupanim("pain", "cover_crouch");
      dopainfromarray(var_1);
      var_2 = 1;
      break;
    case "cover_stand":
      var_1 = scripts\anim\utility.gsc::lookupanim("pain", "cover_stand");
      dopainfromarray(var_1);
      var_2 = 1;
      break;
    case "cover_stand_aim":
      var_1 = scripts\anim\utility.gsc::lookupanim("pain", "cover_stand_aim");
      dopainfromarray(var_1);
      var_2 = 1;
      break;
    case "cover_crouch_aim":
      var_1 = scripts\anim\utility.gsc::lookupanim("pain", "cover_crouch_aim");
      dopainfromarray(var_1);
      var_2 = 1;
      break;
    case "saw":
      if(self.currentpose == "stand")
        var_3 = scripts\anim\utility.gsc::lookupanim("pain", "saw_stand");
      else if(self.currentpose == "crouch")
        var_3 = scripts\anim\utility.gsc::lookupanim("pain", "saw_crouch");
      else
        var_3 = scripts\anim\utility.gsc::lookupanim("pain", "saw_prone");

      pain_setflaggedanimknob("painanim", var_3, 1, 0.3, 1);
      scripts\anim\notetracks.gsc::donotetracks("painanim");
      var_2 = 1;
      break;
    case "mg42":
      mg42pain(self.currentpose);
      var_2 = 1;
      break;
    case "minigun":
      var_2 = 0;
      break;
    case "corner_right_martyrdom":
      var_2 = trycornerrightgrenadedeath();
      break;
    case "rambo":
    case "rambo_right":
    case "rambo_left":
    case "dying_crawl":
      var_2 = 0;
      break;
    default:
      var_2 = 0;
  }

  return var_2;
}

paindeathnotify() {
  self endon("death");
  wait 0.05;
  self notify("pain_death");
}

dopainfromarray(var_0) {
  var_1 = var_0[randomint(var_0.size)];
  pain_setflaggedanimknob("painanim", var_1, 1, 0.3, 1);
  scripts\anim\notetracks.gsc::donotetracks("painanim");
}

dopain(var_0) {
  pain_setflaggedanimknob("painanim", var_0, 1, 0.3, 1);
  scripts\anim\notetracks.gsc::donotetracks("painanim");
}

mg42pain(var_0) {
  pain_setflaggedanimknob("painanim", level.mg_animmg["pain_" + var_0], 1, 0.1, 1);
  scripts\anim\notetracks.gsc::donotetracks("painanim");
}

waitsetstop(var_0, var_1) {
  self endon("killanimscript");
  self endon("death");

  if(isDefined(var_1))
    self endon(var_1);

  wait(var_0);
  self.a.movement = "stop";
}

crawlingpain() {
  if(self.a.disablelongdeath || self.diequietly || self.damageshield)
    return 0;

  if(self.stairsstate != "none")
    return 0;

  if(isDefined(self.a.onback))
    return 0;

  var_0 = scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot");

  if(isDefined(self.forcelongdeath)) {
    setcrawlingpaintransanim(var_0);
    self.health = 10;
    thread crawlingpistol();
    self waittill("killanimscript");
    return 1;
  }

  if(self.health > 100)
    return 0;

  if(!isDefined(self.forcelongdeath) || !self.forcelongdeath) {
    if(var_0 && self.health < self.maxhealth * 0.4) {
      if(gettime() < anim.nextcrawlingpaintimefromlegdamage)
        return 0;
    } else {
      if(anim.numdeathsuntilcrawlingpain > 0)
        return 0;

      if(gettime() < anim.nextcrawlingpaintime)
        return 0;
    }
  }

  if(isDefined(self.deathfunction))
    return 0;

  foreach(var_2 in level.players) {
    if(distancesquared(self.origin, var_2.origin) < 30625)
      return 0;
  }

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "gun", "right_hand", "left_hand"))
    return 0;

  if(scripts\anim\utility_common.gsc::isusingsidearm())
    return 0;

  setcrawlingpaintransanim(var_0);

  if(!isDefined(self.a.stumblingpainanimseq) && !iscrawldeltaallowed(self.a.crawlingpaintransanim))
    return 0;

  anim.nextcrawlingpaintime = gettime() + 3000;
  anim.nextcrawlingpaintimefromlegdamage = gettime() + 3000;
  thread crawlingpistol();
  self waittill("killanimscript");
  return 1;
}

setcrawlingpaintransanim(var_0) {
  var_1 = [];
  var_2 = undefined;

  if(self.currentpose == "stand") {
    var_2 = shouldattemptstumblingpain(var_0);

    if(isDefined(var_2))
      var_1 = [var_2[0]];
    else
      var_1 = scripts\anim\utility.gsc::lookupanim("crawl_death", "stand_transition");
  } else if(self.currentpose == "crouch")
    var_1 = scripts\anim\utility.gsc::lookupanim("crawl_death", "crouch_transition");
  else
    var_1 = scripts\anim\utility.gsc::lookupanim("crawl_death", "prone_transition");

  self.a.crawlingpaintransanim = var_1[randomint(var_1.size)];
  self.a.stumblingpainanimseq = var_2;
}

iscrawldeltaallowed(var_0) {
  if(isDefined(self.a.force_num_crawls))
    return 1;

  var_1 = getmovedelta(var_0, 0, 1);
  var_2 = self localtoworldcoords(var_1);
  return self maymovetopoint(var_2);
}

crawlingpistol() {
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
  scripts\anim\notetracks.gsc::donotetracksintercept("transition", ::handlebackcrawlnotetracks);
  self.a.special = "dying_crawl";
  thread dyingcrawlbackaim();

  if(isDefined(self.enemy))
    self setlookatentity(self.enemy);

  decidenumcrawls();

  while(shouldkeepcrawling()) {
    var_0 = scripts\anim\utility.gsc::lookupanim("crawl_death", "back_crawl");

    if(!iscrawldeltaallowed(var_0)) {
      break;
    }

    pain_setflaggedanimknobrestart("back_crawl", var_0, 1, 0.1, 1.0);
    scripts\anim\notetracks.gsc::donotetracksintercept("back_crawl", ::handlebackcrawlnotetracks);
  }

  self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);

  while(shouldstayalive()) {
    if(scripts\anim\utility_common.gsc::canseeenemy() && aimedsomewhatatenemy()) {
      var_1 = scripts\anim\utility.gsc::lookupanim("crawl_death", "back_fire");
      pain_setflaggedanimknobrestart("back_idle_or_fire", var_1, 1, 0.2, 1.0);
      scripts\anim\notetracks.gsc::donotetracks("back_idle_or_fire");
      continue;
    }

    var_1 = scripts\anim\utility.gsc::lookupanim("crawl_death", "back_idle");

    if(randomfloat(1) < 0.4) {
      var_2 = scripts\anim\utility.gsc::lookupanim("crawl_death", "back_idle_twitch");
      var_1 = var_2[randomint(var_2.size)];
    }

    pain_setflaggedanimknobrestart("back_idle_or_fire", var_1, 1, 0.1, 1.0);
    var_3 = getanimlength(var_1);

    while(var_3 > 0) {
      if(scripts\anim\utility_common.gsc::canseeenemy() && aimedsomewhatatenemy()) {
        break;
      }

      var_4 = 0.5;

      if(var_4 > var_3) {
        var_4 = var_3;
        var_3 = 0;
      } else
        var_3 = var_3 - var_4;

      scripts\anim\notetracks.gsc::donotetracksfortime(var_4, "back_idle_or_fire");
    }
  }

  self notify("end_dying_crawl_back_aim");
  self clearanim(%dying_back_aim_4_wrapper, 0.3);
  self clearanim(%dying_back_aim_6_wrapper, 0.3);
  var_5 = scripts\anim\utility.gsc::lookupanim("crawl_death", "back_death");
  self.deathanim = var_5[randomint(var_5.size)];
  killwrapper();
  self.a.special = "none";
  self.specialdeathfunc = undefined;
}

shouldattemptstumblingpain(var_0) {
  if(self.currentpose != "stand") {
    return;
  }
  var_1 = 2;

  if(randomint(10) > var_1) {
    return;
  }
  var_2 = 0;

  if(!var_0) {
    var_2 = scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower");

    if(!var_2)
      return;
  }

  var_3 = 0;
  var_4 = "leg";
  var_5 = "b";

  if(var_0)
    var_3 = 200;
  else {
    var_4 = "gut";
    var_3 = 128;

    if(45 < self.damageyaw && self.damageyaw < 135)
      var_5 = "l";
    else if(-135 < self.damageyaw && self.damageyaw < -45)
      var_5 = "r";
    else if(-45 < self.damageyaw && self.damageyaw < 45)
      return;
  }

  switch (var_5) {
    case "b":
      var_6 = anglesToForward(self.angles);
      var_7 = self.origin - var_6 * var_3;
      break;
    case "l":
      var_8 = anglestoright(self.angles);
      var_7 = self.origin - var_8 * var_3;
      break;
    case "r":
      var_8 = anglestoright(self.angles);
      var_7 = self.origin + var_8 * var_3;
      break;
    default:
      return;
  }

  if(!self maymovetopoint(var_7)) {
    return;
  }
  var_9 = scripts\anim\utility.gsc::lookupanim("crawl_death", "longdeath");
  var_10 = var_4 + "_" + var_5;
  var_11 = randomint(var_9[var_10].size);
  var_12 = var_9[var_10][var_11];
  return var_12;
}

stumblingpain() {
  pain_setflaggedanimknobrestart("stumblingPainInto", self.a.stumblingpainanimseq[0]);
  scripts\anim\notetracks.gsc::donotetracks("stumblingPainInto");
  self.a.special = "stumbling_pain";
  var_0 = getmovedelta(self.a.stumblingpainanimseq[2]);
  var_1 = getanimlength(self.a.stumblingpainanimseq[2]) * 1000;

  for(var_2 = randomint(2) + 1; var_2 > 0; var_2--) {
    var_3 = anglesToForward(self.angles);
    var_4 = self.origin + var_3 * var_0;

    if(!self maymovetopoint(var_4)) {
      break;
    }

    pain_setflaggedanimknobrestart("stumblingPain", self.a.stumblingpainanimseq[1]);
    scripts\anim\notetracks.gsc::donotetracks("stumblingPain");
  }

  self.a.nodeath = 1;
  self.a.special = "none";
  pain_setflaggedanimknobrestart("stumblingPainCollapse", self.a.stumblingpainanimseq[2], 1, 0.75);
  scripts\anim\notetracks.gsc::donotetracksintercept("stumblingPainCollapse", ::stumblingpainnotetrackhandler);
  scripts\anim\notetracks.gsc::donotetracks("stumblingPainCollapse");
  killwrapper();
}

stumblingpainnotetrackhandler(var_0) {
  if(var_0 == "start_ragdoll") {
    scripts\anim\notetracks.gsc::handlenotetrack(var_0, "stumblingPainCollapse");
    return 1;
  }
}

shouldstayalive() {
  if(!enemyisingeneraldirection(anglesToForward(self.angles)))
    return 0;

  return gettime() < self.desiredtimeofdeath;
}

dyingcrawl() {
  if(!isDefined(self.forcelongdeath)) {
    if(self.currentpose == "prone")
      return 1;

    if(self.a.movement == "stop") {
      if(randomfloat(1) < 0.4) {
        if(randomfloat(1) < 0.5)
          return 1;
      } else if(abs(self.damageyaw) > 90)
        return 1;
    } else if(abs(self getmotionangle()) > 90)
      return 1;
  }

  if(self.currentpose != "prone") {
    var_0 = scripts\anim\utility.gsc::lookupanim("crawl_death", self.currentpose + "_2_crawl");
    var_1 = var_0[randomint(var_0.size)];

    if(!iscrawldeltaallowed(var_1))
      return 1;

    thread dyingcrawlbloodsmear();
    pain_setflaggedanimknob("falling", var_1, 1, 0.5, 1);
    scripts\anim\notetracks.gsc::donotetracks("falling");
  } else
    thread dyingcrawlbloodsmear();

  self.a.crawlingpaintransanim = scripts\anim\utility.gsc::lookupanim("crawl_death", "default_transition");
  self.a.special = "dying_crawl";
  decidenumcrawls();
  var_2 = scripts\anim\utility.gsc::lookupanim("crawl_death", "crawl");

  while(shouldkeepcrawling()) {
    if(!iscrawldeltaallowed(var_2))
      return 1;

    if(isDefined(self.custom_crawl_sound))
      self playSound(self.custom_crawl_sound);

    pain_setflaggedanimknobrestart("crawling", var_2, 1, 0.1, 1.0);
    scripts\anim\notetracks.gsc::donotetracks("crawling");
  }

  self notify("done_crawling");

  if(!isDefined(self.forcelongdeath) && enemyisingeneraldirection(anglesToForward(self.angles) * -1))
    return 1;

  var_3 = scripts\anim\utility.gsc::lookupanim("crawl_death", "death");
  var_4 = var_3[randomint(var_3.size)];
  scripts\anim\death.gsc::playdeathanim(var_4);
  killwrapper();
  self.a.special = "none";
  self.specialdeathfunc = undefined;
  return 0;
}

dyingcrawlbloodsmear() {
  self endon("death");

  if(self.currentpose != "prone") {
    for(;;) {
      self waittill("falling", var_0);

      if(issubstr(var_0, "bodyfall")) {
        break;
      }
    }
  }

  var_1 = "J_SpineLower";
  var_2 = "tag_origin";
  var_3 = 0.25;
  var_4 = level._effect["crawling_death_blood_smear"];

  if(isDefined(self.a.crawl_fx_rate))
    var_3 = self.a.crawl_fx_rate;

  if(isDefined(self.a.crawl_fx))
    var_4 = level._effect[self.a.crawl_fx];

  while(var_3) {
    var_5 = self gettagorigin(var_1);
    var_6 = self gettagangles(var_2);
    var_7 = anglestoright(var_6);
    var_8 = anglesToForward((270, 0, 0));
    playFX(var_4, var_5, var_8, var_7);
    wait(var_3);
  }
}

dyingcrawlbackaim() {
  self endon("kill_long_death");
  self endon("death");
  self endon("end_dying_crawl_back_aim");

  if(isDefined(self.dyingcrawlaiming)) {
    return;
  }
  self.dyingcrawlaiming = 1;
  self setanimlimited(scripts\anim\utility.gsc::lookupanim("crawl_death", "aim_4"), 1, 0);
  self setanimlimited(scripts\anim\utility.gsc::lookupanim("crawl_death", "aim_6"), 1, 0);
  var_0 = 0;

  for(;;) {
    var_1 = scripts\anim\utility_common.gsc::getyawtoenemy();
    var_2 = angleclamp180(var_1 - var_0);

    if(abs(var_2) > 3)
      var_2 = scripts\engine\utility::sign(var_2) * 3;

    var_1 = angleclamp180(var_0 + var_2);

    if(var_1 < 0) {
      if(var_1 < -45.0)
        var_1 = -45.0;

      var_3 = var_1 / -45.0;
      self setanim(%dying_back_aim_4_wrapper, var_3, 0.05);
      self setanim(%dying_back_aim_6_wrapper, 0, 0.05);
    } else {
      if(var_1 > 45.0)
        var_1 = 45.0;

      var_3 = var_1 / 45.0;
      self setanim(%dying_back_aim_6_wrapper, var_3, 0.05);
      self setanim(%dying_back_aim_4_wrapper, 0, 0.05);
    }

    var_0 = var_1;
    wait 0.05;
  }
}

startdyingcrawlbackaimsoon() {
  self endon("kill_long_death");
  self endon("death");
  wait 0.5;
  thread dyingcrawlbackaim();
}

handlebackcrawlnotetracks(var_0) {
  if(var_0 == "fire_spray") {
    if(!scripts\anim\utility_common.gsc::canseeenemy())
      return 1;

    if(!aimedsomewhatatenemy())
      return 1;

    scripts\anim\utility_common.gsc::shootenemywrapper();
    return 1;
  } else if(var_0 == "pistol_pickup") {
    thread startdyingcrawlbackaimsoon();
    return 0;
  }

  return 0;
}

aimedsomewhatatenemy() {
  var_0 = self.enemy getshootatpos();
  var_1 = self getmuzzleangle();
  var_2 = vectortoangles(var_0 - self getmuzzlepos());
  var_3 = scripts\engine\utility::absangleclamp180(var_1[1] - var_2[1]);

  if(var_3 > anim.painyawdifffartolerance) {
    if(distancesquared(self getEye(), var_0) > anim.painyawdiffclosedistsq || var_3 > anim.painyawdiffclosetolerance)
      return 0;
  }

  return scripts\engine\utility::absangleclamp180(var_1[0] - var_2[0]) <= anim.painpitchdifftolerance;
}

enemyisingeneraldirection(var_0) {
  if(!isDefined(self.enemy))
    return 0;

  var_1 = vectorNormalize(self.enemy getshootatpos() - self getEye());
  return vectordot(var_1, var_0) > 0.5;
}

preventpainforashorttime(var_0) {
  self endon("kill_long_death");
  self endon("death");
  self.flashbangimmunity = 1;
  self.longdeathstarting = 1;
  self.a.doinglongdeath = 1;
  self notify("long_death");
  self.health = 10000;
  self.threatbias = self.threatbias - 2000;
  wait 0.75;

  if(self.health > 1)
    self.health = 1;

  wait 0.05;
  self.longdeathstarting = undefined;
  self.a.mayonlydie = 1;

  if(var_0 == "crawling") {
    wait 1.0;

    if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 1048576) {
      anim.numdeathsuntilcrawlingpain = randomintrange(10, 30);
      anim.nextcrawlingpaintime = gettime() + randomintrange(15000, 60000);
    } else {
      anim.numdeathsuntilcrawlingpain = randomintrange(5, 12);
      anim.nextcrawlingpaintime = gettime() + randomintrange(5000, 25000);
    }

    anim.nextcrawlingpaintimefromlegdamage = gettime() + randomintrange(7000, 13000);
  } else if(var_0 == "corner_grenade") {
    wait 1.0;

    if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 490000) {
      anim.numdeathsuntilcornergrenadedeath = randomintrange(10, 30);
      anim.nextcornergrenadedeathtime = gettime() + randomintrange(15000, 60000);
    } else {
      anim.numdeathsuntilcornergrenadedeath = randomintrange(5, 12);
      anim.nextcornergrenadedeathtime = gettime() + randomintrange(5000, 25000);
    }
  }
}

decidenumcrawls() {
  if(isDefined(self.a.force_num_crawls))
    self.a.numcrawls = self.a.force_num_crawls;
  else
    self.a.numcrawls = randomintrange(1, 5);
}

shouldkeepcrawling() {
  if(!self.a.numcrawls) {
    self.a.numcrawls = undefined;
    return 0;
  }

  self.a.numcrawls--;
  return 1;
}

trycornerrightgrenadedeath() {
  if(anim.numdeathsuntilcornergrenadedeath > 0)
    return 0;

  if(gettime() < anim.nextcornergrenadedeathtime)
    return 0;

  if(self.a.disablelongdeath || self.diequietly || self.damageshield)
    return 0;

  if(isDefined(self.deathfunction))
    return 0;

  if(distance(self.origin, level.player.origin) < 175)
    return 0;

  anim.nextcornergrenadedeathtime = gettime() + 3000;
  thread cornerrightgrenadedeath();
  self waittill("killanimscript");
  return 1;
}

cornerrightgrenadedeath() {
  self endon("kill_long_death");
  self endon("death");
  thread paindeathnotify();
  thread preventpainforashorttime("corner_grenade");
  thread scripts\engine\sp\utility::set_battlechatter(0);
  self.threatbias = -1000;
  pain_setflaggedanimknoballrestart("corner_grenade_pain", scripts\anim\utility.gsc::lookupanim("corner_grenade_death", "pain"), %body, 1, 0.1);
  self waittillmatch("corner_grenade_pain", "dropgun");
  scripts\anim\shared.gsc::dropallaiweapons();
  self waittillmatch("corner_grenade_pain", "anim_pose = \"back\"");
  scripts\anim\notetracks_sp.gsc::notetrackposeback();
  self waittillmatch("corner_grenade_pain", "grenade_left");
  var_0 = getweaponmodel("fraggrenade");
  self attach(var_0, "tag_inhand");
  self.deathfunction = ::prematurecornergrenadedeath;
  self waittillmatch("corner_grenade_pain", "end");
  var_1 = gettime() + randomintrange(25000, 60000);
  pain_setflaggedanimknoballrestart("corner_grenade_idle", scripts\anim\utility.gsc::lookupanim("corner_grenade_death", "pain"), %body, 1, 0.2);
  thread watchenemyvelocity();

  while(!enemyisapproaching()) {
    if(gettime() >= var_1) {
      break;
    }

    scripts\anim\notetracks.gsc::donotetracksfortime(0.1, "corner_grenade_idle");
  }

  var_2 = scripts\anim\utility.gsc::lookupanim("corner_grenade_death", "release");
  pain_setflaggedanimknoballrestart("corner_grenade_release", var_2, %body, 1, 0.2);
  var_3 = getnotetracktimes(var_2, "grenade_drop");
  var_4 = var_3[0] * getanimlength(var_2);
  wait(var_4 - 1.0);
  scripts\anim\death.gsc::playdeathsound();
  wait 0.7;
  self.deathfunction = ::waittillgrenadedrops;
  var_5 = (0, 0, 30) - anglestoright(self.angles) * 70;
  cornerdeathreleasegrenade(var_5, randomfloatrange(2.0, 3.0));
  wait 0.05;
  self detach(var_0, "tag_inhand");
  thread killself();
}

cornerdeathreleasegrenade(var_0, var_1) {
  var_2 = self gettagorigin("tag_inhand");
  var_3 = var_2 + (0, 0, 20);
  var_4 = var_2 - (0, 0, 20);
  var_5 = scripts\engine\trace::_bullet_trace(var_3, var_4, 0, undefined);

  if(var_5["fraction"] < 0.5)
    var_2 = var_5["position"];

  var_6 = "default";

  if(var_5["surfacetype"] != "none")
    var_6 = var_5["surfacetype"];

  thread playsoundatpoint("grenade_bounce_med", var_2);
  self.grenadeweapon = getcompleteweaponname("fraggrenade");
  self magicgrenademanual(var_2, var_0, var_1);
}

playsoundatpoint(var_0, var_1) {
  var_2 = spawn("script_origin", var_1);
  var_2 playSound(var_0, "sounddone");
  var_2 waittill("sounddone");
  var_2 delete();
}

killself() {
  self.a.nodeath = 1;
  killwrapper();
  self startragdoll();
  wait 0.1;
  self notify("grenade_drop_done");
}

killwrapper() {
  if(isDefined(self.last_dmg_player))
    self kill(self.origin, self.last_dmg_player);
  else
    self kill();
}

enemyisapproaching() {
  if(!isDefined(self.enemy))
    return 0;

  if(distancesquared(self.origin, self.enemy.origin) > 147456)
    return 0;

  if(distancesquared(self.origin, self.enemy.origin) < 16384)
    return 1;

  var_0 = self.enemy.origin + self.enemyvelocity * 3.0;
  var_1 = self.enemy.origin;

  if(self.enemy.origin != var_0)
    var_1 = pointonsegmentnearesttopoint(self.enemy.origin, var_0, self.origin);

  if(distancesquared(self.origin, var_1) < 16384)
    return 1;

  return 0;
}

prematurecornergrenadedeath() {
  var_0 = scripts\anim\utility.gsc::lookupanim("corner_grenade_death", "premature_death");
  var_1 = var_0[randomint(var_0.size)];
  scripts\anim\death.gsc::playdeathsound();
  pain_setflaggedanimknoballrestart("corner_grenade_die", var_1, %body, 1, 0.2);
  var_2 = scripts\anim\combat_utility.gsc::getgrenadedropvelocity();
  cornerdeathreleasegrenade(var_2, 3.0);
  var_3 = getweaponmodel("fraggrenade");
  self detach(var_3, "tag_inhand");
  wait 0.05;
  self startragdoll();
  self waittillmatch("corner_grenade_die", "end");
}

waittillgrenadedrops() {
  self waittill("grenade_drop_done");
}

watchenemyvelocity() {
  self endon("kill_long_death");
  self endon("death");
  self.enemyvelocity = (0, 0, 0);
  var_0 = undefined;
  var_1 = self.origin;
  var_2 = 0.15;

  for(;;) {
    if(isDefined(self.enemy) && isDefined(var_0) && self.enemy == var_0) {
      var_3 = self.enemy.origin;
      self.enemyvelocity = (var_3 - var_1) * (1 / var_2);
      var_1 = var_3;
    } else {
      if(isDefined(self.enemy))
        var_1 = self.enemy.origin;
      else
        var_1 = self.origin;

      var_0 = self.enemy;
      self.shootentvelocity = (0, 0, 0);
    }

    wait(var_2);
  }
}

additive_pain(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.doingadditivepain)) {
    return;
  }
  if(var_0 < self.minpaindamage) {
    return;
  }
  self.doingadditivepain = 1;
  var_7 = undefined;

  if(scripts\engine\utility::damagelocationisany("left_arm_lower", "left_arm_upper", "left_hand"))
    var_7 = scripts\anim\utility.gsc::lookupanim("additive_pain", "left_arm");

  if(scripts\engine\utility::damagelocationisany("right_arm_lower", "right_arm_upper", "right_hand"))
    var_7 = scripts\anim\utility.gsc::lookupanim("additive_pain", "right_arm");
  else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot"))
    var_7 = scripts\anim\utility.gsc::lookupanim("additive_pain", "left_leg");
  else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot"))
    var_7 = scripts\anim\utility.gsc::lookupanim("additive_pain", "right_leg");
  else {
    var_8 = scripts\anim\utility.gsc::lookupanim("additive_pain", "default");
    var_7 = var_8[randomint(var_8.size)];
  }

  self setanimlimited(%add_pain, 1, 0.1, 1);
  self setanimlimited(var_7, 1, 0, 1);
  wait 0.4;
  self clearanim(var_7, 0.2);
  self clearanim(%add_pain, 0.2);
  self.doingadditivepain = undefined;
}

pain_setflaggedanimknob(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 0.2;

  if(!isDefined(var_4))
    var_4 = 1;

  self setflaggedanimknob(var_0, var_1, var_2, var_3, var_4);
  self.facialanimidx = scripts\anim\face.gsc::playfacialanim(var_1, "pain", self.facialanimidx);
}

pain_setflaggedanimknobrestart(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 0.2;

  if(!isDefined(var_4))
    var_4 = 1;

  self setflaggedanimknobrestart(var_0, var_1, var_2, var_3, var_4);
  self.facialanimidx = scripts\anim\face.gsc::playfacialanim(var_1, "pain", self.facialanimidx);
}

pain_setflaggedanimknoballrestart(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = 0.2;

  if(!isDefined(var_5))
    var_5 = 1;

  self setflaggedanimknoballrestart(var_0, var_1, var_2, var_3, var_4, var_5);
  self.facialanimidx = scripts\anim\face.gsc::playfacialanim(var_1, "pain", self.facialanimidx);
}