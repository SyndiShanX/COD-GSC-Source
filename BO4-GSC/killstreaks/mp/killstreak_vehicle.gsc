/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\killstreak_vehicle.gsc
*************************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\audio_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\oob;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_ai_shared;
#include scripts\core_common\vehicle_death_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\core_common\vehicles\rcxd;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\killstreaks\killstreak_bundles;
#include scripts\killstreaks\killstreak_hacking;
#include scripts\killstreaks\killstreakrules_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\remote_weapons;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\weapons\deployable;

#namespace killstreak_vehicle;

init() {
  clientfield::register("vehicle", "stunned", 1, 1, "int");
}

init_killstreak(bundle) {
  killstreaks::register_bundle(bundle, &activate_vehicle);
  killstreaks::allow_assists(bundle.kstype, 1);
  remote_weapons::registerremoteweapon(bundle.ksweapon.name, #"", &function_c9aa9ee5, &function_8cb72281, 0);
  vehicle::add_main_callback(bundle.ksvehicle, &init_vehicle);
  deployable::register_deployable(bundle.ksweapon, undefined, undefined);
  level.killstreaks[bundle.kstype].var_b6c17aab = 1;

  if(isDefined(bundle.ksvehiclepost)) {
    visionset_mgr::register_info("overlay", bundle.ksvehiclepost, 1, 1, 1, 1);
  }
}

init_vehicle() {
  vehicle = self;
  vehicle clientfield::set("enemyvehicle", 1);
  vehicle.allowfriendlyfiredamageoverride = &function_e9da8b7d;
  vehicle enableaimassist();
  vehicle setdrawinfrared(1);
  vehicle.delete_on_death = 1;
  vehicle.death_enter_cb = &function_3c6cec8b;
  vehicle.disableremoteweaponswitch = 1;
  vehicle.overridevehicledamage = &on_damage;
  vehicle.overridevehiclekilled = &on_death;
  vehicle.watch_remote_weapon_death = 1;
  vehicle.watch_remote_weapon_death_duration = 0.3;
  vehicle util::make_sentient();
}

function_3c6cec8b() {
  remote_controlled = isDefined(self.control_initiated) && self.control_initiated || isDefined(self.controlled) && self.controlled;

  if(remote_controlled) {
    notifystring = self waittill(#"remote_weapon_end", #"shutdown");

    if(notifystring._notify == "remote_weapon_end") {
      self waittill(#"shutdown");
    } else {
      self waittill(#"remote_weapon_end");
    }

    return;
  }

  self waittill(#"shutdown");
}

function_aba709c3(hacker) {
  vehicle = self;
  vehicle clientfield::set("toggle_lights", 1);
  vehicle.owner unlink();
  vehicle clientfield::set("vehicletransition", 0);
  vehicle.owner killstreaks::clear_using_remote();
  vehicle makevehicleunusable();
}

function_2df6e3bf(hacker) {
  killstreak_type = level.var_8997324c[self];
  bundle = level.killstreaks[killstreak_type].script_bundle;
  vehicle = self;
  hacker remote_weapons::useremoteweapon(vehicle, bundle.ksweapon, 1, 0);
  vehicle makevehicleunusable();
  vehicle killstreaks::set_killstreak_delay_killcam(killstreak_type);
  vehicle killstreak_hacking::set_vehicle_drivable_time_starting_now(vehicle);
}

function_fff56140(owner) {
  self endon(#"shutdown");
  self killstreaks::function_fff56140(owner, &function_822e1f64);
}

function_5e2ea3ef(owner, ishacked) {
  self thread function_fff56140(owner);
}

can_activate(placement) {
  if(!isDefined(placement)) {
    return false;
  }

  if(!self isonground()) {
    return false;
  }

  if(self util::isusingremote()) {
    return false;
  }

  if(killstreaks::is_interacting_with_object()) {
    return false;
  }

  if(self oob::istouchinganyoobtrigger()) {
    return false;
  }

  return true;
}

activate_vehicle(type) {
  assert(isplayer(self));
  player = self;

  if(!player killstreakrules::iskillstreakallowed(type, player.team)) {
    return false;
  }

  if(player usebuttonpressed()) {
    return false;
  }

  bundle = level.killstreaks[type].script_bundle;

  if(isDefined(bundle.ksweapon) && isDefined(bundle.ksweapon.deployable) && bundle.ksweapon.deployable && !deployable::function_b3d993e9(bundle.ksweapon, 1)) {
    return false;
  }

  killstreak_id = player killstreakrules::killstreakstart(type, player.team, 0, 1);

  if(killstreak_id == -1) {
    return false;
  }

  vehicle = spawnvehicle(bundle.ksvehicle, player.var_b8878ba9, player.var_ddc03e10, type);
  vehicle deployable::function_dd266e08(player);
  vehicle killstreaks::configure_team(type, killstreak_id, player, "small_vehicle", undefined, &function_5e2ea3ef);
  vehicle killstreak_hacking::enable_hacking(type, &function_aba709c3, &function_2df6e3bf);
  vehicle.damagetaken = 0;
  vehicle.abandoned = 0;
  vehicle.killstreak_id = killstreak_id;
  vehicle.activatingkillstreak = 1;
  vehicle setinvisibletoall();
  vehicle thread watch_shutdown(player);
  vehicle.health = bundle.kshealth;
  vehicle.maxhealth = bundle.kshealth;
  vehicle.hackedhealth = bundle.kshackedhealth;
  vehicle.hackedhealthupdatecallback = &function_f07460c5;
  vehicle.ignore_vehicle_underneath_splash_scalar = 1;

  if(isDefined(bundle.ksweapon)) {
    vehicle setweapon(bundle.ksweapon);
    vehicle.weapon = bundle.ksweapon;
  }

  vehicle killstreak_bundles::spawned(bundle);
  self thread killstreaks::play_killstreak_start_dialog(type, self.team, killstreak_id);
  self stats::function_e24eec31(bundle.ksweapon, #"used", 1);
  remote_weapons::useremoteweapon(vehicle, bundle.ksweapon.name, 1, 0);

  if(!isDefined(player) || !isalive(player) || isDefined(player.laststand) && player.laststand || player isempjammed()) {
    if(isDefined(vehicle)) {
      vehicle notify(#"remote_weapon_shutdown");
      vehicle function_1f46c433();
    }

    return false;
  }

  if(!isDefined(vehicle)) {
    return false;
  }

  vehicle setvisibletoall();
  vehicle.activatingkillstreak = 0;
  target_set(vehicle);
  ability_player::function_c22f319e(bundle.ksweapon);
  vehicle thread watch_game_ended();
  vehicle waittill(#"death");
  return true;
}

function_f07460c5(hacker) {
  vehicle = self;

  if(vehicle.health > vehicle.hackedhealth) {
    vehicle.health = vehicle.hackedhealth;
  }
}

function_c9aa9ee5(vehicle) {
  player = self;
  vehicle usevehicle(player, 0);
  vehicle clientfield::set("vehicletransition", 1);
  vehicle thread audio::sndupdatevehiclecontext(1);
  vehicle thread watch_timeout();
  vehicle thread function_2cee4434();
  vehicle thread function_22528515();
  vehicle thread watch_water();
  player vehicle::set_vehicle_drivable_time_starting_now(int(vehicle.var_22a05c26.ksduration));

  if(isDefined(vehicle.var_22a05c26.ksvehiclepost)) {
    visionset_mgr::activate("overlay", vehicle.var_22a05c26.ksvehiclepost, player, 1, 90000, 1);
  }

  if(isbot(self)) {
    if(isDefined(vehicle.killstreaktype) && (vehicle.killstreaktype == "recon_car" || vehicle.killstreaktype == "inventory_recon_car")) {
      self thread function_88d23aaa(vehicle);
    }
  }
}

function_88d23aaa(vehicle) {
  var_8eaf8b3c = vehicle.overridevehiclekilled;
  vehicle thread rcxd::function_91ea9492();
  vehicle vehicle_ai::get_state_callbacks("death").update_func = undefined;
  vehicle.overridevehiclekilled = var_8eaf8b3c;
}

function_8cb72281(vehicle, exitrequestedbyowner) {
  if(exitrequestedbyowner == 0) {
    vehicle function_1f46c433();
    vehicle thread audio::sndupdatevehiclecontext(0);
  }

  if(isDefined(vehicle.var_22a05c26.ksvehiclepost)) {
    visionset_mgr::deactivate("overlay", vehicle.var_22a05c26.ksvehiclepost, vehicle.owner);
  }

  vehicle clientfield::set("vehicletransition", 0);
  function_68a07849(vehicle.var_22a05c26, self.remoteowner);
}

function_2cee4434() {
  vehicle = self;
  vehicle endon(#"shutdown", #"death");

  while(isDefined(level.var_46f4865d) && level.var_46f4865d) {
    waitframe(1);
  }

  while(!(isDefined(vehicle.owner) && (vehicle.owner attackbuttonpressed() || vehicle.owner vehicleattackbuttonpressed()))) {
    waitframe(1);
  }

  vehicle function_1f46c433();
}

watch_exit() {
  vehicle = self;
  vehicle endon(#"shutdown", #"death");

  while(true) {
    timeused = 0;

    while(vehicle.owner usebuttonpressed()) {
      timeused += level.var_9fee970c;

      if(timeused >= 250) {
        vehicle function_1f46c433();
        return;
      }

      waitframe(1);
    }

    waitframe(1);
  }
}

function_e99d09a3() {
  self endon(#"shutdown");

  for(inwater = 0; !inwater; inwater = trace[#"fraction"] < 1) {
    wait 0.5;
    trace = physicstrace(self.origin + (0, 0, 10), self.origin + (0, 0, 6), (-2, -2, -2), (2, 2, 2), self, 4);
  }

  self function_822e1f64();
}

watch_water() {
  self endon(#"shutdown");
  var_8a7edebd = 10;

  for(inwater = 0; !inwater; inwater = depth > var_8a7edebd) {
    wait 0.5;
    depth = getwaterheight(self.origin) - self.origin[2];
  }

  self function_822e1f64();
}

watch_timeout() {
  vehicle = self;
  bundle = vehicle.var_22a05c26;
  vehicle thread killstreaks::waitfortimeout(bundle.kstype, bundle.ksduration, &function_1f46c433, "shutdown");
}

function_822e1f64() {
  vehicle = self;
  vehicle.abandoned = 1;
  vehicle function_1f46c433();
}

function_1f46c433() {
  vehicle = self;
  vehicle notify(#"shutdown");
}

function_68a07849(bundle, driver) {
  if(isDefined(driver)) {
    var_4dd90b81 = 0;
    driver ability_player::function_f2250880(bundle.ksweapon, var_4dd90b81);
  }
}

watch_shutdown(driver) {
  vehicle = self;
  vehicle endon(#"death");
  vehicle waittill(#"shutdown");
  bundle = vehicle.var_22a05c26;
  vehicle notify(#"remote_weapon_shutdown");

  if(isDefined(vehicle.activatingkillstreak) && vehicle.activatingkillstreak) {
    killstreakrules::killstreakstop(bundle.kstype, vehicle.originalteam, vehicle.killstreak_id);
    vehicle function_1f46c433();
    vehicle delete();
  } else {
    vehicle thread function_584fb7a3();
  }

  vehicle killstreaks::function_67bc25ec();
  function_68a07849(bundle, driver);
}

function_584fb7a3() {
  vehicle = self;
  vehicle endon(#"death");

  if(!(isDefined(vehicle.remote_weapon_end) && vehicle.remote_weapon_end)) {
    vehicle waittill(#"remote_weapon_end", #"hash_59b25025ce93a142");
  }

  attacker = isDefined(vehicle.owner) ? vehicle.owner : undefined;
  vehicle dodamage(vehicle.health + 1, vehicle.origin + (0, 0, 10), attacker, attacker, "none", "MOD_EXPLOSIVE", 0);
}

function_22528515() {
  vehicle = self;
  vehicle endon(#"shutdown");

  while(true) {
    waitresult = vehicle waittill(#"touch");
    ent = waitresult.entity;

    if(isDefined(ent.classname) && (ent.classname == "trigger_hurt_new" || ent.classname == "trigger_out_of_bounds")) {
      vehicle function_1f46c433();
    }
  }
}

on_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(self.activatingkillstreak) {
    return 0;
  }

  if(!isDefined(eattacker) || eattacker != self.owner) {
    bundle = self.var_22a05c26;
    idamage = killstreaks::ondamageperweapon(bundle.kstype, eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
  }

  if(isDefined(eattacker) && isDefined(eattacker.team) && util::function_fbce7263(eattacker.team, self.team)) {
    if(weapon.isemp) {
      self.damage_on_death = 0;
      self.died_by_emp = 1;
      idamage = self.health + 1;
    }
  }

  return idamage;
}

on_death(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  vehicle = self;
  player = vehicle.owner;
  player endon(#"disconnect", #"joined_team", #"joined_spectators");
  bundle = self.var_22a05c26;
  var_7d4f75e = isDefined(vehicle.var_7d4f75e) ? vehicle.var_7d4f75e : 0;
  var_a9911aeb = bundle.kstype;
  var_a8527b41 = vehicle.originalteam;
  var_ebe66d84 = vehicle.killstreak_id;

  if(!var_7d4f75e) {
    killstreakrules::killstreakstop(var_a9911aeb, var_a8527b41, var_ebe66d84);
  }

  vehicle clientfield::set("enemyvehicle", 0);
  vehicle explode(eattacker, weapon);
  var_2105be53 = vehicle.died_by_emp === 1 ? 0.2 : 0.1;

  if(isDefined(player)) {
    player val::set(#"hash_7412aa1ce117e2a5", "freezecontrols");
    vehicle thread function_de865657(var_2105be53);
    wait 0.2;
    player val::reset(#"hash_7412aa1ce117e2a5", "freezecontrols");
  } else {
    vehicle thread function_de865657(var_2105be53);
  }

  if(var_7d4f75e) {
    killstreakrules::killstreakstop(var_a9911aeb, var_a8527b41, var_ebe66d84);
  }

  if(isDefined(vehicle)) {
    vehicle function_1f46c433();
  }
}

watch_game_ended() {
  vehicle = self;
  vehicle endon(#"death");
  level waittill(#"game_ended");
  vehicle.selfdestruct = 1;
  vehicle function_822e1f64();
}

function_de865657(waittime) {
  self endon(#"death");
  wait waittime;
  self ghost();
  self.var_4217cfcb = 1;
}

vehicle_death() {
  self vehicle_death::death_fx();
  self thread vehicle_death::death_radius_damage();
  self thread vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  self vehicle::toggle_tread_fx(0);
  self vehicle::toggle_exhaust_fx(0);
  self vehicle::toggle_sounds(0);
  self vehicle::lights_off();
}

explode(attacker, weapon) {
  self endon(#"death");
  owner = self.owner;

  if(!isDefined(attacker) && isDefined(owner)) {
    attacker = owner;
  }

  attacker = self[[level.figure_out_attacker]](attacker);
  self vehicle_death();
  destroyedbyenemy = 0;
  var_3906173b = isDefined(weapon) && weapon.name === "gadget_icepick";

  if(!(isDefined(self.abandoned) && self.abandoned) && isplayer(attacker)) {
    bundle = self.var_22a05c26;

    if(util::function_fbce7263(self.team, attacker.team)) {
      if(isDefined(bundle)) {
        attacker challenges::destroy_killstreak_vehicle(weapon, self, bundle.var_ebc402ca);
      }

      destroyedbyenemy = 1;

      if(isDefined(bundle)) {
        self killstreaks::function_73566ec7(attacker, weapon, owner);
        luinotifyevent(#"player_callout", 2, bundle.var_cbe3d7de, attacker.entnum);

        if(isDefined(weapon) && weapon.isvalid) {
          level.globalkillstreaksdestroyed++;
          attacker stats::function_e24eec31(bundle.ksweapon, #"destroyed", 1);
          attacker stats::function_e24eec31(bundle.ksweapon, #"destroyed_controlled_killstreak", 1);
        }

        if(!var_3906173b) {
          self killstreaks::play_destroyed_dialog_on_owner(bundle.kstype, self.killstreak_id);
          attacker battlechatter::function_dd6a6012(bundle.kstype, weapon);
        }
      }
    }
  }

  if(isDefined(bundle) && isDefined(bundle.var_bb6c29b4) && isDefined(weapon) && weapon == getweapon(#"shock_rifle")) {
    playFX(bundle.var_bb6c29b4, self.origin);
  }

  return destroyedbyenemy;
}

function_e9da8b7d(einflictor, eattacker, smeansofdeath, weapon) {
  if(isDefined(eattacker) && eattacker == self.owner) {
    return true;
  }

  if(isDefined(einflictor) && einflictor islinkedto(self)) {
    return true;
  }

  return false;
}

function_e94c2667() {
  startheight = 50;

  switch (self getstance()) {
    case #"crouch":
      startheight = 30;
      break;
    case #"prone":
      startheight = 15;
      break;
  }

  return startheight;
}

function_d75fbe15(origin, angles) {
  startheight = function_e94c2667();
  mins = (-5, -5, 0);
  maxs = (5, 5, 10);
  startpoints = [];
  startangles = [];
  wheelcounts = [];
  testcheck = [];
  largestcount = 0;
  largestcountindex = 0;
  testangles = [];
  testangles[0] = (0, 0, 0);
  testangles[1] = (0, 20, 0);
  testangles[2] = (0, -20, 0);
  testangles[3] = (0, 45, 0);
  testangles[4] = (0, -45, 0);
  heightoffset = 5;

  for(i = 0; i < testangles.size; i++) {
    testcheck[i] = 0;
    startangles[i] = (0, angles[1], 0);
    startpoint = origin + vectorscale(anglesToForward(startangles[i] + testangles[i]), 70);
    endpoint = startpoint - (0, 0, 100);
    startpoint += (0, 0, startheight);
    mask = 1 | 2;
    trace = physicstrace(startpoint, endpoint, mins, maxs, self, mask);

    if(isDefined(trace[#"entity"]) && isplayer(trace[#"entity"])) {
      wheelcounts[i] = 0;
      continue;
    }

    startpoints[i] = trace[#"position"] + (0, 0, heightoffset);
    wheelcounts[i] = function_c82e14d2(startpoints[i], startangles[i], heightoffset);

    if(positionwouldtelefrag(startpoints[i])) {
      continue;
    }

    if(largestcount < wheelcounts[i]) {
      largestcount = wheelcounts[i];
      largestcountindex = i;
    }

    if(wheelcounts[i] >= 3) {
      testcheck[i] = 1;

      if(function_b4682bd6(startpoints[i], startangles[i])) {
        placement = spawnStruct();
        placement.origin = startpoints[i];
        placement.angles = startangles[i];
        return placement;
      }
    }
  }

  for(i = 0; i < testangles.size; i++) {
    if(!testcheck[i]) {
      if(wheelcounts[i] >= 2) {
        if(function_b4682bd6(startpoints[i], startangles[i])) {
          placement = spawnStruct();
          placement.origin = startpoints[i];
          placement.angles = startangles[i];
          return placement;
        }
      }
    }
  }

  return undefined;
}

function_c82e14d2(origin, angles, heightoffset) {
  forward = 13;
  side = 10;
  wheels = [];
  wheels[0] = (forward, side, 0);
  wheels[1] = (forward, -1 * side, 0);
  wheels[2] = (-1 * forward, -1 * side, 0);
  wheels[3] = (-1 * forward, side, 0);
  height = 5;
  touchcount = 0;
  yawangles = (0, angles[1], 0);

  for(i = 0; i < 4; i++) {
    wheel = rotatepoint(wheels[i], yawangles);
    startpoint = origin + wheel;
    endpoint = startpoint + (0, 0, -1 * height - heightoffset);
    startpoint += (0, 0, height - heightoffset);
    trace = bulletTrace(startpoint, endpoint, 0, self);

    if(trace[#"fraction"] < 1) {
      touchcount++;
    }
  }

  return touchcount;
}

function_b4682bd6(origin, angles) {
  liftedorigin = origin + (0, 0, 5);
  size = 12;
  height = 15;
  mins = (-1 * size, -1 * size, 0);
  maxs = (size, size, height);
  absmins = liftedorigin + mins;
  absmaxs = liftedorigin + maxs;

  if(boundswouldtelefrag(absmins, absmaxs)) {
    return false;
  }

  startheight = function_e94c2667();
  mask = 1 | 2 | 4;
  trace = physicstrace(liftedorigin, origin + (0, 0, 1), mins, maxs, self, mask);

  if(trace[#"fraction"] < 1) {
    return false;
  }

  size = 2.5;
  height = size * 2;
  mins = (-1 * size, -1 * size, 0);
  maxs = (size, size, height);
  sweeptrace = physicstrace(self.origin + (0, 0, startheight), liftedorigin, mins, maxs, self, mask);

  if(sweeptrace[#"fraction"] < 1) {
    return false;
  }

  return true;
}