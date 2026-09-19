/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createfx\mp_hub_zombies_01_fx.gsc
**************************************************/

#include common_scripts\utility;
#include common_scripts\_createfx;

main() {
  ent = createOneshotEffect("test_effect");
  ent set_origin_and_angles((0, 0, 64), (270, 0, 0));
  ent.v["fxid"] = "test_effect";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_train_steam_main");
  ent set_origin_and_angles((-23024.6, -3628.05, -29.6192), (282, 232, -90));
  ent.v["fxid"] = "zmb_train_steam_main";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_train_steam_background");
  ent set_origin_and_angles((-22401.2, -3146.1, -241.875), (270, 0, 140));
  ent.v["fxid"] = "zmb_train_steam_background";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_train_steam_background");
  ent set_origin_and_angles((-22982.1, -3935, -195.498), (270, 0, 141));
  ent.v["fxid"] = "zmb_train_steam_background";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_train_steam_foreground");
  ent set_origin_and_angles((-23051.1, -3463.6, -259.052), (270, 0, 128));
  ent.v["fxid"] = "zmb_train_steam_foreground";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_train_steam_background");
  ent set_origin_and_angles((-22866.9, -2623.26, -267.326), (270, 0, 140));
  ent.v["fxid"] = "zmb_train_steam_background";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_train_steam_below");
  ent set_origin_and_angles((-23062.4, -3514.9, -248.01), (276.082, 230.427, -99.4793));
  ent.v["fxid"] = "zmb_train_steam_below";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_hub_train_headlight_main");
  ent set_origin_and_angles((-22970.6, -3538.93, -74.3239), (1, 55.9825, -89));
  ent.v["fxid"] = "zmb_hub_train_headlight_main";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_hub_train_headlight_sml");
  ent set_origin_and_angles((-22971.4, -3454.02, -193.31), (1, 55.9825, -89));
  ent.v["fxid"] = "zmb_hub_train_headlight_sml";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_hub_train_headlight_sml");
  ent set_origin_and_angles((-22890.4, -3509.46, -193.535), (1, 55.9825, -89));
  ent.v["fxid"] = "zmb_hub_train_headlight_sml";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_rat_flock_runaway_runner");
  ent set_origin_and_angles((-23156.1, -3074.94, -275.875), (270, 0, -171));
  ent.v["fxid"] = "zmb_rat_flock_runaway_runner";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_rat_flock_runaway_runner");
  ent set_origin_and_angles((-23341.4, -3328.09, -275.875), (270, 0, -77));
  ent.v["fxid"] = "zmb_rat_flock_runaway_runner";
  ent.v["delay"] = -20.9065;

  ent = createOneshotEffect("zmb_rat_flock_runaway_runner");
  ent set_origin_and_angles((-23054.7, -3772.66, -280.146), (270, 0, -21));
  ent.v["fxid"] = "zmb_rat_flock_runaway_runner";
  ent.v["delay"] = -8.48718;

  ent = createOneshotEffect("zmb_train_steam_below");
  ent set_origin_and_angles((-23328, -2949.07, -271.875), (276.082, 230.427, -99.4793));
  ent.v["fxid"] = "zmb_train_steam_below";
  ent.v["delay"] = -15;
}