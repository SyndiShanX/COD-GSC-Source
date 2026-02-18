/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_53cd49b939f89fd7.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\character_customization;
#using scripts\core_common\custom_class;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace lui_camera;

function private autoexec __init__system__() {
  system::register(#"lui_camera", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.client_menus = associativearray();
  level.var_a14cc36b = [];
  callback::on_localclient_connect(&on_player_connect);
}

function on_player_connect(local_client_num) {
  level thread client_menus(local_client_num);
}

function function_6f3e10a2(var_c12be4a6) {
  if(!isDefined(var_c12be4a6)) {
    return undefined;
  }

  data = function_63446d7f(var_c12be4a6);

  if(isDefined(data) && isDefined(var_c12be4a6.state)) {
    data = isDefined(data.states[var_c12be4a6.state]) ? data.states[var_c12be4a6.state] : data;
  }

  return data;
}

function function_63446d7f(var_c12be4a6) {
  if(!isDefined(var_c12be4a6)) {
    return undefined;
  }

  return level.client_menus[var_c12be4a6.menu_name];
}

function function_1337c436(menu_name, target_name, alt_render_mode = 1) {
  assert(isDefined(level.client_menus[menu_name]), "<dev string:x38>" + menu_name + "<dev string:x41>");
  menu_data = level.client_menus[menu_name];
  assert(!isDefined(menu_data.var_cf15815a), "<dev string:x38>" + menu_name + "<dev string:x6f>");
  menu_data.var_cf15815a = target_name;
  menu_data.var_c27fdce9 = alt_render_mode;
}

function function_daadc836(menu_name, local_client_num) {
  if(isDefined(menu_name)) {
    menu_data = level.client_menus[menu_name];
    character = menu_data.custom_characters[local_client_num];

    if(!isDefined(character) && isDefined(menu_data.var_cf15815a)) {
      model = getent(local_client_num, menu_data.var_cf15815a, "targetname");

      if(!isDefined(model)) {
        model = util::spawn_model(local_client_num, "tag_origin");
        model.targetname = menu_data.var_cf15815a;
      }

      model useanimtree("all_player");
      menu_data.custom_characters[local_client_num] = character_customization::function_dd295310(model, local_client_num, menu_data.var_c27fdce9);
      model hide();
      character = menu_data.custom_characters[local_client_num];
    }
  }

  return character;
}

function function_e41243c1(var_e953aca6) {
  if(!isDefined(var_e953aca6)) {
    return array();
  } else if(isarray(var_e953aca6)) {
    return var_e953aca6;
  }

  return array(var_e953aca6);
}

function function_f603fc4d(menu_name, target_name, xcam, sub_xcam, xcam_frame = undefined, var_1f199068 = undefined, var_2c679be0 = undefined, lerp_time = 0, lut_index = 0) {
  assert(!isDefined(level.client_menus[menu_name]), "<dev string:x38>" + menu_name + "<dev string:x41>");
  level.client_menus[menu_name] = {
    #menu_name: menu_name, #target_name: target_name, #xcam: xcam, #sub_xcam: sub_xcam, #xcam_frame: xcam_frame, #var_1f199068: function_e41243c1(var_1f199068), #var_2c679be0: function_e41243c1(var_2c679be0), #lerp_time: lerp_time, #lut_index: lut_index, #var_e57ed98b: []
  };
  return level.client_menus[menu_name];
}

function function_460e6001(menu_name, session_mode, target_name, xcam, sub_xcam, xcam_frame = undefined, lerp_time = 0, lut_index = 0) {
  assert(isDefined(level.client_menus[menu_name]), "<dev string:x38>" + menu_name + "<dev string:x41>");
  level.client_menus[menu_name].var_e57ed98b[session_mode] = {
    #target_name: target_name, #xcam: xcam, #sub_xcam: sub_xcam, #xcam_frame: xcam_frame, #lerp_time: lerp_time, #lut_index: lut_index
  };
}

function function_969a2881(menu_name, camera_function, has_state, var_1f199068 = undefined, var_2c679be0 = undefined, lut_index = 0, var_ef0a4d1e) {
  assert(!isDefined(level.client_menus[menu_name]), "<dev string:x38>" + menu_name + "<dev string:x41>");
  level.client_menus[menu_name] = {
    #menu_name: menu_name, #camera_function: camera_function, #has_state: has_state, #var_1f199068: function_e41243c1(var_1f199068), #var_2c679be0: function_e41243c1(var_2c679be0), #lut_index: lut_index, #var_ef0a4d1e: var_ef0a4d1e
  };
  return level.client_menus[menu_name];
}

function function_6425472c(menu_name, str_scene, var_f647c5b2 = undefined, var_559c5c3e = undefined, var_3e7fd594 = undefined) {
  assert(!isDefined(level.client_menus[menu_name]), "<dev string:x38>" + menu_name + "<dev string:x41>");
  level.client_menus[menu_name] = {
    #menu_name: menu_name, #str_scene: str_scene, #var_f647c5b2: var_f647c5b2, #var_559c5c3e: var_559c5c3e, #var_3e7fd594: var_3e7fd594, #states: [], #var_b80d1ad4: []
  };
  return level.client_menus[menu_name];
}

function function_17384292(menu_name, callback_fn) {
  assert(isDefined(level.client_menus[menu_name]), "<dev string:x38>" + menu_name + "<dev string:x41>");
  level.client_menus[menu_name].var_a362e358 = callback_fn;
}

function function_866692f8(menu_name, state, str_scene, var_f647c5b2 = undefined, var_559c5c3e = undefined, var_3e7fd594 = undefined) {
  assert(isDefined(level.client_menus[menu_name]), "<dev string:x38>" + menu_name + "<dev string:x41>");
  level.client_menus[menu_name].states[state] = {
    #menu_name: menu_name, #str_scene: str_scene, #var_f647c5b2: var_f647c5b2, #var_559c5c3e: var_559c5c3e, #var_3e7fd594: var_3e7fd594, #var_b80d1ad4: []
  };
}

function function_f852c52c(menu_name, state_name = undefined, var_a180b828 = 1, var_a7c679da = 1) {
  assert(isDefined(level.client_menus[menu_name]), "<dev string:x38>" + menu_name + "<dev string:x41>");

  if(isDefined(state_name)) {
    assert(isDefined(level.client_menus[menu_name].states[state_name]), "<dev string:x38>" + menu_name + "<dev string:xa3>" + state_name + "<dev string:xc1>");
    level.client_menus[menu_name].states[state_name].var_b2ad82eb = var_a180b828;
    level.client_menus[menu_name].states[state_name].var_c9213d93 = var_a7c679da;
    return;
  }

  level.client_menus[menu_name].var_b2ad82eb = var_a180b828;
  level.client_menus[menu_name].var_c9213d93 = var_a7c679da;
}

function function_8950260c(menu_name, from_state = "__default__", to_state = "__default__", str_shot) {
  assert(from_state !== to_state, "<dev string:x38>" + menu_name + "<dev string:xc6>" + (isDefined(from_state) ? "<dev string:xfd>" + from_state : "<dev string:xfd>") + "<dev string:x101>");
  assert(isDefined(level.client_menus[menu_name]), "<dev string:x38>" + menu_name + "<dev string:x41>");
  menu = level.client_menus[menu_name];

  if(from_state != "__default__" && isDefined(menu.states[from_state])) {
    menu.states[from_state].var_b80d1ad4[to_state] = str_shot;
    return;
  }

  menu.states.var_b80d1ad4[to_state] = str_shot;
}

function function_de0ab(menu_name, var_42d665b7) {
  assert(isDefined(level.client_menus[menu_name]));

  if(!isDefined(level.client_menus[menu_name].var_1f199068)) {
    level.client_menus[menu_name].var_1f199068 = [];
  } else if(!isarray(level.client_menus[menu_name].var_1f199068)) {
    level.client_menus[menu_name].var_1f199068 = array(level.client_menus[menu_name].var_1f199068);
  }

  level.client_menus[menu_name].var_1f199068[level.client_menus[menu_name].var_1f199068.size] = var_42d665b7;
}

function function_13b48f53(menu_name, var_34fd6dc0) {
  assert(isDefined(level.client_menus[menu_name]));

  if(!isDefined(level.client_menus[menu_name].var_2c679be0)) {
    level.client_menus[menu_name].var_2c679be0 = [];
  } else if(!isarray(level.client_menus[menu_name].var_2c679be0)) {
    level.client_menus[menu_name].var_2c679be0 = array(level.client_menus[menu_name].var_2c679be0);
  }

  level.client_menus[menu_name].var_2c679be0[level.client_menus[menu_name].var_2c679be0.size] = var_34fd6dc0;
}

function function_ffa1213e(var_8de6b51a, var_e3315405) {
  var_cd1475a5 = function_6f3e10a2(var_8de6b51a);
  new_menu = function_6f3e10a2(var_e3315405);

  if(var_cd1475a5.menu_name === new_menu.menu_name) {
    return var_cd1475a5.var_b80d1ad4[isDefined(var_e3315405.state) ? var_e3315405.state : "__default__"];
  }

  return undefined;
}

function setup_menu(local_client_num, var_8de6b51a, var_e3315405) {
  var_cd1475a5 = function_6f3e10a2(var_8de6b51a);
  var_a8080f41 = function_6f3e10a2(var_8de6b51a);
  new_menu = function_6f3e10a2(var_e3315405);
  var_f81682ee = function_63446d7f(var_e3315405);
  var_fdb39764 = var_cd1475a5.menu_name === new_menu.menu_name;
  var_d2bf9838 = var_cd1475a5.str_scene !== level.var_6dfc0bcf;
  var_ad156153 = function_daadc836(var_cd1475a5.menu_name, local_client_num);
  var_9168605c = function_daadc836(new_menu.menu_name, local_client_num);

  if(isDefined(var_cd1475a5)) {
    if(!var_fdb39764) {
      if(isDefined(var_a8080f41.var_2c679be0)) {
        foreach(fn in var_a8080f41.var_2c679be0) {
          if(is_true(var_a8080f41.var_ef0a4d1e)) {
            level[[fn]](local_client_num, var_a8080f41);
            continue;
          }

          level thread[[fn]](local_client_num, var_a8080f41);
        }
      }

      if(!var_fdb39764 && isDefined(var_cd1475a5.str_scene) && var_d2bf9838) {
        outro = isDefined(var_cd1475a5.var_3e7fd594) ? var_cd1475a5.var_3e7fd594 : var_a8080f41.var_3e7fd594;

        if(isDefined(outro)) {
          function_7851a662(var_cd1475a5, outro);
        } else {
          function_4c61e7c(var_cd1475a5);
        }
      }

      level notify(var_8de6b51a.menu_name + "_closed");

      if(isDefined(var_a8080f41.camera_function)) {
        stopmaincamxcam(local_client_num);
      } else if(isDefined(var_a8080f41.xcam)) {
        stopmaincamxcam(local_client_num);
      }

      if(isDefined(var_ad156153) && var_ad156153 !== var_9168605c) {
        [[var_ad156153]] - > hide_model();
        [[var_ad156153]] - > function_39a68bf2();
      }
    }
  }

  if(isDefined(new_menu)) {
    if((isDefined(var_cd1475a5.var_b2ad82eb) ? var_cd1475a5.var_b2ad82eb : var_a8080f41.var_b2ad82eb) !== (isDefined(new_menu.var_b2ad82eb) ? new_menu.var_b2ad82eb : var_f81682ee.var_b2ad82eb)) {
      if(is_true(isDefined(new_menu.var_b2ad82eb) ? new_menu.var_b2ad82eb : var_f81682ee.var_b2ad82eb)) {
        customclass::function_831397a7(local_client_num, is_true(isDefined(new_menu.var_c9213d93) ? new_menu.var_c9213d93 : var_f81682ee.var_c9213d93));
      } else {
        customclass::function_415febc4(local_client_num);
      }
    }

    if(isDefined(var_e3315405.charactermode) && isDefined(var_9168605c)) {
      [[var_9168605c]] - > set_character_mode(var_e3315405.charactermode);
    }

    if(isDefined(var_f81682ee.var_a362e358)) {
      level thread[[var_f81682ee.var_a362e358]](local_client_num, var_e3315405.menu_name, var_e3315405.state);
    }

    var_78594590 = function_6d469004(var_e3315405, var_8de6b51a);

    if(var_fdb39764) {
      if(isDefined(new_menu.str_scene)) {
        level thread function_4e55f369(var_8de6b51a, var_e3315405, var_78594590);
      } else if(isDefined(new_menu.camera_function)) {
        level thread[[new_menu.camera_function]](local_client_num, var_e3315405.menu_name, var_e3315405.state);
      }

      return;
    }

    if(isDefined(var_9168605c)) {
      [[var_9168605c]] - > show_model();
    }

    if(isDefined(var_f81682ee.lut_index)) {
      setDvar(#"vc_lut", var_f81682ee.lut_index);
    }

    if(isDefined(var_f81682ee.camera_function)) {
      if(var_f81682ee.has_state === 1) {
        level thread[[var_f81682ee.camera_function]](local_client_num, var_e3315405.menu_name, var_e3315405.state);
      } else {
        level thread[[var_f81682ee.camera_function]](local_client_num, var_e3315405.menu_name);
      }
    } else if(isDefined(var_f81682ee.xcam)) {
      camera_data = isDefined(var_f81682ee.var_e57ed98b[currentsessionmode()]) ? var_f81682ee.var_e57ed98b[currentsessionmode()] : var_f81682ee;
      camera_ent = struct::get(camera_data.target_name);

      if(isDefined(camera_ent)) {
        playmaincamxcam(local_client_num, camera_data.xcam, camera_data.lerp_time, camera_data.sub_xcam, "", camera_ent.origin, camera_ent.angles);
      }
    }

    if(isDefined(new_menu.str_scene) && (new_menu.var_559c5c3e !== var_cd1475a5.var_559c5c3e || new_menu.str_scene !== var_cd1475a5.str_scene)) {
      level thread function_4aa3b942(new_menu, var_78594590);
    }

    if(isDefined(var_f81682ee.var_1f199068)) {
      foreach(fn in var_f81682ee.var_1f199068) {
        level thread[[fn]](local_client_num, var_f81682ee, var_a8080f41);
      }
    }
  }
}

function function_6d469004(var_e3315405, var_8de6b51a) {
  var_386948ca = level.client_menus[var_e3315405.menu_name].var_386948ca;

  if(isarray(var_386948ca)) {
    foreach(var_2e96e768 in var_386948ca) {
      if(var_2e96e768.var_8176b3c === var_8de6b51a.menu_name && var_2e96e768.var_5e806f4a === var_8de6b51a.state && var_2e96e768.var_a62e11c1 === var_e3315405.state) {
        return var_2e96e768.var_b1e821c5;
      }
    }
  }
}

function function_55d56772(var_7271d7d6, var_8176b3c, var_5e806f4a, var_b5964062, var_a62e11c1) {
  assert(isDefined(level.client_menus[var_b5964062]), "<dev string:x38>" + var_b5964062 + "<dev string:x41>");
  var_2e96e768 = {
    #var_a62e11c1: var_a62e11c1, #var_8176b3c: var_8176b3c, #var_5e806f4a: var_5e806f4a, #var_b1e821c5: var_7271d7d6
  };

  if(!isDefined(level.client_menus[var_b5964062].var_386948ca)) {
    level.client_menus[var_b5964062].var_386948ca = [];
  } else if(!isarray(level.client_menus[var_b5964062].var_386948ca)) {
    level.client_menus[var_b5964062].var_386948ca = array(level.client_menus[var_b5964062].var_386948ca);
  }

  if(!isinarray(level.client_menus[var_b5964062].var_386948ca, var_2e96e768)) {
    level.client_menus[var_b5964062].var_386948ca[level.client_menus[var_b5964062].var_386948ca.size] = var_2e96e768;
  }
}

function private function_2a35a5f(var_a14cc36b) {
  var_12fe97ab = "<dev string:xfd>";

  foreach(menu_item in var_a14cc36b) {
    var_12fe97ab += "<dev string:x110>" + (isDefined(menu_item.menu_name) ? "<dev string:xfd>" + menu_item.menu_name : ishash(menu_item.menu_name) ? function_9e72a96(menu_item.menu_name) : "<dev string:xfd>") + "<dev string:x115>";
  }

  return var_12fe97ab;
}

function client_menus(local_client_num) {
  level endon(#"disconnect");
  level.var_a14cc36b[local_client_num] = [];
  clientmenustack = level.var_a14cc36b[local_client_num];

  while(true) {
    waitresult = level waittill("menu_change" + local_client_num);
    menu_name = waitresult.menu;
    status = waitresult.status;
    state = waitresult.state;
    menu_index = undefined;

    for(i = 0; i < clientmenustack.size; i++) {
      if(clientmenustack[i].menu_name == menu_name) {
        menu_index = i;
        break;
      }
    }

    if(status === "closeToMenu" && isDefined(menu_index)) {
      topmenu = undefined;

      for(i = 0; i < menu_index; i++) {
        popped = array::pop(clientmenustack, 0, 0);

        if(!isDefined(topmenu)) {
          topmenu = popped;
        }
      }

      setup_menu(local_client_num, topmenu, clientmenustack[0]);
      continue;
    }

    statechange = isDefined(menu_index) && status !== "closed" && clientmenustack[menu_index].state !== state && !(!isDefined(clientmenustack[menu_index].state) && !isDefined(state));
    updateonly = statechange && menu_index !== 0;

    if(updateonly) {
      clientmenustack[i].state = state;
      continue;
    }

    if(status === "closed" && isDefined(menu_index)) {
      if(menu_index != 0) {
        var_12fe97ab = function_2a35a5f(clientmenustack);
        assertmsg("<dev string:x11a>" + local_client_num + "<dev string:x125>" + menu_name + "<dev string:x13c>" + var_12fe97ab);
      }

      if(menu_index == 0) {
        popped = array::pop(clientmenustack, 0, 0);
        setup_menu(local_client_num, popped, clientmenustack[0]);
      }

      continue;
    }

    if(status === "opened" && !isDefined(menu_index)) {
      menu_data = {
        #menu_name: menu_name, #state: state, #charactermode: waitresult.mode
      };
      lastmenu = clientmenustack.size < 0 ? undefined : clientmenustack[0];
      setup_menu(local_client_num, lastmenu, menu_data);
      array::push_front(clientmenustack, menu_data);
      continue;
    }

    if(isDefined(menu_index) && statechange) {
      if(menu_index != 0) {
        var_12fe97ab = function_2a35a5f(clientmenustack);
        assertmsg("<dev string:x11a>" + local_client_num + "<dev string:x186>" + menu_name + "<dev string:x1ad>" + var_12fe97ab);
      }

      var_80c09ee8 = clientmenustack[0];
      clientmenustack[0] = {
        #menu_name: menu_name, #state: state, #charactermode: waitresult.mode
      };
      setup_menu(local_client_num, var_80c09ee8, clientmenustack[0]);
    }
  }
}

function function_befcd4f0(str_scene, var_f647c5b2, var_559c5c3e, var_472bee8f, var_b1e821c5) {
  assert(!isDefined(var_f647c5b2) || scene::function_9730988a(str_scene, var_f647c5b2), "<dev string:x1e9>" + str_scene + "<dev string:x1f3>" + (isDefined(var_f647c5b2) ? "<dev string:xfd>" + var_f647c5b2 : "<dev string:xfd>"));
  assert(!isDefined(var_559c5c3e) || scene::function_9730988a(str_scene, var_559c5c3e), "<dev string:x1e9>" + str_scene + "<dev string:x214>" + (isDefined(var_559c5c3e) ? "<dev string:xfd>" + var_559c5c3e : "<dev string:xfd>"));
  level notify(#"hash_46855140938f532c");
  level endon(#"hash_46855140938f532c");

  if(isDefined(var_472bee8f)) {
    level endon(var_472bee8f);
  }

  if(level.var_6dfc0bcf !== str_scene) {
    level scene::stop(level.var_6dfc0bcf);
  } else if(isDefined(level.var_6dfc0bcf)) {
    level scene::cancel(level.var_6dfc0bcf);
  }

  level.var_6dfc0bcf = str_scene;

  if(isDefined(var_f647c5b2)) {
    level scene::play(str_scene, var_f647c5b2, undefined, undefined, undefined, undefined, var_b1e821c5);
    var_b1e821c5 = undefined;
  }

  if(isDefined(var_559c5c3e)) {
    level thread scene::play(str_scene, var_559c5c3e, undefined, undefined, undefined, undefined, var_b1e821c5);
    return;
  }

  level thread scene::play(str_scene, undefined, undefined, undefined, undefined, undefined, var_b1e821c5);
}

function function_5993fa03(str_scene, str_shot, time, var_472bee8f, var_78594590) {
  level notify(#"hash_46855140938f532c");
  level endon(#"hash_46855140938f532c");

  if(isDefined(var_472bee8f)) {
    level endon(var_472bee8f);
  }

  level thread scene::play_from_time(str_scene, str_shot, undefined, time, 1, 1, var_78594590);
}

function function_4aa3b942(new_menu, var_b1e821c5) {
  function_befcd4f0(new_menu.str_scene, new_menu.var_f647c5b2, new_menu.var_559c5c3e, new_menu.menu_name + "_closed", var_b1e821c5);
}

function function_7851a662(var_cd1475a5, shot, var_b1e821c5) {
  function_befcd4f0(var_cd1475a5.str_scene, shot, undefined, var_cd1475a5.menu_name + "_closed", var_b1e821c5);
}

function function_4c61e7c(var_cd1475a5) {
  level notify(#"hash_46855140938f532c");
  level endon(var_cd1475a5.menu_name + "_closed");
  level endon(#"hash_46855140938f532c");
  level.var_6dfc0bcf = undefined;
  level scene::stop(var_cd1475a5.str_scene, 1);
}

function function_4e55f369(var_8de6b51a, var_e3315405, var_b1e821c5) {
  level notify(#"hash_46855140938f532c");
  new_menu = function_6f3e10a2(var_e3315405);
  var_ffb43fb8 = function_ffa1213e(var_8de6b51a, var_e3315405);

  if(isDefined(var_ffb43fb8)) {
    level endon(#"hash_46855140938f532c");
    level endon(new_menu.menu_name + "_closed");
    level scene::play(new_menu.str_scene, var_ffb43fb8, undefined, undefined, undefined, undefined, var_b1e821c5);
    return;
  }

  var_cd1475a5 = function_6f3e10a2(var_8de6b51a);

  if(var_cd1475a5.str_scene !== new_menu.str_scene || var_cd1475a5.var_559c5c3e !== new_menu.var_559c5c3e) {
    new_menu = function_6f3e10a2(var_e3315405);
    function_4aa3b942(new_menu, var_b1e821c5);
  }
}

function is_current_menu(local_client_num, menu_name, state = undefined) {
  if(!isDefined(level.var_a14cc36b[local_client_num]) || level.var_a14cc36b[local_client_num].size == 0) {
    return false;
  }

  return level.var_a14cc36b[local_client_num][0].menu_name === menu_name && (!isDefined(state) || level.var_a14cc36b[local_client_num][0].state === state);
}