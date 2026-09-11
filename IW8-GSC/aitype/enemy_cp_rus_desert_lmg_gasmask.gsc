/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_cp_rus_desert_lmg_gasmask.gsc
******************************************************/

function main() {
  self.additionalassets = "";
  self.subclass = "regular";
  self.defaultcoverselector = "cover_default_cp";
  self.enemyselector = "enemyselector_default_cp";
  self.unittype = "soldier";
  self setengagementmindist(256, 0);
  self setengagementmaxdist(768, 1024);
  self.accuracy = 0.2;
  self.weapon = scripts\cp\cp_weapon::buildweapon("iw8_lm_pkilo_mp", ["bipod_pkilo"], "none", "none");
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
  var2 = ["character_spetsnaz_gasmask_lmg_cp", "character_spetsnaz_gasmask_nohelmet_lmg_cp"];

  switch (scripts\code\character::get_random_character(2, var1, var2, "actor_enemy_cp_rus_desert_lmg_gasmask")) {
    case 0:
      scripts\cp\cp_challenge::main_mp();
      break;
    case 1:
      scripts\cp\cp_enemy_sentry_turret::main_mp();
      break;
  }
}

function precache() {
  var0 = "actor_enemy_cp_rus_desert_lmg_gasmask";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[var0])) {
    level.agent_definition[var0] = [];
    level.agent_definition[var0]["species"] = "human";
    level.agent_definition[var0]["traversal_unit_type"] = "soldier";
    level.agent_definition[var0]["health"] = 270;
    level.agent_definition[var0]["xp"] = 50;
    level.agent_definition[var0]["reward"] = 120;
    level.agent_definition[var0]["asm"] = "soldier_cp";
    level.agent_definition[var0]["radius"] = 15;
    level.agent_definition[var0]["height"] = 70;
    level.agent_definition[var0]["behaviorTree"] = "soldier_agent";
    level.agent_definition[var0]["team"] = "axis";
    level.agent_definition[var0]["setup_func"] = &main;
    level.agent_definition[var0]["setup_model_func"] = &setup_model;
    scripts\cp\cp_challenge::precache_mp(var0);
    scripts\cp\cp_enemy_sentry_turret::precache_mp(var0);
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