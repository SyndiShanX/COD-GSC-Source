/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\roadkill_code.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\_vehicle;
#include animscripts\hummer_turret\common;
#include maps\_hud_util;

turret_guy_in_near_humvee() {
  wait(0.2);

  vehicle = self.ridingVehicle;
  angles = vehicle.angles;
  angles = (0, angles[1], 0);
  forward = anglesToForward(angles);

  ent = spawn_tag_origin();
  ent.origin = vehicle.origin + forward * 250 + (0, 0, 120);
  ent LinkTo(vehicle);
  self.ignoreall = true;

  turret = self GetTurret();
  turret SetMode("manual");
  turret SetTargetEntity(ent);
}

player_fails_if_he_kills_me(damage, attacker, direction_vec, point, type, modelName, tagName) {
  if(!isalive(attacker))
    return;
  if(attacker != level.player) {
    return;
  }
  vehicle = self.ridingVehicle;
  if(isDefined(vehicle)) {
    if(vehicle ent_flag("can_shoot_the_baddies"))
      return;
  }

  wait(1);

  setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
  maps\_utility::missionFailedWrapper();
}

aim_ahead_until_you_get_enemy() {
  self endon("death");

  for(;;) {
    if(isDefined(self.ridingVehicle)) {
      break;
    }
    wait(0.05);
  }

  vehicle = self.ridingVehicle;
  add_damage_function(::player_fails_if_he_kills_me);

  if(vehicle.script_index == 0)
    vehicle.target_override = "turret_aim_target_first";

  angles = vehicle.angles;
  angles = (0, angles[1], 0);
  forward = anglesToForward(angles);

  ent = spawn_tag_origin();
  ent.origin = vehicle.origin + forward * 250 + (0, 0, 120);
  ent LinkTo(vehicle);

  turret = undefined;
  for(;;) {
    turret = self GetTurret();
    if(isDefined(turret)) {
      break;
    }
    if(!isDefined(self.ridingVehicle))
      return;
    wait(0.05);
  }

  turret SetMode("manual");
  turret SetTargetEntity(ent);

  oldmaxsight = self.maxsightdistsqrd;
  self.maxsightdistsqrd = 0;
  turret.dontshoot = true;

  turret thread gunner_aims_at_targets(ent, self.ridingVehicle);

  flag_wait("humvees_spin_up");

  self.maxsightdistsqrd = oldmaxsight;
  thread turret_recovers_shooting_ability(vehicle, turret);

  wait(RandomFloat(1.5));
  turret play_sound_on_entity("minigun_gatling_spinup_npc");
  turret StartBarrelSpin();
  turret StartFiring();

  vehicle ent_flag_wait("start_aiming_at_badguys");

  turret notify("stop_aiming_at_targets");
}

turret_recovers_shooting_ability(vehicle, turret) {
  turret SetMode("auto_ai");
  turret ClearTargetEntity();

  vehicle ent_flag_wait("can_shoot_the_baddies");

  turret.dontshoot = undefined;
}

gunner_aims_at_targets(default_target, vehicle) {
  self endon("stop_aiming_at_targets");
  self endon("death");

  targetname = "turret_aim_target";
  if(isDefined(vehicle.target_override))
    targetname = vehicle.target_override;

  targets = getEntArray(targetname, "targetname");
  foreach(target in targets) {
    if(!isDefined(target.script_noteworthy))
      target.script_noteworthy = "";
  }

  level.toffset++;

  for(;;) {
    ents = get_array_of_closest(self.origin, targets, undefined, 5, 2000, 500);

    next_target = default_target;

    angles = vehicle.angles;

    priority_target = undefined;
    foreach(ent in ents) {
      if(ent.script_noteworthy == "priority") {
        dot = get_dot(self.origin, angles, ent.origin);

        if(dot > 0.7) {
          priority_target = ent;
          break;
        }
      }
    }

    if(isDefined(priority_target)) {
      next_target = priority_target;
    } else {
      for(i = 0; i < ents.size; i++) {
        ent = ents[i];
        dot = get_dot(self.origin, angles, ent.origin);

        if(dot > 0.8) {
          next_target = ent;
          break;
        }
      }
    }

    if(vehicle == level.crazy_ride_convoy["detour"]) {
      if(flag("shot_rings_out"))
        return;
    }

    self SetTargetEntity(next_target);
    if(next_target == default_target) {
      wait(0.15);
    } else {
      for(;;) {
        angles = vehicle.angles;
        dot = get_dot(self.origin, angles, next_target.origin);
        if(dot < 0) {
          break;
        }
        wait(0.1);
      }
    }
  }
}

linder(ent) {
  self notify("stop");
  self endon("stop");
  for(;;) {
    Line(self.origin, ent.origin);
    wait(0.05);
  }
}

hargrove_spawner() {
  self.animname = "hargrove";
  self gun_remove();
}

protect_player_while_scene_is_active() {
  timeoutEnt = spawnStruct();
  timeout_time = 10;
  if(getdvarint("newintro"))
    timeout_time = 18;

  timeoutEnt thread notify_delay("timeout", timeout_time);
  timeoutEnt endon("timeout");

  for(;;) {
    flag_wait("player_hangs_with_commanders");
    set_player_attacker_accuracy(0);
    level.player.IgnoreRandomBulletDamage = true;

    flag_waitopen("player_hangs_with_commanders");
    maps\_gameskill::updateAllDifficulty();
    level.player.IgnoreRandomBulletDamage = false;
  }
}

player_is_protected_near_commanders() {
  protect_player_while_scene_is_active();
  maps\_gameskill::updateAllDifficulty();
  level.player.IgnoreRandomBulletDamage = false;
}

roadkill_foley_shepherd_intro() {
  waittillframeend;
  level.shepherd thread shepherd_roams_battlefield("shepherd_path");
  thread player_is_protected_near_commanders();
  struct = getstruct("roadkill_shepherd_scene", "targetname");

  guys = [];
  guys["foley"] = level.foley;

  struct thread anim_first_frame_solo(level.foley, "roadkill_riverbank_intro");
  wait(1.5);
  struct thread anim_single_solo_run(level.foley, "roadkill_riverbank_intro");

  wait(0.05);

  offset_start = 2;
  animation = level.foley getanim("roadkill_riverbank_intro");
  anim_time = GetAnimLength(animation);
  start_time = offset_start / anim_time;
  level.foley SetAnimTime(animation, start_time);

  node = GetNode("foley_walk_node", "targetname");
  level.foley.a.movement = "run";
  level.foley SetGoalNode(node);
  level.foley.goalradius = 16;
  level.foley add_to_allied_riverbank_ai();

  for(;;) {
    time = level.foley GetAnimTime(animation);
    if(time >= 0.975) {
      break;
    }
    wait(0.05);
  }

  level.foley anim_stopanimscripted();
}

ent_flag_set_trigger() {
  for(;;) {
    self waittill("trigger", other);
    if(!first_touch(other))
      continue;
    other ent_flag_set(self.script_flag);
  }
}

foley_spawner() {
  AssertEx(!isDefined(level.foley), "Multiple Foleys!");
  level.foley = self;
  self.animname = "foley";
  self make_hero();

  if(!flag("player_rolls_into_town")) {
    flag_wait("player_rolls_into_town");
    self safe_delete();
  }
}

safe_delete() {
  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.magic_bullet_shield))
    self stop_magic_bullet_shield();
  self Delete();
}

dunn_spawner() {
  AssertEx(!isDefined(level.dunn), "Multiple Dunns!");
  level.dunn = self;
  self.animname = "dunn";
}

shepherd_spawner() {
  AssertEx(!isDefined(level.shepherd), "Multiple Shepherds!");
  level.shepherd = self;
  self.animname = "shepherd";
  self make_hero();

  if(!flag("player_rolls_into_town")) {
    flag_wait("player_rolls_into_town");
    self safe_delete();
  }
}

player_humvee() {
  self.dontdisconnectpaths = true;
  level.player_humvee = self;
  level.player_humvee.animname = "player_humvee";

  if(level.start_point == "intro" || level.start_point == "getout") {
    org = self player_rides_shotgun_in_humvee(170, 170, 45, 15);

    flag_wait("slam_hood");
    wait(1.5);

    org player_leaves_humvee();
    level.player AllowCrouch(true);
    level.player AllowProne(true);
  }
}

player_turret_humvee() {
  self.dontdisconnectpaths = true;
  level.player_humvee = self;
  level.player_humvee.animname = "player_humvee";

  self player_gets_on_turret();
}

player_gets_on_turret() {
  thread warn_if_player_shoots_prematurely();

  level.player AllowCrouch(true);
  level.player AllowProne(true);

  level.player PlayerLinkToDelta(self, "tag_player", 0.35, 360, 360, 45, 30, true);
  turret = self.mgturret[0];
  turret setModel("weapon_suburban_minigun_viewmodel");
  turret MakeUsable();
  turret SetMode("manual");
  turret UseBy(level.player);
  turret MakeUnusable();

  level.player_turret = turret;
  level.player SetPlayerAngles((0, level.player_humvee.angles[1], 0));

  level.player DisableTurretDismount();

  thread maps\_minigun_viewmodel::player_viewhands_minigun(turret);
}

front_vehicle() {
  self.dontdisconnectpaths = true;
  if(is_first_start()) {
    flag_wait("player_humvee_stops_for_officers");
    wait(3);
    self Vehicle_SetSpeed(0, 10, 10);
  }

  flag_wait("slam_hood");
  wait(1.5);
  self vehicle_unload("passengers");
}

ending_vehicle() {
  self.dontunloadonend = true;
  self.dontdisconnectpaths = true;
  self waittill("reached_end_node");
  level.ending_vehicles[level.ending_vehicles.size] = self;
}

shepherd_ending_vehicle() {
  self.dontunloadonend = true;
  self.dontdisconnectpaths = true;
  self waittill("reached_end_node");
  self vehicle_unload("rear_driver_side");
}

near_vehicle() {
  level.near_vehicle = self;
  self.dontunloadonend = true;
  self.dontdisconnectpaths = true;

  if(is_first_start()) {
    flag_wait("player_humvee_stops_for_officers");
    wait(3);
  }
  flag_wait("slam_hood");
  wait(1.5);
  self vehicle_unload("passengers");
}

rear_vehicle() {
  self.dontdisconnectpaths = true;

  if(is_first_start()) {
    flag_wait("player_humvee_stops_for_officers");

    for(;;) {
      speed = level.player_humvee.veh_speed;
      accel = speed;
      if(accel <= 5) {
        accel = 5;
      }

      self Vehicle_SetSpeed(speed, accel, accel);
      if(flag("slam_hood")) {
        break;
      }
      wait(0.05);
    }
  }

  wait(1.5);
  self vehicle_unload("passengers");
}

intro_convoy() {
  self ent_flag_init("convoy_stops_for_bridge");
}

roadkill_bridge_layer(bridge_model) {
  spawner = GetEnt("bridge_layer_spawner", "targetname");
  spawner.animname = "bridge_layer";

  if(before_bridge_start()) {
    org = getstruct("bridge_layer_org", "targetname");
    org anim_teleport_solo(spawner, "bridge_driveup");
  } else {
    org = getstruct("bridge_layer_org", "targetname");
    org anim_teleport_solo(spawner, "bridge_cross");
    node = GetVehicleNode("bridge_layer_path_1", "targetname");
    spawner.origin = node.origin;
  }

  spawner add_spawn_function(::bridge_layer_think);
  spawner spawn_vehicle();
}

intro_rundown_friendly_spawner() {
  self.pathrandompercent = 200;
}

before_bridge_start() {
  if(level.start_point == "intro")
    return true;
  return level.start_point == "riverbank";
}

bridge_layer_think() {
  self.dontdisconnectpaths = true;
  level.bridge_layer = self;
  self.animname = "bridge_layer";

  level.bridge_start_time = GetTime();

  org = getstruct("bridge_layer_org", "targetname");

  self assign_animtree();
  bridge_model = self.bridge_model;
  bridge_model.animname = "bridge_layer_bridge";
  bridge_model assign_animtree();

  bridge_clip = GetEnt("bridge_clip", "targetname");
  bridge_clip add_target_pivot();
  bridge_clip.pivot LinkTo(bridge_model, "origin_animate_jnt", (0, 0, 0), (0, 0, 180));
  bridge_clip Hide();

  thread bridge_layer_is_threatened_by_baddies(bridge_model);

  guys = [];
  guys["vehicle"] = self;
  guys["bridge"] = bridge_model;

  if(before_bridge_start()) {
    bridge_model Unlink();
    arm_animation = self getanim("bridge_arm_lower");

    array_thread(guys, ::slow_down_bridge);

    org thread anim_single(guys, "bridge_lower");
    wait(0.05);
    foreach(guy in guys) {
      animation = guy getanim("bridge_lower");
      guy SetFlaggedAnim("single anim", animation, 1, 0, 0);
    }

    org thread anim_single(guys, "bridge_lower");

    bridge_anim_rate = 0.62;
    self SetFlaggedAnim("single anim", arm_animation, 1, 0, 1);
    wait(0.05);
    self SetFlaggedAnim("single anim", arm_animation, 1, 0, bridge_anim_rate);

    foreach(guy in guys) {
      animation = guy getanim("bridge_lower");
      guy SetFlaggedAnim("single anim", animation, 1, 0, bridge_anim_rate);
    }

    bridge_animation = bridge_model getanim("bridge_lower");
    for(;;) {
      if(bridge_model GetAnimTime(bridge_animation) >= 0.47) {
        break;
      }
      wait(0.05);
    }

    self SetFlaggedAnim("single anim", arm_animation, 1, 0, 0);
    foreach(guy in guys) {
      animation = guy getanim("bridge_lower");
      guy SetFlaggedAnim("single anim", animation, 1, 0, 0);
    }

    wait 17.5;
    wait 25;
    flag_set("bridge_layer_attacked_by_bridge_baddies");

    start_time = GetTime();
    flag_wait("bridge_baddies_retreat");

    foreach(guy in guys) {
      animation = guy getanim("bridge_lower");
      guy SetFlaggedAnim("single anim", animation, 1, 0, 1);
    }

    self SetFlaggedAnim("single anim", arm_animation, 1, 0, 1);

    bridge_animation = bridge_model getanim("bridge_lower");
    for(;;) {
      if(bridge_model GetAnimTime(bridge_animation) >= 0.68) {
        break;
      }
      wait(0.05);
    }

    wait_for_buffer_time_to_pass(start_time, 30);

    flag_set("riverbank_baddies_retreat");
    flag_set("leaving_riverbank");
    SetSavedDvar("compass", 1);

    level notify("tanks_stop_firing");

    for(;;) {
      if(bridge_model GetAnimTime(bridge_animation) >= 0.98) {
        break;
      }
      wait(0.05);
    }
  } else {
    org thread anim_single(guys, "bridge_lower");

    bridge_model Unlink();

    wait(0.05);
    animation = bridge_model getanim("bridge_lower");
    bridge_model SetAnimTime(animation, 0.99);
    wait(1);
  }

  player_bridge_clip = GetEnt("player_bridge_clip", "targetname");
  player_bridge_clip Delete();

  flag_set("bridgelayer_complete");
  level.bridge_total_time = GetTime() - level.bridge_start_time;

  delayThread(4, ::flag_set, "bridgelayer_crosses");

  animation = getanim("bridge_lower");

  self StopAnimScripted();

  node = GetVehicleNode("bridge_layer_path_1", "targetname");
  self StartPath(node);

  self thread vehicle_paths(node);

  if(!before_bridge_start()) {
    self Vehicle_SetSpeedImmediate(30, 5, 5);
    wait(1);
    self ResumeSpeed(5);
  }

  self waittill("reached_end_node");
  flag_wait("player_gets_in");
  spawn_vehicles_from_targetname_and_drive("lead_vehicle_spawner");
}

slow_down_bridge() {
  wait(0.05);
  animation = self getanim("bridge_lower");
}

enemy_bridge_spawner_damage(damage, attacker, direction_vec, point, type, modelName, tagName) {
  if(!isalive(attacker))
    return;
  if(attacker != level.player) {
    return;
  }
  flag_set("player_attacked_bridge_enemy");
}

enemy_bridge_spawner() {
  startpos = self.origin;
  self endon("death");
  self setthreatbiasgroup("bridge_attackers");

  add_damage_function(::enemy_bridge_spawner_damage);
  self.attackeraccuracy = 0.05;
  self.IgnoreRandomBulletDamage = true;
  flag_wait("bridge_baddies_retreat");

  wait(RandomFloat(1.5));
  node = GetNode(self.target, "targetname");
  self SetGoalNode(node);
  self.goalradius = node.radius;
  self waittill("goal");

  self SetGoalPos(startpos);
  self.goalradius = 16;
  self waittill("goal");
  self Delete();
}

enemy_bridge_vehicle_spawner() {
  flag_wait("bridge_truck_waits");

  wait_until_player_ads_on_truck();

  flag_set("bridge_truck_leaves");
}

wait_until_player_ads_on_truck() {
  flag_assert("bridge_baddies_retreat");

  level endon("bridge_baddies_retreat");

  for(;;) {
    dot = get_dot(level.player getEye(), level.player GetPlayerAngles(), self.origin);
    if(dot > 0.998 && level.player PlayerAds() >= 1.0) {
      break;
    }
    wait(0.05);
  }

  wait(2.5);
}

bridge_layer_is_threatened_by_baddies(bridge_model) {
  if(!is_default_start()) {
    return;
  }
  flag_wait("bridge_layer_attacked_by_bridge_baddies");

  array_spawn_function_targetname("enemy_bridge_vehicle_spawner", ::enemy_bridge_vehicle_spawner);
  spawn_vehicles_from_targetname_and_drive("enemy_bridge_vehicle_spawner");

  wait(1);

  array_spawn_function_targetname("bridge_defender_spawner", ::bridge_defender_spawner);
  delayThread(2, ::array_spawn_targetname, "bridge_defender_spawner");
  array_spawn_targetname("enemy_bridge_spawner");

  wait(2);

  thread bridge_attack_warning_dialogue();

  thread fail_if_player_doesnt_defend_bridge();

  if(level.gameskill >= 2) {
    SetThreatBias("just_player", "bridge_attackers", 3000);
  }

  flag_wait("player_attacked_bridge_enemy");
  SetThreatBias("just_player", "bridge_attackers", 0);
  wait(7);

  flag_set("bridge_baddies_retreat");

  wait(2.5);

  level.foley thread play_sound_on_entity("roadkill_fly_keephitting");
}

bridge_attack_warning_dialogue() {
  wait(3);

  thread foley_line("roadkill_fly_10oclockhigh");

  wait(3.2);

  dunn_line("roadkill_cpd_farside");

  if(flag("player_attacked_bridge_enemy"))
    return;
  level endon("player_attacked_bridge_enemy");

  wait(2.2);

  thread foley_line("roadkill_fly_makingapush");

  wait(2.8);

  dunn_line("roadkill_cpd_bridgelayer");

  wait(1.8);

  foley_line("roadkill_fly_onthebridge");
}

fail_if_player_doesnt_defend_bridge() {
  level endon("player_attacked_bridge_enemy");
  if(flag("player_attacked_bridge_enemy")) {
    return;
  }
  wait(20);
  thread bridge_layer_explodes();
}

bridge_layer_explodes() {
  setDvar("ui_deadquote", &"ROADKILL_BRIDGELAYER_DESTROYED");
  delayThread(3, ::missionFailedWrapper);

  explosion_fx = getfx("bmp_explosion");
  for(;;) {
    vector = randomvector(200);
    z = vector[2];
    z *= 0.5;
    z = abs(z);
    vector = set_z(vector, z);
    playFX(explosion_fx, level.bridge_layer.origin + vector);
    timer = RandomFloatRange(0.4, 0.8);
    wait(timer);
  }
}

bridge_defender_spawner() {
  self endon("death");
  self.attackeraccuracy = 0;
  self.IgnoreRandomBulletDamage = 1;
  flag_wait("player_climbs_stairs");
  self Delete();
}

bridge_almost_done(bridge_model) {
  animation = bridge_model getanim("bridge_lower");
  for(;;) {
    animtime = bridge_model GetAnimTime(animation);
    if(animtime > 0.75) {
      break;
    }
    wait(0.05);
  }
}

fluorescentFlicker() {
  for(;;) {
    self SetLightIntensity(.8);
    wait(RandomFloatRange(0.1, 1.5));

    self SetLightIntensity(RandomFloatRange(0.6, .9) * .8);
    wait(RandomFloatRange(.05, .1));
  }
}

lights() {
  lights = getEntArray("flickerlight1", "targetname");
  foreach(light in lights)
  light thread fluorescentFlicker();
}

get_orgs_from_ents(ents, dontDelete) {
  orgs = [];
  foreach(ent in ents) {
    struct = spawnStruct();
    struct.origin = ent.origin;
    struct.radius = ent.radius;
    orgs[orgs.size] = struct;
    if(!isDefined(dontDelete))
      ent Delete();
  }
  return orgs;
}

riverbank_tank() {
  self endon("death");
  level endon("tanks_stop_firing");

  if(!is_default_start()) {
    return;
  }
  ents = get_linked_ents();
  orgs = get_orgs_from_ents(ents);

  ent = spawn("script_origin", (0, 0, 0));
  ent.origin = orgs[0].origin;
  self SetTurretTargetEnt(ent);
  self.target_ent = ent;

  wait(RandomFloat(4));

  firelink = self.script_firelink;
  firelink_funcs = [];
  firelink_funcs["fire_often"] = ::tank_fires_often;
  firelink_funcs["fire_rarely"] = ::tank_fires_rarely;
  firelink_funcs["fire_never"] = ::tank_fires_never;
  firelink_funcs["stryker_fire"] = ::tank_stryker_fire;

  func = firelink_funcs[firelink];
  [[func]](orgs);
}

tank_fires_never(orgs) {
  ent = self.target_ent;

  for(;;) {
    orgs = array_randomize(orgs);
    foreach(org in orgs) {
      ent.origin = org.origin;
      if(isDefined(org.radius)) {
        ent.origin += randomvector(org.radius);
      }

      if(self Vehicle_CanTurretTargetPoint(ent.origin)) {
        self waittill("turret_on_target");
        wait(RandomFloatRange(2, 3));
      } else {
        wait(RandomFloatRange(3, 5));
      }
    }
  }
}

set_target_org_close(ent) {
  my_org = self.origin + (0, 0, 60);
  angles = VectorToAngles(ent.origin - my_org);
  forward = anglesToForward(angles);
  ent.origin = my_org + forward * 400;
}

tank_fires_rarely(orgs) {
  ent = self.target_ent;
  wait(RandomFloat(10));

  for(;;) {
    orgs = array_randomize(orgs);
    foreach(org in orgs) {
      ent.origin = org.origin;
      if(isDefined(org.radius)) {
        ent.origin += randomvector(org.radius);
      }

      set_target_org_close(ent);

      if(self Vehicle_CanTurretTargetPoint(ent.origin)) {
        self waittill("turret_on_target");
        wait(RandomFloatRange(0.5, 2));

        shots = RandomInt(4) - 1;
        for(i = 0; i < shots; i++) {
          self FireWeapon();

          wait(RandomFloatRange(5, 8));
        }
        wait(15);
      } else {
        wait(RandomFloatRange(3, 5));
      }
    }
  }
}

tank_stryker_fire(orgs) {
  if(!is_default_start()) {
    RadiusDamage(level.riverside_bmp.origin, 128, 5000, 5000);
    return;
  }

  thread tank_fires_often(orgs);

  wait(18);

  level.riverside_bmp waittill_player_lookat(0.98, 0.1, true, 20);

  self notify("stop_tank_fire");

  stryker_blows_up_riverside_bmp();

  tank_fires_often(orgs);
}

stryker_blows_up_riverside_bmp() {
  self.target_ent.origin = level.riverside_bmp.origin + (0, 0, 32);
  self waittill("turret_on_target");
  wait(0.25);

  shots = RandomInt(4) - 1;
  for(;;) {
    if(!isalive(level.riverside_bmp)) {
      break;
    }
    self FireWeapon();
    wait(RandomFloatRange(1, 1.5));
  }
}

tank_fires_often(orgs) {
  self endon("stop_tank_fire");
  ent = self.target_ent;

  for(;;) {
    orgs = array_randomize(orgs);
    foreach(org in orgs) {
      ent.origin = org.origin;
      if(isDefined(org.radius)) {
        ent.origin += randomvector(org.radius);
      }

      set_target_org_close(ent);

      if(self Vehicle_CanTurretTargetPoint(ent.origin)) {
        self waittill("turret_on_target");
        wait(RandomFloatRange(0.5, 2));

        shots = RandomInt(4) - 1;
        for(i = 0; i < shots; i++) {
          self FireWeapon();

          wait(RandomFloatRange(1, 3));
        }
        wait(3);
      } else {
        wait(0.5);
      }
    }
  }
}

roadkill_officers_walk_up() {
  struct = getstruct("intro_orders", "targetname");
  guys = get_guys_with_targetname_from_spawner("intro_friendly_spawner");
  level.roadkill_officers = guys;

  foreach(guy in guys) {
    guy set_run_anim("walk");
    guy.pathrandompercent = 0;
    guy.moveplaybackrate = 1;
    guy.goalradius = 8;
    guy.walkdist = 0;
    guy.disablearrivals = true;
  }

  if(is_first_start()) {
    wait(8);

    foreach(guy in guys) {
      target = getstruct(guy.target, "targetname");
      guy thread maps\_spawner::go_to_node(target, "struct");
    }

    wait(5);
    struct anim_reach_together(guys, "roadkill_intro_orders");
    delayThread(2.950, ::exploder, "intro_boom");
    delayThread(0.5, ::spawn_vehicle_from_targetname_and_drive, "early_f15_flyby");
  }

  struct anim_single(guys, "roadkill_intro_orders");
}

detach_binocs() {
  if(isDefined(self.binoc))
    self Detach("weapon_binocular", "tag_inhand");
  self.binoc = undefined;
}

binoc_scene() {
  struct = getstruct("binoc_scene", "targetname");
  struct thread do_binoc_scene();

  struct = getstruct("binoc_scene_spotter", "targetname");
  struct thread do_binoc_scene();
}

do_binoc_scene() {
  binoc_scene_spawners = getEntArray(self.target, "targetname");
  guys = array_spawn(binoc_scene_spawners);
  guy = guys[0];

  guy.animname = guy.script_noteworthy;

  if(guy.animname == "spotter") {
    guy Attach("weapon_binocular", "tag_inhand");
    guy.binoc = true;
    guy.convoy_func = ::detach_binocs;
  }

  guy.doing_looping_anim = true;
  guy add_to_allied_riverbank_ai();
  self thread play_binoc_scene(guy);
}

play_binoc_scene(guy) {
  self anim_first_frame_solo(guy, "binoc_scene");
  flag_wait("player_enters_riverbank");
  wait(0.75);
  self anim_single_solo(guy, "binoc_scene");
  if(!flag("player_gets_in")) {
    self thread anim_loop_solo(guy, "idle");
  }

  flag_wait("player_gets_in");
  self notify("stop_loop");
}

candy_bar_scene() {
  flag_wait("time_to_go");
  spawners = getEntArray(self.target, "targetname");
  guys = array_spawn(spawners);
  guys[0].animname = "cover_radio3";
  candyMan = guys[0];
  candy = "mil_mre_chocolate01";
  candyMan Attach(candy, "tag_inhand");

  foreach(guy in guys) {
    guy.allowdeath = true;
  }

  self thread anim_loop(guys, "idle");
  flag_wait("player_gets_in");
  if(IsAlive(candyMan))
    candyMan Delete();
}

cover_scene() {
  spawners = getEntArray(self.target, "targetname");
  guys = array_spawn(spawners);
  waittillframeend;

  newguys = [];
  foreach(guy in guys) {
    if(IsSentient(guy))
      continue;
    newguys[newguys.size] = guy;

    guy magic_bullet_shield();
    guy thread shoot_from_notetrack();
  }
  guys = newguys;

  guys[0].animname = "cover_attack2";
  guys[1].animname = "cover_attack3";

  if(isDefined(guys[2]))
    guys[2].animname = "cover_attack1";

  self.g = 5;
  self thread anim_loop(guys, "idle");
  wait(0.05);

  foreach(guy in guys) {
    guy.allowdeath = true;
    animation = guy getanim("idle")[0];
    guy SetAnimTime(animation, 0.35);
  }

  flag_wait("player_gets_in");
  wait(3.2);
  foreach(guy in guys) {
    guy safe_delete();
  }
}

shoot_from_notetrack() {
  self endon("death");
  self.weaponsound = "drone_m4carbine_fire_npc";
  for(;;) {
    self waittill("fire");
    thread maps\_drone::drone_shoot_fx();
  }
}

player_line() {
  for(;;) {
    Line(self.origin, level.player.origin);
    wait(0.05);
  }
}

radio_scene() {
  structs = [];
  structs["1"] = getstruct("radio_scene1", "targetname");
  structs["2"] = getstruct("radio_scene2", "targetname");
  structs["3"] = getstruct("radio_scene3", "targetname");

  guys = [];
  foreach(index, struct in structs) {
    spawner = GetEnt(struct.target, "targetname");
    guys[index] = spawner spawn_ai();
  }

  guys["1"].animname = "cover_radio1";
  guys["2"].animname = "cover_radio2";
  guys["3"].animname = "cover_radio3";

  candyMan = guys["3"];
  candy = "mil_mre_chocolate01";
  candyMan Attach(candy, "tag_inhand");
  candyMan.convoy_func = ::detach_candy;
  candyMan.candy = candy;
  candyMan.doing_looping_anim = true;
  candyMan add_to_allied_riverbank_ai();

  non_candy = [];
  non_candy["1"] = guys["1"];
  non_candy["2"] = guys["2"];

  guys["2"] gun_remove();

  foreach(index, struct in structs) {
    struct thread anim_loop_solo(guys[index], "idle");
  }

  flag_wait("leaving_riverbank");

  level.scr_anim["cover_radio1"]["idle"][0] = level.scr_anim["cover_radio1"]["idle_noshoot"][0];

  flag_wait("player_gets_in");
  foreach(index, struct in structs) {
    struct notify("stop_loop");
  }

  foreach(guy in non_candy) {
    if(isDefined(guy.magic_bullet_shield))
      guy stop_magic_bullet_shield();

    guy Delete();
  }
}

detach_candy() {
  self Detach(self.candy, "tag_inhand");
}

set_dontshootwhilemoving(val) {
  self.dontshootwhilemoving = val;
}

guys_film_explosion() {
  spawner = GetEnt(self.target, "targetname");
  guy = spawner spawn_ai();
  guy endon("death");

  guy.animname = self.script_noteworthy;

  model = level.scr_model[guy.animname];
  guy Attach(model, "tag_inhand");

  if(isDefined(guy.script_delay)) {
    self anim_first_frame_solo(guy, "video_film_start");
    guy script_delay();
  }

  self anim_single_solo(guy, "video_film_start");

  self thread anim_loop_solo(guy, "video_film_idle");
  flag_wait("video_tapers_react");
  self notify("stop_loop");

  start_time = GetTime();
  cheer_time = 6.4;
  if(guy.animname == "film4")
    cheer_time = 8.5;
  if(guy.animname == "film3")
    cheer_time = 6.2;
  if(guy.animname == "film2")
    cheer_time = 6.9;
  if(guy.animname == "film1")
    cheer_time = 6.4;

  guy.noTeleport = true;

  guy disable_pain();

  guy.anim_blend_time_override = 0.5;

  if(guy hasanim("video_film_end")) {
    self thread anim_custom_animmode_solo(guy, "gravity", "video_film_react");
    wait(4);
    guy.anim_blend_time_override = 1;
    guy thread anim_custom_animmode_solo(guy, "gravity", "video_film_end");
  } else {
    self thread anim_custom_animmode_solo(guy, "gravity", "video_film_react");
  }

  wait_for_buffer_time_to_pass(start_time, cheer_time);

  guy StopAnimScripted();
  guy notify("killanimscript");

  if(isDefined(guy.magic_bullet_shield))
    guy stop_magic_bullet_shield();

  guy.fixednode = false;
  node = GetNode("bridge_delete_node", "targetname");
  guy SetGoalNode(node);
  guy.goalradius = 8;
  guy waittill("goal");
  guy Delete();
}

enemy_riverbank_rpg_spawner() {
  self endon("death");
  bridge_targets = getEntArray("bridge_target", "targetname");

  for(;;) {
    target = random(bridge_targets);
    target.health = 1;
    self SetEntityTarget(target);
    timer = RandomFloatRange(1, 3);
    wait(timer);
  }
}

rpgguy() {
  self endon("death");

  for(;;) {
    Print3d(self.origin + (0, 0, 64), "RPG");
    wait(0.05);
  }
}

riverside_house_manager(spawners) {
  if(flag("riverbank_baddies_retreat"))
    return;
  level endon("riverbank_baddies_retreat");

  for(;;) {
    spawners = array_randomize(spawners);
    foreach(spawner in spawners) {
      for(;;) {
        axis = GetAIArray("axis");
        if(axis.size < 6) {
          spawner.count = 1;
          spawner spawn_ai();
          wait(2);
          break;
        }
        wait(2);
      }
    }
  }
}

riverside_flood_manager(spawners) {
  if(flag("riverbank_baddies_retreat"))
    return;
  level endon("riverbank_baddies_retreat");

  for(;;) {
    spawners = array_randomize(spawners);
    foreach(spawner in spawners) {
      for(;;) {
        ai = GetAIArray();
        if(ai.size < 31) {
          spawner.count = 1;
          spawner spawn_ai();
          wait(1);
          break;
        }
        wait(1);
      }
    }
  }
}

riverside_flood_think(delay_min, delay_max) {
  if(flag("riverbank_baddies_retreat"))
    return;
  level endon("riverbank_baddies_retreat");

  self endon("death");
  wait(RandomFloat(1));

  for(;;) {
    self.count = 1;
    guy = self spawn_ai();
    if(!isalive(guy)) {
      wait(1);
      continue;
    }

    guy waittill("death");
    timer = RandomFloatRange(delay_min, delay_max);
    wait(timer);
  }
}

hide_helper_model() {
  self hide_notsolid();
}

show_helper_model() {
  self show_solid();
}

riverbank_guy_dies_on_retreat() {
  self endon("death");
  flag_wait("riverbank_baddies_retreat");
  timer = RandomFloat(3);
  wait(timer);
  self Kill();
}

riverbank_spawner_retreat_think() {
  self endon("death");
  self.startpos = self.origin;
  flag_wait("riverbank_baddies_retreat");
  timer = RandomFloat(6);
  wait(timer);
  self SetGoalPos(self.startpos);
  self.goalradius = 8;
  self waittill("goal");
  self Delete();
}

disable_all_vehicle_mgs() {
  vehicles = getEntArray("script_vehicle", "code_classname");

  foreach(vehicle in vehicles) {
    if(IsSubStr(vehicle.classname, "technical"))
      continue;
    vehicle mgoff();
  }
}

guy_gets_in_player_humvee() {
  if(!isDefined(self.magic_bullet_shield))
    self magic_bullet_shield();

  flag_wait("convoy_moment");

  wait(3.9);

  org = (-2474, -3765, 178);
  self SetGoalPos(org);
  self.goalradius = 8;
  self waittill("goal");

  thread guy_runtovehicle_load(self, level.player_humvee);
  if(isDefined(self.magic_bullet_shield))
    self stop_magic_bullet_shield();

  wait(0.4);
  PrintLn("goalpos " + self.goalpos);
}

jeep_rider_spawner_think() {
  self.qSetGoalPos = false;
  guy_runtovehicle_load(self, level.friendly_open_humvee);
}

humvee_rider_spawner() {
  spawner = GetEnt("humvee_rider_spawner", "script_noteworthy");

  spawner waittill("drone_spawned", guy);
  spawner Delete();
  AssertEx(IsAlive(guy), "No waver!");
  guy thread humvee_rider_waver();
}

humvee_rider_waver() {
  self endon("death");
  self gun_remove();
  wait(0.05);
  self Attach("weapon_m16", "tag_weapon_chest");

  self.ridingVehicle anim_generic_first_frame(self, "help_player_getin", "tag_guy0");
  flag_wait("convoy_moment");
  wait(1.3);
  self.ridingVehicle anim_generic(self, "help_player_getin", "tag_guy0");
  self notify("animontagdone", "end");

  flag_wait("player_gets_in");
  wait(3);
  if(isDefined(self.magic_bullet_shield))
    self stop_magic_bullet_shield();

  self Delete();
}

player_ride_vehicle() {
  level.player_humvee = self;
  self.dontdisconnectpaths = true;
  chairModel = "vehicle_hummer_seat_rb_obj";
  self HidePart("tag_seat_rb_hide");

  chair = spawn("script_model", (0, 0, 0));
  level.chair = chair;
  chair setModel(chairModel);
  chair LinkTo(self, "tag_seat_rb_attach", (0, 0, 0), (0, 0, 0));
  chair MakeUsable();

  flag_wait("convoy_moment");
  self thread gopath();

  wait(1.3);

  self.animname = "player_humvee";
  door_open_animation = self getanim("roadkill_player_door_open");
  self SetFlaggedAnim("other_anim_flag", door_open_animation, 1, 0, 1);
  level thread maps\_anim::start_notetrack_wait(self, "other_anim_flag");

  player_rig = spawn_anim_model("player_rig");
  player_rig LinkTo(self, "tag_body", (0, 0, 0), (0, 0, 0));
  player_rig Hide();

  self anim_first_frame_solo(player_rig, "player_getin", "tag_body");

  flag_set("player_humvee_stops");
  level.player_humvee waittill("vehicle_flag_arrived");

  chair thread chair_waits_for_close();
  chair waittill("trigger");
  level.player DisableWeapons();

  thread player_fov_zooms_in_for_turret();

  self ShowPart("tag_seat_rb_hide");
  chair Delete();

  flag_set("player_gets_in");

  turret = self.mgturret[0];
  turret.animname = "turret";
  turret assign_animtree();
  guys = [];
  guys["player"] = player_rig;
  guys["turret"] = turret;

  level.player SetStance("stand");
  level.player AllowCrouch(false);
  level.player AllowProne(false);

  level.player PlayerLinkToBlend(player_rig, "tag_player", 0.4, 0.2, 0.2);
  player_rig delayCall(0.2, ::Show);

  turret delayThread(1, ::lerp_out_drop_pitch, 1.5);
  player_rig delaythread(0.0, ::play_sound_on_entity, "scn_roadkill_enter_humvee_plr");

  self anim_single(guys, "player_getin", "tag_body");

  player_rig Delete();

  self ClearAnim(door_open_animation, 1, 0, 1);

  level.player EnableWeapons();
  player_gets_on_turret();

  wait(0.1);
  SetSavedDvar("cg_fov", 65);
}

chair_waits_for_close() {
  if(flag("player_gets_in")) {
    return;
  }
  level endon("player_gets_in");
  self endon("death");
  for(;;) {
    if(Distance(self.origin, level.player.origin) < 80)
      self notify("trigger");
    wait(0.05);
  }
}

player_fov_zooms_in_for_turret() {
  wait(1);
  lerp_fov_overtime(2, 55);
}

ride_vehicle() {
  self.dontdisconnectpaths = true;
  flag_wait("player_gets_in");
  self thread gopath();
}

ride_vehicle_starts_moving() {
  thread ride_parameters_check();
  thread common_ride_vehicle_init();
  flag_wait("convoy_moment");
  self thread gopath();
}

common_ride_vehicle_init() {
  self.dontdisconnectpaths = true;
}

ride_parameters_check() {
  if(!isDefined(self.script_parameters)) {
    return;
  }
  switch (self.script_parameters) {
    case "picks_up_riders":
      level.npc_ride_vehicles[level.npc_ride_vehicles.size] = self;
      break;
  }
}

get_vehicle_from_spawner() {
  if(!isDefined(self.target)) {
    return;
  }

  node = GetNode(self.target, "targetname");
  spawner = GetEnt(node.script_linkto, "script_linkname");
  spawner waittill("spawned", vehicle);

  node.vehicle = vehicle;
}

best_friendly_to_run(array) {
  player_angles = level.player GetPlayerAngles();
  player_forward = anglesToForward(player_angles);
  end = level.player getEye();

  foreach(guy in array) {
    start = guy getEye();
    angles = VectorToAngles(start - end);
    forward = anglesToForward(angles);

    dot = VectorDot(forward, player_forward);
    if(dot < 0.75) {
      continue;
    }
    animating_guy = isDefined(guy._animActive) && guy._animActive;

    if(animating_guy && dot >= 0.85) {
      continue;
    }
    return guy;
  }
  return undefined;
}

allies_leave_riverbank() {
  if(flag("player_gets_in"))
    return;
  level endon("player_gets_in");

  array = [];
  foreach(guy in level.allied_riverbank_ai) {
    array[guy.unique_id] = guy;
  }

  for(;;) {
    foreach(guy in array) {
      if(!isalive(guy))
        array[guy.unique_id] = undefined;
    }

    guy = best_friendly_to_run(array);

    if(IsAlive(guy)) {
      array[guy.unique_id] = undefined;

      guy thread run_to_convoy();

      if(level.runnings_to_convoy_count >= level.guy_gets_in_vehicle_targets.size) {
        return;
      }
      wait(4);
    }

    if(!array.size) {
      break;
    }
    wait(0.15);
  }
}

get_in_moving_vehicle() {
  self.get_in_moving_vehicle = true;
}

add_to_allied_riverbank_ai() {
  level.allied_riverbank_ai[level.allied_riverbank_ai.size] = self;

  add_riverbank_flags();
}

add_riverbank_flags() {
  ent_flag_init("go_to_convoy");
  ent_flag_init("got_in_vehicle");
}

allied_riverbank_spawner() {
  self endon("death");

  add_to_allied_riverbank_ai();
  flag_wait("time_to_go");
  self.ignoreall = true;
}

run_to_convoy() {
  level.runnings_to_convoy_count++;

  self anim_stopanimscripted();
  if(isDefined(self.doing_looping_anim)) {
    self.remove_from_animloop = true;
  }

  if(isDefined(self.convoy_func)) {
    self thread[[self.convoy_func]]();
    self.convoy_func = undefined;
  }

  self.moveplaybackrate = 1;
  self.pathrandompercent = 0;
  riverbank_run_node = GetNode("riverbank_run_node", "targetname");
  self.fixednode = false;

  self SetGoalNode(riverbank_run_node);
  self.goalradius = 16;
}

trigger_guy_gets_in_vehicle() {
  level.ally_convoy_trigger = self;

  level.guy_gets_in_vehicle_targets = GetNodeArray(self.target, "targetname");
  foreach(node in level.guy_gets_in_vehicle_targets) {
    node thread get_vehicle_from_spawner();
  }

  used = [];
  foreach(node in level.guy_gets_in_vehicle_targets) {
    AssertEx(isDefined(node.script_index), "Node at " + node.origin + " has no script_index");
    AssertEx(!isDefined(used[node.script_index]), "Reused script_index " + node.script_index + " at " + node.origin);
    used[node.script_index] = true;
  }

  level.guy_gets_in_vehicle_targets = array_index_by_script_index(level.guy_gets_in_vehicle_targets);
  self.index = 0;

  trigger_handles_guys_running_up_stairs_to_get_in_vehicles();

  level.allied_riverbank_ai = remove_dead_from_array(level.allied_riverbank_ai);

  foreach(guy in level.allied_riverbank_ai) {
    guy thread goalspam();

    if(isDefined(guy.gets_in_vehicle)) {
      continue;
    }

    if(self.index >= level.guy_gets_in_vehicle_targets.size) {
      if(isDefined(guy.magic_bullet_shield))
        guy stop_magic_bullet_shield();
      guy Delete();
      continue;
    }

    struct = level.guy_gets_in_vehicle_targets[self.index];
    self.index++;
    guy thread guy_gets_in_convoy(struct);
  }
}

goalspam() {
  self endon("death");
  for(i = 0; i < 5; i++) {
    self notify("goal");
    wait(0.05);
  }
}

trigger_handles_guys_running_up_stairs_to_get_in_vehicles() {
  if(flag("player_gets_in"))
    return;
  level endon("player_gets_in");

  touched = [];
  for(;;) {
    self waittill("trigger", other);
    if(!isalive(other)) {
      continue;
    }
    if(isDefined(touched[other.unique_id])) {
      continue;
    }
    touched[other.unique_id] = true;
    struct = level.guy_gets_in_vehicle_targets[self.index];
    self.index++;
    AssertEx(self.index <= level.guy_gets_in_vehicle_targets.size, "Too many guys!");

    other thread guy_gets_in_convoy(struct);
  }
}

guy_gets_in_convoy(mynode) {
  self.fixednode = true;
  self.gets_in_vehicle = true;
  self.attackeraccuracy = 0;
  if(!isDefined(self.magic_bullet_shield))
    self magic_bullet_shield();
  self SetGoalNode(mynode);
  self.goalradius = 16;

  if(!flag("convoy_moment")) {
    level add_wait(::waittill_msg, "player_got_in");
    self add_wait(::waittill_msg, "goal");
    level add_endon("convoy_moment");
    do_wait_any();

    flag_wait("convoy_moment");
  }

  if(!flag("guys_get_in_convoy_vehicles")) {
    flag_wait("guys_get_in_convoy_vehicles");

    wait_for_index(mynode.script_index);
  }

  if(!isDefined(mynode.target)) {
    flag_wait("player_gets_in");
    self safe_delete();
    return;
  }

  node = GetNode(mynode.target, "targetname");
  self SetGoalNode(node);
  self.disablearrivals = true;

  level add_wait(::waittill_msg, "player_got_in");
  self add_wait(::waittill_msg, "goal");
  do_wait_any();

  self.script_startingposition = node.script_startingposition;

  thread guy_runtovehicle_load(self, node.vehicle);

  self waittill("boarding_vehicle");
  self ent_flag_set("got_in_vehicle");
  if(self.script_startingposition == 4)
    self thread convoy_gunner_think();
}

wait_for_index(index) {
  if(flag("player_gets_in"))
    return;
  level endon("player_gets_in");

  wait(index * 0.35);
}

friendly_open_humvee() {
  level.friendly_open_humvee = self;
  self waittill("reached_end_node");
  house_node = GetNode("house_node", "targetname");

  foreach(guy in self.riders) {
    if(!isalive(guy))
      continue;
    if(!isai(guy)) {
      continue;
    }
    guy SetGoalPos(house_node.origin);
  }
}

vehicle_break() {
  touched = [];
  brake_time = self.script_timer;
  if(!isDefined(brake_time))
    brake_time = 0.3;

  brake_amount = self.script_brake;
  if(!isDefined(brake_amount))
    brake_amount = 0.3;

  for(;;) {
    self waittill("trigger", other);

    if(isDefined(touched[other.unique_id])) {
      continue;
    }
    touched[other.unique_id] = true;
    other thread break_awhile(brake_time, brake_amount);
  }
}

break_awhile(brake_time, brake_amount) {
  self.veh_brake = brake_amount;
  wait(brake_time);
  self.veh_brake = 0;
}

spark_preset() {
  target = getstruct(self.target, "targetname");
  angles = VectorToAngles(target.origin - self.origin);
  level.spark_presets[self.script_parameters] = angles;
}

vehicle_spark_trigger() {
  targ = GetEnt(self.target, "targetname");
  targ_targ = GetEnt(targ.target, "targetname");

  org1 = targ.origin;
  org2 = targ_targ.origin;

  targ Delete();
  targ_targ Delete();

  touched = [];

  technical_only = false;
  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "technical_only":
        technical_only = true;
        break;
    }
  }

  preset = undefined;
  if(isDefined(self.script_parameters)) {
    preset = level.spark_presets[self.script_parameters];
  }

  for(;;) {
    self waittill("trigger", other);

    if(isDefined(touched[other.unique_id])) {
      continue;
    }
    if(technical_only) {
      if(isDefined(level.traffic_jam_truck)) {
        if(other != level.traffic_jam_truck)
          continue;
      } else
        continue;
    }

    touched[other.unique_id] = true;
    other thread vehicle_sparks(org1, org2, preset);
  }
}

vehicle_sparks(org1, org2, preset) {
  fx = getfx("vehicle_scrape_sparks");
  no_spark_frame = RandomInt(4);

  technical = isDefined(level.traffic_jam_truck) && self == level.traffic_jam_truck;
  angles = preset;

  for(;;) {
    my_org = self.origin;
    if(isDefined(self.spark_offset)) {
      my_org += self.spark_offset;
    }
    spark_org = PointOnSegmentNearestToPoint(org1, org2, my_org);
    if(spark_org == org2) {
      return;
    }
    no_spark_frame--;

    if(no_spark_frame && spark_org != org1) {
      angle_range = RandomFloatRange(-85, -55);

      if(!isDefined(preset)) {
        angles = VectorToAngles(spark_org - self.origin);
        angles = (angle_range, angles[1], 0);
      }

      up = AnglesToUp(angles);
      forward = anglesToForward(angles);

      fast_enough = technical || self.veh_speed > 2;

      if(fast_enough) {
        playFX(fx, spark_org, forward, up);
      }
    }

    if(!no_spark_frame)
      no_spark_frame = get_next_no_spark_frame();

    wait(0.05);
  }
}

get_next_no_spark_frame() {
  if(getdvarint("r_roadkill_less_sparks")) {
    return RandomInt(2) + 1;
  }

  return RandomInt(3) + 4;
}

humvee_gunner_idle_until_player_gets_in(owner, turret) {
  level endon("player_gets_in");
  anims = [];
  anims["humvee_turret_bounce"] = true;

  anims["humvee_turret_idle_lookbackB"] = true;
  anims["humvee_turret_idle_signal_forward"] = true;
  anims["humvee_turret_idle_signal_side"] = true;
  anims["humvee_turret_radio"] = true;
  anims["humvee_turret_flinchA"] = true;
  anims["humvee_turret_flinchB"] = true;

  foreach(anime, _ in anims) {
    wait(2);
    level.anime = anime;
    owner turret_gunner_custom_anim(turret, anime);
    if(flag("shot_rings_out"))
      return;
  }
}

detour_vehicle_driver_animates() {
  owner = undefined;
  turret = undefined;

  turret = self.mgturret[0];
  for(;;) {
    owner = turret GetTurretOwner();
    if(IsAlive(owner)) {
      break;
    }
    wait(0.05);
  }

  owner endon("death");
  level.detour_gunner = owner;

  if(!isDefined(owner.magic_bullet_shield)) {
    owner magic_bullet_shield();
  }

  if(!flag("player_gets_in")) {
    humvee_gunner_idle_until_player_gets_in(owner, turret);
    wait(1.5);
  }

  if(!flag("100ton_bomb_goes_off")) {
    owner thread turret_gunner_custom_anim(turret, "humvee_turret_rechamber");
    flag_wait("100ton_bomb_goes_off");
    wait(3.5);
    owner notify("special_anim", "end");
    owner turret_gunner_custom_anim(turret, "humvee_turret_flinchA");
  }

  thread turret_gunner_cycles_custom_anims(owner, turret);
  flag_wait("shot_rings_out");

  struct = getstruct("frantic_look_target_struct", "targetname");
  ent = spawn("script_origin", struct.origin);
  turret SetTargetEntity(ent);

  if(GetDebugDvarInt("showline"))
    turret thread entline(ent);

  count = 0;

  for(;;) {
    owner notify("special_anim", "end");

    struct = getstruct(struct.target, "targetname");

    dist = Distance(ent.origin, struct.origin);
    time = dist / 5000;

    movetime = GetTime();
    ent MoveTo(struct.origin, time, time * 0.2, time * 0.2);

    if(!isDefined(struct.target)) {
      break;
    }

    level waittill_notify_or_timeout("shot_rings_out", 1.5);
    wait_for_buffer_time_to_pass(movetime, 2);

    wait(0.1);
  }

  ent Delete();
}

entline(ent) {
  ent endon("death");
  for(;;) {
    Line(ent.origin, self.origin);
    wait(0.05);
  }
}

turret_gunner_cycles_custom_anims(owner, turret) {
  anims = [];
  anims["humvee_turret_bounce"] = true;

  anims["humvee_turret_idle_lookbackB"] = true;
  anims["humvee_turret_idle_signal_forward"] = true;
  anims["humvee_turret_idle_signal_side"] = true;
  anims["humvee_turret_radio"] = true;
  anims["humvee_turret_flinchA"] = true;
  anims["humvee_turret_flinchB"] = true;

  foreach(anime, _ in anims) {
    wait(2);
    level.anime = anime;
    owner turret_gunner_custom_anim(turret, anime);
    if(flag("shot_rings_out"))
      return;
  }
}
turret_preload_animate() {
  turret = self.mgturret[0];

  turret SetDefaultDropPitch(0);
  turret animscripts\hummer_turret\minigun_stand::setup_turret_anims();
  turret animscripts\hummer_turret\common::turret_animfirstframe(turret.passenger2turret_anime);
}

player_personal_convoy() {
  switch (self.script_index) {
    case 0:
      level.crazy_ride_convoy["lead"] = self;
      break;
    case 1:
      level.crazy_ride_convoy["player"] = self;
      break;
    case 2:
      level.crazy_ride_convoy["rear"] = self;
      self thread turret_preload_animate();
      break;
    case 3:
      level.crazy_ride_convoy["detour"] = self;
      self thread turret_preload_animate();
      thread detour_vehicle_driver_animates();
      thread gunner_becomes_invul();
      break;
    default:
      AssertMsg("err err!");
      break;
  }

  self ent_flag_init("can_shoot_the_baddies");
  self ent_flag_init("start_aiming_at_badguys");

  level.crazy_ride_convoy[self.script_index] = self;
  waittillframeend;

  flag_wait("player_gets_in");

  flag_wait("start_runner");
  if(level.crazy_ride_convoy["player"] == self) {
    self Vehicle_SetSpeed(8.79, 1, 1);
  }
  if(level.crazy_ride_convoy["rear"] == self) {
    self Vehicle_SetSpeed(8.79, 1, 1);
  }

  flag_wait("player_closes_gap");

  self ResumeSpeed(5);

  flag_wait("ambush_auto_adjust_speed");

  self ResumeSpeed(5);

  if(self != level.crazy_ride_convoy["rear"]) {
    return;
  }
  in_front_index = self.script_index - 1;
  near_car = level.crazy_ride_convoy[in_front_index];
  vehicles_maintain_distance_until_traffic(near_car);
}

vehicles_maintain_distance_until_traffic(near_car) {
  following = false;

  for(;;) {
    if(Distance(near_car.origin, self.origin) < 300) {
      self Vehicle_SetSpeed(near_car.veh_speed, 5, 5);
      following = true;
    } else
    if(following) {
      following = false;
      self ResumeSpeed(5);
    }
    wait(0.05);
  }
}

convoy_gunner_think() {
  level.convoy_gunners[self.unique_id] = self;
  thread aim_ahead_until_you_get_enemy();

  self waittill("death");
  wait(1.5);
  if(!isDefined(self)) {
    return;
  }
  self StartRagdoll();
  self Unlink();
}

convoy_gunners_pick_targets() {
  array_thread(level.convoy_gunners, ::convoy_gunner_shoot_protection);
}

convoy_gunner_shoot_protection() {
  if(!isalive(self)) {
    return;
  }
  self endon("death");
  for(;;) {
    self cant_die_unless_player_sees_me();
    self avoid_shooting_through_player();
    wait(0.05);
  }
}

cant_die_unless_player_sees_me() {
  in_danger = within_fov_2d(level.player getEye(), level.player GetPlayerAngles(), self.origin, 0.85);

  if(in_danger) {
    self.IgnoreRandomBulletDamage = false;
    self.attackeraccuracy = 1;
    if(self.health > 100)
      self.health = 100;
  } else {
    self.IgnoreRandomBulletDamage = true;
    self.attackeraccuracy = 0;
    self.health = 5000;
  }
}

avoid_shooting_through_player() {
  enemy = self.enemy;
  if(!isalive(enemy)) {
    return;
  }
  if(enemy.ignoreme) {
    return;
  }
  angles = VectorToAngles(level.player.origin - self.origin);
  if(enemy within_fov_2d(level.player.origin, angles, enemy.origin, 0.85)) {
    enemy.ignoreme = true;
    enemy delayThread(1, ::set_ignoreme, 0);
  }
}

ent_line(ent1, ent2) {
  ent1 endon("death");
  ent2 endon("death");

  timer = 5;
  frames = timer * 20;
  for(i = 0; i < frames; i++) {
    Line(ent1.origin, ent2.origin);
    wait(0.05);
  }
}

enemy_ai_accuracy_effected_by_player_humvee() {
  level endon("player_knocked_down");
  for(;;) {
    ai = GetAIArray("axis");
    foreach(guy in ai) {
      if(!isalive(guy)) {
        continue;
      }
      if(guy.weapon == "rpg") {
        continue;
      }
      if(within_fov_2d(level.player.origin, level.player_humvee.angles, guy.origin, 0.8)) {
        guy.baseaccuracy = 0.2;
      } else {
        guy.baseaccuracy = 0;
      }
      wait(0.02);
    }
    wait(0.05);
  }
}

traffic_jam_truck() {
  level.traffic_jam_truck = self;
  self.vehicle_keeps_going_after_driver_dies = true;
  self.dontunloadonend = true;
  self.spark_offset = (-64, 0, 0);
  self godon();
  self.vehicle_stays_alive = true;
}

setup_ride_path_targets(noteworthy) {
  spawners = getEntArray("ride_vehicle_spawner", "targetname");
  foreach(spawner in spawners) {
    nodes = spawner getLinkedVehicleNodes();
    found_node = false;
    foreach(node in nodes) {
      if(node.script_noteworthy != noteworthy) {
        continue;
      }
      found_node = true;

      if(isDefined(spawner.target))
        remap_targets(spawner.target, node.targetname);
      spawner.target = node.targetname;
      break;
    }
  }
}

remap_targets(ent_targetname, new_targetname) {
  ents = getEntArray(ent_targetname, "targetname");
  foreach(ent in ents) {
    ent.targetname = new_targetname;
  }
}

spawn_more_street_baddies() {
  spawners = level.more_street_spawners;
  wait(7.5);
  foreach(spawner in spawners) {
    spawner.count = 1;
    spawner spawn_ai();
  }
}

ride_killer() {
  level.ride_killer = self;
  self disable_pain();
  self.ignoreme = true;
  self magic_bullet_shield();

  missile_target = GetEnt("missile_target", "targetname");
  self SetEntityTarget(missile_target);

  flag_wait("player_knocked_down");
  self stop_magic_bullet_shield();

  ai = GetAIArray("axis");
  foreach(guy in ai) {
    if(isDefined(guy.magic_bullet_shield))
      guy stop_magic_bullet_shield();

    if(!isDefined(guy.dont_ride_kill))
      guy Kill();
  }
}

friendly_crash_think() {
  level.crash_friendly[level.crash_friendly.size] = self;

  self magic_bullet_shield();
  self SetThreatBiasGroup("ally_with_player");

  self disable_pain();
  self.ignoreSuppression = true;
  self endon("death");
  self.animname = self.animation;
  self thread anim_custom_animmode_solo(self, "gravity", "flashed");
  wait(0.05);

  animtimes = [];
  animtimes["exposed_flashbang_v2"] = 0.245;
  animtimes["exposed_flashbang_v3"] = 0.36;
  animtimes["exposed_flashbang_v5"] = 0.13;

  animlimits = [];
  animlimits["exposed_flashbang_v2"] = 0.72;
  animlimits["exposed_flashbang_v3"] = 0.79;
  animlimits["exposed_flashbang_v4"] = 0.65;
  animlimits["exposed_flashbang_v5"] = 0.65;

  animation = self getanim("flashed");
  animtime = animtimes[self.animation];
  if(isDefined(animtime)) {
    self SetAnimTime(animation, animtime);
  }

  limit = animlimits[self.animation];
  if(isDefined(limit)) {
    for(;;) {
      if(self GetAnimTime(animation) >= limit) {
        break;
      }
      wait(0.05);
    }
    self notify("killanimscript");
  }

  wait(10);
  flag_wait("player_enters_ambush_house");
  self enable_pain();

  if(self.script_forcecolor == "g") {
    if(!self is_hero()) {
      self stop_magic_bullet_shield();
      self thread replace_on_death();
    }
  }

  flag_wait("eyes_on_school");
  self.ignoreSuppression = false;
}

move_flashed_spawner_and_spawn() {
  if(isDefined(self.script_linkTo)) {
    struct = getstruct(self.script_linkto, "script_linkname");
    self.origin = struct.origin;
    self.angles = struct.angles;
  }

  wait(0.25);
  self spawn_ai();
}

blocker_driver() {
  level.blocker_driver = self;
}

roadkill_ride_kill_drones() {
  flag_wait("kill_drones");
  angry_drones = getEntArray("angry_drone", "script_noteworthy");
  foreach(drone in angry_drones) {
    if(IsAlive(drone))
      drone Kill();
    else
      drone Delete();
  }
}

die_after_awhile() {
  self endon("death");
  timer = RandomFloatRange(25, 35);
  wait(timer);
  self Kill();
}

resumeslowly() {
  self endon("death");
  time = 1.0;
  frames = time * 20;

  speed = 1;
  for(i = 0; i < frames; i++) {
    self Vehicle_SetSpeedImmediate(speed, 2, 2);
    speed += 0.6;
    wait(0.05);
  }
  self ResumeSpeed(1);
}

crash_physics_explosion() {
  struct = getstruct("crash_physics_struct", "targetname");
  physics_spawner = getstruct("physics_spawner", "targetname");
  targ = getstruct(physics_spawner.target, "targetname");

  index = 0;
  models = [];
  models[0] = "com_soup_can";
  models[1] = "com_bottle1";
  models[2] = "com_soup_can";
  models[3] = "com_bottle1";
  models[4] = "me_plastic_crate1";

  angles = VectorToAngles(targ.origin - physics_spawner.origin);
  right = AnglesToRight(angles);

  for(i = 0; i < 14; i++) {
    org = targ.origin + randomvector(200);
    angles = VectorToAngles(org - physics_spawner.origin);
    forward = anglesToForward(angles);

    force = forward * RandomFloatRange(4000, 8500);

    model = models[index];
    index++;
    if(index >= models.size)
      index = 0;

    ent = spawn("script_model", physics_spawner.origin);
    ent.origin += right * RandomFloatRange(-40, 40);;
    ent setModel(model);
    ent PhysicsLaunchClient(ent.origin, force);
  }

  PhysicsExplosionSphere(struct.origin, struct.radius, struct.radius, 0.4);
}

goes_to_hell(vehicle_hell) {
  self AttachPath(vehicle_hell);
  wait(0.1);
  self godoff();
  foreach(rider in self.riders) {
    if(!IsAlive(rider)) {
      continue;
    }
    rider safe_delete();
  }
  RadiusDamage(self.origin, 128, 5000, 5000);
}

run_away_die() {
  self endon("death");
  self waittill("goal");
  wait(3);

  struct = getstruct(self.script_linkto, "script_linkname");
  self SetGoalPos(struct.origin);
  self.goalradius = 4;
  self waittill("goal");
  self Kill();
}

player_doesnt_die_in_red_flashing() {
  level endon("ride_ends");
  for(;;) {
    if(level.player ent_flag("player_has_red_flashing_overlay"))
      level.player.attackeraccuracy = 0;
    wait(0.05);
  }
}

school_guy_targets_school() {
  if(flag("shepherd_moves_out"))
    return;
  level endon("shepherd_moves_out");

  targets = getEntArray("school_target", "targetname");

  for(;;) {
    targets = array_randomize(targets);
    foreach(target in targets) {
      self SetEntityTarget(target);
      timer = RandomFloatRange(3, 6);
      wait(timer);
    }
  }
}

ambush_ally_spawner_think() {
  level.ambush_allies_outside_vehicle++;
  self endon("death");

  self SetThreatBiasGroup("ally_outside_school");

  self magic_bullet_shield();
  flag_wait("friendlies_suppress_school");
  self.suppressionwait = 0;
  thread school_guy_targets_school();

  flag_wait("shepherd_moves_out");

  vehicle = getClosest(self.origin, level.ambushed_hummers);

  guy_runtovehicle_load(self, vehicle);
  self stop_magic_bullet_shield();
  level.ambush_allies_outside_vehicle--;
  if(!level.ambush_allies_outside_vehicle)
    flag_set("shepherd_vehicles_leave");

  flag_wait("the_end");
  safe_delete();
}

join_school_threatbias_group_and_damage_func() {
  unreachable = false;
  if(isDefined(self.script_noteworthy)) {
    unreachable = self.script_noteworthy == "school_unreachable_spawner";
  }

  if(unreachable) {
    self SetThreatBiasGroup("axis_school_unreachable");
  } else {
    self SetThreatBiasGroup("axis_school");
  }
  self add_damage_function(::remove_player_from_threatbias_group);
}

remove_player_from_threatbias_group(amt, attacker, force, b, c, d, e) {
  if(!isalive(attacker))
    return;
  if(attacker != level.player) {
    return;
  }
  wait(3);

  level.player SetThreatBiasGroup("allies");
}

ambush_house_spawner_think() {
  self SetThreatBiasGroup("axis_ambush_house");
}

friendlies_traverse_school() {
  for(i = 1; i <= 20; i++) {
    trigger = GetEnt(msg, "targetname");
    if(flag_exist(msg)) {
      flag_wait(msg);

      if(msg == "roadkill_school_10") {
        flag_wait_either("school_back_baddies_dead", "roadkill_near_crossroads");
      }

      volume = trigger get_color_volume_from_trigger();
      if(isDefined(volume))
        volume waittill_volume_dead_or_dying();

      trigger activate_trigger();
    }
  }
}

dunn_says_clear_on_room_clear() {
  flag_wait("hidden_guy_opens_fire");
  wait 1.3;
  volume = getent("dunn_clear_volume", "targetname");
  volume waittill_volume_dead();

  dunn_line("roadkill_cpd_clear");

  wait 1;

  guys = [];
  guys["player"] = level.player;
  guys["foley"] = level.foley;
  guys["dunn"] = level.dunn;

  touchers = 0;
  foreach(guy in guys) {
    if(guy istouching(volume))
      touchers++;
  }

  if(touchers == 2) {
    dunn_line("roadkill_cpd_2cominout");
  } else
  if(touchers == 3) {
    dunn_line("roadkill_cpd_3cominout");
  }
}

hidden_room_spawner() {
  self endon("death");
  self set_force_cover(true);

  add_wait(::can_see_player);
  add_wait(::flag_wait, "hidden_guy_opens_fire");
  do_wait_any();

  self set_force_cover(false);
}

can_see_player() {
  self endon("death");
  for(;;) {
    if(self CanSee(level.player))
      return;
    wait(0.05);
  }
}

cutting_history_class_dialogue() {
  flag_wait("cutting_through_history");

  for(;;) {
    waittillframeend;
    if(!level.dialogue_function_stack_struct.function_stack.size) {
      break;
    }

    wait 0.05;
  }

  dunn_line("roadkill_cpd_historyclass");

  foley_line("roadkill_fly_rogerthat");
}

ambush_house_slowbie() {
  self.moveplaybackrate = 0.76;
  self.attackeraccuracy = 1000;
}

player_impact_earthquake() {
  Earthquake(0.25, 0.8, level.player.origin, 5000);
  level.player PlayRumbleOnEntity("damage_heavy");

  level.player PlayRumbleLoopOnEntity("damage_light");
  flag_wait("player_goes_in_reverse");
  level.player StopRumble("damage_light");
}

traffic_truck_pushed() {
  struct = getstruct("truck_contact_point", "targetname");
  targ = getstruct(struct.target, "targetname");

  vec = VectorNormalize(targ.origin - struct.origin);
  vec *= 2;

  level.traffic_jam_truck VehPhys_Launch(vec, (0, 0, 0), targ.origin);
}

force_player_vehicle_speed(speed) {
  level notify("new_force_player_speed");
  level endon("new_force_player_speed");
  player_vehicle = level.crazy_ride_convoy[1];
  level endon("stop_updating_player_vehicle_speed");
  for(;;) {
    player_vehicle Vehicle_SetSpeedImmediate(speed, 2, 2);
    wait(0.05);
  }
}

radius_damage_in_front() {
  level endon("stop_updating_player_vehicle_speed");
  flag_wait("push_hurts_technical");
  level.traffic_jam_truck godoff();

  damage = 60;
  for(;;) {
    RadiusDamage(level.traffic_jam_truck.origin, 25, damage, damage, level.player);
    if(level.traffic_jam_truck.health < 18000) {
      level.traffic_jam_truck.health = 18000;
    }

    wait(0.05);
  }
}

lead_vehicle_starts_going_again() {
  wait(0.75);
  self Vehicle_SetSpeed(16, 2, 2);
  self.veh_brake = 0;
}

player_pushes_truck_down_alley() {
  player_vehicle = level.crazy_ride_convoy[1];
  rear_vehicle = level.crazy_ride_convoy[2];
  lead_vehicle = level.crazy_ride_convoy[0];

  for(;;) {
    self waittill("trigger", other);
    if(!isDefined(level.traffic_jam_truck))
      continue;
    if(other == level.traffic_jam_truck) {
      break;
    }
  }

  flag_set("we're cut off");
  queue = GetTime();

  player_vehicle.veh_brake = 1.0;
  player_vehicle Vehicle_SetSpeed(8, 1, 1);

  wait(0.25);
  rear_vehicle.veh_brake = 0.5;
  lead_vehicle delayThread(2, ::set_brakes, 0.5);

  level.traffic_jam_truck.veh_brake = 0.5;

  level.traffic_jam_truck waittill_player_lookat(0.6, 0.5, undefined, 8);
  delayThread(0, ::technical_pushed_animation);
  wait(0.2);

  flag_set("push_through");

  wait(0.5);
  player_vehicle.veh_brake = 0;
  player_vehicle Vehicle_SetSpeed(24, 10, 10);
  rear_vehicle.veh_brake = 0;

  lead_vehicle thread lead_vehicle_starts_driving_again();

  wait(0.65);

  flag_set("resume_the_path");

  tech_target_org = getstruct("tech_target_org", "targetname");

  level.traffic_jam_truck vehicleDriveTo(tech_target_org.origin, 25);
  level.traffic_jam_truck.veh_brake = 0;

  wait(1.1);

  timer = 3;
  frames = timer * 20;

  for(;;) {
    level.traffic_jam_truck Vehicle_SetSpeedImmediate(6, 1, 1);
    frames -= 1;
    if(frames <= 0) {
      break;
    }
    wait(0.05);
  }

  level.traffic_jam_truck Vehicle_SetSpeedImmediate(0, 1, 1);
  level.traffic_jam_truck.veh_brake = 1.0;

  wait_for_buffer_time_to_pass(queue, 5.5);
  level.traffic_jam_truck.vehicle_stays_alive = undefined;
}

lead_vehicle_starts_driving_again() {
  wait(3.5);
  self.veh_brake = 0;
  self Vehicle_SetSpeed(12, 1, 1);
}

dump_vehicle_bones() {
  start_time = GetTime();
  for(;;) {
    tag_origin_pos = self GetTagOrigin("tag_origin");
    tag_origin_ang = self GetTagAngles("tag_origin");

    tag_body_pos = self GetTagOrigin("tag_body");
    tag_body_ang = self GetTagAngles("tag_body");

    time = GetTime() - start_time;
    PrintLn("Time: " + time + " tag_origin: " + tag_origin_pos + " " + tag_origin_ang + " tag_body:" + tag_body_pos + " " + tag_body_ang);
    wait(0.05);
  }
}

delete_on_goal() {
  self endon("death");
  self waittill("goal");
  self Delete();
}

player_learned_javelin() {
  return level.player GetCurrentWeapon() == "javelin";
}

detect_player_switched_to_javelin() {
  for(;;) {
    if(level.player GetCurrentWeapon() == "javelin") {
      break;
    }
    wait(0.05);
  }

  flag_set("player_switched_to_javelin");
}

remind_player_to_switch_to_javelin() {
  lines = [];

  lines[0] = "roadkill_fly_switchtojavelin";

  lines[1] = "roadkill_fly_takeoutarmor";

  index = 0;
  for(;;) {
    timer = 9 + RandomIntRange(2, 5);
    frames = timer * 20;
    for(i = 0; i < frames; i++) {
      if(level.player GetCurrentWeapon() == "javelin")
        return;
      wait(0.05);
    }

    theLine = lines[index];
    index++;
    index %= lines.size;

    while(level.dialogue_function_stack_struct.function_stack.size)
      wait(0.05);

    if(level.player GetCurrentWeapon() == "javelin")
      return;
    foley_line(theLine);
  }
}

foley_should_talk() {
  if(GetTime() <= level.last_missile_fire_time + 19000)
    return false;

  return !level.dialogue_function_stack_struct.function_stack.size;
}

enter_riverbank_foley_shepherd_dialogue() {
  wait(11);

  thread autosave_by_name("riverbank");
  wait(3);

  foley_line("roadkill_fly_wereswimming");
  wait(1);
  flag_set("intro_lines_complete");
}

introlines_delay() {
  wait(6);
}

airstrike_call_in_dialogue() {
  if(!is_default_start()) {
    return;
  }
  wait(0.74);

  shepherd_line("roadkill_cpd_airstrike");

  radio_line("roadkill_auc_ontheline");

  wait(0.9);

  radio_line("roadkill_fp1_devil11");

  radio_line("roadkill_fp1_standingby");

  shepherd_line("roadkill_cpd_levelbuilding");

  radio_line("roadkill_fp1_targetacquired");
}

ambushed_hummer() {
  level.ambushed_hummers[level.ambushed_hummers.size] = self;
  self VehPhys_DisableCrashing();
  self.dontdisconnectpaths = true;
  flag_wait("shepherd_vehicles_leave");
  node = GetVehicleNode(self.target, "targetname");
  dist = Distance(self.origin, node.origin);
  time = dist * 0.005;
  wait(time);
  self gopath();
}

put_noteworthy_in_magic_chatter() {
  level.convoy_dialogue_guy[self.script_noteworthy] = self;
}

get_convoy_dialogue_guy(name) {
  if(IsAlive(level.convoy_dialogue_guy[name]))
    return level.convoy_dialogue_guy[name];

  index = 0;
  ai = GetAIArray("allies");
  guys = [];

  foreach(guy in ai) {
    if(!isalive(guy)) {
      continue;
    }
    if(guy is_hero()) {
      continue;
    }
    if(isDefined(guy.convoy_guy)) {
      continue;
    }
    guy.convoy_guy = true;
    level.convoy_dialogue_guy[name] = guy;
    return guy;
  }
}

magic_dialogue_queue(msg, name) {
  guy = get_convoy_dialogue_guy(name);

  AssertEx(IsAlive(guy), "Couldn't find a guy to do line " + msg);

  guy generic_dialogue_queue(msg);
  wait(0.25);
}

printer() {
  frames = Int(2.5 * 20);
  for(i = 0; i < frames; i++) {
    Print3d(self getEye(), "*");
    wait(0.05);
  }
}

south(dist) {
  return level.player.origin + (0, dist * -1, 0);
}

charpos(guy) {
  org = level.player.origin;
  if(flag("100ton_bomb_goes_off"))
    org = level.locked_player_position;

  unit = 128;
  switch (guy) {
    case "ar1":
      return org + (unit, 0, 0);
    case "ar2":
      return org + (unit, unit, 0);
    case "ar3":
      return org + (unit * -1, 0, 0);
    case "ar4":
      return org + (unit * -1, unit * -0.5, 0);
    case "ar5":
      return org + (unit, unit * -0.5, 0);
    case "farguy":
      return org + (unit * 15, unit * 15, 0);

    case "left":
      return org + (unit * -2, 0, 0);
    case "left_back":
      return org + (unit * -2, -1000, 0);
    case "left_back_more":
      return org + (unit * -2, -3000, 0);

    case "right_forward":
      return org + (unit * 2, 1000, 0);

    case "right_forward_more":
      return org + (unit * 2, 1500, 0);

    case "right_rear_back":
      return org + (unit * 2, -3800, 0);

    case "cpd":
      return org + (unit * 0.5, unit * 0.5, unit * -0.2);
    default:
      return org + (0, 0, 0);
  }
}

airstrike_completion_dialogue_and_exploder() {
  time = 2.5;

  delayThread(time, ::play_sound_in_space, "roadkill_ar1_10seconds", south(5000));
  time += 1.1;

  delayThread(time, ::play_sound_in_space, "roadkill_ar2_10seconds", south(3500));
  time += 0.8;

  delayThread(time, ::play_sound_in_space, "roadkill_ar3_10seconds", south(1200));
  time += 2.9;

  delayThread(time, ::play_sound_in_space, "roadkill_ar1_whichbuilding", charpos("ar1"));
  time += 1.6;

  delayThread(time, ::play_sound_in_space, "roadkill_ar2_tallone", charpos("ar2"));
  time += 1.4;

  delayThread(time, ::play_sound_in_space, "roadkill_ar3_heydawg", charpos("left"));
  time += 1.4;

  delayThread(time, ::play_sound_in_space, "roadkill_ar4_whichone", charpos("left_back"));
  time += 4.6;

  delayThread(time, ::play_sound_in_space, "roadkill_ar5_oneonleft", charpos("left_back_more"));
  time += 1.2;

  delayThread(time, ::spawn_vehicle_from_targetname_and_drive, "bomber_spawner");
  time += 0.7;

  delayThread(time, ::play_sound_in_space, "roadkill_ar3_dangerclose", charpos("ar3"));
  time += 2.1;

  delayThread(time, ::play_sound_in_space, "roadkill_cpd_sincewhen", charpos("cpd"));
  time += 1.8;

  video_taper_offset = 0.75;
  wait(time - video_taper_offset);

  flag_set("video_tapers_react");

  wait(video_taper_offset);

  exploder("100ton_bomb");
  thread roadkill_bomb_physics_explosion();
  thread collapsing_building();
  thread collapse_earthquake();
  thread fence_rattle();

  level.player delayThread(3.6, maps\_gameskill::grenade_dirt_on_screen, "left");
  level.locked_player_position = level.player.origin;
  flag_set("100ton_bomb_goes_off");
  start_time = GetTime();
  wait(0.25);

  delayThread(8.85, ::play_sound_in_space, "roadkill_cpd_looklook", charpos("cpd"));

  time = 1.3;

  delayThread(time, ::play_sound_in_space, "roadkill_ar1_boom", charpos("ar1"));

  delayThread(time, ::play_sound_in_space, "roadkill_ar3_woo", charpos("ar1"));
  delayThread(time, ::play_sound_in_space, "roadkill_ar1_yeah", charpos("ar4"));
  time += 0.2;

  delayThread(time, ::play_sound_in_space, "roadkill_ar2_catcalls", charpos("ar2"));
  time += 1.1;
  delayThread(time, ::play_sound_in_space, "roadkill_ar3_catcalls", charpos("ar3"));
  time += 0.9;
  delayThread(time, ::play_sound_in_space, "roadkill_cpd_getsome", charpos("cpd"));
  time += 0.2;
  delayThread(time, ::play_sound_in_space, "roadkill_ar2_yeah", charpos("ar2"));
  time += 0.8;

  delayThread(time, ::play_sound_in_space, "roadkill_ar5_hotman", charpos("right_rear_back"));
  time += 0.4;

  time += 0.5;

  delayThread(time, ::play_sound_in_space, "roadkill_ar1_4thofjuly", charpos("right_rear_back"));
  time += 2.05;

  delayThread(time, ::play_sound_in_space, "roadkill_ar4_oscarmike", charpos("ar1"));
  time += 1.0;

  delayThread(time, ::flag_set, "convoy_oscar_mike_after_explosion");

  delayThread(time, ::play_sound_in_space, "roadkill_cpd_oscarmike", charpos("cpd"));
  time += 0.9;

  delayThread(time, ::play_sound_in_space, "roadkill_ar3_onthemove", charpos("right_rear_back"));
  time += 1.15;

  delayThread(time, ::play_sound_in_space, "roadkill_ar4_rogerthat", charpos("right_rear_back"));
  time += 2.0;

  delayThread(time, ::play_sound_in_space, "roadkill_cpd_paybig", charpos("left_back"));
  time += 1.8;

  delayThread(time, ::play_sound_in_space, "roadkill_ar2_keepdreamin", charpos("left_back"));
  time += 1.1;

  delayThread(time, ::play_sound_in_space, "roadkill_cpd_extreme", charpos("left_back"));

  wait_for_buffer_time_to_pass(start_time, 7.15);
}

convoy_moves_out_dialogue() {
  if(!is_default_start()) {
    return;
  }

  foley_line("roadkill_fly_bridgecomplete");

  dunn_line("roadkill_cpd_movinout");

  time = 0.05;
  delayThread(time, ::magic_dialogue_queue, "roadkill_ar3_backinvehicle", "ar3");
  time += 1.3;

  delayThread(time, ::magic_dialogue_queue, "roadkill_ar4_oscarmike", "ar4");
  time += 1.2;

  wait(time);

  delayThread(time, ::magic_dialogue_queue, "roadkill_fly_oscarmike", "fly");
  time += 0.6;

  delayThread(time, ::magic_dialogue_queue, "roadkill_ar2_oscarmike", "ar2");
  time += 0.6;

  delayThread(time, ::magic_dialogue_queue, "roadkill_cpd_notstoppin", "cpd");
  time += 3.2;

  wait(time);

  if(flag("player_gets_in"))
    return;
  level endon("player_gets_in");

  thread magic_dialogue_queue("roadkill_fly_movingout", "fly");
  wait(1.2);

  thread magic_dialogue_queue("roadkill_fly_mountup", "fly");
  wait(0.5);

  thread magic_dialogue_queue("roadkill_ar2_oscarmike", "ar2");
}

random_ai_line(msg) {
  ai = GetAIArray("allies");
  ai = get_array_of_closest(level.player.origin, ai, undefined, 5);
  guy = random(ai);
  if(!isalive(guy))
    return;
  guy generic_dialogue_queue(msg);
}

warn_if_player_shoots_prematurely() {
  if(flag("ambush_spawn")) {
    return;
  }
  level endon("ambush_spawn");

  lines = [];

  lines[lines.size] = "roadkill_fly_nothingthere";

  lines[lines.size] = "roadkill_fly_ceasefire";

  index = 0;

  for(;;) {
    if(player_shoots_at_non_enemy()) {
      wait(1.5);
    }

    if(player_shoots_at_non_enemy()) {
      theLine = lines[index];
      index++;
      index %= lines.size;
      foley_line(theLine);
      wait(1);
    }
    wait(0.05);
  }
}

player_shoots_at_non_enemy() {
  if(!level.player attackButtonPressed())
    return false;

  ai = GetAIArray("axis");
  angles = level.player GetPlayerAngles();
  dotforward = anglesToForward(angles);
  start = level.player getEye();

  foreach(guy in ai) {
    angles = VectorToAngles(guy.origin - start);
    forward = anglesToForward(angles);

    dot = VectorDot(dotforward, forward);
    if(dot > 0.86)
      return false;
  }

  return true;
}

fail_player_for_excessive_firing() {
  if(flag("ambush_spawn")) {
    return;
  }
  level endon("ambush_spawn");

  count = 0;
  time = 5;
  sustained_firing_frames = time * 20;
  for(;;) {
    if(level.player attackButtonPressed()) {
      count += 1;
    } else {
      count -= 0.25;
    }
    if(count <= 0)
      count = 0;

    if(count > sustained_firing_frames) {
      break;
    }

    wait(0.05);
  }

  setDvar("ui_deadquote", &"ROADKILL_SHOT_TOO_MUCH");
  missionFailedWrapper();
}

stryker_think() {
  self.veh_pathtype = "constrained";
  flag_wait("player_gets_in");
  self.veh_pathtype = "follow";
}

fence_rattle() {
  pivot = GetEnt("animated_bridge_fence_pivot", "targetname");

  wait(3.25);
  animated_bridge_fences = getEntArray("animated_bridge_fence", "targetname");

  foreach(piece in animated_bridge_fences) {
    piece NotSolid();
    piece SetContents(0);
    piece LinkTo(pivot);
  }

  start_angles = pivot.angles;

  amount = -25;
  for(;;) {
    time = abs(amount) * 0.0475;
    if(time < 0.75)
      time = 0.75;
    pivot RotateTo((0, 90, amount), time, time * 0.5, time * 0.5);
    amount *= -0.65;
    wait(time);
    if(abs(amount) <= 2) {
      break;
    }
  }
  pivot RotateTo(start_angles, 0.2);
  wait(0.5);
  pivot Delete();
}

collapse_earthquake() {
  wait(1.1);
  level.player PlayRumbleOnEntity("collapsing_building");
  Earthquake(0.3, 2, (-2556.2, -702.2, 1446), 15000);
  wait(2.4);
  Earthquake(0.15, 0.6, (-2556.2, -702.2, 1446), 15000);
}

collapsing_building() {
  building = GetEnt("collapsing_building", "targetname");
  wait(7.5);
  time = 10;

  ent = spawn("script_origin", building.origin);
  ent.angles = building.angles;
  ent AddPitch(-30);
  ent AddYaw(60);
  ent.origin += (0, 0, -2000);

  building MoveTo(ent.origin, time, 6, 0);
  building RotateTo(ent.angles, time, 6, 0);

  building thread play_sound_on_entity("scn_roadkill_building_collapse");
  exploder("building_collapse");
}

roadkill_bomb_physics_explosion() {
  wait(1.3);
  start = GetEnt("physics_explosion_line", "targetname");
  end = getstruct(start.target, "targetname");

  dest = getstruct(end.target, "targetname");

  radius = start.radius;

  dist = Distance(start.origin, end.origin);
  segments = dist / radius;

  time = 3;
  start MoveTo(dest.origin, time, 2, 0);
  end_time = GetTime() + time * 1000;

  segment_vec = end.origin - start.origin;
  segment_vec /= segments;

  force_vec = (-45, -55, 72);
  angles = VectorToAngles(force_vec);
  forward = anglesToForward(angles);
  force_vec = forward * 0.14;

  count = 0;
  for(;;) {
    if(GetTime() > end_time) {
      break;
    }

    org = start.origin;
    for(i = 0; i < segments; i++) {
      count++;
      if(count <= 3) {
        PhysicsExplosionCylinder(org, radius, radius, 0.3);
      } else {
        PhysicsJolt(org, radius, radius, force_vec);

        count = 0;
      }
      org += segment_vec;
    }

    wait(0.05);
  }
}

street_walk_scene() {
  array_spawn_function_targetname("street_walk_scene", ::street_walk_guy);

  flag_wait("convoy_oscar_mike_after_explosion");
  wait(12.5 - 4);
  array_spawn_targetname("street_walk_scene");
}

street_walk_guy() {
  self endon("death");
  self.ignoreall = true;
  self.ignoreme = true;
  self SetGoalPos(self.origin);
  self.moveplaybackrate = 1;
  self.pathrandompercent = 0;
  struct = getstruct(self.script_linkto, "script_linkname");

  delays = [];
  delays["street_walk_scene1"] = 1.7;
  delays["street_walk_scene2"] = 0.9;
  delays["street_walk_scene3"] = 0;

  delay = delays[struct.targetname];
  delay *= 1.3;
  wait(delay);

  self enable_cqbwalk();

  struct anim_generic_reach(self, "combat_walk");

  struct thread anim_generic_gravity(self, "combat_walk");
  animation = self getGenericAnim("combat_walk");
  for(;;) {
    if(self GetAnimTime(animation) >= 0.96) {
      break;
    }
    wait(0.05);
  }
  self notify("killanimscript");

  node = GetNode(self.target, "targetname");
  self SetGoalNode(node);
  self.fixednode = false;

  self.goalradius = 8;
  self waittill("goal");
  self safe_delete();
}

ps3_hide() {
  if(!level.console)
    return;
  if(!level.ps3) {
    return;
  }
  ents = getEntArray("ps3_hide", "script_noteworthy");
  foreach(ent in ents) {
    ent hide();
  }

  flag_wait("roadkill_town_dialogue");
  foreach(ent in ents) {
    ent show();
  }
}

broken_wall() {
  models = getEntArray(self.target, "targetname");
  foreach(model in models) {
    model LinkTo(self);
  }

  pivot = GetEnt(self.script_linkto, "script_linkname");
  self add_target_pivot(pivot);

  start_ent = GetEnt("broken_wall_start_org", "targetname");

  end_origin = pivot.origin;
  end_angles = pivot.angles;
  pivot.origin = start_ent.origin;
  pivot.angles = start_ent.angles;

  flag_wait("roadkill_town_dialogue");

  flag_wait("building_face_falloff");
  pivot thread play_sound_on_entity("scn_roadkill_building_crumble");

  moveTime = 4;
  pivot RotateTo(end_angles, moveTime, 3, 1);
  pivot MoveTo(end_origin, moveTime, 3, 1);

  exploder("building_crumble");
}

roadkill_riverbank_objective() {
  thread detect_player_switched_to_javelin();

  waittillframeend;

  Objective_Add(obj("bridge_layer"), "current", &"ROADKILL_OBJECTIVE_BRIDGELAYER", (0, 0, 0));
  Objective_Current(obj("bridge_layer"));
  Objective_OnEntity(obj("bridge_layer"), level.foley);
  Objective_SetPointerTextOverride(obj("bridge_layer"), &"SCRIPT_WAYPOINT_TARGETS");

  Objective_Position(obj("bridge_layer"), (0, 0, 0));

  flag_wait("bridge_layer_attacked_by_bridge_baddies");
  wait 4.5;
  Objective_Position(obj("bridge_layer"), (-2519, -2457, 288));
  setsaveddvar("compass", 1);

  flag_wait("bridge_baddies_retreat");
  setsaveddvar("compass", 0);

  flag_wait("bridgelayer_crosses");
  objective_complete(obj("bridge_layer"));

  wait(1.5);

  origin = (-2488, -3755, 182);

  Objective_Add(obj("convoy"), "current", &"ROADKILL_OBJECTIVE_HUMVEE", origin);
  Objective_Current(obj("convoy"));

  for(;;) {
    if(isDefined(level.chair)) {
      break;
    }
    wait(0.05);
  }

  Objective_OnEntity(obj("convoy"), level.chair);
  flag_wait("player_gets_in");
  objective_position(obj("convoy"), (0, 0, 0));

  Objective_String(obj("convoy"), &"ROADKILL_OBJECTIVE_AIRSTRIKE");
  flag_wait("convoy_oscar_mike_after_explosion");
  objective_complete(obj("convoy"));
}

roadkill_ride_objective() {
  Objective_Add(obj("ride"), "current", &"ROADKILL_OBJECTIVE_SCAN", (0, 0, 0));
  Objective_Current(obj("ride"));

  flag_wait("shot_rings_out");
  wait(4.5);

  Objective_Add(obj("ride"), "current", &"ROADKILL_OBJECTIVE_TARGETS", (0, 0, 0));
  Objective_Current(obj("ride"));

  flag_wait("player_knocked_down");
}

roadkill_dismount_objective() {
  if(!is_default_start()) {
    Objective_Add(obj("ride"), "current", &"ROADKILL_OBJECTIVE_TARGETS", (0, 0, 0));
  }

  wait(0.5);

  for(;;) {
    if(IsAlive(level.foley)) {
      break;
    }
    wait(0.05);
  }

  Objective_OnEntity(obj("ride"), level.foley);

  flag_wait("sweep_dismount_building");

  node = GetNode("dismount_obj_node", "targetname");

  Objective_String(obj("ride"), &"ROADKILL_OBJECTIVE_DISMOUNT");
  Objective_Position(obj("ride"), node.origin);

  flag_wait("friendlies_suppress_school");
  objective_complete(obj("ride"));
}

roadkill_school_objective() {
  trigger = getEntWithFlag("roadkill_school_14");

  Objective_Add(obj("school"), "current", &"ROADKILL_OBJECTIVE_SCHOOL", trigger.origin);

  for(;;) {
    if(IsAlive(level.foley)) {
      break;
    }
    wait(0.05);
  }

  AssertEx(IsAlive(level.foley), "No foley no gamey");
  Objective_OnEntity(obj("school"), level.foley);

  flag_wait("roadkill_school_14");
}

roadkill_exfil_objective() {
  objective_complete(obj("school"));

  flag_wait("final_objective");

  struct = getstruct("roadkill_shepherd_ending_scene", "targetname");

  Objective_Add(obj("exfil"), "current", &"ROADKILL_OBJECTIVE_REPORT", struct.origin);
  Objective_Current(obj("exfil"));
}

roadkill_mortars() {
  level endon("time_to_go");
  mortar = self;

  mortars = [];
  mortars[mortars.size] = mortar;
  for(;;) {
    if(!isDefined(mortar.target)) {
      break;
    }
    mortar = getstruct(mortar.target, "targetname");
    mortars[mortars.size] = mortar;
  }

  waits = [];
  waits[0] = 0.3;
  waits[1] = 1.1;
  waits[2] = 0.5;
  waits[3] = 0.0;
  waits[4] = 1.3;
  waits[5] = 2.3;
  waits[6] = 1.6;
  waits[7] = 0.0;
  wait(2.85 - 2.5);

  foreach(mortar in mortars) {
    mortar.water = isDefined(mortar.script_noteworthy) && mortar.script_noteworthy == "water";
  }

  mortar_fx = getfx("mortar_large");
  water_fx = getfx("mortar_water");

  level.building_mortars = get_exploder_array("building_mortar");

  for(i = 0;; i++) {
    i %= mortars.size;

    mortar = mortars[i];

    if(mortar.water) {
      mortar.fx = water_fx;
      mortar.sound = "mortar_explosion_water";
    } else {
      mortar.fx = mortar_fx;
      mortar.sound = "mortar_explosion_dirt";
    }

    thread roadkill_mortar_goes_off(mortar);

    mod = i % waits.size;
    wait(waits[mod]);

    waits[mod] += 0.75;
  }
}

roadkill_mortar_goes_off(mortar) {
  building_mortar = random(level.building_mortars);
  building_mortar activate_individual_exploder();
  wait(2);
  thread play_sound_in_space("artillery_incoming", mortar.origin);
  wait(0.5);

  playFX(mortar.fx, mortar.origin);

  RadiusDamage(mortar.origin, 200, 300, 50);
  thread play_sound_in_space(mortar.sound, mortar.origin);
}

detect_if_player_tries_to_cross_bridge() {
  level endon("player_gets_in");
  flag_wait("player_tries_to_cross_bridge");
  thread player_dies_to_attackers();
}

player_dies_to_attackers() {
  wait(2);
  level.player endon("death");
  level.player delayCall(3, ::EnableHealthShield, false);
  eyepos = level.player getEye();
  org = undefined;

  setDvar("ui_deadquote", &"ROADKILL_GOT_SNIPED");

  foreach(org in level.player_killer_orgs) {
    if(BulletTracePassed(eyepos, org, true, undefined)) {
      break;
    }
  }

  assertex(isDefined(org), "Impossible!");

  for(;;) {
    thread play_sound_in_space("weap_dragunovsniper_fire_npc", org);

    level.player DoDamage(45 / level.player.damagemultiplier, org);
    timer = RandomFloatRange(0.4, 0.7);
    wait(timer);
  }
}

setup_player_killer_orgs() {
  level.player_killer_orgs = [];
  orgs = getEntArray("attack_point", "script_noteworthy");
  foreach(org in orgs) {
    level.player_killer_orgs[level.player_killer_orgs.size] = org.origin;
  }
}

bmp_becomes_javelin_targettable() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "delayed_targeting") {
    if(level.start_point != "move_out")
      wait(10);
  }
  wait(1);
  OFFSET = (0, 0, 60);
  Target_Set(self, OFFSET);
  Target_SetAttackMode(self, "top");
  Target_SetJavelinOnly(self, true);
  self thread set_javelin_targettable_var();

  self.health = 20000;
  self godon();
  self riverbank_bmp_is_shot_at();
  if(isDefined(self)) {
    Target_Remove(self);
  }
}

set_javelin_targettable_var() {
  self endon("death");
  wait(1.5);

  self.javelin_targettable = true;
}

bmp_gets_killed() {
  level.riverside_bmp = self;
}

riverbank_bmp() {
  bmp_destroyed = GetEnt("bmp_destroyed", "targetname");
  bmp_destroyed thread bmp_destroyed();

  array_spawn_function_targetname("riverbank_bmp", ::bmp_gets_killed);
  bmp = spawn_vehicle_from_targetname("riverbank_bmp");

  bmp waittill("death");

  exploder("bmp_explosion");
  wait(0.5);
  bmp_destroyed notify("destroyed");
  bmp Delete();
  exploder("bmp");
}

riverbank_bmp_is_shot_at() {
  self endon("death");
  for(;;) {
    if(!isalive(self)) {
      break;
    }

    oldHealth = self.health;
    self waittill("damage", dmg, attacker, one, two, weapType);
    if(isDefined(attacker.classname) && !isPlayer(attacker)) {
      self.health = oldHealth;
      continue;
    }

    if(weapType != "MOD_PROJECTILE") {
      continue;
    }
    if(dmg < 800) {
      continue;
    }

    self godoff();
    RadiusDamage(self.origin, 150, self.health + 500, self.health + 500);
  }
}

bmp_destroyed() {
  self Hide();
  targ = GetEnt(self.target, "targetname");
  angles = targ.angles;
  origin = targ.origin;
  targ Delete();

  self waittill("destroyed");
  self Show();
  wait(5);
  movetime = 8;
  self MoveTo(origin, movetime, 0, 2);
  self RotateTo(angles, movetime, 0, 2);
}

intro_orders() {
  spawners = getEntArray(self.target, "targetname");
  guys = array_spawn(spawners);

  guys[0].animname = "hargrove";
  guys[1].animname = "foley";

  self thread anim_single(guys, "roadkill_intro_orders");
  wait(0.05);
  guy = undefined;
  foreach(guy in guys) {
    animation = guy getanim("roadkill_intro_orders");
    guy SetAnim(animation, 1, 0, 0);
    guy SetAnimTime(animation, 0.25);
  }
  flag_wait("player_climbs_stairs");
  foreach(guy in guys) {
    animation = guy getanim("roadkill_intro_orders");
    guy SetAnim(animation, 1, 0, 1);
  }

  for(;;) {
    animation = guy getanim("roadkill_intro_orders");
    if(guy GetAnimTime(animation) >= 0.78) {
      break;
    }
    wait(0.05);
  }

  foreach(guy in guys) {
    guy anim_stopanimscripted();
  }
}

ai_invulnerable() {
  if(isDefined(self.script_drone)) {
    return;
  }
  if(isDefined(self.script_godmode)) {
    return;
  }
  if(!isDefined(self.magic_bullet_shield))
    self magic_bullet_shield();

  self.attackeraccuracy = 0;
  self.IgnoreRandomBulletDamage = true;
}

extra_bmp_blows_up() {
  flag_wait("100ton_bomb_goes_off");
  wait(1);
  RadiusDamage(self.origin, 128, 5000, 5000);
}

player_fights_bmps() {
  bridge_targets = getEntArray("bridge_target", "targetname");
  orgs = get_orgs_from_ents(bridge_targets, true);

  flag_wait("leaving_riverbank");

  flag_wait("bridgelayer_crosses");

  foreach(guy in level.stair_block_guys) {
    guy thread run_to_convoy();
  }

  player_stair_blocker = GetEnt("player_stair_blocker", "targetname");
  player_stair_blocker Delete();
  flag_clear("player_climbs_stairs");
}

bmp_targets_bridge(orgs) {
  self endon("death");
  self waittill("reached_end_node");

  self endon("death");

  ent = spawn("script_origin", (0, 0, 0));
  ent.origin = orgs[0].origin;
  self SetTurretTargetEnt(ent);
  self.target_ent = ent;

  self tank_fires_often(orgs);
}

idle_commander() {
  self magic_bullet_shield();
}

dismount_foley() {
  level.foley = self;
  self make_hero();
}

dismount_dunn() {
  level.dunn = self;
  self make_hero();
}

foley_line(msg) {
  level.dialogue_function_stack_struct function_stack(::foley_line_proc, msg);
}

foley_line_proc(msg) {
  if(!flag("player_gets_in")) {
    level.foley generic_dialogue_queue(msg);
    return;
  }

  if(!flag("player_enters_ambush_house")) {
    if(isDefined(level.crazy_ride_convoy["lead"]) && !flag("player_is_dismounted")) {
      level.crazy_ride_convoy["lead"] generic_dialogue_queue(msg);
    } else {
      if(IsAlive(level.foley)) {
        level.foley generic_dialogue_queue(msg);
      } else {
        level.player generic_dialogue_queue(msg);
      }
    }
    return;
  }

  level.foley generic_dialogue_queue(msg);
}

driver_line(msg) {
  level.dialogue_function_stack_struct function_stack(::driver_line_proc, msg);
}

driver_line_proc(alias) {
  play_line_at_offset_on_player_vehicle(alias, (-100, 100, -80));
}

passenger_line(msg) {
  level.dialogue_function_stack_struct function_stack(::passenger_line_proc, msg);
}

passenger_line_proc(alias) {
  play_line_at_offset_on_player_vehicle(alias, (-100, 0, -80));
}

play_line_at_offset_on_player_vehicle(alias, offset) {
  player_vehicle_angles = level.crazy_ride_convoy["player"].angles;
  angles = (0, player_vehicle_angles[1], 0);

  ent = spawn("script_origin", (0, 0, 0));
  ent LinkTo(level.crazy_ride_convoy["player"], "tag_body", offset, (0, 0, 0));

  ent play_sound_on_entity(alias);
  ent Delete();
}

dunn_line(msg) {
  level.dialogue_function_stack_struct function_stack(::dunn_line_proc, msg);
}

dunn_line_proc(msg) {
  if(!flag("player_gets_in")) {
    if(isalive(level.dunn)) {
      level.dunn generic_dialogue_queue(msg);
    } else {
      magic_dialogue_queue(msg, "ar3");
    }

    return;
  }

  if(!flag("player_enters_ambush_house")) {
    if(isDefined(level.crazy_ride_convoy["player"]) && !flag("player_is_dismounted")) {
      level.crazy_ride_convoy["player"] generic_dialogue_queue(msg);
    } else {
      if(IsAlive(level.dunn)) {
        level.dunn generic_dialogue_queue(msg);
      } else {
        level.player generic_dialogue_queue(msg);
      }
    }
    return;
  }

  level.dunn generic_dialogue_queue(msg);
}

shepherd_line(msg) {
  level.dialogue_function_stack_struct function_stack(::shepherd_line_proc, msg);
}

shepherd_line_proc(msg) {
  if(IsAlive(level.shepherd)) {
    level.shepherd generic_dialogue_queue(msg);
  } else {
    if(!isDefined(level.scr_radio[msg]))
      level.scr_radio[msg] = level.scr_sound["generic"][msg];
    radio_dialogue(msg);
  }
}

player_is_safe() {
  for(;;) {
    axis = GetAIArray("axis");
    guy = getClosest(level.player.origin, axis, 600);
    if(!isalive(guy)) {
      break;
    }
    wait(0.2);
  }
  wait(0.75);
}

respawn_dead_school_window_guys() {
  used_exports = [];
  ai = GetAIArray("axis");
  foreach(guy in ai) {
    used_exports[guy.export] = true;
  }

  foreach(spawner in level.school_ambush_spawners) {
    if(!isDefined(used_exports[spawner.export])) {
      spawner.count = 1;
      spawner spawn_ai();
    }
  }
}

radio_line(msg) {
  level.dialogue_function_stack_struct function_stack(::radio_dialogue, msg);
}

pistol_killer_spawner() {
  level.pistol_killer = self;
  self endon("death");
  self magic_bullet_shield();
  node = GetNode(self.target, "targetname");
  node thread anim_generic(self, "exposed_reload");
  wait(0.05);
  animation = getGenericAnim("exposed_reload");
  self SetAnim(animation, 1, 0, 0);
  self SetAnimTime(animation, 0.3);
  flag_wait("player_rounds_end_corner");
  self SetAnim(animation, 1, 0, 1);
  self.a.pose = "crouch";

  for(;;) {
    if(self GetAnimTime(animation) > 0.90) {
      break;
    }
    wait(0.05);
  }
  self.a.pose = "stand";
  self notify("killanimscript");

  node = GetNode("outside_node", "targetname");
  self SetGoalNode(node);
  self disable_cqbwalk();
}

roadkill_pistol_guy() {
  self.flashBangImmunity = true;
  self.ignoreall = true;
  self.ignoreme = true;
  self endon("death");

  self disable_pain();
  self.health = 10000;

  self forceUseWeapon("glock", "primary");
  self add_damage_function(::bloody_pain_reverse);
  thread shoot_randomly();

  struct = getstruct("backwards_struct", "targetname");
  struct thread anim_generic_custom_animmode(self, "gravity", "pistol_walk_back");
  self set_generic_deathanim("pistol_death");
  waittill_notify_or_timeout("damage", 1.5);

  thread fire_bullets_at_guy();
  wait(0.15);
  self thread anim_generic_custom_animmode(self, "gravity", "pistol_death");
  animation = self getGenericAnim("pistol_death");
  time = GetAnimLength(animation);
  self delayThread(0.5, animscripts\shared::DropAIWeapon);

  wait(0.9);
  self.a.nodeath = true;
  self Kill();
}

shoot_randomly() {
  self endon("death");
  self.baseaccuracy = 0;
  wait(0.4);
  self Shoot();
  wait(0.8);
  self Shoot();
  wait(0.2);
  self Shoot();
  wait(0.45);
  self Shoot();
  wait(2);
  self Shoot();
}

bloody_pain_reverse(damage, attacker, direction_vec, point, type, modelName, tagName) {
  angles = direction_vec + (0, 180, 0);
  forward = anglesToForward(angles);
  up = AnglesToUp(angles);

  fx = getfx("headshot");
  playFX(fx, point, forward, up);
}

fire_bullets_at_guy() {
  struct = getstruct("pistol_bullet_spawner", "targetname");
  targ = getstruct(struct.target, "targetname");

  vector = struct.origin - targ.origin;

  waits = [];
  waits[0] = 0.1;
  waits[1] = 0.1;
  waits[2] = 0.1;
  waits[3] = 0.2;
  waits[4] = 0.1;
  waits[5] = 0.1;
  waits[6] = 0.1;
  waits[7] = 0.25;

  count = 12;
  for(i = 0; i < count; i++) {
    dest_org = targ.origin + randomvector(40);
    MagicBullet("m4m203_eotech", struct.origin, dest_org, level.player);
    if(isDefined(waits[i])) {
      wait(waits[i]);
    } else {
      wait(0.1);
    }
  }
}

player_shoot_detection_trigger() {
  wait_for_player_to_force_flee();

  flag_set("retreaters_run");
  level.player.threatbias = 5000;
  wait(2);
  level.player.threatbias = 150;
}

wait_for_player_to_force_flee() {
  if(flag("roadkill_school_9"))
    return;
  level endon("roadkill_school_9");

  add_wait(::flag_wait, "player_forces_enemy_to_flee");
  add_wait(::player_shoots_at_enemies_in_school);
  do_wait();
}

player_shoots_at_enemies_in_school() {
  for(;;) {
    self waittill("trigger", other);
    if(!isalive(other))
      continue;
    if(other == level.player) {
      break;
    }
  }
}

retreat_spawner() {
  self endon("death");
  self.neverEnableCQB = true;
  flag_wait("retreaters_run");

  self SetLookAtEntity(level.player);
  time = RandomFloatRange(0.3, 0.9);
  wait(time);

  self delayCall(3, ::SetLookAtEntity);

  school_flee_struct = getstruct("school_flee_struct", "targetname");

  self maps\_spawner::go_to_node(school_flee_struct, "struct");
}

school_spawner_think() {
  self disable_cqbwalk();
  self.neverEnableCQB = true;

  if(!flag("detour_convoy_slows_down")) {
    self endon("death");
    self.ignoreall = true;
    self.ignoreme = true;
    flag_wait("detour_convoy_slows_down");
    self.ignoreall = false;
    self.ignoreme = false;
    return;
  }

  self.attackeraccuracy = 0.2;
  level.school_baddies[level.school_baddies.size] = self;

  self waittill("death");
  level notify("school_spawner_death");
}

school_spawner_flee_node() {
  level waittill("school_spawner_death");
  guys = level.school_baddies;
  guys = array_removeDead(guys);

  node = GetNode("class_flee_node", "targetname");
  guy = getClosest(node.origin, guys);
  if(IsAlive(guy)) {
    guy.combatMode = "cover";
    guy endon("death");
    guy SetGoalNode(node);
    guy.goalradius = 64;
    guy waittill("goal");
    guy.goalradius = 2000;
  }
}

fleeing_baddie_spawner() {
  self endon("death");
  self.attackeraccuracy = 0;
  self.IgnoreRandomBulletDamage = true;
  old_dist = self.pathenemyfightdist;
  old_look = self.pathenemylookahead;
  self.pathenemyfightdist = 0;
  self.pathenemylookahead = 0;
  self.maxfaceenemydist = 32;
  self enable_sprint();
  self waittill("goal");
  wait(1.5);
  self.attackeraccuracy = 1;
  self.IgnoreRandomBulletDamage = false;
  self.pathenemyfightdist = old_dist;
  self.pathenemylookahead = old_look;
}

stop_sprinting_trigger() {
  for(;;) {
    self waittill("trigger", other);
    if(!isalive(other))
      continue;
    if(first_touch(other)) {
      other delayThread(1.4, ::disable_heat_behavior);
    }
  }
}

damage_targ_trigger_think() {
  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName);
    if(!isalive(attacker)) {
      continue;
    }

    if(Distance(attacker.origin, self.origin) > 940) {
      continue;
    }
    targ = getstruct(self.target, "targetname");
    RadiusDamage(targ.origin, 30, 5000, 5000);
  }

  self Delete();
}

extra_retreat_spawner() {
  self.neverEnableCQB = true;

  level.forced_bcs_callouts++;
  if(level.forced_bcs_callouts == 1) {
    self play_sound_on_entity("AB_2_order_action_suppress");
  } else
  if(level.forced_bcs_callouts == 2) {
    wait(0.15);
    self play_sound_on_entity("AB_3_order_action_coverme");
  }
}

wave_right_trigger() {
  for(;;) {
    self waittill("trigger", other);
    if(!isalive(other))
      continue;
    if(other == level.foley) {
      break;
    }
  }

  thread foley_line("roadkill_fly_sawone");

  if(flag("roadkill_near_crossroads")) {
    add_wait(::flag, "school_back_baddies_dead");
    add_wait(::flag, "roadkill_school_12");
    do_wait_any();
    if(flag("roadkill_school_12")) {
      flag_set("roadkill_school_11");
      return;
    }
  }

  targ = getstruct(self.target, "targetname");
  targ anim_generic_reach(other, "cqb_wave");
  if(IsAlive(other))
    targ thread anim_generic(other, "cqb_wave");
  wait(0.9);
  other enable_ai_color();
  flag_set("roadkill_school_11");
}

staircase_grenade() {
  flag_wait("staircase_grenade");

  trigger = getEntWithFlag("staircase_grenade");
  start = getstruct(trigger.target, "targetname");
  end = getstruct(start.target, "targetname");

  vector = end.origin - start.origin;
  angles = VectorToAngles(vector);
  forward = anglesToForward(angles);
  velocity = forward * 450;
  MagicGrenadeManual("fraggrenade", start.origin, velocity, 5);
}

detach_my_scr_model() {
  self Detach(level.scr_model[self.animname], "tag_inhand");
}

stair_block_guy() {
  level.stair_block_guys[level.stair_block_guys.size] = self;

  self add_riverbank_flags();

  self endon("death");
  struct = getstruct(self.script_linkto, "script_linkname");
  self.animname = struct.targetname;
  self gun_remove();
  self.doing_looping_anim = true;

  if(isDefined(level.scr_model[self.animname])) {
    self Attach(level.scr_model[self.animname], "tag_inhand");
    self.convoy_func = ::detach_my_scr_model;
  }

  struct thread anim_loop_solo(self, "sit_around");
  flag_wait("time_to_go");
  self gun_recall();
  struct notify("stop_loop");
}

rooftop_drone() {
  struct = getstruct(self.script_linkto, "script_linkname");
  self.animname = "generic";
  offset = (0, 0, 100);
  struct.origin -= offset;
  ent = spawn_tag_origin();
  ent.origin = struct.origin;
  ent.angles = struct.angles;
  self LinkTo(ent, "tag_origin", (0, 0, 0), (0, 0, 0));
  ent MoveTo(ent.origin + offset, 1, 0.5, 0.5);
  struct anim_generic(self, "rooftop_turn");
  ent Delete();
  self Delete();
}

wobbly_fans() {
  fans = getEntArray("destructible_toy", "targetname");
  foreach(fan in fans) {
    if(fan.destructible_type == "toy_ceiling_fan")
      fan thread fan_wobbles();
  }
}

fan_wobbles() {
  self endon("death");

  action_v = level.destructible_type[self.destuctableInfo].parts[0][0].v;
  animation = action_v["animation"][0]["anim"];

  for(;;) {
    rate = RandomFloatRange(0.01, 0.04);
    self SetAnim(animation, 1, 0, rate);
    timer = RandomFloatRange(1.0, 2.5);
    wait(timer);

    rate = RandomFloatRange(0.01, 0.15);
    self SetAnim(animation, 1, 0, rate);
    timer = RandomFloatRange(1.0, 3);
    wait(timer);

    rate = RandomFloatRange(0.05, 0.2);
    self SetAnim(animation, 1, 0, rate);
    timer = RandomFloatRange(1.0, 3);
    wait(timer);
  }
}

friendlies_get_on_exit_convoy_trigger() {
  for(;;) {
    self waittill("trigger", other);
    if(!isalive(other))
      continue;
    if(!first_touch(other)) {
      continue;
    }
    if(!isDefined(other.running_loader)) {
      continue;
    }
    other thread friendly_gets_on_vehicle();
  }
}

friendly_gets_on_vehicle() {
  self endon("death");

  vehicle = undefined;
  level.ending_vehicles = array_randomize(level.ending_vehicles);
  foreach(ending_vehicle in level.ending_vehicles) {
    used_positions = 0;
    foreach(pos in ending_vehicle.usedpositions) {
      if(!pos)
        used_positions++;
    }

    if(used_positions) {
      vehicle = ending_vehicle;
      break;
    }
  }

  if(!isDefined(vehicle)) {
    return;
  }
  thread guy_runtovehicle_load(self, vehicle);
}

friendly_ending_runner_spawner() {
  self.running_loader = true;
  self.fixednode = false;
  node = GetNode("friendly_exit_node", "targetname");
  self SetGoalNode(node);
  self.goalradius = 64;
}

shepherd_ending_spawner() {
  level.shepherd = self;

  thread player_loses_gun_at_close_range();
  self.animname = "shepherd";
  self.disablearrivals = true;
  self.disableexits = true;
  self gun_remove();

  thread shepherd_line("roadkill_shp_shocktrauma");

  struct = getstruct("roadkill_shepherd_ending_scene", "targetname");
  struct anim_first_frame_solo(self, "ending");

  Objective_OnEntity(obj("exfil"), self);
  flag_wait("start_shepherd_end");

  thread roadkill_ending_dialogue();

  node = GetNode("shepherd_lookout_node", "targetname");
  self SetGoalNode(node);
  self.goalradius = 8;
  self set_generic_run_anim("walk");

  scene = "ending";
  animation = self getanim(scene);
  time = getanimlength(animation);
  self delaythread(time * 0.332, maps\roadkill_anim::point_start, self);

  struct anim_custom_animmode_solo(self, "gravity", scene);
}

player_loses_gun_at_close_range() {
  self endon("death");
  level.player endon("death");
  for(;;) {
    if(distance(level.player.origin, self.origin) < 200) {
      break;
    }
    wait(0.05);
  }

  for(;;) {
    eyepos = self getEye();
    if(level.player WorldPointInReticle_Circle(eyepos, 65, 75)) {
      break;
    }
    wait(0.05);
  }

  level.player DisableWeapons();
}

roadkill_ending_dialogue() {
  wait(9.8);

  thread random_ai_line("roadkill_ar4_oscarmike");
  wait(0.4);

  wait(0.3);
}

ending_hangout_spawner() {
  self set_generic_run_anim("walk");
}

ride_adjust_convoy_speed_trigger() {}

ignore_and_delete() {
  self endon("death");
  self.ignoreme = true;
  self.ignoreall = true;
  self waittill("goal");
  wait(0.5);
  self waittill("goal");
  self Delete();
}

wait_for_empty_queue() {
  if(!isDefined(self.function_stack)) {
    return;
  }
  while(self.function_stack.size > 0) {
    wait(0.05);
  }
}

dunn_credits_player_with_kill(max_time) {
  level endon("dunn_no_commento");
  wait(max_time + 0.1);
  level.dialogue_function_stack_struct wait_for_empty_queue();

  if(!flag("jumper_died")) {
    return;
  }

  dunn_line("roadkill_cpd_handledit");
}

look_forward_nag() {
  if(flag("ride_looking_forward")) {
    return;
  }
  level endon("ride_looking_forward");

  wait(3);

  foley_line("roadkill_fly_eyesforward");
}

gunner_becomes_invul() {
  turret = self.mgturret[0];
  for(;;) {
    gunner = turret GetTurretOwner();
    if(IsAlive(gunner)) {
      if(!isDefined(gunner.magic_bullet_shield))
        gunner magic_bullet_shield();
      return;
    }
    wait(0.05);
  }
}

get_gunner_from_vehicle() {
  foreach(guy in self.riders) {
    if(!isalive(guy))
      continue;
    if(!issentient(guy))
      continue;
    if(isDefined(guy GetTurret()))
      return guy;
  }
}

structorama() {
  for(;;) {
    struct = getstruct("mortar_school_chain", "targetname");
    struct delayThread(1, ::struct_mortar);
    struct = getstruct(struct.target, "targetname");
    struct delayThread(1.3, ::struct_mortar);
    struct = getstruct(struct.target, "targetname");
    struct delayThread(1.6, ::struct_mortar);
    wait(5);
  }
}

struct_mortar() {
  thread play_sound_in_space("artillery_incoming_loud", self.origin);
  wait(1);
  mortar_fx = getfx("mortar_large");
  playFX(mortar_fx, self.origin);
  RadiusDamage(self.origin, 100, 500, 500, level.player);
  thread play_sound_in_space("mortar_explosion_dirt", self.origin);

  PhysicsExplosionSphere(self.origin, 100, 100, 2);
}

smoke_degrades() {
  wait(2.5);
  self.degrade_time += 0.05;
  wait(1);
  self.degrade_time += 0.05;
  wait(1);
  self.degrade_time += 0.05;
  wait(1);

  self notify("done");
}

turret_burns_out() {
  ent = spawnStruct();
  ent endon("done");
  ent.degrade_time = 0;
  ent thread smoke_degrades();

  level endon("kaboom_to_detour_vehicle");
  fx = getfx("minigun_burnout");
  for(;;) {
    playFXOnTag(fx, self, "j_spin");

    timer = 0;
    if(ent.degrade_time > 0) {
      timer += RandomFloat(ent.degrade_time);
    }
    timer += 0.035;
    wait(timer);
  }
}

vehicle_resumespeed_trigger() {
  if(flag("convoy_slows_down_again"))
    return;
  level endon("convoy_slows_down_again");
  for(;;) {
    self waittill("trigger", other);
    if(!first_touch(other)) {
      continue;
    }
    other Vehicle_SetSpeed(8.2, 5, 5);
  }
}

player_convoy_encounters_baddies() {
  trigger = GetEnt("vehicle_resumespeed_trigger", "targetname");
  trigger thread vehicle_resumespeed_trigger();

  player_vehicle = level.crazy_ride_convoy["player"];
  detour_vehicle = level.crazy_ride_convoy["detour"];
  lead_vehicle = level.crazy_ride_convoy["lead"];
  rear_vehicle = level.crazy_ride_convoy["rear"];

  gunner = detour_vehicle get_gunner_from_vehicle();

  flag_wait("shot_rings_out");
  wait(1.5);

  faster = 10.2;
  lead_vehicle delayCall(0, ::Vehicle_SetSpeed, faster, 10, 10);
  detour_vehicle delayCall(0.45, ::Vehicle_SetSpeed, faster, 10, 10);
  rear_vehicle delayCall(0.8, ::Vehicle_SetSpeed, faster, 10, 10);
  player_vehicle delayCall(1.2, ::Vehicle_SetSpeed, faster, 10, 10);

  flag_wait("haggerty_rechambers");
  level.timer = GetTime();
  delayThread(1.1, ::rpg_hits_hydrant);

  vehicle = detour_vehicle;

  node = GetVehicleNode("detour_vehicle_path", "targetname");

  vehicle thread vehicle_paths(node);
  vehicle StartPath(node);

  node = GetVehicleNode("player_detour_vehicle_path", "targetname");
  player_vehicle thread vehicle_paths(node);
  player_vehicle StartPath(node);

  level notify("convoy_continues_to_ambush");

  flag_wait("detour_convoy_slows_down");
  rear_vehicle delayCall(2.5, ::Vehicle_SetSpeed, 0, 10, 10);
  lead_vehicle delayCall(2.5, ::Vehicle_SetSpeed, 0, 10, 10);

  attractor = Missile_CreateAttractorEnt(level.crazy_ride_convoy["detour"], 25000, 1024);

  slower = 6;

  detour_vehicle Vehicle_SetSpeed(slower, 10, 10);
  wait(0.1);
  player_vehicle Vehicle_SetSpeed(slower, 10, 10);

  flag_wait("gunner_dies");
  if(IsAlive(gunner)) {
    if(isDefined(gunner.magic_bullet_shield))
      gunner stop_magic_bullet_shield();
    eye = gunner getEye();
    MagicBullet("ak47", eye + (0, 0, 35), eye + (0, 0, -35));
  }

  flag_wait("rpg_super_ambush");

  ai = GetAIArray("axis");
  foreach(guy in ai) {
    guy.a.rockets = 0;
  }

  trigger = getEntWithFlag("rpg_ambush");
  start = GetEnt(trigger.target, "targetname");
  end = GetEnt(start.target, "targetname");

  timer = GetTime();

  rear_vehicle.veh_brake = 0.1;
  rear_vehicle delayThread(1.5, ::set_brakes, 1);

  angles = detour_vehicle.angles;
  forward = anglesToForward(angles);
  right = AnglesToRight(angles);

  struct = getstruct("ambush_impact_vector", "targetname");
  target = getstruct(struct.target, "targetname");

  velocity_angles = VectorToAngles(target.origin - struct.origin);
  velocity_forward = anglesToForward(velocity_angles);
  velocity = velocity_forward * 1;

  contact_point = right * -30 + forward * -30 + (0, 0, -10);

  PhysicsExplosionSphere(detour_vehicle.origin + contact_point, 48, 32, 3);
  level notify("kaboom_to_detour_vehicle");

  mortar_fx = getfx("mortar_large");
  playFX(mortar_fx, detour_vehicle.origin + contact_point);

  detour_vehicle godoff();
  RadiusDamage(detour_vehicle.origin, 64, 50000, 50000);

  Earthquake(0.7, 1.2, level.player.origin, 5000);
  level.player PlayRumbleOnEntity("damage_heavy");

  level.player ShellShock("default", 5);

  detour_vehicle.veh_brake = 0.15;

  thread vision_set_fog_changes("roadkill_ambush", 0.8);

  flag_set("ambush");

  Missile_DeleteAttractor(attractor);

  repulsor = Missile_CreateRepulsorEnt(level.player, 700, 1500);

  wait(0.7);
  player_vehicle.veh_brake = 0.05;

  wait(0.5);

  player_vehicle delayThread(0.7, ::set_brakes, 1);

  wait_around_time = 3.2;

  delayThread(2.00 + wait_around_time, ::rpg_flies_by_view);

  lead_vehicle delayCall(5.0, ::resumespeed, 5);

  wait(1.25 + wait_around_time);

  player_vehicle.veh_transmission = "reverse";
  player_vehicle.veh_pathdir = "reverse";
  player_vehicle Vehicle_SetSpeed(16, 5, 5);
  player_vehicle.veh_brake = 0;
  wait(1.8);
  player_vehicle.veh_brake = 1;

  wait(0.7);
  player_vehicle.veh_brake = 0;

  player_vehicle.veh_transmission = "forward";
  player_vehicle.veh_pathdir = "forward";

  node = GetVehicleNode("player_gets_back_on_path", "targetname");
  player_vehicle thread vehicle_paths(node);
  player_vehicle StartPath(node);
  player_vehicle ResumeSpeed(5);

  rear_vehicle ResumeSpeed(5);

  noself_delayCall(2, ::Missile_DeleteAttractor, repulsor);

  wait(0.8);

  rear_vehicle.veh_brake = 0;
}

rpg_hits_hydrant() {
  array_spawn_function_targetname("window_rpg_hydrant", ::rpg_vehicle);
  vehicle = spawn_vehicle_from_targetname_and_drive("window_rpg_hydrant");
  vehicle waittill("death");
  thread hydrant_hit();
}

rpg_flies_by_view() {
  array_spawn_function_targetname("window_rpg_vehicle", ::rpg_vehicle);
  vehicle = spawn_vehicle_from_targetname_and_drive("window_rpg_vehicle");
  vehicle waittill("death");

  struct = getstruct("dyn_explosion_struct", "targetname");

  level.player delayThread(3, maps\_gameskill::grenade_dirt_on_screen, "left");

  struct = getstruct("dyn_spawner_struct", "targetname");
  targ = getstruct(struct.target, "targetname");

  models = [];
  models[0] = "me_woodcrateclosed";
  models[1] = "com_cardboardboxshortclosed_2";

  offsets = [];
  offsets[0] = (0, 0, 8);
  offsets[1] = (0, 0, 4.5);

  forcemult = [];
  forcemult[0] = 4;
  forcemult[1] = 1;

  fx = getfx("rocket_explode");
  playFX(fx, struct.origin);
  thread play_sound_in_space("rocket_explode_dirt", struct.origin, true);
  PhysicsExplosionSphere(struct.origin, 320, 280, 4);
  RadiusDamage(struct.origin, 320, 50, 50);

  for(i = 0; i < 14; i++) {
    end = targ.origin + randomvector(128);
    vec = end - struct.origin;
    angles = VectorToAngles(vec);
    forward = anglesToForward(angles);

    index = RandomInt(models.size);
    ent = spawn("script_model", struct.origin);
    ent setModel(models[index]);

    force = forward;
    force *= 18000;
    force *= forcemult[index];
    force *= RandomFloatRange(0.9, 1.6);
    offset = offsets[index] + randomvector(1.2);

    ent PhysicsLaunchClient(ent.origin + offset, force);
  }
}

vehicle_physics_explosion() {
  rpg_physics = GetEnt("rpg_physics", "targetname");
  targ = GetEnt(rpg_physics.target, "targetname");

  rpg_physics_dest = GetEnt("rpg_physics_dest", "targetname");
  targ_dest = GetEnt(rpg_physics_dest.target, "targetname");

  time = 0.3;
  rpg_physics MoveTo(rpg_physics_dest.origin, time);
  targ MoveTo(targ_dest.origin, time);

  start_time = GetTime();

  time *= 1000;
  power = 6.25;

  vec = targ.origin - rpg_physics.origin;
  angles = VectorToAngles(vec);
  forward = anglesToForward(angles);
  vec = forward * power;

  power *= 0.35;
  level.crazy_ride_convoy["detour"] VehPhys_Launch(vec, 1.0);
}

reverse_force() {
  reverse_force = GetEnt("reverse_force", "targetname");
  targ = GetEnt(reverse_force.target, "targetname");
  vec = targ.origin - reverse_force.origin;
  angles = VectorToAngles(vec);
  forward = anglesToForward(angles);
  vec = forward * 3.5;

  PhysicsJolt(reverse_force.origin, 350, 350, vec);
  Line(reverse_force.origin, targ.origin, (0, 0, 1), 1, 0, 500);
}

rpg_vehicle() {
  self setModel("projectile_rpg7");
  fx = getfx("rpg_trail");
  playFXOnTag(fx, self, "tag_origin");

  fx = getfx("rpg_muzzle");
  playFXOnTag(fx, self, "tag_origin");

  self waittill("reached_end_node");
  flag_set("rpg_end");
  self Delete();
}

ride_scenes() {
  thread favela_flee_alley();
  thread roof_backup_scene();
  thread civ_balcony();
  thread garage_scene();
  thread window_waver();

  thread alley_runners();

  array_spawn_function_noteworthy("flee_if_seen", ::flee_if_seen);
  array_spawn_function_noteworthy("run_and_delete", ::run_and_delete);
}

run_and_delete() {
  self.ignoreme = true;
  self.ignoreall = true;
  self endon("death");

  if(isDefined(self.script_delay)) {
    self SetGoalPos(self.origin);
    self.goalradius = 8;
    script_delay();
    self thread maps\_spawner::go_to_node();
  }

  self waittill("reached_path_end");
  self Delete();
}

flee_if_seen() {
  self.ignoreme = true;
  self.ignoreall = true;
  self endon("death");

  start_pos = self.origin;
  self waittill("goal");
  wait(0.5);

  add_wait(::player_looks_at_me);
  add_wait(::_wait, 4);
  do_wait_any();

  self SetGoalPos(start_pos);
  self.goalradius = 8;
  self waittill("goal");
  self Delete();
}

player_looks_at_me() {
  self endon("death");

  for(;;) {
    if(within_fov_of_players(self.origin, 0.75))
      return;
    wait(0.05);
  }
}

corner_hider() {
  array_spawn_function_noteworthy("corner_hider_spawner", ::corner_hider_spawner);
}

bloody_pain(amount, attacker, dir, point, type, a, b) {
  fx = getfx("headshot");
  forward = anglesToForward(dir);
  up = AnglesToUp(dir);
  playFX(fx, point, forward, up);
}

corner_hider_spawner() {
  self endon("death");
  self set_generic_deathanim("facedown_death");
  self add_damage_function(::bloody_pain_reverse);
  self.health = 5000;

  turret = level.crazy_ride_convoy["detour"].mgturret[0];
  turret SetMode("manual");
  turret SetTargetEntity(self);
  turret.dontshoot = true;
  owner = turret GetTurretOwner();
  if(IsAlive(owner))
    owner.ignoreall = true;

  trigger = GetEnt("detour_shoots_alley_guy_trigger", "targetname");
  for(;;) {
    trigger waittill("trigger", other);
    if(other == level.crazy_ride_convoy["detour"]) {
      break;
    }
    wait(0.05);
  }

  flag_set("trapper_spawners_ignoreme");

  turret.dontshoot = undefined;
  wait(0.5);

  struct = getstruct("run_death_facedown", "targetname");

  struct thread anim_generic_gravity(self, "facedown_death");
  wait(1);

  self.a.nodeath = true;
  self Kill();
}

jumper_shoots_car_fx() {
  self endon("death");

  struct = getstruct("jumper_fx", "targetname");
  dirt_fx = getfx("car_dirt");
  spark_fx = getfx("car_spark");

  count = 0;

  for(;;) {
    self waittillmatch("custom_animmode", "fire_spray");
    count++;

    link = getstruct(struct.script_linkto, "script_linkname");
    angles = VectorToAngles(link.origin - struct.origin);
    forward = anglesToForward(angles);

    fx = dirt_fx;
    alias = "bullet_large_dirt";
    if(count > 6) {
      fx = spark_fx;
      alias = "bullet_large_metal";
    } else {}

    thread play_sound_in_space(alias, struct.origin);
    playFX(fx, struct.origin, forward);
    if(!isDefined(struct.target)) {
      break;
    }
    struct = getstruct(struct.target, "targetname");

    if(count > 9)
      level.player DoDamage(20 / level.player.damageMultiplier, self.origin, self, self);
  }

  for(;;) {
    level.player DoDamage(20 / level.player.damageMultiplier, self.origin, self, self);
    self waittillmatch("custom_animmode", "fire_spray");
  }
}

alley_runners() {
  array_spawn_function_noteworthy("alley_runner_spawner_first", ::alley_runner_spawner_first);
  array_spawn_function_noteworthy("alley_runner_spawner", ::alley_runner_spawner);
}

alley_runner_spawner_first() {
  self endon("death");
  self.ignoreme = true;
  self.ignoreall = true;

  struct = getstruct(self.target, "targetname");
  scene = struct.animation;

  struct anim_generic(self, scene);

  self Delete();
}

wall_climber_ragdolls_on_pain(amt, attacker, force, b, c, d, e) {
  if(attacker != level.player) {
    return;
  }

  self StartRagdoll();
  self remove_damage_function(::wall_climber_ragdolls_on_pain);
}

alley_runner_spawner() {
  self endon("death");
  self add_damage_function(::wall_climber_ragdolls_on_pain);
  self disable_pain();

  self.ignoreall = true;
  self.ignoreme = true;
  self.disableBulletWhizbyReaction = true;
  self.ignoreSuppression = true;

  self.ignoreall = true;

  pauses = [];
  pauses["unarmed_climb_wall"] = 1.2;
  pauses["unarmed_climb_wall_v2"] = 0;

  struct = getstruct(self.target, "targetname");
  scene = struct.animation;
  pause = pauses[scene];
  wait(pause);

  struct anim_generic_reach(self, scene);
  struct anim_generic(self, scene);

  node = GetNode("alley_runner_node", "targetname");
  self SetGoalNode(node);
  self.goalradius = 8;
  self waittill("goal");

  self Delete();
}

favela_flee_alley() {
  array_spawn_function_targetname("favela_hide_spawner", ::favela_hide_spawner);
  flag_wait("start_runner");
  array_spawn_targetname("favela_hide_spawner");
}

favela_hide_spawner() {
  self endon("death");
  self.animname = "flee_alley";
  struct = getstruct(self.target, "targetname");
  struct thread anim_loop_solo(self, "idle");
  wait(5);
  struct notify("stop_loop");
  struct thread anim_custom_animmode_solo(self, "gravity", "round_corner");

  animation = self getanim("round_corner");
  for(;;) {
    if(self GetAnimTime(animation) > 0.8) {
      break;
    }

    wait(0.05);
  }

  self SetLookAtEntity(level.player);
  struct = getstruct("hide_house_scene", "targetname");
  struct anim_first_frame_solo(self, "hands_up");
  wait(1.7);
  struct anim_single_solo(self, "hands_up");
  self safe_delete();
}

window_waver() {
  flag_wait("garage_door_scene");
  wait(10);

  spawner = GetEnt("window_wave_loop_spawner", "targetname");
  spawner.script_drone_override = true;
}

window_wave_loop() {
  self endon("death");
  self SetLookAtEntity(level.player);
  start = self.origin;
  scene = self.script_noteworthy;
  struct = getstruct(self.target, "targetname");
  struct thread anim_generic_loop(self, scene);
  wait(13.4);
  struct notify("stop_loop");
  self anim_stopanimscripted();
  self SetGoalPos(start);
  self.goalradius = 5;
  wait(5);
  self Delete();
}

garage_scene() {
  flag_wait("garage_door_scene");
  run_thread_on_targetname("garage_pull_struct", ::garage_pull_struct);
  array_spawn_function_targetname("garage_spawner", ::garage_spawner);

  garage_spawner_right = GetEnt("garage_spawner_right", "script_noteworthy");
  garage_spawner_left = GetEnt("garage_spawner_left", "script_noteworthy");

  garage_spawner = GetEnt("garage_spawner", "script_noteworthy");

  garage_spawner_right delayThread(0, ::spawn_ai);

  garage_spawner delayThread(6.4, ::spawn_ai);
  garage_spawner_left delayThread(3.4, ::spawn_ai);
}

garage_spawner() {
  self endon("death");
  scene = self.script_noteworthy;
  start_org = self.origin;

  structs = [];
  structs["garage_spawner_right"] = "garage_door_scene";
  structs["garage_spawner_left"] = "garage_door_scene_left";
  structs["garage_spawner"] = "garage_door_scene";
  structs["garage_window_shouter_spawner"] = self.target;

  self.moveplaybackrate = 1;

  if(scene == "garage_spawner_right") {
    self.force_civilian_hunched_run = true;
  } else
  if(scene == "garage_spawner_left") {
    self.force_civilian_stand_run = true;
  }

  if(isDefined(level.scr_anim["generic"][scene + "_run"])) {
    self set_generic_run_anim(scene + "_run", false);
  }

  struct_name = structs[scene];

  struct = getstruct(struct_name, "targetname");
  struct anim_generic_reach(self, scene);

  if(scene == "garage_spawner") {
    level.garage_puller = self;
    self disable_pain();
    self magic_bullet_shield();
    delayThread(1.75, ::flag_set, "pull_garage");
  }

  struct anim_generic(self, scene);

  return_to_goal = [];
  return_to_goal["garage_spawner_right"] = false;
  return_to_goal["garage_spawner_left"] = false;
  return_to_goal["garage_window_shouter_spawner"] = true;
  return_to_goal["garage_spawner"] = false;

  if(!return_to_goal[scene]) {
    self SetGoalPos(self.origin);
    wait(5);
    self safe_delete();
    return;
  }

  self SetGoalPos(start_org);
  self.goalradius = 4;
  self waittill("goal");
  self safe_delete();
}

garage_pull_struct() {
  lower_struct = self;
  mid_struct = getstruct(lower_struct.target, "targetname");
  top_struct = getstruct(mid_struct.target, "targetname");

  top_struct.origin += (0, 0, 10);

  brushes = [];
  brush = top_struct;
  for(;;) {
    newbrush = GetEnt(brush.target, "targetname");
    brushes[brushes.size] = newbrush;
    if(!isDefined(newbrush.target)) {
      break;
    }
    brush = newbrush;
  }

  start_height = mid_struct.origin[2] - lower_struct.origin[2];

  foreach(brush in brushes) {
    brush.start_origin = brush.origin;
    brush.origin += (0, 0, start_height);

    if(brush.origin[2] > top_struct.origin[2])
      brush hide_notsolid();
  }

  flag_wait("pull_garage");
  thread play_sound_in_space("scn_roadkill_garage_close", brushes[0].origin);

  level delayThread(0.95, ::send_notify, "stop_pulling");

  origins = [];
  origins[origins.size] = (0, 0, 420.637);
  origins[origins.size] = (0, 0, 420.62);
  origins[origins.size] = (0, 0, 419.686);
  origins[origins.size] = (0, 0, 418.499);
  origins[origins.size] = (0, 0, 415.63);
  origins[origins.size] = (0, 0, 413.791);
  origins[origins.size] = (0, 0, 412.708);
  origins[origins.size] = (0, 0, 411.595);
  origins[origins.size] = (0, 0, 411.204);
  origins[origins.size] = (0, 0, 410.838);
  origins[origins.size] = (0, 0, 411.314);
  origins[origins.size] = (0, 0, 411.756);
  origins[origins.size] = (0, 0, 412.38);
  origins[origins.size] = (0, 0, 412.633);
  origins[origins.size] = (0, 0, 409.838);
  origins[origins.size] = (0, 0, 401.405);
  origins[origins.size] = (0, 0, 388.418);

  thread garage_brushes_move(brushes, lower_struct, origins);

  for(;;) {
    if(!brushes.size) {
      break;
    }

    foreach(index, brush in brushes) {
      if(brush.origin[2] < top_struct.origin[2]) {
        brush show_solid();
        brushes[index] = undefined;
      }
    }
    wait(0.05);
  }
}

garage_brushes_move(brushes, lower_struct, origins) {
  level endon("stop_pulling");
  PrintLn("	origins = [];");
  index = 0;
  for(;;) {
    hand_org = origins[index];
    index++;

    difference = hand_org[2] - lower_struct.origin[2];
    foreach(brush in brushes) {
      brush MoveTo(brush.start_origin + (0, 0, difference), 0.1, 0, 0);
    }

    if(index >= origins.size) {
      break;
    }
    wait(0.05);
  }

  foreach(brush in brushes) {
    brush MoveTo(brush.start_origin, 0.2, 0.1, 0.1);
  }
}

street_runner_scene() {
  flag_wait("start_runner");

  struct = getstruct("street_runner_scene", "targetname");
  spawner = GetEnt(struct.target, "targetname");
  guy = spawner spawn_ai();
  if(spawn_failed(guy)) {
    return;
  }
  guy.animname = "street_runner";
  animation = guy getanim("scene");

  struct thread anim_custom_animmode_solo(guy, "gravity", "scene");

  wait(0.05);
  guy SetAnimTime(animation, 0.18);

  guy endon("death");
  guy.allowPain = true;
  guy.allowdeath = true;
  guy add_damage_function(::player_fails_if_he_kills_me);

  for(;;) {
    if(guy GetAnimTime(animation) > 0.95) {
      break;
    }
    wait(0.05);
  }

  goalnode = GetNode(guy.target, "targetname");
  guy SetGoalNode(goalnode);
  guy.goalradius = 8;
  guy waittill("goal");
  guy Delete();
}

roof_backup_scene() {
  flag_wait("start_runner");
  wait(4);

  struct = getstruct("roof_backup_scene", "targetname");
  spawner = GetEnt(struct.target, "targetname");
  guy = spawner spawn_ai();
  if(spawn_failed(guy)) {
    return;
  }
  guy.animname = "roof_backup";
  animation = guy getanim("scene");

  struct thread anim_single_solo(guy, "scene");

  wait(0.05);
  guy SetAnimTime(animation, 0.2);
  guy endon("death");
  guy.allowPain = true;
  guy.allowdeath = true;

  for(;;) {
    if(guy GetAnimTime(animation) > 0.59) {
      break;
    }
    wait(0.05);
  }

  guy Delete();
}

civ_balcony() {
  flag_wait("start_balcony");

  door = GetEnt("civ_run_door", "targetname");
  trigger = GetEnt("civ_door_trigger", "targetname");
  spawner = GetEnt("civ_balcony_spawner", "targetname");
  struct = getstruct("civ_balcony_physics", "targetname");

  door ConnectPaths();

  door RotateYaw(-90, 1, 0.5, 0.5);
  guy = spawner spawn_ai();
  if(spawn_failed(guy)) {
    return;
  }
  node = GetNode(guy.target, "targetname");
  startpos = guy.origin;
  guy endon("death");

  guy waittill("goal");
  guy.goalradius = 8;
  wait(0.35);

  forward = anglesToForward(struct.angles);
  vec = forward * 0.15;
  PhysicsJolt(struct.origin, 32, 32, vec);

  wait(1.8);
  guy SetGoalPos(startpos);

  trigger waittill("trigger");

  door RotateYaw(90, 1, 0.5, 0.5);
  wait(0.4);
  play_sound_in_space("scn_doorpeek_door_slam", door.origin);
}

grenade_barrage_if_you_delay() {
  time = 10;
  frames = time * 20;

  count = 0;

  structs = getStructArray("grenade_dismount_spawner", "targetname");
  structs = array_randomize(structs);
  index = 0;

  wait_times = [];
  wait_times[0] = 3.2;
  wait_times[1] = 1.8;
  wait_times[2] = 0.5;
  wait_times[3] = 3.7;
  wait_times[4] = 1.3;
  wait_index = 0;

  for(;;) {
    if(flag("player_inside_ambush_house")) {
      if(count > frames - 35)
        count = frames - 35;
    } else {
      count++;
    }

    if(count >= frames) {
      struct = random(structs);
      struct throw_grenade();
      index++;
      index %= structs.size;

      wait(wait_times[wait_index]);
      wait_index++;
      wait_index %= wait_times.size;
    }
    wait(0.05);
  }
}

dismount_enemy_spawner() {
  self SetThreatBiasGroup("axis_dismount_attackers");
  self.dont_ride_kill = true;
}

throw_grenade() {
  target = getstruct(self.target, "targetname");
  time = RandomFloatRange(3, 5);
  MagicGrenade("fraggrenade", self.origin, target.origin, time);
}

modify_dismount_spawner_threatbias() {
  for(;;) {
    flag_wait("player_inside_ambush_house");
    SetIgnoreMeGroup("axis_dismount_attackers", "ally_with_player");
    SetIgnoreMeGroup("ally_with_player", "axis_dismount_attackers");

    flag_waitopen("player_inside_ambush_house");
    SetThreatBias("axis_dismount_attackers", "ally_with_player", 0);
    SetThreatBias("ally_with_player", "axis_dismount_attackers", 0);
  }
}

handle_player_exposing_himself_in_front_of_school() {
  flag_wait("player_exposes_on_street");
  level.player SetThreatBiasGroup("allies");

  thread player_dies_if_he_goes_too_far();

  for(;;) {
    flag_wait("player_exposes_on_street");
    set_player_attacker_accuracy(1000);
    level.player.noPlayerInvul = true;
    level.player.threatbias = 50000;
    level.player EnableHealthShield(false);

    flag_waitopen("player_exposes_on_street");
    maps\_gameskill::updateAllDifficulty();
    level.player.noPlayerInvul = undefined;
    level.player.threatbias = 150;
    level.player EnableHealthShield(true);
  }
}

player_dies_if_he_goes_too_far() {
  flag_clear("player_dies_on_street");
  flag_wait("player_dies_on_street");
  for(;;) {
    ai = GetAIArray("axis");
    guy = random(ai);
    origin = (0, 0, 0);
    attacker = level.player;

    if(IsAlive(guy)) {
      origin = guy getEye();
      attacker = guy;
    }

    level.player DoDamage(25, origin);
    delay = RandomFloatRange(0.1, 0.3);
    wait(delay);
  }
}

handle_start_points_for_detour_humvee() {
  switch (level.start_point) {
    case "default":
    case "intro":
    case "riverbank":
    case "move_out":
    case "convoy":
    case "ride":
    case "ambush":
      return;
  }

  ride_vehicle_spawners = getEntArray("ride_vehicle_spawner", "targetname");
  foreach(spawner in ride_vehicle_spawners) {
    if(spawner.script_index == 3)
      spawner Delete();
  }
}

player_gets_max_health_for_dismount() {
  level.player endon("death");
  time = 4;
  frames = time * 20;
  for(i = 0; i < frames; i++) {
    level.player.health = level.player.maxhealth;
    wait(0.05);
  }
}

intro_shepherd() {
  shepherd_roamer_spawner = GetEnt("shepherd_roamer_spawner", "targetname");
  shepherd_roamer_spawner add_spawn_function(::intro_shepherd_think);
  shepherd_roamer_spawner spawn_ai();
}

intro_shepherd_think() {
  thread shepherd_roams_battlefield(self.target);
}

player_shepherd_fov() {
  start_time = gettime();
  wait_for_buffer_time_to_pass(start_time, 7.0);
  ent = spawn_tag_origin();
  ent.origin = (65, 0, 0);
  ent thread manage_fov();
  time = 0.5;

  level.player LerpViewAngleClamp(time, time, 0, 0, 0, 0, 0);

  wait_for_buffer_time_to_pass(start_time, 9.4);

  wait time;
  ent delete();
}

manage_fov() {
  self endon("death");

  for(;;) {
    setsaveddvar("cg_fov", self.origin[0]);
    wait 0.05;
  }
}

shepherd_roams_battlefield(target) {
  level.player allowprone(false);
  level.player allowcrouch(false);

  self endon("death");
  self.animname = "shepherd";
  self.ignoreall = true;
  self.disablearrivals = true;
  self.disableexits = true;
  self.grenadeawareness = 0;

  self disable_bulletwhizbyreaction();
  self set_run_anim("angry_walk");
  self gun_remove();

  lookent = getent("shepherd_lookat_target", "targetname");

  gun = spawn_anim_model("gun_model");

  player_rig = spawn_anim_model("player_rig");

  guys = [];
  guys["shepherd"] = self;
  guys["gun"] = gun;
  guys["player_rig"] = player_rig;

  scene = "player_shep_intro";

  animation = player_rig getanim(scene);
  time = getanimlength(animation);
  mortar_org = getstruct("mortar_org", "targetname");

  delayThread(time - 1.6, ::roadkill_mortar_goes_off, mortar_org);
  level.player delayThread(time - 0.2, maps\_gameskill::grenade_dirt_on_screen, "right");

  arc = 15;

  level.player PlayerLinkToDelta(player_rig, "tag_player", 1, arc, arc, arc, arc, 1);
  thread player_shepherd_fov();

  struct = getstruct("shepherd_get_in_fight", "targetname");
  struct thread anim_single(guys, scene);

  struct waittill(scene);
  level.player unlink();
  level.player allowprone(true);
  level.player allowcrouch(true);

  player_rig delete();
  gun delete();

  flag_set("get_on_the_line");
  node = getnode("shepherd_dest_node", "targetname");
  self setgoalnode(node);
  self.goalradius = 8;

  flag_wait("shepherd_leaves");

  self stop_magic_bullet_shield();
  thread shepherd_bridge_scene(self);
}

shepdamage_bullet_thread() {
  self endon("death");
  for(;;) {
    self waittill("bullethit", other);
    if(other == level.player) {
      setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
      missionfailedwrapper();
    }
  }
}

shepdamage_damage_thread() {
  self endon("death");
  for(;;) {
    self waittill("damage", dmg, attacker, one, two, weapType);

    if(!isalive(attacker)) {
      continue;
    }
    if(attacker == level.player) {
      setDvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");
      missionfailedwrapper();
    }
  }
}

shepherd_bridge_scene(shepherd) {
  shepherd gun_remove();
  shepherd = maps\_vehicle_aianim::convert_guy_to_drone(shepherd);
  shepherd.script = "empty_script";
  shepherd.dontdonotetracks = true;
  shepherd setCanDamage(true);
  shepherd.health = 5000;
  shepherd thread shepdamage_bullet_thread();
  shepherd thread shepdamage_damage_thread();

  shepherd hide();

  shepherd.animname = "shepherd";

  shepherd Attach("com_hand_radio", "tag_inhand");

  struct = getstruct("shepherd_new_wander_struct", "targetname");
  ent = spawn_tag_origin();
  start_org = struct.origin + (-200, 0, 0);
  ent.origin = start_org;
  ent.angles = struct.angles;

  ent anim_first_frame_solo(shepherd, "angry_wander");
  wait 0.05;
  shepherd linkto(ent);

  wait 4;
  shepherd show();

  ent thread anim_single_solo(shepherd, "angry_wander");

  time = 8;
  ent moveto(struct.origin, time, 0, time);
  wait time;

  shepherd wait_until_time_to_shepout();

  time = 5;

  ent moveto(start_org, time, time, 0);

  wait time;
  shepherd delete();
}

wait_until_time_to_shepout() {
  level endon("player_starts_stairs");

  animation = getanim("angry_wander");
  for(;;) {
    animtime = self getanimtime(animation);
    if(animtime > 0.80) {
      break;
    }
    wait 0.05;
  }
}

stair_wave_spawner() {
  self endon("death");
  self.animname = "shepherd";
  self Attach("com_hand_radio", "tag_inhand");
  self hide();
  self gun_remove();

  struct = getstruct("shepherd_wander_struct", "targetname");
  struct anim_first_frame_solo(self, "stair_wave");
  wait 0.05;

  eye = self getEye();

  see_spawn = level.player can_see_origin(eye, false);

  within_dist = distance(level.player.origin, self.origin) < 400;
  if(see_spawn || within_dist) {
    waittillframeend;
    self safe_delete();
    return;
  }

  self show();

  struct thread anim_loop_solo(self, "stair_idle");
  for(;;) {
    if(distance(level.player.origin, self.origin) < 350) {
      break;
    }
    wait(0.05);
  }
  struct notify("stop_loop");

  struct anim_single_solo(self, "stair_wave");
  struct thread anim_loop_solo(self, "stair_idle");

  flag_wait("player_gets_in");
  self safe_delete();
}

wander_battlefield_until_time_to_stop(target) {
  if(flag("bridgelayer_complete"))
    return;
  level endon("bridgelayer_complete");

  first_target = target;
  for(;;) {
    if(!isDefined(target))
      target = first_target;

    struct = getstruct(target, "targetname");
    if(isDefined(struct.script_delay)) {
      struct anim_reach_solo(self, "idle_reach");
      struct thread anim_loop_solo(self, "idle");
      wait(struct.script_delay);
      struct notify("stop_loop");
      self anim_stopanimscripted();
    } else {
      self SetGoalPos(struct.origin);
      self.goalradius = struct.radius;
      self waittill("goal");
    }
    target = struct.target;
  }
}

intro_runner_path_breaker() {
  brush = GetEnt("intro_runner_path_breaker", "targetname");
  brush DisconnectPaths();
  brush NotSolid();

  wait(5);
  brush Solid();
  brush ConnectPaths();
  brush Delete();
}

school_unreachable_spawner() {
  self endon("death");
  flag_wait("roadkill_school_14");
  self Delete();
}

ambusher_spawner() {
  level.ambusher = self;
  self.ignoreall = true;
  self.ignoreme = true;
  flag_wait("ambush_spawner_angry");
  self.ignoreme = false;
  if(IsAlive(self)) {
    self.threatbias = 50000;
    self.ignoreall = false;

    link = GetEnt(self.script_linkto, "script_linkname");
    self SetEntityTarget(link);
    wait(3);
    self ClearEntityTarget();
  }

  if(IsAlive(self)) {
    self waittill("death");

    wait(2);
    if(isDefined(self))
      self.ignoreme = true;
  }
}

ignore_until_attack() {
  self endon("death");
  self.ignoreme = true;
  self waittill("shooting");
  wait(0.5);
  self.ignoreme = false;
}

trapper_spawner() {
  self endon("death");
  flag_wait("trapper_spawners_ignoreme");
  self.ignoreme = true;
}

trapper_killer_trigger() {
  trigger = GetEnt("trapper_killer_trigger", "targetname");
  for(;;) {
    trigger waittill("trigger", other);
    other Delete();
  }
}

no_grenades() {
  self.grenadeammo = 0;
}

gaz_balcony_guys() {
  run_thread_on_targetname("gaz_balcony", ::gaz_balcony);
}

gaz_balcony() {
  spawner = GetEnt(self.target, "targetname");
  spawner.script_drone_override = true;
  spawner add_spawn_function(::gaz_balcony_think, self);
  spawner spawn_ai();
}

gaz_balcony_think(struct) {
  self endon("death");
  self SetLookAtEntity(level.player);
  self gun_remove();
  self.allowdeath = true;
  self.health = 1;
  self.ignoreall = true;
  self.ignoreSuppression = true;

  self.custom_scene = struct.animation;
  self.price_idle = struct.animation == "killhouse_sas_price_idle";
  self.first_scene = "killhouse_gaz_idleB";
  if(self.price_idle)
    self.first_scene = "killhouse_sas_price_idle";

  if(self.custom_scene == "killhouse_gaz_idleB") {
    wait(2.5);
  } else {
    wait(RandomFloat(1.5));
  }

  struct thread anim_generic_loop(self, self.first_scene);
  flag_wait("garage_door_scene");

  idle_until_tired_of_idling_or_shot_at(struct);
  timer = RandomFloat(0.65);
  wait(timer);
  struct notify("stop_loop");
  self anim_stopanimscripted();
  self waittill("goal");
  wait(90);
  self Delete();
}

idle_until_tired_of_idling_or_shot_at(struct) {
  self endon("bulletwhizby");
  if(!self.price_idle) {
    struct notify("stop_loop");
    struct anim_generic(self, self.custom_scene + "_solo");
    struct anim_generic(self, self.custom_scene + "_solo");
    struct thread anim_generic_loop(self, self.first_scene);
  }

  wait(60);
}

player_vehicle_catches_up() {
  flag_wait("start_runner");
  for(;;) {
    if(Distance(level.crazy_ride_convoy["player"].origin, level.crazy_ride_convoy["detour"].origin) <= 320) {
      break;
    }
    wait(0.05);
  }

  flag_set("player_closes_gap");
}

slow_down_to_speed_when_you_get_dist_from_ent(speed, ent, dist) {
  for(;;) {
    if(Distance(self.origin, ent.origin) <= dist) {
      self Vehicle_SetSpeed(speed, 5, 5);
      break;
    }
    wait(0.05);
  }
}

riverbank_mg() {
  self Delete();
}

radio_dialogue_generic(alias) {
  if(!isDefined(level.scr_radio[alias])) {
    level.scr_radio[alias] = level.scr_sound["generic"][alias];
  }
  radio_dialogue(alias);
}

ahead_line(alias) {
  play_line_at_offset_on_player_vehicle(alias, (0, 2500, 0));
}

way_ahead_line(alias) {
  play_line_at_offset_on_player_vehicle(alias, (0, 4000, 0));
}

shot_fired_trigger() {
  self waittill("trigger");
  struct_end = getstruct(self.target, "targetname");
  struct_start = getstruct(struct_end.target, "targetname");

  end = struct_end.origin;
  original_end = end;
  start = struct_start.origin;

  angles = VectorToAngles(start - end);
  forward = anglesToForward(angles);
  dist = Distance(end, start);

  end += forward * -1000;

  flag_set("shot_rings_out");

  thread play_sound_in_space("weap_dragunovsniper_fire_npc", start);

  units_per_second = 9000;
  time = dist / units_per_second;
  wait(time * 0.6);

  thread play_sound_in_space("whizby_triggered", end);

  wait(time * 0.4);

  trace = bulletTrace(start, end, true, undefined);
  pos = trace["position"];

  fx = getfx("car_dirt");
  sound = "concrete";
  if(trace["surfacetype"] != "concrete") {
    fx = getfx("car_spark");
    sound = "metal";
  }

  playFX(fx, pos, forward);
  playFX(fx, pos, forward);

  brick_sounds = [];
  brick_sounds[brick_sounds.size] = "ride_bullet_brick_1";
  brick_sounds[brick_sounds.size] = "ride_bullet_brick_2";

  metal_sounds = [];
  metal_sounds[metal_sounds.size] = "ride_bullet_metal_1";
  metal_sounds[metal_sounds.size] = "ride_bullet_metal_3";
  metal_sounds[metal_sounds.size] = "ride_bullet_metal_2";
  metal_sounds[metal_sounds.size] = "ride_bullet_metal_4";
  metal_sounds[metal_sounds.size] = "ride_bullet_metal_5";

  sounds = [];
  sounds["concrete"] = brick_sounds;
  sounds["metal"] = metal_sounds;

  if(!isDefined(level.magic_sound_index))
    level.magic_sound_index = [];

  if(!isDefined(level.magic_sound_index[sound])) {
    level.magic_sound_index[sound] = 0;
  }

  index = level.magic_sound_index[sound];
  alias = sounds[sound][index];
  thread play_sound_in_space(alias, pos, true);

  level.magic_sound_index[sound]++;
  level.magic_sound_index[sound] %= sounds[sound].size;

  wait(1.2);
}

rpg_ambush_spawner() {
  self SetEntityTarget(level.crazy_ride_convoy["detour"]);
  self.interval = 0;

  if(!isDefined(self.script_delay)) {
    return;
  }
  self SetGoalPos(self.origin);
  script_delay();
  self maps\_spawner::go_to_node();
}

hydrant_hit() {
  hydrant_struct = getstruct("hydrant_struct", "targetname");
  RadiusDamage(hydrant_struct.origin, hydrant_struct.radius, 5000, 5000, level.player);
}

technical_pushed_animation() {
  technical = level.traffic_jam_truck;
  technical.animname = "technical";

  struct = spawnStruct();
  struct.origin = (0, 0, 0);
  struct.angles = (0, 0, 0);
  struct thread anim_single_solo(technical, "technical_pushed");
  wait(0.05);
  animation = technical getanim("technical_pushed");
  technical SetAnim(animation, 1, 0, 1.07);
}

roadkill_gameskill_ride_settings() {
  level.difficultySettings["threatbias"]["easy"] = 0;
  level.difficultySettings["threatbias"]["normal"] = 0;
  level.difficultySettings["threatbias"]["hardened"] = 0;
  level.difficultySettings["threatbias"]["veteran"] = 0;

  level.difficultySettings["base_enemy_accuracy"]["easy"] = 1.0;
  level.difficultySettings["base_enemy_accuracy"]["normal"] = 1.0;
  level.difficultySettings["base_enemy_accuracy"]["hardened"] = 1.0;
  level.difficultySettings["base_enemy_accuracy"]["veteran"] = 1.0;

  level.difficultySettings["accuracyDistScale"]["easy"] = 1.0;
  level.difficultySettings["accuracyDistScale"]["normal"] = 1.0;
  level.difficultySettings["accuracyDistScale"]["hardened"] = 1.0;
  level.difficultySettings["accuracyDistScale"]["veteran"] = 1.0;

  level.difficultySettings["pain_test"]["easy"] = maps\_gameskill::always_pain;
  level.difficultySettings["pain_test"]["normal"] = maps\_gameskill::always_pain;
  level.difficultySettings["pain_test"]["hardened"] = maps\_gameskill::always_pain;
  level.difficultySettings["pain_test"]["veteran"] = maps\_gameskill::always_pain;

  level.difficultySettings["player_deathInvulnerableTime"]["easy"] = 7000;
  level.difficultySettings["player_deathInvulnerableTime"]["normal"] = 4000;
  level.difficultySettings["player_deathInvulnerableTime"]["hardened"] = 3000;
  level.difficultySettings["player_deathInvulnerableTime"]["veteran"] = 3000;

  level.difficultySettings["invulTime_preShield"]["easy"] = 0.0;
  level.difficultySettings["invulTime_preShield"]["normal"] = 0.0;
  level.difficultySettings["invulTime_preShield"]["hardened"] = 0.0;
  level.difficultySettings["invulTime_preShield"]["veteran"] = 0.0;

  level.difficultySettings["invulTime_onShield"]["easy"] = 0.5;
  level.difficultySettings["invulTime_onShield"]["normal"] = 0.5;
  level.difficultySettings["invulTime_onShield"]["hardened"] = 0.5;
  level.difficultySettings["invulTime_onShield"]["veteran"] = 0.5;

  level.difficultySettings["invulTime_postShield"]["easy"] = 0.3;
  level.difficultySettings["invulTime_postShield"]["normal"] = 0.3;
  level.difficultySettings["invulTime_postShield"]["hardened"] = 0.3;
  level.difficultySettings["invulTime_postShield"]["veteran"] = 0.3;

  level.difficultySettings["playerHealth_RegularRegenDelay"]["easy"] = 500;
  level.difficultySettings["playerHealth_RegularRegenDelay"]["normal"] = 500;
  level.difficultySettings["playerHealth_RegularRegenDelay"]["hardened"] = 500;
  level.difficultySettings["playerHealth_RegularRegenDelay"]["veteran"] = 500;

  level.difficultySettings["worthyDamageRatio"]["easy"] = 0.2;
  level.difficultySettings["worthyDamageRatio"]["normal"] = 0.2;
  level.difficultySettings["worthyDamageRatio"]["hardened"] = 0.2;
  level.difficultySettings["worthyDamageRatio"]["veteran"] = 0.2;

  level.difficultySettings["health_regenRate"]["easy"] = 0.2;
  level.difficultySettings["health_regenRate"]["normal"] = 0.2;
  level.difficultySettings["health_regenRate"]["hardened"] = 0.2;
  level.difficultySettings["health_regenRate"]["veteran"] = 0.2;

  level.difficultySettings["playerDifficultyHealth"]["easy"] = 20;
  level.difficultySettings["playerDifficultyHealth"]["normal"] = 20;
  level.difficultySettings["playerDifficultyHealth"]["hardened"] = 20;
  level.difficultySettings["playerDifficultyHealth"]["veteran"] = 20;

  level.difficultySettings["longRegenTime"]["easy"] = 500;
  level.difficultySettings["longRegenTime"]["normal"] = 500;
  level.difficultySettings["longRegenTime"]["hardened"] = 500;
  level.difficultySettings["longRegenTime"]["veteran"] = 500;

  level.difficultySettings["healthOverlayCutoff"]["easy"] = 0.02;
  level.difficultySettings["healthOverlayCutoff"]["normal"] = 0.02;
  level.difficultySettings["healthOverlayCutoff"]["hardened"] = 0.02;
  level.difficultySettings["healthOverlayCutoff"]["veteran"] = 0.02;
}

trigger_delete_axis_not_in_volume() {
  self waittill("trigger");

  volume = GetEnt(self.target, "targetname");
  ai = GetAIArray("axis");
  count = 0;
  total = ai.size;

  foreach(guy in ai) {
    if(guy IsTouching(volume))
      continue;
    guy Delete();
    count++;
  }
}

balcony_check() {
  if(!isDefined(self.script_balcony)) {
    return;
  }
  self.a.disableLongDeath = true;

  AssertEx(self.script_balcony, "Cant be < 1");
  self.deathFunction = ::try_balcony_death;
}

try_balcony_death() {
  if(!isDefined(self))
    return false;

  if(self.a.pose != "stand")
    return false;

  if(isDefined(self.prevnode)) {
    angleAI = self.angles[1];
    angleNode = self.prevnode.angles[1];
    angleDiff = abs(angleAI - angleNode);
    if(angleDiff > 80)
      return false;

    d = Distance(self.origin, self.prevnode.origin);
    if(d > 92)
      return false;
  }

  if(!isDefined(level.last_balcony_death))
    level.last_balcony_death = GetTime();
  elapsedTime = GetTime() - level.last_balcony_death;

  if(elapsedTime < 3 * 1000)
    return false;

  deathAnims = getGenericAnim("balcony_death");
  self.deathanim = deathAnims[RandomInt(deathAnims.size)];
  return false;
}

enemy_playground_spawner() {
  level.enemy_playground_enemies[level.enemy_playground_enemies.size] = self;

  level endon("playground_baddies_retreat");
  self.attackeraccuracy = 0;
  self.IgnoreRandomBulletDamage = true;

  thread enemy_playground_guy_retreats();
  self waittill("damage");
  flag_set("playground_baddies_retreat");
}

enemy_playground_guy_retreats() {
  self endon("death");
  flag_wait("playground_baddies_retreat");
  volume = GetEnt("lower_school_flee_volume", "targetname");
  timer = RandomFloat(2);
  wait(timer);
  self SetGoalVolumeAuto(volume);
  self waittill("goal");
  self.attackeraccuracy = 1;
  self.IgnoreRandomBulletDamage = false;
}

player_becomes_normal_gameskill() {
  wait(8.85);

  level.player maps\_gameskill::resetSkill();
  level.player recover_random_bullet_damage();

  level.player clear_custom_gameskill_func();
  setsaveddvar("player_radiusdamagemultiplier", "1.0");
}

recover_random_bullet_damage() {
  level.player.IgnoreRandomBulletDamage = false;
}

wait_for_chance_to_charge_school() {
  volume = GetEnt("safe_to_charge_school_volume", "targetname");

  num = 1;

  for(;;) {
    ai = GetAIArray("axis");
    count = 0;
    too_many = false;
    foreach(guy in level.enemy_playground_enemies) {
      if(!isalive(guy)) {
        continue;
      }
      if(guy IsTouching(volume)) {
        count++;
        if(count > num) {
          too_many = true;
          break;
        }
      }
    }
    if(!too_many)
      return;
    wait(0.05);
  }
}

ending_takeoff_heli_spawner() {
  struct = getstruct("heli_linkup_struct", "script_noteworthy");

  self set_stage(struct, level.heli_guy_left, "left");
  self set_stage(struct, level.heli_guy_right, "right");
  flag_wait("start_shepherd_end");
  self thread load_side("left", level.heli_guy_left);
  self thread load_side("right", level.heli_guy_right);
  wait(8);

  flag_wait("heli_takes_off");
  heli_fly_node = getstruct("heli_fly_node", "targetname");
  self vehicle_paths(heli_fly_node);
}

heli_spawner_left() {
  self.goalradius = 8;
  level.heli_guy_left[level.heli_guy_left.size] = self;
}

heli_spawner_right() {
  self.goalradius = 8;
  level.heli_guy_right[level.heli_guy_right.size] = self;
}

link_heli_to_landing() {
  linker = getstruct("heli_linkup_struct", "script_noteworthy");
  targ = getstruct("gag_stage_littlebird_unload", "script_noteworthy");

  linker.target = targ.targetname;
}

fail_for_civ_kill() {
  add_damage_function(::civ_hit);
}

civ_hit(amt, attacker, force, b, c, d, e) {
  if(!isalive(attacker)) {
    return;
  }
  if(attacker != level.player) {
    return;
  }
  wait(1.5);

  setDvar("ui_deadquote", &"ROADKILL_SHOT_UNARMED");
  missionFailedWrapper();
}

player_get_in_reminder() {
  if(flag("player_gets_in"))
    return;
  level endon("player_gets_in");

  wait(4);

  lines = [];

  lines[lines.size] = "roadkill_fly_comeongetin";

  lines[lines.size] = "roadkill_fly_holdingupline";

  lines[lines.size] = "roadkill_fly_hurryup";

  lines[lines.size] = "roadkill_fly_moveletsgo";

  index = 0;
  for(;;) {
    timer = RandomFloatRange(5, 9);
    wait(timer);

    msg = lines[index];
    index++;
    index %= lines.size;

    foley_line(msg);
  }
}

baddies_on_building_get_your_attention() {
  array_spawn_function_targetname("enemy_rooftop_spawner", ::enemy_rooftop_spawner);
  array_spawn_targetname("enemy_rooftop_spawner");
}

enemy_rooftop_spawner() {
  self endon("death");
  startpos = self.origin;
  self.ignoreall = true;
  self.ignoreme = true;
  self.health = 10000;

  spy_on_convoy();

  self SetGoalPos(startpos);
  self waittill("goal");
  self Delete();
}

spy_on_convoy() {
  flag_assert("video_tapers_react");
  level endon("video_tapers_react");
  level endon("spy_baddies_flee");

  thread flee_if_noticed_by_player();
  self SetGoalPos(self.origin);
  self.goalradius = 16;

  timer = RandomFloat(3);
  wait(timer);

  node = GetNode(self.target, "targetname");
  self SetGoalNode(node);
  self waittill("goal");

  nodes = getStructArray("spy_node", "script_noteworthy");

  for(;;) {
    timer = RandomFloat(0.8);
    wait(timer);
    node = random(nodes);
    self SetGoalPos(node.origin);
    self waittill("goal");
  }
}

flee_if_noticed_by_player() {
  level endon("spy_baddies_flee");
  add_wait(::waittill_msg, "bulletwhizby");
  add_wait(::waittill_msg, "death");
  add_wait(::waittill_msg, "damage");
  do_wait_any();
  level notify("spy_baddies_flee");
}

escape_block_spawner() {
  self magic_bullet_shield();
  self SetGoalPos(self.origin);
  self PushPlayer(true);
  self.dontavoidplayer = true;
  self.goalradius = 16;
  flag_wait("player_gets_in");
  self safe_delete();
}

learn_flash() {
  level.player.flash_ammo = level.player GetWeaponAmmoStock("flash_grenade");
  foley_line("roadkill_fly_getflashbang");

  display_hint("learn_flash");
}

player_learned_flash() {
  flash_ammo = level.player GetWeaponAmmoStock("flash_grenade");
  if(flash_ammo <= 0)
    return true;

  return level.player.flash_ammo > flash_ammo;
}

detect_room_was_flashed() {
  volume = GetEnt("dismount_flash_volume", "targetname");
  flash = volume get_flash_touching();
  for(;;) {
    if(!isDefined(flash)) {
      break;
    }
    wait(0.05);
  }

  flag_set("room_was_flashed");
}

get_flash_touching() {
  for(;;) {
    grenades = getEntArray("grenade", "classname");
    flashes = [];
    foreach(grenade in grenades) {
      if(IsSubStr(grenade.model, "flash")) {
        flashes[flashes.size] = grenade;
      }
    }

    foreach(flash in flashes) {
      if(flash IsTouching(self))
        return flash;
    }
    wait(0.05);
  }
}

blend_sm_sunsamplesizenear() {
  SetSavedDvar("sm_sunsamplesizenear", 0.33);

  flag_wait_or_timeout("player_enters_riverbank", 9);
  maps\_introscreen::ramp_out_sunsample_over_time(1, 0.76);
}

riverbank_player_learns_m203() {
  if(flag("leaving_riverbank")) {
    return;
  }
  level endon("leaving_riverbank");

  level endon("bridge_layer_attacked_by_bridge_baddies");

  flag_wait("player_enters_riverbank");
  wait(20);

  if(player_learned_m203()) {
    return;
  }

  foley_line("roadkill_fly_yourM203");

  display_hint("learn_m203");

  for(;;) {
    if(player_learned_m203()) {
      break;
    }
    wait(0.05);
  }

  wait(2);

  foley_line("roadkill_fly_acrossriver");
}

player_learned_m203() {
  if(flag("leaving_riverbank"))
    return true;

  return level.player getcurrentweapon() == "m203_m4_eotech";
}

other_two_guys_say_huah() {
  lines = [];
  lines[0] = "roadkill_ar1_huah";
  lines[1] = "roadkill_ar2_huah2";
  index = 0;

  ai = getaiarray("allies");
  foreach(guy in ai) {
    if(guy is_hero()) {
      continue;
    }
    msg = lines[index];
    guy generic_dialogue_queue(msg);
    index++;
    if(index >= lines.size)
      return;
  }
}

foley_gets_eyes_on_school_dialogue() {
  foley_line("roadkill_fly_eyesonschool");

  delayThread(2.6, ::flag_set, "friendlies_suppress_school");

  start_time = gettime();

  radio_line("roadkill_ar3_ineffective");
  wait_for_buffer_time_to_pass(start_time, 3.2);

  foley_line("roadkill_fly_keepittogether");

  if(flag("playground_baddies_retreat")) {
    return;
  }

  dunn_line("roadkill_cpd_frontofschool");
}

school_badguy_cleanup() {
  flag_wait("roadkill_school_18");

  ai = getaiarray("axis");
  foreach(guy in ai) {
    guy delete();
  }
}

arab_line(msg) {
  level.arab_function_stack_struct function_stack(::arab_line_proc, msg);
}

arab_line_proc(msg) {
  speakers = getStructArray("arab_speaker", "targetname");
  nearest = getClosest(level.player.origin, speakers);
  play_sound_in_space(msg, nearest.origin);
}

ending_fadeout_nextmission() {
  flag_wait("start_shepherd_end");
  delayThread(6, ::flag_set, "heli_takes_off");
  wait(10);

  black_overlay = create_client_overlay("black", 0, level.player);
  black_overlay FadeOverTime(2);
  black_overlay.alpha = 1;

  wait(2);

  nextmission();
}