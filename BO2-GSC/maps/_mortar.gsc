/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_mortar.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_shellshock;

init_mortars() {
  level._explosion_max_range = [];
  level._explosion_min_range = [];
  level._explosion_blast_radius = [];
  level._explosion_max_damage = [];
  level._explosion_min_damage = [];
  level._explosion_quake_power = [];
  level._explosion_quake_time = [];
  level._explosion_quake_radius = [];
  level._explosion_min_delay = [];
  level._explosion_max_delay = [];
  level._explosion_barrage_min_delay = [];
  level._explosion_barrage_max_delay = [];
  level._explosion_view_chance = [];
  level._explosion_dust_range = [];
  level._explosion_dust_name = [];
}

set_mortar_range(mortar_name, min_range, max_range, set_default) {
  if(!isDefined(level._explosion_min_range))
    init_mortars();

  if(isDefined(set_default) && set_default) {
    if(!isDefined(level._explosion_min_range[mortar_name]))
      level._explosion_min_range[mortar_name] = min_range;

    if(!isDefined(level._explosion_max_range[mortar_name]))
      level._explosion_max_range[mortar_name] = max_range;
  } else {
    level._explosion_min_range[mortar_name] = min_range;
    level._explosion_max_range[mortar_name] = max_range;
  }
}

set_mortar_damage(mortar_name, blast_radius, min_damage, max_damage, set_default) {
  if(!isDefined(level._explosion_blast_radius))
    init_mortars();

  if(isDefined(set_default) && set_default) {
    if(!isDefined(level._explosion_blast_radius[mortar_name]))
      level._explosion_blast_radius[mortar_name] = blast_radius;

    if(!isDefined(level._explosion_min_damage[mortar_name]))
      level._explosion_min_damage[mortar_name] = min_damage;

    if(!isDefined(level._explosion_max_damage[mortar_name]))
      level._explosion_max_damage[mortar_name] = max_damage;
  } else {
    level._explosion_blast_radius[mortar_name] = blast_radius;
    level._explosion_min_damage[mortar_name] = min_damage;
    level._explosion_max_damage[mortar_name] = max_damage;
  }
}

set_mortar_quake(mortar_name, quake_power, quake_time, quake_radius, set_default) {
  if(!isDefined(level._explosion_quake_power))
    init_mortars();

  if(isDefined(set_default) && set_default) {
    if(!isDefined(level._explosion_quake_power[mortar_name]))
      level._explosion_quake_power[mortar_name] = quake_power;

    if(!isDefined(level._explosion_quake_power[mortar_name]))
      level._explosion_quake_time[mortar_name] = quake_time;

    if(!isDefined(level._explosion_quake_radius[mortar_name]))
      level._explosion_quake_radius[mortar_name] = quake_radius;
  } else {
    level._explosion_quake_power[mortar_name] = quake_power;
    level._explosion_quake_time[mortar_name] = quake_time;
    level._explosion_quake_radius[mortar_name] = quake_radius;
  }
}

set_mortar_delays(mortar_name, min_delay, max_delay, barrage_min_delay, barrage_max_delay, set_default) {
  if(!isDefined(level._explosion_min_delay))
    init_mortars();

  if(isDefined(set_default) && set_default) {
    if(!isDefined(level._explosion_min_delay[mortar_name]) && isDefined(min_delay))
      level._explosion_min_delay[mortar_name] = min_delay;

    if(!isDefined(level._explosion_max_delay[mortar_name]) && isDefined(min_delay))
      level._explosion_max_delay[mortar_name] = max_delay;

    if(!isDefined(level._explosion_barrage_min_delay[mortar_name]) && isDefined(barrage_min_delay))
      level._explosion_barrage_min_delay[mortar_name] = barrage_min_delay;

    if(!isDefined(level._explosion_barrage_max_delay[mortar_name]) && isDefined(barrage_max_delay))
      level._explosion_barrage_max_delay[mortar_name] = barrage_max_delay;
  } else {
    if(isDefined(min_delay))
      level._explosion_min_delay[mortar_name] = min_delay;

    if(isDefined(min_delay))
      level._explosion_max_delay[mortar_name] = max_delay;

    if(isDefined(barrage_min_delay))
      level._explosion_barrage_min_delay[mortar_name] = barrage_min_delay;

    if(isDefined(barrage_max_delay))
      level._explosion_barrage_max_delay[mortar_name] = barrage_max_delay;
  }
}

set_mortar_chance(mortar_name, chance, set_default) {
  if(!isDefined(level._explosion_view_chance))
    init_mortars();

  assert(chance <= 1, "_mortar::set_mortar_chance(), the chance parameter needs to be between 0 and 1");

  if(isDefined(set_default) && set_default) {
    if(!isDefined(level._explosion_view_chance[mortar_name]))
      level._explosion_view_chance[mortar_name] = chance;
  } else
    level._explosion_view_chance[mortar_name] = chance;
}

set_mortar_dust(mortar_name, dust_name, range) {
  if(!isDefined(level._explosion_dust_range))
    init_mortars();

  level._explosion_dust_name[mortar_name] = dust_name;

  if(!isDefined(range))
    range = 512;

  level._explosion_dust_range[mortar_name] = range;
}

mortar_loop(mortar_name, barrage_amount, no_terrain) {
  level endon("stop_all_mortar_loops");
  assert(isDefined(mortar_name) && mortar_name != "", "mortar_name not passed. pass in level script");
  assert(isDefined(level._effect) && isDefined(level._effect[mortar_name]), "level._effect[strMortars] not defined. define in level script");
  last_explosion = -1;
  set_mortar_range(mortar_name, 300, 2200, 1);
  set_mortar_delays(mortar_name, 5, 7, 5, 7, 1);
  set_mortar_chance(mortar_name, 0, 1);

  if(!isDefined(barrage_amount) || barrage_amount < 1)
    barrage_amount = 1;

  if(!isDefined(no_terrain))
    no_terrain = 0;

  if(isDefined(level._explosion_stopnotify) && isDefined(level._explosion_stopnotify[mortar_name]))
    level endon(level._explosion_stopnotify[mortar_name]);

  if(!isDefined(level._explosion_stop_barrage) || !isDefined(level._explosion_stop_barrage[mortar_name]))
    level._explosion_stop_barrage[mortar_name] = 0;

  explosion_points = [];
  explosion_points = getentarray(mortar_name, "targetname");
  explosion_points_structs = [];
  explosion_points_structs = getstructarray(mortar_name, "targetname");

  for(i = 0; i < explosion_points_structs.size; i++) {
    explosion_points_structs[i].is_struct = 1;
    explosion_points = add_to_array(explosion_points, explosion_points_structs[i]);
  }

  explosion_points_structs = [];
  dust_points = [];

  if(isDefined(level._explosion_dust_name[mortar_name])) {
    dust_name = level._explosion_dust_name[mortar_name];
    dust_points = getentarray(dust_name, "targetname");
    dust_points_structs = [];
    dust_points_structs = getstructarray(dust_name, "targetname");

    for(i = 0; i < dust_points_structs.size; i++) {
      dust_points_structs[i].is_struct = 1;
      dust_points = add_to_array(dust_points, dust_points_structs[i]);
    }

    dust_points_structs = [];
  }

  for(i = 0; i < explosion_points.size; i++) {
    if(isDefined(explosion_points[i].target) && !no_terrain)
      explosion_points[i] setup_mortar_terrain();
  }

  if(isDefined(level._explosion_start_notify) && isDefined(level._explosion_start_notify[mortar_name]))
    level waittill(level._explosion_start_notify[mortar_name]);

  while(true) {
    while(!level._explosion_stop_barrage[mortar_name]) {
      do_mortar = 0;

      for(j = 0; j < barrage_amount; j++) {
        max_rangesq = level._explosion_max_range[mortar_name] * level._explosion_max_range[mortar_name];
        min_rangesq = level._explosion_min_range[mortar_name] * level._explosion_min_range[mortar_name];
        random_num = randomint(explosion_points.size);

        for(i = 0; i < explosion_points.size; i++) {
          num = (i + random_num) % explosion_points.size;
          do_mortar = 0;
          players = get_players();

          for(q = 0; q < players.size; q++) {
            dist = distancesquared(players[q] getorigin(), explosion_points[num].origin);

            if(num != last_explosion && dist < max_rangesq && dist > min_rangesq) {
              if(level._explosion_view_chance[mortar_name] > 0) {
                if(players[q] player_view_chance(level._explosion_view_chance[mortar_name], explosion_points[num].origin)) {
                  do_mortar = 1;
                  break;
                } else
                  do_mortar = 0;
              } else {
                do_mortar = 1;
                break;
              }
            } else
              do_mortar = 0;
          }

          if(do_mortar) {
            explosion_points[num] thread explosion_activate(mortar_name, undefined, undefined, undefined, undefined, undefined, undefined, dust_points);
            last_explosion = num;
            break;
          }
        }

        last_explosion = -1;

        if(do_mortar) {
          if(isDefined(level._explosion_delay) && isDefined(level._explosion_delay[mortar_name]))
            wait(level._explosion_delay[mortar_name]);
          else
            wait(randomfloatrange(level._explosion_min_delay[mortar_name], level._explosion_max_delay[mortar_name]));

          continue;
        }

        j--;
        wait 0.25;
      }

      if(barrage_amount > 1) {
        if(isDefined(level._explosion_barrage_delay) && isDefined(level._explosion_barrage_delay[mortar_name]))
          wait(level._explosion_barrage_delay[mortar_name]);
        else
          wait(randomfloatrange(level._explosion_barrage_min_delay[mortar_name], level._explosion_barrage_max_delay[mortar_name]));
      }
    }

    wait 0.05;
  }
}

player_view_chance(view_chance, explosion_point) {
  chance = randomfloat(1);

  if(chance <= view_chance) {
    if(within_fov(self geteye(), self getplayerangles(), explosion_point, cos(30)))
      return true;
  }

  return false;
}

explosion_activate(mortar_name, blast_radius, min_damage, max_damage, quake_power, quake_time, quake_radius, dust_points) {
  set_mortar_damage(mortar_name, 256, 25, 400, 1);
  set_mortar_quake(mortar_name, 0.15, 2, 850, 1);

  if(!isDefined(blast_radius))
    blast_radius = level._explosion_blast_radius[mortar_name];

  if(!isDefined(min_damage))
    min_damage = level._explosion_min_damage[mortar_name];

  if(!isDefined(max_damage))
    max_damage = level._explosion_max_damage[mortar_name];

  if(!isDefined(quake_power))
    quake_power = level._explosion_quake_power[mortar_name];

  if(!isDefined(quake_time))
    quake_time = level._explosion_quake_time[mortar_name];

  if(!isDefined(quake_radius))
    quake_radius = level._explosion_quake_radius[mortar_name];

  is_struct = isDefined(self.is_struct) && self.is_struct;
  temp_ent = undefined;

  if(is_struct)
    temp_ent = spawn("script_origin", self.origin);

  if(is_struct)
    temp_ent explosion_incoming(mortar_name);
  else
    self explosion_incoming(mortar_name);

  level notify("explosion", mortar_name);
  radiusdamage(self.origin, blast_radius, max_damage, min_damage);

  if(isDefined(self.has_terrain) && self.has_terrain == 1 && isDefined(self.terrain)) {
    for(i = 0; i < self.terrain.size; i++) {
      if(isDefined(self.terrain[i]))
        self.terrain[i] delete();
    }
  }

  if(isDefined(self.hidden_terrain))
    self.hidden_terrain show();

  self.has_terrain = 0;

  if(is_struct)
    temp_ent explosion_boom(mortar_name, quake_power, quake_time, quake_radius);
  else
    self explosion_boom(mortar_name, quake_power, quake_time, quake_radius);

  if(isDefined(dust_points) && dust_points.size > 0) {
    max_range = 384;

    if(isDefined(level._explosion_dust_range) && isDefined(level._explosion_dust_range[mortar_name]))
      max_range = level._explosion_dust_range[mortar_name];

    for(i = 0; i < dust_points.size; i++) {
      if(distancesquared(dust_points[i].origin, self.origin) < max_range * max_range) {
        if(isDefined(dust_points[i].script_fxid)) {
          playfx(level._effect[dust_points[i].script_fxid], dust_points[i].origin);
          continue;
        }

        playfx(level._effect[level._explosion_dust_name[mortar_name]], dust_points[i].origin);
      }
    }
  }

  if(is_struct)
    temp_ent thread delete_temp_ent();
}

delete_temp_ent() {
  wait 10;
  self delete();
}

explosion_boom(mortar_name, power, time, radius, is_struct) {
  if(!isDefined(power))
    power = 0.15;

  if(!isDefined(time))
    time = 2;

  if(!isDefined(radius))
    radius = 850;

  if(!isDefined(is_struct))
    explosion_sound(mortar_name);
  else {
    temp_ent = spawn("script_origin", self.origin);
    temp_ent explosion_sound(mortar_name);
    temp_ent thread delete_temp_ent();
  }

  explosion_origin = self.origin;
  playfx(level._effect[mortar_name], explosion_origin);
  earthquake(power, time, explosion_origin, radius);
  thread mortar_rumble_on_all_players("damage_light", "damage_heavy", explosion_origin, radius * 0.75, radius * 1.25);
  physradius = radius;

  if(physradius > 500)
    physradius = 500;

  if(!isDefined(level.no_explosion_physics) || isDefined(level.no_explosion_physics) && level.no_explosion_physics)
    physicsexplosionsphere(explosion_origin, physradius, physradius * 0.25, 0.75);

  players = get_players();
  player_count = 0;

  for(q = 0; q < players.size; q++) {
    if(distancesquared(players[q].origin, explosion_origin) > 90000)
      player_count++;
  }

  if(player_count == players.size) {
    return;
  }
  level.playermortar = 1;
  level notify("shell shock player", time * 4);
  max_damage = level._explosion_max_damage[mortar_name];
  min_damage = level._explosion_max_damage[mortar_name];
  maps\_shellshock::main(explosion_origin, time * 4, undefined, max_damage, 1, min_damage);
}

explosion_sound(mortar_name) {
  if(level._effecttype[mortar_name] == "mortar") {
    self playsound("exp_mortar");
    self playsound("exp_mortar_dirt_plume");
  }

  if(level._effecttype[mortar_name] == "mortar_water")
    self playsound("exp_mortar_water");
  else if(level._effecttype[mortar_name] == "artillery")
    self playsound("exp_mortar");
  else if(level._effecttype[mortar_name] == "bomb")
    self playsound("exp_mortar");
}

explosion_incoming(mortar_name) {
  if(level._effecttype[mortar_name] == "mortar")
    self playsound("prj_mortar_incoming", "sounddone");

  if(level._effecttype[mortar_name] == "mortar_water")
    self playsound("prj_mortar_incoming", "sounddone");
  else if(level._effecttype[mortar_name] == "artillery")
    self playsound("prj_mortar_incoming", "sounddone");
  else if(level._effecttype[mortar_name] == "bomb")
    self playsound("prj_mortar_incoming", "sounddone");

  self waittill("sounddone");
}

setup_mortar_terrain() {
  self.has_terrain = 0;

  if(isDefined(self.target)) {
    self.terrain = getentarray(self.target, "targetname");
    self.has_terrain = 1;
  } else {
    println("z:mortar entity has no target: ", self.origin);

  }

  if(!isDefined(self.terrain))
    println("z:mortar entity has target, but target doesnt exist: ", self.origin);

  if(isDefined(self.script_hidden)) {
    if(isDefined(self.script_hidden))
      self.hidden_terrain = getent(self.script_hidden, "targetname");
    else if(isDefined(self.terrain) && isDefined(self.terrain[0].target))
      self.hidden_terrain = getent(self.terrain[0].target, "targetname");

    if(isDefined(self.hidden_terrain))
      self.hidden_terrain hide();
  } else if(isDefined(self.has_terrain)) {
    if(isDefined(self.terrain) && isDefined(self.terrain[0].target))
      self.hidden_terrain = getent(self.terrain[0].target, "targetname");

    if(isDefined(self.hidden_terrain))
      self.hidden_terrain hide();
  }
}

activate_mortar(range, max_damage, min_damage, quake_power, quake_time, quake_radius, bisstruct, effect, bshellshock) {
  incoming_sound(undefined, bisstruct);
  level notify("mortar");
  self notify("mortar");

  if(!isDefined(range))
    range = 256;

  if(!isDefined(max_damage))
    max_damage = 400;

  if(!isDefined(min_damage))
    min_damage = 25;

  if(!isDefined(effect))
    effect = level.mortar;

  if(!isDefined(bshellshock))
    bshellshock = 1;

  radiusdamage(self.origin, range, max_damage, min_damage);

  if(isDefined(self.has_terrain) && self.has_terrain == 1 && isDefined(self.terrain)) {
    for(i = 0; i < self.terrain.size; i++) {
      if(isDefined(self.terrain[i]))
        self.terrain[i] delete();
    }
  }

  if(isDefined(self.hidden_terrain))
    self.hidden_terrain show();

  self.has_terrain = 0;
  mortar_boom(self.origin, quake_power, quake_time, quake_radius, effect, bisstruct, bshellshock);
}

mortar_boom(origin, power, time, radius, effect, bisstruct, bshellshock, custom_sound) {
  if(!isDefined(power))
    power = 0.15;

  if(!isDefined(time))
    time = 2;

  if(!isDefined(radius))
    radius = 850;

  if(!isDefined(bshellshock))
    bshellshock = 1;

  thread mortar_sound(bisstruct, custom_sound);

  if(isDefined(effect))
    playfx(effect, origin);
  else
    playfx(level.mortar, origin);

  earthquake(power, time, origin, radius);
  thread mortar_rumble_on_all_players("damage_light", "damage_heavy", origin, radius * 0.75, radius * 1.25);
  physradius = radius;

  if(!isDefined(level.no_mortar_physics) || isDefined(level.no_mortar_physics) && level.no_mortar_physics) {
    phys_origin = (origin[0], origin[1], origin[2] - 0.5 * physradius);
    physicsexplosionsphere(phys_origin, physradius, physradius * 0.25, 3.0);
  }

  if(isDefined(level.playermortar)) {
    return;
  }
  players = get_players();
  player_count = 0;

  for(q = 0; q < players.size; q++) {
    if(distancesquared(players[q].origin, origin) > 90000)
      player_count++;
  }

  if(player_count == players.size) {
    return;
  }
  if(level.script == "carchase" || level.script == "breakout") {
    return;
  }
  if(bshellshock) {
    level.playermortar = 1;
    level notify("shell shock player", time * 4);
    maps\_shellshock::main(origin, time * 4);
  }
}

mortar_sound(bisstruct, custom_sound) {
  if(isDefined(bisstruct) && bisstruct == 1) {
    temp_ent = spawn("script_origin", self.origin);
    sound = "exp_mortar";

    if(isDefined(custom_sound))
      sound = custom_sound;

    temp_ent playsound(sound);
    temp_ent thread delete_temp_ent();
  } else
    self playsound("exp_mortar");
}

incoming_sound(soundnum, bisstruct) {
  currenttime = gettime();

  if(!isDefined(level.lastmortarincomingtime))
    level.lastmortarincomingtime = currenttime;
  else if(currenttime - level.lastmortarincomingtime < 1000) {
    wait 1;
    return;
  } else
    level.lastmortarincomingtime = currenttime;

  if(isDefined(bisstruct) && bisstruct == 1) {
    temp_ent = spawn("script_origin", self.origin);
    temp_ent playsound("prj_mortar_incoming", "sounddone");
    wait 0.3;
    level notify("mortar_inc_done");
    temp_ent thread delete_temp_ent();
  } else {
    self playsound("prj_mortar_incoming", "sounddone");
    wait 0.3;
    level notify("mortar_inc_done");
  }
}

mortar_rumble_on_all_players(high_rumble_string, low_rumble_string, rumble_org, high_rumble_range, low_rumble_range) {
  players = get_players();

  for(i = 0; i < players.size; i++) {
    if(isDefined(high_rumble_range) && isDefined(low_rumble_range) && isDefined(rumble_org)) {
      if(distance(players[i].origin, rumble_org) < high_rumble_range)
        players[i] playrumbleonentity(high_rumble_string);
      else if(distance(players[i].origin, rumble_org) < low_rumble_range)
        players[i] playrumbleonentity(low_rumble_string);

      continue;
    }

    players[i] playrumbleonentity(high_rumble_string);
  }
}