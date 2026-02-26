/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\killstreak_vehicle.gsc
***********************************************/

#using scripts\abilities\ability_player;
#using scripts\core_common\audio_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\rcxd;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_dialog;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\remote_weapons;
#using scripts\weapons\deployable;
#namespace killstreak_vehicle;

function init_killstreak(bundle) {
  killstreaks::register_bundle(bundle, &activate_vehicle);
  remote_weapons::registerremoteweapon(bundle.ksweapon.name, #"", &function_c9aa9ee5, &function_8cb72281, 0);
  remote_weapons::registerremoteweapon(bundle.ksinventoryweapon.name, #"", &function_c9aa9ee5, &function_8cb72281, 0);
  vehicle::add_main_callback(bundle.ksvehicle, &init_vehicle);
  deployable::register_deployable(bundle.ksweapon, undefined, undefined);
  deployable::register_deployable(bundle.ksinventoryweapon, undefined, undefined);
  level.killstreaks[bundle.kstype].var_b6c17aab = 1;

  if(isDefined(bundle.ksvehiclepost)) {
    visionset_mgr::register_info("overlay", bundle.ksvehiclepost, 1, 1, 1, 1);
  }
}

function init_vehicle(var_19e1140) {
  vehicle = self;
  vehicle clientfield::set("enemyvehicle", 1);
  vehicle clientfield::set("scorestreakActive", 1);
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
  vehicle.var_19e1140 = var_19e1140;
  vehicle util::make_sentient();
}

function function_3c6cec8b() {
  remote_controlled = is_true(self.control_initiated) || is_true(self.controlled);

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

function function_aba709c3(hacker) {
  vehicle = self;
  vehicle clientfield::set("toggle_lights", 1);
  vehicle.owner unlink();
  vehicle clientfield::set("vehicletransition", 0);
  vehicle.owner killstreaks::clear_using_remote();
  vehicle makevehicleunusable();
}

function function_2df6e3bf(hacker) {
  killstreak_type = level.var_8997324c[self];
  bundle = level.killstreaks[killstreak_type].script_bundle;
  weapon = level.killstreaks[killstreak_type].weapon;
  vehicle = self;
  hacker remote_weapons::useremoteweapon(vehicle, weapon, 1, 0);
  vehicle makevehicleunusable();
  vehicle killstreaks::set_killstreak_delay_killcam(killstreak_type);
  vehicle killstreak_hacking::set_vehicle_drivable_time_starting_now(vehicle);
}

function function_fff56140(owner) {
  self endon(#"shutdown");
  self killstreaks::function_fff56140(owner, &function_822e1f64);
}

function function_5e2ea3ef(owner, ishacked) {
  self thread function_fff56140(ishacked);
}

function can_activate(placement) {
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

function activate_vehicle(type) {
  assert(isPlayer(self));
  player = self;

  if(!player killstreakrules::iskillstreakallowed(type, player.team)) {
    return false;
  }

  if(player useButtonPressed()) {
    return false;
  }

  bundle = level.killstreaks[type].script_bundle;
  weapon = level.killstreaks[type].weapon;

  if(isDefined(weapon) && is_true(weapon.deployable) && !deployable::function_b3d993e9(weapon, 1)) {
    return false;
  }

  killstreak_id = player killstreakrules::killstreakstart(type, player.team, 0, 1);

  if(killstreak_id == -1) {
    return false;
  }

  vehicle = spawnvehicle(bundle.ksvehicle, player.var_b8878ba9, player.var_ddc03e10, type, 0, player);
  vehicle setowner(player);
  vehicle deployable::function_dd266e08(player);
  vehicle killstreaks::configure_team(type, killstreak_id, player, "small_vehicle", undefined, &function_5e2ea3ef);
  vehicle killstreak_hacking::enable_hacking(type, &function_aba709c3, &function_2df6e3bf);
  vehicle.damagetaken = 0;
  vehicle.abandoned = 0;
  vehicle.killstreak_id = killstreak_id;
  vehicle.activatingkillstreak = 1;
  vehicle ghost();
  vehicle thread watch_shutdown(player, type);
  vehicle.health = bundle.kshealth;
  vehicle.maxhealth = bundle.kshealth;
  vehicle.hackedhealth = bundle.kshackedhealth;
  vehicle.hackedhealthupdatecallback = &function_f07460c5;
  vehicle.ignore_vehicle_underneath_splash_scalar = 1;

  if(isDefined(weapon)) {
    vehicle setweapon(weapon);
    vehicle.weapon = weapon;
  }

  vehicle killstreak_bundles::spawned(bundle);
  self thread namespace_f9b02f80::play_killstreak_start_dialog(type, self.team, killstreak_id);
  self stats::function_e24eec31(weapon, #"used", 1);

  if(isDefined(vehicle.var_19e1140)) {
    vehicle[[vehicle.var_19e1140]]();
  }

  remote_weapons::useremoteweapon(vehicle, weapon.name, 1, 0);

  if(!isDefined(player) || !isalive(player) || is_true(player.laststand)) {
    if(isDefined(vehicle)) {
      vehicle notify(#"remote_weapon_shutdown");
      vehicle function_1f46c433();
    }

    return false;
  }

  if(!isDefined(vehicle)) {
    return false;
  }

  vehicle show();
  vehicle.activatingkillstreak = 0;
  target_set(vehicle);
  ability_player::function_c22f319e(weapon);
  vehicle thread watch_game_ended();
  vehicle.var_99178ae6 = player util::create_streamer_hint(player.origin, player.angles, 1, undefined, 0, 0);
  vehicle waittill(#"death");
  vehicle function_11fa7e00(type, vehicle.originalteam, killstreak_id);
  return true;
}

function function_11fa7e00(killstreak_type, original_team, killstreak_id, start_cooldown) {
  if(self.var_b8f3aeed !== 1) {
    self killstreakrules::killstreakstop(killstreak_type, original_team, killstreak_id, start_cooldown);
    self.var_b8f3aeed = 1;
  }
}

function function_f07460c5(hacker) {
  vehicle = self;

  if(vehicle.health > vehicle.hackedhealth) {
    vehicle.health = vehicle.hackedhealth;
  }
}

function function_c9aa9ee5(vehicle) {
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

function function_88d23aaa(vehicle) {
  var_8eaf8b3c = vehicle.overridevehiclekilled;
  vehicle thread rcxd::function_91ea9492();
  vehicle vehicle_ai::get_state_callbacks("death").update_func = undefined;
  vehicle.overridevehiclekilled = var_8eaf8b3c;
}

function function_8cb72281(vehicle, exitrequestedbyowner) {
  if(exitrequestedbyowner == 0) {
    vehicle thread audio::sndupdatevehiclecontext(0);
  }

  if(isDefined(vehicle.var_22a05c26.ksvehiclepost)) {
    visionset_mgr::deactivate("overlay", vehicle.var_22a05c26.ksvehiclepost, vehicle.owner);
  }

  vehicle clientfield::set("vehicletransition", 0);
  function_68a07849(vehicle.weapon, self.remoteowner);

  if(exitrequestedbyowner == 0) {
    vehicle function_1f46c433();
  }
}

function function_2cee4434() {
  vehicle = self;
  vehicle endon(#"shutdown", #"death");

  while(is_true(level.var_46f4865d)) {
    waitframe(1);
  }

  while(vehicle.activatingkillstreak) {
    waitframe(1);
  }

  while(!(isDefined(vehicle.owner) && (vehicle.owner attackButtonPressed() || vehicle.owner vehicleattackButtonPressed()) && vehicle.owner killstreaks::function_59e2c378())) {
    waitframe(1);
  }

  if(isDefined(vehicle.var_62b033f0)) {
    vehicle thread[[vehicle.var_62b033f0]]();
  }

  vehicle function_1f46c433();
}

function watch_exit() {
  vehicle = self;
  vehicle endon(#"shutdown", #"death");

  while(true) {
    timeused = 0;

    while(vehicle.owner useButtonPressed() && vehicle.owner killstreaks::function_59e2c378()) {
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

function function_e99d09a3() {
  self endon(#"shutdown");

  for(inwater = 0; !inwater; inwater = trace[#"fraction"] < 1) {
    wait 0.5;
    trace = physicstrace(self.origin + (0, 0, 10), self.origin + (0, 0, 6), (-2, -2, -2), (2, 2, 2), self, 4);
  }

  self function_822e1f64();
}

function watch_water() {
  self endon(#"shutdown");
  var_8a7edebd = isDefined(self.var_f3c54d1d) ? self.var_f3c54d1d : 10;

  for(inwater = 0; !inwater; inwater = depth > var_8a7edebd) {
    wait 0.5;
    depth = getwaterheight(self.origin) - self.origin[2];
  }

  if(isDefined(self.owner) && isDefined(self.var_22a05c26.kstype)) {
    self.owner killstreaks::function_e9873ef7(self.var_22a05c26.kstype, self.killstreak_id, #"hash_614e3e677f840d98");
  }

  self function_822e1f64();
}

function watch_timeout() {
  vehicle = self;
  bundle = vehicle.var_22a05c26;
  vehicle thread killstreaks::waitfortimeout(bundle.kstype, bundle.ksduration, &function_1f46c433, "shutdown");
}

function function_822e1f64() {
  vehicle = self;
  vehicle.abandoned = 1;
  vehicle function_1f46c433();
}

function function_1f46c433() {
  vehicle = self;
  vehicle notify(#"shutdown");
}

function function_68a07849(weapon, driver) {
  if(isDefined(driver)) {
    var_4dd90b81 = 0;
    driver ability_player::function_f2250880(weapon, var_4dd90b81);
  }
}

function watch_shutdown(driver, killstreaktype) {
  vehicle = self;
  vehicle endon(#"death");
  vehicle waittill(#"shutdown");
  bundle = vehicle.var_22a05c26;

  if(isDefined(vehicle.var_99178ae6)) {
    vehicle.var_99178ae6 thread util::delayed_delete(3);
  }

  if(isDefined(vehicle.activatingkillstreak) && vehicle.activatingkillstreak) {
    vehicle notify(#"remote_weapon_shutdown");
    vehicle function_11fa7e00(bundle.kstype, vehicle.originalteam, vehicle.killstreak_id, 0);
    vehicle function_1f46c433();
    vehicle deletedelay();
  } else if(level.gameended === 1) {
    vehicle function_11fa7e00(bundle.kstype, vehicle.originalteam, vehicle.killstreak_id);

    if(isDefined(vehicle)) {
      vehicle deletedelay();
    }
  } else {
    if(isDefined(vehicle.var_c1524340)) {
      vehicle thread[[vehicle.var_c1524340]]();
    } else {
      vehicle thread function_584fb7a3();
    }

    vehicle notify(#"remote_weapon_shutdown");
  }

  function_68a07849(vehicle.weapon, killstreaktype);
}

function function_584fb7a3() {
  vehicle = self;
  vehicle endon(#"death");

  if(!is_true(vehicle.remote_weapon_end)) {
    vehicle waittill(#"remote_weapon_end", #"hash_59b25025ce93a142");
  }

  attacker = isDefined(vehicle.owner) ? vehicle.owner : undefined;
  vehicle dodamage(vehicle.health + 1, vehicle.origin + (0, 0, 10), attacker, attacker, "none", "MOD_EXPLOSIVE", 0);
}

function function_22528515() {
  vehicle = self;
  vehicle endon(#"shutdown");

  while(true) {
    waitresult = vehicle waittill(#"touch");
    ent = waitresult.entity;

    if(isDefined(ent.classname) && (ent.classname == "trigger_hurt" || ent.classname == "trigger_out_of_bounds" && vehicle.var_a6ab9a09 !== 1)) {
      vehicle function_1f46c433();
    }
  }
}

function on_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(is_true(self.activatingkillstreak)) {
    return 0;
  }

  if(!isDefined(psoffsettime) || !isDefined(self.owner) || psoffsettime != self.owner) {
    bundle = self.var_22a05c26;
    damagefromunderneath = killstreaks::ondamageperweapon(bundle.kstype, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
  }

  if(isDefined(psoffsettime) && isDefined(psoffsettime.team) && util::function_fbce7263(psoffsettime.team, self.team)) {
    if(vsurfacenormal.isemp) {
      self.damage_on_death = 0;
      self.died_by_emp = 1;
      damagefromunderneath = self.health + 1;
    }
  }

  return damagefromunderneath;
}

function on_death(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  vehicle = self;
  player = vehicle.owner;

  if(isDefined(player)) {
    player endon(#"disconnect", #"joined_team", #"joined_spectators");
  }

  bundle = self.var_22a05c26;
  var_7d4f75e = isDefined(vehicle.var_7d4f75e) ? vehicle.var_7d4f75e : 0;
  var_a9911aeb = bundle.kstype;
  var_a8527b41 = vehicle.originalteam;
  var_ebe66d84 = vehicle.killstreak_id;
  vehicle killstreaks::function_67bc25ec();
  vehicle clientfield::set("enemyvehicle", 0);

  if(isDefined(vehicle.var_a0f50ca8)) {
    vehicle thread[[vehicle.var_a0f50ca8]]();
  }

  if(isDefined(vehicle.var_99178ae6)) {
    vehicle.var_99178ae6 thread util::delayed_delete(3);
  }

  vehicle explode(shitloc, psoffsettime);
  var_2105be53 = isDefined(vehicle.var_20c65a3e) ? vehicle.var_20c65a3e : vehicle.died_by_emp === 1 ? 0.2 : 0.2;

  if(isDefined(player)) {
    player val::set(#"hash_7412aa1ce117e2a5", "freezecontrols");
    vehicle thread function_de865657(var_2105be53);
    wait 0.2;

    if(isDefined(player)) {
      player val::reset(#"hash_7412aa1ce117e2a5", "freezecontrols");
    }
  } else {
    vehicle thread function_de865657(var_2105be53);
  }

  if(isDefined(vehicle)) {
    vehicle function_1f46c433();
  }
}

function watch_game_ended() {
  vehicle = self;
  vehicle endon(#"death");
  level waittill(#"game_ended");
  vehicle.selfdestruct = 1;
  vehicle function_822e1f64();
}

function function_de865657(waittime) {
  self endon(#"death");
  wait waittime;
  self ghost();
  self.var_4217cfcb = 1;
}

function vehicle_death() {
  self vehicle_death::death_fx();
  self thread vehicle_death::death_radius_damage();
  self thread vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
  self vehicle::toggle_tread_fx(0);
  self vehicle::toggle_exhaust_fx(0);
  self vehicle::toggle_sounds(0);
  self vehicle::lights_off();
}

function explode(attacker, weapon) {
  self endon(#"death");
  owner = self.owner;

  if(!isDefined(attacker) && isDefined(owner)) {
    attacker = owner;
  }

  attacker = self[[level.figure_out_attacker]](attacker);
  self vehicle_death();
  destroyedbyenemy = 0;
  var_3906173b = isDefined(weapon) && weapon.name === "gadget_icepick";

  if(!is_true(self.abandoned) && isPlayer(attacker)) {
    bundle = self.var_22a05c26;

    if(util::function_fbce7263(self.team, attacker.team)) {
      destroyedbyenemy = 1;

      if(isDefined(bundle)) {
        attacker challenges::destroy_killstreak_vehicle(weapon, self, bundle.var_ebc402ca);
        self killstreaks::function_73566ec7(attacker, weapon, owner);
        luinotifyevent(#"player_callout", 2, bundle.var_cbe3d7de, attacker.entnum);

        if(isDefined(weapon) && weapon.isvalid) {
          level.globalkillstreaksdestroyed++;
          attacker stats::function_e24eec31(self.weapon, #"destroyed", 1);
          attacker stats::function_e24eec31(self.weapon, #"destroyed_controlled_killstreak", 1);
          self.owner killstreaks::function_4aad9803(bundle.kstype, self.killstreak_id, weapon);
        }

        if(!var_3906173b) {
          self namespace_f9b02f80::play_destroyed_dialog_on_owner(bundle.kstype, self.killstreak_id);
          attacker battlechatter::function_eebf94f6(bundle.kstype, weapon);
        }

        self.owner killstreaks::function_e9873ef7(bundle.kstype, self.killstreak_id, #"streak_destroyed");
      }
    }
  }

  if(oob::istouchinganyoobtrigger() && !destroyedbyenemy && !var_3906173b) {
    self.owner killstreaks::function_e9873ef7(bundle.kstype, self.killstreak_id, #"hash_7e23b3e299f4835b");
  }

  if(isDefined(bundle) && isDefined(bundle.var_bb6c29b4) && isDefined(weapon) && weapon == getweapon(#"shock_rifle")) {
    playFX(bundle.var_bb6c29b4, self.origin);
  }

  return destroyedbyenemy;
}

function function_e9da8b7d(einflictor, eattacker, smeansofdeath, weapon) {
  if(isDefined(weapon) && weapon == self.owner) {
    return true;
  }

  if(isDefined(smeansofdeath) && smeansofdeath islinkedto(self)) {
    return true;
  }

  return false;
}

function function_e94c2667() {
  startheight = 50;

  switch (self getstance()) {
    case # "crouch":
      startheight = 30;
      break;
    case # "prone":
      startheight = 15;
      break;
  }

  return startheight;
}

function function_d75fbe15(origin, angles) {
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

    if(isDefined(trace[#"entity"]) && isPlayer(trace[#"entity"])) {
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

function function_c82e14d2(origin, angles, heightoffset) {
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

function function_b4682bd6(origin, angles) {
  liftedorigin = angles + (0, 0, 5);
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
  trace = physicstrace(liftedorigin, angles + (0, 0, 1), mins, maxs, self, mask);

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

function function_d4896942(bundle, killstreakname, customendon) {
  self endon(#"death", customendon);
  self.var_7132bbb7 = undefined;

  while(true) {
    self waittill(#"flare_deployed");
    self playSound(#"hash_713a3ce01967434e");
    self.var_7132bbb7 = 1;
    self namespace_f9b02f80::play_pilot_dialog_on_owner("damageEvaded", killstreakname, self.killstreak_id);
    self.var_b6286a42 = gettime() + 5000;
    wait isDefined(bundle.var_2eeb71d2) ? bundle.var_2eeb71d2 : 5;
    self.var_7132bbb7 = undefined;
  }
}

function function_31f9c728(bundle, killstreakname, var_61bbac7a, beep_alias, customendon) {
  self endon(#"death", customendon);

  while(true) {
    waitresult = self waittill(#"stinger_fired_at_me");

    if(isDefined(waitresult.projectile)) {
      self childthread function_849819e9(waitresult.projectile, bundle, killstreakname, var_61bbac7a);
      self childthread function_6650cc9c(waitresult.projectile, bundle, killstreakname, beep_alias);
    }
  }
}

function function_849819e9(missile, bundle, killstreakname, var_61bbac7a) {
  assert(isentity(missile));
  assert(isstruct(bundle));
  assert(isDefined(var_61bbac7a));

  if(!isDefined(self)) {
    return;
  }

  missile endon(#"death");
  var_d1fb4ef3 = isDefined(bundle.var_7d5e1fc0) ? bundle.var_7d5e1fc0 : 0.75;

  while(isDefined(self.owner) && self.owner util::function_63d27d4e(killstreakname)) {
    dist = distance(missile.origin, self.origin);
    velocity = missile getvelocity();
    missile_dir = vectornormalize(velocity);
    missile_speed = vectordot(missile_dir, velocity);

    if(missile_speed > 0) {
      if(dist < missile_speed * var_d1fb4ef3) {
        self playsoundtoplayer(var_61bbac7a, self.owner);
        return;
      }
    }

    wait 0.1;
  }
}

function function_6650cc9c(missile, bundle, killstreakname, beep_alias) {
  assert(isentity(missile));
  assert(isstruct(bundle));
  assert(isDefined(beep_alias));

  if(!isDefined(self)) {
    return;
  }

  missile endon(#"death");
  wait 0.2;

  if(isDefined(self.var_b6286a42) && self.var_b6286a42 < gettime()) {
    self namespace_f9b02f80::play_pilot_dialog_on_owner("incomingMissile", killstreakname, self.killstreak_id);
    self.var_b6286a42 = gettime() + 5000;
  }

  neardist = isDefined(bundle.var_4004fbc) ? bundle.var_4004fbc : 10;
  fardist = isDefined(bundle.var_364ccfdc) ? bundle.var_364ccfdc : 100;
  range = fardist - neardist;

  if(range < 0) {
    return;
  }

  var_6f2344f0 = isDefined(bundle.var_9fb2ddca) ? bundle.var_9fb2ddca : 0.05;
  var_cd12ce4c = isDefined(bundle.var_6e3967de) ? bundle.var_6e3967de : 0.05;
  dist = undefined;

  while(isDefined(self.owner) && self.owner util::function_63d27d4e(killstreakname)) {
    old_dist = dist;
    dist = distance(missile.origin, self.origin);
    var_38fa5914 = isDefined(old_dist) && dist < old_dist;

    if(var_38fa5914) {
      self playsoundtoplayer(beep_alias, self.owner);
    }

    normalizeddist = (dist - neardist) / range;
    beep_interval = lerpfloat(var_6f2344f0, var_cd12ce4c, normalizeddist);
    wait beep_interval;
  }
}