/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_32b18d9fb454babf.gsc
***********************************************/

#using script_13d5d0aa9140d362;
#using script_16b1b77a76492c6a;
#using script_176597095ddfaa17;
#using script_2618e0f3e5e11649;
#using script_355c6e84a79530cb;
#using script_3b2abb7986f4ae7c;
#using script_437ce686d29bb81b;
#using script_4ce5d94e8c797350;
#using script_5b2a3c052bf17d0e;
#using script_7b1cd3908a825fdd;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\objective_manager;
#using scripts\zm_common\zm_destination_manager;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_utility_zsurvival;
#using scripts\zm_common\zm_vo;
#namespace namespace_18bbc38e;

function private autoexec __init__system__() {
  system::register(#"hash_5bcba15330839867", &preinit, undefined, undefined, #"zm_destination_manager");
}

function private preinit() {
  level.contentmanager.var_64a75da7 = &function_64a75da7;
  level.contentmanager.var_dbc06c4b = &function_4824f1b9;
  level.contentmanager.var_314d6e9b = &function_314d6e9b;
  level.contentmanager.var_a3205267 = &function_a3205267;
  level.contentmanager.var_62a42ce = &function_62a42ce;
  level callback::add_callback(#"hash_565739346fc951ae", &function_74c76da9);
  level callback::add_callback(#"hash_276921163232533", &function_85e8bf9e);
}

function private function_64a75da7() {
  if(getdvarint(#"hash_33b0be96bf3cd69a", 0)) {
    level.contentmanager.var_d60029a6 = array(level.contentmanager.var_5f2429b1);
    level.contentmanager.currentdestination = level.contentmanager.var_5f2429b1;
    level flag::set(#"hash_7ace2c0d668c5128");
    level zm_destination_manager::activate(level.contentmanager.var_5f2429b1);
    level flag::wait_till(#"all_players_spawned");

    if(!isDefined(level.contentmanager.var_c4181ea)) {
      level namespace_73df937d::spawn_safehouse(level.contentmanager.var_5f2429b1);

      foreach(player in getplayers()) {
        player setorigin(level.contentmanager.var_c4181ea.origin);
      }
    }

    level waittill(#"safehouse_claimed");
    level thread namespace_591b4396::function_7c05a985(level.contentmanager.var_5f2429b1);
    return;
  }

  level.contentmanager.var_d60029a6 = function_d4de820e();
}

function function_4824f1b9() {
  if(getdvarint(#"hash_15b141da1584bd0d", 1)) {
    zm_utility_zsurvival::end_match(0);
    return true;
  }

  return false;
}

function function_314d6e9b(destination) {
  level endon(#"game_ended");
  level flag::wait_till_clear(#"hash_2ae96d681e4ea79f");
  level flag::wait_till_timeout(30, #"spawn_safehouse");
  level thread namespace_73df937d::spawn_safehouse(destination);
  level flag::clear(#"spawn_safehouse");
  level waittill(#"safehouse_claimed");
}

function function_a3205267(destination) {
  level flag::wait_till(#"hash_10679ff0bf4d6c8d");
  level thread namespace_ce1f29cc::function_6b885d72(destination);
  level thread function_cef826da(destination);

  if(is_true(getgametypesetting(#"hash_59854c1f30538261"))) {
    namespace_d0ab5955::function_d4dec4e8(destination);
  }

  level flag::wait_till(#"intro_scene_done");
}

function function_62a42ce(destination) {
  level thread namespace_e51c1e80::spawn_vehicles(destination);
  function_f169181c(destination);
  namespace_957938f0::function_4317fa79(destination);
  namespace_f0b43eb5::function_2b436554(destination);
  level thread helicopter_escape::function_95c09591(destination);
  level thread namespace_2c949ef8::function_c0966bb1(destination);
  function_b3dda48(destination);
  function_a6f84bf(destination);
}

function function_74c76da9(destination) {
  level thread namespace_ce1f29cc::deactivate_hotzones(destination);
  namespace_d0ab5955::function_f1ad7968(destination);
  zm_utility_zsurvival::function_7c97e961(level.var_b48509f9 + 1);
  level thread namespace_e51c1e80::function_c772bd2c(destination);
}

function private function_cef826da(destination) {
  var_df4a4d76 = destination.locations;

  if(isDefined(level.contentmanager.nextspawn)) {
    var_df4a4d76 = arraysortclosest(var_df4a4d76, level.contentmanager.nextspawn.origin);
  }

  foreach(location in var_df4a4d76) {
    var_7ca1bc80 = location.instances[# "explore_chests_large"];

    if(isDefined(var_7ca1bc80)) {
      content_manager::spawn_instance(var_7ca1bc80);
    }

    var_20780a3a = location.instances[# "explore_chests"];

    if(isDefined(var_20780a3a)) {
      content_manager::spawn_instance(var_20780a3a);
    }

    var_20780a3a = location.instances[# "explore_chests_small"];

    if(isDefined(var_20780a3a)) {
      content_manager::spawn_instance(var_20780a3a);
    }

    var_bf74f01b = location.instances[# "loot_pods"];

    if(isDefined(var_bf74f01b)) {
      content_manager::spawn_instance(var_bf74f01b);
    }

    var_c3d93d9f = location.instances[# "harvest_essence"];

    if(isDefined(var_c3d93d9f)) {
      content_manager::spawn_instance(var_c3d93d9f);
    }

    var_c3d93d9f = location.instances[# "harvest_essence_small"];

    if(isDefined(var_c3d93d9f)) {
      content_manager::spawn_instance(var_c3d93d9f);
    }

    var_a1f9a8cd = location.instances[# "harvest_scrap"];

    if(isDefined(var_a1f9a8cd)) {
      content_manager::spawn_instance(var_a1f9a8cd);
    }

    util::wait_network_frame();
  }

  level flag::set(#"hash_5aca8d24a1f56ee1");
}

function private function_f169181c(destination) {
  level.var_3ed04e02 = [];
  var_90e97a54 = level.contentmanager.var_ab00156;

  if(getdvarint(#"hash_320c8696fac70f53", 0)) {
    var_90e97a54 = array(#"black_chest");
  }

  n_to_spawn = randomintrangeinclusive(3, 3);
  n_spawned = 0;

  while(var_90e97a54.size) {
    str_type = var_90e97a54[randomint(var_90e97a54.size)];
    arrayremovevalue(var_90e97a54, str_type, 0);
    b_spawned = function_9b9c7696(destination, str_type);

    if(is_true(b_spawned)) {
      n_spawned++;
    }

    if(n_spawned >= n_to_spawn && !getdvarint(#"hash_730311c63805303a", 0)) {
      break;
    }
  }

  function_66855ea6(destination, #"demented_echo");
  function_66855ea6(destination, #"upgrade_machines");
  function_66855ea6(destination, #"radio_tuning");
  function_66855ea6(destination, #"hash_2ff0859bce056c66");
  function_66855ea6(destination, #"orb_follow");
}

function private function_66855ea6(destination, str_type) {
  var_df4a4d76 = arraycopy(destination.locations);

  while(var_df4a4d76.size) {
    location = array::function_a3b0f814(var_df4a4d76);
    var_97aab885 = location.instances[str_type];

    if(isDefined(var_97aab885)) {
      var_e7f5b3e0 = 1;

      if(!getdvarint(#"hash_730311c63805303a", 0)) {
        if(isDefined(var_97aab885.var_501bc8c9)) {
          var_2685dd6d = strtok(var_97aab885.var_501bc8c9, ", ");

          foreach(var_a2593226 in var_2685dd6d) {
            if(level.contentmanager.var_1fcbdf50 === var_a2593226) {
              var_e7f5b3e0 = 0;
              break;
            }
          }
        }
      }

      if(var_e7f5b3e0) {
        content_manager::spawn_instance(var_97aab885);
      }

      if(getdvarint(#"hash_730311c63805303a", 0)) {
        continue;
      }

      break;
    }
  }
}

function private function_9b9c7696(destination, str_type) {
  if(str_type === # "hulking_summoner" && level.var_b48509f9 < 2 && !getdvarint(#"hash_730311c63805303a", 0) && !is_true(getgametypesetting(#"hash_1e1a5ebefe2772ba"))) {
    return 0;
  }

  var_ba9835cd = [];
  var_dc84dad0 = [];

  if(!isDefined(level.var_3ed04e02)) {
    level.var_3ed04e02 = [];
  }

  if(!isDefined(level.var_b8c0d7a2)) {
    level.var_b8c0d7a2 = 10000;
  }

  if(!isDefined(level.var_e6b49685)) {
    level.var_e6b49685 = 5000;
  }

  s_player_start = level.var_7767cea8[0];

  foreach(s_location in destination.locations) {
    s_instance = s_location.instances[str_type];

    if(isDefined(s_instance)) {
      var_e7f5b3e0 = 1;

      if(!isDefined(var_dc84dad0)) {
        var_dc84dad0 = [];
      } else if(!isarray(var_dc84dad0)) {
        var_dc84dad0 = array(var_dc84dad0);
      }

      var_dc84dad0[var_dc84dad0.size] = s_instance;

      if(!getdvarint(#"hash_730311c63805303a", 0) || getdvarint(#"hash_4c770de453dafff9", 0)) {
        if(isDefined(s_instance.var_501bc8c9)) {
          var_2685dd6d = strtok(s_instance.var_501bc8c9, ", ");

          foreach(var_a2593226 in var_2685dd6d) {
            if(level.contentmanager.var_1fcbdf50 === var_a2593226) {
              var_e7f5b3e0 = 0;
              break;
            }
          }
        }

        foreach(var_6be26b52 in level.var_3ed04e02) {
          if(distancesquared(s_instance.origin, var_6be26b52.origin) < sqr(level.var_b8c0d7a2)) {
            var_e7f5b3e0 = 0;
            break;
          }
        }

        if(var_e7f5b3e0 && isDefined(s_player_start) && distancesquared(s_player_start.origin, s_instance.origin) < sqr(level.var_e6b49685)) {
          var_e7f5b3e0 = 0;
        }
      }

      if(var_e7f5b3e0) {
        if(!isDefined(var_ba9835cd)) {
          var_ba9835cd = [];
        } else if(!isarray(var_ba9835cd)) {
          var_ba9835cd = array(var_ba9835cd);
        }

        var_ba9835cd[var_ba9835cd.size] = s_instance;
      }
    }
  }

  if(is_true(getgametypesetting(#"hash_1e1a5ebefe2772ba")) && str_type === # "hulking_summoner" && var_ba9835cd.size == 0) {
    var_ba9835cd = var_dc84dad0;
  }

  var_ba9835cd = array::randomize(var_ba9835cd);
  b_spawned = 0;

  foreach(s_instance in var_ba9835cd) {
    if(isDefined(s_instance)) {
      content_manager::spawn_instance(s_instance);

      if(!isDefined(level.var_3ed04e02)) {
        level.var_3ed04e02 = [];
      } else if(!isarray(level.var_3ed04e02)) {
        level.var_3ed04e02 = array(level.var_3ed04e02);
      }

      level.var_3ed04e02[level.var_3ed04e02.size] = s_instance;
      b_spawned = 1;

      if(!getdvarint(#"hash_730311c63805303a", 0)) {
        break;
      }
    }
  }

  return b_spawned;
}

function private function_d4de820e() {
  if(is_true(getdvarint(#"hash_688e3b3254c8a895", 0))) {
    var_89d7bd4 = [];
    var_eef00fc6 = getdvarstring(#"hash_68a0047e00d7d34c");

    if(var_eef00fc6 !== "") {
      var_89d7bd4[var_89d7bd4.size] = var_eef00fc6;
    }

    var_53975913 = getdvarstring(#"hash_68a0077e00d7d865");

    if(var_53975913 !== "") {
      var_89d7bd4[var_89d7bd4.size] = var_53975913;
    }

    var_6155748f = getdvarstring(#"hash_68a0067e00d7d6b2");

    if(var_6155748f !== "") {
      var_89d7bd4[var_89d7bd4.size] = var_6155748f;
    }

    var_18386256 = getdvarstring(#"hash_68a0017e00d7ce33");

    if(var_18386256 !== "") {
      var_89d7bd4[var_89d7bd4.size] = var_18386256;
    }

    var_4607bdf4 = getdvarstring(#"hash_68a0007e00d7cc80");

    if(var_4607bdf4 !== "") {
      var_89d7bd4[var_89d7bd4.size] = var_4607bdf4;
    }

    var_2b588ed4 = 1;
  } else {
    var_2b588ed4 = isDefined(getgametypesetting(#"hash_352d47f1b1b17cc5")) ? getgametypesetting(#"hash_352d47f1b1b17cc5") : 0;
  }

  if(var_2b588ed4) {
    switch (var_2b588ed4) {
      case 1:
        var_13f49a56 = array("objective_sanatorium_defend_console", "objective_zoo_retrieval", "kill_hvt_ski_raz");
        break;
      case 2:
        var_13f49a56 = array("objective_sanatorium_defend_console", "objective_zoo_retrieval", "kill_hvt_ski_raz");
        break;
      case 3:
        var_13f49a56 = var_89d7bd4;
        break;
      default:
        return;
    }

    var_a3c51b07 = [];

    for(i = 0; i < var_13f49a56.size; i++) {
      instance = struct::get(var_13f49a56[i]);
      location = struct::get(instance.target);
      destination = struct::get(location.target);
      assert(destination.variantname == # "content_destination");
      script = content_manager::get_script(instance.content_script_name);
      category = script.objectivecategory;
      destination.var_e859e591 = [];
      destination.var_e859e591[category] = array(instance);
      var_a3c51b07[i] = destination;
    }

    a_spawns = zm_destination_manager::function_f3be07d7(var_a3c51b07[0]);
    var_58b02068 = struct::get(a_spawns[0].target, "targetname");
    level.var_7767cea8 = array(var_58b02068);
    level.var_7767cea8[0].spawns = a_spawns;
    zm_destination_manager::function_123b048f(var_a3c51b07[0]);
    return var_a3c51b07;
  }
}

function private function_b3dda48(s_destination) {
  if(!zm_utility::is_ee_enabled() || !getgametypesetting(#"hash_4fed85baf6c05ff1")) {
    return;
  }

  foreach(s_location in s_destination.locations) {
    if(isDefined(s_location.instances[# "amplify"])) {
      content_manager::spawn_instance(s_location.instances[# "amplify"]);
    }

    if(isDefined(s_location.instances[# "hash_1f5e56ff4b3c50e2"])) {
      content_manager::spawn_instance(s_location.instances[# "hash_1f5e56ff4b3c50e2"]);
    }

    if(isDefined(s_location.instances[# "observe"])) {
      content_manager::spawn_instance(s_location.instances[# "observe"]);
    }
  }
}

function function_a6f84bf(s_destination) {
  var_39539c05 = zm_utility::is_ee_enabled();
  var_95613111 = # "hash_50cc93a10c9d2175";
  var_a0ab1f0d = getgametypesetting(var_95613111);

  var_39539c05 = getdvarint(#"zm_ee_enabled", 0);
  var_a0ab1f0d = 1;

  if(!var_39539c05 || !var_a0ab1f0d) {
    return;
  }

  var_b96bbac7 = [];

  foreach(s_location in s_destination.locations) {
    if(isDefined(s_location.instances[# "hash_18be5193d8310f84"])) {
      content_manager::spawn_instance(s_location.instances[# "hash_18be5193d8310f84"]);
    }

    if(isDefined(s_location.instances[# "hash_18be5493d831149d"])) {
      if(!isDefined(var_b96bbac7)) {
        var_b96bbac7 = [];
      } else if(!isarray(var_b96bbac7)) {
        var_b96bbac7 = array(var_b96bbac7);
      }

      var_b96bbac7[var_b96bbac7.size] = s_location.instances[# "hash_18be5493d831149d"];
    }

    if(isDefined(s_location.instances[# "hash_18be5393d83112ea"])) {
      content_manager::spawn_instance(s_location.instances[# "hash_18be5393d83112ea"]);
    }

    if(isDefined(s_location.instances[# "hash_18be4d93d83108b8"])) {
      content_manager::spawn_instance(s_location.instances[# "hash_18be4d93d83108b8"]);
    }
  }

  if(var_b96bbac7.size) {
    content_manager::spawn_instance(array::random(var_b96bbac7));
  }
}

function function_8e64a2b1(var_6e542c1a, var_a3b3f1b, var_8f08f2fe = # "") {
  assert(isDefined(var_6e542c1a) && isDefined(var_a3b3f1b), "<dev string:x38>");
  level.var_3d1ef3ae = var_6e542c1a;
  level.var_edb2bb69 = ishash(var_a3b3f1b) ? var_a3b3f1b : hash(var_a3b3f1b);
  level.var_1b2466fe = ishash(var_8f08f2fe) ? var_8f08f2fe : hash(var_8f08f2fe);
}

function function_85e8bf9e(params) {
  function_e97f828e();
}

function function_2ff643df(&var_775479a4, var_71f7c7c4, &var_3d3626a4) {
  arrayremovevalue(var_3d3626a4, level.script);
  num = int(max(var_71f7c7c4, var_3d3626a4.size));
  var_b89a70a = [];

  for(i = 0; i < num - var_3d3626a4.size; i++) {
    var_b89a70a[var_b89a70a.size] = array::pop(var_775479a4, 0, 0);
  }

  var_b89a70a = arraycombine(var_b89a70a, var_3d3626a4, 0, 0);
  var_b89a70a = array::randomize(var_b89a70a);

  for(i = 0; i < var_775479a4.size; i++) {
    var_b89a70a[var_b89a70a.size] = var_775479a4[i];
  }

  return var_b89a70a;
}

function function_bd104a73() {
  var_775479a4 = [];
  var_891aaa22 = [];

  foreach(map in function_3cdae979()) {
    fields = getmapfields(map.name);
    var_d0972d81 = !sessionmodeisonlinegame() && (!isDefined(fields.var_694983ad) || getdvarint(fields.var_694983ad, 0));
    var_bb63d618 = sessionmodeisonlinegame() && is_true(getgametypesetting(map.gts));

    if(!getdvarint(#"hash_1613782fc04deff", 0)) {
      var_d0972d81 = 1;
    }

    if(map.name !== level.script && (var_bb63d618 || var_d0972d81)) {
      if(is_true(map.prioritized)) {
        var_891aaa22[var_891aaa22.size] = map.name;
        continue;
      }

      var_775479a4[var_775479a4.size] = map.name;
    }
  }

  var_775479a4 = array::randomize(var_775479a4);

  if(var_891aaa22.size) {
    var_775479a4 = function_2ff643df(var_775479a4, 4, var_891aaa22);
  }

  arrayinsert(var_775479a4, level.script, 0);
  var_433a73b4 = [];
  var_dfe29608 = [];

  foreach(objective in level.var_1d153516) {
    var_877f4c5 = 1;
    structs = content_manager::function_4485ab6d("objectiveCategory", objective);

    foreach(script_struct in structs) {
      if(isDefined(script_struct.var_4b7d58a)) {
        var_877f4c5 &= is_true(getgametypesetting(script_struct.var_4b7d58a)) || is_true(getdvarint(script_struct.var_4b7d58a, 0));
      }
    }

    if(!var_877f4c5) {
      continue;
    }

    var_433a73b4[var_433a73b4.size] = objective;

    if(isDefined(level.var_f8197880[objective])) {
      var_ac58e8e0 = {
        #list: array::randomize(level.var_f8197880[objective]), #index: 0
      };
      var_dfe29608[objective] = var_ac58e8e0;
    }
  }

  var_433a73b4 = array::randomize(var_433a73b4);
  level.contentmanager.var_dc858a58 = {
    #list: arraycopy(var_775479a4), #index: 0
  };
  level.contentmanager.var_407236bf = {
    #list: var_433a73b4, #index: 0
  };
  level.contentmanager.var_9614b1d2 = var_dfe29608;
}

function function_eb705b60() {
  level.contentmanager.var_dc858a58 = namespace_cf6efd05::function_8864b117();
  var_54187df8 = namespace_cf6efd05::function_b12c9424();
  level.contentmanager.var_407236bf = var_54187df8.var_407236bf;
  level.contentmanager.var_9614b1d2 = var_54187df8.var_f203d5e2;
}

function function_369007bb() {
  if(level.var_490ade6 === # "ee") {
    return;
  }

  if(isarray(level.contentmanager.destinations)) {
    destination = undefined;

    foreach(destination in level.contentmanager.destinations) {
      if(isDefined(destination)) {
        break;
      }
    }

    if(!isDefined(destination)) {
      return;
    }

    var_6d9b3bf9 = undefined;

    for(i = 0; i < level.contentmanager.var_407236bf.list.size; i++) {
      var_6d9b3bf9 = level.contentmanager.var_407236bf.list[level.contentmanager.var_407236bf.index];

      if(objective_exists(destination, var_6d9b3bf9)) {
        break;
      }

      if(!isinarray(level.contentmanager.var_691808e8, var_6d9b3bf9)) {
        level.contentmanager.var_691808e8[level.contentmanager.var_691808e8.size] = var_6d9b3bf9;
      }

      level.contentmanager.var_407236bf.index = (level.contentmanager.var_407236bf.index + 1) % level.contentmanager.var_407236bf.list.size;
    }

    println("<dev string:xa6>");

    if(isDefined(var_6d9b3bf9)) {
      var_8b66998e = level.contentmanager.var_9614b1d2[var_6d9b3bf9];

      if(isDefined(var_8b66998e)) {
        var_6da361da = undefined;

        for(j = 0; j < var_8b66998e.list.size; j++) {
          if(objective_exists(destination, var_6d9b3bf9, var_8b66998e.list[var_8b66998e.index])) {
            var_6da361da = var_8b66998e.list[var_8b66998e.index];
            break;
          }

          var_8b66998e.index = (var_8b66998e.index + 1) % var_8b66998e.list.size;
        }

        level.var_490ade6 = var_6d9b3bf9;
        level.var_c73744cc = var_6da361da;
        return;
      }

      level.var_490ade6 = var_6d9b3bf9;
    }
  }
}

function function_e97f828e() {
  if(!namespace_cf6efd05::function_85b812c9()) {
    function_bd104a73();
  } else {
    function_eb705b60();
  }

  level.contentmanager.var_691808e8 = [];

  if(getdvarstring(#"hash_4c7a7b0813c6765d") !== "") {
    function_19e6d9ca(hash(getdvarstring(#"hash_4c7a7b0813c6765d")));
  }

  function_63b54d8c();
  function_369007bb();
}

function function_3cdae979() {
  maps = [{
    #name: "wz_forest", #gts: # "hash_45f866da7af3a609", #prioritized: 0
  }, {
    #name: "wz_golova", #gts: # "hash_d9c18f112ff4552", #prioritized: 0
  }, {
    #name: "wz_sanatorium", #gts: # "hash_4eabe0978dc92ef7", #prioritized: 0
  }, {
    #name: "wz_duga", #gts: # "hash_444f9d0410b85ddf", #prioritized: 0
  }, {
    #name: "wz_ski_slopes", #gts: # "hash_15e3cdab677aed", #prioritized: 0
  }];
  maps[maps.size] = {
    #name: "wz_zoo", #gts: # "hash_3a16dccdcb82e664", #prioritized: 0
  };
  maps[maps.size] = {
    #name: "mp_dune", #gts: # "hash_4437cd0410a41d8e", #prioritized: 0
  };
  maps[maps.size] = {
    #name: "mp_black_sea", #gts: # "hash_5164b603aedfbe2a", #prioritized: 0
  };
  return maps;
}

function function_19e6d9ca(var_5ecdfc37) {
  var_42d8351e = 0;

  foreach(objective_name, var_ac58e8e0 in level.contentmanager.var_9614b1d2) {
    if(isarray(var_ac58e8e0.list) && isinarray(var_ac58e8e0.list, var_5ecdfc37)) {
      var_42d8351e = 1;
      break;
    }
  }

  if(var_42d8351e) {
    level.contentmanager.var_9614b1d2[objective_name] = {
      #list: array(var_5ecdfc37), #index: 0
    };
  }

  level.contentmanager.var_407236bf = {
    #list: array(var_42d8351e ? objective_name : var_5ecdfc37), #index: 0
  };
}

function objective_exists(destination, var_a3b3f1b, variant) {
  instances = destination.var_e859e591[var_a3b3f1b];

  if(!isDefined(instances)) {
    return false;
  }

  if(getdvarstring(#"hash_5dcd31d8e8a23597", "<dev string:x113>") != "<dev string:x113>") {
    if(issubstr(getdvarstring(#"hash_5dcd31d8e8a23597", "<dev string:x113>"), function_9e72a96(var_a3b3f1b))) {
      return false;
    }
  }

  if(isDefined(variant)) {
    foreach(instance in instances) {
      if(instance.variant === variant) {
        return true;
      }
    }

    return false;
  }

  return true;
}

function function_63b54d8c() {
  if(getdvarstring(#"hash_4c7a7b0813c6765d") !== "<dev string:x113>") {
    return;
  }

  if(level.var_b48509f9 === 1 && level.contentmanager.var_407236bf.list[0] === # "hunt") {
    if(isDefined(level.contentmanager.var_9614b1d2[# "hunt"])) {
      arrayremovevalue(level.contentmanager.var_9614b1d2[# "hunt"].list, #"hunt_steiner");
      arrayremovevalue(level.contentmanager.var_9614b1d2[# "hunt"].list, #"hunt_mechz");
      arrayremovevalue(level.contentmanager.var_9614b1d2[# "hunt"].list, #"hash_7ecff86523884e12");
      arrayinsert(level.contentmanager.var_9614b1d2[# "hunt"].list, #"hunt_steiner", randomintrangeinclusive(1, level.contentmanager.var_9614b1d2[# "hunt"].list.size));
    }
  }

  if(level.var_b48509f9 === 2 && level.contentmanager.var_407236bf.list[1] === # "hunt") {
    if(isDefined(level.contentmanager.var_9614b1d2[# "hunt"])) {
      arrayremovevalue(level.contentmanager.var_9614b1d2[# "hunt"].list, #"hunt_mechz");
      arrayinsert(level.contentmanager.var_9614b1d2[# "hunt"].list, #"hunt_mechz", randomintrangeinclusive(2, level.contentmanager.var_9614b1d2[# "hunt"].list.size));
    }
  }

  if(level.var_b48509f9 === 1 && level.contentmanager.var_407236bf.list[0] === # "payload") {
    if(isDefined(level.contentmanager.var_9614b1d2.list[# "payload"])) {
      level.contentmanager.var_9614b1d2[# "payload"].list = [# "payload_noteleport", #"payload_teleport"];
    }
  }
}