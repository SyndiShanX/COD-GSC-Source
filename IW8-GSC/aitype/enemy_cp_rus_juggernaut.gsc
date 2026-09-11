/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_cp_rus_juggernaut.gsc
***********************************************/

function main() {
  self.additionalassets = "ai\\juggernaut_cp_assets.csv";
  self.subclass = "juggernaut";
  self.defaultcoverselector = "cover_default_cp";
  self.enemyselector = "enemyselector_default";
  self.unittype = "juggernaut";
  self setengagementmindist(128, 0);
  self setengagementmaxdist(256, 1024);
  self.accuracy = 1;
  self.weapon = scripts\cp\cp_weapon::buildweapon("iw8_lm_dblmg_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = getcompleteweaponname("frag");
  self.grenadeammo = 0;
}

function setup_model(var_0) {
  character\character_opforce_juggernaut_cp::main_mp();
}

function precache() {
  var_0 = "actor_enemy_cp_rus_juggernaut";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[var_0])) {
    level.agent_definition[var_0] = [];
    level.agent_definition[var_0]["species"] = "human";
    level.agent_definition[var_0]["traversal_unit_type"] = "juggernaut";
    level.agent_definition[var_0]["health"] = 3000;
    level.agent_definition[var_0]["xp"] = 50;
    level.agent_definition[var_0]["reward"] = 300;
    level.agent_definition[var_0]["asm"] = "soldier_cp";
    level.agent_definition[var_0]["radius"] = 15;
    level.agent_definition[var_0]["height"] = 70;
    level.agent_definition[var_0]["behaviorTree"] = "juggernaut_agent";
    level.agent_definition[var_0]["team"] = "axis";
    level.agent_definition[var_0]["setup_func"] = &main;
    level.agent_definition[var_0]["setup_model_func"] = &setup_model;
    character\character_opforce_juggernaut_cp::precache_mp(var_0);
  }

  scripts\aitypes\bt_util::init();
  behaviortree\juggernaut_agent::registerbehaviortree();
  aiasm\suicidebomber_cp_mp::asm_register();
  scripts\cp_mp\agents\agent_init::agent_init();

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  if(!isDefined(level.species_funcs["human"])) {
    level.species_funcs["human"] = [];
  }

  scripts\aitypes\assets::juggernaut();
}