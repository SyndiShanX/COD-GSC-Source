/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moonjackal\moonjackal_anim.gsc
**********************************************************/

main() {
  player();
  _id_13267();
  jackals();
  _id_91DC();
  script_model();
}

player() {}

_id_91DC() {}

script_model() {}

#using_animtree("vehicles");

_id_13267() {
  level._id_EC85["sled_jackal"]["moon_launch"] = % moon_arena_launch_space_plr_jackal;
  level._id_EC85["sled_jackal"]["moon_launch_boost"] = % moon_arena_launch_space_plr_jackal_boost;
}

#using_animtree("jackal");

jackals() {
  level._id_EC85["salter_jackal"]["moon_launch"] = % moon_arena_launch_space_salter_jackal;
}