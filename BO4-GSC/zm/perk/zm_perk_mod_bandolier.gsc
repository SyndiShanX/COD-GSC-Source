/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_bandolier.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_weapons;

#namespace zm_perk_mod_bandolier;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_bandolier", &__init__, undefined, undefined);
}

__init__() {
  function_27473e44();
}

function_27473e44() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_extraammo", "mod_bandolier", #"perk_bandolier", #"specialty_extraammo", 3500);
  zm_perks::register_perk_threads(#"specialty_mod_extraammo", &give_mod_perk, &function_3781ff37);
}

give_mod_perk() {
  self thread function_9335851();
}

function_3781ff37(b_pause, str_perk, str_result, n_slot) {
  self notify(#"hash_73b1e35c66a4e898");
}

function_9335851() {
  self endon(#"disconnect", #"hash_73b1e35c66a4e898");

  while(true) {
    wait 1;
    a_weapons = self getweaponslistprimaries();

    foreach(weapon in a_weapons) {
      w_current = self getcurrentweapon();
      var_911fad7c = zm_weapons::function_af29d744(w_current);
      w_root = zm_weapons::function_386dacbc(weapon);

      if(var_911fad7c == w_root) {
        continue;
      }

      if(weaponhasattachment(weapon, "uber") && w_root == getweapon(#"smg_capacity_t8")) {
        continue;
      }

      n_clip = self getweaponammoclip(weapon);
      n_clip_size = weapon.clipsize;
      n_stock_size = self getweaponammostock(weapon);

      if(isDefined(n_clip) && isDefined(n_clip_size) && n_clip < n_clip_size) {
        var_8e477029 = int(ceil(n_clip_size * 0.05));

        if(weapon.iscliponly) {
          continue;
        }

        if(n_stock_size >= var_8e477029) {
          self setweaponammoclip(weapon, n_clip + var_8e477029);
          self setweaponammostock(weapon, n_stock_size - var_8e477029);

          if(n_clip + var_8e477029 >= n_clip_size) {
            self playsoundtoplayer(#"hash_1306cd3cf0ce7b64", self);
          }

          continue;
        }

        if(n_stock_size > 0) {
          self setweaponammoclip(weapon, n_clip + 1);
          self setweaponammostock(weapon, n_stock_size - 1);
          self playsoundtoplayer(#"hash_1306cd3cf0ce7b64", self);
        }
      }
    }
  }
}