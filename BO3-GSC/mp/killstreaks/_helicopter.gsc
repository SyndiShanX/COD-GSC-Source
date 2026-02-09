/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_helicopter.gsc
*************************************************/

#using scripts\mp\_challenges;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_player;
#using scripts\mp\gametypes\_hostmigration;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\killstreaks\_airsupport;
#using scripts\mp\killstreaks\_dogs;
#using scripts\mp\killstreaks\_flak_drone;
#using scripts\mp\killstreaks\_killstreak_bundles;
#using scripts\mp\killstreaks\_killstreak_detect;
#using scripts\mp\killstreaks\_killstreak_hacking;
#using scripts\mp\killstreaks\_killstreakrules;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\tweakables_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_heatseekingmissile;
#using scripts\shared\weapons\_weaponobjects;
#using_animtree("mp_vehicles");
#namespace helicopter;

function precachehelicopter(model, type = "blackhawk") {
  level.vehicle_deathmodel[model] = model;
  level.heli_sound["hit"] = "evt_helicopter_hit";
  level.heli_sound["hitsecondary"] = "evt_helicopter_hit";
  level.heli_sound["damaged"] = "null";
  level.heli_sound["spinloop"] = "evt_helicopter_spin_loop";
  level.heli_sound["spinstart"] = "evt_helicopter_spin_start";
  level.heli_sound["crash"] = "evt_helicopter_midair_exp";
  level.heli_sound["missilefire"] = "wpn_hellfire_fire_npc";
}

function usekillstreakhelicopter(hardpointtype) {
  if(self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
    return false;
  }
  if(!isDefined(level.heli_paths) || !level.heli_paths.size) {
    iprintlnbold("");
    return false;
  }
  if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
    result = self selecthelicopterlocation(hardpointtype);
    if(!isDefined(result) || result == 0) {
      return false;
    }
  }
  destination = 0;
  missilesenabled = 0;
  if(hardpointtype == "helicopter_x2") {
    missilesenabled = 1;
  }
  assert(level.heli_paths.size > 0, "");
  random_path = randomint(level.heli_paths[destination].size);
  startnode = level.heli_paths[destination][random_path];
  protectlocation = undefined;
  armored = 0;
  if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
    protectlocation = (level.helilocation[0], level.helilocation[1], int(airsupport::getminimumflyheight()) - 200);
    armored = 0;
    startnode = getvalidprotectlocationstart(random_path, protectlocation, destination);
  }
  killstreak_id = self killstreakrules::killstreakstart(hardpointtype, self.team);
  if(killstreak_id == -1) {
    return false;
  }
  if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
    self challenges::calledincomlinkchopper();
  }
  self killstreaks::play_killstreak_start_dialog(hardpointtype, self.team, killstreak_id);
  self thread announcehelicopterinbound(hardpointtype);
  thread heli_think(self, startnode, self.team, missilesenabled, protectlocation, hardpointtype, armored, killstreak_id);
  return true;
}

function announcehelicopterinbound(hardpointtype) {
  team = self.team;
  self addweaponstat(killstreaks::get_killstreak_weapon(hardpointtype), "used", 1);
}

function heli_path_graph() {
  path_start = getEntArray("heli_start", "targetname");
  path_dest = getEntArray("heli_dest", "targetname");
  loop_start = getEntArray("heli_loop_start", "targetname");
  gunner_loop_start = getEntArray("heli_gunner_loop_start", "targetname");
  leave_nodes = getEntArray("heli_leave", "targetname");
  crash_start = getEntArray("heli_crash_start", "targetname");
  assert(isDefined(path_start) && isDefined(path_dest), "");
  for(i = 0; i < path_dest.size; i++) {
    startnode_array = [];
    isprimarydest = 0;
    destnode_pointer = path_dest[i];
    destnode = getent(destnode_pointer.target, "targetname");
    for(j = 0; j < path_start.size; j++) {
      todest = 0;
      currentnode = path_start[j];
      while(isDefined(currentnode.target)) {
        nextnode = getent(currentnode.target, "targetname");
        if(nextnode.origin == destnode.origin) {
          todest = 1;
          break;
        }
        airsupport::debug_print3d_simple("+", currentnode, vectorscale((0, 0, -1), 10));
        if(isDefined(nextnode.target)) {
          airsupport::debug_line(nextnode.origin, getent(nextnode.target, "targetname").origin, (0.25, 0.5, 0.25), 5);
        }
        if(isDefined(currentnode.script_delay)) {
          airsupport::debug_print3d_simple("Wait: " + currentnode.script_delay, currentnode, vectorscale((0, 0, 1), 10));
        }
        currentnode = nextnode;
      }
      if(todest) {
        startnode_array[startnode_array.size] = getent(path_start[j].target, "targetname");
        if(isDefined(path_start[j].script_noteworthy) && path_start[j].script_noteworthy == "primary") {
          isprimarydest = 1;
        }
      }
    }
    assert(isDefined(startnode_array) && startnode_array.size > 0, "");
    if(isprimarydest) {
      level.heli_primary_path = startnode_array;
      continue;
    }
    level.heli_paths[level.heli_paths.size] = startnode_array;
  }
  for(i = 0; i < loop_start.size; i++) {
    startnode = getent(loop_start[i].target, "targetname");
    level.heli_loop_paths[level.heli_loop_paths.size] = startnode;
  }
  assert(isDefined(level.heli_loop_paths[0]), "");
  for(i = 0; i < gunner_loop_start.size; i++) {
    startnode = getent(gunner_loop_start[i].target, "targetname");
    startnode.isgunnerpath = 1;
    level.heli_loop_paths[level.heli_loop_paths.size] = startnode;
  }
  for(i = 0; i < path_start.size; i++) {
    if(isDefined(path_start[i].script_noteworthy) && path_start[i].script_noteworthy == "primary") {
      continue;
    }
    level.heli_startnodes[level.heli_startnodes.size] = path_start[i];
  }
  assert(isDefined(level.heli_startnodes[0]), "");
  for(i = 0; i < leave_nodes.size; i++) {
    level.heli_leavenodes[level.heli_leavenodes.size] = leave_nodes[i];
  }
  assert(isDefined(level.heli_leavenodes[0]), "");
  for(i = 0; i < crash_start.size; i++) {
    crash_start_node = getent(crash_start[i].target, "targetname");
    level.heli_crash_paths[level.heli_crash_paths.size] = crash_start_node;
  }
  assert(isDefined(level.heli_crash_paths[0]), "");
}

function init() {
  path_start = getEntArray("heli_start", "targetname");
  loop_start = getEntArray("heli_loop_start", "targetname");
  debug_refresh = 1;
  thread heli_update_global_dvars(debug_refresh);
  level.chaff_offset["attack"] = (-130, 0, -140);
  level.choppercomlinkfriendly = "veh_t7_drone_hunter";
  level.choppercomlinkenemy = "veh_t7_drone_hunter";
  level.chopperregular = "veh_t7_drone_hunter";
  precachehelicopter(level.chopperregular);
  precachehelicopter(level.choppercomlinkfriendly);
  precachehelicopter(level.choppercomlinkenemy);
  clientfield::register("helicopter", "heli_comlink_bootup_anim", 1, 1, "int");
  clientfield::register("helicopter", "heli_warn_targeted", 1, 1, "int");
  clientfield::register("helicopter", "heli_warn_locked", 1, 1, "int");
  clientfield::register("helicopter", "heli_warn_fired", 1, 1, "int");
  clientfield::register("helicopter", "active_camo", 1, 3, "int");
  clientfield::register("vehicle", "heli_comlink_bootup_anim", 1, 1, "int");
  clientfield::register("vehicle", "heli_warn_targeted", 1, 1, "int");
  clientfield::register("vehicle", "heli_warn_locked", 1, 1, "int");
  clientfield::register("vehicle", "heli_warn_fired", 1, 1, "int");
  clientfield::register("vehicle", "active_camo", 1, 3, "int");
  level.heli_paths = [];
  level.heli_loop_paths = [];
  level.heli_startnodes = [];
  level.heli_leavenodes = [];
  level.heli_crash_paths = [];
  level.last_start_node_index = 0;
  level.chopper_fx["explode"]["death"] = "killstreaks/fx_heli_exp_lg";
  level.chopper_fx["explode"]["guard"] = "killstreaks/fx_heli_exp_md";
  level.chopper_fx["explode"]["gunner"] = "killstreaks/fx_vtol_exp";
  level.chopper_fx["explode"]["large"] = "killstreaks/fx_heli_exp_sm";
  level.chopper_fx["damage"]["light_smoke"] = "killstreaks/fx_heli_smk_trail_engine_33";
  level.chopper_fx["damage"]["heavy_smoke"] = "killstreaks/fx_heli_smk_trail_engine_66";
  level.chopper_fx["smoke"]["trail"] = "killstreaks/fx_heli_smk_trail_tail";
  level.chopper_fx["fire"]["trail"]["large"] = "killstreaks/fx_heli_smk_trail_engine";
  level._effect["heli_comlink_light"]["friendly"] = "_debug/fx_debug_deleted_fx";
  level._effect["heli_comlink_light"]["enemy"] = "_debug/fx_debug_deleted_fx";
  level.helicomlinkbootupanim = % mp_vehicles::veh_anim_future_heli_gearup_bay_open;
  killstreaks::register("helicopter_comlink", "helicopter_comlink", "killstreak_helicopter_comlink", "helicopter_used", &usekillstreakhelicopter, 1);
  killstreaks::register_strings("helicopter_comlink", &"KILLSTREAK_EARNED_HELICOPTER_COMLINK", &"KILLSTREAK_HELICOPTER_COMLINK_NOT_AVAILABLE", &"KILLSTREAK_HELICOPTER_COMLINK_INBOUND", undefined, &"KILLSTREAK_HELICOPTER_COMLINK_HACKED");
  killstreaks::register_dialog("helicopter_comlink", "mpl_killstreak_heli", "helicopterDialogBundle", "helicopterPilotDialogBundle", "friendlyHelicopter", "enemyHelicopter", "enemyHelicopterMultiple", "friendlyHelicopterHacked", "enemyHelicopterHacked", "requestHelicopter", "threatHelicopter");
  killstreaks::register_alt_weapon("helicopter_comlink", "cobra_20mm_comlink");
  killstreaks::set_team_kill_penalty_scale("helicopter_comlink", 0);
  level.killstreaks["helicopter_comlink"].threatonkill = 1;
  level.killstreaks["inventory_helicopter_comlink"].threatonkill = 1;
  if(!path_start.size && !loop_start.size) {
    return;
  }
  heli_path_graph();
}

function heli_update_global_dvars(debug_refresh) {
  do {
    level.heli_loopmax = heli_get_dvar_int("scr_heli_loopmax", "2");
    level.heli_missile_rof = heli_get_dvar_int("scr_heli_missile_rof", "2");
    level.heli_armor = heli_get_dvar_int("scr_heli_armor", "500");
    level.heli_maxhealth = heli_get_dvar_int("scr_heli_maxhealth", "2000");
    level.heli_amored_maxhealth = heli_get_dvar_int("scr_heli_armored_maxhealth", "1500");
    level.heli_missile_max = heli_get_dvar_int("scr_heli_missile_max", "20");
    level.heli_dest_wait = heli_get_dvar_int("scr_heli_dest_wait", "8");
    level.heli_debug = heli_get_dvar_int("scr_heli_debug", "0");
    level.heli_debug_crash = heli_get_dvar_int("scr_heli_debug_crash", "0");
    level.heli_targeting_delay = heli_get_dvar("scr_heli_targeting_delay", "0.6");
    level.heli_turretreloadtime = heli_get_dvar("scr_heli_turretReloadTime", "0.5");
    level.heli_turretclipsize = heli_get_dvar_int("scr_heli_turretClipSize", "80");
    level.heli_visual_range = (isDefined(level.heli_visual_range_override) ? level.heli_visual_range_override : heli_get_dvar_int("scr_heli_visual_range", "3500"));
    level.heli_missile_range = heli_get_dvar_int("scr_heli_missile_range", "100000");
    level.heli_health_degrade = heli_get_dvar_int("scr_heli_health_degrade", "0");
    level.heli_turret_angle_tan = heli_get_dvar_int("scr_heli_turret_angle_tan", "1");
    level.heli_turret_target_cone = heli_get_dvar("scr_heli_turret_target_cone", "0.6");
    level.heli_target_spawnprotection = heli_get_dvar_int("scr_heli_target_spawnprotection", "5");
    level.heli_missile_regen_time = heli_get_dvar("scr_heli_missile_regen_time", "10");
    level.heli_turret_spinup_delay = heli_get_dvar("scr_heli_turret_spinup_delay", "1.0");
    level.heli_target_recognition = heli_get_dvar("scr_heli_target_recognition", "0.3");
    level.heli_missile_friendlycare = heli_get_dvar_int("scr_heli_missile_friendlycare", "512");
    level.heli_missile_target_cone = heli_get_dvar("scr_heli_missile_target_cone", "0.6");
    level.heli_valid_target_cone = heli_get_dvar("scr_heli_missile_valid_target_cone", "0.7");
    level.heli_armor_bulletdamage = heli_get_dvar("scr_heli_armor_bulletdamage", "0.5");
    level.heli_attract_strength = heli_get_dvar("scr_heli_attract_strength", "1000");
    level.heli_attract_range = heli_get_dvar("scr_heli_attract_range", "20000");
    level.helicopterturretmaxangle = heli_get_dvar_int("scr_helicopterTurretMaxAngle", "35");
    level.heli_protect_time = heli_get_dvar("scr_heli_protect_time", "60");
    level.heli_protect_pos_time = heli_get_dvar("scr_heli_protect_pos_time", "12");
    level.heli_protect_radius = heli_get_dvar_int("scr_heli_protect_radius", "2000");
    level.heli_missile_reload_time = heli_get_dvar("scr_heli_missile_reload_time", "5.0");
    level.heli_warning_distance = heli_get_dvar_int("scr_heli_warning_distance", "500");
    wait(1);
  }
  while(isDefined(debug_refresh));
}

function heli_get_dvar_int(dvar, def) {
  return int(heli_get_dvar(dvar, def));
}

function heli_get_dvar(dvar, def) {
  if(getdvarstring(dvar) != "") {
    return getdvarfloat(dvar);
  }
  setDvar(dvar, def);
  return float(def);
}

function set_goal_pos(goalpos, stop) {
  self.heligoalpos = goalpos;
  self setvehgoalpos(goalpos, stop);
}

function spawn_helicopter(owner, origin, angles, model, targetname, target_offset, hardpointtype, killstreak_id) {
  chopper = spawnhelicopter(owner, origin, angles, model, targetname);
  chopper.owner = owner;
  chopper clientfield::set("enemyvehicle", 1);
  chopper.attackers = [];
  chopper.attackerdata = [];
  chopper.attackerdamage = [];
  chopper.flareattackerdamage = [];
  chopper.destroyfunc = &destroyhelicopter;
  chopper.hardpointtype = hardpointtype;
  chopper.killstreak_id = killstreak_id;
  chopper.pilotistalking = 0;
  chopper setdrawinfrared(1);
  chopper.allowcontinuedlockonafterinvis = 1;
  chopper.soundmod = "heli";
  if(!isDefined(target_offset)) {
    target_offset = (0, 0, 0);
  }
  chopper.target_offset = target_offset;
  target_set(chopper, target_offset);
  if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
    chopper.allowhackingaftercloak = 1;
    chopper.flak_drone = flak_drone::spawn(chopper, &onflakdronedestroyed);
    chopper.treat_owner_damage_as_friendly_fire = 1;
    chopper.ignore_team_kills = 1;
    chopper init_active_camo();
  }
  return chopper;
}

function onflakdronedestroyed() {
  chopper = self;
  if(!isDefined(chopper)) {
    return;
  }
  chopper.numflares = 0;
  chopper killstreaks::play_pilot_dialog_on_owner("weaponDestroyed", "helicopter_comlink", chopper.killstreak_id);
  chopper thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
}

function explodeoncontact(hardpointtype) {
  self endon("death");
  wait(10);
  for(;;) {
    self waittill("touch");
    self thread heli_explode();
  }
}

function getvalidprotectlocationstart(random_path, protectlocation, destination) {
  startnode = level.heli_paths[destination][random_path];
  path_index = (random_path + 1) % level.heli_paths[destination].size;
  innofly = airsupport::crossesnoflyzone(protectlocation + (0, 0, 1), protectlocation);
  if(isDefined(innofly)) {
    protectlocation = (protectlocation[0], protectlocation[1], level.noflyzones[innofly].origin[2] + level.noflyzones[innofly].height);
  }
  noflyzone = airsupport::crossesnoflyzone(startnode.origin, protectlocation);
  while(isDefined(noflyzone) && path_index != random_path) {
    startnode = level.heli_paths[destination][path_index];
    if(isDefined(noflyzone)) {
      path_index = (path_index + 1) % level.heli_paths[destination].size;
    }
  }
  return level.heli_paths[destination][path_index];
}

function getvalidrandomleavenode(start) {
  if(self === level.vtol) {
    foreach(node in level.heli_leavenodes) {
      if(isDefined(node.script_noteworthy) && node.script_noteworthy == "primary") {
        return node;
      }
    }
  }
  random_leave_node = randomint(level.heli_leavenodes.size);
  leavenode = level.heli_leavenodes[random_leave_node];
  path_index = (random_leave_node + 1) % level.heli_leavenodes.size;
  noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
  isprimary = leavenode.script_noteworthy === "primary";
  while(isDefined(noflyzone) || isprimary && path_index != random_leave_node) {
    leavenode = level.heli_leavenodes[path_index];
    noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
    isprimary = leavenode.script_noteworthy === "primary";
    path_index = (path_index + 1) % level.heli_leavenodes.size;
  }
  return level.heli_leavenodes[path_index];
}

function getvalidrandomstartnode(dest) {
  path_index = randomint(level.heli_startnodes.size);
  best_index = path_index;
  count = 0;
  for(i = 0; i < level.heli_startnodes.size; i++) {
    startnode = level.heli_startnodes[path_index];
    noflyzone = airsupport::crossesnoflyzone(startnode.origin, dest);
    if(!isDefined(noflyzone)) {
      best_index = path_index;
      if(path_index != level.last_start_node_index) {
        break;
      }
    }
    path_index = (path_index + 1) % level.heli_startnodes.size;
  }
  level.last_start_node_index = best_index;
  return level.heli_startnodes[best_index];
}

function getvalidrandomcrashnode(start) {
  random_leave_node = randomint(level.heli_crash_paths.size);
  leavenode = level.heli_crash_paths[random_leave_node];
  path_index = (random_leave_node + 1) % level.heli_crash_paths.size;
  noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
  while(isDefined(noflyzone) && path_index != random_leave_node) {
    leavenode = level.heli_crash_paths[path_index];
    noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
    path_index = (path_index + 1) % level.heli_crash_paths.size;
  }
  return level.heli_crash_paths[path_index];
}

function configureteampost(owner, ishacked) {
  chopper = self;
  owner thread watchforearlyleave(chopper);
}

function hackedcallbackpost(hacker) {
  heli = self;
  if(isDefined(heli.flak_drone)) {
    heli.flak_drone flak_drone::configureteam(heli, 1);
  }
  heli.endtime = gettime() + (killstreak_bundles::get_hack_timeout() * 1000);
  heli.killstreakendtime = int(heli.endtime);
}

function heli_think(owner, startnode, heli_team, missilesenabled, protectlocation, hardpointtype, armored, killstreak_id) {
  heliorigin = startnode.origin;
  heliangles = startnode.angles;
  if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
    choppermodelfriendly = level.choppercomlinkfriendly;
    choppermodelenemy = level.choppercomlinkenemy;
  } else {
    choppermodelfriendly = level.chopperregular;
    choppermodelenemy = level.chopperregular;
  }
  chopper = spawn_helicopter(owner, heliorigin, heliangles, "heli_ai_mp", choppermodelfriendly, vectorscale((0, 0, 1), 100), hardpointtype, killstreak_id);
  chopper.harpointtype = hardpointtype;
  chopper killstreaks::configure_team(hardpointtype, killstreak_id, owner, "helicopter", undefined, &configureteampost);
  if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
    chopper killstreak_hacking::enable_hacking("helicopter_comlink", undefined, &hackedcallbackpost);
  }
  chopper setenemymodel(choppermodelenemy);
  chopper thread watchforemp();
  target_setturretaquire(chopper, 0);
  chopper thread samturretwatcher();
  if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
    chopper.defaultweapon = getweapon("cobra_20mm_comlink");
  } else {
    chopper.defaultweapon = getweapon("cobra_20mm");
  }
  chopper.requireddeathcount = owner.deathcount;
  chopper.chaff_offset = level.chaff_offset["attack"];
  minigun_snd_ent = spawn("script_origin", chopper gettagorigin("tag_flash"));
  minigun_snd_ent linkto(chopper, "tag_flash", (0, 0, 0), (0, 0, 0));
  chopper.minigun_snd_ent = minigun_snd_ent;
  minigun_snd_ent thread autostopsound();
  chopper thread heli_existance();
  level.chopper = chopper;
  chopper.reached_dest = 0;
  if(armored) {
    chopper.maxhealth = level.heli_amored_maxhealth;
  } else {
    chopper.maxhealth = level.heli_maxhealth;
  }
  chopper.rocketdamageoneshot = level.heli_maxhealth + 1;
  chopper.rocketdamagetwoshot = (level.heli_maxhealth / 2) + 1;
  if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
    chopper.numflares = 0;
  } else {
    if(hardpointtype == "helicopter_guard") {
      chopper.numflares = 1;
    } else {
      chopper.numflares = 2;
    }
  }
  chopper.flareoffset = vectorscale((0, 0, -1), 256);
  chopper.waittime = level.heli_dest_wait;
  chopper.loopcount = 0;
  chopper.evasive = 0;
  chopper.health_bulletdamageble = level.heli_armor;
  chopper.health_evasive = level.heli_armor;
  chopper.targeting_delay = level.heli_targeting_delay;
  chopper.primarytarget = undefined;
  chopper.secondarytarget = undefined;
  chopper.attacker = undefined;
  chopper.missile_ammo = level.heli_missile_max;
  chopper.currentstate = "ok";
  chopper.lastrocketfiretime = -1;
  if(isDefined(protectlocation)) {
    chopper thread heli_protect(startnode, protectlocation, hardpointtype, heli_team);
    chopper clientfield::set("heli_comlink_bootup_anim", 1);
  } else {
    chopper thread heli_fly(startnode, 2, hardpointtype);
  }
  chopper thread heli_damage_monitor(hardpointtype);
  chopper thread wait_for_killed();
  chopper thread heli_health(hardpointtype);
  chopper thread attack_targets(missilesenabled, hardpointtype);
  chopper thread heli_targeting(missilesenabled, hardpointtype);
  chopper thread heli_missile_regen();
  if(hardpointtype != "helicopter_comlink") {
    chopper thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
    chopper thread create_flare_ent(vectorscale((0, 0, -1), 100));
  }
}

function autostopsound() {
  self endon("death");
  level waittill("game_ended");
  self stoploopsound();
}

function heli_existance() {
  self waittill("leaving");
  self spawning::remove_influencers();
}

function create_flare_ent(offset) {
  self.flare_ent = spawn("script_model", self gettagorigin("tag_origin"));
  self.flare_ent setModel("tag_origin");
  self.flare_ent linkto(self, "tag_origin", offset);
}

function heli_missile_regen() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  for(;;) {
    airsupport::debug_print3d("Missile Ammo: " + self.missile_ammo, (0.5, 0.5, 1), self, vectorscale((0, 0, -1), 100), 0);
    if(self.missile_ammo >= level.heli_missile_max) {
      self waittill("hash_b0c5ea03");
    } else {
      if(self.currentstate == "heavy smoke") {
        wait(level.heli_missile_regen_time / 4);
      } else {
        if(self.currentstate == "light smoke") {
          wait(level.heli_missile_regen_time / 2);
        } else {
          wait(level.heli_missile_regen_time);
        }
      }
    }
    if(self.missile_ammo < level.heli_missile_max) {
      self.missile_ammo++;
    }
  }
}

function heli_targeting(missilesenabled, hardpointtype) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  for(;;) {
    targets = [];
    targetsmissile = [];
    players = level.players;
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(self cantargetplayer_turret(player, hardpointtype)) {
        if(isDefined(player)) {
          targets[targets.size] = player;
        }
      }
      if(missilesenabled && self cantargetplayer_missile(player, hardpointtype)) {
        if(isDefined(player)) {
          targetsmissile[targetsmissile.size] = player;
        }
        continue;
      }
      continue;
    }
    dogs = dogs::dog_manager_get_dogs();
    foreach(dog in dogs) {
      if(self cantargetdog_turret(dog)) {
        targets[targets.size] = dog;
      }
      if(missilesenabled && self cantargetdog_missile(dog)) {
        targetsmissile[targetsmissile.size] = dog;
      }
    }
    tanks = getEntArray("talon", "targetname");
    tanks = arraycombine(tanks, getEntArray("siegebot", "targetname"), 0, 0);
    foreach(tank in tanks) {
      if(self cantargettank_turret(tank)) {
        targets[targets.size] = tank;
      }
    }
    actors = getactorarray();
    foreach(actor in actors) {
      if(isDefined(actor) && isDefined(actor.isaiclone) && isalive(actor)) {
        if(self cantargetactor_turret(actor, hardpointtype)) {
          targets[targets.size] = actor;
        }
      }
    }
    if(targets.size == 0 && targetsmissile.size == 0) {
      self.primarytarget = undefined;
      self.secondarytarget = undefined;
      debug_print_target();
      self setgoalyaw(randomint(360));
      wait(self.targeting_delay);
      continue;
    }
    if(targets.size == 1) {
      if(isDefined(targets[0].isaiclone)) {
        killstreaks::update_actor_threat(targets[0]);
      } else {
        if(isDefined(targets[0].type) && (targets[0].type == "dog" || targets[0].type == "tank_drone")) {
          killstreaks::update_dog_threat(targets[0]);
        } else {
          if(isDefined(targets[0].killstreaktype)) {
            killstreaks::update_non_player_threat(targets[0]);
          } else {
            killstreaks::update_player_threat(targets[0]);
          }
        }
      }
      self.primarytarget = targets[0];
      self notify("hash_907788c7");
      self.secondarytarget = undefined;
      debug_print_target();
    } else if(targets.size > 1) {
      assignprimarytargets(targets);
    }
    if(targetsmissile.size == 1) {
      if(!isDefined(targetsmissile[0].type) || targetsmissile[0].type != "dog" || targets[0].type == "tank_drone") {
        self killstreaks::update_missile_player_threat(targetsmissile[0]);
      } else if(targetsmissile[0].type == "dog") {
        self killstreaks::update_missile_dog_threat(targetsmissile[0]);
      }
      self.secondarytarget = targetsmissile[0];
      self notify("hash_519af70b");
      debug_print_target();
    } else if(targetsmissile.size > 1) {
      assignsecondarytargets(targetsmissile);
    }
    wait(self.targeting_delay);
    debug_print_target();
  }
}

function cantargetplayer_turret(player, hardpointtype) {
  cantarget = 1;
  if(!isalive(player) || player.sessionstate != "playing") {
    return 0;
  }
  if(player.ignoreme === 1) {
    return 0;
  }
  if(player == self.owner) {
    self check_owner(hardpointtype);
    return 0;
  }
  if(player airsupport::cantargetplayerwithspecialty() == 0) {
    return 0;
  }
  if(distance(player.origin, self.origin) > level.heli_visual_range) {
    return 0;
  }
  if(!isDefined(player.team)) {
    return 0;
  }
  if(level.teambased && player.team == self.team) {
    return 0;
  }
  if(player.team == "spectator") {
    return 0;
  }
  if(isDefined(player.spawntime) && ((gettime() - player.spawntime) / 1000) <= level.heli_target_spawnprotection) {
    return 0;
  }
  heli_centroid = self.origin + (vectorscale((0, 0, -1), 160));
  heli_forward_norm = anglesToForward(self.angles);
  heli_turret_point = heli_centroid + (144 * heli_forward_norm);
  visible_amount = player sightconetrace(heli_turret_point, self);
  if(visible_amount < level.heli_target_recognition) {
    return 0;
  }
  return cantarget;
}

function cantargetactor_turret(actor, hardpointtype) {
  helicopter = self;
  cantarget = 1;
  if(!isalive(actor)) {
    return actor;
  }
  if(!isDefined(actor.team)) {
    return 0;
  }
  if(level.teambased && actor.team == helicopter.team) {
    return 0;
  }
  if(distancesquared(actor.origin, helicopter.origin) > (level.heli_visual_range * level.heli_visual_range)) {
    return 0;
  }
  heli_centroid = helicopter.origin + (vectorscale((0, 0, -1), 160));
  heli_forward_norm = anglesToForward(helicopter.angles);
  heli_turret_point = heli_centroid + (144 * heli_forward_norm);
  visible_amount = actor sightconetrace(heli_turret_point, helicopter);
  if(visible_amount < level.heli_target_recognition) {
    return 0;
  }
  return cantarget;
}

function getverticaltan(startorigin, endorigin) {
  vector = endorigin - startorigin;
  opposite = startorigin[2] - endorigin[2];
  if(opposite < 0) {
    opposite = opposite * 1;
  }
  adjacent = distance2d(startorigin, endorigin);
  if(adjacent < 0) {
    adjacent = adjacent * 1;
  }
  if(adjacent < 0.01) {
    adjacent = 0.01;
  }
  tangent = opposite / adjacent;
  return tangent;
}

function cantargetplayer_missile(player, hardpointtype) {
  cantarget = 1;
  if(!isalive(player) || player.sessionstate != "playing") {
    return 0;
  }
  if(player.ignoreme === 1) {
    return 0;
  }
  if(player == self.owner) {
    self check_owner(hardpointtype);
    return 0;
  }
  if(player airsupport::cantargetplayerwithspecialty() == 0) {
    return 0;
  }
  if(distance(player.origin, self.origin) > level.heli_missile_range) {
    return 0;
  }
  if(!isDefined(player.team)) {
    return 0;
  }
  if(level.teambased && player.team == self.team) {
    return 0;
  }
  if(player.team == "spectator") {
    return 0;
  }
  if(isDefined(player.spawntime) && ((gettime() - player.spawntime) / 1000) <= level.heli_target_spawnprotection) {
    return 0;
  }
  if(self target_cone_check(player, level.heli_missile_target_cone) == 0) {
    return 0;
  }
  heli_centroid = self.origin + (vectorscale((0, 0, -1), 160));
  heli_forward_norm = anglesToForward(self.angles);
  heli_turret_point = heli_centroid + (144 * heli_forward_norm);
  if(!isDefined(player.lasthit)) {
    player.lasthit = 0;
  }
  player.lasthit = self heliturretsighttrace(heli_turret_point, player, player.lasthit);
  if(player.lasthit != 0) {
    return 0;
  }
  return cantarget;
}

function cantargetdog_turret(dog) {
  cantarget = 1;
  if(!isDefined(dog)) {
    return 0;
  }
  if(distance(dog.origin, self.origin) > level.heli_visual_range) {
    return 0;
  }
  if(!isDefined(dog.team)) {
    return 0;
  }
  if(level.teambased && dog.team == self.team) {
    return 0;
  }
  if(isDefined(dog.script_owner) && self.owner == dog.script_owner) {
    return 0;
  }
  heli_centroid = self.origin + (vectorscale((0, 0, -1), 160));
  heli_forward_norm = anglesToForward(self.angles);
  heli_turret_point = heli_centroid + (144 * heli_forward_norm);
  if(!isDefined(dog.lasthit)) {
    dog.lasthit = 0;
  }
  dog.lasthit = self heliturretdogtrace(heli_turret_point, dog, dog.lasthit);
  if(dog.lasthit != 0) {
    return 0;
  }
  return cantarget;
}

function cantargetdog_missile(dog) {
  cantarget = 1;
  if(!isDefined(dog)) {
    return 0;
  }
  if(distance(dog.origin, self.origin) > level.heli_missile_range) {
    return 0;
  }
  if(!isDefined(dog.team)) {
    return 0;
  }
  if(level.teambased && dog.team == self.team) {
    return 0;
  }
  if(isDefined(dog.script_owner) && self.owner == dog.script_owner) {
    return 0;
  }
  heli_centroid = self.origin + (vectorscale((0, 0, -1), 160));
  heli_forward_norm = anglesToForward(self.angles);
  heli_turret_point = heli_centroid + (144 * heli_forward_norm);
  if(!isDefined(dog.lasthit)) {
    dog.lasthit = 0;
  }
  dog.lasthit = self heliturretdogtrace(heli_turret_point, dog, dog.lasthit);
  if(dog.lasthit != 0) {
    return 0;
  }
  return cantarget;
}

function cantargettank_turret(tank) {
  cantarget = 1;
  if(!isDefined(tank)) {
    return 0;
  }
  if(tank.ignoreme === 1) {
    return 0;
  }
  if(distance(tank.origin, self.origin) > level.heli_visual_range) {
    return 0;
  }
  if(!isDefined(tank.team)) {
    return 0;
  }
  if(level.teambased && tank.team == self.team) {
    return 0;
  }
  if(isDefined(tank.owner) && self.owner == tank.owner) {
    return 0;
  }
  return cantarget;
}

function assignprimarytargets(targets) {
  for(idx = 0; idx < targets.size; idx++) {
    if(isDefined(targets[idx].isaiclone)) {
      killstreaks::update_actor_threat(targets[idx]);
      continue;
    }
    if(isDefined(targets[idx].type) && targets[idx].type == "dog") {
      killstreaks::update_dog_threat(targets[idx]);
      continue;
    }
    if(isPlayer(targets[idx])) {
      killstreaks::update_player_threat(targets[idx]);
      continue;
    }
    killstreaks::update_non_player_threat(targets[idx]);
  }
  assert(targets.size >= 2, "");
  highest = 0;
  second_highest = 0;
  primarytarget = undefined;
  for(idx = 0; idx < targets.size; idx++) {
    assert(isDefined(targets[idx].threatlevel), "");
    if(targets[idx].threatlevel >= highest) {
      highest = targets[idx].threatlevel;
      primarytarget = targets[idx];
    }
  }
  assert(isDefined(primarytarget), "");
  self.primarytarget = primarytarget;
  self notify("hash_907788c7");
}

function assignsecondarytargets(targets) {
  for(idx = 0; idx < targets.size; idx++) {
    if(!isDefined(targets[idx].type) || targets[idx].type != "dog") {
      self killstreaks::update_missile_player_threat(targets[idx]);
      continue;
    }
    if(targets[idx].type == "dog" || targets[0].type == "tank_drone") {
      killstreaks::update_missile_dog_threat(targets[idx]);
    }
  }
  assert(targets.size >= 2, "");
  highest = 0;
  second_highest = 0;
  primarytarget = undefined;
  secondarytarget = undefined;
  for(idx = 0; idx < targets.size; idx++) {
    assert(isDefined(targets[idx].missilethreatlevel), "");
    if(targets[idx].missilethreatlevel >= highest) {
      highest = targets[idx].missilethreatlevel;
      secondarytarget = targets[idx];
    }
  }
  assert(isDefined(secondarytarget), "");
  self.secondarytarget = secondarytarget;
  self notify("hash_519af70b");
}

function heli_reset() {
  self cleartargetyaw();
  self cleargoalyaw();
  self setspeed(60, 25);
  self setyawspeed(75, 45, 45);
  self setmaxpitchroll(30, 30);
  self setneargoalnotifydist(256);
  self setturningability(0.9);
}

function heli_wait(waittime) {
  self endon("death");
  self endon("crashing");
  self endon("evasive");
  self thread heli_hover();
  wait(waittime);
  heli_reset();
  self notify("hash_38f853e7");
}

function heli_hover() {
  self endon("death");
  self endon("hash_38f853e7");
  self endon("evasive");
  self endon("leaving");
  self endon("crashing");
  randint = randomint(360);
  self setgoalyaw(self.angles[1] + randint);
}

function wait_for_killed() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self.bda = 0;
  while(true) {
    self waittill("killed", victim);
    if(!isDefined(self.owner) || !isDefined(victim)) {
      continue;
    }
    if(self.owner == victim) {
      continue;
    }
    if(level.teambased && self.owner.team == victim.team) {
      continue;
    }
    self thread wait_for_bda_timeout();
  }
}

function wait_for_bda_timeout() {
  self endon("killed");
  wait(2.5);
  if(!isDefined(self)) {
    return;
  }
  self play_bda_dialog();
}

function play_bda_dialog() {
  if(self.bda == 1) {
    bdadialog = "kill1";
  } else {
    if(self.bda == 2) {
      bdadialog = "kill2";
    } else {
      if(self.bda == 3) {
        bdadialog = "kill3";
      } else if(self.bda > 3) {
        bdadialog = "killMultiple";
      }
    }
  }
  self killstreaks::play_pilot_dialog_on_owner(bdadialog, self.killstreaktype, self.killstreak_id);
  self notify("bda_dialog", bdadialog);
  self.bda = 0;
}

function heli_hacked_health_update(hacker) {
  helicopter = self;
  hackeddamagetaken = helicopter.maxhealth - helicopter.hackedhealth;
  assert(hackeddamagetaken > 0);
  if(hackeddamagetaken > helicopter.damagetaken) {
    helicopter.damagetaken = hackeddamagetaken;
  }
}

function heli_damage_monitor(hardpointtype) {
  helicopter = self;
  self endon("death");
  self endon("crashing");
  self.damagetaken = 0;
  last_hit_vo = 0;
  hit_vo_spacing = 6000;
  tablehealth = killstreak_bundles::get_max_health(hardpointtype);
  if(isDefined(tablehealth)) {
    self.maxhealth = tablehealth;
  }
  helicopter.hackedhealthupdatecallback = &heli_hacked_health_update;
  helicopter.hackedhealth = killstreak_bundles::get_hacked_health(hardpointtype);
  if(!isDefined(self.attackerdata)) {
    self.attackers = [];
    self.attackerdata = [];
    self.attackerdamage = [];
    self.flareattackerdamage = [];
  }
  for(;;) {
    self waittill("damage", damage, attacker, direction, point, type, modelname, tagname, partname, weapon, flags, inflictor, chargelevel);
    if(!isDefined(attacker) || !isPlayer(attacker)) {
      continue;
    }
    heli_friendlyfire = weaponobjects::friendlyfirecheck(self.owner, attacker);
    if(!heli_friendlyfire) {
      continue;
    }
    if(!level.hardcoremode) {
      if(isDefined(self.owner) && attacker == self.owner) {
        continue;
      }
      if(level.teambased) {
        isvalidattacker = isDefined(attacker.team) && attacker.team != self.team;
      } else {
        isvalidattacker = 1;
      }
      if(!isvalidattacker) {
        continue;
      }
    }
    self.attacker = attacker;
    weapon_damage = killstreak_bundles::get_weapon_damage(hardpointtype, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel);
    if(!isDefined(weapon_damage)) {
      if(type == "MOD_RIFLE_BULLET" || type == "MOD_PISTOL_BULLET") {
        hasfmj = attacker hasperk("specialty_armorpiercing");
        if(hasfmj) {
          damage = damage + (int(damage * level.cac_armorpiercing_data));
        }
        damage = damage * level.heli_armor_bulletdamage;
      } else if(type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_EXPLOSIVE") {
        shouldupdatedamage = weapon.statindex != level.weaponpistolenergy.statindex && weapon.statindex != level.weaponspecialcrossbow.statindex && weapon.statindex != level.weaponsmgnailgun.statindex;
        if(shouldupdatedamage) {
          switch (weapon.name) {
            case "tow_turret": {
              if(isDefined(self.rocketdamagetwoshot)) {
                damage = self.rocketdamagetwoshot;
              } else if(isDefined(self.rocketdamageoneshot)) {
                damage = self.rocketdamageoneshot;
              }
              break;
            }
            default: {
              if(isDefined(self.rocketdamageoneshot)) {
                damage = self.rocketdamageoneshot;
              }
              break;
            }
          }
        }
      }
      weapon_damage = damage;
    }
    if(weapon_damage > 0) {
      self challenges::trackassists(attacker, weapon_damage, 0);
    }
    self.damagetaken = self.damagetaken + weapon_damage;
    playercontrolled = 0;
    if(self.damagetaken > self.maxhealth && !isDefined(self.xpgiven)) {
      self.xpgiven = 1;
      switch (hardpointtype) {
        case "helicopter_gunner": {
          playercontrolled = 1;
          event = "destroyed_vtol_mothership";
          jump loc_000063A8;
        }
        case "helicopter_comlink":
        case "inventory_helicopter_comlink": {
          event = "destroyed_helicopter_comlink";
          if(self.leaving !== 1) {
            self killstreaks::play_destroyed_dialog_on_owner(self.killstreaktype, self.killstreak_id);
          }
          jump loc_000063A8;
        }
        case "supply_drop":
        case "supply_drop_combat_robot": {
          if(isDefined(helicopter.killstreakweaponname)) {
            switch (helicopter.killstreakweaponname) {
              case "ai_tank_drop":
              case "ai_tank_drop_marker":
              case "ai_tank_marker":
              case "inventory_ai_tank_drop":
              case "inventory_ai_tank_marker": {
                event = "destroyed_helicopter_agr_drop";
                break;
              }
              case "combat_robot_drop":
              case "combat_robot_marker":
              case "inventory_combat_robot_drop":
              case "inventory_combat_robot_marker": {
                event = "destroyed_helicopter_giunit_drop";
                break;
              }
              default: {
                event = "destroyed_helicopter_supply_drop";
                break;
              }
            }
          } else {
            event = "destroyed_helicopter_supply_drop";
          }
          break;
        }
      }
      if(isDefined(event)) {
        if(isDefined(self.owner) && self.owner util::isenemyplayer(attacker)) {
          challenges::destroyedhelicopter(attacker, weapon, type, 0);
          challenges::destroyedaircraft(attacker, weapon, playercontrolled);
          scoreevents::processscoreevent(event, attacker, self.owner, weapon);
          attacker challenges::addflyswatterstat(weapon, self);
          if(playercontrolled == 1) {
            attacker challenges::destroyedplayercontrolledaircraft();
          }
          if(hardpointtype == "helicopter_player_gunner") {
            attacker addweaponstat(weapon, "destroyed_controlled_killstreak", 1);
          }
        }
      }
      weaponstatname = "destroyed";
      switch (weapon.name) {
        case "auto_tow":
        case "tow_turret":
        case "tow_turret_drop": {
          weaponstatname = "kills";
          break;
        }
      }
      attacker addweaponstat(weapon, weaponstatname, 1);
      notifystring = undefined;
      killstreakreference = undefined;
      switch (hardpointtype) {
        case "helicopter_gunner": {
          killstreakreference = "killstreak_helicopter_gunner";
          break;
        }
        case "helicopter_player_gunner": {
          killstreakreference = "killstreak_helicopter_player_gunner";
          break;
        }
        case "helicopter_player_firstperson": {
          killstreakreference = "killstreak_helicopter_player_firstperson";
          break;
        }
        case "helicopter":
        case "helicopter_comlink":
        case "helicopter_x2":
        case "inventory_helicopter_comlink": {
          notifystring = &"KILLSTREAK_DESTROYED_HELICOPTER";
          killstreakreference = "killstreak_helicopter_comlink";
          break;
        }
        case "supply_drop": {
          notifystring = &"KILLSTREAK_DESTROYED_SUPPLY_DROP_DEPLOY_SHIP";
          killstreakreference = "killstreak_supply_drop";
          break;
        }
        case "helicopter_guard": {
          killstreakreference = "killstreak_helicopter_guard";
        }
      }
      if(isDefined(killstreakreference)) {
        level.globalkillstreaksdestroyed++;
        attacker addweaponstat(getweapon(hardpointtype), "destroyed", 1);
      }
      if(hardpointtype == "helicopter_player_gunner") {
        self.owner sendkillstreakdamageevent(600);
      }
      if(isDefined(notifystring)) {
        luinotifyevent(&"player_callout", 2, notifystring, attacker.entnum);
      }
      if(isDefined(self.attackers)) {
        for(j = 0; j < self.attackers.size; j++) {
          player = self.attackers[j];
          if(!isDefined(player)) {
            continue;
          }
          if(player == attacker) {
            continue;
          }
          flare_done = self.flareattackerdamage[player.clientid];
          if(isDefined(flare_done) && flare_done == 1) {
            scoreevents::processscoreevent("aircraft_flare_assist", player);
            continue;
          }
          damage_done = self.attackerdamage[player.clientid];
          player thread processcopterassist(self, damage_done);
        }
        self.attackers = [];
      }
      attacker notify("destroyed_helicopter");
      if(target_istarget(self)) {
        target_remove(self);
      }
    } else if(isDefined(self.owner) && isPlayer(self.owner)) {
      if((last_hit_vo + hit_vo_spacing) < gettime()) {
        if(type == "MOD_PROJECTILE" || randomintrange(0, 3) == 0) {
          last_hit_vo = gettime();
        }
      }
    }
    if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
      self thread heli_active_camo_damage_update(damage);
    }
  }
}

function init_active_camo() {
  heli = self;
  heli.active_camo_supported = 1;
  heli.active_camo_damage = 0;
  heli.active_camo_disabled = 0;
  heli.camo_state = 0;
  heli_set_active_camo_state(1);
  if(isDefined(heli.flak_drone)) {
    heli.flak_drone flak_drone::setcamostate(1);
  }
}

function heli_set_active_camo_state(state) {
  heli = self;
  if(!isDefined(heli.active_camo_supported)) {
    return;
  }
  if(state == 0) {
    heli clientfield::set("toggle_lights", 1);
    if(heli.camo_state == 1) {
      heli playSound("veh_hind_cloak_off");
    }
    heli.camo_state = 0;
    heli.camo_state_switch_time = gettime();
  } else {
    if(state == 1) {
      if(heli.active_camo_disabled) {
        return;
      }
      heli clientfield::set("toggle_lights", 0);
      if(heli.camo_state == 0) {
        heli playSound("veh_hind_cloak_on");
      }
      heli.camo_state = 1;
      heli.camo_state_switch_time = gettime();
      if(isDefined(heli.owner)) {
        if(isDefined(heli.play_camo_dialog) && heli.play_camo_dialog) {
          heli killstreaks::play_pilot_dialog_on_owner("activateCounter", "helicopter_comlink", self.killstreak_id);
          heli.play_camo_dialog = 0;
        } else if(!isDefined(heli.play_camo_dialog)) {
          heli.play_camo_dialog = 1;
        }
      }
    } else if(state == 2) {
      heli clientfield::set("toggle_lights", 1);
    }
  }
  if(isDefined(heli.flak_drone)) {
    heli.flak_drone flak_drone::setcamostate(state);
  }
  heli clientfield::set("active_camo", state);
}

function heli_active_camo_damage_update(damage) {
  self endon("death");
  self endon("crashing");
  heli = self;
  heli.active_camo_damage = heli.active_camo_damage + damage;
  if(heli.active_camo_damage > 100) {
    heli.active_camo_disabled = 1;
    heli thread heli_active_camo_damage_disable();
  } else {
    heli heli_set_active_camo_state(2);
    wait(1);
    heli heli_set_active_camo_state(1);
  }
}

function heli_active_camo_damage_disable() {
  self endon("death");
  self endon("crashing");
  heli = self;
  heli notify("heli_active_camo_damage_disable");
  heli endon("heli_active_camo_damage_disable");
  heli heli_set_active_camo_state(0);
  wait(10);
  heli.active_camo_damage = 0;
  heli.active_camo_disabled = 0;
  heli heli_set_active_camo_state(1);
}

function heli_health(hardpointtype, playernotify) {
  self endon("death");
  self endon("crashing");
  self.currentstate = "ok";
  self.laststate = "ok";
  self setdamagestage(3);
  damagestate = 3;
  tablehealth = killstreak_bundles::get_max_health(hardpointtype);
  if(isDefined(tablehealth)) {
    self.maxhealth = tablehealth;
  }
  for(;;) {
    self waittill("damage", damage, attacker, direction, point, type, modelname, tagname, partname, weapon);
    wait(0.05);
    if(self.damagetaken > self.maxhealth) {
      damagestate = 0;
      self setdamagestage(damagestate);
      self heli_set_active_camo_state(0);
      self thread heli_crash(hardpointtype, self.owner, playernotify);
    } else {
      if(self.damagetaken >= (self.maxhealth * 0.66) && damagestate >= 2) {
        self killstreaks::play_pilot_dialog_on_owner("damaged", "helicopter_comlink", self.killstreak_id);
        if(isDefined(self.vehicletype) && self.vehicletype == "heli_player_gunner_mp") {
          playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, "tag_origin");
        } else {
          playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, "tag_main_rotor");
        }
        damagestate = 1;
        self.currentstate = "heavy smoke";
        self.evasive = 1;
        self notify("hash_2b25e23d");
      } else if(self.damagetaken >= (self.maxhealth * 0.33) && damagestate == 3) {
        if(isDefined(self.vehicletype) && self.vehicletype == "heli_player_gunner_mp") {
          playFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, "tag_origin");
        } else {
          playFXOnTag(level.chopper_fx["damage"]["light_smoke"], self, "tag_main_rotor");
        }
        damagestate = 2;
        self.currentstate = "light smoke";
        self notify("hash_2b25e23d");
      }
    }
    if(self.damagetaken <= level.heli_armor) {
      airsupport::debug_print3d_simple("Armor: " + (level.heli_armor - self.damagetaken), self, vectorscale((0, 0, 1), 100), 20);
      continue;
    }
    airsupport::debug_print3d_simple("Health: " + (self.maxhealth - self.damagetaken), self, vectorscale((0, 0, 1), 100), 20);
  }
}

function heli_evasive(hardpointtype) {
  self notify("evasive");
  self.evasive = 1;
  loop_startnode = level.heli_loop_paths[0];
  gunnerpathfound = 1;
  if(hardpointtype == "helicopter_gunner") {
    gunnerpathfound = 0;
    for(i = 0; i < level.heli_loop_paths.size; i++) {
      if(isDefined(level.heli_loop_paths[i].isgunnerpath) && level.heli_loop_paths[i].isgunnerpath) {
        loop_startnode = level.heli_loop_paths[i];
        gunnerpathfound = 1;
        break;
      }
    }
  }
  assert(gunnerpathfound, "");
  startwait = 2;
  if(isDefined(self.donotstop) && self.donotstop) {
    startwait = 0;
  }
  self thread heli_fly(loop_startnode, startwait, hardpointtype);
}

function notify_player(player, playernotify, delay) {
  if(!isDefined(player)) {
    return;
  }
  if(!isDefined(playernotify)) {
    return;
  }
  player endon("disconnect");
  player endon(playernotify);
  wait(delay);
  player notify(playernotify);
}

function play_going_down_vo(delay) {
  self.owner endon("disconnect");
  self endon("death");
  wait(delay);
}

function heli_crash(hardpointtype, player, playernotify) {
  self endon("death");
  self notify("crashing");
  self spawning::remove_influencers();
  self stoploopsound(0);
  if(isDefined(self.minigun_snd_ent)) {
    self.minigun_snd_ent stoploopsound();
  }
  if(isDefined(self.alarm_snd_ent)) {
    self.alarm_snd_ent stoploopsound();
  }
  crashtypes = [];
  crashtypes[0] = "crashOnPath";
  crashtypes[1] = "spinOut";
  crashtype = crashtypes[randomint(2)];
  if(isDefined(self.crashtype)) {
    crashtype = self.crashtype;
  }
  if(level.heli_debug_crash) {
    switch (level.heli_debug_crash) {
      case 1: {
        crashtype = "";
        break;
      }
      case 2: {
        crashtype = "";
        break;
      }
      case 3: {
        crashtype = "";
        break;
      }
      default: {}
    }
  }
  switch (crashtype) {
    case "explode": {
      thread notify_player(player, playernotify, 0);
      self thread heli_explode();
      break;
    }
    case "crashOnPath": {
      if(isDefined(player)) {
        self thread play_going_down_vo(0.5);
      }
      thread notify_player(player, playernotify, 4);
      self clear_client_flags();
      self thread crashonnearestcrashpath(hardpointtype);
      break;
    }
    case "spinOut": {
      if(isDefined(player)) {
        self thread play_going_down_vo(0.5);
      }
      thread notify_player(player, playernotify, 4);
      self clear_client_flags();
      heli_reset();
      heli_speed = 30 + randomint(50);
      heli_accel = 10 + randomint(25);
      leavenode = getvalidrandomcrashnode(self.origin);
      self setspeed(heli_speed, heli_accel);
      self set_goal_pos(leavenode.origin, 0);
      rateofspin = 45 + randomint(90);
      thread heli_secondary_explosions();
      self thread heli_spin(rateofspin);
      self util::waittill_any_timeout(randomintrange(4, 6), "near_goal");
      if(isDefined(player) && isDefined(playernotify)) {
        player notify(playernotify);
      }
      self thread heli_explode();
      break;
    }
  }
  self thread explodeoncontact(hardpointtype);
  time = randomintrange(4, 6);
  self thread waitthenexplode(time);
}

function damagedrotorfx() {
  self endon("death");
  self setrotorspeed(0.6);
}

function waitthenexplode(time) {
  self endon("death");
  wait(time);
  self thread heli_explode();
}

function crashonnearestcrashpath(hardpointtype) {
  crashpathdistance = -1;
  crashpath = level.heli_crash_paths[0];
  for(i = 0; i < level.heli_crash_paths.size; i++) {
    currentdistance = distance(self.origin, level.heli_crash_paths[i].origin);
    if(crashpathdistance == -1 || crashpathdistance > currentdistance) {
      crashpathdistance = currentdistance;
      crashpath = level.heli_crash_paths[i];
    }
  }
  heli_speed = 30 + randomint(50);
  heli_accel = 10 + randomint(25);
  self setspeed(heli_speed, heli_accel);
  thread heli_secondary_explosions();
  self thread heli_fly(crashpath, 0, hardpointtype);
  rateofspin = 45 + randomint(90);
  self thread heli_spin(rateofspin);
  self waittill("hash_df5908ac");
  self waittill("hash_9b1f1e2d");
  self thread heli_explode();
}

function checkhelicoptertag(tagname) {
  if(isDefined(self.model)) {
    if(self.model == "veh_t7_drone_hunter") {
      switch (tagname) {
        case "tag_engine_left": {
          return "tag_fx_exhaust2";
        }
        case "tag_engine_right": {
          return "tag_fx_exhaust1";
        }
        case "tail_rotor_jnt": {
          return "tag_fx_tail";
        }
        default: {
          break;
        }
      }
    }
  }
  return tagname;
}

function heli_secondary_explosions() {
  self endon("death");
  playFXOnTag(level.chopper_fx["explode"]["large"], self, self checkhelicoptertag("tag_engine_left"));
  self playSound(level.heli_sound["hit"]);
  if(isDefined(self.vehicletype) && self.vehicletype == "heli_player_gunner_mp") {
    self thread trail_fx(level.chopper_fx["smoke"]["trail"], self checkhelicoptertag("tag_engine_right"), "stop tail smoke");
  } else {
    self thread trail_fx(level.chopper_fx["smoke"]["trail"], self checkhelicoptertag("tail_rotor_jnt"), "stop tail smoke");
  }
  self setdamagestage(0);
  self thread trail_fx(level.chopper_fx["fire"]["trail"]["large"], self checkhelicoptertag("tag_engine_left"), "stop body fire");
  wait(3);
  if(!isDefined(self)) {
    return;
  }
  playFXOnTag(level.chopper_fx["explode"]["large"], self, self checkhelicoptertag("tag_engine_left"));
  self playSound(level.heli_sound["hitsecondary"]);
}

function heli_spin(speed) {
  self endon("death");
  self thread spinsoundshortly();
  self setyawspeed(speed, speed / 3, speed / 3);
  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + (speed * 0.9));
    wait(1);
  }
}

function spinsoundshortly() {
  self endon("death");
  wait(0.25);
  self stoploopsound();
  wait(0.05);
  self playLoopSound(level.heli_sound["spinloop"]);
  wait(0.05);
  self playSound(level.heli_sound["spinstart"]);
}

function trail_fx(trail_fx, trail_tag, stop_notify) {
  playFXOnTag(trail_fx, self, trail_tag);
}

function destroyhelicopter() {
  team = self.originalteam;
  if(target_istarget(self)) {
    target_remove(self);
  }
  self spawning::remove_influencers();
  if(isDefined(self.interior_model)) {
    self.interior_model delete();
    self.interior_model = undefined;
  }
  if(isDefined(self.minigun_snd_ent)) {
    self.minigun_snd_ent stoploopsound();
    self.minigun_snd_ent delete();
    self.minigun_snd_ent = undefined;
  }
  if(isDefined(self.alarm_snd_ent)) {
    self.alarm_snd_ent delete();
    self.alarm_snd_ent = undefined;
  }
  if(isDefined(self.flare_ent)) {
    self.flare_ent delete();
    self.flare_ent = undefined;
  }
  killstreakrules::killstreakstop(self.hardpointtype, team, self.killstreak_id);
  self delete();
}

function heli_explode() {
  self endon("death");
  forward = (self.origin + vectorscale((0, 0, 1), 100)) - self.origin;
  if(isDefined(self.helitype) && self.helitype == "littlebird") {
    playFX(level.chopper_fx["explode"]["guard"], self.origin, forward);
  } else {
    if(isDefined(self.vehicletype) && self.vehicletype == "heli_player_gunner_mp") {
      playFX(level.chopper_fx["explode"]["gunner"], self.origin, forward);
    } else {
      playFX(level.chopper_fx["explode"]["death"], self.origin, forward);
    }
  }
  self playSound(level.heli_sound["crash"]);
  wait(0.1);
  assert(isDefined(self.destroyfunc));
  self[[self.destroyfunc]]();
}

function clear_client_flags() {
  self clientfield::set("heli_warn_fired", 0);
  self clientfield::set("heli_warn_targeted", 0);
  self clientfield::set("heli_warn_locked", 0);
}

function heli_leave() {
  self notify("hash_df1f87c9");
  self notify("leaving");
  hardpointtype = self.hardpointtype;
  self.leaving = 1;
  if(!(isDefined(self.detroyscoreeventgiven) && self.detroyscoreeventgiven)) {
    self killstreaks::play_pilot_dialog_on_owner("timeout", hardpointtype);
    self killstreaks::play_taacom_dialog_response_on_owner("timeoutConfirmed", hardpointtype);
  }
  leavenode = getvalidrandomleavenode(self.origin);
  heli_reset();
  self clearlookatent();
  exitangles = vectortoangles(leavenode.origin - self.origin);
  self setgoalyaw(exitangles[1]);
  wait(1.5);
  if(!isDefined(self)) {
    return;
  }
  self setspeed(180, 65);
  self util::debug_slow_heli_speed();
  self set_goal_pos((self.origin + ((leavenode.origin - self.origin) / 2)) + vectorscale((0, 0, 1), 1000), 0);
  self waittill("near_goal");
  if(isDefined(self)) {
    self set_goal_pos(leavenode.origin, 1);
    self waittillmatch("goal");
    if(isDefined(self)) {
      self stoploopsound(1);
      self util::death_notify_wrapper();
      if(isDefined(self.alarm_snd_ent)) {
        self.alarm_snd_ent stoploopsound();
        self.alarm_snd_ent delete();
        self.alarm_snd_ent = undefined;
      }
      assert(isDefined(self.destroyfunc));
      self[[self.destroyfunc]]();
    }
  }
}

function heli_fly(currentnode, startwait, hardpointtype) {
  self endon("death");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  self endon("abandoned");
  self.reached_dest = 0;
  heli_reset();
  pos = self.origin;
  wait(startwait);
  while(isDefined(currentnode.target)) {
    nextnode = getent(currentnode.target, "targetname");
    assert(isDefined(nextnode), "");
    pos = nextnode.origin + vectorscale((0, 0, 1), 30);
    if(isDefined(currentnode.script_airspeed) && isDefined(currentnode.script_accel)) {
      heli_speed = currentnode.script_airspeed;
      heli_accel = currentnode.script_accel;
    } else {
      heli_speed = 30 + randomint(20);
      heli_accel = 10 + randomint(5);
    }
    if(isDefined(self.pathspeedscale)) {
      heli_speed = heli_speed * self.pathspeedscale;
      heli_accel = heli_accel * self.pathspeedscale;
    }
    if(!isDefined(nextnode.target)) {
      stop = 1;
    } else {
      stop = 0;
    }
    airsupport::debug_line(currentnode.origin, nextnode.origin, (1, 0.5, 0.5), 200);
    if(self.currentstate == "heavy smoke" || self.currentstate == "light smoke") {
      self setspeed(heli_speed, heli_accel);
      self set_goal_pos(pos, stop);
      self waittill("near_goal");
      self notify("hash_df5908ac");
    } else {
      if(isDefined(nextnode.script_delay) && !isDefined(self.donotstop)) {
        stop = 1;
      }
      self setspeed(heli_speed, heli_accel);
      self set_goal_pos(pos, stop);
      if(!isDefined(nextnode.script_delay) || isDefined(self.donotstop)) {
        self waittill("near_goal");
        self notify("hash_df5908ac");
      } else {
        self setgoalyaw(nextnode.angles[1]);
        self waittillmatch("goal");
        heli_wait(nextnode.script_delay);
      }
    }
    for(index = 0; index < level.heli_loop_paths.size; index++) {
      if(level.heli_loop_paths[index].origin == nextnode.origin) {
        self.loopcount++;
      }
    }
    if(self.loopcount >= level.heli_loopmax) {
      self thread heli_leave();
      return;
    }
    currentnode = nextnode;
  }
  self setgoalyaw(currentnode.angles[1]);
  self.reached_dest = 1;
  self notify("hash_9b1f1e2d");
  if(isDefined(self.waittime) && self.waittime > 0) {
    heli_wait(self.waittime);
  }
  if(isDefined(self)) {
    self thread heli_evasive(hardpointtype);
  }
}

function heli_random_point_in_radius(protectdest, nodeheight) {
  min_distance = int(level.heli_protect_radius * 0.2);
  direction = randomintrange(0, 360);
  distance = randomintrange(min_distance, level.heli_protect_radius);
  x = cos(direction);
  y = sin(direction);
  x = x * distance;
  y = y * distance;
  return (protectdest[0] + x, protectdest[1] + y, nodeheight);
}

function heli_get_protect_spot(protectdest, nodeheight) {
  protect_spot = heli_random_point_in_radius(protectdest, nodeheight);
  tries = 10;
  noflyzone = airsupport::crossesnoflyzone(protectdest, protect_spot);
  while(tries != 0 && isDefined(noflyzone)) {
    protect_spot = heli_random_point_in_radius(protectdest, nodeheight);
    tries--;
    noflyzone = airsupport::crossesnoflyzone(protectdest, protect_spot);
  }
  noflyzoneheight = airsupport::getnoflyzoneheightcrossed(protectdest, protect_spot, nodeheight);
  return (protect_spot[0], protect_spot[1], noflyzoneheight);
}

function wait_or_waittill(time, msg1, msg2, msg3) {
  self endon(msg1);
  self endon(msg2);
  self endon(msg3);
  wait(time);
  return true;
}

function set_heli_speed_normal() {
  self setmaxpitchroll(30, 30);
  heli_speed = 30 + randomint(20);
  heli_accel = 10 + randomint(5);
  self setspeed(heli_speed, heli_accel);
  self setyawspeed(75, 45, 45);
}

function set_heli_speed_evasive() {
  self setmaxpitchroll(30, 90);
  heli_speed = 50 + randomint(20);
  heli_accel = 30 + randomint(5);
  self setspeed(heli_speed, heli_accel);
  self setyawspeed(100, 75, 75);
}

function set_heli_speed_hover() {
  self setmaxpitchroll(0, 90);
  self setspeed(20, 10);
  self setyawspeed(55, 25, 25);
}

function is_targeted() {
  if(isDefined(self.locking_on) && self.locking_on) {
    return true;
  }
  if(isDefined(self.locked_on) && self.locked_on) {
    return true;
  }
  if(isDefined(self.locking_on_hacking) && self.locking_on_hacking) {
    return true;
  }
  return false;
}

function heli_mobilespawn(protectdest) {
  self endon("death");
  self notify("flying");
  self endon("flying");
  self endon("abandoned");
  iprintlnbold(((((("PROTECT ORIGIN: (" + protectdest[0]) + ",") + protectdest[1]) + ",") + protectdest[2]) + ")\n");
  heli_reset();
  self sethoverparams(50, 100, 50);
  wait(2);
  set_heli_speed_normal();
  self set_goal_pos(protectdest, 1);
  self waittill("near_goal");
  set_heli_speed_hover();
}

function heli_protect(startnode, protectdest, hardpointtype, heli_team) {
  self endon("death");
  self notify("flying");
  self endon("flying");
  self endon("abandoned");
  self.reached_dest = 0;
  heli_reset();
  self sethoverparams(50, 100, 50);
  wait(2);
  currentdest = protectdest;
  nodeheight = protectdest[2];
  nextnode = startnode;
  heightoffset = 0;
  if(heli_team == "axis") {
    heightoffset = 400;
  }
  protectdest = (protectdest[0], protectdest[1], nodeheight);
  noflyzoneheight = airsupport::getnoflyzoneheight(protectdest);
  protectdest = (protectdest[0], protectdest[1], noflyzoneheight + heightoffset);
  currentdest = protectdest;
  starttime = gettime();
  self.endtime = starttime + (level.heli_protect_time * 1000);
  self.killstreakendtime = int(self.endtime);
  self setspeed(150, 80);
  self util::debug_slow_heli_speed();
  self set_goal_pos((self.origin + ((currentdest - self.origin) / 3)) + vectorscale((0, 0, 1), 1000), 0);
  self waittill("near_goal");
  heli_speed = 30 + randomint(20);
  heli_accel = 10 + randomint(5);
  self thread updatetargetyaw();
  mapenter = 1;
  while(gettime() < self.endtime) {
    stop = 1;
    if(!mapenter) {
      self updatespeed();
    } else {
      mapenter = 0;
    }
    self set_goal_pos(currentdest, stop);
    self thread updatespeedonlock();
    self util::waittill_any("near_goal", "locking on", "locking on hacking");
    hostmigration::waittillhostmigrationdone();
    self notify("hash_df5908ac");
    if(!self is_targeted()) {
      waittillframeend();
      time = level.heli_protect_pos_time;
      if(self.evasive == 1) {
        time = 2;
      }
      set_heli_speed_hover();
      wait_or_waittill(time, "locking on", "locking on hacking", "damage state");
    } else {
      wait(2);
    }
    prevdest = currentdest;
    currentdest = heli_get_protect_spot(protectdest, nodeheight);
    noflyzoneheight = airsupport::getnoflyzoneheight(currentdest);
    currentdest = (currentdest[0], currentdest[1], noflyzoneheight + heightoffset);
    noflyzones = airsupport::crossesnoflyzones(prevdest, currentdest);
    if(isDefined(noflyzones) && noflyzones.size > 0) {
      currentdest = prevdest;
    }
  }
  self heli_set_active_camo_state(1);
  self thread heli_leave();
}

function updatespeedonlock() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self util::waittill_any("near_goal", "locking on", "locking on hacking");
  self updatespeed();
}

function updatespeed() {
  if(self is_targeted() || (isDefined(self.evasive) && self.evasive)) {
    set_heli_speed_evasive();
  } else {
    set_heli_speed_normal();
  }
}

function updatetargetyaw() {
  self notify("endtargetyawupdate");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("endtargetyawupdate");
  for(;;) {
    if(isDefined(self.primarytarget)) {
      yaw = math::get_2d_yaw(self.origin, self.primarytarget.origin);
      self settargetyaw(yaw);
    }
    wait(1);
  }
}

function fire_missile(smissiletype, ishots = 1, etarget) {
  assert(self.health > 0);
  weapon = undefined;
  weaponshoottime = undefined;
  tags = [];
  switch (smissiletype) {
    case "ffar": {
      weapon = getweapon("hind_FFAR");
      tags[0] = "tag_store_r_2";
      break;
    }
    default: {
      assertmsg("");
      break;
    }
  }
  assert(isDefined(weapon));
  assert(tags.size > 0);
  weaponshoottime = weapon.firetime;
  assert(isDefined(weaponshoottime));
  self setvehweapon(weapon);
  nextmissiletag = -1;
  for(i = 0; i < ishots; i++) {
    nextmissiletag++;
    if(nextmissiletag >= tags.size) {
      nextmissiletag = 0;
    }
    emissile = self fireweapon(0, etarget);
    emissile.killcament = self;
    self.lastrocketfiretime = gettime();
    if(i < (ishots - 1)) {
      wait(weaponshoottime);
    }
  }
}

function check_owner(hardpointtype) {
  if(!isDefined(self.owner) || !isDefined(self.owner.team) || self.owner.team != self.team) {
    self notify("abandoned");
    self thread heli_leave();
  }
}

function attack_targets(missilesenabled, hardpointtype) {
  self thread attack_primary(hardpointtype);
  if(missilesenabled) {
    self thread attack_secondary(hardpointtype);
  }
}

function attack_secondary(hardpointtype) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  for(;;) {
    if(isDefined(self.secondarytarget)) {
      self.secondarytarget.antithreat = undefined;
      self.missiletarget = self.secondarytarget;
      antithreat = 0;
      while(isDefined(self.missiletarget) && isalive(self.missiletarget)) {
        if(self target_cone_check(self.missiletarget, level.heli_missile_target_cone)) {
          self thread missile_support(self.missiletarget, level.heli_missile_rof, 1, undefined);
        } else {
          break;
        }
        antithreat = antithreat + 100;
        self.missiletarget.antithreat = antithreat;
        wait(level.heli_missile_rof);
        if(!isDefined(self.secondarytarget) || (isDefined(self.secondarytarget) && self.missiletarget != self.secondarytarget)) {
          break;
        }
      }
      if(isDefined(self.missiletarget)) {
        self.missiletarget.antithreat = undefined;
      }
    }
    self waittill("hash_519af70b");
    self check_owner(hardpointtype);
  }
}

function turret_target_check(turrettarget, attackangle) {
  targetyaw = math::get_2d_yaw(self.origin, turrettarget.origin);
  chopperyaw = self.angles[1];
  if(targetyaw < 0) {
    targetyaw = targetyaw * -1;
  }
  targetyaw = int(targetyaw) % 360;
  if(chopperyaw < 0) {
    chopperyaw = chopperyaw * -1;
  }
  chopperyaw = int(chopperyaw) % 360;
  if(chopperyaw > targetyaw) {
    difference = chopperyaw - targetyaw;
  } else {
    difference = targetyaw - chopperyaw;
  }
  return difference <= attackangle;
}

function target_cone_check(target, conecosine) {
  heli2target_normal = vectornormalize(target.origin - self.origin);
  heli2forward = anglesToForward(self.angles);
  heli2forward_normal = vectornormalize(heli2forward);
  heli_dot_target = vectordot(heli2target_normal, heli2forward_normal);
  if(heli_dot_target >= conecosine) {
    airsupport::debug_print3d_simple("Cone sight: " + heli_dot_target, self, vectorscale((0, 0, -1), 40), 40);
    return true;
  }
  return false;
}

function missile_support(target_player, rof, instantfire, endon_notify) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  if(isDefined(endon_notify)) {
    self endon(endon_notify);
  }
  self.turret_giveup = 0;
  if(!instantfire) {
    wait(rof);
    self.turret_giveup = 1;
    self notify("hash_e4ae4515");
  }
  if(isDefined(target_player)) {
    if(level.teambased) {
      for(i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if(isDefined(player.team) && player.team == self.team && distance(player.origin, target_player.origin) <= level.heli_missile_friendlycare) {
          airsupport::debug_print3d_simple("Missile omitted due to nearby friendly", self, vectorscale((0, 0, -1), 80), 40);
          self notify("hash_2ff1ad5e");
          return;
        }
      }
    } else {
      player = self.owner;
      if(isDefined(player) && isDefined(player.team) && player.team == self.team && distance(player.origin, target_player.origin) <= level.heli_missile_friendlycare) {
        airsupport::debug_print3d_simple("Missile omitted due to nearby friendly", self, vectorscale((0, 0, -1), 80), 40);
        self notify("hash_2ff1ad5e");
        return;
      }
    }
  }
  if(self.missile_ammo > 0 && isDefined(target_player)) {
    self fire_missile("ffar", 1, target_player);
    self.missile_ammo--;
    self notify("hash_b0c5ea03");
  } else {
    return;
  }
  if(instantfire) {
    wait(rof);
    self notify("hash_2ff1ad5e");
  }
}

function attack_primary(hardpointtype) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  for(;;) {
    if(isDefined(self.primarytarget)) {
      self.primarytarget.antithreat = undefined;
      self.turrettarget = self.primarytarget;
      antithreat = 0;
      last_pos = undefined;
      while(isDefined(self.turrettarget) && isalive(self.turrettarget)) {
        if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink") {
          self setlookatent(self.turrettarget);
        }
        helicopterturretmaxangle = heli_get_dvar_int("scr_helicopterTurretMaxAngle", level.helicopterturretmaxangle);
        while(isDefined(self.turrettarget) && isalive(self.turrettarget) && self turret_target_check(self.turrettarget, helicopterturretmaxangle) == 0) {
          wait(0.1);
        }
        if(!isDefined(self.turrettarget) || !isalive(self.turrettarget)) {
          break;
        }
        self setturrettargetent(self.turrettarget, vectorscale((0, 0, 1), 50));
        self waittill("turret_on_target");
        hostmigration::waittillhostmigrationdone();
        self notify("turret_on_target");
        self thread turret_target_flag(self.turrettarget);
        wait(1);
        self heli_set_active_camo_state(0);
        wait(level.heli_turret_spinup_delay);
        weaponshoottime = self.defaultweapon.firetime;
        self setvehweapon(self.defaultweapon);
        for(i = 0; i < level.heli_turretclipsize; i++) {
          if(isDefined(self.turrettarget) && isDefined(self.primarytarget)) {
            if(self.primarytarget != self.turrettarget) {
              self setturrettargetent(self.primarytarget, vectorscale((0, 0, 1), 40));
            }
          } else {
            if(isDefined(self.targetlost) && self.targetlost && isDefined(self.turret_last_pos)) {
              self setturrettargetvec(self.turret_last_pos);
            } else {
              self clearturrettarget();
            }
          }
          if(gettime() != self.lastrocketfiretime) {
            self setvehweapon(self.defaultweapon);
            minigun = self fireweapon();
          }
          if(i < (level.heli_turretclipsize - 1)) {
            wait(weaponshoottime);
          }
        }
        self notify("hash_849f87ba", self.pilotistalking);
        wait(level.heli_turretreloadtime);
        wait(3);
        self heli_set_active_camo_state(1);
        if(isDefined(self.turrettarget) && isalive(self.turrettarget)) {
          antithreat = antithreat + 100;
          self.turrettarget.antithreat = antithreat;
        }
        if(!isDefined(self.primarytarget) || (isDefined(self.turrettarget) && isDefined(self.primarytarget) && self.primarytarget != self.turrettarget)) {
          break;
        }
      }
      if(isDefined(self.turrettarget)) {
        self.turrettarget.antithreat = undefined;
      }
    }
    self waittill("hash_907788c7");
    self check_owner(hardpointtype);
  }
}

function turret_target_flag(turrettarget) {
  self notify("hash_4008e0d0");
  self endon("hash_4008e0d0");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self endon("hash_849f87ba");
  if(isDefined(turrettarget)) {
    turrettarget endon("death");
    turrettarget endon("disconnect");
  }
  self.targetlost = 0;
  self.turret_last_pos = undefined;
  while(isDefined(turrettarget)) {
    heli_centroid = self.origin + (vectorscale((0, 0, -1), 160));
    heli_forward_norm = anglesToForward(self.angles);
    heli_turret_point = heli_centroid + (144 * heli_forward_norm);
    sight_rec = turrettarget sightconetrace(heli_turret_point, self);
    if(sight_rec < level.heli_target_recognition) {
      break;
    }
    wait(0.05);
  }
  if(isDefined(turrettarget) && isDefined(turrettarget.origin)) {
    assert(isDefined(turrettarget.origin), "");
    self.turret_last_pos = turrettarget.origin + vectorscale((0, 0, 1), 40);
    assert(isDefined(self.turret_last_pos), "");
    self setturrettargetvec(self.turret_last_pos);
    assert(isDefined(self.turret_last_pos), "");
    airsupport::debug_print3d_simple("Turret target lost at: " + self.turret_last_pos, self, vectorscale((0, 0, -1), 70), 60);
    self.targetlost = 1;
  } else {
    self.targetlost = undefined;
    self.turret_last_pos = undefined;
  }
}

function debug_print_target() {
  if(isDefined(level.heli_debug) && level.heli_debug == 1) {
    if(isDefined(self.primarytarget) && isDefined(self.primarytarget.threatlevel)) {
      if(isDefined(self.primarytarget.type) && self.primarytarget.type == "dog") {
        name = "dog";
      } else {
        name = self.primarytarget.name;
      }
      primary_msg = (("Primary: " + name) + " : ") + self.primarytarget.threatlevel;
    } else {
      primary_msg = "Primary: ";
    }
    if(isDefined(self.secondarytarget) && isDefined(self.secondarytarget.threatlevel)) {
      if(isDefined(self.secondarytarget.type) && self.secondarytarget.type == "dog") {
        name = "dog";
      } else {
        name = self.secondarytarget.name;
      }
      secondary_msg = (("Secondary: " + name) + " : ") + self.secondarytarget.threatlevel;
    } else {
      secondary_msg = "Secondary: ";
    }
    frames = (int(self.targeting_delay * 20)) + 1;
    thread airsupport::draw_text(primary_msg, (1, 0.6, 0.6), self, vectorscale((0, 0, 1), 40), frames);
    thread airsupport::draw_text(secondary_msg, (1, 0.6, 0.6), self, (0, 0, 0), frames);
  }
}

function waittill_confirm_location() {
  self endon("emp_jammed");
  self endon("emp_grenaded");
  self waittill("confirm_location", location);
  return location;
}

function selecthelicopterlocation(hardpointtype) {
  self beginlocationcomlinkselection("compass_objpoint_helicopter", 1500);
  self.selectinglocation = 1;
  self thread airsupport::endselectionthink();
  location = self waittill_confirm_location();
  if(!isDefined(location)) {
    return 0;
  }
  if(self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
    return 0;
  }
  level.helilocation = location;
  return airsupport::finishhardpointlocationusage(location, undefined);
}

function processcopterassist(destroyedcopter, damagedone) {
  self endon("disconnect");
  destroyedcopter endon("disconnect");
  wait(0.05);
  if(!isDefined(level.teams[self.team])) {
    return;
  }
  if(self.team == destroyedcopter.team) {
    return;
  }
  assist_level = "aircraft_destruction_assist";
  assist_level_value = int(ceil((damagedone.damage / destroyedcopter.maxhealth) * 4));
  if(assist_level_value > 0) {
    if(assist_level_value > 3) {
      assist_level_value = 3;
    }
    assist_level = (assist_level + "_") + (assist_level_value * 25);
  }
  scoreevents::processscoreevent(assist_level, self);
}

function samturretwatcher() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  self util::waittill_any("turret_on_target", "path start", "near_goal");
  target_setturretaquire(self, 1);
}

function playpilotdialog(dialog, time, voice, shouldwait) {
  self endon("death");
  level endon("remote_end");
  if(isDefined(time)) {
    wait(time);
  }
  if(!isDefined(self.pilotvoicenumber)) {
    self.pilotvoicenumber = 0;
  }
  if(isDefined(voice)) {
    voicenumber = voice;
  } else {
    voicenumber = self.pilotvoicenumber;
  }
  soundalias = ((level.teamprefix[self.team] + voicenumber) + "_") + dialog;
  if(isDefined(self.owner)) {
    self.owner playpilottalking(shouldwait, soundalias);
  }
}

function playpilottalking(shouldwait, soundalias) {
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  for(trycounter = 0; isDefined(self.pilottalking) && self.pilottalking && trycounter < 10; trycounter++) {
    if(isDefined(shouldwait) && !shouldwait) {
      return;
    }
    wait(1);
  }
  self.pilottalking = 1;
  self playlocalsound(soundalias);
  wait(3);
  self.pilottalking = 0;
}

function watchforearlyleave(chopper) {
  chopper notify("watchforearlyleave_helicopter");
  chopper endon("watchforearlyleave_helicopter");
  chopper endon("death");
  self endon("heli_timeup");
  self util::waittill_any("joined_team", "disconnect");
  if(isDefined(chopper)) {
    chopper thread heli_leave();
  }
  if(isDefined(self)) {
    self notify("heli_timeup");
  }
}

function watchforemp() {
  heli = self;
  heli endon("death");
  heli endon("heli_timeup");
  heli.owner waittill("emp_jammed");
  heli thread heli_explode();
}