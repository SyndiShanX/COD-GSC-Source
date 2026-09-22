/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_hit_found.gsc
*****************************************/

_id_4161(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 <= var_2; var_4 = var_4 + 3.0) {
    var_5 = var_1 * var_4;
    var_3[var_3.size] = var_0 + var_5;
  }

  var_3[var_3.size] = var_0 + var_1 * var_2;
  return var_3;
}

_id_9F90(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_5 = [];
  var_6 = [];
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = "none";
  var_11 = 99999999;
  var_12 = undefined;
  var_13 = undefined;
  var_14 = undefined;
  var_15 = undefined;
  var_16 = undefined;
  var_17 = undefined;
  var_18 = undefined;
  var_19 = undefined;
  var_20 = 0;
  var_21 = undefined;
  var_16 = anglesToForward(self.angles);
  var_16 = vectorNormalize((var_16[0], var_16[1], 0));
  var_22 = self.origin + var_16 * 15;

  if(var_2) {
    var_23 = 10.0;
    var_24 = 13.0;
  } else {
    var_23 = 60.0;
    var_24 = 45.0;
  }

  var_7 = var_22 + (0, 0, var_23);
  var_5 = _id_4161(var_7, var_16, 15.0);
  var_25 = var_5.size;

  for(var_26 = 0; var_26 < var_25; var_26++) {
    var_27 = var_5[var_26];
    var_28 = var_27 - (0, 0, var_24);

    if(isDefined(var_15) && isDefined(var_4)) {
      var_29 = _distance2d(var_27, var_8);

      if(var_29 > var_4) {
        var_6[var_26] = undefined;
        continue;
      }
    }

    if(!var_2) {
      var_6[var_26] = _id_9F91(var_27, var_28, var_0, var_1, 5, var_20);

      if(var_6[var_26]["is_matching_hit_found"] == 0) {
        if(1 && var_20) {
          var_6[var_26]["is_matching_hit_found"] = 1;
          var_6[var_26]["position"] = var_5[var_26];
        } else {
          var_6[var_26] = undefined;
          continue;
        }
      }

      if(!isDefined(var_21) && isDefined(var_6[var_26]["entity"])) {
        var_21 = var_6[var_26]["entity"];
        var_30 = _id_028D::_id_439E(var_21);

        if(isDefined(var_30)) {
          if(var_30 < 15.0) {} else {
            var_31 = _id_4161(var_5[var_25 - 1], var_16, var_30 - 15.0);
            var_5 = common_scripts\utility::_id_0F73(var_5, var_31);
            var_25 = var_5.size;
          }
        }
      }

      if(1 && !var_20 && (var_6[var_26]["surface_flags"] & 134217728 || var_6[var_26]["surface_flags"] & 67108864)) {
        var_20 = 1;
      }

      var_32 = var_6[var_26]["position"];
    } else
      var_32 = var_27;

    var_28 = var_5[var_26] - (0, 0, var_24);
    [var_34, var_35, var_36] = _id_1D85(var_32, var_28, 0);

    if(!isDefined(var_34)) {
      var_6[var_26] = undefined;
      continue;
    }

    var_14 = var_3 - 15;
    var_6[var_26]["brush_model_solid_spot"] = var_34;
    var_6[var_26]["brush_model_solid_surfacetype"] = var_35;
    var_6[var_26]["entity"] = var_36;

    if(!isDefined(var_17) || var_34[2] > var_17) {
      var_17 = var_34[2];
    }

    if(!isDefined(var_15)) {
      var_15 = var_26;
      var_8 = var_34;
      var_13 = var_8 + var_16 * var_14;
    }

    if(0) {
      break;
    }
  }

  if(1) {
    var_37 = [];

    foreach(var_39 in var_6) {
      if(var_17 - var_39["brush_model_solid_spot"][2] <= _id_028D::_id_41C4()) {
        var_37[var_37.size] = var_39;
        continue;
      }

      if(getdvarint("turret_plant_debug")) {}
    }

    var_6 = var_37;
  }

  foreach(var_39 in var_6) {
    var_42 = _distance2dsquared(var_39["brush_model_solid_spot"], var_13);

    if(var_42 < var_11) {
      var_11 = var_42;
      var_9 = var_39["brush_model_solid_spot"];
      var_10 = var_39["brush_model_solid_surfacetype"];
      var_12 = var_39["entity"];
    }
  }

  if(isDefined(var_9)) {
    var_44 = 1;

    if(var_2) {
      var_45 = 7.0;
      var_46[0] = (self.origin[0], self.origin[1], var_9[2] + var_45) - anglesToForward(self.angles) * 15;
      var_46[1] = var_46[0] - anglestoright(self.angles) * 15;
      var_46[2] = var_46[0] + anglestoright(self.angles) * 15;
      var_47 = (var_9[0], var_9[1], var_9[2] + var_45) + anglesToForward(self.angles) * 3.0;

      for(var_26 = 0; var_26 < var_46.size; var_26++) {
        [var_34, var_35] = _id_1D85(var_46[var_26], var_47, 1, var_26, var_46.size);

        if(isDefined(var_34)) {
          var_44 = 0;
          break;
        }
      }
    }

    if(var_44) {
      return [var_9, var_10, var_12];
    }
  }

  return [undefined, undefined, undefined];
}

_id_9F91(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;
  var_7 = 0;

  if(var_2) {
    var_6 = var_6 | 536870912;
    var_7 = var_7 | 64;
  }

  if(var_3) {
    var_6 = var_6 | 16777216;
    var_7 = var_7 | 67108864;
    var_7 = var_7 | 134217728;
  }

  var_8 = _func_335(var_0, var_1, var_6, var_7, self, var_4);
  return var_8;
}

_id_1D85(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = undefined;
  var_7 = ~0;
  var_8 = 0;

  if(var_2) {
    var_9 = 377552881;
  } else {
    var_9 = 377749489;
  }

  var_6 = _func_335(var_0, var_1, var_9, var_7, self, undefined, var_8);

  if(var_6["is_matching_hit_found"]) {
    return [var_6["position"], var_6["surfacetype"], var_6["entity"]];
  } else {
    return [undefined, undefined];
  }
}

_id_6FAC(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getdvarint("turret_plant_debug") == 2;

  if(var_0["is_hit"]) {
    if(!var_6) {
      return;
    }
  }

  var_7 = var_1;
  var_8 = var_2;

  if(!isDefined(var_5)) {
    var_9 = _physicstrace(var_7, var_8, var_3);
  } else {
    var_10 = _func_335(var_7, var_8, var_5, undefined, var_3);

    if(var_10["is_matching_hit_found"]) {
      var_9 = var_10["position"];
    } else {
      var_9 = var_8;
    }
  }

  if(!isDefined(var_0["current_angle"])) {
    var_11 = vectorNormalize(var_9 - var_7);
    var_4 = vectorNormalize(var_4);
    var_12 = vectordot(var_11, var_4);
    var_12 = clamp(var_12, -1, 1);
    var_0["current_angle"] = _acos(var_12);
  }

  if(!common_scripts\utility::_id_5646(var_9, var_8)) {
    if(var_0["is_hit"] == 0) {
      var_0["hit_angle"] = var_0["current_angle"];
      var_0["hit_point"] = var_9;
      var_0["is_hit"] = 1;
    }
  }

  return var_0;
}

_id_42BA(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_7 = [];

  if(!isDefined(var_4)) {
    var_4 = 20;
  }

  var_8 = undefined;

  if(var_3 > 0) {
    var_8 = int(var_3 / var_4) + 2;
  } else {
    var_4 = -1 * var_4;
    var_8 = int(var_3 / var_4) + 2;
  }

  var_9 = 0;

  for(var_10 = 0; var_10 < var_8; var_10++) {
    if(var_10 == var_8 - 1) {
      var_9 = var_3;
    } else {
      var_9 = var_10 * var_4;
    }

    var_11 = undefined;

    if(0) {
      var_11 = _combineangles(var_1, (0, var_9, 0));
    } else {
      var_11 = (var_1[0], _angleclamp180(var_1[1] + var_9), var_1[2]);
    }

    var_12 = anglesToForward(var_11) * var_2;
    var_6[var_10] = var_12 + var_0;

    if(var_5) {
      var_13 = _combineangles(var_11, (0, var_5, 0));
      var_14 = anglesToForward(var_13) * var_2;
      var_7[var_10] = var_14 + var_0;
    }
  }

  return [var_6, var_7, var_10];
}

_id_6FAB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = getdvarint("turret_plant_debug") == 2;
  var_10 = [];
  [var_12, var_13, var_14] = _id_42BA(var_1, var_2, var_3, var_4, var_5, var_6);
  var_15 = anglesToForward(var_2);
  var_10["is_hit"] = 0;
  var_10["arc_end"] = var_12[var_14];

  for(var_16 = 0; var_16 < var_12.size; var_16++) {
    var_10["current_angle"] = undefined;
    var_10 = _id_6FAC(var_10, var_1, var_12[var_16], var_7, var_15, var_8);

    if(var_10["is_hit"]) {
      break;
    }

    if(var_6) {
      var_17 = var_13[var_16];
    } else {
      var_17 = var_12[var_16];
    }

    var_18 = (var_17[0], var_17[1], var_0 + _id_028D::_id_41B5());
    var_10 = _id_6FAC(var_10, var_17, var_18, var_7, var_15, var_8);

    if(var_10["is_hit"]) {
      break;
    }

    var_19 = var_18;
    var_20 = (var_19[0], var_19[1], var_0 - _id_028D::_id_41B5());
    var_10 = _id_6FAC(var_10, var_19, var_20, var_7, var_15, var_8);
    var_10["is_hit"] = !var_10["is_hit"];

    if(var_10["is_hit"]) {
      var_10["hit_angle"] = var_10["current_angle"];
      break;
    }
  }

  return var_10;
}

_id_4B43(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_3 = [];
    var_3["is_hit"] = 0;
    var_4 = anglesToForward(_combineangles(self.angles, (0, var_2, 0)));
    var_5 = var_0 - var_4 * var_1;
    var_6 = (var_5[0], var_5[1], self.origin[2] - _id_028D::_id_41B5());
    var_3 = _id_6FAC(var_3, var_5, var_6, self, anglesToForward(self.angles), undefined);
    return var_3["is_hit"];
  }

  return 0;
}

_id_43D8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = _combineangles(var_3, (0, 180, 0));
  var_13 = (var_1[0], var_1[1], 0) - (var_2[0], var_2[1], 0);
  var_14 = length(var_13);
  var_15 = vectorNormalize(var_13);
  var_16 = var_1 + var_15 * var_5 + (0, 0, var_4);
  var_17["right_outer"] = spawnStruct();
  var_17["right_outer"]._id_0F40 = var_16;
  var_17["right_outer"]._id_0F42 = var_6;
  var_17["right_outer"]._id_0F3E = -1 * var_8;
  var_17["right_outer"]._id_7EDF = var_12;
  var_17["right_outer"]._id_7064 = var_0;
  var_17["right_outer"]._id_32D3 = var_11;
  var_17["right_outer"].trace_type = "arc_radial";
  var_17["right_outer"].custom_mask = undefined;
  var_17["left_outer"] = spawnStruct();
  var_17["left_outer"]._id_0F40 = var_16;
  var_17["left_outer"]._id_0F42 = var_6;
  var_17["left_outer"]._id_0F3E = var_7;
  var_17["left_outer"]._id_7EDF = var_12;
  var_17["left_outer"]._id_7064 = var_0;
  var_17["left_outer"]._id_32D3 = var_11;
  var_17["left_outer"].trace_type = "arc_radial";
  var_17["left_outer"].custom_mask = undefined;
  var_18 = var_14 + 7.0;
  var_17["right_inner"] = spawnStruct();
  var_17["right_inner"]._id_0F40 = var_16;
  var_17["right_inner"]._id_0F42 = var_18;
  var_17["right_inner"]._id_0F3E = -1 * var_8;
  var_17["right_inner"]._id_7EDF = var_12;
  var_17["right_inner"]._id_7064 = var_0;
  var_17["right_inner"]._id_32D3 = var_11;
  var_17["right_inner"].trace_type = "arc_single";
  var_17["right_inner"].custom_mask = 377552881;
  var_17["left_inner"] = spawnStruct();
  var_17["left_inner"]._id_0F40 = var_16;
  var_17["left_inner"]._id_0F42 = var_18;
  var_17["left_inner"]._id_0F3E = var_7;
  var_17["left_inner"]._id_7EDF = var_12;
  var_17["left_inner"]._id_7064 = var_0;
  var_17["left_inner"]._id_32D3 = var_11;
  var_17["left_inner"].trace_type = "arc_single";
  var_17["left_inner"].custom_mask = 377552881;
  var_19 = vectortoangles(vectorNormalize(var_2 - var_1));

  if(_id_028D::_id_8BAF()) {
    var_17["le_top_tag_player"] = spawnStruct();
    var_17["le_top_tag_player"]._id_0F40 = var_1;
    var_17["le_top_tag_player"]._id_0F42 = distance(var_2, var_1);
    var_17["le_top_tag_player"]._id_0F3E = var_7;
    var_17["le_top_tag_player"]._id_0F3F = var_9;
    var_17["le_top_tag_player"]._id_7EDF = var_19;
    var_17["le_top_tag_player"].trace_type = "arc_multi";
    var_17["le_top_tag_player"].custom_mask = 377749489;
    var_17["ri_top_tag_player"] = spawnStruct();
    var_17["ri_top_tag_player"]._id_0F40 = var_1;
    var_17["ri_top_tag_player"]._id_0F42 = distance(var_2, var_1);
    var_17["ri_top_tag_player"]._id_0F3E = -1 * var_8;
    var_17["ri_top_tag_player"]._id_0F3F = var_9;
    var_17["ri_top_tag_player"]._id_7EDF = var_19;
    var_17["ri_top_tag_player"].trace_type = "arc_multi";
    var_17["ri_top_tag_player"].custom_mask = 377749489;
  }

  var_20 = 12;
  var_21 = 7;
  [var_23, var_24, var_25, var_26] = _id_41EB(self, var_17, var_20, var_21);

  if(!isDefined(var_23) || var_23 > var_7) {
    var_23 = var_7;
  }

  if(!isDefined(var_24) || var_24 > var_8) {
    var_24 = var_8;
  }

  if(!isDefined(var_25) || var_25 > var_9) {
    var_25 = var_9;
  }

  if(!isDefined(var_26) || var_26 > var_10) {
    var_26 = var_10;
  }

  return [var_23, var_24, var_25, var_26];
}

_id_10D0(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  var_0._id_5C66 = var_0 _meth_85A3();
  var_0._id_7E86 = var_0 _meth_85A4();
  var_0._id_9A95 = var_0 gettoparc();
  var_0._id_1B4B = var_0 getbottomarc();
  var_5 = var_1 gettagorigin("TAG_PLAYER");
  var_6 = var_1 gettagangles("TAG_PLAYER");
  var_7 = var_1 gettagorigin("TAG_TURRET");
  var_8 = var_1 gettagangles("TAG_TURRET");
  var_9 = var_7 - var_5;
  var_10 = length(var_9);
  var_11 = _combineangles(var_8, (0, 180, 0));
  var_12 = vectortoangles(vectorNormalize(var_5 - var_7));
  var_12 = _combineangles(var_12, (0, 0, 90));
  var_13 = _combineangles(var_8, (0, 180, 90));
  var_14 = [];
  var_15 = (var_7[0], var_7[1], var_5[2]);

  if(isDefined(var_3)) {
    if(var_10 > 0) {
      var_16 = var_9 * (1 / var_10);
      var_15 = var_15 + var_16 * var_3;
    }
  }

  if(!isDefined(var_4)) {
    var_4 = 15;
  }

  if(isDefined(var_3)) {
    var_4 = var_4 - var_3;
  }

  var_17 = var_10 + var_4;
  var_18 = var_5 - var_7;
  [var_20, var_21, var_22, var_23] = _id_43D8(var_2[2], var_7, var_5, var_8, var_18[2], 0, var_17, var_0._id_5C66, var_0._id_7E86, var_0._id_9A95, var_0._id_1B4B);

  if(isDefined(var_20) && var_20 < var_0 _meth_85A3()) {
    var_0 setleftarc(var_20);
  }

  if(isDefined(var_21) && var_21 < var_0 _meth_85A4()) {
    var_0 setrightarc(var_21);
  }

  if(isDefined(var_22) && var_22 < var_0 gettoparc()) {
    var_0 settoparc(var_22);
  }

  if(isDefined(var_23) && var_23 < var_0 getbottomarc()) {
    var_0 setbottomarc(var_23);
  }
}

_id_41EB(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = "";
  var_6 = 0;
  var_7 = undefined;

  foreach(var_13, var_9 in var_1) {
    var_10 = undefined;

    if(issubstr(var_13, "left")) {
      var_5 = "left";
      var_10 = var_2;
    } else if(issubstr(var_13, "right")) {
      var_5 = "right";
      var_10 = var_2;
    }

    if(issubstr(var_13, "top")) {
      var_5 = "top";
      var_10 = var_3;
    } else if(issubstr(var_13, "bottom")) {
      var_5 = "bottom";
      var_10 = var_3;
    }

    if(var_9.trace_type == "arc_radial") {
      var_7 = _id_6FAB(var_9._id_7064, var_9._id_0F40, var_9._id_7EDF, var_9._id_0F42, var_9._id_0F3E, 5.0, var_9._id_32D3, var_0, var_9.custom_mask);
    } else if(var_9.trace_type == "arc_multi") {
      var_11 = add_padding_and_get_signed_arc_angle_override_if_needed(var_9._id_0F3E, var_13, var_4, var_10);
      var_7 = _id_6FAA(var_9._id_0F40, var_9._id_7EDF, var_9._id_0F42, var_11, 10.0, var_9._id_0F3F + var_3, var_0, var_9.custom_mask);
    } else if(var_9.trace_type == "arc_single") {
      var_11 = add_padding_and_get_signed_arc_angle_override_if_needed(var_9._id_0F3E, var_13, var_4, var_10);
      var_7 = common_scripts\utility::_id_6FA9(var_9._id_0F40, var_9._id_7EDF, var_9._id_0F42, var_11, var_0, var_9.custom_mask);
    }

    if(var_7["is_hit"]) {
      var_12 = var_7["hit_angle"];
      var_12 = _abs(_angleclamp180(var_12));

      if(var_12 > 10) {
        var_12 = var_12 - var_10;
      }

      if(!isDefined(var_4[var_5]) || var_12 < var_4[var_5]) {
        var_4[var_5] = var_12;
      }
    }

    var_6++;
  }

  return [var_4["left"], var_4["right"], var_4["top"], var_4["bottom"]];
}

add_padding_and_get_signed_arc_angle_override_if_needed(var_0, var_1, var_2, var_3) {
  if(_func_2C6(var_1, "le") && isDefined(var_2["left"])) {
    var_4 = var_2["left"];
  } else if(_func_2C6(var_1, "ri") && isDefined(var_2["right"])) {
    var_4 = var_2["right"];
  } else {
    var_4 = _abs(var_0);
  }

  if(var_0 < 0) {
    var_5 = -1 * (var_4 + var_3);
  } else {
    var_5 = var_4 + var_3;
  }

  return var_5;
}

_id_6FAA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = getdvarint("turret_plant_debug") == 2;
  var_9 = [];
  [var_11, var_12, var_13] = _id_42BA(var_0, var_1, var_2, var_3, var_4, 0);
  var_14 = anglesToForward(var_1);

  for(var_15 = 0; var_15 < var_11.size; var_15++) {
    var_16 = vectortoangles(vectorNormalize(var_11[var_15] - var_0));
    var_16 = _combineangles(var_16, (0, 0, 90));

    if(var_5 > 0) {
      var_5 = var_5 * -1;
    }

    var_9[var_15] = common_scripts\utility::_id_6FA9(var_0, var_16, var_2, var_5, var_6, var_7);
  }

  var_17 = undefined;
  var_18 = 0;

  for(var_15 = 0; var_15 < var_9.size; var_15++) {
    if(isDefined(var_9[var_15]["is_hit"]) && var_9[var_15]["is_hit"]) {
      if(!isDefined(var_17) || _abs(var_17) > _abs(var_9[var_15]["hit_angle"])) {
        var_17 = var_9[var_15]["hit_angle"];
        var_18 = var_15;
      }
    }
  }

  return var_9[var_18];
}

_id_7E4B(var_0) {
  if(isDefined(var_0._id_5C66)) {
    var_0 setleftarc(var_0._id_5C66);
  }

  if(isDefined(var_0._id_7E86)) {
    var_0 setrightarc(var_0._id_7E86);
  }

  if(isDefined(var_0._id_9A95)) {
    var_0 settoparc(var_0._id_9A95);
  }

  if(isDefined(var_0._id_1B4B)) {
    var_0 setbottomarc(var_0._id_1B4B);
  }

  var_0._id_5C66 = undefined;
  var_0._id_7E86 = undefined;
  var_0._id_9A95 = undefined;
  var_0._id_1B4B = undefined;
}