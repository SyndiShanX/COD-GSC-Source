/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_mini_turret.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\placeables;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\popups_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\turret_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_ai_shared;
#include scripts\core_common\vehicle_death_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\weapons\deployable;
#include scripts\weapons\weaponobjects;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_utility;

#namespace mini_turret;

autoexec __init__system__() {
  system::register(#"mini_turret", &__init__, undefined, #"zm_weapons");
}

__init__() {
  clientfield::register("vehicle", "mini_turret_open", 1, 1, "int");
  vehicle::add_main_callback("veh_mini_turret_zm", &initturret);
  weaponobjects::function_e6400478(#"mini_turret", &function_c41ea657, undefined);
  callback::on_revived(&on_player_revived);
  deployable::register_deployable(getweapon(#"mini_turret"), &function_2994c93, undefined, undefined, #"hash_2afe1c9235ce67ab");
  zm::function_84d343d(#"mini_turret", &function_58c4db23);
  zm::function_84d343d(#"gun_mini_turret", &function_58c4db23);
}

function_2994c93(v_origin, v_angles, player) {
  if(zm_utility::check_point_in_playable_area(v_origin) && zm_utility::check_point_in_enabled_zone(v_origin, 1) && ispointonnavmesh(v_origin)) {
    return true;
  }

  return false;
}

function_58c4db23(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  var_b1c1c5cf = zm_equipment::function_7d948481(0.1, 0.1, 0.1, 1);
  var_5d7b4163 = zm_equipment::function_379f6b5d(damage, var_b1c1c5cf, 0.3, 4, 40);
  return var_5d7b4163;
}

on_player_revived(s_params) {
  if(isDefined(s_params) && isplayer(s_params.e_revivee)) {
    e_revivee = s_params.e_revivee;
  } else if(isplayer(self)) {
    e_revivee = self;
  }

  if(isDefined(e_revivee)) {
    e_revivee thread weaponobjects::watchweaponobjectusage();
    e_revivee thread weaponobjects::watchweaponobjectspawn();
  }
}

initturret() {
  turretvehicle = self;
  turretvehicle.dontfreeme = 1;
  turretvehicle.damage_on_death = 0;
  turretvehicle.delete_on_death = undefined;
  turretvehicle.maxhealth = 2000;
  turretvehicle.damagetaken = 0;
  turretvehicle.health = turretvehicle.maxhealth;
  turretvehicle.maxsightdistsqrd = 2500 * 2500;
  turretvehicle turretsetontargettolerance(0, 15);
  turretvehicle.soundmod = "mini_turret";
  turretvehicle.overridevehicledamage = &onturretdamage;
  turretvehicle.overridevehiclekilled = &onturretdeath;
}

function_c41ea657(watcher) {
  watcher.onspawn = &function_3be2d17f;
  watcher.deleteonplayerspawn = 0;
  watcher.ontimeout = &function_d3ea6abe;
}

function_3be2d17f(watcher, player) {
  player endon(#"death", #"disconnect");
  level endon(#"game_ended");
  self endon(#"death");
  slot = player gadgetgetslot(self.weapon);

  if(isDefined(player.b_talisman_extra_miniturret) && player.b_talisman_extra_miniturret) {
    n_charge = player gadgetpowerget(slot);
    player gadgetpowerset(slot, n_charge - 50);
  } else {
    player gadgetpowerreset(slot);
    player gadgetpowerset(slot, 0);
  }

  self weaponobjects::onspawnuseweaponobject(watcher, player);
  self hide();

  if(isDefined(player)) {
    player val::set(#"mini_turret", "freezecontrols");
  }

  self waittill(#"stationary");
  player stats::function_e24eec31(self.weapon, #"used", 1);
  self deployable::function_dd266e08(player);
  self.origin += (0, 0, 2);
  player onplaceturret(self);

  if(isDefined(player)) {
    player val::reset(#"mini_turret", "freezecontrols");
  }

  if(!isDefined(player.mini_turrets)) {
    player.mini_turrets = [];
  }

  if(!isDefined(player.mini_turrets)) {
    player.mini_turrets = [];
  } else if(!isarray(player.mini_turrets)) {
    player.mini_turrets = array(player.mini_turrets);
  }

  player.mini_turrets[player.mini_turrets.size] = self.vehicle;

  if(isDefined(self.weapon) && isDefined(self.vehicle)) {
    self.vehicle thread weaponobjects::function_d9c08e94(self.weapon.fusetime, &function_99f0804f);
    self.vehicle clientfield::set("mini_turret_open", 1);
  }

  self ghost();
  self thread function_24910d60();
  self.vehicle thread function_7f9eb7f();
}

function_d3ea6abe() {
  if(isDefined(self) && isDefined(self.vehicle)) {
    self.vehicle thread function_99f0804f();
  }
}

function_24910d60() {
  vehicle = self.vehicle;
  waitresult = self waittill(#"death");

  if(waitresult._notify != "death") {
    return;
  }

  if(isDefined(vehicle)) {
    vehicle function_45ffb470(undefined, undefined);
  }
}

function_7f9eb7f() {
  owner = self.owner;
  owner endon(#"disconnect");
  waitresult = self waittill(#"death", #"death_started");

  if(!isDefined(self)) {
    arrayremovevalue(owner.mini_turrets, undefined);
    return;
  }

  if(self.damagetaken > self.health) {
    arrayremovevalue(owner.mini_turrets, self);
  }
}

onplaceturret(turret) {
  player = self;
  assert(isplayer(player));

  if(isDefined(turret.vehicle)) {
    turret.vehicle.origin = turret.origin;
    turret.vehicle.angles = turret.angles;
    turret.vehicle thread util::ghost_wait_show(0.05);
    turret.vehicle playSound(#"mpl_turret_startup");
  } else {
    turret.vehicle = spawnvehicle("veh_mini_turret_zm", turret.origin, turret.angles, "dynamic_spawn_ai");
    turret.vehicle.owner = player;
    turret.vehicle setowner(player);
    turret.vehicle.ownerentnum = player.entnum;
    turret.vehicle.parentstruct = turret;
    turret.vehicle.controlled = 0;
    turret.vehicle.treat_owner_damage_as_friendly_fire = 1;
    turret.vehicle.ignore_team_kills = 1;
    turret.vehicle.deal_no_crush_damage = 1;
    turret.vehicle.turret = turret;
    turret.vehicle.team = player.team;
    turret.vehicle setteam(player.team);
    turret.vehicle turret::set_team(player.team, 0);
    turret.vehicle turret::set_torso_targetting(0);
    turret.vehicle turret::set_target_leading(0);
    turret.vehicle.use_non_teambased_enemy_selection = 1;
    turret.vehicle.waittill_turret_on_target_delay = 0.25;
    turret.vehicle.ignore_vehicle_underneath_splash_scalar = 1;
    turret.vehicle thread turret_watch_owner_events();
    turret.vehicle thread turret_laser_watch();
    turret.vehicle thread setup_death_watch_for_new_targets();
    turret.vehicle thread function_31477582();
    turret.vehicle thread util::ghost_wait_show(0.05);
    turret.vehicle.var_63d65a8d = "arc";
    turret.vehicle notsolid();

    if(issentient(turret.vehicle) == 0) {
      turret.vehicle makesentient();
    }

    player stats::function_e24eec31(getweapon(#"mini_turret"), #"used", 1);
  }

  turret.vehicle playLoopSound(#"hash_69240c6db92da5bf", 0.25);
  turret.vehicle.turret_enabled = 1;
  target_set(turret.vehicle, (0, 0, 36));
  turret.vehicle unlink();
  turret.vehicle vehicle::connect_paths();
  turret.vehicle thread turretscanning();
}

onturretdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  empdamage = int(idamage + self.healthdefault * 1 + 0.5);
  var_820fb5ae = self.damagetaken;
  self.damagetaken += idamage;

  if(self.controlled) {
    self.owner vehicle::update_damage_as_occupant(self.damagetaken, self.maxhealth);
  }

  if(self.damagetaken > 100 && 100 >= var_820fb5ae) {
    playFXOnTag(#"hash_3215f91a276a69ec", self, "tag_fx");
  }

  if(self.damagetaken > self.maxhealth && !isDefined(self.will_die)) {
    self.will_die = 1;
    self thread ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  }

  return idamage;
}

onturretdeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  waittillframeend();

  if(isDefined(self)) {
    self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  }
}

ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  turretvehicle = self;
  turretvehicle notify(#"death_started");

  if(turretvehicle.dead === 1) {
    return;
  }

  turretvehicle.dead = 1;
  turretvehicle disabledriverfiring(1);
  turretvehicle.turret_enabled = 0;
  eattacker = self[[level.figure_out_attacker]](eattacker);

  if(isDefined(turretvehicle.parentstruct)) {
    turretvehicle.parentstruct placeables::forceshutdown();
  }

  if(isDefined(level.var_d2600afc)) {
    self[[level.var_d2600afc]](eattacker, self.owner, self.turretweapon);
  }

  turretvehicle stoploopsound(0.5);
  turretvehicle playSound("mpl_turret_exp");
  playFX(level._equipment_explode_fx_lg, self.origin);

  if(isDefined(self.owner) && isDefined(level.playequipmentdestroyedonplayer)) {
    self.owner[[level.playequipmentdestroyedonplayer]]();
  }

  var_980fde21 = self.turret;
  wait 0.1;

  if(isDefined(turretvehicle)) {
    turretvehicle ghost();
    turretvehicle notsolid();
    turretvehicle waittilltimeout(2, #"remote_weapon_end", #"death");
  }

  if(isDefined(turretvehicle)) {
    while(isDefined(turretvehicle) && (turretvehicle.controlled || !isDefined(turretvehicle.owner))) {
      waitframe(1);
    }

    if(isDefined(turretvehicle)) {
      turretvehicle.dontfreeme = undefined;
      wait 0.5;
    }

    if(isDefined(turretvehicle)) {
      turretvehicle delete();
    }
  }

  if(isDefined(var_980fde21)) {
    var_980fde21 delete();
  }
}

onshutdown(turret) {
  turret notify(#"mini_turret_shutdown");
}

turret_watch_owner_events() {
  self notify(#"turret_watch_owner_events_singleton");
  self endon(#"death", #"turret_watch_owner_events_singleton");
  self.owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"changed_specialist");
  self makevehicleusable();
  self.controlled = 0;

  if(isDefined(self.owner)) {
    self.owner unlink();
  }

  self makevehicleunusable();
  self.abandoned = 1;
  onshutdown(self);
  self function_99f0804f();
}

turret_laser_watch() {
  veh = self;
  veh endon(#"death");

  while(true) {
    laser_should_be_on = !veh.controlled && isDefined(veh.enemy);

    if(laser_should_be_on) {
      if(islaseron(veh) == 0) {
        veh vehicle::enable_laser(1, 0);
      }
    } else if(islaseron(veh)) {
      veh vehicle::enable_laser(0, 0);
    }

    wait 0.25;
  }
}

setup_death_watch_for_new_targets() {
  turretvehicle = self;
  turretvehicle endon(#"death");

  for(old_target = undefined; true; old_target = waitresult.target) {
    waitresult = turretvehicle waittill(#"has_new_target");

    if(isDefined(old_target)) {
      old_target notify(#"abort_death_watch");
    }

    waitresult.target thread target_death_watch(turretvehicle);
  }
}

target_death_watch(turretvehicle) {
  target = self;
  target endon(#"abort_death_watch");
  turretvehicle endon(#"death");
  target waittill(#"death", #"disconnect", #"joined_team", #"joined_spectators");
  turretvehicle clearenemy();
}

turretscanning() {
  veh = self;
  veh endon(#"death", #"death_started", #"end_turret_scanning");
  veh.turret_target = undefined;
  veh.do_not_clear_targets_during_think = 1;
  wait 0.8;
  veh playSound(#"mpl_turret_startup");
  veh playLoopSound(#"hash_69240c6db92da5bf");

  while(true) {
    if(veh.controlled || !veh.turret_enabled) {
      wait 0.5;
      continue;
    }

    if(isDefined(veh.enemy)) {
      if(isvehicle(veh.enemy) && issentient(veh.enemy) && !(veh.enemy.var_232915af === 1)) {
        veh setignoreent(veh.enemy, 1);
        wait 0.1;
        continue;
      }
    }

    if(veh has_active_enemy() && isDefined(veh.enemy) && isalive(veh.enemy)) {
      veh.turretrotscale = getdvarfloat(#"hash_7a767607be3081e9", 3);

      if(!isDefined(veh.turret_target) || veh.turret_target != veh.enemy) {
        veh vehicle_ai::setturrettarget(veh.enemy, 0, (0, 0, -15));
        veh.turret_target = veh.enemy;
        veh playsoundtoteam("mpl_turret_alert", veh.team);
      }

      if(veh.turretontarget) {
        if(true) {
          fire_time = 0.33 > 0.33 ? 0.33 : randomfloatrange(0.33, 0.33);
          var_fc9f290e = veh.enemy;
          veh vehicle_ai::fire_for_time(fire_time, 0, veh.enemy);
          var_afae28e0 = !isDefined(var_fc9f290e) || !isalive(var_fc9f290e);

          if(0.34 > 0 && !var_afae28e0) {
            pause_time = 0.34 > 0.34 ? 0.34 : randomfloatrange(0.34, 0.34);
            waitresult = veh.turret_target waittilltimeout(pause_time, #"death", #"disconnect");
            var_afae28e0 = waitresult._notify === "death";
          }
        } else {
          var_fc9f290e = veh.enemy;
          veh vehicle_ai::fire_for_rounds(10, 0, veh.enemy);
          var_afae28e0 = !isDefined(var_fc9f290e) || !isalive(var_fc9f290e);
        }

        if(var_afae28e0 && isDefined(veh.turret_target) && isDefined(veh.turret_target.var_e78602fc) && veh.turret_target.var_e78602fc == veh) {
          veh.owner playsoundtoplayer(#"hash_7ea486136cd776c", veh.owner);
          veh.turretrotscale = 1;
          wait randomfloatrange(0.05, 0.2);
        }
      } else {
        wait 0.25;
      }

      continue;
    }

    var_4ec572ee = isDefined(veh.turret_target);
    var_bb861d93 = 0;

    if(var_4ec572ee) {
      var_bb861d93 = isalive(veh.turret_target);
      veh setpersonalignore(veh.turret_target, 1.5);
    }

    veh clearenemy();
    veh.turret_target = undefined;
    veh.turretrotscale = 1;

    if(var_4ec572ee && var_bb861d93) {
      veh playsoundtoteam("mpl_turret_lost", veh.team);
    }

    if(veh.var_63d65a8d == "arc") {
      if(veh.scanpos === "left") {
        veh turretsettargetangles(0, (-20, 40, 0));
        veh.scanpos = "right";
      } else {
        veh turretsettargetangles(0, (-20, -40, 0));
        veh.scanpos = "left";
      }
    } else if(veh.scanpos === "left") {
      veh turretsettargetangles(0, (-20, 180, 0));
      veh.scanpos = "left2";
    } else if(veh.scanpos === "left2") {
      veh turretsettargetangles(0, (-20, 360, 0));
      veh.scanpos = "right";
    } else if(veh.scanpos === "right") {
      veh turretsettargetangles(0, (-20, -180, 0));
      veh.scanpos = "right2";
    } else {
      veh turretsettargetangles(0, (-20, -360, 0));
      veh.scanpos = "left";
    }

    veh waittilltimeout(3.5, #"enemy");
  }
}

has_active_enemy() {
  if(!isDefined(self.enemylastseentime)) {
    return false;
  }

  return gettime() < self.enemylastseentime + 1000;
}

function_99f0804f() {
  self thread function_45ffb470(undefined, undefined);
}

function_45ffb470(attacker, callback_data) {
  if(!isDefined(self)) {
    return;
  }

  if(self.dead === 1) {
    return;
  }

  playFX(level._equipment_explode_fx_lg, self.origin);
  self playSound("mpl_turret_exp");
  self stoploopsound(0.5);
  turret = self.turret;
  self delete();

  if(isDefined(self.turret)) {
    self.turret delete();
  }
}

function_31477582() {
  self endon(#"death");
  waitframe(1);
  var_463c449d = 386.089 * float(function_60d95f53()) / 1000;
  max_delta = 1;

  while(true) {
    if(!isDefined(self.turret)) {
      wait 1;
      continue;
    }

    trace = physicstrace(self.origin + (0, 0, 0), self.origin + (0, 0, -10), (-3, -3, -1), (3, 3, 1), self.turret, 1 | 16);

    if(trace[#"fraction"] > 0) {
      new_origin = trace[#"position"];
      self.origin = (new_origin[0], new_origin[1], self.origin[2] - min(max_delta, self.origin[2] - new_origin[2]));
      max_delta += var_463c449d;
      waitframe(1);
      continue;
    }

    max_delta = 1;
    wait 1;
  }
}