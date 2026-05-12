/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_training.gsc
*********************************************/

func_00F9() {
  lib_04C1::func_00F9();
  lib_0428::func_00F9();
  lib_04C0::func_00F9();
  maps\mp\_load::func_00F9();
  maps\mp\mp_zombie_training_lighting::func_00F9();
  maps\mp\mp_zombie_training_aud::func_00F9();
  precacheshader("vignette_hud");
  maps\mp\_compass::func_8A2F("compass_map_mp_zombie_training");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_6BA5 = ::func_9C4C;
  level.var_A9C5 = ::func_9C4A;
  level.var_477F = ::func_9C4B;
  level.var_2986 = "mp/zombieEnemyWavesTraining.csv";
  level.var_8C8D = 1;
  level.var_ACA3 = 1;
  level.var_0C25 = 0;
  level.var_ABDA = 1;
  level.var_7F24 = 1000;
  level.var_3230 = 1;
  level.var_3C00 = 0;
  level.var_7F1B = 10;
  level.var_3C5E = 1;
  level.var_4EF0 = 0;
  level.var_0BCE = 1;
  level.var_323A = 1;
  level.var_8C7C = 1;
  level.block_self_revive_use = 1;
  setomnvar("ui_zm_intermission_swaptime_1", 6);
  setomnvar("ui_zm_intermission_swaptime_2", 2);
  setDvar("2494", "0.12, 0, 0");
  level.var_9C48 = [];
  level.var_9C48["melee1"] = &"ZOMBIE_TRAINING_POPUP_MELEE_1";
  level.var_9C48["melee1_pc"] = &"ZOMBIE_TRAINING_POPUP_MELEE_1_PC";
  level.var_9C48["melee2"] = &"ZOMBIE_TRAINING_POPUP_MELEE_2";
  level.var_9C48["shovel"] = &"ZOMBIE_TRAINING_POPUP_EQUIP_SHOVEL";
  level.var_9C48["special1"] = &"ZOMBIE_TRAINING_POPUP_SPECIAL";
  level.var_9C48["economy1"] = &"ZOMBIE_TRAINING_POPUP_ECONOMY_1";
  level.var_9C48["economy2"] = &"ZOMBIE_TRAINING_POPUP_ECONOMY_2";
  level.var_9C48["hintmode"] = &"ZOMBIE_TRAINING_POPUP_HINTMODE";
  level.var_9C48["hintmode2"] = &"ZOMBIE_TRAINING_POPUP_HINTMODE_2";
  level.var_9C48["doorbuy"] = &"ZOMBIE_TRAINING_POPUP_DOORBUY";
  level.var_9C48["wallbuy"] = &"ZOMBIE_TRAINING_POPUP_WALLBUY";
  level.var_9C48["rounds"] = &"ZOMBIE_TRAINING_POPUP_ROUNDS";
  level.var_9C48["boards"] = &"ZOMBIE_TRAINING_POPUP_BOARDS";
  level.var_9C48["consumables"] = &"ZOMBIE_TRAINING_POPUP_CONSUMABLES";
  level.var_9C48["pickups"] = &"ZOMBIE_TRAINING_POPUP_PICKUPS";
  level.var_9C48["ammo"] = &"ZOMBIE_TRAINING_POPUP_AMMO";
  level.var_9C48["exit"] = &"ZOMBIE_TRAINING_POPUP_ENOUGH_CASH";
  level.var_9C48["blitz"] = &"ZOMBIE_TRAINING_POPUP_BLITZ";
  level.var_9C48["armor"] = &"ZOMBIE_TRAINING_POPUP_ARMOR";
  lib_055A::func_00D5();
  lib_055A::func_530A("zone_training_start", 1);
  lib_055A::func_530A("zone_training_field", 0);
  lib_055A::func_530A("zone_training_yard", 0);
  lib_055A::func_530A("zone_training_house", 0);
  lib_055A::func_530A("zone_training_end", 0);
  lib_055A::func_0993("zone_training_start", "zone_training_field", "flag_link_field");
  lib_055A::func_0993("zone_training_field", "zone_training_yard", "field_to_yard");
  lib_055A::func_0993("zone_training_yard", "zone_training_house", "flag_link_house");
  lib_055A::func_0993("zone_training_house", "zone_training_end", "house_to_end");
  lib_055A::func_088A();
  common_scripts\utility::func_3C8F("flag_link_field");
  common_scripts\utility::func_3C8F("flag_link_house");
  common_scripts\utility::func_3C87("flag_dlg_german_death_done");
  common_scripts\utility::func_3C87("flag_all_lamps_hit");
  common_scripts\utility::func_3C87("flag_all_field_zombies_dead");
  common_scripts\utility::func_3C87("flag_player_close_to_first_zombie");
  common_scripts\utility::func_3C87("flag_player_has_weapon");
  common_scripts\utility::func_3C87("flag_first_zombie_dead");
  common_scripts\utility::func_3C87("flag_light_melee_popup_shown");
  common_scripts\utility::func_3C87("flag_boards_popup_shown");
  common_scripts\utility::func_3C87("flag_germans_start_search");
  common_scripts\utility::func_3C87("flag_patrol_spots_zombie");
  common_scripts\utility::func_3C87("flag_wallbuy_bought");
  common_scripts\utility::func_3C87("flag_exit_door_seen");
  common_scripts\utility::func_3C87("flag_exit_door_opened");
  common_scripts\utility::func_3C87("flag_player_in_house");
  common_scripts\utility::func_3C87("flag_enable_2nd_floor_spawns");
  common_scripts\utility::func_3C87("flag_enable_all_1st_floor_spawns");
  common_scripts\utility::func_3C87("flag_player_revived");
  common_scripts\utility::func_3C87("flag_player_awoke_horde");
  common_scripts\utility::func_3C87("flag_player_reached_exit");
  common_scripts\utility::func_3C87("flag_player_got_electro");
  common_scripts\utility::func_3C87("flag_player_ability_enabled");
  common_scripts\utility::func_3C87("player_heartbeat_sound");
  common_scripts\utility::func_3C87("flag_stop_crawl_sway");
  common_scripts\utility::func_3C87("flag_stop_aftermath_sway");
  common_scripts\utility::func_3C87("flag_player_used_ability");
  common_scripts\utility::func_3C87("flag_patrol_timeout");
  common_scripts\utility::func_3C87("flag_hit_patrol_trig");
  common_scripts\utility::func_3C87("flag_spawn_first_zombie");
  common_scripts\utility::func_3C87("flag_perk_popup_shown");
  common_scripts\utility::func_3C87("flag_armor_popup_shown");
  common_scripts\utility::func_3C87("flag_all_initial_house_zombies_dead");
  common_scripts\utility::func_3C87("flag_show_round_ui");
  common_scripts\utility::func_3C87("flag_shovel_popup_shown");
  common_scripts\utility::func_3C87("flag_spawn_crawler");
  common_scripts\utility::func_3C87("flag_show_inventory");
  thread func_327D();
  level.var_0C11 = 0;
  thread func_357A();
  thread func_4055();
  level.var_28F0 = 0;
  level.var_21DA = getdvarint("scr_zombieCheckpoint", 0);
  func_5338();
  thread lib_057D::func_5162();
  thread lib_0551::func_3D50(0);
  thread maps\mp\mp_zombie_falldamage_modifier::func_00F9();
  level thread maps\mp\zquests\dlc1_secrets_mp_zombie_training::init_dlc1_secrets_mp_zombie_training();
  lib_0565::func_7C07("mountain_man_set");
  thread func_3FD2();
  level thread maps\mp\_utility::func_6F74(::func_9FFA);
}

func_21D9() {
  var_00 = ["flag_dlg_german_death_done", "flag_patrol_spots_zombie", "flag_player_revived", "flag_player_got_electro", "flag_germans_start_search", "flag_stop_crawl_sway", "flag_stop_aftermath_sway", "flag_hit_patrol_trig", "flag_spawn_first_zombie"];
  foreach(var_02 in var_00) {
    common_scripts\utility::func_3C8F(var_02);
  }

  thread func_4056();
  thread func_284C();
  var_04 = ["trig_call_out", "trig_kill_germans", "trig_lightset", "trig_pickup_elec_crawl", "trig_awaken_first_z", "trig_buckle_beam", "trig_see_corpse", "trig_see_corpse_2", "trig_see_massacre"];
  foreach(var_06 in var_04) {
    var_07 = getent(var_06, "targetname");
    if(isDefined(var_07)) {
      var_07 common_scripts\utility::func_9D9F();
    }
  }

  level.var_A980 = 1;
  level.var_28F0 = 1;
}

func_21D8() {
  func_21D9();
  var_00 = ["flag_light_melee_popup_shown", "flag_player_awoke_horde", "flag_player_in_house", "flag_player_close_to_first_zombie", "flag_player_has_weapon", "flag_first_zombie_dead", "flag_light_melee_popup_shown", "flag_spawn_first_zombie", "flag_show_inventory"];
  thread func_284D();
  foreach(var_02 in var_00) {
    common_scripts\utility::func_3C8F(var_02);
  }

  var_04 = ["trig_awaken_field_horde", "trig_entered_house", "trig_awaken_first_z_lure", "trig_reach_shovel", "trig_awaken_first_z_tree"];
  foreach(var_06 in var_04) {
    var_07 = getent(var_06, "targetname");
    if(isDefined(var_07)) {
      var_07 common_scripts\utility::func_9D9F();
    }
  }

  level.var_A980 = 1;
  level.var_28F0 = 2;
  thread func_21D5();
}

func_21D5() {
  wait(2);
  common_scripts\utility::func_3C8F("collectible_gate_reached");
  wait(0.5);
  common_scripts\utility::func_3C8F("collectible_farmhouse_reached");
}

func_21D7() {
  level.var_28F0 = 1;
}

func_5338() {
  lib_0557::func_786C();
  lib_0557::func_7846("Training Quest", ::lib_0557::func_30D8, undefined, &"ZOMBIE_TRAINING_HINT_QUEST", "ZOMBIE_TRAINING_HINT_QUEST");
  common_scripts\utility::func_3C87("collectible_gun_purchased");
  common_scripts\utility::func_3C87("collectible_blitz_purchased");
  common_scripts\utility::func_3C87("collectible_gate_reached");
  common_scripts\utility::func_3C87("collectible_farmhouse_reached");
  common_scripts\utility::func_3C87("collectible_escape");
  lib_0557::func_AB8C("collectible_gate_reached");
  lib_0557::func_AB8C("collectible_farmhouse_reached");
  lib_0557::func_AB8C("collectible_gun_purchased");
  lib_0557::func_AB8C("collectible_blitz_purchased");
  lib_0557::func_AB8C("collectible_escape");
  thread func_7825();
  switch (level.var_21DA) {
    case 1:
    case 0:
      lib_0557::func_781E("Training Quest", "Reach Farmhouse", ::func_787D, ::lib_0557::func_30D8, &"ZOMBIE_TRAINING_HINT_STEP_HOUSE");
      break;

    case 2:
      lib_0557::func_781E("Training Quest", "Find Weapon", ::func_787B, ::lib_0557::func_30D8, &"ZOMBIE_TRAINING_HINT_STEP_WEAPON");
      lib_0557::func_781E("Training Quest", "Earn Current", ::func_7875, ::lib_0557::func_30D8, &"ZOMBIE_TRAINING_HINT_STEP_CURRENT");
      lib_0557::func_781E("Training Quest", "Exit Farmhouse", ::func_7878, ::lib_0557::func_30D8, &"ZOMBIE_TRAINING_HINT_STEP_EXIT_HOUSE");
      lib_0557::func_781E("Training Quest", "Rendezvouse with Squad", ::func_7876, ::lib_0557::func_30D8, &"ZOMBIE_TRAINING_HINT_STEP_END");
      break;
  }
}

func_7825() {
  for(;;) {
    level waittill("player_spawned", var_00);
    var_00 thread func_7829();
    var_00 thread quest_collectible_purchase_blitz_think();
  }
}

func_7829() {
  self waittill("new_wallbuy_weapon", var_00);
  lib_0557::func_AB88("collectible_gun_purchased");
}

quest_collectible_purchase_blitz_think() {
  self waittill("perkmachine_activated", var_00);
  lib_0557::func_AB88("collectible_blitz_purchased");
}

func_787D() {
  var_00 = getent("first_door_lock", "targetname");
  var_01 = lib_0557::func_782F(undefined, var_00);
  lib_0557::func_781D("Training Quest", var_01);
  var_02 = lib_053F::func_44A6("field_to_yard");
  var_02 waittill("open");
  common_scripts\utility::func_3C8F("collectible_gate_reached");
  lib_0557::func_7847("Training Quest", var_01);
  var_00 delete();
  common_scripts\utility::func_3C9F("field_to_yard");
}

func_787B() {
  var_00 = getEntArray("wallbuy", "targetname");
  var_01 = lib_0557::func_782F(undefined, var_00);
  lib_0557::func_781D("Training Quest", var_01);
  common_scripts\utility::func_3C8F("collectible_farmhouse_reached");
}

func_7875() {}

func_7878() {}

func_7876() {
  common_scripts\utility::func_3C8F("collectible_escape");
}

func_9FFA() {
  var_00 = self;
  var_00 thread func_9FF6();
  var_00 thread func_9FF8();
  var_00 thread func_9FF9();
  var_00 thread func_9FF5();
  var_00 thread func_9FF7();
}

func_9FF6() {
  common_scripts\utility::func_3C9F("flag_player_close_to_first_zombie");
  lib_0547::func_ABCA(self, 0);
}

func_9FF8() {
  common_scripts\utility::func_3C9F("flag_show_round_ui");
  lib_0547::func_ABCA(self, 3);
}

func_9FF9() {
  common_scripts\utility::func_3C9F("flag_wallbuy_bought");
  lib_0547::func_ABCA(self, 6);
  lib_0547::func_ABCA(self, 8);
}

func_9FF5() {
  common_scripts\utility::func_3C9F("flag_player_ability_enabled");
  lib_0547::func_ABCA(self, 1);
}

func_9FF7() {
  common_scripts\utility::func_3C9F("flag_show_inventory");
  lib_0547::func_ABCA(self, 4);
  lib_0547::func_ABCA(self, 9);
}

func_3FD2() {
  level waittill("player_spawned", var_00);
  var_00 maps\mp\_utility::func_3E8E(1);
  lib_0378::func_8D0B("silence_fx");
  while(!level.var_3FA6) {
    wait 0.05;
  }

  lib_0378::func_8D18("silence_fx");
  var_00 lib_0547::func_7B37(1);
  thread func_7331();
  level.var_1F4F["normal"] = ::func_9C49;
  level.var_7F22["normal"] = ::func_9C4D;
  level.var_0A41["zombie_generic"]["move_mode"] = ::func_9C4E;
  level.var_AC80.var_9065 = ::lib_055A::func_1E58;
  level.var_0611["zmb_player_attached_light"] = loadfx("vfx/lights/mp_zombie_training/zmb_player_attached_light_2");
  func_327C();
  var_01 = func_325F();
  var_01 thread func_3263();
  var_00 maps\mp\gametypes\zombies::func_7D63(0);
  func_737F(0);
  lib_0547::func_7BA9(::func_ABD4);
  func_9FF1(var_00);
  thread func_326E();
  var_00 thread func_9FB0();
  var_00 thread func_9FA6();
  var_00 thread func_9FAB();
  var_00 thread func_9FB2();
  var_00 thread func_9FAD();
  var_00 thread func_9FA7();
  var_00 thread func_9FAE();
  var_00 thread func_9FAA(var_01);
  var_00 thread func_725C();
  var_00 thread func_7254();
  switch (level.var_21DA) {
    case 0:
      thread func_4051();
      thread func_2845(var_00);
      foreach(var_03 in level.var_4EE7) {
        func_3281(var_03, 1);
      }

      thread func_8A43();
      thread func_8A44();
      thread func_3AA2();
      thread func_4EE8();
      break;

    case 1:
      var_00 maps\mp\_utility::func_3E8E(0);
      foreach(var_03 in level.var_4EE7) {
        maps\mp\_utility::func_2CED(2, ::func_3281, var_03, 1);
      }

      thread func_8A43();
      thread func_8A44();
      thread func_AC02();
      thread func_3AA2();
      thread func_284F();
      var_00 maps\mp\_utility::func_2CED(0.5, ::maps\mp\gametypes\zombies::func_7D63, 850);
      var_00 maps\mp\_utility::func_2CED(0.5, ::player_stripmods);
      var_00 maps\mp\_utility::func_2CED(0.5, ::lib_0547::func_7454, 0);
      var_00.zombietrainingmovespeedscale = 0.3;
      var_00 maps\mp\gametypes\_weapons::func_A13B();
      var_00 method_8308(0);
      var_00 method_8670();
      var_00 thread lib_0378::func_8D74("see_massacre");
      if(1) {
        var_00 maps\mp\_utility::func_2CED(1, ::player_flashlightmonitor);
      }

      thread func_4EE8();
      thread func_2846();
      func_21D9();
      break;

    case 2:
      var_00 maps\mp\_utility::func_3E8E(0);
      foreach(var_03 in level.var_4EE7) {
        thread func_3281(var_03, 0);
      }

      var_00 maps\mp\_utility::func_2CED(0.5, ::func_728D);
      var_00 maps\mp\_utility::func_2CED(0.5, ::lib_0547::func_7454, 0);
      var_00 maps\mp\_utility::func_2CED(0.5, ::player_stripmods);
      var_00 maps\mp\_utility::func_2CED(0.5, ::maps\mp\gametypes\zombies::func_7D63, 1000);
      var_00 method_8670();
      thread func_4EE6(var_00);
      thread func_2846();
      func_21D8();
      lib_0557::func_7848("Training Quest");
      break;
  }

  thread func_5FED();
}

func_2845(param_00) {
  thread func_2849();
  thread func_2846();
  thread func_2843();
  thread func_2844();
  thread func_404A();
  thread func_1319(param_00);
  if(0) {
    thread func_ABFC();
  }

  param_00 func_2850();
  param_00 thread player_stripmods();
  thread func_2847(1);
  var_01 = lib_0547::func_AAFA("trig_call_out", "targetname");
  thread func_2E78();
  var_01 = lib_0547::func_AAFA("trig_kill_germans", "targetname");
  common_scripts\utility::func_3C8F("flag_hit_patrol_trig");
  thread func_2E8C();
  common_scripts\utility::func_3C9F("flag_player_got_electro");
  common_scripts\utility::func_3C8F("flag_spawn_first_zombie");
  common_scripts\utility::func_3C8F("flag_stop_crawl_sway");
  thread func_AC02();
  common_scripts\utility::func_3C9F("flag_player_revived");
  func_ABD0();
  func_284F();
}

func_284F() {
  thread func_284E();
  var_00 = getent("static_creek_shovel", "targetname");
  var_01 = lib_0547::func_AAFA("trig_reach_shovel", "targetname");
  var_01 maps\mp\_utility::func_3E8E(1);
  var_02 = common_scripts\utility::func_46B5("shovel_lerp_struct", "targetname");
  var_03 = undefined;
  if(isDefined(var_02)) {
    var_03 = spawn("script_model", var_01.var_0116);
    var_03 setModel("tag_origin");
    var_04 = var_02.var_001D * (1, 0, 0) + var_01.var_001D * (0, 1, 0);
    var_03.var_001D = var_04;
    var_01 playerlinktoblend(var_03, "tag_origin", 0.25);
    var_03 moveto(var_02.var_0116, 0.25);
    var_03 rotateto(var_02.var_001D, 0.25);
    var_05 = var_00.var_0116 - var_01 getEye();
    var_01 setangles(vectortoangles(var_05));
    wait(0.25);
    lib_0378::func_8D74("aud_pickup_shovel");
  }

  var_01 func_728D();
  common_scripts\utility::func_3C8F("flag_player_has_weapon");
  common_scripts\utility::func_3C8F("flag_stop_aftermath_sway");
  wait(1.37);
  func_21D7();
  lib_0555::func_83DD("training_melee_2", var_01);
  var_01 thread creek_firstzombiekillnotifyhide();
  var_01 maps\mp\_utility::func_3E8E(0);
  if(!var_01 common_scripts\utility::func_0668()) {
    var_01 common_scripts\utility::func_0617();
  }

  var_01 method_812B(1);
  var_01 method_812A(1);
  if(isDefined(var_03)) {
    var_01 unlink(var_03);
    var_03 delete();
  }

  thread func_AC03();
  thread func_AC01();
  func_284B();
}

creek_firstzombiekillnotifyhide() {
  var_00 = level common_scripts\utility::func_A74D("flag_first_zombie_dead", 10);
  if(lib_0547::func_5565(var_00, "timeout")) {
    return;
  }

  lib_0555::func_83DD("force_hide", self);
}

func_284B() {
  var_00 = level.var_721C;
  var_00.zombietrainingmovespeedscale = 0.3;
  var_00 maps\mp\gametypes\_weapons::func_A13B();
  var_00 = lib_0547::func_AAFA("trig_awaken_first_z_tree", "targetname");
  thread func_5C82(var_00, "jumpscare_door_lerp_struct");
  func_AC00();
  level.var_3C5F.var_8386 = 1;
  level.var_3C5F thread func_ABAF();
  level.var_721C lib_0378::func_8D74("first_zombie_tree_jumpscare");
  wait(0.3333333);
  common_scripts\utility::func_3C8F("flag_player_close_to_first_zombie");
  func_ABAE(level.var_3C5F, var_00, 1);
  var_01 = 5;
  var_00 notifyonplayercommand("melee_pressed", "+attack");
  var_00 notifyonplayercommand("melee_pressed", "+melee");
  var_00 notifyonplayercommand("melee_pressed", "+melee_zoom");
  var_00 notifyonplayercommand("melee_pressed", "+melee_breath");
  var_00 notifyonplayercommand("heavy_melee_pressed", "+smoke");
  common_scripts\utility::func_A70D(var_01, var_00, "heavy_melee_pressed", level, "flag_first_zombie_dead", var_00, "damage", var_00, "melee_pressed");
  var_00 allowmovement(1);
  var_00 notifyonplayercommandremove("heavy_melee_pressed", "+smoke");
  var_00 notifyonplayercommandremove("melee_pressed", "+attack");
  var_00 notifyonplayercommandremove("melee_pressed", "+melee");
  var_00 notifyonplayercommandremove("melee_pressed", "+melee_zoom");
  var_00 notifyonplayercommandremove("melee_pressed", "+melee_breath");
  if(!common_scripts\utility::func_3C77("flag_first_zombie_dead")) {
    lib_0555::func_83DD("force_hide", var_00);
  }

  var_00.zombietrainingmovespeedscale = 1;
  var_00 maps\mp\gametypes\_weapons::func_A13B();
  var_00 allowjump(1);
  var_00 method_8113(1);
  var_00 method_8114(1);
}

func_5C82(param_00, param_01) {
  param_00 allowmovement(0);
  var_02 = common_scripts\utility::func_46B5(param_01, "targetname");
  var_03 = undefined;
  if(isDefined(var_02)) {
    var_03 = spawn("script_model", param_00.var_0116);
    var_03 setModel("tag_origin");
    var_04 = var_02.var_001D * (1, 0, 0) + param_00.var_001D * (0, 1, 0);
    var_03.var_001D = var_04;
    param_00 playerlinktoblend(var_03, "tag_origin", 0.15);
    var_03 moveto(var_02.var_0116, 0.15);
    var_03 rotateto(var_02.var_001D, 0.15);
    wait(0.15);
  }

  if(isDefined(var_03)) {
    param_00 unlink(var_03);
    var_03 delete();
  }

  param_00 allowmovement(1);
}

func_0A37() {
  thread func_0A38();
  thread func_0A39();
  level endon("flag_stop_aftermath_sway");
  level.var_A089 = 3;
  var_00 = 0;
  var_01 = 0;
  var_02 = 0.1;
  for(;;) {
    var_03 = distance((0, 0, 0), level.var_721C getvelocity());
    var_00 = var_00 + var_03 * 0.026 * level.var_A089;
    if(var_03 == 0) {
      var_00 = var_00 + 1.5;
    } else {
      var_00 = var_00 + randomfloatrange(0, 2);
    }

    var_01 = var_01 + var_03 * 0.01 * level.var_A089;
    if(var_03 == 0) {
      var_01 = var_01 + 1.5;
    } else {
      var_01 = var_01 + randomfloatrange(0, 2);
    }

    if(cos(var_00) > 0) {
      var_00 = var_00 + var_03 * 0.1;
    }

    var_04 = sin(var_00) - 1;
    var_05 = var_04 * 1.8 * level.var_A089;
    var_06 = sin(var_00) * 1 * level.var_A089;
    var_07 = sin(var_01) * 1.8 * level.var_A089;
    level.var_953D rotateto((var_05, var_07, var_06), var_02, var_02 * 0.5, var_02 * 0.5);
    wait 0.05;
  }
}

func_0A39() {
  level endon("flag_stop_aftermath_sway");
  var_00 = getent("trig_see_corpse", "targetname");
  var_00 common_scripts\utility::func_A71A(5, "trigger");
  level.var_A089 = 2;
  level.var_721C setscriptmotionblurparams(1.5, 0.75, 0.75);
  var_00 = getent("trig_see_corpse_2", "targetname");
  var_00 common_scripts\utility::func_A71A(5, "trigger");
  level.var_A089 = 1;
  level.var_721C setscriptmotionblurparams(1, 0.5, 0.5);
  var_00 = getent("trig_reach_shovel", "targetname");
  var_00 common_scripts\utility::func_A71A(5, "trigger");
  level.var_A089 = 0.5;
  level.var_721C setscriptmotionblurparams(0.5, 0.25, 0.25);
}

func_0A38() {
  common_scripts\utility::func_3C9F("flag_stop_aftermath_sway");
  var_00 = 0.8;
  level.var_953D rotateto((0, 0, 0), var_00, var_00 * 0.5, var_00 * 0.5);
  wait(var_00);
  level.var_953D delete();
  level.var_721C playersetgroundreferenceent(undefined);
  setslowmotion(0.95, 1, 0.5);
}

func_0A3A() {
  thread func_0A3B();
  level endon("flag_stop_aftermath_sway");
  level.var_721C setscriptmotionblurparams(2, 1, 1);
  for(;;) {
    wait 0.05;
    if(randomint(50) > 10) {
      continue;
    }

    var_00 = randomint(5) + 2;
    var_01 = randomfloatrange(0.3, 0.9);
    var_02 = randomfloatrange(0.3, 1);
    level.var_721C setblurforplayer(var_00 * 1.2, var_01);
    wait(var_01);
    level.var_721C setblurforplayer(0, var_02);
    wait(var_02);
  }
}

func_0A3B() {
  common_scripts\utility::func_3C9F("flag_stop_aftermath_sway");
  level.var_721C setblurforplayer(0, 0.1);
  level.var_721C method_8670();
}

func_2850() {
  lib_0378::func_8D74("aud_wakeup_submix_start");
  var_00 = common_scripts\utility::func_46B5("player_start_crawl_pos", "targetname");
  var_01 = common_scripts\utility::func_46B5("player_wakeup_point", "targetname");
  level.var_7317 = spawn("script_model", var_00.var_0116);
  level.var_7317.var_001D = var_00.var_001D;
  level.var_7317 setModel("player_zom_marie_world_arms");
  self setstance("stand");
  self method_848D();
  self setorigin(level.var_7317.var_0116);
  self setangles(level.var_7317.var_001D);
  self playerlinktoabsolute(level.var_7317, "tag_player");
  level.var_7317 method_8278("s2_zom_va_intro_wake_up");
  var_02 = getanimlength(%s2_zom_va_intro_wake_up);
  var_03 = 12;
  thread func_74BB();
  self shellshock("zm_training_injured", var_02);
  thread func_A002(self, 5, 1, 0, 0);
  wait(var_03);
  thread func_2EBC();
  wait(var_02 - var_03 + 2);
  func_A002(self, 1, 0, 1, 0);
  var_04 = level.var_7317 gettagorigin("tag_player");
  var_04 = var_04 + (0, 0, 64);
  level.var_7317 scriptmodelclearanim();
  level.var_7317.var_0116 = level.var_7317.var_0116 + (0, 0, 32);
  self unlink();
  level.var_7317 delete();
  self method_812A(0);
  self method_812B(0);
  self method_8113(0);
  self method_8308(0);
  self method_8114(1);
  self setstance("prone");
  waittillframeend;
  self method_8112(0);
  maps\mp\_utility::func_3E8E(1);
  self setorigin(var_01.var_0116);
  self setangles(var_01.var_001D);
  self allowmovement(0);
  wait(0.5);
  self method_848C();
  if(self getstance() != "prone") {
    self setstance("prone");
  }

  self method_8112(0);
  func_737F(1);
  lib_0586::func_078C("training_unarmed_zm");
  lib_0586::func_078E("training_unarmed_zm");
  self setspawnweapon("training_unarmed_zm", 0, 0);
  level.var_953D = spawn("script_model", (0, 0, 0));
  self playersetgroundreferenceent(level.var_953D);
  self setclientomnvar("ui_hide_hud", 1);
  thread func_2851();
  thread func_2852();
  thread func_A002(self, 5, 1, 0, 1);
  wait(3);
  maps\mp\_utility::func_3E8E(0);
  self allowmovement(1);
  self.zombietrainingmovespeedscale = 1;
  maps\mp\gametypes\_weapons::func_A13B();
  thread func_2853();
}

func_2853() {
  level endon("flag_player_revived");
}

func_2851() {
  level endon("flag_stop_crawl_sway");
  while(!common_scripts\utility::func_3C77("flag_stop_crawl_sway")) {
    var_00 = randomfloatrange(0.25, 1);
    var_01 = randomfloatrange(3, 4);
    level.var_953D rotateto((var_00, 0, 0), var_01, var_01 * 0.5, var_01 * 0.5);
    wait(var_01);
    level.var_953D rotateto((0 - var_00, 0, 0), var_01, var_01 * 0.5, var_01 * 0.5);
    wait(var_01);
  }
}

func_2852() {
  level endon("flag_player_revived");
  self.var_729F = 2.4;
  common_scripts\utility::func_3C8F("player_heartbeat_sound");
  for(;;) {
    if(common_scripts\utility::func_3C77("player_heartbeat_sound")) {
      wait 0.05;
      self playrumbleonentity("damage_light");
    }

    wait(self.var_729F);
    wait(0 + randomfloat(0.1));
    if(isDefined(self.zombietrainingmovespeedscale) && randomint(50) > self.zombietrainingmovespeedscale * 190) {
      wait(randomfloat(1));
    }
  }
}

func_3AA2() {
  common_scripts\utility::func_3C9F("field_to_yard");
  common_scripts\utility::func_3C8F("flag_player_awoke_horde");
  foreach(var_01 in level.var_3A72) {
    var_01 thread func_AB50();
  }
}

func_4EE8() {
  var_00 = lib_0547::func_AAFA("trig_entered_house", "targetname");
  common_scripts\utility::func_3C8F("flag_player_in_house");
  thread func_4EF5();
  foreach(var_02 in level.var_52D1) {
    if(isDefined(var_02) && isalive(var_02)) {
      var_02 thread func_AB50();
    }
  }

  level.var_28F0 = 2;
  lib_0557::func_782D("Training Quest", "Reach Farmhouse");
  var_04 = 0;
  if(common_scripts\utility::func_24A6()) {
    var_04 = 10;
  } else {
    var_04 = 20;
  }

  if(var_00.var_62D6 < 960) {
    var_00 maps\mp\gametypes\zombies::func_4798(960 - var_00.var_62D6 + var_04);
  }

  foreach(var_06 in level.var_4EE7) {
    thread func_3281(var_06, 0);
  }

  wait(1);
  foreach(var_02 in level.var_3A72) {
    foreach(var_0A in level.var_4EE7) {
      if(isDefined(var_02) && isalive(var_02)) {
        if(var_02 istouching(var_0A)) {
          var_02 suicide();
        }
      }
    }
  }

  var_00.zombietrainingmovespeedscale = 1;
  var_00 maps\mp\gametypes\_weapons::func_A13B();
  var_00 method_8308(1);
  var_00 method_8113(1);
  var_00 method_8114(1);
  common_scripts\utility::func_A70D(20, level, "flag_wallbuy_bought", level, "flag_all_initial_house_zombies_dead");
  func_4EE6(var_00);
}

func_4EF5() {
  level endon("disable_upper_floor_trig");
  lib_0547::func_AAFB("trig_awaken_upper_zombies");
  func_4EF4();
}

func_4EF4() {
  if(!isDefined(level.var_52D2) || level.var_52D2.size <= 0) {
    return;
  }

  foreach(var_01 in level.var_52D2) {
    if(isDefined(var_01) && isalive(var_01)) {
      var_01 thread func_AB50();
    }
  }
}

func_4EE6(param_00) {
  common_scripts\utility::func_3C8F("flag_link_field");
  common_scripts\utility::func_3C8F("flag_link_house");
  lib_0378::func_8D74("player_entered_house");
  if(level.var_21DA != 2) {
    level.var_28F0 = 2;
  }

  level.var_A981 = 1;
  level notify("zombies_manual_start");
  wait(10);
  common_scripts\utility::func_3C8F("flag_show_round_ui");
  level notify("disable_upper_floor_trig");
  func_4EF4();
}

func_5FED() {
  common_scripts\utility::func_3C9F("flag_exit_door_opened");
  if(!lib_0557::func_783E("Training Quest", "Find Weapon")) {
    lib_0557::func_782D("Training Quest", "Find Weapon");
  }

  if(!lib_0557::func_783E("Training Quest", "Earn Current")) {
    lib_0557::func_782D("Training Quest", "Earn Current");
  }

  lib_0557::func_782D("Training Quest", "Exit Farmhouse");
  var_00 = lib_0547::func_AAFA("trig_training_end", "targetname");
  common_scripts\utility::func_3C8F("flag_player_reached_exit");
  lib_056D::func_8A6E(1);
  lib_0557::func_782D("Training Quest", "Rendezvouse with Squad");
  lib_0555::func_83DD("force_hide", var_00);
  level.var_9C47.blockall = 1;
  var_00 thread func_36A6();
  var_00 setdemigod(1);
  var_00 func_3698();
  foreach(var_02 in maps\mp\agents\_agent_utility::func_43FD("all")) {
    var_02 suicide();
  }

  level.var_28F0 = 0;
  setDvar("scr_zombieCheckpoint", 0);
  level.var_8C7C = 0;
  level.var_7DD2 = 0;
  level.var_3B5C = level.var_746E;
  level thread maps\mp\gametypes\_gamelogic::func_36B9(level.var_746E, game["end_reason"]["zombies_completed"]);
  setnojipscore(0);
  thread maps\mp\_achievement_engine_z_utils::ae_sendmapwon_zm(var_00);
  wait 0.05;
  lib_0554::func_20CB("game_over");
}

func_3698() {
  var_00 = 8;
  var_01 = 2;
  self.zombietrainingmovespeedscale = 0.5;
  maps\mp\gametypes\_weapons::func_A13B();
  self method_8308(0);
  var_02 = newclienthudelem(self);
  var_02.var_01D3 = 0;
  var_02.var_01D7 = 0;
  var_02 setshader("vignette_hud", 640, 480);
  var_02.var_0010 = "left";
  var_02.var_0011 = "top";
  var_02.var_00C6 = "fullscreen";
  var_02.var_01CA = "fullscreen";
  var_02.var_0018 = 0;
  var_02 thread func_9FF3(2, 1);
  self setclientomnvar("ui_hide_hud", 1);
  lib_0555::func_83DD("force_hide", self);
  thread func_2E82();
  wait(var_00);
  thread func_A002(self, var_01, 0, 1);
  wait(var_01);
  self setclientomnvar("ui_hide_hud", 0);
}

func_36A6() {
  lib_0547::func_AAFB("trig_end_slow_walk");
  self.zombietrainingmovespeedscale = 0.25;
  maps\mp\gametypes\_weapons::func_A13B();
}

func_7331() {
  for(;;) {
    level waittill("player_spawned", var_00);
    if(level.var_744A.size > 1) {
      var_01 = var_00 getentitynumber();
      kick(var_01, "EXE_PLAYERKICKED_BOT_BALANCE");
    }
  }
}

func_725C() {
  level common_scripts\utility::func_A70A("player_disconnected", "exitLevel_called");
  level.var_28F0 = 0;
  func_737F(0);
  setDvar("scr_zombieCheckpoint", 0);
}

func_7254() {
  common_scripts\utility::func_A70C(level, "player_bleedout", self, "death");
  setDvar("scr_zombieCheckpoint", level.var_28F0);
  level.var_8C7C = 0;
  func_737F(0);
  if(isDefined(self.var_1780)) {
    self.var_1780 destroy();
  }

  foreach(var_01 in level.var_A7DE) {
    var_02 = function_021F(var_01.var_01A2, "targetname");
    foreach(var_04 in var_02) {
      var_04 hudoutlinedisable();
    }
  }
}

player_flashlightmonitor() {
  self endon("disconnect");
  for(;;) {
    if(isalive(self)) {
      if(playerinstartorfield()) {
        if(!isDefined(self.var_3D4C)) {
          lib_0551::func_3D52(1);
        }
      } else if(isDefined(self.var_3D4C)) {
        lib_0551::func_3D52(0);
      }
    } else if(isDefined(self.var_3D4C)) {
      lib_0551::func_3D52(0);
    }

    wait(1);
  }
}

func_7404() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isPlayer(self)) {
    return 0;
  }

  return lib_055A::func_7413(self, "zone_training_yard") || lib_055A::func_7413(self, "zone_training_house") || lib_055A::func_7413(self, "zone_training_end");
}

playerinstartorfield() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isPlayer(self)) {
    return 0;
  }

  return lib_055A::func_7413(self, "zone_training_start") || lib_055A::func_7413(self, "zone_training_field");
}

func_728D() {
  if(!isPlayer(self)) {
    return;
  }

  if(0) {
    self method_8349("frag_grenade_zm");
    maps\mp\_utility::func_0642("frag_grenade_zm");
    self method_82FA("frag_grenade_zm", 4);
  }

  var_00 = "shovel_zm";
  lib_0586::func_078C(var_00, 0, undefined, undefined, 1);
  lib_0586::func_078E(var_00);
  self setspawnweapon(var_00, 1, 1);
}

player_stripmods() {
  if(lib_0547::func_5767(self) && isPlayer(self)) {
    if(isDefined(level.var_AB22)) {
      foreach(var_02, var_01 in level.var_AB22) {
        if(lib_0547::func_4BA7(var_02)) {
          lib_0547::func_A086(var_02);
        }
      }
    }
  }
}

func_737F(param_00) {}

func_7268() {
  maps\mp\_utility::func_0642("role_ability_mad_minute_zm");
  level.var_AB43 = 1;
  common_scripts\utility::func_3C8F("flag_player_ability_enabled");
  if(0) {
    self roleapplypowerchange(1);
  }
}

func_1351() {
  var_00 = common_scripts\utility::func_46B7("sfx_horde_right_pos", "targetname");
  while(!common_scripts\utility::func_3C77("flag_player_has_weapon")) {
    var_01 = common_scripts\utility::func_7A33(var_00);
    thread lib_0378::func_8D74("random_growl", var_01);
    wait(randomfloatrange(5, 10));
  }
}

func_1319(param_00) {
  lib_0547::func_AAFA("trig_see_massacre", "targetname");
  param_00 thread lib_0378::func_8D74("see_massacre");
}

func_4051() {
  var_00 = spawnStruct();
  var_00.var_6ED0 = common_scripts\utility::func_46B5("ridge_patrol_path_1", "targetname");
  var_00.var_6EC2 = common_scripts\utility::func_46B5(var_00.var_6ED0.var_01A2, "targetname");
  var_01 = spawnStruct();
  var_01.var_6ED0 = common_scripts\utility::func_46B5("ridge_patrol_path_2", "targetname");
  var_01.var_6EC2 = common_scripts\utility::func_46B5(var_01.var_6ED0.var_01A2, "targetname");
  var_02 = common_scripts\utility::func_46B5("ger_death_pos", "targetname");
  var_03 = var_02 common_scripts\utility::func_8FFC();
  var_04 = common_scripts\utility::func_46B5("ger2_death_pos", "targetname");
  var_05 = var_04 common_scripts\utility::func_8FFC();
  level.var_404C = var_03;
  level.var_4057 = var_05;
  common_scripts\utility::func_3C9F("flag_germans_start_search");
  lib_0547::func_AAFA("trig_kill_germans", "targetname");
  common_scripts\utility::func_3C8F("flag_hit_patrol_trig");
}

func_404A() {
  var_00 = getent("creek_crawl2_body", "targetname");
  var_01 = undefined;
  var_02 = undefined;
  var_03 = undefined;
  if(isDefined(var_00)) {
    var_01 = getent(var_00.var_01A2, "targetname");
  }

  if(isDefined(var_01)) {
    var_02 = getent(var_01.var_01A2, "targetname");
    var_02 linkto(var_01, "J_Head");
  }

  if(isDefined(var_02)) {
    var_03 = getent(var_02.var_01A2, "targetname");
    var_03 linkto(var_00);
  }

  var_04 = getent("crawler_elec", "targetname");
  if(isDefined(var_00)) {
    if(isDefined(var_01)) {
      var_01 linkto(var_00, "j_spineupper", (-1, 0, 0), (0, 0, 0));
      var_00.var_39F2 = var_01;
    }

    var_04 linkto(var_00, "J_MainRoot");
    playFXOnTag(common_scripts\utility::func_44F5("zmb_electroschnelle_reg_chg_wv"), var_04, "J_Gun");
    var_00 method_8495(var_00.var_8109, var_00.var_0116, var_00.var_001D);
    if(isDefined(var_03)) {
      var_03 method_8495(var_00.var_8109, var_00.var_0116, var_00.var_001D);
    }

    wait(1);
    var_00 scriptmodelpauseanim(1);
    if(isDefined(var_03)) {
      var_03 scriptmodelpauseanim(1);
    }

    if(0) {
      common_scripts\utility::func_3C9F("flag_spawn_crawler");
    } else {
      lib_0547::func_AAFA("trig_spawn_crawler2", "targetname");
    }

    var_00 scriptmodelpauseanim(0);
    if(isDefined(var_03)) {
      var_03 scriptmodelpauseanim(0);
    }

    var_00 lib_0378::func_8D74("aud_german_crawling_foley");
    common_scripts\utility::func_3C9F("flag_player_got_electro");
    killfxontag(common_scripts\utility::func_44F5("zmb_electroschnelle_reg_chg_wv"), var_04, "J_Gun");
    var_04 delete();
  }
}

func_4049() {
  var_00 = getent("creek_crawl2_body", "targetname");
  var_01 = undefined;
  var_02 = undefined;
  var_03 = undefined;
  if(isDefined(var_00)) {
    var_01 = getent(var_00.var_01A2, "targetname");
  }

  if(isDefined(var_01)) {
    var_02 = getent(var_01.var_01A2, "targetname");
  }

  if(isDefined(var_02)) {
    var_03 = getent(var_02.var_01A2, "targetname");
  }

  var_04 = getent("crawler_elec", "targetname");
  if(isDefined(var_00)) {
    var_00 delete();
  }

  if(isDefined(var_01)) {
    var_01 delete();
  }

  if(isDefined(var_02)) {
    var_02 delete();
  }

  if(isDefined(var_03)) {
    var_03 delete();
  }

  if(isDefined(var_04)) {
    var_04 delete();
  }
}

func_4056() {
  thread func_4049();
}

func_284E() {
  var_00 = getent("static_creek_shovel", "targetname");
  common_scripts\utility::func_3C9F("flag_player_has_weapon");
  func_284D();
}

func_284D() {
  var_00 = getent("static_creek_shovel", "targetname");
  if(isDefined(var_00)) {
    var_00 delete();
  }
}

func_2849() {
  var_00 = lib_0547::func_AAFA("trig_pickup_elec_crawl", "targetname");
  common_scripts\utility::func_3C8F("flag_player_got_electro");
  var_00 playersetgroundreferenceent(undefined);
  thread func_2E9B();
  var_00 common_scripts\utility::func_0603();
  var_00 common_scripts\utility::func_0600();
  var_00 allowmovement(0);
  var_00 allowlook(0);
  var_00 lib_0586::func_078C("elec_inspect_zm");
  wait(0.25);
  var_00 lib_0586::func_078E("elec_inspect_zm", 1);
  wait(2.083);
  var_00 thread lib_0378::func_8D74("play_revive_sound");
  func_737F(0);
  var_00.var_729F = 0.8;
  var_00 allowjump(0);
  var_00 method_8308(0);
  var_00 method_8113(1);
  var_00 method_8112(1);
  wait(0.1);
  var_00 setstance("stand");
  var_00 method_8113(0);
  var_00 method_8114(0);
  wait(0.25);
  var_00 thread player_flashlightmonitor();
  var_00 setclientomnvar("ui_hide_hud", 0);
  var_00 playersetgroundreferenceent(level.var_953D);
  thread func_2EB8();
  wait(3.017);
  var_00.zombietrainingmovespeedscale = 0.3;
  common_scripts\utility::func_3C8F("flag_player_revived");
  var_00 maps\mp\gametypes\zombies::func_4798(850);
  thread func_0A37();
  thread func_0A3A();
  wait(0.25);
  var_00 lib_0586::func_078E(var_00 lib_0547::func_AB2B());
  var_00 common_scripts\utility::func_0617();
  var_00 common_scripts\utility::func_0614();
  if(var_00 hasweapon("elec_inspect_zm")) {
    var_00 lib_0586::func_0790("elec_inspect_zm");
  }

  var_00 allowmovement(1);
  var_00 allowlook(1);
}

func_2847(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = getEntArray("creek_corpse_blocker", "targetname");
  foreach(var_03 in var_01) {
    if(param_00) {
      var_03 solid();
      continue;
    }

    var_03 delete();
  }
}

func_2846() {
  common_scripts\utility::func_3C9F("flag_player_revived");
  thread func_2847(0);
}

func_2843() {
  var_00 = getent("crawl_buckle_beam", "targetname");
  var_01 = common_scripts\utility::func_46B5("crawl_buckle_beam_dest", "targetname");
  var_02 = common_scripts\utility::func_46B5("crawl_buckle_beam_fx", "targetname");
  var_03 = lib_0547::func_AAFB("trig_buckle_beam");
  thread lib_0378::func_8D74("crawl_beam_buckle");
  if(isDefined(var_00) && isDefined(var_01)) {
    var_00 moveto(var_01.var_0116, 0.15, 0.05, 0);
    var_00 rotateto(var_01.var_001D, 0.15, 0.05, 0);
  }

  if(isDefined(var_02)) {
    var_04 = lib_0547::func_8FBA(var_02, "zmb_fire_falling_beam_1");
    triggerfx(var_04);
  }

  level thread common_scripts\_exploder::func_088E(203);
}

func_2844() {
  var_00 = getent("crawl_collapse_beam", "targetname");
  var_01 = common_scripts\utility::func_46B5("crawl_collapse_beam_dest", "targetname");
  var_02 = common_scripts\utility::func_46B5("crawl_buckle_beam_fx", "targetname");
  var_03 = getent("creek_beam_blocker", "targetname");
  if(isDefined(var_03)) {
    var_03 notsolid();
  }

  var_04 = lib_0547::func_AAFB("trig_spawn_crawler2");
  thread lib_0378::func_8D74("crawl_beam_collapse");
  if(isDefined(var_00) && isDefined(var_01)) {
    var_00 moveto(var_01.var_0116, 0.15, 0.05, 0);
    var_00 rotateto(var_01.var_001D, 0.15, 0.05, 0);
  }

  if(isDefined(var_02)) {
    var_05 = lib_0547::func_8FBA(var_02, "zmb_fire_falling_beam_1");
    triggerfx(var_05);
  }

  if(isDefined(var_03)) {
    var_03 solid();
  }
}

func_284C() {
  var_00 = getent("crawl_buckle_beam", "targetname");
  var_01 = common_scripts\utility::func_46B5("crawl_buckle_beam_dest", "targetname");
  var_02 = getent("crawl_collapse_beam", "targetname");
  var_03 = common_scripts\utility::func_46B5("crawl_collapse_beam_dest", "targetname");
  var_04 = getent("creek_beam_blocker", "targetname");
  if(isDefined(var_04)) {
    var_04 solid();
  }

  if(isDefined(var_00)) {
    var_00 moveto(var_01.var_0116, 0.15, 0.05, 0);
    var_00 rotateto(var_01.var_001D, 0.15, 0.05, 0);
  }

  if(isDefined(var_02)) {
    var_02 moveto(var_03.var_0116, 0.15, 0.05, 0);
    var_02 rotateto(var_03.var_001D, 0.15, 0.05, 0);
  }
}

func_8A43() {
  lib_0547::func_AAFB("trig_see_farmhouse");
  thread func_2EA9();
}

func_8A44() {
  lib_0547::func_AAFB("trig_awaken_field_horde");
  thread func_2E74();
}

func_4055() {
  lib_0547::func_AAFB("trig_near_wallbuy_corpse");
  thread func_2EAC();
}

func_8387() {
  for(;;) {
    self waittill("trigger", var_00);
    if(!isPlayer(var_00)) {
      continue;
    } else {
      break;
    }

    wait(0.1);
  }

  self delete();
}

func_4EF3(param_00) {
  var_01 = common_scripts\utility::func_46B7("farmhouse_upper_traverse", "script_noteworthy");
  foreach(var_03 in var_01) {
    var_04 = getnodesinradius(var_03.var_0116, 15, 0, 90);
    foreach(var_06 in var_04) {
      if(lib_0547::func_55C2(var_06)) {
        setnavlinkenabled(var_06, param_00);
      }
    }
  }
}

func_74BB() {
  lib_0378::func_8D74("aud_pre_flare");
  wait(18);
  level thread common_scripts\_exploder::func_088E(201);
  lib_0378::func_8D74("aud_intro_flare");
  wait(1.4);
  level thread common_scripts\_exploder::func_088E(201);
}

func_ABD0() {
  level.var_A980++;
  level.var_A98C = gettime();
  level notify("waveupdate");
  level.var_ACC3++;
}

func_AC00() {
  common_scripts\utility::func_3C9F("flag_spawn_first_zombie");
  var_00 = common_scripts\utility::func_46B5("first_z_spawn_tree_door_1", "targetname");
  level.var_3C5F = lib_054D::func_90BA("zombie_generic", var_00, "first zombie", 0, 1, 0, "guts");
  level.var_3C5F.var_9C4F = 1;
  level.var_3C5F.var_8386 = 0;
  level.var_3C5F.var_56F1 = 1;
  level.var_3C5F.var_8065 = 0.3;
  level.var_3C5F func_ABB0();
  level.var_3C5F lib_0547::func_84CB();
}

func_ABFF() {
  common_scripts\utility::func_3C9F("flag_spawn_first_zombie");
  if(level.var_3C5E == 0) {
    var_00 = common_scripts\utility::func_46B5("first_z_spawn_stander", "targetname");
    var_01 = common_scripts\utility::func_46B5("first_z_goal", "targetname");
    level.var_3C5F = lib_054D::func_90BA("zombie_generic", var_00, "first zombie", 0, 1, 0, "guts");
    level.var_3C5F.var_9C4F = 1;
    level.var_3C5F.var_8386 = 0;
    level.var_3C5F.var_56F1 = 1;
    level.var_3C5F.var_8065 = 0.3;
    level.var_3C5F func_ABB0();
    level.var_3C5F lib_0547::func_84CB();
    level.var_3C5F scragentsetscripted(1);
    level.var_3C5F method_839C("anim deltas");
    level.var_3C5F maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "training");
    level.var_3C5F.var_509A = 1;
    level.var_3C5F.var_00CA = 1;
    level.var_3C5F maps\mp\agents\_scripted_agent_anim_util::func_71FD("s2_training_entry", 0, "scripted_anim");
    level.var_3C5F func_ABAD(0);
  }
}

func_ABF4(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(param_00) {
    self.var_6701 = 1;
    return;
  }

  self.var_6701 = 0;
}

func_AC02() {
  var_00 = common_scripts\utility::func_46B5("first_z_spawn_stander", "targetname");
  var_01 = common_scripts\utility::func_46B5("first_z_goal", "targetname");
  level.var_3C60 = lib_054D::func_90BA("zombie_generic", var_00, "first zombie", 0, 1, 0, "guts");
  level.var_3C60.var_8386 = 1;
  level.var_3C60.var_5750 = 1;
  level.var_3C60.var_8065 = 0.6;
  level.var_3C60 lib_0547::func_84CB();
  level.var_3C60 func_ABD9();
  level.var_3C60 scragentsetscripted(1);
  level.var_3C60 method_839C("anim deltas");
  level.var_3C60 maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "training");
  level.var_3C60.var_509A = 1;
  level.var_3C60.var_00CA = 1;
  level.var_3C60 thread func_ABD8();
  level.var_3C60.var_56DC = 1;
  level.var_3C60 maps\mp\agents\_scripted_agent_anim_util::func_71FD("s2_training_entry", 0, "scripted_anim");
  level.var_3C60 func_ABAD(0);
  level.var_3C60.var_56DC = 0;
}

func_ABD8() {
  var_00 = getent("trig_awaken_first_z_lure", "targetname");
  var_01 = common_scripts\utility::func_A70E(level, "flag_first_zombie_dead", var_00, "trigger");
  var_02 = var_01[0];
  var_03 = var_01[1];
  if(var_02 == "flag_first_zombie_dead") {
    wait(3);
  }

  while(common_scripts\utility::func_562E(level.var_3C60.var_56DC)) {
    wait(1);
  }

  if(isalive(level.var_3C60)) {
    level.var_3C60 thread func_ABAC();
  }
}

func_ABFC() {
  common_scripts\utility::func_3C9F("flag_spawn_first_zombie");
  var_00 = common_scripts\utility::func_46B7("first_z_spawn_faker_fakes", "targetname");
  foreach(var_02 in var_00) {
    var_03 = lib_054D::func_90BA("zombie_generic", var_02, "first zombie", 0, 1, 0);
    var_03 func_ABF4(1);
    var_03 suicide();
  }
}

func_ABAD(param_00) {
  self scragentsetscripted(1);
  self.var_57C0 = 1;
  maps\mp\agents\_scripted_agent_anim_util::func_8415("passive_idle", param_00);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "training");
}

func_ABAC() {
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "training");
  self scragentsetscripted(0);
  self.var_57C0 = 0;
  self.var_509A = 0;
  self.var_00CA = 0;
}

func_ABAF() {
  level endon("flag_first_zombie_dead");
  level endon("flag_player_in_house");
  self endon("death");
  for(;;) {
    if(common_scripts\utility::func_AA4A(level.var_721C.var_0116, level.var_721C.var_001D, self.var_0116, cos(45)) && distance2dsquared(level.var_721C.var_0116, self.var_0116) < squared(500)) {
      if(!self.var_8386) {
        lib_0555::func_83DD("training_melee_2", level.var_721C);
        level.var_721C thread creek_firstzombiekillnotifyhide();
        self.var_8386 = 1;
      }

      if(distance2dsquared(level.var_721C.var_0116, self.var_0116) < squared(75)) {
        common_scripts\utility::func_3C8F("flag_player_close_to_first_zombie");
        break;
      }
    }

    wait(0.2);
  }
}

func_ABB0() {
  self.var_4BF2 = "zom_head_fdr02_org1";
  self.var_4B5A = 0;
  self.var_4B6E = 0;
  self.var_18B0 = "guts";
  lib_0547::func_A19E();
}

func_ABD9() {
  self.var_4BF2 = "zom_head_fdr04_org1";
  self.var_4B5A = 0;
  self.var_4B6E = 1;
  self.var_4CAA = "zom_m40helmet_net1";
  self.var_18B0 = "poncho";
  lib_0547::func_A19E();
}

func_ABAE(param_00, param_01, param_02) {
  if(isalive(param_00)) {
    param_00.var_5ED1 = param_00 gettagorigin("TAG_EYE");
  } else {
    return;
  }

  var_03 = 1;
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(param_02) {
    var_03 = param_00 func_55E2(param_01);
  }

  if(var_03) {
    var_04 = param_00.var_5ED1 - param_01 getEye();
    param_01 setangles(vectortoangles(var_04));
  }
}

func_ABDC(param_00) {
  level endon("flag_player_in_house");
  level endon("flag_light_melee_popup_shown");
  if(!isDefined(param_00)) {
    param_00 = "melee1";
  }

  for(;;) {
    if(common_scripts\utility::func_AA4A(level.var_721C.var_0116, level.var_721C.var_001D, self.var_0116, cos(45)) && distance2dsquared(level.var_721C.var_0116, self.var_0116) < squared(150)) {
      lib_0555::func_83DD("training_melee_1", level.var_721C);
      common_scripts\utility::func_3C8F("flag_light_melee_popup_shown");
      break;
    }

    wait(0.2);
  }
}

func_AC03() {
  level notify("waveupdate");
  level.var_ACC3++;
  var_00 = common_scripts\utility::func_46B7("yard_spawners", "targetname");
  level.var_3A72 = [];
  var_01 = "wave 3";
  var_02 = 0;
  var_03 = 1;
  var_04 = 0;
  var_05 = undefined;
  var_06 = 0;
  var_07 = undefined;
  for(var_08 = 0; var_08 < var_00.size; var_08++) {
    var_09 = lib_054D::func_90BA("zombie_generic", var_00[var_08], var_01, var_02, var_03, var_04, var_05, var_06, var_07);
    var_09.var_9C4F = 4;
    level.var_3A72[level.var_3A72.size] = var_09;
    var_09.var_509A = 1;
    var_09 thread func_ABDC("melee1");
    var_09 lib_0547::func_84CB();
    var_09 func_ABB1();
  }
}

func_AC01() {
  var_00 = common_scripts\utility::func_46B7("initial_house_upper_spawners", "targetname");
  var_01 = common_scripts\utility::func_46B7("initial_house_lower_spawners", "targetname");
  level.var_52D2 = [];
  level.var_52D1 = [];
  level.var_52D3 = [];
  var_02 = "wave 3";
  var_03 = 0;
  var_04 = 1;
  var_05 = 0;
  var_06 = undefined;
  var_07 = 0;
  var_08 = undefined;
  for(var_09 = 0; var_09 < var_01.size; var_09++) {
    var_0A = lib_054D::func_90BA("zombie_generic", var_01[var_09], var_02, var_03, var_04, var_05, var_06, var_07, var_08);
    var_0A.var_9C4F = 3;
    level.var_52D1[level.var_52D1.size] = var_0A;
    var_0A thread func_ABDC("melee1");
    var_0A lib_0547::func_84CB();
    var_0A func_ABB1();
  }

  for(var_09 = 0; var_09 < var_00.size; var_09++) {
    var_0A = lib_054D::func_90BA("zombie_generic", var_00[var_09], var_02, var_03, var_04, var_05, var_06, var_07, var_08);
    var_0A.var_9C4F = 3;
    level.var_52D2[level.var_52D2.size] = var_0A;
    var_0A thread func_ABDC("melee1");
    var_0A lib_0547::func_84CB();
    var_0A func_ABB1();
  }

  level.var_52D3 = common_scripts\utility::func_0F73(level.var_52D1, level.var_52D2);
  foreach(var_0A in level.var_52D3) {
    var_0A func_ABB1();
  }
}

func_ABD4(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(isPlayer(self)) {
    return;
  }

  if(0) {
    if(!common_scripts\utility::func_3C77("flag_player_ability_enabled")) {
      if(level.var_A980 >= 2) {
        level.var_4EF0++;
      }

      if(level.var_4EF0 > 15) {
        level.var_721C func_7268();
      }
    }
  }

  if(isDefined(self.var_9C4F)) {
    switch (self.var_9C4F) {
      case 1:
        common_scripts\utility::func_3C8F("flag_first_zombie_dead");
        wait(3);
        lib_0555::func_83DD("training_econ_1", self);
        maps\mp\_utility::func_2CED(2, ::func_2E91);
        maps\mp\_utility::func_2CED(6, ::lib_0555::func_83DD, "training_econ_2", self);
        break;

      case 2:
        break;

      case 3:
        level.var_3A72 = common_scripts\utility::func_0F93(level.var_3A72, self);
        if(level.var_3A72.size == 0) {
          common_scripts\utility::func_3C8F("flag_all_field_zombies_dead");
        }
        break;

      case 4:
        level.var_52D3 = common_scripts\utility::func_0F93(level.var_52D3, self);
        if(level.var_52D3.size == 0) {
          common_scripts\utility::func_3C8F("flag_all_initial_house_zombies_dead");
        }
        break;

      default:
        break;
    }
  }
}

func_ABB1(param_00) {
  self scragentsetscripted(1);
  self.var_57C0 = 1;
  self.var_00CA = 1;
  maps\mp\agents\_scripted_agent_anim_util::func_8415("passive_idle", param_00);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "training");
  self.var_509A = 1;
}

func_AB50() {
  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "training");
  self scragentsetscripted(0);
  self.var_57C0 = 0;
  self.var_509A = 0;
  self.var_00CA = 0;
}

func_9FAF() {
  level endon("flag_player_reached_exit");
  for(;;) {
    self waittill("weapon_change", var_00);
    if(var_00 == "role_ability_mad_minute_zm") {
      break;
    }
  }

  lib_0378::func_8D74("aud_stop_player_vox");
  wait 0.05;
  setslowmotion(1, 0.25, 0.05);
  self setdemigod(1);
  common_scripts\utility::func_A74B("zm_role_putaway", 4);
  setslowmotion(0.25, 1, 0.05);
  self setdemigod(0);
  level.var_AB43 = 0;
  wait 0.05;
  lib_0378::func_8D74("aud_start_player_vox");
}

func_9FB0() {
  level endon("flag_player_reached_exit");
  level endon("challenge_kill_highlights");
  level.var_5B5D = undefined;
  common_scripts\utility::func_3C9F("flag_player_ability_enabled");
  thread func_9FAF();
  for(;;) {
    var_00 = self rolecheckstate("ready");
    var_01 = self rolecheckstate("active");
    if(var_01) {
      common_scripts\utility::func_3C8F("flag_player_used_ability");
      wait(1);
      continue;
    }

    if(isDefined(level.var_5B5D) && level.var_5B5D + 30000 > gettime()) {
      wait(1);
      continue;
    }

    if(var_00 && !func_9FFB()) {
      common_scripts\utility::func_3C7B("flag_player_used_ability");
      level.var_5B5D = gettime();
      if(!level.var_258F && !common_scripts\utility::func_55E0()) {
        lib_0555::func_83DD("training_special_pc", self);
      } else {
        lib_0555::func_83DD("training_special", self);
      }

      thread tut_playerusedabilitynotifyhide();
      continue;
    }

    wait 0.05;
  }
}

tut_playerusedabilitynotifyhide() {
  var_00 = level common_scripts\utility::func_A74D("flag_player_used_ability", 10);
  if(lib_0547::func_5565(var_00, "timeout")) {
    return;
  }

  lib_0555::func_83DD("force_hide", self);
}

func_9FAA(param_00) {
  level endon("flag_exit_door_opened");
  level endon("challenge_kill_highlights");
  common_scripts\utility::func_3C9F("flag_player_in_house");
  var_01 = 0;
  var_02 = 0;
  var_03 = param_00.var_8140;
  for(;;) {
    self waittill("money_update");
    var_04 = self.var_62D6;
    if(var_04 >= var_03) {
      if(!common_scripts\utility::func_3C77(lib_0557::func_7838("Training Quest", "Earn Current"))) {
        lib_0557::func_782D("Training Quest", "Earn Current");
      }

      if(!var_01) {
        lib_0555::func_83DD("training_exit", self);
        var_01 = 1;
        if(!var_02) {
          if(isDefined(param_00.var_8301)) {
            foreach(var_06 in param_00.var_8301) {
              var_06 hudoutlineenableforclient(self, 0, 0);
            }

            var_02 = 1;
          }
        }
      }
    } else {
      if(var_01) {
        var_01 = 0;
      }

      if(var_02) {
        if(isDefined(param_00.var_8301)) {
          foreach(var_06 in param_00.var_8301) {
            var_06 hudoutlinedisable();
          }

          var_02 = 0;
        }
      }
    }

    wait 0.05;
  }
}

func_9FA5() {
  level endon("flag_player_reached_exit");
  common_scripts\utility::func_3C9F("flag_player_in_house");
  var_00 = 0;
  var_01 = [];
  foreach(var_03 in level.var_A7DE) {
    if(isDefined(var_03.var_0165)) {
      var_01[var_01.size] = var_03.var_0165;
    }
  }

  for(;;) {
    var_05 = self getcurrentweapon();
    if(common_scripts\utility::func_0F79(var_01, var_05)) {
      var_06 = self getfractionmaxammo(var_05);
      if(var_06 < 0.25 && !var_00 && !func_9FFB()) {
        lib_0555::func_83DD("training_ammo", self);
        var_00 = 1;
        break;
      }
    }

    wait(0.5);
  }
}

func_9FA6() {
  level endon("flag_player_reached_exit");
  level endon("challenge_kill_highlights");
  common_scripts\utility::func_3C9F("flag_player_in_house");
  var_00 = 0;
  var_01 = [];
  var_02 = [];
  var_03 = 0;
  foreach(var_05 in level.var_A7DE) {
    if(isDefined(var_05.var_0165)) {
      var_01[var_01.size] = var_05.var_0165;
    }
  }

  level.var_5B5E = undefined;
  for(;;) {
    var_07 = self getcurrentweapon();
    if(!isDefined(var_07)) {
      wait(1);
      continue;
    }

    var_08 = self getfractionmaxammo(var_07);
    if(var_08 >= 0.25) {
      if(var_03) {
        foreach(var_0A in var_02) {
          var_0A hudoutlinedisable();
        }

        var_02 = [];
        var_03 = 0;
      }

      wait(1);
      continue;
    }

    if(isDefined(level.var_5B5E) && level.var_5B5E + 20000 > gettime()) {
      wait(1);
      continue;
    }

    var_0C = undefined;
    var_0D = [];
    foreach(var_05 in level.var_A7DE) {
      if(isDefined(var_05.var_0165)) {
        if(var_05.var_0165 == getweapondisplayname(var_07)) {
          var_0C = var_05;
          var_0D = function_021F(var_0C.var_01A2, "targetname");
        }
      }
    }

    if(!func_9FFB()) {
      if(common_scripts\utility::func_0F79(var_01, var_07)) {
        level.var_5B5E = gettime();
        lib_0555::func_83DD("training_ammo", self);
        if(isDefined(var_0C)) {
          foreach(var_0A in var_0D) {
            var_0A hudoutlineenableforclient(self, 0, 0);
            var_02[var_02.size] = var_0A;
          }

          var_03 = 1;
        }
      }
    }

    wait(1);
  }
}

func_9FAB() {
  level endon("flag_player_in_house");
  lib_0547::func_AAFB("trig_show_hint_tut");
  lib_0555::func_83DD("training_hint_1", self);
  common_scripts\utility::func_3C8F("flag_show_inventory");
  self notifyonplayercommand("toggleScoresDown", "togglescores");
  self.var_00CE = 1;
  setslowmotion(1, 0.25, 0.5);
  thread func_A002(self, 0.25, 0, 1, 0, "vignette_hud");
  common_scripts\utility::func_A74B("toggleScoresDown", 2);
  lib_0557::func_7848("Training Quest");
  lib_0555::func_83DD("training_hint_2", self);
  self.var_00CE = 0;
  setslowmotion(0.25, 1, 0.5);
  thread func_A002(self, 0.25, 1, 0, 1);
  self notifyonplayercommandremove("toggleScoresDown", "togglescores");
}

func_9FAD() {
  common_scripts\utility::func_3C9F("flag_player_in_house");
  for(;;) {
    var_00 = lib_0547::func_AAFB("trig_near_perk");
    if(!func_9FFB()) {
      if(!common_scripts\utility::func_3C77("flag_perk_popup_shown")) {
        lib_0555::func_83DD("training_blitz", var_00);
        common_scripts\utility::func_3C8F("flag_perk_popup_shown");
        break;
      }
    }

    wait(1);
  }
}

func_9FA7() {
  common_scripts\utility::func_3C9F("flag_player_in_house");
  for(;;) {
    var_00 = lib_0547::func_AAFB("trig_near_armor");
    if(!func_9FFB()) {
      if(!common_scripts\utility::func_3C77("flag_armor_popup_shown")) {
        lib_0555::func_83DD("training_armor", var_00);
        common_scripts\utility::func_3C8F("flag_armor_popup_shown");
        break;
      }
    }

    wait(1);
  }
}

func_9FAE() {
  common_scripts\utility::func_3C9F("flag_wallbuy_bought");
  if(!lib_0557::func_783E("Training Quest", "Find Weapon")) {
    lib_0557::func_782D("Training Quest", "Find Weapon");
  }

  for(;;) {
    wait(5);
    if(!func_9FFB()) {
      if(!common_scripts\utility::func_3C77("flag_shovel_popup_shown")) {
        lib_0555::func_83DD("training_shovel", level.var_721C);
        common_scripts\utility::func_3C8F("flag_shovel_popup_shown");
        break;
      }
    }
  }
}

func_9FB2() {
  level endon("flag_player_reached_exit");
  level endon("challenge_kill_highlights");
  common_scripts\utility::func_3C9F("flag_player_in_house");
  var_00 = [];
  foreach(var_02 in level.var_A7DE) {
    if(isDefined(var_02.var_0165)) {
      var_00[var_00.size] = var_02.var_0165;
    }

    var_02 thread func_9FB1(self);
    var_03 = function_021F(var_02.var_01A2, "targetname");
    foreach(var_05 in var_03) {
      var_05 hudoutlineenableforclient(self, 0, 0);
    }
  }

  var_08 = 0;
  for(;;) {
    self waittill("weapon_change", var_09);
    if(!isalive(self)) {
      break;
    }

    foreach(var_0B in var_00) {
      if(lib_0586::func_0791(var_0B, var_09)) {
        thread func_2EB9();
        common_scripts\utility::func_3C8F("flag_wallbuy_bought");
        if(!0) {
          func_7268();
        }

        var_08 = 1;
      }
    }

    if(var_08) {
      break;
    }
  }

  foreach(var_02 in level.var_A7DE) {
    var_03 = function_021F(var_02.var_01A2, "targetname");
    foreach(var_05 in var_03) {
      var_05 hudoutlinedisable();
    }
  }
}

func_9FB1(param_00) {
  level endon("flag_player_reached_exit");
  level.var_5B64 = undefined;
  while(!common_scripts\utility::func_3C77("flag_wallbuy_bought")) {
    if(isDefined(level.var_5B64) && level.var_5B64 + 20000 > gettime()) {
      wait(1);
      continue;
    }

    if(distance2dsquared(param_00.var_0116, self.var_0116) < squared(100)) {
      level.var_5B64 = gettime();
      lib_0555::func_83DD("training_wallbuy", self);
      thread tut_playerboughtwallbuynotifyhide();
      wait(5);
    }

    wait(0.5);
  }
}

tut_playerboughtwallbuynotifyhide() {
  var_00 = level common_scripts\utility::func_A74D("flag_wallbuy_bought", 5);
  if(lib_0547::func_5565(var_00, "timeout")) {
    return;
  }

  lib_0555::func_83DD("force_hide", self);
}

func_A00F(param_00, param_01, param_02, param_03) {
  var_04 = 0.35;
  var_05 = 0.35;
  if(!isDefined(param_00)) {
    return;
  }

  if(common_scripts\utility::func_562E(level.var_9C47.blockall)) {
    return;
  }

  var_06 = level.var_9C48[param_00];
  if(func_9FFB() && common_scripts\utility::func_562E(param_03)) {
    func_9FF4(1);
  }

  level.var_9C47 settext(var_06);
  level.var_9C47 thread func_9FF3(var_04, 1);
  level.var_9C47.var_2940 = param_00;
  if(isDefined(param_01) || isDefined(param_02)) {
    if(isDefined(param_01) && function_02A2(param_01) && isDefined(param_02)) {
      common_scripts\utility::func_A64B(param_02, param_01);
    } else if(isDefined(param_01) && function_02A2(param_01)) {
      wait(param_01);
    } else if(isDefined(param_02)) {
      common_scripts\utility::func_3C9F(param_02);
    }

    if(func_9FFB() && level.var_9C47.var_0018 == 1 && lib_0547::func_5565(level.var_9C47.var_2940, param_00)) {
      level.var_9C47 thread func_9FF3(var_05, 0);
      level.var_9C47.var_2940 = undefined;
      return;
    }
  }
}

func_A00E(param_00, param_01, param_02) {
  if(!func_9FFB()) {
    func_A00F(param_00, param_01, param_02);
  }
}

func_9FF4(param_00) {
  if(common_scripts\utility::func_562E(param_00)) {
    level.var_9C47.var_0018 = 0;
  } else {
    level.var_9C47 func_9FF3(0.35, 0);
  }

  level.var_9C47.var_2940 = undefined;
}

func_9FFB() {
  return level.var_9C47.var_0018 > 0;
}

func_9FF1(param_00) {
  level.var_9C47 = newclienthudelem(param_00);
  level.var_9C47.var_00A0 = 1;
  level.var_9C47.var_0184 = 2;
  level.var_9C47.var_00C2 = 0;
  level.var_9C47.var_0010 = "center";
  level.var_9C47.var_0011 = "bottom";
  level.var_9C47.var_00C6 = "center";
  level.var_9C47.var_01CA = "top";
  level.var_9C47.var_017A = 1;
  level.var_9C47.var_009B = 1.25;
  level.var_9C47.var_01D3 = 0;
  level.var_9C47.var_01D7 = 100;
  level.var_9C47.var_0056 = (1, 1, 1);
  level.var_9C47.var_0018 = 0;
}

func_A002(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_05)) {
    param_05 = "black";
  }

  if(!isDefined(param_00.var_1780)) {
    param_00.var_1780 = newclienthudelem(param_00);
    param_00.var_1780.var_01D3 = 0;
    param_00.var_1780.var_01D7 = 0;
    param_00.var_1780 setshader(param_05, 640, 480);
    param_00.var_1780.var_0010 = "left";
    param_00.var_1780.var_0011 = "top";
    param_00.var_1780.var_00C6 = "fullscreen";
    param_00.var_1780.var_01CA = "fullscreen";
    param_00.var_1780.var_0018 = param_02;
  }

  param_00.var_1780 func_9FF3(param_01, param_03);
  if(common_scripts\utility::func_562E(param_04)) {
    param_00.var_1780 destroy();
  }
}

func_9FF3(param_00, param_01) {
  self fadeovertime(param_00);
  self.var_0018 = param_01;
  wait(param_00);
}

func_2EBC() {
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_whatwasthatthing");
}

func_2E80() {
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_maybesomebodysurvivedthey");
}

func_2E78() {
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_drostenoliviajefferson");
  wait(4);
  common_scripts\utility::func_3C8F("flag_germans_start_search");
  wait(1);
  var_00 = common_scripts\utility::func_46B5("ger_start_pos", "targetname");
  thread lib_0378::func_8D74("ger_search", var_00, level.var_404C);
  wait(2);
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_ohshit");
  if(0) {
    wait(2.6);
    common_scripts\utility::func_3C8F("flag_patrol_spots_zombie");
    wait(3);
    lib_0378::func_8D74("training_dist_gunfire");
    wait(2);
    common_scripts\utility::func_3C8F("flag_spawn_crawler");
    wait(2);
    thread func_1351();
  }
}

func_2E8C() {
  if(!0) {
    lib_0378::func_8D74("ger_combat1", level.var_404C);
    common_scripts\utility::func_3C8F("flag_patrol_spots_zombie");
    wait(4);
    lib_0378::func_8D74("training_dist_gunfire");
    wait(2);
    common_scripts\utility::func_3C8F("flag_spawn_crawler");
    wait(2);
    thread func_1351();
  }
}

func_2EA8() {
  wait(1.5);
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_whatwhatinthehell");
}

func_2EAE() {
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_ohgodnono");
}

func_2EAF() {
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_ihavetogetawayihavetomove");
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_thatsoldieraheadmaybeheha");
}

func_2E9B() {
  level.var_721C lib_0378::func_8D74("uber_battery_pickup");
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_whatisthisklausmentioneds");
}

func_2EB8() {
  wait(0.5);
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_itclosedmywounds");
}

func_2E7F() {
  wait(1);
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_gottimhimmel");
}

func_2E91() {
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_thatsoldierheshouldnotbea");
}

func_2E97() {}

func_2EA9() {
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_irememberthatfarmhouseits");
}

func_2E74() {
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_moreofthosebrokensoldiers");
}

func_2EBD(param_00) {
  wait(2);
  if(param_00 == 3) {
    level.var_721C thread lib_0367::func_8E3C("comeinwaves");
    return;
  }

  if(param_00 == 4) {
    level.var_721C thread lib_0367::func_8E3C("gettingstronger");
  }
}

func_2EAC() {}

func_2EB9() {
  level.var_721C thread lib_0378::func_307E("zmb_train_mari_thenazisusethisenergyfrom");
}

func_2EAB() {
  level.var_721C thread lib_0367::func_8E3C("opendoor");
}

func_2E82() {
  level.var_721C thread lib_0367::func_8E3C("townahead", undefined, 1, 1);
  level.var_721C thread lib_0367::func_8E3C("hopealive", undefined, 1, 1);
}

func_357A() {
  level.var_5AF2 = getEntArray("lamp_mystery_box", "targetname");
  foreach(var_01 in level.var_5AF2) {
    var_01 setCanDamage(1);
    var_01.var_4DC9 = 0;
    var_01 thread func_3579();
  }

  if(!isDefined(level.var_5F74)) {
    for(;;) {
      if(isDefined(level.var_5F74)) {
        break;
      } else {
        wait(1);
      }
    }
  }

  if(level.var_5F74.size == 0) {
    return;
  }

  foreach(var_04 in level.var_5F74) {
    thread maps\mp\zombies\_zombies_magicbox::func_135B(var_04);
  }

  common_scripts\utility::func_3C9F("flag_all_lamps_hit");
  foreach(var_04 in level.var_5F74) {
    thread maps\mp\zombies\_zombies_magicbox::func_135C(var_04);
  }

  foreach(var_09 in level.var_65F6) {
    func_3281(var_09, 1);
  }

  thread func_357C();
}

func_357C() {
  while(!isDefined(level.var_5F7F)) {
    wait(1);
  }

  maps\mp\zombies\_zombies_magicbox::func_7CEA("fliegerfaust_zm");
  maps\mp\zombies\_zombies_magicbox::func_7CEA("karabin_zm");
  maps\mp\zombies\_zombies_magicbox::func_7CEA("kar98_zm");
  maps\mp\zombies\_zombies_magicbox::func_7CEA("springfield_zm");
  maps\mp\zombies\_zombies_magicbox::func_7CEA("leeenfield_zm");
}

func_3579() {
  self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
  self.var_4DC9 = 1;
  var_0A = (0, 0, 0);
  if(self.var_0106 == "ger_oil_lamp_01_a") {
    var_0A = (0, 0, 8);
  } else if(self.var_0106 == "ger_oil_lamp_01_b") {
    var_0A = (0, 0, -22);
  }

  playFX(common_scripts\utility::func_44F5("ee_lamp_fx"), self.var_0116 + var_0A, anglesToForward(self.var_001D), anglestoup(self.var_001D));
  thread lib_0378::func_8D74("ee_update");
  var_0B = 1;
  foreach(var_0D in level.var_5AF2) {
    if(!var_0D.var_4DC9) {
      var_0B = 0;
    }
  }

  if(var_0B) {
    common_scripts\utility::func_3C8F("flag_all_lamps_hit");
    thread lib_0378::func_8D74("ee_complete");
    if(level.var_A980 <= 25 && maps\mp\_utility::func_4571() == "mp_zombie_training") {
      level.var_400E[level.var_400E.size] = ["mountain_man_set 4 -1", "all"];
    }
  }
}

func_AA3D() {
  if(!0) {
    var_00 = getEntArray("zbarrier_window", "script_noteworthy");
    foreach(var_02 in var_00) {
      var_02 makeunusable();
    }
  }
}

func_327D() {
  level.var_65F6 = getEntArray("mysterybox_door", "targetname");
  foreach(var_01 in level.var_65F6) {
    var_02 = getEntArray(var_01.var_01A2, "targetname");
    foreach(var_04 in var_02) {
      if(!isDefined(var_04.var_0165)) {
        continue;
      }

      var_05 = var_04.var_0165;
      switch (var_05) {
        case "door_model":
          var_01.var_326B = var_04;
          var_06 = common_scripts\utility::func_46B5(var_04.var_01A2, "targetname");
          var_07 = common_scripts\utility::func_46B5(var_06.var_01A2, "targetname");
          var_01.var_6BE3 = var_06.var_001D;
          var_01.var_2443 = var_07.var_001D;
          break;

        case "door_model_r":
          var_01.var_326D = var_04;
          var_08 = common_scripts\utility::func_46B5(var_04.var_01A2, "targetname");
          var_09 = common_scripts\utility::func_46B5(var_08.var_01A2, "targetname");
          var_01.var_6BF2 = var_08.var_0116;
          var_01.var_2446 = var_09.var_0116;
          break;

        case "door_model_l":
          var_01.var_326C = var_04;
          var_0A = common_scripts\utility::func_46B5(var_04.var_01A2, "targetname");
          var_0B = common_scripts\utility::func_46B5(var_0A.var_01A2, "targetname");
          var_01.var_6BF1 = var_0A.var_0116;
          var_01.var_2445 = var_0B.var_0116;
          break;

        default:
          break;
      }
    }

    func_3281(var_01, 0);
  }
}

func_327C() {
  level.var_4EE7 = getEntArray("house_door", "targetname");
  foreach(var_01 in level.var_4EE7) {
    var_02 = getent(var_01.var_01A2, "targetname");
    var_03 = common_scripts\utility::func_46B5(var_02.var_01A2, "targetname");
    var_04 = common_scripts\utility::func_46B5(var_03.var_01A2, "targetname");
    var_01.var_326B = var_02;
    var_01.var_6BE3 = var_03.var_001D;
    var_01.var_2443 = var_04.var_001D;
  }
}

func_3281(param_00, param_01) {
  if(common_scripts\utility::func_562E(param_01)) {
    if(isDefined(param_00.var_326C) && isDefined(param_00.var_326D)) {
      if(param_00.var_326C.var_0116 != param_00.var_6BF1) {
        param_00.var_326C moveto(param_00.var_6BF1, 1, 0.25, 0.5);
      }

      if(param_00.var_326D.var_0116 != param_00.var_6BF2) {
        param_00.var_326D moveto(param_00.var_6BF2, 1, 0.25, 0.5);
      }
    } else if(param_00.var_326B.var_001D != param_00.var_6BE3) {
      param_00.var_326B rotateto(param_00.var_6BE3, 1, 0.25, 0.5);
    }

    param_00 lib_0378::func_8D74("door_open");
    param_00 notsolid();
    param_00 method_8060();
    return;
  }

  if(isDefined(param_00.var_326C) && isDefined(param_00.var_326D)) {
    if(param_00.var_326C.var_0116 != param_00.var_2445) {
      param_00.var_326C moveto(param_00.var_2445, 1, 0.25, 0.5);
    }

    if(param_00.var_326D.var_0116 != param_00.var_2446) {
      param_00.var_326D moveto(param_00.var_2446, 1, 0.25, 0.5);
    }
  } else if(param_00.var_326B.var_001D != param_00.var_2443) {
    param_00.var_326B rotateto(param_00.var_2443, 1, 0.25, 0.5);
  }

  param_00 lib_0378::func_8D74("door_close");
  param_00 solid();
  param_00 method_805F();
}

func_325F() {
  var_00 = "house_to_end";
  foreach(var_02 in level.var_AC1D) {
    if(lib_0547::func_5565(var_02.var_819A, var_00)) {
      return var_02;
    }
  }
}

func_3263() {
  childthread func_3279();
  self waittill("open", var_00);
  common_scripts\utility::func_3C8F("flag_exit_door_opened");
  if(isDefined(self.var_8301)) {
    foreach(var_02 in self.var_8301) {
      var_02 hudoutlinedisable();
    }
  }
}

func_3279() {
  self endon("flag_exit_door_opened");
  var_00 = getent("trig_near_door", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(!isPlayer(var_01)) {
      continue;
    }

    if(var_01.var_62D6 < self.var_267B && !common_scripts\utility::func_3C77("flag_exit_door_opened")) {
      thread func_2EAB();
      common_scripts\utility::func_3C8F("flag_exit_door_seen");
      break;
    }

    wait(0.1);
  }
}

func_326E() {
  level endon("field_to_yard");
  var_00 = getent("trig_near_yard_door", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(!isPlayer(var_01)) {
      continue;
    } else {
      lib_0555::func_83DD("training_door", var_01);
      break;
    }

    wait(0.1);
  }
}

func_9C4C() {
  if(getdvarint("scr_zombieCheckpoint", 0) == 0) {
    self setclientomnvar("ui_hide_hud", 1);
    thread func_A002(self, 0.25, 1, 1, 0);
  }

  if(lib_0547::func_5767(self) && isPlayer(self)) {
    lib_0586::func_078F();
  }

  player_stripmods();
  lib_0547::func_7454(0);
}

func_9C4E() {
  if(isDefined(level.var_A980)) {
    if(level.var_A980 <= 1) {
      if(common_scripts\utility::func_562E(self.var_56F1) || common_scripts\utility::func_562E(self.var_5750)) {
        if(self.var_00CA) {
          return "walk";
        }

        self.var_6481 = self.var_8065;
        return "run";
      } else {
        if(!isDefined(self.var_8065)) {
          self.var_8065 = randomfloatrange(0, 1);
          self.var_6481 = self.var_8065;
        }

        return "walk";
      }
    }
  }

  return lib_054D::func_AC6E();
}

func_9C4D() {
  common_scripts\utility::func_3C8F("flag_enable_2nd_floor_spawns");
  if(common_scripts\utility::func_3C77("flag_player_reached_exit")) {
    return;
  }

  switch (level.var_A980) {
    case 2:
      if(level.var_0BCE) {
        common_scripts\utility::func_3C8F("flag_enable_all_1st_floor_spawns");
      }
      break;

    case 3:
      thread func_2EBD(3);
      maps\mp\_utility::func_2CED(5, ::lib_0555::func_83DD, "training_rounds", self);
      if(!level.var_0BCE) {
        common_scripts\utility::func_3C8F("flag_enable_all_1st_floor_spawns");
      }
      break;

    case 4:
      thread func_2EBD(4);
      break;

    case 7:
      break;

    case 10:
      level notify("challenge_kill_highlights");
      var_00 = func_325F();
      if(isDefined(var_00.var_8301)) {
        foreach(var_02 in var_00.var_8301) {
          var_02 hudoutlinedisableforclient(level.var_721C);
        }
      }
      break;

    case 20:
      maps\mp\gametypes\zombies::func_47A8("ZM_TRAINING_20");
      break;
  }
}

func_9C49(param_00) {
  return 0;
}

func_9C4A(param_00, param_01, param_02) {
  waittillframeend;
}

func_9C4B(param_00) {
  param_00 = 2;
  lib_0547::func_4780(param_00);
}

func_74EC(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  common_scripts\utility::func_0603();
  common_scripts\utility::func_0600();
  maps\mp\_utility::func_3E8E(1);
  lib_0586::func_078C(param_00);
  wait(0.25);
  if(param_02) {
    lib_0586::func_078E(param_00, 1);
  } else {
    lib_0586::func_078E(param_00);
  }

  wait(param_01);
  lib_0586::func_078E(lib_0547::func_AB2B());
  common_scripts\utility::func_0617();
  common_scripts\utility::func_0614();
  if(self hasweapon(param_00)) {
    lib_0586::func_0790(param_00);
  }

  maps\mp\_utility::func_3E8E(0);
}

func_5CA4(param_00) {
  var_01 = self getangles();
  var_02 = 0;
  while(var_02 <= 1) {
    var_03 = func_3886(var_01, param_00, var_02);
    self setangles(var_03);
    var_02 = var_02 + 0.1;
    wait 0.05;
  }
}

func_0DD1(param_00, param_01, param_02) {
  return angleclamp360(param_00 + angleclamp180(param_01 - param_00) * param_02);
}

func_3886(param_00, param_01, param_02) {
  return (func_0DD1(param_00[0], param_01[0], param_02), func_0DD1(param_00[1], param_01[1], param_02), func_0DD1(param_00[2], param_01[2], param_02));
}

func_4205(param_00) {
  if(isDefined(self.var_5ED1)) {
    var_01 = self.var_5ED1 - param_00 getEye();
  } else {
    var_01 = self.var_0116 - var_01 getEye();
  }

  var_02 = vectornormalize((var_01[0], var_01[1], 0));
  var_03 = anglesToForward(param_00.var_001D);
  var_04 = vectornormalize((var_03[0], var_03[1], 0));
  var_05 = vectordot(var_02, var_04);
  var_05 = clamp(var_05, -1, 1);
  var_06 = acos(var_05);
  return var_06;
}

func_55DC(param_00) {
  var_01 = param_00 < 45;
  return var_01;
}

func_55E2(param_00) {
  var_01 = func_4205(param_00);
  var_02 = func_55DC(var_01);
  return var_02;
}