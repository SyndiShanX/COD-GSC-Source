/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_zodt8_devgui.gsc
***********************************************/

#include script_7893277eec698972;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\zm\zm_zodt8;
#include scripts\zm\zm_zodt8_pap_quest;
#include scripts\zm\zm_zodt8_sentinel_trial;
#include scripts\zm\zm_zodt8_side_quests;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_trial_util;

#namespace zm_zodt8_devgui;

function_5d346946() {
  zm_devgui::add_custom_devgui_callback(&function_78c32556);
  adddebugcommand("<dev string:x38>");
  adddebugcommand("<dev string:x85>");
  adddebugcommand("<dev string:xc9>");
  adddebugcommand("<dev string:x102>");
  adddebugcommand("<dev string:x156>");
  adddebugcommand("<dev string:x1ac>");
  adddebugcommand("<dev string:x1f5>");
  adddebugcommand("<dev string:x25a>");
  adddebugcommand("<dev string:x2c1>");
  adddebugcommand("<dev string:x328>");
  adddebugcommand("<dev string:x393>");
  adddebugcommand("<dev string:x3dc>");
  adddebugcommand("<dev string:x429>");
  adddebugcommand("<dev string:x474>");
  adddebugcommand("<dev string:x4cb>");
  adddebugcommand("<dev string:x519>");
  level.var_b9714a5d = &function_51855e65;
}

function_78c32556(cmd) {
  switch (cmd) {
    case #"hash_50d92ca3c6c7c2a8":
      level thread function_4110a06f();
      return 1;
    case #"gear_up":
      level thread zodt8_sentinel::gear_up();
      return 1;
    case #"hash_672373a99384fb53":
      level thread function_853d8116();
      return 1;
    case #"hash_5634a634a8ffec47":
      level thread function_1d9dddd0();
      return 1;
    case #"move_pap":
      level thread function_10dafedb();
      return 1;
    case #"hash_74823c0e0a29545b":
      give_flare("<dev string:x567>");
      return 1;
    case #"hash_130280144168a5e7":
      give_flare("<dev string:x56d>");
      return 1;
    case #"hash_2972e55f40fe8050":
      give_flare("<dev string:x575>");
      return 1;
    case #"hash_59b568ce3fe548b6":
      level thread function_649d5f75();
      return 1;
    case #"hash_be17a68845640e4":
      level thread function_a368f5ed("<dev string:x57c>");
      return 1;
    case #"hash_5c17aed53086a4e8":
      level thread function_a368f5ed("<dev string:x584>");
      return 1;
    case #"hash_2474089e18afbc3":
      level thread function_a368f5ed("<dev string:x58d>");
      return 1;
    case #"hash_515fa2d180024bd3":
      level thread function_a368f5ed("<dev string:x596>");
      return 1;
    case #"hash_687e53bfcb79ec3b":
      if(isDefined(level.chests) && isDefined(level.chest_index) && isDefined(level.chests[level.chest_index].zbarrier)) {
        level.chests[level.chest_index].zbarrier thread namespace_b45e3f05::function_8baed388();
      }

      break;
    case #"hide_chests":
      function_7edbb38();

      if(level.chest_index != -1) {
        chest = level.chests[level.chest_index];
        chest zm_magicbox::hide_chest(0);
      }

      break;
    case #"show_chests":
      function_7edbb38();

      if(level.chest_index != -1) {
        chest = level.chests[level.chest_index];
        chest zm_magicbox::show_chest();
      }

      break;
  }
}

function_7edbb38() {
  while(level flag::get("<dev string:x5a1>")) {
    waitframe(1);
  }
}

function_4110a06f() {
  zm_devgui::zombie_devgui_open_sesame();
  level thread zodt8_pap_quest::function_765118cf();
  level flag::set(#"open_lore_room");
  level thread zm_zodt8::change_water_height_fore(1);
  level thread zm_zodt8::change_water_height_aft(1);
}

function_10dafedb() {
  if(!level flag::get("<dev string:x5b4>")) {
    level.s_pap_quest.var_4ee2e2ab = 0;
    level flag::set("<dev string:x5b4>");
    return;
  }

  level zodt8_pap_quest::function_306b4f35();
}

function_1d9dddd0() {
  if(level flag::get("<dev string:x5c9>")) {
    if(level.e_clip_water_aft clientfield::get("<dev string:x5dd>") != 0) {
      iprintlnbold("<dev string:x5f8>");
    } else {
      zm_zodt8::change_water_height_aft(0);
    }

    return;
  }

  if(level.e_clip_water_aft clientfield::get("<dev string:x5dd>") != 0) {
    iprintlnbold("<dev string:x5f8>");
    return;
  }

  zm_zodt8::change_water_height_aft(1);
}

function_853d8116() {
  if(level flag::get("<dev string:x631>")) {
    if(level.e_clip_water_fore clientfield::get("<dev string:x5dd>") != 0) {
      iprintlnbold("<dev string:x646>");
    } else {
      zm_zodt8::change_water_height_fore(0);
    }

    return;
  }

  if(level.e_clip_water_fore clientfield::get("<dev string:x5dd>") != 0) {
    iprintlnbold("<dev string:x646>");
    return;
  }

  zm_zodt8::change_water_height_fore(1);
}

function_649d5f75() {
  a_e_players = getplayers();
  namespace_4a807bff::function_8498110e(a_e_players[0]);
}

function_a368f5ed(var_99416cd7) {
  a_e_players = getplayers();

  foreach(e_player in a_e_players) {
    switch (var_99416cd7) {
      case #"decay":
        namespace_4a807bff::function_ca37502d(e_player);
        break;
      case #"plasma":
        namespace_4a807bff::function_1b182e8c(e_player);
        break;
      case #"purity":
        namespace_4a807bff::function_b9b7b8c(e_player);
        break;
      case #"radiance":
        namespace_4a807bff::function_b3695700(e_player);
        break;
    }
  }
}

give_flare(str_color) {
  a_e_players = getplayers();

  foreach(e_player in a_e_players) {
    switch (str_color) {
      case #"red":
        namespace_b45e3f05::give_flare("<dev string:x567>");
        break;
      case #"green":
        namespace_b45e3f05::give_flare("<dev string:x56d>");
        break;
      case #"blue":
        namespace_b45e3f05::give_flare("<dev string:x575>");
        break;
    }
  }
}

private function_51855e65(round_number) {
  var_efac84b3 = array(0, 500, 1000, 1000, 1400, 4000, 5000, 5500, 5500, 5500, 8000, 8000, 8000, 8000, 9000, 9000, 9000, 9500, 9500, 9500, 9500, 11000, 11000, 11000, 11000, 13000, 13000, 13000, 13000, 14000);
  round_index = round_number - 1;
  assert(round_index >= 0 && round_index < 30);

  foreach(player in getplayers()) {
    player zm_score::function_c1f146ff(var_efac84b3[round_index]);
  }

  if(round_number >= 7) {
    level flag::set("<dev string:x67e>");
    level flag::set(#"hash_3e80d503318a5674");
  }

  if(round_number >= 8) {
    assert(isDefined(level.var_4fe2f84d[#"zblueprint_shield_dual_wield"]));

    foreach(trigger in level.var_4fe2f84d[#"zblueprint_shield_dual_wield"]) {
      trigger.crafted = 1;
      trigger.blueprint = trigger.craftfoundry;

      if(isDefined(trigger.model)) {
        trigger.model notsolid();
        trigger.model show();
      }
    }

    foreach(player in getplayers()) {
      player zm_devgui::zombie_devgui_weapon_give("<dev string:x689>");
    }
  }

  if(round_number >= 9) {
    zm_trial_util::open_all_doors();
  }

  if(round_number >= 13) {
    level.s_pap_quest.var_4ee2e2ab = 0;
    level flag::set("<dev string:x5b4>");
  }

  if(round_number >= 24) {
    zm_trial_util::function_9c71b46f();
  }
}

