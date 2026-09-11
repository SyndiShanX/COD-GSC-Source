/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_cp_alq_desert_shotgun.gsc
**************************************************/

function main() {
  self.additionalassets = "";
  self.subclass = "regular";
  self.defaultcoverselector = "cover_shotgunner";
  self.enemyselector = "enemyselector_default_cp";
  self.unittype = "soldier";
  self setengagementmindist(0, 0);
  self setengagementmaxdist(280, 400);
  self.accuracy = 0.2;
  self.weapon = scripts\cp\cp_weapon::buildweapon("iw8_sh_romeo870_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
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
  var2 = ["character_cp_al_qatala_desert_ar", "character_cp_al_qatala_desert_ar_2", "character_cp_al_qatala_desert_ar_3", "character_cp_al_qatala_desert_ar_4", "character_cp_al_qatala_desert_dmr", "character_cp_al_qatala_desert_cqc"];

  switch (scripts\code\character::get_random_character(6, var1, var2, "actor_enemy_cp_alq_desert_shotgun")) {
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
    case 4:
      character\character_cp_al_qatala_desert_dmr::main_mp();
      break;
    case 5:
      character\character_cp_al_qatala_desert_cqc::main_mp();
      break;
  }
}

function precache() {
  var0 = "actor_enemy_cp_alq_desert_shotgun";

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
    character\character_cp_al_qatala_desert_dmr::precache_mp(var0);
    character\character_cp_al_qatala_desert_cqc::precache_mp(var0);
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