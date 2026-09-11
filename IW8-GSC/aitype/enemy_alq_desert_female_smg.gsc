/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_alq_desert_female_smg.gsc
**************************************************/

function main() {
  self.additionalassets = "";
  self.team = "axis";
  self.type = "human";
  self.unittype = "soldier";
  self.subclass = "regular";
  self.accuracy = 0.2;
  self.health = 150;
  self.grenadeweapon = isundefinedweapon();
  self.grenadeammo = 0;
  self.secondaryweapon = scripts\code\ai::create_weapon_in_script("");
  self.sidearm = scripts\code\ai::create_weapon_in_script("iw8_pi_mike1911", "sidearm");
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(128, 0);
    self setengagementmaxdist(512, 768);
  }

  self.usescriptedweapon = 1;
  self.scriptedweaponclassprimary = "smg";
  self.weapon = scripts\code\ai::create_weapon_in_script(["iw8_sm_uzulu", "iw8_ar_akilo47"]);
  var_0 = undefined;
  var_1 = ["alq_syrkistan_female_scarf_purple"];

  switch (scripts\code\character::get_random_character(1, var_0, var_1)) {
    case 0:
      character\alq_syrkistan_female_scarf_purple::main();
      break;
  }
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var_0) {
  character\alq_syrkistan_female_scarf_purple::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_sm_uzulu");
  precacheitem("iw8_ar_akilo47");
  precacheitem("iw8_pi_mike1911");
}