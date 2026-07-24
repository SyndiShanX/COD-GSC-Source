/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3034.gsc
**************************************/

main(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = "allies";

  if(issubstr(var_2, "enemy")) {
    var_6 = "axis";
  }

  if(isDefined(var_3)) {
    precachevehicle(var_3);
  } else {
    var_3 = var_1;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(var_1 == "jackal_un" || var_1 == "jackal_un_space") {
    precachevehicle(var_1 + "_thrustperk");
    precachevehicle(var_1 + "_dualfire");
    precachevehicle(var_1 + "_thrustperk_dualfire");
  }

  if(isDefined(var_3) && var_3 == "jackal_un_space") {
    precachevehicle(var_3 + "_thrustperk");
    precachevehicle(var_3 + "_dualfire");
    precachevehicle(var_3 + "_thrustperk_dualfire");
  }

  scripts\sp\vehicle_build::_id_31C5(var_1, var_0, undefined, var_2);
  scripts\sp\vehicle_build::bugoutontimeout(var_4);
  scripts\sp\vehicle_build::_id_31BF(var_5);
  scripts\sp\vehicle_build::_id_31AC(_id_0BD4::_id_A298);
  scripts\sp\vehicle_build::build_all_treadfx(var_1, var_3);
  scripts\sp\vehicle_build::_id_31A3(3000);
  scripts\sp\vehicle_build::_id_3186(var_0, var_0, 0, var_2);
  _id_0C21::_id_9635();

  if(var_6 == "axis") {
    scripts\sp\vehicle_build::_id_31C4("axis");
    _id_0BD7::init(var_6);
  } else {
    scripts\sp\vehicle_build::_id_31C4("allies");
    _id_0BD8::init(var_6);
  }

  _id_0BD4::_id_31A1();
  scripts\sp\vehicle_build::_id_31C6(var_2, "default", "vfx/iw7/core/vehicle/jackal/vfx_jackal_wash.vfx", 1);
  scripts\sp\vehicle_build::_id_31C6(var_2, "rock", "vfx/iw7/core/vehicle/jackal/vfx_jackal_wash_concrete.vfx", 1);
  scripts\sp\vehicle_build::_id_31C6(var_2, "concrete_dry", "vfx/iw7/core/vehicle/jackal/vfx_jackal_wash_concrete.vfx", 1);
  scripts\sp\vehicle_build::_id_31C6(var_2, "snow", "vfx/iw7/core/vehicle/jackal/vfx_jackal_wash_lowg.vfx", 1);
  scripts\sp\vehicle_build::_id_31C6(var_2, "metal", "vfx/iw7/core/vehicle/jackal/vfx_jackal_wash_metal.vfx", 1);
  scripts\sp\vehicle_build::_id_31C6(var_2, "water", "vfx/iw7/core/vehicle/jackal/vfx_jackal_water_tread_wash.vfx", 1);

  if(!isDefined(level._id_A056)) {
    level._id_83DF = _id_0BD4::_id_10492;
    level._id_A056 = spawnStruct();
    level._id_A056._id_4FEB = [];
    level._id_A056._id_63A3 = 0;
    level._id_A056._id_67D8 = 0;
    level._id_A056._id_A976 = -99999999;
    level._id_A056._id_A9BD = -9999999;
    level._id_A056._id_1C54 = 1;
    level._id_A056._id_1C6D = 1;
    level._id_A056._id_1C3C = 1;
    level._id_A056._id_1C6C = 1;
    level._id_A056._id_9B6F = 1;
    level._id_A056._id_D3C1 = "none";
    level._id_A056._id_11B0D = [];
    level._id_A056._id_11B0D["moveto"] = [];
    level._id_A056._id_11B0D["lookat"] = [];
    level._id_A056._id_11B0D["lookat"]["desires"] = 0;
    level._id_A056._id_11B0D["lookat"]["absolute"] = 0;
    level._id_A056._id_11B0D["lookat"]["link"] = 0;
    level._id_A056._id_11B0D["moveto"]["desires"] = 0;
    level._id_A056._id_11B0D["moveto"]["absolute"] = 0;
    level._id_A056._id_11B0D["moveto"]["link"] = 0;
    level._id_A056._id_68B3 = _id_0BD1::_id_68B4();
    level._id_A056._id_B003 = 0;
    level._id_A056._id_BD0F = 0;
    level._id_A056._id_BD10 = 0;
    level._id_A056._id_C73C = 0;
    level._id_A056._id_EBAD = 1;
    level._id_A056._id_EBAE = 1;
    level._id_A056._id_3818 = [];
    level._id_A056._id_D824 = [];
    level._id_A056._id_1630 = [];
    level._id_A056._id_191E = [];
    level._id_A056._id_1914 = [];
    level._id_A056._id_12F96 = [];
    level._id_A056._id_2698 = [];
    level._id_A056.targets = [];
    level._id_A056._id_C93E = [];
    level._id_A056._id_D92C = [];
    level._id_A056._id_933B = [];
    level._id_A056._id_90E3 = [];
    level._id_A056._id_7001 = [];
    level._id_A056._id_432C = [];
    level._id_A056._id_A7E8 = [];
    level._id_A056._id_6F90 = 0;
    level._id_A056._id_2CAD = 0;
    level._id_A056._id_4B57 = 0;
    level._id_A056._id_105E7 = 15;
    level._id_A056._id_241A = _id_0BD9::_id_A318;
    _id_0BDC::_id_9641();
    level._id_A056._id_B323 = 0;
    level notify("jackal_global_init_complete");
  }

  if(_id_B323(var_2)) {
    level._id_A056._id_B323 = 1;
    _id_57AF(var_6, var_0);
    setomnvar("ui_jackal_load_ui", 1);
  }

  _id_0BD4::_id_75E7(var_6, var_2);
}

_id_B323(var_0) {
  var_1 = 0;
  var_2 = getEntArray(var_0, "classname");

  foreach(var_4 in var_2) {
    if(var_4 _id_0BDC::_id_9CF5()) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_57AF(var_0, var_1) {
  if(var_0 == "axis") {
    scripts\sp\vehicle_build::_id_31B0("veh_mil_air_ca_jackal_01_player", var_1);
  } else {
    scripts\sp\vehicle_build::_id_31B0("veh_mil_air_un_jackal_02_player", var_1);
  }
}