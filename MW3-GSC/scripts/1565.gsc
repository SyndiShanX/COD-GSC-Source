/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1565.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::_id_2AC2("mi17_noai", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2ABE("vehicle_mi17_woodland");
  maps\_vehicle::_id_2ABE("vehicle_mi17_woodland_fly");
  maps\_vehicle::_id_2ABE("vehicle_mi17_woodland_fly_cheap");
  maps\_vehicle::_id_2ABE("vehicle_mi17_woodland_landing");
  var_3 = [];
  var_3["vehicle_mi17_woodland"] = "explosions/helicopter_explosion_mi17_woodland";
  var_3["vehicle_mi17_woodland_fly"] = "explosions/helicopter_explosion_mi17_woodland_low";
  var_3["vehicle_mi17_woodland_fly_cheap"] = "explosions/helicopter_explosion_mi17_woodland_low";
  var_3["vehicle_mi17_woodland_landing"] = "explosions/helicopter_explosion_mi17_woodland_low";
  var_3["vehicle_mi-28_flying"] = "explosions/helicopter_explosion_mi17_woodland_low";
  maps\_vehicle::_id_2A02("fire/fire_smoke_trail_L", "tag_engine_right", "mi17_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1);
  maps\_vehicle::_id_2A02("explosions/aerial_explosion", "tag_engine_right", "mi17_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1);
  maps\_vehicle::_id_2A02("explosions/aerial_explosion", "tag_deathfx", "mi17_helicopter_secondary_exp", undefined, undefined, undefined, 4.0);
  maps\_vehicle::_id_2A02(var_3[var_0], undefined, "mi17_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::_id_2AC1( % mi17_heli_rotors, undefined, 0);
  maps\_vehicle::_id_2A02("explosions/grenadeexp_default", "tag_engine_left", "mi17_helicopter_hit", undefined, undefined, undefined, 0.2, 1);
  maps\_vehicle::_id_2A02("explosions/grenadeexp_default", "tag_engine_right", "mi17_helicopter_hit", undefined, undefined, undefined, 0.5, 1);
  maps\_vehicle::_id_2AC5();
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_29F5("tank_rumble", 0.15, 4.5, 600, 1, 1);
  maps\_vehicle::_id_2AC6("axis");
  maps\_vehicle::_id_2AC8(1);
  var_4 = randomfloatrange(0, 1);
  var_5 = maps\_vehicle::_id_2B1A(var_0, var_2);
  maps\_vehicle::_id_2AAD(var_5, "cockpit_blue_cargo01", "tag_light_cargo01", "misc/aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::_id_2AAD(var_5, "cockpit_blue_cockpit01", "tag_light_cockpit01", "misc/aircraft_light_cockpit_blue", "interior", 0.1);
  maps\_vehicle::_id_2AAD(var_5, "white_blink", "tag_light_belly", "misc/aircraft_light_white_blink", "running", var_4);
  maps\_vehicle::_id_2AAD(var_5, "white_blink_tail", "tag_light_tail", "misc/aircraft_light_red_blink", "running", var_4);
  maps\_vehicle::_id_2AAD(var_5, "wingtip_green", "tag_light_L_wing", "misc/aircraft_light_wingtip_green", "running", var_4);
  maps\_vehicle::_id_2AAD(var_5, "wingtip_red", "tag_light_R_wing", "misc/aircraft_light_wingtip_red", "running", var_4);
}

_id_2B1D() {
  self._id_295E = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
  self._id_295A = 710;
  self._id_2941 = 0;
  maps\_vehicle::_id_2AB3("running");
  maps\_vehicle::_id_2AB3("interior");
}