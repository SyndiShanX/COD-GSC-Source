/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3034.gsc
***************************************/

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

  scripts\sp\vehicle_build::func_31C5(var_1, var_0, undefined, var_2);
  scripts\sp\vehicle_build::bugoutontimeout(var_4);
  scripts\sp\vehicle_build::func_31BF(var_5);
  scripts\sp\vehicle_build::func_31AC(func_0BD4::func_A298);
  scripts\sp\vehicle_build::build_all_treadfx(var_1, var_3);
  scripts\sp\vehicle_build::func_31A3(3000);
  scripts\sp\vehicle_build::func_3186(var_0, var_0, 0, var_2);
  func_0C21::func_9635();

  if(var_6 == "axis") {
    scripts\sp\vehicle_build::func_31C4("axis");
    func_0BD7::init(var_6);
  } else {
    scripts\sp\vehicle_build::func_31C4("allies");
    func_0BD8::init(var_6);
  }

  func_0BD4::func_31A1();
  scripts\sp\vehicle_build::func_31C6(var_2, "default", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash.vfx", 1);
  scripts\sp\vehicle_build::func_31C6(var_2, "rock", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash_concrete.vfx", 1);
  scripts\sp\vehicle_build::func_31C6(var_2, "concrete_dry", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash_concrete.vfx", 1);
  scripts\sp\vehicle_build::func_31C6(var_2, "snow", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash_lowg.vfx", 1);
  scripts\sp\vehicle_build::func_31C6(var_2, "metal", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash_metal.vfx", 1);
  scripts\sp\vehicle_build::func_31C6(var_2, "water", "vfx\iw7\core\vehicle\jackal\vfx_jackal_water_tread_wash.vfx", 1);

  if(!isDefined(level.var_A056)) {
    level._meth_83DF = func_0BD4::func_10492;
    level.var_A056 = spawnStruct();
    level.var_A056.var_4FEB = [];
    level.var_A056.var_63A3 = 0;
    level.var_A056.var_67D8 = 0;
    level.var_A056.var_A976 = -99999999;
    level.var_A056.var_A9BD = -9999999;
    level.var_A056.var_1C54 = 1;
    level.var_A056.var_1C6D = 1;
    level.var_A056.var_1C3C = 1;
    level.var_A056.var_1C6C = 1;
    level.var_A056.var_9B6F = 1;
    level.var_A056.var_D3C1 = "none";
    level.var_A056.var_11B0D = [];
    level.var_A056.var_11B0D["moveto"] = [];
    level.var_A056.var_11B0D["lookat"] = [];
    level.var_A056.var_11B0D["lookat"]["desires"] = 0;
    level.var_A056.var_11B0D["lookat"]["absolute"] = 0;
    level.var_A056.var_11B0D["lookat"]["link"] = 0;
    level.var_A056.var_11B0D["moveto"]["desires"] = 0;
    level.var_A056.var_11B0D["moveto"]["absolute"] = 0;
    level.var_A056.var_11B0D["moveto"]["link"] = 0;
    level.var_A056.var_68B3 = func_0BD1::func_68B4();
    level.var_A056.var_B003 = 0;
    level.var_A056.var_BD0F = 0;
    level.var_A056.var_BD10 = 0;
    level.var_A056.var_C73C = 0;
    level.var_A056.var_EBAD = 1;
    level.var_A056.var_EBAE = 1;
    level.var_A056.var_3818 = [];
    level.var_A056.var_D824 = [];
    level.var_A056.var_1630 = [];
    level.var_A056.var_191E = [];
    level.var_A056.var_1914 = [];
    level.var_A056.var_12F96 = [];
    level.var_A056.var_2698 = [];
    level.var_A056.targets = [];
    level.var_A056.var_C93E = [];
    level.var_A056.var_D92C = [];
    level.var_A056.var_933B = [];
    level.var_A056.var_90E3 = [];
    level.var_A056.var_7001 = [];
    level.var_A056.var_432C = [];
    level.var_A056.var_A7E8 = [];
    level.var_A056.var_6F90 = 0;
    level.var_A056.var_2CAD = 0;
    level.var_A056.var_4B57 = 0;
    level.var_A056.var_105E7 = 15;
    level.var_A056.var_241A = func_0BD9::func_A318;
    func_0BDC::func_9641();
    level.var_A056.var_B323 = 0;
    level notify("jackal_global_init_complete");
  }

  if(func_B323(var_2)) {
    level.var_A056.var_B323 = 1;
    func_57AF(var_6, var_0);
    setomnvar("ui_jackal_load_ui", 1);
  }

  func_0BD4::func_75E7(var_6, var_2);
}

func_B323(var_0) {
  var_1 = 0;
  var_2 = getEntArray(var_0, "classname");

  foreach(var_4 in var_2) {
    if(var_4 func_0BDC::func_9CF5()) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

func_57AF(var_0, var_1) {
  if(var_0 == "axis") {
    scripts\sp\vehicle_build::func_31B0("veh_mil_air_ca_jackal_01_player", var_1);
  } else {
    scripts\sp\vehicle_build::func_31B0("veh_mil_air_un_jackal_02_player", var_1);
  }
}