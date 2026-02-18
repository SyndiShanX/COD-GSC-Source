/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\ammo_perks.gsc
***********************************************/

#using scripts\core_common\system_shared;
#namespace ammo;

function private autoexec __init__system__() {
  system::register("cp_ammo_perks", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_a253061b = &function_d1df9410;
}

function function_d1df9410(waitresult) {
  player = waitresult.player;
  assert(isPlayer(player));
  player playSound(#"wpn_ammo_pickup");
  player playlocalsound(#"wpn_ammo_pickup");
  primary_weapons = player getweaponslistprimaries();

  for(i = 0; i < primary_weapons.size; i++) {
    weapon = primary_weapons[i];

    if(is_true(weapon.var_cc0ed831)) {
      continue;
    }

    stock = player getweaponammostock(weapon);
    clip = weapon.clipsize;
    clip *= getdvarfloat(#"scavenger_clip_multiplier", 1);
    clip = int(clip);
    maxammo = player function_5d951520(weapon);

    if(stock < maxammo - clip * 3) {
      ammo = stock + clip * 3;
      player setweaponammostock(weapon, ammo);
      continue;
    }

    player setweaponammostock(weapon, maxammo);
  }
}