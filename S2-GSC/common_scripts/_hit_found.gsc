/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: common_scripts\_hit_found.gsc
*********************************************/

func_4161(param_00, param_01, param_02) {
  var_03 = [];
  for(var_04 = 0; var_04 <= param_02; var_04 = var_04 + 3) {
    var_05 = param_01 * var_04;
    var_03[var_03.size] = param_00 + var_05;
  }

  var_03[var_03.size] = param_00 + param_01 * param_02;
  return var_03;
}

func_9F90(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  var_05 = [];
  var_06 = [];
  var_07 = undefined;
  var_08 = undefined;
  var_09 = undefined;
  var_0A = "none";
  var_0B = 99999999;
  var_0C = undefined;
  var_0D = undefined;
  var_0E = undefined;
  var_0F = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;
  var_14 = 0;
  var_15 = undefined;
  var_10 = anglesToForward(self.var_001D);
  var_10 = vectornormalize((var_10[0], var_10[1], 0));
  var_16 = self.var_0116 + var_10 * 15;
  if(param_02) {
    var_17 = 10;
    var_18 = 13;
  } else {
    var_17 = 60;
    var_18 = 45;
  }

  var_07 = var_16 + (0, 0, var_17);
  var_05 = func_4161(var_07, var_10, 15);
  var_19 = var_05.size;
  var_1A = 0;
  while(var_1A < var_19) {
    var_1B = var_05[var_1A];
    var_1C = var_1B - (0, 0, var_18);
    if(isDefined(var_0F) && isDefined(param_04)) {
      var_1D = distance2d(var_1B, var_08);
      if(var_1D > param_04) {
        var_06[var_1A] = undefined;
        continue;
      }
    }

    if(!param_02) {
      var_06[var_1A] = func_9F91(var_1B, var_1C, param_00, param_01, 5, var_14);
      if(var_06[var_1A]["is_matching_hit_found"] == 0) {
        if(1 && var_14) {
          var_06[var_1A]["is_matching_hit_found"] = 1;
          var_06[var_1A]["position"] = var_05[var_1A];
        } else {
          var_06[var_1A] = undefined;
          continue;
        }
      }

      if(!isDefined(var_15) && isDefined(var_06[var_1A]["entity"])) {
        var_15 = var_06[var_1A]["entity"];
        var_1E = common_scripts\_plant_weapon::func_439E(var_15);
        if(isDefined(var_1E)) {
          if(var_1E < 15) {} else {
            var_1F = func_4161(var_05[var_19 - 1], var_10, var_1E - 15);
            var_05 = common_scripts\utility::func_0F73(var_05, var_1F);
            var_19 = var_05.size;
          }
        }
      }

      if(1 && !var_15 && var_07[var_1B]["surface_flags"] & 134217728 || var_07[var_1B]["surface_flags"] & 67108864) {
        var_15 = 1;
      }

      var_21 = var_07[var_1B]["position"];
    } else {
      var_21 = var_1C;
    }

    var_1D = var_06[var_1B] - (0, 0, var_19);
    var_22 = func_1D85(var_21, var_1D, 0);
    var_23 = var_22[0];
    var_24 = var_22[1];
    var_1E = var_22[2];
    if(!isDefined(var_23)) {
      var_07[var_1B] = undefined;
      continue;
    }

    var_0F = param_04 - 15;
    var_07[var_1B]["brush_model_solid_spot"] = var_23;
    var_07[var_1B]["brush_model_solid_surfacetype"] = var_24;
    var_07[var_1B]["entity"] = var_1E;
    if(!isDefined(var_12) || var_23[2] > var_12) {
      var_12 = var_23[2];
    }

    if(!isDefined(var_10)) {
      var_10 = var_1B;
      var_09 = var_23;
      var_0E = var_09 + var_11 * var_0F;
    }

    if(0) {
      break;
    }

    var_1B++;
  }

  if(1) {
    var_25 = [];
    foreach(var_27 in var_06) {
      if(var_11 - var_27["brush_model_solid_spot"][2] <= common_scripts\_plant_weapon::func_41C4()) {
        var_25[var_25.size] = var_27;
      } else if(getdvarint("turret_plant_debug")) {}
    }

    var_06 = var_25;
  }

  foreach(var_29 in var_0A) {
    var_2A = distance2dsquared(var_29["brush_model_solid_spot"], var_10);
    if(var_2A < var_0E) {
      var_0E = var_2A;
      var_0C = var_29["brush_model_solid_spot"];
      var_0D = var_29["brush_model_solid_surfacetype"];
      var_0F = var_29["entity"];
    }
  }

  if(isDefined(var_0C)) {
    var_2C = 1;
    if(var_05) {
      var_2D = 7;
      var_2E[0] = (self.var_0116[0], self.var_0116[1], var_0C[2] + var_2D) - anglesToForward(self.var_001D) * 15;
      var_2E[1] = var_2E[0] - anglestoright(self.var_001D) * 15;
      var_2E[2] = var_2E[0] + anglestoright(self.var_001D) * 15;
      var_2F = (var_0C[0], var_0C[1], var_0C[2] + var_2D) + anglesToForward(self.var_001D) * 3;
      for(var_1D = 0; var_1D < var_2E.size; var_1D++) {
        var_30 = func_1D85(var_2E[var_1D], var_2F, 1, var_1D, var_2E.size);
        var_25 = var_30[0];
        var_26 = var_30[1];
        if(isDefined(var_25)) {
          var_2C = 0;
          break;
        }
      }
    }

    if(var_2C) {
      return [var_0C, var_0D, var_0F];
    }
  }

  return [undefined, undefined, undefined];
}

func_9F91(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = 0;
  var_07 = 0;
  if(param_02) {
    var_06 = var_06 | 536870912;
    var_07 = var_07 | 64;
  }

  if(param_03) {
    var_06 = var_06 | 16777216;
    var_07 = var_07 | 67108864;
    var_07 = var_07 | 134217728;
  }

  var_08 = function_0335(param_00, param_01, var_06, var_07, self, param_04);
  return var_08;
}

func_1D85(param_00, param_01, param_02, param_03, param_04) {
  var_05 = undefined;
  var_06 = undefined;
  var_07 = ~0;
  var_08 = 0;
  if(param_02) {
    var_09 = 377552881;
  } else {
    var_09 = 377749489;
  }

  var_06 = function_0335(param_00, param_01, var_09, var_07, self, undefined, var_08);
  if(var_06["is_matching_hit_found"]) {
    return [var_06["position"], var_06["surfacetype"], var_06["entity"]];
  }

  return [undefined, undefined];
}

func_6FAC(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = getdvarint("turret_plant_debug") == 2;
  if(param_00["is_hit"]) {
    if(!var_06) {
      return;
    }
  }

  var_07 = param_01;
  var_08 = param_02;
  if(!isDefined(param_05)) {
    var_09 = physicstrace(var_07, var_08, param_03);
  } else {
    var_0A = function_0335(var_08, var_09, var_06, undefined, param_04);
    if(var_0A["is_matching_hit_found"]) {
      var_09 = var_0A["position"];
    } else {
      var_09 = var_08;
    }
  }

  if(!isDefined(param_01["current_angle"])) {
    var_0B = vectornormalize(var_0A - var_08);
    param_05 = vectornormalize(param_05);
    var_0C = vectordot(var_0B, param_05);
    var_0C = clamp(var_0C, -1, 1);
    param_01["current_angle"] = acos(var_0C);
  }

  if(!common_scripts\utility::func_5646(var_0A, var_09)) {
    if(param_01["is_hit"] == 0) {
      param_01["hit_angle"] = param_01["current_angle"];
      param_01["hit_point"] = var_0A;
      param_01["is_hit"] = 1;
    }
  }

  return param_01;
}

func_42BA(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = [];
  var_07 = [];
  if(!isDefined(param_04)) {
    param_04 = 20;
  }

  var_08 = undefined;
  if(param_03 > 0) {
    var_08 = int(param_03 / param_04) + 2;
  } else {
    param_04 = -1 * param_04;
    var_08 = int(param_03 / param_04) + 2;
  }

  var_09 = 0;
  for(var_0A = 0; var_0A < var_08; var_0A++) {
    if(var_0A == var_08 - 1) {
      var_09 = param_03;
    } else {
      var_09 = var_0A * param_04;
    }

    var_0B = undefined;
    if(0) {
      var_0B = combineangles(param_01, (0, var_09, 0));
    } else {
      var_0B = (param_01[0], angleclamp180(param_01[1] + var_09), param_01[2]);
    }

    var_0C = anglesToForward(var_0B) * param_02;
    var_06[var_0A] = var_0C + param_00;
    if(param_05) {
      var_0D = combineangles(var_0B, (0, param_05, 0));
      var_0E = anglesToForward(var_0D) * param_02;
      var_07[var_0A] = var_0E + param_00;
    }
  }

  return [var_06, var_07, var_0A];
}

func_6FAB(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = getdvarint("turret_plant_debug") == 2;
  var_0A = [];
  var_0B = func_42BA(param_01, param_02, param_03, param_04, param_05, param_06);
  var_0C = var_0B[0];
  var_0D = var_0B[1];
  var_0E = var_0B[2];
  var_0F = anglesToForward(param_02);
  var_0A["is_hit"] = 0;
  var_0A["arc_end"] = var_0C[var_0E];
  for(var_10 = 0; var_10 < var_0C.size; var_10++) {
    var_0A["current_angle"] = undefined;
    var_0A = func_6FAC(var_0A, param_01, var_0C[var_10], param_07, var_0F, param_08);
    if(var_0A["is_hit"]) {
      break;
    }

    if(param_06) {
      var_11 = var_0D[var_10];
    } else {
      var_11 = var_0C[var_10];
    }

    var_12 = (var_11[0], var_11[1], param_00 + common_scripts\_plant_weapon::func_41B5());
    var_0A = func_6FAC(var_0A, var_11, var_12, param_07, var_0F, param_08);
    if(var_0A["is_hit"]) {
      break;
    }

    var_13 = var_12;
    var_14 = (var_13[0], var_13[1], param_00 - common_scripts\_plant_weapon::func_41B5());
    var_0A = func_6FAC(var_0A, var_13, var_14, param_07, var_0F, param_08);
    var_0A["is_hit"] = !var_0A["is_hit"];
    if(var_0A["is_hit"]) {
      var_0A["hit_angle"] = var_0A["current_angle"];
      break;
    }
  }

  return var_0A;
}

func_4B43(param_00, param_01, param_02) {
  if(isDefined(param_00)) {
    var_03 = [];
    var_03["is_hit"] = 0;
    var_04 = anglesToForward(combineangles(self.var_001D, (0, param_02, 0)));
    var_05 = param_00 - var_04 * param_01;
    var_06 = (var_05[0], var_05[1], self.var_0116[2] - common_scripts\_plant_weapon::func_41B5());
    var_03 = func_6FAC(var_03, var_05, var_06, self, anglesToForward(self.var_001D), undefined);
    return var_03["is_hit"];
  }

  return 0;
}

func_43D8(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = combineangles(param_03, (0, 180, 0));
  var_0D = (param_01[0], param_01[1], 0) - (param_02[0], param_02[1], 0);
  var_0E = length(var_0D);
  var_0F = vectornormalize(var_0D);
  var_10 = param_01 + var_0F * param_05 + (0, 0, param_04);
  var_11["right_outer"] = spawnStruct();
  var_11["right_outer"].var_0F40 = var_10;
  var_11["right_outer"].var_0F42 = param_06;
  var_11["right_outer"].var_0F3E = -1 * param_08;
  var_11["right_outer"].var_7EDF = var_0C;
  var_11["right_outer"].var_7064 = param_00;
  var_11["right_outer"].var_32D3 = param_0B;
  var_11["right_outer"].trace_type = "arc_radial";
  var_11["right_outer"].custom_mask = undefined;
  var_11["left_outer"] = spawnStruct();
  var_11["left_outer"].var_0F40 = var_10;
  var_11["left_outer"].var_0F42 = param_06;
  var_11["left_outer"].var_0F3E = param_07;
  var_11["left_outer"].var_7EDF = var_0C;
  var_11["left_outer"].var_7064 = param_00;
  var_11["left_outer"].var_32D3 = param_0B;
  var_11["left_outer"].trace_type = "arc_radial";
  var_11["left_outer"].custom_mask = undefined;
  var_12 = var_0E + 7;
  var_11["right_inner"] = spawnStruct();
  var_11["right_inner"].var_0F40 = var_10;
  var_11["right_inner"].var_0F42 = var_12;
  var_11["right_inner"].var_0F3E = -1 * param_08;
  var_11["right_inner"].var_7EDF = var_0C;
  var_11["right_inner"].var_7064 = param_00;
  var_11["right_inner"].var_32D3 = param_0B;
  var_11["right_inner"].trace_type = "arc_single";
  var_11["right_inner"].custom_mask = 377552881;
  var_11["left_inner"] = spawnStruct();
  var_11["left_inner"].var_0F40 = var_10;
  var_11["left_inner"].var_0F42 = var_12;
  var_11["left_inner"].var_0F3E = param_07;
  var_11["left_inner"].var_7EDF = var_0C;
  var_11["left_inner"].var_7064 = param_00;
  var_11["left_inner"].var_32D3 = param_0B;
  var_11["left_inner"].trace_type = "arc_single";
  var_11["left_inner"].custom_mask = 377552881;
  var_13 = vectortoangles(vectornormalize(param_02 - param_01));
  if(common_scripts\_plant_weapon::func_8BAF()) {
    var_11["le_top_tag_player"] = spawnStruct();
    var_11["le_top_tag_player"].var_0F40 = param_01;
    var_11["le_top_tag_player"].var_0F42 = distance(param_02, param_01);
    var_11["le_top_tag_player"].var_0F3E = param_07;
    var_11["le_top_tag_player"].var_0F3F = param_09;
    var_11["le_top_tag_player"].var_7EDF = var_13;
    var_11["le_top_tag_player"].trace_type = "arc_multi";
    var_11["le_top_tag_player"].custom_mask = 377749489;
    var_11["ri_top_tag_player"] = spawnStruct();
    var_11["ri_top_tag_player"].var_0F40 = param_01;
    var_11["ri_top_tag_player"].var_0F42 = distance(param_02, param_01);
    var_11["ri_top_tag_player"].var_0F3E = -1 * param_08;
    var_11["ri_top_tag_player"].var_0F3F = param_09;
    var_11["ri_top_tag_player"].var_7EDF = var_13;
    var_11["ri_top_tag_player"].trace_type = "arc_multi";
    var_11["ri_top_tag_player"].custom_mask = 377749489;
  }

  var_14 = 12;
  var_15 = 7;
  var_16 = func_41EB(self, var_11, var_14, var_15);
  var_17 = var_16[0];
  var_18 = var_16[1];
  var_19 = var_16[2];
  var_1A = var_16[3];
  if(!isDefined(var_17) || var_17 > param_07) {
    var_17 = param_07;
  }

  if(!isDefined(var_18) || var_18 > param_08) {
    var_18 = param_08;
  }

  if(!isDefined(var_19) || var_19 > param_09) {
    var_19 = param_09;
  }

  if(!isDefined(var_1A) || var_1A > param_0A) {
    var_1A = param_0A;
  }

  return [var_17, var_18, var_19, var_1A];
}

func_10D0(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_01)) {
    param_01 = param_00;
  }

  param_00.var_5C66 = param_00 method_85A3();
  param_00.var_7E86 = param_00 method_85A4();
  param_00.var_9A95 = param_00 method_84BB();
  param_00.var_1B4B = param_00 method_84BC();
  var_05 = param_01 gettagorigin("TAG_PLAYER");
  var_06 = param_01 gettagangles("TAG_PLAYER");
  var_07 = param_01 gettagorigin("TAG_TURRET");
  var_08 = param_01 gettagangles("TAG_TURRET");
  var_09 = var_07 - var_05;
  var_0A = length(var_09);
  var_0B = combineangles(var_08, (0, 180, 0));
  var_0C = vectortoangles(vectornormalize(var_05 - var_07));
  var_0C = combineangles(var_0C, (0, 0, 90));
  var_0D = combineangles(var_08, (0, 180, 90));
  var_0E = [];
  var_0F = (var_07[0], var_07[1], var_05[2]);
  if(isDefined(param_03)) {
    if(var_0A > 0) {
      var_10 = var_09 * 1 / var_0A;
      var_0F = var_0F + var_10 * param_03;
    }
  }

  if(!isDefined(param_04)) {
    param_04 = 15;
  }

  if(isDefined(param_03)) {
    param_04 = param_04 - param_03;
  }

  var_11 = var_0A + param_04;
  var_12 = var_05 - var_07;
  var_13 = func_43D8(param_02[2], var_07, var_05, var_08, var_12[2], 0, var_11, param_00.var_5C66, param_00.var_7E86, param_00.var_9A95, param_00.var_1B4B);
  var_14 = var_13[0];
  var_15 = var_13[1];
  var_16 = var_13[2];
  var_17 = var_13[3];
  if(isDefined(var_14) && var_14 < param_00 method_85A3()) {
    param_00 method_8151(var_14);
  }

  if(isDefined(var_15) && var_15 < param_00 method_85A4()) {
    param_00 method_8150(var_15);
  }

  if(isDefined(var_16) && var_16 < param_00 method_84BB()) {
    param_00 method_8152(var_16);
  }

  if(isDefined(var_17) && var_17 < param_00 method_84BC()) {
    param_00 method_8153(var_17);
  }
}

func_41EB(param_00, param_01, param_02, param_03) {
  var_04 = [];
  var_05 = "";
  var_06 = 0;
  var_07 = undefined;
  foreach(var_0D, var_09 in param_01) {
    var_0A = undefined;
    if(issubstr(var_0D, "left")) {
      var_05 = "left";
      var_0A = param_02;
    } else if(issubstr(var_0D, "right")) {
      var_05 = "right";
      var_0A = param_02;
    }

    if(issubstr(var_0D, "top")) {
      var_05 = "top";
      var_0A = param_03;
    } else if(issubstr(var_0D, "bottom")) {
      var_05 = "bottom";
      var_0A = param_03;
    }

    if(var_09.trace_type == "arc_radial") {
      var_07 = func_6FAB(var_09.var_7064, var_09.var_0F40, var_09.var_7EDF, var_09.var_0F42, var_09.var_0F3E, 5, var_09.var_32D3, param_00, var_09.custom_mask);
    } else if(var_09.trace_type == "arc_multi") {
      var_0B = add_padding_and_get_signed_arc_angle_override_if_needed(var_09.var_0F3E, var_0D, var_04, var_0A);
      var_07 = func_6FAA(var_09.var_0F40, var_09.var_7EDF, var_09.var_0F42, var_0B, 10, var_09.var_0F3F + param_03, param_00, var_09.custom_mask);
    } else if(var_09.trace_type == "arc_single") {
      var_0B = add_padding_and_get_signed_arc_angle_override_if_needed(var_09.var_0F3E, var_0D, var_04, var_0A);
      var_07 = common_scripts\utility::func_6FA9(var_09.var_0F40, var_09.var_7EDF, var_09.var_0F42, var_0B, param_00, var_09.custom_mask);
    }

    if(var_07["is_hit"]) {
      var_0C = var_07["hit_angle"];
      var_0C = abs(angleclamp180(var_0C));
      if(var_0C > 10) {
        var_0C = var_0C - var_0A;
      }

      if(!isDefined(var_04[var_05]) || var_0C < var_04[var_05]) {
        var_04[var_05] = var_0C;
      }
    }

    var_06++;
  }

  return [var_04["left"], var_04["right"], var_04["top"], var_04["bottom"]];
}

add_padding_and_get_signed_arc_angle_override_if_needed(param_00, param_01, param_02, param_03) {
  if(function_02C6(param_01, "le") && isDefined(param_02["left"])) {
    var_04 = param_02["left"];
  } else if(function_02C6(param_02, "ri") && isDefined(param_03["right"])) {
    var_04 = param_03["right"];
  } else {
    var_04 = abs(param_01);
  }

  if(param_00 < 0) {
    var_05 = -1 * var_04 + param_03;
  } else {
    var_05 = var_05 + var_04;
  }

  return var_05;
}

func_6FAA(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = getdvarint("turret_plant_debug") == 2;
  var_09 = [];
  var_0A = func_42BA(param_00, param_01, param_02, param_03, param_04, 0);
  var_0B = var_0A[0];
  var_0C = var_0A[1];
  var_0D = var_0A[2];
  var_0E = anglesToForward(param_01);
  for(var_0F = 0; var_0F < var_0B.size; var_0F++) {
    var_10 = vectortoangles(vectornormalize(var_0B[var_0F] - param_00));
    var_10 = combineangles(var_10, (0, 0, 90));
    if(param_05 > 0) {
      param_05 = param_05 * -1;
    }

    var_09[var_0F] = common_scripts\utility::func_6FA9(param_00, var_10, param_02, param_05, param_06, param_07);
  }

  var_11 = undefined;
  var_12 = 0;
  for(var_0F = 0; var_0F < var_09.size; var_0F++) {
    if(isDefined(var_09[var_0F]["is_hit"]) && var_09[var_0F]["is_hit"]) {
      if(!isDefined(var_11) || abs(var_11) > abs(var_09[var_0F]["hit_angle"])) {
        var_11 = var_09[var_0F]["hit_angle"];
        var_12 = var_0F;
      }
    }
  }

  return var_09[var_12];
}

func_7E4B(param_00) {
  if(isDefined(param_00.var_5C66)) {
    param_00 method_8151(param_00.var_5C66);
  }

  if(isDefined(param_00.var_7E86)) {
    param_00 method_8150(param_00.var_7E86);
  }

  if(isDefined(param_00.var_9A95)) {
    param_00 method_8152(param_00.var_9A95);
  }

  if(isDefined(param_00.var_1B4B)) {
    param_00 method_8153(param_00.var_1B4B);
  }

  param_00.var_5C66 = undefined;
  param_00.var_7E86 = undefined;
  param_00.var_9A95 = undefined;
  param_00.var_1B4B = undefined;
}