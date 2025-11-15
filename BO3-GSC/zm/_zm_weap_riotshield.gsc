/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_riotshield.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace riotshield;

function autoexec __init__sytem__() {
  system::register("zm_equip_riotshield", & __init__, & __main__, undefined);
}

function __init__() {
  if(!isDefined(level.weaponriotshield)) {
    level.weaponriotshield = getweapon("riotshield");
  }
  clientfield::register("clientuimodel", "zmInventory.shield_health", 11000, 4, "float");
  zombie_utility::set_zombie_var("riotshield_cylinder_radius", 360);
  zombie_utility::set_zombie_var("riotshield_fling_range", 90);
  zombie_utility::set_zombie_var("riotshield_gib_range", 90);
  zombie_utility::set_zombie_var("riotshield_gib_damage", 75);
  zombie_utility::set_zombie_var("riotshield_knockdown_range", 90);
  zombie_utility::set_zombie_var("riotshield_knockdown_damage", 15);
  zombie_utility::set_zombie_var("riotshield_fling_force_melee", 100);
  zombie_utility::set_zombie_var("riotshield_hit_points", 1850);
  zombie_utility::set_zombie_var("riotshield_fling_damage_shield", 100);
  zombie_utility::set_zombie_var("riotshield_knockdown_damage_shield", 15);
  zombie_utility::set_zombie_var("riotshield_juke_damage_shield", 100);
  zombie_utility::set_zombie_var("riotshield_stowed_block_fraction", 1);
  level.riotshield_network_choke_count = 0;
  level.riotshield_gib_refs = [];
  level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "guts";
  level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "right_arm";
  level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "left_arm";
  zm::register_player_damage_callback( & player_damage_override_callback);
  if(!isDefined(level.riotshield_melee)) {
    level.riotshield_melee = & riotshield_melee;
  }
  if(!isDefined(level.riotshield_melee_power)) {
    level.riotshield_melee_power = & riotshield_melee;
  }
  if(!isDefined(level.riotshield_damage_callback)) {
    level.riotshield_damage_callback = & player_damage_shield;
  }
  if(!isDefined(level.should_shield_absorb_damage)) {
    level.should_shield_absorb_damage = & should_shield_absorb_damage;
  }
  callback::on_connect( & on_player_connect);
}

function __main__() {}

function on_player_connect() {
  self.player_shield_reset_health = & player_init_shield_health;
  if(!isDefined(self.player_shield_apply_damage)) {
    self.player_shield_apply_damage = & player_damage_shield;
  }
  self thread player_watch_weapon_change();
  self thread player_watch_shield_melee();
  self thread player_watch_shield_melee_power();
}

function player_init_shield_health() {
  self updateriotshieldmodel();
  self clientfield::set_player_uimodel("zmInventory.shield_health", 1);
  return true;
}

function player_set_shield_health(damage, max_damage) {
  self updateriotshieldmodel();
  self clientfield::set_player_uimodel("zmInventory.shield_health", damage / max_damage);
}

function player_shield_absorb_damage(eattacker, idamage, shitloc, smeansofdeath) {}

function player_shield_facing_attacker(vdir, limit) {
  orientation = self getplayerangles();
  forwardvec = anglesToForward(orientation);
  forwardvec2d = (forwardvec[0], forwardvec[1], 0);
  unitforwardvec2d = vectornormalize(forwardvec2d);
  tofaceevec = vdir * -1;
  tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
  unittofaceevec2d = vectornormalize(tofaceevec2d);
  dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
  return dotproduct > limit;
}

function should_shield_absorb_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(isDefined(self.hasriotshield) && self.hasriotshield && isDefined(vdir)) {
    if(isDefined(eattacker) && (isDefined(eattacker.is_zombie) && eattacker.is_zombie || isplayer(eattacker))) {
      if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped) {
        if(self player_shield_facing_attacker(vdir, 0.2)) {
          return 1;
        }
      } else {
        if(!isDefined(self.riotshieldentity)) {
          if(!self player_shield_facing_attacker(vdir, -0.2)) {
            return level.zombie_vars["riotshield_stowed_block_fraction"];
          }
        } else {
          assert(!isDefined(self.riotshieldentity), "");
        }
      }
    }
  }
  return 0;
}

function player_damage_override_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  friendly_fire = isDefined(eattacker) && eattacker.team === self.team;
  if(isDefined(self.hasriotshield) && self.hasriotshield && !friendly_fire) {
    fblockfraction = self[[level.should_shield_absorb_damage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    if(fblockfraction > 0 && isDefined(self.player_shield_apply_damage)) {
      iblocked = int(fblockfraction * idamage);
      iunblocked = idamage - iblocked;
      if(isDefined(self.player_shield_apply_damage)) {
        self[[self.player_shield_apply_damage]](iblocked, 0, shitloc == "riotshield", smeansofdeath);
        if(isDefined(self.riotshield_damage_absorb_callback)) {
          self[[self.riotshield_damage_absorb_callback]](eattacker, iblocked, shitloc, smeansofdeath);
        }
      }
      return iunblocked;
    }
  }
  return -1;
}

function player_damage_shield(idamage, bheld, fromcode = 0, smod = "MOD_UNKNOWN") {
  damagemax = level.weaponriotshield.weaponstarthitpoints;
  if(isDefined(self.weaponriotshield)) {
    damagemax = self.weaponriotshield.weaponstarthitpoints;
  }
  shieldhealth = damagemax;
  shielddamage = idamage;
  rumbled = 0;
  if(fromcode) {
    shielddamage = 0;
  }
  shieldhealth = self damageriotshield(shielddamage);
  if(shieldhealth <= 0) {
    if(!rumbled) {
      self playrumbleonentity("damage_heavy");
      earthquake(1, 0.75, self.origin, 100);
    }
    self thread player_take_riotshield();
  } else {
    if(!rumbled) {
      self playrumbleonentity("damage_light");
      earthquake(0.5, 0.5, self.origin, 100);
    }
    self playSound("fly_riotshield_zm_impact_zombies");
  }
  self updateriotshieldmodel();
  self clientfield::set_player_uimodel("zmInventory.shield_health", shieldhealth / damagemax);
}

function player_watch_weapon_change() {
  for(;;) {
    self waittill("weapon_change", weapon);
    self updateriotshieldmodel();
  }
}

function player_watch_shield_melee() {
  for(;;) {
    self waittill("weapon_melee", weapon);
    if(weapon.isriotshield) {
      self[[level.riotshield_melee]](weapon);
    }
  }
}

function player_watch_shield_melee_power() {
  for(;;) {
    self waittill("weapon_melee_power", weapon);
    if(weapon.isriotshield) {
      self[[level.riotshield_melee_power]](weapon);
    }
  }
}

function riotshield_fling_zombie(player, fling_vec, index) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.ignore_riotshield) && self.ignore_riotshield) {
    return;
  }
  if(isDefined(self.riotshield_fling_func)) {
    self[[self.riotshield_fling_func]](player);
    return;
  }
  damage = 2500;
  self dodamage(damage, player.origin, player, player, "", "MOD_IMPACT");
  if(self.health < 1) {
    self.riotshield_death = 1;
    self startragdoll(1);
    self launchragdoll(fling_vec);
  }
}

function zombie_knockdown(player, gib) {
  damage = level.zombie_vars["riotshield_knockdown_damage"];
  if(isDefined(level.override_riotshield_damage_func)) {
    self[[level.override_riotshield_damage_func]](player, gib);
  } else {
    if(gib) {
      self.a.gib_ref = array::random(level.riotshield_gib_refs);
      self thread zombie_death::do_gib();
    }
    self dodamage(damage, player.origin, player);
  }
}

function riotshield_knockdown_zombie(player, gib) {
  self endon("death");
  playsoundatposition("vox_riotshield_forcehit", self.origin);
  playsoundatposition("wpn_riotshield_proj_impact", self.origin);
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.riotshield_knockdown_func)) {
    self[[self.riotshield_knockdown_func]](player, gib);
  } else {
    self zombie_knockdown(player, gib);
  }
  self dodamage(level.zombie_vars["riotshield_knockdown_damage"], player.origin, player);
  self playSound("fly_riotshield_forcehit");
}

function riotshield_get_enemies_in_range() {
  view_pos = self getEye();
  zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, 2 * level.zombie_vars["riotshield_knockdown_range"]);
  if(!isDefined(zombies)) {
    return;
  }
  knockdown_range_squared = level.zombie_vars["riotshield_knockdown_range"] * level.zombie_vars["riotshield_knockdown_range"];
  gib_range_squared = level.zombie_vars["riotshield_gib_range"] * level.zombie_vars["riotshield_gib_range"];
  fling_range_squared = level.zombie_vars["riotshield_fling_range"] * level.zombie_vars["riotshield_fling_range"];
  cylinder_radius_squared = level.zombie_vars["riotshield_cylinder_radius"] * level.zombie_vars["riotshield_cylinder_radius"];
  fling_force = level.zombie_vars["riotshield_fling_force_melee"];
  fling_force_v = 0.5;
  forward_view_angles = self getweaponforwarddir();
  end_pos = view_pos + vectorscale(forward_view_angles, level.zombie_vars["riotshield_knockdown_range"]);
  if(2 == getdvarint("")) {
    near_circle_pos = view_pos + vectorscale(forward_view_angles, 2);
    circle(near_circle_pos, level.zombie_vars[""], (1, 0, 0), 0, 0, 100);
    line(near_circle_pos, end_pos, (0, 0, 1), 1, 0, 100);
    circle(end_pos, level.zombie_vars[""], (1, 0, 0), 0, 0, 100);
  }
  for(i = 0; i < zombies.size; i++) {
    if(!isDefined(zombies[i]) || !isalive(zombies[i])) {
      continue;
    }
    if(zombies[i].archetype == "margwa") {
      continue;
    }
    test_origin = zombies[i] getcentroid();
    test_range_squared = distancesquared(view_pos, test_origin);
    if(test_range_squared > knockdown_range_squared) {
      return;
    }
    normal = vectornormalize(test_origin - view_pos);
    dot = vectordot(forward_view_angles, normal);
    if(0 > dot) {
      continue;
    }
    radial_origin = pointonsegmentnearesttopoint(view_pos, end_pos, test_origin);
    if(distancesquared(test_origin, radial_origin) > cylinder_radius_squared) {
      continue;
    }
    if(0 == zombies[i] damageconetrace(view_pos, self)) {
      continue;
    }
    if(test_range_squared < fling_range_squared) {
      level.riotshield_fling_enemies[level.riotshield_fling_enemies.size] = zombies[i];
      dist_mult = (fling_range_squared - test_range_squared) / fling_range_squared;
      fling_vec = vectornormalize(test_origin - view_pos);
      if(5000 < test_range_squared) {
        fling_vec = fling_vec + (vectornormalize(test_origin - radial_origin));
      }
      fling_vec = (fling_vec[0], fling_vec[1], fling_force_v * abs(fling_vec[2]));
      fling_vec = vectorscale(fling_vec, fling_force + (fling_force * dist_mult));
      level.riotshield_fling_vecs[level.riotshield_fling_vecs.size] = fling_vec;
      continue;
    }
    level.riotshield_knockdown_enemies[level.riotshield_knockdown_enemies.size] = zombies[i];
    level.riotshield_knockdown_gib[level.riotshield_knockdown_gib.size] = 0;
  }
}

function riotshield_network_choke() {
  level.riotshield_network_choke_count++;
  if(!level.riotshield_network_choke_count % 10) {
    util::wait_network_frame();
    util::wait_network_frame();
    util::wait_network_frame();
  }
}

function riotshield_melee(weapon) {
  if(!isDefined(level.riotshield_knockdown_enemies)) {
    level.riotshield_knockdown_enemies = [];
    level.riotshield_knockdown_gib = [];
    level.riotshield_fling_enemies = [];
    level.riotshield_fling_vecs = [];
  }
  self riotshield_get_enemies_in_range();
  shield_damage = 0;
  level.riotshield_network_choke_count = 0;
  for(i = 0; i < level.riotshield_fling_enemies.size; i++) {
    riotshield_network_choke();
    if(isDefined(level.riotshield_fling_enemies[i])) {
      level.riotshield_fling_enemies[i] thread riotshield_fling_zombie(self, level.riotshield_fling_vecs[i], i);
      shield_damage = shield_damage + level.zombie_vars["riotshield_fling_damage_shield"];
    }
  }
  for(i = 0; i < level.riotshield_knockdown_enemies.size; i++) {
    riotshield_network_choke();
    level.riotshield_knockdown_enemies[i] thread riotshield_knockdown_zombie(self, level.riotshield_knockdown_gib[i]);
    shield_damage = shield_damage + level.zombie_vars["riotshield_knockdown_damage_shield"];
  }
  level.riotshield_knockdown_enemies = [];
  level.riotshield_knockdown_gib = [];
  level.riotshield_fling_enemies = [];
  level.riotshield_fling_vecs = [];
  if(shield_damage) {
    self player_damage_shield(shield_damage, 0);
  }
}

function updateriotshieldmodel() {
  wait(0.05);
  self.hasriotshield = 0;
  self.weaponriotshield = level.weaponnone;
  foreach(weapon in self getweaponslist(1)) {
    if(weapon.isriotshield) {
      self.hasriotshield = 1;
      self.weaponriotshield = weapon;
    }
  }
  current = self getcurrentweapon();
  self.hasriotshieldequipped = current.isriotshield;
  if(self.hasriotshield) {
    self clientfield::set_player_uimodel("hudItems.showDpadDown", 1);
    if(self.hasriotshieldequipped) {
      self zm_weapons::clear_stowed_weapon();
    } else {
      self zm_weapons::set_stowed_weapon(self.weaponriotshield);
    }
  } else {
    self clientfield::set_player_uimodel("hudItems.showDpadDown", 0);
    self setstowedweapon(level.weaponnone);
  }
  self refreshshieldattachment();
}

function player_take_riotshield() {
  self notify("destroy_riotshield");
  current = self getcurrentweapon();
  if(current.isriotshield) {
    if(!self laststand::player_is_in_laststand()) {
      new_primary = level.weaponnone;
      primaryweapons = self getweaponslistprimaries();
      for(i = 0; i < primaryweapons.size; i++) {
        if(!primaryweapons[i].isriotshield) {
          new_primary = primaryweapons[i];
          break;
        }
      }
      if(new_primary == level.weaponnone) {
        self zm_weapons::give_fallback_weapon();
        self switchtoweaponimmediate();
        self playSound("wpn_riotshield_zm_destroy");
      } else {
        self switchtoweaponimmediate();
        self playSound("wpn_riotshield_zm_destroy");
        self waittill("weapon_change");
      }
    }
  }
  self playSound("zmb_rocketshield_break");
  if(isDefined(self.weaponriotshield)) {
    self zm_equipment::take(self.weaponriotshield);
  } else {
    self zm_equipment::take(level.weaponriotshield);
  }
  self.hasriotshield = 0;
  self.hasriotshieldequipped = 0;
}