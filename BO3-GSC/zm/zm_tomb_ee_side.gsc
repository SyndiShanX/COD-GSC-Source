/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_ee_side.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_audio_zhd;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_tomb_amb;
#using scripts\zm\zm_tomb_ee_lights;
#using scripts\zm\zm_tomb_utility;
#using scripts\zm\zm_tomb_vo;
#namespace zm_tomb_ee_side;

function init() {
  clientfield::register("world", "wagon_1_fire", 21000, 1, "int");
  clientfield::register("world", "wagon_2_fire", 21000, 1, "int");
  clientfield::register("world", "wagon_3_fire", 21000, 1, "int");
  clientfield::register("actor", "ee_zombie_tablet_fx", 21000, 1, "int");
  clientfield::register("toplayer", "ee_beacon_reward", 21000, 1, "int");
  callback::on_connect( & on_player_connect);
  sq_one_inch_punch();
  level thread wagon_fire_challenge();
  level thread wall_hole_poster();
  level thread quadrotor_medallions();
  level thread zm_tomb_ee_lights::main();
  level thread radio_ee_song();
}

function on_player_connect() {
  self thread onplayerconnect_ee_jump_scare();
  self thread onplayerconnect_ee_oneinchpunch();
}

function quadrotor_medallions() {
  level flag::init("ee_medallions_collected");
  level thread quadrotor_medallions_vo();
  level.n_ee_medallions = 4;
  level flag::wait_till("ee_medallions_collected");
  level thread zm_tomb_amb::sndplaystinger("side_sting_4");
  s_mg_spawn = struct::get("mgspawn", "targetname");
  v_spawnpt = s_mg_spawn.origin;
  v_spawnang = s_mg_spawn.angles;
  player = getplayers()[0];
  var_67f03e82 = getweapon("lmg_mg08_upgraded");
  options = player zm_weapons::get_pack_a_punch_weapon_options(var_67f03e82);
  var_c91432f = zm_utility::spawn_weapon_model(var_67f03e82, undefined, v_spawnpt, v_spawnang, options);
  playFXOnTag(level._effect["special_glow"], var_c91432f, "tag_origin");
  t_weapon_swap = zm_tomb_utility::tomb_spawn_trigger_radius(v_spawnpt, 100, 1);
  t_weapon_swap.require_look_at = 1;
  t_weapon_swap.cursor_hint = "HINT_WEAPON";
  t_weapon_swap.cursor_hint_weapon = var_67f03e82;
  b_retrieved = 0;
  while(!b_retrieved) {
    t_weapon_swap waittill("trigger", e_player);
    b_retrieved = swap_mg(e_player);
  }
  t_weapon_swap zm_tomb_utility::tomb_unitrigger_delete();
  var_c91432f delete();
}

function quadrotor_medallions_vo() {
  n_vo_counter = 0;
  while(n_vo_counter < 4) {
    level waittill("quadrotor_medallion_found", v_quadrotor);
    v_quadrotor playSound("zmb_medallion_pickup");
    if(isDefined(v_quadrotor)) {
      zm_tomb_vo::maxissay("vox_maxi_drone_pickups_" + n_vo_counter, v_quadrotor);
      n_vo_counter++;
      if(isDefined(v_quadrotor) && n_vo_counter == 4) {
        zm_tomb_vo::maxissay("vox_maxi_drone_pickups_" + n_vo_counter, v_quadrotor);
      }
    }
  }
}

function swap_mg(e_player) {
  w_current_weapon = e_player getcurrentweapon();
  var_4caca97d = getweapon("lmg_mg08_upgraded");
  if(zombie_utility::is_player_valid(e_player) && !e_player.is_drinking && !e_player bgb::is_enabled("zm_bgb_disorderly_combat") && !zm_utility::is_placeable_mine(w_current_weapon) && !zm_equipment::is_equipment(w_current_weapon) && "none" != w_current_weapon.name && !e_player zm_equipment::hacker_active() && (!isDefined(level.revive_tool) || (isDefined(level.revive_tool) && level.revive_tool != w_current_weapon))) {
    if(e_player hasweapon(var_4caca97d)) {
      e_player givemaxammo(var_4caca97d);
    } else {
      a_weapons = e_player getweaponslistprimaries();
      if(isDefined(a_weapons) && a_weapons.size >= zm_utility::get_player_weapon_limit(e_player)) {
        e_player takeweapon(w_current_weapon);
      }
      e_player giveweapon(var_4caca97d, e_player zm_weapons::get_pack_a_punch_weapon_options(var_4caca97d), 0);
      e_player givestartammo(var_4caca97d);
      e_player switchtoweapon(var_4caca97d);
    }
    return true;
  }
  return false;
}

function wall_hole_poster() {
  m_poster = getent("hole_poster", "targetname");
  m_poster setCanDamage(1);
  m_poster.health = 1000;
  m_poster.maxhealth = m_poster.health;
  while(true) {
    m_poster waittill("damage");
    if(m_poster.health <= 0) {
      m_poster physicslaunch(m_poster.origin, (0, 0, 0));
    }
  }
}

function wagon_fire_challenge() {
  level flag::init("ee_wagon_timer_start");
  level flag::init("ee_wagon_challenge_complete");
  s_powerup = struct::get("wagon_powerup", "targetname");
  while(!level flag::exists("start_zombie_round_logic")) {
    wait(0.5);
  }
  level flag::wait_till("start_zombie_round_logic");
  wagon_fire_start();
  while(true) {
    level flag::wait_till("ee_wagon_timer_start");
    level flag::wait_till_timeout(30, "ee_wagon_challenge_complete");
    if(!level flag::get("ee_wagon_challenge_complete")) {
      wagon_fire_start();
      level flag::clear("ee_wagon_timer_start");
    } else {
      zm_powerups::specific_powerup_drop("zombie_blood", s_powerup.origin);
      level waittill("end_of_round");
      waittillframeend();
      while(level.weather_rain > 0) {
        level waittill("end_of_round");
        waittillframeend();
      }
      wagon_fire_start();
      level flag::clear("ee_wagon_timer_start");
      level flag::clear("ee_wagon_challenge_complete");
    }
  }
}

function wagon_fire_start() {
  level.n_wagon_fires_out = 0;
  a_triggers = getEntArray("wagon_damage_trigger", "targetname");
  foreach(trigger in a_triggers) {
    trigger thread wagon_fire_trigger_watch();
    level clientfield::set(trigger.script_noteworthy, 1);
  }
}

function wagon_fire_trigger_watch() {
  self notify("watch_reset");
  self endon("watch_reset");
  var_83560def = level.a_elemental_staffs["staff_water"].w_weapon;
  var_2499bc6a = level.a_elemental_staffs_upgraded["staff_water_upgraded"].w_weapon;
  while(true) {
    self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon);
    if(isplayer(attacker) && (weapon == var_83560def || weapon == var_2499bc6a)) {
      level.n_wagon_fires_out++;
      if(!level flag::get("ee_wagon_timer_start")) {
        level flag::set("ee_wagon_timer_start");
      }
      level clientfield::set(self.script_noteworthy, 0);
      if(level.n_wagon_fires_out == 3) {
        level flag::set("ee_wagon_challenge_complete");
        level thread zm_tomb_amb::sndplaystinger("side_sting_1");
      }
      return;
    }
  }
}

function onplayerconnect_ee_jump_scare() {
  self endon("disconnect");
  if(!isDefined(level.jump_scare_lookat_point)) {
    level.jump_scare_lookat_point = struct::get("struct_gg_look", "targetname");
  }
  if(!isDefined(level.b_saw_jump_scare)) {
    level.b_saw_jump_scare = 0;
  }
  while(!level.b_saw_jump_scare) {
    n_time = 0;
    while(self adsbuttonpressed() && n_time < 25) {
      n_time++;
      wait(0.05);
    }
    if(n_time >= 25 && self adsbuttonpressed() && self getcurrentweapon().issniperweapon && self zm_zonemgr::entity_in_zone("zone_nml_18") && zm_utility::is_player_looking_at(level.jump_scare_lookat_point.origin, 0.998, 0, undefined)) {
      self playsoundtoplayer("zmb_easteregg_scarydog", self);
      self.var_92fcfed8 = self openluimenu("JumpScare-Tomb");
      n_time = 0;
      while(self adsbuttonpressed() && n_time < 5) {
        n_time++;
        wait(0.05);
      }
      self closeluimenu(self.var_92fcfed8);
      level.b_saw_jump_scare = 1;
    }
    wait(0.05);
  }
}

function onplayerconnect_ee_oneinchpunch() {
  self.sq_one_inch_punch_stage = 0;
  self.sq_one_inch_punch_kills = 0;
}

function sq_one_inch_punch_disconnect_watch() {
  self waittill("disconnect");
  if(isDefined(self.sq_one_inch_punch_tablet)) {
    self.sq_one_inch_punch_tablet delete();
  }
  spawn_tablet_model(self.sq_one_inch_punch_tablet_num, "bunker", "muddy");
  level.n_tablets_remaining++;
}

function sq_one_inch_punch_death_watch() {
  self endon("disconnect");
  self waittill("bled_out");
  if(self.sq_one_inch_punch_stage < 6) {
    self.sq_one_inch_punch_stage = 0;
    self.sq_one_inch_punch_kills = 0;
    if(isDefined(self.sq_one_inch_punch_tablet)) {
      self.sq_one_inch_punch_tablet delete();
    }
    spawn_tablet_model(self.sq_one_inch_punch_tablet_num, "bunker", "muddy");
    level.n_tablets_remaining++;
  }
}

function sq_one_inch_punch() {
  zm_spawner::add_custom_zombie_spawn_logic( & bunker_volume_death_check);
  zm_spawner::add_custom_zombie_spawn_logic( & church_volume_death_check);
  level.n_tablets_remaining = 4;
  a_tablets = [];
  for(n_player_id = 0; n_player_id < level.n_tablets_remaining; n_player_id++) {
    a_tablets[n_player_id] = spawn_tablet_model(n_player_id + 1, "bunker", "muddy");
  }
  t_bunker = getent("trigger_oneinchpunch_bunker_table", "targetname");
  t_bunker thread bunker_trigger_thread();
  t_bunker setcursorhint("HINT_NOICON");
  t_birdbath = getent("trigger_oneinchpunch_church_birdbath", "targetname");
  t_birdbath thread birdbath_trigger_thread();
  t_birdbath setcursorhint("HINT_NOICON");
}

function bunker_trigger_thread() {
  while(true) {
    self waittill("trigger", player);
    if(player.sq_one_inch_punch_stage == 0) {
      player.sq_one_inch_punch_stage++;
      player.sq_one_inch_punch_tablet_num = level.n_tablets_remaining;
      player clientfield::set_to_player("player_tablet_state", 2);
      player playSound("zmb_squest_oiptablet_pickup");
      player thread sq_one_inch_punch_disconnect_watch();
      player thread sq_one_inch_punch_death_watch();
      m_tablet = getent("tablet_bunker_" + level.n_tablets_remaining, "targetname");
      m_tablet delete();
      level.n_tablets_remaining--;
      iprintln("");
    }
    if(player.sq_one_inch_punch_stage == 4) {
      player.sq_one_inch_punch_tablet = spawn_tablet_model(player.sq_one_inch_punch_tablet_num, "bunker", "clean");
      player.sq_one_inch_punch_stage++;
      player clientfield::set_to_player("player_tablet_state", 0);
      player playSound("zmb_squest_oiptablet_place_table");
      iprintln("");
    } else if(player.sq_one_inch_punch_stage == 6 && (isDefined(player.beacon_ready) && player.beacon_ready)) {
      player clientfield::set_to_player("ee_beacon_reward", 0);
      w_beacon = getweapon("beacon");
      player zm_weapons::weapon_give(w_beacon);
      player thread zm_tomb_vo::richtofenrespondvoplay("get_beacon");
      if(isDefined(level.zombie_include_weapons[w_beacon]) && !level.zombie_include_weapons[w_beacon]) {
        level.zombie_include_weapons[w_beacon] = 1;
        level.zombie_weapons[w_beacon].is_in_box = 1;
      }
      player playSound("zmb_squest_oiptablet_get_reward");
      player.sq_one_inch_punch_stage++;
      iprintln("");
    }
  }
}

function birdbath_trigger_thread() {
  while(true) {
    self waittill("trigger", player);
    if(player.sq_one_inch_punch_stage == 1) {
      if(isDefined(player.sq_one_inch_punch_reclean)) {
        player.sq_one_inch_punch_reclean = undefined;
        player.sq_one_inch_punch_stage++;
        player.sq_one_inch_punch_tablet = spawn_tablet_model(player.sq_one_inch_punch_tablet_num, "church", "clean");
        level thread tablet_cleanliness_chastise(player, 1);
      } else {
        player.sq_one_inch_punch_tablet = spawn_tablet_model(player.sq_one_inch_punch_tablet_num, "church", "muddy");
      }
      player playSound("zmb_squest_oiptablet_bathe");
      player clientfield::set_to_player("player_tablet_state", 0);
      player.sq_one_inch_punch_stage++;
      iprintln("");
    }
    if(player.sq_one_inch_punch_stage == 3) {
      player clientfield::set_to_player("player_tablet_state", 1);
      player.sq_one_inch_punch_stage++;
      if(isDefined(player.sq_one_inch_punch_tablet)) {
        player.sq_one_inch_punch_tablet delete();
      }
      player playSound("zmb_squest_oiptablet_pickup_clean");
      player thread tablet_cleanliness_thread();
      iprintln("");
    }
  }
}

function tablet_cleanliness_thread() {
  self endon("death_or_disconnect");
  while(self.sq_one_inch_punch_stage == 4) {
    if(self.is_player_slowed) {
      self clientfield::set_to_player("player_tablet_state", 2);
      self playsoundtoplayer("zmb_squest_oiptablet_dirtied", self);
      self.sq_one_inch_punch_stage = 1;
      self.sq_one_inch_punch_reclean = 1;
      level thread tablet_cleanliness_chastise(self);
      iprintln("");
    }
    wait(1);
  }
}

function tablet_cleanliness_chastise(e_player, b_cleaned = 0) {
  if(!isDefined(e_player) || (isDefined(level.sam_talking) && level.sam_talking) || level flag::get("story_vo_playing")) {
    return;
  }
  level flag::set("story_vo_playing");
  e_player zm_tomb_vo::set_player_dontspeak(1);
  level.sam_talking = 1;
  str_line = "vox_sam_generic_chastise_7";
  if(b_cleaned) {
    str_line = "vox_sam_generic_chastise_8";
  }
  if(isDefined(e_player)) {
    e_player playsoundtoplayer(str_line, e_player);
  }
  n_duration = soundgetplaybacktime(str_line);
  wait(n_duration / 1000);
  level.sam_talking = 0;
  level flag::clear("story_vo_playing");
  if(isDefined(e_player)) {
    e_player zm_tomb_vo::set_player_dontspeak(0);
  }
}

function bunker_volume_death_check() {
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }
  volume_name = "oneinchpunch_bunker_volume";
  volume = getent(volume_name, "targetname");
  assert(isDefined(volume), volume_name + "");
  attacker = self.attacker;
  if(isDefined(attacker) && isplayer(attacker)) {
    if(attacker.sq_one_inch_punch_stage == 5 && (self.damagemod == "MOD_MELEE" || self.damageweapon.name == "tomb_shield")) {
      if(self istouching(volume)) {
        self clientfield::set("ee_zombie_tablet_fx", 1);
        attacker.sq_one_inch_punch_kills++;
        iprintln("" + attacker.sq_one_inch_punch_kills);
        if(attacker.sq_one_inch_punch_kills >= 20) {
          attacker thread bunker_spawn_reward();
          attacker.sq_one_inch_punch_stage++;
          level thread zm_tomb_amb::sndplaystinger("side_sting_3");
          iprintln("");
        }
      }
    }
  }
}

function bunker_spawn_reward() {
  self endon("disconnect");
  wait(2);
  self clientfield::set_to_player("ee_beacon_reward", 1);
  wait(2);
  self.beacon_ready = 1;
}

function church_volume_death_check() {
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }
  volume_name = "oneinchpunch_church_volume";
  volume = getent(volume_name, "targetname");
  assert(isDefined(volume), volume_name + "");
  attacker = self.attacker;
  if(isDefined(attacker) && isplayer(attacker)) {
    if(attacker.sq_one_inch_punch_stage == 2 && (self.damagemod == "MOD_MELEE" || self.damageweapon.name == "tomb_shield")) {
      if(self istouching(volume)) {
        self clientfield::set("ee_zombie_tablet_fx", 1);
        attacker.sq_one_inch_punch_kills++;
        iprintln("" + attacker.sq_one_inch_punch_kills);
        if(attacker.sq_one_inch_punch_kills >= 20) {
          attacker.sq_one_inch_punch_stage++;
          attacker.sq_one_inch_punch_kills = 0;
          attacker.sq_one_inch_punch_tablet delete();
          attacker.sq_one_inch_punch_tablet = spawn_tablet_model(attacker.sq_one_inch_punch_tablet_num, "church", "clean");
          level thread zm_tomb_amb::sndplaystinger("side_sting_6");
          iprintln("");
        }
      }
    }
  }
}

function spawn_tablet_model(n_player_id, str_location, str_state) {
  s_tablet_spawn = struct::get((("oneinchpunch_" + str_location) + "_tablet_") + n_player_id, "targetname");
  v_spawnpt = s_tablet_spawn.origin;
  v_spawnang = s_tablet_spawn.angles;
  m_tablet = spawn("script_model", v_spawnpt);
  m_tablet.angles = v_spawnang;
  if(str_state == "clean") {
    m_tablet setModel("p7_zm_ori_tablet_stone");
    if(str_location == "church") {
      m_tablet playSound("zmb_squest_oiptablet_charged");
    }
  } else {
    m_tablet setModel("p7_zm_ori_tablet_stone_muddy");
  }
  m_tablet.targetname = (("tablet_" + str_location) + "_") + n_player_id;
  return m_tablet;
}

function radio_ee_song() {
  level.found_ee_radio_count = 0;
  wait(3);
  a_structs = struct::get_array("ee_radio_pos", "targetname");
  foreach(unitrigger_stub in a_structs) {
    unitrigger_stub.radius = 50;
    unitrigger_stub.height = 128;
    unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.require_look_at = 1;
    m_radio = spawn("script_model", unitrigger_stub.origin);
    m_radio.angles = unitrigger_stub.angles;
    m_radio setModel("p7_zm_ori_radio_01");
    m_radio attach("p7_zm_ori_radio_01_panel_02", "tag_j_cover");
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, & radio_ee_think);
    unitrigger_stub thread radio_ee_debug();
    util::wait_network_frame();
  }
}

function radio_ee_debug() {
  self endon("stop_display");
  while(true) {
    print3d(self.origin, "", vectorscale((1, 0, 1), 255), 1);
    wait(0.05);
  }
}

function radio_ee_think() {
  self endon("kill_trigger");
  while(true) {
    self waittill("trigger", player);
    if(!zm_audio_zhd::function_8090042c()) {
      continue;
    }
    if(zombie_utility::is_player_valid(player)) {
      level.found_ee_radio_count++;
      playsoundatposition("zmb_ee_mus_activate", self.origin);
      if(level.found_ee_radio_count == 3) {
        level thread zm_audio::sndmusicsystem_playstate("shepherd_of_fire");
      }
      self.stub notify("stop_display");
      zm_unitrigger::unregister_unitrigger(self.stub);
      return;
    }
  }
}