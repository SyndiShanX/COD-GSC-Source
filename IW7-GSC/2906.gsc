/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2906.gsc
**************************************/

main() {
  _id_91DC();
  _id_58BC();
}

#using_animtree("generic_human");

_id_91DC() {
  level._id_EC85["generic"]["patrol_walk"] = % patrol_bored_patrolwalk;
  level._id_EC85["generic"]["patrol_walk_twitch"] = % patrol_bored_patrolwalk_twitch;
  level._id_EC85["generic"]["patrol_stop"] = % patrol_bored_walk_2_bored;
  level._id_EC85["generic"]["patrol_start"] = % patrol_bored_2_walk;
  level._id_EC85["generic"]["patrol_turn180"] = % patrol_bored_2_walk_180turn;
  level._id_EC85["generic"]["patrol_radio_in_clear"] = % patrolwalk_cold_gunup_transition;
  level._id_EC85["generic"]["patrol_idle"] = % patrol_bored_idle;
  level._id_EC85["generic"]["patrol_idle_1"] = % patrol_bored_idle;
  level._id_EC85["generic"]["patrol_idle_2"] = % patrol_bored_idle_smoke;
  level._id_EC85["generic"]["patrol_idle_3"] = % patrol_bored_idle_cellphone;
  level._id_EC85["generic"]["patrol_idle_4"] = % patrol_bored_twitch_bug;
  level._id_EC85["generic"]["patrol_idle_5"] = % patrol_bored_twitch_checkphone;
  level._id_EC85["generic"]["patrol_idle_6"] = % patrol_bored_twitch_stretch;
  level._id_EC85["generic"]["patrol_idle_smoke"] = % patrol_bored_idle_smoke;
  level._id_EC85["generic"]["patrol_idle_checkphone"] = % patrol_bored_twitch_checkphone;
  level._id_EC85["generic"]["patrol_idle_stretch"] = % patrol_bored_twitch_stretch;
  level._id_EC85["generic"]["patrol_idle_phone"] = % patrol_bored_idle_cellphone;
}

#using_animtree("dog");

_id_58BC() {
  level._id_EC85["generic"]["patrol_dog_stop"] = % iw6_dog_attackidle_runin_8;
  level._id_EC85["generic"]["patrol_dog_start"] = % iw6_dog_attackidle_runout_8;
}