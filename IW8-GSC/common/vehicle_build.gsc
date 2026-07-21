/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\vehicle_build.gsc
***********************************************/

build_radiusdamage(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = (0, 0, 0);

  var_4 = spawnStruct();
  var_4.offset = var_0;
  var_4.range = var_1;
  var_4.maxdamage = var_2;
  var_4.mindamage = var_3;
  level.vehicle.templates.death_radiusdamage[level.vtclassname] = var_4;
}

build_rumble(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle.templates.rumble))
    level.vehicle.templates.rumble = [];

  var_6 = build_quake(var_1, var_2, var_3, var_4, var_5);
  precacherumble(var_0);
  var_6.rumble = var_0;
  level.vehicle.templates.rumble[level.vtclassname] = var_6;
}

build_deathquake(var_0, var_1, var_2) {
  var_3 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.death_earthquake))
    level.vehicle.templates.death_earthquake = [];

  level.vehicle.templates.death_earthquake[var_3] = build_quake(var_0, var_1, var_2);
}

build_quake(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.scale = var_0;
  var_5.duration = var_1;
  var_5.radius = var_2;

  if(isDefined(var_3))
    var_5.basetime = var_3;

  if(isDefined(var_4))
    var_5.randomaditionaltime = var_4;

  return var_5;
}

build_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_5))
    var_5 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 1;

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

build_deathfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.vehicle_death_fx[var_12]))
    level.vehicle.templates.vehicle_death_fx[var_12] = [];

  level.vehicle.templates.vehicle_death_fx[var_12][level.vehicle.templates.vehicle_death_fx[var_12].size] = build_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

build_rocket_deathfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.vehicle_death_fx[var_11]))
    level.vehicle.templates.vehicle_death_fx[var_11] = [];

  level.vehicle.templates.vehicle_rocket_death_fx[var_11][level.vehicle.templates.vehicle_death_fx[var_11].size] = build_fx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

build_deathanimations(var_0, var_1, var_2, var_3) {
  var_4 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.deathanimations[var_4]))
    level.vehicle.templates.deathanimations[var_4] = [];

  level.vehicle.templates.deathanimations[var_4]["_encstr_B42E085325A82CB3F221"] = var_0;
  level.vehicle.templates.deathanimations[var_4]["_encstr_8253060E2B5FE330"] = var_1;
  level.vehicle.templates.deathanimations[var_4]["_encstr_8D5B09262CD8B5EEB02719"] = var_2;
  level.vehicle.templates.deathanimations[var_4]["_encstr_A5AD056A019C63"] = var_3;
}

build_landanims(var_0) {
  var_1 = level.vtclassname;
  level.vehicle.templates.landanims[var_1] = [[var_0]]();
}

build_turret(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = level.vtclassname;

  if(!isDefined(level.vehicle.templates.mgturret[var_9]))
    level.vehicle.templates.mgturret[var_9] = [];

  var_10 = build_turret_struct(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  level.vehicle.templates.mgturret[var_9][level.vehicle.templates.mgturret[var_9].size] = var_10;
}

build_mainturret(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = level.vtclassname;

  if(isDefined(level.vehicle.templates.mainturret[var_8])) {}

  var_9 = build_turret_struct(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  level.vehicle.templates.mainturret[var_8] = var_9;
}

build_turret_struct(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  precachemodel(var_2);
  precacheturret(var_0);
  var_9 = spawnStruct();
  var_9.info = var_0;
  var_9.tag = var_1;
  var_9.model = var_2;
  var_9.defaultonmode = var_3;
  var_9.defaultdroppitch = var_4;
  var_9.defaultdropyaw = var_5;

  if(isDefined(var_6))
    var_9.offset_tag = var_6;

  if(isDefined(var_7))
    var_9.referencename = var_7;

  if(isDefined(var_8) && var_8)
    var_9.mainturretchild = var_8;

  return var_9;
}

build_light(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.vehicle.templates.vehicle_lights))
    level.vehicle.templates.vehicle_lights = [];

  if(!isDefined(level.vehicle.templates.vehicle_lights_group_override))
    level.vehicle.templates.vehicle_lights_group_override = [];

  if(isDefined(level.vehicle.templates.vehicle_lights_group_override[var_4]) && !level.vtoverride) {
    return;
  }
  var_6 = spawnStruct();
  var_6.name = var_1;
  var_6.tag = var_2;
  var_6.delay = var_5;
  var_6.effect = loadfx(var_3);
  level.vehicle.templates.vehicle_lights[var_0][var_1] = var_6;
  scripts\common\vehicle_lights::group_light(var_0, var_1, "_encstr_AF1904A7F929");

  if(isDefined(var_4))
    scripts\common\vehicle_lights::group_light(var_0, var_1, var_4);
}

build_hideparts(var_0, var_1) {
  if(!isDefined(level.vehicle.templates.hide_part_list))
    level.vehicle.templates.hide_part_list = [];

  level.vehicle.templates.hide_part_list[var_0] = var_1;
}

build_deathmodel(var_0, var_1) {
  if(var_0 != level.vtmodel) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = var_0;

  precachemodel(var_0);
  precachemodel(var_1);
  level.vehicle.templates.deathmodel[var_0] = var_1;
}

build_idle(var_0) {
  if(!isDefined(level.vehicle.templates.idle_anim))
    level.vehicle.templates.idle_anim = [];

  if(!isDefined(level.vehicle.templates.idle_anim[level.vtmodel]))
    level.vehicle.templates.idle_anim[level.vtmodel] = [];

  level.vehicle.templates.idle_anim[level.vtmodel][level.vehicle.templates.idle_anim[level.vtmodel].size] = var_0;
}

build_drive(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 10;

  level.vehicle.templates.driveidle[level.vtmodel] = var_0;

  if(isDefined(var_1))
    level.vehicle.templates.driveidle_r[level.vtmodel] = var_1;

  level.vehicle.templates.driveidle_normal_speed[level.vtmodel] = var_2;

  if(isDefined(var_3))
    level.vehicle.templates.driveidle_animrate[level.vtmodel] = var_3;
}

build_template(var_0, var_1, var_2, var_3) {
  scripts\common\vehicle_code::vehicle_setuplevelvariables();

  if(isDefined(var_2))
    var_0 = var_2;

  precachevehicle(var_0);
  level.vehicle.templates.team[var_3] = "_encstr_8E8405EA382B2A";
  level.vehicle.templates.life[var_3] = 999;
  level.vehicle.templates.has_main_turret[var_1] = 0;
  level.vehicle.templates.main_turrets[var_1] = [];
  level.vtmodel = var_1;
  level.vttype = var_0;
  level.vtclassname = var_3;
  level.vehicle.templates.model[var_3] = var_1;
}

build_exhaust(var_0) {
  level.vehicle.templates.exhaust_fx[level.vtmodel] = loadfx(var_0);
}

build_enginefx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_1))
    var_1 = "_encstr_933A0E1D2C3BFA2BDCB3963756D7990F";

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

build_treadfx(var_0, var_1, var_2, var_3) {
  if(!scripts\common\utility::issp()) {
    return;
  }
  if(isDefined(var_0)) {
    set_vehicle_effect(var_0, var_1, var_2);

    if(isDefined(var_3) && var_3) {
      set_vehicle_effect(var_0, var_1, var_2, "_encstr_85D80671C9373354");
      set_vehicle_effect(var_0, var_1, var_2, "_encstr_8D2309E159A7A3C4D9F157");
    }
  } else {
    var_0 = level.vtclassname;
    scripts\common\vehicle_treadfx::main();
  }
}

build_all_treadfx(var_0, var_1) {
  var_2 = get_surface_types();

  foreach(var_4 in var_2)
  set_vehicle_effect(var_0, var_4);
}

set_vehicle_effect(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vehicle.templates.surface_effects))
    level.vehicle.templates.surface_effects = [];

  if(isDefined(var_3)) {
    var_1 = var_1 + var_3;
    var_2 = var_2 + var_3;
  }

  if(isDefined(var_2))
    level.vehicle.templates.surface_effects[var_0][var_1] = loadfx(var_2);
  else if(isDefined(level.vehicle.templates.surface_effects[var_0]) && isDefined(level.vehicle.templates.surface_effects[var_0][var_1]))
    level.vehicle.templates.surface_effects[var_0][var_1] = undefined;
}

get_surface_types() {
  return ["_encstr_A71E069A1DB026AF", "_encstr_8B9B0598169CDA", "_encstr_9751076CB09C83B2E8", "_encstr_A99506D77CD5A833", "_encstr_95C70977B8306FF02D4BC5", "_encstr_96670551849240", "_encstr_8BA9066699BF7320", "_encstr_B2D10885A01AD8F94C4D", "_encstr_87D6063BD8163737", "_encstr_AF29063B1B66A72B", "_encstr_95760779B317B4A09D", "_encstr_921904C3D370", "_encstr_9BC806E72F38AFE8", "_encstr_B61904B6AB32", "_encstr_AAA7064B8083F5B3", "_encstr_ACC808E0C62C9B47B2C9", "_encstr_8A1F05937B366D", "_encstr_AB18059B2B98F7", "_encstr_97180566B03293", "_encstr_854C06DD0B8E959C", "_encstr_ABF605EEBD7B32", "_encstr_A35B08C7A707BA5950A3", "_encstr_A98008D0CB9047536256", "_encstr_8EC808C1B10BB9D1A58D", "_encstr_AF0F07BEFD03C15B0A", "_encstr_8BA30823CB8313313845", "_encstr_B6550650AB1570B1", "_encstr_B8DD0D702FA0B553AB5158029353E0", "_encstr_A5450BC280BF4B604068C33187", "_encstr_8D6C06F8D4A5560C", "_encstr_8B1608EC43B8D647A113"];
}

build_team(var_0) {
  level.vehicle.templates.team[level.vtclassname] = var_0;
}

build_bulletshield(var_0) {
  level.vehicle.templates.bullet_shield[level.vtclassname] = var_0;
}

build_grenadeshield(var_0) {
  level.vehicle.templates.grenade_shield[level.vtclassname] = var_0;
}

build_aianims(var_0, var_1, var_2) {
  var_3 = level.vtclassname;
  level.vehicle.templates.aianims[var_3] = [[var_0]]();

  if(isDefined(var_2) && isDefined(level.func) && isDefined(level.func["_encstr_A9C2139BCAD1EB9D56D0968D1B59EBC2DCA5B59B7D" + var_2]))
    level.vehicle.templates.aianims[var_3] = [[level.func["_encstr_A9C2139BCAD1EB9D56D0968D1B59EBC2DCA5B59B7D" + var_2]]](level.vehicle.templates.aianims[var_3]);
  else if(isDefined(var_1))
    level.vehicle.templates.aianims[var_3] = [[var_1]](level.vehicle.templates.aianims[var_3]);
}

build_attach_models(var_0) {
  level.vehicle.templates.attachedmodels[level.vtclassname] = [[var_0]]();
}

build_unload_groups(var_0) {
  level.vehicle.templates.unloadgroups[level.vtclassname] = [[var_0]]();
}

build_life(var_0, var_1, var_2) {
  var_3 = level.vtclassname;
  level.vehicle.templates.life[var_3] = var_0;
  level.vehicle.templates.life_range_low[var_3] = var_1;
  level.vehicle.templates.life_range_high[var_3] = var_2;
}

build_destructible(var_0, var_1) {}

build_localinit(var_0) {
  level.vehicleinitthread[level.vttype][level.vtclassname] = var_0;
}

build_atmo_types(var_0, var_1) {
  level.vehicle.templates.atmotypes[level.vtclassname]["_encstr_86840585A35BB7"] = var_0;
  level.vehicle.templates.atmotypes[level.vtclassname]["_encstr_AF8A061B6A1960CD"] = var_1;
}

build_ace(var_0) {
  level.vehicle.templates.aces[level.vtclassname] = var_0;
}

build_semiace(var_0) {
  level.vehicle.templates.semiaces[level.vtclassname] = var_0;
}

build_playercontrolled_model(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.playercontrolledmodel = var_0;
  var_2.worldmodel = var_1;
  precachemodel(var_0);
  level.vehicle.templates.vehicleplayermodel[level.vtclassname] = var_2;
}

build_is_helicopter(var_0) {
  if(!isDefined(level.vehicle.templates.helicopter_list))
    level.vehicle.templates.helicopter_list = [];

  if(!isDefined(var_0))
    var_0 = level.vttype;

  level.vehicle.templates.helicopter_list[var_0] = 1;
}

build_is_airplane(var_0) {
  if(!isDefined(level.vehicle.templates.airplane_list))
    level.vehicle.templates.airplane_list = [];

  if(!isDefined(var_0))
    var_0 = level.vttype;

  level.vehicle.templates.airplane_list[var_0] = 1;
}

build_single_tread(var_0) {
  if(!isDefined(level.vehicle.templates.single_tread_list))
    level.vehicle.templates.single_tread_list = [];

  if(!isDefined(var_0))
    var_0 = level.vttype;

  level.vehicle.templates.single_tread_list[var_0] = 1;
}

build_rider_death_func(var_0) {
  if(!isDefined(level.vehicle.templates.rider_death_func))
    level.vehicle.templates.rider_death_func = [];

  level.vehicle.templates.rider_death_func[level.vtclassname] = var_0;
}