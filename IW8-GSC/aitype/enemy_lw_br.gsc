/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_lw_br.gsc
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
  self.weapon = scripts\mp\class::buildweapon("iw8_ar_akilo47", ["none", "none", "none", "none", "none", "none"], "none", "none");
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = getcompleteweaponname("frag_grenade_mp");
  self.grenadeammo = 2;
}

function setup_model(var0) {
  character\character_spetsnaz_gasmask_nohelmet_ar_cp::main_mp();
}

function precache() {
  var0 = "actor_enemy_lw_br";

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
    level.agent_definition[var0]["asm"] = "soldier_lw_br";
    level.agent_definition[var0]["radius"] = 15;
    level.agent_definition[var0]["height"] = 70;
    level.agent_definition[var0]["behaviorTree"] = "soldier_lw_br_agent";
    level.agent_definition[var0]["team"] = "axis";
    level.agent_definition[var0]["setup_func"] = &main;
    level.agent_definition[var0]["setup_model_func"] = &setup_model;
    character\character_spetsnaz_gasmask_nohelmet_ar_cp::precache_mp(var0);
  }

  scripts\aitypes\bt_util::init();
  character\character_cp_usmc_basic_ar_3::registerbehaviortree();
  behaviortree\riotshield_cp::asm_register();
  scripts\cp_mp\agents\agent_init::agent_init();

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  if(!isDefined(level.species_funcs["human"])) {
    level.species_funcs["human"] = [];
  }

  scripts\aitypes\assets::soldier();
}