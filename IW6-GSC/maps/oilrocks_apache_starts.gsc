/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_starts.gsc
*******************************************/

main() {
  maps\_utility::default_start(maps\oilrocks_apache_tutorial::start);
  maps\_utility::add_start("AITEST", maps\oilrocks_proximity_spawned_ai::start, undefined, maps\oilrocks_proximity_spawned_ai::start_test, undefined, undefined);
  maps\_utility::add_start("apache_tutorial_fly", maps\oilrocks_apache_tutorial::start, undefined, maps\oilrocks_apache_tutorial::main, undefined, maps\oilrocks_apache_tutorial::catchup_function);
  maps\_utility::add_start("apache_factory", maps\oilrocks_apache_factory::start, undefined, maps\oilrocks_apache_factory::main, undefined, maps\oilrocks_apache_factory::catchup_function);
  maps\_utility::add_start("apache_clear_antiair", maps\oilrocks_apache_antiair::start, undefined, maps\oilrocks_apache_antiair::main, undefined, maps\oilrocks_apache_antiair::catchup_function);
  maps\_utility::add_start("apache_main_island", maps\oilrocks_apache_main_island::start, undefined, maps\oilrocks_apache_main_island::main, undefined, maps\oilrocks_apache_main_island::catchup_function);
  maps\_utility::add_start("apache_chopper", maps\oilrocks_apache_chopper::start, undefined, maps\oilrocks_apache_chopper::main, undefined, undefined);
  maps\_utility::add_start("apache_finale", maps\oilrocks_apache_finale::start, undefined, maps\oilrocks_apache_finale::main, undefined, undefined);
}