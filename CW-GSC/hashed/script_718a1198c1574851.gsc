/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_718a1198c1574851.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using script_5495f0bb06045dc7;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\player\player_reinsertion;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\player\player_loadout;
#using scripts\wz_common\hud;
#using scripts\wz_common\wz_loadouts;
#namespace namespace_bc2b656d;

function event_handler[gametype_init] main(eventstruct) {
  namespace_17baa64d::init();
  spawning::function_32b97d1b(&spawning::function_90dee50d);
  spawning::function_adbbb58a(&spawning::function_c24e290c);
  spawning::addsupportedspawnpointtype("fireteam");
  callback::add_callback(#"hash_1019ab4b81d07b35", &on_team_eliminated);
  callback::add_callback(#"hash_7912e21750e4010d", &function_b057aee2);
  callback::on_player_killed(&on_player_killed);
  callback::on_disconnect(&on_player_disconnect);
  level.alwaysusestartspawns = 1;
  level.onstartgametype = &namespace_17baa64d::on_start_game_type;
  level.givecustomloadout = &give_custom_loadout;
  level.var_894b9d74 = 1;
  level.var_405a6738 = 25000;
  level.var_c7f8ccf6 = 50;
  level.var_5c14d2e6 = &function_b82fbeb8;
  level.var_317fb13c = &function_b82fbeb8;
  level.var_5cb948b1 = &function_6de0bb32;
  player_reinsertion::function_b5ee47fa(&function_807b902);
}

function event_handler[level_init] level_init(eventstruct) {
  if(!isstruct(level.territory) || !isstring(level.territory.var_bf5eb349)) {
    return;
  }

  settings = getscriptbundle(level.territory.var_bf5eb349);
  death_circle::function_5e412e4a(settings);
}

function give_custom_loadout(takeoldweapon = 0) {
  self loadout::init_player(!takeoldweapon);

  if(takeoldweapon) {
    oldweapon = self getcurrentweapon();
    weapons = self getweaponslist();

    foreach(weapon in weapons) {
      self takeweapon(weapon);
    }
  }

  nullprimary = getweapon(#"null_offhand_primary");
  self giveweapon(nullprimary);
  self setweaponammoclip(nullprimary, 0);
  self switchtooffhand(nullprimary);

  if(self.firstspawn !== 0) {
    hud::function_2f66bc37();
  }

  healthgadget = getweapon(#"hash_5a7fd1af4a1d5c9");
  self giveweapon(healthgadget);
  self setweaponammoclip(healthgadget, 0);
  self switchtooffhand(healthgadget);
  level.var_ef61b4b5 = healthgadget;
  var_fb6490c8 = self gadgetgetslot(healthgadget);
  self gadgetpowerset(var_fb6490c8, 0);
  bare_hands = getweapon(#"bare_hands");
  self giveweapon(bare_hands);
  self function_c9a111a(bare_hands);
  self switchtoweapon(bare_hands, 1);

  if(self.firstspawn !== 0) {
    self setspawnweapon(bare_hands);
  }

  self.specialty = self getloadoutperks(0);
  self loadout::register_perks();
  return bare_hands;
}

function function_b82fbeb8() {
  assert(isPlayer(self));

  if(!isPlayer(self) || !isalive(self)) {
    return;
  }

  item_world::function_1b11e73c();

  while(isDefined(self) && !isDefined(self.inventory)) {
    waitframe(1);
  }

  if(!isDefined(self)) {
    return;
  }

  self wz_loadouts::give_weapon(#"pistol_semiauto_t9_item");
  self wz_loadouts::give_item(#"ammo_small_caliber_item_t9");
}

function function_6de0bb32() {
  assert(isPlayer(self));

  if(isDefined(self.inventory)) {
    var_cc6ff6a1 = function_4ba8fde(#"pistol_semiauto_t9_item").id;
    var_122bdb78 = function_4ba8fde(#"ammo_small_caliber_item_t9").id;
    var_dd8041ff = 0;
    var_348a5219 = 1;

    foreach(inventoryitem in self.inventory.items) {
      itemid = inventoryitem.id;

      if(itemid == 32767) {
        continue;
      }

      if(itemid != var_cc6ff6a1) {
        var_348a5219 = 0;
        break;
      }
    }

    foreach(ammoweapon, itemid in self.inventory.ammo) {
      if(!var_348a5219) {
        break;
      }

      weapon = getweapon(ammoweapon);
      ammostock = self getweaponammostock(weapon);

      if(itemid == var_122bdb78) {
        var_dd8041ff = ammostock;
        continue;
      }

      if(ammostock > 0) {
        var_348a5219 = 0;
        break;
      }
    }

    if(var_348a5219) {
      ammoitem = function_4ba8fde(#"ammo_small_caliber_item_t9");
      ammoweapon = item_world_util::function_f4a8d375(ammoitem.id);
      item_drop::drop_item(0, ammoweapon, 1, var_dd8041ff, ammoitem.id, self.origin);
    }

    return !var_348a5219;
  }

  return true;
}

function on_team_eliminated(params) {
  players = getplayers(params.team);

  foreach(player in players) {
    if(isDefined(player.reinsertionvehicle)) {
      player.reinsertionvehicle delete();
    }
  }
}

function on_player_killed(params) {
  self.var_26074a5b = undefined;

  if(!isDefined(self.reinsertionvehicle)) {
    vehicle = spawnvehicle(#"hash_3effd1dd89ee3d36", (0, 0, 0), (0, 0, 0));

    if(isDefined(vehicle)) {
      vehicle.targetname = "reinsertionvehicle";
      vehicle ghost();
      vehicle notsolid();
      self.reinsertionvehicle = vehicle;
    }
  }

  self thread function_855ba783();
  self thread function_c3144b08();
}

function function_b057aee2() {
  players = function_a1ef346b();

  foreach(player in players) {
    scoreevents::processscoreevent(#"hash_3f198e388e56ccf5", player);
  }
}

function function_855ba783() {
  self endon(#"disconnect");
  level endon(#"game_ended");
  self waittill(#"spawned");

  if(self.currentspectatingclient > -1) {
    self.var_26074a5b = self.currentspectatingclient;
  }
}

function function_c3144b08() {
  self endon(#"disconnect", #"spawned", #"force_spawn");
  level endon(#"game_ended");
  waitresult = self waittill(#"waitingtospawn");
  var_fa9f2461 = waitresult.timeuntilspawn + -0.5;

  if(var_fa9f2461 > 0) {
    wait var_fa9f2461;
  }

  self luinotifyevent(#"hash_175f8739ed7a932", 0);
}

function on_player_disconnect() {
  if(isDefined(self.reinsertionvehicle)) {
    self.reinsertionvehicle delete();
  }
}

function function_807b902() {
  if(!isDefined(level.inprematchperiod) || level.inprematchperiod) {
    return;
  }

  self thread function_acdf637e();
  player = self function_70f1d702();

  if(isDefined(player)) {
    if(isDefined(level.deathcircle.var_5c54ab33)) {
      self function_2ec1bf5c(player.origin);
    } else {
      fwd = anglesToForward(player.angles);
      groundpt = player.origin - fwd * 1500;
      var_6b4313e9 = player.origin + fwd * 1500;
      self function_b74c009d(groundpt, var_6b4313e9);
    }

    return;
  }

  if(isDefined(level.deathcircle.var_5c54ab33)) {
    circle = level.deathcircle.var_5c54ab33;
    angle = randomint(360);
    origin = circle.origin + (cos(angle), sin(angle), 0);
    self function_2ec1bf5c(origin);
  }
}

function function_70f1d702() {
  if(isDefined(self.var_26074a5b)) {
    player = getentbynum(self.var_26074a5b);

    if(isalive(player) && player.team == self.team) {
      return player;
    }
  }

  players = function_a1cff525(self.squad);

  if(players.size > 0) {
    return players[randomint(players.size)];
  }

  return undefined;
}

function function_2ec1bf5c(origin) {
  circle = level.deathcircle.var_5c54ab33;
  var_bab1ee6b = {
    #origin: circle.origin, #radius: circle.radius - 1500
  };
  var_d9100e0 = isDefined(level.deathcircle.nextcircle) ? level.deathcircle.nextcircle.origin : circle.origin;
  dir = vectornormalize(origin - var_d9100e0);
  var_51c8b128 = death_circle::function_936b3f09(origin, dir, var_bab1ee6b);
  point = (var_51c8b128[0], var_51c8b128[1], 0);

  if(isDefined(level.territory) && isarray(level.territory.bounds) && level.territory.bounds.size > 0) {
    inbounds = 0;
    var_ddd29fdc = vectornormalize((var_d9100e0[0], var_d9100e0[1], 0) - point);

    while(!inbounds) {
      foreach(bound in level.territory.bounds) {
        testpoint = (point[0], point[1], bound.origin[2]);

        if(istouching(testpoint, bound)) {
          inbounds = 1;
          break;
        }
      }

      if(!inbounds) {
        point += var_ddd29fdc * 1000;
      }
    }
  }

  trace = groundtrace(point + (0, 0, 20000), point + (0, 0, -10000), 0, undefined);
  groundpoint = trace[#"position"];
  trace = groundtrace(var_d9100e0 + (0, 0, 20000), var_d9100e0 + (0, 0, -10000), 0, undefined);
  var_6b4313e9 = trace[#"position"];
  self function_b74c009d(groundpoint, var_6b4313e9);
}

function function_b74c009d(groundpoint, var_6b4313e9) {
  players = function_c65231e2(self.squad);

  if(players.size <= 0) {
    return;
  }

  for(squadindex = 0; squadindex < players.size; squadindex++) {
    if(self == players[squadindex]) {
      break;
    }
  }

  slice = 360 / players.size;
  angle = squadindex * slice;
  r = randomintrange(150, 200);
  xoffset = r * cos(angle);
  yoffset = r * sin(angle);
  zoffset = getdvarint(#"hash_1e5142ed6dd5c6a0", randomintrange(15000, 15100));
  origin = groundpoint + (xoffset, yoffset, zoffset);
  self thread function_2613549d(origin, var_6b4313e9);
}

function function_2613549d(origin, var_6b4313e9) {
  level endon(#"game_ended");
  self endon(#"disconnect", #"end_respawn");
  self setorigin(origin);
  fwd = var_6b4313e9 - origin;
  var_7d48f39e = vectortoangles(fwd);
  launchvelocity = fwd;
  vehicle = self.reinsertionvehicle;

  if(isDefined(vehicle)) {
    vehicle.origin = origin;
    vehicle.angles = var_7d48f39e;
    self ghost();
    self notsolid();
    self dontinterpolate();
    self setclientthirdperson(1);
    self function_648c1f6(vehicle, undefined, 0, 180, 180, 180, 180, 0);
    self setplayerangles(var_7d48f39e);
    wait 0;
    self setclientthirdperson(0);
    self startcameratween(0);
    self show();
    self solid();
    self unlink();
    launchvelocity = anglesToForward(self getplayerangles());
  }

  self player_insertion::start_freefall(launchvelocity, 1);
}

function private function_acdf637e() {
  if(isDefined(level.var_317fb13c)) {
    self thread[[level.var_317fb13c]]();
  }
}

function function_fd9dd4cc() {
  players = function_c65231e2(self.squad);

  for(i = 0; i < players.size; i++) {
    if(self == players[i]) {
      return i;
    }
  }

  return 0;
}