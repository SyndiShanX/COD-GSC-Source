/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_treadfx.gsc
**********************************************/

#using scripts\common\utility;
#using scripts\common\vehicle_build;
#namespace vehicle_treadfx;

function main(classname) {
  if(!utility::issp()) {
    return;
  }

  if(!isDefined(classname)) {
    return;
  }

  println("<dev string:x24>" + classname + "<dev string:x2c>");

  switch (classname) {
    case #"hash_71008a9338b0673b":
    case #"hash_3f2c0e6c7a64af09":
      setallvehiclefx(classname, "vfx/core/tread/tread_dust_hamburg_cheap.vfx");
      setvehiclefx(classname, "water");
      setvehiclefx(classname, "paintedmetal");
      setvehiclefx(classname, "riotshield");
      break;
    case #"hash_4bad46ea31d6d86a":
    case #"hash_70617a8b0ec2cd1d":
    case #"hash_ce8f530cb4709d4e":
      setallvehiclefx(classname, "vfx_core_tread_dust_default");
      setvehiclefx(classname, "water");
      setvehiclefx(classname, "rock", undefined);
      setvehiclefx(classname, "metal", undefined);
      setvehiclefx(classname, "brick", undefined);
      setvehiclefx(classname, "plaster", undefined);
      setvehiclefx(classname, "asphalt", "vfx_core_tread_asphalt_default");
      setvehiclefx(classname, "paintedmetal", undefined);
      setvehiclefx(classname, "riotshield", undefined);
      setvehiclefx(classname, "snow", "vfx_core_tread_snow_default");
      setvehiclefx(classname, "slush", "vfx_core_tread_snow_default");
      setvehiclefx(classname, "ice", "vfx_core_tread_ice_default");
      break;
    case #"hash_83743926c270ef6":
    case #"hash_f6a9c91966c29d2":
    case #"hash_1516dae648a09369":
    case #"hash_1986ad9d73e2efcd":
    case #"hash_27322cedec30a150":
    case #"hash_285836f85889835c":
    case #"hash_2d54cd0aaf896093":
    case #"hash_2e8f1078a6e42aa1":
    case #"hash_3475a2b82542f108":
    case #"hash_4394dd264b4c336d":
    case #"hash_4455ac470ad4f447":
    case #"hash_44f7c5624c563a12":
    case #"hash_45f333f304af9321":
    case #"hash_4dec7c28e67c4250":
    case #"hash_586cf9fb35a624ff":
    case #"hash_6144babed4d994c1":
    case #"hash_6388d3310b6eee51":
    case #"hash_6b776e69d76b398e":
    case #"hash_6e092f3933097748":
    case #"hash_70163daef54d5e2f":
    case #"hash_7fdb04f7b8f336b4":
    case #"hash_8022748acb3f8b32":
    case #"hash_8abe07bcb971cd7b":
    case #"hash_8fe0f4cda180e9be":
    case #"hash_9f774232eb800672":
    case #"hash_b4cf2c3d5885aaf9":
    case #"hash_b6e3060e46cbf009":
    case #"hash_b810f95da7cb884b":
    case #"hash_bdef3789ccbcfb29":
    case #"hash_c1a8acb1f85adf86":
    case #"hash_cd15e045f931d2f1":
    case #"hash_3203e98492f32e9":
    case #"hash_cf5c774c44923b1b":
    case #"hash_d399f417cdbe4ec4":
    case #"hash_d461eaf25c74fc8e":
    case #"hash_d592af7e6653cc27":
    case #"hash_de37649d78beb4f1":
    case #"hash_e05ccf70c83917ca":
    case #"hash_e8747ab7fcf1ae4b":
    case #"hash_f3b63b2061ebef82":
    case #"hash_f535f05298f09dcd":
    case #"hash_f6fd3c22bf19b36a":
    case #"hash_fb3a63203f10a93b":
    case #"hash_fe6255f9395ab835":
      setallvehiclefx(classname, "vfx_code_tread_heli_dust_default");
      setvehiclefx(classname, "water", "vfx_code_tread_heli_water");
      setvehiclefx(classname, "snow", "vfx_core_tread_heli_snow_default");
      setvehiclefx(classname, "slush", "vfx_core_tread_heli_snow_default");
      setvehiclefx(classname, "ice", "vfx_core_tread_heli_snow_default");
      break;
    case #"hash_fa8573607a14bd31":
      setallvehiclefx(classname, "vfx_core_tread_dust_default");
      setvehiclefx(classname, "snow", "vfx_core_tread_snow_default");
      setvehiclefx(classname, "slush", "vfx_core_tread_snow_default");
      setvehiclefx(classname, "ice", "vfx_core_tread_ice_default");
      break;
    default:
      setallvehiclefx(classname, "vfx_core_tread_dust_default");
      setvehiclefx(classname, "water");
      setvehiclefx(classname, "concrete");
      setvehiclefx(classname, "rock");
      setvehiclefx(classname, "metal");
      setvehiclefx(classname, "brick");
      setvehiclefx(classname, "plaster");
      setvehiclefx(classname, "asphalt", "vfx_core_tread_asphalt_default");
      setvehiclefx(classname, "paintedmetal");
      setvehiclefx(classname, "riotshield");
      setvehiclefx(classname, "snow", "vfx_core_tread_snow_default");
      setvehiclefx(classname, "slush", "vfx_core_tread_snow_default");
      setvehiclefx(classname, "ice", "vfx_core_tread_ice_default");
      break;
  }
}

function setvehiclefx(classname, material, fx) {
  vehicle_build::set_vehicle_effect(classname, material, fx);
}

function setallvehiclefx(classname, fx) {
  types = get_trace_types();
  setvehiclefx(classname, "none");

  foreach(type in types) {
    setvehiclefx(classname, type, fx);
  }
}

function get_trace_types() {
  return ["brick", "bark", "carpet", "cloth", "concrete", "dirt", "flesh", "foliage", "glass", "grass", "gravel", "ice", "metal", "mud", "paper", "plaster", "rock", "sand", "snow", "water", "wood", "asphalt", "ceramic", "plastic", "rubber", "cushion", "fruit", "paintedmetal", "riotshield", "slush", "default"];
}