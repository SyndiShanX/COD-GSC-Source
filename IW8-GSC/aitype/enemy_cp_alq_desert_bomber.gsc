/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_cp_alq_desert_bomber.gsc
*************************************************/

function main() {
  self.additionalassets = "suicide_bomber_agent.csv";
  self.subclass = "regular";
  self.defaultcoverselector = "cover_default_cp";
  self.enemyselector = "enemyselector_default_cp";
  self.unittype = "suicidebomber";
  self setengagementmindist(256, 0);
  self setengagementmaxdist(768, 1024);
  self.accuracy = 0.2;
  self.weapon = isundefinedweapon();
  self.sidearm = scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  self.grenadeweapon = getcompleteweaponname("suicide_vest");
  self.grenadeammo = 2;
}

function setup_model(var0) {
  character\character_spetsnaz_gasmask_ar_cp::main_mp();
}

function precache() {
  var0 = "actor_enemy_cp_alq_desert_bomber";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[var0])) {
    level.agent_definition[var0] = [];
    level.agent_definition[var0]["species"] = "human";
    level.agent_definition[var0]["traversal_unit_type"] = "suicidebomber";
    level.agent_definition[var0]["health"] = 180;
    level.agent_definition[var0]["xp"] = 50;
    level.agent_definition[var0]["reward"] = 100;
    level.agent_definition[var0]["asm"] = "suicidebomber_cp";
    level.agent_definition[var0]["radius"] = 15;
    level.agent_definition[var0]["height"] = 70;
    level.agent_definition[var0]["behaviorTree"] = "suicidebomber_agent";
    level.agent_definition[var0]["team"] = "axis";
    level.agent_definition[var0]["setup_func"] = &main;
    level.agent_definition[var0]["setup_model_func"] = &setup_model;
    character\character_spetsnaz_gasmask_ar_cp::precache_mp(var0);
  }

  scripts\aitypes\bt_util::init();
  behaviortree\suicidebomber_agent::registerbehaviortree();
  character\character_cp_al_qatala_desert_ar_tmtyl::asm_register();
  scripts\cp_mp\agents\agent_init::agent_init();

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  if(!isDefined(level.species_funcs["human"])) {
    level.species_funcs["human"] = [];
  }

  scripts\aitypes\assets::suicidebomber();
}