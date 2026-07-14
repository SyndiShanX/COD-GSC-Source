/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_build.gsc
********************************************/

#using scripts\common\utility;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_lights;
#using scripts\common\vehicle_treadfx;
#using scripts\engine\utility;
#namespace vehicle_build;

function build_radiusdamage(offset, range, maxdamage, mindamage) {
  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  struct = spawnStruct();
  struct.offset = offset;
  struct.range = range;
  struct.maxdamage = maxdamage;
  struct.mindamage = mindamage;
  level.vehicle.templates.death_radiusdamage[level.vtclassname] = struct;
}

function build_rumble(rumble, scale, duration, radius, basetime, randomaditionaltime) {
  if(!isDefined(level.vehicle.templates.rumble)) {
    level.vehicle.templates.rumble = [];
  }

  struct = build_quake(scale, duration, radius, basetime, randomaditionaltime);
  assert(isDefined(rumble));
  precacherumble(rumble);
  struct.rumble = rumble;
  level.vehicle.templates.rumble[level.vtclassname] = struct;
}

function build_deathquake(scale, duration, radius) {
  classname = level.vtclassname;

  if(!isDefined(level.vehicle.templates.death_earthquake)) {
    level.vehicle.templates.death_earthquake = [];
  }

  level.vehicle.templates.death_earthquake[classname] = build_quake(scale, duration, radius);
}

function build_quake(scale, duration, radius, basetime, randomaditionaltime) {
  struct = spawnStruct();
  struct.scale = scale;
  struct.duration = duration;
  struct.radius = radius;

  if(isDefined(basetime)) {
    struct.basetime = basetime;
  }

  if(isDefined(randomaditionaltime)) {
    struct.randomaditionaltime = randomaditionaltime;
  }

  return struct;
}

function build_fx(effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, selfdeletedelay, remove_deathfx_entity_delay, attacker_velocity_lerp) {
  if(!isDefined(bsoundlooping)) {
    bsoundlooping = 0;
  }

  if(!isDefined(beffectlooping)) {
    beffectlooping = 0;
  }

  if(!isDefined(delay)) {
    delay = 1;
  }

  struct = spawnStruct();
  struct.effect = utility::load_fx(effect);
  struct.tag = tag;
  struct.sound = sound;
  struct.bsoundlooping = bsoundlooping;
  struct.delay = delay;
  struct.waitdelay = waitdelay;
  struct.stayontag = stayontag;
  struct.notifystring = notifystring;
  struct.beffectlooping = beffectlooping;
  struct.selfdeletedelay = selfdeletedelay;
  struct.remove_deathfx_entity_delay = remove_deathfx_entity_delay;
  struct.attacker_velocity_lerp = attacker_velocity_lerp;
  return struct;
}

function build_deathfx(effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, delete_vehicle_delay, remove_deathfx_entity_delay, attacker_velocity_lerp) {
  assert(isDefined(effect), "<dev string:x24>");
  classname = level.vtclassname;

  if(!isDefined(level.vehicle.templates.vehicle_death_fx[classname])) {
    level.vehicle.templates.vehicle_death_fx[classname] = [];
  }

  level.vehicle.templates.vehicle_death_fx[classname][level.vehicle.templates.vehicle_death_fx[classname].size] = build_fx(effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, delete_vehicle_delay, remove_deathfx_entity_delay, attacker_velocity_lerp);
}

function build_rocket_deathfx(effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, delete_vehicle_delay, remove_deathfx_entity_delay) {
  assert(isDefined(effect), "<dev string:x24>");
  classname = level.vtclassname;

  if(!isDefined(level.vehicle.templates.vehicle_rocket_death_fx[classname])) {
    level.vehicle.templates.vehicle_rocket_death_fx[classname] = [];
  }

  level.vehicle.templates.vehicle_rocket_death_fx[classname][level.vehicle.templates.vehicle_rocket_death_fx[classname].size] = build_fx(effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, delete_vehicle_delay, remove_deathfx_entity_delay);
}

function function_7f52823cfdedd8db(effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring) {
  assert(isDefined(effect), "<dev string:x24>");
  classname = level.vtclassname;
  level.vehicle.templates.var_5cc6ecb6fb44af7c[classname] = build_fx(effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring);
}

function build_deathanimations(forwardanimation, rightanimation, backwardanimation, leftanimation) {
  assert(isDefined(forwardanimation), "<dev string:x8e>" + level.vtclassname);
  assert(isDefined(rightanimation), "<dev string:xbb>" + level.vtclassname);
  assert(isDefined(backwardanimation), "<dev string:xe6>" + level.vtclassname);
  assert(isDefined(leftanimation), "<dev string:x114>" + level.vtclassname);
  classname = level.vtclassname;

  if(!isDefined(level.vehicle.templates.deathanimations[classname])) {
    level.vehicle.templates.deathanimations[classname] = [];
  }

  level.vehicle.templates.deathanimations[classname]["forward"] = forwardanimation;
  level.vehicle.templates.deathanimations[classname]["right"] = rightanimation;
  level.vehicle.templates.deathanimations[classname]["backward"] = backwardanimation;
  level.vehicle.templates.deathanimations[classname]["left"] = leftanimation;
}

function build_turret(info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename, mainturretchild) {
  classname = level.vtclassname;

  if(!isDefined(level.vehicle.templates.mgturret[classname])) {
    level.vehicle.templates.mgturret[classname] = [];
  }

  struct = build_turret_struct(info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename, mainturretchild);
  level.vehicle.templates.mgturret[classname][level.vehicle.templates.mgturret[classname].size] = struct;
}

function build_mainturret(info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename) {
  classname = level.vtclassname;

  if(isDefined(level.vehicle.templates.mainturret[classname])) {
    assertmsg("<dev string:x13e>");
  }

  struct = build_turret_struct(info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename);
  level.vehicle.templates.mainturret[classname] = struct;
}

function build_turret_struct(info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename, mainturretchild) {
  precachemodel(model);
  precacheturret(info);
  struct = spawnStruct();
  struct.info = info;
  struct.tag = tag;
  struct.model = model;
  struct.defaultonmode = defaultonmode;
  struct.defaultdroppitch = defaultdroppitch;
  struct.defaultdropyaw = defaultdropyaw;

  if(isDefined(offset_tag)) {
    struct.offset_tag = offset_tag;
  }

  if(isDefined(referencename)) {
    struct.referencename = referencename;
  }

  if(mainturretchild) {
    struct.mainturretchild = mainturretchild;
  }

  return struct;
}

function build_light(classname, name, tag, effect, group, delay) {
  if(!isDefined(level.vehicle.templates.vehicle_lights)) {
    level.vehicle.templates.vehicle_lights = [];
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group_override)) {
    level.vehicle.templates.vehicle_lights_group_override = [];
  }

  if(isDefined(level.vehicle.templates.vehicle_lights_group_override[group]) && !level.vtoverride) {
    return;
  }

  struct = spawnStruct();
  struct.name = name;
  struct.tag = tag;
  struct.delay = delay;
  struct.effect = utility::load_fx(effect);
  level.vehicle.templates.vehicle_lights[classname][name] = struct;
  vehicle_lights::group_light(classname, name, "all");

  if(isDefined(group)) {
    vehicle_lights::group_light(classname, name, group);
  }
}

function function_b446834d4287bfdf(classname, name, part, group, delay, var_3b8d5cf93766831c) {
  if(!isDefined(level.vehicle.templates.vehicle_lights)) {
    level.vehicle.templates.vehicle_lights = [];
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group_override)) {
    level.vehicle.templates.vehicle_lights_group_override = [];
  }

  if(isDefined(level.vehicle.templates.vehicle_lights_group_override[group]) && !level.vtoverride) {
    return;
  }

  struct = spawnStruct();
  struct.name = name;
  struct.part = part;
  struct.delay = delay;
  struct.isscriptable = 1;
  level.vehicle.templates.vehicle_lights[classname][name] = struct;

  if(!isDefined(var_3b8d5cf93766831c) || var_3b8d5cf93766831c == 0) {
    vehicle_lights::group_light(classname, name, "all");
  }

  if(isDefined(group)) {
    vehicle_lights::group_light(classname, name, group);
  }
}

function build_hideparts(classname, parts_array) {
  assert(isDefined(classname));
  assert(isDefined(parts_array));

  if(!isDefined(level.vehicle.templates.hide_part_list)) {
    level.vehicle.templates.hide_part_list = [];
  }

  level.vehicle.templates.hide_part_list[classname] = parts_array;
}

function build_deathmodel(model, deathmodel) {
  if(model != level.vtmodel) {
    return;
  }

  if(!isDefined(deathmodel)) {
    deathmodel = model;
  }

  precachemodel(model);
  precachemodel(deathmodel);
  level.vehicle.templates.deathmodel[model] = deathmodel;
}

function build_husk(model, huskmodel, type, var_d941668d6444bf8f) {
  if(model != level.vtmodel) {
    return;
  }

  assert(isDefined(huskmodel), "<dev string:x167>");
  assert(isDefined(type), "<dev string:x18b>");
  precachemodel(model);
  precachemodel(huskmodel);
  level.vehicle.templates.husk[model] = huskmodel;
  level.vehicle.templates.husktype[model] = type;

  if(!isDefined(var_d941668d6444bf8f)) {
    var_d941668d6444bf8f = 1;
  }

  level.vehicle.templates.var_bc8fe258d26d514[model] = var_d941668d6444bf8f;
}

function build_drive(forward, reverse, normalspeed, rate) {
  if(!isDefined(normalspeed)) {
    normalspeed = 10;
  }

  level.vehicle.templates.driveidle[level.vtmodel] = forward;

  if(isDefined(reverse)) {
    level.vehicle.templates.driveidle_r[level.vtmodel] = reverse;
  }

  level.vehicle.templates.driveidle_normal_speed[level.vtmodel] = normalspeed;

  if(isDefined(rate)) {
    level.vehicle.templates.driveidle_animrate[level.vtmodel] = rate;
  }
}

function build_template(class, model, type, classname) {
  vehicle_code::vehicle_setuplevelvariables();

  if(!isDefined(type)) {
    type = class;
  }

  assert(isDefined(classname), "<dev string:x1ac>");
  precachevehicle(type);
  level.vehicle.templates.type[classname] = type;
  level.vehicle.templates.team[classname] = "neutral";
  level.vehicle.templates.has_main_turret[model] = 0;
  level.vehicle.templates.main_turrets[model] = [];
  level.vtmodel = model;
  level.vttype = type;
  level.vtclassname = classname;
  level.vehicle.templates.model[classname] = model;

  switch (class) {
    case #"hash_37e412543c51c9ec":
      build_life(10000, 9500, 10500);
      build_deathquake(1, 1.6, 500);
      level.vehicle.templates.explosivehits[classname] = 2;
      break;
    case #"hash_b626ccb5ac25b9c":
    case #"hash_68cb10ac5667e070":
      build_life(9000, 8750, 9250);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 500, 120, 20);
      level.vehicle.templates.explosivehits[classname] = 2;
      break;
    case #"hash_e88686bc1d16bcea":
      build_life(12000, 11750, 12250);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 500, 120, 20);
      level.vehicle.templates.explosivehits[classname] = 2;
      break;
    case #"hash_178f2685991a7482":
      build_life(20000, 19000, 21000);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 500, 120, 20);
      level.vehicle.templates.explosivehits[classname] = 5;
      break;
    case #"hash_290903a1af40c196":
      build_life(4000, 3750, 4250);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 400, 120, 20);
      level.vehicle.templates.explosivehits[classname] = 1;
      break;
    case #"hash_479ffef06a7cc84e":
      build_life(10000, 9500, 10500);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 400, 120, 20);
      level.vehicle.templates.explosivehits[classname] = 2;
      break;
    case #"hash_c93466c10cc10ba":
    case #"hash_619324ebc667112c":
    case #"hash_79dd32c8d8093d05":
    case #"hash_895a2c6c51da0091":
      build_life(2500, 2300, 2700);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 400, 120, 20);
      level.vehicle.templates.explosivehits[classname] = 0;
      break;
    case #"hash_1a86166c17e05dc1":
    case #"hash_7ec20b2ed0c1c55b":
    case #"hash_bd2b14a6c78f31a8":
    default:
      build_life(2500, 2300, 2700);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 400, 120, 20);
      level.vehicle.templates.explosivehits[classname] = 1;
      break;
  }
}

function function_ff2a7dd585b6ae27(vehicleref, vehicleclass) {
  if(isxhashasset(vehicleref)) {
    bundle = getscriptbundle(vehicleref);
    classname = bundle.ref;
  } else {
    classname = vehicleref;
    bundlename = classname + "_sp";
    bundle = getscriptbundle("vehiclebundle:" + bundlename);
  }

  if(!isDefined(bundle)) {
    return false;
  }

  if(isDefined(bundle.compositemodel)) {
    model = bundle.compositemodel;
  } else {
    model = bundle.model;
  }

  type = bundle.vehicle;

  if(!(isDefined(model) && isDefined(type))) {
    return false;
  }

  build_template(vehicleclass, model, type, classname);

  if(bundle.husk.hashusk) {
    if(isDefined(bundle.husk.compositemodel)) {
      huskmodel = bundle.husk.compositemodel;
    } else if(isDefined(bundle.husk.model)) {
      huskmodel = bundle.husk.model;
    } else {
      huskmodel = model;
    }

    if(isDefined(bundle.husk.vehicle)) {
      huskvehicle = bundle.husk.vehicle;
    } else {
      huskvehicle = type;
    }

    build_husk(model, huskmodel, huskvehicle, 0);
  }

  if(bundle.ai.supportsai) {
    assert(isDefined(bundle.ai.vehicleanimalias) && bundle.ai.vehicleanimalias != "<dev string:x1cb>", "<dev string:x1cf>" + getxhashsourcename(vehicleref));
    unload_groups = [];
    unload_groups["default"] = [];
    unload_groups["all"] = [];

    foreach(index, seatdata in bundle.aiseats) {
      if(isDefined(seatdata.vehicle_getinanim) && isDefined(seatdata.vehicle_getinanim.id)) {
        seatdata.vehicle_getinanim = seatdata.vehicle_getinanim.id;
      } else {
        seatdata.vehicle_getinanim = undefined;
      }

      if(isDefined(seatdata.vehicle_getinanim_combat) && isDefined(seatdata.vehicle_getinanim_combat.id)) {
        seatdata.vehicle_getinanim = seatdata.vehicle_getinanim_combat.id;
      } else {
        seatdata.vehicle_getinanim = undefined;
      }

      if(isDefined(seatdata.vehicle_getoutanim) && isDefined(seatdata.vehicle_getoutanim.id)) {
        seatdata.vehicle_getoutanim = seatdata.vehicle_getoutanim.id;
      } else {
        seatdata.vehicle_getoutanim = undefined;
      }

      if(isDefined(seatdata.linkoffset)) {
        x = seatdata.linkoffset.x ?? 0;
        y = seatdata.linkoffset.y ?? 0;
        z = seatdata.linkoffset.z ?? 0;

        if(x != 0 || y != 0 || z != 0) {
          seatdata.linkoffset = (x, y, z);
          seatdata.linkangle = (0, 0, 0);
        } else {
          seatdata.linkoffset = undefined;
        }
      }

      if(isDefined(bundle.aianimations) && isDefined(bundle.aianimations[index])) {
        animationdata = bundle.aianimations[index];

        if(isDefined(animationdata.idle) && isDefined(animationdata.idle.id)) {
          seatdata.idle = animationdata.idle.id;
        }

        if(isDefined(animationdata.getin) && isDefined(animationdata.getin.id)) {
          seatdata.getin = animationdata.getin.id;
        }

        if(isDefined(animationdata.getout) && isDefined(animationdata.getout.id)) {
          seatdata.getout = animationdata.getout.id;
        }

        if(isDefined(animationdata.death) && isDefined(animationdata.death.id)) {
          seatdata.death = animationdata.death.id;
        }

        if(isDefined(animationdata.ragdoll_fall_anim) && isDefined(animationdata.ragdoll_fall_anim.id)) {
          seatdata.ragdoll_fall_anim = animationdata.ragdoll_fall_anim.id;
        }

        if(isDefined(animationdata.idle_anim) && animationdata.idle_anim != "") {
          seatdata.idle_anim = animationdata.idle_anim;
        }
      }

      if(!seatdata.do_not_unload) {
        unload_groups["default"][unload_groups["default"].size] = index;
        unload_groups["all"][unload_groups["all"].size] = index;
      }
    }

    foreach(extraunloadgroup in bundle.unloadgroups) {
      unload_groups[extraunloadgroup.name] = [];

      foreach(index, seatdata in extraunloadgroup.seats) {
        unload_groups[extraunloadgroup.name][unload_groups[extraunloadgroup.name].size] = seatdata.seatindex;
      }
    }

    bundle.unloadgroups = undefined;
    bundle.aianimations = undefined;
    assign_aianims(bundle.aiseats, bundle.ai.vehicleanimalias);
    assign_unload_groups(unload_groups);
  }

  return true;
}

function build_treadfx(classname, type, fx, do_wash) {
  if(!utility::issp()) {
    return;
  }

  if(isDefined(classname)) {
    set_vehicle_effect(classname, type, fx);

    if(do_wash) {
      set_vehicle_effect(classname, type, fx, "_bank");
      set_vehicle_effect(classname, type, fx, "_bank_lg");
    }

    return;
  }

  classname = level.vtclassname;
  vehicle_treadfx::main();
}

function build_all_treadfx(classname, fx) {
  types = get_surface_types();

  foreach(type in types) {
    set_vehicle_effect(classname, type);
  }
}

function set_vehicle_effect(classname, material, fx, suffix) {
  if(!isDefined(level.vehicle.templates.surface_effects)) {
    level.vehicle.templates.surface_effects = [];
  }

  if(isDefined(suffix)) {
    material += suffix;
    fx += suffix;
  }

  if(isDefined(fx)) {
    level.vehicle.templates.surface_effects[classname][material] = utility::load_fx(fx);
    return;
  }

  if(isDefined(level.vehicle.templates.surface_effects[classname]) && isDefined(level.vehicle.templates.surface_effects[classname][material])) {
    level.vehicle.templates.surface_effects[classname][material] = undefined;
  }
}

function get_surface_types() {
  return ["brick", "bark", "carpet", "cloth", "concrete", "dirt", "flesh", "foliage", "glass", "grass", "gravel", "ice", "metal", "mud", "paper", "plaster", "rock", "sand", "snow", "water", "wood", "asphalt", "ceramic", "plastic", "rubber", "cushion", "fruit", "paintedmetal", "riotshield", "slush", "default"];
}

function build_team(team) {
  level.vehicle.templates.team[level.vtclassname] = team;
}

function build_bulletshield(bshield) {
  assert(isDefined(bshield));
  level.vehicle.templates.bullet_shield[level.vtclassname] = bshield;
}

function build_grenadeshield(bshield) {
  assert(isDefined(bshield));
  level.vehicle.templates.grenade_shield[level.vtclassname] = bshield;
}

function function_e193637d7025cbb1(weaponarray) {
  assert(isDefined(weaponarray));
  level.vehicle.templates.var_d499c951c21f6dbb[level.vtclassname] = weaponarray;
}

function function_b1b60a52dca51a1c(bshield) {
  assert(isDefined(bshield));
  level.vehicle.templates.collision_shield[level.vtclassname] = bshield;
}

function build_aianims(aithread, vehiclethread, vehicleanimalias) {
  classname = level.vtclassname;
  level.vehicle.templates.aianims[classname] = [[aithread]]();

  if(isDefined(level.func) && isDefined(vehicleanimalias) && isDefined(level.func["set_vehicle_anims_" + vehicleanimalias])) {
    level.vehicle.templates.aianims[classname] = [[level.func["set_vehicle_anims_" + vehicleanimalias]]](level.vehicle.templates.aianims[classname]);
    return;
  }

  if(isDefined(vehiclethread)) {
    level.vehicle.templates.aianims[classname] = [[vehiclethread]](level.vehicle.templates.aianims[classname]);
  }
}

function assign_aianims(aithreadresult, vehicleanimalias) {
  classname = level.vtclassname;
  level.vehicle.templates.aianims[classname] = aithreadresult;

  if(isDefined(level.func) && isDefined(vehicleanimalias) && isDefined(level.func["set_vehicle_anims_" + vehicleanimalias])) {
    level.vehicle.templates.aianims[classname] = [[level.func["set_vehicle_anims_" + vehicleanimalias]]](level.vehicle.templates.aianims[classname]);
  }
}

function build_attach_models(modelsthread) {
  level.vehicle.templates.attachedmodels[level.vtclassname] = [[modelsthread]]();
}

function function_b36241dc6dbc0ab4(attachmodels) {
  level.vehicle.templates.attachedmodels[level.vtclassname] = attachmodels;
}

function build_unload_groups(unloadgroupsthread) {
  level.vehicle.templates.unloadgroups[level.vtclassname] = [[unloadgroupsthread]]();
}

function assign_unload_groups(unloadgroups) {
  level.vehicle.templates.unloadgroups[level.vtclassname] = unloadgroups;
}

function build_life(health, minhealth, maxhealth) {
  classname = level.vtclassname;
  level.vehicle.templates.life[classname] = health;
  level.vehicle.templates.life_range_low[classname] = minhealth;
  level.vehicle.templates.life_range_high[classname] = maxhealth;
}

function build_localinit(init_thread) {
  level.vehicleinitthread[getxhashasset(level.vttype)][level.vtclassname] = init_thread;
}

function build_is_helicopter(vehicle_type) {
  if(!isDefined(level.vehicle.templates.helicopter_list)) {
    level.vehicle.templates.helicopter_list = [];
  }

  if(!isDefined(vehicle_type)) {
    vehicle_type = level.vttype;
  }

  level.vehicle.templates.helicopter_list[getxhashasset(vehicle_type)] = 1;
}

function build_is_boat(vehicle_type) {
  if(!isDefined(level.vehicle.templates.boat_list)) {
    level.vehicle.templates.boat_list = [];
  }

  if(!isDefined(vehicle_type)) {
    vehicle_type = level.vttype;
  }

  level.vehicle.templates.boat_list[getxhashasset(vehicle_type)] = 1;
}

function build_is_airplane(vehicle_type) {
  if(!isDefined(level.vehicle.templates.airplane_list)) {
    level.vehicle.templates.airplane_list = [];
  }

  if(!isDefined(vehicle_type)) {
    vehicle_type = level.vttype;
  }

  level.vehicle.templates.airplane_list[getxhashasset(vehicle_type)] = 1;
}

function build_is_tank(vehicle_type) {
  if(!isDefined(level.vehicle.templates.tank_list)) {
    level.vehicle.templates.tank_list = [];
  }

  if(!isDefined(vehicle_type)) {
    vehicle_type = level.vttype;
  }

  level.vehicle.templates.tank_list[getxhashasset(vehicle_type)] = 1;
}

function build_rider_death_func(func) {
  if(!isDefined(level.vehicle.templates.rider_death_func)) {
    level.vehicle.templates.rider_death_func = [];
  }

  level.vehicle.templates.rider_death_func[level.vtclassname] = func;
}

function build_iw9physics(classname, vehicletype, init_thread) {
  level.vehicle.templates.iw9physics[classname] = vehicletype;
  level.vehicleinitthread[getxhashasset(vehicletype)][classname] = init_thread;
}

function build_hud(classname, index) {
  level.vehicle.templates.hudindex[classname] = index;
}

function build_dependentparts(classname, parentbone, childbones) {
  if(!isDefined(level.vehicle.templates.dependentparts)) {
    level.vehicle.templates.dependentparts = [];
  }

  if(!isarray(childbones)) {
    childbones = [childbones];
  }

  level.vehicle.templates.dependentparts[classname][parentbone] = childbones;
}