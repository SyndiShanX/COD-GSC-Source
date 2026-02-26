/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_cod5_factory\.csc
*************************************************/

#include clientscripts\_utility;
#include clientscripts\_music;
#include clientscripts\_zombiemode_weapons;

zombie_monitor(clientNum) {
  self endon("disconnect");
  self endon("zombie_off");
  while(1) {
    if(isDefined(self.zombifyFX)) {
      playFX(clientNum, level._effect["zombie_grain"], self.origin);
    }
    realwait(0.1);
  }
}
zombifyHandler(clientNum, newState, oldState) {
  player = getlocalplayers()[clientNum];
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
factory_ZPO_listener() {
  while(1) {
    level waittill("ZPO");
    level notify("revive_on");
    level notify("fast_reload_on");
    level notify("doubletap_on");
    level notify("jugger_on");
    level notify("pl1");
  }
}
main() {
  include_weapons();
  level._uses_crossbow = true;
  clientscripts\_lights::register_light_type("light_electric", ::triggered_lights_think);
  clientscripts\_zombiemode::main();
  clientscripts\_utility::registerSystem("zombify", ::zombifyHandler);
  clientscripts\zombie_cod5_factory_teleporter::main();
  clientscripts\zombie_cod5_factory_fx::main();
  thread clientscripts\zombie_cod5_factory_amb::main();
  thread waitforclient(0);
  register_zombie_types();
  level thread factory_ZPO_listener();
  println("*** Client : zombie running...or is it chasing? Muhahahaha");
}
register_zombie_types() {
  character\clientscripts\c_ger_honorguard_zt::register_gibs();
}
include_weapons() {
  include_weapon("m1911_zm", false);
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
  include_weapon("crossbow_explosive_zm");
  include_weapon("knife_ballistic_zm");
  include_weapon("knife_ballistic_bowie_zm", false);
  include_weapon("m1911_upgraded_zm", false);
  include_weapon("python_upgraded_zm", false);
  include_weapon("cz75_upgraded_zm", false);
  include_weapon("g11_lps_upgraded_zm", false);
  include_weapon("famas_upgraded_zm", false);
  include_weapon("spectre_upgraded_zm", false);
  include_weapon("cz75dw_upgraded_zm", false);
  include_weapon("spas_upgraded_zm", false);
  include_weapon("hs10_upgraded_zm", false);
  include_weapon("aug_acog_mk_upgraded_zm", false);
  include_weapon("galil_upgraded_zm", false);
  include_weapon("commando_upgraded_zm", false);
  include_weapon("fnfal_upgraded_zm", false);
  include_weapon("dragunov_upgraded_zm", false);
  include_weapon("l96a1_upgraded_zm", false);
  include_weapon("rpk_upgraded_zm", false);
  include_weapon("hk21_upgraded_zm", false);
  include_weapon("m72_law_upgraded_zm", false);
  include_weapon("china_lake_upgraded_zm", false);
  include_weapon("crossbow_explosive_upgraded_zm", false);
  include_weapon("knife_ballistic_upgraded_zm", false);
  include_weapon("knife_ballistic_bowie_upgraded_zm", false);
  include_weapon("zombie_kar98k", false);
  include_weapon("zombie_kar98k_upgraded", false);
  include_weapon("zombie_m1carbine", false);
  include_weapon("zombie_m1carbine_upgraded", false);
  include_weapon("zombie_gewehr43", false);
  include_weapon("zombie_gewehr43_upgraded", false);
  include_weapon("zombie_stg44", false);
  include_weapon("zombie_stg44_upgraded", false);
  include_weapon("zombie_thompson", false);
  include_weapon("zombie_thompson_upgraded", false);
  include_weapon("mp40_zm", false);
  include_weapon("mp40_upgraded_zm", false);
  include_weapon("zombie_type100_smg", false);
  include_weapon("zombie_type100_smg_upgraded", false);
  include_weapon("stielhandgranate", false);
  include_weapon("zombie_doublebarrel", false);
  include_weapon("zombie_doublebarrel_upgraded", false);
  include_weapon("zombie_shotgun", false);
  include_weapon("zombie_shotgun_upgraded", false);
  include_weapon("zombie_fg42", false);
  include_weapon("zombie_fg42_upgraded", false);
  include_weapon("ray_gun_zm", true);
  include_weapon("ray_gun_upgraded_zm", false);
  include_weapon("tesla_gun_zm", true);
  include_weapon("tesla_gun_upgraded_zm", false);
  include_weapon("zombie_cymbal_monkey", true);
  include_weapon("mine_bouncing_betty", false);
}
triggered_lights_think(light_struct) {
  level waittill("pl1");
  if(isDefined(self.script_float)) {
    clientscripts\_lights::set_light_intensity(light_struct, self.script_float);
  } else {
    clientscripts\_lights::set_light_intensity(light_struct, 1.5);
  }
}