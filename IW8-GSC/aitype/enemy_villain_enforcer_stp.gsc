/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitype\enemy_villain_enforcer_stp.gsc
*************************************************/

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
  self.secondaryweapon = isundefinedweapon();
  self.sidearm = isundefinedweapon();
  self.behaviortreeasset = "enemy_combatant";
  self.asmasset = "soldier";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default";

  if(isai(self)) {
    self setengagementmindist(256, 0);
    self setengagementmaxdist(768, 1024);
  }

  self.usescriptedweapon = 0;
  self.scriptedweaponclassprimary = "none";
  self.weapon = getcompleteweaponname("iw8_sm_mpapa7", ["mmags_mpapa7", "reflex_west01", "stockno_mpapa7"]);
  character\character_villain_enforcer_st_petersburg::main();
}

function spawner() {
  self setspawnerteam("axis");
}

function precache(var0) {
  character\character_villain_enforcer_st_petersburg::precache();
  scripts\aitypes\bt_util::init();
  scripts\aitypes\assets::soldier();
  behaviortree\enemy_combatant::registerbehaviortree();
  aiasm\soldier_sp::asm_register();
  precacheitem("iw8_sm_mpapa7+xmags_mpapa7+reflex_west01+stockno_mpapa7");
}