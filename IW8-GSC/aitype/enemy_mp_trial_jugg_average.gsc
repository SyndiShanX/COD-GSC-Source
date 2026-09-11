/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_mp_trial_jugg_average.gsc
**************************************************/

function main() {
  self.additionalassets = "";
  self.subclass = "regular";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";
  self.unittype = "soldier";
  self setengagementmindist(128, 0);
  self setengagementmaxdist(1200, 1600);
  self.accuracy = 0.01;

  switch (scripts\code\character::get_random_weapon(5)) {
    case 0:
      self.weapon = scripts\mp\class::buildweapon("iw8_ar_akilo47", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 1:
      self.weapon = scripts\mp\class::buildweapon("iw8_lm_pkilo", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 2:
      self.weapon = scripts\mp\class::buildweapon("iw8_sm_uzulu", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 3:
      self.weapon = scripts\mp\class::buildweapon("iw8_ar_falpha", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 4:
      self.weapon = scripts\mp\class::buildweapon("iw8_ar_falima", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
  }

  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = getcompleteweaponname("molotov");
  self.grenadeammo = 1;
}

function setup_model(var0) {
  var1 = undefined;
  var2 = ["character_spetsnaz_cqc_trial", "character_spetsnaz_ar_trial", "character_spetsnaz_lmg_trial", "character_spetsnaz_dmr_trial"];

  switch (scripts\code\character::get_random_character(4, var1, var2, "actor_enemy_mp_trial_jugg_average")) {
    case 0:
      scripts\cp\animation_suite::main_mp();
      break;
    case 1:
      xmodelalias\heads_al_qatala_tmtyl::main_mp();
      break;
    case 2:
      scripts\cp\cp_events::main_mp();
      break;
    case 3:
      scripts\cp\challenges_cp::main_mp();
      break;
  }
}

function precache() {
  var0 = "actor_enemy_mp_trial_jugg_average";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[var0])) {
    level.agent_definition[var0] = [];
    level.agent_definition[var0]["species"] = "human";
    level.agent_definition[var0]["traversal_unit_type"] = "soldier";
    level.agent_definition[var0]["health"] = 200;
    level.agent_definition[var0]["xp"] = 50;
    level.agent_definition[var0]["reward"] = 50;
    level.agent_definition[var0]["asm"] = "soldier_cp";
    level.agent_definition[var0]["radius"] = 15;
    level.agent_definition[var0]["height"] = 70;
    level.agent_definition[var0]["behaviorTree"] = "soldier_agent";
    level.agent_definition[var0]["team"] = "axis";
    level.agent_definition[var0]["setup_func"] = &main;
    level.agent_definition[var0]["setup_model_func"] = &setup_model;
    scripts\cp\animation_suite::precache_mp(var0);
    xmodelalias\heads_al_qatala_tmtyl::precache_mp(var0);
    scripts\cp\cp_events::precache_mp(var0);
    scripts\cp\challenges_cp::precache_mp(var0);
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