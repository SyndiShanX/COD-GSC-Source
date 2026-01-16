/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\drone_squadron.gsc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\audio_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_ai_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\core_common\vehicles\wasp;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\killstreaks\ai\lead_drone;
#include scripts\killstreaks\ai\wing_drone;
#include scripts\killstreaks\helicopter_shared;
#include scripts\killstreaks\killstreak_bundles;
#include scripts\killstreaks\killstreak_hacking;
#include scripts\killstreaks\killstreakrules_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\qrdrone;
#include scripts\killstreaks\remote_weapons;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\weapons\heatseekingmissile;

#namespace drone_squadron;

autoexec __init__system__() {
  system::register(#"drone_squadron", &__init__, undefined, #"killstreaks");
}

__init__() {
  qrdrone::init_shared();
  killstreaks::register_killstreak("killstreak_drone_squadron", &function_d52c51c6);
  killstreaks::register_alt_weapon("drone_squadron", getweapon(#"killstreak_remote"));
  killstreaks::register_alt_weapon("drone_squadron", getweapon(#"hash_26ffb92552ae26be"));
  killstreaks::register_alt_weapon("drone_squadron", getweapon(#"hash_5fbda3ef4b135b49"));
  remote_weapons::registerremoteweapon("drone_squadron", #"hash_7c833954874f735d", &function_97bbef8, &function_d9733cc9, 0);
  level.killstreaks[#"drone_squadron"].threatonkill = 1;
  visionset_mgr::register_info("visionset", "drone_squadron_visionset", 1, 120, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
  callback::on_joined_team(&function_a9737855);
  callback::on_joined_spectate(&function_a9737855);
  callback::on_disconnect(&function_a9737855);
  callback::on_player_killed(&function_a9737855);
  callback::on_finalize_initialization(&function_1c601b99);
}

calcspawnorigin(origin, angles) {
  var_f868a6d2 = struct::get_array("drone_squadron_spawn", "targetname");

  if(isDefined(var_f868a6d2) && var_f868a6d2.size) {
    var_109e505c = arraysortclosest(var_f868a6d2, origin);
    dir = vectornormalize(origin - var_109e505c[0].origin);
    angles = vectortoangles(dir);
    return {
      #origin: var_109e505c[0].origin, 
      #angles: angles
    };
  }

  heightoffset = killstreaks::function_975d45c3();
  startnode = undefined;
  assert(level.heli_startnodes.size > 0, "<dev string:x38>");
  var_581dc057 = [];

  foreach(node in level.heli_startnodes) {
    facingdir = anglesToForward(angles);

    if(!util::within_fov(origin, angles, node.origin, cos(70))) {
      array::add(var_581dc057, node);
    }
  }

  if(var_581dc057.size) {
    startnode = array::random(var_581dc057);
  }

  if(!isDefined(startnode)) {
    random = randomint(level.heli_startnodes.size);
    startnode = level.heli_startnodes[random];
  }

  if(!isDefined(startnode)) {
    mins = (-5, -5, 0);
    maxs = (5, 5, 10);
    startpoints = [];
    testangles = [];
    testangles[0] = (0, 0, 0);
    testangles[1] = (0, 30, 0);
    testangles[2] = (0, -30, 0);
    testangles[3] = (0, 60, 0);
    testangles[4] = (0, -60, 0);
    testangles[3] = (0, 90, 0);
    testangles[4] = (0, -90, 0);
    bestorigin = origin;
    bestangles = angles;
    bestfrac = 0;

    for(i = 0; i < testangles.size; i++) {
      startpoint = origin + (0, 0, heightoffset);
      endpoint = startpoint + vectorscale(anglesToForward((0, angles[1], 0) + testangles[i]), 70);
      mask = 1 | 2;
      trace = physicstrace(startpoint, endpoint, mins, maxs, self, mask);

      if(isDefined(trace[#"entity"]) && isplayer(trace[#"entity"])) {
        continue;
      }

      if(trace[#"fraction"] > bestfrac) {
        bestfrac = trace[#"fraction"];
        bestorigin = trace[#"position"];
        bestangles = (0, angles[1], 0) + testangles[i];

        if(bestfrac == 1) {
          break;
        }
      }
    }

    if(bestfrac > 0) {
      if(distance2dsquared(origin, bestorigin) < 400) {
        return undefined;
      }

      trace = physicstrace(bestorigin, bestorigin + (0, 0, 50), mins, maxs, self, mask);
      var_b34db008 = trace[#"position"];
      var_27f435a7 = getclosestpointonnavvolume(bestorigin, "navvolume_big", 2000);

      if(isDefined(var_27f435a7)) {
        var_b34db008 = var_27f435a7;
      }

      placement = spawnStruct();
      placement.origin = var_b34db008;
      placement.angles = bestangles;
      return placement;
    }
  } else {
    assert(isDefined(startnode));
    var_56e2a4e0 = randomintrange(800, 1200);
    dir = vectornormalize(startnode.origin - origin);
    pos = origin + dir * var_56e2a4e0;
    pos = (pos[0], pos[1], heightoffset);
    spawnloc = getclosestpointonnavvolume(pos, "navvolume_small", 2000);

    if(isDefined(spawnloc)) {

      recordline(startnode.origin, origin, (0, 1, 1), "<dev string:x67>");
      recordline(startnode.origin, spawnloc, (0, 0, 1), "<dev string:x67>");
      recordline(origin, spawnloc, (0, 0, 1), "<dev string:x67>");
      recordsphere(origin, 5, (1, 0, 0), "<dev string:x70>");
      recordsphere(startnode.origin, 100, (0, 1, 1), "<dev string:x70>");
      recordsphere(spawnloc, 5, (0, 0, 1), "<dev string:x70>");

        return {
          #origin: spawnloc, 
          #angles: vectortoangles(dir * -1)
        };
    }
  }

  return undefined;
}

function_d52c51c6(killstreaktype) {
  assert(isplayer(self));
  player = self;

  if(!isnavvolumeloaded()) {

    iprintlnbold("<dev string:x79>");

      self iprintlnbold(#"hash_62ced7a8acdaa034");
    return false;
  }

  if(player isplayerswimming()) {
    self iprintlnbold(#"hash_425241374bdd61f0");
    return false;
  }

  spawnpos = calcspawnorigin(player.origin, player.angles);

  if(!isDefined(spawnpos)) {
    self iprintlnbold(#"hash_425241374bdd61f0");
    return false;
  }

  killstreak_id = player killstreakrules::killstreakstart("drone_squadron", player.team, 0, 1);

  if(killstreak_id == -1) {
    return false;
  }

  player stats::function_e24eec31(getweapon(#"drone_squadron"), #"used", 1);
  drone_squadron = spawnvehicle("veh_drone_squadron_mp", spawnpos.origin, spawnpos.angles, "dynamic_spawn_ai");
  drone_squadron killstreaks::configure_team("drone_squadron", killstreak_id, player, "small_vehicle", undefined, &configureteampost);
  drone_squadron killstreak_hacking::enable_hacking("drone_squadron", &hackedcallbackpre, &hackedcallbackpost);
  drone_squadron.killstreak_id = killstreak_id;
  drone_squadron.killstreak_end_time = gettime() + 45000;
  drone_squadron.original_vehicle_type = drone_squadron.vehicletype;
  drone_squadron.ignore_vehicle_underneath_splash_scalar = 1;
  drone_squadron clientfield::set("enemyvehicle", 1);
  drone_squadron.hardpointtype = "drone_squadron";
  drone_squadron.soundmod = "player";
  drone_squadron.maxhealth = killstreak_bundles::get_max_health("drone_squadron");
  drone_squadron.lowhealth = killstreak_bundles::get_low_health("drone_squadron");
  drone_squadron.health = drone_squadron.maxhealth;
  drone_squadron.hackedhealth = killstreak_bundles::get_hacked_health("drone_squadron");
  drone_squadron.rocketdamage = drone_squadron.maxhealth / 2 + 1;
  drone_squadron.playeddamaged = 0;
  drone_squadron.treat_owner_damage_as_friendly_fire = 1;
  drone_squadron.ignore_team_kills = 1;
  drone_squadron.goalradius = 4000;
  drone_squadron.goalheight = 500;
  drone_squadron.enable_guard = 1;
  drone_squadron.always_face_enemy = 1;
  drone_squadron.identifier_weapon = getweapon("drone_squadron");
  drone_squadron thread killstreaks::waitfortimeout("drone_squadron", 45000, &ontimeout, "drone_squadron_shutdown");
  drone_squadron thread killstreaks::waitfortimecheck(45000 * 0.5, &ontimecheck, "death", "drone_squadron_shutdown");
  drone_squadron thread watchwater();
  drone_squadron thread watchdeath();
  drone_squadron thread watchshutdown();
  drone_squadron vehicle::init_target_group();
  drone_squadron vehicle::add_to_target_group(drone_squadron);
  drone_squadron setrotorspeed(1);
  drone_squadron.protectent = self;
  params = level.killstreakbundle[#"drone_squadron"];
  immediate_use = isDefined(params.ksuseimmediately) ? params.ksuseimmediately : 0;

  if(!isDefined(drone_squadron.wing_drone)) {
    drone_squadron.wing_drone = [];
  }

  drone_right = anglestoright(drone_squadron.angles);
  var_3daa0416 = drone_right * -1;
  var_1b4e1739 = anglesToForward(drone_squadron.angles) * -1;
  waitframe(1);
  var_91edb2b7 = drone_squadron.origin + drone_right * 128 + var_1b4e1739 * 128;
  var_91edb2b7 = getclosestpointonnavvolume(var_91edb2b7, "navvolume_small", 2000);
  wing_drone = spawnvehicle("spawner_boct_mp_wing_drone", var_91edb2b7, drone_squadron.angles, "wing_drone_ai");

  if(isDefined(level.var_14151f16)) {
    [[level.var_14151f16]](wing_drone, 0);
  }

  wing_drone.leader = drone_squadron;
  wing_drone setteam(drone_squadron.team);
  wing_drone.team = drone_squadron.team;
  wing_drone.formation = "right";
  wing_drone setrotorspeed(1);
  wing_drone.protectent = self;
  wing_drone.owner = player;
  wing_drone clientfield::set("enemyvehicle", 1);
  wing_drone.killstreaktype = "drone_squadron";
  wing_drone.identifier_weapon = getweapon("drone_squadron");
  wing_drone.var_c5bb583d = 1;
  drone_squadron.wing_drone[drone_squadron.wing_drone.size] = wing_drone;
  player.drone_squadron = drone_squadron;
  player.var_e80d9471 = 1;
  waitframe(1);
  var_91edb2b7 = drone_squadron.origin + var_3daa0416 * 128 + var_1b4e1739 * 128;
  var_91edb2b7 = getclosestpointonnavvolume(var_91edb2b7, "navvolume_small", 2000);
  wing_drone = spawnvehicle("spawner_boct_mp_wing_drone", var_91edb2b7, drone_squadron.angles, "wing_drone_ai");
  wing_drone.leader = drone_squadron;
  wing_drone setteam(drone_squadron.team);
  wing_drone.team = drone_squadron.team;
  wing_drone.formation = "left";
  wing_drone setrotorspeed(1);
  wing_drone.protectent = self;
  wing_drone.owner = player;
  wing_drone.identifier_weapon = getweapon("drone_squadron");
  wing_drone.killstreaktype = "drone_squadron";
  wing_drone.var_c5bb583d = 1;

  if(isDefined(level.var_14151f16)) {
    [[level.var_14151f16]](wing_drone, 0);
  }

  wing_drone clientfield::set("enemyvehicle", 1);
  drone_squadron.wing_drone[drone_squadron.wing_drone.size] = wing_drone;
  self killstreaks::play_killstreak_start_dialog("drone_squadron", self.team, killstreak_id);
  drone_squadron killstreaks::play_pilot_dialog_on_owner("arrive", "drone_squadron", killstreak_id);
  drone_squadron thread watchgameended();

  foreach(drone in drone_squadron.wing_drone) {
    drone callback::function_d8abfc3d(#"on_vehicle_killed", &function_c94a0c4d);
  }

  return true;
}

function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon(#"drone_squadron"), &function_bff5c062);
  }

  if(isDefined(level.var_a5dacbea)) {
    [[level.var_a5dacbea]](getweapon(#"drone_squadron"), &function_127fb8f3);
  }
}

private function_576084fa(drone, attackingplayer) {
  drone.team = attackingplayer.team;
  drone setteam(attackingplayer.team);
  drone setowner(attackingplayer);
  drone.owner = attackingplayer;
  drone.protectent = attackingplayer;
  drone clientfield::set("enemyvehicle", 2);
}

function_bff5c062(dronesquad, attackingplayer) {
  dronesquad killstreaks::configure_team_internal(attackingplayer, 1);
  function_576084fa(dronesquad, attackingplayer);

  if(!isDefined(dronesquad.wing_drone) || !isarray(dronesquad.wing_drone)) {
    return;
  }

  foreach(drone in dronesquad.wing_drone) {
    if(!isDefined(drone)) {
      continue;
    }

    function_576084fa(drone, attackingplayer);
  }

  dronesquad thread watchteamchange();
}

function_127fb8f3(dronesquad, attackingplayer) {
  dronesquad dodamage(dronesquad.health, dronesquad.origin, attackingplayer);
}

hackedcallbackpre(hacker) {
  drone_squadron = self;
  drone_squadron.owner unlink();
  drone_squadron clientfield::set("vehicletransition", 0);
}

hackedcallbackpost(hacker) {
  drone_squadron = self;
  hacker remote_weapons::useremoteweapon(drone_squadron, "drone_squadron", 0);
  drone_squadron notify(#"watchremotecontroldeactivate_remoteweapons");
  drone_squadron.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(drone_squadron);
}

configureteampost(owner, ishacked) {
  drone_squadron = self;
  drone_squadron thread watchteamchange();
}

watchgameended() {
  drone_squadron = self;
  drone_squadron endon(#"death");
  level waittill(#"game_ended");
  drone_squadron.abandoned = 1;
  drone_squadron.selfdestruct = 1;
  drone_squadron notify(#"drone_squadron_shutdown");
}

function_97bbef8(drone_squadron) {
  player = self;
  assert(isplayer(player));
  drone_squadron usevehicle(player, 0);
  drone_squadron clientfield::set("vehicletransition", 1);
  drone_squadron thread audio::sndupdatevehiclecontext(1);
  drone_squadron thread vehicle::monitor_missiles_locked_on_to_me(player);
  drone_squadron.inheliproximity = 0;
  drone_squadron.treat_owner_damage_as_friendly_fire = 0;
  drone_squadron.ignore_team_kills = 0;
  minheightoverride = undefined;
  minz_struct = struct::get_array("vehicle_oob_minz", "targetname");

  if(isDefined(minz_struct) && isDefined(minz_struct[0])) {
    minheightoverride = minz_struct[0].origin[2];
  }

  drone_squadron thread qrdrone::qrdrone_watch_distance(2000, minheightoverride);
  drone_squadron.distance_shutdown_override = &function_2d28907;
  drone_squadron.owner killstreaks::thermal_glow(1);
  player vehicle::set_vehicle_drivable_time(45000, drone_squadron.killstreak_end_time);
  visionset_mgr::activate("visionset", "drone_squadron_visionset", player, 1, 90000, 1);

  if(isDefined(drone_squadron.playerdrivenversion)) {
    drone_squadron setvehicletype(drone_squadron.playerdrivenversion);
  }
}

function_d9733cc9(drone_squadron, exitrequestedbyowner) {
  drone_squadron.treat_owner_damage_as_friendly_fire = 1;
  drone_squadron.ignore_team_kills = 1;

  if(isDefined(drone_squadron.owner)) {
    drone_squadron.owner vehicle::stop_monitor_missiles_locked_on_to_me();

    if(drone_squadron.controlled === 1) {
      visionset_mgr::deactivate("visionset", "drone_squadron_visionset", drone_squadron.owner);
    }

    if(isbot(drone_squadron.owner)) {
      drone_squadron.owner ai::set_behavior_attribute("control", "commander");
    }
  }

  params = level.killstreakbundle[#"drone_squadron"];
  shutdown_on_exit = isDefined(params.ksshutdownonexit) ? params.ksshutdownonexit : 0;

  if(exitrequestedbyowner || shutdown_on_exit) {
    if(isDefined(drone_squadron.owner)) {
      drone_squadron.owner qrdrone::destroyhud();
      drone_squadron.owner killstreaks::thermal_glow(0);
      drone_squadron.owner unlink();
      drone_squadron clientfield::set("vehicletransition", 0);
    }

    drone_squadron thread audio::sndupdatevehiclecontext(0);
  }

  if(isDefined(drone_squadron.original_vehicle_type)) {
    drone_squadron.vehicletype = drone_squadron.original_vehicle_type;
  }

  if(shutdown_on_exit) {
    drone_squadron ontimeout();
  }
}

ontimeout() {
  drone_squadron = self;
  drone_squadron.owner globallogic_audio::play_taacom_dialog("timeout", "drone_squadron");
  function_35909ca6(drone_squadron.owner);
  params = level.killstreakbundle[#"drone_squadron"];

  if(isDefined(drone_squadron.owner)) {
    radiusdamage(drone_squadron.origin, params.ksexplosionouterradius, params.ksexplosioninnerdamage, params.ksexplosionouterdamage, drone_squadron.owner, "MOD_EXPLOSIVE", getweapon("drone_squadron"));

    if(isDefined(params.ksexplosionrumble)) {
      drone_squadron.owner playrumbleonentity(params.ksexplosionrumble);
    }
  }

  drone_squadron notify(#"drone_squadron_shutdown");
}

ontimecheck() {
  self killstreaks::play_pilot_dialog_on_owner("timecheck", "drone_squadron", self.killstreak_id);
}

function_2d28907() {
  if(isDefined(self.owner)) {
    self.owner globallogic_audio::play_taacom_dialog("distanceCheck", "drone_squadron");
  }

  self notify(#"drone_squadron_shutdown");
}

function_c94a0c4d(params) {
  attacker = params.eattacker;
  weapon = params.weapon;
  attacker = self[[level.figure_out_attacker]](attacker);

  if(isDefined(attacker) && (!isDefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
    if(isplayer(attacker)) {
      scoreevents::processscoreevent(#"hash_8bf3519db5f0fd4", attacker, self.owner, weapon);
    }
  }
}

watchdeath() {
  drone_squadron = self;
  waitresult = drone_squadron waittill(#"death");
  attacker = waitresult.attacker;
  weapon = waitresult.weapon;
  modtype = waitresult.mod;
  drone_squadron notify(#"drone_squadron_shutdown");
  attacker = self[[level.figure_out_attacker]](attacker);

  if(isDefined(attacker) && (!isDefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
    if(isplayer(attacker)) {
      challenges::destroyedaircraft(attacker, weapon, drone_squadron.controlled === 1, 1);
      attacker challenges::addflyswatterstat(weapon, self);
      drone_squadron killstreaks::function_73566ec7(attacker, weapon, drone_squadron.owner);
      attacker battlechatter::function_dd6a6012("drone_squadron", weapon);

      if(modtype == "MOD_RIFLE_BULLET" || modtype == "MOD_PISTOL_BULLET") {}

      luinotifyevent(#"player_callout", 2, #"hash_32fcc2097e294f0a", attacker.entnum);
    }

    if(isDefined(drone_squadron) && isDefined(drone_squadron.owner)) {
      drone_squadron killstreaks::play_destroyed_dialog_on_owner("drone_squadron", drone_squadron.killstreak_id);
    }
  }
}

watchteamchange() {
  self notify(#"hash_7e3a7db8b681733");
  self endon(#"hash_7e3a7db8b681733");
  drone_squadron = self;
  drone_squadron endon(#"drone_squadron_shutdown");
  drone_squadron.owner waittill(#"joined_team", #"disconnect", #"joined_spectators");

  if(isDefined(drone_squadron)) {
    drone_squadron notify(#"drone_squadron_shutdown");
  }
}

watchwater() {
  drone_squadron = self;
  drone_squadron endon(#"drone_squadron_shutdown");

  while(true) {
    wait 0.1;
    trace = physicstrace(self.origin + (0, 0, 10), self.origin + (0, 0, 6), (-2, -2, -2), (2, 2, 2), self, 4);

    if(trace[#"fraction"] < 1) {
      break;
    }
  }

  drone_squadron notify(#"drone_squadron_shutdown");
}

function_89609eb8(origin, angles) {
  var_f868a6d2 = struct::get_array("drone_squadron_spawn", "targetname");

  if(isDefined(var_f868a6d2) && var_f868a6d2.size) {
    var_109e505c = arraysortclosest(var_f868a6d2, origin);
    dir = vectornormalize(origin - var_109e505c[0].origin);
    angles = vectortoangles(dir);
    return {
      #origin: var_109e505c[0].origin, 
      #angles: angles
    };
  }

  leavenode = undefined;
  assert(level.heli_startnodes.size > 0, "<dev string:x38>");
  var_581dc057 = [];

  foreach(node in level.heli_startnodes) {
    facingdir = anglesToForward(angles);

    if(!util::within_fov(origin, angles, node.origin, cos(70))) {
      array::add(var_581dc057, node);
    }
  }

  if(var_581dc057.size) {
    leavenode = array::random(var_581dc057);
  }

  if(isDefined(leavenode)) {
    spawnloc = getclosestpointonnavvolume(leavenode.origin, "navvolume_small", 2000);

    if(isDefined(spawnloc)) {

      recordline(leavenode.origin, origin, (0, 1, 1), "<dev string:x67>");
      recordline(leavenode.origin, spawnloc, (0, 0, 1), "<dev string:x67>");
      recordline(origin, spawnloc, (0, 0, 1), "<dev string:x67>");
      recordsphere(origin, 5, (1, 0, 0), "<dev string:x70>");
      recordsphere(leavenode.origin, 100, (0, 1, 1), "<dev string:x70>");
      recordsphere(spawnloc, 5, (0, 0, 1), "<dev string:x70>");

        return {
          #origin: spawnloc, 
          #angles: (0, 0, 0)
        };
    }
  }

  return undefined;
}

function_f9ec0116(drone, leavenode) {
  drone endon(#"death");
  drone.ignoreall = 1;
  drone setneargoalnotifydist(40);
  drone function_a57c34b7(leavenode.origin, 1, 1);
  drone waittilltimeout(8, #"near_goal");
  drone kill();
}

watchshutdown() {
  drone_squadron = self;
  drone_squadron waittill(#"drone_squadron_shutdown");

  if(isDefined(drone_squadron.control_initiated) && drone_squadron.control_initiated || isDefined(drone_squadron.controlled) && drone_squadron.controlled) {
    drone_squadron remote_weapons::endremotecontrolweaponuse(0);

    while(isDefined(drone_squadron.control_initiated) && drone_squadron.control_initiated || isDefined(drone_squadron.controlled) && drone_squadron.controlled) {
      waitframe(1);
    }
  }

  if(isDefined(drone_squadron.owner)) {
    drone_squadron.owner qrdrone::destroyhud();
    drone_squadron.owner killstreaks::thermal_glow(0);
  }

  killstreakrules::killstreakstop("drone_squadron", drone_squadron.originalteam, drone_squadron.killstreak_id);
  function_35909ca6(drone_squadron.owner);
  leavenode = undefined;

  if(isDefined(drone_squadron.owner)) {
    leavenode = function_89609eb8(drone_squadron.owner.origin, drone_squadron.owner.angles);
  } else {
    leavenode = function_89609eb8(drone_squadron.origin, drone_squadron.angles);
  }

  if(isDefined(leavenode)) {
    if(isalive(drone_squadron)) {
      if(isDefined(drone_squadron.wing_drone)) {
        drone_squadron.wing_drone = array::remove_undefined(drone_squadron.wing_drone);

        foreach(wing_drone in drone_squadron.wing_drone) {
          wing_drone thread function_f9ec0116(wing_drone, leavenode);
        }
      }

      drone_squadron thread function_f9ec0116(drone_squadron, leavenode);
    }

    return;
  }

  if(isalive(drone_squadron)) {
    if(isDefined(drone_squadron.wing_drone)) {
      drone_squadron.wing_drone = array::remove_undefined(drone_squadron.wing_drone);

      foreach(wing_drone in drone_squadron.wing_drone) {
        wing_drone kill();
      }
    }

    drone_squadron kill();
  }
}

function_da3b4d35() {
  self endon(#"death", #"drone_squadron_shutdown");
  self thread function_c7284de2();

  while(true) {
    self.targets = [];
    self.wing_drone = array::remove_undefined(self.wing_drone);

    if(!isDefined(self.wing_drone) || !self.wing_drone.size) {
      return;
    }

    foreach(player in util::get_players()) {
      if(player.team == self.team) {
        continue;
      }

      if(!isalive(player)) {
        continue;
      }

      direction = self.owner getplayerangles();
      direction_vec = anglesToForward(direction);
      eye_pos = self.owner getplayercamerapos();
      direction_vec = (direction_vec[0] * 5000, direction_vec[1] * 5000, direction_vec[2] * 5000);
      trace = bulletTrace(eye_pos, eye_pos + direction_vec, 1, self.owner, 1, 1, self);
      var_31491620 = trace[#"position"];
      var_468f300e = vectornormalize(anglesToForward(direction));
      var_b7e30855 = 5000 * 5000;

      if(distancesquared(eye_pos, player.origin) < var_b7e30855) {
        if(player sightconetrace(eye_pos, self.owner, var_468f300e, 8)) {
          self.targets[self.targets.size] = player;
        }
      }

      self.targets[0] = arraygetclosest(var_31491620, self.targets);
    }

    util::wait_network_frame(1);
  }
}

function_c7284de2() {
  assert(isDefined(self.owner));
  player = self.owner;
  leaddrone = self;
  player endon(#"death");
  leaddrone endon(#"death", #"drone_squadron_shutdown");
  function_47a6b2ec(player);
  function_d0eb04e9(player);
  assert(isDefined(player.var_99033e70));
  assert(isDefined(player.var_ce69b6d1));

  while(true) {
    if(isDefined(self.isstunned) && self.isstunned) {
      waitframe(1);
      continue;
    }

    if(!isDefined(player.var_bfbfc356)) {
      function_d43ba50b(player, undefined);
      function_410e488d(leaddrone, undefined);
    } else if(!isalive(player.var_bfbfc356)) {
      function_d43ba50b(player, undefined);
      function_410e488d(leaddrone, undefined);
    } else if(!function_74ceb0a5(leaddrone)) {
      function_d43ba50b(player, undefined);
      function_410e488d(leaddrone, undefined);
    }

    if(isDefined(player.var_49c8cc7f) && !isalive(player.var_49c8cc7f)) {
      function_bef71297(player, undefined);
    } else if(isDefined(leaddrone.targets) && !leaddrone.targets.size) {
      function_bef71297(player, undefined);
    }

    if(isDefined(leaddrone.targets) && leaddrone.targets.size && isDefined(leaddrone.targets[0])) {
      if(isDefined(player.var_bfbfc356) && player.var_bfbfc356 == leaddrone.targets[0]) {
        waitframe(1);
        continue;
      }
    }

    if(isDefined(leaddrone.targets) && leaddrone.targets.size && isDefined(leaddrone.targets[0]) && isalive(leaddrone.targets[0])) {
      function_bef71297(player, leaddrone.targets[0]);
    }

    if(player jumpbuttonpressed()) {
      if(isDefined(leaddrone.targets) && leaddrone.targets.size > 0) {
        function_410e488d(leaddrone, leaddrone.targets[0]);
        function_bef71297(player, undefined);
        function_d43ba50b(player, leaddrone.targets[0]);
      }
    }

    util::wait_network_frame(1);
  }
}

private function_410e488d(leaddrone, target) {
  foreach(drone in leaddrone.wing_drone) {
    if(isDefined(drone)) {
      drone.favoriteenemy = target;
    }
  }
}

private function_74ceb0a5(leaddrone) {
  var_c479f7cf = leaddrone.wing_drone.size;
  validcount = 0;

  foreach(drone in leaddrone.wing_drone) {
    if(isDefined(drone) && isDefined(drone.favoriteenemy)) {
      validcount++;
    }
  }

  if(validcount >= var_c479f7cf) {
    return true;
  }

  return false;
}

private function_47a6b2ec(player) {
  player.var_99033e70 = gameobjects::get_next_obj_id();
  objective_add(player.var_99033e70, "active", undefined, #"hash_19883df3d28a354a");
  objective_setprogress(player.var_99033e70, 1);
  function_da7940a3(player.var_99033e70, 1);
  objective_setinvisibletoall(player.var_99033e70);
}

private function_bef71297(player, target) {
  assert(isDefined(player.var_99033e70));

  if(isDefined(target)) {
    player.var_49c8cc7f = target;
    objective_onentity(player.var_99033e70, target);
    objective_setvisibletoplayer(player.var_99033e70, player);
    return;
  }

  player.var_49c8cc7f = undefined;
  objective_clearentity(player.var_99033e70);
  objective_setinvisibletoall(player.var_99033e70);
}

private function_d0eb04e9(player) {
  player.var_ce69b6d1 = gameobjects::get_next_obj_id();
  objective_add(player.var_ce69b6d1, "active", undefined, #"hash_247ae058537c8726");
  objective_setprogress(player.var_ce69b6d1, 1);
  function_da7940a3(player.var_ce69b6d1, 1);
  objective_setinvisibletoall(player.var_ce69b6d1);
}

private function_d43ba50b(player, target) {
  assert(isDefined(player.var_ce69b6d1));

  if(isDefined(target)) {
    player.var_bfbfc356 = target;
    objective_onentity(player.var_ce69b6d1, target);
    objective_setvisibletoplayer(player.var_ce69b6d1, player);
    return;
  }

  player.var_bfbfc356 = undefined;
  objective_clearentity(player.var_ce69b6d1);
  objective_setinvisibletoall(player.var_ce69b6d1);
}

private function_35909ca6(player) {
  if(isDefined(player.var_ce69b6d1)) {
    objective_delete(player.var_ce69b6d1);
    gameobjects::release_obj_id(player.var_ce69b6d1);
    player.var_bfbfc356 = undefined;
    player.var_ce69b6d1 = undefined;
  }

  if(isDefined(player.var_99033e70)) {
    objective_delete(player.var_99033e70);
    gameobjects::release_obj_id(player.var_99033e70);
    player.var_49c8cc7f = undefined;
    player.var_99033e70 = undefined;
  }

  player.var_e80d9471 = undefined;
}

private function_a9737855(params) {
  player = self;

  if(isDefined(player.var_e80d9471) && player.var_e80d9471) {
    function_35909ca6(player);
  }
}