/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\doorbuy.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\cp_mp\content_manager;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\interaction;
#using scripts\engine\utility;
#using scripts\mp\equipment\c4;
#namespace doorbuy;

function init_doorbuy() {
  level thread function_7d7811a152066077();
}

function function_7d7811a152066077() {
  level.a_s_doorbuys = [];
  content_manager::register_script("doorbuy", &function_6d0912117e9a9e3);
  wait 0.1;
  mapdestinations = utility::getStructArray("content_destination", "variantname");

  if(isDefined(mapdestinations) && mapdestinations.size > 0) {
    level thread function_272932835d23225c(mapdestinations[0]);
  }

  level thread function_233b115afbbdb524();

  level thread function_67ce357c2e2478d7();
}

function function_272932835d23225c(destination) {
  foreach(location in destination.locations) {
    doorbuy_instance = location.instances["doorbuy"];

    if(isDefined(doorbuy_instance)) {
      foreach(instance in doorbuy_instance.versions) {
        content_manager::spawn_instance(instance);
      }
    }
  }
}

function function_233b115afbbdb524() {
  var_37f334c1f5b39c65 = getEntArray("zombie_door", "targetname");

  foreach(t_doorbuy in var_37f334c1f5b39c65) {
    instance = utility::getStruct(t_doorbuy.target, "targetname");
    t_doorbuy doorbuy_init(instance, 1);
  }
}

function private function_6d0912117e9a9e3(instance) {
  var_25ad4528af3906ce = instance.contentgroups["doorbuy_trigger"];

  if(isarray(var_25ad4528af3906ce)) {
    foreach(var_c318cd3a7e81533a in var_25ad4528af3906ce) {
      var_c318cd3a7e81533a doorbuy_init(instance);
    }
  }
}

function private doorbuy_init(instance, var_9c58267a9b1f2155) {
  a_doors = [];
  self.instance = instance;

  if(isDefined(self.script_modelname)) {
    door = content_manager::spawn_script_model(self, self.script_modelname, 1);
    door.n_open_time = self.script_timeout;
    door.var_7f70bb16ff4511bd = self.script_soundalias;
    a_doors = utility::array_add(a_doors, door);

    if(isent(door)) {
      if(door isscriptable()) {
        assertex(door getscriptablehaspart("<dev string:x1c>"), "<dev string:x24>" + door.origin + "<dev string:x3e>");
        assertex(door getscriptableparthasstate("<dev string:x1c>", "<dev string:x62>"), "<dev string:x24>" + door.origin + "<dev string:x6c>");
        assertex(door getscriptableparthasstate("<dev string:x1c>", "<dev string:xa0>"), "<dev string:x24>" + door.origin + "<dev string:xab>");
        door setscriptablepartstate("base", "closed");
      } else if(isDefined(self.target2)) {
        var_d264bcb6d4a095a4 = utility::getStruct(self.target2, "targetname");
        door.var_a162751895346133 = var_d264bcb6d4a095a4.origin;
        door.var_a9b4e017df447bad = var_d264bcb6d4a095a4.angles;
      }
    }

    doorbuy_container = self;
    interact_location = door;
  } else {
    var_a4e265944c0fffe7 = utility::getStructArray(self.target2, "targetname");
    a_doors = [];

    if(isarray(var_a4e265944c0fffe7)) {
      foreach(s_door_loc in var_a4e265944c0fffe7) {
        if(!isDefined(s_door_loc.door)) {
          s_door_loc.door = content_manager::spawn_script_model(instance, s_door_loc.script_modelname, 1, undefined, s_door_loc.origin);
          s_door_loc.door.angles = s_door_loc.angles;
          s_door_loc.door.target = s_door_loc.target;
          s_door_loc.door.script_delete = s_door_loc.script_delete;
          s_door_loc.door.n_open_time = utility::default_to(s_door_loc.script_timeout, self.script_timeout);
          s_door_loc.door.var_7f70bb16ff4511bd = utility::default_to(s_door_loc.script_soundalias, self.script_soundalias);
        }

        a_doors = utility::array_add(a_doors, s_door_loc.door);
      }
    }

    if(isDefined(self.target2)) {
      var_5407d2589480cb66 = getscriptablearray(self.target2, "targetname");
      a_doors = utility::array_combine_unique(a_doors, var_5407d2589480cb66);
      var_ec583846f1cb5c0c = getEntArray(self.target2, "targetname");
      a_doors = utility::array_combine_unique(a_doors, var_ec583846f1cb5c0c);
    }

    foreach(door in a_doors) {
      if(isent(door)) {
        if(door isscriptable()) {
          assertex(door getscriptablehaspart("<dev string:x1c>"), "<dev string:x24>" + door.origin + "<dev string:x3e>");
          assertex(door getscriptableparthasstate("<dev string:x1c>", "<dev string:x62>"), "<dev string:x24>" + door.origin + "<dev string:x6c>");
          assertex(door getscriptableparthasstate("<dev string:x1c>", "<dev string:xa0>"), "<dev string:x24>" + door.origin + "<dev string:xab>");
          door setscriptablepartstate("base", "closed");
        } else if(isDefined(door.target)) {
          var_d264bcb6d4a095a4 = utility::getStruct(door.target, "targetname");
          door.var_a162751895346133 = var_d264bcb6d4a095a4.origin;
          door.var_a9b4e017df447bad = var_d264bcb6d4a095a4.angles;

          if(isDefined(var_d264bcb6d4a095a4.target)) {
            door.var_ccc321cb92e1d1d0 = getEnt(var_d264bcb6d4a095a4.target, "targetname");

            if(isDefined(door.var_ccc321cb92e1d1d0)) {
              door.var_ccc321cb92e1d1d0 notsolid();
              door.var_ccc321cb92e1d1d0 connectpaths();
            }
          }
        } else if(isDefined(door.target2)) {
          var_d264bcb6d4a095a4 = utility::getStruct(door.target2, "targetname");
          door.var_a162751895346133 = var_d264bcb6d4a095a4.origin;
          door.var_a9b4e017df447bad = var_d264bcb6d4a095a4.angles;
        }

        door.n_open_time = utility::default_to(door.n_open_time, door.script_timeout);
        door.var_7f70bb16ff4511bd = utility::default_to(door.var_7f70bb16ff4511bd, door.script_soundalias);
      }
    }

    if(istrue(var_9c58267a9b1f2155)) {
      interact_location = self;
      var_7aeee20648fcd230 = distance(self getpointinbounds(1, 1, 1), self getpointinbounds(-1, -1, -1));
      self.radius = var_7aeee20648fcd230;
    } else {
      interact_location = self.origin;
    }
  }

  self.radius = utility::default_to(self.radius, 40);
  self.script_cost = utility::default_to(self.script_cost, 1000);
  self.script_currency = utility::default_to(self.script_currency, "essence");

  if(function_be31d2b54e616fb7()) {
    str_hint = &"SHARED_HINTSTRINGS/DOORBUY_POWER_HINT";
  } else {
    str_hint = function_eeb8c278274b96c3();
  }

  self.interact = interaction::register_interact(interact_location, self.radius, &doorbuy_used, str_hint, self.script_cost);

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "barrier_unpurchaseable_trigger") {
    self.interact setCursorHint("HINT_NOBUTTON");
  }

  if(function_be31d2b54e616fb7()) {
    self.interact sethintinoperable(1);
    self.interact setCursorHint("HINT_NOBUTTON");
  }

  level.a_s_doorbuys = utility::array_add(level.a_s_doorbuys, self);
  self.interact.var_9c58267a9b1f2155 = var_9c58267a9b1f2155;

  if(isDefined(self.script_tag) && self.interact tagexists(self.script_tag)) {
    self.interact sethinttag(self.script_tag);
  } else if(self.interact tagexists("tag_hint")) {
    self.interact sethinttag("tag_hint");
  }

  self.interact.s_doorbuy = self;
  self.interact.doors = a_doors;
  minimap_icon = "cp_mp_doorbuy_minimap";

  if(function_be31d2b54e616fb7()) {
    minimap_icon = "cp_mp_power_door_minimap";
  }

  foreach(door in a_doors) {
    door.a_interacts = utility::default_to(door.a_interacts, []);
    door.a_interacts = utility::function_6d6af8144a5131f1(door.a_interacts, self.interact);

    if(door isscriptable()) {
      continue;
    }

    if(!isDefined(door.var_35e7c712de6487f6) && !utility::is_equal(door.script_noteworthy, "no_minimap")) {
      door.var_35e7c712de6487f6 = spawnscriptable(minimap_icon, door.origin, door.angles);
    }
  }

  if(isvector(interact_location) || istrue(var_9c58267a9b1f2155)) {
    self.interact.script_delete = 1;
    self.interact.b_is_trigger = 1;
  }

  thread function_e9c313af43b8ffa6();

  if(isDefined(level.var_180851032aeb2782)) {
    self thread[[level.var_180851032aeb2782]]();
  }
}

function private function_eeb8c278274b96c3() {
  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case #"hash_279cf0389419e022":
        str_hint = &"SHARED_HINTSTRINGS/DOORBUY_BARRIER_LOCK_HINT";
        break;
      case #"hash_fe4be2d2f966a37d":
        str_hint = &"SHARED_HINTSTRINGS/DOORBUY_BARRIER_HINT_ESSENCE";
        break;
      case #"hash_12c639a20c74c99a":
        str_hint = &"SHARED_HINTSTRINGS/DOORBUY_AETHER_CHARGE_HINT_ESSENCE";
        break;
      default:
        str_hint = &"SHARED_HINTSTRINGS/DOORBUY_HINT_ESSENCE";
        break;
    }
  } else if(self.script_currency == "essence") {
    str_hint = &"SHARED_HINTSTRINGS/DOORBUY_HINT_ESSENCE";
  } else {
    str_hint = &"SHARED_HINTSTRINGS/DOORBUY_HINT";
  }

  return str_hint;
}

function doorbuy_used(player) {
  if(isDefined(self.s_doorbuy.script_noteworthy) && self.s_doorbuy.script_noteworthy == "barrier_unpurchaseable_trigger") {
    return;
  }

  if(self.s_doorbuy function_be31d2b54e616fb7()) {
    if(!utility::flag(self.s_doorbuy.script_power) && !istrue(level.var_bbbe3abb95817b83)) {
      return;
    }
  }

  if(isDefined(player) && isDefined(self.s_doorbuy.script_currency) && isDefined(self.s_doorbuy.script_cost)) {
    if(!player currency::attempt_purchase(self.s_doorbuy.script_currency, self.s_doorbuy.script_cost, 1)) {
      player playsoundtoplayer("ui_zm_core_door_purchase_deny", player);
      return;
    }
  }

  if(isPlayer(player)) {
    player playsoundtoplayer("ui_zm_core_door_purchase_success", player);
  }

  if(isarray(self.doors)) {
    self.doors = utility::array_removeundefined(self.doors);

    foreach(door in self.doors) {
      door thread open_doorbuy();
    }
  }

  if(isDefined(self.s_doorbuy.script_flag_set)) {
    var_b9249169199027bb = strtok(self.s_doorbuy.script_flag_set, " ");

    foreach(flag in var_b9249169199027bb) {
      utility::flag_set(flag);
    }
  }

  level notify("door_opened", self);

  if(isDefined(self.s_doorbuy.script_noteworthy) && self.s_doorbuy.script_noteworthy == "aether_charge_doorbuy") {
    self.s_doorbuy thread function_1071fb611dd3d29c();
  }

  if(isDefined(self.s_doorbuy.instance)) {
    var_25ad4528af3906ce = self.s_doorbuy.instance.contentgroups["doorbuy_trigger"];

    if(isarray(var_25ad4528af3906ce)) {
      foreach(var_c318cd3a7e81533a in var_25ad4528af3906ce) {
        if(isDefined(var_c318cd3a7e81533a.interact) && var_c318cd3a7e81533a.interact != self && istrue(var_c318cd3a7e81533a.interact.b_is_trigger)) {
          var_c318cd3a7e81533a.interact delete();
        }
      }
    }
  }

  waitframe();

  if(isDefined(self)) {
    if(istrue(self.script_delete)) {
      self delete();
      return;
    }

    self makeunusable();
  }
}

function open_doorbuy() {
  if(!isDefined(self)) {
    return;
  }

  if(istrue(self.var_e585f40be16294d9)) {
    return;
  }

  self endon("death");

  if(isDefined(self.script_label)) {
    if(self.script_label == "wait_for_bomb") {
      wait 1;
    }

    if(self.script_label == "doorbuy_zipline_doors") {
      self setModel("t10_zm_energy_barrier_05_green");
    }
  }

  self.var_e585f40be16294d9 = 1;
  self notify("doorbuy_opening");
  self connectpaths();

  if(isDefined(self.var_35e7c712de6487f6)) {
    self.var_35e7c712de6487f6 freescriptable();
  }

  if(isarray(self.a_interacts)) {
    foreach(interact in self.a_interacts) {
      if(isDefined(interact)) {
        interact makeunusable();
      }
    }
  }

  if(self isscriptable()) {
    self setscriptablepartstate("base", "opening");

    if(istrue(self.script_delete)) {
      self freescriptable();
    }

    return;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "trig_rumble_mobile_barrier") {
    self delete();
    return;
  }

  n_time = utility::default_to(self.n_open_time, 0);
  n_time = clamp(n_time, 0, 999);

  if(self.classname != "script_brushmodel") {
    if(isDefined(self.var_7f70bb16ff4511bd)) {
      self playSound(self.var_7f70bb16ff4511bd);
    }
  }

  self notsolid();

  if(n_time > 0) {
    if(isDefined(self.var_a162751895346133)) {
      self moveTo(self.var_a162751895346133, n_time);

      if(isDefined(self.var_a9b4e017df447bad)) {
        self rotateTo(self.var_a9b4e017df447bad, n_time);
      }

      self waittill("movedone");

      if(isDefined(self.var_ccc321cb92e1d1d0)) {
        self.var_ccc321cb92e1d1d0 solid();
        self.var_ccc321cb92e1d1d0 disconnectPaths();
      }

      self disconnectPaths();
    } else {
      self movez(-150, n_time);
      self waittill("movedone");
      self delete();
    }

    if(istrue(self.script_delete)) {
      self delete();
    }

    return;
  }

  self delete();
}

function function_bfd5db9911f7056b() {
  power_doors = [];

  foreach(doorbuy in level.a_s_doorbuys) {
    if(doorbuy function_be31d2b54e616fb7()) {
      power_doors = utility::array_combine(power_doors, doorbuy.interact.doors);
    }
  }

  return power_doors;
}

function function_be31d2b54e616fb7() {
  var_e93d7bb6a32245f0 = isDefined(self.script_power) && issubstr(self.script_power, "power");
  var_1b8234fcdeb31e41 = isDefined(self.script_type) && (self.script_type == "power_open" || self.script_type == "power_transform");
  return var_e93d7bb6a32245f0 || var_1b8234fcdeb31e41;
}

function function_1071fb611dd3d29c() {
  level endon("game_ended");

  for(i = 0; i < level.players.size; i++) {
    if(isarray(level.players[i].c4s)) {
      foreach(c4 in level.players[i].c4s) {
        if(distance_2d_squared(c4.origin, self.origin) < 1280 && abs(c4.origin[2] - self.origin[2]) < 640) {
          c4 thread function_db6ccc8e1166190c();
        }
      }
    }
  }
}

function function_db6ccc8e1166190c() {
  level endon("game_ended");
  wait 1;
  scripts\mp\equipment\c4::sweepc4();
}

function function_b92412ffa0393ddc(func) {
  if(!isDefined(self.var_142cbdd8a88f8259)) {
    self.var_142cbdd8a88f8259 = [];
  }

  self.var_142cbdd8a88f8259 = utility::function_6d6af8144a5131f1(self.var_142cbdd8a88f8259, func);
}

function trigger_power(b_state, n_power_zone) {
  doors = function_bfd5db9911f7056b();
  var_27c8a0347a3bbcb7 = !isDefined(n_power_zone);

  foreach(door in doors) {
    var_f0b0324cf67d6487 = isDefined(door.script_int) && isDefined(n_power_zone) && door.script_int == n_power_zone;

    if(!var_f0b0324cf67d6487 && !var_27c8a0347a3bbcb7) {
      continue;
    }

    assert(isDefined(door.var_142cbdd8a88f8259), "<dev string:xe1>");

    foreach(func in door.var_142cbdd8a88f8259) {
      door thread[[func]](b_state);
    }
  }
}

function private function_395efcf15256ee0a(var_76c5a85ca21a69b9) {
  if(istrue(var_76c5a85ca21a69b9)) {
    thread open_doorbuy();
  }
}

function private function_596802105bfa5a98(var_76c5a85ca21a69b9) {
  if(istrue(var_76c5a85ca21a69b9)) {
    foreach(interact in self.a_interacts) {
      str_hint = interact function_eeb8c278274b96c3();
      interact interaction::function_c2efffe46a3f99d2(str_hint, interact.script_cost);
      interact sethintinoperable(0);
      interact setCursorHint("HINT_BUTTON");

      if(!utility::is_equal(self.script_noteworthy, "no_minimap")) {
        self.var_35e7c712de6487f6 freescriptable();
        self.var_35e7c712de6487f6 = spawnscriptable("cp_mp_doorbuy_minimap", self.origin, self.angles);
      }
    }
  }
}

function private function_e9c313af43b8ffa6() {
  door_type = self.script_type;

  if(!isDefined(door_type)) {
    if(function_be31d2b54e616fb7()) {
      door_type = "power_open";
    } else {
      return;
    }
  }

  switch (door_type) {
    case #"hash_40cb59b986cd76c7":
      foreach(door in self.interact.doors) {
        door function_b92412ffa0393ddc(&function_395efcf15256ee0a);
      }

      break;
    case #"hash_8ad550d7a39a5a2d":
      foreach(door in self.interact.doors) {
        door function_b92412ffa0393ddc(&function_596802105bfa5a98);
      }

      break;
  }
}

function function_a7ca20ea38e7dd83() {
  level.var_bbbe3abb95817b83 = 1;

  foreach(s_doorbuy in level.a_s_doorbuys) {
    if(isDefined(s_doorbuy.interact)) {
      s_doorbuy.interact thread doorbuy_used();
    }
  }

  level.var_bbbe3abb95817b83 = undefined;
}

function private function_67ce357c2e2478d7() {
  function_6e7290c8ee4f558b("<dev string:x116>");
  function_a9a864379a098ad6("<dev string:x126>", "<dev string:x13d>", &function_6a0e53758c9edf, 1);
  function_a9a864379a098ad6("<dev string:x154>", "<dev string:x169>", &function_a7ca20ea38e7dd83);
  function_fe953f000498048f();
}

function private function_6a0e53758c9edf() {
  var_39239d1f90650b = (0, 0, 4);
  var_e33953429ed350f = 0.25;

  while(true) {
    foreach(s_doorbuy in level.a_s_doorbuys) {
      if(!isDefined(s_doorbuy.interact)) {
        continue;
      }

      var_d8b783bf56b63a71 = "<dev string:x17e>";

      if(isDefined(s_doorbuy.script_tag) && s_doorbuy.interact tagexists(s_doorbuy.script_tag)) {
        v_position = s_doorbuy.interact gettagorigin(s_doorbuy.script_tag);
        var_d8b783bf56b63a71 = s_doorbuy.script_tag;
      } else if(s_doorbuy.interact tagexists("<dev string:x18c>")) {
        v_position = s_doorbuy.interact gettagorigin("<dev string:x18c>", 1);
        var_d8b783bf56b63a71 = "<dev string:x18c>";
      } else {
        v_position = s_doorbuy.interact.origin;
      }

      if(istrue(s_doorbuy.interact.var_9c58267a9b1f2155)) {
        level thread utility::draw_entity_bounds(s_doorbuy.interact, 0.05);
      } else {
        utility::draw_circle(v_position, s_doorbuy.interact.var_10a09b4e9dcdf2ed, (0, 0, 1), 1, 0, 1);
      }

      print3d(v_position, "<dev string:x198>" + s_doorbuy.script_currency, (0, 1, 0), 1, var_e33953429ed350f);
      print3d(v_position - var_39239d1f90650b, "<dev string:x1ab>" + s_doorbuy.script_cost, (0, 1, 0), 1, var_e33953429ed350f);
      var_3c6719c8aa252447 = "<dev string:x1b5>";
      var_f884de9f009c09b4 = "<dev string:x1b5>";

      if(isDefined(s_doorbuy.script_flag_set)) {
        var_b9249169199027bb = strtok(s_doorbuy.script_flag_set, "<dev string:x1b9>");

        foreach(str_flag in var_b9249169199027bb) {
          var_3c6719c8aa252447 = var_3c6719c8aa252447 + str_flag + "<dev string:x1b9>";
        }

        if(isDefined(level.zone_manager) && isarray(level.zone_manager.defs)) {
          foreach(zone_def in level.zone_manager.defs) {
            if(isarray(zone_def.adjacent_zones)) {
              foreach(str_zone, var_5b7050cf7b40f6de in zone_def.adjacent_zones) {
                if(isarray(var_5b7050cf7b40f6de.flags)) {
                  foreach(str_flag in var_5b7050cf7b40f6de.flags) {
                    if(utility::array_contains(var_b9249169199027bb, str_flag)) {
                      var_f884de9f009c09b4 = var_f884de9f009c09b4 + str_zone + "<dev string:x1b9>";
                      break;
                    }
                  }
                }
              }
            }
          }
        }
      }

      print3d(v_position - var_39239d1f90650b * 2, "<dev string:x1be>" + var_3c6719c8aa252447, (0, 1, 0), 1, 0.25);
      print3d(v_position - var_39239d1f90650b * 3, "<dev string:x1ce>" + var_f884de9f009c09b4, (0, 1, 0), 1, 0.25);
      print3d(v_position - var_39239d1f90650b * 4, "<dev string:x1e2>" + utility::default_to(s_doorbuy.script_power, "<dev string:x1b5>"), (0, 1, 0), 1, 0.25);

      if(istrue(s_doorbuy.interact.b_is_trigger)) {
        var_ab9799ccaf563cab = "<dev string:x1f2>";
        var_d8b783bf56b63a71 = "<dev string:x1b5>";
      } else {
        var_ab9799ccaf563cab = "<dev string:x1fd>";
        var_d8b783bf56b63a71 = "<dev string:x207>" + var_d8b783bf56b63a71 + "<dev string:x211>";
      }

      print3d(v_position - var_39239d1f90650b * 5, "<dev string:x216>" + var_ab9799ccaf563cab + var_d8b783bf56b63a71, (0, 1, 0), 1, 0.25);

      if(isarray(s_doorbuy.interact.doors)) {
        s_doorbuy.interact.doors = utility::array_removeundefined(s_doorbuy.interact.doors);

        foreach(door in s_doorbuy.interact.doors) {
          line(v_position, door.origin, (0, 0, 1));
          sphere(door.origin, 10, (0, 0, 1));

          if(door isscriptable()) {
            print3d(door.origin, "<dev string:x22b>", (0, 1, 0), 1, 0.25);
            continue;
          }

          print3d(door.origin, "<dev string:x244>", (0, 1, 0), 1, 0.25);
        }
      }
    }

    waitframe();
  }
}

# /