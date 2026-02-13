/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2123.gsc
*************************************************/

_id_16D5() {
  if(weaponclass(level.player getcurrentweapon()) == "rifle") {
    _id_0847::_id_DF08("weap_putaway_large_plr", level.player);
    wait 0.5;
    _id_0847::_id_DF08("weap_ammo_pickup", level.player);
    wait 1;
    _id_0847::_id_DF08("weap_raise_large_plr", level.player);
  }

  if(weaponclass(level.player getcurrentweapon()) == "smg") {
    _id_0847::_id_DF08("weap_putaway_medium_plr", level.player);
    wait 0.5;
    _id_0847::_id_DF08("weap_ammo_pickup", level.player);
    wait 1;
    _id_0847::_id_DF08("weap_raise_medium_plr", level.player);
  }

  if(weaponclass(level.player getcurrentweapon()) == "spread") {
    _id_0847::_id_DF08("weap_putaway_medium_plr", level.player);
    wait 0.5;
    _id_0847::_id_DF08("weap_ammo_pickup", level.player);
    wait 1;
    _id_0847::_id_DF08("weap_raise_medium_plr", level.player);
  }

  if(weaponclass(level.player getcurrentweapon()) == "pistol") {
    _id_0847::_id_DF08("weap_putaway_small_plr", level.player);
    wait 0.5;
    _id_0847::_id_DF08("weap_ammo_pickup", level.player);
    wait 1;
    _id_0847::_id_DF08("weap_raise_small_plr", level.player);
  }

  if(weaponclass(level.player getcurrentweapon()) == "sniper") {
    _id_0847::_id_DF08("weap_putaway_large_plr", level.player);
    wait 0.5;
    _id_0847::_id_DF08("weap_ammo_pickup", level.player);
    wait 1;
    _id_0847::_id_DF08("weap_raise_large_plr", level.player);
  }

  if(weaponclass(level.player getcurrentweapon()) == "rocketlauncher") {
    _id_0847::_id_DF08("weap_putaway_launcher_plr", level.player);
    wait 0.5;
    _id_0847::_id_DF08("weap_ammo_pickup", level.player);
    wait 1;
    _id_0847::_id_DF08("weap_raise_launcher_plr", level.player);
  }

  if(weaponclass(level.player getcurrentweapon()) == "mg") {
    _id_0847::_id_DF08("weap_putaway_launcher_plr", level.player);
    wait 0.5;
    _id_0847::_id_DF08("weap_ammo_pickup", level.player);
    wait 1;
    _id_0847::_id_DF08("weap_raise_launcher_plr", level.player);
  }
}