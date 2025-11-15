/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_infantry_upper.gsc
********************************************/

start() {
  maps\oilrocks_infantry_code::infantry_teleport_start("infantry_upper_player_start");
}

main() {
  thread merrick_goes_green();
  maps\oilrocks_infantry_code::init_color_helper_triggers();
  maps\_utility::autosave_by_name();
}

catchup_function() {
  thread merrick_goes_green();
}

merrick_goes_green() {
  var_0 = getent("keegan_goes_green", "targetname");
  var_0 waittill("trigger");
  level.merrick maps\_utility::set_force_color("g");
}