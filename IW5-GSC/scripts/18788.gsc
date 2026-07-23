/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18788.gsc
**************************************/

main(var_0, var_1, var_2, var_3) {
  if(var_0 == "vehicle_submarine_sdv") {
    maps\_vehicle::_id_2AC2("submarine_sdv", var_0, var_1, var_2);
  } else {
    maps\_vehicle::_id_2AC2("blackshadow_730", var_0, var_1, var_2);
  }
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2ABE(var_0);
  maps\_vehicle::_id_2ACE(999, 500, 1500);

  if(!isDefined(var_3) || !var_3) {
    if(var_0 == "vehicle_submarine_sdv") {
      maps\_vehicle::_id_29F5("tank_rumble", 0.05, 1.5, 900, 1, 1);
    }
  }

  maps\_vehicle::_id_2AC6("allies");
  level._effect["sdv_prop_wash_1"] = loadfx("water/sdv_prop_wash_2");
  level._effect["sdv_headlights"] = loadfx("misc/spotlight_submarine_sdv");
}

_id_2B1D() {
  maps\_utility::_id_1402("moving");
  maps\_utility::_id_1402("lights");
  thread _id_4962();
  thread _id_4961();
  thread _id_4963();
}

_id_4961() {
  self endon("sdv_done");
  self endon("death");

  for(;;) {
    maps\_utility::_id_1654("moving");
    thread maps\_utility::play_sound_on_tag("sdv_start", "TAG_PROPELLER");
    maps\_utility::delaythread(1, maps\_utility::_id_258E, "sdv_move_loop", "TAG_PROPELLER", 1);
    playFXOnTag(common_scripts\utility::getfx("sdv_prop_wash_1"), self, "TAG_PROPELLER");
    maps\_utility::_id_13DB("moving");
    stopFXOnTag(common_scripts\utility::getfx("sdv_prop_wash_1"), self, "TAG_PROPELLER");
    self notify("stop soundsdv_move_loop");
    thread maps\_utility::play_sound_on_tag("sdv_stop", "TAG_PROPELLER");
  }
}

_id_4962() {
  common_scripts\utility::waittill_either("sdv_done", "death");

  if(maps\_utility::_id_1008("lights")) {
    stopFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self, "TAG_LIGHT_L");
    stopFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self, "TAG_LIGHT_R");
  }

  if(maps\_utility::_id_1008("moving")) {
    stopFXOnTag(common_scripts\utility::getfx("sdv_prop_wash_1"), self, "TAG_PROPELLER");
    self notify("stop soundsdv_move_loop");
  }
}

_id_4963() {
  self endon("sdv_done");
  self endon("death");

  for(;;) {
    maps\_utility::_id_1654("lights");
    playFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self, "TAG_LIGHT_L");
    playFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self, "TAG_LIGHT_R");
    maps\_utility::_id_13DB("lights");
    stopFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self, "TAG_LIGHT_L");
    stopFXOnTag(common_scripts\utility::getfx("sdv_headlights"), self, "TAG_LIGHT_R");
  }
}