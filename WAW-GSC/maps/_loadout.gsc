/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_loadout.gsc
**************************************/

#include maps\_utility;

init_loadout() {
  if(!isDefined(level.player_loadout)) {
    level.player_loadout = [];
  }

  init_models_and_variables_loadout();

  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] give_loadout();
    players[i].pers["class"] = "closequarters";
  }
  level.loadoutComplete = true;
  level notify("loadout complete");

  if(level.campaign == "russian") {
    if(level.script == "ber2") {
      mptype\player_rus_guard_wet::precache();
    } else if(level.script == "sniper") {} else {
      mptype\player_rus_guard::precache();
    }
  } else if(level.campaign == "american") {
    if(level.script == "pel1") {
      mptype\player_usa_marine::precache();
    } else if(level.script == "pel1a" || level.script == "pel2") {
      mptype\player_usa_marine::precache();
    } else if(level.script == "oki2") {
      mptype\player_usa_marine_wet::precache();
    } else if(level.script == "mak") {
      mptype\player_usa_raider::precache();
    } else if(level.script == "pby_fly") {} else if(level.script == "nazi_zombie_sumpf" || level.script == "nazi_zombie_asylum" || level.script == "nazi_zombie_factory") {
      mptype\nazi_zombie_heroes::precache();
    } else {
      mptype\player_usa_marine::precache();
    }
  } else {
    mptype\player_usa_marine::precache();
  }
}

init_models_and_variables_loadout() {
  if(level.script == "coop_test1") {
    add_weapon("m1garand");
    add_weapon("thompson");
    add_weapon("fraggrenade");
    set_switch_weapon("m1garand");

    set_player_viewmodel("viewmodel_usa_marine_arms");

    level.campaign = "american";
    return;
  } else if(level.script == "mak") {
    add_weapon("nambu");
    set_switch_weapon("nambu");
    set_laststand_pistol("nambu");

    set_player_viewmodel("viewmodel_usa_raider_arms");
    set_player_interactive_hands("viewmodel_usa_raider_player");

    level.campaign = "american";
    return;
  } else if(level.script == "pel1") {
    add_weapon("colt");
    add_weapon("m1garand_bayonet");
    add_weapon("fraggrenade");
    add_weapon("m8_white_smoke");
    add_weapon("rocket_barrage");
    set_action_slot(4, "weapon", "rocket_barrage");
    set_secondary_offhand("smoke");

    set_laststand_pistol("colt");

    set_player_viewmodel("viewmodel_usa_marine_arms");
    set_player_interactive_hands("viewmodel_usa_marine_player");

    set_switch_weapon("m1garand_bayonet");

    level.campaign = "american";
    return;
  } else if(level.script == "pel1a") {
    add_weapon("m1garand");
    PrecacheItem("m2_flamethrower");

    add_weapon("thompson");

    add_weapon("fraggrenade");
    add_weapon("m8_white_smoke");
    set_secondary_offhand("smoke");

    set_switch_weapon("m1garand");

    set_laststand_pistol("colt");

    set_player_viewmodel("viewmodel_usa_marine_arms");
    set_player_interactive_hands("viewmodel_usa_marine_player");

    level.campaign = "american";
    return;
  } else if(level.script == "pel1b") {
    add_weapon("shotgun");
    add_weapon("30cal_bipod");

    add_weapon("fraggrenade");
    add_weapon("m8_white_smoke");
    set_secondary_offhand("smoke");
    set_switch_weapon("30cal_bipod");

    set_laststand_pistol("colt");

    set_player_viewmodel("viewmodel_usa_marine_arms");
    set_player_interactive_hands("viewmodel_usa_marine_player");

    level.campaign = "american";
    return;
  } else if(level.script == "pby_fly") {
    set_laststand_pistol("colt");

    set_player_viewmodel("viewmodel_usa_pbycrew_arms");

    level.campaign = "american";
    return;
  } else if(level.script == "pel2") {
    add_weapon("colt");

    add_weapon("bar");
    add_weapon("fraggrenade");
    add_weapon("m8_white_smoke");
    set_secondary_offhand("smoke");

    set_switch_weapon("bar");

    set_laststand_pistol("colt");

    set_player_viewmodel("viewmodel_usa_marine_arms");
    set_player_interactive_hands("viewmodel_usa_marine_player");

    level.campaign = "american";
    return;
  } else if(level.script == "see1") {
    add_weapon("mosin_rifle");
    add_weapon("tokarev");

    add_weapon("stick_grenade");
    add_weapon("molotov");
    PrecacheItem("napalmblob");
    PrecacheItem("napalmbloblight");
    set_secondary_offhand("smoke");
    set_switch_weapon("mosin_rifle");

    set_laststand_pistol("tokarev");

    set_player_viewmodel("viewmodel_rus_guard_arms");

    level.campaign = "russian";
    return;
  } else if(level.script == "see2") {
    add_weapon("m2_flamethrower");
    add_weapon("ppsh");
    add_weapon("stick_grenade");
    set_secondary_offhand("smoke");
    set_switch_weapon("m2_flamethrower");

    set_laststand_pistol("none");

    level.campaign = "russian";
    return;
  } else if(level.script == "ber1") {
    add_weapon("tokarev");
    add_weapon("mosin_rifle");
    add_weapon("stick_grenade");

    add_weapon("molotov");
    set_secondary_offhand("molotov");
    set_switch_weapon("mosin_rifle");

    set_laststand_pistol("tokarev");

    set_player_viewmodel("viewmodel_rus_guard_arms");

    level.campaign = "russian";
    return;
  } else if(level.script == "ber1_geo") {
    add_weapon("mosin_rifle");
    add_weapon("ppsh");
    add_weapon("stick_grenade");
    add_weapon("molotov");
    set_secondary_offhand("smoke");
    set_switch_weapon("mosin_rifle");

    set_laststand_pistol("tokarev");

    set_player_viewmodel("viewmodel_rus_guard_arms");

    level.campaign = "russian";
    return;
  } else if(level.script == "ber2") {
    add_weapon("ppsh");
    add_weapon("tokarev");

    add_weapon("stick_grenade");
    add_weapon("molotov");
    set_secondary_offhand("smoke");
    set_switch_weapon("ppsh");

    set_laststand_pistol("tokarev");

    set_player_viewmodel("viewmodel_rus_guard_arms");

    level.campaign = "russian";
    return;
  } else if(level.script == "sniper") {
    add_weapon("mosin_rifle_scoped");
    add_weapon("stick_grenade");
    set_switch_weapon("mosin_rifle_scoped");

    set_laststand_pistol("tokarev");

    set_player_viewmodel("viewmodel_rus_guard_arms");
    set_player_interactive_hands("viewmodel_rus_guard_player");

    level.campaign = "russian";
    return;
  } else if(level.script == "ber3") {
    add_weapon("svt40");
    add_weapon("ppsh");

    add_weapon("stick_grenade");
    add_weapon("molotov");
    PrecacheItem("napalmblob");
    PrecacheItem("napalmbloblight");
    set_secondary_offhand("smoke");
    set_switch_weapon("ppsh");

    set_laststand_pistol("tokarev");

    set_player_viewmodel("viewmodel_rus_guard_arms");
    level.campaign = "russian";
    return;
  } else if(level.script == "ber3b") {
    add_weapon("tokarev");
    add_weapon("svt40");

    add_weapon("stick_grenade");
    add_weapon("molotov");
    set_secondary_offhand("smoke");
    set_switch_weapon("svt40");

    set_laststand_pistol("tokarev");

    set_player_viewmodel("viewmodel_rus_guard_arms");

    level.campaign = "russian";
    return;
  } else if(level.script == "oki2") {
    add_weapon("30cal_wet");

    PrecacheItem("m2_flamethrower_wet");
    add_weapon("thompson_wet");
    add_weapon("fraggrenade");
    add_weapon("m8_white_smoke");

    set_secondary_offhand("smoke");

    set_switch_weapon("thompson_wet");

    set_laststand_pistol("colt_wet");

    set_player_viewmodel("viewmodel_usa_marinewet_rolledup_arms");
    set_player_interactive_hands("viewmodel_usa_marinewet_rolledup_player");

    level.campaign = "american";
    return;
  } else if(level.script == "prologue") {
    add_weapon("m1garand");
    add_weapon("colt");
    set_switch_weapon("colt");

    set_laststand_pistol("colt");

    set_player_viewmodel("viewmodel_usa_marine_arms");

    level.campaign = "american";
    return;
  } else if(level.script == "oki3") {
    add_weapon("m1garand");
    add_weapon("thompson");
    add_weapon("fraggrenade");
    add_weapon("m8_white_smoke");
    add_weapon("air_support");
    set_action_slot(4, "weapon", "air_support");
    set_secondary_offhand("smoke");
    set_switch_weapon("m1garand");
    set_laststand_pistol("colt");

    set_player_viewmodel("viewmodel_usa_marine_arms");
    set_player_interactive_hands("viewmodel_usa_marine_player");

    level.campaign = "american";
    return;
  } else if(level.script == "living_battlefield") {
    add_weapon("m1garand_bayonet");
    add_weapon("thompson");
    add_weapon("molotov");
    PrecacheItem("napalmblob");
    PrecacheItem("napalmbloblight");
    add_weapon("fraggrenade");
    set_secondary_offhand("flash");
    set_switch_weapon("m1garand_bayonet");

    set_laststand_pistol("colt");

    set_player_viewmodel("viewmodel_usa_marine_arms");

    level.campaign = "american";
    return;
  } else if(getDvar("zombiemode") == "1" || IsSubStr(level.script, "nazi_zombie_")) {
    add_weapon("zombie_colt");
    PrecacheItem("napalmblob");
    PrecacheItem("napalmbloblight");
    set_switch_weapon("zombie_colt");

    set_laststand_pistol("zombie_colt");

    set_player_viewmodel("viewmodel_usa_marine_arms");
    set_player_interactive_hands("viewmodel_usa_marine_player");

    level.campaign = "american";
    return;
  } else if(IsSubStr(level.script, "intro_")) {
    return;
  } else if(level.script == "credits") {
    set_player_viewmodel("viewmodel_usa_marine_arms");
    set_player_interactive_hands("viewmodel_usa_marine_player");
    level.campaign = "american";
    return;
  }

  println("loadout.gsc: No level listing in _loadout.gsc, giving default guns!!!! =======================");

  add_weapon("colt");
  add_weapon("m1garand");
  add_weapon("fraggrenade");
  add_weapon("m8_white_smoke");
  set_secondary_offhand("smoke");

  set_laststand_pistol("colt");
  set_switch_weapon("m1garand");

  if(isDefined(level.campaign) && level.campaign == "russian") {
    set_player_viewmodel("viewmodel_rus_guard_arms");
  } else {
    set_player_viewmodel("viewmodel_usa_marine_arms");
    level.campaign = "american";
  }
}
add_weapon(weapon_name) {
  PrecacheItem(weapon_name);
  level.player_loadout[level.player_loadout.size] = weapon_name;
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
set_player_viewmodel(viewmodel) {
  PrecacheModel(viewmodel);
  level.player_viewmodel = viewmodel;
}
set_player_interactive_hands(model) {
  level.player_interactive_hands = model;
  PrecacheModel(level.player_interactive_hands);
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
    self GiveWeapon(level.player_loadout[i]);
  }

  self SetActionSlot(1, "");
  self SetActionSlot(2, "");
  self SetActionSlot(3, "altMode");
  self SetActionSlot(4, "");

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

  wait(0.5);

  self player_flag_set("loadout_given");
}

give_model(class) {
  if(level.campaign == "russian") {
    if(level.script == "ber2") {
      self mptype\player_rus_guard_wet::main();
    } else if(level.script == "sniper") {} else {
      self mptype\player_rus_guard::main();
    }
  } else if(level.campaign == "american") {
    if(level.script == "pel1") {
      self mptype\player_usa_marine::main();
    } else if(level.script == "pel1a" || level.script == "pel2") {
      self mptype\player_usa_marine::main();
    } else if(level.script == "oki2") {
      self mptype\player_usa_marine_wet::main();
    } else if(level.script == "mak") {
      self mptype\player_usa_raider::main();
    } else if(level.script == "pby_fly") {} else if(level.script == "nazi_zombie_sumpf" || level.script == "nazi_zombie_asylum" || level.script == "nazi_zombie_factory") {
      switch (self.entity_num) {
        case 0:
          character\char_zomb_player_0::main();
          break;
        case 1:
          character\char_zomb_player_1::main();
          break;
        case 2:
          character\char_zomb_player_2::main();
          break;
        case 3:
          character\char_zomb_player_3::main();
          break;
      }
    } else {
      self mptype\player_usa_marine::main();
    }
  } else {
    self mptype\player_usa_marine::main();
  }

  if(isDefined(level.player_viewmodel)) {
    self SetViewModel(level.player_viewmodel);
  }
}

SavePlayerWeaponStatePersistent(slot) {
  current = level.player getCurrentWeapon();
  if((!isDefined(current)) || (current == "none")) {
    assertmsg("Player's current weapon is 'none' or undefined. Make sure 'disableWeapons()' has not been called on the player when trying to save weapon states.");
  }
  game["weaponstates"][slot]["current"] = current;

  offhand = level.player getcurrentoffhand();
  game["weaponstates"][slot]["offhand"] = offhand;

  game["weaponstates"][slot]["list"] = [];
  weapList = level.player GetWeaponsList();
  for(weapIdx = 0; weapIdx < weapList.size; weapIdx++) {
    game["weaponstates"][slot]["list"][weapIdx]["name"] = weapList[weapIdx];
  }
}

RestorePlayerWeaponStatePersistent(slot) {
  if(!isDefined(game["weaponstates"])) {
    return false;
  }
  if(!isDefined(game["weaponstates"][slot])) {
    return false;
  }

  level.player takeallweapons();

  for(weapIdx = 0; weapIdx < game["weaponstates"][slot]["list"].size; weapIdx++) {
    weapName = game["weaponstates"][slot]["list"][weapIdx]["name"];

    if(isDefined(level.legit_weapons)) {
      if(!isDefined(level.legit_weapons[weapName])) {
        continue;
      }
    }

    if(weapName == "c4") {
      continue;
    }
    if(weapName == "claymore") {
      continue;
    }
    level.player GiveWeapon(weapName);
    level.player GiveMaxAmmo(weapName);
  }

  if(isDefined(level.legit_weapons)) {
    weapname = game["weaponstates"][slot]["offhand"];
    if(isDefined(level.legit_weapons[weapName])) {
      level.player switchtooffhand(weapname);
    }

    weapname = game["weaponstates"][slot]["current"];
    if(isDefined(level.legit_weapons[weapName])) {
      level.player SwitchToWeapon(weapname);
    }
  } else {
    level.player switchtooffhand(game["weaponstates"][slot]["offhand"]);
    level.player SwitchToWeapon(game["weaponstates"][slot]["current"]);
  }

  return true;
}