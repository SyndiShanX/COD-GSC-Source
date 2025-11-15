/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_temple_ffotd.csc
*************************************************/

#using scripts\codescripts\struct;
#namespace zm_temple_ffotd;

function main_start() {
  a_wallbuys = struct::get_array("weapon_upgrade", "targetname");
  foreach(s_wallbuy in a_wallbuys) {
    if(s_wallbuy.zombie_weapon_upgrade == "smg_standard") {
      s_wallbuy.origin = s_wallbuy.origin + vectorscale((0, 1, 0), 5);
    }
  }
  level._effect["powerup_on_red"] = "zombie/fx_powerup_on_red_zmb";
}

function main_end() {}