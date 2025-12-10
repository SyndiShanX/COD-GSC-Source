/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_dragon_scale_shield.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_traps;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_dragon_strike;
#using scripts\zm\_zm_weap_riotshield;
#using scripts\zm\_zm_weapons;
#using scripts\zm\craftables\_zm_craft_shield;
#namespace dragon_scale_shield;

function autoexec __init__sytem__() {
  system::register("zm_weap_dragonshield", &__init__, &__main__, undefined);
}

function __init__() {
  zm_craft_shield::init("craft_shield_zm", "dragonshield", "wpn_t7_zmb_dlc3_dragon_shield_dmg0_world", &"ZOMBIE_DRAGON_SHIELD_CRAFT", &"ZOMBIE_DRAGON_SHIELD_TAKEN", &"ZOMBIE_DRAGON_SHIELD_PICKUP");
  clientfield::register("allplayers", "ds_ammo", 12000, 1, "int");
  clientfield::register("allplayers", "burninate", 12000, 1, "counter");
  clientfield::register("allplayers", "burninate_upgraded", 12000, 1, "counter");
  clientfield::register("actor", "dragonshield_snd_projectile_impact", 12000, 1, "counter");
  clientfield::register("vehicle", "dragonshield_snd_projectile_impact", 12000, 1, "counter");
  clientfield::register("actor", "dragonshield_snd_zombie_knockdown", 12000, 1, "counter");
  clientfield::register("vehicle", "dragonshield_snd_zombie_knockdown", 12000, 1, "counter");
  level flag::init("dragon_shield_used");
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  level.weaponriotshield = getweapon("dragonshield");
  zm_equipment::register("dragonshield", &"ZOMBIE_DRAGON_SHIELD_PICKUP", &"ZOMBIE_DRAGON_SHIELD_HINT", undefined, "riotshield");
  level.weaponriotshieldupgraded = getweapon("dragonshield_upgraded");
  zm_equipment::register("dragonshield_upgraded", &"ZOMBIE_DRAGON_SHIELD_UPGRADE_PICKUP", &"ZOMBIE_DRAGON_SHIELD_HINT", undefined, "riotshield");
  level.var_7ba638ea = getweapon("dragonshield_projectile");
  level.var_855a12ba = getweapon("dragonshield_projectile_upgraded");
  level.riotshield_melee_power = &function_71d88f26;
  level.should_shield_absorb_damage = &should_shield_absorb_damage;
  zombie_utility::set_zombie_var("dragonshield_proximity_fling_radius", 96);
  zombie_utility::set_zombie_var("dragonshield_proximity_knockdown_radius", 128);
  zombie_utility::set_zombie_var("dragonshield_cylinder_radius", 180);
  zombie_utility::set_zombie_var("dragonshield_fling_range", 480);
  zombie_utility::set_zombie_var("dragonshield_gib_range", 900);
  zombie_utility::set_zombie_var("dragonshield_gib_damage", 75);
  zombie_utility::set_zombie_var("dragonshield_knockdown_range", 1200);
  zombie_utility::set_zombie_var("dragonshield_knockdown_damage", 15);
  zombie_utility::set_zombie_var("dragonshield_projectile_lifetime", 1.1);
  level.var_d73afd29 = [];
  level.var_d73afd29[level.var_d73afd29.size] = "guts";
  level.var_d73afd29[level.var_d73afd29.size] = "right_arm";
  level.var_d73afd29[level.var_d73afd29.size] = "left_arm";
  level.var_337d1ed2 = &zombie_knockdown;
}

function __main__() {
  zm_equipment::register_for_level("dragonshield");
  zm_equipment::include("dragonshield");
  zm_equipment::set_ammo_driven("dragonshield", level.weaponriotshield.startammo, 1);
  zm_equipment::register_for_level("dragonshield_upgraded");
  zm_equipment::include("dragonshield_upgraded");
  zm_equipment::set_ammo_driven("dragonshield_upgraded", level.weaponriotshieldupgraded.startammo, 1);
  zombie_utility::set_zombie_var("riotshield_fling_damage_shield", 100);
  zombie_utility::set_zombie_var("riotshield_knockdown_damage_shield", 15);
  zombie_utility::set_zombie_var("riotshield_fling_range", 120);
  zombie_utility::set_zombie_var("riotshield_gib_range", 120);
  zombie_utility::set_zombie_var("riotshield_knockdown_range", 120);
  level thread function_a3a9c2dc();
}

function on_player_connect() {
  self thread watchfirstuse();
}

function watchfirstuse() {
  self endon("disconnect");
  while(isDefined(self)) {
    self waittill("weapon_change", newweapon);
    if(newweapon.isriotshield) {
      break;
    }
  }
  self notify("hide_equipment_hint_text");
  level flag::set("dragon_shield_used");
  util::wait_network_frame();
  self.rocket_shield_hint_shown = 1;
  zm_equipment::show_hint_text(&"ZOMBIE_DRAGON_SHIELD_HINT", 5);
}

function on_player_spawned() {
  self thread function_98962bde();
  self thread player_watch_ammo_change();
  self thread player_watch_max_ammo();
  self.player_shield_apply_damage = &function_247d568b;
  self.riotshield_damage_absorb_callback = &riotshield_damage_absorb_callback;
}

function function_98962bde() {
  self notify("hash_34db92fa");
  self endon("hash_34db92fa");
  self endon("disconnect");
  while(isDefined(self)) {
    level waittill("start_of_round");
    if(isDefined(self) && (isDefined(self.hasriotshield) && self.hasriotshield)) {
      self zm_equipment::change_ammo(self.weaponriotshield, 1);
      self thread check_weapon_ammo(self.weaponriotshield);
    }
  }
}

function player_watch_ammo_change() {
  self notify("player_watch_ammo_change");
  self endon("player_watch_ammo_change");
  for(;;) {
    self waittill("equipment_ammo_changed", equipment);
    if(isstring(equipment)) {
      equipment = getweapon(equipment);
    }
    if(equipment == getweapon("dragonshield") || equipment == getweapon("dragonshield_upgraded")) {
      self thread check_weapon_ammo(equipment);
    }
  }
}

function player_watch_max_ammo() {
  self notify("player_watch_max_ammo");
  self endon("player_watch_max_ammo");
  for(;;) {
    self waittill("zmb_max_ammo");
    wait(0.05);
    if(isDefined(self.hasriotshield) && self.hasriotshield) {
      self thread check_weapon_ammo(self.weaponriotshield);
    }
  }
}

function check_weapon_ammo(weapon) {
  wait(0.05);
  if(isDefined(self)) {
    ammo = self getweaponammoclip(weapon);
    self clientfield::set("ds_ammo", ammo);
  }
}

function should_shield_absorb_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(isDefined(self.hasriotshield) && self.hasriotshield) {
    if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped && smeansofdeath == "MOD_EXPLOSIVE" && isDefined(eattacker) && (isDefined(eattacker.is_elemental_zombie) && eattacker.is_elemental_zombie) && eattacker.var_9a02a614 === "napalm") {
      return 1;
    }
    if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped && smeansofdeath == "MOD_BURNED") {
      return 1;
    }
  }
  return riotshield::should_shield_absorb_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
}

function function_247d568b(idamage, bheld, fromcode = 0, smod = "MOD_UNKNOWN") {
  if(smod != "MOD_BURNED") {
    riotshield::player_damage_shield(idamage, bheld, fromcode, smod);
  }
}

function riotshield_damage_absorb_callback(eattacker, idamage, shitloc, smeansofdeath) {}

function function_71d88f26(weapon) {
  ammo = self getammocount(weapon);
  disabled = isDefined(self.var_a0a9409e) && self.var_a0a9409e;
  if(ammo > 0 && !disabled) {
    self zm_equipment::change_ammo(weapon, -1);
    self thread function_f894ad3e();
    self thread burninate(weapon);
    self thread check_weapon_ammo(weapon);
  } else {
    riotshield::riotshield_melee(weapon);
  }
}

function function_f894ad3e() {
  self playrumbleonentity("zod_shield_juke");
  if(self zm_equipment::get_player_equipment() == getweapon("dragonshield")) {
    var_e93a0115 = "burninate";
    var_c3937998 = level.var_7ba638ea;
  } else {
    var_e93a0115 = "burninate_upgraded";
    var_c3937998 = level.var_855a12ba;
  }
  self clientfield::increment(var_e93a0115);
  range = level.zombie_vars["dragonshield_knockdown_range"];
  view_pos = self getweaponmuzzlepoint();
  forward_view_angles = self getweaponforwarddir();
  end_pos = view_pos + (range * forward_view_angles);
  var_aa911866 = magicbullet(var_c3937998, view_pos, end_pos, self);
}

function function_c9b3ba45(e_attacker) {
  self.marked_for_death = 1;
  if(isDefined(self)) {
    self dodamage(self.health + 666, e_attacker.origin, e_attacker);
  }
}

function function_3f5e8a65() {
  level.var_9e674825++;
  if(!level.var_9e674825 % 10) {
    util::wait_network_frame();
    util::wait_network_frame();
    util::wait_network_frame();
  }
}

function burninate(w_weapon) {
  physicsexplosioncylinder(self.origin, 600, 240, 1);
  if(w_weapon == getweapon("dragonshield_upgraded")) {
    n_clientfield = 2;
  } else {
    n_clientfield = 1;
  }
  self thread function_8b8bd269(n_clientfield);
  self notify("hash_10fa975d", w_weapon);
}

function function_8b8bd269(n_clientfield) {
  if(!isDefined(level.var_2f79fc7)) {
    level.var_2f79fc7 = [];
    level.var_490f6a0d = [];
    level.var_e4a96ed9 = [];
    level.var_1c1b4cce = [];
  }
  self function_459dacdd();
  self.var_3a6322f2 = 0;
  level.var_9e674825 = 0;
  for(i = 0; i < level.var_e4a96ed9.size; i++) {
    if(level.var_e4a96ed9[i].archetype === "zombie") {
      level.var_e4a96ed9[i] clientfield::set("dragon_strike_zombie_fire", n_clientfield);
    }
    level.var_e4a96ed9[i] thread function_64bd9bf5(self, level.var_1c1b4cce[i], i);
    function_3f5e8a65();
  }
  for(i = 0; i < level.var_2f79fc7.size; i++) {
    if(level.var_2f79fc7[i].archetype === "zombie") {
      level.var_2f79fc7[i] clientfield::set("dragon_strike_zombie_fire", n_clientfield);
    }
    level.var_2f79fc7[i] thread function_c25e3d4b(self, level.var_490f6a0d[i]);
    function_3f5e8a65();
  }
  self notify("hash_8c80a390", self.var_3a6322f2);
  level.var_2f79fc7 = [];
  level.var_490f6a0d = [];
  level.var_e4a96ed9 = [];
  level.var_1c1b4cce = [];
}

function function_459dacdd() {
  view_pos = self getweaponmuzzlepoint();
  zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, level.zombie_vars["dragonshield_knockdown_range"]);
  if(!isDefined(zombies)) {
    return;
  }
  knockdown_range_squared = level.zombie_vars["dragonshield_knockdown_range"] * level.zombie_vars["dragonshield_knockdown_range"];
  gib_range_squared = level.zombie_vars["dragonshield_gib_range"] * level.zombie_vars["dragonshield_gib_range"];
  fling_range_squared = level.zombie_vars["dragonshield_fling_range"] * level.zombie_vars["dragonshield_fling_range"];
  cylinder_radius_squared = level.zombie_vars["dragonshield_cylinder_radius"] * level.zombie_vars["dragonshield_cylinder_radius"];
  var_26ce68e3 = level.zombie_vars["dragonshield_proximity_knockdown_radius"] * level.zombie_vars["dragonshield_proximity_knockdown_radius"];
  var_36f73bb5 = level.zombie_vars["dragonshield_proximity_fling_radius"] * level.zombie_vars["dragonshield_proximity_fling_radius"];
  forward_view_angles = self getweaponforwarddir();
  end_pos = view_pos + vectorscale(forward_view_angles, level.zombie_vars["dragonshield_knockdown_range"]);
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
    test_origin = zombies[i] getcentroid();
    test_range_squared = distancesquared(view_pos, test_origin);
    if(test_range_squared > knockdown_range_squared) {
      zombies[i] function_8e9a1613("range", (1, 0, 0));
      return;
    }
    normal = vectornormalize(test_origin - view_pos);
    dot = vectordot(forward_view_angles, normal);
    if(test_range_squared < var_36f73bb5) {
      level.var_e4a96ed9[level.var_e4a96ed9.size] = zombies[i];
      dist_mult = 1;
      fling_vec = vectornormalize(test_origin - view_pos);
      fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
      fling_vec = vectorscale(fling_vec, 50 + (50 * dist_mult));
      level.var_1c1b4cce[level.var_1c1b4cce.size] = fling_vec;
      zombies[i] thread function_41f7c503(self, 1, 0, 0);
      continue;
    } else if(test_range_squared < var_26ce68e3 && 0 > dot) {
      if(!isDefined(zombies[i].var_e1dbd63)) {
        zombies[i].var_e1dbd63 = level.var_337d1ed2;
      }
      level.var_2f79fc7[level.var_2f79fc7.size] = zombies[i];
      level.var_490f6a0d[level.var_490f6a0d.size] = 0;
      zombies[i] thread function_41f7c503(self, 0, 0, 1);
      continue;
    }
    if(0 > dot) {
      zombies[i] function_8e9a1613("dot", (1, 0, 0));
      continue;
    }
    radial_origin = pointonsegmentnearesttopoint(view_pos, end_pos, test_origin);
    if(distancesquared(test_origin, radial_origin) > cylinder_radius_squared) {
      zombies[i] function_8e9a1613("cylinder", (1, 0, 0));
      continue;
    }
    if(0 == zombies[i] damageconetrace(view_pos, self)) {
      zombies[i] function_8e9a1613("cone", (1, 0, 0));
      continue;
    }
    var_6ce0bf79 = level.zombie_vars["dragonshield_projectile_lifetime"];
    zombies[i].var_d8486721 = (var_6ce0bf79 * sqrt(test_range_squared)) / level.zombie_vars["dragonshield_knockdown_range"];
    if(test_range_squared < fling_range_squared) {
      level.var_e4a96ed9[level.var_e4a96ed9.size] = zombies[i];
      dist_mult = (fling_range_squared - test_range_squared) / fling_range_squared;
      fling_vec = vectornormalize(test_origin - view_pos);
      if(5000 < test_range_squared) {
        fling_vec = fling_vec + (vectornormalize(test_origin - radial_origin));
      }
      fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
      fling_vec = vectorscale(fling_vec, 50 + (50 * dist_mult));
      level.var_1c1b4cce[level.var_1c1b4cce.size] = fling_vec;
      zombies[i] thread function_41f7c503(self, 1, 0, 0);
      continue;
    }
    if(test_range_squared < gib_range_squared) {
      if(!isDefined(zombies[i].var_e1dbd63)) {
        zombies[i].var_e1dbd63 = level.var_337d1ed2;
      }
      level.var_2f79fc7[level.var_2f79fc7.size] = zombies[i];
      level.var_490f6a0d[level.var_490f6a0d.size] = 1;
      zombies[i] thread function_41f7c503(self, 0, 1, 0);
      continue;
    }
    if(!isDefined(zombies[i].var_e1dbd63)) {
      zombies[i].var_e1dbd63 = level.var_337d1ed2;
    }
    level.var_2f79fc7[level.var_2f79fc7.size] = zombies[i];
    level.var_490f6a0d[level.var_490f6a0d.size] = 0;
    zombies[i] thread function_41f7c503(self, 0, 0, 1);
  }
}

function function_8e9a1613(msg, color) {
  if(!getdvarint("")) {
    return;
  }
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  print3d(self.origin + vectorscale((0, 0, 1), 60), msg, color, 1, 1, 40);
}

function function_64bd9bf5(player, fling_vec, index) {
  delay = self.var_d8486721;
  if(isDefined(delay) && delay > 0.05) {
    wait(delay);
  }
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.var_23340a5d)) {
    self[[self.var_23340a5d]](player);
    return;
  }
  self function_c9b3ba45(player);
  if(self.health <= 0) {
    if(!(isDefined(self.no_damage_points) && self.no_damage_points)) {
      points = 10;
      if(!index) {
        points = zm_score::get_zombie_death_player_points();
      } else if(1 == index) {
        points = 30;
      }
      player zm_score::player_add_points("riotshield_fling", points);
    }
    self startragdoll();
    self launchragdoll(fling_vec);
    self.var_5eeaffc8 = 1;
    player.var_3a6322f2++;
  }
}

function zombie_knockdown(player, gib) {
  delay = self.var_d8486721;
  if(isDefined(delay) && delay > 0.05) {
    wait(delay);
  }
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(!isvehicle(self)) {
    if(gib && (!(isDefined(self.gibbed) && self.gibbed))) {
      self.a.gib_ref = array::random(level.var_d73afd29);
      self thread zombie_death::do_gib();
    } else {
      self zombie_utility::setup_zombie_knockdown(player);
    }
  }
  if(isDefined(level.var_d532d63)) {
    self[[level.var_d532d63]](player, gib);
  } else {
    damage = level.zombie_vars["dragonshield_knockdown_damage"];
    self clientfield::increment("dragonshield_snd_zombie_knockdown");
    self.var_2a2a6dce = &function_21b74baa;
    self dodamage(damage, player.origin, player);
    if(!isvehicle(self)) {
      self animcustom(&function_2d1a5562);
    }
    if(self.health <= 0) {
      player.var_3a6322f2++;
    }
  }
}

function function_2d1a5562() {
  self notify("hash_21776edb");
  self endon("killanimscript");
  self endon("death");
  self endon("hash_21776edb");
  if(isDefined(self.marked_for_death) && self.marked_for_death) {
    return;
  }
  if(self.damageyaw <= -135 || self.damageyaw >= 135) {
    if(self.missinglegs) {
      fallanim = "zm_dragonshield_fall_front_crawl";
    } else {
      fallanim = "zm_dragonshield_fall_front";
    }
    getupanim = "zm_dragonshield_getup_belly_early";
  } else {
    if(self.damageyaw > -135 && self.damageyaw < -45) {
      fallanim = "zm_dragonshield_fall_left";
      getupanim = "zm_dragonshield_getup_belly_early";
    } else {
      if(self.damageyaw > 45 && self.damageyaw < 135) {
        fallanim = "zm_dragonshield_fall_right";
        getupanim = "zm_dragonshield_getup_belly_early";
      } else {
        fallanim = "zm_dragonshield_fall_back";
        if(randomint(100) < 50) {
          getupanim = "zm_dragonshield_getup_back_early";
        } else {
          getupanim = "zm_dragonshield_getup_back_late";
        }
      }
    }
  }
  self setanimstatefromasd(fallanim);
  self zombie_shared::donotetracks("dragonshield_fall_anim", self.var_2a2a6dce);
  if(!isDefined(self) || !isalive(self) || self.missinglegs || (isDefined(self.marked_for_death) && self.marked_for_death)) {
    return;
  }
  self setanimstatefromasd(getupanim);
  self zombie_shared::donotetracks("dragonshield_getup_anim");
}

function function_c25e3d4b(player, gib) {
  self endon("death");
  self clientfield::increment("dragonshield_snd_projectile_impact");
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.var_e1dbd63)) {
    self[[self.var_e1dbd63]](player, gib);
  }
}

function function_21b74baa(note) {
  if(note == "zombie_knockdown_ground_impact") {
    playFX(level._effect["dragonshield_knockdown_ground"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    self clientfield::increment("dragonshield_snd_zombie_knockdown");
  }
}

function function_41f7c503(player, fling, gib, knockdown) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(!fling && (gib || knockdown)) {}
  if(fling) {
    if(30 > randomintrange(1, 100)) {
      player zm_audio::create_and_play_dialog("kill", "rocketshield");
    }
  }
}

function function_a3a9c2dc() {
  level flagsys::wait_till("");
  wait(1);
  zm_devgui::add_custom_devgui_callback(&function_6f901616);
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  if(getdvarint("") > 0) {
    adddebugcommand("");
  }
}

function function_6f901616(cmd) {
  players = getplayers();
  retval = 0;
  switch (cmd) {
    case "": {
      array::thread_all(players, &zm_devgui::zombie_devgui_equipment_give, "");
      retval = 1;
      break;
    }
    case "": {
      array::thread_all(players, &zm_devgui::zombie_devgui_equipment_give, "");
      retval = 1;
      break;
    }
    case "": {
      array::thread_all(players, &function_f685a6db);
      retval = 1;
      break;
    }
    case "": {
      array::thread_all(players, &function_eeac5a22);
      retval = 1;
      break;
    }
  }
  return retval;
}

function detect_reentry() {
  if(isDefined(self.devgui_preserve_time)) {
    if(self.devgui_preserve_time == gettime()) {
      return true;
    }
  }
  self.devgui_preserve_time = gettime();
  return false;
}

function function_f685a6db() {
  if(self detect_reentry()) {
    return;
  }
  self notify("hash_f685a6db");
  self endon("hash_f685a6db");
  level flagsys::wait_till("");
  self.var_f685a6db = !(isDefined(self.var_f685a6db) && self.var_f685a6db);
  if(self.var_f685a6db) {
    while(isDefined(self)) {
      damagemax = level.weaponriotshield.weaponstarthitpoints;
      if(isDefined(self.weaponriotshield)) {
        damagemax = self.weaponriotshield.weaponstarthitpoints;
      }
      shieldhealth = self damageriotshield(0);
      if(shieldhealth == 0) {
        shieldhealth = self damageriotshield(damagemax * -1);
      } else {
        shieldhealth = self damageriotshield(int(damagemax / 10));
      }
      wait(0.5);
    }
  }
}

function function_eeac5a22() {
  if(self detect_reentry()) {
    return;
  }
  self notify("hash_eeac5a22");
  self endon("hash_eeac5a22");
  level flagsys::wait_till("");
  self.var_eeac5a22 = !(isDefined(self.var_eeac5a22) && self.var_eeac5a22);
  if(self.var_eeac5a22) {
    while(isDefined(self)) {
      if(isDefined(self.hasriotshield) && self.hasriotshield) {
        self zm_equipment::change_ammo(self.weaponriotshield, 1);
        self thread check_weapon_ammo(self.weaponriotshield);
      }
      wait(1);
    }
  }
}