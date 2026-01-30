/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_mutators.gsc
*****************************************/

main() {
  initmutatortable();
  initexomutator();
  initdismemberment();
  initdismembermentweaponmodifiers();
  level.activemutators = [];
}

addmutatortotable(var_0, var_1, var_2, var_3, var_4) {
  level.mutators[var_0] = [];
  level.mutators[var_0][0] = var_1;
  level.mutators[var_0][2] = var_2;
  level.mutators[var_0][3] = var_3;
  level.mutators[var_0][4] = var_4;
}

disablemutatorfortypes(var_0, var_1) {
  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_3 in var_1) {
    level.mutators_disabled[var_3][var_0] = 1;
  }
}

initfastmutator() {
  level._effect["mut_fast_head"] = loadfx("vfx/gameplay/mp/zombie/zombie_fast_head");
  addmutatortotable("fast", ::mutatorfast, "zmb_mut_fast_spawn");
  disablemutatorfortypes("fast", ["zombie_dog", "zombie_melee_goliath", "zombie_ranged_goliath"]);
}

initexplodermutator() {
  level._effect["mut_exp_head"] = loadfx("vfx/gameplay/mp/zombie/zombie_fire_head");
  level._effect["mut_exp_arm_l"] = loadfx("vfx/gameplay/mp/zombie/zombie_fire_upperarm_lt");
  level._effect["mut_exp_arm_r"] = loadfx("vfx/gameplay/mp/zombie/zombie_fire_upperarm_rt");
  level._effect["mut_exp_back"] = loadfx("vfx/gameplay/mp/zombie/zombie_fire_back");
  level._effect["mut_exp_explosion_sm"] = loadfx("vfx/gameplay/mp/zombie/zombie_xplod_detonate_sml");
  level._effect["mut_exp_explosion_lg"] = loadfx("vfx/gameplay/mp/zombie/zombie_xplod_detonate_lrg");
  level._effect["mut_exp_charge"] = loadfx("vfx/gameplay/mp/zombie/zombie_xplod_detonate_charge");
  addmutatortotable("exploder", ::mutatorexploder, "zmb_mut_expl_spawn", ::onexploderzombiekilled);
  disablemutatorfortypes("exploder", ["zombie_melee_goliath", "zombie_ranged_goliath"]);
}

initemzmutator() {
  level._effect["mut_emz_head"] = loadfx("vfx/gameplay/mp/zombie/zombie_emp_head");
  level._effect["mut_emz_arm_l"] = loadfx("vfx/gameplay/mp/zombie/zombie_emp_upperarm_lt");
  level._effect["mut_emz_arm_r"] = loadfx("vfx/gameplay/mp/zombie/zombie_emp_upperarm_rt");
  level._effect["mut_emz_back"] = loadfx("vfx/gameplay/mp/zombie/zombie_emp_back");
  level._effect["mut_emz_explosion"] = loadfx("vfx/explosion/emp_grenade_lrg_mp");
  level._effect["mut_emz_attack_sm"] = loadfx("vfx/gameplay/mp/zombie/zombie_attack_emz");
  level._effect["mut_emz_attack_lg"] = loadfx("vfx/gameplay/mp/zombie/zombie_attack_emz_lrg");
  addmutatortotable("emz", ::mutatoremz, "zmb_mut_emz_spawn");
  disablemutatorfortypes("emz", ["zombie_ranged_goliath"]);
}

initmutatortable() {
  level.mutators = [];
  addmutatortotable("crawl", ::mutatorcrawl);
  disablemutatorfortypes("crawl", ["zombie_dog", "zombie_melee_goliath", "zombie_ranged_goliath"]);
  addmutatortotable("exo", ::mutatorexo);
  disablemutatorfortypes("exo", ["zombie_dog", "zombie_melee_goliath", "zombie_ranged_goliath"]);
}

initexomutator() {
  if(level.currentgen && maps\mp\_utility::getmapname() == "mp_zombie_ark") {
    level.exobodyparts["zom_civ_ruban_male_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["torso"] = "zom_marine_exo_torso_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["right_arm"] = "zom_marine_exo_r_arm_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["left_arm"] = "zom_marine_exo_l_arm_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["right_leg"] = "zom_marine_exo_r_leg_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["left_leg"] = "zom_marine_exo_l_leg_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
  } else {
    level.exobodyparts["zom_civ_ruban_male_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_ab"]["torso"] = "zom_marine_exo_torso_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_ab"]["right_arm"] = "zom_marine_exo_r_arm_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_ab"]["left_arm"] = "zom_marine_exo_l_arm_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_ab"]["right_leg"] = "zom_marine_exo_r_leg_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_ab"]["left_leg"] = "zom_marine_exo_l_leg_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["torso"] = "zom_marine_exo_torso_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["right_arm"] = "zom_marine_exo_r_arm_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["left_arm"] = "zom_marine_exo_l_arm_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["right_leg"] = "zom_marine_exo_r_leg_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_b"]["left_leg"] = "zom_marine_exo_l_leg_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_c"]["torso"] = "zom_marine_exo_torso_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_c"]["right_arm"] = "zom_marine_exo_r_arm_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_c"]["left_arm"] = "zom_marine_exo_l_arm_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_c"]["right_leg"] = "zom_marine_exo_r_leg_slice";
    level.exobodyparts["zom_civ_ruban_male_torso_slice_c"]["left_leg"] = "zom_marine_exo_l_leg_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice_bb"]["torso"] = "zom_marine_exo_torso_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice_bb"]["right_arm"] = "zom_marine_exo_r_arm_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice_bb"]["left_arm"] = "zom_marine_exo_l_arm_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice_bb"]["right_leg"] = "zom_marine_exo_r_leg_slice";
    level.exobodyparts["zom_marine_shotgun_torso_slice_bb"]["left_leg"] = "zom_marine_exo_l_leg_slice";
  }
}

initdismemberment() {
  level.fullbodygibcounter = 0;

  if(level.currentgen && maps\mp\_utility::getmapname() == "mp_zombie_ark") {
    level.dismemberment["zom_marine_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
    level.dismemberment["zom_marine_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
    level.dismemberment["zom_marine_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_emp_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
    level.dismemberment["zom_marine_m_emp_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
    level.dismemberment["zom_marine_m_emp_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_emp_exo_r_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_emp_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_emp_exo_l_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_fire_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
    level.dismemberment["zom_marine_m_fire_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
    level.dismemberment["zom_marine_m_fire_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_fire_exo_r_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_fire_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_fire_exo_l_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_ovr_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
    level.dismemberment["zom_marine_m_ovr_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
    level.dismemberment["zom_marine_m_ovr_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_ovr_exo_r_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_ovr_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_ovr_exo_l_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment[1]["modelToSpawn"] = "zom_civ_ruban_male_r_arm_phys";
    level.dismemberment[2]["modelToSpawn"] = "zom_civ_ruban_male_r_arm_phys";
    level.dismemberment[4]["modelToSpawn"] = "zom_civ_ruban_male_r_leg_phys";
    level.dismemberment[8]["modelToSpawn"] = "zom_civ_ruban_male_r_leg_phys";
    level.dismemberment[16]["modelToSpawn"] = "zom_civ_urban_male_head_phys";
    level.dismemberment[16]["nub"] = "zom_civ_urban_male_head_slice";
    level.dismemberment[1]["tagName"] = "J_Shoulder_RI";
    level.dismemberment[2]["tagName"] = "J_Shoulder_LE";
    level.dismemberment[4]["tagName"] = "J_Hip_RI";
    level.dismemberment[8]["tagName"] = "J_Hip_LE";
    level.dismemberment[16]["tagName"] = "J_Head";
    level.dismemberment[1]["fxTagName"] = "J_Shoulder_RI";
    level.dismemberment[2]["fxTagName"] = "J_Shoulder_LE";
    level.dismemberment[4]["fxTagName"] = "J_Hip_RI";
    level.dismemberment[8]["fxTagName"] = "J_Hip_LE";
    level.dismemberment[16]["fxTagName"] = "J_Head";
    level.dismemberment["full"]["fxTagName"] = "J_MainRoot";
    level.dismemberment[1]["torsoFX"] = "torso_arm_loss_right";
    level.dismemberment[2]["torsoFX"] = "torso_arm_loss_left";
    level.dismemberment[4]["torsoFX"] = "torso_loss_right";
    level.dismemberment[8]["torsoFX"] = "torso_loss_left";
    level.dismemberment[16]["torsoFX"] = "torso_head_loss";
    level.dismemberment[1]["limbFX"] = "arm_loss_right";
    level.dismemberment[2]["limbFX"] = "arm_loss_left";
    level.dismemberment[4]["limbFX"] = "limb_loss_right";
    level.dismemberment[8]["limbFX"] = "limb_loss_left";
    level.dismemberment[16]["limbFX"] = "head_loss";
    level.dismemberment[1]["dismemberSound"] = "zmb_dism_arm";
    level.dismemberment[2]["dismemberSound"] = "zmb_dism_arm";
    level.dismemberment[4]["dismemberSound"] = "zmb_dism_leg";
    level.dismemberment[8]["dismemberSound"] = "zmb_dism_leg";
    level.dismemberment[16]["dismemberSound"] = "zmb_dism_head";
    level.dismemberment["full"]["dismemberSound"] = "zmb_dism_instakill_explosion";
    level.dismemberment[1]["dismemberExoSound"] = "zmb_dism_arm";
    level.dismemberment[2]["dismemberExoSound"] = "zmb_dism_arm_exo";
    level.dismemberment[4]["dismemberExoSound"] = "zmb_dism_leg_exo";
    level.dismemberment[8]["dismemberExoSound"] = "zmb_dism_leg_exo";
    level.dismemberment[16]["dismemberExoSound"] = "zmb_dism_head";
    level.dismemberment["full"]["dismemberExoSound"] = "zmb_dism_instakill_explosion";
  } else {
    level.dismemberment["zom_marine_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
    level.dismemberment["zom_marine_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_l_arm_phys";
    level.dismemberment["zom_marine_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
    level.dismemberment["zom_marine_m_emp_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
    level.dismemberment["zom_marine_m_emp_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_l_arm_phys";
    level.dismemberment["zom_marine_m_emp_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_emp_exo_r_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_emp_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
    level.dismemberment["zom_marine_m_emp_exo_l_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
    level.dismemberment["zom_marine_m_fire_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
    level.dismemberment["zom_marine_m_fire_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_l_arm_phys";
    level.dismemberment["zom_marine_m_fire_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_fire_exo_r_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_fire_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
    level.dismemberment["zom_marine_m_fire_exo_l_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
    level.dismemberment["zom_marine_m_ovr_exo_r_arm_slice"]["modelToSpawn"] = "zom_marine_exo_r_arm_phys";
    level.dismemberment["zom_marine_m_ovr_exo_l_arm_slice"]["modelToSpawn"] = "zom_marine_exo_l_arm_phys";
    level.dismemberment["zom_marine_m_ovr_exo_r_leg_slice"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_ovr_exo_r_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_r_leg_phys";
    level.dismemberment["zom_marine_m_ovr_exo_l_leg_slice"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
    level.dismemberment["zom_marine_m_ovr_exo_l_leg_slice_ab"]["modelToSpawn"] = "zom_marine_exo_l_leg_phys";
    level.dismemberment[1]["modelToSpawn"] = "zom_civ_ruban_male_r_arm_phys";
    level.dismemberment[2]["modelToSpawn"] = "zom_civ_ruban_male_l_arm_phys";
    level.dismemberment[4]["modelToSpawn"] = "zom_civ_ruban_male_r_leg_phys";
    level.dismemberment[8]["modelToSpawn"] = "zom_civ_ruban_male_l_leg_phys";
    level.dismemberment[16]["modelToSpawn"] = "zom_civ_urban_male_head_phys";
    level.dismemberment[16]["nub"] = "zom_civ_urban_male_head_slice";
    level.dismemberment[1]["tagName"] = "J_Shoulder_RI";
    level.dismemberment[2]["tagName"] = "J_Shoulder_LE";
    level.dismemberment[4]["tagName"] = "J_Hip_RI";
    level.dismemberment[8]["tagName"] = "J_Hip_LE";
    level.dismemberment[16]["tagName"] = "J_Head";
    level.dismemberment[1]["fxTagName"] = "J_Shoulder_RI";
    level.dismemberment[2]["fxTagName"] = "J_Shoulder_LE";
    level.dismemberment[4]["fxTagName"] = "J_Hip_RI";
    level.dismemberment[8]["fxTagName"] = "J_Hip_LE";
    level.dismemberment[16]["fxTagName"] = "J_Head";
    level.dismemberment["full"]["fxTagName"] = "J_MainRoot";
    level.dismemberment[1]["torsoFX"] = "torso_arm_loss_right";
    level.dismemberment[2]["torsoFX"] = "torso_arm_loss_left";
    level.dismemberment[4]["torsoFX"] = "torso_loss_right";
    level.dismemberment[8]["torsoFX"] = "torso_loss_left";
    level.dismemberment[16]["torsoFX"] = "torso_head_loss";
    level.dismemberment[1]["limbFX"] = "arm_loss_right";
    level.dismemberment[2]["limbFX"] = "arm_loss_left";
    level.dismemberment[4]["limbFX"] = "limb_loss_right";
    level.dismemberment[8]["limbFX"] = "limb_loss_left";
    level.dismemberment[16]["limbFX"] = "head_loss";
    level.dismemberment[1]["dismemberSound"] = "zmb_dism_arm";
    level.dismemberment[2]["dismemberSound"] = "zmb_dism_arm";
    level.dismemberment[4]["dismemberSound"] = "zmb_dism_leg";
    level.dismemberment[8]["dismemberSound"] = "zmb_dism_leg";
    level.dismemberment[16]["dismemberSound"] = "zmb_dism_head";
    level.dismemberment["full"]["dismemberSound"] = "zmb_dism_instakill_explosion";
    level.dismemberment[1]["dismemberExoSound"] = "zmb_dism_arm";
    level.dismemberment[2]["dismemberExoSound"] = "zmb_dism_arm_exo";
    level.dismemberment[4]["dismemberExoSound"] = "zmb_dism_leg_exo";
    level.dismemberment[8]["dismemberExoSound"] = "zmb_dism_leg_exo";
    level.dismemberment[16]["dismemberExoSound"] = "zmb_dism_head";
    level.dismemberment["full"]["dismemberExoSound"] = "zmb_dism_instakill_explosion";
  }
}

initdismembermentweaponmodifiers() {
  var_0 = "mp/zombieDismembermentModifiers.csv";
  var_1 = 0;
  var_2 = 2;
  var_3 = 3;
  var_4 = 4;
  var_5 = 5;
  var_6 = tablegetrowcount(var_0);

  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_8 = tablelookupbyrow(var_0, var_7, var_1);
    var_9 = tablelookupbyrow(var_0, var_7, var_2);
    var_10 = tablelookupbyrow(var_0, var_7, var_3);
    var_11 = tablelookupbyrow(var_0, var_7, var_4);
    var_12 = tablelookupbyrow(var_0, var_7, var_5);
    level.dismembermentmodifiers[var_8] = float(var_9);
    level.dismembermentupgrademodifiers[var_8] = float(var_10);
    level.highdamageweapons[var_8] = var_11 == "true";
    level.dismembermentignorelocation[var_8] = var_12 == "true";
  }
}

mutator_apply(var_0) {
  if(!isDefined(level.activemutators[var_0])) {
    level.activemutators[var_0] = 0;
  }

  if(!isDefined(self.activemutators)) {
    self.activemutators = [];
  }

  if(isDefined(self.activemutators[var_0])) {
    return;
  }
  if(isDefined(level.mutators_disabled[self.agent_type])) {
    if(isDefined(level.mutators_disabled[self.agent_type][var_0]) && level.mutators_disabled[self.agent_type][var_0]) {
      return;
    }
  }

  level.activemutators[var_0]++;
  self.activemutators[var_0] = 1;
  self[[level.mutators[var_0][0]]]();

  if(isDefined(self.activemutators)) {
    self.activemutators[var_0] = undefined;
  }

  level.activemutators[var_0]--;
}

torso_effects_apply(var_0, var_1) {
  if(isDefined(level._effect[var_0 + "_head"])) {
    maps\mp\zombies\_util::playfxontagnetwork(level._effect[var_0 + "_head"], self, "j_head");
  }

  if(isDefined(level._effect[var_0 + "_arm_r"])) {
    maps\mp\zombies\_util::playfxontagnetwork(level._effect[var_0 + "_arm_r"], self, "j_shoulder_ri");
  }

  if(isDefined(level._effect[var_0 + "_arm_l"])) {
    maps\mp\zombies\_util::playfxontagnetwork(level._effect[var_0 + "_arm_l"], self, "j_shoulder_le");
  }

  if(isDefined(level._effect[var_0 + "_back"])) {
    maps\mp\zombies\_util::playfxontagnetwork(level._effect[var_0 + "_back"], self, "j_spineupper");
  }

  self.torso_fx = var_0;

  if(isDefined(var_1)) {
    thread torso_effects_remove(var_0, var_1);
  }
}

torso_effects_remove(var_0, var_1) {
  self notify("removeTorsoEffectsDelayed");
  self endon("removeTorsoEffectsDelayed");
  self endon("death");

  if(isDefined(var_1)) {
    wait(var_1);
  }

  if(isDefined(self)) {
    if(isDefined(level._effect[var_0 + "_head"])) {
      maps\mp\zombies\_util::stopfxontagnetwork(level._effect[var_0 + "_head"], self, "j_head");
    }

    if(isDefined(level._effect[var_0 + "_arm_r"])) {
      maps\mp\zombies\_util::stopfxontagnetwork(level._effect[var_0 + "_arm_r"], self, "j_shoulder_ri");
    }

    if(isDefined(level._effect[var_0 + "_arm_l"])) {
      maps\mp\zombies\_util::stopfxontagnetwork(level._effect[var_0 + "_arm_l"], self, "j_shoulder_le");
    }

    if(isDefined(level._effect[var_0 + "_back"])) {
      maps\mp\zombies\_util::stopfxontagnetwork(level._effect[var_0 + "_back"], self, "j_spineupper");
    }
  }
}

mutator_precloneswap_limb(var_0, var_1, var_2) {
  if(var_2) {
    var_3 = level.dismemberment[var_0]["nub"];

    if(isDefined(var_3)) {
      self attach(var_3, "", 1);
      return;
    }
  } else if(isDefined(self.swaplimbmodels) && isDefined(self.swaplimbmodels[var_1])) {
    self attach(self.swaplimbmodels[var_1]);
  } else if(isDefined(self.limbmodels) && isDefined(self.limbmodels[var_1])) {
    self attach(self.limbmodels[var_1]);
  }
}

mutator_precloneswap() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  if(isDefined(self.missingbodyparts)) {
    if(self.missingbodyparts & 16) {
      var_0 = 1;
    }

    if(self.missingbodyparts & 1) {
      var_1 = 1;
    }

    if(self.missingbodyparts & 2) {
      var_2 = 1;
    }

    if(self.missingbodyparts & 4) {
      var_3 = 1;
    }

    if(self.missingbodyparts & 8) {
      var_4 = 1;
    }
  }

  self detachall();

  if(isDefined(self.swapbody)) {
    self setModel(self.swapbody);
  }

  if(var_0) {
    var_5 = level.dismemberment[16]["nub"];

    if(isDefined(var_5)) {
      self attach(var_5, "", 1);
    }
  } else {
    self attach(self.headmodel);
  }

  mutator_precloneswap_limb(4, "right_leg", var_3);
  mutator_precloneswap_limb(8, "left_leg", var_4);
  mutator_precloneswap_limb(1, "right_arm", var_1);
  mutator_precloneswap_limb(2, "left_arm", var_2);
}

mutatorexo() {
  thread mutatorspawnsound("exo");
  maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
  self.boostfxtag = "tag_jetpack";
  var_0 = self getmodelfromentity();
  self setModel(level.exobodyparts[var_0]["torso"]);

  if(isDefined(level.exobodyparts[var_0]["heads"])) {
    var_1 = level.exobodyparts[var_0]["heads"][randomint(level.exobodyparts[var_0]["heads"].size)];
    self detach(self.headmodel);
    self.headmodel = var_1;
    self attach(var_1);
  }

  replacelimbtoexolimb(var_0, "right_leg");
  replacelimbtoexolimb(var_0, "left_leg");
  replacelimbtoexolimb(var_0, "right_arm");
  replacelimbtoexolimb(var_0, "left_arm");

  if(!isDefined(self.moverateroundmod)) {
    self.moverateroundmod = 0;
  }

  self.moverateroundmod = self.moverateroundmod + 1;
  self waittill("death");
}

replacelimbtoexolimb(var_0, var_1) {
  self detach(self.limbmodels[var_1]);
  self.limbmodels[var_1] = level.exobodyparts[var_0][var_1];
  self attach(self.limbmodels[var_1]);
}

mutatorfast() {
  thread mutatorspawnsound("fast");
  maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
  self.boostfxtag = "tag_jetpack";
  thread runner_ambient_sound();
  var_0 = ["zom_marine_m_ovr_exo_torso_slice"];
  var_1 = ["zom_marine_m_ovr_nofx_exo_torso_slice"];
  var_2 = ["zombies_head_mutator_overcharge", "zombies_head_mutator_ovrchrg_cau_a", "zombies_head_mutator_ovrchrg_cau_b", "zombies_head_mutator_ovrchrg_cau_c"];
  var_3 = ["zom_marine_m_ovr_exo_r_leg_slice", "zom_marine_m_ovr_exo_r_leg_slice_ab"];
  var_4 = ["zom_marine_m_ovr_nofx_exo_r_leg_slice", "zom_marine_m_ovr_nofx_exo_r_leg_slice_ab"];
  var_5 = ["zom_marine_m_ovr_exo_l_leg_slice", "zom_marine_m_ovr_exo_l_leg_slice_ab"];
  var_6 = ["zom_marine_m_ovr_nofx_exo_l_leg_slice", "zom_marine_m_ovr_nofx_exo_l_leg_slice_ab"];
  var_7 = ["zom_marine_m_ovr_exo_r_arm_slice"];
  var_8 = ["zom_marine_m_ovr_nofx_exo_r_arm_slice"];
  var_9 = ["zom_marine_m_ovr_exo_l_arm_slice"];
  var_10 = ["zom_marine_m_ovr_nofx_exo_l_arm_slice"];
  var_11 = randomint(var_0.size);
  var_12 = randomint(var_2.size);
  var_13 = randomint(var_3.size);
  var_14 = randomint(var_5.size);
  var_15 = randomint(var_7.size);
  var_16 = randomint(var_9.size);
  self.precloneswapfunc = ::mutator_precloneswap;
  self detachall();
  self setModel(var_0[var_11]);
  self.swapbody = var_1[var_11];
  self attach(var_2[var_12]);
  self.headmodel = var_2[var_12];
  self attach(var_3[var_13]);
  self attach(var_5[var_14]);
  self attach(var_7[var_15]);
  self attach(var_9[var_16]);
  self.limbmodels["right_leg"] = var_3[var_13];
  self.limbmodels["left_leg"] = var_5[var_14];
  self.limbmodels["right_arm"] = var_7[var_15];
  self.limbmodels["left_arm"] = var_9[var_16];
  self.swaplimbmodels["right_leg"] = var_4[var_13];
  self.swaplimbmodels["left_leg"] = var_6[var_14];
  self.swaplimbmodels["right_arm"] = var_8[var_15];
  self.swaplimbmodels["left_arm"] = var_10[var_16];
  var_17 = maps\mp\gametypes\zombies::geteyeeffectforzombie("fast", self.headmodel);
  maps\mp\zombies\_util::zombie_set_eyes(var_17);
  torso_effects_apply("mut_fast");
  self setsurfacetype("slush");

  if(!isDefined(self.moverateroundmod)) {
    self.moverateroundmod = 0;
  }

  self.moverateroundmod = self.moverateroundmod + 5;
  self waittill("death");
}

mutatoremz_clearemp(var_0) {
  self.empgrenaded = 0;
  self setempjammed(0);
  maps\mp\_utility::playerallowhighjump(1, "empgrenade");
  maps\mp\_utility::playerallowhighjumpdrop(1, "empgrenade");
  maps\mp\_utility::playerallowboostjump(1, "empgrenade");
  maps\mp\_utility::playerallowpowerslide(1, "empgrenade");
  maps\mp\_utility::playerallowdodge(1, "empgrenade");
  self playsoundtoplayer("emp_system_reboot", self);

  if(!maps\mp\zombies\_util::iszombieshardmode()) {
    self digitaldistortsetparams(0.0, 0.0);
  }

  maps\mp\gametypes\_scrambler::playersethudempscrambledoff(var_0);
}

mutatoremz_deathwaiter(var_0) {
  self notify("emzDeathWaiter");
  self endon("emzDeathWaiter");
  self endon("emzTimedOut");
  self waittill("death");
  mutatoremz_clearemp(var_0);
}

mutatoremz_rumbleloop(var_0) {
  self endon("emp_rumble_loop");
  self notify("emp_rumble_loop");
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    self playrumbleonentity("damage_heavy");
    wait 0.05;
  }
}

mutatoremz_watchdistortdisconnectdeath(var_0) {
  self notify("mutatorEMZ_watchDistortDisconnectDeath");
  self endon("mutatorEMZ_watchDistortDisconnectDeath");
  common_scripts\utility::waittill_any("death", "disconnect", "faux_spawn", "joined_team");

  if(isDefined(self)) {
    self digitaldistortsetparams(0.0, 0.0);
    maps\mp\gametypes\_scrambler::playersethudempscrambledoff(var_0);
  }
}

mutatoremz_digitaldistort(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("joined_team");
  var_2 = 0.6;
  self digitaldistortsetmaterial("digital_distort_mp");
  self digitaldistortsetparams(var_2, 1.0);
  thread mutatoremz_watchdistortdisconnectdeath(var_1);
  wait 0.1;
  var_3 = var_0;
  var_4 = var_2;
  var_5 = 0.2;
  var_6 = var_4 - var_5;
  var_7 = 0.1;
  var_8 = var_4;

  while(var_3 > 0) {
    var_8 = var_6 * (var_3 / var_0) + var_5;
    self digitaldistortsetparams(var_8, 1.0);
    var_3 = var_3 - var_7;
    wait(var_7);
  }

  self digitaldistortsetparams(0.0, 0.0);
}

mutatoremz_applyemp() {
  self notify("applyEmp");
  self endon("applyEmp");
  self endon("death");
  self endon("disconnect");
  wait 0.05;
  self.empduration = 5;

  if(isDefined(self.isexotacticalarmoractive) && self.isexotacticalarmoractive) {
    self.empduration = self.empduration - 1.25;
  }

  var_0 = 1;
  maps\mp\_utility::playerallowhighjump(0, "empgrenade");
  maps\mp\_utility::playerallowhighjumpdrop(0, "empgrenade");
  maps\mp\_utility::playerallowboostjump(0, "empgrenade");
  maps\mp\_utility::playerallowpowerslide(0, "empgrenade");
  maps\mp\_utility::playerallowdodge(0, "empgrenade");
  self playsoundtoplayer("emp_big_activate", self);
  self.empgrenaded = 1;
  self.empendtime = gettime() + self.empduration * 1000;
  var_1 = maps\mp\gametypes\_scrambler::playersethudempscrambled(self.empendtime, var_0, "emp");

  if(!maps\mp\zombies\_util::iszombieshardmode()) {
    thread mutatoremz_digitaldistort(self.empduration, var_1);
  }

  thread mutatoremz_rumbleloop(0.75);
  self setempjammed(1);
  thread maps\mp\zombies\_zombies_audio::player_emp();
  thread mutatoremz_deathwaiter(var_1);
  wait(self.empduration);
  self notify("emzTimedOut");
  mutatoremz_clearemp(var_1);
}

mutatoremz_watchforattackhits() {
  self endon("death");

  for(;;) {
    self waittill("attack_hit", var_0, var_1);

    if(isplayer(var_0) && maps\mp\_utility::isreallyalive(var_0)) {
      if(isDefined(var_0.exosuitonline) && var_0.exosuitonline) {
        var_0 thread mutatoremz_applyemp();
      }

      if(isDefined(level.noflashemzfunc)) {
        var_2 = var_0[[level.noflashemzfunc]]();
      } else {
        var_2 = level._effect["mut_emz_attack_sm"];
      }

      playFX(var_2, var_1);
      var_0 playlocalsound("zmb_emz_impact");
      level notify("zmb_emz_attack", self, var_1, 10000);
    }
  }
}

mutatoremz_watchforproximityboosters() {
  self endon("death");
  var_0 = 32400;
  var_1 = 500;
  var_2 = 3.0;
  maps\mp\zombies\_util::waittill_enter_game();

  for(;;) {
    if(isDefined(self.distractiondrone)) {
      wait 0.1;
      continue;
    }

    var_3 = [];

    if(self.aistate != "traverse" && !maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
      foreach(var_5 in level.players) {
        if(!maps\mp\zombies\_util::isonhumanteam(var_5) || !maps\mp\_utility::isreallyalive(var_5) || maps\mp\zombies\_util::isplayerinlaststand(var_5)) {
          continue;
        }
        if(!isDefined(var_5.exosuitonline) || !var_5.exosuitonline) {
          continue;
        }
        if(!isDefined(var_5.exoeventtime) || gettime() - var_5.exoeventtime > var_1) {
          continue;
        }
        if(distancesquared(var_5.origin, self.origin) > var_0) {
          continue;
        }
        if(var_5.ignoreme || maps\mp\zombies\_util::shouldignoreent(var_5)) {
          continue;
        }
        if(var_5 isnotarget()) {
          continue;
        }
        var_3[var_3.size] = var_5;
      }
    }

    var_7 = self.origin + (0, 0, 40);

    if(var_3.size > 0) {
      playFX(level._effect["mut_emz_attack_lg"], var_7);

      foreach(var_5 in var_3) {
        var_5 playlocalsound("zmb_emz_impact");
        var_5 thread mutatoremz_applyemp();
      }

      level notify("zmb_emz_attack", self, var_7, var_0);
      wait(var_2);
    }

    wait 0.1;
  }
}

mutatoremz_bursttonearbyplayers(var_0) {
  var_1 = 32400;
  var_2 = 500;
  var_3 = 3.0;

  if(isDefined(self.distractiondrone)) {
    return;
  }
  if(self.aistate == "traverse" || maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_4 = self.origin + (0, 0, 40);

  if(var_0) {
    playFX(level._effect["mut_emz_attack_lg"], var_4);
  }

  foreach(var_6 in level.players) {
    if(!maps\mp\zombies\_util::isonhumanteam(var_6) || !maps\mp\_utility::isreallyalive(var_6) || maps\mp\zombies\_util::isplayerinlaststand(var_6)) {
      continue;
    }
    if(!isDefined(var_6.exosuitonline) || !var_6.exosuitonline) {
      continue;
    }
    if(!isDefined(var_6.exoeventtime) || gettime() - var_6.exoeventtime > var_2) {
      continue;
    }
    if(distancesquared(var_6.origin, self.origin) > var_1) {
      continue;
    }
    if(var_6.ignoreme || maps\mp\zombies\_util::shouldignoreent(var_6)) {
      continue;
    }
    if(var_6 isnotarget()) {
      continue;
    }
    var_6 playlocalsound("zmb_emz_impact");
    var_6 thread mutatoremz_applyemp();
  }

  level notify("zmb_emz_attack", self, var_4, var_1);
}

mutatoremz() {
  if(self.agent_type == "zombie_dog") {
    thread mutatoremz_dog();
    self waittill("death");
    return;
  }

  thread mutatorspawnsound("emz");

  if(!maps\mp\zombies\_util::is_true(self.nomutatormodelswap)) {
    maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
    self.boostfxtag = "tag_jetpack";
    var_0 = ["zom_marine_m_emp_exo_torso_slice", "zom_marine_m_emp_exo_torso_slice_ab"];
    var_1 = ["zom_marine_m_emp_nofx_exo_torso_slice", "zom_marine_m_emp_nofx_exo_torso_slice_ab"];
    var_2 = ["zombies_head_mutator_emp", "zombies_head_mutator_emp_cau_a", "zombies_head_mutator_emp_cau_b", "zombies_head_mutator_emp_cau_c"];
    var_3 = ["zom_marine_m_emp_exo_r_leg_slice", "zom_marine_m_emp_exo_r_leg_slice_ab"];
    var_4 = ["zom_marine_m_emp_nofx_exo_r_leg_slice", "zom_marine_m_emp_nofx_exo_r_leg_slice_ab"];
    var_5 = ["zom_marine_m_emp_exo_l_leg_slice", "zom_marine_m_emp_exo_l_leg_slice_ab"];
    var_6 = ["zom_marine_m_emp_nofx_exo_l_leg_slice", "zom_marine_m_emp_nofx_exo_l_leg_slice_ab"];
    var_7 = ["zom_marine_m_emp_exo_r_arm_slice"];
    var_8 = ["zom_marine_m_emp_nofx_exo_r_arm_slice"];
    var_9 = ["zom_marine_m_emp_exo_l_arm_slice"];
    var_10 = ["zom_marine_m_emp_nofx_exo_l_arm_slice"];
    var_11 = randomint(var_0.size);
    var_12 = randomint(var_2.size);
    var_13 = randomint(var_3.size);
    var_14 = randomint(var_5.size);
    var_15 = randomint(var_7.size);
    var_16 = randomint(var_9.size);
    self.precloneswapfunc = ::mutator_precloneswap;
    self detachall();
    self setModel(var_0[var_11]);
    self.swapbody = var_1[var_11];
    self attach(var_2[var_12]);
    self.headmodel = var_2[var_12];
    self attach(var_3[var_13]);
    self attach(var_5[var_14]);
    self attach(var_7[var_15]);
    self attach(var_9[var_16]);
    self.limbmodels["right_leg"] = var_3[var_13];
    self.limbmodels["left_leg"] = var_5[var_14];
    self.limbmodels["right_arm"] = var_7[var_15];
    self.limbmodels["left_arm"] = var_9[var_16];
    self.swaplimbmodels["right_leg"] = var_4[var_13];
    self.swaplimbmodels["left_leg"] = var_6[var_14];
    self.swaplimbmodels["right_arm"] = var_8[var_15];
    self.swaplimbmodels["left_arm"] = var_10[var_16];
  }

  var_17 = maps\mp\gametypes\zombies::geteyeeffectforzombie("emp", self.headmodel);
  maps\mp\zombies\_util::zombie_set_eyes(var_17);
  torso_effects_apply("mut_emz");

  if(isDefined(self.goliathweapon)) {
    maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_emz_arm_r"], self.goliathweapon, "tag_fx");
    maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_emz_arm_l"], self.goliathweapon, "tag_fx");
  }

  self setsurfacetype("bark");
  self playLoopSound("zmb_emz_crackle_loop");
  thread mutatoremz_watchforattackhits();
  thread mutatoremz_watchforproximityboosters();
  self waittill("death");
}

mutatoremz_dog() {
  thread mutatorspawnsound("emz");
  self setModel("zom_dog_emz");
  maps\mp\zombies\_util::zombie_set_eyes("zombie_dog_eye_emp");

  if(isDefined(level._effect["mut_emz_head"])) {
    maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_emz_head"], self, "j_head");
  }

  if(isDefined(level._effect["mut_emz_arm_r"])) {
    maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_emz_arm_r"], self, "r_frontLeg1_jnt");
  }

  if(isDefined(level._effect["mut_emz_arm_l"])) {
    maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_emz_arm_l"], self, "l_frontLeg1_jnt");
  }

  if(isDefined(level._effect["mut_emz_back"])) {
    maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_emz_back"], self, "spine4_jnt");
  }

  self setsurfacetype("bark");
  self playLoopSound("zmb_emz_crackle_loop");
  thread mutatoremz_watchforattackhits();
  thread mutatoremz_watchforproximityboosters();
  self waittill("death");
}

hasexplodermutator() {
  if(maps\mp\zombies\_util::checkactivemutator("exploder")) {
    return 1;
  }

  if(maps\mp\zombies\_util::getzombieslevelnum() == 4 && maps\mp\zombies\_util::checkactivemutator("combo_exploder_teleport")) {
    return 1;
  }

  return 0;
}

onexploderzombiekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!hasexplodermutator()) {
    return;
  }
  if(self.hasexploded) {
    return;
  }
  self.hasexploded = 1;
  var_9 = self;

  if(isDefined(var_1)) {
    var_9 = var_1;
  }

  var_10 = self.origin;

  if(!isDefined(level.nextexplodertime) || gettime() >= level.nextexplodertime) {
    level.nextexplodertime = gettime() + 100;
  } else {
    var_11 = (level.nextexplodertime - gettime()) * 0.001;
    level.nextexplodertime = level.nextexplodertime + 100;
    wait(var_11);
  }

  mutatorexploder_explode(var_9, var_10, 0);
}

mutatorexploder_explode(var_0, var_1, var_2) {
  self.hasexploded = 1;

  if(var_2) {
    var_3 = level._effect["mut_exp_explosion_lg"];

    if(isDefined(self.detonatelargefxoverride)) {
      var_3 = self.detonatelargefxoverride;
    }

    playFX(var_3, var_1);
    self notify("stopWarningSound");
    playsoundatpos(var_1, "zmb_exploder_explode");
    radiusdamage(var_1 + (0, 0, 60), 180, 45, 15, var_0, "MOD_EXPLOSIVE", "exploder_zm_large_mp", 1);
  } else {
    var_3 = level._effect["mut_exp_explosion_sm"];

    if(isDefined(self.detonatesmallfxoverride)) {
      var_3 = self.detonatesmallfxoverride;
    }

    playFX(var_3, var_1);
    self notify("stopWarningSound");
    playsoundatpos(var_1, "zmb_exploder_explode_small");
    radiusdamage(var_1 + (0, 0, 60), 120, 1, 1, var_0, "MOD_EXPLOSIVE", "exploder_zm_small_mp", 1);
  }

  if(isalive(self)) {
    trymutilate(undefined, "exploder_zm_large_mp", "MOD_EXPLOSIVE", 1.0, self, undefined);
    self suicide();
  }
}

mutatorexploder_warningsound(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("tag_origin");
  waitframe();

  if(isDefined(self)) {
    var_1 playsoundonmovingent("zmb_exploder_warning");
    common_scripts\utility::waittill_either("death", "stopWarningSound");
  }

  var_1 stopsounds();
  wait 1.0;
  var_1 delete();
}

mutatorexploder_proximitybomb() {
  self endon("death");
  maps\mp\zombies\_util::waittill_enter_game();
  var_0 = 14400;

  for(;;) {
    wait 0.1;

    if(isDefined(self.distractiondrone)) {
      continue;
    }
    var_1 = 0;

    if(self.aistate != "traverse" && !maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
      foreach(var_3 in level.players) {
        if(!maps\mp\zombies\_util::isonhumanteam(var_3) || !maps\mp\_utility::isreallyalive(var_3) || maps\mp\zombies\_util::isplayerinlaststand(var_3)) {
          continue;
        }
        if(var_3.ignoreme || maps\mp\zombies\_util::shouldignoreent(var_3)) {
          continue;
        }
        if(var_3 isnotarget()) {
          continue;
        }
        if(distancesquared(var_3.origin, self.origin) > var_0) {
          continue;
        }
        var_1 = 1;
        break;
      }
    }

    if(var_1) {
      self.ignoreall = 1;
      self.curmeleetarget = undefined;
      self scragentsetgoalpos(self.origin);
      self scragentsetscripted(1);
      maps\mp\agents\_scripted_agent_anim_util::set_anim_state("exploder_explode");
      var_5 = "j_spineupper";

      if(self.agent_type == "zombie_dog") {
        var_5 = "spine4_jnt";
      }

      var_6 = level._effect["mut_exp_charge"];

      if(isDefined(self.detonatechargefxoverride)) {
        var_6 = self.detonatechargefxoverride;
      }

      maps\mp\zombies\_util::playfxontagnetwork(var_6, self, var_5, 1);
      thread mutatorexploder_warningsound(self.origin);
      wait(randomfloatrange(1.75, 1.9));
      mutatorexploder_explode(self, self.origin, 1);
      return;
    }
  }
}

mutatorexploder() {
  if(self.agent_type == "zombie_dog") {
    thread mutatorexploder_dog();
    self waittill("death");
    return;
  }

  thread mutatorspawnsound("exploder");
  maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
  self.boostfxtag = "tag_jetpack";
  var_0 = ["zom_marine_m_fire_exo_torso_slice", "zom_marine_m_fire_exo_torso_slice_ab"];
  var_1 = ["zom_marine_m_fire_nofx_exo_torso_slice", "zom_marine_m_fire_nofx_exo_torso_slice_ab"];
  var_2 = ["zombies_head_mutator_fire", "zombies_head_mutator_fire_cau_a", "zombies_head_mutator_fire_cau_b", "zombies_head_mutator_fire_cau_c"];
  var_3 = ["zom_marine_m_fire_exo_r_leg_slice", "zom_marine_m_fire_exo_r_leg_slice_ab"];
  var_4 = ["zom_marine_m_fire_exo_l_leg_slice", "zom_marine_m_fire_exo_l_leg_slice_ab"];
  var_5 = ["zom_marine_m_fire_exo_r_arm_slice"];
  var_6 = ["zom_marine_m_fire_exo_l_arm_slice"];
  var_7 = randomint(var_0.size);
  var_8 = randomint(var_2.size);
  var_9 = randomint(var_3.size);
  var_10 = randomint(var_4.size);
  var_11 = randomint(var_5.size);
  var_12 = randomint(var_6.size);
  self.precloneswapfunc = ::mutator_precloneswap;
  self detachall();
  self setModel(var_0[var_7]);
  self.swapbody = var_1[var_7];
  self attach(var_2[var_8]);
  self.headmodel = var_2[var_8];
  self attach(var_3[var_9]);
  self attach(var_4[var_10]);
  self attach(var_5[var_11]);
  self attach(var_6[var_12]);
  self.limbmodels["right_leg"] = var_3[var_9];
  self.limbmodels["left_leg"] = var_4[var_10];
  self.limbmodels["right_arm"] = var_5[var_11];
  self.limbmodels["left_arm"] = var_6[var_12];
  var_13 = maps\mp\gametypes\zombies::geteyeeffectforzombie("exploder", self.headmodel);
  maps\mp\zombies\_util::zombie_set_eyes(var_13);
  torso_effects_apply("mut_exp");
  self setsurfacetype("fruit");
  thread exploder_ambient_sound();
  self.hasexploded = 0;
  thread mutatorexploder_proximitybomb();
  self waittill("death");
}

mutatorexploder_dog() {
  thread mutatorspawnsound("exploder");
  maps\mp\zombies\_util::zombie_set_eyes("zombie_dog_eye_exploder");

  if(isDefined(level._effect["mut_exp_head"])) {
    maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_exp_head"], self, "j_head");
  }

  if(isDefined(level._effect["mut_exp_arm_r"])) {
    maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_exp_arm_r"], self, "r_frontLeg1_jnt");
  }

  if(isDefined(level._effect["mut_exp_arm_l"])) {
    maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_exp_arm_l"], self, "l_frontLeg1_jnt");
  }

  if(isDefined(level._effect["mut_exp_back"])) {
    maps\mp\zombies\_util::playfxontagnetwork(level._effect["mut_exp_back"], self, "spine4_jnt");
  }

  self setsurfacetype("fruit");
  thread exploder_ambient_sound();
  self.hasexploded = 0;
  self.bypasscorpse = 1;
  thread mutatorexploder_proximitybomb();
  self waittill("death");
}

exploder_ambient_sound() {
  self playLoopSound("zmb_exploder_ambient_loop");
  self waittill("death");
  self stoploopsound("zmb_exploder_ambient_loop");
}

runner_ambient_sound() {
  var_0 = spawn("script_origin", self.origin);
  var_0 linkto(self);
  var_0 playLoopSound("zmb_runner_ambient_loop");
  var_1 = 0;

  while(isalive(self)) {
    var_2 = self getvelocity();
    var_3 = distance((var_2[0], var_2[1], 0), (0, 0, 0));

    if(var_1 == 0 && var_3 < 5) {
      var_0 scalevolume(0, 0.5);
      self scalevolume(1, 0.5);
      var_1 = 1;
    } else if(var_1 && var_3 >= 5) {
      var_0 scalevolume(1, 0.5);
      self scalevolume(0, 0.5);
      var_1 = 0;
    }

    wait 1;
  }

  var_0 stoploopsound("zmb_runner_ambient_loop");
  waitframe();
  var_0 delete();
}

mutatorcrawl() {
  mutilate(12, 0);
}

startcrawl() {
  self.dismember_crawl = 1;
  maps\mp\agents\humanoid\_humanoid_util::dodgedisable();

  if(isDefined(self.lungemeleeenabled)) {
    maps\mp\agents\humanoid\_humanoid_util::lungemeleeupdate(10.0, 240, 120, "attack_lunge_boost", level._effect["boost_lunge"], 1, 255);
  }

  maps\mp\agents\humanoid\_humanoid_util::leapdisable();
  self scragentallowboost(0);
  self scragentsetorienttoground(1);
  self scragentsetviewheight(15);
  level.crawlingzombies++;
  self waittill("death");
  level.crawlingzombies--;
}

getdismembermentmodifier(var_0, var_1, var_2) {
  if(maps\mp\zombies\_util::isinstakill()) {
    return 0;
  }

  var_3 = undefined;

  if(isDefined(var_1)) {
    var_1 = getweaponbasename(var_1);
    var_3 = var_1;
  } else if(isDefined(var_2)) {
    var_3 = var_2;
  }

  if(!isDefined(var_3)) {
    return 1;
  }

  var_4 = level.dismembermentmodifiers[var_3];

  if(isDefined(var_0) && isplayer(var_0) && isDefined(var_1) && isDefined(var_4) && !maps\mp\_utility::iskillstreakweapon(var_1)) {
    var_4 = checkweaponupgrademodifier(var_0, var_1, var_4);
    return var_4;
  } else if(isDefined(var_4)) {
    return var_4;
  } else {
    return 1;
  }
}

checkweaponupgrademodifier(var_0, var_1, var_2) {
  var_3 = level.dismembermentupgrademodifiers[var_1];

  if(!isDefined(var_3)) {
    return var_2;
  }

  var_4 = maps\mp\zombies\_util::getzombieweaponlevel(var_0, var_1);

  if(var_4 <= 1) {
    return var_2;
  }

  var_5 = var_2 - var_3;
  var_6 = var_2 - var_4 / 3 * var_5;
  return clamp(var_6, var_3, var_2);
}

getmutilationmask(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_3 >= 1) {
    if(hasexplodermutator()) {
      return 31;
    }

    if(isDefined(var_2) && var_2 == "MOD_MELEE") {
      if(isDefined(var_4) && var_4 maps\mp\zombies\_terminals::hasexosuit()) {
        return 16;
      }
    }

    if(var_1 == "iw5_dlcgun4zm_mp") {
      return 31;
    }

    if(var_1 == "iw5_tridentzm_mp" && issubstr(var_0, "torso")) {
      return common_scripts\utility::random([17, 18, 3, 19, 16]);
    }
  }

  var_6 = maps\mp\zombies\_util::is_true(level.dismembermentignorelocation[var_1]) || maps\mp\zombies\_util::is_true(level.dismembermentignorelocation[var_2]) || maps\mp\zombies\_util::isinstakill();

  if(var_6) {
    var_7 = 31;
  } else {
    var_7 = locationtobodypart(var_0);
  }

  var_8 = 1;

  if(var_7 == 0) {
    return 0;
  }

  var_8 = var_8 * (getdismembermentmodifier(var_4, var_1, undefined) * getdismembermentmodifier(var_4, undefined, var_2));
  var_8 = var_8 * (-0.7 * var_3 + 1);
  return getmutilationmaskinternal(var_7, var_5, var_3, var_8);
}

getmutilationmaskinternal(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if((var_0 &var_0 - 1) > 0) {
    if(var_2 < 1) {
      var_5 = randomint(24);
      var_6 = 228;

      for(var_7 = 4; var_7 > 0; var_7--) {
        var_8 = 1 << var_5 % var_7 * 2;
        var_5 = int(var_5 / var_7);
        var_9 = var_6 % var_8;
        var_10 = int(var_6 / var_8);
        var_6 = var_9 + (var_10 >> 2) * var_8;
        var_11 = 1 << (var_10 & 3);

        if((var_0 &var_11) != 0 && isDefined(bodypartmasktoanimclass(var_1 | var_4 | var_11))) {
          if(randomfloat(1.0) >= chancetokeepbodypart(var_11) * var_3) {
            var_4 = var_4 | var_11;
          }
        }
      }
    } else {
      while(var_0 > 0) {
        var_11 = var_0 & 0 - var_0;

        if(randomfloat(1.0) >= chancetokeepbodypart(var_11) * var_3) {
          var_4 = var_4 | var_11;
        }

        var_0 = var_0 - var_11;
      }
    }
  } else if(var_2 >= 1 || isDefined(bodypartmasktoanimclass(var_1 | var_0))) {
    if(randomfloat(1.0) >= chancetokeepbodypart(var_0) * var_3) {
      var_4 = var_0;
    }
  }

  return var_4;
}

trymutilate(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;

  if(isalive(self) && (!maps\mp\agents\_scripted_agent_anim_util::isstatelocked() || var_3 >= 1) && self.aistate != "traverse" && maps\mp\zombies\_util::has_entered_game()) {
    var_7 = getmutilationmask(var_0, var_1, var_2, var_3, var_4, self.missingbodyparts);

    if(var_7 != 0) {
      var_8 = !maps\mp\zombies\_util::is_true(self.dismember_crawl);
      var_9 = isDefined(self.missingbodyparts) && self.missingbodyparts == 0;

      if(level.crawlingzombies < 3 || self.dismember_crawl || (var_7 & 12) == 0 || (var_7 & 16) != 0 || (self.missingbodyparts & 3) != 0) {
        if(mutilate(self.missingbodyparts | var_7, maps\mp\zombies\_util::is_true(level.highdamageweapons[var_1]), var_3, var_5)) {
          if(maps\mp\zombies\_util::isinstakill()) {
            earthquake(randomfloatrange(0.15, 0.35), 1, self.origin, 200);
          }

          var_6 = 1;
        } else if(!isDefined(self.limbmodels) && var_7 != 0 && (hasexplodermutator() || maps\mp\zombies\_util::isinstakill() && (maps\mp\zombies\_util::checkactivemutator("emz") || maps\mp\zombies\_util::checkactivemutator("fast")))) {
          earthquake(randomfloatrange(0.15, 0.35), 1, self.origin, 200);
          var_6 = 1;
        }

        if(isalive(self) && isplayer(var_4)) {
          if(var_8 && maps\mp\zombies\_util::is_true(self.dismember_crawl)) {
            var_4 thread maps\mp\zombies\_zombies_audio::player_hurt_zombie_vox("crawl_spawn");
          } else if(var_9 && isDefined(self.missingbodyparts) && self.missingbodyparts != 0) {
            var_4 thread maps\mp\zombies\_zombies_audio::player_hurt_zombie_vox("shoot_arm");
          }
        }
      }
    }
  }

  return var_6;
}

isfullbodymutilation() {
  if(!isDefined(self.recentlylostlimbs)) {
    return 0;
  }

  return maps\mp\zombies\_util::countlimbs(self.recentlylostlimbs) >= 3;
}

mutilate(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(isDefined(self.limbmodels) && var_0 != self.missingbodyparts) {
    var_6 = ~self.missingbodyparts &var_0;
    self.missingbodyparts = var_0;
    var_7 = self.spawntime < gettime();

    if(maps\mp\zombies\_util::countlimbs(var_6) >= 3) {
      if(var_7) {
        self.recentlylostlimbs = var_6;
      }

      var_7 = 0;
    }

    if((var_6 & 1) != 0) {
      detachlimb(1, self.limbmodels["right_arm"], var_3, var_7, var_4);
    }

    if((var_6 & 2) != 0) {
      detachlimb(2, self.limbmodels["left_arm"], var_3, var_7, var_4);
    }

    if((var_6 & 4) != 0) {
      detachlimb(4, self.limbmodels["right_leg"], var_3, var_7, var_4);
    }

    if((var_6 & 8) != 0) {
      detachlimb(8, self.limbmodels["left_leg"], var_3, var_7, var_4);
    }

    if((var_6 & 16) != 0) {
      detachlimb(16, self.headmodel, var_3, var_7, var_4);

      if(isDefined(self.linked_fx) && isDefined(self.linked_fx["tag_eye"])) {
        setfxkillondelete(self.linked_fx["tag_eye"], 1);
        thread delayeddeleteeyesfx();
      }
    }

    var_8 = bodypartmasktoanimclass(var_0);

    if(isDefined(var_8)) {
      if(!self.dismember_crawl && (var_0 & 12) != 0) {
        thread startcrawl();
      }

      if(var_7) {
        var_9 = var_8;

        switch (self.movemode) {
          case "walk":
            var_9 = var_9 + "_walk";
            break;
          case "sprint":
          case "run":
            var_9 = var_9 + "_run";
            break;
        }

        if(var_1) {
          var_9 = var_9 + "_highdamage";
        }

        if(var_2 < 1) {
          thread maps\mp\agents\humanoid\_humanoid_util::changeanimclass(var_8, var_9);
        } else {
          var_5 = 1;
        }
      } else {
        self setanimclass(var_8);

        if(self.aistate == "idle") {
          maps\mp\agents\_scripted_agent_anim_util::set_anim_state("idle_noncombat");
        }
      }
    } else {
      var_5 = 1;
    }

    if(var_5 && var_7) {
      self.recentlylostlimbs = var_6;
    }
  }

  return var_5;
}

delayeddeleteeyesfx() {
  self endon("death");
  waitframe();

  if(isDefined(self.linked_fx["tag_eye"])) {
    self.linked_fx["tag_eye"] delete();
    self.linked_fx["tag_eye"] = undefined;
  }
}

bodypartmasktoanimclass(var_0) {
  switch (var_0) {
    case 1:
      return "zombie_missing_right_arm_animclass";
    case 2:
      return "zombie_missing_left_arm_animclass";
    case 4:
      return "zombie_missing_right_leg_animclass";
    case 8:
      return "zombie_missing_left_leg_animclass";
    case 12:
      return "zombie_crawl_animclass";
    case 0:
      return "zombie_animclass";
    default:
      return undefined;
  }
}

locationtobodypart(var_0) {
  switch (var_0) {
    case "right_hand":
    case "right_arm_lower":
    case "right_arm_upper":
      return 1;
    case "left_hand":
    case "left_arm_lower":
    case "left_arm_upper":
      return 2;
    case "right_foot":
    case "right_leg_lower":
    case "right_leg_upper":
      return 4;
    case "left_foot":
    case "left_leg_lower":
    case "left_leg_upper":
      return 8;
    case "neck":
    case "helmet":
    case "head":
      return 16;
    default:
      return 0;
  }
}

chancetokeepbodypart(var_0) {
  if(isDefined(self.hasarmor) && var_0 != 16) {
    return 1;
  }

  switch (var_0) {
    case 1:
      return 0.45;
    case 2:
      return 0.45;
    case 4:
      return 0.5;
    case 8:
      return 0.5;
    case 16:
      if(isDefined(self.hashelmet)) {
        return 1;
      }

      return 0.65;
    default:
      return 1;
  }
}

getlimbproperty(var_0, var_1, var_2) {
  if(isDefined(level.dismemberment[var_1])) {
    var_3 = level.dismemberment[var_1][var_2];

    if(isDefined(var_3)) {
      return var_3;
    }
  }

  var_3 = level.dismemberment[var_0][var_2];
  return var_3;
}

getlimborigin(var_0, var_1) {
  var_2 = 40;

  switch (var_0) {
    case 2:
    case 1:
      return self.origin + (0, 0, var_2);
    case 8:
    case 4:
      var_3 = self gettagorigin(var_1);
      return (self.origin[0], self.origin[1], var_3[2]);
    case 16:
      return self gettagorigin(var_1);
  }
}

detachlimb(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = undefined;

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(var_3) {
    var_7 = getlimbproperty(var_0, var_1, "tagName");
    var_5 = getlimborigin(var_0, var_7);
    var_6 = self gettagangles(var_7);
  }

  self notify("detachLimb", var_0);
  self detach(var_1, "", 1);
  var_8 = getlimbproperty(var_0, var_1, "nub");

  if(isDefined(var_8)) {
    self attach(var_8, "", 1);
  }

  if(var_3) {
    var_9 = undefined;

    if(!level.currentgen && var_4) {
      var_9 = spawn("script_model", var_5);
      var_10 = getlimbproperty(var_0, var_1, "modelToSpawn");

      if(!isDefined(var_10)) {
        var_10 = var_1;
      }

      var_9 setModel(var_10);
      var_9.angles = var_6;
      var_11 = (0, 0, randomfloatrange(1000, 2000));

      if(!isDefined(var_2)) {
        var_2 = (0, 0, 0);
      }

      var_12 = var_2 * randomfloatrange(500, 1000);
      var_13 = (randomfloatrange(-2000, 2000), randomfloatrange(-2000, 2000), randomfloatrange(-2000, 2000));
      var_14 = anglestoright(self.angles);

      switch (var_0) {
        case 1:
          var_12 = var_12 + var_14 * 750;
          break;
        case 4:
          var_12 = var_12 + var_14 * 500;
          break;
        case 2:
          var_12 = var_12 - var_14 * 750;
          break;
        case 8:
          var_12 = var_12 - var_14 * 500;
          break;
      }

      var_15 = var_11 + var_12;
      var_16 = length(var_15);
      var_17 = var_15 / var_16;
      var_16 = min(var_16, 1750);
      var_9 physicslaunchclientwithimpulse(var_17 * var_16, var_13);
      var_9 deleteonhostmigration();

      if(level.nextdismemberedbodypartindex < level.dismemberedbodyparts.size) {
        level.dismemberedbodyparts[level.nextdismemberedbodypartindex] delete();
      }

      level.dismemberedbodyparts[level.nextdismemberedbodypartindex] = var_9;
      level.nextdismemberedbodypartindex = (level.nextdismemberedbodypartindex + 1) % 20;
    }

    var_18 = getlimbproperty(var_0, var_1, "fxTagName");
    var_19 = getlimbproperty(var_0, var_1, "torsoFX");
    var_20 = getlimbproperty(var_0, var_1, "limbFX");

    if(maps\mp\zombies\_util::checkactivemutator("emz")) {
      var_19 = var_19 + "_emz";
      var_20 = var_20 + "_emz";
    } else if(hasexplodermutator()) {
      var_19 = var_19 + "_exp";
      var_20 = var_20 + "_exp";
    } else if(maps\mp\zombies\_util::checkactivemutator("fast")) {
      var_19 = var_19 + "_ovr";
      var_20 = var_20 + "_ovr";
    }

    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_19), self, var_18, 1);

    if(!level.currentgen) {
      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_20), var_9, var_18, 1);
    }

    var_21 = maps\mp\zombies\_util::getdismembersoundname();
    var_22 = getlimbproperty(var_0, var_1, var_21);
    thread play_dismember_sound(var_22);
  }
}

play_dismember_sound(var_0) {
  waitframe();

  if(self.health > 0) {
    self playsoundonmovingent(var_0);
  } else {
    self playSound(var_0);
  }
}

mutatorspawnsound(var_0) {
  self notify("mutatorSpawnSound");
  self endon("mutatorSpawnSound");

  if(maps\mp\zombies\_util::is_true(self.nomutatorspawnsound)) {
    return;
  }
  if(isDefined(level.mutators[var_0][2])) {
    wait(randomfloatrange(0.2, 0.8));
    var_1 = level.mutators[var_0][2];
    self playsoundonmovingent(var_1);
  }
}

ondamagefinishedmutators(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  foreach(var_11 in level.mutators) {
    if(isDefined(var_11[4])) {
      self[[var_11[4]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }
  }
}

onkilledmutators(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  foreach(var_10 in level.mutators) {
    if(isDefined(var_10[3])) {
      self[[var_10[3]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }
  }
}