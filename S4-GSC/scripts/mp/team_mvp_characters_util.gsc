/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\team_mvp_characters_util.gsc
***************************************************/

create_client_character_camera(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3.angles = (0, var_1[1], 0);
  var_3 setModel("tag_player");

  if(istrue(var_2)) {
    var_4 = spawn("script_model", var_3.origin);
    var_4 setModel("tag_player");
    var_4 linkto(var_3, "tag_player", (0, 0, 0), (0, 90, 0));
    var_3._id_1792 = var_4;
  }

  return var_3;
}

attach_player_to_camera_view(var_0) {
  var_1 = self;

  if(isDefined(var_0._id_1792)) {
    var_0 = var_0._id_1792;
  }

  var_1 _meth_8060();
  var_1 cameralinkto(var_0, "tag_player", 1, 1);
}

run_delta_motion_on_client_character(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1);
  var_3 setModel("tag_origin");
  var_3.angles = var_2;
  var_3 _meth_82CC(var_0, "clientCharacterAnim", undefined, undefined, 1);
  self unlink();
  self linkto(var_3, "tag_origin");
  return var_3;
}

debugme() {
  while(isDefined(self)) {
    waitframe();
  }
}

_id_C9B1(var_0, var_1, var_2, var_3) {
  var_0 notify("run_animation_on_camera");
  var_0 endon("run_animation_on_camera");
  var_0 _meth_82CA();
  var_0.origin = var_2;

  if(isDefined(var_3)) {
    var_0.angles = var_3;
  } else {
    var_0.angles = (0, 0, 0);
  }

  var_0 _meth_82CC(var_1, "clientCharacterAnim");
}

spawn_props_and_animate(var_0, var_1, var_2) {
  var_3 = [];

  if(var_0[5] != "none") {
    var_4 = strtok(var_0[5], ",");
    var_5 = strtok(var_0[6], ",");

    foreach(var_9, var_7 in var_4) {
      var_8 = spawn_prop_and_animate_internal(var_0, var_7, var_5[var_9], var_1, var_2);
      var_3[var_3.size] = var_8;
    }
  }

  return var_3;
}

spawn_prop_and_animate_internal(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0[0];
  var_6 = spawn("script_model", var_3);
  var_6 setModel(var_1);
  var_6.angles = var_4;
  var_6 _meth_82CC(var_2, "client_character_prop_anim");
  return var_6;
}

_animation_data(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_0 == 0) {
    var_3 = 3;
  } else if(var_0 == 2) {
    var_3 = 5;
  }

  var_4 = [];
  var_4["type"] = var_0;
  var_4["ref"] = var_1;
  var_4["animRef"] = var_2;
  var_4["cutoffTime"] = var_3;
  return var_4;
}

get_animation_data() {
  return scripts\mp\team_mvp_characters_animation_data::get_animation_data_internal();
}

_id_C1C9() {
  var_0 = get_animation_data();

  foreach(var_3, var_2 in var_0) {
    if(isDefined(var_2)) {
      _id_C1C8(var_2["ref"], var_2["animRef"], var_2["cutoffTime"]);
    }
  }
}

_id_C1C8(var_0, var_1, var_2) {
  if(!isDefined(level._id_10E54)) {
    level._id_10E54 = [];
  }

  if(isDefined(var_2)) {
    level._id_10E54[var_0] = min(var_2, _func_0079(var_1));
  } else {
    level._id_10E54[var_0] = _func_0079(var_1);
  }
}

_id_6354(var_0) {
  if(!isDefined(level._id_10E54[var_0])) {
    return 5;
  }

  return level._id_10E54[var_0];
}

register_animation_camera_data() {
  var_0 = get_animation_data();

  foreach(var_3, var_2 in var_0) {
    if(isDefined(var_2)) {
      register_anim_camera_data(var_2["ref"], var_2["animRef"]);
    }
  }
}

register_anim_camera_data(var_0, var_1) {
  if(!isDefined(level.winner_circle_anim_camera_data)) {
    level.winner_circle_anim_camera_data = [];
  }

  var_2 = [];

  if(isDefined(var_1)) {
    var_3 = _func_00BA(var_1, undefined, 1);

    if(isDefined(var_3)) {
      foreach(var_8, var_5 in var_3) {
        var_6 = var_5["name"];

        if(scripts\engine\utility::string_starts_with(var_6, "dof_") && !isDefined(var_2["fstop"])) {
          var_7 = strtok(var_6, "_");

          if(isDefined(var_7[1]) && scripts\engine\utility::_id_86D6(var_7[1])) {
            var_2["fstop"] = float(var_7[1]);
          }

          if(isDefined(var_7[2]) && scripts\engine\utility::_id_86D6(var_7[2])) {
            var_2["fdist"] = float(var_7[2]);
          }

          continue;
        }

        if(scripts\engine\utility::string_starts_with(var_6, "change_fov,") && !isDefined(var_2["fov"])) {
          var_7 = strtok(var_6, ",");

          if(isDefined(var_7[1]) && scripts\engine\utility::_id_86D6(var_7[1])) {
            var_2["fov"] = int(var_7[1]);
          }

          continue;
        }

        if(scripts\engine\utility::string_starts_with(var_6, "change_fov_absolute,") && !isDefined(var_2["fov"])) {
          var_7 = strtok(var_6, ",");

          if(isDefined(var_7[1]) && scripts\engine\utility::_id_86D6(var_7[1])) {
            var_2["fov"] = int(var_7[1]);
          }
        }
      }
    }
  }

  level.winner_circle_anim_camera_data[var_0] = var_2;
}

get_camera_data_from_ref(var_0) {
  return level.winner_circle_anim_camera_data[var_0];
}

file_print_generate_animation_data_function() {
  var_0 = "\\share\\raw\\scripts\\mp\\team_mvp_characters_animation_data.gsc";
  scripts\engine\utility::_id_5A33();
  scripts\engine\utility::_id_5A31("//AUTOGENERATED. Do not modify manually!");
  scripts\engine\utility::_id_5A31("//Run the frontend (or a map) with '+set scr_pmf_generate_anim_data_script 1' to generate this file.");
  scripts\engine\utility::_id_5A31(" ");
  scripts\engine\utility::_id_5A31("#include scripts\\mp\\team_mvp_characters_util;");
  scripts\engine\utility::_id_5A31("#inline scripts\\common\\inline\\winner_circle;");
  scripts\engine\utility::_id_5A31("#using_animtree( \"client_character\" );");
  scripts\engine\utility::_id_5A31(" ");
  scripts\engine\utility::_id_5A31("get_animation_data_internal()");
  scripts\engine\utility::_id_5A31("{");
  scripts\engine\utility::_id_5A31("\treturn");
  scripts\engine\utility::_id_5A31("\t[");
  scripts\engine\utility::_id_5A31("\t\t//Fatality Data");
  print_data_from_csv_table("postMatchFlowAnimations.csv", "CONST_ANIM_TYPE_FATALITY", 0, 2);
  scripts\engine\utility::_id_5A31("");
  scripts\engine\utility::_id_5A31("\t\t//POM Data");
  print_data_from_csv_table("postMatchFlowAnimationsIntros.csv", "CONST_ANIM_TYPE_POM", 0, 2);
  scripts\engine\utility::_id_5A31("");
  scripts\engine\utility::_id_5A31("\t\t//Fatality Thumbnail Info");
  print_data_from_csv_table("postMatchFlowAnimations.csv", "CONST_ANIM_TYPE_FATALITY_THUMBNAIL", 12, 12);
  scripts\engine\utility::_id_5A31("");
  scripts\engine\utility::_id_5A31("\t\t//POM Thumbnail Info");
  print_data_from_csv_table("postMatchFlowAnimationsIntros.csv", "CONST_ANIM_TYPE_POM_THUMBNAIL", 12, 12);
  scripts\engine\utility::_id_5A31("");
  scripts\engine\utility::_id_5A31("\t\t//Execution Data");
  print_data_from_csv_table("mp_cp/executiontable.csv", "CONST_ANIM_TYPE_EXECUTION", 19, 19);
  scripts\engine\utility::_id_5A31("");
  scripts\engine\utility::_id_5A31("\t\t//Execution Thumbnail Info");
  print_data_from_csv_table("mp_cp/executiontable.csv", "CONST_ANIM_TYPE_EXECUTION_THUMBNAIL", 25, 25);
  scripts\engine\utility::_id_5A31("");
  scripts\engine\utility::_id_5A31("\t\tundefined // end of array");
  scripts\engine\utility::_id_5A31("\t];");
  scripts\engine\utility::_id_5A31("}");
  var_1 = "raw";
  var_2 = "mp";
  scripts\engine\utility::_id_5A32(var_0, 1);
}

print_data_from_csv_table(var_0, var_1, var_2, var_3) {
  var_4 = tablelookupgetnumrows(var_0);
  var_5 = [];

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_7 = tablelookupbyrow(var_0, var_6, var_2);
    var_8 = tablelookupbyrow(var_0, var_6, var_3);
    var_9 = var_7 == "" || var_7 == "none" || var_8 == "" || var_8 == "none";
    var_10 = isDefined(var_5[var_7]);
    var_5[var_7] = 1;

    if(var_9) {
      scripts\engine\utility::_id_5A31("\t\tundefined, // no data for row " + var_6);
      continue;
    }

    if(var_10) {
      scripts\engine\utility::_id_5A31("\t\tundefined, // duplicate ref " + var_7 + " on row " + var_6);
      continue;
    }

    scripts\engine\utility::_id_5A31("\t\t_animation_data( " + var_1 + ", \"" + var_7 + "\", %" + var_8 + " ),");
  }
}