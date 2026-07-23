/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\23557.gsc
**************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::_id_2AC2("cobra_player", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2ABE("vehicle_cobra_helicopter");
  maps\_vehicle::_id_2ABE("vehicle_cobra_helicopter_fly");
  var_3 = [];
  var_3["vehicle_cobra_helicopter"] = "explosions/helicopter_explosion_hind_desert";
  var_3["vehicle_cobra_helicopter_fly"] = "explosions/helicopter_explosion_hind_desert";
  maps\_vehicle::_id_2A02("explosions/grenadeexp_default", "tag_engine_left", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, 1);
  maps\_vehicle::_id_2A02("explosions/grenadeexp_default", "tail_rotor_jnt", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, 1);
  maps\_vehicle::_id_2A02("fire/fire_smoke_trail_L", "tail_rotor_jnt", "hind_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1);
  maps\_vehicle::_id_2A02("explosions/aerial_explosion", "tag_engine_right", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1);
  maps\_vehicle::_id_2A02("explosions/aerial_explosion", "tag_deathfx", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 4.0);
  maps\_vehicle::_id_2A02(var_3[var_0], undefined, "hind_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::_id_2AC5();
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_2AC6("allies");
  maps\_vehicle::_id_2AC7();
  var_4 = randomfloatrange(0, 1);
  var_5 = maps\_vehicle::_id_2B1A(var_0, var_2);
  maps\_vehicle::_id_2AAD(var_5, "wingtip_green", "tag_light_L_wing", "misc/aircraft_light_wingtip_green", "running", var_4);
  maps\_vehicle::_id_2AAD(var_5, "wingtip_red", "tag_light_R_wing", "misc/aircraft_light_wingtip_red", "running", var_4);
  maps\_vehicle::_id_2AAD(var_5, "white_blink", "tag_light_belly", "misc/aircraft_light_white_blink", "running", var_4);
  maps\_vehicle::_id_2AAD(var_5, "white_blink_tail", "tag_light_tail", "misc/aircraft_light_white_blink", "running", var_4);
}

_id_2B1D() {
  self.delete_on_death = 1;
  self._id_2941 = 0;
}