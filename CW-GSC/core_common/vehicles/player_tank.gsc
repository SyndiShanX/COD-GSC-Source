/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_tank.gsc
************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\player_vehicle;
#namespace player_tank;

function private autoexec __init__system__() {
  system::register(#"player_tank", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("player_tank", &function_c0f1d81b);
  clientfield::register("scriptmover", "tank_deathfx", 1, 1, "int");
  clientfield::register("vehicle", "tank_shellejectfx", 1, 1, "int");
}

function private function_c0f1d81b() {
  self setmovingplatformenabled(1, 0);
  self.var_84fed14b = 0;
  self.var_d6691161 = 0;
  self.var_5d662124 = 2;
  self.var_3daa0191 = &function_b61c27bb;
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_96f5d31b);
  callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_cd8db309);
  callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_b8458486);
  callback::function_d8abfc3d(#"hash_551381cffdc79048", &player_vehicle::function_948f0984);
  callback::function_d8abfc3d(#"on_vehicle_damage", &on_vehicle_damage);
  callback::function_d8abfc3d(#"on_vehicle_killed", &function_4366bf50);
  self thread player_vehicle::function_5bce3f3a(1, 100);
}

function private function_b61c27bb(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  occupants = self getvehoccupants();

  if(isDefined(occupants)) {
    foreach(occupant in occupants) {
      if(isPlayer(occupant) && !isbot(occupant)) {
        damagepct = modelindex / self.maxhealth;
        damagepct = int(max(damagepct, 3));
        damagedirection = undefined;

        if(isDefined(damagefromunderneath) || isDefined(psoffsettime)) {
          if(isDefined(psoffsettime) && (partname === "MOD_RIFLE_BULLET" || partname === "MOD_PISTOL_BULLET")) {
            damagedirection = vectornormalize(occupant.origin - psoffsettime.origin);
          } else {
            damagedirection = vsurfacenormal;
          }
        }

        occupant addtodamageindicator(damagepct, damagedirection);
        break;
      }
    }
  }
}

function function_4366bf50(params) {
  eattacker = params.eattacker;
  weapon = params.weapon;

  if(isDefined(self.team) && isDefined(eattacker.team) && self.team != # "neutral" && util::function_fbce7263(self.team, eattacker.team) && self getvehoccupants().size > 0) {
    scoreevents::processscoreevent(#"destroyed_tank", eattacker, undefined, weapon);
  }

  deathmodel = spawn("script_model", self.origin + (0, 0, 80));
  deathmodel setModel(#"veh_t9_mil_ru_tank_t72_turret_dead_spawn");
  deathmodel.angles = self function_bc2f1cb8(0);
  side_offset = getdvarint(#"hash_2163abe439abdd44", 5);
  right_offset = randomintrange(side_offset * -1, side_offset);
  forward_offset = getdvarint(#"hash_3ad1ffe3739de420", 10);
  forward = anglesToForward(deathmodel.angles);
  right = anglestoright(deathmodel.angles);
  contact_point = deathmodel.origin;
  contact_point += forward * forward_offset;
  contact_point += right * right_offset;
  var_f0436c8a = getdvarint(#"hash_7a9d06ee19067d4f", 150);
  var_da0636d8 = getdvarint(#"hash_7a81f4ee18ef9701", 180);
  up_force = randomintrange(var_f0436c8a, var_da0636d8);
  deathmodel physicslaunch(contact_point, (0, 0, up_force));
  deathmodel clientfield::set("tank_deathfx", 1);
  deathmodel waittilltimeout(20, #"death");

  if(isDefined(deathmodel)) {
    deathmodel deletedelay();
  }
}

function private function_96f5d31b(params) {
  player = params.player;
  eventstruct = params.eventstruct;

  if(!isDefined(player)) {
    return;
  }

  if(eventstruct.seat_index === 0) {
    self function_11397df9(player);
  }

  self thread function_2014e301(player);
}

function private function_cd8db309(params) {
  eventstruct = params.eventstruct;
  player = params.player;

  if(eventstruct.seat_index === 0) {
    self function_eba4498a(player);
  }
}

function function_b8458486(params) {
  player = params.player;
  eventstruct = params.eventstruct;

  if(!isDefined(player)) {
    return;
  }

  if(eventstruct.seat_index === 0) {
    self function_11397df9(player);
    self thread function_2014e301(player);
    return;
  }

  self function_eba4498a(player);
}

function private function_44f6c97c() {
  self endon(#"death");
  self notify("65aa500f1592187f");
  self endon("65aa500f1592187f");
  wait 0.5;
  self vehicle::toggle_control_bone_group(1, 1);
  self playSound("veh_tank_shell_hatch_open");
  wait 0.5;
  self clientfield::set("tank_shellejectfx", 1);
  wait 1.25;
  self clientfield::set("tank_shellejectfx", 0);
  self vehicle::toggle_control_bone_group(1, 0);
  self playSound("veh_tank_shell_hatch_close");
}

function private function_2014e301(player) {
  player endon(#"hash_27646c99772610b4", #"death", #"exit_vehicle");
  self endon(#"death");

  while(true) {
    self waittill(#"weapon_fired");

    if(!is_true(self.var_1bc57b69)) {
      self thread function_44f6c97c();
    }

    tankweapon = self seatgetweapon(0);
    var_610cfafc = int(tankweapon.reloadtime * 1000);
    player setvehicleweaponwaitduration(var_610cfafc);
    player setvehicleweaponwaitendtime(gettime() + var_610cfafc);
  }
}

function function_11397df9(player) {
  if(!isDefined(self.var_9be5a571)) {
    self.var_9be5a571 = [];
  }

  player.overrideplayerdamage = &function_7daf5af2;
  player.var_9a9c6a96 = 1;
  self thread player_vehicle::function_53f7a11f(player);
}

function function_eba4498a(player) {
  self.overridevehicledamage = undefined;

  if(isDefined(player)) {
    player.overrideplayerdamage = undefined;
    player.var_9a9c6a96 = undefined;
    player notify(#"hash_27646c99772610b4");
  }
}

function private on_vehicle_damage(params) {
  if(isPlayer(params.eattacker) && params.eattacker isinvehicle() && params.smeansofdeath === "MOD_PROJECTILE") {
    self playSound(#"hash_301ede6e928927f2");
  }
}

function private function_7daf5af2(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  damage = partname;
  vehicle = self getvehicleoccupied();

  if(!isvehicle(vehicle) || !isalive(vehicle)) {
    return damage;
  }

  if(vsurfacenormal === "MOD_DEATH_CIRCLE") {
    return damage;
  }

  if(vsurfacenormal === "MOD_TRIGGER_HURT") {
    return damage;
  }

  damage = 0;
  return damage;
}