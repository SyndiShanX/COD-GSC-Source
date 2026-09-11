/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_mp_trial_clr_lmg_night.gsc
***************************************************/

function main() {
  self.additionalassets = "";
  self.subclass = "regular";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";
  self.unittype = "soldier";
  self setengagementmindist(256, 0);
  self setengagementmaxdist(1400, 2000);
  self.accuracy = 0.3;
  self.weapon = scripts\mp\class::buildweapon("iw8_lm_pkilo", ["laserrange_bar"], "none", "none");
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = getcompleteweaponname("frag_grenade_mp");
  self.grenadeammo = 1;
}

function setup_model(var_0) {
  character\character_al_qatala_trials::main_mp();
}

function precache() {
  var_0 = "actor_enemy_mp_trial_clr_lmg_night";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[var_0])) {
    level.agent_definition[var_0] = [];
    level.agent_definition[var_0]["species"] = "human";
    level.agent_definition[var_0]["traversal_unit_type"] = "soldier";
    level.agent_definition[var_0]["health"] = 140;
    level.agent_definition[var_0]["xp"] = 50;
    level.agent_definition[var_0]["reward"] = 50;
    level.agent_definition[var_0]["asm"] = "soldier_cp";
    level.agent_definition[var_0]["radius"] = 15;
    level.agent_definition[var_0]["height"] = 70;
    level.agent_definition[var_0]["behaviorTree"] = "soldier_agent";
    level.agent_definition[var_0]["team"] = "axis";
    level.agent_definition[var_0]["setup_func"] = &main;
    level.agent_definition[var_0]["setup_model_func"] = &setup_model;
    character\character_al_qatala_trials::precache_mp(var_0);
  }

  scripts\aitypes\bt_util::init();
  behaviortree\soldier_agent::registerbehaviortree();
  aiasm\suicidebomber_cp_mp::asm_register();
  scripts\cp_mp\agents\agent_init::agent_init();

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  if(!isDefined(level.species_funcs["human"])) {
    level.species_funcs["human"] = [];
  }

  scripts\aitypes\assets::soldier();
}