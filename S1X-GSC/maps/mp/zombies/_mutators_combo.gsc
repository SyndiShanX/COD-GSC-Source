/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_mutators_combo.gsc
***********************************************/

initcombomutators() {
  initcombomutatorfx();
  maps\mp\zombies\_mutators::addmutatortotable("combo_spike_teleport", ::mutatorcombospiketeleport, "zmb_mut_spiked_spawn", undefined, ::mutatorcombospiketeleportondamaged);
  maps\mp\zombies\_mutators::addmutatortotable("combo_exploder_teleport", ::mutatorcomboexploderteleport, "zmb_mut_expl_spawn", maps\mp\zombies\_mutators::onexploderzombiekilled);
  maps\mp\zombies\_mutators::addmutatortotable("combo_armor_emz", ::mutatorcomboarmoremz, "zmb_mut_emz_spawn", ::mutatorcomboarmoremzkilled, ::mutatorcomboarmoremzondamaged);
  maps\mp\zombies\_mutators::addmutatortotable("combo_emz_spike", ::mutatorcomboemzspike, "zmb_mut_emz_spawn", undefined, ::mutatorcomboemzspikeondamaged);
  maps\mp\zombies\_mutators::disablemutatorfortypes("combo_spike_teleport", ["zombie_dog", "zombie_melee_goliath", "zombie_ranged_goliath"]);
  maps\mp\zombies\_mutators::disablemutatorfortypes("combo_exploder_teleport", ["zombie_dog", "zombie_melee_goliath", "zombie_ranged_goliath"]);
  maps\mp\zombies\_mutators::disablemutatorfortypes("combo_armor_emz", ["zombie_dog", "zombie_melee_goliath", "zombie_ranged_goliath"]);
  maps\mp\zombies\_mutators::disablemutatorfortypes("combo_emz_spike", ["zombie_dog", "zombie_melee_goliath", "zombie_ranged_goliath"]);
}

initcombomutatorfx() {
  level.valideyetypes[level.valideyetypes.size] = "combo_spike_teleport";
  level.valideyetypes[level.valideyetypes.size] = "combo_exploder_teleport";
  level.valideyetypes[level.valideyetypes.size] = "combo_armor_emz";
  level.valideyetypes[level.valideyetypes.size] = "combo_emz_spike";
  level._effect["zombie_eye_combo_spike_teleport"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_tele_spike_dlc");
  level._effect["zombie_eye_combo_exploder_teleport"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_tele_exp_dlc");
  level._effect["zombie_eye_combo_armor_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_armor_cau_dlc_a");
  level._effect["zombie_eye_combo_armor_emz_cau_dlc_a"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_armor_cau_dlc_a");
  level._effect["zombie_eye_combo_armor_emz_cau_dlc_b"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_armor_cau_dlc_b");
  level._effect["zombie_eye_combo_armor_emz_cau_dlc_c"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_armor_cau_dlc_c");
  level._effect["zombie_eye_combo_emz_spike"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_spike_cau_dlc_a");
  level._effect["zombie_eye_combo_emz_spike_cau_dlc_a"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_spike_cau_dlc_a");
  level._effect["zombie_eye_combo_emz_spike_cau_dlc_b"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_spike_cau_dlc_b");
  level._effect["zombie_eye_combo_emz_spike_cau_dlc_c"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_cmb_emp_spike_cau_dlc_c");
  level._effect["mut_combo_exploder_teleport_head"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_head");
  level._effect["mut_combo_exploder_teleport_arm_l"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_upperarm_lt");
  level._effect["mut_combo_exploder_teleport_arm_r"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_upperarm_rt");
  level._effect["mut_combo_exploder_teleport_back"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_back");
  level._effect["mut_combo_exploder_teleport_pre"] = loadfx("vfx/unique/dlc_teleport_zm_cmb_tele_exp_start");
  level._effect["mut_combo_exploder_teleport_post"] = loadfx("vfx/unique/dlc_teleport_zm_cmb_tele_exp");
  level._effect["mut_combo_exploder_spike_pre"] = loadfx("vfx/unique/dlc_teleport_zm_cmb_tele_spike_start");
  level._effect["mut_combo_exploder_spike_post"] = loadfx("vfx/unique/dlc_teleport_zm_cmb_tele_spike");
  level._effect["mut_combo_exploder_detonate_lrg"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_detonate_lrg");
  level._effect["mut_combo_exploder_detonate_sml"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_detonate_sml");
  level._effect["mut_combo_exploder_detonate_charge"] = loadfx("vfx/gameplay/mp/zombie/zombie_cmb_tele_exp_detonate_charge");
  level._effect["mut_combo_emz_spike_attack"] = loadfx("vfx/gameplay/mp/zombie/dlc_zombie_attack_combo_emp_spike");
}

mutatorcombospiketeleport() {
  thread maps\mp\zombies\_mutators::mutatorspawnsound("combo_spike_teleport");
  maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
  self.boostfxtag = "tag_jetpack";
  mutatorcombospiketeleportmodelsetup();
  mutatorcombospiketeleportbehavior();
}

mutatorcombospiketeleportmodelsetup() {
  var_0 = ["zom_cmb_blink_spike_torso_a_slice"];
  var_1 = ["zom_cmb_blink_spike_nofx_torso_a_slice"];
  var_2 = ["zom_cmb_blink_spike_head_a"];
  var_3 = ["zom_cmb_blink_spike_r_leg_a_slice"];
  var_4 = ["zom_cmb_blink_spike_l_leg_a_slice"];
  var_5 = ["zom_cmb_blink_spike_r_arm_a_slice"];
  var_6 = ["zom_cmb_blink_spike_nofx_r_arm_a_slice"];
  var_7 = ["zom_cmb_blink_spike_l_arm_a_slice"];
  var_8 = ["zom_cmb_blink_spike_nofx_l_arm_a_slice"];
  var_9 = randomint(var_0.size);
  var_10 = randomint(var_2.size);
  var_11 = randomint(var_3.size);
  var_12 = randomint(var_4.size);
  var_13 = randomint(var_5.size);
  var_14 = randomint(var_7.size);
  self.precloneswapfunc = maps\mp\zombies\_mutators::mutator_precloneswap;
  self detachall();
  self setModel(var_0[var_9]);
  self.swapbody = var_1[var_9];
  self attach(var_2[var_10]);
  self.headmodel = var_2[var_10];
  self attach(var_3[var_11]);
  self attach(var_4[var_12]);
  self attach(var_5[var_13]);
  self attach(var_7[var_14]);
  self.limbmodels["right_leg"] = var_3[var_11];
  self.limbmodels["left_leg"] = var_4[var_12];
  self.limbmodels["right_arm"] = var_5[var_13];
  self.limbmodels["left_arm"] = var_7[var_14];
  self.swaplimbmodels["right_arm"] = var_6[var_13];
  self.swaplimbmodels["left_arm"] = var_8[var_14];

  if(!isDefined(self.moverateroundmod)) {
    self.moverateroundmod = 0;
  }

  self.moverateroundmod = self.moverateroundmod + 5;
  mutatorcombospiketeleporteyefx();
  self.eyefxfunc = ::mutatorcombospiketeleporteyefx;
  self.teleportprefxoverride = level._effect["mut_combo_exploder_spike_pre"];
  self.teleportpostfxoverride = level._effect["mut_combo_exploder_spike_post"];
}

mutatorcombospiketeleporteyefx() {
  var_0 = maps\mp\gametypes\zombies::geteyeeffectforzombie("combo_spike_teleport", self.headmodel);
  maps\mp\zombies\_util::zombie_set_eyes(var_0);
}

mutatorcombospiketeleportbehavior() {
  thread maps\mp\zombies\_mutators_teleport::mutatorteleport_handleteleport();
  self waittill("death");
  playsoundatpos(self.origin, "zmb_mut_spiked_explo");
}

mutatorcombospiketeleportondamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!maps\mp\zombies\_util::checkactivemutator("combo_spike_teleport")) {
    return;
  }
  if(common_scripts\utility::cointoss()) {
    return;
  }
  if(!isDefined(self.spikeblastready)) {
    thread mutatorcombospikeblast(var_1);
  }
}

mutatorcombospikeblast(var_0) {
  self endon("death");
  self.spikeblastready = 0;
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = self gettagorigin("J_Spine4");
  var_1 linkto(self, "J_Spine4");
  wait 0.05;

  if(maps\mp\zombies\_util::checkactivemutator("combo_emz_spike")) {
    playFX(common_scripts\utility::getfx("mut_combo_emz_spike_attack"), var_1.origin);
  } else {
    playFX(common_scripts\utility::getfx("mut_spiked_explosion_2"), var_1.origin);
  }

  playsoundatpos(var_1.origin, "zmb_mut_spiked_explo_overkill");
  wait 0.1;

  foreach(var_3 in level.players) {
    if(distance(var_3.origin, self.origin) < 150) {
      var_4 = clamp(25 * (level.wavecounter / 9), 25, 50);

      if(isDefined(var_0) && var_3 == var_0) {
        var_3 dodamage(var_4, self.origin);
      } else {
        var_3 dodamage(var_4 * 0.5, self.origin);
      }
    }
  }

  var_1 delete();
  wait 0.75;

  if(isalive(self)) {
    self.spikeblastready = undefined;
  }
}

mutatorcomboexploderteleport() {
  thread maps\mp\zombies\_mutators::mutatorspawnsound("combo_exploder_teleport");
  maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
  self.boostfxtag = "tag_jetpack";
  mutatorcomboexploderteleportmodelsetup();
  mutatorcomboexploderteleportbehavior();
}

mutatorcomboexploderteleportmodelsetup() {
  var_0 = ["zom_cmb_blink_fire_torso_a_slice"];
  var_1 = ["zom_cmb_blink_fire_nofx_torso_a_slice"];
  var_2 = ["zom_cmb_blink_fire_head_a"];
  var_3 = ["zom_cmb_blink_fire_r_leg_a_slice"];
  var_4 = ["zom_cmb_blink_fire_l_leg_a_slice"];
  var_5 = ["zom_cmb_blink_fire_r_arm_a_slice"];
  var_6 = ["zom_cmb_blink_fire_l_arm_a_slice"];
  var_7 = randomint(var_0.size);
  var_8 = randomint(var_2.size);
  var_9 = randomint(var_3.size);
  var_10 = randomint(var_4.size);
  var_11 = randomint(var_5.size);
  var_12 = randomint(var_6.size);
  self.precloneswapfunc = maps\mp\zombies\_mutators::mutator_precloneswap;
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
  mutatorcomboexploderteleporteyefx();
  self.eyefxfunc = ::mutatorcomboexploderteleporteyefx;
  self setsurfacetype("bark");
  self.teleportprefxoverride = level._effect["mut_combo_exploder_teleport_pre"];
  self.teleportpostfxoverride = level._effect["mut_combo_exploder_teleport_post"];
  self.detonatechargefxoverride = level._effect["mut_combo_exploder_detonate_charge"];
  self.detonatelargefxoverride = level._effect["mut_combo_exploder_detonate_lrg"];
  self.detonatesmallfxoverride = level._effect["mut_combo_exploder_detonate_sml"];
}

mutatorcomboexploderteleporteyefx() {
  var_0 = maps\mp\gametypes\zombies::geteyeeffectforzombie("combo_exploder_teleport", self.headmodel);
  maps\mp\zombies\_util::zombie_set_eyes(var_0);
  maps\mp\zombies\_mutators::torso_effects_apply("mut_combo_exploder_teleport");
}

mutatorcomboexploderteleportbehavior() {
  thread maps\mp\zombies\_mutators::exploder_ambient_sound();
  self.hasexploded = 0;
  thread maps\mp\zombies\_mutators::mutatorexploder_proximitybomb();
  thread maps\mp\zombies\_mutators_teleport::mutatorteleport_handleteleport();
  self waittill("death");
}

mutatorcomboarmoremz() {
  thread maps\mp\zombies\_mutators::mutatorspawnsound("combo_armor_emz");
  maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
  self.boostfxtag = "no_boost_fx";
  mutatorcomboarmoremzmodelsetup();
  mutatorcomboarmoremzbehavior();
}

mutatorcomboarmoremzmodelsetup() {
  var_0 = ["zom_cmb_armor_emp_body"];
  var_1 = ["zom_cmb_armor_emp_nofx_body"];
  var_2 = ["zombies_head_mutator_emp", "zombies_head_mutator_emp_cau_a", "zombies_head_mutator_emp_cau_b", "zombies_head_mutator_emp_cau_c"];
  var_3 = randomint(var_0.size);
  var_4 = randomint(var_2.size);
  self.precloneswapfunc = maps\mp\zombies\_mutators::mutator_precloneswap;
  self detachall();
  self.limbmodels = undefined;
  self setModel(var_0[var_3]);
  self.swapbody = var_1[var_3];
  self attach(var_2[var_4]);
  self.headmodel = var_2[var_4];
  var_5 = maps\mp\gametypes\zombies::geteyeeffectforzombie("combo_armor_emz", self.headmodel);
  maps\mp\zombies\_util::zombie_set_eyes(var_5);
  maps\mp\zombies\_mutators::torso_effects_apply("mut_emz");
  self setsurfacetype("bark");
  self playLoopSound("zmb_emz_crackle_loop");
}

mutatorcomboarmoremzbehavior() {
  thread maps\mp\zombies\_mutators::mutatoremz_watchforattackhits();
  thread maps\mp\zombies\_mutators::mutatoremz_watchforproximityboosters();
  thread mutatorcomboaddhelmet();
  self waittill("death");
}

mutatorcomboarmoremzondamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!maps\mp\zombies\_util::checkactivemutator("combo_armor_emz")) {
    return;
  }
  if(isDefined(self.hashelmet) && isplayer(var_1) && maps\mp\_utility::isheadshot(var_5, var_8, var_4)) {
    self.helmet_health = self.helmet_health - var_2;

    if(self.helmet_health <= 0) {
      self notify("helmet_lost");
    }
  }
}

mutatorcomboarmoremzkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!maps\mp\zombies\_util::checkactivemutator("combo_armor_emz")) {
    return;
  }
  if(isDefined(self.hashelmet) && isDefined(self.helmet)) {
    self.helmet unlink();
    self.helmet setModel("zombie_helmet_collision");
    self.helmet physicslaunchclient(self.helmet.origin, (randomintrange(-5, 5), randomintrange(-5, 5), randomintrange(-5, 5)));
  }
}

mutatorcomboaddhelmet() {
  var_0 = "J_helmet";
  self.hasarmor = 1;
  self.hashelmet = 1;
  self.helmet_health = 50;
  var_1 = self gettagorigin(var_0);
  var_2 = self gettagangles(var_0);
  var_3 = spawn("script_model", var_1);
  self.helmet = var_3;
  var_3.angles = var_2;
  var_3 setModel("zombie_helmet");
  var_3 linkto(self, var_0, (-0.2, -0.45, -4.7), (0, 90, 0));
  thread mutatorcombohelmetdetach(var_3);
  self waittill("death");
  self.hashelmet = undefined;
  self.helmet = undefined;
  thread mutatorcombohelmetcleanup(var_3);
}

mutatorcombohelmetdetach(var_0) {
  self endon("death");
  self waittill("helmet_lost");
  self.hashelmet = undefined;
  self.helmet = undefined;
  earthquake(0.25, 0.4, self.origin, 128);
  self.moverateroundmod = self.moverateroundmod + 5;
  playFX(common_scripts\utility::getfx("mut_helmet_impact"), var_0.origin);
  var_0 playSound("zmb_mut_armor_helmet_ping");
  var_0 unlink();
  var_0 setModel("zombie_helmet_collision");
  var_0 physicslaunchclient(var_0.origin, (randomintrange(-5, 5), randomintrange(-5, 5), randomintrange(-5, 5)));
  physicsexplosionsphere(var_0.origin - (0, 0, 2), 16, 1, 5);
  thread mutatorcombohelmetcleanup(var_0);
}

mutatorcombohelmetcleanup(var_0) {
  wait 5;

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

mutatorcomboemzspike() {
  thread maps\mp\zombies\_mutators::mutatorspawnsound("combo_spike_teleport");
  maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
  self.boostfxtag = "tag_jetpack";
  mutatorcomboemzspikemodelsetup();
  mutatorcomboemzspikebehavior();
}

mutatorcomboemzspikemodelsetup() {
  var_0 = ["zom_mut_cmb_spikes_emp_torso_slice"];
  var_1 = ["zom_mut_cmb_spikes_emp_nofx_torso_slice"];
  var_2 = ["zombies_head_mutator_fire", "zombies_head_mutator_fire_cau_a", "zombies_head_mutator_fire_cau_b", "zombies_head_mutator_fire_cau_c"];
  var_3 = ["zom_mut_cmb_spikes_emp_r_leg_slice"];
  var_4 = ["zom_mut_cmb_spikes_emp_l_leg_slice"];
  var_5 = ["zom_mut_cmb_spikes_emp_r_arm_slice"];
  var_6 = ["zom_mut_cmb_spikes_emp_nofx_r_arm_slice"];
  var_7 = ["zom_mut_cmb_spikes_emp_l_arm_slice"];
  var_8 = ["zom_mut_cmb_spikes_emp_nofx_l_arm_slice"];
  var_9 = randomint(var_0.size);
  var_10 = randomint(var_2.size);
  var_11 = randomint(var_3.size);
  var_12 = randomint(var_4.size);
  var_13 = randomint(var_5.size);
  var_14 = randomint(var_7.size);
  self.precloneswapfunc = maps\mp\zombies\_mutators::mutator_precloneswap;
  self detachall();
  self setModel(var_0[var_9]);
  self.swapbody = var_1[var_9];
  self attach(var_2[var_10]);
  self.headmodel = var_2[var_10];
  self attach(var_3[var_11]);
  self attach(var_4[var_12]);
  self attach(var_5[var_13]);
  self attach(var_7[var_14]);
  self.limbmodels["right_leg"] = var_3[var_11];
  self.limbmodels["left_leg"] = var_4[var_12];
  self.limbmodels["right_arm"] = var_5[var_13];
  self.limbmodels["left_arm"] = var_7[var_14];
  self.swaplimbmodels["right_arm"] = var_6[var_13];
  self.swaplimbmodels["left_arm"] = var_8[var_14];

  if(!isDefined(self.moverateroundmod)) {
    self.moverateroundmod = 0;
  }

  self.moverateroundmod = self.moverateroundmod + 5;
  var_15 = maps\mp\gametypes\zombies::geteyeeffectforzombie("combo_emz_spike", self.headmodel);
  maps\mp\zombies\_util::zombie_set_eyes(var_15);
  maps\mp\zombies\_mutators::torso_effects_apply("mut_emz");
  self setsurfacetype("bark");
  self playLoopSound("zmb_emz_crackle_loop");
}

mutatorcomboemzspikebehavior() {
  thread maps\mp\zombies\_mutators::mutatoremz_watchforattackhits();
  thread maps\mp\zombies\_mutators::mutatoremz_watchforproximityboosters();
  self waittill("death");
  playsoundatpos(self.origin, "zmb_mut_spiked_explo");
}

mutatorcomboemzspikeondamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!maps\mp\zombies\_util::checkactivemutator("combo_emz_spike")) {
    return;
  }
  if(common_scripts\utility::cointoss()) {
    return;
  }
  if(!isDefined(self.spikeblastready)) {
    thread mutatorcombospikeblast(var_1);
    thread maps\mp\zombies\_mutators::mutatoremz_bursttonearbyplayers(0);
  }
}