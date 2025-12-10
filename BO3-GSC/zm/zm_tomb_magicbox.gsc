/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_magicbox.gsc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#namespace tomb_magicbox;

function autoexec __init__sytem__() {
  system::register("tomb_magicbox", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("zbarrier", "magicbox_initial_fx", 21000, 1, "int");
  clientfield::register("zbarrier", "magicbox_amb_fx", 21000, 2, "int");
  clientfield::register("zbarrier", "magicbox_open_fx", 21000, 1, "int");
  clientfield::register("zbarrier", "magicbox_leaving_fx", 21000, 1, "int");
  level.chest_joker_custom_movement = &custom_joker_movement;
  level.custom_magic_box_timer_til_despawn = &custom_magic_box_timer_til_despawn;
  level.custom_magic_box_do_weapon_rise = &custom_magic_box_do_weapon_rise;
  level.custom_magic_box_weapon_wait = &custom_magic_box_weapon_wait;
  level.custom_magicbox_float_height = 50;
  level.custom_magic_box_fx = &function_61903aae;
  level.custom_treasure_chest_glowfx = &function_e4e60ea;
  level.magic_box_zbarrier_state_func = &set_magic_box_zbarrier_state;
  level thread wait_then_create_base_magic_box_fx();
  level thread handle_fire_sale();
}

function function_61903aae() {}

function function_e4e60ea() {}

function custom_joker_movement() {
  v_origin = self.weapon_model.origin - vectorscale((0, 0, 1), 5);
  self.weapon_model delete();
  m_lock = util::spawn_model(level.chest_joker_model, v_origin, self.angles);
  m_lock playSound("zmb_hellbox_bear");
  wait(0.5);
  level notify("weapon_fly_away_start");
  wait(1);
  m_lock rotateyaw(3000, 4, 4);
  wait(3);
  v_angles = anglesToForward(self.angles - vectorscale((0, 1, 0), 90));
  m_lock moveto(m_lock.origin + (20 * v_angles), 0.5, 0.5);
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
  v_float = (anglesToForward(magic_box.angles - vectorscale((0, 1, 0), 90))) * 40;
  self moveto(self.origin - (v_float * 0.25), putbacktime, putbacktime * 0.5);
  wait(putbacktime);
  if(isDefined(self)) {
    self delete();
  }
}

function custom_magic_box_weapon_wait() {
  wait(0.5);
}

function wait_then_create_base_magic_box_fx() {
  while(!isDefined(level.chests)) {
    wait(0.5);
  }
  while(!isDefined(level.chests[level.chests.size - 1].zbarrier)) {
    wait(0.5);
  }
  foreach(chest in level.chests) {
    chest.zbarrier clientfield::set("magicbox_initial_fx", 1);
  }
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
      thread zm_unitrigger::register_static_unitrigger(self.owner.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think);
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
  self setzbarrierpiecestate(1, "open");
  wait(1);
  self clientfield::set("magicbox_amb_fx", 1);
}

function magic_box_arrives() {
  self clientfield::set("magicbox_leaving_fx", 0);
  self setzbarrierpiecestate(1, "opening");
  while(self getzbarrierpiecestate(1) == "opening") {
    wait(0.05);
  }
  self notify("arrived");
  self.state = "close";
  s_zone_capture_area = level.zone_capture.zones[self.zone_capture_area];
  if(isDefined(s_zone_capture_area)) {
    if(!s_zone_capture_area flag::get("player_controlled")) {
      self clientfield::set("magicbox_amb_fx", 1);
    } else {
      self clientfield::set("magicbox_amb_fx", 2);
    }
  }
}

function magic_box_leaves() {
  self notify("stop_open_idle");
  self clientfield::set("magicbox_leaving_fx", 1);
  self clientfield::set("magicbox_open_fx", 0);
  self setzbarrierpiecestate(1, "closing");
  self playSound("zmb_hellbox_rise");
  while(self getzbarrierpiecestate(1) == "closing") {
    wait(0.1);
  }
  self notify("left");
  s_zone_capture_area = level.zone_capture.zones[self.zone_capture_area];
  if(isDefined(s_zone_capture_area)) {
    if(s_zone_capture_area flag::get("player_controlled")) {
      self clientfield::set("magicbox_amb_fx", 3);
    } else {
      self clientfield::set("magicbox_amb_fx", 0);
    }
  }
  if(isDefined(level.dig_magic_box_moved) && !level.dig_magic_box_moved) {
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
    level waittill("fire_sale_off");
    for(i = 0; i < level.chests.size; i++) {
      if(level.chest_index != i && isDefined(level.chests[i].was_temp)) {
        if(isDefined(level.chests[i].zbarrier.zone_capture_area) && level.zone_capture.zones[level.chests[i].zbarrier.zone_capture_area] flag::get("player_controlled")) {
          level.chests[i].zbarrier clientfield::set("magicbox_amb_fx", 3);
          continue;
        }
        level.chests[i].zbarrier clientfield::set("magicbox_amb_fx", 0);
      }
    }
  }
}