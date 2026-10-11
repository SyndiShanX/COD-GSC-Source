/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\incursion_waves.gsc
***********************************************/

#using script_324b68cb416acbec;
#using script_537a712b2be3193c;
#using script_5460cd6692149701;
#using script_68fa6b4ee60216ae;
#using scripts\anim\squadmanager;
#using scripts\common\utility;
#using scripts\cp\cp_aiparachute;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_outline;
#using scripts\cp\incursion_waves;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace incursion_waves;

function function_c07bd2e42ba41bc0() {
  level endon("game_ended");
  flag_init("wave_spawn_pause");
  level.var_8215ab0bbda0504f = [];
  level.var_8e6e84bcf72a908f = [];
  flag_wait("strike_init_done");

  if(!coop_mode_has("incursion_waves")) {
    return;
  }

  locations = getStructArray("objective_locations", "targetname");

  if(!isDefined(locations) || locations.size < 1) {
    return;
  }

  namespace_6d1c9cb20efeb350::main();
  namespace_7adb1ffcf7f14c91::main();
  function_c0493d69216f6d54();
  wave = 0;
  debug_wave = getdvarint(@ "hash_44f7a86af84d092c", 0);

  if(debug_wave != 0) {
    wave = debug_wave;
  }

  level.current_wave = wave;
  flag_wait("player_spawned_with_loadout");

  if(isDefined(level.var_61e4080758ea1943)) {
    function_6e2cf74c41de0afc();
  }

  level thread namespace_d9d93e01b62de24a::function_edbfa2ba7f3b537f();

  while(true) {
    wave++;
    debug_wave = getdvarint(@ "hash_20fdd1881ec96495", 0);

    if(debug_wave != 0) {
      wave = debug_wave;
    }

    level.current_wave = wave;
    level notify("incursion_wave_increase", level.current_wave);

    if(level.current_wave > 1) {
      wave_cooldown(30);
    }

    setomnvar("cp_wave_number", wave);

    foreach(player in level.players) {
      player thread scripts\cp\cp_hud_message::showsplash("cp_wave_started", level.current_wave, undefined);
    }

    function_577d509cdf72f199(wave);
    wait 2;

    foreach(player in level.players) {
      player thread scripts\cp\cp_hud_message::showsplash("cp_wave_ended", level.current_wave, undefined);
    }

    function_520db2326be2924e(wave);
    flag_waitopen("wave_spawn_pause");
  }
}

function wave_cooldown(wait_time) {
  level endon("game_ended");
  level notify("timeout_wave");
  level endon("timeout_wave");
  self endon("death");
  setomnvar("cp_countdown_color", 0);
  wave_timer = gettime() + wait_time * 1000;
  setomnvar("cp_wave_timer", int(wave_timer));

  if(wait_time - 10 > 0) {
    wait wait_time - 10;

    for(i = 0; i < 10; i++) {
      setomnvar("cp_countdown_color", 2);
      wait 1;
    }
  }

  setomnvar("cp_wave_timer", 0);
}

function function_7fbeeb5260c6fc5c(group) {
  new_type = function_912c529627d743d1();

  if(isDefined(new_type)) {
    switch (new_type) {
      case #"hash_e8cae19783883e47":
        function_ad08e7559ffc20a(group);
        break;
      case #"hash_963d0ba060e98ea7":
        function_63b46133c32e3c66(group);
        break;
      default:
        function_78a6d85f1d5c30af(group);
        break;
    }

    return;
  }

  function_8f1f42604edb1fd9();
}

function function_912c529627d743d1() {
  if(isDefined(self.unittype) && self.unittype == "juggernaut") {
    return undefined;
  }

  if(level.current_wave >= 15) {
    return "black_ops";
  } else if(level.current_wave >= 10) {
    return "commando";
  } else if(level.current_wave >= 5) {
    return "heavy";
  } else {
    return undefined;
  }

  return undefined;
}

function function_78a6d85f1d5c30af(group) {
  body = undefined;
  head = undefined;
  weapon = undefined;
  grenade_type = undefined;
  armor = 420;
  helmet = undefined;
  spawn_array = undefined;
  function_8f1f42604edb1fd9(body, head, weapon, grenade_type, armor, helmet, spawn_array);
}

function function_ad08e7559ffc20a(group) {
  body = "body_mp_milsim_balkan_sf_1_1";
  head = "head_mp_milsim_balkan_sf_1_1";
  weapon = scripts\cp_mp\weapon::buildweapon("iw8_ar_mike4_mp", ["thermal", "none", "none", "none", "none", "laserbalanced_mike4"], "none", "none");
  grenade_type = "flash_mp";
  armor = 630;
  helmet = 1;
  spawn_array = undefined;
  function_8f1f42604edb1fd9(body, head, weapon, grenade_type, armor, helmet, spawn_array);
  self.script_forcegrenade = 1;
}

function function_63b46133c32e3c66(group) {
  body = "body_mp_eastern_velikan_1_1";
  head = "head_mp_eastern_velikan_1_1";
  weapon = scripts\cp_mp\weapon::buildweapon("iw8_lm_mgolf36_mp", ["thermal", "none", "none", "none", "none", "none"], "none", "none");
  grenade_type = "semtex_mp";
  armor = 630;
  helmet = 1;
  spawn_array = undefined;
  function_8f1f42604edb1fd9(body, head, weapon, grenade_type, armor, helmet, spawn_array);
  self.script_forcegrenade = 1;
  self.accuracy = 0.4;
  self.health = 270;
}

function function_8f1f42604edb1fd9(body, head, weapon, grenade_type, armor, helmet, spawn_array) {
  if(isDefined(body)) {
    self setModel(body);
  }

  if(isDefined(head)) {
    if(isDefined(self.headmodel)) {
      self detach(self.headmodel);
    }

    self attach(head, "", 1);
    self.headmodel = head;
  }

  if(isDefined(armor)) {
    scripts\cp\spawning::give_soldier_armor();
    self.equip_armor = 1;
    self.armor_health = armor;
    self.allowpain = 0;
  }

  if(isDefined(helmet)) {
    scripts\cp\spawning::give_soldier_helmet();
  }

  self.goalradius = 800;

  if(getdvarint(@ "hash_8de63a2e6037a1f9", 420) != 420) {
    self.armor_health = getdvarint(@ "hash_8de63a2e6037a1f9");
  }

  if(isDefined(weapon)) {
    if(isDefined(self.weapon)) {
      self takeweapon(self.weapon);
    }

    self.weapon = weapon;
    utility::initweapon(self.weapon);
    self giveweapon(self.weapon);
    self setspawnweapon(self.weapon);
    self.bulletsinclip = weaponclipsize(self.weapon);
    self.primaryweapon = self.weapon;
  }

  if(isDefined(grenade_type)) {
    self.grenadeweapon = makeweapon(grenade_type);
    self.grenadeammo = 2;
  }

  thread namespace_d9d93e01b62de24a::function_9c0fbe62c1b9d660();
  thread watchchangeweapon();
  function_38e18ac0e9dffaf1(spawn_array);
  delaythread(3, &function_130532172349e887);
  thread function_ad05e00ece389a29();
  thread function_596d07facb536bbc();
  thread update_spawn_data_on_death();
  self.wave_spawn = 1;
  return self;
}

function function_130532172349e887() {
  self.allowlongdeath = 0;
}

function function_ad05e00ece389a29() {
  self endon("death");
  wait 2;

  if(isDefined(self.ridingvehicle)) {
    self.ridingvehicle waittill("unloaded");
  }
}

function update_spawn_data_on_death() {
  self endon("stop_death_watcher");
  thread function_f5c40ab76d02f395();
  msg = waittill_any_return_2("death", "long_death");

  if(msg == "long_death") {
    test = 1;
  }

  if(istrue(self.died_poorly)) {
    return;
  }

  if(isDefined(self.damagemod)) {
    if(self.damagemod == "MOD_SUICIDE") {
      return;
    }
  }

  level.var_bae0ff6d10c1e7d8++;
}

function function_f5c40ab76d02f395() {
  self endon("death");
  self waittill("entervehicle");
  waitframe();

  if(isDefined(self.vehicle_position)) {
    if(self.vehicle_position == 0) {
      self notify("stop_death_watcher");
    }

    if(self.vehicle_position == 1) {
      self notify("stop_death_watcher");
    }
  }
}

function watchchangeweapon() {
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    objweapon = self getcurrentweapon();

    if(isDefined(objweapon)) {
      dochangeweapon(objweapon);
    }

    self waittill("weapon_change");
  }
}

function dochangeweapon(objweapon) {
  scripts\cp\weapon::updatelauncherusage();
  scripts\cp\weapon::updatedragonsbreath(objweapon);
}

function function_1c225fe307735a4e() {
  level.current_wave += 1;

  foreach(player in level.players) {
    player thread scripts\cp\cp_hud_message::showsplash("cp_wave_started", level.current_wave, undefined);
  }

  wait 1;
  setomnvar("cp_wave_number", level.current_wave);
  wait 2;
  function_577d509cdf72f199(level.current_wave);
  function_520db2326be2924e(level.current_wave);
}

function function_a8029b288749d0d5(wave_type, goalradius, var_4aa0f44c1a6b235f) {
  position = scripts\cp\incursion_waves::function_a4bc93565e7da7dc();
  pos_struct = spawnStruct();
  pos_struct.origin = position;
  pos_struct.angles = (0, 0, 0);
  squad_list = namespace_6d1c9cb20efeb350::squad_get(wave_type);

  if(isDefined(var_4aa0f44c1a6b235f)) {
    squad_list = var_4aa0f44c1a6b235f;
  }

  all_enemies = [];
  spawnpoint = namespace_7adb1ffcf7f14c91::spawnpoint_choose(pos_struct, 5000, 2000);
  enemies = undefined;

  if(wave_type == "riot") {
    enemies = function_3470ae2ea5d473db(spawnpoint);
  } else {
    enemies = function_a9b9234c0760c45e(spawnpoint, squad_list, goalradius);
  }

  return enemies;
}

function function_3470ae2ea5d473db(spawnpoint) {
  var_45c5d4d61773b0b9 = namespace_d9d93e01b62de24a::ai_spawn("actor_enemy_cp_rus_riotshield", spawnpoint, 0, 128);
  guy1 = namespace_d9d93e01b62de24a::ai_spawn("actor_enemy_cp_rus_desert_smg", spawnpoint, 1, 128);
  guy2 = namespace_d9d93e01b62de24a::ai_spawn("actor_enemy_cp_rus_desert_smg", spawnpoint, 1, 128);
  var_45c5d4d61773b0b9 thread namespace_d9d93e01b62de24a::function_9c0fbe62c1b9d660();
  guy1 setgoalentity(var_45c5d4d61773b0b9, 1000);
  guy2 setgoalentity(var_45c5d4d61773b0b9, 1000);
  enemies = [var_45c5d4d61773b0b9, guy1, guy2];

  foreach(guy in enemies) {
    guy function_38e18ac0e9dffaf1();
  }

  return enemies;
}

function function_38e18ac0e9dffaf1(var_da87f68719e2b303) {
  function_e6d574e5d6613546(var_da87f68719e2b303);
  thread function_b23e29727caf4c44();
}

function function_e6d574e5d6613546(var_da87f68719e2b303) {
  if(!isDefined(level.var_603f2855fc89966)) {
    level.var_603f2855fc89966 = [];
  }

  key = level.current_wave;

  if(isDefined(var_da87f68719e2b303)) {
    key = var_da87f68719e2b303;
  }

  if(!isDefined(level.var_603f2855fc89966[key])) {
    level.var_603f2855fc89966[key] = [self];
    return;
  }

  current = level.var_603f2855fc89966[key];
  level.var_603f2855fc89966[key] = array_combine_unique(current, [self]);
}

function function_b23e29727caf4c44() {
  self waittill("death");

  foreach(key, spawned_array in level.var_603f2855fc89966) {
    new_array = undefined;
    removed = undefined;

    foreach(spawned_guy in spawned_array) {
      if(self == spawned_guy) {
        removed = 1;

        if(isDefined(new_array)) {
          new_array = array_remove(new_array, self);
          continue;
        }

        new_array = array_remove(spawned_array, self);
      }
    }

    if(isDefined(removed)) {
      if(!isDefined(new_array) || new_array.size == 0) {
        level.var_603f2855fc89966[key] = undefined;
        continue;
      }

      level.var_603f2855fc89966[key] = new_array;
    }
  }
}

function function_524c83c2668954ea() {
  org = level.players[0].origin;

  if(!isDefined(level.var_9d8c80df4ff60185)) {
    level.var_9d8c80df4ff60185 = 0;
  }

  if(isalive(level.players[level.var_9d8c80df4ff60185])) {
    org = level.players[level.var_9d8c80df4ff60185].origin;
    level.var_9d8c80df4ff60185 += 1;

    if(!isDefined(level.players[level.var_9d8c80df4ff60185])) {
      level.var_9d8c80df4ff60185 = 0;
    }
  }

  return org;
}

function function_9c1525e5e9da73f2(module_name, spawner_name, min_override, max_override, num_override) {
  max_dist = 4000;

  if(isDefined(max_override)) {
    max_dist = max_override;
  }

  min_dist = 2500;

  if(isDefined(min_override)) {
    min_dist = min_override;
  }

  min_dist_sq = min_dist * min_dist;
  spawners = [];
  num = 5;

  if(isDefined(num_override)) {
    num = num_override;
  }

  if(!isDefined(spawner_name)) {
    spawner_name = "wave_spawn_heli";
  }

  spawner_array = getStructArray(spawner_name, "targetname");
  org = function_524c83c2668954ea();
  var_eeca462ce9f2a320 = sortbydistancecullbyradius(spawner_array, org, max_dist);

  if(!isDefined(var_eeca462ce9f2a320) || var_eeca462ce9f2a320.size == 0) {
    var_eeca462ce9f2a320 = sortbydistance(spawner_array, org);

    for(i = 0; i < var_eeca462ce9f2a320.size; i++) {
      if(!isDefined(var_eeca462ce9f2a320[i].active)) {
        spawners[spawners.size] = var_eeca462ce9f2a320[i];

        if(spawners.size > num) {
          break;
        }
      }
    }

    return spawners;
  }

  for(i = 0; i < var_eeca462ce9f2a320.size; i++) {
    if(distancesquared(org, var_eeca462ce9f2a320[i].origin) > min_dist_sq) {
      spawners[spawners.size] = var_eeca462ce9f2a320[i];

      if(spawners.size > num) {
        break;
      }
    }
  }

  if(spawners.size > 0) {
    spawners = array_randomize(spawners);
  } else {
    test = 1;
  }

  return spawners;
}

function function_fd5721a770f0b9c9(type_array, spawner_list, var_1dbea318de624f2e) {
  foreach(spawner in spawner_list) {
    spawner.script_noteworthy = type_array;

    if(isDefined(var_1dbea318de624f2e)) {
      if(issubstr(var_1dbea318de624f2e, "mindia")) {
        spawner.script_function = "mindia8";
        continue;
      }

      spawner.script_function = "lbravo_carrier";
    }
  }
}

function timeout_wave(timer) {
  level endon("wave_ended");
  wait timer;
  level notify("stop_wave");

  if(isDefined(level.var_603f2855fc89966[level.current_wave])) {
    foreach(guy in level.var_603f2855fc89966[level.current_wave]) {
      guy scripts\cp\spawning::script_kill_ai();
    }
  }
}

function function_577d509cdf72f199(wave_num) {
  level endon("stop_wave");
  level thread timeout_wave(300);

  if(!isDefined(level.var_603f2855fc89966)) {
    level.var_603f2855fc89966 = [];
  }

  if(!isDefined(level.var_603f2855fc89966[level.current_wave])) {
    level.var_603f2855fc89966[level.current_wave] = [];
  }

  spawn_style = ["ground", "paratrooper", "lbravo", "mindia"];
  var_2c5831beac142a62 = ["smg", "ar", "lmg"];
  level.total_spawns = 12;
  level.current_spawns = 0;
  var_1a811cf4b557c3c9 = 12;
  level.var_bae0ff6d10c1e7d8 = 0;
  level.var_f09a19ac00f88108 = [];
  wave_num %= 5;

  switch (wave_num) {
    case 1:
      var_2c5831beac142a62 = ["smg", "shotgun"];
      break;
    case 2:
      var_2c5831beac142a62 = ["smg", "ar"];
      break;
    case 3:
      var_2c5831beac142a62 = ["smg", "rpg", "ar", "ar"];
      break;
    case 4:
      var_2c5831beac142a62 = ["lmg", "ar"];
      break;
    case 5:
      if(level.current_wave < 10) {
        spawn_style = ["mindia_jugg_boss"];
        var_2c5831beac142a62 = ["juggernaut"];
        level.total_spawns = 6;
      } else {
        spawn_style = ["mindia_jugg_boss"];
        var_2c5831beac142a62 = ["juggernaut"];
        level.total_spawns = 6;
      }

      break;
    case 6:
      var_2c5831beac142a62 = ["smg", "ar"];
      level.total_spawns *= 1.5;
      break;
    case 7:
      var_2c5831beac142a62 = ["smg", "rpg", "ar", "ar"];
      level.total_spawns *= 2;
      break;
    case 8:
      var_2c5831beac142a62 = ["lmg"];
      level.total_spawns *= 2;
      break;
    case 9:
      var_2c5831beac142a62 = ["lmg", "ar"];
      level.total_spawns *= 2;
      break;
    case 0:
      spawn_style = ["mindia_jugg_boss"];
      var_2c5831beac142a62 = ["juggernaut"];
      level.total_spawns = 12;
      break;
    default:
      type_array = "lmg";
      break;
  }

  while(level.var_bae0ff6d10c1e7d8 < level.total_spawns) {
    level.current_spawns = 0;

    if(isDefined(level.var_603f2855fc89966[level.current_wave])) {
      level.current_spawns = level.var_603f2855fc89966[level.current_wave].size;
    }

    var_bbbc0b66aa0597bc = level.total_spawns - level.current_spawns - level.var_bae0ff6d10c1e7d8;
    var_55136654a2e10edd = var_1a811cf4b557c3c9 - level.current_spawns;
    space_available = min(var_bbbc0b66aa0597bc, var_55136654a2e10edd);

    if(space_available > 0) {
      if(space_available < 12) {
        if(array_contains(spawn_style, "mindia")) {
          spawn_style = array_remove(spawn_style, "mindia");
        }

        if(spawn_style.size == 0) {
          spawn_style[0] = "lbravo";
        }
      }

      spawn_method = random(spawn_style);
      spawn_request = 3;

      if(level.var_f09a19ac00f88108.size > 0) {
        spawn_method = "ground";
        spawn_request = level.var_f09a19ac00f88108.size;
      } else {
        switch (spawn_method) {
          case #"hash_3001c424b2e29f75":
            spawn_request = 6;
            break;
          case #"hash_9f7523757b8fae7b":
            spawn_request = 1;
            break;
          case #"hash_8d96201d150187de":
            spawn_request = min(space_available, 3);
            break;
          case #"hash_9289d87f8116e31a":
            spawn_request = 6;
            break;
          case #"hash_79dd32c8d8093d05":
            spawn_request = 6;
            break;
          case #"hash_2c7808fa88619df3":
            spawn_request = 12;
            break;
        }
      }

      if(space_available < spawn_request) {} else {
        switch (spawn_method) {
          case #"hash_8d96201d150187de":
            var_4aa0f44c1a6b235f = undefined;

            if(level.var_f09a19ac00f88108.size > 0) {
              var_4aa0f44c1a6b235f = level.var_f09a19ac00f88108;
            }

            level.var_1c53f5de9489edd5 = spawn_request;
            var_94a1f19adc274198 = spawn_request;
            function_6d2bbb090901ad4b(var_2c5831beac142a62, var_4aa0f44c1a6b235f, var_94a1f19adc274198);
            break;
          case #"hash_9289d87f8116e31a":
            function_fa504167aded72b7(var_2c5831beac142a62);
            break;
          case #"hash_79dd32c8d8093d05":
            function_5fed65420fe0e2f6(var_2c5831beac142a62);
            break;
          case #"hash_2c7808fa88619df3":
            function_5c3ba13998974994(var_2c5831beac142a62);
            break;
          case #"hash_9f7523757b8fae7b":
            function_dc6162964ac57914(var_2c5831beac142a62);
            break;
          case #"hash_3001c424b2e29f75":
            function_4b2120b98910a4b6(var_2c5831beac142a62);
            break;
          default:
            break;
        }
      }

      wait 5;
      continue;
    }

    wait 5;
  }

  level notify("wave_ended");
}

function function_e3bc33935bae107f() {
  var_cc900cb112348987 = ["wave_spawn_heli", "wave_spawn_ground"];
  num = 0;

  foreach(group_name in var_cc900cb112348987) {
    if(isDefined(level.spawn_module_structs_memory[group_name])) {
      foreach(group in level.spawn_module_structs_memory[group_name]) {
        num += group.totalspawns;
      }
    }

    if(isDefined(level.active_spawn_module_structs[group_name])) {
      foreach(group in level.active_spawn_module_structs[group_name]) {
        num += group.totalspawns;
      }
    }
  }

  return num;
}

function function_613013012fba0b7a(var_2c5831beac142a62, var_4aa0f44c1a6b235f) {
  var_1dbea318de624f2e = "wave_spawn_ground";
  type_array = "";

  foreach(element in var_2c5831beac142a62) {
    type_array += element + " ";
  }

  level.ambientgroups[var_1dbea318de624f2e].spawn_points = function_9c1525e5e9da73f2(var_1dbea318de624f2e, "wave_spawn_ground", 1200, 2500, 15);
  function_50ebf0ac0d810885(level.ambientgroups[var_1dbea318de624f2e].spawn_points);
  function_fd5721a770f0b9c9(type_array, level.ambientgroups[var_1dbea318de624f2e].spawn_points, var_1dbea318de624f2e);
  group = scripts\cp\spawning::run_spawn_module(var_1dbea318de624f2e);
  level waittill("group_" + "wave_spawn_ground" + "_post_module_complete");
  return 3;
}

function function_6d2bbb090901ad4b(var_2c5831beac142a62, var_4aa0f44c1a6b235f, var_94a1f19adc274198) {
  var_1dbea318de624f2e = "wave_spawn_ground";
  type_array = "";

  foreach(element in var_2c5831beac142a62) {
    type_array += element + " ";
  }

  spawners = function_9c1525e5e9da73f2(var_1dbea318de624f2e, "wave_spawn_ground", 1200, 2500, 15);

  if(spawners.size < 1) {
    return 0;
  }

  num_to_spawn = 3;

  if(isDefined(var_94a1f19adc274198)) {
    num_to_spawn = var_94a1f19adc274198;
  }

  num_spawned = function_ac3679951b7689c3(spawners, type_array, num_to_spawn);
  return num_spawned;
}

function function_fa504167aded72b7(var_2c5831beac142a62, var_4aa0f44c1a6b235f) {
  var_1dbea318de624f2e = "wave_spawn_heli";
  var_dce8057401c9c502 = function_9c1525e5e9da73f2(var_1dbea318de624f2e);
  spawn_point = random(var_dce8057401c9c502);
  type_array = "";

  foreach(element in var_2c5831beac142a62) {
    if(level.current_wave > 10) {
      element += "_heavy";
    }

    type_array += element + " ";
  }

  var_ee13026b48e61129 = [];
  offset_array = [-100, 0, 100];

  for(i = 0; i < 3; i++) {
    for(j = 0; j < 3; j++) {
      offset = (offset_array[i], offset_array[j], 0);
      new_spawn = spawnStruct();
      new_spawn.origin = spawn_point.origin + offset;
      new_spawn.targetname = "wave_spawn_paratrooper";
      new_spawn.script_noteworthy = type_array;
      var_ee13026b48e61129[var_ee13026b48e61129.size] = new_spawn;
    }
  }

  level.ambientgroups["wave_spawn_paratrooper"].spawn_points = var_ee13026b48e61129;
  ac130_spawn_loc = getStruct("ac130_spawn_loc", "targetname");
  group = scripts\cp\cp_aiparachute::request_paratroopers("wave_spawn_paratrooper", undefined, ac130_spawn_loc.origin, var_ee13026b48e61129);
  return 6;
}

function function_5c3ba13998974994(var_2c5831beac142a62) {
  var_1dbea318de624f2e = "wave_spawn_heli_mindia";
  type_array = "";

  foreach(element in var_2c5831beac142a62) {
    type_array += element + " ";
  }

  spawners = function_9c1525e5e9da73f2(var_1dbea318de624f2e);

  if(spawners.size < 1) {
    return 0;
  }

  function_fd5721a770f0b9c9(type_array, spawners, var_1dbea318de624f2e);
  veh_spawner = spawners[0];
  heli = spawn_heli(veh_spawner);

  if(isDefined(heli)) {
    num_to_spawn = 12;
    num_spawned = heli function_d0e3fc0f5e612280(veh_spawner, type_array, num_to_spawn);
    return num_spawned;
  }

  return 0;
}

function function_4b2120b98910a4b6(var_2c5831beac142a62) {
  var_1dbea318de624f2e = "wave_spawn_heli_mindia_jugg_boss";
  type_array = "";

  for(i = 0; i < 5; i++) {
    element = "ar";
    type_array += element + " ";
  }

  type_array += "juggernaut ";
  spawners = function_9c1525e5e9da73f2(var_1dbea318de624f2e);

  if(spawners.size < 1) {
    return 0;
  }

  function_fd5721a770f0b9c9(type_array, spawners, var_1dbea318de624f2e);
  veh_spawner = spawners[0];
  heli = spawn_heli(veh_spawner);

  if(isDefined(heli)) {
    num_to_spawn = 6;
    num_spawned = heli function_d0e3fc0f5e612280(veh_spawner, type_array, num_to_spawn);
    return num_spawned;
  }

  return 0;
}

function function_5fed65420fe0e2f6(var_2c5831beac142a62) {
  var_1dbea318de624f2e = "wave_spawn_heli";
  type_array = "";

  foreach(element in var_2c5831beac142a62) {
    type_array += element + " ";
  }

  spawners = function_9c1525e5e9da73f2(var_1dbea318de624f2e);

  if(spawners.size < 1) {
    return 0;
  }

  function_fd5721a770f0b9c9(type_array, spawners, var_1dbea318de624f2e);
  veh_spawner = spawners[0];
  heli = spawn_heli(veh_spawner);

  if(isDefined(heli)) {
    num_to_spawn = 6;
    num_spawned = heli function_d0e3fc0f5e612280(veh_spawner, type_array, num_to_spawn);
    return num_spawned;
  }

  return 0;
}

function function_1deaabec65389cb3(var_2c5831beac142a62, var_4aa0f44c1a6b235f) {
  var_1dbea318de624f2e = "wave_spawn_heli";
  type_array = "";

  foreach(element in var_2c5831beac142a62) {
    if(level.current_wave > 10) {
      element += "_heavy";
    }

    type_array += element + " ";
  }

  level.ambientgroups[var_1dbea318de624f2e].spawn_points = function_9c1525e5e9da73f2(var_1dbea318de624f2e);
  function_50ebf0ac0d810885(level.ambientgroups[var_1dbea318de624f2e].spawn_points);
  function_fd5721a770f0b9c9(type_array, level.ambientgroups[var_1dbea318de624f2e].spawn_points, var_1dbea318de624f2e);
  group = scripts\cp\spawning::run_spawn_module(var_1dbea318de624f2e);
  level waittill("group_" + var_1dbea318de624f2e + "_post_module_complete");
  return 6;
}

function spawn_heli(veh_spawner) {
  success = veh_spawner scripts\cp\spawning::spawn_vehicle_at_vehicle_spawner();

  if(success) {
    return veh_spawner.vehicle;
  }

  return undefined;
}

function function_ac3679951b7689c3(spawnpoint_list, type_array, num_to_spawn) {
  type_array = strtok(type_array, " ");
  squad_list = [];

  for(i = 0; i < num_to_spawn; i++) {
    index = i % type_array.size;
    squad_list[squad_list.size] = type_array[index];
  }

  num_spawned = spawn_ai_group(num_to_spawn, squad_list, spawnpoint_list);
  return num_spawned;
}

function function_d0e3fc0f5e612280(spawnpoint, type_array, num_to_spawn) {
  type_array = strtok(type_array, " ");
  spawn_threshold = 2;
  squad_list = ["smg", "smg"];

  for(i = 0; i < num_to_spawn; i++) {
    index = i % type_array.size;
    squad_list[squad_list.size] = type_array[index];
  }

  num_to_spawn += spawn_threshold;
  spawnpoint_list = [spawnpoint];
  num_spawned = spawn_ai_group(num_to_spawn, squad_list, spawnpoint_list);

  if(num_spawned > spawn_threshold) {
    return (num_spawned - spawn_threshold);
  }

  return 0;
}

function spawn_ai_group(num_to_spawn, squad_list, spawnpoint_list) {
  spawned = [];

  for(i = 0; i < num_to_spawn; i++) {
    var_2b3fe0e3fb0cd248 = get_aitype(squad_list, i);
    spawnpoint_index = i % spawnpoint_list.size;
    spawnpoint = spawnpoint_list[spawnpoint_index];
    soldier = spawnpoint scripts\cp\spawning::spawn_ai(undefined, undefined, var_2b3fe0e3fb0cd248);

    if(isDefined(soldier)) {
      soldier.dontkilloff = 1;
      soldier.aitype = squad_list[i];
      spawned[spawned.size] = soldier;
      soldier.spawnpoint = spawnpoint;
      spawnpoint notify("spawn_success", spawnpoint);
      level notify("spawned_group_soldier", soldier);
      level notify("ai_spawn_successful", soldier, spawnpoint, spawnpoint.origin);
      soldier namespace_f07a91c6c17492be::init();
      soldier thread function_7fbeeb5260c6fc5c();
      soldier function_9742a64af2d2ea49(spawnpoint);
    }

    wait 0.1;
  }

  if(spawned.size) {
    return spawned.size;
  }

  return 0;
}

function function_9742a64af2d2ea49(spawnpoint) {
  self endon("death");

  if(getdvarint(@ "hash_9bcca58e56e4c178", 0)) {
    scripts\cp\cp_outline::enable_outline_for_players(self, level.players, "<dev string:x1c>", "<dev string:x33>");
  }

  scripts\cp\spawning::node_fields_pre_goal(spawnpoint);
  thread scripts\cp\spawning::ai_watchforbadpath();
  scripts\anim\squadmanager::addtosquad();
  spawnpoint scripts\cp\spawning::function_ec648f2c89ea1c91();
  scripts\cp\spawning::function_389fff85c076f49e();
  scripts\cp\spawning::function_b395044780aac4();
  scripts\cp\spawning::function_b34ed4eafa93c760();

  if(isDefined(spawnpoint.script_function)) {
    if(isDefined(level.spawner_script_funcs[spawnpoint.script_function]) && isDefined(spawnpoint.ai_infil_type)) {
      self[[level.spawner_script_funcs[spawnpoint.script_function].script_function]](undefined, spawnpoint, spawnpoint.ai_infil_type);
    }
  }

  if(isDefined(spawnpoint.target)) {
    thread scripts\cp\spawning::enter_combat_after_go_to_node();
  } else {
    thread scripts\cp\spawning::enter_combat();
  }

  spawnpoint.aitype = undefined;
  return true;
}

function get_aitype(squad_list, index) {
  type = squad_list[index];

  if(level.current_wave > 5) {
    switch (type) {
      case #"hash_321a9678047d0a4e":
        break;
      case #"hash_4ad475e6e15635bd":
        break;
      default:
        type += "_heavy";
        break;
    }
  }

  return type;
}

function function_90186a2e3f2e6435(var_2c5831beac142a62, var_4aa0f44c1a6b235f) {
  var_1dbea318de624f2e = "wave_spawn_heli_mindia";
  type_array = "";

  foreach(element in var_2c5831beac142a62) {
    if(level.current_wave > 10) {
      element += "_heavy";
    }

    type_array += element + " ";
  }

  level.ambientgroups[var_1dbea318de624f2e].spawn_points = function_9c1525e5e9da73f2(var_1dbea318de624f2e);
  function_50ebf0ac0d810885(level.ambientgroups[var_1dbea318de624f2e].spawn_points);
  function_fd5721a770f0b9c9(type_array, level.ambientgroups[var_1dbea318de624f2e].spawn_points, var_1dbea318de624f2e);
  group = scripts\cp\spawning::run_spawn_module(var_1dbea318de624f2e);
  return 12;
}

function function_dc6162964ac57914(var_2c5831beac142a62, var_4aa0f44c1a6b235f) {
  var_1dbea318de624f2e = "wave_spawn_heli_mindia_jugg";
  type_array = "";
  spawners = function_9c1525e5e9da73f2(var_1dbea318de624f2e);
  function_fd5721a770f0b9c9(type_array, spawners, var_1dbea318de624f2e);
  group = scripts\cp\spawning::run_spawn_module(var_1dbea318de624f2e);
  function_50ebf0ac0d810885(spawners);
  return true;
}

function function_c7c757a184734bb7(var_2c5831beac142a62, var_4aa0f44c1a6b235f) {
  var_1dbea318de624f2e = "wave_spawn_heli_mindia_jugg_boss";
  type_array = "";
  spawners = function_9c1525e5e9da73f2(var_1dbea318de624f2e);
  function_fd5721a770f0b9c9(type_array, spawners, var_1dbea318de624f2e);

  foreach(spawner in spawners) {
    spawner.spawn_aitype_counts["ar"] = 7;
    spawner.spawn_aitype_counts["juggernaut"] = 1;
  }

  level.ambientgroups[var_1dbea318de624f2e].spawn_points = spawners;
  level.ambientgroups[var_1dbea318de624f2e].spawn_aitype_counts["juggernaut"] = 1;
  level.ambientgroups[var_1dbea318de624f2e].spawn_aitype_counts["ar"] = 7;
  group = scripts\cp\spawning::run_spawn_module(var_1dbea318de624f2e);
  wait 5;
  return 6;
}

function function_50ebf0ac0d810885(spawners) {
  foreach(spawner in spawners) {
    spawner.spawn_aitype_counts = undefined;
  }
}

function function_91e608317eb58eb2() {
  locations = getStructArray("objective_locations", "targetname");
  player_center = get_center_point_of_array(level.players);
  sorted = sortbydistance(locations, player_center);

  if(distance(sorted[2].origin, player_center) > 3000) {
    pos = random([sorted[2], sorted[3]]);
  } else {
    pos = sorted[sorted.size - 1];
  }

  if(isDefined(level.var_8215ab0bbda0504f) && level.var_8215ab0bbda0504f.size > 0) {
    pos = random(level.var_8215ab0bbda0504f);
  }

  return pos;
}

function spawn_dog(spawnpoint) {
  aitype = "actor_enemy_cp_dog";
  ai = namespace_d9d93e01b62de24a::ai_spawn(aitype, spawnpoint, 0);

  if(isDefined(ai)) {
    if(namespace_d9d93e01b62de24a::function_578d89786b7eda1()) {
      ai delaythread(1, &namespace_d9d93e01b62de24a::function_3ba1a006f4de9686);
    } else {
      ai thread namespace_d9d93e01b62de24a::function_9c0fbe62c1b9d660();
    }

    ai function_38e18ac0e9dffaf1();
    return ai;
  }

  return undefined;
}

function function_a9b9234c0760c45e(spawnpoint, squad_list, goalradius) {
  spawned = [];

  for(i = 0; i < squad_list.size; i++) {
    type = squad_list[i];
    aitype = "actor_enemy_cp_alq_desert_" + type;

    if(level.current_wave >= 10) {
      var_439b78048a60675 = "actor_enemy_cp_rus_desert_";

      if(type == "ar") {
        type = "ar_ak";
      }

      switch (type) {
        case #"hash_321a9678047d0a4e":
          aitype = "actor_enemy_cp_rus_riotshield";
          break;
        case #"hash_4ad475e6e15635bd":
          aitype = "actor_enemy_cp_rus_juggernaut";
          break;
        default:
          aitype = var_439b78048a60675 + type;
          break;
      }
    }

    ai = namespace_d9d93e01b62de24a::ai_spawn(aitype, spawnpoint, 0);

    if(isDefined(ai)) {
      spawned[spawned.size] = ai;
      ai.spawnpoint = spawnpoint;
      ai.aitype = type;
      ai function_38e18ac0e9dffaf1();
      ai function_7fbeeb5260c6fc5c();
      ai thread function_9742a64af2d2ea49(spawnpoint);
    }

    waitframe();
  }

  if(spawned.size) {
    return spawned;
  }

  return undefined;
}

function function_6edf7e31ca183bb8() {
  self.dontkilloff = 1;
  wait 2;
  self.dontkilloff = undefined;
}

function function_c0493d69216f6d54() {
  scripts\cp\spawning::registerambientgroup("wave_spawn_heli", 0, 8, 8, 0.1, 0, "wave_spawn_heli", undefined, undefined, undefined);
  scripts\cp\spawning::register_module_ai_spawn_func("wave_spawn_heli", &function_7fbeeb5260c6fc5c);
  scripts\cp\spawning::registerambientgroup("wave_spawn_heli_mindia", 0, 14, 14, 0.1, 0, "wave_spawn_heli", undefined, undefined, undefined);
  scripts\cp\spawning::register_module_ai_spawn_func("wave_spawn_heli_mindia", &function_7fbeeb5260c6fc5c);
  scripts\cp\spawning::registerambientgroup("wave_spawn_heli_mindia_jugg", 3, 3, 3, 0.1, 0, "wave_spawn_heli", undefined, undefined, undefined);
  scripts\cp\spawning::register_module_ai_spawn_func("wave_spawn_heli_mindia_jugg", &function_7fbeeb5260c6fc5c);
  scripts\cp\spawning::registerambientgroup("wave_spawn_heli_mindia_jugg_boss", 8, 8, 8, 0.1, 0, "wave_spawn_heli", undefined, undefined, undefined);
  scripts\cp\spawning::register_module_ai_spawn_func("wave_spawn_heli_mindia_jugg_boss", &function_7fbeeb5260c6fc5c);
  scripts\cp\spawning::registerambientgroup("wave_spawn_paratrooper", 0, 6, 6, 1, 0, "wave_spawn_paratrooper", undefined, undefined, undefined);
  scripts\cp\spawning::register_module_ai_spawn_func("wave_spawn_paratrooper", &function_7fbeeb5260c6fc5c);
  scripts\cp\spawning::set_spawn_scoring_params_for_group("wave_spawn_heli", undefined, 20000, 30000);
  scripts\cp\spawning::set_spawn_scoring_params_for_group("wave_spawn_heli_mindia", undefined, 20000, 30000);
  scripts\cp\spawning::set_spawn_scoring_params_for_group("wave_spawn_heli_mindia_jugg", undefined, 20000, 30000);
  scripts\cp\spawning::set_spawn_scoring_params_for_group("wave_spawn_heli_mindia_jugg_boss", undefined, 20000, 30000);
  scripts\cp\spawning::set_spawn_scoring_params_for_group("wave_spawn_paratrooper", undefined, 20000, 30000);
  level.var_432e8d8d2b997226 = [];
  level.var_432e8d8d2b997226["wave_spawn_heli"] = &function_3b5824a062991c2e;
  scripts\cp\spawning::registerambientgroup("wave_spawn_ground", &function_db68fe3eda64cc58, &function_db68fe3eda64cc58, &function_db68fe3eda64cc58, 0.1, 0, "wave_spawn_ground", undefined, undefined, undefined);
  scripts\cp\spawning::register_module_ai_spawn_func("wave_spawn_ground", &function_7fbeeb5260c6fc5c);
}

function function_3b5824a062991c2e() {
  var_dce8057401c9c502 = function_9c1525e5e9da73f2(undefined, "wave_spawn_ground");
  return var_dce8057401c9c502;
}

function function_db68fe3eda64cc58(group) {
  if(level.var_f09a19ac00f88108.size > 0) {
    return level.var_f09a19ac00f88108.size;
  }

  if(isDefined(level.var_1c53f5de9489edd5)) {
    return level.var_1c53f5de9489edd5;
  }

  return 3;
}

function function_596d07facb536bbc() {
  self endon("death");
  dist = 1800;
  dist_sq = dist * dist;
  far_dist = 2400;
  far_dist_sq = far_dist * far_dist;
  var_a888435e0d19392d = 3400;
  var_45fafae5d6358b8a = var_a888435e0d19392d * var_a888435e0d19392d;
  self.goalradius = 32;
  self.hunt_state = "get_closer";

  while(true) {
    enemy = level.players[0];

    if(!enemy scripts\cp\utility::is_valid_player()) {
      if(isDefined(level.players[1])) {
        enemy = level.players[1];
      }
    }

    if(isDefined(self.enemy)) {
      enemy = self.enemy;
    }

    if(!isDefined(enemy)) {
      wait 1;
      continue;
    }

    if(istrue(self.playing_skit)) {
      wait 1;
      continue;
    }

    if(self.hunt_state == "get_closer_fast") {
      self.goalradius = 32;
      self.scripted_mode = 1;
      scripts\cp\spawning::set_demeanor_from_unittype("sprint");

      if(distancesquared(self.origin, enemy.origin) > far_dist_sq) {
        self setgoalpos(enemy.origin);
      } else {
        self.hunt_state = "get_closer";
        self setgoalpos(self.origin);
      }
    } else if(self.hunt_state == "get_closer") {
      self.goalradius = 32;
      self.scripted_mode = 1;
      scripts\cp\spawning::set_demeanor_from_unittype("combat");

      if(distancesquared(self.origin, enemy.origin) > dist_sq) {
        self setgoalpos(enemy.origin);
      } else {
        self.hunt_state = "close_enough";
        self setgoalpos(self.origin);
      }
    } else {
      self.goalradius = 1500;
      self.scripted_mode = 0;
      how_far = distancesquared(self.origin, enemy.origin);

      if(how_far > var_45fafae5d6358b8a) {
        self.hunt_state = "get_closer_fast";
      } else if(how_far > far_dist_sq) {
        self.hunt_state = "get_closer";
      }
    }

    wait 1;
  }
}

function function_fdac8f6f00e7c3f2(loc) {
  level.var_8215ab0bbda0504f = array_add_safe(level.var_8215ab0bbda0504f, loc);
  level.var_8e6e84bcf72a908f = array_add_safe(level.var_8e6e84bcf72a908f, loc);
}

function function_afde497917cef48d(loc) {
  level.var_8215ab0bbda0504f = array_remove(level.var_8215ab0bbda0504f, loc);
}

function function_c1dc7a1d01595216() {
  player_pos = function_a4bc93565e7da7dc();
  hardpoints = level.var_8215ab0bbda0504f;

  if(!hardpoints.size) {
    return undefined;
  }

  return getclosest(player_pos, hardpoints);
}

function function_a4bc93565e7da7dc() {
  if(!isDefined(level.player_to_spawn_on)) {
    level.player_to_spawn_on = level.players[0];
  } else {
    foreach(player in level.players) {
      if(player == level.player_to_spawn_on) {
        continue;
      }

      if(player is_valid_player()) {
        level.player_to_spawn_on = player;
      }
    }
  }

  return level.player_to_spawn_on.origin;
}

function function_6e2cf74c41de0afc() {
  [[level.var_61e4080758ea1943]]();
}

function function_5775b1927fd651c4(squad_list, thresh, force_spawnpoint, wait_for_killed) {
  position = function_91e608317eb58eb2();
  spawnpoint = namespace_7adb1ffcf7f14c91::spawnpoint_choose(position, 5000, 3000);

  if(!isDefined(squad_list)) {
    squad_list = namespace_6d1c9cb20efeb350::squad_get("ar_smg");
  }

  enemies = function_a9b9234c0760c45e(spawnpoint, squad_list, 800);

  if(!isDefined(thresh)) {
    thresh = 1;
  }

  if(istrue(wait_for_killed)) {
    namespace_d9d93e01b62de24a::function_e4f3059610095250(enemies, 1);
  }
}

function function_520db2326be2924e(wave_num) {
  if(isDefined(level.var_62ed34c7e289d568)) {
    [[level.var_62ed34c7e289d568]](wave_num);
  }
}