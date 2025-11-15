/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\enemy_dog_sp.gsc
**************************************/

#include character\character_sp_german_sheperd_dog;

main() {
  self.accuracy = 1;
  self.animstatedef = "";
  self.animtree = "dog.atr";
  self.csvinclude = "";
  self.demolockonhighlightdistance = 100;
  self.demolockonviewheightoffset1 = 8;
  self.demolockonviewheightoffset2 = 8;
  self.demolockonviewpitchmax1 = 60;
  self.demolockonviewpitchmax2 = 60;
  self.demolockonviewpitchmin1 = 0;
  self.demolockonviewpitchmin2 = 0;
  self.footstepfxtable = "";
  self.footstepprepend = "fly_step_dog";
  self.footstepscriptcallback = 0;
  self.grenadeammo = 0;
  self.grenadeweapon = "dog_bite_sp";
  self.health = 200;
  self.precachescript = "";
  self.secondaryweapon = "";
  self.sidearm = "";
  self.subclass = "regular";
  self.team = "axis";
  self.type = "dog";
  self.weapon = "dog_bite_sp";
  self setengagementmindist(0.0, 0.0);
  self setengagementmaxdist(100.0, 300.0);
  character\character_sp_german_sheperd_dog::main();
  self setcharacterindex(0);
}

spawner() {
  self setspawnerteam("axis");
}

precache(ai_index) {
  character\character_sp_german_sheperd_dog::precache();
  precacheitem("dog_bite_sp");
  precacheitem("dog_bite_sp");
}