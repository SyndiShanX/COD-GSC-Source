/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_alq_urban_snow_pistol.gsc
**************************************************/

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
  self.sidearm = scripts\code\ai::create_weapon_in_script("", "sidearm");
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(0, 0);
    self setengagementmaxdist(280, 400);
  }

  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "pistol";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_pi_mike1911"]);
  var0 = undefined;
  var1 = ["character_al_qatala_urban_a6_variant"];

  switch (scripts\code\character::get_random_character(1, var0, var1)) {
    case 0:
      character\character_al_qatala_urban_a6_variant::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var0) {
  character\character_al_qatala_urban_a6_variant::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_pi_mike1911");
  precacheitem("frag");
}