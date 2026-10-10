/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_49933f4f48d029a1.gsc
*************************************************/

#using script_27af1dac0930f28e;
#using scripts\engine\utility;
#namespace namespace_b9879d94296d26c8;

function function_1367788e05985a34() {
  level.ftuedata = spawnStruct();
  level.ftuedata.var_56e53e400a2d0f31 = ["kpop_eastern", 5];
  level.ftuedata.playerstartingposition = (20980, -7872, -400);
  level.ftuedata.var_9d94e563e4be46b8 = (357, 351, 0);
  level.ftuedata.var_396891c2565891d8 = "stand";
  level.ftuedata.playerstartingweapon = "iw9_pi_golf17_mp";
  level.ftuedata.var_7728a06c25a3f3d6 = 87;
  level.ftuedata.allystartingposition = (21080, -7944, -400);
  level.ftuedata.var_4192420425d287d1 = (0, 10, 0);
  level.ftuedata.var_8c5da83724fd450b = "crouch";
  level.ftuedata.circleposition = (23758, -7328, 4000);
  level.ftuedata.circleradius = 500000;
  level.ftuedata.var_744254a0a817ff39 = spawnStruct();
  level.ftuedata.var_744254a0a817ff39.sound = 1;
  level.ftuedata.var_f09f2ffd8a67fe03 = spawnStruct();
  level.ftuedata.var_f09f2ffd8a67fe03.sound = 1;
  level.ftuedata.var_3c5ef1ed040af91c = spawnStruct();
  level.ftuedata.var_3c5ef1ed040af91c.var_329c3ac67930d855 = 100;
  level.ftuedata.var_3c5ef1ed040af91c.zoffsetwaypoint = 45;
  level.ftuedata.var_3c5ef1ed040af91c.zoffsetobject = (0, 0, 10);
  level.ftuedata.var_3c5ef1ed040af91c.waypointicon = "mgl_ui_icon_ping_tacmap_enemy";
  level.ftuedata.var_3c5ef1ed040af91c.var_7520d86455f99294 = spawnscriptable("vfx_ftue_ring_2", (0, 0, 0));
  level.ftuedata.var_3c5ef1ed040af91c.var_8535c66bd370de4b = 0.75;
  level.ftuedata.var_49cab10caac7c6cd = spawnStruct();
  level.ftuedata.var_49cab10caac7c6cd.var_d9b20fb7b6b1ceed = 30;
  level.ftuedata.var_49cab10caac7c6cd.var_97c42731e7169654 = 3;
  level.ftuedata.walkstep = spawnStruct();
  level.ftuedata.walkstep.distancevalue = 15;
  level.ftuedata.walkstep.var_97c42731e7169654 = 3;
  level.ftuedata.var_b5799765f0103e33 = spawnStruct();
  level.ftuedata.var_b5799765f0103e33.var_b4651e34ae901b3e = 50;
  level.ftuedata.var_b5799765f0103e33.var_d9b20fb7b6b1ceed = 30;
  level.ftuedata.var_b5799765f0103e33.var_97c42731e7169654 = 3;
  level.ftuedata.movetoposition = spawnStruct();
  level.ftuedata.var_75e74a5148c1d441 = 200;
  level.ftuedata.movetoposition.positions = [];
  level.ftuedata.movetoposition.positions[0] = (21412, -7872, -365);
  level.ftuedata.movetoposition.positions[1] = (23298, -7951, -365);
  level.ftuedata.movetoposition.positions[2] = (24838, -7843, -363);
  level.ftuedata.movetoposition.positions[3] = (26712, -6141, -398);
  level.ftuedata.var_6c00d659b72888bf = spawnStruct();
  level.ftuedata.var_6c00d659b72888bf.var_62a3b08574578b5c = 120;
  level.ftuedata.var_6c00d659b72888bf.var_d2d2c2efeca7f10d = 15;
  level.ftuedata.var_6c00d659b72888bf.var_d651012a7700b7e = (21785, -7788, -410);
  level.ftuedata.var_6c00d659b72888bf.var_ed077719222ad193 = (0, 180, -10);
  level.ftuedata.var_6c00d659b72888bf.var_c2e05bd1d324f3d3 = "iw9_ar_mike4_mp";
  level.ftuedata.var_6c00d659b72888bf.var_3e64b0476403507a = "bar_ar_longhvy_p01_mike4+comp_ar_06_p01+grip_angled12+iw9_minireddot02_tall+iw9_rec_mike4+mag_ar_p01+pgrip_p01+stock_ar_p01_mike4";
  level.ftuedata.var_4b422fdc1b596ef9 = spawnStruct();
  level.ftuedata.var_4b422fdc1b596ef9.var_83d581980a9200f0 = 300;
  level.ftuedata.var_4b422fdc1b596ef9.var_bddb37f38f87a338 = (22132, -7965, -395);
  level.ftuedata.var_7f1eeec6d27ff97f = spawnStruct();
  level.ftuedata.var_7f1eeec6d27ff97f.var_9551ca6d0c161d7c = 0;
  level.ftuedata.reloadstep = spawnStruct();
  level.ftuedata.reloadstep.needtoreload = 1;
  level.ftuedata.var_4084605d5216bc12 = spawnStruct();
  level.ftuedata.var_4084605d5216bc12.var_c9746086dbdd302d = (22592, -7910, -364);
  level.ftuedata.adsstep = spawnStruct();
  level.ftuedata.adsstep.var_88a418affb89d5ea = 1;
  level.ftuedata.var_7931a9f93d82dd27 = spawnStruct();
  level.ftuedata.var_7931a9f93d82dd27.adsactive = 1;
  level.ftuedata.helisequence = spawnStruct();
  level.ftuedata.helisequence.spawnposition = (20689, -7315, 100);
  level.ftuedata.helisequence.spawnangles = (0, -110, 0);
  level.ftuedata.helisequence.var_db585b8134eed64c = [];
  pathstruct = spawnStruct();
  pathstruct.position = (27419, -8297, 300);
  pathstruct.speed = 50;
  pathstruct.acceleration = 100;
  pathstruct.yaw = 60;
  level.ftuedata.helisequence.var_db585b8134eed64c[0] = pathstruct;
  pathstruct = spawnStruct();
  pathstruct.position = (29800, -8169, 0);
  pathstruct.speed = 50;
  pathstruct.acceleration = 100;
  level.ftuedata.helisequence.var_db585b8134eed64c[1] = pathstruct;
  pathstruct = spawnStruct();
  pathstruct.position = (28412, -7268, -300);
  pathstruct.speed = 50;
  pathstruct.acceleration = 100;
  pathstruct.yaw = 185;
  level.ftuedata.helisequence.var_db585b8134eed64c[2] = pathstruct;
  level.ftuedata.helisequence.attackposition = (26842, -6050, 150);
  level.ftuedata.helisequence.crashposition = (26353, -5213, -250);
  level.ftuedata.var_6de4e8c345415ade = 1;
  level.ftuedata.wallsinfo = spawnStruct();
  level.ftuedata.wallsinfo.scriptables = [];
  level.ftuedata.wallsinfo.scriptables[#"192x256"] = "vfx_ftue_wall_1";
  level.ftuedata.wallsinfo.scriptables[#"192x256_temp"] = "vfx_ftue_wall_1_temp";
  level.ftuedata.wallsinfo.scriptables[#"64x256"] = "vfx_ftue_wall_1_64";
  level.ftuedata.walls = [];

  if(level.script == "mp_don3_mobile" || getdvarint(@ "hash_7bd8859e6b42b5d3", 0) == 1) {
    function_46039c03113f60c4("192x256", (21634, -8321, -424), (0, 90, 0), 3);
    function_46039c03113f60c4("192x256", (21634, -8321, -424), (0, 90, 0), 3);
    function_46039c03113f60c4("192x256", (21058, -8321, -424), (0, 45, 0), 1);
    function_46039c03113f60c4("192x256", (20922, -8185, -424), (0, 0, 0), 2);
    function_46039c03113f60c4("192x256", (20922, -7801, -424), (0, 300, 0), 2);
    function_46039c03113f60c4("192x256", (21180, -7576, -280), (0, 240, 0), 1);
    function_46039c03113f60c4("192x256", (21344, -7672, -280), (0, 270, 0), 2);
    function_46039c03113f60c4("64x256", (21724, -7680, -424), (0, 300, 0), 2);
    function_46039c03113f60c4("192x256", (22004, -7632, -292), (0, 270, 0), 1);
    function_46039c03113f60c4("192x256", (22192, -7632, -292), (0, 0, 0), 1);
    function_46039c03113f60c4("64x256", (22192, -7440, -292), (0, 0, 0), 1);
    function_46039c03113f60c4("192x256", (22104, -8080, -424), (0, 130, 0), 1);
    function_46039c03113f60c4("64x256", (22226, -8032, -424), (0, 111, 0), 2);
    function_46039c03113f60c4("64x256", (22304, -8028, -424), (0, 90, 0), 1);
    function_46039c03113f60c4("192x256", (22704, -8020, -424), (0, 92, 0), 2);
    function_46039c03113f60c4("192x256", (22704, -8212, -424), (0, 0, 0), 1);
    function_46039c03113f60c4("64x256", (22704, -8276, -424), (0, 0, 0), 1);
    function_46039c03113f60c4("64x256", (21236, -7532, -424), (0, 180, 0), 1);
    function_46039c03113f60c4("64x256", (21508, -7676, -424), (0, 270, 0), 1);
    function_46039c03113f60c4("192x256", (21812, -7632, -416), (0, 270, 0), 1);
    function_46039c03113f60c4("192x256", (22192, -7360, -416), (0, 0, 0), 1);
    function_46039c03113f60c4("192x256", (21952, -8192, -416), (0, 180, 0), 1);
    function_46039c03113f60c4("64x256", (22714, -8244, -416), (0, 0, 0), 1);
    function_46039c03113f60c4("192x256", (21768, -6886, -420), (0, 225, 0), 2);
    function_46039c03113f60c4("192x256", (22036, -7158, -420), (0, -90, 0), 14);
    function_46039c03113f60c4("192x256", (23936, -8258, -424), (0, 90, 0), 1);
    function_46039c03113f60c4("192x256", (25408, -8392, -424), (0, 90, 0), 1);
    function_46039c03113f60c4("192x256", (26050, -7188, -424), (0, 135, 0), 1);
    function_46039c03113f60c4("192x256", (26705, -6499, -442), (0, 135, 0), 1);
    function_46039c03113f60c4("192x256", (23096, -8316, -424), (0, 90, 0), 2);
    function_46039c03113f60c4("192x256", (23295.8, -8288, -424), (0, 55, 0), 1);
    function_46039c03113f60c4("192x256", (23138.5, -8178, -424), (0, 90, 0), 3);
    function_46039c03113f60c4("192x256", (24772, -8676, -424), (0, 90, 0), 3);
    function_46039c03113f60c4("192x256", (26064, -7888, -444), (0, 207, 0), 4);
    function_46039c03113f60c4("192x256", (25458, -6764, -434), (0, 315, 0), 1);
    function_46039c03113f60c4("192x256", (24956, -7289, -439), (0, 135, 0), 1);
    function_46039c03113f60c4("192x256", (25302, -7364, -439), (0, 45, 0), 1);
    function_46039c03113f60c4("192x256", (26139, -6275, -439), (0, 225, 0), 1);
    function_46039c03113f60c4("192x256", (26290, -6036, -450), (0, 315, 0), 3);
    function_46039c03113f60c4("192x256", (26694, -5632, -450), (0, 270, 0), 1);
    function_46039c03113f60c4("192x256", (26886, -5632, -450), (0, 225, 0), 3);
    function_46039c03113f60c4("192x256", (27294, -6040, -450), (0, 180, 0), 1);
    function_46039c03113f60c4("192x256", (27294, -6232, -450), (0, 135, 0), 3);
  }

  level.ftuedata.tempwalls = [];
  level.ftuedata.tempwalls["forward_lock_1"] = spawnStruct();
  level.ftuedata.tempwalls["forward_lock_1"].data = ["192x256_temp", (21872, -7650, -620), (0, 180, 0), 3];
  level.ftuedata.tempwalls["forward_lock_2"] = spawnStruct();
  level.ftuedata.tempwalls["forward_lock_2"].data = ["192x256_temp", (22860, -7168, -612), (0, 180, 0), 6];
  level.ftuedata.tempwalls["forward_lock_3"] = spawnStruct();
  level.ftuedata.tempwalls["forward_lock_3"].data = ["192x256_temp", (23572, -7160, -612), (0, 180, 0), 6];
  level.ftuedata.tempwalls["forward_lock_4"] = spawnStruct();
  level.ftuedata.tempwalls["forward_lock_4"].data = ["192x256_temp", (24818, -7302, -615), (0, 155, 0), 7];
  level.ftuedata.tempwalls["forward_lock_5"] = spawnStruct();
  level.ftuedata.tempwalls["forward_lock_5"].data = ["192x256_temp", (25336, -7344, -615), (0, 225, 0), 2];
  level.ftuedata.tempwalls["forward_lock_6"] = spawnStruct();
  level.ftuedata.tempwalls["forward_lock_6"].data = ["192x256_temp", (26066, -6434, -620), (0, 225, 0), 3];
  level.ftuedata.tempwalls["backward_lock_1"] = spawnStruct();
  level.ftuedata.tempwalls["backward_lock_1"].data = ["192x256", (22860, -8320, -424), (0, 0, 0), 6];
  level.ftuedata.tempwalls["backward_lock_2"] = spawnStruct();
  level.ftuedata.tempwalls["backward_lock_2"].data = ["192x256", (24224, -8264, -424), (0, 0, 0), 7];
  level.ftuedata.enablespawnvehicles = 1;
  level.ftuedata.vehicles = [];
  function_129481e19615e540(#"LittleBird_1", &namespace_9e27347da4069f42::function_7faf4fc46a309ce4, (28412, -7268, -300), (0, 0, 0), undefined, undefined, undefined, 1);

  if(level.script == "mp_don3_mobile") {
    function_129481e19615e540(#"atv_1", &namespace_9e27347da4069f42::function_1bc8a302d36b9ab8, (22976, -8112, -388), (0, 60, 0), 1);
    function_129481e19615e540(#"atv_2", &namespace_9e27347da4069f42::function_1bc8a302d36b9ab8, (23456, -7808, -404), (0, 330, 0), 1);
    function_129481e19615e540(#"cargo_1", &namespace_9e27347da4069f42::function_c446faece0456afc, (21095, -8009, -370), (0, 10, 0));
    function_129481e19615e540(#"cargo_2", &namespace_9e27347da4069f42::function_c446faece0456afc, (22587, -7751, -350), (0, 157, 0));
    function_129481e19615e540(#"suv_1", &namespace_9e27347da4069f42::function_9758acff14ae878e, (23248, -8136, -333), (0, 215, 0), 1);
    function_129481e19615e540(#"suv_2", &namespace_9e27347da4069f42::function_9758acff14ae878e, (23168, -7668, -333), (0, 40, 0));
    function_129481e19615e540(#"suv_3", &namespace_9e27347da4069f42::function_9758acff14ae878e, (25567, -8064, -333), (0, 66, 0));
  }

  level.ftuedata.var_9572c127e918050c = 1;
  level.ftuedata.var_a1c8c05e25923460 = spawnStruct();
  level.ftuedata.var_a1c8c05e25923460.scriptables = [];
  level.ftuedata.var_a1c8c05e25923460.scriptables[#"concrete_barrier"] = "barrier_traffic_concrete_block_01_yellow_ftue";
  level.ftuedata.var_a1c8c05e25923460.scriptables[#"hash_9cd8873e83556c93"] = "barrier_traffic_concrete_block_01_yellow_b_destr_ftue";
  level.ftuedata.var_a1c8c05e25923460.scriptables[#"wood_box_long"] = "ch_crate24x32x64_simple_ftue";
  level.ftuedata.var_e82a930c823a7b9c = [];

  if(level.script == "mp_don3_mobile") {
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["concrete_barrier", (21831, -7810, -421), (0, 19, 0)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["wood_box_long", (21789, -7782, -426), (0, 14, 0)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["wood_box_long", (22131, -7967, -420), (0, 316, 0)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["wood_box_long", (22125, -8013, -415), (0, 264, 0)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["wood_box_long", (22122, -8011, -391), (0, 280, 0)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["wood_box_long", (22158, -8001, -397), (81, 270, -104)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["wood_box_long", (22365, -7808, -426), (0, 340, 0)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["wood_box_long", (22353, -7806, -386), (90, 73, 80)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["wood_box_long", (22377, -7733, -400), (90, 115, -90)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["wood_box_long", (22395, -7711, -400), (90, 123, -90)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["wood_box_long", (22397, -7766, -400), (6, 59, 68)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["concrete_barrier", (25415, -8032, -382), (285, 123, 172)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["concrete_barrier", (24882, -7856, -422), (0, 11, 0)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["concrete_barrier", (25492, -7108, -420), (0, 80, 0)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["concrete_barrier", (25549, -7448, -416), (0, 62, -3)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["concrete_barrier", (25762, -7372, -416), (0, 50, 0)]);
    level.ftuedata.var_e82a930c823a7b9c = array_add(level.ftuedata.var_e82a930c823a7b9c, ["concrete_barrier", (26168, -6959, -443), (0, 35, 0)]);
  }

  level.ftuedata.soundevents = spawnStruct();
  level.ftuedata.soundevents.kill_confirm = #"hash_5a42d8453bf065e8";
  level.ftuedata.soundevents.moving = #"hash_78f1531eb8aae739";
  level.ftuedata.soundevents.moving_objective = #"hash_1330a8ba55edbbc5";
  level.ftuedata.soundevents.weapon_marked = #"hash_909422389702ed90";
  level.ftuedata.soundevents.ammo_marked = #"hash_878321fe4e1d8766";
  level.ftuedata.soundevents.taking_fire = #"hash_c1f89a7dbe07fe1c";
  level.ftuedata.soundevents.teammate_saved = #"hash_b515a03f8c292707";
  level.ftuedata.soundevents.close_call = #"hash_22fed4045771557a";
  level.ftuedata.soundevents.reloading = #"hash_768870e7b9ec0022";
  level.ftuedata.soundevents.armor_marked = #"hash_f0fc21356058387";
  level.ftuedata.soundevents.caution = #"hash_b9cd3b226369c308";
  level.ftuedata.soundevents.var_7005d00435a3568 = #"hash_64e2619145fd1d4e";
  level.ftuedata.soundevents.var_7006000435a3c01 = #"hash_cef9c1e457d7f24c";
  level.ftuedata.soundevents.var_7005f00435a39ce = #"hash_3ce04aed65d4df4f";
  level.ftuedata.soundevents.player_awesome = #"hash_14b8fbecb5931672";
  level.ftuedata.soundevents.help = #"hash_56ca3a1fc48f4f64";
  level.ftuedata.soundevents.on_me = #"hash_f4a387d815490431";
  level.ftuedata.soundevents.heli_incoming = #"hash_5b52cb164501b74b";
  level.ftuedata.soundevents.rpg = #"hash_ab565fa201eb95ce";
  level.ftuedata.soundevents.heli_destroyed = #"hash_8bc89623ff67607b";
  level.ftuedata.soundevents.var_2e6da450104bda0c = #"hash_c916df1b370de812";
  level.ftuedata.var_df53369f451f4139 = 1;
  level.ftuedata.var_212875d77b9905f5 = 1;
  level.ftuedata.botsinfo = spawnStruct();
  level.ftuedata.botsinfo.inactiveposition = (21860, -5043, -400);
  level.ftuedata.botsinfo.spawnedbots = 0;
  level.ftuedata.botsinfo.outlinedelay = 0.8;
  level.ftuedata.allybots = [];
  level.ftuedata.enemybots = [];
  var_dcc729e919264041 = spawnStruct();
  var_dcc729e919264041.spawnpriority = "high";
  var_dcc729e919264041.entranceonspawn = 1;
  var_dcc729e919264041.id = #"AllyBot_1";
  var_dcc729e919264041.name = "Nova";
  var_dcc729e919264041.team = "ally";
  var_dcc729e919264041.personality = "regular";
  var_dcc729e919264041.operatorref = ["nova_eastern", 9];
  var_dcc729e919264041.weapon = "iw9_ar_mike4_mp";
  var_dcc729e919264041.spawnposition = level.ftuedata.allystartingposition;
  var_dcc729e919264041.spawnrotation = level.ftuedata.var_4192420425d287d1;
  var_dcc729e919264041.destpositions = function_538ddd6b7c171d9d("AllyBot_1");
  level.ftuedata.allybots = function_ef848ae505edfa55(level.ftuedata.allybots, var_dcc729e919264041);
  var_f8e1d0734f4d40a2 = spawnStruct();
  var_f8e1d0734f4d40a2.spawnpriority = "high";
  var_f8e1d0734f4d40a2.entranceonspawn = 1;
  var_f8e1d0734f4d40a2.id = #"ExecuteBot_1";
  var_f8e1d0734f4d40a2.name = "Diego";
  var_f8e1d0734f4d40a2.team = "autoassign";
  var_f8e1d0734f4d40a2.personality = "recruit";
  var_f8e1d0734f4d40a2.operatorref = ["milsim_eastern_1", 18];
  var_f8e1d0734f4d40a2.weapon = "iw9_ar_mike4_mp";
  var_f8e1d0734f4d40a2.spawnposition = (21241, -7899, -365);
  var_f8e1d0734f4d40a2.spawnrotation = (0, 15, 0);
  var_f8e1d0734f4d40a2.destpositions = function_538ddd6b7c171d9d("ExecuteBot_1");
  var_f8e1d0734f4d40a2.disableoutline = 1;
  level.ftuedata.enemybots = function_ef848ae505edfa55(level.ftuedata.enemybots, var_f8e1d0734f4d40a2);
  var_520720762445c397 = spawnStruct();
  var_520720762445c397.spawnpriority = "high";
  var_520720762445c397.id = #"AutoShootBot_1";
  var_520720762445c397.name = "Fernando";
  var_520720762445c397.team = "autoassign";
  var_520720762445c397.personality = "recruit";
  var_520720762445c397.operatorref = ["milsim_eastern_1", 18];
  var_520720762445c397.weapon = "iw9_ar_mike4_mp";
  var_520720762445c397.spawnposition = (22823, -8098, -376);
  var_520720762445c397.spawnrotation = undefined;
  var_520720762445c397.destpositions = function_538ddd6b7c171d9d("AutoShootBot_1");
  var_520720762445c397.var_d676e6af83f5eb14 = undefined;
  var_520720762445c397.shootenabled = 1;
  var_520720762445c397.shoottarget = "AllyBot_1";
  var_520720762445c397.var_4165728871d6465c = 0;
  level.ftuedata.enemybots = function_ef848ae505edfa55(level.ftuedata.enemybots, var_520720762445c397);
  var_e5a621404b970f2b = spawnStruct();
  var_e5a621404b970f2b.spawnpriority = "mid";
  var_e5a621404b970f2b.id = #"ADSBot_1";
  var_e5a621404b970f2b.name = "Miguel";
  var_e5a621404b970f2b.team = "autoassign";
  var_e5a621404b970f2b.personality = "recruit";
  var_e5a621404b970f2b.operatorref = ["milsim_eastern_1", 18];
  var_e5a621404b970f2b.weapon = "iw9_ar_mike4_mp";
  var_e5a621404b970f2b.spawnposition = (24284, -8368, -358);
  var_e5a621404b970f2b.spawnrotation = undefined;
  var_e5a621404b970f2b.destpositions = function_538ddd6b7c171d9d("ADSBot_1");
  var_e5a621404b970f2b.var_d676e6af83f5eb14 = (23000, -7133, 4000);
  var_e5a621404b970f2b.shootenabled = 1;
  var_e5a621404b970f2b.shoottarget = "Player";
  var_e5a621404b970f2b.var_4165728871d6465c = 0;
  level.ftuedata.enemybots = function_ef848ae505edfa55(level.ftuedata.enemybots, var_e5a621404b970f2b);
  var_5f0794ac6f9f6b74 = spawnStruct();
  var_5f0794ac6f9f6b74.spawnpriority = "mid";
  var_5f0794ac6f9f6b74.id = #"ADSBot_2";
  var_5f0794ac6f9f6b74.name = "Andres";
  var_5f0794ac6f9f6b74.team = "autoassign";
  var_5f0794ac6f9f6b74.personality = "recruit";
  var_5f0794ac6f9f6b74.operatorref = ["milsim_eastern_1", 18];
  var_5f0794ac6f9f6b74.weapon = "iw9_ar_mike4_mp";
  var_5f0794ac6f9f6b74.spawnposition = (24587, -7736, -358);
  var_5f0794ac6f9f6b74.spawnrotation = undefined;
  var_5f0794ac6f9f6b74.destpositions = function_538ddd6b7c171d9d("ADSBot_2");
  var_5f0794ac6f9f6b74.var_d676e6af83f5eb14 = (23000, -7133, 4000);
  var_5f0794ac6f9f6b74.shootenabled = 1;
  var_5f0794ac6f9f6b74.shoottarget = "AllyBot_1";
  var_5f0794ac6f9f6b74.var_4165728871d6465c = 0;
  level.ftuedata.enemybots = function_ef848ae505edfa55(level.ftuedata.enemybots, var_5f0794ac6f9f6b74);
  var_59e47b1bee4bc158 = spawnStruct();
  var_59e47b1bee4bc158.spawnpriority = "mid";
  var_59e47b1bee4bc158.id = #"ManualShootBot_1";
  var_59e47b1bee4bc158.name = "Gomez";
  var_59e47b1bee4bc158.team = "autoassign";
  var_59e47b1bee4bc158.personality = "recruit";
  var_59e47b1bee4bc158.operatorref = ["milsim_eastern_1", 18];
  var_59e47b1bee4bc158.weapon = "iw9_ar_mike4_mp";
  var_59e47b1bee4bc158.spawnposition = (25699, -8107, -341);
  var_59e47b1bee4bc158.spawnrotation = undefined;
  var_59e47b1bee4bc158.destpositions = function_538ddd6b7c171d9d("ManualShootBot_1");
  var_59e47b1bee4bc158.var_d676e6af83f5eb14 = (28575, -7916, 4050);
  var_59e47b1bee4bc158.shootenabled = 1;
  var_59e47b1bee4bc158.shoottarget = "AllyBot_1";
  var_59e47b1bee4bc158.var_4165728871d6465c = 0;
  level.ftuedata.enemybots = function_ef848ae505edfa55(level.ftuedata.enemybots, var_59e47b1bee4bc158);
  var_404f450a04e51af = spawnStruct();
  var_404f450a04e51af.spawnpriority = "mid";
  var_404f450a04e51af.id = #"ManualShootBot_2";
  var_404f450a04e51af.name = "Anton";
  var_404f450a04e51af.team = "autoassign";
  var_404f450a04e51af.personality = "recruit";
  var_404f450a04e51af.operatorref = ["milsim_eastern_1", 18];
  var_404f450a04e51af.weapon = "iw9_ar_mike4_mp";
  var_404f450a04e51af.spawnposition = (25699, -8107, -341);
  var_404f450a04e51af.spawnrotation = undefined;
  var_404f450a04e51af.destpositions = function_538ddd6b7c171d9d("ManualShootBot_2");
  var_404f450a04e51af.entrancestyle = "shooting";
  var_404f450a04e51af.var_d676e6af83f5eb14 = (28575, -7916, 4050);
  var_404f450a04e51af.shootenabled = 1;
  var_404f450a04e51af.shoottarget = "Player";
  var_404f450a04e51af.var_4165728871d6465c = 0;
  level.ftuedata.enemybots = function_ef848ae505edfa55(level.ftuedata.enemybots, var_404f450a04e51af);
  var_eeebce83ecdef6d1 = spawnStruct();
  var_eeebce83ecdef6d1.spawnpriority = "mid";
  var_eeebce83ecdef6d1.id = #"FinalCombatBot_1";
  var_eeebce83ecdef6d1.name = "Hernando";
  var_eeebce83ecdef6d1.team = "autoassign";
  var_eeebce83ecdef6d1.personality = "recruit";
  var_eeebce83ecdef6d1.operatorref = ["milsim_eastern_1", 18];
  var_eeebce83ecdef6d1.weapon = "iw9_ar_mike4_mp";
  var_eeebce83ecdef6d1.spawnposition = (25500, -6770, -392);
  var_eeebce83ecdef6d1.spawnrotation = undefined;
  var_eeebce83ecdef6d1.destpositions = function_538ddd6b7c171d9d("FinalCombatBot_1");
  var_eeebce83ecdef6d1.var_d676e6af83f5eb14 = (26944, -5897, 664);
  var_eeebce83ecdef6d1.shootenabled = 1;
  var_eeebce83ecdef6d1.shoottarget = "Player";
  var_eeebce83ecdef6d1.var_4165728871d6465c = 1;
  level.ftuedata.enemybots = function_ef848ae505edfa55(level.ftuedata.enemybots, var_eeebce83ecdef6d1);
  var_8f46bf0dcf156a6 = spawnStruct();
  var_8f46bf0dcf156a6.spawnpriority = "mid";
  var_8f46bf0dcf156a6.id = #"FinalCombatBot_2";
  var_8f46bf0dcf156a6.name = "Juan";
  var_8f46bf0dcf156a6.team = "autoassign";
  var_8f46bf0dcf156a6.personality = "recruit";
  var_8f46bf0dcf156a6.operatorref = ["milsim_eastern_1", 18];
  var_8f46bf0dcf156a6.weapon = "iw9_ar_mike4_mp";
  var_8f46bf0dcf156a6.spawnposition = (25500, -6770, -392);
  var_8f46bf0dcf156a6.spawnrotation = undefined;
  var_8f46bf0dcf156a6.destpositions = function_538ddd6b7c171d9d("FinalCombatBot_2");
  var_8f46bf0dcf156a6.entrancestyle = "shooting";
  var_8f46bf0dcf156a6.var_d676e6af83f5eb14 = (26944, -5897, 664);
  var_8f46bf0dcf156a6.shootenabled = 1;
  var_8f46bf0dcf156a6.shoottarget = "AllyBot_1";
  var_8f46bf0dcf156a6.var_4165728871d6465c = 1;
  level.ftuedata.enemybots = function_ef848ae505edfa55(level.ftuedata.enemybots, var_8f46bf0dcf156a6);
  var_f807c045bf8ed217 = spawnStruct();
  var_f807c045bf8ed217.spawnpriority = "mid";
  var_f807c045bf8ed217.id = #"FinalCombatBot_3";
  var_f807c045bf8ed217.name = "Martin";
  var_f807c045bf8ed217.team = "autoassign";
  var_f807c045bf8ed217.personality = "recruit";
  var_f807c045bf8ed217.operatorref = ["milsim_eastern_1", 18];
  var_f807c045bf8ed217.weapon = "iw9_ar_mike4_mp";
  var_f807c045bf8ed217.spawnposition = (26276, -6880, -392);
  var_f807c045bf8ed217.spawnrotation = undefined;
  var_f807c045bf8ed217.destpositions = function_538ddd6b7c171d9d("FinalCombatBot_3");
  var_f807c045bf8ed217.var_d676e6af83f5eb14 = (26944, -5897, 664);
  var_f807c045bf8ed217.entrancestyle = "shooting";
  var_f807c045bf8ed217.shootenabled = 1;
  var_f807c045bf8ed217.shoottarget = "AllyBot_1";
  var_f807c045bf8ed217.var_4165728871d6465c = 1;
  level.ftuedata.enemybots = function_ef848ae505edfa55(level.ftuedata.enemybots, var_f807c045bf8ed217);
  var_30000c5d18adc444 = spawnStruct();
  var_30000c5d18adc444.spawnpriority = "mid";
  var_30000c5d18adc444.id = #"FinalCombatBot_4";
  var_30000c5d18adc444.name = "Ocacio";
  var_30000c5d18adc444.team = "autoassign";
  var_30000c5d18adc444.personality = "recruit";
  var_30000c5d18adc444.operatorref = ["milsim_eastern_1", 18];
  var_30000c5d18adc444.weapon = "iw9_ar_mike4_mp";
  var_30000c5d18adc444.spawnposition = (26276, -6880, -392);
  var_30000c5d18adc444.spawnrotation = undefined;
  var_30000c5d18adc444.destpositions = function_538ddd6b7c171d9d("FinalCombatBot_4");
  var_30000c5d18adc444.var_d676e6af83f5eb14 = (26944, -5897, 664);
  var_30000c5d18adc444.shootenabled = 1;
  var_30000c5d18adc444.shoottarget = "Player";
  var_30000c5d18adc444.var_4165728871d6465c = 1;
  level.ftuedata.enemybots = function_ef848ae505edfa55(level.ftuedata.enemybots, var_30000c5d18adc444);
  var_3c589bf5c00c8f65 = spawnStruct();
  var_3c589bf5c00c8f65.spawnpriority = "low";
  var_3c589bf5c00c8f65.id = #"hash_5fc34f1381859d7c";
  var_3c589bf5c00c8f65.name = "Nicolao";
  var_3c589bf5c00c8f65.team = "autoassign";
  var_3c589bf5c00c8f65.personality = "recruit";
  var_3c589bf5c00c8f65.operatorref = ["milsim_eastern_1", 18];
  var_3c589bf5c00c8f65.weapon = "iw9_ar_mike4_mp";
  var_3c589bf5c00c8f65.spawnposition = (27908, -7507, -379);
  var_3c589bf5c00c8f65.disableoutline = 1;
  level.ftuedata.enemybots = function_ef848ae505edfa55(level.ftuedata.enemybots, var_3c589bf5c00c8f65);
  var_62c72b082bbcbfa = spawnStruct();
  var_62c72b082bbcbfa.spawnpriority = "low";
  var_62c72b082bbcbfa.id = #"hash_5fc352138185a295";
  var_62c72b082bbcbfa.name = "Felipe";
  var_62c72b082bbcbfa.team = "autoassign";
  var_62c72b082bbcbfa.personality = "recruit";
  var_62c72b082bbcbfa.operatorref = ["milsim_eastern_1", 18];
  var_62c72b082bbcbfa.weapon = "iw9_ar_mike4_mp";
  var_62c72b082bbcbfa.spawnposition = (27908, -7507, -379);
  var_62c72b082bbcbfa.disableoutline = 1;
  level.ftuedata.enemybots = function_ef848ae505edfa55(level.ftuedata.enemybots, var_62c72b082bbcbfa);
  var_dbae0db22158b7eb = spawnStruct();
  var_dbae0db22158b7eb.spawnpriority = "low";
  var_dbae0db22158b7eb.id = #"hash_f81a4b6389fb8e3a";
  var_dbae0db22158b7eb.name = "Maestre";
  var_dbae0db22158b7eb.team = "autoassign";
  var_dbae0db22158b7eb.personality = "recruit";
  var_dbae0db22158b7eb.operatorref = ["milsim_eastern_1", 18];
  var_dbae0db22158b7eb.weapon = "iw9_ar_mike4_mp";
  var_dbae0db22158b7eb.spawnposition = (25699, -8107, -341);
  level.ftuedata.enemybots = function_ef848ae505edfa55(level.ftuedata.enemybots, var_dbae0db22158b7eb);
  level.ftuedata.enemygroups = spawnStruct();
  level.ftuedata.enemygroups.autofire = ["AutoShootBot_1"];
  level.ftuedata.enemygroups.ads = ["ADSBot_1", "ADSBot_2"];
  level.ftuedata.enemygroups.manualfire = ["ManualShootBot_1", "ManualShootBot_2"];
  level.ftuedata.enemygroups.combat = [];
  level.ftuedata.enemygroups.combat[0] = ["FinalCombatBot_1", "FinalCombatBot_2"];
  level.ftuedata.enemygroups.combat[1] = ["FinalCombatBot_3", "FinalCombatBot_4"];
}

function private function_129481e19615e540(id, spawnfunction, spawnposition, spawnrotation, spawndestroyed, initialdamage, vfxdata, engineturnedon) {
  if(!isDefined(id) || !isDefined(spawnfunction) || !isDefined(spawnposition) || !isDefined(spawnrotation)) {
    return;
  }

  level.ftuedata.vehicles[id] = spawnStruct();
  level.ftuedata.vehicles[id].spawnfunction = spawnfunction;
  level.ftuedata.vehicles[id].spawnposition = spawnposition;
  level.ftuedata.vehicles[id].spawnrotation = spawnrotation;
  level.ftuedata.vehicles[id].initialdamage = initialdamage;

  if(isDefined(spawndestroyed)) {
    level.ftuedata.vehicles[id].spawndestroyed = spawndestroyed;
  }

  if(isDefined(initialdamage)) {
    level.ftuedata.vehicles[id].initialdamage = initialdamage;
  }

  if(isDefined(vfxdata)) {
    level.ftuedata.vehicles[id].vfxdata = vfxdata;
  }

  if(isDefined(engineturnedon)) {
    level.ftuedata.vehicles[id].engineturnedon = engineturnedon;
  }
}

function private function_ef848ae505edfa55(var_2857a3996fb3fa53, botdata) {
  if(!isDefined(var_2857a3996fb3fa53) || !isDefined(botdata) || !isDefined(botdata.id) || !isDefined(botdata.name) || !isDefined(botdata.personality) || !isDefined(botdata.operatorref) || !isDefined(botdata.weapon) || !isDefined(botdata.spawnposition)) {
    println("<dev string:x1c>");
    return;
  }

  var_2857a3996fb3fa53[botdata.id] = botdata;
  return var_2857a3996fb3fa53;
}

function private function_46039c03113f60c4(model, position, rotation, instances) {
  level.ftuedata.walls = array_add(level.ftuedata.walls, [model, position, rotation, instances]);
}

function private function_538ddd6b7c171d9d(id) {
  destpositions = [];

  switch (id) {
    case #"hash_46f2e5a2ee89ad68":
      destpositions["MOVE_TO_STEP"] = [(21568, -7925, -363), "Player", "stand"];
      destpositions["TAKE_WEAPON_STEP"] = [(21782, -7846, -381), "Player", "crouch"];
      destpositions["TAKE_AMMO_STEP_1"] = [(22129, -7840, -375), (22308, -7978, -426), "stand"];
      destpositions["TAKE_AMMO_STEP_2"] = [(22308, -7978, -426), (22831, -7816, -364), "stand"];
      destpositions["AUTO_FIRE_STEP"] = [(22322, -7796, -375), (22287, -8003, -375), "crouch"];
      destpositions["TAKE_ARMOR_STEP"] = [(22640, -7874, -366), (23438, -8023, -358), "stand"];
      destpositions["ADS_STEP"] = [(23438, -8023, -358), (24587, -7736, -358), "stand"];
      destpositions["ADS_COMBAT_STEP"] = [(23744, -7685, -365), undefined, "stand"];
      destpositions["MANUAL_COMBAT_STEP"] = [(24860, -7892, -363), (25699, -8107, -341), "stand"];
      destpositions["FINAL_COMBAT_STEP"] = [(25452, -7528, -420), (26944, -5897, 664), "stand"];
      destpositions["RPG_STEP"] = [(26005, -6936, -387), undefined, "stand"];
      destpositions["EXTRACTION_STEP"] = [(26517, -6256, -395), "Player", "stand"];
      break;
    case #"hash_e3503b315bb9daad":
      destpositions["DEFAULT"] = [(21204, -7912, -365), undefined, "stand"];
      break;
    case #"hash_7d264f708f627646":
      destpositions["DEFAULT"] = [(22622, -7876, -364), "AllyBot_1", "stand"];
      break;
    case #"hash_a0446975e35c8a72":
      destpositions["DEFAULT"] = [(24247, -7989, -365), "Player", "stand"];
      break;
    case #"hash_a0446875e35c88df":
      destpositions["DEFAULT"] = [(24111, -7762, -371), "AllyBot_1", "stand"];
      break;
    case #"hash_30c0053027d3ee93":
      destpositions["DEFAULT"] = [(25509, -7610, -357), "AllyBot_1", "stand"];
      break;
    case #"hash_30c0063027d3f026":
      destpositions["DEFAULT"] = [(25568, -8134, -358), "Player", "stand"];
      break;
    case #"hash_ff4b5ec74f0a4cd0":
      destpositions["DEFAULT"] = [(25630, -6996, -368), "Player", "stand"];
      break;
    case #"hash_ff4b61c74f0a5189":
      destpositions["DEFAULT"] = [(25795, -7287, -362), "AllyBot_1", "stand"];
      break;
    case #"hash_ff4b60c74f0a4ff6":
      destpositions["DEFAULT"] = [(26079, -6863, -391), "AllyBot_1", "stand"];
      break;
    case #"hash_ff4b63c74f0a54af":
      destpositions["DEFAULT"] = [(25814, -6735, -382), "Player", "stand"];
      break;
    default:
      println("<dev string:x6b>");
      break;
  }

  return destpositions;
}