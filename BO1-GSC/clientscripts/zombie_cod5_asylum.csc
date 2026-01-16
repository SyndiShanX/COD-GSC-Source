/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_cod5_asylum.csc
************************************************/

#include clientscripts\_utility;
#include clientscripts\_music;
#include clientscripts\_zombiemode_weapons;

zombie_monitor(clientNum) {
  self endon("disconnect");
  self endon("zombie_off");
  while(1) {
    if(isDefined(self.zombifyFX)) {
      playfx(clientNum, level._effect["zombie_grain"], self.origin);
    }
    realwait(0.1);
  }
}

zombifyHandler(clientNum, newState, oldState) {
  player = getLocalPlayers()[clientNum];
  if(newState == "1") {
    if(!isDefined(player.zombifyFX)) {
      player.zombifyFX = 1;
      player thread zombie_monitor(clientNum);
      println("Zombie effect on");
    }
  } else if(newState == "0") {
    if(isDefined(player.zombifyFX)) {
      player.zombifyFX = undefined;
      self notify("zombie_off");
      println("Zombie effect off");
    }
  }
}

main() {
  include_weapons();
  level._uses_crossbow = true;
  clientscripts\_zombiemode::main();
  clientscripts\_utility::registerSystem("zombify", ::zombifyHandler);
  clientscripts\zombie_cod5_asylum_fx::main();
  thread clientscripts\zombie_cod5_asylum_amb::main();
  thread waitforclient(0);
  level thread swinging_lamp_init();
  register_zombie_types();
  println("*** Client : zombie running...or is it chasing? Muhahahaha");
}

register_zombie_types() {
  character\clientscripts\c_ger_honorguard_zt::register_gibs();
}

include_weapons() {
  include_weapon("python_zm");
  include_weapon("cz75_zm");
  include_weapon("g11_lps_zm");
  include_weapon("famas_zm");
  include_weapon("spectre_zm");
  include_weapon("cz75dw_zm");
  include_weapon("spas_zm");
  include_weapon("hs10_zm");
  include_weapon("aug_acog_zm");
  include_weapon("galil_zm");
  include_weapon("commando_zm");
  include_weapon("fnfal_zm");
  include_weapon("dragunov_zm");
  include_weapon("l96a1_zm");
  include_weapon("rpk_zm");
  include_weapon("hk21_zm");
  include_weapon("m72_law_zm");
  include_weapon("china_lake_zm");
  include_weapon("zombie_cymbal_monkey");
  include_weapon("ray_gun_zm");
  include_weapon("crossbow_explosive_zm");
  include_weapon("knife_ballistic_zm");
  include_weapon("zombie_kar98k", false);
  include_weapon("stielhandgranate", false);
  include_weapon("zombie_gewehr43", false);
  include_weapon("zombie_m1garand", false);
  include_weapon("zombie_thompson", false);
  include_weapon("zombie_shotgun", false);
  include_weapon("mp40_zm", false);
  include_weapon("zombie_bar", false);
  include_weapon("zombie_bar_bipod", false);
  include_weapon("zombie_stg44", false);
  include_weapon("zombie_doublebarrel", false);
  include_weapon("zombie_doublebarrel_sawed", false);
  include_weapon("zombie_cymbal_monkey");
  include_weapon("freezegun_zm");
  include_weapon("m1911_upgraded_zm", false);
  include_weapon("mine_bouncing_betty", false);
}

swinging_lamp_init(clientNum) {
  if(!isDefined(clientNum)) {
    clientNum = 0;
  }
  lantern = GetDynEnt("morgue_lamp");
}