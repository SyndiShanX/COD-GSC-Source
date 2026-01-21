/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\pain.gsc
*********************************************/

func_951B() {}

main() {
  self endon("killanimscript");
  lib_0A1E::func_C879();
}

func_98AC() {
  level._effect["crawling_death_blood_smear"] = loadfx("vfx\core\impacts\blood_smear_decal.vfx");
}

end_script() {}

func_1390C() {
  if(!isDefined(self.var_DE)) {
    return 0;
  }

  if(isexplosivedamagemod(self.var_DE)) {
    return 1;
  }

  if(scripts\engine\utility::wasdamagedbyoffhandshield()) {
    return 1;
  }

  if(self.var_DE == "MOD_MELEE" && isDefined(self.opcode::OP_EvalLocalVariableRefCached) && isDefined(self.var_4F.unittype) && self.var_4F.unittype == "c8") {
    return 1;
  }

  if(gettime() - level.var_A955 <= 50) {
    var_0 = level.var_A954 * level.var_A954 * 1.2 * 1.2;
    if(distancesquared(self.origin, level.var_A952) < var_0) {
      var_1 = var_0 * 0.5 * 0.5;
      self.var_B4DF = distancesquared(self.origin, level.var_A953) < var_1;
      return 1;
    }
  }

  return 0;
}

func_7E5D() {
  if(self.a.pose == "prone") {
    return;
  }

  if(isDefined(self.sethalfresparticles) && isDefined(self.sethalfresparticles.team) && self.sethalfresparticles.team == self.team) {
    return;
  }

  if(!isDefined(self.damageshieldcounter) || gettime() - self.a.var_A9C8 > 1500) {
    self.damageshieldcounter = randomintrange(2, 3);
  }

  if(isDefined(self.sethalfresparticles) && distancesquared(self.origin, self.sethalfresparticles.origin) < squared(512)) {
    self.damageshieldcounter = 0;
  }

  if(self.damageshieldcounter > 0) {
    self.damageshieldcounter--;
    return;
  }

  self.var_4D6A = 1;
  self.allowpain = 0;
  if(self.ignoreme) {
    self.var_D817 = 1;
  } else {
    self.ignoreme = 1;
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
  }

  if(self.a.pose == "crouch") {
    return scripts\anim\utility::func_B027("pain", "damage_shield_crouch");
  }

  var_0 = scripts\anim\utility::func_B027("pain", "damage_shield_pain_array");
  return var_0[randomint(var_0.size)];
}

botmemoryselectpos() {
  if(self.var_E0 && !isDefined(self.var_55BF)) {
    var_0 = func_7E5D();
    if(isDefined(var_0)) {
      return var_0;
    }
  }

  if(isDefined(self.a.onback)) {
    if(self.a.pose == "crouch") {
      return scripts\anim\utility::func_B027("pain", "back");
    } else {
      scripts\anim\notetracks::stoponback();
    }
  }

  if(self.a.pose == "stand") {
    var_1 = isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 4096;
    if(!var_1 && self.a.movement == "run" && abs(self getspawnpoint_searchandrescue()) < 60) {
      return getsafecircleorigin();
    }

    self.a.movement = "stop";
    return getstance();
  }

  if(self.a.pose == "crouch") {
    self.a.movement = "stop";
    return func_7E46();
  }

  if(self.a.pose == "prone") {
    self.a.movement = "stop";
    return func_80A0();
  }
}

getsafecircleorigin() {
  var_0 = [];
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  if(self maymovetopoint(self gettweakablevalue((300, 0, 0)))) {
    var_2 = 1;
    var_1 = 1;
  } else if(self maymovetopoint(self gettweakablevalue((200, 0, 0)))) {
    var_1 = 1;
  }

  if(isDefined(self.a.var_55FD)) {
    var_2 = 0;
    var_1 = 0;
  }

  if(var_2) {
    var_0 = scripts\anim\utility::func_B027("pain", "run_long");
  } else if(var_1) {
    var_0 = scripts\anim\utility::func_B027("pain", "run_medium");
  } else if(self maymovetopoint(self gettweakablevalue((120, 0, 0)))) {
    var_0 = scripts\anim\utility::func_B027("pain", "run_short");
  }

  if(!var_0.size) {
    self.a.movement = "stop";
    return getstance();
  }

  return var_0[randomint(var_0.size)];
}

gettagorigin() {
  var_0 = [];
  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var_0 = scripts\anim\utility::func_B027("pain", "pistol_torso_upper");
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    var_0 = scripts\anim\utility::func_B027("pain", "pistol_torso_lower");
  } else if(scripts\engine\utility::damagelocationisany("neck")) {
    var_0 = scripts\anim\utility::func_B027("pain", "pistol_neck");
  } else if(scripts\engine\utility::damagelocationisany("head")) {
    var_0 = scripts\anim\utility::func_B027("pain", "pistol_head");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "right_leg_upper")) {
    var_0 = scripts\anim\utility::func_B027("pain", "pistol_leg");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper")) {
    var_0 = scripts\anim\utility::func_B027("pain", "pistol_left_arm_upper");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_lower")) {
    var_0 = scripts\anim\utility::func_B027("pain", "pistol_left_arm_lower");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper")) {
    var_0 = scripts\anim\utility::func_B027("pain", "pistol_right_arm_upper");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_lower")) {
    var_0 = scripts\anim\utility::func_B027("pain", "pistol_right_arm_lower");
  }

  if(var_0.size < 2) {
    var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("pain", "pistol_default1"));
  }

  if(var_0.size < 2) {
    var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("pain", "pistol_default2"));
  }

  return var_0[randomint(var_0.size)];
}

getstance() {
  if(scripts\anim\utility_common::isusingsidearm()) {
    return gettagorigin();
  }

  var_0 = [];
  var_1 = [];
  if(scripts\engine\utility::damagelocationisany("torso_upper")) {
    var_0 = scripts\anim\utility::func_B027("pain", "torso_upper");
    var_1 = scripts\anim\utility::func_B027("pain", "torso_upper_extended");
  } else if(scripts\engine\utility::damagelocationisany("torso_lower")) {
    var_0 = scripts\anim\utility::func_B027("pain", "torso_lower");
    var_1 = scripts\anim\utility::func_B027("pain", "torso_lower_extended");
  } else if(scripts\engine\utility::damagelocationisany("head", "helmet", "neck")) {
    var_0 = scripts\anim\utility::func_B027("pain", "head");
    var_1 = scripts\anim\utility::func_B027("pain", "head_extended");
  } else if(scripts\engine\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    var_0 = scripts\anim\utility::func_B027("pain", "right_arm");
    var_1 = scripts\anim\utility::func_B027("pain", "right_arm_extended");
  } else if(scripts\engine\utility::damagelocationisany("left_arm_upper", "left_arm_lower")) {
    var_0 = scripts\anim\utility::func_B027("pain", "left_arm");
    var_1 = scripts\anim\utility::func_B027("pain", "left_arm_extended");
  } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "right_leg_upper")) {
    var_0 = scripts\anim\utility::func_B027("pain", "leg");
    var_1 = scripts\anim\utility::func_B027("pain", "leg_extended");
  } else if(scripts\engine\utility::damagelocationisany("left_foot", "right_foot", "left_leg_lower", "right_leg_lower")) {
    var_0 = scripts\anim\utility::func_B027("pain", "foot");
    var_1 = scripts\anim\utility::func_B027("pain", "foot_extended");
  }

  if(var_0.size < 2) {
    if(!self.a.disablelongdeath) {
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("pain", "default_long"));
    } else {
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("pain", "default_short"));
    }
  }

  if(var_1.size < 2) {
    var_1 = scripts\engine\utility::array_combine(var_1, scripts\anim\utility::func_B027("pain", "default_extended"));
  }

  if(!self.var_E0 && !self.a.disablelongdeath) {
    var_2 = randomint(var_0.size + var_1.size);
    if(var_2 < var_0.size) {
      return var_0[var_2];
    } else {
      return var_1[var_2 - var_0.size];
    }
  }

  return var_0[randomint(var_0.size)];
}

func_7E46() {
  var_0 = [];
  if(!self.var_E0 && !self.a.disablelongdeath) {
    var_0 = scripts\anim\utility::func_B027("pain", "crouch_longdeath");
  }

  var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("pain", "crouch_default"));
  if(scripts\engine\utility::damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper")) {
    var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("pain", "crouch_left_arm"));
  }

  if(scripts\engine\utility::damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper")) {
    var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility::func_B027("pain", "crouch_right_arm"));
  }

  return var_0[randomint(var_0.size)];
}

func_80A0() {
  var_0 = scripts\anim\utility::func_B027("pain", "prone");
  return var_0[randomint(var_0.size)];
}

func_D4EE(var_0) {
  var_1 = 1;
  func_C86D("painanim", var_0, %body, 1, 0.1, var_1);
  if(self.a.pose == "prone") {
    self func_83CF(%prone_legs_up, %prone_legs_down, 1, 0.1, 1);
  }

  if(animhasnotetrack(var_0, "start_aim")) {
    thread func_C172("painanim");
    self endon("start_aim");
  }

  if(animhasnotetrack(var_0, "code_move")) {
    scripts\anim\shared::donotetracks("painanim");
  }

  scripts\anim\shared::donotetracks("painanim");
}

func_C172(var_0) {
  self endon("killanimscript");
  self waittillmatch("start_aim", var_0);
  self notify("start_aim");
}

func_10969() {
  self endon("killanimscript");
  self.var_2BB9 = 1;
  self.allowpain = 0;
  wait(0.5);
  self.var_2BB9 = undefined;
  self.allowpain = 1;
}

func_10968(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  self.a.var_10930 = "none";
  thread func_10969();
  switch (var_0) {
    case "cover_left":
      if(self.a.pose == "stand") {
        var_1 = scripts\anim\utility::func_B027("pain", "cover_left_stand");
        func_5A5B(var_1);
        var_2 = 1;
      } else if(self.a.pose == "crouch") {
        var_1 = scripts\anim\utility::func_B027("pain", "cover_left_crouch");
        func_5A5B(var_1);
        var_2 = 1;
      } else {
        var_2 = 0;
      }
      break;

    case "cover_right":
      if(self.a.pose == "stand") {
        var_1 = scripts\anim\utility::func_B027("pain", "cover_right_stand");
        func_5A5B(var_1);
        var_2 = 1;
      } else if(self.a.pose == "crouch") {
        var_1 = scripts\anim\utility::func_B027("pain", "cover_right_crouch");
        func_5A5B(var_1);
        var_2 = 1;
      } else {
        var_2 = 0;
      }
      break;

    case "cover_right_stand_A":
      var_2 = 0;
      break;

    case "cover_right_stand_B":
      dopain(scripts\anim\utility::func_B027("pain", "cover_right_stand_B"));
      var_2 = 1;
      break;

    case "cover_left_stand_A":
      dopain(scripts\anim\utility::func_B027("pain", "cover_left_stand_A"));
      var_2 = 1;
      break;

    case "cover_left_stand_B":
      dopain(scripts\anim\utility::func_B027("pain", "cover_left_stand_B"));
      var_2 = 1;
      break;

    case "cover_crouch":
      var_1 = scripts\anim\utility::func_B027("pain", "cover_crouch");
      func_5A5B(var_1);
      var_2 = 1;
      break;

    case "cover_stand":
      var_1 = scripts\anim\utility::func_B027("pain", "cover_stand");
      func_5A5B(var_1);
      var_2 = 1;
      break;

    case "cover_stand_aim":
      var_1 = scripts\anim\utility::func_B027("pain", "cover_stand_aim");
      func_5A5B(var_1);
      var_2 = 1;
      break;

    case "cover_crouch_aim":
      var_1 = scripts\anim\utility::func_B027("pain", "cover_crouch_aim");
      func_5A5B(var_1);
      var_2 = 1;
      break;

    case "saw":
      if(self.a.pose == "stand") {
        var_3 = scripts\anim\utility::func_B027("pain", "saw_stand");
      } else if(self.a.pose == "crouch") {
        var_3 = scripts\anim\utility::func_B027("pain", "saw_crouch");
      } else {
        var_3 = scripts\anim\utility::func_B027("pain", "saw_prone");
      }

      func_C86C("painanim", var_3, 1, 0.3, 1);
      scripts\anim\shared::donotetracks("painanim");
      var_2 = 1;
      break;

    case "mg42":
      func_B6AE(self.a.pose);
      var_2 = 1;
      break;

    case "minigun":
      var_2 = 0;
      break;

    case "corner_right_martyrdom":
      var_2 = func_12893();
      break;

    case "dying_crawl":
    case "rambo_right":
    case "rambo_left":
    case "rambo":
      var_2 = 0;
      break;

    default:
      var_2 = 0;
      break;
  }

  return var_2;
}

func_C874() {
  self endon("death");
  wait(0.05);
  self notify("pain_death");
}

func_5A5B(var_0) {
  var_1 = var_0[randomint(var_0.size)];
  func_C86C("painanim", var_1, 1, 0.3, 1);
  scripts\anim\shared::donotetracks("painanim");
}

dopain(var_0) {
  func_C86C("painanim", var_0, 1, 0.3, 1);
  scripts\anim\shared::donotetracks("painanim");
}

func_B6AE(var_0) {
  func_C86C("painanim", level.var_B6B0["pain_" + var_0], 1, 0.1, 1);
  scripts\anim\shared::donotetracks("painanim");
}

func_13713(var_0, var_1) {
  self endon("killanimscript");
  self endon("death");
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  wait(var_0);
  self.a.movement = "stop";
}

func_4874() {
  if(self.a.disablelongdeath || self.var_EF || self.var_E0) {
    return 0;
  }

  if(self.getcsplinepointtargetname != "none") {
    return 0;
  }

  if(isDefined(self.a.onback)) {
    return 0;
  }

  var_0 = scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot");
  if(isDefined(self.var_72CC)) {
    func_F6AD(var_0);
    self.health = 10;
    thread func_4877();
    self waittill("killanimscript");
    return 1;
  }

  if(self.health > 100) {
    return 0;
  }

  if(var_0 && self.health < self.maxhealth * 0.4) {
    if(gettime() < level.var_BF78) {
      return 0;
    }
  } else {
    if(level.var_C222 > 0) {
      return 0;
    }

    if(gettime() < level.var_BF77) {
      return 0;
    }
  }

  if(isDefined(self.var_4E46)) {
    return 0;
  }

  foreach(var_2 in level.players) {
    if(distancesquared(self.origin, var_2.origin) < 30625) {
      return 0;
    }
  }

  if(scripts\engine\utility::damagelocationisany("head", "helmet", "gun", "right_hand", "left_hand")) {
    return 0;
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return 0;
  }

  func_F6AD(var_0);
  if(!isDefined(self.a.var_11188) && !func_9D9D(self.a.var_4876)) {
    return 0;
  }

  anim.var_BF77 = gettime() + 3000;
  anim.var_BF78 = gettime() + 3000;
  thread func_4877();
  self waittill("killanimscript");
  return 1;
}

func_F6AD(var_0) {
  var_1 = [];
  var_2 = undefined;
  if(self.a.pose == "stand") {
    var_2 = func_FFC3(var_0);
    if(isDefined(var_2)) {
      var_1 = [var_2[0]];
    } else {
      var_1 = scripts\anim\utility::func_B027("crawl_death", "stand_transition");
    }
  } else if(self.a.pose == "crouch") {
    var_1 = scripts\anim\utility::func_B027("crawl_death", "crouch_transition");
  } else {
    var_1 = scripts\anim\utility::func_B027("crawl_death", "prone_transition");
  }

  self.a.var_4876 = var_1[randomint(var_1.size)];
  self.a.var_11188 = var_2;
}

func_9D9D(var_0) {
  if(isDefined(self.a.var_7280)) {
    return 1;
  }

  var_1 = getmovedelta(var_0, 0, 1);
  var_2 = self gettweakablevalue(var_1);
  return self maymovetopoint(var_2);
}

func_4877() {
  self endon("kill_long_death");
  self endon("death");
  thread func_D899("crawling");
  self.a.var_10930 = "none";
  self.var_10957 = undefined;
  self func_8306();
  thread func_C874();
  level notify("ai_crawling", self);
  self func_82A5(%dying, %body, 1, 0.1, 1);
  if(isDefined(self.a.var_11188)) {
    func_11185();
    self.a.var_11188 = undefined;
    return;
  }

  if(!func_5F71()) {
    return;
  }

  func_C86C("transition", self.a.var_4876, 1, 0.5, 1);
  scripts\anim\notetracks::donotetracksintercept("transition", ::func_8977);
  self.a.var_10930 = "dying_crawl";
  thread func_5F73();
  if(isDefined(self.enemy)) {
    self func_8306(self.enemy);
  }

  func_4F64();
  while(func_10031()) {
    var_0 = scripts\anim\utility::func_B027("crawl_death", "back_crawl");
    if(!func_9D9D(var_0)) {
      break;
    }

    func_C86E("back_crawl", var_0, 1, 0.1, 1);
    scripts\anim\notetracks::donotetracksintercept("back_crawl", ::func_8977);
  }

  self.var_527E = gettime() + randomintrange(4000, 20000);
  while(func_10099()) {
    if(scripts\anim\utility_common::canseeenemy() && func_1A3C()) {
      var_1 = scripts\anim\utility::func_B027("crawl_death", "back_fire");
      func_C86E("back_idle_or_fire", var_1, 1, 0.2, 1);
      scripts\anim\shared::donotetracks("back_idle_or_fire");
      continue;
    }

    var_1 = scripts\anim\utility::func_B027("crawl_death", "back_idle");
    if(randomfloat(1) < 0.4) {
      var_2 = scripts\anim\utility::func_B027("crawl_death", "back_idle_twitch");
      var_1 = var_2[randomint(var_2.size)];
    }

    func_C86E("back_idle_or_fire", var_1, 1, 0.1, 1);
    var_3 = getanimlength(var_1);
    while(var_3 > 0) {
      if(scripts\anim\utility_common::canseeenemy() && func_1A3C()) {
        break;
      }

      var_4 = 0.5;
      if(var_4 > var_3) {
        var_4 = var_3;
        var_3 = 0;
        continue;
      }

      var_3 = var_3 - var_4;
      scripts\anim\notetracks::donotetracksfortime(var_4, "back_idle_or_fire");
    }
  }

  self notify("end_dying_crawl_back_aim");
  self clearanim(%dying_back_aim_4_wrapper, 0.3);
  self clearanim(%dying_back_aim_6_wrapper, 0.3);
  var_5 = scripts\anim\utility::func_B027("crawl_death", "back_death");
  self.var_4E2A = var_5[randomint(var_5.size)];
  func_A6CE();
  self.a.var_10930 = "none";
  self.var_10957 = undefined;
}

func_FFC3(var_0) {
  if(self.a.pose != "stand") {
    return;
  }

  var_1 = 2;
  if(randomint(10) > var_1) {
    return;
  }

  var_2 = 0;
  if(!var_0) {
    var_2 = scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower");
    if(!var_2) {
      return;
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
    if(45 < self.var_E3 && self.var_E3 < 135) {
      var_5 = "l";
    } else if(-135 < self.var_E3 && self.var_E3 < -45) {
      var_5 = "r";
    } else if(-45 < self.var_E3 && self.var_E3 < 45) {
      return;
    }
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
      break;
  }

  if(!self maymovetopoint(var_7)) {
    return;
  }

  var_9 = scripts\anim\utility::func_B027("crawl_death", "longdeath");
  var_10 = var_4 + "_" + var_5;
  var_11 = randomint(var_9[var_10].size);
  var_12 = var_9[var_10][var_11];
  return var_12;
}

func_11185() {
  func_C86E("stumblingPainInto", self.a.var_11188[0]);
  scripts\anim\shared::donotetracks("stumblingPainInto");
  self.a.var_10930 = "stumbling_pain";
  var_0 = getmovedelta(self.a.var_11188[2]);
  var_1 = getanimlength(self.a.var_11188[2]) * 1000;
  for(var_2 = randomint(2) + 1; var_2 > 0; var_2--) {
    var_3 = anglesToForward(self.angles);
    var_4 = self.origin + var_3 * var_0;
    if(!self maymovetopoint(var_4)) {
      break;
    }

    func_C86E("stumblingPain", self.a.var_11188[1]);
    scripts\anim\shared::donotetracks("stumblingPain");
  }

  self.a.nodeath = 1;
  self.a.var_10930 = "none";
  func_C86E("stumblingPainCollapse", self.a.var_11188[2], 1, 0.75);
  scripts\anim\notetracks::donotetracksintercept("stumblingPainCollapse", ::func_11189);
  scripts\anim\shared::donotetracks("stumblingPainCollapse");
  func_A6CE();
}

func_11189(var_0) {
  if(var_0 == "start_ragdoll") {
    scripts\anim\notetracks::handlenotetrack(var_0, "stumblingPainCollapse");
    return 1;
  }
}

func_10099() {
  if(!enemyisingeneraldirection(anglesToForward(self.angles))) {
    return 0;
  }

  return gettime() < self.var_527E;
}

func_5F71() {
  if(!isDefined(self.var_72CC)) {
    if(self.a.pose == "prone") {
      return 1;
    }

    if(self.a.movement == "stop") {
      if(randomfloat(1) < 0.4) {
        if(randomfloat(1) < 0.5) {
          return 1;
        }
      } else if(abs(self.var_E3) > 90) {
        return 1;
      }
    } else if(abs(self getspawnpoint_searchandrescue()) > 90) {
      return 1;
    }
  }

  if(self.a.pose != "prone") {
    var_0 = scripts\anim\utility::func_B027("crawl_death", self.a.pose + "_2_crawl");
    var_1 = var_0[randomint(var_0.size)];
    if(!func_9D9D(var_1)) {
      return 1;
    }

    thread func_5F74();
    func_C86C("falling", var_1, 1, 0.5, 1);
    scripts\anim\shared::donotetracks("falling");
  } else {
    thread func_5F74();
  }

  self.a.var_4876 = scripts\anim\utility::func_B027("crawl_death", "default_transition");
  self.a.var_10930 = "dying_crawl";
  func_4F64();
  var_2 = scripts\anim\utility::func_B027("crawl_death", "crawl");
  while(func_10031()) {
    if(!func_9D9D(var_2)) {
      return 1;
    }

    if(isDefined(self.var_4C41)) {
      self playSound(self.var_4C41);
    }

    func_C86E("crawling", var_2, 1, 0.1, 1);
    scripts\anim\shared::donotetracks("crawling");
  }

  self notify("done_crawling");
  if(!isDefined(self.var_72CC) && enemyisingeneraldirection(anglesToForward(self.angles) * -1)) {
    return 1;
  }

  var_3 = scripts\anim\utility::func_B027("crawl_death", "death");
  var_4 = var_3[randomint(var_3.size)];
  scripts\anim\death::func_CF0E(var_4);
  func_A6CE();
  self.a.var_10930 = "none";
  self.var_10957 = undefined;
  return 0;
}

func_5F74() {
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
  if(isDefined(self.a.var_486A)) {
    var_3 = self.a.var_486A;
  }

  if(isDefined(self.a.var_4869)) {
    var_4 = level._effect[self.a.var_4869];
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

func_5F73() {
  self endon("kill_long_death");
  self endon("death");
  self endon("end_dying_crawl_back_aim");
  if(isDefined(self.var_5F72)) {
    return;
  }

  self.var_5F72 = 1;
  self func_82AC(scripts\anim\utility::func_B027("crawl_death", "aim_4"), 1, 0);
  self func_82AC(scripts\anim\utility::func_B027("crawl_death", "aim_6"), 1, 0);
  var_0 = 0;
  for(;;) {
    var_1 = scripts\anim\utility_common::getyawtoenemy();
    var_2 = angleclamp180(var_1 - var_0);
    if(abs(var_2) > 3) {
      var_2 = scripts\engine\utility::sign(var_2) * 3;
    }

    var_1 = angleclamp180(var_0 + var_2);
    if(var_1 < 0) {
      if(var_1 < -45) {
        var_1 = -45;
      }

      var_3 = var_1 / -45;
      self give_attacker_kill_rewards(%dying_back_aim_4_wrapper, var_3, 0.05);
      self give_attacker_kill_rewards(%dying_back_aim_6_wrapper, 0, 0.05);
    } else {
      if(var_1 > 45) {
        var_1 = 45;
      }

      var_3 = var_1 / 45;
      self give_attacker_kill_rewards(%dying_back_aim_6_wrapper, var_3, 0.05);
      self give_attacker_kill_rewards(%dying_back_aim_4_wrapper, 0, 0.05);
    }

    var_0 = var_1;
    wait(0.05);
  }
}

func_10D8E() {
  self endon("kill_long_death");
  self endon("death");
  wait(0.5);
  thread func_5F73();
}

func_8977(var_0) {
  if(var_0 == "fire_spray") {
    if(!scripts\anim\utility_common::canseeenemy()) {
      return 1;
    }

    if(!func_1A3C()) {
      return 1;
    }

    scripts\anim\utility_common::shootenemywrapper();
    return 1;
  } else if(var_0 == "pistol_pickup") {
    thread func_10D8E();
    return 0;
  }

  return 0;
}

func_1A3C() {
  var_0 = self.enemy getshootatpos();
  var_1 = self getspawnpointdist();
  var_2 = vectortoangles(var_0 - self getmuzzlepos());
  var_3 = scripts\engine\utility::absangleclamp180(var_1[1] - var_2[1]);
  if(var_3 > level.var_C88B) {
    if(distancesquared(self getEye(), var_0) > level.var_C889 || var_3 > level.var_C88A) {
      return 0;
    }
  }

  return scripts\engine\utility::absangleclamp180(var_1[0] - var_2[0]) <= level.var_C87D;
}

enemyisingeneraldirection(var_0) {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  var_1 = vectornormalize(self.enemy getshootatpos() - self getEye());
  return vectordot(var_1, var_0) > 0.5;
}

func_D899(var_0) {
  self endon("kill_long_death");
  self endon("death");
  self.var_6EC4 = 1;
  self.var_AFE7 = 1;
  self.a.var_58DA = 1;
  self notify("long_death");
  self.health = 10000;
  self.var_33F = self.var_33F - 2000;
  wait(0.75);
  if(self.health > 1) {
    self.health = 1;
  }

  wait(0.05);
  self.var_AFE7 = undefined;
  self.a.var_B4E7 = 1;
  if(var_0 == "crawling") {
    wait(1);
    if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 1048576) {
      anim.var_C222 = randomintrange(10, 30);
      anim.var_BF77 = gettime() + randomintrange(15000, -5536);
    } else {
      anim.var_C222 = randomintrange(5, 12);
      anim.var_BF77 = gettime() + randomintrange(5000, 25000);
    }

    anim.var_BF78 = gettime() + randomintrange(7000, 13000);
    return;
  }

  if(var_0 == "corner_grenade") {
    wait(1);
    if(isDefined(level.player) && distancesquared(self.origin, level.player.origin) < 490000) {
      anim.var_C221 = randomintrange(10, 30);
      anim.var_BF76 = gettime() + randomintrange(15000, -5536);
      return;
    }

    anim.var_C221 = randomintrange(5, 12);
    anim.var_BF76 = gettime() + randomintrange(5000, 25000);
    return;
  }
}

func_4F64() {
  if(isDefined(self.a.var_7280)) {
    self.a.var_C21F = self.a.var_7280;
    return;
  }

  self.a.var_C21F = randomintrange(1, 5);
}

func_10031() {
  if(!self.a.var_C21F) {
    self.a.var_C21F = undefined;
    return 0;
  }

  self.a.var_C21F--;
  return 1;
}

func_12893() {
  if(level.var_C221 > 0) {
    return 0;
  }

  if(gettime() < level.var_BF76) {
    return 0;
  }

  if(self.a.disablelongdeath || self.var_EF || self.var_E0) {
    return 0;
  }

  if(isDefined(self.var_4E46)) {
    return 0;
  }

  if(distance(self.origin, level.player.origin) < 175) {
    return 0;
  }

  anim.var_BF76 = gettime() + 3000;
  thread func_4669();
  self waittill("killanimscript");
  return 1;
}

func_4669() {
    self endon("kill_long_death");
    self endon("death");
    thread func_C874();
    thread func_D899("corner_grenade");
    thread scripts\sp\utility::func_F2DA(0);
    self.var_33F = -1000;
    func_C86D("corner_grenade_pain", scripts\anim\utility::func_B027("corner_grenade_death", "pain"), %body, 1, 0.1);
    self waittillmatch("dropgun", "corner_grenade_pain");
    scripts\anim\shared::func_5D1A();
    self waittillmatch("anim_pose = \"back\","corner_grenade_pain");
      scripts\anim\notetracks::notetrackposeback(); self waittillmatch("grenade_left", "corner_grenade_pain"); var_0 = getweaponmodel("fraggrenade"); self attach(var_0, "tag_inhand"); self.var_4E46 = ::func_D850; self waittillmatch("end", "corner_grenade_pain"); var_1 = gettime() + randomintrange(25000, -5536); func_C86D("corner_grenade_idle", scripts\anim\utility::func_B027("corner_grenade_death", "pain"), %body, 1, 0.2); thread func_13A17();
      while(!func_6560()) {
        if(gettime() >= var_1) {
          break;
        }

        scripts\anim\notetracks::donotetracksfortime(0.1, "corner_grenade_idle");
      }

      var_2 = scripts\anim\utility::func_B027("corner_grenade_death", "release"); func_C86D("corner_grenade_release", var_2, %body, 1, 0.2); var_3 = getnotetracktimes(var_2, "grenade_drop"); var_4 = var_3[0] * getanimlength(var_2); wait(var_4 - 1); scripts\anim\death::playdeathsound(); wait(0.7); self.var_4E46 = ::waittillhelisdead; var_5 = (0, 0, 30) - anglestoright(self.angles) * 70; func_4663(var_5, randomfloatrange(2, 3)); wait(0.05); self detach(var_0, "tag_inhand"); thread func_A678();
    }

    func_4663(var_0, var_1) {
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

      thread func_D527("grenade_bounce", var_2);
      self.grenadeweapon = "fraggrenade";
      self getuniqueobjectid(var_2, var_0, var_1);
    }

    func_D527(var_0, var_1) {
      var_2 = spawn("script_origin", var_1);
      var_2 playSound(var_0, "sounddone");
      var_2 waittill("sounddone");
      var_2 delete();
    }

    func_A678() {
      self.a.nodeath = 1;
      func_A6CE();
      self giverankxp();
      wait(0.1);
      self notify("grenade_drop_done");
    }

    func_A6CE() {
      if(isDefined(self.var_A8AA)) {
        self func_81D0(self.origin, self.var_A8AA);
        return;
      }

      self func_81D0();
    }

    func_6560() {
      if(!isDefined(self.enemy)) {
        return 0;
      }

      if(distancesquared(self.origin, self.enemy.origin) > 147456) {
        return 0;
      }

      if(distancesquared(self.origin, self.enemy.origin) < 16384) {
        return 1;
      }

      var_0 = self.enemy.origin + self.var_6579 * 3;
      var_1 = self.enemy.origin;
      if(self.enemy.origin != var_0) {
        var_1 = pointonsegmentnearesttopoint(self.enemy.origin, var_0, self.origin);
      }

      if(distancesquared(self.origin, var_1) < 16384) {
        return 1;
      }

      return 0;
    }

    func_D850() {
      var_0 = scripts\anim\utility::func_B027("corner_grenade_death", "premature_death");
      var_1 = var_0[randomint(var_0.size)];
      scripts\anim\death::playdeathsound();
      func_C86D("corner_grenade_die", var_1, %body, 1, 0.2);
      var_2 = scripts\anim\combat_utility::func_7EE3();
      func_4663(var_2, 3);
      var_3 = getweaponmodel("fraggrenade");
      self detach(var_3, "tag_inhand");
      wait(0.05);
      self giverankxp();
      self waittillmatch("end", "corner_grenade_die");
    }

    waittillhelisdead() {
      self waittill("grenade_drop_done");
    }

    func_13A17() {
      self endon("kill_long_death");
      self endon("death");
      self.var_6579 = (0, 0, 0);
      var_0 = undefined;
      var_1 = self.origin;
      var_2 = 0.15;
      for(;;) {
        if(isDefined(self.enemy) && isDefined(var_0) && self.enemy == var_0) {
          var_3 = self.enemy.origin;
          self.var_6579 = var_3 - var_1 * 1 / var_2;
          var_1 = var_3;
        } else {
          if(isDefined(self.enemy)) {
            var_1 = self.enemy.origin;
          } else {
            var_1 = self.origin;
          }

          var_0 = self.enemy;
          self.var_FE9F = (0, 0, 0);
        }

        wait(var_2);
      }
    }

    func_17DD(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
      self endon("death");
      if(!isDefined(self)) {
        return;
      }

      if(isDefined(self.var_58D6)) {
        return;
      }

      if(var_0 < self.soundexists) {
        return;
      }

      self.var_58D6 = 1;
      var_7 = undefined;
      if(scripts\engine\utility::damagelocationisany("left_arm_lower", "left_arm_upper", "left_hand")) {
        var_7 = scripts\anim\utility::func_B027("additive_pain", "left_arm");
      }

      if(scripts\engine\utility::damagelocationisany("right_arm_lower", "right_arm_upper", "right_hand")) {
        var_7 = scripts\anim\utility::func_B027("additive_pain", "right_arm");
      } else if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot")) {
        var_7 = scripts\anim\utility::func_B027("additive_pain", "left_leg");
      } else if(scripts\engine\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot")) {
        var_7 = scripts\anim\utility::func_B027("additive_pain", "right_leg");
      } else {
        var_8 = scripts\anim\utility::func_B027("additive_pain", "default");
        var_7 = var_8[randomint(var_8.size)];
      }

      self func_82AC(%add_pain, 1, 0.1, 1);
      self func_82AC(var_7, 1, 0, 1);
      wait(0.4);
      self clearanim(var_7, 0.2);
      self clearanim(%add_pain, 0.2);
      self.var_58D6 = undefined;
    }

    func_C86C(var_0, var_1, var_2, var_3, var_4) {
      if(!isDefined(var_2)) {
        var_2 = 1;
      }

      if(!isDefined(var_3)) {
        var_3 = 0.2;
      }

      if(!isDefined(var_4)) {
        var_4 = 1;
      }

      self give_left_powers(var_0, var_1, var_2, var_3, var_4);
      self.facialanimidx = scripts\anim\face::playfacialanim(var_1, "pain", self.facialanimidx);
    }

    func_C86E(var_0, var_1, var_2, var_3, var_4) {
      if(!isDefined(var_2)) {
        var_2 = 1;
      }

      if(!isDefined(var_3)) {
        var_3 = 0.2;
      }

      if(!isDefined(var_4)) {
        var_4 = 1;
      }

      self func_82E7(var_0, var_1, var_2, var_3, var_4);
      self.facialanimidx = scripts\anim\face::playfacialanim(var_1, "pain", self.facialanimidx);
    }

    func_C86D(var_0, var_1, var_2, var_3, var_4, var_5) {
      if(!isDefined(var_3)) {
        var_3 = 1;
      }

      if(!isDefined(var_4)) {
        var_4 = 0.2;
      }

      if(!isDefined(var_5)) {
        var_5 = 1;
      }

      self func_82E4(var_0, var_1, var_2, var_3, var_4, var_5);
      self.facialanimidx = scripts\anim\face::playfacialanim(var_1, "pain", self.facialanimidx);
    }