/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_5c9b111047cd229f.gsc
*****************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\devgui;
#using scripts\engine\utility;
#namespace subclass_to_aitype_map;

function autoexec init() {
  level thread function_378daafe824a5c0();
}

function private function_378daafe824a5c0() {
  level endon("game_ended");
  waitframe();
  level.stam_default_mapping = "ChooseSmallest";
  level.var_54d7099494ead715 = undefined;
  level.stam_default_substring = undefined;
  level.var_c9e0fca55204d8c4 = [];
  level.subclass_to_aitype_map = [];
  level.var_962742d9501c1412 = [];
  subclass_names = getscriptbundlenames("ai_subclass");

  foreach(str_bundle in subclass_names) {
    name = getscriptbundlefieldvalue(str_bundle, "name");
    level.var_962742d9501c1412[level.var_962742d9501c1412.size] = name;
  }

  add_map();
  gametypebundle = getgametypescriptbundle();

  if(isDefined(gametypebundle) && isDefined(gametypebundle.subclass_to_aitype_map)) {
    add_map(gametypebundle.subclass_to_aitype_map);
  }

  mapinfo = getactivemapinfobundle();

  if(isDefined(mapinfo) && isDefined(mapinfo.subclass_to_aitype_map) && mapinfo.subclass_to_aitype_map.size > 0) {
    add_map(mapinfo.subclass_to_aitype_map);
  }

  if(isDefined(gametypebundle) && isDefined(gametypebundle.var_d72ac83fac014227)) {
    add_map(gametypebundle.var_d72ac83fac014227);
  }

  utility::flag_set("subclass_to_aitype_map_initialized");
  level thread function_e3f62c04fcbf8c79();

  level thread init_debug_stam();
}

function function_7f9ebc41207674e9(subclass) {
  assert(utility::flag("<dev string:x24>"), "<dev string:x4a>");
  return function_b3988325430ce242(subclass);
}

function add_map(map_asset) {
  processed_map = process_map_asset(map_asset, level.stam_default_mapping, level.var_54d7099494ead715, level.stam_default_substring, level.subclass_to_aitype_map);
  level.stam_default_mapping = processed_map.default_mapping ?? level.stam_default_mapping;
  level.var_54d7099494ead715 = processed_map.default_specific_aitype ?? level.var_54d7099494ead715;
  level.stam_default_substring = processed_map.default_substring ?? level.stam_default_substring;
  level.subclass_to_aitype_map = processed_map.subclass_map;

  foreach(subclass_name in level.var_962742d9501c1412) {
    aitype = function_9fc4e9f61d6b21d8(subclass_name);

    if(isDefined(aitype)) {
      setsubclasstoaitype(subclass_name, aitype);
    }
  }

  level.var_c9e0fca55204d8c4[level.var_c9e0fca55204d8c4.size] = map_asset;
}

function remove_map(map_asset) {
  assert(arraycontains(level.var_c9e0fca55204d8c4, map_asset));
  level.var_c9e0fca55204d8c4 = arrayremove(level.var_c9e0fca55204d8c4, map_asset);
  level.subclass_to_aitype_map = [];

  foreach(current_map_asset in level.var_c9e0fca55204d8c4) {
    add_map(current_map_asset);
  }
}

function function_427ae77ce1056e01(subclass, map_assets) {
  assert(utility::flag("<dev string:x24>"), "<dev string:x4a>");

  if(!isarray(map_assets)) {
    map_assets = [map_assets];
  }

  assert(map_assets.size > 0);
  processed_map = process_map_asset(map_assets[0]);

  for(map_index = 1; map_index < map_assets.size; map_index++) {
    processed_map = process_map_asset(map_assets[map_index], processed_map.default_mapping, processed_map.default_specific_aitype, processed_map.default_substring, processed_map.subclass_to_aitype_map);
  }

  if(isDefined(processed_map.subclass_map[subclass])) {
    return processed_map.subclass_map[subclass];
  }

  if(isDefined(processed_map.default_mapping)) {
    calculated_aitype = calculate_aitype(subclass, processed_map.default_mapping, processed_map.default_specific_aitype, processed_map.default_substring);
    return calculated_aitype;
  }

  return undefined;
}

function private process_map_asset(map_asset, prev_default_mapping, var_f46f630650bf02a1, prev_default_substring, prev_subclass_map) {
  return_map = {
    #subclass_map: arraycopy(prev_subclass_map ?? []), #default_substring: prev_default_substring, #default_specific_aitype: var_f46f630650bf02a1, #default_mapping: prev_default_mapping
  };

  if(!isDefined(map_asset)) {
    return return_map;
  }

  if(isstring(map_asset)) {
    if(!issubstr(map_asset, "subclass_to_aitype_map:")) {
      map_asset = "subclass_to_aitype_map:" + map_asset;
    }

    map_asset = getxhashasset(map_asset);
  }

  scriptbundle = load_map_asset(map_asset);

  if(isDefined(scriptbundle)) {
    if(isDefined(scriptbundle.default_mapping) && scriptbundle.default_mapping != "DontChange") {
      return_map.default_mapping = scriptbundle.default_mapping;

      if(return_map.default_mapping == "Specific") {
        assert(isstring(scriptbundle.defaultspecificaitype));
        return_map.default_specific_aitype = scriptbundle.defaultspecificaitype;
      } else if(return_map.default_mapping == "ContainsString") {
        assert(isstring(scriptbundle.defaultsubstring));
        return_map.default_substring = scriptbundle.defaultsubstring;
      }
    }

    if(isDefined(scriptbundle.entry_list)) {
      foreach(entry in scriptbundle.entry_list) {
        subclass_name = getscriptbundlefieldvalue(entry.subclass, "name");

        if(!isDefined(subclass_name)) {
          continue;
        }

        calculated_aitype = calculate_aitype(subclass_name, entry.mapping, entry.specificaitype, entry.substring);

        if(!isDefined(calculated_aitype)) {
          continue;
        }

        return_map.subclass_map[subclass_name] = calculated_aitype;
      }
    }
  }

  return return_map;
}

function private calculate_aitype(subclass_name, mapping, specific_aitype, substring) {
  assert(isDefined(mapping));

  if(!isDefined(mapping)) {
    return;
  }

  if(mapping == "Specific") {
    assert(isstring(specific_aitype));
    return specific_aitype;
  }

  aitypes = namespace_9d8e359c3b1041e5::get_aitype_by_subclass_sharedfunc(subclass_name);

  if(!isarray(aitypes) || aitypes.size <= 0) {
    return;
  }

  if(mapping == "ContainsString") {
    assert(isstring(substring));

    foreach(aitype in aitypes) {
      if(issubstr(aitype, substring)) {
        return aitype;
      }
    }
  }

  smallest_aitype = undefined;

  foreach(aitype in aitypes) {
    strlen = aitype.size;

    if(!isDefined(smallest_aitype) || smallest_aitype.size > strlen) {
      smallest_aitype = aitype;
    }
  }

  return smallest_aitype;
}

function private load_map_asset(map_asset) {
  assert(isxhash(map_asset) || isxhashasset(map_asset));

  if(!isDefined(level.var_e6acc6202bec467e)) {
    level.var_e6acc6202bec467e = [];
  }

  scriptbundle = undefined;

  if(!isDefined(level.var_e6acc6202bec467e[map_asset])) {
    scriptbundle = getscriptbundle(map_asset);

    if(!isDefined(scriptbundle)) {
      assertmsg("<dev string:x78>" + getxhashsourcename(map_asset));
      return undefined;
    }

    level.var_e6acc6202bec467e[map_asset] = scriptbundle;
  }

  scriptbundle = level.var_e6acc6202bec467e[map_asset];
  return scriptbundle;
}

function private function_e3f62c04fcbf8c79() {
  level endon("game_ended");
  setdvarifuninitialized(@ "hash_33aa1a0677d2f25f", "");

  while(true) {
    stam_dvar = getDvar(@ "hash_33aa1a0677d2f25f");

    if(stam_dvar == "") {
      wait 1;
      continue;
    }

    setDvar(@ "hash_33aa1a0677d2f25f", "");
    map_assets = strtok(stam_dvar, "|");

    foreach(map_asset in map_assets) {
      if(map_asset[0] == "-") {
        map_asset = getsubstr(map_asset, 1, map_asset.size);
        remove_map(map_asset);
        continue;
      }

      add_map(map_asset);
    }
  }
}

function private function_9fc4e9f61d6b21d8(subclass) {
  if(isDefined(level.subclass_to_aitype_map[subclass])) {
    return level.subclass_to_aitype_map[subclass];
  }

  calculated_aitype = calculate_aitype(subclass, level.stam_default_mapping, level.var_54d7099494ead715, level.stam_default_substring);
  return calculated_aitype;
}

function private init_debug_stam() {
  if(getdvarint(@ "nodebug", 0) >= 1) {
    return;
  }

  devgui::function_9082edeb5db93280("<dev string:x91>");
  devgui::function_502a7d5e4d9dfa5b("<dev string:xb4>", "<dev string:xc9>", &function_cc177ffde4bc515f);
  devgui::function_77df7fe7dd273e10();
  level thread draw_debug_stam();
}

function private function_cc177ffde4bc515f() {
  devgui::function_3f8a26ec96988e80("<dev string:xf5>", @ "stam_debug");
}

function private draw_debug_stam() {
  level endon("<dev string:x103>");

  while(true) {
    if(getdvarint(@ "stam_debug", 0) == 0) {
      waitframe();
      continue;
    }

    col = (0, 1, 0);
    yy = 400;
    printtoscreen2d(10, yy, "<dev string:x111>", col);
    yy += 20;
    printtoscreen2d(10, yy, "<dev string:x12b>" + level.stam_default_mapping, col);
    yy += 20;

    if(level.stam_default_mapping == "<dev string:x140>") {
      printtoscreen2d(10, yy, "<dev string:x152>" + level.stam_default_substring, col);
    } else if(level.stam_default_mapping == "<dev string:x16b>") {
      printtoscreen2d(10, yy, "<dev string:x177>" + level.var_bb740e14e3b6aefc, col);
    }

    yy += 30;
    entry_i = 0;

    foreach(subclass in level.var_962742d9501c1412) {
      aitype = function_b3988325430ce242(subclass);
      col = arraycontains(level.subclass_to_aitype_map, aitype) ? (0.9, 0.6, 0) : (0.8, 0.5, 0);
      printtoscreen2d(200, yy + entry_i * 20, subclass + "<dev string:x18c>" + aitype, col);
      entry_i++;
    }

    printtoscreen2d(10, yy, "<dev string:x194>", col);
    yy += 20;
    entry_i = 0;

    foreach(map_name in level.var_c9e0fca55204d8c4) {
      printtoscreen2d(10, yy + entry_i * 20, map_name, col);
      entry_i++;
    }

    waitframe();
  }
}

# /