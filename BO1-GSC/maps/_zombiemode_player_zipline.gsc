/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_player_zipline.gsc
***********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;

main() {
  precache_zipline_assets();
  init_player_ziplines();
}

#using_animtree("zombie_coast");
precache_zipline_assets() {
  precachemodel("viewmodel_hands_no_model");
  level.zipline_anims = [];
  level.zipline_anims["zipline_grab"] = % pb_zombie_zipline_grab;
  level.zipline_anims["zipline_release"] = % pb_zombie_zipline_release;
  level.zipline_anims["zipline_loop"] = % pb_zombie_zipline_loop;
  level.zipline_animtree = #animtree;
}

init_player_ziplines() {
  zipline_vehicles = getentarray("zipline_vehicles", "script_noteworthy");
  zipline_trigs = getentarray("player_zipline", "targetname");
  array_thread(zipline_trigs, ::monitor_player_zipline, zipline_vehicles);
  flag_wait("all_players_spawned");
  players = get_players();
  array_thread(players, ::jump_button_monitor);
}

monitor_player_zipline(zipline_vehicles) {
  zip_path = self.target;
  targets = getentarray(self.target, "targetname");
  poi = undefined;
  for(i = 0; i < targets.size; i++) {
    if(targets[i].classname == "script_brushmodel" || targets[i].classname == "script_model") {
      assertex(isDefined(targets[i].script_string), "The zipline gate needs to have a script_string reference with one or more flag names seperated by spaces");
      zip_hint_trig = spawn("trigger_radius_use", targets[i].origin);
      zip_hint_trig SetCursorHint("HINT_NOICON");
      zip_hint_trig sethintstring(&"ZOMBIE_COAST_ZIPLINE_NO_ACCESS");
      zipline_flags = strTok(targets[i].script_string, " ");
      if(targets[i].targetname == "zipline_test1") {
        flag_wait("start_beach_group");
        flag_wait_any("shipfront_far_enter", "shipfront_deck_storage");
      } else {
        flag_wait_any_array(zipline_flags);
      }
      targets[i] ConnectPaths();
      zip_hint_trig delete();
      playfx(level._effect["poltergeist"], targets[i].origin);
      targets[i] thread move_delete_zipline_gate();
    } else if(targets[i].classname == "script_origin") {
      targets[i] create_zombie_point_of_interest(undefined, 30, 0, false);
      targets[i] thread create_zombie_point_of_interest_attractor_positions(4, 45);
      poi = targets[i];
    }
  }
  enemyoverride = [];
  enemyoverride[0] = poi.origin;
  enemyoverride[1] = poi;
  while(1) {
    self waittill("trigger", who);
    if(!isplayer(who)) {
      if(isDefined(who.is_ziplining)) {
        continue;
      }
      who.is_ziplining = true;
      if(who.team == "axis") {
        who playLoopSound("evt_zipline_slide", .5);
        who thread wait_to_end_looper();
        continue;
      }
      ai = getaiarray("axis");
      followers = [];
      for(i = 0; i < ai.size; i++) {
        if(isDefined(ai[i].favoriteenemy) && ai[i].favoriteenemy == who) {
          ai[i].enemyoverride = enemyoverride;
          ai[i].following_human_zombie = true;
          followers[followers.size] = ai[i];
        }
      }
      who thread wait_for_human_zombie_exit_zipline(followers);
      who thread reset_followers_on_death(followers);
      continue;
    }
    if(!who is_ok_to_zipline(zip_path)) {
      continue;
    }
    if(isDefined(who.is_ziplining)) {
      continue;
    }
    vehicle = get_zipline_vehicle(zipline_vehicles);
    if(isDefined(vehicle)) {
      who.is_ziplining = true;
      who thread do_player_zipline(vehicle, zip_path, self);
      players = get_players();
      ai = getaiarray("axis");
      followers = [];
      for(i = 0; i < ai.size; i++) {
        if(isDefined(ai[i].favoriteenemy) && ai[i].favoriteenemy == who) {
          ai[i].following_player_zipline = true;
          ai[i].enemyoverride = enemyoverride;
          followers[followers.size] = ai[i];
        }
      }
      who thread wait_for_player_to_disconnect(followers);
      who thread wait_for_player_exit_zipline(followers);
    }
  }
}

wait_to_end_looper() {
  self endon("death");
  self waittill("zombie_end_traverse");
  if(isDefined(self)) {
    self stopLoopSound(1);
  }
}

wait_for_player_to_disconnect(followers) {
  self endon("exit_zipline");
  self waittill("disconnect");
  for(i = 0; i < followers.size; i++) {
    if(isDefined(followers[i]) && isalive(followers[i])) {
      followers[i].following_player_zipline = undefined;
      followers[i].enemyoverride = undefined;
    }
  }
}

wait_for_player_exit_zipline(followers) {
  self endon("disconnect");
  self endon("death");
  self waittill("exit_zipline");
  for(i = 0; i < followers.size; i++) {
    if(isDefined(followers[i]) && isalive(followers[i])) {
      if(isDefined(followers[i].favoriteenemy) && followers[i].favoriteenemy == self) {
        followers[i].following_player_zipline = undefined;
        followers[i].enemyoverride = undefined;
      }
    }
  }
}

wait_for_human_zombie_exit_zipline(followers) {
  self endon("death");
  while(is_true(self.is_traversing)) {
    wait(.05);
  }
  self.is_ziplining = undefined;
  for(i = 0; i < followers.size; i++) {
    if(isDefined(followers[i]) && isalive(followers[i])) {
      if(isDefined(followers[i].favoriteenemy) && followers[i].favoriteenemy == self) {
        followers[i].following_human_zombie = undefined;
        followers[i].enemyoverride = undefined;
      }
    }
  }
}

reset_followers_on_death(followers) {
  self endon("zombie_end_traverse");
  self waittill("death");
  for(i = 0; i < followers.size; i++) {
    if(isDefined(followers[i]) && isalive(followers[i])) {
      if(isDefined(followers[i].favoriteenemy) && followers[i].favoriteenemy == self) {
        followers[i].following_human_zombie = undefined;
        followers[i].enemyoverride = undefined;
      }
    }
  }
}

is_ok_to_zipline(zip_path) {
  if(self maps\_laststand::player_is_in_laststand()) {
    return false;
  }
  weap = self getcurrentweapon();
  if(weap == "syrette_sp") {
    return false;
  }
  if(self getstance() == "stand" || is_true(self.divetoprone)) {
    if(!isDefined(self.jumptime)) {
      return false;
    }
    if(self jumpbuttonpressed() || (gettime() - self.jumptime <= 800) || is_true(self.divetoprone)) {
      return true;
    }
  }
  return false;
}

do_player_zipline(vehicle, zip_path, zip_trig) {
  self endon("disconnect");
  vehicle thread zipline_player_death_disconnect_failsafe(self);
  weaponname = self getcurrentweapon();
  if(is_placeable_mine(weaponname) || weaponname == "syrette_sp") {
    primaryWeapons = self GetWeaponsListPrimaries();
    if(isDefined(primaryWeapons) && primaryWeapons.size > 0) {
      self SwitchToWeapon(primaryWeapons[0]);
    }
  }
  self Allowstand(true);
  self allowcrouch(true);
  self EnableInvulnerability();
  vehicle attachpath(getvehiclenode(zip_path, "targetname"));
  wait_network_frame();
  has_perk = false;
  if(isDefined(self.perk_purchased)) {
    has_perk = true;
  }
  self player_enter_zipline(vehicle, zip_path);
  sound_ent = spawn("script_origin", self.origin);
  sound_ent linkto(self);
  sound_ent playLoopSound("evt_zipline_slide");
  sound_ent thread force_deletion_of_soundent(self, vehicle);
  vehicle startpath();
  wait(.5);
  self maps\_zombiemode_audio::create_and_play_dialog("general", "zipline");
  if(!has_perk) {
    weaponname = self getcurrentweapon();
    if(is_placeable_mine(weaponname) || weaponname == "syrette_sp") {
      primaryWeapons = self GetWeaponsListPrimaries();
      if(isDefined(primaryWeapons) && primaryWeapons.size > 0) {
        self SwitchToWeapon(primaryWeapons[0]);
      }
    }
    self setviewmodel("viewmodel_hands_no_model");
    self enableweapons();
  }
  end_node = get_zipline_end_node(zip_path);
  wait(.75);
  self EnableWeaponFire();
  while(distancesquared(vehicle.origin, end_node.origin) > (950 * 950)) {
    wait(.05);
  }
  self clearclientflag(level._CF_PLAYER_ZIPLINE_RUMBLE_QUAKE);
  vehicle waittill("reached_end_node");
  self thread player_exit_zipline(vehicle, zip_trig);
  if(isDefined(sound_ent)) {
    sound_ent delete();
  }
  wait(2);
  self.is_ziplining = undefined;
}

force_deletion_of_soundent(player, vehicle) {
  vehicle endon("reached_end_node");
  vehicle endon("player_unlinked");
  player waittill_any("death", "disconnect");
  self Delete();
}

zipline_player_death_disconnect_failsafe(player) {
  self endon("player_unlinked");
  player waittill_any("death", "disconnect");
  self unlink();
  self.in_use = undefined;
}

player_exit_zipline(vehicle, zip_trig) {
  vehicle.in_use = undefined;
  vehicle notify("player_unlinked");
  self DisableInvulnerability();
  self clearclientflag(level._CF_PLAYER_ZIPLINE_FAKE_PLAYER_SETUP);
  self move_to_safe_landing_spot(zip_trig, vehicle, self);
  self unlink();
  release_time = GetAnimLength(level.zipline_anims["zipline_release"]);
  self disableweapons();
  wait(release_time);
  self setloweredweapon(0);
  self Show();
  wait(1);
  self maps\zombie_coast::coast_custom_viewmodel_override();
  self enableweapons();
  self EnableWeaponReload();
  self notify("exit_zipline");
  self allowcrouch(true);
  self allowprone(true);
  wait(.1);
  Earthquake(RandomFloatRange(0.35, 0.45), RandomFloatRange(.25, .5), self.origin, 100);
  self.zipline_vehicle = undefined;
  self allowads(true);
  self allowsprint(true);
  self decrement_is_drinking();
  self allowmelee(true);
}

move_to_safe_landing_spot(zip_trig, vehicle, zipliner) {
  landing_spots = getstructarray(zip_trig.target, "targetname");
  if(landing_spots.size < 1) {
    return;
  }
  landing_spot_found = false;
  while(!landing_spot_found) {
    for(i = 0; i < landing_spots.size; i++) {
      if(zipliner_can_land_here(landing_spots[i].origin, zipliner)) {
        vehicle.origin = landing_spots[i].origin;
        landing_spot_found = true;
      }
    }
    wait(.05);
  }
}

zipliner_can_land_here(spot, zipliner) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i] == zipliner) {
      continue;
    }
    if(distancesquared(players[i].origin, spot) < 60 * 60) {
      return false;
    }
  }
  return true;
}

player_enter_zipline(vehicle, path_start) {
  self thread zombie_zipline_intersect_monitor();
  self setloweredweapon(1);
  self DisableWeaponFire();
  if(isDefined(self.perk_purchased)) {
    self thread monitor_perk_on_zipline();
  }
  self playerlinktodelta(vehicle, "tag_origin", .5, 180, 180, 180, 180);
  self.zipline_vehicle = vehicle;
  while(is_true(self.divetoprone)) {
    wait(.05);
  }
  self setclientflag(level._CF_PLAYER_ZIPLINE_RUMBLE_QUAKE);
  self setclientflag(level._CF_PLAYER_ZIPLINE_FAKE_PLAYER_SETUP);
  self allowsprint(false);
  if(!isDefined(self.perk_purchased)) {
    self allowmelee(false);
    self disableweapons();
    self DisableWeaponReload();
    self increment_is_drinking();
    self setstance("stand");
    self allowcrouch(false);
    self allowprone(false);
    self allowads(false);
  }
  self hide();
  wait_network_frame();
}

monitor_perk_on_zipline() {
  self endon("disconnect");
  while(isDefined(self.perk_purchased)) {
    wait(.05);
  }
  self DisableWeaponReload();
  self allowmelee(false);
  self increment_is_drinking();
  self setstance("stand");
  self allowcrouch(false);
  self allowprone(false);
  self allowads(false);
  self allowsprint(false);
  self setviewmodel("viewmodel_hands_no_model");
}

zombie_zipline_intersect_monitor() {
  self endon("exit_zipline");
  self endon("disconnect");
  while(1) {
    ai = getaiarray();
    for(i = 0; i < ai.size; i++) {
      if(!is_true(ai[i].is_traversing)) {
        continue;
      }
      if(is_true(ai[i].animname == "director_zombie")) {
        if(distancesquared(self.origin, ai[i].origin) < (100 * 100)) {
          if(isDefined(self.zipline_vehicle)) {
            speed = self.zipline_vehicle getspeedmph();
            if(speed - 5 > 0) {
              self.zipline_vehicle setspeed(speed - 5, .5);
            }
          }
        }
      }
      if(distancesquared(self.origin, ai[i].origin) < (18 * 18)) {
        ai[i] dodamage(ai[i].health + 100, ai[i].origin);
        level.zombie_total++;
      }
    }
    wait(.05);
  }
}

get_zipline_vehicle(vehicles) {
  for(i = 0; i < vehicles.size; i++) {
    if(!isDefined(vehicles[i].in_use)) {
      vehicles[i].in_use = true;
      return vehicles[i];
    }
  }
  return undefined;
}

get_zipline_end_node(start_path) {
  start_node = getvehiclenode(start_path, "targetname");
  while(1) {
    if(isDefined(start_node.target)) {
      next_node = getvehiclenode(start_node.target, "targetname");
      if(isDefined(next_node)) {
        start_node = next_node;
      }
    } else {
      return start_node;
    }
  }
}

flag_wait_any_array(flag_array) {
  flag_activated = false;
  while(!flag_activated) {
    for(i = 0; i < flag_array.size; i++) {
      if(flag(flag_array[i])) {
        flag_activated = true;
      }
    }
    wait(.1);
  }
}

jump_button_monitor() {
  level endon("intermission");
  self endon("disconnect");
  while(1) {
    if(self jumpbuttonpressed()) {
      self.jumptime = gettime();
    }
    wait(.1);
  }
}

move_delete_zipline_gate() {
  self notsolid();
  org = self.origin + (0, 0, 250);
  self play_sound_on_ent("debris_move");
  playsoundatposition("zmb_lightning_l", self.origin);
  num = RandomIntRange(3, 5);
  og_angles = self.angles;
  for(i = 0; i < num; i++) {
    angles = og_angles + (-5 + RandomFloat(10), -5 + RandomFloat(10), -5 + RandomFloat(10));
    time = RandomFloatRange(0.1, 0.4);
    self Rotateto(angles, time);
    wait(time - 0.05);
  }
  time = 1;
  self moveTo(org, time, time * 0.5);
  self RotateTo(self.angles + (randomintrange(-20, 20), randomintrange(-20, 20), randomintrange(-20, 20)), time * 0.75);
  self waittill("movedone");
  playsoundatposition("zmb_zombie_spawn", self.origin);
  playfx(level._effect["large_ceiling_dust"], self.origin);
  self Delete();
}