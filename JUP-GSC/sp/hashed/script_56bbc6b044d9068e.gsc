/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_56bbc6b044d9068e.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_b7b6752218f40f9;

function function_6c8f43b0ad6fe1(boxtype, var_3124d97e64e2ed57) {
  var_1f213921962c951e = spawnStruct();
  var_1f213921962c951e.box_offset = (0, 0, 0);
  var_1f213921962c951e.box_rotation = (0, 0, 0);
  box_type = boxtype;

  if(issubstr(box_type, "scriptable_")) {
    box_type = removesubstr(box_type, "scriptable_");
  }

  pistol_caches = ["cp_blueprint_crate_dungeons_pistol"];
  regular_caches = ["cp_blueprint_crate_dungeons", "cp_blueprint_crate_dungeons" + "_depth01", "cp_blueprint_crate_dungeons" + "_depth03", "cp_blueprint_crate_dungeons" + "_depth06"];
  large_caches = ["cp_blueprint_crate_dungeons_large", "cp_blueprint_crate_dungeons_large" + "_depth01", "cp_blueprint_crate_dungeons_large" + "_depth03", "cp_blueprint_crate_dungeons_large" + "_depth06", "cp_blueprint_crate_dungeons_large" + "_depth10"];
  xlarge_caches = ["cp_blueprint_crate_dungeons_xlarge", "cp_blueprint_crate_dungeons_xlarge" + "_depth03", "cp_blueprint_crate_dungeons_xlarge" + "_depth07", "cp_blueprint_crate_dungeons_xlarge" + "_depth15", "cp_blueprint_crate_dungeons_xlarge" + "_depth30"];
  var_5f45ff87503cd468 = array_contains(pistol_caches, box_type);
  var_3c67976e1ffdd337 = array_contains(regular_caches, box_type);
  var_705e7141311b0a4c = array_contains(large_caches, box_type);
  var_c89dfd816942c5f8 = array_contains(xlarge_caches, box_type);

  if(var_5f45ff87503cd468) {
    box_offset = (5, 0, 4);
    box_rotation = (0, 0, 0);
  } else if(var_3c67976e1ffdd337) {
    switch (var_3124d97e64e2ed57) {
      case #"hash_66010ba111a1ebad":
        box_offset = (0, 0, 11.5);
        break;
      case #"hash_660109a111a1e887":
        box_offset = (0, 0, 9.5);
        break;
      case #"hash_660104a111a1e0a8":
        box_offset = (0, 0, 6.5);
        break;
      case #"hash_7038dec66d8275be":
      default:
        box_offset = (0, 0, 12.5);
        break;
    }

    box_rotation = (0, 90, 0);
  } else if(var_705e7141311b0a4c) {
    switch (var_3124d97e64e2ed57) {
      case #"hash_66010ba111a1ebad":
        box_offset = (0, 0, 15.5);
        break;
      case #"hash_660109a111a1e887":
        box_offset = (0, 0, 13.5);
        break;
      case #"hash_660104a111a1e0a8":
        box_offset = (0, 0, 10.5);
        break;
      case #"hash_6603f0a111a3ffc3":
        box_offset = (0, 0, 6.5);
        break;
      case #"hash_7038dec66d8275be":
      default:
        box_offset = (0, 0, 16.5);
        break;
    }

    box_rotation = (0, 90, 0);
  } else if(var_c89dfd816942c5f8) {
    switch (var_3124d97e64e2ed57) {
      case #"hash_660109a111a1e887":
        box_offset = (0, 0, 21);
        break;
      case #"hash_660105a111a1e23b":
        box_offset = (0, 0, 17);
        break;
      case #"hash_6603f3a111a4047c":
        box_offset = (0, 0, 9);
        break;
      case #"hash_65fd84a1119ed891":
        box_offset = (0, 0, 2);
        break;
      case #"hash_7038dec66d8275be":
      default:
        box_offset = (0, 0, 24);
        break;
    }

    box_rotation = (0, 90, 0);
  } else {
    switch (var_3124d97e64e2ed57) {
      case #"hash_66010ba111a1ebad":
        box_offset = (0, 0, 11.5);
        break;
      case #"hash_660109a111a1e887":
        box_offset = (0, 0, 9.5);
        break;
      case #"hash_660104a111a1e0a8":
        box_offset = (0, 0, 6.5);
        break;
      case #"hash_7038dec66d8275be":
      default:
        box_offset = (0, 0, 13.5);
        break;
    }

    box_rotation = (0, 90, 0);
  }

  var_1f213921962c951e.box_offset = box_offset;
  var_1f213921962c951e.box_rotation = box_rotation;
  return var_1f213921962c951e;
}

function function_8dc9e7e5c593107c(scriptables) {
  foreach(scriptable in scriptables) {
    if(isDefined(scriptable.itembox)) {
      return scriptable;
    }
  }
}

function function_e3c4d9826d0b82f6() {
  setdevdvarifuninitialized(@ "hash_80d6488aecd346c8", 0);
  level notify("<dev string:x1c>");
  level endon("<dev string:x1c>");
  up_pressed = 0;
  down_pressed = 0;
  left_pressed = 0;
  right_pressed = 0;
  var_84c09d59ab4fd74e = 0;
  var_714bb15cf22cf6f = 0;

  while(!isDefined(level.player)) {
    wait 1;
  }

  if(!isDefined(level.var_440f684cddc61b73)) {
    level.var_440f684cddc61b73 = [];
  }

  level childthread function_915988a78d5fc7f();
  contents = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
  weaponfound = undefined;
  inc_amount = 0.5;

  while(true) {
    if(getdvarint(@ "hash_80d6488aecd346c8", 0) == 1) {
      if(isDefined(weaponfound)) {
        weap_angles = anglestoaxis(weaponfound.angles);
        var_54e37475e556aa46 = weap_angles["<dev string:x2f>"];
        var_1e3ae2fcc2883069 = weap_angles["<dev string:x37>"];
        var_1ec34defde21bdbe = weap_angles["<dev string:x2f>"] * -1;
        var_5d120fd9a105a1bc = weap_angles["<dev string:x37>"] * -1;
        var_8b17211619723721 = weap_angles["<dev string:x3a>"];
        var_495ae12cc4f12434 = weap_angles["<dev string:x3a>"] * -1;
        var_54e37475e556aa46 = (var_54e37475e556aa46[0], var_54e37475e556aa46[1], 0);
        var_1e3ae2fcc2883069 = (var_1e3ae2fcc2883069[0], var_1e3ae2fcc2883069[1], 0);
        var_1ec34defde21bdbe = (var_1ec34defde21bdbe[0], var_1ec34defde21bdbe[1], 0);
        var_5d120fd9a105a1bc = (var_5d120fd9a105a1bc[0], var_5d120fd9a105a1bc[1], 0);

        if(level.player buttonPressed("<dev string:x40>") || level.player buttonPressed("<dev string:x48>")) {
          while(level.player buttonPressed("<dev string:x40>") || level.player buttonPressed("<dev string:x48>")) {
            waitframe();
          }

          if(!up_pressed) {
            up_pressed = 1;

            if(!isDefined(weaponfound.script_offset)) {
              weaponfound.script_offset = (0, 0, 0);
            }

            weaponfound.script_offset += (inc_amount, 0, 0);
            newpos = weaponfound.origin + var_1e3ae2fcc2883069 * inc_amount;
            weaponfound.origin = newpos;
          }
        } else {
          up_pressed = 0;
        }

        if(level.player buttonPressed("<dev string:x50>") || level.player buttonPressed("<dev string:x5a>")) {
          while(level.player buttonPressed("<dev string:x50>") || level.player buttonPressed("<dev string:x5a>")) {
            waitframe();
          }

          if(!down_pressed) {
            down_pressed = 1;

            if(!isDefined(weaponfound.script_offset)) {
              weaponfound.script_offset = (0, 0, 0);
            }

            weaponfound.script_offset -= (inc_amount, 0, 0);
            newpos = weaponfound.origin + var_5d120fd9a105a1bc * inc_amount;
            weaponfound.origin = newpos;
          }
        } else {
          down_pressed = 0;
        }

        if(level.player buttonPressed("<dev string:x64>") || level.player buttonPressed("<dev string:x6e>")) {
          while(level.player buttonPressed("<dev string:x64>") || level.player buttonPressed("<dev string:x6e>")) {
            waitframe();
          }

          if(!left_pressed) {
            left_pressed = 1;

            if(!isDefined(weaponfound.script_offset)) {
              weaponfound.script_offset = (0, 0, 0);
            }

            weaponfound.script_offset += (0, inc_amount, 0);
            newpos = weaponfound.origin + var_54e37475e556aa46 * inc_amount;
            weaponfound.origin = newpos;
          }
        } else {
          left_pressed = 0;
        }

        if(level.player buttonPressed("<dev string:x78>") || level.player buttonPressed("<dev string:x83>")) {
          while(level.player buttonPressed("<dev string:x78>") || level.player buttonPressed("<dev string:x83>")) {
            waitframe();
          }

          if(!right_pressed) {
            right_pressed = 1;

            if(!isDefined(weaponfound.script_offset)) {
              weaponfound.script_offset = (0, 0, 0);
            }

            weaponfound.script_offset -= (0, inc_amount, 0);
            newpos = weaponfound.origin + var_1ec34defde21bdbe * inc_amount;
            weaponfound.origin = newpos;
          }
        } else {
          right_pressed = 0;
        }

        if(level.player buttonPressed("<dev string:x8e>")) {
          while(level.player buttonPressed("<dev string:x8e>")) {
            waitframe();
          }

          if(!var_84c09d59ab4fd74e) {
            var_84c09d59ab4fd74e = 1;

            if(!isDefined(weaponfound.script_offset)) {
              weaponfound.script_offset = (0, 0, 0);
            }

            weaponfound.script_offset += (0, 0, inc_amount);
            newpos = weaponfound.origin + var_495ae12cc4f12434 * inc_amount;
            weaponfound.origin = newpos;
          }
        } else {
          var_84c09d59ab4fd74e = 0;
        }

        if(level.player buttonPressed("<dev string:x90>")) {
          while(level.player buttonPressed("<dev string:x90>")) {
            waitframe();
          }

          if(!var_714bb15cf22cf6f) {
            var_714bb15cf22cf6f = 1;

            if(!isDefined(weaponfound.script_offset)) {
              weaponfound.script_offset = (0, 0, 0);
            }

            weaponfound.script_offset -= (0, 0, inc_amount);
            newpos = weaponfound.origin + var_8b17211619723721 * inc_amount;
            weaponfound.origin = newpos;
          }
        } else {
          var_714bb15cf22cf6f = 0;
        }
      }

      if(level.player buttonPressed("<dev string:x92>")) {
        while(level.player buttonPressed("<dev string:x92>") || level.player buttonPressed("<dev string:x92>")) {
          waitframe();
        }

        player_forward = anglesToForward(level.player getplayerangles());
        player_eye = level.player getEye();
        result = scripts\engine\trace::ray_trace(player_eye, player_eye + player_forward * 1000, level.player, contents);

        if(result["<dev string:x98>"] != "<dev string:xa0>") {
          if(isDefined(result["<dev string:xad>"]) && isvector(result["<dev string:xad>"])) {
            scriptables = getentitylessscriptablearray(undefined, undefined, result["<dev string:xad>"], 100);

            if(scriptables.size > 0) {
              weaponfound = function_8dc9e7e5c593107c(scriptables);

              if(isDefined(weaponfound)) {
                if(!isDefined(weaponfound.script_offset)) {
                  weaponfound.script_offset = (0, 0, 0);
                }

                iprintln("<dev string:xb6>" + weaponfound.itembox.itemname);
                level.var_440f684cddc61b73 = function_6d6af8144a5131f1(level.var_440f684cddc61b73, weaponfound.itembox);

                if(level.var_440f684cddc61b73.size >= 5) {
                  level.var_440f684cddc61b73 = array_remove_index(level.var_440f684cddc61b73, 0);
                }
              }
            }
          }
        }
      }
    }

    waitframe();
  }
}

function function_915988a78d5fc7f() {
  level endon("<dev string:xc5>");
  level endon("<dev string:xd0>");

  while(true) {
    if(getdvarint(@ "hash_80d6488aecd346c8", 0) == 1) {
      foreach(itembox in level.var_440f684cddc61b73) {
        if(isDefined(itembox.spawneditem)) {
          if(isDefined(itembox.spawneditem.origin)) {
            print3d(itembox.spawneditem.origin + (0, 0, 15), "<dev string:xdb>" + itembox.spawneditem.origin, (0, 1, 0), 1, 0.1, 1, 1);
          }

          if(isDefined(itembox.spawneditem.weapon_offset)) {
            print3d(itembox.spawneditem.origin + (0, 0, 18), "<dev string:xe5>" + itembox.spawneditem.weapon_offset, (0, 1, 0), 1, 0.1, 1, 1);
          }

          if(isDefined(itembox.spawneditem.script_offset)) {
            origin_diff = itembox.var_cea55c49c1be059f - itembox.spawneditem.origin;
            print3d(itembox.spawneditem.origin + (0, 0, 21), "<dev string:xf5>" + itembox.spawneditem.weapon_offset - origin_diff, (1, 0, 0), 1, 0.1, 1, 1);
          }
        }
      }
    }

    wait 0.05;
  }
}

function function_231f43f1d8cf0ef1(var_1b276f35dd9e0aea) {
  if(!isDefined(var_1b276f35dd9e0aea)) {
    return undefined;
  }

  var_2ef465eed8edab39 = spawnStruct();
  var_2ef465eed8edab39.var_20c06686589dcd6d = undefined;
  var_2ef465eed8edab39.weaponoffset = (0, 0, 0);
  var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);

  switch (var_1b276f35dd9e0aea) {
    case #"hash_21bb46e97fca81c4":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (1, -1, -2);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_21bb49e97fca867d":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (0.75, -3, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_1788f3bd8e378e94":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (0.25, 0, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_ab674007d7f2a25f":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (2, -3, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_476c987a54e45e4c":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (-1, -1, -3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_d36b5c75272a5dbe":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (4.5, -2, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_39cd940bd89d6715":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (1, -2, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_63d37a96df145677":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (2, 0, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_ddc84285b405f65c":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (4, -2, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_ddc84585b405fb15":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons";
      var_2ef465eed8edab39.weaponoffset = (5, -1.5, -2);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_75e8e07a7c17b665":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-2, 0, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_75e8dd7a7c17b1ac":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (1.5, 0.25, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, -5);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_a8d75a2b87816525":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-1, -1, 0);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, -75);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth07";
      break;
    case #"hash_569612254f89d1f":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-1.5, -1.5, 0.1);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth07";
      break;
    case #"hash_f5b7ce311fed784d":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (0, 1, -2);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_63f9bccf8cc3ab94":
    case #"hash_63f9bdcf8cc3ad27":
    case #"hash_63f9bfcf8cc3b04d":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (0, -0.16, -0.4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, -75);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth06";
      break;
    case #"hash_3ff194f563922a95":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (2.5, 0, -3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_cfff3f264cb5f8ba":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-10, -4.7, -3.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 18);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth07";
      break;
    case #"hash_f0925ae27f5b990a":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_pistol";
      var_2ef465eed8edab39.weaponoffset = (7.25, -0.5, 6);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "default";
      break;
    case #"hash_f09259e27f5b9777":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_pistol";
      var_2ef465eed8edab39.weaponoffset = (6.5, 1.5, 7);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "default";
      break;
    case #"hash_eec788a0a79fc096":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_pistol";
      var_2ef465eed8edab39.weaponoffset = (3.75, 0.5, 6);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "default";
      break;
    case #"hash_eec787a0a79fbf03":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_pistol";
      var_2ef465eed8edab39.weaponoffset = (4.5, 0.5, 6);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "default";
      break;
    case #"hash_28cf5b516b4ab8e":
    case #"hash_28cf4b516b4a9fb":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (4.5, 0, -1);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, -12);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_fb0824c57662df0b":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (0, -2, -3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_31470322cf505e91":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons";
      var_2ef465eed8edab39.weaponoffset = (9, 1, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_b591a7b55ede2267":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (0, -1, -3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_1480a71be353595d":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (-2, -2.5, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_7333db7aac3dcc96":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (3.5, -3.5, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_7333dc7aac3dce29":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (2.25, -1, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_6845cd3067835fab":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (2, -4, -3.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_8feeb384dd94872b":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (-0.5, -1, -3.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_7e945560c96fe323":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (6, -4, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, -5);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_d20888beab32e688":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (4, -3.5, -1);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth06";
      break;
    case #"hash_d2f34adba74789ce":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (4, -3.5, -3.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 10);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_2fc5227e62dc28c3":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (-1, -1.75, -3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 15);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_76810919ec2f72c8":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-1, 0, -3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_c2bf3bafade06b32":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-8, -1.5, -4.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth07";
      break;
    case #"hash_198680e4a892f95e":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (1, -1, -3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, -7);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_1c105fb50c847214":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (8, -3, -3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, -2);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth07";
      break;
    case #"hash_371da10f0e7eab13":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (1.5, -1.5, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_371da30f0e7eae39":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (3, -2.5, -3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, -5);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_8248cbb01dd30d01":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (1, -1, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, -1.5, -3);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_230d3e6ff3876dec":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (3.5, -3.5, -2.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, -2);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_a1afe18f55099671":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (0, -1, -2.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_e68982a2ee8459f3":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (5.75, -2, -3.75);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, -4);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_6817de284a9d69d2":
    case #"hash_6817dd284a9d683f":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-4.75, 0.5, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, -6);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_876692e6dba809e3":
    case #"hash_876693e6dba80b76":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-1, -1.75, -1);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 18);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth07";
      break;
    case #"hash_b838f671c846e9a2":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (3.75, -2.5, -3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 12);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_d2088bbeab32eb41":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (3.5, -4.3, -2.3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 26);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_1e46070e08bb5c0a":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (-1.5, -1, -2.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_76810c19ec2f7781":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (1.5, -0.5, -2.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_728e10bf5a13c2ac":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-1, 1, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, -1.5, -5);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_c6cb1beaedee7f36":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (0, -2.5, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, -2);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_404bdbbf422921d3":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (0, -0.5, -4.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_404bdcbf42292366":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (1, -1, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_d36b5b75272a5c2b":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (3.5, -1, -3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_e7252cf45691d031":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons";
      var_2ef465eed8edab39.weaponoffset = (8.5, -2.5, -3.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_796892933673e1b7":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (4, -1.5, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_b838f571c846e80f":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons";
      var_2ef465eed8edab39.weaponoffset = (5.5, -2.25, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_5f9df7fdd0eea814":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-1, 0, -2);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 15);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_5f9dfafdd0eeaccd":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-2, -2, -3.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 10);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_3523ded6a70c9654":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-7, -0.5, -4.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_3523e1d6a70c9b0d":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-11, 0, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_7a2ca11838b3cd91":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_pistol";
      var_2ef465eed8edab39.weaponoffset = (6.5, -0.5, 5.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "default";
      break;
    case #"hash_79796657f3216f7a":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_xlarge";
      var_2ef465eed8edab39.weaponoffset = (-1.2, 0.8, -4.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_34c9b735f0f5e530":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_pistol";
      var_2ef465eed8edab39.weaponoffset = (4.5, 1, 6);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "default";
      break;
    case #"hash_fdf47fc3e6b7c6cb":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (-0.5, 0, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_9fd4986f8debd368":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (2, 0, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_d4f57e1987505af":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_pistol";
      var_2ef465eed8edab39.weaponoffset = (8.5, -1.5, 6);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_476c9b7a54e46305":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (1, -3, -4);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth01";
      break;
    case #"hash_932bd94b3a63f0e4":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (0.398, -1, -5.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 90, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth06";
      break;
    case #"hash_ce4254252df982aa":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_pistol";
      var_2ef465eed8edab39.weaponoffset = (0, 0, 5.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 90, -90);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "default";
      break;
    case #"hash_e60b34dbe65dfd6b":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (-1, 8.5, -4.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 90, 53);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth10";
      break;
    case #"hash_8fee6b37bf439744":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (0.499, -1.5, -4.5);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 180, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth06";
      break;
    case #"hash_8e8de4a673a8e04e":
    case #"hash_8e61d0a673862e90":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons";
      var_2ef465eed8edab39.weaponoffset = (0.48, -1, -3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth03";
      break;
    case #"hash_1034ff50a7524973":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons_large";
      var_2ef465eed8edab39.weaponoffset = (0.47, -1, -3);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 90, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "depth06";
      break;
    case #"hash_fa3ce8acbb19a2bb":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons";
      var_2ef465eed8edab39.weaponoffset = (0, 0, 0);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "default";
      break;
    case #"hash_54ed51d2f4df2011":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons";
      var_2ef465eed8edab39.weaponoffset = (0, 0, 0);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "default";
      break;
    case #"hash_b7c258f34317cf65":
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons";
      var_2ef465eed8edab39.weaponoffset = (0, 0, 0);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      var_2ef465eed8edab39.var_3124d97e64e2ed57 = "default";
      break;
    default:
      println("<dev string:x107>");
      var_2ef465eed8edab39.var_20c06686589dcd6d = "cp_blueprint_crate_dungeons";
      var_2ef465eed8edab39.weaponoffset = (0, 0, 0);
      var_2ef465eed8edab39.var_298349d024e91598 = (0, 0, 0);
      break;
  }

  return var_2ef465eed8edab39;
}