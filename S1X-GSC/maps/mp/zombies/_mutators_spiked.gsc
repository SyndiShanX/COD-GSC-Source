/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_mutators_spiked.gsc
************************************************/

initspikedmutator() {
  level._effect["mut_spiked_explosion"] = loadfx("vfx/blood/dlc_zombie_spike_explosion");
  level._effect["mut_spiked_explosion_2"] = loadfx("vfx/blood/dlc_zombie_spike_explosion_2");
  maps\mp\zombies\_mutators::addmutatortotable("spiked", ::mutatorspiked, "zmb_mut_spiked_spawn", undefined, ::onspikedzombiedamaged);
  maps\mp\zombies\_mutators::disablemutatorfortypes("spiked", ["zombie_dog", "zombie_melee_goliath", "zombie_ranged_goliath"]);
}

mutatorspiked() {
  thread maps\mp\zombies\_mutators::mutatorspawnsound("spiked");
  maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
  self.boostfxtag = "tag_jetpack";
  var_0 = ["zom_marine_m_spikes_exo_torso_slice"];
  var_1 = ["zom_marine_m_spikes_exo_torso_slice"];
  var_2 = ["zombies_head_mutator_fire", "zombies_head_mutator_fire_cau_a", "zombies_head_mutator_fire_cau_b", "zombies_head_mutator_fire_cau_c"];
  var_3 = ["zom_marine_m_ovr_exo_r_leg_slice", "zom_marine_m_ovr_exo_r_leg_slice_ab"];
  var_4 = ["zom_marine_m_ovr_nofx_exo_r_leg_slice", "zom_marine_m_ovr_nofx_exo_r_leg_slice_ab"];
  var_5 = ["zom_marine_m_ovr_exo_l_leg_slice", "zom_marine_m_ovr_exo_l_leg_slice_ab"];
  var_6 = ["zom_marine_m_ovr_nofx_exo_l_leg_slice", "zom_marine_m_ovr_nofx_exo_l_leg_slice_ab"];
  var_7 = ["zom_marine_m_spikes_exo_r_arm_slice"];
  var_8 = ["zom_marine_m_spikes_exo_r_arm_slice"];
  var_9 = ["zom_marine_m_spikes_exo_l_arm_slice"];
  var_10 = ["zom_marine_m_spikes_exo_l_arm_slice"];
  var_11 = randomint(var_0.size);
  var_12 = randomint(var_2.size);
  var_13 = randomint(var_3.size);
  var_14 = randomint(var_5.size);
  var_15 = randomint(var_7.size);
  var_16 = randomint(var_9.size);
  self.precloneswapfunc = maps\mp\zombies\_mutators::mutator_precloneswap();
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
  self.swaplimbmodels["right_arm"] = var_8[var_15];
  self.swaplimbmodels["left_arm"] = var_10[var_16];

  if(!isDefined(self.moverateroundmod)) {
    self.moverateroundmod = 0;
  }

  self.moverateroundmod = self.moverateroundmod + 5;
  var_17 = maps\mp\gametypes\zombies::geteyeeffectforzombie("fast", self.headmodel);
  maps\mp\zombies\_util::zombie_set_eyes(var_17);
  self waittill("death");
  playsoundatpos(self.origin, "zmb_mut_spiked_explo");
}

onspikedzombiedamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!maps\mp\zombies\_util::checkactivemutator("spiked")) {
    return;
  }
  if(common_scripts\utility::cointoss()) {
    return;
  }
  if(!isDefined(self.spikeblastready)) {
    thread spikeblast(var_1);
  }
}

spikeblast(var_0) {
  self endon("death");
  self.spikeblastready = 0;
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = self gettagorigin("J_Spine4");
  var_1 linkto(self, "J_Spine4");
  wait 0.05;
  playFX(common_scripts\utility::getfx("mut_spiked_explosion_2"), var_1.origin);
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