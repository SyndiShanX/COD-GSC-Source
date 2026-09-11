/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_vehicle_turretdrone.gsc
*************************************************/

function spawn_vehicle_turret_drone(var0, var1, var2, var3) {
  var4 = associate_turret_settings_from_type(var0, var2);
  self.turret = spawn_vehicle_turret(var4, var0, var1, var2);
  self.can_find_new_target = 1;
  thread turret_manager(level);

  if(!isDefined(self.turret)) {
    return;
  }

  if(!isDefined(self.turretparts)) {
    self.turretparts = [];
  }

  var5 = get_soldier_model_from_type(var3);
  var6 = create_drone_model(var4, var5);
  self.turretparts[self.turretparts.size] = var6;
  wait 0.05;
  var7 = spawn_drone_hitbox(self.turret, 1200);
  thread vehicle_follow_parent(var7, self.turret, var4.hitboxoffset);
  var7.drone_model = var6;
  var7.truck = self;
  var7.damage_functions[0] = &turret_hitbox_track_damage;
  self.turretparts[self.turretparts.size] = var7;
  wait 0.05;

  if(isDefined(var4.standmodel)) {
    var8 = spawn("script_model", self.turret.origin + rotatevector(var4.standoffset, self.turret.angles));
    var8 setModel(var4.standmodel);
    var8.angles = self.turret.angles + var4.standangles;
    var8 linkTo(self);
    var8 notsolid();
    self.turretparts[self.turretparts.size] = var8;
    return;
  }
}

function associate_turret_settings_from_type(var0, var1) {
  var2 = undefined;

  switch (var0) {
    case "minigun":
      var2 = make_turret_minigun_config(var1);
      break;
    case "wheelson":
      var2 = make_turret_wheelson_config(var1);
      break;
    case "lmg":
      var2 = make_turret_lmg_config(var1);
      break;
    case "sniper":
      var2 = make_turret_sniper_config(var1);
      break;
    default:
      break;
  }

  return var2;
}

function get_soldier_model_from_type(var0) {
  var1 = undefined;

  switch (var0) {
    case "alqatala_soldier":
      var1 = "aq_pilot_fullbody_1";
      break;
    case "russian_soldier":
      var1 = "aq_pilot_fullbody_2";
      break;
    default:
      break;
  }

  return var1;
}

function get_weapon_type_from_input(var0) {
  var1 = undefined;

  switch (var0) {
    case "minigun_manned":
      var1 = "iw8_mg_50cal_cp";
      break;
    case "wheelson_manned":
      var1 = "pac_sentry_turret_cp";
      break;
    case "lmg_manned":
      var1 = "iw8_mg_50cal_cp";
      break;
    case "sniper_manned":
      var1 = "iw8_mg_50cal_cp";
      break;
    default:
      break;
  }

  return var1;
}

function delete_vehicles_turrets() {
  if(isDefined(self.turret)) {
    self.turret notify("death");
    self.turret delete();
  }

  if(isDefined(self.turretparts)) {
    foreach(var1 in self.turretparts) {
      if(isent(var1)) {
        var1 delete();
      }
    }

    return;
  }
}

function make_turret_minigun_config(var0) {
  var1 = spawnStruct();
  var1.idleanim = "reb_vh_techo_cab1_idle_search01";
  var1.turretoffset = (10, 0, 0);
  var1.soldieroffset = (27, 0, 35);
  var1.hitboxoffset = (-20, 0, -40);
  var1.wepmodel = "weapon_wm_mg_mobile_turret";
  var1.weapon = get_weapon_type_from_input(var0);
  var1.standmodel = undefined;
  var1.standoffset = undefined;
  var1.standangles = undefined;
  return var1;
}

function make_turret_wheelson_config(var0) {
  var1 = spawnStruct();
  var1.idleanim = "reb_vh_techo_cab1_idle_search01";
  var1.turretoffset = (0, 0, 30);
  var1.soldieroffset = (28, 0, -10);
  var1.hitboxoffset = (-20, 0, -40);
  var1.wepmodel = "veh8_mil_lnd_whotel_turret";
  var1.weapon = get_weapon_type_from_input(var0);
  var1.standmodel = "pipe_metal_painted_straight_32_gray";
  var1.standoffset = (0, 0, -30);
  var1.standangles = (0, 270, 90);
  return var1;
}

function make_turret_lmg_config(var0) {
  var1 = spawnStruct();
  var1.idleanim = "reb_vh_techo_cab1_idle_search01";
  var1.turretoffset = (20, 0, 22);
  var1.soldieroffset = (28, 0, -10);
  var1.hitboxoffset = (-20, 0, -40);
  var1.wepmodel = "veh8_mil_lnd_whotel_turret";
  var1.weapon = get_weapon_type_from_input(var0);
  var1.standmodel = undefined;
  var1.standoffset = undefined;
  var1.standangles = undefined;
  return var1;
}

function make_turret_sniper_config(var0) {
  var1 = spawnStruct();
  var1.idleanim = "reb_vh_techo_cab1_idle_search01";
  var1.turretoffset = (20, 0, 22);
  var1.soldieroffset = (28, 0, -10);
  var1.hitboxoffset = (-20, 0, -40);
  var1.wepmodel = "veh8_mil_lnd_whotel_turret";
  var1.weapon = get_weapon_type_from_input(var0);
  var1.standmodel = undefined;
  var1.standoffset = undefined;
  var1.standangles = undefined;
  return var1;
}

function spawn_drone_hitbox(var0) {
  var1 = spawnStruct();
  var1.origin = self.origin;
  var1.classname_mp = "script_vehicle_empty_turret";
  var1.vehicletype = "empty_turret";
  var1.script_modelname = "cp_turret_body";
  var1.script_team = "axis";

  if(!isDefined(var1.angles)) {
    var1.angles = (270, 180, 180);
  }

  var2 = scripts\common\vehicle::vehicle_spawn(var1);
  var2.vehicle_skipdeathmodel = 1;
  var2.death_fx_on_self = 1;
  var2 setvehicleteam("axis");
  var2.team = "axis";
  var2.script_team = "axis";
  var2.health = var2.healthbuffer + var0;
  var2 setCanDamage(1);
  return var2;
}

function create_drone_model(var0, var1) {
  var2 = spawn("script_model", self.turret.origin + rotatevector(var0.soldieroffset, self.turret.angles));
  var2 setModel(var1);
  var2.angles = self.angles + (270, 0, 0);
  var2 scriptmodelplayanim(var0.idleanim);
  var2 linkTo(self.turret, "tag_aim");
  var2 notsolid();
  return var2;
}

function turret_hitbox_track_damage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isent(self)) {
    return;
  }

  if(self.health > self.healthbuffer) {
    if(isPlayer(var1)) {
      var10 = vectordot(var2, anglesToForward(self.angles));
      var11 = acos(var10);

      if(var11 < 92) {
        self.health += int(var0 * 0.8);
      }

      var1 scripts\cp\cp_damagefeedback::updatehitmarker("hitturret", 0, var0, 0, 0);
    }

    return;
  }

  if(isPlayer(var1)) {
    var1 scripts\cp\cp_damagefeedback::updatehitmarker("hitturret", 0, var0, 0, 0);
  }

  self.truck.turret_disabled = 1;
  self.truck notify("end_turret");
  clean_up_turret(self.truck);
  thread delete_drone_model();
  delete_vehicles_turrets(self.truck);
}

function delete_drone_model(var0) {
  self endon("death");
  level endon("game_ended");
  var1 = 1500;
  var2 = var1 * var1;

  if(!isent(self)) {
    return;
  }

  self scriptmodelplayanim("reb_vh_techo_cab1_idle_death01");
  wait 2;

  while(scripts\cp\utility::any_player_nearby(self.origin, var2)) {
    wait 1;
  }

  self delete();
}

function spawn_vehicle_turret(var0, var1, var2, var3) {
  if(isDefined(var2)) {
    var4 = self gettagorigin(var2) + var0.turretoffset;
  } else {
    var4 = self.origin + var1.turretoffset;
  }

  var5 = spawnturret("misc_turret", var4, var1.weapon);
  var5 setModel(get_turret_model_from_short(var2));
  var5 linkTo(self);
  var5.sentrytype = "auto_turret";
  var5.muzzlepoint = var5 gettagorigin("tag_aim_pivot");
  var5 maketurretinoperable();
  var5 setmode("manual");
  var5.team = "axis";
  var5.script_team = "axis";
  var5 setturretteam("axis");
  var5 makeunusable();
  var5 notsolid();
  set_turret_settings_from_model(var5, var2);
  set_turret_settings_from_weapon(var5, var4);
  var5.target_ent = var5 scripts\engine\utility::spawn_tag_origin();
  var5.target_ent show();
  var5 settargetentity(var5.target_ent);
  return var5;
}

function set_turret_settings_from_model(var0) {
  switch (var0) {
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

function set_turret_settings_from_weapon(var0) {
  switch (var0) {
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

function get_turret_model_from_short(var0) {
  var1 = undefined;

  switch (var0) {
    case "minigun":
      var1 = "weapon_wm_mg_mobile_turret";
      break;
    case "wheelson":
      var1 = "veh8_mil_lnd_whotel_turret";
      break;
    default:
      break;
  }

  return var1;
}

function vehicle_follow_parent(var0, var1, var2) {
  var0 endon("death");
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  if(!isDefined(var2)) {
    var2 = (0, 0, 0);
  }

  var1 += (15, 0, 32);

  for(;;) {
    if(isDefined(self.truck) && !self.truck issuspendedvehicle() && self.truck vehicle_getspeed() > 0) {
      var3 = var0 gettagorigin("tag_aim");
      var4 = var0 gettagangles("tag_aim");
      var5 = (0, var4[1], 0);
      self vehicle_teleport(var3 + rotatevector(var1, var5), (270, 180, 180));
    }

    wait 0.1;
  }
}

function process_turret_sweep_nodes(var0) {
  if(!isDefined(var0)) {
    return;
  }

  level.turret_start_locs = [];
  var1 = scripts\engine\utility::getStructArray("convoy_turret_target", "script_noteworthy");

  foreach(var3 in var1) {
    if(var3.script_parameters != var0) {
      scripts\engine\utility::array_remove(var1, var3);
    }
  }

  foreach(var3 in var1) {
    var3.end1 = var3;
    var3.end2 = var3;

    while(isDefined(var3.end1.target)) {
      var3.end1 = scripts\engine\utility::getStruct(var3.end1.target, "targetname");
    }

    while(isDefined(scripts\engine\utility::getStruct(var3.end2.targetname, "target"))) {
      var3.end2 = scripts\engine\utility::getStruct(var3.end2.targetname, "target");
    }

    level.turret_start_locs[level.turret_start_locs.size] = var3;
  }
}

function shoot_vehicle_turret_at_attacker(var0) {
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

  self.target_player = var0;
  var1 = 6000;
  var2 = var1 * var1;

  while(distance2dsquared(self.origin, self.target_player.origin) < var2) {
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
    var0 = undefined;
    var1 = 30250000;

    foreach(var3 in level.players) {
      var4 = distance2dsquared(self.origin, var3.origin);

      if(var4 < var1) {
        var0 = var3;
        var1 = var4;
      }

      wait 0.1;
    }

    if(!isDefined(var0)) {
      continue;
    }

    if(!isalive(var0)) {
      continue;
    }

    if(!istrue(self.can_find_new_target)) {
      continue;
    }

    if(istrue(self.turret_disabled)) {
      continue;
    }

    self.target_player = var0;
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

  var0 = 30;
  var0 += randomfloatrange(0, 15);

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
      var1 = gettime();

      if(var1 > self.last_horn_time + 1000 * var0) {
        self.last_horn_time = undefined;
        return;
      }

      return;
    }

    return;
  }
}

function turret(var0) {
  thread turret_internal(var0);
}

function turret_internal(var0) {
  var0 endon("death");
  var0 endon("end_turret");
  var1 = get_truck_turret_start_node(var0);
  var2 = get_turret_path(var0);
  set_turret_target_loc(var0, var0.target_player.origin + (0, 0, 40));
  start_firing_turret(var0);

  if(isDefined(var2)) {
    wait 1;
    turret_sweep_to_loc(var0, var2.end, var0.turret.speed, 1);
  } else {
    var3 = 0;

    while(var3 <= 3) {
      set_turret_target_loc(var0, var0.target_player.origin + (0, 0, 40));
      wait 0.25;
      var3 += 0.25;
    }
  }

  clean_up_turret(var0);
}

function set_turret_owner_to_riders() {
  if(isDefined(self.riders)) {
    foreach(var1 in self.riders) {
      if(isalive(var1) && isai(var1)) {
        self.turret setturretowner(var1);
      }
    }

    return;
  }
}

function clean_up_turret(var0) {
  stop_firing_turret(var0);
}

function get_turret_path(var0) {
  var1 = spawnStruct();
  var2 = var0.target_player;
  var3 = scripts\engine\utility::getclosest(var2.origin, level.turret_start_locs, 200);

  if(!isDefined(var3)) {
    return undefined;
  }

  var4 = distance2dsquared(var2.origin, var3.end1.origin);
  var5 = distance2dsquared(var2.origin, var3.end2.origin);

  if(var4 > var5) {
    var6 = var3.end1;
  } else {
    var6 = var4.end2;
  }

  var2.start = var3.origin;
  var2.end = var6.origin;
  return var2;
}

function get_truck_turret_start_node(var0) {
  if(!isDefined(level.turret_start_locs) || level.turret_start_locs.size <= 0) {
    return;
  }

  var1 = var0.target_player;
  var2 = scripts\engine\utility::getclosest(var1.origin, level.turret_start_locs);
  return var2.truck_loc;
}

function turret_manager(var0) {
  var0 endon("death");
  var0.turret endon("death");
  init_turret_lifetime_shot_count(var0);

  for(;;) {
    var0 waittill("start_firing_turret");
    reset_turret_shot_count(var0);
    wait var0.turret.warning_time;

    while(turret_should_keep_firing(var0)) {
      fire_turret(var0);
      wait var0.turret.wait_between_shots;

      if(!should_continue_current_shot_run(var0)) {
        if(get_shot_fired(var0) == var0.turret.shots_per_round) {
          reset_turret_shot_count(var0);
          wait var0.turret.wait_between_shot_round;
        }

        if(!turret_should_keep_firing(var0)) {
          break;
        }
      }
    }
  }
}

function should_continue_current_shot_run(var0) {
  if(!turret_should_keep_firing(var0)) {
    return false;
  }

  if(get_shot_fired(var0) == var0.turret.shots_per_round) {
    return false;
  }

  return true;
}

function play_spin_up_sfx(var0) {
  var0 endon("death");
  var0.turret endon("death");
  var0.turret notify("play_minigun_spin_up_SFX");
  var0.turret endon("play_minigun_spin_up_SFX");
  var0.turret endon("play_minigun_spin_down_SFX");

  if(!isent(var0.turret)) {
    return;
  }

  var1 = var0.turret.warning_time / 4;
  var0.turret playSound("convoy_gatling_distant_spinup1");
  wait var1;
  var0.turret playSound("convoy_gatling_distant_spinup2");
  wait var1;
  var0.turret playSound("convoy_gatling_distant_spinup3");
  wait var1;
  var0.turret playSound("convoy_gatling_distant_spinup4");
  wait var1;
  var0.turret playLoopSound("minigun_heli_gatling_spinloop");
}

function play_spin_down_sfx(var0) {
  var0 endon("death");
  var0.turret endon("death");
  var0.turret notify("play_minigun_spin_down_SFX");
  var0.turret endon("play_minigun_spin_down_SFX");
  var0.turret endon("play_minigun_spin_up_SFX");
  var1 = var0.turret.warning_time / 4;
  var0.turret stoploopsound("minigun_heli_gatling_spinloop");
  var0.turret playSound("convoy_gatling_distant_spindown4");
  wait var1;
  var0.turret playSound("convoy_gatling_distant_spindown3");
  wait var1;
  var0.turret playSound("convoy_gatling_distant_spindown2");
  wait var1;
  var0.turret playSound("convoy_gatling_distant_spindown1");
}

function get_shot_fired(var0) {
  return var0.turret.shot_count;
}

function init_turret_lifetime_shot_count(var0) {
  var0.turret.lifetime_shot_count = 0;
}

function should_skip_first_few_shot(var0) {
  var1 = 5;
  return var0.turret.lifetime_shot_count < var1;
}

function reset_turret_shot_count(var0) {
  if(!isent(var0.turret)) {
    return;
  }

  var0.turret.shot_count = 0;
}

function fire_turret(var0) {
  var0.turret.lifetime_shot_count++;

  if(should_skip_first_few_shot(var0)) {
    return;
  }

  var0.turret shootturret();
  var0.turret.shot_count++;
}

function turret_track_target(var0, var1) {
  thread turret_track_target_think(var0, var0);
}

function turret_track_target_think(var0, var1) {
  var0 endon("death");
  var0 endon("stop_turret_tracking_target");

  for(;;) {
    var2 = var1.recent_position;
    set_turret_target_loc(var0, var2);
    wait var0.turret.track_target_delay;
  }
}

function start_firing_turret(var0) {
  var0.keep_firing_turret = 1;
  var0 notify("start_firing_turret");
}

function stop_firing_turret(var0) {
  var0.keep_firing_turret = 0;
}

function turret_should_keep_firing(var0) {
  return istrue(var0.keep_firing_turret);
}

function turret_is_firing(var0) {
  return istrue(var0.keep_firing_turret);
}

function set_turret_target_loc(var0, var1) {
  var0.turret.target_ent dontinterpolate();
  var0.turret.target_ent.origin = var1;
}

function turret_sweep_to_loc(var0, var1, var2, var3) {
  var4 = distance(var0.turret.target_ent.origin, var1) / var2;
  var0.turret.target_ent moveTo(var1, var4);

  if(istrue(var3)) {
    wait var4;
    return;
  }
}