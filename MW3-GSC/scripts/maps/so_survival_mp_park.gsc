/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_survival_mp_park.gsc
************************************************/

main() {
  level.wave_table = "sp/so_survival/tier_2.csv";
  level.loadout_table = "sp/so_survival/tier_2.csv";
  _id_061C::_id_3D56("easy", "actor_enemy_so_easy_v2");
  maps\mp\mp_park_precache::main();
  maps\createart\mp_park_art::main();
  maps\mp\mp_park_fx::main();
  maps\createfx\mp_park_fx::main();
  maps\_so_survival::_id_3F65();
  var_0 = getEntArray("misc_turret", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.weaponinfo) && var_2.weaponinfo == "turret_minigun_mp") {
      var_2 delete();
    }
  }

  maps\_load::main();
  ambientplay("ambient_mp_park");
  maps\_utility::set_vision_set("mp_park", 0);
  maps\_so_survival::_id_3F66();
  maps\_compass::setupminimap("compass_map_mp_park");
  _id_0618::_id_6F52();
  maps\_so_survival::_id_3F67();
  thread killtrigger((1750, -302, 122), 40, 15);
  thread killtrigger((1858, -350, 174), 60, 15);
  thread killtrigger((1806, -326, 160), 60, 15);
  thread killtrigger((1738, -358, 122), 40, 15);
  level._effect["heli_snow_override_fx"] = loadfx("treadfx/heli_dust_default");
  var_4 = "treadfx/heli_dust_default";
  maps\_treadfx::_id_28EF("script_vehicle_blackhawk_low_so", "snow", var_4);
  maps\_treadfx::_id_28EF("script_vehicle_littlebird_armed_so", "snow", var_4);
  maps\_treadfx::_id_28EF("script_vehicle_mi17_woodland_fly_cheap_so", "snow", var_4);
}

killtrigger(var_0, var_1, var_2) {
  var_3 = spawn("trigger_radius", var_0, 0, var_1, var_2);

  for(;;) {
    var_3 waittill("trigger", var_4);

    if(!isplayer(var_4)) {
      continue;
    }
    var_4 maps\_utility::_id_1887();
  }
}