/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\scene_debug.gsc
******************************************/

#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\scene_internal;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace scene_debug;

function function_194590af69906dd3() {
  if(getdvarint(@ "nodebug", 0) >= 1) {
    return;
  }

  setdvarifuninitialized(@ "scr_debug_scene_devgui", "<dev string:x24>");
  setdvarifuninitialized(@ "scr_debug_scene_disabled", 0);
  setdvarifuninitialized(@ "scr_debug_scene", 0);
  setdvarifuninitialized(@ "scr_debug_scene_events", 0);
  setdvarifuninitialized(@ "hash_71fb5222b333d146", "<dev string:x24>");
  setdvarifuninitialized(@ "scr_debug_scene_player_rig", 0);
  setdvarifuninitialized(@ "hash_f98fc73c88850645", 0);
  setdvarifuninitialized(@ "hash_d0761d5c3f9e3bf", 0);
  setdvarifuninitialized(@ "hash_373ad6363da1c230", (0, 0, 0));
  setdvarifuninitialized(@ "hash_eab41865eb0e96ea", (0, 0, 0));
  setdvarifuninitialized(@ "scr_debug_scene_list", 0);
  setdvarifuninitialized(@ "hash_b279d32f047f16db", 0);
  setdvarifuninitialized(@ "scr_debug_scene_penetrate", 1);
  setdvarifuninitialized(@ "hash_b95e70dfa43a9845", 1);
  setdvarifuninitialized(@ "hash_bc2179c6aea6636d", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_778fd26081328e2f", "<dev string:x24>");
  level thread debug_scenes();
}

function register() {
  if(!getdvarint(@ "scr_debug_scene_list", 0)) {
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

function unregister() {
  if(!getdvarint(@ "scr_debug_scene_list", 0)) {
    return;
  }

  sceneroot = self;
  assert(isstruct(sceneroot.scenedata));

  if(isDefined(sceneroot.scenedata.debuglistlast)) {
    sceneroot.scenedata.debuglistlast.debuglistnext = sceneroot.scenedata.debuglistnext;
  }

  if(level.scene.debuglist == sceneroot.scenedata) {
    level.scene.debuglist = sceneroot.scenedata.debuglistnext;
  }

  sceneroot.scenedata.debuglistlast = undefined;
  sceneroot.scenedata.debuglistnext = undefined;
}

function private debug_scenes() {
  while(!(isDefined(level.player) && isDefined(level.scene))) {
    waitframe();
  }

  wait 0.5;
  level.scene.debug_player = level.player;
  level.scene.debug_player thread function_885778f4c26a57ba("<dev string:x28>");
  level.scene.debug_player thread function_885778f4c26a57ba("<dev string:x33>");
  level.scene.debug_player thread function_885778f4c26a57ba("<dev string:x40>");
  level.scene.debug_player thread function_885778f4c26a57ba("<dev string:x4b>");
  function_146b8cea02a5a4eb();
  function_52f6223b9b56681b();
  devgui::function_9082edeb5db93280("<dev string:x58>");
  devgui::function_cd4e263c1f3018ae("<dev string:x69>", "<dev string:x7c>", &function_bd0ab793e83b94ef, 0, 1);
  devgui::function_502a7d5e4d9dfa5b("<dev string:x8f>", "<dev string:x9d>", &scene_menu, 0, 2);
  devgui::function_77df7fe7dd273e10();
  level thread function_e7e798bd060cf03d();
}

function private function_52f6223b9b56681b() {
  var_e29b675e10b7ca10 = [];

  foreach(s_scene in level.var_8b929db1c0421d07) {
    if(function_ba02ac76b97863b8(s_scene.script_scenescriptbundle) && !s_scene.var_b8d0b3148ac4e533) {
      if(isDefined(var_e29b675e10b7ca10[s_scene.script_scenescriptbundle])) {
        var_e29b675e10b7ca10[s_scene.script_scenescriptbundle]++;
      } else {
        var_e29b675e10b7ca10[s_scene.script_scenescriptbundle] = 1;
      }

      s_scene.var_d69404e803a096ca = var_e29b675e10b7ca10[s_scene.script_scenescriptbundle];
    }
  }
}

function private function_ba02ac76b97863b8(str_scene_name) {
  n_count = 0;

  foreach(s_scene in level.var_8b929db1c0421d07) {
    if(s_scene.script_scenescriptbundle == str_scene_name) {
      n_count++;
    }
  }

  if(n_count > 1) {
    return 1;
  }

  return 0;
}

function private function_e7e798bd060cf03d() {
  while(true) {
    waitframe();

    if(!getdvarint(@ "scr_debug_scene", 0) && !getdvarint(@ "scr_debug_scene_list", 0)) {
      continue;
    }

    function_835db787656b0e9c();
  }
}

function private function_835db787656b0e9c() {
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

    if(getdvarint(@ "scr_debug_scene_list", 0)) {
      roots[roots.size] = spawnStruct();
      roots[roots.size - 1].sceneroot = walk.sceneroot;
    }

    scenescriptbundle = walk.sceneroot scene::scene_scriptbundle();
    sceneshots = scenescriptbundle scene::function_30fd977cf5a4a95e();
    sceneobjects = scenescriptbundle scene::function_bd663a9606d90ac1();

    if(getdvarint(@ "scr_debug_scene_list", 0)) {
      roots[roots.size - 1].sceneshots = sceneshots;
      roots[roots.size - 1].sceneobjects = sceneobjects;
    }

    countshot += sceneshots;
    countobject += sceneobjects;
    walk = walk.debuglistnext;
  }

  if(getdvarint(@ "scr_debug_scene_list", 0)) {
    roots = arraysort(roots, undefined, &function_2f7c63e77b293fe7);

    foreach(root in roots) {
      state = root.sceneroot scene::get_state();
      strorigin = "<dev string:xab>" + int(root.sceneroot.origin[0]) + "<dev string:xb1>" + int(root.sceneroot.origin[1]) + "<dev string:xb1>" + int(root.sceneroot.origin[2]) + "<dev string:xb7>";
      strstate = isDefined(state) ? state : "<dev string:xbd>";
      print(root.sceneroot.script_scenescriptbundle + "<dev string:xce>" + strstate + "<dev string:xd6>" + strorigin + "<dev string:xdb>" + root.sceneshots + "<dev string:xe6>" + root.sceneobjects);
    }
  }

  setDvar(@ "scr_debug_scene_list", 0);
  printtoscreen2d(50, 60, "<dev string:xf3>" + countscene + "<dev string:xff>" + countshot + "<dev string:x10b>" + countobject + "<dev string:x119>" + countbundle, (1, 1, 1), 1);
}

function private function_2f7c63e77b293fe7(a, b) {
  return stricmp(a.sceneroot.script_scenescriptbundle, b.sceneroot.script_scenescriptbundle) < 0;
}

function private function_146b8cea02a5a4eb() {
  if(!isDefined(level.var_18c87c2c4c3b0a2d)) {
    level.var_18c87c2c4c3b0a2d = [];
  }

  var_851c384140f3d1c8 = getscriptbundlenames("<dev string:x127>");

  foreach(str_scene_bundle in var_851c384140f3d1c8) {
    s_scenedef = getscriptbundle(str_scene_bundle);
    str_scene_name = strtok(getxhashsourcename(str_scene_bundle), "<dev string:x13c>");
    str_scene_name = str_scene_name[1];

    if(!isDefined(str_scene_name)) {
      continue;
    }

    if(!arraycontains(level.var_18c87c2c4c3b0a2d, str_scene_name)) {
      level.var_18c87c2c4c3b0a2d = arraycombineunique(level.var_18c87c2c4c3b0a2d, [str_scene_name]);
      s_scene = spawnStruct();
      s_scene.script_scenescriptbundle = str_scene_name;
      s_scene.origin = (0, 0, 0);
      s_scene.angles = (0, 0, 0);
      s_scene.var_b8d0b3148ac4e533 = 1;
      level.var_8b929db1c0421d07 = arraycombineunique(level.var_8b929db1c0421d07, [s_scene]);
    }
  }
}

function private function_bd0ab793e83b94ef(params) {
  if(params[0] == "<dev string:x141>" || !utility::flag("<dev string:x14b>")) {
    utility::flag_set("<dev string:x14b>");
    level thread function_3c59aa392ac39dcc();
    return;
  }

  utility::flag_clear("<dev string:x14b>");
}

function private function_3c59aa392ac39dcc(params) {
  level notify("<dev string:x165>");
  level endon("<dev string:x165>");
  var_8d60da971d96ac26 = (0.8, 0.8, 0);
  var_2baf6b7eee00cea7 = (0.8, 0, 0.8);

  while(utility::flag("<dev string:x14b>")) {
    foreach(s_scene in level.var_8b929db1c0421d07) {
      str_scene_state = s_scene scene::get_state();
      a_ents = s_scene scene::get_entities();
      str_scene_name = isDefined(s_scene.var_d69404e803a096ca) ? s_scene.script_scenescriptbundle + "<dev string:x180>" + s_scene.var_d69404e803a096ca : s_scene.script_scenescriptbundle;
      print3d(s_scene.origin, "<dev string:x185>" + getxhashsourcename(str_scene_name), (0.8, 0, 0.8), 0.8, 0.2);
      print3d(s_scene.origin + (0, 0, -5), "<dev string:x190>" + str_scene_state, (0.8, 0, 0.8), 0.8, 0.2);

      foreach(ent in a_ents) {
        if(!isDefined(ent)) {
          continue;
        }

        sceneobjectdata = ent.sceneobjectdata;
        str_anim = undefined;

        if(isDefined(sceneobjectdata)) {
          str_anim = sceneobjectdata.activeanimation;
        }

        if(isDefined(ent.scene_player_rig)) {
          str_name = ent.scene_player_rig.animname;
        } else {
          str_name = ent.animname ?? sceneobjectdata.sceneobject.variant_object.name;
        }

        if(isanimation(str_anim) && isDefined(str_name)) {
          str_type = ent function_edcc1c2f941f4751();
          str_anim_text = "<dev string:x24>";
          str_extra_info = "<dev string:x24>";
          var_bad1c827136f96f = getanimlength(str_anim) ?? 0;

          if(isPlayer(ent)) {
            player_rig = level.player_rig ?? ent.scene_player_rig;

            if(isDefined(player_rig)) {
              var_b965be4ab10edc7e = player_rig getanimtime(str_anim) ?? 0;
              var_3ba18033860bafae = var_b965be4ab10edc7e * var_bad1c827136f96f;
            } else {
              var_b965be4ab10edc7e = 0;
              var_3ba18033860bafae = 0;
            }
          } else if(ent vehicle::is_vehicle() || isai(ent) || utility::issp()) {
            if(isagent(ent) && isDefined(ent.var_e073af6d35bd0942)) {
              var_b965be4ab10edc7e = ent aigetanimtime("<dev string:x19b>", ent.var_e073af6d35bd0942);
            } else {
              var_b965be4ab10edc7e = ent getanimtime(str_anim) ?? 0;
            }

            var_3ba18033860bafae = var_b965be4ab10edc7e * var_bad1c827136f96f;
          } else if(isanimScripted(ent)) {
            var_b965be4ab10edc7e = ent getanimtime(str_anim) ?? 0;
            var_3ba18033860bafae = var_b965be4ab10edc7e * var_bad1c827136f96f;
          } else if(isDefined(ent.var_bbd02606816314a8)) {
            if(var_3ba18033860bafae >= var_bad1c827136f96f) {
              ent.var_bbd02606816314a8 = gettime();
            }

            var_3ba18033860bafae = (gettime() - ent.var_bbd02606816314a8) / 1000;
            var_b965be4ab10edc7e = var_3ba18033860bafae / var_bad1c827136f96f;
          } else {
            var_b965be4ab10edc7e = 0;
            var_3ba18033860bafae = 0;
          }

          var_b288497f88cb2852 = var_bad1c827136f96f * 30;
          var_b577b0949f7f5e84 = int(var_b965be4ab10edc7e * var_b288497f88cb2852);
          str_extra_info = "<dev string:x1ab>" + var_3ba18033860bafae + "<dev string:x1ba>" + var_bad1c827136f96f + "<dev string:x1bf>" + var_b577b0949f7f5e84 + "<dev string:x1ba>" + var_b288497f88cb2852 + "<dev string:x1d3>";
          var_b991f23f9ff3c95e = getanimname(str_anim);

          if(isxhashasset(var_b991f23f9ff3c95e)) {
            var_b991f23f9ff3c95e = getxhashsourcename(var_b991f23f9ff3c95e);
          }

          if(animislooping(str_anim)) {
            str_anim_text = "<dev string:x1d8>" + var_b991f23f9ff3c95e;
          } else {
            str_anim_text = "<dev string:x1e7>" + var_b991f23f9ff3c95e;
          }

          var_9d77361dcd71aee3 = ent.origin - (0, 0, 6);
          print3d(var_9d77361dcd71aee3, "<dev string:x1f1>" + ent getentitynumber() + str_type + "<dev string:x1fe>" + (str_name ?? "<dev string:x20a>" + ent getentitynumber()), (0.8, 0.8, 0), 0.8, 0.2);
          print3d(var_9d77361dcd71aee3 - (0, 0, 5), str_anim_text, (0.8, 0.8, 0), 0.8, 0.2);
          print3d(var_9d77361dcd71aee3 - (0, 0, 11), str_extra_info, (0.8, 0.8, 0), 0.8, 0.2);
          print3d(var_9d77361dcd71aee3 - (0, 0, 17), "<dev string:x215>" + ent.origin, (0.8, 0.8, 0), 0.8, 0.2);
          ent render_tag("<dev string:x225>");
          ent render_tag("<dev string:x239>");
          ent render_tag("<dev string:x24c>");
          ent render_tag("<dev string:x262>");
          ent render_tag("<dev string:x270>");
          ent render_tag("<dev string:x27e>");
          ent render_tag("<dev string:x28b>");
          ent render_tag("<dev string:x296>", "<dev string:x2a4>");
        }
      }
    }

    waitframe();
  }
}

function private render_tag(str_tag, str_label, b_recorder_only) {
  if(!isDefined(str_label)) {
    str_label = str_tag;
  }

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
    if(!isDefined(line_length)) {
      line_length = 6;
    }

    originendpoint = org + anglesToForward(angles) * line_length;
    originrightpoint = org + anglestoright(angles) * -1 * line_length;
    originuppoint = org + anglestoup(angles) * line_length;
    line(org, originendpoint, (1, 0, 0));
    line(org, originrightpoint, (0, 1, 0));
    line(org, originuppoint, (0, 0, 1));

    if(isDefined(str_label)) {
      print3d(org, str_label, (1, 0.5, 1), 2, 0.05);
    }
  }
}

function private function_edcc1c2f941f4751() {
  str_text = "<dev string:x24>";

  if(isactor(self) || isagent(self)) {
    str_text = "<dev string:x2ac>";
  } else if(isPlayer(self)) {
    str_text = "<dev string:x2b4>";
  } else if(isDefined(vehicle::get_ref())) {
    str_text = "<dev string:x2c0>";
  } else {
    str_text = "<dev string:x2cd>" + self.classname + "<dev string:x2d2>";
  }

  return str_text;
}

function display_scene_menu(str_scene_selected) {
  str_type = "<dev string:x2d7>";
  level notify("<dev string:x2e0>");
  level endon("<dev string:x2e0>");
  waittillframeend();
  names = [];
  b_shot_menu = 0;
  s_scene = undefined;

  if(isstring(str_scene_selected)) {
    s_scene = function_aade29044f6febba(str_scene_selected);
    names = arraycombine(names, s_scene scene::function_837e044d37c5d180());
    names[names.size] = "<dev string:x24>";
    names[names.size] = "<dev string:x2f6>";
    names[names.size] = "<dev string:x2fe>";
    names[names.size] = "<dev string:x24>";
    names[names.size] = "<dev string:x307>";
    str_title = str_scene_selected + "<dev string:x30f>";
    b_shot_menu = 1;
    selected = level.scene_menu_shot_index ?? 0;
  } else {
    if(utility::flag("<dev string:x319>")) {
      println("<dev string:x333>" + str_type + "<dev string:x348>");
    }

    var_5d9478057df4c3e5 = 1;

    foreach(s_scene in level.var_8b929db1c0421d07) {
      str_scenedef = s_scene.script_scenescriptbundle;

      if(!isDefined(str_scenedef)) {
        continue;
      }

      if(isxhash(str_scenedef)) {
        s_scenedef = getscriptbundle(str_scenedef);
      }

      if(!isDefined(s_scenedef) && isstring(str_scenedef)) {
        s_scenedef = getscriptbundle("<dev string:x35a>" + str_scenedef);
      }

      if(!isDefined(s_scenedef)) {
        continue;
      }

      str_scene_menu_name = isDefined(s_scene.var_d69404e803a096ca) ? str_scenedef + "<dev string:x180>" + s_scene.var_d69404e803a096ca : str_scenedef;

      if(utility::flag("<dev string:x319>")) {
        if(s_scene scene::get_state() == "<dev string:x370>") {
          names[names.size] = str_scene_menu_name;
          println("<dev string:x333>" + str_type + "<dev string:xd6>" + var_5d9478057df4c3e5 + "<dev string:x37b>" + str_scenedef);
          var_5d9478057df4c3e5++;
        }

        continue;
      }

      names[names.size] = str_scene_menu_name;
    }

    if(utility::flag("<dev string:x319>")) {
      println("<dev string:x333>" + str_type + "<dev string:x385>");
    }

    names = utility::alphabetize(names);

    foreach(str_scene_name in names) {
      if(issubstr(str_scene_name, "<dev string:x395>")) {
        names = arrayremove(names, str_scene_name);
        arrayinsert(names, str_scene_name, 0);
      }
    }

    if(isDefined(level.var_33009922f6ff7446)) {
      foreach(str_scene_name in names) {
        if(issubstr(str_scene_name, level.var_33009922f6ff7446)) {
          names = arrayremove(names, str_scene_name);
          arrayinsert(names, str_scene_name, 0);
        }
      }
    }

    names[names.size] = "<dev string:x24>";
    names[names.size] = "<dev string:x39d>";
    arrayinsert(names, "<dev string:x24>", 0);
    arrayinsert(names, "<dev string:x3a5>", 0);
    str_title = str_type + "<dev string:x3c7>";
    selected = level.scene_menu_index ?? 0;
  }

  if(selected > names.size - 1) {
    selected = 0;
  }

  up_pressed = 0;
  down_pressed = 0;
  held = 0;
  var_d87acc06076b58ca = gettime();

  while(utility::flag("<dev string:x3cc>")) {
    if(!isDefined(level.scene.debug_player)) {
      level.scene.debug_player = level.players[0];
      waitframe();
      continue;
    }

    if(b_shot_menu) {
      if(isDefined(level.last_scene_state) && isDefined(level.last_scene_state[str_scene_selected])) {
        str_title = str_scene_selected + "<dev string:x3e1>" + level.last_scene_state[str_scene_selected] + "<dev string:x3e7>";
      }
    }

    scene_list_settext(names, selected, str_title, b_shot_menu, 1);
    currenttime = gettime();
    pagecount = 10;

    if(currenttime < var_d87acc06076b58ca) {
      pagecount = 0;
    }

    if(!up_pressed) {
      if(level.scene.debug_player buttonPressed("<dev string:x28>") || level.scene.debug_player buttonPressed("<dev string:x40>")) {
        up_pressed = 1;
        selected--;

        while(!isDefined(names[selected]) || names[selected] == "<dev string:x24>") {
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
    } else if(level.scene.debug_player function_82c6c002c1cbc8d8("<dev string:x28>") || level.scene.debug_player function_82c6c002c1cbc8d8("<dev string:x40>")) {
      held = 1;
      selected -= pagecount;
    } else if(!level.scene.debug_player buttonPressed("<dev string:x28>") && !level.scene.debug_player buttonPressed("<dev string:x40>")) {
      held = 0;
      up_pressed = 0;
    }

    if(!down_pressed) {
      if(level.scene.debug_player buttonPressed("<dev string:x33>") || level.scene.debug_player buttonPressed("<dev string:x4b>")) {
        down_pressed = 1;
        selected++;

        while(!isDefined(names[selected]) || names[selected] == "<dev string:x24>") {
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
    } else if(level.scene.debug_player function_82c6c002c1cbc8d8("<dev string:x33>") || level.scene.debug_player function_82c6c002c1cbc8d8("<dev string:x4b>")) {
      held = 1;
      selected += pagecount;
    } else if(!level.scene.debug_player buttonPressed("<dev string:x33>") && !level.scene.debug_player buttonPressed("<dev string:x4b>")) {
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
      var_d87acc06076b58ca = gettime() + 500;
    }

    if(names[selected] != "<dev string:x3a5>" && names[selected] != "<dev string:x39d>" && !b_shot_menu) {
      s_scene = function_aade29044f6febba(names[selected]);
    }

    if(level.scene.debug_player buttonPressed("<dev string:x3ec>") || level.scene.debug_player buttonPressed("<dev string:x3f8>")) {
      if(b_shot_menu) {
        while(level.scene.debug_player buttonPressed("<dev string:x3ec>") || level.scene.debug_player buttonPressed("<dev string:x3f8>")) {
          waitframe();
        }

        level.scene_menu_shot_index = selected;
        level thread display_scene_menu();
      } else {
        level.scene_menu_index = selected;
        var_801efcb296c81c06 = "<dev string:x402>" + getxhashhexname(@ "scr_debug_scene_devgui") + "<dev string:x40a>";
        adddebugcommand(var_801efcb296c81c06);
        return;
      }
    }

    if(names[selected] != "<dev string:x39d>" && names[selected] != "<dev string:x3a5>" && !b_shot_menu && isDefined(s_scene)) {
      if(level.scene.debug_player buttonPressed("<dev string:x419>") || level.scene.debug_player buttonPressed("<dev string:x427>")) {
        level.scene.debug_player setOrigin(s_scene.origin);

        while(level.scene.debug_player buttonPressed("<dev string:x419>") || level.scene.debug_player buttonPressed("<dev string:x427>")) {
          waitframe();
        }
      } else if(level.scene.debug_player buttonPressed("<dev string:x435>") || level.scene.debug_player buttonPressed("<dev string:x442>")) {
        level.scene.debug_player setOrigin(s_scene.origin);

        while(level.scene.debug_player buttonPressed("<dev string:x435>") || level.scene.debug_player buttonPressed("<dev string:x442>")) {
          waitframe();
        }
      }
    }

    if(b_shot_menu && (function_6524e946516b534e() || function_217ffd073ec8c363()) && isDefined(str_scene_selected) && arraycontains(s_scene scene::function_837e044d37c5d180(), names[selected])) {
      if(function_6524e946516b534e()) {
        a_str_shot_names = s_scene scene::function_837e044d37c5d180();
        var_8001b0e61b029584 = [];
        var_946fa5ec1341b850 = 0;

        foreach(str_shot_name in a_str_shot_names) {
          if(str_shot_name != names[selected] && !var_946fa5ec1341b850) {
            continue;
          }

          var_946fa5ec1341b850 = 1;
          var_8001b0e61b029584[var_8001b0e61b029584.size] = str_shot_name;
        }

        s_scene thread scene::play(undefined, var_8001b0e61b029584);
      } else if(function_217ffd073ec8c363()) {
        s_scene thread scene::init(undefined, names[selected]);
      }

      while(function_217ffd073ec8c363() || function_6524e946516b534e()) {
        waitframe();
      }
    } else if(function_22c33fb31bec181b() && isDefined(names[selected])) {
      if(!b_shot_menu && names[selected] == "<dev string:x3a5>") {
        if(utility::flag("<dev string:x319>")) {
          utility::flag_clear("<dev string:x319>");
        } else {
          utility::flag_set("<dev string:x319>");
        }

        while(function_22c33fb31bec181b()) {
          waitframe();
        }

        level thread display_scene_menu();
      } else if(!b_shot_menu) {
        if(names[selected] == "<dev string:x39d>") {
          var_801efcb296c81c06 = "<dev string:x402>" + getxhashhexname(@ "scr_debug_scene_devgui") + "<dev string:x40a>";
          adddebugcommand(var_801efcb296c81c06);
          return;
        }
      } else if(b_shot_menu) {
        if(s_scene.var_b8d0b3148ac4e533) {
          s_scene.origin = getdvarvector(@ "hash_373ad6363da1c230");
          s_scene.angles = getdvarvector(@ "hash_eab41865eb0e96ea");
        }

        if(names[selected] == "<dev string:x307>") {
          level.scene_menu_shot_index = selected;

          while(function_22c33fb31bec181b()) {
            waitframe();
          }

          level thread display_scene_menu();
        } else if(names[selected] == "<dev string:x2f6>") {
          s_scene thread scene::stop();
        } else if(names[selected] == "<dev string:x2fe>") {
          s_scene thread scene::cleanup(1);
        } else if(names[selected] == "<dev string:x44f>") {
          s_scene thread scene::init();
        } else if(names[selected] == "<dev string:x457>") {
          s_scene thread scene::play();
        } else if(names[selected] != "<dev string:x24>") {
          s_scene thread scene::play(undefined, names[selected]);
        }
      }

      while(function_22c33fb31bec181b() || function_6524e946516b534e()) {
        waitframe();
      }

      if(!b_shot_menu && names[selected] != "<dev string:x24>") {
        level.scene_menu_index = selected;
        level thread display_scene_menu(names[selected]);
      }
    }

    waitframe();
  }
}

function private function_aade29044f6febba(str_scene_selected) {
  var_64af815746cd2fd0 = strtok(str_scene_selected, "<dev string:x180>");
  str_scene_selected = var_64af815746cd2fd0[0];
  var_d69404e803a096ca = var_64af815746cd2fd0[1];

  if(isDefined(var_d69404e803a096ca)) {
    var_d69404e803a096ca = int(var_d69404e803a096ca);
  }

  s_scene = level.var_8b929db1c0421d07[0];

  foreach(var_712cbb1d3431ce00 in level.var_8b929db1c0421d07) {
    if(str_scene_selected == var_712cbb1d3431ce00.script_scenescriptbundle && (!isDefined(var_d69404e803a096ca) || var_d69404e803a096ca == var_712cbb1d3431ce00.var_d69404e803a096ca)) {
      s_scene = var_712cbb1d3431ce00;
      break;
    }
  }

  return s_scene;
}

function private scene_menu(params) {
  if(!utility::flag("<dev string:x3cc>")) {
    utility::flag_set("<dev string:x3cc>");
    level.scene.debug_player val::set("<dev string:x45f>", "<dev string:x46e>", 0);
    level.scene.debug_player val::set("<dev string:x45f>", "<dev string:x47c>", 0);
    level.scene.debug_player val::set("<dev string:x45f>", "<dev string:x486>", 0);
    level thread display_scene_menu();
    return;
  }

  utility::flag_clear("<dev string:x3cc>");
  level.scene.debug_player val::reset("<dev string:x45f>", "<dev string:x46e>");
  level.scene.debug_player val::reset("<dev string:x45f>", "<dev string:x47c>");
  level.scene.debug_player val::reset("<dev string:x45f>", "<dev string:x486>");
  function_23f91059855df63d();
}

function private scene_list_settext(strings, n_selected, str_title, b_shot_menu, var_d7c3bc47919cd2a5) {
  if(!utility::flag("<dev string:x48f>")) {
    thread _scene_list_settext(strings, n_selected, str_title, b_shot_menu, var_d7c3bc47919cd2a5);
  }
}

function private _scene_list_settext(strings, n_selected, str_title, b_shot_menu, var_d7c3bc47919cd2a5) {
  if(!isDefined(var_d7c3bc47919cd2a5)) {
    var_d7c3bc47919cd2a5 = 1;
  }

  for(i = 0; i < var_d7c3bc47919cd2a5; i++) {
    printtoscreen2d(100, 260, str_title, (1, 1, 1), 2);
    str_mode = "<dev string:x4a5>";

    switch (str_mode) {
      case #"hash_7038dec66d8275be":
        printtoscreen2d(100, 290, "<dev string:x4b0>", (1, 1, 1), 2);
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
        text = "<dev string:x24>";
      }

      str_scene = text;

      if(isDefined(level.last_scene_state) && isDefined(level.last_scene_state[text])) {
        text += "<dev string:x3e1>" + level.last_scene_state[text] + "<dev string:x3e7>";
      }

      if(i == 5) {
        text = "<dev string:x4ed>" + text + "<dev string:x4f3>";
        str_color = (0.8, 0.4, 0);
      } else if(str_scene != "<dev string:x24>") {
        str_color = (0, 1, 0);
      } else {
        str_color = (1, 1, 1);
      }

      y_offset = i * 30;
      printtoscreen2d(86, 350 + y_offset, text, str_color, 2);
    }

    if(b_shot_menu && !getdvarint(@ "hash_303a3f39ecf974db", 0)) {
      if(!isDefined(level.scene.var_4b3d13d75ab66180)) {
        level.scene.var_4b3d13d75ab66180 = newhudelem();
      }

      level.scene.var_4b3d13d75ab66180.alignx = "<dev string:x4f8>";
      level.scene.var_4b3d13d75ab66180.x = 55;
      level.scene.var_4b3d13d75ab66180.y = 250;
      level.scene.var_4b3d13d75ab66180.fontscale = 1;
      level.scene.var_4b3d13d75ab66180.color = (1, 1, 1);
      level.scene.var_4b3d13d75ab66180.horzalign = "<dev string:x500>";
      level.scene.var_4b3d13d75ab66180.vertalign = "<dev string:x500>";
      buttonprompttext = "<dev string:x24>";

      if(level.scene.debug_player usinggamepad()) {
        buttonprompttext = "<dev string:x50e>";
      } else {
        buttonprompttext = "<dev string:x574>";
      }

      level.scene.var_4b3d13d75ab66180 setdevtext(buttonprompttext);
    } else {
      function_23f91059855df63d();
      printtoscreen2d(100, 830, "<dev string:x5bd>", (1, 1, 1), 2);
    }

    waitframe();
  }
}

function private function_23f91059855df63d() {
  if(isDefined(level.scene.var_4b3d13d75ab66180)) {
    level.scene.var_4b3d13d75ab66180 destroy();
  }
}

function private function_22c33fb31bec181b() {
  if(level.scene.debug_player buttonPressed("<dev string:x5e2>") || level.scene.debug_player buttonPressed("<dev string:x5ee>") || level.scene.debug_player buttonPressed("<dev string:x5fa>")) {
    return 1;
  }

  return 0;
}

function private function_6524e946516b534e() {
  if(level.scene.debug_player buttonPressed("<dev string:x603>") || level.scene.debug_player buttonPressed("<dev string:x60f>")) {
    return 1;
  }

  return 0;
}

function private function_217ffd073ec8c363() {
  if(level.scene.debug_player buttonPressed("<dev string:x614>") || level.scene.debug_player buttonPressed("<dev string:x620>")) {
    return 1;
  }

  return 0;
}

function private function_82c6c002c1cbc8d8(str_button) {
  if(getdvarint(@ "hash_66d7268f08facc81", 0)) {
    return 0;
  }

  return self._holding_button[str_button];
}

function private function_885778f4c26a57ba(str_button) {
  self endon("<dev string:x628>");

  if(!isDefined(self._holding_button)) {
    self._holding_button = [];
  }

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

function tag_thread(tag, size, duration, blendtimesec) {
  self endon("<dev string:x636>");
  self notify("<dev string:x64d>" + tag);
  self endon("<dev string:x64d>" + tag);
  starttime = gettime();

  if(!isDefined(level.var_9b7137b1581c88f7)) {
    level.var_9b7137b1581c88f7 = [];
    level.var_9b7137b1581c88f7[level.var_9b7137b1581c88f7.size] = (1, 0, 0);
    level.var_9b7137b1581c88f7[level.var_9b7137b1581c88f7.size] = (0, 1, 0);
    level.var_9b7137b1581c88f7[level.var_9b7137b1581c88f7.size] = (0, 0, 1);
    level.var_9b7137b1581c88f7[level.var_9b7137b1581c88f7.size] = (1, 1, 0);
    level.var_9b7137b1581c88f7[level.var_9b7137b1581c88f7.size] = (0, 1, 1);
    level.var_9b7137b1581c88f7[level.var_9b7137b1581c88f7.size] = (1, 0, 1);
    level.debug_tag_color = -1;
  }

  color = (1, 1, 1);
  blendtimems = 0;

  if(!isDefined(blendtimesec)) {
    level.debug_tag_color = (level.debug_tag_color + 1) % level.var_9b7137b1581c88f7.size;
    color = level.var_9b7137b1581c88f7[level.debug_tag_color];
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

    if(tag != "<dev string:x24>") {
      origin = self gettagorigin(tag, 0, 1, 0);
      angles = self gettagangles(tag, 0, 1, 0);
      print3d(origin + (0, 0, 1), tag, (1, 1, 1), 1, 0.15, 1, 1);
    } else if(isPlayer(self)) {
      origin = self getEye();
      angles = self getplayerangles();
    } else {
      print3d(origin + (0, 0, 1), "<dev string:x662>", (1, 1, 1), 1, 0.15, 1, 1);
    }

    line(origin, origin + anglesToForward(angles) * size, color, 1, 0, duration);
    line(origin, origin + anglestoright(angles) * size, color * 0.75, 1, 0, duration);
    line(origin, origin + anglestoup(angles) * size, (1, 1, 1), 1, 0, duration);
    print3d(origin + (0, 0, 5), "<dev string:x24>" + self getentitynumber(), (1, 1, 1), 1, 0.25, 1, 1);
    print3d(origin + (0, 0, 10), "<dev string:x24>" + gettime() - starttime, (1, 1, 1), 1, 0.25, 1, 1);
  }
}

function object_event(sceneobjectdata, event, origin, angles) {
  if(!getdvarint(@ "scr_debug_scene_events", 0)) {
    return;
  }

  filter = getDvar(@ "hash_71fb5222b333d146", "<dev string:x24>");

  if(filter != "<dev string:x24>" && !issubstr(tolower(filter), tolower(sceneobjectdata.sceneobject.variant_object.name)) && !issubstr(tolower(sceneobjectdata.sceneobject.variant_object.name), tolower(filter)) && !issubstr(tolower(event), tolower(filter))) {
    return;
  }

  level thread object_event_thread(sceneobjectdata, event, origin, angles);
}

function private object_event_thread(sceneobjectdata, event, origin, angles) {
  self notify("d1649d6e99566155");
  self endon("d1649d6e99566155");
  assert(isDefined(sceneobjectdata));
  assert(isDefined(event));
  assert(isDefined(origin));
  assert(isDefined(angles));

  if(!isDefined(level.scene_debug_events)) {
    level.scene_debug_events = [];
  }

  bucketdistsq = squared(5);
  duration = getdvarint(@ "scr_debug_scene_events", 0);
  scale = 0.25;
  step = 4;
  eventlistadd = undefined;

  foreach(eventlist in level.scene_debug_events) {
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
    level.scene_debug_events[level.scene_debug_events.size] = eventlistadd;
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
  print3d((0, 0, 0), "<dev string:x24>", (1, 1, 1), 1, 1, 1);
  waitframe();

  foreach(eventlist in level.scene_debug_events) {
    drawnorigin = undefined;
    drawnangles = undefined;
    lastscene = undefined;
    lastobject = undefined;
    offset = (0, 0, 0);

    for(i = 0; i < eventlist.events.size; i++) {
      event = eventlist.events[i];

      if(drawnorigin != event.origin || drawnangles != event.angles) {
        drawnorigin = event.origin;
        drawnangles = event.angles;
        axis = anglestoaxis(event.angles);
        line(event.origin, event.origin + axis["<dev string:x673>"] * 10, (1, 0, 0), 1, 0, duration);
        line(event.origin, event.origin + axis["<dev string:x67e>"] * 10, (0, 1, 0), 1, 0, duration);
        line(event.origin, event.origin + axis["<dev string:x687>"] * 10, (0, 0, 1), 1, 0, duration);
      }

      if(lastscene != event.scenename) {
        lastscene = event.scenename;
        print3d(eventlist.origin + offset, lastscene, (1, 1, 0), 1, scale, duration);
        offset += (0, 0, step);
      }

      if(lastobject != event.objectname) {
        lastobject = event.objectname;
        offset += (0, 0, step * 0.5);
        print3d(eventlist.origin + offset, lastobject, (0, 1, 1), 1, scale, duration);
        offset += (0, 0, step);
      }

      print3d(eventlist.origin + offset, event.event + "<dev string:x3e1>" + event.time + "<dev string:x3e7>", (1, 1, 1), 1, scale, duration);
      offset += (0, 0, step);
      print3d(eventlist.origin + offset, "<dev string:x24>" + int(event.origin[0]) + "<dev string:xb1>" + int(event.origin[1]) + "<dev string:xb1>" + int(event.origin[2]), (1, 1, 1), 1, scale, duration);
      offset += (0, 0, step);
      activeanimation = "<dev string:x24>";
      objectname = "<dev string:x24>";

      if(isDefined(event.activeanimation)) {
        activeanimation = event.activeanimation;
      }

      if(isDefined(event.objectname)) {
        objectname = event.objectname;
      }

      println("<dev string:x68d>" + event.time + "<dev string:x69e>" + event.event + "<dev string:x6a4>" + objectname);
    }
  }

  level.scene_debug_events = undefined;
}

function scene_play_player() {
  sceneplay = self;
  sceneroot = sceneplay.sceneroot;
  scenedata = sceneroot.scenedata;

  if(!isDefined(scenedata)) {
    return undefined;
  }

  foreach(sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.var_caf7bc39e6b19dd5) {
    sceneobjectdata = scenedata.sceneobjectdata[sceneobjectindex];

    if(isPlayer(sceneobjectdata.entity)) {
      return sceneobjectdata.entity;
    }

    if(sceneobjectdata.sceneobject.variant_type === "<dev string:x6ab>") {
      participatingplayers = sceneobjectdata.xcamplayers ?? sceneobjectdata.sceneroot.scenestatic.exclusiveplayers ?? level.players;
      return participatingplayers[0];
    }
  }
}

function function_ba32edc20462b709(shotindex) {
  sceneplay = self;

  if(getdvarint(@ "hash_f98fc73c88850645", 0)) {
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    player = sceneplay scene_play_player();

    if(!isDefined(player)) {
      return;
    }

    sceneplay function_566e3d31befe1331();
    player.var_7b353d581f4f612c[0] = newhudelem();
    player.var_7b353d581f4f612c[1] = newhudelem();
    str_scene_name = sceneroot.script_scenescriptbundle ?? "<dev string:x24>";
    str_shot_name = sceneroot.scenedata.scenescriptbundle.shots[shotindex].variant_object.name ?? "<dev string:x24>";
    player.var_7b353d581f4f612c[0].alignx = "<dev string:x67e>";
    player.var_7b353d581f4f612c[0].aligny = "<dev string:x6b9>";
    player.var_7b353d581f4f612c[0].vertalign = "<dev string:x6b9>";
    player.var_7b353d581f4f612c[0].horzalign = "<dev string:x67e>";
    player.var_7b353d581f4f612c[0].font = "<dev string:x6c3>";
    player.var_7b353d581f4f612c[0].x = -20;
    player.var_7b353d581f4f612c[0].y = -90;
    player.var_7b353d581f4f612c[0].fontscale = 1;
    player.var_7b353d581f4f612c[0].color = (0.6, 0.6, 0.6);
    player.var_7b353d581f4f612c[1].alignx = "<dev string:x67e>";
    player.var_7b353d581f4f612c[1].aligny = "<dev string:x6b9>";
    player.var_7b353d581f4f612c[1].vertalign = "<dev string:x6b9>";
    player.var_7b353d581f4f612c[1].horzalign = "<dev string:x67e>";
    player.var_7b353d581f4f612c[1].font = "<dev string:x6c3>";
    player.var_7b353d581f4f612c[1].x = -20;
    player.var_7b353d581f4f612c[1].y = -70;
    player.var_7b353d581f4f612c[1].fontscale = 1;
    player.var_7b353d581f4f612c[1].color = (0.6, 0.6, 0.6);
    player.var_7b353d581f4f612c[0] setdevtext("<dev string:x185>" + (isxhashasset(str_scene_name) ? getxhashsourcename(str_scene_name) : str_scene_name));
    player.var_7b353d581f4f612c[1] thread function_11162298d42afbc9(sceneplay, str_shot_name, sceneroot.var_f1be55806e0d5f25);
  }
}

function private function_11162298d42afbc9(sceneplay, shotname, starttime) {
  self notify("82bc872dcb5dd5c8");
  self endon("82bc872dcb5dd5c8");
  self endon("<dev string:x636>");

  while(isDefined(sceneplay.sceneroot)) {
    shottime = sceneplay.sceneroot scene::function_30ae5e4baf26ba77(sceneplay.currentshot);

    if(isDefined(shottime)) {
      shottime = "<dev string:x6d1>" + floor(shottime * 100);
    } else {
      shottime = "<dev string:x24>";
    }

    if(isDefined(sceneplay.sceneroot.var_f1be55806e0d5f25)) {
      shottext = shottime + "<dev string:x6d7>" + shotname + "<dev string:x6e2>" + sceneplay.sceneroot.var_f1be55806e0d5f25;
    } else {
      shottext = shottime + "<dev string:x6d7>" + shotname;
    }

    self setdevtext(shottext);
    waitframe();
  }
}

function function_566e3d31befe1331() {
  sceneplay = self;

  if(getdvarint(@ "hash_f98fc73c88850645", 0)) {
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    player = sceneplay scene_play_player();

    if(!isDefined(player)) {
      return;
    }

    if(isarray(player.var_7b353d581f4f612c)) {
      foreach(hud_elem in player.var_7b353d581f4f612c) {
        if(isDefined(hud_elem)) {
          hud_elem destroy();
        }
      }

      player.var_7b353d581f4f612c = function_5713d46873b29625(player.var_7b353d581f4f612c);
    }
  }
}

function function_bbb480647f4f57ab(shotindexes, duration, cameras) {
  if(!isDefined(duration)) {
    duration = 5;
  }

  sceneplay = self;
  player = undefined;

  if(getdvarint(@ "hash_f98fc73c88850645", 0)) {
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    player = sceneplay scene_play_player();

    if(!isDefined(player)) {
      return;
    }

    player function_b7d86476ccd2b3ea();
    y = -35;
    player.var_af0b696397ddfea3 = [];
    str_scene_name = sceneroot.script_scenescriptbundle ?? "<dev string:x24>";

    foreach(arrayindex, shotindex in shotindexes) {
      hudelem = newhudelem();
      str_shot_name = sceneroot.scenedata.scenescriptbundle.shots[shotindex].variant_object.name ?? "<dev string:x24>";
      hudelem.alignx = "<dev string:x67e>";
      hudelem.aligny = "<dev string:x6b9>";
      hudelem.vertalign = "<dev string:x6b9>";
      hudelem.horzalign = "<dev string:x67e>";
      hudelem.font = "<dev string:x6c3>";
      hudelem.x = -25;
      hudelem.y = y;
      hudelem.fontscale = 1;
      hudelem.color = (0, 0.6, 0);
      cameratext = "<dev string:x24>";

      if(isDefined(cameras) && isDefined(cameras[arrayindex])) {
        camerapos = cameras[arrayindex];
        cameratext = "<dev string:x6ed>" + int(camerapos[0]) + "<dev string:xb1>" + int(camerapos[1]) + "<dev string:xb1>" + int(camerapos[2]) + "<dev string:x6f3>";
      }

      hudelem setdevtext(cameratext + "<dev string:x6f9>" + getxhashsourcename(str_scene_name) + "<dev string:x709>" + str_shot_name);
      y -= 20;
      player.var_af0b696397ddfea3[player.var_af0b696397ddfea3.size] = hudelem;
    }
  }

  if(duration >= 0 && isDefined(player)) {
    player utility::delaythreadendon(duration, "<dev string:x710>", &function_b7d86476ccd2b3ea);
  }
}

function function_b7d86476ccd2b3ea() {
  self notify("<dev string:x710>");

  if(!isDefined(self)) {
    return;
  }

  if(isarray(self.var_af0b696397ddfea3)) {
    foreach(hud_elem in self.var_af0b696397ddfea3) {
      if(isDefined(hud_elem)) {
        hud_elem destroy();
      }
    }

    self.var_af0b696397ddfea3 = undefined;
  }
}

function function_c4e717374c36ac3(sceneobjectindex, entitytomatch) {
  var_c809a3d453c003d6 = getdvarint(@ "hash_3bc9bc279e3f772", 0);

  if(isDefined(entitytomatch)) {
    if(var_c809a3d453c003d6 && entitytomatch == level.players[0]) {
      if(var_c809a3d453c003d6 - 1 == sceneobjectindex) {
        return 1;
      } else {
        return 0;
      }
    }
  } else if(var_c809a3d453c003d6) {
    if(var_c809a3d453c003d6 - 1 == sceneobjectindex) {
      return 1;
    } else {
      return 0;
    }
  }

  return 0;
}

function function_24a6aeb21d33a19b() {
  assert(isPlayer(self));

  if(getdvarint(@ "scr_debug_scene", 0) && getdvarint(@ "scr_debug_scene_penetrate", 0)) {
    hits = trace::player_trace_get_all_results(self.origin + (0, 0, 0.01), self.origin, undefined, self);

    foreach(hitinfo in hits) {
      if(isent(hitinfo["<dev string:x734>"])) {
        iprintlnbold("<dev string:x73e>" + hitinfo["<dev string:x734>"] getentitynumber() + (isDefined(hitinfo["<dev string:x734>"].model) ? "<dev string:x750>" + hitinfo["<dev string:x734>"].model : "<dev string:x24>"));
        continue;
      }

      if(getdvarint(@ "scr_debug_scene_penetrate", 0) > 1) {
        iprintlnbold("<dev string:x75c>");
      }
    }
  }
}

# /