/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_infantry_starts.gsc
*********************************************/

main() {
  maps\_utility::add_start("apache_landing", maps\oilrocks_apache_landing::start, undefined, maps\oilrocks_apache_landing::main, undefined, maps\oilrocks_apache_landing::catchup_function);
  maps\_utility::add_start("infantry", maps\oilrocks_infantry::start, undefined, maps\oilrocks_infantry::main, undefined, maps\oilrocks_infantry::catchup_function);
  maps\_utility::add_start("infantry_b", maps\oilrocks_infantry_b::start, undefined, maps\oilrocks_infantry_b::main, undefined, undefined);
  maps\_utility::add_start("infantry_elevator", maps\oilrocks_infantry_elevator::start, undefined, maps\oilrocks_infantry_elevator::main, undefined, undefined);
}