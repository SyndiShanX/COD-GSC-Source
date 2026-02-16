/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\objective_barriers.gsc
*****************************************************/

init() {
  level._effect["objective_barrier"] = loadfx("vfx/s4/zombie/vfx_obj_holdout_barrier_mod_straight_56x48.vfx");
  register_tall_objective_barrier_instances();
  disable_all_tall_objective_barriers();
}

hide_all_objective_clip() {
  foreach(var_1 in level._id_3BE9._id_96DE) {
    foreach(var_3 in var_1._id_8300) {
      foreach(var_5 in var_3.versions) {
        if(isDefined(var_5._id_3BE8) && isDefined(var_5._id_3BE8["prop"])) {
          toggle_objective_clip(var_5._id_3BE8["prop"], 0, 1);
          continue;
        }

        toggle_objective_clip(undefined, 0, 1);
      }
    }
  }
}

toggle_objective_clip(var_0, var_1, var_2) {
  toggle_tall_objective_barriers(var_1);
  var_3 = getEntArray("objective_clip_prop", "targetname");

  foreach(var_5 in var_3) {
    if(_func_0107(var_0) && isDefined(var_0[0]._id_0481) && scripts\engine\utility::is_equal(var_5.target, var_0[0]._id_0481) || scripts\engine\utility::is_equal(var_2, 1)) {
      if(var_1) {
        if(!scripts\engine\utility::is_equal(var_5._id_039B, "no_carve")) {
          var_5 _meth_80B5();
        }

        var_5 show();
        continue;
      }

      if(!scripts\engine\utility::is_equal(var_5._id_039B, "no_carve")) {
        var_5 _meth_8093();
      }

      var_5 hide();
    }
  }

  if(should_spawn_vlo_barriers()) {
    toggle_vlo_barriers(1);
  } else if(istrue(level.vlo_objective_barriers_active)) {
    toggle_vlo_barriers(0);
  }

  if(isDefined(var_0)) {
    foreach(var_8 in var_0) {
      if(var_1) {
        var_9 = scripts\engine\utility::getStructArray(var_8._id_0481, "script_noteworthy");
        var_10 = [];

        if(isDefined(var_8._id_3BE8["blocker"])) {
          var_10 = var_8._id_3BE8["blocker"];
        }

        self._id_0DE8 = [];
        var_11 = scripts\engine\utility::array_combine(var_9, var_8._id_3BE8["blocker"]);

        foreach(var_13 in var_11) {
          if(!scripts\engine\utility::is_equal(var_13._id_3BE4, "blocker")) {
            continue;
          }
          var_14 = spawn("script_model", var_13.origin);
          var_14.angles = var_13.angles;

          switch (var_13._id_0481) {
            case "objective_barrier":
              var_14 setModel("vfx_zm_obj_holdout_barrier_mod_bottom_center_56x48");
              var_15 = scripts\engine\utility::getfx("objective_barrier");
              var_14.barrier_fx = playFXOnTag(var_15, var_14, "tag_origin");
              break;
            case "objective_barrier_rune":
              var_14 setModel("s4_zm_rune_decal_inviktor_barrier");
              break;
            default:
              var_14 setModel(var_13._id_0481);
              break;
          }

          if(scripts\engine\utility::is_equal(var_13._id_039B, "no_collision")) {
            var_14 notsolid();
          } else {
            var_14 solid();
          }

          var_14 playLoopSound("zmb_kortifex_wall_lp");
          self._id_0DE8 = scripts\engine\utility::_id_1B8D(self._id_0DE8, var_14);
        }

        if(isDefined(var_8._id_3BE8["hide_map_props"])) {
          foreach(var_18 in var_8._id_3BE8["hide_map_props"]) {
            var_19 = getEntArray(var_18._id_039B, "script_noteworthy");

            foreach(var_21 in var_19) {
              var_22 = 1;

              if(isDefined(var_8._id_3BE8["hide_map_props"][0]._id_3BE8["exclude_hide_map_props"])) {
                foreach(var_24 in var_8._id_3BE8["hide_map_props"][0]._id_3BE8["exclude_hide_map_props"]) {
                  if(isDefined(var_24._id_039B) && var_21._id_0481 == var_24._id_039B) {
                    var_22 = 0;
                  }
                }
              }

              if(!scripts\engine\utility::is_equal(var_22, 0)) {
                var_21 hide();
              }
            }
          }
        }

        continue;
      }

      if(!var_1 && isDefined(self._id_0DE8)) {
        if(isDefined(self._id_0DE8)) {
          foreach(var_29 in self._id_0DE8) {
            if(isDefined(var_29.barrier_fx)) {
              stopFXOnTag(scripts\engine\utility::getfx("objective_barrier_fx"), var_29, "tag_origin");
            }

            var_29 stoploopsound("zmb_kortifex_wall_lp");
            var_29 delete();
          }

          self._id_0DE8 = [];
        }

        if(isDefined(var_8._id_3BE8["hide_map_props"])) {
          foreach(var_18 in var_8._id_3BE8["hide_map_props"]) {
            var_19 = getEntArray(var_18._id_039B, "script_noteworthy");

            foreach(var_21 in var_19) {
              var_21 show();
            }
          }
        }
      }
    }
  }
}

should_spawn_vlo_barriers() {
  if(!isDefined(level._id_3BE9)) {
    return 0;
  }

  var_0 = level._id_3BE9._id_0F51;

  if(isDefined(var_0) && !scripts\engine\utility::_id_5C00("vlo_open") && (scripts\engine\utility::is_equal(var_0._id_0481, "objective_basement_north_orb_follow") || scripts\engine\utility::is_equal(var_0._id_0481, "objective_basement_south_orb_follow") || scripts\engine\utility::is_equal(var_0._id_0481, "objective_domination_basement_indoor") || scripts\engine\utility::is_equal(var_0._id_0481, "objective_domination_red_star_alley") || scripts\engine\utility::is_equal(var_0._id_0481, "objective_domination_basement_outdoor"))) {
    return 1;
  }

  return 0;
}

get_vlo_barrier_array() {
  var_0 = scripts\engine\utility::getStructArray("vlo_objective_barrier", "targetname");
  var_1 = scripts\engine\utility::getStructArray("vlo_objective_barrier_rune", "targetname");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  return var_2;
}

toggle_vlo_barriers(var_0) {
  level.a_vlo_blockers = scripts\cp\utility::_id_459B(level.a_vlo_blockers, []);
  var_1 = get_vlo_barrier_array();

  if(var_0) {
    level.vlo_objective_barriers_active = 1;

    foreach(var_3 in var_1) {
      var_4 = spawn("script_model", var_3.origin);
      var_4.angles = var_3.angles;

      switch (var_3._id_0481) {
        case "vlo_objective_barrier":
          var_4 setModel("vfx_zm_obj_holdout_barrier_mod_bottom_center_56x48");
          var_5 = scripts\engine\utility::getfx("objective_barrier");
          var_4.barrier_fx = playFXOnTag(var_5, var_4, "tag_origin");
          break;
        case "vlo_objective_barrier_rune":
          var_4 setModel("s4_zm_rune_decal_inviktor_barrier");
          break;
        default:
          var_4 setModel(var_3._id_0481);
          break;
      }

      var_4 solid();
      var_4 playLoopSound("zmb_kortifex_wall_lp");
      self.a_vlo_blockers = scripts\engine\utility::_id_1B8D(self.a_vlo_blockers, var_4);
    }
  } else {
    level.vlo_objective_barriers_active = 0;

    if(isDefined(self.a_vlo_blockers)) {
      foreach(var_8 in self.a_vlo_blockers) {
        if(isDefined(var_8.barrier_fx)) {
          stopFXOnTag(scripts\engine\utility::getfx("objective_barrier_fx"), var_8, "tag_origin");
        }

        var_8 stoploopsound("zmb_kortifex_wall_lp");
        var_8 delete();
      }

      self.a_vlo_blockers = [];
    }
  }
}

toggle_tall_objective_barriers(var_0) {
  var_1 = level._id_3BE9._id_0F51;
  level.a_tall_objective_barrier_instances = scripts\cp\utility::_id_459B(level.a_tall_objective_barrier_instances, []);

  if(istrue(var_0)) {
    if(!isDefined(var_1)) {
      return;
    }
    if(!isDefined(var_1._id_96CF)) {
      return;
    }
    if(!isDefined(level.a_tall_objective_barrier_instances[var_1._id_96CF._id_0481])) {
      return;
    }
    var_2 = getEntArray(var_1._id_96CF._id_0481, "target");

    foreach(var_4 in level.a_tall_objective_barrier_instances[var_1._id_96CF._id_0481]) {
      if(scripts\engine\utility::is_equal(var_4, var_1._id_0481)) {
        foreach(var_6 in var_2) {
          var_6 _meth_8093();
          var_6 show();
          var_6 solid();
        }
      }
    }
  } else
    disable_all_tall_objective_barriers();
}

disable_all_tall_objective_barriers() {
  var_0 = getEntArray("objective_barrier_tall_clip", "targetname");

  foreach(var_2 in var_0) {
    var_2 _meth_8093();
    var_2 hide();
  }
}

register_tall_objective_barrier_instances() {
  level.a_tall_objective_barrier_instances["objectives_location_oasis_ruins_east"] = ["objective_oasis_ruins_east_exterior_holdout", "objective_oasis_ruins_east_exterior_soul_capture", "objective_domination_ruin_east_outdoor", "objective_domination_ruin_east_south", "objective_oasis_ruins_east_building_assault"];
  level.a_tall_objective_barrier_instances["objectives_location_oasis_train"] = ["objective_oasis_train_east_soul_capture", "objective_oasis_train_west_soul_capture"];
  level.a_tall_objective_barrier_instances["objectives_location_dark_aether"] = ["objective_dark_aether_east_holdout", "objective_dark_aether_west_holdout"];
}