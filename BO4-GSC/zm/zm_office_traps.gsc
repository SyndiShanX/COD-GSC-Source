/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_office_traps.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\zm_common\zm_items;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_utility;

#namespace zm_office_traps;

init() {
  level init_flags();
  level.var_e2103f01 = 0;
  zm_items::function_4d230236(getweapon(#"hash_31fb0b01bd55c7bf"), &function_a28f0b21);
  zm_items::function_4d230236(getweapon(#"hash_31fb0c01bd55c972"), &function_af5c24bb);
  level function_e021562c();
}

init_flags() {
  level flag::init("trap_elevator");
  level flag::init("trap_quickrevive");
  level flag::init(#"hash_7b57f5f8bfe10b93");
}

function_a28f0b21(e_holder, w_item) {
  self playSound(#"hash_230737b2535a3374");
  level.var_e2103f01 += 1;

  if(function_8b1a219a()) {
    level.var_51823720[0] sethintstring(#"hash_323a35945e51c09a");
    level.var_51823720[1] sethintstring(#"hash_323a35945e51c09a");
  } else {
    level.var_51823720[0] sethintstring(#"hash_595a7e6ce85abd6e");
    level.var_51823720[1] sethintstring(#"hash_595a7e6ce85abd6e");
  }

  level flag::set(#"hash_7b57f5f8bfe10b93");
}

function_af5c24bb(e_holder, w_item) {
  self playSound(#"hash_230737b2535a3374");
  level.var_e2103f01 += 1;

  if(function_8b1a219a()) {
    level.var_51823720[0] sethintstring(#"hash_323a35945e51c09a");
    level.var_51823720[1] sethintstring(#"hash_323a35945e51c09a");
    return;
  }

  level.var_51823720[0] sethintstring(#"hash_595a7e6ce85abd6e");
  level.var_51823720[1] sethintstring(#"hash_595a7e6ce85abd6e");
}

function_e021562c() {
  level.var_51823720 = getEntArray("trigger_battery_trap_fix", "targetname");

  if(isDefined(level.var_51823720)) {
    array::thread_all(level.var_51823720, &function_cebfdd08);
  }
}

function_cebfdd08() {
  if(!isDefined(self.script_flag_wait)) {
    return;
  }

  if(!isDefined(self.script_string)) {
    return;
  }

  self sethintstring(#"hash_100d349fbdcacb2b");
  self setcursorhint("HINT_NOICON");
  self usetriggerrequirelookat();
  trap_trigger = getEntArray(self.script_flag_wait, "targetname");
  array::thread_all(trap_trigger, &function_a72b7c27, self.script_flag_wait);
  var_81f22deb = getent(self.script_string, "targetname");
  level thread function_5bd53e9b(var_81f22deb, self.script_flag_wait);

  if(zm_utility::is_standard()) {
    level flag::set(self.script_flag_wait);
  } else {
    while(!level flag::get(self.script_flag_wait)) {
      waitresult = self waittill(#"trigger");
      who = waitresult.activator;

      if(zm_utility::is_player_valid(who)) {
        if(!isDefined(level.var_e2103f01) || level.var_e2103f01 == 0) {
          zm_utility::play_sound_at_pos("no_purchase", self.origin);
          continue;
        }

        if(isDefined(level.var_e2103f01) && level.var_e2103f01 > 0) {
          self playSound("zmb_battery_insert");
          level flag::set(self.script_flag_wait);
          level.var_e2103f01 -= 1;

          if(level.var_e2103f01 == 0) {
            level.var_51823720[0] sethintstring(#"hash_100d349fbdcacb2b");
            level.var_51823720[1] sethintstring(#"hash_100d349fbdcacb2b");
          }

          if(level flag::get(#"hash_7b57f5f8bfe10b93")) {
            level zm_ui_inventory::function_7df6bb60(#"hash_48c5bcc6c9fab9d6", 1);
            level zm_ui_inventory::function_7df6bb60(#"hash_2695edd24ddf6e7b", 1);
            level flag::clear(#"hash_7b57f5f8bfe10b93");
            continue;
          }

          level zm_ui_inventory::function_7df6bb60(#"hash_7d940511ce9f0341", 1);
          level zm_ui_inventory::function_7df6bb60(#"hash_4a5aa2652a3ee760", 1);
        }
      }
    }
  }

  self sethintstring("");
  self triggerenable(0);
}

function_a72b7c27(str_flag) {
  if(!isDefined(str_flag)) {
    return;
  }

  if(self.classname == "trigger_use_new") {
    self sethintstring(#"zombie/need_power");
    self thread function_91882233(str_flag);
    self triggerenable(0);
  }
}

function_91882233(str_flag) {
  if(!isDefined(str_flag)) {
    return;
  }

  if(self.classname == "trigger_use_new") {
    level flag::wait_till(str_flag);
    self triggerenable(1);
  }
}

function_5bd53e9b(var_a703e7de, str_flag) {
  level flag::wait_till(str_flag);
  var_a703e7de notsolid();
  var_a703e7de.fx = spawn("script_model", var_a703e7de.origin);
  var_a703e7de.fx setModel("tag_origin");
  var_a703e7de movez(48, 1, 0.4, 0);
  var_a703e7de waittill(#"movedone");
  var_a703e7de rotateroll(360 * randomintrange(4, 10), 1.2, 0.6, 0);
  playFXOnTag(level._effect[#"poltergeist"], var_a703e7de.fx, "tag_origin");
  var_a703e7de waittill(#"rotatedone");
  var_a703e7de hide();
  var_a703e7de.fx hide();
  var_a703e7de.fx delete();
  var_a703e7de delete();
}