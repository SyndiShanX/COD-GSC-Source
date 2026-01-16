/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_escape_magicbox.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_escape_pebble;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_escape_magicbox;

autoexec __init__system__() {
  system::register(#"zm_escape_magicbox", &__init__, &__main__, undefined);
}

__init__() {
  level.locked_magic_box_cost = 2000;
  level.custom_magicbox_state_handler = &set_locked_magicbox_state;
  level.var_f39bb42a = &watch_for_lock;
  level.var_555605da = &clean_up_locked_box;
  level.custom_firesale_box_leave = 1;
}

__main__() {
  level.chest_joker_model = #"hash_4b77dcb67eb0dc91";
  level.chest_joker_custom_movement = &custom_joker_movement;
}

custom_joker_movement() {
  v_origin = self.weapon_model.origin - (0, 0, 5);

  if(isDefined(self.weapon_model)) {
    self.weapon_model delete();
    self.weapon_model = undefined;
  }

  mdl_lock = util::spawn_model(level.chest_joker_model, v_origin, self.angles + (0, 180, 0));
  mdl_lock.targetname = "box_lock";
  mdl_lock setCanDamage(1);
  level.var_c7626f2a[#"box_lock"] = &pebble::function_bdd1bac8;
  level notify(#"hash_219aba01ff2d6de4");
  playsoundatposition(#"hash_7c7d8771a48e8871", mdl_lock.origin);
  wait 0.5;
  level notify(#"weapon_fly_away_start");
  wait 1;
  mdl_lock rotateyaw(3000, 4, 4);
  wait 3;
  mdl_lock movez(20, 0.5, 0.5);
  mdl_lock waittill(#"movedone");
  mdl_lock movez(-100, 0.5, 0.5);
  mdl_lock waittill(#"movedone");
  level notify(#"hash_3698278a3a5d8beb");
  mdl_lock delete();
  self notify(#"box_moving");
  level notify(#"weapon_fly_away_end");
}

watch_for_lock() {
  self endon(#"user_grabbed_weapon", #"chest_accessed");
  self waittill(#"box_locked");
  self notify(#"kill_chest_think");
  self.grab_weapon_hint = 0;
  self.chest_user = undefined;
  wait 0.1;
  self thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think);
  self thread zm_magicbox::treasure_chest_think();
}

clean_up_locked_box() {
  self endon(#"box_spin_done");
  self.owner waittill(#"box_locked");

  if(isDefined(self.weapon_model)) {
    self.weapon_model delete();
    self.weapon_model = undefined;
  }

  if(isDefined(self.weapon_model_dw)) {
    self.weapon_model_dw delete();
    self.weapon_model_dw = undefined;
  }

  self hidezbarrierpiece(3);
  self hidezbarrierpiece(4);
  self setzbarrierpiecestate(3, "closed");
  self setzbarrierpiecestate(4, "closed");
}

magic_box_locks() {
  self.owner.is_locked = 1;
  self.owner notify(#"box_locked");
  self playSound(#"zmb_hellbox_lock");
  self clientfield::set("magicbox_open_fx", 0);
  self setzbarrierpiecestate(5, "closing");

  while(self getzbarrierpiecestate(5) == "closing") {
    wait 0.5;
  }

  self notify(#"locked");
}

magic_box_unlocks() {
  self playSound(#"zmb_hellbox_unlock");
  self setzbarrierpiecestate(5, "opening");

  while(self getzbarrierpiecestate(5) == "opening") {
    wait 0.5;
  }

  self setzbarrierpiecestate(2, "closed");
  self showzbarrierpiece(2);
  self hidezbarrierpiece(5);
  self notify(#"unlocked");
  self.owner.is_locked = undefined;
}

set_locked_magicbox_state(state) {
  switch (state) {
    case #"locking":
      self showzbarrierpiece(5);
      self thread magic_box_locks();
      self.state = "locking";
      break;
    case #"unlocking":
      self showzbarrierpiece(5);
      self thread magic_box_unlocks();
      self.state = "close";
      break;
  }
}

function_be66db38() {
  level flagsys::wait_till("<dev string:x38>");
  e_box = undefined;

  for(i = 0; i < level.chests.size; i++) {
    if(isDefined(level.chests[i].zbarrier.state === "<dev string:x53>") && level.chests[i].zbarrier.state === "<dev string:x53>") {
      e_box = level.chests[i];
      break;
    }
  }

  if(isDefined(e_box)) {
    while(distance(level.players[0].origin, e_box.origin) > 128) {
      wait 1;
    }

    e_box.zbarrier zm_magicbox::set_magic_box_zbarrier_state("<dev string:x5d>");
  }
}

