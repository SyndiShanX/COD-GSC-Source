/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3034.gsc
***************************************/

main(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = "allies";

  if(issubstr(var_02, "enemy"))
    var_06 = "axis";

  if(isDefined(var_03))
    precachevehicle(var_03);
  else
    var_03 = var_01;

  if(!isDefined(var_04))
    var_04 = 0;

  if(!isDefined(var_05))
    var_05 = 0;

  if(var_01 == "jackal_un" || var_01 == "jackal_un_space") {
    precachevehicle(var_01 + "_thrustperk");
    precachevehicle(var_01 + "_dualfire");
    precachevehicle(var_01 + "_thrustperk_dualfire");
  }

  if(isDefined(var_03) && var_03 == "jackal_un_space") {
    precachevehicle(var_03 + "_thrustperk");
    precachevehicle(var_03 + "_dualfire");
    precachevehicle(var_03 + "_thrustperk_dualfire");
  }

  scripts\sp\vehicle_build::func_31C5(var_01, var_00, undefined, var_02);
  scripts\sp\vehicle_build::bugoutontimeout(var_04);
  scripts\sp\vehicle_build::func_31BF(var_05);
  scripts\sp\vehicle_build::func_31AC(func_0BD4::func_A298);
  scripts\sp\vehicle_build::build_all_treadfx(var_01, var_03);
  scripts\sp\vehicle_build::func_31A3(3000);
  scripts\sp\vehicle_build::func_3186(var_00, var_00, 0, var_02);
  func_0C21::func_9635();

  if(var_06 == "axis") {
    scripts\sp\vehicle_build::func_31C4("axis");
    func_0BD7::init(var_06);
  } else {
    scripts\sp\vehicle_build::func_31C4("allies");
    func_0BD8::init(var_06);
  }

  func_0BD4::func_31A1();
  scripts\sp\vehicle_build::func_31C6(var_02, "default", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash.vfx", 1);
  scripts\sp\vehicle_build::func_31C6(var_02, "rock", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash_concrete.vfx", 1);
  scripts\sp\vehicle_build::func_31C6(var_02, "concrete_dry", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash_concrete.vfx", 1);
  scripts\sp\vehicle_build::func_31C6(var_02, "snow", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash_lowg.vfx", 1);
  scripts\sp\vehicle_build::func_31C6(var_02, "metal", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash_metal.vfx", 1);
  scripts\sp\vehicle_build::func_31C6(var_02, "water", "vfx\iw7\core\vehicle\jackal\vfx_jackal_water_tread_wash.vfx", 1);

  if(!isDefined(level.func_A056)) {
    level._meth_83DF = func_0BD4::func_10492;
    level.func_A056 = spawnStruct();
    level.func_A056.func_4FEB = [];
    level.func_A056.func_63A3 = 0;
    level.func_A056.func_67D8 = 0;
    level.func_A056.func_A976 = -99999999;
    level.func_A056.func_A9BD = -9999999;
    level.func_A056.func_1C54 = 1;
    level.func_A056.func_1C6D = 1;
    level.func_A056.func_1C3C = 1;
    level.func_A056.func_1C6C = 1;
    level.func_A056.func_9B6F = 1;
    level.func_A056.func_D3C1 = "none";
    level.func_A056.func_11B0D = [];
    level.func_A056.func_11B0D["moveto"] = [];
    level.func_A056.func_11B0D["lookat"] = [];
    level.func_A056.func_11B0D["lookat"]["desires"] = 0;
    level.func_A056.func_11B0D["lookat"]["absolute"] = 0;
    level.func_A056.func_11B0D["lookat"]["link"] = 0;
    level.func_A056.func_11B0D["moveto"]["desires"] = 0;
    level.func_A056.func_11B0D["moveto"]["absolute"] = 0;
    level.func_A056.func_11B0D["moveto"]["link"] = 0;
    level.func_A056.func_68B3 = func_0BD1::func_68B4();
    level.func_A056.func_B003 = 0;
    level.func_A056.func_BD0F = 0;
    level.func_A056.func_BD10 = 0;
    level.func_A056.func_C73C = 0;
    level.func_A056.func_EBAD = 1;
    level.func_A056.func_EBAE = 1;
    level.func_A056.func_3818 = [];
    level.func_A056.func_D824 = [];
    level.func_A056.func_1630 = [];
    level.func_A056.func_191E = [];
    level.func_A056.func_1914 = [];
    level.func_A056.func_12F96 = [];
    level.func_A056.func_2698 = [];
    level.func_A056.targets = [];
    level.func_A056.func_C93E = [];
    level.func_A056.func_D92C = [];
    level.func_A056.func_933B = [];
    level.func_A056.func_90E3 = [];
    level.func_A056.func_7001 = [];
    level.func_A056.func_432C = [];
    level.func_A056.func_A7E8 = [];
    level.func_A056.func_6F90 = 0;
    level.func_A056.func_2CAD = 0;
    level.func_A056.func_4B57 = 0;
    level.func_A056.func_105E7 = 15;
    level.func_A056.func_241A = func_0BD9::func_A318;
    func_0BDC::func_9641();
    level.func_A056.func_B323 = 0;
    level notify("jackal_global_init_complete");
  }

  if(func_B323(var_02)) {
    level.func_A056.func_B323 = 1;
    func_57AF(var_06, var_00);
    setomnvar("ui_jackal_load_ui", 1);
  }

  func_0BD4::func_75E7(var_06, var_02);
}

func_B323(var_00) {
  var_01 = 0;
  var_02 = getEntArray(var_00, "classname");

  foreach(var_04 in var_02) {
    if(var_04 func_0BDC::func_9CF5()) {
      var_01 = 1;
      break;
    }
  }

  return var_01;
}

func_57AF(var_00, var_01) {
  if(var_00 == "axis")
    scripts\sp\vehicle_build::func_31B0("veh_mil_air_ca_jackal_01_player", var_01);
  else
    scripts\sp\vehicle_build::func_31B0("veh_mil_air_un_jackal_02_player", var_01);
}