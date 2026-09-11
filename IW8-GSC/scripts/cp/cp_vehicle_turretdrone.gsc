/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_vehicle_turretdrone.gsc
*************************************************/

function spawn_vehicle_turret_drone(var_0, var_1, var_2, var_3) {
  var_4 = associate_turret_settings_from_type(var_0, var_2);
  self.turret = spawn_vehicle_turret(var_4, var_0, var_1, var_2);
  self.can_find_new_target = 1;
  thread turret_manager(level);

  if(!isDefined(self.turret)) {
    return;
  }

  if(!isDefined(self.turretparts)) {
    self.turretparts = [];
  }

  var_5 = get_soldier_model_from_type(var_3);
  var_6 = create_drone_model(var_4, var_5);
  self.turretparts[self.turretparts.size] = var_6;
  wait 0.05;
  var_7 = spawn_drone_hitbox(self.turret, 1200);
  thread vehicle_follow_parent(var_7, self.turret, var_4.hitboxoffset);
  var_7.drone_model = var_6;
  var_7.truck = self;
  var_7.damage_functions[0] = &turret_hitbox_track_damage;
  self.turretparts[self.turretparts.size] = var_7;
  wait 0.05;

  if(isDefined(var_4.standmodel)) {
    var_8 = spawn("script_model", self.turret.origin + rotatevector(var_4.standoffset, self.turret.angles));
    var_8 setModel(var_4.standmodel);
    var_8.angles = self.turret.angles + var_4.standangles;
    var_8 linkTo(self);
    var_8 notsolid();
    self.turretparts[self.turretparts.size] = var_8;
    return;
  }
}

function associate_turret_settings_from_type(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "minigun":
      var_2 = make_turret_minigun_config(var_1);
      break;
    case "wheelson":
      var_2 = make_turret_wheelson_config(var_1);
      break;
    case "lmg":
      var_2 = make_turret_lmg_config(var_1);
      break;
    case "sniper":
      var_2 = make_turret_sniper_config(var_1);
      break;
    default:
      break;
  }

  return var_2;
}

function get_soldier_model_from_type(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "alqatala_soldier":
      var_1 = "aq_pilot_fullbody_1";
      break;
    case "russian_soldier":
      var_1 = "aq_pilot_fullbody_2";
      break;
    default:
      break;
  }

  return var_1;
}

function get_weapon_type_from_input(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "minigun_manned":
      var_1 = "iw8_mg_50cal_cp";
      break;
    case "wheelson_manned":
      var_1 = "pac_sentry_turret_cp";
      break;
    case "lmg_manned":
      var_1 = "iw8_mg_50cal_cp";
      break;
    case "sniper_manned":
      var_1 = "iw8_mg_50cal_cp";
      break;
    default:
      break;
  }

  return var_1;
}

function delete_vehicles_turrets() {
  if(isDefined(self.turret)) {
    self.turret notify("death");
    self.turret delete();
  }

  if(isDefined(self.turretparts)) {
    foreach(var_1 in self.turretparts) {
      if(isent(var_1)) {
        var_1 delete();
      }
    }

    return;
  }
}

function make_turret_minigun_config(var_0) {
  var_1 = spawnStruct();
  var_1.idleanim = "reb_vh_techo_cab1_idle_search01";
  var_1.turretoffset = (10, 0, 0);
  var_1.soldieroffset = (27, 0, 35);
  var_1.hitboxoffset = (-20, 0, -40);
  var_1.wepmodel = "weapon_wm_mg_mobile_turret";
  var_1.weapon = get_weapon_type_from_input(var_0);
  var_1.standmodel = undefined;
  var_1.standoffset = undefined;
  var_1.standangles = undefined;
  return var_1;
}

function make_turret_wheelson_config(var_0) {
  var_1 = spawnStruct();
  var_1.idleanim = "reb_vh_techo_cab1_idle_search01";
  var_1.turretoffset = (0, 0, 30);
  var_1.soldieroffset = (28, 0, -10);
  var_1.hitboxoffset = (-20, 0, -40);
  var_1.wepmodel = "veh8_mil_lnd_whotel_turret";
  var_1.weapon = get_weapon_type_from_input(var_0);
  var_1.standmodel = "pipe_metal_painted_straight_32_gray";
  var_1.standoffset = (0, 0, -30);
  var_1.standangles = (0, 270, 90);
  return var_1;
}

function make_turret_lmg_config(var_0) {
  var_1 = spawnStruct();
  var_1.idleanim = "reb_vh_techo_cab1_idle_search01";
  var_1.turretoffset = (20, 0, 22);
  var_1.soldieroffset = (28, 0, -10);
  var_1.hitboxoffset = (-20, 0, -40);
  var_1.wepmodel = "veh8_mil_lnd_whotel_turret";
  var_1.weapon = get_weapon_type_from_input(var_0);
  var_1.standmodel = undefined;
  var_1.standoffset = undefined;
  var_1.standangles = undefined;
  return var_1;
}

function make_turret_sniper_config(var_0) {
  var_1 = spawnStruct();
  var_1.idleanim = "reb_vh_techo_cab1_idle_search01";
  var_1.turretoffset = (20, 0, 22);
  var_1.soldieroffset = (28, 0, -10);
  var_1.hitboxoffset = (-20, 0, -40);
  var_1.wepmodel = "veh8_mil_lnd_whotel_turret";
  var_1.weapon = get_weapon_type_from_input(var_0);
  var_1.standmodel = undefined;
  var_1.standoffset = undefined;
  var_1.standangles = undefined;
  return var_1;
}

function spawn_drone_hitbox(var_0) {
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.classname_mp = "script_vehicle_empty_turret";
  var_1.vehicletype = "empty_turret";
  var_1.script_modelname = "cp_turret_body";
  var_1.script_team = "axis";

  if(!isDefined(var_1.angles)) {
    var_1.angles = (270, 180, 180);
  }

  var_2 = scripts\common\vehicle::vehicle_spawn(var_1);
  var_2.vehicle_skipdeathmodel = 1;
  var_2.death_fx_on_self = 1;
  var_2 setvehicleteam("axis");
  var_2.team = "axis";
  var_2.script_team = "axis";
  var_2.health = var_2.healthbuffer + var_0;
  var_2 setCanDamage(1);
  return var_2;
}

function create_drone_model(var_0, var_1) {
  var_2 = spawn("script_model", self.turret.origin + rotatevector(var_0.soldieroffset, self.turret.angles));
  var_2 setModel(var_1);
  var_2.angles = self.angles + (270, 0, 0);
  var_2 scriptmodelplayanim(var_0.idleanim);
  var_2 linkTo(self.turret, "tag_aim");
  var_2 notsolid();
  return var_2;
}

function turret_hitbox_track_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isent(self)) {
    return;
  }

  if(self.health > self.healthbuffer) {
    if(isPlayer(var_1)) {
      var_10 = vectordot(var_2, anglesToForward(self.angles));
      var_11 = acos(var_10);

      if(var_11 < 92) {
        self.health += int(var_0 * 0.8);
      }

      var_1 scripts\cp\cp_damagefeedback::updatehitmarker("hitturret", 0, var_0, 0, 0);
    }

    return;
  }

  if(isPlayer(var_1)) {
    var_1 scripts\cp\cp_damagefeedback::updatehitmarker("hitturret", 0, var_0, 0, 0);
  }

  self.truck.turret_disabled = 1;
  self.truck notify("end_turret");
  clean_up_turret(self.truck);
  thread delete_drone_model();
  delete_vehicles_turrets(self.truck);
}

function delete_drone_model(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = 1500;
  var_2 = var_1 * var_1;

  if(!isent(self)) {
    return;
  }

  self scriptmodelplayanim("reb_vh_techo_cab1_idle_death01");
  wait 2;

  while(scripts\cp\utility::any_player_nearby(self.origin, var_2)) {
    wait 1;
  }

  self delete();
}

function spawn_vehicle_turret(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    var_4 = self gettagorigin(var_2) + var_0.turretoffset;
  } else {
    var_4 = self.origin + var_1.turretoffset;
  }

  var_5 = spawnturret("misc_turret", var_4, var_1.weapon);
  var_5 setModel(get_turret_model_from_short(var_2));
  var_5 linkTo(self);
  var_5.sentrytype = "auto_turret";
  var_5.muzzlepoint = var_5 gettagorigin("tag_aim_pivot");
  var_5 maketurretinoperable();
  var_5 setmode("manual");
  var_5.team = "axis";
  var_5.script_team = "axis";
  var_5 setturretteam("axis");
  var_5 makeunusable();
  var_5 notsolid();
  set_turret_settings_from_model(var_5, var_2);
  set_turret_settings_from_weapon(var_5, var_4);
  var_5.target_ent = var_5 scripts\engine\utility::spawn_tag_origin();
  var_5.target_ent show();
  var_5 settargetentity(var_5.target_ent);
  return var_5;
}

function set_turret_settings_from_model(var_0) {
  switch (var_0) {
    case "minigun":
      self setleftarc(80);
      self setrightarc(80);
      self settoparc(80);
      self setbottomarc(30);
      self setconvergencetime(0.65, "pitch");
      self setconvergencetime(0.65, "yaw");
      self setconvergenceheightpercent(0.65);
      self setdefaultdroppitch(-75);
      self.storedtarget = undefined;
      self.health = 99999;
      self.burstmin = 200;
      self.burstmax = 800;
      self.pausemin = 0.15;
      self.pausemax = 0.25;
      self.timeout = 90;
      self.spinuptime = 1;
      self.overheattime = 15;
      self.cooldowntime = 0.2;
      self.fxtime = 0.3;
      self.speed = 210;
      break;
    case "wheelson":
      self setleftarc(180);
      self setrightarc(180);
      self settoparc(180);
      self setbottomarc(30);
      self setconvergencetime(0.65, "pitch");
      self setconvergencetime(0.65, "yaw");
      self setconvergenceheightpercent(0.65);
      self setdefaultdroppitch(-75);
      self.storedtarget = undefined;
      self.health = 99999;
      self.burstmin = 200;
      self.burstmax = 800;
      self.pausemin = 0.15;
      self.pausemax = 0.25;
      self.timeout = 90;
      self.spinuptime = 1;
      self.overheattime = 15;
      self.cooldowntime = 0.2;
      self.fxtime = 0.3;
      self.speed = 210;
      break;
    default:
      break;
  }
}

function set_turret_settings_from_weapon(var_0) {
  switch (var_0) {
    case "minigun_manned":
      self.wait_between_shots = 0.15;
      self.wait_between_shot_round = 1;
      self.shots_per_round = 150;
      self.track_target_delay = 0.1;
      self.warning_time = 1;
      self laseron();
      break;
    case "wheelson_manned":
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

function get_turret_model_from_short(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "minigun":
      var_1 = "weapon_wm_mg_mobile_turret";
      break;
    case "wheelson":
      var_1 = "veh8_mil_lnd_whotel_turret";
      break;
    default:
      break;
  }

  return var_1;
}

function vehicle_follow_parent(var_0, var_1, var_2) {
  var_0 endon("death");
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_1 += (15, 0, 32);

  for(;;) {
    if(isDefined(self.truck) && !self.truck issuspendedvehicle() && self.truck vehicle_getspeed() > 0) {
      var_3 = var_0 gettagorigin("tag_aim");
      var_4 = var_0 gettagangles("tag_aim");
      var_5 = (0, var_4[1], 0);
      self vehicle_teleport(var_3 + rotatevector(var_1, var_5), (270, 180, 180));
    }

    wait 0.1;
  }
}

function process_turret_sweep_nodes(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  level.turret_start_locs = [];
  var_1 = scripts\engine\utility::getStructArray("convoy_turret_target", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(var_3.script_parameters != var_0) {
      scripts\engine\utility::array_remove(var_1, var_3);
    }
  }

  foreach(var_3 in var_1) {
    var_3.end1 = var_3;
    var_3.end2 = var_3;

    while(isDefined(var_3.end1.target)) {
      var_3.end1 = scripts\engine\utility::getStruct(var_3.end1.target, "targetname");
    }

    while(isDefined(scripts\engine\utility::getStruct(var_3.end2.targetname, "target"))) {
      var_3.end2 = scripts\engine\utility::getStruct(var_3.end2.targetname, "target");
    }

    level.turret_start_locs[level.turret_start_locs.size] = var_3;
  }
}

function shoot_vehicle_turret_at_attacker(var_0) {
  level endon("game_ended");
  level endon("event_convoy_delete");
  self endon("death");
  self endon("end_turret");

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

    while(turret_is_firing(self)) {
      wait 0.5;
    }

    wait 0.1;
  }

  self.can_find_new_target = 1;
}

function shoot_vehicle_turret_at_nearest_player() {
  level endon("game_ended");
  self endon("event_convoy_delete");
  self endon("death");
  self endon("end_turret");

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

    while(turret_is_firing(self)) {
      wait 0.5;
    }

    wait 0.1;
    self.can_find_new_target = 1;
  }
}

function honk_turret_horn() {
  if(istrue(self.disable_horn)) {
    return;
  }

  var_0 = 30;
  var_0 += randomfloatrange(0, 15);

  if(!isDefined(self.last_horn_time)) {
    self.last_horn_time = gettime();

    if(soundexists("veh_horn_mid_random")) {
      self playsoundonmovingent("veh_horn_mid_random");
      return;
    }

    return;
  }

  if(isDefined(self.target_player)) {
    if(distance2dsquared(self.target_player.origin, self.origin) > 1048576) {
      var_1 = gettime();

      if(var_1 > self.last_horn_time + 1000 * var_0) {
        self.last_horn_time = undefined;
        return;
      }

      return;
    }

    return;
  }
}

function turret(var_0) {
  thread turret_internal(var_0);
}

function turret_internal(var_0) {
  var_0 endon("death");
  var_0 endon("end_turret");
  var_1 = get_truck_turret_start_node(var_0);
  var_2 = get_turret_path(var_0);
  set_turret_target_loc(var_0, var_0.target_player.origin + (0, 0, 40));
  start_firing_turret(var_0);

  if(isDefined(var_2)) {
    wait 1;
    turret_sweep_to_loc(var_0, var_2.end, var_0.turret.speed, 1);
  } else {
    var_3 = 0;

    while(var_3 <= 3) {
      set_turret_target_loc(var_0, var_0.target_player.origin + (0, 0, 40));
      wait 0.25;
      var_3 += 0.25;
    }
  }

  clean_up_turret(var_0);
}

function set_turret_owner_to_riders() {
  if(isDefined(self.riders)) {
    foreach(var_1 in self.riders) {
      if(isalive(var_1) && isai(var_1)) {
        self.turret setturretowner(var_1);
      }
    }

    return;
  }
}

function clean_up_turret(var_0) {
  stop_firing_turret(var_0);
}

function get_turret_path(var_0) {
  var_1 = spawnStruct();
  var_2 = var_0.target_player;
  var_3 = scripts\engine\utility::getclosest(var_2.origin, level.turret_start_locs, 200);

  if(!isDefined(var_3)) {
    return undefined;
  }

  var_4 = distance2dsquared(var_2.origin, var_3.end1.origin);
  var_5 = distance2dsquared(var_2.origin, var_3.end2.origin);

  if(var_4 > var_5) {
    var_6 = var_3.end1;
  } else {
    var_6 = var_4.end2;
  }

  var_2.start = var_3.origin;
  var_2.end = var_6.origin;
  return var_2;
}

function get_truck_turret_start_node(var_0) {
  if(!isDefined(level.turret_start_locs) || level.turret_start_locs.size <= 0) {
    return;
  }

  var_1 = var_0.target_player;
  var_2 = scripts\engine\utility::getclosest(var_1.origin, level.turret_start_locs);
  return var_2.truck_loc;
}

function turret_manager(var_0) {
  var_0 endon("death");
  var_0.turret endon("death");
  init_turret_lifetime_shot_count(var_0);

  for(;;) {
    var_0 waittill("start_firing_turret");
    reset_turret_shot_count(var_0);
    wait var_0.turret.warning_time;

    while(turret_should_keep_firing(var_0)) {
      fire_turret(var_0);
      wait var_0.turret.wait_between_shots;

      if(!should_continue_current_shot_run(var_0)) {
        if(get_shot_fired(var_0) == var_0.turret.shots_per_round) {
          reset_turret_shot_count(var_0);
          wait var_0.turret.wait_between_shot_round;
        }

        if(!turret_should_keep_firing(var_0)) {
          break;
        }
      }
    }
  }
}

function should_continue_current_shot_run(var_0) {
  if(!turret_should_keep_firing(var_0)) {
    return false;
  }

  if(get_shot_fired(var_0) == var_0.turret.shots_per_round) {
    return false;
  }

  return true;
}

function play_spin_up_sfx(var_0) {
  var_0 endon("death");
  var_0.turret endon("death");
  var_0.turret notify("play_minigun_spin_up_SFX");
  var_0.turret endon("play_minigun_spin_up_SFX");
  var_0.turret endon("play_minigun_spin_down_SFX");

  if(!isent(var_0.turret)) {
    return;
  }

  var_1 = var_0.turret.warning_time / 4;
  var_0.turret playSound("convoy_gatling_distant_spinup1");
  wait var_1;
  var_0.turret playSound("convoy_gatling_distant_spinup2");
  wait var_1;
  var_0.turret playSound("convoy_gatling_distant_spinup3");
  wait var_1;
  var_0.turret playSound("convoy_gatling_distant_spinup4");
  wait var_1;
  var_0.turret playLoopSound("minigun_heli_gatling_spinloop");
}

function play_spin_down_sfx(var_0) {
  var_0 endon("death");
  var_0.turret endon("death");
  var_0.turret notify("play_minigun_spin_down_SFX");
  var_0.turret endon("play_minigun_spin_down_SFX");
  var_0.turret endon("play_minigun_spin_up_SFX");
  var_1 = var_0.turret.warning_time / 4;
  var_0.turret stoploopsound("minigun_heli_gatling_spinloop");
  var_0.turret playSound("convoy_gatling_distant_spindown4");
  wait var_1;
  var_0.turret playSound("convoy_gatling_distant_spindown3");
  wait var_1;
  var_0.turret playSound("convoy_gatling_distant_spindown2");
  wait var_1;
  var_0.turret playSound("convoy_gatling_distant_spindown1");
}

function get_shot_fired(var_0) {
  return var_0.turret.shot_count;
}

function init_turret_lifetime_shot_count(var_0) {
  var_0.turret.lifetime_shot_count = 0;
}

function should_skip_first_few_shot(var_0) {
  var_1 = 5;
  return var_0.turret.lifetime_shot_count < var_1;
}

function reset_turret_shot_count(var_0) {
  if(!isent(var_0.turret)) {
    return;
  }

  var_0.turret.shot_count = 0;
}

function fire_turret(var_0) {
  var_0.turret.lifetime_shot_count++;

  if(should_skip_first_few_shot(var_0)) {
    return;
  }

  var_0.turret shootturret();
  var_0.turret.shot_count++;
}

function turret_track_target(var_0, var_1) {
  thread turret_track_target_think(var_0, var_0);
}

function turret_track_target_think(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("stop_turret_tracking_target");

  for(;;) {
    var_2 = var_1.recent_position;
    set_turret_target_loc(var_0, var_2);
    wait var_0.turret.track_target_delay;
  }
}

function start_firing_turret(var_0) {
  var_0.keep_firing_turret = 1;
  var_0 notify("start_firing_turret");
}

function stop_firing_turret(var_0) {
  var_0.keep_firing_turret = 0;
}

function turret_should_keep_firing(var_0) {
  return istrue(var_0.keep_firing_turret);
}

function turret_is_firing(var_0) {
  return istrue(var_0.keep_firing_turret);
}

function set_turret_target_loc(var_0, var_1) {
  var_0.turret.target_ent dontinterpolate();
  var_0.turret.target_ent.origin = var_1;
}

function turret_sweep_to_loc(var_0, var_1, var_2, var_3) {
  var_4 = distance(var_0.turret.target_ent.origin, var_1) / var_2;
  var_0.turret.target_ent moveTo(var_1, var_4);

  if(istrue(var_3)) {
    wait var_4;
    return;
  }
}