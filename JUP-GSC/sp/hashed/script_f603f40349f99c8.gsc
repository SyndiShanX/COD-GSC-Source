/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_f603f40349f99c8.gsc
************************************************/

#using script_3a8f9ace195c9da9;
#using script_3cb1beed718e7650;
#using script_69a61780e1cc21a9;
#using script_f603f40349f99c8;
#using scripts\common\ai;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\cp\helicopter\cp_helicopter;
#using scripts\cp\utility;
#using scripts\cp\vehicles;
#using scripts\cp\vehicles\damage_cp;
#using scripts\cp\weapon;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;
#namespace namespace_8b141a01ef32f9c7;

function function_dc1dc0ca4ebbffff() {
  level thread function_878c940b4037c1bc();
  namespace_d8c2d739478db8bb::main();
  level.var_c64e1c2400079db2 = [];
  function_5083d138c614f0b2("heli_ahotel", "veh_jup_ahotel", undefined, undefined, undefined, undefined, 5000);
  function_88d2b9d02c3d28f7("heli_ahotel", "turret", "veh9_mil_air_heli_ahotel64_turret", "chopper_gunner_turret_dam_sandbox", "tag_turret");
  function_88d2b9d02c3d28f7("heli_ahotel", "projectile", undefined, "chopper_gunner_proj_cp", undefined, "tag_gun_r", "tag_gun_l");
  function_1174b5f59ff8bb07("heli_ahotel", ["tag_pilot"], undefined, undefined, undefined, [(-5, -5, -5)]);
  function_5083d138c614f0b2("heli_hind", "veh_jup_hind", undefined, undefined, undefined, undefined, 5000);
  function_88d2b9d02c3d28f7("heli_hind", "turret", "veh9_mil_air_heli_hind_turret_mp", "chopper_gunner_turret_chemical_sandbox", "tag_turret");
  function_88d2b9d02c3d28f7("heli_hind", "projectile", undefined, "iw9_la_rpapa7_cp_hind", undefined, "tag_gun_right1", "tag_gun_left1");
  function_1174b5f59ff8bb07("heli_hind", ["tag_pilot"], undefined, undefined, undefined, [(40, 0, -5)]);
  function_5083d138c614f0b2("heli_med", "veh_jup_heli_med");
  function_1174b5f59ff8bb07("heli_med", ["tag_seat_0", "tag_seat_1"]);
  function_5083d138c614f0b2("heli_iw9_blima", "veh9_blima");
  function_1174b5f59ff8bb07("heli_iw9_blima", ["tag_pilot1", "tag_pilot2"], undefined, undefined, undefined, [(0, 0, -20), (0, 0, -20)]);
  function_5083d138c614f0b2("heli_blima", "veh_jup_blima");
  function_1174b5f59ff8bb07("heli_blima", ["tag_pilot1", "tag_pilot2"], undefined, undefined, undefined, [(0, 0, -20), (0, 0, -20)]);
  function_5083d138c614f0b2("heli_blima_anim_infil", "veh_jup_blima_anim_infil");
  function_1174b5f59ff8bb07("heli_blima_anim_infil", ["tag_pilot1", "tag_pilot2"], undefined, undefined, undefined, [(0, 0, -20), (0, 0, -20)]);
  function_5083d138c614f0b2("heli_palfa", "veh_jup_palfa");
  function_1174b5f59ff8bb07("heli_palfa", ["tag_seat_0", "tag_seat_1"], undefined, undefined, undefined, [(0, 0, 10), (0, 0, 10)]);
  function_5083d138c614f0b2("heli_iw9_palfa", "veh9_palfa");
  function_1174b5f59ff8bb07("heli_iw9_palfa", ["tag_seat_0", "tag_seat_1"], undefined, undefined, undefined, [(0, 0, 10), (0, 0, 10)]);
  function_5083d138c614f0b2("heli_ru_heli_transport", "veh_jup_ru_heli_transport");
  function_1174b5f59ff8bb07("heli_ru_heli_transport", ["tag_seat_0", "tag_seat_1"], undefined, undefined, undefined, [(0, 0, 10), (0, 0, 10)]);
  level._effect["vfx_blima_explosion_ground"] = loadfx("vfx/iw9/cp/vfx_blima_explosion_ground.vfx");

  setdevdvarifuninitialized(@ "hash_38043388d6ad9578", 0);
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x38>", "<dev string:x49>");
  scripts\common\devgui::function_fe953f000498048f();
}

function function_878c940b4037c1bc() {
  flag_wait("create_script_initialized");

  if(!isDefined(level.var_e71b7bace9f852ce)) {
    level.var_e71b7bace9f852ce = [];
  }

  if(!isDefined(level.var_27181b4298b7c47f)) {
    level.var_27181b4298b7c47f = [];
  }

  var_3fa0d61dfe35d78d = getStructArray("heli_unload", "script_noteworthy");
  level.var_e71b7bace9f852ce = array_combine_unique(level.var_e71b7bace9f852ce, var_3fa0d61dfe35d78d);
  global_exits = getStructArray("heli_exit", "targetname");
  level.var_27181b4298b7c47f = array_combine_unique(level.var_27181b4298b7c47f, global_exits);
}

function private function_e2a8f0e3599cb3e9() {}

function function_5083d138c614f0b2(alias, vehicle_ref, model, vehicletype, classname_mp, var_fd80c01ac65aedfe, health, var_a4d76f90d6916d81) {
  if(isDefined(level.var_c64e1c2400079db2[alias])) {
    return;
  }

  var_a4d76f90d6916d81 = default_to(var_a4d76f90d6916d81, 0);
  health = default_to(health, 5000);
  struct = spawnStruct();
  struct.alias = alias;
  struct.vehicle_ref = vehicle_ref;
  struct.model = model;
  struct.vehicletype = vehicletype;
  struct.classname_mp = classname_mp;
  struct.health = health;
  struct.var_a4d76f90d6916d81 = var_a4d76f90d6916d81;
  struct.var_fd80c01ac65aedfe = var_fd80c01ac65aedfe;
  level.var_c64e1c2400079db2[alias] = struct;
}

function function_1174b5f59ff8bb07(alias, tags, idle_anims, var_400555c3cb5919c5, axis_models, tag_offsets, angle_offsets) {
  assertex(isDefined(level.var_c64e1c2400079db2[alias]), "register_dungeon_heli_fake_pilot - No alias data registered for specified Alias!");

  if(!isDefined(level.var_c64e1c2400079db2[alias].var_6b14b67cfe9b565e)) {
    level.var_c64e1c2400079db2[alias].var_6b14b67cfe9b565e = [];
  }

  idle_anims = default_to(idle_anims, ["vh_mindia8_pilot_idle"]);
  tags = default_to(tags, ["tag_seat_0"]);
  var_400555c3cb5919c5 = default_to(var_400555c3cb5919c5, ["allied_pilot_fullbody_1", "allied_pilot_fullbody_2", "allied_pilot_fullbody_3"]);
  axis_models = default_to(axis_models, ["xcomp_c_sp_enemy_pmc_pilot_fullbody", "xcomp_c_sp_enemy_pmc_pilot_fullbody"]);
  struct = spawnStruct();
  struct.tags = tags;
  struct.idle_anims = idle_anims;
  struct.var_400555c3cb5919c5 = var_400555c3cb5919c5;
  struct.axis_models = axis_models;
  struct.tag_offsets = tag_offsets;
  struct.angle_offsets = angle_offsets;
  level.var_c64e1c2400079db2[alias].var_6b14b67cfe9b565e = struct;
}

function function_88d2b9d02c3d28f7(alias, weapon_type, turret_model, weapon_asset, weapon_tag, var_3487cd6784d0808d, var_9770a147a288de82) {
  assertex(isDefined(level.var_c64e1c2400079db2[alias]), "register_dungeon_chopper_weapon - No alias data registered for specified Alias!");
  assertex(function_5b7e9a4c946f3a13(weapon_type, ["turret", "projectile"]), "register_dungeon_chopper_weapon - Invalid weapon type!");

  if(!isDefined(level.var_c64e1c2400079db2[alias].weapons)) {
    level.var_c64e1c2400079db2[alias].weapons = [];
  }

  struct = spawnStruct();
  struct.weapon_type = weapon_type;
  struct.turret_model = turret_model;
  struct.weapon_asset = weapon_asset;
  struct.weapon_tag = weapon_tag;
  struct.var_3487cd6784d0808d = var_3487cd6784d0808d;
  struct.var_9770a147a288de82 = var_9770a147a288de82;
  level.var_c64e1c2400079db2[alias].weapons = array_add(level.var_c64e1c2400079db2[alias].weapons, struct);
}

function function_15cc3579cdac3cfb(veh_spawner, health_override, owner, team, has_flares, skip_init, var_c963289eca1e8c95) {
  if(isDefined(skip_init)) {
    veh_spawner.skip_init = skip_init;
  }

  heli = function_142bb6a871e12466(veh_spawner, undefined, owner, var_c963289eca1e8c95);

  if(!istrue(skip_init)) {
    heli function_710597a48791417e(has_flares, health_override, team, veh_spawner);
  }

  if(istrue(heli.var_a4d76f90d6916d81)) {
    function_63a4589af5fb207c(heli);
  }

  level.incomingallchoppergunners++;
  heli.ishovering = 0;
  heli thread function_882f3ddd49a7fc42();
  return heli;
}

function function_e48fde1878d8a034(veh_spawner, ai_spawners, skip_init) {
  if(isDefined(skip_init)) {
    veh_spawner.skip_init = skip_init;
  }

  heli = function_142bb6a871e12466(veh_spawner, ai_spawners);

  if(istrue(veh_spawner.var_e662d8c3659cb3e3)) {
    heli.var_e662d8c3659cb3e3 = 1;
  }

  if(!istrue(veh_spawner.nopath)) {
    if(istrue(veh_spawner.var_5b19e50d0eb082f1)) {
      level thread function_3cdf4ced62a8f20c(heli, veh_spawner, heli scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd());
    } else {
      level delaythread(1, &function_7341a0e079d4d2c8, heli, veh_spawner, heli scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd());
    }
  }

  return heli;
}

function function_60437debbda12a43(veh_spawner, owner, skip_init, team) {
  team = default_to(team, "allies");

  if(isDefined(skip_init)) {
    veh_spawner.skip_init = skip_init;
  }

  heli = function_142bb6a871e12466(veh_spawner, undefined, owner);

  if(!istrue(skip_init)) {
    heli function_9b94a0371fe1f89f(-1, team);
  }

  if(istrue(heli.var_a4d76f90d6916d81) || !isDefined(heli.var_a4d76f90d6916d81)) {
    function_63a4589af5fb207c(heli);
  }

  return heli;
}

function function_142bb6a871e12466(veh_spawner, ai_spawners, owner, var_c963289eca1e8c95) {
  alias = veh_spawner.script_function;
  assertex(isDefined(alias), "dungeon_spawn_heli_common - No script_function defined on spawner! Manually define one or use one of the predefined script_struct_cp_vehicle_jup_heli_* spawners");
  alias_data = function_2c780304448a233b(alias);

  if(!isDefined(alias_data)) {
    assertmsg("dungeon_spawn_heli_common - No alias data registered for specified Alias!");
    return undefined;
  }

  ref_override = undefined;

  if(isDefined(veh_spawner.ref_override)) {
    ref_override = veh_spawner.ref_override;
  }

  if((isDefined(alias_data.vehicle_ref) || isDefined(ref_override)) && !istrue(var_c963289eca1e8c95)) {
    heli = function_a383f70a02485829(veh_spawner, ai_spawners);
  } else {
    ref_data = undefined;

    if(isDefined(alias_data.vehicle_ref) || isDefined(ref_override)) {
      ref = ter_op(isDefined(ref_override), ref_override, alias_data.vehicle_ref);
      ref_data = scripts\cp_mp\vehicles\vehicle::function_29b4292c92443328(ref);
    }

    vehicletype = alias_data.vehicletype;

    if(isDefined(ref_data)) {
      vehicletype = ref_data.vehicle;
    }

    model = alias_data.model;

    if(isDefined(ref_data)) {
      model = ref_data.model;
    }

    assertex(isDefined(model) && isDefined(vehicletype), "dungeon_spawn_heli_common - No chopper model and/or type defined!");
    veh_spawner.owner = owner;
    veh_spawner.vehicletype = vehicletype;
    veh_spawner.modelname = model;
    veh_spawner.in_use = 1;
    heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, veh_spawner.origin, veh_spawner.angles, vehicletype, model);

    if(!isDefined(heli)) {
      return undefined;
    }

    heli.vehicle_spawner = veh_spawner;

    if(!isDefined(veh_spawner.spawned_vehicles)) {
      veh_spawner.spawned_vehicles = [];
    }

    veh_spawner.spawned_vehicles = array_add(veh_spawner.spawned_vehicles, heli);

    if(isDefined(veh_spawner.var_a4d76f90d6916d81)) {
      heli.var_a4d76f90d6916d81 = veh_spawner.var_a4d76f90d6916d81;
    }

    heli.alias = alias;
  }

  return heli;
}

function private function_a22505cd7aae238c() {}

function function_9b94a0371fe1f89f(health_override, team_override) {
  self.isheli = 1;
  self.borntime = gettime();
  self.team = "axis";

  if(isDefined(self.script_team)) {
    self.team = self.script_team;
  } else if(isDefined(team_override)) {
    self.team = team_override;
  }

  self setvehicleteam(self.team);
  self.teamfriendlyto = self.team;

  if(self.team == "axis") {
    level thread scripts\cp\weapon::add_to_special_lockon_target_list(self);
    thread helicopter_death_lockon_clear();
  }

  if(is_equal(health_override, -1)) {
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  } else {
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
    thread destroy_vehicle_if_driver_dies();
    chopper_health = 1250;

    if(isDefined(self.alias)) {
      alias_data = level.var_c64e1c2400079db2[self.alias];
      chopper_health = alias_data.health;
    }

    set_cp_vehicle_health_values(chopper_health);

    if(isDefined(health_override)) {
      chopper_health = health_override;
    }

    var_b03bb545b5483a28 = 1;

    if(var_b03bb545b5483a28 == 0) {
      thread scripts\common\vehicle_code::vehicle_deathlogic();
      self.death_fx_on_self = 1;
      self.vehicle_skipdeathmodel = 1;
      self.vehicle_forcerocketdeath = undefined;
      self.deathfunction = &scripts\cp\vehicles::function_30a6caeaaa14c934;
      self.nocrash = 0;
      self.var_78da61277c9dee0a = &function_97b00cd33ff5cfd8;
      self.var_eae10920b9197a32 = &function_bf9918e38554b480;
    } else if(var_b03bb545b5483a28 == 1) {
      self.health_remaining = chopper_health;
      thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor(undefined, chopper_health);
      self.nocrash = 1;
      self.var_78da61277c9dee0a = &function_97b00cd33ff5cfd8;
      self.var_eae10920b9197a32 = &function_bf9918e38554b480;
    } else {
      scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data_for_weapon("veh_jup_heli_med", 1, "iw9_la_gromeo_mp");
    }

    if(getdvarint(@ "hash_38043388d6ad9578", 0) == 1) {
      level thread function_42f32038d8ff20bb(self);
    }
  }

  thread damage_players_on_top();
  thread scripts\cp\helicopter\cp_helicopter::rumble_nearby_players();
  utility::function_3677f2be30fdd581("engine", "on");
  utility::function_3677f2be30fdd581("vector_field", "on");
  utility::function_3677f2be30fdd581("blinking_lights", "on");
  utility::function_3677f2be30fdd581("running_lights", "on");
  utility::function_3677f2be30fdd581("Exhaust", "on");
  self vehicle_turnengineon();
  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = self;
}

function function_3dc9f009b066c5ef(needs_riders, health_override, team_override, var_739bfde00a15fde3) {
  if(!isDefined(var_739bfde00a15fde3)) {
    var_739bfde00a15fde3 = 1;
  }

  function_9b94a0371fe1f89f(health_override, team_override);

  if(!isDefined(self.load_queue)) {
    self.load_queue = [];
  }

  if(istrue(var_739bfde00a15fde3)) {
    thread landing_damage_watcher();
  }

  self.vehicle_spawner.in_use = 1;
  self.no_evasive = 1;
  vehicle_ref = scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd();

  if(needs_riders) {
    switch (vehicle_ref) {
      case #"hash_293b5f5fefd56c2c":
      case #"hash_9d4e22a00fc630b5":
        self.unload_hover_offset = 150;
        break;
      case #"hash_b40eeff172c68887":
        self.unload_hover_offset = 692;
        break;
      default:
        break;
    }

    level scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(self);
  }
}

function function_710597a48791417e(has_flares, health_override, team_override, heli_spawner) {
  function_9b94a0371fe1f89f(health_override, team_override);

  if(!isDefined(has_flares)) {
    has_flares = 1;
  }

  if(istrue(has_flares)) {
    self.flaresreservecount = 1;
    self.flareslive = [];

    if(issharedfuncdefined("flares", "handleIncomingStinger")) {
      self thread[[getsharedfunc("flares", "handleIncomingStinger")]]();
    }
  }

  self.needs_to_evade = 0;
  self.circlespeed = 40;
  self.var_f9ff3a209aa9db43 = 20;
  self.var_434136cad96e6f3a = 20;
  self.circle_radius = 2500;
  self setmaxpitchroll(15, 15);
  self sethoverparams(25, 15, 10);

  if(isDefined(self.alias)) {
    var_6b6c95721d1a7495 = level.var_c64e1c2400079db2[self.alias].weapons;

    foreach(weapon_str in var_6b6c95721d1a7495) {
      if(weapon_str.weapon_type == "turret") {
        turret_model = weapon_str.turret_model;

        if(isDefined(heli_spawner) && isDefined(heli_spawner.skinoverride)) {
          turret_model = heli_spawner.skinoverride + "::" + turret_model;
        }

        scripts\cp\helicopter\cp_helicopter::heli_mg_create(turret_model, weapon_str.weapon_asset, weapon_str.weapon_tag);
        continue;
      }

      if(weapon_str.weapon_type == "projectile") {
        self.rockets_ready = 1;
        self.var_a2838155288f4e2d = 0.5;
        self.var_daa92cf2a7658327 = weapon_str.var_3487cd6784d0808d;
        self.var_daa912f2a76549f9 = weapon_str.var_9770a147a288de82;
        self.rocket_weapon = weapon_str.weapon_asset;
      }
    }
  }
}

function private function_33825298e360ff5f() {}

function function_63a4589af5fb207c(vehicle, var_ce466b5e28c4827d, var_882160ef04cd8207) {
  if(!isDefined(var_ce466b5e28c4827d)) {
    var_ce466b5e28c4827d = 0;
  }

  if(!isDefined(var_882160ef04cd8207)) {
    var_882160ef04cd8207 = 0;
  }

  if(var_882160ef04cd8207 && var_ce466b5e28c4827d) {
    return;
  }

  var_c5e1976ccbcb10e2 = undefined;
  vehicle_data = undefined;
  fake_guys = [];
  start_seat = 0;
  ang_offset = undefined;
  tag_offset = undefined;

  if(isDefined(vehicle.alias) && isDefined(level.var_c64e1c2400079db2[vehicle.alias].var_6b14b67cfe9b565e)) {
    var_c5e1976ccbcb10e2 = level.var_c64e1c2400079db2[vehicle.alias].var_6b14b67cfe9b565e;
    pilot_num = var_c5e1976ccbcb10e2.tags.size;

    if(is_equal(vehicle.team, "allies")) {
      drivermodels = var_c5e1976ccbcb10e2.var_400555c3cb5919c5;
    } else {
      drivermodels = var_c5e1976ccbcb10e2.axis_models;
    }
  } else {
    drivermodels = ["xcomp_c_sp_enemy_pmc_pilot_fullbody", "xcomp_c_sp_enemy_pmc_pilot_fullbody"];
    pilot_num = 2;
  }

  if(!isDefined(level.vehicle_ai_script_models)) {
    level.vehicle_ai_script_models = [];
  }

  if(isDefined(vehicle.vehiclename)) {
    vehicle_data = scripts\cp_mp\vehicles\vehicle::function_29b4292c92443328(vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd());

    if((!isDefined(vehicle_data.aiseats) || vehicle_data.aiseats.size == 0) && !isDefined(var_c5e1976ccbcb10e2)) {
      return;
    }
  }

  if(!isDefined(vehicle_data) && !isDefined(var_c5e1976ccbcb10e2)) {
    return;
  }

  if(var_ce466b5e28c4827d) {
    start_seat = 1;
  }

  if(var_882160ef04cd8207) {
    pilot_num = 1;
  }

  for(i = start_seat; i < pilot_num; i++) {
    if(isDefined(vehicle_data) && isDefined(vehicle_data.aiseats[i])) {
      struct = vehicle_data.aiseats[i];
      tag = struct.sittag;
      idle_anim = struct.idle_anim;
      idle = struct.idle;

      if(isDefined(var_c5e1976ccbcb10e2.tag_offsets) && isDefined(var_c5e1976ccbcb10e2.tag_offsets[i])) {
        tag_offset = var_c5e1976ccbcb10e2.tag_offsets[i];
      }

      if(isDefined(var_c5e1976ccbcb10e2.angle_offsets) && isDefined(var_c5e1976ccbcb10e2.angle_offsets[i])) {
        ang_offset = var_c5e1976ccbcb10e2.angle_offsets[i];
      }
    } else {
      tag = var_c5e1976ccbcb10e2.tags[i];

      if(var_c5e1976ccbcb10e2.idle_anims.size > 1) {
        idle_anim = var_c5e1976ccbcb10e2.idle_anims[i];
      } else {
        idle_anim = var_c5e1976ccbcb10e2.idle_anims[0];
      }

      if(isDefined(var_c5e1976ccbcb10e2.tag_offsets) && isDefined(var_c5e1976ccbcb10e2.tag_offsets[i])) {
        tag_offset = var_c5e1976ccbcb10e2.tag_offsets[i];
      }

      if(isDefined(var_c5e1976ccbcb10e2.angle_offsets) && isDefined(var_c5e1976ccbcb10e2.angle_offsets[i])) {
        ang_offset = var_c5e1976ccbcb10e2.angle_offsets[i];
      }

      idle = undefined;
    }

    fake_guy = vehicle function_961b546391bfb613(i, tag, idle_anim, idle, drivermodels[i], tag_offset, ang_offset);
    fake_guys[fake_guys.size] = fake_guy;
    level.vehicle_ai_script_models[level.vehicle_ai_script_models.size] = fake_guy;
    vehicle thread function_488891202f54b173(fake_guys);
  }
}

function function_488891202f54b173(fake_guys) {
  self waittill("death");

  if(isDefined(fake_guys)) {
    for(i = 0; i < fake_guys.size; i++) {
      fake_guys[i] function_181c9f4791ecc5c1();
    }
  }
}

function function_181c9f4791ecc5c1() {
  if(array_contains(level.vehicle_ai_script_models, self)) {
    level.vehicle_ai_script_models = array_remove(level.vehicle_ai_script_models, self);
  }

  if(isDefined(self)) {
    self delete();
  }
}

function function_961b546391bfb613(posindex, tag, animname, xanim, model, tag_offset, ang_offset) {
  if(!isDefined(self.usedpositions)) {
    self.usedpositions = [];
  }

  if(!isDefined(self.attachedguys)) {
    self.attachedguys = [];
  }

  if(!isDefined(self.riders)) {
    self.riders = [];
  }

  assertex(!istrue(self.usedpositions[posindex]), "Trying to assign to a position already in use");
  spawnorg = self gettagorigin(tag);
  spawnang = self gettagangles(tag);

  if(isDefined(xanim)) {
    startorg = getstartorigin(spawnorg, spawnang, xanim);
    startang = getstartangles(spawnorg, spawnang, xanim);
  } else {
    startorg = spawnorg;
    startang = spawnang;
  }

  spawned = spawn("script_model", startorg);
  spawned.angles = startang;
  spawned setModel(model);

  if(!isDefined(ang_offset)) {
    ang_offset = (0, 0, 0);
  }

  if(isDefined(tag_offset)) {
    spawned linktomoveoffset(self, tag, tag_offset, ang_offset);
  } else if(istrue(self.var_9e0ade9f6d9a6b3)) {
    spawned linktomoveoffset(self, tag);
  } else {
    spawned linktomoveoffset(self, tag, (0, 0, 0), (0, 0, 0));
  }

  if(isDefined(animname)) {
    spawned scriptmodelplayanim(animname);
  } else if(isDefined(xanim)) {
    spawned scriptmodelplayanim(xanim);
  }

  spawned.vehicle_position = posindex;
  spawned.disable_gun_recall = 1;
  self.attachedguys[self.attachedguys.size] = spawned;
  self.usedpositions[posindex] = 1;
  self.riders[self.riders.size] = spawned;

  if(posindex == 0) {
    self.driver = spawned;
    self.pilot = spawned;
  } else if(posindex == 1) {
    self.copilot = spawned;
  }

  return spawned;
}

function function_e0a8282dc1437508(var_c2f1ca305ee16808) {
  self endon("death");
  var_c2f1ca305ee16808 endon("death");

  if(!isDefined(self) || !isDefined(var_c2f1ca305ee16808)) {
    return;
  }

  health_amount = 250;

  while(true) {
    self waittill("damage", amount, attacker, unused, point);

    if(isDefined(attacker) && isPlayer(attacker) && isDefined(amount) && amount > 0 && isDefined(point)) {
      if(var_c2f1ca305ee16808 tagexists("j_head")) {
        head_pos = var_c2f1ca305ee16808 gettagorigin("j_head");
      } else {
        head_pos = var_c2f1ca305ee16808.origin + (0, 0, 50);
      }

      head_pos += (0, 0, -20);
      start_point = attacker getEye();
      vec_shot = vectorNormalize(point - start_point);
      vec_head = vectorNormalize(head_pos - start_point);
      hit_dot = vectordot(vec_shot, vec_head);
      veh_dot = vectordot(vectorNormalize(anglesToForward(self.angles)), vectorNormalize(point - self.origin));
      seat_pos = var_c2f1ca305ee16808.origin + (0, 0, 18);

      if(hit_dot > 0.99975 && veh_dot > 0.73 && point[2] > seat_pos[2]) {
        health_amount -= amount;

        if(health_amount <= 0) {
          self notify("death", attacker);
        }
      }
    }
  }
}

function private function_918c429e7f3c0a01() {}

function function_3cdf4ced62a8f20c(vehicle, veh_spawner, heli_type, var_ebc42e43f4b05504) {
  vehicle.animintro = 1;
  vehicle function_247ad6a91f6a4ffe(1);
  vehicle vehphys_forcekeyframedmotion();
  node = veh_spawner.unloadloc;
  vehicle.currentnode = node;
  ground_pos = drop_to_ground(node.origin, 100, -1000);
  scenenode = spawnStruct();
  scenenode.origin = ground_pos;
  scenenode.angles = node.angles;
  vehicle.scenenode = scenenode;
  animation = level.vehicle.templates.aianims[vehicle scripts\common\vehicle_code::get_vehicle_classname()][0].vehicle_getoutanim;
  neworg = getstartorigin(scenenode.origin, scenenode.angles, animation);
  newangles = getstartangles(scenenode.origin, scenenode.angles, animation);
  vehicle vehicle_teleport(neworg, newangles);
  vehicle dontinterpolate();
  vehicle scripts\common\vehicle_paths::unload_node(node);
  vehicle function_ba0a95c33d3dcf7f(node, node);
}

function function_7341a0e079d4d2c8(vehicle, veh_spawner, heli_type, var_ebc42e43f4b05504) {
  vehicle endon("death");

  if(!isDefined(var_ebc42e43f4b05504)) {
    var_ebc42e43f4b05504 = 1;
  }

  vehicle thread function_5ab30a41cdf6dc06(vehicle, veh_spawner, var_ebc42e43f4b05504);
  exit_path = 0;
  move_path = undefined;

  if(isDefined(veh_spawner.target) && !istrue(veh_spawner.var_209f3bad98930e61)) {
    move_path = getStruct(veh_spawner.target, "targetname");
  } else {
    move_path = function_607ea2d15b963c30(veh_spawner, veh_spawner.unloadloc);
  }

  if(!istrue(vehicle.var_bb38e84f2964aa8a) && isDefined(veh_spawner.unloadloc)) {
    vehicle thread function_2a0c1b548874c4a6(veh_spawner.unloadloc.origin, heli_type);
  }

  if(isDefined(move_path) && !isDefined(veh_spawner.nopath)) {
    move_path.radius = 50;
    vehicle scripts\common\vehicle_paths::vehicle_paths_helicopter(move_path);
  }

  if(isDefined(vehicle.currentnode) && isDefined(vehicle.currentnode.target)) {
    exit_path = 1;
  }

  if(isDefined(veh_spawner.auto_crash)) {
    vehicle.auto_crash = 1;
  }

  if(!exit_path) {
    vehicle function_ba0a95c33d3dcf7f(vehicle.currentnode, veh_spawner.unloadloc);
  }

  if(getdvarint(@ "hash_691520ae38c53622", 0) != 0) {
    vehicle.maxhealth = getdvarint(@ "hash_691520ae38c53622");
    vehicle.health = vehicle.maxhealth;
  }

  if(isDefined(veh_spawner.var_72772fa651ecbe2b) && isDefined(level.var_a8dc22c62ba69b88[veh_spawner.var_72772fa651ecbe2b])) {
    vehicle thread[[level.var_a8dc22c62ba69b88[veh_spawner.var_72772fa651ecbe2b]]]();
  }

  function_24e5ddbcc6f9f8a3(veh_spawner);
}

function private function_ba0a95c33d3dcf7f(pathnode, var_e740d27647dcd867) {
  self endon("death");
  var_61bec49fd0ba66b6 = function_6c7e1340e878c7d3(pathnode, var_e740d27647dcd867);

  if(!isDefined(var_61bec49fd0ba66b6)) {
    var_61bec49fd0ba66b6 = undefined;

    if(!isDefined(var_61bec49fd0ba66b6)) {
      var_61bec49fd0ba66b6 = random(level.var_27181b4298b7c47f);
    }
  }

  self vehphys_setdefaultmotion();
  ground_pos = getgroundposition(self.origin, 1);

  if(distancesquared(self.origin, ground_pos) <= 1000000) {
    offset = function_858fe3aede740aba(var_61bec49fd0ba66b6, self, 1000, 1000);
    exit_path = spawnStruct();
    exit_path.origin = ground_pos + offset;
    dist = distance(self.origin, exit_path.origin);

    if(dist > 512) {
      exit_path.angles = pathnode.angles;
      exit_path.radius = 512;
      self.var_918c5a31037e00ee = spawnStruct();
      self.var_918c5a31037e00ee.speed = 85;
      thread draw_capsule(exit_path.origin, 32, 32, (0, 0, 0), (0, 1, 0), 0, 250);
      thread scripts\common\vehicle_paths::vehicle_paths_helicopter(exit_path);
      self setneargoalnotifydist(512);
      waittill_any_2("near_goal", "goal");
    }
  }

  self.end_point = var_61bec49fd0ba66b6;
  path_start = var_61bec49fd0ba66b6;
  path_start.radius = 1000;
  self.var_918c5a31037e00ee = spawnStruct();
  self.var_918c5a31037e00ee.speed = 85;
  thread scripts\common\vehicle_paths::vehicle_paths_helicopter(path_start);
}

function private function_6c7e1340e878c7d3(pathnode, var_e740d27647dcd867) {
  org = pathnode.origin;
  dotangles = pathnode.angles;
  var_2b008b868cc6c2f7 = [];

  if(isDefined(var_e740d27647dcd867.script_linkto)) {
    var_2b008b868cc6c2f7 = var_e740d27647dcd867 get_linked_structs();
  }

  if(var_2b008b868cc6c2f7.size == 0) {
    if(isDefined(self.alias)) {
      alias_data = function_2c780304448a233b(self.alias);

      if(isDefined(alias_data.var_fd80c01ac65aedfe)) {
        exits = getStructArray(alias_data.var_fd80c01ac65aedfe, "targetname");
        var_2b008b868cc6c2f7 = sortbydistance(exits, var_e740d27647dcd867.origin);
      }
    }
  }

  if(var_2b008b868cc6c2f7.size == 0) {
    if(level.var_27181b4298b7c47f.size > 0) {
      var_2b008b868cc6c2f7 = sortbydistance(level.var_27181b4298b7c47f, var_e740d27647dcd867.origin);
    }
  }

  if(var_2b008b868cc6c2f7.size == 0) {
    return pathnode;
  }

  best_dot = -5;
  var_14bb0bb2b7d418d7 = undefined;
  sorted_structs = get_array_of_closest(org, var_2b008b868cc6c2f7);

  foreach(struct in sorted_structs) {
    dot = math::get_dot(org, dotangles, struct.origin);

    if(dot > best_dot) {
      best_dot = dot;
      var_14bb0bb2b7d418d7 = struct;
    }
  }

  return var_14bb0bb2b7d418d7;
}

function private function_607ea2d15b963c30(var_a4e4a71852a83d8f, unload_struct) {
  end = 3;
  next_struct = unload_struct;
  struct_path = [];
  struct_path[0] = next_struct;

  for(i = 0; i < end; i++) {
    next_struct = struct_path[i];
    next_struct.script_goalyaw = 1;
    prev_struct = spawnStruct();
    struct_path[i + 1] = prev_struct;

    if(i == 0) {
      zup = 1000;
      magnitude = 1000;
      prev_struct.speed = 10;
      offset = function_858fe3aede740aba(var_a4e4a71852a83d8f, next_struct, zup, magnitude);
    } else if(i == 1) {
      zup = 0;
      magnitude = 750;
      prev_struct.speed = 25;
      offset = function_858fe3aede740aba(var_a4e4a71852a83d8f, next_struct, zup, magnitude);
    } else {
      zup = 0;
      magnitude = 500;
      prev_struct.speed = var_a4e4a71852a83d8f.speed;
      offset = function_858fe3aede740aba(var_a4e4a71852a83d8f, next_struct, zup, magnitude);
    }

    prev_struct.origin = next_struct.origin + offset;
    prev_struct.angles = next_struct.angles;
    prev_struct.radius = 500;
    prev_struct.target = next_struct;
  }

  return struct_path[struct_path.size - 1];
}

function private function_858fe3aede740aba(start_node, end_node, z_val, mag) {
  distance_vector = start_node.origin - end_node.origin;
  offset = vectorNormalize(distance_vector);
  offset *= mag;
  offset = (offset[0], offset[1], z_val);
  return offset;
}

function private function_24e5ddbcc6f9f8a3(startloc) {
  startloc.used = 0;

  if(isDefined(startloc.unloadloc)) {
    startloc.unloadloc.used = 0;
    startloc.unloadloc = undefined;
  }
}

function function_2a0c1b548874c4a6(unloadorigin, helitype) {
  self endon("death");
  pos = getgroundposition(unloadorigin, 1, 1000, 0);
  dist = 500;
  dist_sq = dist * dist;

  while(isDefined(unloadorigin) && distance2dsquared(unloadorigin, self.origin) > dist_sq) {
    wait 0.1;
  }

  wait_time = is_equal(helitype, "little_bird") || is_equal(helitype, "veh_jup_heli_med") ? 1 : 8;
  wait wait_time;
  magicgrenademanual("smoke_grenade_mp", pos, (0, 0, -10), 0.5);
  thread play_sound_in_space("smoke_grenade_expl_trans", self.origin);
}

function function_c23b5f880258a806(veh_spawner) {
  var_e740d27647dcd867 = undefined;

  if(isDefined(veh_spawner.target)) {
    path_array = function_4b6780152e7fc544(getStruct(veh_spawner.target, "targetname"), 1);

    foreach(node in path_array) {
      if(isDefined(node.script_unload)) {
        var_e740d27647dcd867 = node;
      }
    }
  }

  if(!isDefined(var_e740d27647dcd867) && level.var_27181b4298b7c47f.size > 0) {
    unload_locs = sortbydistance(level.var_e71b7bace9f852ce, veh_spawner.origin);
    var_6b1c846c60859605 = [];

    foreach(loc in unload_locs) {
      if(istrue(loc.used)) {
        continue;
      }

      loc.used = 0;
      var_6b1c846c60859605 = array_add(var_6b1c846c60859605, loc);
    }

    var_e740d27647dcd867 = var_6b1c846c60859605[0];
  }

  return var_e740d27647dcd867;
}

function function_940ad0e8afc6f871(locs) {
  if(!isarray(locs)) {
    locs = [locs];
  }

  level.var_e71b7bace9f852ce = array_combine_unique(level.var_e71b7bace9f852ce, locs);
}

function function_e86a7973821ccdc4(locs) {
  if(!isarray(locs)) {
    locs = [locs];
  }

  level.var_27181b4298b7c47f = array_combine_unique(level.var_27181b4298b7c47f, locs);
}

function function_b15a802b4c2c6f75(heli_type) {
  switch (heli_type) {
    case #"hash_835a3b4bb4e34233":
    case #"hash_bc31095b59d83674":
    case #"hash_ca9945ca2bd4d081":
      return true;
    case #"hash_293b5f5fefd56c2c":
    case #"hash_9d4e22a00fc630b5":
    case #"hash_b40eeff172c68887":
      return false;
  }

  return false;
}

function function_641bf5ce20d47b86(heli_type) {
  switch (heli_type) {
    case #"hash_835a3b4bb4e34233":
    case #"hash_b40eeff172c68887":
    case #"hash_bc31095b59d83674":
    case #"hash_ca9945ca2bd4d081":
      return true;
    case #"hash_293b5f5fefd56c2c":
    case #"hash_9d4e22a00fc630b5":
      return false;
  }

  return false;
}

function function_551cd59ad7fc3375(helitype) {
  switch (helitype) {
    case #"hash_835a3b4bb4e34233":
    case #"hash_bc31095b59d83674":
    case #"hash_ca9945ca2bd4d081":
      if(self.vehicle_position == 5 || self.vehicle_position == 6) {
        return true;
      }
    case #"hash_293b5f5fefd56c2c":
    case #"hash_9d4e22a00fc630b5":
      return false;
  }

  return false;
}

function function_5ab30a41cdf6dc06(vehicle, var_a4e4a71852a83d8f, var_ebc42e43f4b05504) {
  vehicle endon("death");
  riders = vehicle.riders;
  vehicle waittill("unloaded");
  vehicle.unloading = 0;
}

function private function_f1c78bfa8c716691() {}

function function_49208aaf95d642dc(heli, start_goal, leave_flag) {
  heli endon("death");
  heli endon("crashing");
  heli endon("leaving");
  heli.rockets_ready = 1;
  heli.has_rockets = 0;
  heli.no_evasive = 1;
  heli.var_edff35a4f2cd74e = 1;
  heli.var_d995749555657b65 = 1;
  heli.nocircle = 0;
  heli.var_8218d9794907e952 = 0;

  if(!isDefined(heli.target_ent)) {
    heli.target_ent = spawn_tag_origin();
    heli.target_ent show();
    heli thread delete_on_death(heli.target_ent);
  }

  heli function_5612623a692d93bd();
  heli thread function_43a6691b3b111bc5(leave_flag);
  heli thread function_980d0bbb82302cc1();
  flag_set("attack_heli_initialized");

  if(isDefined(start_goal)) {
    function_c0565cc728c6d6ab(heli, start_goal);
  }

  level thread function_8de7cf733832427b(heli);

  while(true) {
    if(function_97b0480bb2c85166(heli)) {
      function_3d21334f0aa05c80(heli);
    } else {
      function_1917b6db8e1c3d8(heli);
    }

    wait 0.1;
  }
}

function function_c0565cc728c6d6ab(heli, goal_name) {
  heli endon("death");
  heli endon("crashing");
  heli endon("gained_new_target");
  goal_path = getStruct(goal_name, "targetname");
  heli vehicle_setspeed(50, 20, 20);
  heli setmaxpitchroll(30, 30);
  heli sethoverparams(50, 5, 2.5);
  heli setturningability(0.3);
  heli setyawspeed(100, 40, 40, 0.1);

  while(true) {
    heli vehicle_setspeed(50, 20, 20);
    var_c69f7c6f0406298d = 0;

    if(isDefined(goal_path) && isDefined(goal_path.script_delay)) {
      var_c69f7c6f0406298d = 1;
    }

    heli setvehgoalpos(goal_path.origin, var_c69f7c6f0406298d);
    heli waittill_any_2("goal", "near_goal");

    if(isDefined(goal_path.script_delay)) {
      heli sethoverparams(150, 15, 10);
      heli clearlookatent();
      heli cleartargetyaw();
      heli cleargoalyaw();
      var_592e2a10dbb68dac = int(goal_path.script_delay);

      if(randomint(100) > 75) {
        function_503e74ba5d3e6a9b(heli, var_592e2a10dbb68dac, 1);
      } else {
        function_af2717b19eade30e(heli, var_592e2a10dbb68dac);
      }
    }

    if(!isDefined(goal_path.target)) {
      break;
    }

    goal_path = getStruct(goal_path.target, "targetname");

    if(!isDefined(goal_path)) {
      break;
    }
  }
}

function function_5612623a692d93bd() {
  if(!function_4c52a19676ca8338(self)) {
    return;
  }

  self.var_f31d9f20529f1d15 = 0;
  self.var_bb5f5542e38db179 = level.player spawn_tag_origin();
  self.var_bb5f5542e38db179 setModel("tag_origin_only_collision");
  self.var_bb5f5542e38db179.origin = level.player.origin;
  self.var_bb5f5542e38db179 notsolid();
  self.var_bb5f5542e38db179.health = 999999;
  self.var_bb5f5542e38db179.var_d1f953c063dff1eb = 1;

  thread function_fca4db20a617c3fb(self.var_bb5f5542e38db179, "<dev string:x66>");

  thread function_a92995c66be865a5();
}

function function_a92995c66be865a5() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  while(!isDefined(level.player)) {
    wait 1;
  }

  level.player endon("death");
  childthread function_842a5d20d12f92b2();
  childthread function_4e72bf231ea74017();
  childthread function_c54d8f8b21f22fe6();
  childthread function_21642cdfcb5639b();
  childthread function_bd7f22a2dc3b0d34();
  childthread function_232e6c866a77c3f5();
}

function function_21642cdfcb5639b() {
  while(true) {
    level.player waittill("weapon_fired", objweapon);
    bissilenced = objweapon issilenced();

    if(bissilenced) {
      continue;
    }

    if(distance2d(level.player.origin, self.origin) > 8000) {
      continue;
    }

    self.var_bb5f5542e38db179.origin = level.player.origin;
  }
}

function function_bd7f22a2dc3b0d34() {
  while(true) {
    level.player waittill("grenade_fire");
    wait 5;

    if(distance2d(level.player.origin, self.origin) > 8000) {
      continue;
    }

    self.var_bb5f5542e38db179.origin = level.player.origin;
  }
}

function function_232e6c866a77c3f5() {
  while(true) {
    wait 1;

    if(!level.player scripts\cp_mp\utility\player_utility::isinvehicle()) {
      continue;
    }

    if(distance2d(level.player.origin, self.origin) > 7000) {
      continue;
    }

    function_e80139f7cdf8e252();
    self.var_bb5f5542e38db179.origin = level.player.origin;
  }
}

function function_fca4db20a617c3fb(ent, str) {
  if(getdvarint(@ "hash_b829e1e0eacd17a4", 0) == 0) {
    return;
  }

  ent endon("<dev string:x82>");

  while(true) {
    print3d(ent.origin, str, (1, 1, 1), 1, 1, 5);
    wait 0.25;
  }
}

function function_4c52a19676ca8338(heli) {
  return istrue(heli.var_d995749555657b65);
}

function function_97b0480bb2c85166(heli) {
  if(!function_4c52a19676ca8338(heli)) {
    return false;
  }

  return !istrue(heli.var_f31d9f20529f1d15);
}

function function_c54d8f8b21f22fe6() {
  while(true) {
    wait 0.25;
    var_d476cca618d671c5 = 0;

    if(function_2c6e6b56beec4dc1()) {
      var_d476cca618d671c5 = 1;
    }

    if(function_65bd24e64b7fc311()) {
      var_d476cca618d671c5 = 1;
    }

    if(function_fb46a81c34b9d7de()) {
      var_d476cca618d671c5 = 1;
    }

    if(function_e8001a7628e8c655()) {
      var_d476cca618d671c5 = 1;
    }

    if(function_57b2ccdbb68f66cc()) {
      var_d476cca618d671c5 = 1;
    }

    if(var_d476cca618d671c5 && !istrue(self.var_f31d9f20529f1d15)) {
      function_318516ae478a3957();
    }

    if(!var_d476cca618d671c5 && istrue(self.var_f31d9f20529f1d15)) {
      self notify("lost_target");
    }

    self.var_f31d9f20529f1d15 = var_d476cca618d671c5;
  }
}

function function_842a5d20d12f92b2() {
  while(true) {
    self waittill("damage", amount, attacker, unused, point);

    if(isDefined(attacker) && isPlayer(attacker)) {
      function_6e9f4bd500d5e97c();
    }
  }
}

function function_4e72bf231ea74017() {
  while(true) {
    wait 0.25;

    if(!self.var_f31d9f20529f1d15) {
      results = function_cf7dd37ff1885ce2();

      if(!results) {
        continue;
      }
    } else {
      player_visible = function_5e41e3d667ce3345();

      if(player_visible) {
        self.var_bb5f5542e38db179.origin = level.player.origin;
      }

      if(!player_visible && function_f46bcfa924597743()) {
        continue;
      }
    }

    function_e80139f7cdf8e252();
  }
}

function function_cf7dd37ff1885ce2() {
  start_time = gettime();
  first_test = function_5e41e3d667ce3345();

  if(!first_test) {
    return false;
  }

  while(true) {
    player_visible = function_5e41e3d667ce3345();

    if(!player_visible) {
      return false;
    }

    wait 0.25;

    if(gettime() - start_time > 3000) {
      break;
    }
  }

  return true;
}

function function_5e41e3d667ce3345() {
  fov_angle = 120;

  if(!within_fov(self.origin, self.angles, level.player.origin + (0, 0, 30), cos(fov_angle))) {
    return 0;
  }

  if(distance(self.origin, level.player.origin) > 5000) {
    return 0;
  }

  var_efb844234ac72b75 = level.player getEye();
  contents = scripts\engine\trace::create_all_contents();
  trace = scripts\engine\trace::ray_trace(self.origin, var_efb844234ac72b75, [self], contents, 0, 1, 1);

  if(isDefined(trace["entity"]) && (trace["entity"] == level.player || isDefined(level.player.vehicle) && trace["entity"] == level.player.vehicle)) {
    return 1;
  }

  return 0;
}

function function_f46bcfa924597743() {
  if(!isDefined(self.var_bb5f5542e38db179)) {
    return true;
  }

  if(distance(self.var_bb5f5542e38db179.origin, level.player.origin) > 150) {
    return true;
  }

  return false;
}

function function_6e9f4bd500d5e97c() {
  self.lasttimedamaged = gettime();
}

function function_2c6e6b56beec4dc1() {
  if(!isDefined(self.lasttimedamaged)) {
    return false;
  }

  mtime = 30000;
  curtime = gettime();

  if(self.lasttimedamaged + mtime > curtime) {
    self.var_bb5f5542e38db179.origin = level.player.origin;
    return true;
  }

  return false;
}

function function_e80139f7cdf8e252() {
  self.var_b23181ae41e16b0f = gettime();
}

function function_318516ae478a3957() {
  self notify("gained_new_target");
  self.var_ad4d944cdb8d2e4f = gettime();
}

function function_fb46a81c34b9d7de() {
  if(!isDefined(self.var_ad4d944cdb8d2e4f)) {
    return false;
  }

  mtime = 30000;
  curtime = gettime();

  if(self.var_ad4d944cdb8d2e4f + mtime > curtime) {
    self.var_bb5f5542e38db179.origin = level.player.origin;
    return true;
  }

  return false;
}

function function_65bd24e64b7fc311() {
  if(!isDefined(self.var_b23181ae41e16b0f)) {
    return false;
  }

  mtime = 10000;
  curtime = gettime();

  if(self.var_b23181ae41e16b0f + mtime > curtime) {
    return true;
  }

  return false;
}

function function_e8001a7628e8c655() {
  if(!isDefined(self.var_eb994bdfa396a885) || is_equal(self.var_eb994bdfa396a885, 0)) {
    return false;
  }

  mtime = 60000;

  if(flag("flag_debug_force_spawn_attack_heli")) {
    mtime = 0;
  }

  curtime = gettime();

  if(self.birthtime + mtime > curtime) {
    self.var_bb5f5542e38db179.origin = level.player.origin;
    return true;
  }

  return false;
}

function function_57b2ccdbb68f66cc() {
  if(!ent_flag("ent_flag_combat_ping")) {
    return false;
  }

  mtime = self.var_6cc9eb22d51b59a9 * 1000;
  curtime = gettime();

  if(self.var_8fd13314e32252c9 + mtime > curtime) {
    self.var_bb5f5542e38db179.origin = level.player.origin;
    return true;
  }

  ent_flag_clear("ent_flag_combat_ping");
  return false;
}

function function_a99aeff5794b896c(duration) {
  ent_flag_set("ent_flag_combat_ping");
  self.var_8fd13314e32252c9 = gettime();
  self.var_6cc9eb22d51b59a9 = duration;
}

function private function_1917b6db8e1c3d8(heli) {
  heli endon("death");
  heli endon("lost_target");
  heli endon("crashing");
  heli endon("leaving");
  chopper_height = heli scripts\cp\helicopter\cp_helicopter::function_68c2534a5ea3cd2b();

  if(!istrue(heli.no_evasive)) {
    level thread scripts\cp\helicopter\cp_helicopter::evasive_think(heli);
  }

  heli clearlookatent();
  heli.minigun setmode("manual");
  heli.minigun setturretteam("axis");
  targettimeout = 0;
  timeout = 5;
  heli vehicle_setspeed(50, 30);

  while(true) {
    if(function_97b0480bb2c85166(heli)) {
      valid_target = heli scripts\cp\helicopter\cp_helicopter::heli_get_target();
    } else {
      valid_target = heli.target_ent;
    }

    if(!isDefined(valid_target)) {
      wait 1;
      targettimeout += 1;

      if(targettimeout > timeout) {
        valid_target = heli.best_target;

        if(!isDefined(valid_target)) {
          continue;
        }

        targettimeout = 0;
      } else {
        continue;
      }
    }

    if(heli scripts\cp\helicopter\cp_helicopter::should_move_to_target(heli.minigun, valid_target)) {
      if(!isDefined(heli.gotopos)) {
        heli scripts\cp\helicopter\cp_helicopter::function_ecfae3fe40d58512(valid_target);
      }

      heli thread function_57e8f430a86076f6(valid_target, "stop_continuous_mg");
      heli scripts\cp\helicopter\cp_helicopter::function_875ed67682e3f07a(valid_target, 1);
      heli notify("stop_continuous_mg");
      heli.shooting_minigun = 0;
    }

    if(distance(heli.origin, valid_target.origin) > 4500) {
      continue;
    }

    heli thread scripts\cp\helicopter\cp_helicopter::engage_target_circle_strafe(valid_target, chopper_height);
    heli waittill_any_timeout_1(20, "target_engaged");
    heli.nocircle = 0;
  }
}

function function_57e8f430a86076f6(valid_target, endon_msg) {
  self endon("death");
  self endon("lost_target");
  self endon("crashing");
  self endon("leaving");
  self endon(endon_msg);
  self.minigun settargetentity(valid_target, (0, 0, 40));

  while(true) {
    result = waittill_any_ents_or_timeout_return(3, self.minigun, "turret_on_target");

    if(is_equal(result, "turret_on_target")) {
      break;
    }
  }

  while(true) {
    wait 1;

    if(distance(self.origin, valid_target.origin) > 4500) {
      continue;
    }

    scripts\cp\helicopter\cp_helicopter::shoot_at_target(valid_target);

    while(istrue(self.shooting_minigun)) {
      wait 0.1;
    }

    wait randomintrange(2, 4);
  }
}

function function_3d21334f0aa05c80(heli) {
  heli endon("gained_new_target");
  heli notify("heli_started_searching");
  heli notify("stop_circling");
  search_locations = getStructArray("heli_search_pos", "targetname");

  if(!isDefined(heli.search_pos)) {
    heli.search_pos = spawn("script_origin", (0, 0, 0));
  }

  heli sethoverparams(15, 15, 10);
  heli vehicle_setspeed(0, 10, 10);
  wait randomintrange(4, 8);
  heli notify("heli_started_searching_patrol");
  search_distance = 1000;

  while(true) {
    heli vehicle_setspeed(50, 30);
    chopper_height = heli scripts\cp\helicopter\cp_helicopter::function_68c2534a5ea3cd2b();
    available_locations = sortbydistancecullbyradius(search_locations, heli.var_bb5f5542e38db179.origin, search_distance);
    location = array_random(available_locations);

    if(!isDefined(location)) {
      location = getclosest(heli.var_bb5f5542e38db179.origin, search_locations);
    }

    heli.search_pos.origin = location.origin;
    heli.gotopos = heli.search_pos.origin;
    heli scripts\cp\helicopter\cp_helicopter::function_875ed67682e3f07a(heli.search_pos, 1);

    if(randomint(100) > 75) {
      function_503e74ba5d3e6a9b(heli, 12);
    } else if(randomint(100) > 50) {
      function_af2717b19eade30e(heli, 6);
    }

    search_distance += 500;
  }
}

function function_af2717b19eade30e(heli, duration) {
  heli sethoverparams(150, 15, 10);
  heli vehicle_setspeed(0, 10, 10);

  if(!isDefined(heli.sway_target)) {
    heli.sway_target = spawn("script_origin", heli.origin);
  }

  while(length(heli vehicle_getvelocity()) > 50) {
    wait 0.25;
  }

  heli setlookatent(heli.var_bb5f5542e38db179);
  wait duration;
  heli clearlookatent();
}

function function_503e74ba5d3e6a9b(heli, duration, var_3d0c36a83c4305d) {
  if(!istrue(var_3d0c36a83c4305d)) {
    function_af2717b19eade30e(heli, 6);
  }

  if(!isDefined(heli.sway_target)) {
    heli.sway_target = spawn("script_origin", heli.origin);
  }

  heli sethoverparams(150, 15, 10);
  heli vehicle_setspeed(0, 10, 10);
  var_715de04f46d0c38b = vectorNormalize(anglesToForward(heli.angles));
  var_6997d136eb82b56b = vectorNormalize(anglestoleft(heli.angles));
  var_34df92fdae35a4f8 = vectorNormalize(anglestoright(heli.angles));
  heli_forward = heli.origin + var_715de04f46d0c38b * 500;
  heli_left = heli.origin + var_6997d136eb82b56b * 500;
  heli_right = heli.origin + var_34df92fdae35a4f8 * 500;
  heli.sway_target.origin = heli_forward;
  heli setlookatent(heli.sway_target);
  heli thread notify_delay("sway_timer_ended", duration);
  heli endon("sway_timer_ended");

  while(true) {
    heli.sway_target moveTo(heli_left, 3, 1, 1);
    wait 6;
    heli.sway_target moveTo(heli_forward, 3, 1, 1);
    wait 3;
    heli.sway_target moveTo(heli_right, 3, 1, 1);
    wait 6;
    heli.sway_target moveTo(heli_forward, 3, 1, 1);
    wait 3;
  }

  heli clearlookatent();
}

function notify_delay(snotifystring, fdelay) {
  assert(isDefined(self));
  assert(isDefined(snotifystring));
  assert(isDefined(fdelay));
  self endon("death");

  if(fdelay > 0) {
    wait fdelay;
  }

  if(!isDefined(self)) {
    return;
  }

  self notify(snotifystring);
}

function function_980d0bbb82302cc1() {
  self endon("death");
  self endon("leaving");
  self.target_ent endon("death");

  while(true) {
    wait 0.05;
    new_pos = function_849379c4b0af1608();

    if(!isDefined(new_pos)) {
      continue;
    }

    self.target_ent.origin = new_pos;
  }
}

function function_f6728d9b61e08a68() {
  self endon("death");
  self endon("leaving");

  while(true) {
    minigun_org = self.minigun gettagorigin("tag_flash");
    minigun_angles = self.minigun gettagangles("tag_flash");
    minigun_target = minigun_org + anglesToForward(minigun_angles) * 3500;

    line(minigun_org, minigun_target, (1, 1, 0), 1, 0, 1);

    waitframe();
  }
}

function function_849379c4b0af1608(miss) {
  weaponspeed = int(200);

  if(istrue(self.shooting_minigun)) {
    weaponspeed = int(350);
  }

  ent = function_dc167ebe6403c4b7();

  if(!isDefined(ent)) {
    ent = get_closest_living_player();

    if(!isDefined(ent)) {
      return undefined;
    }
  }

  if(function_97b0480bb2c85166(self)) {
    ent = self.var_bb5f5542e38db179;
  }

  ent endon("death");
  totaldistance = distance(self.origin, ent.origin);
  var_5ed51674a2a22028 = mph_travel_time(weaponspeed, totaldistance);
  maxspeed = 0;

  if(ent isvehicle()) {
    currspeed = 0;
    var_243cc3b50304e6ce = (0, 0, 0);
    maxspeed = 0;
    samples = 2;
    var_2ef08d4cdf09ce9d = 150;
    point1 = undefined;
    point2 = undefined;
    var_f595234b61d94e5c = 0;

    for(i = 0; i < samples; i++) {
      if(i == 0) {
        point1 = ent.origin;
      }

      if(i == samples - 1) {
        point2 = ent.origin;
      }

      currspeed = ent vehicle_getspeed();
      var_f595234b61d94e5c += currspeed;
      maxspeed = max(maxspeed, currspeed);
      waitframe();
    }

    if(istrue(miss)) {
      maxspeed *= 1.25;

      iprintln("<dev string:x88>");
    }

    var_ff8a73939086ebaa = var_f595234b61d94e5c / samples;
    inchespersecond = mph_to_ips(var_ff8a73939086ebaa);
    angles = vectortoangles(point2 - point1);
  } else if(isPlayer(ent)) {
    var_2ef08d4cdf09ce9d = 0;
    inchespersecond = length(ent getvelocity());
    angles = vectortoangles(ent getvelocity());
  } else {
    var_2ef08d4cdf09ce9d = 0;
    inchespersecond = 0;
    angles = ent.angles;
  }

  start = self.origin;
  var_48bd8d850d8a3be6 = inchespersecond * var_5ed51674a2a22028;

  if(function_4c52a19676ca8338(self) && isDefined(self.var_ad4d944cdb8d2e4f) && !isDefined(level.player.vehicle)) {
    var_3215317754272c93 = gettime() - self.var_ad4d944cdb8d2e4f;
    var_f78cd6f4e25a6fe5 = var_3215317754272c93 / 40000;
    var_f78cd6f4e25a6fe5 = 1 - max(min(var_f78cd6f4e25a6fe5, 1), 0);
    var_278020cf0fd66aa3 = 1 + var_f78cd6f4e25a6fe5 * 2.5;
    var_48bd8d850d8a3be6 *= var_278020cf0fd66aa3;
  }

  var_48bd8d850d8a3be6 += var_2ef08d4cdf09ce9d;
  var_48bd8d850d8a3be6 = int(var_48bd8d850d8a3be6);
  var_7bbc01d44d8bfdf1 = ent.origin + anglesToForward(angles) * var_48bd8d850d8a3be6;
  var_dbdb6416d2651728 = getgroundposition(var_7bbc01d44d8bfdf1, 16, 5000, 5000);

  if(ent isvehicle() && ent istouchingpoint(var_dbdb6416d2651728)) {
    var_dbdb6416d2651728 -= (0, 0, 50);
  }

  return var_dbdb6416d2651728;
}

function function_dc167ebe6403c4b7(player, heli) {
  vehicles = [];

  foreach(player in level.players) {
    if(!player scripts\cp_mp\utility\player_utility::isinvehicle()) {
      continue;
    }

    vehicles[vehicles.size] = player.vehicle;
  }

  if(vehicles.size) {
    vehicle = random(vehicles);

    if(!isDefined(vehicle.var_f052a2bf872947b0)) {
      vehicle thread function_68604961afad4a37();
      vehicle.var_f052a2bf872947b0 = 1;
    }

    if(isDefined(heli)) {
      heli.var_8901cb3dfa63e875 = 0;
    }

    return vehicle;
  }

  return undefined;
}

function function_68604961afad4a37() {
  self endon("death");
  level endon("game_ended");
  af = 4300;

  while(true) {
    if(getdvarint(@ "hash_ca939b1c15baa62a", 4000) != 4000) {
      af = getdvarint(@ "hash_ca939b1c15baa62a", 4000);
    }

    fwd = anglesToForward((0, self.angles[1], 0));
    rgt = anglestoright((0, self.angles[1], 0));
    self.var_8c7951652ac9e489 = fwd * af;
    self.var_7406a4b155ec4d92 = rgt * 200 + fwd * af;
    self.var_c7364cbcd79b0831 = rgt * -200 + fwd * af;
    self.var_7d880633d0e7301a = rgt * 350 + fwd * 1000;
    self.var_ddbfda638cec2af9 = rgt * -350 + fwd * 1000;
    self.var_f7222efac2245ca3 = fwd * 3200;
    wait 0.15;
  }
}

function function_43a6691b3b111bc5(leave_flag) {
  self endon("death");
  level endon("game_ended");
  flag_wait("attack_heli_initialized");
  flag_wait(leave_flag);
  self notify("leaving");
  var_5f252c2e0124022e = getStructArray("heli_exit", "targetname");
  exit_pos = sortbydistance(var_5f252c2e0124022e, self.origin)[0];
  exit_target = spawn("script_origin", exit_pos.origin);
  self.gotopos = exit_pos.origin;
  scripts\cp\helicopter\cp_helicopter::function_875ed67682e3f07a(exit_target, 1);
  exit_target delete();
  self delete();
}

function private function_243fc588423c4ce() {}

function function_b2c754e9a9fa71a2(heli, var_facda1cf1315eccf, var_a75db4c1181f06ad, var_68b81540443a122c) {
  heli.minigun setturretteam("allies");
  heli.minigun setmode("manual");
  nextfiretime = gettime();
  target_array = [];
  var_68b81540443a122c = default_to(var_68b81540443a122c, 8);
  var_a75db4c1181f06ad = default_to(var_a75db4c1181f06ad, 3);
  var_facda1cf1315eccf = default_to(var_facda1cf1315eccf, "attack_chopper_lookat_pos");
  var_ca705fecf52f7429 = getStruct(var_facda1cf1315eccf, "targetname");

  if(isDefined(var_ca705fecf52f7429)) {
    var_4ce0b91a3ffa6fa5 = spawn_tag_origin(var_ca705fecf52f7429.origin);
    heli.var_456998ac94c0b6ec = var_4ce0b91a3ffa6fa5;
  }

  heli.firingturret = 0;
  heli.var_a154077d541f57c4 = 0;
  heli thread function_90ccf11b1d026616();
  thread function_294d0fc96d390061(heli, nextfiretime, var_a75db4c1181f06ad);
  heli thread function_cd9e0ece7b32cc2b(var_68b81540443a122c);
}

function function_90ccf11b1d026616() {
  heli = self;
  self endon("death");
  self endon("end_heli_targeting");
  level endon("game_ended");

  while(true) {
    heli.valid_target = heli get_nearby_enemy(heli.patrolstruct.origin + (0, 0, -150), 4000, heli.minigun);

    if(isDefined(heli.valid_target)) {
      var_c1ca92304a345e52 = array_add_safe(heli.potentialtargets, heli);
      var_c1ca92304a345e52 = array_removedead_or_dying(var_c1ca92304a345e52);

      if(!isDefined(function_61aef23379ae7542(var_c1ca92304a345e52, undefined, 0, 4500, undefined, 390))) {
        heli.valid_target = undefined;
      }
    }

    if(!isDefined(heli.valid_target)) {
      heli.minigun cleartargetentity();

      if(isDefined(heli.var_456998ac94c0b6ec)) {
        heli setlookatent(heli.var_456998ac94c0b6ec);
      }
    } else {
      heli.minigun settargetentity(heli.valid_target);
      heli setlookatent(heli.valid_target);
    }

    wait 3;
  }
}

function function_294d0fc96d390061(heli, nextfiretime, var_a75db4c1181f06ad) {
  heli endon("death");
  level endon("game_ended");
  heli.firingturret = 0;
  waitframe();

  while(true) {
    heli.minigun waittill("turret_on_target");

    while(isDefined(heli) && isDefined(heli.var_a154077d541f57c4) && heli.var_a154077d541f57c4) {
      wait 0.5;
    }

    if(!isDefined(heli) || !isDefined(heli.var_a154077d541f57c4)) {
      return;
    }

    if(gettime() > nextfiretime && isDefined(heli.valid_target)) {
      heli.firingturret = 1;

      for(i = 0; i < 15; i++) {
        heli.minigun shootturret("tag_flash");
        wait randomfloatrange(0.1, 0.3);
      }

      heli.firingturret = 0;
      nextfiretime = gettime() + var_a75db4c1181f06ad * 1000;
    }

    wait 1;
  }
}

function function_cd9e0ece7b32cc2b(var_68b81540443a122c) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var_68b81540443a122c)) {
    return;
  }

  waitframe();
  self.minigun waittill("turret_on_target");
  wait 0.5;

  for(nextfiretime = gettime() + 1000; true; nextfiretime = gettime() + var_68b81540443a122c * 1000) {
    while(self.firingturret) {
      wait 0.5;
    }

    for(currenttime = gettime(); currenttime < nextfiretime; currenttime = gettime()) {
      wait 0.5;
    }

    if(isDefined(self.valid_target)) {
      self.target_ent unlink();
      missiletargets = [];
      missiletargets[missiletargets.size] = self.valid_target;
    } else {
      wait 0.5;
      continue;
    }

    self.var_a154077d541f57c4 = 1;

    if(isDefined(self.var_daa912f2a76549f9)) {
      tag = self.var_daa912f2a76549f9;
    } else {
      tag = "tag_gun_l";
    }

    rocket = undefined;
    var_6d259fbb6c14c5d9 = [];
    var_a542d4fb1b75f71b = spawnStruct();
    var_a542d4fb1b75f71b.count = 0;

    foreach(target in missiletargets) {
      if(!isDefined(target)) {
        continue;
      }

      if(istrue(self.abort)) {
        continue;
      }

      end = undefined;
      temp = spawn_tag_origin();

      if(isvector(target)) {
        temp.origin = target;
      } else {
        temp.origin = target.origin;
      }

      waitframe();

      if(!isDefined(target)) {
        continue;
      }

      if(!isDefined(temp.origin)) {
        continue;
      }

      var_bb2614156dd72ed0 = 0;
      nearest_player = getclosest(temp.origin, level.players);

      if(distancesquared(nearest_player.origin, temp.origin) < 202500) {
        var_bb2614156dd72ed0 = 1;
      }

      allies = undefined;

      if(!var_bb2614156dd72ed0) {
        allies = getaiarrayinradius(temp.origin, 450, "allies");
      }

      if(isDefined(allies) && allies.size || istrue(self.abort)) {
        var_bb2614156dd72ed0 = 1;
      }

      if(var_bb2614156dd72ed0) {
        temp delete();
        continue;
      }

      angles = vectortoangles(flat_origin(temp.origin) - flat_origin(self.origin));

      if(!within_fov(flat_origin(self.origin), self.angles, flat_origin(temp.origin), -0.173648)) {
        if(isai(target)) {
          self setlookatent(target);
          self.minigun settargetentity(target);
        } else {
          self setlookatent(temp);
          self.minigun settargetentity(temp);
        }

        waitframe();

        while(!within_fov(flat_origin(self.origin), self.angles, flat_origin(temp.origin), -0.173648)) {
          waitframe();
        }

        if(isDefined(self.var_456998ac94c0b6ec)) {
          self setlookatent(self.var_456998ac94c0b6ec);
        } else {
          self clearlookatent();
        }
      }

      if(!isDefined(temp)) {
        continue;
      }

      for(j = 0; j < 2; j++) {
        speed = self vehicle_getspeed();
        offset = speed * 10;
        start = self gettagorigin(tag) + anglesToForward(self.angles) * offset;
        start -= (0, 0, 69);

        if(isDefined(temp)) {
          if(isDefined(self.rocket_weapon)) {
            rocket = magicbullet(self.rocket_weapon, start, temp.origin);
          } else {
            rocket = magicbullet("iw9_la_rpapa7_mp", start, temp.origin);
          }

          var_a542d4fb1b75f71b.count++;
          var_8ae0bdbda627f4a2 = temp.origin;
          rocket thread delete_on_death(temp);
          rocket thread function_3f7c0a28e08489b9(target, var_a542d4fb1b75f71b, self);
          var_6d259fbb6c14c5d9[var_6d259fbb6c14c5d9.size] = rocket;
        }

        wait randomfloatrange(0.25, 0.5);
      }

      if(isDefined(self.var_daa912f2a76549f9) && isDefined(self.var_daa92cf2a7658327)) {
        tag = ter_op(tag == self.var_daa912f2a76549f9, self.var_daa92cf2a7658327, self.var_daa912f2a76549f9);
      } else {
        tag = ter_op(tag == "tag_gun_l", "tag_gun_r", "tag_gun_l");
      }

      if(i == missiletargets.size - 1) {
        break;
      }

      wait 0.35;
    }

    start = gettime();

    while(var_a542d4fb1b75f71b.count != 0 && gettime() - start > 5000) {
      wait 0.5;
    }

    wait 0.5;
    self.var_a154077d541f57c4 = 0;
  }
}

function function_3f7c0a28e08489b9(target, tempstruct, heli) {
  self waittill("death");
  tempstruct.count--;

  if(!isDefined(self)) {
    return;
  }

  impactorigin = self.origin;
  earthquake(0.35, 0.45, impactorigin, 4000);
  nearest_players = get_array_of_closest(impactorigin, level.players);

  if(isDefined(nearest_players)) {
    foreach(nearest_player in nearest_players) {
      nearest_player playRumbleOnEntity("damage_heavy");
    }
  }

  waitframe();

  if(!isDefined(target)) {
    return;
  }

  if(!function_d6c65a66f59242a4(target) && function_f60b16bd3ca5fa28(target)) {
    if(istrue(target.magic_bullet_shield)) {
      return;
    }

    damage = undefined;

    if(isai(target)) {
      damage = target.health;
    } else if(target scripts\common\vehicle::isvehiclealive()) {
      if(isDefined(target.healthbuffer)) {
        damage = target.health - target.healthbuffer + 1;
      } else {
        damage = target.health + 1;
      }
    }

    assert(isDefined(damage));

    if(isDefined(heli.rocket_weapon)) {
      target dodamage(damage, target.origin, heli, undefined, "MOD_EXPLOSIVE", heli.rocket_weapon);
      return;
    }

    target dodamage(damage, target.origin, heli, undefined, "MOD_EXPLOSIVE", "iw9_la_rpapa7_mp");
  }
}

function private function_d605dba16917dd24() {}

function function_d2ee055dc4ce18d4() {
  self notify("crashing");
  self notify("newpath");
  self notify("deathspin");
  self.crashing = 1;
  scripts\common\vehicle_code::vehicle_setcrashing(1);

  if(isDefined(self.headicon)) {
    deleteheadicon(self.headicon);
    self.headicon = undefined;
  }

  utility::function_3677f2be30fdd581("running_lights", "off");
  utility::function_3677f2be30fdd581("infil_lights", "off");
  utility::function_3677f2be30fdd581("NaviLights", "off");
  utility::function_3677f2be30fdd581("interior_light", "off");
  utility::function_3677f2be30fdd581("pilot_cockpit_light", "off");
  utility::function_3677f2be30fdd581("co_pilot_cockpit_light", "off");
  utility::function_3677f2be30fdd581("blinking_lights", "off");
  utility::function_3677f2be30fdd581("blinking_light", "off");
  utility::function_3677f2be30fdd581("tail_light", "off");
  utility::function_3677f2be30fdd581("cockpit_light", "off");
  scripts\common\vehicle_code::detach_getoutrigs();
}

function function_882f3ddd49a7fc42() {
  level endon("game_ended");
  waittill_any_2("death", "end_heli_patrol");
  level.incomingallchoppergunners--;
}

function function_8de7cf733832427b(heli) {
  heli endon("<dev string:x82>");

  if(getdvarint(@ "hash_b829e1e0eacd17a4", 0) == 0) {
    return;
  }

  x_offset = -50;
  childthread function_88faeeceb64d43af(heli);
  childthread function_5ae56bbab07c8776(x_offset, 150, &function_12b58133ffd214d6, heli);
  childthread function_5ae56bbab07c8776(x_offset, 165, &function_1d29fd6162ed61a1, heli);
  childthread function_5ae56bbab07c8776(x_offset, 180, &function_b35b184c6f051ae2, heli);
  childthread function_5ae56bbab07c8776(x_offset, 195, &function_41f5f67e423ec4cd, heli);
  childthread function_5ae56bbab07c8776(x_offset, 210, &function_a6ccf4e8e2d25f18, heli);
  childthread function_5ae56bbab07c8776(x_offset, 225, &function_b8ff2bac0098fb4d, heli);
}

function function_88faeeceb64d43af(heli) {
  while(true) {
    msg = heli.minigun waittill_any_timeout_1(1, "<dev string:x8d>");

    if(msg == "<dev string:x9e>") {
      heli ent_flag_clear("<dev string:x8d>");
      continue;
    }

    heli ent_flag_set("<dev string:x8d>");
  }
}

function function_12b58133ffd214d6(heli) {
  return "<dev string:xa6>" + heli.var_f31d9f20529f1d15;
}

function function_1d29fd6162ed61a1(heli) {
  return "<dev string:xbd>" + heli.health_remaining;
}

function function_b35b184c6f051ae2(heli) {
  shooting_minigun = heli.shooting_minigun;

  if(!isDefined(shooting_minigun)) {
    shooting_minigun = 0;
  }

  return "<dev string:xc6>" + shooting_minigun;
}

function function_41f5f67e423ec4cd(heli) {
  return "<dev string:xd7>" + heli ent_flag("<dev string:x8d>");
}

function function_a6ccf4e8e2d25f18(heli) {
  distance_to_target = distance(heli.target_ent.origin, heli.origin);
  return "<dev string:xeb>" + distance_to_target;
}

function function_b8ff2bac0098fb4d(heli) {
  return "<dev string:xfd>" + heli function_5e41e3d667ce3345();
}

function private function_5ae56bbab07c8776(x, y, var_2e13c5e7a5393831, param) {
  text = newhudelem();
  width = 350;
  text.alignx = "<dev string:x10e>";
  text.aligny = "<dev string:x113>";
  text.x = x;
  text.y = y;
  text.sort = 5;
  text.fontscale = 1;
  text.alpha = 0.5;
  text.archived = 0;
  instances_allowed = 20;

  for(current_instances = 0; true; current_instances = 0) {
    text setdevtext([[var_2e13c5e7a5393831]](param));

    wait 0.1;
    current_instances++;

    if(current_instances > instances_allowed) {
      text clearalltextafterhudelem();
    }
  }
}

function private function_4732f688344dbdec() {}

function function_bf9918e38554b480(attacker) {
  function_d2ee055dc4ce18d4();

  if(isDefined(self.riders)) {
    foreach(rider in self.riders) {
      rider.dropweapon = 0;
    }
  }

  function_42dd0521f08a1e8b(self.origin);
  waitframe();
  scripts\common\vehicle_code::vehicle_setcrashing(0);
  scripts\common\vehicle_paths::delete_riders();
  self delete();
}

function private function_ad0f6c511ccba3e7() {}

function function_378ede9ff9410fdc(pos) {
  if(isDefined(self.vehiclename) && !istrue(self.var_6f9bee9664b1b3e3) && scripts\cp_mp\vehicles\vehicle::function_89dc39dc11f3988c(self.vehiclename)) {
    scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
    return;
  }

  playFX(getfx("vfx_blima_explosion_ground"), pos);
  playsoundatpos(pos, "cp_blima_expl_corpse");
}

function function_42dd0521f08a1e8b(pos) {
  if(isDefined(self.vehiclename) && !istrue(self.var_6f9bee9664b1b3e3) && scripts\cp_mp\vehicles\vehicle::function_89dc39dc11f3988c(self.vehiclename)) {
    scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
    return;
  }

  playFX(getfx("helidown_rpghit"), pos);
  playsoundatpos(pos, "cp_blima_expl_air");
}

function private function_b404721db1a7c1fc() {}

function function_97b00cd33ff5cfd8(attacker) {
  function_d2ee055dc4ce18d4();
  function_42dd0521f08a1e8b(self.origin);

  if(isDefined(attacker) && isPlayer(attacker)) {
    self.original_attacker = attacker;
  }

  if(istrue(self.vehicle_skipdeathcrash)) {
    self notify("death", attacker, "MOD_EXPLOSIVE", undefined, self.origin);
    scripts\common\vehicle_paths::delete_riders();
    self delete();
    return;
  }

  crash_loc = function_675c274a9e8d73da();
  self.crashloc = crash_loc;

  if(!isDefined(self.crash_speed)) {
    self.crash_speed = 150;
  }

  if(!isDefined(self.crash_accel)) {
    self.crash_accel = 40;
  }

  if(!isDefined(self.crash_decel)) {
    self.crash_decel = 60;
  }

  self.crash_speed = getdvarint(@ "hash_3bb964b2683ffa4f", self.crash_speed);
  self.crash_accel = getdvarint(@ "hash_440a4c558381b194", self.crash_accel);
  self.crash_decel = getdvarint(@ "hash_42b9fe6249d1673d", self.crash_decel);

  if(!isDefined(crash_loc.radius)) {
    crash_loc.radius = 350;
  }

  if(soundexists("hind_helicopter_dying_loop")) {
    self playLoopSound("hind_helicopter_dying_loop");
  }

  self clearlookatent();
  thread function_8371c80117bccb7(attacker);

  if(self.crash_style == "rotate" || self.crash_style == "auto_navmesh" || self.crash_style == "auto_ground" || self.crash_style == "rotate_in_air_explode") {
    thread function_b1ef346e3f64ed68(crash_loc.origin);
  } else if(self.crash_style == "directed") {
    thread function_d785023069ac80bb(crash_loc.origin);
  } else if(self.crash_style == "zigzag") {
    thread function_cf233d42a30985c3(crash_loc.origin);
  }

  thread function_5a90c3f90dad0869(crash_loc.origin);

  if(isDefined(self.crash_timeout)) {
    thread function_eaba742808136968(self.crash_timeout);
  }

  msg = waittill_any_return_2("heli_death_crash_timeout", "heli_death_impact_ground");

  if(!isDefined(msg) || is_equal(msg, "heli_death_impact_ground")) {
    function_378ede9ff9410fdc(crash_loc.origin);
  } else {
    function_42dd0521f08a1e8b(self.origin);
  }

  self stoploopsound();
  self notify("death", attacker, "MOD_EXPLOSIVE", undefined, self.origin);
  scripts\common\vehicle_paths::delete_riders();

  if(istrue(self.var_a446c274174c1268) || getdvarint(@ "hash_ba8282e1a78ac163", 1) > 0) {
    function_a977d4c89fc61d28(crash_loc);
  }

  scripts\common\vehicle_code::vehicle_setcrashing(0);
  self notify("vehicle_deathComplete", self.origin, self.angles);
  self delete();
}

function function_a977d4c89fc61d28(crash_loc) {
  corpse_model = "veh9_mil_air_ahotel64_dst_cp";
  var_7ebe80cccf82fbe6 = "veh9_mil_air_ahotel64_tail_dst_cp";

  if(isDefined(self.corpse_model)) {
    corpse_model = self.corpse_model;
  }

  if(isDefined(self.var_7ebe80cccf82fbe6)) {
    var_7ebe80cccf82fbe6 = self.var_7ebe80cccf82fbe6;
  }

  trace = scripts\engine\trace::ray_trace(self.origin + (0, 0, 100), crash_loc.origin + (0, 0, -10), [self]);
  corpse = spawn("script_model", trace["position"] + (0, 0, -10));
  corpse.angles = (trace["normal"][0], self.angles[1], trace["normal"][2]);
  corpse setModel(corpse_model);
  corpse.tail = spawn("script_model", corpse.origin + anglesToForward(corpse.angles) * -285 + anglestoright(corpse.angles) * 50);
  corpse.tail setModel(var_7ebe80cccf82fbe6);
  trace = scripts\engine\trace::ray_trace(corpse.tail.origin + (0, 0, 100), corpse.tail.origin + (0, 0, -100), [corpse, corpse.tail, self]);
  corpse.tail.angles = (trace["normal"][0], corpse.angles[1], trace["normal"][2]);
  corpse.tail.origin = trace["position"] + (0, 0, -5);
  corpse thread function_50fb3d8ba61f0f28();
}

function function_a083214e51cbcee9(locs) {
  if(!isarray(locs)) {
    locs = [locs];
  }

  level.vehicle.helicopter_crash_locations = array_combine_unique(level.vehicle.helicopter_crash_locations, locs);
}

function function_675c274a9e8d73da() {
  var_d37bf5f45da067eb = ["zigzag", "directed", "rotate", "auto_ground", "auto_navmesh"];
  var_d39dfcf08c9638ee = default_to(self.crash_style, "auto_navmesh");

  if(istrue(self.auto_crash)) {
    var_d39dfcf08c9638ee = "auto_ground";
  }

  if(var_d39dfcf08c9638ee == "random") {
    var_d39dfcf08c9638ee = random(var_d37bf5f45da067eb);
    self.crash_style = var_d39dfcf08c9638ee;
  }

  crash_loc = undefined;

  if(var_d39dfcf08c9638ee == "auto_navmesh") {
    ground_pos = getclosestpointonnavmesh(self.origin);
    pos = spawnStruct();
    pos.origin = ground_pos;
    pos.angles = (0, 0, 0);
    crash_loc = pos;
  } else if(var_d39dfcf08c9638ee == "auto_ground") {
    position = anglestoright(self.angles) * randomintrange(-500, 500);
    groundpos = getgroundposition(self.origin + position, 128, 5000);
    pos = spawnStruct();
    pos.origin = groundpos;
    pos.angles = (0, 0, 0);
    crash_loc = pos;
  } else if(isDefined(self.preferred_crash_location)) {
    crash_loc = self.preferred_crash_location;
  } else if(isDefined(level.vehicle.var_4bd4e750e5a8e895)) {
    crash_loc = [[level.vehicle.var_4bd4e750e5a8e895]](self);
  } else {
    assertex(level.vehicle.helicopter_crash_locations.size > 0, "A helicopter tried to crash but you didn't have any script_origins with targetname helicopter_crash_location in the level");
    unusedlocations = scripts\common\vehicle_code::get_unused_crash_locations();
    assertex(unusedlocations.size > 0, "You dont have enough script_origins with targetname helicopter_crash_location in the level");
    crash_loc = getclosest(self.origin, unusedlocations);
  }

  crash_loc.claimed = 1;
  return crash_loc;
}

function function_50fb3d8ba61f0f28() {
  utility::function_3677f2be30fdd581("stage3", "on");
  self.tail utility::function_3677f2be30fdd581("stage3", "on");
  wait 30;
  function_378ede9ff9410fdc(self.origin);
  self.tail delete();
  self delete();
}

function function_5a90c3f90dad0869(pos) {
  self endon("death");
  self endon("heli_death_crash_timeout");
  deathfx = 0;

  while(distance(self.origin, pos) > 200) {
    if(distance(self.origin, pos) < 350 && !deathfx) {
      deathfx = 1;
    }

    wait 0.05;
  }

  self notify("heli_death_impact_ground");
}

function function_eaba742808136968(timeout) {
  self endon("death");
  self endon("heli_death_impact_ground");
  wait timeout;
  self notify("heli_death_crash_timeout");
}

function function_8371c80117bccb7(attacker) {
  self endon("in_air_explosion");
  self endon("heli_death_crash_timeout");
  crashloc = self.crashloc;
  indirect_zoff = 0;
  direct = 0;

  if(isDefined(crashloc.script_parameters) && crashloc.script_parameters == "direct") {
    direct = 1;
  }

  if(isDefined(self.heli_crash_indirect_zoff)) {
    direct = 0;
    indirect_zoff = self.heli_crash_indirect_zoff;
  }

  if(direct) {
    self vehicle_setspeed(self.crash_speed, self.crash_accel, self.crash_decel);
    self setneargoalnotifydist(crashloc.radius);
    self setvehgoalpos(crashloc.origin, 0);
    waittill_any_2("goal", "near_goal");
    function_ce82963d678f419e(crashloc);
  } else {
    indirect_target = (crashloc.origin[0], crashloc.origin[1], self.origin[2] + indirect_zoff);

    if(isDefined(self.heli_crash_lead)) {
      indirect_target = self.origin + self.heli_crash_lead * self vehicle_getvelocity();
      indirect_target = (indirect_target[0], indirect_target[1], indirect_target[2] + indirect_zoff);
    }

    self vehicle_setspeed(self.crash_speed, self.crash_accel, self.crash_decel);
    self setneargoalnotifydist(350);
    self setvehgoalpos(indirect_target, 1);

    for(msg = "blank"; msg != "death"; msg = "death") {
      msg = waittill_any_return_3("goal", "near_goal", "death");

      if(!isDefined(msg) && !isDefined(self)) {
        crashloc.claimed = undefined;
        self notify("vehicle_crashDone");
        return;
      }
    }

    if(getdvarint(@ "hash_38043388d6ad9578", 0) == 1) {
      sphere(indirect_target, 1, (1, 1, 0), undefined, 200000);
    }

    self setvehgoalpos(crashloc.origin, 0);
    waittill_any_2("goal", "near_goal");
    function_ce82963d678f419e(crashloc);
  }

  crashloc.claimed = undefined;
  self notify("stop_crash_loop_sound");
  self notify("vehicle_crashDone");
}

function function_ce82963d678f419e(dest) {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(dest.target)) {
    dest = getStruct(dest.target, "targetname");
    assert(isDefined(dest));
    radius = 56;

    if(isDefined(dest.radius)) {
      radius = dest.radius;
    }

    self setneargoalnotifydist(radius);
    self setvehgoalpos(dest.origin, 0);
    waittill_any_2("goal", "near_goal");
  }
}

function function_b1ef346e3f64ed68(pos) {
  self endon("death");
  self endon("vehicle_crashDone");
  self setmaxpitchroll(60, 90);
  self setyawspeed(700, 200, 200);

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    irand = randomintrange(140, 170);
    self settargetyaw(self.angles[1] + irand);
    wait 0.5;
  }
}

function function_d785023069ac80bb(pos) {
  self endon("vehicle_crashDone");
  self setmaxpitchroll(randomintrange(20, 90), randomintrange(5, 90));
  self setyawspeed(400, 100, 100);
  angleoff = 90 * randomintrange(-2, 3);

  for(;;) {
    totarget = pos - self.origin;
    yaw = vectortoyaw(totarget);
    yaw += angleoff;
    self settargetyaw(yaw);
    wait 0.1;
  }
}

function function_cf233d42a30985c3(pos) {
  self endon("vehicle_crashDone");
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

function function_42f32038d8ff20bb(heli) {
  offset_increment = 10;
  offset_num = 0;

  while(true) {
    if(!isDefined(heli)) {
      return;
    }

    print3d(heli.origin + (0, 0, offset_increment * offset_num), "<dev string:x11a>", function_5ad81bf829387427(heli.auto_crash), 1, 0.5, 1, 1);
    offset_num++;
    print3d(heli.origin + (0, 0, offset_increment * offset_num), "<dev string:x124>", function_5ad81bf829387427(heli.nocrash), 1, 0.5, 1, 1);
    offset_num++;
    print3d(heli.origin + (0, 0, offset_increment * offset_num), "<dev string:x12c>", function_5ad81bf829387427(heli.vehicle_skipdeathmodel), 1, 0.5, 1, 1);
    offset_num++;
    print3d(heli.origin + (0, 0, offset_increment * offset_num), "<dev string:x143>", function_5ad81bf829387427(heli.death_fx_on_self), 1, 0.5, 1, 1);
    offset_num++;
    print3d(heli.origin + (0, 0, offset_increment * offset_num), "<dev string:x154>", function_5ad81bf829387427(heli.vehicle_forcerocketdeath), 1, 0.5, 1, 1);
    offset_num++;
    print3d(heli.origin + (0, 0, offset_increment * offset_num), "<dev string:x16d>", function_5ad81bf829387427(heli.crashing), 1, 0.5, 1, 1);
    offset_num++;
    print3d(heli.origin + (0, 0, offset_increment * offset_num), "<dev string:x176>", function_5ad81bf829387427(heli.vehiclecrashing), 1, 0.5, 1, 1);
    offset_num++;
    print3d(heli.origin + (0, 0, offset_increment * offset_num), "<dev string:x186>", function_5ad81bf829387427(heli.var_a446c274174c1268), 1, 0.5, 1, 1);
    offset_num++;
    print3d(heli.origin + (0, 0, offset_increment * offset_num), "<dev string:x192>", function_5ad81bf829387427(heli.vehicle_skipdeathcrash), 1, 0.5, 1, 1);
    offset_num++;

    if(isDefined(heli.preferred_crash_style)) {
      print3d(heli.origin + (0, 0, offset_increment * offset_num), "<dev string:x1a9>" + heli.preferred_crash_style, (1, 1, 1), 1, 0.5, 1, 1);
      offset_num++;
    }

    if(isDefined(heli.crash_speed)) {
      print3d(heli.origin + (0, 0, offset_increment * offset_num), "<dev string:x1bf>" + heli.crash_speed, (1, 1, 1), 1, 0.5, 1, 1);
      offset_num++;
    }

    if(isDefined(heli.heli_crash_lead)) {
      print3d(heli.origin + (0, 0, offset_increment * offset_num), "<dev string:x1cb>" + heli.heli_crash_lead, (1, 1, 1), 1, 0.5, 1, 1);
      offset_num++;
    }

    if(isDefined(heli.heli_crash_indirect_zoff)) {
      print3d(heli.origin + (0, 0, offset_increment * offset_num), "<dev string:x1db>" + heli.heli_crash_indirect_zoff, (1, 1, 1), 1, 0.5, 1, 1);
      offset_num++;
    }

    if(isDefined(heli.crashloc)) {
      radius = default_to(heli.crashloc.radius, 256);
      sphere(heli.crashloc.origin, radius, (1, 0, 0), undefined, 1);
      direct = isDefined(heli.crashloc.script_parameters) && heli.crashloc.script_parameters == "<dev string:x1f4>";
      print3d(heli.crashloc.origin + (0, 0, 10), "<dev string:x1fb>", ter_op(istrue(direct), (0, 1, 0), (1, 0, 0)), 1, 0.5, 1, 1);
    }

    foreach(crash_loc in level.vehicle.helicopter_crash_locations) {
      if(is_equal(crash_loc, heli.crashloc)) {
        continue;
      }

      radius = default_to(crash_loc.radius, 256);
      sphere(crash_loc.origin, radius, (1, 0, 0), undefined, 1);
      direct = isDefined(crash_loc.script_parameters) && crash_loc.script_parameters == "<dev string:x1f4>";
      print3d(crash_loc.origin + (0, 0, 10), "<dev string:x1fb>", ter_op(istrue(direct), (0, 1, 0), (1, 0, 0)), 1, 0.5, 1, 1);
    }

    offset_num = 0;
    waitframe();
  }
}

function function_5ad81bf829387427(option) {
  color_on = (0, 1, 0);
  color_off = (1, 0, 0);

  if(istrue(option)) {
    return color_on;
  }

  return color_off;
}

function private function_e912975270a0233() {}

function function_78ed4539c554909d(veh_spawner, team, var_e6678f57993a5439, skip_init, make_sentient) {
  drone = undefined;
  drone_type = "heli_non_phys";
  team = default_to(team, "allies");
  var_e6678f57993a5439 = default_to(var_e6678f57993a5439, 1);
  make_sentient = default_to(make_sentient, 0);
  owner = ter_op(team == "allies", level.player, undefined);
  var_6bd7f9597d80ab26 = "veh_jup_ai_recon_drone_mp";
  var_28d7d1da6479ad7a = "veh_jup_ai_recon_drone_physics_mp";
  model_name = "veh9_mil_air_drone_recon_large_mp";
  veh_type = ter_op(issubstr(drone_type, "_non_phys"), var_6bd7f9597d80ab26, var_28d7d1da6479ad7a);

  if(drone_type == "heli_non_phys" || drone_type == "heli_phys") {
    drone = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, veh_spawner.origin, veh_spawner.angles, veh_type, model_name);
  } else if(drone_type == "veh_phys" || drone_type == "veh_non_phys") {
    spawn_data = spawnStruct();
    spawn_data.origin = veh_spawner.origin;
    spawn_data.angles = veh_spawner.angles;
    spawn_data.targetname = "test_ai_drone";
    spawn_data.vehicletype = ter_op(drone_type == "ally_veh_non_phys", var_6bd7f9597d80ab26, var_28d7d1da6479ad7a);
    spawn_data.owner = owner;
    spawn_data.modelname = model_name;
    drone = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawn_data);
  }

  if(isDefined(drone)) {
    drone.vehicle_spawner = veh_spawner;

    if(!istrue(skip_init)) {
      function_8accc895d6de3a7d(drone, var_e6678f57993a5439, team, owner, make_sentient);
    }
  }

  return drone;
}

function function_8accc895d6de3a7d(drone, var_e6678f57993a5439, drone_team, owner, make_sentient) {
  drone.health = 130;
  drone.maxhealth = 130;
  drone.currenthealth = 130;
  drone.damagetaken = 0;
  drone.speed = 45;
  drone.accel = 20;

  if(isDefined(owner)) {
    drone.owner = owner;
    drone setotherent(owner);
  }

  drone.team = drone_team;
  drone setvehicleteam(drone.team);
  drone.stunned = 0;
  drone.inactive = 0;
  drone.vehiclename = "jup_ai_recon_drone";
  drone.streakname = "jup_ai_recon_drone";
  drone.attract_strength = 10000;
  drone.attract_range = 150;
  drone.attractor = missile_createattractorent(drone, drone.attract_strength, drone.attract_range);

  if(drone.team == "axis") {
    level thread scripts\cp\weapon::add_to_special_lockon_target_list(drone);
    drone thread helicopter_death_lockon_clear();
  }

  drone vehicle_invoketriggers(1);
  drone vehicle_breakglass(1);
  drone vehicle_setspeed(drone.speed, drone.accel, drone.accel);
  drone setyawspeedbyname("faster");
  drone setmaxpitchroll(25, 50);
  drone sethoverparams(130, 10, 5);
  drone setturningability(1);
  drone setdroneturnparams(50, 1.3, 30, 20);
  drone setneargoalnotifydist(16);

  if(make_sentient) {
    drone scripts\mp\sentientpoolmanager::registersentient("Lethal_Moving", drone.team);
  }

  drone setCanDamage(1);

  if(issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData")) {
    [[getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](drone.streakname, 1);
  }

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]]("emp_grenade_mp", 1, 1, drone.streakname);
  }

  if(issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    drone[[getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](drone.streakname, &scripts\cp_mp\killstreaks\helper_drone::function_caf721cb23374e2b);
  }

  drone scripts\cp\vehicles\damage_cp::set_death_callback(drone.streakname, &function_ee844586cce0ea38);

  if(!isDefined(drone.damagestates)) {
    drone.damagestates = [];
    drone.currentdamagestate = 0;
  }

  drone.damagestates[1] = spawnStruct();
  drone.damagestates[1].damageamount = drone.maxhealth * 0.75;
  drone.damagestates[1].damagestatefunc = &scripts\cp_mp\killstreaks\helper_drone::function_f6914d06b20aee20;
  drone.damagestates[2] = spawnStruct();
  drone.damagestates[2].damageamount = drone.maxhealth * 0.5;
  drone.damagestates[2].damagestatefunc = &scripts\cp_mp\killstreaks\helper_drone::function_3ad98c4f7524b525;
  drone.damagestates[3] = spawnStruct();
  drone.damagestates[3].damageamount = drone.maxhealth * 0.25;
  drone.damagestates[3].damagestatefunc = &scripts\cp_mp\killstreaks\helper_drone::function_e68a206899cafbe5;
  drone thread function_1ce855b5c723ec51();

  if(istrue(var_e6678f57993a5439)) {
    namespace_548a10c405703106::function_4f0e1fcf2e24ebe8(drone, drone.team);
  }

  drone utility::function_3677f2be30fdd581("lights", "on");
  drone utility::function_3677f2be30fdd581("glint", "on");
  drone thread function_3ce09e703e77c662();
  drone thread function_e5f3d97edea5c765();
}

function function_ee844586cce0ea38(data) {
  if(!isDefined(self) || istrue(self.isdestroyed)) {
    return;
  }

  if(isDefined(data) && isDefined(data.inflictor) && isDefined(data.inflictor.weapon_name) && (data.inflictor.weapon_name == "shock_stick_mp" || data.inflictor.weapon_name == "jup_shock_stick_cp")) {
    thread function_501fc660dee28156(data);
  } else {
    thread function_1a7e381449637ab4(1);
  }

  return 0;
}

function function_501fc660dee28156(data) {
  self.isdestroyed = 1;
  self.var_d31453e33d3e34ca = 1;

  if(istrue(self.repeatuse)) {
    self.repeatuse = 0;
  }

  var_ecb39c9eecbd70ad = 3000;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 1, 0, 0, 0);
  castend = self.origin + anglestoup(self.angles) * var_ecb39c9eecbd70ad * -1 + (randomintrange(-500, 500), 0, randomintrange(-500, 500));
  trace = scripts\engine\trace::ray_trace(self.origin, castend, [self]);
  target_origin = trace["position"] + trace["normal"] * 5;
  maxvelocity = getdvarfloat(@ "hash_44e62153228221f", 30.2);
  acceleration = getdvarfloat(@ "hash_cdb03278c6d17e78", 13.8);
  deceleration = getdvarfloat(@ "hash_ed85baf3072c3fff", 17.2);
  var_f9ca3f557a387549 = getdvarfloat(@ "hash_3f6d20d42a18063b", 2500);
  distance = distance(target_origin, self.origin);
  falltime = sqrt(2 * distance / acceleration);
  falltime = min(falltime, 2) - 0.2;
  self vehicle_setspeed(maxvelocity, acceleration, deceleration);
  self setvehgoalpos(target_origin, 0);
  thread scripts\cp_mp\killstreaks\helper_drone::function_9bfdff1ee5a47652();
  time = 0;

  while(true) {
    if(distancesquared(self.origin, target_origin) <= var_f9ca3f557a387549 || time >= falltime) {
      function_8d995a68bc0a3f63(data);
      break;
    }

    time += level.framedurationseconds;
    waitframe();
  }
}

function function_8d995a68bc0a3f63(data) {
  if(isDefined(data.inflictor) && isDefined(data.inflictor.stuckto)) {
    data.inflictor notify("forceDeath");
  }

  if(isDefined(self.var_75bb433488d96804)) {
    self.owner cameraunlink();
    self.var_75bb433488d96804 delete();
    self.var_75bb433488d96804 = undefined;
  }

  thread function_1a7e381449637ab4(1);
}

function function_1a7e381449637ab4(wasdestroyed, wasexited, wastimedout, wasdetonated) {
  self.isdestroyed = 1;

  if(isDefined(self.targetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.targetmarkergroup);
    self.targetmarkergroup = undefined;
  }

  if(isDefined(self.minimapid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.minimapid);
    self.minimapid = undefined;
  }

  if(issharedfuncdefined("game", "clearOOB")) {
    [[getsharedfunc("game", "clearOOB")]](self, 1);
  }

  scripts\cp_mp\emp_debuff::clear_emp(1);
  scripts\cp_mp\killstreaks\helper_drone::function_24085a0230958938();
  scripts\cp_mp\emp_debuff::allow_emp(0);
  self notify("explode");
  wait 0.2;
  function_e8005d4d7f8a002f(self.helperdronetype, wasdestroyed);
}

function function_e8005d4d7f8a002f(dronetype, wasdestroyed, dronevel, dronehealth) {
  if(isDefined(self.radar)) {
    self.radar delete();
  }

  self.ispiloted = undefined;
  self.repeatuse = undefined;

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  if(isDefined(self.playersfx)) {
    self.playersfx delete();
  }

  if(isDefined(self.scrambler)) {
    self.scrambler delete();
  }

  if(isDefined(self.enemyobjid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.enemyobjid);
  }

  if(isDefined(self.pulsedarts) && self.pulsedarts.size > 0) {
    foreach(pulsedart in self.pulsedarts) {
      pulsedart notify("death");
    }
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function function_e5f3d97edea5c765() {
  if(isDefined(self.vehicle_spawner) && isDefined(self.vehicle_spawner.target)) {
    first_node = getStruct(self.vehicle_spawner.target, "targetname");
    scripts\common\vehicle_paths::vehicle_paths_helicopter(first_node);
  }
}

function function_3ce09e703e77c662() {}

function function_1ce855b5c723ec51() {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  level waittill_any_2("bro_shot_start", "game_ended");
  function_ee844586cce0ea38();
}

function private function_7ecf77ee33070752() {}

function function_2c780304448a233b(alias_name) {
  if(!isDefined(alias_name)) {
    return undefined;
  }

  if(!isDefined(level.var_c64e1c2400079db2)) {
    return undefined;
  }

  if(!isDefined(level.var_c64e1c2400079db2[alias_name])) {
    return undefined;
  }

  return level.var_c64e1c2400079db2[alias_name];
}

function function_4f0e1fcf2e24ebe8(heli, team, max_dist, natural_dist, z_offset, var_94daefb3c6070e16, icon_size) {
  if(is_equal(team, "allies")) {
    icon = "hud_icon_head_equipment_friendly";
  } else {
    icon = "hud_icon_head_equipment_enemy";
  }

  if(!isDefined(max_dist)) {
    max_dist = 12000;
  }

  if(!isDefined(natural_dist)) {
    natural_dist = 1500;
  }

  if(!isDefined(z_offset)) {
    z_offset = 10;
  }

  if(!isDefined(var_94daefb3c6070e16)) {
    var_94daefb3c6070e16 = 0;
  }

  if(!isDefined(icon_size)) {
    icon_size = "icon_regular";
  }

  heli.headicon = createheadicon(heli);
  setheadiconimage(heli.headicon, icon);
  setheadiconmaxdistance(heli.headicon, max_dist);
  setheadiconnaturaldistance(heli.headicon, natural_dist);
  setheadiconzoffset(heli.headicon, z_offset);
  setheadiconsnaptoedges(heli.headicon, 1);
  function_ddfa1aae9717e4d9(heli.headicon, "icon_regular");
  setheadicondrawinmap(heli.headicon, var_94daefb3c6070e16);
  heli thread scripts\cp\utility::watchheadicon(heli, heli.headicon);
}

function private function_c004ce81c6437d2c() {}

function function_61483c01c23ba872(str_name, var_fa448e35ec19bb8d) {
  if(!isDefined(var_fa448e35ec19bb8d)) {
    var_fa448e35ec19bb8d = 1;
  }

  setdevdvarifuninitialized(@ "hash_91f5df8e99e96006", 0);
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x202>");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x22b>", "<dev string:x245>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x26a>", "<dev string:x283>", &function_7b2161f6d3e67601);
  scripts\common\devgui::function_fe953f000498048f();

  level.var_1496650f878c4850 = [];
  var_eae6aff771c7ceea = getStructArray(str_name, "targetname");

  foreach(heli_str in var_eae6aff771c7ceea) {
    heli_str.obj_id = isDefined(heli_str.script_parameters) ? heli_str.script_parameters : "0";
    heli_str.mdl_pristine = undefined;
    heli_str.mdl_dst = undefined;
    heli_str.clip_pristine = undefined;
    heli_str.clip_dst = undefined;
    heli_str.is_destroyed = 0;
    heli_str.var_af6bb5934bfbcb6c = var_fa448e35ec19bb8d;
    child_objs = function_a5079b5837467402(heli_str.target, "targetname");

    foreach(obj in child_objs) {
      if(!isDefined(obj.script_noteworthy)) {
        continue;
      }

      switch (obj.script_noteworthy) {
        case #"hash_74a444c1cef840d9":
          heli_str.mdl_pristine = obj;
          break;
        case #"hash_4dd6bc33f95af1ac":
          heli_str.mdl_dst = obj;
          heli_str.mdl_dst hide();
          break;
        case #"hash_371ebf3904eb11c4":
          heli_str.clip_pristine = obj;
          break;
        case #"hash_315e46e2063470e1":
          heli_str.var_b8f2240d36269f3d = obj;
          break;
        case #"hash_70ae65deb44945bf":
          heli_str.clip_dst = obj;
          heli_str.clip_dst hide();
          break;
        case #"hash_d4e262d0989fd2ed":
          heli_str.var_e04cacd1d7767f5 = obj;
          break;
      }
    }

    if(!isDefined(heli_str.mdl_pristine)) {
      continue;
    }

    heli_str.mdl_pristine setautoboxcalculationusingdobj(1);
    heli_str.mdl_pristine setModel(heli_str.mdl_pristine.model);

    if(issubstr(heli_str.mdl_pristine.model, "mindia8")) {
      continue;
    }

    level.var_1496650f878c4850 = array_add(level.var_1496650f878c4850, heli_str);
    heli_str.mdl_pristine setscriptablepartstate("running_lights", "on");
    heli_str.mdl_pristine setscriptablepartstate("Exhaust", "on");
    heli_str.mdl_pristine setscriptablepartstate("vector_field", "on");

    if(istrue(var_fa448e35ec19bb8d)) {
      function_50aef2baaff3d99f(heli_str, 1);
    }

    if(str_name == "chem_obj_heli" && istrue(level.checkpoint_reached)) {
      level thread function_4dcc095965bdce62(heli_str);
      continue;
    }

    level thread function_7220a872b217b087(heli_str);
  }
}

function function_4dcc095965bdce62(heli_str) {
  heli_str waittill("explode_callback_added");
  wait 1;
  function_e1f70dc53bdf6626(heli_str);
}

function function_50aef2baaff3d99f(heli_str, on) {
  if(istrue(on)) {
    heli_str.mdl_pristine setscriptablepartstate("rotors", "motion");
    heli_str.mdl_pristine dontinterpolate();
    heli_str.mdl_pristine scriptmodelclearanim();
    heli_str.mdl_pristine scriptmodelplayanim("veh_jup_mil_ru_heli_transport_chemical_rotor_idle_loop");
    level thread scripts\cp\weapon::add_to_special_lockon_target_list(heli_str.mdl_pristine);

    if(isDefined(heli_str.var_e04cacd1d7767f5)) {
      heli_str thread function_e8851c49a54dd201();
    }

    heli_str.var_af6bb5934bfbcb6c = 1;
    return;
  }

  heli_str.mdl_pristine setscriptablepartstate("rotors", "static");
  heli_str.mdl_pristine dontinterpolate();
  heli_str.mdl_pristine scriptmodelclearanim();
  heli_str notify("heli_str_rotors_off");

  if(isDefined(heli_str.var_e04cacd1d7767f5)) {
    heli_str.var_e04cacd1d7767f5 trigger_off();
  }

  level thread scripts\cp\weapon::remove_from_special_lockon_target_list(heli_str.mdl_pristine);
  heli_str.var_af6bb5934bfbcb6c = 0;
}

function function_e8851c49a54dd201() {
  self endon("heli_str_rotors_off");
  self endon("heli_static_destroyed");
  self.mdl_pristine endon("death");

  while(true) {
    all_vehicles = getvehiclearray();

    foreach(veh in all_vehicles) {
      if(!isDefined(veh.helperdronetype)) {
        continue;
      }

      if(veh istouching(self.var_e04cacd1d7767f5)) {
        veh dodamage(9999999, self.var_e04cacd1d7767f5.origin, self.var_e04cacd1d7767f5, self.var_e04cacd1d7767f5, "MOD_TRIGGER_HURT", "palfa_mp");
      }
    }

    wait 0.1;
  }
}

function function_7220a872b217b087(heli_str) {
  heli = heli_str.mdl_pristine;
  heli endon("death");
  heli setCanDamage(1);
  heli setCanRadiusDamage(1);
  heli.health = 2147483647;
  heli.maxhealth = 2147483647;
  heli.health_remaining = 5000;
  heli.var_4e49a501165e9337 = heli.health_remaining;
  var_6444e7d31c2f4218 = heli.health_remaining * 0.75;
  var_cbb2ffefce6736ca = heli.health_remaining * 0.5;
  var_f314ff32ec51a987 = heli.health_remaining * 0.25;
  half_dmg = heli.health_remaining * 0.5 + 250;
  third_dmg = heli.health_remaining * 0.3333 + 150;

  level thread function_6759d110d798c4b4(heli_str);

  while(true) {
    heli waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, einflictor);

    if(getdvarint(@ "hash_d6a84652bcb25596", 0) == 1) {
      string = "<dev string:x297>";

      if(isDefined(tagname)) {
        string = "<dev string:x298>" + getxhashsourcename(tagname);
      }

      if(isDefined(partname)) {
        string = "<dev string:x29e>" + getxhashsourcename(partname);
      }

      iprintlnbold(string);
    }

    heli.health += damage;

    if(!isDefined(attacker) && !isDefined(einflictor)) {
      continue;
    }

    isplayerdamage = 0;
    var_692781a899140787 = 0;
    isplayervehicledamage = 0;

    if(isDefined(attacker)) {
      if(attacker == level.player) {
        isplayerdamage = 1;
      } else if(is_equal(attacker.team, "allies")) {
        var_692781a899140787 = 1;
      } else if(attacker scripts\cp_mp\vehicles\vehicle::isvehicle() && (is_equal(attacker.teamfriendlyto, "allies") || is_equal(attacker.team, "allies"))) {
        isplayervehicledamage = 1;
      }
    } else if(isDefined(einflictor)) {
      if(is_equal(einflictor.team, "allies")) {
        var_692781a899140787 = 1;
      }
    }

    if(!isplayerdamage && !var_692781a899140787 && !isplayervehicledamage) {
      continue;
    }

    weap_name = isDefined(objweapon) && isDefined(objweapon.basename) ? objweapon.basename : undefined;

    if(!isDefined(weap_name) && isDefined(einflictor) && isDefined(einflictor.weapon_name)) {
      weap_name = einflictor.weapon_name;
    }

    weap_class = isDefined(objweapon) && isDefined(objweapon.classname) ? objweapon.classname : undefined;
    var_7cd7a4a529eb8a1e = undefined;
    heli_str.var_4d6d89935511dd2e = weap_class;
    heli_str.var_71efe19bc16fd96d = weap_name;
    heli_str.last_damage_mod = meansofdeath;
    heli_str.var_331bfe7308f68830 = damage;

    if(is_equal(weap_name, "iw8_spotter_scope_mp") || is_equal(weap_name, "iw9_laser_large_ir_mp") || is_equal(meansofdeath, "MOD_MELEE") || is_equal(weap_name, "throwingknife_cp")) {
      continue;
    }

    flag_set("flag_heli_damaged_any_" + heli_str.obj_id);
    hit_count = function_5a98e41c6e64ea74(weap_name, meansofdeath, weap_class, damage, isplayervehicledamage);

    if(hit_count > 0) {
      var_7cd7a4a529eb8a1e = int(heli.var_4e49a501165e9337 / hit_count);
      heli_str.var_8e9290b337610aa = var_7cd7a4a529eb8a1e;
      heli.health_remaining -= var_7cd7a4a529eb8a1e;
    }

    var_ddb155b679e004de = undefined;

    if(istrue(isplayervehicledamage) && is_equal(meansofdeath, "MOD_CRUSH")) {
      if(isDefined(heli_str.var_95f332a2a46b2d30)) {
        cur_time = gettime();

        if(cur_time - heli_str.var_95f332a2a46b2d30 < 3000) {
          continue;
        }
      }

      damage = 50;
      level notify("heli_damaged_vehicle_ram");

      if(isDefined(attacker.vehiclename)) {
        var_ddb155b679e004de = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle(attacker.vehiclename);

        if(isDefined(var_ddb155b679e004de.class)) {
          switch (var_ddb155b679e004de.class) {
            case #"hash_d582c3286e5c390f":
              break;
            case #"hash_21622ca3ad06efb5":
            case #"hash_c71b112fe04823d6":
              damage = 250;
              break;
            case #"hash_2453c9ffec9f5c20":
            case #"hash_53e0b558455f04c6":
            case #"hash_e8ec392f4f2724e4":
              damage = 500;
              break;
          }
        }
      }

      heli_str.var_331bfe7308f68830 = damage;
      heli_str.var_95f332a2a46b2d30 = gettime();
    }

    if(hit_count == 0) {
      heli.health_remaining -= damage;
    }

    if(heli.health_remaining <= 0) {
      break;
    }

    if(hit_count <= 0) {
      if(is_equal(meansofdeath, "MOD_EXPLOSIVE")) {
        if(is_equal(weap_class, "rocketlauncher")) {
          heli.health_remaining -= half_dmg;
        }
      } else if(is_equal(meansofdeath, "MOD_GRENADE_SPLASH") || is_equal(meansofdeath, "MOD_GRENADE")) {
        if(is_equal(weap_class, "grenade") && !is_equal(weap_name, "jup_flash_grenade_cp") && !is_equal(weap_name, "gas_grenade_cp") && !is_equal(weap_name, "concussion_grenade_cp")) {
          heli.health_remaining -= third_dmg;
        }
      } else if(is_equal(meansofdeath, "MOD_PROJECTILE")) {
        if(is_equal(weap_class, "rocketlauncher")) {
          heli.health_remaining -= half_dmg;
        }
      } else if(is_equal(meansofdeath, "MOD_IMPACT")) {
        if(isDefined(weap_name) && issubstr(weap_name, "c4")) {
          level notify("heli_damaged_single_c4");
        }
      } else if(is_equal(meansofdeath, "MOD_CRUSH")) {} else if(is_equal(meansofdeath, "MOD_MELEE")) {} else if(is_equal(meansofdeath, "MOD_RIFLE_BULLET") && !is_equal(objweapon.basename, "jup_mg_jltv_dungeons_cp") || is_equal(meansofdeath, "MOD_PISTOL_BULLET")) {
        if(damage >= 3) {
          level notify("heli_damaged_bullet", attacker);
        }
      }
    }

    if(heli.health_remaining <= 0) {
      break;
    }

    if(heli.health_remaining <= var_f314ff32ec51a987) {
      heli setscriptablepartstate("damageHeavy", "stopped");

      if(!flag("flag_heli_damaged_heavy_" + heli_str.obj_id)) {
        level notify("heli_damaged_heavy_" + heli_str.obj_id);
        flag_set("flag_heli_damaged_heavy_" + heli_str.obj_id);
      }

      continue;
    }

    if(heli.health_remaining > var_f314ff32ec51a987 && heli.health_remaining <= var_cbb2ffefce6736ca) {
      heli setscriptablepartstate("damageMedium", "stopped");

      if(!flag("flag_heli_damaged_med_" + heli_str.obj_id)) {
        level notify("heli_damaged_med_" + heli_str.obj_id);
        flag_set("flag_heli_damaged_med_" + heli_str.obj_id);
      }

      continue;
    }

    if(heli.health_remaining > var_cbb2ffefce6736ca && heli.health_remaining <= var_6444e7d31c2f4218) {
      heli setscriptablepartstate("damageLight", "stopped");

      if(!flag("flag_heli_damaged_light_" + heli_str.obj_id)) {
        level notify("heli_damaged_light_" + heli_str.obj_id);
        flag_set("flag_heli_damaged_light_" + heli_str.obj_id);
      }
    }
  }

  function_e1f70dc53bdf6626(heli_str);
}

function function_606322b129b94140(callback, obj_id) {
  if(!isDefined(level.var_1496650f878c4850)) {
    return;
  }

  foreach(heli_str in level.var_1496650f878c4850) {
    if(isDefined(obj_id)) {
      if(is_equal(heli_str.obj_id, obj_id)) {
        heli_str.var_629e5d7e52d402b8 = callback;
      }
    } else {
      heli_str.var_629e5d7e52d402b8 = callback;
    }

    heli_str notify("explode_callback_added");
  }
}

function function_5a98e41c6e64ea74(weap_name, mod, weap_class, var_cce02caeb222cc58, isplayervehicledamage) {
  if(isDefined(weap_name)) {
    if(issubstr(weap_name, "cruise_proj")) {
      return 1;
    }

    if(issubstr(weap_name, "toma_proj")) {
      return 4;
    }

    if(issubstr(weap_name, "auto_drone_proj")) {
      return 6;
    }

    if(issubstr(weap_name, "artillery")) {
      return 18;
    }

    if(issubstr(weap_name, "chopper_gunner_proj")) {
      return 2;
    }

    if(issubstr(weap_name, "chopper_gunner_turret")) {
      return 13;
    }

    if(issubstr(weap_name, "assault_drone")) {
      return 2;
    }

    if(issubstr(weap_name, "c4") && is_equal(mod, "MOD_EXPLOSIVE")) {
      if(var_cce02caeb222cc58 >= 240) {
        return 1;
      } else {
        return 1.75;
      }
    }

    if(issubstr(weap_name, "la_rpapa7")) {
      if(is_equal(mod, "MOD_PROJECTILE")) {
        return 2;
      } else {
        return 3;
      }
    }

    if(issubstr(weap_name, "la_gromeo")) {
      if(is_equal(mod, "MOD_PROJECTILE")) {
        return 1;
      } else {
        return 2;
      }
    }

    if(issubstr(weap_name, "la_mike32")) {
      if(is_equal(mod, "MOD_GRENADE")) {
        return 4;
      } else {
        return 6;
      }
    }

    if(issubstr(weap_name, "frag")) {
      if(is_equal(mod, "MOD_GRENADE") || is_equal(mod, "MOD_GRENADE_SPLASH")) {
        return 4;
      }
    }

    if(issubstr(weap_name, "semtex")) {
      if(is_equal(mod, "MOD_GRENADE") || is_equal(mod, "MOD_GRENADE_SPLASH")) {
        return 4;
      }
    }

    if(issubstr(weap_name, "thermite")) {
      if(is_equal(mod, "MOD_IMPACT")) {
        return 4;
      } else {
        return 6;
      }
    }

    if(issubstr(weap_name, "molotov")) {
      if(is_equal(mod, "MOD_GRENADE") || is_equal(mod, "MOD_EXPLOSIVE")) {
        return 4;
      } else {
        return 6;
      }
    }

    if(issubstr(weap_name, "claymore")) {
      if(is_equal(mod, "MOD_GRENADE")) {
        return 3;
      } else {
        return 6;
      }
    }

    if(issubstr(weap_name, "semtex_bolt_splash")) {
      if(is_equal(mod, "MOD_EXPLOSIVE")) {
        return 4;
      } else {
        return 8;
      }
    }
  }

  return 0;
}

function function_e1f70dc53bdf6626(heli_str) {
  heli_str.clip_dst show();
  heli_str.mdl_pristine setCanDamage(0);
  heli_str.mdl_pristine setscriptablepartstate("explode", "dead");
  heli_str.mdl_pristine scriptmodelclearanim();
  var_eac9bd0d4b0a9cef = cointoss() ? "veh8_common_pickup_expl_tag_origin_1" : "veh8_common_pickup_expl_tag_origin_2";
  heli_str.is_destroyed = 1;
  heli_str notify("heli_static_destroyed");
  level notify("heli_static_destroyed_" + heli_str.obj_id);

  if(isDefined(heli_str.var_e04cacd1d7767f5)) {
    heli_str.var_e04cacd1d7767f5 trigger_off();
  }

  heli_str.mdl_dst show();
  heli_str.mdl_dst dontinterpolate();
  heli_str.mdl_dst scriptmodelclearanim();
  heli_str.mdl_dst scriptmodelplayanimdeltamotion(var_eac9bd0d4b0a9cef);

  if(istrue(heli_str.var_af6bb5934bfbcb6c)) {
    level thread scripts\cp\weapon::remove_from_special_lockon_target_list(heli_str.mdl_pristine);
  }

  if(isDefined(heli_str.var_629e5d7e52d402b8)) {
    level thread[[heli_str.var_629e5d7e52d402b8]](heli_str);
  }
}

function function_7b2161f6d3e67601() {
  if(!isDefined(level.var_1496650f878c4850)) {
    return;
  }

  weapon = makeweapon("<dev string:x2a5>");

  foreach(heli in level.var_1496650f878c4850) {
    heli.mdl_pristine dodamage(heli.mdl_pristine.health_remaining, heli.mdl_pristine.origin, level.player, undefined, "<dev string:x2b6>", weapon, undefined, undefined, undefined);
  }
}

function function_6759d110d798c4b4(heli_str) {
  while(true) {
    if(getdvarint(@ "hash_91f5df8e99e96006", 0) == 1) {
      if(!istrue(heli_str.var_1284703964c7bb77)) {
        heli_str thread function_d57aad904fc851d3();
        heli_str.var_1284703964c7bb77 = 1;
      }
    } else if(istrue(heli_str.var_1284703964c7bb77)) {
      heli_str notify("<dev string:x2c4>");
      heli_str.var_1284703964c7bb77 = 0;
    }

    waitframe();
  }
}

function function_d57aad904fc851d3() {
  self.mdl_pristine endon("<dev string:x82>");
  self endon("<dev string:x2c4>");

  while(true) {
    curr_health = self.mdl_pristine.health_remaining;
    max_health = self.mdl_pristine.var_4e49a501165e9337;
    print3d(self.mdl_pristine.origin + (0, 0, 128), "<dev string:x2de>" + curr_health + "<dev string:x2f5>" + max_health, (1, 1, 1), undefined, 1, 1);

    if(istrue(self.is_destroyed)) {
      print3d(self.mdl_pristine.origin + (0, 0, 112), "<dev string:x2f9>", (1, 0, 0), undefined, 1, 1);
    }

    var_c8378b32a5cf3e4f = isDefined(self.var_71efe19bc16fd96d) ? self.var_71efe19bc16fd96d : "<dev string:x303>";
    var_74674d2f6a77d6dc = isDefined(self.var_4d6d89935511dd2e) ? self.var_4d6d89935511dd2e : "<dev string:x303>";
    var_a04df03a42806368 = isDefined(self.last_damage_mod) ? self.last_damage_mod : "<dev string:x303>";
    var_331bfe7308f68830 = isDefined(self.var_331bfe7308f68830) ? self.var_331bfe7308f68830 : "<dev string:x303>";
    var_8e9290b337610aa = isDefined(self.var_8e9290b337610aa) ? self.var_8e9290b337610aa : "<dev string:x303>";
    print3d(self.mdl_pristine.origin + (0, 0, 96), "<dev string:x30d>" + var_c8378b32a5cf3e4f, (1, 1, 1), undefined, 1, 1);
    print3d(self.mdl_pristine.origin + (0, 0, 80), "<dev string:x326>" + var_74674d2f6a77d6dc, (1, 1, 1), undefined, 1, 1);
    print3d(self.mdl_pristine.origin + (0, 0, 64), "<dev string:x340>" + var_a04df03a42806368, (1, 1, 1), undefined, 1, 1);
    print3d(self.mdl_pristine.origin + (0, 0, 48), "<dev string:x353>" + var_331bfe7308f68830, (1, 1, 1), undefined, 1, 1);
    print3d(self.mdl_pristine.origin + (0, 0, 32), "<dev string:x366>" + var_8e9290b337610aa, (1, 1, 1), undefined, 1, 1);
    waitframe();
  }
}

# /