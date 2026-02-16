/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombietron_pickups.gsc
****************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombietron_utility;

init() {
  PrecacheItem("m2_flamethrower_zt");
  PrecacheItem("ray_gun_zt");
  PrecacheItem("m60_zt");
  PrecacheItem("minigun_zt");
  PrecacheItem("spas_zt");
  PrecacheItem("china_lake_zt");
  PrecacheItem("rpg_zt");
  PrecacheVehicle("heli_mini_zt");
  map_vehicles_cleanup();
  level.prize_models = [];
  level.prize_models[level.prize_models.size] = "zombietron_gold_brick";
  level.prize_models[level.prize_models.size] = "zombietron_gold_bricks";
  level.prize_models[level.prize_models.size] = "zombietron_gold_coin";
  level.prize_models[level.prize_models.size] = "zombietron_silver_brick";
  level.prize_models[level.prize_models.size] = "zombietron_silver_bricks";
  level.prize_models[level.prize_models.size] = "zombietron_silver_coin";
  level.prize_models[level.prize_models.size] = "zombie_z_money_icon";
  level.uber_prize_models = [];
  level.uber_prize_models[level.uber_prize_models.size] = "zombietron_ruby";
  level.uber_prize_models[level.uber_prize_models.size] = "zombietron_sapphire";
  level.uber_prize_models[level.uber_prize_models.size] = "zombietron_diamond";
  for(i = 0; i < level.prize_models.size; i++) {
    PrecacheModel(level.prize_models[i]);
  }
  for(i = 0; i < level.uber_prize_models.size; i++) {
    PrecacheModel(level.uber_prize_models[i]);
  }
  level.mine_model = "p_glo_electrical_insulator01";
  PrecacheModel(level.mine_model);
  level.extra_life_model = "c_usa_blackops_body1_fb";
  PrecacheModel(level.extra_life_model);
  level.speed_model = "p_rus_boots";
  PrecacheModel(level.speed_model);
  level.tank_pickup_model = "t5_veh_tank_t55_mini_static";
  PrecacheModel(level.tank_pickup_model);
  level.heli_pickup_model = "t5_veh_helo_hind_mini";
  PrecacheModel(level.heli_pickup_model);
  level.spinning_blocker_model = "p_glo_barrel_metal_blue";
  PrecacheModel(level.spinning_blocker_model);
  level.tesla_blocker_model = "zombietron_electric_ball";
  PrecacheModel(level.tesla_blocker_model);
  level.stun_blocker_model = "zombie_teddybear";
  PrecacheModel(level.stun_blocker_model);
  level.double_shot_model = "anim_chicken";
  PrecacheModel(level.double_shot_model);
  level.bomb_model = "zombie_bomb";
  PrecacheModel(level.bomb_model);
  level.booster_model = "zombietron_lightning_bolt";
  PrecacheModel(level.booster_model);
  level.mini_turret_model = "zombie_auto_turret";
  PrecacheModel(level.mini_turret_model);
  level.monkey_model = "weapon_zombie_monkey_bomb_zt";
  PreCacheModel(level.monkey_model);
  level.cow_model = "anim_asian_water_buffalo";
  PreCacheModel(level.cow_model);
  level.red_barrel_model = "global_explosive_barrel";
  PreCacheModel(level.red_barrel_model);
  level.head_model = "char_ger_ansel_head";
  PreCacheModel(level.head_model);
  level.pickup_last_weapon = undefined;
  level.pickup_last_shield = undefined;
  level.pickup_types = [];
  level.pickup_weapons = [];
  level.pickup_types[level.pickup_types.size] = "m2_flamethrower_zt";
  level.pickup_types[level.pickup_types.size] = "minigun_zt";
  level.pickup_types[level.pickup_types.size] = "spas_zt";
  level.pickup_types[level.pickup_types.size] = "china_lake_zt";
  level.pickup_types[level.pickup_types.size] = "rpg_zt";
  level.pickup_types[level.pickup_types.size] = "ray_gun_zt";
  level.pickup_types[level.pickup_types.size] = "bomb";
  level.pickup_types[level.pickup_types.size] = "speed";
  level.pickup_types[level.pickup_types.size] = "booster";
  level.pickup_types[level.pickup_types.size] = "tank";
  level.pickup_types[level.pickup_types.size] = "mini_turret";
  level.pickup_types[level.pickup_types.size] = "mini_turret";
  level.pickup_types[level.pickup_types.size] = "mini_turret";
  level.pickup_types[level.pickup_types.size] = "monkey";
  level.pickup_types[level.pickup_types.size] = "spinning_blockers";
  level.pickup_types[level.pickup_types.size] = "tesla_blockers";
  level.pickup_types[level.pickup_types.size] = "stun_blockers";
  level.pickup_types[level.pickup_types.size] = "double_shot";
  level.pickup_types[level.pickup_types.size] = "double_shot";
  level.pickup_types[level.pickup_types.size] = "double_shot";
  level.pickup_types[level.pickup_types.size] = "heli";
  level.avail_pickups = [];
  level.pickup_mutual_exlusive = [];
  level.pickup_mutual_exlusion_list = [];
  level.pickup_mutual_exlusion_list[level.pickup_mutual_exlusion_list.size] = "tank";
  level.pickup_mutual_exlusion_list[level.pickup_mutual_exlusion_list.size] = "heli";
  level.pickup_mutual_exlusion_list[level.pickup_mutual_exlusion_list.size] = "tesla_blockers";
  level.pickup_mutual_exlusion_list[level.pickup_mutual_exlusion_list.size] = "stun_blockers";
  level.pickup_mutual_exlusion_list[level.pickup_mutual_exlusion_list.size] = "spinning_blockers";
  for(i = 0; i < level.pickup_mutual_exlusion_list.size; i++) {
    level.pickup_mutual_exlusive[level.pickup_mutual_exlusion_list[i]] = 0;
  }
  level.reward_pickups = [];
  level.reward_pickups[level.reward_pickups.size] = "bomb";
  level.reward_pickups[level.reward_pickups.size] = "heli";
  level.reward_pickups[level.reward_pickups.size] = "tank";
  level.reward_pickups[level.reward_pickups.size] = "booster";
  level.min_round_requirement["tank"] = 4;
  level.min_round_requirement["monkey"] = 5;
  level.min_round_requirement["mini_turret"] = 7;
  level.min_round_requirement["heli"] = 9;
  level thread pickup_spawner();
  level thread prize_spawner();
  level thread extra_life_spawner();
  turret_init();
}
map_vehicles_cleanup() {
  map_vehicles = getEntArray("map_vehicles", "targetname");
  for(i = 0; i < map_vehicles.size; i++) {
    map_vehicles[i] Delete();
  }
}
clear_all_pickups() {
  level notify("stop_spawning_pickups");
  wait_network_frame();
  pickupsItems = getEntArray("a_pickup_item", "script_noteworthy");
  for(i = 0; i < pickupsItems.size; i++) {
    pickup = pickupsItems[i];
    if(isDefined(pickup)) {
      if(isDefined(pickup.type) && is_type_exclusive(pickup.type)) {
        level.pickup_mutual_exlusive[pickup.type] = 0;
      }
      if(isDefined(pickup.trigger)) {
        pickup.trigger Delete();
      }
      pickup Delete();
    }
  }
}
pickup_bomb_on_player(player) {
  self endon("picked_up");
  self endon("disconnect");
  while(1) {
    if(self.origin[2] < player.origin[2]) {
      self.origin = player.origin;
      break;
    }
    modz = (player.origin[0], player.origin[1], self.origin[2] - 32);
    self.origin = modz;
    wait 0.05;
  }
}
directed_pickup_award_to(player, type, model) {
  assertex(isDefined(type), "valid type not specified");
  assertex(isDefined(player), "valid player not specified");
  assertex(isDefined(model), "valid model not specified");
  origin = player.origin + (0, 0, 800);
  pickup = spawn("script_model", origin);
  pickup.angles = (0, RandomInt(360), 0);
  pickup setModel(model);
  trigger = spawn("trigger_radius", origin, 0, 30, 128);
  pickup.type = type;
  trigger EnableLinkTo();
  trigger LinkTo(pickup);
  pickup thread wait_for_pickup(type, trigger);
  pickup thread pickup_bomb_on_player(player);
  pickup.trigger = trigger;
}
extra_life_spawner() {
  while(1) {
    waittime = RandomFloatRange(level.zombie_vars["min_extra_life_spawn_time"], level.zombie_vars["max_extra_life_spawn_time"]);
    while(waittime > 0) {
      while(!flag("round_is_active")) {
        wait 5;
      }
      wait 5;
      waittime -= 5;
    }
    players = get_players();
    lives = 0;
    for(i = 0; i < players.size; i++) {
      lives += players[i].lives;
    }
    waittime = lives * 10;
    while(waittime > 0) {
      while(!flag("round_is_active")) {
        wait 5;
      }
      wait 5;
      waittime -= 5;
    }
    if(flag("all_players_dead")) {
      continue;
    }
    spawn_point = get_random_pickup_location();
    if(isDefined(spawn_point)) {
      type = "extra_life";
      origin = spawn_point.origin;
      pickup = spawn("script_model", origin);
      pickup.script_noteworthy = "a_pickup_item";
      yaw = RandomInt(360);
      pickup.angles = (0, yaw, 0);
      pickup setModel(level.extra_life_model);
      trigger = spawn("trigger_radius", origin, 0, 30, 128);
      pickup setclientflag(level._ZT_SCRIPTMOVER_CF_POWERUP);
      pickup.type = type;
      pickup thread wait_for_pickup(type, trigger);
      pickup thread powerup_timeout(trigger);
      pickup thread powerup_wobble(trigger);
      pickup.trigger = trigger;
    }
  }
}
pickup_spawner() {
  stall = false;
  while(1) {
    if(!stall) {
      wait RandomFloatRange(10, 15);
    }
    stall = false;
    while(!flag("round_is_active")) {
      wait 1;
      stall = true;
    }
    if(stall) {
      continue;
    }
    if(flag("all_players_dead")) {
      continue;
    }
    spawn_random_pickup();
  }
}
prize_spawner() {
  stall = false;
  while(1) {
    if(!stall) {
      wait RandomFloatRange(10, 20);
    }
    stall = false;
    while(!flag("round_is_active")) {
      wait 1;
      stall = true;
    }
    if(stall) {
      continue;
    }
    if(flag("all_players_dead")) {
      continue;
    }
    spawn_prize_glob();
  }
}
spawn_treasures(spawn_point, count, radOverride, timeout) {
  level endon("stop_spawning_pickups");
  if(!isDefined(spawn_point)) {
    return;
  }
  type = "money";
  for(i = 0; i < count; i++) {
    radius = 85;
    if(isDefined(radOverride)) {
      radius = radOverride;
    }
    origin = spawn_point + (RandomIntRange(0 - radius, radius), RandomIntRange(0 - radius, radius), 24);
    if(RandomFloat(100) < level.zombie_vars["rare_price_percentage"]) {
      spawn_uber_prize(level.zombie_vars["max_prize_inc_range"] * RandomFloatRange(0.3, 1.1), origin);
    } else {
      pickup = spawn("script_model", origin);
      pickup.script_noteworthy = "a_pickup_item";
      pickup.type = type;
      yaw = RandomInt(360);
      pickup.angles = (0, yaw, 0);
      model = get_random_prize_model();
      pickup setModel(model);
      pickup setscale(RandomFloatRange(1.0, 2.0));
      pickup setclientflag(level._ZT_SCRIPTMOVER_CF_POWERUP);
      trigger = spawn("trigger_radius", origin, 0, 30, 128);
      pickup thread wait_for_pickup(type, trigger);
      if(isDefined(timeout)) {
        pickup thread powerup_timeout(trigger);
      }
      pickup thread powerup_wobble(trigger);
      pickup.trigger = trigger;
    }
    wait .2;
  }
}
spawn_prize_glob() {
  spawn_point = get_random_pickup_location();
  level thread spawn_treasures(spawn_point.origin, 3 + RandomInt(5), spawn_point.radius, true);
}
get_random_prize_model() {
  return level.prize_models[RandomInt(level.prize_models.size)];
}
spawn_uber_prize(barpoints, spawn_point) {
  type = "money";
  pickup = spawn("script_model", spawn_point);
  if(!isDefined(pickup)) {
    return;
  }
  pickup.type = type;
  pickup.script_noteworthy = "a_pickup_item";
  pickup.increments = int(barpoints);
  pickup.points = 5 * level.zombie_vars["prize_points"];
  pickup.angles = (RandomIntRange(25, 75), RandomInt(360), 0);
  model = level.uber_prize_models[RandomInt(level.uber_prize_models.size)];
  pickup setModel(model);
  quarterBar = level.zombie_vars["max_prize_inc_range"] / 4;
  scale = barpoints / quarterBar;
  scale *= 0.5;
  if(scale < 1) scale = 1;
  if(scale > 5) scale = 5;
  pickup setscale(scale);
  wait_network_frame();
  if(!isDefined(pickup)) {
    return;
  }
  trigger = spawn("trigger_radius", spawn_point, 0, 40, 128);
  pickup thread wait_for_pickup(type, trigger);
  pickup thread powerup_timeout(trigger, level.zombie_vars["powerup_uber_timeout"]);
  pickup.trigger = trigger;
  return pickup;
}
spawn_uber_prizes(increments, spawn_point, popUp, popVec) {
  quarterBar = level.zombie_vars["max_prize_inc_range"] / 4;
  while(increments > 0) {
    if(increments >= quarterBar) {
      pickup = spawn_uber_prize(quarterBar, spawn_point);
      increments -= quarterBar;
    } else {
      pickup = spawn_uber_prize(increments, spawn_point);
      increments = 0;
    }
    if(isDefined(pickup)) {
      if(isDefined(popUp)) {
        pickup.trigger EnableLinkTo();
        pickup.trigger LinkTo(pickup);
        pickup thread powerup_popup(pickup.trigger, popVec);
      } else {
        pickup thread powerup_wobble(pickup.trigger);
      }
      wait_network_frame();
    }
  }
}
powerup_popup(trigger, popVec) {
  trigger trigger_off();
  if(!isDefined(popVec)) {
    target_point = self.origin + (RandomFloatRange(-4, 4), RandomFloatRange(-4, 4), 20);
  } else {
    target_point = self.origin + popVec;
  }
  vel = target_point - self.origin;
  self.origin += 4 * vel;
  vel = vel * RandomFloatRange(25, 40);
  self PhysicsLaunch(self.origin, vel);
  wait 3;
  if(isDefined(trigger)) {
    trigger trigger_on();
  }
}
get_random_pickup_type() {
  if(level.avail_pickups.size < (level.pickup_types.size / 4)) {
    level.avail_pickups = randomize_array(level.pickup_types);
  }
  pu = level.avail_pickups[0];
  level.avail_pickups = array_remove(level.avail_pickups, pu);
  return pu;
}
get_random_pickup_location(ignore) {
  spawn_locations = [];
  pickupTarget = level.arenas[level.current_arena] + "_pickup";
  spawn_locations = getStructArray(pickupTarget, "targetname");
  if(spawn_locations.size == 0) {
    return undefined;
  }
  spawn_point = spawn_locations[RandomInt(spawn_locations.size)];
  if(isDefined(ignore)) {
    attempts = 5;
    while(attempts) {
      attempts--;
      if(spawn_point == ignore) {
        spawn_point = spawn_locations[RandomInt(spawn_locations.size)];
        continue;
      } else {
        break;
      }
    }
  }
  return spawn_point;
}
spawn_random_pickup() {
  spawn_point = get_random_pickup_location();
  if(isDefined(spawn_point)) {
    while(1) {
      type = get_random_pickup_type();
      if(can_spawn_pickup(type)) {
        radius = 75;
        if(isDefined(spawn_point.radius)) {
          radius = spawn_point.radius;
        }
        origin = spawn_point.origin + (RandomIntRange(0 - radius, radius), RandomIntRange(0 - radius, radius), 0);
        spawn_pickup(type, origin);
        break;
      }
      wait_network_frame();
    }
  }
}
spawn_random_weapon_pickup() {
  spawn_point = get_random_pickup_location();
  if(isDefined(spawn_point)) {
    while(1) {
      type = get_random_pickup_type();
      if(can_spawn_pickup(type)) {
        radius = 75;
        if(isDefined(spawn_point.radius)) {
          radius = spawn_point.radius;
        }
        origin = spawn_point.origin + (RandomIntRange(0 - radius, radius), RandomIntRange(0 - radius, radius), 0);
        spawn_pickup(type, origin);
        break;
      }
      wait_network_frame();
    }
  }
}
spawn_specific_pickup(type) {
  spawn_point = get_random_pickup_location();
  if(isDefined(spawn_point)) {
    if(can_spawn_pickup(type)) {
      radius = 75;
      if(isDefined(spawn_point.radius)) {
        radius = spawn_point.radius;
      }
      origin = spawn_point.origin + (RandomIntRange(0 - radius, radius), RandomIntRange(0 - radius, radius), 0);
      spawn_pickup(type, origin);
    }
  }
}
is_type_exclusive(type) {
  for(i = 0; i < level.pickup_mutual_exlusion_list.size; i++) {
    if(level.pickup_mutual_exlusion_list[i] == type) {
      return true;
    }
  }
  return false;
}
can_spawn_pickup(type) {
  if(isDefined(level.min_round_requirement[type])) {
    if(level.round_number < level.min_round_requirement[type]) {
      return false;
    }
  }
  if(type == "mini_turret") {
    if(level.magical_exit_taken) {
      return false;
    }
    if(!can_spawn_turret()) {
      return false;
    }
  }
  if(type == "monkey" && level.magical_exit_taken) {
    return false;
  }
  if(type == "heli" && level.arenas[level.current_arena] == "prison") {
    if(level.magical_exit_taken) {
      return false;
    }
    if(!flag("round_is_active")) {
      return false;
    }
  }
  if(is_type_exclusive(type)) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i].heli) || isDefined(players[i].tank) || isDefined(players[i].spinning_blockers) || isDefined(players[i].tesla_blockers) || isDefined(players[i].stun_blockers)) {
        return false;
      }
    }
    for(i = 0; i < level.pickup_mutual_exlusion_list.size; i++) {
      if(level.pickup_mutual_exlusive[level.pickup_mutual_exlusion_list[i]] > 0) {
        return false;
      }
    }
  }
  return true;
}
spawn_pickup(type, origin) {
  if(!isDefined(type)) {
    return;
  }
  origin += (0, 0, 32);
  pickup = spawn("script_model", origin);
  pickup.script_noteworthy = "a_pickup_item";
  pickup.angles = (0, 0, 70);
  pickup.type = type;
  trigger = undefined;
  model = GetWeaponModel(type, 0);
  if(model != "") {
    pickup setModel(model);
    trigger = spawn("trigger_radius", origin, 0, 40, 128);
    trigger.isWeapon = true;
    switch (type) {
      case "m2_flamethrower_zt":
        pickup setscale(2.5);
        break;
      case "minigun_zt":
        pickup setscale(2);
        break;
      case "spas_zt":
        pickup setscale(2.5);
        break;
      case "china_lake_zt":
        pickup setscale(2.5);
        break;
      case "rpg_zt":
        pickup setscale(2);
        break;
      case "ray_gun_zt":
        pickup setscale(4);
        break;
      default:
        pickup setscale(2);
        break;
    }
  } else if(type == "speed") {
    pickup setModel(level.speed_model);
    trigger = spawn("trigger_radius", origin, 0, 40, 128);
    pickup setscale(3);
    pickup.angles = (0, 0, -20);
  } else if(type == "tank") {
    level.pickup_mutual_exlusive["tank"] = 1;
    pickup setModel(level.tank_pickup_model);
    trigger = spawn("trigger_radius", origin, 0, 40, 128);
    pickup.angles = (0, 0, 0);
  } else if(type == "heli") {
    level.pickup_mutual_exlusive["heli"] = 1;
    pickup setModel(level.heli_pickup_model);
    pickup.origin += (0, 0, 35);
    trigger = spawn("trigger_radius", origin, 0, 40, 128);
    pickup.angles = (0, 0, 0);
  } else if(type == "spinning_blockers") {
    level.pickup_mutual_exlusive["spinning_blockers"] = 1;
    pickup setModel(level.spinning_blocker_model);
    trigger = spawn("trigger_radius", origin, 0, 40, 128);
    pickup.angles = (0, 0, 10);
  } else if(type == "tesla_blockers") {
    level.pickup_mutual_exlusive["tesla_blockers"] = 1;
    pickup setModel(level.tesla_blocker_model);
    trigger = spawn("trigger_radius", origin, 0, 40, 128);
    pickup setscale(1.5);
    pickup.angles = (0, 0, 10);
  } else if(type == "stun_blockers") {
    level.pickup_mutual_exlusive["stun_blockers"] = 1;
    pickup setModel(level.stun_blocker_model);
    trigger = spawn("trigger_radius", origin, 0, 40, 128);
    pickup setscale(2.5);
    pickup.angles = (-70, 0, 0);
  } else if(type == "double_shot") {
    pickup thread double_shot_wait_for_pickup_audio();
    pickup setModel(level.double_shot_model);
    trigger = spawn("trigger_radius", origin, 0, 40, 128);
    pickup setscale(3.0);
    pickup.angles = (0, 0, 0);
  } else if(type == "bomb") {
    pickup setModel(level.bomb_model);
    trigger = spawn("trigger_radius", origin, 0, 40, 128);
  } else if(type == "booster") {
    pickup setModel(level.booster_model);
    trigger = spawn("trigger_radius", origin, 0, 40, 128);
    pickup setscale(1.75);
    pickup.angles = (0, 0, 0);
  } else if(type == "mini_turret") {
    pickup setModel(level.mini_turret_model);
    trigger = spawn("trigger_radius", origin, 0, 40, 128);
    pickup.angles = (0, 0, 0);
  } else if(type == "monkey") {
    pickup setModel(level.monkey_model);
    trigger = spawn("trigger_radius", origin, 0, 40, 128);
    pickup.angles = (-70, 0, 0);
  } else if(type == "extra_life") {
    pickup setModel(level.extra_life_model);
    trigger = spawn("trigger_radius", origin, 0, 30, 128);
  } else {
    ASSERTMSG("No spawn fucntion for zombietron pickup type " + type);
  }
  if(pickup special_pickup_idle(type) == false) {
    pickup thread powerup_rotate(trigger);
  }
  pickup thread wait_for_pickup(type, trigger);
  pickup thread powerup_timeout(trigger);
  pickup.trigger = trigger;
  pickup setclientflag(level._ZT_SCRIPTMOVER_CF_POWERUP);
  return pickup;
}
special_pickup_idle(type) {
  if(type == "double_shot") {
    self thread chicken_idle();
    return true;
  }
  return false;
}
move_pickup_to_score(type, player) {
  x = 1000;
  y = 1500;
  z = 300;
  if(level.flipped) {
    x = 0 - x;
    y = 0 - y;
  }
  end_pt = player.origin;
  if(player.entity_num == 0) {} else if(player.entity_num == 1) {
    y = 0 - y;
  } else if(player.entity_num == 2) {
    x = 0 - x;
  } else if(player.entity_num == 3) {
    y = 0 - y;
    x = 0 - x;
  }
  end_pt += (x, y, z);
  self notify("picked_up");
  self moveto(end_pt, 1.4, 0, 0);
  self waittill("movedone");
}
wait_for_pickup(type, trigger) {
  wait .4;
  trigger waittill("trigger", player);
  if(isDefined(player)) {
    if(isDefined(trigger.isWeapon)) {
      player.special_weapon = type;
      player GiveWeapon(player.special_weapon);
      player SwitchToWeapon(player.special_weapon);
      player thread weapon_pickup_update();
    } else if(type == "money") {
      if(!isDefined(self.points)) {
        player maps\_zombietron_score::player_add_points(level.zombie_vars["prize_points"]);
      } else {
        player maps\_zombietron_score::player_add_points(self.points);
      }
      if(!isDefined(self.increments)) {
        player maps\_zombietron_score::update_multiplier_bar(player.pointBarInc);
      } else {
        player maps\_zombietron_score::update_multiplier_bar(self.increments);
      }
      self move_pickup_to_score(type, player);
    } else if(type == "extra_life" || type == "extra_life_directed") {
      if(type == "extra_life") {
        players = get_players();
        for(i = 0; i < players.size; i++) {
          player = players[i];
          player.lives++;
          if(player.lives > level.zombie_vars["max_lives"]) {
            player.lives = level.zombie_vars["max_lives"];
          }
          if(!isAlive(player)) {
            player maps\_zombietron_main::player_respawn();
          }
          player maps\_zombietron_score::update_hud();
        }
      } else {
        player.lives++;
        if(player.lives > level.zombie_vars["max_lives"]) {
          player.lives = level.zombie_vars["max_lives"];
        }
        if(!isAlive(player)) {
          player maps\_zombietron_main::player_respawn();
        }
        player maps\_zombietron_score::update_hud();
      }
      self move_pickup_to_score(type, player);
    } else if(type == "speed") {
      player thread speed_pickup_update();
    } else if(type == "tank") {
      if(isDefined(player.tank) || isDefined(player.heli)) {
        self thread wait_for_pickup(type, trigger);
        return;
      }
      player thread tank_pickup_update(self);
    } else if(type == "heli") {
      if(isDefined(player.tank) || isDefined(player.heli)) {
        self thread wait_for_pickup(type, trigger);
        return;
      }
      player thread heli_pickup_update(self);
    } else if(type == "spinning_blockers") {
      player thread spinning_blockers_update();
    } else if(type == "tesla_blockers") {
      player thread tesla_blockers_update();
    } else if(type == "stun_blockers") {
      player thread stun_blockers_update();
    } else if(type == "double_shot") {
      player thread double_shot_update();
    } else if(type == "mini_turret") {
      level thread turret_pickup_update(player);
    } else if(type == "bomb") {
      player.bombs++;
      if(player.bombs > level.zombie_vars["max_bombs"]) {
        player.bombs = level.zombie_vars["max_bombs"];
      }
      player maps\_zombietron_score::update_hud();
      self move_pickup_to_score(type, player);
    } else if(type == "booster") {
      player.boosters++;
      if(player.boosters > level.zombie_vars["max_boost"]) {
        player.boosters = level.zombie_vars["max_boost"];
      }
      player maps\_zombietron_score::update_hud();
      self move_pickup_to_score(type, player);
    } else if(type == "monkey") {
      level thread monkey_update(player, self.origin);
    }
  }
  self clearclientflag(level._ZT_SCRIPTMOVER_CF_POWERUP);
  self notify("picked_up");
  if(is_type_exclusive(type)) {
    level.pickup_mutual_exlusive[type] = 0;
  }
  if(isDefined(trigger)) {
    trigger delete();
  }
  if(isDefined(self)) {
    self Hide();
  }
  wait_network_frame();
  if(isDefined(self)) {
    self delete();
  }
}
weapon_pickup_update() {
  self notify("new_weapon_pickup");
  self endon("new_weapon_pickup");
  self endon("death");
  self endon("disconnect");
  time_left = level.zombie_vars["pickup_time"];
  if(isDefined(self.fate_fortune)) {
    time_left *= level.zombie_vars["fate_fortune_drop_mod"];
  }
  original_time = time_left;
  while(time_left > 0) {
    wait 0.05;
    if(self IsFiring()) {
      time_left -= 0.05;
    } else {
      time_left -= 0.01;
    }
    self.headshots = Int((time_left / original_time) * 1000);
  }
  self.headshots = 0;
  self TakeAllWeapons();
  self GiveWeapon(self.default_weap);
  self switchToWeapon(self.default_weap);
  self.special_weapon = undefined;
}
spinning_blockers_damage_trigger(player) {
  player endon("new_spinners_pickup");
  while(1) {
    self waittill("trigger", guy);
    if(!isDefined(guy.boss) || guy.boss == false) {
      guy playSound("zmb_pwup_barrel_impact");
      guy DoDamage(guy.health + 1, player.origin, player, undefined, "MOD_CRUSH");
      guy StartRagdoll(1);
      player PlayRumbleOnEntity("slide_rumble");
    }
  }
}
spinning_blockers_timeout(org) {
  self endon("new_spinners_pickup");
  self playLoopSound("zmb_pwup_barrel_loop", .5);
  time = level.zombie_vars["barrel_time"];
  if(isDefined(self.fate_fortune)) {
    time *= level.zombie_vars["fate_fortune_drop_mod"];
  }
  while(time > 0) {
    wait 0.05;
    time -= 0.05;
  }
  self StopLoopSound(.5);
  self playSound("zmb_pwup_barrel_end");
  self notify("new_spinners_pickup");
}
spinning_blockers_cleanup(org) {
  self waittill_any("new_spinners_pickup", "disconnect", "player_died");
  self notify("new_spinners_pickup");
  org.trigger1 Delete();
  org.trigger2 Delete();
  org.barrel1 Unlink();
  org.barrel2 Unlink();
  vel = org.barrel1.origin - self.origin;
  vel *= 10;
  org.barrel1 PhysicsLaunch(org.barrel1.origin, vel);
  vel = org.barrel2.origin - self.origin;
  vel *= 10;
  org.barrel2 PhysicsLaunch(org.barrel2.origin, vel);
  org.barrel1 playSound("zmb_pwup_barrel_fall_0");
  org.barrel2 playSound("zmb_pwup_barrel_fall_1");
  wait 5;
  org.barrel1 Delete();
  org.barrel2 Delete();
  org Delete();
  self.spinning_blockers = undefined;
}
spinning_blockers_update() {
  self notify("new_spinners_pickup");
  self endon("new_spinners_pickup");
  self.spinning_blockers = true;
  org = spawn("script_model", self.origin);
  org setModel("tag_origin");
  barrel = spawn("script_model", self.origin);
  barrel setModel(level.spinning_blocker_model);
  barrel SetPlayerCollision(0);
  barrel LinkTo(org, "tag_origin", (0, 80, 0));
  trigger = spawn("trigger_radius", barrel.origin, level.SPAWNFLAG_TRIGGER_AI_AXIS, 40, 50);
  trigger EnableLinkTo();
  trigger LinkTo(barrel);
  trigger thread spinning_blockers_damage_trigger(self);
  org.barrel1 = barrel;
  org.trigger1 = trigger;
  org LinkTo(self);
  barrel = spawn("script_model", self.origin);
  barrel setModel(level.spinning_blocker_model);
  barrel SetPlayerCollision(0);
  barrel LinkTo(org, "tag_origin", (0, -80, 0));
  trigger = spawn("trigger_radius", barrel.origin, level.SPAWNFLAG_TRIGGER_AI_AXIS, 40, 50);
  trigger EnableLinkTo();
  trigger LinkTo(barrel);
  trigger thread spinning_blockers_damage_trigger(self);
  org.barrel2 = barrel;
  org.trigger2 = trigger;
  self thread spinning_blockers_timeout(org);
  self thread spinning_blockers_cleanup(org);
  while(1) {
    org rotateTo(org.angles + (0, 180, 0), 0.9);
    wait 0.9;
  }
}
tesla_blockers_damage_trigger(player) {
  player endon("new_tesla_pickup");
  player endon("disconnect");
  while(1) {
    self waittill("trigger", guy);
    if(maps\_zombietron_weapon::tesla_ok_to_discharge(player)) {
      if(isDefined(guy.damagedby) && guy.damagedby == "tesla") {
        continue;
      } else {
        guy.damagedby = "tesla";
        playFXOnTag(level._effect["tesla_contact"], guy, "j_head");
        guy DoDamage(1, player.origin, player, undefined, "MOD_UNKNOWN");
        self.triggered = true;
        break;
      }
    }
  }
}
tesla_blockers_timeout(org) {
  self endon("new_tesla_pickup");
  self playLoopSound("zmb_pwup_coco_loop");
  time = level.zombie_vars["tesla_time"];
  if(isDefined(self.fate_fortune)) {
    time *= level.zombie_vars["fate_fortune_drop_mod"];
  }
  time = time * 1000 + GetTime();
  while(GetTime() < time) {
    wait 0.05;
  }
  self StopLoopSound(.5);
  self playSound("zmb_pwup_coco_end");
  self notify("new_tesla_pickup");
}
tesla_blockers_cleanup(org) {
  self waittill_any("new_tesla_pickup", "disconnect", "player_died");
  self notify("new_tesla_pickup");
  for(i = 0; i < org.triggers.size; i++) {
    if(isDefined(org.triggers[i])) {
      org.triggers[i] Delete();
      org.objects[i] Unlink();
      vel = org.objects[i].origin - self.origin;
      vel *= 10;
      org.objects[i] PhysicsLaunch(org.objects[i].origin, vel);
      wait 0.5;
    }
  }
  wait 2;
  for(i = 0; i < org.objects.size; i++) {
    if(isDefined(org.objects[i])) {
      org.objects[i] Delete();
    }
  }
  org Delete();
  self.tesla_blockers = undefined;
}
tesla_blockers_deletion_monitors(org) {
  self endon("new_tesla_pickup");
  while(1) {
    for(i = 0; i < org.objects.size; i++) {
      if(isDefined(org.triggers[i]) && isDefined(org.triggers[i].triggered)) {
        org.triggers[i] Delete();
        org.objects[i] Delete();
      }
    }
    wait 0.05;
  }
}
tesla_blockers_move(org) {
  self endon("new_tesla_pickup");
  while(1) {
    org rotateTo(org.angles + (0, 180, 0), 1.0);
    wait 1;
  }
}
tesla_blockers_fx(org) {
  self endon("new_tesla_pickup");
  self endon("disconnect");
  for(i = 0; i < org.objects.size; i++) {
    if(isDefined(org.objects[i])) {
      playFXOnTag(level._effect["coconut"], org.objects[i], "tag_origin");
    }
  }
}
tesla_blockers_update() {
  self notify("new_tesla_pickup");
  self endon("new_tesla_pickup");
  self.tesla_blockers = true;
  org = spawn("script_model", self.origin);
  org.origin += (0, 0, 0);
  org setModel("tag_origin");
  org LinkTo(self);
  tesla = spawn("script_model", self.origin);
  tesla setModel(level.tesla_blocker_model);
  tesla LinkTo(org, "tag_origin", (0, 80, 50));
  trigger = spawn("trigger_radius", tesla.origin, level.SPAWNFLAG_TRIGGER_AI_AXIS | level.SPAWNFLAG_TRIGGER_NOT_PLAYER, 18, 50);
  trigger EnableLinkTo();
  trigger LinkTo(tesla);
  trigger thread tesla_blockers_damage_trigger(self);
  org.objects[0] = tesla;
  org.triggers[0] = trigger;
  tesla = spawn("script_model", self.origin);
  tesla setModel(level.tesla_blocker_model);
  tesla LinkTo(org, "tag_origin", (0, -80, 50));
  trigger = spawn("trigger_radius", tesla.origin, level.SPAWNFLAG_TRIGGER_AI_AXIS | level.SPAWNFLAG_TRIGGER_NOT_PLAYER, 18, 50);
  trigger EnableLinkTo();
  trigger LinkTo(tesla);
  trigger thread tesla_blockers_damage_trigger(self);
  org.objects[1] = tesla;
  org.triggers[1] = trigger;
  tesla = spawn("script_model", self.origin);
  tesla setModel(level.tesla_blocker_model);
  tesla LinkTo(org, "tag_origin", (80, 0, 50));
  trigger = spawn("trigger_radius", tesla.origin, level.SPAWNFLAG_TRIGGER_AI_AXIS | level.SPAWNFLAG_TRIGGER_NOT_PLAYER, 18, 50);
  trigger EnableLinkTo();
  trigger LinkTo(tesla);
  trigger thread tesla_blockers_damage_trigger(self);
  org.objects[2] = tesla;
  org.triggers[2] = trigger;
  tesla = spawn("script_model", self.origin);
  tesla setModel(level.tesla_blocker_model);
  tesla LinkTo(org, "tag_origin", (-80, 0, 50));
  trigger = spawn("trigger_radius", tesla.origin, level.SPAWNFLAG_TRIGGER_AI_AXIS | level.SPAWNFLAG_TRIGGER_NOT_PLAYER, 18, 50);
  trigger EnableLinkTo();
  trigger LinkTo(tesla);
  trigger thread tesla_blockers_damage_trigger(self);
  org.objects[3] = tesla;
  org.triggers[3] = trigger;
  self thread tesla_blockers_move(org);
  self thread tesla_blockers_fx(org);
  self thread tesla_blockers_deletion_monitors(org);
  self thread tesla_blockers_timeout(org);
  self thread tesla_blockers_cleanup(org);
}
stunned_guy_think() {
  self.stunned = true;
  wait level.zombie_vars["stun_effect_time"];
  self.stunned = undefined;
}
stun_blockers_damage_trigger(player) {
  player endon("new_stun_pickup");
  while(1) {
    self waittill("trigger", guy);
    if(!isDefined(guy.stunned) && !isDefined(guy.boss)) {
      guy playSound("zmb_pwup_bear_stun");
      playFXOnTag(level._effect["stun_bear_explode"], guy, "j_hip_le");
      player PlayRumbleOnEntity("slide_rumble");
      guy thread stunned_guy_think();
    }
  }
}
stun_blockers_timeout(org) {
  self endon("new_stun_pickup");
  self playLoopSound("zmb_pwup_bear_loop");
  time = level.zombie_vars["stun_time"];
  if(isDefined(self.fate_fortune)) {
    time *= level.zombie_vars["fate_fortune_drop_mod"];
  }
  time = time * 1000 + GetTime();
  while(GetTime() < time) {
    wait_network_frame();
  }
  self StopLoopSound(.5);
  self playSound("zmb_pwup_bear_end");
  self notify("new_stun_pickup");
}
stun_blockers_cleanup(org) {
  self waittill_any("new_stun_pickup", "disconnect", "player_died");
  self notify("new_stun_pickup");
  playFXOnTag(level._effect["stun_bear_fade"], self, "tag_origin");
  wait 0.5;
  org.trigger Delete();
  org Delete();
  self.stun_blockers = undefined;
}
stun_blockers_update() {
  self notify("new_stun_pickup");
  self endon("new_stun_pickup");
  self.stun_blockers = true;
  org = spawn("script_model", self.origin);
  org.origin += (0, 0, 0);
  org setModel("tag_origin");
  org LinkTo(self);
  trigger = spawn("trigger_radius", org.origin, level.SPAWNFLAG_TRIGGER_AI_AXIS + level.SPAWNFLAG_TRIGGER_NOT_PLAYER, 130, 50);
  trigger EnableLinkTo();
  trigger LinkTo(org);
  trigger thread stun_blockers_damage_trigger(self);
  org.trigger = trigger;
  playFXOnTag(level._effect["stun_bear"], org, "tag_origin");
  self thread stun_blockers_timeout(org);
  self thread stun_blockers_cleanup(org);
}
double_shot_fire(orb, weapon) {
  if(!isDefined(weapon)) {
    weapon = self getcurrentweapon();
  }
  if(!isDefined(weapon) || weapon == "none") {
    return;
  }
  setweapon(orb, weapon);
  fire(orb, self);
}
double_shot_fire_loop(orb) {
  orb endon("death");
  orb endon("spinning_out");
  while(1) {
    self waittill("weapon_fired");
    if(isDefined(self.tank)) {
      self double_shot_fire(orb, "china_lake_zt");
    } else
    if(isDefined(self.heli)) {
      self double_shot_fire(orb, "ray_gun_zt");
    } else {
      self double_shot_fire(orb);
    }
  }
}
double_shot_disconnect_watch_helper(orb, is_chicken, fated) {
  orb endon("death");
  if(isDefined(fated)) {
    is_chicken = undefined;
  }
  if(isDefined(is_chicken) && is_chicken) {
    self waittill_any("disconnect", "player_died");
  } else {
    self waittill("disconnect");
  }
  if(isDefined(orb)) {
    orb notify("spin_out");
  }
}
double_shot_disconnect_watch(orb, is_chicken) {
  if(isDefined(self.fate) && self.fate == "friendship") {
    self thread double_shot_disconnect_watch_helper(orb, is_chicken, true);
  } else {
    self thread double_shot_disconnect_watch_helper(orb, is_chicken);
  }
  orb waittill("spin_out", weapon);
  orb notify("spinning_out");
  self notify("orb_spinning_out");
  if(!isDefined(weapon) || weapon == "none") {
    weapon = "m60_zt";
  }
  if(isDefined(is_chicken) && is_chicken) {
    orb thread chicken_death_idle();
  }
  spinOutTime = 5;
  fireTime = WeaponFireTime(weapon);
  if(fireTime < 0.05) {
    fireTime = 0.05;
  }
  while(spinOutTime > 0) {
    rotate180Time = 1.0;
    orb rotateTo(orb.angles + (0, 180, 0), rotate180Time);
    localRotateTime = rotate180Time;
    while(localRotateTime > 0) {
      self double_shot_fire(orb, weapon);
      wait fireTime;
      localRotateTime -= fireTime;
    }
    spinOutTime -= rotate180Time;
  }
  orb playSound("zmb_dblshot_end");
  forward = (orb.origin + (0, 0, 1)) - orb.origin;
  playFX(level._effect["chicken_done"], orb.origin, forward);
  forward = (orb.origin + (0, 1, 0)) - orb.origin;
  playFX(level._effect["chicken_done"], orb.origin, forward);
  forward = (orb.origin + (1, 0, 0)) - orb.origin;
  playFX(level._effect["chicken_done"], orb.origin, forward);
  wait_network_frame();
  orb Delete();
}
double_shot_exit_watcher(orb) {
  self endon("disconnect");
  orb endon("spinning_out");
  while(1) {
    self waittill("move_to_start");
    for(i = 0; i < orb.follow_points.size; i++) {
      orb.follow_points[i] = self.origin;
    }
  }
}
double_shot_chicken_time_add(orb) {
  self endon("disconnect");
  orb endon("spinning_out");
  while(isDefined(orb)) {
    self waittill("another_chicken");
    time = level.zombie_vars["double_shot_time"];
    if(isDefined(self.fate_fortune)) {
      time *= level.zombie_vars["fate_fortune_drop_mod"];
    }
    orb.timeout = time * 1000 + GetTime();
  }
}
double_shot_update() {
  self endon("disconnect");
  orb = spawn("script_model", self.origin + (0, 0, 50));
  orb setModel(level.double_shot_model);
  orb endon("spinning_out");
  self thread double_shot_disconnect_watch(orb, true);
  orb.follow_points = [];
  num_follow_points = 5;
  for(i = 0; i < num_follow_points; i++) {
    orb.follow_points[i] = self.origin;
  }
  if(isDefined(self.double_shot_orb)) {
    self.double_shot_orb.follow_ent = orb;
  }
  if(isDefined(self.fate_shot_orb)) {
    orb.follow_ent = self.fate_shot_orb;
  } else {
    orb.follow_ent = self;
  }
  self.double_shot_orb = orb;
  self thread double_shot_exit_watcher(orb);
  self thread double_shot_fire_loop(orb);
  self thread double_shot_audio_loop(orb);
  self thread double_shot_audio_death(orb);
  orb thread chicken_active_idle();
  self notify("another_chicken");
  time = level.zombie_vars["double_shot_time"];
  if(isDefined(self.fate) && (isDefined(self.fate_fortune) || self.fate == "friendship")) {
    time *= level.zombie_vars["fate_fortune_drop_mod"];
  }
  orb.timeout = time * 1000 + GetTime();
  follow_index = 0;
  next_index = follow_index + 1;
  while(GetTime() < orb.timeout && isDefined(orb)) {
    if(isPlayer(self)) {
      orb.angles = self GetPlayerAngles();
    } else {
      orb.angles = self.angles;
    }
    if(Distance2dSquared(orb.follow_ent.origin, orb.follow_points[follow_index]) > 4 * 4) {
      follow_pt = orb.follow_ent.origin;
      if(isPlayer(orb.follow_ent)) {
        follow_pt = follow_pt + (0, 0, 50);
        if(isDefined(self.fate_shot_orb)) {
          orb.follow_ent = self.fate_shot_orb;
        }
      }
      orb.follow_points[next_index] = follow_pt;
      follow_index = next_index;
      next_index++;
      next_index = next_index % num_follow_points;
      orb moveTo(orb.follow_points[next_index], 0.15, 0, 0);
    }
    wait_network_frame();
  }
  if(isDefined(self.double_shot_orb) && self.double_shot_orb == orb) {
    self.double_shot_orb = undefined;
  }
  orb notify("spin_out", self getcurrentweapon());
}
fated_double_shot_update(model) {
  self endon("disconnect");
  orb = spawn("script_model", self.origin + (0, 0, 50));
  if(isDefined(model)) {
    orb setModel(model);
  } else {
    orb setModel(level.double_shot_model);
  }
  orb.follow_points = [];
  num_follow_points = 5;
  orb playSound("zmb_dblshot_spawn");
  for(i = 0; i < num_follow_points; i++) {
    orb.follow_points[i] = self.origin;
  }
  self.fate_shot_orb = orb;
  orb.follow_ent = self;
  self thread double_shot_fire_loop(orb);
  self thread double_shot_disconnect_watch(orb);
  self thread double_shot_audio_loop(orb);
  orb thread fated_active_idle();
  follow_index = 0;
  next_index = follow_index + 1;
  while(1) {
    orb.angles = self.angles;
    if(Distance2dSquared(orb.follow_ent.origin, orb.follow_points[follow_index]) > 6 * 6) {
      follow_pt = orb.follow_ent.origin;
      if(isPlayer(orb.follow_ent)) {
        follow_pt = follow_pt + (0, 0, 50);
      }
      orb.follow_points[next_index] = follow_pt;
      follow_index = next_index;
      next_index++;
      next_index = next_index % num_follow_points;
      orb moveTo(orb.follow_points[next_index], 0.2, 0, 0);
    }
    wait 0.05;
  }
}
heli_rocket_loop(mini_heli) {
  mini_heli endon("death");
  mini_heli DisableGunnerFiring(0, true);
  weapon = "hind_rockets_zt";
  fire_tags = [];
  fire_tags[0] = "tag_rocket1";
  fire_tags[1] = "tag_rocket3";
  fire_tags[2] = "tag_rocket2";
  fire_tags[3] = "tag_rocket4";
  fire_index = 0;
  while(1) {
    driver = mini_heli GetSeatOccupant(0);
    if(isDefined(driver) && driver attackButtonPressed()) {
      fire_tag = fire_tags[fire_index];
      origin = mini_heli GetTagOrigin(fire_tag);
      angles = mini_heli GetTagAngles("tag_flash_gunner1");
      endpt = origin + anglesToForward(angles) * 500;
      MagicBullet(weapon, origin, endpt, driver);
      fire_time = WeaponFireTime(weapon);
      wait fire_time;
      fire_index++;
      fire_index = fire_index % 4;
    }
    wait .05;
  }
}
pop_off_head() {
  self setclientflag(level._ZT_ACTOR_CF_KILLED_BY_HELI);
}
heli_trigger_think(player) {
  self endon("death");
  while(1) {
    self waittill("trigger", guy);
    if(!isDefined(guy.launched) && !isPlayer(guy)) {
      if(!isDefined(guy.boss) || guy.boss == false) {
        guy.a.gib_ref = "head";
        guy.a.gib_vel = (0, 0, 3500);
        guy DoDamage(guy.health + 1, guy.origin + (0, 0, -25), player, undefined, "explosive", "head");
        if(isDefined(guy.is_dog)) {
          continue;
        }
        guy SetPlayerCollision(0);
        if(ok_to_gib() && !isDefined(guy.is_quad) && !isDefined(guy.is_dog)) {
          guy pop_off_head();
        }
        guy StartRagdoll(1);
        guy.launched = true;
      }
    }
  }
}
heli_zombie_poi(player) {
  players = GetPlayers();
  index = 0;
  for(i = 0; i < players.size; i++) {
    if(players[i] == player) {
      index = i;
      break;
    }
  }
  poi = spawn("script_model", player.origin);
  poi thread destroy_me_on_player_notify(player, "disconnect");
  poi thread destroy_me_on_player_notify(player, "veh_done");
  level.active_heli[index] = poi;
  while(isDefined(poi)) {
    trace = bulletTrace(self.origin, self.origin + (0, 0, -500), false, undefined);
    poi.origin = (self.origin[0], self.origin[1], trace["position"][2]);
    wait 1;
  }
  level.active_heli = array_remove(level.active_heli, level.active_heli[index]);
}
push_origin_out(origin, radius) {
  mins = (-4, -4, 0);
  maxs = (4, 4, 4);
  dir = (1, 0, 0);
  hitp = PlayerPhysicsTrace(origin, origin + dir * radius, mins, maxs);
  dist = Distance(hitp, origin);
  if(dist < radius) {
    origin = origin - dir * (radius - dist);
  }
  dir = (-1, 0, 0);
  hitp = PlayerPhysicsTrace(origin, origin + dir * radius, mins, maxs);
  dist = Distance(hitp, origin);
  if(dist < radius) {
    origin = origin - dir * (radius - dist);
  }
  dir = (0, 1, 0);
  hitp = PlayerPhysicsTrace(origin, origin + dir * radius, mins, maxs);
  dist = Distance(hitp, origin);
  if(dist < radius) {
    origin = origin - dir * (radius - dist);
  }
  dir = (0, -1, 0);
  hitp = PlayerPhysicsTrace(origin, origin + dir * radius, mins, maxs);
  dist = Distance(hitp, origin);
  if(dist < radius) {
    origin = origin - dir * (radius - dist);
  }
  return origin;
}
heli_pickup_update(pickup) {
  self EnableInvulnerability();
  origin = push_origin_out(self.origin, 30);
  heli = SpawnVehicle("t5_veh_helo_hind_mini", "player_heli", "heli_mini_zt", origin + (0, 0, level.heli_height), self.angles);
  heli.health = 100000;
  heli.lockheliheight = true;
  heli MakeVehicleUsable();
  heli UseBy(self);
  heli MakeVehicleUnusable();
  heli.takedamage = false;
  self.heli = heli;
  heli.player = self;
  heli maps\_vehicle::turret_attack_think();
  heli thread heli_rocket_loop(heli);
  trigger = spawn("trigger_radius", origin, level.SPAWNFLAG_TRIGGER_AI_AXIS, 55, 60);
  trigger EnableLinkTo();
  trigger LinkTo(heli, "tag_origin", (0, 0, -60));
  trigger thread heli_trigger_think(self);
  self notify("veh_activated");
  self setclientflag(level._ZT_PLAYER_CF_HELI_PILOT);
  time_left = level.zombie_vars["heli_alive_time"];
  if(isDefined(self.fate_fortune)) {
    time_left *= level.zombie_vars["fate_fortune_drop_mod"];
  }
  heli thread heli_zombie_poi(self);
  heli thread veh_chicken_watcher();
  self waittill_any_or_timeout(time_left, "disconnect", "heli_abort");
  self notify("veh_done");
  self clearclientflag(level._ZT_PLAYER_CF_HELI_PILOT);
  trigger Delete();
  self.heli = undefined;
  if(self.usingvehicle) {
    heli MakeVehicleUsable();
    heli UseBy(self);
  }
  heli Delete();
  playFX(level._effect["respawn"], self.origin, anglesToForward(self.angles));
  self RadiusDamage(self.origin, 200, 10000, 10000, self);
  self DisableInvulnerability();
  self turn_shield_on(true);
}
veh_chicken_watcher() {
  while(isDefined(self)) {
    self waittill_any("turret_fire");
    if(isDefined(self.player.double_shot_orb) || isDefined(self.player.fate_shot_orb)) {
      self.player notify("weapon_fired");
    }
  }
}
tank_outofworld_watcher() {
  self endon("death");
  self endon("disconnect");
  min_dist_squared = 1300 * 1300;
  while(isDefined(self.tank)) {
    origin = maps\_zombietron_main::get_camera_center_point();
    dist_squared = DistanceSquared(origin, self.origin);
    if(dist_squared > min_dist_squared) {
      self.aborted_tank = true;
      self notify("tank_abort");
    }
    wait .25;
  }
}
tank_pickup_update(pickup) {
  self EnableInvulnerability();
  origin = push_origin_out(pickup.origin, 30);
  tank = SpawnVehicle("t5_veh_tank_t55_mini", "player_tank", "tank_t55_mini", origin, self.angles);
  tank.health = 100000;
  tank MakeVehicleUsable();
  tank UseBy(self);
  tank MakeVehicleUnusable();
  tank.takedamage = false;
  self.tank = tank;
  tank.player = self;
  tank maps\_vehicle::turret_attack_think();
  playFXOnTag(level._effect[self.light_playFX], tank, "tag_origin");
  time_left = level.zombie_vars["tank_alive_time"];
  if(isDefined(self.fate_fortune)) {
    time_left *= level.zombie_vars["fate_fortune_drop_mod"];
  }
  self notify("veh_activated");
  tank thread veh_chicken_watcher();
  self thread tank_outofworld_watcher();
  self waittill_any_or_timeout(time_left, "disconnect", "tank_abort");
  self notify("veh_done");
  self.tank = undefined;
  if(self.usingvehicle) {
    tank MakeVehicleUsable();
    tank UseBy(self);
  }
  tank Delete();
  if(isDefined(self.aborted_tank)) {
    self.aborted_tank = undefined;
    origin = maps\_zombietron_main::get_player_spawn_point();
    above = origin + (0, 0, 100);
    below = origin + (0, 0, -100);
    hitp = PlayerPhysicsTrace(above, below);
    self SetOrigin(hitp);
  }
  playFX(level._effect["respawn"], self.origin, anglesToForward(self.angles));
  self RadiusDamage(self.origin, 200, 10000, 10000, self);
  self DisableInvulnerability();
  self turn_shield_on(true);
}
speed_pickup_cleanup() {
  self waittill_any("new_speed_pickup", "disconnect", "player_died");
  self SetMoveSpeedScale(self.default_movespeed);
  self StopLoopSound(.5);
  self playSound("zmb_pwup_speed_end");
}
speed_pickup_update() {
  self notify("new_speed_pickup");
  self endon("new_speed_pickup");
  self endon("disconnect");
  self thread speed_pickup_cleanup();
  wait 0.05;
  self playLoopSound("zmb_pwup_speed_loop");
  self SetMoveSpeedScale(level.zombie_vars["player_speed"]);
  playFXOnTag(level._effect["character_fire_death_sm"], self, "tag_origin");
  time_left = level.zombie_vars["player_speed_time"];
  if(isDefined(self.fate_fortune)) {
    time_left *= level.zombie_vars["fate_fortune_drop_mod"];
  }
  wait(time_left);
  self StopLoopSound(.5);
  self playSound("zmb_pwup_speed_end");
  self SetMoveSpeedScale(self.default_movespeed);
}
powerup_wobble(trigger) {
  trigger endon("trigger");
  while(isDefined(self)) {
    waittime = randomfloatrange(2.5, 5);
    yaw = RandomInt(360);
    if(yaw > 300) {
      yaw = 300;
    } else if(yaw < 60) {
      yaw = 60;
    }
    yaw = self.angles[1] + yaw;
    self rotateto((-20 + randomint(40), yaw, -90 + randomint(180)), waittime, waittime * 0.5, waittime * 0.5);
    wait randomfloat(waittime - 0.1);
  }
}
powerup_rotate(trigger) {
  trigger endon("trigger");
  if(isDefined(self)) {
    playFXOnTag(level._effect["powerup_on_red"], self, "tag_origin");
  }
  dir = 180;
  if(RandomInt(100) > 50) {
    dir = -180;
  }
  time = RandomFloatRange(3, 7);
  while(isDefined(self)) {
    self rotateTo(self.angles + (0, dir, 0), time);
    wait time;
  }
}
powerup_timeout(trigger, timeout) {
  trigger endon("trigger");
  if(!isDefined(timeout)) {
    wait level.zombie_vars["powerup_timeout"];
  } else {
    wait timeout;
  }
  for(i = 0; i < 40; i++) {
    if(!isDefined(self)) {
      break;
    }
    if(i % 2) {
      self hide();
    } else {
      self show();
    }
    if(i < 15) {
      wait 0.5;
      wait_network_frame();
    } else if(i < 25) {
      wait 0.25;
      wait_network_frame();
    } else {
      wait 0.1;
      wait_network_frame();
    }
  }
  if(isDefined(trigger)) {
    trigger notify("trigger");
  }
  if(isDefined(self)) {
    self delete();
  }
}
get_random_mine_location() {
  spawn_locations = [];
  hazardTarget = level.arenas[level.current_arena] + "_hazard";
  spawn_locations = getStructArray(hazardTarget, "targetname");
  if(spawn_locations.size == 0) {
    return undefined;
  }
  spawn_point = spawn_locations[RandomInt(spawn_locations.size)];
  return spawn_point;
}
wait_for_mine_pickup(trigger) {
  self endon("death");
  while(1) {
    trigger waittill("trigger", guy);
    if(isDefined(guy) && isDefined(self.active) && self.active) {
      if(!(isDefined(guy.tank) || isDefined(guy.boss))) {
        guy playSound("zmb_hazard_hit");
        guy DoDamage(guy.health + 500, self.origin);
      }
      playFXOnTag(level._effect["tesla_contact"], guy, "j_head");
      wait .05;
    }
  }
}
mine_off_on_loop() {
  self endon("death");
  self setclientflag(level._ZT_SCRIPTMOVER_CF_ELEC_TRAP);
  wait 0.5;
  self clearclientflag(level._ZT_SCRIPTMOVER_CF_ELEC_TRAP);
  wait 10;
  self thread wait_for_mine_pickup(self.trigger);
  while(1) {
    self setclientflag(level._ZT_SCRIPTMOVER_CF_ELEC_TRAP);
    wait 1.2;
    self.active = true;
    wait RandomFloatRange(4, 10);
    self clearclientflag(level._ZT_SCRIPTMOVER_CF_ELEC_TRAP);
    self.active = false;
    wait RandomFloatRange(3, 6);
  }
}
delete_sound_ent_on_death(ent) {
  self waittill("death");
  ent Delete();
}
AdjustMineOrigin(origin) {
  min_dist = 24;
  min_dist_squared = min_dist * min_dist;
  pushed = true;
  max_tries = 3;
  while(pushed && max_tries > 0) {
    max_tries--;
    pushed = false;
    for(i = 0; i < level.mines.size; i++) {
      mine = level.mines[i];
      if(isDefined(mine)) {
        dist_squared = DistanceSquared(origin, mine.origin);
        if(dist_squared < min_dist_squared) {
          dir = origin - mine.origin;
          dir = VectorNormalize(dir);
          origin = origin + dir * min_dist;
          pushed = true;
        }
      }
    }
  }
  return origin;
}
clear_mines() {
  if(!isDefined(level.mines)) {
    level.mines = [];
  }
  for(i = 0; i < level.mines.size; i++) {
    if(isDefined(level.mines[i])) {
      level.mines[i].trigger Delete();
      if(isDefined(level.mines[i].fx)) {
        level.mines[i].fx Delete();
      }
      if(isDefined(level.mines[i].fx2)) {
        level.mines[i].fx2 Delete();
      }
      level.mines[i] Delete();
    }
  }
  level.mines = [];
}
spawn_mines() {
  clear_mines();
  count = 1 + RandomInt(2 + Int((level.round_number - 4) / 3));
  for(i = 0; i < count; i++) {
    spawn_point = get_random_mine_location();
    if(!isDefined(spawn_point)) {
      return;
    }
    radius = 85;
    if(isDefined(spawn_point.radius)) {
      radius = spawn_point.radius;
    }
    origin = spawn_point.origin + (RandomIntRange(0 - radius, radius), RandomIntRange(0 - radius, radius), 0);
    origin = AdjustMineOrigin(origin);
    pickup = spawn("script_model", origin);
    pickup setModel(level.mine_model);
    pickup.trigger = spawn("trigger_radius", origin, level.SPAWNFLAG_TRIGGER_AI_AXIS, 20, 50);
    pickup thread mine_off_on_loop();
    level.mines[i] = pickup;
  }
}
shield_debug() {
  self endon("death");
  while(1) {
    drawcylinder(self.origin, 65, 50);
    wait 0.05;
  }
}
shield_trigger_think(player) {
  self endon("death");
  self endon("disconnect");
  while(1) {
    self waittill("trigger", guy);
    if(!isDefined(guy)) {
      continue;
    }
    if(isPlayer(guy)) {
      continue;
    }
    if(isDefined(guy.launched)) {
      continue;
    }
    if(isDefined(guy.boss)) {
      continue;
    }
    if(!IsSentient(guy)) {
      continue;
    }
    if(isDefined(player.rhino_deaths)) {
      player.rhino_deaths++;
    }
    guy SetPlayerCollision(0);
    guy DoDamage(guy.health + 1, player.origin, player, undefined, "explosive");
    guy StartRagdoll(1);
    guy LaunchRagdoll((0, 0, 220));
    guy.launched = true;
    guy playSound("zmb_ragdoll_launched");
    player PlayRumbleOnEntity("slide_rumble");
  }
}
shield_flag_on(onOff) {
  if(onOff) {
    self.shield_is_on = 1;
  } else {
    self.shield_is_on = undefined;
  }
}
turn_shield_on(short_shield) {
  shield_flag_on(1);
  self EnableInvulnerability();
  wait 0.05;
  trigger = spawn("trigger_radius", self.origin, level.SPAWNFLAG_TRIGGER_AI_AXIS, 65, 50);
  trigger EnableLinkTo();
  trigger LinkTo(self);
  trigger thread shield_trigger_think(self);
  if(!isDefined(short_shield) || !short_shield) {
    if(!isDefined(self.tank) && !isDefined(self.heli)) {
      trigger playSound("zmb_player_shield_full");
      playFXOnTag(level._effect["shield"], self, "tag_origin");
    }
    wait 2.9;
    if(!isDefined(self.tank) && !isDefined(self.heli)) {
      playFXOnTag(level._effect["shield"], self, "tag_origin");
    }
    wait 2.7;
  }
  if(!isDefined(self.tank) && !isDefined(self.heli)) {
    trigger playSound("zmb_player_shield_half");
    playFXOnTag(level._effect["shield_gone"], self, "tag_origin");
  }
  wait 3;
  trigger Delete();
  shield_flag_on(0);
  if(!isDefined(self.tank) && !isDefined(self.heli)) {
    self playSound("zmb_player_shield_end");
    self DisableInvulnerability();
  }
}
update_drop_booster() {
  self notify("update_drop_booster");
  self endon("update_drop_booster");
  while(1) {
    wait 0.05;
    if(IsAlive(self) && !level.in_intermission && !isDefined(self.tank) && !isDefined(self.heli) && self jumpbuttonPressed()) {
      if(isDefined(self.boosters) && self.boosters > 0) {
        self.rhino_deaths = 0;
        self playSound("zmb_speed_boost_activate");
        self.boosters--;
        self maps\_zombietron_score::update_hud();
        self EnableInvulnerability();
        curdir = anglesToForward((0, 0, 0));
        trigger = spawn("trigger_radius", self.origin, level.SPAWNFLAG_TRIGGER_AI_AXIS, 85, 50);
        trigger EnableLinkTo();
        trigger LinkTo(self, "tag_origin", curdir * 200, self.angles);
        trigger thread shield_trigger_think(self);
        trigger2 = spawn("trigger_radius", self.origin, level.SPAWNFLAG_TRIGGER_AI_AXIS, 85, 50);
        trigger2 EnableLinkTo();
        trigger2 LinkTo(self, "tag_origin", curdir * 50, self.angles);
        trigger2 thread shield_trigger_think(self);
        curdir = anglesToForward(self.angles);
        endTime = GetTime() + 600;
        boost_vector = curdir * 2000;
        boost_vector += (0, 0, 200);
        self SetVelocity(boost_vector);
        boost_vector -= (0, 0, 200);
        while(GetTime() < endTime) {
          self SetVelocity(boost_vector);
          self PlayRumbleOnEntity("slide_rumble");
          wait 0.05;
        }
        if(self.rhino_deaths >= 20) {
          self giveachievement_wrapper("SP_ZOM_CHICKENS");
        }
        self.rhino_deaths = undefined;
        trigger Delete();
        trigger2 Delete();
        if(!isDefined(self.tank) && !isDefined(self.heli)) {
          self DisableInvulnerability();
        }
      }
    }
  }
}
update_drop_bomb() {
  self notify("update_drop_bomb");
  self endon("update_drop_bomb");
  while(1) {
    if(IsAlive(self) && !level.in_intermission && self fragButtonPressed()) {
      if(isDefined(self.bombs) && self.bombs > 0) {
        self EnableInvulnerability();
        self.bombs--;
        self maps\_zombietron_score::update_hud();
        player_org = self.origin;
        origin = player_org + (20, 0, 800);
        self setclientflag(level._ZT_PLAYER_CF_START_SMART_BOMB);
        ClearAllCorpses();
        wait .3;
        physicsExplosionSphere(player_org, 800, 128, 3);
        playRumbleOnPosition("artillery_rumble", self.origin);
        wait_network_frame();
        zombies = GetAISpeciesArray("axis", "all");
        zombies = get_array_of_closest(player_org, zombies);
        num_per_loop = zombies.size / 4;
        num = 0;
        for(i = 0; i < zombies.size; i++) {
          guy = zombies[i];
          if(isDefined(guy)) {
            if(isDefined(guy.boss)) {
              continue;
            }
            guy setclientflag(level._ZT_ACTOR_CF_LAUNCH_AND_BURN);
            guy DoDamage(guy.health + 1, player_org, self, undefined, "explosive");
            guy StartRagdoll(1);
            guy.launched = true;
          }
          num++;
          if(num >= num_per_loop) {
            wait_network_frame();
            num = 0;
          }
        }
        wait .1;
        wait_network_frame();
        wait .3;
        wait_network_frame();
        self clearclientflag(level._ZT_PLAYER_CF_START_SMART_BOMB);
        if(!isDefined(self.tank) && !isDefined(self.heli)) {
          self DisableInvulnerability();
        }
      }
    }
    wait 0.05;
  }
}
turret_init() {
  level.mini_turret_orgs = [];
  level.mini_turrets = getEntArray("mini_turret", "script_noteworthy");
  for(i = 0; i < level.mini_turrets.size; i++) {
    level.mini_turrets[i].original_location = level.mini_turrets[i].origin;
    level.mini_turrets[i] SetDefaultDropPitch(-35);
    level.mini_turrets[i] SetConvergenceTime(0.3);
    level.mini_turrets[i] SetTurretTeam("allies");
    level.mini_turrets[i] MakeTurretUnusable();
    level.mini_turret_orgs[i] = spawn("script_model", level.mini_turrets[i].origin);
    level.mini_turret_orgs[i] setModel("tag_origin");
    level.mini_turrets[i] LinkTo(level.mini_turret_orgs[i]);
    level.mini_turrets[i].org = level.mini_turret_orgs[i];
    level.mini_turrets[i].deployed = false;
    level.mini_turrets[i].script_delay_min = 0.25;
    level.mini_turrets[i].script_delay_max = 0.5;
    level.mini_turrets[i].script_burst_min = 0.5;
    level.mini_turrets[i].script_burst_max = 1.5;
  }
}
can_spawn_turret() {
  if(level.round_number < level.zombie_vars["mini_turret_min_round"]) {
    return false;
  }
  if(level.magical_exit_taken) {
    return false;
  }
  for(i = 0; i < level.mini_turrets.size; i++) {
    if(!level.mini_turrets[i].deployed) {
      return true;
    }
  }
  return false;
}
turret_timeout() {
  timeLeft = GetTime() + (level.zombie_vars["mini_turret_time"] * 1000);
  while(GetTime() < timeLeft) {
    if(!flag("round_is_active")) {
      zombies = GetAISpeciesArray("axis", "all");
      if(zombies.size == 0) {
        break;
      }
    }
    wait 1;
  }
  wait 1;
  self notify("turret_time_to_go");
}
turret_pickup_update(player) {
  mini_turret = undefined;
  for(i = 0; i < level.mini_turrets.size; i++) {
    if(!level.mini_turrets[i].deployed) {
      mini_turret = level.mini_turrets[i];
      break;
    }
  }
  if(!isDefined(mini_turret)) {
    return;
  }
  mini_turret SetMode("auto_nonai");
  mini_turret.deployed = true;
  dropTarget = player.origin + (0, 0, 800);
  mini_turret.org.origin = dropTarget;
  mini_turret playSound("evt_turret_incoming");
  target = player.origin;
  if(isDefined(player.heli) || isDefined(player.tank)) {
    hitp = PlayerPhysicsTrace(player.origin + (0, 0, 72), player.origin + (0, 0, -500));
    target = (player.origin[0], player.origin[1], hitp[2]);
  }
  wait 0.1;
  mini_turret.org moveTo(target, 0.5, 0, 0);
  wait 0.65;
  playFXOnTag(level._effect["betty_explode"], mini_turret, "tag_origin");
  mini_turret playSound("evt_turret_land");
  physicsExplosionSphere(mini_turret.org.origin, 512, 128, 2);
  player PlayRumbleOnEntity("artillery_rumble");
  if(GetPlayers().size > 1) {
    mini_turret.fx = SpawnFx(level._effect[player.light_playFX], mini_turret.origin, (1, 0, 0), (0, 0, 1));
    if(isDefined(mini_turret.fx)) {
      triggerFx(mini_turret.fx);
    }
  }
  mini_turret SetTurretOwner(player);
  mini_turret thread maps\_mgturret::burst_fire_unmanned();
  mini_turret thread turret_timeout();
  mini_turret waittill("turret_time_to_go");
  if(isDefined(mini_turret.fx)) {
    mini_turret.fx Delete();
    mini_turret.fx = undefined;
  }
  mini_turret notify("turret_deactivated");
  mini_turret SetMode("auto_ai");
  mini_turret notify("stop_burst_fire_unmanned");
  mini_turret playSound("evt_turret_takeoff");
  playFXOnTag(level._effect["mini_turret_takeoff"], mini_turret, "tag_origin");
  mini_turret.org moveTo(dropTarget, 1, 0, 0);
  wait 1;
  mini_turret.org moveTo(mini_turret.original_location, 1, 0, 0);
  mini_turret.deployed = false;
}
#using_animtree("zombie_cymbal_monkey");
monkey_update(player, origin) {
  hitp = PlayerPhysicsTrace(origin + (0, 0, 72), origin + (0, 0, -500));
  origin = (origin[0], origin[1], hitp[2]);
  mark = origin + (0, 0, 12);
  monkey = spawn("script_model", origin);
  monkey setModel(level.monkey_model);
  monkey UseAnimTree(#animtree);
  monkey SetAnim(%o_monkey_bomb);
  monkey.angles = (0, RandomInt(360), 0);
  playFXOnTag(level._effect["monkey_glow"], monkey, "origin_animate_jnt");
  level.active_monkeys[level.active_monkeys.size] = monkey;
  fx = undefined;
  if(GetPlayers().size > 1) {
    fx = SpawnFx(level._effect[player.light_playFX], monkey.origin + (0, 0, -12), (1, 0, 0), (0, 0, 1));
  }
  if(isDefined(fx)) {
    triggerFx(fx);
  }
  wait level.zombie_vars["monkey_fuse_time"];
  if(isDefined(fx)) {
    fx Delete();
  }
  level.active_monkeys = array_remove(level.active_monkeys, monkey);
  monkey playSound("zmb_monkey_explo");
  playFX(level._effect["monkey_explode"], mark, (1, 0, 0));
  player RadiusDamage(monkey.origin, level.zombie_vars["monkey_attract_dist"], 15000, 15000, player, "MOD_EXPLOSIVE");
  PhysicsExplosionSphere(monkey.origin, level.zombie_vars["monkey_attract_dist"], level.zombie_vars["monkey_attract_dist"], 1);
  earthquake(0.3, 1.0, monkey.origin, 100);
  PlayRumbleOnPosition("artillery_rumble", origin);
  monkey ClearAnim(%o_monkey_bomb, 0.2);
  wait 0.2;
  monkey Delete();
}
#using_animtree("critter");
chicken_idle() {
  self UseAnimTree(#animtree);
  curAnim = % a_chicken_react_up_down;
  lastAnim = % a_chicken_idle_peck;
  playFXOnTag(level._effect["powerup_on_red"], self, "tag_origin");
  while(isDefined(self)) {
    if(curAnim == lastAnim) {
      self ClearAnim(lastAnim, 0.2);
    }
    self SetAnim(curAnim);
    wait(RandomIntRange(2, 4));
    lastAnim = curAnim;
    switch (RandomInt(4)) {
      case 0:
        curAnim = % a_chicken_idle_peck;
        break;
      case 1:
        curAnim = % a_chicken_react_a;
        break;
      case 2:
        curAnim = % a_chicken_idle_a;
        break;
      case 3:
        curAnim = % a_chicken_react_to_front;
        break;
    }
  }
}
chicken_death_idle() {
  self endon("death");
  self UseAnimTree(#animtree);
  time = getAnimLength(%a_chicken_react_up_down);
  while(isDefined(self)) {
    self SetAnim(%a_chicken_react_up_down);
    wait time;
    self ClearAnim(%a_chicken_react_up_down, 0);
  }
}
chicken_active_idle() {
  self endon("death");
  self endon("spinning_out");
  self UseAnimTree(#animtree);
  time = getAnimLength(%a_chicken_react_to_front_notrans);
  while(isDefined(self)) {
    self SetAnim(%a_chicken_react_to_front_notrans);
    wait time;
    self ClearAnim(%a_chicken_react_to_front_notrans, 0);
  }
}
fated_active_idle() {
  self UseAnimTree(#animtree);
  self SetAnim(%fxanim_zombies_crow_fly_anim);
}
delete_sound_ent(ent, wait_string) {
  self waittill_any(wait_string, "disconnect");
  if(isDefined(ent)) {
    ent Delete();
  }
}
double_shot_wait_for_pickup_audio() {
  self endon("picked_up");
  self endon("death");
  while(isDefined(self)) {
    self playSound("zmb_dblshot_squawk", "sounddone");
    self waittill("sounddone");
    wait(RandomFloatRange(2, 5));
  }
}
double_shot_audio_loop(orb) {
  orb endon("spinning_out");
  orb endon("death");
  while(isDefined(orb)) {
    rand = RandomIntRange(0, 100);
    if(rand > 30) {
      orb playSound("zmb_dblshot_wingflap");
    }
    if(rand > 70) {
      orb playSound("zmb_dblshot_squawk");
    }
    wait(RandomFloatRange(1, 3));
  }
}
double_shot_audio_death(orb) {
  self endon("disconnect");
  orb endon("death");
  orb waittill("spinning_out");
  while(isDefined(orb)) {
    orb playSound("zmb_dblshot_death");
    orb playSound("zmb_dblshot_wingflap");
    wait(RandomFloatRange(.5, 1));
  }
}
spawn_treasure(numGlobs) {
  level endon("stop_spawning_pickups");
  while(numGlobs) {
    thread maps\_zombietron_pickups::spawn_prize_glob();
    wait(RandomFloatRange(0.1, 0.8));
    numGlobs--;
  }
}
spawn_bonus_room() {
  weaps = RandomIntRange(level.zombie_vars["zombie_treasure_weapon_drops_min"], level.zombie_vars["zombie_treasure_weapon_drops_max"]);
  while(weaps) {
    maps\_zombietron_pickups::spawn_random_weapon_pickup();
    weaps--;
  }
  maps\_zombietron_pickups::spawn_random_pickup();
  level thread spawn_treasure(level.zombie_vars["zombie_treasure_boss"]);
}
spawn_armory() {
  numplayers = GetPlayers().size;
  for(i = 0; i < 4; i++) {
    spawn_random_weapon_pickup();
    wait 0.2;
    spawn_specific_pickup("bomb");
    wait 0.2;
    spawn_specific_pickup("booster");
    wait 0.2;
  }
  if(numplayers > 1) {
    numChickens = 1;
  } else {
    numChickens = 4;
  }
  while(numChickens) {
    numChickens--;
    spawn_specific_pickup("double_shot");
    wait 0.2;
  }
  while(numplayers) {
    spawn_random_pickup();
    wait 0.2;
    numplayers--;
  }
}