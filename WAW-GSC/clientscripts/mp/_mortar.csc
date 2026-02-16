/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_mortar.csc
****************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_utility_code;

init_mortars() {
  level._explosion_max_range = [];
  level._explosion_min_range = [];
  level._explosion_blast_radius = [];
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

player_view_chance(view_chance, explosion_point) {
  chance = RandomFloat(1);
  if(chance <= view_chance) {
    if(within_fov(Getlocalclienteyepos(self), Getlocalclientangles(self), explosion_point, cos(30))) {
      return true;
    }
  }

  return false;
}
explosion_incoming(mortar_name, pos, soundnum) {
  if(!isDefined(level._explosion_last_incoming)) {
    level._explosion_last_incoming = -1;
  }

  soundnum = RandomInt(4) + 1;
  while(soundnum == level._explosion_last_incoming) {
    soundnum = RandomInt(4) + 1;
  }

  level._explosion_last_incoming = soundnum;

  if(level._effectType[mortar_name] == "mortar") {
    switch (soundnum) {
      case 1:
        playSound(0, "mortar_incoming1", pos);
        wait(1.07 - 0.25);
        break;
      case 2:
        playSound(0, "mortar_incoming2", pos);
        wait(0.67 - 0.25);
        break;
      case 3:
        playSound(0, "mortar_incoming3", pos);
        wait(1.55 - 0.25);
        break;
      default:
        wait(1.75);
        break;
    }
  } else if(level._effectType[mortar_name] == "artillery") {
    switch (soundnum) {
      case 1:
        playSound(0, "mortar_incoming4", pos);
        wait(1.07 - 0.25);
        break;
      case 2:
        playSound(0, "mortar_incoming4_new", pos);
        wait(0.67 - 0.25);
        break;
      case 3:
        playSound(0, "mortar_incoming1_new", pos);
        wait(1.55 - 0.25);
        break;
      default:
        wait(1.75);
        break;
    }
  } else if(level._effectType[mortar_name] == "bomb") {
    switch (soundnum) {
      case 1:
        playSound(0, "mortar_incoming2_new", pos);
        wait(1.75);
        break;
      case 2:
        playSound(0, "mortar_incoming3_new", pos);
        wait(1.75);
        break;
      case 3:
        playSound(0, "mortar_incoming4_new", pos);
        wait(1.75);
        break;
      default:
        wait(1.75);
        break;
    }
  }
}
explosion_boom(mortar_name, explosion_origin, power, time, radius) {
  if(!isDefined(power)) {
    power = 0.15;
  }

  if(!isDefined(time)) {
    time = 2;
  }

  if(!isDefined(radius)) {
    radius = 850;
  }

  explosion_sound(mortar_name, explosion_origin);

  playFX(0, level._effect[mortar_name], explosion_origin);

  localPlayers = getlocalplayers();

  for(i = 0; i < localPlayers.size; i++) {
    localPlayers[i] earthQuake(power, time, explosion_origin, radius);
  }
}
explosion_sound(mortar_name, pos) {
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
        playSound(0, "amb_mortar_dirt", pos);
        break;
      case 2:
        playSound(0, "amb_mortar_dirt", pos);
        break;
      case 3:
        playSound(0, "amb_mortar_dirt", pos);
        break;
    }
  }
  if(level._effectType[mortar_name] == "mortar_water") {
    switch (soundnum) {
      case 1:
        playSound(0, "amb_mortar_water", pos);
        break;
      case 2:
        playSound(0, "amb_mortar_water", pos);
        break;
      case 3:
        playSound(0, "amb_mortar_water", pos);
        break;
    }
  } else if(level._effectType[mortar_name] == "artillery") {
    switch (soundnum) {
      case 1:
        playSound(0, "amb_mortar_explosion4", pos);
        break;
      case 2:
        playSound(0, "amb_mortar_explosion5", pos);
        break;
      case 3:
        playSound(0, "amb_mortar_explosion1", pos);
        break;
    }
  } else if(level._effectType[mortar_name] == "bomb") {
    switch (soundnum) {
      case 1:
        playSound(0, "amb_mortar_explosion1", pos);
        break;
      case 2:
        playSound(0, "amb_mortar_explosion4", pos);
        break;
      case 3:
        playSound(0, "amb_mortar_explosion5", pos);
        break;
    }
  }
}

explosion_activate(mortar_name, blast_radius, quake_power, quake_time, quake_radius, dust_points) {
  set_mortar_quake(mortar_name, 0.15, 2, 850, true);

  if(!isDefined(blast_radius)) {
    blast_radius = level._explosion_blast_radius[mortar_name];
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

  explosion_incoming(mortar_name, self.origin);

  level notify("explosion", mortar_name);

  explosion_boom(mortar_name, self.origin, quake_power, quake_time, quake_radius);

  if(isDefined(dust_points) && dust_points.size > 0) {
    max_range = 384;
    if(isDefined(level._explosion_dust_range) && isDefined(level._explosion_dust_range[mortar_name])) {
      max_range = level._explosion_dust_range[mortar_name];
    }

    for(i = 0; i < dust_points.size; i++) {
      if(DistanceSquared(dust_points[i].origin, self.origin) < max_range * max_range) {
        if(isDefined(dust_points[i].script_fxid)) {
          {}
          playFX(0, level._effect[dust_points[i].script_fxid], dust_points[i].origin);
        } else {
          {}
          playFX(0, level._effect[level._explosion_dust_name[mortar_name]], dust_points[i].origin);
        }
      }
    }
  }
}
mortar_loop(mortar_name, barrage_amount) {
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

  if(isDefined(level._explosion_stopNotify) && isDefined(level._explosion_stopNotify[mortar_name])) {
    level endon(level._explosion_stopNotify[mortar_name]);
  }

  if(!isDefined(level._explosion_stop_barrage) || !isDefined(level._explosion_stop_barrage[mortar_name])) {
    level._explosion_stop_barrage[mortar_name] = false;
  }

  explosion_points = [];
  explosion_points_structs = [];

  num_points = 0;

  while(num_points == 0) {
    explosion_points = getEntArray(0, mortar_name, "targetname");
    explosion_points_structs = getstructarray(mortar_name, "targetname");

    num_points = explosion_points.size + explosion_points_structs.size;
    wait(0.5);
  }

  for(i = 0; i < explosion_points_structs.size; i++) {
    explosion_points_structs[i].is_struct = true;
    explosion_points = add_to_array(explosion_points, explosion_points_structs[i]);
  }

  explosion_points_structs = [];

  dust_points = [];
  if(isDefined(level._explosion_dust_name[mortar_name])) {
    dust_name = level._explosion_dust_name[mortar_name];

    dust_points = getEntArray(0, dust_name, "targetname");

    dust_points_structs = [];
    dust_points_structs = getstructarray(dust_name, "targetname");

    for(i = 0; i < dust_points_structs.size; i++) {
      dust_points_structs[i].is_struct = true;
      dust_points = add_to_array(dust_points, dust_points_structs[i]);
    }

    dust_points_structs = [];
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
          {}
          num = (i + random_num) % explosion_points.size;

          do_mortar = false;

          players = getlocalplayers();
          for(q = 0; q < players.size; q++) {
            dist = distanceSquared(getlocalclientpos(q), explosion_points[num].origin);

            if(num != last_explosion && dist < max_rangeSQ && dist > min_rangeSQ) {
              {}

              if(level._explosion_view_chance[mortar_name] > 0) {
                if(players[q] player_view_chance(level._explosion_view_chance[mortar_name], explosion_points[num].origin)) {
                  {}
                  do_mortar = true;
                  break;
                } else {
                  {}
                  do_mortar = false;
                }
              } else {
                do_mortar = true;
                break;
              }
            } else {
              {}
              do_mortar = false;
            }
          }

          if(do_mortar) {
            explosion_points[num] thread explosion_activate(mortar_name, undefined, undefined, undefined, undefined, dust_points);
            last_explosion = num;
            break;
          }
        }

        last_explosion = -1;

        if(do_mortar) {
          {}
          if(isDefined(level._explosion_delay) && isDefined(level._explosion_delay[mortar_name])) {
            wait(level._explosion_delay[mortar_name]);
          } else {
            wait(RandomFloatRange(level._explosion_min_delay[mortar_name], level._explosion_max_delay[mortar_name]));
          }
        } else {
          {}
          j--;
          wait(0.25);
        }
      }

      if(barrage_amount > 1) {
        if(isDefined(level._explosion_barrage_delay) && isDefined(level._explosion_barrage_delay[mortar_name])) {
          {}
          wait(level._explosion_barrage_delay[mortar_name]);
        } else {
          {}
          wait(RandomFloatRange(level._explosion_barrage_min_delay[mortar_name], level._explosion_barrage_max_delay[mortar_name]));
        }
      }
    }
    wait(0.05);
  }
}