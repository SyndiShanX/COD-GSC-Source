/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_loadout.gsc
**************************************/

#include maps\_utility;

init_loadout() {
  if(!isDefined(level.player_loadout)) {
    level.player_loadout = [];
    level.player_loadout_options = [];
  }
  init_models_and_variables_loadout();
  players = get_players("all");
  for(i = 0; i < players.size; i++) {
    players[i] give_loadout();
    players[i].pers["class"] = "closequarters";
  }
  level.loadoutComplete = true;
  level notify("loadout complete");
  if(getDvar(#"zombietron") == "1") {
    mptype\player_t5_zt::precache();
  } else if(getDvar(#"zombiemode") == "1" || IsSubStr(level.script, "nazi_zombie_") || IsSubStr(level.script, "zombie_")) {
    if(IsSubStr(level.script, "zombie_pentagon")) {
      mptype\player_t5_zm_pentagon::precache();
    } else if(IsSubStr(level.script, "zombie_theater")) {
      mptype\player_t5_zm_theater::precache();
    } else {
      mptype\player_t5_zm::precache();
    }
  }
}
init_models_and_variables_loadout() {
  if(getDvar(#"zombiemode") == "1") {
    if(!isDefined(level.zombietron_mode)) {
      add_weapon("knife_zm");
    }
  } else {
    if(level.script == "frontend" || level.script == "so_narrative1_frontend" || level.script == "so_narrative2_frontend" || level.script == "so_narrative3_frontend" || level.script == "so_narrative4_frontend" || level.script == "so_narrative5_frontend" || level.script == "so_narrative6_frontend" || level.script == "so_narrative0_frontend" || level.script == "outro") {} else if(level.script == "flashpoint") {
      add_weapon("knife_karambit_sp");
    } else {
      add_weapon("knife_sp");
    }
  }
  if(level.script == "coop_test1") {
    add_weapon("m1garand");
    add_weapon("thompson");
    add_weapon("frag_grenade");
    set_switch_weapon("m1garand");
    set_player_viewmodel("viewmodel_usa_marine_arms");
    set_player_interactive_hands("viewhands_player_usmc");
    level.campaign = "american";
    return;
  }
  if(level.script == "m202_sound_test") {
    add_weapon("rpg_player_sp");
    add_weapon("m202_flash_sp");
    add_weapon("strela_sp");
    add_weapon("m220_tow_sp");
    add_weapon("china_lake_sp");
    set_laststand_pistol("m1911_sp");
    set_switch_weapon("rpg_player_sp");
    set_player_viewmodel("viewmodel_usa_marine_arms");
    set_player_interactive_hands("viewhands_player_usmc");
    level.campaign = "american";
    return;
  } else if(GetSubStr(level.script, 0, 6) == "sp_t5_") {
    add_weapon("m16_sp");
    add_weapon("m1911_sp");
    set_switch_weapon("m16_sp");
    set_laststand_pistol("m1911_sp");
    set_switch_weapon("m16_sp");
    set_player_viewmodel("viewmodel_usa_cia_camo_arms");
    set_player_interactive_hands("viewmodel_usa_cia_camo_arms");
    level.campaign = "american";
    return;
  } else if(level.script == "berlin") {
    add_weapon("frag_grenade_sp");
    add_weapon("m1911_silencer_sp");
    set_switch_weapon("m1911_silencer_sp");
    set_laststand_pistol("m1911_silencer_sp");
    set_player_viewmodel("viewmodel_usa_jungmar_arms");
    set_player_interactive_hands("viewmodel_usa_jungmar_player");
    set_player_interactive_model("viewmodel_usa_jungmar_player_fullbody");
    level.campaign = "american";
    return;
  } else if(level.script == "cuba") {
    add_weapon("frag_grenade_sp");
    add_weapon("asp_sp");
    PreCacheItem("m16_sp");
    PreCacheItem("m16_acog_sp");
    PreCacheItem("m16_gl_sp");
    PreCacheItem("gl_m16_sp");
    add_weapon("m16_acog_gl_sp");
    set_switch_weapon("m16_acog_gl_sp");
    set_laststand_pistol("asp_sp");
    set_player_viewmodel("viewmodel_usa_cuban_casual_arms");
    set_player_interactive_hands("viewmodel_usa_cuban_casual_player");
    set_player_interactive_model("viewmodel_usa_cuban_casual_fullbody");
    level.campaign = "american";
    return;
  } else if(level.script == "frontend" || level.script == "so_narrative1_frontend" || level.script == "so_narrative2_frontend" || level.script == "so_narrative3_frontend" || level.script == "so_narrative4_frontend" || level.script == "so_narrative5_frontend" || level.script == "so_narrative6_frontend" || level.script == "so_narrative0_frontend") {
    set_laststand_pistol("none");
    set_player_viewmodel("tag_origin");
    set_player_interactive_hands("tag_origin");
    set_player_interactive_model("viewmodel_usa_mason_interrogation_fullbody");
    level.campaign = "none";
    return;
  } else if(level.script == "outro") {
    set_laststand_pistol("none");
    level.campaign = "none";
    return;
  } else if(level.script == "int_escape") {
    add_weapon("interrogation_hands_sp");
    set_switch_weapon("interrogation_hands_sp");
    set_player_viewmodel("viewmodel_usa_mason_interrogation_arms");
    set_player_interactive_hands("viewmodel_usa_mason_interrogation_player");
    set_player_interactive_model("viewmodel_usa_mason_interrogation_fullbody");
    level.campaign = "american";
    return;
  } else if(level.script == "creek_1") {
    precacheitem("creek_flashlight_pistol_sp");
    add_weapon("commando_gl_sp");
    add_weapon("wa2000_sp");
    set_laststand_pistol("m1911_sp");
    set_switch_weapon("commando_gl_sp");
    set_player_viewmodel("viewmodel_usa_jungmar_wet_arms");
    set_player_interactive_hands("viewmodel_usa_jungmar_wet_player");
    set_player_interactive_model("viewmodel_usa_jungmar_wet_player_fullbody");
    level.campaign = "american";
    return;
  } else if(level.script == "river") {
    add_weapon("commando_acog_sp", 13);
    add_weapon("ks23_sp", 13);
    add_weapon("frag_grenade_sp");
    add_weapon("flash_grenade_sp");
    set_laststand_pistol("m1911_sp");
    set_switch_weapon("commando_acog_sp");
    set_player_viewmodel("viewmodel_usa_jungmar_wet_arms");
    set_player_interactive_hands("viewmodel_usa_jungmar_wet_player");
    level.campaign = "american";
    return;
  } else if(level.script == "in_country") {
    add_weapon("m16_acog_sp");
    add_weapon("m1911_sp");
    set_switch_weapon("m16_acog_sp");
    add_weapon("frag_grenade_sp");
    set_laststand_pistol("m1911_sp");
    set_switch_weapon("m16_acog_sp");
    set_player_viewmodel("viewmodel_usa_jungmar_arms");
    set_player_interactive_model("viewmodel_usa_jungmar_player_fullbody");
    level.campaign = "american";
    return;
  } else if(level.script == "flashpoint") {
    add_weapon("mp5k_elbit_extclip_sp", 1);
    add_weapon("python_speed_sp");
    set_laststand_pistol("makarov_sp");
    set_switch_weapon("mp5k_elbit_extclip_sp");
    add_weapon("frag_grenade_sp");
    add_weapon("willy_pete_sp");
    set_player_viewmodel("viewmodel_usa_blackops_urban_arms");
    set_player_interactive_hands("viewmodel_usa_blackops_urban_player");
    set_player_interactive_model("viewmodel_usa_blackops_urban_player_fullbody");
    level.campaign = "american";
    return;
  } else if(level.script == "hue_city") {
    precacheitem("rpg_sp");
    precacheitem("rpk_sp");
    precacheitem("commando_sp");
    precacheitem("m1911_sp");
    set_laststand_pistol("m1911_sp");
    add_weapon("frag_grenade_sp");
    set_player_viewmodel("viewmodel_usa_jungmar_arms");
    set_player_interactive_hands("viewmodel_usa_jungmar_player");
    set_player_interactive_model("viewmodel_usa_jungmar_player_fullbody");
    level.campaign = "american";
    return;
  } else if(level.script == "pow") {
    PrecacheItem("ak47_acog_sp");
    PrecacheItem("ak47_dualclip_sp");
    PrecacheItem("ak47_extclip_sp");
    PrecacheItem("ak47_gl_sp");
    PrecacheItem("gl_ak47_sp");
    PrecacheItem("ak47_ft_sp");
    PrecacheItem("ft_ak47_sp");
    PrecacheItem("rpk_sp");
    PrecacheItem("rpk_acog_sp");
    PrecacheItem("rpk_extclip_sp");
    PrecacheItem("galil_sp");
    PrecacheItem("cz75_sp");
    PrecacheItem("cz75_auto_sp");
    PrecacheItem("cz75lh_sp");
    PrecacheItem("cz75dw_sp");
    PrecacheItem("rpg_player_sp");
    PrecacheItem("uzi_sp");
    PrecacheItem("uzi_acog_sp");
    PrecacheItem("uzi_extclip_sp");
    PrecacheItem("uzi_grip_sp");
    add_weapon("cz75_sp");
    add_weapon("ak47_sp");
    add_weapon("frag_grenade_sp");
    add_weapon("flash_grenade_sp");
    set_switch_weapon("ak47_sp");
    set_laststand_pistol("cz75_sp");
    set_player_viewmodel("viewmodel_usa_pow_arms");
    set_player_interactive_hands("viewmodel_usa_pow_player");
    set_player_interactive_model("viewmodel_usa_prisoner_player_fullbody");
    level.campaign = "american";
    return;
  } else if(level.script == "wmd_sr71") {
    add_weapon("aug_arctic_acog_silencer_sp");
    add_weapon("m1911_silencer_sp");
    add_weapon("frag_grenade_sp");
    add_weapon("flash_grenade_sp");
    set_secondary_offhand("flash_grenade_sp");
    set_switch_weapon("aug_arctic_acog_silencer_sp");
    set_laststand_pistol("m1911_silencer_sp");
    set_player_interactive_model("viewmodel_usa_blackops_winter_player_fullbody");
    set_player_interactive_hands("viewhands_player_usmc");
    set_player_viewmodel("viewmodel_usa_blackops_winter_arms");
    level.campaign = "american";
    return;
  } else if(level.script == "wmd") {
    add_weapon("aug_arctic_acog_silencer_sp");
    add_weapon("crossbow_vzoom_alt_sp", 11);
    add_weapon("frag_grenade_sp");
    add_weapon("flash_grenade_sp");
    set_secondary_offhand("flash_grenade_sp");
    set_switch_weapon("crossbow_vzoom_alt_sp");
    set_laststand_pistol("m1911_silencer_sp");
    set_player_interactive_model("viewmodel_usa_blackops_winter_player_fullbody");
    set_player_interactive_hands("viewmodel_usa_blackops_winter_player");
    set_player_viewmodel("viewmodel_usa_blackops_winter_arms");
    level.campaign = "american";
    return;
  } else if(level.script == "khe_sanh") {
    PreCacheItem("m16_sp");
    PreCacheItem("m16_mk_sp");
    PreCacheItem("mk_m16_sp");
    add_weapon("m16_mk_sp", 1);
    add_weapon("m60_sp");
    add_weapon("frag_grenade_sp");
    set_switch_weapon("m16_mk_sp");
    set_laststand_pistol("none");
    set_player_viewmodel("viewmodel_usa_jungmar_arms");
    set_player_interactive_hands("viewmodel_usa_jungmar_player");
    set_player_interactive_model("viewmodel_usa_jungmar_player_fullbody");
    level.campaign = "american";
    return;
  } else if(level.script == "vorkuta") {
    PrecacheItem("makarov_sp");
    PrecacheItem("vorkuta_knife_sp");
    add_weapon("ak47_sp");
    add_weapon("ak47_gl_sp");
    set_switch_weapon("ak47_sp");
    set_laststand_pistol("makarov_sp");
    add_weapon("frag_grenade_sp");
    set_player_viewmodel("viewmodel_rus_prisoner_arms");
    set_player_interactive_hands("viewmodel_rus_prisoner_player_fullbody");
    set_player_interactive_model("viewmodel_rus_prisoner_player_fullbody");
    level.campaign = "russian";
    return;
  } else if(level.script == "pentagon") {
    set_laststand_pistol("m1911_sp");
    set_player_interactive_model("viewmodel_usa_pent_officeworker_fullbody");
    level.campaign = "american";
    return;
  } else if(level.script == "collateral_damage") {
    precacheitem("commando_acog_sp");
    precacheitem("m1911_sp");
    precacheitem("frag_grenade_sp");
    add_weapon("commando_acog_sp");
    add_weapon("m1911_sp");
    add_weapon("frag_grenade_sp");
    set_laststand_pistol("m1911_sp");
    set_switch_weapon("commando_acog_sp");
    set_player_viewmodel("viewmodel_usa_jungmar_arms");
    set_player_interactive_hands("viewmodel_usa_jungmar_player");
    set_player_interactive_model("viewmodel_usa_jungmar_player_fullbody");
    level.campaign = "american";
    return;
  } else if(level.script == "fullahead") {
    add_weapon("ppsh_sp");
    add_weapon("mosin_sp");
    add_weapon("frag_grenade_russian_sp");
    set_laststand_pistol("tokarevtt30_sp");
    set_switch_weapon("ppsh_sp");
    set_player_viewmodel("viewmodel_rus_reznov_winter_arms");
    set_player_interactive_hands("viewmodel_rus_reznov_winter_player");
    set_player_interactive_model("viewmodel_rus_reznov_winter_fullbody");
    level.campaign = "russian";
    return;
  } else if(level.script == "kowloon") {
    add_weapon("cz75dw_sp");
    add_weapon("frag_grenade_sp");
    add_weapon("flash_grenade_sp");
    set_secondary_offhand("flash_grenade_sp");
    set_laststand_pistol("cz75_sp");
    set_switch_weapon("cz75dw_sp");
    set_player_viewmodel("viewmodel_usa_blackops_urban_arms_getwet");
    set_player_interactive_hands("viewmodel_usa_blackops_urban_player_gwet");
    set_player_interactive_model("viewmodel_usa_blackops_urban_player_fullbody_gwet");
    level.campaign = "american";
    return;
  } else if(level.script == "interrogation_escape") {
    add_weapon("m1911_sp");
    add_weapon("m16_sp");
    add_weapon("frag_grenade_sp");
    set_laststand_pistol("m1911_sp");
    set_switch_weapon("m16_sp");
    set_player_viewmodel("viewmodel_usa_pow_arms");
    set_player_interactive_hands("viewhands_player_usmc");
    set_player_interactive_model("viewmodel_usa_marine_player_legs");
    level.campaign = "american";
    return;
  } else if(level.script == "rebirth") {
    add_weapon("frag_grenade_sp");
    set_laststand_pistol("m1911_sp");
    set_player_viewmodel("viewmodel_usa_blackops_urban_arms");
    set_player_interactive_hands("viewmodel_usa_blackops_urban_player");
    set_player_interactive_model("viewmodel_usa_blackops_urban_player_fullbody");
    level.campaign = "american";
    return;
  } else if(level.script == "underwaterbase") {
    add_weapon("mac11_elbit_extclip_sp");
    add_weapon("famas_reflex_dualclip_sp");
    set_laststand_pistol("cz75_sp");
    set_switch_weapon("famas_reflex_dualclip_sp");
    add_weapon("frag_grenade_sp");
    add_weapon("flash_grenade_sp");
    set_secondary_offhand("flash_grenade_sp");
    set_player_viewmodel("viewmodel_usa_ubase_arms");
    set_player_interactive_hands("viewmodel_usa_ubase_player");
    set_player_interactive_model("viewmodel_usa_ubase_fullbody");
    level.campaign = "american";
    return;
  } else if(getDvar(#"zombiemode") == "1" || IsSubStr(level.script, "zombie_")) {
    if(!isDefined(level.zombietron_mode)) {
      add_weapon("knife_zm");
      add_weapon("m1911_zm");
      PrecacheItem("bowie_knife_zm");
      set_laststand_pistol("m1911_zm");
      set_player_viewmodel("viewmodel_usa_pow_arms");
      set_player_interactive_hands("viewhands_usmc");
    }
    level.campaign = "american";
    return;
  } else if(IsSubStr(level.script, "intro_")) {
    return;
  } else if(getDvar(#"g_gametype") == "vs") {
    return;
  }
  println("loadout.gsc: No level listing in _loadout.gsc, giving default guns!!!! =======================");
  add_weapon("m1911_sp");
  add_weapon("m16_sp");
  add_weapon("frag_grenade_sp");
  add_weapon("flash_grenade_sp");
  set_secondary_offhand("flash_grenade_sp");
  set_laststand_pistol("m1911_sp");
  set_switch_weapon("m16_sp");
  set_player_viewmodel("viewmodel_usa_marine_arms");
  set_player_interactive_hands("viewhands_player_usmc");
  set_player_interactive_model("viewmodel_usa_marine_player_legs");
  level.campaign = "american";
}
add_weapon(weapon_name, options) {
  PrecacheItem(weapon_name);
  level.player_loadout[level.player_loadout.size] = weapon_name;
  if(!isDefined(options)) {
    options = -1;
  }
  level.player_loadout_options[level.player_loadout_options.size] = options;
}
set_secondary_offhand(weapon_name) {
  level.player_secondaryoffhand = weapon_name;
}
set_switch_weapon(weapon_name) {
  level.player_switchweapon = weapon_name;
}
set_action_slot(num, option1, option2) {
  if(num < 2 || num > 4) {
    if(level.script != "pby_fly") {
      assertmsg("_loadout.gsc: set_action_slot must be set with a number greater than 1 and less than 5");
    }
  }
  if(isDefined(option1)) {
    if(option1 == "weapon") {
      PrecacheItem(option2);
      level.player_loadout[level.player_loadout.size] = option2;
    }
  }
  if(!isDefined(level.player_actionslots)) {
    level.player_actionslots = [];
  }
  action_slot = spawnStruct();
  action_slot.num = num;
  action_slot.option1 = option1;
  if(isDefined(option2)) {
    action_slot.option2 = option2;
  }
  level.player_actionslots[level.player_actionslots.size] = action_slot;
}
set_player_viewmodel(model) {
  PrecacheModel(model);
  level.player_viewmodel = model;
}
set_player_interactive_hands(model) {
  PrecacheModel(model);
  level.player_interactive_hands = model;
}
set_player_interactive_model(model) {
  PrecacheModel(model);
  level.player_interactive_model = model;
}
set_laststand_pistol(weapon) {
  level.laststandpistol = weapon;
}
give_loadout(wait_for_switch_weapon) {
  if(!isDefined(game["gaveweapons"])) {
    game["gaveweapons"] = 0;
  }
  if(!isDefined(game["expectedlevel"])) {
    game["expectedlevel"] = "";
  }
  if(game["expectedlevel"] != level.script) {
    game["gaveweapons"] = 0;
  }
  if(game["gaveweapons"] == 0) {
    game["gaveweapons"] = 1;
  }
  gave_grenade = false;
  for(i = 0; i < level.player_loadout.size; i++) {
    if(WeaponType(level.player_loadout[i]) == "grenade") {
      gave_grenade = true;
      break;
    }
  }
  if(!gave_grenade) {
    if(isDefined(level.player_grenade)) {
      grenade = level.player_grenade;
      self GiveWeapon(grenade);
      self SetWeaponAmmoStock(grenade, 0);
      gave_grenade = true;
    }
    if(!gave_grenade) {
      ai = GetAiArray("allies");
      if(isDefined(ai)) {
        for(i = 0; i < ai.size; i++) {
          if(isDefined(ai[i].grenadeWeapon)) {
            grenade = ai[i].grenadeWeapon;
            self GiveWeapon(grenade);
            self SetWeaponAmmoStock(grenade, 0);
            break;
          }
        }
      }
      println("^3LOADOUT ISSUE: Unable to give a grenade, the player need to be given a grenade and then take it away in order for the player to throw back grenades, but not have any grenades in his inventory.");
    }
  }
  for(i = 0; i < level.player_loadout.size; i++) {
    if(isDefined(level.player_loadout_options[i]) && (level.player_loadout_options[i] != -1)) {
      weaponOptions = self calcweaponoptions(level.player_loadout_options[i]);
      self GiveWeapon(level.player_loadout[i], 0, weaponOptions);
    } else {
      self GiveWeapon(level.player_loadout[i]);
    }
  }
  self SetActionSlot(1, "");
  self SetActionSlot(2, "");
  self SetActionSlot(3, "altMode");
  self SetActionSlot(4, "");
  if(level.script == "living_battlefield") {
    self SetActionSlot(4, "nightvision");
  }
  if(isDefined(level.player_actionslots)) {
    for(i = 0; i < level.player_actionslots.size; i++) {
      num = level.player_actionslots[i].num;
      option1 = level.player_actionslots[i].option1;
      if(isDefined(level.player_actionslots[i].option2)) {
        option2 = level.player_actionslots[i].option2;
        self SetActionSlot(num, option1, option2);
      } else {
        self SetActionSlot(num, option1);
      }
    }
  }
  if(isDefined(level.player_switchweapon)) {
    if(isDefined(wait_for_switch_weapon) && wait_for_switch_weapon == true) {
      wait(0.5);
    }
    self SwitchToWeapon(level.player_switchweapon);
  }
  if(getDvar(#"zombiemode") == "0") {
    wait(0.5);
  }
  self player_flag_set("loadout_given");
}
give_model(class) {
  entity_num = self GetEntityNumber();
  if(level.campaign == "none") {} else if(getDvar(#"zombietron") == "1") {
    switch (entity_num) {
      case 0:
        character\c_usa_sog2_zt::main();
        break;
      case 1:
        character\c_zom_blue_guy_zt::main();
        break;
      case 2:
        character\c_zom_red_guy_zt::main();
        break;
      case 3:
        character\c_zom_yellow_guy_zt::main();
        break;
    }
  } else if(getDvar(#"zombiemode") == "1" || IsSubStr(level.script, "nazi_zombie_") || IsSubStr(level.script, "zombie_")) {
    if(IsSubStr(level.script, "zombie_pentagon")) {
      if(isDefined(self.zm_random_char)) {
        entity_num = self.zm_random_char;
      }
      switch (entity_num) {
        case 0:
          character\c_usa_jfk_zt::main();
          break;
        case 1:
          character\c_usa_mcnamara_zt::main();
          break;
        case 2:
          character\c_usa_nixon_zt::main();
          break;
        case 3:
          character\c_cub_castro_zt::main();
          break;
      }
    } else if(IsSubStr(level.script, "zombie_theater")) {
      if(isDefined(self.zm_random_char)) {
        entity_num = self.zm_random_char;
      }
      switch (entity_num) {
        case 0:
          character\c_usa_dempsey_zt::main();
          break;
        case 1:
          character\c_rus_nikolai_zt::main();
          break;
        case 2:
          character\c_jap_takeo_zt::main();
          break;
        case 3:
          character\c_ger_richtofen_zt::main();
          break;
      }
    } else {
      switch (entity_num) {
        case 0:
          character\c_usa_marine_michael_carter_player_zm::main();
          break;
        case 1:
          character\c_usa_marine_michael_carter_player_zm::main();
          break;
        case 2:
          character\c_usa_marine_michael_carter_player_zm::main();
          break;
        case 3:
          character\c_usa_marine_michael_carter_player_zm::main();
          break;
      }
    }
  }
  if(isDefined(level.player_viewmodel)) {
    self SetViewModel(level.player_viewmodel);
  }
}