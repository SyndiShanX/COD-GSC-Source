/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\pain.gsc
**************************************/

main() {
  if(isDefined(self.longdeathstarting)) {
    self waittill("killanimscript");
    return;
  }

  if([[anim.pain_test]]()) {
    return;
  }
  if(self.a.disablepain) {
    return;
  }
  self notify("kill_long_death");

  if(isDefined(self.a.paintime)) {
    self.a.lastpaintime = self.a.paintime;
  } else {
    self.a.lastpaintime = 0;
  }
  self.a.paintime = gettime();

  if(self.stairsstate != "none") {
    self.a.painonstairs = 1;
  } else {
    self.a.painonstairs = undefined;
  }
  if(self.a.nextstandinghitdying) {
    self.health = 1;
  }
  var_0 = 0;
  var_1 = 0;
  var_2 = self.health / self.maxhealth;
  self notify("anim entered pain");
  self endon("killanimscript");
  animscripts\utility::initialize("pain");
  self animmode("gravity");

  if(!isDefined(self.no_pain_sound)) {
    animscripts\face::saygenericdialogue("pain");
  }
  if(self.damagelocation == "helmet") {
    animscripts\death::helmetpop();
  } else if(wasdamagedbyexplosive() && randomint(2) == 0) {
    animscripts\death::helmetpop();
  }
  if(isDefined(self.painfunction)) {
    self[[self.painfunction]]();
    return;
  }

  if(crawlingpain()) {
    return;
  }
  if(specialpain(self.a.special)) {
    return;
  }
  var_3 = getpainanim();
  playpainanim(var_3);
}

initpainfx() {
  level._effect["crawling_death_blood_smear"] = loadfx("impacts/blood_smear_decal");
}

end_script() {
  if(isDefined(self.damageshieldpain)) {
    self.damageshieldcounter = undefined;
    self.damageshieldpain = undefined;
    self.allowpain = 1;

    if(!isDefined(self.predamageshieldignoreme)) {
      self.ignoreme = 0;
    }
    self.predamageshieldignoreme = undefined;
  }

  if(isDefined(self.blockingpain)) {
    self.blockingpain = undefined;
    self.allowpain = 1;
  }
}

wasdamagedbyexplosive() {
  if(isexplosivedamagemod(self.damagemod)) {
    return 1;
  }
  if(gettime() - anim.lastcarexplosiontime <= 50) {
    var_0 = anim.lastcarexplosionrange * anim.lastcarexplosionrange * 1.2 * 1.2;

    if(distancesquared(self.origin, anim.lastcarexplosiondamagelocation) < var_0) {
      var_1 = var_0 * 0.5 * 0.5;
      self.maydoupwardsdeath = distancesquared(self.origin, anim.lastcarexplosionlocation) < var_1;
      return 1;
    }
  }

  return 0;
}

#using_animtree("generic_human");

getdamageshieldpainanim() {
  if(self.a.pose == "prone") {
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
  } else {
    self.damageshieldpain = 1;
    self.allowpain = 0;

    if(self.ignoreme) {
      self.predamageshieldignoreme = 1;
    } else {
      self.ignoreme = 1;
    }
    if(animscripts\utility::usingsidearm()) {
      animscripts\shared::placeweaponon(self.primaryweapon, "right");
    }
    if(self.a.pose == "crouch") {
      return % exposed_crouch_extendedpaina;
    }
    var_0 = animscripts\utility::array(%stand_exposed_extendedpain_chest, %stand_exposed_extendedpain_head_2_crouch, %stand_exposed_extendedpain_hip_2_crouch);
  }
}

getpainanim() {
  if(self.damageshield && !isDefined(self.disabledamageshieldpain)) {
    var_0 = getdamageshieldpainanim();

    if(isDefined(var_0)) {
      return var_0;
    }
  }

  if(isDefined(self.a.onback)) {
    if(self.a.pose == "crouch") {
      return % back_pain;
    } else {
      animscripts\notetracks::stoponback();
    }
  }

  if(self.a.pose == "stand") {
    var_1 = isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 4096;

    if(!var_1 && self.a.movement == "run" && abs(self getmotionangle()) < 60) {
      return getrunningforwardpainanim();
    }
    self.a.movement = "stop";
    return getstandpainanim();
  } else if(self.a.pose == "crouch") {
    self.a.movement = "stop";
    return getcrouchpainanim();
  } else if(self.a.pose == "prone") {
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
  } else if(self maymovetopoint(self localtoworldcoords((200, 0, 0)))) {
    var_1 = 1;
  }
  if(isDefined(self.a.disablelongpain)) {
    var_2 = 0;
    var_1 = 0;
  }

  if(var_2) {
    var_0[var_0.size] = % run_pain_leg;
    var_0[var_0.size] = % run_pain_shoulder;
    var_0[var_0.size] = % run_pain_stomach_stumble;
    var_0[var_0.size] = % run_pain_head;
  }

  if(var_1) {
    var_0[var_0.size] = % run_pain_fallonknee_02;
    var_0[var_0.size] = % run_pain_stomach;
    var_0[var_0.size] = % run_pain_stumble;
    var_0[var_0.size] = % run_pain_stomach_fast;
    var_0[var_0.size] = % run_pain_leg_fast;
    var_0[var_0.size] = % run_pain_fall;
  } else if(self maymovetopoint(self localtoworldcoords((120, 0, 0)))) {
    var_0[var_0.size] = % run_pain_fallonknee;
    var_0[var_0.size] = % run_pain_fallonknee_03;
  }

  if(!var_0.size) {
    self.a.movement = "stop";
    return getstandpainanim();
  }

  return var_0[randomint(var_0.size)];
}

getstandpistolpainanim() {
  var_0 = [];

  if(animscripts\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
    var_0[var_0.size] = % pistol_stand_pain_chest;
  }
  if(animscripts\utility::damagelocationisany("torso_lower", "left_leg_upper", "right_leg_upper")) {
    var_0[var_0.size] = % pistol_stand_pain_groin;
  }
  if(animscripts\utility::damagelocationisany("head", "neck")) {
    var_0[var_0.size] = % pistol_stand_pain_head;
  }
  if(animscripts\utility::damagelocationisany("left_arm_lower", "left_arm_upper", "torso_upper")) {
    var_0[var_0.size] = % pistol_stand_pain_leftshoulder;
  }
  if(animscripts\utility::damagelocationisany("right_arm_lower", "right_arm_upper", "torso_upper")) {
    var_0[var_0.size] = % pistol_stand_pain_rightshoulder;
  }
  if(var_0.size < 2) {
    var_0[var_0.size] = % pistol_stand_pain_chest;
  }
  if(var_0.size < 2) {
    var_0[var_0.size] = % pistol_stand_pain_groin;
  }
  return var_0[randomint(var_0.size)];
}

getstandpainanim() {
  if(animscripts\utility::usingsidearm()) {
    return getstandpistolpainanim();
  }
  var_0 = [];
  var_1 = [];

  if(animscripts\utility::damagelocationisany("torso_upper", "torso_lower")) {
    var_1[var_1.size] = % stand_exposed_extendedpain_gut;
    var_1[var_1.size] = % stand_exposed_extendedpain_stomach;
  }

  if(animscripts\utility::damagelocationisany("torso_upper", "head", "helmet", "neck")) {
    var_0[var_0.size] = % exposed_pain_face;
    var_0[var_0.size] = % stand_exposed_extendedpain_neck;
    var_1[var_1.size] = % stand_exposed_extendedpain_head_2_crouch;
  }

  if(animscripts\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    var_0[var_0.size] = % exposed_pain_right_arm;
  }
  if(animscripts\utility::damagelocationisany("left_arm_lower", "left_arm_upper")) {
    var_0[var_0.size] = % stand_exposed_extendedpain_shoulderswing;
    var_1[var_1.size] = % stand_exposed_extendedpain_shoulder_2_crouch;
  }

  if(animscripts\utility::damagelocationisany("torso_lower", "left_leg_upper", "right_leg_upper")) {
    var_0[var_0.size] = % exposed_pain_groin;
    var_0[var_0.size] = % stand_exposed_extendedpain_hip;
    var_1[var_1.size] = % stand_exposed_extendedpain_hip_2_crouch;
    var_1[var_1.size] = % stand_exposed_extendedpain_feet_2_crouch;
    var_1[var_1.size] = % stand_exposed_extendedpain_stomach;
  }

  if(animscripts\utility::damagelocationisany("left_foot", "right_foot", "left_leg_lower", "right_leg_lower")) {
    var_0[var_0.size] = % stand_exposed_extendedpain_thigh;
    var_1[var_1.size] = % stand_exposed_extendedpain_feet_2_crouch;
  }

  if(var_0.size < 2) {
    if(!self.a.disablelongdeath) {
      var_0[var_0.size] = % exposed_pain_2_crouch;
      var_0[var_0.size] = % stand_extendedpainb;
    } else {
      var_0[var_0.size] = % exposed_pain_right_arm;
      var_0[var_0.size] = % exposed_pain_face;
      var_0[var_0.size] = % exposed_pain_groin;
    }
  }

  if(var_1.size < 2) {
    var_1[var_1.size] = % stand_extendedpainc;
    var_1[var_1.size] = % stand_exposed_extendedpain_chest;
  }

  if(!self.damageshield && !self.a.disablelongdeath) {
    var_2 = randomint(var_0.size + var_1.size);

    if(var_2 < var_0.size) {
      return var_0[var_2];
    } else {
      return var_1[var_2 - var_0.size];
    }
  }

  return var_0[randomint(var_0.size)];
}

removeblockedanims(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_4 = 1;

    if(animhasnotetrack(var_3, "code_move")) {
      var_4 = getnotetracktimes(var_3, "code_move")[0];
    }
    var_5 = getmovedelta(var_3, 0, var_4);
    var_6 = self localtoworldcoords(var_5);

    if(self maymovetopoint(var_6, 1, 1)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

getcrouchpainanim() {
  var_0 = [];

  if(!self.damageshield && !self.a.disablelongdeath) {
    var_0[var_0.size] = % exposed_crouch_extendedpaina;
  }
  var_0[var_0.size] = % exposed_crouch_pain_chest;
  var_0[var_0.size] = % exposed_crouch_pain_headsnap;
  var_0[var_0.size] = % exposed_crouch_pain_flinch;

  if(animscripts\utility::damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper")) {
    var_0[var_0.size] = % exposed_crouch_pain_left_arm;
  }
  if(animscripts\utility::damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper")) {
    var_0[var_0.size] = % exposed_crouch_pain_right_arm;
  }
  return var_0[randomint(var_0.size)];
}

getpronepainanim() {
  if(randomint(2) == 0) {
    return % prone_reaction_a;
  } else {
    return % prone_reaction_b;
  }
}

playpainanim(var_0) {
  var_1 = 1;
  self setflaggedanimknoballrestart("painanim", var_0, %body, 1, 0.1, var_1);

  if(self.a.pose == "prone") {
    self updateprone(%prone_legs_up, %prone_legs_down, 1, 0.1, 1);
  }
  if(animhasnotetrack(var_0, "start_aim")) {
    thread notifystartaim("painanim");
    self endon("start_aim");
  }

  if(animhasnotetrack(var_0, "code_move")) {
    animscripts\shared::donotetracks("painanim");
  }
  animscripts\shared::donotetracks("painanim");
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
  if(var_0 == "none") {
    return 0;
  }
  self.a.special = "none";
  thread specialpainblocker();

  switch (var_0) {
    case "cover_left":
      if(self.a.pose == "stand") {
        var_1 = [];
        var_1[var_1.size] = % corner_standl_painb;
        var_1[var_1.size] = % corner_standl_painc;
        var_1[var_1.size] = % corner_standl_paind;
        var_1[var_1.size] = % corner_standl_paine;
        dopainfromarray(var_1);
        var_2 = 1;
      } else if(self.a.pose == "crouch") {
        var_1 = [];
        var_1[var_1.size] = % cornercrl_painb;
        dopainfromarray(var_1);
        var_2 = 1;
      } else {
        var_2 = 0;
      }
      break;
    case "cover_right":
      if(self.a.pose == "stand") {
        var_1 = [];
        var_1[0] = % corner_standr_pain;
        var_1[1] = % corner_standr_painb;
        var_1[2] = % corner_standr_painc;
        dopainfromarray(var_1);
        var_2 = 1;
      } else if(self.a.pose == "crouch") {
        var_1 = [];
        var_1[var_1.size] = % cornercrr_alert_paina;
        var_1[var_1.size] = % cornercrr_alert_painc;
        dopainfromarray(var_1);
        var_2 = 1;
      } else {
        var_2 = 0;
      }
      break;
    case "cover_right_stand_A":
      var_2 = 0;
      break;
    case "cover_right_stand_B":
      dopain(%corner_standr_pain_b_2_alert);
      var_2 = 1;
      break;
    case "cover_left_stand_A":
      dopain(%corner_standl_pain_a_2_alert);
      var_2 = 1;
      break;
    case "cover_left_stand_B":
      dopain(%corner_standl_pain_b_2_alert);
      var_2 = 1;
      break;
    case "cover_crouch":
      var_1 = [];
      var_1[var_1.size] = % covercrouch_pain_right;
      var_1[var_1.size] = % covercrouch_pain_front;
      var_1[var_1.size] = % covercrouch_pain_left_3;
      dopainfromarray(var_1);
      var_2 = 1;
      break;
    case "cover_stand":
      var_1 = [];
      var_1[var_1.size] = % coverstand_pain_groin;
      var_1[var_1.size] = % coverstand_pain_leg;
      dopainfromarray(var_1);
      var_2 = 1;
      break;
    case "cover_stand_aim":
      var_1 = [];
      var_1[var_1.size] = % coverstand_pain_aim_2_hide_01;
      var_1[var_1.size] = % coverstand_pain_aim_2_hide_02;
      dopainfromarray(var_1);
      var_2 = 1;
      break;
    case "cover_crouch_aim":
      dopain(%covercrouch_pain_aim_2_hide_01);
      var_2 = 1;
      break;
    case "saw":
      if(self.a.pose == "stand") {
        var_3 = % saw_gunner_pain;
      } else if(self.a.pose == "crouch") {
        var_3 = % saw_gunner_lowwall_pain_02;
      } else {
        var_3 = % saw_gunner_prone_pain;
      }
      self setflaggedanimknob("painanim", var_3, 1, 0.3, 1);
      animscripts\shared::donotetracks("painanim");
      var_2 = 1;
      break;
    case "mg42":
      mg42pain(self.a.pose);
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
  self setflaggedanimknob("painanim", var_1, 1, 0.3, 1);
  animscripts\shared::donotetracks("painanim");
}

dopain(var_0) {
  self setflaggedanimknob("painanim", var_0, 1, 0.3, 1);
  animscripts\shared::donotetracks("painanim");
}

mg42pain(var_0) {
  self setflaggedanimknob("painanim", level.mg_animmg["pain_" + var_0], 1, 0.1, 1);
  animscripts\shared::donotetracks("painanim");
}

waitsetstop(var_0, var_1) {
  self endon("killanimscript");
  self endon("death");

  if(isDefined(var_1)) {
    self endon(var_1);
  }
  wait(var_0);
  self.a.movement = "stop";
}

crawlingpain() {
  if(self.a.disablelongdeath || self.diequietly || self.damageshield) {
    return 0;
  }
  if(self.stairsstate != "none") {
    return 0;
  }
  if(isDefined(self.a.onback)) {
    return 0;
  }
  var_0["prone"] = animscripts\utility::array(%dying_crawl_2_back);
  var_0["stand"] = animscripts\utility::array(%dying_stand_2_back_v1, %dying_stand_2_back_v2);
  var_0["crouch"] = animscripts\utility::array(%dying_crouch_2_back);
  self.a.crawlingpaintransanim = var_0[self.a.pose][randomint(var_0[self.a.pose].size)];

  if(isDefined(self.forcelongdeath)) {
    self.health = 10;
    thread crawlingpistol();
    self waittill("killanimscript");
    return 1;
  }

  if(!iscrawldeltaallowed(self.a.crawlingpaintransanim)) {
    return 0;
  }
  if(self.health > 100) {
    return 0;
  }
  var_1 = animscripts\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot");

  if(var_1 && self.health < self.maxhealth * 0.4) {
    if(gettime() < anim.nextcrawlingpaintimefromlegdamage) {
      return 0;
    }
  } else {
    if(anim.numdeathsuntilcrawlingpain > 0) {
      return 0;
    }
    if(gettime() < anim.nextcrawlingpaintime) {
      return 0;
    }
  }

  if(isDefined(self.deathfunction)) {
    return 0;
  }
  foreach(var_3 in level.players) {
    if(distance(self.origin, var_3.origin) < 175) {
      return 0;
    }
  }

  if(animscripts\utility::damagelocationisany("head", "helmet", "gun", "right_hand", "left_hand")) {
    return 0;
  }
  if(animscripts\utility::usingsidearm()) {
    return 0;
  }
  anim.nextcrawlingpaintime = gettime() + 3000;
  anim.nextcrawlingpaintimefromlegdamage = gettime() + 3000;
  thread crawlingpistol();
  self waittill("killanimscript");
  return 1;
}

iscrawldeltaallowed(var_0) {
  if(isDefined(self.a.force_num_crawls)) {
    return 1;
  }
  var_1 = getmovedelta(var_0, 0, 1);
  var_2 = self localtoworldcoords(var_1);
  return self maymovetopoint(var_2);
}

initcrawlingpistolanims() {
  self.a.array = [];
  self.a.array["stand_2_crawl"] = animscripts\utility::array(%dying_stand_2_crawl_v1, %dying_stand_2_crawl_v2, %dying_stand_2_crawl_v3);
  self.a.array["crouch_2_crawl"] = animscripts\utility::array(%dying_crouch_2_crawl);
  self.a.array["crawl"] = % dying_crawl;
  self.a.array["death"] = animscripts\utility::array(%dying_crawl_death_v1, %dying_crawl_death_v2);
  self.a.array["back_idle"] = % dying_back_idle;
  self.a.array["back_idle_twitch"] = animscripts\utility::array(%dying_back_twitch_a, %dying_back_twitch_b);
  self.a.array["back_crawl"] = % dying_crawl_back;
  self.a.array["back_fire"] = % dying_back_fire;
  self.a.array["back_death"] = animscripts\utility::array(%dying_back_death_v1, %dying_back_death_v2, %dying_back_death_v3);

  if(isDefined(self.crawlingpainanimoverridefunc)) {
    [[self.crawlingpainanimoverridefunc]]();
  }
}

crawlingpistol() {
  self endon("kill_long_death");
  self endon("death");
  initcrawlingpistolanims();
  thread preventpainforashorttime("crawling");
  self.a.special = "none";
  self.specialdeathfunc = undefined;
  thread paindeathnotify();
  level notify("ai_crawling", self);
  thread crawling_stab_achievement();
  self setanimknoball(%dying, %body, 1, 0.1, 1);

  if(!dyingcrawl()) {
    return;
  }
  self setflaggedanimknob("transition", self.a.crawlingpaintransanim, 1, 0.5, 1);
  animscripts\notetracks::donotetracksintercept("transition", ::handlebackcrawlnotetracks);
  self.a.special = "dying_crawl";
  thread dyingcrawlbackaim();

  if(isDefined(self.enemy)) {
    self setlookatentity(self.enemy);
  }
  decidenumcrawls();

  while(shouldkeepcrawling()) {
    var_0 = animscripts\utility::animarray("back_crawl");

    if(!iscrawldeltaallowed(var_0)) {
      break;
    }

    self setflaggedanimknobrestart("back_crawl", var_0, 1, 0.1, 1.0);
    animscripts\notetracks::donotetracksintercept("back_crawl", ::handlebackcrawlnotetracks);
  }

  self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);

  while(shouldstayalive()) {
    if(animscripts\utility::canseeenemy() && aimedsomewhatatenemy()) {
      var_1 = animscripts\utility::animarray("back_fire");
      self setflaggedanimknobrestart("back_idle_or_fire", var_1, 1, 0.2, 1.0);
      animscripts\shared::donotetracks("back_idle_or_fire");
      continue;
    }

    var_1 = animscripts\utility::animarray("back_idle");

    if(randomfloat(1) < 0.4) {
      var_1 = animscripts\utility::animarraypickrandom("back_idle_twitch");
    }
    self setflaggedanimknobrestart("back_idle_or_fire", var_1, 1, 0.1, 1.0);
    var_2 = getanimlength(var_1);

    while(var_2 > 0) {
      if(animscripts\utility::canseeenemy() && aimedsomewhatatenemy()) {
        break;
      }

      var_3 = 0.5;

      if(var_3 > var_2) {
        var_3 = var_2;
        var_2 = 0;
      } else {
        var_2 = var_2 - var_3;
      }
      animscripts\notetracks::donotetracksfortime(var_3, "back_idle_or_fire");
    }
  }

  self notify("end_dying_crawl_back_aim");
  self clearanim(%dying_back_aim_4_wrapper, 0.3);
  self clearanim(%dying_back_aim_6_wrapper, 0.3);
  self.deathanim = animscripts\utility::animarraypickrandom("back_death");
  killwrapper();
  self.a.special = "none";
  self.specialdeathfunc = undefined;
}

crawling_stab_achievement() {
  if(self.team == "allies") {
    return;
  }
  self endon("end_dying_crawl_back_aim");
  self waittill("death", var_0, var_1);

  if(!isDefined(self) || !isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }
}

shouldstayalive() {
  if(!enemyisingeneraldirection(anglesToForward(self.angles))) {
    return 0;
  }
  return gettime() < self.desiredtimeofdeath;
}

dyingcrawl() {
  if(!isDefined(self.forcelongdeath)) {
    if(self.a.pose == "prone") {
      return 1;
    }
    if(self.a.movement == "stop") {
      if(randomfloat(1) < 0.4) {
        if(randomfloat(1) < 0.5) {
          return 1;
        }
      } else if(abs(self.damageyaw) > 90) {
        return 1;
      }
    } else if(abs(self getmotionangle()) > 90) {
      return 1;
    }
  }

  if(self.a.pose != "prone") {
    var_0 = animscripts\utility::animarraypickrandom(self.a.pose + "_2_crawl");

    if(!iscrawldeltaallowed(var_0)) {
      return 1;
    }
    thread dyingcrawlbloodsmear();
    self setflaggedanimknob("falling", var_0, 1, 0.5, 1);
    animscripts\shared::donotetracks("falling");
  } else {
    thread dyingcrawlbloodsmear();
  }
  self.a.crawlingpaintransanim = % dying_crawl_2_back;
  self.a.special = "dying_crawl";
  decidenumcrawls();

  while(shouldkeepcrawling()) {
    var_1 = animscripts\utility::animarray("crawl");

    if(!iscrawldeltaallowed(var_1)) {
      return 1;
    }
    if(isDefined(self.custom_crawl_sound)) {
      self playSound(self.custom_crawl_sound);
    }
    self setflaggedanimknobrestart("crawling", var_1, 1, 0.1, 1.0);
    animscripts\shared::donotetracks("crawling");
  }

  self notify("done_crawling");

  if(!isDefined(self.forcelongdeath) && enemyisingeneraldirection(anglesToForward(self.angles) * -1)) {
    return 1;
  }
  var_2 = animscripts\utility::animarraypickrandom("death");

  if(var_2 != % dying_crawl_death_v2) {
    self.a.nodeath = 1;
  }
  animscripts\death::playdeathanim(var_2);
  killwrapper();
  self.a.special = "none";
  self.specialdeathfunc = undefined;
  return 0;
}

dyingcrawlbloodsmear() {
  self endon("death");

  if(self.a.pose != "prone") {
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

  if(isDefined(self.a.crawl_fx_rate)) {
    var_3 = self.a.crawl_fx_rate;
  }
  if(isDefined(self.a.crawl_fx)) {
    var_4 = level._effect[self.a.crawl_fx];
  }
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
  self setanimlimited(%dying_back_aim_4, 1, 0);
  self setanimlimited(%dying_back_aim_6, 1, 0);
  var_0 = 0;

  for(;;) {
    var_1 = animscripts\utility::getyawtoenemy();
    var_2 = angleclamp180(var_1 - var_0);

    if(abs(var_2) > 3) {
      var_2 = common_scripts\utility::sign(var_2) * 3;
    }
    var_1 = angleclamp180(var_0 + var_2);

    if(var_1 < 0) {
      if(var_1 < -45.0) {
        var_1 = -45.0;
      }
      var_3 = var_1 / -45.0;
      self setanim(%dying_back_aim_4_wrapper, var_3, 0.05);
      self setanim(%dying_back_aim_6_wrapper, 0, 0.05);
    } else {
      if(var_1 > 45.0) {
        var_1 = 45.0;
      }
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
    if(!animscripts\utility::canseeenemy()) {
      return 1;
    }
    if(!aimedsomewhatatenemy()) {
      return 1;
    }
    animscripts\utility::shootenemywrapper();
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
  var_3 = animscripts\utility::absangleclamp180(var_1[1] - var_2[1]);

  if(var_3 > anim.painyawdifffartolerance) {
    if(distancesquared(self getEye(), var_0) > anim.painyawdiffclosedistsq || var_3 > anim.painyawdiffclosetolerance) {
      return 0;
    }
  }

  return animscripts\utility::absangleclamp180(var_1[0] - var_2[0]) <= anim.painpitchdifftolerance;
}

enemyisingeneraldirection(var_0) {
  if(!isDefined(self.enemy)) {
    return 0;
  }
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

  if(self.health > 1) {
    self.health = 1;
  }
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
  if(isDefined(self.a.force_num_crawls)) {
    self.a.numcrawls = self.a.force_num_crawls;
  } else {
    self.a.numcrawls = randomintrange(1, 5);
  }
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
  if(anim.numdeathsuntilcornergrenadedeath > 0) {
    return 0;
  }
  if(gettime() < anim.nextcornergrenadedeathtime) {
    return 0;
  }
  if(self.a.disablelongdeath || self.diequietly || self.damageshield) {
    return 0;
  }
  if(isDefined(self.deathfunction)) {
    return 0;
  }
  if(distance(self.origin, level.player.origin) < 175) {
    return 0;
  }
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
  thread maps\_utility::set_battlechatter(0);
  self.threatbias = -1000;
  self setflaggedanimknoballrestart("corner_grenade_pain", %corner_standr_death_grenade_hit, %body, 1, 0.1);
  self waittillmatch("corner_grenade_pain", "dropgun");
  animscripts\shared::dropallaiweapons();
  self waittillmatch("corner_grenade_pain", "anim_pose = \"back\"");
  animscripts\notetracks::notetrackposeback();
  self waittillmatch("corner_grenade_pain", "grenade_left");
  var_0 = getweaponmodel("fraggrenade");
  self attach(var_0, "tag_inhand");
  self.deathfunction = ::prematurecornergrenadedeath;
  self waittillmatch("corner_grenade_pain", "end");
  var_1 = gettime() + randomintrange(25000, 60000);
  self setflaggedanimknoballrestart("corner_grenade_idle", %corner_standr_death_grenade_idle, %body, 1, 0.2);
  thread watchenemyvelocity();

  while(!enemyisapproaching()) {
    if(gettime() >= var_1) {
      break;
    }

    animscripts\notetracks::donotetracksfortime(0.1, "corner_grenade_idle");
  }

  var_2 = % corner_standr_death_grenade_slump;
  self setflaggedanimknoballrestart("corner_grenade_release", var_2, %body, 1, 0.2);
  var_3 = getnotetracktimes(var_2, "grenade_drop");
  var_4 = var_3[0] * getanimlength(var_2);
  wait(var_4 - 1.0);
  animscripts\death::playdeathsound();
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
  var_5 = bulletTrace(var_3, var_4, 0, undefined);

  if(var_5["fraction"] < 0.5) {
    var_2 = var_5["position"];
  }
  var_6 = "default";

  if(var_5["surfacetype"] != "none") {
    var_6 = var_5["surfacetype"];
  }
  thread playsoundatpoint("grenade_bounce_" + var_6, var_2);
  self.grenadeweapon = "fraggrenade";
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
  if(isDefined(self.last_dmg_player)) {
    self kill(self.origin, self.last_dmg_player);
  } else {
    self kill();
  }
}

enemyisapproaching() {
  if(!isDefined(self.enemy)) {
    return 0;
  }
  if(distancesquared(self.origin, self.enemy.origin) > 147456) {
    return 0;
  }
  if(distancesquared(self.origin, self.enemy.origin) < 16384) {
    return 1;
  }
  var_0 = self.enemy.origin + self.enemyvelocity * 3.0;
  var_1 = self.enemy.origin;

  if(self.enemy.origin != var_0) {
    var_1 = pointonsegmentnearesttopoint(self.enemy.origin, var_0, self.origin);
  }
  if(distancesquared(self.origin, var_1) < 16384) {
    return 1;
  }
  return 0;
}

prematurecornergrenadedeath() {
  var_0 = animscripts\utility::array(%dying_back_death_v1, %dying_back_death_v2, %dying_back_death_v3, %dying_back_death_v4);
  var_1 = var_0[randomint(var_0.size)];
  animscripts\death::playdeathsound();
  self setflaggedanimknoballrestart("corner_grenade_die", var_1, %body, 1, 0.2);
  var_2 = animscripts\combat_utility::getgrenadedropvelocity();
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
      if(isDefined(self.enemy)) {
        var_1 = self.enemy.origin;
      } else {
        var_1 = self.origin;
      }
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
  var_7 = animscripts\utility::array(%pain_add_standing_belly, %pain_add_standing_left_arm, %pain_add_standing_right_arm);
  var_8 = % pain_add_standing_belly;

  if(animscripts\utility::damagelocationisany("left_arm_lower", "left_arm_upper", "left_hand")) {
    var_8 = % pain_add_standing_left_arm;
  }
  if(animscripts\utility::damagelocationisany("right_arm_lower", "right_arm_upper", "right_hand")) {
    var_8 = % pain_add_standing_right_arm;
  } else if(animscripts\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
    var_8 = % pain_add_standing_left_leg;
  } else if(animscripts\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
    var_8 = % pain_add_standing_right_leg;
  } else {
    var_8 = var_7[randomint(var_7.size)];
  }
  self setanimlimited(%add_pain, 1, 0.1, 1);
  self setanimlimited(var_8, 1, 0, 1);
  wait 0.4;
  self clearanim(var_8, 0.2);
  self clearanim(%add_pain, 0.2);
  self.doingadditivepain = undefined;
}