/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_thundergun.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_weap_thundergun;

function autoexec __init__sytem__() {
  system::register("zm_weap_thundergun", & __init__, & __main__, undefined);
}

function __init__() {
  level.weaponzmthundergun = getweapon("thundergun");
  level.weaponzmthundergunupgraded = getweapon("thundergun_upgraded");
}

function __main__() {
  level._effect["thundergun_knockdown_ground"] = "zombie/fx_thundergun_knockback_ground";
  level._effect["thundergun_smoke_cloud"] = "zombie/fx_thundergun_smoke_cloud";
  zombie_utility::set_zombie_var("thundergun_cylinder_radius", 180);
  zombie_utility::set_zombie_var("thundergun_fling_range", 480);
  zombie_utility::set_zombie_var("thundergun_gib_range", 900);
  zombie_utility::set_zombie_var("thundergun_gib_damage", 75);
  zombie_utility::set_zombie_var("thundergun_knockdown_range", 1200);
  zombie_utility::set_zombie_var("thundergun_knockdown_damage", 15);
  level.thundergun_gib_refs = [];
  level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "guts";
  level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "right_arm";
  level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "left_arm";
  level.basic_zombie_thundergun_knockdown = & zombie_knockdown;
  if(!isdefined(level.override_thundergun_damage_func)) {
    level.override_thundergun_damage_func = & override_thundergun_damage_func;
  }
  level thread thundergun_devgui_dvar_think();
  callback::on_connect( & thundergun_on_player_connect);
}

function thundergun_devgui_dvar_think() {
  if(!zm_weapons::is_weapon_included(level.weaponzmthundergun)) {
    return;
  }
  setdvar("", level.zombie_vars[""]);
  setdvar("", level.zombie_vars[""]);
  setdvar("", level.zombie_vars[""]);
  setdvar("", level.zombie_vars[""]);
  setdvar("", level.zombie_vars[""]);
  setdvar("", level.zombie_vars[""]);
  for (;;) {
    level.zombie_vars[""] = getdvarint("");
    level.zombie_vars[""] = getdvarint("");
    level.zombie_vars[""] = getdvarint("");
    level.zombie_vars[""] = getdvarint("");
    level.zombie_vars[""] = getdvarint("");
    level.zombie_vars[""] = getdvarint("");
    wait(0.5);
  }
}

function thundergun_on_player_connect() {
  self thread wait_for_thundergun_fired();
}

function wait_for_thundergun_fired() {
  self endon("disconnect");
  self waittill("spawned_player");
  for (;;) {
    self waittill("weapon_fired");
    currentweapon = self getcurrentweapon();
    if(currentweapon == level.weaponzmthundergun || currentweapon == level.weaponzmthundergunupgraded) {
      self thread thundergun_fired();
      view_pos = self gettagorigin("tag_flash") - self getplayerviewheight();
      view_angles = self gettagangles("tag_flash");
      playfx(level._effect["thundergun_smoke_cloud"], view_pos, anglestoforward(view_angles), anglestoup(view_angles));
    }
  }
}

function thundergun_network_choke() {
  level.thundergun_network_choke_count++;
  if(!level.thundergun_network_choke_count % 10) {
    util::wait_network_frame();
    util::wait_network_frame();
    util::wait_network_frame();
  }
}

function thundergun_fired() {
  physicsexplosioncylinder(self.origin, 600, 240, 1);
  self thread thundergun_affect_ais();
}

function thundergun_affect_ais() {
  if(!isdefined(level.thundergun_knockdown_enemies)) {
    level.thundergun_knockdown_enemies = [];
    level.thundergun_knockdown_gib = [];
    level.thundergun_fling_enemies = [];
    level.thundergun_fling_vecs = [];
  }
  self thundergun_get_enemies_in_range();
  level.thundergun_network_choke_count = 0;
  for (i = 0; i < level.thundergun_fling_enemies.size; i++) {
    level.thundergun_fling_enemies[i] thread thundergun_fling_zombie(self, level.thundergun_fling_vecs[i], i);
  }
  for (i = 0; i < level.thundergun_knockdown_enemies.size; i++) {
    level.thundergun_knockdown_enemies[i] thread thundergun_knockdown_zombie(self, level.thundergun_knockdown_gib[i]);
  }
  level.thundergun_knockdown_enemies = [];
  level.thundergun_knockdown_gib = [];
  level.thundergun_fling_enemies = [];
  level.thundergun_fling_vecs = [];
}

function thundergun_get_enemies_in_range() {
  view_pos = self getweaponmuzzlepoint();
  zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, level.zombie_vars["thundergun_knockdown_range"]);
  if(!isdefined(zombies)) {
    return;
  }
  knockdown_range_squared = level.zombie_vars["thundergun_knockdown_range"] * level.zombie_vars["thundergun_knockdown_range"];
  gib_range_squared = level.zombie_vars["thundergun_gib_range"] * level.zombie_vars["thundergun_gib_range"];
  fling_range_squared = level.zombie_vars["thundergun_fling_range"] * level.zombie_vars["thundergun_fling_range"];
  cylinder_radius_squared = level.zombie_vars["thundergun_cylinder_radius"] * level.zombie_vars["thundergun_cylinder_radius"];
  forward_view_angles = self getweaponforwarddir();
  end_pos = view_pos + vectorscale(forward_view_angles, level.zombie_vars["thundergun_knockdown_range"]);
  if(2 == getdvarint("")) {
    near_circle_pos = view_pos + vectorscale(forward_view_angles, 2);
    circle(near_circle_pos, level.zombie_vars[""], (1, 0, 0), 0, 0, 100);
    line(near_circle_pos, end_pos, (0, 0, 1), 1, 0, 100);
    circle(end_pos, level.zombie_vars[""], (1, 0, 0), 0, 0, 100);
  }
  for (i = 0; i < zombies.size; i++) {
    if(!isdefined(zombies[i]) || !isalive(zombies[i])) {
      continue;
    }
    test_origin = zombies[i] getcentroid();
    test_range_squared = distancesquared(view_pos, test_origin);
    if(test_range_squared > knockdown_range_squared) {
      zombies[i] thundergun_debug_print("range", (1, 0, 0));
      return;
    }
    normal = vectornormalize(test_origin - view_pos);
    dot = vectordot(forward_view_angles, normal);
    if(0 > dot) {
      zombies[i] thundergun_debug_print("dot", (1, 0, 0));
      continue;
    }
    radial_origin = pointonsegmentnearesttopoint(view_pos, end_pos, test_origin);
    if(distancesquared(test_origin, radial_origin) > cylinder_radius_squared) {
      zombies[i] thundergun_debug_print("cylinder", (1, 0, 0));
      continue;
    }
    if(0 == zombies[i] damageconetrace(view_pos, self)) {
      zombies[i] thundergun_debug_print("cone", (1, 0, 0));
      continue;
    }
    if(test_range_squared < fling_range_squared) {
      level.thundergun_fling_enemies[level.thundergun_fling_enemies.size] = zombies[i];
      dist_mult = (fling_range_squared - test_range_squared) / fling_range_squared;
      fling_vec = vectornormalize(test_origin - view_pos);
      if(5000 < test_range_squared) {
        fling_vec = fling_vec + (vectornormalize(test_origin - radial_origin));
      }
      fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
      fling_vec = vectorscale(fling_vec, 100 + (100 * dist_mult));
      level.thundergun_fling_vecs[level.thundergun_fling_vecs.size] = fling_vec;
      zombies[i] thread setup_thundergun_vox(self, 1, 0, 0);
      continue;
    }
    if(test_range_squared < gib_range_squared) {
      level.thundergun_knockdown_enemies[level.thundergun_knockdown_enemies.size] = zombies[i];
      level.thundergun_knockdown_gib[level.thundergun_knockdown_gib.size] = 1;
      zombies[i] thread setup_thundergun_vox(self, 0, 1, 0);
      continue;
    }
    level.thundergun_knockdown_enemies[level.thundergun_knockdown_enemies.size] = zombies[i];
    level.thundergun_knockdown_gib[level.thundergun_knockdown_gib.size] = 0;
    zombies[i] thread setup_thundergun_vox(self, 0, 0, 1);
  }
}

function thundergun_debug_print(msg, color) {
  if(!getdvarint("")) {
    return;
  }
  if(!isdefined(color)) {
    color = (1, 1, 1);
  }
  print3d(self.origin + vectorscale((0, 0, 1), 60), msg, color, 1, 1, 40);
}

function thundergun_fling_zombie(player, fling_vec, index) {
  if(!isdefined(self) || !isalive(self)) {
    return;
  }
  if(isdefined(self.thundergun_fling_func)) {
    self[[self.thundergun_fling_func]](player);
    return;
  }
  self.deathpoints_already_given = 1;
  self dodamage(self.health + 666, player.origin, player);
  if(self.health <= 0) {
    if(isdefined(player) && isdefined(level.hero_power_update)) {
      level thread[[level.hero_power_update]](player, self);
    }
    points = 10;
    if(!index) {
      points = zm_score::get_zombie_death_player_points();
    } else if(1 == index) {
      points = 30;
    }
    player zm_score::player_add_points("thundergun_fling", points);
    self startragdoll();
    self launchragdoll(fling_vec);
    self.thundergun_death = 1;
  }
}

function zombie_knockdown(player, gib) {
  if(gib && !self.gibbed) {
    self.a.gib_ref = array::random(level.thundergun_gib_refs);
    self thread zombie_death::do_gib();
  }
  if(isdefined(level.override_thundergun_damage_func)) {
    self[[level.override_thundergun_damage_func]](player, gib);
  } else {
    damage = level.zombie_vars["thundergun_knockdown_damage"];
    self playsound("fly_thundergun_forcehit");
    self.thundergun_handle_pain_notetracks = & handle_thundergun_pain_notetracks;
    self dodamage(damage, player.origin, player);
    self animcustom( & playthundergunpainanim);
  }
}

function playthundergunpainanim() {
  self notify("end_play_thundergun_pain_anim");
  self endon("killanimscript");
  self endon("death");
  self endon("end_play_thundergun_pain_anim");
  if(isdefined(self.marked_for_death) && self.marked_for_death) {
    return;
  }
  if(self.damageyaw <= -135 || self.damageyaw >= 135) {
    if(self.missinglegs) {
      fallanim = "zm_thundergun_fall_front_crawl";
    } else {
      fallanim = "zm_thundergun_fall_front";
    }
    getupanim = "zm_thundergun_getup_belly_early";
  } else {
    if(self.damageyaw > -135 && self.damageyaw < -45) {
      fallanim = "zm_thundergun_fall_left";
      getupanim = "zm_thundergun_getup_belly_early";
    } else {
      if(self.damageyaw > 45 && self.damageyaw < 135) {
        fallanim = "zm_thundergun_fall_right";
        getupanim = "zm_thundergun_getup_belly_early";
      } else {
        fallanim = "zm_thundergun_fall_back";
        if(randomint(100) < 50) {
          getupanim = "zm_thundergun_getup_back_early";
        } else {
          getupanim = "zm_thundergun_getup_back_late";
        }
      }
    }
  }
  self setanimstatefromasd(fallanim);
  self zombie_shared::donotetracks("thundergun_fall_anim", self.thundergun_handle_pain_notetracks);
  if(!isdefined(self) || !isalive(self) || self.missinglegs || (isdefined(self.marked_for_death) && self.marked_for_death)) {
    return;
  }
  self setanimstatefromasd(getupanim);
  self zombie_shared::donotetracks("thundergun_getup_anim");
}

function thundergun_knockdown_zombie(player, gib) {
  self endon("death");
  playsoundatposition("wpn_thundergun_proj_impact", self.origin);
  if(!isdefined(self) || !isalive(self)) {
    return;
  }
  if(isdefined(self.thundergun_knockdown_func)) {
    self[[self.thundergun_knockdown_func]](player, gib);
  }
}

function handle_thundergun_pain_notetracks(note) {
  if(note == "zombie_knockdown_ground_impact") {
    playfx(level._effect["thundergun_knockdown_ground"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
    self playsound("fly_thundergun_forcehit");
  }
}

function is_thundergun_damage() {
  return self.damageweapon == level.weaponzmthundergun || self.damageweapon == level.weaponzmthundergunupgraded && (self.damagemod != "MOD_GRENADE" && self.damagemod != "MOD_GRENADE_SPLASH");
}

function enemy_killed_by_thundergun() {
  return isdefined(self.thundergun_death) && self.thundergun_death;
}

function thundergun_sound_thread() {
  self endon("disconnect");
  self waittill("spawned_player");
  for (;;) {
    result = self util::waittill_any_return("grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback", "disconnect");
    if(!isdefined(result)) {
      continue;
    }
    if(result == "weapon_change" || result == "grenade_fire" && self getcurrentweapon() == level.weaponzmthundergun) {
      self playloopsound("tesla_idle", 0.25);
      continue;
    }
    self notify("weap_away");
    self stoploopsound(0.25);
  }
}

function setup_thundergun_vox(player, fling, gib, knockdown) {
  if(!isdefined(self) || !isalive(self)) {
    return;
  }
  if(!fling && (gib || knockdown)) {}
  if(fling) {
    if(30 > randomintrange(1, 100)) {
      player zm_audio::create_and_play_dialog("kill", "thundergun");
    }
  }
}

function override_thundergun_damage_func(player, gib) {
  self zombie_utility::setup_zombie_knockdown(player);
}