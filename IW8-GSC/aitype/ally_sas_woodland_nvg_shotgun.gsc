/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\ally_sas_woodland_nvg_shotgun.gsc
****************************************************/

function main() {
  self.additionalassets = "";
  self.team = "allies";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = getcompleteweaponname("frag");
  self.grenadeammo = 0;
  self.secondaryweapon = scripts\code\ai::create_weapon_in_script("");
  self.sidearm = scripts\code\ai::create_weapon_in_script("iw8_pi_papa320", "sidearm");
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(0, 0);
    self setengagementmaxdist(280, 400);
  }

  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "shotgun";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_sh_romeo870"]);
  character\character_sas_woodland_nvg::main();
}

function spawner() {
  self setspawnerteam("allies");
}

function precache(var0) {
  character\character_sas_woodland_nvg::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_sh_romeo870");
  precacheitem("iw8_pi_papa320");
  precacheitem("frag");
}