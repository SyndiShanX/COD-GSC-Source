/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\pain.gsc
********************************/

#using_animtree("generic_human");

init_animset_pain() {
  var_0 = [];
  var_0["damage_shield_crouch"] = % exposed_crouch_extendedpaina;
  var_0["damage_shield_pain_array"] = [ % stand_exposed_extendedpain_chest, % stand_exposed_extendedpain_head_2_crouch, % stand_exposed_extendedpain_hip_2_crouch];
  var_0["back"] = % back_pain;
  var_0["run_long"] = [ % run_pain_leg, % run_pain_shoulder, % run_pain_stomach_stumble, % run_pain_head, % run_pain_fallonknee_02, % run_pain_stomach, % run_pain_stumble, % run_pain_stomach_fast, % run_pain_leg_fast, % run_pain_fall];
  var_0["run_medium"] = [ % run_pain_fallonknee_02, % run_pain_stomach, % run_pain_stumble, % run_pain_stomach_fast, % run_pain_leg_fast, % run_pain_fall];
  var_0["run_short"] = [ % run_pain_fallonknee, % run_pain_fallonknee_03];
  var_0["pistol_torso_upper"] = [ % pistol_stand_pain_chest, % pistol_stand_pain_rightshoulder, % pistol_stand_pain_leftshoulder];
  var_0["pistol_torso_lower"] = [ % pistol_stand_pain_chest, % pistol_stand_pain_groin];
  var_0["pistol_neck"] = [ % pistol_stand_pain_chest, % pistol_stand_pain_head];
  var_0["pistol_head"] = [ % pistol_stand_pain_head];
  var_0["pistol_leg"] = [ % pistol_stand_pain_groin];
  var_0["pistol_left_arm_upper"] = [ % pistol_stand_pain_chest, % pistol_stand_pain_leftshoulder];
  var_0["pistol_right_arm_upper"] = [ % pistol_stand_pain_chest, % pistol_stand_pain_rightshoulder];
  var_0["pistol_left_arm_lower"] = [ % pistol_stand_pain_leftshoulder];
  var_0["pistol_right_arm_lower"] = [ % pistol_stand_pain_rightshoulder];
  var_0["pistol_default1"] = [ % pistol_stand_pain_chest];
  var_0["pistol_default2"] = [ % pistol_stand_pain_groin];
  var_0["torso_pistol"] = % pistol_stand_pain_chest;
  var_0["torso_upper"] = [ % exposed_pain_face, % stand_exposed_extendedpain_neck];
  var_0["torso_upper_extended"] = [ % stand_exposed_extendedpain_gut, % stand_exposed_extendedpain_stomach, % stand_exposed_extendedpain_head_2_crouch];
  var_0["torso_lower"] = [ % exposed_pain_groin, % stand_exposed_extendedpain_hip];
  var_0["torso_lower_extended"] = [ % stand_exposed_extendedpain_gut, % stand_exposed_extendedpain_stomach, % stand_exposed_extendedpain_hip_2_crouch, % stand_exposed_extendedpain_feet_2_crouch, % stand_exposed_extendedpain_stomach];
  var_0["head"] = [ % exposed_pain_face, % stand_exposed_extendedpain_neck];
  var_0["head_extended"] = [ % stand_exposed_extendedpain_head_2_crouch];
  var_0["right_arm"] = [ % exposed_pain_right_arm];
  var_0["right_arm_extended"] = [];
  var_0["left_arm"] = [ % stand_exposed_extendedpain_shoulderswing];
  var_0["left_arm_extended"] = [ % stand_exposed_extendedpain_shoulder_2_crouch];
  var_0["leg"] = [ % exposed_pain_groin, % stand_exposed_extendedpain_hip];
  var_0["leg_extended"] = [ % stand_exposed_extendedpain_hip_2_crouch, % stand_exposed_extendedpain_feet_2_crouch, % stand_exposed_extendedpain_stomach];
  var_0["foot"] = [ % stand_exposed_extendedpain_thigh];
  var_0["foot_extended"] = [ % stand_exposed_extendedpain_feet_2_crouch];
  var_0["default_long"] = [ % exposed_pain_2_crouch, % stand_extendedpainb];
  var_0["default_short"] = [ % exposed_pain_right_arm, % exposed_pain_face, % exposed_pain_groin];
  var_0["default_extended"] = [ % stand_extendedpainc, % stand_exposed_extendedpain_chest];
  var_0["crouch_longdeath"] = [ % exposed_crouch_extendedpaina];
  var_0["crouch_default"] = [ % exposed_crouch_pain_chest, % exposed_crouch_pain_headsnap, % exposed_crouch_pain_flinch];
  var_0["crouch_left_arm"] = [ % exposed_crouch_pain_left_arm];
  var_0["crouch_right_arm"] = [ % exposed_crouch_pain_right_arm];
  var_0["prone"] = [ % prone_reaction_a, % prone_reaction_b];
  var_0["cover_left_stand"] = [ % corner_standl_painb, % corner_standl_painc, % corner_standl_paind, % corner_standl_paine];
  var_0["cover_left_crouch"] = [[ % h1_cornercrl_painb_2],
    [ % cornercrl_painb]
  ];
  var_0["cover_right_stand"] = [ % corner_standr_pain, % corner_standr_painb, % corner_standr_painc];
  var_0["cover_right_crouch"] = [[ % h1_cornercrr_alert_paina_2, % h1_cornercrr_alert_painb_2, % h1_cornercrr_alert_painc_2],
    [ % cornercrr_alert_paina, % cornercrr_alert_painc]
  ];
  var_0["cover_right_stand_A"] = % h1_cornerstndr_pain_2_cover_a;
  var_0["cover_right_stand_B"] = % h1_cornerstndr_pain_2_cover_b;
  var_0["cover_left_stand_A"] = % h1_cornerstndl_pain_2_cover_a;
  var_0["cover_left_stand_B"] = % h1_cornerstndl_pain_2_cover_b;
  var_0["cover_crouch"] = [ % covercrouch_pain_front, % covercrouch_pain_left_3];
  var_0["cover_stand"] = [ % coverstand_pain_groin, % coverstand_pain_leg];
  var_0["cover_stand_aim"] = [ % coverstand_pain_aim_2_hide_01, % coverstand_pain_aim_2_hide_02];
  var_0["smg_cover_stand_aim"] = [ % smg_coverstand_pain_aim_2_hide_01, % smg_coverstand_pain_aim_2_hide_02];
  var_0["cover_crouch_aim"] = [ % covercrouch_pain_aim_2_hide_01];
  var_0["saw_stand"] = % saw_gunner_pain;
  var_0["saw_crouch"] = % saw_gunner_lowwall_pain_02;
  var_0["saw_prone"] = % saw_gunner_prone_pain;
  anim.archetypes["soldier"]["pain"] = var_0;
  var_0 = [];
  var_0["prone_transition"] = [ % dying_crawl_2_back];
  var_0["stand_transition"] = [ % dying_stand_2_back_v1, % dying_stand_2_back_v2];
  var_0["crouch_transition"] = [ % dying_crouch_2_back];
  var_0["default_transition"] = % dying_crawl_2_back;
  var_0["stand_2_crawl"] = [ % dying_stand_2_crawl_v1, % dying_stand_2_crawl_v2, % dying_stand_2_crawl_v3];
  var_0["crouch_2_crawl"] = [ % dying_crouch_2_crawl];
  var_0["crawl"] = % dying_crawl;
  var_0["death"] = [ % dying_crawl_death_v1, % dying_crawl_death_v2];
  var_0["back_idle"] = % dying_back_idle;
  var_0["back_idle_twitch"] = [ % dying_back_twitch_a, % dying_back_twitch_b];
  var_0["back_crawl"] = % dying_crawl_back;
  var_0["back_fire"] = % dying_back_fire;
  var_0["back_death"] = [ % dying_back_death_v1, % dying_back_death_v2, % dying_back_death_v3];
  var_0["aim_4"] = % dying_back_aim_4;
  var_0["aim_6"] = % dying_back_aim_6;
  var_0["longdeath"] = [];
  var_0["longdeath"]["gut_b"] = [[ % stand_2_longdeath_wander_gut, % longdeath_wander_gut, % longdeath_wander_gut_collapse, % longdeath_wander_gut_death],
    [ % stand_2_longdeath_gut_wounded_b, % longdeath_gut_wounded_b_walk, % longdeath_gut_wounded_b_collapse],
    [ % stand_2_longdeath_gut_b, % longdeath_gut_b_walk, % longdeath_gut_b_impact]
  ];
  var_0["longdeath"]["gut_l"] = [[ % stand_2_longdeath_gut_l, % longdeath_gut_l_walk, % longdeath_gut_l_impact]
  ];
  var_0["longdeath"]["gut_r"] = [[ % stand_2_longdeath_gut_r, % longdeath_gut_r_walk, % longdeath_gut_r_impact]
  ];
  var_0["longdeath"]["leg_b"] = [[ % stand_2_longdeath_wander_leg_1, % longdeath_wander_leg_1, % longdeath_wander_leg_collapse_1, % longdeath_wander_leg_death],
    [ % stand_2_longdeath_wander_leg_2, % longdeath_wander_leg_2, % longdeath_wander_leg_collapse_2, % longdeath_wander_leg_death],
    [ % stand_2_longdeath_leg_wounded_b_1, % longdeath_leg_wounded_b_walk_1, % longdeath_leg_wounded_b_collapse_1],
    [ % stand_2_longdeath_leg_wounded_b_2, % longdeath_leg_wounded_b_walk_2, % longdeath_leg_wounded_b_collapse_2]
  ];
  anim.archetypes["soldier"]["crawl_death"] = var_0;
  var_0 = [];
  var_0["pain"] = % corner_standr_death_grenade_hit;
  var_0["idle"] = % corner_standr_death_grenade_idle;
  var_0["release"] = % corner_standr_death_grenade_slump;
  var_0["premature_death"] = [ % dying_back_death_v1, % dying_back_death_v2, % dying_back_death_v3, % dying_back_death_v4];
  anim.archetypes["soldier"]["corner_grenade_death"] = var_0;
  var_0 = [];
  var_0["default"] = [ % pain_add_standing_belly, % pain_add_standing_left_arm, % pain_add_standing_right_arm];
  var_0["left_arm"] = % pain_add_standing_left_arm;
  var_0["right_arm"] = % pain_add_standing_right_arm;
  var_0["left_leg"] = % pain_add_standing_left_leg;
  var_0["right_leg"] = % pain_add_standing_right_leg;
  anim.archetypes["soldier"]["additive_pain"] = var_0;
}

shouldplaypreh1painanim() {
  if(isdefined(self.preh1_pain_anims) && self.preh1_pain_anims)
    return 1;

  return 0;
}

verifypreh1() {}

verifyh1() {}

main() {
  if(!animscripts\utility::using_improved_transitions())
    self.preh1_pain_anims = 1;

  if(isdefined(self.longdeathstarting)) {
    self waittill("killanimscript");
    return;
  }

  if([
      [anim.pain_test]
    ]()) {
    return;
  }
  if(self.a.disablepain) {
    return;
  }
  self notify("kill_long_death");
  self.facialanimidx = undefined;

  if(isdefined(self.a.paintime))
    self.a.lastpaintime = self.a.paintime;
  else
    self.a.lastpaintime = 0;

  if(isdefined(self.magic_bullet_shield) && self.magic_bullet_shield && gettime() - self.a.lastpaintime < 1500) {
    return;
  }
  self.a.paintime = gettime();

  if(self.stairsstate != "none")
    self.a.painonstairs = 1;
  else
    self.a.painonstairs = undefined;

  if(self.a.nextstandinghitdying)
    self.health = 1;

  self notify("anim entered pain");
  self endon("killanimscript");
  animscripts\utility::initialize("pain");
  self animmode("gravity");

  if(!isdefined(self.no_pain_sound))
    animscripts\face::saygenericdialogue("pain");

  if(self.damagelocation == "helmet")
    animscripts\death::helmetpop();
  else if(wasdamagedbyexplosive() && randomint(2) == 0)
    animscripts\death::helmetpop();

  if(isdefined(self.painfunction)) {
    self[[self.painfunction]]();
    return;
  }

  if(crawlingpain()) {
    return;
  }
  if(specialpain(self.a.special)) {
    return;
  }
  var_0 = getpainanim();

  if(isdefined(var_0))
    self.a.painanimlength = getanimlength(var_0);

  playpainanim(var_0);
}

initpainfx() {
  level._effect["crawling_death_blood_smear"] = loadfx("vfx\blood\blood_smear_decal");
}

end_script() {
  if(isdefined(self.damageshieldpain)) {
    self.damageshieldcounter = undefined;
    self.damageshieldpain = undefined;
    self.allowpain = 1;

    if(!isdefined(self.predamageshieldignoreme))
      self.ignoreme = 0;

    self.predamageshieldignoreme = undefined;
  }

  if(isdefined(self.blockingpain)) {
    self.blockingpain = undefined;
    self.allowpain = 1;
  }

  self clearanim( % head, 0.2);
  self.facialanimidx = undefined;
}

wasdamagedbyexplosive() {
  if(isexplosivedamagemod(self.damagemod))
    return 1;

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

getdamageshieldpainanim() {
  verifyh1();

  if(self.a.pose == "prone") {
    return;
  }
  if(isdefined(self.lastattacker) && isdefined(self.lastattacker.team) && self.lastattacker.team == self.team) {
    return;
  }
  if(!isdefined(self.damageshieldcounter) || gettime() - self.a.lastpaintime > 1500)
    self.damageshieldcounter = randomintrange(2, 3);

  if(isdefined(self.lastattacker) && distancesquared(self.origin, self.lastattacker.origin) < squared(512))
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

    if(animscripts\utility::usingsidearm())
      animscripts\shared::placeweaponon(self.primaryweapon, "right");

    if(self.a.pose == "crouch")
      return animscripts\utility::lookupanim("pain", "damage_shield_crouch");

    var_0 = animscripts\utility::lookupanim("pain", "damage_shield_pain_array");
  }
}

getpainanim_preh1() {
  verifypreh1();

  if(self.a.pose == "stand") {
    if(self.a.movement == "run" && self getmotionangle() < 60 && self getmotionangle() > -60)
      return getrunningforwardpainanim_preh1();

    self.a.movement = "stop";
    return getstandpainanim_preh1();
  } else if(self.a.pose == "crouch") {
    self.a.movement = "stop";
    return getcrouchpainanim_preh1();
  } else if(self.a.pose == "prone") {
    self.a.movement = "stop";
    return getpronepainanim_preh1();
  } else {
    self.a.movement = "stop";
    return % back_pain;
  }
}

getpainanim() {
  if(shouldplaypreh1painanim())
    return getpainanim_preh1();

  verifyh1();

  if(self.damageshield && !isdefined(self.disabledamageshieldpain)) {
    var_0 = getdamageshieldpainanim();

    if(isdefined(var_0))
      return var_0;
  }

  if(isdefined(self.a.onback)) {
    if(self.a.pose == "crouch")
      return animscripts\utility::lookupanim("pain", "back");
    else
      animscripts\notetracks::stoponback();
  }

  if(self.a.pose == "stand") {
    var_1 = isdefined(self.node) && distancesquared(self.origin, self.node.origin) < 4096;

    if(!var_1 && self.a.movement == "run" && abs(self getmotionangle()) < 60)
      return getrunningforwardpainanim();

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

removeblockedanims(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = getmovedelta(var_0[var_2], 0, 1);
    var_4 = self localtoworldcoords(var_3);

    if(self maymovetopoint(var_4))
      var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

getrunningforwardpainanim_preh1() {
  verifypreh1();
  var_0 = animscripts\utility::array( % run_pain_fallonknee, % run_pain_fallonknee_02, % run_pain_fallonknee_03, % run_pain_stomach, % run_pain_stumble);
  var_0 = removeblockedanims(var_0);

  if(!var_0.size) {
    self.a.movement = "stop";
    return getstandpainanim_preh1();
  }

  return var_0[randomint(var_0.size)];
}

getrunningforwardpainanim() {
  verifyh1();
  var_0 = [];
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  if(self maymovetopoint(self localtoworldcoords((300, 0, 0)))) {
    var_2 = 1;
    var_1 = 1;
  } else if(self maymovetopoint(self localtoworldcoords((200, 0, 0))))
    var_1 = 1;

  if(isdefined(self.a.disablelongpain)) {
    var_2 = 0;
    var_1 = 0;
  }

  if(var_2)
    var_0 = animscripts\utility::lookupanim("pain", "run_long");
  else if(var_1)
    var_0 = animscripts\utility::lookupanim("pain", "run_medium");
  else if(self maymovetopoint(self localtoworldcoords((120, 0, 0))))
    var_0 = animscripts\utility::lookupanim("pain", "run_short");

  if(!var_0.size) {
    self.a.movement = "stop";
    return getstandpainanim();
  }

  return var_0[randomint(var_0.size)];
}

getstandpistolpainanim() {
  var_0 = [];

  if(animscripts\utility::damagelocationisany("torso_upper"))
    var_0 = animscripts\utility::lookupanim("pain", "pistol_torso_upper");
  else if(animscripts\utility::damagelocationisany("torso_lower"))
    var_0 = animscripts\utility::lookupanim("pain", "pistol_torso_lower");
  else if(animscripts\utility::damagelocationisany("neck"))
    var_0 = animscripts\utility::lookupanim("pain", "pistol_neck");
  else if(animscripts\utility::damagelocationisany("head"))
    var_0 = animscripts\utility::lookupanim("pain", "pistol_head");
  else if(animscripts\utility::damagelocationisany("left_leg_upper", "right_leg_upper"))
    var_0 = animscripts\utility::lookupanim("pain", "pistol_leg");
  else if(animscripts\utility::damagelocationisany("left_arm_upper"))
    var_0 = animscripts\utility::lookupanim("pain", "pistol_left_arm_upper");
  else if(animscripts\utility::damagelocationisany("left_arm_lower"))
    var_0 = animscripts\utility::lookupanim("pain", "pistol_left_arm_lower");
  else if(animscripts\utility::damagelocationisany("right_arm_upper"))
    var_0 = animscripts\utility::lookupanim("pain", "pistol_right_arm_upper");
  else if(animscripts\utility::damagelocationisany("right_arm_lower"))
    var_0 = animscripts\utility::lookupanim("pain", "pistol_right_arm_lower");

  if(var_0.size < 2)
    var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("pain", "pistol_default1"));

  if(var_0.size < 2)
    var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("pain", "pistol_default2"));

  return var_0[randomint(var_0.size)];
}

weaponanims() {
  var_0 = getweaponmodel(self.weapon);

  if(isdefined(self.holdingweapon) && !self.holdingweapon || var_0 == "")
    return "none";

  var_1 = weaponclass(self.weapon);

  switch (var_1) {
    case "smg":
    case "mg":
      return "rifle";
    case "rifle":
    case "spread":
    case "rocketlauncher":
    case "pistol":
      return var_1;
    default:
      return "rifle";
  }
}

getstandpainanim_preh1() {
  verifypreh1();
  var_0 = [];

  if(weaponanims() == "pistol") {
    if(animscripts\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck"))
      var_0[var_0.size] = % pistol_stand_pain_chest;

    if(animscripts\utility::damagelocationisany("torso_lower", "left_leg_upper", "right_leg_upper"))
      var_0[var_0.size] = % pistol_stand_pain_groin;

    if(animscripts\utility::damagelocationisany("head", "neck"))
      var_0[var_0.size] = % pistol_stand_pain_head;

    if(animscripts\utility::damagelocationisany("left_arm_lower", "left_arm_upper", "torso_upper"))
      var_0[var_0.size] = % pistol_stand_pain_leftshoulder;

    if(animscripts\utility::damagelocationisany("right_arm_lower", "right_arm_upper", "torso_upper"))
      var_0[var_0.size] = % pistol_stand_pain_rightshoulder;

    if(var_0.size < 2)
      var_0[var_0.size] = % pistol_stand_pain_chest;

    if(var_0.size < 2)
      var_0[var_0.size] = % pistol_stand_pain_groin;
  } else {
    var_1 = self.damagetaken / self.maxhealth;

    if(var_1 > 0.4 && !animscripts\utility::damagelocationisany("left_hand", "right_hand", "left_foot", "right_foot", "helmet"))
      var_0[var_0.size] = % exposed_pain_2_crouch;

    if(animscripts\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck"))
      var_0[var_0.size] = % exposed_pain_back;

    if(animscripts\utility::damagelocationisany("right_hand", "right_arm_upper", "right_arm_lower", "torso_upper"))
      var_0[var_0.size] = % exposed_pain_dropgun;

    if(animscripts\utility::damagelocationisany("torso_lower", "left_leg_upper", "right_leg_upper"))
      var_0[var_0.size] = % exposed_pain_groin;

    if(animscripts\utility::damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper"))
      var_0[var_0.size] = % exposed_pain_left_arm;

    if(animscripts\utility::damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper"))
      var_0[var_0.size] = % exposed_pain_right_arm;

    if(animscripts\utility::damagelocationisany("left_foot", "right_foot", "left_leg_lower", "right_leg_lower", "left_leg_upper", "right_leg_upper"))
      var_0[var_0.size] = % exposed_pain_leg;

    if(var_0.size < 2)
      var_0[var_0.size] = % exposed_pain_back;

    if(var_0.size < 2)
      var_0[var_0.size] = % exposed_pain_dropgun;
  }

  return var_0[randomint(var_0.size)];
}

getstandpainanim() {
  verifyh1();

  if(animscripts\utility::usingsidearm())
    return getstandpistolpainanim();

  var_0 = [];
  var_1 = [];

  if(animscripts\utility::damagelocationisany("torso_upper")) {
    var_0 = animscripts\utility::lookupanim("pain", "torso_upper");
    var_1 = animscripts\utility::lookupanim("pain", "torso_upper_extended");
  } else if(animscripts\utility::damagelocationisany("torso_lower")) {
    var_0 = animscripts\utility::lookupanim("pain", "torso_lower");
    var_1 = animscripts\utility::lookupanim("pain", "torso_lower_extended");
  } else if(animscripts\utility::damagelocationisany("head", "helmet", "neck")) {
    var_0 = animscripts\utility::lookupanim("pain", "head");
    var_1 = animscripts\utility::lookupanim("pain", "head_extended");
  } else if(animscripts\utility::damagelocationisany("right_arm_upper", "right_arm_lower")) {
    var_0 = animscripts\utility::lookupanim("pain", "right_arm");
    var_1 = animscripts\utility::lookupanim("pain", "right_arm_extended");
  } else if(animscripts\utility::damagelocationisany("left_arm_upper", "left_arm_lower")) {
    var_0 = animscripts\utility::lookupanim("pain", "left_arm");
    var_1 = animscripts\utility::lookupanim("pain", "left_arm_extended");
  } else if(animscripts\utility::damagelocationisany("left_leg_upper", "right_leg_upper")) {
    var_0 = animscripts\utility::lookupanim("pain", "leg");
    var_1 = animscripts\utility::lookupanim("pain", "leg_extended");
  } else if(animscripts\utility::damagelocationisany("left_foot", "right_foot", "left_leg_lower", "right_leg_lower")) {
    var_0 = animscripts\utility::lookupanim("pain", "foot");
    var_1 = animscripts\utility::lookupanim("pain", "foot_extended");
  }

  if(var_0.size < 2) {
    if(!self.a.disablelongdeath)
      var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("pain", "default_long"));
    else
      var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("pain", "default_short"));
  }

  if(var_1.size < 2)
    var_1 = common_scripts\utility::array_combine(var_1, animscripts\utility::lookupanim("pain", "default_extended"));

  if(!self.damageshield && !self.a.disablelongdeath) {
    var_2 = randomint(var_0.size + var_1.size);

    if(var_2 < var_0.size)
      return var_0[var_2];
    else
      return var_1[var_2 - var_0.size];
  }

  return var_0[randomint(var_0.size)];
}

getcrouchpainanim_preh1() {
  verifypreh1();
  var_0 = [];

  if(animscripts\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck"))
    var_0[var_0.size] = % exposed_crouch_pain_chest;

  if(animscripts\utility::damagelocationisany("head", "neck", "torso_upper"))
    var_0[var_0.size] = % exposed_crouch_pain_headsnap;

  if(animscripts\utility::damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper"))
    var_0[var_0.size] = % exposed_crouch_pain_left_arm;

  if(animscripts\utility::damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper"))
    var_0[var_0.size] = % exposed_crouch_pain_right_arm;

  if(var_0.size < 2)
    var_0[var_0.size] = % exposed_crouch_pain_flinch;

  if(var_0.size < 2)
    var_0[var_0.size] = % exposed_crouch_pain_chest;

  return var_0[randomint(var_0.size)];
}

getcrouchpainanim() {
  verifyh1();
  var_0 = [];

  if(!self.damageshield && !self.a.disablelongdeath)
    var_0 = animscripts\utility::lookupanim("pain", "crouch_longdeath");

  var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("pain", "crouch_default"));

  if(animscripts\utility::damagelocationisany("left_hand", "left_arm_lower", "left_arm_upper"))
    var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("pain", "crouch_left_arm"));

  if(animscripts\utility::damagelocationisany("right_hand", "right_arm_lower", "right_arm_upper"))
    var_0 = common_scripts\utility::array_combine(var_0, animscripts\utility::lookupanim("pain", "crouch_right_arm"));

  return var_0[randomint(var_0.size)];
}

getpronepainanim_preh1() {
  verifypreh1();

  if(randomint(2) == 0)
    return % prone_reaction_a;
  else
    return % prone_reaction_b;
}

getpronepainanim() {
  verifyh1();
  var_0 = animscripts\utility::lookupanim("pain", "prone");
  return var_0[randomint(var_0.size)];
}

playpainanim_preh1(var_0) {
  verifypreh1();

  if(isdefined(self.magic_bullet_shield))
    var_1 = 1.5;
  else
    var_1 = self.animplaybackrate;

  self setflaggedanimknoballrestart("painanim", var_0, % body, 1, 0.1, var_1);

  if(self.a.pose == "prone")
    self updateprone( % prone_legs_up, % prone_legs_down, 1, 0.1, 1);

  if(animhasnotetrack(var_0, "start_aim")) {
    thread notifystartaim("painanim");
    self endon("start_aim");
  }

  animscripts\shared::donotetracks("painanim");
}

playpainanim(var_0) {
  if(shouldplaypreh1painanim()) {
    playpainanim_preh1(var_0);
    return;
  }

  verifyh1();
  var_1 = 1;
  pain_setflaggedanimknoballrestart("painanim", var_0, % body, 1, 0.1, var_1);

  if(self.a.pose == "prone")
    self updateprone( % prone_legs_up, % prone_legs_down, 1, 0.1, 1);

  if(animhasnotetrack(var_0, "start_aim")) {
    thread notifystartaim("painanim");
    self endon("start_aim");
  }

  if(animhasnotetrack(var_0, "code_move"))
    animscripts\shared::donotetracks("painanim");

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
  if(var_0 == "none")
    return 0;

  self.a.special = "none";
  thread specialpainblocker();

  switch (var_0) {
    case "cover_left":
      if(self.a.pose == "stand") {
        var_1 = animscripts\utility::lookupanim("pain", "cover_left_stand");
        dopainfromarray(var_1);
        var_2 = 1;
      } else if(self.a.pose == "crouch") {
        var_1 = animscripts\utility::lookupanim("pain", "cover_left_crouch")[animscripts\corner::shouldplayalerttransition(self)];
        dopainfromarray(var_1);
        var_2 = 1;
      } else
        var_2 = 0;

      break;
    case "cover_right":
      if(self.a.pose == "stand") {
        var_1 = animscripts\utility::lookupanim("pain", "cover_right_stand");
        dopainfromarray(var_1);
        var_2 = 1;
      } else if(self.a.pose == "crouch") {
        var_1 = animscripts\utility::lookupanim("pain", "cover_right_crouch")[animscripts\corner::shouldplayalerttransition(self)];
        dopainfromarray(var_1);
        var_2 = 1;
      } else
        var_2 = 0;

      break;
    case "cover_right_stand_A":
      if(self.changingcoverpos || isdefined(self.animarchetype) && self.animarchetype == "s1_soldier")
        var_2 = 0;
      else {
        dopain(animscripts\utility::lookupanim("pain", "cover_right_stand_A"));
        var_2 = 1;
      }

      break;
    case "cover_right_stand_B":
      if(self.changingcoverpos)
        var_2 = 0;
      else {
        dopain(animscripts\utility::lookupanim("pain", "cover_right_stand_B"));
        var_2 = 1;
      }

      break;
    case "cover_left_stand_A":
      if(self.changingcoverpos)
        var_2 = 0;
      else {
        dopain(animscripts\utility::lookupanim("pain", "cover_left_stand_A"));
        var_2 = 1;
      }

      break;
    case "cover_left_stand_B":
      if(self.changingcoverpos)
        var_2 = 0;
      else {
        dopain(animscripts\utility::lookupanim("pain", "cover_left_stand_B"));
        var_2 = 1;
      }

      break;
    case "cover_crouch":
      var_1 = animscripts\utility::lookupanim("pain", "cover_crouch");
      dopainfromarray(var_1);
      var_2 = 1;
      break;
    case "cover_stand":
      var_1 = animscripts\utility::lookupanim("pain", "cover_stand");
      dopainfromarray(var_1);
      var_2 = 1;
      break;
    case "cover_stand_aim":
      var_1 = animscripts\utility::lookupanim("pain", "cover_stand_aim");
      dopainfromarray(var_1);
      var_2 = 1;
      break;
    case "smg_cover_stand_aim":
      var_1 = animscripts\utility::lookupanim("pain", var_0);
      dopainfromarray(var_1);
      var_2 = 1;
      break;
    case "cover_crouch_aim":
      if(self.a.pose != "stand") {
        self clearanim( % exposed_aiming, 0);
        var_1 = animscripts\utility::lookupanim("pain", "cover_crouch_aim");
      } else
        var_1 = [ % exposed_pain_back, % exposed_pain_groin, % exposed_pain_left_arm, % exposed_pain_leg, % exposed_pain_right_arm];

      dopainfromarray(var_1);
      var_2 = 1;
      break;
    case "saw":
      if(self.a.pose == "stand")
        var_3 = animscripts\utility::lookupanim("pain", "saw_stand");
      else if(self.a.pose == "crouch")
        var_3 = animscripts\utility::lookupanim("pain", "saw_crouch");
      else
        var_3 = animscripts\utility::lookupanim("pain", "saw_prone");

      pain_setflaggedanimknob("painanim", var_3, 1, 0.3, 1);
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
  pain_setflaggedanimknob("painanim", var_1, 1, 0.3, 1);
  animscripts\shared::donotetracks("painanim");
}

dopain(var_0) {
  pain_setflaggedanimknob("painanim", var_0, 1, 0.3, 1);
  animscripts\shared::donotetracks("painanim");
}

mg42pain(var_0) {
  pain_setflaggedanimknob("painanim", level.mg_animmg["pain_" + var_0], 1, 0.1, 1);
  animscripts\shared::donotetracks("painanim");
}

waitsetstop(var_0, var_1) {
  self endon("killanimscript");
  self endon("death");

  if(isdefined(var_1))
    self endon(var_1);

  wait(var_0);
  self.a.movement = "stop";
}

crawlingpain() {
  if(self.a.disablelongdeath || self.diequietly || self.damageshield)
    return 0;

  if(self.stairsstate != "none")
    return 0;

  if(isdefined(self.a.onback))
    return 0;

  if(isdefined(self.mech) && self.mech)
    return 0;

  var_0 = animscripts\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot");

  if(isdefined(self.forcelongdeath)) {
    setcrawlingpaintransanim(var_0);
    self.health = 10;
    thread crawlingpistol();
    self waittill("killanimscript");
    return 1;
  }

  if(self.health > 100)
    return 0;

  if(var_0 && self.health < self.maxhealth * 0.4) {
    if(gettime() < anim.nextcrawlingpaintimefromlegdamage)
      return 0;
  } else {
    if(anim.numdeathsuntilcrawlingpain > 0)
      return 0;

    if(gettime() < anim.nextcrawlingpaintime)
      return 0;
  }

  if(isdefined(self.deathfunction))
    return 0;

  foreach(var_2 in level.players) {
    if(distancesquared(self.origin, var_2.origin) < 30625)
      return 0;
  }

  if(animscripts\utility::damagelocationisany("head", "helmet", "gun", "right_hand", "left_hand"))
    return 0;

  if(animscripts\utility::usingsidearm())
    return 0;

  setcrawlingpaintransanim(var_0);

  if(!isdefined(self.a.stumblingpainanimseq) && !iscrawldeltaallowed(self.a.crawlingpaintransanim))
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

  if(self.a.pose == "stand") {
    var_2 = shouldattemptstumblingpain(var_0);

    if(isdefined(var_2))
      var_1 = [var_2[0]];
    else
      var_1 = animscripts\utility::lookupanim("crawl_death", "stand_transition");
  } else if(self.a.pose == "crouch")
    var_1 = animscripts\utility::lookupanim("crawl_death", "crouch_transition");
  else
    var_1 = animscripts\utility::lookupanim("crawl_death", "prone_transition");

  self.a.crawlingpaintransanim = var_1[randomint(var_1.size)];
  self.a.stumblingpainanimseq = var_2;
}

iscrawldeltaallowed(var_0) {
  if(isdefined(self.a.force_num_crawls))
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
  thread crawling_stab_achievement();
  self setanimknoball( % dying, % body, 1, 0.1, 1);

  if(isdefined(self.a.stumblingpainanimseq)) {
    stumblingpain();
    self.a.stumblingpainanimseq = undefined;
    return;
  }

  if(!dyingcrawl()) {
    return;
  }
  pain_setflaggedanimknob("transition", self.a.crawlingpaintransanim, 1, 0.5, 1);
  animscripts\notetracks::donotetracksintercept("transition", ::handlebackcrawlnotetracks);
  self.a.special = "dying_crawl";
  thread dyingcrawlbackaim();

  if(isdefined(self.enemy)) {
    if(!(isdefined(level.crewchief) && self.enemy == level.crewchief))
      self setlookatentity(self.enemy);
  }

  decidenumcrawls();

  while (shouldkeepcrawling()) {
    var_0 = animscripts\utility::lookupanim("crawl_death", "back_crawl");

    if(!iscrawldeltaallowed(var_0)) {
      break;
    }

    pain_setflaggedanimknobrestart("back_crawl", var_0, 1, 0.1, 1.0);
    animscripts\notetracks::donotetracksintercept("back_crawl", ::handlebackcrawlnotetracks);
  }

  self.desiredtimeofdeath = gettime() + randomintrange(4000, 20000);

  while (shouldstayalive()) {
    if(animscripts\utility::canseeenemy() && aimedsomewhatatenemy()) {
      var_1 = animscripts\utility::lookupanim("crawl_death", "back_fire");
      pain_setflaggedanimknobrestart("back_idle_or_fire", var_1, 1, 0.2, 1.0);
      animscripts\shared::donotetracks("back_idle_or_fire");
      continue;
    }

    var_1 = animscripts\utility::lookupanim("crawl_death", "back_idle");

    if(randomfloat(1) < 0.4) {
      var_2 = animscripts\utility::lookupanim("crawl_death", "back_idle_twitch");
      var_1 = var_2[randomint(var_2.size)];
    }

    pain_setflaggedanimknobrestart("back_idle_or_fire", var_1, 1, 0.1, 1.0);
    var_3 = getanimlength(var_1);

    while (var_3 > 0) {
      if(animscripts\utility::canseeenemy() && aimedsomewhatatenemy()) {
        break;
      }

      var_4 = 0.5;

      if(var_4 > var_3) {
        var_4 = var_3;
        var_3 = 0;
      } else
        var_3 = var_3 - var_4;

      animscripts\notetracks::donotetracksfortime(var_4, "back_idle_or_fire");
    }
  }

  self notify("end_dying_crawl_back_aim");
  self clearanim( % dying_back_aim_4_wrapper, 0.3);
  self clearanim( % dying_back_aim_6_wrapper, 0.3);
  var_5 = animscripts\utility::lookupanim("crawl_death", "back_death");
  self.deathanim = var_5[randomint(var_5.size)];
  killwrapper();
  self.a.special = "none";
  self.specialdeathfunc = undefined;
}

shouldattemptstumblingpain(var_0) {
  if(self.a.pose != "stand") {
    return;
  }
  var_1 = 2;

  if(randomint(10) > var_1) {
    return;
  }
  var_2 = 0;

  if(!var_0) {
    var_2 = animscripts\utility::damagelocationisany("torso_upper", "torso_lower");

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
      var_6 = anglestoforward(self.angles);
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
  var_9 = animscripts\utility::lookupanim("crawl_death", "longdeath");
  var_10 = var_4 + "_" + var_5;
  var_11 = randomint(var_9[var_10].size);
  var_12 = var_9[var_10][var_11];
  return var_12;
}

stumblingpain() {
  pain_setflaggedanimknobrestart("stumblingPainInto", self.a.stumblingpainanimseq[0]);
  animscripts\shared::donotetracks("stumblingPainInto");
  self.a.special = "stumbling_pain";
  var_0 = getmovedelta(self.a.stumblingpainanimseq[2]);
  var_1 = getanimlength(self.a.stumblingpainanimseq[2]) * 1000;

  for (var_2 = randomint(2) + 1; var_2 > 0; var_2--) {
    var_3 = anglestoforward(self.angles);
    var_4 = self.origin + var_3 * var_0;

    if(!self maymovetopoint(var_4)) {
      break;
    }

    pain_setflaggedanimknobrestart("stumblingPain", self.a.stumblingpainanimseq[1]);
    animscripts\shared::donotetracks("stumblingPain");
  }

  self.a.nodeath = 1;
  self.a.special = "none";
  pain_setflaggedanimknobrestart("stumblingPainCollapse", self.a.stumblingpainanimseq[2], 1, 0.75);
  animscripts\notetracks::donotetracksintercept("stumblingPainCollapse", ::stumblingpainnotetrackhandler);
  animscripts\shared::donotetracks("stumblingPainCollapse");
  killwrapper();
}

stumblingpainnotetrackhandler(var_0) {
  if(var_0 == "start_ragdoll") {
    animscripts\notetracks::handlenotetrack(var_0, "stumblingPainCollapse");
    return 1;
  }
}

crawling_stab_achievement() {
  if(self.team == "allies") {
    return;
  }
  self endon("end_dying_crawl_back_aim");
  self waittill("death", var_0, var_1);

  if(!isdefined(self) || !isdefined(var_0) || !isplayer(var_0)) {
    return;
  }
  if(var_1 == "MOD_MELEE")
    maps\_utility::giveachievement_wrapper("NO_REST_FOR_THE_WEARY");
}

shouldstayalive() {
  if(!enemyisingeneraldirection(anglestoforward(self.angles)))
    return 0;

  return gettime() < self.desiredtimeofdeath;
}

dyingcrawl() {
  if(!isdefined(self.forcelongdeath)) {
    if(self.a.pose == "prone")
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

  if(self.a.pose != "prone") {
    var_0 = animscripts\utility::lookupanim("crawl_death", self.a.pose + "_2_crawl");
    var_1 = var_0[randomint(var_0.size)];

    if(!iscrawldeltaallowed(var_1))
      return 1;

    thread dyingcrawlbloodsmear();
    pain_setflaggedanimknob("falling", var_1, 1, 0.5, 1);
    animscripts\shared::donotetracks("falling");
  } else
    thread dyingcrawlbloodsmear();

  self.a.crawlingpaintransanim = animscripts\utility::lookupanim("crawl_death", "default_transition");
  self.a.special = "dying_crawl";
  decidenumcrawls();
  var_2 = animscripts\utility::lookupanim("crawl_death", "crawl");

  while (shouldkeepcrawling()) {
    if(!iscrawldeltaallowed(var_2))
      return 1;

    if(isdefined(self.custom_crawl_sound))
      self playsound(self.custom_crawl_sound);

    pain_setflaggedanimknobrestart("crawling", var_2, 1, 0.1, 1.0);
    animscripts\shared::donotetracks("crawling");
  }

  self notify("done_crawling");

  if(!isdefined(self.forcelongdeath) && enemyisingeneraldirection(anglestoforward(self.angles) * -1))
    return 1;

  var_3 = animscripts\utility::lookupanim("crawl_death", "death");
  var_4 = var_3[randomint(var_3.size)];

  if(var_4 != % dying_crawl_death_v2)
    self.a.nodeath = 1;

  animscripts\death::playdeathanim(var_4, 0);
  killwrapper();
  self.a.special = "none";
  self.specialdeathfunc = undefined;
  return 0;
}

dyingcrawlbloodsmear() {
  self endon("death");

  if(self.a.pose != "prone") {
    for (;;) {
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

  if(isdefined(self.a.crawl_fx_rate))
    var_3 = self.a.crawl_fx_rate;

  if(isdefined(self.a.crawl_fx))
    var_4 = level._effect[self.a.crawl_fx];

  while (var_3) {
    var_5 = self gettagorigin(var_1);
    var_6 = self gettagangles(var_2);
    var_7 = anglestoright(var_6);
    var_8 = anglestoforward((270, 0, 0));
    playfx(var_4, var_5, var_8, var_7);
    wait(var_3);
  }
}

dyingcrawlbackaim() {
  self endon("kill_long_death");
  self endon("death");
  self endon("end_dying_crawl_back_aim");

  if(isdefined(self.dyingcrawlaiming)) {
    return;
  }
  self.dyingcrawlaiming = 1;
  self setanimlimited(animscripts\utility::lookupanim("crawl_death", "aim_4"), 1, 0);
  self setanimlimited(animscripts\utility::lookupanim("crawl_death", "aim_6"), 1, 0);
  var_0 = 0;

  for (;;) {
    var_1 = animscripts\utility::getyawtoenemy();
    var_2 = angleclamp180(var_1 - var_0);

    if(abs(var_2) > 3)
      var_2 = common_scripts\utility::sign(var_2) * 3;

    var_1 = angleclamp180(var_0 + var_2);

    if(var_1 < 0) {
      if(var_1 < -45.0)
        var_1 = -45.0;

      var_3 = var_1 / -45.0;
      self setanim( % dying_back_aim_4_wrapper, var_3, 0.05);
      self setanim( % dying_back_aim_6_wrapper, 0, 0.05);
    } else {
      if(var_1 > 45.0)
        var_1 = 45.0;

      var_3 = var_1 / 45.0;
      self setanim( % dying_back_aim_6_wrapper, var_3, 0.05);
      self setanim( % dying_back_aim_4_wrapper, 0, 0.05);
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
    if(!animscripts\utility::canseeenemy())
      return 1;

    if(!aimedsomewhatatenemy())
      return 1;

    animscripts\utility::shootenemywrapper();
    return 1;
  } else if(var_0 == "pistol_pickup") {
    thread startdyingcrawlbackaimsoon();
    return 0;
  }

  return 0;
}

aimedsomewhatatenemy() {
  if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
    var_0 = animscripts\combat_utility::get_last_known_shoot_pos(self.enemy);
  else
    var_0 = self.enemy getshootatpos();

  var_1 = self getmuzzleangle();
  var_2 = vectortoangles(var_0 - self getmuzzlepos());
  var_3 = animscripts\utility::absangleclamp180(var_1[1] - var_2[1]);

  if(var_3 > anim.painyawdifffartolerance) {
    if(distancesquared(self geteye(), var_0) > anim.painyawdiffclosedistsq || var_3 > anim.painyawdiffclosetolerance)
      return 0;
  }

  return animscripts\utility::absangleclamp180(var_1[0] - var_2[0]) <= anim.painpitchdifftolerance;
}

enemyisingeneraldirection(var_0) {
  if(!isdefined(self.enemy))
    return 0;

  if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
    var_1 = animscripts\combat_utility::get_last_known_shoot_pos(self.enemy);
  else
    var_1 = self.enemy getshootatpos();

  var_2 = vectornormalize(var_1 - self geteye());
  return vectordot(var_2, var_0) > 0.5;
}

preventpainforashorttime(var_0) {
  self endon("kill_long_death");
  self endon("death");
  self.flashbangimmunity = 1;
  self.longdeathstarting = 1;
  self.a.doinglongdeath = 1;
  self notify("long_death");
  self.health = 10000;
  wait 0.75;

  if(self.health > 1)
    self.health = 1;

  wait 0.05;
  self.longdeathstarting = undefined;
  self.a.mayonlydie = 1;

  if(var_0 == "crawling") {
    wait 1.0;

    if(isdefined(level.player) && distancesquared(self.origin, level.player.origin) < 1048576) {
      anim.numdeathsuntilcrawlingpain = randomintrange(10, 30);
      anim.nextcrawlingpaintime = gettime() + randomintrange(15000, 60000);
    } else {
      anim.numdeathsuntilcrawlingpain = randomintrange(5, 12);
      anim.nextcrawlingpaintime = gettime() + randomintrange(5000, 25000);
    }

    anim.nextcrawlingpaintimefromlegdamage = gettime() + randomintrange(7000, 13000);
  } else if(var_0 == "corner_grenade") {
    wait 1.0;

    if(isdefined(level.player) && distancesquared(self.origin, level.player.origin) < 490000) {
      anim.numdeathsuntilcornergrenadedeath = randomintrange(10, 30);
      anim.nextcornergrenadedeathtime = gettime() + randomintrange(15000, 60000);
    } else {
      anim.numdeathsuntilcornergrenadedeath = randomintrange(5, 12);
      anim.nextcornergrenadedeathtime = gettime() + randomintrange(5000, 25000);
    }
  }
}

decidenumcrawls() {
  if(isdefined(self.a.force_num_crawls))
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

  if(isdefined(self.deathfunction))
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
  thread maps\_utility::set_battlechatter(0);
  self.threatbias = -1000;
  pain_setflaggedanimknoballrestart("corner_grenade_pain", animscripts\utility::lookupanim("corner_grenade_death", "pain"), % body, 1, 0.1);
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
  pain_setflaggedanimknoballrestart("corner_grenade_idle", animscripts\utility::lookupanim("corner_grenade_death", "pain"), % body, 1, 0.2);
  thread watchenemyvelocity();

  while (!enemyisapproaching()) {
    if(gettime() >= var_1) {
      break;
    }

    animscripts\notetracks::donotetracksfortime(0.1, "corner_grenade_idle");
  }

  var_2 = animscripts\utility::lookupanim("corner_grenade_death", "release");
  pain_setflaggedanimknoballrestart("corner_grenade_release", var_2, % body, 1, 0.2);
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
  var_5 = bullettrace(var_3, var_4, 0, undefined);

  if(var_5["fraction"] < 0.5)
    var_2 = var_5["position"];

  var_6 = "default";

  if(var_5["surfacetype"] != "none")
    var_6 = var_5["surfacetype"];

  thread playsoundatpoint("grenade_bounce_" + var_6, var_2);
  self.grenadeweapon = "fraggrenade";
  self magicgrenademanual(var_2, var_0, var_1);
}

playsoundatpoint(var_0, var_1) {
  var_2 = spawn("script_origin", var_1);
  var_2 playsound(var_0, "sounddone");
  var_2 waittill("sounddone");
  var_2 delete();
}

killself() {
  self.a.nodeath = 1;
  killwrapper();
  self clearanim( % head, 0.2);
  self startragdoll();
  wait 0.1;
  self notify("grenade_drop_done");
}

killwrapper() {
  if(isdefined(self.last_dmg_player))
    self kill(self.origin, self.last_dmg_player);
  else
    self kill();
}

enemyisapproaching() {
  if(!isdefined(self.enemy))
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
  var_0 = animscripts\utility::lookupanim("corner_grenade_death", "premature_death");
  var_1 = var_0[randomint(var_0.size)];
  animscripts\death::playdeathsound();
  pain_setflaggedanimknoballrestart("corner_grenade_die", var_1, % body, 1, 0.2);
  var_2 = animscripts\combat_utility::getgrenadedropvelocity();
  cornerdeathreleasegrenade(var_2, 3.0);
  var_3 = getweaponmodel("fraggrenade");
  self detach(var_3, "tag_inhand");
  wait 0.05;
  self clearanim( % head, 0.2);
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

  for (;;) {
    if(isdefined(self.enemy) && isdefined(var_0) && self.enemy == var_0) {
      var_3 = self.enemy.origin;
      self.enemyvelocity = (var_3 - var_1) * (1 / var_2);
      var_1 = var_3;
    } else {
      if(isdefined(self.enemy))
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

  if(!isdefined(self)) {
    return;
  }
  if(isdefined(self.doingadditivepain)) {
    return;
  }
  if(!isdefined(self.mech) || isdefined(self.mech) && !self.mech) {
    if(var_0 < self.minpaindamage)
      return;
  } else if(var_0 < self.minpaindamage / 3) {
    return;
  }
  self.doingadditivepain = 1;
  var_7 = undefined;

  if(animscripts\utility::damagelocationisany("left_arm_lower", "left_arm_upper", "left_hand"))
    var_7 = animscripts\utility::lookupanim("additive_pain", "left_arm");

  if(animscripts\utility::damagelocationisany("right_arm_lower", "right_arm_upper", "right_hand"))
    var_7 = animscripts\utility::lookupanim("additive_pain", "right_arm");
  else if(animscripts\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "left_foot"))
    var_7 = animscripts\utility::lookupanim("additive_pain", "left_leg");
  else if(animscripts\utility::damagelocationisany("right_leg_upper", "right_leg_lower", "right_foot"))
    var_7 = animscripts\utility::lookupanim("additive_pain", "right_leg");
  else {
    var_8 = animscripts\utility::lookupanim("additive_pain", "default");
    var_7 = var_8[randomint(var_8.size)];
  }

  self setanimlimited( % add_pain, 1, 0.1, 1);
  self setanimlimited(var_7, 1, 0, 1);
  wait 0.4;
  self clearanim(var_7, 0.2);
  self clearanim( % add_pain, 0.2);
  self.doingadditivepain = undefined;
}

pain_setflaggedanimknob(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(var_2))
    var_2 = 1;

  if(!isdefined(var_3))
    var_3 = 0.2;

  if(!isdefined(var_4))
    var_4 = 1;

  self setflaggedanimknob(var_0, var_1, var_2, var_3, var_4);
  self.facialanimidx = animscripts\face::playfacialanim(var_1, "pain", self.facialanimidx);
}

pain_setflaggedanimknobrestart(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(var_2))
    var_2 = 1;

  if(!isdefined(var_3))
    var_3 = 0.2;

  if(!isdefined(var_4))
    var_4 = 1;

  self setflaggedanimknobrestart(var_0, var_1, var_2, var_3, var_4);
  self.facialanimidx = animscripts\face::playfacialanim(var_1, "pain", self.facialanimidx);
}

pain_setflaggedanimknoballrestart(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(var_3))
    var_3 = 1;

  if(!isdefined(var_4))
    var_4 = 0.2;

  if(!isdefined(var_5))
    var_5 = 1;

  self setflaggedanimknoballrestart(var_0, var_1, var_2, var_3, var_4, var_5);
  self.facialanimidx = animscripts\face::playfacialanim(var_1, "pain", self.facialanimidx);
}