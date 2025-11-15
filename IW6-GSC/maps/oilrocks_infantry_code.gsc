/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_infantry_code.gsc
*******************************************/

infantry_teleport_start(var_0) {
  var_1 = common_scripts\utility::getstructarray(var_0, "targetname")[0];
  level.player maps\_utility::teleport_player(var_1);
  spawn_start_guys(var_1);
  level.player takeallweapons();
  maps\_loadout::give_loadout();
}

spawn_start_guys(var_0) {
  var_1 = convert_old_spawners_to_structs(var_0);
  var_2 = maps\oilrocks_code::spawn_infantry_friends(0);
  maps\oilrocks_code::assign_friendly_heros();

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_friendname) && var_4.script_friendname == "Logan")
      var_4 delete();
  }

  var_2 = common_scripts\utility::array_removeundefined(var_2);

  foreach(var_8, var_4 in var_2) {
    var_7 = var_1[var_8];

    if(isDefined(var_7.angles)) {
      var_4 forceteleport(var_7.origin, var_7.angles);
      continue;
    }

    var_4 forceteleport(var_7.origin, (0, 0, 0));
  }

  level.infantry_guys = var_2;
}

convert_old_spawners_to_structs(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");

  if(var_1.size == 0)
    return common_scripts\utility::getstructarray(var_0.target, "targetname");

  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = spawnStruct();
    var_5.origin = var_4.origin;

    if(isDefined(var_4.angles))
      var_5.angles = var_4.angles;
    else
      var_5.angles = (0, 0, 0);

    var_2[var_2.size] = var_5;
  }

  return var_2;
}

init_color_helper_triggers() {
  if(isDefined(level.init_color_helper_triggers)) {
    return;
  }
  level.init_color_helper_triggers = 1;
  common_scripts\utility::array_thread(getEntArray("color_helper", "targetname"), ::color_helper_trigger);
}

color_helper_trigger() {
  wait 1.05;
  var_0 = getent(self.target, "targetname");
  var_1 = getent(var_0.target, "targetname");

  if(!isDefined(var_1)) {
    if(!maps\_utility::is_default_start())
      iprintln("can't find color_trigger for trigger with target, " + var_0.target);

    return;
  }

  var_1 endon("trigger");

  for(;;) {
    self waittill("trigger");
    var_0 maps\_utility::waittill_volume_dead_or_dying();

    if(level.player istouching(self))
      var_1 notify("trigger");
  }
}

remove_ignoreme_on_heros() {
  level.merrick maps\_utility::set_ignoreme(0);
  level.hesh maps\_utility::set_ignoreme(0);
  level.keegan maps\_utility::set_ignoreme(0);
}