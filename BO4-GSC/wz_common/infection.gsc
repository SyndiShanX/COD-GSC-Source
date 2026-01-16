/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\infection.gsc
***********************************************/

#include script_cb32d07c95e5628;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\infection;
#include scripts\core_common\lui_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\globallogic_defaults;
#include scripts\mp_common\item_drop;
#include scripts\mp_common\item_inventory;
#include scripts\mp_common\item_world;
#include scripts\wz_common\gametypes\warzone;
#include scripts\wz_common\wz_ai_utils;
#include scripts\wz_common\wz_ai_zonemgr;
#include scripts\wz_common\wz_loadouts;

#namespace infection;

autoexec __init__system__() {
  system::register(#"wz_infection", &__init__, undefined, #"infection");
}

private __init__() {
  if(!function_74650d7()) {
    return;
  }

  globallogic_defaults::function_daa7e9d5();
  level.var_6b2b1231 = getweapon(#"hash_6b525d940c1c1e39");
  clientfield::register("toplayer", "infected", 21000, 1, "int");
  callback::on_player_killed_with_params(&function_2cdab964);
  callback::on_player_killed_with_params(&function_70f6e873);
  callback::on_spawned(&on_player_spawned);
  level thread function_d9ff5189();
  level thread function_16e24b6c();

  level thread _setup_devgui();

  level thread function_cdd9b388();

}

private function_e717b0d(player) {
  if(!isDefined(player) || !isalive(player) || !isDefined(player.inventory)) {
    return;
  }

  hatchet = wz_loadouts::_get_item(#"tomahawk_t8_wz_item_pandemic");
  var_fa3df96 = player item_inventory::function_e66dcff5(hatchet);
  player item_world::function_de2018e3(hatchet, player, var_fa3df96);
}

function_d9ff5189() {
  level.var_6990c489 = [];
  zones = array(#"construction_zombie_player_spawn", #"estates_zombie_player_spawn", #"hydro_zombie_player_spawn", #"train_zombie_player_spawn", #"turbine_zombie_player_spawn", #"rivertown_zombie_player_spawn", #"fracking_zombie_player_spawn", #"factory_zombie_player_spawn", #"cargo_zombie_player_spawn", #"array_zombie_player_spawn", #"asylum_zombie_player_spawn", #"nuketown_zombie_player_spawn", #"ghosttown_zombie_player_spawn", #"lighthouse_zombie_player_spawn", #"farm_zombie_player_spawn", #"firing_zombie_player_spawn", #"boxing_zombie_player_spawn", #"diner_zombie_player_spawn", #"clearing_zombie_player_spawn", #"gazebo_zombie_player_spawn");

  foreach(zone in zones) {
    zonespawns = struct::get_array(zone, "targetname");

    if(zonespawns.size > 0) {
      var_f7b61e5e = spawnStruct();
      min = zonespawns[0].origin;
      max = min;

      for(index = 1; index < zonespawns.size; index++) {
        spawn = zonespawns[index].origin;
        max = (max(max[0], spawn[0]), max(max[1], spawn[1]), max(max[2], spawn[2]));
        min = (min(min[0], spawn[0]), min(min[1], spawn[1]), min(min[2], spawn[2]));
      }

      var_f7b61e5e.origin = (min + max) / 2;
      var_f7b61e5e.max = max;
      var_f7b61e5e.min = min;
      var_f7b61e5e.spawn_points = zonespawns;
      level.var_6990c489[level.var_6990c489.size] = var_f7b61e5e;
    }

    waitframe(1);
  }
}

function_f488681f() {
  if(isDefined(self.var_139ab759) && self.var_139ab759 + 0 >= gettime()) {
    return;
  }

  spawn_point = function_89116a1e();

  if(isDefined(spawn_point)) {
    spawn_point_origin = spawn_point.origin;
    starttrace = physicstraceex(spawn_point_origin + (0, 0, 128), spawn_point_origin, (-0.5, -0.5, -0.5), (0.5, 0.5, 0.5), self, 1);
    spawn_point_origin = starttrace[#"position"];
    self.resurrect_origin = spawn_point_origin;
    self.resurrect_angles = spawn_point.angles;
    self.var_139ab759 = gettime();
  }
}

function_8bdd6715() {
  self item_world::function_df82b00c();
  item_drop::function_767443cc(self);
  self thread function_b8c66122();
  self thread function_ff850b97();
  self warzone::function_2f66bc37();
  self clientfield::set_to_player("infected", 1);
  self clientfield::set_to_player("realtime_multiplay", 1);
  self function_3aaa02be(0);
  self.var_a62dbeca = 1;
}

on_player_spawned() {
  if(isDefined(self)) {
    if(self clientfield::get_to_player("infected") == 1) {
      self freezecontrolsallowlook(1);
      self ghost();
      self thread function_cc4a1b88();
      wait 0.5;

      if(!isDefined(self)) {
        return;
      }

      self show();
      self playboast("boast_zombie_climbout");
      self freezecontrolsallowlook(0);
    }
  }
}

function_cc4a1b88() {
  self luinotifyevent(#"hash_21b9cfc69e007bc4", 0);
}

function_89116a1e() {
  if(!isplayer(self)) {
    assert(0);
    return;
  }

  if(!isDefined(level.var_6990c489) || level.var_6990c489.size <= 0) {
    return;
  }

  zones = level.var_6990c489;
  validzones = [];

  if(isDefined(level.deathcircle) && isDefined(level.deathcircle.nextcircle)) {
    var_5b345622 = min(level.deathcircle.radius - level.deathcircle.nextcircle.radius, 10000);
    validzones = [];
    var_89e77f16 = (level.deathcircle.radius - var_5b345622) * (level.deathcircle.radius - var_5b345622);
    nextorigin = level.deathcircle.origin;

    for(index = 0; index < zones.size; index++) {
      zone = zones[index];

      if(distance2dsquared(nextorigin, zone.origin) <= var_89e77f16) {
        validzones[validzones.size] = zone;
      }
    }
  }

  if(validzones.size > 0) {
    zones = validzones;
  } else if(isDefined(level.deathcircle)) {
    closestzone = zones[0];
    var_42c5fb9a = distance2dsquared(level.deathcircle.origin, closestzone.origin);

    for(index = 1; index < zones.size; index++) {
      zone = zones[index];
      var_d5e7808c = distance2dsquared(level.deathcircle.origin, zone.origin);

      if(var_d5e7808c < var_42c5fb9a) {
        var_42c5fb9a = var_d5e7808c;
        closestzone = zone;
      }
    }

    zones = array(closestzone);
  }

  closestzone = zones[0];
  closestdistsq = distance2dsquared(self.origin, closestzone.origin);

  for(index = 1; index < zones.size; index++) {
    zone = zones[index];
    var_98ea9d5c = distance2dsquared(self.origin, zone.origin);

    if(var_98ea9d5c < closestdistsq) {
      closestzone = zone;
      closestdistsq = var_98ea9d5c;
    }
  }

  return closestzone.spawn_points[randomint(closestzone.spawn_points.size)];
}

function_b8c66122() {
  assert(isplayer(self));

  if(!isplayer(self) || !isalive(self)) {
    return;
  }

  if(item_world::function_1b11e73c()) {
    while(isDefined(self) && !isDefined(self.inventory)) {
      waitframe(1);
    }

    if(!isDefined(self)) {
      return;
    }

    for(i = 0; i < 2; i++) {
      function_e717b0d(self);
    }
  }

  if(isDefined(self)) {
    self takeweapon(level.weaponbasemeleeheld);
    self giveweapon(level.var_6b2b1231);
  }
}

private function_4fcf8d3f(player) {
  if(!isplayer(player) || !player is_infected()) {
    return;
  }

  if(player.health < player.maxhealth) {
    player.health = player.maxhealth;
  }

  for(i = 0; i < 2; i++) {
    function_e717b0d(player);
  }
}

private function_2cdab964(params) {
  attacker = params.eattacker;
  weapon = params.weapon;

  if(isDefined(params.laststandparams)) {
    attacker = params.laststandparams.attacker;
    weapon = params.laststandparams.sweapon;
  }

  function_4fcf8d3f(attacker);

  if(isDefined(self) && isDefined(self.var_a1d415ee) && isDefined(self.var_a1d415ee.attacker)) {
    var_a6c0f254 = self.var_a1d415ee.attacker;

    if(var_a6c0f254 !== attacker) {
      function_4fcf8d3f(var_a6c0f254);
    }
  }
}

private function_70f6e873(params) {
  if(!isDefined(self) || !self is_infected()) {
    return;
  }

  attacker = params.eattacker;
  origin = self.origin;
  items = self namespace_65181344::function_fd87c780(#"zombie_infected_itemlist", 1);

  foreach(item in items) {
    if(!isDefined(item)) {
      continue;
    }

    item thread wz_ai_utils::function_7a1e21a9(attacker, origin);
  }
}

private event_handler[grenade_fire] function_4776caf4(eventstruct) {
  eventstruct.projectile endon(#"death");

  if(sessionmodeiswarzonegame() && isplayer(self) && isalive(self)) {
    weaponname = eventstruct.weapon.name;

    if(weaponname != #"hash_351254cd4fc93d6e") {
      return;
    }

    eventstruct.projectile waittill(#"stationary");

    if(!isDefined(eventstruct.projectile)) {
      return;
    }

    eventstruct.projectile delete();
  }
}

private function_fcd9114b() {
  return self ismeleeing() && isDefined(self.var_8a022726) && isDefined(self.var_8a022726.var_a9309589) && self.var_8a022726 istriggerenabled() && self istouching(self.var_8a022726);
}

function_ff850b97() {
  self endon(#"death");

  while(true) {
    if(self function_fcd9114b()) {
      self.var_8a022726.var_a9309589 dodamage(1, self.origin, self, self, undefined, "MOD_EXPLOSIVE");

      while(self function_fcd9114b()) {
        waitframe(1);
      }

      continue;
    }

    waitframe(1);
  }
}

function_16e24b6c() {
  var_d05b667e = [#"p8_wz_door_01_frame_white": 1, #"p8_wz_door_01": 1, #"p8_wz_door_01_array": 1, #"p8_wz_door_01_assylum": 1, #"p8_wz_door_01_assylum_double": 1, #"hash_88b4d6deb60840d": 1, #"hash_6130912b218af142": 1, #"p8_wz_door_01_diner": 1, #"p8_wz_door_01_estate": 1, #"hash_70294bd7c3b0e2ff": 1, #"p8_wz_door_01_factory": 1, #"p8_wz_door_01_farm": 1, #"hash_7c40a6297a29d7bd": 1, #"p8_wz_door_01_frame": 1, #"p8_wz_door_01_frame_wooden": 1, #"p8_wz_door_01_frame_wooden_painted": 1, #"p8_wz_door_01_latch": 1, #"hash_3f00c218be809b12": 1, #"p8_wz_door_01_train": 1, #"p8_wz_door_01_turbine": 1, #"p8_wz_door_01_wood": 1, #"p8_wz_door_01_wood_plain": 1, #"hash_1debd9bb0784f5f9": 1, #"p8_wz_door_barricade_01": 1, #"p8_wz_door_barricade_01_lrg": 1, #"p8_wz_door_barricade_01_med": 1, #"p8_wz_door_barricade_01_sml": 1, #"p8_wz_door_01_double_frame_white": 1, #"p8_wz_door_01_double": 1, #"hash_508d4a4298138acd": 1, #"hash_5ab15b04f91b09bf": 1, #"p8_wz_door_01_double_frame": 1, #"p8_wz_door_01_double_frame_wooden": 1, #"hash_6c99ba1916eb0091": 1, #"p8_wz_door_01_frame_wooden_double": 1];
  dynents = getdynentarray();

  foreach(dynent in dynents) {
    if(!isDefined(dynent.var_15d44120) || !isDefined(var_d05b667e[dynent.var_15d44120])) {
      continue;
    }

    dynent.ondamaged = &function_cabd9ff3;
  }
}

private function_cabd9ff3(eventstruct) {
  if(!isDefined(eventstruct) || !isDefined(eventstruct.attacker) || !eventstruct.attacker is_infected()) {
    return;
  }

  dynent = eventstruct.ent;

  if(!isDefined(dynent.var_5059b11f)) {
    dynent.var_5059b11f = 0;
  }

  dynent.var_5059b11f++;

  if(dynent.var_5059b11f >= 2) {
    dynent.health -= dynent.health;
  }
}

private _setup_devgui() {
  while(!canadddebugcommand()) {
    waitframe(1);
  }

  mapname = util::get_map_name();
  adddebugcommand("<dev string:x38>");
  adddebugcommand("<dev string:x6b>" + mapname + "<dev string:x7c>");
}

private function_cdd9b388() {
  while(true) {
    if(getdvarint(#"wz_respawn_points", 0)) {
      wait 1;
    } else {
      waitframe(1);
    }

    if(getdvarint(#"wz_respawn_points", 0)) {
      players = getplayers();

      if(players.size <= 0) {
        continue;
      }

      origin = players[0].origin;
      points = [];

      if(isDefined(level.var_6990c489)) {
        foreach(zone in level.var_6990c489) {
          if(!isDefined(zone.spawn_points)) {
            continue;
          }

          points = arraycombine(points, zone.spawn_points, 1, 0);
        }
      }

      var_ea8ae4bc = 20000;
      var_654d4508 = var_ea8ae4bc * var_ea8ae4bc;
      var_84dd2a8b = 2048;

      foreach(point in points) {
        disttopointsq = distancesquared(origin, point.origin);

        if(disttopointsq > var_654d4508) {
          continue;
        }

        radius = 64;

        if(disttopointsq < var_84dd2a8b * var_84dd2a8b) {
          radius = max(distance(origin, point.origin) / var_84dd2a8b * radius, 1);
        }

        color = (1, 0, 1);
        sphere(point.origin, radius, color, 1, 0, 10, 20);
      }
    }
  }
}

