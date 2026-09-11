/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_cp_alq_desert_ar.gsc
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

  switch (scripts\code\character::get_random_weapon(3)) {
    case 0:
      self.weapon = scripts\cp\cp_weapon::buildweapon("iw8_ar_akilo47_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 1:
      self.weapon = scripts\cp\cp_weapon::buildweapon("iw8_ar_falpha_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 2:
      self.weapon = scripts\cp\cp_weapon::buildweapon("iw8_ar_falima_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
  }

  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.sidearm = scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  self.grenadeweapon = getcompleteweaponname("frag_grenade_mp");
  self.grenadeammo = 2;
}

function setup_model(var0) {
  var1 = undefined;
  var2 = ["character_cp_al_qatala_desert_ar", "character_cp_al_qatala_desert_ar_2", "character_cp_al_qatala_desert_ar_3", "character_cp_al_qatala_desert_ar_4"];

  switch (scripts\code\character::get_random_character(4, var1, var2, "actor_enemy_cp_alq_desert_ar")) {
    case 0:
      character\character_cp_al_qatala_desert_ar::main_mp();
      break;
    case 1:
      character\character_cp_al_qatala_desert_ar_2::main_mp();
      break;
    case 2:
      character\character_cp_al_qatala_desert_ar_3::main_mp();
      break;
    case 3:
      character\character_cp_al_qatala_desert_ar_4::main_mp();
      break;
  }
}

function precache() {
  var0 = "actor_enemy_cp_alq_desert_ar";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[var0])) {
    level.agent_definition[var0] = [];
    level.agent_definition[var0]["species"] = "human";
    level.agent_definition[var0]["traversal_unit_type"] = "soldier";
    level.agent_definition[var0]["health"] = 180;
    level.agent_definition[var0]["xp"] = 50;
    level.agent_definition[var0]["reward"] = 100;
    level.agent_definition[var0]["asm"] = "soldier_cp";
    level.agent_definition[var0]["radius"] = 15;
    level.agent_definition[var0]["height"] = 70;
    level.agent_definition[var0]["behaviorTree"] = "soldier_agent";
    level.agent_definition[var0]["team"] = "axis";
    level.agent_definition[var0]["setup_func"] = &main;
    level.agent_definition[var0]["setup_model_func"] = &setup_model;
    character\character_cp_al_qatala_desert_ar::precache_mp(var0);
    character\character_cp_al_qatala_desert_ar_2::precache_mp(var0);
    character\character_cp_al_qatala_desert_ar_3::precache_mp(var0);
    character\character_cp_al_qatala_desert_ar_4::precache_mp(var0);
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