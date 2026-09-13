/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6bc507afe7a93a3.gsc
***********************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_blima", ::_id_6CB969A7647DC10F);
}

_id_6CB969A7647DC10F() {
  callbacks = [];
  callbacks["spawn"] = ::_id_41496C26B8D3660C;
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_blima", callbacks);

  if(scripts\common\utility::_id_A10967D736DC56E5())
    scripts\common\vehicle_build::build_attach_models(::set_attached_models);
}

_id_41496C26B8D3660C(spawndata, _id_EE8DA5624236DC89) {
  vehicle = scripts\cp_mp\vehicles\vehicle::_id_BBA34CF920370FF4("veh9_blima", spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(vehicle))
    return undefined;

  if(istrue(spawndata._id_F16652E1462A3739)) {
    vehicle.unload_hover_offset = 570;
    vehicle.unload_land_offset = 165;
    vehicle.script_badplace = 0;
    vehicle.vehiclesetuprope = 1;
    vehicle vehicle_setspeed(60, 20, 10);
    vehicle._id_22AA4AA0CF0AA6BB = 1;
    vehicle._id_A8F4BB03B366AA80 = 1;
    vehicle.deathfunc = scripts\cp_mp\vehicles\vehicle::vehicle_death;
    vehicle scripts\cp_mp\vehicles\vehicle_occupancy::_id_A91927DF280E94E4();
  }

  return vehicle;
}

#using_animtree("script_model");

set_attached_models() {
  array = [];
  array["TAG_FastRope_LE"] = spawnStruct();
  array["TAG_FastRope_LE"].model = "equipment_fast_rope_wm_01_infil_heli_l";
  array["TAG_FastRope_LE"].tag = "body_animate_jnt";
  array["TAG_FastRope_LE"].idleanim = % iw9_ai_infil_blima_rope_l_idle;
  array["TAG_FastRope_LE"].dropanim = % iw9_ai_infil_blima_rope_l_drop;
  array["TAG_FastRope_RI"] = spawnStruct();
  array["TAG_FastRope_RI"].model = "equipment_fast_rope_wm_01_infil_heli_l";
  array["TAG_FastRope_RI"].tag = "body_animate_jnt";
  array["TAG_FastRope_RI"].idleanim = % iw9_ai_infil_blima_rope_r_idle;
  array["TAG_FastRope_RI"].dropanim = % iw9_ai_infil_blima_rope_r_drop;
  strings = getarraykeys(array);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < strings.size; _id_AC0E594AC96AA3A8++)
    precachemodel(array[strings[_id_AC0E594AC96AA3A8]].model);

  return array;
}