/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_mortar.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

main() {}
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
  if(!isDefined(level._explosion_min_range)) {
    init_mortars();
  }

  if(isDefined(set_default) && set_default) {
    if(!isDefined(level._explosion_min_range[mortar_name])) {
      level._explosion_min_range[mortar_name] = min_range;
    }

    if(!isDefined(level._explosion_max_range[mortar_name])) {
      level._explosion_max_range[mortar_name] = max_range;
    }
  } else {
    level._explosion_min_range[mortar_name] = min_range;
    level._explosion_max_range[mortar_name] = max_range;
  }
}
set_mortar_damage(mortar_name, blast_radius, min_damage, max_damage, set_default) {
  if(!isDefined(level._explosion_blast_radius)) {
    init_mortars();
  }

  if(isDefined(set_default) && set_default) {
    if(!isDefined(level._explosion_blast_radius[mortar_name])) {
      level._explosion_blast_radius[mortar_name] = blast_radius;
    }

    if(!isDefined(level._explosion_min_damage[mortar_name])) {
      level._explosion_min_damage[mortar_name] = min_damage;
    }

    if(!isDefined(level._explosion_max_damage[mortar_name])) {
      level._explosion_max_damage[mortar_name] = max_damage;
    }
  } else {
    level._explosion_blast_radius[mortar_name] = blast_radius;
    level._explosion_min_damage[mortar_name] = min_damage;
    level._explosion_max_damage[mortar_name] = max_damage;
  }
}
set_mortar_quake(mortar_name, quake_power, quake_time, quake_radius, set_default) {
  if(!isDefined(level._explosion_quake_power)) {
    init_mortars();
  }

  if(isDefined(set_default) && set_default) {
    if(!isDefined(level._explosion_quake_power[mortar_name])) {
      level._explosion_quake_power[mortar_name] = quake_power;
    }

    if(!isDefined(level._explosion_quake_power[mortar_name])) {
      level._explosion_quake_time[mortar_name] = quake_time;
    }

    if(!isDefined(level._explosion_quake_radius[mortar_name])) {
      level._explosion_quake_radius[mortar_name] = quake_radius;
    }
  } else {
    level._explosion_quake_power[mortar_name] = quake_power;
    level._explosion_quake_time[mortar_name] = quake_time;
    level._explosion_quake_radius[mortar_name] = quake_radius;
  }
}
set_mortar_delays(mortar_name, min_delay, max_delay, barrage_min_delay, barrage_max_delay, set_default) {
  if(!isDefined(level._explosion_min_delay)) {
    init_mortars();
  }

  if(isDefined(set_default) && set_default) {
    if(!isDefined(level._explosion_min_delay[mortar_name]) && isDefined(min_delay)) {
      level._explosion_min_delay[mortar_name] = min_delay;
    }

    if(!isDefined(level._explosion_max_delay[mortar_name]) && isDefined(min_delay)) {
      level._explosion_max_delay[mortar_name] = max_delay;
    }

    if(!isDefined(level._explosion_barrage_min_delay[mortar_name]) && isDefined(barrage_min_delay)) {
      level._explosion_barrage_min_delay[mortar_name] = barrage_min_delay;
    }

    if(!isDefined(level._explosion_barrage_max_delay[mortar_name]) && isDefined(barrage_max_delay)) {
      level._explosion_barrage_max_delay[mortar_name] = barrage_max_delay;
    }
  } else {
    if(isDefined(min_delay)) {
      level._explosion_min_delay[mortar_name] = min_delay;
    }

    if(isDefined(min_delay)) {
      level._explosion_max_delay[mortar_name] = max_delay;
    }

    if(isDefined(barrage_min_delay)) {
      level._explosion_barrage_min_delay[mortar_name] = barrage_min_delay;
    }

    if(isDefined(barrage_max_delay)) {
      level._explosion_barrage_max_delay[mortar_name] = barrage_max_delay;
    }
  }
}
set_mortar_chance(mortar_name, chance, set_default) {
  if(!isDefined(level._explosion_view_chance)) {
    init_mortars();
  }

  assertex(chance <= 1, "_mortar::set_mortar_chance(), the chance parameter needs to be between 0 and 1");

  if(isDefined(set_default) && set_default) {
    if(!isDefined(level._explosion_view_chance[mortar_name])) {
      level._explosion_view_chance[mortar_name] = chance;
    }
  } else {
    level._explosion_view_chance[mortar_name] = chance;
  }
}

set_mortar_dust(mortar_name, dust_name, range) {
  if(!isDefined(level._explosion_dust_range)) {
    init_mortars();
  }

  level._explosion_dust_name[mortar_name] = dust_name;

  if(!isDefined(range)) {
    range = 512;
  }

  level._explosion_dust_range[mortar_name] = range;
}
mortar_loop(mortar_name, barrage_amount, no_terrain) {
  level endon("stop_all_mortar_loops");

  assertex((isDefined(mortar_name) && (mortar_name != "")), "mortar_name not passed. pass in level script");
  assertex((isDefined(level._effect) && isDefined(level._effect[mortar_name])), "level._effect[strMortars] not defined. define in level script");

  last_explosion = -1;

  set_mortar_range(mortar_name, 300, 2200, true);
  set_mortar_delays(mortar_name, 5, 7, 5, 7, true);
  set_mortar_chance(mortar_name, 0, true);

  if(!isDefined(barrage_amount) || barrage_amount < 1) {
    barrage_amount = 1;
  }

  if(!isDefined(no_terrain)) {
    no_terrain = false;
  }

  if(isDefined(level._explosion_stopNotify) && isDefined(level._explosion_stopNotify[mortar_name])) {
    level endon(level._explosion_stopNotify[mortar_name]);
  }

  if(!isDefined(level._explosion_stop_barrage) || !isDefined(level._explosion_stop_barrage[mortar_name])) {
    level._explosion_stop_barrage[mortar_name] = false;
  }

  explosion_points = [];
  explosion_points = getEntArray(mortar_name, "targetname");

  explosion_points_structs = [];
  explosion_points_structs = getstructarray(mortar_name, "targetname");

  for(i = 0; i < explosion_points_structs.size; i++) {
    explosion_points_structs[i].is_struct = true;
    explosion_points = add_to_array(explosion_points, explosion_points_structs[i]);
  }

  explosion_points_structs = [];

  dust_points = [];
  if(isDefined(level._explosion_dust_name[mortar_name])) {
    dust_name = level._explosion_dust_name[mortar_name];

    dust_points = getEntArray(dust_name, "targetname");

    dust_points_structs = [];
    dust_points_structs = getstructarray(dust_name, "targetname");

    for(i = 0; i < dust_points_structs.size; i++) {
      dust_points_structs[i].is_struct = true;
      dust_points = add_to_array(dust_points, dust_points_structs[i]);
    }

    dust_points_structs = [];
  }

  for(i = 0; i < explosion_points.size; i++) {
    if(isDefined(explosion_points[i].target) && (!no_terrain)) {
      explosion_points[i] setup_mortar_terrain();
    }
  }

  if(isDefined(level._explosion_start_notify) && isDefined(level._explosion_start_notify[mortar_name])) {
    level waittill(level._explosion_start_notify[mortar_name]);
  }

  while(true) {
    while(!level._explosion_stop_barrage[mortar_name]) {
      do_mortar = false;

      for(j = 0; j < barrage_amount; j++) {
        max_rangeSQ = level._explosion_max_range[mortar_name] * level._explosion_max_range[mortar_name];
        min_rangeSQ = level._explosion_min_range[mortar_name] * level._explosion_min_range[mortar_name];
        random_num = RandomInt(explosion_points.size);

        for(i = 0; i < explosion_points.size; i++) {
          num = (i + random_num) % explosion_points.size;

          do_mortar = false;
          players = get_players();
          for(q = 0; q < players.size; q++) {
            dist = DistanceSquared(players[q] GetOrigin(), explosion_points[num].origin);

            if(num != last_explosion && dist < max_rangeSQ && dist > min_rangeSQ) {
              if(level._explosion_view_chance[mortar_name] > 0) {
                if(players[q] player_view_chance(level._explosion_view_chance[mortar_name], explosion_points[num].origin)) {
                  do_mortar = true;
                  break;
                } else {
                  do_mortar = false;
                }
              } else {
                do_mortar = true;
                break;
              }
            } else {
              do_mortar = false;
            }
          }

          if(do_mortar) {
            explosion_points[num] thread explosion_activate(mortar_name, undefined, undefined, undefined, undefined, undefined, undefined, dust_points);
            last_explosion = num;
            break;
          }
        }

        last_explosion = -1;

        if(do_mortar) {
          if(isDefined(level._explosion_delay) && isDefined(level._explosion_delay[mortar_name])) {
            wait(level._explosion_delay[mortar_name]);
          } else {
            wait(RandomFloatRange(level._explosion_min_delay[mortar_name], level._explosion_max_delay[mortar_name]));
          }
        } else {
          j--;
          wait(0.25);
        }
      }

      if(barrage_amount > 1) {
        if(isDefined(level._explosion_barrage_delay) && isDefined(level._explosion_barrage_delay[mortar_name])) {
          wait(level._explosion_barrage_delay[mortar_name]);
        } else {
          wait(RandomFloatRange(level._explosion_barrage_min_delay[mortar_name], level._explosion_barrage_max_delay[mortar_name]));
        }
      }
    }
    wait(0.05);
  }
}

player_view_chance(view_chance, explosion_point) {
  chance = RandomFloat(1);
  if(chance <= view_chance) {
    if(within_fov(self getEye(), self GetPlayerAngles(), explosion_point, cos(30))) {
      return true;
    }
  }

  return false;
}

explosion_activate(mortar_name, blast_radius, min_damage, max_damage, quake_power, quake_time, quake_radius, dust_points) {
  set_mortar_damage(mortar_name, 256, 25, 400, true);
  set_mortar_quake(mortar_name, 0.15, 2, 850, true);

  if(!isDefined(blast_radius)) {
    blast_radius = level._explosion_blast_radius[mortar_name];
  }

  if(!isDefined(min_damage)) {
    min_damage = level._explosion_min_damage[mortar_name];
  }

  if(!isDefined(max_damage)) {
    max_damage = level._explosion_max_damage[mortar_name];
  }

  if(!isDefined(quake_power)) {
    quake_power = level._explosion_quake_power[mortar_name];
  }

  if(!isDefined(quake_time)) {
    quake_time = level._explosion_quake_time[mortar_name];
  }

  if(!isDefined(quake_radius)) {
    quake_radius = level._explosion_quake_radius[mortar_name];
  }

  is_struct = isDefined(self.is_struct) && self.is_struct;
  temp_ent = undefined;
  if(is_struct) {
    temp_ent = spawn("script_origin", self.origin);
  }

  if(is_struct) {
    temp_ent explosion_incoming(mortar_name);
  } else {
    self explosion_incoming(mortar_name);
  }

  level notify("explosion", mortar_name);

  RadiusDamage(self.origin, blast_radius, max_damage, min_damage);

  if((isDefined(self.has_terrain) && self.has_terrain == true) && (isDefined(self.terrain))) {
    for(i = 0; i < self.terrain.size; i++) {
      if(isDefined(self.terrain[i])) {
        self.terrain[i] Delete();
      }
    }
  }

  if(isDefined(self.hidden_terrain)) {
    self.hidden_terrain Show();
  }

  self.has_terrain = false;

  if(is_struct) {
    temp_ent explosion_boom(mortar_name, quake_power, quake_time, quake_radius);
  } else {
    self explosion_boom(mortar_name, quake_power, quake_time, quake_radius);
  }

  if(isDefined(dust_points) && dust_points.size > 0) {
    max_range = 384;
    if(isDefined(level._explosion_dust_range) && isDefined(level._explosion_dust_range[mortar_name])) {
      max_range = level._explosion_dust_range[mortar_name];
    }

    for(i = 0; i < dust_points.size; i++) {
      if(DistanceSquared(dust_points[i].origin, self.origin) < max_range * max_range) {
        if(isDefined(dust_points[i].script_fxid)) {
          playFX(level._effect[dust_points[i].script_fxid], dust_points[i].origin);
        } else {
          playFX(level._effect[level._explosion_dust_name[mortar_name]], dust_points[i].origin);
        }
      }
    }
  }

  if(is_struct) {
    temp_ent thread delete_temp_ent();
  }
}

delete_temp_ent() {
  wait(5);
  self Delete();
}

explosion_boom(mortar_name, power, time, radius, is_struct) {
  if(!isDefined(power)) {
    power = 0.15;
  }

  if(!isDefined(time)) {
    time = 2;
  }

  if(!isDefined(radius)) {
    radius = 850;
  }

  if(!isDefined(is_struct)) {
    explosion_sound(mortar_name);
  } else {
    temp_ent = spawn("script_origin", self.origin);
    temp_ent explosion_sound(mortar_name);
    temp_ent thread delete_temp_ent();
  }

  explosion_origin = self.origin;

  playFX(level._effect[mortar_name], explosion_origin);
  Earthquake(power, time, explosion_origin, radius);

  thread mortar_rumble_on_all_players("damage_light", "damage_heavy", explosion_origin, radius * 0.75, radius * 1.25);

  physRadius = radius;
  if(physRadius > 500) {
    physRadius = 500;
  }
  PhysicsExplosionSphere(explosion_origin, physRadius, physRadius * 0.25, 0.75);

  players = get_players();
  player_count = 0;
  for(q = 0; q < players.size; q++) {
    if(Distancesquared(players[q].origin, explosion_origin) > 300 * 300) {
      player_count++;
    }
  }

  if(player_count == players.size) {
    return;
  }

  level.playerMortar = true;
  level notify("shell shock player", time * 4);

  max_damage = level._explosion_max_damage[mortar_name];
  min_damage = level._explosion_max_damage[mortar_name];
  maps\_shellshock::main(explosion_origin, time * 4, undefined, max_damage, 1, min_damage);
}

explosion_sound(mortar_name) {
  if(!isDefined(level._explosion_last_sound)) {
    level._explosion_last_sound = 0;
  }

  soundnum = RandomInt(3) + 1;
  while(soundnum == level._explosion_last_sound) {
    soundnum = RandomInt(3) + 1;
  }

  level._explosion_last_sound = soundnum;

  if(level._effectType[mortar_name] == "mortar") {
    switch (soundnum) {
      case 1:
        self playSound("mortar_dirt");
        break;
      case 2:
        self playSound("mortar_dirt");
        break;
      case 3:
        self playSound("mortar_dirt");
        break;
    }
  }
  if(level._effectType[mortar_name] == "mortar_water") {
    switch (soundnum) {
      case 1:
        self playSound("mortar_impact_water");
        break;
      case 2:
        self playSound("mortar_impact_water");
        break;
      case 3:
        self playSound("mortar_impact_water");
        break;
    }
  } else if(level._effectType[mortar_name] == "artillery") {
    switch (soundnum) {
      case 1:
        self playSound("mortar_explosion4");
        break;
      case 2:
        self playSound("mortar_explosion5");
        break;
      case 3:
        self playSound("mortar_explosion1");
        break;
    }
  } else if(level._effectType[mortar_name] == "bomb") {
    switch (soundnum) {
      case 1:
        self playSound("mortar_explosion1");
        break;
      case 2:
        self playSound("mortar_explosion4");
        break;
      case 3:
        self playSound("mortar_explosion5");
        break;
    }
  }
}

explosion_incoming(mortar_name) {
  if(level._effectType[mortar_name] == "mortar") {
    if(!SoundExists("art_incoming")) {
      return;
    }

    self playSound("art_incoming", "sounddone");
  }
  if(level._effectType[mortar_name] == "mortar_water") {
    if(!SoundExists("art_incoming")) {
      return;
    }

    self playSound("art_incoming", "sounddone");
  } else if(level._effectType[mortar_name] == "artillery") {
    if(!SoundExists("art_incoming")) {
      return;
    }

    self playSound("art_incoming", "sounddone");
  } else if(level._effectType[mortar_name] == "bomb") {
    if(!SoundExists("art_incoming")) {
      return;
    }

    self playSound("art_incoming", "sounddone");
  }
  self waittill("sounddone");
}

setup_mortar_terrain() {
  self.has_terrain = false;
  if(isDefined(self.target)) {
    self.terrain = getEntArray(self.target, "targetname");
    self.has_terrain = true;
  } else {
    println("z:mortar entity has no target: ", self.origin);
  }

  if(!isDefined(self.terrain)) {
    println("z:mortar entity has target, but target doesnt exist: ", self.origin);
  }

  if(isDefined(self.script_hidden)) {
    if(isDefined(self.script_hidden)) {
      self.hidden_terrain = GetEnt(self.script_hidden, "targetname");
    } else if((isDefined(self.terrain)) && (isDefined(self.terrain[0].target))) {
      self.hidden_terrain = GetEnt(self.terrain[0].target, "targetname");
    }

    if(isDefined(self.hidden_terrain)) {
      self.hidden_terrain Hide();
    }
  } else if(isDefined(self.has_terrain)) {
    if(isDefined(self.terrain) && isDefined(self.terrain[0].target)) {
      self.hidden_terrain = GetEnt(self.terrain[0].target, "targetname");
    }

    if(isDefined(self.hidden_terrain)) {
      self.hidden_terrain Hide();
    }
  }

}

activate_mortar(range, max_damage, min_damage, quake_power, quake_time, quake_radius, bIsstruct) {
  incoming_sound(undefined, bIsstruct);

  level notify("mortar");
  self notify("mortar");

  if(!isDefined(range)) {
    range = 256;
  }

  if(!isDefined(max_damage)) {
    max_damage = 400;
  }

  if(!isDefined(min_damage)) {
    min_damage = 25;
  }

  RadiusDamage(self.origin, range, max_damage, min_damage);

  if((isDefined(self.has_terrain) && self.has_terrain == true) && (isDefined(self.terrain))) {
    for(i = 0; i < self.terrain.size; i++) {
      if(isDefined(self.terrain[i])) {
        self.terrain[i] Delete();
      }
    }
  }

  if(isDefined(self.hidden_terrain)) {
    self.hidden_terrain Show();
  }
  self.has_terrain = false;

  mortar_boom(self.origin, quake_power, quake_time, quake_radius, undefined, bIsstruct);
}

mortar_boom(origin, power, time, radius, effect, bIsstruct) {
  if(!isDefined(power)) {
    power = 0.15;
  }

  if(!isDefined(time)) {
    time = 2;
  }

  if(!isDefined(radius)) {
    radius = 850;
  }

  thread mortar_sound(bIsstruct);

  if(isDefined(effect)) {
    playFX(effect, origin);
  } else {
    playFX(level.mortar, origin);
  }

  Earthquake(power, time, origin, radius);
  thread mortar_rumble_on_all_players("damage_light", "damage_heavy", origin, radius * 0.75, radius * 1.25);

  physRadius = radius;
  if(physRadius > 500) {
    physRadius = 500;
  }
  PhysicsExplosionSphere(origin, physRadius, physRadius * 0.25, 0.75);

  if(isDefined(level.playerMortar)) {
    return;
  }

  players = get_players();
  players = get_players();
  player_count = 0;
  for(q = 0; q < players.size; q++) {
    if(Distancesquared(players[q].origin, origin) > 300 * 300) {
      player_count++;
    }
  }

  if(player_count == players.size) {
    return;
  }
  if(level.script == "carchase" || level.script == "breakout") {
    return;
  }

  level.playerMortar = true;
  level notify("shell shock player", time * 4);
  maps\_shellshock::main(origin, time * 4);
}

mortar_sound(bIsstruct) {
  if(!isDefined(level.mortar_last_sound)) {
    level.mortar_last_sound = -1;
  }

  soundnum = RandomInt(3) + 1;
  while(soundnum == level.mortar_last_sound) {
    soundnum = RandomInt(3) + 1;
  }

  level.mortar_last_sound = soundnum;

  if(!bIsstruct) {} else {
    play_sound_in_space("mortar_explosion" + soundnum, self.origin);
  }
}

incoming_sound(soundnum, bIsstruct) {
  currenttime = GetTime();
  if(!isDefined(level.lastmortarincomingtime)) {
    level.lastmortarincomingtime = currenttime;
  } else if((currenttime - level.lastmortarincomingtime) < 1000) {
    wait(1);
    return;
  } else {
    level.lastmortarincomingtime = currenttime;
  }

  if(!isDefined(soundnum)) {
    soundnum = RandomInt(3) + 1;
  }

  if(soundnum == 1) {
    if(bIsstruct) {
      thread play_sound_in_space("mortar_incoming1", self.origin);
    } else {}
    wait(1.07 - 0.25);
  } else if(soundnum == 2) {
    if(bIsstruct) {
      thread play_sound_in_space("mortar_incoming2", self.origin);
    } else {}
    wait(0.67 - 0.25);
  } else {
    if(bIsstruct) {
      thread play_sound_in_space("mortar_incoming3", self.origin);
    } else {}
    wait(1.55 - 0.25);
  }
}

mortar_rumble_on_all_players(high_rumble_string, low_rumble_string, rumble_org, high_rumble_range, low_rumble_range) {
  players = get_players();

  for(i = 0; i < players.size; i++) {
    if(isDefined(high_rumble_range) && isDefined(low_rumble_range) && isDefined(rumble_org)) {
      if(distance(players[i].origin, rumble_org) < high_rumble_range) {
        players[i] playrumbleonentity(high_rumble_string);
      } else if(distance(players[i].origin, rumble_org) < low_rumble_range) {
        players[i] playrumbleonentity(low_rumble_string);
      }
    } else {
      players[i] playrumbleonentity(high_rumble_string);
    }
  }
}