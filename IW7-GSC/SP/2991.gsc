/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2991.gsc
**************************************/

main(var_0, var_1, var_2) {
  scripts\sp\vehicle_build::_id_31C5("capital_ship", var_0, var_1, var_2);
  scripts\sp\vehicle_build::_id_31A6(::init_location);
  scripts\sp\vehicle_build::_id_31A3(999, 500, 1500);
  scripts\sp\vehicle_build::_id_31B8("mig_rumble", 0.2, 0.15, 20300, 0.05, 0.05);
  scripts\sp\vehicle_build::_id_31C4("axis");
  scripts\sp\vehicle_build::_id_31C6();
  scripts\sp\vehicle_build::_id_319F();
  level._effect["freighter_thrust_down_idle"] = loadfx("vfx/iw7/core/vehicle/capship/civ/vfx_capship_civ_thruster_down_sml_idle.vfx");
  level._effect["freighter_thrust_down_boost"] = loadfx("vfx/iw7/core/vehicle/capship/civ/vfx_capship_civ_thruster_down_sml_heavy.vfx");
  level._effect["freighter_thrust_idle"] = loadfx("vfx/iw7/core/vehicle/capship/civ/vfx_capship_civ_thruster_rear_sml_idle.vfx");
  level._effect["freighter_thrust_boost"] = loadfx("vfx/iw7/core/vehicle/capship/civ/vfx_capship_civ_thruster_rear_sml_heavy.vfx");
}

init_location() {
  if(self.classname == "script_vehicle_capitalship_freighter_small") {
    thread _id_11868();
  }
}

_id_11868() {
  self endon("death");
  playFXOnTag(scripts\engine\utility::getfx("freighter_thrust_down_idle"), self, "tag_hover_engine_front");
  playFXOnTag(scripts\engine\utility::getfx("freighter_thrust_down_idle"), self, "tag_hover_engine_back_left");
  playFXOnTag(scripts\engine\utility::getfx("freighter_thrust_down_idle"), self, "tag_hover_engine_back_right");
  playFXOnTag(scripts\engine\utility::getfx("freighter_thrust_idle"), self, "tag_engine_rear");
  wait 0.1;
  self._id_DDA9 = 0;
  var_0 = self.origin;

  for(;;) {
    var_1 = length((var_0[0], var_0[1], 0) - (self.origin[0], self.origin[1], 0));

    if(var_1 > 100) {
      _id_11853();
    } else {
      _id_1185C();
    }

    var_0 = self.origin;
    wait 0.05;
  }
}

_id_11853() {
  if(!self._id_DDA9) {
    return;
  }
  self._id_DDA9 = 0;
  killfxontag(scripts\engine\utility::getfx("freighter_thrust_idle"), self, "tag_engine_rear");
  playFXOnTag(scripts\engine\utility::getfx("freighter_thrust_boost"), self, "tag_engine_rear");
}

_id_1185C() {
  if(self._id_DDA9) {
    return;
  }
  self._id_DDA9 = 1;
  killfxontag(scripts\engine\utility::getfx("freighter_thrust_boost"), self, "tag_engine_rear");
  playFXOnTag(scripts\engine\utility::getfx("freighter_thrust_idle"), self, "tag_engine_rear");
}