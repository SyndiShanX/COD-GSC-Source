/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_vehicle_turretdrone.gsc
***********************************************/

spawn_vehicle_turret_drone(var_0, var_1, var_2, var_3) {
  var_4 = associate_turret_settings_from_type(var_0, var_2);
  self.turret = spawn_vehicle_turret(var_4, var_0, var_1, var_2);
  self.can_find_new_target = 1;
  level thread turret_manager(self);

  if(!isDefined(self.turret)) {
    return;
  }
  if(!isDefined(self.turretparts))
    self.turretparts = [];

  var_5 = get_soldier_model_from_type(var_3);
  var_6 = create_drone_model(var_4, var_5);
  self.turretparts[self.turretparts.size] = var_6;
  wait 0.05;
  var_7 = self.turret spawn_drone_hitbox(1200);
  var_7 thread vehicle_follow_parent(self.turret, var_4.hitboxoffset, (270, 180, 180));
  var_7.drone_model = var_6;
  var_7.truck = self;
  var_7.damage_functions[0] = ::turret_hitbox_track_damage;
  self.turretparts[self.turretparts.size] = var_7;
  wait 0.05;

  if(isDefined(var_4.standmodel)) {
    var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.turret.origin + rotatevector(var_4.standoffset, self.turret.angles));
    var_8 setModel(var_4.standmodel);
    var_8.angles = self.turret.angles + var_4.standangles;
    var_8 linkTo(self);
    var_8 notsolid();
    self.turretparts[self.turretparts.size] = var_8;
  }
}

associate_turret_settings_from_type(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "_encstr_95AD085B5AB9D2ECABE6":
      var_2 = make_turret_minigun_config(var_1);
      break;
    case "_encstr_AC7609CBBAF5A95033C0DB":
      var_2 = make_turret_wheelson_config(var_1);
      break;
    case "_encstr_9A190463ADB3":
      var_2 = make_turret_lmg_config(var_1);
      break;
    case "_encstr_850707F7E5833355B8":
      var_2 = make_turret_sniper_config(var_1);
      break;
    default:
      break;
  }

  return var_2;
}

get_soldier_model_from_type(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_961111A7588BA03177909F9703C519D15037E5":
      var_1 = "_encstr_967D148517D7E02DC6DB1DEB665D1B8D4C7B8C97F5C4";
      break;
    case "_encstr_A9BC1023ABBEC75418C57F5BEF585FF7ED23":
      var_1 = "_encstr_887D1485B8BEC14B367B8EF566D5D8B113F68CCBAFC8";
      break;
    default:
      break;
  }

  return var_1;
}

get_weapon_type_from_input(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_AB820F7288900F7718659FA513A87D67CD":
      var_1 = "_encstr_8C971096BB1CF55B3BF54D60C62C1BD7C683";
      break;
    case "_encstr_ACE3106FA0F325F1B7FFB0018D518DD67FE2":
      var_1 = "_encstr_8DC0152AE28E9F8B7F0273BE1B5E24FD03CDCD53914303";
      break;
    case "_encstr_BA1E0B3D88187FCAA7CDB39731":
      var_1 = "_encstr_8C971096BB1CF55B3BF54D60C62C1BD7C683";
      break;
    case "_encstr_ADA20E9BDCB4835627EBDAB09B375991":
      var_1 = "_encstr_8C971096BB1CF55B3BF54D60C62C1BD7C683";
      break;
    default:
      break;
  }

  return var_1;
}

delete_vehicles_turrets() {
  if(isDefined(self.turret)) {
    self.turret notify("_encstr_AD75063D571AE108");
    self.turret delete();
  }

  if(isDefined(self.turretparts)) {
    foreach(var_1 in self.turretparts) {
      if(isent(var_1))
        var_1 delete();
    }
  }
}

make_turret_minigun_config(var_0) {
  var_1 = spawnStruct();
  var_1.idleanim = "_encstr_8A91208AAD69990B3A07FDA9426B0AD931C9A0E2D144B2812DDF1305E9C61FA8B8B3";
  var_1.turretoffset = (10, 0, 0);
  var_1.soldieroffset = (27, 0, 35);
  var_1.hitboxoffset = (-20, 0, -40);
  var_1.wepmodel = "_encstr_9B5D1B14F7BA4948CEE728E0FF1581DF829D06930D524F53BD7B08A8BB";
  var_1.weapon = get_weapon_type_from_input(var_0);
  var_1.standmodel = undefined;
  var_1.standoffset = undefined;
  var_1.standangles = undefined;
  return var_1;
}

make_turret_wheelson_config(var_0) {
  var_1 = spawnStruct();
  var_1.idleanim = "_encstr_8A91208AAD69990B3A07FDA9426B0AD931C9A0E2D144B2812DDF1305E9C61FA8B8B3";
  var_1.turretoffset = (0, 0, 30);
  var_1.soldieroffset = (28, 0, -10);
  var_1.hitboxoffset = (-20, 0, -40);
  var_1.wepmodel = "_encstr_B6941B55DDAC72AF1F32107E4A3B459183389FD9451501DD079BEB2133";
  var_1.weapon = get_weapon_type_from_input(var_0);
  var_1.standmodel = "_encstr_8A602407B407ACAFB62B47851BF507585A73A35619EBCD8E390BB4EC8647D73364F53B93585E";
  var_1.standoffset = (0, 0, -30);
  var_1.standangles = (0, 270, 90);
  return var_1;
}

make_turret_lmg_config(var_0) {
  var_1 = spawnStruct();
  var_1.idleanim = "_encstr_8A91208AAD69990B3A07FDA9426B0AD931C9A0E2D144B2812DDF1305E9C61FA8B8B3";
  var_1.turretoffset = (20, 0, 22);
  var_1.soldieroffset = (28, 0, -10);
  var_1.hitboxoffset = (-20, 0, -40);
  var_1.wepmodel = "_encstr_B6941B55DDAC72AF1F32107E4A3B459183389FD9451501DD079BEB2133";
  var_1.weapon = get_weapon_type_from_input(var_0);
  var_1.standmodel = undefined;
  var_1.standoffset = undefined;
  var_1.standangles = undefined;
  return var_1;
}

make_turret_sniper_config(var_0) {
  var_1 = spawnStruct();
  var_1.idleanim = "_encstr_8A91208AAD69990B3A07FDA9426B0AD931C9A0E2D144B2812DDF1305E9C61FA8B8B3";
  var_1.turretoffset = (20, 0, 22);
  var_1.soldieroffset = (28, 0, -10);
  var_1.hitboxoffset = (-20, 0, -40);
  var_1.wepmodel = "_encstr_B6941B55DDAC72AF1F32107E4A3B459183389FD9451501DD079BEB2133";
  var_1.weapon = get_weapon_type_from_input(var_0);
  var_1.standmodel = undefined;
  var_1.standoffset = undefined;
  var_1.standangles = undefined;
  return var_1;
}

spawn_drone_hitbox(var_0) {
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.classname_mp = "_encstr_AC291C7FFB0AD8B75B71B3D9EAC7E628676FEBCB70F3106863CBCB2302EB";
  var_1.vehicletype = "_encstr_8C2A0D6F68EF6DE92E0B681D764723";
  var_1.script_modelname = "_encstr_96CE0F8D83AF1DABC9C9563AF5C4DB2397";
  var_1.script_team = "_encstr_8E8405EA382B2A";

  if(!isDefined(var_1.angles))
    var_1.angles = (270, 180, 180);

  var_2 = scripts\common\vehicle::vehicle_spawn(var_1);
  var_2.vehicle_skipdeathmodel = 1;
  var_2.death_fx_on_self = 1;
  var_2 setvehicleteam("_encstr_8E8405EA382B2A");
  var_2.team = "_encstr_8E8405EA382B2A";
  var_2.script_team = "_encstr_8E8405EA382B2A";
  var_2.health = var_2.healthbuffer + var_0;
  var_2 setCanDamage(1);
  return var_2;
}

create_drone_model(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.turret.origin + rotatevector(var_0.soldieroffset, self.turret.angles));
  var_2 setModel(var_1);
  var_2.angles = self.angles + (270, 0, 0);
  var_2 scriptmodelplayanim(var_0.idleanim);
  var_2 linkTo(self.turret, "_encstr_8E300878E04AE8B18198");
  var_2 notsolid();
  return var_2;
}

turret_hitbox_track_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isent(self)) {
    return;
  }
  if(self.health > self.healthbuffer) {
    if(isPlayer(var_1)) {
      var_10 = vectordot(var_2, anglesToForward(self.angles));
      var_11 = acos(var_10);

      if(var_11 < 92)
        self.health = self.health + int(var_0 * 0.8);

      var_1 scripts\cp\cp_damagefeedback::updatehitmarker("_encstr_A39C0AB8ECCC1805E3031B31", 0, var_0, 0, 0);
    }

    return;
  }

  if(isPlayer(var_1))
    var_1 scripts\cp\cp_damagefeedback::updatehitmarker("_encstr_A39C0AB8ECCC1805E3031B31", 0, var_0, 0, 0);

  self.truck.turret_disabled = 1;
  self.truck notify("_encstr_A94E0BB2DC32D71DAE934E598E");
  clean_up_turret(self.truck);
  self.drone_model thread delete_drone_model();
  self.truck delete_vehicles_turrets();
}

delete_drone_model(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 1500;
  var_2 = var_1 * var_1;

  if(!isent(self)) {
    return;
  }
  self scriptmodelplayanim("_encstr_8AED1F272BC4F5D943AFE8B26C1A7BBEB1852689EBA5C8632BEB8C562C3A340313");
  wait 2;

  while(scripts\cp\utility::any_player_nearby(self.origin, var_2))
    wait 1;

  self delete();
}

spawn_vehicle_turret(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2))
    var_4 = self gettagorigin(var_2) + var_0.turretoffset;
  else
    var_4 = self.origin + var_0.turretoffset;

  var_5 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_4, var_0.weapon);
  var_5 setModel(get_turret_model_from_short(var_1));
  var_5 linkTo(self);
  var_5.sentrytype = "_encstr_AA650C2C57D17BFAD15DE4C9591D";
  var_5.muzzlepoint = var_5 gettagorigin("_encstr_8AFF0E7BE26F40E0BC8D6731A123C89D");
  var_5 maketurretinoperable();
  var_5 setmode("_encstr_849007B268BD03DFD8");
  var_5.team = "_encstr_8E8405EA382B2A";
  var_5.script_team = "_encstr_8E8405EA382B2A";
  var_5 setturretteam("_encstr_8E8405EA382B2A");
  var_5 makeunusable();
  var_5 notsolid();
  var_5 set_turret_settings_from_model(var_1);
  var_5 set_turret_settings_from_weapon(var_3);
  var_5.target_ent = var_5 scripts\engine\utility::spawn_tag_origin();
  var_5.target_ent show();
  var_5 settargetentity(var_5.target_ent);
  return var_5;
}

set_turret_settings_from_model(var_0) {
  switch (var_0) {
    case "_encstr_95AD085B5AB9D2ECABE6":
      self setleftarc(80);
      self setrightarc(80);
      self settoparc(80);
      self setbottomarc(30);
      self setconvergencetime(0.65, "_encstr_BD6506F36A2B46B0");
      self setconvergencetime(0.65, "_encstr_AF1904C7E3A4");
      self setconvergenceheightpercent(0.65);
      self setdefaultdroppitch(-75.0);
      self.storedtarget = undefined;
      self.health = 99999;
      self.burstmin = 200;
      self.burstmax = 800;
      self.pausemin = 0.15;
      self.pausemax = 0.25;
      self.timeout = 90.0;
      self.spinuptime = 1.0;
      self.overheattime = 15.0;
      self.cooldowntime = 0.2;
      self.fxtime = 0.3;
      self.speed = 210;
      break;
    case "_encstr_AC7609CBBAF5A95033C0DB":
      self setleftarc(180);
      self setrightarc(180);
      self settoparc(180);
      self setbottomarc(30);
      self setconvergencetime(0.65, "_encstr_BD6506F36A2B46B0");
      self setconvergencetime(0.65, "_encstr_AF1904C7E3A4");
      self setconvergenceheightpercent(0.65);
      self setdefaultdroppitch(-75.0);
      self.storedtarget = undefined;
      self.health = 99999;
      self.burstmin = 200;
      self.burstmax = 800;
      self.pausemin = 0.15;
      self.pausemax = 0.25;
      self.timeout = 90.0;
      self.spinuptime = 1.0;
      self.overheattime = 15.0;
      self.cooldowntime = 0.2;
      self.fxtime = 0.3;
      self.speed = 210;
      break;
    default:
      break;
  }
}

set_turret_settings_from_weapon(var_0) {
  switch (var_0) {
    case "_encstr_AB820F7288900F7718659FA513A87D67CD":
      self.wait_between_shots = 0.15;
      self.wait_between_shot_round = 1;
      self.shots_per_round = 150;
      self.track_target_delay = 0.1;
      self.warning_time = 1;
      self laseron();
      break;
    case "_encstr_ACE3106FA0F325F1B7FFB0018D518DD67FE2":
      self.wait_between_shots = 1.6;
      self.wait_between_shot_round = 5;
      self.shots_per_round = 15;
      self.track_target_delay = 0.15;
      self.warning_time = 0.6;
      self laseron();
      break;
    default:
      break;
  }
}

get_turret_model_from_short(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_95AD085B5AB9D2ECABE6":
      var_1 = "_encstr_9B5D1B14F7BA4948CEE728E0FF1581DF829D06930D524F53BD7B08A8BB";
      break;
    case "_encstr_AC7609CBBAF5A95033C0DB":
      var_1 = "_encstr_B6941B55DDAC72AF1F32107E4A3B459183389FD9451501DD079BEB2133";
      break;
    default:
      break;
  }

  return var_1;
}

vehicle_follow_parent(var_0, var_1, var_2) {
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  var_1 = var_1 + (15, 0, 32);

  for(;;) {
    if(isDefined(self.truck) && !self.truck issuspendedvehicle() && self.truck vehicle_getspeed() > 0) {
      var_3 = var_0 gettagorigin("_encstr_8E300878E04AE8B18198");
      var_4 = var_0 gettagangles("_encstr_8E300878E04AE8B18198");
      var_5 = (0, var_4[1], 0);
      self vehicle_teleport(var_3 + rotatevector(var_1, var_5), (270, 180, 180));
    }

    wait 0.1;
  }
}

process_turret_sweep_nodes(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level.turret_start_locs = [];
  var_1 = scripts\engine\utility::getStructArray("_encstr_AAC2153E08D88B67F1EED5CBBB3ABD2350D4B6FB127023", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_3 in var_1) {
    if(var_3.script_parameters != var_0)
      scripts\engine\utility::array_remove(var_1, var_3);
  }

  foreach(var_3 in var_1) {
    var_3.end1 = var_3;

    for(var_3.end2 = var_3; isDefined(var_3.end1.target); var_3.end1 = scripts\engine\utility::getStruct(var_3.end1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF")) {}

    while(isDefined(scripts\engine\utility::getStruct(var_3.end2.targetname, "_encstr_A16007A921A23B85E3")))
      var_3.end2 = scripts\engine\utility::getStruct(var_3.end2.targetname, "_encstr_A16007A921A23B85E3");

    level.turret_start_locs[level.turret_start_locs.size] = var_3;
  }
}

shoot_vehicle_turret_at_attacker(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A94E0BB2DC32D71DAE934E598E");

  if(!istrue(self.can_find_new_target)) {
    return;
  }
  if(istrue(self.turret_disabled)) {
    return;
  }
  self.target_player = var_0;
  var_1 = 6000;
  var_2 = var_1 * var_1;

  while(distance2dsquared(self.origin, self.target_player.origin) < var_2) {
    self.can_find_new_target = 0;
    turret(self);

    while(turret_is_firing(self))
      wait 0.5;

    wait 0.1;
  }

  self.can_find_new_target = 1;
}

shoot_vehicle_turret_at_nearest_player() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_883D14105B679DCB3733E0681ECF52378FF2D0E893BF");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A94E0BB2DC32D71DAE934E598E");

  for(;;) {
    wait 1;
    var_0 = undefined;
    var_1 = 30250000;

    foreach(var_3 in level.players) {
      var_4 = distance2dsquared(self.origin, var_3.origin);

      if(var_4 < var_1) {
        var_0 = var_3;
        var_1 = var_4;
      }

      wait 0.1;
    }

    if(!isDefined(var_0)) {
      continue;
    }
    if(!isalive(var_0)) {
      continue;
    }
    if(!istrue(self.can_find_new_target)) {
      continue;
    }
    if(istrue(self.turret_disabled)) {
      continue;
    }
    self.target_player = var_0;
    thread honk_turret_horn();
    self.can_find_new_target = 0;
    turret(self);

    while(turret_is_firing(self))
      wait 0.5;

    wait 0.1;
    self.can_find_new_target = 1;
  }
}

honk_turret_horn() {
  if(istrue(self.disable_horn)) {
    return;
  }
  var_0 = 30;
  var_0 = var_0 + randomfloatrange(0, 15);

  if(!isDefined(self.last_horn_time)) {
    self.last_horn_time = gettime();

    if(soundexists("_encstr_91E214C4A1C3493BA7EBD81ED580A9F73B0F7E89586B"))
      self playsoundonmovingent("_encstr_91E214C4A1C3493BA7EBD81ED580A9F73B0F7E89586B");
  } else if(isDefined(self.target_player)) {
    if(distance2dsquared(self.target_player.origin, self.origin) > 1048576) {
      var_1 = gettime();

      if(var_1 > self.last_horn_time + 1000 * var_0)
        self.last_horn_time = undefined;
    }
  }
}

turret(var_0) {
  var_0 thread turret_internal(var_0);
}

turret_internal(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_A94E0BB2DC32D71DAE934E598E");
  var_1 = get_truck_turret_start_node(var_0);
  var_2 = get_turret_path(var_0);
  set_turret_target_loc(var_0, var_0.target_player.origin + (0, 0, 40));
  start_firing_turret(var_0);

  if(isDefined(var_2)) {
    wait 1;
    turret_sweep_to_loc(var_0, var_2.end, var_0.turret.speed, 1);
  } else {
    for(var_3 = 0; var_3 <= 3; var_3 = var_3 + 0.25) {
      set_turret_target_loc(var_0, var_0.target_player.origin + (0, 0, 40));
      wait 0.25;
    }
  }

  clean_up_turret(var_0);
}

set_turret_owner_to_riders() {
  if(isDefined(self.riders)) {
    foreach(var_1 in self.riders) {
      if(isalive(var_1) && isai(var_1))
        self.turret setturretowner(var_1);
    }
  }
}

clean_up_turret(var_0) {
  stop_firing_turret(var_0);
}

get_turret_path(var_0) {
  var_1 = spawnStruct();
  var_2 = var_0.target_player;
  var_3 = scripts\engine\utility::getclosest(var_2.origin, level.turret_start_locs, 200);

  if(!isDefined(var_3))
    return undefined;

  var_4 = distance2dsquared(var_2.origin, var_3.end1.origin);
  var_5 = distance2dsquared(var_2.origin, var_3.end2.origin);

  if(var_4 > var_5)
    var_6 = var_3.end1;
  else
    var_6 = var_3.end2;

  var_1.start = var_2.origin;
  var_1.end = var_6.origin;
  return var_1;
}

get_truck_turret_start_node(var_0) {
  if(!isDefined(level.turret_start_locs) || level.turret_start_locs.size <= 0) {
    return;
  }
  var_1 = var_0.target_player;
  var_2 = scripts\engine\utility::getclosest(var_1.origin, level.turret_start_locs);
  return var_2.truck_loc;
}

turret_manager(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.turret endon("_encstr_AD75063D571AE108");
  init_turret_lifetime_shot_count(var_0);

  for(;;) {
    var_0 waittill("_encstr_8D5114B3F35FC23051AD78BE232ECF49435B2AE5D253");
    reset_turret_shot_count(var_0);
    wait(var_0.turret.warning_time);

    while(turret_should_keep_firing(var_0)) {
      fire_turret(var_0);
      wait(var_0.turret.wait_between_shots);

      if(!should_continue_current_shot_run(var_0)) {
        if(get_shot_fired(var_0) == var_0.turret.shots_per_round) {
          reset_turret_shot_count(var_0);
          wait(var_0.turret.wait_between_shot_round);
        }

        if(!turret_should_keep_firing(var_0)) {
          break;
        }
      }
    }
  }
}

should_continue_current_shot_run(var_0) {
  if(!turret_should_keep_firing(var_0))
    return 0;

  if(get_shot_fired(var_0) == var_0.turret.shots_per_round)
    return 0;

  return 1;
}

play_spin_up_sfx(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.turret endon("_encstr_AD75063D571AE108");
  var_0.turret notify("_encstr_878419D89A06938EDF1940CBEF4750176AC39890015BF9C60F1E43");
  var_0.turret endon("_encstr_878419D89A06938EDF1940CBEF4750176AC39890015BF9C60F1E43");
  var_0.turret endon("_encstr_AF681B90E9F13F010B80222A884305EFEB4F0136E8B99FD32519F9D059");

  if(!isent(var_0.turret)) {
    return;
  }
  var_1 = var_0.turret.warning_time / 4;
  var_0.turret playSound("_encstr_81F21FEF77ADFE1758199CD9F15172F5A751613058143F02FB31BB509A206B4296");
  wait(var_1);
  var_0.turret playSound("_encstr_ADF21F10B766CBDF6B215C57C3121B70D7DFB0C8BF1461E563D94EE79C4A7B7B6A");
  wait(var_1);
  var_0.turret playSound("_encstr_97F21FA8422D555027977C67945BD8DDD7E908707B43B3484BEF7EE791AB83A9AA");
  wait(var_1);
  var_0.turret playSound("_encstr_8AF21F1BEDCDECBDBCEBB30B47B12D733BD72396DC47B09BD1AF9B83B4B9570ED0");
  wait(var_1);
  var_0.turret playLoopSound("_encstr_95FA1EB52D374BD9579BFA34AC365AF5EC853AC6B47376D7DC835A9BD87BF638");
}

play_spin_down_sfx(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.turret endon("_encstr_AD75063D571AE108");
  var_0.turret notify("_encstr_AF681B90E9F13F010B80222A884305EFEB4F0136E8B99FD32519F9D059");
  var_0.turret endon("_encstr_AF681B90E9F13F010B80222A884305EFEB4F0136E8B99FD32519F9D059");
  var_0.turret endon("_encstr_878419D89A06938EDF1940CBEF4750176AC39890015BF9C60F1E43");
  var_1 = var_0.turret.warning_time / 4;
  var_0.turret stoploopsound("_encstr_95FA1EB52D374BD9579BFA34AC365AF5EC853AC6B47376D7DC835A9BD87BF638");
  var_0.turret playSound("_encstr_B669216CEDB93BED97F53B16D1D84B7376D7C89637E82CE63ABE9B0E5ADC46EDEEB986");
  wait(var_1);
  var_0.turret playSound("_encstr_A66921709AF59D989FDF343FEC1380651F21C0B8330BEBF08337C6AFD97369DFC3DAC2");
  wait(var_1);
  var_0.turret playSound("_encstr_B2692166E010CD98571FEF87A1A07750A1B911DC87107890D0E7C38BE8E087505740CA");
  wait(var_1);
  var_0.turret playSound("_encstr_84692186D708E6DDDB1FECDB6B9081731729BF39E851E760E9F0DBEFC47595773795D9");
}

get_shot_fired(var_0) {
  return var_0.turret.shot_count;
}

init_turret_lifetime_shot_count(var_0) {
  var_0.turret.lifetime_shot_count = 0;
}

should_skip_first_few_shot(var_0) {
  var_1 = 5;
  return var_0.turret.lifetime_shot_count < var_1;
}

reset_turret_shot_count(var_0) {
  if(!isent(var_0.turret)) {
    return;
  }
  var_0.turret.shot_count = 0;
}

fire_turret(var_0) {
  var_0.turret.lifetime_shot_count++;

  if(should_skip_first_few_shot(var_0)) {
    return;
  }
  var_0.turret shootturret();
  var_0.turret.shot_count++;
}

turret_track_target(var_0, var_1) {
  var_0 thread turret_track_target_think(var_0, var_1);
}

turret_track_target_think(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_81171C62541D810F3C50A37BE25059C3884E4FF40AC5D76EC373A2387D4B");

  for(;;) {
    var_2 = var_1.recent_position;
    set_turret_target_loc(var_0, var_2);
    wait(var_0.turret.track_target_delay);
  }
}

start_firing_turret(var_0) {
  var_0.keep_firing_turret = 1;
  var_0 notify("_encstr_8D5114B3F35FC23051AD78BE232ECF49435B2AE5D253");
}

stop_firing_turret(var_0) {
  var_0.keep_firing_turret = 0;
}

turret_should_keep_firing(var_0) {
  return istrue(var_0.keep_firing_turret);
}

turret_is_firing(var_0) {
  return istrue(var_0.keep_firing_turret);
}

set_turret_target_loc(var_0, var_1) {
  var_0.turret.target_ent dontinterpolate();
  var_0.turret.target_ent.origin = var_1;
}

turret_sweep_to_loc(var_0, var_1, var_2, var_3) {
  var_4 = distance(var_0.turret.target_ent.origin, var_1) / var_2;
  var_0.turret.target_ent moveTo(var_1, var_4);

  if(istrue(var_3))
    wait(var_4);
}