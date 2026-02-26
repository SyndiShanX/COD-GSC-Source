/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\killstreaks.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreak_detect;
#using scripts\killstreaks\killstreaks_shared;
#namespace killstreaks;

function private autoexec __init__system__() {
  system::register(#"killstreaks", &preinit, undefined, undefined, #"renderoverridebundle");
}

function private preinit() {
  init_shared();
  killstreak_detect::init_shared();
  function_f1707039();
  function_6c73be30();
}

function private function_6c73be30() {
  level.killstreakweapons[getweapon(#"gun_ultimate_turret")] = "ultimate_turret";
  level.killstreakweapons[getweapon(#"ultimate_turret")] = "ultimate_turret";
  level.killstreakweapons[getweapon(#"hash_38ffd09564931482")] = "recon_car";
  level.killstreakweapons[getweapon(#"hash_1734871fef9c0549")] = "chopper_gunner";
  level.killstreakweapons[getweapon(#"chopper_gunner")] = "ultimate_turret";
  level.killstreakweapons[getweapon(#"killstreak_remote")] = "chopper_gunner";
  level.killstreakweapons[getweapon(#"hero_pineapplegun")] = "hero_pineapplegun";
  level.killstreakweapons[getweapon(#"inventory_ultimate_turret")] = "inventory_ultimate_turret";
  level.killstreakweapons[getweapon(#"inventory_sig_lmg")] = "inventory_sig_lmg";
  level.killstreakweapons[getweapon(#"sig_lmg")] = "sig_lmg";
  level.killstreakweapons[getweapon(#"inventory_chopper_gunner")] = "inventory_chopper_gunner";
  level.killstreakweapons[getweapon(#"inventory_hero_annihilator")] = "inventory_hero_annihilator";
  level.killstreakweapons[getweapon(#"hero_annihilator")] = "hero_annihilator";
  level.killstreakweapons[getweapon(#"ultimate_turret_deploy")] = "ultimate_turret";
  level.killstreakweapons[getweapon(#"hash_33be4792feeabece")] = "remote_missile";
  level.killstreakweapons[getweapon(#"remote_missile_bomblet")] = "remote_missile";
  level.killstreakweapons[getweapon(#"hash_3f33adcbed7f6c86")] = "planemortar";
  level.killstreakweapons[getweapon(#"inventory_hero_flamethrower")] = "inventory_hero_flamethrower";
  level.killstreakweapons[getweapon(#"hero_flamethrower")] = "hero_flamethrower";
  level.killstreakweapons[getweapon(#"remote_missile_missile")] = "remote_missile";
  level.killstreakweapons[getweapon(#"inventory_recon_car")] = "inventory_recon_car";
  level.killstreakweapons[getweapon(#"inventory_hero_pineapplegun")] = "inventory_hero_pineapplegun";
  level.killstreakweapons[getweapon(#"hash_561b772c6e726ebd")] = "inventory_planemortar";
  level.killstreakweapons[getweapon(#"hash_72c14c150086340c")] = "napalm_strike_zm";
  level.killstreakweapons[getweapon(#"hash_78a35da92bd92644")] = "napalm_strike_zm";
  level.killstreakweapons[getweapon(#"sig_bow_flame")] = "sig_bow_flame";
  level.killstreakweapons[getweapon(#"hash_183ddeea72e71f27")] = "napalm_strike_zm";
  level.killstreakweapons[getweapon(#"inventory_sig_bow_flame")] = "inventory_sig_bow_flame";
  level.killstreakweapons[getweapon(#"hash_3243350071038ce0")] = "inventory_napalm_strike_zm";
  level.killstreakweapons[getweapon(#"recon_car_zm")] = "recon_car";
  level.killstreakweapons[getweapon(#"remote_missile_zm")] = "remote_missile";
  level.killstreakweapons[getweapon(#"inventory_remote_missile_zm")] = "inventory_remote_missile";
}

function private function_f1707039() {
  level.var_4b42d599 = [];

  for(i = 0; i < 4; i++) {
    level.var_4b42d599[i] = "killstreaks.killstreak" + i + ".inUse";
    clientfield::register_clientuimodel(level.var_4b42d599[i], #"killstreak_rewards", [#"killstreak" + (isDefined(i) ? "" + i : ""), #"inuse"], 1, 1, "int", undefined, 0, 0);
  }

  level.var_46b33f90[i] = [];
  level.var_173b8ed7 = max(8, 4);

  for(i = 0; i < level.var_173b8ed7; i++) {
    level.var_46b33f90[i] = "killstreaks.killstreak" + i + ".spaceFull";
    clientfield::register_clientuimodel(level.var_46b33f90[i], #"killstreak_rewards", [#"killstreak" + (isDefined(i) ? "" + i : ""), #"spacefull"], 1, 1, "int", undefined, 0, 0);
  }
}

function function_d79281c4(off) {
  if(off) {
    setDvar(#"hash_c4d58c161f407a2", 0);
    return;
  }

  setDvar(#"hash_c4d58c161f407a2", 1);
}