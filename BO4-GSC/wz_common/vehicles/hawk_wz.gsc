/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\vehicles\hawk_wz.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\oob;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_ai_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\core_common\vehicles\hawk;
#include scripts\killstreaks\airsupport;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\mp_common\item_inventory;

#namespace hawk_wz;

autoexec __init__system__() {
  system::register(#"hawk_wz", &__init__, undefined, undefined);
}

__init__() {
  level.hawk_settings = spawnStruct();
  level.hawk_settings.weapon = getweapon(#"eq_hawk");
  level.hawk_settings.bundle = getscriptbundle("hawk_settings_wz");
  assert(isDefined(level.hawk_settings.bundle));
  callback::on_finalize_initialization(&function_3675de8b);
  callback::on_item_use(&on_item_use);
  clientfield::register("vehicle", "hawk_range", 13000, 1, "int");
}

function_3675de8b() {
  map_center = airsupport::getmapcenter();
  level.var_5718bd08 = isDefined(level.var_7fd6bd44) ? level.var_7fd6bd44 : map_center[2] + 1000;
}

private on_item_use(params) {
  self endon(#"death", #"disconnect", #"begin_grenade_tracking", #"grenade_throw_cancelled");

  if(!isDefined(params.item) || !isDefined(params.item.itementry) || !isDefined(params.item.itementry.weapon) || params.item.itementry.weapon.name != #"eq_hawk") {
    return;
  }

  self waittill(#"grenade_fire");
  self thread spawn_hawk(params.item.id);
}

function_6ada73f(spawnpos) {
  return physicstrace(self.origin, spawnpos, (-18, -18, 0), (18, 18, 12), undefined, 16 | 2);
}

private function_900bb4f5(params) {
  if(isDefined(self)) {
    self thread hawk::hawk_destroy();
  }
}

spawn_hawk(itemid) {
  self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist", #"changed_specialist_death");

  if(isDefined(self.hawk) && isDefined(self.hawk.vehicle)) {
    self.hawk.vehicle hawk::hawk_destroy(1);
  }

  self.hawk = spawnStruct();
  vehicletype = "veh_hawk_player_wz";
  playerangles = self getplayerangles();
  var_865c71c9 = (playerangles[0], playerangles[1], 0);
  var_c7588ce0 = (0, playerangles[1], 0);
  forward = anglesToForward(var_c7588ce0);
  forward *= 20;
  spawnpos = self.origin + (0, 0, 90) + forward;
  trace = self function_6ada73f(spawnpos);

  if(trace[#"fraction"] < 1) {
    spawnpos = self.origin + (0, 0, 75) + forward;
    trace = function_6ada73f(spawnpos);
  }

  if(trace[#"fraction"] < 1) {
    spawnpos = self.origin + (0, 0, 45) + forward;
    trace = function_6ada73f(spawnpos);
  }

  if(trace[#"fraction"] < 1) {
    spawnpos = self.origin + (0, 0, 75);
    trace = function_6ada73f(spawnpos);
  }

  if(trace[#"fraction"] < 1) {
    spawnpos = self.origin + (0, 0, 45);
  }

  if(!validateorigin(spawnpos)) {
    self.hawk = undefined;
    return;
  }

  vehicle = spawnvehicle(vehicletype, spawnpos, var_c7588ce0);
  vehicle setteam(self.team);
  vehicle.team = self.team;
  vehicle.owner = self;
  vehicle.weapon = getweapon("eq_hawk");
  vehicle.var_20c71d46 = 1;
  vehicle.overridevehicledamage = &function_b162cdbd;
  vehicle.var_c5d65381 = 1;
  vehicle.var_8516173f = 1;
  vehicle.glasscollision_alt = 1;
  vehicle.is_staircase_up = &function_900bb4f5;
  vehicle.id = itemid;
  level.item_vehicles[level.item_vehicles.size] = vehicle;
  vehicle thread item_inventory::function_956a8ecd();
  self.hawk.vehicle = vehicle;
  bundle = level.hawk_settings.bundle;
  var_a33bcd86 = int(isDefined(bundle.var_a33bcd86) ? bundle.var_a33bcd86 : 0);

  if(isbot(self)) {
    var_a33bcd86 = 0;
  }

  if(isDefined(vehicle)) {
    if(var_a33bcd86) {
      self freezecontrolsallowlook(1);
      util::wait_network_frame(1);

      if(!isalive(vehicle)) {
        return;
      }
    }

    vehicle.can_control = 1;

    if(var_a33bcd86) {
      self.hawk.controlling = 1;
      self thread function_1b057db2();
      vehicle usevehicle(self, 0);
      self setplayerangles(var_865c71c9);
      self freezecontrolsallowlook(0);
      self util::setusingremote("hawk");
    } else {
      vehicle.var_e9f68b24 = var_865c71c9;
    }

    self thread function_1e7eecd7(vehicle, var_a33bcd86);
    self thread watch_destroyed(vehicle);
    self thread hawk_update(vehicle);
    self create_missile_hud(vehicle, var_a33bcd86);
    self thread watch_team_change(vehicle);
    self thread oob::function_c5278cb0(vehicle);
  }
}

function_b162cdbd(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(gettime() - self.birthtime <= 350) {
    return 0;
  }

  startinghealth = 400;

  if(isDefined(level.hawk_settings.bundle.var_108f064f) && weapon == getweapon(#"shock_rifle")) {
    idamage = startinghealth / level.hawk_settings.bundle.var_108f064f;
  }

  return idamage;
}

hawk_update(vehicle) {
  self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist", #"changed_specialist_death");
  vehicle endon(#"death");
  playerorigin = self.origin;

  while(true) {
    playerorigin = update_range(vehicle, playerorigin);

    if(isDefined(self.isjammed) && self.isjammed) {
      self thread function_1eddba48();
      break;
    }

    waitframe(1);
  }
}

update_range(vehicle, playerorigin) {
  if(isalive(self)) {
    playerorigin = self.origin;
  }

  vehicle.var_b61d83c4 = 0;
  self.hawk.var_b61d83c4 = 0;
  distsqr = distancesquared(vehicle.origin, playerorigin);

  if(distsqr > level.hawk_settings.bundle.far_distance * level.hawk_settings.bundle.far_distance || vehicle.origin[2] > level.var_5718bd08) {
    vehicle clientfield::set("hawk_range", 1);
    vehicle.var_b61d83c4 = 1;
    self.hawk.var_b61d83c4 = 1;
  } else {
    vehicle clientfield::set("hawk_range", 0);
  }

  if(isalive(self) && self isinvehicle() && self getvehicleoccupied() == vehicle) {
    if(distsqr > level.hawk_settings.bundle.max_distance * level.hawk_settings.bundle.max_distance) {
      self thread function_1eddba48();
    }

    if(isDefined(level.deathcircle)) {
      if(distance2dsquared(vehicle.origin, level.deathcircle.origin) > level.deathcircle.radius * level.deathcircle.radius) {
        if(!isDefined(vehicle.var_3de57a77)) {
          vehicle.var_3de57a77 = gettime();
        }

        var_a71a8383 = gettime() - vehicle.var_3de57a77;

        if(int(1 * 1000) <= var_a71a8383) {
          vehicle hawk::hawk_destroy();
        }
      } else {
        vehicle.var_3de57a77 = undefined;
      }
    }
  }

  return playerorigin;
}

watch_destroyed(vehicle) {
  self endon(#"disconnect");
  vehicle waittill(#"death");

  if(isDefined(self)) {
    if(!self util::function_63d27d4e("remote_missile")) {
      self destroy_missile_hud();
    }
  }
}

function_d89c1628(vehicle) {
  if(!(isDefined(vehicle.can_control) && vehicle.can_control)) {
    return false;
  }

  if(self isremotecontrolling() || self util::isusingremote()) {
    return false;
  }

  if(self.hawk.var_a3b23d12) {
    return false;
  }

  if(!self fragbuttonpressed()) {
    return false;
  }

  if(self function_15049d95()) {
    return false;
  }

  if(!isalive(self)) {
    return false;
  }

  return true;
}

private function_1eddba48() {
  if(!isDefined(self) || !isDefined(self.hawk) || !isDefined(self.hawk.vehicle) || self.hawk.vehicle.var_55dded30 !== self) {
    return;
  }

  hawk = self.hawk.vehicle;

  if(hawk.var_720290e3 === 1) {
    return;
  }

  hawk.var_720290e3 = 1;
  hawk.can_control = 0;
  self.hawk.controlling = 0;
  self clientfield::set_to_player("static_postfx", 1);
  var_9e2fe80f = isDefined(level.hawk_settings.bundle.var_2f47b335) ? level.hawk_settings.bundle.var_2f47b335 : 0.5;
  wait var_9e2fe80f;

  if(isDefined(self)) {
    self clientfield::set_to_player("static_postfx", 0);
  }

  if(isDefined(self) && isDefined(hawk) && self isinvehicle() && self getvehicleoccupied() === hawk) {
    hawk usevehicle(self, 0);
  }
}

function_1e7eecd7(vehicle, var_44e9a475) {
  self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist", #"changed_specialist_death");
  vehicle endon(#"death");

  if(var_44e9a475) {
    self.hawk.controlling = 1;
    vehicle.var_55dded30 = self;
    vehicle.playercontrolled = 1;
  } else {
    self.hawk.controlling = 0;
    vehicle.var_55dded30 = undefined;
    vehicle.playercontrolled = 0;
  }

  self.hawk.var_a3b23d12 = 1;

  while(true) {
    if(self.hawk.controlling) {
      self thread function_c4770b46(vehicle);
      self waittill(#"exit_vehicle");
      self.hawk.controlling = 0;
      vehicle.player = self;
      vehicle.var_55dded30 = undefined;
      vehicle.playercontrolled = 0;
      vehicle setspeedimmediate(0);
      vehicle setvehvelocity((0, 0, 0));
      vehicle setphysacceleration((0, 0, 0));
      vehicle setangularvelocity((0, 0, 0));
      vehicle setneargoalnotifydist(40);
      vehicle setgoal(vehicle.origin, 1);
      vehicle function_a57c34b7(vehicle.origin, 1, 0);
      vehicle makevehicleunusable();
      self util::function_9a39538a();
      self.hawk.var_a3b23d12 = 1;
      self playsoundtoplayer("gdt_hawk_pov_out", self);

      if(!(isDefined(vehicle.being_destroyed) && vehicle.being_destroyed)) {
        vehicle notify(#"hawk_settled");
      }

      return;
    }

    if(self function_d89c1628(vehicle)) {
      self.hawk.controlling = 1;
      self thread function_1b057db2();
      vehicle usevehicle(self, 0);
      vehicle.var_55dded30 = self;
      vehicle.playercontrolled = 1;
      self util::setusingremote("hawk");
      vehicle playsoundtoplayer("gdt_hawk_pov_in", self);
      self freezecontrolsallowlook(0);
      vehicle vehicle_ai::clearallmovement();
      vehicle function_d4c687c9();

      if(isDefined(vehicle.var_e9f68b24)) {
        self setplayerangles(vehicle.var_e9f68b24);
      }
    } else if(!self fragbuttonpressed()) {
      self.hawk.var_a3b23d12 = 0;
    }

    waitframe(1);
  }
}

function_1b057db2() {
  self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist", #"changed_specialist_death");
  self notify("6954b7d60005c9f0");
  self endon("6954b7d60005c9f0");
  var_10a85d23 = self gestures::function_c77349d4("gestable_drone_hawk_pda");
  self stopgestureviewmodel(var_10a85d23, 0, 0);

  if(isDefined(self.var_f97921ea)) {
    var_a4137bf5 = gettime() - self.var_f97921ea;

    if(var_a4137bf5 < 850) {
      wait float(850 - var_a4137bf5) / 1000;
    }
  }

  var_37ea2019 = 0;

  while(!var_37ea2019 && isalive(self) && self.hawk.controlling) {
    if(self gestures::play_gesture(var_10a85d23, undefined, 0)) {
      var_37ea2019 = 1;
      self waittill(#"exit_vehicle", #"death");
      self.var_f97921ea = gettime();
      self stopgestureviewmodel(var_10a85d23, 0, 0);
    }

    waitframe(1);
  }
}

function_9096c10() {
  return self usebuttonpressed() || self stancebuttonpressed() && self gamepadusedlast();
}

function_c4770b46(vehicle) {
  self notify("7ebee304d299c8bb");
  self endon("7ebee304d299c8bb");
  vehicle endon(#"death");
  self endon(#"disconnect", #"joined_team", #"joined_spectators", #"changed_specialist", #"changed_specialist_death", #"exit_vehicle");

  while(self function_9096c10()) {
    waitframe(1);
  }

  while(!self function_9096c10()) {
    waitframe(1);
  }

  while(self function_9096c10()) {
    waitframe(1);
  }

  waitframe(1);
  vehicle usevehicle(self, 0);
}

watch_team_change(hawk) {
  hawk endon(#"death");
  waitresult = self waittill(#"disconnect", #"joined_team", #"joined_spectator", #"changed_specialist", #"changed_specialist_death");

  if(!isDefined(hawk)) {
    return;
  }

  hawk notify(#"hawk_settled");
}

create_missile_hud(vehicle, var_a33bcd86) {
  player = self;

  if(var_a33bcd86) {
    vehicle playsoundtoplayer("gdt_hawk_pov_in", self);
  }
}

destroy_missile_hud() {}