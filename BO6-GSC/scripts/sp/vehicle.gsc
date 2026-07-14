/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\vehicle.gsc
**************************************/

#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\asm\asm_sp;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_lights;
#using scripts\common\vehicle_paths;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\drone_base;
#using scripts\sp\fakeactor;
#using scripts\sp\mgturret;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_stats;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#using scripts\sp\vehicle_treads;
#namespace vehicle;

function init_vehicles() {
  if(!utility::add_init_script("s\x8dH\xe6\x80\x89\x11\x01\x8e\xf63", &init_vehicles)) {
    return;
  }

  utility::create_func_ref("='p\xc3\x7f\xf8\x05 $\x01", &makefakeai);
  utility::create_func_ref("\x85>\x94\xaan9\x18<89\xe6\x9fXr\xdb\x9d\xf1\xe8\xc2\xe8", &setturretignoregoals);
  utility::create_func_ref("X&\\\xe6\xa3n\xae\x06\x05kz\x95\xe1,b\xc9", &vehicle_orientto);
  utility::create_func_ref("\xb3e\xa3\xcd\x0eXw\xe6e9,\x9c\xe4X\xbc", &getspawnerarray);
  utility::create_func_ref("U\t6|c\x1em\xb7\xd0~@", &setaispread);
  utility::create_func_ref("aA\x99(\xed{P\x1d}T(_0\r\x98Us", &vehicle_script_forcecolor_riders);
  utility::create_func_ref("\xcd!{\xf5)\x92\x1c\xcd\x0e\x93\xfc\x17O\b", &vehicle_treads::vehicle_treads);
  utility::create_func_ref("=\xc3\xc5\x1a\xd1\t|M\xb2\xbd9\x17\n\x94\xfa", &drone_base::drone_give_soul);
  utility::create_func_ref("\xe6\xa1\xe1\x1eX\xbdJD\xec\x94\x85\x98\x80\xb1PF\xae1\xf8", &fakeactor::fakeactor_give_soul);
  utility::create_func_ref("\xf3\xa6\xbc\xd8\xff\x93T\x81`\xe9\xeaf\xf1x\xae\xc3B\f", &shared::placeweaponon);
  utility::create_func_ref("5\xff\xfas\xf2\x824\xd4\xe69\xb8$p\x03\x8d\\\x1c", &spawner::vehicle_deathflag);
  utility::create_func_ref("\xc6J\xb0\xaa\xc3\fYS\xa1\x99[]\xf2\x15\xc9Dg\x92\x165\xfc\xd9\xda|p", &spawner::vehicle_spawner_deathflag);
  utility::create_func_ref("\xa1\xaf\"q\xdd\x9dCv\xdf\vNjy\x86\xd1\x7f\xbdm\xaf", &spawner::run_spawn_functions);
  utility::create_func_ref("\xa7\xa8\xcdB\xe7\x01w\xed\xdf&\xe2Oj\xb7\xdd\x9c\xff\xbe\xb5", &utility::updateanimpose);
  utility::create_func_ref("P\xcf\xa8\x85K\x9d\x18*\n\x15\x17\t\xba\xf8K\x11\x13", &notetracks::donotetracks);
  utility::create_func_ref(" \xdd-(:\xca'(?GP\x8c3p\xa3P\x0e]s\"}", &shared::dropallaiweapons);
  utility::create_func_ref("~\xc7g\xdc\x957z}_#\xb1\x91\xfb", &player_stats::register_kill);
  utility::create_func_ref("\xbd\xfd)3\x9d\xac\x1da\xc9\xee\xb1\t\xe2\xcb\x8c{\xac", &player_stats::register_shot_hit);
  utility::create_func_ref("\xbd\xfd)3\x9d\xac\x1da\xc9\xee\xb1\t\xe2\xcb\x8c{\xac", &player_stats::register_shot_hit);
  utility::create_func_ref("\xaa\xc7\xa3\xf0p]P^\xcfPZAj\xdf\xcahh\xc3\xdb", &mgturret::burst_fire_unmanned);
  utility::create_func_ref("V\\\x19\x0e*\xcdZ{\xa1\xc3\x7f\xad<5R\xbc\x1f\xa9M4\xb6", &mgturret::turret_watchplayeruse);
  utility::create_func_ref("z\x9b5wF\xe4\x93\xb5\xd5l\xefq\xb1\xfd", &asm_sp::asm_animcustom);
  utility::create_func_ref("\x9e]T\xeb\xf4J]\xdf\xcd\xdd\xb6\xc8\x8a\x81\x88S2@", &spawner::spawner_makerealai);
  utility::create_func_ref("\xeb;\x8a\x15x l/\x1c|\nb", &spawner::use_a_turret);
  utility::create_func_ref("Q\x87\x7f\x0e\xc0E\xa1q\xe9\xe0", &spawner::go_to_node);
  utility::create_func_ref("\xcc\x85\xb9\x1d9\xb7p\xac\xfaa\x9b\xb4m", &fastrope_anim);
  utility::create_func_ref("\xbbZ\xf6p\xd9F\xdf1W\x98&\xb9\x8eQ\x9a\xb8\xd8", &door_anim);
  utility::create_func_ref("\x17\xbdxO\xb7D\xae\x8e\xa5?\x98}N\xea", &function_c6973c7ecc5591a0);
  utility::registersharedfunc(#"vehicle", #"updatedamagestate", &vehicle_updatedamagestate);
  callback::add(#"vehicle_create_early", &function_49ecec455b7b5dd3);
  callback::add(#"vehicle_create", &function_1a136f80b274c97e);
  callback::add(#"vehicle_create_late", &function_1c900dff808826b2);
  callback::add(#"player_vehicle_enter", &function_6c26f15bdd57734e);
  callback::add(#"player_vehicle_exit", &function_5aeae29d5e86a6ce);

  setdvarifuninitialized(@ "vehicle_spawner_vehicletype", "<dev string:x24>");
  devgui::function_ddef1d43d4e5ef07("<dev string:x28>", "<dev string:x52>", &function_c4ea8cf3e924e7e6, 0, 2);

  setsaveddvar(@ "hash_6c581ca7ecebfbd7", 0);
  setsaveddvar(@ "hash_df58327eaa885dfe", 0.6);
  level thread init();
  level thread vehicle_ai::init();
  function_d94697ab77a94084();
  function_82723d0344d232c();
}

function function_d94697ab77a94084() {
  if(getdvarint(@ "hash_742caa13b3c2e685", 0)) {
    return;
  }

  if(isDefined(level.disablevehiclescripts) && level.disablevehiclescripts) {
    return;
  }

  if(!utility::add_init_script("\x1c\x91\b\x15^\x82\x84\xf8", &init_vehicles)) {
    return;
  }

  thread init_vehicles_thread();
  cleanup_vt();
}

function cleanup_vt() {
  level.vtclassname = undefined;
  level.vtmodel = undefined;
  level.vttype = undefined;
}

function init_vehicles_thread() {
  utility::create_lock("\x86\xea;VCIgLa\x05A\xfa{L\x97\xa2\x16L");
  vehicle_code::vehicle_setuplevelvariables();
  level.vehicle.helicopter_crash_locations = utility::array_combine(level.vehicle.helicopter_crash_locations, utility::getstructarray_delete("v\xab\xa3\x83\x7fq\x19\"`l\xc8y&\xbf,\x9d\ab\x1c\xd0\x8c\xd7\xa6a\x84", "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc"));
  vehicle_setupspawners();
  allvehiclesprespawn = vehicle_precachescripts();
  setup_vehicles(allvehiclesprespawn);
  level.vehicle.has_vehicles = getEntArray("\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e", #code_classname).size > 0;
  utility::script_func("\x18\x9a\x90o\x18[\xa9\x11F\x149\x17P\x81{", "\xdbc\xd9@\xd4\x1e\xceh\x93\xab\xfc\x91\x86i\x84\xff\x8f", &"script/invulerable_frags");
  utility::script_func("\x18\x9a\x90o\x18[\xa9\x11F\x149\x17P\x81{", "\xdc\x9fV\xbe`z\x16)H\xd6\xe5\xe2S~\x81\x91l\xcc<", &"script/invulerable_bullets");
  utility::script_func("\x18\x9a\x90o\x18[\xa9\x11F\x149\x17P\x81{", "\n\xab\t\x1b\x9d\x12\xdexp\xfb\x122\b", &"script/enter_vehicle");
  utility::script_func("\x18\x9a\x90o\x18[\xa9\x11F\x149\x17P\x81{", "e\x1e\x96G\xeb\xd9+Cil\xd8\xac", &"script/exit_vehicle", &function_57109d2dc6bc406f);
}

function vehicle_setupspawners() {
  spawners = vehicle_code::_getvehiclespawnerarray();

  foreach(spawner in spawners) {
    spawner thread vehicle_spawnerlogic();
    model = spawner vehicle_code::function_5ceb396224add9b3();

    if(isDefined(spawner.var_d22ac03c16b6e075) && isDefined(model)) {
      array = strtok(spawner.var_d22ac03c16b6e075, "\x16");

      for(i = 0; i < array.size; i++) {
        if(array[i] == "z\xd4mN") {
          precachemodel(model);
          continue;
        }

        precachemodel(array[i] + "W\xd3" + model);
      }

      if(isDefined(level.vehicle.templates.husk[model])) {
        for(i = 0; i < array.size; i++) {
          if(array[i] == "z\xd4mN") {
            precachemodel(level.vehicle.templates.husk[model]);
            continue;
          }

          if(istrue(level.vehicle.templates.var_823d01d0e03d4202[model])) {
            precachemodel(array[i] + "W\xd3" + level.vehicle.templates.husk[model]);
          }
        }
      }

      if(isDefined(level.vehicle.templates.mgturret[spawner.classname])) {
        for(i = 0; i < array.size; i++) {
          if(array[i] != "z\xd4mN") {
            precachemodel(array[i] + "W\xd3" + level.vehicle.templates.mgturret[spawner.classname][0].model);
          }
        }
      }

      if(isDefined(level.vehicle.templates.mainturret[spawner.classname])) {
        for(i = 0; i < array.size; i++) {
          if(array[i] != "z\xd4mN") {
            precachemodel(array[i] + "W\xd3" + level.vehicle.templates.mainturret[spawner.classname].model);
          }
        }
      }
    }
  }
}

function vehicle_spawnerlogic() {
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(isDefined(self.script_deathflag)) {
    thread utility::script_func("\xc6J\xb0\xaa\xc3\fYS\xa1\x99[]\xf2\x15\xc9Dg\x92\x165\xfc\xd9\xda|p");
  }

  self.count = 1;
  self.spawn_functions = [];

  while(true) {
    self waittill("\xcb!f\x94\xa0@\xc1", vehicle);
    self.count--;

    if(!isDefined(vehicle)) {
      println("<dev string:x6b>" + self.origin + "<dev string:x8f>");
      continue;
    }

    vehicle.spawn_funcs = self.spawn_functions;
    vehicle.spawner = self;
    vehicle thread utility::script_func("\xa1\xaf\"q\xdd\x9dCv\xdf\vNjy\x86\xd1\x7f\xbdm\xaf");
  }
}

function vehicle_precachescripts() {
  allvehiclesprespawn = [];
  level.needsprecaching = [];

  if(!isDefined(level.vehicleinitthread)) {
    level.vehicleinitthread = [];
  }

  vehicles = getEntArray("\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e", #code_classname);

  foreach(vehicle in vehicles) {
    if(vehicle.vehicletype == "\f5\xd5\x03\xff" || vehicle.vehicletype == "\xc1q\xcft\xf9\xe5ua\x02\xc1") {
      continue;
    }

    allvehiclesprespawn[allvehiclesprespawn.size] = vehicle;
    vehicle_precachesetup(vehicle.classname, vehicle);
  }

  if(level.needsprecaching.size > 0) {
    println("<dev string:xa4>");
    println("<dev string:xfd>");
    println("<dev string:xa4>");
    tab = "<dev string:x156>";

    foreach(reasons in level.needsprecaching) {
      println(index);

      foreach(reason in reasons) {
        println(tab + reason.pos);

        foreach(r in reason.reasons) {
          println(tab + tab + r);
        }
      }
    }

    println("<dev string:xa4>");

    assert(0, "<dev string:x15e>");
    level waittill("e\x14\x16\xc5\xc8");
  }

  return allvehiclesprespawn;
}

function vehicle_precachesetup(classname, vehicle) {
  vehicletype = getxhashasset(vehicle.vehicletype);

  if(isDefined(level.vehicleinitthread[vehicletype]) && isDefined(level.vehicleinitthread[vehicletype][vehicle.classname])) {
    return;
  }

  if(vehicle.classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e") {
    return;
  }

  reasons = [];

  if(isDefined(level.needsprecaching[classname])) {
    reasons = level.needsprecaching[classname];
  }

  struct = spawnStruct();
  struct.pos = vehicle.origin;
  struct.reasons = [];

  if(!isDefined(level.vehicleinitthread[vehicletype])) {
    struct.reasons[struct.reasons.size] = "B\xb4\xec7\x1e\xe0\x7fh@`\xf2\xde\xe4" + vehicle.vehicletype + "\xed\x8b\xde\xff\x16L\xbe\xd7~\xd3xw:y\x8dw{~%\x16(ir\n\x99\xfc\x99\x7fi,,\xd50(\xcc\x12^\x84}\x16\x11o\xc9\x82\x9e\xb4\xbaa\x89\xa8\xa0\xf88\xe4\xd5\xa20\xf5\xf7\xae\x87\t:\x163J\xd2+\x02m\xd4\xa5\xa9\xe5\xe1|\xe1o\xe87y<\xbc\xb5\xd8s\xba\x14(\xb3P\x91\xcfw\xc73\x1b\x88%]\xa2\\F\x97\xa7\x9bd9h\xea\x1f6\x93.\xb4\xc4.\xf0\xcap\x82\xa2/c\xbe\x14|6O\xfa\xee\tS\xbe\xc6(\xc1\xcdQ\xa1";
  } else if(!isDefined(level.vehicleinitthread[vehicletype][vehicle.classname])) {
    struct.reasons[struct.reasons.size] = "p\xd2\to\xf7\xf3\xbe\xd6T\xdd\r" + vehicle.classname + "\xf7\xba\xe8\n5\xee\xf5\xd0~:\xf5\x8a\xe3\x1a'q\x8e\xea\xed\xd18x\xcd\xe0\x88\xd8S\x98un\xa1A#\x0f\x12\xac\xdayo\xe5\x8e\xe1\xd21\xae\xe0\xc4\xc5,h\xb2\xbc\r\x84`5S\xf6\x0e\xf6\xaa?\xafa<\xe5\xcd\x88&z\x03\x96\x03\xda\x1b\xcb\xa1@\x1e\xdf\xdaV\xe9\xd8\x86f\xe2\n\xb9\xaf\xd2PDDs\x8f~\x9e\xc9\xc9MN\xf29\xc23";
  }

  reasons[reasons.size] = struct;
  level.needsprecaching[classname] = reasons;
}

function setup_vehicles(vehicles) {
  nonspawned = [];

  foreach(vehicle in vehicles) {
    if(isspawner(vehicle)) {
      continue;
    }

    nonspawned[nonspawned.size] = vehicle;
  }

  foreach(live_vehicle in nonspawned) {
    model = live_vehicle vehicle_code::function_5ceb396224add9b3();

    if(isDefined(live_vehicle.var_d22ac03c16b6e075) && isDefined(model)) {
      array = strtok(live_vehicle.var_d22ac03c16b6e075, "\x16");
      color = array[randomintrange(0, array.size)];

      if(color == "z\xd4mN") {
        precachemodel(model);
      } else {
        precachemodel(color + "W\xd3" + model);
      }

      if(isDefined(level.vehicle.templates.husk[model])) {
        if(color == "z\xd4mN") {
          precachemodel(level.vehicle.templates.husk[model]);
        } else if(istrue(level.vehicle.templates.var_823d01d0e03d4202[model])) {
          precachemodel(color + "W\xd3" + level.vehicle.templates.husk[model]);
        }
      }

      if(color == "z\xd4mN") {
        live_vehicle setModel(model);
      } else {
        live_vehicle setModel(color + "W\xd3" + model);
      }
    }

    if(isDefined(live_vehicle.spawnflags) && live_vehicle.spawnflags & 16) {
      live_vehicle.isstationary = 1;
    }

    if(isDefined(live_vehicle.spawnflags) && live_vehicle.spawnflags & 4) {
      husk = live_vehicle thread function_2a7668c3238ff719(1);
      continue;
    }

    if(isDefined(live_vehicle.spawnflags)) {
      if(live_vehicle.spawnflags & 1) {
        live_vehicle thread utility::script_func("\x17\xbdxO\xb7D\xae\x8e\xa5?\x98}N\xea");
      } else {
        live_vehicle vehicle_turnengineoff();
        vehicle_interact::allow_use(live_vehicle, 0);
      }

      if(live_vehicle vehicle_isphysveh() && !live_vehicle ishelicopter() && (live_vehicle.spawnflags & 8 || istrue(live_vehicle.isstationary))) {
        live_vehicle vehphys_parkingbrake(1);
      }
    }

    thread vehicle_init(live_vehicle);
  }
}

function reservevehicle(count) {
  return true;
}

function vehicle_spawn(vspawner) {
  return vehicle_spawn_internal(vspawner);
}

function spawn_vehicle_and_gopath() {
  vehicle = spawn_vehicle();

  if(isDefined(self.script_speed)) {
    if(!ishelicopter()) {
      vehicle vehicle_setspeed(self.script_speed);
    }
  }

  thread vehicle_paths::gopath(vehicle);
  return vehicle;
}

function function_c4ea8cf3e924e7e6() {
  vehicletype = getDvar(@ "vehicle_spawner_vehicletype", "");

  if(vehicletype != "") {
    player = level.players[0];

    if(!isDefined(player)) {
      return;
    }

    forward = anglesToForward(player.angles);
    spawnposition = player.origin + (0, 0, 100) + forward * 300;
    spawnangles = player.angles * (0, 1, 0);
    vehicle = spawnVehicle(undefined, "v\x18\x90\xb51\xf6\xd3\xc0\x15\x1e\xaff\xed\x0eh\x90*\x05(", vehicletype, spawnposition, spawnangles);

    if(!isDefined(vehicle.interactdata)) {
      vehicle makeusable();
    }
  }
}

function spawn_vehicle_and_attach_to_spline_path(default_speed) {
  vehicle = spawn_vehicle();

  if(isDefined(default_speed)) {
    vehicle vehicle_setspeed(default_speed);
  }

  vehicle thread vehicle_becomes_crashable();
  vehicle endon("\x1e\xfd\xd1\xa2\a");
  vehicle.dontunloadonend = 1;
  vehicle vehicle_paths::gopath(vehicle);
  vehicle leave_path_for_spline_path();
}

function leave_path_for_spline_path() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\xdc\xc6N\xb4\xc1G\xaflN\x85\xcdC_g\x954Kl6e");
  utility::waittill_any("\xed\xd0Wt\xef\xd8ewu*\x89\xe3\xc6\xb5O\xe9\xdc9", "\xb47\xe8Q\xb4\xec7<\xda\x01\xf8\xbc\xb1\x90+\x02");
  node = get_my_spline_node(self.origin);

  if(isDefined(level.drive_spline_path_fun)) {
    node thread[[level.drive_spline_path_fun]](self);
  }
}

function get_my_spline_node(org) {
  org = (org[0], org[1], 0);
  all_nodes = utility::get_array_of_closest(org, level.snowmobile_path);
  close_nodes = [];

  for(i = 0; i < 3; i++) {
    close_nodes[i] = all_nodes[i];
  }

  foreach(path in level.snowmobile_path) {
    foreach(node in close_nodes) {
      if(node == path) {
        return node;
      }
    }
  }

  assert(0, "<dev string:x1c6>");
}

function vehicle_becomes_crashable() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xed\xd0Wt\xef\xd8ewu*\x89\xe3\xc6\xb5O\xe9\xdc9");
  waittillframeend();
  self.riders = utility::array_removedead(self.riders);

  if(self.riders.size) {
    utility::array_thread(self.riders, &vehicle_rider_death_detection, self);
    utility::waittill_any("\xec\x95\x86\xfac{\x1b\x1b\xd2n-\xedn", "\xc0\x92\xbeY\xa2o!\xed\x14-\xcb");
    vehicle_code::vehicle_killriders();
    wait 0.25;
  }

  self notify("\xdc\xc6N\xb4\xc1G\xaflN\x85\xcdC_g\x954Kl6e");
  self vehphys_crash();
}

function vehicle_rider_death_detection(vehicle) {
  assert(!vehicle function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(isDefined(self.vehicle_position) && self.vehicle_position != 0) {
    return;
  }

  self.health = 1;
  vehicle endon("\x1e\xfd\xd1\xa2\a");
  self.baseaccuracy = 0.15;
  self waittill("\x1e\xfd\xd1\xa2\a");
  vehicle notify("\xc0\x92\xbeY\xa2o!\xed\x14-\xcb");
  vehicle vehicle_code::vehicle_killriders();
}

function spawn_vehicle() {
  vehicle = vehicle_spawn(self);
  return vehicle;

  return vehicle_spawn(self);
}

function spawn_vehicles_from_targetname(targetname) {
  vehicles = [];
  spawners = getEntArray(targetname, #targetname);

  foreach(spawner in spawners) {
    if(!isDefined(spawner.code_classname) || spawner.code_classname != "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e") {
      continue;
    }

    if(isspawner(spawner)) {
      vehicle = vehicle_spawn_internal(spawner);
      vehicles = utility::array_add(vehicles, vehicle);
    }
  }

  assert(vehicles.size, "<dev string:x1e1>" + targetname);
  return vehicles;
}

function spawn_vehicle_from_targetname(name) {
  vehiclearray = spawn_vehicles_from_targetname(name);
  assert(vehiclearray.size == 1, "<dev string:x208>" + name + "<dev string:x235>" + vehiclearray.size + "<dev string:x24a>");
  return vehiclearray[0];
}

function spawn_vehicle_from_targetname_and_drive(name) {
  vehiclearray = spawn_vehicles_from_targetname(name);
  assert(vehiclearray.size == 1, "<dev string:x208>" + name + "<dev string:x235>" + vehiclearray.size + "<dev string:x24a>");
  vehicle = vehiclearray[0];

  if(istrue(vehicle.var_724703221109b30d) && isstring(vehicle.target)) {
    vehicle vehicle_paths::function_19c1b82fa20b2bae();
    vehicle vehicle_paths::function_ca5656ce7fb840b1();
    vehicle thread attach_vehicle_and_gopath(getvehiclenode(vehicle.target, #targetname));
  } else {
    thread vehicle_paths::gopath(vehiclearray[0]);
  }

  return vehiclearray[0];
}

function spawn_vehicles_from_targetname_and_drive(name) {
  vehiclearray = spawn_vehicles_from_targetname(name);

  foreach(vehicle in vehiclearray) {
    if(istrue(vehicle.var_724703221109b30d) && isstring(vehicle.target)) {
      vehicle vehicle_paths::function_19c1b82fa20b2bae();
      vehicle vehicle_paths::function_ca5656ce7fb840b1();
      vehicle thread attach_vehicle_and_gopath(getvehiclenode(vehicle.target, #targetname));
      continue;
    }

    thread vehicle_paths::gopath(vehicle);
  }

  return vehiclearray;
}

function function_49ecec455b7b5dd3(params) {
  params.spawndata.initai = 1;
}

#using_animtree("\x1c\x91\b\x15^\x82\x84\xf8");

function function_1a136f80b274c97e(params) {
  params.vehicle useanimtree(#animtree);
}

function function_1c900dff808826b2(params) {
  vehicle = params.vehicle;
  vspawner = params.spawndata;

  if(isDefined(vspawner.target)) {
    vehicle.target = vspawner.target;
  }

  if(isDefined(vspawner.script_noteworthy)) {
    vehicle.script_noteworthy = vspawner.script_noteworthy;
  }

  if(isDefined(vspawner.script_parameters)) {
    vehicle.script_parameters = vspawner.script_parameters;
  }

  if(isDefined(vspawner.script_linkto)) {
    vehicle.script_linkto = vspawner.script_linkto;
  }

  if(isDefined(vspawner.script_godmode)) {
    vehicle.script_godmode = vspawner.script_godmode;
  }

  if(isDefined(vspawner.script_index)) {
    vehicle.script_index = vspawner.script_index;
  }

  if(isDefined(vspawner.script_friendname)) {
    vehicle.script_friendname = vspawner.script_friendname;
  }

  if(isDefined(vspawner.script_dontunloadonend)) {
    vehicle.script_dontunloadonend = vspawner.script_dontunloadonend;
  }

  if(isDefined(vspawner.script_deathflag)) {
    vehicle.script_deathflag = vspawner.script_deathflag;
  }

  if(isDefined(vspawner.script_team)) {
    vehicle.script_team = vspawner.script_team;
  }

  if(isDefined(vspawner.script_delete)) {
    vehicle.script_delete = vspawner.script_delete;
  }

  if(isDefined(vspawner.script_vehicle_selfremove)) {
    vehicle.script_vehicle_selfremove = vspawner.script_vehicle_selfremove;
  }

  if(isDefined(vspawner.script_vehicle_lights_on)) {
    vehicle.script_vehicle_lights_on = vspawner.script_vehicle_lights_on;
  }

  vehicle vehicle_code::spawn_riders();

  if(isDefined(vspawner.target)) {
    node = getvehiclenode(vspawner.target, #targetname);

    if(isDefined(node)) {
      vehicle vehicle_paths::function_19c1b82fa20b2bae();
      vehicle vehicle_paths::function_ca5656ce7fb840b1();
      vehicle attach_vehicle_and_gopath(node);
    }
  }
}

function function_6c26f15bdd57734e(params) {
  self.veh = params.vehicle;
}

function function_5aeae29d5e86a6ce(params) {
  if(isDefined(self)) {
    self.veh = undefined;
  }
}

function vehicle_spawn_internal(vspawner) {
  if(isDefined(vspawner.script_delay_spawn)) {
    vspawner endon("\x1e\xfd\xd1\xa2\a");
    wait vspawner.script_delay_spawn;
  }

  assert(!isDefined(vspawner.vehicle_spawned_thisframe), "<dev string:x265>");
  nonentspawner = 0;
  targetname = vspawner.targetname ?? "";
  model = vspawner vehicle_code::function_5ceb396224add9b3();

  if(isDefined(vspawner.var_d22ac03c16b6e075)) {
    array = strtok(vspawner.var_d22ac03c16b6e075, "\x16");
    color = array[randomintrange(0, array.size)];

    if(color != "z\xd4mN") {
      model = color + "W\xd3" + model;
    }
  }

  vehicletype = vspawner.vehicletype;

  if(getdvarint(@ "hash_a56728daa842e5e") && isDefined(level.vehicle.templates.iw9physics[vspawner.classname])) {
    vehicletype = level.vehicle.templates.iw9physics[vspawner.classname];
  }

  vehicle = spawnVehicle(model, targetname, vehicletype, vspawner.origin, vspawner.angles);
  vehicle utility::ent_flag_wait_or_timeout("\xa5\xe5(\x86%\xf7\r\xaf\xbd\x1b\xb9\xde\xd1^\xff\xed\xae\x8e\x15F0d\x01)\f\xb9\x1d\b\x8d", 1);
  assert(isDefined(vehicle));
  vehicle.classname_mp = vspawner.classname;

  if(isDefined(vspawner.spawnflags) && vspawner.spawnflags & 16) {
    vehicle.isstationary = 1;
  }

  if(isDefined(vspawner.spawnflags) && vspawner.spawnflags & 4) {
    husk = vehicle function_2a7668c3238ff719(1);
    return husk;
  }

  if(isDefined(vspawner.spawnflags)) {
    if(vspawner.spawnflags & 1) {
      vehicle thread utility::script_func("\x17\xbdxO\xb7D\xae\x8e\xa5?\x98}N\xea");
    } else {
      vehicle_interact::allow_use(vehicle, 0);
    }

    if(vspawner.spawnflags & 8 || istrue(vehicle.isstationary)) {
      vehicle vehphys_parkingbrake(1);
    }
  }

  if(isDefined(vspawner.target)) {
    vehicle.target = vspawner.target;
  }

  if(isDefined(vspawner.script_noteworthy)) {
    vehicle.script_noteworthy = vspawner.script_noteworthy;
  }

  if(isDefined(vspawner.script_parameters)) {
    vehicle.script_parameters = vspawner.script_parameters;
  }

  if(isDefined(vspawner.script_linkto)) {
    vehicle.script_linkto = vspawner.script_linkto;
  }

  if(isDefined(vspawner.script_godmode)) {
    vehicle.script_godmode = vspawner.script_godmode;
  }

  if(isDefined(vspawner.script_index)) {
    vehicle.script_index = vspawner.script_index;
  }

  if(isDefined(vspawner.script_friendname)) {
    vehicle.script_friendname = vspawner.script_friendname;
  }

  if(isDefined(vspawner.script_dontunloadonend)) {
    vehicle.script_dontunloadonend = vspawner.script_dontunloadonend;
  }

  if(isDefined(vspawner.script_deathflag)) {
    vehicle.script_deathflag = vspawner.script_deathflag;
  }

  if(isDefined(vspawner.script_team)) {
    vehicle.script_team = vspawner.script_team;
  }

  if(isDefined(vspawner.script_delete)) {
    vehicle.script_delete = vspawner.script_delete;
  }

  if(isDefined(vspawner.script_vehicle_selfremove)) {
    vehicle.script_vehicle_selfremove = vspawner.script_vehicle_selfremove;
  }

  if(isDefined(vspawner.script_vehicle_lights_on)) {
    vehicle.script_vehicle_lights_on = vspawner.script_vehicle_lights_on;
  }

  if(isDefined(vspawner.var_a5cdc186166134fa)) {
    vehicle.var_724703221109b30d = vspawner.var_a5cdc186166134fa;
  }

  if(isDefined(vspawner.script_disconnectpaths)) {
    vehicle.script_disconnectpaths = vspawner.script_disconnectpaths;
  }

  if(isDefined(vspawner.script_badplace)) {
    vehicle.script_badplace = vspawner.script_badplace;
  }

  vehicle.var_61f1f15028036b24 = 1;
  assert(isDefined(vehicle));

  if(!isDefined(vspawner.spawned_count)) {
    vspawner.spawned_count = 0;
  }

  vspawner.spawned_count++;
  vspawner.last_spawned_vehicle = vehicle;
  vehicle.vehicle_spawner = vspawner;
  thread vehicle_init(vehicle);
  vspawner notify("\xcb!f\x94\xa0@\xc1", vehicle);
  return vehicle;
}

function vehicle_init(vehicle) {
  assert(!vehicle function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(getDvar(@ "hash_742caa13b3c2e685") == "\x87") {
    return;
  }

  assert(vehicle.classname != "<dev string:x2ae>");
  classname = vehicle vehicle_code::get_vehicle_classname();

  if(isDefined(level.vehicle.templates.hide_part_list[classname])) {
    foreach(part in level.vehicle.templates.hide_part_list[classname]) {
      vehicle hidepart(part);
    }
  }

  vehicletype = getxhashasset(vehicle.vehicletype);

  if(vehicletype == "\f5\xd5\x03\xff" || vehicletype == "\xc1q\xcft\xf9\xe5ua\x02\xc1") {
    vehicle thread vehicle_paths::getonpath();
    return;
  }

  vehicle utility::set_ai_number();
  vehicle vehicle_setstartinghealth();

  vehicle thread vehicle_damagedebuginfo();

  vehicle thread function_b5c20429ad5cb97e("<dev string:x2be>" + vehicle.healthstarting, 0, (0, 1, 0));

  vehicle vehicle_code::vehicle_setteam();

  if(!isDefined(level.vehicleinitthread[vehicletype][classname])) {
    println("<dev string:x2de>" + classname);
    println("<dev string:x2f8>" + getxhashsourcename(vehicletype));
    println("<dev string:x314>" + vehicle.model);
  }

  var_3e9290005207581c = vehicle.script_badplace;
  vehicle thread[[level.vehicleinitthread[vehicletype][classname]]]();

  if(isDefined(var_3e9290005207581c)) {
    vehicle.script_badplace = var_3e9290005207581c;
  }

  vehicle thread vehicle_playexhausteffect();
  vehicle thread vehicle_playengineeffect();

  if(!isDefined(vehicle.script_avoidplayer)) {
    vehicle.script_avoidplayer = 0;
  }

  if(isDefined(level.vehicle.draw_thermal)) {
    if(level.vehicle.draw_thermal) {
      vehicle thermaldrawenable();
    }
  }

  vehicle utility::ent_flag_init("\x9er\x94D?\xa3\x0f\xe2");
  vehicle utility::ent_flag_init("\xa7d\x05\"\x92)");
  vehicle utility::ent_flag_init("EE\v\xcd\x1d\x99");
  vehicle.riders = [];
  vehicle.unloadque = [];
  vehicle.unload_group = "\x91\xca\xcc\v\xab\xd8:";
  vehicle.fastroperig = [];

  if(isDefined(level.vehicle.templates.attachedmodels) && isDefined(level.vehicle.templates.attachedmodels[classname])) {
    rigs = level.vehicle.templates.attachedmodels[classname];
    strings = getarraykeys(rigs);

    foreach(string in strings) {
      vehicle.fastroperig[string] = undefined;
      vehicle.fastroperiganimating[string] = 0;
    }
  }

  if(isDefined(vehicle.script_vehicle_lights_on)) {
    vehicle thread vehicle_lights::lights_on(vehicle.script_vehicle_lights_on);
  }

  if(isDefined(vehicle.script_godmode)) {
    vehicle.godmode = 1;
  }

  vehicle thread vehicle_damagelogic();
  vehicle thread vehicle_aianim::handle_attached_guys();

  if(isDefined(vehicle.script_friendname)) {
    vehicle setvehiclelookattext(vehicle.script_friendname, &"");
  }

  vehicle thread vehicle_handleunloadevent();

  if(isDefined(vehicle.script_dontunloadonend)) {
    vehicle.dontunloadonend = 1;
  }

  vehicle thread vehicle_rumble();
  vehicle thread utility::script_func("\xcd!{\xf5)\x92\x1c\xcd\x0e\x93\xfc\x17O\b");
  vehicle thread idle_animations();
  vehicle thread animate_drive_idle();

  if(isDefined(vehicle.script_deathflag)) {
    vehicle thread utility::script_func("5\xff\xfas\xf2\x824\xd4\xe69\xb8$p\x03\x8d\\\x1c");
  }

  vehicle thread vehicle_code::mainturretinit();
  vehicle thread vehicle_code::mginit();

  if(isDefined(level.vehicle.spawn_callback_thread)) {
    level thread[[level.vehicle.spawn_callback_thread]](vehicle);
  }

  var_bdde832ca449080d = spawnStruct();
  var_bdde832ca449080d.vehicle = vehicle;
  callback::callback("+\xe8l\x83{\xf6\x91\xda\xec-\xe3\xc8\xb0\x1d\xd1\xfd\xe6\xc0WlZ.\x92 ", var_bdde832ca449080d);

  if(isDefined(vehicle.script_team)) {
    vehicle setvehicleteam(vehicle.script_team);
  }

  vehicle vehicle_code::function_cec7a68e007ea227();

  if(!istrue(vehicle.var_724703221109b30d)) {
    vehicle thread vehicle_paths::getonpath();
  }

  if(isDefined(level.ignorewash)) {
    ignore_wash = level.ignorewash;
  } else {
    ignore_wash = 0;
  }

  if(utility::issp() && vehicle vehicle_hasdustkickup() && !ignore_wash) {
    vehicle thread aircraft_wash_thread();
  }

  if(vehicle vehicle_isphysveh()) {
    vehicle.veh_pathtype = "M\x85\xb6VeQ\xc41\xbf\x98\x91";

    if(isDefined(vehicle.script_pathtype)) {
      vehicle.veh_pathtype = vehicle.script_pathtype;
    }
  }

  vehicle thread function_42f59561e03c19b3();
  vehicle thread vehicle_code::function_7c36133ec0eac741();
  vehicle vehicle_code::spawn_riders();
  vehicle thread vehicle_deathlogic();
}

function function_fb0d5b639c8ee7fb() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\x1e\xfd\xd1\xa2\a");
  utility::flag_wait("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97");

  while(true) {
    level.player waittill("\f\xdc\x8e\xc0P\fr'\x15\xa1q");

    if(isDefined(self.driver) && isPlayer(self.driver)) {
      ontime = gettime();
      vehicle_lights_on("\xb5\xfd\xcc*RlO[\x18w\xa2");
      level.player waittill("%\xa3n>\xaf S\xa3\xf0\xdeq\xf0");

      if(gettime() - ontime < 300) {
        wait 0.3;
      }

      vehicle_lights_on("\fh\xfaN\t4D3\xb0");
    }
  }
}

function aircraft_wash_thread(model) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\\\xd6X\xe9\x05\xf6\nh\x1158\x02\x18\a");
  self notify("&\xc3^\x90P\xa5\xcd\x14\x8b\x87\x86\x93\xc72\x18Z\xb9\xf6\xf4\xc4");
  self endon("&\xc3^\x90P\xa5\xcd\x14\x8b\x87\x86\x93\xc72\x18Z\xb9\xf6\xf4\xc4");
  max_height = 2000;

  if(isDefined(level.treadfx_maxheight)) {
    max_height = level.treadfx_maxheight;
  }

  min_fraction = 80 / max_height;
  rate = 0.5;

  if(isairplane()) {
    rate = 0.15;
  }

  trace_ent = self;

  if(isDefined(model)) {
    trace_ent = model;
  }

  trace_count = 3;
  var_b9611feb3f795bf8 = trace::create_default_contents(1);

  for(;;) {
    wait rate;

    if(true) {
      if(isDefined(self.disable_wash) && self.disable_wash) {
        continue;
      }

      if(isDefined(self.treadfx_maxheight)) {
        max_height = self.treadfx_maxheight;
      }

      down_vector = anglestoup(trace_ent.angles) * -1;
      trace = undefined;
      trace_count++;

      if(trace_count > 3) {
        trace_count = 3;
        trace = trace::ray_trace(trace_ent.origin, trace_ent.origin + down_vector * max_height, trace_ent, var_b9611feb3f795bf8, 1);
      }

      if(trace["\xda\x16\x81\aw}^i"] == 1 || trace["\xda\x16\x81\aw}^i"] < min_fraction) {
        continue;
      }

      dist = distance(trace_ent.origin, trace["\xc1\xbd\xdci\xe8i{7"]);
      treadfx = get_wash_fx(self, trace, down_vector, dist);

      if(!isDefined(treadfx)) {
        continue;
      }

      rate = (dist - 350) / (max_height - 350) * 0.1 + 0.05;
      rate = max(rate, 0.05);

      if(!isDefined(trace)) {
        continue;
      }

      if(!isDefined(trace["\xc1\xbd\xdci\xe8i{7"])) {
        continue;
      }

      fx_origin = trace["\xc1\xbd\xdci\xe8i{7"];
      fx_normal = trace["+0a<s,"];
      dist = vectordot(fx_origin - trace_ent.origin, fx_normal);
      pos = trace_ent.origin + (0, 0, dist);
      forward = fx_origin - pos;

      if(isDefined(self.treadfx_orient_to_player)) {
        forward = fx_origin - level.player.origin;
      }

      if(vectordot(trace["+0a<s,"], (0, 0, 1)) == -1) {
        continue;
      }

      if(length(forward) < 1) {
        forward = trace_ent.angles + (0, 180, 0);
      }

      playFX(treadfx, fx_origin, fx_normal, forward);
    }
  }
}

function get_wash_fx(vehicle, trace, down_vector, dist) {
  surface = trace["I\xf8\x17\x03\x90\x81\xd3\xf0]e\x11"];
  bank = undefined;
  dot = vectordot((0, 0, -1), down_vector);

  if(dot >= 0.97) {
    bank = undefined;
  } else if(dot >= 0.92) {
    bank = "\x1b\xf0[\x01{";
  } else {
    bank = "\xcfa)\x85\r~\xb1.";
  }

  return get_wash_effect(vehicle vehicle_code::get_vehicle_classname(), surface, bank);
}

function get_wash_effect(classname, surface, bank) {
  if(isDefined(bank)) {
    bank_surface = surface + bank;

    if(!isDefined(level.vehicle.templates.surface_effects[classname][bank_surface]) && surface != "\x91\xca\xcc\v\xab\xd8:") {
      return get_wash_effect(classname, "\x91\xca\xcc\v\xab\xd8:", bank);
    } else {
      return level.vehicle.templates.surface_effects[classname][bank_surface];
    }
  }

  return get_vehicle_effect(classname, surface);
}

function get_vehicle_effect(classname, surface) {
  if(!isDefined(level.vehicle.templates.surface_effects[classname][surface]) && surface != "\x91\xca\xcc\v\xab\xd8:") {
    return get_vehicle_effect(classname, "\x91\xca\xcc\v\xab\xd8:");
  } else {
    return level.vehicle.templates.surface_effects[classname][surface];
  }

  return undefined;
}

function function_b5c20429ad5cb97e(text, linenum, color, bone) {
  if(!isDefined(self.damagedebuginfo)) {
    self.damagedebuginfo = spawnStruct();
  }

  if(!isDefined(self.var_dde3f9a00daadc90)) {
    self.var_dde3f9a00daadc90 = 0;
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  queuesize = 12;

  if(!isDefined(linenum)) {
    linenum = 3;

    if(self.var_dde3f9a00daadc90 < queuesize) {
      self.var_dde3f9a00daadc90 += 1;
    }

    for(i = queuesize; i > linenum; i--) {
      self.damagedebuginfo.text[i] = self.damagedebuginfo.text[i - 1];
      self.damagedebuginfo.color[i] = self.damagedebuginfo.color[i - 1];
    }
  }

  self.damagedebuginfo.text[linenum] = text;
  self.damagedebuginfo.color[linenum] = color;
}

function vehicle_damagedebuginfo() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(self.damagedebuginfo)) {
    self.damagedebuginfo = spawnStruct();
    self.damagedebuginfo.text[0] = "";
    self.damagedebuginfo.color[0] = (1, 1, 1);
    self.damagedebuginfo.text[1] = "";
    self.damagedebuginfo.color[1] = (1, 1, 1);
    self.damagedebuginfo.text[2] = "";
    self.damagedebuginfo.color[2] = (1, 1, 1);
  }

  for(;;) {
    if(!getdvarint(@ "hash_cfd8073837710cef")) {} else {
      zoffset = 70;

      for(i = 0; i < self.damagedebuginfo.text.size; i++) {
        if(isDefined(self.damagedebuginfo.text[i])) {
          zoffset -= 3;

          print3d(self.origin + (0, 0, zoffset), self.damagedebuginfo.text[i], self.damagedebuginfo.color[i], 1, 0.2, 1, 1);
        }
      }
    }

    waitframe();
  }
}

function vehicle_hasdustkickup() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!ishelicopter() && !isairplane()) {
    return false;
  }

  return true;
}

function vehicle_handleunloadevent() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\x1e\xfd\xd1\xa2\a");
  type = self.vehicletype;

  if(!utility::ent_flag_exist("\x9er\x94D?\xa3\x0f\xe2")) {
    utility::ent_flag_init("\x9er\x94D?\xa3\x0f\xe2");
  }
}

function vehicle_rumble() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\xe8K\x0e\x1e\x86\xcb\xf6\"\x9f\xaf\xba\x96|8@\xe0\x9c_\xeb");
  classname = vehicle_code::get_vehicle_classname();
  rumblestruct = level.vehicle.templates.rumble[classname];

  if(!isDefined(rumblestruct)) {
    return;
  }

  height = rumblestruct.radius * 2;
  zoffset = -1 * rumblestruct.radius;
  areatrigger = spawn("\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", self.origin + (0, 0, zoffset), 0, rumblestruct.radius, height);
  areatrigger enablelinkTo();
  areatrigger linkTo(self);
  self.rumbletrigger = areatrigger;
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(self.rumbleon)) {
    self.rumbleon = 1;
  }

  if(isDefined(rumblestruct.scale)) {
    self.rumble_scale = rumblestruct.scale;
  } else {
    self.rumble_scale = 0.15;
  }

  if(isDefined(rumblestruct.duration)) {
    self.rumble_duration = rumblestruct.duration;
  } else {
    self.rumble_duration = 4.5;
  }

  if(isDefined(rumblestruct.radius)) {
    self.rumble_radius = rumblestruct.radius;
  } else {
    self.rumble_radius = 600;
  }

  if(isDefined(rumblestruct.basetime)) {
    self.rumble_basetime = rumblestruct.basetime;
  } else {
    self.rumble_basetime = 1;
  }

  if(isDefined(rumblestruct.randomaditionaltime)) {
    self.rumble_randomaditionaltime = rumblestruct.randomaditionaltime;
  } else {
    self.rumble_randomaditionaltime = 1;
  }

  areatrigger.radius = self.rumble_radius;

  while(true) {
    areatrigger waittill("\x91`\xb1\xe7T\x97>");

    if(vehicle_code::vehicle_is_stopped() && !isDefined(self.forcerumble) || !self.rumbleon) {
      wait 0.1;
      continue;
    }

    self playrumblelooponentity(rumblestruct.rumble);

    if(isstring(self.vehicletype)) {
      soundname = self.vehicletype + "\xd79\xea[\x89\xb1+\xf5n\x99x";

      if(soundexists(soundname)) {
        level.player playSound(soundname);
      }
    }

    while(level.player istouching(areatrigger) && self.rumbleon && (!vehicle_code::vehicle_is_stopped() || isDefined(self.forcerumble))) {
      earthquake(self.rumble_scale, self.rumble_duration, self.origin, self.rumble_radius);
      wait self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime);
    }

    self stoprumble(rumblestruct.rumble);
  }
}

function idle_animations() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!isDefined(level.vehicle.templates.idle_anim[self.model])) {
    return;
  }

  self useanimtree(#animtree);

  foreach(animation in level.vehicle.templates.idle_anim[self.model]) {
    self setanim(animation);
  }
}

function animate_drive_idle() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!utility::issp()) {
    return;
  }

  self endon("_\xb3\x9f\xacU\x1f`\xf3o\x18\x0e\x1e\"\x9f~\x14zHn");

  if(!isDefined(self.vehiclewheeldirection)) {
    self.vehiclewheeldirection = 1;
  }

  model = vehicle_code::function_5ceb396224add9b3();
  curanimrate = -1;
  newanimtime = undefined;

  if(!isDefined(level.vehicle.templates.driveidle[model])) {
    return;
  }

  self useanimtree(#animtree);

  if(!isDefined(level.vehicle.templates.driveidle_r[model])) {
    level.vehicle.templates.driveidle_r[model] = level.vehicle.templates.driveidle[model];
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  normalspeed = level.vehicle.templates.driveidle_normal_speed[model];
  animrate = 1;

  if(isDefined(level.vehicle.templates.driveidle_animrate) && isDefined(level.vehicle.templates.driveidle_animrate[model])) {
    animrate = level.vehicle.templates.driveidle_animrate[model];
  }

  lastdir = self.vehiclewheeldirection;
  animation = level.vehicle.templates.driveidle[model];

  while(true) {
    if(!normalspeed) {
      if(isDefined(self.suspend_driveanims)) {
        wait 0.05;
        continue;
      }

      self setanim(level.vehicle.templates.driveidle[model], 1, 0.2, animrate);
      return;
    }

    speed = self vehicle_getspeed();

    if(lastdir != self.vehiclewheeldirection) {
      dif = 0;

      if(self.vehiclewheeldirection) {
        animation = level.vehicle.templates.driveidle[model];
        dif = 1 - get_normal_anim_time(level.vehicle.templates.driveidle_r[model]);
        self clearanim(level.vehicle.templates.driveidle_r[model], 0);
      } else {
        animation = level.vehicle.templates.driveidle_r[model];
        dif = 1 - get_normal_anim_time(level.vehicle.templates.driveidle[model]);
        self clearanim(level.vehicle.templates.driveidle[model], 0);
      }

      newanimtime = 0.01;

      if(newanimtime >= 1 || newanimtime == 0) {
        newanimtime = 0.01;
      }

      lastdir = self.vehiclewheeldirection;
    }

    newanimrate = speed / normalspeed;

    if(newanimrate != curanimrate) {
      self setanim(animation, 1, 0.05, newanimrate);
      curanimrate = newanimrate;
    }

    if(isDefined(newanimtime)) {
      self setanimtime(animation, newanimtime);
      newanimtime = undefined;
    }

    wait 0.05;
  }
}

function get_normal_anim_time(animation) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  animtime = self getanimtime(animation);
  animlength = getanimlength(animation);

  if(animtime == 0) {
    return 0;
  }

  return self getanimtime(animation) / getanimlength(animation);
}

function vehicle_playexhausteffect() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(level.vehicle.templates.exhaust_fx[self.model])) {
    return;
  }

  while(true) {
    playFXOnTag(level.vehicle.templates.exhaust_fx[self.model], self, "R<\xee1\"h\x14\xe7\xd7\xb3o\x82H?LB*m");
    waitframe();
  }
}

function vehicle_playengineeffect() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  enginefx = level.vehicle.templates.engine_fx[vehicle_code::get_vehicle_classname()];

  if(!isDefined(enginefx)) {
    return;
  }

  effectdelay = 0.25;
  prev_effect = undefined;
  var_47fb807fba597925 = undefined;

  while(true) {
    if(!vehicle_code::vehicle_isalive(self)) {
      return;
    }

    var_c6a747ce87fee8ca = enginefx.effect;
    var_47fb807fba597925 = enginefx.effect_tag;
    effort_ratio = self vehicle_getspeed() / self vehicle_gettopspeedforward();

    if(isDefined(self.enginefx_effort_scale)) {
      effort_ratio *= self.enginefx_effort_scale;
    }

    if(isDefined(enginefx.max_effort_effect) && effort_ratio >= enginefx.max_effort_ratio) {
      var_c6a747ce87fee8ca = enginefx.max_effort_effect;
    } else if(isDefined(enginefx.med_effort_effect) && effort_ratio >= enginefx.med_effort_ratio) {
      var_c6a747ce87fee8ca = enginefx.med_effort_effect;
    } else if(isDefined(enginefx.min_effort_effect) && effort_ratio >= enginefx.min_effort_ratio) {
      var_c6a747ce87fee8ca = enginefx.min_effort_effect;
    }

    if(!isDefined(prev_effect) || prev_effect != var_c6a747ce87fee8ca) {
      if(isDefined(prev_effect)) {
        stopFXOnTag(prev_effect, self, var_47fb807fba597925);
        waitframe();

        if(!vehicle_code::vehicle_isalive(self)) {
          return;
        }
      }

      playFXOnTag(var_c6a747ce87fee8ca, self, var_47fb807fba597925);
      prev_effect = var_c6a747ce87fee8ca;
    }

    wait effectdelay;
  }
}

function vehicle_setstartinghealth() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x363>" + "<dev string:x376>");
  classname = vehicle_code::get_vehicle_classname();
  assert(isDefined(level.vehicle.templates.life[classname]), "<dev string:x382>" + classname);

  if(isDefined(self.script_startinghealth)) {
    self.health = self.script_startinghealth;
  } else {
    if(level.vehicle.templates.life[classname] == -1) {
      return;
    }

    if(isDefined(level.vehicle.templates.life_range_low[classname]) && isDefined(level.vehicle.templates.life_range_high[classname]) && level.vehicle.templates.life_range_high[classname] > level.vehicle.templates.life_range_low[classname]) {
      self.health = randomint(level.vehicle.templates.life_range_high[classname] - level.vehicle.templates.life_range_low[classname]) + level.vehicle.templates.life_range_low[classname];
    } else {
      self.health = level.vehicle.templates.life[classname];
    }
  }

  self.explosivehits = 0;
  self.maxhealth = self.health;
  self.healthactual = self.health;
  self.healthstarting = self.health;
  self.damagestate = "\xa2\x0e\x03\x18\xd1\xd3\x9c\xcb\xa9\x8a\xbd\r\x96\x03";
  self.var_eb23aee521b9553c = 1;
  self.ui_warning = 0;
  function_c8cc945bbe92494f();
}

function function_c8cc945bbe92494f() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x3d5>" + "<dev string:x376>");

  if(isDefined(self.damageableparts)) {
    return;
  }

  self.damageableparts = [];

  for(i = 0; i < getnumparts(self.model); i++) {
    partname = getpartname(self.model, i);
    partname = function_153c0158e8422bd5(partname);

    if(utility::array_contains_key(level.vehicle.damageableparts, partname)) {
      self.damageableparts[partname] = level.vehicle.damageableparts[partname];
    }
  }
}

function function_a703370b8c7b925a(alloweddist, damagelocation, returnarray, notires) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  function_c8cc945bbe92494f();

  if(self.damageableparts.size == 0) {
    if(istrue(returnarray)) {
      return [];
    } else {
      return;
    }
  }

  parts = function_6b94a59c48bca71d(self.damageableparts, damagelocation);
  partstemp = [];

  foreach(part in parts) {
    if(!vehicle_damage::function_5cef7c29a68bb143(self.damageableparts[part])) {
      if(!istrue(notires) || !iswheelbone(part)) {
        partstemp[partstemp.size] = part;
      }
    }
  }

  parts = partstemp;
  firstpart = utility::function_b691d50c7cd79a9(parts);
  firstpart = function_1260d6aa2ba119b8(firstpart);

  if(istrue(returnarray)) {
    return parts;
  }

  if(isDefined(firstpart) && distancesquared(damagelocation, self gettagorigin(firstpart)) <= squared(alloweddist)) {
    return firstpart;
  }

  if(istrue(returnarray)) {
    return [];
  }

  return;
}

function function_1260d6aa2ba119b8(part) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!isDefined(part)) {
    return undefined;
  }

  if(part == "\x8eX\x9d\xfa&ump\x95N}\x99\xe4\xdbn\xd1\xbe\x91X\xdaX\xce\xcaF" || part == "t\x16;\xaf\x89\xba[\xe0\x959\xf5\xc4\xb0\xc6m\xd7#Xk\x16\xd9e\x8c") {
    undamagedbumper = getsubstr(part, 0, part.size - 8);

    if(utility::function_498b347f61e9af18(undamagedbumper, "\x1e\xfd\xd1\xa2\a")) {
      return part;
    }

    return undamagedbumper;
  }
}

function function_6b94a59c48bca71d(array, damagelocation) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  assert(isDefined(array), "<dev string:x3f7>");
  self.partdamagelocation = damagelocation;
  keys = getarraykeys(array);
  keys = utility::array_sort_with_func(keys, &part_distance);
  return keys;
}

function part_distance(parta, partb) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  return distancesquared(self gettagorigin(parta), self.partdamagelocation) < distancesquared(self gettagorigin(partb), self.partdamagelocation);
}

function function_42f59561e03c19b3() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x40d>" + "<dev string:x376>");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x83\xcb\xd4\xd6\xb7mZj-.\xd1\x0e\x95\xb8\xbd\xc6B\xd3\xfeh\xc4O");
  self vehphys_enablecollisioncallback(1);

  while(true) {
    self.collisioninfo = undefined;
    classname = vehicle_code::get_vehicle_classname();
    self waittill("l\xdb\xb1c\x96sio\xb9", body0, body1, flag0, flag1, position, normal, impulse, ent, collzone);

    if(istrue(self.var_7156cdd876bf47d5)) {
      return;
    }

    self.collisioninfo["\xdb\xe2\xd5@\xd4\xae\v"] = impulse;

    if(getdvarint(@ "hash_cfd8073837710cef")) {
      utility::draw_angles(vectortoangles(normal), position, (0, 1, 0), 1000, 10);
      line(position, position + anglesToForward(vectortoangles(normal)) * -32, (1, 0, 0), 1, 0, 1000);
      line(position, self.origin, (0, 1, 1), 1, 0, 1000);
      print3d(self.origin + (0, 0, 3), classname, (0, 1, 1), 1, 0.2, 1000, 1);
      print3d(self.origin, "<dev string:x433>" + impulse, (0, 1, 1), 1, 0.2, 1000, 0);
      print3d(self.origin + (0, 0, -3), "<dev string:x440>" + collzone, (0, 1, 1), 1, 0.2, 1000, 0);

      if(isDefined(ent)) {
        print3d(self.origin + (0, 0, -6), "<dev string:x44e>" + vectordot(anglesToForward(self.angles), anglesToForward(ent.angles)), (0, 1, 1), 1, 0.2, 1000, 0);
      }
    }

    if(isDefined(ent) && ent.code_classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e" && isDefined(ent.collisioninfo) && isDefined(ent.collisioninfo["\xdb\xe2\xd5@\xd4\xae\v"]) && ent.collisioninfo["\xdb\xe2\xd5@\xd4\xae\v"] > impulse) {
      impulse = ent.collisioninfo["\xdb\xe2\xd5@\xd4\xae\v"];
      self.collisioninfo["\xdb\xe2\xd5@\xd4\xae\v"] = ent.collisioninfo["\xdb\xe2\xd5@\xd4\xae\v"];
    }

    if(!function_e22e06c4d80a249f() && impulse >= 0.15) {
      damage = impulse * 400;
      damagescaled = function_dcb5c359188c8884(damage);
      closestparttodamage = function_a703370b8c7b925a(64, position, 0, 1);

      if(isDefined(closestparttodamage)) {
        if(getdvarint(@ "hash_cfd8073837710cef")) {
          classname = vehicle_code::get_vehicle_classname();
          classname = getsubstr(classname, 19, classname.size);

          print3d(self gettagorigin(closestparttodamage), classname + "<dev string:x457>" + closestparttodamage + "<dev string:x45f>" + damagescaled, (1, 0, 0), 1, 0.2, 1000, 0);

          line(position, self gettagorigin(closestparttodamage), (1, 0, 0), 1, 0, 1000);
        }

        if(impulse > 0.8) {
          function_74001d2ba3442c();
          partstodamage = function_a703370b8c7b925a(1000, position, 1, 1);

          for(i = 0; i < partstodamage.size; i++) {
            if(i == 5) {
              break;
            }

            thread function_4ccfccffa8dadbac(partstodamage[i], 0, "\x9fa91\xb9\xa7\xd3y\xfeITy\x86", undefined, level.player, 1, position, 1);
          }
        } else {
          thread function_4ccfccffa8dadbac(closestparttodamage, 0, "M\x81\xaf\xee\xc9\xcfD\xef\x91J", undefined, level.player, 1, position, 1);
        }
      }

      if(!function_13f261a563b91b58() && !isvehiclehusk() && !ent isvehiclehusk()) {
        var_52cfecb96f62c976 = function_c25bcb6b3db7d70b(ent, position, impulse, collzone);

        if(var_52cfecb96f62c976 == 1) {
          vehicle_headondeath(ent);
        } else if(var_52cfecb96f62c976 != 2) {
          vehicle_damage(damagescaled, undefined, "M\x81\xaf\xee\xc9\xcfD\xef\x91J");
        }
      }
    }

    if(isvehiclehusk() && isDefined(ent)) {
      if(!isDefined(self.vehiclecollisions)) {
        self.vehiclecollisions = 0;
      }

      if(ent.code_classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e") {
        self.vehiclecollisions += 1;
      }

      if(self.vehiclecollisions >= 5) {
        ents = self getlinkedchildren();
        ents = utility::array_add(ents, self);
        utility::array_delete(ents);
      }
    }

    wait 1;
  }
}

function private function_dcb5c359188c8884(amount) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  scaledamount = amount;

  if(istrue(level.var_6e5b14e1aaa606df)) {
    scaledamount = amount * level.var_6e5b14e1aaa606df;
  }

  if(istrue(self.var_6e5b14e1aaa606df)) {
    scaledamount = amount * self.var_6e5b14e1aaa606df;
  }

  return scaledamount;
}

function vehicle_headondeath(ent) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(getdvarint(@ "hash_cfd8073837710cef")) {
    classname = vehicle_code::get_vehicle_classname();

    print3d(self.origin + (0, 0, 60), classname + "<dev string:x467>", (1, 0, 0), 1, 1, 1000, 1);
  }

  self.headondeath = 1;
  self notify("\x11\xd3)\x87/t\xcf\xfc\xb0\x0f!;\x8f(\xc1\xd9\xd0\xde-");
  vehicle_kill(ent);
}

function function_c25bcb6b3db7d70b(ent, position, impulse, collzone) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(ishelicopter() || ent ishelicopter()) {
    return 0;
  }

  if(vehicle_isboat() || ent vehicle_isboat()) {
    return 0;
  }

  if(getdvarint(@ "hash_7598045ee90e851d") == 1 && impulse > 0.4 && isDefined(self.classname_mp) && isDefined(ent.classname_mp) && isDefined(ent) && ent.code_classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e" && ent function_e9c62ae0d75550eb(position) && function_e9c62ae0d75550eb(position) && vectordot(anglesToForward(self.angles), anglesToForward(ent.angles)) < -0.9 && collzone == 0) {
    if(!(isDefined(level.vehicle.templates.explosivehits[self.classname_mp]) && isDefined(level.vehicle.templates.explosivehits[ent.classname_mp]))) {
      return 1;
    }

    if(level.vehicle.templates.explosivehits[self.classname_mp] < level.vehicle.templates.explosivehits[ent.classname_mp]) {
      return 1;
    }

    if(level.vehicle.templates.explosivehits[self.classname_mp] == level.vehicle.templates.explosivehits[ent.classname_mp]) {
      if(!isDefined(self.driver) || !isPlayer(self.driver)) {
        return 1;
      }
    }

    if(function_7af76a23651821d3() < self.healthstarting * 0.5) {
      return 1;
    }

    vehicle_damage(self.healthstarting * 0.5, undefined, "M\x81\xaf\xee\xc9\xcfD\xef\x91J");
    return 2;
  }

  return 0;
}

function vehicle_isboat() {
  if(!isDefined(self.vehicletype)) {
    return false;
  }

  return isDefined(level.vehicle.templates.boat_list[getxhashasset(self.vehicletype)]);
}

function function_e9c62ae0d75550eb(point) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  dot = 0;
  tag = "j'I\x9d\xc3\f\x8fUQ\xff\n\x0f\xbd\xaa\xa3\xae\xb4\v\r\xed_\v}\x88J\xca\r";

  if(!self tagexists("j'I\x9d\xc3\f\x8fUQ\xff\n\x0f\xbd\xaa\xa3\xae\xb4\v\r\xed_\v}\x88J\xca\r")) {
    print("<dev string:x479>");
    tag = "\xec\xbfK|\au\xcd\xc2\x19<";
  }

  to_point = point - self gettagorigin(tag);
  forward = anglesToForward(self.angles);
  dot = vectordot(to_point, forward);
  return dot > 0;
}

function vehicle_damage(amount, inflictor, mod) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x4b9>" + "<dev string:x376>");

  if(istrue(self.godmode) || istrue(self.demigodmode)) {
    print("<dev string:x4c7>");
    return;
  }

  if(!isDefined(mod)) {
    mod = undefined;
  }

  self dodamage(amount, self.origin, inflictor, undefined, mod);
  function_47928040a45736e4();
}

function vehicle_kill(inflictor) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x4fd>" + "<dev string:x376>");

  if(istrue(self.godmode) || istrue(self.demigodmode)) {
    print("<dev string:x50f>");
    return;
  }

  damage = self.healthstarting * 2;
  self dodamage(damage, self.origin, inflictor, undefined, "\x9fa91\xb9\xa7\xd3y\xfeITy\x86");

  if(isDefined(level.player.veh) && self == level.player.veh) {
    setomnvar("%\a}\xf2O\xba\xd5- !\x97\x1f\a\x7f\xf3=*?pc_", 0);
  }
}

function function_2ba0b2f77db6ce25() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(isDefined(function_2d41e79bce5eb2ea())) {
    setomnvar("x\xbe1\x04e\xdbp\xa3\xc9i\xad\xb1\x12#", function_2d41e79bce5eb2ea());
    return;
  }

  setomnvar("x\xbe1\x04e\xdbp\xa3\xc9i\xad\xb1\x12#", 2);
}

function function_9910ceb723e45c93() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  level.player callback::callback(#"hash_a698d2f22002248c");
  level.player setclientomnvar("x\xbe1\x04e\xdbp\xa3\xc9i\xad\xb1\x12#", -1);
}

function function_47928040a45736e4() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(isDefined(level.player.veh) && self == level.player.veh || isDefined(level.player.leanout_vehicle) && self == level.player.leanout_vehicle) {
    healthpercentage = function_5aab6b7d94318613();

    if(healthpercentage < 0) {
      setomnvar("%\a}\xf2O\xba\xd5- !\x97\x1f\a\x7f\xf3=*?pc_", int(0));
    } else {
      setomnvar("%\a}\xf2O\xba\xd5- !\x97\x1f\a\x7f\xf3=*?pc_", int(healthpercentage * 100));
    }

    if(isDefined(self.var_61b1d066dfc993fb)) {
      level.player setclientomnvar("\xb4\xf4\xe2?sM\x8c\x0f\x8dcL\xbd\xb3O\xe8\xb1?/Mz0", self.var_61b1d066dfc993fb);
    } else {
      level.player setclientomnvar("\xb4\xf4\xe2?sM\x8c\x0f\x8dcL\xbd\xb3O\xe8\xb1?/Mz0", 0);
    }

    if(isDefined(self.ui_warning)) {
      level.player setclientomnvarbit("\x03p\xa1.\x02{\xf7\x9f\xbf\xd5\x10\x8a~8", 1, self.ui_warning);
      return;
    }

    level.player setclientomnvarbit("\x03p\xa1.\x02{\xf7\x9f\xbf\xd5\x10\x8a~8", 1, 0);
  }
}

function function_7af76a23651821d3() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x544>" + "<dev string:x376>");
  return self.healthactual - self.healthbuffer;
}

function vehicle_sethealth(amount, resetstarting) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x553>" + "<dev string:x376>");

  if(!isDefined(self.healthbuffer)) {
    self.healthbuffer = 0;
  }

  amount = int(amount + self.healthbuffer);
  self.health = amount;
  self.healthactual = amount;

  if(istrue(resetstarting)) {
    self.healthstarting = amount - self.healthbuffer;
  }
}

function vehicle_damagelogic() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.damage_functions = [];
  classname = vehicle_code::get_vehicle_classname();

  if(isDefined(level.vehicle.templates.bullet_shield[classname]) && !isDefined(self.script_bulletshield)) {
    self.script_bulletshield = level.vehicle.templates.bullet_shield[classname];
  }

  if(isDefined(level.vehicle.templates.grenade_shield[classname]) && !isDefined(self.script_grenadeshield)) {
    self.script_grenadeshield = level.vehicle.templates.grenade_shield[classname];
  }

  if(isDefined(level.vehicle.templates.collision_shield[classname]) && !isDefined(self.var_7156cdd876bf47d5)) {
    self.var_7156cdd876bf47d5 = level.vehicle.templates.collision_shield[classname];
  }

  self.healthbuffer = 100000;
  self.health += self.healthbuffer;
  self.healthactual = self.health;
  damagestateupdatefunc = undefined;

  if(utility::issharedfuncdefined(#"vehicle", #"updatedamagestate")) {
    damagestateupdatefunc = utility::getsharedfunc(#"vehicle", #"updatedamagestate");
  }

  while(self.health > 0) {
    self.damageinfo = undefined;
    self waittill("\fU`\xc0y\x95", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time);
    partname = function_153c0158e8422bd5(partname);
    attachtagname = function_153c0158e8422bd5(attachtagname);

    if(!utility::flag("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97")) {
      utility::flag_wait("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97");
    }

    utility::flag_wait("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97");
    damagedpartname = attachtagname != "" ? attachtagname : partname;
    amount = function_28cf8e66a94f0940(amount, meansofdeath, time);
    amount = function_71340cd727b70175(amount, objweapon);

    if(!isDefined(meansofdeath) || !isexplosivedamage(meansofdeath, objweapon)) {
      amount = function_7d6801c56962c0b(amount);
    }

    self.damageinfo["\xf2yqmf\x14"] = amount;
    self.damageinfo["Z\xb4\x87\xac '\am"] = attacker;
    self.damageinfo["L=\xb0g_u\x83$\x95\xd2\x10\x1d\b"] = direction_vec;
    self.damageinfo["/\xd0\x9a\x817\x9e,\aY\x0f\r\xc5\xc5\xd8"] = damagelocation;
    self.damageinfo["\x13\x01\xf9"] = meansofdeath;
    self.damageinfo["\xe5\x06\xb0\bE\x16"] = objweapon;

    if(istrue(self.custom_damage_handler)) {
      return;
    }

    foreach(func in self.damage_functions) {
      thread[[func]](amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon);
    }

    if(isDefined(attacker)) {
      attacker utility::script_func("\xbd\xfd)3\x9d\xac\x1da\xc9\xee\xb1\t\xe2\xcb\x8c{\xac");

      if(utility::func_ref_exist("\xd9V\r\xd2\x8d\xc6\xac\xebd,\xd6\xb0\x9d+\xaf\xda\xf6FZ\xcc-\xca9")) {
        data = undefined;

        if(isDefined(level.fn_damage_pack)) {
          data = [[level.fn_damage_pack]](attacker, self, amount, objweapon, meansofdeath, undefined, damagelocation, direction_vec, modelname, partname, attachtagname, dflags);
        }

        if(isDefined(data)) {
          self.damage_data = data;
        } else {
          self.damage_data = undefined;
        }

        new_amount = utility::script_func("\xd9V\r\xd2\x8d\xc6\xac\xebd,\xd6\xb0\x9d+\xaf\xda\xf6FZ\xcc-\xca9", data);

        if(isDefined(new_amount)) {
          amount = new_amount;
        }
      }
    }

    if(function_e22e06c4d80a249f()) {
      thread function_b5c20429ad5cb97e("<dev string:x571>", 1, (0, 1, 0));

      self.health = self.healthactual;
    } else if(function_c5f1f555a46d1757(attacker)) {
      thread function_b5c20429ad5cb97e("<dev string:x579>" + self.script_team + "<dev string:x591>" + time, 1, (0, 1, 0));

      self.health = self.healthactual;
    } else if(function_3da181bf831071d0(attacker, meansofdeath, objweapon)) {
      thread function_b5c20429ad5cb97e("<dev string:x598>" + "<dev string:x591>" + time, 1, (0, 1, 0));

      self.health = self.healthactual;
    } else if(function_ebdbc7037cf61b26(meansofdeath, objweapon)) {
      thread function_b5c20429ad5cb97e("<dev string:x5ad>" + "<dev string:x591>" + time, 1, (0, 1, 0));

      self.health = self.healthactual;
    } else {
      if(function_95129c303d937cd4(meansofdeath)) {
        thread function_b5c20429ad5cb97e("<dev string:x5c4>" + "<dev string:x591>" + time, 1, (0, 1, 0));

        self.health = self.healthactual;
      }

      if(isDefined(self.var_35eb19d2089de17a)) {
        part_hit = self[[self.var_35eb19d2089de17a]](damagedpartname, meansofdeath, damagelocation);

        if(isDefined(part_hit)) {
          if(isDefined(self.var_90af29f1cb37cfc2)) {
            self thread[[self.var_90af29f1cb37cfc2]](attacker, amount, part_hit, direction_vec, damagelocation);
          }

          if(isstartstr(part_hit, "\x1e\x80\x10,\xb7yQ\x9a\xe5")) {
            amount = 0;
            self.health = self.healthactual;
          }
        }
      }

      if(utility::issp() && isDefined(meansofdeath)) {
        if(isDefined(objweapon) && function_bfa2035e9fa29a51(getcompleteweaponname(objweapon)) || !function_cdf5a4d14c30e9d8(self.health, amount, direction_vec, damagelocation, meansofdeath, objweapon, attacker, inflictor)) {
          if(meansofdeath == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
            function_56a5352f9d369de3(amount, damagelocation, meansofdeath, objweapon, attacker);
          } else {
            thread function_4ccfccffa8dadbac(damagedpartname, amount, meansofdeath, objweapon, attacker);
          }
        }
      }

      if(function_13f261a563b91b58()) {
        thread function_b5c20429ad5cb97e("<dev string:x5da>", 1, (0, 1, 0));

        self.health = self.healthactual;
      } else {
        self.healthactual = self.health;
        function_47928040a45736e4();
      }

      thread function_b5c20429ad5cb97e("<dev string:x5e5>" + self.damagestate + "<dev string:x5f6>" + self.healthactual, 1, (1, 0, 0));

      thread function_b5c20429ad5cb97e(meansofdeath + "<dev string:x603>" + amount + "<dev string:x60a>" + self.explosivehits + "<dev string:x61e>" + damagedpartname + "<dev string:x625>" + self.healthactual + "<dev string:x591>" + time);
    }

    if(function_e22e06c4d80a249f() || function_13f261a563b91b58()) {
      continue;
    }

    if(amount >= self.healthstarting * 2) {
      self notify("\x1e\xfd\xd1\xa2\a", attacker, meansofdeath, objweapon, damagelocation);
    }

    if(self.damagestate == "\xb0\x8c\x10\xb1O,E\xf3\xfe\xc0\xa9") {
      if(self.health <= self.healthbuffer || function_f679660d961ca6a0()) {
        self notify("\x1e\xfd\xd1\xa2\a", attacker, meansofdeath, objweapon, damagelocation);
      }

      continue;
    }

    if(isDefined(level.vehicle.templates.explosivehits[classname]) && function_f679660d961ca6a0()) {
      self notify("\x1e\xfd\xd1\xa2\a", attacker, meansofdeath, objweapon, damagelocation);
    }

    if(ishelicopter() && function_f679660d961ca6a0()) {
      self notify("\x1e\xfd\xd1\xa2\a", attacker, meansofdeath, objweapon, damagelocation);
    }

    oldstate = self.damagestate;
    healthpercentage = (self.health - self.healthbuffer) / self.healthstarting;

    if(function_f679660d961ca6a0()) {
      self.damagestate = "\xb0\x8c\x10\xb1O,E\xf3\xfe\xc0\xa9";
    } else if(healthpercentage <= 0.3) {
      self.damagestate = "\xb0\x8c\x10\xb1O,E\xf3\xfe\xc0\xa9";
    } else if(healthpercentage <= 0.65) {
      self.damagestate = "Kb\\\x1d\x1d\xb5&\xd5\x95\x86{O";
    } else if(healthpercentage <= 0.9) {
      self.damagestate = "Y1\x8b\xde\b)b\xdb\xc2\x1c\xf3";
    } else {
      self.damagestate = "\xa2\x0e\x03\x18\xd1\xd3\x9c\xcb\xa9\x8a\xbd\r\x96\x03";
    }

    if(isDefined(damagestateupdatefunc)) {
      [[damagestateupdatefunc]](self.damagestate, oldstate);
    }

    thread function_b5c20429ad5cb97e("<dev string:x5e5>" + self.damagestate + "<dev string:x5f6>" + self.healthactual, 1, (1, 0, 0));

    if(self.damagestate == "\xb0\x8c\x10\xb1O,E\xf3\xfe\xc0\xa9") {
      vehicle_sethealth(self.healthstarting * 0.3);
      function_47928040a45736e4();
      self.burndownstart = gettime();
      self notify("{\xa1;!1\xdea\xe6\xb4\fx\x15\xb1i\x1c9n\x1e");
      childthread burndown_timer();
    }
  }
}

function function_bfa2035e9fa29a51(weaponname) {
  if(!isDefined(self.var_c4717464c2b8c07d)) {
    return false;
  }

  if(arraycontains(self.var_c4717464c2b8c07d, weaponname)) {
    return true;
  }

  return false;
}

function isexplosivedamage(mod, objweapon) {
  if(isDefined(objweapon) && isDefined(objweapon.basename)) {
    switch (objweapon.basename) {
      case #"hash_734c65fd451709ec":
      case #"hash_b347bbcd9d4a348d":
        if(getdvarint(@ "hash_cfd8073837710cef")) {
          iprintln("\x13\x97\xb2\xf1\x1c\x95\x9bB\x1d$E\xcb\xe5*\x99\xda\xe3{\xca+e\xcc\xe7\xad\"\xda\xfe\xf0:\vP\xc3\xe7\x9cn\xd5\xb1S" + objweapon.basename);
        }

        return false;
    }
  }

  if(mod == "9\xe6R?Wcx5\xf2F%Q3W\x06z\xfe\a" || mod == "\xa2rl\xdaDn\x17b\xd9I\xc9=N" || mod == "j\xa7\x11\xfa\x14J\xe9\x92\xa8\xd0*I\xc4\x8a\xd75\x05\x89\x05S\x90" || mod == "\x9az\x88\xfat)*\xe4\x14\x11\x15" || mod == "\xd4zD\xebP%\xe9IEC\x15R\x13*" || mod == "\xa2rl\xdaDn\x17b\xd9I\xc9=N") {
    return true;
  }

  return false;
}

function function_f679660d961ca6a0() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  classname = vehicle_code::get_vehicle_classname();
  assert(isDefined(level.vehicle.templates.explosivehits[classname]), "<dev string:x62c>" + classname);

  if(level.vehicle.templates.explosivehits[classname] == 0) {
    if(self.explosivehits > level.vehicle.templates.explosivehits[classname]) {
      return true;
    }
  }

  if(level.vehicle.templates.explosivehits[classname] > 0 && self.explosivehits >= level.vehicle.templates.explosivehits[classname]) {
    return true;
  }

  return false;
}

function burndown_timer() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self.ui_warning = 1;
  function_47928040a45736e4();
  healthinc = int((self.health - self.healthbuffer) / 30 / 0.25) + 1;

  while(gettime() - self.burndownstart < 30000) {
    countdown = 30000 - gettime() - self.burndownstart;

    thread function_b5c20429ad5cb97e("<dev string:x650>" + countdown, 2, (1, 0, 1));

    vehicle_damage(healthinc, undefined, "\x9fa91\xb9\xa7\xd3y\xfeITy\x86");
    wait 1;
  }
}

function private function_28cf8e66a94f0940(amount, meansofdeath, time) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  thread function_b5c20429ad5cb97e("<dev string:x65e>" + time + "<dev string:x674>" + self.healthstarting + "<dev string:x68a>", 0, (1, 0, 0.5));

  isbullet = undefined;

  if(isDefined(meansofdeath) && isendstr(meansofdeath, "\xa7$\x87\xd4D8^")) {
    isbullet = 1;
  } else {
    return amount;
  }

  scaledamount = undefined;

  if(istrue(level.var_54e549f1fb7f6695)) {
    scaledamount = amount * level.var_54e549f1fb7f6695;

    thread function_b5c20429ad5cb97e("<dev string:x65e>" + time + "<dev string:x674>" + self.healthstarting + "<dev string:x69e>" + level.var_54e549f1fb7f6695, 0, (1, 0, 0.5));
  }

  if(istrue(self.var_54e549f1fb7f6695)) {
    scaledamount = amount * self.var_54e549f1fb7f6695;

    thread function_b5c20429ad5cb97e("<dev string:x65e>" + time + "<dev string:x674>" + self.healthstarting + "<dev string:x6b8>" + self.var_54e549f1fb7f6695, 0, (1, 0, 0.5));
  }

  if(isDefined(scaledamount)) {
    addhealth(amount - scaledamount);
    amount = scaledamount;
  }

  return amount;
}

function private function_71340cd727b70175(amount, objweapon) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  scaledamount = undefined;

  if(utility_sp::isthrowingknife(objweapon)) {
    scaledamount = amount * 0.05;
  }

  if(isDefined(scaledamount)) {
    addhealth(amount - scaledamount);
    amount = scaledamount;
  }

  return amount;
}

function private function_7d6801c56962c0b(amount) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(self.damagestate == "\xb0\x8c\x10\xb1O,E\xf3\xfe\xc0\xa9") {
    addhealth(amount * 0.75);
    return (amount * 0.25);
  }

  return amount;
}

function function_c5f1f555a46d1757(attacker) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  return !isDefined(attacker) && self.script_team != "\xba\xa5\x1f\xc9m\x80i" || attacker_isonmyteam(attacker) || attacker_troop_isonmyteam(attacker) || is_invulnerable_from_ai(attacker);
}

function attacker_troop_isonmyteam(attacker) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x6d1>" + "<dev string:x376>");

  if(getdvarint(@ "hash_fb816855f6554343")) {
    return 0;
  }

  if(isDefined(self.script_team) && self.script_team == "O\x15\x1b\xad\x9ff" && isDefined(attacker) && isPlayer(attacker)) {
    return 1;
  }

  if(isai(attacker) && attacker.team == self.script_team) {
    return 1;
  }

  return 0;
}

function attacker_isonmyteam(attacker) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x6d1>" + "<dev string:x376>");

  if(getdvarint(@ "hash_fb816855f6554343")) {
    return false;
  }

  if(isDefined(attacker) && isDefined(attacker.script_team) && isDefined(self.script_team) && attacker.script_team == self.script_team) {
    return true;
  }

  return false;
}

function is_invulnerable_from_ai(attacker) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!isDefined(self.script_ai_invulnerable)) {
    return 0;
  }

  if(isDefined(attacker) && isai(attacker) && self.script_ai_invulnerable == 1) {
    return 1;
  }

  return 0;
}

function function_95129c303d937cd4(type) {
  return type == "\x13\x1e\xe31{\xb4\xf1\x85\x18";
}

function function_3da181bf831071d0(attacker, type, objweapon) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  return isDefined(level.var_bb525a8c795d4c4d) && [[level.var_bb525a8c795d4c4d]](attacker, type, objweapon);
}

function function_ebdbc7037cf61b26(type, objweapon) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  return bulletshielded(type) || explosive_bulletshielded(type) || grenadeshielded(type, objweapon);
}

function grenadeshielded(type, objweapon) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!isDefined(self.script_grenadeshield)) {
    return 0;
  }

  type = tolower(type);

  if(!isDefined(type) || !issubstr(type, ",\xe1\x93So\x98\r")) {
    return 0;
  }

  if(isDefined(level.vehicle.templates.var_53194e31d40d5ab1[vehicle_code::get_vehicle_classname()])) {
    if(arraycontains(level.vehicle.templates.var_53194e31d40d5ab1[vehicle_code::get_vehicle_classname()], getweaponbasename(objweapon))) {
      return 0;
    }
  }

  if(self.script_grenadeshield) {
    return 1;
  }

  return 0;
}

function explosive_bulletshielded(type) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!isDefined(self.script_explosive_bullet_shield)) {
    return 0;
  }

  type = tolower(type);

  if(!isDefined(type) || !issubstr(type, "g%\x0f\x95\xc3\xea\b\xae\xfd")) {
    return 0;
  }

  if(self.script_explosive_bullet_shield) {
    return 1;
  }

  return 0;
}

function bulletshielded(type) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!isDefined(self.script_bulletshield)) {
    return 0;
  }

  type = tolower(type);

  if(!isDefined(type) || !issubstr(type, "\xd7\xdb\xaaU\x82\xb0") || issubstr(type, "g%\x0f\x95\xc3\xea\b\xae\xfd")) {
    return 0;
  }

  if(self.script_bulletshield) {
    return 1;
  }

  return 0;
}

function function_56a5352f9d369de3(amount, damagelocation, meansofdeath, objweapon, attacker) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  var_6abb1cdb0bb44a47 = function_a703370b8c7b925a(64, damagelocation, 1);
  var_47e7585df1727559 = [];

  foreach(part in var_6abb1cdb0bb44a47) {
    if(level.vehicle.damageableparts[part].healthvalue == 5) {
      var_47e7585df1727559[var_47e7585df1727559.size] = part;
    }
  }

  var_6abb1cdb0bb44a47 = var_47e7585df1727559;
  closestparttodamage = utility::function_b691d50c7cd79a9(var_6abb1cdb0bb44a47);

  if(isDefined(closestparttodamage) && distancesquared(damagelocation, self gettagorigin(closestparttodamage)) <= squared(64)) {
    thread function_4ccfccffa8dadbac(closestparttodamage, amount, meansofdeath, objweapon, undefined, 1, damagelocation);
  }
}

function vehicle_deathlogic() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("n\xb7#\x95\xb0th}t49Y\xc2\x8c");
  thread vehicle_code::helicopter_unloading_watcher();
  self waittill("\x1e\xfd\xd1\xa2\a", attacker, meansofdeath, weaponobject, damagelocation);

  if(isDefined(self.fn_death)) {
    [[self.fn_death]]();
  }

  shouldcontinue = vehicle_deathcustomlogic(attacker, meansofdeath, weaponobject);

  if(isDefined(shouldcontinue) && !shouldcontinue) {
    return;
  }

  vehicle_playdeatheffects(attacker, meansofdeath, damagelocation);

  if(isDefined(self.riders)) {
    foreach(rider in self.riders) {
      if(!isDefined(rider)) {
        continue;
      }

      rider notify("&.\xf8(rq\x18ch\x1d\xe3\"\r\xe4\xee\r4l\xd8L");
      rider motionwarpcancel();
    }
  }

  if(isDefined(self.runningtovehicle)) {
    foreach(guy in self.runningtovehicle) {
      if(!isDefined(guy)) {
        continue;
      }

      guy notify("&.\xf8(rq\x18ch\x1d\xe3\"\r\xe4\xee\r4l\xd8L");
      guy motionwarpcancel();
    }
  }

  thread vehicle_code::vehicle_killriders();

  if(function_8df9c00ebdae969f()) {
    function_932432db10b5a1a4();
  } else {
    if(ishelicopter()) {
      vehicle_docrash(attacker, meansofdeath);
    }

    vehicle_setdeathmodel();
  }

  if(vehicle_code::vehicle_iscorpse()) {
    self notify("S0q\x9e\x06,77\xf97\x01b\x1bR\xa0\x952\xc0`\xea>", self.origin, self.angles);
    return;
  }

  vehicle_code::vehicle_deathcleanup();

  if(isDefined(self.driver) && isPlayer(self.driver)) {
    function_9910ceb723e45c93();
  }

  self notify("S0q\x9e\x06,77\xf97\x01b\x1bR\xa0\x952\xc0`\xea>", self.origin, self.angles);

  if(isDefined(self.driver) && isPlayer(self.driver)) {
    self.driver utility::callsharedfunc(#"vehicle", #"vehicle_drivershowviewmodel");
  }

  if(function_8df9c00ebdae969f() || self isscriptable()) {
    if(isDefined(self.var_baa586c34331ad94)) {
      utility::array_delete(self.var_baa586c34331ad94);
    }
  }

  wait 0.1;
  self delete();
}

function vehicle_setdeathmodel() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  model = vehicle_code::function_5ceb396224add9b3();

  if(!isDefined(level.vehicle.templates.deathmodel[model])) {
    return;
  }

  if(istrue(self.vehicle_skipdeathmodel)) {
    return;
  }

  if(self isscriptable()) {
    deathmodel = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", self.origin);
    deathmodel.angles = self.angles;
    deathmodel setModel(level.vehicle.templates.deathmodel[model]);
    deathmodel physicslaunchserver();

    if(deathmodel isscriptable() && deathmodel getscriptablehaspart("\xb7\x11\x9eh;\xb7") && deathmodel getscriptableparthasstate("\xb7\x11\x9eh;\xb7", "\x1e\xfd\xd1\xa2\a")) {
      deathmodel setscriptablepartstate("\xb7\x11\x9eh;\xb7", "\x1e\xfd\xd1\xa2\a");
    }

    return;
  }

  self setModel(level.vehicle.templates.deathmodel[model]);
}

function vehicle_landvehicle(neargoal, node) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("y\xecwy:L\xfd");

  if(!isDefined(neargoal)) {
    neargoal = 2;
  }

  self setneargoalnotifydist(neargoal);
  self sethoverparams(0, 0, 0);
  self cleargoalyaw();
  self settargetyaw(utility::flat_angle(self.angles)[1]);

  if(isDefined(self.unload_land_offset)) {
    setvehgoalpos_wrap(utility::groundpos(self.origin) + (0, 0, self.unload_land_offset), 1);
  } else {
    setvehgoalpos_wrap(utility::groundpos(self.origin), 1);
  }

  self waittill("\x83\xd6\xaf\x11");
}

function setvehgoalpos_wrap(origin, bstop) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(self.health <= 0) {
    return;
  }

  if(isDefined(self.originheightoffset)) {
    origin += (0, 0, self.originheightoffset);
  }

  self setvehgoalpos(origin, bstop);
}

function vehicle_liftoffvehicle(height) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!isDefined(height)) {
    height = 512;
  }

  destination = self.origin + (0, 0, height);
  self setneargoalnotifydist(10);
  setvehgoalpos_wrap(destination, 1);
  self waittill("\x83\xd6\xaf\x11");
}

function vehicle_docrash(attacker, cause) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(istrue(self.vehicle_skipdeathcrash)) {
    return;
  }

  vehicle_setcrashing(1);
  var_2fa6a4053398680 = getdvarint(@ "vehlegacyhelipathingforphysicshelicopters") != 0 && ishelicopter() && self vehicle_isphysveh();

  if(self vehicle_isphysveh() && !var_2fa6a4053398680) {
    self vehphys_crash();

    if(!istrue(self.dontdisconnectpaths)) {
      self disconnectPaths();
    }

    while(!vehicle_code::vehicle_iscorpse() && isDefined(self) && !vehicle_code::vehicle_is_stopped()) {
      waitframe();
    }
  } else if(ishelicopter()) {
    thread vehicle_helicoptercrash(attacker, cause);
    self waittill("\x9de4-c\xb1\xca\xebc\xc9\x16n\xd0\x88o\x9bY");
  }

  vehicle_setcrashing(0);
}

function vehicle_helicoptercrash(attacker, cause) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(isDefined(attacker) && isPlayer(attacker)) {
    self.original_attacker = attacker;
  }

  if(!isDefined(self)) {
    return;
  }

  vehicle_code::detach_getoutrigs();
  thread helicopter_crash_move(attacker, cause);
}

function helicopter_crash_move(attacker, cause) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("R}\xc3\xe1m\x8e\xd1\xabr\xba.\xac\xdd\xbfPv");

  if(isDefined(self.var_836a33e1f5b56739)) {
    crashloc = self.var_836a33e1f5b56739;
  } else if(isDefined(level.vehicle.var_ec907582bdc7d484)) {
    crashloc = [[level.vehicle.var_ec907582bdc7d484]](self);
  } else {
    assert(level.vehicle.helicopter_crash_locations.size > 0, "<dev string:x6f3>");
    unusedlocations = get_unused_crash_locations();
    assert(unusedlocations.size > 0, "<dev string:x770>");
    crashloc = utility::getclosest(self.origin, unusedlocations);
  }

  assert(isDefined(crashloc));
  crashloc.claimed = 1;
  self notify("y\xecwy:L\xfd");
  self notify("\x7fGv{t-\x97\xe2\xe6");
  indirect_zoff = 0;
  direct = 0;

  if(isDefined(crashloc.script_parameters) && crashloc.script_parameters == "D]\xa6\xc7\x9d?") {
    direct = 1;
  }

  if(isDefined(self.heli_crash_indirect_zoff)) {
    direct = 0;
    indirect_zoff = self.heli_crash_indirect_zoff;
  }

  var_e7380b59d08ac51c = undefined;

  if(direct) {
    assert(isDefined(crashloc.radius));
    crash_speed = 40;
    self vehicle_setspeed(crash_speed, 15, 10);
    self setneargoalnotifydist(crashloc.radius);
    self setvehgoalpos(crashloc.origin, 0);
    var_e7380b59d08ac51c = thread helicopter_crash_flavor(crashloc.origin, crash_speed);
    utility::waittill_any("\x83\xd6\xaf\x11", "*\x9f}\b\x94[?\x81\"");
    helicopter_crash_path(crashloc);
  } else {
    indirect_target = (crashloc.origin[0], crashloc.origin[1], self.origin[2] + indirect_zoff);

    if(isDefined(self.heli_crash_lead)) {
      indirect_target = self.origin + self.heli_crash_lead * self vehicle_getvelocity();
      indirect_target = (indirect_target[0], indirect_target[1], indirect_target[2] + indirect_zoff);
    }

    crash_speed = 20;

    if(isDefined(self.crash_speed)) {
      crash_speed = self.crash_speed;
    }

    self vehicle_setspeed(crash_speed, 10, 10);
    self setneargoalnotifydist(350);
    self setvehgoalpos(indirect_target, 1);
    var_e7380b59d08ac51c = thread helicopter_crash_flavor(indirect_target, 40);

    for(msg = "\x9a\x93\xb5\xc4I"; msg != "\x1e\xfd\xd1\xa2\a"; msg = "\x1e\xfd\xd1\xa2\a") {
      msg = utility::waittill_any("\x83\xd6\xaf\x11", "*\x9f}\b\x94[?\x81\"", "\x1e\xfd\xd1\xa2\a");

      if(!isDefined(msg) && !isDefined(self)) {
        crashloc.claimed = undefined;
        self notify("\x9de4-c\xb1\xca\xebc\xc9\x16n\xd0\x88o\x9bY");
        return;
      }
    }

    self setvehgoalpos(crashloc.origin, 0);
    self waittill("\x83\xd6\xaf\x11");
    helicopter_crash_path(crashloc);
  }

  crashloc.claimed = undefined;
  self notify("\xc6\xd4\x83\t?\xdb\xde`\x8fX\x13\xab\x050\x168\x0f\nK\xe2\x97");

  if(!istrue(var_e7380b59d08ac51c)) {
    self notify("\x9de4-c\xb1\xca\xebc\xc9\x16n\xd0\x88o\x9bY");
  }
}

function get_unused_crash_locations() {
  unusedlocations = [];
  level.vehicle.helicopter_crash_locations = utility::array_removeundefined(level.vehicle.helicopter_crash_locations);

  foreach(location in level.vehicle.helicopter_crash_locations) {
    if(isDefined(location.claimed)) {
      continue;
    }

    unusedlocations[unusedlocations.size] = location;
  }

  return unusedlocations;
}

function helicopter_crash_path(crashloc) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  while(isDefined(crashloc.target)) {
    crashloc = utility::getStruct(crashloc.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    assert(isDefined(crashloc));
    radius = 56;

    if(isDefined(crashloc.radius)) {
      radius = crashloc.radius;
    }

    self setneargoalnotifydist(radius);
    self setvehgoalpos(crashloc.origin, 0);
    utility::waittill_any("\x83\xd6\xaf\x11", "*\x9f}\b\x94[?\x81\"");
  }
}

function helicopter_crash_flavor(target_origin, crash_speed) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\x9de4-c\xb1\xca\xebc\xc9\x16n\xd0\x88o\x9bY");
  self clearlookatent();

  if(soundexists("\x1a\xb4\xdc\x19}\xa1+\xc6-\x8do\x0eG\x95\xe4}#\xbc\x96\xcdg\xbel\xdb\xde\x0e")) {
    self playLoopSound("\x1a\xb4\xdc\x19}\xa1+\xc6-\x8do\x0eG\x95\xe4}#\xbc\x96\xcdg\xbel\xdb\xde\x0e");
  }

  style = 0;

  if(isDefined(self.preferred_crash_style)) {
    style = self.preferred_crash_style;

    if(self.preferred_crash_style < 0) {
      style_chance = [1, 2, 2];
      total = 5;
      rnd = randomint(total);
      chance = 0;

      foreach(val in style_chance) {
        chance += val;

        if(rnd < chance) {
          style = i;
          break;
        }
      }
    }
  }

  switch (style) {
    case 1:
      thread helicopter_crash_zigzag();
      break;
    case 2:
      thread helicopter_crash_directed(target_origin, crash_speed);
      break;
    case 3:
      thread helicopter_in_air_explosion();
      break;
    case 4:
      thread helicopter_pilot_death_explosion();
      break;
    case 5:
      thread function_b58ddddf3ef09ffb(target_origin, crash_speed);
      return 1;
    case 0:
    default:
      thread helicopter_crash_rotate();
      break;
  }

  return undefined;
}

function helicopter_crash_zigzag() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\x9de4-c\xb1\xca\xebc\xc9\x16n\xd0\x88o\x9bY");
  self clearlookatent();
  self setyawspeed(400, 100, 100);
  dir = randomint(2);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    irand = randomintrange(20, 120);

    if(dir) {
      self settargetyaw(self.angles[1] + irand);
    } else {
      self settargetyaw(self.angles[1] - irand);
    }

    dir = 1 - dir;
    rtime = randomfloatrange(0.5, 1);
    wait rtime;
  }
}

function helicopter_crash_directed(target_origin, crash_speed) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\x9de4-c\xb1\xca\xebc\xc9\x16n\xd0\x88o\x9bY");
  self clearlookatent();
  self setmaxpitchroll(randomintrange(20, 90), randomintrange(5, 90));
  self setyawspeed(400, 100, 100);
  angleoff = 90 * randomintrange(-2, 3);

  for(;;) {
    totarget = target_origin - self.origin;
    yaw = vectortoyaw(totarget);
    yaw += angleoff;
    self settargetyaw(yaw);
    wait 0.1;
  }
}

function helicopter_in_air_explosion() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  vehicleclassname = vehicle_code::get_vehicle_classname();

  if(isDefined(level.vehicle.templates.vehicle_rocket_death_fx[vehicleclassname])) {
    deathfxstructs = level.vehicle.templates.vehicle_rocket_death_fx[vehicleclassname];
    struct = deathfxstructs[2];

    if(isDefined(struct) && isDefined(struct.waitdelay)) {
      wait struct.waitdelay;
    }

    waitframe();
  }

  self notify("\x9de4-c\xb1\xca\xebc\xc9\x16n\xd0\x88o\x9bY");
  self notify("R}\xc3\xe1m\x8e\xd1\xabr\xba.\xac\xdd\xbfPv");
}

function helicopter_pilot_death_explosion() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  thread helicopter_crash_rotate();
  utility::waittill_notify_or_timeout("\x83\xd6\xaf\x11", 5);
  self notify("f6\x16g\xf6\x9c\xeb2\xed\x9b+");
  thread helicopter_in_air_explosion();
}

function function_b58ddddf3ef09ffb(targetorigin, crashspeed) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  vehicleclassname = vehicle_code::get_vehicle_classname();
  smokefxstruct = level.vehicle.templates.var_b6a8f366c6727786[vehicleclassname];

  if(isstruct(smokefxstruct)) {
    playFXOnTag(smokefxstruct.effect, self, smokefxstruct.tag);
  }

  thread helicopter_crash_rotate();
  time = utility::mph_travel_time(crashspeed, distance(targetorigin, self.origin)) + 3;
  utility::waittill_any_timeout(clamp(time, 5, 15), "\x83\xd6\xaf\x11", "*\x9f}\b\x94[?\x81\"");

  if(isstruct(smokefxstruct)) {
    killfxontag(smokefxstruct.effect, self, smokefxstruct.tag);
  }

  self notify("f6\x16g\xf6\x9c\xeb2\xed\x9b+");
  thread helicopter_in_air_explosion();
}

function helicopter_crash_rotate() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\x9de4-c\xb1\xca\xebc\xc9\x16n\xd0\x88o\x9bY");
  self clearlookatent();
  self setmaxpitchroll(60, 90);
  self setyawspeed(700, 200, 200);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    irand = randomintrange(140, 170);
    self settargetyaw(self.angles[1] + irand);
    wait 0.5;
  }
}

function vehicle_setcrashing(boolean) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self.vehiclecrashing = boolean;
}

function vehicle_deathcustomlogic(attacker, meansofdeath, weaponobject) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  result = undefined;

  if(isDefined(self.custom_death_script)) {
    self thread[[self.custom_death_script]]();
  }

  if(isDefined(self.deathfunction)) {
    result = self[[self.deathfunction]](attacker, meansofdeath, weaponobject);
  }

  if(isDefined(level.vehicle.templates.death_thread[self.vehicletype])) {
    thread[[level.vehicle.templates.death_thread[self.vehicletype]]]();
  }

  registerkill = isDefined(meansofdeath) && isDefined(attacker) && isDefined(weaponobject);

  if(registerkill) {
    weaponname = getcompleteweaponname(weaponobject);
    attacker utility::script_func("~\xc7g\xdc\x957z}_#\xb1\x91\xfb", self, meansofdeath, weaponname);
  }

  return result;
}

function vehicle_playdeatheffects(attacker, meansofdeath, damagelocation) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(vehicle_isdestructible()) {
    return;
  }

  level notify("\xca\xbd9d\x9d\x97\x114\x93\xb7\x9c\x8b y\x92\xfc\xee", self.origin);
  self notify("*\x83\xc10XI\x1e", self.origin);
  thread vehicle_deathearthquake();
  thread vehicle_deathradiusdamage();

  if(self isscriptable() && !ishelicopter()) {
    utility::function_64d4c2d2dace59ac("\xe5\xd8!\xb8n\x8e\xf0\xc4\x86\xf7", "\x19b\xc2y");
    utility::delaycall(0.1, &delete);
    return;
  }

  thread vehicle_deathkilllights();
  thread vehicle_deathvfx(attacker, meansofdeath);
}

function vehicle_isdestructible() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  return isDefined(self.destructible_type);
}

function vehicle_deathearthquake() {
  deathearthquake = level.vehicle.templates.death_earthquake[vehicle_code::get_vehicle_classname()];

  if(isDefined(deathearthquake)) {
    earthquake(deathearthquake.scale, deathearthquake.duration, self.origin, deathearthquake.radius);
  }
}

function vehicle_deathradiusdamage() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x7ce>" + "<dev string:x376>");

  if(ishelicopter()) {
    return;
  }

  classname = vehicle_code::get_vehicle_classname();

  if(!(isDefined(level.vehicle.templates.death_radiusdamage) && isDefined(level.vehicle.templates.death_radiusdamage[classname]))) {
    return;
  }

  maxdamage = level.vehicle.templates.death_radiusdamage[classname].maxdamage;
  mindamage = level.vehicle.templates.death_radiusdamage[classname].mindamage;
  self radiusdamage(self.origin + level.vehicle.templates.death_radiusdamage[classname].offset, level.vehicle.templates.death_radiusdamage[classname].range, maxdamage, mindamage);
}

function vehicle_deathkilllights() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x7e9>" + "<dev string:x376>");
  vehicle_lights::lights_off_internal("\xc0\xc6J", self.model, vehicle_code::get_vehicle_classname());
}

function vehicle_deathvfx(attacker, meansofdeath) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  vehicleclassname = vehicle_code::get_vehicle_classname();
  var_2791f8175588b1a8 = isDefined(self.preferred_crash_style) && self.preferred_crash_style == 5;

  if(vehicle_shoulddorocketdeath(attacker, meansofdeath, vehicleclassname) || var_2791f8175588b1a8) {
    if(!var_2791f8175588b1a8) {
      self.vehicle_skipdeathmodel = 1;
      self.preferred_crash_style = 3;
    } else {
      self.var_dbd095504ac1cebc = 1;
    }

    deathfxstructs = level.vehicle.templates.vehicle_rocket_death_fx[vehicleclassname];
  } else if(istrue(self.pilot_killed)) {
    self.vehicle_skipdeathmodel = 1;
    self.preferred_crash_style = 4;
    deathfxstructs = level.vehicle.templates.vehicle_rocket_death_fx[vehicleclassname];
  } else {
    deathfxstructs = level.vehicle.templates.vehicle_death_fx[vehicleclassname];
  }

  if(isDefined(deathfxstructs)) {
    foreach(fxstruct in deathfxstructs) {
      thread kill_fx_thread(self.model, fxstruct, self.vehicletype, attacker);
    }
  }
}

function kill_fx_thread(model, struct, type, attacker) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(isDefined(self.pilot_killed) || istrue(self.var_dbd095504ac1cebc)) {
    self waittill("f6\x16g\xf6\x9c\xeb2\xed\x9b+");
  }

  if(isDefined(self.nodeath)) {
    return;
  }

  if(!isDefined(attacker)) {
    return;
  }

  assert(isDefined(struct));

  if(isDefined(struct.waitdelay)) {
    if(struct.waitdelay >= 0) {
      wait struct.waitdelay;
    } else {
      self waittill("\\\xd6X\xe9\x05\xf6\nh\x1158\x02\x18\a");
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(struct.notifystring)) {
    self notify(struct.notifystring);
  }

  attackerdirection = vectorNormalize(self.origin - attacker.origin);

  if(isDefined(struct.selfdeletedelay)) {
    utility::delaycall(struct.selfdeletedelay, &delete);
  }

  if(isDefined(struct.effect)) {
    if(struct.beffectlooping) {
      if(isDefined(struct.tag)) {
        if(isDefined(struct.stayontag) && struct.stayontag == 1) {
          thread loop_fx_on_vehicle_tag(struct.effect, struct.delay, struct.tag);
        } else {
          thread playloopedfxontag(struct.effect, struct.delay, struct.tag);
        }
      } else {
        forward = self.origin + (0, 0, 100) - self.origin;
        playFX(struct.effect, self.origin, forward);
      }
    } else if(isDefined(struct.tag)) {
      forward = _kill_fx_play_direction(attackerdirection, struct.attacker_velocity_lerp);

      if(isDefined(forward)) {
        deathent = deathfx_ent();
        playFX(struct.effect, deathent gettagorigin(struct.tag), forward);

        if(isDefined(struct.remove_deathfx_entity_delay)) {
          deathent utility::delaycall(struct.remove_deathfx_entity_delay, &delete);
        }
      } else {
        deathent = deathfx_ent();
        playFXOnTag(struct.effect, deathent, struct.tag);
        thread stop_fx_on_vehicle_watcher(struct.effect, deathent, struct.tag);

        if(isDefined(struct.remove_deathfx_entity_delay)) {
          deathfx_ent() utility::delaycall(struct.remove_deathfx_entity_delay, &delete);
        }
      }
    } else {
      forward = _kill_fx_play_direction(attackerdirection, struct.attacker_velocity_lerp);

      if(isDefined(forward)) {
        playFX(struct.effect, self.origin, forward);
      } else {
        forward = self.origin + (0, 0, 100) - self.origin;
        playFX(struct.effect, self.origin, forward);
      }
    }
  }

  if(isDefined(struct.sound)) {
    if(struct.bsoundlooping) {
      thread death_firesound(struct.sound);
      return;
    }

    utility::play_sound_in_space(struct.sound);
  }
}

function death_firesound(sound) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  thread utility::script_func("8\xc6\x85/\x1b\xdb\xb7\xe0\xdcou\xdc\xc8\xfa\xf6n\xebt,g", sound, undefined, 0, 1);
  utility::waittill_any("A\x10\n5\xd9\xcd\x86V\f\xba\xab\xb7f\xc8\xe9", "\xc6\xd4\x83\t?\xdb\xde`\x8fX\x13\xab\x050\x168\x0f\nK\xe2\x97");

  if(!isDefined(self)) {
    iprintln("<dev string:x809>");

    return;
  }

  self notify("y\x9cO.4\xf5\xb1\x19\xa8\xe1" + sound);
}

function deathfx_ent() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(isDefined(self.death_fx_on_self) && self.death_fx_on_self) {
    return self;
  }

  if(!isDefined(self.deathfx_ent)) {
    ent = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", (0, 0, 0));
    ent setModel(self.model);
    ent.origin = self.origin;
    ent.angles = self.angles;
    ent notsolid();
    ent hide();
    ent linkTo(self);
    ent.death_fx = 1;
    self.deathfx_ent = ent;
  } else {
    self.deathfx_ent setModel(self.model);
  }

  return self.deathfx_ent;
}

function _kill_fx_play_direction(attackdir, lerp) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(isDefined(attackdir) && isDefined(lerp)) {
    velocity = self getentityvelocity();
    velocity = vectorNormalize(velocity);
    attackdir = vectorNormalize(attackdir);
    dir = vectorlerp(velocity, attackdir, lerp);
    return dir;
  }

  return undefined;
}

function playloopedfxontag(effect, durration, tag) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  effectorigin = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", self.origin);
  self endon("A\x10\n5\xd9\xcd\x86V\f\xba\xab\xb7f\xc8\xe9");
  thread playloopedfxontag_originupdate(tag, effectorigin);

  while(true) {
    playFX(effect, effectorigin.origin, effectorigin.upvec);
    wait durration;
  }
}

function playloopedfxontag_originupdate(tag, effectorigin) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  effectorigin.angles = self gettagangles(tag);
  effectorigin.origin = self gettagorigin(tag);
  effectorigin.forwardvec = anglesToForward(effectorigin.angles);
  effectorigin.upvec = anglestoup(effectorigin.angles);

  while(isDefined(self) && self.code_classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e" && self vehicle_getspeed() > 0) {
    effectorigin.angles = self gettagangles(tag);
    effectorigin.origin = self gettagorigin(tag);
    effectorigin.forwardvec = anglesToForward(effectorigin.angles);
    effectorigin.upvec = anglestoup(effectorigin.angles);
    wait 0.05;
  }
}

function loop_fx_on_vehicle_tag(effect, looptime, tag) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  assert(isDefined(effect));
  assert(isDefined(tag));
  assert(isDefined(looptime));
  self endon("3Y%H1\x1d\x15\xa7zj\x88\x0f\x97\xd0\xf7Q\x03\xe2\x97\xa1\x8a");

  while(isDefined(self)) {
    playFXOnTag(effect, deathfx_ent(), tag);
    wait looptime;
  }
}

function stop_fx_on_vehicle_watcher(effect_id, deathent, effect_tag) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  deathent waittill("oj_\xdc\xf1\xcb\xb1\x12=\x91\xf0\xd8\xdf\x8d\xb2EA");
  stopFXOnTag(effect_id, deathent, effect_tag);
}

function vehicle_shoulddorocketdeath(attacker, meansofdeath, vehicleclassname) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!vehicle_hasrocketdeath(vehicleclassname)) {
    return false;
  }

  if(istrue(self.vehicle_forcerocketdeath)) {
    return true;
  }

  if(meansofdeath == "\xd4zD\xebP%\xe9IEC\x15R\x13*") {
    return true;
  }

  if(meansofdeath == "j\xa7\x11\xfa\x14J\xe9\x92\xa8\xd0*I\xc4\x8a\xd75\x05\x89\x05S\x90") {
    return true;
  }

  if(meansofdeath == "\x9az\x88\xfat)*\xe4\x14\x11\x15") {
    return true;
  }

  return false;
}

function vehicle_hasrocketdeath(classname) {
  return isDefined(level.vehicle.templates.vehicle_rocket_death_fx[classname]);
}

function function_8df9c00ebdae969f() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x85a>" + "<dev string:x376>");
  model = self.vehiclemodel;

  if(model == "") {
    model = self.model;
  }

  if(issubstr(model, "W\xd3")) {
    model = strtok(model, "W\xd3")[1];
  }

  if(isDefined(level.vehicle.templates.husk[model]) && !istrue(self.var_c2da02d8a143697f)) {
    return true;
  }

  return false;
}

function function_2a7668c3238ff719(quiet) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x894>" + "<dev string:x376>");
  utility::flag_wait("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97");
  husk = function_932432db10b5a1a4(quiet);
  self delete();
  return husk;
}

function function_932432db10b5a1a4(quiet) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!isDefined(level.vehicle.husks)) {
    level.vehicle.husks = [];
  } else {
    level.vehicle.husks = utility::array_removeundefined(level.vehicle.husks);
  }

  velocity = self vehicle_getvelocity();

  if(istrue(self.headondeath)) {
    velocity = self vehicle_getvelocity();
    velocity *= 5;
  }

  model = vehicle_code::function_5ceb396224add9b3();
  colorvariation = "";

  if(issubstr(model, "W\xd3")) {
    colorvariation = strtok(model, "W\xd3")[0] + "W\xd3";
    model = strtok(model, "W\xd3")[1];

    if(!istrue(level.vehicle.templates.var_823d01d0e03d4202[model])) {
      colorvariation = "";
    }
  }

  self notsolid();
  classname = vehicle_code::get_vehicle_classname();
  husk = spawnVehicle(colorvariation + level.vehicle.templates.husk[model], "K\xbf\xb2\xfe\x84\xd0pt\f\xac\x9f\xa1", level.vehicle.templates.husktype[model], self.origin, self.angles, undefined, velocity);
  husk.isvehiclehusk = 1;
  husk.classname_mp = classname;
  husk vehicle_sethealth(level.vehicle.templates.life[classname] + 100000);
  husk.healthstarting = level.vehicle.templates.life[classname];
  husk.parentmodel = model;
  husk.explosivehits = 0;
  husk.isstationary = self.isstationary;
  husk.parentlaunchtime = self.var_a2586a35d25c0a9b;
  husk.var_9d852b0be51ba072 = self.var_9d852b0be51ba072;
  husk utility::set_ai_number();

  if(isDefined(self.script_disconnectpaths)) {
    husk.script_disconnectpaths = self.script_disconnectpaths;
  }

  if(isDefined(self.script_badplace)) {
    husk.script_badplace = self.script_badplace;
  }

  if(!husk hascomponent("_\xb5\x13\x10x)k\x15")) {
    husk addcomponent("_\xb5\x13\x10x)k\x15");
  }

  self notify("\xce\xa8\xe5\xd1=\xe0\x12\xf7\xd6\x1eg\a\x06/\xed#\x99.\xf1(", husk);

  if(isDefined(self.var_a4a6c9f9025f54a1)) {
    husk thread[[self.var_a4a6c9f9025f54a1]]();
  }

  level.vehicle.husks = utility::array_add(level.vehicle.husks, husk);

  if(isDefined(self.spawnflags) && (self.spawnflags & 8 || istrue(husk.isstationary))) {
    husk vehphys_parkingbrake(1);
  }

  husk function_af542de68448290e();
  husk vehicle_turnengineoff();
  husk utility::delaycall(0.05, &vehphys_crash);
  husk function_c8cc945bbe92494f();

  if(getdvarint(@ "hash_cfd8073837710cef")) {
    print3d(husk.origin + (0, 0, 3), "<dev string:x8ac>" + velocity, (0, 1, 1), 1, 0.2, 1000, 1);

    utility::draw_arrow_time(husk.origin, husk.origin + velocity, (0, 1, 1), 1000);
  }

  if(istrue(self.var_54e549f1fb7f6695)) {
    husk.var_54e549f1fb7f6695 = self.var_54e549f1fb7f6695;
  }

  if(!istrue(quiet)) {
    husk thread function_10d8f2bafc6d55f7();
  }

  if(!istrue(quiet) && !istrue(self.skiplaunch)) {
    husk thread vehicle_code::vehicle_husklaunch(self, undefined, undefined);
  }

  husk thread vehicle_damagedebuginfo();

  husk thread vehicle_code::function_cec7a68e007ea227();
  husk thread function_42f59561e03c19b3();
  husk thread function_e5fa2c6836cebd7c(self);
  husk thread function_37fce4207aa07b42();

  if(isDefined(self.damageableparts)) {
    foreach(part in self.damageableparts) {
      if(vehicle_damage::function_5cef7c29a68bb143(part)) {
        husk.damageableparts[i].healthvalue = 0;
      }
    }
  }

  function_328bc8b7fcc6839e(husk);
  return husk;
}

function function_328bc8b7fcc6839e(husk) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(isDefined(self.riders)) {
    foreach(rider in self.riders) {
      if(!isDefined(rider)) {
        continue;
      }

      if(!isalive(rider)) {
        continue;
      }

      if(isDefined(rider._blackboard)) {
        vehicle = rider._blackboard.currentvehicle;
        position = rider._blackboard.var_70902d09f32053a7;
      } else {
        vehicle = rider.ridingvehicle;
        position = rider.vehicle_position;
      }

      aianims = vehicle_aianim::anim_pos(vehicle, position);

      if(isDefined(aianims) && isDefined(aianims.sittag)) {
        rider unlink();
      }

      rider linkTo(husk, aianims.sittag);
    }
  }
}

function function_e5fa2c6836cebd7c(parent) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(self isscriptable()) {
    var_fe067cb81e8fda05 = ["\xfe;K'x\x8cb\x1d", "\xe6Uy\x9d\x97\xb6[P\x98\xeaF", "\xdc \xe3\xe4\f\x8eN\x18#\f\xd4\xbc\xd6\xc8\xf0", "5?3\xa3\xb0\x94zwjJ\xd9F\xf03\x9b\x15", "G\x16\xb3\xaf1]\xd6\ae\xc9\xd73N\xbd\x9b\xd1", "t\x16\xd9\xf5\x89\xab\xd6\x0eV\x93\xafL\x166\xb5", "t\x85\xb3\xd7wK\xb9\xc8\xdc4-V\xd8\x8c\xebf\xe4\xdb\xcd\x8e", "\xaew&\x06\x1c@\x8atE\x80@u\xd5\xd2\xeb\xe6\xec\x9f\x8f\xf7\xfd@\xcc\x87I\xee\x82\x9be", "\xedO.\xcc\xfe\x99\xd3\x10\f#\xe4\x06,n\xd7\xcc\xd8\xd3\xb8\x97\xe7\xb3\xa5\x88", "\xd9\x8eZ\xa9\x83\xd9%]A5\x8b\x1a\xeaRo2p\xf8\xe8", "m\x03\xb0-\xf9\xe2W\xa4\x97\x87!\xfc\xde;\xebm\xcf\xd3\x95\xdf\xd9", "b\xf6\x01\x14;B(x\xf1\x9c\x88\xef~z\a\xdd\xbd%\x84\xfb2\x97", "\xaev\xd0\xe1C+\x86[\x82\xf5\xb8\a\x82\xbb\x80\xb47\xf3\xc6I", "t,\xec\xf5w\x9672\xbd\xbb}1\xb0\xc6\xad\xeb\x93\x96\xce\x1a\xe8", "U6\x1a\xd7\x8b\t\xe3p0\x9fga\xe3\"\xdcX\xd1\x8f\xa2Yv\xeb\xcf\xc80\xbfb", "\xa3a\xb3\xfa\xee-\x9bd{\xee_\x98\xb0\x1b[}r\xd2\xecCt\xf5\xd8o'\xdcV9", "\x8c2\xb9\x88qtG\xca\b\xec\x1f,\x02C_\x9e\xbd\x8f", "t,\xec\xf5\x86W1\xb1\x858}39\xde\xb9\x8e\xfa\xc6\xca\x99\xe8", "<e}\xb4dE\xdc\x14\xb0\xd6\xc5\x8e\xca,\x14\x11?\xee\x1b\x04\xb5\xc2", "\xd1\xb0\xec\xd7C]\x98l\xc2\x0e\xfa1\xc2\x8dm_\xc6Y3\xe8", ":\xb0\xb3\xf5h]\x89l\x85\xe0\xbe1\xb0\xb1[\xf5\x93Kv4G", "\xd1\xc2g\xd7\xdd\xa1\xac\xb2\xc6\xf5s\xe0XrV"];

    foreach(part in var_fe067cb81e8fda05) {
      if(isDefined(parent.damageableparts) && isDefined(parent.damageableparts[part])) {
        if(vehicle_damage::function_5cef7c29a68bb143(parent.damageableparts[part])) {
          state = "\x19b\xc2y";
        } else {
          parent.damageableparts[part].healthvalue = 0;
          state = "\x1e\xfd\xd1\xa2\a";
        }

        utility::function_64d4c2d2dace59ac(part, state);
      }
    }

    var_676176713a395d0 = ["{\xa3\xdbe\x1e\xe4vr\xfd|\xbf\x86J\xd4q\xfa@\x97\xb0", "\xa3\x85;\xaf\x19\xf6{\x93\xfa3\xe4o\xdct\xf59-;\xd0G", "\xdd\x12\xb7c\xa2\x1a\xbey\xbcz\xf0\xab0\xf0\xd2\x11\x80m", "Ff\xb8\x8c\x191\x18R2\x13\x85\x9e\t\x1c\xda\xfd\xbf\x89\xeb", "\x8eX\x9d\xfa&ump\x95N}\x99\xe4\xdbn\xd1\xbe\x91X\xdaX\xce\xcaF", "t\x16;\xaf\x89\xba[\xe0\x959\xf5\xc4\xb0\xc6m\xd7#Xk\x16\xd9e\x8c", "\x98\xf3B#\x04\x91\xfa\xe0,\xac\xef\xc0\fK\xd8v\x13\xed\xa6I", "\xdb\xdb\xe5\xe7\x1eD\xfeA\x18\x93\xd8a?Y0A\x1b-\xaa2v", "piU6\x16\xf8\x8a,z\xa6\xda\x82 %=\x98\x85\xceE\xae\xf5\xfc", "\xd1\x85g\xd7\xc6\x96\xd9\x86\xa3\xf5\x99'\xde\xdc\xa3\xd7\x93ighG\xbe\x19", "\xdd\x11_\x10\x90\xf8:9~uf\xf1+\xee\x9c\x03\x04\xbe\xb5", ",\x86O\xbb\xddm[IF\xd4i\xc8EC%-\xeb\xa4\xe0\x05", "O\x96\xcb\xb9\x931\x9a`\x88\xc1j\xc5'?^\x94\xe9\x1b\x8d\x17\xde", "\x0fU\xa0IH\xf3\xe4\x85m\x19\xa8 \xaa\xd0\xa4>\xe7\xe6\xc8\x12\x11(", "Z\xe0/A\x8e\xcf\xe9\x12e\x97f\x17\xbf\x92m3\\^", "k\x11O\xef\x98y\xa4<t4\xac\x94S\xa3]_\xe72\x03", "\x7fw?\x1dH\xe2D\xd9\xe5\xbc\xea\x1e\xaa&fVd[\xac\xa20\xe1", "\x1dP\xe9\xc0\xc0&\x8f\xbaZF\xdd0A\xc1Y\x87]\xc0q", "IvhP\xf9|\xe6\xe9\t7 \xb0\xa5\x88\xc5\xc9\x11\xbe", "j'I\x9d\xc3\f\x8fUQ\xff\n\x0f\xbd\xaa\xa3\xae\xb4\v\r\xed_\v}\x88J\xca\r", "\xab\awI\xb7\xc8\xe0Gk\x19\x81\x9d\xe2\xf9\xad\xb2\xe9|\x85\x82\xe6\x13I\x03G\xc0\x18D", "\x1dJ\x85<\x93\xb0}U\x86\xa0\xd8\xd5*\x9cH\x15KJ\xf7\x1b\xf2\x88\x1d!\x86\x9d\xd8\xf2", "\x02\xdc_#\xa3D\x1fJ\x9bE)\xbb*X\xfe\xa2\x1d\xeb,\xf2J\x05\xf7\x06\xaf\x1a\x11ON", "\xf6&sQF#`W\xf6\x17JBN\xbboY2\xe7\"\x8e\n\xd4Y\x1ae\xf7", "{\xa8I\xda\x87\x94Z3\x18\xa8\xd0\xcf\x02\x86\xb8s\xe7e\xd0&v0\x1c\x027r\xa4"];

    foreach(part in var_676176713a395d0) {
      state = undefined;

      if(isDefined(parent.damageableparts) && isDefined(parent.damageableparts[part]) && vehicle_damage::function_5cef7c29a68bb143(parent.damageableparts[part])) {
        classname = vehicle_code::get_vehicle_classname();

        if(iswheelbone(part) && getdvarint(@ "hash_4bd69b09131419ca") == 1) {
          function_4ccfccffa8dadbac(part, 0, "\x9fa91\xb9\xa7\xd3y\xfeITy\x86", undefined, level.player, 1, self gettagorigin(part), 0);
        } else {
          self.damageableparts[part].healthvalue = 0;
          state = "\x19b\xc2y";
        }
      } else if(isDefined(self.damageableparts) && isDefined(self.damageableparts[part]) && randomint(2) == 0) {
        classname = vehicle_code::get_vehicle_classname();

        if(iswheelbone(part) && getdvarint(@ "hash_4bd69b09131419ca") == 1) {
          function_4ccfccffa8dadbac(part, 0, "\x9fa91\xb9\xa7\xd3y\xfeITy\x86", undefined, level.player, 1, self gettagorigin(part), 0);
        } else {
          self.damageableparts[part].healthvalue = 0;
          state = "\x1e\xfd\xd1\xa2\a";
        }
      }

      if(isDefined(state)) {
        utility::function_64d4c2d2dace59ac(part, state);
      }
    }

    return;
  }

  thread function_b5c20429ad5cb97e("<dev string:x8bf>", 1, (1, 0, 0));
}

function function_37fce4207aa07b42() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self notify("\x19\xa2\xef~\xac\xdf\x9c~i$\x14T+T\xa2\x9c");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x19\xa2\xef~\xac\xdf\x9c~i$\x14T+T\xa2\x9c");

  thread function_b5c20429ad5cb97e("<dev string:x8de>", 2, (0, 1, 1));

  while(self.health > 0) {
    self.damageinfo = undefined;
    self waittill("\fU`\xc0y\x95", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time);
    partname = function_153c0158e8422bd5(partname);
    attachtagname = function_153c0158e8422bd5(attachtagname);
    damagedpartname = attachtagname != "" ? attachtagname : partname;
    amount = function_28cf8e66a94f0940(amount, meansofdeath, time);
    self.damageinfo["\xf2yqmf\x14"] = amount;
    self.damageinfo["Z\xb4\x87\xac '\am"] = attacker;
    self.damageinfo["L=\xb0g_u\x83$\x95\xd2\x10\x1d\b"] = direction_vec;
    self.damageinfo["/\xd0\x9a\x817\x9e,\aY\x0f\r\xc5\xc5\xd8"] = damagelocation;
    self.damageinfo["\x13\x01\xf9"] = meansofdeath;
    self.damageinfo["\xe5\x06\xb0\bE\x16"] = objweapon;

    if(function_e22e06c4d80a249f()) {
      thread function_b5c20429ad5cb97e("<dev string:x571>", 1, (0, 1, 0));

      self.health = self.healthactual;
      continue;
    }

    if(!function_cdf5a4d14c30e9d8(self.health, amount, direction_vec, damagelocation, meansofdeath, objweapon, attacker, inflictor)) {
      thread function_b5c20429ad5cb97e(meansofdeath + "<dev string:x603>" + amount + "<dev string:x61e>" + damagedpartname + "<dev string:x625>" + self.health + "<dev string:x591>" + time);

      if(meansofdeath == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
        function_56a5352f9d369de3(amount, damagelocation, meansofdeath, objweapon, attacker);
      } else {
        thread function_4ccfccffa8dadbac(damagedpartname, amount, meansofdeath, objweapon, attacker);
      }
    }

    if(function_13f261a563b91b58()) {
      thread function_b5c20429ad5cb97e("<dev string:x5da>", 1, (0, 1, 0));

      self.health = self.healthactual;
      continue;
    }

    self.healthactual = self.health;
  }
}

function function_cdf5a4d14c30e9d8(health, amount, direction_vec, damagelocation, meansofdeath, objweapon, attacker, inflictor) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(function_dfbd7f7c122040ed(health, amount, meansofdeath, objweapon)) {
    thread function_74001d2ba3442c();
    partstodamage = function_a703370b8c7b925a(undefined, damagelocation, 1);

    for(i = 0; i < partstodamage.size; i++) {
      if(i == 4) {
        break;
      }

      if(isDefined(inflictor)) {
        thread function_4ccfccffa8dadbac(partstodamage[i], amount * 2, meansofdeath, objweapon, attacker, 1, inflictor.origin);
        continue;
      }

      thread function_4ccfccffa8dadbac(partstodamage[i], amount * 2, meansofdeath, objweapon, attacker, 1);
    }

    if(!istrue(self.skiplaunch) && isDefined(meansofdeath) && isexplosivedamage(meansofdeath, objweapon)) {
      thread vehicle_code::function_6b685ddce1d4d1c1(amount, direction_vec, damagelocation, meansofdeath);
    }

    return true;
  }

  return false;
}

function function_dfbd7f7c122040ed(health, amount, meansofdeath, objweapon) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  classname = vehicle_code::get_vehicle_classname();
  assert(isDefined(level.vehicle.templates.explosivehits[classname]), "<dev string:x62c>" + classname);

  if(amount >= 110 && (meansofdeath == "9\xe6R?Wcx5\xf2F%Q3W\x06z\xfe\a" || meansofdeath == "\xa2rl\xdaDn\x17b\xd9I\xc9=N" || meansofdeath == "j\xa7\x11\xfa\x14J\xe9\x92\xa8\xd0*I\xc4\x8a\xd75\x05\x89\x05S\x90")) {
    hitsscale = function_14c9275bfc98d85b(objweapon);

    if(level.vehicle.templates.explosivehits[classname] > 0) {
      healthreduction = self.healthstarting / level.vehicle.templates.explosivehits[classname] / 0.5 * hitsscale;
      vehicle_addhealth(amount);
      function_66aacef1a8b8eef3(healthreduction);
    }

    self.explosivehits += 0.5 * hitsscale;
    return true;
  } else if(amount >= 190 && (meansofdeath == "\x9az\x88\xfat)*\xe4\x14\x11\x15" || meansofdeath == "\xd4zD\xebP%\xe9IEC\x15R\x13*" || meansofdeath == "\x9fa91\xb9\xa7\xd3y\xfeITy\x86")) {
    hitsscale = function_14c9275bfc98d85b(objweapon);

    if(level.vehicle.templates.explosivehits[classname] > 0) {
      healthreduction = self.healthstarting / level.vehicle.templates.explosivehits[classname] / 1 * hitsscale;
      vehicle_addhealth(amount);
      function_66aacef1a8b8eef3(healthreduction);
    }

    self.explosivehits += 1 * hitsscale;
    return true;
  }

  return false;
}

function vehicle_addhealth(amount, resetstarting) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x553>" + "<dev string:x376>");
  amount = int(amount);

  if(!isDefined(self.healthbuffer)) {
    self.healthbuffer = 0;
  }

  self.health += amount;
  self.healthactual = self.health;

  if(istrue(resetstarting)) {
    self.healthstarting = self.health - self.healthbuffer;
  }
}

function function_66aacef1a8b8eef3(amount, resetstarting) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x4b9>" + "<dev string:x376>");
  amount = int(amount);

  if(!isDefined(self.healthbuffer)) {
    self.healthbuffer = 0;
  }

  if(amount >= self.health) {
    vehicle_kill(level.player);
    return;
  }

  self.health -= amount;
  self.healthactual = self.health;

  if(istrue(resetstarting)) {
    self.healthstarting = self.health - self.healthbuffer;
  }
}

function private function_14c9275bfc98d85b(objweapon) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!isDefined(objweapon)) {
    return 1;
  }

  scaleweaponname = getweaponbasename(objweapon);
  scaledamount = 1;

  if(isDefined(level.var_7d174b9e2b6a8048)) {
    foreach(entry in level.var_7d174b9e2b6a8048) {
      if(entry[0] == scaleweaponname) {
        scaledamount = entry[1];
      }
    }
  }

  if(isDefined(self.var_7d174b9e2b6a8048)) {
    foreach(entry in self.var_7d174b9e2b6a8048) {
      if(entry[0] == scaleweaponname) {
        scaledamount = entry[1];
      }
    }
  }

  return scaledamount;
}

function function_74001d2ba3442c() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x8e7>" + "<dev string:x376>");

  if(!self isscriptable()) {
    return;
  }

  function_c8cc945bbe92494f();
  keys = getarraykeys(self.damageableparts);

  foreach(key in keys) {
    if(isstartstr(key, "\xe8\xb0\xec\xfa\xeeZ\xb9\x91")) {
      self.damageableparts[key].healthvalue = 0;
      utility::function_64d4c2d2dace59ac(key, "\x1e\xfd\xd1\xa2\a");
    }
  }
}

function function_4ccfccffa8dadbac(damagedpartname, amount, meansofdeath, objweapon, attacker, skipregen, origin, skiptire) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!isDefined(skipregen)) {
    skipregen = 0;
  }

  if(!isDefined(skiptire)) {
    skiptire = 0;
  }

  if(!isDefined(damagedpartname) || !utility::array_contains_key(level.vehicle.damageableparts, damagedpartname)) {
    return;
  }

  if(isDefined(damagedpartname) && isDefined(self.var_ce736cde368e23a8) && arraycontains(self.var_ce736cde368e23a8, damagedpartname)) {
    if(getdvarint(@ "hash_cfd8073837710cef")) {
      print3d(self.origin, "<dev string:x904>" + damagedpartname, (1, 1, 1), 1, 0.2, 1000, 1);
    }

    return;
  }

  function_c8cc945bbe92494f();

  if(!isDefined(self.damageableparts[damagedpartname])) {
    return;
  }

  if(!skipregen) {
    addhealth(amount * 0.5);
  }

  hits = 0;

  if(isDefined(objweapon) && isDefined(objweapon.classname)) {
    if(!isDefined(meansofdeath) || meansofdeath != "M\x81\xaf\xee\xc9\xcfD\xef\x91J") {
      switch (objweapon.classname) {
        case #"hash_719417cb1de832b6":
          hits = 0.5;
          break;
        case #"hash_8cdaf2e4ecfe5b51":
          hits = 1;
          break;
        case #"hash_6191aaef9f922f96":
          hits = 4;
          break;
        case #"hash_61e969dacaaf9881":
        case #"hash_e224d0b635d0dadd":
          hits = 8;
          break;
      }
    }
  } else if(isDefined(meansofdeath)) {
    switch (meansofdeath) {
      case #"hash_b1078ff213fddba6":
        hits = 1;
        break;
      case #"hash_a5123f4d02745600":
        hits = 3;
        break;
      case #"hash_61e42661ac27b9f2":
        hits = self.damageableparts[damagedpartname].healthvalue;
        break;
    }
  }

  if(iswheelbone(damagedpartname) && !isPlayer(attacker) || iswheelbone(damagedpartname) && isai(attacker)) {
    hits *= 0.5;
  }

  if(issubstr(damagedpartname, "\xe8\xb0\xec\xfa\xeeZ\xb9\x91") && isDefined(meansofdeath) && meansofdeath == "M\x81\xaf\xee\xc9\xcfD\xef\x91J" && isDefined(objweapon) && objweapon.classname == ",\xe1\x93So\x98\r") {
    hits = 2;
  }

  if(iswheelbone(damagedpartname) && skiptire) {
    hits = 0;
  }

  self.damageableparts[damagedpartname].healthvalue -= hits;

  thread function_190458c54394a7de(damagedpartname, hits, origin);

  if(vehicle_damage::function_5cef7c29a68bb143(self.damageableparts[damagedpartname])) {
    if(iswheelbone(damagedpartname) && !skiptire) {
      if(isvehiclehusk() || getdvarint(@ "hash_f0f3e5a83f3f2843") && function_19673cfdc0457934()) {
        numwheels = function_5b866aef7365dcf5();

        switch (damagedpartname) {
          case #"hash_176975cfc4da6ccf":
            function_247d3c35df33496b(0, "\xccX");
            break;
          case #"hash_7882ec199836b440":
            function_247d3c35df33496b(1, "\x05\xda");
            break;
          case #"hash_8990a9b7b683c2bd":
            function_247d3c35df33496b(2, "\xa8\x02");
            break;
          case #"hash_a4c07c681d7d1836":
            function_247d3c35df33496b(3, "\xb5\xe4");
            break;
          case #"hash_e88679f8ff04aa03":
            if(numwheels > 4) {
              function_247d3c35df33496b(4, "\x0f\xb6");
            } else {
              function_247d3c35df33496b(2, "\x0f\xb6");
            }

            break;
          case #"hash_95f9a89e42cf970c":
            if(numwheels > 4) {
              function_247d3c35df33496b(5, "\x0fW");
            } else {
              function_247d3c35df33496b(3, "\x0fW");
            }

            break;
        }
      }
    }

    utility::function_64d4c2d2dace59ac(damagedpartname, "\x1e\xfd\xd1\xa2\a");
    classname = vehicle_code::get_vehicle_classname();

    if(isDefined(level.vehicle.templates.dependentparts[classname]) && isDefined(level.vehicle.templates.dependentparts[classname][damagedpartname])) {
      foreach(part in level.vehicle.templates.dependentparts[classname][damagedpartname]) {
        if(!vehicle_damage::function_5cef7c29a68bb143(self.damageableparts[damagedpartname])) {
          utility::function_64d4c2d2dace59ac(part, "\x1e\xfd\xd1\xa2\a");
        }
      }
    }

    return;
  }

  if(issubstr(damagedpartname, "\xe8\xb0\xec\xfa\xeeZ\xb9\x91") && self.damageableparts[damagedpartname].healthvalue <= 3) {
    utility::function_64d4c2d2dace59ac(damagedpartname, "Jz.&UU");
  }
}

function function_5b866aef7365dcf5() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(self tagexists("\x1dJ\x85<\x93\xb0}U\x86\xa0\xd8\xd5*\x9cH\x15KJ\xf7\x1b\xf2\x88\x1d!\x86\x9d\xd8\xf2")) {
    return 6;
  }

  return 4;
}

function addhealth(amount) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(amount < 0) {
    print("<dev string:x912>" + amount);
    return;
  }

  self.health += int(amount);
}

function iswheelbone(damagedpartname) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  switch (damagedpartname) {
    case #"hash_176975cfc4da6ccf":
    case #"hash_7882ec199836b440":
    case #"hash_8990a9b7b683c2bd":
    case #"hash_95f9a89e42cf970c":
    case #"hash_a4c07c681d7d1836":
    case #"hash_e88679f8ff04aa03":
      return 1;
    default:
      return 0;
  }
}

function function_247d3c35df33496b(wheelnum, position) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x8e7>" + "<dev string:x376>");

  if(!isDefined(self.var_61b1d066dfc993fb)) {
    self.var_61b1d066dfc993fb = 0;
  }

  self.var_61b1d066dfc993fb |= 1 << wheelnum;

  if(isDefined(self.driver) && isPlayer(self.driver)) {
    level.player setclientomnvar("\xb4\xf4\xe2?sM\x8c\x0f\x8dcL\xbd\xb3O\xe8\xb1?/Mz0", self.var_61b1d066dfc993fb);
  }

  classname = vehicle_code::get_vehicle_classname();

  if(!isDefined(self.blowntires)) {
    self.blowntires = [];
  }

  if(!arraycontains(self.blowntires, position)) {
    self blowuptire(wheelnum);
    self.blowntires = utility::array_add(self.blowntires, position);
    self notify("\x19E\xc8%c\xddE\xfd\xd7\xf4\x04\xe0?\xca'_\x14n", position);
  }
}

function function_190458c54394a7de(damagedpartname, amount, origin) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x93f>" + "<dev string:x376>");

  self notify("<dev string:x967>" + damagedpartname);
  self endon("<dev string:x976>");
  self endon("<dev string:x967>" + damagedpartname);
  originoffset = undefined;

  if(isDefined(origin)) {
    originoffset = origin - self.origin;
  }

  time = gettime();

  for(;;) {
    if(!getdvarint(@ "hash_cfd8073837710cef")) {} else {
      if(gettime() - time > 10000) {
        break;
      }

      if(isDefined(originoffset)) {
        line(self.origin + originoffset, self gettagorigin(damagedpartname, 1), (1, 1, 1), 1, 0, 1);
      }

      print3d(self gettagorigin(damagedpartname, 1), damagedpartname + "<dev string:x603>" + amount + "<dev string:x625>" + self.damageableparts[damagedpartname].healthvalue + "<dev string:x591>" + time, (1, 1, 1), 1, 0.2, 1, 1);
    }

    waitframe();
  }
}

function function_10d8f2bafc6d55f7(state) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!self isscriptable()) {
    return;
  }

  if(!isDefined(state)) {
    state = "\xb8\"";
  }

  utility::function_64d4c2d2dace59ac("T\x8c\xb4\x9d\xdd\x16\xa5^\xdd\xc1\x167d\x90Etd", state);
  utility::function_64d4c2d2dace59ac("\xe7\xdf\x801[o\xd6wl\x16", state);

  if(!istrue(self.var_9d852b0be51ba072)) {
    utility::function_64d4c2d2dace59ac("x\xebRK \xf2\xc6\xa3\xa6\x89\x1e", state);
  }
}

function spawnvehicle_sp(spawndata, faildata) {
  vehicle = undefined;

  if(isDefined(spawndata.initialvelocity)) {
    vehicle = spawnVehicle(spawndata.modelname, spawndata.targetname, spawndata.vehicletype, spawndata.origin, spawndata.angles, spawndata.owner, spawndata.initialvelocity, spawndata.dospawnedcallback);
  } else {
    vehicle = spawnVehicle(spawndata.modelname, spawndata.targetname, spawndata.vehicletype, spawndata.origin, spawndata.angles, spawndata.owner, undefined, spawndata.dospawnedcallback);
  }

  if(!isDefined(vehicle)) {
    return undefined;
  }

  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x97f>" + "<dev string:x376>");
  vehicle.spawndata = spawndata;
  return vehicle;
}

function isplayerinvehicle(veh) {
  assert(!veh function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x9a2>" + "<dev string:x376>");

  if(isDefined(veh) && isDefined(veh.driver) && isPlayer(veh.driver)) {
    return true;
  }

  if(!isDefined(veh) && isDefined(level.player.veh)) {
    return true;
  }

  return false;
}

function function_57109d2dc6bc406f(veh) {
  assert(!veh function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x9a2>" + "<dev string:x376>");
  return !isplayerinvehicle(veh);
}

function deletevehicle_sp(vehicle) {
  assert(!vehicle function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x4fd>" + "<dev string:x376>");
  vehicle delete();
}

function vehicle_script_forcecolor_riders(script_forcecolor) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  foreach(rider in self.riders) {
    if(isai(rider)) {
      rider utility_sp::set_force_color(script_forcecolor);
      continue;
    }

    if(isDefined(rider.spawner)) {
      rider.spawner.script_forcecolor = script_forcecolor;
      continue;
    }

    assertmsg("<dev string:x9bc>");
  }
}

function fastrope_anim(model, animation, flag) {
  model animScripted(flag, model.origin, model.angles, animation, undefined, undefined, 0);
}

function door_anim(vehicle, animation) {
  vehicle setflaggedanimrestart("\xf9\x03\x9d\x02f\x97{\xdd\x180\t\xe1=\xbfh\xfa\x8c", animation);
}

function function_c6973c7ecc5591a0(distance, enter, interact_delay, var_bd4206898a9ed9b4 = 1, offset0, offset1) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x9e9>" + "<dev string:x376>");

  if(!self vehicle_isphysveh()) {
    return;
  }

  if(!isDefined(distance)) {
    distance = 150;
  }

  if(!isDefined(interact_delay)) {
    interact_delay = 0.5;
  }

  if(!isDefined(self.candamage)) {
    function_32ed3b18bdde4e08(1);
  }

  thread vehicle_watch_for_driving(distance, &function_8ffadf1f948e6055, &function_79e81c60bf74e1cb, interact_delay, var_bd4206898a9ed9b4, offset0, offset1);

  if(istrue(enter)) {
    level.player.veh = self;
    level.player function_8ffadf1f948e6055(self, var_bd4206898a9ed9b4);
  }
}

function private function_1bae6cba1a3566b4(howlong) {
  self notify("\xba\xe9\x9d\x98_b\xd3E\xa6\xe8\x9b(\xb0`af");
  self endon("\xba\xe9\x9d\x98_b\xd3E\xa6\xe8\x9b(\xb0`af");
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.var_20f6e2ea824baab9 = 1;
  wait howlong;
  self.var_20f6e2ea824baab9 = 0;
}

function private function_4e402214f2a7f523(dist, offset0, offset1) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  offset0 = offset0 ?? (0, 0, 0);
  offset1 = offset1 ?? (0, 0, 0);

  if(!isDefined(self.cursor_hints)) {
    self.cursor_hints = [];
    tag = "\xec\xbfK|\au\xcd\xc2\x19<";

    if(self tagexists("\r~t\x1c\x91z0}\xa1\xa7\xdf\x01PF\x830\xe4\xdd")) {
      tag = "\r~t\x1c\x91z0}\xa1\xa7\xdf\x01PF\x830\xe4\xdd";
    } else if(self tagexists("m\x03\xb0-\xb9\"\xa7\xa5\x94\xf3")) {
      tag = "m\x03\xb0-\xb9\"\xa7\xa5\x94\xf3";
    }

    hint_ent = utility::function_94c66bbed3da2a18(self gettagorigin(tag), (0, 0, 0));
    hint_ent linkTo(self, tag, offset0, (0, 0, 0));
    self.cursor_hints[self.cursor_hints.size] = hint_ent;

    foreach(cursor_hint in self.cursor_hints) {
      cursor_hint.var_e703a981d06a1192 = 1;
      cursor_hint cursor_hint::create_cursor_hint(undefined, undefined, &"hash_27799f76307755fa", 90, dist, dist);
    }

    utility::waittill_any("\x1e\xfd\xd1\xa2\a", "\x13T\x84y\x9c:\xeb\x9e}\xc9Y9\xda\xd5");

    foreach(cursor_hint in self.cursor_hints) {
      cursor_hint delete();
    }

    self.cursor_hints = undefined;
  }
}

function vehicle_watch_for_driving(dist, entercallback, exitcallback, interact_delay, var_bd4206898a9ed9b4, offset0, offset1) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self notify("C`e\x94\xdb\x90\x99V\x96v{+\b\xcc\xdeJ6\xaaz\n\xfa\xfb|\x03U");
  self endon("C`e\x94\xdb\x90\x99V\x96v{+\b\xcc\xdeJ6\xaaz\n\xfa\xfb|\x03U");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x13T\x84y\x9c:\xeb\x9e}\xc9Y9\xda\xd5");
  level.player endon("\x1e\xfd\xd1\xa2\a");
  self.player_drivable = 1;

  if(self.code_classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e") {
    thread function_4e402214f2a7f523(dist, offset0, offset1);

    while(true) {
      utility::waittill_any_ents_array(self.cursor_hints, "\x91`\xb1\xe7T\x97>");
      level.player val::set("\xb3VC-\xc6c\xb2", "`\x16\xae\xa2\xe4t\x187\xe7", 0);
      level.player[[entercallback]](self, var_bd4206898a9ed9b4);

      while(level.player useButtonPressed()) {
        waitframe();
      }

      if(isDefined(interact_delay)) {
        wait interact_delay;
      }

      level.player waittill(":\x8dYuZ$\xf8\x8b^<(");
      level.player val::reset_all("\xb3VC-\xc6c\xb2");
      level.player[[exitcallback]](self);
      self.driver = undefined;
      level.player.veh = undefined;

      if(isDefined(interact_delay)) {
        wait interact_delay;
      }
    }
  }
}

function function_fab908b5d7a4f720() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:xa05>" + "<dev string:x376>");
  self notify("\x13T\x84y\x9c:\xeb\x9e}\xc9Y9\xda\xd5");
  self.player_drivable = undefined;
}

function function_8ffadf1f948e6055(veh, var_bd4206898a9ed9b4) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:x9e9>" + "<dev string:x376>");
  animtag = "m\x03\xb0-\xb9\"\xa7\xa5\x94\xf3";
  veh function_2bf4d035410164b6(animtag);
  veh.ownerid = self getentitynumber();
  veh.originalowner = self;
  veh.team_og = veh.team;
  veh.driver = self;
  veh.can_hijack = undefined;
  self.veh = veh;

  if(isDefined(self.team)) {
    veh.team = self.team;
  }

  self setplayerangles(veh.angles);
  veh setotherent(self);
  self animscriptentervehicle();
  veh vehicle_turnengineon();
  self usevehicle(veh, 0, 1);
  self hideviewmodel();
  self hidelegsandshadow();
  self playerhide();
  self startcameratween(0.5);

  if(veh hascomponent("\xf5C'")) {
    veh setconfigvalue("\xf5C'", "\xe1f\x0fv\x96", 1);
  }

  if(veh hascomponent("D\xc7\xb3\x91")) {
    veh setconfigvalue("D\xc7\xb3\x91", "\xe1f\x0fv\x96", 1);
  }

  if(isDefined(veh.turret)) {
    veh.turret setotherent(self);
    self remotecontrolturret(veh.turret);
  }

  veh vehphys_parkingbrake(0);

  if(isDefined(veh.classname_mp)) {
    callback::callback(#"hash_bdcfe99d5271a18d", {
      #var_bd4206898a9ed9b4: var_bd4206898a9ed9b4, #vehicle_model: veh.model
    });
    veh function_2ba0b2f77db6ce25();
    veh function_47928040a45736e4();
    veh function_c7757649c8097e58(0);
  }

  self notify("\xc2\xc1u\xd6bI#Jp\x8e\xdcV\xc17O\xfb\xe6|\x16\xf5rd\x82", veh);
  self notify("\x8bw\xc1\xd1\xeb\x1d\x0e\x04\xad!{\xcb\xf7");
}

function function_c82bad5785ce2e74() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!isDefined(self.blowntires)) {
    return [];
  }

  return self.blowntires;
}

function function_67ea7a2a342b8ab3(inflictor) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:xa24>" + "<dev string:x376>");

  if(istrue(self.godmode) || istrue(self.demigodmode)) {
    print("<dev string:xa44>");
    return;
  }

  burndownhealth = self.healthstarting * 0.3 - 1 + self.healthbuffer;
  burndowndamage = self.health - burndownhealth;

  if(burndowndamage > 1) {
    self dodamage(burndowndamage, self.origin, inflictor, undefined, "\x9fa91\xb9\xa7\xd3y\xfeITy\x86");
  }
}

function function_535dafac745fb26a(needbrake) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self.var_1d05a652f2044499 = needbrake;
}

function function_32ed3b18bdde4e08(bool) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:xa83>" + "<dev string:x376>");

  if(bool) {
    self.candamage = 1;
    self setCanDamage(1);
    return;
  }

  self.candamage = 0;
  self setCanDamage(0);
}

function function_79e81c60bf74e1cb(veh) {
  assert(!veh function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:xaa5>" + "<dev string:x376>");

  if(!isDefined(veh.driver)) {
    return;
  }

  veh.ownerid = 0;
  veh.originalowner = undefined;
  veh.driver = undefined;

  if(isDefined(veh.team_og)) {
    veh.team = veh.team_og;
  }

  if(isDefined(veh.exitfunc)) {
    exitpos = [[veh.exitfunc]]();
  } else {
    exitpos = self.origin + anglestoright(self.angles) * -100 + anglesToForward(self.angles) * -80;
  }

  self leavevehicle(0, 1);
  self setOrigin(utility::drop_to_ground(exitpos, 0, 0));
  self animscriptexitvehicle();
  veh setotherent(undefined);
  veh setentityowner(undefined);
  self playershow();
  function_626a1e107fcccc44();
  self showlegsandshadow();
  val::reset_all("\xb3VC-\xc6c\xb2");

  if(isDefined(veh.turret)) {
    self remotecontrolturretoff(veh.turret);
    veh.turret setmode("\xda\x13\x17\xa2q\xf0\xfb\xf8w\xe6\xe5qh\xe9");
  }

  if(isDefined(veh.classname_mp)) {
    callback::callback(#"hash_a698d2f22002248c");
    veh function_9910ceb723e45c93();
    veh function_c7757649c8097e58(1);
  }

  if(istrue(veh.var_1d05a652f2044499)) {
    veh vehphys_parkingbrake(1);
  }

  self notify("?\xc6\xf5Y\xd1\xd0`W\xba\xbbpT*\x04U\x1d?\xc8\xf7\xfb\xf3\xc0", veh);
}

function function_daf07ebacb30997d(guy) {
  exitpos = function_124a84ab43e5dc43(anglestoleft(self.angles), guy) ?? function_124a84ab43e5dc43(anglestoright(self.angles), guy);

  if(!istrue(level.var_d3600ae8a9050d90) && (!isvector(exitpos) || !ispointonnavmesh(exitpos, guy))) {
    bounds = self getboundshalfsize();
    leftexitpos = self.origin + anglestoleft(self.angles) * (max(40, bounds[1]) + 40);
    exitpos = getclosestpointonnavmesh(leftexitpos, guy);
    exitpos = guy checkposinsolid(exitpos);
  }

  return exitpos;
}

function private function_124a84ab43e5dc43(dir, guy) {
  bounds = self getboundshalfsize();
  upoffset = anglestoup(self.angles) * (self.var_6f273f314be10d17 ?? 0);
  exitpos1 = self.origin + dir * (bounds[1] + 10 + 5) + upoffset;
  halfwidth = max(40, bounds[1]) + 40;
  exitpos2 = self.origin + dir * halfwidth + upoffset;
  content = self.var_f479e9b144bf596b ?? trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  traceinfo = trace::sphere_trace(exitpos1, exitpos2, 10, [guy], content);

  if(traceinfo["\xda\x16\x81\aw}^i"] < 0.1) {
    return undefined;
  }

  exitpos = vectorlerp(exitpos1, exitpos2, traceinfo["\xda\x16\x81\aw}^i"]);
  return guy checkposinsolid(exitpos);
}

function private checkposinsolid(exitpos) {
  insolid = trace::player_trace(exitpos + (0, 0, 20), exitpos);

  if(insolid["\xda\x16\x81\aw}^i"] < 0.9) {
    return undefined;
  }

  return exitpos;
}

function function_626a1e107fcccc44() {
  self showviewmodel();
}

function function_2bf4d035410164b6(bone) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  parts = getnumparts(self.model);

  if(parts > 0) {
    for(i = 0; i < parts; i++) {
      if(getpartname(self.model, i) == bone) {
        return true;
      }
    }
  }

  iprintln("<dev string:xac0>" + self.model + "<dev string:xacd>" + bone);

  return false;
}

function function_7f3e576d62e018ad(weaponname) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  assert(isDefined(weaponname), "<dev string:xae6>");

  if(!isDefined(self.var_c4717464c2b8c07d)) {
    self.var_c4717464c2b8c07d = [];
  }

  if(!isarray(weaponname)) {
    weaponname = [weaponname];
  }

  self.var_c4717464c2b8c07d = utility::array_combine(self.var_c4717464c2b8c07d, weaponname);
  self.var_c4717464c2b8c07d = utility::array_remove_duplicates(self.var_c4717464c2b8c07d);
}

function function_8c6fa1cdd8ffae53(weaponname, scale) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  assert(isDefined(weaponname), "<dev string:xae6>");
  assert(isDefined(scale), "<dev string:xb09>");
  assert(!isstring(scale), "<dev string:xb26>");

  if(!isDefined(self.var_7d174b9e2b6a8048)) {
    self.var_7d174b9e2b6a8048 = [];
  }

  if(isarray(weaponname)) {
    foreach(name in weaponname) {
      self.var_7d174b9e2b6a8048 = utility::array_add(self.var_7d174b9e2b6a8048, [name, scale]);
    }

    return;
  }

  self.var_7d174b9e2b6a8048 = utility::array_add(self.var_7d174b9e2b6a8048, [weaponname, scale]);
}

function function_22979b2fcafc24a7(usedistance, enter) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x32a>" + "<dev string:xa05>" + "<dev string:x376>");
  thread utility::script_func("\x17\xbdxO\xb7D\xae\x8e\xa5?\x98}N\xea", usedistance, enter);
}

function vehicle_updatedamagestate(newstate, oldstate) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  assert(isDefined(newstate) && isDefined(oldstate));

  if(newstate == oldstate) {
    return;
  }

  self notify("+%\xc2\xfb\x96P\x14\x83\x02v\x1ep\x97\x9b\xec\x1d@\x17\xac", newstate);

  if(oldstate != "\xa2\x0e\x03\x18\xd1\xd3\x9c\xcb\xa9\x8a\xbd\r\x96\x03") {
    function_44f9083d43348f5f(oldstate);
  }

  if(newstate != "\xa2\x0e\x03\x18\xd1\xd3\x9c\xcb\xa9\x8a\xbd\r\x96\x03") {
    function_5e080593c243f4d1(newstate);
  }

  self.damagestate = newstate;
}

function function_10ebe2f038568985(state) {
  self notify("\xa0F;P{\xb9\x9c\xac\xb6\x90U|@\xca\xd8\xb4");
  self endon("\xa0F;P{\xb9\x9c\xac\xb6\x90U|@\xca\xd8\xb4");
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  oldspeedstate = undefined;

  while(isDefined(self)) {
    speedstate = undefined;
    speed = int(self vehicle_getspeed());

    if(speed <= 3) {
      speedstate = 0;
    } else if(speed <= 25) {
      speedstate = 1;
    } else {
      speedstate = 2;
    }

    if(isDefined(oldspeedstate) && isDefined(self.damagestate) && speedstate != oldspeedstate) {
      function_5e080593c243f4d1(state);
      return;
    }

    oldspeedstate = speedstate;
    wait 0.1;
  }
}

function function_c461acfd68ad4fdd() {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  self notify("CJ[\x0e*\x93-\xf3\xa8\xc8i\xdb\x1b\xc9\xa0\xd1\xcb\x19Z\xd1\x19\n\xb8\x1d\xe9\xee\x06\xb3W#[F0<\xc0B\x80\r");
}

function function_5e080593c243f4d1(state) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");

  if(!self isscriptable()) {
    return;
  }

  if(!self getscriptablehaspart(state) || !self getscriptableparthasstate(state, "\xf8\x88m")) {
    return;
  }

  speed = int(self vehicle_getspeed());

  if(speed <= 3) {
    self setscriptablepartstate(state, "\t\xe6\xedX6\xeb\xa7", 1);
  } else if(speed <= 25) {
    self setscriptablepartstate(state, "\xcb\xba\xeb\x89\n\xfd\x82\x89", 1);
  } else {
    self setscriptablepartstate(state, "T\xca\xa7\x8a\xdf\xbb\xf1,\xb4", 1);
  }

  thread function_10ebe2f038568985(state);
}

function function_44f9083d43348f5f(state) {
  assert(!function_b0176e9e85e2d9e9(), "<dev string:x193>");
  function_c461acfd68ad4fdd();

  if(!self isscriptable()) {
    return;
  }

  if(!self getscriptablehaspart(state) || !self getscriptableparthasstate(state, "\xf8\x88m")) {
    return;
  }

  self setscriptablepartstate(state, "\xf8\x88m", 1);
}

function function_82723d0344d232c() {
  assert(isDefined(level.vehicle), "<dev string:xb51>");
  leveldata = spawnStruct();
  leveldata.minedata = [];
  level.vehicle.minetriggerdata = leveldata;

  if(utility::issharedfuncdefined(#"vehicle_mines", #"init")) {
    [[utility::getsharedfunc(#"vehicle_mines", #"init")]]();
  }
}

function function_5306611fbd1461fc() {
  assert(isDefined(level.vehicle.minetriggerdata), "<dev string:xb85>");
  return level.vehicle.minetriggerdata;
}

function function_d99afe8cca2ec06e(equipref, create) {
  leveldata = function_5306611fbd1461fc();
  minedata = leveldata.minedata[equipref];

  if(!isDefined(minedata) && istrue(create)) {
    minedata = spawnStruct();
    minedata.radius = 10;
    minedata.triggercallback = undefined;
    leveldata.minedata[equipref] = minedata;
  }

  return minedata;
}

function vehicle_isfriendlytomine(mine) {
  if(isDefined(mine.owner) && isDefined(self.driver)) {
    return (mine.owner.team == self.driver.team);
  }

  return false;
}

function private getvehicleminedata(vehicleref) {
  vehicleminedata = get_data(vehicleref).damage;

  if(!isDefined(vehicleminedata)) {
    vehicleminedata = spawnStruct();
  }

  if(!isDefined(vehicleminedata.frontextents)) {
    vehicleminedata.frontextents = 90;
  }

  if(!isDefined(vehicleminedata.backextents)) {
    vehicleminedata.backextents = 115;
  }

  if(!isDefined(vehicleminedata.leftextents)) {
    vehicleminedata.leftextents = 38;
  }

  if(!isDefined(vehicleminedata.rightextents)) {
    vehicleminedata.rightextents = 38;
  }

  if(!isDefined(vehicleminedata.bottomextents)) {
    vehicleminedata.bottomextents = 20;
  }

  if(!isDefined(vehicleminedata.distancetobottom)) {
    vehicleminedata.distancetobottom = 35;
  }

  if(!isDefined(vehicleminedata.loscheckoffset)) {
    vehicleminedata.loscheckoffset = (0, 0, 37);
  }

  return vehicleminedata;
}

function private getnormal2d(vector) {
  return (vector[1], vector[0] * -1, 0);
}

function vehicle_shouldvehicletriggermine(vehicle, mine) {
  if(istrue(vehicle function_b0176e9e85e2d9e9())) {
    println("<dev string:xbc7>");
  }

  if(!isDefined(vehicle.classname) && vehicle.classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e") {
    return false;
  }

  minedata = function_d99afe8cca2ec06e(mine.equipmentref);

  if(!isDefined(minedata)) {
    return false;
  }

  if(istrue(mine.exploding)) {
    return false;
  }

  if(lengthsquared(vehicle vehicle_getvelocity()) < 100) {
    if(lengthsquared(vehicle vehicle_getangularvelocity()) < 400) {
      return false;
    }
  }

  vehicleminedata = getvehicleminedata(vehicle.vehiclename);

  if(!isDefined(vehicleminedata)) {
    dist = distance(vehicle.origin, mine.origin);

    if(dist > minedata.radius + 150) {
      return false;
    }
  } else {
    frontoffsetvec = anglesToForward(vehicle.angles) * vehicleminedata.frontextents;
    backoffsetvec = anglesToForward(vehicle.angles) * -1 * vehicleminedata.backextents;
    leftoffsetvec = anglestoright(vehicle.angles) * -1 * vehicleminedata.leftextents;
    rightoffsetvec = anglestoright(vehicle.angles) * vehicleminedata.rightextents;
    vehicleorigin = vehicle.origin + vehicleminedata.loscheckoffset;
    frontleft = vehicleorigin + frontoffsetvec + leftoffsetvec;
    frontright = vehicleorigin + frontoffsetvec + rightoffsetvec;
    backleft = vehicleorigin + backoffsetvec + leftoffsetvec;
    backright = vehicleorigin + backoffsetvec + rightoffsetvec;
    var_8cd4e6d723f23086 = (frontright - frontleft) * (1, 1, 0);
    var_a25a183994b68826 = (backleft - frontleft) * (1, 1, 0);
    between = mine.origin - frontleft;
    betweendot = vectordot(vectorNormalize(var_8cd4e6d723f23086), between);

    if(betweendot < 0) {
      return false;
    }

    betweendot = vectordot(vectorNormalize(var_a25a183994b68826), between);

    if(betweendot < 0) {
      return false;
    }

    var_57a0c5c272867ab0 = (backleft - backright) * (1, 1, 0);
    var_8f23e0b066175de9 = (frontright - backright) * (1, 1, 0);
    between = mine.origin - backright;
    betweendot = vectordot(vectorNormalize(var_57a0c5c272867ab0), between);

    if(betweendot < 0) {
      return false;
    }

    betweendot = vectordot(vectorNormalize(var_8f23e0b066175de9), between);

    if(betweendot < 0) {
      return false;
    }

    between = mine.origin - vehicleorigin - anglestoup(vehicle.angles) * vehicleminedata.bottomextents;
    betweendot = vectordot(between, anglestoup(vehicle.angles));

    if(betweendot > vehicleminedata.distancetobottom) {
      return false;
    } else if(betweendot < -100) {
      return false;
    }
  }

  return true;
}

function vehicle_minetrigger(vehicle, mine) {
  if(istrue(vehicle function_b0176e9e85e2d9e9())) {
    println("<dev string:xbc7>");
  }

  minedata = function_d99afe8cca2ec06e(mine.equipmentref);

  if(isDefined(minedata.triggercallback)) {
    thread[[minedata.triggercallback]](vehicle, mine);
  }

  if(utility::issharedfuncdefined(#"vehicle_mines", #"trigger")) {
    thread[[utility::getsharedfunc(#"vehicle_mines", #"trigger")]](vehicle, mine);
  }
}

function trackprojectiles() {
  if(!isDefined(level.mines)) {
    level.mines = [];
  }

  if(!isDefined(level.projectilekillstreaks)) {
    level.projectilekillstreaks = [];
  }

  if(!isDefined(level.var_a7649d89078653e9)) {
    level.var_a7649d89078653e9 = 0;
  }

  while(true) {
    level.grenades = getEntArray(",\xe1\x93So\x98\r", #classname);
    level.missiles = getEntArray("N\xbd6\xb6e\x1d", #classname);
    level.projectilepartition = undefined;
    level.smallprojectilepartition = undefined;
    waitframe();
  }
}

function createprojectilepartition() {
  if(isDefined(level.projectilepartition)) {
    return;
  }

  arr2d = [];
  arr2d[0] = level.grenades;
  arr2d[1] = level.missiles;
  arr2d[2] = level.mines;
  arr2d[3] = level.projectilekillstreaks;
  projectiles = [];

  foreach(array in arr2d) {
    foreach(entity in array) {
      if(isent(entity)) {
        projectiles[entity getentitynumber()] = entity;
      }
    }
  }

  level.projectilepartition = utility::create_partition(projectiles, 400);
}

function function_a1e1596a26a4adbd() {
  utility::registersharedfunc(#"game_utility", #"createProjectilePartition", &createprojectilepartition);
  level thread trackprojectiles();
  thread vehicle_damage::function_d57b78ea693a64e8();
}