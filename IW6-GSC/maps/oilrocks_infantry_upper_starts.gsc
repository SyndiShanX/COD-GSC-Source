/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_infantry_upper_starts.gsc
***************************************************/

main() {
  maps\_utility::add_start("infantry_upper", maps\oilrocks_infantry_upper::start, undefined, maps\oilrocks_infantry_upper::main, undefined, maps\oilrocks_infantry_upper::catchup_function);
  maps\_utility::add_start("infantry_panic_room", maps\oilrocks_infantry_panic_room::start, undefined, maps\oilrocks_infantry_panic_room::main, undefined, undefined);
  maps\_utility::add_start("infantry_panic_room_testChopper", maps\oilrocks_infantry_panic_room::start_chopper_test, undefined, maps\oilrocks_infantry_panic_room::main_chopper_test, undefined, undefined);
  maps\_utility::add_start("infantry_panic_room_final", maps\oilrocks_infantry_panic_room::start2, undefined, maps\oilrocks_infantry_panic_room::main2, undefined, undefined);
}