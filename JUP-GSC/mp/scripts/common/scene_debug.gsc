/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\scene_debug.gsc
***********************************************/

#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\scene_internal;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\utility;
#namespace scene;

function function_6cd499378aadcad8() {
  setdvarifuninitialized(@ "hash_559926a6436db818", "<dev string:x1c>");
  setdvarifuninitialized(@ "hash_1aa832f211c5245e", 0);
  setdvarifuninitialized(@ "scr_debug_scene", 0);
  setdvarifuninitialized(@ "hash_143b0dff4afbd1d3", 0);
  setdvarifuninitialized(@ "hash_71fb5222b333d146", "<dev string:x1c>");
  setdvarifuninitialized(@ "hash_54fd90073299424e", 0);
  setdvarifuninitialized(@ "hash_f98fc73c88850645", 0);
  setdvarifuninitialized(@ "hash_d0761d5c3f9e3bf", 0);
  setdvarifuninitialized(@ "hash_373ad6363da1c230", (0, 0, 0));
  setdvarifuninitialized(@ "hash_eab41865eb0e96ea", (0, 0, 0));
  setdvarifuninitialized(@ "hash_7dda2ca8e979b1b2", 0);
  setdvarifuninitialized(@ "hash_b279d32f047f16db", 0);
  level thread debug_scenes();
}

function private function_475cdb01202582a1() {
  if(!getdvarint(@ "hash_7dda2ca8e979b1b2", 0)) {
    return;
  }

  sceneroot = self;
  assert(isstruct(sceneroot.scenedata));

  if(isDefined(level.scene.debuglist)) {
    level.scene.debuglist.debuglistlast = sceneroot.scenedata;
  }

  sceneroot.scenedata.debuglistnext = level.scene.debuglist;
  sceneroot.scenedata.debuglistlast = undefined;
  level.scene.debuglist = sceneroot.scenedata;
}

function private function_86051e11e7b7a98e() {
  if(!getdvarint(@ "hash_7dda2ca8e979b1b2", 0)) {
    return;
  }

  sceneroot = self;
  assert(isstruct(sceneroot.scenedata));

  if(isDefined(sceneroot.scenedata.debuglistlast)) {
    sceneroot.scenedata.debuglistlast.debuglistnext = sceneroot.scenedata.debuglistnext;
  }

  if(is_equal(level.scene.debuglist, sceneroot.scenedata)) {
    level.scene.debuglist = sceneroot.scenedata.debuglistnext;
  }

  sceneroot.scenedata.debuglistlast = undefined;
  sceneroot.scenedata.debuglistnext = undefined;
}

function private debug_scenes() {
  while(!isDefined(level.player) || !isDefined(level.scene)) {
    waitframe();
  }

  wait 0.5;
  level.scene.debug_player = level.player;
  level.scene.debug_player thread function_5759a29120b54c79("<dev string:x20>");
  level.scene.debug_player thread function_5759a29120b54c79("<dev string:x2b>");
  level.scene.debug_player thread function_5759a29120b54c79("<dev string:x38>");
  level.scene.debug_player thread function_5759a29120b54c79("<dev string:x43>");
  function_35eda8020e32f5c0();
  function_1191a68610545006();
  function_6e7290c8ee4f558b("<dev string:x50>");
  function_b23a59dfb4ca49a1("<dev string:x61>", "<dev string:x74>", &function_259e5f65a65e7a4a, 0, 1);
  function_a9a864379a098ad6("<dev string:x87>", "<dev string:x95>", &scene_menu, 0, 2);
  function_fe953f000498048f();
  level thread function_7c896b815539ac80();
}

function private function_1191a68610545006() {
  var_82701a2a9f269ecf = [];

  foreach(s_scene in level.var_a0b4eb1703be349a) {
    if(function_bb946c981c3bc3e9(s_scene.script_scenescriptbundle) && !istrue(s_scene.var_cb890cd9a86235d2)) {
      if(isDefined(var_82701a2a9f269ecf[s_scene.script_scenescriptbundle])) {
        var_82701a2a9f269ecf[s_scene.script_scenescriptbundle]++;
      } else {
        var_82701a2a9f269ecf[s_scene.script_scenescriptbundle] = 1;
      }

      s_scene.var_39852edf15442735 = var_82701a2a9f269ecf[s_scene.script_scenescriptbundle];
    }
  }
}

function private function_bb946c981c3bc3e9(str_scene_name) {
  n_count = 0;

  foreach(s_scene in level.var_a0b4eb1703be349a) {
    if(is_equal(s_scene.script_scenescriptbundle, str_scene_name)) {
      n_count++;
    }
  }

  if(n_count > 1) {
    return 1;
  }

  return 0;
}

function private function_7c896b815539ac80() {
  while(true) {
    waitframe();

    if(!getdvarint(@ "scr_debug_scene", 0) && !getdvarint(@ "hash_7dda2ca8e979b1b2", 0)) {
      continue;
    }

    function_b0f35d29939ca41d();
  }
}

function private function_b0f35d29939ca41d() {
  countscene = 0;
  countobject = 0;
  countshot = 0;
  countbundle = 0;
  walk = level.scene.debuglist;

  if(isDefined(level.globalbundles)) {
    countbundle = level.globalbundles.size;
  }

  roots = [];

  while(isDefined(walk)) {
    countscene++;

    if(getdvarint(@ "hash_7dda2ca8e979b1b2", 0)) {
      roots[roots.size] = spawnStruct();
      roots[roots.size - 1].sceneroot = walk.sceneroot;
    }

    scenescriptbundle = walk.sceneroot scene_scriptbundle();
    sceneshots = scenescriptbundle function_d1338e27a26ecaeb();
    sceneobjects = scenescriptbundle function_291cd2f1089d3a94();

    if(getdvarint(@ "hash_7dda2ca8e979b1b2", 0)) {
      roots[roots.size - 1].sceneshots = sceneshots;
      roots[roots.size - 1].sceneobjects = sceneobjects;
    }

    countshot += sceneshots;
    countobject += sceneobjects;
    walk = walk.debuglistnext;
  }

  if(getdvarint(@ "hash_7dda2ca8e979b1b2", 0)) {
    roots = array_sort_with_func(roots, &function_a726872ed3f8991c);

    foreach(root in roots) {
      state = root.sceneroot get_state();
      strorigin = "<dev string:xa3>" + int(root.sceneroot.origin[0]) + "<dev string:xa9>" + int(root.sceneroot.origin[1]) + "<dev string:xa9>" + int(root.sceneroot.origin[2]) + "<dev string:xaf>";
      strstate = isDefined(state) ? state : "<dev string:xb5>";
      print(root.sceneroot.script_scenescriptbundle + "<dev string:xc6>" + strstate + "<dev string:xce>" + strorigin + "<dev string:xd3>" + root.sceneshots + "<dev string:xde>" + root.sceneobjects);
    }
  }

  setDvar(@ "hash_7dda2ca8e979b1b2", 0);
  printtoscreen2d(50, 60, "<dev string:xeb>" + countscene + "<dev string:xf7>" + countshot + "<dev string:x103>" + countobject + "<dev string:x111>" + countbundle, (1, 1, 1), 1);
}

function private function_a726872ed3f8991c(a, b) {
  return stricmp(a.sceneroot.script_scenescriptbundle, b.sceneroot.script_scenescriptbundle) < 0;
}

function private function_35eda8020e32f5c0() {
  var_20fee085e968ff25 = getscriptbundlenames("<dev string:x11f>");

  foreach(var_3032d30b52922730 in var_20fee085e968ff25) {
    s_scenedef = getscriptbundle(var_3032d30b52922730);
    str_scene_name = strtok(getxhashsourcename(var_3032d30b52922730), "<dev string:x134>");
    str_scene_name = str_scene_name[1];

    if(!isDefined(str_scene_name)) {
      continue;
    }

    if(!array_contains(level.a_scene_names, str_scene_name)) {
      level.a_scene_names = function_6d6af8144a5131f1(level.a_scene_names, str_scene_name);
      s_scene = spawnStruct();
      s_scene.script_scenescriptbundle = str_scene_name;
      s_scene.origin = (0, 0, 0);
      s_scene.angles = (0, 0, 0);
      s_scene.var_cb890cd9a86235d2 = 1;
      level.var_a0b4eb1703be349a = function_6d6af8144a5131f1(level.var_a0b4eb1703be349a, s_scene);
    }
  }
}

function private function_259e5f65a65e7a4a(params) {
  if(isDefined(params[0]) && params[0] == "<dev string:x139>" || !flag("<dev string:x143>")) {
    flag_set("<dev string:x143>");
    level thread function_1a6063b0e34ec373();
    return;
  }

  flag_clear("<dev string:x143>");
}

function private function_1a6063b0e34ec373(params) {
  level notify("<dev string:x15d>");
  level endon("<dev string:x15d>");
  var_a16d4962e4996f7 = (0.8, 0.8, 0);
  var_d67003533dc77764 = (0.8, 0, 0.8);

  while(flag("<dev string:x143>")) {
    foreach(s_scene in level.var_a0b4eb1703be349a) {
      var_97e88c04cc05cbbd = s_scene get_state();
      a_ents = s_scene get_entities();
      str_scene_name = isDefined(s_scene.var_39852edf15442735) ? s_scene.script_scenescriptbundle + "<dev string:x178>" + s_scene.var_39852edf15442735 : s_scene.script_scenescriptbundle;
      print3d(s_scene.origin, "<dev string:x17d>" + str_scene_name, (0.8, 0, 0.8), 0.8, 0.3);
      print3d(s_scene.origin + (0, 0, -5), "<dev string:x188>" + var_97e88c04cc05cbbd, (0.8, 0, 0.8), 0.8, 0.3);

      foreach(ent in a_ents) {
        if(!isDefined(ent)) {
          continue;
        }

        sceneobjectdata = ent.sceneobjectdata;
        str_anim = undefined;

        if(isDefined(sceneobjectdata)) {
          str_anim = sceneobjectdata.activeanimation;
        }

        if(isDefined(ent.var_7c6c008ca46286b0)) {
          str_name = ent.var_7c6c008ca46286b0.animname;
        } else {
          str_name = ent.animname;
        }

        if(isDefined(str_anim) && isDefined(str_name)) {
          str_type = ent function_e61fb9c68ca391c0();
          var_fef94c1af0da7262 = "<dev string:x1c>";
          str_extra_info = "<dev string:x1c>";
          var_b8016ad28a74c8ba = default_to(getanimlength(str_anim), 0);

          if(isPlayer(ent)) {
            player_rig = default_to(level.player_rig, ent.var_7c6c008ca46286b0);

            if(isDefined(player_rig)) {
              var_8f5cd7d0a9d1ed15 = default_to(player_rig getanimtime(str_anim), 0);
              var_a7ffb7e10e570a37 = var_8f5cd7d0a9d1ed15 * var_b8016ad28a74c8ba;
            } else {
              continue;
            }
          } else if(ent scripts\common\vehicle::isvehicle() || isai(ent) || utility::issp()) {
            if(isagent(ent) && isDefined(ent.var_b65a7211c663d3ed)) {
              var_8f5cd7d0a9d1ed15 = ent aigetanimtime("<dev string:x193>", ent.var_b65a7211c663d3ed);
            } else {
              var_8f5cd7d0a9d1ed15 = default_to(ent getanimtime(str_anim), 0);
            }

            var_a7ffb7e10e570a37 = var_8f5cd7d0a9d1ed15 * var_b8016ad28a74c8ba;
          } else {
            var_8f5cd7d0a9d1ed15 = 0;
            var_a7ffb7e10e570a37 = 0;
          }

          var_335e78b3a74cad37 = var_b8016ad28a74c8ba * 30;
          var_2e13d0ea5f29252f = int(var_8f5cd7d0a9d1ed15 * var_335e78b3a74cad37);
          str_extra_info = "<dev string:x1a3>" + var_a7ffb7e10e570a37 + "<dev string:x1b2>" + var_b8016ad28a74c8ba + "<dev string:x1b7>" + var_2e13d0ea5f29252f + "<dev string:x1b2>" + var_335e78b3a74cad37 + "<dev string:x1cb>";
          var_3fbeadb96e8ca187 = getanimname(str_anim);

          if(isxhashasset(var_3fbeadb96e8ca187)) {
            var_3fbeadb96e8ca187 = getxhashsourcename(var_3fbeadb96e8ca187);
          }

          if(animislooping(str_anim)) {
            var_fef94c1af0da7262 = "<dev string:x1d0>" + var_3fbeadb96e8ca187;
          } else {
            var_fef94c1af0da7262 = "<dev string:x1df>" + var_3fbeadb96e8ca187;
          }

          var_b6e6ba17ec8331f4 = ent.origin - (0, 0, 15);
          print3d(var_b6e6ba17ec8331f4, "<dev string:x1e9>" + ent getentitynumber() + str_type + "<dev string:x1f6>" + (isDefined(str_name) ? str_name : "<dev string:x202>" + ent getentitynumber()), (0.8, 0.8, 0), 0.8, 0.3);
          print3d(var_b6e6ba17ec8331f4 - (0, 0, 5), var_fef94c1af0da7262, (0.8, 0.8, 0), 0.8, 0.3);
          print3d(var_b6e6ba17ec8331f4 - (0, 0, 11), str_extra_info, (0.8, 0.8, 0), 0.8, 0.3);
          ent render_tag("<dev string:x20d>");
          ent render_tag("<dev string:x221>");
          ent render_tag("<dev string:x234>");
          ent render_tag("<dev string:x24a>");
          ent render_tag("<dev string:x258>");
          ent render_tag("<dev string:x266>");
          ent render_tag("<dev string:x273>");
          ent render_tag("<dev string:x27e>", "<dev string:x28c>");
        }
      }
    }

    waitframe();
  }
}

function private render_tag(str_tag, str_label, b_recorder_only) {
  str_label = default_to(str_label, str_tag);
  v_centroid = self getcentroid();
  v_tag_org = self gettagorigin(str_tag, 1);

  if(isDefined(v_tag_org)) {
    v_tag_ang = self gettagangles(str_tag);
    anim_origin_render(v_tag_org, v_tag_ang, 2, str_label);
    line(v_centroid, v_tag_org, (0.3, 0.3, 0.3), 1.25, 1);
  }
}

function private anim_origin_render(org, angles, line_length, str_label) {
  if(isDefined(org) && isDefined(angles)) {
    line_length = default_to(line_length, 6);
    originendpoint = org + anglesToForward(angles) * line_length;
    originrightpoint = org + anglestoright(angles) * -1 * line_length;
    originuppoint = org + anglestoup(angles) * line_length;
    line(org, originendpoint, (1, 0, 0));
    line(org, originrightpoint, (0, 1, 0));
    line(org, originuppoint, (0, 0, 1));

    if(isDefined(str_label)) {
      print3d(org, str_label, (1, 0.5, 1), 2.5, 0.05);
    }
  }
}

function private function_e61fb9c68ca391c0() {
  str_text = "<dev string:x1c>";

  if(isactor(self) || isagent(self)) {
    str_text = "<dev string:x294>";
  } else if(isPlayer(self)) {
    str_text = "<dev string:x29c>";
  } else if(isDefined(self.vehiclename)) {
    str_text = "<dev string:x2a8>";
  } else {
    str_text = "<dev string:x2b5>" + self.classname + "<dev string:x2ba>";
  }

  return str_text;
}

function display_scene_menu(var_8e2d937d4bb36011) {
  str_type = "<dev string:x2bf>";
  level notify("<dev string:x2c8>");
  level endon("<dev string:x2c8>");
  waittillframeend();
  names = [];
  b_shot_menu = 0;
  s_scene = undefined;

  if(isstring(var_8e2d937d4bb36011)) {
    s_scene = function_58e23a3be918ec3f(var_8e2d937d4bb36011);
    names = array_combine(names, s_scene function_8a37fe423de2b9db());
    names[names.size] = "<dev string:x1c>";
    names[names.size] = "<dev string:x2de>";
    names[names.size] = "<dev string:x2e6>";
    names[names.size] = "<dev string:x1c>";
    names[names.size] = "<dev string:x2ef>";
    str_title = var_8e2d937d4bb36011 + "<dev string:x2f7>";
    b_shot_menu = 1;
    selected = default_to(level.scene_menu_shot_index, 0);
  } else {
    if(flag("<dev string:x301>")) {
      println("<dev string:x31b>" + str_type + "<dev string:x330>");
    }

    var_4ba13583548f921e = 1;

    foreach(s_scene in level.var_a0b4eb1703be349a) {
      str_scenedef = s_scene.script_scenescriptbundle;
      s_scenedef = getscriptbundle("<dev string:x342>" + str_scenedef);
      var_642a2c2acddcda83 = isDefined(s_scene.var_39852edf15442735) ? str_scenedef + "<dev string:x178>" + s_scene.var_39852edf15442735 : str_scenedef;

      if(flag("<dev string:x301>")) {
        if(s_scene get_state() == "<dev string:x358>") {
          names[names.size] = var_642a2c2acddcda83;
          println("<dev string:x31b>" + str_type + "<dev string:xce>" + var_4ba13583548f921e + "<dev string:x363>" + str_scenedef);
          var_4ba13583548f921e++;
        }

        continue;
      }

      names[names.size] = var_642a2c2acddcda83;
    }

    if(flag("<dev string:x301>")) {
      println("<dev string:x31b>" + str_type + "<dev string:x36d>");
    }

    names = utility::alphabetize(names);

    foreach(str_scene_name in names) {
      str_prefix = getsubstr(str_scene_name, 0, 4);

      if(str_prefix == "<dev string:x37d>") {
        names = array_remove(names, str_scene_name);
        names = array_insert(names, str_scene_name, 0);
      }
    }

    names[names.size] = "<dev string:x1c>";
    names[names.size] = "<dev string:x385>";
    names = array_insert(names, "<dev string:x1c>", 0);
    names = array_insert(names, "<dev string:x38d>", 0);
    str_title = str_type + "<dev string:x3af>";
    selected = default_to(level.scene_menu_index, 0);
  }

  if(selected > names.size - 1) {
    selected = 0;
  }

  up_pressed = 0;
  down_pressed = 0;
  held = 0;
  var_f98bd61d8515551 = gettime();

  while(flag("<dev string:x3b4>")) {
    if(!isDefined(level.scene.debug_player)) {
      level.scene.debug_player = level.players[0];
      waitframe();
      continue;
    }

    if(b_shot_menu) {
      if(isDefined(level.last_scene_state) && isDefined(level.last_scene_state[var_8e2d937d4bb36011])) {
        str_title = var_8e2d937d4bb36011 + "<dev string:x3c9>" + level.last_scene_state[var_8e2d937d4bb36011] + "<dev string:x3cf>";
      }
    }

    scene_list_settext(names, selected, str_title, b_shot_menu, 1);
    currenttime = gettime();
    pagecount = 10;

    if(currenttime < var_f98bd61d8515551) {
      pagecount = 0;
    }

    if(!up_pressed) {
      if(level.scene.debug_player buttonPressed("<dev string:x20>") || level.scene.debug_player buttonPressed("<dev string:x38>")) {
        up_pressed = 1;
        selected--;

        while(!isDefined(names[selected]) || names[selected] == "<dev string:x1c>") {
          selected--;

          if(selected < 0) {
            selected = names.size - 1;
            continue;
          }

          if(selected >= names.size) {
            selected = 0;
          }
        }
      }
    } else if(level.scene.debug_player function_ed160eec4d1b0619("<dev string:x20>") || level.scene.debug_player function_ed160eec4d1b0619("<dev string:x38>")) {
      held = 1;
      selected -= pagecount;
    } else if(!level.scene.debug_player buttonPressed("<dev string:x20>") && !level.scene.debug_player buttonPressed("<dev string:x38>")) {
      held = 0;
      up_pressed = 0;
    }

    if(!down_pressed) {
      if(level.scene.debug_player buttonPressed("<dev string:x2b>") || level.scene.debug_player buttonPressed("<dev string:x43>")) {
        down_pressed = 1;
        selected++;

        while(!isDefined(names[selected]) || names[selected] == "<dev string:x1c>") {
          selected++;

          if(selected < 0) {
            selected = names.size - 1;
            continue;
          }

          if(selected >= names.size) {
            selected = 0;
          }
        }
      }
    } else if(level.scene.debug_player function_ed160eec4d1b0619("<dev string:x2b>") || level.scene.debug_player function_ed160eec4d1b0619("<dev string:x43>")) {
      held = 1;
      selected += pagecount;
    } else if(!level.scene.debug_player buttonPressed("<dev string:x2b>") && !level.scene.debug_player buttonPressed("<dev string:x43>")) {
      held = 0;
      down_pressed = 0;
    }

    if(held) {
      if(selected < 0) {
        selected = 0;
      } else if(selected >= names.size) {
        selected = names.size - 1;
      }
    } else if(selected < 0) {
      selected = names.size - 1;
    } else if(selected >= names.size) {
      selected = 0;
    }

    if(held && pagecount == 10) {
      var_f98bd61d8515551 = gettime() + 500;
    }

    if(names[selected] != "<dev string:x38d>" && names[selected] != "<dev string:x385>" && !b_shot_menu) {
      s_scene = function_58e23a3be918ec3f(names[selected]);
    }

    if(level.scene.debug_player buttonPressed("<dev string:x3d4>") || level.scene.debug_player buttonPressed("<dev string:x3e0>")) {
      if(b_shot_menu) {
        while(level.scene.debug_player buttonPressed("<dev string:x3d4>") || level.scene.debug_player buttonPressed("<dev string:x3e0>")) {
          waitframe();
        }

        level.scene_menu_shot_index = selected;
        level thread display_scene_menu();
      } else {
        level.scene_menu_index = selected;
        var_6a0645b23db85dcf = "<dev string:x3ea>" + getxhashhexname(@ "hash_559926a6436db818") + "<dev string:x3f2>";
        adddebugcommand(var_6a0645b23db85dcf);
        return;
      }
    }

    if(names[selected] != "<dev string:x385>" && names[selected] != "<dev string:x38d>" && !b_shot_menu && isDefined(s_scene)) {
      if(level.scene.debug_player buttonPressed("<dev string:x401>") || level.scene.debug_player buttonPressed("<dev string:x40f>")) {
        level.scene.debug_player setOrigin(s_scene.origin);

        while(level.scene.debug_player buttonPressed("<dev string:x401>") || level.scene.debug_player buttonPressed("<dev string:x40f>")) {
          waitframe();
        }
      } else if(level.scene.debug_player buttonPressed("<dev string:x41d>") || level.scene.debug_player buttonPressed("<dev string:x42a>")) {
        level.scene.debug_player setOrigin(s_scene.origin);

        while(level.scene.debug_player buttonPressed("<dev string:x41d>") || level.scene.debug_player buttonPressed("<dev string:x42a>")) {
          waitframe();
        }
      }
    }

    if(b_shot_menu && (function_90157e16d9b18a9d() || function_6a0b118cb67914b8()) && isDefined(var_8e2d937d4bb36011) && array_contains(s_scene function_8a37fe423de2b9db(), names[selected])) {
      if(function_90157e16d9b18a9d()) {
        a_str_shot_names = s_scene function_8a37fe423de2b9db();
        var_4af252be7b7e9615 = [];
        var_b10f292029388b03 = 0;

        foreach(str_shot_name in a_str_shot_names) {
          if(str_shot_name != names[selected] && !var_b10f292029388b03) {
            continue;
          }

          var_b10f292029388b03 = 1;
          var_4af252be7b7e9615[var_4af252be7b7e9615.size] = str_shot_name;
        }

        s_scene thread play(undefined, var_4af252be7b7e9615);
      } else if(function_6a0b118cb67914b8()) {
        s_scene thread init(undefined, names[selected]);
      }

      while(function_6a0b118cb67914b8() || function_90157e16d9b18a9d()) {
        waitframe();
      }
    } else if(function_e4ca8661daaa7f0e() && isDefined(names[selected])) {
      if(!b_shot_menu && names[selected] == "<dev string:x38d>") {
        if(flag("<dev string:x301>")) {
          flag_clear("<dev string:x301>");
        } else {
          flag_set("<dev string:x301>");
        }

        while(function_e4ca8661daaa7f0e()) {
          waitframe();
        }

        level thread display_scene_menu();
      } else if(!b_shot_menu) {
        if(names[selected] == "<dev string:x385>") {
          var_6a0645b23db85dcf = "<dev string:x3ea>" + getxhashhexname(@ "hash_559926a6436db818") + "<dev string:x3f2>";
          adddebugcommand(var_6a0645b23db85dcf);
          return;
        }
      } else if(b_shot_menu) {
        if(istrue(s_scene.var_cb890cd9a86235d2)) {
          s_scene.origin = getdvarvector(@ "hash_373ad6363da1c230");
          s_scene.angles = getdvarvector(@ "hash_eab41865eb0e96ea");
        }

        if(names[selected] == "<dev string:x2ef>") {
          level.scene_menu_shot_index = selected;

          while(function_e4ca8661daaa7f0e()) {
            waitframe();
          }

          level thread display_scene_menu();
        } else if(names[selected] == "<dev string:x2de>") {
          s_scene thread stop();
        } else if(names[selected] == "<dev string:x2e6>") {
          s_scene thread cleanup(1);
        } else if(names[selected] == "<dev string:x437>") {
          s_scene thread init();
        } else if(names[selected] == "<dev string:x43f>") {
          s_scene thread play();
        } else if(names[selected] != "<dev string:x1c>") {
          s_scene thread play(undefined, names[selected]);
        }
      }

      while(function_e4ca8661daaa7f0e() || function_90157e16d9b18a9d()) {
        waitframe();
      }

      if(!b_shot_menu && names[selected] != "<dev string:x1c>") {
        level.scene_menu_index = selected;
        level thread display_scene_menu(names[selected]);
      }
    }

    waitframe();
  }
}

function private function_58e23a3be918ec3f(var_8e2d937d4bb36011) {
  var_80831c1ace77d57b = strtok(var_8e2d937d4bb36011, "<dev string:x178>");
  var_8e2d937d4bb36011 = var_80831c1ace77d57b[0];
  var_39852edf15442735 = var_80831c1ace77d57b[1];

  if(isDefined(var_39852edf15442735)) {
    var_39852edf15442735 = int(var_39852edf15442735);
  }

  s_scene = level.var_a0b4eb1703be349a[0];

  foreach(s_scene in level.var_a0b4eb1703be349a) {
    if(is_equal(var_8e2d937d4bb36011, s_scene.script_scenescriptbundle) && (!isDefined(var_39852edf15442735) || is_equal(var_39852edf15442735, s_scene.var_39852edf15442735))) {
      break;
    }
  }

  return s_scene;
}

function private scene_menu(params) {
  if(!flag("<dev string:x3b4>")) {
    flag_set("<dev string:x3b4>");
    level.scene.debug_player val::set("<dev string:x447>", "<dev string:x456>", 0);
    level.scene.debug_player val::set("<dev string:x447>", "<dev string:x464>", 0);
    level.scene.debug_player val::set("<dev string:x447>", "<dev string:x46e>", 0);
    level thread display_scene_menu();
    return;
  }

  flag_clear("<dev string:x3b4>");
  level.scene.debug_player val::reset("<dev string:x447>", "<dev string:x456>");
  level.scene.debug_player val::reset("<dev string:x447>", "<dev string:x464>");
  level.scene.debug_player val::reset("<dev string:x447>", "<dev string:x46e>");
  function_b7d145bff0acb42();
}

function private scene_list_settext(strings, n_selected, str_title, b_shot_menu, var_9a294debc8b593a8) {
  if(!flag("<dev string:x477>")) {
    thread _scene_list_settext(strings, n_selected, str_title, b_shot_menu, var_9a294debc8b593a8);
  }
}

function private _scene_list_settext(strings, n_selected, str_title, b_shot_menu, var_9a294debc8b593a8) {
  if(!isDefined(var_9a294debc8b593a8)) {
    var_9a294debc8b593a8 = 1;
  }

  for(i = 0; i < var_9a294debc8b593a8; i++) {
    printtoscreen2d(150, 310, str_title, (1, 1, 1), 2.5);
    str_mode = "<dev string:x48d>";

    switch (str_mode) {
      case #"hash_7038dec66d8275be":
        printtoscreen2d(150, 325, "<dev string:x498>", (1, 1, 1), 2.5);
        break;
      case #"hash_7da50739ef480ecb":
        break;
      case #"hash_8d4787dcb1802e22":
        break;
      case #"hash_d48d5b579a6c7c3":
        break;
    }

    for(i = 0; i < 16; i++) {
      index = i + n_selected - 5;

      if(isDefined(strings[index])) {
        text = strings[index];
      } else {
        text = "<dev string:x1c>";
      }

      str_scene = text;

      if(isDefined(level.last_scene_state) && isDefined(level.last_scene_state[text])) {
        text += "<dev string:x3c9>" + level.last_scene_state[text] + "<dev string:x3cf>";
      }

      if(i == 5) {
        text = "<dev string:x4d5>" + text + "<dev string:x4db>";
        str_color = (0.8, 0.4, 0);
      } else if(str_scene != "<dev string:x1c>") {
        str_color = (0, 1, 0);
      } else {
        str_color = (1, 1, 1);
      }

      printtoscreen2d(136, 400 + i * 30, text, str_color, 2.5);
    }

    if(b_shot_menu && !getdvarint(@ "hash_303a3f39ecf974db", 0)) {
      if(!isDefined(level.scene.var_49da744408f4f28b)) {
        level.scene.var_49da744408f4f28b = newhudelem();
      }

      level.scene.var_49da744408f4f28b.alignx = "<dev string:x4e0>";
      level.scene.var_49da744408f4f28b.x = 50;
      level.scene.var_49da744408f4f28b.y = 250;
      level.scene.var_49da744408f4f28b.fontscale = 1;
      level.scene.var_49da744408f4f28b.color = (1, 1, 1);
      buttonprompttext = "<dev string:x1c>";

      if(level.scene.debug_player usinggamepad()) {
        buttonprompttext = "<dev string:x4e8>";
      } else {
        buttonprompttext = "<dev string:x54e>";
      }

      level.scene.var_49da744408f4f28b setdevtext(buttonprompttext);
    } else {
      function_b7d145bff0acb42();
      printtoscreen2d(150, 410 + 480, "<dev string:x597>", (1, 1, 1), 2.5);
    }

    waitframe();
  }
}

function private function_b7d145bff0acb42() {
  if(isDefined(level.scene.var_49da744408f4f28b)) {
    level.scene.var_49da744408f4f28b destroy();
  }
}

function private function_e4ca8661daaa7f0e() {
  if(level.scene.debug_player buttonPressed("<dev string:x5bc>") || level.scene.debug_player buttonPressed("<dev string:x5c8>") || level.scene.debug_player buttonPressed("<dev string:x5d4>")) {
    return 1;
  }

  return 0;
}

function private function_90157e16d9b18a9d() {
  if(level.scene.debug_player buttonPressed("<dev string:x5dd>") || level.scene.debug_player buttonPressed("<dev string:x5e9>")) {
    return 1;
  }

  return 0;
}

function private function_6a0b118cb67914b8() {
  if(level.scene.debug_player buttonPressed("<dev string:x5ee>") || level.scene.debug_player buttonPressed("<dev string:x5fa>")) {
    return 1;
  }

  return 0;
}

function private function_ed160eec4d1b0619(str_button) {
  if(getdvarint(@ "hash_66d7268f08facc81", 0)) {
    return 0;
  }

  return self._holding_button[str_button];
}

function private function_5759a29120b54c79(str_button) {
  self endon("<dev string:x602>");
  self._holding_button = default_to(self._holding_button, []);
  self._holding_button[str_button] = 0;
  time_started = 0;

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    use_time = 250;

    if(self._holding_button[str_button]) {
      if(!self buttonPressed(str_button)) {
        self._holding_button[str_button] = 0;
      }
    } else if(self buttonPressed(str_button)) {
      if(time_started == 0) {
        time_started = gettime();
      }

      if(gettime() - time_started > use_time) {
        self._holding_button[str_button] = 1;
      }
    } else if(time_started != 0) {
      time_started = 0;
    }

    waitframe();
  }
}

function function_c623b8e6e4b0a90(tag, size, duration, blendtimesec) {
  self endon("<dev string:x610>");
  self notify("<dev string:x627>" + tag);
  self endon("<dev string:x627>" + tag);
  starttime = gettime();

  if(!isDefined(level.var_545cde3d65ac0cc)) {
    level.var_545cde3d65ac0cc = [];
    level.var_545cde3d65ac0cc[level.var_545cde3d65ac0cc.size] = (1, 0, 0);
    level.var_545cde3d65ac0cc[level.var_545cde3d65ac0cc.size] = (0, 1, 0);
    level.var_545cde3d65ac0cc[level.var_545cde3d65ac0cc.size] = (0, 0, 1);
    level.var_545cde3d65ac0cc[level.var_545cde3d65ac0cc.size] = (1, 1, 0);
    level.var_545cde3d65ac0cc[level.var_545cde3d65ac0cc.size] = (0, 1, 1);
    level.var_545cde3d65ac0cc[level.var_545cde3d65ac0cc.size] = (1, 0, 1);
    level.var_efc719d27ab26877 = -1;
  }

  color = (1, 1, 1);
  blendtimems = 0;

  if(!isDefined(blendtimesec)) {
    level.var_efc719d27ab26877 = (level.var_efc719d27ab26877 + 1) % level.var_545cde3d65ac0cc.size;
    color = level.var_545cde3d65ac0cc[level.var_efc719d27ab26877];
  } else {
    blendtimems = blendtimesec * 1000;
  }

  start = gettime();

  while(true) {
    waitframe();
    origin = self.origin;
    angles = self.angles;

    if(blendtimems > 0) {
      color = vectorlerp((0, 0, 0), (1, 1, 1), min(1, float(gettime() - start) / float(blendtimems)));
    }

    if(tag != "<dev string:x1c>") {
      origin = self gettagorigin(tag, 0, 1, 0);
      angles = self gettagangles(tag, 0, 1, 0);
      print3d(origin + (0, 0, 1), tag, (1, 1, 1), 1, 0.15, 1, 1);
    } else if(isPlayer(self)) {
      origin = self getEye();
      angles = self getplayerangles();
    } else {
      print3d(origin + (0, 0, 1), "<dev string:x63c>", (1, 1, 1), 1, 0.15, 1, 1);
    }

    line(origin, origin + anglesToForward(angles) * size, color, 1, 0, duration);
    line(origin, origin + anglestoright(angles) * size, color * 0.75, 1, 0, duration);
    line(origin, origin + anglestoup(angles) * size, (1, 1, 1), 1, 0, duration);
    print3d(origin + (0, 0, 5), "<dev string:x1c>" + self getentitynumber(), (1, 1, 1), 1, 0.25, 1, 1);
    print3d(origin + (0, 0, 10), "<dev string:x1c>" + gettime() - starttime, (1, 1, 1), 1, 0.25, 1, 1);
  }
}

function function_ce4b6d4d859ede39(sceneobjectdata, event, origin, angles) {
  if(!getdvarint(@ "hash_143b0dff4afbd1d3", 0)) {
    return;
  }

  filter = getDvar(@ "hash_71fb5222b333d146", "<dev string:x1c>");

  if(filter != "<dev string:x1c>" && !issubstr(tolower(filter), tolower(sceneobjectdata.sceneobject function_aeb2b46911a5811d())) && !issubstr(tolower(sceneobjectdata.sceneobject function_aeb2b46911a5811d()), tolower(filter)) && !issubstr(tolower(event), tolower(filter))) {
    return;
  }

  level thread function_baa34fb5707b7466(sceneobjectdata, event, origin, angles);
}

function function_baa34fb5707b7466(sceneobjectdata, event, origin, angles) {
  assert(isDefined(sceneobjectdata));
  assert(isDefined(event));
  assert(isDefined(origin));
  assert(isDefined(angles));
  level notify("<dev string:x64d>");
  level endon("<dev string:x64d>");

  if(!isDefined(level.var_fb96551e5ea54b9)) {
    level.var_fb96551e5ea54b9 = [];
  }

  bucketdistsq = squared(5);
  duration = getdvarint(@ "hash_143b0dff4afbd1d3", 0);
  scale = 0.25;
  step = 4;
  eventlistadd = undefined;

  foreach(eventlist in level.var_fb96551e5ea54b9) {
    if(distancesquared(eventlist.origin, origin) < bucketdistsq) {
      eventlistadd = eventlist;
      break;
    }
  }

  if(!isDefined(eventlistadd)) {
    eventlistadd = spawnStruct();
    eventlistadd.origin = origin;
    eventlistadd.angles = angles;
    eventlistadd.events = [];
    eventlistadd.offset = (0, 0, 0);
    level.var_fb96551e5ea54b9[level.var_fb96551e5ea54b9.size] = eventlistadd;
  }

  eventadd = spawnStruct();
  eventadd.objectname = sceneobjectdata.sceneobject.variant_object.name;
  eventadd.activeanimation = sceneobjectdata.activeanimation;
  eventadd.scenename = sceneobjectdata.sceneroot.script_scenescriptbundle;
  eventadd.event = event;
  eventadd.origin = origin;
  eventadd.angles = angles;
  eventadd.time = gettime();
  eventlistadd.events[eventlistadd.events.size] = eventadd;
  waitframe();

  foreach(eventlist in level.var_fb96551e5ea54b9) {
    drawnorigin = undefined;
    drawnangles = undefined;
    lastscene = undefined;
    lastobject = undefined;
    offset = (0, 0, 0);

    for(i = 0; i < eventlist.events.size; i++) {
      event = eventlist.events[i];

      if(!isDefined(drawnorigin) || drawnorigin != event.origin || drawnangles != event.angles) {
        drawnorigin = event.origin;
        drawnangles = event.angles;
        axis = anglestoaxis(event.angles);
        line(event.origin, event.origin + axis["<dev string:x663>"] * 10, (1, 0, 0), 1, 0, duration);
        line(event.origin, event.origin + axis["<dev string:x66e>"] * 10, (0, 1, 0), 1, 0, duration);
        line(event.origin, event.origin + axis["<dev string:x677>"] * 10, (0, 0, 1), 1, 0, duration);
      }

      if(!isDefined(lastscene) || lastscene != event.scenename) {
        lastscene = event.scenename;
        print3d(eventlist.origin + offset, lastscene, (1, 1, 0), 1, scale, duration);
        offset += (0, 0, step);
      }

      if(!isDefined(lastobject) || lastobject != event.objectname) {
        lastobject = event.objectname;
        offset += (0, 0, step * 0.5);
        print3d(eventlist.origin + offset, lastobject, (0, 1, 1), 1, scale, duration);
        offset += (0, 0, step);
      }

      print3d(eventlist.origin + offset, event.event + "<dev string:x3c9>" + event.time + "<dev string:x3cf>", (1, 1, 1), 1, scale, duration);
      offset += (0, 0, step);
      print3d(eventlist.origin + offset, "<dev string:x1c>" + int(event.origin[0]) + "<dev string:xa9>" + int(event.origin[1]) + "<dev string:xa9>" + int(event.origin[2]), (1, 1, 1), 1, scale, duration);
      offset += (0, 0, step);
      activeanimation = "<dev string:x1c>";
      objectname = "<dev string:x1c>";

      if(isDefined(event.activeanimation)) {
        activeanimation = event.activeanimation;
      }

      if(isDefined(event.objectname)) {
        objectname = event.objectname;
      }

      println("<dev string:x67d>" + event.time + "<dev string:x68e>" + event.event + "<dev string:x694>" + objectname);
    }
  }

  level.var_fb96551e5ea54b9 = undefined;
}

function function_eeff9ce6b23bb906() {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  scenedata = sceneroot.scenedata;

  if(!isDefined(scenedata)) {
    return undefined;
  }

  foreach(sceneobjectindex, var_19a1a40cf0ff83b9 in sceneplay.var_7038c2a13f1f5db8) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

    if(isPlayer(sceneobjectdata.entity)) {
      return sceneobjectdata.entity;
    }
  }
}

function function_d4cfde3fa9af7e5a(shotindex) {
  sceneplay = self;

  if(getdvarint(@ "hash_f98fc73c88850645", 0)) {
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    player = sceneplay function_eeff9ce6b23bb906();

    if(!isDefined(player)) {
      return;
    }

    sceneplay function_6b2bc344ea55f120();
    player.var_43996b501c46de7f[0] = newhudelem();
    player.var_43996b501c46de7f[1] = newhudelem();
    str_scene_name = default_to(sceneroot.script_scenescriptbundle, "<dev string:x1c>");
    str_shot_name = default_to(sceneroot.scenedata.scenescriptbundle.shots[shotindex].variant_object.name, "<dev string:x1c>");
    player.var_43996b501c46de7f[0].alignx = "<dev string:x66e>";
    player.var_43996b501c46de7f[0].aligny = "<dev string:x69b>";
    player.var_43996b501c46de7f[0].vertalign = "<dev string:x69b>";
    player.var_43996b501c46de7f[0].horzalign = "<dev string:x66e>";
    player.var_43996b501c46de7f[0].font = "<dev string:x6a5>";
    player.var_43996b501c46de7f[0].x = -20;
    player.var_43996b501c46de7f[0].y = -90;
    player.var_43996b501c46de7f[0].fontscale = 1;
    player.var_43996b501c46de7f[0].color = (0.6, 0.6, 0.6);
    player.var_43996b501c46de7f[1].alignx = "<dev string:x66e>";
    player.var_43996b501c46de7f[1].aligny = "<dev string:x69b>";
    player.var_43996b501c46de7f[1].vertalign = "<dev string:x69b>";
    player.var_43996b501c46de7f[1].horzalign = "<dev string:x66e>";
    player.var_43996b501c46de7f[1].font = "<dev string:x6a5>";
    player.var_43996b501c46de7f[1].x = -20;
    player.var_43996b501c46de7f[1].y = -70;
    player.var_43996b501c46de7f[1].fontscale = 1;
    player.var_43996b501c46de7f[1].color = (0.6, 0.6, 0.6);
    player.var_43996b501c46de7f[0] setdevtext("<dev string:x17d>" + str_scene_name);

    if(isDefined(sceneroot.var_2f23edb971f368a6)) {
      shottext = "<dev string:x6b3>" + str_shot_name + "<dev string:x6bd>" + sceneroot.var_2f23edb971f368a6;
    } else {
      shottext = "<dev string:x6b3>" + str_shot_name;
    }

    player.var_43996b501c46de7f[1] setdevtext(shottext);
  }
}

function function_6b2bc344ea55f120() {
  sceneplay = self;

  if(getdvarint(@ "hash_f98fc73c88850645", 0)) {
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    player = sceneplay function_eeff9ce6b23bb906();

    if(!isDefined(player)) {
      return;
    }

    if(isarray(player.var_43996b501c46de7f)) {
      foreach(hud_elem in player.var_43996b501c46de7f) {
        if(isDefined(hud_elem)) {
          hud_elem destroy();
        }
      }

      player.var_43996b501c46de7f = array_removeundefined(player.var_43996b501c46de7f);
    }
  }
}

function function_ffae6ec92028ce08(shotindexes, duration, cameras) {
  if(!isDefined(duration)) {
    duration = 5;
  }

  sceneplay = self;
  player = undefined;

  if(getdvarint(@ "hash_f98fc73c88850645", 0)) {
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    player = sceneplay function_eeff9ce6b23bb906();

    if(!isDefined(player)) {
      return;
    }

    player function_7fb7bdf37cd47759();
    y = -35;
    player.var_7c8fce4c59afb3ae = [];
    str_scene_name = default_to(sceneroot.script_scenescriptbundle, "<dev string:x1c>");

    foreach(arrayindex, shotindex in shotindexes) {
      hudelem = newhudelem();
      str_shot_name = default_to(sceneroot.scenedata.scenescriptbundle.shots[shotindex].variant_object.name, "<dev string:x1c>");
      hudelem.alignx = "<dev string:x66e>";
      hudelem.aligny = "<dev string:x69b>";
      hudelem.vertalign = "<dev string:x69b>";
      hudelem.horzalign = "<dev string:x66e>";
      hudelem.font = "<dev string:x6a5>";
      hudelem.x = -25;
      hudelem.y = y;
      hudelem.fontscale = 1;
      hudelem.color = (0, 0.6, 0);
      cameratext = "<dev string:x1c>";

      if(isDefined(cameras) && isDefined(cameras[arrayindex])) {
        camerapos = cameras[arrayindex];
        cameratext = "<dev string:x6c8>" + int(camerapos[0]) + "<dev string:xa9>" + int(camerapos[1]) + "<dev string:xa9>" + int(camerapos[2]) + "<dev string:x6ce>";
      }

      hudelem setdevtext(cameratext + "<dev string:x6d4>" + str_scene_name + "<dev string:x6e4>" + str_shot_name);
      y -= 20;
      player.var_7c8fce4c59afb3ae[player.var_7c8fce4c59afb3ae.size] = hudelem;
    }
  }

  if(duration >= 0 && isDefined(player)) {
    player delaythreadendon(duration, "<dev string:x6eb>", &function_7fb7bdf37cd47759);
  }
}

function function_7fb7bdf37cd47759() {
  self notify("<dev string:x6eb>");

  if(!isDefined(self)) {
    return;
  }

  if(isarray(self.var_7c8fce4c59afb3ae)) {
    foreach(hud_elem in self.var_7c8fce4c59afb3ae) {
      if(isDefined(hud_elem)) {
        hud_elem destroy();
      }
    }

    self.var_7c8fce4c59afb3ae = undefined;
  }
}

function function_2fbba7f29e8d78ce(sceneobjectindex, entitytomatch) {
  var_fdc8fd88a88422e5 = getdvarint(@ "hash_3bc9bc279e3f772", 0);

  if(isDefined(entitytomatch)) {
    if(var_fdc8fd88a88422e5 && utility::is_equal(entitytomatch, level.players[0])) {
      if(var_fdc8fd88a88422e5 - 1 == sceneobjectindex) {
        return 1;
      } else {
        return 0;
      }
    }
  } else if(var_fdc8fd88a88422e5) {
    if(var_fdc8fd88a88422e5 - 1 == sceneobjectindex) {
      return 1;
    } else {
      return 0;
    }
  }

  return 0;
}

# /