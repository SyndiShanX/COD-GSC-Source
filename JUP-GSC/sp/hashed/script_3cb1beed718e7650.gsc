/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3cb1beed718e7650.gsc
*************************************************/

#using script_102d83a437e2b29f;
#using script_125aff4134a8d5af;
#using script_24e4405cf93f20ed;
#using script_4bac13d511590220;
#using script_f3b4a4783ede654;
#using script_f603f40349f99c8;
#using scripts\common\ai;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_lights;
#using scripts\common\vehicle_paths;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\vehicles;
#using scripts\cp\vehicles\damage_cp;
#using scripts\cp\weapon;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\turret_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_compass;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\debug;
#using scripts\vehicle\vehicle_common;
#namespace namespace_48d38898a22ee3d7;

function private function_db971fccae2d6b8b() {}

function function_c6a62b7a2794062a() {
  level thread function_c0e79e0eccc47ce3();
  setdvarifuninitialized(@ "hash_18e48e8099801eb", 1);

  setdvarifuninitialized(@ "debug_turret", "<dev string:x1c>");
  setdvarifuninitialized(@ "hash_b33dfa2c5d1b92db", 0);
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1e>");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x3a>", "<dev string:x50>");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x5d>", "<dev string:x70>");
  scripts\common\devgui::function_fe953f000498048f();

  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setweaponhitdamagedata("c4_mp", 8);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setweaponhitdamagedata("c4_cp", 8);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setweaponhitdamagedata("jup_c4_mp", 8);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setweaponhitdamagedata("jup_c4_cp", 8);
  scripts\cp\vehicles\damage_cp::function_d508766fa2962e37("toma_proj_jup_mp");
  scripts\cp\vehicles\damage_cp::function_d508766fa2962e37("auto_drone_proj_mp");
  scripts\cp\vehicles\damage_cp::function_d508766fa2962e37("artillery_mp");
  function_dc1dc0ca4ebbffff();
  function_ddc83442e3d668a2();

  level thread function_b3e7de6bb615773f();
}

function function_c0e79e0eccc47ce3() {
  flag_wait("create_script_initialized");
}

function function_136d8a6a5c016d7e(veh_spawner, ai_spawners, pathing_type, var_758e6be9fd2019ee, var_4c4bc1e869f20e26) {
  pathing_type = default_to(pathing_type, "p2p");
  var_4c4bc1e869f20e26 = default_to(var_4c4bc1e869f20e26, 0);
  vehicle = function_a383f70a02485829(veh_spawner, ai_spawners);

  if(!isDefined(vehicle)) {
    return undefined;
  }

  if(vehicle scripts\common\vehicle::ishelicopter()) {
    if((isDefined(veh_spawner.target) || isDefined(var_758e6be9fd2019ee)) && pathing_type != "none" && !istrue(veh_spawner.nopath)) {
      level delaythread(1, &function_7341a0e079d4d2c8, vehicle, veh_spawner, vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd());
    }

    return vehicle;
  }

  if(isDefined(veh_spawner.var_5bbf95f73f01706e)) {
    vehicle.var_5bbf95f73f01706e = veh_spawner.var_5bbf95f73f01706e;
  }

  if(isDefined(veh_spawner.goal_threshold)) {
    vehicle.goal_threshold = veh_spawner.goal_threshold;
  }

  if(isDefined(veh_spawner.forced_speed)) {
    vehicle.forced_speed = veh_spawner.forced_speed;
  }

  if(isDefined(veh_spawner.force_speed)) {
    vehicle.forced_speed = veh_spawner.force_speed;
  }

  if(!isDefined(veh_spawner.target) && !isDefined(var_758e6be9fd2019ee) || pathing_type == "none" || istrue(veh_spawner.nopath)) {
    return vehicle;
  }

  var_7a57641a11395e2d = undefined;
  path_start = undefined;

  if(isDefined(var_758e6be9fd2019ee)) {
    if(isstring(var_758e6be9fd2019ee)) {
      var_7a57641a11395e2d = var_758e6be9fd2019ee;
    } else if(isstruct(var_758e6be9fd2019ee)) {
      var_7a57641a11395e2d = var_758e6be9fd2019ee.targetname;
      path_start = var_758e6be9fd2019ee;
    } else if(isnode(var_758e6be9fd2019ee)) {
      var_7a57641a11395e2d = var_758e6be9fd2019ee.targetname;
      path_start = var_758e6be9fd2019ee;
    }
  } else {
    var_7a57641a11395e2d = veh_spawner.target;
  }

  if(!isDefined(path_start) && isDefined(var_7a57641a11395e2d)) {
    path_start = function_f0144da019d3204e(var_7a57641a11395e2d);
  }

  if(!isDefined(path_start) && !isDefined(var_7a57641a11395e2d)) {
    return;
  }

  if(isDefined(path_start) && !isDefined(path_start.angles)) {
    path_start.angles = (0, 0, 0);
  }

  if(!var_4c4bc1e869f20e26) {
    vehicle vehicle_teleport(path_start.origin, path_start.angles);
  }

  if(isDefined(path_start)) {
    switch (pathing_type) {
      case #"hash_8a33376c5284ae95":
        vehicle thread function_bab28ad00f02cf47(path_start);
        break;
      case #"hash_bb4e2beab760add4":
      case #"hash_db187e91b8481c6a":
        vehicle thread function_4971980ce1dda1fb(path_start);
        break;
      case #"hash_80496a95e817dfc":
        vehicle thread function_6770ea8fb26804bf(path_start);
        break;
      case #"hash_5d790c92015e111f":
        vehicle thread function_ddaa9e960832374e(path_start);
        break;
      case #"hash_57be474cb2e03ce6":
        vehicle thread function_580dffaaa0d4b3a9(var_7a57641a11395e2d);
        break;
      case #"hash_9144672328a7bf30":
        vehicle thread function_b8b5f6a755675b1(var_7a57641a11395e2d);
        break;
      case #"hash_db653a4972b3c13b":
      default:
        break;
    }
  }

  return vehicle;
}

function function_a383f70a02485829(veh_spawner, ai_spawners) {
  if(getDvar(@ "hash_742caa13b3c2e685") == "1") {
    return;
  }

  assertex(isDefined(veh_spawner), "dungeon_vehicle_spawngroup - no vehicle spawner defined");
  riders = [];
  alias = undefined;
  alias_data = undefined;
  seatindex = 0;
  var_b5424ebe989b94b4 = 0;
  var_ce466b5e28c4827d = 0;
  var_882160ef04cd8207 = 0;
  spawners = undefined;
  needs_riders = isDefined(veh_spawner.spawngroup) || isDefined(ai_spawners) || isDefined(veh_spawner.script_vehiclegroup);

  if(isDefined(veh_spawner.script_vehiclegroup)) {
    veh_spawner.spawngroup = veh_spawner.script_vehiclegroup;
    veh_spawner.script_vehiclegroup = undefined;
  }

  veh_team = default_to(veh_spawner.script_team, "axis");
  vehicle_ref = scripts\cp\cp_spawning_util::function_30c929b6490aaa38(veh_spawner);

  if(isDefined(veh_spawner.script_function)) {
    alias = veh_spawner.script_function;
    alias_data = function_2c780304448a233b(alias);

    if(isDefined(alias_data) && isDefined(alias_data.vehicle_ref)) {
      vehicle_ref = alias_data.vehicle_ref;
    }
  }

  if(isDefined(veh_spawner.ref_override)) {
    vehicle_ref = veh_spawner.ref_override;
  }

  assertex(isDefined(vehicle_ref), "dungeon_vehicle_spawngroup - No supported vehicle ref or alias found. Check vehicletype list.");
  ref_data = scripts\cp_mp\vehicles\vehicle::function_29b4292c92443328(vehicle_ref);
  max_riders = ref_data.aiseats.size;

  if(needs_riders) {
    riders = function_c1c8efc410395e96(ref_data, veh_spawner, ai_spawners, vehicle_ref);
  }

  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(vehicle_ref, veh_spawner);

  if(!isDefined(vehicle)) {
    assertmsg("dungeon_vehicle_spawngroup - Vehicle wasn't spawned. Check vehicletypes above.");
    return undefined;
  }

  vehicle.vehicle_spawner = veh_spawner;
  vehicle.var_7ee6203c5532a9e6 = 1;

  if(!isDefined(vehicle.classname_mp) && isDefined(veh_spawner.classname_mp)) {
    vehicle.classname_mp = veh_spawner.classname_mp;
  }

  if(isDefined(veh_spawner.var_bb38e84f2964aa8a)) {
    if(isstring(veh_spawner.var_bb38e84f2964aa8a)) {
      veh_spawner.var_bb38e84f2964aa8a = int(veh_spawner.var_bb38e84f2964aa8a);
    }

    vehicle.var_bb38e84f2964aa8a = veh_spawner.var_bb38e84f2964aa8a;
  }

  if(isDefined(veh_spawner.var_a4d76f90d6916d81)) {
    vehicle.var_a4d76f90d6916d81 = veh_spawner.var_a4d76f90d6916d81;
  }

  level notify("spawned_vehicle");

  if(vehicle scripts\cp_mp\vehicles\vehicle::vehiclecanfly() || vehicle scripts\common\vehicle::ishelicopter()) {
    if(isDefined(alias)) {
      vehicle.alias = alias;
    }
  }

  if(riders.size > 0) {
    if(vehicle scripts\common\vehicle::ishelicopter()) {
      if(!istrue(veh_spawner.skip_init)) {
        vehicle function_3dc9f009b066c5ef(needs_riders);
      }

      foreach(rider in riders) {
        if(!isDefined(rider) || !isalive(rider)) {
          continue;
        }

        if(is_equal(rider.script_startingposition, 0)) {
          var_ce466b5e28c4827d = 1;
          continue;
        }

        if(is_equal(rider.script_startingposition, 1)) {
          var_882160ef04cd8207 = 1;
        }
      }

      if(!isDefined(vehicle.var_a4d76f90d6916d81) || istrue(vehicle.var_a4d76f90d6916d81)) {
        function_63a4589af5fb207c(vehicle, var_ce466b5e28c4827d, var_882160ef04cd8207);
      }

      vehicle.riders = riders;
      availablepositionsstruct = vehicle scripts\common\vehicle_aianim::get_availablepositions();

      foreach(rider in riders) {
        if(!isDefined(rider) || !isalive(rider)) {
          continue;
        }

        rider.vehicle = vehicle;
        pos = vehicle scripts\common\vehicle_aianim::choose_vehicle_position(rider, availablepositionsstruct, 0);
        rider scripts\vehicle\vehicle_common::entervehicle(vehicle, 1, pos, scripts\common\vehicle_aianim::anim_pos(vehicle, pos.vehicle_position));

        if(!isDefined(rider) || !isalive(rider)) {
          continue;
        }

        rider.vehicle_position = pos.vehicle_position;

        if(rider function_551cd59ad7fc3375(vehicle_ref)) {
          scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(rider, "skipDeathCount", 1);
        }

        rider.var_b582b10663b5b2a9 = 0;

        if(is_equal(rider.script_startingposition, 0) || is_equal(rider.script_startingposition, 1)) {
          rider.dropweapon = 0;
        }

        if((vehicle_ref == "veh9_blima" || vehicle_ref == "veh_jup_blima" || vehicle_ref == "veh_jup_blima_anim_infil") && (is_equal(rider.script_startingposition, 5) || is_equal(rider.script_startingposition, 6))) {
          rider.dropweapon = 0;
        }
      }

      if(!isDefined(veh_spawner.unloadloc)) {
        veh_spawner.unloadloc = function_c23b5f880258a806(veh_spawner);
      }
    } else {
      spawninvehicle = 1;

      if(istrue(veh_spawner.load_vehicle)) {
        spawninvehicle = 0;
      } else if(isDefined(veh_spawner.var_3f0312e6382c878f) && veh_spawner.var_3f0312e6382c878f == 0) {
        spawninvehicle = 0;
      }

      vehicle scripts\cp_mp\vehicles\vehicle::function_f92faaaf5c5077c6(riders, spawninvehicle);
    }

    level notify("loaded_ai_in_vehicle", vehicle);
  }

  if(isDefined(veh_spawner.auto_crash)) {
    vehicle.auto_crash = 1;
  }

  if(getdvarint(@ "hash_691520ae38c53622", 0) != 0) {
    vehicle.maxhealth = getdvarint(@ "hash_691520ae38c53622");
    vehicle.health = vehicle.maxhealth;
  }

  if(isDefined(veh_spawner.var_72772fa651ecbe2b)) {
    funcs = strtok(veh_spawner.var_72772fa651ecbe2b, "+");

    foreach(func in funcs) {
      if(isDefined(level.var_a8dc22c62ba69b88[func])) {
        vehicle thread[[level.var_a8dc22c62ba69b88[func]]]();
      }
    }
  }

  if(!vehicle scripts\common\vehicle::ishelicopter()) {
    if(isDefined(level.var_6e5ff6cae14c4081)) {
      level.var_6e5ff6cae14c4081[level.var_6e5ff6cae14c4081.size] = vehicle;
    }

    if(vehicle isboat() || vehicle scripts\cp_mp\vehicles\vehicle::isvehicleboat()) {
      vehicle.unloadondriverdeath = 0;
      vehicle.var_3816d927b2610b20 = &function_e48289454000f767;
      vehicle.var_af63688e8d4f80ee = 1;
    } else {
      vehicle.unloadondriverdeath = 1;

      if(vehicle_ref == "veh_jup_jltv_mg") {
        vehicle.var_3816d927b2610b20 = &function_9634375484e376f3;
      }
    }
  }

  return vehicle;
}

function function_c1c8efc410395e96(ref_data, veh_spawner, ai_spawners, vehicle_ref) {
  riders = [];
  alias = undefined;
  alias_data = undefined;
  seatindex = 0;
  var_b5424ebe989b94b4 = 0;
  var_ce466b5e28c4827d = 0;
  var_882160ef04cd8207 = 0;
  spawners = undefined;
  max_riders = ref_data.aiseats.size;

  if(isDefined(ai_spawners)) {
    spawners = ai_spawners;
  } else if(isDefined(veh_spawner.spawngroup)) {
    spawners = getStructArray(veh_spawner.spawngroup, "targetname");
  }

  assertex(isarray(spawners), "dungeon_vehicle_spawngroup - No valid AI Rider spawners found!");
  num_riders = spawners.size;

  if(isDefined(num_riders) && num_riders > 0) {
    switch (vehicle_ref) {
      case #"hash_23ace49635b088cf":
      case #"hash_293b5f5fefd56c2c":
      case #"hash_835a3b4bb4e34233":
      case #"hash_9d4e22a00fc630b5":
      case #"hash_b40eeff172c68887":
      case #"hash_bc31095b59d83674":
      case #"hash_ca9945ca2bd4d081":
        seatindex = 2;
        max_riders -= 2;
        break;
    }
  }

  if(num_riders > max_riders) {
    num_riders = max_riders;
  }

  if(isDefined(level.var_ed8b3892702336d7)) {
    level[[level.var_ed8b3892702336d7]](veh_spawner);
  }

  if(function_b15a802b4c2c6f75(vehicle_ref)) {
    for(index = 0; index < num_riders; index++) {
      spawner = spawners[index];

      if(isDefined(spawner.script_startingposition) && int(spawner.script_startingposition) == 5) {
        var_b5424ebe989b94b4 = 1;
      }
    }
  }

  for(index = 0; index < num_riders; index++) {
    spawner = spawners[index];
    spawner.script_demeanor = undefined;

    if(getdvarint(@ "hash_18e48e8099801eb", 0) == 1) {
      if(isDefined(spawner.script_stealthgroup) && !istrue(spawner.var_9e5f6ca242b92628)) {
        spawner.var_9e5f6ca242b92628 = 1;
      }
    }

    rider = scripts\cp\spawning::function_7736c252ad19c782(undefined, spawner, undefined, 1);

    if(!isDefined(rider)) {
      tries = 0;

      while(tries < 3) {
        rider = scripts\cp\spawning::function_7736c252ad19c782(undefined, spawner, undefined, 1);

        if(!isDefined(rider)) {
          wait 0.1;
          tries++;
          continue;
        }

        break;
      }
    }

    if(!isDefined(rider)) {
      println("<dev string:x8f>" + spawner.targetname + "<dev string:xa1>" + spawner.origin);
      continue;
    }

    level notify("vehicle_rider_spawned", rider, veh_spawner);

    if(isDefined(spawner.var_89ac88ba78378fd3)) {
      rider.var_89ac88ba78378fd3 = spawner.var_89ac88ba78378fd3;
    }

    var_65119e62f62616e1 = rider.team;

    if(function_b15a802b4c2c6f75(vehicle_ref) && !istrue(var_b5424ebe989b94b4) && num_riders <= 4) {
      rider.script_startingposition = 5;
      var_b5424ebe989b94b4 = 1;
    } else if(isDefined(spawner.script_startingposition)) {
      if(!isint(spawner.script_startingposition)) {
        spawner.script_startingposition = int(spawner.script_startingposition);
      }

      if(spawner.script_startingposition == 0) {
        var_ce466b5e28c4827d = 1;
      } else if(spawner.script_startingposition == 1) {
        var_882160ef04cd8207 = 1;
      }

      rider.script_startingposition = spawner.script_startingposition;
    } else {
      rider.script_startingposition = seatindex;
      rider.spawner.script_startingposition = seatindex;
      seatindex++;
    }

    if(isDefined(level.var_7a9f066f79bed633)) {
      rider thread[[level.var_7a9f066f79bed633]]();
    }

    if(!isint(rider.script_startingposition)) {
      rider.script_startingposition = int(rider.script_startingposition);
    }

    rider.vehicle_position = rider.script_startingposition;
    riders[riders.size] = rider;

    if(rider.script_startingposition == 0 && istrue(veh_spawner.var_eaa2050e5c2a8cae)) {
      if(isDefined(rider.nocorpse)) {
        rider.og_nocorpse = rider.nocorpse;
      }

      rider.nocorpse = 1;
    }
  }

  if(isDefined(ref_data) && istrue(ref_data.ai.supportsai)) {
    veh_spawner.initai = 1;
  }

  namespace_cbe993018617a21d::function_64d2d74ab85e00bb(riders);
  return riders;
}

function function_4fb2325851136a56(var_784030f0b32d0f1d, var_d516d906a6f10c31) {
  if(ent_flag("dungeon_initted")) {
    return;
  }

  namespace_9246f10206f50768::function_1da2c31423c2676a();
  scripts\cp\weapon::add_to_special_lockon_target_list(self);

  if(istrue(var_784030f0b32d0f1d)) {
    if(!self hascomponent("animator")) {
      self addcomponent("animator");
    }
  }

  if(!isDefined(var_d516d906a6f10c31)) {
    var_d516d906a6f10c31 = 0;
  }

  if(isDefined(self.force_speed)) {
    self.forced_speed = self.force_speed;
  }

  if(isDefined(self.forced_speed)) {
    self setconfigvalue("p2p", "manualSpeed", mph_to_ips(self.forced_speed));
  } else if(is_equal(self.var_5bbf95f73f01706e, "normal")) {
    self setconfigvalue("p2p", "automaticNormal", 1);
  } else {
    self setconfigvalue("p2p", "automaticFast", 1);
  }

  if(istrue(var_d516d906a6f10c31)) {
    self setconfigvalue("p2p", "goalPoint", self.origin);
  }

  if(isDefined(self.goal_threshold)) {
    self setconfigvalue("p2p", "goalThreshold", self.goal_threshold);
  }

  if(istrue(self.check_stuck)) {
    self setconfigvalue("p2p", "checkStuck", 1);
  } else {
    self setconfigvalue("p2p", "checkStuck", 0);
  }

  self.pausing = 0;
  ent_flag_set("dungeon_initted");
}

function function_3012bc853bee1857(var_784030f0b32d0f1d) {
  if(ent_flag("dungeon_initted")) {
    return;
  }

  namespace_9246f10206f50768::function_1da2c31423c2676a();

  if(!self hascomponent("path")) {
    self addcomponent("path");
  }

  if(istrue(var_784030f0b32d0f1d)) {
    if(!self hascomponent("animator")) {
      self addcomponent("animator");
    }
  }

  if(isDefined(self.force_speed)) {
    self.forced_speed = self.force_speed;
  }

  if(isDefined(self.forced_speed)) {
    self setconfigvalue("p2p", "manualSpeed", mph_to_ips(self.forced_speed));
  } else if(is_equal(self.var_5bbf95f73f01706e, "normal")) {
    self setconfigvalue("p2p", "automaticNormal", 1);
  } else if(is_equal(self.var_5bbf95f73f01706e, "fast")) {
    self setconfigvalue("p2p", "automaticFast", 1);
  }

  self.pausing = 0;
  ent_flag_set("dungeon_initted");
}

function private function_ec1bfb6dc29ce2f1() {}

function function_bab28ad00f02cf47(path_start, skip_init) {
  self endon("death");

  if(!istrue(skip_init)) {
    function_4fb2325851136a56();
  }

  dest = function_f0144da019d3204e(path_start.target);
  function_6e7d13e0969b82f8(dest);
}

function function_4971980ce1dda1fb(path_start, skip_init) {
  if(!isDefined(level.vehiclenavmeshlayer)) {
    scripts\cp_mp\vehicles\vehicle::function_466cdec791b7edfe();
  }

  self endon("death");

  if(!istrue(skip_init)) {
    function_4fb2325851136a56();
  }

  dest = function_f0144da019d3204e(path_start.target);
  function_6e7d13e0969b82f8(path_start, "p2p_pathfind_global");
}

function function_6770ea8fb26804bf(path_start, skip_init, var_b7d9b54851a59550) {
  if(!isDefined(level.vehiclenavmeshlayer)) {
    scripts\cp_mp\vehicles\vehicle::function_466cdec791b7edfe();
  }

  self endon("death");

  if(!istrue(skip_init)) {
    function_4fb2325851136a56();
  }

  if(istrue(var_b7d9b54851a59550)) {
    self.var_b7d9b54851a59550 = 1;
  }

  dest = function_f0144da019d3204e(path_start.target);
  function_6e7d13e0969b82f8(path_start, "p2p_pathfind_cp");
}

function function_ddaa9e960832374e(path_start, skip_init) {
  self notify("newpath");

  if(!istrue(skip_init)) {
    function_3012bc853bee1857();
  }

  spline_struct = function_daffaa0c86586219(path_start);

  if(isDefined(spline_struct.points) && spline_struct.points.size > 0) {
    self.var_ece6645577bd9452 = function_6e313dda90fb035f(spline_struct.points, spline_struct.times, spline_struct.is_looping, 1);
    self setconfigvalue("path", "catmullRomId", self.var_ece6645577bd9452);
  }
}

function function_580dffaaa0d4b3a9(var_d3c8fc8a655eabed, skip_init) {
  self notify("newpath");

  if(!istrue(skip_init)) {
    function_3012bc853bee1857();
  }

  var_937be080516a6ca3 = getvehiclenodeindex(var_d3c8fc8a655eabed, "targetname");
  start_node = getvehiclenode(var_d3c8fc8a655eabed, "targetname");

  if(isDefined(var_937be080516a6ca3)) {
    self setconfigvalue("path", "radiantId", var_937be080516a6ca3);
  }

  self vehicle_turnengineon();
  scripts\common\vehicle_paths::vehicle_paths_non_heli(start_node);
}

function function_b8b5f6a755675b1(var_d3c8fc8a655eabed) {
  if(!isDefined(self.target)) {
    self.target = var_d3c8fc8a655eabed;
  }

  self vehicle_turnengineon();
  self.var_e477b04ae71253d8 = &function_f29e9e88cd69b3bd;
  scripts\common\vehicle_paths::getonpath();
  level scripts\common\vehicle_paths::gopath(self);
}

function function_f6ea25cea46b0184(nextpoint, lastpoint, dist_sq, pathfind_type) {
  if(!isDefined(lastpoint)) {
    lastpoint = nextpoint;
  }

  var_a967646668185a6d = 0;

  if(!isDefined(nextpoint.target) && !istrue(nextpoint.var_13b782d931e3956b)) {
    var_a967646668185a6d = 1;
  }

  if(isDefined(nextpoint.script_goal_threshold)) {
    self setconfigvalue("p2p", "goalThreshold", nextpoint.script_goal_threshold);
  } else {
    self setconfigvalue("p2p", "goalThreshold", -1);
  }

  if(istrue(nextpoint.var_3efdd073323b953c)) {
    self setconfigvalue("p2p", "brakeAtGoal", 1);
  } else {
    self setconfigvalue("p2p", "brakeAtGoal", 0);
  }

  speed = undefined;
  var_c1de620e3562e32e = undefined;
  var_5cd3de55fd843f0e = undefined;

  if(isDefined(self.var_5bbf95f73f01706e)) {
    var_c1de620e3562e32e = self function_3dda404001a83ee("p2p", "automaticNormal");
    var_5cd3de55fd843f0e = self function_3dda404001a83ee("p2p", "automaticFast");

    if(self.var_5bbf95f73f01706e == "fast") {
      self setconfigvalue("p2p", "automaticFast", 1);
    } else {
      self setconfigvalue("p2p", "automaticNormal", 1);
    }

    var_c1de620e3562e32e = self function_3dda404001a83ee("p2p", "automaticNormal");
    var_5cd3de55fd843f0e = self function_3dda404001a83ee("p2p", "automaticFast");
  } else {
    speed = 20;

    if(isDefined(self.force_speed)) {
      self.forced_speed = self.force_speed;
    }

    if(isDefined(self.forced_speed)) {
      speed = self.forced_speed;
    } else if(isDefined(nextpoint.script_speed)) {
      speed = nextpoint.script_speed;
    } else {
      var_17129dc345d151cf = self function_3dda404001a83ee("p2p", "manualSpeed");

      if(var_17129dc345d151cf != -1) {
        speed = ips_to_mph(float(var_17129dc345d151cf));
      }
    }
  }

  if(isDefined(speed)) {
    speed = float(speed);
  }

  if(is_equal(pathfind_type, "p2p_pathfind_cp")) {
    if(isDefined(speed) && speed != -1) {
      namespace_4ed427f42d64d93c::function_26e9e22860c819ce(self.origin, nextpoint.origin, mph_to_ips(speed));
    } else {
      namespace_4ed427f42d64d93c::function_26e9e22860c819ce(self.origin, nextpoint.origin);
    }

    self waittill("path_finished");
    return;
  }

  if(is_equal(pathfind_type, "p2p_pathfind_global")) {
    blocked_count = 0;
    blocked_threshold = 5;

    while(true) {
      msg = namespace_9246f10206f50768::function_8f40a2c8678f8304(self.origin, nextpoint.origin, speed, undefined, var_a967646668185a6d);

      if(msg == "path_blocked") {
        blocked_count++;

        if(blocked_count < blocked_threshold) {
          waitframe();
          continue;
        }

        continue;
      }

      break;
    }

    return;
  }

  if(isDefined(speed) && speed != -1) {
    self setconfigvalue("p2p", "manualSpeed", mph_to_ips(speed));
  }

  if(istrue(var_a967646668185a6d)) {
    self setconfigvalue("p2p", "brakeAtGoal", 1);
    self setconfigvalue("p2p", "pause", 1);
  }

  self setconfigvalue("p2p", "goalPoint", nextpoint.origin);
  waittill_any_3("goal", "goal_reached", "near_goal");
}

function function_6e7d13e0969b82f8(node, pathfind_type) {
  assertex(isDefined(node) || isDefined(self.attachedpath), "vehicle_path() called without a path");
  self notify("newpath");

  if(isDefined(node)) {
    self.attachedpath = node;
  }

  pathstart = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(pathstart)) {
    return;
  }

  self endon("newpath");
  self endon("death");
  pathpoint = pathstart;
  lastpoint = undefined;
  nextpoint = pathstart;
  get_func = scripts\common\vehicle_paths::get_path_getfunc(pathstart);

  if(isDefined(level.var_c0fcdf87286f983)) {
    get_func = level.var_c0fcdf87286f983;
  }

  if(isboat() || scripts\cp_mp\vehicles\vehicle::isvehicleboat()) {
    self function_481c2a63f2ba3332(0);
  }

  self vehicle_turnengineon();
  dist_sq = 40000;

  if(self hascomponent("p2p")) {
    dist = self function_3dda404001a83ee("p2p", "goalThreshold");
    dist_sq = dist * dist;
  }

  while(isDefined(nextpoint)) {
    if(isDefined(level.var_817773201f5f2e3d)) {
      [[level.var_817773201f5f2e3d]](nextpoint, lastpoint, get_func);
    } else {
      function_f6ea25cea46b0184(nextpoint, lastpoint, dist_sq, pathfind_type);
    }

    if(!isDefined(self)) {
      return;
    }

    scripts\common\vehicle_paths::trigger_process_node(nextpoint);
    self.currentnode = nextpoint;

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(nextpoint.script_team)) {
      self.script_team = nextpoint.script_team;
    }

    if(isDefined(nextpoint.script_transmission)) {
      self.veh_transmission = nextpoint.script_transmission;

      if(self.veh_transmission == "forward") {
        vehicle_setwheeldirection(1);
      } else {
        vehicle_setwheeldirection(0);
      }
    }

    if(isDefined(nextpoint.script_brake)) {
      self.veh_brake = nextpoint.script_brake;

      if(self vehicle_isphysveh()) {
        self vehphys_parkingbrake(1);
      }
    }

    if(isDefined(nextpoint.script_pathtype)) {
      self.veh_pathtype = nextpoint.script_pathtype;
    }

    if(isDefined(nextpoint.script_ent_flag_wait) && !ent_flag(nextpoint.script_ent_flag_wait)) {
      if(isDefined(nextpoint.script_decel)) {
        decel = nextpoint.script_decel;
      } else if(isDefined(nextpoint.target)) {
        stoppoint = [[get_func]](nextpoint.target);
        distance = ips_to_mph(distance(nextpoint.origin, stoppoint.origin));
        speed = self vehicle_getspeed();
        decel = squared(speed) / 2 * distance;
      } else {
        decel = 20;
      }

      self vehicle_setspeed(0, decel, decel);
      childthread scripts\common\vehicle_paths::vehicle_notifyonstop();
      ent_flag_wait(nextpoint.script_ent_flag_wait);

      if(!isDefined(self)) {
        return;
      }

      accel = 60;

      if(isDefined(nextpoint.script_accel)) {
        accel = nextpoint.script_accel;
      }

      self notify("resumed_path");
      self resumespeed(accel);
    }

    if(isDefined(nextpoint.script_delay)) {
      decel = 20;

      if(isDefined(nextpoint.script_decel)) {
        decel = nextpoint.script_decel;
      }

      self vehicle_setspeed(0, decel);
      childthread scripts\common\vehicle_paths::vehicle_notifyonstop();

      if(isDefined(nextpoint.target)) {
        childthread scripts\common\vehicle_paths::overshoot_next_node([[get_func]](nextpoint.target));
      }

      nextpoint script_delay();
      self notify("delay_passed");
      accel = 60;

      if(isDefined(nextpoint.script_accel)) {
        accel = nextpoint.script_accel;
      }

      self notify("resumed_path");
      self resumespeed(accel);
    }

    if(isDefined(nextpoint.script_flag_wait) || isDefined(nextpoint.script_flag_waitopen)) {
      was_stopped = 0;
      var_5b62e4fc3021a9a7 = isDefined(nextpoint.script_flag_wait) && !flag(nextpoint.script_flag_wait);
      var_d54eec4cdd1d8fab = isDefined(nextpoint.script_flag_waitopen) && flag(nextpoint.script_flag_waitopen);
      stopped_msg = undefined;

      if(var_5b62e4fc3021a9a7 || var_d54eec4cdd1d8fab || isDefined(nextpoint.script_delay_post)) {
        was_stopped = 1;
        accel = 5;
        decel = 20;

        if(isDefined(nextpoint.script_accel)) {
          accel = nextpoint.script_accel;
        }

        if(isDefined(nextpoint.script_decel)) {
          decel = nextpoint.script_decel;
        }

        if(var_5b62e4fc3021a9a7) {
          stopped_msg = "script_flag_wait_" + nextpoint.script_flag_wait;
        } else if(var_d54eec4cdd1d8fab) {
          stopped_msg = "script_flag_waitopen_" + nextpoint.script_flag_waitopen;
        } else if(isDefined(nextpoint.script_flag_wait)) {
          stopped_msg = "script_delay_post_" + nextpoint.script_flag_wait;
        } else {
          stopped_msg = "script_delay_post_" + nextpoint.script_flag_waitopen;
        }

        scripts\common\vehicle_paths::_vehicle_stop_named(stopped_msg, accel, decel);
        childthread scripts\common\vehicle_paths::vehicle_notifyonstop();

        if(isDefined(nextpoint.target)) {
          childthread scripts\common\vehicle_paths::overshoot_next_node([[get_func]](nextpoint.target));
        }
      }

      if(var_5b62e4fc3021a9a7) {
        flag_wait(nextpoint.script_flag_wait);
      }

      if(var_d54eec4cdd1d8fab) {
        flag_waitopen(nextpoint.script_flag_waitopen);
      }

      if(!isDefined(self)) {
        return;
      }

      if(isDefined(nextpoint.script_delay_post)) {
        wait nextpoint.script_delay_post;

        if(!isDefined(self)) {
          return;
        }
      }

      accel = 10;

      if(isDefined(nextpoint.script_accel)) {
        accel = nextpoint.script_accel;
      }

      if(was_stopped) {
        self notify("resumed_path");
        scripts\common\vehicle_paths::_vehicle_resume_named(stopped_msg);
      }

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    if(isDefined(nextpoint.script_vehicle_lights_off)) {
      thread function_eb3dc3bbaf5fafdc(nextpoint.script_vehicle_lights_off);
    }

    if(isDefined(nextpoint.script_vehicle_lights_on)) {
      thread function_1d533751456d5e6a(nextpoint.script_vehicle_lights_on);
    }

    if(scripts\common\vehicle_paths::vehicle_should_unload(&scripts\common\vehicle_paths::node_wait, nextpoint) && self hascomponent("p2p")) {
      function_ecbcec373d227be(undefined, nextpoint.script_unload);
    }

    if(isDefined(level.var_6a598e1a00ae007f)) {
      self[[level.var_6a598e1a00ae007f]](nextpoint);
    }

    lastpoint = nextpoint;

    if(!isDefined(nextpoint.target)) {
      break;
    }

    nextpoint = [[get_func]](nextpoint.target);

    if(!isDefined(nextpoint)) {
      nextpoint = lastpoint;
      assertmsg("can't find nextpoint for node at origin (node targets nothing or different type?): " + lastpoint.origin);
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    scripts\common\vehicle_code::vehicle_deathcleanup();
    scripts\common\vehicle_paths::delete_riders();
    self notify("delete");
    self delete();
  }
}

function private function_cc48c692af66b44c() {}

function pause_path() {
  if(self hascomponent("p2p")) {
    self setconfigvalue("p2p", "gasToStopMovement", 1);
    self setconfigvalue("p2p", "brakeAtGoal", 1);
    self setconfigvalue("p2p", "pause", 1);

    if(self hascomponent("path")) {
      self setconfigvalue("path", "pause", 1);
    }
  } else {
    scripts\common\vehicle::vehicle_stop_named("dungeon_veh_path_pause", 15, 15);
  }

  self vehphys_parkingbrake(1);
}

function resume_path() {
  self vehphys_parkingbrake(0);

  if(self hascomponent("p2p")) {
    self setconfigvalue("p2p", "brakeAtGoal", 0);
    self setconfigvalue("p2p", "resume", 1);

    if(self hascomponent("path")) {
      self setconfigvalue("path", "resume", 1);
    }

    return;
  }

  scripts\common\vehicle::vehicle_resume_named("dungeon_veh_path_pause");
}

function function_9634375484e376f3() {
  self endon("death");

  if(istrue(self.unloading)) {
    return;
  }

  self.unloading = 1;

  if(istrue(self.unloadondriverdeath)) {
    self vehphys_parkingbrake(1);
    self notify("path_updated");
    self notify("newpath");

    if(self hascomponent("p2p")) {
      function_ecbcec373d227be();
    }

    wait 1;
    self vehphys_parkingbrake(0);

    if(self hascomponent("p2p")) {
      namespace_cbe993018617a21d::function_1686ecaabfdc542d();
    }

    self vehicle_turnengineoff();
  }
}

function function_ce99bb95835ce72e(gunner) {
  self endon("death");
  gunner endon("jumpedout");
  gunner waittill("death");
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");
}

function function_e48289454000f767() {
  self endon("death");

  if(isDefined(self) && isalive(self)) {
    thread function_da00c0e13a055259();
  }

  if(istrue(self.unloadondriverdeath)) {
    thread namespace_cbe993018617a21d::unloadvehicle();
  }

  self notify("path_updated");
  self notify("newpath");
  self setconfigvalue("p2p", "brakeAtGoal", 1);
  self stoppath();
  self vehicle_cleardrivingstate();
  self setconfigvalue("p2p", "goalPoint", self.origin + anglesToForward(self.angles) * 500);
  self vehicle_turnengineoff();
  self setconfigvalue("p2p", "pause", 1);
  thread function_4a037e62a51e9372();
}

function function_4a037e62a51e9372() {
  self endon("unanchored");
  self endon("death");

  while(self vehicle_getspeed() > 1) {
    waitframe();
  }

  self setconfigvalue("p2p", "goalPoint", self.origin);
  self function_481c2a63f2ba3332(-1);

  if(self hascomponent("p2p")) {
    self removecomponent("p2p");
  }

  if(self hascomponent("path")) {
    self removecomponent("path");
  }
}

function function_da00c0e13a055259() {
  self notify("dungeon_owner_check");
  self endon("dungeon_owner_check");
  self endon("death");

  while(true) {
    riders = array_removedead(self.riders);

    if(riders.size == 0) {
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");
      break;
    }

    wait 0.1;
  }
}

function function_ecbcec373d227be(var_92454c62aaac39ff, unload_group, var_fb98a329bd6d6dbe) {
  if(!isDefined(self.var_5bbf95f73f01706e)) {
    self setconfigvalue("p2p", "manualSpeed", 0);
  }

  immediate_stop = istrue(var_92454c62aaac39ff) || istrue(self.var_f7532aedaddbfafd);

  if(immediate_stop) {
    self setconfigvalue("p2p", "goalPoint", self.origin);
    self vehicle_setspeedimmediate(0, 1, 1);
  }

  self setconfigvalue("p2p", "brakeAtGoal", 1);
  goalpoint = self.currentnode;

  if(isDefined(goalpoint) && !isDefined(goalpoint.target) && !immediate_stop) {
    self function_1c952754074bd3a1(self function_3dda404001a83ee("p2p", "goalPoint"), 0, 5, 0.7, 0.25, 0, 0.35);
  }

  pause_path();
  self stoppath();
  self vehicle_cleardrivingstate();
  waitframe();
  common_unload(unload_group, var_fb98a329bd6d6dbe);
}

function common_unload(unload_group, var_fb98a329bd6d6dbe) {
  self endon("death");

  if(!isDefined(var_fb98a329bd6d6dbe)) {
    var_fb98a329bd6d6dbe = 1;
  }

  if(!isDefined(unload_group)) {
    unload_group = "default";
  } else if(!isstring(unload_group)) {
    unload_group = "default";
  }

  var_b3941e6a151cf4d2 = scripts\common\vehicle_code::_vehicle_unload(unload_group);
  namespace_cbe993018617a21d::function_5d3dd28d4c5af8b2(var_b3941e6a151cf4d2);

  if(scripts\common\vehicle_aianim::riders_unloadable(unload_group)) {
    ent_flag_wait("unloaded");
  }

  if(istrue(var_fb98a329bd6d6dbe)) {
    thread function_da00c0e13a055259();
  }

  if(isDefined(level.vehicle.var_3dfa81ab7ac6a1b3)) {
    if([[level.vehicle.var_3dfa81ab7ac6a1b3]](self, var_b3941e6a151cf4d2)) {
      return 1;
    }
  }

  if(isDefined(level.vehicle.var_9442d439c225c3fe)) {
    if([[level.vehicle.var_9442d439c225c3fe]](self)) {
      return 1;
    }
  }
}

function function_f29e9e88cd69b3bd() {
  namespace_cbe993018617a21d::function_5d3dd28d4c5af8b2(self.riders);
  return undefined;
}

function function_f0144da019d3204e(tname) {
  if(!isDefined(tname)) {
    return undefined;
  }

  str = getStruct(tname, "targetname");

  if(isDefined(str)) {
    return str;
  }

  veh_node = getvehiclenode(tname, "targetname");

  if(isDefined(veh_node)) {
    return veh_node;
  }

  return undefined;
}

function function_daffaa0c86586219(path_start) {
  [points, is_looping] = function_3b0860e6185e09a1(path_start);
  path_speed = 10;

  if(isDefined(path_start.script_speed)) {
    path_speed = path_start.script_speed;
  }

  times = function_77fa26f1d5ce6194(points, mph_to_ips(path_speed));
  spline_struct = spawnStruct();
  spline_struct.points = points;
  spline_struct.times = times;
  spline_struct.is_looping = is_looping;
  spline_struct.spline_speed = path_speed;
  return spline_struct;
}

function function_1d533751456d5e6a(group, delay) {
  model = default_to(self.classname_mp, self.classname);
  delay = default_to(delay, 0);
  group = default_to(group, "all");

  if(!isDefined(level.vehicle.templates.vehicle_lights_group) || !isDefined(level.vehicle.templates.vehicle_lights_group[model]) || !isDefined(level.vehicle.templates.vehicle_lights_group[model][group])) {
    if(isDefined(group)) {
      delaythread(delay, &function_3677f2be30fdd581, group, "on");
    }

    return;
  }

  thread scripts\common\vehicle::vehicle_lights_on(group);
}

function function_eb3dc3bbaf5fafdc(group, delay) {
  model = default_to(self.classname_mp, self.classname);

  if(!isDefined(delay)) {
    delay = 0;
  }

  if(!isDefined(group)) {
    group = "all";
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group) || !isDefined(level.vehicle.templates.vehicle_lights_group[model]) || !isDefined(level.vehicle.templates.vehicle_lights_group[model][group])) {
    if(isDefined(group)) {
      delaythread(delay, &function_3677f2be30fdd581, group, "off");
    }

    return;
  }

  thread scripts\common\vehicle::vehicle_lights_off(group);
}

function function_3b0860e6185e09a1(startstruct) {
  structs = [];
  structs[structs.size] = startstruct;
  structs[structs.size] = getStruct(startstruct.target, "targetname");
  is_looping = 0;
  num = 1;

  while(true) {
    structs[structs.size] = getStruct(structs[num].target, "targetname");
    num++;

    if(!isDefined(structs[num].target)) {
      break;
    }

    next_struct = getStruct(structs[num].target, "targetname");

    if(next_struct == startstruct || array_contains(structs, next_struct)) {
      is_looping = 1;
      break;
    }
  }

  points = [];

  foreach(struct in structs) {
    points[points.size] = struct.origin;
  }

  return [points, is_looping];
}

function function_4b6780152e7fc544(var_79d997bd46d03a0f, force_structs) {
  self endon("death");
  apathnodes = [];

  if(isDefined(var_79d997bd46d03a0f)) {
    estartnode = var_79d997bd46d03a0f;
  } else {
    estartnode = self.attachedpath;
  }

  if(!isDefined(force_structs)) {
    force_structs = 0;
  }

  if(!isDefined(estartnode)) {
    return apathnodes;
  }

  nextnode = estartnode;
  nextnode.counted = 0;

  while(isDefined(nextnode)) {
    if(isDefined(nextnode.counted) && nextnode.counted == 1) {
      break;
    }

    apathnodes = array_add(apathnodes, nextnode);
    nextnode.counted = 1;

    if(!isDefined(nextnode.target)) {
      break;
    }

    if(istrue(force_structs)) {
      nextnode = getent_or_struct(nextnode.target, "targetname");
      continue;
    }

    if(!ishelicopter()) {
      nextnode = getvehiclenode(nextnode.target, "targetname");
      continue;
    }

    nextnode = getent_or_struct(nextnode.target, "targetname");
  }

  return apathnodes;
}

function function_77fa26f1d5ce6194(pathing_array, var_6f12cbb2d9251959) {
  var_865de0e45fd72eda = [];
  durations = [];
  amount = pathing_array.size;
  currentpoint = undefined;
  last_point = self.origin;
  vel = 15;
  using_objects = !isvector(pathing_array[0]);

  for(i = 0; i < pathing_array.size; i++) {
    if(isDefined(pathing_array[i + 1])) {
      if(using_objects) {
        currentpoint = pathing_array[i + 1].origin;
      } else {
        currentpoint = pathing_array[i + 1];
      }
    }

    if(i == 0) {
      var_865de0e45fd72eda[var_865de0e45fd72eda.size] = self.origin;
    } else if(using_objects) {
      var_865de0e45fd72eda[var_865de0e45fd72eda.size] = pathing_array[i].origin;
    } else {
      var_865de0e45fd72eda[var_865de0e45fd72eda.size] = pathing_array[i];
    }

    speed = ter_op(isDefined(var_6f12cbb2d9251959), var_6f12cbb2d9251959, 300);
    var_d530f6290fec0a8c = namespace_9246f10206f50768::get_duration_between_points(last_point, currentpoint, speed);
    durations[durations.size] = var_d530f6290fec0a8c;
    last_point = currentpoint;
  }

  return durations;
}

function function_f60b16bd3ca5fa28(target) {
  if(isai(target) && isalive(target)) {
    return true;
  }

  if(target scripts\common\vehicle::isvehiclealive()) {
    return true;
  }

  return false;
}

function function_d6c65a66f59242a4(target) {
  if(isagent(target)) {
    return false;
  }

  if(isvector(target)) {
    return true;
  }

  if(target function_d18d54d06a474398()) {
    return true;
  }

  return false;
}

function function_61e2a08d58acf36c(target) {
  if(!target isvehicle()) {
    return false;
  }

  return isDefined(target.owner) && target.owner == level.player;
}

function function_d18d54d06a474398() {
  if(isai(self)) {
    return false;
  }

  return isstruct(self) || isent(self) && self.classname == "script_origin";
}

function get_nearby_enemy(org, dist_check, trace_ent) {
  self endon("death");

  if(!isDefined(trace_ent) || isDefined(trace_ent) && !isDefined(trace_ent.origin)) {
    trace_ent = self;
  }

  contents = ["physicscontents_item", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_explosionclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_explosionclip"];
  guys = getentitiesinradius(org, dist_check, "axis", trace_ent, physics_createcontents(contents));

  if(!isDefined(guys)) {
    return undefined;
  }

  guys = sortbydistance(guys, level.player.origin);
  self.potentialtargets = guys;

  foreach(guy in guys) {
    if(guy.classname == "misc_turret") {
      if(scripts\engine\trace::ray_trace_passed(trace_ent.origin, guy.origin + (0, 0, 100), guys)) {
        return guy;
      }
    }
  }

  mid_index = guys.size > 1 ? int(round_float(guys.size / 2, 0, 1)) : 0;

  for(i = mid_index; i < guys.size; i++) {
    if(!isalive(guys[i])) {
      continue;
    }

    if(scripts\engine\trace::ray_trace_passed(trace_ent.origin, guys[i].origin + (0, 0, 100), guys)) {
      return guys[i];
    }
  }

  for(i = mid_index; i >= 0; i--) {
    if(!isalive(guys[i])) {
      continue;
    }

    if(scripts\engine\trace::ray_trace_passed(trace_ent.origin, guys[i].origin + (0, 0, 100), guys)) {
      return guys[i];
    }
  }

  return undefined;
}

function function_dfcae8e542563262(data) {
  data.damage = 0;
}

function private function_a0de426219fd2b6a() {}

function function_a3a8a805eac22adc() {
  self endon("death");
  should_stop = 0;
  self.stopped_for_allies = 0;
  self.stops = [];

  while(true) {
    waitframe();

    if(self.stopped_for_allies && !should_stop) {
      function_f295e4a4d25f4de7("allies");
      self.stopped_for_allies = 0;
      self notify("resume_stop_for_allies");
    }

    should_stop = 0;
    nearby_allies = get_array_of_closest(self.origin, getaiarray("axis"), undefined, undefined, 300);

    if(nearby_allies.size == 0) {
      continue;
    }

    foreach(guy in nearby_allies) {
      if(guy function_492986516c659372(300, self)) {
        should_stop = 1;
        guy notify("move_for_technical");
      }
    }

    if(!should_stop) {
      continue;
    }

    if(!self.stopped_for_allies) {
      self.stopped_for_allies = 1;
      function_da78da82badf4edc("allies", 15, 15);
    }

    wait 0.5;
  }
}

function function_f295e4a4d25f4de7(name) {
  assert(isDefined(self.stops[name]), "Tried to resume technical before stopping");
  iprintln("Vehicle resuming after stopping for " + name);
  self.stops[name] = undefined;
  self.stops = array_remove_key(self.stops, name);
  resume_path();

  if(!self.stops.size) {
    self notify("moving");
  }
}

function function_da78da82badf4edc(name, accel, decel) {
  if(isDefined(self.stops[name])) {
    return;
  }

  iprintln("Vehicle stopping for " + name);
  self.stops[name] = 1;
  pause_path();

  if(self.stops.size == 1) {
    self notify("stopping");
  }
}

function function_492986516c659372(pathdist, truck) {
  current_pos = truck.origin;
  current_node = truck.currentnode;
  total_dist = 0;

  while(total_dist < pathdist) {
    next_node = function_f0144da019d3204e(current_node.target);
    next_pos = next_node.ground_pos;

    if(math::get_dot(current_pos, vectortoangles(next_pos - current_pos), self.origin) > 0 && math::get_dot(next_pos, vectortoangles(current_pos - next_pos), self.origin) > 0) {
      var_2000b85c541ff9a7 = vectorfromlinetopoint(current_pos, next_pos, self.origin);

      if(length2dsquared(var_2000b85c541ff9a7) <= squared(48)) {
        return (distancesquared(self.origin - var_2000b85c541ff9a7, current_pos) <= squared(pathdist - total_dist));
      }
    }

    total_dist += distance(current_pos, next_pos);
    current_pos = next_pos;
    current_node = next_node;
  }

  return false;
}

function function_504a24496786c47f(node_array) {
  nodes = undefined;

  if(isDefined(node_array)) {
    nodes = node_array;
  } else {
    nodes = getallvehiclenodes();
  }

  var_c9787abb0668d729 = 1;
  num_traces = 0;

  foreach(node in nodes) {
    if(isDefined(node.ground_pos)) {
      continue;
    }

    node.ground_pos = utility::groundpos(node.origin);
    num_traces++;

    if(num_traces >= var_c9787abb0668d729) {
      waitframe();
      num_traces = 0;
    }
  }

  flag_set("vehicle_node_ground_pos_stored");
}

function function_658c64a0e1b5c7fd() {
  self endon("death");
  self.badplaces = [];

  while(true) {
    while(self vehicle_getspeed() > 1 || self.stopped_for_allies) {
      function_bf2f3a749c7c8390(450);
      waittill_notify_or_timeout("new_node", 1);

      if(self.stopped_for_allies) {
        self waittill("resume_stop_for_allies");
      }
    }

    function_8003e39d1c069276();

    while(self vehicle_getspeed() <= 1) {
      waitframe();
    }
  }
}

function function_bf2f3a749c7c8390(pathdist) {
  if(self.badplaces.size) {
    function_8003e39d1c069276();
  }

  current_pos = self.origin - anglesToForward(self.angles) * 112;
  current_node = self.currentnode;
  total_dist = 0;

  while(total_dist < pathdist) {
    next_node = function_f0144da019d3204e(current_node.target);

    while(!isDefined(next_node.ground_pos)) {
      waitframe();
    }

    next_pos = next_node.ground_pos;
    dist = distance(current_pos, next_pos);
    angles = vectortoangles(next_pos - current_pos);

    if(dist > pathdist - total_dist) {
      dist = pathdist - total_dist;
      next_pos = current_pos + anglesToForward(angles) * dist;
    }

    mid_pos = (current_pos + next_pos) / 2;
    id = createnavbadplacebybounds(mid_pos, (dist / 2 + 20, 68, 60), angles);
    self.badplaces[self.badplaces.size] = id;
    total_dist += dist;
    current_pos = next_pos;
    current_node = next_node;
  }
}

function function_8003e39d1c069276() {
  if(!self.badplaces.size) {
    return;
  }

  foreach(id in self.badplaces) {
    destroynavobstacle(id);
  }

  self.badplaces = [];
}

function private function_f946c5f672089760() {}

function function_b9890a1062fcebf3(vehicle, var_e3d9c2a0b05e4ce0, lookaheadtime, var_3233fba8a854387e) {
  if(isDefined(var_3233fba8a854387e)) {
    vehicle endon(var_3233fba8a854387e);
  }

  var_a55d80aa32829d78 = undefined;

  while(true) {
    enemies = getaiarray("axis");

    if(enemies.size) {
      var_a55d80aa32829d78 = enemies[0] physics_getcharactercollisioncapsule();
      break;
    }

    waitframe();
  }

  var_a7796ca2eb0bab7a = vehicle getboundshalfsize();
  var_5d4f8669bb887e6 = 4;
  var_352c5930ea8d4ee9 = var_a7796ca2eb0bab7a[1] + var_a55d80aa32829d78["radius"] * var_5d4f8669bb887e6;
  var_be24014547f24daf = var_a7796ca2eb0bab7a[0] + var_a55d80aa32829d78["radius"] * var_5d4f8669bb887e6;
  var_5886126ea90b44e0 = var_a7796ca2eb0bab7a[2] + var_a55d80aa32829d78["half_height"] * var_5d4f8669bb887e6;

  while(true) {
    var_6b051c16c0678276 = vehicle physics_getentitycenterofmass()["unscaled"];
    vehiclespeedips = vehicle vehicle_getspeed() * 17.6;
    var_8ed7efe8cbdd0211 = var_be24014547f24daf + vehiclespeedips * lookaheadtime;
    var_4d81310885ca021e = anglestoaxis(vehicle.angles);
    enemies = getaiarray("axis");
    var_9adf5951085bc39a = 0;
    var_c64b63d06232b260 = 2147483647;

    foreach(enemy in enemies) {
      if(ai_isridingvehicle(enemy)) {
        continue;
      }

      var_9e0d2ffd4b5b3b92 = enemy.origin - var_6b051c16c0678276;
      forwarddistance = vectordot(var_9e0d2ffd4b5b3b92, var_4d81310885ca021e["forward"]);

      if(forwarddistance < 0 || forwarddistance > var_8ed7efe8cbdd0211) {
        continue;
      }

      var_aecc8dacc19cf9b = abs(vectordot(var_9e0d2ffd4b5b3b92, var_4d81310885ca021e["right"]));

      if(var_aecc8dacc19cf9b < 0 || var_aecc8dacc19cf9b > var_352c5930ea8d4ee9) {
        continue;
      }

      verticaldistance = abs(vectordot(var_9e0d2ffd4b5b3b92, var_4d81310885ca021e["up"]));

      if(verticaldistance < 0 || verticaldistance > var_5886126ea90b44e0) {
        continue;
      }

      var_9adf5951085bc39a = 1;
      var_796cf671944133d7 = vectordot(enemy.velocity, var_4d81310885ca021e["forward"]);

      if(var_796cf671944133d7 < var_c64b63d06232b260) {
        var_c64b63d06232b260 = var_796cf671944133d7;
      }
    }

    if(var_9adf5951085bc39a) {
      vehicle setconfigvalue("p2p", "manualSpeed", max(var_c64b63d06232b260, 0.1));
    } else {
      vehicle setconfigvalue("p2p", "manualSpeed", var_e3d9c2a0b05e4ce0 * 17.6);
    }

    waitframe();
  }
}

function ai_isridingvehicle(ai, vehicle) {
  if(isDefined(vehicle)) {
    return is_equal(ai.ridingvehicle, vehicle);
  }

  return isDefined(ai.ridingvehicle);
}

function private function_b4d5f5ce776fb51c() {}

function vehicle_main_turret_think() {
  self endon("death");
  self endon("stop_tank_think");
  level endon("game_ended");
  scanside = 0;
  burst_min = 1;
  burst_max = 1;
  pause_min = 0.5;
  pause_max = 0.6;
  weaponinfo = "iw9_tur_apc_russian_mp";

  if(self.vehiclename == "veh9_cougar") {
    burst_min = 1;
    burst_max = 1;
    pause_min = 3;
    pause_max = 4;
    weaponinfo = "iw9_tur_cougar_mp";
  }

  firetime = weaponfiretime(weaponinfo);

  while(true) {
    oldenemy = self.currentenemy;
    function_4eefea108ddadf6f();

    if(isDefined(self.currentenemy)) {
      self setturrettargetEnt(self.currentenemy, self.currentenemy gettagorigin("j_mainroot") - self.currentenemy.origin);

      while(function_935490ace0011c00(self.currentenemy) && !scripts\cp_mp\utility\turret_utility::function_bb61346fda4278e5(self, self.currentenemy, "j_mainroot")) {
        waitframe();
      }

      if(function_935490ace0011c00(self.currentenemy)) {
        numshots = randomintrange(burst_min, burst_max + 1);

        while(function_935490ace0011c00(self.currentenemy) && numshots > 0) {
          self fireweapon();
          numshots--;
          wait firetime;
        }

        wait randomfloatrange(pause_min, pause_max);
      }

      continue;
    }

    self clearturrettarget();
    waitframe();
  }
}

function function_935490ace0011c00(target) {
  if(!isDefined(target)) {
    return 0;
  }

  dist = distancesquared(target.origin, self.origin);

  if(!isalive(target) || target.sessionstate != "playing") {
    return 0;
  }

  if(istrue(target.notarget)) {
    return 0;
  }

  if(dist > 16777216) {
    return 0;
  }

  if(!isDefined(target.pers["team"])) {
    return 0;
  }

  if(level.teambased && target.pers["team"] == self.team) {
    return 0;
  }

  if(target.pers["team"] == "spectator") {
    return 0;
  }

  if(isDefined(target.spawntime) && (gettime() - target.spawntime) / 1000 <= 2) {
    return 0;
  }

  if(issharedfuncdefined("perk", "hasPerk")) {
    if(target[[getsharedfunc("perk", "hasPerk")]]("specialty_blindeye")) {
      return 0;
    }
  }

  return self vehicle_canturrettargetpoint(target getEye(), 1, self);
}

function function_4eefea108ddadf6f() {
  currentenemy = self.currentenemy;
  targettime = self.enemytargettime;

  if(function_935490ace0011c00(currentenemy) && isDefined(targettime) && gettime() - targettime < 3000) {
    return;
  }

  players = level.players;
  closesttarget = undefined;
  closestdistsq = undefined;

  foreach(target in players) {
    if(!function_935490ace0011c00(target)) {
      continue;
    }

    distsq = distancesquared(target.origin, self.origin);

    if(!isDefined(closesttarget) || distsq < closestdistsq) {
      closesttarget = target;
      closestdistsq = distsq;
    }
  }

  self.currentenemy = closesttarget;
  self.enemytargettime = gettime();
}

function function_cc657d65c0799981() {
  self notify("stop_tank_think");
  self clearturrettarget();
}

function private function_dd2f906208c5407e() {}

function function_bd91bf5511021131() {
  self endon("death");
  self.mainturret endon("stop_mainturret_fire");
  self.mainturret endon("death");
  scripts\common\vehicle_code::_mainturreton();

  if(!self.mainturret ent_flag_exist("flag_main_turret_on_target")) {
    self.mainturret ent_flag_init("flag_main_turret_on_target");
  }

  self.mainturret setmode("auto_nonai");
  startedfiring = 0;

  if(!isDefined(self.mainturret.firetime)) {
    info = self.mainturret getturretweaponinfo();
    firetime = info.firetime;
  } else {
    firetime = self.mainturret.firetime;
  }

  while(true) {
    manual_target = self.mainturret gettargetentity(0);
    var_cdfa995862e5259d = self.mainturret getturrettarget(0);
    turrettarget = undefined;

    if(isDefined(manual_target)) {
      turrettarget = manual_target;
    } else if(isDefined(var_cdfa995862e5259d)) {
      turrettarget = var_cdfa995862e5259d;
    }

    var_264336879edd634 = 10;

    if(isDefined(self.mainturret.var_264336879edd634)) {
      var_264336879edd634 = self.mainturret.var_264336879edd634;
    }

    if(isDefined(turrettarget) && function_192247dfbe3311e(var_264336879edd634, turrettarget)) {
      function_9632c367b3b3faea(firetime);
    }

    waitframe();
  }
}

function function_9632c367b3b3faea(fire_time) {
  self endon("death");
  self.mainturret endon("stop_mainturret_fire");
  self.mainturret endon("stop_vehicleturret_think");
  self.mainturret endon("death");

  if(!isDefined(fire_time)) {
    fire_time = 5;
  }

  self.mainturret shootturret();
  wait fire_time;
}

function function_192247dfbe3311e(cos_angle, target) {
  if(!isDefined(cos_angle)) {
    cos_angle = 10;
  }

  tag_org = self.mainturret gettagorigin("tag_flash");
  tag_ang = self.mainturret gettagangles("tag_flash");
  target_offset = (0, 0, 0);

  if(isDefined(target) && isPlayer(target)) {
    target_offset = (0, 0, 60);
  }

  if(isvector(target)) {
    target_pos = target;
  } else {
    target_pos = target.origin + target_offset;
  }

  if(math::within_fov_2d(tag_org, tag_ang, target_pos, cos(cos_angle))) {
    return 1;
  }

  return 0;
}

function function_9896a313055eb03f() {
  self.mainturret notify("stop_mainturret_fire");
  self.mainturret cleartargetentity();
  scripts\common\vehicle_code::_mainturretoff();
}

function private function_7734ed4df651f612() {}

function function_5a44f27c93a4bbff() {
  thread function_f3a7246102872fb1();
  thread function_36042e85a77d2242();
}

function function_f3a7246102872fb1() {
  self endon("stop_gunner_think");
  self endon("death");
  self endon("disable_turrets");
  level endon("game_over");
  level endon("flag_dungeon_outro_start");
  waitframe();

  while(!isDefined(self.riders)) {
    wait 0.5;
  }

  self.gunner = function_cde7b4002c7a79eb();

  while(!isDefined(self.gunner)) {
    self.gunner = function_cde7b4002c7a79eb();
    wait 0.1;
  }

  self.gunner.allowpain = 0;
  self.gunner.equip_armor = 1;
  self.gunner.armor_health = 600;
  self.gunner.isgunner = 1;

  while(!isDefined(self.mgturret)) {
    waitframe();
  }

  turret = self.mgturret[0];
  turret makeunusable();

  level thread function_173155a78c3609b6(self, turret);

  self.gunner.vehicle = self;
  self.gunner waittill("death");

  if(isDefined(turret)) {
    turret cleartargetentity();
    turret setmode("sentry_offline");
  }

  if(isDefined(turret.turret_pointer)) {
    turret.turret_pointer delete();
  }

  wait 0.75;
  self notify("gunner_defeated");
}

function private function_cde7b4002c7a79eb() {
  foreach(rider in self.riders) {
    if(rider.vehicle_position == 4) {
      return rider;
    }
  }

  return undefined;
}

function function_36042e85a77d2242() {
  while(!isDefined(self.mgturret)) {
    if(isDefined(self.turrets) && (isDefined(self.turrets["jup_mg_jltv_mp"]) || isDefined(self.turrets["iw9_mg_jltv_mp"]))) {
      self.mgturret = [];

      if(isDefined(self.turrets["jup_mg_jltv_mp"])) {
        self.mgturret[0] = self.turrets["jup_mg_jltv_mp"];
      } else {
        self.mgturret[0] = self.turrets["iw9_mg_jltv_mp"];
      }
    }

    waitframe();
  }

  turret = self.mgturret[0];
  turret.ownervehicle = self;
  turret endon("stop_turret_behavior");

  while(!isDefined(self.gunner)) {
    waitframe();
  }

  turret function_2d08aa32acc33152("Init");

  while(true) {
    wait 0.2;

    if(turret.curstate == "EndBehavior") {
      continue;
    }

    if(!isDefined(self.gunner) || !isalive(self.gunner)) {
      turret function_2d08aa32acc33152("NoGunner");
      continue;
    }

    if(function_dc81cfe47b0383f7()) {
      turret function_2d08aa32acc33152("AttackPlayer");
      continue;
    }

    turret function_2d08aa32acc33152("Sweep");
  }
}

function function_2d08aa32acc33152(newstate) {
  if(isDefined(self.curstate) && newstate == self.curstate) {
    return;
  }

  if(isDefined(self.curstate) && self.curstate == "EndBehavior" && newstate != "Init") {
    return;
  }

  switch (newstate) {
    case #"hash_9bca931401172fb3":
      thread function_61e2c81826f25e3d();
      break;
    case #"hash_adfa56541ac05c65":
      thread function_46667b2536868e13();
      break;
    case #"hash_64530731442f6918":
      thread function_f18790b754e2fef6();
      break;
    case #"hash_a3b7d367f5d49123":
      thread function_801dc7148e82af03();
      break;
    case #"hash_6deeea2786ca360c":
      thread function_68e8f113a0f752da();
      break;
  }

  self.curstate = newstate;
}

function private function_61e2c81826f25e3d() {
  self notify("vehicle_mg_turret_turret_newbehavior");
  self endon("vehicle_mg_turret_turret_newbehavior");
  self setmode("manual");
  self settoparc(25);
  self setbottomarc(25);
  self setleftarc(180);
  self setrightarc(180);
  thread function_a23f6f0e65a71dab();
}

function private function_46667b2536868e13() {
  self notify("vehicle_mg_turret_turret_newbehavior");
  self endon("vehicle_mg_turret_turret_newbehavior");
  self turretfiredisable();
  self cleartargetentity();
}

function private function_f18790b754e2fef6() {
  self notify("vehicle_mg_turret_turret_newbehavior");
  self endon("vehicle_mg_turret_turret_newbehavior");
  self setconvergencetime(2, "yaw");
  self setconvergencetime(2, "pitch");
  thread function_3e7e0fbbb69e6a6e();
  childthread function_ad5b49b513608505();
  childthread function_5b555f80f9ea3203();
}

function private function_3e7e0fbbb69e6a6e() {
  self endon("vehicle_mg_turret_turret_newbehavior");
  wait 3;
  self turretfireenable();
}

function private function_801dc7148e82af03() {
  self notify("vehicle_mg_turret_turret_newbehavior");
  self endon("vehicle_mg_turret_turret_newbehavior");
  self setconvergencetime(4, "yaw");
  self setconvergencetime(4, "pitch");

  if(istrue(self.var_51bda74c63974c44)) {
    self turretfireenable();
  } else {
    self turretfiredisable();
  }

  level.var_71d3a2515466d4ad = getStructArray("turret_sweep_target", "targetname");
  search_side = 1;

  while(true) {
    success = function_4389288d0f185b0a(search_side);

    if(istrue(success)) {
      search_side *= -1;
    }

    self cleartargetentity();
    waitframe();
  }
}

function private function_68e8f113a0f752da() {
  self notify("vehicle_mg_turret_turret_newbehavior");
  self notify("stop_turret_behavior");
  level notify("turret_EndBehavior");
  self cleartargetentity();
  self turretfireenable();
}

function private function_a23f6f0e65a71dab() {
  waittill_any_ents(self, "death", self.ownervehicle.gunner, "death", self.ownervehicle, "gunner_defeated", self.ownervehicle, "disable_turrets", level, "flag_dungeon_outro_start", level, "game_over");
  function_2d08aa32acc33152("EndBehavior");
}

function private function_ad5b49b513608505() {
  last_known_pos = undefined;
  self.ownervehicle.var_f9374a64ef9c64ec = undefined;
  var_2d1996a1afa79192 = 0;
  aim_offset = (0, 0, 0);
  ignore_array = [self, self.ownervehicle.gunner];
  ignore_array = array_combine(ignore_array, level.players);

  while(true) {
    waitframe();

    if(!isDefined(level.players) || level.players.size == 0) {
      function_8f2c513d45a65cf2("<dev string:xa6>", "<dev string:xb1>", (1, 0, 0));

      continue;
    }

    self.var_f9374a64ef9c64ec = scripts\cp\utility::get_closest_living_player();

    if(!isDefined(self.var_f9374a64ef9c64ec)) {
      function_8f2c513d45a65cf2("<dev string:xa6>", "<dev string:xc2>", (1, 0, 0));

      continue;
    }

    if(!is_equal(self.ownervehicle.gunner.enemy, self.var_f9374a64ef9c64ec)) {
      function_8f2c513d45a65cf2("<dev string:xa6>", "<dev string:xd6>", (1, 0, 0));

      continue;
    }

    if(gettime() - self.ownervehicle.gunner lastknowntime(self.var_f9374a64ef9c64ec) > 10000) {
      function_8f2c513d45a65cf2("<dev string:xa6>", "<dev string:xf7>", (1, 0, 0));

      continue;
    }

    var_3ddca0e2bc88225c = self.ownervehicle.gunner lastknownpos(self.var_f9374a64ef9c64ec);

    if(is_equal(var_3ddca0e2bc88225c, last_known_pos)) {
      function_8f2c513d45a65cf2("<dev string:xa6>", "<dev string:x103>", (1, 1, 0));

      continue;
    }

    last_known_pos = var_3ddca0e2bc88225c;

    if(gettime() > var_2d1996a1afa79192) {
      start_origin = self gettagorigin("tag_aim");
      eye_offset = self.var_f9374a64ef9c64ec getEye() - self.var_f9374a64ef9c64ec.origin - (0, 0, 10);

      if(scripts\engine\trace::ray_trace_passed(start_origin, last_known_pos, ignore_array)) {
        aim_offset = (0, 0, 0);
      } else if(scripts\engine\trace::ray_trace_passed(start_origin, last_known_pos + eye_offset, ignore_array)) {
        aim_offset = eye_offset;
      } else if(scripts\engine\trace::ray_trace_passed(start_origin, last_known_pos + eye_offset / 2, ignore_array)) {
        aim_offset = eye_offset / 2;
      }

      var_2d1996a1afa79192 = gettime() + 1000;
    }

    aim_pos = last_known_pos + aim_offset;

    if(distancesquared(aim_pos, self.ownervehicle.origin) < 40000 && !self turretcantarget(aim_pos)) {
      aim_origin = self.ownervehicle.origin;
      aim_fwd = flatten_vector(aim_pos - aim_origin);
      aim_pos = aim_origin + aim_fwd * 500;
    }

    function_8f2c513d45a65cf2("<dev string:xa6>", "<dev string:x11f>", (0, 1, 0));

    function_fe473f00e5fc7644(aim_pos);
  }
}

function private function_5b555f80f9ea3203() {
  gunner = self.ownervehicle.gunner;

  while(!function_886fa3ae45871fff(gunner)) {
    waitframe();
  }

  while(true) {
    waitframe();

    if(!isDefined(self.var_f9374a64ef9c64ec)) {
      function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x133>", (1, 0, 0));

      continue;
    }

    if(!is_equal(gunner.enemy, self.var_f9374a64ef9c64ec)) {
      function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x146>", (1, 0, 0));

      continue;
    }

    if(gettime() - gunner lastknowntime(self.var_f9374a64ef9c64ec) > 10000) {
      function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x168>", (1, 0, 0));

      continue;
    }

    if(isDefined(self.turret_pointer)) {
      if(!self turretcantarget(self.turret_pointer.origin)) {
        function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x17e>", (1, 0, 0));

        continue;
      }
    }

    start_origin = self gettagorigin("tag_flash");
    start_angles = self gettagangles("tag_flash");
    target_origin = gunner lastknownpos(self.var_f9374a64ef9c64ec);

    if(!function_a19a6b814df3b1d6(start_origin, start_angles, target_origin)) {
      function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x19a>", (1, 0, 0));

      continue;
    }

    if(distance2dsquared(self.origin, target_origin) > squared(1800)) {
      function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x1c6>", (1, 0, 0));

      function_8f2c513d45a65cf2("<dev string:x1da>", "<dev string:x1e3>", (1, 0, 0));

      continue;
    } else {
      function_8f2c513d45a65cf2("<dev string:x1da>", "<dev string:x1f0>", (0, 1, 0));
    }

    trace = scripts\engine\trace::ray_trace(start_origin, start_origin + anglesToForward(start_angles) * 1800, self);
    hit_ent = trace["entity"];

    if(isDefined(hit_ent) && (hit_ent == self.ownervehicle || is_equal(hit_ent.team, "axis"))) {
      function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x1fa>", (1, 0, 0));

      continue;
    }

    function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x21c>", (0, 1, 0));

    for(i = 0; i < 10; i++) {
      self shootturret("tag_flash");
      level notify("technical_hot_event", gunner);

      if(isDefined(level.var_3715dfcccf50ccdb)) {
        thread[[level.var_3715dfcccf50ccdb]]();
      }

      wait 0.1;
    }

    wait 1;

    while(!function_886fa3ae45871fff(gunner)) {
      waitframe();
    }
  }
}

function private function_886fa3ae45871fff(gunner) {
  if(!isDefined(self.var_f9374a64ef9c64ec)) {
    function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x133>", (1, 0, 0));

    return false;
  }

  if(gunner cansee(self.var_f9374a64ef9c64ec)) {
    function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x226>", (1, 0, 0));

    return true;
  }

  last_known_time = gunner lastknowntime(self.var_f9374a64ef9c64ec);

  if(!isDefined(last_known_time)) {
    function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x247>", (1, 0, 0));

    return false;
  }

  if(gettime() - last_known_time > 10000) {
    function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x168>", (1, 0, 0));

    return false;
  }

  last_known_pos = gunner lastknownpos(self.var_f9374a64ef9c64ec);

  if(!isDefined(last_known_pos)) {
    function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x278>", (1, 0, 0));

    return false;
  }

  if(!function_a19a6b814df3b1d6(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), last_known_pos)) {
    function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x19a>", (1, 0, 0));

    return false;
  }

  if(distancesquared(last_known_pos, self.var_f9374a64ef9c64ec.origin) > squared(1800)) {
    function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x1c6>", (1, 0, 0));

    return false;
  } else {
    function_8f2c513d45a65cf2("<dev string:x1da>", "<dev string:x1f0>", (0, 1, 0));
  }

  function_8f2c513d45a65cf2("<dev string:x129>", "<dev string:x2ad>", (0, 1, 0));

  return true;
}

function private function_a19a6b814df3b1d6(start_origin, start_angles, var_c74e2e565ee3fe18) {
  if(!isDefined(self.var_f9374a64ef9c64ec)) {
    return false;
  }

  pass = 0;

  if(within_fov(start_origin, start_angles, var_c74e2e565ee3fe18, 0.7)) {
    function_8f2c513d45a65cf2("<dev string:x2b8>", "<dev string:x2bc>", (0, 1, 0));

    return true;
  }

  eye_offset = self.var_f9374a64ef9c64ec getEye() - self.var_f9374a64ef9c64ec.origin;

  if(within_fov(start_origin, start_angles, var_c74e2e565ee3fe18 + eye_offset, 0.7)) {
    function_8f2c513d45a65cf2("<dev string:x2b8>", "<dev string:x2bc>", (0, 1, 0));

    return true;
  }

  if(within_fov(start_origin, start_angles, var_c74e2e565ee3fe18 + eye_offset / 2, 0.7)) {
    function_8f2c513d45a65cf2("<dev string:x2b8>", "<dev string:x2bc>", (0, 1, 0));

    return true;
  }

  function_8f2c513d45a65cf2("<dev string:x2b8>", "<dev string:x2c4>", (1, 0, 0));

  return false;
}

function private function_4389288d0f185b0a(search_side) {
  closest_targets = get_array_of_closest(self.ownervehicle.origin, level.var_71d3a2515466d4ad, undefined, undefined, 4000);
  valid_targets = [];
  right_dir = anglestoright(self.ownervehicle.angles);
  var_a02118632c7f1621 = getStructArray("defender_hardpoint", "script_noteworthy");
  var_6b84f2ec187b1c4d = getclosest(self.ownervehicle.origin, var_a02118632c7f1621, 1500);

  if(isDefined(var_6b84f2ec187b1c4d)) {
    dir = vectorNormalize(var_6b84f2ec187b1c4d.origin - self.ownervehicle.origin);
    dot = vectordot(right_dir, dir);
    search_side = dot;
  }

  foreach(target in closest_targets) {
    dir = vectorNormalize(target.origin - self.ownervehicle.origin);
    dot = vectordot(right_dir, dir);

    if(dot * search_side <= 0) {
      continue;
    }

    if(!self turretcantarget(target.origin)) {
      continue;
    }

    valid_targets[valid_targets.size] = target;
  }

  best_target = undefined;

  foreach(player in level.players) {
    dir = vectorNormalize(player.origin - self.ownervehicle.origin);
    dot = vectordot(right_dir, dir);

    if(dot * search_side > 0) {
      best_target = getclosest(player.origin, valid_targets);
      continue;
    }

    best_target = getfarthest(player.origin, valid_targets);
  }

  var_8f133d816a123660 = undefined;

  if(isDefined(best_target)) {
    var_8f133d816a123660 = best_target.origin;
  } else {
    random_x = self.origin[0] + randomintrange(-1000, 1000);
    random_y = self.origin[1] + randomintrange(-1000, 1000);
    random_z = self.origin[2] + randomintrange(20, 50);
    var_8f133d816a123660 = (random_x, random_y, random_z);
  }

  function_fe473f00e5fc7644(var_8f133d816a123660);
  function_5d7f0fa663061c51(4);
  return true;
}

function private function_fe473f00e5fc7644(pos) {
  if(!isDefined(self.turret_pointer)) {
    self.turret_pointer = spawn_script_origin(pos);
  } else {
    self.turret_pointer.origin = pos;
  }

  self settargetentity(self.turret_pointer);
}

function private function_5d7f0fa663061c51(timeout) {
  og_forward = anglesToForward(self.ownervehicle.angles);
  timeout_time = gettime() + timeout * 1000;

  while(gettime() < timeout_time) {
    waitframe();
    forward = anglesToForward(self.ownervehicle.angles);
    dot = vectordot(og_forward, forward);

    if(dot < 0.5) {
      break;
    }
  }
}

function private function_dc81cfe47b0383f7() {
  self endon("death");
  level endon("game_over");
  group_size = 5;

  if(isDefined(self.aiseats)) {
    group_size = self.aiseats.size;
  }

  passengers = [];
  passengers = array_add(passengers, self.riders[0]);
  passengers = array_add(passengers, self.riders[group_size - 1]);
  return namespace_a0852b262a68d01::function_155f16ed1b7f00cd(passengers, 10);
}

function function_504a6eecbc2db511(player) {
  player endon("death");
  level endon("game_over");

  while(true) {
    level waittill("spawned_vehicle");

    if(isDefined(level.vehicle) && isDefined(level.vehicle.compass) && isDefined(level.vehicle.compass.instances)) {
      foreach(veh in level.vehicle.compass.instances) {
        if(!isDefined(veh)) {
          continue;
        }

        veh thread update_vehicle_fow_visibility(player);
      }
    }

    waitframe();
  }
}

function private update_vehicle_fow_visibility(player) {
  self endon("death");
  self endon("entitydeleted");
  player endon("death");
  level endon("game_over");
  self notify("update_vehicle_FOW_visibility");
  self endon("update_vehicle_FOW_visibility");
  var_b78d8e455ee5f092 = -1;

  while(true) {
    if(isDefined(player) && isPlayer(player) && isalive(player)) {
      currentstate = scripts\cp_mp\vehicles\vehicle_compass::vehicle_compass_shouldbevisibletoplayer(self, player);

      if(var_b78d8e455ee5f092 != currentstate) {
        if(currentstate) {
          self vehicleshowonminimap(1);
          self vehicleshowonminimapforclient(player, 1);
        } else {
          self vehicleshowonminimap(0);
          self vehicleshowonminimapforclient(player, 0);
        }

        var_b78d8e455ee5f092 = currentstate;
      }
    }

    wait 0.25;
  }
}

function private function_b1eab7c7fda1fb57() {}

function function_e7813196f9c1136d() {
  dvar = getunarchiveddebugdvar(@ "debug_turret", "<dev string:x1c>");
  return int(dvar);
}

function function_173155a78c3609b6(vehicle, turret) {
  vehicle endon("<dev string:x2cf>");

  while(true) {
    if(function_e7813196f9c1136d()) {
      turret function_f58445f5019e2b7e();
      vehicle function_9e5df0d209bb4ff4(turret);
      var_b112cabff90e69d = function_45d81fcf37c996d6("<dev string:xa6>");
      var_fcb89b4892ea60fc = function_45d81fcf37c996d6("<dev string:x129>");
      dist_status = function_45d81fcf37c996d6("<dev string:x1da>");
      fov_status = function_45d81fcf37c996d6("<dev string:x2b8>");
      function_dd7ad6e8da294b01("<dev string:x2d5>", "<dev string:x2e0>");

      if(isDefined(var_b112cabff90e69d)) {
        function_dd7ad6e8da294b01("<dev string:x2d5>", "<dev string:x2f4>" + var_b112cabff90e69d.text, var_b112cabff90e69d.color);
      }

      if(isDefined(var_fcb89b4892ea60fc)) {
        function_dd7ad6e8da294b01("<dev string:x2d5>", "<dev string:x300>" + var_fcb89b4892ea60fc.text, var_fcb89b4892ea60fc.color);
      }

      if(isDefined(dist_status)) {
        function_dd7ad6e8da294b01("<dev string:x2d5>", "<dev string:x30e>" + dist_status.text, dist_status.color);
      }

      if(isDefined(fov_status)) {
        function_dd7ad6e8da294b01("<dev string:x2d5>", "<dev string:x31f>" + fov_status.text, fov_status.color);
      }

      function_20367cc98c4d2265("<dev string:x2d5>");
    }

    waitframe();
  }
}

function function_8f2c513d45a65cf2(channel, str, color) {
  if(!isDefined(level.turret)) {
    level.turret = spawnStruct();
  }

  if(!isDefined(level.turret.debug)) {
    level.turret.debug = spawnStruct();
  }

  if(!isDefined(level.turret.debug.status_channels)) {
    level.turret.debug.status_channels = [];
  }

  if(!isDefined(level.turret.debug.status_channels[channel])) {
    level.turret.debug.status_channels[channel] = spawnStruct();
  }

  level.turret.debug.status_channels[channel].text = str;
  level.turret.debug.status_channels[channel].color = color;
}

function function_20367cc98c4d2265(type) {
  level.turret.debug.screen[type] = 0;
}

function function_45d81fcf37c996d6(channel) {
  if(!isDefined(level.turret)) {
    return undefined;
  }

  if(!isDefined(level.turret.debug)) {
    return undefined;
  }

  if(!isDefined(level.turret.debug.status_channels)) {
    return undefined;
  }

  if(!isDefined(level.turret.debug.status_channels[channel])) {
    return undefined;
  }

  return level.turret.debug.status_channels[channel];
}

function function_dd7ad6e8da294b01(type, msg, color) {
  if(!isDefined(level.turret)) {
    level.turret = spawnStruct();
  }

  if(!isDefined(level.turret.debug)) {
    level.turret.debug = spawnStruct();
  }

  if(!isDefined(level.turret.debug.screen)) {
    level.turret.debug.screen = [];
  }

  if(!isDefined(level.turret.debug.screen[type])) {
    level.turret.debug.screen[type] = 0;
  }

  x = 10;

  if(type == "<dev string:x2d5>") {
    y = 50;
  } else if(type == "<dev string:x32b>") {
    y = 150;
  } else if(type == "<dev string:x332>") {
    y = 250;
  } else {
    y = 350;
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  y += level.turret.debug.screen[type] * 15;
  printtoscreen2d(x, y, msg, color, 1.25);
  level.turret.debug.screen[type]++;
}

function function_f58445f5019e2b7e() {
  dot = 0.7;
  fov_yaw = acos(dot);
  arc_segs = 10;
  fovcosinez = cos(20);
  arc_tag = "<dev string:x337>";
  color = (1, 0, 0);
  turret_yaw = self getturretcurrentyaw();
  flash_yaw = self gettagangles(arc_tag)[1];
  yaw_to_use = flash_yaw;
  start = self gettagorigin(arc_tag);
  scripts\stealth\debug::draw_arc(start, -1 * fov_yaw, fov_yaw, (0, yaw_to_use, 0), 1800, 1, arc_segs, color);

  if(fovcosinez > dot) {
    color *= 0.5;
    fov_pitch = acos(fovcosinez);
    eye_pitch = 0;
    scripts\stealth\debug::draw_arc(start, -1 * fov_pitch, fov_pitch, (eye_pitch, yaw_to_use, 0), 1800, 0, arc_segs, color);
  }
}

function function_9e5df0d209bb4ff4(turret) {
  if(!isDefined(turret.turret_pointer)) {
    return;
  }

  start = turret gettagorigin("<dev string:x337>");
  line(start, turret.turret_pointer.origin, (1, 0, 0));
  sphere(turret.turret_pointer.origin, 8, (1, 0, 0));
  print3d(turret.turret_pointer.origin, "<dev string:x341>", (1, 0, 0), 1, 0.25, 1, 1);
}

function function_b3e7de6bb615773f() {
  while(true) {
    if(getdvarint(@ "hash_b33dfa2c5d1b92db", 0) == 1) {
      vehicles = vehicle_getarray();

      foreach(vehicle in vehicles) {
        if(!vehicle scripts\cp_mp\vehicles\vehicle::isvehicle()) {
          continue;
        }

        leveldataforvehicle = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle(vehicle.vehiclename);

        if(!isDefined(leveldataforvehicle)) {
          continue;
        }

        if(vehicle scripts\cp_mp\vehicles\vehicle::isvehicledestroyed()) {
          continue;
        }

        frontoffsetvec = anglesToForward(vehicle.angles) * leveldataforvehicle.frontextents;
        backoffsetvec = anglesToForward(vehicle.angles) * -1 * leveldataforvehicle.frontextents;
        leftoffsetvec = anglestoright(vehicle.angles) * -1 * leveldataforvehicle.leftextents;
        rightoffsetvec = anglestoright(vehicle.angles) * leveldataforvehicle.rightextents;
        var_9f0d15eba340bf01 = anglestoup(vehicle.angles) * leveldataforvehicle.bottomextents;
        var_778e08d0a232328f = leveldataforvehicle.distancetobottom;
        var_ac307e84851e9014 = vehicle.origin + frontoffsetvec + leftoffsetvec;
        var_e17a04abec5f5041 = vehicle.origin + frontoffsetvec + rightoffsetvec;
        var_23b140236499fe2 = vehicle.origin + backoffsetvec + leftoffsetvec;
        var_1118294591c12077 = vehicle.origin + backoffsetvec + rightoffsetvec;
        frontleftbottom = var_ac307e84851e9014 - var_9f0d15eba340bf01;
        frontrightbottom = var_e17a04abec5f5041 - var_9f0d15eba340bf01;
        var_c80d7a3533c8f664 = var_23b140236499fe2 - var_9f0d15eba340bf01;
        var_62962038a03e2b7f = var_1118294591c12077 - var_9f0d15eba340bf01;
        var_cfa9836a54166d96 = var_ac307e84851e9014 - (0, 0, var_778e08d0a232328f);
        var_99c083275e810a1 = var_e17a04abec5f5041 - (0, 0, var_778e08d0a232328f);
        var_7d4326b2ec6739f4 = var_23b140236499fe2 - (0, 0, var_778e08d0a232328f);
        var_dfb315e8ee8333df = var_1118294591c12077 - (0, 0, var_778e08d0a232328f);
        var_1d29919376ad4830 = [];
        var_1d29949376ad4ec9 = [];
        var_1d29939376ad4c96 = [];
        var_1d29919376ad4830[0] = var_ac307e84851e9014;
        var_1d29919376ad4830[1] = var_e17a04abec5f5041;
        var_1d29919376ad4830[2] = var_1118294591c12077;
        var_1d29919376ad4830[3] = var_23b140236499fe2;
        var_1d29949376ad4ec9[0] = frontleftbottom;
        var_1d29949376ad4ec9[1] = frontrightbottom;
        var_1d29949376ad4ec9[2] = var_62962038a03e2b7f;
        var_1d29949376ad4ec9[3] = var_c80d7a3533c8f664;
        var_1d29939376ad4c96[0] = var_cfa9836a54166d96;
        var_1d29939376ad4c96[1] = var_99c083275e810a1;
        var_1d29939376ad4c96[2] = var_dfb315e8ee8333df;
        var_1d29939376ad4c96[3] = var_7d4326b2ec6739f4;

        for(i = 0; i < 4; i++) {
          j = i + 1;

          if(j == 4) {
            j = 0;
          }

          line(var_1d29919376ad4830[i], var_1d29919376ad4830[j], (1, 0, 0), 1, 0, 1);
          line(var_1d29949376ad4ec9[i], var_1d29949376ad4ec9[j], (1, 0, 0), 1, 0, 1);
          line(var_1d29919376ad4830[i], var_1d29949376ad4ec9[i], (1, 0, 0), 1, 0, 1);
        }

        for(i = 0; i < 4; i++) {
          j = i + 1;

          if(j == 4) {
            j = 0;
          }

          line(var_1d29949376ad4ec9[i], var_1d29949376ad4ec9[j], (1, 1, 0), 1, 0, 1);
          line(var_1d29939376ad4c96[i], var_1d29939376ad4c96[j], (1, 1, 0), 1, 0, 1);
          line(var_1d29949376ad4ec9[i], var_1d29939376ad4c96[i], (1, 1, 0), 1, 0, 1);
        }
      }
    }

    waitframe();
  }
}

# /