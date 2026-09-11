/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\civilian_cp_tugofwar.gsc
***********************************************/

function main() {
  self.additionalassets = "";
  self.subclass = "regular";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";
  self.unittype = "civilian";
  self setengagementmindist(256, 0);
  self setengagementmaxdist(768, 1024);
  self.accuracy = 0.2;
  self.weapon = isundefinedweapon();
  self.grenadeweapon = isundefinedweapon();
  self.grenadeammo = 0;
}

function setup_model(var0) {
  scripts\cp\cp_matchdata::main_mp();
}

function precache() {
  var0 = "actor_civilian_cp_tugofwar";

  if(!isDefined(level.agent_definition)) {
    level.agent_definition = [];
  }

  if(!isDefined(level.agent_definition[var0])) {
    level.agent_definition[var0] = [];
    level.agent_definition[var0]["species"] = "human";
    level.agent_definition[var0]["traversal_unit_type"] = "civilian";
    level.agent_definition[var0]["health"] = 30;
    level.agent_definition[var0]["xp"] = 50;
    level.agent_definition[var0]["reward"] = 50;
    level.agent_definition[var0]["asm"] = "civilian_cp";
    level.agent_definition[var0]["radius"] = 15;
    level.agent_definition[var0]["height"] = 70;
    level.agent_definition[var0]["behaviorTree"] = "civilian_agent";
    level.agent_definition[var0]["team"] = "allies";
    level.agent_definition[var0]["setup_func"] = &main;
    level.agent_definition[var0]["setup_model_func"] = &setup_model;
    scripts\cp\cp_matchdata::precache_mp(var0);
  }

  scripts\aitypes\bt_util::init();
  behaviortree\civilian_agent::registerbehaviortree();
  aiasm\civilian_cp_mp::asm_register();
  scripts\cp_mp\agents\agent_init::agent_init();

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  if(!isDefined(level.species_funcs["human"])) {
    level.species_funcs["human"] = [];
  }

  scripts\aitypes\assets::civilian();
}