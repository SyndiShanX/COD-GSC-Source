/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_cp_rus_desert_ar_goliath.gsc
*****************************************************/

function main() {
  self.additionalassets = "";
  self.subclass = "regular";
  self.defaultcoverselector = "cover_default_cp";
  self.enemyselector = "enemyselector_default";
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
  self.grenadeweapon = isundefinedweapon();
  self.grenadeammo = 2;
}

function setup_model(var_0) {
  character\character_russian_boss_hometown_cp::main_mp();
}

function precache() {
  var_0 = "actor_enemy_cp_rus_desert_ar_goliath";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[var_0])) {
    level.agent_definition[var_0] = [];
    level.agent_definition[var_0]["species"] = "human";
    level.agent_definition[var_0]["traversal_unit_type"] = "soldier";
    level.agent_definition[var_0]["health"] = 150;
    level.agent_definition[var_0]["xp"] = 50;
    level.agent_definition[var_0]["reward"] = 110;
    level.agent_definition[var_0]["asm"] = "soldier_cp";
    level.agent_definition[var_0]["radius"] = 15;
    level.agent_definition[var_0]["height"] = 70;
    level.agent_definition[var_0]["behaviorTree"] = "soldier_agent";
    level.agent_definition[var_0]["team"] = "axis";
    level.agent_definition[var_0]["setup_func"] = &main;
    level.agent_definition[var_0]["setup_model_func"] = &setup_model;
    character\character_russian_boss_hometown_cp::precache_mp(var_0);
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