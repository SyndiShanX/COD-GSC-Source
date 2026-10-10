/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_746b6a89a2ea92f5.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp\agent_damage;
#using scripts\cp\damagefeedback;
#using scripts\cp\laststand;
#using scripts\cp\persistence;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#namespace namespace_204f70473d5c12c;

function init() {
  level._effect["drone_turret_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_lrg_dest_exp.vfx");
  level._effect["drone_grenade_light_danger"] = loadfx("vfx/iw8_cp/raid/vfx_raid_wheelson_flashlight_npc.vfx");

  if(!isDefined(level.drone_turrets)) {
    level.drone_turrets = [];
  }

  init_types();
}

function init_types() {
  if(!isDefined(level.var_44e7aa9ca256a799)) {
    level.var_44e7aa9ca256a799 = [];
  }

  level.var_44e7aa9ca256a799["flash_grenade_mp"] = spawnStruct();
  level.var_44e7aa9ca256a799["flash_grenade_mp"].cooldown = 12.5;
  level.var_44e7aa9ca256a799["flash_grenade_mp"].var_29111195d194b22a = 0;
  level.var_44e7aa9ca256a799["flash_grenade_mp"].waittime = 2.5;
  level.var_44e7aa9ca256a799["frag_grenade_mp"] = spawnStruct();
  level.var_44e7aa9ca256a799["frag_grenade_mp"].cooldown = 6;
  level.var_44e7aa9ca256a799["frag_grenade_mp"].var_29111195d194b22a = 2;
  level.var_44e7aa9ca256a799["frag_grenade_mp"].waittime = 0;
}

function function_ae2ff42bca6d6dcc(spawnpoint) {
  startpos = spawnpoint.origin;
  startang = spawnpoint.angles;
  vehicleinfo = "veh_radar_drone_recon_mp";
  dronemodel = "veh8_mil_air_tuniform_c4_ai";
  drone = spawnVehicle(dronemodel, "drone_turret", vehicleinfo, startpos, startang);
  drone.team = "axis";
  drone.spawnpoint = spawnpoint;
  drone.spawntime = gettime();
  drone.type = "flash_grenade_mp";

  if(isDefined(drone.spawnpoint) && isDefined(drone.spawnpoint.script_parameters)) {
    drone.type = "" + drone.spawnpoint.script_parameters;
  }

  malfa_clip = getEnt("malfa_clip", "targetname");

  if(isDefined(malfa_clip)) {
    drone.clip = spawn("script_model", malfa_clip.origin);
    drone.clip.angles = malfa_clip.angles;
    drone.clip clonebrushmodeltoscriptmodel(malfa_clip);
    drone.clip.origin = drone.origin;
    drone.clip.angles = drone.angles;
    drone.clip linkTo(drone, "j_body", (0, 0, 0), (0, 0, 0));
    drone.clip enableaimassist();
    drone.clip setCanDamage(1);
    drone.clip makeentitysentient(drone.team, 1, 1);
    drone.clip.var_d1f953c063dff1eb = 1;
    drone thread damage_feedback_watch();
    drone thread watch_for_death();
  }

  drone thread handle_movement();
  drone setscriptablepartstate("lights", "on", 0);
  drone setscriptablepartstate("glint", "on", 0);
  drone setturningability(0.6);
  drone setmaxpitchroll(10, 10);
  drone setairresistance(20);

  if(!isDefined(level.vehicle_ai_script_models)) {
    level.vehicle_ai_script_models = [];
  }

  level.vehicle_ai_script_models[level.vehicle_ai_script_models.size] = drone;
  level.drone_turrets[level.drone_turrets.size] = drone;
  return drone;
}

function handle_movement() {
  self endon("death");
  var_c5013bf3debfe892 = function_bec91df897d1a193();
  function_c8a50f99d108e589(var_c5013bf3debfe892);
}

function function_bec91df897d1a193() {
  struct = self.spawnpoint;

  if(!isDefined(struct.target)) {
    return undefined;
  }

  while(true) {
    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "drone_grenade_line") {
      return struct;
    }

    if(isDefined(struct.target)) {
      targetstruct = getStruct(struct.target, "targetname");
      thread move_to_new_node(targetstruct, (0, 0, 0), 25);

      while(distance(self.origin, targetstruct.origin) > 16) {
        wait 0.1;
      }

      struct = targetstruct;
      continue;
    }

    return undefined;
  }
}

function function_c8a50f99d108e589(var_c5013bf3debfe892) {
  childthread function_572d3c6762b74dab();
  var_e14463f4b51550a1 = 0;

  if(isDefined(var_c5013bf3debfe892) && isDefined(var_c5013bf3debfe892.radius)) {
    var_e14463f4b51550a1 = int(var_c5013bf3debfe892.radius);
  }

  if(!isDefined(var_c5013bf3debfe892.target)) {
    return;
  }

  var_9f656d408fe35b51 = getStruct(var_c5013bf3debfe892.target, "targetname");

  while(true) {
    nearest_player = function_b4c76b9635f7c3f0(4194304);

    if(!isDefined(nearest_player)) {
      wait 3;
      continue;
    }

    currentdist = distance2d(nearest_player.origin, self.origin);

    if(isDefined(nearest_player) && currentdist > 64) {
      targetstruct = spawnStruct();
      targetstruct.origin = pointonsegmentnearesttopoint(var_c5013bf3debfe892.origin, var_9f656d408fe35b51.origin, nearest_player.origin);

      if(var_e14463f4b51550a1 > 0) {
        var_81127e016b847fdd = nearest_player.origin - targetstruct.origin;
        var_904ba70f73808cb7 = vectornormalize2(var_81127e016b847fdd);
        var_d70ed963b89051fd = length2d(var_81127e016b847fdd);
        var_81127e016b847fdd = ter_op(var_d70ed963b89051fd > var_e14463f4b51550a1, var_904ba70f73808cb7 * var_e14463f4b51550a1, var_904ba70f73808cb7 * var_81127e016b847fdd);
        targetstruct.origin += var_81127e016b847fdd;
      }

      if(distance2d(self.origin, targetstruct.origin) > 25) {
        thread move_to_new_node(targetstruct, (0, 0, 0), 25);
      }

      while(distance(self.origin, targetstruct.origin) > 12) {
        wait 0.1;
      }
    }

    wait 0.5;
  }
}

function function_572d3c6762b74dab() {
  while(true) {
    nearest_player = function_b4c76b9635f7c3f0(147456);

    if(isDefined(nearest_player) && function_e9e1ba41686efa8e()) {
      childthread drop_grenade(nearest_player);
    }

    wait 0.1;
  }
}

function function_b4c76b9635f7c3f0(maxdist_sq) {
  var_7296729673615c7 = 1073741824;

  if(isDefined(maxdist_sq)) {
    var_7296729673615c7 = maxdist_sq;
  }

  closest_player = undefined;

  foreach(player in level.players) {
    if(isDefined(level.ignoredbycheck) && [[level.ignoredbycheck]](self, player)) {
      continue;
    }

    if(scripts\cp\laststand::player_in_laststand(player)) {
      continue;
    }

    if(player.origin[2] > self.origin[2] - 25) {
      continue;
    }

    dist_sqr = distance2dsquared(self.origin, player.origin);

    if(player scripts\cp_mp\utility\player_utility::_isalive() && dist_sqr < var_7296729673615c7) {
      closest_player = player;
      var_7296729673615c7 = dist_sqr;
    }
  }

  return closest_player;
}

function function_e9e1ba41686efa8e() {
  if(!isDefined(self.var_287efb93cfffbdbd)) {
    return true;
  }

  var_b344f40b2915564a = 7.5;

  if(isDefined(level.var_44e7aa9ca256a799[self.type])) {
    var_b344f40b2915564a = level.var_44e7aa9ca256a799[self.type].cooldown;
  }

  if(getdvarint(@ "hash_b52efb180e0a0c93", 0) > 0) {
    var_b344f40b2915564a = getdvarint(@ "hash_b52efb180e0a0c93", 0);
  }

  if(gettime() - self.var_287efb93cfffbdbd > var_b344f40b2915564a * 1000) {
    return true;
  }

  return false;
}

function drop_grenade(nearest_player) {
  self.var_287efb93cfffbdbd = gettime();
  velocity = (0, 0, -10);
  distancetoplayer = distance(self.origin, nearest_player.origin);
  var_18041d0638a909b7 = distancetoplayer / 800 + 0.25;
  var_29111195d194b22a = 0;
  waittime = 0;
  lookangle = vectortoangles(nearest_player.origin - self.origin);
  self setgoalyaw(lookangle[1]);
  self setyawspeed(400, 300, 270, 0.3);

  if(isDefined(level.var_44e7aa9ca256a799[self.type])) {
    var_29111195d194b22a = level.var_44e7aa9ca256a799[self.type].var_29111195d194b22a;
    waittime = level.var_44e7aa9ca256a799[self.type].waittime;
  }

  if(var_29111195d194b22a > 0) {
    var_18041d0638a909b7 += var_29111195d194b22a;
  }

  if(waittime > 0) {
    wait waittime;
  }

  nade = magicgrenademanual(self.type, self.origin - (0, 0, 2), velocity, var_18041d0638a909b7);
  thread function_241a6f854e3af34d();
  wait var_18041d0638a909b7;

  if(self.type == "flash_grenade_mp") {
    foreach(player in level.players) {
      if(distance(player getEye(), nade.origin) < 500) {
        result = scripts\cp\weapon::applyflashfromdamage(player, self, nade.origin, 0);
      }
    }
  }
}

function function_241a6f854e3af34d() {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(self.light_fx_tag)) {
    self.light_fx_tag = "tag_camera_fx";
  }

  playFXOnTag(level._effect["drone_grenade_light_danger"], self, self.light_fx_tag);
  wait 5;
  stopFXOnTag(level._effect["drone_grenade_light_danger"], self, self.light_fx_tag);
}

function move_to_new_node(node, offset, speed_override) {
  self endon("death");
  self notify("move_to_new_node");
  self endon("move_to_new_node");

  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  dist = distance(self.origin, node.origin);

  if(!isDefined(node.angles)) {
    node.angles = (0, 0, 0);
  }

  if(dist > 1) {
    self.next_node = node;
    speed = 10;

    if(isDefined(speed_override)) {
      speed = speed_override;
    }

    self.move_speed = speed;
    self vehicle_setspeed(speed, speed * 0.65, speed * 0.95);
    lookangle = vectortoangles(node.origin - self.origin);
    self setgoalyaw(lookangle[1]);
    self setyawspeed(400, 300, 270, 0.3);
    thread update_goal_pos(node, offset);
    waittill_any_timeout_2(15, "near_goal", "stop_tracking");
    self notify("stop_tracking");
    self.next_node = undefined;
    self.current_node = node;
    self.move_speed = 0;
    self vehicle_setspeed(1, 120, 120);
    return;
  }

  wait 0.1;
}

function update_goal_pos(node, offset) {
  self endon("death");
  self endon("stop_tracking");
  self notify("update_goal_pos");
  self endon("update_goal_pos");
  pos = undefined;

  if(isvector(node)) {
    pos = node;
  } else if(isDefined(node.origin)) {
    pos = node.origin;
  }

  if(!isDefined(pos)) {
    announcement("<dev string:x1c>");

    return;
  }

  self setvehgoalpos(pos + offset, 0);
  self setneargoalnotifydist(32);
}

function damage_feedback_watch() {
  self endon("death");
  level endon("game_ended");
  self setCanDamage(0);
  self.health = 100000;
  self.clip setCanDamage(1);
  self.clip.health = 100000;
  self.clip.fake_health = 50;
  self.var_689d46e1e37cc5ad = &function_c5d04118503d4ea7;

  while(true) {
    self.clip waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid);
    self.clip.fake_health -= idamage;
    self.clip.health = 100000;

    if(!isDefined(eattacker) || !isPlayer(eattacker) && (!isDefined(eattacker.owner) || !isPlayer(eattacker.owner))) {
      continue;
    }

    if(isDefined(self.mgturret)) {
      self notify("pause_move");
    } else if(isDefined(self.drone_base)) {
      self.drone_base notify("pause_move");
    }

    thread function_25586d738b30af98(eattacker);

    if(scripts\cp\agent_damage::should_get_currency_from_kill(einflictor, eattacker, objweapon)) {
      if(idamage < self.clip.fake_health) {
        eattacker scripts\cp\persistence::give_player_currency(10, "large");
      } else {
        eattacker scripts\cp\persistence::give_player_currency(100, "large");
      }
    }

    if(self.clip.fake_health <= 0) {
      self.health = 1;
    }

    scripts\cp\damagefeedback::process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, vdir, spartname, undefined, self);
  }
}

function function_25586d738b30af98(eattacker) {
  self notify("new_damage");
  self endon("new_damage");
  self.last_damaged_by = eattacker;
  self.last_damaged_time = gettime();
  wait 5;
  self.last_damaged_by = undefined;
  self.last_damaged_time = undefined;
}

function function_c5d04118503d4ea7(idamage) {
  if(self.clip.fake_health <= 0) {
    return true;
  }

  return false;
}

function watch_for_death() {
  self endon("death");

  while(true) {
    if(self.clip.fake_health <= 0 || self.health <= 0) {
      thread kill_drone();
    }

    wait 0.1;
  }
}

function kill_drone() {
  if(istrue(self.drone_dying)) {
    return;
  }

  self.drone_dying = 1;
  explode_fx();

  if(isDefined(self.clip.fake_health) && self.clip.fake_health > 0) {
    self.clip dodamage(9999, self.origin, self);
  }

  level.drone_turrets = array_remove(level.drone_turrets, self);
  level.vehicle_ai_script_models = array_remove(level.vehicle_ai_script_models, self);
  self freeentitysentient();
  refs = [self.clip, self];

  if(isDefined(self.clip)) {
    if(issentient(self.clip)) {
      self.clip freeentitysentient();
    }

    self.clip notify("death");
    self.clip delete();
  }

  if(isDefined(self.node_grid)) {
    self.node_grid = undefined;
  }

  var_34a9757868bb0162 = self;

  if(isDefined(var_34a9757868bb0162) && isent(var_34a9757868bb0162)) {
    if(isDefined(var_34a9757868bb0162)) {
      var_34a9757868bb0162 delete();
    }
  }

  waitframe();

  if(isDefined(var_34a9757868bb0162) && isent(var_34a9757868bb0162)) {
    var_34a9757868bb0162 notify("death");
    var_34a9757868bb0162 delete();
  }
}

function explode_fx() {
  playFX(getfx("drone_turret_explode"), self.origin);
  self playSound("cp_bomb_drone_death");
}

function function_8d5e27863a5831e9(var_8d20a2cd0457e5b1) {
  if(!isDefined(level.drone_turrets)) {
    return;
  }

  var_f00f10160eacb571 = level.drone_turrets;

  for(i = 0; i < var_f00f10160eacb571.size; i++) {
    drone = var_f00f10160eacb571[i];

    if(!isDefined(drone) || !isent(drone)) {
      continue;
    }

    if(isDefined(drone.clip) && drone.clip.fake_health <= 0) {
      continue;
    }

    if(isDefined(var_8d20a2cd0457e5b1)) {
      var_5c266234f3e3ad4e = 0;

      foreach(player in level.players) {
        if(distance(drone.origin, player.origin) < var_8d20a2cd0457e5b1) {
          var_5c266234f3e3ad4e = 1;
        }
      }

      if(var_5c266234f3e3ad4e) {
        continue;
      }
    }

    drone thread kill_drone();
  }
}