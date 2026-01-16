/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\mp_vacant.gsc
********************************/

main() {
  maps\mp\mp_vacant_precache::main();
  maps\mp\mp_vacant_fx::main();
  maps\createart\mp_vacant_art::main();
  maps\mp\_load::main();
  maps\mp\_water::init();
  maps\mp\_compass::setupminimap("compass_map_mp_vacant_dlc");
  game["attackers"] = "axis";
  game["defenders"] = "allies";
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  thread delete_botconnect_clip();
  maps\mp\_utility::hardpointtriggerswap((718, -571, 4), "patch_hp_zone_trigger_3");
}

delete_botconnect_clip() {
  for (;;) {
    var_0 = getent("botconnect_delete_on_load", "targetname");

    if(isdefined(var_0)) {
      var_0 delete();
      break;
    }

    waitframe();
  }
}