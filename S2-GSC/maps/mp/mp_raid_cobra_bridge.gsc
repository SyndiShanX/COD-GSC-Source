/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_cobra_bridge.gsc
*********************************************/

func_00D5() {
  var_00["mp_raid_bridge_01_a"] = ::func_67D1;
  lib_04FF::func_86DA("bridge_1", "modelNotetrackFuncs", var_00);
  var_01["mp_raid_bridge_01_b"] = ::func_67D2;
  lib_04FF::func_86DA("bridge_2", "modelNotetrackFuncs", var_01);
}

func_2CD4(param_00, param_01, param_02) {
  wait(param_00);
  lib_04F3::func_79CB(param_02, param_01);
}

func_67D1(param_00, param_01) {
  var_02 = param_01[param_00];
  var_03 = self;
  var_04 = undefined;
  var_05 = (0, 0, 0);
  var_06 = undefined;
  var_07 = undefined;
  var_08 = 0;
  var_09 = 1;
  var_0A = 1;
  switch (var_02) {
    case "piece_a":
      var_03 showpart("j_wood_planks_a_01");
      var_03 showpart("j_beam_bottom_cross_a_01");
      var_03 showpart("j_beam_bottom_cross_a_02");
      break;

    case "piece_b":
      var_03 showpart("j_wood_planks_a_02");
      break;

    case "piece_c":
      var_03 showpart("j_wood_planks_a_03");
      break;

    case "piece_d":
      var_03 showpart("j_wood_planks_a_04");
      break;

    case "piece_e":
      var_03 showpart("j_wood_planks_a_05");
      break;

    case "piece_f":
      var_03 showpart("j_wood_planks_a_06");
      break;

    case "piece_g":
      var_03 showpart("j_frame_main_end_r_a");
      var_03 showpart("j_frame_main_end_l_a");
      break;

    case "piece_h":
      var_03 showpart("j_frame_segment_r_middle_a");
      var_03 showpart("j_frame_segment_l_middle_a");
      var_03 showpart("j_beam_bottom_cross_a_03");
      var_03 showpart("j_beam_bottom_cross_a_04");
      break;

    case "piece_i":
      var_03 showpart("j_frame_segment_r_half_a");
      var_03 showpart("j_frame_segment_l_half_a");
      var_03 showpart("j_beam_bottom_cross_a_05");
      var_03 showpart("j_beam_bottom_cross_a_06");
      var_03 showpart("j_corrugated_wall_le");
      var_03 showpart("j_corrugated_wall_ri");
      break;

    case "piece_j":
      var_03 showpart("j_wood_beam_a_04");
      var_03 showpart("j_wood_beam_a_03");
      var_03 showpart("j_wood_beam_a_02");
      var_03 showpart("j_wood_beam_a_01");
      break;

    case "piece_k":
      var_03 showpart("j_wood_beam_a_08");
      var_03 showpart("j_wood_beam_a_07");
      var_03 showpart("j_wood_beam_a_06");
      var_03 showpart("j_wood_beam_a_05");
      break;

    case "piece_l":
      var_03 showpart("j_wood_beam_a_012");
      var_03 showpart("j_wood_beam_a_011");
      var_03 showpart("j_wood_beam_a_010");
      var_03 showpart("j_wood_beam_a_09");
      var_03 showpart("j_barrel_le_01");
      var_03 showpart("j_barrel_le_02");
      var_03 showpart("j_barrel_ri_01");
      var_03 showpart("j_barrel_ri_02");
      break;

    case "sound_a":
      var_06 = "buildable_bridge_partial_a";
      var_04 = "j_beam_bottom_cross_a_01";
      var_05 = (0, 0, 12);
      break;

    case "sound_b":
      var_06 = "buildable_bridge_partial_a";
      var_04 = "j_beam_bottom_cross_a_02";
      var_05 = (0, 0, 12);
      break;

    case "sound_c":
      var_06 = "buildable_bridge_partial_a";
      var_04 = "j_beam_bottom_cross_a_03";
      var_05 = (0, 0, 12);
      break;

    case "sound_d":
      var_06 = "buildable_bridge_partial_a";
      var_04 = "j_beam_bottom_cross_a_04";
      var_05 = (0, 0, 12);
      break;

    case "sound_e":
      var_06 = "buildable_bridge_partial_a";
      var_04 = "j_beam_bottom_cross_a_05";
      var_05 = (0, 0, 12);
      break;

    case "sound_f":
      var_06 = "buildable_bridge_partial_a";
      var_07 = "buildable_bridge_partial_a_complete";
      var_08 = 0.45;
      var_04 = "j_beam_bottom_cross_a_06";
      var_05 = (0, 0, 12);
      break;

    case "sound_g":
      var_06 = "buildable_bridge_partial_b";
      var_04 = "j_beam_bottom_cross_a_02";
      var_05 = (0, 0, 12);
      break;

    case "sound_h":
      var_06 = "buildable_bridge_partial_b";
      var_04 = "j_beam_bottom_cross_a_04";
      var_05 = (0, 0, 12);
      break;

    case "sound_i":
      var_06 = "buildable_bridge_partial_b";
      var_07 = "buildable_bridge_partial_b_complete";
      var_08 = 0.9;
      var_04 = "j_beam_bottom_cross_a_06";
      var_05 = (0, 0, 12);
      break;

    case "sound_j":
      var_06 = "buildable_bridge_partial_c";
      var_04 = "j_beam_bottom_cross_a_01";
      var_05 = (0, 0, 12);
      break;

    case "sound_k":
      var_06 = "buildable_bridge_partial_c";
      var_04 = "j_beam_bottom_cross_a_03";
      var_05 = (0, 0, 12);
      break;

    case "sound_l":
      var_06 = "buildable_bridge_partial_c";
      var_07 = "buildable_bridge_partial_c_complete";
      var_08 = 1.65;
      var_04 = "j_beam_bottom_cross_a_05";
      var_05 = (0, 0, 12);
      break;

    default:
      var_0B = 0;
      var_09 = 0;
      break;
  }

  if(var_0A) {
    var_0C = var_03.var_8BF7[var_02];
    if(isDefined(var_0C)) {
      foreach(var_0E in var_0C) {
        var_0E lib_0502::func_79C6();
      }
    }
  }

  if(isDefined(var_06)) {
    var_10 = var_03.var_116;
    if(isDefined(var_04)) {
      var_10 = var_03 gettagorigin(var_04);
    }

    var_10 = var_10 + var_05;
    lib_04F3::func_79CB(var_06, var_10);
    var_06 = undefined;
    if(isDefined(var_07)) {
      var_04 = "j_beam_bottom_cross_a_06";
      var_10 = var_03 gettagorigin(var_04);
      var_10 = var_10 + (-64, 0, 24);
      thread func_2CD4(var_08, var_10, var_07);
      var_08 = 0;
      var_07 = undefined;
    }
  }

  return var_09;
}

func_67D2(param_00, param_01) {
  var_02 = param_01[param_00];
  var_03 = self;
  var_04 = undefined;
  var_05 = (0, 0, 0);
  var_06 = undefined;
  var_07 = undefined;
  var_08 = 0;
  var_09 = 1;
  var_0A = 1;
  switch (var_02) {
    case "piece_a":
      var_03 showpart("j_wood_planks_b_06");
      break;

    case "piece_b":
      var_03 showpart("j_wood_planks_b_05");
      break;

    case "piece_c":
      var_03 showpart("j_wood_planks_b_04");
      break;

    case "piece_d":
      var_03 showpart("j_wood_planks_b_03");
      break;

    case "piece_e":
      var_03 showpart("j_wood_planks_b_02");
      break;

    case "piece_f":
      var_03 showpart("j_wood_planks_b_01");
      break;

    case "piece_g":
      var_03 showpart("j_frame_segment_l_half_b");
      var_03 showpart("j_frame_segment_r_half_b");
      var_03 showpart("j_beam_bottom_cross_b_05");
      var_03 showpart("j_beam_bottom_cross_b_06");
      var_03 showpart("j_beam_bottom_cross_b_07");
      break;

    case "piece_h":
      var_03 showpart("j_frame_segment_l_middle_b");
      var_03 showpart("j_frame_segment_r_middle_b");
      var_03 showpart("j_beam_bottom_cross_b_03");
      var_03 showpart("j_beam_bottom_cross_b_04");
      break;

    case "piece_i":
      var_03 showpart("j_frame_main_end_l_b");
      var_03 showpart("j_frame_main_end_r_b");
      var_03 showpart("j_beam_bottom_cross_b_01");
      var_03 showpart("j_beam_bottom_cross_b_02");
      break;

    case "piece_j":
      var_03 showpart("j_wood_beam_b_09");
      var_03 showpart("j_wood_beam_b_010");
      var_03 showpart("j_wood_beam_b_011");
      var_03 showpart("j_wood_beam_b_012");
      break;

    case "piece_k":
      var_03 showpart("j_wood_beam_b_05");
      var_03 showpart("j_wood_beam_b_06");
      var_03 showpart("j_wood_beam_b_07");
      var_03 showpart("j_wood_beam_b_08");
      break;

    case "piece_l":
      var_03 showpart("j_wood_beam_b_01");
      var_03 showpart("j_wood_beam_b_02");
      var_03 showpart("j_wood_beam_b_03");
      var_03 showpart("j_wood_beam_b_04");
      break;

    case "sound_a":
      var_06 = "buildable_bridge_partial_a";
      var_04 = "j_beam_bottom_cross_b_06";
      var_05 = (0, 0, 12);
      break;

    case "sound_b":
      var_06 = "buildable_bridge_partial_a";
      var_04 = "j_beam_bottom_cross_b_05";
      var_05 = (0, 0, 12);
      break;

    case "sound_c":
      var_06 = "buildable_bridge_partial_a";
      var_04 = "j_beam_bottom_cross_b_04";
      var_05 = (0, 0, 12);
      break;

    case "sound_d":
      var_06 = "buildable_bridge_partial_a";
      var_04 = "j_beam_bottom_cross_b_03";
      var_05 = (0, 0, 12);
      break;

    case "sound_e":
      var_06 = "buildable_bridge_partial_a";
      var_04 = "j_beam_bottom_cross_b_02";
      var_05 = (0, 0, 12);
      break;

    case "sound_f":
      var_06 = "buildable_bridge_partial_a";
      var_07 = "buildable_bridge_partial_a_complete";
      var_08 = 0.45;
      var_04 = "j_beam_bottom_cross_b_01";
      var_05 = (0, 0, 12);
      break;

    case "sound_g":
      var_06 = "buildable_bridge_partial_b";
      var_04 = "j_beam_bottom_cross_b_06";
      var_05 = (0, 0, 12);
      break;

    case "sound_h":
      var_06 = "buildable_bridge_partial_b";
      var_04 = "j_beam_bottom_cross_b_04";
      var_05 = (0, 0, 12);
      break;

    case "sound_i":
      var_06 = "buildable_bridge_partial_b";
      var_07 = "buildable_bridge_partial_b_complete";
      var_08 = 0.9;
      var_04 = "j_beam_bottom_cross_b_02";
      var_05 = (0, 0, 12);
      break;

    case "sound_j":
      var_06 = "buildable_bridge_partial_c";
      var_04 = "j_beam_bottom_cross_b_05";
      var_05 = (0, 0, 12);
      break;

    case "sound_k":
      var_06 = "buildable_bridge_partial_c";
      var_04 = "j_beam_bottom_cross_b_03";
      var_05 = (0, 0, 12);
      break;

    case "sound_l":
      var_06 = "buildable_bridge_partial_c";
      var_07 = "buildable_bridge_partial_c_complete";
      var_08 = 1.65;
      var_04 = "j_beam_bottom_cross_b_01";
      var_05 = (0, 0, 12);
      break;

    default:
      var_09 = 0;
      break;
  }

  if(var_0A) {
    var_0B = var_03.var_8BF7[var_02];
    if(isDefined(var_0B)) {
      foreach(var_0D in var_0B) {
        var_0D lib_0502::func_79C6();
      }
    }
  }

  if(isDefined(var_06)) {
    var_0F = var_03.var_116;
    if(isDefined(var_04)) {
      var_0F = var_03 gettagorigin(var_04);
    }

    var_0F = var_0F + var_05;
    lib_04F3::func_79CB(var_06, var_0F);
    var_06 = undefined;
    if(isDefined(var_07)) {
      var_04 = "j_beam_bottom_cross_b_01";
      var_0F = var_03 gettagorigin(var_04);
      var_0F = var_0F + (64, 0, 24);
      thread func_2CD4(var_08, var_0F, var_07);
      var_08 = 0;
      var_07 = undefined;
    }
  }

  return var_09;
}