/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\vehicles\dart_wz.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\hud_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\popups_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_ai_shared;
#include scripts\core_common\vehicle_death_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\mp_common\item_inventory;
#include scripts\weapons\heatseekingmissile;

#namespace dart;

autoexec __init__system__() {
  system::register(#"dart_wz", &__init__, undefined, undefined);
}

__init__() {
  callback::on_item_use(&on_item_use);
  vehicle::add_main_callback("dart_wz", &function_79a59d11);
  clientfield::register("toplayer", "dart_wz_out_of_circle", 24000, 5, "int");
  clientfield::register("toplayer", "dart_wz_static_postfx", 24000, 1, "int");
  clientfield::register("vehicle", "dart_wz_timeout_beep", 1, 1, "int");
}

private kill_vehicle(attackingplayer, weapon = level.weaponnone) {
  damageorigin = self.origin + (0, 0, 1);
  self finishvehicleradiusdamage(self, undefined, 32000, 32000, 10, 0, "MOD_EXPLOSIVE", weapon, damageorigin, 400, -1, (0, 0, 1), 0);
}

private on_item_use(params) {
  self endon(#"death", #"disconnect");

  if(!isDefined(params.item) || !isDefined(params.item.itementry) || !isDefined(params.item.itementry.weapon) || params.item.itementry.weapon.name != #"dart") {
    return;
  }

  if(!self function_1e845317()) {
    return;
  }

  self function_bd506c77();

  if(!self function_1e845317()) {
    self take_remote();
    return;
  }

  traceresults = self spawn_trace();
  relativeorigin = undefined;
  var_2e2dbfa3 = undefined;

  if(isDefined(traceresults.hitent)) {
    relativeorigin = traceresults.origin - traceresults.hitent.origin;
    var_2e2dbfa3 = traceresults.hitent.angles;
  }

  spawnorigin = traceresults.origin;

  if(isDefined(traceresults.hitent) && isDefined(relativeorigin)) {
    anglesdelta = traceresults.hitent.angles - var_2e2dbfa3;
    spawnorigin = traceresults.hitent.origin + rotatepoint(relativeorigin, anglesdelta);
  }

  self thread throw_dart(spawnorigin, traceresults.angles, params.item.id);
}

private function_1e845317() {
  if(self clientfield::get_to_player("inside_infiltration_vehicle") != 0) {
    return false;
  }

  if(self isinvehicle()) {
    return false;
  }

  if(!validateorigin(self.origin)) {
    return false;
  }

  return true;
}

private function_bd506c77() {
  self endon(#"death", #"disconnect");
  remoteweapon = getweapon(#"warzone_remote");

  if(self hasweapon(remoteweapon)) {
    return;
  }

  if(self isswitchingweapons()) {
    self waittilltimeout(2, #"weapon_change");
  }

  self giveweapon(remoteweapon);
  self switchtoweapon(remoteweapon, 1);
  self waittilltimeout(2, #"weapon_change");
}

private take_remote() {
  remoteweapon = getweapon(#"warzone_remote");
  self takeweapon(remoteweapon);
}

private throw_dart(spawnorigin, spawnangles, itemid) {
  self endon(#"death", #"disconnect");
  playereyepos = self getplayercamerapos();
  vehicle = spawnvehicle(#"veh_dart_wz", spawnorigin, spawnangles);

  if(isDefined(vehicle)) {
    level.item_vehicles[level.item_vehicles.size] = vehicle;
    vehicle.id = itemid;
    vehicle setteam(self.team);
    vehicle.team = self.team;
    vehicle setowner(self);
    vehicle.owner = self;
    vehicle.ownerentnum = self.entnum;
    vehicle thread item_inventory::function_956a8ecd();
    target_set(vehicle, (0, 0, 0));
    assert(vehicle isremotecontrol());
    vehicle usevehicle(self, 0);

    if(!self function_f35d7cf3(playereyepos, vehicle)) {
      vehicle.origin = playereyepos;
      vehicle kill_vehicle(self, getweapon(#"dart"));
    }

    return;
  }

  self take_remote();
}

private function_5f9c568d(params) {
  player = self.owner;
  player thread function_ea9fe221(self);
}

function_79a59d11() {
  self disabledriverfiring(1);
  self.ignore_death_jolt = 1;
  self.var_92043a49 = 1;
  self.is_staircase_up = &function_5f9c568d;
  self.vehcheckforpredictedcrash = 1;
  self.predictedcollisiontime = 0.2;
  self.var_4ab08c1d = 1;
  self.glasscollision_alt = 1;
}

private spawn_trace() {
  eyeangle = self getplayerangles();
  forward = anglesToForward(eyeangle);
  eyepos = self getplayercamerapos();
  endpos = eyepos + forward * 50;
  var_f45df727 = eyepos + forward * 200;
  traceresults = {};
  traceresults.trace = bulletTrace(eyepos, var_f45df727, 1, self, 1, 1);
  traceresults.isvalid = traceresults.trace[#"fraction"] >= 1;
  traceresults.waterdepth = 0;
  traceresults.origin = endpos;
  traceresults.angles = eyeangle;
  return traceresults;
}

private function_f35d7cf3(playereyepos, vehicle) {
  eyeangle = self getplayerangles();
  forward = anglesToForward(eyeangle);
  eyepos = playereyepos;
  endpos = vehicle.origin;
  trace = bulletTrace(eyepos, endpos, 1, self, 1, 1);

  if(trace[#"fraction"] < 1) {
    return false;
  }

  mins = (vehicle.radius * -1, vehicle.radius * -1, vehicle.radius * -1);
  maxs = (vehicle.radius, vehicle.radius, vehicle.radius);
  trace = physicstraceex(eyepos, endpos, mins, maxs, self, 1);
  return trace[#"fraction"] >= 1;
}

on_vehicle_damage(params) {
  if(params.smeansofdeath === "MOD_CRUSH" && self isvehicleusable()) {
    self.idflags |= 8192;
  }

  return params.idamage;
}

event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  vehicle = eventstruct.vehicle;

  if(!isDefined(vehicle.scriptvehicletype) || vehicle.scriptvehicletype != #"dart_wz") {
    return;
  }

  vehicle.owner = self;
  self clientfield::set_to_player("dart_wz_static_postfx", 1);
  vehicle enabledartmissilelocking();
  self thread function_d13b1540(vehicle);
  vehicle thread watchownerdisconnect(self);
  vehicle thread watchremotecontroldeactivate();
  vehicle thread function_b35c5fa4();
  vehicle callback::on_vehicle_collision(&dartcollision);
  vehicle callback::function_d8abfc3d(#"on_vehicle_damage", &on_vehicle_damage);
  vehicle callback::function_d8abfc3d(#"on_vehicle_killed", &on_vehicle_killed);
}

watchremotecontroldeactivate() {
  self notify("45eaa61d466e347f");
  self endon("45eaa61d466e347f");
  dart = self;
  player = self.owner;
  dart endon(#"death", #"remote_weapon_end");
  player endon(#"disconnect");

  while(player attackbuttonpressed()) {
    waitframe(1);
  }

  while(true) {
    if(player attackbuttonpressed()) {
      player thread function_ea9fe221(dart);
      return;
    }

    waitframe(1);
  }
}

event_handler[exit_vehicle] codecallback_vehicleexit(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  vehicle = eventstruct.vehicle;

  if(!isDefined(vehicle.scriptvehicletype) || vehicle.scriptvehicletype != #"dart_wz") {
    return;
  }

  self thread function_ea9fe221(vehicle);
}

watchownerdisconnect(player) {
  self notify("3e0604a78c24647e");
  self endon("3e0604a78c24647e");
  self endon(#"death");
  player waittill(#"disconnect", #"death");
  self makevehicleunusable();
  self kill_vehicle(self);
}

private function_d13b1540(vehicle) {
  self notify("6f85cb6661241b51");
  self endon("6f85cb6661241b51");
  self endon(#"death", #"disconnect");
  vehicle endon(#"death", #"exit_vehicle");
  var_51fede25 = gettime() + 30000;
  self vehicle::set_vehicle_drivable_time_starting_now(30000);
  var_5fa298a1 = var_51fede25 - 10000;
  var_5cf8708d = 0;

  while(true) {
    time = gettime();

    if(1 && time >= var_51fede25) {
      self thread function_ea9fe221(vehicle);
      break;
    }

    if(self inlaststand()) {
      self thread function_ea9fe221(vehicle);
      break;
    }

    if(isDefined(self.isjammed) && self.isjammed) {
      self thread function_ea9fe221(vehicle);
      break;
    }

    if(self clientfield::get_to_player("inside_infiltration_vehicle") != 0) {
      self thread function_ea9fe221(vehicle);
      break;
    }

    if(1 && time >= var_5fa298a1 && !(isDefined(var_5cf8708d) && var_5cf8708d)) {
      var_5cf8708d = 1;
      vehicle clientfield::set("dart_wz_timeout_beep", 1);
    }

    if(true) {
      var_aba3faed = distancesquared(self.origin, vehicle.origin);

      if(var_aba3faed > 8000 * 8000) {
        self thread function_ea9fe221(vehicle);
      }
    }

    waterheight = getwaterheight(vehicle.origin, 100, -10000);

    if(waterheight != -131072) {
      var_19dbcac7 = vehicle.origin[2] - waterheight;

      if(var_19dbcac7 <= 0) {
        self thread function_ea9fe221(vehicle, 1);
      }
    }

    if(isDefined(level.deathcircle)) {
      if(distance2dsquared(vehicle.origin, level.deathcircle.origin) > level.deathcircle.radius * level.deathcircle.radius) {
        if(!isDefined(vehicle.var_3de57a77)) {
          vehicle.var_3de57a77 = gettime();
        }

        var_a71a8383 = gettime() - vehicle.var_3de57a77;

        if(int(3 * 1000) <= var_a71a8383) {
          vehicle usevehicle(self, 0);
          self clientfield::set_to_player("recon_out_of_circle", 0);
        }

        var_e96a9222 = min(var_a71a8383, int(3 * 1000));
        var_e96a9222 /= int(3 * 1000);
        var_e96a9222 *= 31;
        self clientfield::set_to_player("recon_out_of_circle", int(var_e96a9222));
        waitframe(1);
      } else {
        self clientfield::set_to_player("recon_out_of_circle", 0);
        vehicle.var_3de57a77 = undefined;
        wait 0.5;
      }

      continue;
    }

    wait 0.1;
  }
}

function_3a595d3c() {
  camera_pos = isDefined(self.owner) && isDefined(self getseatoccupant(0)) ? self.owner getplayercamerapos() : self.origin;
  dir = anglesToForward(self.angles);
  results = bulletTrace(camera_pos, camera_pos + dir * 96, 1, self, 1, 1);

  if(isDefined(results)) {
    if(isDefined(results[#"fraction"]) && results[#"fraction"] > 0.99) {
      return true;
    }
  }

  return false;
}

private function_c6ac711a(target) {
  if(!isDefined(target)) {
    return false;
  }

  if(target.classname != "grenade") {
    return false;
  }

  if(!isDefined(target.weapon) || target.weapon.name != #"dart") {
    return false;
  }

  if(!isDefined(target.owner) || target.owner != self) {
    return false;
  }

  return true;
}

function_b35c5fa4() {
  self notify("5a365a749191eb18");
  self endon("5a365a749191eb18");
  dart = self;
  player = dart.owner;
  dart endon(#"death");
  player endon(#"death");

  while(true) {
    waitresult = dart waittill(#"veh_predictedcollision");

    if(waitresult.stype == "glass") {
      continue;
    }

    if(player function_c6ac711a(waitresult.target)) {
      continue;
    }

    if(!isDefined(waitresult.target) && (waitresult.stype === "default" || waitresult.stype === "")) {
      if(self function_3a595d3c()) {
        continue;
      }
    }

    player = dart.owner;
    player thread function_ea9fe221(dart, 1);
    return;
  }
}

dartcollision(params) {
  dart = self;
  player = dart.owner;

  if(params.stype == "glass") {
    return;
  }

  if(!isDefined(params.entity) && (params.stype === "default" || params.stype === "")) {
    if(self function_3a595d3c()) {
      return;
    }
  }

  player thread function_ea9fe221(dart, 1);
}

leave_dart(dart) {
  if(isDefined(self)) {
    if(isDefined(dart) && self isinvehicle() && self getvehicleoccupied() == dart) {
      dart usevehicle(self, 0);
    }

    self take_remote();
  }
}

function_ea9fe221(dart, collision) {
  player = self;

  if(isDefined(dart)) {
    if(isDefined(dart.var_ea9fe221) && dart.var_ea9fe221) {
      return;
    }

    dart.var_ea9fe221 = 1;
  }

  if(isDefined(player) && player clientfield::get_to_player("inside_infiltration_vehicle") != 0) {
    player clientfield::set_to_player("dart_wz_static_postfx", 0);
    player leave_dart(dart);

    if(isDefined(dart)) {
      dart kill_vehicle(player, getweapon(#"dart"));
    }

    return;
  }

  waitframe(1);

  if(isDefined(player) && isplayer(player)) {
    player clientfield::set_to_player("dart_wz_static_postfx", 0);
    player val::set(#"dart", "freezecontrols", 1);
    player enableweaponcycling();
    player setclientuivisibilityflag("hud_visible", 0);
  }

  if(isDefined(dart) && isvehicle(dart)) {
    dart disabledartmissilelocking();
    dart setspeedimmediate(0);

    if(isDefined(player) && isplayer(player) && !isbot(player)) {
      forward = anglesToForward(dart.angles);
      moveamount = vectorscale(forward, 300 * -1);
      trace = physicstrace(dart.origin, dart.origin + moveamount, (4 * -1, 4 * -1, 4 * -1), (4, 4, 4), undefined, 1);
      cam = spawn("script_model", trace[#"position"]);
      cam setModel(#"tag_origin");
      cam linkto(dart);
      cam util::deleteaftertime(5);
    }

    dart kill_vehicle(player, getweapon(#"dart"));
  }

  if(isDefined(cam)) {
    player camerasetposition(cam.origin);
    player camerasetlookat(dart.origin);
    player cameraactivate(1);
  }

  if(isDefined(player) && isplayer(player) && !isbot(player)) {
    player vehicle::stop_monitor_missiles_locked_on_to_me();
    player vehicle::stop_monitor_damage_as_occupant();
  }

  waittime = 0.5;

  if(isDefined(collision) && collision) {
    waittime = 2;
  }

  wait waittime;

  if(isDefined(player) && isplayer(player)) {
    player setclientuivisibilityflag("hud_visible", 1);
    player val::reset(#"dart", "freezecontrols");
    player cameraactivate(0);
    player leave_dart(dart);
    player thread hud::fade_to_black_for_x_sec(0, 0.3, 0, 0.1);
  }

  if(isDefined(cam)) {
    cam delete();
  }
}

private on_vehicle_killed(params) {
  if(isDefined(params.occupants)) {
    if(params.occupants.size > 0 && self function_c7aa9338(params.occupants)) {
      if(isplayer(params.eattacker)) {
        params.eattacker stats::function_dad108fa(#"destroy_equipment", 1);
        callback::callback(#"hash_67dd51a5d529c64c");
      }
    }
  }

  if(isDefined(self.owner) && isplayer(self.owner)) {
    self.owner leave_dart(self);
  }

  wait 0.1;

  if(isDefined(self)) {
    self.var_4217cfcb = 1;
    self ghost();
  }

  wait 2;

  if(isDefined(self)) {
    self delete();
  }
}

private function_c7aa9338(array) {
  foreach(ent in array) {
    if(util::function_fbce7263(ent.team, self.team)) {
      return true;
    }
  }

  return false;
}

getdartmissiletargets() {
  targets = arraycombine(target_getarray(), level.missileentities, 0, 0);
  targets = arraycombine(targets, level.players, 0, 0);
  return targets;
}

isvaliddartmissiletarget(ent) {
  player = self;

  if(!isDefined(ent)) {
    return false;
  }

  entisplayer = isplayer(ent);

  if(entisplayer && !isalive(ent)) {
    return false;
  }

  if(ent.ignoreme === 1) {
    return false;
  }

  dart = player getvehicleoccupied();

  if(!isDefined(dart)) {
    return false;
  }

  if(distancesquared(dart.origin, ent.origin) > player.dart_killstreak_weapon.lockonmaxrange * player.dart_killstreak_weapon.lockonmaxrange) {
    return false;
  }

  if(entisplayer && ent hasperk(#"specialty_nokillstreakreticle")) {
    return false;
  }

  return true;
}

isstillvaliddartmissiletarget(ent, weapon) {
  player = self;

  if(!(target_istarget(ent) || isplayer(ent)) && !(isDefined(ent.allowcontinuedlockonafterinvis) && ent.allowcontinuedlockonafterinvis)) {
    return false;
  }

  dart = player getvehicleoccupied();

  if(!isDefined(dart)) {
    return false;
  }

  entisplayer = isplayer(ent);

  if(entisplayer && !isalive(ent)) {
    return false;
  }

  if(ent.ignoreme === 1) {
    return false;
  }

  if(distancesquared(dart.origin, ent.origin) > player.dart_killstreak_weapon.lockonmaxrange * player.dart_killstreak_weapon.lockonmaxrange) {
    return false;
  }

  if(entisplayer && ent hasperk(#"specialty_nokillstreakreticle")) {
    return false;
  }

  if(!heatseekingmissile::insidestingerreticlelocked(ent, undefined, weapon)) {
    return false;
  }

  return true;
}

disabledartmissilelocking() {
  dart = self;
  player = dart.owner;

  if(isDefined(player)) {
    player.get_stinger_target_override = undefined;
    player.is_still_valid_target_for_stinger_override = undefined;
    player.is_valid_target_for_stinger_override = undefined;
    player.dart_killstreak_weapon = undefined;
    player notify(#"stinger_irt_off");
    player heatseekingmissile::clearirtarget();
  }
}

enabledartmissilelocking() {
  dart = self;
  player = dart.owner;
  weapon = dart seatgetweapon(0);

  if(isDefined(player)) {
    player.get_stinger_target_override = &getdartmissiletargets;
    player.is_still_valid_target_for_stinger_override = &isstillvaliddartmissiletarget;
    player.is_valid_target_for_stinger_override = &isvaliddartmissiletarget;
    player.dart_killstreak_weapon = weapon;
    player thread heatseekingmissile::stingerirtloop(weapon);
  }
}