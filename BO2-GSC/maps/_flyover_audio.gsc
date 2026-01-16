/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_flyover_audio.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

init() {
  if(!isDefined(level._flyover_audio_table)) {
    level._flyover_audio_table = [];
    level._flyover_audio_table["primary"] = [];
    level._flyover_audio_table["secondary"] = [];
  }

  level._flyover_audio_radius = [];
  level._flyover_audio_radius["primary"] = 4000;
  level._flyover_audio_radius["secondary"] = 1500;
  level._flyover_audio_time = 100;
  add_flyover_audio_entry("primary", "default", "veh_mig_flyby", "veh_mig_flyby_lfe", 3000);
  add_flyover_audio_entry("secondary", "default", "veh_mig_flyby", "veh_mig_flyby_lfe", 3000);
  add_flyover_audio_entry("primary", "plane_phantom_gearup_lowres", "veh_phantom_flyby", undefined, 4375);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_715", undefined, 715);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_1626", undefined, 1626);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_1924", undefined, 1924);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_2362", undefined, 2362);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_2793", undefined, 2793);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_3032", undefined, 3032);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_3090", undefined, 3090);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_3410", undefined, 3410);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_4025", undefined, 4025);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_4375", undefined, 4375);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_4642", undefined, 4642);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_4740", undefined, 4740);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_4762", undefined, 4762);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_5615", undefined, 5615);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_6200", undefined, 6200);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_8270", undefined, 8270);
  add_flyover_audio_entry("primary", "drone_avenger_fast", "evt_flyby_wash_10420", undefined, 10420);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_280", undefined, 280);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_310", undefined, 310);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_312", undefined, 312);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_405", undefined, 405);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_530", undefined, 530);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_630", undefined, 630);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_666", undefined, 666);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_715", undefined, 715);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_1085", undefined, 1085);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_1200", undefined, 1200);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_1874", undefined, 1874);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_2200", undefined, 2200);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_2362", undefined, 2362);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_2793", undefined, 2793);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_4375", undefined, 4375);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_6270", undefined, 6270);
  add_flyover_audio_entry("secondary", "drone_avenger_fast", "evt_flyby_apex_7000", undefined, 7000);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_715", undefined, 715);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_1626", undefined, 1626);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_1924", undefined, 1924);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_2362", undefined, 2362);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_2793", undefined, 2793);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_3032", undefined, 3032);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_3090", undefined, 3090);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_3410", undefined, 3410);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_4025", undefined, 4025);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_4375", undefined, 4375);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_4642", undefined, 4642);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_4740", undefined, 4740);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_4762", undefined, 4762);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_5615", undefined, 5615);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_6200", undefined, 6200);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_8270", undefined, 8270);
  add_flyover_audio_entry("primary", "drone_pegasus_fast", "evt_flyby_wash_10420", undefined, 10420);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_280", undefined, 280);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_310", undefined, 310);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_312", undefined, 312);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_405", undefined, 405);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_530", undefined, 530);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_630", undefined, 630);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_666", undefined, 666);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_715", undefined, 715);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_1085", undefined, 1085);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_1200", undefined, 1200);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_1874", undefined, 1874);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_2200", undefined, 2200);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_2362", undefined, 2362);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_2793", undefined, 2793);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_4375", undefined, 4375);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_6270", undefined, 6270);
  add_flyover_audio_entry("secondary", "drone_pegasus_fast", "evt_flyby_apex_7000", undefined, 7000);
  add_flyover_audio_entry("secondary", "civ_pickup", "veh_car_by_252", undefined, 352);
  add_flyover_audio_entry("secondary", "civ_pickup", "veh_car_by_349", undefined, 449);
  add_flyover_audio_entry("secondary", "civ_pickup", "veh_car_by_517", undefined, 617);
  add_flyover_audio_entry("secondary", "civ_pickup", "veh_car_by_560", undefined, 660);
  add_flyover_audio_entry("secondary", "civ_pickup", "veh_car_by_624", undefined, 724);
  add_flyover_audio_entry("secondary", "civ_hatchback_small", "veh_car_by_252", undefined, 352);
  add_flyover_audio_entry("secondary", "civ_hatchback_small", "veh_car_by_349", undefined, 449);
  add_flyover_audio_entry("secondary", "civ_hatchback_small", "veh_car_by_517", undefined, 617);
  add_flyover_audio_entry("secondary", "civ_hatchback_small", "veh_car_by_560", undefined, 660);
  add_flyover_audio_entry("secondary", "civ_hatchback_small", "veh_car_by_624", undefined, 724);
  add_flyover_audio_entry("secondary", "tiara", "veh_car_by_252", undefined, 352);
  add_flyover_audio_entry("secondary", "tiara", "veh_car_by_349", undefined, 449);
  add_flyover_audio_entry("secondary", "tiara", "veh_car_by_517", undefined, 617);
  add_flyover_audio_entry("secondary", "tiara", "veh_car_by_560", undefined, 660);
  add_flyover_audio_entry("secondary", "tiara", "veh_car_by_624", undefined, 724);
  add_flyover_audio_entry("secondary", "civ_bus", "veh_car_by_252", undefined, 352);
  add_flyover_audio_entry("secondary", "civ_bus", "veh_car_by_349", undefined, 449);
  add_flyover_audio_entry("secondary", "civ_bus", "veh_car_by_517", undefined, 617);
  add_flyover_audio_entry("secondary", "civ_bus", "veh_car_by_560", undefined, 660);
  add_flyover_audio_entry("secondary", "civ_bus", "veh_car_by_624", undefined, 724);
  thread onplayerconnect();
}

add_flyover_audio_entry(source, vehicle_type, sound_alias1, sound_alias2, time) {
  if(!isDefined(level._flyover_audio_table[source][vehicle_type]))
    level._flyover_audio_table[source][vehicle_type] = [];

  entry = spawnstruct();
  entry.sound_alias1 = sound_alias1;
  entry.sound_alias2 = sound_alias2;
  entry.time = time;
  level._flyover_audio_table[source][vehicle_type][level._flyover_audio_table[source][vehicle_type].size] = entry;
}

main() {
  self endon("disconnect");
  self endon("death");

  while(true) {
    vehicles = getvehiclearray();

    for(i = 0; i < vehicles.size; i++) {
      vehicle = vehicles[i];

      if(isDefined(vehicle) && (vehicle.vehicleclass == "plane" || vehicle.vehicleclass == "4 wheel")) {
        if(isDefined(self.viewlockedentity) && vehicle == self.viewlockedentity) {
          continue;
        }
        if(!isDefined(vehicle.flyby_timeout))
          vehicle.flyby_timeout = [];

        if(!isDefined(vehicle.flyby_audio_start_delay))
          vehicle.flyby_audio_start_delay = [];

        if(!isDefined(vehicle.flyby_audio_entry))
          vehicle.flyby_audio_entry = [];

        velocity = vehicle.velocity;
        velocity = (velocity[0], velocity[1], 0);
        p1 = vehicle.origin;
        p1 = (p1[0], p1[1], 0);
        p2 = p1 + velocity * level._flyover_audio_time;
        vehicle update_flyby_audio("primary", p1, p2, velocity);
        vehicle update_flyby_audio("secondary", p1, p2, velocity);
      }
    }

    wait 0.05;
  }
}

update_flyby_audio(source, p1, p2, velocity) {
  if(isDefined(self.flyby_timeout[source]) && self.flyby_timeout[source] > 0) {
    self.flyby_timeout[source] = self.flyby_timeout[source] - 50;

    if(self.flyby_timeout[source] < 0)
      self.flyby_timeout[source] = 0;

    return;
  }

  t = [];
  t = circle_line_intersect(p1, p2, (level.player.origin[0], level.player.origin[1], 0), level._flyover_audio_radius[source]);

  if(t.size < 2) {
    self.flyby_audio_entry[source] = undefined;
    return;
  }

  if(t[0] < 0 || t[1] < 0) {
    self.flyby_audio_entry[source] = undefined;
    return;
  }

  t[0] = 1.0 - t[0];
  t[1] = 1.0 - t[1];
  time = (t[0] + t[1]) * 0.5 * level._flyover_audio_time * 1000;

  if(time > 715) {
    bestentry = get_best_entry(source, self.vehicletype, time);

    if(isDefined(bestentry)) {
      if(isDefined(self.flyby_audio_entry[source])) {
        if(bestentry.time < self.flyby_audio_entry[source].time) {
          self.flyby_audio_entry[source] = bestentry;
          self.flyby_audio_start_delay[source] = bestentry.time - time;
        }
      } else {
        self.flyby_audio_entry[source] = bestentry;
        self.flyby_audio_start_delay[source] = bestentry.time - time;
      }
    } else
      self.flyby_audio_entry[source] = undefined;
  }

  if(isDefined(self.flyby_audio_entry[source])) {
    if(isDefined(self.flyby_audio_start_delay[source])) {
      self.flyby_audio_start_delay[source] = self.flyby_audio_start_delay[source] - 50;

      if(self.flyby_audio_start_delay[source] < 0) {
        self playsound(self.flyby_audio_entry[source].sound_alias1);

        if(isDefined(self.flyby_audio_entry[source].sound_alias2) && self.flyby_audio_entry[source].sound_alias2 != "null")
          self playsound(self.flyby_audio_entry[source].sound_alias2);

        self.flyby_timeout[source] = self.flyby_audio_entry[source].time;
        self.flyby_audio_entry[source] = undefined;
      }
    }
  }
}

get_best_entry(source, vehicletype, time) {
  entries = level._flyover_audio_table[source]["default"];

  if(isDefined(level._flyover_audio_table[source][vehicletype]))
    entries = level._flyover_audio_table[source][vehicletype];

  if(!isDefined(entries))
    return undefined;

  for(i = 0; i < entries.size; i++) {
    if(time < entries[i].time)
      return entries[i];
  }

  return undefined;
}

onplayerconnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    thread main();
  }
}

plane_position_updater(miliseconds, soundalias_1, soundalias_2) {
  apex = miliseconds;
  dx = undefined;
  last_time = undefined;
  last_pos = undefined;
  start_time = 0;

  if(!isDefined(soundalias_1))
    self.soundalias_1 = "veh_mig_flyby";
  else
    self.soundalias_1 = soundalias_1;

  if(!isDefined(soundalias_2))
    self.soundalias_2 = "veh_mig_flyby_lfe";
  else
    self.soundalias_2 = soundalias_2;

  while(isDefined(self)) {
    if(isDefined(last_pos)) {
      dx = self.origin - last_pos;

      if(length(dx) > 0.01) {
        velocity = dx / (gettime() - last_time);
        assert(isDefined(velocity));
        players = getplayers();
        assert(isDefined(players));
        other_point = self.origin + velocity * 100000;
        point = closest_point_on_line_to_point(players[0].origin, self.origin, other_point);
        assert(isDefined(point));
        dist = distance(point, self.origin);
        assert(isDefined(dist));
        time = dist / length(velocity);
        assert(isDefined(time));

        if(time < apex) {
          self playsound(self.soundalias_1);

          if(self.soundalias_2 != "null")
            self playsound(self.soundalias_2);

          start_time = gettime();
          break;
        }
      }
    }

    last_pos = self.origin;
    last_time = gettime();

    if(start_time != 0) {
      iprintlnbold("time: " + (gettime() - start_time) / 1000 + "\\n");

    }

    wait 0.1;
  }
}

closest_point_on_line_to_point(point, linestart, lineend) {
  linesegment = lineend - linestart;
  dist = length(linesegment);
  dir = vectornormalize(lineend - linestart);
  delta = point - linestart;
  t = vectordot(delta, dir) / dist;

  if(t < 0.0)
    return linestart;
  else if(t > 1.0)
    return lineend;

  return linestart + dir * (t * dist);
}

circle_line_intersect(p1, p2, center, radius) {
  t = [];
  d = p2 - p1;
  f = center - p2;
  a = vectordot(d, d);
  b = 2 * vectordot(f, d);
  c = vectordot(f, f) - radius * radius;
  discriminant = b * b - 4 * a * c;

  if(discriminant > 0) {
    discriminant = sqrt(discriminant);
    t[0] = (b * -1 - discriminant) / (2 * a);
    t[1] = (b * -1 + discriminant) / (2 * a);
  }

  return t;
}