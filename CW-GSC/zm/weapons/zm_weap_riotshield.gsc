/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_riotshield.gsc
***********************************************/

#using script_301f64a4090c381a;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_weapons;
#namespace riotshield;

function private autoexec __init__system__() {
  system::register(#"zm_equip_riotshield", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  if(!isDefined(level.weaponriotshield)) {
    level.weaponriotshield = getweapon(#"riotshield");
  }

  clientfield::register("toplayer", "zm_shield_damage_rumble", 1, 1, "counter");
  clientfield::register("toplayer", "zm_shield_break_rumble", 1, 1, "counter");
  clientfield::register_clientuimodel("ZMInventoryPersonal.shield_health", 1, 4, "float");
  zombie_utility::set_zombie_var(#"riotshield_cylinder_radius", 360);
  zombie_utility::set_zombie_var(#"riotshield_fling_range", 90);
  zombie_utility::set_zombie_var(#"riotshield_gib_range", 90);
  zombie_utility::set_zombie_var(#"riotshield_gib_damage", 75);
  zombie_utility::set_zombie_var(#"riotshield_knockdown_range", 90);
  zombie_utility::set_zombie_var(#"riotshield_fling_force_melee", 100);
  zombie_utility::set_zombie_var(#"riotshield_fling_damage_shield", 50);
  zombie_utility::set_zombie_var(#"hash_6835f7c5524585f3", 50);
  zombie_utility::set_zombie_var(#"hash_bfdf728041b626a", 120);
  zombie_utility::set_zombie_var(#"riotshield_knockdown_damage_shield", 200);
  zombie_utility::set_zombie_var(#"riotshield_stowed_block_fraction", 1);
  level.riotshield_gib_refs = [];
  level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "guts";
  level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "right_arm";
  level.riotshield_gib_refs[level.riotshield_gib_refs.size] = "left_arm";
  zm_player::function_57301eaf(&player_damage_override_callback);

  if(!isDefined(level.riotshield_melee)) {
    level.riotshield_melee = &riotshield_melee;
  }

  if(!isDefined(level.riotshield_melee_power)) {
    level.riotshield_melee_power = &riotshield_melee;
  }

  if(!isDefined(level.riotshield_damage_callback)) {
    level.riotshield_damage_callback = &player_damage_shield;
  }

  if(!isDefined(level.should_shield_absorb_damage)) {
    level.should_shield_absorb_damage = &should_shield_absorb_damage;
  }

  if(!isDefined(level.callbackplayershielddamageblocked)) {
    level.callbackplayershielddamageblocked = &callback_playershielddamageblocked;
  }

  if(!isDefined(level.var_2677b8bb)) {
    level.var_2677b8bb = new throttle();
    [[level.var_2677b8bb]] - > initialize(4, 0.1);
  }

  callback::on_connect(&on_player_connect);
  zm::register_actor_damage_callback(&function_4aa5e0c7);
}

function private postinit() {
  level thread function_d987f765();
}

function on_player_connect() {
  self.player_shield_reset_health = &player_init_shield_health;

  if(!isDefined(self.player_shield_apply_damage)) {
    self.player_shield_apply_damage = &player_damage_shield;
  }

  self thread player_watch_weapon_change();
  self thread player_watch_shield_melee();
  self thread player_watch_shield_melee_power();
}

function player_init_shield_health(weapon, var_cd9d17e0 = 0) {
  self endon(#"disconnect");

  if(!isDefined(weapon)) {
    weapon = level.weaponriotshield;

    if(isDefined(self.weaponriotshield)) {
      weapon = self.weaponriotshield;
    }
  }

  switch (zm_custom::function_901b751c(#"zmshielddurability")) {
    case 0:
      level.var_7bcfc873 = 2;
      break;
    case 2:
      level.var_7bcfc873 = 0.5;
      break;
    case 1:
    default:
      level.var_7bcfc873 = 1;
      break;
  }

  var_2aaf6cdb = zombie_utility::get_zombie_var(#"hash_cc85b961f25c2ff");

  if(isDefined(var_2aaf6cdb)) {
    level.var_7bcfc873 *= var_2aaf6cdb;
  }

  damagemax = int(weapon.weaponstarthitpoints);
  shieldhealth = self damageriotshield(0);
  shieldhealth = self damageriotshield(shieldhealth - damagemax);
  self updateriotshieldmodel();
  self clientfield::set_player_uimodel("ZMInventoryPersonal.shield_health", 1);
  n_current_health = self damageriotshield(0);

  if(n_current_health < damagemax) {
    self.var_d3345483 = 1;
  } else {
    self.var_d3345483 = undefined;
  }

  if(var_cd9d17e0) {
    self givemaxammo(weapon);
  }

  return true;
}

function player_set_shield_health(damage, max_damage) {
  self endon(#"disconnect");
  self updateriotshieldmodel();
  val = 0;

  if(max_damage) {
    val = damage / max_damage;
  }

  self clientfield::set_player_uimodel("ZMInventoryPersonal.shield_health", val);
}

function function_d987f765() {
  level endon(#"game_ended");

  while(true) {
    s_waitresult = level waittill(#"carpenter_started");

    if(zm_powerups::function_cfd04802(#"carpenter") && isPlayer(s_waitresult.var_264cf1f9)) {
      if(is_true(s_waitresult.var_264cf1f9.hasriotshield) && isDefined(s_waitresult.var_264cf1f9.player_shield_reset_health)) {
        s_waitresult.var_264cf1f9[[s_waitresult.var_264cf1f9.player_shield_reset_health]]();
      }

      continue;
    }

    players = getplayers();

    foreach(e_player in players) {
      if(isDefined(e_player) && is_true(e_player.hasriotshield) && isDefined(e_player.player_shield_reset_health)) {
        e_player[[e_player.player_shield_reset_health]]();
      }
    }
  }
}

function player_shield_absorb_damage(eattacker, idamage, shitloc, smeansofdeath) {}

function callback_playershielddamageblocked(damage) {}

function player_shield_facing_attacker(vdir, limit, attacker) {
  orientation = self getplayerangles();
  forwardvec = anglesToForward(orientation);
  forwardvec2d = (forwardvec[0], forwardvec[1], 0);
  unitforwardvec2d = vectornormalize(forwardvec2d);
  tofaceevec = attacker.origin - self.origin;
  tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
  unittofaceevec2d = vectornormalize(tofaceevec2d);
  dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
  return dotproduct > limit;
}

function should_shield_absorb_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(is_true(self.hasriotshield) && isDefined(psoffsettime)) {
    if(isDefined(shitloc) && issentient(shitloc)) {
      if(is_true(self.hasriotshieldequipped)) {
        if(self hasperk(#"specialty_shield") || self player_shield_facing_attacker(psoffsettime, 0.2, shitloc)) {
          return 1;
        }
      } else if(!isDefined(self.riotshieldentity)) {
        if(!self player_shield_facing_attacker(psoffsettime, -0.2, shitloc)) {
          return zombie_utility::get_zombie_var(#"riotshield_stowed_block_fraction");
        }
      } else {
        assert(!isDefined(self.riotshieldentity), "<dev string:x38>");
      }
    }
  }

  return 0;
}

function player_damage_override_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  friendly_fire = isDefined(eattacker) && eattacker.team === self.team;

  if(is_true(self.hasriotshield) && !friendly_fire) {
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

function player_damage_shield(idamage, bheld, fromcode, smod = 0, var_4e0da269 = 1) {
  self endon(#"disconnect");

  if(!isDefined(self.var_9c2026aa)) {
    self.var_9c2026aa = 0;
  }

  if(!isDefined(fromcode)) {
    fromcode = 0;
  }

  if(!isDefined(level.var_7bcfc873)) {
    level.var_7bcfc873 = 1;
  }

  if(isDefined(self.weaponriotshield)) {
    damagemax = self.weaponriotshield.weaponstarthitpoints;
    weapon = self.weaponriotshield;
  } else {
    damagemax = level.weaponriotshield.weaponstarthitpoints;
    weapon = level.weaponriotshield;
  }

  shieldhealth = damagemax;
  var_4d0cca6e = self function_d24e0d61();
  shielddamage = fromcode * level.var_7bcfc873 * var_4d0cca6e;
  shielddamage = int(max(shielddamage, 1));

  if(smod) {
    shielddamage = 0;
  }

  shieldhealth = self damageriotshield(shielddamage);
  self.var_d3345483 = 1;

  if(shieldhealth <= 0) {
    if(isDefined(self.var_27aeb716)) {
      self thread[[self.var_27aeb716]](weapon);
    }

    self clientfield::increment_to_player("zm_shield_break_rumble");
    self thread zm_audio::create_and_play_dialog(#"shield", #"destroy");
    self thread player_take_riotshield();
  } else {
    if(var_4e0da269) {
      self clientfield::increment_to_player("zm_shield_damage_rumble");
      self playSound(#"fly_riotshield_zm_impact_zombies");
    }

    self updateriotshieldmodel();
  }

  if(damagemax > 0) {
    self clientfield::set_player_uimodel("ZMInventoryPersonal.shield_health", shieldhealth / damagemax);
  }
}

function function_d24e0d61() {
  var_41f4ea3c = self.var_9c2026aa + namespace_e38c57c1::function_cbf286b0();
  return 1 - var_41f4ea3c;
}

function function_4aa5e0c7(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(surfacetype.isriotshield && boneindex != "MOD_MELEE" && boneindex != "MOD_IMPACT" && boneindex != "MOD_ELECTROCUTED") {
    var_754eb193 = psoffsettime + psoffsettime * 0.2 * math::clamp(level.round_number - 10, 0, 20);
    return var_754eb193;
  }

  return -1;
}

function player_watch_weapon_change() {
  self endon(#"disconnect");

  for(;;) {
    self waittill(#"weapon_change");
    self updateriotshieldmodel();
    damagemax = level.weaponriotshield.weaponstarthitpoints;

    if(isDefined(self.weaponriotshield) && self.weaponriotshield != level.weaponnone) {
      damagemax = self.weaponriotshield.weaponstarthitpoints;
    }

    shieldhealth = self.weaponhealth;
    val = 0;

    if(damagemax) {
      val = shieldhealth / damagemax;
    }

    self clientfield::set_player_uimodel("ZMInventoryPersonal.shield_health", val);
  }
}

function player_watch_shield_melee() {
  self endon(#"disconnect");

  for(;;) {
    waitresult = self waittill(#"weapon_melee");

    if(waitresult.weapon.isriotshield) {
      self[[level.riotshield_melee]](waitresult.weapon);
    }
  }
}

function player_watch_shield_melee_power() {
  self endon(#"disconnect");

  for(;;) {
    waitresult = self waittill(#"weapon_melee_power");

    if(waitresult.weapon.isriotshield) {
      self[[level.riotshield_melee_power]](waitresult.weapon);
    }
  }
}

function riotshield_fling_zombie(player, fling_vec, index) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(is_true(self.ignore_riotshield)) {
    return;
  }

  if(isDefined(self.var_9c1f60e8)) {
    self[[self.var_9c1f60e8]](fling_vec);
    return;
  }

  self dodamage(3000, fling_vec.origin, fling_vec, fling_vec, "", "MOD_IMPACT");

  if(self.health < 1 || fling_vec zm_powerups::is_insta_kill_active()) {
    self startragdoll(1);
    self launchragdoll(index);
  }
}

function riotshield_knockdown_zombie(player, gib, weapon) {
  self endon(#"death");
  playsoundatposition(#"vox_riotshield_forcehit", self.origin);
  playsoundatposition(#"wpn_riotshield_proj_impact", self.origin);

  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(self.archetype === # "brutus") {
    self ai::stun();
  } else {
    self zombie_utility::setup_zombie_knockdown(player);
  }

  if(gib) {
    self.a.gib_ref = array::random(level.riotshield_gib_refs);
    self thread zombie_death::do_gib();
  }

  self dodamage(3000, player.origin, player, undefined, "none", "MOD_IMPACT", 0, weapon);
  self playSound(#"fly_riotshield_forcehit");
}

function riotshield_get_enemies_in_range(riotshield_knockdown_range, riotshield_gib_range, riotshield_fling_range, var_1c3d89, riotshield_cylinder_radius, riotshield_fling_force_melee) {
  view_pos = self getEye();
  var_25e2354 = function_4d8c71ce();
  var_72714481 = getaispeciesarray(level.zombie_team, "all");
  a_e_targets = arraycombine(var_72714481, var_25e2354, 0, 0);

  if(!isDefined(riotshield_knockdown_range)) {
    riotshield_knockdown_range = zombie_utility::get_zombie_var(#"riotshield_knockdown_range");
  }

  a_e_targets = array::get_all_closest(view_pos, a_e_targets, undefined, undefined, 2 * zombie_utility::get_zombie_var(#"riotshield_knockdown_range"));

  if(!isDefined(a_e_targets)) {
    return;
  }

  knockdown_range_squared = riotshield_knockdown_range * riotshield_knockdown_range;

  if(!isDefined(riotshield_gib_range)) {
    riotshield_gib_range = zombie_utility::get_zombie_var(#"riotshield_gib_range");
  }

  gib_range_squared = riotshield_gib_range * riotshield_gib_range;

  if(!isDefined(riotshield_fling_range)) {
    riotshield_fling_range = zombie_utility::get_zombie_var(#"riotshield_fling_range");
  }

  fling_range_squared = riotshield_fling_range * riotshield_fling_range;

  if(!isDefined(riotshield_cylinder_radius)) {
    riotshield_cylinder_radius = zombie_utility::get_zombie_var(#"riotshield_cylinder_radius");
  }

  cylinder_radius_squared = riotshield_cylinder_radius * riotshield_cylinder_radius;

  if(!isDefined(var_1c3d89)) {
    var_1c3d89 = zombie_utility::get_zombie_var(#"riotshield_cylinder_radius");
  }

  var_8f9e26e4 = var_1c3d89 * var_1c3d89;
  var_606a8462 = riotshield_knockdown_range > riotshield_fling_range;

  if(!isDefined(riotshield_fling_force_melee)) {
    riotshield_fling_force_melee = zombie_utility::get_zombie_var(#"riotshield_fling_force_melee");
  }

  fling_force = riotshield_fling_force_melee;
  fling_force_v = 0.5;
  forward_view_angles = self getweaponforwarddir();
  end_pos = view_pos + vectorscale(forward_view_angles, riotshield_knockdown_range);

  if(2 == getdvarint(#"scr_riotshield_debug", 0)) {
    near_circle_pos = view_pos + vectorscale(forward_view_angles, 2);
    circle(near_circle_pos, riotshield_cylinder_radius, (1, 0, 0), 0, 0, 300);
    line(near_circle_pos, end_pos, (0, 0, 1), 1, 0, 100);
    circle(end_pos, riotshield_cylinder_radius, (1, 0, 0), 0, 0, 300);
  }

  foreach(e_target in a_e_targets) {
    if(!isalive(e_target) || !isDefined(e_target.zm_ai_category)) {
      continue;
    }

    test_origin = e_target getcentroid();
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

    if(distancesquared(test_origin, radial_origin) > var_8f9e26e4) {
      continue;
    }

    if(0 == e_target damageconetrace(view_pos, self)) {
      continue;
    }

    switch (e_target.zm_ai_category) {
      case # "normal":
        if(test_range_squared < fling_range_squared) {
          if(distancesquared(test_origin, radial_origin) > cylinder_radius_squared) {
            break;
          }

          level.riotshield_fling_enemies[level.riotshield_fling_enemies.size] = e_target;
          dist_mult = (fling_range_squared - test_range_squared) / fling_range_squared;
          fling_vec = vectornormalize(test_origin - view_pos);

          if(5000 < test_range_squared) {
            fling_vec += vectornormalize(test_origin - radial_origin);
          }

          fling_vec = (fling_vec[0], fling_vec[1], fling_force_v * abs(fling_vec[2]));
          fling_vec = vectorscale(fling_vec, fling_force + fling_force * dist_mult);
          level.riotshield_fling_vecs[level.riotshield_fling_vecs.size] = fling_vec;
        } else if(var_606a8462 && test_range_squared < knockdown_range_squared) {
          if(distancesquared(test_origin, radial_origin) > var_8f9e26e4) {
            break;
          }

          level.riotshield_knockdown_enemies[level.riotshield_knockdown_enemies.size] = e_target;

          if(var_606a8462 && test_range_squared < gib_range_squared) {
            level.riotshield_knockdown_gib[level.riotshield_knockdown_gib.size] = 1;
          }
        }

        break;
      case # "special":
      case # "elite":
        if(self hasperk(#"specialty_mod_shield")) {
          level.riotshield_knockdown_enemies[level.riotshield_knockdown_enemies.size] = e_target;
          level.riotshield_knockdown_gib[level.riotshield_knockdown_gib.size] = 0;
        } else {
          if(!isDefined(level.var_21ffc192)) {
            level.var_21ffc192 = [];
          } else if(!isarray(level.var_21ffc192)) {
            level.var_21ffc192 = array(level.var_21ffc192);
          }

          level.var_21ffc192[level.var_21ffc192.size] = e_target;
          e_target dodamage(3000, self.origin, self, self, "", "MOD_IMPACT");
        }

        break;
      default:
        if(!isDefined(level.var_21ffc192)) {
          level.var_21ffc192 = [];
        } else if(!isarray(level.var_21ffc192)) {
          level.var_21ffc192 = array(level.var_21ffc192);
        }

        level.var_21ffc192[level.var_21ffc192.size] = e_target;
        e_target dodamage(3000, self.origin, self, self, "", "MOD_IMPACT");
        break;
    }
  }
}

function riotshield_melee(weapon, riotshield_knockdown_range, riotshield_gib_range, riotshield_fling_range, var_1c3d89, riotshield_cylinder_radius, riotshield_fling_force_melee) {
  if(!isDefined(level.riotshield_knockdown_enemies)) {
    level.riotshield_knockdown_enemies = [];
    level.riotshield_knockdown_gib = [];
    level.riotshield_fling_enemies = [];
    level.riotshield_fling_vecs = [];
    level.var_21ffc192 = [];
  }

  self riotshield_get_enemies_in_range(riotshield_knockdown_range, riotshield_gib_range, riotshield_fling_range, var_1c3d89, riotshield_cylinder_radius, riotshield_fling_force_melee);
  shield_damage = 0;

  for(i = 0; i < level.riotshield_fling_enemies.size; i++) {
    [[level.var_2677b8bb]] - > waitinqueue(level.riotshield_fling_enemies[i]);

    if(isDefined(level.riotshield_fling_enemies[i])) {
      level.riotshield_fling_enemies[i] thread riotshield_fling_zombie(self, level.riotshield_fling_vecs[i], i);
      var_d3f92d4d = zombie_utility::get_zombie_var(#"riotshield_fling_damage_shield");

      if(self hasperk(#"specialty_mod_shield")) {
        var_d3f92d4d *= 0.66;
      }

      shield_damage += var_d3f92d4d;
    }
  }

  for(i = 0; i < level.riotshield_knockdown_enemies.size; i++) {
    [[level.var_2677b8bb]] - > waitinqueue(level.riotshield_knockdown_enemies[i]);

    if(!isDefined(level.riotshield_knockdown_enemies[i])) {
      continue;
    }

    level.riotshield_knockdown_enemies[i] thread riotshield_knockdown_zombie(self, level.riotshield_knockdown_gib[i]);
    shield_damage += zombie_utility::get_zombie_var(#"riotshield_knockdown_damage_shield");
  }

  foreach(ai_enemy in level.var_21ffc192) {
    switch (ai_enemy.zm_ai_category) {
      case # "boss":
      case # "special":
      case # "elite":
        var_d3f92d4d = zombie_utility::get_zombie_var(#"hash_bfdf728041b626a");
        break;
      default:
        var_d3f92d4d = zombie_utility::get_zombie_var(#"hash_6835f7c5524585f3");
        break;
    }

    if(self hasperk(#"specialty_mod_shield")) {
      var_d3f92d4d *= 0.66;
    }

    shield_damage += var_d3f92d4d;
  }

  level.riotshield_knockdown_enemies = [];
  level.riotshield_knockdown_gib = [];
  level.riotshield_fling_enemies = [];
  level.riotshield_fling_vecs = [];
  level.var_21ffc192 = [];

  if(shield_damage) {
    self player_damage_shield(shield_damage, 0);
  }
}

function updateriotshieldmodel() {
  self endon(#"disconnect");
  waitframe(1);
  self.hasriotshield = 0;
  self.weaponriotshield = level.weaponnone;

  foreach(weapon in self getweaponslist(1)) {
    if(weapon.isriotshield) {
      level.var_ef7415bc = 1;
      self.hasriotshield = 1;
      self.weaponriotshield = weapon;
      break;
    }
  }

  current = self getcurrentweapon();
  self.hasriotshieldequipped = current.isriotshield;

  if(self.hasriotshield) {
    if(self.hasriotshieldequipped) {
      self zm_weapons::clear_stowed_weapon();

      if(isDefined(level.var_ecfcf864)) {
        self[[level.var_ecfcf864]]();
      }
    } else {
      self zm_weapons::set_stowed_weapon(self.weaponriotshield);

      if(isDefined(level.var_1177ae05)) {
        self[[level.var_1177ae05]]();
      }
    }
  } else {
    self zm_weapons::clear_stowed_weapon();
  }

  self refreshshieldattachment();
}

function player_take_riotshield() {
  self notify(#"destroy_riotshield");
  self endon(#"disconnect");
  self disableweaponcycling();
  util::wait_network_frame();
  self function_a9109d26();
  self playsoundtoplayer(#"hash_560e1cb348d4600f", self);
  weapon = level.weaponriotshield;

  if(isDefined(self.weaponriotshield)) {
    weapon = self.weaponriotshield;
  }

  if(zm_equipment::is_equipment(weapon)) {
    self zm_equipment::take(weapon);
  } else {
    self zm_weapons::weapon_take(weapon);
  }

  self updateriotshieldmodel();
  self enableweaponcycling();
  self.hasriotshield = 0;
  self.hasriotshieldequipped = 0;
  self.var_d3345483 = undefined;
}

function function_a9109d26() {
  self endon(#"death");
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
        self switchtoweaponimmediate(undefined, 1);
        self playSound(#"wpn_riotshield_zm_destroy");
        return;
      }

      self switchtoweaponimmediate(undefined, 1);
      self playSound(#"wpn_riotshield_zm_destroy");
      self waittill(#"weapon_change");
    }
  }
}