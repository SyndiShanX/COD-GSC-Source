/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_hub_zombies_01_fx.gsc
********************************************/

main() {
  level._effect["zmb_hub_train_headlight_sml"] = loadfx("vfx/lights/mp_zombie_training/zmb_hub_train_headlight_sml");
  level._effect["zmb_hub_train_headlight_main"] = loadfx("vfx/lights/mp_zombie_training/zmb_hub_train_headlight_main");
  level._effect["train_headlight_kubelwagen_bright_03_lt_spot"] = loadfx("vfx/lights/train_headlight_kubelwagen_bright_03_lt_spot");
  level._effect["zmb_rat_flock_runaway_runner"] = loadfx("vfx/map/mp_zombie_nest/zmb_rat_flock_runaway_runner");
  level._effect["zmb_train_steam_below"] = loadfx("vfx/map/mp_zombie_hub/zmb_train_steam_below");
  level._effect["zmb_train_steam_background"] = loadfx("vfx/map/mp_zombie_hub/zmb_train_steam_background");
  level._effect["zmb_train_steam_foreground"] = loadfx("vfx/map/mp_zombie_hub/zmb_train_steam_foreground");
  level._effect["zmb_train_steam_main"] = loadfx("vfx/map/mp_zombie_hub/zmb_train_steam_main");
  level._effect["test_effect"] = loadfx("vfx/test/test_fx");
  level._effect["zmb_hub_canon_env_fx"] = LoadFX("vfx/map/mp_zombie_hub/zmb_war_machine_canon_env");

  if(getDvar("3508") != "1")
    maps\createfx\mp_hub_zombies_01_fx::main();
}