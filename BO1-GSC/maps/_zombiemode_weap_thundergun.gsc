/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_weap_thundergun.gsc
************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_net;
#using_animtree("generic_human");
init() {
  if(!maps\_zombiemode_weapons::is_weapon_included("thundergun_zm")) {
    return;
  }
  level._effect["thundergun_viewmodel_power_cell1"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view1");
  level._effect["thundergun_viewmodel_power_cell2"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view2");
  level._effect["thundergun_viewmodel_power_cell3"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view3");
  level._effect["thundergun_viewmodel_steam"] = loadfx("weapon/thunder_gun/fx_thundergun_steam_view");
  level._effect["thundergun_viewmodel_power_cell1_upgraded"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view1");
  level._effect["thundergun_viewmodel_power_cell2_upgraded"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view2");
  level._effect["thundergun_viewmodel_power_cell3_upgraded"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view3");
  level._effect["thundergun_viewmodel_steam_upgraded"] = loadfx("weapon/thunder_gun/fx_thundergun_steam_view");
  level._effect["thundergun_knockdown_ground"] = loadfx("weapon/thunder_gun/fx_thundergun_knockback_ground");
  level._effect["thundergun_smoke_cloud"] = loadfx("weapon/thunder_gun/fx_thundergun_smoke_cloud");
  set_zombie_var("thundergun_cylinder_radius", 180);
  set_zombie_var("thundergun_fling_range", 480);
  set_zombie_var("thundergun_gib_range", 900);
  set_zombie_var("thundergun_gib_damage", 75);
  set_zombie_var("thundergun_knockdown_range", 1200);
  set_zombie_var("thundergun_knockdown_damage", 15);
  level.thundergun_gib_refs = [];
  level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "guts";
  level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "right_arm";
  level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "left_arm";
  level thread thundergun_on_player_connect();
}

thundergun_on_player_connect() {
  for(;;) {
    level waittill("connecting", player);
    player thread wait_for_thundergun_fired();
  }
}

wait_for_thundergun_fired() {
  self endon("disconnect");
  self waittill("spawned_player");
  for(;;) {
    self waittill("weapon_fired");
    currentweapon = self GetCurrentWeapon();
    if((currentweapon == "thundergun_zm") || (currentweapon == "thundergun_upgraded_zm")) {
      self thread thundergun_fired();
      view_pos = self GetTagOrigin("tag_flash") - self GetPlayerViewHeight();
      view_angles = self GetTagAngles("tag_flash");
      playFX(level._effect["thundergun_smoke_cloud"], view_pos, anglesToForward(view_angles), AnglesToUp(view_angles));
    }
  }
}

thundergun_fired() {
  PhysicsExplosionCylinder(self.origin, 600, 240, 1);
  if(!isDefined(level.thundergun_knockdown_enemies)) {
    level.thundergun_knockdown_enemies = [];
    level.thundergun_knockdown_gib = [];
    level.thundergun_fling_enemies = [];
    level.thundergun_fling_vecs = [];
  }
  self thundergun_get_enemies_in_range();
  for(i = 0; i < level.thundergun_fling_enemies.size; i++) {
    level.thundergun_fling_enemies[i] thread thundergun_fling_zombie(self, level.thundergun_fling_vecs[i], i);
  }
  for(i = 0; i < level.thundergun_knockdown_enemies.size; i++) {
    level.thundergun_knockdown_enemies[i] thread thundergun_knockdown_zombie(self, level.thundergun_knockdown_gib[i]);
  }
  level.thundergun_knockdown_enemies = [];
  level.thundergun_knockdown_gib = [];
  level.thundergun_fling_enemies = [];
  level.thundergun_fling_vecs = [];
}

thundergun_get_enemies_in_range() {
  view_pos = self GetWeaponMuzzlePoint();
  zombies = get_array_of_closest(view_pos, GetAiSpeciesArray("axis", "all"), undefined, undefined, level.zombie_vars["thundergun_knockdown_range"]);
  if(!isDefined(zombies)) {
    return;
  }
  knockdown_range_squared = level.zombie_vars["thundergun_knockdown_range"] * level.zombie_vars["thundergun_knockdown_range"];
  gib_range_squared = level.zombie_vars["thundergun_gib_range"] * level.zombie_vars["thundergun_gib_range"];
  fling_range_squared = level.zombie_vars["thundergun_fling_range"] * level.zombie_vars["thundergun_fling_range"];
  cylinder_radius_squared = level.zombie_vars["thundergun_cylinder_radius"] * level.zombie_vars["thundergun_cylinder_radius"];
  forward_view_angles = self GetWeaponForwardDir();
  end_pos = view_pos + vector_scale(forward_view_angles, level.zombie_vars["thundergun_knockdown_range"]);
  for(i = 0; i < zombies.size; i++) {
    if(!isDefined(zombies[i]) || !IsAlive(zombies[i])) {
      continue;
    }
    test_origin = zombies[i] getcentroid();
    test_range_squared = distanceSquared(view_pos, test_origin);
    if(test_range_squared > knockdown_range_squared) {
      zombies[i] thundergun_debug_print("range", (1, 0, 0));
      return;
    }
    normal = VectorNormalize(test_origin - view_pos);
    dot = VectorDot(forward_view_angles, normal);
    if(0 > dot) {
      zombies[i] thundergun_debug_print("dot", (1, 0, 0));
      continue;
    }
    radial_origin = PointOnSegmentNearestToPoint(view_pos, end_pos, test_origin);
    if(distanceSquared(test_origin, radial_origin) > cylinder_radius_squared) {
      zombies[i] thundergun_debug_print("cylinder", (1, 0, 0));
      continue;
    }
    if(0 == zombies[i] DamageConeTrace(view_pos, self)) {
      zombies[i] thundergun_debug_print("cone", (1, 0, 0));
      continue;
    }
    if(test_range_squared < fling_range_squared) {
      level.thundergun_fling_enemies[level.thundergun_fling_enemies.size] = zombies[i];
      dist_mult = (fling_range_squared - test_range_squared) / fling_range_squared;
      fling_vec = VectorNormalize(test_origin - view_pos);
      if(5000 < test_range_squared) {
        fling_vec = fling_vec + VectorNormalize(test_origin - radial_origin);
      }
      fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
      fling_vec = vector_scale(fling_vec, 100 + 100 * dist_mult);
      level.thundergun_fling_vecs[level.thundergun_fling_vecs.size] = fling_vec;
      zombies[i] thread setup_thundergun_vox(self, true, false, false);
    } else if(test_range_squared < gib_range_squared) {
      level.thundergun_knockdown_enemies[level.thundergun_knockdown_enemies.size] = zombies[i];
      level.thundergun_knockdown_gib[level.thundergun_knockdown_gib.size] = true;
      zombies[i] thread setup_thundergun_vox(self, false, true, false);
    } else {
      level.thundergun_knockdown_enemies[level.thundergun_knockdown_enemies.size] = zombies[i];
      level.thundergun_knockdown_gib[level.thundergun_knockdown_gib.size] = false;
      zombies[i] thread setup_thundergun_vox(self, false, false, true);
    }
  }
}

thundergun_debug_print(msg, color) {}
thundergun_fling_zombie(player, fling_vec, index) {
  if(!isDefined(self) || !IsAlive(self)) {
    return;
  }
  if(isDefined(self.thundergun_fling_func)) {
    self[[self.thundergun_fling_func]](player);
    return;
  }
  self DoDamage(self.health + 666, player.origin, player);
  if(self.health <= 0) {
    points = 10;
    if(!index) {
      points = maps\_zombiemode_score::get_zombie_death_player_points();
    } else if(1 == index) {
      points = 30;
    }
    player maps\_zombiemode_score::player_add_points("thundergun_fling", points);
    self StartRagdoll();
    self LaunchRagdoll(fling_vec);
    self.thundergun_death = true;
  }
}

thundergun_knockdown_zombie(player, gib) {
  self endon("death");
  playsoundatposition("vox_thundergun_forcehit", self.origin);
  if(!isDefined(self) || !IsAlive(self)) {
    return;
  }
  if(isDefined(self.thundergun_knockdown_func)) {
    self[[self.thundergun_knockdown_func]](player, gib);
  } else {
    self DoDamage(level.zombie_vars["thundergun_knockdown_damage"], player.origin, player);
  }
  if(gib) {
    self.a.gib_ref = random(level.thundergun_gib_refs);
    self thread animscripts\zombie_death::do_gib();
  }
  self.thundergun_handle_pain_notetracks = ::handle_thundergun_pain_notetracks;
  self DoDamage(level.zombie_vars["thundergun_knockdown_damage"], player.origin, player);
}

handle_thundergun_pain_notetracks(note) {
  if(note == "zombie_knockdown_ground_impact") {
    playFX(level._effect["thundergun_knockdown_ground"], self.origin, anglesToForward(self.angles), AnglesToUp(self.angles));
    self playSound("fly_thundergun_forcehit");
  }
}

is_thundergun_damage() {
  return isDefined(self.damageweapon) && (self.damageweapon == "thundergun_zm" || self.damageweapon == "thundergun_upgraded_zm");
}

enemy_killed_by_thundergun() {
  return (isDefined(self.thundergun_death) && self.thundergun_death == true);
}

thundergun_sound_thread() {
  self endon("disconnect");
  self waittill("spawned_player");
  for(;;) {
    result = self waittill_any_return("grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback");
    if(!isDefined(result)) {
      continue;
    }
    if((result == "weapon_change" || result == "grenade_fire") && self GetCurrentWeapon() == "thundergun_zm") {
      self playLoopSound("tesla_idle", 0.25);
    } else {
      self notify("weap_away");
      self stopLoopSound(0.25);
    }
  }
}

setup_thundergun_vox(player, fling, gib, knockdown) {
  if(!isDefined(self) || !IsAlive(self)) {
    return;
  }
  if(!fling && (gib || knockdown)) {
    if(25 > RandomIntRange(1, 100)) {}
  }
  if(fling) {
    if(30 > RandomIntRange(1, 100)) {
      player maps\_zombiemode_audio::create_and_play_dialog("kill", "thundergun");
    }
  }
}