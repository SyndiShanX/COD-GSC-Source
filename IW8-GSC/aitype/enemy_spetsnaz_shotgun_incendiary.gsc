/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_spetsnaz_shotgun_incendiary.gsc
********************************************************/

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
  self.secondaryweapon = isundefinedweapon();
  self.sidearm = getcompleteweaponname("iw8_pi_golf21");
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(0, 0);
    self setengagementmaxdist(280, 400);
  }

  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";
  self.weapon = getcompleteweaponname("iw8_sh_dpapa12_incendiary", ["rec_dpapa12", "front_dpapa12", "ammo_dpapa12"]);
  character\character_spetsnaz_cqc::main();
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var0) {
  character\character_spetsnaz_cqc::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_sh_dpapa12_incendiary+rec_dpapa12+front_dpapa12+ammo_dpapa12");
  precacheitem("iw8_pi_golf21");
  precacheitem("frag");
}