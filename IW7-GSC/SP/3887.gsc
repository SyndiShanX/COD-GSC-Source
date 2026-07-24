/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3887.gsc
**************************************/

main() {
  _id_F990();
  _id_F9AF();
  _id_F930();
  _id_FA28();
  _id_F921();
  _id_FA3C();
  _id_F927();
  level thread _id_0F2D::_id_E241();
}

_id_F990() {
  level._id_13563 = spawnStruct();
  level._id_13563._id_1087E = getspawnerarray("vr_spawner_human");
  level._id_13563._id_63A1 = [];
  level._id_13563._id_12B98 = [];
  level._id_13563._id_2BE3 = [];
  level._id_13563._id_4E37 = 0;
  level._id_13563._id_BF5B = [];
  level._id_13563._id_653C = getEntArray("vr_enemy_uv_light", "targetname");

  foreach(var_1 in level._id_13563._id_653C) {
    var_1.active = 0;
    var_1._id_10C89 = 0.01;
    var_1._id_10CF0 = var_1 _meth_8136();
  }

  level._id_13563._id_2F09 = getEnt("vr_boundary_wall", "targetname");
  level._id_13563._id_2F09 hide();
  level._id_13563._id_760D = [];
  level._id_13563._id_5BDE = 0;
  level._id_BFED = 1;
  level._id_55F0 = 1;
  scripts\engine\utility::flag_init("vr_delete_thrown_grenades");
  scripts\engine\utility::flag_init("vr_tutorial_leave_shown");
}

_id_1355F() {
  precachestring(&"SHIPCRIB_VR_TUT_LEAVE");
  scripts\sp\utility::_id_16EB("vr_tut_leave", &"SHIPCRIB_VR_TUT_LEAVE", ::_id_13569);
}

_id_13569() {
  return scripts\engine\utility::flag("vr_tutorial_leave_shown");
}

_id_F9AF() {
  level._id_13563._id_9B3D = getEnt("vr_iris", "targetname");
  level._id_13563._id_9B3D._id_CBFA = getEnt("vr_iris_pivot", "targetname");
  level._id_13563._id_9B3D._id_CBFA.start_pos = level._id_13563._id_9B3D._id_CBFA.origin;
  level._id_13563._id_9B3D linkTo(level._id_13563._id_9B3D._id_CBFA);
}

_id_F930() {
  level._id_13563._id_4D95 = [];
  var_0 = getEntArray("vr_data_box", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      continue;
    }
    if(isDefined(var_2.target)) {
      var_2._id_A645 = getEnt(var_2.target, "targetname");
      var_2._id_A645 thread _id_F9BC(var_2);
    }

    var_2 hide();
    level._id_13563._id_4D95[var_2.targetname] = var_2;
  }
}

_id_F9BC(var_0) {
  self._id_1FBB = "killcounter";
  self._id_4B5B = 0;
  scripts\sp\utility::_id_23B7("killcounter");
  scripts\sp\utility::_id_65E0("killcounter_animating");
  var_1 = scripts\sp\utility::_id_7CCC(self.model);
  self._id_1141E = [];
  self._id_1141C = [];

  foreach(var_3 in var_1) {
    if(issubstr(var_3, "tag_num")) {
      self hidepart(var_3);
      self._id_1141E[self._id_1141E.size] = var_3;
      continue;
    }

    if(issubstr(var_3, "tag_boxcounter")) {
      self hidepart(var_3);
      self._id_1141C[self._id_1141C.size] = var_3;
    }
  }

  self hide();
  self linkTo(var_0, "tag_enemy_counter", (0, 0, 0), (0, 0, 0));
}

_id_FA28() {
  var_0 = getEntArray("vr_ring_rig", "targetname");

  foreach(var_2 in var_0) {
    level._id_13563._id_E546[var_2._id_EDD5] = var_2;
    var_3 = scripts\engine\utility::getStruct("vr_ring" + var_2._id_EDD5 + "_start", "targetname");
    var_2.start_pos = var_3.origin;
    var_2._id_10BA1 = var_3.angles;
    var_2 scripts\sp\utility::_id_65E0("ring_spinning");
    var_2 scripts\sp\utility::_id_65E0("ring_unfolding");
    var_2._id_1FBB = "ring" + var_2._id_EDD5;
    var_2 scripts\sp\utility::_id_23B7("ring" + var_2._id_EDD5);
    var_2 hide();

    if(var_2._id_EDD5 == 0) {
      var_2._id_D958 = getEnt("vr_ring" + var_2._id_EDD5 + "_probe", "targetname");
      var_2._id_D958 linkTo(var_2, "tag_origin", (0, 0, 0), (0, 90, 0));
    }
  }
}

_id_F921() {
  foreach(var_1 in level._id_13563._id_E546) {
    var_2 = _id_7834("vr_corner_helper", "targetname", var_1._id_EDD5);
    var_3 = _id_7834("vr_cornerpiece", "script_noteworthy", var_1._id_EDD5);

    foreach(var_5 in var_2) {
      var_1._id_466A[var_5.script_index] = _id_7989(var_3, var_5.script_index);
      var_6 = var_1._id_466A[var_5.script_index];
      var_6._id_6B71 = getEntArray("vr_ring" + var_1._id_EDD5 + "_corner" + var_6.script_index + "_falling_geo", "script_noteworthy");
      var_7 = _id_7AFE(var_5.target, "targetname");
      _id_4660(var_7, var_1, var_6);
      var_6._id_6128 hide();
      var_6._id_6123 hide();

      if(var_6._id_EDD5 == 1) {
        var_6 scripts\sp\utility::_id_65E0("segment_dropping_geo");
        var_6._id_1078F._id_F187 = var_6._id_1078F.origin - var_6._id_CBFA.origin;
        var_6._id_1078F._id_A534 = undefined;
      }

      if(isDefined(var_6._id_6B71)) {
        var_8 = [];

        foreach(var_10 in var_6._id_6B71) {
          var_10._id_7595 = "vfx_vr_blockdrop_extra_small";
          var_8[var_10._id_EE8C] = var_10;
          var_10._id_8D0D = 512;
          var_10._id_D6A0 = var_10.origin + (0, 0, var_10._id_8D0D) - var_6._id_CBFA.origin;
          var_10.angles_offset = var_10.angles - var_6._id_CBFA.angles;
          var_10 linkTo(var_6._id_CBFA, "", var_10._id_D6A0, var_10.angles_offset);
        }

        var_6._id_6B71 = var_8;
      }

      var_6 linkTo(var_6._id_CBFA);
      var_6._id_AC84 linkTo(var_6._id_CBFA);
      var_6._id_6128 linkTo(var_6._id_CBFA);
      var_6._id_6123 linkTo(var_6._id_CBFA);
      var_6._id_CBFA linkTo(var_1, "j_corner" + var_6.script_index, (0, 0, 0), (0, 0, 0));
    }
  }
}

_id_4660(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(isent(var_4)) {
      if(isDefined(var_4.script_noteworthy)) {
        if(var_4.script_noteworthy == "pivot")
          var_2._id_CBFA = var_4;
        else if(var_4.script_noteworthy == "emissive_passive")
          var_2._id_6128 = var_4;
        else if(var_4.script_noteworthy == "emissive_active")
          var_2._id_6123 = var_4;
        else if(var_4.script_noteworthy == "light_center")
          var_2._id_AC84 = var_4;
      }

      continue;
    }

    if(isstruct(var_4)) {
      if(isDefined(var_4.script_noteworthy)) {
        if(var_4.script_noteworthy == "spawn_org")
          var_2._id_1078F = var_4;
      }
    }
  }
}

_id_FA3C() {
  foreach(var_1 in level._id_13563._id_E546) {
    var_2 = _id_7834("vr_segment_helper", "targetname", var_1._id_EDD5);

    foreach(var_4 in var_2) {
      if(isDefined(var_4.target))
        var_5 = _id_7AFE(var_4.target, "targetname");
      else
        var_5 = [];

      var_1.segments[var_4.script_index] = getEnt("vr_ring" + var_1._id_EDD5 + "_" + var_4.script_index, "targetname");
      var_6 = _id_7835("traverse", "targetname", var_1._id_EDD5, var_4.script_index);
      var_5 = scripts\engine\utility::array_combine(var_5, var_6);
      var_7 = var_1.segments[var_4.script_index];
      var_7._id_CBFA = undefined;
      var_7._id_10870 = [];
      var_7._id_B7D5 = [];
      var_7.collision = undefined;

      if(var_1._id_EDD5 == 0) {
        if(var_7.script_index == 0 || var_7.script_index == 2)
          var_7._id_6E86 = getEnt("vr_cap" + var_7.script_index, "targetname");
        else {
          var_8 = getEntArray("vr_cap" + var_7.script_index, "targetname");

          foreach(var_10 in var_8) {
            if(var_10.script_parameters == "flap")
              var_7._id_6E86 = var_10;
          }

          foreach(var_10 in var_8) {
            if(var_10.script_parameters == "blue_lights") {
              var_7._id_6E86._id_6128 = var_10;
              var_7._id_6E86._id_6128 hide();
              continue;
            }

            if(var_10.script_parameters == "red_lights") {
              var_7._id_6E86._id_6123 = var_10;
              var_7._id_6E86._id_6123 hide();
            }
          }
        }
      } else if(var_1._id_EDD5 == 1) {
        var_7 scripts\sp\utility::_id_65E0("segment_dropping_geo");
        var_7._id_12B96 = getnode("vr_ring0_" + var_7.script_index + "_leftnode", "targetname");
        var_7._id_12B97 = getnode("vr_ring0_" + var_7.script_index + "_rightnode", "targetname");
        var_7._id_6B71 = getEntArray("vr_ring" + var_1._id_EDD5 + "_" + var_7.script_index + "_falling_geo", "script_noteworthy");
        var_7._id_75B5 = scripts\engine\utility::getStructArray("vr_ring" + var_1._id_EDD5 + "_" + var_7.script_index + "_fx", "targetname");
      }

      if(var_1._id_EDD5 == 5) {
        if(var_7.script_index == 1) {
          var_7._id_6128 = getEnt("vr_ring5_1_blue_light", "targetname");
          var_7._id_6123 = getEnt("vr_ring5_1_red_light", "targetname");
          var_7._id_6128 hide();
          var_7._id_6123 hide();
        } else if(var_7.script_index == 3) {
          var_7._id_6128 = getEnt("vr_ring5_3_blue_light", "targetname");
          var_7._id_6123 = getEnt("vr_ring5_3_red_light", "targetname");
          var_7._id_6128 hide();
          var_7._id_6123 hide();
        }
      }

      _id_F18A(var_5, var_1, var_7);
      var_7 linkTo(var_7._id_CBFA);

      foreach(var_15 in var_7._id_10870)
      var_15._id_F187 = var_15.origin - var_7._id_CBFA.origin;

      foreach(var_15 in var_7._id_B7D5)
      var_15._id_F187 = var_15.origin - var_7._id_CBFA.origin;

      if(isDefined(var_7._id_75B5)) {
        foreach(var_15 in var_7._id_75B5)
        var_15._id_F187 = var_15.origin - var_7._id_CBFA.origin;
      }

      if(isDefined(var_7._id_6E86)) {
        var_7._id_6E86.angles_offset = var_7._id_6E86.angles - var_7._id_CBFA.angles;
        var_7._id_6E86._id_D6A0 = var_7._id_6E86.origin - var_7._id_CBFA.origin;

        if(isDefined(var_7._id_6E86._id_6128)) {
          var_7._id_6E86._id_6128 linkTo(var_7._id_6E86, "", (0, 0, 0), (0, 0, 0));
          var_7._id_6E86._id_6123 linkTo(var_7._id_6E86, "", (0, 0, 0), (0, 0, 0));
        }

        var_7._id_6E86 linkTo(var_7._id_CBFA, "", var_7._id_6E86._id_D6A0, var_7._id_6E86.angles_offset);
      }

      if(isDefined(var_7._id_6128))
        var_7._id_6128 linkTo(var_7._id_CBFA, "", (0, 0, 0), (0, 0, 0));

      if(isDefined(var_7._id_6123))
        var_7._id_6123 linkTo(var_7._id_CBFA, "", (0, 0, 0), (0, 0, 0));

      if(isDefined(var_7._id_6B71)) {
        var_21 = [];

        foreach(var_23 in var_7._id_6B71) {
          var_21[var_23._id_EE8C] = var_23;
          var_23._id_8D0D = 512;
          var_23._id_D6A0 = var_23.origin + (0, 0, var_23._id_8D0D) - var_7._id_CBFA.origin;
          var_23.angles_offset = var_23.angles - var_7._id_CBFA.angles;
          var_23._id_7587 = anglestoright(var_7._id_CBFA.angles);
          var_23._id_7595 = "vfx_vr_blockdrop";

          if(isDefined(var_23.script_parameters)) {
            if(var_23.script_parameters == "vfx_3block")
              var_23._id_7595 = "vfx_vr_blockdrop_small";
            else if(var_23.script_parameters == "unfold")
              var_23._id_7595 = "vfx_vr_blockdrop_extra_small";
            else if(var_23.script_parameters == "angled") {
              var_15 = scripts\engine\utility::getStruct(var_23.target, "targetname");
              var_23._id_7587 = anglesToForward(var_15.angles);
            }
          }

          var_23 linkTo(var_7._id_CBFA, "", var_23._id_D6A0, var_23.angles_offset);
        }

        var_7._id_6B71 = var_21;
      }

      if(isDefined(var_7.collision))
        var_7.collision linkTo(var_7._id_CBFA);

      var_7._id_CBFA linkTo(var_1, "j_segment" + var_7.script_index, (0, 0, 0), (0, 0, 0));
    }
  }
}

_id_F18A(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(isent(var_4)) {
      if(isDefined(var_4.script_noteworthy)) {
        if(var_4.script_noteworthy == "pivot")
          var_2._id_CBFA = var_4;
        else if(var_4.script_noteworthy == "collision")
          var_2.collision = var_4;
      }

      continue;
    }

    if(isstruct(var_4)) {
      if(var_4.script_noteworthy == "spawn_org")
        _id_FA4A(var_4, var_1, var_2);
    }
  }
}

_id_FA4A(var_0, var_1, var_2) {
  var_3 = var_2._id_10870.size;
  var_2._id_10870[var_3] = var_0;

  if(!isDefined(var_2._id_10870[var_3]._id_EEBA))
    var_2._id_10870[var_3]._id_EEBA = 1;
}

_id_F9EB(var_0, var_1, var_2) {
  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "left")
      var_2._id_12B96 = var_0;
    else
      var_2._id_12B97 = var_0;
  }
}

_id_F927() {
  var_0 = getEnt("start_vr_chamber", "targetname").origin;
  var_1 = getEnt("start_vr_chamber", "targetname").angles;
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

_id_7834(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = _id_7AFE(var_0, var_1);

  foreach(var_6 in var_4) {
    if(!isDefined(var_6._id_EDD5)) {
      continue;
    }
    if(var_6._id_EDD5 == var_2)
      var_3[var_3.size] = var_6;
  }

  return var_3;
}

_id_7835(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = _id_7834(var_0, var_1, var_2);

  foreach(var_7 in var_5) {
    if(!isDefined(var_7.script_index)) {
      continue;
    }
    if(var_7.script_index == var_3)
      var_4[var_4.size] = var_7;
  }

  return var_4;
}

_id_7989(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3.script_index == var_1)
      return var_3;
  }
}

_id_7AFE(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\engine\utility::getStructArray(var_0, var_1);
  var_4 = getEntArray(var_0, var_1);
  var_5 = getnodearray(var_0, var_1);
  var_6 = scripts\engine\utility::array_combine(var_3, var_4);
  var_6 = scripts\engine\utility::array_combine(var_5, var_6);

  foreach(var_8 in var_6) {
    if(isDefined(var_8))
      var_2[var_2.size] = var_8;
  }

  return var_2;
}