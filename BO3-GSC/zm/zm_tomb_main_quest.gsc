/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_main_quest.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\zm_challenges_tomb;
#using scripts\zm\zm_tomb_amb;
#using scripts\zm\zm_tomb_challenges;
#using scripts\zm\zm_tomb_chamber;
#using scripts\zm\zm_tomb_craftables;
#using scripts\zm\zm_tomb_ee_main_step_7;
#using scripts\zm\zm_tomb_quest_air;
#using scripts\zm\zm_tomb_quest_crypt;
#using scripts\zm\zm_tomb_quest_elec;
#using scripts\zm\zm_tomb_quest_fire;
#using scripts\zm\zm_tomb_quest_ice;
#using scripts\zm\zm_tomb_teleporter;
#using scripts\zm\zm_tomb_utility;
#using scripts\zm\zm_tomb_vo;
#using_animtree("generic");
#namespace zm_tomb_main_quest;

function main_quest_init() {
  level flag::init("dug");
  level flag::init("air_open");
  level flag::init("fire_open");
  level flag::init("lightning_open");
  level flag::init("ice_open");
  level flag::init("panels_solved");
  level flag::init("fire_solved");
  level flag::init("ice_solved");
  level flag::init("chamber_puzzle_cheat");
  level flag::init("activate_zone_crypt");
  level flag::init("staff_air_upgrade_unlocked");
  level flag::init("staff_water_upgrade_unlocked");
  level flag::init("staff_fire_upgrade_unlocked");
  level flag::init("staff_lightning_upgrade_unlocked");
  level.callbackvehicledamage = &aircrystalbiplanecallback_vehicledamage;
  level.game_mode_custom_onplayerdisconnect = &player_disconnect_callback;
  callback::on_connect(&onplayerconnect);
  staff_air = getent("prop_staff_air", "targetname");
  staff_fire = getent("prop_staff_fire", "targetname");
  staff_lightning = getent("prop_staff_lightning", "targetname");
  staff_water = getent("prop_staff_water", "targetname");
  staff_air.weapname = "staff_air";
  staff_fire.weapname = "staff_fire";
  staff_lightning.weapname = "staff_lightning";
  staff_water.weapname = "staff_water";
  staff_air.w_weapon = getweapon("staff_air");
  staff_fire.w_weapon = getweapon("staff_fire");
  staff_lightning.w_weapon = getweapon("staff_lightning");
  staff_water.w_weapon = getweapon("staff_water");
  staff_air.element = "air";
  staff_fire.element = "fire";
  staff_lightning.element = "lightning";
  staff_water.element = "water";
  staff_air.craftable_name = "elemental_staff_air";
  staff_fire.craftable_name = "elemental_staff_fire";
  staff_lightning.craftable_name = "elemental_staff_lightning";
  staff_water.craftable_name = "elemental_staff_water";
  staff_air.charger = struct::get("staff_air_charger", "script_noteworthy");
  staff_fire.charger = struct::get("staff_fire_charger", "script_noteworthy");
  staff_lightning.charger = struct::get("zone_bolt_chamber", "script_noteworthy");
  staff_water.charger = struct::get("staff_ice_charger", "script_noteworthy");
  staff_fire.quest_clientfield = "fire_staff.quest_state";
  staff_air.quest_clientfield = "air_staff.quest_state";
  staff_lightning.quest_clientfield = "lightning_staff.quest_state";
  staff_water.quest_clientfield = "water_staff.quest_state";
  staff_fire.enum = 1;
  staff_air.enum = 2;
  staff_lightning.enum = 3;
  staff_water.enum = 4;
  level.a_elemental_staffs = [];
  level.a_elemental_staffs["staff_air"] = staff_air;
  level.a_elemental_staffs["staff_fire"] = staff_fire;
  level.a_elemental_staffs["staff_lightning"] = staff_lightning;
  level.a_elemental_staffs["staff_water"] = staff_water;
  foreach(staff in level.a_elemental_staffs) {
    staff.charger.charges_received = 0;
    staff.charger.is_inserted = 0;
    staff thread place_staffs_encasement();
    staff thread staff_charger_check();
    staff ghost();
  }
  staff_air_upgraded = getent("prop_staff_air_upgraded", "targetname");
  staff_fire_upgraded = getent("prop_staff_fire_upgraded", "targetname");
  staff_lightning_upgraded = getent("prop_staff_lightning_upgraded", "targetname");
  staff_water_upgraded = getent("prop_staff_water_upgraded", "targetname");
  staff_air_upgraded.weapname = "staff_air_upgraded";
  staff_fire_upgraded.weapname = "staff_fire_upgraded";
  staff_lightning_upgraded.weapname = "staff_lightning_upgraded";
  staff_water_upgraded.weapname = "staff_water_upgraded";
  staff_air_upgraded.w_weapon = getweapon("staff_air_upgraded");
  staff_fire_upgraded.w_weapon = getweapon("staff_fire_upgraded");
  staff_lightning_upgraded.w_weapon = getweapon("staff_lightning_upgraded");
  staff_water_upgraded.w_weapon = getweapon("staff_water_upgraded");
  staff_air_upgraded.base_weapname = "staff_air";
  staff_fire_upgraded.base_weapname = "staff_fire";
  staff_lightning_upgraded.base_weapname = "staff_lightning";
  staff_water_upgraded.base_weapname = "staff_water";
  staff_air_upgraded.element = "air";
  staff_fire_upgraded.element = "fire";
  staff_lightning_upgraded.element = "lightning";
  staff_water_upgraded.element = "water";
  staff_air_upgraded.charger = staff_air.charger;
  staff_fire_upgraded.charger = staff_fire.charger;
  staff_lightning_upgraded.charger = staff_lightning.charger;
  staff_water_upgraded.charger = staff_water.charger;
  staff_fire_upgraded.enum = 1;
  staff_air_upgraded.enum = 2;
  staff_lightning_upgraded.enum = 3;
  staff_water_upgraded.enum = 4;
  staff_air.upgrade = staff_air_upgraded;
  staff_fire.upgrade = staff_fire_upgraded;
  staff_water.upgrade = staff_water_upgraded;
  staff_lightning.upgrade = staff_lightning_upgraded;
  level.a_elemental_staffs_upgraded = [];
  level.a_elemental_staffs_upgraded["staff_air_upgraded"] = staff_air_upgraded;
  level.a_elemental_staffs_upgraded["staff_fire_upgraded"] = staff_fire_upgraded;
  level.a_elemental_staffs_upgraded["staff_lightning_upgraded"] = staff_lightning_upgraded;
  level.a_elemental_staffs_upgraded["staff_water_upgraded"] = staff_water_upgraded;
  foreach(staff_upgraded in level.a_elemental_staffs_upgraded) {
    staff_upgraded.charger.charges_received = 0;
    staff_upgraded.charger.is_inserted = 0;
    staff_upgraded.charger.is_charged = 0;
    staff_upgraded.prev_ammo_clip = staff_upgraded.w_weapon.clipsize;
    staff_upgraded.prev_ammo_stock = staff_upgraded.w_weapon.startammo;
    staff_upgraded thread place_staffs_encasement();
    staff_upgraded ghost();
  }
  foreach(staff in level.a_elemental_staffs) {
    staff.prev_ammo_clip = staff.w_weapon.clipsize;
    staff.prev_ammo_stock = staff.w_weapon.startammo;
    staff.upgrade.downgrade = staff;
  }
  level.var_2b2f83e5 = getweapon("staff_revive");
  level.staffs_charged = 0;
  array::thread_all(level.zombie_spawners, &spawner::add_spawn_function, &zombie_spawn_func);
  level thread watch_for_staff_upgrades();
  level thread chambers_init();
  level thread zm_tomb_quest_air::main();
  level thread zm_tomb_quest_fire::main();
  level thread zm_tomb_quest_ice::main();
  level thread zm_tomb_quest_elec::main();
  level thread zm_tomb_quest_crypt::main();
  level thread zm_tomb_chamber::main();
  level thread zm_tomb_vo::watch_occasional_line("puzzle", "puzzle_confused", "vo_puzzle_confused");
  level thread zm_tomb_vo::watch_occasional_line("puzzle", "puzzle_good", "vo_puzzle_good");
  level thread zm_tomb_vo::watch_occasional_line("puzzle", "puzzle_bad", "vo_puzzle_bad");
  level thread zm_tomb_vo::watch_one_shot_samantha_clue("vox_sam_ice_staff_clue_0", "sam_clue_dig", "elemental_staff_water_all_pieces_found");
  level thread zm_tomb_vo::watch_one_shot_samantha_clue("vox_sam_fire_staff_clue_0", "sam_clue_mechz", "mechz_killed");
  level thread zm_tomb_vo::watch_one_shot_samantha_clue("vox_sam_fire_staff_clue_1", "sam_clue_biplane", "biplane_down");
  level thread zm_tomb_vo::watch_one_shot_samantha_clue("vox_sam_fire_staff_clue_2", "sam_clue_zonecap", "staff_piece_capture_complete");
  level thread zm_tomb_vo::watch_one_shot_samantha_clue("vox_sam_lightning_staff_clue_0", "sam_clue_tank", "elemental_staff_lightning_all_pieces_found");
  level thread zm_tomb_vo::watch_one_shot_samantha_clue("vox_sam_wind_staff_clue_0", "sam_clue_giant", "elemental_staff_air_all_pieces_found");
  level.dig_spawners = getEntArray("zombie_spawner_dig", "script_noteworthy");
  array::thread_all(level.dig_spawners, &spawner::add_spawn_function, &zm_tomb_utility::dug_zombie_spawn_init);
}

function onplayerconnect() {}

function player_disconnect_callback(player) {
  var_d95a0cf3 = player.characterindex + 1;
  level util::delay(0.5, undefined, &zm_tomb_craftables::clear_player_staff_by_player_number, var_d95a0cf3);
}

function place_staffs_encasement() {
  self.origin = self.charger.origin;
  self.angles = self.charger.angles;
}

function chambers_init() {
  level flag::init("gramophone_placed");
  array::thread_all(getEntArray("trigger_death_floor", "targetname"), &monitor_chamber_death_trigs);
  a_stargate_gramophones = struct::get_array("stargate_gramophone_pos", "targetname");
  array::thread_all(a_stargate_gramophones, &run_gramophone_teleporter);
  a_door_main = getEntArray("chamber_entrance", "targetname");
  foreach(e_door in a_door_main) {
    if(e_door.classname == "script_brushmodel") {
      e_door connectpaths();
    }
  }
  a_door_main[0] linkto(a_door_main[1]);
  a_door_main[1] thread run_gramophone_door("vinyl_master", a_door_main[0]);
}

function monitor_chamber_death_trigs() {
  while(true) {
    self waittill("trigger", ent);
    if(isPlayer(ent)) {
      ent.bleedout_time = 0;
    }
    ent dodamage(ent.health + 666, ent.origin);
    wait(0.05);
  }
}

function watch_gramophone_vinyl_pickup() {
  str_vinyl_record = "vinyl_main";
  switch (self.script_int) {
    case 1: {
      str_vinyl_record = "vinyl_fire";
      break;
    }
    case 2: {
      str_vinyl_record = "vinyl_air";
      break;
    }
    case 3: {
      str_vinyl_record = "vinyl_elec";
      break;
    }
    case 4: {
      str_vinyl_record = "vinyl_ice";
      break;
    }
    default: {
      str_vinyl_record = "vinyl_master";
      break;
    }
  }
  level waittill(("gramophone_" + str_vinyl_record) + "_picked_up");
  self.has_vinyl = 1;
}

function get_gramophone_song() {
  switch (self.script_int) {
    case 1: {
      return "mus_gramophone_fire";
      break;
    }
    case 2: {
      return "mus_gramophone_air";
      break;
    }
    case 3: {
      return "mus_gramophone_electric";
      break;
    }
    case 4: {
      return "mus_gramophone_ice";
      break;
    }
    default: {
      return "mus_gramophone_electric";
      break;
    }
  }
}

function run_gramophone_teleporter(str_vinyl_record) {
  self.has_vinyl = 0;
  self.gramophone_model = undefined;
  self thread watch_gramophone_vinyl_pickup();
  t_gramophone = zm_tomb_utility::tomb_spawn_trigger_radius(self.origin, 60, 1);
  t_gramophone zm_tomb_utility::set_unitrigger_hint_string(&"ZOMBIE_BUILD_PIECE_MORE");
  level waittill("gramophone_vinyl_player_picked_up");
  str_craftablename = "gramophone";
  t_gramophone zm_tomb_utility::set_unitrigger_hint_string(&"ZM_TOMB_RU");
  while(!self.has_vinyl) {
    wait(0.05);
  }
  t_gramophone zm_tomb_utility::set_unitrigger_hint_string(&"ZM_TOMB_PLGR");
  while(true) {
    t_gramophone waittill("trigger", player);
    if(!isDefined(self.gramophone_model)) {
      if(!level flag::get("gramophone_placed")) {
        self.gramophone_model = spawn("script_model", self.origin);
        self.gramophone_model.angles = self.angles;
        self.gramophone_model setModel("p7_spl_gramophone");
        level clientfield::set("piece_record_zm_player", 0);
        level flag::set("gramophone_placed");
        t_gramophone zm_tomb_utility::set_unitrigger_hint_string("");
        str_song_id = self get_gramophone_song();
        self.gramophone_model playSound(str_song_id);
        player thread zm_tomb_vo::play_gramophone_place_vo();
        zm_tomb_teleporter::stargate_teleport_enable(self.script_int);
        level flag::wait_till("teleporter_building_" + self.script_int);
        level flag::wait_till_clear("teleporter_building_" + self.script_int);
        t_gramophone zm_tomb_utility::set_unitrigger_hint_string(&"ZM_TOMB_PUGR");
        if(isDefined(self.script_flag)) {
          level flag::set(self.script_flag);
        }
      } else {
        player zm_tomb_utility::door_gramophone_elsewhere_hint();
      }
    } else {
      self.gramophone_model delete();
      self.gramophone_model = undefined;
      player playSound("zmb_craftable_pickup");
      level flag::clear("gramophone_placed");
      level clientfield::set("piece_record_zm_player", 1);
      zm_tomb_teleporter::stargate_teleport_disable(self.script_int);
      t_gramophone zm_tomb_utility::set_unitrigger_hint_string(&"ZM_TOMB_PLGR");
    }
  }
}

function door_watch_open_sesame() {
  level util::waittill_any("", "");
  self.has_vinyl = 1;
  level.b_open_all_gramophone_doors = 1;
  wait(0.5);
  if(isDefined(self.trigger)) {
    self.trigger notify("trigger", getplayers()[0]);
  }
}

function run_gramophone_door(str_vinyl_record, var_ac769486) {
  level flag::init(self.targetname + "_opened");
  level flag::init("crypt_opened");
  trig_position = struct::get(self.targetname + "_position", "targetname");
  trig_position.has_vinyl = 0;
  trig_position.gramophone_model = undefined;
  trig_position thread watch_gramophone_vinyl_pickup();
  trig_position thread door_watch_open_sesame();
  t_door = zm_tomb_utility::tomb_spawn_trigger_radius(trig_position.origin, 60, 1, undefined, &function_ed81ffaa);
  t_door zm_tomb_utility::set_unitrigger_hint_string(&"ZOMBIE_BUILD_PIECE_MORE");
  level util::waittill_any("gramophone_vinyl_player_picked_up", "open_sesame", "open_all_gramophone_doors");
  str_craftablename = "gramophone";
  t_door zm_tomb_utility::set_unitrigger_hint_string(&"ZM_TOMB_RU");
  trig_position.trigger = t_door;
  while(!trig_position.has_vinyl) {
    wait(0.05);
  }
  t_door zm_tomb_utility::set_unitrigger_hint_string(&"ZM_TOMB_PLGR");
  while(true) {
    t_door waittill("trigger", player);
    if(!isDefined(trig_position.gramophone_model)) {
      if(!level flag::get("gramophone_placed") || (isDefined(level.b_open_all_gramophone_doors) && level.b_open_all_gramophone_doors)) {
        if(!(isDefined(level.b_open_all_gramophone_doors) && level.b_open_all_gramophone_doors)) {
          trig_position.gramophone_model = spawn("script_model", trig_position.origin);
          trig_position.gramophone_model.angles = trig_position.angles;
          trig_position.gramophone_model setModel("p7_spl_gramophone");
          level flag::set("gramophone_placed");
          level clientfield::set("piece_record_zm_player", 0);
        }
        str_song = trig_position get_gramophone_song();
        playsoundatposition(str_song, self.origin);
        t_door zm_tomb_utility::set_unitrigger_hint_string("");
        self playSound("zmb_crypt_stairs");
        wait(6);
        chamber_blocker();
        level flag::set(self.targetname + "_opened");
        if(isDefined(trig_position.script_flag)) {
          level flag::set(trig_position.script_flag);
        }
        level clientfield::set("crypt_open_exploder", 1);
        self movez(-260, 10, 1, 1);
        self waittill("movedone");
        var_ac769486 connectpaths();
        var_ac769486 delete();
        self delete();
        t_door zm_tomb_utility::set_unitrigger_hint_string(&"ZM_TOMB_PUGR");
        if(isDefined(level.b_open_all_gramophone_doors) && level.b_open_all_gramophone_doors) {
          break;
        }
      } else {
        player zm_tomb_utility::door_gramophone_elsewhere_hint();
      }
    } else {
      trig_position.gramophone_model delete();
      trig_position.gramophone_model = undefined;
      level flag::clear("gramophone_placed");
      level flag::set("crypt_opened");
      player playSound("zmb_craftable_pickup");
      level clientfield::set("piece_record_zm_player", 1);
      break;
    }
  }
  t_door zm_tomb_utility::tomb_unitrigger_delete();
  trig_position.trigger = undefined;
}

function function_ed81ffaa(player) {
  if(level flag::get("crypt_opened") || (isDefined(level.b_open_all_gramophone_doors) && level.b_open_all_gramophone_doors)) {
    return false;
  }
  return true;
}

function chamber_blocker() {
  a_blockers = getEntArray("junk_nml_chamber", "targetname");
  m_blocker = getent("junk_nml_chamber", "targetname");
  s_blocker_end = struct::get(m_blocker.script_linkto, "script_linkname");
  m_blocker thread zm_blockers::debris_move(s_blocker_end);
  m_blocker_clip = getent("junk_nml_chamber_clip", "targetname");
  m_blocker_clip connectpaths();
  m_blocker waittill("movedone");
  m_blocker_clip delete();
}

function watch_for_staff_upgrades() {
  foreach(staff in level.a_elemental_staffs) {
    staff thread staff_upgrade_watch();
  }
}

function staff_upgrade_watch() {
  level flag::wait_till(self.weapname + "_upgrade_unlocked");
  self thread place_staff_in_charger();
}

function staff_get_pickup_message() {
  if(self.element == "air") {
    return &"ZM_TOMB_PUAS";
  }
  if(self.element == "fire") {
    return &"ZM_TOMB_PUFS";
  }
  if(self.element == "lightning") {
    return &"ZM_TOMB_PULS";
  }
  return &"ZM_TOMB_PUIS";
}

function staff_get_insert_message() {
  if(self.element == "air") {
    return &"ZM_TOMB_INAS";
  }
  if(self.element == "fire") {
    return &"ZM_TOMB_INFS";
  }
  if(self.element == "lightning") {
    return &"ZM_TOMB_INLS";
  }
  return &"ZM_TOMB_INWS";
}

function player_has_staff() {
  a_weapons = self getweaponslistprimaries();
  foreach(weapon in a_weapons) {
    if(issubstr(weapon.name, "staff")) {
      return true;
    }
  }
  return false;
}

function can_pickup_staff() {
  b_has_staff = self player_has_staff();
  w_current = self getcurrentweapon();
  b_staff_equipped = issubstr(w_current.name, "staff");
  if(b_has_staff && !b_staff_equipped) {
    self thread zm_tomb_utility::swap_staff_hint();
  }
  return !b_has_staff || b_staff_equipped;
}

function watch_for_player_pickup_staff() {
  staff_picked_up = 0;
  pickup_message = self staff_get_pickup_message();
  self.trigger zm_tomb_utility::set_unitrigger_hint_string(pickup_message);
  self show();
  while(!staff_picked_up) {
    self.trigger waittill("trigger", player);
    self notify("retrieved", player);
    if(player can_pickup_staff() && !player bgb::is_enabled("zm_bgb_disorderly_combat")) {
      weapon_drop = player getcurrentweapon();
      a_weapons = player getweaponslistprimaries();
      n_max_other_weapons = zm_utility::get_player_weapon_limit(player) - 1;
      if(a_weapons.size > n_max_other_weapons) {
        player takeweapon(weapon_drop);
      }
      foreach(weapon in a_weapons) {
        if(issubstr(weapon.name, "staff")) {
          player takeweapon(weapon);
        }
      }
      player thread watch_staff_ammo_reload();
      self ghost();
      self setinvisibletoall();
      player giveweapon(self.w_weapon);
      player switchtoweapon(self.w_weapon);
      clip_size = self.w_weapon.clipsize;
      player setweaponammoclip(self.w_weapon, clip_size);
      self.owner = player;
      level notify("stop_staff_sound");
      self notify("staff_equip");
      staff_picked_up = 1;
      self.charger.is_inserted = 0;
      self clientfield::set("staff_charger", 0);
      self.charger.full = 1;
      zm_tomb_craftables::set_player_staff(self.w_weapon, player);
    }
  }
}

function watch_staff_ammo_reload() {
  self endon("disconnect");
  while(true) {
    self waittill("zmb_max_ammo");
    a_weapons = self getweaponslistprimaries();
    foreach(weapon in a_weapons) {
      if(issubstr(weapon.name, "staff")) {
        self setweaponammoclip(weapon, weapon.maxammo);
      }
    }
  }
}

function rotate_forever(rotate_time = 20) {
  self endon("death");
  while(true) {
    self rotateyaw(360, 20, 0, 0);
    self waittill("rotatedone");
  }
}

function staff_crystal_wait_for_teleport(n_element_enum) {
  level flag::init("charger_ready_" + n_element_enum);
  self zm_tomb_craftables::craftable_waittill_spawned();
  self.origin = self.piecespawn.model.origin;
  self.piecespawn.model ghost();
  self.piecespawn.model movez(-1000, 0.05);
  e_plinth = getent("crystal_plinth" + n_element_enum, "targetname");
  e_plinth.v_start = e_plinth.origin;
  e_plinth.v_crystal = e_plinth.origin;
  e_plinth.v_crystal = (e_plinth.v_crystal[0], e_plinth.v_crystal[1], e_plinth.origin[2] + 30);
  e_plinth.v_staff = e_plinth.origin;
  e_plinth.v_staff = (e_plinth.v_staff[0], e_plinth.v_staff[1], e_plinth.origin[2] + 110);
  e_plinth moveto(e_plinth.v_start, 0.05);
  while(true) {
    level waittill("player_teleported", e_player, n_teleport_enum);
    if(n_teleport_enum == n_element_enum) {
      break;
    }
  }
  e_plinth moveto(e_plinth.v_crystal, 6);
  e_plinth thread sndmoveplinth(6);
  lookat_dot = cos(90);
  dist_sq = 250000;
  lookat_time = 0;
  while(lookat_time < 1 && isDefined(self.piecespawn.model)) {
    wait(0.1);
    if(!isDefined(self.piecespawn.model)) {
      break;
    }
    if(self.piecespawn.model zm_tomb_utility::any_player_looking_at_plinth(lookat_dot, dist_sq)) {
      lookat_time = lookat_time + 0.1;
    } else {
      lookat_time = 0;
    }
  }
  if(isDefined(self.piecespawn.model)) {
    self.piecespawn.model movez(985, 0.05);
    self.piecespawn.model waittill("movedone");
    self.piecespawn.model show();
    self.piecespawn.model thread rotate_forever();
    self.piecespawn.model movez(15, 2);
    self.piecespawn.model playLoopSound("zmb_squest_crystal_loop", 4.25);
  }
  level flag::wait_till("charger_ready_" + n_element_enum);
  while(!zm_tomb_chamber::is_chamber_occupied()) {
    util::wait_network_frame();
  }
  e_plinth moveto(e_plinth.v_staff, 3);
  e_plinth thread sndmoveplinth(3);
  e_plinth waittill("movedone");
}

function sndmoveplinth(time) {
  self notify("sndmoveplinth");
  self endon("sndmoveplinth");
  self playLoopSound("zmb_chamber_plinth_move", 0.25);
  wait(time);
  self stoploopsound(0.1);
  self playSound("zmb_chamber_plinth_stop");
}

function staff_mechz_drop_pieces(s_piece) {
  s_piece zm_tomb_craftables::craftable_waittill_spawned();
  s_piece.piecespawn.model ghost();
  for(i = 0; i < 1; i++) {
    level waittill("mechz_killed", origin);
  }
  s_piece.piecespawn.canmove = 1;
  zm_unitrigger::reregister_unitrigger_as_dynamic(s_piece.piecespawn.unitrigger);
  origin = zm_utility::groundpos_ignore_water_new(origin + vectorscale((0, 0, 1), 40));
  s_piece.piecespawn.model moveto(origin + vectorscale((0, 0, 1), 16), 0.05);
  s_piece.piecespawn.model waittill("movedone");
  if(isDefined(s_piece.piecespawn.model)) {
    s_piece.piecespawn.model show();
    s_piece.piecespawn.model notify("staff_piece_glow");
    s_piece.piecespawn.model thread mechz_staff_piece_failsafe();
  }
}

function mechz_staff_piece_failsafe() {
  min_dist_sq = 1000000;
  self endon("death");
  wait(120);
  while(true) {
    a_players = getplayers();
    b_anyone_near = 0;
    foreach(e_player in a_players) {
      dist_sq = distance2dsquared(e_player.origin, self.origin);
      if(dist_sq < min_dist_sq) {
        b_anyone_near = 1;
      }
    }
    if(!b_anyone_near) {
      break;
    }
    wait(1);
  }
  a_locations = struct::get_array("mechz_location", "script_noteworthy");
  s_location = zm_utility::get_closest_2d(self.origin, a_locations);
  self moveto(s_location.origin + vectorscale((0, 0, 1), 32), 3);
}

function biplane_clue() {
  self endon("death");
  level endon("biplane_down");
  while(true) {
    cur_round = level.round_number;
    while(level.round_number == cur_round) {
      wait(1);
    }
    wait(randomfloatrange(5, 15));
    a_players = getplayers();
    foreach(e_player in a_players) {
      level notify("sam_clue_biplane", e_player);
    }
  }
}

function staff_biplane_drop_pieces(a_staff_pieces) {
  foreach(staff_piece in a_staff_pieces) {
    staff_piece zm_tomb_craftables::craftable_waittill_spawned();
    staff_piece.origin = staff_piece.piecespawn.model.origin;
    staff_piece.piecespawn.model ghost();
    staff_piece.piecespawn.model movez(-500, 0.05);
  }
  level flag::wait_till("activate_zone_village_0");
  cur_round = level.round_number;
  while(level.round_number == cur_round) {
    wait(1);
  }
  s_biplane_pos = struct::get("air_crystal_biplane_pos", "targetname");
  vh_biplane = spawnvehicle("biplane_zm", s_biplane_pos.origin, s_biplane_pos.angles, "air_crystal_biplane");
  vh_biplane flag::init("biplane_down", 0);
  vh_biplane thread biplane_clue();
  e_fx_tag = getent("air_crystal_biplane_tag", "targetname");
  e_fx_tag moveto(vh_biplane.origin, 0.05);
  e_fx_tag waittill("movedone");
  e_fx_tag linkto(vh_biplane);
  vh_biplane.health = 10000;
  vh_biplane setCanDamage(1);
  vh_biplane setforcenocull();
  vh_biplane attachpath(getvehiclenode("biplane_start", "targetname"));
  vh_biplane setspeed(75, 15, 5);
  vh_biplane startpath();
  e_fx_tag clientfield::set("plane_fx", 1);
  s_biplane_pos struct::delete();
  vh_biplane flag::wait_till("biplane_down");
  vh_biplane playSound("zmb_zombieblood_3rd_plane_explode");
  vh_biplane delete();
  e_fx_tag clientfield::set("plane_fx", 0);
  playFX(level._effect["biplane_explode"], e_fx_tag.origin);
  foreach(staff_piece in a_staff_pieces) {
    staff_piece.e_fx = spawn("script_model", e_fx_tag.origin);
    staff_piece.e_fx setModel("tag_origin");
    staff_piece.e_fx clientfield::set("glow_biplane_trail_fx", 1);
    staff_piece.e_fx moveto(staff_piece.origin, 5);
  }
  a_staff_pieces[0].e_fx waittill("movedone");
  e_fx_tag delete();
  foreach(staff_piece in a_staff_pieces) {
    staff_piece.piecespawn.model movez(500, 0.05);
    staff_piece.piecespawn.model waittill("movedone");
    staff_piece.piecespawn.model show();
    staff_piece.piecespawn.model notify("staff_piece_glow");
    staff_piece.e_fx delete();
  }
}

function aircrystalbiplanecallback_vehicledamage(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, vdamageorigin, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name, vsurfacenormal) {
  if(isPlayer(e_attacker) && self.vehicletype == "biplane_zm" && !self flag::get("biplane_down")) {
    self flag::set("biplane_down");
    level notify("biplane_down");
  }
  return n_damage;
}

function zone_capture_clue(str_zone) {
  level endon("staff_piece_capture_complete");
  while(true) {
    wait(5);
    while(!level.zones[str_zone].is_occupied) {
      wait(1);
    }
    a_players = getplayers();
    foreach(e_player in a_players) {
      level notify("sam_clue_zonecap", e_player);
    }
  }
}

function staff_unlock_with_zone_capture(s_staff_piece) {
  s_staff_piece zm_tomb_craftables::craftable_waittill_spawned();
  str_zone = zm_zonemgr::get_zone_from_position(s_staff_piece.piecespawn.model.origin, 1);
  if(!isDefined(str_zone)) {
    assertmsg("");
    return;
  }
  level thread zone_capture_clue(str_zone);
  s_staff_piece.piecespawn.model ghost();
  while(true) {
    level waittill("zone_captured_by_player", str_captured_zone);
    if(str_captured_zone == str_zone) {
      break;
    }
  }
  level notify("staff_piece_capture_complete");
  foreach(uts_box in level.a_uts_challenge_boxes) {
    if(uts_box.str_location == "church_capture") {
      uts_box.s_staff_piece = s_staff_piece;
      level thread zm_challenges_tomb::open_box(undefined, uts_box, &reward_staff_piece);
      return;
    }
  }
}

function reward_staff_piece(player, s_stat) {
  m_piece = spawn("script_model", self.origin);
  m_piece.angles = self.angles + vectorscale((0, 1, 0), 180);
  m_piece setModel("wpn_t7_zmb_hd_staff_tip_fire_world");
  m_piece.origin = self.origin;
  m_piece.angles = self.angles + vectorscale((0, 1, 0), 90);
  m_piece clientfield::set("element_glow_fx", 1);
  util::wait_network_frame();
  if(!zm_challenges_tomb::reward_rise_and_grab(m_piece, 50, 2, 2, -1)) {
    return false;
  }
  n_dist = 9999;
  a_players = getplayers();
  a_players = util::get_array_of_closest(self.m_box.origin, a_players);
  if(isDefined(a_players[0])) {
    a_players[0] zm_craftables::player_take_piece(self.s_staff_piece.piecespawn);
  }
  m_piece delete();
  return true;
}

function dig_spot_get_staff_piece(e_player) {
  level notify("sam_clue_dig", e_player);
  str_zone = self.str_zone;
  foreach(s_staff in level.ice_staff_pieces) {
    if(!isDefined(s_staff.num_misses)) {
      s_staff.num_misses = 0;
    }
    if(issubstr(str_zone, s_staff.zone_substr)) {
      miss_chance = 100 / (s_staff.num_misses + 1);
      if(level.weather_snow <= 0) {
        miss_chance = 101;
      }
      if(randomint(100) > miss_chance || (s_staff.num_misses > 3 && miss_chance < 100)) {
        return s_staff;
      }
      s_staff.num_misses++;
      break;
    }
  }
  return undefined;
}

function show_ice_staff_piece(origin) {
  arrayremovevalue(level.ice_staff_pieces, self);
  wait(0.5);
  self.piecespawn.canmove = 1;
  zm_unitrigger::reregister_unitrigger_as_dynamic(self.piecespawn.unitrigger);
  vert_offset = 32;
  self.piecespawn.model moveto(origin + (0, 0, vert_offset), 0.05);
  self.piecespawn.model waittill("movedone");
  self.piecespawn.model showindemo();
  self.piecespawn.model show();
  self.piecespawn.model notify("staff_piece_glow");
  self.piecespawn.model playSound("evt_staff_digup");
  self.piecespawn.model playLoopSound("evt_staff_digup_lp");
}

function staff_ice_dig_pieces(a_staff_pieces) {
  level flagsys::wait_till("start_zombie_round_logic");
  level.ice_staff_pieces = arraycopy(a_staff_pieces);
  foreach(s_piece in level.ice_staff_pieces) {
    s_piece zm_tomb_craftables::craftable_waittill_spawned();
    s_piece.piecespawn.model ghost();
  }
  level.ice_staff_pieces[0].zone_substr = "bunker";
  level.ice_staff_pieces[1].zone_substr = "nml";
  level.ice_staff_pieces[2].zone_substr = "village";
  level.ice_staff_pieces[2].num_misses = 2;
}

function crystal_play_glow_fx(s_crystal) {
  level flag::wait_till("start_zombie_round_logic");
  switch (s_crystal.modelname) {
    case "t6_wpn_zmb_staff_crystal_air_part": {
      watch_for_crystal_pickup(s_crystal, 2);
      break;
    }
    case "t6_wpn_zmb_staff_crystal_fire_part": {
      watch_for_crystal_pickup(s_crystal, 1);
      break;
    }
    case "t6_wpn_zmb_staff_crystal_bolt_part": {
      watch_for_crystal_pickup(s_crystal, 3);
      break;
    }
    case "t6_wpn_zmb_staff_crystal_water_part": {
      watch_for_crystal_pickup(s_crystal, 4);
      break;
    }
  }
}

function watch_for_crystal_pickup(s_crystal, n_enum) {
  s_crystal.piecespawn.model clientfield::set("element_glow_fx", n_enum);
  s_crystal.piecespawn waittill("pickup");
  self playSound("evt_crystal");
  level.n_crystals_pickedup++;
}

function crystal_dropped(s_crystal) {
  level flag::wait_till("start_zombie_round_logic");
  s_crystal.piecespawn waittill("piece_released");
  level.n_crystals_pickedup--;
  level thread crystal_play_glow_fx(s_crystal);
}

function staff_charger_get_player_msg(e_player) {
  weapon_available = 1;
  charge_ready = 0;
  if(self.stub.staff_data.charger.is_inserted) {
    if(self.stub.staff_data.charger.is_charged) {
      charge_ready = 1;
    }
  }
  if(e_player bgb::is_enabled("zm_bgb_disorderly_combat")) {
    return "";
  }
  if(e_player hasweapon(self.stub.staff_data.w_weapon)) {
    msg = self.stub.staff_data staff_get_insert_message();
    return msg;
  }
  if(charge_ready) {
    msg = self.stub.staff_data staff_get_pickup_message();
    return msg;
  }
  return "";
}

function place_staff_in_charger() {
  level flag::set("charger_ready_" + self.enum);
  v_trigger_pos = self.charger.origin;
  v_trigger_pos = (v_trigger_pos[0], v_trigger_pos[1], v_trigger_pos[2] - 30);
  if(isDefined(self.charge_trigger)) {
    self.charge_trigger zm_tomb_utility::tomb_unitrigger_delete();
  }
  self.charge_trigger = zm_tomb_utility::tomb_spawn_trigger_radius(v_trigger_pos, 120, 1, &staff_charger_get_player_msg);
  self.charge_trigger.require_look_at = 1;
  self.charge_trigger.staff_data = self;
  waittill_staff_inserted();
}

function debug_staff_charge() {
  if(!isDefined(self.charger.charges_received)) {
    self.charger.charges_received = 0;
  }
  while(self.charger.is_inserted) {
    if(self.charger.is_charged) {
      maxammo = self.w_weapon.maxammo;
      if(!isDefined(self.prev_ammo_stock)) {
        self.prev_ammo_stock = maxammo;
      }
      print3d(self.origin, (self.prev_ammo_stock + "") + maxammo, vectorscale((1, 1, 1), 255), 1);
    } else {
      print3d(self.origin, (self.charger.charges_received + "") + 20, vectorscale((1, 1, 1), 255), 1);
    }
    wait(0.05);
  }
}

function waittill_staff_inserted() {
  while(true) {
    self.charge_trigger waittill("trigger", player);
    weapon_available = 1;
    if(isDefined(player)) {
      weapon_available = player hasweapon(self.w_weapon);
      if(weapon_available) {
        player takeweapon(self.w_weapon);
      }
    }
    if(weapon_available) {
      self.charger.is_inserted = 1;
      self thread debug_staff_charge();
      zm_tomb_craftables::clear_player_staff(self.w_weapon);
      n_player = player getentitynumber();
      self.charge_trigger.playertrigger[n_player] zm_tomb_utility::tomb_trigger_update_message(&staff_charger_get_player_msg);
      self.angles = (270, 90, 0);
      self moveto(self.charger.origin, 0.05);
      self waittill("movedone");
      self clientfield::set("staff_charger", self.enum);
      self.charger.full = 0;
      self show();
      self playSound("zmb_squest_charge_place_staff");
      return;
    }
  }
}

function zombie_spawn_func() {
  self.actor_killed_override = &zombie_killed_override;
}

function zombie_killed_override(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime) {
  if(level flag::get("ee_sam_portal_active") && !level flag::get("ee_souls_absorbed")) {
    zm_tomb_ee_main_step_7::ee_zombie_killed_override(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime);
    return;
  }
  if(zm_tomb_challenges::footprint_zombie_killed(attacker)) {
    return;
  }
  n_max_dist_sq = 9000000;
  if(isPlayer(attacker) || sweapon == level.var_653c9585) {
    if(!level flag::get("fire_puzzle_1_complete")) {
      zm_tomb_quest_fire::sacrifice_puzzle_zombie_killed(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime);
    }
    s_nearest_staff = undefined;
    n_nearest_dist_sq = n_max_dist_sq;
    foreach(staff in level.a_elemental_staffs) {
      if(isDefined(staff.charger.full) && staff.charger.full) {
        continue;
      }
      if(staff.charger.is_inserted || staff.upgrade.charger.is_inserted) {
        if(!(isDefined(staff.charger.is_charged) && staff.charger.is_charged)) {
          dist_sq = distance2dsquared(self.origin, staff.origin);
          if(dist_sq <= n_nearest_dist_sq) {
            n_nearest_dist_sq = dist_sq;
            s_nearest_staff = staff;
          }
        }
      }
    }
    if(isDefined(s_nearest_staff)) {
      if(s_nearest_staff.charger.is_charged) {} else {
        s_nearest_staff.charger.charges_received++;
        s_nearest_staff.charger thread zombie_soul_to_charger(self, s_nearest_staff.enum);
      }
    }
  }
}

function zombie_soul_to_charger(ai_zombie, n_element) {
  ai_zombie clientfield::set("zombie_soul", n_element);
  wait(1.5);
  self notify("soul_received");
}

function staff_charger_check() {
  self.charger.is_charged = 0;
  level flag::wait_till(self.weapname + "_upgrade_unlocked");
  self showallparts();
  while(true) {
    if(self.charger.charges_received >= 20 || (getdvarint("zombie_cheat") >= 2 && self.charger.is_inserted)) {
      wait(0.5);
      self.charger.is_charged = 1;
      e_player = zm_utility::get_closest_player(self.charger.origin);
      e_player thread zm_tomb_vo::say_puzzle_completion_line(self.enum);
      self clientfield::set("staff_charger", 0);
      self.charger.full = 1;
      level clientfield::set(self.quest_clientfield, 4);
      foreach(player in level.players) {
        player thread zm_craftables::player_show_craftable_parts_ui(undefined, ("zmInventory." + self.element) + "_staff.visible", 0);
      }
      level thread spawn_upgraded_staff_triggers(self.enum);
      level.staffs_charged++;
      if(level.staffs_charged == 4) {
        level flag::set("ee_all_staffs_upgraded");
      }
      self thread staff_sound();
      break;
    }
    wait(1);
  }
}

function staff_sound() {
  self thread sndstaffupgradedstinger();
  self playSound("zmb_squest_charge_soul_full");
  self playLoopSound("zmb_squest_charge_soul_full_loop", 0.1);
  level waittill("stop_staff_sound");
  self stoploopsound(0.1);
}

function sndstaffupgradedstinger() {
  if(level.staffs_charged == 4) {
    level thread zm_tomb_amb::sndplaystinger("staff_all_upgraded");
    return;
  }
  if(self.weapname == "staff_air") {
    level thread zm_tomb_amb::sndplaystinger("staff_air_upgraded");
  }
  if(self.weapname == "staff_fire") {
    level thread zm_tomb_amb::sndplaystinger("staff_fire_upgraded");
  }
  if(self.weapname == "staff_lightning") {
    level thread zm_tomb_amb::sndplaystinger("staff_lightning_upgraded");
  }
  if(self.weapname == "staff_water") {
    level thread zm_tomb_amb::sndplaystinger("staff_ice_upgraded");
  }
}

function spawn_upgraded_staff_triggers(n_index) {
  e_staff_standard = zm_tomb_craftables::get_staff_info_from_element_index(n_index);
  e_staff_standard_upgraded = e_staff_standard.upgrade;
  e_staff_standard.charge_trigger.require_look_at = 1;
  pickup_message = e_staff_standard staff_get_pickup_message();
  e_staff_standard.charge_trigger zm_tomb_utility::set_unitrigger_hint_string(pickup_message);
  e_staff_standard ghost();
  e_staff_standard_upgraded.trigger = e_staff_standard.charge_trigger;
  e_staff_standard_upgraded.angles = (270, 90, 0);
  e_staff_standard_upgraded moveto(e_staff_standard.origin, 0.1);
  e_staff_standard_upgraded waittill("movedone");
  e_staff_standard_upgraded show();
  e_fx = spawn("script_model", e_staff_standard_upgraded.origin + vectorscale((0, 0, 1), 12));
  e_fx setModel("tag_origin");
  wait(0.6);
  e_fx clientfield::set("element_glow_fx", e_staff_standard.enum);
  e_staff_standard_upgraded watch_for_player_pickup_staff();
  player = e_staff_standard_upgraded.owner;
  e_fx delete();
  while(true) {
    if(e_staff_standard.charger.is_charged) {
      e_staff_standard_upgraded thread staff_upgraded_reload_monitor();
      break;
    }
    util::wait_network_frame();
  }
}

function staff_upgraded_reload_monitor() {
  self.weaponname = self.weapname;
  self thread zm_tomb_craftables::track_staff_weapon_respawn(self.owner);
  while(true) {
    place_staff_in_charger();
    self thread staff_upgraded_reload();
    self watch_for_player_pickup_staff();
    self.charger.is_inserted = 0;
    maxammo = self.w_weapon.maxammo;
    n_ammo = int(min(maxammo, self.prev_ammo_stock));
    if(isDefined(self.owner)) {
      self.owner setweaponammostock(self.w_weapon, n_ammo);
      self.owner setweaponammoclip(self.w_weapon, self.prev_ammo_clip);
      self thread zm_tomb_craftables::track_staff_weapon_respawn(self.owner);
    }
  }
}

function staff_upgraded_reload() {
  self endon("staff_equip");
  max_ammo = self.w_weapon.maxammo;
  n_count = int(max_ammo / 20);
  b_reloaded = 0;
  while(true) {
    self.charger waittill("soul_received");
    self.prev_ammo_stock = self.prev_ammo_stock + n_count;
    if(self.prev_ammo_stock > max_ammo) {
      self.prev_ammo_stock = max_ammo;
      self clientfield::set("staff_charger", 0);
      self.charger.full = 1;
    }
  }
}