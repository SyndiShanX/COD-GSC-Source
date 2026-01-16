/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_quick_revive.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;

#namespace zm_perk_quick_revive;

autoexec __init__system__() {
  system::register(#"zm_perk_quick_revive", &__init__, undefined, undefined);
}

__init__() {
  enable_quick_revive_perk_for_level();
}

enable_quick_revive_perk_for_level() {
  if(function_8b1a219a()) {
    zm_perks::register_perk_basic_info(#"specialty_quickrevive", #"perk_quick_revive", 2000, #"hash_1fe09aea69fefa7", getweapon("zombie_perk_bottle_revive"), getweapon("zombie_perk_totem_quick_revive"), #"zmperksquickrevive");
  } else {
    zm_perks::register_perk_basic_info(#"specialty_quickrevive", #"perk_quick_revive", 2000, #"zombie/perk_quickrevive", getweapon("zombie_perk_bottle_revive"), getweapon("zombie_perk_totem_quick_revive"), #"zmperksquickrevive");
  }

  zm_perks::register_perk_precache_func(#"specialty_quickrevive", &quick_revive_precache);
  zm_perks::register_perk_clientfields(#"specialty_quickrevive", &quick_revive_register_clientfield, &quick_revive_set_clientfield);
  zm_perks::register_perk_machine(#"specialty_quickrevive", &quick_revive_perk_machine_setup);
  zm_perks::register_perk_threads(#"specialty_quickrevive", &give_quick_revive_perk, &take_quick_revive_perk);
  zm_perks::register_perk_host_migration_params(#"specialty_quickrevive", "vending_revive", "revive_light");
  zm_perks::register_perk_machine_power_override(#"specialty_quickrevive", &turn_revive_on);
}

quick_revive_precache() {
  if(isDefined(level.var_88d522c3)) {
    [[level.var_88d522c3]]();
    return;
  }

  level._effect[#"revive_light"] = #"zombie/fx_perk_quick_revive_zmb";
  level.machine_assets[#"specialty_quickrevive"] = spawnStruct();
  level.machine_assets[#"specialty_quickrevive"].weapon = getweapon("zombie_perk_bottle_revive");
  level.machine_assets[#"specialty_quickrevive"].off_model = "p7_zm_vending_revive";
  level.machine_assets[#"specialty_quickrevive"].on_model = "p7_zm_vending_revive";
}

quick_revive_register_clientfield() {}

quick_revive_set_clientfield(state) {}

quick_revive_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  use_trigger.script_sound = "mus_perks_revive_jingle";
  use_trigger.script_string = "revive_perk";
  use_trigger.script_label = "mus_perks_revive_sting";
  use_trigger.target = "vending_revive";
  perk_machine.script_string = "revive_perk";
  perk_machine.targetname = "vending_revive";

  if(isDefined(bump_trigger)) {
    bump_trigger.script_string = "revive_perk";
  }
}

turn_revive_on() {
  level endon(#"stop_quickrevive_logic");
  level flag::wait_till("start_zombie_round_logic");

  while(true) {
    machine = getEntArray("vending_revive", "targetname");
    machine_triggers = getEntArray("vending_revive", "target");

    for(i = 0; i < machine.size; i++) {
      machine[i] setModel(level.machine_assets[#"specialty_quickrevive"].off_model);

      if(isDefined(level.quick_revive_final_pos)) {
        level.quick_revive_default_origin = level.quick_revive_final_pos;
      }

      if(!isDefined(level.quick_revive_default_origin)) {
        level.quick_revive_default_origin = machine[i].origin;
        level.quick_revive_default_angles = machine[i].angles;
      }

      level.quick_revive_machine = machine[i];
    }

    array::thread_all(machine, &zm_perks::set_power_on, 0);

    for(i = 0; i < machine.size; i++) {
      if(isDefined(machine[i].classname) && machine[i].classname == "script_model") {
        if(isDefined(machine[i].script_noteworthy) && machine[i].script_noteworthy == "clip") {
          machine_clip = machine[i];
          continue;
        }

        machine[i] setModel(level.machine_assets[#"specialty_quickrevive"].on_model);
        machine[i] playSound(#"zmb_perks_power_on");
        machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
        machine_model = machine[i];
        machine[i] thread zm_perks::perk_fx("revive_light");
        exploder::exploder("quick_revive_lgts");
        machine[i] notify(#"stop_loopsound");
        machine[i] thread zm_perks::play_loop_on_machine();

        if(isDefined(machine_triggers[i])) {
          machine_clip = machine_triggers[i].clip;
        }

        if(isDefined(machine_triggers[i])) {
          blocker_model = machine_triggers[i].blocker_model;
        }
      }
    }

    util::wait_network_frame();
    array::thread_all(machine, &zm_perks::set_power_on, 1);

    if(isDefined(level.machine_assets[#"specialty_quickrevive"].power_on_callback)) {
      array::thread_all(machine, level.machine_assets[#"specialty_quickrevive"].power_on_callback);
    }

    level notify(#"specialty_quickrevive_power_on");

    if(isDefined(machine_model)) {
      machine_model.ishidden = 0;
    }

    notify_str = level waittill(#"revive_off", #"revive_hide", #"stop_quickrevive_logic");
    should_hide = 0;

    if(notify_str._notify == "revive_hide") {
      should_hide = 1;
    }

    if(isDefined(level.machine_assets[#"specialty_quickrevive"].power_off_callback)) {
      array::thread_all(machine, level.machine_assets[#"specialty_quickrevive"].power_off_callback);
    }

    for(i = 0; i < machine.size; i++) {
      if(isDefined(machine[i].classname) && machine[i].classname == "script_model") {
        machine[i] zm_perks::turn_perk_off(should_hide);
      }
    }
  }
}

unhide_quickrevive() {
  while(zm_perks::players_are_in_perk_area(level.quick_revive_machine)) {
    wait 0.1;
  }

  if(isDefined(level.quick_revive_machine_clip)) {
    level.quick_revive_machine_clip show();
    level.quick_revive_machine_clip disconnectpaths();
  }

  if(isDefined(level.quick_revive_final_pos)) {
    level.quick_revive_machine.origin = level.quick_revive_final_pos;
  }

  playFX(level._effect[#"poltergeist"], level.quick_revive_machine.origin);

  if(isDefined(level.quick_revive_trigger) && isDefined(level.quick_revive_trigger.blocker_model)) {
    level.quick_revive_trigger.blocker_model hide();
  }

  level.quick_revive_machine show();
  level.quick_revive_machine solid();

  if(isDefined(level.quick_revive_machine.original_pos)) {
    level.quick_revive_default_origin = level.quick_revive_machine.original_pos;
    level.quick_revive_default_angles = level.quick_revive_machine.original_angles;
  }

  direction = level.quick_revive_machine.origin;
  direction = (direction[1], direction[0], 0);

  if(direction[1] < 0 || direction[0] > 0 && direction[1] > 0) {
    direction = (direction[0], direction[1] * -1, 0);
  } else if(direction[0] < 0) {
    direction = (direction[0] * -1, direction[1], 0);
  }

  org = level.quick_revive_default_origin;

  if(isDefined(level.quick_revive_linked_ent)) {
    org = level.quick_revive_linked_ent.origin;

    if(isDefined(level.quick_revive_linked_ent_offset)) {
      org += level.quick_revive_linked_ent_offset;
    }
  }

  if(!(isDefined(level.quick_revive_linked_ent_moves) && level.quick_revive_linked_ent_moves) && level.quick_revive_machine.origin != org) {
    level.quick_revive_machine moveto(org, 3);
    level.quick_revive_machine vibrate(direction, 10, 0.5, 2.9);
    level.quick_revive_machine waittill(#"movedone");
    level.quick_revive_machine.angles = level.quick_revive_default_angles;
  } else {
    if(isDefined(level.quick_revive_linked_ent)) {
      org = level.quick_revive_linked_ent.origin;

      if(isDefined(level.quick_revive_linked_ent_offset)) {
        org += level.quick_revive_linked_ent_offset;
      }

      level.quick_revive_machine.origin = org;
    }

    level.quick_revive_machine vibrate((0, -100, 0), 0.3, 0.4, 3);
  }

  if(isDefined(level.quick_revive_linked_ent)) {
    level.quick_revive_machine linkto(level.quick_revive_linked_ent);
  }

  level.quick_revive_machine.ishidden = 0;
}

restart_quickrevive() {
  vending_machines = zm_perks::get_perk_machines();

  foreach(trigger in vending_machines) {
    if(!isDefined(trigger.script_noteworthy)) {
      continue;
    }

    if(trigger.script_noteworthy == #"specialty_quickrevive") {
      trigger notify(#"stop_quickrevive_logic");
      trigger thread zm_perks::vending_trigger_think();
      trigger triggerenable(1);
    }
  }
}

update_quickrevive_power_state(poweron) {
  foreach(item in level.powered_items) {
    if(isDefined(item.target) && isDefined(item.target.script_noteworthy) && item.target.script_noteworthy == "specialty_quickrevive") {
      if(item.power && !poweron) {
        if(!isDefined(item.powered_count)) {
          item.powered_count = 0;
        } else if(item.powered_count > 0) {
          item.powered_count--;
        }
      } else if(!item.power && poweron) {
        if(!isDefined(item.powered_count)) {
          item.powered_count = 0;
        }

        item.powered_count++;
      }

      if(!isDefined(item.depowered_count)) {
        item.depowered_count = 0;
      }

      item.power = poweron;
    }
  }
}

give_quick_revive_perk() {}

take_quick_revive_perk(b_pause, str_perk, str_result, n_slot) {}