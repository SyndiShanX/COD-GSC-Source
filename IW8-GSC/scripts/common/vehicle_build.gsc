/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_build.gsc
***********************************************/

function build_radiusdamage(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    var0 = (0, 0, 0);
  }

  var4 = spawnStruct();
  var4.offset = var0;
  var4.range = var1;
  var4.maxdamage = var2;
  var4.mindamage = var3;
  level.vehicle.templates.death_radiusdamage[level.vtclassname] = var4;
}

function build_rumble(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(level.vehicle.templates.rumble)) {
    level.vehicle.templates.rumble = [];
  }

  var6 = build_quake(var1, var2, var3, var4, var5);
  precacherumble(var0);
  var6.rumble = var0;
  level.vehicle.templates.rumble[level.vtclassname] = var6;
}

function build_deathquake(var0, var1, var2) {
  var3 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.death_earthquake)) {
    level.vehicle.templates.death_earthquake = [];
  }

  level.vehicle.templates.death_earthquake[var3] = build_quake(var0, var1, var2);
}

function build_quake(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  var5.scale = var0;
  var5.duration = var1;
  var5.radius = var2;

  if(isDefined(var3)) {
    var5.basetime = var3;
  }

  if(isDefined(var4)) {
    var5.randomaditionaltime = var4;
  }

  return var5;
}

function build_fx(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  if(!isDefined(var5)) {
    var5 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!isDefined(var4)) {
    var4 = 1;
  }

  var12 = spawnStruct();
  var12.effect = loadfx(var0);
  var12.tag = var1;
  var12.sound = var2;
  var12.bsoundlooping = var5;
  var12.delay = var4;
  var12.waitdelay = var6;
  var12.stayontag = var7;
  var12.notifystring = var8;
  var12.beffectlooping = var3;
  var12.selfdeletedelay = var9;
  var12.remove_deathfx_entity_delay = var10;
  var12.attacker_velocity_lerp = var11;
  return var12;
}

function build_deathfx(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.vehicle_death_fx[var12])) {
    level.vehicle.templates.vehicle_death_fx[var12] = [];
  }

  level.vehicle.templates.vehicle_death_fx[var12][level.vehicle.templates.vehicle_death_fx[var12].size] = build_fx(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
}

function build_rocket_deathfx(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var11 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.vehicle_death_fx[var11])) {
    level.vehicle.templates.vehicle_death_fx[var11] = [];
  }

  level.vehicle.templates.vehicle_rocket_death_fx[var11][level.vehicle.templates.vehicle_death_fx[var11].size] = build_fx(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
}

function build_deathanimations(var0, var1, var2, var3) {
  var4 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.deathanimations[var4])) {
    level.vehicle.templates.deathanimations[var4] = [];
  }

  level.vehicle.templates.deathanimations[var4]["forward"] = var0;
  level.vehicle.templates.deathanimations[var4]["right"] = var1;
  level.vehicle.templates.deathanimations[var4]["backward"] = var2;
  level.vehicle.templates.deathanimations[var4]["left"] = var3;
}

function build_landanims(var0) {
  var1 = level.vtclassname;
  level.vehicle.templates.landanims[var1] = [[var0]]();
}

function build_turret(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.mgturret[var9])) {
    level.vehicle.templates.mgturret[var9] = [];
  }

  var10 = build_turret_struct(var0, var1, var2, var3, var4, var5, var6, var7, var8);
  level.vehicle.templates.mgturret[var9][level.vehicle.templates.mgturret[var9].size] = var10;
}

function build_mainturret(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = level.vtclassname;

  if(isDefined(level.vehicle.templates.mainturret[var8])) {}

  var9 = build_turret_struct(var0, var1, var2, var3, var4, var5, var6, var7);
  level.vehicle.templates.mainturret[var8] = var9;
}

function build_turret_struct(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  precachemodel(var2);
  precacheturret(var0);
  var9 = spawnStruct();
  var9.info = var0;
  var9.tag = var1;
  var9.model = var2;
  var9.defaultonmode = var3;
  var9.defaultdroppitch = var4;
  var9.defaultdropyaw = var5;

  if(isDefined(var6)) {
    var9.offset_tag = var6;
  }

  if(isDefined(var7)) {
    var9.referencename = var7;
  }

  if(isDefined(var8) && var8) {
    var9.mainturretchild = var8;
  }

  return var9;
}

function build_light(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(level.vehicle.templates.vehicle_lights)) {
    level.vehicle.templates.vehicle_lights = [];
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group_override)) {
    level.vehicle.templates.vehicle_lights_group_override = [];
  }

  if(isDefined(level.vehicle.templates.vehicle_lights_group_override[var4]) && !level.vtoverride) {
    return;
  }

  var6 = spawnStruct();
  var6.name = var1;
  var6.tag = var2;
  var6.delay = var5;
  var6.effect = loadfx(var3);
  level.vehicle.templates.vehicle_lights[var0][var1] = var6;
  scripts\common\vehicle_lights::group_light(var0, var1, "all");

  if(isDefined(var4)) {
    scripts\common\vehicle_lights::group_light(var0, var1, var4);
    return;
  }
}

function build_hideparts(var0, var1) {
  if(!isDefined(level.vehicle.templates.hide_part_list)) {
    level.vehicle.templates.hide_part_list = [];
  }

  level.vehicle.templates.hide_part_list[var0] = var1;
}

function build_deathmodel(var0, var1) {
  if(var0 != level.vtmodel) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = var0;
  }

  precachemodel(var0);
  precachemodel(var1);
  level.vehicle.templates.deathmodel[var0] = var1;
}

function build_idle(var0) {
  if(!isDefined(level.vehicle.templates.idle_anim)) {
    level.vehicle.templates.idle_anim = [];
  }

  if(!isDefined(level.vehicle.templates.idle_anim[level.vtmodel])) {
    level.vehicle.templates.idle_anim[level.vtmodel] = [];
  }

  level.vehicle.templates.idle_anim[level.vtmodel][level.vehicle.templates.idle_anim[level.vtmodel].size] = var0;
}

function build_drive(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 10;
  }

  level.vehicle.templates.driveidle[level.vtmodel] = var0;

  if(isDefined(var1)) {
    level.vehicle.templates.driveidle_r[level.vtmodel] = var1;
  }

  level.vehicle.templates.driveidle_normal_speed[level.vtmodel] = var2;

  if(isDefined(var3)) {
    level.vehicle.templates.driveidle_animrate[level.vtmodel] = var3;
    return;
  }
}

function build_template(var0, var1, var2, var3) {
  scripts\common\vehicle_code::vehicle_setuplevelvariables();

  if(isDefined(var2)) {
    var0 = var2;
  }

  precachevehicle(var0);
  level.vehicle.templates.team[var3] = "axis";
  level.vehicle.templates.life[var3] = 999;
  level.vehicle.templates.has_main_turret[var1] = 0;
  level.vehicle.templates.main_turrets[var1] = [];
  level.vtmodel = var1;
  level.vttype = var0;
  level.vtclassname = var3;
  level.vehicle.templates.model[var3] = var1;
}

function build_exhaust(var0) {
  level.vehicle.templates.exhaust_fx[level.vtmodel] = loadfx(var0);
}

function build_enginefx(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(var1)) {
    var1 = "tag_engine_fx";
  }

  var8 = spawnStruct();
  var8.effect = loadfx(var0);
  var8.effect_tag = var1;

  if(isDefined(var2)) {
    var8.max_effort_effect = loadfx(var2);
    var8.max_effort_ratio = var3;
  }

  if(isDefined(var4)) {
    var8.med_effort_effect = loadfx(var4);
    var8.med_effort_ratio = var5;
  }

  if(isDefined(var6)) {
    var8.min_effort_effect = loadfx(var6);
    var8.min_effort_ratio = var7;
  }

  level.vehicle.templates.engine_fx[level.vtclassname] = var8;
}

function build_treadfx(var0, var1, var2, var3) {
  if(!scripts\common\utility::issp()) {
    return;
  }

  if(isDefined(var0)) {
    set_vehicle_effect(var0, var1, var2);

    if(isDefined(var3) && var3) {
      set_vehicle_effect(var0, var1, var2, "_bank");
      set_vehicle_effect(var0, var1, var2, "_bank_lg");
      return;
    }

    return;
  }

  var0 = level.vtclassname;
  scripts\common\vehicle_treadfx::main();
}

function build_all_treadfx(var0, var1) {
  var2 = get_surface_types();

  foreach(var4 in var2) {
    set_vehicle_effect(var0, var4);
  }
}

function set_vehicle_effect(var0, var1, var2, var3) {
  if(!isDefined(level.vehicle.templates.surface_effects)) {
    level.vehicle.templates.surface_effects = [];
  }

  if(isDefined(var3)) {
    var1 += var3;
    var2 += var3;
  }

  if(isDefined(var2)) {
    level.vehicle.templates.surface_effects[var0][var1] = loadfx(var2);
    return;
  }

  if(isDefined(level.vehicle.templates.surface_effects[var0]) && isDefined(level.vehicle.templates.surface_effects[var0][var1])) {
    level.vehicle.templates.surface_effects[var0][var1] = undefined;
    return;
  }
}

function get_surface_types() {
  return ["brick", "bark", "carpet", "cloth", "concrete", "dirt", "flesh", "foliage", "glass", "grass", "gravel", "ice", "metal", "mud", "paper", "plaster", "rock", "sand", "snow", "water", "wood", "asphalt", "ceramic", "plastic", "rubber", "cushion", "fruit", "paintedmetal", "riotshield", "slush", "default"];
}

function build_team(var0) {
  level.vehicle.templates.team[level.vtclassname] = var0;
}

function build_bulletshield(var0) {
  level.vehicle.templates.bullet_shield[level.vtclassname] = var0;
}

function build_grenadeshield(var0) {
  level.vehicle.templates.grenade_shield[level.vtclassname] = var0;
}

function build_aianims(var0, var1, var2) {
  var3 = level.vtclassname;
  level.vehicle.templates.aianims[var3] = [[var0]]();

  if(isDefined(var2) && isDefined(level.func) && isDefined(level.func["set_vehicle_anims_" + var2])) {
    level.vehicle.templates.aianims[var3] = [[level.func["set_vehicle_anims_" + var2]]](level.vehicle.templates.aianims[var3]);
    return;
  }

  if(isDefined(var1)) {
    level.vehicle.templates.aianims[var3] = [[var1]](level.vehicle.templates.aianims[var3]);
    return;
  }
}

function build_attach_models(var0) {
  level.vehicle.templates.attachedmodels[level.vtclassname] = [[var0]]();
}

function build_unload_groups(var0) {
  level.vehicle.templates.unloadgroups[level.vtclassname] = [[var0]]();
}

function build_life(var0, var1, var2) {
  var3 = level.vtclassname;
  level.vehicle.templates.life[var3] = var0;
  level.vehicle.templates.life_range_low[var3] = var1;
  level.vehicle.templates.life_range_high[var3] = var2;
}

function build_destructible(var0, var1) {}

function build_localinit(var0) {
  level.vehicleinitthread[level.vttype][level.vtclassname] = var0;
}

function build_atmo_types(var0, var1) {
  level.vehicle.templates.atmotypes[level.vtclassname]["atmo"] = var0;
  level.vehicle.templates.atmotypes[level.vtclassname]["space"] = var1;
}

function build_ace(var0) {
  level.vehicle.templates.aces[level.vtclassname] = var0;
}

function build_semiace(var0) {
  level.vehicle.templates.semiaces[level.vtclassname] = var0;
}

function build_playercontrolled_model(var0, var1) {
  var2 = spawnStruct();
  var2.playercontrolledmodel = var0;
  var2.worldmodel = var1;
  precachemodel(var0);
  level.vehicle.templates.vehicleplayermodel[level.vtclassname] = var2;
}

function build_is_helicopter(var0) {
  if(!isDefined(level.vehicle.templates.helicopter_list)) {
    level.vehicle.templates.helicopter_list = [];
  }

  if(!isDefined(var0)) {
    var0 = level.vttype;
  }

  level.vehicle.templates.helicopter_list[var0] = 1;
}

function build_is_airplane(var0) {
  if(!isDefined(level.vehicle.templates.airplane_list)) {
    level.vehicle.templates.airplane_list = [];
  }

  if(!isDefined(var0)) {
    var0 = level.vttype;
  }

  level.vehicle.templates.airplane_list[var0] = 1;
}

function build_single_tread(var0) {
  if(!isDefined(level.vehicle.templates.single_tread_list)) {
    level.vehicle.templates.single_tread_list = [];
  }

  if(!isDefined(var0)) {
    var0 = level.vttype;
  }

  level.vehicle.templates.single_tread_list[var0] = 1;
}

function build_rider_death_func(var0) {
  if(!isDefined(level.vehicle.templates.rider_death_func)) {
    level.vehicle.templates.rider_death_func = [];
  }

  level.vehicle.templates.rider_death_func[level.vtclassname] = var0;
}