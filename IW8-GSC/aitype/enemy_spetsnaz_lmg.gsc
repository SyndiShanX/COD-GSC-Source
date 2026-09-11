/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_spetsnaz_lmg.gsc
***********************************************/

function main() {
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = getcompleteweaponname("frag");
  self.grenadeammo = 2;
  self.secondaryweapon = scripts\code\ai::create_weapon_in_script("");
  self.sidearm = scripts\code\ai::create_weapon_in_script("iw8_pi_golf21", "sidearm");
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(512, 400);
    self setengagementmaxdist(1024, 1250);
  }

  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "lmg";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_lm_pkilo"]);
  character\character_spetsnaz_lmg::main();
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var0) {
  character\character_spetsnaz_lmg::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_lm_pkilo");
  precacheitem("iw8_pi_golf21");
  precacheitem("frag");
}