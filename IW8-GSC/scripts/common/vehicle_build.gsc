/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_build.gsc
***********************************************/

function build_radiusdamage(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  var_4 = spawnStruct();
  var_4.offset = var_0;
  var_4.range = var_1;
  var_4.maxdamage = var_2;
  var_4.mindamage = var_3;
  level.vehicle.templates.death_radiusdamage[level.vtclassname] = var_4;
}

function build_rumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle.templates.rumble)) {
    level.vehicle.templates.rumble = [];
  }

  var_6 = build_quake(var_1, var_2, var_3, var_4, var_5);
  precacherumble(var_0);
  var_6.rumble = var_0;
  level.vehicle.templates.rumble[level.vtclassname] = var_6;
}

function build_deathquake(var_0, var_1, var_2) {
  var_3 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.death_earthquake)) {
    level.vehicle.templates.death_earthquake = [];
  }

  level.vehicle.templates.death_earthquake[var_3] = build_quake(var_0, var_1, var_2);
}

function build_quake(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.scale = var_0;
  var_5.duration = var_1;
  var_5.radius = var_2;

  if(isDefined(var_3)) {
    var_5.basetime = var_3;
  }

  if(isDefined(var_4)) {
    var_5.randomaditionaltime = var_4;
  }

  return var_5;
}

function build_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_12 = spawnStruct();
  var_12.effect = loadfx(var_0);
  var_12.tag = var_1;
  var_12.sound = var_2;
  var_12.bsoundlooping = var_5;
  var_12.delay = var_4;
  var_12.waitdelay = var_6;
  var_12.stayontag = var_7;
  var_12.notifystring = var_8;
  var_12.beffectlooping = var_3;
  var_12.selfdeletedelay = var_9;
  var_12.remove_deathfx_entity_delay = var_10;
  var_12.attacker_velocity_lerp = var_11;
  return var_12;
}

function build_deathfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.vehicle_death_fx[var_12])) {
    level.vehicle.templates.vehicle_death_fx[var_12] = [];
  }

  level.vehicle.templates.vehicle_death_fx[var_12][level.vehicle.templates.vehicle_death_fx[var_12].size] = build_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

function build_rocket_deathfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.vehicle_death_fx[var_11])) {
    level.vehicle.templates.vehicle_death_fx[var_11] = [];
  }

  level.vehicle.templates.vehicle_rocket_death_fx[var_11][level.vehicle.templates.vehicle_death_fx[var_11].size] = build_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

function build_deathanimations(var_0, var_1, var_2, var_3) {
  var_4 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.deathanimations[var_4])) {
    level.vehicle.templates.deathanimations[var_4] = [];
  }

  level.vehicle.templates.deathanimations[var_4]["forward"] = var_0;
  level.vehicle.templates.deathanimations[var_4]["right"] = var_1;
  level.vehicle.templates.deathanimations[var_4]["backward"] = var_2;
  level.vehicle.templates.deathanimations[var_4]["left"] = var_3;
}

function build_landanims(var_0) {
  var_1 = level.vtclassname;
  level.vehicle.templates.landanims[var_1] = [[var_0]]();
}

function build_turret(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.mgturret[var_9])) {
    level.vehicle.templates.mgturret[var_9] = [];
  }

  var_10 = build_turret_struct(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  level.vehicle.templates.mgturret[var_9][level.vehicle.templates.mgturret[var_9].size] = var_10;
}

function build_mainturret(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = level.vtclassname;

  if(isDefined(level.vehicle.templates.mainturret[var_8])) {}

  var_9 = build_turret_struct(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  level.vehicle.templates.mainturret[var_8] = var_9;
}

function build_turret_struct(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  precachemodel(var_2);
  precacheturret(var_0);
  var_9 = spawnStruct();
  var_9.info = var_0;
  var_9.tag = var_1;
  var_9.model = var_2;
  var_9.defaultonmode = var_3;
  var_9.defaultdroppitch = var_4;
  var_9.defaultdropyaw = var_5;

  if(isDefined(var_6)) {
    var_9.offset_tag = var_6;
  }

  if(isDefined(var_7)) {
    var_9.referencename = var_7;
  }

  if(isDefined(var_8) && var_8) {
    var_9.mainturretchild = var_8;
  }

  return var_9;
}

function build_light(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle.templates.vehicle_lights)) {
    level.vehicle.templates.vehicle_lights = [];
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group_override)) {
    level.vehicle.templates.vehicle_lights_group_override = [];
  }

  if(isDefined(level.vehicle.templates.vehicle_lights_group_override[var_4]) && !level.vtoverride) {
    return;
  }

  var_6 = spawnStruct();
  var_6.name = var_1;
  var_6.tag = var_2;
  var_6.delay = var_5;
  var_6.effect = loadfx(var_3);
  level.vehicle.templates.vehicle_lights[var_0][var_1] = var_6;
  scripts\common\vehicle_lights::group_light(var_0, var_1, "all");

  if(isDefined(var_4)) {
    scripts\common\vehicle_lights::group_light(var_0, var_1, var_4);
    return;
  }
}

function build_hideparts(var_0, var_1) {
  if(!isDefined(level.vehicle.templates.hide_part_list)) {
    level.vehicle.templates.hide_part_list = [];
  }

  level.vehicle.templates.hide_part_list[var_0] = var_1;
}

function build_deathmodel(var_0, var_1) {
  if(var_0 != level.vtmodel) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  precachemodel(var_0);
  precachemodel(var_1);
  level.vehicle.templates.deathmodel[var_0] = var_1;
}

function build_idle(var_0) {
  if(!isDefined(level.vehicle.templates.idle_anim)) {
    level.vehicle.templates.idle_anim = [];
  }

  if(!isDefined(level.vehicle.templates.idle_anim[level.vtmodel])) {
    level.vehicle.templates.idle_anim[level.vtmodel] = [];
  }

  level.vehicle.templates.idle_anim[level.vtmodel][level.vehicle.templates.idle_anim[level.vtmodel].size] = var_0;
}

function build_drive(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 10;
  }

  level.vehicle.templates.driveidle[level.vtmodel] = var_0;

  if(isDefined(var_1)) {
    level.vehicle.templates.driveidle_r[level.vtmodel] = var_1;
  }

  level.vehicle.templates.driveidle_normal_speed[level.vtmodel] = var_2;

  if(isDefined(var_3)) {
    level.vehicle.templates.driveidle_animrate[level.vtmodel] = var_3;
    return;
  }
}

function build_template(var_0, var_1, var_2, var_3) {
  scripts\common\vehicle_code::vehicle_setuplevelvariables();

  if(isDefined(var_2)) {
    var_0 = var_2;
  }

  precachevehicle(var_0);
  level.vehicle.templates.team[var_3] = "axis";
  level.vehicle.templates.life[var_3] = 999;
  level.vehicle.templates.has_main_turret[var_1] = 0;
  level.vehicle.templates.main_turrets[var_1] = [];
  level.vtmodel = var_1;
  level.vttype = var_0;
  level.vtclassname = var_3;
  level.vehicle.templates.model[var_3] = var_1;
}

function build_exhaust(var_0) {
  level.vehicle.templates.exhaust_fx[level.vtmodel] = loadfx(var_0);
}

function build_enginefx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_1)) {
    var_1 = "tag_engine_fx";
  }

  var_8 = spawnStruct();
  var_8.effect = loadfx(var_0);
  var_8.effect_tag = var_1;

  if(isDefined(var_2)) {
    var_8.max_effort_effect = loadfx(var_2);
    var_8.max_effort_ratio = var_3;
  }

  if(isDefined(var_4)) {
    var_8.med_effort_effect = loadfx(var_4);
    var_8.med_effort_ratio = var_5;
  }

  if(isDefined(var_6)) {
    var_8.min_effort_effect = loadfx(var_6);
    var_8.min_effort_ratio = var_7;
  }

  level.vehicle.templates.engine_fx[level.vtclassname] = var_8;
}

function build_treadfx(var_0, var_1, var_2, var_3) {
  if(!scripts\common\utility::issp()) {
    return;
  }

  if(isDefined(var_0)) {
    set_vehicle_effect(var_0, var_1, var_2);

    if(isDefined(var_3) && var_3) {
      set_vehicle_effect(var_0, var_1, var_2, "_bank");
      set_vehicle_effect(var_0, var_1, var_2, "_bank_lg");
      return;
    }

    return;
  }

  var_0 = level.vtclassname;
  scripts\common\vehicle_treadfx::main();
}

function build_all_treadfx(var_0, var_1) {
  var_2 = get_surface_types();

  foreach(var_4 in var_2) {
    set_vehicle_effect(var_0, var_4);
  }
}

function set_vehicle_effect(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vehicle.templates.surface_effects)) {
    level.vehicle.templates.surface_effects = [];
  }

  if(isDefined(var_3)) {
    var_1 += var_3;
    var_2 += var_3;
  }

  if(isDefined(var_2)) {
    level.vehicle.templates.surface_effects[var_0][var_1] = loadfx(var_2);
    return;
  }

  if(isDefined(level.vehicle.templates.surface_effects[var_0]) && isDefined(level.vehicle.templates.surface_effects[var_0][var_1])) {
    level.vehicle.templates.surface_effects[var_0][var_1] = undefined;
    return;
  }
}

function get_surface_types() {
  return ["brick", "bark", "carpet", "cloth", "concrete", "dirt", "flesh", "foliage", "glass", "grass", "gravel", "ice", "metal", "mud", "paper", "plaster", "rock", "sand", "snow", "water", "wood", "asphalt", "ceramic", "plastic", "rubber", "cushion", "fruit", "paintedmetal", "riotshield", "slush", "default"];
}

function build_team(var_0) {
  level.vehicle.templates.team[level.vtclassname] = var_0;
}

function build_bulletshield(var_0) {
  level.vehicle.templates.bullet_shield[level.vtclassname] = var_0;
}

function build_grenadeshield(var_0) {
  level.vehicle.templates.grenade_shield[level.vtclassname] = var_0;
}

function build_aianims(var_0, var_1, var_2) {
  var_3 = level.vtclassname;
  level.vehicle.templates.aianims[var_3] = [[var_0]]();

  if(isDefined(var_2) && isDefined(level.func) && isDefined(level.func["set_vehicle_anims_" + var_2])) {
    level.vehicle.templates.aianims[var_3] = [[level.func["set_vehicle_anims_" + var_2]]](level.vehicle.templates.aianims[var_3]);
    return;
  }

  if(isDefined(var_1)) {
    level.vehicle.templates.aianims[var_3] = [[var_1]](level.vehicle.templates.aianims[var_3]);
    return;
  }
}

function build_attach_models(var_0) {
  level.vehicle.templates.attachedmodels[level.vtclassname] = [[var_0]]();
}

function build_unload_groups(var_0) {
  level.vehicle.templates.unloadgroups[level.vtclassname] = [[var_0]]();
}

function build_life(var_0, var_1, var_2) {
  var_3 = level.vtclassname;
  level.vehicle.templates.life[var_3] = var_0;
  level.vehicle.templates.life_range_low[var_3] = var_1;
  level.vehicle.templates.life_range_high[var_3] = var_2;
}

function build_destructible(var_0, var_1) {}

function build_localinit(var_0) {
  level.vehicleinitthread[level.vttype][level.vtclassname] = var_0;
}

function build_atmo_types(var_0, var_1) {
  level.vehicle.templates.atmotypes[level.vtclassname]["atmo"] = var_0;
  level.vehicle.templates.atmotypes[level.vtclassname]["space"] = var_1;
}

function build_ace(var_0) {
  level.vehicle.templates.aces[level.vtclassname] = var_0;
}

function build_semiace(var_0) {
  level.vehicle.templates.semiaces[level.vtclassname] = var_0;
}

function build_playercontrolled_model(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.playercontrolledmodel = var_0;
  var_2.worldmodel = var_1;
  precachemodel(var_0);
  level.vehicle.templates.vehicleplayermodel[level.vtclassname] = var_2;
}

function build_is_helicopter(var_0) {
  if(!isDefined(level.vehicle.templates.helicopter_list)) {
    level.vehicle.templates.helicopter_list = [];
  }

  if(!isDefined(var_0)) {
    var_0 = level.vttype;
  }

  level.vehicle.templates.helicopter_list[var_0] = 1;
}

function build_is_airplane(var_0) {
  if(!isDefined(level.vehicle.templates.airplane_list)) {
    level.vehicle.templates.airplane_list = [];
  }

  if(!isDefined(var_0)) {
    var_0 = level.vttype;
  }

  level.vehicle.templates.airplane_list[var_0] = 1;
}

function build_single_tread(var_0) {
  if(!isDefined(level.vehicle.templates.single_tread_list)) {
    level.vehicle.templates.single_tread_list = [];
  }

  if(!isDefined(var_0)) {
    var_0 = level.vttype;
  }

  level.vehicle.templates.single_tread_list[var_0] = 1;
}

function build_rider_death_func(var_0) {
  if(!isDefined(level.vehicle.templates.rider_death_func)) {
    level.vehicle.templates.rider_death_func = [];
  }

  level.vehicle.templates.rider_death_func[level.vtclassname] = var_0;
}