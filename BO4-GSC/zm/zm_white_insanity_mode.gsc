/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_insanity_mode.gsc
***********************************************/

#include script_24c32478acf44108;
#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\zm\zm_white_computer_system;
#include scripts\zm\zm_white_door_powerup;
#include scripts\zm\zm_white_main_quest;
#include scripts\zm\zm_white_portals;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_fasttravel;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_white_insanity_mode;

autoexec __init__system__() {
  system::register(#"zm_white_insanity_mode", &__init__, &__main__, undefined);
}

__init__() {
  init_clientfields();
}

__main__() {
  init_flags();
  init_quest();
}

init_clientfields() {
  clientfield::register("vehicle", "fx8_insanity_wisp", 18000, 1, "int");
}

init_flags() {
  if(zm_utility::is_ee_enabled()) {
    level flag::init(#"shed_waiting");
    level flag::init(#"wisp_path_completed");
    level flag::init(#"hash_13cf89176254a394");
    level flag::init(#"tv_broken");
    level flag::init(#"hash_eb582974245f076");
    level flag::init(#"hash_12b747be855cc622");
    level flag::init(#"hash_7cd09ec15b9808a9");
    level flag::init(#"insanity_mode_triggered");
  }
}

init_quest() {
  if(zm_utility::is_ee_enabled()) {
    level.var_d416f0ff = spawnStruct();
    nd_start = getvehiclenode("insanity_mode_wisp_path_start", "targetname");
    var_ef55363f = getent("insanity_mode_wisp_info_volume", "targetname");

    if(isDefined(nd_start) && isDefined(var_ef55363f)) {
      do {
        vh_wisp = spawner::simple_spawn_single(getent("veh_insanity_mode_wisp", "targetname"));
        waitframe(1);
      }
      while(!isDefined(vh_wisp));

      vh_wisp.origin = nd_start.origin;
      vh_wisp.angles = nd_start.angles;
      arrayremovevalue(level.ai[#"axis"], vh_wisp);
      var_ef55363f.origin = nd_start.origin;
      var_ef55363f.angles = nd_start.angles;
      var_ef55363f enablelinkto();
      var_ef55363f linkto(vh_wisp);
      vh_wisp.var_ef55363f = var_ef55363f;
      vh_wisp val::set(#"insanity_mode_wisp", "takedamage", 0);
      level.var_d416f0ff.vh_wisp = vh_wisp;
    }

    function_69a6d31a(0);
    zm_sq::register(#"insanity_mode", #"step_1", #"insanity_mode_step1", &insanity_mode_step1_setup, &insanity_mode_step1_cleanup);
    zm_sq::register(#"insanity_mode", #"step_2", #"insanity_mode_step2", &insanity_mode_step2_setup, &insanity_mode_step2_cleanup);
    zm_sq::register(#"insanity_mode", #"step_3", #"insanity_mode_step3", &insanity_mode_step3_setup, &insanity_mode_step3_cleanup);
    zm_sq::register(#"insanity_mode", #"step_4", #"insanity_mode_step4", &insanity_mode_step4_setup, &insanity_mode_step4_cleanup);
    zm_sq::start(#"insanity_mode");
    return;
  }

  function_52a6a332();
}

function_52a6a332(var_1e3deed9 = 1) {
  var_9d62fe6f = getent("insanity_mode_wisp_start_trigger", "targetname");
  var_ef55363f = getent("insanity_mode_wisp_info_volume", "targetname");
  var_7a5bbd26 = getent("insanity_mode_damage_trigger", "targetname");
  var_d190efa8 = struct::get_array("insanity_mode_zone_containment_model");
  var_bdd13992 = getEntArray("insanity_mode_zone_containment_clip", "targetname");
  var_9d62fe6f delete();
  var_ef55363f delete();
  var_7a5bbd26 delete();

  if(var_1e3deed9) {
    foreach(s_containment in var_d190efa8) {
      if(isDefined(s_containment.e_model)) {
        s_containment.e_model delete();
      }
    }

    foreach(e_clip in var_bdd13992) {
      e_clip delete();
    }
  }
}

insanity_mode_step1_setup(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    level waittill(#"update_doomsday_clock");
    var_9d62fe6f = getent("insanity_mode_wisp_start_trigger", "targetname");
    level thread function_4bcfb4d9();

    while(!level flag::get(#"wisp_path_completed")) {
      level flag::wait_till(#"hash_35762ecd1ee8f3c1");
      reset_wisp();
      level thread function_d7fe6be2();
      a_flags = array(#"hash_35762ecd1ee8f3c1", #"shed_waiting");
      level flag::wait_till_clear_any(a_flags);

      if(!level flag::get(#"hash_35762ecd1ee8f3c1")) {
        level notify(#"hash_227a6fc118040203");
        level.var_d416f0ff.vh_wisp clientfield::set("fx8_insanity_wisp", 0);
        continue;
      }

      function_461006d1();
      level flag::set(#"infinite_round_spawning");
      var_f8b0325d = array(#"wisp_path_completed", #"hash_13cf89176254a394");
      level flag::wait_till_any(var_f8b0325d);
      level flag::clear(#"infinite_round_spawning");
      level.var_d416f0ff.vh_wisp clientfield::set("fx8_insanity_wisp", 0);

      if(!level flag::get(#"wisp_path_completed")) {
        level waittill(#"start_of_round");
        level flag::clear(#"hash_13cf89176254a394");

        iprintlnbold("<dev string:x38>");

      }
    }
  }
}

insanity_mode_step1_cleanup(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level flag::set(#"wisp_path_completed");
  }
}

function_d7fe6be2() {
  self endon(#"end_game", #"hash_227a6fc118040203");
  var_9d62fe6f = getent("insanity_mode_wisp_start_trigger", "targetname");
  level flag::set(#"shed_waiting");

  while(level flag::get(#"shed_waiting")) {
    a_e_players = getplayers();

    foreach(e_player in a_e_players) {
      if(e_player istouching(var_9d62fe6f)) {

        iprintlnbold("<dev string:x66>");

          level flag::clear(#"shed_waiting");
      }
    }

    wait 0.25;
  }
}

reset_wisp() {
  nd_start = getvehiclenode("insanity_mode_wisp_path_start", "targetname");
  level.var_d416f0ff.vh_wisp.origin = nd_start.origin;
  level.var_d416f0ff.vh_wisp.angles = nd_start.angles;
  level.var_d416f0ff.vh_wisp vehicle::get_on_path(nd_start);
  wait 0.5;
  level.var_d416f0ff.vh_wisp clientfield::set("fx8_insanity_wisp", 1);
}

function_461006d1() {
  nd_start = getvehiclenode("insanity_mode_wisp_path_start", "targetname");
  vh_wisp = level.var_d416f0ff.vh_wisp;
  vh_wisp thread function_7cfef7a8();
  vh_wisp playSound(#"hash_591341e81a7abb0");
  vh_wisp vehicle::get_on_path(nd_start);
  vh_wisp vehicle::resume_path();
  vh_wisp thread vehicle::get_on_and_go_path(nd_start);
  vh_wisp thread function_dba32984();
  vh_wisp setspeed(6);

  iprintlnbold("<dev string:x76>");

}

function_dba32984() {
  level endon(#"wisp_path_completed", #"hash_13cf89176254a394");

  if(isDefined(self.var_ef55363f)) {
    is_player_touching = 1;
    a_e_players = getplayers();

    while(is_player_touching) {
      wait 0.25;

      foreach(e_player in a_e_players) {
        is_player_touching = 0;

        if(e_player istouching(self.var_ef55363f)) {
          is_player_touching = 1;
        }
      }
    }

    self playSound(#"hash_4f86aa0523c734ed");

    iprintlnbold("<dev string:x8c>");

      self vehicle::pause_path();
    level flag::set(#"hash_13cf89176254a394");
  }
}

function_7cfef7a8() {
  self waittill(#"hash_28a9083d4bf6e717");
  level flag::set(#"wisp_path_completed");
}

function_4bcfb4d9() {
  self endon(#"wisp_path_completed", #"magic_door_power_up_grabbed");

  while(true) {
    level flag::wait_till(#"hash_35762ecd1ee8f3c1");

    if(!level flag::get(#"hash_13cf89176254a394")) {
      level.door_powerup zm_powerups::powerup_delete();
      level flag::wait_till_clear(#"hash_35762ecd1ee8f3c1");
      zm_white_door_powerup::door_powerup_drop(level.perk_type, level.ammodrop.origin);
    }

    wait 0.5;
  }
}

insanity_mode_step2_setup(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    pixbeginevent(#"hash_7e38a18c8bc5484c");
    level thread zm_white_computer_system::function_5fbede7a();
    var_7a5bbd26 = getent("insanity_mode_damage_trigger", "targetname");

    while(true) {
      waitresult = var_7a5bbd26 waittill(#"damage");

      if(waitresult.weapon == getweapon(#"bowie_knife_story_1")) {
        level thread zm_white_computer_system::function_60f15ca8();
        level flag::set(#"tv_broken");
        break;
      }
    }

    pixendevent();
  }
}

insanity_mode_step2_cleanup(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level flag::set(#"tv_broken");
  }
}

insanity_mode_step3_setup(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    s_insanity_mode_confirmation = struct::get("insanity_mode_confirmation");
    str_hint = zm_utility::function_d6046228(#"hash_209b7a0a83ce0276", #"hash_683c616025752252");

    while(!flag::get(#"hash_7cd09ec15b9808a9")) {

      iprintlnbold("<dev string:xc4>" + level.var_f13364b4.var_3c358113);

        level flag::clear(#"hash_eb582974245f076");
      level.var_f13364b4.a_n_codes[level.var_f13364b4.var_3c358113].var_544c05c6 = 1;
      level flag::wait_till(#"hash_eb582974245f076");

      iprintlnbold("<dev string:xdb>");

        wait 0.5;
      level.var_c2511d7b = getplayers();
      s_insanity_mode_confirmation zm_unitrigger::create(str_hint, 96);
      zm_unitrigger::function_89380dda(s_insanity_mode_confirmation.s_unitrigger, 1);
      s_insanity_mode_confirmation thread function_3d4b148b();
      level thread timer_countdown();
      zm_white_main_quest::function_63e4838b(1);
      a_flags = array(#"hash_7cd09ec15b9808a9", #"hash_12b747be855cc622");
      level flag::wait_till_any(a_flags);

      if(level flag::get(#"hash_12b747be855cc622") && !level flag::get(#"hash_7cd09ec15b9808a9")) {
        zm_unitrigger::unregister_unitrigger(s_insanity_mode_confirmation.s_unitrigger);
        zm_white_main_quest::function_63e4838b(0);
        level.countdown_clock zm_white_computer_system::function_9b1511fa();
      }
    }
  }
}

insanity_mode_step3_cleanup(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level flag::set(#"hash_eb582974245f076");
    level flag::set(#"hash_7cd09ec15b9808a9");
  }
}

timer_countdown() {
  level flag::clear(#"hash_12b747be855cc622");
  level endon(#"hash_12b747be855cc622");
  level.countdown_clock zm_white_computer_system::clock_countdown();
  level flag::set(#"hash_12b747be855cc622");

  iprintlnbold("<dev string:x12c>");

}

function_3d4b148b() {
  while(level.var_c2511d7b.size > 0) {
    s_waitresult = self waittill(#"trigger_activated");
    arrayremovevalue(level.var_c2511d7b, s_waitresult.e_who);

    iprintlnbold("<dev string:x145>" + level.var_c2511d7b.size);

  }

  level flag::set(#"hash_7cd09ec15b9808a9");
  level flag::set(#"hash_12b747be855cc622");
}

insanity_mode_step4_setup(var_5ea5c94d) {
  if(!var_5ea5c94d) {
    function_1541f1c9();
  }
}

insanity_mode_step4_cleanup(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    level flag::set(#"insanity_mode_triggered");
  }
}

function_1541f1c9() {
  level.var_73d1e054 = 1;
  level flag::set(#"insanity_mode_triggered");
  level.musicsystemoverride = 1;
  level.var_3c9cfd6f = 1;
  level.var_d555ff19 = 1;
  function_52a6a332(0);
  playsoundatposition(#"hash_83b85ca3e963765", (0, 0, 0));
  level thread lui::screen_flash(1, 2, 1, 1, "white");
  array::run_all(getaiarray(), &namespace_9ff9f642::freeze);
  wait 1;
  zm_white_main_quest::function_32c317fb();
  zm_white_portals::function_5c2807fc();
  function_69a6d31a(1);
  function_83c13f8e();
  function_5ac5f2aa();
  function_4f84973a();
  function_ff416940();
  function_7cb78bcd();
  a_e_players = getplayers();
  var_a0b0c8c4 = struct::get_array("insanity_mode_teleport_location", "targetname");

  for(i = 0; i < a_e_players.size; i++) {
    a_e_players[i] zm_fasttravel::function_2aed1d83(var_a0b0c8c4[i], 1);
  }

  wait 2 + 1;
  function_411302d7();
  level thread zm_audio::sndannouncerplayvox(undefined, undefined, "vox_event_insanitystart_avoa_0");
  level thread function_b693a570();
}

function_b693a570() {
  level endon(#"game_over");
  var_8f5b3e75 = 2;
  var_69503500 = 12;
  var_5f530783 = [];

  for(i = 0; i <= var_69503500 - var_8f5b3e75; i++) {
    var_5f530783[i] = "im_" + var_8f5b3e75 + i;
  }

  zm_audio::playstate("im_1");
  var_432c4ea2 = array::randomize(var_5f530783);
  array::add(var_5f530783, "im_1");

  while(true) {
    zm_audio::playstate(var_432c4ea2[0]);
    arrayremoveindex(var_432c4ea2, 0);

    if(var_432c4ea2.size <= 0) {
      var_432c4ea2 = array::randomize(var_5f530783);
    }

    wait 1;
  }
}

function_411302d7() {
  if(level.round_number != 200) {
    level flag::wait_till("round_active");
    zm_round_logic::set_round_number(200 - 1);
  }

  level notify(#"kill_round");
  zombies = getaiteamarray(level.zombie_team);

  if(isDefined(zombies)) {
    for(i = 0; i < zombies.size; i++) {
      zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
    }
  }
}

function_69a6d31a(b_show) {
  var_d190efa8 = struct::get_array("insanity_mode_zone_containment_model");

  foreach(s_containment in var_d190efa8) {
    if(b_show) {
      s_containment.e_model = util::spawn_model(s_containment.model, s_containment.origin, s_containment.angles);
      continue;
    }

    if(isDefined(s_containment.e_model)) {
      s_containment.e_model delete();
    }
  }

  var_bdd13992 = getEntArray("insanity_mode_zone_containment_clip", "targetname");

  foreach(e_clip in var_bdd13992) {
    if(b_show) {
      e_clip solid();
      continue;
    }

    e_clip notsolid();
  }

  var_76a02192 = getEntArray("insanity_mode_no_starting_powerups", "targetname");

  if(isDefined(level.var_5fa2f970)) {
    foreach(vol_no_powerups in var_76a02192) {
      if(b_show) {
        vol_no_powerups show();

        if(!isDefined(level.var_5fa2f970)) {
          level.var_5fa2f970 = [];
        } else if(!isarray(level.var_5fa2f970)) {
          level.var_5fa2f970 = array(level.var_5fa2f970);
        }

        if(!isinarray(level.var_5fa2f970, vol_no_powerups)) {
          level.var_5fa2f970[level.var_5fa2f970.size] = vol_no_powerups;
        }

        continue;
      }

      vol_no_powerups hide();
      arrayremovevalue(level.var_5fa2f970, vol_no_powerups);
    }
  }
}

function_83c13f8e() {
  a_e_players = getplayers();

  foreach(e_player in a_e_players) {
    e_player zm_perks::function_cc24f525();
  }
}

function_5ac5f2aa() {
  a_e_players = getplayers();

  foreach(e_player in a_e_players) {
    e_player.var_c09adff0 = 1;
    e_player.var_e77eadb7 = 1;
    e_player zm_hero_weapon::function_45b7d6c1(2);
    e_player zm_hero_weapon::function_1164ba7b(1);
    e_player zm_hero_weapon::hero_give_weapon(level.hero_weapon[e_player.var_b708af7b][2], 1);
  }
}

function_4f84973a() {
  a_e_players = getplayers();

  foreach(e_player in a_e_players) {
    a_weapon_curr = e_player getweaponslistprimaries();

    foreach(weapon_curr in a_weapon_curr) {
      if(zm_pap_util::function_7352d8cc(weapon_curr)) {
        continue;
      }

      e_player function_e16c950d(weapon_curr);
    }
  }
}

get_upgrade(weapon) {
  if(isDefined(level.zombie_weapons[weapon]) && isDefined(level.zombie_weapons[weapon].upgrade_name)) {
    return zm_weapons::get_upgrade_weapon(weapon, 0);
  }

  return zm_weapons::get_upgrade_weapon(weapon, 1);
}

function_e16c950d(weapon) {
  weapon_upgrade = self get_upgrade(weapon);

  if(isDefined(weapon_upgrade)) {
    self takeweapon(weapon);
    weapon_upgrade = self zm_weapons::give_build_kit_weapon(weapon_upgrade);
    self thread aat::remove(weapon_upgrade);
    self zm_weapons::function_7c5dd4bd(weapon_upgrade);

    if(isDefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weapon_upgrade)) {
      self thread aat::acquire(weapon_upgrade);
      self zm_pap_util::repack_weapon(weapon_upgrade, 4);
    }
  }
}

function_7cb78bcd() {
  foreach(zone in level.zones) {
    enable_zone(zone, 0);
  }

  a_e_zombie_doors = getEntArray("zombie_door", "targetname");

  if(isDefined(a_e_zombie_doors)) {
    foreach(var_6620353d in a_e_zombie_doors) {
      switch (var_6620353d.script_flag) {
        case #"green_backyard_to_green_house":
        case #"culdesac_to_yellow_house_f1":
        case #"culdesac_to_green_house":
        case #"yellow_backyard_to_yellow_house":
          if(!(isDefined(var_6620353d.has_been_opened) && var_6620353d.has_been_opened)) {
            a_e_players = getplayers();
            var_6620353d notify(#"trigger", {
              #activator: a_e_players[0], 
              #is_forced: 1
            });
          }

          break;
      }
    }
  }

  enable_zone(level.zones[#"zone_culdesac_green"], 1);
  enable_zone(level.zones[#"zone_green_house_f1"], 1);
  enable_zone(level.zones[#"zone_green_house_f2"], 1);
  enable_zone(level.zones[#"zone_green_backyard"], 1);
  enable_zone(level.zones[#"zone_culdesac_yellow"], 1);
  enable_zone(level.zones[#"zone_yellow_house_f1"], 1);
  enable_zone(level.zones[#"zone_yellow_house_f2"], 1);
  enable_zone(level.zones[#"zone_yellow_backyard"], 1);
}

enable_zone(zone, is_enabled = 1) {
  zone.is_enabled = is_enabled;
  zone.is_spawning_allowed = is_enabled;
  var_42da954d = getarraykeys(zone.adjacent_zones);

  for(i = 0; i < zone.adjacent_zones.size; i++) {
    zone.adjacent_zones[var_42da954d[i]].is_connected = level.zones[var_42da954d[i]].is_enabled;

    if(isDefined(level.zones[var_42da954d[i]].adjacent_zones[zone.name])) {
      level.zones[var_42da954d[i]].adjacent_zones[zone.name].is_connected = is_enabled;
    }
  }
}

function_ff416940() {
  a_e_players = getplayers();

  foreach(e_player in a_e_players) {
    w_lethal = e_player zm_loadout::get_player_lethal_grenade();

    if(w_lethal.isgadget) {
      n_slot = e_player gadgetgetslot(w_lethal);
      e_player gadgetpowerreset(n_slot, 0);
    }
  }
}