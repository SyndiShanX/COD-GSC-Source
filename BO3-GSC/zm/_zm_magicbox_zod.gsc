/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_magicbox_zod.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#namespace zm_magicbox_zod;

function init() {
  registerclientfield("zbarrier", "magicbox_initial_fx", 1, 1, "int");
  registerclientfield("zbarrier", "magicbox_amb_sound", 1, 1, "int");
  registerclientfield("zbarrier", "magicbox_open_fx", 1, 2, "int");
  level._effect["box_light_marker"] = "zombie/fx_weapon_box_marker_zod_zmb";
  level._effect["box_light_flare"] = "zombie/fx_weapon_box_marker_fl_zod_zmb";
  level._effect["poltergeist"] = "tools/fx_null";
  level.chest_joker_model = "p7_zm_zod_magic_box_tentacle_teddy";
  level.chest_joker_custom_movement = &custom_joker_movement;
  level.custom_magic_box_timer_til_despawn = &custom_magic_box_timer_til_despawn;
  level.custom_magic_box_do_weapon_rise = &custom_magic_box_do_weapon_rise;
  level.custom_magic_box_weapon_wait = &custom_magic_box_weapon_wait;
  level.custom_pandora_show_func = &custom_pandora_show_func;
  level.custom_treasure_chest_glowfx = &custom_magic_box_fx;
  level.custom_firesale_box_leave = 1;
  level.custom_magicbox_float_height = 40;
  level.magic_box_zbarrier_state_func = &set_magic_box_zbarrier_state;
  level thread handle_fire_sale();
  level thread custom_magicbox_host_migration();
}

function custom_joker_movement() {
  v_origin = self.weapon_model.origin - vectorscale((0, 0, 1), 5);
  self.weapon_model delete();
  m_lock = spawn("script_model", v_origin);
  m_lock setModel(level.chest_joker_model);
  m_lock.angles = self.angles + vectorscale((0, 1, 0), 180);
  m_lock playSound("zmb_hellbox_bear");
  wait(0.5);
  level notify("weapon_fly_away_start");
  wait(1);
  m_lock rotateyaw(3000, 4.5, 4.5);
  wait(3);
  v_angles = anglesToForward(self.angles - vectorscale((1, 1, 0), 90));
  m_lock moveto(m_lock.origin + (35 * v_angles), 1.5, 1);
  m_lock waittill("movedone");
  m_lock moveto(m_lock.origin + -100 * v_angles, 0.5, 0.5);
  m_lock waittill("movedone");
  m_lock delete();
  self notify("box_moving");
  level notify("weapon_fly_away_end");
}

function custom_magic_box_timer_til_despawn(magic_box) {
  self endon("kill_weapon_movement");
  putbacktime = 12;
  v_float = anglestoup(self.angles) * level.custom_magicbox_float_height;
  self moveto(self.origin - (v_float * 0.4), putbacktime, putbacktime * 0.5);
  wait(putbacktime);
  if(isDefined(self)) {
    self delete();
  }
}

function custom_magic_box_fx() {}

function custom_pandora_fx_func() {
  self endon("death");
  self.pandora_light = util::spawn_model("tag_origin", self.zbarrier.origin, vectorscale((-1, 0, -1), 90));
  if(!(isDefined(level._box_initialized) && level._box_initialized)) {
    level flag::wait_till("start_zombie_round_logic");
    level._box_initialized = 1;
  }
  wait(1);
  if(isDefined(self.pandora_light)) {
    playFXOnTag(level._effect["box_light_marker"], self.pandora_light, "tag_origin");
  }
}

function custom_pandora_show_func() {
  if(!isDefined(self.pandora_light)) {
    if(!isDefined(level.pandora_fx_func)) {
      level.pandora_fx_func = &custom_pandora_fx_func;
    }
    self thread[[level.pandora_fx_func]]();
  }
  playFX(level._effect["box_light_flare"], self.pandora_light.origin);
}

function custom_magic_box_weapon_wait() {
  wait(0.5);
}

function set_magic_box_zbarrier_state(state) {
  for(i = 0; i < self getnumzbarrierpieces(); i++) {
    self hidezbarrierpiece(i);
  }
  self notify("zbarrier_state_change");
  switch (state) {
    case "away": {
      self showzbarrierpiece(0);
      self.state = "away";
      self.owner.is_locked = 0;
      break;
    }
    case "arriving": {
      self showzbarrierpiece(1);
      self thread magic_box_arrives();
      self.state = "arriving";
      break;
    }
    case "initial": {
      self showzbarrierpiece(1);
      self thread magic_box_initial();
      self thread zm_unitrigger::register_static_unitrigger(self.owner.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think);
      self.state = "close";
      break;
    }
    case "open": {
      self showzbarrierpiece(2);
      self thread magic_box_opens();
      self.state = "open";
      break;
    }
    case "close": {
      self showzbarrierpiece(2);
      self thread magic_box_closes();
      self.state = "close";
      break;
    }
    case "leaving": {
      self showzbarrierpiece(1);
      self thread magic_box_leaves();
      self.state = "leaving";
      self.owner.is_locked = 0;
      break;
    }
    default: {
      if(isDefined(level.custom_magicbox_state_handler)) {
        self[[level.custom_magicbox_state_handler]](state);
      }
      break;
    }
  }
}

function magic_box_initial() {
  level flag::wait_till("all_players_spawned");
  level flag::wait_till("zones_initialized");
  self setzbarrierpiecestate(1, "open");
  self clientfield::set("magicbox_amb_sound", 1);
  self clientfield::set("magicbox_open_fx", 3);
}

function magic_box_arrives() {
  self setzbarrierpiecestate(1, "opening");
  while(self getzbarrierpiecestate(1) == "opening") {
    wait(0.05);
  }
  self notify("arrived");
  self.state = "close";
  self clientfield::set("magicbox_amb_sound", 1);
}

function magic_box_leaves() {
  self clientfield::set("magicbox_open_fx", 0);
  self setzbarrierpiecestate(1, "closing");
  self playSound("zmb_hellbox_rise");
  while(self getzbarrierpiecestate(1) == "closing") {
    wait(0.1);
  }
  self notify("left");
  self clientfield::set("magicbox_open_fx", 2);
  self clientfield::set("magicbox_amb_sound", 0);
  if(!(isDefined(level.dig_magic_box_moved) && level.dig_magic_box_moved)) {
    level.dig_magic_box_moved = 1;
  }
}

function magic_box_opens() {
  self clientfield::set("magicbox_open_fx", 1);
  self setzbarrierpiecestate(2, "opening");
  self playSound("zmb_hellbox_open");
  while(self getzbarrierpiecestate(2) == "opening") {
    wait(0.1);
  }
  self notify("opened");
  self thread magic_box_open_idle();
}

function magic_box_open_idle() {
  self endon("stop_open_idle");
  self hidezbarrierpiece(2);
  self showzbarrierpiece(5);
  while(true) {
    self setzbarrierpiecestate(5, "opening");
    while(self getzbarrierpiecestate(5) != "open") {
      wait(0.05);
    }
  }
}

function magic_box_closes() {
  self notify("stop_open_idle");
  self hidezbarrierpiece(5);
  self showzbarrierpiece(2);
  self setzbarrierpiecestate(2, "closing");
  self playSound("zmb_hellbox_close");
  self clientfield::set("magicbox_open_fx", 0);
  while(self getzbarrierpiecestate(2) == "closing") {
    wait(0.1);
  }
  self notify("closed");
}

function custom_magic_box_do_weapon_rise() {
  self endon("box_hacked_respin");
  wait(0.5);
  self setzbarrierpiecestate(3, "closed");
  self setzbarrierpiecestate(4, "closed");
  util::wait_network_frame();
  self zbarrierpieceuseboxriselogic(3);
  self zbarrierpieceuseboxriselogic(4);
  self showzbarrierpiece(3);
  self showzbarrierpiece(4);
  self setzbarrierpiecestate(3, "opening");
  self setzbarrierpiecestate(4, "opening");
  while(self getzbarrierpiecestate(3) != "open") {
    wait(0.5);
  }
  self hidezbarrierpiece(3);
  self hidezbarrierpiece(4);
}

function handle_fire_sale() {
  while(true) {
    str_firesale_status = level util::waittill_any_return("fire_sale_off", "fire_sale_on");
    for(i = 0; i < level.chests.size; i++) {
      if(level.chest_index != i && isDefined(level.chests[i].was_temp)) {
        if(str_firesale_status == "fire_sale_on") {
          level.chests[i].zbarrier clientfield::set("magicbox_amb_sound", 1);
          level.chests[i].zbarrier clientfield::set("magicbox_open_fx", 3);
          continue;
        }
        level.chests[i].zbarrier clientfield::set("magicbox_amb_sound", 0);
        level.chests[i].zbarrier clientfield::set("magicbox_open_fx", 2);
      }
    }
  }
}

function custom_magicbox_host_migration() {
  level endon("end_game");
  level notify("mb_hostmigration");
  level endon("mb_hostmigration");
  while(true) {
    level waittill("host_migration_end");
    if(!isDefined(level.chests)) {
      continue;
    }
    foreach(chest in level.chests) {
      if(!(isDefined(chest.hidden) && chest.hidden)) {
        if(isDefined(chest) && isDefined(chest.pandora_light)) {
          playFXOnTag(level._effect["box_light_marker"], chest.pandora_light, "tag_origin");
        }
      }
      util::wait_network_frame();
    }
  }
}