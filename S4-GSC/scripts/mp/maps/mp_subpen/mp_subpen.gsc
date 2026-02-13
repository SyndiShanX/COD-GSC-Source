/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_subpen\mp_subpen.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_subpen\mp_subpen_precache::main();
  scripts\mp\maps\mp_subpen\gen\mp_subpen_art::main();
  scripts\mp\maps\mp_subpen\mp_subpen_fx::main();
  scripts\mp\maps\mp_subpen\mp_subpen_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_subpen");
  setDvar("#x32ee39981452e9751", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  setDvar("#x331157d6a11c2a653", 3000.0);
  setDvar("#x3b94d9d617f14e388", 1200);
  setDvar("#x36d8bf82840d880d2", 1);
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  thread fixcollision();
  thread fixcollision2();
  level addpostlaunchspawns();
  scripts\mp\s4_elf_poi::add_elf_poi_position((1635, 561, 348.5), (0, 180, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((1210, -1008.25, 324.5), (0, 180, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((370.5, -550.25, 383.75), (0, 90, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((177, 531.5, 347.5), (0, 90, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-53.4765, -40.8801, 490.5), (0, 166, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-781, -494.5, 281), (0, 90, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1059.39, -476.345, 492), (0, 46.2073, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1195, 374.5, 347), (0, 270, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-497, 754, 218.478), (0, 270, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1378, -28.5, 371.5), (0, 180, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-315.218, -946.14, 530.5), (0, 90, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1062.23, -747.378, 550.375), (0, 322, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1604.29, -990.39, 474.722), (0, 90, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-2115.5, -797, 451), (0, 233, 0), "sitting");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-2626.55, 667.623, 312), (0, 316.801, 0), "standing");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-1829, 170, 409), (0, 270, 0), "laying");
  scripts\mp\s4_elf_poi::add_elf_poi_position((-2512.68, -364.243, 360), (0, 30, 0), "laying");
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("1", (-804.038, 303.239, 682.325), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("2", (-1705.37, -811.712, 605.984), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("3", (1210.19, -1079.42, 531.766), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("4", (-738.465, -550.867, 721.089), (0, 0, 0), 1);
  scripts\mp\gametypes\kspoint::override_car_package_drop_trajectory("5", (-2884.73, 212.534, 480.107), (0, 90, 0), 1);
}

fixcollision() {
  var_0 = getent("player512x512x8", "targetname");
  var_1 = spawn("script_model", (-1722, 947, 340));
  var_1.angles = (0, 354.692, 90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("player512x512x8", "targetname");
  var_3 = spawn("script_model", (-1212, 900, 340));
  var_3.angles = (0, 354.692, 90);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("player512x512x8", "targetname");
  var_5 = spawn("script_model", (-702, 876, 340));
  var_5.angles = (0, 0, 90);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("player512x512x8", "targetname");
  var_7 = spawn("script_model", (-190, 876, 340));
  var_7.angles = (0, 0, 90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("player512x512x8", "targetname");
  var_9 = spawn("script_model", (318, 915, 340));
  var_9.angles = (0, 8.75, 90);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("player512x512x8", "targetname");
  var_11 = spawn("script_model", (824, 993, 340));
  var_11.angles = (0, 8.75, 90);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = spawn("script_model", (1556.5, -398.5, 311));
  var_12 setModel("s4_sub_catwalk_railing_32");
  var_12.angles = (0, 270, 0);
  var_13 = getent("clip128x128x8", "targetname");
  var_14 = spawn("script_model", (-192, 45, 373));
  var_14.angles = (0, 5.837, -90);
  var_14 clonebrushmodeltoscriptmodel(var_13);
  var_15 = getent("clip128x128x8", "targetname");
  var_16 = spawn("script_model", (-94, 55, 373));
  var_16.angles = (0, 5.837, -90);
  var_16 clonebrushmodeltoscriptmodel(var_15);
  var_17 = getent("clip128x128x8", "targetname");
  var_18 = spawn("script_model", (-192, -111, 373));
  var_18.angles = (0, 354.338, -90);
  var_18 clonebrushmodeltoscriptmodel(var_17);
  var_19 = getent("clip128x128x8", "targetname");
  var_20 = spawn("script_model", (-96, -120, 373));
  var_20.angles = (0, 354.338, -90);
  var_20 clonebrushmodeltoscriptmodel(var_19);
  var_21 = getent("clip128x128x8", "targetname");
  var_22 = spawn("script_model", (299, 55, 373));
  var_22.angles = (0, 354.599, -90);
  var_22 clonebrushmodeltoscriptmodel(var_21);
  var_23 = getent("clip128x128x8", "targetname");
  var_24 = spawn("script_model", (396, 47, 373));
  var_24.angles = (0, 354.599, -90);
  var_24 clonebrushmodeltoscriptmodel(var_23);
  var_25 = getent("clip128x128x8", "targetname");
  var_26 = spawn("script_model", (299, -119, 373));
  var_26.angles = (0, 5.663, -90);
  var_26 clonebrushmodeltoscriptmodel(var_25);
  var_27 = getent("clip128x128x8", "targetname");
  var_28 = spawn("script_model", (395, -109, 373));
  var_28.angles = (0, 5.663, -90);
  var_28 clonebrushmodeltoscriptmodel(var_27);
  var_29 = getent("clip64x64x256", "targetname");
  var_30 = spawn("script_model", (695, -293, 70));
  var_30.angles = (270, 0, 90);
  var_30 clonebrushmodeltoscriptmodel(var_29);
  var_31 = getent("clip64x64x64", "targetname");
  var_32 = spawn("script_model", (695, -413, 91));
  var_32.angles = (270, 0, -90);
  var_32 clonebrushmodeltoscriptmodel(var_31);
  var_33 = getent("clip32x32x256", "targetname");
  var_34 = spawn("script_model", (679, -353, 116));
  var_34.angles = (270, 0, 90);
  var_34 clonebrushmodeltoscriptmodel(var_33);
  var_35 = getent("clip32x32x256", "targetname");
  var_36 = spawn("script_model", (691, -353, 112));
  var_36.angles = (270, 0, 90);
  var_36 clonebrushmodeltoscriptmodel(var_35);
  var_37 = getent("clip64x64x8", "targetname");
  var_38 = spawn("script_model", (-2874, 456, 332));
  var_38.angles = (0, 281.662, -84.0003);
  var_38 clonebrushmodeltoscriptmodel(var_37);
  var_39 = getent("clip64x64x8", "targetname");
  var_40 = spawn("script_model", (-2886, 458, 334));
  var_40.angles = (0, 269.663, -90);
  var_40 clonebrushmodeltoscriptmodel(var_39);
  var_41 = getent("clip64x64x8", "targetname");
  var_42 = spawn("script_model", (284, -172, 320));
  var_42.angles = (21.996, 270, -90);
  var_42 clonebrushmodeltoscriptmodel(var_41);
  var_43 = getent("clip32x32x32", "targetname");
  var_44 = spawn("script_model", (260, -222, 316));
  var_44.angles = (21.996, 270, -90);
  var_44 clonebrushmodeltoscriptmodel(var_43);
  var_45 = getent("clip64x64x8", "targetname");
  var_46 = spawn("script_model", (94, -178, 342));
  var_46.angles = (0, 0, 21.997);
  var_46 clonebrushmodeltoscriptmodel(var_45);
  var_47 = getent("clip64x64x8", "targetname");
  var_48 = spawn("script_model", (94, -236, 318));
  var_48.angles = (0, 0, 21.997);
  var_48 clonebrushmodeltoscriptmodel(var_47);
  var_49 = spawn("script_model", (-1432, -977.5, 390.5));
  var_49 setModel("ee_pipe_01_256_light_brown");
  var_49.angles = (0, 0, -180);
  var_50 = spawn("script_model", (-1688, -977.5, 390.5));
  var_50 setModel("ee_pipe_01_256_light_brown");
  var_50.angles = (0, 0, -180);
  var_51 = spawn("script_model", (-1944, -977.5, 390.5));
  var_51 setModel("ee_pipe_01_256_light_brown");
  var_51.angles = (0, 0, -180);
  var_52 = spawn("script_model", (-1910.5, -837, 398.5));
  var_52 setModel("ee_pipe_01_256_light_brown");
  var_52.angles = (0, 270, -180);
  var_53 = spawn("script_model", (-1928.5, -1006.5, 372));
  var_53 setModel("ee_pipe_01_256_light_brown");
  var_53.angles = (270, 360, 90);
  var_54 = spawn("script_model", (-1867, -975, 385));
  var_54 setModel("s4_sub_catwalk_railing_cover_128");
  var_54.angles = (0, 180, 0);
  var_55 = spawn("script_model", (-1956, -979, 359));
  var_55 setModel("s4_metal_pipe_straight_x32_01");
  var_55.angles = (270, 270, 90);
  var_56 = spawn("script_model", (-1956, -979, 423));
  var_56 setModel("s4_metal_pipe_straight_x32_01");
  var_56.angles = (270, 270, 90);
  var_57 = spawn("script_model", (-1956, -979, 487));
  var_57 setModel("s4_metal_pipe_straight_x32_01");
  var_57.angles = (270, 270, 90);
  var_58 = spawn("script_model", (-2532, -393, 311));
  var_58 setModel("s4_metal_pipe_straight_x32_01");
  var_58.angles = (270, 270, 90);
  var_59 = spawn("script_model", (-2532, -393, 375));
  var_59 setModel("s4_metal_pipe_straight_x32_01");
  var_59.angles = (270, 270, 90);
  var_60 = spawn("script_model", (-2532, -393, 439));
  var_60 setModel("s4_metal_pipe_straight_x32_01");
  var_60.angles = (270, 270, 90);
  var_61 = spawn("script_model", (-2532, -393, 503));
  var_61 setModel("s4_metal_pipe_straight_x32_01");
  var_61.angles = (270, 270, 90);
  var_62 = spawn("script_model", (-2532, -393, 567));
  var_62 setModel("s4_metal_pipe_straight_x32_01");
  var_62.angles = (270, 270, 90);
}

fixcollision2() {
  var_0 = getent("clip64x64x64", "targetname");
  var_1 = spawn("script_model", (1229, -996, 261));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip64x64x64", "targetname");
  var_3 = spawn("script_model", (1229, -1023, 261));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = spawn("script_model", (1256, -970, 319));
  var_4 setModel("s4_ger_wood_walkway_01_x64");
  var_4.angles = (0, 0, -90);
  var_5 = spawn("script_model", (1256, -970, 259));
  var_5 setModel("s4_ger_wood_walkway_01_x64");
  var_5.angles = (0, 0, 90);
  var_6 = spawn("script_model", (1256, -969, 319));
  var_6 setModel("s4_ger_wood_walkway_01_x64");
  var_6.angles = (0, 90, -90);
  var_7 = spawn("script_model", (1256, -992, 260));
  var_7 setModel("s4_ger_wood_walkway_01_x64");
  var_7.angles = (0, 90, 90);
  var_8 = spawn("script_model", (1256, -1047, 259));
  var_8 setModel("s4_ger_wood_walkway_01_x64");
  var_8.angles = (0, 0, 90);
  var_9 = spawn("script_model", (1256, -1047, 319));
  var_9 setModel("s4_ger_wood_walkway_01_x64");
  var_9.angles = (0, 0, -90);
  var_10 = getent("clip256x256x256", "targetname");
  var_11 = spawn("script_model", (1149, -720, 508));
  var_11.angles = (0, 0, -15.0388);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = spawn("script_model", (1149, -966, 578.5));
  var_12.angles = (0, 0, -16.901);
  var_12 clonebrushmodeltoscriptmodel(var_10);
  var_13 = getent("clip128x128x8", "targetname");
  var_14 = spawn("script_model", (1013, -696, 480));
  var_14.angles = (0, 90, 90);
  var_14 clonebrushmodeltoscriptmodel(var_13);
  var_15 = getent("clip64x64x64", "targetname");
  var_16 = spawn("script_model", (758.084, -669, 240.041));
  var_16.angles = (0, 0, 0);
  var_16 clonebrushmodeltoscriptmodel(var_15);
}

addpostlaunchspawns() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "ctf":
      break;
    case "patrol":
      break;
    case "control":
      break;
    case "sd":
      break;
    case "dm":
    case "gun":
      break;
    case "dom":
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1603.1, -626.109, 332.5), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1609.1, -684.109, 332.5), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1552, -946.452, 284), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1486, -930.464, 284), (0, 66, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1005.43, -1174.02, 284), (0, 118, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (957.769, -1414.48, 284), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (889.769, -1418.48, 284), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (767.445, -1191.95, 284), (0, 62, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (377.427, -1406, 284), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (1478, -346.132, 72), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1253.88, 33.83, 194.5), (0, 128, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (1254.17, -57.8764, 194.5), (0, 238, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (897.889, 323.794, 72), (0, 198, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (887.908, 73.8263, 72), (0, 150, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (763.887, -369.226, 72), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (635.962, 67.8636, 72), (0, 118, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (439.962, 311.863, 72), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (394, -378.811, 72), (0, 160, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn_secondary", (384.111, -144.718, 72), (0, 208, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-86.718, -382.111, 201.75), (0, 118, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-502.424, 698.801, 154.5), (0, 270, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1409.43, -755.151, 376.25), (0, 152, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1503.38, -807.232, 376.25), (0, 106, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-1727.4, -801.313, 376.25), (0, 66, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_dom_spawn", (-2187.4, -919.313, 448.25), (0, 360, 0));
      break;
    case "war":
    case "conf":
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1603.1, -626.109, 332.5), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1609.1, -684.109, 332.5), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1552, -946.452, 284), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1486, -930.464, 284), (0, 66, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1005.43, -1174.02, 284), (0, 118, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (957.769, -1414.48, 284), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (889.769, -1418.48, 284), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (767.445, -1191.95, 284), (0, 62, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (377.427, -1406, 284), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (1478, -346.132, 72), (0, 90, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1253.88, 33.83, 194.5), (0, 128, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (1254.17, -57.8764, 194.5), (0, 238, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (897.889, 323.794, 72), (0, 198, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (887.908, 73.8263, 72), (0, 150, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (763.887, -369.226, 72), (0, 0, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (635.962, 67.8636, 72), (0, 118, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (439.962, 311.863, 72), (0, 180, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (394, -378.811, 72), (0, 160, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn_secondary", (384.111, -144.718, 72), (0, 208, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-86.718, -382.111, 201.75), (0, 118, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-502.424, 698.801, 154.5), (0, 270, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1409.43, -755.151, 376.25), (0, 152, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1503.38, -807.232, 376.25), (0, 106, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-1727.4, -801.313, 376.25), (0, 66, 0));
      var_0[var_0.size] = _id_0817::_id_4046("mp_tdm_spawn", (-2187.4, -919.313, 448.25), (0, 360, 0));
      break;
    case "koth":
      break;
    default:
      break;
  }

  _id_0817::_id_1127(var_0);
}