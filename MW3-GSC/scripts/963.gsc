/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\963.gsc
**************************************/

main() {
  common_scripts\utility::flag_init("start_sinking");
  common_scripts\utility::flag_init("russian_sub_spawned");
  common_scripts\utility::flag_init("fx_player_surfaced");
  common_scripts\utility::flag_init("detonate_torpedo");
  common_scripts\utility::flag_init("fx_chinook_screen_watersplash");
  common_scripts\utility::flag_init("sub_surface_rumble");
  common_scripts\utility::flag_init("trigger_vfx_pipe_burst");
  common_scripts\utility::flag_init("trigger_vfx_pipe_burst_cr");
  common_scripts\utility::flag_init("trigger_vfx_pipe_burst_mr");
  common_scripts\utility::flag_init("flag_ship_splode_1_fx");
  common_scripts\utility::flag_init("flag_ship_splode_2_fx");
  common_scripts\utility::flag_init("flag_ship_splode_3_fx");
  common_scripts\utility::flag_init("flag_ship_splode_4_fx");
  common_scripts\utility::flag_init("flag_ship_splode_5_fx");
  common_scripts\utility::flag_init("flag_ship_splode_6_fx");
  common_scripts\utility::flag_init("flag_destroyer_fx");
  common_scripts\utility::flag_init("msg_fx_under_docks");
  _id_4743();
  thread precachefx();
  thread _id_4780();
  _id_4A37::main();
  maps\_shg_fx::_id_4445();
  thread maps\_shg_fx::_id_4456();
  thread _id_4AAD();
  thread _id_4AAF();
  thread _id_4AAE();
  thread _id_4AC4();
  thread _id_4A3D();
  thread _id_4A7E();
  thread _id_4A6B();
  thread _id_4A6C();
  thread _id_4A7F();
  thread _id_4A88();
  thread _id_4A89();
  thread _id_4A8A();
  thread _id_4A93();
  thread _id_4A8B();
  thread _id_4A8C();
  thread _id_4A92();
  thread _id_4A96();
  thread _id_4A8D();
  thread _id_4A90();
  thread _id_4A99();
  thread _id_4A97();
  thread _id_4A67();
  thread _id_4A4A();
  thread _id_4A44();
  thread _id_4A3E();
  thread _id_4A42();
  thread _id_4A4E();
  thread _id_477E();
  thread _id_4AA0();
  thread _id_4770();
  thread _id_4A40();
  thread _id_4A41();
  level thread _id_4A3A();
  level thread _id_4A3B();
  level thread _id_4A3C();
  thread _id_4AB7();
  thread _id_4A58();
  thread _id_4ABB();
  thread _id_4ABD();
  thread _id_4AC2();
  thread _id_4AC8();
  thread _id_4ACA();
  thread _id_4ACC();
  thread _id_4ACD();
  thread _id_4ACE();
  thread _id_4ACF();
  thread _id_4AD2();
  thread maps\_shg_fx::_id_445E(1000, "msg_vfx_tunnel_a", "msg_vfx_tunnel_b");
  thread maps\_shg_fx::_id_445E(1500, "msg_vfx_tunnel_b");
  thread maps\_shg_fx::_id_445E(1600, "msg_vfx_tunnel_a");
  thread maps\_shg_fx::_id_445E(2000, "msg_vfx_udrwtr_a");
  thread maps\_shg_fx::_id_445E(3000, "msg_vfx_udrwtr_b");
  thread maps\_shg_fx::_id_445E(4000, "msg_vfx_udrwtr_c");
  thread maps\_shg_fx::_id_445E(5000, "msg_vfx_sub_interior_a");
  thread maps\_shg_fx::_id_445E(5100, "msg_vfx_sub_interior_a1");
  thread maps\_shg_fx::_id_445E(5200, "msg_vfx_sub_interior_a2");
  thread maps\_shg_fx::_id_445E(5300, "msg_vfx_sub_interior_a3");
  thread maps\_shg_fx::_id_445E(260, "msg_vfx_sub_interior_red_light_pulse");
  thread maps\_shg_fx::_id_445E(5400, "msg_vfx_sub_interior_a4");
  thread maps\_shg_fx::_id_445E(5500, "msg_vfx_sub_interior_a5");
  thread maps\_shg_fx::_id_445E(6000, "msg_vfx_sub_interior_b");
  thread maps\_shg_fx::_id_445E(6050, "msg_vfx_sub_interior_b0");
  thread maps\_shg_fx::_id_445E(6100, "msg_vfx_sub_interior_b1");
  thread maps\_shg_fx::_id_445E(6200, "msg_vfx_sub_interior_b2");
  thread maps\_shg_fx::_id_445E(6500, "msg_vfx_sub_interior_c");
  thread maps\_shg_fx::_id_445E(20000, "msg_vfx_surface_zone_20000", "msg_vfx_surface_zone_20000", "msg_vfx_sub_interior_minus_25000");
  thread maps\_shg_fx::_id_445E(21000, "msg_vfx_surface_zone_21000", "msg_vfx_surface_zone_21000", "msg_vfx_sub_interior_minus_25000");
  thread maps\_shg_fx::_id_445E(22000, "msg_vfx_surface_zone_22000", "msg_vfx_surface_zone_22000", "msg_vfx_sub_interior_minus_25000");
  thread maps\_shg_fx::_id_445E(23000, "msg_vfx_surface_zone_23000", "msg_vfx_surface_zone_23000", "msg_vfx_sub_interior_minus_25000");
  thread maps\_shg_fx::_id_445E(25000, "msg_vfx_surface_zone_25000", "msg_vfx_surface_zone_25000", "msg_vfx_sub_interior_minus_25000");
  thread maps\_shg_fx::_id_445F(25001, "msg_vfx_surface_zone_25000", "sub_breach_finished");
  thread maps\_shg_fx::_id_445E(26000, "msg_vfx_surface_zone_26000");
}

_id_4743() {
  setsaveddvar("sm_spotlimit", 1);
  setsaveddvar("sm_sunshadowscale", 0.85);
  setsaveddvar("sm_sunsamplesizenear", 0.25);
  setsaveddvar("fx_alphathreshold", 11);
}

_id_4A38() {
  level endon("msg_nyharbor_stoplandexplosions");
  wait 10.0;
  var_0 = [(-23478, -7706, 2923), (-22185, -8779, 2180), (-23378, -6212, 5748), (-23424, -6366, 7314), (-19972, -9802, 5410), (-20379, -10371, 4822), (-20035, -10621, 5546), (-15733, -13971, 3326), (-15685, -14066, 4087), (-14732, -11701, 5727), (-15379, -14279, 4894), (-15221, -14225, 6551), (-15507, -13927, 7272), (-15628, -13548, 7604), (-15548, -14034, 8099), (-14356, -14567, 4206), (-14039, -14379, 3792), (-10906, -12809, 1927), (-25745, -10676, 1154), (-11855, -17013, 87), (-17644, -14389, 59), (-40405, -20724, 47), (-39551, -14037, 1154), (3869, -55407, 2641), (-591, -58842, 2617), (-14109, -27253, 727), (-16280, -26991, 559), (-12941, -60922, 1411), (-17831, -11150, 5230), (-37800, -14379, 749), (-36001, -14058, 1100), (-28545, -9132, 767), (6874, -30979, 1168), (-11626, -27742, 750)];
  thread maps\_shg_fx::_id_4454(700, "smoke_geotrail_genericexplosion", 7, 500, 2000, 10, 30, 200, 75, 1200);
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = level.player getorigin();
  var_1.angles = (270, 0, -45);
  var_2 = [];
  var_3 = maps\_shg_fx::_id_446A(700);
  wait 1.0;

  for(;;) {
    common_scripts\utility::flag_waitopen("msg_vfx_sub_interior_minus_25000");
    var_4 = level.player getplayerangles();
    var_5 = vectornormalize(anglesToForward(var_4));
    var_6 = -1;
    var_7 = [];

    for(var_8 = 0; var_8 < var_0.size; var_8++) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_9 = vectornormalize(var_0[var_8] - level.player.origin);

      if(vectordot(var_5, var_9) > 0.45) {
        var_6 = 1;
        var_7[var_7.size] = var_0[var_8];
      }
    }

    if(var_6 > 0) {
      var_10 = randomint(var_7.size + 1);

      if(isDefined(var_10)) {
        var_11 = var_7[var_10];

        if(isDefined(var_3) && isDefined(var_11)) {
          var_3.v["origin"] = var_11;
          common_scripts\utility::exploder(700);
          maps\_audio::aud_send_msg("land_explosion", var_11);
        }
      }
    }

    wait 2.0;
  }
}

_id_4A39() {
  level endon("msg_nyharbor_stopwaterexplosions");
  level endon("switch_chinook");
  wait 1.0;
  var_0 = [(-16078.9, -21985.4, -200), (-16816.5, -20880.9, -200), (-18183.6, -18682.9, -200), (-18336.6, -22499, -200), (-19216.4, -24298.5, -200), (-20321.3, -23572.2, -200), (-20265.5, -25595.6, -200), (-20735.7, -27581.2, -200), (-22218.2, -27296.4, -200), (-19044.7, -27895.1, -200), (-18075.8, -29197.2, -200), (-17744, -30302.6, -200), (-17999.4, -28065.1, -200), (-16754.2, -24812.2, -200), (-15567.5, -21403.1, -200), (-20567.9, -22634.9, -200), (-22419.9, -22541.9, -200), (-23146.1, -22028.9, -200), (-25366.4, -21724.8, -200), (-25043.7, -17634.6, -200), (-25993.9, -18138.5, -200), (-26250.4, -15147.6, -200), (-25659.9, -14375.8, -200), (-23713.3, -13311.5, -200), (-22780.3, -13618.7, -200), (-21478, -14437.1, -200), (-22617.4, -14448.8, -200), (-23806.5, -14948.8, -200), (-23644.5, -15660.2, -200), (-28572.1, -13679.3, -200), (-28228.2, -12692.6, -200), (-27916.6, -12271.2, -200), (-29142.7, -12614.8, -200), (-28393.1, -13857.3, -200), (-31218.2, -10518.2, -200), (-32947.7, -9691.9, -200), (-33643.6, -8825.27, -200), (-33621, -7460.5, -200), (-32622.4, -7111.54, -200), (-35627.4, -7209.94, -200), (-35884.1, -6679.09, -200), (-36072.6, -5718.29, -200), (-35921.5, -4673.62, -200), (-35050.2, -4831.81, -200), (-35889.1, -5455.13, -200), (-38852.8, -5039.36, -200), (-40430.3, -4731.15, -200), (-40006.1, -5136.87, -200), (-41720, -6428.87, -200), (-42289.9, -6732.02, -200), (-42919, -7569.04, -200), (-43737.6, -7743.24, -200), (-44748.6, -7912.62, -200), (-45201.1, -8196.11, -200), (-43944.9, -9585.19, -200), (-45505.2, -10311.4, -200), (-45846.5, -10420.5, -200), (-46029.4, -10493.4, -200), (-47543.1, -11105.5, -200), (-47441.8, -11546.2, -200), (-47907.2, -13315.8, -200), (-49340.5, -13184.8, -200), (-49846.9, -13546.4, -200), (-49886.7, -13569.9, -200), (-50055.7, -13249.7, -200), (-50757.5, -11968.9, -200), (-51311.7, -11834.3, -200), (-52190.5, -12655.5, -200), (-52377.9, -13990.1, -200), (-51499.3, -14423, -200), (-51421, -14657.3, -200), (-52251.8, -16500.2, -200), (-52368.3, -16925.9, -200), (-52242.7, -16851.7, -200), (-51244.4, -17150.9, -200), (-50379.3, -17859.9, -200), (-50120.7, -18476.7, -200), (-44681.9, -17448.3, -200), (-43879.6, -17154.6, -200), (-43479.3, -16726, -200), (-43063.4, -15127.9, -200), (-42987.8, -15359.1, -200), (-42286.2, -16393.4, -200), (-41453.7, -17380.7, -200), (-41378.6, -17010.7, -200), (-41172.4, -15877.7, -200), (-40568, -16025.7, -200), (-40032.1, -17036.5, -200), (-40066.7, -17954.3, -200), (-41229.4, -18365.4, -200), (-42487, -18963, -200), (-33784.9, -22706.5, -200), (-32928.3, -24092.6, -200), (-32805.7, -25060.2, -200), (-32799.6, -25218.4, -200), (-32935.9, -25547.7, -200), (-33131.7, -26361, -200), (-33144.1, -26924.8, -200), (-32960.4, -27469.7, -200), (-32737.9, -28466.1, -200), (-32683.1, -28446, -200), (-32341.5, -28929.9, -200), (-31640.9, -30358.7, -200), (-31188.3, -31317.3, -200), (-31032.7, -31237.5, -200), (-29785.7, -30629.1, -200), (-28250.7, -31535.6, -200), (-28246.9, -31948.5, -200), (-28254.1, -31957, -200), (-28467.5, -32222.5, -200), (-28823.8, -32628.9, -200), (-29495.3, -33378.9, -200), (-29826.3, -33751.8, -200), (-29825.5, -33746.4, -200), (-29844.5, -33592, -200), (-30582.3, -32543.2, -200), (-31548.1, -32468, -200), (-32419.6, -32942.7, -200), (-32867, -33544.2, -200), (-33027.8, -34026.5, -200), (-32915.2, -34432, -200), (-32707.8, -34600.1, -200), (-32052.9, -34652.6, -200), (-31514.5, -34655.9, -200), (-30548.6, -34693.2, -200), (-29892.7, -34738.4, -200), (-28809.5, -34828.7, -200), (-26584.5, -34816.2, -200), (-25628.3, -34667.6, -200), (-25157.4, -34594, -200), (-24945.2, -34813.7, -200), (-24756, -35644.5, -200), (-24775, -37517, -200), (-25791.8, -38224.2, -200), (-28097.7, -38460.5, -200), (-29101.6, -38226.6, -200), (-29863.8, -37763.9, -200), (-30215.2, -37246.5, -200), (-30520.7, -36707.9, -200), (-31239.8, -35961.7, -200), (-31839.2, -35612.7, -200), (-32567.1, -35535.9, -200), (-33042.2, -35873.3, -200), (-33576.7, -36402.1, -200), (-34468, -37275.5, -200), (-35055.7, -38052.1, -200), (-35065.8, -38466.1, -200), (-34695.2, -38761.9, -200), (-34282.6, -38943.2, -200), (-34316.1, -39559.9, -200), (-36498.1, -41442.5, -200), (-36734.7, -41555.1, -200), (-36808.4, -41017.6, -200), (-36901.2, -40131.5, -200), (-37105.7, -38808.8, -200), (-37242.5, -38294.2, -200), (-37652.6, -37773.5, -200), (-38465, -37260.7, -200), (-39435.1, -36868.1, -200), (-40792.8, -36680.6, -200), (-41798.2, -36391.3, -200), (-41591.9, -37534.7, -200), (-41837, -38447.7, -200), (-42499.8, -39271.8, -200), (-43396.9, -39836.7, -200), (-44616.3, -39742.9, -200), (-45983.7, -39432, -200), (-47076.6, -39397, -200), (-47583.7, -39841.6, -200), (-47899.1, -40521.4, -200), (-48520, -41278.8, -200), (-50112.7, -40881.5, -200), (-50971.5, -40474.9, -200), (-50986.2, -40432.4, -200), (-51301.8, -39502.8, -200)];
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = level.player getorigin();
  var_1.angles = (270, 0, -45);
  var_2 = [];
  var_3 = maps\_shg_fx::_id_446A(701);
  wait 1.0;

  for(;;) {
    common_scripts\utility::flag_waitopen("msg_vfx_sub_interior_minus_25000");
    var_4 = level.player getplayerangles();
    var_5 = vectornormalize(anglesToForward(var_4));
    var_6 = -1;
    var_7 = [];

    for(var_8 = 0; var_8 < var_0.size; var_8++) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_9 = vectornormalize(var_0[var_8] - level.player.origin);

      if(vectordot(var_5, var_9) > 0.45) {
        var_6 = 1;
        var_7[var_7.size] = var_0[var_8];
      }
    }

    if(var_6 > 0) {
      var_10 = randomint(var_7.size + 1);

      if(isDefined(var_10)) {
        var_11 = var_7[var_10];

        if(isDefined(var_3) && isDefined(var_11)) {
          var_3.v["origin"] = var_11;
          common_scripts\utility::exploder(701);
        }
      }
    }

    wait 2.0;
  }
}

_id_4A3A() {
  level waittill("msg_fx_trigger_waterHitA");
  common_scripts\utility::exploder(850);
  wait 0.25;
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = self.player getorigin();
  var_0.angles = (270, 0, 0);
  playFXOnTag(common_scripts\utility::getfx("large_water_impact_close_rain"), var_0, "tag_origin");
  wait 10.0;
  var_0 delete();
}

_id_4A3B() {
  level waittill("msg_fx_trigger_waterHitB");
  common_scripts\utility::exploder(851);
  wait 0.25;
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = self.player getorigin();
  var_0.angles = (270, 0, 0);
  playFXOnTag(common_scripts\utility::getfx("large_water_impact_close_rain"), var_0, "tag_origin");
  wait 10.0;
  var_0 delete();
}

_id_4A3C() {
  level waittill("msg_fx_trigger_waterHitC");
  common_scripts\utility::exploder(852);
  wait 0.25;
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = self.player getorigin();
  var_0.angles = (270, 0, 0);
  playFXOnTag(common_scripts\utility::getfx("large_water_impact_close_rain"), var_0, "tag_origin");
  wait 10.0;
  var_0 delete();
}

_id_4A3D() {
  wait 1;
  var_0 = common_scripts\utility::getfx("lights_godray_beam_harbor");
  var_1 = [(-39249, -23793.9, -309.083), (-39238.2, -23802.1, -302.346), (-39239.3, -23842.4, -305.435), (-39231.2, -23833.4, -298.456), (-39242.1, -23825.2, -305.193), (-39410.9, -23784.6, -315.104), (-39400.1, -23792.8, -308.367), (-39408.2, -23801.8, -315.346), (-39404, -23815.9, -311.214), (-39401.2, -23833.1, -311.456), (-39393.1, -23824.1, -304.477), (-38982.4, -23731.1, -300.505), (-38971.6, -23739.3, -293.768), (-38975.5, -23762.4, -296.615), (-38972.7, -23779.6, -296.857), (-38964.6, -23770.6, -289.878), (-38805.2, -23733.9, -302.235), (-38794.4, -23742.1, -295.498), (-38798.3, -23765.2, -298.345), (-38795.5, -23782.4, -298.587), (-38787.4, -23773.4, -291.608)];
  var_2 = [(41.9076, 9.07033, -152.016), (47.1022, 350.779, -162.906), (47.8449, 314.967, 168.305), (47.1022, 350.779, -162.906), (41.9076, 9.07033, -152.016), (41.9076, 9.07033, -152.016), (47.1022, 350.779, -162.906), (47.8449, 314.967, 168.305), (41.9076, 9.07033, -152.016), (47.8449, 314.967, 168.305), (47.1022, 350.779, -162.906), (41.9076, 9.07033, -152.016), (47.1022, 350.779, -162.906), (41.9076, 9.07033, -152.016), (47.8449, 314.967, 168.305), (47.1022, 350.779, -162.906), (41.9076, 9.07033, -152.016), (47.1022, 350.779, -162.906), (41.9076, 9.07033, -152.016), (47.8449, 314.967, 168.305), (47.1022, 350.779, -162.906)];
  var_3 = [];

  for(;;) {
    common_scripts\utility::flag_wait("fx_zone_5100_active");

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_3[var_4] = spawnfx(var_0, var_1[var_4], anglesToForward(var_2[var_4]), anglestoup(var_2[var_4]));
      triggerfx(var_3[var_4]);
    }

    common_scripts\utility::flag_waitopen("fx_zone_5100_active");

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_3[var_4] delete();
    }
  }
}

_id_4770() {
  level waittill("msg_fx_set_surface_visionset");
}

_id_4A3E() {
  common_scripts\utility::flag_init("msg_fx_set_buildinghit2");
  wait 1.0;
  var_0 = getent("sub_board_anim_node", "targetname");
  var_1 = maps\_shg_fx::_id_446A(248);
  var_1.v["origin"] = var_0.origin + (-5035, -4309, 380);
  var_2 = getent("ny_manhattan_building_exchange_01_facade_des", "targetname");
  var_3 = getent("ny_manhattan_building_exchange_01_facade_des2", "targetname");
  var_4 = getent("ny_manhattan_building_exchange_01_facade_des3", "targetname");
  var_2._id_1032 = "building_des";
  var_3._id_1032 = "building_des";
  var_4._id_1032 = "building_des";
  var_2 maps\_anim::_id_1244();
  var_3 maps\_anim::_id_1244();
  var_4 maps\_anim::_id_1244();
  var_2 hide();
  var_3 hide();
  var_4 hide();
  var_5 = getent("surface_building_hit_undamaged", "targetname");
  common_scripts\utility::flag_wait("msg_fx_set_buildinghit2");
  level notify("msg_nyharbor_stoplandexplosions");
  level notify("msg_nyharbor_stopwaterexplosions");
  common_scripts\utility::exploder(248);
  maps\_audio::aud_send_msg("harbor_missile_03");
  wait 4.2;
  var_2 show();
  var_3 show();
  var_4 show();
  common_scripts\utility::exploder(240);
  maps\_audio::aud_send_msg("building_missile_explosion_02");
  common_scripts\utility::exploder(241);
  wait 0.25;
  var_2 setanim(level._id_0C59["building_des"]["ny_manhattan_building_exchange_01_facade_des_anim"]);
  var_3 setanim(level._id_0C59["building_des"]["ny_manhattan_building_exchange_01_facade_des_anim"]);
  var_4 setanim(level._id_0C59["building_des"]["ny_manhattan_building_exchange_01_facade_des_anim"]);
  var_5 hide();
  wait 0.75;
  common_scripts\utility::exploder(245);
  wait 0.25;
  common_scripts\utility::exploder(242);
  wait 0.5;
  common_scripts\utility::exploder(243);
  wait 0.25;
  common_scripts\utility::exploder(244);
  wait 0.5;
  common_scripts\utility::exploder(246);
  wait 360;
  var_2 hide();
  var_3 hide();
  var_4 hide();
  thread _id_4A38();
  thread _id_4A39();
}

_id_4A3F(var_0) {
  self endon("death");

  for(;;) {
    self waittillmatch("looping anim", "start_fire");
    maps\_audio::aud_send_msg("aud_fire_extinguisher_spray", var_0);

    for(var_1 = 0; var_1 < 5; var_1++) {
      playFXOnTag(common_scripts\utility::getfx("fire_extinguisher_spray"), var_0, "tag_fx");
      wait 0.1;
    }
  }
}

_id_4A40() {
  common_scripts\utility::flag_wait("sub_breach_started");
  wait 24;
  maps\_utility::vision_set_fog_changes("ny_harbor_sub_breach", 2);
}

_id_4A41() {
  common_scripts\utility::flag_wait("player_on_boat");
  maps\_utility::vision_set_fog_changes("ny_harbor_zodiac", 3);
}

_id_4A42() {
  wait 1.0;
  var_0 = getent("sub_breach_anim_node", "targetname");
  var_1 = maps\_shg_fx::_id_446A(249);
  var_1.v["origin"] = (-37920.9, -22439.9, -335);
  var_2 = maps\_shg_fx::_id_446A(250);
  var_2.v["origin"] = (-39290.9, -23624.6, -276.368);
  var_3 = getent("ny_manhattan_building_exchange_01_facade_des4", "targetname");
  var_3._id_1032 = "building_des";
  var_3 maps\_anim::_id_1244();
  var_4 = getent("surface_building_hit_undamaged2", "targetname");
  var_3 hide();
  common_scripts\utility::flag_wait("sub_breach_started");
  wait 15.66;
  level notify("msg_fx_player_surfaced");
  wait 4.0;
  common_scripts\utility::exploder(249);
  common_scripts\utility::exploder(250);
  maps\_audio::aud_send_msg("harbor_missile_03");
  var_3 show();
  wait 0.7;
  level thread maps\_shg_fx::_id_444E(0.25, 0.5, 0.2, 0.25);
  wait 2.4;
  var_3 setanim(level._id_0C59["building_des"]["ny_manhattan_building_exchange_01_facade_des_anim"]);
  maps\_audio::aud_send_msg("building_missile_explosion_01");
  common_scripts\utility::exploder(251);
  wait 0.25;
  common_scripts\utility::exploder(252);
  var_4 hide();
  wait 200;
  var_3 hide();
}

_id_4A43(var_0) {
  wait 0.1;
  var_1 = randomfloat(1);
  var_0 setanim(level._id_0C59["smoke_column"]["rot"], 1.0, 1.0, 0.0);
  var_0 setanim(level._id_0C59["smoke_column"]["fire"], 1.0, 1.0, 0.0);
  wait 0.1;

  for(;;) {
    var_2 = level.player.origin - var_0.origin;
    var_3 = vectortoangles(vectornormalize(var_2));
    var_4 = var_3[1] - 90.0;

    if(var_4 < 0) {
      var_4 = 360 + var_4;

    }
    var_1 = var_1 + 0.000208333;

    if(var_1 < 0) {
      var_1 = 1.0 + var_1;
    } else if(var_1 > 1) {
      var_1 = var_1 - 1.0;

    }
    var_0 setanimtime(level._id_0C59["smoke_column"]["fire"], clamp(var_4 / 360.0, 0.0, 1.0));
    var_0 setanimtime(level._id_0C59["smoke_column"]["rot"], var_1);
    wait 0.05;
  }
}

_id_4A44() {
  var_0 = getEntArray("fx_ny_smoke_column", "targetname");
  var_1 = [];
  var_2 = "ny_column_base";
  var_3 = level.createfxbyfxid[var_2];

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      if(var_5.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_5.v["exploder"])) {
        continue;
      }
      var_1[var_1.size] = var_5.v["origin"];
    }
  }

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    if(isDefined(var_0[var_7])) {
      var_8 = var_0[var_7];
      var_8._id_1032 = "smoke_column";
      var_8.origin = var_1[var_7];
      var_8 maps\_anim::_id_1244();
      thread _id_4A43(var_8);
    }
  }

  var_9 = var_1.size;
  var_10 = var_0.size + 1;

  for(var_7 = var_9; var_7 < var_10; var_7++) {
    if(isDefined(var_0[var_7])) {
      var_0[var_7] delete();
    }
  }
}

_id_4A45() {
  level.player setwatersheeting(2, 7.0);
}

_id_4A46(var_0) {
  level.player setwatersheeting(2, var_0);
}

_id_4A47(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = var_2 * 20;

  for(var_5 = var_4 - 1; var_3 < var_4; var_3++) {
    var_6 = (var_1 - var_0) * (var_3 / var_5);
    var_6 = var_6 + var_0;
    setsunlight(var_6[0], var_6[1], var_6[2]);
  }

  setsunlight(var_1[0], var_1[1], var_1[2]);
}

_id_4A48(var_0) {
  var_1 = level._id_4A49;
  var_2 = vectornormalize((0.88, 0.5, 0.82));
  var_3 = vectornormalize((0.34, 0.939, 0.82));
  var_4 = vectornormalize((-0.34, 0.939, 0.62));
  var_5 = getmapsunlight();
  var_6 = vectornormalize((var_5[0], var_5[1], var_5[2])) * 2.25;
  setsundirection(var_0);
  level._id_49C1 waittillmatch("single anim", "waterout");
  thread maps\_utility::vision_set_fog_changes("ny_harbor_surfacing", 0);
  level common_scripts\utility::waitframe();
  thread _id_4A46(2.0);
  wait 2.05;
  var_5 = getmapsunlight();
  var_6 = vectornormalize((var_5[0], var_5[1], var_5[2])) * 2.25;
  var_1 waittillmatch("single anim", "breach_impact");
  lerpsundirection(var_2, var_3, 6.3);
  wait 6.3;
  lerpsundirection(var_3, var_4, 2);
  level.player waittill("stop_breathing");
  resetsundirection();
}

_id_4A4A() {
  var_0 = getent("dyn_water_breachpatch_high", "script_noteworthy");
  var_1 = getent("dyn_water_breachpatch2_high", "targetname");
  var_2 = getent("dyn_water_breachpatchfoamy_high", "script_noteworthy");
  var_3 = getent("dyn_water_breachpatchfoamy2_high", "targetname");
  var_4 = getent("dyn_water_breachpatch_low", "script_noteworthy");
  var_0 hide();
  var_2 show();
  var_1 hide();
  var_3 delete();
  var_4 show();
  var_2.origin = (-35356, -20967, -240);
  wait 1.0;
  var_5 = getent("fx_nyharbor_wave_front", "targetname");
  var_6 = getent("fx_nyharbor_wave_side", "targetname");
  var_7 = getent("fx_nyharbor_wave_displace", "targetname");
  var_8 = getent("fx_nyharbor_wave_crashing", "targetname");
  var_5 hide();
  var_6 hide();
  var_7 hide();
  var_8 hide();
  var_9 = getent("sub_breach_anim_node", "targetname");
  var_10 = spawn("script_origin", var_9.origin + (0, 0, -96));
  var_10.angles = var_9.angles;
  var_11 = spawn("script_origin", var_9.origin + (0, 0, -96));
  var_11.angles = var_9.angles;
  var_6._id_1032 = "wave_side";
  var_6 maps\_anim::_id_1244();
  var_5._id_1032 = "wave_front";
  var_5 maps\_anim::_id_1244();
  var_7._id_1032 = "wave_displace";
  var_7 maps\_anim::_id_1244();
  var_8._id_1032 = "wave_crashing";
  var_8 maps\_anim::_id_1244();
  var_12 = [var_6, var_5, var_8];
  var_13 = [var_7];
  var_10 thread maps\_anim::_id_11BF(var_12, "wave");
  var_11 thread maps\_anim::_id_11BF(var_13, "wave");
  var_5 hide();
  var_6 hide();
  var_7 hide();
  var_8 hide();
  var_14 = spawnStruct();
  var_14.v["name"] = "sub_override";
  var_14.v["wake"] = ["tag_fx_wake", "tag_fx_wake1", "tag_fx_wake2", "tag_fx_wake3", "tag_fx_wake4", "tag_fx_wake5", "tag_fx_wake6"];
  var_15 = spawnStruct();
  var_15.v["ent"] = var_6;
  var_15.v["fx"] = common_scripts\utility::getfx("ny_harbor_wavech");
  var_15.v["chain"] = "wake";
  var_15.v["looptime"] = 0.04;
  var_15.v["chainset_name"] = "sub_override";
  var_15.v["chainset_override"] = var_14;
  common_scripts\utility::flag_wait("sub_breach_started");
  level notify("msg_nyharbor_stoplandexplosions");
  level notify("msg_nyharbor_stopwaterexplosions");
  level notify("msg_fx_stop_slava_missiles");
  var_16 = getmapsundirection();
  var_17 = vectornormalize((0.88, 0.5, 0.82));
  thread _id_4A48(var_17);
  level._id_49C1 waittillmatch("single anim", "waterout");
  var_18 = common_scripts\utility::spawn_tag_origin();
  var_18.origin = level._id_49C1.origin + (0, 0, 40);
  var_18.angles = (270, 0, 0);
  var_18 linkto(level._id_49C1);
  playFXOnTag(common_scripts\utility::getfx("ny_sub_playerwaterripple"), var_18, "tag_origin");
  var_0 show();
  var_2 hide();
  var_4 hide();
  var_1 show();
  var_19 = level._id_4A49;
  var_19 waittillmatch("single anim", "start_pre_displace");
  common_scripts\utility::flag_set("sub_surface_rumble");
  var_7 show();
  var_20 = maps\_ocean::_id_4A36(level._id_4A30["water_patch"], (-35271, -21133, -224));
  var_11.origin = var_9.origin + (0, 0, var_20 - 118);
  var_11 thread maps\_anim::_id_11DD(var_13, "wave");
  var_19 waittillmatch("single anim", "start_wave_anim");
  level notify("msg_breach_fx_started");
  var_6 show();
  var_5 show();
  var_7 show();
  var_10 thread maps\_anim::_id_11DD(var_12, "wave");
  level._id_4A4C = getdvarfloat("sm_sunshadowscale");
  setsaveddvar("sm_sunshadowscale", 0.4);
  common_scripts\utility::exploder(222);
  var_21 = common_scripts\utility::spawn_tag_origin();
  var_21.angles = (270, 0, 0);
  var_21.origin = var_19 gettagorigin("tag_fx_bow2");
  var_21 linkto(var_19, "tag_fx_bow2");
  playFXOnTag(common_scripts\utility::getfx("ny_sub_breachMainBow"), var_21, "tag_origin");
  var_22 = common_scripts\utility::spawn_tag_origin();
  var_22.origin = var_19 gettagorigin("body");
  var_22.angles = var_19 gettagangles("body");
  var_22 linkto(var_19, "body", (2226, -216, 221), (0, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("ny_sub_breachmainBow_gush"), var_22, "tag_origin");
  var_23 = maps\_shg_fx::_id_4474(var_15);
  wait 0.1;
  level thread maps\_shg_fx::_id_444E(0.25, 1, 0.5, 0.3);

  if(level.console && level.ps3 || !level.console) {
    sethalfresparticles(1);

  }
  var_19 waittillmatch("single anim", "breach_water");
  var_14.v["wake"] = ["tag_fx_wave", "tag_fx_wave1", "tag_fx_wave2", "tag_fx_wave3", "tag_fx_wave4", "tag_fx_wave5"];
  var_15.v["ent"] = var_5;
  var_15.v["fx"] = common_scripts\utility::getfx("ny_harbor_wavelargech");
  var_15.v["chainset_override"] = var_14;
  var_15.v["looptime"] = 0.08;
  var_24 = maps\_shg_fx::_id_4474(var_15);
  common_scripts\utility::exploder(220);
  playFXOnTag(common_scripts\utility::getfx("ny_sub_fingush"), var_19, "tag_fx_elevator");
  playFXOnTag(common_scripts\utility::getfx("ny_sub_towerbase"), var_19, "tag_fx_towerbase");
  var_25 = common_scripts\utility::spawn_tag_origin();
  var_25.origin = var_19 gettagorigin("tag_origin");
  var_25.angles = var_19 gettagangles("tag_origin");
  var_25 linkto(var_19, "body", (-1130, 0, 233), (0, 0, 0));
  var_26 = common_scripts\utility::spawn_tag_origin();
  var_26.origin = var_25.origin;
  var_26.angles = var_25.angles;
  var_26 linkto(var_19, "body", (-708, 0, 233), (0, 0, 0));
  var_27 = common_scripts\utility::spawn_tag_origin();
  var_27.origin = var_25.origin;
  var_27.angles = var_25.angles;
  var_27 linkto(var_19, "body", (0, 0, 280), (0, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("ny_sub_directionalgushes"), var_22, "tag_origin");
  var_7 waittillmatch("single anim", "breach_displace_fx");
  var_14.v["wake"] = ["tag_fx_wake_", "tag_fx_wake_1", "tag_fx_wake_2", "tag_fx_wake_3", "tag_fx_wake_4"];
  var_15.v["ent"] = var_7;
  var_15.v["fx"] = common_scripts\utility::getfx("ny_harbor_wavelargech2");
  var_15.v["chainset_override"] = var_14;
  var_15.v["looptime"] = 0.04;
  wait 0.5;
  wait 0.5;
  level thread maps\_shg_fx::_id_444E(0.25, 1, 0.3, 0.53);
  wait 0.25;
  playFX(common_scripts\utility::getfx("ny_sub_sidefroth_before"), (-34172, -20987, -260), anglesToForward((0, 0, 0)));
  playFX(common_scripts\utility::getfx("ny_sub_sidefroth_before"), (-34372, -20987, -260), anglesToForward((0, 0, 0)));
  playFX(common_scripts\utility::getfx("ny_sub_sidefroth_before"), (-34572, -20987, -260), anglesToForward((0, 0, 0)));
  playFX(common_scripts\utility::getfx("ny_sub_sidefroth_before"), (-34772, -20987, -260), anglesToForward((0, 0, 0)));
  playFX(common_scripts\utility::getfx("ny_sub_sidefroth_before"), (-34972, -20987, -260), anglesToForward((0, 0, 0)));
  playFX(common_scripts\utility::getfx("ny_sub_sidefroth_before"), (-35172, -20987, -260), anglesToForward((0, 0, 0)));
  level common_scripts\utility::waitframe();
  playFX(common_scripts\utility::getfx("ny_sub_sidefroth_before"), (-35272, -20987, -260), anglesToForward((0, 0, 0)));
  playFX(common_scripts\utility::getfx("ny_sub_sidefroth_before"), (-35372, -20987, -260), anglesToForward((0, 0, 0)));
  playFXOnTag(common_scripts\utility::getfx("ny_sub_fin_wisp"), var_25, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("ny_sub_fin_wisp"), var_26, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("ny_sub_fin_wisp"), var_27, "tag_origin");
  var_0 hide();
  var_1 show();
  var_2 show();
  var_4 hide();
  thread _id_4A46(3.75);
  var_19 waittillmatch("single anim", "breach_impact");
  level notify("msg_breach_fx_ended");
  level notify(var_23);
  var_10 delete();
  level notify(var_24);
  wait 0.5;
  common_scripts\utility::exploder(221);
  level thread maps\_shg_fx::_id_444E(0.35, 1.5, 0.3, 0.53);
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("ny_sub_sideport_4"), var_19, "tag_fx_ventback_single7");
  wait 0.5;
  thread _id_4A46(4.75);
  playFXOnTag(common_scripts\utility::getfx("ny_sub_sidefroth"), var_19, "tag_fx_foamrear2");
  playFXOnTag(common_scripts\utility::getfx("ny_sub_sidefroth"), var_19, "tag_fx_foamrear3");
  playFXOnTag(common_scripts\utility::getfx("ny_sub_sidefroth"), var_19, "tag_fx_foamrear4");
  playFXOnTag(common_scripts\utility::getfx("ny_sub_sidefroth"), var_19, "tag_fx_foamrear5");
  var_5 delete();
  var_6 delete();
  var_7 delete();
  wait 2;
  playFXOnTag(common_scripts\utility::getfx("ny_sub_sidefroth"), var_19, "tag_fx_foamrear6");
  playFXOnTag(common_scripts\utility::getfx("ny_sub_damage_smoke"), var_19, "tag_fx_damage_smoke");
  wait 1;
  setsaveddvar("sm_sunshadowscale", level._id_4A4C);
  wait 2.5;
  playFXOnTag(common_scripts\utility::getfx("ny_sub_sidefroth"), var_19, "tag_fx_foamrear1");
  common_scripts\utility::exploder(26011);
  wait 1;
  playFXOnTag(common_scripts\utility::getfx("sub_foam_lapping_waves"), var_19, "tag_fx_tail_foam");
  playFXOnTag(common_scripts\utility::getfx("sub_breaching_tail_steam"), var_19, "tag_fx_tail_foam");
  wait 5.35;
  thread _id_4A46(3.75);
  level.player waittill("stop_breathing");
  stopFXOnTag(common_scripts\utility::getfx("ny_sub_damage_smoke"), var_19, "tag_fx_damage_smoke");

  if(level.console && level.ps3 || !level.console) {
    sethalfresparticles(0);

  }
  level thread _id_4A38();
  level thread _id_4A39();
  level thread _id_4AC8();
  var_0 hide();
  var_2 hide();
  var_1 hide();
  var_4 show();
  stopFXOnTag(common_scripts\utility::getfx("sub_foam_lapping_waves"), var_19, "tag_fx_tail_foam");
  stopFXOnTag(common_scripts\utility::getfx("sub_breaching_tail_steam"), var_19, "tag_fx_tail_foam");
  wait 27.8;
  level notify("start_surface_missile_fx");
}

_id_4A4D() {
  var_0 = undefined;
  wait 0.1;
  var_1 = getent("fx_id_smokeguy", "targetname");
  var_2 = getEntArray("actor_enemy_opforce_navy_short_P90", "classname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4) && isDefined(var_1)) {
      if(var_4 istouching(var_1)) {
        var_0 = var_4;
      }
    }
  }

  if(isDefined(var_0)) {
    var_6 = spawnStruct();
    var_6.v["ent"] = var_0;
    var_6.v["fx"] = common_scripts\utility::getfx("ny_harbor_actor_smoke");
    var_6.v["chain"] = "all";
    var_6.v["looptime"] = 0.16;
    var_7 = maps\_shg_fx::_id_4474(var_6);
    var_6.v["ent"] = var_0;
    wait 2.0;
    level notify(var_7);
  }

  level._id_45C0 waittillmatch("single anim", "show");
  wait 3.3;
  level thread maps\_shg_fx::_id_444E(0.25, 1, 0.3, 0.53);
  common_scripts\utility::exploder(247);
}

_id_4A4E() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = self.player getorigin();
  var_0.angles = (270, 0, -45);
  wait 1;

  for(;;) {
    common_scripts\utility::flag_wait("fx_zone_26000_active");
    maps\_shg_fx::_id_4460("fx_zone_5000_active", "fx_zone_6000_active");
    level._id_45C0 waittillmatch("single anim", "show");
    wait 5.0;
    var_1 = randomfloatrange(-1.5, 1.5) + 2.0;
    wait(var_1);
    var_2 = maps\_shg_fx::_id_446B(600);
    var_3 = var_2[randomint(var_2.size + 1)];

    if(isDefined(var_3)) {
      var_4 = var_3 common_scripts\utility::activate_individual_exploder();
      maps\_audio::aud_send_msg("big_splash", var_4);
    }
  }
}

_id_4A4F(var_0) {
  if(!isDefined(level._id_4A50)) {
    level._id_4A50 = 0;

  }
  var_1 = var_0 + (0, 0, 48);
  var_2 = var_1 - level.player.origin;
  var_3 = length(var_2);
  var_4 = vectornormalize(var_2);
  var_5 = vectornormalize(anglesToForward(level.player.angles));
  var_6 = vectordot(var_4, var_5);

  if(var_6 > 0.3 && var_3 < 1000) {
    if(level.console && level.ps3 || !level.console) {
      sethalfresparticles(1);
      level._id_4A50++;
    }

    wait 2.0;

    if(level.console && level.ps3 || !level.console) {
      if(level._id_4A50 < 2) {
        sethalfresparticles(0);

      }
      level._id_4A50--;
    }
  }
}

_id_4A51() {
  var_0 = spawnStruct();
  var_0.v["name"] = "dvora_wake";
  var_0.v["wake"] = ["tag_wave_r1", "tag_wave_r2", "tag_wave_r3"];
  var_1 = spawnStruct();
  var_1.v["ent"] = self;
  var_1.v["fx"] = common_scripts\utility::getfx("ny_harbor_wavech");
  var_1.v["chain"] = "wake";
  var_1.v["looptime"] = 0.04;
  var_1.v["chainset_name"] = "dvora_wake";
  var_1.v["chainset_override"] = var_0;
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = self gettagorigin("tag_body");
  var_2.angles = self gettagangles("tag_body");
  var_2 thread _id_4A52(self, 5, 0);
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = var_2.origin;
  var_3.angles = var_2.angles;
  var_3 thread _id_4A52(self, 5, 0);
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4.origin = var_2.origin;
  var_5 = vectortoangles((2148, 1586, 0));
  var_4.angles = combineangles(var_5, (270, 0, 0));
  var_4 thread _id_4A52(self, 5, 0);
  level common_scripts\utility::waitframe();
  level waittill("msg_fx_start_carrierfx");
  maps\_shg_fx::_id_4449("burning_oil_slick_1");
  playFXOnTag(common_scripts\utility::getfx("ny_dvora_wakestern_trail"), self, "tag_propeller_fx");
  playFXOnTag(common_scripts\utility::getfx("ny_dvora_wakebow"), var_2, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("ny_dvora_wakebow_trail"), var_3, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("ny_dvora_wakebow_trailxup"), var_4, "tag_origin");
  self waittill("dvora_destroyed");
  stopFXOnTag(common_scripts\utility::getfx("ny_dvora_wakebow"), var_2, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("ny_dvora_wakestern_trail"), self, "tag_propeller_fx");
  level common_scripts\utility::waitframe();
  playFXOnTag(common_scripts\utility::getfx("ny_dvora_wakebow2"), var_2, "tag_origin");
  level common_scripts\utility::waitframe();
  playFXOnTag(common_scripts\utility::getfx("ny_dvora_wakestern_trail2"), self, "tag_propeller_fx");
  level waittill("msg_fx_stop_cin_dvorafx");
  var_3 notify("fx_stop_updatepos");
  var_4 notify("fx_stop_updatepos");
  stopFXOnTag(common_scripts\utility::getfx("ny_dvora_wakebow2"), var_2, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("ny_dvora_wakebow_trail"), var_3, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("ny_dvora_wakebow_trailxup"), var_4, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("ny_dvora_wakestern_trail2"), var_2, "tag_origin");
  var_2 delete();
  var_3 delete();
  var_4 delete();
}

_id_4A52(var_0, var_1, var_2) {
  self endon("fx_stop_updatepos");
  var_3 = 0;
  var_4 = 0;

  if(isDefined(var_2)) {
    var_3 = var_2;

  }
  if(isDefined(var_1)) {
    var_4 = var_1;

  }
  for(;;) {
    var_5 = var_0 gettagorigin("tag_body");
    var_6 = var_0 gettagangles("tag_body");
    var_5 = var_5 + anglesToForward(var_6) * 250;
    var_7 = 0;

    if(var_3) {
      var_7 = maps\_ocean::_id_4A36(level._id_4A30["water_patch"], var_5);

    }
    if(isDefined(self)) {
      self moveto((var_5[0], var_5[1], var_7 + var_4), 0.12);

    }
    wait 0.12;
  }
}

_id_4A53() {
  level notify("msg_nyharbor_stoplandexplosions");
  level notify("msg_nyharbor_stopwaterexplosions");
  level notify("msg_fx_stop_slava_missiles");
  maps\_shg_fx::_id_4467(242);
  maps\_shg_fx::_id_4467(252);
  level._id_4A4C = getdvarfloat("sm_sunshadowscale");
  setsaveddvar("sm_sunshadowscale", 0.35);
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = self gettagorigin("tag_wheel_front_left");
  var_0.angles = combineangles(self gettagangles("tag_origin"), (270, 0, 0));
  var_0 linkto(self, "tag_wheel_front_left");
  playFXOnTag(common_scripts\utility::getfx("ny_dvora_zodiac_bump"), var_0, "tag_origin");
  wait 0.25;
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = level._id_4A54 gettagorigin("tag_wheel_front_left");
  var_1.angles = combineangles(level._id_4A54 gettagangles("tag_wheel_front_left"), (270, 0, 0));
  var_1 linkto(level._id_4A54, "tag_wheel_front_left", (0, 0, 0), (0, 0, 0));
  level thread maps\_shg_fx::_id_444E(0.35, 1, 0.3, 0.53);
  playFXOnTag(common_scripts\utility::getfx("ny_dvora_zodiac_bump"), var_1, "tag_origin");

  if(level.console && level.ps3 || !level.console) {
    sethalfresparticles(1);
    level._id_4A50++;
  }

  wait 1.3;

  if(level.console && level.ps3 || !level.console) {
    if(level._id_4A50 < 2) {
      sethalfresparticles(0);

    }
    level._id_4A50--;
  }

  level notify("msg_fx_start_carrierfx");
  var_0 delete();
  var_1 delete();
}

_id_4A55() {
  playFXOnTag(common_scripts\utility::getfx("zubr_wake_nyharbor"), self, "tag_wake");
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = self gettagorigin("tag_wheel_back_right");
  var_0.angles = self gettagangles("tag_wheel_back_right");
  var_0 linkto(self, "tag_wheel_back_right", (0, 0, 50), (0, 0, 0));
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = self gettagorigin("tag_wheel_back_right");
  var_1.angles = self gettagangles("tag_wheel_back_right");
  var_1 linkto(self, "tag_wheel_back_left", (0, 0, -50), (0, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("zubr_wakeside_nyharbor"), var_0, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("zubr_wakeside_nyharbor"), var_1, "tag_origin");
  common_scripts\utility::waittill_either("death", "stop_fx");
  stopFXOnTag(common_scripts\utility::getfx("zubr_wakeside_nyharbor"), var_0, "tag_origin");
  stopFXOnTag(common_scripts\utility::getfx("zubr_wakeside_nyharbor"), var_1, "tag_origin");
  var_0 delete();
  var_1 delete();
}

_id_4A56(var_0) {
  var_0 endon("death");

  for(;;) {
    if(isDefined(self)) {
      var_1 = var_0 gettagorigin("tag_propeller_fx");
      var_2 = maps\_ocean::_id_4A36(level._id_4A30["water_patch"], var_1);
      var_3 = (var_1[0], var_1[1], -225);
      var_4 = var_0 gettagangles("tag_propeller_fx");
      self.angles = var_4;
      var_3 = var_3 + anglesToForward(var_4) * -150;
      self moveto((var_3[0], var_3[1], var_2 - 300), 0.2);
      wait 0.2;
    }
  }
}

_id_4A57() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = self gettagorigin("tag_propeller_fx");
  var_0.angles = self gettagangles("tag_propeller_fx");
  var_0 thread _id_4A56(self);
  playFXOnTag(common_scripts\utility::getfx("dvora_wake_nyharbor"), var_0, "tag_origin");
  level endon("msg_fx_stop_cin_dvorafx");
  self waittill("death");
  stopFXOnTag(common_scripts\utility::getfx("dvora_wake_nyharbor"), var_0, "tag_origin");
  var_0 delete();
}

_id_4A58() {
  common_scripts\utility::waitframe();

  if(level.createfx_enabled) {
    return 0;

  }
  var_0 = (-40344.3, -23924.7, -235.465);
  var_1 = (288.103, 186.437, -6.33035);
  thread _id_4A59(var_0, var_1);
}

_id_4A59(var_0, var_1) {
  common_scripts\utility::flag_wait("msg_vfx_surface_zone_26000");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_0;
  var_2.angles = var_1;
  playFXOnTag(common_scripts\utility::getfx("sub_foam_lapping_waves"), var_2, "tag_origin");
  common_scripts\utility::flag_waitopen("msg_vfx_surface_zone_26000");
  stopFXOnTag(common_scripts\utility::getfx("sub_foam_lapping_waves"), var_2, "tag_origin");
  var_2 delete();
}

_id_4A5A(var_0) {
  var_1 = var_0.origin;

  for(;;) {
    if(isDefined(var_0)) {
      common_scripts\utility::flag_wait("msg_vfx_surface_zone_26000");
      var_2 = maps\_ocean::_id_4A36(level._id_4A30["water_patch"], var_1);
      var_3 = var_1;
      var_3 = var_3 + anglestoup(var_0.angles) * (var_2 * 2);
      var_0 moveto(var_3, 0.1);
      wait 0.1;
    }
  }
}

_id_4A5B(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  var_11 = common_scripts\utility::spawn_tag_origin();
  var_11.origin = self gettagorigin("j_spine4");
  var_11.angles = vectortoangles(var_4);
  var_11 linkto(self, var_8);
  playFXOnTag(common_scripts\utility::getfx("ny_harbor_dvora_bloodhit"), var_11, "tag_origin");

  if(var_1 == 3) {
    playFXOnTag(common_scripts\utility::getfx("ny_harbor_dvora_bloodsplat"), var_0, "tag_guy3");

  }
  wait 2;
  var_11 delete();
}

_id_4A5C() {
  var_0 = 0;

  foreach(var_2 in self._id_0A39) {
    var_2 thread _id_4A5B(self, var_0);
    var_0++;
  }
}

_id_4A5D() {
  var_0 = getdvar("vision_set_current");
  visionsetnaked("generic_flash", 0.08);
  wait 0.17;
  visionsetnaked(var_0, 0.08);
}

_id_4A5E() {
  level waittill("msg_fx_play_lastsplash");
  wait 2.0;

  if(level.console && level.ps3 || !level.console) {
    sethalfresparticles(1);
    level._id_4A50++;
  }

  wait 2.0;

  if(level.console && level.ps3 || !level.console) {
    if(level._id_4A50 < 2) {
      sethalfresparticles(0);

    }
    level._id_4A50--;
  }

  wait 2.0;
  var_0 = 20;
  var_1 = 600;
  var_2 = level.player.origin;
  var_3 = anglesToForward(level.player.angles);
  var_4 = level.player getvelocity() / 20.0 + (1, 0, 0);
  var_5 = vectornormalize(var_4);
  var_1 = 1000;
  var_6 = var_2 + var_3 * var_1 + var_4 * var_0;
  var_7 = maps\_ocean::_id_4A36(level._id_4A30["water_patch"], var_6);
  var_8 = (var_6[0], var_6[1], var_7 - 260);
  playFX(common_scripts\utility::getfx("ny_harbor_dvora_fallingchunks"), var_8, (0, 0, 1), var_5);
  playFXOnTag(common_scripts\utility::getfx("ny_dvora_finalexplosion_splash"), level._id_4A5F, "tag_origin");
}

_id_4A60() {
  level waittill("msg_fx_play_chinook_board_coverpop");
  wait 1.1;

  if(isDefined(level._id_4975)) {
    playFXOnTag(common_scripts\utility::getfx("ny_dvora_finalexplosion_splash"), level._id_4975, "tag_origin");

  }
  thread _id_4A46(2.0);
}

_id_4A61() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    var_1 = 20;
    var_2 = 600;
    var_3 = level.player.origin;
    var_4 = anglesToForward(level.player.angles);
    var_5 = level.player getvelocity() / 20.0 + (1, 0, 0);
    var_6 = vectornormalize(var_5);
    var_7 = maps\_shg_common::_id_1684(var_4, (0, 0, 1));

    if(var_0 < 5) {
      var_2 = 1000;

    }
    var_8 = var_3 + var_4 * var_2 + var_5 * var_1 + var_7 * (-250 + 500 * randomfloat(1.0));
    var_9 = maps\_ocean::_id_4A36(level._id_4A30["water_patch"], var_8);
    var_10 = (var_8[0], var_8[1], var_9 - 260);
    maps\_audio::aud_send_msg("dvora_post_carrier_splashes", var_10);
    playFX(common_scripts\utility::getfx("ny_harbor_dvora_fallingchunks"), var_10, (0, 0, 1), var_6);
    thread _id_4A4F(var_10);
    wait 1;
  }
}

_id_4A62() {
  var_0 = 4000.0;
  var_1 = level._id_4975 gettagorigin("tag_origin");
  var_2 = self gettagorigin("tag_origin");
  var_3 = distance(var_1, var_2);
  var_4 = var_3 / var_0;
  var_1 = var_1 + level.player getvelocity() / 20.0 * var_4;
  var_5 = var_1 - var_2;
  var_6 = vectornormalize(var_5);
  playFX(common_scripts\utility::getfx("ny_harbor_dvora_debrisatplayer"), var_2, var_6, (0, 0, 1));
}

_id_4A63(var_0, var_1, var_2) {
  var_3 = (var_2 - 8 - 450.0) / 30.0;
  wait(var_3);
  var_4 = var_0 gettagorigin(var_1);
  level common_scripts\utility::waitframe();
  var_5 = var_0 gettagorigin(var_1);
  var_6 = var_5 - var_4;
  var_5 = var_5 + (var_6[0], var_6[1], 0) * 7;
  playFX(common_scripts\utility::getfx("ny_dvora_debris_splash"), (var_5[0], var_5[1], -252), (0, 0, 1), (1, 0, 0));
}

_id_4A64(var_0, var_1) {
  thread _id_4A63(var_1, "chunk3_11", 497);
  thread _id_4A63(var_0, "chunk2_6", 501);
  thread _id_4A63(var_0, "chunk2_17", 506);
  thread _id_4A63(var_0, "chunk2_14", 514);
  thread _id_4A63(var_1, "chunk3_1", 521);
  thread _id_4A63(var_0, "chunk2_11", 522);
  thread _id_4A63(var_1, "chunk3_8", 524);
  thread _id_4A63(var_1, "chunk3_10", 525);
  thread _id_4A63(var_1, "chunk3_9", 527);
  thread _id_4A63(var_1, "chunk3_4", 530);
}

_id_4A65(var_0, var_1, var_2) {
  var_3 = (var_2 - 450.0) / 30.0;
  wait(var_3);
  playFXOnTag(common_scripts\utility::getfx("ny_harbor_dvora_chunkemitter"), var_0, var_1);
}

_id_4A66(var_0, var_1) {
  thread _id_4A65(var_0, "chunk2_3", 455);
  thread _id_4A65(var_0, "chunk2_14", 461);
  thread _id_4A65(var_0, "chunk2_17", 463);
  thread _id_4A65(var_0, "chunk2_6", 458);
  thread _id_4A65(var_0, "chunk2_12", 451);
  thread _id_4A65(var_0, "chunk2_11", 468);
  thread _id_4A65(var_1, "chunk3_4", 470);
  thread _id_4A65(var_1, "chunk3_9", 470);
  thread _id_4A65(var_1, "chunk3_8", 470);
  thread _id_4A65(var_1, "chunk3_5", 478);
  thread _id_4A65(var_1, "chunk3_6", 478);
  thread _id_4A65(var_1, "chunk3_10", 478);
}

_id_4A67() {
  level common_scripts\utility::waitframe();
  level common_scripts\utility::waitframe();
  var_0 = getent("vehicle_russian_super_dvora_mark2_destroyA", "targetname");
  var_1 = getent("vehicle_russian_super_dvora_mark2_destroyB", "targetname");
  var_0 hide();
  var_1 hide();
}

_id_4A68(var_0) {
  var_1 = [];
  var_1[0] = self;
  self._id_1032 = "dvora";
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_3 = [];
  var_4 = [];

  for(var_5 = 1; var_5 < 18; var_5++) {
    var_6 = "chunk2_" + var_5;
    var_3[var_3.size] = var_6;
  }

  for(var_5 = 1; var_5 < 10; var_5++) {
    var_6 = "chunk3_" + var_5;
    var_4[var_4.size] = var_6;
  }

  var_7 = getent("vehicle_russian_super_dvora_mark2_destroyA", "targetname");
  var_8 = getent("vehicle_russian_super_dvora_mark2_destroyB", "targetname");
  var_2.origin = var_7 gettagorigin("tag_body_state2");
  var_2.angles = var_7 gettagangles("tag_body_state2");
  var_2 linkto(var_7, "tag_body_state2");
  var_7 hide();
  var_8 hide();
  self waittill("dvora_destroyed");
  maps\_audio::aud_send_msg("slowmo_dvora_destroyed");
  var_7 show();
  var_7.origin = self gettagorigin("tag_origin");
  var_7.angles = self gettagangles("tag_origin");
  var_7 linkto(self, "tag_origin");
  var_7._id_1032 = "dvora";
  var_7 maps\_anim::_id_1244();
  var_8.origin = self gettagorigin("tag_origin");
  var_8.angles = self gettagangles("tag_origin");
  var_8 linkto(self, "tag_origin");
  var_8._id_1032 = "dvora";
  var_8 maps\_anim::_id_1244();
  var_7 setanim(level._id_0C59["dvora"]["destorychunk"]);
  var_8 setanim(level._id_0C59["dvora"]["destorychunk"]);
  thread _id_4A5E();
  _id_4A64(var_7, var_8);
  _id_4A66(var_7, var_8);
  var_7 _id_4A62();
  playFXOnTag(common_scripts\utility::getfx("ny_harbor_dvora_death_exp"), var_7, "tag_deathfx1");
  var_9 = var_7 gettagorigin("tag_deathfx");
  var_9 = (var_9[0], var_9[1], -183);
  playFX(common_scripts\utility::getfx("ny_harbor_dvora_death_firewave"), var_9, anglesToForward((270, 0, 0)));
  wait 0.05;
  playFXOnTag(common_scripts\utility::getfx("ny_harbor_dvora_death_expinit"), var_7, "tag_deathfx1");
  self hide();
  wait 0.067;
  playFXOnTag(common_scripts\utility::getfx("ny_harbor_dvora_death_exp"), var_7, "tag_deathfx2");
  playFXOnTag(common_scripts\utility::getfx("ny_harbor_dvora_death"), var_7, "tag_deathfx");
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("ny_harbor_dvora_death_exp2"), var_7, "tag_deathfx3");
  wait 0.06;
  var_7 hidepart("tag_body_state2");
  var_8 show();
  wait 0.27;
  playFXOnTag(common_scripts\utility::getfx("ny_harbor_dvora_death_exp3"), self, "tag_deathfx4");
  var_8 hidepart("chunk3_9");
  wait 1.63;
  var_10 = self gettagorigin("tag_origin") + (0, 0, 0);
  level notify("msg_fx_stop_cin_dvorafx");
  var_10 = self gettagorigin("tag_origin") + (0, 0, 0);
  playFX(common_scripts\utility::getfx("ny_harbor_dvora_death_splah"), var_10, anglesToForward((0, -90, 0)));
  stopFXOnTag(common_scripts\utility::getfx("ny_harbor_dvora_death"), self, "tag_deathfx");
  maps\_audio::aud_send_msg("boat_slowmo_final_splash");
  wait 0.2;
  wait 0.25;
  level thread maps\_shg_fx::_id_444E(0.3, 1, 0.3, 0.53);
  wait 0.25;
  var_10 = var_7 gettagorigin("tag_deathfx") + (150, -50, 0);
  playFX(common_scripts\utility::getfx("ny_dvora_finalexplosion"), var_10, anglesToForward((270, 0, 0)));
  var_7 hide();
  var_8 hide();
  thread _id_4A61();
  wait 1.75;
  var_11 = common_scripts\utility::spawn_tag_origin();
  var_8 delete();
  var_7 delete();
  var_2 delete();
  var_11 delete();
  wait 2.0;
  setsaveddvar("sm_sunshadowscale", level._id_4A4C);
  common_scripts\utility::exploder(242);
  common_scripts\utility::exploder(252);
  wait 2.0;
  maps\_shg_fx::_id_444A("burning_oil_slick_1", "exploder");
  wait 3.0;

  if(!common_scripts\utility::flag("msg_fx_under_docks")) {
    level thread _id_4A38();
    wait 1.0;
    level thread _id_4A39();
    wait 1.0;
    level thread _id_4AC8();
  }

  thread _id_4A60();
}

precachefx() {
  level._effect["ny_sub_damage_smoke"] = loadfx("maps/ny_harbor/ny_sub_damage_smoke");
  level._effect["fire_extinguisher_spray"] = loadfx("props/fire_extinguisher_spray");
  level._effect["fire_extinguisher_exp"] = loadfx("props/fire_extinguisher_exp");
  level._effect["ny_sub_sidefroth_normal"] = loadfx("maps/ny_harbor/ny_sub_sidefroth_normal");
  level._effect["ny_dvora_wakestern_trail2"] = loadfx("maps/ny_harbor/ny_dvora_wakestern_trail2");
  level._effect["ny_harbor_dvora_death_expinit"] = loadfx("maps/ny_harbor/ny_harbor_dvora_death_expinit");
  level._effect["ny_harbor_dvora_bloodsplat"] = loadfx("maps/ny_harbor/ny_harbor_dvora_bloodsplat");
  level._effect["ny_harbor_dvora_bloodhit"] = loadfx("maps/ny_harbor/ny_harbor_dvora_bloodhit");
  level._effect["ny_harbor_dvora_fallingchunks"] = loadfx("maps/ny_harbor/ny_harbor_dvora_fallingchunks");
  level._effect["ny_harbor_dvora_debrisatplayer"] = loadfx("maps/ny_harbor/ny_harbor_dvora_debrisatplayer");
  level._effect["ny_dvora_wakebow2"] = loadfx("maps/ny_harbor/ny_dvora_wakebow2");
  level._effect["ny_harbor_dvora_death_exp3"] = loadfx("maps/ny_harbor/ny_harbor_dvora_death_exp3");
  level._effect["ny_harbor_dvora_death_exp2"] = loadfx("maps/ny_harbor/ny_harbor_dvora_death_exp2");
  level._effect["ny_sub_playerwaterripple"] = loadfx("maps/ny_harbor/ny_sub_playerwaterripple");
  level._effect["parabolic_water_stand"] = loadfx("misc/parabolic_water_stand");
  level._effect["ny_dvora_finalexplosion_splash"] = loadfx("maps/ny_harbor/ny_dvora_finalexplosion_splash");
  level._effect["ny_dvora_debris_splash"] = loadfx("maps/ny_harbor/ny_dvora_debris_splash");
  level._effect["ny_dvora_sideSplash"] = loadfx("maps/ny_harbor/ny_dvora_sideSplash");
  level._effect["ny_dvora_finalexplosion"] = loadfx("maps/ny_harbor/ny_dvora_finalexplosion");
  level._effect["ny_harbor_dvora_death_firewave"] = loadfx("maps/ny_harbor/ny_harbor_dvora_death_firewave");
  level._effect["ny_harbor_dvora_death_splah"] = loadfx("maps/ny_harbor/ny_harbor_dvora_death_splah");
  level._effect["ny_harbor_dvora_chunkemitter"] = loadfx("maps/ny_harbor/ny_harbor_dvora_chunkemitter");
  level._effect["ny_harbor_dvora_death_exp"] = loadfx("maps/ny_harbor/ny_harbor_dvora_death_exp");
  level._effect["ny_dvora_wakestern_trail"] = loadfx("maps/ny_harbor/ny_dvora_wakestern_trail");
  level._effect["ny_dvora_wakebow_trailxup"] = loadfx("maps/ny_harbor/ny_dvora_wakebow_trailxup");
  level._effect["ny_dvora_wakebow_trail"] = loadfx("maps/ny_harbor/ny_dvora_wakebow_trail");
  level._effect["ny_dvora_wakebow"] = loadfx("maps/ny_harbor/ny_dvora_wakebow");
  level._effect["ny_sub_fin_wisp"] = loadfx("maps/ny_harbor/ny_sub_fin_wisp");
  level._effect["ny_sub_sidefroth_before"] = loadfx("maps/ny_harbor/ny_sub_sidefroth_before");
  level._effect["ny_sub_breachmainBow_gush"] = loadfx("maps/ny_harbor/ny_sub_breachmainBow_gush");
  level._effect["ny_sub_directionalgushes"] = loadfx("maps/ny_harbor/ny_sub_directionalgushes");
  level._effect["ny_sub_sidefroth"] = loadfx("maps/ny_harbor/ny_sub_sidefroth");
  level._effect["ny_dvora_zodiac_bump2"] = loadfx("maps/ny_harbor/ny_dvora_zodiac_bump2");
  level._effect["ny_sub_sideport_4"] = loadfx("maps/ny_harbor/ny_sub_sideport_4");
  level._effect["ny_sub_hatch_grenade"] = loadfx("maps/ny_harbor/ny_sub_hatch_grenade");
  level._effect["dvora_wakeside_nyharbor"] = loadfx("treadfx/dvora_wakeside_nyharbor");
  level._effect["dvora_wake_nyharbor"] = loadfx("treadfx/dvora_wake_nyharbor");
  level._effect["zubr_wakeside_nyharbor"] = loadfx("treadfx/zubr_wakeside_nyharbor");
  level._effect["zubr_wake_nyharbor"] = loadfx("treadfx/zubr_wake_nyharbor");
  level._effect["ny_dvora_zodiac_bump"] = loadfx("maps/ny_harbor/ny_dvora_zodiac_bump");
  level._effect["mortarExp_water"] = loadfx("explosions/mortarExp_water");
  level._effect["ny_harbor_dvora_death2"] = loadfx("maps/ny_harbor/ny_harbor_dvora_death2");
  level._effect["ny_harbor_dvora_death"] = loadfx("maps/ny_harbor/ny_harbor_dvora_death");
  level._effect["ny_harbor_actor_smoke"] = loadfx("maps/ny_harbor/ny_harbor_actor_smoke");
  level._effect["ny_sub_hatch_smoke"] = loadfx("maps/ny_harbor/ny_sub_hatch_smoke");
  level._effect["ny_sub_hatch_smoke_2"] = loadfx("maps/ny_harbor/ny_sub_hatch_smoke_2");
  level._effect["nyharbor_sub_impact2"] = loadfx("maps/ny_harbor/nyharbor_sub_impact2");
  level._effect["ny_sub_breachMainBow"] = loadfx("maps/ny_harbor/ny_sub_breachMainBow");
  level._effect["ny_harbor_buildinghit2"] = loadfx("maps/ny_harbor/ny_harbor_buildinghit2");
  level._effect["ny_harbor_building_missile3"] = loadfx("maps/ny_harbor/ny_harbor_building_missile3");
  level._effect["ny_harbor_building_missile2"] = loadfx("maps/ny_harbor/ny_harbor_building_missile2");
  level._effect["ny_harbor_building_missile"] = loadfx("maps/ny_harbor/ny_harbor_building_missile");
  level._effect["ny_harbor_buildingchunkfall"] = loadfx("maps/ny_harbor/ny_harbor_buildingchunkfall");
  level._effect["ny_harbor_buildinghit_edge"] = loadfx("maps/ny_harbor/ny_harbor_buildinghit_edge");
  level._effect["ny_harbor_buildinghit"] = loadfx("maps/ny_harbor/ny_harbor_buildinghit");
  level._effect["ny_sub_breachMain"] = loadfx("maps/ny_harbor/ny_sub_breachMain");
  level._effect["ny_sub_towerbase"] = loadfx("maps/ny_harbor/ny_sub_towerbase");
  level._effect["ny_sub_fingush"] = loadfx("maps/ny_harbor/ny_sub_fingush");
  level._effect["nyharbor_sub_impact"] = loadfx("maps/ny_harbor/nyharbor_sub_impact");
  level._effect["ny_column_base"] = loadfx("maps/ny_harbor/ny_column_base");
  level._effect["fire_ceiling_lg_slow"] = loadfx("fire/fire_ceiling_lg_slow");
  level._effect["fire_falling_runner_consistent"] = loadfx("fire/fire_falling_runner_consistent_harbor");
  level._effect["firelp_large_med_pm_nolight_cheap"] = loadfx("fire/firelp_large_med_pm_nolight_cheap");
  level._effect["firelp_large_pm_nolight"] = loadfx("fire/firelp_large_pm_nolight");
  level._effect["firelp_large_pm_nolight_cheap"] = loadfx("fire/firelp_large_pm_nolight_cheap");
  level._effect["firelp_large_pm_nolight_r"] = loadfx("fire/firelp_large_pm_nolight");
  level._effect["firelp_large_pm_nolight_r_reflect"] = loadfx("fire/firelp_large_pm_reflect");
  level._effect["fire_ceiling_md_slow"] = loadfx("fire/fire_ceiling_md_slow");
  level._effect["fire_falling_runner"] = loadfx("fire/fire_falling_runner_harbor");
  level._effect["fire_embers_directional"] = loadfx("fire/fire_embers_directional");
  level._effect["ny_harbor_wavelargech2"] = loadfx("maps/ny_harbor/ny_harbor_wavelargech2");
  level._effect["fire_ceiling_sm_slow"] = loadfx("fire/fire_ceiling_sm_slow");
  level._effect["fire_line_sm_cheap"] = loadfx("fire/fire_line_sm_cheap");
  level._effect["fire_line_sm"] = loadfx("fire/fire_line_sm");
  level._effect["ny_harbor_wavelargech"] = loadfx("maps/ny_harbor/ny_harbor_wavelargech");
  level._effect["ny_harbor_wavech"] = loadfx("maps/ny_harbor/ny_harbor_wavech");
  level._effect["nyharbor_sub_breach"] = loadfx("maps/ny_harbor/nyharbor_sub_breach");
  level._effect["ny_column_top"] = loadfx("maps/ny_harbor/ny_column_top");
  level._effect["player_enter_water"] = loadfx("water/player_submerge");
  level._effect["sdv_prop_wash_2"] = loadfx("water/sdv_prop_wash_2");
  level._effect["nyharbor_propwash_surfacing_player"] = loadfx("maps/ny_harbor/nyharbor_propwash_surfacing_player");
  level._effect["nyharbor_propwash_surfacing_npc"] = loadfx("maps/ny_harbor/nyharbor_propwash_surfacing_npc");
  level._effect["car_breaklights"] = loadfx("misc/car_brakelight_bm21");
  level._effect["water_bubbles_longlife_lp"] = loadfx("water/water_bubbles_longlife_lp");
  level._effect["water_bubbles_longlife_sm_lp"] = loadfx("water/water_bubbles_longlife_sm_lp");
  level._effect["water_bubbles_wide_sm_lp"] = loadfx("water/water_bubbles_wide_sm_lp");
  level._effect["water_bubbles_wide_sm"] = loadfx("water/water_bubbles_wide_sm");
  level._effect["water_bubbles_random_runner_lp"] = loadfx("water/water_bubbles_random_runner_lp");
  level._effect["water_bubbles_lg_lp"] = loadfx("water/water_bubbles_lg_lp");
  level._effect["ny_harbor_submine_bubble_tiny"] = loadfx("maps/ny_harbor/ny_harbor_submine_bubble_tiny");
  level._effect["water_bubbles_tiny_cylind50"] = loadfx("water/water_bubbles_tiny_cylind50");
  level._effect["water_bubbles_trail_emit"] = loadfx("water/water_bubbles_trail_emit");
  level._effect["water_bubbles_trail_big_emit"] = loadfx("water/water_bubbles_trail_big_emit");
  level._effect["sub_waterdisp_tail"] = loadfx("water/sub_waterdisp_tail");
  level._effect["sub_waterdisp_fin_f"] = loadfx("water/sub_waterdisp_fin_f");
  level._effect["sub_waterdisp_head"] = loadfx("water/sub_waterdisp_head");
  level._effect["sub_waterdisp_midbody_offset"] = loadfx("water/sub_waterdisp_midbody_offset");
  level._effect["harbor_distort_cam"] = loadfx("maps/ny_harbor/harbor_distort_cam");
  level._effect["nyharbor_sdv_bubble_transition1"] = loadfx("maps/ny_harbor/nyharbor_sdv_bubble_transition1");
  level._effect["nyharbor_sdv_bubble_transition2"] = loadfx("maps/ny_harbor/nyharbor_sdv_bubble_transition2");
  level._effect["intro_player_scuba_bubble"] = loadfx("maps/ny_harbor/harbor_intro_player_scuba_bubble");
  level._effect["intro_npc_scuba_bubble"] = loadfx("maps/ny_harbor/harbor_intro_npc_scuba_bubble");
  level._effect["scuba_bubbles_breath_player"] = loadfx("water/scuba_bubbles_breath_player");
  level._effect["scuba_bubbles_NPC"] = loadfx("water/scuba_bubbles_breath_longlife");
  level._effect["underwater_particulates_player"] = loadfx("maps/ny_harbor/harbor_undrwtr_particulates_player");
  level._effect["underwater_particulates"] = loadfx("water/ny_harbor_underwater_particulates");
  level._effect["torch_flare"] = loadfx("misc/torch_cutting_fire_underwater");
  level._effect["torch_fire_gun"] = loadfx("misc/torch_cutting_fire_gun_underwater");
  level._effect["torch_metal_glow_underwater"] = loadfx("misc/torch_metal_glow_underwater");
  level._effect["torch_metal_glow_underwater_fade"] = loadfx("misc/torch_metal_glow_underwater_fade");
  level._effect["underwater_particulates_lit"] = loadfx("dust/light_shaft_dust_large");
  level._effect["underwater_particulates_glitter"] = loadfx("water/underwater_particulates_glitter");
  level._effect["ny_harbor_undrwtr_particulate_intro"] = loadfx("maps/ny_harbor/ny_harbor_undrwtr_particulate_intro");
  level._effect["ny_harbor_underwater_dust_bright"] = loadfx("water/ny_harbor_underwater_dust_bright");
  level._effect["ny_harbor_underwater_dust_narrow"] = loadfx("water/ny_harbor_underwater_dust_narrow");
  level._effect["ny_harbor_underwater_dust_tumble_wide"] = loadfx("water/ny_harbor_underwater_dust_tumble_wide");
  level._effect["ny_harbor_underwater_dust_swirl"] = loadfx("water/ny_harbor_underwater_dust_swirl");
  level._effect["underwater_dust_kick_minisub"] = loadfx("water/underwater_dust_kick_minisub");
  level._effect["fish_school_top_oilrig_base"] = loadfx("animals/fish_school_top_oilrig_base");
  level._effect["fish_school_side_large"] = loadfx("animals/fish_school_side_large");
  level._effect["ny_harbor_underwater_caustic"] = loadfx("water/ny_harbor_underwater_caustic");
  level._effect["ny_harbor_underwater_caustic_ray_long"] = loadfx("water/ny_harbor_underwater_caustic_ray_long");
  level._effect["light_strobe_undrwtr_mine"] = loadfx("lights/light_strobe_undrwtr_mine");
  level._effect["underwater_murk"] = loadfx("water/ny_harbor_underwater_murk");
  level._effect["underwater_murk_xlg"] = loadfx("water/ny_harbor_underwater_murk_xlg");
  level._effect["lights_underwater_godray"] = loadfx("lights/lights_underwater_godray");
  level._effect["lights_underwater_shadowLarge"] = loadfx("lights/lights_underwater_shadowLarge");
  level._effect["depth_charge_distance_ambient"] = loadfx("explosions/depth_charge_distance_ambient");
  level._effect["depth_charge_distance_ambient_sm"] = loadfx("explosions/depth_charge_distance_ambient_sm");
  level._effect["depth_charge_distance_amb_runr"] = loadfx("explosions/depth_charge_distance_amb_runr");
  level._effect["depth_charge_explosion"] = loadfx("explosions/depth_charge");
  level._effect["sub_surfacing_explosion1"] = loadfx("maps/ny_harbor/ny_sub_surfacing_explosion1");
  level._effect["sub_surfacing_explosion2"] = loadfx("maps/ny_harbor/ny_sub_surfacing_explosion2");
  level._effect["sub_surfacing_explosion3"] = loadfx("maps/ny_harbor/ny_sub_surfacing_explosion3");
  level._effect["ny_harbor_ship_sink_explo"] = loadfx("maps/ny_harbor/ny_harbor_ship_sink_explo");
  level._effect["ny_harbor_ship_sink_explo_post"] = loadfx("maps/ny_harbor/ny_harbor_ship_sink_explo_post");
  level._effect["ny_harbor_ship_sink_post_smk"] = loadfx("maps/ny_harbor/ny_harbor_ship_sink_post_smk");
  level._effect["ny_harbor_ship_sink_oil"] = loadfx("maps/ny_harbor/ny_harbor_ship_sink_oil");
  level._effect["ny_harbor_ship_sink_oil_l"] = loadfx("maps/ny_harbor/ny_harbor_ship_sink_oil_l");
  level._effect["floating_debris_xlg_underwater"] = loadfx("misc/floating_debris_xlg_underwater");
  level._effect["floating_obj_trash_underwater"] = loadfx("misc/floating_obj_trash_underwater");
  level._effect["floating_obj_sunglasses_undrwtr"] = loadfx("misc/floating_obj_sunglasses_undrwtr");
  level._effect["floating_obj_bottles_underwater"] = loadfx("misc/floating_obj_bottles_underwater");
  level._effect["floating_obj_boot_underwater"] = loadfx("misc/floating_obj_boot_underwater");
  level._effect["floating_obj_mug_underwater"] = loadfx("misc/floating_obj_mug_underwater");
  level._effect["floating_obj_soccerball_undrwtr"] = loadfx("misc/floating_obj_soccerball_undrwtr");
  level._effect["ny_carrier_crack"] = loadfx("maps/ny_harbor/ny_carrier_crack");
  level._effect["panel_flash_left"] = loadfx("maps/ny_harbor/sdv_panel_left");
  level._effect["panel_flash_right"] = loadfx("maps/ny_harbor/sdv_panel_right");
  level._effect["lead_sdv_beacon"] = loadfx("maps/ny_harbor/sdv_beacon");
  level._effect["light_glow_red_generic_pulse_harbor"] = loadfx("misc/light_glow_red_generic_pulse_harbor");
  level._effect["lighthaze_skylight"] = loadfx("misc/lighthaze_skylight");
  level._effect["lights_green_blinking"] = loadfx("lights/lights_green_blinking");
  level._effect["light_headlight"] = loadfx("lights/lights_headlight_harbor");
  level._effect["flashlight_spotlight"] = loadfx("misc/flashlight_spotlight_harbor");
  level._effect["lights_torch_cutting"] = loadfx("lights/lights_torch_cutting");
  level._effect["lights_grating_rays"] = loadfx("lights/lights_grating_rays");
  level._effect["godray_underwater"] = loadfx("misc/godray_underwater");
  level._effect["sub_propeller_propwash"] = loadfx("water/sub_propeller_propwash");
  level._effect["sub_volumetric_lightbeam2"] = loadfx("maps/ny_harbor/sub_volumetric_lightbeam2");
  level._effect["sub_volumetric_lightbeam2_static"] = loadfx("maps/ny_harbor/sub_volumetric_lightbeam2_static");
  level._effect["sub_volumetric_shadow_fin_front"] = loadfx("maps/ny_harbor/sub_volumetric_shadow_fin_front");
  level._effect["sub_volumetric_shadow_fin_rear"] = loadfx("maps/ny_harbor/sub_volumetric_shadow_fin_rear");
  level._effect["sub_ping"] = loadfx("misc/sonar_sub_ping");
  level._effect["mine_ping"] = loadfx("misc/sonar_mine_ping_scale1");
  level._effect["mine_ping_scale1"] = loadfx("misc/sonar_mine_ping_scale1");
  level._effect["mine_ping_scale2"] = loadfx("misc/sonar_mine_ping_scale2");
  level._effect["mine_ping_scale3"] = loadfx("misc/sonar_mine_ping_scale3");
  level._effect["mine_ping_scale4"] = loadfx("misc/sonar_mine_ping_scale4");
  level._effect["sonar_mine_ping_scrn_right"] = loadfx("misc/sonar_mine_ping_scrn_right");
  level._effect["sonar_mine_ping_scrn_left"] = loadfx("misc/sonar_mine_ping_scrn_left");
  level._effect["friend_ping"] = loadfx("misc/sonar_friend_ping");
  level._effect["flesh_hit"] = loadfx("impacts/flesh_hit_body_fatal_exit");
  level._effect["steam_room_ceiling"] = loadfx("smoke/steam_room_ceiling");
  level._effect["drips_slow"] = loadfx("misc/drips_slow");
  level._effect["drips_slow_sub_sfx"] = loadfx("misc/drips_slow_sub_sfx");
  level._effect["drips_fast"] = loadfx("misc/drips_fast");
  level._effect["drips_fast_sub_sfx"] = loadfx("misc/drips_fast_sub_sfx");
  level._effect["drips_fast_sub_2_sfx"] = loadfx("misc/drips_fast_sub_2_sfx");
  level._effect["waterfall_drainage_short_dcemp"] = loadfx("water/waterfall_drainage_short_dcemp");
  level._effect["waterfall_drainage_splash_dcemp"] = loadfx("water/waterfall_drainage_splash_dcemp");
  level._effect["falling_water_trickle"] = loadfx("water/falling_water_trickle");
  level._effect["ny_sub_heat_distortion"] = loadfx("maps/ny_harbor/ny_sub_heat_distortion");
  level._effect["sub_int_water_splash"] = loadfx("maps/ny_harbor/sub_int_water_splash");
  level._effect["sub_int_water_splash2"] = loadfx("maps/ny_harbor/sub_int_water_splash2");
  level._effect["powerline_runner"] = loadfx("explosions/powerline_runner");
  level._effect["powerline_runner_blue"] = loadfx("explosions/powerline_runner_blue");
  level._effect["powerline_runner_s_blue"] = loadfx("explosions/powerline_runner_s_blue");
  level._effect["powerline_runner_red"] = loadfx("explosions/powerline_runner_red");
  level._effect["powerline_runner_s_red"] = loadfx("explosions/powerline_runner_s_red");
  level._effect["powerline_runner_red_nolight"] = loadfx("explosions/powerline_runner_red_nolight");
  level._effect["hallway_smoke_dark"] = loadfx("smoke/hallway_smoke_dark");
  level._effect["ground_smoke_dcburning1200x1200"] = loadfx("smoke/ground_smoke1200x1200_dcburning");
  level._effect["steam_manhole"] = loadfx("smoke/steam_manhole");
  level._effect["red_steady_light"] = loadfx("misc/tower_light_red_sort_harbor");
  level._effect["steam_room_100"] = loadfx("smoke/steam_room_100");
  level._effect["steam_jet"] = loadfx("smoke/steam_jet_med_harbor");
  level._effect["steam_jet_loop"] = loadfx("smoke/steam_jet_med_loop_harbor");
  level._effect["steam_jet_loop_cheap"] = loadfx("smoke/steam_jet_loop_cheap");
  level._effect["steam_jet_loop_valve"] = loadfx("smoke/steam_jet_loop_valve");
  level._effect["lights_smokey_grating_sm"] = loadfx("lights/lights_smokey_grating_sm");
  level._effect["submarine_red_light"] = loadfx("misc/submarine_red_light");
  level._effect["chinook_red_light"] = loadfx("misc/chinook_red_light");
  level._effect["drips_fast"] = loadfx("misc/drips_fast");
  level._effect["drips_slow"] = loadfx("misc/drips_slow");
  level._effect["steam_vent_large_slow"] = loadfx("smoke/steam_vent_large_slow");
  level._effect["steam_vent_large_bright"] = loadfx("smoke/steam_vent_large_bright");
  level._effect["head_smash"] = loadfx("misc/blood_head_smash");
  level._effect["head_kick"] = loadfx("misc/blood_head_kick");
  level._effect["florescent_glow_blue"] = loadfx("misc/florescent_glow_blue");
  level._effect["breach_door_metal"] = loadfx("explosions/breach_door_metal");
  level._effect["breach_door_flash"] = loadfx("maps/ny_harbor/breach_door_flash");
  level._effect["sub_breach_door_seat_destroy"] = loadfx("maps/ny_harbor/sub_breach_door_seat_destroy");
  level._effect["steam_jet_s_loop"] = loadfx("smoke/steam_jet_s_loop");
  level._effect["steam_jet_s_loop_2"] = loadfx("smoke/steam_jet_s_loop_2");
  level._effect["light_glow_white_harbor"] = loadfx("misc/light_glow_white_harbor");
  level._effect["smoke_rolling_small"] = loadfx("smoke/smoke_rolling_small");
  level._effect["smoke_rolling_medium"] = loadfx("smoke/smoke_rolling_medium");
  level._effect["smoke_rolling_medium_cheap"] = loadfx("smoke/smoke_rolling_medium_cheap");
  level._effect["steam_vent_skinny_slow"] = loadfx("smoke/steam_vent_skinny_slow");
  level._effect["door_open_smokeout"] = loadfx("maps/ny_harbor/door_open_smokeout");
  level._effect["sub_grenade_decal"] = loadfx("maps/ny_harbor/sub_grenade_decal");
  level._effect["sub_missile_room_fire"] = loadfx("maps/ny_harbor/sub_missile_room_fire");
  level._effect["water_pipe_spray_2"] = loadfx("water/water_pipe_spray_2");
  level._effect["water_pipe_spray_3"] = loadfx("water/water_pipe_spray_3");
  level._effect["water_pipe_spray_4"] = loadfx("water/water_pipe_spray_4");
  level._effect["water_pipe_spray_5"] = loadfx("water/water_pipe_spray_5");
  level._effect["water_pipe_spray_6"] = loadfx("water/water_pipe_spray_6");
  level._effect["water_pipe_mist"] = loadfx("water/water_pipe_mist");
  level._effect["water_pipe_burst"] = loadfx("water/water_pipe_burst");
  level._effect["water_pipe_burst_2"] = loadfx("water/water_pipe_burst_2");
  level._effect["water_pipe_burst_3"] = loadfx("water/water_pipe_burst_3");
  level._effect["water_pipe_burst_4"] = loadfx("water/water_pipe_burst_4");
  level._effect["cpu_fire"] = loadfx("fire/cpu_fire");
  level._effect["lights_sub_alarm_strobe"] = loadfx("lights/lights_sub_alarm_strobe");
  level._effect["sub_engine_sparks"] = loadfx("maps/ny_harbor/sub_engine_sparks");
  level._effect["sub_water_floating_junk"] = loadfx("maps/ny_harbor/sub_water_floating_junk");
  level._effect["sub_water_floating_junk_2"] = loadfx("maps/ny_harbor/sub_water_floating_junk_2");
  level._effect["light_red_pinlight_sort"] = loadfx("lights/light_red_pinlight_sort");
  level._effect["light_green_pinlight"] = loadfx("lights/light_green_pinlight");
  level._effect["footstep_water"] = loadfx("maps/ny_harbor/footstep_water");
  level._effect["footstep_water_slow"] = loadfx("maps/ny_harbor/footstep_water_slow");
  level._effect["death_water"] = loadfx("maps/ny_harbor/death_water");
  level._effect["lights_godray_beam_harbor"] = loadfx("maps/ny_harbor/lights_godray_beam_harbor");
  level._effect["lighthaze_sub_ladder_distant"] = loadfx("maps/ny_harbor/lighthaze_sub_ladder_distant");
  level._effect["lighthaze_sub_ladder_bottom"] = loadfx("maps/ny_harbor/lighthaze_sub_ladder_bottom");
  level._effect["lighthaze_sub_ladder_bottom_fade"] = loadfx("maps/ny_harbor/lighthaze_sub_ladder_bottom_fade");
  level._effect["sub_monitor_explosion"] = loadfx("maps/ny_harbor/sub_monitor_explosion");
  level._effect["sub_monitor_explosion_m"] = loadfx("maps/ny_harbor/sub_monitor_explosion_m");
  level._effect["sub_monitor_explosion_m2"] = loadfx("maps/ny_harbor/sub_monitor_explosion_m2");
  level._effect["sub_monitor_explosion_r"] = loadfx("maps/ny_harbor/sub_monitor_explosion_r");
  level._effect["sub_monitor_explosion_s"] = loadfx("maps/ny_harbor/sub_monitor_explosion_s");
  level._effect["sub_control_room_smk"] = loadfx("maps/ny_harbor/sub_control_room_smk");
  level._effect["headshot"] = loadfx("impacts/flesh_hit_head_fatal_exit");
  level._effect["flashlight_ai"] = loadfx("misc/flashlight");
  level._effect["monitor_glow"] = loadfx("props/monitor_glow");
  level._effect["monitor_glow_point"] = loadfx("props/monitor_glow_point");
  level._effect["lights_point_white"] = loadfx("lights/lights_point_white");
  level._effect["ny_harbor_navalgunfirerunner"] = loadfx("misc/ny_harbor_navalgunfirerunner");
  level._effect["battleship_flash_large_withmissile"] = loadfx("maps/ny_harbor/battleship_flash_large_withmissile");
  level._effect["thick_dark_smoke_giant"] = loadfx("smoke/thick_dark_smoke_giant_nyharbor");
  level._effect["thick_dark_smoke_giant2"] = loadfx("smoke/thick_dark_smoke_giant_nyharbor");
  level._effect["ny_clouds"] = loadfx("weather/ny_clouds");
  level._effect["field_fire_distant"] = loadfx("fire/field_fire_distant");
  level._effect["ny_harbor_waterbarrage"] = loadfx("water/ny_harbor_waterbarrage");
  level._effect["ny_harbor_waterbarrage2"] = loadfx("water/ny_harbor_waterbarrage2");
  level._effect["ny_harbor_waterbarrageSlow"] = loadfx("water/ny_harbor_waterbarrageSlow");
  level._effect["ny_harbor_explosionVerticalbarrage"] = loadfx("explosions/fireball_nyharbor_verticalbarrage");
  level._effect["antiair_runner"] = loadfx("misc/antiair_runner_flak");
  level._effect["battlefield_smokebank_large"] = loadfx("smoke/battlefield_smokebank_large");
  level._effect["mist_sea"] = loadfx("weather/mist_sea");
  level._effect["slava_splash"] = loadfx("misc/slava_splash");
  level._effect["slava_water_floor_rush"] = loadfx("maps/ny_harbor/slava_water_floor_rush");
  level._effect["generic_explosions"] = loadfx("explosions/generic_explosion");
  level._effect["ny_battleship_sirench2"] = loadfx("maps/ny_harbor/ny_battleship_sirench2");
  level._effect["ny_battleship_sirenchlight2"] = loadfx("maps/ny_harbor/ny_battleship_sirenchlight2");
  level._effect["large_water_impact"] = loadfx("maps/ny_harbor/large_water_impact");
  level._effect["large_water_impact_close"] = loadfx("maps/ny_harbor/large_water_impact_close");
  level._effect["large_water_impact_close_rain"] = loadfx("maps/ny_harbor/large_water_impact_close_rain");
  level._effect["large_water_impact_close_wave"] = loadfx("maps/ny_harbor/large_water_impact_close_wave");
  level._effect["large_water_impact_close_rush"] = loadfx("maps/ny_harbor/large_water_impact_close_rush");
  level._effect["smoke_geotrail_genericexplosion"] = loadfx("smoke/smoke_geotrail_genericexplosion");
  level._effect["fireball_lp_smk_l"] = loadfx("fire/fireball_lp_smk_l");
  level._effect["fireball_lp_blue_smk_l"] = loadfx("fire/fireball_lp_blue_smk_l");
  level._effect["ny_blue_smk"] = loadfx("maps/ny_harbor/ny_blue_smk");
  level._effect["drifting_gray_smk_L"] = loadfx("smoke/drifting_gray_smk_L");
  level._effect["generic_explosion_debris"] = loadfx("explosions/generic_explosion_debris");
  level._effect["window_explosion_glass_only"] = loadfx("explosions/window_explosion_glass_only");
  level._effect["burning_oil_slick_1"] = loadfx("fire/burning_oil_slick_1");
  level._effect["burning_oil_slick_no_smk"] = loadfx("fire/burning_oil_slick_no_smk");
  level._effect["burning_oil_slick_1_reflect"] = loadfx("fire/burning_oil_slick_1_reflect");
  level._effect["sub_tail_foam"] = loadfx("maps/ny_harbor/sub_tail_foam");
  level._effect["hot_tub_bubbles"] = loadfx("maps/ny_harbor/hot_tub_bubbles");
  level._effect["sub_breaching_tail_steam"] = loadfx("maps/ny_harbor/sub_breaching_tail_steam");
  level._effect["sub_breaching_tail_steam_child"] = loadfx("maps/ny_harbor/sub_breaching_tail_steam_child");
  level._effect["sub_foam_lapping_waves"] = loadfx("maps/ny_harbor/sub_foam_lapping_waves");
  level._effect["sub_foam_lapping_waves"] = loadfx("maps/ny_harbor/sub_foam_lapping_waves");
  level._effect["sub_water_drainage"] = loadfx("maps/ny_harbor/sub_water_drainage");
  level._effect["carrier_foam_lapping_waves"] = loadfx("maps/ny_harbor/carrier_foam_lapping_waves");
  level._effect["carrier_deck_water_flow"] = loadfx("maps/ny_harbor/carrier_deck_water_flow");
  level._effect["waterfall_drainage_carrier"] = loadfx("water/waterfall_drainage_carrier");
  level._effect["waterfall_drainage_carrier_splash"] = loadfx("water/waterfall_drainage_carrier_splash");
  level._effect["carrier_underside_drips"] = loadfx("maps/ny_harbor/carrier_underside_drips");
  level._effect["wave_crest_spray"] = loadfx("maps/ny_harbor/wave_crest_spray");
  level._effect["wave_crest_spray_explosion"] = loadfx("maps/ny_harbor/wave_crest_spray_explosion");
  level._effect["fluorescent_glow"] = loadfx("misc/fluorescent_glow");
  level._effect["heli_water_harbor_cinematic"] = loadfx("treadfx/heli_water_harbor_cinematic");
  level._effect["lights_godray_beam"] = loadfx("lights/lights_godray_beam_bright");
  level._effect["smoke_geotrail_missile_large"] = loadfx("smoke/smoke_geotrail_missile_large");
  level._effect["missile_launch_large"] = loadfx("smoke/smoke_geotrail_missile_large");
  level._effect["smoke_geotrail_ssnMissile"] = loadfx("smoke/smoke_geotrail_ssnMissile");
  level._effect["ny_battleship_siren"] = loadfx("maps/ny_harbor/ny_battleship_siren");
  level._effect["ny_battleship_sirench"] = loadfx("maps/ny_harbor/ny_battleship_sirench");
  level._effect["cloud_bank_gulag_z_feather"] = loadfx("weather/cloud_bank_gulag_z_feather");
  level._effect["ny_battleship_sirenchlight"] = loadfx("maps/ny_harbor/ny_battleship_sirenchlight");
  level._effect["lights_strobe_red"] = loadfx("lights/lights_strobe_red");
  level._effect["ship_edge_foam_oriented"] = loadfx("water/ship_edge_foam_oriented");
  level._effect["ship_edge_foam_oriented_small"] = loadfx("water/ship_edge_foam_oriented_small");
  level._effect["ship_edge_foam_oriented_tiny"] = loadfx("water/ship_edge_foam_oriented_tiny");
  level._effect["ship_edge_foam_oriented_sm_shrt"] = loadfx("water/ship_edge_foam_oriented_sm_shrt");
  level._effect["corvette_explosion_front"] = loadfx("maps/ny_harbor/corvette_explosion_front");
  level._effect["corvette_explosion_front_reflect"] = loadfx("maps/ny_harbor/corvette_explosion_front_reflect");
  level._effect["burya_explosion_splash"] = loadfx("maps/ny_harbor/burya_explosion_splash");
  level._effect["destroyer_impact_splash"] = loadfx("maps/ny_harbor/destroyer_impact_splash");
  level._effect["destroyer_missile_impact"] = loadfx("maps/ny_harbor/destroyer_missile_impact");
  level._effect["ssn12_launch_smoke"] = loadfx("smoke/smoke_geotrail_ssnMissile");
  level._effect["ssn12_launch_smoke12"] = loadfx("maps/ny_harbor/smoke_ssnmissile12_launch");
  level._effect["ssn12_launch_smoke_trail"] = loadfx("smoke/smoke_geotrail_ssnMissile_trail");
  level._effect["ssn12_enhaust"] = loadfx("maps/ny_harbor/ny_ssn12_exhaust");
  level._effect["ssn12_init"] = loadfx("maps/ny_harbor/ny_ssn12_init");
  level._effect["ssn12_flash"] = loadfx("maps/ny_harbor/ny_ssn12_flash");
  level._effect["smoke_geotrail_ssnMissile12_trail"] = loadfx("smoke/smoke_geotrail_ssnMissile12_trail");
  level._effect["contrail12"] = loadfx("maps/ny_harbor/smoke_geo_ssnm12_cheap");
  level._effect["slava_missile_bg"] = loadfx("maps/ny_harbor/smoke_geo_ssnm12_cheap_background");
  level._effect["horizon_flash_runner"] = loadfx("weather/horizon_flash_runner_harbor");
  level._effect["steam_missile_tube"] = loadfx("maps/ny_harbor/steam_missile_tube");
  level._effect["heli_takeoff_swirl"] = loadfx("dust/heli_takeoff_swirl");
  level._effect["falling_dirt_light_runner"] = loadfx("dust/falling_dirt_light_runner");
  level._effect["cloud_ash_nyHarborm"] = loadfx("weather/cloud_ash_nyHarbor");
  level._effect["cloud_ash_lite_nyHarbor"] = loadfx("weather/cloud_ash_lite_nyHarbor");
  level._effect["firelp_med_pm_nolight_atlas"] = loadfx("fire/fire_med_pm_nolight_atlas");
  level._effect["building_collapse_nyharbor"] = loadfx("dust/building_collapse_nyharbor");
  level._effect["lights_godray_default"] = loadfx("lights/lights_conelight_default");
  level._effect["firelp_med_pm"] = loadfx("fire/firelp_med_pm");
  level._effect["firelp_small_pm"] = loadfx("fire/firelp_small_pm");
  level._effect["firelp_small_pm_a"] = loadfx("fire/firelp_small_pm_a");
  level._effect["firelp_large_pm"] = loadfx("fire/firelp_large_pm");
  level._effect["firelp_large_pm_r"] = loadfx("fire/firelp_large_pm");
  level._effect["firelp_large_pm_r_reflect"] = loadfx("fire/firelp_large_pm_reflect");
  level._effect["gazfire"] = loadfx("fire/firelp_small_pm");
  level._effect["large_column"] = loadfx("props/dcburning_pillars");
  level._effect["pipe_steam"] = loadfx("impacts/pipe_steam");
  level._effect["firelp_small_pm_nolight"] = loadfx("fire/firelp_small_pm_nolight");
  level._effect["minigun_shell_eject"] = loadfx("shellejects/20mm_mp");
  level._effect["player_death_explosion"] = loadfx("explosions/player_death_explosion");
  level._effect["bloodspurt_underwater"] = loadfx("water/blood_spurt_underwater");
  level._effect["drips_player_hand"] = loadfx("water/drips_player_hand");
  level._effect["wavebreak_oilrig_runner"] = loadfx("misc/wavebreak_oilrig_runner");
  level._effect["water_froth_oilrig"] = loadfx("misc/water_froth_oilrig");
  level._effect["water_froth_oilrig_leg_runner"] = loadfx("misc/water_froth_oilrig_leg_runner");
  level._effect["skybox_mig29_flyby_manual_loop"] = loadfx("misc/skybox_mig29_flyby_manual_loop");
  level._effect["skybox_hind_flyby"] = loadfx("misc/skybox_hind_flyby");
  level._effect["bird_seagull_flock_harbor"] = loadfx("misc/bird_seagull_flock_harbor");
  level._effect["body_splash_railing"] = loadfx("impacts/water_splash_bodydump");
  level._effect["sub_surface_runner"] = loadfx("water/sub_surface_runner");
  level._effect["thin_black_smoke_L"] = loadfx("smoke/thin_black_smoke_L");
  level._effect["light_c4_blink"] = loadfx("misc/light_c4_blink");

  if(getdvarint("sm_enable") && getdvar("r_zfeather") != "0") {
    level._effect["spotlight"] = loadfx("misc/hunted_spotlight_model");
  } else {
    level._effect["spotlight"] = loadfx("misc/spotlight_large");

  }
  level._effect["heli_dlight_blue"] = loadfx("misc/aircraft_light_cockpit_blue");
  level._effect["ship_explosion"] = loadfx("explosions/tanker_explosion");
  level._effect["small_splash_constant"] = loadfx("water/small_splash_constant");
  level._effect["ocean_ripple"] = loadfx("misc/ny_harbor_ripple");

  if(!isDefined(level._id_00AB)) {
    level._effect["zodiac_wake_geotrail"] = loadfx("treadfx/zodiac_wake_geotrail_harbor");

  }
  level._effect["zodiac_leftground"] = loadfx("misc/watersplash_large");
  level._effect["player_zodiac_bumpbig"] = loadfx("misc/watersplash_large");
  level._effect["zodiac_bumpbig"] = loadfx("misc/watersplash_large");
  level._id_4A69["zodiac_bumpbig"] = "tag_guy2";
  level._effect["player_zodiac_bump"] = loadfx("impacts/large_waterhit");
  level._effect["zodiac_bump"] = loadfx("impacts/large_waterhit");
  level._effect["zodiac_collision"] = loadfx("misc/watersplash_large");
  level._id_4A69["zodiac_collision"] = "TAG_DEATH_FX";

  if(!isDefined(level._id_00AB)) {
    level._effect["zodiac_bounce_small_left"] = loadfx("water/zodiac_splash_bounce_small");
    level._id_4A69["zodiac_bounce_small_left"] = "TAG_FX_LF";
    level._effect["zodiac_bounce_small_right"] = loadfx("water/zodiac_splash_bounce_small");
    level._id_4A69["zodiac_bounce_small_right"] = "TAG_FX_RF";
    level._effect["zodiac_bounce_large_left"] = loadfx("water/zodiac_splash_bounce_large");
    level._id_4A69["zodiac_bounce_large_left"] = "TAG_FX_LF";
    level._effect["zodiac_bounce_large_right"] = loadfx("water/zodiac_splash_bounce_large");
    level._id_4A69["zodiac_bounce_large_right"] = "TAG_FX_RF";
    level._effect["zodiac_sway_left"] = loadfx("water/zodiac_splash_turn_hard");
    level._id_4A69["zodiac_sway_left"] = "TAG_FX_LF";
    level._effect["zodiac_sway_right"] = loadfx("water/zodiac_splash_turn_hard");
    level._id_4A69["zodiac_sway_right"] = "TAG_FX_RF";
    level._effect["zodiac_sway_left_light"] = loadfx("water/zodiac_splash_turn_light");
    level._id_4A69["zodiac_sway_left_light"] = "TAG_FX_LF";
    level._effect["zodiac_sway_right_light"] = loadfx("water/zodiac_splash_turn_light");
    level._id_4A69["zodiac_sway_right_light"] = "TAG_FX_RF";
  }

  level._id_4A6A["bump_big_start"] = 2;
  level._id_4A6A["bump_small_start"] = 1;
  level._id_4A6A["bump_big_after_rapids"] = 4;
  level._id_4A6A["bump_small_after_rapids"] = 2;
  level._id_4A6A["bump_big_player_dies"] = 7;
  level._id_4A6A["bump_small_player_dies"] = 3;
}

_id_4A6B() {
  wait 2.0;
  var_0 = common_scripts\utility::getfx("water_bubbles_wide_sm_lp");
  var_1 = [(-16310.6, -24354.9, -1660.94), (-16400.8, -24309.7, -1662.02), (-16497.9, -24267.3, -1664.36), (-16689, -24187.2, -1671.44), (-16783.8, -24151.6, -1675.71), (-17898, -23897.2, -1706.4), (-17587.8, -23942.8, -1699.35), (-17183.5, -24031.1, -1684.73), (-17383.1, -23981.5, -1691.34), (-17690.4, -23924.1, -1700.39), (-17997.1, -23893.5, -1710.37), (-18209.7, -23879.2, -1717.74), (-18417.6, -23876.2, -1725.78), (-18518.1, -23878.1, -1729.52), (-15934.2, -24096.8, -1654.38), (-16135.8, -23991.6, -1662.13), (-16340.3, -23893.1, -1667.33), (-16442.7, -23853.6, -1669.35), (-16653.4, -23773.4, -1673.12), (-16866, -23704.7, -1678.58), (-16758.7, -23736, -1675.3), (-17083.3, -23642.4, -1684.83), (-18426.4, -23476.4, -1726.16), (-18765.5, -23491.6, -1736.59), (-18308, -23478.5, -1720.63), (-16589.9, -24224.3, -1664.82), (-16217.1, -24399.8, -1658.26)];
  var_2 = [(270.001, 359.927, -119.927), (270.001, 359.653, -113.653), (270.001, 359.788, -107.788), (270.001, 359.788, -107.788), (270.001, 359.788, -107.788), (270.002, 359.876, -97.8751), (270.001, 359.931, -99.931), (270.001, 359.861, -107.86), (270.001, 359.861, -107.86), (270.001, 359.861, -107.86), (270.002, 359.938, -99.9375), (270.002, 359.939, -89.9384), (270.002, 359.939, -89.9384), (270.002, 359.94, -87.9397), (270.002, 359.888, 62.1124), (270.002, 359.787, 68.2136), (270.002, 359.79, 70.2103), (270.002, 359.736, 68.2638), (270.002, 359.736, 68.2638), (270.002, 359.736, 68.2638), (270.002, 359.736, 68.2638), (270.002, 359.736, 68.2638), (270.002, 359.641, 92.3588), (270.002, 359.949, 94.0513), (270.002, 359.948, 94.0518), (270.001, 359.788, -107.788), (270.001, 359.927, -119.927)];
  var_3 = [];

  for(;;) {
    common_scripts\utility::flag_wait("fx_zone_1000_active");

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_3[var_4] = spawnfx(var_0, var_1[var_4], anglesToForward(var_2[var_4]), anglestoup(var_2[var_4]));
      triggerfx(var_3[var_4]);
    }

    common_scripts\utility::flag_waitopen("fx_zone_1000_active");

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_3[var_4] delete();
    }
  }
}

_id_4A6C() {
  wait 2.0;
  var_0 = common_scripts\utility::getfx("water_bubbles_longlife_sm_lp");
  var_1 = [(-19169.2, -23550.2, -1620.38), (-17729.9, -23753.6, -1691.15), (-16714.1, -23923.9, -1686.64), (-17500.4, -23808.9, -1711.69), (-18807.6, -23672.9, -1725.55), (-18674.8, -23735.8, -1742.5), (-18236.5, -23736.7, -1710.42), (-16923.1, -23960.2, -1651.07), (-16422.9, -24120.7, -1676.75), (-17101.3, -24057.6, -1605.14), (-17102.5, -24057.6, -1663.11), (-17568.7, -23952.2, -1619.49), (-17568.7, -23952.2, -1676.49), (-18042.9, -23895.6, -1635.93), (-18043, -23896.5, -1693.51), (-18517.3, -23887.7, -1652.97), (-18983.3, -23927.8, -1669.41), (-19051.3, -23460, -1642.84), (-18537.1, -23415.3, -1627.26), (-18013.9, -23423.6, -1611.15), (-17491.6, -23485.4, -1594.57), (-16221.2, -24407.5, -1581.35), (-16651.4, -24209.9, -1648.76)];
  var_2 = [];

  for(;;) {
    common_scripts\utility::flag_wait("fx_zone_1000_active");

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      var_2[var_3] = spawnfx(var_0, var_1[var_3]);
      triggerfx(var_2[var_3]);
    }

    common_scripts\utility::flag_waitopen("fx_zone_1000_active");

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2[var_3] delete();
    }
  }
}

_id_4A6D() {
  level endon("msg_fx_player_surfaced");

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("underwater_particulates_player"), self, "TAG_PROPELLER");
    wait 0.25;
  }
}

_id_4A6E() {
  level endon("msg_fx_intro_end");
  level endon("msg_fx_player_surfaced");

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("harbor_distort_cam"), self, "TAG_PROPELLER");
    wait 1;
  }
}

_id_4A6F() {
  self endon("death");

  for(;;) {
    self setModel("ny_harbor_tunnel_evacuation_sign_01_alt");
    wait(randomfloatrange(0.001, 0.15));
    self setModel("ny_harbor_tunnel_evacuation_sign_01");
    wait(randomfloatrange(0.001, 0.25));
  }
}

_id_4A70() {
  self endon("death");

  for(;;) {
    self setModel("vehicle_taxi_rooftop_ad_base_on");
    wait 0.5;
    self setModel("vehicle_taxi_rooftop_ad_base_off");
    wait 0.15;
    self setModel("vehicle_taxi_rooftop_ad_base_on");
    wait 0.3;
    self setModel("vehicle_taxi_rooftop_ad_base_off");
    wait 0.65;
  }
}

_id_4A71() {
  self endon("death");

  for(;;) {
    self setModel("vehicle_taxi_rooftop_ad_2_on");
    wait 0.5;
    self setModel("vehicle_taxi_rooftop_ad_2");
    wait 0.15;
    self setModel("vehicle_taxi_rooftop_ad_2_on");
    wait 0.3;
    self setModel("vehicle_taxi_rooftop_ad_2");
    wait 0.65;
  }
}

_id_4A72() {
  level endon("msg_fx_intro_end");

  for(;;) {
    maps\_audio::aud_send_msg("player_scuba_bubbles");
    playFXOnTag(common_scripts\utility::getfx("intro_player_scuba_bubble"), self, "TAG_PLAYER");
    wait(6.0 + randomfloat(1));
  }
}

_id_4A73() {
  level endon("msg_fx_intro_end");

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("intro_npc_scuba_bubble"), self, "TAG_EYE");
    wait(2.5 + randomfloat(2));
  }
}

_id_4A74() {
  common_scripts\utility::exploder(1010);
  wait 9;
  maps\_utility::_id_2693(1010);
  level notify("msg_torch_flare_fx_end");
}

_id_4A75() {
  maps\_utility::vision_set_fog_changes("ny_harbor_intro_dark", 0);
  setblur(5, 0);
  wait 4;
  maps\_utility::vision_set_fog_changes("ny_harbor_intro", 1);
  setblur(0, 0.75);
}

_id_4A76() {
  wait 5;

  for(var_0 = 0; var_0 < 2; var_0++) {
    var_1 = getdvar("vision_set_current");
    visionsetnaked("ny_harbor_torch_contrast", 0.1);
    wait(0.1 + randomfloat(0.2));
    visionsetnaked("generic_flash", 0);
    maps\_audio::aud_send_msg("torch_screen_flash");
    setblur(8, 0);
    level.player sethuddynlight(1, (1, 1, 1));
    wait(0.01 + randomfloat(0.02));
    visionsetnaked(var_1, 0.4);
    setblur(0, 0.6);
    level.player sethuddynlight(300, (0, 0, 0));
    wait(1.5 + randomfloat(0.5));
  }
}

_id_4A77() {
  wait 5;
  var_0 = level._id_1436;
  var_1 = [];
  var_1["nearStart"] = 1;
  var_1["nearEnd"] = 2;
  var_1["nearBlur"] = 8;
  var_1["farStart"] = 30;
  var_1["farEnd"] = 420;
  var_1["farBlur"] = 7;
  maps\_utility::_id_27C0(var_0, var_1, 0.2);
  wait 10;
  maps\_utility::_id_27C0(var_1, var_0, 1);
}

_id_4A78() {
  setsaveddvar("r_specularcolorscale", 3.25);
  wait 15;
  var_0 = 0.1875;
  var_1 = 3.25;

  while(var_1 > 2.5) {
    var_1 = var_1 - var_0;
    setsaveddvar("r_specularcolorscale", var_1);
    wait 0.05;
  }

  setsaveddvar("r_specularcolorscale", 2.5);
}

_id_4A79() {
  common_scripts\utility::flag_wait("hatch_player_using_ladder");
  wait 0.05;
  var_0 = 0.0416667;
  var_1 = 0.25;

  while(var_1 > 0.075) {
    var_1 = var_1 - var_0;
    setsaveddvar("sm_sunsamplesizenear", var_1);
    wait 0.05;
  }

  setsaveddvar("sm_sunsamplesizenear", 0.075);
  wait 5;
  setsaveddvar("sm_sunsamplesizenear", 0.25);
}

_id_4A7A() {
  common_scripts\utility::flag_wait("get_on_zodiac");
  wait 1;
  var_0 = 0.0416667;
  var_1 = 0.25;

  while(var_1 > 0.075) {
    var_1 = var_1 - var_0;
    setsaveddvar("sm_sunsamplesizenear", var_1);
    wait 0.05;
  }

  wait 1.5;
  setsaveddvar("sm_sunsamplesizenear", 0.25);
}

_id_4A7B() {
  common_scripts\utility::exploder(1020);
  wait 15;
  maps\_shg_fx::_id_4467(1020);
}

_id_4A7C() {
  wait 0;
  common_scripts\utility::exploder(50000);
  common_scripts\utility::exploder(50001);
  common_scripts\utility::exploder(50002);
  common_scripts\utility::exploder(50003);
  common_scripts\utility::exploder(50004);
  common_scripts\utility::exploder(50005);
  common_scripts\utility::exploder(50006);
  common_scripts\utility::exploder(50007);
  common_scripts\utility::exploder(50008);
  common_scripts\utility::exploder(50009);
  common_scripts\utility::exploder(50010);
  common_scripts\utility::exploder(50011);
  common_scripts\utility::exploder(50012);
  maps\_utility::delaythread(10.03, maps\_shg_fx::_id_4467, 50000);
  maps\_utility::delaythread(10, common_scripts\utility::exploder, 51000);
  maps\_utility::delaythread(6.53, maps\_shg_fx::_id_4467, 50001);
  maps\_utility::delaythread(6.5, common_scripts\utility::exploder, 51001);
  maps\_utility::delaythread(7.03, maps\_shg_fx::_id_4467, 50002);
  maps\_utility::delaythread(7, common_scripts\utility::exploder, 51002);
  maps\_utility::delaythread(7.13, maps\_shg_fx::_id_4467, 50003);
  maps\_utility::delaythread(7.1, common_scripts\utility::exploder, 51003);
  maps\_utility::delaythread(8.03, maps\_shg_fx::_id_4467, 50004);
  maps\_utility::delaythread(8, common_scripts\utility::exploder, 51004);
  maps\_utility::delaythread(7.53, maps\_shg_fx::_id_4467, 50005);
  maps\_utility::delaythread(7.5, common_scripts\utility::exploder, 51005);
  maps\_utility::delaythread(11.03, maps\_shg_fx::_id_4467, 50006);
  maps\_utility::delaythread(11, common_scripts\utility::exploder, 51006);
  maps\_utility::delaythread(10.23, maps\_shg_fx::_id_4467, 50007);
  maps\_utility::delaythread(10.2, common_scripts\utility::exploder, 51007);
  maps\_utility::delaythread(8.23, maps\_shg_fx::_id_4467, 50008);
  maps\_utility::delaythread(8.2, common_scripts\utility::exploder, 51008);
  maps\_utility::delaythread(7.23, maps\_shg_fx::_id_4467, 50009);
  maps\_utility::delaythread(7.2, common_scripts\utility::exploder, 51009);
  maps\_utility::delaythread(7.03, maps\_shg_fx::_id_4467, 50010);
  maps\_utility::delaythread(7, common_scripts\utility::exploder, 51010);
  maps\_utility::delaythread(6.83, maps\_shg_fx::_id_4467, 50011);
  maps\_utility::delaythread(6.8, common_scripts\utility::exploder, 51011);
  maps\_utility::delaythread(6.23, maps\_shg_fx::_id_4467, 50012);
  maps\_utility::delaythread(6.2, common_scripts\utility::exploder, 51012);
}

_id_4A7D() {
  wait 15.1;
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_tiny_cylind50"), self, "grate");
  wait 0.1;
  common_scripts\utility::exploder(1030);
  wait 5;
  stopFXOnTag(common_scripts\utility::getfx("water_bubbles_tiny_cylind50"), self, "grate");
}

_id_4A7E() {
  level waittill("bubble_wash_player_out_gate");
  wait 5.5;
  playFXOnTag(common_scripts\utility::getfx("scuba_bubbles_breath_player"), level._id_49C1, "TAG_PLAYER");
  wait 1.5;
  playFXOnTag(common_scripts\utility::getfx("scuba_bubbles_breath_player"), level._id_49C1, "TAG_PLAYER");
  wait 1.0;
  playFXOnTag(common_scripts\utility::getfx("scuba_bubbles_breath_player"), level._id_49C1, "TAG_PLAYER");
}

_id_4A7F() {
  common_scripts\utility::flag_wait("start_sinking");
  thread _id_4A87();
  thread _id_4A82();
  thread _id_4A83();
  thread _id_4A84();
  thread _id_4A80();
  common_scripts\utility::flag_wait("sinking_ship_fx");
  thread _id_4A86();
}

_id_4A80() {
  var_0 = spawnStruct();
  _id_4A85("2900", var_0);
  var_1 = var_0.v["origins"];
  var_2 = var_0.v["angles"];
  var_3 = var_0.v["ents"];
  var_4 = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_4[var_5] = 0;

  }
  var_6 = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6[var_5] = common_scripts\utility::spawn_tag_origin();
    var_6[var_5].origin = var_1[var_5];
    var_6[var_5].angles = var_2[var_5];
    var_6[var_5] linkto(level._id_4A81, "tag_origin");
  }

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    common_scripts\utility::flag_wait("sinking_ship_fx");
    playFXOnTag(common_scripts\utility::getfx("ny_harbor_ship_sink_explo"), var_6[var_5], "tag_origin");
    maps\_audio::aud_send_msg("ship_sink_flash_explosion", var_6[var_5]);
    var_4[var_5] = 1;
  }

  common_scripts\utility::flag_wait("russian_sub_spawned");

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    stopFXOnTag(common_scripts\utility::getfx("ny_harbor_ship_sink_explo"), var_6[var_5], "tag_origin");
    var_6[var_5] delete();
  }
}

_id_4A82() {
  var_0 = spawnStruct();
  _id_4A85("2905", var_0);
  var_1 = var_0.v["origins"];
  var_2 = var_0.v["angles"];
  var_3 = var_0.v["ents"];
  var_4 = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_4[var_5] = common_scripts\utility::spawn_tag_origin();
    var_4[var_5].origin = var_1[var_5];
    var_4[var_5].angles = var_2[var_5];
    var_4[var_5] linkto(level._id_4A81, "tag_origin");
  }

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    playFXOnTag(common_scripts\utility::getfx("ny_harbor_ship_sink_explo_post"), var_4[var_5], "tag_origin");

  }
  common_scripts\utility::flag_wait("russian_sub_spawned");

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    stopFXOnTag(common_scripts\utility::getfx("ny_harbor_ship_sink_explo_post"), var_4[var_5], "tag_origin");
    var_4[var_5] delete();
  }
}

_id_4A83() {
  var_0 = spawnStruct();
  _id_4A85("2910", var_0);
  var_1 = var_0.v["origins"];
  var_2 = var_0.v["angles"];
  var_3 = var_0.v["ents"];
  var_4 = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_4[var_5] = common_scripts\utility::spawn_tag_origin();
    var_4[var_5].origin = var_1[var_5];
    var_4[var_5].angles = var_2[var_5];
    var_4[var_5] linkto(level._id_4A81, "tag_origin");
  }

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    playFXOnTag(common_scripts\utility::getfx("water_bubbles_lg_lp"), var_4[var_5], "tag_origin");

  }
  common_scripts\utility::flag_wait("russian_sub_spawned");

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    stopFXOnTag(common_scripts\utility::getfx("water_bubbles_lg_lp"), var_4[var_5], "tag_origin");
    var_4[var_5] delete();
  }
}

_id_4A84() {
  var_0 = spawnStruct();
  _id_4A85("2915", var_0);
  var_1 = var_0.v["origins"];
  var_2 = var_0.v["angles"];
  var_3 = var_0.v["ents"];
  var_4 = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_4[var_5] = common_scripts\utility::spawn_tag_origin();
    var_4[var_5].origin = var_1[var_5];
    var_4[var_5].angles = var_2[var_5];
    var_4[var_5] linkto(level._id_4A81, "tag_origin");
  }

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    playFXOnTag(common_scripts\utility::getfx("ny_harbor_ship_sink_post_smk"), var_4[var_5], "tag_origin");

  }
  common_scripts\utility::flag_wait("russian_sub_spawned");

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    stopFXOnTag(common_scripts\utility::getfx("ny_harbor_ship_sink_post_smk"), var_4[var_5], "tag_origin");
    var_4[var_5] delete();
  }
}

_id_4A85(var_0, var_1) {
  var_2 = [];
  var_3 = [];
  var_4 = [];
  var_5 = maps\_utility::string(var_0);
  var_6 = maps\_shg_fx::_id_4446(var_5);

  if(isDefined(var_6)) {
    foreach(var_8 in var_6) {
      var_2[var_2.size] = var_8.v["origin"];
      var_3[var_3.size] = var_8.v["angles"];
      var_4[var_4.size] = var_8;
    }
  }

  var_1.v["origins"] = var_2;
  var_1.v["angles"] = var_3;
  var_1.v["ents"] = var_4;
}

_id_4A86() {
  level.player _id_4AD4(0);
  var_0 = getdvar("vision_set_current");
  visionsetnaked("ny_harbor_undrwtr_explo_flash_strong", 0.1);
  wait 0.1;
  visionsetnaked(var_0, 0.15);
  level.player _id_4AD4(1);
}

_id_4A87() {
  maps\_audio::aud_send_msg("sinking_ship_debris_splash");
  common_scripts\utility::exploder(2920);
  common_scripts\utility::flag_wait("russian_sub_spawned");
  maps\_shg_fx::_id_4467(2920);
}

_id_4A88() {
  level waittill("start_submarine02");
  wait 1.65;
  playFXOnTag(common_scripts\utility::getfx("underwater_dust_kick_minisub"), level._id_4970, "TAG_PLAYER");
}

_id_4A89() {
  common_scripts\utility::flag_wait("detonate_torpedo");
  wait 2.3;
  maps\_shg_fx::_id_4449("depth_charge_distance_amb_runr");
}

_id_4A8A() {
  common_scripts\utility::flag_wait("detonate_torpedo");
  wait 2.5;
  common_scripts\utility::exploder(4011);
  wait 0.45;
  common_scripts\utility::exploder(4012);
}

_id_4A8B() {
  common_scripts\utility::flag_wait("russian_sub_spawned");
  playFXOnTag(common_scripts\utility::getfx("sub_propeller_propwash"), level._id_49C3, "tag_left_porpeller");
  playFXOnTag(common_scripts\utility::getfx("sub_propeller_propwash"), level._id_49C3, "tag_right_propeller");
  level waittill("submine_planted");
  stopFXOnTag(common_scripts\utility::getfx("sub_propeller_propwash"), level._id_49C3, "tag_left_porpeller");
  stopFXOnTag(common_scripts\utility::getfx("sub_propeller_propwash"), level._id_49C3, "tag_right_propeller");
}

_id_4A8C() {
  common_scripts\utility::flag_wait("detonate_torpedo");
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_emit"), level._id_49C3, "tag_fx_ventback_single4");
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_emit"), level._id_49C3, "tag_fx_ventback_single5");
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_emit"), level._id_49C3, "tag_fx_fin_b_right");
  playFXOnTag(common_scripts\utility::getfx("sub_waterdisp_fin_f"), level._id_49C3, "tag_fx_fin_f_right");
  playFXOnTag(common_scripts\utility::getfx("sub_waterdisp_tail"), level._id_49C3, "tag_fx_fin_b");
  playFXOnTag(common_scripts\utility::getfx("sub_waterdisp_head"), level._id_49C3, "tag_fx_wake");
  playFXOnTag(common_scripts\utility::getfx("sub_waterdisp_midbody_offset"), level._id_49C3, "tag_origin");
  level waittill("entering_mine_plant");
  stopFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_emit"), level._id_49C3, "tag_fx_ventback_single4");
  stopFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_emit"), level._id_49C3, "tag_fx_ventback_single5");
  stopFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_emit"), level._id_49C3, "tag_fx_fin_b_right");
  stopFXOnTag(common_scripts\utility::getfx("sub_waterdisp_fin_f"), level._id_49C3, "tag_fx_fin_f_right");
  stopFXOnTag(common_scripts\utility::getfx("sub_waterdisp_tail"), level._id_49C3, "tag_fx_fin_b");
  stopFXOnTag(common_scripts\utility::getfx("sub_waterdisp_head"), level._id_49C3, "tag_fx_wake");
  stopFXOnTag(common_scripts\utility::getfx("sub_waterdisp_midbody_offset"), level._id_49C3, "tag_origin");
}

_id_4A8D() {
  level waittill("entering_mine_plant");
  playFXOnTag(common_scripts\utility::getfx("nyharbor_sdv_bubble_transition1"), level._id_4970._id_4A8E, "TAG_PLAYER");
}

_id_4A8F() {
  level waittill("starting_mine_plant");
}

_id_4A90() {
  level waittill("starting_mine_plant");
  wait 2.7;
  playFXOnTag(common_scripts\utility::getfx("nyharbor_sdv_bubble_transition2"), level._id_49C1, "TAG_PLAYER");
}

_id_4A91() {
  playFXOnTag(common_scripts\utility::getfx("ny_harbor_submine_bubble_tiny"), self, "TAG_FX");
  wait 5.0;
  stopFXOnTag(common_scripts\utility::getfx("ny_harbor_submine_bubble_tiny"), self, "TAG_FX");
}

_id_4A92() {
  level waittill("entering_mine_plant");
  var_0 = "ny_harbor_underwater_caustic_ray_long";
  var_1 = level.createfxbyfxid[var_0];

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(var_3.v["exploder"] == "3000") {
        var_3 common_scripts\utility::pauseeffect();
      }
    }
  }

  common_scripts\utility::exploder(4001);
  level waittill("msg_fx_player_surfaced");
  maps\_shg_fx::_id_4467(4001);
}

_id_4A93() {
  common_scripts\utility::flag_wait("detonate_sub");
  thread _id_4A95();
  wait 0.05;
  playFXOnTag(common_scripts\utility::getfx("sub_surfacing_explosion1"), level._id_4A94, "tag_weapon");
  level.player thread _id_4AD3();
  earthquake(0.3, 1.7, level.player.origin, 1024);
  common_scripts\utility::flag_wait("submine_detonated");
  wait 0.7;
  thread _id_4A95();
  wait 0.05;
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0 linkto(level._id_4A49, "tag_fx_fin_b_left", (175, 0, 450), (0, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("sub_surfacing_explosion2"), var_0, "tag_origin");
  level.player thread _id_4AD3();
  earthquake(0.25, 1.7, level.player.origin, 1024);
  wait 1.85;
  thread _id_4A95();
  wait 0.05;
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 linkto(level._id_4A49, "tag_fx_ventback_single7", (-200, -100, -100), (0, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("sub_surfacing_explosion3"), var_1, "tag_origin");
  level.player thread _id_4AD3();
  earthquake(0.4, 1.7, level.player.origin, 1024);
  level notify("sub_surfacing_explosion_vfx_end");
  wait 1.0;
  earthquake(0.25, 5, level.player.origin, 2048);
}

_id_4A95() {
  level.player _id_4AD4(0);
  level.player _id_4AD6(0);
  var_0 = getdvar("vision_set_current");
  setblur(10, 0.5);
  visionsetnaked("ny_harbor_torch_contrast", 0.05);
  wait 0.06;
  visionsetnaked("ny_harbor_undrwtr_explo_flash_light", 0.05);
  level.player sethuddynlight(1, (1, 1, 1));
  wait 0.1;
  visionsetnaked(var_0, 0.1);
  setblur(0, 0.5);
  level.player sethuddynlight(100, (0, 0, 0));
  level.player _id_4AD4(1);
  level.player _id_4AD6(1);
}

_id_4A96() {
  common_scripts\utility::flag_wait("submine_planted");
  wait 4.0;
  playFXOnTag(common_scripts\utility::getfx("sub_waterdisp_midbody_offset"), level._id_4A49, "tag_origin");
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_ventback_four1");
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_ventback_single1");
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_ventback_single3");
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_ventback_single5");
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_ventback_single7");
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_vent8");
  wait 0.2;
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_vent7");
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_vent6");
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_tower_back");
  common_scripts\utility::flag_wait("submine_detonated");
  stopFXOnTag(common_scripts\utility::getfx("sub_waterdisp_midbody_offset"), level._id_4A49, "tag_origin");
  level waittill("sub_surfacing_explosion_vfx_end");
  wait 2.0;
  stopFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_ventback_four1");
  stopFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_ventback_single1");
  stopFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_ventback_single3");
  wait 0.1;
  stopFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_ventback_single5");
  stopFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_ventback_single7");
  stopFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_vent8");
  wait 0.1;
  stopFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_vent7");
  stopFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_vent6");
  stopFXOnTag(common_scripts\utility::getfx("water_bubbles_trail_big_emit"), level._id_4A49, "tag_fx_tower_back");
}

_id_4A97() {
  level waittill("sub_surfacing_explosion_vfx_end");
  playFXOnTag(common_scripts\utility::getfx("nyharbor_propwash_surfacing_npc"), level._id_4A98, "J_Ball_LE");
  playFXOnTag(common_scripts\utility::getfx("nyharbor_propwash_surfacing_npc"), level._id_4A98, "J_Ball_RI");
  wait 2.0;
  playFXOnTag(common_scripts\utility::getfx("scuba_bubbles_NPC"), level._id_4A98, "TAG_EYE");
  level waittill("msg_fx_player_surfaced");
  wait 2.0;
  stopFXOnTag(common_scripts\utility::getfx("nyharbor_propwash_surfacing_npc"), level._id_4A98, "J_Ball_LE");
  stopFXOnTag(common_scripts\utility::getfx("nyharbor_propwash_surfacing_npc"), level._id_4A98, "J_Ball_RI");
  stopFXOnTag(common_scripts\utility::getfx("scuba_bubbles_NPC"), level._id_4A98, "TAG_EYE");
}

_id_4A99() {
  level waittill("sub_surfacing_explosion_vfx_end");
  wait 1.85;
  playFXOnTag(common_scripts\utility::getfx("nyharbor_propwash_surfacing_player"), level._id_49C1, "tag_camera");
  wait 1.4;
  thread _id_4A9A();
}

_id_4A9A() {
  setblur(4, 0.5);
  wait 0.2;
  level.player _id_4AD4(0);
  level.player _id_4AD6(0);
  var_0 = getdvar("vision_set_current");
  wait 0.5;
  visionsetnaked("ny_harbor_player_surfacing", 0.75);
  level.player sethuddynlight(500, (1, 1, 1));
  wait 0.35;
  thread _id_4A9B();
  wait 0.65;
  visionsetnaked(var_0, 0.35);
  level.player sethuddynlight(100, (0, 0, 0));
  level.player _id_4AD4(1);
  level.player _id_4AD6(1);
  wait 0.5;
  setblur(0, 0.5);
}

_id_4A9B() {
  var_0 = getent("harbor_underwater_geo", "script_noteworthy");
  var_0 hide();
}

_id_477E() {
  self waittill("msg_fx_start_hindDust");
  playFX(common_scripts\utility::getfx("heli_takeoff_swirl"), (-671, 598, 16), anglesToForward((0, 318, 0)), (1, 0, 0));
}

_id_4A9E() {
  for(;;) {
    self waittill("moving");

    if(maps\_utility::_id_1008("moving")) {
      thread maps\_utility::play_sound_on_tag("veh_blackshadow_startup", "TAG_PROPELLER");
      maps\_utility::delaythread(1, maps\_utility::_id_258E, "veh_blackshadow_bubble_trail_01", "TAG_PROPELLER", 1);
      maps\_utility::delaythread(1, maps\_utility::_id_258E, "veh_blackshadow_loop", "TAG_PROPELLER", 1);
      continue;
    }

    self notify("stop soundveh_blackshadow_loop");
    self notify("stop soundveh_blackshadow_bubble_trail_01");
    thread maps\_utility::play_sound_on_tag("veh_blackshadow_stop", "TAG_PROPELLER");
  }
}

_id_4A9F() {
  for(;;) {
    self waittill("moving");

    if(maps\_utility::_id_1008("moving")) {
      maps\_utility::delaythread(1, maps\_utility::_id_258E, "veh_blackshadow_bubble_trail_02", "TAG_PROPELLER", 1);
      maps\_utility::delaythread(1, maps\_utility::_id_258E, "veh_blackshadow_loop_npc", "TAG_PROPELLER", 1);
      continue;
    }

    self notify("stop soundveh_blackshadow_loop_npc");
    self notify("stop soundveh_blackshadow_bubble_trail_02");
  }
}

_id_4AA0() {
  wait 0.6;

  if(common_scripts\utility::flag("entering_water")) {
    maps\_shg_fx::_id_4449("thick_dark_smoke_giant");
    maps\_shg_fx::_id_4449("battlefield_smokebank_large");
    level notify("msg_nyharbor_stoplandexplosions");
    level notify("msg_nyharbor_stopwaterexplosions");
    wait 1.0;
    level waittill("msg_breach_fx_ended");
    level thread _id_4A38();
    level thread _id_4A39();
    common_scripts\utility::exploder(556);
    maps\_shg_fx::_id_444A("battlefield_smokebank_large");
    maps\_shg_fx::_id_444A("thick_dark_smoke_giant", "oneshotfx");
  } else {
    level thread _id_4A39();
    level thread _id_4A38();
    common_scripts\utility::exploder(556);
  }
}

_id_4AA1(var_0) {
  playFXOnTag(common_scripts\utility::getfx("deathfx_bloodpool_underwater"), var_0, "J_NECK");
}

_id_4AA2(var_0) {
  playFXOnTag(common_scripts\utility::getfx("bloodspurt_underwater"), var_0, "TAG_KNIFE_FX");
}

_id_4AA3(var_0) {
  playFXOnTag(common_scripts\utility::getfx("splash_underwater_stealthkill"), var_0, "J_SpineUpper");
}

_id_4AA4(var_0) {
  var_1 = [];
  var_1[var_1.size] = "J_Wrist_LE";
  var_1[var_1.size] = "J_Thumb_LE_1";
  var_1[var_1.size] = "J_Thumb_LE_2";
  var_2 = 10;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    thread _id_4AA6(var_1, var_0);
    wait(randomfloatrange(0.05, 0.3));
  }
}

_id_4AA5(var_0) {
  var_1 = [];
  var_1[var_1.size] = "J_Wrist_RI";
  var_1[var_1.size] = "J_Thumb_RI_1";
  var_1[var_1.size] = "J_Webbing_RI";
  var_1[var_1.size] = "J_Elbow_RI";
  var_2 = 10;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    thread _id_4AA6(var_1, var_0);
    wait(randomfloatrange(0.05, 0.3));
  }
}

_id_4AA6(var_0, var_1) {
  foreach(var_3 in var_0) {}
  playFXOnTag(common_scripts\utility::getfx("drips_player_hand"), var_1, var_3);
}

_id_4780() {
  level._id_2A9C = 2000;
  var_0 = "treadfx/heli_water_harbor";
  var_1 = "treadfx/heli_water_harbor";
  var_2[0] = "script_vehicle_ny_blackhawk";
  var_2[1] = "script_vehicle_ch46e_ny_harbor";
  var_2[2] = "script_vehicle_mi24p_hind_woodland";

  foreach(var_4 in var_2) {
    maps\_treadfx::_id_28EF(var_4, "brick", var_0);
    maps\_treadfx::_id_28EF(var_4, "bark", var_0);
    maps\_treadfx::_id_28EF(var_4, "carpet", var_0);
    maps\_treadfx::_id_28EF(var_4, "cloth", var_0);
    maps\_treadfx::_id_28EF(var_4, "concrete", var_0);
    maps\_treadfx::_id_28EF(var_4, "dirt", var_0);
    maps\_treadfx::_id_28EF(var_4, "flesh", var_0);
    maps\_treadfx::_id_28EF(var_4, "foliage", var_0);
    maps\_treadfx::_id_28EF(var_4, "glass", var_0);
    maps\_treadfx::_id_28EF(var_4, "grass", var_0);
    maps\_treadfx::_id_28EF(var_4, "gravel", var_0);
    maps\_treadfx::_id_28EF(var_4, "ice", var_0);
    maps\_treadfx::_id_28EF(var_4, "metal", var_0);
    maps\_treadfx::_id_28EF(var_4, "mud", var_0);
    maps\_treadfx::_id_28EF(var_4, "paper", var_0);
    maps\_treadfx::_id_28EF(var_4, "plaster", var_0);
    maps\_treadfx::_id_28EF(var_4, "rock", var_0);
    maps\_treadfx::_id_28EF(var_4, "sand", var_0);
    maps\_treadfx::_id_28EF(var_4, "snow", var_0);
    maps\_treadfx::_id_28EF(var_4, "water", var_1);
    maps\_treadfx::_id_28EF(var_4, "wood", var_0);
    maps\_treadfx::_id_28EF(var_4, "asphalt", var_0);
    maps\_treadfx::_id_28EF(var_4, "ceramic", var_0);
    maps\_treadfx::_id_28EF(var_4, "plastic", var_0);
    maps\_treadfx::_id_28EF(var_4, "rubber", var_0);
    maps\_treadfx::_id_28EF(var_4, "cushion", var_0);
    maps\_treadfx::_id_28EF(var_4, "fruit", var_0);
    maps\_treadfx::_id_28EF(var_4, "painted metal", var_0);
    maps\_treadfx::_id_28EF(var_4, "default", var_0);
    maps\_treadfx::_id_28EF(var_4, "none", var_0);
  }
}

_id_4AA7() {
  wait 5.7;
  common_scripts\utility::exploder(254);
}

_id_4AA8() {
  common_scripts\utility::exploder(256);
}

_id_4AA9() {
  thread maps\_utility::vision_set_fog_changes("ny_harbor_sub_4_breach", 0);
}

_id_4AAA() {
  setblur(6, 0);
  wait 1.0;
  setblur(0, 0.4);
}

_id_4AAB() {
  wait 5.95;
  common_scripts\utility::exploder(261);
}

_id_4AAC(var_0) {
  common_scripts\utility::exploder(257);
  thread maps\_utility::vision_set_fog_changes("ny_harbor_sub_5", 0);
  wait 1.0;
  common_scripts\utility::exploder(264);
  wait 0.05;
  var_1 = getent("control_room_seat", "script_noteworthy");

  if(isDefined(var_1)) {
    var_1 hide();
  }
}

_id_4AAD() {
  common_scripts\utility::flag_wait("trigger_vfx_pipe_burst");
  maps\_audio::aud_send_msg("aud_flooded_room_pipe_burst");
  wait 0.2;
  earthquake(0.3, 1.7, level.player.origin, 1024);
}

_id_4AAE() {
  common_scripts\utility::flag_wait("trigger_vfx_pipe_burst_mr");
  maps\_audio::aud_send_msg("aud_missile_room_pipe_burst");
  wait 0.3;
  earthquake(0.4, 1.7, level.player.origin, 1024);
}

_id_4AAF() {
  common_scripts\utility::flag_wait("trigger_vfx_pipe_burst_cr");
  maps\_audio::aud_send_msg("aud_control_room_pipe_burst");
  wait 0.0;
  earthquake(0.4, 1.7, level.player.origin, 1024);
}

_id_4AB0(var_0) {
  level._id_4AB1 showpart("tag_lighton");
  playFXOnTag(common_scripts\utility::getfx("light_green_pinlight"), level._id_4AB1, "tag_lighton");
  wait 1;
  thread _id_4AB2();
  common_scripts\utility::exploder(265);
}

_id_4AB2(var_0) {
  playFXOnTag(common_scripts\utility::getfx("light_red_pinlight_sort"), level._id_4AB3, "tag_lighton");
}

_id_4AB4(var_0) {
  common_scripts\utility::exploder(263);
  level._id_4AB3 hidepart("tag_lighton");
  stopFXOnTag(common_scripts\utility::getfx("light_red_pinlight_sort"), level._id_4AB3, "tag_lighton");
  thread _id_4AB5();
}

_id_4AB5() {
  var_0 = getent("hatch_light", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  wait 3.8;
  var_1 = 0.16;
  var_2 = 0.001;

  while(var_2 < 1.75) {
    var_2 = var_2 + var_1;
    var_0 setlightintensity(var_2);
    wait 0.05;
  }

  var_0 setlightintensity(1.75);
}

_id_4AB6() {
  animscripts\utility::_id_24BB("water", loadfx("maps/ny_harbor/footstep_water"));
  animscripts\utility::_id_24BD("knee fx left", "J_Knee_LE", "water", loadfx("maps/ny_harbor/footstep_water"));
  animscripts\utility::_id_24BD("knee fx right", "J_Knee_RI", "water", loadfx("maps/ny_harbor/footstep_water"));
  animscripts\utility::_id_24BC("water", loadfx("maps/ny_harbor/footstep_water"));
}

_id_4AB7() {
  foreach(var_1 in level.createfxent) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1.v["type"] != "exploder") {
      continue;
    }
    if(!isDefined(var_1.v["exploder"])) {
      continue;
    }
    if(isDefined(var_1.v["flag"])) {
      if(var_1.v["flag"] == "fire_reflect") {
        var_2 = var_1.v["origin"];
        var_3 = var_1.v["fxid"];
        var_1 thread _id_4AB8(var_3, var_2);
      }
    }
  }
}

_id_4AB8(var_0, var_1) {
  var_2 = distance(var_1, level.player.origin);

  while(var_2 >= 6500) {
    var_2 = distance(var_1, level.player.origin);
    wait 0.25;
  }

  thread _id_4AB9(var_0, var_1);
}

_id_4AB9(var_0, var_1) {
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_1;
  var_3 = common_scripts\utility::getfx(var_0 + "_reflect");

  if(isDefined(var_3)) {
    playFXOnTag(var_3, var_2, "tag_origin");

  }
  var_4 = 1;

  while(var_4 < 6500) {
    var_4 = distance(var_2.origin, level.player.origin);
    var_5 = var_2.origin - level.player getEye();
    var_6 = vectortoangles(var_5);
    var_2.angles = (-90, var_6[1], 0);
    wait 0.05;
  }

  stopFXOnTag(var_3, var_2, "tag_origin");
  var_2 delete();
  thread _id_4AB8(var_0, var_1);
}

_id_4ABA(var_0) {
  var_1 = distance(var_0, level.player.origin);

  if(var_1 < 7000) {
    var_2 = 1 - var_1 / 7000;
    earthquake(0.4, 2, var_0, 5500);
    setblur(2.0 * var_2, 0.1);
    wait 0.5;
    setblur(0, 0.4);
  }
}

_id_4ABB() {
  common_scripts\utility::waitframe();
  var_0 = spawnStruct();
  _id_4AC3(999, var_0);
  var_1 = var_0.v["ents"];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    thread _id_4ABC(var_1[var_2], "msg_vfx_surface_zone_25000");
  }
}

_id_4ABC(var_0, var_1) {
  common_scripts\utility::flag_wait(var_1);
  wait(randomfloat(4));
  var_2 = anglestoright(var_0.v["angles"]) * -50000 + var_0.v["origin"];
  var_3[0] = var_0.v["origin"];
  var_3[1] = var_2;
  var_3[2] = 25;
  maps\_audio::aud_send_msg("fx_skybox_hind", var_3);
  var_0 common_scripts\utility::activate_individual_exploder();

  for(;;) {
    common_scripts\utility::flag_wait(var_1);
    common_scripts\utility::flag_waitopen("msg_vfx_sub_interior_minus_25000");
    wait(randomfloat(6) + 10);
    var_0 common_scripts\utility::activate_individual_exploder();
    maps\_audio::aud_send_msg("fx_skybox_hind", var_3);
  }
}

_id_4ABD() {
  common_scripts\utility::waitframe();
  var_0 = spawnStruct();
  _id_4AC3(998, var_0);
  var_1 = var_0.v["ents"];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    thread _id_4ABE(var_1[var_2], "msg_vfx_surface_zone_25000");
  }
}

_id_4ABE(var_0, var_1) {
  common_scripts\utility::flag_wait(var_1);
  wait(randomfloat(4));
  var_2 = anglestoright(var_0.v["angles"]) * -140000 + var_0.v["origin"] + (0, 0, 7000);
  var_3[0] = var_0.v["origin"];
  var_3[1] = var_2;
  var_3[2] = 10;
  maps\_audio::aud_send_msg("fx_skybox_mig", var_3);
  var_0 common_scripts\utility::activate_individual_exploder();

  for(;;) {
    common_scripts\utility::flag_wait(var_1);
    common_scripts\utility::flag_waitopen("msg_vfx_sub_interior_minus_25000");
    wait(randomfloat(12) + 4);
    wait 2;
    var_0 common_scripts\utility::activate_individual_exploder();
    maps\_audio::aud_send_msg("fx_skybox_mig", var_3);
  }
}

_id_4ABF(var_0) {
  wait 0.15;
  self show();
  var_1 = getent(self.script_noteworthy + "_col", "script_noteworthy");

  if(isDefined(var_1)) {
    var_1 linkto(self, "tag_collision", (0, 0, 0), (0, -90, 0));

  }
  maps\_audio::aud_send_msg("explode_wave", var_1);
  self._id_1032 = "explosion_wave";
  maps\_anim::_id_1244();

  if(isDefined(var_0)) {
    thread _id_4AC1();
  } else {
    thread _id_4AC0();

  }
  maps\_anim::_id_1246(self, "wave");
  self hide();
}

_id_4AC0() {
  playFXOnTag(common_scripts\utility::getfx("wave_crest_spray"), self, "tag_sprayfx");
  wait 1.5;
  stopFXOnTag(common_scripts\utility::getfx("wave_crest_spray"), self, "tag_sprayfx");
}

_id_4AC1() {
  playFXOnTag(common_scripts\utility::getfx("wave_crest_spray_explosion"), self, "tag_sprayfx");
  wait 1.5;
  stopFXOnTag(common_scripts\utility::getfx("wave_crest_spray_explosion"), self, "tag_sprayfx");
}

_id_4AC2() {
  wait 1.0;
  var_0 = getent("destroyer_wave", "script_noteworthy");
  var_0 hide();
  var_1 = getent("ship_splode_1_wave", "script_noteworthy");
  var_1 hide();
  var_2 = getent("ship_splode_2_wave", "script_noteworthy");
  var_2 hide();
  var_3 = getent("ship_splode_3_wave", "script_noteworthy");
  var_3 hide();
  var_4 = getent("ship_splode_4_wave", "script_noteworthy");
  var_4 hide();
  var_5 = getent("ship_splode_6_wave", "script_noteworthy");
  var_5 hide();
}

_id_4AC3(var_0, var_1) {
  var_2 = [];
  var_3 = [];
  var_4 = [];
  var_5 = maps\_shg_fx::_id_4446(var_0);

  foreach(var_7 in var_5) {
    var_2[var_2.size] = var_7.v["origin"];
    var_3[var_3.size] = var_7.v["angles"];
    var_4[var_4.size] = var_7;
  }

  var_1.v["origins"] = var_2;
  var_1.v["angles"] = var_3;
  var_1.v["ents"] = var_4;
}

_id_4AC4() {
  var_0 = getEntArray("poison_wake_volume", "targetname");
  common_scripts\utility::array_thread(var_0, ::_id_4AC5);
}

_id_4AC5() {
  for(;;) {
    self waittill("trigger", var_0);

    if(var_0 maps\_utility::_id_133C("in_poison_volume")) {} else {
      var_0 maps\_utility::_id_1402("in_poison_volume");

    }
    if(isDefined(var_0) && distancesquared(var_0.origin, level.player.origin) < 9250000) {
      if(var_0 maps\_utility::_id_1008("in_poison_volume")) {
        continue;
      }
      var_0 thread _id_4AC6(self);
      var_0 maps\_utility::_id_13DC("in_poison_volume");
    }
  }
}

_id_4AC6(var_0) {
  self endon("death");
  thread _id_4AC7();
  var_1 = 200;

  for(;;) {
    if(self istouching(var_0)) {
      if(var_1 > 5) {
        wait(max(1 - var_1 / 120, 0.1));
      } else {
        wait 0.15;

      }
      var_2 = var_0.script_fxid;

      if(isplayer(self)) {
        var_1 = distance(self getvelocity(), (0, 0, 0));

        if(var_1 < 5) {
          var_2 = "footstep_water_slow";
        }
      }

      if(isai(self)) {
        var_1 = distance(self.velocity, (0, 0, 0));

        if(var_1 < 5) {
          var_2 = "footstep_water_slow";
        }
      }

      var_3 = self.origin + (0, 0, 64);
      var_4 = self.origin - (0, 0, 150);
      var_5 = bulletTrace(var_3, var_4, 0, undefined);
      var_6 = common_scripts\utility::getfx(var_2);
      var_3 = var_5["position"];
      var_7 = (0, self.angles[1], 0);
      var_8 = anglesToForward(var_7);
      var_9 = anglestoup(var_7);
      playFX(var_6, var_3, var_9, var_8);
      continue;
    }

    maps\_utility::_id_13DE("in_poison_volume");
    return;
  }
}

_id_4AC7(var_0) {
  self waittill("death");

  if(maps\_utility::_id_133C("in_poison_volume") && maps\_utility::_id_1008("in_poison_volume") && isDefined(self.origin)) {
    playFX(common_scripts\utility::getfx("death_water"), self.origin, (270, 0, 0));
  }
}

_id_4AC8() {
  common_scripts\utility::waitframe();
  level endon("msg_fx_stop_slava_missiles");
  var_0 = getEntArray("missile_launcher", "targetname");
  var_1 = -1;
  var_2 = 0;

  for(;;) {
    common_scripts\utility::flag_wait("msg_vfx_surface_zone_25000");
    common_scripts\utility::flag_waitopen("msg_vfx_sub_interior_minus_25000");
    var_3 = level.player getplayerangles();
    var_4 = vectornormalize(anglesToForward(var_3));
    var_5 = -1;
    var_6 = [];

    for(var_7 = 0; var_7 < var_0.size; var_7++) {
      var_8 = vectornormalize(var_0[var_7].origin - level.player.origin);
      var_9 = vectordot(var_4, var_8);

      if(vectordot(var_4, var_8) > 0.75) {
        if(var_7 != var_1) {
          var_6[var_6.size] = var_7;
          var_5 = 1;
        }
      }
    }

    if(var_5 > 0 && var_6.size > 0) {
      var_10 = randomint(var_6.size);
      var_11 = var_6[var_10];
      thread _id_4AC9(var_0[var_11]);
      var_1 = var_11;
    } else {
      while(var_2 == var_1) {
        var_2 = randomint(var_0.size);
        var_11 = var_0[var_2];
      }

      var_1 = var_2;
      thread _id_4AC9(var_0[var_2]);
    }

    var_12 = randomfloat(2) + 1;
    wait(var_12);
  }
}

_id_4AC9(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("vehicle_s300_pmu2");
  var_1.angles = var_0.angles;
  var_2[0] = var_1;
  maps\_audio::aud_send_msg("slava_missile_launch", var_2);
  playFXOnTag(common_scripts\utility::getfx("slava_missile_bg"), var_1, "tag_fx");
  var_3 = 12000;
  var_4 = 130;
  var_5 = vectornormalize(anglesToForward(var_1.angles));
  var_6 = var_5;
  var_7 = var_6 * var_3 * 0.05;
  var_8 = (0, 0, -4);
  var_9 = 0;

  while(var_9 == 0) {
    var_1.origin = var_1.origin + var_7;
    var_7 = var_7 + var_8;
    var_10 = vectornormalize(var_7);
    var_11 = vectortoangles(var_10);
    var_1.angles = var_11;
    level common_scripts\utility::waitframe();

    if(var_1.origin[2] <= 0) {
      var_9 = 1;
    }
  }

  stopFXOnTag(common_scripts\utility::getfx("slava_missile_bg"), var_1, "tag_fx");
  playFX(common_scripts\utility::getfx("horizon_flash_runner"), var_1.origin);
  var_2[0] = var_1.origin;
  maps\_audio::aud_send_msg("slava_missile_explode", var_2);
  var_1 delete();
}

_id_4ACA() {
  common_scripts\utility::waitframe();

  if(common_scripts\utility::flag_exist("switch_chinook") == 0) {
    common_scripts\utility::flag_init("switch_chinook");

  }
  common_scripts\utility::flag_wait("switch_chinook");
  var_0 = 0;

  while(var_0 == 0) {
    var_1 = level._id_4ACB gettagorigin("tail_rotor_jnt");
    var_2 = (var_1[0], var_1[1], -290);
    var_3 = level._id_4ACB.angles;
    var_4 = (270, var_3[1], 0);
    var_5 = anglesToForward(var_4);
    playFX(common_scripts\utility::getfx("heli_water_harbor_cinematic"), var_2, var_5);
    wait 0.1;
  }
}

_id_4ACC() {
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_wait("fx_chinook_screen_watersplash");
  thread _id_4A46(3.0);
}

_id_4ACD() {
  level.player waittill("stop_breathing");
  common_scripts\utility::exploder(26111);
  wait 3;
  maps\_shg_fx::_id_4448(26111);
}

_id_4ACE() {
  common_scripts\utility::waitframe();

  if(common_scripts\utility::flag_exist("switch_chinook") == 0) {
    common_scripts\utility::flag_init("switch_chinook");

  }
  common_scripts\utility::flag_wait("switch_chinook");
  setsaveddvar("sm_spotlimit", 1);
  playFXOnTag(common_scripts\utility::getfx("lights_godray_beam"), level._id_4ACB, "tag_window_light1");
  playFXOnTag(common_scripts\utility::getfx("lighthaze_sub_ladder_bottom"), level._id_4ACB, "tag_window_light2");
  playFXOnTag(common_scripts\utility::getfx("chinook_red_light"), level._id_4ACB, "tag_light_cargo02");
  playFXOnTag(common_scripts\utility::getfx("light_c4_blink"), level._id_4ACB, "tag_nearwall");
  playFXOnTag(common_scripts\utility::getfx("light_c4_blink"), level._id_4ACB, "tag_nearwall2");
}

_id_4ACF() {
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_wait("russian_sub_spawned");
  wait 7.5;
  var_0 = maps\_shg_fx::_id_4447("sub_volumetric_lightbeam2_static");
  var_1 = var_0[0].v["origin"];
  var_2 = var_0[0].v["angles"];
  var_3 = spawnfx(common_scripts\utility::getfx("sub_volumetric_lightbeam2"), var_1, anglesToForward(var_2), anglestoup(var_2));
  triggerfx(var_3);
  wait 0.01;
  var_0[0] common_scripts\utility::pauseeffect();
  playFXOnTag(common_scripts\utility::getfx("sub_volumetric_shadow_fin_front"), level._id_49C3, "tag_fx_fin_f_right");
  wait 21.5;
  playFXOnTag(common_scripts\utility::getfx("sub_volumetric_shadow_fin_rear"), level._id_49C3, "tag_fx_fin_b_right");
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4 linkto(level._id_49C3, "tag_fx_fin_b_left", (0, -365, 0), (0, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("sub_volumetric_shadow_fin_rear"), var_4, "tag_origin");
  common_scripts\utility::flag_waitopen("msg_vfx_udrwtr_b");
  var_3 delete();
  var_4 delete();
}

_id_4AD0() {
  level notify("msg_nyharbor_stoplandexplosions");
  level notify("msg_nyharbor_stopwaterexplosions");
  level notify("msg_fx_stop_slava_missiles");
  maps\_shg_fx::_id_4467(242);
  maps\_shg_fx::_id_4467(252);
}

_id_4AD1() {
  level thread _id_4A39();
  level thread _id_4A38();
  level thread _id_4AC8();
  common_scripts\utility::exploder(242);
  common_scripts\utility::exploder(252);
}

_id_4AD2() {
  wait 3.0;
  common_scripts\utility::flag_wait("msg_fx_under_docks");
  _id_4AD0();
  common_scripts\utility::flag_waitopen("msg_fx_under_docks");
  _id_4AD1();
}

_id_4AD3() {
  var_0 = 0.25;

  for(var_1 = 0; var_1 < var_0; var_1 = var_1 + 0.05) {
    level.player playrumbleonentity("falling_land");
    wait 0.05;
  }

  stopallrumbles();
}

_id_4AD4(var_0) {
  self._id_4AD5 = var_0;
}

_id_4AD6(var_0) {
  self._id_4AD7 = var_0;
}