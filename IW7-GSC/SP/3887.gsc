/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3887.gsc
************************/

main() {
  func_F990();
  func_F9AF();
  func_F930();
  func_FA28();
  func_F921();
  func_FA3C();
  func_F927();
  level thread lib_0F2D::func_E241();
}

func_F990() {
  level.var_13563 = spawnStruct();
  level.var_13563.var_1087E = getspawnerarray("vr_spawner_human");
  level.var_13563.var_63A1 = [];
  level.var_13563.var_12B98 = [];
  level.var_13563.var_2BE3 = [];
  level.var_13563.var_4E37 = 0;
  level.var_13563.var_BF5B = [];
  level.var_13563.var_653C = getEntArray("vr_enemy_uv_light", "targetname");
  foreach(var_1 in level.var_13563.var_653C) {
    var_1.var_19 = 0;
    var_1.var_10C89 = 0.01;
    var_1.var_10CF0 = var_1 getspawnpoint();
  }

  level.var_13563.var_2F09 = getent("vr_boundary_wall", "targetname");
  level.var_13563.var_2F09 hide();
  level.var_13563.var_760D = [];
  level.var_13563.var_5BDE = 0;
  level.var_BFED = 1;
  level.var_55F0 = 1;
  scripts\engine\utility::flag_init("vr_delete_thrown_grenades");
  scripts\engine\utility::flag_init("vr_tutorial_leave_shown");
}

func_1355F() {
  precachestring(&"SHIPCRIB_VR_TUT_LEAVE");
  scripts\sp\utility::func_16EB("vr_tut_leave", &"SHIPCRIB_VR_TUT_LEAVE", ::func_13569);
}

func_13569() {
  return scripts\engine\utility::flag("vr_tutorial_leave_shown");
}

func_F9AF() {
  level.var_13563.var_9B3D = getent("vr_iris", "targetname");
  level.var_13563.var_9B3D.var_CBFA = getent("vr_iris_pivot", "targetname");
  level.var_13563.var_9B3D.var_CBFA.start_pos = level.var_13563.var_9B3D.var_CBFA.origin;
  level.var_13563.var_9B3D linkto(level.var_13563.var_9B3D.var_CBFA);
}

func_F930() {
  level.var_13563.var_4D95 = [];
  var_0 = getEntArray("vr_data_box", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      continue;
    }

    if(isDefined(var_2.target)) {
      var_2.var_A645 = getent(var_2.target, "targetname");
      var_2.var_A645 thread func_F9BC(var_2);
    }

    var_2 hide();
    level.var_13563.var_4D95[var_2.var_336] = var_2;
  }
}

func_F9BC(var_0) {
  self.var_1FBB = "killcounter";
  self.var_4B5B = 0;
  scripts\sp\utility::func_23B7("killcounter");
  scripts\sp\utility::func_65E0("killcounter_animating");
  var_1 = scripts\sp\utility::func_7CCC(self.model);
  self.var_1141E = [];
  self.var_1141C = [];
  foreach(var_3 in var_1) {
    if(issubstr(var_3, "tag_num")) {
      self hidepart(var_3);
      self.var_1141E[self.var_1141E.size] = var_3;
      continue;
    }

    if(issubstr(var_3, "tag_boxcounter")) {
      self hidepart(var_3);
      self.var_1141C[self.var_1141C.size] = var_3;
    }
  }

  self hide();
  self linkto(var_0, "tag_enemy_counter", (0, 0, 0), (0, 0, 0));
}

func_FA28() {
  var_0 = getEntArray("vr_ring_rig", "targetname");
  foreach(var_2 in var_0) {
    level.var_13563.var_E546[var_2.var_EDD5] = var_2;
    var_3 = scripts\engine\utility::getstruct("vr_ring" + var_2.var_EDD5 + "_start", "targetname");
    var_2.start_pos = var_3.origin;
    var_2.var_10BA1 = var_3.angles;
    var_2 scripts\sp\utility::func_65E0("ring_spinning");
    var_2 scripts\sp\utility::func_65E0("ring_unfolding");
    var_2.var_1FBB = "ring" + var_2.var_EDD5;
    var_2 scripts\sp\utility::func_23B7("ring" + var_2.var_EDD5);
    var_2 hide();
    if(var_2.var_EDD5 == 0) {
      var_2.var_D958 = getent("vr_ring" + var_2.var_EDD5 + "_probe", "targetname");
      var_2.var_D958 linkto(var_2, "tag_origin", (0, 0, 0), (0, 90, 0));
    }
  }
}

func_F921() {
  foreach(var_1 in level.var_13563.var_E546) {
    var_2 = func_7834("vr_corner_helper", "targetname", var_1.var_EDD5);
    var_3 = func_7834("vr_cornerpiece", "script_noteworthy", var_1.var_EDD5);
    foreach(var_5 in var_2) {
      var_1.var_466A[var_5.script_index] = func_7989(var_3, var_5.script_index);
      var_6 = var_1.var_466A[var_5.script_index];
      var_6.var_6B71 = getEntArray("vr_ring" + var_1.var_EDD5 + "_corner" + var_6.script_index + "_falling_geo", "script_noteworthy");
      var_7 = func_7AFE(var_5.target, "targetname");
      func_4660(var_7, var_1, var_6);
      var_6.var_6128 hide();
      var_6.var_6123 hide();
      if(var_6.var_EDD5 == 1) {
        var_6 scripts\sp\utility::func_65E0("segment_dropping_geo");
        var_6.var_1078F.var_F187 = var_6.var_1078F.origin - var_6.var_CBFA.origin;
        var_6.var_1078F.var_A534 = undefined;
      }

      if(isDefined(var_6.var_6B71)) {
        var_8 = [];
        foreach(var_0A in var_6.var_6B71) {
          var_0A.var_7595 = "vfx_vr_blockdrop_extra_small";
          var_8[var_0A.var_EE8C] = var_0A;
          var_0A.var_8D0D = 512;
          var_0A.var_D6A0 = var_0A.origin + (0, 0, var_0A.var_8D0D) - var_6.var_CBFA.origin;
          var_0A.var_42 = var_0A.angles - var_6.var_CBFA.angles;
          var_0A linkto(var_6.var_CBFA, "", var_0A.var_D6A0, var_0A.var_42);
        }

        var_6.var_6B71 = var_8;
      }

      var_6 linkto(var_6.var_CBFA);
      var_6.var_AC84 linkto(var_6.var_CBFA);
      var_6.var_6128 linkto(var_6.var_CBFA);
      var_6.var_6123 linkto(var_6.var_CBFA);
      var_6.var_CBFA linkto(var_1, "j_corner" + var_6.script_index, (0, 0, 0), (0, 0, 0));
    }
  }
}

func_4660(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(isent(var_4)) {
      if(isDefined(var_4.script_noteworthy)) {
        if(var_4.script_noteworthy == "pivot") {
          var_2.var_CBFA = var_4;
        } else if(var_4.script_noteworthy == "emissive_passive") {
          var_2.var_6128 = var_4;
        } else if(var_4.script_noteworthy == "emissive_active") {
          var_2.var_6123 = var_4;
        } else if(var_4.script_noteworthy == "light_center") {
          var_2.var_AC84 = var_4;
        }
      }

      continue;
    }

    if(isstruct(var_4)) {
      if(isDefined(var_4.script_noteworthy)) {
        if(var_4.script_noteworthy == "spawn_org") {
          var_2.var_1078F = var_4;
        }
      }
    }
  }
}

func_FA3C() {
  foreach(var_1 in level.var_13563.var_E546) {
    var_2 = func_7834("vr_segment_helper", "targetname", var_1.var_EDD5);
    foreach(var_4 in var_2) {
      if(isDefined(var_4.target)) {
        var_5 = func_7AFE(var_4.target, "targetname");
      } else {
        var_5 = [];
      }

      var_1.segments[var_4.script_index] = getent("vr_ring" + var_1.var_EDD5 + "_" + var_4.script_index, "targetname");
      var_6 = func_7835("traverse", "targetname", var_1.var_EDD5, var_4.script_index);
      var_5 = scripts\engine\utility::array_combine(var_5, var_6);
      var_7 = var_1.segments[var_4.script_index];
      var_7.var_CBFA = undefined;
      var_7.var_10870 = [];
      var_7.var_B7D5 = [];
      var_7.collision = undefined;
      if(var_1.var_EDD5 == 0) {
        if(var_7.script_index == 0 || var_7.script_index == 2) {
          var_7.var_6E86 = getent("vr_cap" + var_7.script_index, "targetname");
        } else {
          var_8 = getEntArray("vr_cap" + var_7.script_index, "targetname");
          foreach(var_0A in var_8) {
            if(var_0A.script_parameters == "flap") {
              var_7.var_6E86 = var_0A;
            }
          }

          foreach(var_0A in var_8) {
            if(var_0A.script_parameters == "blue_lights") {
              var_7.var_6E86.var_6128 = var_0A;
              var_7.var_6E86.var_6128 hide();
              continue;
            }

            if(var_0A.script_parameters == "red_lights") {
              var_7.var_6E86.var_6123 = var_0A;
              var_7.var_6E86.var_6123 hide();
            }
          }
        }
      } else if(var_1.var_EDD5 == 1) {
        var_7 scripts\sp\utility::func_65E0("segment_dropping_geo");
        var_7.var_12B96 = getnode("vr_ring0_" + var_7.script_index + "_leftnode", "targetname");
        var_7.var_12B97 = getnode("vr_ring0_" + var_7.script_index + "_rightnode", "targetname");
        var_7.var_6B71 = getEntArray("vr_ring" + var_1.var_EDD5 + "_" + var_7.script_index + "_falling_geo", "script_noteworthy");
        var_7.var_75B5 = scripts\engine\utility::getstructarray("vr_ring" + var_1.var_EDD5 + "_" + var_7.script_index + "_fx", "targetname");
      }

      if(var_1.var_EDD5 == 5) {
        if(var_7.script_index == 1) {
          var_7.var_6128 = getent("vr_ring5_1_blue_light", "targetname");
          var_7.var_6123 = getent("vr_ring5_1_red_light", "targetname");
          var_7.var_6128 hide();
          var_7.var_6123 hide();
        } else if(var_7.script_index == 3) {
          var_7.var_6128 = getent("vr_ring5_3_blue_light", "targetname");
          var_7.var_6123 = getent("vr_ring5_3_red_light", "targetname");
          var_7.var_6128 hide();
          var_7.var_6123 hide();
        }
      }

      func_F18A(var_5, var_1, var_7);
      var_7 linkto(var_7.var_CBFA);
      foreach(var_0F in var_7.var_10870) {
        var_0F.var_F187 = var_0F.origin - var_7.var_CBFA.origin;
      }

      foreach(var_0F in var_7.var_B7D5) {
        var_0F.var_F187 = var_0F.origin - var_7.var_CBFA.origin;
      }

      if(isDefined(var_7.var_75B5)) {
        foreach(var_0F in var_7.var_75B5) {
          var_0F.var_F187 = var_0F.origin - var_7.var_CBFA.origin;
        }
      }

      if(isDefined(var_7.var_6E86)) {
        var_7.var_6E86.var_42 = var_7.var_6E86.angles - var_7.var_CBFA.angles;
        var_7.var_6E86.var_D6A0 = var_7.var_6E86.origin - var_7.var_CBFA.origin;
        if(isDefined(var_7.var_6E86.var_6128)) {
          var_7.var_6E86.var_6128 linkto(var_7.var_6E86, "", (0, 0, 0), (0, 0, 0));
          var_7.var_6E86.var_6123 linkto(var_7.var_6E86, "", (0, 0, 0), (0, 0, 0));
        }

        var_7.var_6E86 linkto(var_7.var_CBFA, "", var_7.var_6E86.var_D6A0, var_7.var_6E86.var_42);
      }

      if(isDefined(var_7.var_6128)) {
        var_7.var_6128 linkto(var_7.var_CBFA, "", (0, 0, 0), (0, 0, 0));
      }

      if(isDefined(var_7.var_6123)) {
        var_7.var_6123 linkto(var_7.var_CBFA, "", (0, 0, 0), (0, 0, 0));
      }

      if(isDefined(var_7.var_6B71)) {
        var_15 = [];
        foreach(var_17 in var_7.var_6B71) {
          var_15[var_17.var_EE8C] = var_17;
          var_17.var_8D0D = 512;
          var_17.var_D6A0 = var_17.origin + (0, 0, var_17.var_8D0D) - var_7.var_CBFA.origin;
          var_17.var_42 = var_17.angles - var_7.var_CBFA.angles;
          var_17.var_7587 = anglestoright(var_7.var_CBFA.angles);
          var_17.var_7595 = "vfx_vr_blockdrop";
          if(isDefined(var_17.script_parameters)) {
            if(var_17.script_parameters == "vfx_3block") {
              var_17.var_7595 = "vfx_vr_blockdrop_small";
            } else if(var_17.script_parameters == "unfold") {
              var_17.var_7595 = "vfx_vr_blockdrop_extra_small";
            } else if(var_17.script_parameters == "angled") {
              var_0F = scripts\engine\utility::getstruct(var_17.target, "targetname");
              var_17.var_7587 = anglesToForward(var_0F.angles);
            }
          }

          var_17 linkto(var_7.var_CBFA, "", var_17.var_D6A0, var_17.var_42);
        }

        var_7.var_6B71 = var_15;
      }

      if(isDefined(var_7.collision)) {
        var_7.collision linkto(var_7.var_CBFA);
      }

      var_7.var_CBFA linkto(var_1, "j_segment" + var_7.script_index, (0, 0, 0), (0, 0, 0));
    }
  }
}

func_F18A(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(isent(var_4)) {
      if(isDefined(var_4.script_noteworthy)) {
        if(var_4.script_noteworthy == "pivot") {
          var_2.var_CBFA = var_4;
        } else if(var_4.script_noteworthy == "collision") {
          var_2.collision = var_4;
        }
      }

      continue;
    }

    if(isstruct(var_4)) {
      if(var_4.script_noteworthy == "spawn_org") {
        func_FA4A(var_4, var_1, var_2);
      }
    }
  }
}

func_FA4A(var_0, var_1, var_2) {
  var_3 = var_2.var_10870.size;
  var_2.var_10870[var_3] = var_0;
  if(!isDefined(var_2.var_10870[var_3].var_EEBA)) {
    var_2.var_10870[var_3].var_EEBA = 1;
  }
}

func_F9EB(var_0, var_1, var_2) {
  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "left") {
      var_2.var_12B96 = var_0;
      return;
    }

    var_2.var_12B97 = var_0;
  }
}

func_F927() {
  var_0 = getent("start_vr_chamber", "targetname").origin;
  var_1 = getent("start_vr_chamber", "targetname").angles;
  var_2 = (11008, 3712, 2362);
  var_3 = (0, 90, 0);
  var_4 = (11235.1, 3926.81, 2380.24) - var_2;
  var_5 = (270, 0, 0) - var_3;
  var_6 = scripts\common\createfx::createloopsound();
  var_6 scripts\common\createfx::set_origin_and_angles(var_0 + var_4, var_1 + var_5);
  var_6.v["soundalias"] = "emt_vr_hum_lp_01";
  var_4 = (10732.1, 3453.25, 2451) - var_2;
  var_5 = (270, 0, 0) - var_3;
  var_6 = scripts\common\createfx::createloopsound();
  var_6 scripts\common\createfx::set_origin_and_angles(var_0 + var_4, var_1 + var_5);
  var_6.v["soundalias"] = "emt_vr_hum_lp_01";
  var_4 = (11284.2, 3450.01, 2460) - var_2;
  var_5 = (270, 0, 0) - var_3;
  var_6 = scripts\common\createfx::createloopsound();
  var_6 scripts\common\createfx::set_origin_and_angles(var_0 + var_4, var_1 + var_5);
  var_6.v["soundalias"] = "emt_vr_hum_lp_01";
  var_4 = (10768.8, 3945.5, 2371.24) - var_2;
  var_5 = (270, 0, 0) - var_3;
  var_6 = scripts\common\createfx::createloopsound();
  var_6 scripts\common\createfx::set_origin_and_angles(var_0 + var_4, var_1 + var_5);
  var_6.v["soundalias"] = "emt_vr_hum_lp_01";
  var_4 = (11281.1, 3659.77, 2460) - var_2;
  var_5 = (270, 0, 0) - var_3;
  var_6 = scripts\common\createfx::createloopsound();
  var_6 scripts\common\createfx::set_origin_and_angles(var_0 + var_4, var_1 + var_5);
  var_6.v["soundalias"] = "emt_vr_hum_lp_02";
  var_4 = (10704.5, 3634.39, 2462) - var_2;
  var_5 = (270, 0, 0) - var_3;
  var_6 = scripts\common\createfx::createloopsound();
  var_6 scripts\common\createfx::set_origin_and_angles(var_0 + var_4, var_1 + var_5);
  var_6.v["soundalias"] = "emt_vr_hum_lp_02";
  var_4 = (11009.5, 3421.3, 2461) - var_2;
  var_5 = (270, 0, 0) - var_3;
  var_6 = scripts\common\createfx::createloopsound();
  var_6 scripts\common\createfx::set_origin_and_angles(var_0 + var_4, var_1 + var_5);
  var_6.v["soundalias"] = "emt_vr_hum_lp_03";
  var_4 = (11005, 3955.25, 2374.24) - var_2;
  var_5 = (270, 0, 0) - var_3;
  var_6 = scripts\common\createfx::createloopsound();
  var_6 scripts\common\createfx::set_origin_and_angles(var_0 + var_4, var_1 + var_5);
  var_6.v["soundalias"] = "emt_vr_hum_lp_03";
}

func_7834(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = func_7AFE(var_0, var_1);
  foreach(var_6 in var_4) {
    if(!isDefined(var_6.var_EDD5)) {
      continue;
    }

    if(var_6.var_EDD5 == var_2) {
      var_3[var_3.size] = var_6;
    }
  }

  return var_3;
}

func_7835(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = func_7834(var_0, var_1, var_2);
  foreach(var_7 in var_5) {
    if(!isDefined(var_7.script_index)) {
      continue;
    }

    if(var_7.script_index == var_3) {
      var_4[var_4.size] = var_7;
    }
  }

  return var_4;
}

func_7989(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3.script_index == var_1) {
      return var_3;
    }
  }
}

func_7AFE(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\engine\utility::getstructarray(var_0, var_1);
  var_4 = getEntArray(var_0, var_1);
  var_5 = getnodearray(var_0, var_1);
  var_6 = scripts\engine\utility::array_combine(var_3, var_4);
  var_6 = scripts\engine\utility::array_combine(var_5, var_6);
  foreach(var_8 in var_6) {
    if(isDefined(var_8)) {
      var_2[var_2.size] = var_8;
    }
  }

  return var_2;
}