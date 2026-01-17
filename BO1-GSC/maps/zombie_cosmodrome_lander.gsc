/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_cosmodrome_lander.gsc
*********************************************/

#include animscripts\zombie_utility;
#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;

init() {
  flag_init("lander_power");
  flag_init("lander_connected");
  flag_init("lander_grounded");
  flag_init("lander_takeoff");
  flag_init("lander_landing");
  flag_init("lander_cooldown");
  flag_init("lander_inuse");
  level.zone_connected = false;
  level.lander_in_use = false;
  level.lander_ridden = 0;
  lander = getent("lander", "targetname");
  lander.door_north = GetEnt("zipline_door_n", "script_noteworthy");
  lander.door_south = GetEnt("zipline_door_s", "script_noteworthy");
  lander setforcenocull();
  lander.door_north setforcenocull();
  lander.door_south setforcenocull();
  lander.station = "lander_station5";
  lander.state = "idle";
  lander.called = false;
  lander.anchor = spawn("script_origin", lander.origin);
  lander.anchor.angles = lander.angles;
  lander linkto(lander.anchor);
  lander link_pieces(undefined, true);
  lander.door_north link_pieces(undefined, true);
  lander.door_south link_pieces(undefined, true);
  lander.zone = [];
  lander.zone["lander_station1"] = "base_entry_zone";
  lander.zone["lander_station3"] = "north_catwalk_zone3";
  lander.zone["lander_station4"] = "storage_lander_zone";
  lander.zone["lander_station5"] = "centrifuge_zone";
  lander.stations_waiting = 3;
  init_call_boxes();
  level thread lander_poi_init();
  flag_wait("all_players_spawned");
  setup_initial_lander_states();
  level notify("lander_launched");
  wait(.1);
  clientnotify("LL");
  flag_wait("power_on");
  enable_callboxes();
  open_lander_gate();
  level thread lander_cooldown_think();
  level thread play_launch_unlock_vox();
}
setup_initial_lander_states() {
  clientNotify("BE_O");
  clientNotify("CW_O");
  ClientNotify("S_O");
}
lander_poi_init() {
  lander_poi = getEntArray("lander_poi", "targetname");
  for(i = 0; i < lander_poi.size; i++) {
    lander_poi[i] create_zombie_point_of_interest(undefined, 30, 0, false);
    lander_poi[i] thread create_zombie_point_of_interest_attractor_positions(4, 45);
  }
}
activate_lander_poi(station) {
  if(!isDefined(station))
    return;
  current_poi = undefined;
  lander_poi = getEntArray("lander_poi", "targetname");
  for(i = 0; i < lander_poi.size; i++) {
    if(lander_poi[i].script_string == station) {
      current_poi = lander_poi[i];
      continue;
    }
  }
  current_poi activate_zombie_point_of_interest();
  flag_wait("lander_grounded");
  current_poi deactivate_zombie_point_of_interest();
}
init_lander_screen() {
  self setModel("p_zom_lunar_control_scrn_on");
}
link_pieces(piece, no_cull) {
  pieces = getEntArray(self.target, "targetname");
  for(i = 0; i < pieces.size; i++) {
    if(isDefined(pieces[i].script_noteworthy) && pieces[i].script_noteworthy == "zip_buy") {
      pieces[i] EnableLinkTo();
    }
    if(isDefined(piece)) {
      pieces[i] LinkTo(piece);
    } else {
      pieces[i] LinkTo(self);
    }
    if(isDefined(no_cull) && no_cull) {
      pieces[i] setforcenocull();
    }
  }
}
close_lander_door(time) {
  open_pos = getstruct(self.target, "targetname");
  start_pos = getstruct(open_pos.target, "targetname");
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "shaft_cap") {} else {
    flag_wait("lander_grounded");
  }
}
open_lander_door(time) {
  open_pos = getstruct(self.target, "targetname");
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "shaft_cap") {
    level waittill("lander_launched");
  } else {}
}
open_lander_gate() {
  lander = getent("lander", "targetname");
  north_pos = GetEnt("zipline_door_n_pos", "script_noteworthy");
  south_pos = GetEnt("zipline_door_s_pos", "script_noteworthy");
  lander.door_north thread move_gate(north_pos, true);
  lander.door_south move_gate(south_pos, true);
}
close_lander_gate(time) {
  lander = getent("lander", "targetname");
  north_pos = GetEnt("zipline_door_n_pos", "script_noteworthy");
  south_pos = GetEnt("zipline_door_s_pos", "script_noteworthy");
  center_pos = GetEnt("zipline_center", "script_noteworthy");
  lander.door_north thread move_gate(north_pos, false, time);
  lander.door_south move_gate(south_pos, false, time);
}
move_gate(pos, lower, time) {
  if(!isDefined(time)) {
    time = 1.0;
  }
  lander = getent("lander", "targetname");
  self unlink();
  if(lower) {
    self notsolid();
    if(self.classname == "script_brushmodel") {
      self moveto(pos.origin + (0, 0, -132), time);
    } else {
      self playSound("zmb_lander_gate");
      self moveto(pos.origin + (0, 0, -44), time);
    }
    self waittill("movedone");
    if(self.classname == "script_brushmodel") {
      self connectpaths();
    }
  } else {
    if(self.classname == "script_brushmodel") {} else {
      self playSound("zmb_lander_gate");
    }
    self notsolid();
    self moveto(pos.origin, time);
    self waittill("movedone");
    if(self.classname == "script_brushmodel") {
      self solid();
      self disconnectpaths();
    }
  }
  self linkto(lander.anchor);
}
init_buy() {
  trigger = GetEnt("zip_buy", "script_noteworthy");
  trigger thread lander_buy_think();
}
init_call_boxes() {
  flag_wait("zones_initialized");
  trigger = getEntArray("zip_call_box", "targetname");
  for(i = 0; i < trigger.size; i++) {
    trigger[i] thread call_box_think();
    self.destination = "lander_station5";
  }
}
call_box_think() {
  level endon("fake_death");
  lander = getent("lander", "targetname");
  self sethintstring(&"ZOMBIE_NEED_POWER");
  self setcursorhint("HINT_NOICON");
  flag_wait("power_on");
  self.activated_station = false;
  if(lander.station != self.script_noteworthy) {
    self sethintstring(&"ZOMBIE_COSMODROME_LANDER_INACTIVE");
  } else {
    self sethintstring(&"ZOMBIE_COSMODROME_LANDER_AT_STATION");
    self setcursorhint("HINT_NOICON");
  }
  while(1) {
    who = undefined;
    self waittill("trigger", who);
    if(who maps\_laststand::player_is_in_laststand()) {
      continue;
    }
    if(flag("lander_cooldown") || flag("lander_inuse")) {
      continue;
    }
    if(!self.activated_station) {
      self.activated_station = true;
    }
    if(lander.station != self.script_noteworthy) {
      call_destination = self.script_noteworthy;
      lander.called = true;
      bbPrint("zombie_uses: playername %s playerscore %d teamscore %d round %d cost %d name %s x %f y %f z %f type escape_call", who.playername, who.score, level.team_pool[who.team_num].score, level.round_number, level.lander_cost, call_destination, self.origin);
      level.lander_in_use = true;
      self playSound("zmb_push_button");
      self playSound("vox_ann_lander_current_0");
      switch (call_destination) {
        case "lander_station5":
          level clientnotify("LLCF");
          break;
        case "lander_station1":
          level clientnotify("LLBE");
          break;
        case "lander_station3":
          level clientnotify("LLCW");
          break;
        case "lander_station4":
          level clientnotify("LLSS");
          break;
      }
      self thread lander_take_off(call_destination);
    }
    wait(.05);
  }
}
lander_buy_think() {
  level endon("fake_death");
  self sethintstring(&"ZOMBIE_NEED_POWER");
  flag_wait("power_on");
  lander = getent("lander", "targetname");
  panel = getent("rocket_launch_panel", "targetname");
  self sethintstring(&"ZOMBIE_COSMODROME_LANDER_NO_CONNECTIONS");
  lander_lights_red();
  level clientnotify("LACF");
  while(!lander.called) {
    wait(1);
  }
  level.zone_connected = true;
  flag_set("lander_connected");
  self SetHintString(&"ZOMBIE_COSMODROME_LANDER");
  node = GetNode("goto_centrifuge", "targetname");
  while(1) {
    who = undefined;
    self waittill("trigger", who);
    if(flag("lander_cooldown") || flag("lander_inuse")) {
      play_sound_at_pos("no_purchase", self.origin);
      continue;
    }
    if(who maps\_laststand::player_is_in_laststand()) {
      play_sound_at_pos("no_purchase", self.origin);
      continue;
    }
    rider_trigger = getent(lander.station + "_riders", "targetname");
    touching = false;
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(rider_trigger isTouching(players[i])) {
        touching = true;
      }
    }
    if(!touching) {
      continue;
    }
    if(is_player_valid(who) && who.score >= level.lander_cost) {
      who maps\_zombiemode_score::minus_to_player_score(level.lander_cost);
      play_sound_at_pos("purchase", self.origin);
      self playSound("zmb_push_button");
      self playSound("vox_ann_lander_current_0");
      level.lander_in_use = true;
      lander.called = false;
      switch (lander.station) {
        case "lander_station1":
          if(!flag("lander_a_used")) {
            level notify("new_lander_used");
          }
          flag_set("lander_a_used");
          lander setclientflag(4);
          break;
        case "lander_station3":
          if(!flag("lander_b_used")) {
            level notify("new_lander_used");
          }
          flag_set("lander_b_used");
          lander setclientflag(6);
          break;
        case "lander_station4":
          if(!flag("lander_c_used")) {
            level notify("new_lander_used");
          }
          flag_set("lander_c_used");
          lander setclientflag(5);
          break;
      }
      call_box = getent(lander.station, "script_noteworthy");
      if(lander.station == "lander_station5") {
        dest = [];
        azkeys = GetArrayKeys(lander.zone);
        for(i = 0; i < azkeys.size; i++) {
          if(azkeys[i] == lander.station) {
            continue;
          }
          zone = level.zones[lander.zone[azkeys[i]]];
          if(isDefined(zone) && zone.is_enabled) {
            dest[dest.size] = azkeys[i];
          }
        }
        dest = array_randomize(dest);
        call_box.destination = dest[0];
      } else {
        call_box.destination = "lander_station5";
      }
      lander.driver = who;
      if(IsPlayer(who)) {
        bbPrint("zombie_uses: playername %s playerscore %d teamscore %d round %d cost %d name %s x %f y %f z %f type escape", who.playername, who.score, level.team_pool[who.team_num].score, level.round_number, level.lander_cost, call_box.destination, self.origin);
      }
      lander playSound("zmb_lander_start");
      lander playLoopSound("zmb_lander_exhaust_loop", 1);
      switch (call_box.destination) {
        case "lander_station5":
          level clientnotify("LLCF");
          break;
        case "lander_station1":
          level clientnotify("LLBE");
          break;
        case "lander_station3":
          level clientnotify("LLCW");
          break;
        case "lander_station4":
          level clientnotify("LLSS");
          break;
      }
      self lander_take_off(call_box.destination);
    } else {
      play_sound_at_pos("no_purchase", self.origin);
      who maps\_zombiemode_audio::create_and_play_dialog("general", "no_money", undefined, 0);
      continue;
    }
    wait(.05);
  }
}
enable_callboxes() {
  call_boxes = getEntArray("zip_call_box", "targetname");
  lander = getent("lander", "targetname");
  for(j = 0; j < call_boxes.size; j++) {
    if(call_boxes[j].script_noteworthy != lander.station) {
      call_boxes[j] trigger_on();
      call_boxes[j] sethintstring(&"ZOMBIE_COSMODROME_LANDER_CALL");
    } else {
      call_boxes[j] trigger_on();
      call_boxes[j] sethintstring("");
      call_boxes[j] setcursorhint("HINT_NOICON");
    }
  }
}
new_lander_intro() {
  level.intro_lander = true;
  level thread lander_intro_think();
  lander = getent("lander", "targetname");
  north_pos = GetEnt("zipline_door_n_pos", "script_noteworthy");
  south_pos = GetEnt("zipline_door_s_pos", "script_noteworthy");
  lander.og_angles = lander.angles;
  north_pos.og_angles = north_pos.angles;
  south_pos.og_angles = south_pos.angles;
  thread close_lander_gate(0.05);
  flag_wait("all_players_connected");
  flag_wait("all_players_spawned");
  lander = getent("lander", "targetname");
  lander lock_players_intro();
  lander playLoopSound("zmb_lander_exhaust_loop");
  lander.sound_ent = spawn("script_origin", lander.origin);
  lander.sound_ent LinkTo(lander);
  lander.sound_ent playSound("zmb_lander_launch");
  lander.sound_ent playLoopSound("zmb_lander_flying_low_loop");
  lander_struct = getstruct("lander_station5", "targetname");
  spot1 = lander_struct.origin;
  wait(1.5);
  level thread lander_engine_fx();
  lander.anchor moveto(spot1, 8, 0.1, 7.9);
  level notify("lander_launched");
  ClientNotify("LL");
  lander.anchor waittill("movedone");
  level.intro_lander = false;
  lander DisconnectPaths();
  flag_set("lander_grounded");
  clientnotify("LG");
  level thread maps\zombie_cosmodrome_amb::play_cosmo_announcer_vox("vox_ann_startup");
  lander.sound_ent StopLoopSound(1);
  lander StopLoopSound(3);
  lander.sound_ent playSound("zmb_lander_land");
  open_lander_gate();
  unlock_players();
  level thread force_wait_for_gersh_line();
}
lander_intro_think() {
  trigger = GetEnt("zip_buy", "script_noteworthy");
  trigger setcursorhint("HINT_NOICON");
  flag_wait("lander_grounded");
  wait(15);
  init_buy();
}
lander_take_off(dest) {
  flag_clear("lander_grounded");
  flag_set("lander_takeoff");
  lander = getent("lander", "targetname");
  lander_lights_red();
  lander thread lock_players(dest);
  level notify("LU", lander.riders, self);
  lander.depart_station = lander.station;
  depart = getent(lander.station, "script_noteworthy");
  if(depart.target == "catwalk_zip_door") {
    ClientNotify("CW_O");
  } else if(depart.target == "base_entry_zip_door") {
    clientnotify("BE_O");
  } else if(depart.target == "centrifuge_zip_door") {
    clientnotify("CF_O");
  } else if(depart.target == "storage_zip_door") {
    clientnotify("S_O");
  }
  depart_door = getEntArray(depart.target, "targetname");
  for(i = 0; i < depart_door.size; i++) {
    depart_door[i] thread open_lander_door();
  }
  close_lander_gate();
  station = getstruct(lander.station, "targetname");
  hub = getstruct(station.target, "targetname");
  flag_clear("spawn_zombies");
  level thread lander_engine_fx();
  wait(1);
  if(lander.called == true) {
    lander.station = self.script_noteworthy;
  } else {
    lander.station = dest;
  }
  arrive = getent(lander.station, "script_noteworthy");
  if(isDefined(arrive.target)) {
    if(arrive.target == "catwalk_zip_door") {
      ClientNotify("CWD");
    } else if(arrive.target == "base_entry_zip_door") {
      clientnotify("BED");
    } else if(arrive.target == "centrifuge_zip_door") {
      clientnotify("CFD");
    } else if(arrive.target == "storage_zip_door") {
      clientnotify("SOD");
    }
    arrive_door = getEntArray(arrive.target, "targetname");
    for(i = 0; i < arrive_door.size; i++) {}
  }
  lander.sound_ent playSound("zmb_lander_launch");
  lander.sound_ent playLoopSound("zmb_lander_flying_low_loop");
  lander.anchor moveto(hub.origin, 3.0, 2, 1);
  lander.anchor thread lander_takeoff_wobble();
  level notify("lander_launched");
  flag_clear("lander_takeoff");
  wait(.1);
  ClientNotify("LL");
  wait(3);
  lander setclientflag(9);
  lander ConnectPaths();
  lander.anchor lander_hover_idle();
  if(isDefined(hub.target)) {
    extra_dest = getstruct(hub.target, "targetname");
    lander.anchor moveto(extra_dest.origin, 2.0);
    lander.anchor waittill("movedone");
  }
  call_box = getent(lander.station, "script_noteworthy");
  call_box playSound("vox_ann_lander_current_1");
  lander clearclientflag(9);
  lander_goto_dest();
}
lander_hover_idle() {
  num = self.angles[0] + randomintrange(-3, 3);
  num1 = self.angles[1] + randomintrange(-3, 3);
  self rotateto((num, num1, randomfloatrange(0, 5)), .5);
  self moveto((self.origin[0], self.origin[1], self.origin[2] + 20), .5, .1);
  wait(.5);
}
player_blocking_lander() {
  players = getplayers();
  lander = getent("lander", "targetname");
  rider_trigger = getent(lander.station + "_riders", "targetname");
  crumb = getstruct(rider_trigger.target, "targetname");
  for(i = 0; i < players.size; i++) {
    if(rider_trigger isTouching(players[i])) {
      players[i] setOrigin(crumb.origin + (RandomIntRange(-20, 20), RandomIntRange(-20, 20), 0));
      players[i] DoDamage(players[i].health + 10000, players[i].origin);
    }
  }
  zombies = getaispeciesarray("axis");
  for(i = 0; i < zombies.size; i++) {
    if(isDefined(zombies[i])) {
      if(rider_trigger isTouching(zombies[i])) {
        level.zombie_total++;
        playsoundatposition("nuked", zombies[i].origin);
        playFX(level._effect["zomb_gib"], zombies[i].origin);
        if(isDefined(zombies[i].lander_death)) {
          zombies[i][
            [zombies[i].lander_death]
          ]();
        }
        zombies[i] Delete();
      }
    }
  }
  wait(.5);
}
lock_players(destination) {
  lander = getent("lander", "targetname");
  lander.riders = 0;
  spots = getEntArray("zipline_spots", "script_noteworthy");
  taken = [];
  zipline_door1 = getent("zipline_door_n", "script_noteworthy");
  zipline_door2 = getent("zipline_door_s", "script_noteworthy");
  base = getent("lander_base", "script_noteworthy");
  ls_taken = [];
  rider_trigger = getent(lander.station + "_riders", "targetname");
  crumb = getstruct(rider_trigger.target, "targetname");
  lander thread takeoff_nuke(undefined, 80, 1, rider_trigger);
  lander thread takeoff_knockdown(81, 250);
  players = getplayers();
  lander_trig = getent("zip_buy", "script_noteworthy");
  x = 0;
  while(!flag("lander_grounded")) {
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      if(!rider_trigger isTouching(players[i]) && !players[i] istouching(zipline_door1) && !players[i] istouching(zipline_door2) && !players[i] istouching(base) && x < 8) {
        continue;
      }
      if(players[i] maps\_laststand::player_is_in_laststand()) {
        if(!isDefined(players[i].on_lander_last_stand) && distance(players[i].origin, base.origin) <= 196) {
          if(flag("lander_landing")) {
            continue;
          }
          lander.riders++;
          players[i].on_lander_last_stand = 1;
          max_dist = 196;
          grab = -1;
          for(j = 0; j < 4; j++) {
            if(is_true(ls_taken[j]) || is_true(taken[j])) {
              continue;
            }
            dist = distance(players[i].origin, spots[j].origin);
            if(dist < max_dist) {
              max_dist = dist;
              grab = j;
            }
          }
          ls_taken[grab] = 1;
          players[i] playerlinktodelta(spots[grab], undefined, 1, 180, 180, 180, 180, true);
          players[i].lander_link_spot = spots[grab];
          players[i] thread laststand_lander_link();
        }
        continue;
      }
      if(!players[i] isTouching(lander_trig)) {
        continue;
      }
      if(isDefined(players[i].lander) && players[i].lander) {
        continue;
      }
      max_dist = 10000;
      grab = -1;
      for(j = 0; j < 4; j++) {
        if(isDefined(taken[j]) && taken[j] == 1) {
          continue;
        }
        dist = distance2d(players[i].origin, spots[j].origin);
        if(dist < max_dist) {
          max_dist = dist;
          grab = j;
        }
      }
      taken[grab] = 1;
      players[i] playerlinktodelta(spots[grab], undefined, 1, 180, 180, 180, 180, true);
      players[i] enableinvulnerability();
      players[i] thread maps\_zombiemode::store_crumb(crumb.origin);
      players[i].lander = true;
      players[i].lander_link_spot = spots[grab];
      players[i].on_lander_last_stand = undefined;
      players[i] setclientflag(0);
      lander.riders++;
    }
    wait(.25);
    x++;
    if(x == 4) {
      if(lander.riders == players.size) {
        level thread activate_lander_poi(destination);
      }
    }
  }
}
laststand_lander_link() {
  self endon("death");
  self endon("disconnect");
  wait(1.1);
  self unlink();
}
lock_players_intro() {
  lander = getent("lander", "targetname");
  lander.riders = 0;
  spots = getEntArray("zipline_spots", "script_noteworthy");
  players = getplayers();
  taken = [];
  rider_trigger = getent("lander_in_sky_riders", "targetname");
  crumb = getstruct(rider_trigger.target, "targetname");
  for(i = 0; i < players.size; i++) {
    grab = -1;
    for(j = 0; j < 4; j++) {
      if(isDefined(taken[j]) && taken[j] == 1) {
        continue;
      }
      grab = j;
    }
    taken[grab] = 1;
    players[i] playerlinkto(spots[grab], undefined, 0.0, 180, 180, 180, 180, true);
    players[i] enableinvulnerability();
    players[i].lander = true;
    lander.riders++;
  }
}
unlock_players() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] unlink();
    players[i] disableinvulnerability();
    players[i].on_lander_last_stand = undefined;
    players[i] thread maps\_zombiemode::store_crumb(players[i].origin);
    players[i].lander = false;
  }
  lander = getent("lander", "targetname");
  if(isDefined(lander.driver) && lander.driver is_zombie()) {
    lander.driver unlink();
    lander.driver = undefined;
  }
}
lander_goto_dest() {
  level endon("intermission");
  lander = getent("lander", "targetname");
  final_dest = getstruct(lander.station, "targetname");
  arrive = getent(lander.station, "script_noteworthy");
  if(isDefined(final_dest.target)) {
    current_dest = getstruct(final_dest.target, "targetname");
    if(isDefined(current_dest.target)) {
      lander.anchor thread lander_flight_wobble(lander, final_dest);
      extra_dest = getstruct(current_dest.target, "targetname");
      lander.anchor moveto(extra_dest.origin, 5.0, 1);
      lander.anchor waittill("movedone");
      lander_clean_up_corpses(lander.anchor.origin, 150);
      lander.anchor moveto(current_dest.origin, 2.0, 0, 2);
      lander.anchor waittill("movedone");
    } else {
      lander.anchor thread lander_flight_wobble(lander, final_dest);
      lander.anchor moveto(current_dest.origin, 7.0, 1, 2.75);
      lander.anchor waittill("movedone");
    }
  }
  lander_clean_up_corpses(lander.anchor.origin, 150);
  flag_wait("lander_landing");
  movetime = 5;
  acceltime = .1;
  deceltime = 4.9;
  if(isDefined(arrive.target)) {
    if(arrive.target == "catwalk_zip_door") {
      ClientNotify("CW_C");
    } else if(arrive.target == "base_entry_zip_door") {
      movetime = 6;
      acceltime = .1;
      deceltime = 5.9;
      clientnotify("BE_C");
    } else if(arrive.target == "centrifuge_zip_door") {
      movetime = 7;
      acceltime = .1;
      deceltime = 6.9;
      clientnotify("CF_C");
    } else if(arrive.target == "storage_zip_door") {
      movetime = 6;
      acceltime = .1;
      deceltime = 5.9;
      clientnotify("S_C");
    }
  }
  arrive_door = getEntArray(arrive.target, "targetname");
  for(i = 0; i < arrive_door.size; i++) {
    arrive_door[i] thread close_lander_door(1.0);
  }
  lander.anchor moveto(final_dest.origin, movetime, acceltime, deceltime);
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i].lander) {
      players[i] clearclientflag(0);
    }
  }
  lander.anchor thread lander_landing_wobble(movetime);
  level thread player_blocking_lander();
  lander.anchor waittill("movedone");
  lander DisconnectPaths();
  lander.sound_ent StopLoopSound(1);
  lander StopLoopSound(3);
  playsoundatposition("zmb_lander_land", lander.origin);
  put_players_back_on_lander();
  flag_set("lander_grounded");
  flag_clear("lander_landing");
  ClientNotify("LG");
  flag_set("spawn_zombies");
  open_lander_gate();
  unlock_players();
  level.lander_in_use = false;
  lander.called = false;
  if(isDefined(arrive.target)) {
    switch (arrive.target) {
      case "catwalk_zip_door":
        ClientNotify("LACW");
        break;
      case "base_entry_zip_door":
        clientnotify("LABE");
        break;
      case "centrifuge_zip_door":
        clientnotify("LACF");
        break;
      case "storage_zip_door":
        clientnotify("LASS");
        break;
    }
  }
  if(flag("lander_a_used") && flag("lander_b_used") && flag("lander_c_used") && !flag("launch_activated")) {
    flag_set("launch_activated");
  }
}
lander_engine_fx() {
  lander_base = getent("lander_base", "script_noteworthy");
  lander_base setclientflag(1);
  lander_base setclientflag(7);
  flag_wait("lander_grounded");
  lander_base clearclientflag(7);
  wait(2.5);
  playFX(level._effect["lunar_lander_dust"], lander_base.origin);
  lander_base Clearclientflag(1);
}
takeoff_nuke(max_zombies, range, delay, trig) {
  if(isDefined(delay)) {
    wait(delay);
  }
  zombies = getaispeciesarray("axis");
  spot = self.origin;
  zombies = get_array_of_closest(self.origin, zombies, undefined, max_zombies, range);
  for(i = 0; i < zombies.size; i++) {
    if(!zombies[i] istouching(trig)) {
      continue;
    }
    zombies[i] thread zombie_burst();
  }
  wait(.5);
  lander_clean_up_corpses(spot, 250);
}
zombie_burst() {
  self endon("death");
  wait(randomfloatrange(0.2, 0.3));
  level.zombie_total++;
  playsoundatposition("nuked", self.origin);
  playFX(level._effect["zomb_gib"], self.origin);
  if(isDefined(self.lander_death)) {
    self[[self.lander_death]]();
  }
  self Delete();
}
takeoff_knockdown(min_range, max_range) {
  zombies = getaispeciesarray("axis");
  for(i = 0; i < zombies.size; i++) {
    dist = distancesquared(zombies[i].origin, self.origin);
    if(dist >= (min_range * min_range) && dist <= (max_range * max_range)) {
      zombies[i] thread zombie_knockdown();
    }
  }
}
zombie_knockdown() {
  self endon("death");
  wait(randomfloatrange(0.2, 0.3));
  self.lander_knockdown = 1;
  if(isDefined(self.thundergun_knockdown_func)) {
    self[[self.thundergun_knockdown_func]](self, false);
  }
  self.thundergun_handle_pain_notetracks = maps\_zombiemode_weap_thundergun::handle_thundergun_pain_notetracks;
  self DoDamage(1, self.origin);
}
lander_clean_up_corpses(spot, range) {
  corpses = GetCorpseArray();
  if(isDefined(corpses)) {
    for(i = 0; i < corpses.size; i++) {
      if(distancesquared(spot, corpses[i].origin) <= (range * range)) {
        corpses[i] thread lander_remove_corpses();
      }
    }
  }
}
lander_remove_corpses() {
  wait(randomfloatrange(0.05, .25));
  if(!isDefined(self)) {
    return;
  }
  playFX(level._effect["zomb_gib"], self.origin);
  self Delete();
}
lander_flight_wobble(lander, final_dest) {
  self thread lander_flight_stop_wobble();
  self endon("movedone");
  self endon("start_approach");
  first_time = true;
  rot_time = 0.75;
  while(1) {
    if(first_time) {
      rot_time = 1.75;
    }
    if(lander.depart_station == "lander_station5" && final_dest.targetname == "lander_station1") {
      self rotateto((randomfloatrange(345, 355), 0, randomfloatrange(0, 5)), rot_time);
    } else if(lander.depart_station == "lander_station1" && final_dest.targetname == "lander_station5") {
      self rotateto((randomfloatrange(370, 380), 0, randomfloatrange(-5, 0)), rot_time);
    } else if(lander.depart_station == "lander_station5" && final_dest.targetname == "lander_station4") {
      self rotateto((randomfloatrange(370, 380), 0, randomfloatrange(-5, 0)), rot_time);
    } else if(lander.depart_station == "lander_station4" && final_dest.targetname == "lander_station5") {
      self rotateto((randomfloatrange(345, 355), 0, randomfloatrange(0, 5)), rot_time);
    } else if(lander.depart_station == "lander_station5" && final_dest.targetname == "lander_station3") {
      self rotateto((randomfloatrange(5, 10), 0, randomfloatrange(-15, -10)), rot_time);
    } else if(lander.depart_station == "lander_station3" && final_dest.targetname == "lander_station5") {
      self rotateto((randomfloatrange(-10, -5), 0, randomfloatrange(10, 15)), rot_time);
    } else {
      self rotateto((randomfloatrange(-5, 5), 0, randomfloatrange(-5, 5)), rot_time);
    }
    wait(rot_time);
    if(first_time) {
      first_time = false;
    }
  }
}
lander_takeoff_wobble() {
  level endon("lander_launched");
  while(1) {
    self rotateto((randomfloatrange(-10, 10), 0, randomfloatrange(-10, 10)), .5);
    wait(.5);
  }
}
lander_landing_wobble(movetime) {
  time = movetime - 1;
  timer = gettime() + (time * 1000);
  while(gettime() < timer) {
    self rotateto((randomfloatrange(-5, 5), 0, randomfloatrange(-5, 5)), .75);
    wait(.75);
  }
  self rotateto((0, 0, 0), .75);
}
lander_flight_stop_wobble() {
  wait(3);
  self notify("start_approach");
  self.old_angles = self.angles;
  self rotateto((self.angles[0] * -1, self.angles[1] * -1, self.angles[2] * -1), 2.75);
  wait(3);
  self rotateto(self.old_angles, 2);
  flag_set("lander_landing");
}
lander_cooldown_think() {
  lander_use_trig = GetEnt("zip_buy", "script_noteworthy");
  lander_callboxes = getEntArray("zip_call_box", "targetname");
  lander = getent("lander", "targetname");
  while(1) {
    level waittill("LU", riders, trig);
    flag_set("lander_inuse");
    players = get_players();
    for(i = 0; i < players.size; i++) {
      lander_use_trig setinvisibletoplayer(players[i], true);
    }
    for(i = 0; i < lander_callboxes.size; i++) {
      if(lander_callboxes[i] == trig) {
        lander_callboxes[i] SetHintString(&"ZOMBIE_COSMODROME_LANDER_ON_WAY");
        lander_callboxes[i] setcursorhint("HINT_NOICON");
      } else {
        lander_callboxes[i] sethintstring(&"ZOMBIE_COSMODROME_LANDER_IN_USE");
        lander_callboxes[i] setcursorhint("HINT_NOICON");
      }
    }
    while(level.lander_in_use) {
      wait(.1);
    }
    flag_clear("lander_inuse");
    flag_set("lander_cooldown");
    cooldown = 3;
    str = &"ZOMBIE_COSMODROME_LANDER_COOLDOWN";
    if(riders != 0) {
      cooldown = 30;
      str = &"ZOMBIE_COSMODROME_LANDER_REFUEL";
      for(i = 0; i < lander_callboxes.size; i++) {
        lander_callboxes[i] playSound("vox_ann_lander_cooldown");
      }
      lander playSound("zmb_lander_pump_start");
      lander playLoopSound("zmb_lander_pump_loop", 1);
    }
    lander_use_trig SetHintString(str);
    players = get_players();
    for(i = 0; i < players.size; i++) {
      lander_use_trig setinvisibletoplayer(players[i], false);
    }
    for(i = 0; i < lander_callboxes.size; i++) {
      if(lander_callboxes[i].script_noteworthy != lander.station) {
        lander_callboxes[i] sethintstring(str);
      } else {
        lander_callboxes[i] sethintstring(&"ZOMBIE_COSMODROME_LANDER_AT_STATION");
        lander_callboxes[i] setcursorhint("HINT_NOICON");
      }
    }
    wait(cooldown);
    lander StopLoopSound(1.5);
    lander playSound("zmb_lander_pump_end");
    if(cooldown == 30) {
      for(i = 0; i < lander_callboxes.size; i++) {
        lander_callboxes[i] playSound("vox_ann_lander_ready");
      }
    }
    lander_lights_green();
    lander_use_trig SetHintString(&"ZOMBIE_COSMODROME_LANDER");
    players = get_players();
    for(i = 0; i < players.size; i++) {
      lander_use_trig setinvisibletoplayer(players[i], false);
    }
    for(i = 0; i < lander_callboxes.size; i++) {
      if(lander_callboxes[i].script_noteworthy != lander.station) {
        lander_callboxes[i] sethintstring(&"ZOMBIE_COSMODROME_LANDER_CALL");
      } else {
        lander_callboxes[i] sethintstring(&"ZOMBIE_COSMODROME_LANDER_AT_STATION");
        lander_callboxes[i] setcursorhint("HINT_NOICON");
      }
    }
    flag_clear("lander_cooldown");
  }
}
lander_lights_green() {
  clientnotify("L_G");
}
lander_lights_red() {
  clientnotify("L_R");
}
play_launch_unlock_vox() {
  while(1) {
    flag_wait("lander_grounded");
    if(flag("lander_a_used") && flag("lander_b_used") && flag("lander_c_used")) {
      level thread maps\zombie_cosmodrome_amb::play_cosmo_announcer_vox("vox_ann_landers_used");
      return;
    }
    wait(.05);
  }
}
force_wait_for_gersh_line() {
  wait(10);
  level thread maps\zombie_cosmodrome_eggs::play_egg_vox(undefined, "vox_gersh_egg_start", 0);
}
put_players_back_on_lander() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(!is_true(players[i].lander) && !is_true(players[i].on_lander_last_stand)) {
      continue;
    }
    if(!players[i] is_player_on_lander()) {
      if(isDefined(players[i].lander_link_spot)) {
        players[i] SetOrigin(players[i].lander_link_spot.origin);
        players[i] playSound("zmb_laugh_child");
      }
    }
  }
}
is_player_on_lander() {
  lander = getent("lander", "targetname");
  rider_trigger = getent(lander.station + "_riders", "targetname");
  lander_trig = getent("zip_buy", "script_noteworthy");
  base = getent("lander_base", "script_noteworthy");
  if(rider_trigger isTouching(self) || self istouching(lander_trig) || distance(self.origin, base.origin) < 200) {
    return true;
  }
  return false;
}