/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_build.gsc
***********************************************/

build_radiusdamage(offset, range, maxdamage, mindamage) {
  if(!isDefined(offset))
    offset = (0, 0, 0);

  struct = spawnStruct();
  struct.offset = offset;
  struct.range = range;
  struct.maxdamage = maxdamage;
  struct.mindamage = mindamage;
  level.vehicle.templates.death_radiusdamage[level.vtclassname] = struct;
}

build_rumble(rumble, scale, duration, radius, basetime, randomaditionaltime) {
  if(!isDefined(level.vehicle.templates.rumble))
    level.vehicle.templates.rumble = [];

  struct = build_quake(scale, duration, radius, basetime, randomaditionaltime);
  precacherumble(rumble);
  struct.rumble = rumble;
  level.vehicle.templates.rumble[level.vtclassname] = struct;
}

build_deathquake(scale, duration, radius) {
  classname = level.vtclassname;

  if(!isDefined(level.vehicle.templates.death_earthquake))
    level.vehicle.templates.death_earthquake = [];

  level.vehicle.templates.death_earthquake[classname] = build_quake(scale, duration, radius);
}

build_quake(scale, duration, radius, basetime, randomaditionaltime) {
  struct = spawnStruct();
  struct.scale = scale;
  struct.duration = duration;
  struct.radius = radius;

  if(isDefined(basetime))
    struct.basetime = basetime;

  if(isDefined(randomaditionaltime))
    struct.randomaditionaltime = randomaditionaltime;

  return struct;
}

build_fx(effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, selfdeletedelay, remove_deathfx_entity_delay, attacker_velocity_lerp) {
  if(!isDefined(bsoundlooping))
    bsoundlooping = 0;

  if(!isDefined(beffectlooping))
    beffectlooping = 0;

  if(!isDefined(delay))
    delay = 1;

  struct = spawnStruct();
  struct.effect = loadfx(effect);
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

build_deathfx(effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, _id_5B457EDCFF6FA295, remove_deathfx_entity_delay, attacker_velocity_lerp) {
  classname = level.vtclassname;

  if(!isDefined(level.vehicle.templates.vehicle_death_fx[classname]))
    level.vehicle.templates.vehicle_death_fx[classname] = [];

  level.vehicle.templates.vehicle_death_fx[classname][level.vehicle.templates.vehicle_death_fx[classname].size] = build_fx(effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, _id_5B457EDCFF6FA295, remove_deathfx_entity_delay, attacker_velocity_lerp);
}

build_rocket_deathfx(effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, _id_5B457EDCFF6FA295, remove_deathfx_entity_delay) {
  classname = level.vtclassname;

  if(!isDefined(level.vehicle.templates.vehicle_death_fx[classname]))
    level.vehicle.templates.vehicle_death_fx[classname] = [];

  level.vehicle.templates.vehicle_rocket_death_fx[classname][level.vehicle.templates.vehicle_death_fx[classname].size] = build_fx(effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring, _id_5B457EDCFF6FA295, remove_deathfx_entity_delay);
}

build_deathanimations(_id_04A32601CC0B7DCC, _id_DE6189ED34354801, _id_9ECAE3DA61774D2E, _id_DA007C9CD223AE3A) {
  classname = level.vtclassname;

  if(!isDefined(level.vehicle.templates.deathanimations[classname]))
    level.vehicle.templates.deathanimations[classname] = [];

  level.vehicle.templates.deathanimations[classname]["forward"] = _id_04A32601CC0B7DCC;
  level.vehicle.templates.deathanimations[classname]["right"] = _id_DE6189ED34354801;
  level.vehicle.templates.deathanimations[classname]["backward"] = _id_9ECAE3DA61774D2E;
  level.vehicle.templates.deathanimations[classname]["left"] = _id_DA007C9CD223AE3A;
}

build_landanims(_id_30FC9B2B4EFD0FE0) {
  classname = level.vtclassname;
  level.vehicle.templates.landanims[classname] = [[_id_30FC9B2B4EFD0FE0]]();
}

build_turret(info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename, mainturretchild) {
  classname = level.vtclassname;

  if(!isDefined(level.vehicle.templates.mgturret[classname]))
    level.vehicle.templates.mgturret[classname] = [];

  struct = build_turret_struct(info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename, mainturretchild);
  level.vehicle.templates.mgturret[classname][level.vehicle.templates.mgturret[classname].size] = struct;
}

build_mainturret(info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename) {
  classname = level.vtclassname;

  if(isDefined(level.vehicle.templates.mainturret[classname])) {}

  struct = build_turret_struct(info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename);
  level.vehicle.templates.mainturret[classname] = struct;
}

build_turret_struct(info, tag, model, defaultonmode, defaultdroppitch, defaultdropyaw, offset_tag, referencename, mainturretchild) {
  precachemodel(model);
  precacheturret(info);
  struct = spawnStruct();
  struct.info = info;
  struct.tag = tag;
  struct.model = model;
  struct.defaultonmode = defaultonmode;
  struct.defaultdroppitch = defaultdroppitch;
  struct.defaultdropyaw = defaultdropyaw;

  if(isDefined(offset_tag))
    struct.offset_tag = offset_tag;

  if(isDefined(referencename))
    struct.referencename = referencename;

  if(isDefined(mainturretchild) && mainturretchild)
    struct.mainturretchild = mainturretchild;

  return struct;
}

build_light(classname, name, tag, effect, group, delay) {
  if(!isDefined(level.vehicle.templates.vehicle_lights))
    level.vehicle.templates.vehicle_lights = [];

  if(!isDefined(level.vehicle.templates.vehicle_lights_group_override))
    level.vehicle.templates.vehicle_lights_group_override = [];

  if(isDefined(level.vehicle.templates.vehicle_lights_group_override[group]) && !level.vtoverride) {
    return;
  }
  struct = spawnStruct();
  struct.name = name;
  struct.tag = tag;
  struct.delay = delay;
  struct.effect = loadfx(effect);
  level.vehicle.templates.vehicle_lights[classname][name] = struct;
  scripts\common\vehicle_lights::group_light(classname, name, "all");

  if(isDefined(group))
    scripts\common\vehicle_lights::group_light(classname, name, group);
}

_id_2CF37D073C6BDE84(classname, name, part, group, delay, _id_22ED434F33B345AF) {
  if(!isDefined(level.vehicle.templates.vehicle_lights))
    level.vehicle.templates.vehicle_lights = [];

  if(!isDefined(level.vehicle.templates.vehicle_lights_group_override))
    level.vehicle.templates.vehicle_lights_group_override = [];

  if(isDefined(level.vehicle.templates.vehicle_lights_group_override[group]) && !level.vtoverride) {
    return;
  }
  struct = spawnStruct();
  struct.name = name;
  struct.part = part;
  struct.delay = delay;
  struct.isscriptable = 1;
  level.vehicle.templates.vehicle_lights[classname][name] = struct;

  if(!isDefined(_id_22ED434F33B345AF) || _id_22ED434F33B345AF == 0)
    scripts\common\vehicle_lights::group_light(classname, name, "all");

  if(isDefined(group))
    scripts\common\vehicle_lights::group_light(classname, name, group);
}

build_hideparts(classname, _id_A5CED284F97867DB) {
  if(!isDefined(level.vehicle.templates.hide_part_list))
    level.vehicle.templates.hide_part_list = [];

  level.vehicle.templates.hide_part_list[classname] = _id_A5CED284F97867DB;
}

build_deathmodel(model, deathmodel) {
  if(model != level.vtmodel) {
    return;
  }
  if(!isDefined(deathmodel))
    deathmodel = model;

  precachemodel(model);
  precachemodel(deathmodel);
  level.vehicle.templates.deathmodel[model] = deathmodel;
}

_id_98128821320ABA35(model, _id_12A4C0B2EEB1DB9D, type, _id_CB3CC2D75D941670) {
  if(model != level.vtmodel) {
    return;
  }
  precachemodel(model);
  precachemodel(_id_12A4C0B2EEB1DB9D);
  level.vehicle.templates._id_FB41D1CA75009BF0[model] = _id_12A4C0B2EEB1DB9D;
  level.vehicle.templates._id_CFB2CE4545421678[model] = type;

  if(!isDefined(_id_CB3CC2D75D941670))
    _id_CB3CC2D75D941670 = 1;

  level.vehicle.templates._id_893DA51CF12B2C8B[model] = _id_CB3CC2D75D941670;
}

build_idle(animation) {
  if(!isDefined(level.vehicle.templates.idle_anim))
    level.vehicle.templates.idle_anim = [];

  if(!isDefined(level.vehicle.templates.idle_anim[level.vtmodel]))
    level.vehicle.templates.idle_anim[level.vtmodel] = [];

  level.vehicle.templates.idle_anim[level.vtmodel][level.vehicle.templates.idle_anim[level.vtmodel].size] = animation;
}

build_drive(forward, reverse, normalspeed, rate) {
  if(!isDefined(normalspeed))
    normalspeed = 10;

  level.vehicle.templates.driveidle[level.vtmodel] = forward;

  if(isDefined(reverse))
    level.vehicle.templates.driveidle_r[level.vtmodel] = reverse;

  level.vehicle.templates.driveidle_normal_speed[level.vtmodel] = normalspeed;

  if(isDefined(rate))
    level.vehicle.templates.driveidle_animrate[level.vtmodel] = rate;
}

build_template(class, model, type, classname) {
  scripts\common\vehicle_code::vehicle_setuplevelvariables();

  if(!isDefined(type))
    type = class;

  precachevehicle(type);
  level.vehicle.templates.team[classname] = "neutral";
  level.vehicle.templates.has_main_turret[model] = 0;
  level.vehicle.templates.main_turrets[model] = [];
  level.vtmodel = model;
  level.vttype = type;
  level.vtclassname = classname;
  level.vehicle.templates.model[classname] = model;

  switch (class) {
    case "husk":
      build_life(10000, 9500, 10500);
      build_deathquake(1, 1.6, 500);
      level.vehicle.templates._id_EBD1D83C2799EF12[classname] = 2;
      break;
    case "milarmor":
    case "blima":
      build_life(9000, 8750, 9250);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 500, 120, 20);
      level.vehicle.templates._id_EBD1D83C2799EF12[classname] = 2;
      break;
    case "milarmorbig":
      build_life(12000, 11750, 12250);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 500, 120, 20);
      level.vehicle.templates._id_EBD1D83C2799EF12[classname] = 2;
      break;
    case "coscar":
      build_life(20000, 19000, 21000);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 500, 120, 20);
      level.vehicle.templates._id_EBD1D83C2799EF12[classname] = 5;
      break;
    case "truckbig":
      build_life(4000, 3750, 4250);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 400, 120, 20);
      level.vehicle.templates._id_EBD1D83C2799EF12[classname] = 1;
      break;
    case "trucksemi":
      build_life(10000, 9500, 10500);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 400, 120, 20);
      level.vehicle.templates._id_EBD1D83C2799EF12[classname] = 2;
      break;
    case "lbravo":
    case "atv":
    case "motorcycle":
    case "pwc":
      build_life(2500, 2300, 2700);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 400, 120, 20);
      level.vehicle.templates._id_EBD1D83C2799EF12[classname] = 0;
      break;
    case "truck":
    case "boat":
    case "car":
    default:
      build_life(2500, 2300, 2700);
      build_deathquake(1, 1.6, 500);
      build_radiusdamage((0, 0, 0), 400, 120, 20);
      level.vehicle.templates._id_EBD1D83C2799EF12[classname] = 1;
      break;
  }
}

build_exhaust(effect) {
  level.vehicle.templates.exhaust_fx[level.vtmodel] = loadfx(effect);
}

build_enginefx(effect, effect_tag, _id_AADDBB03C1FCC213, _id_5518C3038395A8AC, _id_DAAE31D1181D4443, _id_857639D0DA517CBC, _id_7F3BAF48A89E1EE5, _id_D4F8A348E6FD43D2) {
  if(!isDefined(effect_tag))
    effect_tag = "tag_engine_fx";

  struct = spawnStruct();
  struct.effect = loadfx(effect);
  struct.effect_tag = effect_tag;

  if(isDefined(_id_AADDBB03C1FCC213)) {
    struct.max_effort_effect = loadfx(_id_AADDBB03C1FCC213);
    struct.max_effort_ratio = _id_5518C3038395A8AC;
  }

  if(isDefined(_id_DAAE31D1181D4443)) {
    struct.med_effort_effect = loadfx(_id_DAAE31D1181D4443);
    struct.med_effort_ratio = _id_857639D0DA517CBC;
  }

  if(isDefined(_id_7F3BAF48A89E1EE5)) {
    struct.min_effort_effect = loadfx(_id_7F3BAF48A89E1EE5);
    struct.min_effort_ratio = _id_D4F8A348E6FD43D2;
  }

  level.vehicle.templates.engine_fx[level.vtclassname] = struct;
}

build_treadfx(classname, type, fx, _id_14A8A921608CB466) {
  if(!scripts\common\utility::issp()) {
    return;
  }
  if(isDefined(classname)) {
    set_vehicle_effect(classname, type, fx);

    if(isDefined(_id_14A8A921608CB466) && _id_14A8A921608CB466) {
      set_vehicle_effect(classname, type, fx, "_bank");
      set_vehicle_effect(classname, type, fx, "_bank_lg");
    }
  } else {
    classname = level.vtclassname;
    scripts\common\vehicle_treadfx::main();
  }
}

build_all_treadfx(classname, fx) {
  types = get_surface_types();

  foreach(type in types)
  set_vehicle_effect(classname, type);
}

set_vehicle_effect(classname, material, fx, _id_0E4731409BD255E0) {
  if(!isDefined(level.vehicle.templates.surface_effects))
    level.vehicle.templates.surface_effects = [];

  if(isDefined(_id_0E4731409BD255E0)) {
    material = material + _id_0E4731409BD255E0;
    fx = fx + _id_0E4731409BD255E0;
  }

  if(isDefined(fx))
    level.vehicle.templates.surface_effects[classname][material] = loadfx(fx);
  else if(isDefined(level.vehicle.templates.surface_effects[classname]) && isDefined(level.vehicle.templates.surface_effects[classname][material]))
    level.vehicle.templates.surface_effects[classname][material] = undefined;
}

get_surface_types() {
  return ["brick", "bark", "carpet", "cloth", "concrete", "dirt", "flesh", "foliage", "glass", "grass", "gravel", "ice", "metal", "mud", "paper", "plaster", "rock", "sand", "snow", "water", "wood", "asphalt", "ceramic", "plastic", "rubber", "cushion", "fruit", "paintedmetal", "riotshield", "slush", "default"];
}

build_team(team) {
  level.vehicle.templates.team[level.vtclassname] = team;
}

build_bulletshield(_id_AAAD959CE4CD1A0C) {
  level.vehicle.templates.bullet_shield[level.vtclassname] = _id_AAAD959CE4CD1A0C;
}

build_grenadeshield(_id_AAAD959CE4CD1A0C) {
  level.vehicle.templates.grenade_shield[level.vtclassname] = _id_AAAD959CE4CD1A0C;
}

_id_D82E00BEF8433948(weaponarray) {
  level.vehicle.templates._id_7412CA7553957E74[level.vtclassname] = weaponarray;
}

_id_CEEB72985B41BFB1(_id_AAAD959CE4CD1A0C) {
  level.vehicle.templates._id_4356B75E0EDDF77D[level.vtclassname] = _id_AAAD959CE4CD1A0C;
}

build_aianims(_id_23460F55E2F66AF3, _id_7D2527780564C35B, vehicleanimalias) {
  classname = level.vtclassname;
  level.vehicle.templates.aianims[classname] = [[_id_23460F55E2F66AF3]]();

  if(isDefined(vehicleanimalias) && isDefined(level.func) && isDefined(level.func["set_vehicle_anims_" + vehicleanimalias]))
    level.vehicle.templates.aianims[classname] = [[level.func["set_vehicle_anims_" + vehicleanimalias]]](level.vehicle.templates.aianims[classname]);
  else if(isDefined(_id_7D2527780564C35B))
    level.vehicle.templates.aianims[classname] = [[_id_7D2527780564C35B]](level.vehicle.templates.aianims[classname]);
}

_id_A82F8A25AD7E6B3F(_id_FDD5AB14AB76741A, vehicleanimalias) {
  classname = level.vtclassname;
  level.vehicle.templates.aianims[classname] = _id_FDD5AB14AB76741A;

  if(isDefined(vehicleanimalias) && isDefined(level.func) && isDefined(level.func["set_vehicle_anims_" + vehicleanimalias]))
    level.vehicle.templates.aianims[classname] = [[level.func["set_vehicle_anims_" + vehicleanimalias]]](level.vehicle.templates.aianims[classname]);
}

build_attach_models(_id_F78826186A8A6A5F) {
  level.vehicle.templates.attachedmodels[level.vtclassname] = [[_id_F78826186A8A6A5F]]();
}

build_unload_groups(_id_D22E801BB7CC696A) {
  level.vehicle.templates.unloadgroups[level.vtclassname] = [[_id_D22E801BB7CC696A]]();
}

_id_AB7252DA140C8FE7(unloadgroups) {
  level.vehicle.templates.unloadgroups[level.vtclassname] = unloadgroups;
}

build_life(health, _id_ED42BF9CFFB5C5AD, maxhealth) {
  classname = level.vtclassname;
  level.vehicle.templates.life[classname] = health;
  level.vehicle.templates.life_range_low[classname] = _id_ED42BF9CFFB5C5AD;
  level.vehicle.templates.life_range_high[classname] = maxhealth;
}

build_destructible(model, destructible) {}

build_localinit(_id_3D449CEDDE396F60) {
  level.vehicleinitthread[_func_40FD49171FAD19D3(level.vttype)][level.vtclassname] = _id_3D449CEDDE396F60;
}

build_atmo_types(_id_DFCDAEF94E46DB19, _id_32939C69D1F8188A) {
  level.vehicle.templates.atmotypes[level.vtclassname]["atmo"] = _id_DFCDAEF94E46DB19;
  level.vehicle.templates.atmotypes[level.vtclassname]["space"] = _id_32939C69D1F8188A;
}

build_ace(_id_521073B2C1B5E439) {
  level.vehicle.templates.aces[level.vtclassname] = _id_521073B2C1B5E439;
}

build_semiace(_id_CDF39AF1C6B4F363) {
  level.vehicle.templates.semiaces[level.vtclassname] = _id_CDF39AF1C6B4F363;
}

build_playercontrolled_model(playercontrolledmodel, worldmodel) {
  struct = spawnStruct();
  struct.playercontrolledmodel = playercontrolledmodel;
  struct.worldmodel = worldmodel;
  precachemodel(playercontrolledmodel);
  level.vehicle.templates.vehicleplayermodel[level.vtclassname] = struct;
}

build_is_helicopter(_id_3D22F278EFD315CC) {
  if(!isDefined(level.vehicle.templates.helicopter_list))
    level.vehicle.templates.helicopter_list = [];

  if(!isDefined(_id_3D22F278EFD315CC))
    _id_3D22F278EFD315CC = level.vttype;

  level.vehicle.templates.helicopter_list[_func_40FD49171FAD19D3(_id_3D22F278EFD315CC)] = 1;
}

_id_3A186B889337BD1B(_id_3D22F278EFD315CC) {
  if(!isDefined(level.vehicle.templates._id_91F3271E71001190))
    level.vehicle.templates._id_91F3271E71001190 = [];

  if(!isDefined(_id_3D22F278EFD315CC))
    _id_3D22F278EFD315CC = level.vttype;

  level.vehicle.templates._id_91F3271E71001190[_func_40FD49171FAD19D3(_id_3D22F278EFD315CC)] = 1;
}

build_is_airplane(_id_3D22F278EFD315CC) {
  if(!isDefined(level.vehicle.templates.airplane_list))
    level.vehicle.templates.airplane_list = [];

  if(!isDefined(_id_3D22F278EFD315CC))
    _id_3D22F278EFD315CC = level.vttype;

  level.vehicle.templates.airplane_list[_func_40FD49171FAD19D3(_id_3D22F278EFD315CC)] = 1;
}

_id_5A73D7723FCE9849(_id_3D22F278EFD315CC) {
  if(!isDefined(level.vehicle.templates._id_27719D9C0BC9708A))
    level.vehicle.templates._id_27719D9C0BC9708A = [];

  if(!isDefined(_id_3D22F278EFD315CC))
    _id_3D22F278EFD315CC = level.vttype;

  level.vehicle.templates._id_27719D9C0BC9708A[_func_40FD49171FAD19D3(_id_3D22F278EFD315CC)] = 1;
}

build_single_tread(_id_3D22F278EFD315CC) {
  if(!isDefined(level.vehicle.templates.single_tread_list))
    level.vehicle.templates.single_tread_list = [];

  if(!isDefined(_id_3D22F278EFD315CC))
    _id_3D22F278EFD315CC = level.vttype;

  level.vehicle.templates.single_tread_list[_func_40FD49171FAD19D3(_id_3D22F278EFD315CC)] = 1;
}

build_rider_death_func(func) {
  if(!isDefined(level.vehicle.templates.rider_death_func))
    level.vehicle.templates.rider_death_func = [];

  level.vehicle.templates.rider_death_func[level.vtclassname] = func;
}

_id_D97DAFAF227ED144(classname, vehicletype, _id_3D449CEDDE396F60) {
  level.vehicle.templates._id_95742F5C97192175[classname] = vehicletype;
  level.vehicleinitthread[_func_40FD49171FAD19D3(vehicletype)][classname] = _id_3D449CEDDE396F60;
}

_id_26ADACDEDD87D439(classname, index) {
  level.vehicle.templates._id_445AD4FF08E86D9E[classname] = index;
}

_id_2660787CA33CF457(classname, _id_A1B2FFA6284BEB63, _id_955F6816E98AB2C0) {
  if(!isDefined(level.vehicle.templates._id_A72227C6BFA8A146))
    level.vehicle.templates._id_A72227C6BFA8A146 = [];

  if(!isarray(_id_955F6816E98AB2C0))
    _id_955F6816E98AB2C0 = [_id_955F6816E98AB2C0];

  level.vehicle.templates._id_A72227C6BFA8A146[classname][_id_A1B2FFA6284BEB63] = _id_955F6816E98AB2C0;
}