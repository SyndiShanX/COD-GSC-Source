/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombiemode_weap_black_hole_bomb\.csc
**************************************************************/

#include clientscripts\_utility;
#include clientscripts\_music;
#include clientscripts\_zombiemode_weapons;
#include clientscripts\_zombiemode;

init() {
  if(getDvar(#"createfx") == "on") {
    return;
  }
  if(!clientscripts\_zombiemode_weapons::is_weapon_included("zombie_black_hole_bomb")) {
    return;
  }
  level._effect["black_hole_bomb_portal"] = LoadFX("maps/zombie/fx_zmb_blackhole_looping");
  level._effect["black_hole_bomb_event_horizon"] = LoadFX("maps/zombie/fx_zmb_blackhole_implode");
  level._effect["black_hole_bomb_marker_flare"] = LoadFX("maps/zombie/fx_zmb_blackhole_flare_marker");
  level._effect["black_hole_bomb_zombie_pull"] = LoadFX("maps/zombie/fx_blackhole_zombie_breakup");
  level._current_black_hole_bombs = [];
  level._visionset_black_hole_bomb = "zombie_black_hole";
  level._visionset_black_hole_bomb_transition_time_in = 2.0;
  level._visionset_black_hole_bomb_transition_time_out = 1.0;
  level._visionset_black_hole_bomb_priority = 10;
  level._SCRIPTMOVER_CLIENT_FLAG_BLACKHOLE = 10;
  register_clientflag_callback("scriptmover", level._SCRIPTMOVER_CLIENT_FLAG_BLACKHOLE, ::black_hole_deployed);
  level._ACTOR_CLIENT_FLAG_BLACKHOLE = 10;
  register_clientflag_callback("actor", level._ACTOR_CLIENT_FLAG_BLACKHOLE, ::black_hole_zombie_being_pulled);
  OnPlayerConnect_Callback(::black_hole_on_player_connect);
  OnPlayerSpawned_Callback(::black_hole_on_player_spawned);
  level thread black_hole_visionset_think();
}
black_hole_on_player_connect(int_local_client_num) {
  self endon("disconnect");
  while(!ClientHasSnapshot(int_local_client_num)) {
    wait 0.05;
  }
  if(int_local_client_num != 0) {
    return;
  }
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    players[i]._curr_black_hole_dist = 100000 * 100000;
    players[i]._last_black_hole_dist = 100000 * 100000;
  }
}
black_hole_on_player_spawned(int_local_client_num) {
  self endon("disconnect");
  while(!self hasdobj(int_local_client_num)) {
    wait(0.05);
  }
  if(int_local_client_num != 0) {
    return;
  }
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    if(!isDefined(players[i]._curr_black_hole_dist)) {
      players[i]._curr_black_hole_dist = 100000 * 100000;
    } else if(!isDefined(players[i]._last_black_hole_dist)) {
      players[i]._last_black_hole_dist = 100000 * 100000;
    }
  }
}
black_hole_deployed(local_client_num, int_set, ent_new) {
  if(local_client_num != 0) {
    return;
  }
  players = GetLocalPlayers();
  for(i = 0; i < players.size; i++) {
    level thread black_hole_fx_start(i, self);
    level thread black_hole_activated(self, i);
  }
}
black_hole_fx_start(local_client_num, ent_bomb) {
  bomb_fx_spot = spawn(local_client_num, ent_bomb.origin, "script_model");
  bomb_fx_spot setModel("tag_origin");
  playFXOnTag(local_client_num, level._effect["black_hole_bomb_portal"], bomb_fx_spot, "tag_origin");
  playFXOnTag(local_client_num, level._effect["black_hole_bomb_marker_flare"], bomb_fx_spot, "tag_origin");
  ent_bomb waittill("entityshutdown");
  event_horizon_spot = spawn(local_client_num, bomb_fx_spot.origin, "script_model");
  event_horizon_spot setModel("tag_origin");
  bomb_fx_spot Delete();
  playFXOnTag(local_client_num, level._effect["black_hole_bomb_event_horizon"], event_horizon_spot, "tag_origin");
  wait(0.2);
  event_horizon_spot Delete();
}
black_hole_visionset_switch(str_switch, flt_transition_time, int_local_client_num) {
  self endon("disconnect");
  self endon("death");
  if(!isDefined(flt_transition_time)) {
    flt_transition_time = 2.0;
  }
  if(self IsSpectating()) {
    return;
  }
  switch (str_switch) {
    case "inside_bh":
      self zombie_vision_set_apply(level._visionset_black_hole_bomb, level._visionset_black_hole_bomb_priority, level._visionset_black_hole_bomb_transition_time_in, int_local_client_num);
      break;
    case "outside_bh":
      self zombie_vision_set_remove(level._visionset_black_hole_bomb, level._visionset_black_hole_bomb_transition_time_in, int_local_client_num);
      break;
    default:
      self zombie_vision_set_remove(undefined, level._visionset_black_hole_bomb_transition_time_out, int_local_client_num);
      break;
  }
}
black_hole_visionset_think() {
  flt_black_hole_vision_transition_time = 0;
  min_black_hole_dist = 512 * 512;
  self._visionset_think_running = 1;
  temp_array = [];
  while(isDefined(level._current_black_hole_bombs)) {
    players = GetLocalPlayers();
    for(i = 0; i < players.size; i++) {
      players[i]._curr_black_hole_dist = 100000 * 100000;
    }
    self._curr_black_hole_dist = 100000 * 100000;
    if(level._current_black_hole_bombs.size == 0) {
      players = GetLocalPlayers();
      for(i = 0; i < players.size; i++) {
        players[i] black_hole_visionset_switch("default", 2.0, i);
      }
    } else {
      players = GetLocalPlayers();
      for(i = 0; i < players.size; i++) {
        struct_closest_black_hole = players[i] get_closest_black_hole();
        players[i] black_hole_vision_set(min_black_hole_dist, flt_black_hole_vision_transition_time, struct_closest_black_hole, i);
        players[i]._last_black_hole_dist = players[i]._curr_black_hole_dist;
      }
    }
    temp_array = level._current_black_hole_bombs;
    for(i = 0; i < temp_array.size; i++) {
      if(isDefined(temp_array[i]._black_hole_active) && temp_array[i]._black_hole_active == 0) {
        level._current_black_hole_bombs = array_remove(level._current_black_hole_bombs, temp_array[i]);
      }
    }
    wait(0.1);
    temp_array = [];
  }
}
get_closest_black_hole() {
  self endon("disconnect");
  self endon("death");
  struct_closest_black_hole = undefined;
  for(i = 0; i < level._current_black_hole_bombs.size; i++) {
    curr_dist = DistanceSquared(level._current_black_hole_bombs[i].origin, self.origin);
    if(curr_dist < self._curr_black_hole_dist) {
      self._curr_black_hole_dist = curr_dist;
      struct_closest_black_hole = level._current_black_hole_bombs[i];
    }
  }
  return struct_closest_black_hole;
}
black_hole_vision_set(min_black_hole_dist, flt_transition_time, struct_closest_black_hole, int_local_client_num) {
  self endon("disconnect");
  self endon("death");
  set_dist = self._curr_black_hole_dist;
  if(set_dist < min_black_hole_dist) {
    trace = bulletTrace(self getEye(), struct_closest_black_hole.origin, false, self);
    if(trace["fraction"] > 0.85 && struct_closest_black_hole._black_hole_active == 1) {
      self black_hole_visionset_switch("inside_bh", flt_transition_time, int_local_client_num);
    } else {
      self black_hole_visionset_switch("outside_bh", flt_transition_time, int_local_client_num);
    }
  } else if(set_dist > min_black_hole_dist) {
    self black_hole_visionset_switch("outside_bh", flt_transition_time, int_local_client_num);
  }
}
black_hole_activated(ent_model, int_local_client_num) {
  new_black_hole_struct = spawnStruct();
  new_black_hole_struct.origin = ent_model.origin;
  new_black_hole_struct._black_hole_active = 1;
  level._current_black_hole_bombs = add_to_array(level._cosmodrome_black_hole_bombs, new_black_hole_struct);
  ent_model waittill("entityshutdown");
  new_black_hole_struct._black_hole_active = 0;
  wait(0.2);
}
black_hole_zombie_being_pulled(local_client_num, int_set, actor_new) {
  self endon("death");
  self endon("entityshutdown");
  if(local_client_num != 0) {
    return;
  }
  if(int_set) {
    self._bhb_pulled_in_fx = spawn(local_client_num, self.origin, "script_model");
    self._bhb_pulled_in_fx.angles = self.angles;
    self._bhb_pulled_in_fx LinkTo(self, "tag_origin");
    self._bhb_pulled_in_fx setModel("tag_origin");
    level thread black_hole_bomb_pulled_in_fx_clean(self, self._bhb_pulled_in_fx);
    players = GetLocalPlayers();
    for(i = 0; i < players.size; i++) {
      playFXOnTag(i, level._effect["black_hole_bomb_zombie_pull"], self._bhb_pulled_in_fx, "tag_origin");
    }
  } else {
    if(isDefined(self._bhb_pulled_in_fx)) {
      self._bhb_pulled_in_fx notify("no_clean_up_needed");
      self._bhb_pulled_in_fx Unlink();
      self._bhb_pulled_in_fx Delete();
    }
  }
}
black_hole_bomb_pulled_in_fx_clean(ent_zombie, ent_fx_origin) {
  ent_fx_origin endon("no_clean_up_needed");
  if(!isDefined(ent_zombie)) {
    return;
  }
  ent_zombie waittill("entityshutdown");
  if(isDefined(ent_fx_origin)) {
    ent_fx_origin Delete();
  }
}