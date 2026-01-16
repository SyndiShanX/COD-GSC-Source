/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_loadout.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include animscripts\assign_weapon;

init_loadout() {
  if(!isDefined(level.player_loadout)) {
    level.player_loadout = [];
    level.player_loadout_options = [];
    level.player_loadout_slots = [];
  }

  if(!isDefined(level.player_perks))
    level.player_perks = [];

  animscripts\assign_weapon::assign_weapon_init();
  init_models_and_variables_loadout();
  players = get_players("all");

  for(i = 0; i < players.size; i++) {
    players[i] give_loadout();
    players[i].pers["class"] = "closequarters";
  }

  level.loadoutcomplete = 1;
  level notify("loadout complete");
}

init_melee_weapon() {
  if(level.script == "frontend") {
  } else if(level.script == "angola" || level.script == "angola_2")
    add_weapon("machete_sp");
  else
    add_weapon("knife_sp");
}

init_loadout_weapons() {
  init_melee_weapon();

  if(level.script == "m202_sound_test") {
    add_weapon("rpg_player_sp");
    add_weapon("m202_flash_sp");
    add_weapon("strela_sp");
    add_weapon("m220_tow_sp");
    add_weapon("china_lake_sp");
    set_laststand_pistol("m1911_sp");
    set_switch_weapon("rpg_player_sp");
    return;
  } else if(getsubstr(level.script, 0, 6) == "sp_t5_") {
    add_weapon("m16_sp");
    add_weapon("m1911_sp");
    set_switch_weapon("m16_sp");
    set_laststand_pistol("m1911_sp");
    set_switch_weapon("m16_sp");
    return;
  } else if(getsubstr(level.script, 0, 6) == "sp_t6_") {
  } else if(level.script == "frontend") {
    set_laststand_pistol("none");
    return;
  } else if(level.script == "outro") {
    set_laststand_pistol("none");
    return;
  } else if(issubstr(level.script, "intro_"))
    return;
  else if(gamemodeismode(level.gamemode_rts) || issubstr(level.script, "so_rts")) {
    precacheitem("frag_grenade_sp");
    return;
  }

  primary = getloadoutweapon("primary");
  secondary = getloadoutweapon("secondary");
  grenade = getloadoutitem("primarygrenade");
  specialgrenade = getloadoutitem("specialGrenade");
  primaryweaponoptions = getloadoutitemindex("primarycamo");
  secondaryweaponoptions = getloadoutitemindex("secondarycamo");

  for(i = 1; i <= 12; i++) {
    perk = getloadoutitem("specialty" + i);
    add_perk(perk);
  }

  add_weapon(primary, primaryweaponoptions);
  add_weapon(secondary, secondaryweaponoptions);
  add_weapon(grenade, undefined, "primarygrenade");
  add_weapon(specialgrenade, undefined, "specialgrenade");

  println("GiveWeapon( " + primary + " ) -- primary weapon");

  println("GiveWeapon( " + secondary + " ) -- secondary weapon");

  println("GiveWeapon( " + grenade + " ) -- primary grenade");

  println("GiveWeapon( " + specialgrenade + " ) -- secondary grenade");

  if(primary != "weapon_null_sp")
    set_switch_weapon(primary);
  else if(secondary != "weapon_null_sp")
    set_switch_weapon(secondary);

  precacheitem("frag_grenade_sp");
}

init_viewmodels_and_campaign() {
  if(level.script == "la_1") {
    set_player_viewmodel("c_usa_cia_masonjr_armlaunch_viewhands");
    set_player_interactive_model("c_usa_cia_masonjr_armlaunch_viewbody");
    level.campaign = "american";
    return;
  } else if(level.script == "la_1b") {
    set_player_viewmodel("c_usa_cia_masonjr_armlaunch_viewhands");
    set_player_interactive_model("c_usa_cia_masonjr_armlaunch_viewbody");
    level.campaign = "american";
    return;
  } else if(level.script == "la_2") {
    set_player_viewmodel("c_usa_cia_masonjr_armlaunch_viewhands");
    set_player_interactive_model("c_usa_cia_masonjr_armlaunch_viewbody");
    level.campaign = "american";
    return;
  }

  if(level.script == "blackout") {
    set_player_viewmodel("c_usa_cia_masonjr_armlaunch_viewhands");
    set_player_interactive_hands("c_usa_cia_masonjr_armlaunch_viewbody");
    set_player_interactive_model("c_usa_cia_masonjr_armlaunch_viewbody");
    level.campaign = "american";
    return;
  } else if(level.script == "angola" || level.script == "angola_2") {
    set_player_viewmodel("c_usa_seal80s_mason_viewhands");
    set_player_interactive_hands("c_usa_seal80s_mason_viewbody");
    set_player_interactive_model("c_usa_seal80s_mason_viewbody");
    level.campaign = "american";
    return;
  } else if(level.script == "monsoon") {
    set_player_viewmodel("c_usa_seal6_monsoon_armlaunch_viewhands");
    set_player_camo_viewmodel("c_usa_cia_masonjr_viewhands_cl");
    set_player_interactive_hands("c_usa_seal6_monsoon_armlaunch_viewbody");
    set_player_interactive_model("c_usa_seal6_monsoon_armlaunch_viewbody");
    level.campaign = "american";
    return;
  } else if(level.script == "karma" || level.script == "karma_2") {
    set_player_viewmodel("c_usa_masonjr_karma_armlaunch_viewhands");
    set_player_interactive_model("c_usa_masonjr_karma_armlaunch_viewbody");
    level.campaign = "american";
    return;
  } else if(level.script == "panama" || level.script == "panama_2" || level.script == "panama_3") {
    set_player_viewmodel("c_usa_woods_panama_viewhands");
    set_player_interactive_hands("c_usa_woods_panama_viewbody");
    set_player_interactive_model("c_usa_woods_panama_viewbody");
    level.campaign = "american";
    return;
  } else if(level.script == "so_cmp_afghanistan") {
    set_player_viewmodel("c_usa_mason_afgan_viewhands");
    set_player_interactive_hands("c_usa_mason_afgan_viewhands");
    set_player_interactive_model("c_usa_mason_afgan_viewbody");
    level.campaign = "american";
    return;
  } else if(level.script == "yemen") {
    set_player_viewmodel("c_mul_yemen_farid_datapad_viewhands");
    set_player_camo_viewmodel("c_mul_yemen_farid_datapad_viewhands_cl");
    set_player_interactive_model("c_mul_yemen_farid_viewbody");
    level.campaign = "american";
    return;
  } else if(level.script == "pakistan" || level.script == "pakistan_2" || level.script == "pakistan_3") {
    set_player_viewmodel("c_usa_cia_masonjr_armlaunch_viewhands");
    set_player_interactive_hands("c_usa_cia_masonjr_armlaunch_viewhands");
    set_player_interactive_model("c_usa_cia_masonjr_armlaunch_viewbody");
    level.campaign = "american";
    return;
  } else if(level.script == "nicaragua") {
    set_player_viewmodel("c_mul_menendez_nicaragua_viewhands");
    set_player_interactive_hands("c_mul_menendez_nicaragua_viewhands");
    set_player_interactive_model("c_mul_menendez_nicaragua_viewbody");
  } else if(level.script == "haiti") {
    set_player_viewmodel("c_usa_cia_masonjr_armlaunch_viewhands");
    set_player_interactive_model("c_usa_seal6_skyfall_armlaunch_viewbody");
    level.campaign = "american";
    return;
  } else if(level.script == "m202_sound_test") {
    set_player_viewmodel("viewmodel_usa_marine_arms");
    set_player_interactive_hands("viewhands_player_usmc");
    level.campaign = "american";
    return;
  } else if(getsubstr(level.script, 0, 6) == "sp_t5_" || getsubstr(level.script, 0, 6) == "sp_t6_") {
    set_player_viewmodel("c_usa_cia_masonjr_armlaunch_viewhands");
    set_player_interactive_model("c_usa_cia_masonjr_armlaunch_viewbody");
    set_player_interactive_hands("c_usa_cia_masonjr_viewhands");
    level.campaign = "american";
    return;
  } else if(level.script == "frontend") {
    set_player_viewmodel("c_usa_cia_masonjr_viewhands");
    set_player_interactive_hands("c_usa_cia_masonjr_viewhands");
    set_player_interactive_model("c_usa_cia_masonjr_viewbody");
    level.campaign = "none";
    return;
  } else if(level.script == "outro") {
    set_laststand_pistol("none");
    level.campaign = "none";
    return;
  } else if(issubstr(level.script, "intro_"))
    return;
  else if(gamemodeismode(level.gamemode_rts)) {
    if(level.script == "so_rts_mp_socotra") {
      set_player_viewmodel("c_usa_seal6_monsoon_armlaunch_viewhands");
      set_player_interactive_hands("c_usa_seal6_monsoon_armlaunch_viewbody");
      set_player_interactive_model("c_usa_seal6_monsoon_armlaunch_viewbody");
    } else {
      set_player_viewmodel("c_usa_cia_masonjr_armlaunch_viewhands");
      set_player_interactive_hands("viewmodel_usa_jungmar_player");
      set_player_interactive_model("c_usa_cia_masonjr_armlaunch_viewbody");
    }

    return;
  }

  set_player_viewmodel("c_usa_cia_masonjr_viewhands");
  set_player_interactive_hands("viewmodel_usa_jungmar_player");
  set_player_interactive_model("c_usa_cia_masonjr_viewbody");
  level.campaign = "american";
}

init_models_and_variables_loadout() {
  init_loadout_weapons();
  init_viewmodels_and_campaign();
}

do_additional_precaching(str_weapon_name) {
  if(str_weapon_name == "titus6_sp") {
    precacheitem("exptitus6_sp");
    precacheitem("titus6_sp");
    precacheitem("titus_explosive_dart_sp");
  }

  if(str_weapon_name == "crossbow_sp" || str_weapon_name == "crossbow80s_sp")
    precacheitem("explosive_bolt_sp");
}

add_weapon(weapon_name, options, slot_instructions) {
  if(!isDefined(weapon_name) || weapon_name == "weapon_null_sp") {
    return;
  }
  precacheitem(weapon_name);
  do_additional_precaching(weapon_name);
  level.player_loadout[level.player_loadout.size] = weapon_name;

  if(!isDefined(options))
    options = -1;

  level.player_loadout_options[level.player_loadout_options.size] = options;

  if(!isDefined(slot_instructions))
    slot_instructions = "";

  level.player_loadout_slots[level.player_loadout_slots.size] = slot_instructions;
}

add_perk(perk_name) {
  if(!isDefined(perk_name) || perk_name == "weapon_null_sp" || perk_name == "weapon_null" || perk_name == "specialty_null") {
    return;
  }
  perk_specialties = strtok(perk_name, "|");

  for(i = 0; i < perk_specialties.size; i++)
    level.player_perks[level.player_perks.size] = perk_specialties[i];
}

set_secondary_offhand(weapon_name) {
  level.player_secondaryoffhand = weapon_name;
}

set_switch_weapon(weapon_name) {
  level.player_switchweapon = weapon_name;
}

set_action_slot(num, option1, option2) {
  if(num < 2 || num > 4) {
    assertmsg("_loadout.gsc: set_action_slot must be set with a number greater than 1 and less than 5");

  }

  if(isDefined(option1)) {
    if(option1 == "weapon") {
      precacheitem(option2);
      level.player_loadout[level.player_loadout.size] = option2;
    }
  }

  if(!isDefined(level.player_actionslots))
    level.player_actionslots = [];

  action_slot = spawnstruct();
  action_slot.num = num;
  action_slot.option1 = option1;

  if(isDefined(option2))
    action_slot.option2 = option2;

  level.player_actionslots[level.player_actionslots.size] = action_slot;
}

set_player_viewmodel(model) {
  precachemodel(model);
  level.player_viewmodel = model;
}

set_player_camo_viewmodel(model) {
  precachemodel(model);
  level.player_camo_viewmodel = model;
}

set_player_interactive_hands(model) {
  precachemodel(model);
  level.player_interactive_hands = model;
}

set_player_interactive_model(model) {
  precachemodel(model);
  level.player_interactive_model = model;
}

set_laststand_pistol(weapon) {
  level.laststandpistol = weapon;
}

give_loadout(wait_for_switch_weapon) {
  if(!isDefined(game["gaveweapons"]))
    game["gaveweapons"] = 0;

  if(!isDefined(game["expectedlevel"]))
    game["expectedlevel"] = "";

  if(game["expectedlevel"] != level.script)
    game["gaveweapons"] = 0;

  if(game["gaveweapons"] == 0)
    game["gaveweapons"] = 1;

  gave_grenade = 0;

  for(i = 0; i < level.player_loadout.size; i++) {
    if(weapontype(level.player_loadout[i]) == "grenade") {
      gave_grenade = 1;
      break;
    }
  }

  if(!gave_grenade) {
    if(isDefined(level.player_grenade))
      grenade = level.player_grenade;
    else
      grenade = "frag_grenade_sp";

    self giveweapon(grenade);
    self setweaponammoclip(grenade, 0);
    self setweaponammostock(grenade, 0);
    gave_grenade = 1;
  }

  bmaxammo = 0;

  if(!array_check_for_dupes(level.player_perks, "specialty_extraammo"))
    bmaxammo = 1;

  for(i = 0; i < level.player_loadout.size; i++) {
    if(isDefined(level.player_loadout_options[i]) && level.player_loadout_options[i] != -1) {
      weaponoptions = self calcweaponoptions(level.player_loadout_options[i]);
      self giveweapon(level.player_loadout[i], 0, weaponoptions);
    } else
      self giveweapon(level.player_loadout[i]);

    if(isDefined(level.player_loadout_slots[i]) && level.player_loadout_slots[i] != "") {
      if(level.player_loadout_slots[i] == "primarygrenade") {
        self switchtooffhand(level.player_loadout[i]);
        self setoffhandprimaryclass(level.player_loadout[i]);
      } else if(level.player_loadout_slots[i] == "specialgrenade") {
        self switchtooffhand(level.player_loadout[i]);
        self setoffhandsecondaryclass(level.player_loadout[i]);
      }
    }

    if(bmaxammo)
      self givemaxammo(level.player_loadout[i]);
  }

  for(i = 0; i < level.player_perks.size; i++)
    self setperk(level.player_perks[i]);

  self setactionslot(1, "");
  self setactionslot(2, "");
  self setactionslot(3, "altMode");
  self setactionslot(4, "");

  if(isDefined(level.player_actionslots)) {
    for(i = 0; i < level.player_actionslots.size; i++) {
      num = level.player_actionslots[i].num;
      option1 = level.player_actionslots[i].option1;

      if(isDefined(level.player_actionslots[i].option2)) {
        option2 = level.player_actionslots[i].option2;
        self setactionslot(num, option1, option2);
        continue;
      }

      self setactionslot(num, option1);
    }
  }

  if(isDefined(level.player_switchweapon)) {
    if(isDefined(wait_for_switch_weapon) && wait_for_switch_weapon == 1)
      wait 0.5;

    self setspawnweapon(level.player_switchweapon);
    self switchtoweapon(level.player_switchweapon);
  }

  wait 0.5;
  self player_flag_set("loadout_given");
}

give_model() {
  entity_num = self getentitynumber();

  if(level.campaign == "none") {
  }

  if(isDefined(level.player_viewmodel))
    self setviewmodel(level.player_viewmodel);
}