/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_discovery.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_discovery_fx::main();
  precachemodel("collision_vehicle_64x64x64");
  precachemodel("collision_wall_128x128x10");
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_discovery2_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_discovery2");
  }
  maps\mp\_load::main();
  maps\mp\gametypes\_teamset_winterspecops::level_init();
  spawncollision("collision_vehicle_64x64x64", "collider", (-1105.96, 2118.02, 148), (0, 335.7, 0));
  spawncollision("collision_wall_128x128x10", "collider", (-1439, 1383, 150), (0, 0, 0));
  spawncollision("collision_wall_128x128x10", "collider", (-1384.63, 1392.93, 150), (0, 315, 0));
  spawncollision("collision_geo_sphere_64", "collider", (729.5, 1099, -5.5), (0, 348.4, 0));
  icechunk1 = spawn("script_model", (-958.025, -1587.14, 179));
  if(isDefined(icechunk1)) {
    icechunk1.angles = (0, 129.067, 0);
    icechunk1 setModel("p_rus_snow_chunk_04");
  }
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  level thread dynamic_path_init();
  thread trigger_killer((-1831, -192.5, -228), 64, 128);
}
dynamic_path_init() {
  level.destroyed_paths = [];
  dynamic_path_triggers = getEntArray("dynamic_path", "targetname");
  array_thread(dynamic_path_triggers, ::dynamic_path_think);
  for(;;) {
    level waittill("connected", player);
    player thread dynamic_path_delete();
  }
}
dynamic_path_delete() {
  self endon("disconnect");
  self wait_endon(5, "spawned");
  for(i = 0; i < level.destroyed_paths.size; i++) {
    self ClientNotify(level.destroyed_paths[i]);
    wait(0.1);
  }
}
dynamic_path_think() {
  client_notify = undefined;
  player_collisions = [];
  ai_collisions = [];
  remove = true;
  if(isDefined(self.script_noteworthy)) {
    client_notify = self.script_noteworthy + "_anim";
    player_collisions = getEntArray(self.script_noteworthy + "_collision", "targetname");
    ai_collisions = getEntArray(self.script_noteworthy + "_ai_collision", "targetname");
  }
  for(i = 0; i < ai_collisions.size; i++) {
    ai_collisions[i] NotSolid();
    ai_collisions[i] ConnectPaths();
  }
  self.fake_health_max = 500;
  self.fake_health = self.fake_health_max;
  self thread sound_small_think();
  self thread sound_heavy_think();
  for(;;) {
    self waittill("damage", amount, attacker, direction, point, type);
    if(!isDefined(type)) {
      continue;
    }
    if(type == "MOD_MELEE" || type == "MOD_UNKNOWN" || type == "MOD_IMPACT") {
      continue;
    }
    self.fake_health -= amount;
    if(self.fake_health <= self.fake_health_max / 2) {
      self notify("damage_small");
    }
    if(self.fake_health <= self.fake_health_max / 4) {
      self notify("damage_heavy");
    }
    if(self.fake_health <= 0) {
      break;
    }
  }
  if(isDefined(client_notify)) {
    level ClientNotify(client_notify);
    level.destroyed_paths[level.destroyed_paths.size] = client_notify + "_delete";
  }
  for(i = 0; i < ai_collisions.size; i++) {
    ai_collisions[i] Solid();
    ai_collisions[i] DisconnectPaths();
  }
  for(i = 0; i < player_collisions.size; i++) {
    if(remove) {
      player_collisions[i] delete();
    } else {
      player_collisions[i].og_origin = player_collisions[i].origin;
      player_collisions[i].origin = player_collisions[i].origin + (0, 0, -10000);
    }
  }
  PlayRumbleOnPosition("grenade_rumble", self.origin);
  Earthquake(0.5, 0.5, self.origin, 800);
  playsoundatposition("dst_glacier_fall", self.origin);
  level thread dropAllToGround(self.origin, 128, 128);
  self dynamic_path_destroy_equipment();
  if(isDefined(level.sdBomb) && level.sdBomb.visuals[0] IsTouching(self)) {
    level.sdBomb maps\mp\gametypes\_gameobjects::returnHome();
  }
  if(isDefined(level.sabBomb) && level.sabBomb.visuals[0] IsTouching(self)) {
    level.sabBomb maps\mp\gametypes\_gameobjects::returnHome();
  }
  if(isDefined(level.flags)) {
    for(i = 0; i < level.flags.size; i++) {
      if(isDefined(level.flags[i].visuals) && level.flags[i].visuals[0] IsTouching(self)) {
        level.flags[i] maps\mp\gametypes\_gameobjects::returnHome();
      }
    }
  }
  if(remove) {
    self delete();
  }
}
sound_small_think() {
  self endon("death");
  self waittill("damage_small");
  playsoundatposition("evt_glacier_crack_small", self.origin);
}
sound_heavy_think() {
  self endon("death");
  self waittill("damage_heavy");
  playsoundatposition("evt_glacier_crack_heavy", self.origin);
}
dynamic_path_destroy_equipment() {
  grenades = getEntArray("grenade", "classname");
  for(i = 0; i < grenades.size; i++) {
    item = grenades[i];
    if(!isDefined(item.name)) {
      continue;
    }
    if(!isDefined(item.owner)) {
      continue;
    }
    if(!IsWeaponEquipment(item.name)) {
      continue;
    }
    if(!item IsTouching(self)) {
      continue;
    }
    watcher = item.owner getWatcherForWeapon(item.name);
    if(!isDefined(watcher)) {
      continue;
    }
    watcher thread maps\mp\gametypes\_weaponobjects::waitAndDetonate(item, 0.0, undefined);
  }
}
getWatcherForWeapon(weapname) {
  if(!isDefined(self)) {
    return undefined;
  }
  if(!IsPlayer(self)) {
    return undefined;
  }
  for(i = 0; i < self.weaponObjectWatcherArray.size; i++) {
    if(self.weaponObjectWatcherArray[i].weapon != weapname) {
      continue;
    }
    return (self.weaponObjectWatcherArray[i]);
  }
  return undefined;
}
trigger_killer(position, width, height) {
  kill_trig = spawn("trigger_radius", position, 0, width, height);
  while(1) {
    kill_trig waittill("trigger", player);
    if(isplayer(player)) {
      player suicide();
    }
  }
}