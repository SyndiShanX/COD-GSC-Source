/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_b9a55edd207e4ca.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using script_46192c58ea066d7f;
#using script_5495f0bb06045dc7;
#using script_69514c4c056c768;
#using scripts\core_common\armor_carrier;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\item_inventory;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\location;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\radiation;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\territory;
#using scripts\core_common\territory_util;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\callbacks;
#using scripts\mp_common\laststand;
#using scripts\mp_common\player\player_loadout;
#using scripts\wz_common\hud;
#using scripts\wz_common\spawn;
#using scripts\wz_common\wz_loadouts;
#namespace namespace_2938acdc;

function init() {
  level.var_db91e97c = 1;
  function_28e27688();
  death_circle::function_c156630d();
  namespace_17baa64d::init();

  if(!is_true(getdvarint(#"hash_613aa8df1f03f054", 1))) {
    level.givecustomloadout = &give_custom_loadout;
  }

  setsaveddvar(#"hash_1677d88b90b7fcf8", 1);
  spawning::function_32b97d1b(&spawning::function_90dee50d);
  spawning::function_adbbb58a(&spawning::function_c24e290c);
  callback::on_start_gametype(&function_3b948dcf);
  callback::function_c11071a8(&function_c11071a8);
  callback::on_vehicle_spawned(&on_vehicle_spawned);
  callback::add_callback(#"hash_740a58650e79dbfd", &function_c3623479);
  callback::add_callback(#"hash_40cd438036ae13df", &function_1f93e91f);
  callback::on_player_killed(&on_player_killed);
  callback::add_callback(#"hash_3be1213f454fa90e", &function_a4740127);
  level.var_61d4f517 = getgametypesetting(#"hash_3513cf8b4287cdd7");
  level.var_5c49de55 = getgametypesetting(#"hash_6eef7868c4f5ddbc");

  if(is_true(level.var_5c49de55)) {
    clientfield::register_clientuimodel("squad_wipe_tokens.count", 1, 4, "int");
    callback::on_connect(&on_player_connect);
  }

  level.var_eada15e7 = &function_407d343f;
}

function private on_player_connect() {
  if(!isDefined(game.var_5c49de55[self.team])) {
    game.var_5c49de55[self.team] = level.var_5c49de55;
  }

  self clientfield::set_player_uimodel("squad_wipe_tokens.count", game.var_5c49de55[self.team]);
}

function function_b8da6142(player) {
  if(!is_true(level.var_61d4f517)) {
    return 0;
  }

  if(!isDefined(level.var_5f536694)) {
    level.var_5f536694 = [];
  }

  if(level.var_5f536694[player.squad] === gettime()) {
    return 1;
  }

  forcespawn = !player laststand_mp::function_c0ec19cd();

  if(forcespawn) {
    level.var_5f536694[player.squad] = gettime();
  }

  return forcespawn;
}

function function_e1ca24fe(players) {
  arrayremovevalue(players, undefined, 0);
  return players;
}

function function_c11071a8() {
  wait math::clamp(level.prematchperiod - 2, 0, level.prematchperiod);
  players = getplayers();

  if(is_true(getgametypesetting("allowPlayerMovementPrematch"))) {
    level thread function_38b14e59(players, 2, 3, 2, 0);
  }

  wait 2;
  players = function_e1ca24fe(players);

  foreach(player in players) {
    player val::set(#"hash_4a7df1f1aa746fdc", "freezecontrols", 1);
    player val::set(#"hash_4a7df1f1aa746fdc", "disablegadgets", 1);

    if(isDefined(player.startspawn)) {
      if(isDefined(player.startspawn.origin)) {
        player setorigin(player.startspawn.origin);
      }

      if(isDefined(player.startspawn.angles)) {
        player setplayerangles(player.startspawn.angles);
      }
    }
  }

  wait 3 + 2 / 3;
  players = function_e1ca24fe(players);

  foreach(player in players) {
    if(!isalive(player)) {
      continue;
    }

    player val::reset(#"hash_4a7df1f1aa746fdc", "freezecontrols");
    player val::reset(#"hash_4a7df1f1aa746fdc", "disablegadgets");
  }
}

function function_38b14e59(players, fadeouttime, blacktime, fadeintime, rumble) {
  if(isDefined(lui::get_luimenu("FullScreenBlack"))) {
    lui_menu = lui::get_luimenu("FullScreenBlack");
  }

  players = function_e1ca24fe(players);

  foreach(player in players) {
    if(isDefined(player)) {
      if(![[lui_menu]] - > function_7bfd10e6(player)) {
        [[lui_menu]] - > open(player);
      }

      [[lui_menu]] - > set_startalpha(player, 0);
      [[lui_menu]] - > set_endalpha(player, 1);
      [[lui_menu]] - > set_fadeovertime(player, int(fadeouttime * 1000));
    }
  }

  wait fadeouttime + blacktime;
  players = function_e1ca24fe(players);

  foreach(player in players) {
    player thread item_inventory::reset_inventory();

    if(rumble) {
      player function_bc82f900(#"infiltration_rumble");
    }

    if(![[lui_menu]] - > function_7bfd10e6(player)) {
      [[lui_menu]] - > open(player);
    }

    [[lui_menu]] - > set_startalpha(player, 1);
    [[lui_menu]] - > set_endalpha(player, 0);
    [[lui_menu]] - > set_fadeovertime(player, int(fadeintime * 1000));
  }

  wait fadeintime;
  players = function_e1ca24fe(players);

  foreach(player in players) {
    [[lui_menu]] - > close(player);
  }
}

function function_3b948dcf() {
  if(!level.deathcircle.enabled) {
    return;
  }

  waitframe(1);
  level.var_35d74f0a = location::function_2e7ce8a0();
  deathcircle = death_circle::function_a8749d88(level.var_35d74f0a.origin, level.var_35d74f0a.radius, 5, 1);
  level thread death_circle::function_dc15ad60(deathcircle);
  function_aef30871(level.var_35d74f0a);
}

function function_aef30871(location) {
  if(isDefined(level.var_7767cea8)) {
    var_a144f484 = [];

    foreach(dest in level.var_7767cea8) {
      distance = distance2d(dest.origin, location.origin);

      if(distance < location.radius) {
        if(!isDefined(var_a144f484)) {
          var_a144f484 = [];
        } else if(!isarray(var_a144f484)) {
          var_a144f484 = array(var_a144f484);
        }

        var_a144f484[var_a144f484.size] = dest;
      }
    }

    if(var_a144f484.size == 0) {
      var_56c7ce59 = undefined;
      closest_distance = 999999999;

      foreach(dest in level.var_7767cea8) {
        distance = distance2d(dest.origin, location.origin);

        if(distance < closest_distance) {
          closest_distance = distance;
          var_56c7ce59 = dest;
        }
      }

      if(!isDefined(var_a144f484)) {
        var_a144f484 = [];
      } else if(!isarray(var_a144f484)) {
        var_a144f484 = array(var_a144f484);
      }

      var_a144f484[var_a144f484.size] = var_56c7ce59;
    }

    foreach(dest in level.var_7767cea8) {
      if(!function_844e7af4(dest, var_a144f484)) {
        spawn::function_3b1d0553(dest);
      }
    }

    level.var_7767cea8 = var_a144f484;
  }
}

function function_844e7af4(dest, destinations) {
  foreach(var_57701f4a in destinations) {
    if(var_57701f4a.target == dest.target) {
      return true;
    }
  }

  return false;
}

function function_28e27688() {
  location::function_18dac968((-2800, -17300, 1370), 0, 0, 10000);
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

  healthgadget = getweapon(#"gadget_health_regen");
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
  self thread function_fd19a11c();
  return bare_hands;
}

function function_fd19a11c() {
  self endon(#"death");
  waitframe(1);

  while(!isDefined(self.inventory)) {
    waitframe(1);
  }

  item_inventory::reset_inventory(0);
  var_3401351 = randomintrangeinclusive(1, 5);

  switch (var_3401351) {
    case 1:
      function_6541c917();
      break;
    case 2:
      function_ae5cdb4c();
      break;
    case 3:
      function_a0a43fdb();
      break;
    case 4:
      function_343266f9();
      break;
    case 5:
      function_2e725b79();
      break;
  }

  give_max_ammo();
  var_67fe8973 = [];
  var_67fe8973[var_67fe8973.size] = 126;
  var_67fe8973[var_67fe8973.size] = 128;
  var_67fe8973[var_67fe8973.size] = 134;
  var_67fe8973[var_67fe8973.size] = 125;
  give_killstreaks(var_67fe8973);
  actionslot3 = getdvarint(#"hash_449fa75f87a4b5b4", 0) < 0 ? "flourish_callouts" : "ping_callouts";
  self setactionslot(3, actionslot3);
  actionslot4 = getdvarint(#"hash_23270ec9008cb656", 0) < 0 ? "scorestreak_wheel" : "sprays_boasts";
  self setactionslot(4, actionslot4);
}

function give_killstreaks(var_67fe8973) {
  self loadout::clear_killstreaks();

  if(!level.loadoutkillstreaksenabled) {
    return;
  }

  classnum = self.class_num_for_global_weapons;
  sortedkillstreaks = [];
  currentkillstreak = 0;

  for(killstreaknum = 0; killstreaknum < var_67fe8973.size; killstreaknum++) {
    killstreakindex = var_67fe8973[killstreaknum];

    if(isDefined(killstreakindex) && killstreakindex > 0) {
      assert(isDefined(level.tbl_killstreakdata[killstreakindex]), "<dev string:x38>" + killstreakindex + "<dev string:x49>");

      if(isDefined(level.tbl_killstreakdata[killstreakindex])) {
        self.killstreak[currentkillstreak] = level.tbl_killstreakdata[killstreakindex];

        if(is_true(level.usingmomentum)) {
          killstreaktype = killstreaks::get_by_menu_name(self.killstreak[currentkillstreak]);

          if(isDefined(killstreaktype)) {
            weapon = killstreaks::get_killstreak_weapon(killstreaktype);
            self giveweapon(weapon);

            if(is_true(level.usingscorestreaks)) {
              if(weapon.iscarriedkillstreak) {
                if(!isDefined(self.pers[# "held_killstreak_ammo_count"][weapon])) {
                  self.pers[# "held_killstreak_ammo_count"][weapon] = 0;
                }

                if(!isDefined(self.pers[# "held_killstreak_clip_count"][weapon])) {
                  self.pers[# "held_killstreak_clip_count"][weapon] = 0;
                }

                if(self.pers[# "held_killstreak_ammo_count"][weapon] > 0) {
                  self killstreaks::function_fa6e0467(weapon);
                } else {
                  self loadout::function_3ba6ee5d(weapon, 0);
                }
              } else {
                quantity = 0;

                if(isDefined(self.pers[# "killstreak_quantity"]) && isDefined(self.pers[# "killstreak_quantity"][weapon])) {
                  quantity = self.pers[# "killstreak_quantity"][weapon];
                }

                self setweaponammoclip(weapon, quantity);
              }
            }

            sortdata = spawnStruct();
            sortdata.cost = self function_dceb5542(level.killstreaks[killstreaktype].itemindex);
            sortdata.weapon = weapon;
            sortindex = 0;

            for(sortindex = 0; sortindex < sortedkillstreaks.size; sortindex++) {
              if(sortedkillstreaks[sortindex].cost > sortdata.cost) {
                break;
              }
            }

            for(i = sortedkillstreaks.size; i > sortindex; i--) {
              sortedkillstreaks[i] = sortedkillstreaks[i - 1];
            }

            sortedkillstreaks[sortindex] = sortdata;
          }
        }

        currentkillstreak++;
      }
    }
  }

  var_2e1bd530 = [];
  var_2e1bd530[0] = 3;
  var_2e1bd530[1] = 1;
  var_2e1bd530[2] = 0;

  if(isDefined(level.usingmomentum) && level.usingmomentum) {
    for(sortindex = 0; sortindex < sortedkillstreaks.size && sortindex < var_2e1bd530.size; sortindex++) {
      if(sortedkillstreaks[sortindex].weapon != level.weaponnone) {
        self setkillstreakweapon(var_2e1bd530[sortindex], sortedkillstreaks[sortindex].weapon);
      }
    }
  }
}

function function_6541c917() {
  wz_loadouts::give_weapon(#"pistol_standard_t8_item");
  wz_loadouts::give_weapon(#"smg_standard_t8_item", array(#"tritium_wz_item"));
  wz_loadouts::give_item(#"frag_grenade_wz_item");
  wz_loadouts::give_item(#"hash_1e9bf9999d767989");
}

function function_ae5cdb4c() {
  wz_loadouts::give_weapon(#"pistol_standard_t8_item");
  wz_loadouts::give_weapon(#"ar_accurate_t8_item", array(#"reflex_wz_item"));
  wz_loadouts::give_item(#"frag_grenade_wz_item");
  wz_loadouts::give_item(#"hash_1e9bf9999d767989");
}

function function_a0a43fdb() {
  wz_loadouts::give_weapon(#"pistol_standard_t8_item");
  wz_loadouts::give_weapon(#"lmg_standard_t8_item", array(#"reflex_wz_item"));
  wz_loadouts::give_item(#"frag_grenade_wz_item");
  wz_loadouts::give_item(#"hash_1e9bf9999d767989");
}

function function_343266f9() {
  wz_loadouts::give_weapon(#"pistol_standard_t8_item");
  wz_loadouts::give_weapon(#"tr_powersemi_t8_item");
  wz_loadouts::give_item(#"frag_grenade_wz_item");
  wz_loadouts::give_item(#"hash_1e9bf9999d767989");
}

function function_2e725b79() {
  wz_loadouts::give_weapon(#"pistol_standard_t8_item");
  wz_loadouts::give_weapon(#"sniper_powerbolt_t8_item", array(#"sniperscope_wz_item"));
  wz_loadouts::give_item(#"frag_grenade_wz_item");
  wz_loadouts::give_item(#"hash_1e9bf9999d767989");
}

function give_max_ammo() {
  wz_loadouts::give_item(#"ammo_small_caliber_item_t9", 4);
  wz_loadouts::give_item(#"ammo_ar_item_t9", 4);
  wz_loadouts::give_item(#"ammo_large_caliber_item_t9", 4);
  wz_loadouts::give_item(#"ammo_sniper_item_t9", 4);
  wz_loadouts::give_item(#"ammo_shotgun_item_t9", 4);
  wz_loadouts::give_item(#"ammo_special_item_t9", 4);
}

function function_cb5befb2() {
  circlespawns = [];
  spawns = spawning::function_4fe2525a();
  circleorigin = level.var_35d74f0a.origin;
  circleradius = level.var_35d74f0a.radius;

  foreach(spawn in spawns) {
    distance = distance2d(spawn.origin, circleorigin);

    if(distance > circleradius) {
      continue;
    }

    if(!isDefined(circlespawns)) {
      circlespawns = [];
    } else if(!isarray(circlespawns)) {
      circlespawns = array(circlespawns);
    }

    circlespawns[circlespawns.size] = spawn;
  }

  return circlespawns;
}

function function_11fa5782(vehicletype, droppoint) {
  if(vehicletype != # "hash_6595f5efe62a4ec") {
    return;
  }

  if(!isDefined(level.var_5a6cc4da)) {
    level.var_5a6cc4da = array::randomize(struct::get_array("vehicle_drop_heli", "targetname"));
    level.var_1059a6b4 = 0;
  }

  droppoint = level.var_5a6cc4da[level.var_1059a6b4];

  if(!isDefined(droppoint)) {
    return;
  }

  ground_pos = bulletTrace(droppoint.origin + (0, 0, 128), droppoint.origin - (0, 0, 128), 0, undefined, 1);
  level.var_1059a6b4 = (level.var_1059a6b4 + 1) % level.var_5a6cc4da.size;
  var_d5552131 = spawnvehicle(vehicletype, ground_pos[# "position"] + (0, 0, 120), droppoint.angles);

  if(!isDefined(var_d5552131)) {
    return;
  }

  var_d5552131 makeusable();

  if(is_true(var_d5552131.isphysicsvehicle)) {
    var_d5552131 setbrake(1);
  }

  level thread function_c3623479(var_d5552131);
  return var_d5552131;
}

function function_4212369d() {
  if(is_true(getgametypesetting(#"hash_12e554c594614ee4"))) {
    level.var_11fa5782 = &function_11fa5782;
    vehicles = [];

    if(is_true(getgametypesetting(#"hash_7fc70ca67b167d76"))) {
      vehicles[vehicles.size] = # "vehicle_t9_mil_ru_truck_transport_player";
      vehicles[vehicles.size] = # "vehicle_t9_mil_ru_truck_transport_player";
    }

    if(is_true(getgametypesetting(#"hash_183c8366c2eb71e2"))) {
      vehicles[vehicles.size] = # "vehicle_t9_mil_fav_light";
      vehicles[vehicles.size] = # "vehicle_t9_mil_fav_light";
    }

    if(is_true(getgametypesetting(#"hash_28b3c94342b6914c"))) {
      vehicles[vehicles.size] = # "hash_6595f5efe62a4ec";
    }

    if(is_true(getgametypesetting(#"hash_21ac269b4a3e7e37"))) {
      vehicles[vehicles.size] = # "hash_28d512b739c9d9c1";
      vehicles[vehicles.size] = # "hash_28d512b739c9d9c1";
    }

    if(vehicles.size > 0) {
      level thread namespace_3d2704b3::function_add63876(vehicles, 2147483647, 120, 120, 180, 2, 45, struct::get_array("vehicle_drop", "targetname"), 6000);
    }
  }
}

function function_20d09030() {
  if(is_true(getgametypesetting(#"hash_7eb0bbf9b8410462"))) {
    switch (level.basegametype) {
      case # "fireteam_dirty_bomb":
        level thread namespace_3d2704b3::function_7fc18ad5(#"hash_27bac84003da7795", 2147483647, 80, 90, 180);
        break;
      case # "fireteam_koth":
        level thread namespace_3d2704b3::function_7fc18ad5(#"hash_1a0411d6007279fe", 2147483647, 80, 90, 180);
        break;
      case # "fireteam_elimination":
        level thread namespace_3d2704b3::function_7fc18ad5(#"hash_c09c4ba8509f91b", 2147483647, 38, 90, 180);
        break;
      case # "fireteam_satlink":
        level thread namespace_3d2704b3::function_7fc18ad5(#"hash_4b59ee69b4c70996", 2147483647, 80, 90, 180);
        break;
    }
  }
}

function function_c3623479(vehicle) {
  if(!isDefined(vehicle)) {
    return;
  }

  globallogic_audio::function_61e17de0("fireteamVehSpawn", getplayers(undefined, vehicle.origin, 6000));

  switch (vehicle.vehicletype) {
    case # "hash_6595f5efe62a4ec":
      objectivetype = "heli_drop";
      break;
    case # "hash_28d512b739c9d9c1":
      objectivetype = "tank_drop";
      break;
    case # "vehicle_t9_mil_fav_light":
      objectivetype = "fav_drop";
      break;
    case # "vehicle_t9_mil_ru_truck_transport_player":
      objectivetype = "truck_drop";
      break;
    default:
      objectivetype = "tank_drop";
      break;
  }

  vehicle.objid = gameobjects::get_next_obj_id();
  objective_add(vehicle.objid, "active", vehicle, objectivetype, vehicle);
  objective_setvisibletoall(vehicle.objid);
  vehicle thread function_e63bcc08();
  vehicle waittill(#"death");
  gameobjects::release_obj_id(vehicle.objid);
  wait 30;

  if(isDefined(vehicle)) {
    vehicle delete();
  }
}

function function_e63bcc08() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"enter_vehicle", #"exit_vehicle", #"change_seat");
    player = waitresult.player;
    owner = self getvehoccupants()[0];

    if(isDefined(owner)) {
      objective_setinvisibletoall(self.objid);
      continue;
    }

    objective_setvisibletoall(self.objid);
  }
}

function on_vehicle_spawned() {
  if(self.scriptvehicletype === "helicopter_heavy") {
    globallogic_audio::function_61e17de0("fireteamVehSpawn", getplayers(undefined, self.origin, 6000));
  }
}

function function_1f93e91f(params) {
  if(isDefined(params.vehicletype)) {
    droppoint = params.droppoint;
    offset = (0, 0, 10000);
    trace = groundtrace(params.droppoint + offset, params.droppoint - offset, 0, undefined, 0);

    if(isDefined(trace[# "position"])) {
      droppoint = trace[# "position"];
    }

    globallogic_audio::function_61e17de0("fireteamVehDrop", getplayers(undefined, droppoint, 6000));
    return;
  }

  globallogic_audio::function_61e17de0("fireteamSupplyDrop", getplayers());
}

function on_player_killed(params) {
  aliveplayers = function_a1cff525(self.squad);
  squadplayers = function_c65231e2(self.squad);

  if(aliveplayers.size == 0 && squadplayers.size > 1) {
    attacker = params.eattacker;
    callback::callback(#"squad_wiped", {
      #squad: self.squad, #players: squadplayers, #attacker: attacker
    });

    if(isPlayer(attacker) && attacker util::isenemyplayer(self)) {
      if(squadplayers.size >= max(2, (isDefined(level.var_704bcca1) ? level.var_704bcca1 : 0) - 1)) {
        scoreevents::processscoreevent(#"hash_44c301a9ab6ae990", attacker, self, params.weapon);
        attacker stats::function_cc215323(#"hash_1cfa004323a2ffe6", 1);
        attacker stats::function_dad108fa(#"hash_626ed693fa15cd7", 1);

        if(attacker stats::get_stat_global(#"hash_13ea35c63c00066c") >= 10) {
          attacker giveachievement(#"mp_achievement_squad_wipes");
        }
      }

      attacker globallogic_audio::leader_dialog_on_player("fireteamSquadWiped");
    } else {
      globallogic_audio::function_61e17de0("fireteamSquadWipedFriendly", squadplayers);
    }
  } else if(aliveplayers.size == 1) {
    if(!isDefined(level.var_e2384c19) && !aliveplayers[0] laststand::player_is_in_laststand()) {
      aliveplayers[0] globallogic_audio::leader_dialog_on_player("fireteamSquadLastAlive", undefined, undefined, undefined, undefined, undefined, undefined, 1);
    }
  }

  if(aliveplayers.size == 0 && level.spawnsystem.var_c2cc011f === 1) {
    globallogic_audio::function_61e17de0("fireteamSquadEliminated", squadplayers);
  }
}

function function_a4740127() {
  if(!level flag::get(#"hash_60fcdd11812a0134")) {
    return;
  }

  if(level.players.size == function_a1ef346b().size) {
    return;
  }

  foreach(player in level.players) {
    aliveplayers = function_a1cff525(player.squad);
    squadplayers = function_c65231e2(player.squad);

    if(aliveplayers.size == squadplayers.size) {
      player globallogic_audio::leader_dialog_on_player("fireteamEnemyRedeploy");
      continue;
    }

    if(aliveplayers.size == 1 && aliveplayers[0] == player) {
      player globallogic_audio::leader_dialog_on_player("fireteamSquadRedeploy");
      continue;
    }

    if(aliveplayers.size > 0 || !level.spawnsystem.var_c2cc011f === 1) {
      player globallogic_audio::leader_dialog_on_player("fireteamGeneralRedeploy");
    }
  }
}

function function_407d343f() {
  self loadout::give_talents(0);
  self loadout::give_perks();
}