/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\ally_cp_reb_ar.gsc
***********************************************/

function main() {
  self.additionalassets = "";
  self.subclass = "regular";
  self.defaultcoverselector = "cover_default_cp";
  self.enemyselector = "enemyselector_default_cp";
  self.unittype = "soldier";
  self setengagementmindist(256, 0);
  self setengagementmaxdist(768, 1024);
  self.accuracy = 0.2;

  switch (scripts\code\character::get_random_weapon(2)) {
    case 0:
      self.weapon = scripts\cp\cp_weapon::buildweapon("iw8_ar_akilo47_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 1:
      self.weapon = scripts\cp\cp_weapon::buildweapon("iw8_ar_falpha_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
  }

  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.sidearm = scripts\cp\cp_weapon::buildweapon("iw8_pi_golf21_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  self.grenadeweapon = getcompleteweaponname("frag_grenade_mp");
  self.grenadeammo = 2;
}

function setup_model(var0) {
  var1 = undefined;
  var2 = ["character_sla_rebels_male_ar", "character_sla_rebels_male_ar_2_1", "character_sla_rebels_male_cqb", "character_sla_rebels_male_cqb_2_1", "character_sla_rebels_male_lmg", "character_sla_rebels_male_lmg_2_1", "character_iw8_sla_rebel_female_1_1", "character_iw8_sla_rebel_female_2_1"];

  switch (scripts\code\character::get_random_character(8, var1, var2, "actor_ally_cp_reb_ar")) {
    case 0:
      character\character_sla_rebels_male_ar::main_mp();
      break;
    case 1:
      character\character_sla_rebels_male_ar_2_1::main_mp();
      break;
    case 2:
      character\character_sla_rebels_male_cqb::main_mp();
      break;
    case 3:
      character\character_sla_rebels_male_cqb_2_1::main_mp();
      break;
    case 4:
      character\character_sla_rebels_male_lmg::main_mp();
      break;
    case 5:
      character\character_sla_rebels_male_lmg_2_1::main_mp();
      break;
    case 6:
      character\character_iw8_sla_rebel_female_1_1::main_mp();
      break;
    case 7:
      character\character_iw8_sla_rebel_female_2_1::main_mp();
      break;
  }
}

function precache() {
  var0 = "actor_ally_cp_reb_ar";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[var0])) {
    level.agent_definition[var0] = [];
    level.agent_definition[var0]["species"] = "human";
    level.agent_definition[var0]["traversal_unit_type"] = "soldier";
    level.agent_definition[var0]["health"] = 150;
    level.agent_definition[var0]["xp"] = 50;
    level.agent_definition[var0]["reward"] = 100;
    level.agent_definition[var0]["asm"] = "soldier_cp";
    level.agent_definition[var0]["radius"] = 15;
    level.agent_definition[var0]["height"] = 70;
    level.agent_definition[var0]["behaviorTree"] = "soldier_agent";
    level.agent_definition[var0]["team"] = "allies";
    level.agent_definition[var0]["setup_func"] = &main;
    level.agent_definition[var0]["setup_model_func"] = &setup_model;
    character\character_sla_rebels_male_ar::precache_mp(var0);
    character\character_sla_rebels_male_ar_2_1::precache_mp(var0);
    character\character_sla_rebels_male_cqb::precache_mp(var0);
    character\character_sla_rebels_male_cqb_2_1::precache_mp(var0);
    character\character_sla_rebels_male_lmg::precache_mp(var0);
    character\character_sla_rebels_male_lmg_2_1::precache_mp(var0);
    character\character_iw8_sla_rebel_female_1_1::precache_mp(var0);
    character\character_iw8_sla_rebel_female_2_1::precache_mp(var0);
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